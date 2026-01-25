Return-Path: <netdev+bounces-253236-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mN8VLGGWdml6SgEAu9opvQ
	(envelope-from <netdev+bounces-253236-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:17:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A80C82A73
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5A6D3004232
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8511F30DEDC;
	Sun, 25 Jan 2026 22:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXjfi6Dj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E53175D53
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 22:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769379391; cv=none; b=oKjfXlWzLOvEXsAY2jFSGxrQrJQcqpwDVntPuYLHvsBlsE8jNpBo3ZA2Totp9s9JcGrO7yiVLL+r2m5SwqXYglYiSKsldWq8MBWnT5br47cxmUQMx0LBZn0TFaUp4uChpr+1gaEXg1rv22M0sZ3VDnQgPT/+iRHep++AIYETMZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769379391; c=relaxed/simple;
	bh=f3JOuPvjWSkZ5OMkpcZPMBzYMykOzPVsEuZRDZjmfrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d69rt6usySXWH9W9XbqOiKedM+cYFhoFdz+4tRh1Fh9KhvmleBIURPFZzU69Ly5tOHA+jBc3PqdqrZWz5dMcJnOc5dotpdU9CJy1CbROPvZjmR3KTFontGqhmBmo1UeB/UJ2h068Mxm5ITMTW6SLMXsERJin3DcLuVmk+jWzGWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXjfi6Dj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC34C2BC86;
	Sun, 25 Jan 2026 22:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769379391;
	bh=f3JOuPvjWSkZ5OMkpcZPMBzYMykOzPVsEuZRDZjmfrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nXjfi6DjXDT+vEwmrnTDrefeneyQCEW+WZwgmEKzn38xGlSOO+2cmjTFNuwg4R603
	 12t5u2HmnuowyrtWuCvDdWJDMnDl49qtRdVLCjTOjOukCdCcjCrrKM68vD1RoFyzFI
	 bOwW9u0mSjkmJq5j4A4PhChil8zodhleWEavBL0NERPAwqPS8n/yKfLAadL/lzzPRG
	 7VQyrV0OniqAL9ep3Mm1KWlS2em+XkTeKGIh9gh20VZXfTPZKbI0QZ0QZqo0S8n+8M
	 8R44ka8/76H+Q6kWJtih6ovCy4DUZDybt3XOjBoCN1e3oaMnn5McaCxkI+kA17o3w2
	 ucZB241H8e4jQ==
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
Subject: Re: [net-next,17/21] net: stmmac: rk: replace empty set_to_rmii() with supports_rmii
Date: Sun, 25 Jan 2026 14:16:29 -0800
Message-ID: <20260125221629.3396169-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <E1vjEvA-00000005ghD-2i2t@rmk-PC.armlinux.org.uk>
References: <E1vjEvA-00000005ghD-2i2t@rmk-PC.armlinux.org.uk>
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
	TAGGED_FROM(0.00)[bounces-253236-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A80C82A73
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: stmmac: rk: rk3506, rk3528 and kk3588 have rmii_mode in clock register

This patch consolidates RMII mode configuration for rk3506, rk3528, and
rk3588 by moving the rmii_mode bit writes from per-SoC set_to_rmii()
functions into a centralized block in rk_gmac_powerup().

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index ebbc09ea572a..759deb66ef2a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c

[ ... ]

> @@ -1412,6 +1385,15 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
> 			return ret;
> 	}

The context above this hunk is relevant. Earlier in rk_gmac_powerup():

    ret = rk_get_phy_intf_sel(bsp_priv->phy_iface);
    ...
    if (bsp_priv->gmac_phy_intf_sel_mask ||
        bsp_priv->gmac_rmii_mode_mask) {
        ...
        ret = regmap_write(bsp_priv->grf, bsp_priv->gmac_grf_reg, val);
        ...
    }

At this point, if the first if-block executed, ret has been overwritten by
regmap_write() and will be 0 on success.

> +	if (bsp_priv->clock.rmii_mode_mask) {
> +		val = rk_encode_wm16(ret == PHY_INTF_SEL_RMII,
> +				     bsp_priv->clock.rmii_mode_mask);

For RK3588, both gmac_phy_intf_sel_mask and clock.rmii_mode_mask are set.
The first if-block will execute and overwrite ret with the regmap_write()
return value (0 on success).

When this second if-block runs, ret will be 0 rather than the original
PHY_INTF_SEL_RMII value (which is 4). This means ret == PHY_INTF_SEL_RMII
will always evaluate to false for RK3588, causing the rmii_mode bit to be
cleared instead of set when RMII mode is configured.

Should ret be saved before the first if-block and restored here, or should
a separate variable hold the phy interface selection?

> +
> +		ret = rk_write_clock_grf_reg(bsp_priv, val);
> +		if (ret < 0)
> +			return ret;
> +	}

[ ... ]

