Return-Path: <netdev+bounces-43829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DACAB7D4EEF
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 13:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35C72B20F9E
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 11:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC32262BA;
	Tue, 24 Oct 2023 11:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WJ4DGqZQ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67B726E14
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 11:35:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301DA128
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 04:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698147304; x=1729683304;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3bhAqaROnfOK6CfL0o9BQvxvGocbUJeZ7jqOkT9I820=;
  b=WJ4DGqZQTnbmHqY00dy+wSN+5luofcfwoINyOcbGB0F0nX6u3cusV2YZ
   aqCDrEyBRibyOCHKDp/S0uy43Y+5pHJPdoTU3iuII3yBQllwMONQCBgm/
   k7ElTsHiGrFpQX+dZ3KdDyFSlgmWSz6eeNkVVSOqASBJlSOMs8wfh82vx
   mL9jjR0UcKng1lCPF0t3Z/ig50jX+Z+SsPjRtCgfSBZVYn1bTeqJCjZ5j
   eYTSoTYpv6DKfDW31Xf9VFKqqp7lOapo6BjrA2La0zGak3PB4draSexQA
   a3G2hzOtPi8i5ARUQh5XyEfW50Xtp3EzZ6Ah9JvwoIHHtjQSpiP60WuDv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="5660554"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="5660554"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 04:35:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="6146177"
Received: from wasp.igk.intel.com ([10.102.20.192])
  by orviesa001.jf.intel.com with ESMTP; 24 Oct 2023 04:33:44 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	piotr.raczynski@intel.com,
	wojciech.drewek@intel.com,
	marcin.szycik@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	jesse.brandeburg@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-next v1 10/15] ice: allow changing SWITCHDEV_CTRL VSI queues
Date: Tue, 24 Oct 2023 13:09:24 +0200
Message-ID: <20231024110929.19423-11-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024110929.19423-1-michal.swiatkowski@linux.intel.com>
References: <20231024110929.19423-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement mechanism to change number of queues for SWITCHDEV_CTRL VSI
type.

Value from ::req_txq/rxq will be written to ::alloc_txq/rxq after
calling ice_vsi_rebuild().

Reviewed-by: Piotr Raczynski <piotr.raczynski@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index ae4b4220e1bb..85a8cb28a489 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -212,11 +212,18 @@ static void ice_vsi_set_num_qs(struct ice_vsi *vsi)
 						 vsi->alloc_txq));
 		break;
 	case ICE_VSI_SWITCHDEV_CTRL:
-		/* The number of queues for ctrl VSI is equal to number of VFs.
+		/* The number of queues for ctrl VSI is equal to number of PRs
 		 * Each ring is associated to the corresponding VF_PR netdev.
+		 * Tx and Rx rings are always equal
 		 */
-		vsi->alloc_txq = ice_get_num_vfs(pf);
-		vsi->alloc_rxq = vsi->alloc_txq;
+		if (vsi->req_txq && vsi->req_rxq) {
+			vsi->alloc_txq = vsi->req_txq;
+			vsi->alloc_rxq = vsi->req_rxq;
+		} else {
+			vsi->alloc_txq = 1;
+			vsi->alloc_rxq = 1;
+		}
+
 		vsi->num_q_vectors = 1;
 		break;
 	case ICE_VSI_VF:
-- 
2.41.0


