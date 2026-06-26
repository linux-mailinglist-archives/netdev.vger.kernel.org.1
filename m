Return-Path: <netdev+bounces-302241-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M1CHJiWwPmoYKQkAu9opvQ
	(envelope-from <netdev+bounces-302241-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 19:00:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 059AF6CF4F4
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 19:00:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=szelinsky.de header.s=mail header.b=OjoBLhqR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302241-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302241-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=szelinsky.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C059C303B18F
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 17:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522AE3FFAC5;
	Fri, 26 Jun 2026 17:00:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E0E3FE64E;
	Fri, 26 Jun 2026 17:00:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782493202; cv=none; b=uszPN7iB13tAalZ9vTAVCOxBSx9T/AjnMVoz00NtQ8IMvn4TnbN3dDk8BwzCaMsi24tdbn/3ozttmuJQtroZ3qWaEz//vzUhwdi4erEjQXaPxEP2t7FLzCEe/uFYg2Z7p03Gm3xZuvW5IfU00CzCX0lp18tlaJOk0Twaev8inBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782493202; c=relaxed/simple;
	bh=FQkHWUzJBB2/z628wqG2IuYocn2yZt0Eh1WYROrR/gk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZfTCiOol4ktvRXKzO/Fhv6AVuU/XNV3Hr3imbzM65yrodLQNq5JI26LlIwsEBOy/HBUutKQyWNugaGetDbN4HRwzzD+wJ0OVuhHj/JQbu5/ckPGFSXxWpBKogsXppEMg2P2O4IyN4GnfWRosdOYZTKjPl54RkqtfomrhJcDaRJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=OjoBLhqR; arc=none smtp.client-ip=85.214.127.56
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 300CFE83338;
	Fri, 26 Jun 2026 18:59:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1782493192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nX6qkuRBO5lfmxLF+Ac/nHbJvTXJ1T6NWBM5C0QvoNY=;
	b=OjoBLhqRJUNkm9OWKjOLrgGh8FXtd8YzAtti8a56ykBr1m/nDYfOKkKmCVEyoJYdMfPuoB
	/RtPkfQ+QtF7fSac6y5J76vTvMWbzGQmM7GNcKnb972vrHa0C06hGAWiaUefkSkClcDCqP
	3Hvtcw8T7aOZBVPqSdYwVkLw5z1C0vfxEYD4xkbXLzYFs5Lqk2CobIWa7t8r0FLCYMIKn4
	EgRVrvfbo28SNhb6IA5VUvxGjjdJsGC8ATH0oOVQ7NoG9WpgkljmHYLJdrx0LfbRgezE8q
	bDrzC3jaw7BlUjHcjvvToCcsVpG7ULST149gEf+IGao+p5ajp/8TK+YDl8Ak3g==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id DmjNYrUrcMCC; Fri, 26 Jun 2026 18:59:52 +0200 (CEST)
Received: from p14sgen5.lan (p5784dea5.dip0.t-ipconnect.de [87.132.222.165])
	by szelinsky.de (Postfix) with ESMTPSA;
	Fri, 26 Jun 2026 18:59:51 +0200 (CEST)
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
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net-next v3 0/3] net: pse-pd: decouple controller lookup from MDIO probe
Date: Fri, 26 Jun 2026 18:59:26 +0200
Message-ID: <20260626165929.2908782-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[szelinsky.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302241-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:corey@leavitt.info,m:jelonek.jonas@gmail.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:github@szelinsky.de,m:andrew@lunn.ch,m:jelonekjonas@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[pengutronix.de,bootlin.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[leavitt.info,gmail.com,kernel.org,vger.kernel.org,szelinsky.de];
	DKIM_TRACE(0.00)[szelinsky.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 059AF6CF4F4

This is v3 of Corey's series [1]. It takes the PSE controller lookup out
of the MDIO probe path, so a modular PSE driver no longer makes the
PHY/DSA probe spin on -EPROBE_DEFER until the PSE module loads.

v2 was four patches. The first one (a regulator handle fix) is a
self-contained bug fix, so on Jakub's suggestion it is going to net on
its own [2] and is not part of this series. The three patches here are
the notifier rework and target net-next. net-next was closed for the
merge window when v2 was posted; it is open again now, so here they are.

How it works: pse_core gets a notifier chain (REGISTERED / UNREGISTERED).
The phy layer subscribes, owns phydev->psec, and attaches the PSE handle
when the controller shows up instead of during probe. fwnode_mdio loses
its PSE awareness, so no -EPROBE_DEFER leaves it and the probe-retry loop
is gone.

Tested on a Realtek rtl93xx PoE switch with two HS104 PSE controllers on
i2c:

 - clean boot, no probe-retry loop, no watchdog reset
 - 10G SFP+ port: module hotplug works, no deadlock
 - ethtool --set-pse enable/disable cuts and restores power to a PD
 - i2c unbind -> rmmod -> modprobe: PSE detaches on unbind and re-attaches
   on reload with power restored, no reboot. No lockdep splats.

Tested-by: Carlo Szelinsky <github@szelinsky.de>

Changes in v3:
 - Drop patch 1 (regulator handle fix); it goes to net separately [2].
 - Rebase on current net-next. No code changes to the three patches.

v1 was an RFC by Corey [3].

[1] https://lore.kernel.org/netdev/20260620112440.1734404-1-github@szelinsky.de/
[2] https://lore.kernel.org/netdev/20260624204017.2752934-1-github@szelinsky.de/
[3] https://lore.kernel.org/netdev/20260423-pse-notifier-decouple-v1-0-86ed750a9d62@leavitt.info/

Corey Leavitt (3):
  net: pse-pd: add notifier chain for controller lifecycle events
  net: pse-pd: fire lifecycle events on controller register/unregister
  net: phy: own phydev->psec via PSE notifier and remove fwnode_mdio
    hook

 drivers/net/mdio/fwnode_mdio.c |  34 -------
 drivers/net/phy/phy_device.c   | 168 +++++++++++++++++++++++++++++++--
 drivers/net/phy/sfp.c          |   2 +-
 drivers/net/pse-pd/pse_core.c  |  54 +++++++++++
 include/linux/phy.h            |   2 +
 include/linux/pse-pd/pse.h     |  41 ++++++++
 6 files changed, 258 insertions(+), 43 deletions(-)


base-commit: 805185b7c7a1069e407b6f7b3bc98e44d415f484
-- 
2.43.0


