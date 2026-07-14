Return-Path: <netdev+bounces-307600-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EwXnCLutVmo4AAEAu9opvQ
	(envelope-from <netdev+bounces-307600-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 23:44:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6BB759084
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 23:44:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=WxqRDjeE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307600-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307600-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20BE830D1094
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 21:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B84F429CE8;
	Tue, 14 Jul 2026 21:43:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C541F41E6BE;
	Tue, 14 Jul 2026 21:43:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784065434; cv=none; b=Yc3zCz8bU6vXiDYuU3IlO4ANbivsIS4+3YIsnlk83BLu/EHpRIN5sal21AMUdxUhEVrSLW0ShANUE/MQ76Yrgil7TCqgf30hCBeA85gIoXL2aYP2ArRB/zBGLDLVzjzF30vHzeQFm6XB7EXLAldPJC45pMms3LMF+GmvogbgazA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784065434; c=relaxed/simple;
	bh=tv5yR270+dO2Aef8XqKmJwA5kQ3pZ5hPr4+H/U/i2/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNvXbYpYE3U/lPqVxTNRYUpzBPyIQzryQzp09O6F5/RZxSDxAa8k3eDw+UU4uLqN0F56j6av2/xelkhV+d2za8hgQOUMiZAjNYeiazhNdP6eTvY0EUFKOOm/Ej/h+ntsjKfssNekmowaTxIx0tXm1eOf5bT3HZ65IehVwWxT4XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WxqRDjeE; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PmPupBSM6VPPCXEyQZIAkhab3lhx7i3VQEtooc2tVrA=; b=WxqRDjeElpWED4AuGh2rXtxqoJ
	lq+1Q1t6hGh9mTNEZjJKOE5f2MO1CIybO9Ga2kdMppiZRNILrfLCcajNv+4RJpm90w8vGm45hyVKe
	O8qjc9zFj+Mrah2vrNhOtXlQbcIN69AVSJlaxYdUnxh55dPpvEkZpqazs+ZloWtSCkY8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wjkul-00CFqr-Pl; Tue, 14 Jul 2026 23:43:43 +0200
Date: Tue, 14 Jul 2026 23:43:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: Frank.Sae@motor-comm.com, hkallweit1@gmail.com, linux@armlinux.org.uk,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, jianmin.wang@motor-comm.com,
	ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
	jie.han@motor-comm.com
Subject: Re: [PATCH] net: phy: Add driver for Motorcomm Quad 2.5GbE phy
Message-ID: <a0e43216-d215-4c81-9954-c5e497b2d50f@lunn.ch>
References: <20260714111203.3852126-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714111203.3852126-1-kyle.switch@motor-comm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307600-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kyle.switch@motor-comm.com,m:Frank.Sae@motor-comm.com,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianmin.wang@motor-comm.com,m:ming.xu@motor-comm.com,m:xiaolin.xu@motor-comm.com,m:jie.han@motor-comm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[motor-comm.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:from_mime,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6A6BB759084

On Tue, Jul 14, 2026 at 07:12:03PM +0800, Kyle Switch wrote:
> Add a driver for motorcomm yt8824 quad 2.5G ethernet phy, supports
> 2.5G/1000M/100M/10M speed.

Please take a read of:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

and set the Subject line correctly.

> +#define REG_MII_MMD_CTRL			0x0D
> +#define REG_MII_MMD_DATA			0x0E

include/uapi/linux/mii.h

#define	MII_MMD_CTRL		0x0d	/* MMD Access Control Register */
#define	MII_MMD_DATA		0x0e	/* MMD Access Data Register */

Please don't repeat something which already exists. But i also wounder
why you need these.

> +static int ytphy_write_mmd(struct phy_device *phydev,
> +			   u16 device, u16 reg,
> +			   u16 value)
> +{
> +	int ret;
> +
> +	ret = __phy_write(phydev, REG_MII_MMD_CTRL, device);
> +	if (ret)
> +		return ret;
> +	ret = __phy_write(phydev, REG_MII_MMD_DATA, reg);
> +	if (ret)
> +		return ret;
> +	ret = __phy_write(phydev, REG_MII_MMD_CTRL, device | 0x4000);
> +	if (ret)
> +		return ret;
> +	ret = __phy_write(phydev, REG_MII_MMD_DATA, value);
> +
> +	return ret;
> +}

Why are you reinventing these functions when they already exist?

> +
>  /**
>   * ytphy_get_wol() - report whether wake-on-lan is enabled
>   * @phydev: a pointer to a &struct phy_device
> @@ -3059,99 +3187,1620 @@ static int yt8821_resume(struct phy_device *phydev)
>  	return yt8821_modify_utp_fiber_bmcr(phydev, BMCR_PDOWN, 0);
>  }
>  
> -static struct phy_driver motorcomm_phy_drvs[] = {
> -	{
> -		PHY_ID_MATCH_EXACT(PHY_ID_YT8511),
> -		.name		= "YT8511 Gigabit Ethernet",
> -		.config_init	= yt8511_config_init,
> -		.suspend	= genphy_suspend,
> -		.resume		= genphy_resume,
> -		.read_page	= yt8511_read_page,
> -		.write_page	= yt8511_write_page,
> -	},
> -	{
> -		PHY_ID_MATCH_EXACT(PHY_ID_YT8521),
> -		.name		= "YT8521 Gigabit Ethernet",
> -		.get_features	= yt8521_get_features,
> -		.probe		= yt8521_probe,

Why are these all stoppering? diff would not remove them unless
something is changing.


    Andrew

---
pw-bot: cr

