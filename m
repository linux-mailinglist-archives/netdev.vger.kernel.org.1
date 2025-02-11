Return-Path: <netdev+bounces-165236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D03A31349
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 18:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD1BF162A90
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 17:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181A338F80;
	Tue, 11 Feb 2025 17:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CZdv53lc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E30250C1F
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 17:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739295724; cv=none; b=UdFGjuXJknTLe2vrJC7Son8UBEQnGPZQ8fuS1ushVdHXvP4y5toDeWhtQ8IrguhQyDAaZrcOHyaqgRN4MasbiGLM+Cxz3sUJPC//JwgGZdkJoxN4DpjaLmyqIDLg+3QzX4LNm6MB6XUSznMG3n2swfXtYfzhXk7Ce5fT66EQ6To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739295724; c=relaxed/simple;
	bh=/dJ4iWZvn1XrPQb3ucobZGFq3U6bK1FwH53od8so46w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u0LNW8AL9D3w5H3cJTtYbrjtPAme9v/fDnm+FCHLLs5zC/QAip0VGoPHuxHHIqJ9iNBDuRSDFy6EduUszPDxH7tsKXSS0EayOuJprlYKK4dT3vID7dzonZDRWmCFw7/8oDQowhYRb1biR1lmJ5lUO11tDGuOkUP+XgQ/8gXD4o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CZdv53lc; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739295722; x=1770831722;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/dJ4iWZvn1XrPQb3ucobZGFq3U6bK1FwH53od8so46w=;
  b=CZdv53lcHG/+PKlL5gP23hUseuLEJM/ScthRgFjsQi0+vdBgq296H8QL
   sYWM2KsetkJxyEhKy2Lei9h9N86DQGtYyYKkC09zaiwfkXu4vo/VtqVMO
   i3v36ZNd6i4UTj3XRoS/4AG+MdK5bk+KwJX15B2mGiOSwp335T2Mb/doj
   A1PPcXrpU0R6XsVCdqFR8xpkO8Gb0NlyhCcowOWkVp4rhX6w3otaETjBE
   dY/S/1EFYck2QIuMvTpRTzBSciIUV9pCoqTCpt3Hvb0F+CArAmxvFjue5
   eSIOzvQNlfKpnRlID5GyhOuf5Ruf3B5c0A5RQP62Pu3BenxL5C8V+//j9
   g==;
X-CSE-ConnectionGUID: 2OcgXXzoTp+TVyFJFGBp+A==
X-CSE-MsgGUID: Lu80Jc0ETkO/zRjxqkpfEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="43855617"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="43855617"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 09:41:57 -0800
X-CSE-ConnectionGUID: B74FmaV7ROGjHOf0RGNfXQ==
X-CSE-MsgGUID: Yw46Zp9RSNqJV42cvRZ5lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="112538341"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa006.jf.intel.com with ESMTP; 11 Feb 2025 09:41:55 -0800
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 4E82932ECC;
	Tue, 11 Feb 2025 17:41:54 +0000 (GMT)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	michal.swiatkowski@linux.intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Subject: [PATCH iwl-net 1/2] ice: Fix deinitializing VF in error path
Date: Tue, 11 Feb 2025 18:43:21 +0100
Message-ID: <20250211174322.603652-1-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If ice_ena_vfs() fails after calling ice_create_vf_entries(), it frees
all VFs without removing them from snapshot PF-VF mailbox list, leading
to list corruption.

Reproducer:
  devlink dev eswitch set $PF1_PCI mode switchdev
  ip l s $PF1 up
  ip l s $PF1 promisc on
  sleep 1
  echo 1 > /sys/class/net/$PF1/device/sriov_numvfs
  sleep 1
  echo 1 > /sys/class/net/$PF1/device/sriov_numvfs

Trace (minimized):
  list_add corruption. next->prev should be prev (ffff8882e241c6f0), but was 0000000000000000. (next=ffff888455da1330).
  kernel BUG at lib/list_debug.c:29!
  RIP: 0010:__list_add_valid_or_report+0xa6/0x100
   ice_mbx_init_vf_info+0xa7/0x180 [ice]
   ice_initialize_vf_entry+0x1fa/0x250 [ice]
   ice_sriov_configure+0x8d7/0x1520 [ice]
   ? __percpu_ref_switch_mode+0x1b1/0x5d0
   ? __pfx_ice_sriov_configure+0x10/0x10 [ice]

Sometimes a KASAN report can be seen instead with a similar stack trace:
  BUG: KASAN: use-after-free in __list_add_valid_or_report+0xf1/0x100

VFs are added to this list in ice_mbx_init_vf_info(), but only removed
in ice_free_vfs(). Move the removing to ice_free_vf_entries(), which is
also being called in other places where VFs are being removed (including
ice_free_vfs() itself).

Fixes: 8cd8a6b17d27 ("ice: move VF overflow message count into struct ice_mbx_vf_info")
Reported-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Closes: https://lore.kernel.org/intel-wired-lan/PH0PR11MB50138B635F2E5CEB7075325D961F2@PH0PR11MB5013.namprd11.prod.outlook.com
Reviewed-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_sriov.c          | 5 +----
 drivers/net/ethernet/intel/ice/ice_vf_lib.c         | 8 ++++++++
 drivers/net/ethernet/intel/ice/ice_vf_lib_private.h | 1 +
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c b/drivers/net/ethernet/intel/ice/ice_sriov.c
index b83f99c01d91..8aabf7749aa5 100644
--- a/drivers/net/ethernet/intel/ice/ice_sriov.c
+++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
@@ -36,6 +36,7 @@ static void ice_free_vf_entries(struct ice_pf *pf)
 
 	hash_for_each_safe(vfs->table, bkt, tmp, vf, entry) {
 		hash_del_rcu(&vf->entry);
+		ice_deinitialize_vf_entry(vf);
 		ice_put_vf(vf);
 	}
 }
@@ -193,10 +194,6 @@ void ice_free_vfs(struct ice_pf *pf)
 			wr32(hw, GLGEN_VFLRSTAT(reg_idx), BIT(bit_idx));
 		}
 
-		/* clear malicious info since the VF is getting released */
-		if (!ice_is_feature_supported(pf, ICE_F_MBX_LIMIT))
-			list_del(&vf->mbx_info.list_entry);
-
 		mutex_unlock(&vf->cfg_lock);
 	}
 
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index c7c0c2f50c26..815ad0bfe832 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -1036,6 +1036,14 @@ void ice_initialize_vf_entry(struct ice_vf *vf)
 	mutex_init(&vf->cfg_lock);
 }
 
+void ice_deinitialize_vf_entry(struct ice_vf *vf)
+{
+	struct ice_pf *pf = vf->pf;
+
+	if (!ice_is_feature_supported(pf, ICE_F_MBX_LIMIT))
+		list_del(&vf->mbx_info.list_entry);
+}
+
 /**
  * ice_dis_vf_qs - Disable the VF queues
  * @vf: pointer to the VF structure
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib_private.h b/drivers/net/ethernet/intel/ice/ice_vf_lib_private.h
index 0c7e77c0a09f..5392b0404986 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib_private.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib_private.h
@@ -24,6 +24,7 @@
 #endif
 
 void ice_initialize_vf_entry(struct ice_vf *vf);
+void ice_deinitialize_vf_entry(struct ice_vf *vf);
 void ice_dis_vf_qs(struct ice_vf *vf);
 int ice_check_vf_init(struct ice_vf *vf);
 enum virtchnl_status_code ice_err_to_virt_err(int err);
-- 
2.45.0


