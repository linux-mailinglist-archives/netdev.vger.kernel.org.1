Return-Path: <netdev+bounces-302199-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zTwRJPuXPmrqIgkAu9opvQ
	(envelope-from <netdev+bounces-302199-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 17:17:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 218376CE671
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 17:17:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=G1h62niQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302199-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302199-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEF4230711CD
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 15:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E986B37C906;
	Fri, 26 Jun 2026 15:10:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC7037BE8A;
	Fri, 26 Jun 2026 15:10:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782486659; cv=none; b=CiN/jTodj69j+wvuMnOr4gfOL3ucVn6FvYqZjP8zffuCRkT+HDSl8AUi+SmzNPr65D1z5TKg9BZfhKQm1gvl+nniuOJAQ2eoZHAnCsZswdRIiTTvaRv1wf+M6HJQ5gLKzM9KLj1qOZztYHLlIRT939bJZmlbs7NgxP+JaxXyom0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782486659; c=relaxed/simple;
	bh=EXG0HhmVZnvqVgn/dshv6gKk0n1/VKraBkkrriRbZhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I91GE1TkzV+HfpiUIqZyBMwXN0LogH3rLmDid/ORpxa60rAwrgM7s9/wptmscD7FLwtbjX6Lfqg8wdPYS7NoF/Z8Fw9BxJbz3OH1fEZWLuwSh/dTZH9j3/SHAqXWYo5jkTuNbleaCEHJ9nIx9g4CJlVh667dFo6Xn7dEe8FBSh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=G1h62niQ; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BCB881A09EB;
	Fri, 26 Jun 2026 15:10:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8750960232;
	Fri, 26 Jun 2026 15:10:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D5000104C976A;
	Fri, 26 Jun 2026 17:10:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782486652; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=RIDSW4QSN+EL196dH0Hkhfs2WUAzhZ9MQ1BBZjgBM6k=;
	b=G1h62niQqlh9fdwTRptlTS4dlNEaeDSca/KWRTACRbEf/8BU3A61klMmetMCWiFxjywELB
	8AL3p/XkWsIa8g7+MWFuaL8aHrRXbVdtNsTPWxrEHZx3uZiNTDhSBUDxO4PHFPOx0uUcG0
	KSDKXGC++qqDjaNzmEPK2U8nGqyh8h30Fh/Hu5Hzk5DEzO8ZaOb64Op/w05VRFlRIaW+wi
	xJoheRJKHp+ZdUuwRsHOokMQpp+bDBOQspihj5C51dc7BC5JceVRqIKTdMe3wM5s4Veo9T
	6WVdIVOdT5DKmsLUUVtBR4z1/zYVjYWtRcXbels8EDf1lilKLIobvsRv40XZrw==
Message-ID: <f729897a-c2a5-4925-9d8a-9d29569113ec@bootlin.com>
Date: Fri, 26 Jun 2026 17:10:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 2/2] net: phy: mdio-i2c: defer RollBall bridge
 probe to PHY discovery
To: Petr Wozniak <petr.wozniak@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 Bjorn Mork <bjorn@mork.no>, Aleksander Bajkowski <olek2@wp.pl>,
 Marek Behun <kabel@kernel.org>
References: <20260624084814.20972-1-petr.wozniak@gmail.com>
 <20260624084814.20972-3-petr.wozniak@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260624084814.20972-3-petr.wozniak@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-302199-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,armlinux.org.uk,lunn.ch];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:petr.wozniak@gmail.com,m:linux@armlinux.org.uk,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-phy@lists.infradead.org,m:bjorn@mork.no,m:olek2@wp.pl,m:kabel@kernel.org,m:petrwozniak@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,lists.infradead.org,mork.no,wp.pl];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,wp.pl:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 218376CE671

Hi Petr,

On 6/24/26 10:48, Petr Wozniak wrote:
> commit 8fe125892f40 ("net: phy: sfp: probe for RollBall I2C-to-MDIO
> bridge in mdio-i2c") introduced a regression: the RollBall I2C-to-MDIO
> bridge is not yet ready to respond to CMD_READ/CMD_DONE cycles when
> sfp_sm_add_mdio_bus() runs in SFP_S_INIT.  The 200 ms probe times out,
> i2c_mii_probe_rollball() returns -ENODEV, and sfp_sm_add_mdio_bus()
> sets mdio_protocol = MDIO_I2C_NONE.  By the time sfp_sm_probe_for_phy()
> runs (up to ~17 s later on affected hardware), the bridge is fully
> initialized but PHY probing is skipped because the protocol has already
> been changed to NONE.
> 
> This affects both modules inserted before boot and hotplugged modules on
> hardware where bridge initialization exceeds the 200 ms probe window
> (confirmed: FLYPRO SFP-10GT-CS-30M with Aquantia AQR113C, hotplugged).
> 
> Move the probe from i2c_mii_init_rollball(), called at bus-creation time,
> to sfp_sm_probe_for_phy() in sfp.c, where it runs after the SFP state
> machine module initialization delays.  Export the probe function as
> mdio_i2c_probe_rollball() so sfp.c can call it.
> 
> For RTL8261BE-based modules the probe correctly returns -ENODEV at PHY
> discovery time, causing sfp_sm_probe_for_phy() to destroy the MDIO bus
> and set MDIO_I2C_NONE, eliminating the 5+ minute PHY probe retry loop.
> 
> For genuine RollBall modules (e.g. FLYPRO SFP-10GT-CS-30M with Aquantia
> AQR113C) the probe now runs after initialization is complete and
> correctly returns 0, so PHY detection proceeds normally.
> 
> Reported-by: Aleksander Bajkowski <olek2@wp.pl>
> Fixes: 8fe125892f40 ("net: phy: sfp: probe for RollBall I2C-to-MDIO bridge in mdio-i2c")
> Signed-off-by: Petr Wozniak <petr.wozniak@gmail.com>
I finally got time to test this with a RollBall module, and I
confirm what Aleksander says, the RollBall module's PHY doesn't
get detected even with this patch.

It does work on v7.0 though, so before the bridge probing was
introduced.

Maxime

