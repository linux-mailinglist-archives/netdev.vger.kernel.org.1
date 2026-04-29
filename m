Return-Path: <netdev+bounces-282541-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NgcEEGS8mlhsgEAu9opvQ
	(envelope-from <netdev+bounces-282541-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 01:20:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B6549B531
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 01:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23F03301F300
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A5639A07B;
	Wed, 29 Apr 2026 23:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuYiimmp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EED39A058
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 23:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777504830; cv=none; b=jU2KxzMnrmTu7WxGiPHkYBtWzm6efCksNTrO3FvNEhSX/4eHW+uaKb/KCClFcWiktHG6yOqJ4f8QuFZrvqtYocMOeyVkZ5cpQllHw55OP9CvfHjhc5vZeqehDMBKQSLglw6dSBq+EOVeOBiDhFMQ2PTFVdj0vNCTFY+2c6zSTJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777504830; c=relaxed/simple;
	bh=8yUalhQiacb6ndI3FJHIMCDZWuNxlI1ZYXfnxLFHdEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfqco4v6VMJQQzfonCg8IIq4MWHR8tcp+5dGvEouLJhek+YRTB1ZWc9PBGICejIhhJKxLGYHv5xAmvzx8q0CL7SG1qee/3yT3O6iIQDR3d2X9v9dGzRqa67I0XhQdrXBKMUQUjHZTTyl6dlw21FzV8zWBOkuEIQPprJ98ToAk+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuYiimmp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4807C19425;
	Wed, 29 Apr 2026 23:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777504830;
	bh=8yUalhQiacb6ndI3FJHIMCDZWuNxlI1ZYXfnxLFHdEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NuYiimmpZAW/bW+COVr4zz51Aw8lz+TFGbnYQrh+DxCPkFqbG1V41pKwthn6+8KrU
	 I2RUlTcZhJvkqrMIa9AwVDZofaxQy1HzGdeePiejFscdPVZJN0w84Jlq+6hC2pxYYv
	 HmybF03YUbVyoNUVHTjZWixFXbqeop+uoL5Wn1ncoKEnwrwOmL0zVnOFBMFPt5vTJr
	 E/rg08Wkr94vIsdc4P++VO4YXAigXd7bfWGy3pnWXh8+kW3ew/OrliJcsITQVgWzSi
	 ZkclP2ptEBoH4oD/cL37LIVmOMWiXKrtXcpsjiDaBGB0S4pPVtbJ/+j8q6X7s+zfCm
	 Dbcj8jMbnb8nA==
From: Jakub Kicinski <kuba@kernel.org>
To: justin.chen@broadcom.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com
Subject: Re: [PATCH net-next 1/2] net: bcmasp: Divide init to allow partial bring up
Date: Wed, 29 Apr 2026 16:20:22 -0700
Message-ID: <20260429232021.2186988-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428220858.2076469-2-justin.chen@broadcom.com>
References: <20260428220858.2076469-2-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 95B6549B531
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282541-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email says "Blindly sending out since there will be a repost,
anyway."
---
net: bcmasp: Divide init to allow partial bring up

To prepare for a partial bring up of the interface during resume,
we break apart the bcmasp_netif_init() function into smaller chunks
that can be called as necessary.

> diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> index ec63f50a849e..aff0a6d84126 100644
> --- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
> +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
[ ... ]
> -static void umac_reset(struct bcmasp_intf *intf)
> +static void umac_reset_and_init(struct bcmasp_intf *intf,
> +				const unsigned char *addr)
>  {
> +	struct phy_device *phydev = intf->ndev->phydev;
> +	u32 mac0, mac1;
>  
>  	umac_wl(intf, 0x0, UMC_CMD);
>  	umac_wl(intf, UMC_CMD_SW_RESET, UMC_CMD);
>  	usleep_range(10, 100);
>  	/* We hold the umac in reset and bring it out of
>  	 * reset when phy link is up.
>  	 */
> -}
>  
> -static void umac_set_hw_addr(struct bcmasp_intf *intf,
> -			     const unsigned char *addr)
> -{
> -	u32 mac0 = (addr[0] << 24) | (addr[1] << 16) | (addr[2] << 8) |
> -		    addr[3];
> -	u32 mac1 = (addr[4] << 8) | addr[5];
> +	umac_wl(intf, 0x800, UMC_FRM_LEN);
> +	umac_wl(intf, 0xffff, UMC_PAUSE_CNTRL);
> +	umac_wl(intf, 0x800, UMC_RX_MAX_PKT_SZ);
> +
> +	mac0 = (addr[0] << 24) | (addr[1] << 16) | (addr[2] << 8) |
> +		addr[3];
> +	mac1 = (addr[4] << 8) | addr[5];
>  
>  	umac_wl(intf, mac0, UMC_MAC0);
>  	umac_wl(intf, mac1, UMC_MAC1);
> +
> +	/* Reset shadow values since we reset the umac */
> +	intf->old_duplex = -1;
> +	intf->old_link = -1;
> +	intf->old_pause = -1;
> +	phydev->eee_cfg.tx_lpi_timer = umac_rl(intf, UMC_EEE_LPI_TIMER);
>  }

Since UMC_CMD_SW_RESET was just asserted above, won't reading
UMC_EEE_LPI_TIMER here return 0 or a hardware default value, effectively
overwriting the bootloader-configured EEE TX LPI timer?

Also, since umac_reset_and_init() is now called unconditionally during
bcmasp_interface_resume(), does this dangerously overwrite
phydev->eee_cfg.tx_lpi_timer without holding mutex_lock(&phydev->lock)?
This seems like it could create a data race with concurrent accesses, for
example from ethtool.

[ ... ]
> +static void bcmasp_netif_init(struct net_device *dev)
> +{
> +	struct bcmasp_intf *intf = netdev_priv(dev);
>  
>  	bcmasp_init_tx(intf);
>  	netif_napi_add_tx(intf->ndev, &intf->tx_napi, bcmasp_tx_poll);

This existed prior to this patch, but since bcmasp_netif_init() and
bcmasp_netif_deinit() are called directly from bcmasp_interface_resume()
and bcmasp_interface_suspend() (which execute asynchronously without
rtnl_lock), can modifying the global dev->napi_list via netif_napi_add_tx()
and netif_napi_del() cause a race condition with concurrent list readers?

Suspend and resume paths typically rely on napi_enable() and napi_disable()
rather than adding and deleting the NAPI structures entirely.

[ ... ]
> @@ -1454,17 +1436,19 @@ int bcmasp_interface_resume(struct bcmasp_intf *intf)
>  	if (ret)
>  		return ret;
>  
> -	ret = bcmasp_netif_init(dev, false);
> -	if (ret)
> -		goto out;
> +	bcmasp_core_clock_set_intf(intf, true);
>  
>  	bcmasp_resume_from_wol(intf);
>  
> +	bcmasp_phy_hw_prepare(intf);
> +
> +	umac_reset_and_init(intf, dev->dev_addr);
> +

If Wake-on-LAN is disabled, bcmasp_interface_suspend() un-prepares the PHY
by asserting reset and disabling clocks. By calling bcmasp_resume_from_wol()
before bcmasp_phy_hw_prepare(), if EEE is enabled and invokes eee_fixup(),
won't the MDIO access timeout or cause a bus error because the PHY hardware
isn't prepared yet?

Additionally, won't any WOL state changes (like clearing
UMC_MPD_CTRL_MPD_EN) be immediately wiped out by the MAC software reset
inside the subsequent umac_reset_and_init() call?

I noticed this is fixed later in the series by commit 6994d859a69dd
(net: bcmasp: Keep PHY link during WoL sleep cycle), but does leaving it
like this here break bisection?

> +	bcmasp_netif_init(dev);
> +
> +	phy_start(dev->phydev);
> +
>  	netif_device_attach(dev);
>  
>  	return 0;
> -
> -out:
> -	clk_disable_unprepare(intf->parent->clk);
> -	return ret;
>  }
-- 
pw-bot: cr

