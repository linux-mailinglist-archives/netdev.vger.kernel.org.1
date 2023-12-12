Return-Path: <netdev+bounces-56309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F9A80E7AA
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 10:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95A801C20832
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 09:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26182584EE;
	Tue, 12 Dec 2023 09:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fPaeF1co"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF3110B
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 01:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702373483; x=1733909483;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pjVxK9NlNyYS/SGjXdIPXAjSQ6EE+9PYePXN+hhqSxc=;
  b=fPaeF1cocMt1+DnLDkKbRXJSdPqSrHhYaFed83oceUm8a6/riQceRF7g
   ndehnIrjHpz/ICcogfj4F+JgDhn/5Cy1lLAjNMTimUlZ2Yu9OSOXySjns
   Oe9IvVeLH2QI/zj83lJ6i3j0G4YYxo8ECne3DG95Jb8/MKcA+H6wHfutJ
   Rak0H7bJ2vECONkp42Da2vxwQgp9TE32ceoOokQSOa2SCBIi2shePnW+W
   /RR4CeW6AJLTodUki7QbT6lb8URFSWIBquExKItREM9M1y6gj2CpwtHem
   6MH1kCA0N0ACUAfStvDks+e2El/BiBUsjfA4JCT5cVJSjszeUNlZGv4sx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="374284919"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="374284919"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 01:31:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="749645546"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="749645546"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orsmga006.jf.intel.com with ESMTP; 12 Dec 2023 01:31:18 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 153E533EA3;
	Tue, 12 Dec 2023 09:31:17 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Larysa Zaremba <larysa.zaremba@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	netdev@vger.kernel.org,
	jesse.brandeburg@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net] ice: Fix PF with enabled XDP going no-carrier after reset
Date: Tue, 12 Dec 2023 10:29:01 +0100
Message-ID: <20231212092903.446491-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 6624e780a577fc596788 ("ice: split ice_vsi_setup into smaller
functions") has refactored a bunch of code involved in PFR. In this
process, TC queue number adjustment for XDP was lost. Bring it back.

Lack of such adjustment causes interface to go into no-carrier after a
reset, if XDP program is attached, with the following message:

ice 0000:b1:00.0: Failed to set LAN Tx queue context, error: -22
ice 0000:b1:00.0 ens801f0np0: Failed to open VSI 0x0006 on switch 0x0001
ice 0000:b1:00.0: enable VSI failed, err -22, VSI index 0, type ICE_VSI_PF
ice 0000:b1:00.0: PF VSI rebuild failed: -22
ice 0000:b1:00.0: Rebuild failed, unload and reload driver

Fixes: 6624e780a577 ("ice: split ice_vsi_setup into smaller functions")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_lib.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 626577c7d5b2..2b6ac37ae0b3 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -2376,6 +2376,9 @@ static int ice_vsi_cfg_tc_lan(struct ice_pf *pf, struct ice_vsi *vsi)
 		} else {
 			max_txqs[i] = vsi->alloc_txq;
 		}
+
+		if (vsi->type == ICE_VSI_PF)
+			max_txqs[i] += vsi->num_xdp_txq;
 	}
 
 	dev_dbg(dev, "vsi->tc_cfg.ena_tc = %d\n", vsi->tc_cfg.ena_tc);
-- 
2.41.0


