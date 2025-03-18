Return-Path: <netdev+bounces-175881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8574FA67DAB
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 21:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E9653B62CA
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 20:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D32A212FB1;
	Tue, 18 Mar 2025 20:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IteYFDFT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DBD1EB5CC
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 20:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742328324; cv=none; b=r87+LmFT2XgLkHDEhGAF8pB7q72fgzgGrvJr4a8uVWQYMM8jc7Cc4cU0CXjhUkOPs3vIj53UIft/IKaz37Dnd+Z8KSJq0RV2FzYlY8bHR18nJXQHCvqIGysEXqPFCXNJPDWHZbPSWn59Hy+6hnvW8fycrNLJQOwD0JAXvmIu2LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742328324; c=relaxed/simple;
	bh=LQ3jlFn5IMM1Awz4zvpFlXKmE1yu8eUwg73WfX3ZTEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D93Mm+u8Ynnczmt0RNsDWytktmwD5x6y7knFqqNDBKkxML9kv2KzLNv48ZMSXn4MQyniW62GtxkRyXtvxjtQZ8maA/lRUgBmKsuLMKg6P4+csZlCYX2MYL0pvHpr1OKP0KeRiwVbS+xI/EWerQXsa5CMhGIARR1Sk4SqBkmZkss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IteYFDFT; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742328323; x=1773864323;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LQ3jlFn5IMM1Awz4zvpFlXKmE1yu8eUwg73WfX3ZTEU=;
  b=IteYFDFTZVKmMX3E90OrxYfwO62ZJ7gtTJOMGvuoaim4urw4ouDmOL07
   C4+QL5+RHL0PXVgCY0pd0eB/4Oka2z+nIAi1BO/JQTYoBRvCKsmW7Wh4Z
   G9LFH3n8PFovlnfVOdubEyCtDRB4JKOQ7dWbl00Ie/DeZkl2s5BK0ixC6
   uBMpRnDaEPL/R7B50n3slPImz59kLPG83fODCWULiHy/OQZGNIHUsFPJi
   1nwIQK4AoM9L8cnC8mZ0deNLw+ONnBvPW39AFi+6NAhihat19Yrsc/rl+
   wm9xQ80R7MNaiIrgRRso79ne3yWq54tokHBBFCM+ztP2fC4tDC07DePMF
   Q==;
X-CSE-ConnectionGUID: LS6/wUA7TeCStgxM+kLG4A==
X-CSE-MsgGUID: 87I/QNtWTgGqyHKz5f40wQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43593026"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="43593026"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 13:05:20 -0700
X-CSE-ConnectionGUID: uiW6y5ZmRQSQJx8K+n5hCA==
X-CSE-MsgGUID: gHewBR69QdCO+pyxtHZ5zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="153363132"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 18 Mar 2025 13:05:19 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jesse Brandeburg <jbrandeburg@cloudflare.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	kernel-team@cloudflare.com,
	leon@kernel.org,
	Dave Ertman <david.m.ertman@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 3/9] ice: fix reservation of resources for RDMA when disabled
Date: Tue, 18 Mar 2025 13:04:47 -0700
Message-ID: <20250318200511.2958251-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250318200511.2958251-1-anthony.l.nguyen@intel.com>
References: <20250318200511.2958251-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jesse Brandeburg <jbrandeburg@cloudflare.com>

If the CONFIG_INFINIBAND_IRDMA symbol is not enabled as a module or a
built-in, then don't let the driver reserve resources for RDMA. The result
of this change is a large savings in resources for older kernels, and a
cleaner driver configuration for the IRDMA=n case for old and new kernels.

Implement this by avoiding enabling the RDMA capability when scanning
hardware capabilities.

Note: Loading the out-of-tree irdma driver in connection to the in-kernel
ice driver, is not supported, and should not be attempted, especially when
disabling IRDMA in the kernel config.

Fixes: d25a0fc41c1f ("ice: Initialize RDMA support")
Signed-off-by: Jesse Brandeburg <jbrandeburg@cloudflare.com>
Acked-by: Dave Ertman <david.m.ertman@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 7a2a2e8da8fa..1e801300310e 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -2271,7 +2271,8 @@ ice_parse_common_caps(struct ice_hw *hw, struct ice_hw_common_caps *caps,
 			  caps->nvm_unified_update);
 		break;
 	case ICE_AQC_CAPS_RDMA:
-		caps->rdma = (number == 1);
+		if (IS_ENABLED(CONFIG_INFINIBAND_IRDMA))
+			caps->rdma = (number == 1);
 		ice_debug(hw, ICE_DBG_INIT, "%s: rdma = %d\n", prefix, caps->rdma);
 		break;
 	case ICE_AQC_CAPS_MAX_MTU:
-- 
2.47.1


