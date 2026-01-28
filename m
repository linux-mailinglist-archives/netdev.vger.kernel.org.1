Return-Path: <netdev+bounces-254433-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLdBHbxwemlI6QEAu9opvQ
	(envelope-from <netdev+bounces-254433-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:25:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFC4A877B
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B35793021EA4
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 20:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE98328B68;
	Wed, 28 Jan 2026 20:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f+3eECS5"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A177327C18
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 20:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769631922; cv=none; b=bnrwJFbH+jbCza5smZP+YgF+pSepoMt8VA/14wSRYcdjyVOuYi8SzuZJr1ncB9mUvUOiYw2YyIqzFPW6ObEwnv+KLeXf6CQgty4DNqsuWVa3QG0xWQ8Gx2xiLnV4K0uO3XAWWMuEI516RcPlk/xkpgybFe03nF7go852QrpsaCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769631922; c=relaxed/simple;
	bh=1THU/IXqc2zov1vCJBRjkt4WEKVf9VZSfAJe/fhn0Mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YUeikzDl9fnPi5Em5JTAYIw3AQYYUO+HJGHQ5l1BO1JFW3nqQeZS6r7Xbh0DpaCmJPILjBtA57ARKwpXZG4RZkZ+NuJJv1P8c0u2nJYsS93EWVikvLksMt2HUZUCsPtTKyDFhlqKKhOWGkls7qwVDAGO1ghix0H3DVF02uYPoww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f+3eECS5; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D78F34E422F0;
	Wed, 28 Jan 2026 20:25:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 96E6D6071F;
	Wed, 28 Jan 2026 20:25:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 73AC9119A882A;
	Wed, 28 Jan 2026 21:25:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769631915; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=SMfXIGAVa52Lc0KHAoLt8kPypfvKVyXFIVQcUwllpO0=;
	b=f+3eECS5rX9nJuCYjiQNpi6vq9rORfn4RDkY6QY6l5DjrlEKm62iUNOiXtUGoGRa4zR1P7
	XkADItiyHSDdWG05D5BNZIKAF0ZGmFBOZ8UXXDiOpaXMVHa67UKNkUPIj1vO3ocRIz+8+3
	PqG6JYx0J3azkIzHzRdXOnrl+ZuhN/+o9pqt5MRO4RxBtmZA80WpVacDVkzhQFt5g3fUyS
	bGANNyM+F/XlXsfEGmsN1+AJKpWuvkT3YbKIe/1qYPlEJzIKXdgWS9trSel7NyYG9SE4ff
	ia+F15x0NcrTXqTaA7rrj3F0b+EEaSfHN6wIN8wX7Pb986Ipl9hpaL+GT/L0yg==
Message-ID: <65ba2124-3940-4dd6-bbab-a31cdc67f573@bootlin.com>
Date: Wed, 28 Jan 2026 21:25:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: sfp: Fix quirk for Ubiquiti U-Fiber Instant SFP
 module
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, netdev@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>
References: <20260128175714.11411-1-kabel@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260128175714.11411-1-kabel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,google.com,davemloft.net,gmail.com,lunn.ch];
	TAGGED_FROM(0.00)[bounces-254433-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CCFC4A877B
X-Rspamd-Action: no action

Hi Marek,

On 28/01/2026 18:57, Marek Behún wrote:
> Commit fd580c9830316eda ("net: sfp: augment SFP parsing with
> phy_interface_t bitmap") did not add augumentation for the interface
                                       ^^^^^^^^^^^^^
                                       augmentation
> bitmap in the quirk for Ubiquiti U-Fiber Instant.
> 
> The subsequent commit f81fa96d8a6c7a77 ("net: phylink: use
> phy_interface_t bitmaps for optical modules") then changed phylink code
> for selection of SFP interface: instead of using link mode bitmap, the
> interface bitmap is used, and the fastest interface mode supported by
> both SFP module and MAC is chosen.
> 
> Since the interface bitmap contains also modes faster than 1000base-x,
> this caused a regression wherein this module stopped working
> out-of-the-box.
> 
> Fix this.
> 
> Fixes: fd580c9830316eda ("net: sfp: augment SFP parsing with phy_interface_t bitmap")
> Signed-off-by: Marek Behún <kabel@kernel.org>
> ---
>  drivers/net/phy/sfp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index 47f095bd91ce..eb6fa98e5d71 100644
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
> @@ -479,6 +479,8 @@ static void sfp_quirk_ubnt_uf_instant(const struct sfp_eeprom_id *id,
>  	linkmode_zero(caps->link_modes);
>  	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
>  			 caps->link_modes);
> +	bitmap_zero(caps->interfaces, PHY_INTERFACE_MODE_MAX);

small nit, you can use phy_interface_zero() here.

> +	__set_bit(PHY_INTERFACE_MODE_1000BASEX, caps->interfaces);
>  }
>  
>  #define SFP_QUIRK(_v, _p, _s, _f) \

With that, it looks good to me,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime



