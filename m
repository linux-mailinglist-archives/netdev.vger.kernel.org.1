Return-Path: <netdev+bounces-79429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E048792DD
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 12:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9A0AB23E91
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 11:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6F879B69;
	Tue, 12 Mar 2024 11:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="wj0BoyDH"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3415A79B73
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 11:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710242456; cv=none; b=V52RvDwtGVD7MJ6NYyxdhgf1Suc18nF8t8eoz/2ScOi2vmbNxsd98I88rbdiBkwkAXRs0D07UZtg9CDXUtEsPWfumeKQHb6RilwZ1H45deNj6E1Z0I5wfUyrx7MdDhHIvY1+ANe6VA2SESJxEVLJ/NhJCWkOU44fRhzGSd5PbIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710242456; c=relaxed/simple;
	bh=OTca8ekV6r4/5e5k7YjJinx+VHTLXxT3NAZ6B9Zk9ho=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sRP2BDPx+GKcLh+AI6G3HNiti4le/4qgmc/tDqttEB74IW2eNA6yXzVAyJvONXI2rPRfPIKn/1y8oS8w3GgP11okr/UUs62gWqlkqoIu7FkMA4ge1xeUZZSIlD/qaWgNRb/uqynEpBOM8s3f2/iiPGlfyVx/fxywfM3xH18NLMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=wj0BoyDH; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 3FA6C20758;
	Tue, 12 Mar 2024 12:20:51 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d9setOEyrNTT; Tue, 12 Mar 2024 12:20:50 +0100 (CET)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 57632205DD;
	Tue, 12 Mar 2024 12:20:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 57632205DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1710242450;
	bh=x6EE4LXXtCscXe7/3w+bGHO/aq9fItFtiLgNcOe1YcA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=wj0BoyDHHfyklZrSxkiXZxibYAx4XSaOlR4uSGOXkNBwCTRZjjs9QB911IsO9bY/m
	 +EPUGUx6Bdl4GWvR98+bs9HmFbrxz4cMMoIJ3jiYHtp1FOTSRB0L+0HfWB41w67QNO
	 jja8Na0r/w7bVBoS67wsQGNivDictVE+VKZ+YLdLOC6cQNYJQAFl07N9qvAd02fuzT
	 OZKzpWf7eKzlLpUksH0kHuJZc8rFp5OhMlHR2AhvdI/sUyNEs/8X6fe7sVunC3u5ys
	 GO2muX9tyWOUX7KKEGPDu4Cv9ErGVLCHfHpG2HoqajMdy3tfLCMGi9e8RZwuy7aFdQ
	 wVCBKmF1EDJ6w==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id 48AEB80004A;
	Tue, 12 Mar 2024 12:20:50 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 12:20:50 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 12:20:49 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 6A0CE3182A2D; Tue, 12 Mar 2024 12:20:49 +0100 (CET)
Date: Tue, 12 Mar 2024 12:20:49 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
	"Jakub Kicinski" <kuba@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH 2/5] xfrm: Pass UDP encapsulation in TX packet offload
Message-ID: <ZfA6kauSNCbPLIuM@gauss3.secunet.de>
References: <20240306100438.3953516-1-steffen.klassert@secunet.com>
 <20240306100438.3953516-3-steffen.klassert@secunet.com>
 <a650221ae500f0c7cf496c61c96c1b103dcb6f67.camel@redhat.com>
 <Ze/0Fi5oqkcqwbIX@gauss3.secunet.de>
 <20240312111528.GT12921@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240312111528.GT12921@unreal>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Tue, Mar 12, 2024 at 01:15:28PM +0200, Leon Romanovsky wrote:
> On Tue, Mar 12, 2024 at 07:20:06AM +0100, Steffen Klassert wrote:
> > On Mon, Mar 11, 2024 at 05:25:03PM +0100, Paolo Abeni wrote:
> > > Hi,
> > > 
> > > On Wed, 2024-03-06 at 11:04 +0100, Steffen Klassert wrote:
> > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > > 
> > > > In addition to citied commit in Fixes line, allow UDP encapsulation in
> > > > TX path too.
> > > > 
> > > > Fixes: 89edf40220be ("xfrm: Support UDP encapsulation in packet offload mode")
> > > > CC: Steffen Klassert <steffen.klassert@secunet.com>
> > > > Reported-by: Mike Yu <yumike@google.com>
> > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > > Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> > > > Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> > > 
> > > This is causing self-test failures:
> > > 
> > > https://netdev.bots.linux.dev/flakes.html?tn-needle=pmtu-sh
> > > 
> > > reverting this change locally resolves the issue.
> > > 
> > > @Leon, @Steffen: could you please have a look?
> > 
> > Looks like the check for x->encap was removed unconditionally.
> > I should just be removed when XFRM_DEV_OFFLOAD_PACKET is set,
> > otherwise we might create a GSO packet with UPD encapsulation.
> > 
> > Leon?
> 
> Right, I missed IPsec SW path, that x->encap check can be removed
> in packet offload because HW supports it and in crypto offload, because
> there is a check in xfrm_dev_state_add() to prevent it.
> 
> What about this fix?
> 
> diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> index 653e51ae3964..6e3e5a09cfeb 100644
> --- a/net/xfrm/xfrm_device.c
> +++ b/net/xfrm/xfrm_device.c
> @@ -407,7 +407,7 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
>         struct xfrm_dst *xdst = (struct xfrm_dst *)dst;
>         struct net_device *dev = x->xso.dev;
> 
> -       if (!x->type_offload)
> +       if (!x->type_offload || x->xso.type == XFRM_DEV_OFFLOAD_UNSPECIFIED)
>                 return false;

Then we can't generate GSO packets for the SW path anymore. We just need
to reject UDP enacpsulation in SW here.

