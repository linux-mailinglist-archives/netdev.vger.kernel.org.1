Return-Path: <netdev+bounces-209841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E22B110E7
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 20:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B5697BB21D
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 18:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4305A2ED178;
	Thu, 24 Jul 2025 18:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vh3VmMkl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4402ED14C
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 18:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753381726; cv=none; b=LmFv7M8KXpOwht+XP4GxWib9x2uVwQqBCyANVi2Zs17498Zd9CbXv7am+4GcRpPeZZicIkbmlXZ3q8dBxFv1TmQ+81d++KB25ytxIy6gf+l8PPCktskWnzELAHmlHuhKxHyJv5tOrcVAd3HeFDCfcjXRhbiSMYnIqK/N+OSquCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753381726; c=relaxed/simple;
	bh=jL2zXc1przACZVfHvvd1qK9c6HGhbI7yLjbIbwKLLhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nO+HKe/bZNWtU7v+JLFQdo0w8viVFCXC/7p6UyeySNMBj3WqjjU5ucwi2xrgWCIfOuIvEYcYBg5zxHa1n5YSyC1891P+BqrfvFNofG5JMHMrM6UVA2cDsX3iQ4Zao7rBeTdc3m4elfm3ORKU9xsdXt9ONMqaKToNm7RpO11ghRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vh3VmMkl; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753381725; x=1784917725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jL2zXc1przACZVfHvvd1qK9c6HGhbI7yLjbIbwKLLhs=;
  b=Vh3VmMkln5gpNkh2TgvsHIGGnsQokuACjLYItWjZPm8ceX3zs90eTRj+
   fzySNmSYgvQGtDadEDPpe4DvgTviGfj59knQziOCsPfDpR087HAp0cFvT
   ZlbEsd35HnA4NjJRoYj30rJyfPgjwcTXM4DqK/50ZNpLpCnLuvS2ShK+8
   hTPDh759+ipa2dseD5eU6zaybNCKbIOPh2NiToSP+Ow05P5KYBI0WkxjD
   XrkxpcUSYn5uDz8plKNgc64vwfYz9GAnPaWQsIlecUeqJpP2Bjm++e6mb
   NPV7y8eNmCKX+DlU/p4f5CghivCt4TKJpNR7Y9ez3QrUGGU4jEyb9o/PB
   Q==;
X-CSE-ConnectionGUID: UZIVxCs8TYGqyA6hz97dhg==
X-CSE-MsgGUID: 6PVaekN5RSCFU8oxwieGow==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55861398"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="55861398"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 11:28:39 -0700
X-CSE-ConnectionGUID: FWABk7sQRLy6Z82lVbe52g==
X-CSE-MsgGUID: ZXHyX2zJTleljkn9KkDhww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="161096510"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 24 Jul 2025 11:28:38 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	aleksander.lobakin@intel.com,
	przemyslaw.kitszel@intel.com,
	piotr.kwapulinski@intel.com,
	aleksandr.loktionov@intel.com,
	jedrzej.jagielski@intel.com,
	larysa.zaremba@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next 7/8] iavf: use libie_aq_str
Date: Thu, 24 Jul 2025 11:28:23 -0700
Message-ID: <20250724182826.3758850-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250724182826.3758850-1-anthony.l.nguyen@intel.com>
References: <20250724182826.3758850-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

There is no need to store the err string in hw->err_str. Simplify it and
use common helper. hw->err_str is still used for other purpouse.

It should be marked that previously for unknown error the numeric value
was passed as a string. Now the "LIBIE_AQ_RC_UNKNOWN" is used for such
cases.

Add libie_aminq module in iavf Kconfig.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/Kconfig            |  1 +
 drivers/net/ethernet/intel/iavf/iavf_common.c | 52 -------------------
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  5 +-
 .../net/ethernet/intel/iavf/iavf_prototype.h  |  1 -
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
index c859a096de9f..69054af4689a 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -50,6 +50,7 @@ MODULE_ALIAS("i40evf");
 MODULE_DESCRIPTION("Intel(R) Ethernet Adaptive Virtual Function Network Driver");
 MODULE_IMPORT_NS("LIBETH");
 MODULE_IMPORT_NS("LIBIE");
+MODULE_IMPORT_NS("LIBIE_ADMINQ");
 MODULE_LICENSE("GPL v2");
 
 static const struct net_device_ops iavf_netdev_ops;
@@ -1694,7 +1695,7 @@ static int iavf_config_rss_aq(struct iavf_adapter *adapter)
 	if (status) {
 		dev_err(&adapter->pdev->dev, "Cannot set RSS key, err %s aq_err %s\n",
 			iavf_stat_str(hw, status),
-			iavf_aq_str(hw, hw->aq.asq_last_status));
+			libie_aq_str(hw->aq.asq_last_status));
 		return iavf_status_to_errno(status);
 
 	}
@@ -1704,7 +1705,7 @@ static int iavf_config_rss_aq(struct iavf_adapter *adapter)
 	if (status) {
 		dev_err(&adapter->pdev->dev, "Cannot set RSS lut, err %s aq_err %s\n",
 			iavf_stat_str(hw, status),
-			iavf_aq_str(hw, hw->aq.asq_last_status));
+			libie_aq_str(hw->aq.asq_last_status));
 		return iavf_status_to_errno(status);
 	}
 
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
diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index 31a4289fc0ee..34a422a4a29c 100644
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
2.47.1


