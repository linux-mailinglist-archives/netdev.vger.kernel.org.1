Return-Path: <netdev+bounces-306933-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SNIpFBhPU2rsZgMAu9opvQ
	(envelope-from <netdev+bounces-306933-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 10:23:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A61744269
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 10:23:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=TworFBj1;
	dmarc=pass (policy=reject) header.from=bootlin.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306933-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306933-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 003EF300F5C5
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 08:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896A8374183;
	Sun, 12 Jul 2026 08:23:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699FD36A03A
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 08:23:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783844628; cv=none; b=SI/xAma0yQIqqXJOqUJVPd4QFZOy6X3WrsPftIc7LMuymGIFGmPhb2eNSngkk4gqPh6Y1cqU9jG2+MpBtknkcmryOizko2Pyk/ZqXu4rxIFFtLk6gAgcwiBdAypvlI3b8BLkZT0x83b/PT5Q3AHK/joHurkNqIujWvUNozJ8C1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783844628; c=relaxed/simple;
	bh=Wm9mBxki+2Uz52W1xaFYlSEaPVE1Bz6yA7m6SVUbV+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VZ6du+1tb7y+hc2M9wrrCTASXb3Oh857idsj4Jtj9DIPVVRddF+IB++7l9jR/xj1/DqtD0gE8Zx1FZY1O+vg0g/dK/EQUumYnXdZvYocWiBByRsnOvNTvVKfIQtbBL4mXVC7V9kXqszDbeId6LBPZn4G1cIfRQWhDbfrU/GzpBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TworFBj1; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D44624E40D77;
	Sun, 12 Jul 2026 08:23:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7850C60341;
	Sun, 12 Jul 2026 08:23:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 681C111BD0592;
	Sun, 12 Jul 2026 10:23:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783844621; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=WHd81YusCFbEXGMG/orhuGL4aOt5YJkijG0IowGEMpw=;
	b=TworFBj1iKFBDZdd0hW7T35/udycdlvdJT42I5MhPY8f69eKxcAu1HCbcgbrUKkHGc053y
	TMdoA5TgribQCRtoiSs8gtx0j4e8drmKp85I9yVeIVkHNL/Gy3Vi/xA79zKA/soTg27Yx8
	QGVk3p+mJ1EMiv2aIx19iwKtKaL2+upK9UAlAuKnZCPDq/qDFMcLWWqh32CxJamK1hEex6
	gUxPy4l3UYUXZXAywuKs+YeVm79ADyLx6Khsxbm+1QgEgTWbZA7wHp6wibwtcph6LkY2ZF
	4Lxfj8MLgmtEoL6JAlmkevqy3Yamx/EwVap2126ii+k//WNhmFRuX+GLFA/vTA==
Message-ID: <caa2b141-7131-44dc-ab01-0dd62c6e0a8a@bootlin.com>
Date: Sun, 12 Jul 2026 10:23:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/2] net: dsa: realtek: rtl8365mb: add SGMII
 support for RTL8367S
To: contact@c127.dev, Linus Walleij <linusw@kernel.org>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>
Cc: Mieczyslaw Nalewaj <namiltd@yahoo.com>,
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260711-rtl8367s-sgmii-v6-0-88f7944ddca7@c127.dev>
 <20260711-rtl8367s-sgmii-v6-1-88f7944ddca7@c127.dev>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260711-rtl8367s-sgmii-v6-1-88f7944ddca7@c127.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306933-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:contact@c127.dev,m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:namiltd@yahoo.com,m:luizluca@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[c127.dev,kernel.org,bang-olufsen.dk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[yahoo.com,gmail.com,vger.kernel.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:from_mime,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99A61744269

Hi Johan,

On 7/12/26 06:31, Johan Alvarado via B4 Relay wrote:
> From: Johan Alvarado <contact@c127.dev>
> 
> The RTL8367S can mux its embedded SerDes to external interface 1,
> which is typically used to connect the switch to a CPU port. The chip
> info table already declares SGMII as a supported interface mode for
> this chip, but the driver only implements RGMII so far.
> 
> Implement SGMII support as a phylink PCS, with the configuration
> sequence derived from the GPL-licensed Realtek rtl8367c vendor driver
> as distributed in the Mercusys MR80X GPL code drop:
> 
>  - Add accessors for the SerDes indirect access registers (SDS_INDACS),
>    through which the SerDes internal registers are reached.
> 
>  - Register a phylink_pcs for the SerDes, selected from mac_select_pcs
>    for the SGMII interface, so the SerDes handling lives in the PCS
>    operations rather than in the MAC operations.
> 
>  - Probe the SerDes tuning variant from the chip option register once
>    at setup. The vendor driver keeps two sets of SerDes tuning
>    parameters and selects between them based on this option; only the
>    variant for a non-zero option (which all RTL8367S parts seen so far
>    report) has been validated on hardware, so the SerDes interface
>    modes are only advertised in that case. An unsupported variant thus
>    fails at phylink validation time instead of at link configuration
>    time.
> 
>  - Keep the embedded DW8051 microcontroller in reset and disabled. The
>    vendor driver loads firmware into it to manage the SerDes link, but
>    analysis of that firmware shows it only duplicates the link
>    management phylink already performs: it polls the port status and
>    writes the external interface force registers behind the driver's
>    back.
> 
>  - Clear the line rate bypass bit for the external interface, tune the
>    SerDes with the vendor-prescribed parameters, mux the SerDes to MAC8
>    in SGMII mode and only then take the SerDes out of reset, as the
>    vendor driver does.
> 
>  - After deasserting the SerDes reset, reset the SerDes data path via
>    the SerDes BMCR register to flush the FIFOs and resync the PLL.
>    This mirrors what the vendor firmware does right after deasserting
>    the SerDes reset, and ensures a clean link state from cold boot.
> 
>  - Force the SGMII link parameters (link, speed, duplex) in the SDS_MISC
>    register from pcs_link_up(). SGMII in-band autonegotiation is not
>    implemented, so only fixed-link and conventional PHY setups are
>    supported, just like RGMII. This is reported to phylink through
>    pcs_inband_caps() returning LINK_INBAND_DISABLE, so phylink never
>    selects an in-band-enabled negotiation mode for this PCS.
> 
>  - Program the SerDes pause enables in SDS_MISC from the resolved
>    pause modes when forcing the MAC external interface in mac_link_up,
>    as the vendor driver does, rather than leaving whatever state the
>    boot firmware left there. Flow control testing shows these bits,
>    not the MAC force pause bits, gate pause on the SerDes external
>    interface. This is done in the MAC layer because pcs_link_up()
>    carries no pause information.
> 
>  - Implement pcs_get_state() by reading the link status from the
>    SerDes, with the forced speed and duplex read back from SDS_MISC.
>    Although the supported fixed-link and conventional PHY setups do not
>    use it, the PCS owns the SerDes link state, and phylink consults
>    pcs_get_state() to track the physical link when operating in in-band
>    mode with autonegotiation disabled. The SerDes has no link interrupt
>    wired up, so the PCS sets its poll flag.
> 
> Tested on a Mercusys MR80X v2.20, where the RTL8367S is connected to
> the SoC over SGMII.
> 
> Suggested-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> Suggested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Suggested-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
> Signed-off-by: Johan Alvarado <contact@c127.dev>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime


