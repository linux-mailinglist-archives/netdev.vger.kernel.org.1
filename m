Return-Path: <netdev+bounces-297668-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SJVONJ1eKWpNVwMAu9opvQ
	(envelope-from <netdev+bounces-297668-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:54:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E5D669780
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 14:54:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=oB1cPcaF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297668-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297668-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 04A06307681F
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 12:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345DB403AF7;
	Wed, 10 Jun 2026 12:50:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A73311CAF
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 12:49:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781095800; cv=none; b=rhAmv8f/hSBjYbUjDnH2EAWdwfQ3gH1/ZebiihwYKT+HrS8KEWaFfqC+/D/2HGNOZkuBMpOCDMiQgvamnudC1tJybGod6l/7s7YyeIouIVXbWBMy+sBeIL258N5rSwAjDXartxU7U6GMpOVXeLzbtu3js+JUdzYLKQrN55w67w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781095800; c=relaxed/simple;
	bh=t/mmtFIpn7BjmbAhOFWnWyWAruOaFZ94gtJYze76RkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=K6MShRYe7JlfuzuTk6UQ3vzkeYqD6MUu/ECOqa/ElGIHg9wKM8tfcGKuvxb88S+2QxZ4gYKk6VKXwkwYfBMYzwjKAMYXt+WQVFisEUAz87MRtSfKJLGAhjAEhDEIbDkq9OG05g2RiKGULsAcODi1lRhFDAUSEBGZ20UjSvgULBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oB1cPcaF; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E8D844E42DFB;
	Wed, 10 Jun 2026 12:49:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AF2865FFC9;
	Wed, 10 Jun 2026 12:49:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3863D106B8540;
	Wed, 10 Jun 2026 14:49:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781095794; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=FTlxtAl4bHdfHTY/b2x8Cm3mgEUhaXXY9Yp0wUvIO80=;
	b=oB1cPcaFAx0PF3eoGV5N0y1vr/83rJElOPl9jNJZYJRgl4RwakZO7flnEAsnIAtbMSHQyh
	LuPlDKaLO/sZlsa6/Wbd8zZ32JSiacu/a3ucQxI5E8WzHwy9b7yvF2x9obg/pv64QuKuuG
	MShQkrYWiu6Y774LKkOeWIVp+mNpXQUSRpaPjqub2+0pxf/wG/exGQ3hOc2a+P5eo6iGr/
	we0orki1WuQGHDLeGQ70uQ3io8Myyx12ovnFTDTk2dlfX26bQYsdN394sHB3FwfMIve0MX
	cnL1yn9yB9mFn0t9XX7bQx7ba8MsFMKOwoft/h4ADYPIKSJTz+H7SvXncOEhfQ==
Message-ID: <f1b441f7-cc5f-4118-9504-82b1fc377f3c@bootlin.com>
Date: Wed, 10 Jun 2026 14:49:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/5] net: mdio: realtek-rtl9300: Make
 otto_emdio_read_cmd() generic
To: Markus Stockhausen <markus.stockhausen@gmx.de>, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
 daniel@makrotopia.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org
References: <20260609052856.3142922-1-markus.stockhausen@gmx.de>
 <20260609052856.3142922-4-markus.stockhausen@gmx.de>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260609052856.3142922-4-markus.stockhausen@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297668-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:markus.stockhausen@gmx.de,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:chris.packham@alliedtelesis.co.nz,m:daniel@makrotopia.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:devicetree@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmx.de,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,gmx.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75E5D669780

Hello Markus,

On 6/9/26 07:28, Markus Stockhausen wrote:
> The otto_emdio_read_cmd() helper still uses RTL9300 specific properties.
> This cannot be made generic as the I/O register has different layouts for
> the different SoCs. E.g.
> 
> - RTL930x: data in bits 31-16, data out bits 15-0
> - RTL931x: data in bits 15-0, data out bits 31-16
> 
> Add a mask parameter to the function signature and fill it properly
> in the callers. As the masks will always have bits set from constant
> defines, there is no need for a consistency check.
> 
> Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
> ---

[...]

>  static int otto_emdio_read_cmd(struct mii_bus *bus, u32 cmd,
> -			       struct otto_emdio_cmd_regs *cmd_data, u32 *value)
> +			       struct otto_emdio_cmd_regs *cmd_data, u32 mask, u32 *value)
>  {
>  	struct otto_emdio_priv *priv = otto_emdio_bus_to_priv(bus);
>  	int ret;
> @@ -205,7 +205,7 @@ static int otto_emdio_read_cmd(struct mii_bus *bus, u32 cmd,
>  	if (ret)
>  		return ret;
>  
> -	*value = FIELD_GET(RTL9300_PHY_CTRL_DATA, *value);
> +	*value = (*value & mask) >> __ffs(mask);

If I'm not mistaken, you can use field_get() when the mask isn't constexpr :

https://elixir.bootlin.com/linux/v7.1-rc7/source/include/linux/bitfield.h#L299

With this change, you may add :

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


