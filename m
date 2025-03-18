Return-Path: <netdev+bounces-175883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C15AA67DB1
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 21:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF48D19C7CA2
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 20:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB82F2139A2;
	Tue, 18 Mar 2025 20:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WtFiZgu1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411EF212F98
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 20:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742328325; cv=none; b=Lj3Bzf5/SlthP2QbBQW+QhtsQv7sMhaGxZjef3V36/AnmhjeR769DndO3zpVaTjWNSgmlGxJ0RCeiHUkbsV//fDArofhDLcB9j2Efi4zr05CQ0tNBlQ5MI/opF6o2LOp+fV6KVX1qYQmMKS1LkquLF9xuAHsJKXJaNxZxoTHSrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742328325; c=relaxed/simple;
	bh=PjBx/l71FMUid7XFJ8z+egNc3YEaqeIkqY9zLKseRPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nb8ZT/EIYYvQtUfUxglqfsrqGpn9xpHLM2RSo6brhfNvvjyD6Zeomkea0+KLu7nVNnKyXoxZgUVzZh0ZJH+hSi2weMPLqK/N6OZnzy/wGa321hvreRHivyBwHzz1QywHID/NRluCj4ZJjqZDUXnYsbE1YvAiaKliIruKkOJVYwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WtFiZgu1; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742328325; x=1773864325;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PjBx/l71FMUid7XFJ8z+egNc3YEaqeIkqY9zLKseRPI=;
  b=WtFiZgu1yTu80gKlfv+CkQSo1k7b4hEtYZHDCpCOlSN1D2mZxyG/hKLV
   //N2MrLVfPmPwd6Rv8cwSH3QT4DDR+TIS7AwvmdHP9NZOTMvk6or5LGdZ
   EpvqaVDx2EKrmeomx4fQXrq/cWuk/zx0bXhcHemOa6YeZoWfQI5VeE/IR
   iNTrgKxMkf89Rx2gIOQemHQXyl/IqPsjcqNvWvsPjslPx6sqynTvMoLLS
   wgyRJJPWIrVHtLndwN+eUeuhzAHrsIvLc4L0GhbVIeYk2uq1mSuH7qqck
   2G7y4l6UKUpZ28vpEimuLUrl9TdQdSQyZKxbpi4caBl+rZHQpg8KsAJQI
   g==;
X-CSE-ConnectionGUID: mOmGxxNmSAWva0W4XSWYvw==
X-CSE-MsgGUID: rLGfMAacTQC33BxhsA5cvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43593046"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="43593046"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 13:05:21 -0700
X-CSE-ConnectionGUID: 4K3tOHz+TRGAE99JwKpOoA==
X-CSE-MsgGUID: 9gpZhmfqQUWdHCo4yLRB1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="153363147"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 18 Mar 2025 13:05:20 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jan Glaza <jan.glaza@intel.com>,
	anthony.l.nguyen@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 5/9] ice: stop truncating queue ids when checking
Date: Tue, 18 Mar 2025 13:04:49 -0700
Message-ID: <20250318200511.2958251-6-anthony.l.nguyen@intel.com>
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

From: Jan Glaza <jan.glaza@intel.com>

Queue IDs can be up to 4096, fix invalid check to stop
truncating IDs to 8 bits.

Fixes: bf93bf791cec8 ("ice: introduce ice_virtchnl.c and ice_virtchnl.h")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Jan Glaza <jan.glaza@intel.com>
Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index ff4ad788d96a..346aee373ccd 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -562,7 +562,7 @@ bool ice_vc_isvalid_vsi_id(struct ice_vf *vf, u16 vsi_id)
  *
  * check for the valid queue ID
  */
-static bool ice_vc_isvalid_q_id(struct ice_vsi *vsi, u8 qid)
+static bool ice_vc_isvalid_q_id(struct ice_vsi *vsi, u16 qid)
 {
 	/* allocated Tx and Rx queues should be always equal for VF VSI */
 	return qid < vsi->alloc_txq;
-- 
2.47.1


