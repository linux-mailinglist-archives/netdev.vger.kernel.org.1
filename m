Return-Path: <netdev+bounces-38320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 704947BA66C
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 18:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id CEE0B1F23438
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 16:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33E32AB51;
	Thu,  5 Oct 2023 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BeO1bv3z"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189D837165
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 16:34:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4217C10FD
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 09:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696523607; x=1728059607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H4tVF3AGFD8z0oPFyVS7XspV2q8D9YiA3l5U6eh2cCk=;
  b=BeO1bv3zas+6Ph989GEDJT94jjlPA42HwZu/8leDwn4L2HzH/ly8UlW+
   41p1w5C9pOGFSARlcNgt4UerQWLg36UsvW/BMyBHulgb88wwi0q3nhWDA
   ETODJvSdrktDRjyqFMtXAXVsFrP3ZPdUvREM+0L9fmyu995iu/AdbbwIK
   dWWP51aoHHkK56yzum3s2H6kBzCbu0vonQhxCOV71OdxXCTJmTOTUQyDk
   1G1NfzIHtnXTiS6gL1jPeOO4vAGev1Ka7GFprxd2KJ8qFedMKcpU+BWh0
   z85rmTqVX7pCf8wWP/4puO3IsQBa+iz6SqOcpx278dgJv9ZYD33m2j3fv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="2152673"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="2152673"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 09:29:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="875607746"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="875607746"
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
Subject: [PATCH net-next 5/9] i40e: Simplify memory allocation functions
Date: Thu,  5 Oct 2023 09:28:46 -0700
Message-Id: <20231005162850.3218594-6-anthony.l.nguyen@intel.com>
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

Enum i40e_memory_type enum is unused in i40e_allocate_dma_mem() thus
can be safely removed. Useless macros in i40e_alloc.h can be removed
as well.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.c |  4 ----
 drivers/net/ethernet/intel/i40e/i40e_alloc.h  | 14 -------------
 drivers/net/ethernet/intel/i40e/i40e_hmc.c    | 12 ++++-------
 drivers/net/ethernet/intel/i40e/i40e_main.c   | 20 +++++++++----------
 drivers/net/ethernet/intel/i40e/i40e_osdep.h  |  7 -------
 5 files changed, 14 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
index 100eb77b8dfe..e72cfe587c89 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
@@ -51,7 +51,6 @@ static int i40e_alloc_adminq_asq_ring(struct i40e_hw *hw)
 	int ret_code;
 
 	ret_code = i40e_allocate_dma_mem(hw, &hw->aq.asq.desc_buf,
-					 i40e_mem_atq_ring,
 					 (hw->aq.num_asq_entries *
 					 sizeof(struct i40e_aq_desc)),
 					 I40E_ADMINQ_DESC_ALIGNMENT);
@@ -78,7 +77,6 @@ static int i40e_alloc_adminq_arq_ring(struct i40e_hw *hw)
 	int ret_code;
 
 	ret_code = i40e_allocate_dma_mem(hw, &hw->aq.arq.desc_buf,
-					 i40e_mem_arq_ring,
 					 (hw->aq.num_arq_entries *
 					 sizeof(struct i40e_aq_desc)),
 					 I40E_ADMINQ_DESC_ALIGNMENT);
@@ -136,7 +134,6 @@ static int i40e_alloc_arq_bufs(struct i40e_hw *hw)
 	for (i = 0; i < hw->aq.num_arq_entries; i++) {
 		bi = &hw->aq.arq.r.arq_bi[i];
 		ret_code = i40e_allocate_dma_mem(hw, bi,
-						 i40e_mem_arq_buf,
 						 hw->aq.arq_buf_size,
 						 I40E_ADMINQ_DESC_ALIGNMENT);
 		if (ret_code)
@@ -198,7 +195,6 @@ static int i40e_alloc_asq_bufs(struct i40e_hw *hw)
 	for (i = 0; i < hw->aq.num_asq_entries; i++) {
 		bi = &hw->aq.asq.r.asq_bi[i];
 		ret_code = i40e_allocate_dma_mem(hw, bi,
-						 i40e_mem_asq_buf,
 						 hw->aq.asq_buf_size,
 						 I40E_ADMINQ_DESC_ALIGNMENT);
 		if (ret_code)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_alloc.h b/drivers/net/ethernet/intel/i40e/i40e_alloc.h
index a6c9a9e343d1..4b2d8da048c6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_alloc.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_alloc.h
@@ -6,23 +6,9 @@
 
 struct i40e_hw;
 
-/* Memory allocation types */
-enum i40e_memory_type {
-	i40e_mem_arq_buf = 0,		/* ARQ indirect command buffer */
-	i40e_mem_asq_buf = 1,
-	i40e_mem_atq_buf = 2,		/* ATQ indirect command buffer */
-	i40e_mem_arq_ring = 3,		/* ARQ descriptor ring */
-	i40e_mem_atq_ring = 4,		/* ATQ descriptor ring */
-	i40e_mem_pd = 5,		/* Page Descriptor */
-	i40e_mem_bp = 6,		/* Backing Page - 4KB */
-	i40e_mem_bp_jumbo = 7,		/* Backing Page - > 4KB */
-	i40e_mem_reserved
-};
-
 /* prototype for functions used for dynamic memory allocation */
 int i40e_allocate_dma_mem(struct i40e_hw *hw,
 			  struct i40e_dma_mem *mem,
-			  enum i40e_memory_type type,
 			  u64 size, u32 alignment);
 int i40e_free_dma_mem(struct i40e_hw *hw,
 		      struct i40e_dma_mem *mem);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_hmc.c b/drivers/net/ethernet/intel/i40e/i40e_hmc.c
index 96ee63aca7a1..7451d346ae83 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_hmc.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_hmc.c
@@ -22,7 +22,6 @@ int i40e_add_sd_table_entry(struct i40e_hw *hw,
 			    enum i40e_sd_entry_type type,
 			    u64 direct_mode_sz)
 {
-	enum i40e_memory_type mem_type __attribute__((unused));
 	struct i40e_hmc_sd_entry *sd_entry;
 	bool dma_mem_alloc_done = false;
 	struct i40e_dma_mem mem;
@@ -43,16 +42,13 @@ int i40e_add_sd_table_entry(struct i40e_hw *hw,
 
 	sd_entry = &hmc_info->sd_table.sd_entry[sd_index];
 	if (!sd_entry->valid) {
-		if (I40E_SD_TYPE_PAGED == type) {
-			mem_type = i40e_mem_pd;
+		if (type == I40E_SD_TYPE_PAGED)
 			alloc_len = I40E_HMC_PAGED_BP_SIZE;
-		} else {
-			mem_type = i40e_mem_bp_jumbo;
+		else
 			alloc_len = direct_mode_sz;
-		}
 
 		/* allocate a 4K pd page or 2M backing page */
-		ret_code = i40e_allocate_dma_mem(hw, &mem, mem_type, alloc_len,
+		ret_code = i40e_allocate_dma_mem(hw, &mem, alloc_len,
 						 I40E_HMC_PD_BP_BUF_ALIGNMENT);
 		if (ret_code)
 			goto exit;
@@ -140,7 +136,7 @@ int i40e_add_pd_table_entry(struct i40e_hw *hw,
 			page = rsrc_pg;
 		} else {
 			/* allocate a 4K backing page */
-			ret_code = i40e_allocate_dma_mem(hw, page, i40e_mem_bp,
+			ret_code = i40e_allocate_dma_mem(hw, page,
 						I40E_HMC_PAGED_BP_SIZE,
 						I40E_HMC_PD_BP_BUF_ALIGNMENT);
 			if (ret_code)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a6f7124d009a..4ad845a77067 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -131,14 +131,14 @@ struct device *i40e_hw_to_dev(struct i40e_hw *hw)
 }
 
 /**
- * i40e_allocate_dma_mem_d - OS specific memory alloc for shared code
+ * i40e_allocate_dma_mem - OS specific memory alloc for shared code
  * @hw:   pointer to the HW structure
  * @mem:  ptr to mem struct to fill out
  * @size: size of memory requested
  * @alignment: what to align the allocation to
  **/
-int i40e_allocate_dma_mem_d(struct i40e_hw *hw, struct i40e_dma_mem *mem,
-			    u64 size, u32 alignment)
+int i40e_allocate_dma_mem(struct i40e_hw *hw, struct i40e_dma_mem *mem,
+			  u64 size, u32 alignment)
 {
 	struct i40e_pf *pf = i40e_hw_to_pf(hw);
 
@@ -152,11 +152,11 @@ int i40e_allocate_dma_mem_d(struct i40e_hw *hw, struct i40e_dma_mem *mem,
 }
 
 /**
- * i40e_free_dma_mem_d - OS specific memory free for shared code
+ * i40e_free_dma_mem - OS specific memory free for shared code
  * @hw:   pointer to the HW structure
  * @mem:  ptr to mem struct to free
  **/
-int i40e_free_dma_mem_d(struct i40e_hw *hw, struct i40e_dma_mem *mem)
+int i40e_free_dma_mem(struct i40e_hw *hw, struct i40e_dma_mem *mem)
 {
 	struct i40e_pf *pf = i40e_hw_to_pf(hw);
 
@@ -169,13 +169,13 @@ int i40e_free_dma_mem_d(struct i40e_hw *hw, struct i40e_dma_mem *mem)
 }
 
 /**
- * i40e_allocate_virt_mem_d - OS specific memory alloc for shared code
+ * i40e_allocate_virt_mem - OS specific memory alloc for shared code
  * @hw:   pointer to the HW structure
  * @mem:  ptr to mem struct to fill out
  * @size: size of memory requested
  **/
-int i40e_allocate_virt_mem_d(struct i40e_hw *hw, struct i40e_virt_mem *mem,
-			     u32 size)
+int i40e_allocate_virt_mem(struct i40e_hw *hw, struct i40e_virt_mem *mem,
+			   u32 size)
 {
 	mem->size = size;
 	mem->va = kzalloc(size, GFP_KERNEL);
@@ -187,11 +187,11 @@ int i40e_allocate_virt_mem_d(struct i40e_hw *hw, struct i40e_virt_mem *mem,
 }
 
 /**
- * i40e_free_virt_mem_d - OS specific memory free for shared code
+ * i40e_free_virt_mem - OS specific memory free for shared code
  * @hw:   pointer to the HW structure
  * @mem:  ptr to mem struct to free
  **/
-int i40e_free_virt_mem_d(struct i40e_hw *hw, struct i40e_virt_mem *mem)
+int i40e_free_virt_mem(struct i40e_hw *hw, struct i40e_virt_mem *mem)
 {
 	/* it's ok to kfree a NULL pointer */
 	kfree(mem->va);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_osdep.h b/drivers/net/ethernet/intel/i40e/i40e_osdep.h
index 997569a4ad57..70cac3bb31ec 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_osdep.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_osdep.h
@@ -36,18 +36,11 @@ struct i40e_dma_mem {
 	u32 size;
 };
 
-#define i40e_allocate_dma_mem(h, m, unused, s, a) \
-			i40e_allocate_dma_mem_d(h, m, s, a)
-#define i40e_free_dma_mem(h, m) i40e_free_dma_mem_d(h, m)
-
 struct i40e_virt_mem {
 	void *va;
 	u32 size;
 };
 
-#define i40e_allocate_virt_mem(h, m, s) i40e_allocate_virt_mem_d(h, m, s)
-#define i40e_free_virt_mem(h, m) i40e_free_virt_mem_d(h, m)
-
 #define i40e_debug(h, m, s, ...)				\
 do {								\
 	if (((m) & (h)->debug_mask))				\
-- 
2.38.1


