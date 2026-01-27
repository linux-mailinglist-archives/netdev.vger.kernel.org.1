Return-Path: <netdev+bounces-253635-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPTVJqcJeGk2ngEAu9opvQ
	(envelope-from <netdev+bounces-253635-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 01:41:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8378E854
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 01:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B9B530300E8
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 00:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7528A1DE887;
	Tue, 27 Jan 2026 00:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFVT0ozS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5363542AA6
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 00:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769474460; cv=none; b=oQIkH7H3dvICioPvE0VmHFsGYqGy6TvRIPo32JzUA0eR4k26fQWh+kbVBOxCaVdpaWIiX0vSncLe78KCVZ5MsphEfhgCcC4gJ0yw0xYGBTQd3egNyT5p0zl1YW9SMIivgjJDEUwUEpVUSWN18iF1kG1qLdx3yXA1vAsTkobpNHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769474460; c=relaxed/simple;
	bh=gyfB6CxCcjmjjILeS0ZovfjbSMTZXSuR0XjS5SBThoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=feahHh9MGAALlT5e5YERpv+ifpCxCLkERW2zzJfjKa5evIml1q7lB7eRfyXV8+Xa9R36bIuLzSDiK64RGp7LKiZlxCVt6wkYJcEua+qlFORHnyw4JdwlyxgUSPu0CDhBbT9ybFRRvT3RMrI1nlWO6P+9mHk17HaX3kVBwUo4tSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFVT0ozS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A547C116C6;
	Tue, 27 Jan 2026 00:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769474459;
	bh=gyfB6CxCcjmjjILeS0ZovfjbSMTZXSuR0XjS5SBThoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UFVT0ozS7FgYPwaFDGZ2cfWG/YY0qi0V4LPQU40c0jX9fImWwrtpWlxdnt49l6rRY
	 IfaHAQPPFc2RZ3JGvCuM6tTpBHcmYxktxedE/mHEKiddEqF+eze1T163nqc3edvZr9
	 tLFBLabXkQx/jpHgkNRSyWj5bNQCdae0z82Fe82+jD/f2IAHUA316GeuWuXskcT1Ka
	 Uog7VArapPEvIuXcXCR2XDRq+qr9Jeo30IMKCFiMSveEG4V5hM3ORrzG3GYjYOomrC
	 tq7dKlnF8YodLJXlXUGc0LR18mW/bZZqglo4aEp9xO68iBwamtVrN1jdqfTM92wHjT
	 L5XbbISIqMQbw==
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
Subject: Re: [net-next,v2,07/22] net: stmmac: rk: convert to mask-based interface mode configuration
Date: Mon, 26 Jan 2026 16:40:57 -0800
Message-ID: <20260127004057.3785761-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <E1vkL2D-00000005uso-3W6y@rmk-PC.armlinux.org.uk>
References: <E1vkL2D-00000005uso-3W6y@rmk-PC.armlinux.org.uk>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-253635-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D8378E854
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: stmmac: rk: convert to mask-based interface mode configuration

This commit consolidates PHY interface mode configuration into common
infrastructure by introducing mask fields for phy_intf_sel and rmii_mode,
moving the register writes from SoC-specific functions into the common
rk_gmac_powerup() function.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index 4117f6863ff0..35836ffdfc1d 100644

[ ... ]

> @@ -1654,7 +1685,9 @@ static int rk_gmac_check_ops(struct rk_priv_data *bsp_priv)
>  static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
>  {
>  	struct device *dev = bsp_priv->dev;
> +	u32 val;
>  	int ret;
> +	u8 intf;
>
>  	ret = rk_gmac_check_ops(bsp_priv);
>  	if (ret)
> @@ -1664,6 +1697,26 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
>  	if (ret)
>  		return ret;
>
> +	ret = rk_get_phy_intf_sel(bsp_priv->phy_iface);
> +	if (ret < 0)
> +		return ret;

Should this error path call gmac_clk_enable(bsp_priv, false) before
returning? The clocks were enabled just above, and the existing error
handling for rk_phy_powerup() later in this function disables the
clocks on failure:

    ret = rk_phy_powerup(bsp_priv);
    if (ret) {
        gmac_clk_enable(bsp_priv, false);
        return ret;
    }

> +
> +	intf = ret;
> +
> +	if (bsp_priv->gmac_phy_intf_sel_mask ||
> +	    bsp_priv->gmac_rmii_mode_mask) {
> +		/* If defined, encode the phy_intf_sel value */
> +		val = rk_encode_wm16(intf, bsp_priv->gmac_phy_intf_sel_mask);
> +
> +		/* If defined, encode the RMII mode mask setting. */
> +		val |= rk_encode_wm16(intf == PHY_INTF_SEL_RMII,
> +				      bsp_priv->gmac_rmii_mode_mask);
> +
> +		ret = regmap_write(bsp_priv->grf, bsp_priv->gmac_grf_reg, val);
> +		if (ret < 0)
> +			return ret;

Same question here - should this also disable clocks before returning?

> +	}

