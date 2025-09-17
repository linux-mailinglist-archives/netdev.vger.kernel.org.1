Return-Path: <netdev+bounces-223923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75829B7CF4B
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BC121B28E66
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 09:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6F9345730;
	Wed, 17 Sep 2025 09:48:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46BA342CBE
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 09:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758102499; cv=none; b=UBMcd4Fh96NUBLgJ8QNo2ygNXChcwyLEXdv/Q9shkTfAP2qO6Ufr/Dt7z1oL//x7NBWEKgWHrwCluIrvUGLivYL8wzvJlLIc0oUKQladJEaYqUtSaFJEQdnzmOzJhk+rgnZbvxRXOGjo34WwnNvXondn8BBLrb3n1QKuCNApNj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758102499; c=relaxed/simple;
	bh=LZfBT4URMH11Jl5GzO1eDEuKsLJO0uRezv7HzJw7xb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=romKcFKLs3uQfkAyoTAVfl9DsYaOiw4L5CfF4AxSVQ1VEY5rcOqEZbDM6WSexUvX5+U+nCwYX+iUIhCgiSHAGjAMWrV+EOR5k/ZReEwhgPRbeA64RmIcSCrjnLx4L3YnsjI6FrAPutVyXs1dXg62zX0IAIaQpnDiCp2DjQyVcNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uyolW-0002AY-3W; Wed, 17 Sep 2025 11:47:54 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uyolV-001jwD-08;
	Wed, 17 Sep 2025 11:47:53 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1uyolU-00000008oe8-41pl;
	Wed, 17 Sep 2025 11:47:52 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net-next v3 1/1] net: phy: clear link parameters on admin link down
Date: Wed, 17 Sep 2025 11:47:51 +0200
Message-ID: <20250917094751.2101285-1-o.rempel@pengutronix.de>
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

When a PHY is halted (e.g. `ip link set dev lan2 down`), several
fields in struct phy_device may still reflect the last active
connection. This leads to ethtool showing stale values even though
the link is down.

Reset selected fields in _phy_state_machine() when transitioning
to PHY_HALTED and the link was previously up:

- speed/duplex -> UNKNOWN, but only in autoneg mode (in forced mode
  these fields carry configuration, not status)
- master_slave_state -> UNKNOWN if previously supported
- mdix -> INVALID (state only, same meaning as "unknown")
- lp_advertising -> always cleared

The cleanup is skipped if the PHY is in PHY_ERROR state, so the
last values remain available for diagnostics.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
changes v3:
- rework commit message
- move cleaning sequence to PHY_HALTED case in _phy_state_machine()
changes v2:
- rebase and resned against net-next

 drivers/net/phy/phy.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index e046dd858f15..02da4a203ddd 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -1548,6 +1548,19 @@ static enum phy_state_work _phy_state_machine(struct phy_device *phydev)
 		}
 		break;
 	case PHY_HALTED:
+		if (phydev->link) {
+			if (phydev->autoneg == AUTONEG_ENABLE) {
+				phydev->speed = SPEED_UNKNOWN;
+				phydev->duplex = DUPLEX_UNKNOWN;
+			}
+			if (phydev->master_slave_state !=
+						MASTER_SLAVE_STATE_UNSUPPORTED)
+				phydev->master_slave_state =
+						MASTER_SLAVE_STATE_UNKNOWN;
+			phydev->mdix = ETH_TP_MDI_INVALID;
+			linkmode_zero(phydev->lp_advertising);
+		}
+		fallthrough;
 	case PHY_ERROR:
 		if (phydev->link) {
 			phydev->link = 0;
--
2.47.3


