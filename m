Return-Path: <netdev+bounces-28612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE9777FFE6
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 23:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603B0281F25
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 21:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858DE1BB50;
	Thu, 17 Aug 2023 21:29:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4791BB4F
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 21:29:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36EAE56
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 14:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692307776; x=1723843776;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mGFNu249rgf+huStE14W8ojPimSdurYCP4QniMeARdI=;
  b=ViZtilf8G1xiwFBqErYJKPrr6MUFU1UHF7YVRDPB8/q5AusHBuAbUAee
   JKlLIyewS7vAe4otUwAXcuynhJCJkqWAtvwP1K4/plqwjO65sxMkhagv1
   mg5PqNSrsPi6s6Z2TAouODmUU0qBDy6O/k959pwc25HM8JGHdRnBh+FOZ
   cDOlKB/ME9gPdOTCBYaFk1Jri/ydU9WFbZu9Wr9xV7qf1N3m+4lOJatsx
   pZqz3i434RqS7T1NDKdBI3BZnn4hDAPM8IPRYtVKzlt6/rlUpYNrgW4Ms
   904bbwi7i83e61UkN9DWpw6TwQX3bd4giDZ0EgeSHxzo/ZVyl8XiEL7vz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="363095045"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="363095045"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 14:29:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="824813697"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="824813697"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Aug 2023 14:29:35 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jan Sokolowski <jan.sokolowski@intel.com>,
	anthony.l.nguyen@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH net-next v2 02/15] ice: refactor ice_ddp to make functions static
Date: Thu, 17 Aug 2023 14:22:26 -0700
Message-Id: <20230817212239.2601543-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230817212239.2601543-1-anthony.l.nguyen@intel.com>
References: <20230817212239.2601543-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jan Sokolowski <jan.sokolowski@intel.com>

As following methods are not used outside of ice_ddp,
they can be made static:
ice_verify_pgk
ice_pkg_val_buf
ice_aq_download_pkg
ice_aq_update_pkg
ice_find_seg_in_pkg

Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ddp.c | 120 ++++++++++++-----------
 drivers/net/ethernet/intel/ice/ice_ddp.h |  10 --
 2 files changed, 61 insertions(+), 69 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index d71ed210f9c4..b27ec93638b6 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -30,7 +30,7 @@ static const struct ice_tunnel_type_scan tnls[] = {
  * Verifies various attributes of the package file, including length, format
  * version, and the requirement of at least one segment.
  */
-enum ice_ddp_state ice_verify_pkg(struct ice_pkg_hdr *pkg, u32 len)
+static enum ice_ddp_state ice_verify_pkg(struct ice_pkg_hdr *pkg, u32 len)
 {
 	u32 seg_count;
 	u32 i;
@@ -118,7 +118,7 @@ static enum ice_ddp_state ice_chk_pkg_version(struct ice_pkg_ver *pkg_ver)
  *
  * This helper function validates a buffer's header.
  */
-struct ice_buf_hdr *ice_pkg_val_buf(struct ice_buf *buf)
+static struct ice_buf_hdr *ice_pkg_val_buf(struct ice_buf *buf)
 {
 	struct ice_buf_hdr *hdr;
 	u16 section_count;
@@ -1152,6 +1152,54 @@ static void ice_release_global_cfg_lock(struct ice_hw *hw)
 	ice_release_res(hw, ICE_GLOBAL_CFG_LOCK_RES_ID);
 }
 
+/**
+ * ice_aq_download_pkg
+ * @hw: pointer to the hardware structure
+ * @pkg_buf: the package buffer to transfer
+ * @buf_size: the size of the package buffer
+ * @last_buf: last buffer indicator
+ * @error_offset: returns error offset
+ * @error_info: returns error information
+ * @cd: pointer to command details structure or NULL
+ *
+ * Download Package (0x0C40)
+ */
+static int
+ice_aq_download_pkg(struct ice_hw *hw, struct ice_buf_hdr *pkg_buf,
+		    u16 buf_size, bool last_buf, u32 *error_offset,
+		    u32 *error_info, struct ice_sq_cd *cd)
+{
+	struct ice_aqc_download_pkg *cmd;
+	struct ice_aq_desc desc;
+	int status;
+
+	if (error_offset)
+		*error_offset = 0;
+	if (error_info)
+		*error_info = 0;
+
+	cmd = &desc.params.download_pkg;
+	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_download_pkg);
+	desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
+
+	if (last_buf)
+		cmd->flags |= ICE_AQC_DOWNLOAD_PKG_LAST_BUF;
+
+	status = ice_aq_send_cmd(hw, &desc, pkg_buf, buf_size, cd);
+	if (status == -EIO) {
+		/* Read error from buffer only when the FW returned an error */
+		struct ice_aqc_download_pkg_resp *resp;
+
+		resp = (struct ice_aqc_download_pkg_resp *)pkg_buf;
+		if (error_offset)
+			*error_offset = le32_to_cpu(resp->error_offset);
+		if (error_info)
+			*error_info = le32_to_cpu(resp->error_info);
+	}
+
+	return status;
+}
+
 /**
  * ice_dwnld_cfg_bufs
  * @hw: pointer to the hardware structure
@@ -1294,20 +1342,20 @@ static enum ice_ddp_state ice_download_pkg(struct ice_hw *hw,
 }
 
 /**
- * ice_aq_download_pkg
+ * ice_aq_update_pkg
  * @hw: pointer to the hardware structure
- * @pkg_buf: the package buffer to transfer
- * @buf_size: the size of the package buffer
+ * @pkg_buf: the package cmd buffer
+ * @buf_size: the size of the package cmd buffer
  * @last_buf: last buffer indicator
  * @error_offset: returns error offset
  * @error_info: returns error information
  * @cd: pointer to command details structure or NULL
  *
- * Download Package (0x0C40)
+ * Update Package (0x0C42)
  */
-int ice_aq_download_pkg(struct ice_hw *hw, struct ice_buf_hdr *pkg_buf,
-			u16 buf_size, bool last_buf, u32 *error_offset,
-			u32 *error_info, struct ice_sq_cd *cd)
+static int ice_aq_update_pkg(struct ice_hw *hw, struct ice_buf_hdr *pkg_buf,
+			     u16 buf_size, bool last_buf, u32 *error_offset,
+			     u32 *error_info, struct ice_sq_cd *cd)
 {
 	struct ice_aqc_download_pkg *cmd;
 	struct ice_aq_desc desc;
@@ -1319,7 +1367,7 @@ int ice_aq_download_pkg(struct ice_hw *hw, struct ice_buf_hdr *pkg_buf,
 		*error_info = 0;
 
 	cmd = &desc.params.download_pkg;
-	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_download_pkg);
+	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_update_pkg);
 	desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
 
 	if (last_buf)
@@ -1360,53 +1408,6 @@ int ice_aq_upload_section(struct ice_hw *hw, struct ice_buf_hdr *pkg_buf,
 	return ice_aq_send_cmd(hw, &desc, pkg_buf, buf_size, cd);
 }
 
-/**
- * ice_aq_update_pkg
- * @hw: pointer to the hardware structure
- * @pkg_buf: the package cmd buffer
- * @buf_size: the size of the package cmd buffer
- * @last_buf: last buffer indicator
- * @error_offset: returns error offset
- * @error_info: returns error information
- * @cd: pointer to command details structure or NULL
- *
- * Update Package (0x0C42)
- */
-static int ice_aq_update_pkg(struct ice_hw *hw, struct ice_buf_hdr *pkg_buf,
-			     u16 buf_size, bool last_buf, u32 *error_offset,
-			     u32 *error_info, struct ice_sq_cd *cd)
-{
-	struct ice_aqc_download_pkg *cmd;
-	struct ice_aq_desc desc;
-	int status;
-
-	if (error_offset)
-		*error_offset = 0;
-	if (error_info)
-		*error_info = 0;
-
-	cmd = &desc.params.download_pkg;
-	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_update_pkg);
-	desc.flags |= cpu_to_le16(ICE_AQ_FLAG_RD);
-
-	if (last_buf)
-		cmd->flags |= ICE_AQC_DOWNLOAD_PKG_LAST_BUF;
-
-	status = ice_aq_send_cmd(hw, &desc, pkg_buf, buf_size, cd);
-	if (status == -EIO) {
-		/* Read error from buffer only when the FW returned an error */
-		struct ice_aqc_download_pkg_resp *resp;
-
-		resp = (struct ice_aqc_download_pkg_resp *)pkg_buf;
-		if (error_offset)
-			*error_offset = le32_to_cpu(resp->error_offset);
-		if (error_info)
-			*error_info = le32_to_cpu(resp->error_info);
-	}
-
-	return status;
-}
-
 /**
  * ice_update_pkg_no_lock
  * @hw: pointer to the hardware structure
@@ -1470,8 +1471,9 @@ int ice_update_pkg(struct ice_hw *hw, struct ice_buf *bufs, u32 count)
  * success it returns a pointer to the segment header, otherwise it will
  * return NULL.
  */
-struct ice_generic_seg_hdr *ice_find_seg_in_pkg(struct ice_hw *hw, u32 seg_type,
-						struct ice_pkg_hdr *pkg_hdr)
+static struct ice_generic_seg_hdr *
+ice_find_seg_in_pkg(struct ice_hw *hw, u32 seg_type,
+		    struct ice_pkg_hdr *pkg_hdr)
 {
 	u32 i;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.h b/drivers/net/ethernet/intel/ice/ice_ddp.h
index 41acfe26df1c..abb5f32f2ef4 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.h
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.h
@@ -416,21 +416,13 @@ struct ice_pkg_enum {
 	void *(*handler)(u32 sect_type, void *section, u32 index, u32 *offset);
 };
 
-int ice_aq_download_pkg(struct ice_hw *hw, struct ice_buf_hdr *pkg_buf,
-			u16 buf_size, bool last_buf, u32 *error_offset,
-			u32 *error_info, struct ice_sq_cd *cd);
 int ice_aq_upload_section(struct ice_hw *hw, struct ice_buf_hdr *pkg_buf,
 			  u16 buf_size, struct ice_sq_cd *cd);
 
 void *ice_pkg_buf_alloc_section(struct ice_buf_build *bld, u32 type, u16 size);
 
-enum ice_ddp_state ice_verify_pkg(struct ice_pkg_hdr *pkg, u32 len);
-
 struct ice_buf_build *ice_pkg_buf_alloc(struct ice_hw *hw);
 
-struct ice_generic_seg_hdr *ice_find_seg_in_pkg(struct ice_hw *hw, u32 seg_type,
-						struct ice_pkg_hdr *pkg_hdr);
-
 int ice_update_pkg_no_lock(struct ice_hw *hw, struct ice_buf *bufs, u32 count);
 int ice_update_pkg(struct ice_hw *hw, struct ice_buf *bufs, u32 count);
 
@@ -439,6 +431,4 @@ u16 ice_pkg_buf_get_active_sections(struct ice_buf_build *bld);
 void *ice_pkg_enum_section(struct ice_seg *ice_seg, struct ice_pkg_enum *state,
 			   u32 sect_type);
 
-struct ice_buf_hdr *ice_pkg_val_buf(struct ice_buf *buf);
-
 #endif
-- 
2.38.1


