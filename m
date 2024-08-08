Return-Path: <netdev+bounces-116793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE69994BBFA
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 13:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D269F1C209BE
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 11:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAC318C904;
	Thu,  8 Aug 2024 11:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FFg45Fa7"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CD618C327;
	Thu,  8 Aug 2024 11:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723115310; cv=none; b=unH1264rsG7lI5aV07PGntANfVfWTA0pWiOf/1pt6DDMOJ6bowOJYtZcjWvAXD0Y3QF0DDn+A32URIm6ngLnK/LtKQRTz21DOXrHf7/o5KywMNsE3jvlv84YG3tP0ktLrI288IDd1PT40vIebd3URPADSwUQokgUgfEQEt4FoHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723115310; c=relaxed/simple;
	bh=G+cg0S2rbVkbMk6EG1Ltrc7EDaQzCg/cGCnun1rHfLA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DD3PJXDFp6l4FsHomB03pLNWJQmSL2jMsOcyUgWk6uOJ5muP0U/i1zZFcAX7wGuju5TkJsIe1GIWX8TjbRxCZXIlT6YK7F8qzOLPGR/nB2f3NJDyrodjHnSA5kQ88M2UFRBJGxOqbDROK8Fkmm5wDG09lkVOO7UanrRa/6x5XeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FFg45Fa7; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 478B8DlD053053;
	Thu, 8 Aug 2024 06:08:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1723115293;
	bh=cJDHnbFzXsSFyr7PoTZRHdsllb5f/1mW2RxejXjN16s=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=FFg45Fa7BFpL4jf4OpFIyXudOrdL30hXr8HoBpbwvQaYOA74I+mYvTKpPQM95/+ep
	 b2q0UFHES4hRcNMu6MCdGXhucq5p65UolIAJG3ZQXuBESdO960TRjYWaJA2RZeyQSf
	 rw+8PsTTuvt5/EYGveBzIIZZ1b/L9YToPANZ8LSU=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 478B8Dqn078933
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Aug 2024 06:08:13 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Aug 2024 06:08:13 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Aug 2024 06:08:13 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 478B8Co0087689;
	Thu, 8 Aug 2024 06:08:12 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 478B8CrD012010;
	Thu, 8 Aug 2024 06:08:12 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Jan Kiszka <jan.kiszka@siemens.com>,
        Dan Carpenter
	<dan.carpenter@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>, Vignesh Raghavendra
	<vigneshr@ti.com>,
        Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Diogo
 Ivo <diogo.ivo@siemens.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Simon
 Horman <horms@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo
 Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>
Subject: [PATCH net-next 5/6] net: ti: icss-iep: Move icss_iep structure
Date: Thu, 8 Aug 2024 16:37:59 +0530
Message-ID: <20240808110800.1281716-6-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808110800.1281716-1-danishanwar@ti.com>
References: <20240808110800.1281716-1-danishanwar@ti.com>
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
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 drivers/net/ethernet/ti/icssg/icss_iep.c     | 72 -------------------
 drivers/net/ethernet/ti/icssg/icss_iep.h     | 74 +++++++++++++++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.c |  5 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h |  2 +
 4 files changed, 78 insertions(+), 75 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c b/drivers/net/ethernet/ti/icssg/icss_iep.c
index 75c294ce6fb6..5d6d1cf78e93 100644
--- a/drivers/net/ethernet/ti/icssg/icss_iep.c
+++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
@@ -53,78 +53,6 @@
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
-	const struct regmap_config *config;
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
-	struct work_struct work;
-};
-
 /**
  * icss_iep_get_count_hi() - Get the upper 32 bit IEP counter
  * @iep: Pointer to structure representing IEP.
diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.h b/drivers/net/ethernet/ti/icssg/icss_iep.h
index 803a4b714893..9283123349e8 100644
--- a/drivers/net/ethernet/ti/icssg/icss_iep.h
+++ b/drivers/net/ethernet/ti/icssg/icss_iep.h
@@ -12,7 +12,79 @@
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
+	const struct regmap_config *config;
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
+	struct work_struct work;
+};
+
 extern const struct icss_iep_clockops prueth_iep_clockops;
 
 /* Firmware specific clock operations */
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
index 85c9797b6238..778b41c16f2d 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -325,7 +325,7 @@ static int emac_phy_connect(struct prueth_emac *emac)
 	return 0;
 }
 
-static u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp *sts)
+u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp *sts)
 {
 	u32 hi_rollover_count, hi_rollover_count_r;
 	struct prueth_emac *emac = clockops_data;
@@ -384,7 +384,8 @@ static void prueth_iep_settime(void *clockops_data, u64 ns)
 	sc_desc.cyclecounter0_set = cyclecount & GENMASK(31, 0);
 	sc_desc.cyclecounter1_set = (cyclecount & GENMASK(63, 32)) >> 32;
 	sc_desc.iepcount_set = ns % cycletime;
-	sc_desc.CMP0_current = cycletime - 4; //Count from 0 to (cycle time)-4
+	/* Count from 0 to (cycle time) - emac->iep->def_inc */
+	sc_desc.CMP0_current = cycletime - emac->iep->def_inc;
 
 	memcpy_toio(sc_descp, &sc_desc, sizeof(sc_desc));
 
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
index 6cb1dce8b309..79e8577caf91 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
@@ -362,6 +362,8 @@ void icssg_stats_work_handler(struct work_struct *work);
 void emac_update_hardware_stats(struct prueth_emac *emac);
 int emac_get_stat_by_name(struct prueth_emac *emac, char *stat_name);
 
+u64 prueth_iep_gettime(void *clockops_data, struct ptp_system_timestamp *sts);
+
 /* Common functions */
 void prueth_cleanup_rx_chns(struct prueth_emac *emac,
 			    struct prueth_rx_chn *rx_chn,
-- 
2.34.1


