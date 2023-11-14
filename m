Return-Path: <netdev+bounces-47790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4637EB639
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 19:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D044E1C20B9D
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 18:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D3E2FC2F;
	Tue, 14 Nov 2023 18:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BvKFlCTF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E7626AD9
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 18:15:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C33812F
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 10:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699985725; x=1731521725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D/Rkn5E5E4wRMYt5J+17xe5SsKRQ863fcKYjeEAc1y0=;
  b=BvKFlCTFz1V2Mb+E6oQK54e4/2MgAo1K30npvE9AagKGSCE0T0gXnep2
   oifn3kATXJLxcs/8r1qS/BfoUFJ1vHOrvsoww6UypQwDPIYn5K3BBjmCi
   h5W6S1prFhi0K9RXCm6s6qWa1UcAkF5srWuyac8jADgamCMmDRKjUmmxZ
   20vV4l1dB50lvo1bhki1XlGtndSgSc+UeuQbog67PEOzf5kKBZM0PQQFO
   aCSrdB3JdIXFc/0H5amLWwe+tooJ5BYhhqCVDBEv+hFW3I4/cDofjX7M4
   8LbRxvHAsIpF/DjUy2qqvblW7DS1ROBCXIbccLPshtT04O8JfwxcJm7/G
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390514516"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="390514516"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 10:15:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="741160958"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="741160958"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga006.jf.intel.com with ESMTP; 14 Nov 2023 10:15:02 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	wojciech.drewek@intel.com,
	marcin.szycik@intel.com,
	piotr.raczynski@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net-next 10/15] ice: allow changing SWITCHDEV_CTRL VSI queues
Date: Tue, 14 Nov 2023 10:14:30 -0800
Message-ID: <20231114181449.1290117-11-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231114181449.1290117-1-anthony.l.nguyen@intel.com>
References: <20231114181449.1290117-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Implement mechanism to change number of queues for SWITCHDEV_CTRL VSI
type.

Value from ::req_txq/rxq will be written to ::alloc_txq/rxq after
calling ice_vsi_rebuild().

Reviewed-by: Piotr Raczynski <piotr.raczynski@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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


