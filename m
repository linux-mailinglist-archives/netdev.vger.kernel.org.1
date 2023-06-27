Return-Path: <netdev+bounces-14132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF03473F0D9
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 04:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C40C1C209E6
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 02:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEF8A21;
	Tue, 27 Jun 2023 02:32:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA2C36B
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 02:32:37 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237F419A1
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 19:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687833157; x=1719369157;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=OEXo62myx6hQDxFmvymqLEvdScEYILLvYYQ6q+9KruM=;
  b=lsQ/tv0W12SmLFGKWNRxw7sW3KYuWckyBtIDqd8MHKpGHqcgX9DMW4GE
   YkHGNKIN6UZ3jW0ut+G2boH92zjZltmuoZQOQWCT1LUQEsHmpOuny7rrf
   cma5/QcvOxVXK0hy77K5FaSKPbfoo/s7xHdvKmc+N80IPQ5Da31VkTDlV
   Npvy7t8zsF3p1LvaoUraZJIZ0YjSS1aznKBF8HFnSA9NxfWB/+5vIxIid
   j45bDiWioWJg/BzdfR1zuXXKXIsYT82e9A1Z1wCSt2nYQ/6pyuYLdz4Ob
   zvdv8yS1r22A2rH8tedUL9hxsFlSVzrHr1O/53PJxEfXAbkGebpyYvOMd
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="220664331"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jun 2023 19:32:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 26 Jun 2023 19:32:34 -0700
Received: from hat-linux.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 26 Jun 2023 19:32:34 -0700
From: <Tristram.Ha@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>, Tristram Ha
	<Tristram.Ha@microchip.com>
Subject: [PATCH net] net: dsa: microchip: correct KSZ8795 static MAC table access
Date: Mon, 26 Jun 2023 19:33:07 -0700
Message-ID: <1687833188-3184-1-git-send-email-Tristram.Ha@microchip.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Tristram Ha <Tristram.Ha@microchip.com>

The KSZ8795 driver code was modified to use on KSZ8863/73, which has
different register definitions.  Some of the new KSZ8795 register
information are wrong compared with previous code.

KSZ8795 also behaves differently in that the STATIC_MAC_TABLE_USE_FID
and STATIC_MAC_TABLE_FID bits are off by 1 when doing MAC table reading
than writing.  To compensate that a special code was added to shift the
register value by 1 before applying those bits.  This is wrong when the
code is running on KSZ8863, so this special is only executed when
KSZ8795 is detected.

Fixes: c8e04374f9e1 ("net: dsa: microchip: Make ksz8_w_sta_mac_table() static")

Signed-off-by: Tristram Ha <Tristram.Ha@microchip.com>
---
 drivers/net/dsa/microchip/ksz8795.c    | 8 +++++++-
 drivers/net/dsa/microchip/ksz_common.c | 8 ++++----
 drivers/net/dsa/microchip/ksz_common.h | 7 +++++++
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index f56fca1b1a22..cc5b19a3d0df 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -506,7 +506,13 @@ static int ksz8_r_sta_mac_table(struct ksz_device *dev, u16 addr,
 		(data_hi & masks[STATIC_MAC_TABLE_FWD_PORTS]) >>
 			shifts[STATIC_MAC_FWD_PORTS];
 	alu->is_override = (data_hi & masks[STATIC_MAC_TABLE_OVERRIDE]) ? 1 : 0;
-	data_hi >>= 1;
+
+	/* KSZ8795 family switches have STATIC_MAC_TABLE_USE_FID and
+	 * STATIC_MAC_TABLE_FID definitions off by 1 when doing read on the
+	 * static MAC table compared to doing write.
+	 */
+	if (ksz_is_ksz87xx(dev))
+		data_hi >>= 1;
 	alu->is_static = true;
 	alu->is_use_fid = (data_hi & masks[STATIC_MAC_TABLE_USE_FID]) ? 1 : 0;
 	alu->fid = (data_hi & masks[STATIC_MAC_TABLE_FID]) >>
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index a4428be5f483..a0ba2605bb62 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -331,13 +331,13 @@ static const u32 ksz8795_masks[] = {
 	[STATIC_MAC_TABLE_VALID]	= BIT(21),
 	[STATIC_MAC_TABLE_USE_FID]	= BIT(23),
 	[STATIC_MAC_TABLE_FID]		= GENMASK(30, 24),
-	[STATIC_MAC_TABLE_OVERRIDE]	= BIT(26),
-	[STATIC_MAC_TABLE_FWD_PORTS]	= GENMASK(24, 20),
+	[STATIC_MAC_TABLE_OVERRIDE]	= BIT(22),
+	[STATIC_MAC_TABLE_FWD_PORTS]	= GENMASK(20, 16),
 	[DYNAMIC_MAC_TABLE_ENTRIES_H]	= GENMASK(6, 0),
-	[DYNAMIC_MAC_TABLE_MAC_EMPTY]	= BIT(8),
+	[DYNAMIC_MAC_TABLE_MAC_EMPTY]	= BIT(7),
 	[DYNAMIC_MAC_TABLE_NOT_READY]	= BIT(7),
 	[DYNAMIC_MAC_TABLE_ENTRIES]	= GENMASK(31, 29),
-	[DYNAMIC_MAC_TABLE_FID]		= GENMASK(26, 20),
+	[DYNAMIC_MAC_TABLE_FID]		= GENMASK(22, 16),
 	[DYNAMIC_MAC_TABLE_SRC_PORT]	= GENMASK(26, 24),
 	[DYNAMIC_MAC_TABLE_TIMESTAMP]	= GENMASK(28, 27),
 	[P_MII_TX_FLOW_CTRL]		= BIT(5),
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 8abecaf6089e..33d9a2f6af27 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -569,6 +569,13 @@ static inline void ksz_regmap_unlock(void *__mtx)
 	mutex_unlock(mtx);
 }
 
+static inline bool ksz_is_ksz87xx(struct ksz_device *dev)
+{
+	return dev->chip_id == KSZ8795_CHIP_ID ||
+	       dev->chip_id == KSZ8794_CHIP_ID ||
+	       dev->chip_id == KSZ8765_CHIP_ID;
+}
+
 static inline bool ksz_is_ksz88x3(struct ksz_device *dev)
 {
 	return dev->chip_id == KSZ8830_CHIP_ID;
-- 
2.17.1


