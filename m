Return-Path: <netdev+bounces-129256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED30297E846
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 11:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B91D1C20434
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 09:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB29E1946BC;
	Mon, 23 Sep 2024 09:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Krp4m8mh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933351946B9
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 09:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727082744; cv=none; b=FiXH/E+WE/WZfXaKNNgF6u2O1iTVFqAlZrSBYPhRdiTrsKl7XWkURUVwY8My0uOKdN6AISgGw5odpy3O4IiFFM9Si5Y176jjVwpTJNljWyEz8Sw6utlInPtNFzewLmPP1L7OoTA1fAKSqhtJgTl0LL7FiN5DDB5qii2VtMFgTAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727082744; c=relaxed/simple;
	bh=UatYCZokIAfgyIA3l+1UFywBBqhiRuO04TIbEcM4L7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qtpuQdz9whljxLNU/Q9qH4CGrcC8fHKSYNPInzirLujuwe8fpz2/F98gZwJnHnCFfbOD7H9Q8bky16T5TfGTgZ41gc9GqMd+Fqy1p/208UuFKWPhsVKmoXUV8QSHUuwXnJQGhTKxuBeZQx/v4CdZPBW3b/hPs6nLamFTS1Q3KvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Krp4m8mh; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727082743; x=1758618743;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UatYCZokIAfgyIA3l+1UFywBBqhiRuO04TIbEcM4L7Q=;
  b=Krp4m8mhREIrkxG/fKWNvFf6411R3L/oJ+F1IqNSGaf9weAJeGY7sa3w
   jxrGAHKbaOD5VrmA4gY4R0jac9fAeUtsdb8cHyKfuSwvi7YQxh2NSwds9
   3AarEirWezObsfg2RC4eDoDP3bBev422xMEdJiB9xdbu+q5ekf3K9Khyk
   D98wcsc7qQ2HeIQATR77rFg3hvaVwyEhuAfGAsd0jeNyCKmO5Bmni+fgj
   zhAdriTP+6Cm8+mdkRREmyYmOC6V3V2UaFHmwusiIvlFD1ke+a2r9wMaf
   Q5jm3bGja4Gdu4DtdVImJ9QTP0+1CnoG5CfduQYsYVxwplrIO2vBWywKo
   w==;
X-CSE-ConnectionGUID: lhLHCauFR9yFVekJ/1WSRg==
X-CSE-MsgGUID: 4+65mS1URBuT9sof5xBDZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="36591248"
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="36591248"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 02:12:22 -0700
X-CSE-ConnectionGUID: jog8e2WsRxGUtwgBIdJiAQ==
X-CSE-MsgGUID: IJQEDUgnSr2iuEN5CT3lMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="101856976"
Received: from unknown (HELO amlin-019-225.igk.intel.com) ([10.102.19.225])
  by fmviesa001.fm.intel.com with ESMTP; 23 Sep 2024 02:12:20 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH iwl-net v1] i40e: Fix macvlan leak by synchronizing access to mac_filter_hash
Date: Mon, 23 Sep 2024 11:12:19 +0200
Message-Id: <20240923091219.3040651-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch addresses a macvlan leak issue in the i40e driver caused by
concurrent access to vsi->mac_filter_hash. The leak occurs when multiple
threads attempt to modify the mac_filter_hash simultaneously, leading to
inconsistent state and potential memory leaks.

To fix this, we now wrap the calls to i40e_del_mac_filter() and zeroing
vf->default_lan_addr.addr with spin_lock/unlock_bh(&vsi->mac_filter_hash_lock),
ensuring atomic operations and preventing concurrent access.

Additionally, we add lockdep_assert_held(&vsi->mac_filter_hash_lock) in
i40e_add_mac_filter() to help catch similar issues in the future.

Reproduction steps:
1. Spawn VFs and configure port vlan on them.
2. Trigger concurrent macvlan operations (e.g., adding and deleting
	portvlan and/or mac filters).
3. Observe the potential memory leak and inconsistent state in the
	mac_filter_hash.

This synchronization ensures the integrity of the mac_filter_hash and prevents
the described leak.

Fixes: fed0d9f13266 ("i40e: Fix VF's MAC Address change on VM")
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c        | 1 +
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 03205eb..25295ae 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1734,6 +1734,7 @@ struct i40e_mac_filter *i40e_add_mac_filter(struct i40e_vsi *vsi,
 	struct hlist_node *h;
 	int bkt;
 
+	lockdep_assert_held(&vsi->mac_filter_hash_lock);
 	if (vsi->info.pvid)
 		return i40e_add_filter(vsi, macaddr,
 				       le16_to_cpu(vsi->info.pvid));
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 662622f..dfa785e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2213,8 +2213,10 @@ static int i40e_vc_get_vf_resources_msg(struct i40e_vf *vf, u8 *msg)
 		vfres->vsi_res[0].qset_handle
 					  = le16_to_cpu(vsi->info.qs_handle[0]);
 		if (!(vf->driver_caps & VIRTCHNL_VF_OFFLOAD_USO) && !vf->pf_set_mac) {
+			spin_lock_bh(&vsi->mac_filter_hash_lock);
 			i40e_del_mac_filter(vsi, vf->default_lan_addr.addr);
 			eth_zero_addr(vf->default_lan_addr.addr);
+			spin_unlock_bh(&vsi->mac_filter_hash_lock);
 		}
 		ether_addr_copy(vfres->vsi_res[0].default_mac_addr,
 				vf->default_lan_addr.addr);
-- 
2.25.1


