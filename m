Return-Path: <netdev+bounces-13141-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D9973A6F1
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 19:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08CA0280E51
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 17:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72104200B4;
	Thu, 22 Jun 2023 17:06:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602BD200AC
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 17:06:00 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FF0171C
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 10:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687453554; x=1718989554;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hV16s8TElbhtP3JupYXd56hiW4DRvxmqQ3bxk0Xs33o=;
  b=W4N3G+0Vqt25uZHKQyBc/x3mCd/fQZGKVSbrElvKIi/PiG1eJYIFRx3J
   Qx9fQaUopE8lZ+EX+VBykcd0VXFhlQH9s0KXp4Cb9xwLMIYhA/8QCyFZh
   5PmbpW/66d/ih/M/Hy13PJ2NKJ+W8MOviv4z+eofjDfZxlVQ+MN273XPZ
   lTRDacWnDb63wk1cUpEED/8IK/R4RNzgjVvspPq/nkBlN4M3lNKUCJgaN
   NKhhsApMz/xRF2SpLNVMH0GU+NwcYQDwentu/Smd8N/5KgSJWKBhhV0K9
   Oys8NffDYYUxUkduPghBG1Ip9gHUKBo9p0cnecV/fwHKsZ200diuKGdRn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="390353112"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="390353112"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 10:04:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="714971001"
X-IronPort-AV: E=Sophos;i="6.01,149,1684825200"; 
   d="scan'208";a="714971001"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga002.jf.intel.com with ESMTP; 22 Jun 2023 10:04:09 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com
Subject: [PATCH net-next 2/3] iavf: remove some unused functions and pointless wrappers
Date: Thu, 22 Jun 2023 09:59:13 -0700
Message-Id: <20230622165914.2203081-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230622165914.2203081-1-anthony.l.nguyen@intel.com>
References: <20230622165914.2203081-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Remove iavf_aq_get_rss_lut(), iavf_aq_get_rss_key(), iavf_vf_reset().

Remove some "OS specific memory free for shared code" wrappers ;)

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_alloc.h  |  3 +-
 drivers/net/ethernet/intel/iavf/iavf_common.c | 45 -------------------
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 22 +++------
 drivers/net/ethernet/intel/iavf/iavf_osdep.h  |  9 ----
 .../net/ethernet/intel/iavf/iavf_prototype.h  |  5 ---
 5 files changed, 8 insertions(+), 76 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_alloc.h b/drivers/net/ethernet/intel/iavf/iavf_alloc.h
index 2711573c14ec..162ea70685a6 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_alloc.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_alloc.h
@@ -28,7 +28,6 @@ enum iavf_status iavf_free_dma_mem(struct iavf_hw *hw,
 				   struct iavf_dma_mem *mem);
 enum iavf_status iavf_allocate_virt_mem(struct iavf_hw *hw,
 					struct iavf_virt_mem *mem, u32 size);
-enum iavf_status iavf_free_virt_mem(struct iavf_hw *hw,
-				    struct iavf_virt_mem *mem);
+void iavf_free_virt_mem(struct iavf_hw *hw, struct iavf_virt_mem *mem);
 
 #endif /* _IAVF_ALLOC_H_ */
diff --git a/drivers/net/ethernet/intel/iavf/iavf_common.c b/drivers/net/ethernet/intel/iavf/iavf_common.c
index dd11dbbd5551..1afd761d8052 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_common.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_common.c
@@ -35,7 +35,6 @@ enum iavf_status iavf_set_mac_type(struct iavf_hw *hw)
 		status = IAVF_ERR_DEVICE_NOT_SUPPORTED;
 	}
 
-	hw_dbg(hw, "found mac: %d, returns: %d\n", hw->mac.type, status);
 	return status;
 }
 
@@ -397,23 +396,6 @@ static enum iavf_status iavf_aq_get_set_rss_lut(struct iavf_hw *hw,
 	return status;
 }
 
-/**
- * iavf_aq_get_rss_lut
- * @hw: pointer to the hardware structure
- * @vsi_id: vsi fw index
- * @pf_lut: for PF table set true, for VSI table set false
- * @lut: pointer to the lut buffer provided by the caller
- * @lut_size: size of the lut buffer
- *
- * get the RSS lookup table, PF or VSI type
- **/
-enum iavf_status iavf_aq_get_rss_lut(struct iavf_hw *hw, u16 vsi_id,
-				     bool pf_lut, u8 *lut, u16 lut_size)
-{
-	return iavf_aq_get_set_rss_lut(hw, vsi_id, pf_lut, lut, lut_size,
-				       false);
-}
-
 /**
  * iavf_aq_set_rss_lut
  * @hw: pointer to the hardware structure
@@ -472,19 +454,6 @@ iavf_status iavf_aq_get_set_rss_key(struct iavf_hw *hw, u16 vsi_id,
 	return status;
 }
 
-/**
- * iavf_aq_get_rss_key
- * @hw: pointer to the hw struct
- * @vsi_id: vsi fw index
- * @key: pointer to key info struct
- *
- **/
-enum iavf_status iavf_aq_get_rss_key(struct iavf_hw *hw, u16 vsi_id,
-				     struct iavf_aqc_get_set_rss_key_data *key)
-{
-	return iavf_aq_get_set_rss_key(hw, vsi_id, key, false);
-}
-
 /**
  * iavf_aq_set_rss_key
  * @hw: pointer to the hw struct
@@ -828,17 +797,3 @@ void iavf_vf_parse_hw_config(struct iavf_hw *hw,
 		vsi_res++;
 	}
 }
-
-/**
- * iavf_vf_reset
- * @hw: pointer to the hardware structure
- *
- * Send a VF_RESET message to the PF. Does not wait for response from PF
- * as none will be forthcoming. Immediately after calling this function,
- * the admin queue should be shut down and (optionally) reinitialized.
- **/
-enum iavf_status iavf_vf_reset(struct iavf_hw *hw)
-{
-	return iavf_aq_send_msg_to_pf(hw, VIRTCHNL_OP_RESET_VF,
-				      0, NULL, 0, NULL);
-}
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index f8e6f3cd7b38..f83720a72cc0 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -192,12 +192,11 @@ enum iavf_status iavf_allocate_dma_mem_d(struct iavf_hw *hw,
 }
 
 /**
- * iavf_free_dma_mem_d - OS specific memory free for shared code
+ * iavf_free_dma_mem - wrapper for DMA memory freeing
  * @hw:   pointer to the HW structure
  * @mem:  ptr to mem struct to free
  **/
-enum iavf_status iavf_free_dma_mem_d(struct iavf_hw *hw,
-				     struct iavf_dma_mem *mem)
+enum iavf_status iavf_free_dma_mem(struct iavf_hw *hw, struct iavf_dma_mem *mem)
 {
 	struct iavf_adapter *adapter = (struct iavf_adapter *)hw->back;
 
@@ -209,13 +208,13 @@ enum iavf_status iavf_free_dma_mem_d(struct iavf_hw *hw,
 }
 
 /**
- * iavf_allocate_virt_mem_d - OS specific memory alloc for shared code
+ * iavf_allocate_virt_mem - virt memory alloc wrapper
  * @hw:   pointer to the HW structure
  * @mem:  ptr to mem struct to fill out
  * @size: size of memory requested
  **/
-enum iavf_status iavf_allocate_virt_mem_d(struct iavf_hw *hw,
-					  struct iavf_virt_mem *mem, u32 size)
+enum iavf_status iavf_allocate_virt_mem(struct iavf_hw *hw,
+					struct iavf_virt_mem *mem, u32 size)
 {
 	if (!mem)
 		return IAVF_ERR_PARAM;
@@ -230,20 +229,13 @@ enum iavf_status iavf_allocate_virt_mem_d(struct iavf_hw *hw,
 }
 
 /**
- * iavf_free_virt_mem_d - OS specific memory free for shared code
+ * iavf_free_virt_mem - virt memory free wrapper
  * @hw:   pointer to the HW structure
  * @mem:  ptr to mem struct to free
  **/
-enum iavf_status iavf_free_virt_mem_d(struct iavf_hw *hw,
-				      struct iavf_virt_mem *mem)
+void iavf_free_virt_mem(struct iavf_hw *hw, struct iavf_virt_mem *mem)
 {
-	if (!mem)
-		return IAVF_ERR_PARAM;
-
-	/* it's ok to kfree a NULL pointer */
 	kfree(mem->va);
-
-	return 0;
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/iavf/iavf_osdep.h b/drivers/net/ethernet/intel/iavf/iavf_osdep.h
index a452ce90679a..77d33deaabb5 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_osdep.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_osdep.h
@@ -13,12 +13,6 @@
 /* get readq/writeq support for 32 bit kernels, use the low-first version */
 #include <linux/io-64-nonatomic-lo-hi.h>
 
-/* File to be the magic between shared code and
- * actual OS primitives
- */
-
-#define hw_dbg(hw, S, A...)	do {} while (0)
-
 #define wr32(a, reg, value)	writel((value), ((a)->hw_addr + (reg)))
 #define rd32(a, reg)		readl((a)->hw_addr + (reg))
 
@@ -35,14 +29,11 @@ struct iavf_dma_mem {
 
 #define iavf_allocate_dma_mem(h, m, unused, s, a) \
 	iavf_allocate_dma_mem_d(h, m, s, a)
-#define iavf_free_dma_mem(h, m) iavf_free_dma_mem_d(h, m)
 
 struct iavf_virt_mem {
 	void *va;
 	u32 size;
 };
-#define iavf_allocate_virt_mem(h, m, s) iavf_allocate_virt_mem_d(h, m, s)
-#define iavf_free_virt_mem(h, m) iavf_free_virt_mem_d(h, m)
 
 #define iavf_debug(h, m, s, ...)				\
 do {								\
diff --git a/drivers/net/ethernet/intel/iavf/iavf_prototype.h b/drivers/net/ethernet/intel/iavf/iavf_prototype.h
index edebfbbcffdc..940cb4203fbe 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_prototype.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_prototype.h
@@ -40,12 +40,8 @@ enum iavf_status iavf_aq_queue_shutdown(struct iavf_hw *hw, bool unloading);
 const char *iavf_aq_str(struct iavf_hw *hw, enum iavf_admin_queue_err aq_err);
 const char *iavf_stat_str(struct iavf_hw *hw, enum iavf_status stat_err);
 
-enum iavf_status iavf_aq_get_rss_lut(struct iavf_hw *hw, u16 seid,
-				     bool pf_lut, u8 *lut, u16 lut_size);
 enum iavf_status iavf_aq_set_rss_lut(struct iavf_hw *hw, u16 seid,
 				     bool pf_lut, u8 *lut, u16 lut_size);
-enum iavf_status iavf_aq_get_rss_key(struct iavf_hw *hw, u16 seid,
-				     struct iavf_aqc_get_set_rss_key_data *key);
 enum iavf_status iavf_aq_set_rss_key(struct iavf_hw *hw, u16 seid,
 				     struct iavf_aqc_get_set_rss_key_data *key);
 
@@ -60,7 +56,6 @@ static inline struct iavf_rx_ptype_decoded decode_rx_desc_ptype(u8 ptype)
 
 void iavf_vf_parse_hw_config(struct iavf_hw *hw,
 			     struct virtchnl_vf_resource *msg);
-enum iavf_status iavf_vf_reset(struct iavf_hw *hw);
 enum iavf_status iavf_aq_send_msg_to_pf(struct iavf_hw *hw,
 					enum virtchnl_ops v_opcode,
 					enum iavf_status v_retval,
-- 
2.38.1


