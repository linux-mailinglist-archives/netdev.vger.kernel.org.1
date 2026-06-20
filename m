Return-Path: <netdev+bounces-300824-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l+NjOii0NmpODgcAu9opvQ
	(envelope-from <netdev+bounces-300824-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 17:39:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5326A9215
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 17:39:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=jByZMLtQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300824-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300824-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17993300AB28
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 15:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5CC3B1B4;
	Sat, 20 Jun 2026 15:39:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C605846F;
	Sat, 20 Jun 2026 15:39:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781969958; cv=none; b=qXibxE21c0wQFZXb0Gcdc6Km601LKoEoGdhkFmmefHf/mKt5yWcu93JuRPbHHOiqEH5pmTJzLi2H6s8N2UvkWRYq6JU/o7aElhBduCendVVncdgciTKYEtdXn8vm0ZOuC/8peS6RZ1fLqvqjSbFAkDDsTNUBynQp5Bg2iE9YlZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781969958; c=relaxed/simple;
	bh=Oql8fv3mFJtUrXq7QayK6tyFulBHq6855VeskzWzCI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uwQymxg8r0VXc93/zBOfNMiG0FABqv2R1g47YM4GqoSApB2cG98KeSaFaasqwuo5xaUtU/jM+AB7iuWFco7u7BX65lOdJTWGLsef7YdomtjjQgC0SoMwqs1dyj5eCqbZMm+D/4YEr/jHN7Jacj8+uSpgVe7L9CjJPcJWLFPgofU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jByZMLtQ; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 81263C653F5;
	Sat, 20 Jun 2026 15:39:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0E222601B7;
	Sat, 20 Jun 2026 15:39:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2A763106C88F0;
	Sat, 20 Jun 2026 17:39:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781969952; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=WcvKsOadaZ5TWyzFgIVzgmz4m6DJ/Dw1ihvYTIWU4AI=;
	b=jByZMLtQxxnUOXnc5AVtkUBcl3Dvez7uo/i2SjpJuvLwSMdM4DaYuktJaNcr/irTel0fn/
	VEj7SjLUSw4LnczBHbNaMfb1kxkDPR45qB/VvZXAekOW1qxtXJd7NC7yBHrHlRl1CI/At1
	NSXEjFlCLsawA3Mh8V6uhljWGpMBrsbKl7zhA2xQ3psLx1zK2j5VpPISnRLSKtpTWvXFa2
	FWhuZfvHTXXWUI6sU4/B2PEr+5Kwz+Krp/j3dhLixi/FRe9ptGtPWTT2/XUS66s4gWVu0A
	ZI/AgfyekNQUWyNITvszm/xgMBBVKlWDdm55ravToDnUpm/w6vLicS13YxzoSg==
Message-ID: <54769f58-ac83-4c5b-bd0d-3c0e83c1ab31@bootlin.com>
Date: Sat, 20 Jun 2026 17:39:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: phylink: print correct c45 phy id when missing
 PHY driver
To: Aleksander Jan Bajkowski <olek2@wp.pl>, linux@armlinux.org.uk,
 andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 rmk+kernel@armlinux.org.uk, vladimir.oltean@nxp.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260620131130.949298-1-olek2@wp.pl>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260620131130.949298-1-olek2@wp.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300824-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[wp.pl,armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nxp.com,vger.kernel.org];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:olek2@wp.pl,m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:vladimir.oltean@nxp.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,wp.pl:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E5326A9215

Hi Aleksander,

On 6/20/26 15:11, Aleksander Jan Bajkowski wrote:
> If no PHY driver is found, `phy_id` is returned. `phy_id` holds the c22 ID.
> Modules with a rollball bridge support only c45 transfers. The c45 IDs are
> stored in the `c45_ids` structure. In the current code these modules report
> an ID 0x00000000. This may lead users to mistakenly conclude that the
> rollball bridge isn't properly implemented in their SFP module. This patch
> fixes the wrong IDs for c45 modules when a driver cannot be found.
> 
> Tested on Fiberstore SFP-GB-BE-T (C22) and ONTi ONT-C1TE-R05 (Rollball).
> 
> Before:
> [ 2440.373985] mtk_soc_eth 15100000.ethernet sfp-lan: PHY i2c:sfp2:11 (id 0x00000000) has no driver loaded
> [ 2440.383385] mtk_soc_eth 15100000.ethernet sfp-lan: Drivers which handle known common cases: CONFIG_BCM84881_PHY, CONFIG_MARVELL_PHY
> [ 2440.395274] sfp sfp2: sfp_add_phy failed: -EINVAL
> 
> After:
> [   82.573700] mtk_soc_eth 15100000.ethernet sfp-lan: PHY i2c:sfp2:11 (id 0x001cc898) has no driver loaded
> [   82.583098] mtk_soc_eth 15100000.ethernet sfp-lan: Drivers which handle known common cases: CONFIG_BCM84881_PHY, CONFIG_MARVELL_PHY
> [   82.594996] sfp sfp2: sfp_add_phy failed: -EINVAL
> 
> Fixes: ffcbfb5f9779 ("net: phylink: improve phylink_sfp_config_phy() error message with missing PHY driver")
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>

TBH I'm not convinced this counts as a net-worthy fix, I'd send that
to net-next when it reopens instead. Sure this is useful debug info,
but when you hit that error message you're already in for some digging
around in the code/config :)

> ---
>  drivers/net/phy/phylink.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> index 087ac63f9193..7d7595158bf9 100644
> --- a/drivers/net/phy/phylink.c
> +++ b/drivers/net/phy/phylink.c
> @@ -3917,13 +3917,30 @@ static void phylink_sfp_link_up(void *upstream)
>  	phylink_enable_and_run_resolve(pl, PHYLINK_DISABLE_LINK);
>  }
>  
> +static u32 phylink_get_phy_id(struct phy_device *phy)
> +{
> +	if (phy->is_c45) {
> +		const int num_ids = ARRAY_SIZE(phy->c45_ids.device_ids);
> +		int i;
> +
> +		for (i = 1; i < num_ids; i++) {
> +			if (phy->c45_ids.mmds_present & BIT(i))
> +				return (phy->c45_ids.device_ids[i]);
> +		}
> +
> +		return 0;
> +	} else {
> +		return phy->phy_id;
> +	}
> +}

The function name is misleading, you don't really get the id, you get either
the c22 id or the first non-zero C45 id.

> +
>  static int phylink_sfp_connect_phy(void *upstream, struct phy_device *phy)
>  {
>  	struct phylink *pl = upstream;
>  
>  	if (!phy->drv) {
> -		phylink_err(pl, "PHY %s (id 0x%.8lx) has no driver loaded\n",
> -			    phydev_name(phy), (unsigned long)phy->phy_id);
> +		phylink_err(pl, "PHY %s (id 0x%.8x) has no driver loaded\n",

Why change the printk format from 0x%.8lx to 0x%.8x ?

> +			    phydev_name(phy), phylink_get_phy_id(phy));
>  		phylink_err(pl, "Drivers which handle known common cases: CONFIG_BCM84881_PHY, CONFIG_MARVELL_PHY\n");
>  		return -EINVAL;
>  	}


After reading all that, I'm actually not really convinced the overall patch
is the best approach. It's a lot of logic for a very niche case. This is really for
debug purposes, so why not instead print either the phy_id for a C22 PHY, or
just "C45 PHY" and no id at all for C45 ? This removes the confusion about the
id being 0, while still being cleat that the user needs to figure-out what's
going on with their module...

Maxime

