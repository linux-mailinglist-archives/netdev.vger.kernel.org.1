Return-Path: <netdev+bounces-105951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B4F913D71
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 19:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D66F1F20D46
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 17:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E671836E3;
	Sun, 23 Jun 2024 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SBi8Ig5k"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0444712E1D1;
	Sun, 23 Jun 2024 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719165405; cv=none; b=CL8POoEYw5woExXpVJJgZBW/I6p4kranMdA00NTMO6GkQrjGVxJ+9VhS6vIGZ5nEMBjEZcZDucNR2PURGZdO833QNO4n8br5VyqJublxwGYbqm/GnjssGqQxwRmkozZ4JmMP2cordAr+9QYedcuS/yAuQkasVmlBAhx7qR+ciek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719165405; c=relaxed/simple;
	bh=R9Ubzz/1Tw0aPlQUWNOfjVouf4hBa4yPYahG9GCS5I0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJHdLpuay/J3TypXNvw1xVxPLkAK6M5UAzXG4mdhGhjzQ3vVW1toJBoLsBdTXw+viPTbLHq47O2bRnK2L2myXWntfocCQf1CmlRL+rHGkCT5IZEmP2oDV56aCMGy2YzgWyIeNXG2OWUYzuSj8ABtMzyCw4E0SSDZ5ytZX1KEGwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SBi8Ig5k; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6B2hSzN6wUZJiN2cPxvTxUJrgPEaM8Jvt0OMTSIbYFM=; b=SBi8Ig5kM9ywmlWWVx0DvoKUAo
	yyRh60WddHqNpeE/FjsSi/ZryLQInZXbah8k/+I89/2eJfBdsIjvMtjMm8b05mPvAZ+qUCoGwhbvt
	jZ/tokMkC1U0/CbtrK7E/T3nAZV16KPC37oMmxXzyxRG9Er14xy1J/aFqSNzw3EbImpw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sLRRv-000nIu-KM; Sun, 23 Jun 2024 19:56:23 +0200
Date: Sun, 23 Jun 2024 19:56:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo.bianconi83@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, conor@kernel.org,
	linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com,
	benjamin.larsson@genexis.eu, rkannoth@marvell.com,
	sgoutham@marvell.com
Subject: Re: [PATCH v3 net-next 2/2] net: airoha: Introduce ethernet support
 for EN7581 SoC
Message-ID: <2752c453-cabd-4ca0-833f-262b221de240@lunn.ch>
References: <cover.1719159076.git.lorenzo@kernel.org>
 <89c9c226ddb31d9ff3d31231e8f532a3e983363a.1719159076.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89c9c226ddb31d9ff3d31231e8f532a3e983363a.1719159076.git.lorenzo@kernel.org>

> +static int airoha_fe_set_pse_oq_rsv(struct airoha_eth *eth,
> +				    u32 port, u32 queue, u32 val)
> +{
> +	u32 orig_val, tmp, all_rsv, fq_limit;
> +	const u32 pse_port_oq_id[] = {
> +		PSE_PORT0_QUEUE,
> +		PSE_PORT1_QUEUE,
> +		PSE_PORT2_QUEUE,
> +		PSE_PORT3_QUEUE,
> +		PSE_PORT4_QUEUE,
> +		PSE_PORT5_QUEUE,
> +		PSE_PORT6_QUEUE,
> +		PSE_PORT7_QUEUE,
> +		PSE_PORT8_QUEUE,
> +		PSE_PORT9_QUEUE,
> +		PSE_PORT10_QUEUE
> +	};

> +static void airoha_fe_oq_rsv_init(struct airoha_eth *eth)
> +{
> +	int i;
> +
> +	/* hw misses PPE2 oq rsv */
> +	airoha_fe_set(eth, REG_FE_PSE_BUF_SET,
> +		      PSE_DEF_RSV_PAGE * PSE_PORT8_QUEUE);
> +
> +	for (i = 0; i < PSE_PORT0_QUEUE; i++)
> +		airoha_fe_set_pse_oq_rsv(eth, 0, i, 0x40);
> +	for (i = 0; i < PSE_PORT1_QUEUE; i++)
> +		airoha_fe_set_pse_oq_rsv(eth, 1, i, 0x40);
> +
> +	for (i = 6; i < PSE_PORT2_QUEUE; i++)
> +		airoha_fe_set_pse_oq_rsv(eth, 2, i, 0);
> +
> +	for (i = 0; i < PSE_PORT3_QUEUE; i++)
> +		airoha_fe_set_pse_oq_rsv(eth, 3, i, 0x40);

Code like this is making me wounder about the split between MAC
driver, DSA driver and DSA tag driver. Or if it should actually be a
pure switchdev driver?

If there some open architecture documentation for this device?

What are these ports about?

> +static void airoha_qdma_clenaup_rx_queue(struct airoha_queue *q)

cleanup?

> +static int airoha_dev_open(struct net_device *dev)
> +{
> +	struct airoha_eth *eth = netdev_priv(dev);
> +	int err;
> +
> +	if (netdev_uses_dsa(dev))
> +		airoha_fe_set(eth, REG_GDM1_INGRESS_CFG, GDM1_STAG_EN_MASK);
> +	else
> +		airoha_fe_clear(eth, REG_GDM1_INGRESS_CFG, GDM1_STAG_EN_MASK);

Does that imply both instances of the GMAC are not connected to the
switch? Can one be used with a PHY?

	Andrew

