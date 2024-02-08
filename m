Return-Path: <netdev+bounces-70347-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE6D84E741
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 19:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D5EE1F25603
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 18:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F487EF0C;
	Thu,  8 Feb 2024 18:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lsZzz4uH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D78B823D3
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 18:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707415423; cv=none; b=RAxHiLI9kuX6MYbVC2s4p5RHJJ6sdUgF3kqqShJEBdYKeEOLJrR0TDrJ03RGxsT4C+3nr869SXkEg2z82s1lCFM/S2FQxEhMySOjWwsyOPcr45KdHBn4vf0UUQGNGLdBlRfldTTWS05ywiv2w7D43giDN6XMU3N4HBfz1lFqYq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707415423; c=relaxed/simple;
	bh=VgB9GBN+vGw6/CetNX+8Z/FzuZNNsFcSdiSoEJ4ci+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SS6IrLTY9CJXig35FOuYDhQmzMl/O4QvXfmlCRjmGc3yOOOIGPCEhQeOiX4xI8Kx9jIxHDwK/NykSFoGxVAw+1QGzWcIVtGlQKWyXYjebNjMS29BYHBJ4U6Gf00j3M13h38hRNYGWFlT6SGcy9yw0ioROzdWa5RFPHOgULKMSAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lsZzz4uH; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707415421; x=1738951421;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VgB9GBN+vGw6/CetNX+8Z/FzuZNNsFcSdiSoEJ4ci+k=;
  b=lsZzz4uHnhuzYZAdhqn/0c1BRdLdlrjAJPgNUxccYkvMTkVwmvZhgedk
   MJSeI0INDvPN7m7G31yrUSwb1u7vUD5PcpKdKbh0bq/hmOdl1T/tVjzqX
   PTdd2maOoP+IigKH+vzV4VbNQVnT4JJ+amkgK4rCSUQ+m97xZ5MQfgh1W
   beBHpi/4bJg5OphA6ajcMoEXz5vvHUC3C3MEVqP9swYM5l3BzyaS9xp0C
   pKqI5CgQOMhErfiBtE51n1obDxZtEbTN4Q427dHFKggOfbKpZFCCSl5pg
   ISTDfdHEY/2mZkvqEK1KsBdMYcoTsRbkv9tPbHC5qc5nyiaubf5/k0Kfk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="395695634"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="395695634"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:03:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="24951333"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa002.fm.intel.com with ESMTP; 08 Feb 2024 10:03:40 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>,
	anthony.l.nguyen@intel.com,
	Simon Horman <horms@kernel.org>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net] i40e: Do not allow untrusted VF to remove administratively set MAC
Date: Thu,  8 Feb 2024 10:03:33 -0800
Message-ID: <20240208180335.1844996-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ivan Vecera <ivecera@redhat.com>

Currently when PF administratively sets VF's MAC address and the VF
is put down (VF tries to delete all MACs) then the MAC is removed
from MAC filters and primary VF MAC is zeroed.

Do not allow untrusted VF to remove primary MAC when it was set
administratively by PF.

Reproducer:
1) Create VF
2) Set VF interface up
3) Administratively set the VF's MAC
4) Put VF interface down

[root@host ~]# echo 1 > /sys/class/net/enp2s0f0/device/sriov_numvfs
[root@host ~]# ip link set enp2s0f0v0 up
[root@host ~]# ip link set enp2s0f0 vf 0 mac fe:6c:b5:da:c7:7d
[root@host ~]# ip link show enp2s0f0
23: enp2s0f0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
    link/ether 3c:ec:ef:b7:dd:04 brd ff:ff:ff:ff:ff:ff
    vf 0     link/ether fe:6c:b5:da:c7:7d brd ff:ff:ff:ff:ff:ff, spoof checking on, link-state auto, trust off
[root@host ~]# ip link set enp2s0f0v0 down
[root@host ~]# ip link show enp2s0f0
23: enp2s0f0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
    link/ether 3c:ec:ef:b7:dd:04 brd ff:ff:ff:ff:ff:ff
    vf 0     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff, spoof checking on, link-state auto, trust off

Fixes: 700bbf6c1f9e ("i40e: allow VF to remove any MAC filter")
Fixes: ceb29474bbbc ("i40e: Add support for VF to specify its primary MAC address")
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 38 ++++++++++++++++---
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 908cdbd3ec5d..b34c71770887 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2848,6 +2848,24 @@ static int i40e_vc_get_stats_msg(struct i40e_vf *vf, u8 *msg)
 				      (u8 *)&stats, sizeof(stats));
 }
 
+/**
+ * i40e_can_vf_change_mac
+ * @vf: pointer to the VF info
+ *
+ * Return true if the VF is allowed to change its MAC filters, false otherwise
+ */
+static bool i40e_can_vf_change_mac(struct i40e_vf *vf)
+{
+	/* If the VF MAC address has been set administratively (via the
+	 * ndo_set_vf_mac command), then deny permission to the VF to
+	 * add/delete unicast MAC addresses, unless the VF is trusted
+	 */
+	if (vf->pf_set_mac && !vf->trusted)
+		return false;
+
+	return true;
+}
+
 #define I40E_MAX_MACVLAN_PER_HW 3072
 #define I40E_MAX_MACVLAN_PER_PF(num_ports) (I40E_MAX_MACVLAN_PER_HW /	\
 	(num_ports))
@@ -2907,8 +2925,8 @@ static inline int i40e_check_vf_permission(struct i40e_vf *vf,
 		 * The VF may request to set the MAC address filter already
 		 * assigned to it so do not return an error in that case.
 		 */
-		if (!test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps) &&
-		    !is_multicast_ether_addr(addr) && vf->pf_set_mac &&
+		if (!i40e_can_vf_change_mac(vf) &&
+		    !is_multicast_ether_addr(addr) &&
 		    !ether_addr_equal(addr, vf->default_lan_addr.addr)) {
 			dev_err(&pf->pdev->dev,
 				"VF attempting to override administratively set MAC address, bring down and up the VF interface to resume normal operation\n");
@@ -3114,19 +3132,29 @@ static int i40e_vc_del_mac_addr_msg(struct i40e_vf *vf, u8 *msg)
 			ret = -EINVAL;
 			goto error_param;
 		}
-		if (ether_addr_equal(al->list[i].addr, vf->default_lan_addr.addr))
-			was_unimac_deleted = true;
 	}
 	vsi = pf->vsi[vf->lan_vsi_idx];
 
 	spin_lock_bh(&vsi->mac_filter_hash_lock);
 	/* delete addresses from the list */
-	for (i = 0; i < al->num_elements; i++)
+	for (i = 0; i < al->num_elements; i++) {
+		const u8 *addr = al->list[i].addr;
+
+		/* Allow to delete VF primary MAC only if it was not set
+		 * administratively by PF or if VF is trusted.
+		 */
+		if (ether_addr_equal(addr, vf->default_lan_addr.addr) &&
+		    i40e_can_vf_change_mac(vf))
+			was_unimac_deleted = true;
+		else
+			continue;
+
 		if (i40e_del_mac_filter(vsi, al->list[i].addr)) {
 			ret = -EINVAL;
 			spin_unlock_bh(&vsi->mac_filter_hash_lock);
 			goto error_param;
 		}
+	}
 
 	spin_unlock_bh(&vsi->mac_filter_hash_lock);
 
-- 
2.41.0


