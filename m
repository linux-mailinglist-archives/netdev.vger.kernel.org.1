Return-Path: <netdev+bounces-253239-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMn8IoSWdml6SgEAu9opvQ
	(envelope-from <netdev+bounces-253239-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:17:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D63A982A82
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95DC7301876D
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B374830E829;
	Sun, 25 Jan 2026 22:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="px5R/rXq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918571DDC3F
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 22:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769379396; cv=none; b=FbIZcPUoLmziQ0qC63pOV423THAMp9l7N7++8QVWCFNkhWRqRwB6kuRM9+nyf7fb36MVQZwag6NRFSFuXtlCjtRT9FcLNvNLYUbE0I9B+QUJJKE1JjCB0sWRAEimZrCmOOI6vY5S5lW5d8+LFABCF1lxmCaNVUddyZEcHObQXOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769379396; c=relaxed/simple;
	bh=E8R/DJ/ZbtKTHps96zcRomj23PE6yMett5iGgHXATgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mKh+nq0ImjEIDW9VddQeX0vW8E/gF0q6fRe3r7KWUsokX5fo8VepYlPcce/ibicqTV2N+iy+abl4/mbO6tL+j2ucoMLd4gO8eJJWIa+j4zhMOSP2MbE84sqcx0/SgpfNXCWGgHZXMHxIge/mAFdYMF1ZiKTewiHwtcV0NVeu5wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=px5R/rXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18A6C4CEF1;
	Sun, 25 Jan 2026 22:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769379396;
	bh=E8R/DJ/ZbtKTHps96zcRomj23PE6yMett5iGgHXATgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=px5R/rXqCwz2QVbI/14rOI9OYcyDWK9WeJQ71v8yaGRyq4uUo7bfAXPy+adHh2aIK
	 e5i+8zYDRoNIgvKowNezzV3pH+nEwgf/fNQn+qmcCk9Q9rGxuX7yBrx22VeXFSAuuh
	 WSkkKeJ4xs664gJ/VDCGQhO3WTOSbhw3+6h4EHOCFYF7xS/fIlqcV4LWexh+gTHWfs
	 33QdoyfZW303ADs3czHpKmd2jKtA0lR2yKlc7sOIarhPzTSv2u383TV/wvROk9ml6Y
	 xj/thP1HuC/aitZxgKUW+JovDB3748F+t4brtT7v0MIk5cs9DBDHwS/ZQk2ePSSub2
	 eLrinl8J6O3ww==
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
Subject: Re: [net-next,20/21] net: stmmac: rk: use rk_encode_wm16() for clock selection
Date: Sun, 25 Jan 2026 14:16:34 -0800
Message-ID: <20260125221634.3396295-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <E1vjEvQ-00000005ghV-07C8@rmk-PC.armlinux.org.uk>
References: <E1vjEvQ-00000005ghV-07C8@rmk-PC.armlinux.org.uk>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-253239-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: D63A982A82
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: stmmac: rk: rk3506, rk3528 and kk3588 have rmii_mode in clock register

This patch adds an rmii_mode_mask field to struct rk_clock_fields to handle
RMII mode configuration in the clock GRF register. It removes the SoC-specific
set_to_rmii() functions for rk3506, rk3528, and rk3588, replacing them with a
generic mechanism in rk_gmac_powerup().

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index ebbc09ea572a..759deb66ef2a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c

[ ... ]

> @@ -1412,6 +1385,15 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
>  			return ret;
>  	}
>
> +	if (bsp_priv->clock.rmii_mode_mask) {
> +		val = rk_encode_wm16(ret == PHY_INTF_SEL_RMII,
> +				     bsp_priv->clock.rmii_mode_mask);

Is this comparison using the correct value? Earlier in rk_gmac_powerup(), the
variable ret is assigned the return value from rk_get_phy_intf_sel(), which is
PHY_INTF_SEL_RGMII (0) or PHY_INTF_SEL_RMII (1).

However, for SoCs that have gmac_phy_intf_sel_mask set (such as rk3588), the
code enters the preceding if block:

    if (bsp_priv->gmac_phy_intf_sel_mask || bsp_priv->gmac_rmii_mode_mask) {
        ...
        ret = regmap_write(bsp_priv->grf, bsp_priv->gmac_grf_reg, val);
        ...
    }

After this block, ret has been overwritten with the regmap_write() return
value (0 on success). When the rmii_mode_mask block executes, the comparison
ret == PHY_INTF_SEL_RMII becomes 0 == 1, which is always false.

This means for rk3588 in RMII mode, the rmii_mode bit in the clock register
will be cleared (RGMII mode) instead of set. Would it be better to save the
PHY interface selection value in a separate variable before it gets
overwritten?

> +
> +		ret = rk_write_clock_grf_reg(bsp_priv, val);
> +		if (ret < 0)
> +			return ret;
> +	}

