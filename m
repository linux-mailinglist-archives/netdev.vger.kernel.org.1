Return-Path: <netdev+bounces-77283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC68F8711C8
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 01:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43C45B21AC5
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 00:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3A32F5A;
	Tue,  5 Mar 2024 00:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GXJHMweG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F2D7F
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 00:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709599065; cv=none; b=bjTiDIM7mneDB2rZW3NIFvgN/EydJW8IJBEUXkTy0QyvWoIgQ2EsIvd/IPV3O7penhxUjblprEMgVhZux+iiFhfCT+6VGvtf5P5ejkGoFIoLygYOqfP0ExvflJW8Nn8ZhRI7jNFnITK8B2B7btIweoCMtuAwvapDFrm0+SvjT8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709599065; c=relaxed/simple;
	bh=K9bkpzmDfx9tgWYMV1JZSyt1aawAzwpzvfo0ToK8RTc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pA6Q+nx/L5JdJxIWGnXzBwfpPaRHzeGdWgfbdkZh3xBbZFAqsHD2QPOKaZyI8509H8I4sRAQFwgzum0MV7xNtLfvxls0OQhfEFhdWiAzOaCBQIXjx17Y4ZWenwyiDmpCyrpM7KrQWGyJzQiCd1/FFNMuBirs5RWPfaEeryi+4yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GXJHMweG; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709599063; x=1741135063;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=K9bkpzmDfx9tgWYMV1JZSyt1aawAzwpzvfo0ToK8RTc=;
  b=GXJHMweGC14smh319VPX2+AYRH3Hrs5n+3K+G041PI2+992BOpPK5NEk
   fB8G1z72k4tX40EwHF3KuDm/hok2aCr8iW8WAEXNyAy+2wqzHxy4EaJbl
   1/n6b96v3kHzOCCnrruH3TdbhE0FjRVhi2w9YN4Y2y0qegmjyof6E7AOX
   TEnn+4Ahy6m7JuR8QIc40Q+pStUD+QFloHe6395szBmSo3T8V558Egv72
   bHQnxsPvrRF6FJNVQoHjgeHkQ2mjpitKEHtYs2W8vgPhZsyIXF5zdIVX6
   WoMx96f9D/ap+xTHjcK/KjmF4vQZ3pZIS5OKeOZp+69I3whT7QFlAo98E
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="14768001"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="14768001"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 16:37:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="9769970"
Received: from jbrandeb-coyote30.jf.intel.com ([10.166.29.19])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 16:37:42 -0800
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: [PATCH iwl-net v1] ice: fix typo in assignment
Date: Mon,  4 Mar 2024 16:37:07 -0800
Message-Id: <20240305003707.55507-1-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix an obviously incorrect assignment, created with a typo or cut-n-paste
error.

Fixes: 5995ef88e3a8 ("ice: realloc VSI stats arrays")
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 097bf8fd6bf0..fc23dbe302b4 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -3192,7 +3192,7 @@ ice_vsi_realloc_stat_arrays(struct ice_vsi *vsi)
 		}
 	}
 
-	tx_ring_stats = vsi_stat->rx_ring_stats;
+	tx_ring_stats = vsi_stat->tx_ring_stats;
 	vsi_stat->tx_ring_stats =
 		krealloc_array(vsi_stat->tx_ring_stats, req_txq,
 			       sizeof(*vsi_stat->tx_ring_stats),

base-commit: 948abb59ebd3892c425165efd8fb2f5954db8de7
-- 
2.39.3


