Return-Path: <netdev+bounces-38319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 653247BA64C
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 18:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 616271C2074E
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 16:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F34A28E16;
	Thu,  5 Oct 2023 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fTvRRjbC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1DA35896
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 16:33:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A3AB6FA
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 09:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696523473; x=1728059473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FfaWrPyHsw7fmUhdG9yBqjZXNhdtR2fp4BcrRSRg6yc=;
  b=fTvRRjbCAlNeh3Y+v96LwkOkCro4/j0zMNod+q4r3Vvg6aLBC5OLmyrD
   l0Noz90UxpBsdPyBIoEPBxCLQgXWHfUeV4Ma+nUfSKbb2Oy3mFvkm6BMS
   fj1PSNjLyaAoFFOFv0cNTUtDJ8rlERa51UJqasWMLcUPpL+R9k65yfuav
   pDD30LSqP7z7XJb9IgsXRJYC9sHw/qvJox4zaieNBCVO8rGly50hseif7
   O4WjjHnID0a9pvlkJT6O+qppKSqvSCgu+e0V2PUxEwQY3X+bl2fZIywpa
   LzGIk5dCwgQ1ULOKqra7H5HxUV3xKVien/U9nAlv2stGBStMKZ8W1OwKD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="2152653"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="2152653"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 09:29:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="875607730"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="875607730"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga004.jf.intel.com with ESMTP; 05 Oct 2023 09:29:54 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>,
	anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 1/9] i40e: Remove back pointer from i40e_hw structure
Date: Thu,  5 Oct 2023 09:28:42 -0700
Message-Id: <20231005162850.3218594-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231005162850.3218594-1-anthony.l.nguyen@intel.com>
References: <20231005162850.3218594-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Ivan Vecera <ivecera@redhat.com>

The .back field placed in i40e_hw is used to get pointer to i40e_pf
instance but it is not necessary as the i40e_hw is a part of i40e_pf
and containerof macro can be used to obtain the pointer to i40e_pf.
Remove .back field from i40e_hw structure, introduce i40e_hw_to_pf()
and i40e_hw_to_dev() helpers and use them.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h       | 11 ++++++++++
 drivers/net/ethernet/intel/i40e/i40e_main.c  | 22 ++++++++++++++------
 drivers/net/ethernet/intel/i40e/i40e_osdep.h |  8 +++----
 drivers/net/ethernet/intel/i40e/i40e_type.h  |  1 -
 4 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 6e310a539467..7f79d5929be6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -1321,4 +1321,15 @@ static inline u32 i40e_is_tc_mqprio_enabled(struct i40e_pf *pf)
 	return pf->flags & I40E_FLAG_TC_MQPRIO;
 }
 
+/**
+ * i40e_hw_to_pf - get pf pointer from the hardware structure
+ * @hw: pointer to the device HW structure
+ **/
+static inline struct i40e_pf *i40e_hw_to_pf(struct i40e_hw *hw)
+{
+	return container_of(hw, struct i40e_pf, hw);
+}
+
+struct device *i40e_hw_to_dev(struct i40e_hw *hw);
+
 #endif /* _I40E_H_ */
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 4b9788d2ded7..a6f7124d009a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -119,6 +119,17 @@ static void netdev_hw_addr_refcnt(struct i40e_mac_filter *f,
 	}
 }
 
+/**
+ * i40e_hw_to_dev - get device pointer from the hardware structure
+ * @hw: pointer to the device HW structure
+ **/
+struct device *i40e_hw_to_dev(struct i40e_hw *hw)
+{
+	struct i40e_pf *pf = i40e_hw_to_pf(hw);
+
+	return &pf->pdev->dev;
+}
+
 /**
  * i40e_allocate_dma_mem_d - OS specific memory alloc for shared code
  * @hw:   pointer to the HW structure
@@ -129,7 +140,7 @@ static void netdev_hw_addr_refcnt(struct i40e_mac_filter *f,
 int i40e_allocate_dma_mem_d(struct i40e_hw *hw, struct i40e_dma_mem *mem,
 			    u64 size, u32 alignment)
 {
-	struct i40e_pf *pf = (struct i40e_pf *)hw->back;
+	struct i40e_pf *pf = i40e_hw_to_pf(hw);
 
 	mem->size = ALIGN(size, alignment);
 	mem->va = dma_alloc_coherent(&pf->pdev->dev, mem->size, &mem->pa,
@@ -147,7 +158,7 @@ int i40e_allocate_dma_mem_d(struct i40e_hw *hw, struct i40e_dma_mem *mem,
  **/
 int i40e_free_dma_mem_d(struct i40e_hw *hw, struct i40e_dma_mem *mem)
 {
-	struct i40e_pf *pf = (struct i40e_pf *)hw->back;
+	struct i40e_pf *pf = i40e_hw_to_pf(hw);
 
 	dma_free_coherent(&pf->pdev->dev, mem->size, mem->va, mem->pa);
 	mem->va = NULL;
@@ -15619,10 +15630,10 @@ static int i40e_init_recovery_mode(struct i40e_pf *pf, struct i40e_hw *hw)
  **/
 static inline void i40e_set_subsystem_device_id(struct i40e_hw *hw)
 {
-	struct pci_dev *pdev = ((struct i40e_pf *)hw->back)->pdev;
+	struct i40e_pf *pf = i40e_hw_to_pf(hw);
 
-	hw->subsystem_device_id = pdev->subsystem_device ?
-		pdev->subsystem_device :
+	hw->subsystem_device_id = pf->pdev->subsystem_device ?
+		pf->pdev->subsystem_device :
 		(ushort)(rd32(hw, I40E_PFPCI_SUBSYSID) & USHRT_MAX);
 }
 
@@ -15692,7 +15703,6 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	set_bit(__I40E_DOWN, pf->state);
 
 	hw = &pf->hw;
-	hw->back = pf;
 
 	pf->ioremap_len = min_t(int, pci_resource_len(pdev, 0),
 				I40E_MAX_CSR_SPACE);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_osdep.h b/drivers/net/ethernet/intel/i40e/i40e_osdep.h
index 2bd4de03dafa..997569a4ad57 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_osdep.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_osdep.h
@@ -18,10 +18,10 @@
  * actual OS primitives
  */
 
-#define hw_dbg(hw, S, A...)							\
-do {										\
-	dev_dbg(&((struct i40e_pf *)hw->back)->pdev->dev, S, ##A);		\
-} while (0)
+struct i40e_hw;
+struct device *i40e_hw_to_dev(struct i40e_hw *hw);
+
+#define hw_dbg(hw, S, A...) dev_dbg(i40e_hw_to_dev(hw), S, ##A)
 
 #define wr32(a, reg, value)	writel((value), ((a)->hw_addr + (reg)))
 #define rd32(a, reg)		readl((a)->hw_addr + (reg))
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 232131bedc3e..658bc8913278 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -525,7 +525,6 @@ struct i40e_dcbx_config {
 /* Port hardware description */
 struct i40e_hw {
 	u8 __iomem *hw_addr;
-	void *back;
 
 	/* subsystem structs */
 	struct i40e_phy_info phy;
-- 
2.38.1


