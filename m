Return-Path: <netdev+bounces-98987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 744328D351A
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 13:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA9B6B241E9
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 11:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5111667E7;
	Wed, 29 May 2024 11:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SthJDRBu"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC7D15B12B;
	Wed, 29 May 2024 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716980788; cv=none; b=djRySqvApU5RC96qCpXgS8wEnqFORtT5/Aq+Wg29JtykMJG58u4bPSXkHZJe5rAbdooMiEb8UZrb9T0AA+yBsgair50W7R/VelUDi9Zm5wYMcATb/0vw6+KMekzR4JwWByTcRQRHpI5nR93rEGTd5QKCWb3xhcNXDGfrRJwHfYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716980788; c=relaxed/simple;
	bh=kKPPVUMD2TYcS5ShO5J9SKYPjEvVUGyhNEAlBK3Z70A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I1yAfplRzKQuxdfnEuApGc8aezz6Cc9VRgsW80htvWW66myvCEMxYg62zI3xTzkhXBduyuYbdfLKrUamWJVvNAh3JMm0Y55/ynH24OVCze3tW+fZmXHwNGVOI/GknOfDfPZewcqgbRNqKWjOcDiFrJHM6xiQuHdoyRkzrffTMgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SthJDRBu; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44TB5vnG003409;
	Wed, 29 May 2024 06:05:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716980757;
	bh=7MgOY9kdreM+vPTMIhw2c2Lnd4ERhmEO9KYfTGuQAmc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=SthJDRBuudcyCTDZQybEu7hvrVm+7tgPH1ikI75BcAYCHugKYsM516Mxjw/V4vsZE
	 4iIMaMb2EjMaBMS2AlPrQrKg+t19rBP0UwkPvfTv9dpoBF9ODOGPUcd8P0gav6+TuN
	 tY18X03LNVTDA9LvD18S8zlCO1pwSO/+chZ/bOUs=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44TB5v7O107539
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 29 May 2024 06:05:57 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 29
 May 2024 06:05:56 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 29 May 2024 06:05:56 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44TB5usr036003;
	Wed, 29 May 2024 06:05:56 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 44TB5t7D016494;
	Wed, 29 May 2024 06:05:56 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Jan Kiszka <jan.kiszka@siemens.com>,
        Dan Carpenter
	<dan.carpenter@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>, Simon Horman
	<horms@kernel.org>,
        Diogo Ivo <diogo.ivo@siemens.com>,
        Wolfram Sang
	<wsa+renesas@sang-engineering.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Vladimir Oltean
	<vladimir.oltean@nxp.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard
 Cochran <richardcochran@gmail.com>,
        Roger Quadros <rogerq@kernel.org>,
        MD
 Danish Anwar <danishanwar@ti.com>, Paolo Abeni <pabeni@redhat.com>,
        Jakub
 Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>
Subject: [PATCH net-next v8 1/2] net: ti: icssg: Move icss_iep structure
Date: Wed, 29 May 2024 16:35:50 +0530
Message-ID: <20240529110551.620907-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529110551.620907-1-danishanwar@ti.com>
References: <20240529110551.620907-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Move icss_iep structure definition and prueth_iep_gettime to icss_iep.h
and icssg_prueth.h file respectively so that they can be used / accessed
by all icssg driver files.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icss_iep.c     | 72 -------------------
 drivers/net/ethernet/ti/icssg/icss_iep.h     | 73 +++++++++++++++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c |  2 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  2 +
 4 files changed, 75 insertions(+), 74 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
index 3025e9c18970..915cd4fda53c 100644
--- a/drivers/net/ethernet/ti/icssg/icss_iep.c
+++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
@@ -52,78 +52,6 @@
 #define IEP_CAP_CFG_CAPNR_1ST_EVENT_EN(n)	BIT(LATCH_INDEX(n))
 #define IEP_CAP_CFG_CAP_ASYNC_EN(n)		BIT(LATCH_INDEX(n) + 10)
 
-enum {
-	ICSS_IEP_GLOBAL_CFG_REG,
-	ICSS_IEP_GLOBAL_STATUS_REG,
-	ICSS_IEP_COMPEN_REG,
-	ICSS_IEP_SLOW_COMPEN_REG,
-	ICSS_IEP_COUNT_REG0,
-	ICSS_IEP_COUNT_REG1,
-	ICSS_IEP_CAPTURE_CFG_REG,
-	ICSS_IEP_CAPTURE_STAT_REG,
-
-	ICSS_IEP_CAP6_RISE_REG0,
-	ICSS_IEP_CAP6_RISE_REG1,
-
-	ICSS_IEP_CAP7_RISE_REG0,
-	ICSS_IEP_CAP7_RISE_REG1,
-
-	ICSS_IEP_CMP_CFG_REG,
-	ICSS_IEP_CMP_STAT_REG,
-	ICSS_IEP_CMP0_REG0,
-	ICSS_IEP_CMP0_REG1,
-	ICSS_IEP_CMP1_REG0,
-	ICSS_IEP_CMP1_REG1,
-
-	ICSS_IEP_CMP8_REG0,
-	ICSS_IEP_CMP8_REG1,
-	ICSS_IEP_SYNC_CTRL_REG,
-	ICSS_IEP_SYNC0_STAT_REG,
-	ICSS_IEP_SYNC1_STAT_REG,
-	ICSS_IEP_SYNC_PWIDTH_REG,
-	ICSS_IEP_SYNC0_PERIOD_REG,
-	ICSS_IEP_SYNC1_DELAY_REG,
-	ICSS_IEP_SYNC_START_REG,
-	ICSS_IEP_MAX_REGS,
-};
-
-/**
- * struct icss_iep_plat_data - Plat data to handle SoC variants
- * @config: Regmap configuration data
- * @reg_offs: register offsets to capture offset differences across SoCs
- * @flags: Flags to represent IEP properties
- */
-struct icss_iep_plat_data {
-	struct regmap_config *config;
-	u32 reg_offs[ICSS_IEP_MAX_REGS];
-	u32 flags;
-};
-
-struct icss_iep {
-	struct device *dev;
-	void __iomem *base;
-	const struct icss_iep_plat_data *plat_data;
-	struct regmap *map;
-	struct device_node *client_np;
-	unsigned long refclk_freq;
-	int clk_tick_time;	/* one refclk tick time in ns */
-	struct ptp_clock_info ptp_info;
-	struct ptp_clock *ptp_clock;
-	struct mutex ptp_clk_mutex;	/* PHC access serializer */
-	spinlock_t irq_lock; /* CMP IRQ vs icss_iep_ptp_enable access */
-	u32 def_inc;
-	s16 slow_cmp_inc;
-	u32 slow_cmp_count;
-	const struct icss_iep_clockops *ops;
-	void *clockops_data;
-	u32 cycle_time_ns;
-	u32 perout_enabled;
-	bool pps_enabled;
-	int cap_cmp_irq;
-	u64 period;
-	u32 latch_enable;
-};
-
 /**
  * icss_iep_get_count_hi() - Get the upper 32 bit IEP counter
  * @iep: Pointer to structure representing IEP.
diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.h b/drivers/net/ethernet/ti/icssg/icss_iep.h
index 803a4b714893..ca84bfc56185 100644
--- a/drivers/net/ethernet/ti/icssg/icss_iep.h
+++ b/drivers/net/ethernet/ti/icssg/icss_iep.h
@@ -12,7 +12,78 @@
 #include <linux/ptp_clock_kernel.h>
 #include <linux/regmap.h>
 
-struct icss_iep;
+enum {
+	ICSS_IEP_GLOBAL_CFG_REG,
+	ICSS_IEP_GLOBAL_STATUS_REG,
+	ICSS_IEP_COMPEN_REG,
+	ICSS_IEP_SLOW_COMPEN_REG,
+	ICSS_IEP_COUNT_REG0,
+	ICSS_IEP_COUNT_REG1,
+	ICSS_IEP_CAPTURE_CFG_REG,
+	ICSS_IEP_CAPTURE_STAT_REG,
+
+	ICSS_IEP_CAP6_RISE_REG0,
+	ICSS_IEP_CAP6_RISE_REG1,
+
+	ICSS_IEP_CAP7_RISE_REG0,
+	ICSS_IEP_CAP7_RISE_REG1,
+
+	ICSS_IEP_CMP_CFG_REG,
+	ICSS_IEP_CMP_STAT_REG,
+	ICSS_IEP_CMP0_REG0,
+	ICSS_IEP_CMP0_REG1,
+	ICSS_IEP_CMP1_REG0,
+	ICSS_IEP_CMP1_REG1,
+
+	ICSS_IEP_CMP8_REG0,
+	ICSS_IEP_CMP8_REG1,
+	ICSS_IEP_SYNC_CTRL_REG,
+	ICSS_IEP_SYNC0_STAT_REG,
+	ICSS_IEP_SYNC1_STAT_REG,
+	ICSS_IEP_SYNC_PWIDTH_REG,
+	ICSS_IEP_SYNC0_PERIOD_REG,
+	ICSS_IEP_SYNC1_DELAY_REG,
+	ICSS_IEP_SYNC_START_REG,
+	ICSS_IEP_MAX_REGS,
+};
+
+/**
+ * struct icss_iep_plat_data - Plat data to handle SoC variants
+ * @config: Regmap configuration data
+ * @reg_offs: register offsets to capture offset differences across SoCs
+ * @flags: Flags to represent IEP properties
+ */
+struct icss_iep_plat_data {
+	struct regmap_config *config;
+	u32 reg_offs[ICSS_IEP_MAX_REGS];
+	u32 flags;
+};
+
+struct icss_iep {
+	struct device *dev;
+	void __iomem *base;
+	const struct icss_iep_plat_data *plat_data;
+	struct regmap *map;
+	struct device_node *client_np;
+	unsigned long refclk_freq;
+	int clk_tick_time;	/* one refclk tick time in ns */
+	struct ptp_clock_info ptp_info;
+	struct ptp_clock *ptp_clock;
+	struct mutex ptp_clk_mutex;	/* PHC access serializer */
+	spinlock_t irq_lock; /* CMP IRQ vs icss_iep_ptp_enable access */
+	u32 def_inc;
+	s16 slow_cmp_inc;
+	u32 slow_cmp_count;
+	const struct icss_iep_clockops *ops;
+	void *clockops_data;
+	u32 cycle_time_ns;
+	u32 perout_enabled;
+	bool pps_enabled;
+	int cap_cmp_irq;
+	u64 period;
+	u32 latch_enable;
+};
+
 extern const struct icss_iep_clockops prueth_iep_clockops;
 
 /* Firmware specific clock operations */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 1ea3fbd5e954..3bd5caf26851 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -284,7 +284,7 @@ static int emac_phy_connect(struct prueth_emac *emac)
 	return 0;
 }
 
-static u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp *sts)
+u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp *sts)
 {
 	u32 hi_rollover_count, hi_rollover_count_r;
 	struct prueth_emac *emac = clockops_data;
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index a78c5eb75fb8..208fb78fb71f 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -320,6 +320,8 @@ void emac_stats_work_handler(struct work_struct *work);
 void emac_update_hardware_stats(struct prueth_emac *emac);
 int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name);
 
+u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp *sts);
+
 /* Common functions */
 void prueth_cleanup_rx_chns(struct prueth_emac *emac,
 			    struct prueth_rx_chn *rx_chn,
-- 
2.34.1


