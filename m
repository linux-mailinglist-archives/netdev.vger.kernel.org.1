Return-Path: <netdev+bounces-49647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0097F2D4A
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 13:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A394BB2169A
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 12:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47914A9A6;
	Tue, 21 Nov 2023 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D1D9DF/l"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5900CD65;
	Tue, 21 Nov 2023 04:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700570118; x=1732106118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nivaZQ+9P0ZV/opmlAd8c2iOR56SU+o3ql7tnZt2R+U=;
  b=D1D9DF/l34RN+o4MhIIZvE1SAi13aICV6oWBa48iBCMBGm23hWQrmP6s
   uEhOGywmxtlqe+LnBE8YkifDTUI3ebqZh1r2Mr7go4q+r01oe7DLCEc5E
   08uZl947mLlAIwL1+ItJzh4uRu1vemyWtfdYjZfOou80tDO4gR02isduV
   23h8BCW6LayfdJNYYVs+dJI02YqxiJJNeFd8PHkVLbI1VNM4KuecguNCF
   w02XkpRkKwck2wNTi1gOH4KawTSZyvwwOKNxzZ+xK0sLMp7FG8RPrrJAQ
   mhfkMRAq1KktgtV2ya3+U7Z4xEoA0CfSYFkDbZkX6z7mh+3igwnmuq+tG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="458327794"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="458327794"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 04:35:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="837044350"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="837044350"
Received: from wpastern-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.57.17])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 04:35:13 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	intel-wired-lan@lists.osuosl.org,
	Jakub Kicinski <kuba@kernel.org>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 3/3] e1000e: Use pcie_capability_read_word() for reading LNKSTA
Date: Tue, 21 Nov 2023 14:34:28 +0200
Message-Id: <20231121123428.20907-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231121123428.20907-1-ilpo.jarvinen@linux.intel.com>
References: <20231121123428.20907-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use pcie_capability_read_word() for reading LNKSTA and remove the
custom define that matches to PCI_EXP_LNKSTA.

As only single user for cap_offset remains, replace it with a call to
pci_pcie_cap(). Instead of e1000_adapter, make local variable out of
pci_dev because both users are interested in it.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
index 5340cf73778d..694a779e718d 100644
--- a/drivers/net/ethernet/intel/e1000e/mac.c
+++ b/drivers/net/ethernet/intel/e1000e/mac.c
@@ -17,16 +17,13 @@ s32 e1000e_get_bus_info_pcie(struct e1000_hw *hw)
 {
 	struct e1000_mac_info *mac = &hw->mac;
 	struct e1000_bus_info *bus = &hw->bus;
-	struct e1000_adapter *adapter = hw->adapter;
-	u16 pcie_link_status, cap_offset;
+	struct pci_dev *pdev = hw->adapter->pdev;
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
2.30.2


