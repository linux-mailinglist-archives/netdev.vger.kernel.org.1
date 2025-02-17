Return-Path: <netdev+bounces-166947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B59A38030
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 11:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C46188D4F6
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 10:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F130D2165E3;
	Mon, 17 Feb 2025 10:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b9D9do1h"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4115D217648
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788122; cv=none; b=sYj9hT9NzS9RtSHh4QxXRr2P7X6ljd7vug+LBwReLNAZjTBDQiYSIqQ8CFL1L4hAMIyxR/gtbwSJqzYauEsflMgbEw5zGFUgyR2ytpCNkXTxoCcw6OwW0XwTPJcAVFBEBc7T4EpK15+tdwt7KKxsU/JcnUe/K3/ZNle6XeX/2qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788122; c=relaxed/simple;
	bh=o883OfTm68rDA6RHHWWy73WfvDjr1+zc/EcXXU3GS3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DzAdUrFMqEC4Q5Or0Rtk0F2iqUKLxUaH9cuF4O+a10cZ0GgW0Egl4xJ1UO2zdb2rR4wFwzpkG9eZ0wP0TODQFrqOd+tKqvMhI4sxy7FCIXXMeKZvBwcASHS8JgzYuSHtdxgTZvE2lm7iGVy6KqabRb3jURTGAgxnKihKIAzILss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b9D9do1h; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739788121; x=1771324121;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o883OfTm68rDA6RHHWWy73WfvDjr1+zc/EcXXU3GS3w=;
  b=b9D9do1hfeoB5A1iLE+/xV7Yelw9q3OY/MU8VEOELGvk/BUX6DMlLBxZ
   260bPn01O3mue10z9rQbG4BvqD2f4C4qriBNq6pQI1FkqTMhaj1iYIU9i
   mLixivn1ql3iHYDAhRiMBOcIJCnTPIFpGnlvtc/DG4p/lm8gDRgxLU/jb
   NZIRLg+eUvtBZqpcPkud42MVWY5OZsz3Wbpb22tklFV+T87o89Hx6nj1h
   nIKoEx+Y5wLdOx9bSfbRqQwKgxfnH0idmcxss55UabtTrvn6EQaHK6bVY
   bHgRLxxmyCBzeaRTis0yk+cbIh/j4yWmlZ9vJ34oYbGc7NJ9nF9HD++Ju
   Q==;
X-CSE-ConnectionGUID: Hpbmzr2fQJ6A1zCrzXD0fA==
X-CSE-MsgGUID: fpse3GA9Q9qNvMQIUztgiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11347"; a="40168410"
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="40168410"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 02:28:39 -0800
X-CSE-ConnectionGUID: EOgKHumnRAKbWTkaD3+A7w==
X-CSE-MsgGUID: T3A0wCpsT1W9DzKwclcX1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,292,1732608000"; 
   d="scan'208";a="114598267"
Received: from enterprise.igk.intel.com ([10.102.20.175])
  by fmviesa010.fm.intel.com with ESMTP; 17 Feb 2025 02:28:37 -0800
From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jan Glaza <jan.glaza@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Subject: [iwl-net 2/4] ice: stop truncating queue ids when checking
Date: Mon, 17 Feb 2025 11:27:45 +0100
Message-ID: <20250217102744.300357-6-martyna.szapar-mudlaw@linux.intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250217102744.300357-2-martyna.szapar-mudlaw@linux.intel.com>
References: <20250217102744.300357-2-martyna.szapar-mudlaw@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Glaza <jan.glaza@intel.com>

Queue IDs can be up to 4096, update invalid check
to stop truncating IDs to 8 bits.

Fixes: bf93bf791cec8 ("ice: introduce ice_virtchnl.c and ice_virtchnl.h")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Jan Glaza <jan.glaza@intel.com>
Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index b6285433307c..343f2b4b0dc5 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -565,7 +565,7 @@ bool ice_vc_isvalid_vsi_id(struct ice_vf *vf, u16 vsi_id)
  *
  * check for the valid queue ID
  */
-static bool ice_vc_isvalid_q_id(struct ice_vsi *vsi, u8 qid)
+static bool ice_vc_isvalid_q_id(struct ice_vsi *vsi, u16 qid)
 {
 	/* allocated Tx and Rx queues should be always equal for VF VSI */
 	return qid < vsi->alloc_txq;
-- 
2.47.0


