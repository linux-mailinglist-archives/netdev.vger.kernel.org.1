Return-Path: <netdev+bounces-275476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id I+nTLkey0mlKZwcAu9opvQ
	(envelope-from <netdev+bounces-275476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 21:04:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FFD39F53B
	for <lists+netdev@lfdr.de>; Sun, 05 Apr 2026 21:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2232D3001FB4
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 18:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EB72E0413;
	Sun,  5 Apr 2026 18:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="i2p0G45j"
X-Original-To: netdev@vger.kernel.org
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F922882DE;
	Sun,  5 Apr 2026 18:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775415482; cv=none; b=qqCpStMLvhr8SxwZunxUrEawACn6LWatk2eNyvx529LEvM/pOp+hBlbWI2o/O0iPJ6pyKiV+5d6ZPfjcoXMabkSsa7MiOOsndlvfxVeOqdKfQDCUpA8wTEk+2zLWv/zWKx2kH045RBmA7MYI/vBrX3qHoDQX5+ObADEsxv8JxA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775415482; c=relaxed/simple;
	bh=AuFKDh0dWTWl9Dw5DnH2oGloilnV4g8z0dgPgcaEOXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qFF7sECXEBnpkPweAwd2KGGa33AqZIYoSwy2YrH+VLcxTo6cF0W9yhmqydbfa2Tts/oY7jcqf8+SQYSU4/+4FQSCZlmUNATJjgyGXAmtrZnlL6mlOhzMi+rdRk7aV09cYJUwsCPQfJs6xOWNul0HuCOnFhEOPp3o6c3n/ankSns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=i2p0G45j; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 04EB9E83701;
	Sun,  5 Apr 2026 20:57:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1775415473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AuFKDh0dWTWl9Dw5DnH2oGloilnV4g8z0dgPgcaEOXc=;
	b=i2p0G45j6+4/97rTFUgnlLTJmac/F8iezqcmkJNOh2iqyqKfF5H6FhSjsv115OKiNdvXB6
	AzxTf3W1cfOJYcq08f3ivLDbVlJLsvv71b4HlRuDV90VhYtSqgajC0ZiudIapZa01oEwsb
	P0HpV5oMe3nS9Vm6HXEv9anqyKVW5FwbhpiYXcFSDmc4s7XIVgvqGM5EzLruvz7ogysoST
	TiAaYzT8MqH9U/WvUVF4WYhJ2w/eDEOBM1FL+eqOVZxON33V4Toz+D1oL54oB8mGyQGmFM
	sXaXhlANlYlUgqz5+QgBIAaOL+MbF3erSlWWBYrP3sQSM04hdF9XWklDZ8wFeA==
X-Virus-Scanned: Debian amavisd-new at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
	by localhost (szelinsky.de [127.0.0.1]) (amavisd-new, port 10025)
	with ESMTP id c5768AZ9SMzt; Sun,  5 Apr 2026 20:57:52 +0200 (CEST)
Received: from p14sgen5.intern.hubertus-soelden.com (unknown [83.218.176.39])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sun,  5 Apr 2026 20:57:51 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: Re: [PATCH net-next v2 3/3] net: mdio: treat PSE EPROBE_DEFER as non-fatal during PHY registration
Date: Sun,  5 Apr 2026 20:57:30 +0200
Message-ID: <20260405185730.3937952-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6185f9d8-dabe-4190-b020-711e3a046e64@lunn.ch>
References: <6185f9d8-dabe-4190-b020-711e3a046e64@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [5.84 / 15.00];
	SPAM_FLAG(5.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[szelinsky.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[szelinsky.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275476-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_CC(0.00)[bootlin.com,pengutronix.de,lunn.ch,gmail.com,armlinux.org.uk,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,szelinsky.de];
	DKIM_TRACE(0.00)[szelinsky.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,szelinsky.de:dkim,szelinsky.de:mid]
X-Rspamd-Queue-Id: B0FFD39F53B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Andrew,

So I went and looked at whether we can just let EPROBE_DEFER do its
thing here, like you suggested.

From what I can tell, the issue is where it happens.
fwnode_mdiobus_register_phy() gets called during the MDIO bus scan in
__of_mdiobus_parse_phys(), and if any PHY returns -EPROBE_DEFER there,
the whole scan bails out - none of the PHYs on that bus get registered.
So you'd lose all networking on that bus just because one PHY's PSE
controller isn't ready yet.

I also dug into the timing question you raised. Correct me if I'm
wrong, but from what I see the deferred probe timeout is 10s and
regulator_late_cleanup fires at 30s, so the ordering would actually
work out - the consumer would get to claim the regulator before
cleanup kills it. It's more the bus level collateral damage that
seemed like the real problem to me.

That's basically why I ended up treating EPROBE_DEFER as non-fatal
for PSE during PHY registration and doing lazy resolution instead.
The admin_state_synced flag then covers the window between PSE
controller probe and whenever the lazy resolution actually happens.

But I might be looking at this the wrong way - would you rather we
defer the whole bus and accept that trade-off? Or does the lazy
approach seem reasonable for this case? Happy to hear if you have
a different idea entirely.

Cheers,
Carlo

