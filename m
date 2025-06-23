Return-Path: <netdev+bounces-200305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68ECDAE47E7
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 17:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD993B9B05
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 15:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DD0271471;
	Mon, 23 Jun 2025 15:03:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960EA267700;
	Mon, 23 Jun 2025 15:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691010; cv=none; b=ap3D5ONh2MonyX65U7cXUN0EOEovTH7HOH9q7uuOZ0vKio32TzaPtXCEYoonsAB60OYj7Qr7dtfqs6NE3/ERH94pB+ky/2kzwnOnx1xiHb23WwdYMNYBlOxmMeiE1981qMTzYfVAD6Y14kWK18LEezhyZ+8DXvBQ690I5vOltzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691010; c=relaxed/simple;
	bh=TPqeMh80gQBOcHpui5dsDRlcE8x3uF7B3//Ah9f+stc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k/Upoc3YIBrZKLbj5/evrj51+AWkCx9r6p4PWEYReIwqadlxHWTnzKTGGcIRQsqoAKkH5zInXHA4viGESchFXVMYt/Tq6m87jsuBHAjQCE7PkkFWjeTJ35YlMFWATFPtiCiju+eqjYN/ytXrLWucu2gpjctzuMOONTIPLR8RoKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=altera.com; spf=fail smtp.mailfrom=altera.com; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=altera.com
X-CSE-ConnectionGUID: QwuqUjL3QVKS4/6Sfm/35w==
X-CSE-MsgGUID: O/9RSt4nSu229B0X91O2sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="56709636"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="56709636"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 08:03:26 -0700
X-CSE-ConnectionGUID: 3E3SWQexTg6PAFqqgWO47w==
X-CSE-MsgGUID: rH7YcLrxQXaPzoxIyMff6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="156186349"
Received: from sramkris-mobl1.amr.corp.intel.com (HELO mgerlach-mobl1.intel.com) ([10.124.222.185])
  by orviesa004.jf.intel.com with ESMTP; 23 Jun 2025 08:03:16 -0700
From: Matthew Gerlach <matthew.gerlach@altera.com>
To: dinguyen@kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	richardcochran@gmail.com,
	linux-clk@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
	Teh Wen Ping <wen.ping.teh@intel.com>,
	Matthew Gerlach <matthew.gerlach@altera.com>
Subject: [PATCH v5 RESEND] clk: socfpga: agilex: add support for the Intel Agilex5
Date: Mon, 23 Jun 2025 08:03:14 -0700
Message-ID: <20250623150314.19243-1-matthew.gerlach@altera.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Add support for Intel's SoCFPGA Agilex5 platform. The clock manager
driver for the Agilex5 is very similar to the Agilex platform, so
it is reusing most of the Agilex clock driver code.

Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
Changes in v5:
- Remove incorrect usage of .index and continue with the old way
  of using string names.
- Add lore links to revision history.
- Link to v4: https://lore.kernel.org/lkml/20250417145238.31657-1-matthew.gerlach@altera.com/T/#u

Changes in v4:
- Add .index to clk_parent_data.
- Link to v3: https://lore.kernel.org/linux-clk/20231003120402.4186270-1-niravkumar.l.rabara@intel.com/

Changes in v3:
- Used different name for stratix10_clock_data pointer.
- Used a single function call, devm_platform_ioremap_resource().
- Used only .name in clk_parent_data.
- Link to v2: https://lore.kernel.org/linux-clk/20230801010234.792557-1-niravkumar.l.rabara@intel.com/

Stephen suggested to use .fw_name or .index, But since the changes are on top
of existing driver and current driver code is not using clk_hw and removing
.name and using .fw_name and/or .index resulting in parent clock_rate &
recalc_rate to 0.

In order to use .index, I would need to refactor the common code that is shared
by a few Intel SoCFPGA platforms (S10, Agilex and N5x). So, if using .name for
this patch is acceptable then I will upgrade clk-agilex.c in future submission.

Changes in v2:
- Instead of creating separate clock manager driver, re-use agilex clock
  manager driver and modified it for agilex5 changes to avoid code
  duplicate.
- Link to v1: https://lore.kernel.org/linux-clk/20230618132235.728641-4-niravkumar.l.rabara@intel.com/
---
 drivers/clk/socfpga/clk-agilex.c | 413 ++++++++++++++++++++++++++++++-
 1 file changed, 412 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/socfpga/clk-agilex.c b/drivers/clk/socfpga/clk-agilex.c
index 8dd94f64756b..43c1e4e26cf0 100644
--- a/drivers/clk/socfpga/clk-agilex.c
+++ b/drivers/clk/socfpga/clk-agilex.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2019, Intel Corporation
+ * Copyright (C) 2019-2024, Intel Corporation
+ * Copyright (C) 2025, Altera Corporation
  */
 #include <linux/slab.h>
 #include <linux/clk-provider.h>
@@ -8,6 +9,7 @@
 #include <linux/platform_device.h>
 
 #include <dt-bindings/clock/agilex-clock.h>
+#include <dt-bindings/clock/intel,agilex5-clkmgr.h>
 
 #include "stratix10-clk.h"
 
@@ -334,6 +336,375 @@ static const struct stratix10_gate_clock agilex_gate_clks[] = {
 	  10, 0, 0, 0, 0, 0, 4},
 };
 
+static const struct clk_parent_data agilex5_pll_mux[] = {
+	{ .name = "osc1", },
+	{ .name = "cb-intosc-hs-div2-clk", },
+	{ .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data agilex5_boot_mux[] = {
+	{ .name = "osc1", },
+	{ .name = "cb-intosc-hs-div2-clk", },
+};
+
+static const struct clk_parent_data agilex5_core0_free_mux[] = {
+	{ .name = "main_pll_c1", },
+	{ .name = "peri_pll_c0", },
+	{ .name = "osc1", },
+	{ .name = "cb-intosc-hs-div2-clk", },
+	{ .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data agilex5_core1_free_mux[] = {
+	{ .name = "main_pll_c1", },
+	{ .name = "peri_pll_c0", },
+	{ .name = "osc1", },
+	{ .name = "cb-intosc-hs-div2-clk", },
+	{ .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data agilex5_core2_free_mux[] = {
+	{ .name = "main_pll_c0", },
+	{ .name = "osc1", },
+	{ .name = "cb-intosc-hs-div2-clk", },
+	{ .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data agilex5_core3_free_mux[] = {
+	{ .name = "main_pll_c0", },
+	{ .name = "osc1", },
+	{ .name = "cb-intosc-hs-div2-clk", },
+	{ .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data agilex5_dsu_free_mux[] = {
+	{ .name = "main_pll_c2", },
+	{ .name = "peri_pll_c0", },
+	{ .name = "osc1", },
+	{ .name = "cb-intosc-hs-div2-clk", },
+	{ .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data agilex5_noc_free_mux[] = {
+	{ .name = "main_pll_c3", },
+	{ .name = "peri_pll_c1", },
+	{ .name = "osc1", },
+	{ .name = "cb-intosc-hs-div2-clk", },
+	{ .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data agilex5_emaca_free_mux[] = {
+	{ .name = "main_pll_c1", },
+	{ .name = "peri_pll_c3", },
+	{ .name = "osc1", },
+	{ .name = "cb-intosc-hs-div2-clk", },
+	{ .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data agilex5_emacb_free_mux[] = {
+	{ .name = "main_pll_c1", },
+	{ .name = "peri_pll_c3", },
+	{ .name = "osc1", },
+	{ .name = "cb-intosc-hs-div2-clk", },
+	{ .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data agilex5_emac_ptp_free_mux[] = {
+	{ .name = "main_pll_c3", },
+	{ .name = "peri_pll_c3", },
+	{ .name = "osc1", },
+	{ .name = "cb-intosc-hs-div2-clk", },
+	{ .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data agilex5_gpio_db_free_mux[] = {
+	{ .name = "main_pll_c3", },
+	{ .name = "peri_pll_c1", },
+	{ .name = "osc1", },
+	{ .name = "cb-intosc-hs-div2-clk", },
+	{ .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data agilex5_psi_ref_free_mux[] = {
+	{ .name = "main_pll_c1", },
+	{ .name = "peri_pll_c3", },
+	{ .name = "osc1", },
+	{ .name = "cb-intosc-hs-div2-clk", },
+	{ .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data agilex5_usb31_free_mux[] = {
+	{ .name = "main_pll_c3", },
+	{ .name = "peri_pll_c2", },
+	{ .name = "osc1", },
+	{ .name = "cb-intosc-hs-div2-clk", },
+	{ .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data agilex5_s2f_usr0_free_mux[] = {
+	{ .name = "main_pll_c1", },
+	{ .name = "peri_pll_c3", },
+	{ .name = "osc1", },
+	{ .name = "cb-intosc-hs-div2-clk", },
+	{ .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data agilex5_s2f_usr1_free_mux[] = {
+	{ .name = "main_pll_c1", },
+	{ .name = "peri_pll_c3", },
+	{ .name = "osc1", },
+	{ .name = "cb-intosc-hs-div2-clk", },
+	{ .name = "f2s-free-clk", },
+};
+
+static const struct clk_parent_data agilex5_core0_mux[] = {
+	{ .name = "core0_free_clk", },
+	{ .name = "boot_clk", },
+};
+
+static const struct clk_parent_data agilex5_core1_mux[] = {
+	{ .name = "core1_free_clk", .index = AGILEX5_CORE1_FREE_CLK },
+	{ .name = "boot_clk", },
+};
+
+static const struct clk_parent_data agilex5_core2_mux[] = {
+	{ .name = "core2_free_clk", },
+	{ .name = "boot_clk", },
+};
+
+static const struct clk_parent_data agilex5_core3_mux[] = {
+	{ .name = "core3_free_clk", },
+	{ .name = "boot_clk", },
+};
+
+static const struct clk_parent_data agilex5_dsu_mux[] = {
+	{ .name = "dsu_free_clk", },
+	{ .name = "boot_clk", },
+};
+
+static const struct clk_parent_data agilex5_emac_mux[] = {
+	{ .name = "emaca_free_clk", },
+	{ .name = "emacb_free_clk", },
+	{ .name = "boot_clk", },
+};
+
+static const struct clk_parent_data agilex5_noc_mux[] = {
+	{ .name = "noc_free_clk", },
+	{ .name = "boot_clk", },
+};
+
+static const struct clk_parent_data agilex5_s2f_user0_mux[] = {
+	{ .name = "s2f_user0_free_clk", },
+	{ .name = "boot_clk", },
+};
+
+static const struct clk_parent_data agilex5_s2f_user1_mux[] = {
+	{ .name = "s2f_user1_free_clk", },
+	{ .name = "boot_clk", },
+};
+
+static const struct clk_parent_data agilex5_psi_mux[] = {
+	{ .name = "psi_ref_free_clk", },
+	{ .name = "boot_clk", },
+};
+
+static const struct clk_parent_data agilex5_gpio_db_mux[] = {
+	{ .name = "gpio_db_free_clk", },
+	{ .name = "boot_clk", },
+};
+
+static const struct clk_parent_data agilex5_emac_ptp_mux[] = {
+	{ .name = "emac_ptp_free_clk", },
+	{ .name = "boot_clk", },
+};
+
+static const struct clk_parent_data agilex5_usb31_mux[] = {
+	{ .name = "usb31_free_clk", },
+	{ .name = "boot_clk", },
+};
+
+/*
+ * clocks in AO (always on) controller
+ */
+static const struct stratix10_pll_clock agilex5_pll_clks[] = {
+	{ AGILEX5_BOOT_CLK, "boot_clk", agilex5_boot_mux, ARRAY_SIZE(agilex5_boot_mux), 0,
+	  0x0 },
+	{ AGILEX5_MAIN_PLL_CLK, "main_pll", agilex5_pll_mux, ARRAY_SIZE(agilex5_pll_mux), 0,
+	  0x48 },
+	{ AGILEX5_PERIPH_PLL_CLK, "periph_pll", agilex5_pll_mux, ARRAY_SIZE(agilex5_pll_mux), 0,
+	  0x9C },
+};
+
+static const struct stratix10_perip_c_clock agilex5_main_perip_c_clks[] = {
+	{ AGILEX5_MAIN_PLL_C0_CLK, "main_pll_c0", "main_pll", NULL, 1, 0,
+	  0x5C },
+	{ AGILEX5_MAIN_PLL_C1_CLK, "main_pll_c1", "main_pll", NULL, 1, 0,
+	  0x60 },
+	{ AGILEX5_MAIN_PLL_C2_CLK, "main_pll_c2", "main_pll", NULL, 1, 0,
+	  0x64 },
+	{ AGILEX5_MAIN_PLL_C3_CLK, "main_pll_c3", "main_pll", NULL, 1, 0,
+	  0x68 },
+	{ AGILEX5_PERIPH_PLL_C0_CLK, "peri_pll_c0", "periph_pll", NULL, 1, 0,
+	  0xB0 },
+	{ AGILEX5_PERIPH_PLL_C1_CLK, "peri_pll_c1", "periph_pll", NULL, 1, 0,
+	  0xB4 },
+	{ AGILEX5_PERIPH_PLL_C2_CLK, "peri_pll_c2", "periph_pll", NULL, 1, 0,
+	  0xB8 },
+	{ AGILEX5_PERIPH_PLL_C3_CLK, "peri_pll_c3", "periph_pll", NULL, 1, 0,
+	  0xBC },
+};
+
+/* Non-SW clock-gated enabled clocks */
+static const struct stratix10_perip_cnt_clock agilex5_main_perip_cnt_clks[] = {
+	{ AGILEX5_CORE0_FREE_CLK, "core0_free_clk", NULL, agilex5_core0_free_mux,
+	ARRAY_SIZE(agilex5_core0_free_mux), 0, 0x0104, 0, 0, 0},
+	{ AGILEX5_CORE1_FREE_CLK, "core1_free_clk", NULL, agilex5_core1_free_mux,
+	ARRAY_SIZE(agilex5_core1_free_mux), 0, 0x0104, 0, 0, 0},
+	{ AGILEX5_CORE2_FREE_CLK, "core2_free_clk", NULL, agilex5_core2_free_mux,
+	ARRAY_SIZE(agilex5_core2_free_mux), 0, 0x010C, 0, 0, 0},
+	{ AGILEX5_CORE3_FREE_CLK, "core3_free_clk", NULL, agilex5_core3_free_mux,
+	ARRAY_SIZE(agilex5_core3_free_mux), 0, 0x0110, 0, 0, 0},
+	{ AGILEX5_DSU_FREE_CLK, "dsu_free_clk", NULL, agilex5_dsu_free_mux,
+	ARRAY_SIZE(agilex5_dsu_free_mux), 0, 0x0100, 0, 0, 0},
+	{ AGILEX5_NOC_FREE_CLK, "noc_free_clk", NULL, agilex5_noc_free_mux,
+	  ARRAY_SIZE(agilex5_noc_free_mux), 0, 0x40, 0, 0, 0 },
+	{ AGILEX5_EMAC_A_FREE_CLK, "emaca_free_clk", NULL, agilex5_emaca_free_mux,
+	  ARRAY_SIZE(agilex5_emaca_free_mux), 0, 0xD4, 0, 0x88, 0 },
+	{ AGILEX5_EMAC_B_FREE_CLK, "emacb_free_clk", NULL, agilex5_emacb_free_mux,
+	  ARRAY_SIZE(agilex5_emacb_free_mux), 0, 0xD8, 0, 0x88, 1 },
+	{ AGILEX5_EMAC_PTP_FREE_CLK, "emac_ptp_free_clk", NULL,
+	  agilex5_emac_ptp_free_mux, ARRAY_SIZE(agilex5_emac_ptp_free_mux), 0, 0xDC, 0, 0x88,
+	  2 },
+	{ AGILEX5_GPIO_DB_FREE_CLK, "gpio_db_free_clk", NULL, agilex5_gpio_db_free_mux,
+	  ARRAY_SIZE(agilex5_gpio_db_free_mux), 0, 0xE0, 0, 0x88, 3 },
+	{ AGILEX5_S2F_USER0_FREE_CLK, "s2f_user0_free_clk", NULL,
+	  agilex5_s2f_usr0_free_mux, ARRAY_SIZE(agilex5_s2f_usr0_free_mux), 0, 0xE8, 0, 0x30,
+	  2 },
+	{ AGILEX5_S2F_USER1_FREE_CLK, "s2f_user1_free_clk", NULL,
+	  agilex5_s2f_usr1_free_mux, ARRAY_SIZE(agilex5_s2f_usr1_free_mux), 0, 0xEC, 0, 0x88,
+	  5 },
+	{ AGILEX5_PSI_REF_FREE_CLK, "psi_ref_free_clk", NULL, agilex5_psi_ref_free_mux,
+	  ARRAY_SIZE(agilex5_psi_ref_free_mux), 0, 0xF0, 0, 0x88, 6 },
+	{ AGILEX5_USB31_FREE_CLK, "usb31_free_clk", NULL, agilex5_usb31_free_mux,
+	  ARRAY_SIZE(agilex5_usb31_free_mux), 0, 0xF8, 0, 0x88, 7},
+};
+
+/* SW Clock gate enabled clocks */
+static const struct stratix10_gate_clock agilex5_gate_clks[] = {
+	/* Main PLL0 Begin */
+	/* MPU clocks */
+	{ AGILEX5_CORE0_CLK, "core0_clk", NULL, agilex5_core0_mux,
+	  ARRAY_SIZE(agilex5_core0_mux), 0, 0x24, 8, 0, 0, 0, 0x30, 5, 0 },
+	{ AGILEX5_CORE1_CLK, "core1_clk", NULL, agilex5_core1_mux,
+	  ARRAY_SIZE(agilex5_core1_mux), 0, 0x24, 9, 0, 0, 0, 0x30, 5, 0 },
+	{ AGILEX5_CORE2_CLK, "core2_clk", NULL, agilex5_core2_mux,
+	  ARRAY_SIZE(agilex5_core2_mux), 0, 0x24, 10, 0, 0, 0, 0x30, 6, 0 },
+	{ AGILEX5_CORE3_CLK, "core3_clk", NULL, agilex5_core3_mux,
+	  ARRAY_SIZE(agilex5_core3_mux), 0, 0x24, 11, 0, 0, 0, 0x30, 7, 0 },
+	{ AGILEX5_MPU_CLK, "dsu_clk", NULL, agilex5_dsu_mux, ARRAY_SIZE(agilex5_dsu_mux), 0, 0,
+	  0, 0, 0, 0, 0x34, 4, 0 },
+	{ AGILEX5_MPU_PERIPH_CLK, "mpu_periph_clk", NULL, agilex5_dsu_mux,
+	  ARRAY_SIZE(agilex5_dsu_mux), 0, 0, 0, 0x44, 20, 2, 0x34, 4, 0 },
+	{ AGILEX5_MPU_CCU_CLK, "mpu_ccu_clk", NULL, agilex5_dsu_mux,
+	  ARRAY_SIZE(agilex5_dsu_mux), 0, 0, 0, 0x44, 18, 2, 0x34, 4, 0 },
+	{ AGILEX5_L4_MAIN_CLK, "l4_main_clk", NULL, agilex5_noc_mux,
+	  ARRAY_SIZE(agilex5_noc_mux), 0, 0x24, 1, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_L4_MP_CLK, "l4_mp_clk", NULL, agilex5_noc_mux, ARRAY_SIZE(agilex5_noc_mux), 0,
+	  0x24, 2, 0x44, 4, 2, 0x30, 1, 0 },
+	{ AGILEX5_L4_SYS_FREE_CLK, "l4_sys_free_clk", NULL, agilex5_noc_mux,
+	  ARRAY_SIZE(agilex5_noc_mux), 0, 0, 0, 0x44, 2, 2, 0x30, 1, 0 },
+	{ AGILEX5_L4_SP_CLK, "l4_sp_clk", NULL, agilex5_noc_mux, ARRAY_SIZE(agilex5_noc_mux),
+	  CLK_IS_CRITICAL, 0x24, 3, 0x44, 6, 2, 0x30, 1, 0 },
+
+	/* Core sight clocks*/
+	{ AGILEX5_CS_AT_CLK, "cs_at_clk", NULL, agilex5_noc_mux, ARRAY_SIZE(agilex5_noc_mux), 0,
+	  0x24, 4, 0x44, 24, 2, 0x30, 1, 0 },
+	{ AGILEX5_CS_TRACE_CLK, "cs_trace_clk", NULL, agilex5_noc_mux,
+	  ARRAY_SIZE(agilex5_noc_mux), 0, 0x24, 4, 0x44, 26, 2, 0x30, 1, 0 },
+	{ AGILEX5_CS_PDBG_CLK, "cs_pdbg_clk", "cs_at_clk", NULL, 1, 0, 0x24, 4,
+	  0x44, 28, 1, 0, 0, 0 },
+	/* Main PLL0 End */
+
+	/* Main Peripheral PLL1 Begin */
+	{ AGILEX5_EMAC0_CLK, "emac0_clk", NULL, agilex5_emac_mux, ARRAY_SIZE(agilex5_emac_mux),
+	  0, 0x7C, 0, 0, 0, 0, 0x94, 26, 0 },
+	{ AGILEX5_EMAC1_CLK, "emac1_clk", NULL, agilex5_emac_mux, ARRAY_SIZE(agilex5_emac_mux),
+	  0, 0x7C, 1, 0, 0, 0, 0x94, 27, 0 },
+	{ AGILEX5_EMAC2_CLK, "emac2_clk", NULL, agilex5_emac_mux, ARRAY_SIZE(agilex5_emac_mux),
+	  0, 0x7C, 2, 0, 0, 0, 0x94, 28, 0 },
+	{ AGILEX5_EMAC_PTP_CLK, "emac_ptp_clk", NULL, agilex5_emac_ptp_mux,
+	  ARRAY_SIZE(agilex5_emac_ptp_mux), 0, 0x7C, 3, 0, 0, 0, 0x88, 2, 0 },
+	{ AGILEX5_GPIO_DB_CLK, "gpio_db_clk", NULL, agilex5_gpio_db_mux,
+	  ARRAY_SIZE(agilex5_gpio_db_mux), 0, 0x7C, 4, 0x98, 0, 16, 0x88, 3, 1 },
+	  /* Main Peripheral PLL1 End */
+
+	  /* Peripheral clocks  */
+	{ AGILEX5_S2F_USER0_CLK, "s2f_user0_clk", NULL, agilex5_s2f_user0_mux,
+	  ARRAY_SIZE(agilex5_s2f_user0_mux), 0, 0x24, 6, 0, 0, 0, 0x30, 2, 0 },
+	{ AGILEX5_S2F_USER1_CLK, "s2f_user1_clk", NULL, agilex5_s2f_user1_mux,
+	  ARRAY_SIZE(agilex5_s2f_user1_mux), 0, 0x7C, 6, 0, 0, 0, 0x88, 5, 0 },
+	{ AGILEX5_PSI_REF_CLK, "psi_ref_clk", NULL, agilex5_psi_mux,
+	  ARRAY_SIZE(agilex5_psi_mux), 0, 0x7C, 7, 0, 0, 0, 0x88, 6, 0 },
+	{ AGILEX5_USB31_SUSPEND_CLK, "usb31_suspend_clk", NULL, agilex5_usb31_mux,
+	  ARRAY_SIZE(agilex5_usb31_mux), 0, 0x7C, 25, 0, 0, 0, 0x88, 7, 0 },
+	{ AGILEX5_USB31_BUS_CLK_EARLY, "usb31_bus_clk_early", "l4_main_clk",
+	  NULL, 1, 0, 0x7C, 25, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_USB2OTG_HCLK, "usb2otg_hclk", "l4_mp_clk", NULL, 1, 0, 0x7C,
+	  8, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SPIM_0_CLK, "spim_0_clk", "l4_mp_clk", NULL, 1, 0, 0x7C, 9,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SPIM_1_CLK, "spim_1_clk", "l4_mp_clk", NULL, 1, 0, 0x7C, 11,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SPIS_0_CLK, "spis_0_clk", "l4_sp_clk", NULL, 1, 0, 0x7C, 12,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SPIS_1_CLK, "spis_1_clk", "l4_sp_clk", NULL, 1, 0, 0x7C, 13,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_DMA_CORE_CLK, "dma_core_clk", "l4_mp_clk", NULL, 1, 0, 0x7C,
+	  14, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_DMA_HS_CLK, "dma_hs_clk", "l4_mp_clk", NULL, 1, 0, 0x7C, 14,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_I3C_0_CORE_CLK, "i3c_0_core_clk", "l4_mp_clk", NULL, 1, 0,
+	  0x7C, 18, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_I3C_1_CORE_CLK, "i3c_1_core_clk", "l4_mp_clk", NULL, 1, 0,
+	  0x7C, 19, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_I2C_0_PCLK, "i2c_0_pclk", "l4_sp_clk", NULL, 1, 0, 0x7C, 15,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_I2C_1_PCLK, "i2c_1_pclk", "l4_sp_clk", NULL, 1, 0, 0x7C, 16,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_I2C_EMAC0_PCLK, "i2c_emac0_pclk", "l4_sp_clk", NULL, 1, 0,
+	  0x7C, 17, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_I2C_EMAC1_PCLK, "i2c_emac1_pclk", "l4_sp_clk", NULL, 1, 0,
+	  0x7C, 22, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_I2C_EMAC2_PCLK, "i2c_emac2_pclk", "l4_sp_clk", NULL, 1, 0,
+	  0x7C, 27, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_UART_0_PCLK, "uart_0_pclk", "l4_sp_clk", NULL, 1, 0, 0x7C, 20,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_UART_1_PCLK, "uart_1_pclk", "l4_sp_clk", NULL, 1, 0, 0x7C, 21,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SPTIMER_0_PCLK, "sptimer_0_pclk", "l4_sp_clk", NULL, 1, 0,
+	  0x7C, 23, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SPTIMER_1_PCLK, "sptimer_1_pclk", "l4_sp_clk", NULL, 1, 0,
+	  0x7C, 24, 0, 0, 0, 0, 0, 0 },
+
+	/*NAND, SD/MMC and SoftPHY overall clocking*/
+	{ AGILEX5_DFI_CLK, "dfi_clk", "l4_mp_clk", NULL, 1, 0, 0, 0, 0x44, 16,
+	  2, 0, 0, 0 },
+	{ AGILEX5_NAND_NF_CLK, "nand_nf_clk", "dfi_clk", NULL, 1, 0, 0x7C, 10,
+	  0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_NAND_BCH_CLK, "nand_bch_clk", "l4_mp_clk", NULL, 1, 0, 0x7C,
+	  10, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SDMMC_SDPHY_REG_CLK, "sdmmc_sdphy_reg_clk", "l4_mp_clk", NULL,
+	  1, 0, 0x7C, 5, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SDMCLK, "sdmclk", "dfi_clk", NULL, 1, 0, 0x7C, 5, 0, 0, 0, 0,
+	  0, 0 },
+	{ AGILEX5_SOFTPHY_REG_PCLK, "softphy_reg_pclk", "l4_mp_clk", NULL, 1, 0,
+	  0x7C, 26, 0, 0, 0, 0, 0, 0 },
+	{ AGILEX5_SOFTPHY_PHY_CLK, "softphy_phy_clk", "l4_mp_clk", NULL, 1, 0,
+	  0x7C, 26, 0x44, 16, 2, 0, 0, 0 },
+	{ AGILEX5_SOFTPHY_CTRL_CLK, "softphy_ctrl_clk", "dfi_clk", NULL, 1, 0,
+	  0x7C, 26, 0, 0, 0, 0, 0, 0 },
+};
+
 static int n5x_clk_register_c_perip(const struct n5x_perip_c_clock *clks,
 				       int nums, struct stratix10_clock_data *data)
 {
@@ -542,11 +913,51 @@ static int agilex_clkmgr_probe(struct platform_device *pdev)
 	return	probe_func(pdev);
 }
 
+static int agilex5_clkmgr_init(struct platform_device *pdev)
+{
+	struct stratix10_clock_data *stratix_data;
+	struct device *dev = &pdev->dev;
+	void __iomem *base;
+	int i, num_clks;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	num_clks = AGILEX5_NUM_CLKS;
+
+	stratix_data = devm_kzalloc(dev,
+				    struct_size(stratix_data, clk_data.hws, num_clks), GFP_KERNEL);
+	if (!stratix_data)
+		return -ENOMEM;
+
+	for (i = 0; i < num_clks; i++)
+		stratix_data->clk_data.hws[i] = ERR_PTR(-ENOENT);
+
+	stratix_data->base = base;
+	stratix_data->clk_data.num = num_clks;
+
+	agilex_clk_register_pll(agilex5_pll_clks, ARRAY_SIZE(agilex5_pll_clks),
+				stratix_data);
+
+	agilex_clk_register_c_perip(agilex5_main_perip_c_clks,
+				    ARRAY_SIZE(agilex5_main_perip_c_clks), stratix_data);
+
+	agilex_clk_register_cnt_perip(agilex5_main_perip_cnt_clks,
+				      ARRAY_SIZE(agilex5_main_perip_cnt_clks), stratix_data);
+
+	agilex_clk_register_gate(agilex5_gate_clks,
+				 ARRAY_SIZE(agilex5_gate_clks), stratix_data);
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, &stratix_data->clk_data);
+}
+
 static const struct of_device_id agilex_clkmgr_match_table[] = {
 	{ .compatible = "intel,agilex-clkmgr",
 	  .data = agilex_clkmgr_init },
 	{ .compatible = "intel,easic-n5x-clkmgr",
 	  .data = n5x_clkmgr_init },
+	{ .compatible = "intel,agilex5-clkmgr",
+	  .data = agilex5_clkmgr_init },
 	{ }
 };
 
-- 
2.35.3


