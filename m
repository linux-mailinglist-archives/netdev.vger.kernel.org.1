Return-Path: <netdev+bounces-222600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC70B54F42
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 15:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5844D7A5F76
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 13:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633FD3090D1;
	Fri, 12 Sep 2025 13:20:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A6E26561D
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683214; cv=none; b=cIbpz5VhAXcZ3LKteIMjZUUDwYYiK33niXKVgrALZYHPdgpyixK7iKUhllnkRVRMARcJy78n/I9NpNXrVO0BrZd3MxB8HkSC/i2H9tQCZ6q1NuBmERS0B2rLVKzkpgChp/0meGZkXNZUylrQddZO73HCQW6Wq8Wg6PTh3k8tAnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683214; c=relaxed/simple;
	bh=jBT7UqVLaR7sIfPtQ2y7sFr6Lw5a+jEfCOzb7CLcvBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P1V7xW+UOOIhOpAH7XBMTf2yPqtGRjdQCu1JNzw1jjwile51jWZYCpPtoMgBwzrxLKy08t8Y10Rts3S2w1O3ebmmR4AMhMR2UiprEC3KwJjQ/w83rza7a2Vc+4vfhjfXPRTFomcT7GXam0ayZpo/tOY6zact8jv+zk8qVG5DfQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1ux3h4-0006qY-N1; Fri, 12 Sep 2025 15:20:02 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1ux3h3-000wG1-1S;
	Fri, 12 Sep 2025 15:20:01 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1ux3h3-00000006hn6-1Zxs;
	Fri, 12 Sep 2025 15:20:01 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 1/1] net: phy: clear EEE runtime state in PHY_HALTED/PHY_ERROR
Date: Fri, 12 Sep 2025 15:20:00 +0200
Message-ID: <20250912132000.1598234-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Clear EEE runtime flags when the PHY transitions to HALTED or ERROR
and the state machine drops the link. This avoids stale EEE state being
reported via ethtool after the PHY is stopped or hits an error.

This change intentionally only clears software runtime flags and avoids
MDIO accesses in HALTED/ERROR. A follow-up patch will address other
link state variables.

Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v2:
- Update commit message to mention follow-up patch for other link state
  variables.
- v1 Link: https://lore.kernel.org/all/20250909131248.4148301-1-o.rempel@pengutronix.de

Related discussion: https://lore.kernel.org/r/aKg7nf8YczCT6N0O@shell.armlinux.org.uk
---
 drivers/net/phy/phy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index c02da57a4da5..e046dd858f15 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1551,6 +1551,8 @@ static enum phy_state_work _phy_state_machine(struct phy_device *phydev)
 	case PHY_ERROR:
 		if (phydev->link) {
 			phydev->link = 0;
+			phydev->eee_active = false;
+			phydev->enable_tx_lpi = false;
 			phy_link_down(phydev);
 		}
 		state_work = PHY_STATE_WORK_SUSPEND;
--
2.47.3


