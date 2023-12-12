Return-Path: <netdev+bounces-56594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A608E80F86D
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 21:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6673A284953
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 20:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E926E65A75;
	Tue, 12 Dec 2023 20:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LVLiS0AG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFAA18F
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 12:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702414285; x=1733950285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ItW7/5FteYpToQ9+a1j1igGqV6CjDVBZiZAS4Sgq1xs=;
  b=LVLiS0AGunx92D4CJvfpDJjQYLh+0FTRFq+LXSx+Kw+bNevL1P5aoweV
   bZcS3cKQDo3OUb4LWmZwu3a9KRAwwfgQCPkHyGg7eaOp5OQgNKqJ0GqET
   0dYlrHLkM2liYlwXpMl3p/YEXgYagUoySKEItSRKmtg+qcufzyu7YjTnS
   /VgLx58efpYrTRPD+m9fZeazrbmzTTIPgOrppevFdyKK/gUIWbqiE+as8
   rwaotc+0pgQprileo0kfhvfD4ybALosX8hewKkNCTZybmneAHhtpab493
   Bj9gxaQr1LJViTh6ht4qENWUohBZPEh9+djXZcWTapRweqtjQFpuqsbT8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1942382"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="1942382"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 12:49:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1105044039"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="1105044039"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmsmga005.fm.intel.com with ESMTP; 12 Dec 2023 12:49:57 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	sasha.neftin@intel.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Simon Horman <horms@kernel.org>,
	Naama Meir <naamax.meir@linux.intel.com>
Subject: [PATCH net-next 2/3] e1000e: Use PCI_EXP_LNKSTA_NLW & FIELD_GET() instead of custom defines/code
Date: Tue, 12 Dec 2023 12:49:44 -0800
Message-ID: <20231212204947.513563-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231212204947.513563-1-anthony.l.nguyen@intel.com>
References: <20231212204947.513563-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

e1000e has own copy of PCI Negotiated Link Width field defines. Use the
ones from include/uapi/linux/pci_regs.h instead of the custom ones and
remove the custom ones and convert to FIELD_GET().

Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/defines.h | 2 --
 drivers/net/ethernet/intel/e1000e/mac.c     | 7 ++++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/defines.h b/drivers/net/ethernet/intel/e1000e/defines.h
index 63c3c79380a1..a4d29c9e03a6 100644
--- a/drivers/net/ethernet/intel/e1000e/defines.h
+++ b/drivers/net/ethernet/intel/e1000e/defines.h
@@ -681,8 +681,6 @@
 #define PCIE_LINK_STATUS             0x12
 
 #define PCI_HEADER_TYPE_MULTIFUNC    0x80
-#define PCIE_LINK_WIDTH_MASK         0x3F0
-#define PCIE_LINK_WIDTH_SHIFT        4
 
 #define PHY_REVISION_MASK      0xFFFFFFF0
 #define MAX_PHY_REG_ADDRESS    0x1F  /* 5 bit address bus (0-0x1F) */
diff --git a/drivers/net/ethernet/intel/e1000e/mac.c b/drivers/net/ethernet/intel/e1000e/mac.c
index 5df7ad93f3d7..5340cf73778d 100644
--- a/drivers/net/ethernet/intel/e1000e/mac.c
+++ b/drivers/net/ethernet/intel/e1000e/mac.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 1999 - 2018 Intel Corporation. */
 
+#include <linux/bitfield.h>
+
 #include "e1000.h"
 
 /**
@@ -25,9 +27,8 @@ s32 e1000e_get_bus_info_pcie(struct e1000_hw *hw)
 		pci_read_config_word(adapter->pdev,
 				     cap_offset + PCIE_LINK_STATUS,
 				     &pcie_link_status);
-		bus->width = (enum e1000_bus_width)((pcie_link_status &
-						     PCIE_LINK_WIDTH_MASK) >>
-						    PCIE_LINK_WIDTH_SHIFT);
+		bus->width = (enum e1000_bus_width)FIELD_GET(PCI_EXP_LNKSTA_NLW,
+							     pcie_link_status);
 	}
 
 	mac->ops.set_lan_id(hw);
-- 
2.41.0


