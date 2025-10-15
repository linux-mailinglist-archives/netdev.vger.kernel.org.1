Return-Path: <netdev+bounces-229756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEF1BE0915
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 21:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 489B94E90C5
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 19:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E4B29D279;
	Wed, 15 Oct 2025 19:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TCj4mjLY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75441303C9E
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 19:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760558301; cv=none; b=BbI2nVtq50+ONexUsh0l1Hg6kSneGWGL5QuGgCo1IYe2S1EFQ+SJIn/ClWkYiyQF/gNrTznu60E1UycNLB/VHX28lvqmBm2sAxBpKSUGWxn+6ApBwxpFMSI/lWkpRCvr+oe9ihWyOu5sAf7tSBnLjjUpvXmAnZHp+eO0RZsfmOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760558301; c=relaxed/simple;
	bh=Uj7EnbvZssJkVXp84KaxPj2LwI4Rfo5X/hchbm0Lm+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBZetws8MrP20TTfWcjYva+NTh30lnbkvUrw6S5bP7Zx8DS2rKPfVA6xU+A4rVvbhMO3iQNSEGSXBujj+J1PKOzrD2S3yZCXrAgEzr6fAlkorIf/v8mXOalHZIbWoAxkvJoHvSExL77Z9YOgQLBz4fgom0uBKHaxFKjGRLt+c0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TCj4mjLY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ez/LWcvd6t0zds7+2GDOM1sGoxixfln/lVUaFFw+q2w=; b=TCj4mjLY12ibKAG0NPUZPavQoS
	HrqyZ7Oduiwbw6K4wW99Ig1xX7J2/iWGmCMvmQPSGv/DkX/suh48DgT87snGAIP530Mew1JyS0EzF
	IqE+0V8/ZGtDHUITXGuZoU5B/oKmRM8YCt55n6pQXpOaJ9DrSg8xk19zMFLBsoV8BjSU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v97dP-00B4JZ-N4; Wed, 15 Oct 2025 21:58:07 +0200
Date: Wed, 15 Oct 2025 21:58:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Vivian Wang <wangruikang@iscas.ac.cn>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next v6 5/5] eea: introduce ethtool support
Message-ID: <90bddd14-3902-4c19-a134-3c0ea7a66fec@lunn.ch>
References: <20251015071145.63774-1-xuanzhuo@linux.alibaba.com>
 <20251015071145.63774-6-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015071145.63774-6-xuanzhuo@linux.alibaba.com>

> @@ -111,6 +116,8 @@ struct eea_net_cfg {
>  	u8 tx_cq_desc_size;
>  
>  	u32 split_hdr;
> +
> +	struct hwtstamp_config ts_cfg;
>  };
>  

> @@ -391,6 +397,10 @@ static void eea_submit_skb(struct eea_net_rx *rx, struct sk_buff *skb,
>  	if (rx->pkt.data_valid)
>  		skb->ip_summed = CHECKSUM_UNNECESSARY;
>  
> +	if (enet->cfg.ts_cfg.rx_filter == HWTSTAMP_FILTER_ALL)
> +		skb_hwtstamps(skb)->hwtstamp = EEA_DESC_TS(desc) +
> +			enet->hw_ts_offset;
> +

These two hunks are nothing to do with ethtool.

Otherwise this code looks O.K. to me.

	Andrew

