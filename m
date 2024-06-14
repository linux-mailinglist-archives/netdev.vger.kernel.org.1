Return-Path: <netdev+bounces-103435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 765AD90803F
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 02:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8956BB20D3A
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 00:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56A736C;
	Fri, 14 Jun 2024 00:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpWn+OGu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1AFD4409
	for <netdev@vger.kernel.org>; Fri, 14 Jun 2024 00:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718326090; cv=none; b=MgUSEJ4Fvrm04GdvWDEBSRFedWFCRGbiCU/ZstMJ3iFSF2yRHsLtx0JvMkkj5N8tNwiZKtFWmJm+4LgcnkKrcURYLsjnajFGl0fABBi53XTxtn+2LFhBYZ57r4hjgQOafN9VoCsJGhdZhgviAdJ+Z4ZTniFtNgZQFPWsW/AV3lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718326090; c=relaxed/simple;
	bh=HivRAjv7FOkh7RgeVuuiSjUnQ1FmS0VxB9TXrhNK9yY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aldzCPL5ZfWJ0+c21fZuuzWhbmKkhE8oVcC1uKSwBYL1UEDlR+B7kKPr6a9QMHxEHyqTaxdHsyBSgj+CgYoA0wAaNgzFSyDqW2y0Pd5lQu4+qjeJvbzkC8TDbI2PPsl/xQ8g/HGtgZed76eWBjqbxO4nDdnwGyK+Y2CAxNkvTZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpWn+OGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8836DC2BBFC;
	Fri, 14 Jun 2024 00:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718326090;
	bh=HivRAjv7FOkh7RgeVuuiSjUnQ1FmS0VxB9TXrhNK9yY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tpWn+OGuGdvE73pOcXWnuMT42cuk2OmiGN2yn4Je6+MY1gd1ywZv8HVNSMtGuTuq4
	 vXNuf7f8MU9NCoTCR86fgTTTdsz7q3/msYRDDf0OIdi8qYr+RUQxW/cpTwox40XRGX
	 DkKnS/rAWanYmsc5CabXn3pn1YZOsrLjfJZ7uEu6wJRHA6irUx7MUIXIqw3rukdkDp
	 g0/oeG6YbrFoD59lZk8gab7ZVAbAQCM2egE5/BcJQRl8xeVbENUnyYCu2AiFdMHb4B
	 VEUmdCLCtmiyE3b8emY85V/zIYl/Zz5Y5FTfzSO/3us47i/QJHjyOxgooWg9sVd3MI
	 BUWWwTEEid/hA==
Date: Thu, 13 Jun 2024 17:48:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, horms@kernel.org,
 jiri@resnulli.us, pabeni@redhat.com, linux@armlinux.org.uk,
 hfdevel@gmx.net, naveenm@marvell.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v10 4/7] net: tn40xx: add basic Tx handling
Message-ID: <20240613174808.67eb994c@kernel.org>
In-Reply-To: <20240611045217.78529-5-fujita.tomonori@gmail.com>
References: <20240611045217.78529-1-fujita.tomonori@gmail.com>
	<20240611045217.78529-5-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 13:52:14 +0900 FUJITA Tomonori wrote:
> +	/* 1. load MAC (obsolete) */
> +	/* 2. disable Rx (and Tx) */
> +	tn40_write_reg(priv, TN40_REG_GMAC_RXF_A, 0);
> +	mdelay(100);

Why mdelay()? 100ms of CPU spinning in a loop is not great.
I only see calls to tn40_sw_reset() from open and close, both
of which can sleep so you should be able to use msleep().

You can test with CONFIG_DEBUG_ATOMIC_SLEEP enabled to confirm.

> +	/* 3. Disable port */
> +	tn40_write_reg(priv, TN40_REG_DIS_PORT, 1);
> +	/* 4. Disable queue */
> +	tn40_write_reg(priv, TN40_REG_DIS_QU, 1);
> +	/* 5. Wait until hw is disabled */
> +	for (i = 0; i < 50; i++) {
> +		if (tn40_read_reg(priv, TN40_REG_RST_PORT) & 1)
> +			break;
> +		mdelay(10);

read_poll_timeout() ?

> +	}
> +	if (i == 50)
> +		netdev_err(priv->ndev, "SW reset timeout. continuing anyway\n");


> +	if (unlikely(vid >= 4096)) {

can the core actually call with an invalid vid? I don't thinks so..

> +	struct tn40_priv *priv = netdev_priv(ndev);
> +
> +	u32 rxf_val = TN40_GMAC_RX_FILTER_AM | TN40_GMAC_RX_FILTER_AB |
> +		TN40_GMAC_RX_FILTER_OSEN | TN40_GMAC_RX_FILTER_TXFC;
> +	int i;
> +

nit: no empty lines between variable declarations

> +		u8 hash;
> +		struct netdev_hw_addr *mclist;
> +		u32 reg, val;

nit: declaration lines longest to shortest within a block

> +static void tn40_get_stats(struct net_device *ndev,
> +			   struct rtnl_link_stats64 *stats)
> +{
> +	struct tn40_priv *priv = netdev_priv(ndev);
> +
> +	netdev_stats_to_stats64(stats, &priv->net_stats);

You should hold the stats in driver priv, probably:

from struct net_device:

	struct net_device_stats	stats; /* not used by modern drivers */


> +static int tn40_priv_init(struct tn40_priv *priv)
> +{
> +	int ret;
> +
> +	tn40_set_link_speed(priv, 0);
> +
> +	ret = tn40_hw_reset(priv);
> +	if (ret)
> +		return ret;

But probe already called reset, is there a reason to reset multiple
times? Would be good to add some reason why in a comment (if you know)

> +	/* Set GPIO[9:0] to output 0 */
> +	tn40_write_reg(priv, 0x51E0, 0x30010006);	/* GPIO_OE_ WR CMD */
> +	tn40_write_reg(priv, 0x51F0, 0x0);	/* GPIO_OE_ DATA */
> +	tn40_write_reg(priv, TN40_REG_MDIO_CMD_STAT, 0x3ec8);
> +
> +	// we use tx descriptors to load a firmware.

nit: stick to a single style of comments? ;)

> +	ret = tn40_create_tx_ring(priv);
> +	if (ret)
> +		return ret;
> +	ret = tn40_fw_load(priv);
> +	tn40_destroy_tx_ring(priv);

