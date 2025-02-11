Return-Path: <netdev+bounces-165026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B93A3019E
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 03:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C24033A6B89
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 02:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E811BFE00;
	Tue, 11 Feb 2025 02:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ORLfukIz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60C41C3C1C
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 02:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739241684; cv=none; b=WtYbrRFmwUDQhrTE0zVdZYE8TdtNAn+Vnc2lDlJNKD0qYP6rYrMokbOb6ch+9duHW+nmPxNES50VkLBHxWmBFRIprskhhRR4ULigvqFXW69QjZ+cLNb36Q/rWeuW4m9MTLa3JaGN8nWwBf3TxOA7Tf5Bv6MczoZODbUq3EsIbYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739241684; c=relaxed/simple;
	bh=0I4trm11Zt0vOhZIkPvv8fZ+KaLcMHXs1mD4PkidyuQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=cwVOwLL25M3Wk5zNkdNQ0BJ+mEvaK5D54IfsOtTkKkl14M4i9b7U/bjATu3dWKYGcqexsMoXKGUmbgRhfIWvZO949gncmTh58cpOxXedMaMiRtO4iOJ9CdibJpmREuvTuETYPPL9GFpgBYaxImrIJc3QrU0DHd2j8KLW2b6ishc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ORLfukIz; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739241683; x=1770777683;
  h=from:to:cc:subject:date:message-id;
  bh=0I4trm11Zt0vOhZIkPvv8fZ+KaLcMHXs1mD4PkidyuQ=;
  b=ORLfukIzBb7n8DBrwvwwiuV/NOTI8VayxdAe7p7y9q9DHG+dgZbmwjaD
   2MgILKBOOUZEv1IYarsM2hm6T3BzH8bJXGCcqWcIv5mhWNZ74ua2D7Z1S
   3pBkURHMG3avH/6ipRwjgqyWwyMV0IZkZb2MDSRiiqGz1JncON3c89H+A
   nHnxl+iV9tEFMJf4zNbk6gNrSCmeNLTLlIin4ioPHfx9mXKGtdxssHipm
   EvqTRdMZFItDtYRIe+eWHuHZnnCdfjbURLWCf0osjV6wgcwZywrdTcdzW
   TaRxgJDJXze1udKFyST77fYPelTOA1lYAb6lCAOx7miq70IiqfMcfpM/t
   w==;
X-CSE-ConnectionGUID: vIIk0EyWRZyWVMd4XehYGw==
X-CSE-MsgGUID: uGDb7SXQTnCmXFL/Hc+N7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="50483861"
X-IronPort-AV: E=Sophos;i="6.13,276,1732608000"; 
   d="scan'208";a="50483861"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 18:41:21 -0800
X-CSE-ConnectionGUID: CLmtrMOVRZ+N5emmFzHgXQ==
X-CSE-MsgGUID: QlUJ7qYUT2eLFpUKHpID0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="135635057"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by fmviesa002.fm.intel.com with ESMTP; 10 Feb 2025 18:41:20 -0800
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	decot@google.com,
	willemb@google.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	madhu.chittim@intel.com
Subject: [PATCH iwl-net] idpf: check error for register_netdev() on init
Date: Mon, 10 Feb 2025 18:38:51 -0800
Message-Id: <20250211023851.21090-1-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Current init logic ignores the error code from register_netdev(),
which will cause WARN_ON() on attempt to unregister it, if there was one,
and there is no info for the user that the creation of the netdev failed.

WARNING: CPU: 89 PID: 6902 at net/core/dev.c:11512 unregister_netdevice_many_notify+0x211/0x1a10
...
[ 3707.563641]  unregister_netdev+0x1c/0x30
[ 3707.563656]  idpf_vport_dealloc+0x5cf/0xce0 [idpf]
[ 3707.563684]  idpf_deinit_task+0xef/0x160 [idpf]
[ 3707.563712]  idpf_vc_core_deinit+0x84/0x320 [idpf]
[ 3707.563739]  idpf_remove+0xbf/0x780 [idpf]
[ 3707.563769]  pci_device_remove+0xab/0x1e0
[ 3707.563786]  device_release_driver_internal+0x371/0x530
[ 3707.563803]  driver_detach+0xbf/0x180
[ 3707.563816]  bus_remove_driver+0x11b/0x2a0
[ 3707.563829]  pci_unregister_driver+0x2a/0x250

Introduce an error check and log the vport number and error code.
On removal make sure to check VPORT_REG_NETDEV flag prior to calling
unregister and free on the netdev.

Add local variables for idx, vport_config and netdev for readability.

Fixes: 0fe45467a104 ("idpf: add create vport and netdev configuration")
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
Suggested-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 27 ++++++++++++++--------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index a3d6b8f198a8..a322a8ac771e 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -927,15 +927,19 @@ static int idpf_stop(struct net_device *netdev)
 static void idpf_decfg_netdev(struct idpf_vport *vport)
 {
 	struct idpf_adapter *adapter = vport->adapter;
+	u16 idx = vport->idx;
 
 	kfree(vport->rx_ptype_lkup);
 	vport->rx_ptype_lkup = NULL;
 
-	unregister_netdev(vport->netdev);
-	free_netdev(vport->netdev);
+	if (test_and_clear_bit(IDPF_VPORT_REG_NETDEV,
+			       adapter->vport_config[idx]->flags)) {
+		unregister_netdev(vport->netdev);
+		free_netdev(vport->netdev);
+	}
 	vport->netdev = NULL;
 
-	adapter->netdevs[vport->idx] = NULL;
+	adapter->netdevs[idx] = NULL;
 }
 
 /**
@@ -1536,12 +1540,17 @@ void idpf_init_task(struct work_struct *work)
 	}
 
 	for (index = 0; index < adapter->max_vports; index++) {
-		if (adapter->netdevs[index] &&
-		    !test_bit(IDPF_VPORT_REG_NETDEV,
-			      adapter->vport_config[index]->flags)) {
-			register_netdev(adapter->netdevs[index]);
-			set_bit(IDPF_VPORT_REG_NETDEV,
-				adapter->vport_config[index]->flags);
+		struct idpf_vport_config *vport_config = adapter->vport_config[index];
+		struct net_device *netdev = adapter->netdevs[index];
+
+		if (netdev && !test_bit(IDPF_VPORT_REG_NETDEV, vport_config->flags)) {
+			err = register_netdev(netdev);
+			if (err) {
+				dev_err(&pdev->dev, "failed to register netdev for vport %d: %pe\n",
+					index, ERR_PTR(err));
+				continue;
+			}
+			set_bit(IDPF_VPORT_REG_NETDEV, vport_config->flags);
 		}
 	}
 
-- 
2.17.2


