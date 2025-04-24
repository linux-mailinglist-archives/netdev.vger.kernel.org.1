Return-Path: <netdev+bounces-185471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D0BA9A919
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 11:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 113923A9510
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 09:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F61B1D516F;
	Thu, 24 Apr 2025 09:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GPU2vGO7"
X-Original-To: netdev@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E545819CC3D;
	Thu, 24 Apr 2025 09:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745488453; cv=none; b=GZfPvQ4SwVThLL3ECRv3anqwRiSk3eaqZQrX20bopI/QGX8iLqlTp+MOraHp5+0gHC+bJ7x1tOKrrnRM3F8jwjqvHNBL6orByPoSA/PztsTqqFJvok2SlJasAiwq/ImD32TsYCF6mx+QSaZbqt5FAjVnHQwLFzEMti1QyhCNVRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745488453; c=relaxed/simple;
	bh=ZV2EU0lS5UbkQEDKIMlLp8H7/VASWeIN55PoSggIycY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l9sYHlfJNE/4HwPR2JMICff88e7LnNAeyLCXqOELpxQK1m2jPk8xYqDRZyCBuRRTrYL4oJunKtT8g/ae6UNf25qdfeL+DHMC2DlP70wLAsdZiC+AtizEaNjxw63P088ZR7u0xAY8+REZcfXVjXqA35FpfkhnyoRLoU9cYxuCWc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GPU2vGO7; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53O9rLn61823416
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 04:53:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1745488401;
	bh=Z6vAvY6wUi4QuG5rrF2KhxpeZXkQGT1PaOJZ62tuOIQ=;
	h=From:To:CC:Subject:Date;
	b=GPU2vGO7CtlJfPhBIk7463bycm1+DXX+RJKzHTpIIy5M8eZGqaaK/xzfrMoubZ7mp
	 /okyAUW84DTvUhyocTjTKfoXd2POG1fJ+/WYQeT6m/wbjKVWGidogOT9SdGHKP//C9
	 mE1nlb05S07LGShl9r5DynJb5sm+coDaZO5Vb59A=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53O9rLas068950
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 24 Apr 2025 04:53:21 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Apr 2025 04:53:20 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Apr 2025 04:53:20 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53O9rKQx014724;
	Thu, 24 Apr 2025 04:53:20 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 53O9rJRI020685;
	Thu, 24 Apr 2025 04:53:20 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Meghana Malladi
	<m-malladi@ti.com>, Lee Trager <lee@trager.us>,
        Madhavan Srinivasan
	<maddy@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Michael Ellerman
	<mpe@ellerman.id.au>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Roger Quadros
	<rogerq@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>,
        Jonathan Corbet
	<corbet@lwn.net>, Simon Horman <horms@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <netdev@vger.kernel.org>, <srk@ti.com>,
        Vignesh
 Raghavendra <vigneshr@ti.com>
Subject: [PATCH net-next v3] net: ti: icssg-prueth: Add ICSSG FW Stats
Date: Thu, 24 Apr 2025 15:23:16 +0530
Message-ID: <20250424095316.2643573-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The ICSSG firmware maintains set of stats called PA_STATS.
Currently the driver only dumps 4 stats. Add support for dumping more
stats.

The offset for different stats are defined as MACROs in icssg_switch_map.h
file. All the offsets are for Slice0. Slice1 offsets are slice0 + 4.
The offset calculation is taken care while reading the stats in
emac_update_hardware_stats().

The statistics are documented in
Documentation/networking/device_drivers/icssg_prueth.rst

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
v2 - v3:
*) Included different firmware maintained error counters in the aggregate
rx_errors / rx_dropped / tx_errors / tx_dropped statistics as suggested by
Jakub Kicinski <kuba@kernel.org>
*) Rebased on the latest net-next

v1 - v2:
*) Created icssg_prueth.rst and added Documentation of firmware statistics
as suggested by Jakub Kicinski <kuba@kernel.org>
*) Removed unimplemented preemption statistics.
*) Collected RB tag from Simon Horman <horms@kernel.org>

v1 - https://lore.kernel.org/all/20250227093712.2130561-1-danishanwar@ti.com/
v2 - https://lore.kernel.org/all/20250305111608.520042-1-danishanwar@ti.com/

 .../device_drivers/ethernet/index.rst         |  1 +
 .../ethernet/ti/icssg_prueth.rst              | 56 ++++++++++++++++++
 drivers/net/ethernet/ti/icssg/icssg_common.c  | 24 +++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  2 +-
 drivers/net/ethernet/ti/icssg/icssg_stats.c   |  8 +--
 drivers/net/ethernet/ti/icssg/icssg_stats.h   | 58 ++++++++++++-------
 .../net/ethernet/ti/icssg/icssg_switch_map.h  | 33 +++++++++++
 7 files changed, 151 insertions(+), 31 deletions(-)
 create mode 100644 Documentation/networking/device_drivers/ethernet/ti/icssg_prueth.rst

diff --git a/Documentation/networking/device_drivers/ethernet/index.rst b/Documentation/networking/device_drivers/ethernet/index.rst
index 05d822b904b4..f9ed93c1da35 100644
--- a/Documentation/networking/device_drivers/ethernet/index.rst
+++ b/Documentation/networking/device_drivers/ethernet/index.rst
@@ -55,6 +55,7 @@ Contents:
    ti/cpsw_switchdev
    ti/am65_nuss_cpsw_switchdev
    ti/tlan
+   ti/icssg_prueth
    wangxun/txgbe
    wangxun/ngbe
 
diff --git a/Documentation/networking/device_drivers/ethernet/ti/icssg_prueth.rst b/Documentation/networking/device_drivers/ethernet/ti/icssg_prueth.rst
new file mode 100644
index 000000000000..da21ddf431bb
--- /dev/null
+++ b/Documentation/networking/device_drivers/ethernet/ti/icssg_prueth.rst
@@ -0,0 +1,56 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============================================
+Texas Instruments ICSSG PRUETH ethernet driver
+==============================================
+
+:Version: 1.0
+
+ICSSG Firmware
+==============
+
+Every ICSSG core has two Programmable Real-Time Unit(PRUs), two auxiliary
+Real-Time Transfer Unit (RTUs), and two Transmit Real-Time Transfer Units
+(TX_PRUs). Each one of these runs its own firmware. The firmwares combnined are
+referred as ICSSG Firmware.
+
+Firmware Statistics
+===================
+
+The ICSSG firmware maintains certain statistics which are dumped by the driver
+via ``ethtool -S <interface>``
+
+These statistics are as follows,
+
+ - ``FW_RTU_PKT_DROP``: Diagnostic error counter which increments when RTU drops a locally injected packet due to port being disabled or rule violation.
+ - ``FW_Q0_OVERFLOW``: TX overflow counter for queue0
+ - ``FW_Q1_OVERFLOW``: TX overflow counter for queue1
+ - ``FW_Q2_OVERFLOW``: TX overflow counter for queue2
+ - ``FW_Q3_OVERFLOW``: TX overflow counter for queue3
+ - ``FW_Q4_OVERFLOW``: TX overflow counter for queue4
+ - ``FW_Q5_OVERFLOW``: TX overflow counter for queue5
+ - ``FW_Q6_OVERFLOW``: TX overflow counter for queue6
+ - ``FW_Q7_OVERFLOW``: TX overflow counter for queue7
+ - ``FW_DROPPED_PKT``: This counter is incremented when a packet is dropped at PRU because of rule violation.
+ - ``FW_RX_ERROR``: Incremented if there was a CRC error or Min/Max frame error at PRU
+ - ``FW_RX_DS_INVALID``: Incremented when RTU detects Data Status invalid condition
+ - ``FW_TX_DROPPED_PACKET``: Counter for packets dropped via TX Port
+ - ``FW_TX_TS_DROPPED_PACKET``: Counter for packets with TS flag dropped via TX Port
+ - ``FW_INF_PORT_DISABLED``: Incremented when RX frame is dropped due to port being disabled
+ - ``FW_INF_SAV``: Incremented when RX frame is dropped due to Source Address violation
+ - ``FW_INF_SA_DL``: Incremented when RX frame is dropped due to Source Address being in the denylist
+ - ``FW_INF_PORT_BLOCKED``: Incremented when RX frame is dropped due to port being blocked and frame being a special frame
+ - ``FW_INF_DROP_TAGGED`` : Incremented when RX frame is dropped for being tagged
+ - ``FW_INF_DROP_PRIOTAGGED``: Incremented when RX frame is dropped for being priority tagged
+ - ``FW_INF_DROP_NOTAG``: Incremented when RX frame is dropped for being untagged
+ - ``FW_INF_DROP_NOTMEMBER``: Incremented when RX frame is dropped for port not being member of VLAN
+ - ``FW_RX_EOF_SHORT_FRMERR``: Incremented if End Of Frame (EOF) task is scheduled without seeing RX_B1
+ - ``FW_RX_B0_DROP_EARLY_EOF``: Incremented when frame is dropped due to Early EOF
+ - ``FW_TX_JUMBO_FRM_CUTOFF``: Incremented when frame is cut off to prevent packet size > 2000 Bytes
+ - ``FW_RX_EXP_FRAG_Q_DROP``: Incremented when express frame is received in the same queue as the previous fragment
+ - ``FW_RX_FIFO_OVERRUN``: RX fifo overrun counter
+ - ``FW_CUT_THR_PKT``: Incremented when a packet is forwarded using Cut-Through forwarding method
+ - ``FW_HOST_RX_PKT_CNT``: Number of valid packets sent by Rx PRU to Host on PSI
+ - ``FW_HOST_TX_PKT_CNT``: Number of valid packets copied by RTU0 to Tx queues
+ - ``FW_HOST_EGRESS_Q_PRE_OVERFLOW``: Host Egress Q (Pre-emptible) Overflow Counter
+ - ``FW_HOST_EGRESS_Q_EXP_OVERFLOW``: Host Egress Q (Pre-emptible) Overflow Counter
diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
index b4be76e13a2f..79f2d86acf21 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -1318,10 +1318,28 @@ void icssg_ndo_get_stats64(struct net_device *ndev,
 	stats->rx_over_errors = emac_get_stat_by_name(emac, "rx_over_errors");
 	stats->multicast      = emac_get_stat_by_name(emac, "rx_multicast_frames");
 
-	stats->rx_errors  = ndev->stats.rx_errors;
-	stats->rx_dropped = ndev->stats.rx_dropped;
+	stats->rx_errors  = ndev->stats.rx_errors +
+			    emac_get_stat_by_name(emac, "FW_RX_ERROR") +
+			    emac_get_stat_by_name(emac, "FW_RX_EOF_SHORT_FRMERR") +
+			    emac_get_stat_by_name(emac, "FW_RX_B0_DROP_EARLY_EOF") +
+			    emac_get_stat_by_name(emac, "FW_RX_EXP_FRAG_Q_DROP") +
+			    emac_get_stat_by_name(emac, "FW_RX_FIFO_OVERRUN");
+	stats->rx_dropped = ndev->stats.rx_dropped +
+			    emac_get_stat_by_name(emac, "FW_DROPPED_PKT") +
+			    emac_get_stat_by_name(emac, "FW_INF_PORT_DISABLED") +
+			    emac_get_stat_by_name(emac, "FW_INF_SAV") +
+			    emac_get_stat_by_name(emac, "FW_INF_SA_DL") +
+			    emac_get_stat_by_name(emac, "FW_INF_PORT_BLOCKED") +
+			    emac_get_stat_by_name(emac, "FW_INF_DROP_TAGGED") +
+			    emac_get_stat_by_name(emac, "FW_INF_DROP_PRIOTAGGED") +
+			    emac_get_stat_by_name(emac, "FW_INF_DROP_NOTAG") +
+			    emac_get_stat_by_name(emac, "FW_INF_DROP_NOTMEMBER");
 	stats->tx_errors  = ndev->stats.tx_errors;
-	stats->tx_dropped = ndev->stats.tx_dropped;
+	stats->tx_dropped = ndev->stats.tx_dropped +
+			    emac_get_stat_by_name(emac, "FW_RTU_PKT_DROP") +
+			    emac_get_stat_by_name(emac, "FW_TX_DROPPED_PACKET") +
+			    emac_get_stat_by_name(emac, "FW_TX_TS_DROPPED_PACKET") +
+			    emac_get_stat_by_name(emac, "FW_TX_JUMBO_FRM_CUTOFF");
 }
 EXPORT_SYMBOL_GPL(icssg_ndo_get_stats64);
 
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index b6be4aa57a61..23c465f1ce7f 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -54,7 +54,7 @@
 
 #define ICSSG_MAX_RFLOWS	8	/* per slice */
 
-#define ICSSG_NUM_PA_STATS	4
+#define ICSSG_NUM_PA_STATS	32
 #define ICSSG_NUM_MIIG_STATS	60
 /* Number of ICSSG related stats */
 #define ICSSG_NUM_STATS (ICSSG_NUM_MIIG_STATS + ICSSG_NUM_PA_STATS)
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
index 6f0edae38ea2..e8241e998aa9 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
@@ -11,7 +11,6 @@
 
 #define ICSSG_TX_PACKET_OFFSET	0xA0
 #define ICSSG_TX_BYTE_OFFSET	0xEC
-#define ICSSG_FW_STATS_BASE	0x0248
 
 static u32 stats_base[] = {	0x54c,	/* Slice 0 stats start */
 				0xb18,	/* Slice 1 stats start */
@@ -46,9 +45,8 @@ void emac_update_hardware_stats(struct prueth_emac *emac)
 
 	if (prueth->pa_stats) {
 		for (i = 0; i < ARRAY_SIZE(icssg_all_pa_stats); i++) {
-			reg = ICSSG_FW_STATS_BASE +
-			      icssg_all_pa_stats[i].offset *
-			      PRUETH_NUM_MACS + slice * sizeof(u32);
+			reg = icssg_all_pa_stats[i].offset +
+			      slice * sizeof(u32);
 			regmap_read(prueth->pa_stats, reg, &val);
 			emac->pa_stats[i] += val;
 		}
@@ -80,7 +78,7 @@ int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name)
 	if (emac->prueth->pa_stats) {
 		for (i = 0; i < ARRAY_SIZE(icssg_all_pa_stats); i++) {
 			if (!strcmp(icssg_all_pa_stats[i].name, stat_name))
-				return emac->pa_stats[icssg_all_pa_stats[i].offset / sizeof(u32)];
+				return emac->pa_stats[i];
 		}
 	}
 
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/net/ethernet/ti/icssg/icssg_stats.h
index e88b919f532c..5ec0b38e0c67 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
@@ -155,24 +155,10 @@ static const struct icssg_miig_stats icssg_all_miig_stats[] = {
 	ICSSG_MIIG_STATS(tx_bytes, true),
 };
 
-/**
- * struct pa_stats_regs - ICSSG Firmware maintained PA Stats register
- * @fw_rx_cnt: Number of valid packets sent by Rx PRU to Host on PSI
- * @fw_tx_cnt: Number of valid packets copied by RTU0 to Tx queues
- * @fw_tx_pre_overflow: Host Egress Q (Pre-emptible) Overflow Counter
- * @fw_tx_exp_overflow: Host Egress Q (Express) Overflow Counter
- */
-struct pa_stats_regs {
-	u32 fw_rx_cnt;
-	u32 fw_tx_cnt;
-	u32 fw_tx_pre_overflow;
-	u32 fw_tx_exp_overflow;
-};
-
-#define ICSSG_PA_STATS(field)			\
-{						\
-	#field,					\
-	offsetof(struct pa_stats_regs, field),	\
+#define ICSSG_PA_STATS(field)	\
+{				\
+	#field,			\
+	field,			\
 }
 
 struct icssg_pa_stats {
@@ -181,10 +167,38 @@ struct icssg_pa_stats {
 };
 
 static const struct icssg_pa_stats icssg_all_pa_stats[] = {
-	ICSSG_PA_STATS(fw_rx_cnt),
-	ICSSG_PA_STATS(fw_tx_cnt),
-	ICSSG_PA_STATS(fw_tx_pre_overflow),
-	ICSSG_PA_STATS(fw_tx_exp_overflow),
+	ICSSG_PA_STATS(FW_RTU_PKT_DROP),
+	ICSSG_PA_STATS(FW_Q0_OVERFLOW),
+	ICSSG_PA_STATS(FW_Q1_OVERFLOW),
+	ICSSG_PA_STATS(FW_Q2_OVERFLOW),
+	ICSSG_PA_STATS(FW_Q3_OVERFLOW),
+	ICSSG_PA_STATS(FW_Q4_OVERFLOW),
+	ICSSG_PA_STATS(FW_Q5_OVERFLOW),
+	ICSSG_PA_STATS(FW_Q6_OVERFLOW),
+	ICSSG_PA_STATS(FW_Q7_OVERFLOW),
+	ICSSG_PA_STATS(FW_DROPPED_PKT),
+	ICSSG_PA_STATS(FW_RX_ERROR),
+	ICSSG_PA_STATS(FW_RX_DS_INVALID),
+	ICSSG_PA_STATS(FW_TX_DROPPED_PACKET),
+	ICSSG_PA_STATS(FW_TX_TS_DROPPED_PACKET),
+	ICSSG_PA_STATS(FW_INF_PORT_DISABLED),
+	ICSSG_PA_STATS(FW_INF_SAV),
+	ICSSG_PA_STATS(FW_INF_SA_DL),
+	ICSSG_PA_STATS(FW_INF_PORT_BLOCKED),
+	ICSSG_PA_STATS(FW_INF_DROP_TAGGED),
+	ICSSG_PA_STATS(FW_INF_DROP_PRIOTAGGED),
+	ICSSG_PA_STATS(FW_INF_DROP_NOTAG),
+	ICSSG_PA_STATS(FW_INF_DROP_NOTMEMBER),
+	ICSSG_PA_STATS(FW_RX_EOF_SHORT_FRMERR),
+	ICSSG_PA_STATS(FW_RX_B0_DROP_EARLY_EOF),
+	ICSSG_PA_STATS(FW_TX_JUMBO_FRM_CUTOFF),
+	ICSSG_PA_STATS(FW_RX_EXP_FRAG_Q_DROP),
+	ICSSG_PA_STATS(FW_RX_FIFO_OVERRUN),
+	ICSSG_PA_STATS(FW_CUT_THR_PKT),
+	ICSSG_PA_STATS(FW_HOST_RX_PKT_CNT),
+	ICSSG_PA_STATS(FW_HOST_TX_PKT_CNT),
+	ICSSG_PA_STATS(FW_HOST_EGRESS_Q_PRE_OVERFLOW),
+	ICSSG_PA_STATS(FW_HOST_EGRESS_Q_EXP_OVERFLOW),
 };
 
 #endif /* __NET_TI_ICSSG_STATS_H */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
index 424a7e945ea8..490a9cc06fb0 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
@@ -231,4 +231,37 @@
 /* Start of 32 bits PA_STAT counters */
 #define PA_STAT_32b_START_OFFSET                           0x0080
 
+#define FW_RTU_PKT_DROP			0x0088
+#define FW_Q0_OVERFLOW			0x0090
+#define FW_Q1_OVERFLOW			0x0098
+#define FW_Q2_OVERFLOW			0x00A0
+#define FW_Q3_OVERFLOW			0x00A8
+#define FW_Q4_OVERFLOW			0x00B0
+#define FW_Q5_OVERFLOW			0x00B8
+#define FW_Q6_OVERFLOW			0x00C0
+#define FW_Q7_OVERFLOW			0x00C8
+#define FW_DROPPED_PKT			0x00F8
+#define FW_RX_ERROR			0x0100
+#define FW_RX_DS_INVALID		0x0108
+#define FW_TX_DROPPED_PACKET		0x0110
+#define FW_TX_TS_DROPPED_PACKET		0x0118
+#define FW_INF_PORT_DISABLED		0x0120
+#define FW_INF_SAV			0x0128
+#define FW_INF_SA_DL			0x0130
+#define FW_INF_PORT_BLOCKED		0x0138
+#define FW_INF_DROP_TAGGED		0x0140
+#define FW_INF_DROP_PRIOTAGGED		0x0148
+#define FW_INF_DROP_NOTAG		0x0150
+#define FW_INF_DROP_NOTMEMBER		0x0158
+#define FW_RX_EOF_SHORT_FRMERR		0x0188
+#define FW_RX_B0_DROP_EARLY_EOF		0x0190
+#define FW_TX_JUMBO_FRM_CUTOFF		0x0198
+#define FW_RX_EXP_FRAG_Q_DROP		0x01A0
+#define FW_RX_FIFO_OVERRUN		0x01A8
+#define FW_CUT_THR_PKT			0x01B0
+#define FW_HOST_RX_PKT_CNT		0x0248
+#define FW_HOST_TX_PKT_CNT		0x0250
+#define FW_HOST_EGRESS_Q_PRE_OVERFLOW	0x0258
+#define FW_HOST_EGRESS_Q_EXP_OVERFLOW	0x0260
+
 #endif /* __NET_TI_ICSSG_SWITCH_MAP_H  */

base-commit: 07e32237ed9d3f5815fb900dee9458b5f115a678
-- 
2.34.1


