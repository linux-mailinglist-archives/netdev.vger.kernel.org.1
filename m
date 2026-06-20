Return-Path: <netdev+bounces-300796-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TYcpN554NmqqAAcAu9opvQ
	(envelope-from <netdev+bounces-300796-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 13:25:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7480B6A8C9D
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 13:25:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=szelinsky.de header.s=mail header.b=BbNuxPgz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300796-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-300796-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=szelinsky.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C6DB930008A0
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 11:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AC73537E0;
	Sat, 20 Jun 2026 11:25:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5791623B63E;
	Sat, 20 Jun 2026 11:25:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781954715; cv=none; b=GBoZ1oEk7/LMhfzbvIIPihLv3s5IRu7iC/RzhEOXwY4S5lX8pdujUE1+Cd+1CPWBB6FtWRLdln1tdzF/nkaSDu0HGom050ZFJ3LxW6HbZt0XlKy4uG4aJMgsGPbAMqxgc+r+8jNY8wOqphgT4nDBA2ommhz8PEtleKkzx5OMw9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781954715; c=relaxed/simple;
	bh=p9EMZJ7Ul9Djq32sSvwFS9M86WNwG0DqcgT3p42t1nM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kplm9p76F/0ZFhR4fvSlIEG34GLjZYDzMtY80gyXlgr53FZBCv7OUMm8fTeSgDTlUECihbrZqlw0FVqHwse3AOlAe/qCB5sceG+ZGEStlaDnJDXRMR9La4ZJ4wKN+DcR3chx3MYgXt6BBLuo20RdjvBsogB98Oq7BUlPCARLMTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=BbNuxPgz; arc=none smtp.client-ip=85.214.127.56
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id DDC28E837CA;
	Sat, 20 Jun 2026 13:25:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1781954703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lvu5Nzo6743E4/pdJ+Bi8AD3SUYi/knvHlC/aML8AbA=;
	b=BbNuxPgzBssnGY/hLP+8wKWijI12uee+oUe8dA7/R7p4GFxZShEwl+YsvFQb4STCxPERWj
	SzEDjNigcZHUklPLxHoXF903B4DuCOevjtypCjSCctFYgCFzx91xkTWeTU3NyKy1DVcj6Z
	YX2JmupDtolR4ZB75/SwDhWX7/nTJeq3NorU2gRRJPVWu4qZHwn6/KKYRo5DOvzNxxK/Ig
	LgK5UXwOy4kZciOrVkrTJTQmRfjd25C0kUe1AV7Ao3zuLevSoMalPiTsfmXbedat9mJges
	z3hDzl2rCRqM3fqDbii4IYS7SutHeJBHqo9jHJCQJY+KRXY9vbs6pd3g3gIV7A==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id hAlVIrI2EfXm; Sat, 20 Jun 2026 13:25:03 +0200 (CEST)
Received: from p14sgen5.lanhh (dslb-002-205-089-174.002.205.pools.vodafone-ip.de [2.205.89.174])
	by szelinsky.de (Postfix) with ESMTPSA;
	Sat, 20 Jun 2026 13:25:02 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Corey Leavitt <corey@leavitt.info>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net-next v2 0/4] net: pse-pd: decouple controller lookup from MDIO probe
Date: Sat, 20 Jun 2026 13:24:36 +0200
Message-ID: <20260620112440.1734404-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423-pse-notifier-decouple-v1-0-86ed750a9d62@leavitt.info>
References: <20260423-pse-notifier-decouple-v1-0-86ed750a9d62@leavitt.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[szelinsky.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[szelinsky.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300796-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:corey@leavitt.info,m:jelonek.jonas@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:github@szelinsky.de,m:andrew@lunn.ch,m:jelonekjonas@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[pengutronix.de,bootlin.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[leavitt.info,gmail.com,vger.kernel.org,szelinsky.de];
	DKIM_TRACE(0.00)[szelinsky.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,szelinsky.de:dkim,szelinsky.de:email,szelinsky.de:mid,szelinsky.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7480B6A8C9D

This is v2 of Corey's RFC [1]. Corey is busy at the moment, so I'm picking
it up to unblock everyone. The design is unchanged. The main thing v2
fixes is the SFP deadlock Jonas reported, plus a couple of smaller points
from the review.

The problem:

When a PSE controller driver is built as a module and a DT PHY node has a
"pses = <&...>" phandle, fwnode_mdiobus_register_phy() tries to resolve the
PSE handle before the controller has probed. It gets -EPROBE_DEFER, the
MDIO/DSA probe fails, and driver-core keeps retrying until the PSE module
loads. Since fa2f0454174c each retry does a full phy_device_register() /
phy_device_remove() cycle, so on a board with a tight watchdog the retry
loop can reset the box before userspace is up.

Rather than make the retry cheaper, this takes the PSE lookup out of the
MDIO probe path completely. pse_core gets a notifier chain (REGISTERED /
UNREGISTERED), the phy layer subscribes, owns phydev->psec, and attaches the
PSE handle when the controller actually shows up instead of during probe.
fwnode_mdio no longer knows about PSE, so no -EPROBE_DEFER crosses that
boundary and the retry loop is gone.

What changed since v1:

 - v1 made phy_device_register() hold rtnl across the whole registration,
   including device_add(). That deadlocks a PHY that drives its own SFP cage:
   device_add() -> phy_probe() -> phy_sfp_probe() -> sfp_bus_add_upstream(),
   and sfp_bus_add_upstream() takes rtnl again. Jonas hit this with
   RTL8214FC. v2 keeps device_add() out of rtnl and only takes rtnl around
   the psec attach, which now runs after device_add(). Doing the attach
   after the phy is on the bus keeps the PSE_REGISTERED race closed: either
   the notifier walk finds the phy and attaches it, or our own attach does,
   and the phydev->psec check makes that idempotent.

 - A broken "pses" binding now gets a phydev_warn() instead of being
   swallowed. -ENOENT (no phandle) and -EPROBE_DEFER stay quiet.

Tested on a Realtek rtl93xx PoE switch with two HS104 PSE controllers on
i2c:

 - clean boot, no probe-retry loop, no watchdog reset
 - 10G SFP+ port: module hotplug works, no deadlock (this is the path that
   hung with v1)
 - ethtool --set-pse enable/disable cuts and restores power to a connected PD
 - full i2c unbind -> rmmod -> modprobe cycle: PSE detaches on unbind (module
   refcount drops to 0 so rmmod works), and re-attaches on reload with power
   restored, no reboot. No lockdep splats.

Tested-by: Carlo Szelinsky <github@szelinsky.de>

One thing I'd like input on: the Fixes: tags. Patch 1 is a standalone
regulator lifetime fix and carries its own Fixes:. The boot-hang itself is
fixed by patches 2-4 together. Should those three carry
Fixes: fa2f0454174c so the fix can be backported, or should the series stay
net-next only? I'm fine either way.

[1] https://lore.kernel.org/netdev/20260423-pse-notifier-decouple-v1-0-86ed750a9d62@leavitt.info/

Corey Leavitt (4):
  net: pse-pd: scope pse_control regulator handle to kref lifetime
  net: pse-pd: add notifier chain for controller lifecycle events
  net: pse-pd: fire lifecycle events on controller register/unregister
  net: phy: own phydev->psec via PSE notifier and remove fwnode_mdio
    hook

 drivers/net/mdio/fwnode_mdio.c |  34 -------
 drivers/net/phy/phy_device.c   | 168 +++++++++++++++++++++++++++++++--
 drivers/net/phy/sfp.c          |   2 +-
 drivers/net/pse-pd/pse_core.c  |  60 +++++++++++-
 include/linux/phy.h            |   2 +
 include/linux/pse-pd/pse.h     |  41 ++++++++
 6 files changed, 261 insertions(+), 46 deletions(-)


base-commit: b85966adbf5de0668a815c6e3527f87e0c387fb4
-- 
2.43.0


