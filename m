Return-Path: <netdev+bounces-126523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE064971AA7
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 15:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D92671C22A8C
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 13:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E381B7908;
	Mon,  9 Sep 2024 13:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="L3iEfKY+"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2F11B86D5
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 13:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725887942; cv=none; b=Crz8yK+/YQeP6+Ncgs3Afh/Vd7PSxqtcl1Gz2iMQfo4+WRJiDcZr2iStgXJcye+IqsR2g7aj0tsPmk53GP40dZPXO0QA+WDpTA8k7EPdi1290JQXx7AZfNdS5lJp4mpiuZ6AFbI9WhL2T+wFpQKO4YhcBWE1f1d2GfO549JsXts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725887942; c=relaxed/simple;
	bh=g2c7WxYBmtRM/VR9ATeeHC3MPf2vZdCwKmZgSBOMNd0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LnxEQvluls54pIyl7zgmfnjOB8Qbk0E+0sB9FmusBZMeApygEQsctdbY+hMcC5lJxT1m0OIXwV2P+NOSAbZRF7tJp+zcolhzIrr4oXhkOxvynHAPNFWRUiqWD05F2sTgIcgb16PWZyoDH9WinIB57AeG3syJ9fIXFQCm9wNFggk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=L3iEfKY+; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 0C630206BC;
	Mon,  9 Sep 2024 15:18:58 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LQl_MYspIVNX; Mon,  9 Sep 2024 15:18:56 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id BD4052067F;
	Mon,  9 Sep 2024 15:18:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com BD4052067F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1725887936;
	bh=Yw4Fts2wCAlgTwj4J/AtuU/+kEPjwA0VRzZYlc+9y0M=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=L3iEfKY+ALbWOUUC3uAS1UHM6CycdmfnPAxje57Jfyu6YB/xdnUq5db43Vk5zh7Tq
	 iikaZl7j5RjN7ChHDuEn8ar3pzCBfLFy+VycJyNO7gTsfTPzIZYxRAaJ3L9TH79dD6
	 PQfbgNd28Ha6DvunV9haIS3SSBsK6OOJApys1RMEuXQxvEiKWcNeL7f+3ZYhmpfurm
	 y0JbObyDOxOYmEVUoidSTHRpNeh98cW2XjTXsUrOgxfZjkt0pP0J8dKE/RZOiwf6cM
	 9sXg+LTSdlip+xE6soLSPkoC9z2pfXbT2NgfoMmhF7WjSFp3KkBd3YhiRJapIINKsy
	 +f8iphzjlDw6Q==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 15:18:56 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 15:18:56 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 22BDF3182BF6; Mon,  9 Sep 2024 15:18:56 +0200 (CEST)
Date: Mon, 9 Sep 2024 15:18:56 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Florian Westphal <fw@strlen.de>
CC: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 06/11] xfrm: switch migrate to xfrm_policy_lookup_bytype
Message-ID: <Zt71wBgRnVDJfpne@gauss3.secunet.de>
References: <20240909100328.1838963-1-steffen.klassert@secunet.com>
 <20240909100328.1838963-7-steffen.klassert@secunet.com>
 <20240909110111.GB19195@breakpoint.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240909110111.GB19195@breakpoint.cc>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Mon, Sep 09, 2024 at 01:01:11PM +0200, Florian Westphal wrote:
> Steffen Klassert <steffen.klassert@secunet.com> wrote:
> > From: Florian Westphal <fw@strlen.de>
> > 
> > XFRM_MIGRATE still uses the old lookup method:
> > first check the bydst hash table, then search the list of all the other
> > policies.
> > 
> > Switch MIGRATE to use the same lookup function as the packetpath.
> > 
> > This is done to remove the last remaining users of the pernet
> > xfrm.policy_inexact lists with the intent of removing this list.
> > 
> > After this patch, policies are still added to the list on insertion
> > and they are rehashed as-needed but no single API makes use of these
> > anymore.
> > 
> > This change is compile tested only.
> 
> This needs following fixup:
> 
> https://patchwork.kernel.org/project/netdevbpf/patch/20240830143920.9478-1-fw@strlen.de/

Hm, looks like I've overlooked this and the other patch.

