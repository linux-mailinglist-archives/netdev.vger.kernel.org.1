Return-Path: <netdev+bounces-181181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BF4A84022
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 12:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 796029E196D
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 10:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6097627C16D;
	Thu, 10 Apr 2025 10:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U+ix+dtx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B758627C844
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 10:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744279305; cv=none; b=uSOciTE6FY9LtrRHCOUpZ/lc/jNADq2CsqR48Qx6wHetc9OmIvFr8mN06iMo+ROZ2EKRJd0fqaKMBogYO+cXypA/snoqx9iCNvHjN8+qqtJDW2vvX+fkSr1w2a/Z8KQmeuVq6ULjg2M1EaULq8Kr+EYzDrs9tHjseFspsNEMfzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744279305; c=relaxed/simple;
	bh=jAg/40in19GYDbgk6D3oK2wpbqw+hw8XtWQ4vs/PfYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aU0KonvcF12kjPCgZDZVVGMvokseZAfSQampE+TIItNx8ogj8fS06CBGhR607a0LKRpKXof6TFKkPWAiqJtfUCWRpBb7GiQ8sLX6dMAPbrN3rb4slsP717ycNp4gbkt2uiRAvKLfNi6RsBmtoTn05+nFRSK6c4ItJmkRVkeVIbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U+ix+dtx; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744279303; x=1775815303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jAg/40in19GYDbgk6D3oK2wpbqw+hw8XtWQ4vs/PfYY=;
  b=U+ix+dtx/XFRHdvrV2oDllwmI8NKwtEhX/rkxcu5UIuozUv32/fZ4l1+
   lTxlOI8ytsomNew6zD3iyN7mQHIY5ZBDUrRAOBD5VU7d1dCNkVHAnn7/u
   ozI1AWq7kyT/vdDznOue60VoUEHz1Vh7lehXaWawDFIr7BxxoXhk+BNLt
   lvdIxUrlFj/tGy+jZK3C87G3sYJzuPbvWSIp6F3+745v73An9loW1bbvC
   RymhNeCvwhgWSWQXmyWn1FXOBAtQHfiGSxqPBiCpaufqRvP0ns+keXwS1
   AaQ2k4Pb9U8bW4bF9fT9yB6kKPLVqbxyEvXO/OKJVo3uS9T+jX74dyc75
   Q==;
X-CSE-ConnectionGUID: wyLu90wqSNa9zHVPQ5BqpQ==
X-CSE-MsgGUID: 80vbgw8gR7Cbp6263/czEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="63183915"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="63183915"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 03:01:43 -0700
X-CSE-ConnectionGUID: WWsw2xqpQN+d66fN0Tch4g==
X-CSE-MsgGUID: HVfRDyItT+uOf3kO4uDuOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="159819801"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa001.fm.intel.com with ESMTP; 10 Apr 2025 03:01:41 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	aleksander.lobakin@intel.com,
	przemyslaw.kitszel@intel.com,
	piotr.kwapulinski@intel.com,
	aleksandr.loktionov@intel.com,
	jedrzej.jagielski@intel.com,
	larysa.zaremba@intel.com,
	anthony.l.nguyen@intel.com
Subject: [iwl-next v2 7/8] iavf: use libie_aq_str
Date: Thu, 10 Apr 2025 12:01:20 +0200
Message-ID: <20250410100121.2353754-8-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250410100121.2353754-1-michal.swiatkowski@linux.intel.com>
References: <20250410100121.2353754-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to store the err string in hw->err_str. Simplify it and
use common helper. hw->err_str is still used for other purpouse.

It should be marked that previously for unknown error the numeric value
was passed as a string. Now the "LIBIE_AQ_RC_UNKNOWN" is used for such
cases.

Add libie_aminq module in iavf Kconfig.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/Kconfig            |  1 +
 .../net/ethernet/intel/iavf/iavf_prototype.h  |  1 -
 drivers/net/ethernet/intel/iavf/iavf_common.c | 52 -------------------
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  5 +-
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  2 +-
 5 files changed, 5 insertions(+), 56 deletions(-)

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index d5de9bc8b1b6..29c03a9ce145 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -260,6 +260,7 @@ config I40E_DCB
 config IAVF
 	tristate
 	select LIBIE
+	select LIBIE_ADMINQ
 	select NET_SHAPER
 
 config I40EVF
diff --git a/drivers/net/ethernet/intel/iavf/iavf_prototype.h b/drivers/net/ethernet/intel/iavf/iavf_prototype.h
index 34b5ed87a9aa..7f9f9dbf959a 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_prototype.h
+++ b/drivers/net/ethernet/intel/iavf/iavf_prototype.h
@@ -34,7 +34,6 @@ void iavf_debug_aq(struct iavf_hw *hw, enum iavf_debug_mask mask,
 
 bool iavf_check_asq_alive(struct iavf_hw *hw);
 enum iavf_status iavf_aq_queue_shutdown(struct iavf_hw *hw, bool unloading);
-const char *iavf_aq_str(struct iavf_hw *hw, enum libie_aq_err aq_err);
 const char *iavf_stat_str(struct iavf_hw *hw, enum iavf_status stat_err);
 
 enum iavf_status iavf_aq_set_rss_lut(struct iavf_hw *hw, u16 seid,
diff --git a/drivers/net/ethernet/intel/iavf/iavf_common.c b/drivers/net/ethernet/intel/iavf/iavf_common.c
index cc71e48b5689..614a886bca99 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_common.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_common.c
@@ -7,58 +7,6 @@
 #include "iavf_adminq.h"
 #include "iavf_prototype.h"
 
-/**
- * iavf_aq_str - convert AQ err code to a string
- * @hw: pointer to the HW structure
- * @aq_err: the AQ error code to convert
- **/
-const char *iavf_aq_str(struct iavf_hw *hw, enum libie_aq_err aq_err)
-{
-	switch (aq_err) {
-	case LIBIE_AQ_RC_OK:
-		return "OK";
-	case LIBIE_AQ_RC_EPERM:
-		return "LIBIE_AQ_RC_EPERM";
-	case LIBIE_AQ_RC_ENOENT:
-		return "LIBIE_AQ_RC_ENOENT";
-	case LIBIE_AQ_RC_ESRCH:
-		return "LIBIE_AQ_RC_ESRCH";
-	case LIBIE_AQ_RC_EIO:
-		return "LIBIE_AQ_RC_EIO";
-	case LIBIE_AQ_RC_EAGAIN:
-		return "LIBIE_AQ_RC_EAGAIN";
-	case LIBIE_AQ_RC_ENOMEM:
-		return "LIBIE_AQ_RC_ENOMEM";
-	case LIBIE_AQ_RC_EACCES:
-		return "LIBIE_AQ_RC_EACCES";
-	case LIBIE_AQ_RC_EBUSY:
-		return "LIBIE_AQ_RC_EBUSY";
-	case LIBIE_AQ_RC_EEXIST:
-		return "LIBIE_AQ_RC_EEXIST";
-	case LIBIE_AQ_RC_EINVAL:
-		return "LIBIE_AQ_RC_EINVAL";
-	case LIBIE_AQ_RC_ENOSPC:
-		return "LIBIE_AQ_RC_ENOSPC";
-	case LIBIE_AQ_RC_ENOSYS:
-		return "LIBIE_AQ_RC_ENOSYS";
-	case LIBIE_AQ_RC_EMODE:
-		return "LIBIE_AQ_RC_EMODE";
-	case LIBIE_AQ_RC_ENOSEC:
-		return "LIBIE_AQ_RC_ENOSEC";
-	case LIBIE_AQ_RC_EBADSIG:
-		return "LIBIE_AQ_RC_EBADSIG";
-	case LIBIE_AQ_RC_ESVN:
-		return "LIBIE_AQ_RC_ESVN";
-	case LIBIE_AQ_RC_EBADMAN:
-		return "LIBIE_AQ_RC_EBADMAN";
-	case LIBIE_AQ_RC_EBADBUF:
-		return "LIBIE_AQ_RC_EBADBUF";
-	}
-
-	snprintf(hw->err_str, sizeof(hw->err_str), "%d", aq_err);
-	return hw->err_str;
-}
-
 /**
  * iavf_stat_str - convert status err code to a string
  * @hw: pointer to the HW structure
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 2c0bb41809a4..1b4a9a921d6c 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -50,6 +50,7 @@ MODULE_ALIAS("i40evf");
 MODULE_DESCRIPTION("Intel(R) Ethernet Adaptive Virtual Function Network Driver");
 MODULE_IMPORT_NS("LIBETH");
 MODULE_IMPORT_NS("LIBIE");
+MODULE_IMPORT_NS("LIBIE_ADMINQ");
 MODULE_LICENSE("GPL v2");
 
 static const struct net_device_ops iavf_netdev_ops;
@@ -1734,7 +1735,7 @@ static int iavf_config_rss_aq(struct iavf_adapter *adapter)
 	if (status) {
 		dev_err(&adapter->pdev->dev, "Cannot set RSS key, err %s aq_err %s\n",
 			iavf_stat_str(hw, status),
-			iavf_aq_str(hw, hw->aq.asq_last_status));
+			libie_aq_str(hw->aq.asq_last_status));
 		return iavf_status_to_errno(status);
 
 	}
@@ -1744,7 +1745,7 @@ static int iavf_config_rss_aq(struct iavf_adapter *adapter)
 	if (status) {
 		dev_err(&adapter->pdev->dev, "Cannot set RSS lut, err %s aq_err %s\n",
 			iavf_stat_str(hw, status),
-			iavf_aq_str(hw, hw->aq.asq_last_status));
+			libie_aq_str(hw->aq.asq_last_status));
 		return iavf_status_to_errno(status);
 	}
 
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index a6f0e5990be2..65340ba0b152 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -29,7 +29,7 @@ static int iavf_send_pf_msg(struct iavf_adapter *adapter,
 	if (status)
 		dev_dbg(&adapter->pdev->dev, "Unable to send opcode %d to PF, status %s, aq_err %s\n",
 			op, iavf_stat_str(hw, status),
-			iavf_aq_str(hw, hw->aq.asq_last_status));
+			libie_aq_str(hw->aq.asq_last_status));
 	return iavf_status_to_errno(status);
 }
 
-- 
2.42.0


