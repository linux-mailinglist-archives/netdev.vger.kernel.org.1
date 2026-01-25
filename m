Return-Path: <netdev+bounces-253235-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mP1NDVOWdml6SgEAu9opvQ
	(envelope-from <netdev+bounces-253235-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:16:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CDA82A6C
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CE7230087AD
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F201530E0F9;
	Sun, 25 Jan 2026 22:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJ2VaWe9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF07C175D53
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 22:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769379389; cv=none; b=E9ZVM/0z8tQqzUdmCBIg8a7d6edp8ptFvoLWN8UJqJP5vi9FMNJq2x2IMaM2AMD0vFbq9a/68/ZHBmqUUOAX3gZ7L4GA6guXn356rg7/WOjzX9XQTtAhoIQsbNoKviaFhuf+QTKLH/vmXlBkylCPDMR+Zc1bBx5R4+leirVs+bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769379389; c=relaxed/simple;
	bh=d0e6wGR5CvLacjw6Dk5QUSRgUBj7IzlbzM3eQMWWIE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMfwc9P2QKfZc/xc6Yn2ra99nXl/KZw1/Vmm/322l7Rh7KGcsR+odiLGxU1XQfW9cIeQK0rLsmm6Ag7kRxjSuTp11/h5xaXNvT9UDCstdLW0ECv1jjtXaul4ifqzROsRIeq+ePRJHu5MI3XvfXuO/Hd4gsFAru4hQt6kA1uOAsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJ2VaWe9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E478AC16AAE;
	Sun, 25 Jan 2026 22:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769379389;
	bh=d0e6wGR5CvLacjw6Dk5QUSRgUBj7IzlbzM3eQMWWIE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dJ2VaWe9Y681uA5O6VXiK85/AuwwpVof+DzkmFwm5UjvHuE6pywUzUvbVAVvOXG9l
	 hfwQi9rV09LguQ+rVHfvrDcDP6YSxfApFjuMrydLFiQonchAFn2tRes4gM0d6+UyZU
	 dW0vnCZjSE5R1FACd/AZN94Rzc8fBePyCwj8e02cLWvaF5lhQpnRzsL5mTsd3yyZay
	 Ht5v6d9voDwxlVedzgNIlVB0UA/Bqe+yW6MJdfp1dsH05KSmnmJgcxTE3FKNu+K3Do
	 yLa4swLHRjCesVqles3HfHIx6KR6dMZFmPjLGp9PnykUiMtH8pbTWHFeRUv5uwCy8X
	 oyLyoEBWa5sQA==
From: Jakub Kicinski <kuba@kernel.org>
To: rmk+kernel@armlinux.org.uk
Cc: Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	andrew@lunn.ch,
	davem@davemloft.net,
	alexandre.torgue@foss.st.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	heiko@sntech.de,
	andrew+netdev@lunn.ch,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [net-next,07/21] net: stmmac: rk: convert to mask-based interface mode configuration
Date: Sun, 25 Jan 2026 14:16:27 -0800
Message-ID: <20260125221627.3396138-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <E1vjEuL-00000005ggE-1z5W@rmk-PC.armlinux.org.uk>
References: <E1vjEuL-00000005ggE-1z5W@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-253235-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 91CDA82A6C
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: stmmac: rk: convert to mask-based interface mode configuration

This patch consolidates PHY interface mode configuration into a common
infrastructure. It introduces mask fields for phy_intf_sel and rmii_mode,
and moves the register writes from SoC-specific set_to_rgmii/set_to_rmii
functions into the common rk_gmac_powerup() function.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index 4117f6863ff0..48fc5b58092f 100644

[ ... ]

> @@ -1198,9 +1225,6 @@ static const struct rk_gmac_ops rk3576_ops = {
>  #define RK3588_GRF_GMAC_CON0			0X0008
>  #define RK3588_GRF_CLK_CON1			0X0070

The comment above these defines says "/* php_grf */" indicating that
RK3588_GRF_GMAC_CON0 is in the php_grf register space.

[ ... ]

> +static int rk3588_init(struct rk_priv_data *bsp_priv)
> +{
> +	switch (bsp_priv->id) {
> +	case 0:
> +		bsp_priv->gmac_phy_intf_sel_mask = GENMASK_U16(5, 3);
> +		return 0;
> +
> +	case 1:
> +		bsp_priv->gmac_phy_intf_sel_mask = GENMASK_U16(11, 9);
> +		return 0;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}

[ ... ]

> @@ -1296,10 +1330,14 @@ static void rk3588_set_clock_selection(struct rk_priv_data *bsp_priv, bool input
>  }
>
>  static const struct rk_gmac_ops rk3588_ops = {
> +	.init = rk3588_init,
>  	.set_to_rgmii = rk3588_set_to_rgmii,
>  	.set_to_rmii = rk3588_set_to_rmii,
>  	.set_speed = rk3588_set_gmac_speed,
>  	.set_clock_selection = rk3588_set_clock_selection,
> +
> +	.gmac_grf_reg = RK3588_GRF_GMAC_CON0,

rk3588_ops sets gmac_grf_reg to RK3588_GRF_GMAC_CON0, and rk3588_init()
sets gmac_phy_intf_sel_mask. This enables the new common code path in
rk_gmac_powerup().

[ ... ]

> @@ -1664,6 +1707,24 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
>  	if (ret)
>  		return ret;
>
> +	ret = rk_get_phy_intf_sel(bsp_priv->phy_iface);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (bsp_priv->gmac_phy_intf_sel_mask ||
> +	    bsp_priv->gmac_rmii_mode_mask) {
> +		/* If defined, encode the phy_intf_sel value */
> +		val = rk_encode_wm16(ret, bsp_priv->gmac_phy_intf_sel_mask);
> +
> +		/* If defined, encode the RMII mode mask setting. */
> +		val |= rk_encode_wm16(ret == PHY_INTF_SEL_RMII,
> +				      bsp_priv->gmac_rmii_mode_mask);
> +
> +		ret = regmap_write(bsp_priv->grf, bsp_priv->gmac_grf_reg, val);
                                          ^^^^

For rk3588, does this write to the wrong regmap? The old code in
rk3588_set_to_rgmii() and rk3588_set_to_rmii() wrote the PHY_INTF_SEL
register to bsp_priv->php_grf:

    regmap_write(bsp_priv->php_grf, RK3588_GRF_GMAC_CON0,
                 RK3588_GMAC_PHY_INTF_SEL(id, PHY_INTF_SEL_RGMII));

But the new common code writes to bsp_priv->grf instead. The comment in
the source indicates RK3588_GRF_GMAC_CON0 is in the php_grf register
space. Should this be using php_grf for rk3588?

> +		if (ret < 0)
> +			return ret;
> +	}

