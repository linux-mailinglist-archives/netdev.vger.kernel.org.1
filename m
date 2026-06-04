Return-Path: <netdev+bounces-295417-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NK3GCXrrIWpKQgEAu9opvQ
	(envelope-from <netdev+bounces-295417-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 23:17:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C54643901
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 23:17:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=qhD906c7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295417-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295417-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C491301ED25
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 21:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6D63F9F51;
	Thu,  4 Jun 2026 21:15:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB2C3FDBF7
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 21:15:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780607753; cv=none; b=Usl/j9rkMDSwKI72DfplyQOFbCmvRwgIJAf+qNBBPRiITPCUpOgAELMTdMDcjGfNMOqfW0fIXHPsmIvbNKoISzEEnZt74VvgZ01MrG6B+l2G5Bzcl21dppyIMncvs/UnuUWokfFaApQnQx3OniBNqSuPP6hjpzEEOKPmihtE4Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780607753; c=relaxed/simple;
	bh=uzi1qKKF319w7qp7uCB9CjmvG2HW8sHhqSjX68MC+M0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sx1F22qb8gAPd91GliXu9IvpTdu1Hixoc3hbzzE6eGorEh2Z5A5S/N7BPgSIEs400IUkeAS++6FAugQ4uDMLdxzZipuQw7h3jfChn+64R6tu9fK8Cbfxl2ML8RBXMiFi36N8woq9EurS9G1px9h9Y7sog2TLmjFRGDGI0FTfM+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qhD906c7; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8581B1A07A0;
	Thu,  4 Jun 2026 21:15:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4CB325FED1;
	Thu,  4 Jun 2026 21:15:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F4213106A1D59;
	Thu,  4 Jun 2026 23:15:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780607746; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=pOjBojSdOqI950HvFqUStTBY/H0OP5HMjT8uY3n8qDo=;
	b=qhD906c7wi4RO3tIb91H7sy8JaNxOpSMGv1l/u2cm+PbpftHyD7b1Hm3sRfQIOpxiQpCvX
	RlUJRkvbdBmWK+G8kqf4MwdhkCl0aAYjOU36maQaM3pWaTmUvVFIQEr15FlXOqlH/5c31U
	IHsOF98kHZErzXd8dh9ppSmEjReUgyn6+eudB+HOOmPKWmOp9+FqZx7NokfmQaZkQoMt93
	L0ErMuNAyB9Z8c47SUg394hGcXMnf3YAFtOflutq3WNQWaviB8O8Z75P+nHjui/WmSkAYo
	GsohIC1ElgtKK/AVaHOA5BIayJ5IgFcTQpmG/aXooGeYWF/Q9q3fKQEd8DcpyA==
Message-ID: <f7c713b9-7674-4b2e-82ac-01485d128c05@bootlin.com>
Date: Thu, 4 Jun 2026 23:15:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: mdio-i2c: defer RollBall bridge probe
 to PHY discovery
To: Petr Wozniak <petr.wozniak@gmail.com>, netdev@vger.kernel.org
Cc: kuba@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, bjorn@mork.no, olek2@wp.pl
References: <20260604181207.17468-1-petr.wozniak@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260604181207.17468-1-petr.wozniak@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295417-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:petr.wozniak@gmail.com,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-phy@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:bjorn@mork.no,m:olek2@wp.pl,m:petrwozniak@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,redhat.com,lists.infradead.org,vger.kernel.org,mork.no,wp.pl];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 22C54643901

Hi,

On 6/4/26 20:12, Petr Wozniak wrote:
> commit 8fe125892f40 ("net: phy: sfp: probe for RollBall I2C-to-MDIO
> bridge in mdio-i2c") introduced a regression: for SFP modules inserted
> before system boot, the RollBall I2C-to-MDIO bridge is not yet ready to
> respond to CMD_READ/CMD_DONE cycles when sfp_sm_add_mdio_bus() runs.
> The 200 ms probe times out, i2c_mii_probe_rollball() returns -ENODEV,
> and sfp_sm_add_mdio_bus() sets mdio_protocol = MDIO_I2C_NONE.  By the
> time sfp_sm_probe_for_phy() runs (up to ~17 s later on affected
> hardware), the bridge is fully initialized — but PHY probing is skipped
> because the protocol has already been changed to NONE.
> 
> Move the probe from i2c_mii_init_rollball() — called at bus-creation
> time — to sfp_sm_probe_for_phy() in sfp.c, where it runs after the SFP
> state machine's module initialization delays.  Export the probe function
> as mdio_i2c_probe_rollball() so sfp.c can call it.
> 
> For RTL8261BE-based modules: the probe correctly returns -ENODEV at PHY
> discovery time, causing sfp_sm_probe_for_phy() to destroy the MDIO bus
> and set MDIO_I2C_NONE — eliminating the 5+ minute PHY probe retry loop.
> 
> For genuine RollBall modules inserted before boot (e.g. FLYPRO
> SFP-10GT-CS-30M with Aquantia AQR113C): the probe now runs after
> initialization is complete and correctly returns 0 — PHY detection
> proceeds normally.

I'm not sure I'm getting it, how come the init doesn't have time to complete
for modules that are present at boot, while it works for hotplugged modules ?

I'd expect modules to take even longer to init for hotplugged modules, as they
aren't sitting in the cage during the whole linux boot.

Maxime

