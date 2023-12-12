Return-Path: <netdev+bounces-56595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC07680F86F
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 21:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 678F32849DD
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 20:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA28D65A7F;
	Tue, 12 Dec 2023 20:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dI5n9ptP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEAA19A
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 12:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702414285; x=1733950285;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qZyQ46rGdSML/RhLtn7ye3koqu2Jrxa4oAbvmY62oCQ=;
  b=dI5n9ptPU27A1ZcpEWPu+E90dgB61ZJZnwysX2NCgx6EIR0iHupmFt+L
   ckwZLpB+N8ioQlXrOPwxBq0202/XDJq1ENWzDxaSRvc5LCX/ThjnXxb8J
   YN6j5JOvpX+RG2p4vpSDcG45mwrbX6GJ6LF+uKNxB9wFXzbT6Dczbj+Nf
   4Otyx/ZG0ld/lMDPc6gauqBn9DNK5vbMyfLVyApMGz16Is6KkYplEYs2K
   96kP+u9ES0IHscD/496TjypF2nymwtbvRTjLxjY/X7e6MteYhqnkHq82q
   gLH1YsU7dXA/mR9rhDI04UBTiIBj6yVPbPyUsG43yY8nG+4CRVjEuLWrb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1942388"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="1942388"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 12:49:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="1105044042"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="1105044042"
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
Subject: [PATCH net-next 3/3] e1000e: Use pcie_capability_read_word() for reading LNKSTA
Date: Tue, 12 Dec 2023 12:49:45 -0800
Message-ID: <20231212204947.513563-4-anthony.l.nguyen@intel.com>
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

Use pcie_capability_read_word() for reading LNKSTA and remove the
custom define that matches to PCI_EXP_LNKSTA.

As only single user for cap_offset remains, replace it with a call to
pci_pcie_cap(). Instead of e1000_adapter, make local variable out of
pci_dev because both users are interested in it.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/defines.h |  1 -
 drivers/net/ethernet/intel/e1000e/mac.c     | 11 ++++-------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/defines.h b/drivers/net/ethernet/intel/e1000e/defines.h
index a4d29c9e03a6..23a58cada43a 100644
--- a/drivers/net/ethernet/intel/e1000e/defines.h
+++ b/drivers/net/ethernet/intel/e1000e/defines.h
@@ -678,7 +678,6 @@
 
 /* PCI/PCI-X/PCI-EX Config space */
 #define PCI_HEADER_TYPE_REGISTER     0x0E
-#define PCIE_LINK_STATUS             0x12
 
 #define PCI_HEADER_TYPE_MULTIFUNC    0x80
 
diff --git a/drivers/net/ethernet/intel/e1000e/mac.c b/drivers/net/ethernet/intel/e1000e/mac.c
index 5340cf73778d..8c3d9c5962f2 100644
--- a/drivers/net/ethernet/intel/e1000e/mac.c
+++ b/drivers/net/ethernet/intel/e1000e/mac.c
@@ -15,18 +15,15 @@
  **/
 s32 e1000e_get_bus_info_pcie(struct e1000_hw *hw)
 {
+	struct pci_dev *pdev = hw->adapter->pdev;
 	struct e1000_mac_info *mac = &hw->mac;
 	struct e1000_bus_info *bus = &hw->bus;
-	struct e1000_adapter *adapter = hw->adapter;
-	u16 pcie_link_status, cap_offset;
+	u16 pcie_link_status;
 
-	cap_offset = adapter->pdev->pcie_cap;
-	if (!cap_offset) {
+	if (!pci_pcie_cap(pdev)) {
 		bus->width = e1000_bus_width_unknown;
 	} else {
-		pci_read_config_word(adapter->pdev,
-				     cap_offset + PCIE_LINK_STATUS,
-				     &pcie_link_status);
+		pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &pcie_link_status);
 		bus->width = (enum e1000_bus_width)FIELD_GET(PCI_EXP_LNKSTA_NLW,
 							     pcie_link_status);
 	}
-- 
2.41.0


