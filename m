Return-Path: <netdev+bounces-102528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D505990381A
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 11:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758AC1F21AFF
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 09:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E6B176FC9;
	Tue, 11 Jun 2024 09:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="K9ThOjT6"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF378176FB3;
	Tue, 11 Jun 2024 09:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718099107; cv=none; b=HBGYnu7i3AqmO7aJclivTLVNtojLydSVRN8vIro1bfIO7lIfehBfymkYMZ9ICcMAKTFsVqelDS/QeVNbWjhTgsTR4dDbtLIVUIU0n34haGvsXJw2zCkabouA80XjcNZ7UZK+js4czFo9wOwC76vLCspejHMQfHy91j4jNC19duk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718099107; c=relaxed/simple;
	bh=N2AFykO7g5lcDZvqLYnlKBNb5KH5FUFag2Cy+VHydbM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KVSW6MjZYuZ7b9WqRkij/Ll/LY/qILpPIfXQwFUDd0avOX1YN91j4R18T5GyYZfA9WWSmRiABmn7FZyUvkLmVeBfLnbJ8bdE3bwxyPv2cEAK3IFloporK/qPegkzNwQE23BZk6a1TbkH4+3vJ3WDuQ90Txm8Rpoi9ZgAWA3i1N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=K9ThOjT6; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718099104; x=1749635104;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N2AFykO7g5lcDZvqLYnlKBNb5KH5FUFag2Cy+VHydbM=;
  b=K9ThOjT6eRMXsPMk/KE8gY8zmwZlP1De9T65zFXvzNeoXkUkLm6PoLDg
   SvRv5rrap+8apnN0Jbo3238jOFMBiZbNRUsRDDBjlDK3tJnz3UJHKhI69
   HF+Gjo8Yu2X+wL/P7GWPrSdjudsUB1Jgn7CfdGKM7yBPRhJiwuOUPjD13
   fscRCtGqjZxQajUgiCES0oH4t8qVITNer6IZscnFqCxHGgLIScCTheV2W
   C6yDN5cHPP4ynuX4fAflLvd1/5FL6RZK8WhSq6eLd+w5k5IYJPJb9xD1O
   4PhGxkGudR2acNNZjoGfpADHAq8qtNkjsHWv7pN0kg5ixiuDDDUCqK02X
   A==;
X-CSE-ConnectionGUID: 0cBbznKCTOiQxMmBD6ZkJQ==
X-CSE-MsgGUID: s44okEMyQhCNKnXzE0tYLw==
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; 
   d="scan'208";a="258114337"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Jun 2024 02:44:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 11 Jun 2024 02:44:17 -0700
Received: from che-ld-unglab06.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 11 Jun 2024 02:44:14 -0700
From: Rengarajan S <rengarajan.s@microchip.com>
To: <woojung.huh@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <rengarajan.s@microchip.com>
Subject: [PATCH net-next v1] lan78xx: lan7801 MAC support with lan8841
Date: Tue, 11 Jun 2024 15:12:33 +0530
Message-ID: <20240611094233.865234-1-rengarajan.s@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add lan7801 MAC only support with lan8841. The PHY fixup is registered
for lan8841 and the initializations are done using lan8835_fixup since
the register configs are similar for both lann8841 and lan8835. The PHY
is unregistered at two instances, one during init and other during
disconnect.

Signed-off-by: Rengarajan S <rengarajan.s@microchip.com>
---
 drivers/net/usb/lan78xx.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 5add4145d9fc..ab6f0c42b4d9 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -479,6 +479,7 @@ struct lan78xx_net {
 
 /* define external phy id */
 #define	PHY_LAN8835			(0x0007C130)
+#define PHY_LAN8841			(0x00221650)
 #define	PHY_KSZ9031RNX			(0x00221620)
 
 /* use ethtool to change the level for any given device */
@@ -2327,6 +2328,13 @@ static struct phy_device *lan7801_phy_init(struct lan78xx_net *dev)
 			netdev_err(dev->net, "Failed to register fixup for PHY_LAN8835\n");
 			return NULL;
 		}
+		/* external PHY fixup for LAN8841 */
+		ret = phy_register_fixup_for_uid(PHY_LAN8841, 0xfffffff0,
+						 lan8835_fixup);
+		if (ret < 0) {
+			netdev_err(dev->net, "Failed to register fixup for PHY_LAN8841\n");
+			return NULL;
+		}
 		/* add more external PHY fixup here if needed */
 
 		phydev->is_internal = false;
@@ -2390,6 +2398,8 @@ static int lan78xx_phy_init(struct lan78xx_net *dev)
 							     0xfffffff0);
 				phy_unregister_fixup_for_uid(PHY_LAN8835,
 							     0xfffffff0);
+				phy_unregister_fixup_for_uid(PHY_LAN8841,
+							     0xfffffff0);
 			}
 		}
 		return -EIO;
@@ -4239,6 +4249,7 @@ static void lan78xx_disconnect(struct usb_interface *intf)
 
 	phy_unregister_fixup_for_uid(PHY_KSZ9031RNX, 0xfffffff0);
 	phy_unregister_fixup_for_uid(PHY_LAN8835, 0xfffffff0);
+	phy_unregister_fixup_for_uid(PHY_LAN8841, 0xfffffff0);
 
 	phy_disconnect(net->phydev);
 
-- 
2.25.1


