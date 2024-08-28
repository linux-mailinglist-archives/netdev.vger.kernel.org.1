Return-Path: <netdev+bounces-122689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E67962333
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 11:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC38D1F21E3B
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 09:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E7015F3E6;
	Wed, 28 Aug 2024 09:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bHfwtuv/"
X-Original-To: netdev@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FDC15C15D;
	Wed, 28 Aug 2024 09:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724836770; cv=none; b=gB/bbRdNZQZUMN3IRlf7YKfdLd4L7M5eXyT6AIZCox+0j3fSmH/QJ07sBcDTG2QShRScPFoQXsBfg7yz1zdWV7449UCDAIoKJ7uglrxgFvor+Rql/mz6pQpH6t6eCh/HfQcfwNNa9txt32P/9qG6YJcOetur3SJAzahHPEq17sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724836770; c=relaxed/simple;
	bh=VKqn019mXiAcIfDFDHE3reE1n3mGO3rMm6Hmb4BNhV4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=so+ELcSgdM3ePFMYR1kqPxfW9bUI7qupNKpvpYhrUp1BathBuNteSkhHiO3DIg216sLsnrrufams/xsvO7NMcZssn2WtlP+cZAWQ1QijhPc7PY9rBbJcvebD7Gs3HQfgMOVEaXSTtUlxOtEkKf3tkdK9uQfFMBFGKL3q11MwAIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bHfwtuv/; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47S9J683080825;
	Wed, 28 Aug 2024 04:19:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724836746;
	bh=npGJAiff1Ez+ejGbIez+fqU5Qyxj2AEDK+MljLWNnsg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=bHfwtuv/i64HYEq6eN+z0+8mw8J17xNBKOPOR2JxACDYxcB0uVepKNftxnL9QAH4V
	 +bY6Au7IxACZOig0D5Gr6A7BdwcnRtMXix7WbfQC6+tqcXvZMcOs1sB2nl1GwDaeXx
	 fyC8VDAc2J0VyDtgWESUhA84ZxZgvPxn+deJHveI=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47S9J688068029
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Aug 2024 04:19:06 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Aug 2024 04:19:05 -0500
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Aug 2024 04:19:06 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47S9J54b054743;
	Wed, 28 Aug 2024 04:19:05 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 47S9J5G5007461;
	Wed, 28 Aug 2024 04:19:05 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Andrew Lunn <andrew@lunn.ch>, Dan Carpenter <dan.carpenter@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Javier Carrasco
	<javier.carrasco.cruz@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Diogo Ivo <diogo.ivo@siemens.com>, Simon Horman <horms@kernel.org>,
        Richard
 Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next v3 1/6] net: ti: icss-iep: Move icss_iep structure
Date: Wed, 28 Aug 2024 14:48:56 +0530
Message-ID: <20240828091901.3120935-2-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828091901.3120935-1-danishanwar@ti.com>
References: <20240828091901.3120935-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Move icss_iep structure definition and to icss_iep.h file so that the
structure members can be used / accessed by all icssg driver files.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/icssg/icss_iep.c | 72 -----------------------
 drivers/net/ethernet/ti/icssg/icss_iep.h | 73 +++++++++++++++++++++++-
 2 files changed, 72 insertions(+), 73 deletions(-)

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
index 803a4b714893..0bdca0155abd 100644
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
-- 
2.34.1


