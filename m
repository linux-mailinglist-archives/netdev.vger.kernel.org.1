Return-Path: <netdev+bounces-169164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2502A42C50
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 20:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97284188FF2A
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 19:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CB31EA7F4;
	Mon, 24 Feb 2025 19:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W6WiYiWy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4521EA7FA
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 19:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740424018; cv=none; b=O2NeSH0ZXy12jQfub9hiEKLc15Oq1i3ZEd5TvJR774as+IGRG5GztUwT2AXJoDAiFYz4QvEMUIvW1nmdP82bEqi6aswHts06AV027NSV04jaWEmxv9s6bfRAkIytO1rLQnrCVUCTlsd69LWOK3f1Y2DYshzGe7wgu8p7hgOu7rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740424018; c=relaxed/simple;
	bh=5oi5eWMS/VxfQDViWUUaWJURI+rH8oMwrGvNj8xckZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JkkxGOnIaWUh5BBeMFlmfEE9Xf6Gh6yHBYbyNBh+XvcihVYg/QREpJFhuB1CxuSDYZJBJYnHs9ZXCMDKQms6GINNOrCXBkvR1ihhfMi1O0ZAWAOmAuwIElT+0IvpqF4juLeJxBSfBUYq0nOK7BEztFQAkfCoCkJvUMxqzfqIBOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W6WiYiWy; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740424016; x=1771960016;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5oi5eWMS/VxfQDViWUUaWJURI+rH8oMwrGvNj8xckZk=;
  b=W6WiYiWyCB2sqziafNP5EjHCD0i/CD7d2VBwjjmxtAgd8JQOY+q2zsvK
   D0NpHI5EdcfoZFzy4Uhx0efCpqPL4svaJRpEJsyTjsCVscGIMQ7ZpwqCc
   IbSuGvs9Jw3VYa4d1AXzWPekPCu+o6xq0ynSsaX/3xwBzdodZfDufSUhJ
   eEJdOZDX6R+dv77HP9SLsdi7W/5xDC2K/G7SlNpPUCtL8RP2Wvb7lLykD
   Df6feoEm1LEY+rSUWelyyglwG9SvbgKabAl/FXMGPdApEPhT4W0aaXLDF
   ktWmUo25WbYJDG6lmCOESCMvoD8C4sXFy2L+sK0nL+OopMSbYaBxADKs1
   w==;
X-CSE-ConnectionGUID: xfKUVpY9QE2nwdb0+7wVkA==
X-CSE-MsgGUID: eEceMJIYTJiPrJ15O3WNHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="58614189"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="58614189"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 11:06:54 -0800
X-CSE-ConnectionGUID: LiCucU4jR7Kv99uOIfABAw==
X-CSE-MsgGUID: m1xA0oDwTlCY/ScD7uPdJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="153358456"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 24 Feb 2025 11:06:53 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Marcin Szycik <marcin.szycik@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net 1/5] ice: Fix deinitializing VF in error path
Date: Mon, 24 Feb 2025 11:06:41 -0800
Message-ID: <20250224190647.3601930-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250224190647.3601930-1-anthony.l.nguyen@intel.com>
References: <20250224190647.3601930-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marcin Szycik <marcin.szycik@linux.intel.com>

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
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
2.47.1


