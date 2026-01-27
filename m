Return-Path: <netdev+bounces-253637-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SN0oILsJeGk2ngEAu9opvQ
	(envelope-from <netdev+bounces-253637-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 01:41:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F19C68E86A
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 01:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4EDF4303931C
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 00:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B6F1DB356;
	Tue, 27 Jan 2026 00:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amHPgMvj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658A742AA6
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 00:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769474463; cv=none; b=DKXDAZIwBW/pHhTLXjRr4I6+Wcvru/GSWRd+cMO+Q3Gb/eZiaiU156e51hxWLR6RSLtHWrf1fSjjD++HFAyn4PvyeAg+TjOoHGRHpLUnQFhViHJPc0/5QJ0Rk61Bb/yS+qbm3Nb65nno0NxPQoLjH7nJxV0LYU0c7iux/PhyUyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769474463; c=relaxed/simple;
	bh=dtMq2dGqlL8iuDbPHgE+yg8+ta+2jgFx0lXwCi1sJLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5t5x2mzrch7qIWOKRPydJtHATompilumlfKZcYOyjgu/a6RSkeRQtgQ1Rrr91LVg/l2mNvWeFdLDURfbdFQaxX9xRx94Fz4wJVfLYk1WIrs3Sjc8mixokeGTBs8ogXdQFMBR0JzzOVJNriF1xa7mDAvpz22J7DUGNSpC+30jNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amHPgMvj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD50EC16AAE;
	Tue, 27 Jan 2026 00:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769474463;
	bh=dtMq2dGqlL8iuDbPHgE+yg8+ta+2jgFx0lXwCi1sJLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=amHPgMvjw6CwyQLu+V9jsG5c7pyu4QX0j8a+GP9muiPRJrHh9GC60/6nHhoxtscU8
	 r+aZgdg2QHrCzivJsePMI03Nc05C4mCnROWb6TbdWxfnoNxfQgcdf6Dgz8lFNT4z0T
	 ftQCrrq9z50slvQFvpk6eTz6FBeFGbOTJWANIAUBLYl/cixixaO+Ri/lXuxbNYJZMQ
	 sI2iNg8uIHUInJ2vI3q2cm1c8/2HGbVrKt5tEcIPZHnwkUUVcygDqZfnWPWlAnN2/j
	 juq/C8lXafcN4elHhrQ0DztJc07jEMHfqF2jJ/fh/ZvswAnG3yger7LwVRf6KzZvsW
	 Zi01OPNwmXOrQ==
From: Jakub Kicinski <kuba@kernel.org>
To: rmk+kernel@armlinux.org.uk
Cc: Jakub Kicinski <kuba@kernel.org>,
	linux-stm32@st-md-mailman.stormreply.com,
	andrew+netdev@lunn.ch,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	linux-rockchip@lists.infradead.org,
	heiko@sntech.de,
	alexandre.torgue@foss.st.com,
	andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com
Subject: Re: [net-next,v2,21/22] net: stmmac: rk: use rk_encode_wm16() for clock selection
Date: Mon, 26 Jan 2026 16:41:01 -0800
Message-ID: <20260127004101.3785871-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <E1vkL3N-00000005uuA-2GnK@rmk-PC.armlinux.org.uk>
References: <E1vkL3N-00000005uuA-2GnK@rmk-PC.armlinux.org.uk>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-253637-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: F19C68E86A
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: stmmac: rk: use rk_encode_wm16() for clock selection

This commit refactors the per-SoC set_clock_selection() method into
unified helper functions using rk_encode_wm16(), with mask-based
configuration stored in struct rk_clock_fields.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index 26fc93854cb0..443d3bd62cae 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c

[ ... ]

> @@ -1000,25 +991,23 @@ static const struct rk_gmac_ops rk3576_ops = {
>  #define RK3588_GMAC_CLK_RMII_MODE(id)		GRF_BIT(5 * (id))
>  #define RK3588_GMAC_CLK_RGMII_MODE(id)		GRF_CLR_BIT(5 * (id))
>
> -#define RK3588_GMAC_CLK_SELECT_CRU(id)		GRF_BIT(5 * (id) + 4)
> -#define RK3588_GMAC_CLK_SELECT_IO(id)		GRF_CLR_BIT(5 * (id) + 4)
> -
> -#define RK3588_GMAC_CLK_RMII_GATE(id)		GRF_BIT(5 * (id) + 1)
> -#define RK3588_GMAC_CLK_RMII_NOGATE(id)		GRF_CLR_BIT(5 * (id) + 1)
> -
>  static int rk3588_init(struct rk_priv_data *bsp_priv)
>  {
>  	switch (bsp_priv->id) {
>  	case 0:
>  		bsp_priv->gmac_phy_intf_sel_mask = GENMASK_U16(5, 3);
> +		bsp_priv->clock.io_clksel_cru_mask = BIT_U16(4);
>  		bsp_priv->clock.gmii_clk_sel_mask = GENMASK_U16(3, 2);
>  		bsp_priv->clock.rmii_clk_sel_mask = BIT_U16(2);
> +		bsp_priv->clock.rmii_gate_en_mask = BIT_U16(1);
>  		return 0;
>
>  	case 1:
>  		bsp_priv->gmac_phy_intf_sel_mask = GENMASK_U16(11, 9);
> +		bsp_priv->clock.io_clksel_cru_mask = BIT_U16(10);
                                                        ^^

Should this be BIT_U16(9) instead of BIT_U16(10)?

The removed macro RK3588_GMAC_CLK_SELECT_CRU(id) used the formula
GRF_BIT(5 * (id) + 4), which for id=1 gives 5*1+4 = bit 9.

The other masks for id=1 follow the 5*(id) pattern correctly:
  - rmii_gate_en_mask = BIT_U16(6)  matches 5*1+1 = 6
  - gmii_clk_sel_mask = GENMASK_U16(8, 7)  matches 5*1+{2,3}
  - rmii_clk_sel_mask = BIT_U16(7)

But io_clksel_cru_mask = BIT_U16(10) does not match 5*1+4 = 9.

>  		bsp_priv->clock.gmii_clk_sel_mask = GENMASK_U16(8, 7);
>  		bsp_priv->clock.rmii_clk_sel_mask = BIT_U16(7);
> +		bsp_priv->clock.rmii_gate_en_mask = BIT_U16(6);
>  		return 0;

[ ... ]

