Return-Path: <netdev+bounces-77268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B437871084
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 23:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D4501C21AAD
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 22:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847E37C092;
	Mon,  4 Mar 2024 22:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BM+I+cwm"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D3A7B3FA
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 22:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592997; cv=none; b=A9ne1yEOVh0q8X4gOr6Vtl9LLWPq+zDidx6S6NMmqqzIrN7f+p2p12S/PZc3G2VhmolJ7H29hU2DO1L17XYJfCx/lpH/+5JW/p1I5iGLiMd9SsJZAtuTwa11ZWOWfqoFrNqp5mKDEPAFVl4JVXgIttRIddusr6c41Qq+YNGwiFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592997; c=relaxed/simple;
	bh=jIAAIx9kDtmVcXf6HFELccB46Q1w4AIcY1XJrkCV7rA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYH5e5E6S8g1yrEsBWNeKzH/SGi1028OoL6X0u8pdbq+gHkj9UKWYkPUTkwjwtczS90bvQtOnppOfHP/OmfTjXOGlDKXBE0hC4TEfBp5hXXXfhdHknYrPrDiqifWsG1yEAAhzDESJD39NbD8TS8sSdpP0wZVlEEn8xq0B2YMOQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=BM+I+cwm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=r0n1lhJBODqtvRWnwfBmDZ2gKOwoURvjCiUnt9BsIgw=; b=BM+I+cwmW4SG+FaQshZgYT2cea
	IZnve31DzPz0svs8VGtJmz3Cazshvt+q8SrcYzHTwi2zoqBYa1GOo5t/XtfRtiyqyMSCpRxxdFI7x
	Tdkvifuq2B3p+PBtwd9fxo4cV/nvColAKsLPuMXMrd9hGgK9hCxh91KDTVgg+hv88+Jc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rhHEx-009MP2-D9; Mon, 04 Mar 2024 23:56:59 +0100
Date: Mon, 4 Mar 2024 23:56:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 06/22] ovpn: introduce the ovpn_peer object
Message-ID: <053db969-1c21-41db-b0b5-f436593205dc@lunn.ch>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-7-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304150914.11444-7-antonio@openvpn.net>

> +	ret = ptr_ring_init(&peer->tx_ring, OVPN_QUEUE_LEN, GFP_KERNEL);
> +	if (ret < 0) {
> +		netdev_err(ovpn->dev, "%s: cannot allocate TX ring\n", __func__);
> +		goto err_dst_cache;
> +	}
> +
> +	ret = ptr_ring_init(&peer->rx_ring, OVPN_QUEUE_LEN, GFP_KERNEL);
> +	if (ret < 0) {
> +		netdev_err(ovpn->dev, "%s: cannot allocate RX ring\n", __func__);
> +		goto err_tx_ring;
> +	}
> +
> +	ret = ptr_ring_init(&peer->netif_rx_ring, OVPN_QUEUE_LEN, GFP_KERNEL);
> +	if (ret < 0) {
> +		netdev_err(ovpn->dev, "%s: cannot allocate NETIF RX ring\n", __func__);
> +		goto err_rx_ring;
> +	}

These rings are 1024 entries? The real netif below also likely has
another 1024 entry ring. Rings like this are latency. Is there a BQL
like mechanism to actually keep the rings empty, throw packets away
rather than queue them, because queueing them just accumulates
latency?

So, i guess my question is, how do you avoid bufferbloat? Why do you
actually need these rings?

    Andrew

