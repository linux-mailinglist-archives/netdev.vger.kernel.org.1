Return-Path: <netdev+bounces-132252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F871991221
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 00:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18EDA1C22E71
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA5014A4C6;
	Fri,  4 Oct 2024 22:08:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353CA231CAD;
	Fri,  4 Oct 2024 22:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.161.129.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728079692; cv=none; b=SZyu5XntaQusPHWMXM7bVAAwwC6soZvj0gWxp960jJUFlGQ7GpWL/R3ksv40T2zbNsu+unx24CDC6nE2QIX45WCiTphR1bbTOR4b30OPZtrbib8aHJrbtj6L86sJLPl8Pl/kFEui1NOGRRoJ+rPfXMhIoa8CX4FN8Y7N8rcBnWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728079692; c=relaxed/simple;
	bh=cSflEgaFKMaHFtX/YbDDjEzFRDjwFue/n4BmMmc/ppE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JxA7o46Dbc+AWnR4sOv9mkoatdV4QsMywFKR5KNXPale5bytZZl5Ar5JggJk5pwc9beRQtkK1g7HS0ypXv2PCGAsOrBYV/KRkj0LqfAbrbJXPkp9fi960mwHryzLOMIQ5HUpWFoVu65uHiXHfeWd7xpVKI1rzavbjbSWyIMU9oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; arc=none smtp.client-ip=108.161.129.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
	by finn.localdomain with esmtp (Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1swpug-000iqZ-FK;
	Fri, 04 Oct 2024 21:32:38 +0000
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
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] net: phy: disable eee due to errata on various KSZ switches
Date: Fri,  4 Oct 2024 14:32:35 -0700
Message-Id: <20241004213235.3353398-1-tharvey@gateworks.com>
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

Disable EEE for these switches based on errata.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
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


