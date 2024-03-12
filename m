Return-Path: <netdev+bounces-79433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B4987931A
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 12:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AE2E1F218A7
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 11:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8644379B6D;
	Tue, 12 Mar 2024 11:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="pMS3QEI+"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AC869D0A
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 11:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710243407; cv=none; b=U1Nu3vwDyd+GhOLCJLubMfCdaegxE4IEQkvMpmGs6iVM2+ycR+D9vVt3KYakR7yA0J5NWZ9oPN4eUHWU9B2he/RrAVYBFdozuptVdfzndBudbPTkAjQLh4GhfIjbkVFZNTqSeKyA0FRD9EJXTyfw2O80CPgipRrruVK6eYswSe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710243407; c=relaxed/simple;
	bh=3o/32+gNi7dBsTKx51Zvp1OjPbM7jazD08rz37oUJ58=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jz67wlNvZd1H72Yo86oFfrgIo5X1BuxIIZRtXblurLhs/y9iMPNuXLCJwC4tVqLNZSkox2w4yfKzgk2oz9mYGFRBNVdVVRgtfcnNrv7KiLtkx+joyvm3Zz2EAgkK93f3XL+K1fZ0raYPD05kvHDnwS0sGDP/YTekcHfOu5HbjGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=pMS3QEI+; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 26F2F2083B;
	Tue, 12 Mar 2024 12:36:43 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r93UHtqpsVbz; Tue, 12 Mar 2024 12:36:42 +0100 (CET)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 8D482207E4;
	Tue, 12 Mar 2024 12:36:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 8D482207E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1710243402;
	bh=fT0hl51me38fwSaSN/najHHBS2IBRvjuoQeQFPYR7NA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=pMS3QEI+wushpZNHlamAheAiAX9sHqx4jCPn1qKuyp4MIFts0RRVciQcRAtMXEr2Y
	 xQz1XOnyuirta1+R3YRAfpNxpYNGjzwcJnzyZfsGm+krqdm8iTfP0e9dgZxvfsZpNA
	 hV6kGoIwqtOgPsiVKDpYiKI8XU4wTMRxU0tSnuvqM7YWqj8QGDojRUZKzCpvgJxTe+
	 oscNC6yOgHvVzd1ITzCyzSWLEN9qTnfpR08w3vCTiTE2CeauYa+UvZCOwA6lAbrc9/
	 Y7KUTb8ldlIxbdFQbHxY9wus498Lcx6um8DJx12vhxB4lAnuTzznIqEXsFZePR3JHW
	 0C2IuuASQ4mmQ==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 7B59580004A;
	Tue, 12 Mar 2024 12:36:42 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 12:36:42 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 12:36:41 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 999763182A2D; Tue, 12 Mar 2024 12:36:41 +0100 (CET)
Date: Tue, 12 Mar 2024 12:36:41 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
	"Jakub Kicinski" <kuba@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH 2/5] xfrm: Pass UDP encapsulation in TX packet offload
Message-ID: <ZfA+SZwcUFdQssxu@gauss3.secunet.de>
References: <20240306100438.3953516-1-steffen.klassert@secunet.com>
 <20240306100438.3953516-3-steffen.klassert@secunet.com>
 <a650221ae500f0c7cf496c61c96c1b103dcb6f67.camel@redhat.com>
 <Ze/0Fi5oqkcqwbIX@gauss3.secunet.de>
 <20240312111528.GT12921@unreal>
 <ZfA6kauSNCbPLIuM@gauss3.secunet.de>
 <20240312112630.GU12921@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240312112630.GU12921@unreal>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Tue, Mar 12, 2024 at 01:26:30PM +0200, Leon Romanovsky wrote:
> 
> Is it better?
> 
> diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> index 653e51ae3964..6346690d5c69 100644
> --- a/net/xfrm/xfrm_device.c
> +++ b/net/xfrm/xfrm_device.c
> @@ -407,7 +407,8 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
>         struct xfrm_dst *xdst = (struct xfrm_dst *)dst;
>         struct net_device *dev = x->xso.dev;
> 
> -       if (!x->type_offload)
> +       if (!x->type_offload ||
> +           (x->xso.type == XFRM_DEV_OFFLOAD_UNSPECIFIED && x->encap))
>                 return false;

Yes, that should do it.

Thanks!

