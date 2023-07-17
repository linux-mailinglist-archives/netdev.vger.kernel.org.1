Return-Path: <netdev+bounces-18267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AAA756281
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 14:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEEC4281253
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 12:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAC0AD39;
	Mon, 17 Jul 2023 12:09:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F3079C8
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 12:09:25 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ACAEE6;
	Mon, 17 Jul 2023 05:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689595742; x=1721131742;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O3yP0T0bW+xJPNEoHbl0Tg6ZcW8tghAmjL0CP7lEp9o=;
  b=AwDwWe7OfP0mDfdW/0tcb05xj59dBShTYrWU5AZVqtE/Afbe2dLwBtGY
   Yw1IQXVr+h34OZJsXDm/DUBwXGzDyhdMcXRYQWSeu7GcvnnxNGYW7kWSJ
   SKJKzwCE5PoxapG2hdzHId+yAGNC3EJn06nekaCtPqTxeoizZ+XyTYRUT
   OiVaBnxQF3Vi1urEGHZ9cy2qHGvuTwZj5Nhe689GekNdDZy/rmLd+OwNd
   qvVZFJ4NCtcQViTwdTLuVyJ+kKwwdTfH9RUq0yOq4rHYWuV+RvlJdo6Nf
   XD491kC8sCJ4sAj074o+9nXr2FJpTXEkIj6+Usxv70Fjm4HJ6wNga7ehn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="452286736"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="452286736"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 05:08:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10773"; a="1053891367"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="1053891367"
Received: from pglc00062.png.intel.com ([10.221.207.82])
  by fmsmga005.fm.intel.com with ESMTP; 17 Jul 2023 05:08:13 -0700
From: Rohan G Thomas <rohan.g.thomas@intel.com>
To: "David S . Miller" <davem@davemloft.net>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Rohan G Thomas <rohan.g.thomas@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next 1/1] net: stmmac: xgmac: Fix L3L4 filter count
Date: Mon, 17 Jul 2023 20:06:03 +0800
Message-Id: <20230717120603.5053-1-rohan.g.thomas@intel.com>
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
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Get the exact count of L3L4 filters when the L3L4FNUM field of
HW_FEATURE1 register is >= 8. If L3L4FNUM < 8, then the number of L3L4
filters supported by XGMAC is equal to L3L4FNUM. From L3L4FNUM >= 8
the number of L3L4 filters goes on like 8, 16, 32, ... Current
maximum of L3L4FNUM = 10.

Also, fix the XGMAC_IDDR bitmask of L3L4_ADDR_CTRL register. IDDR
field starts from the 8th bit of the L3L4_ADDR_CTRL register. IDDR[3:0]
indicates the type of L3L4 filter register while IDDR[8:4] indicates
the filter number (0 to 31). So overall 9 bits are used for IDDR
(i.e. L3L4_ADDR_CTRL[16:8]) to address the registers of all the
filters. Currently, XGMAC_IDDR is GENMASK(15,8), causing issues
accessing L3L4 filters above 15 for those XGMACs configured with more
than 16 L3L4 filters.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 1913385df685..153321fe42c3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -165,7 +165,7 @@
 #define XGMAC_DCS_SHIFT			16
 #define XGMAC_ADDRx_LOW(x)		(0x00000304 + (x) * 0x8)
 #define XGMAC_L3L4_ADDR_CTRL		0x00000c00
-#define XGMAC_IDDR			GENMASK(15, 8)
+#define XGMAC_IDDR			GENMASK(16, 8)
 #define XGMAC_IDDR_SHIFT		8
 #define XGMAC_IDDR_FNUM			4
 #define XGMAC_TT			BIT(1)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 070bd912580b..df5af52fd1a1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -408,6 +408,16 @@ static int dwxgmac2_get_hw_feature(void __iomem *ioaddr,
 	/* MAC HW feature 1 */
 	hw_cap = readl(ioaddr + XGMAC_HW_FEATURE1);
 	dma_cap->l3l4fnum = (hw_cap & XGMAC_HWFEAT_L3L4FNUM) >> 27;
+	/* If L3L4FNUM < 8, then the number of L3L4 filters supported by
+	 * XGMAC is equal to L3L4FNUM. From L3L4FNUM >= 8 the number of
+	 * L3L4 filters goes on like 8, 16, 32, ... Current maximum of
+	 * L3L4FNUM = 10.
+	 */
+	if (dma_cap->l3l4fnum >= 8 && dma_cap->l3l4fnum <= 10)
+		dma_cap->l3l4fnum = 8 << (dma_cap->l3l4fnum - 8);
+	else if (dma_cap->l3l4fnum > 10)
+		dma_cap->l3l4fnum = 32;
+
 	dma_cap->hash_tb_sz = (hw_cap & XGMAC_HWFEAT_HASHTBLSZ) >> 24;
 	dma_cap->rssen = (hw_cap & XGMAC_HWFEAT_RSSEN) >> 20;
 	dma_cap->tsoen = (hw_cap & XGMAC_HWFEAT_TSOEN) >> 18;
-- 
2.26.2


