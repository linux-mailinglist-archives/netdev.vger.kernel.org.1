Return-Path: <netdev+bounces-110779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C6692E447
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 12:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16AF228294A
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 10:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F8A15748F;
	Thu, 11 Jul 2024 10:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Ng1GEOVE"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DF214E2F1
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 10:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720692684; cv=none; b=qXzCoU8cCb5vA0z5b83xrxcU3EoAUQuTBkrCgON+J20zswmQu2nbF8LfiUbmAMuBFCxYDyGEqvgLfJDcw0yilhCD8tPkF1WgeCPJdoQpp1f/m24MSuk0p8wXiqkm6PDuj0X3i4wfAmHtIi5+KbCCYzpMyDez19EZblRoBuua2VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720692684; c=relaxed/simple;
	bh=q4U8ZW0taWEYvN7i+FHy9cnxKlt2ValwXbb4QmRWgFw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BaRM0ek/QCWc4S6CBiykfQVLnrXPJeA72yEJisAd7dFTr9KD7FRsfgaWF6uZnrCVPl+3Qs8ToM/FipcNolArNd53BnLoTs113TK6VurhNzfRptQv5dIDcZlrLQRSeWbJG+9hrs5YzHqWPrIbdSMeyYh69o1KxuehSMUzgw2dRIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Ng1GEOVE; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id F007D207AC;
	Thu, 11 Jul 2024 12:11:20 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F8bz9GepqIWX; Thu, 11 Jul 2024 12:11:20 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 6EE13206F0;
	Thu, 11 Jul 2024 12:11:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 6EE13206F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1720692680;
	bh=WuMx0euj7Ycy5E1NTZ8V2oPXNpWBYrLeX7oL885Dqtg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=Ng1GEOVEALgAbZ42mCkEtkLJeoNaR72qaKrwUNseL8WJi23RqW0OsfmL2IIKWnyXR
	 gHspj/1C+bHkgAU+SLB1G6unfRlXk6bphhVgnJSitVRpknnoo/DyU68Cp4UyvAOG0G
	 pgAHcCIIRkGOxW/ydr7hGzxi3d2ICubWGO1DltuPuYm6L0tqnh58tGUdKqJEmY/W9u
	 TRPTHOb0DaOFoMt15h0nHhbOJQ7bhZKhrvLLtPT/UyQRounZ/3E9Beg3Cg47wsWi8Z
	 PDRH+H3LAx2r8RUbIQcgAIV6pcXH1pnrmxe51GdxXBxD+aYOqYjNUmlk9Wo/M3Aqic
	 IcQBFVa85KE5w==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout1.secunet.com (Postfix) with ESMTP id 6830980004A;
	Thu, 11 Jul 2024 12:11:20 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 11 Jul 2024 12:11:20 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 12:11:19 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 719953182AE6; Thu, 11 Jul 2024 12:11:19 +0200 (CEST)
Date: Thu, 11 Jul 2024 12:11:19 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Mike Yu <yumike@google.com>, <netdev@vger.kernel.org>,
	<stanleyjhu@google.com>, <martinwu@google.com>, <chiachangwang@google.com>
Subject: Re: [PATCH ipsec v3 0/4] Support IPsec crypto offload for IPv6 ESP
 and IPv4 UDP-encapsulated ESP data paths
Message-ID: <Zo+vx4wS49TNX4fa@gauss3.secunet.de>
References: <20240710111654.4085575-1-yumike@google.com>
 <20240711095208.GN6668@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240711095208.GN6668@unreal>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Thu, Jul 11, 2024 at 12:52:08PM +0300, Leon Romanovsky wrote:
> On Wed, Jul 10, 2024 at 07:16:50PM +0800, Mike Yu wrote:
> > 
> > Mike Yu (4):
> >   xfrm: Support crypto offload for inbound IPv6 ESP packets not in GRO
> >     path
> >   xfrm: Allow UDP encapsulation in crypto offload control path
> >   xfrm: Support crypto offload for inbound IPv4 UDP-encapsulated ESP
> >     packet
> >   xfrm: Support crypto offload for outbound IPv4 UDP-encapsulated ESP
> >     packet
> > 
> >  net/ipv4/esp4.c         |  8 +++++++-
> >  net/ipv4/esp4_offload.c | 17 ++++++++++++++++-
> >  net/xfrm/xfrm_device.c  |  6 +++---
> >  net/xfrm/xfrm_input.c   |  3 ++-
> >  net/xfrm/xfrm_policy.c  |  5 ++++-
> >  5 files changed, 32 insertions(+), 7 deletions(-)
> 
> Steffen,
> 
> If it helps, we tested v2 version and it didn't break anything for us :).
> But we didn't test this specific functionality.
> 
> Thanks

Thanks for testing it Leon!

This is a new feature, so I don't want to apply it to the ipsec
tree. Mike, can you rebase on top of ipsec-next instead?

Thanks!

