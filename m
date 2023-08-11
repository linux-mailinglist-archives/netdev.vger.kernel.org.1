Return-Path: <netdev+bounces-26777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1083D778ECB
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 14:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDCC7281A1F
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 12:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DEC12B6D;
	Fri, 11 Aug 2023 12:11:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E1712B65
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 12:11:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30060E55;
	Fri, 11 Aug 2023 05:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691755874; x=1723291874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5ICqtGaIKb34c4cygMFH/ekn4DHFgMuzIFwY2H+IcbU=;
  b=lTxckpOkFW9oF+VMERbFkNlbsieY8/O9RmQhCy8hj9cCQz6GXIHqpera
   uJy44RhP8QkqppDhtGFcqqKGqZK71qx2frEy0jvAQrhNRpr2bBDCl7y85
   F/MnhUtQUvZFdosWtWo1cvqTvkr5HjrzkUmD5ax+wiDT547BddmGvG0fp
   Ool8CifnhyLoP6ADzKh4bnVd4VF6PT+UPldysUWsUWOyFJ2Xtzm3ZGoGs
   /kEyGB/BSZcYx+5iNidKH6nBD223hAlf1q8jXawYuyhgLH/rOg3jxyRKa
   JRV8noWf/g/ccGvqvo7qM88XrWHzp/XwwboEhhi162/yrkT6c92z28Ki+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="438002121"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="438002121"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 05:11:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="906421890"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="906421890"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga005.jf.intel.com with ESMTP; 11 Aug 2023 05:11:11 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id F3B41333E2;
	Fri, 11 Aug 2023 13:11:09 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: Kees Cook <keescook@chromium.org>,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-hardening@vger.kernel.org,
	Steven Zou <steven.zou@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v2 4/7] ice: make use of DEFINE_FLEX() in ice_ddp.c
Date: Fri, 11 Aug 2023 08:08:11 -0400
Message-Id: <20230811120814.169952-5-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230811120814.169952-1-przemyslaw.kitszel@intel.com>
References: <20230811120814.169952-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Use DEFINE_FLEX() macro for constant-num-of-elems (4)
flex array members of ice_ddp.c

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
add/remove: 4/0 grow/shrink: 0/1 up/down: 1195/-878 (317)
---
 drivers/net/ethernet/intel/ice/ice_ddp.c | 39 +++++++-----------------
 1 file changed, 11 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
index d71ed210f9c4..0e64ecd6f7c5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ddp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
@@ -1558,21 +1558,14 @@ static enum ice_ddp_state ice_init_pkg_info(struct ice_hw *hw,
  */
 static enum ice_ddp_state ice_get_pkg_info(struct ice_hw *hw)
 {
-	enum ice_ddp_state state = ICE_DDP_PKG_SUCCESS;
-	struct ice_aqc_get_pkg_info_resp *pkg_info;
-	u16 size;
+	DEFINE_FLEX(struct ice_aqc_get_pkg_info_resp, pkg_info, pkg_info,
+		    ICE_PKG_CNT);
+	u16 size = __struct_size(pkg_info);
 	u32 i;
 
-	size = struct_size(pkg_info, pkg_info, ICE_PKG_CNT);
-	pkg_info = kzalloc(size, GFP_KERNEL);
-	if (!pkg_info)
+	if (ice_aq_get_pkg_info_list(hw, pkg_info, size, NULL))
 		return ICE_DDP_PKG_ERR;
 
-	if (ice_aq_get_pkg_info_list(hw, pkg_info, size, NULL)) {
-		state = ICE_DDP_PKG_ERR;
-		goto init_pkg_free_alloc;
-	}
-
 	for (i = 0; i < le32_to_cpu(pkg_info->count); i++) {
 #define ICE_PKG_FLAG_COUNT 4
 		char flags[ICE_PKG_FLAG_COUNT + 1] = { 0 };
@@ -1602,10 +1595,7 @@ static enum ice_ddp_state ice_get_pkg_info(struct ice_hw *hw)
 			  pkg_info->pkg_info[i].name, flags);
 	}
 
-init_pkg_free_alloc:
-	kfree(pkg_info);
-
-	return state;
+	return ICE_DDP_PKG_SUCCESS;
 }
 
 /**
@@ -1620,9 +1610,10 @@ static enum ice_ddp_state ice_chk_pkg_compat(struct ice_hw *hw,
 					     struct ice_pkg_hdr *ospkg,
 					     struct ice_seg **seg)
 {
-	struct ice_aqc_get_pkg_info_resp *pkg;
+	DEFINE_FLEX(struct ice_aqc_get_pkg_info_resp, pkg, pkg_info,
+		    ICE_PKG_CNT);
+	u16 size = __struct_size(pkg);
 	enum ice_ddp_state state;
-	u16 size;
 	u32 i;
 
 	/* Check package version compatibility */
@@ -1641,15 +1632,8 @@ static enum ice_ddp_state ice_chk_pkg_compat(struct ice_hw *hw,
 	}
 
 	/* Check if FW is compatible with the OS package */
-	size = struct_size(pkg, pkg_info, ICE_PKG_CNT);
-	pkg = kzalloc(size, GFP_KERNEL);
-	if (!pkg)
-		return ICE_DDP_PKG_ERR;
-
-	if (ice_aq_get_pkg_info_list(hw, pkg, size, NULL)) {
-		state = ICE_DDP_PKG_LOAD_ERROR;
-		goto fw_ddp_compat_free_alloc;
-	}
+	if (ice_aq_get_pkg_info_list(hw, pkg, size, NULL))
+		return ICE_DDP_PKG_LOAD_ERROR;
 
 	for (i = 0; i < le32_to_cpu(pkg->count); i++) {
 		/* loop till we find the NVM package */
@@ -1666,8 +1650,7 @@ static enum ice_ddp_state ice_chk_pkg_compat(struct ice_hw *hw,
 		/* done processing NVM package so break */
 		break;
 	}
-fw_ddp_compat_free_alloc:
-	kfree(pkg);
+
 	return state;
 }
 
-- 
2.40.1


