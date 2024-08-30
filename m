Return-Path: <netdev+bounces-123856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9788966B0A
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 23:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749271F25742
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 21:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3561D1BF7E9;
	Fri, 30 Aug 2024 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ODMqYvFw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82871BE259;
	Fri, 30 Aug 2024 21:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725051622; cv=none; b=HH68z9hEfQsUS2cayy37Hpqn6NTato2kxJokVX8c4aWaafnixtTR2xv64VU0Pz2YOj1/9lqUQG/Gcj9vuQH/laGyW5hH7G+QiKl6RQ6fj5lj0xTJor+XB1qQE4+QQYPqMl8eOaKmqlCvAtDYmQF0komDy4oK+vtuQfPCIyC3i+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725051622; c=relaxed/simple;
	bh=EuJxsRZqSRptjHeV2I+tD0QyjFPtJ80vfoL2f9+YKTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmQZhPsqZOuLb6KOOI1AB1KPFCmhIp+ZQXtPA5A8om61Grn24sTwkEIuCDaJ2VVWEYVxIuAjlrqpv53POw/A1QvkRa+/9SneRD9GZ0ggCxxoHIudkloSmbKUo+4F11P099skVhHt1JDB1pXnk4idqIHqYvq+x2tep1526+loVhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ODMqYvFw; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5jMQ5PsZq54MPA7xWEMe58isTrj2xTtba8YYcseqKz0=; b=ODMqYvFwI2/7zngbRJ8po0zcdS
	IObsoE5VEzrCyVYeBDba3DRuy+VJr8fcSnuw6+oHO32nAlof71NRP7zd6ivHaC1uO9tipJ8otsuLs
	iJx2RQyetokWBwk/p4yUtTJBsE8oLQrNJo93KPAqhnrNB44f3rMYAw0be6/eGkn4/sOA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sk8j6-006ADw-By; Fri, 30 Aug 2024 23:00:12 +0200
Date: Fri, 30 Aug 2024 23:00:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Herve Codina <herve.codina@bootlin.com>,
	Simon Horman <horms@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v2 2/7] net: ethernet: fs_enet: cosmetic cleanups
Message-ID: <0232c636-112e-4345-b70d-90f8696704ff@lunn.ch>
References: <20240829161531.610874-1-maxime.chevallier@bootlin.com>
 <20240829161531.610874-3-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829161531.610874-3-maxime.chevallier@bootlin.com>

> @@ -235,15 +219,15 @@ static int fs_enet_napi(struct napi_struct *napi, int budget)
>  			if (pkt_len <= fpi->rx_copybreak) {
>  				/* +2 to make IP header L1 cache aligned */
>  				skbn = netdev_alloc_skb(dev, pkt_len + 2);
> -				if (skbn != NULL) {
> +				if (skbn) {
>  					skb_reserve(skbn, 2);	/* align IP header */
> -					skb_copy_from_linear_data(skb,
> -						      skbn->data, pkt_len);
> +					skb_copy_from_linear_data(skb, skbn->data,
> +								  pkt_len);
>  					swap(skb, skbn);
>  					dma_sync_single_for_cpu(fep->dev,
> -						CBDR_BUFADDR(bdp),
> -						L1_CACHE_ALIGN(pkt_len),
> -						DMA_FROM_DEVICE);
> +								CBDR_BUFADDR(bdp),
> +								L1_CACHE_ALIGN(pkt_len),
> +								DMA_FROM_DEVICE);

The indentation level here suggest refactoring into helpers might be
nice. But not a prerequisite for merging.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

