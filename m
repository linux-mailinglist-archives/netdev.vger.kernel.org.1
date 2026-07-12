Return-Path: <netdev+bounces-306936-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aRmkMlBYU2oAaAMAu9opvQ
	(envelope-from <netdev+bounces-306936-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 11:03:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C061744395
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 11:03:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=o7dBrgpq;
	dmarc=pass (policy=reject) header.from=bootlin.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306936-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306936-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E44B6300B611
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 09:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B6039D3D3;
	Sun, 12 Jul 2026 09:03:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A0539A7F4;
	Sun, 12 Jul 2026 09:03:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783846990; cv=none; b=gzLBaqyeWILYS4UCkXFYKgLfuot3ow2wroTYmp/Kj2yPydkIQELs+eBK9S1x1gfyxBvXV83iGv+3SiRM54vkDYa4V8nHXv9hfIg/RlQlkt9Bgo2Ln73HDKw0dktUYGVsHGpR3HKLGM8i86HW2KXFFVSgas85EI6ZeFeIWn7Uzdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783846990; c=relaxed/simple;
	bh=Y5j23no5u2H1kbaTkS7wpoU9LyBJZUE/kmGQflwVAQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A6/LO2eJQn5xF+VVM5IU3WbGUb1OrciuCFzDyUr1BCk1NfCzliM6u7a8UOrjmH4Fs31ki9AHH8DJez7mM04tVUah+RG1xphEd/5GIKeSE+PwvwPUa74fbDC5GPsfmfxBA6jXo2KAS6TYb0+6l994LOWGRSasIpZA1eHCAX0VEjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o7dBrgpq; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D50FC1A0F80;
	Sun, 12 Jul 2026 09:03:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A7A0860341;
	Sun, 12 Jul 2026 09:03:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 80F5511BD39CB;
	Sun, 12 Jul 2026 11:02:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783846982; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=BzeV9M0n32gUOxgGqEtVDv99ZeZJFZbG23By9p8ZkjY=;
	b=o7dBrgpq5Pczd1+m6GDzkI6M5/IIRcSLO9ODKbpMQTkbcG6oayKsAQ6bhHML+EFnuN/qEk
	zMkehK63rgADVVmQHiX4qZXH2upDiMTZQJTe4BIc3VhWXQcPK8/M6LE5OJxVntj4WiFj1r
	bXHhLaYjzuG30T6QNzhqg7cn3WJSsl47jzBZwnDYJnb9eViIV3D3AK4WkDNnXx7itJ5fEx
	lZ6b579+cuLcvizdm9l39fzhMq0+16IOXjfIVBk6n2zOsCIr0+BTfiu10TenEa7ycoBcgw
	5os84svvlCXxgl0LopHE6IC0sFkWQobgsoeQzSb4LZwxVaXfORr/ieNP1GXzlA==
Message-ID: <bab33e22-b346-47d3-9b22-4646e68c6983@bootlin.com>
Date: Sun, 12 Jul 2026 11:02:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: stmmac: enable the MAC on link up for all
 supported speeds
To: vadik likholetov <vadikas@gmail.com>, netdev@vger.kernel.org
Cc: andrew@lunn.ch, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 thierry.reding@kernel.org, jonathanh@nvidia.com, vbhadram@nvidia.com,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260710120908.3731591-1-vadikas@gmail.com>
 <20260712065522.30241-1-vadikas@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260712065522.30241-1-vadikas@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306936-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:vadikas@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:thierry.reding@kernel.org,m:jonathanh@nvidia.com,m:vbhadram@nvidia.com,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,bootlin.com:from_mime,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C061744395

Hi,

When sending a new iteration, it should be a standalone thread, and not
a reply to the previous version. Patchwork seems to have picked it up, so
I _think_ it's ok for this one though :)

On 7/12/26 08:55, vadik likholetov wrote:
> stmmac_mac_link_down() clears the MAC's transmit and receive enable bits.
> stmmac_mac_link_up() is expected to set them again through
> stmmac_mac_set(..., true), but it first switches on the negotiated speed
> and returns early for a speed the switch does not list. The MAC is then
> left gated off.
> 
> The speed selection is split into three switches, keyed on the interface.
> The generic branch -- taken for everything that is neither USXGMII nor
> XLGMII, so including PHY_INTERFACE_MODE_10GBASER -- lists only SPEED_2500,
> SPEED_1000, SPEED_100 and SPEED_10.
> 
> MGBE on Tegra234 runs 10GBASE-R into an Aquantia AQR113C. That PHY does
> rate matching, so phylink_link_up() replaces the media speed with the
> MAC-side interface speed before calling into the MAC:
> 
> 	case RATE_MATCH_PAUSE:
> 		speed = phylink_interface_max_speed(link_state.interface);
> 		duplex = DUPLEX_FULL;
> 
> The driver is therefore called as
> 
> 	stmmac_mac_link_up(interface=10GBASER, speed=10000, duplex=1)
> 
> which falls through to "default: return;". The interface stops passing
> traffic after the first link flap.
> 
> The failure is easy to misread. The link still comes up, because the PHY
> is polled over MDIO and needs no MAC, so the interface reports carrier 1
> at the media speed. The DMA is untouched, so its start bits stay set and
> descriptors are still consumed. Only the MAC itself is gated off: the
> receiver counts nothing (mmc_rx_framecount_gb stops advancing, RE is 0)
> and nothing reaches the wire (TE is 0). The interface survives boot only
> because stmmac_hw_setup(), called from ndo_open, enables the MAC
> unconditionally -- so the problem appears only once the cable has been
> unplugged and plugged back in, and "ip link set dev <ethX> down && ip
> link set dev <ethX> up" appears to fix it.
> 
> The interface is not what the speed bits depend on: with the single
> exception of 2.5G, which is selected through the XGMII block on USXGMII
> and through the regular speed bits otherwise, each speed maps to one
> field of struct mac_link. The per-interface switches are speed
> validation, and phylink already validates the speed against
> priv->hw->link.caps. So collapse the three switches into one keyed on the
> speed alone, keeping the interface test only for the 2.5G case. This
> covers 10G on 10GBASE-R, and equally 5G, and 1G/100/10 on USXGMII, all of
> which hit "default: return;" today.
> 
> A core that does not support a speed leaves the corresponding mac_link
> field at 0, and phylink will not offer it that speed in the first place.
> For dwxgmac2 at 10G, link.xgmii.speed10000 is XGMAC_CONFIG_SS_10000,
> which is 0 and is the correct speed selection for a 10GBASE-R MAC: ctrl
> then equals old_ctrl, the register write is skipped, and execution
> reaches stmmac_mac_set(..., true).
> 
> Log an error in the default case, since a speed with no entry here leaves
> the MAC disabled and the symptom does not point at the cause.
> 
> Fixes: d8ca113724e7 ("net: stmmac: tegra: Add MGBE support")
> Suggested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Signed-off-by: vadik likholetov <vadikas@gmail.com>
> ---
> v2:
>  - Collapse the three per-interface switches into a single switch on the
>    speed, rather than adding SPEED_10000 to the generic branch, which
>    left SPEED_5000 and the USXGMII sub-1G speeds broken (Maxime).
>  - netdev_err() in the default case (Andrew).
> 
> Fixes tag: the missing speeds predate the commit cited above. I picked
> d8ca113724e7 because MGBE is the first in-tree user to reach it -- it
> needs a 10GBASE-R interface driven by a rate-matching PHY, so that
> phylink hands the MAC a 10G speed. Happy to re-target it.
> 
> Verified on an AGX Orin devkit (Tegra234 MGBE0 + AQR113C), before and
> after, on the same board and cable. MAC registers read with `ethtool -d`,
> after a physical unplug and replug:
> 
>   stock		MAC_TX_CONFIG 0x00010000 (TE=0)
> 		MAC_RX_CONFIG 0x3ff022c0 (RE=0)
> 		rx_packets frozen, DHCP lease lost
> 
>   patched	MAC_TX_CONFIG 0x00010001 (TE=1)
> 		MAC_RX_CONFIG 0x3ff022c1 (RE=1)
> 		rx_packets keeps climbing, DHCP lease retained
> 
> Only the 10GBASE-R path is covered by hardware here; the other speeds are
> by inspection. Testing was done with MGBE0 handed to a VM via
> vfio-platform, so the driver ran in a guest; the MAC register evidence
> above is read from the device itself and the code path is not
> virtualisation-specific.
> 
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c | 92 ++++++++-----------
>  1 file changed, 37 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 2a0d7eff8..fa9f88e51 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1083,63 +1083,45 @@ static void stmmac_mac_link_up(struct phylink_config *config,
>  	old_ctrl = readl(priv->ioaddr + MAC_CTRL_REG);
>  	ctrl = old_ctrl & ~priv->hw->link.speed_mask;
>  
> -	if (interface == PHY_INTERFACE_MODE_USXGMII) {
> -		switch (speed) {
> -		case SPEED_10000:
> -			ctrl |= priv->hw->link.xgmii.speed10000;
> -			break;
> -		case SPEED_5000:
> -			ctrl |= priv->hw->link.xgmii.speed5000;
> -			break;
> -		case SPEED_2500:
> +	switch (speed) {
> +	case SPEED_100000:
> +		ctrl |= priv->hw->link.xlgmii.speed100000;
> +		break;
> +	case SPEED_50000:
> +		ctrl |= priv->hw->link.xlgmii.speed50000;
> +		break;
> +	case SPEED_40000:
> +		ctrl |= priv->hw->link.xlgmii.speed40000;
> +		break;
> +	case SPEED_25000:
> +		ctrl |= priv->hw->link.xlgmii.speed25000;
> +		break;
> +	case SPEED_10000:
> +		ctrl |= priv->hw->link.xgmii.speed10000;
> +		break;
> +	case SPEED_5000:
> +		ctrl |= priv->hw->link.xgmii.speed5000;
> +		break;
> +	case SPEED_2500:
> +		if (interface == PHY_INTERFACE_MODE_USXGMII)
>  			ctrl |= priv->hw->link.xgmii.speed2500;
> -			break;
> -		default:
> -			return;
> -		}
> -	} else if (interface == PHY_INTERFACE_MODE_XLGMII) {
> -		switch (speed) {
> -		case SPEED_100000:
> -			ctrl |= priv->hw->link.xlgmii.speed100000;
> -			break;
> -		case SPEED_50000:
> -			ctrl |= priv->hw->link.xlgmii.speed50000;
> -			break;
> -		case SPEED_40000:
> -			ctrl |= priv->hw->link.xlgmii.speed40000;
> -			break;
> -		case SPEED_25000:
> -			ctrl |= priv->hw->link.xlgmii.speed25000;
> -			break;
> -		case SPEED_10000:
> -			ctrl |= priv->hw->link.xgmii.speed10000;
> -			break;
> -		case SPEED_2500:
> -			ctrl |= priv->hw->link.speed2500;
> -			break;
> -		case SPEED_1000:
> -			ctrl |= priv->hw->link.speed1000;
> -			break;
> -		default:
> -			return;
> -		}
> -	} else {
> -		switch (speed) {
> -		case SPEED_2500:
> +		else
>  			ctrl |= priv->hw->link.speed2500;
> -			break;
> -		case SPEED_1000:
> -			ctrl |= priv->hw->link.speed1000;
> -			break;
> -		case SPEED_100:
> -			ctrl |= priv->hw->link.speed100;
> -			break;
> -		case SPEED_10:
> -			ctrl |= priv->hw->link.speed10;
> -			break;
> -		default:
> -			return;
> -		}
> +		break;
> +	case SPEED_1000:
> +		ctrl |= priv->hw->link.speed1000;
> +		break;
> +	case SPEED_100:
> +		ctrl |= priv->hw->link.speed100;
> +		break;
> +	case SPEED_10:
> +		ctrl |= priv->hw->link.speed10;
> +		break;
> +	default:
> +		netdev_err(priv->dev,
> +			   "unsupported speed %d on %s, leaving the MAC disabled\n",
> +			   speed, phy_modes(interface));

You should probably be using phy_speed_to_str() to print the speed.

Thanks,

Maxime


