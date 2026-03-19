Return-Path: <netdev+bounces-269612-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MN/hHb8+vGn6vgIAu9opvQ
	(envelope-from <netdev+bounces-269612-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:21:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8CB2D0BE5
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8DEF306B4E7
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80303F54BA;
	Thu, 19 Mar 2026 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XPencwRH"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BC53F23D8
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773944245; cv=none; b=BS+xZX0bT5gl4L3h+AQvHfS/hHkiMgwgaANIb3CKuwLp5702rm3585q0BkOYcjd+nBPrQaVLTVm+IJtb0IgiJKZjAJl5avFQFwjOzW6yuCA9Q8/59kHwAz83xeHZJs+69U631tdllOyAhDUYHbdr3FzKC0McZ2MB2EnncclxC9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773944245; c=relaxed/simple;
	bh=VmoCxf/LKpudsCGR8vlmAvnLPDMFMQ+wNAJlA+M6mf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ew7nNptFiwmSyEXD9qPCUL3mNwQrZkbwFbf32PcOz7Y823GvHIMR00Op6Q6rLCe47gbuZYqFlodkcr+nuPIg1HNMOiwrTuwoqlAywycgqxADX9WQUVwTadlofzSfId9GnSXFxQBw5XB7yFBOdZlQ2NV7JaazVdMUjV/8xBxXdbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XPencwRH; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 97B714E42677;
	Thu, 19 Mar 2026 18:17:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5D53760050;
	Thu, 19 Mar 2026 18:17:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 792D110450A96;
	Thu, 19 Mar 2026 19:17:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773944239; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=GhDTKiA+AQMLigmNF3JlnBZbT990XvOcqXq4KBKI+Vs=;
	b=XPencwRHT23THIBY9L55xww8D260XMTawse+FF94oFRQo6piA73Ps13S5GSsDCW6gV+RUz
	JLep0pmxd8U1XMwluUjvb1SZVHGfw5ENwJkyLQJZ0KJ7Ow1SXDHLTTU9aHtOxNGvHXYfBO
	k+4YlK01s7HlQWmJOURAptAItd54RsA9tq3L5GAIyQsfSEDaLqSNqc2BdBsphV5nZvX0xa
	8CYRzSLsPZ5QBVzZg804urnwPkTU0gJ3gEO5evGsmhBjU/YGwVJe4wrVaszNy/EHWW5MKT
	LXCmkGWnx0FfigV0oXqYRaJLKf0G4lV/Tph1ehi3kaIZoYPp5+LH2ZwRs/davQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	UNGLinuxDriver@microchip.com
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: microchip: Don't embed struct phy_device to maintain the port state
Date: Thu, 19 Mar 2026 19:17:04 +0100
Message-ID: <20260319181705.1576679-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-269612-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,kernel.org,davemloft.net,google.com,redhat.com,microchip.com,gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AD8CB2D0BE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The KSZ9477 maintains the SGMII port's state for speed, duplex and link
status to be able to fixup the accesses to its internal older version of
the Designware XPCS. However, it does so by embedding a full instance of
struct phy_device, only to use the 'speed', 'link' and 'duplex' fields.

This is also only used for the SGMII port, it's otherwise unused for all
other regular ports.

Replace that with simple int/bool values.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/dsa/microchip/ksz9477.c    | 17 ++++++++---------
 drivers/net/dsa/microchip/ksz_common.c |  2 +-
 drivers/net/dsa/microchip/ksz_common.h |  4 +++-
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 5facffbb9c9a..5416016b33e0 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -224,14 +224,13 @@ static int ksz9477_pcs_read(struct mii_bus *bus, int phy, int mmd, int reg)
 				else
 					duplex = DUPLEX_HALF;
 
-				if (!p->phydev.link ||
-				    p->phydev.speed != speed ||
-				    p->phydev.duplex != duplex) {
+				if (!p->link || p->speed != speed ||
+				    p->duplex != duplex) {
 					u16 ctrl;
 
-					p->phydev.link = 1;
-					p->phydev.speed = speed;
-					p->phydev.duplex = duplex;
+					p->link = true;
+					p->speed = speed;
+					p->duplex = duplex;
 					port_sgmii_r(dev, port, mmd, MII_BMCR,
 						     &ctrl);
 					ctrl &= BMCR_ANENABLE;
@@ -241,10 +240,10 @@ static int ksz9477_pcs_read(struct mii_bus *bus, int phy, int mmd, int reg)
 						     ctrl);
 				}
 			} else {
-				p->phydev.link = 0;
+				p->link = false;
 			}
 		} else if (reg == MII_BMSR) {
-			p->phydev.link = !!(val & BMSR_LSTATUS);
+			p->link = !!(val & BMSR_LSTATUS);
 		}
 	}
 
@@ -557,7 +556,7 @@ int ksz9477_r_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 *data)
 			val = 0x0700;
 			break;
 		case MII_STAT1000:
-			if (p->phydev.speed == SPEED_1000)
+			if (p->speed == SPEED_1000)
 				val = 0x3800;
 			else
 				val = 0;
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index c517478cc476..144373e13bea 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3983,7 +3983,7 @@ static void ksz9477_phylink_mac_link_up(struct phylink_config *config,
 	if (dev->info->internal_phy[port])
 		return;
 
-	p->phydev.speed = speed;
+	p->speed = speed;
 
 	ksz_port_set_xmii_speed(dev, port, speed);
 
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 929aff4c55de..18f13ee9c7b6 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -129,7 +129,9 @@ struct ksz_port {
 	bool learning;
 	bool isolated;
 	int stp_state;
-	struct phy_device phydev;
+	int speed;
+	int duplex;
+	bool link;
 
 	u32 fiber:1;			/* port is fiber */
 	u32 force:1;
-- 
2.49.0


