Return-Path: <netdev+bounces-253237-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPFXB26Wdml6SgEAu9opvQ
	(envelope-from <netdev+bounces-253237-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:17:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 669B082A7A
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 23:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1056230053C6
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 22:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B9D30C618;
	Sun, 25 Jan 2026 22:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhAo3cqi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C113330E0CB
	for <netdev@vger.kernel.org>; Sun, 25 Jan 2026 22:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769379392; cv=none; b=pvkRBfnlriV1V1hF7IOkNGZAJTQWsTRkAm0loBvH19kJLtt7W1U/M6LnQyZOWsPshySGqWD/5vfjz+LDLbQSzNIMJBrgaEvE+KwuioJBSRLLvMm14eka2C7vvRpQz3fv2Zz1f1zsPiMYmPaQB/nc4P1RUBIqNEYCZGRsxopaELc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769379392; c=relaxed/simple;
	bh=6tZOcoDzLjLZcLcPdF7/WrSy+zSdMZm9sx0zi040qLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qoDNtEQECXhy+h7BXJxYm97ST+86oy1fA6rsbIG0fSbgNgr1W536TyYDjPKX9/KQh879zHnWIs8tWDlzNuUo/MET3HlQ3LAyqN22sh0/aDCWbh+K3tqPZ5FRORCCRcY4HyhAiN/OfKU/G/xDBbOOAoUE1EhQelsD6iEujLcvwb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhAo3cqi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27ABFC19425;
	Sun, 25 Jan 2026 22:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769379392;
	bh=6tZOcoDzLjLZcLcPdF7/WrSy+zSdMZm9sx0zi040qLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mhAo3cqiV3m5SxW526CCIL5J+nR3v9o0BKXcdtdln/txsFUNcEtkPC9z86vdxHAHs
	 /j45rTwFWkBzTS6CTNz7S9PnQylV6tPQBA1wTY47zsmbFIHhyj+Ddm1/kq87McwBbH
	 UIjNYuWt+q5z7OSRQXXgWmOv9pxjoHLfCLA4iswiDqAyUbnaVqgVxD0tAP0CZgDZzE
	 nNlHu3drq4RpNMHdqAj3pNq2laOHJonC8+u5XfUA6LDEFW7bCAv680sTJXwKT7WZaC
	 5rYjAl9yw68Vy4lh6j5Cr9n4TkHYx6CU7H3mrViRLVGz1wBR9o35l2gBHx7U3UrlbP
	 l/fctiky0mCtQ==
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
Subject: Re: [net-next,18/21] net: stmmac: rk: rk3328: gmac2phy only supports RMII
Date: Sun, 25 Jan 2026 14:16:31 -0800
Message-ID: <20260125221631.3396200-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <E1vjEvF-00000005ghI-3CYC@rmk-PC.armlinux.org.uk>
References: <E1vjEvF-00000005ghI-3CYC@rmk-PC.armlinux.org.uk>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-253237-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 669B082A7A
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: stmmac: rk: rk3506, rk3528 and kk3588 have rmii_mode in clock register

This commit consolidates RMII mode configuration for rk3506, rk3528, and
rk3588 by adding a rmii_mode_mask field to rk_clock_fields, removing the
per-SoC set_to_rmii() functions, and adding common code in rk_gmac_powerup()
to write this field.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index ebbc09ea572a..759deb66ef2a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c

[ ... ]

> @@ -1412,6 +1385,15 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
>  			return ret;
>  	}

The code above (not shown in the diff, but present in the function) is:

    ret = rk_get_phy_intf_sel(bsp_priv->phy_iface);
    ...
    if (bsp_priv->gmac_phy_intf_sel_mask ||
        bsp_priv->gmac_rmii_mode_mask) {
        ...
        ret = regmap_write(bsp_priv->grf, bsp_priv->gmac_grf_reg, val);
        if (ret < 0)
            return ret;
    }

At this point, if the block above executed, ret holds the return value from
regmap_write() (0 on success), not the interface selector.

> +	if (bsp_priv->clock.rmii_mode_mask) {
> +		val = rk_encode_wm16(ret == PHY_INTF_SEL_RMII,
> +				     bsp_priv->clock.rmii_mode_mask);

For rk3588, both gmac_phy_intf_sel_mask and clock.rmii_mode_mask are set in
rk3588_init(). When the preceding block executes, it overwrites ret with
the regmap_write() return value. Then here, ret == PHY_INTF_SEL_RMII
compares 0 == 4 which is always false, so the rmii_mode bit will never be
set for rk3588 in RMII mode.

Should ret be saved before the preceding block so its original value
(the interface selector) can be used here?

> +
> +		ret = rk_write_clock_grf_reg(bsp_priv, val);
> +		if (ret < 0)
> +			return ret;
> +	}

[ ... ]

