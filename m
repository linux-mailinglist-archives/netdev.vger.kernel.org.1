Return-Path: <netdev+bounces-124104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 080E99680E0
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 09:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A74971F218F7
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 07:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC841836D5;
	Mon,  2 Sep 2024 07:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="oowGHzHb"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE4514900E
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 07:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725263077; cv=none; b=B30/PXguSesrbzbqPdJykKAfNyGEgxQcPr1QdweoA0BnBrJKVhk7ULhoHwM1jCuSuouiCiL1BcdzDqOtxUf2+8Ud9ufrarqoXRrxBVT+PNwvcZ/kx3yfb3gFo7ktu/gHVV4d8sKBB4d5v60R4syI90fU/EXW0/G1glnvrl57tjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725263077; c=relaxed/simple;
	bh=Z5MSN7/WhXgsp2lG/ACzGwyC+EatbB4s76pvC5Mq/HQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOnCPbafT0iJ4cku8xKs1QH6aaENqOFDIE5F1YmsKP3XsWfiYfoLEKo3erGMj7XvjKVBwcrAI6/yZuBJrz+xgb8so2vXLUi3X5MNS300Z4HbZOa5KspeRTSKAdQEMDbSNlETRw19KDtSlblS+sy5aHeq5dqKYkZjjdblefGDG9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=oowGHzHb; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 4FC2F201A1;
	Mon,  2 Sep 2024 09:44:26 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ShyD50PksvsO; Mon,  2 Sep 2024 09:44:25 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 75F6C200BC;
	Mon,  2 Sep 2024 09:44:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 75F6C200BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1725263065;
	bh=yKLYlyE0Ck7dd4o/yu3S6L3VPxGNFKfcE86wj/gvERk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=oowGHzHbGLyhGX+imMrVveGRbGOfvTWkjR23JH7RdAygk3LN0Wwln1UOMipl9WPyR
	 WknuYdGP/kuClUD+jcvywohGgSd6k0gQZkUMP3JWZZOkw5wVpBb26uNyC7WWnD1k+y
	 /BMvXi0RNCLJOnjQQtLfoFOG65ACtwVjh79fKvls4Mo7r39fMHbLhNWHNRVd8DjSfx
	 YLTWwqu9m0v/SdORnF7yk/BIblhfKyVEMCjqzE4uLFgHpFNqemaJKF/JuDbqNvBtWf
	 +SW7Te2hnYpGgN9ciXCgFLFNCey/3hgOY0v48ACdpU265qUyPLqOnrib+MRvi2KD/R
	 n5m1oOslXcd9Q==
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Sep 2024 09:44:25 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 09:44:24 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 6E80E318086C; Mon,  2 Sep 2024 09:44:24 +0200 (CEST)
Date: Mon, 2 Sep 2024 09:44:24 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Feng Wang <wangfe@google.com>, <netdev@vger.kernel.org>,
	<antony.antony@secunet.com>
Subject: Re: [PATCH] xfrm: add SA information to the offloaded packet
Message-ID: <ZtVs2KwxY8VkvoEr@gauss3.secunet.de>
References: <20240822200252.472298-1-wangfe@google.com>
 <Zs62fyjudeEJvJsQ@gauss3.secunet.de>
 <20240831173934.GC4000@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240831173934.GC4000@unreal>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Sorry for the delay. I'm on vacation, so responses will take a bit
longer during the next two weeks.

On Sat, Aug 31, 2024 at 08:39:34PM +0300, Leon Romanovsky wrote:
> On Wed, Aug 28, 2024 at 07:32:47AM +0200, Steffen Klassert wrote:
> > On Thu, Aug 22, 2024 at 01:02:52PM -0700, Feng Wang wrote:
> > > From: wangfe <wangfe@google.com>
> > > 
> > > In packet offload mode, append Security Association (SA) information
> > > to each packet, replicating the crypto offload implementation.
> > > The XFRM_XMIT flag is set to enable packet to be returned immediately
> > > from the validate_xmit_xfrm function, thus aligning with the existing
> > > code path for packet offload mode.
> > > 
> > > This SA info helps HW offload match packets to their correct security
> > > policies. The XFRM interface ID is included, which is crucial in setups
> > > with multiple XFRM interfaces where source/destination addresses alone
> > > can't pinpoint the right policy.
> > > 
> > > Signed-off-by: wangfe <wangfe@google.com>
> > 
> > Applied to ipsec-next, thanks Feng!
> 
> Steffen,
> 
> What is your position on this patch?
> It is the same patch (logically) as the one that was rejected before?
> https://lore.kernel.org/all/ZfpnCIv+8eYd7CpO@gauss3.secunet.de/

This is an infrastructure patch to support routing based IPsec
with xfrm interfaces. I just did not notice it because it was not
mentioned in the commit message of the first patchset. This should have
been included into the packet offload API patchset, but I overlooked
that xfrm interfaces can't work with packet offload mode. The stack
infrastructure should be complete, so that drivers can implement
that without the need to fix the stack before.

In case the patch has issues, we should fix it.

