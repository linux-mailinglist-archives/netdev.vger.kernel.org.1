Return-Path: <netdev+bounces-253234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KmhAT+Wdml6SgEAu9opvQ
	(envelope-from <netdev+bounces-253234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:16:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA3882A57
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 094003003EEA
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383762FC891;
	Sun, 25 Jan 2026 22:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lO3FJpY9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164F4175D53
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 22:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769379388; cv=none; b=ZPAfznYQNlL5YB/GGd7IvVSBffnw9/zilkSiRADhrqo8fMDpFjVOwuEKkUo46AGZ7HHgzF1bgM00P7mxp4etK9glJyoSbQ3il0dFIDwBWlPGa6DHOQ8GF5jqatOzmWSF/i0jvAoWWzIImQQRWymO2bzeUZVo7pBjaBftJtYF9Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769379388; c=relaxed/simple;
	bh=IXmYEQa3v2AXOgV7ZGc0qQyUfP6Kstj5GKYZ3gYVCpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjUFeU1jjPvyOzteAxZ565loUHWb3qjuCOjzs6uUjVUpRjRhAoCAO0UrTzMF9LWic4hG9Q32urq5a+sVPsboiZwkGrAyCXlXPSgc8RYSrFFBUathitRbNoMWmQRnmLoXMRfdm2ISfa1hi4dSMGTyOtl2d8hC77+lLQMEVQqkwzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lO3FJpY9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25263C4CEF1;
	Sun, 25 Jan 2026 22:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769379387;
	bh=IXmYEQa3v2AXOgV7ZGc0qQyUfP6Kstj5GKYZ3gYVCpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lO3FJpY9D/lRWbrbZt5lKv/9RNiUf0XAQ1CTBQnkGmRGICX0fbqjXxP3cx+iV41YZ
	 2utOyn6n0/g5qTZkOhbkLhGHcfrXFbMoL+AcVvrF+yrLOepU0BHU1RdYBGxG4+uaGs
	 ZHDv1uNdNkK1PTXcronHbCVGe6m2jf5qYi78kqwd2QX6moWWnHHXRyDxQDrun7kcJ6
	 idTmkGO0oedSkBaAqDsnZKbNbYUU1hgU/2z7LhEoa9FlY+ICoSDW4ky8q2I0jGC1Fa
	 7t3qMbx8v/CBRxOGNIbP9l8+3LZeaXMk+1krgyH8on91VQj7ChHyv5ktPAGVI6Lbpg
	 aE2Hkpc3PV+nA==
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
Subject: Re: [net-next,03/21] net: stmmac: rk: convert rk3328 to use bsp_priv->id
Date: Sun, 25 Jan 2026 14:16:25 -0800
Message-ID: <20260125221625.3396113-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <E1vjEu1-00000005gfq-05H8@rmk-PC.armlinux.org.uk>
References: <E1vjEu1-00000005gfq-05H8@rmk-PC.armlinux.org.uk>
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
	TAGGED_FROM(0.00)[bounces-253234-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 4DA3882A57
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: stmmac: rk: convert to mask-based interface mode configuration

This commit converts many Rockchip GMAC implementations to use a new
centralized mask-based infrastructure for configuring PHY interface
mode. The PHY_INTF_SEL and RMII mode configuration is moved from
individual set_to_rgmii()/set_to_rmii() functions to rk_gmac_powerup().

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index 4117f6863ff0..48fc5b58092f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c

[ ... ]

> @@ -1198,9 +1225,6 @@ static const struct rk_gmac_ops rk3576_ops = {
>  #define RK3588_GRF_GMAC_CON0			0X0008
>  #define RK3588_GRF_CLK_CON1			0X0070

The comment above this definition says "/* php_grf */" indicating that
RK3588_GRF_GMAC_CON0 is in the php_grf address space.

> -#define RK3588_GMAC_PHY_INTF_SEL(id, val)	\
> -	(GRF_FIELD(5, 3, val) << ((id) * 6))
> -

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

>  static void rk3588_set_to_rgmii(struct rk_priv_data *bsp_priv,
>  				int tx_delay, int rx_delay)
>  {
>  	u32 offset_con, id = bsp_priv->id;
>
>  	offset_con = bsp_priv->id == 1 ? RK3588_GRF_GMAC_CON9 :
>  					 RK3588_GRF_GMAC_CON8;
>
> -	regmap_write(bsp_priv->php_grf, RK3588_GRF_GMAC_CON0,
> -		     RK3588_GMAC_PHY_INTF_SEL(id, PHY_INTF_SEL_RGMII));

This removed code wrote to php_grf, but the new centralized code in
rk_gmac_powerup() writes to grf instead. Is this intentional?

[ ... ]

>  static void rk3588_set_to_rmii(struct rk_priv_data *bsp_priv)
>  {
> -	regmap_write(bsp_priv->php_grf, RK3588_GRF_GMAC_CON0,
> -		     RK3588_GMAC_PHY_INTF_SEL(bsp_priv->id, PHY_INTF_SEL_RMII));

Same here - the original wrote to php_grf.

[ ... ]

>  static const struct rk_gmac_ops rk3588_ops = {
> +	.init = rk3588_init,
>  	.set_to_rgmii = rk3588_set_to_rgmii,
>  	.set_to_rmii = rk3588_set_to_rmii,
>  	.set_speed = rk3588_set_gmac_speed,
>  	.set_clock_selection = rk3588_set_clock_selection,
> +
> +	.gmac_grf_reg = RK3588_GRF_GMAC_CON0,

This sets gmac_grf_reg to RK3588_GRF_GMAC_CON0, which is then used by
rk_gmac_powerup() to write to bsp_priv->grf.

[ ... ]

> @@ -1654,6 +1696,7 @@ static int rk_gmac_check_ops(struct rk_priv_data *bsp_priv)
>  static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
>  {
>  	struct device *dev = bsp_priv->dev;
> +	u32 val;
>  	int ret;

[ ... ]

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
                                 ^^^^^^^^^^^^

For RK3588, this writes to bsp_priv->grf at offset RK3588_GRF_GMAC_CON0
(0x0008). However, the original code wrote to bsp_priv->php_grf at the
same offset. These are different regmaps obtained from different device
tree phandles (rockchip,grf vs rockchip,php-grf).

Does RK3588 need a mechanism to write the PHY_INTF_SEL to php_grf rather
than grf? The clock register already has clock_grf_reg_in_php support
to select which regmap to use, but there does not appear to be a similar
mechanism for gmac_grf_reg.
-- 
pw-bot: cr

