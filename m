Return-Path: <netdev+bounces-35927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A7B7ABD81
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 05:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id BD02A1F2334E
	for <lists+netdev@lfdr.de>; Sat, 23 Sep 2023 03:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE1864D;
	Sat, 23 Sep 2023 03:10:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957AB381;
	Sat, 23 Sep 2023 03:10:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEED31B2;
	Fri, 22 Sep 2023 20:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695438640; x=1726974640;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Zs7uT5rkXwBEP94Q3MOsbrrHL02FsNr/kLDkz8dRM58=;
  b=Q2d9C3uoNof/EYweUgrq6GOaX0y1ASjChJtanp5SluwTOl6732Ry4lUg
   TeKYhcFvVCLlXJapQtT9syo7X7dztbLNtealO8p3NH4Nxm2SMeN62voLC
   XYJ13PSqFa53P6Z+SFOjGEaH3qDC1aDQXIrCSgR49+qWVxwdsLumiWtsi
   9cK7xvCSSWyJRGBI+hRfnBpwypDLdut/3kpIs2QedGOKRK+JKd2qk2Kna
   CdnuYdrm66GGlHtfLHFxP9m5RODiJTXcKhDhe2q7UWPDWJGXij2LEl/dN
   A9CqQfwBu9oi905mnWqllP9LFL4GnegWpZnQSM4RKx941vQQd350fYRVL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="384819124"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="384819124"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 20:10:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="697417478"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="697417478"
Received: from pglc00352.png.intel.com ([10.221.235.155])
  by orsmga003.jf.intel.com with ESMTP; 22 Sep 2023 20:10:35 -0700
From: Rohan G Thomas <rohan.g.thomas@intel.com>
To: "David S . Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rohan G Thomas <rohan.g.thomas@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next 1/1] net: stmmac: xgmac: EST interrupts handling
Date: Sat, 23 Sep 2023 11:10:31 +0800
Message-Id: <20230923031031.21434-1-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Enabled the following EST related interrupts:
  1) Constant Gate Control Error (CGCE)
  2) Head-of-Line Blocking due to Scheduling (HLBS)
  3) Head-of-Line Blocking due to Frame Size (HLBF)
  4) Base Time Register error (BTRE)
  5) Switch to S/W owned list Complete (SWLC)
Also, add EST errors into the ethtool statistic.

The commit e49aa315cb01 ("net: stmmac: EST interrupts handling and
error reporting") and commit 9f298959191b ("net: stmmac: Add EST
errors into ethtool statistic") add EST interrupts handling and error
reporting support to DWMAC4 core. This patch enables the same support
for XGMAC.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    | 27 ++++++
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 89 +++++++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 7a8f47e7b728..75782b8cdfe9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -289,6 +289,33 @@
 #define XGMAC_PTOV_SHIFT		23
 #define XGMAC_SSWL			BIT(1)
 #define XGMAC_EEST			BIT(0)
+#define XGMAC_MTL_EST_STATUS		0x00001058
+#define XGMAC_BTRL			GENMASK(15, 8)
+#define XGMAC_BTRL_SHIFT		8
+#define XGMAC_BTRL_MAX			GENMASK(15, 8)
+#define XGMAC_CGCE			BIT(4)
+#define XGMAC_HLBS			BIT(3)
+#define XGMAC_HLBF			BIT(2)
+#define XGMAC_BTRE			BIT(1)
+#define XGMAC_SWLC			BIT(0)
+#define XGMAC_MTL_EST_SCH_ERR		0x00001060
+#define XGMAC_MTL_EST_FRM_SZ_ERR	0x00001064
+#define XGMAC_MTL_EST_FRM_SZ_CAP	0x00001068
+#define XGMAC_SZ_CAP_HBFS_MASK		GENMASK(14, 0)
+#define XGMAC_SZ_CAP_HBFQ_SHIFT		16
+#define XGMAC_SZ_CAP_HBFQ_MASK(val)	\
+	({					\
+		typeof(val) _val = (val);	\
+		(_val > 4 ? GENMASK(18, 16) :	\
+		 _val > 2 ? GENMASK(17, 16) :	\
+		 BIT(16));			\
+	})
+#define XGMAC_MTL_EST_INT_EN		0x00001070
+#define XGMAC_IECGCE			BIT(4)
+#define XGMAC_IEHS			BIT(3)
+#define XGMAC_IEHF			BIT(2)
+#define XGMAC_IEBE			BIT(1)
+#define XGMAC_IECC			BIT(0)
 #define XGMAC_MTL_EST_GCL_CONTROL	0x00001080
 #define XGMAC_BTR_LOW			0x0
 #define XGMAC_BTR_HIGH			0x1
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index f352be269deb..0af0aefa6656 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -1469,9 +1469,97 @@ static int dwxgmac3_est_configure(void __iomem *ioaddr, struct stmmac_est *cfg,
 		ctrl &= ~XGMAC_EEST;
 
 	writel(ctrl, ioaddr + XGMAC_MTL_EST_CONTROL);
+
+	/* Configure EST interrupt */
+	if (cfg->enable)
+		ctrl = XGMAC_IECGCE | XGMAC_IEHS | XGMAC_IEHF | XGMAC_IEBE |
+		       XGMAC_IECC;
+	else
+		ctrl = 0;
+
+	writel(ctrl, ioaddr + XGMAC_MTL_EST_INT_EN);
 	return 0;
 }
 
+static void dwxgmac3_est_irq_status(void __iomem *ioaddr,
+				    struct net_device *dev,
+				    struct stmmac_extra_stats *x, u32 txqcnt)
+{
+	u32 status, value, feqn, hbfq, hbfs, btrl;
+	u32 txqcnt_mask = BIT(txqcnt) - 1;
+
+	status = readl(ioaddr + XGMAC_MTL_EST_STATUS);
+
+	value = XGMAC_CGCE | XGMAC_HLBS | XGMAC_HLBF | XGMAC_BTRE | XGMAC_SWLC;
+
+	/* Return if there is no error */
+	if (!(status & value))
+		return;
+
+	if (status & XGMAC_CGCE) {
+		/* Clear Interrupt */
+		writel(XGMAC_CGCE, ioaddr + XGMAC_MTL_EST_STATUS);
+
+		x->mtl_est_cgce++;
+	}
+
+	if (status & XGMAC_HLBS) {
+		value = readl(ioaddr + XGMAC_MTL_EST_SCH_ERR);
+		value &= txqcnt_mask;
+
+		x->mtl_est_hlbs++;
+
+		/* Clear Interrupt */
+		writel(value, ioaddr + XGMAC_MTL_EST_SCH_ERR);
+
+		/* Collecting info to shows all the queues that has HLBS
+		 * issue. The only way to clear this is to clear the
+		 * statistic.
+		 */
+		if (net_ratelimit())
+			netdev_err(dev, "EST: HLB(sched) Queue 0x%x\n", value);
+	}
+
+	if (status & XGMAC_HLBF) {
+		value = readl(ioaddr + XGMAC_MTL_EST_FRM_SZ_ERR);
+		feqn = value & txqcnt_mask;
+
+		value = readl(ioaddr + XGMAC_MTL_EST_FRM_SZ_CAP);
+		hbfq = (value & XGMAC_SZ_CAP_HBFQ_MASK(txqcnt)) >>
+			XGMAC_SZ_CAP_HBFQ_SHIFT;
+		hbfs = value & XGMAC_SZ_CAP_HBFS_MASK;
+
+		x->mtl_est_hlbf++;
+
+		/* Clear Interrupt */
+		writel(feqn, ioaddr + XGMAC_MTL_EST_FRM_SZ_ERR);
+
+		if (net_ratelimit())
+			netdev_err(dev, "EST: HLB(size) Queue %u Size %u\n",
+				   hbfq, hbfs);
+	}
+
+	if (status & XGMAC_BTRE) {
+		if ((status & XGMAC_BTRL) == XGMAC_BTRL_MAX)
+			x->mtl_est_btrlm++;
+		else
+			x->mtl_est_btre++;
+
+		btrl = (status & XGMAC_BTRL) >> XGMAC_BTRL_SHIFT;
+
+		if (net_ratelimit())
+			netdev_info(dev, "EST: BTR Error Loop Count %u\n",
+				    btrl);
+
+		writel(XGMAC_BTRE, ioaddr + XGMAC_MTL_EST_STATUS);
+	}
+
+	if (status & XGMAC_SWLC) {
+		writel(XGMAC_SWLC, ioaddr + XGMAC_MTL_EST_STATUS);
+		netdev_info(dev, "EST: SWOL has been switched\n");
+	}
+}
+
 static void dwxgmac3_fpe_configure(void __iomem *ioaddr, u32 num_txq,
 				   u32 num_rxq, bool enable)
 {
@@ -1541,6 +1629,7 @@ const struct stmmac_ops dwxgmac210_ops = {
 	.config_l4_filter = dwxgmac2_config_l4_filter,
 	.set_arp_offload = dwxgmac2_set_arp_offload,
 	.est_configure = dwxgmac3_est_configure,
+	.est_irq_status = dwxgmac3_est_irq_status,
 	.fpe_configure = dwxgmac3_fpe_configure,
 };
 
-- 
2.26.2


