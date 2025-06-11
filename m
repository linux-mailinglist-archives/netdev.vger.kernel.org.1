Return-Path: <netdev+bounces-196470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77106AD4EB9
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 10:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E91317C41B
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 08:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE7523F41F;
	Wed, 11 Jun 2025 08:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lkFXsMSp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7785223C8CD
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 08:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749631579; cv=none; b=SM+My9MXuFO6ocFdGVvZ2vwDt8BuXX/+Xl3ViA2tuK/lBKQnYvUTrFoxUqUd0co1rb7LLBIKrSThVUiHscu4aIvnKoTn6Y+gCJrGnZ+3mopVFKegRG5mWNWvLOw+K8LdHxuIEEilg2WKJGUgDA9b6F9humtvqWZeGCb387TIknI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749631579; c=relaxed/simple;
	bh=6x6QL82OphoxZIikvvYXWnq+2WXRIS75JJh3r94rvgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tDV9b9cUkuqSTnJYigsCxZP79vSgYpgfCoZ2EEXAxQbNnQsFyz0C6p+s3kzk5XeNYpmy6UvbTgRmzkBzsjrBznGDkT9M5HghMzepLRvmKyNEKPo7qbM2+k2+zWlcPSUZR/xDEL8FqRZ4IT0Zh1g/ubid9N3pabLrNTCgdPekiaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lkFXsMSp; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749631578; x=1781167578;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6x6QL82OphoxZIikvvYXWnq+2WXRIS75JJh3r94rvgE=;
  b=lkFXsMSpQ4MAwjN7S0NM73BmMdi+Mosni5++d7ccXyeiDeE3GI451A1+
   qYHQL4H8EpjKkp9yuNocNuVval4xR4egCAKsKH9jEaEZGCRUBmhd/R1RS
   TKIaHT5qNBxANhYxJrNZDAeElANC71h2ZnjbM+Cp1Xm0/iAPhRDtz0tko
   SfXlo8y74RDTXSUEL3dwDAgVxB2Ccayg5syLPferJJQBm4sJ58LSMiwmo
   mot9F9WsfQTftCbsrhw3yv0hMq6hlEhQS2WEtPL8w2Hoxm5UGRyUtyW9V
   QXtmvE5PJNfdOMhR1yuUOORGqEcwjfcZpZ7GNIC7TKXWIZR/NEjT+9ehB
   A==;
X-CSE-ConnectionGUID: Rq8LR9UFQIy2ha6Ux9sX4A==
X-CSE-MsgGUID: xMZ8b62HR9qKD8DRWTWBzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="62046158"
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="62046158"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 01:46:17 -0700
X-CSE-ConnectionGUID: bTb/FLHOST6nd0bHeHumug==
X-CSE-MsgGUID: 3sHeCa0ERRqjoandVdG6KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,227,1744095600"; 
   d="scan'208";a="152298394"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa004.fm.intel.com with ESMTP; 11 Jun 2025 01:46:16 -0700
Received: from kord.igk.intel.com (kord.igk.intel.com [10.123.220.9])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 73C8B332AE;
	Wed, 11 Jun 2025 09:46:15 +0100 (IST)
From: Konrad Knitter <konrad.knitter@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Konrad Knitter <konrad.knitter@intel.com>
Subject: [PATCH iwl-next v1 3/3] ixgbe: add overwrite mask from factory settings
Date: Wed, 11 Jun 2025 11:01:22 +0200
Message-Id: <20250611090122.4312-4-konrad.knitter@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250611090122.4312-1-konrad.knitter@intel.com>
References: <20250611090122.4312-1-konrad.knitter@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support for restoring settings and identifiers from factory settings
instead of using those found in the image.

Restoring data from factory settings requires restoring both settings
and identifiers simultaneously. Other combinations are not supported.

Signed-off-by: Konrad Knitter <konrad.knitter@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_fw_update.c | 6 ++++++
 drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_fw_update.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_fw_update.c
index e5479fc07a07..6b46da369934 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_fw_update.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_fw_update.c
@@ -654,6 +654,12 @@ int ixgbe_flash_pldm_image(struct devlink *devlink,
 		/* overwrite both settings and identifiers, preserve nothing */
 		preservation = IXGBE_ACI_NVM_NO_PRESERVATION;
 		break;
+	case (DEVLINK_FLASH_OVERWRITE_SETTINGS |
+	     DEVLINK_FLASH_OVERWRITE_IDENTIFIERS |
+	     DEVLINK_FLASH_OVERWRITE_FROM_FACTORY_SETTINGS):
+		/* overwrite both settings and identifiers, from factory settings */
+		preservation = IXGBE_ACI_NVM_FACTORY_DEFAULT;
+		break;
 	default:
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Requested overwrite mask is not supported");
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
index d76334b8fbad..426bb2424620 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type_e610.h
@@ -691,6 +691,7 @@ struct ixgbe_aci_cmd_nvm {
 #define IXGBE_ACI_NVM_LAST_CMD		BIT(0)
 #define IXGBE_ACI_NVM_PCIR_REQ		BIT(0) /* Used by NVM Write reply */
 #define IXGBE_ACI_NVM_PRESERVE_ALL	BIT(1)
+#define IXGBE_ACI_NVM_FACTORY_DEFAULT	BIT(2)
 #define IXGBE_ACI_NVM_ACTIV_SEL_NVM	BIT(3) /* Write Activate/SR Dump only */
 #define IXGBE_ACI_NVM_ACTIV_SEL_OROM	BIT(4)
 #define IXGBE_ACI_NVM_ACTIV_SEL_NETLIST	BIT(5)
-- 
2.38.1


