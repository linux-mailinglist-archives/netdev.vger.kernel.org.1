Return-Path: <netdev+bounces-213865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3253B272C4
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 01:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 467CF7B5F87
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 23:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649662877FA;
	Thu, 14 Aug 2025 23:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qnlv8V70"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD10C2877C6
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 23:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212948; cv=none; b=M3bWkePZ3DNPG7RdCngDsRzRdZIpKFaXeHMgASe5B0cRNZLQ2sglw5KSnz7+4hZyL3JFZIXOUHK8XPiI8BJTMZRbsyIy8z0JqN0N3ZNh7kGuEKcpSu9h7lR96GlbU1fItxOsMTqs6cdsWRyEI2EUFQ+t8uLfNatd5dj3BYNkgzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212948; c=relaxed/simple;
	bh=JQi0feW18XeNDr+ta9NI5lFi3lu2ss9DYruyoXJj2VU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1V6Cpf4Jy7rqkw6JsD1hB5sZfgw71diC57+Rk9R1vOB2IyeFB7hYllXnB6r4BhRVVu1btZ6emqdGatr2rQji510mQgLI9Oh0+jumMrs5Ff6EejU82ttpNw6a4lxa/CqV3uCUV38j0y5AIUzGqgbnTumJOLoa+WapnNiQB+hbEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qnlv8V70; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755212947; x=1786748947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JQi0feW18XeNDr+ta9NI5lFi3lu2ss9DYruyoXJj2VU=;
  b=Qnlv8V70pRDnk0cB7XP8LPq2QqqgkwE3Lgr3Oz5d/iOIwUhP/em1nJHy
   RF1PKFmnHKp76vvqTAnNwf3yx5VcwVRCb4uetsywIoINQN9/iUw7chpqL
   zKn/UknsPg5sirtUgswG/MV8p7Ie+HB+PzVzbxVqkSyouuTgA6hQQhFiR
   HLNNNlSBmWvFXRquwW9ehIro56u8FBhIq/gp1e7BKc6cNiN56AqlHcbkW
   ZugX3sYwOD8nm1aJv86PdjOiVhrSn42QGWG1Hbs4QS1xMYbR6N/NZ/jOM
   VqHJKkNkHR3GJMbdENbz4TPeg+hUre3pPUFPKmrbIr/jSFzsXRsaO5lMp
   Q==;
X-CSE-ConnectionGUID: oaGeMXktQfaDzbQpuGTjWg==
X-CSE-MsgGUID: lrRaWRQfSRGUnxarnT/qIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="45117967"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="45117967"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 16:09:04 -0700
X-CSE-ConnectionGUID: d0qNlFfHSlaiVfjx4+kuPQ==
X-CSE-MsgGUID: A5k8CkpCQc6qMINTB51lSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="166848128"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 14 Aug 2025 16:09:04 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Dave Ertman <david.m.ertman@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 2/7] ice: replace u8 elements with bool where appropriate
Date: Thu, 14 Aug 2025 16:08:49 -0700
Message-ID: <20250814230855.128068-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250814230855.128068-1-anthony.l.nguyen@intel.com>
References: <20250814230855.128068-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Ertman <david.m.ertman@intel.com>

In preparation for the new LAG functionality implementation, there are
a couple of existing LAG elements of the capabilities struct that should
be bool instead of u8.  Since we are adding a new element to this struct
that should also be a bool, fix the existing LAG u8 in this patch and
eliminate !! operators where possible.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 4 ++--
 drivers/net/ethernet/intel/ice/ice_type.h   | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 003d60a4db21..209f42045fea 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2418,10 +2418,10 @@ ice_parse_common_caps(struct ice_hw *hw, struct ice_hw_common_caps *caps,
 			  caps->reset_restrict_support);
 		break;
 	case LIBIE_AQC_CAPS_FW_LAG_SUPPORT:
-		caps->roce_lag = !!(number & LIBIE_AQC_BIT_ROCEV2_LAG);
+		caps->roce_lag = number & LIBIE_AQC_BIT_ROCEV2_LAG;
 		ice_debug(hw, ICE_DBG_INIT, "%s: roce_lag = %u\n",
 			  prefix, caps->roce_lag);
-		caps->sriov_lag = !!(number & LIBIE_AQC_BIT_SRIOV_LAG);
+		caps->sriov_lag = number & LIBIE_AQC_BIT_SRIOV_LAG;
 		ice_debug(hw, ICE_DBG_INIT, "%s: sriov_lag = %u\n",
 			  prefix, caps->sriov_lag);
 		break;
diff --git a/drivers/net/ethernet/intel/ice/ice_type.h b/drivers/net/ethernet/intel/ice/ice_type.h
index 03c6c271865d..2b07d5e48847 100644
--- a/drivers/net/ethernet/intel/ice/ice_type.h
+++ b/drivers/net/ethernet/intel/ice/ice_type.h
@@ -293,8 +293,9 @@ struct ice_hw_common_caps {
 	u8 dcb;
 	u8 ieee_1588;
 	u8 rdma;
-	u8 roce_lag;
-	u8 sriov_lag;
+
+	bool roce_lag;
+	bool sriov_lag;
 
 	bool nvm_update_pending_nvm;
 	bool nvm_update_pending_orom;
-- 
2.47.1


