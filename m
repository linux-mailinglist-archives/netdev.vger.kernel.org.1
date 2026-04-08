Return-Path: <netdev+bounces-276707-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDnRK57D1mlDIAgAu9opvQ
	(envelope-from <netdev+bounces-276707-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 23:07:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE7A3C3F7B
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 23:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFF783014C6E
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 21:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A062337996C;
	Wed,  8 Apr 2026 21:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b="cnF0c+Zp"
X-Original-To: netdev@vger.kernel.org
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A29339B3D;
	Wed,  8 Apr 2026 21:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.127.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775682457; cv=none; b=JRX5QzcGOKuqZbUweBik+QevBTtW0LeZNJKn1ULA9aMJvTH1CfZ6C2BvIJB0DbOJfrFnERvGtryoRbnIIbAM/bVAtfu6l0iF8HEJ+1vW/316c70OVj0YjBrXcID3cTEhaFVhro1rAFlmC/b9fND0wHKSAfvt7qctITAdST/gfM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775682457; c=relaxed/simple;
	bh=p375EVvCBiVMUT283BZgLjGqOXk2ZUOC0JJGv9cIjzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KdCSXSsh+LMQooEuohnwE+hmng16n9hfCtIx/28fVdeCcUO4fur36227GIrkqjj+ggBKQ41tJvk8fFgyOTwvPPuAOwPiGvvVibkcSPk8nrcajrLogHwfJrc8TzNmKDvejWyT9J1A3pYhVjDNpET+JE3vJmy0z1YY0zIaYG2hRyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=cnF0c+Zp; arc=none smtp.client-ip=85.214.127.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szelinsky.de
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 395B4E83FB8;
	Wed,  8 Apr 2026 23:07:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1775682447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DBFooOrPqy11+ivnIBAcisekxyJXWHOaheUWIkk4FJg=;
	b=cnF0c+ZpMyFvch7j9UCkHoKMdYamOhwyWFfV53jB1jwKQWSJdUPctOFaPObFrDCGfbzUud
	PL6LghneoLMCHlim2cy8pOE4HF3Dt/0MS2cQ6ZyF3IdBHA4DVoTS+hch9NYH+AkkEM2N6Y
	1R6xLIJSM3ZXhJfhlRyNefWLS7uJDiluZ0/fjfcyh6VlNaxY5FgrH3sYxzSxpm+s5IUzaL
	Et609d8oJMGI6xgfLpuPvoRvq3a5Iv+jnZ+qeFBhWzuvIguvISbw6iHeDc8eEXG/9zHesG
	0Qf9tLIHc/OufcHPOjyOK0GWBKCi0ojr0e/V11nkjxN7lGzG0PW5uU6Kyar/eA==
X-Virus-Scanned: Debian amavisd-new at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
	by localhost (szelinsky.de [127.0.0.1]) (amavisd-new, port 10025)
	with ESMTP id iHDJ7hKURNct; Wed,  8 Apr 2026 23:07:27 +0200 (CEST)
Received: from p14sgen5.fritz.box (dslb-002-205-089-102.002.205.pools.vodafone-ip.de [2.205.89.102])
	by szelinsky.de (Postfix) with ESMTPSA;
	Wed,  8 Apr 2026 23:07:26 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: andrew@lunn.ch
Cc: o.rempel@pengutronix.de,
	kory.maincent@bootlin.com,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] net: mdio: treat PSE EPROBE_DEFER as non-fatal during PHY registration
Date: Wed,  8 Apr 2026 23:07:11 +0200
Message-ID: <20260408210711.439068-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <8e12f0ac-be0d-4664-a533-df3bd1efb34a@lunn.ch>
References: <8e12f0ac-be0d-4664-a533-df3bd1efb34a@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[szelinsky.de,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[szelinsky.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[pengutronix.de,bootlin.com,lunn.ch,gmail.com,armlinux.org.uk,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276707-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[szelinsky.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,szelinsky.de:dkim,szelinsky.de:mid]
X-Rspamd-Queue-Id: 2AE7A3C3F7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

So I went ahead and tested the phy_probe() approach on my setup (RTL930x
DSA switch with an I2C Hasivo HS104 PSE controller as module).

PoE itself works fine, but phydev->psec never gets set - ethtool just
says "No PSE is attached" on all ports.

Took me a while to figure out what's going on. The problem is how DSA
handles PHYs: when phy_probe() returns -EPROBE_DEFER because the PSE
controller hasn't probed yet, the PHY device is registered but sits
there unprobed. Then the DSA switch comes along, sets up its ports, and
phy_attach_direct() force-binds the generic PHY driver with
device_bind_driver(). Now the device already has a driver, so when the
deferred probe retry kicks in it just skips it. phy_probe() never runs
again and psec stays NULL.

What I'm seeing timing-wise:
  - MDIO scan registers PHYs, phy_probe() defers (no PSE yet)
  - DSA probes, phy_attach_direct() binds genphy
  - t=17s: HS104 finally probes
  - deferred retry: nope, driver already bound
  - t=35s: regulator_late_cleanup (caught by admin_state_synced)

Not sure what the best path forward is here. Should we look at fixing
phy_attach_direct() to handle this case, or go back to the non-fatal
EPROBE_DEFER approach from v2 for now?

Cheers,
Carlo

