Return-Path: <netdev+bounces-132822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 632D9993538
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 19:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956921C228D7
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 17:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112351DD9DF;
	Mon,  7 Oct 2024 17:42:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4751DD9D3;
	Mon,  7 Oct 2024 17:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.161.129.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728322959; cv=none; b=nmXZgnL424tQaLdjzK86XYT7VVQyrRdb9N9qezmhSG/5U4KbOUwfFu5HTT2CTOB1E7cYUIFz3idAoE17II2qwysDmhKCVhl74N2DUX2RzyTzMPgFep7IfWB0Is01f+wTCv8fwR5VOOM+PmiKdVBjWo9syO47GZjRLTayZ4LeSrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728322959; c=relaxed/simple;
	bh=KTCDxkuciJcgeGKWyDCmnFVFa2SRDkclGWps7hBAY7E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EfvktRmQ5MmTfRFQ+fd05ir52JVYyfMWOmQ96KD4e1d18rq05HXwD7MLh0tFEronLN3MJOx1K9wCb1XvftWRYsFHLCodOqRidS2oanva2sy5GW/NP4bzX1tyv5mpMENBQQsSm3tGisUWLCr+LyahInqCCJt2ZW2e/WQ/tAp0BIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; arc=none smtp.client-ip=108.161.129.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
	by finn.localdomain with esmtp (Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1sxrkZ-000mTr-Ft;
	Mon, 07 Oct 2024 17:42:27 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Lukasz Majewski <lukma@denx.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH net v3] net: phy: disable eee due to errata on various KSZ switches
Date: Mon,  7 Oct 2024 10:42:11 -0700
Message-Id: <20241007174211.3511506-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The well-known errata regarding EEE not being functional on various KSZ
switches has been refactored a few times. Recently the refactoring has
excluded several switches that the errata should also apply to.

Disable EEE for additional switches with this errata.

The original workaround for the errata was applied with a register
write to manually disable the EEE feature in MMD 7:60 which was being
applied for KSZ9477/KSZ9897/KSZ9567 switch ID's.

Then came commit ("26dd2974c5b5 net: phy: micrel: Move KSZ9477 errata
fixes to PHY driver") and commit ("6068e6d7ba50 net: dsa: microchip:
remove KSZ9477 PHY errata handling") which moved the errata from the
switch driver to the PHY driver but only for PHY_ID_KSZ9477 (PHY ID)
however that PHY code was dead code because an entry was never added
for PHY_ID_KSZ9477 via MODULE_DEVICE_TABLE.

This was apparently realized much later and commit ("54a4e5c16382 net:
phy: micrel: add Microchip KSZ 9477 to the device table") added the
PHY_ID_KSZ9477 to the PHY driver but as the errata was only being
applied to PHY_ID_KSZ9477 it's not completely clear what switches
that relates to.

Later commit ("6149db4997f5 net: phy: micrel: fix KSZ9477 PHY issues
after suspend/resume") breaks this again for all but KSZ9897 by only
applying the errata for that PHY ID.

The most recent time this was affected was with commit ("08c6d8bae48c
net: phy: Provide Module 4 KSZ9477 errata (DS80000754C)") which
removes the blatant register write to MMD 7:60 and replaces it by
setting phydev->eee_broken_modes = -1 so that the generic phy-c45 code
disables EEE but this is only done for the KSZ9477_CHIP_ID (Switch ID).

Fixes: 08c6d8bae48c ("net: phy: Provide Module 4 KSZ9477 errata (DS80000754C)")
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v3: added missing fixes tag
v2: added fixes tag and history of issue
---
 drivers/net/dsa/microchip/ksz_common.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index b074b4bb0629..d2bd82a1067c 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2578,11 +2578,19 @@ static u32 ksz_get_phy_flags(struct dsa_switch *ds, int port)
 		if (!port)
 			return MICREL_KSZ8_P1_ERRATA;
 		break;
+	case KSZ8795_CHIP_ID:
+	case KSZ8794_CHIP_ID:
+	case KSZ8765_CHIP_ID:
+		/* KSZ87xx DS80000687C Module 2 */
+	case KSZ9896_CHIP_ID:
+		/* KSZ9896 Errata DS80000757A Module 2 */
+	case KSZ9897_CHIP_ID:
+		/* KSZ9897 Errata DS00002394C Module 4 */
+	case KSZ9567_CHIP_ID:
+		/* KSZ9567 Errata DS80000756A Module 4 */
 	case KSZ9477_CHIP_ID:
-		/* KSZ9477 Errata DS80000754C
-		 *
-		 * Module 4: Energy Efficient Ethernet (EEE) feature select must
-		 * be manually disabled
+		/* KSZ9477 Errata DS80000754C Module 4 */
+		/* Energy Efficient Ethernet (EEE) feature select must be manually disabled
 		 *   The EEE feature is enabled by default, but it is not fully
 		 *   operational. It must be manually disabled through register
 		 *   controls. If not disabled, the PHY ports can auto-negotiate
-- 
2.25.1


