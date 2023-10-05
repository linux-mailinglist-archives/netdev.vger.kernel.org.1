Return-Path: <netdev+bounces-38325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AF87BA67F
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 18:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 037C7281C31
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 16:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2718F30CE8;
	Thu,  5 Oct 2023 16:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K0Kf1W+T"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD10D30CE1
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 16:35:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01711998
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 09:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696523610; x=1728059610;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rBA9hCId1RUf3ax1BFUSnFxUQHKa5aytwCKepUnzI4Y=;
  b=K0Kf1W+Tosb2Y3xqubwA5WVH6VKz5DkLl++QWKJ11j2M3D1x28DnVJYs
   dNFQhO7OYhT3LDkzC8HzSd36uV7eFCQTx4d2lo3N30LXAzfP3jon2G3dV
   aX7kh6rJ3O8tXD4dtw5JJOO/YuAJ75yR6ZeC9kYGcNwEeLDxhzTDljFYT
   l1F/9s98r9L8TNaqNERVeUWHeG0vM+9n09USSvD4PuMvYioIX2GxCEFd/
   FBgWYVMI9FCCjqdUsgT8U+IsHT/3PH3CXk8hoOELYwEHkQJ08QLNE9p2N
   AAq0C3tJZu7TRUMM8lzXytzcqoge8u3TV2ERDjqEkB7K88VkUYXukm6vS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="2152695"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="2152695"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 09:29:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="875607766"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="875607766"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga004.jf.intel.com with ESMTP; 05 Oct 2023 09:29:55 -0700
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
Subject: [PATCH net-next 9/9] i40e: Move DDP specific macros and structures to i40e_ddp.c
Date: Thu,  5 Oct 2023 09:28:50 -0700
Message-Id: <20231005162850.3218594-10-anthony.l.nguyen@intel.com>
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

Move several DDP related macros and structures from i40e.h header
to i40e_ddp.c where are privately used. Make static i40e_ddp_load()
function that is also used only in i40e_ddp and move declaration of
i40e_ddp_flash() used by i40e_ethtool.c to i40e_prototype.h

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h        | 24 -------------------
 drivers/net/ethernet/intel/i40e/i40e_ddp.c    | 22 +++++++++++++++--
 .../net/ethernet/intel/i40e/i40e_prototype.h  |  5 ++++
 3 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 107826c040c1..214744de120d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -4,7 +4,6 @@
 #ifndef _I40E_H_
 #define _I40E_H_
 
-#include <linux/ethtool.h>
 #include <linux/pci.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/types.h>
@@ -296,29 +295,6 @@ struct i40e_udp_port_config {
 	u8 filter_index;
 };
 
-#define I40_DDP_FLASH_REGION 100
-#define I40E_PROFILE_INFO_SIZE 48
-#define I40E_MAX_PROFILE_NUM 16
-#define I40E_PROFILE_LIST_SIZE \
-	(I40E_PROFILE_INFO_SIZE * I40E_MAX_PROFILE_NUM + 4)
-#define I40E_DDP_PROFILE_PATH "intel/i40e/ddp/"
-#define I40E_DDP_PROFILE_NAME_MAX 64
-
-int i40e_ddp_load(struct net_device *netdev, const u8 *data, size_t size,
-		  bool is_add);
-int i40e_ddp_flash(struct net_device *netdev, struct ethtool_flash *flash);
-
-struct i40e_ddp_profile_list {
-	u32 p_count;
-	struct i40e_profile_info p_info[];
-};
-
-struct i40e_ddp_old_profile_list {
-	struct list_head list;
-	size_t old_ddp_size;
-	u8 old_ddp_buf[];
-};
-
 /* macros related to FLX_PIT */
 #define I40E_FLEX_SET_FSIZE(fsize) (((fsize) << \
 				    I40E_PRTQF_FLX_PIT_FSIZE_SHIFT) & \
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ddp.c b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
index 21b3518c4096..6b68b6575a1d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ddp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ddp.c
@@ -4,6 +4,24 @@
 #include <linux/firmware.h>
 #include "i40e.h"
 
+#define I40_DDP_FLASH_REGION		100
+#define I40E_PROFILE_INFO_SIZE		48
+#define I40E_MAX_PROFILE_NUM		16
+#define I40E_PROFILE_LIST_SIZE		\
+	(I40E_PROFILE_INFO_SIZE * I40E_MAX_PROFILE_NUM + 4)
+#define I40E_DDP_PROFILE_PATH		"intel/i40e/ddp/"
+#define I40E_DDP_PROFILE_NAME_MAX	64
+
+struct i40e_ddp_profile_list {
+	u32 p_count;
+	struct i40e_profile_info p_info[];
+};
+
+struct i40e_ddp_old_profile_list {
+	struct list_head list;
+	size_t old_ddp_size;
+	u8 old_ddp_buf[];
+};
 
 /**
  * i40e_ddp_profiles_eq - checks if DDP profiles are the equivalent
@@ -261,8 +279,8 @@ static bool i40e_ddp_is_pkg_hdr_valid(struct net_device *netdev,
  * Checks correctness and loads DDP profile to the NIC. The function is
  * also used for rolling back previously loaded profile.
  **/
-int i40e_ddp_load(struct net_device *netdev, const u8 *data, size_t size,
-		  bool is_add)
+static int i40e_ddp_load(struct net_device *netdev, const u8 *data, size_t size,
+			 bool is_add)
 {
 	u8 profile_info_sec[sizeof(struct i40e_profile_section_header) +
 			    sizeof(struct i40e_profile_info)];
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index 2001fefa0c52..46b9a05ceb91 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -4,6 +4,7 @@
 #ifndef _I40E_PROTOTYPE_H_
 #define _I40E_PROTOTYPE_H_
 
+#include <linux/ethtool.h>
 #include <linux/avf/virtchnl.h>
 #include "i40e_debug.h"
 #include "i40e_type.h"
@@ -497,4 +498,8 @@ int
 i40e_add_pinfo_to_list(struct i40e_hw *hw,
 		       struct i40e_profile_segment *profile,
 		       u8 *profile_info_sec, u32 track_id);
+
+/* i40e_ddp */
+int i40e_ddp_flash(struct net_device *netdev, struct ethtool_flash *flash);
+
 #endif /* _I40E_PROTOTYPE_H_ */
-- 
2.38.1


