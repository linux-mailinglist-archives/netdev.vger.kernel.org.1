Return-Path: <netdev+bounces-137396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F039A6006
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 11:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 711DAB28734
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 09:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1DB194C79;
	Mon, 21 Oct 2024 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="MxhXQr2D"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D81D531
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503026; cv=none; b=kjNm13jJ9OpcU834mtmLxfqlLhv/TC5uEd7/vlkqUk1tG+ZTaDefyZXgrPvOPkBBN9nn94DWG2W6KCYIJJnZoXg6hJGal3Q9dFjg0VlVvfBfg30xKW+B2BLChxdcK+31vX/GAyIAdPMXVwJshHyJNuhnmURXL6RwVU87cFZRcLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503026; c=relaxed/simple;
	bh=PyCx5vnfW1+bXSxbUibXQPTrgTOZtFw3+1JXRe/JuFY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1s44B5ggJCGECI9a7czSwuK7fk2/cnP8JVFiOB8lCOJ/6lThIecxFx/V3ZLRMEa+MQ+gFe0zQkcm53LpByCUrctOxYkWZYx7X2+rOqqdp8z2xurECzJKf90gk4cG6iumM/Cgff8nqhm67QW7CqNa7iXSbGcAD1pvSzoQNCX8gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=MxhXQr2D; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id A4F53201AA;
	Mon, 21 Oct 2024 11:30:21 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d8X1o4rZowtn; Mon, 21 Oct 2024 11:30:21 +0200 (CEST)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 1D24520184;
	Mon, 21 Oct 2024 11:30:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 1D24520184
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1729503021;
	bh=rIv4EQITWJFHOmq6nEtKJA+fKOIB4yEgaJ7xuI1UMU0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=MxhXQr2DJkZ/c8nOEyKBCbSDtxZnpL7BUJ3ZbPpere2+eKFji48m4ROUVBzBhjsve
	 eJV2IVKL0sldASEqgZju6MX+yrftISHC9fGp5BHpzu7LYX00upxFFyRAiA3HJM9OWI
	 +D8ociOVlX2f+QLS2lrQ3JyM8u2wIZnHaD1+M74mEJGUywtHAJ0Ctsgu4b+w2F93DX
	 GORjwsyTSqHtblmQ4/likkmx4Fus3PFcplUHD3oMS92g8aWFfIZpLGC9WnB5+WXwYD
	 jfuA1nCuUia17pJdk5XRnwT8OUwRMv+mtVk0rFRY39MHXxgTn9fbLg/VFJBQmQFQef
	 SJZb82EzytkEA==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 11:30:20 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 11:30:20 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 9CF133184C85; Mon, 21 Oct 2024 11:30:20 +0200 (CEST)
Date: Mon, 21 Oct 2024 11:30:20 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Christian Hopps <chopps@chopps.org>
CC: <devel@linux-ipsec.org>, <netdev@vger.kernel.org>, Florian Westphal
	<fw@strlen.de>, Sabrina Dubroca <sd@queasysnail.net>, Simon Horman
	<horms@kernel.org>, Antony Antony <antony@phenome.org>, Christian Hopps
	<chopps@labn.net>
Subject: Re: [PATCH ipsec-next v12 08/16] xfrm: iptfs: add user packet
 (tunnel ingress) handling
Message-ID: <ZxYfLMIahzR9cpMw@gauss3.secunet.de>
References: <20241007135928.1218955-1-chopps@chopps.org>
 <20241007135928.1218955-9-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241007135928.1218955-9-chopps@chopps.org>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Mon, Oct 07, 2024 at 09:59:20AM -0400, Christian Hopps wrote:
> From: Christian Hopps <chopps@labn.net>
> @@ -77,8 +609,11 @@ static int iptfs_user_init(struct net *net, struct xfrm_state *x,
>  {
>  	struct xfrm_iptfs_data *xtfs = x->mode_data;
>  	struct xfrm_iptfs_config *xc;
> +	u64 q;
>  
>  	xc = &xtfs->cfg;
> +	xc->max_queue_size = IPTFS_DEFAULT_MAX_QUEUE_SIZE;
> +	xtfs->init_delay_ns = IPTFS_DEFAULT_INIT_DELAY_USECS * NSECS_IN_USEC;
>  
>  	if (attrs[XFRMA_IPTFS_PKT_SIZE]) {
>  		xc->pkt_size = nla_get_u32(attrs[XFRMA_IPTFS_PKT_SIZE]);
> @@ -92,6 +627,17 @@ static int iptfs_user_init(struct net *net, struct xfrm_state *x,
>  			return -EINVAL;
>  		}
>  	}
> +	if (attrs[XFRMA_IPTFS_MAX_QSIZE])
> +		xc->max_queue_size = nla_get_u32(attrs[XFRMA_IPTFS_MAX_QSIZE]);
> +	if (attrs[XFRMA_IPTFS_INIT_DELAY])
> +		xtfs->init_delay_ns =
> +			(u64)nla_get_u32(attrs[XFRMA_IPTFS_INIT_DELAY]) *
> +			NSECS_IN_USEC;
> +
> +	q = (u64)xc->max_queue_size * 95;
> +	(void)do_div(q, 100);

This cast is not need.

> +	xtfs->ecn_queue_size = (u32)q;
> +
>  	return 0;
>  }
>  
> @@ -101,8 +647,11 @@ static unsigned int iptfs_sa_len(const struct xfrm_state *x)
>  	struct xfrm_iptfs_config *xc = &xtfs->cfg;
>  	unsigned int l = 0;
>  
> -	if (x->dir == XFRM_SA_DIR_OUT)
> +	if (x->dir == XFRM_SA_DIR_OUT) {
> +		l += nla_total_size(sizeof(u32)); /* init delay usec */
> +		l += nla_total_size(sizeof(xc->max_queue_size));
>  		l += nla_total_size(sizeof(xc->pkt_size));
> +	}
>  
>  	return l;
>  }
> @@ -112,9 +661,22 @@ static int iptfs_copy_to_user(struct xfrm_state *x, struct sk_buff *skb)
>  	struct xfrm_iptfs_data *xtfs = x->mode_data;
>  	struct xfrm_iptfs_config *xc = &xtfs->cfg;
>  	int ret = 0;
> +	u64 q;
> +
> +	if (x->dir == XFRM_SA_DIR_OUT) {
> +		q = xtfs->init_delay_ns;
> +		(void)do_div(q, NSECS_IN_USEC);

Same here.


