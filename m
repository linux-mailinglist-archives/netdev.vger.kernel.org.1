Return-Path: <netdev+bounces-170177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29ADBA47967
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 10:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2194A1721C5
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 09:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E09226170;
	Thu, 27 Feb 2025 09:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="y9YduzUA"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AE3270024;
	Thu, 27 Feb 2025 09:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740649055; cv=none; b=Rkiss/o0rISqjvi2ZMBnh1JmGijWMP7gEGWJ5wtfqVtXYRe8ldmRvstUVvSfl3rSpviRiGOa8+ZY+/O8XdVX5W01FfO4ie7dpfTYK9IIew1l8in10t9hz76JlaOt8mBfZ6Fw5a2LADvTTNZvciKWpT3XwScV6p/NAO7ml7NSXe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740649055; c=relaxed/simple;
	bh=s8jxRtmEa4JXDMzCHRkJA86F/q/YoZVW0KQQZ4JSHJs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u7z2X8s2qMKfYQ+JvD1x+0sH82+BSFCAzzarAE5VE+4l51DT3dEco2wmhtuDrl3V+++dOZr1gNooLYHh5RABJZ6hvCoDLOlrYD/ttL/GOQ5RTbdelGfVxM/foHcaS7vVuxz7T2uZZmPZKqgd7aw9BYp+aMq1dXXx2aU3ySks4EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=y9YduzUA; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51R9bHOY2343129
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 03:37:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1740649037;
	bh=O7xVApe7OWt5Xaf5TUGNDnUX/j980sFAxGJ2aaz5evQ=;
	h=From:To:CC:Subject:Date;
	b=y9YduzUArvEuguZPJwviT0cS5Jj9prSjk7dvAFgbEekurVyGrKvt4b5D5HAGA9oUd
	 dH1AM3K2Zq96uypvaRSZBG48d3r8pYcWwIWSvfvtqyMLY5XswPwEkBE4PNaxABJMkQ
	 6fpSgt1zCUKUwzs9dQtb/woG9A253oFRA9uARr+k=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51R9bHUG039975
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Feb 2025 03:37:17 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Feb 2025 03:37:17 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Feb 2025 03:37:17 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51R9bH7q057513;
	Thu, 27 Feb 2025 03:37:17 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 51R9bGXH008583;
	Thu, 27 Feb 2025 03:37:16 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: Meghana Malladi <m-malladi@ti.com>, Diogo Ivo <diogo.ivo@siemens.com>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric
 Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next] net: ti: icssg-prueth: Add ICSSG FW Stats
Date: Thu, 27 Feb 2025 15:07:12 +0530
Message-ID: <20250227093712.2130561-1-danishanwar@ti.com>
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

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   2 +-
 drivers/net/ethernet/ti/icssg/icssg_stats.c   |   6 +-
 drivers/net/ethernet/ti/icssg/icssg_stats.h   |  63 +++++++----
 .../net/ethernet/ti/icssg/icssg_switch_map.h  | 105 ++++++++++++++++++
 4 files changed, 149 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 329b46e9ee53..569d3d53db59 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -50,7 +50,7 @@
 
 #define ICSSG_MAX_RFLOWS	8	/* per slice */
 
-#define ICSSG_NUM_PA_STATS	4
+#define ICSSG_NUM_PA_STATS	37
 #define ICSSG_NUM_MIIG_STATS	60
 /* Number of ICSSG related stats */
 #define ICSSG_NUM_STATS (ICSSG_NUM_MIIG_STATS + ICSSG_NUM_PA_STATS)
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.c b/drivers/net/ethernet/ti/icssg/icssg_stats.c
index 8800bd3a8d07..3f1400e0207c 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_stats.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_stats.c
@@ -11,7 +11,6 @@
 
 #define ICSSG_TX_PACKET_OFFSET	0xA0
 #define ICSSG_TX_BYTE_OFFSET	0xEC
-#define ICSSG_FW_STATS_BASE	0x0248
 
 static u32 stats_base[] = {	0x54c,	/* Slice 0 stats start */
 				0xb18,	/* Slice 1 stats start */
@@ -44,9 +43,8 @@ void emac_update_hardware_stats(struct prueth_emac *emac)
 
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
diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/net/ethernet/ti/icssg/icssg_stats.h
index e88b919f532c..8d0fe42a5a41 100644
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
@@ -181,10 +167,43 @@ struct icssg_pa_stats {
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
+	ICSSG_PA_STATS(FW_INF_SA_BL),
+	ICSSG_PA_STATS(FW_INF_PORT_BLOCKED),
+	ICSSG_PA_STATS(FW_INF_DROP_TAGGED),
+	ICSSG_PA_STATS(FW_INF_DROP_PRIOTAGGED),
+	ICSSG_PA_STATS(FW_INF_DROP_NOTAG),
+	ICSSG_PA_STATS(FW_INF_DROP_NOTMEMBER),
+	ICSSG_PA_STATS(FW_PREEMPT_BAD_FRAG),
+	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_ERR),
+	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_TX),
+	ICSSG_PA_STATS(FW_PREEMPT_ASSEMBLY_OK),
+	ICSSG_PA_STATS(FW_PREEMPT_FRAG_CNT_RX),
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
index 424a7e945ea8..d30203a0978c 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_switch_map.h
@@ -231,4 +231,109 @@
 /* Start of 32 bits PA_STAT counters */
 #define PA_STAT_32b_START_OFFSET                           0x0080
 
+/* Diagnostic error counter which increments when RTU drops a locally injected
+ * packet due to port disabled or rule violation.
+ */
+#define FW_RTU_PKT_DROP		0x0088
+
+/* Tx Queue Overflow Counters */
+#define FW_Q0_OVERFLOW		0x0090
+#define FW_Q1_OVERFLOW		0x0098
+#define FW_Q2_OVERFLOW		0x00A0
+#define FW_Q3_OVERFLOW		0x00A8
+#define FW_Q4_OVERFLOW		0x00B0
+#define FW_Q5_OVERFLOW		0x00B8
+#define FW_Q6_OVERFLOW		0x00C0
+#define FW_Q7_OVERFLOW		0x00C8
+
+/* Incremented if a packet is dropped at PRU because of a rule violation */
+#define FW_DROPPED_PKT		0x00F8
+
+/* Incremented if there was a CRC error or Min/Max frame error at PRU0 */
+#define FW_RX_ERROR		0x0100
+
+/* Incremented when RTU detects Data Status invalid condition */
+#define FW_RX_DS_INVALID	0x0108
+
+/* Counter for packets dropped via TX Port */
+#define FW_TX_DROPPED_PACKET	0x0110
+
+/* Counter for packets with TS flag dropped via TX Port */
+#define FW_TX_TS_DROPPED_PACKET	0x0118
+
+/* Incremented when RX frame is dropped due to port being disabled */
+#define FW_INF_PORT_DISABLED	0x0120
+
+/* Incremented when RX frame is dropped due to Source Address violation */
+#define FW_INF_SAV		0x0128
+
+/* Incremented when RX frame is dropped due to Source Address being black
+ * listed
+ */
+#define FW_INF_SA_BL		0x0130
+
+/* Incremented when RX frame is dropped due to port being blocked and frame
+ * is being a special frame
+ */
+#define FW_INF_PORT_BLOCKED	0x0138
+
+/* Incremented when RX frame is dropped for being tagged */
+#define FW_INF_DROP_TAGGED	0x0140
+
+/* Incremented when RX frame is dropped for being priority tagged */
+#define FW_INF_DROP_PRIOTAGGED	0x0148
+
+/* Incremented when RX frame is dropped for being untagged */
+#define FW_INF_DROP_NOTAG	0x0150
+
+/* Incremented when RX frame is dropped for port not being member of VLAN */
+#define FW_INF_DROP_NOTMEMBER	0x0158
+
+/* Bad fragment Error Counter */
+#define FW_PREEMPT_BAD_FRAG	0x0160
+
+/* Fragment assembly Error Counter */
+#define FW_PREEMPT_ASSEMBLY_ERR	0x0168
+
+/* Fragment count in TX */
+#define FW_PREEMPT_FRAG_CNT_TX	0x0170
+
+/* Assembly Completed */
+#define FW_PREEMPT_ASSEMBLY_OK	0x0178
+
+/* Fragments received */
+#define FW_PREEMPT_FRAG_CNT_RX	0x0180
+
+/* Incremented if EOF task is scheduled without seeing RX_B1 */
+#define FW_RX_EOF_SHORT_FRMERR	0x0188
+
+/* Incremented when frame is dropped due to Early EOF received in B0 */
+#define FW_RX_B0_DROP_EARLY_EOF	0x0190
+
+/* Incremented when frame is cut off to prevent packet size > 2000B */
+#define FW_TX_JUMBO_FRM_CUTOFF	0x0198
+
+/* Incremented when express frame is received in the same queue as the previous
+ * fragment
+ */
+#define FW_RX_EXP_FRAG_Q_DROP	0x01A0
+
+/* RX fifo overrun counter */
+#define FW_RX_FIFO_OVERRUN	0x01A8
+
+/* Cut-through packet Counter */
+#define FW_CUT_THR_PKT		0x01B0
+
+/* Number of valid packets sent by Rx PRU to Host on PSI */
+#define FW_HOST_RX_PKT_CNT	0x0248
+
+/* Number of valid packets copied by RTU0 to Tx queues */
+#define FW_HOST_TX_PKT_CNT	0x0250
+
+/* Host Egress Q (Pre-emptible) Overflow Counter */
+#define FW_HOST_EGRESS_Q_PRE_OVERFLOW 0x0258
+
+/* Host Egress Q (Pre-emptible) Overflow Counter */
+#define FW_HOST_EGRESS_Q_EXP_OVERFLOW 0x0260
+
 #endif /* __NET_TI_ICSSG_SWITCH_MAP_H  */

base-commit: 0493f7a54e5bcf490f943f7b25ec6e1051832f98
-- 
2.34.1


