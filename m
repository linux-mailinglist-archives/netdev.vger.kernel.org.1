Return-Path: <netdev+bounces-239746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEC2C6C0E2
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 00:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16DE44E91B4
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 23:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1613C3115B0;
	Tue, 18 Nov 2025 23:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IvZKE8yl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9A12DCF4C
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 23:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763509940; cv=none; b=DAzW8EU3m3NsUaVrj229nJJCwbHCph8LgvbBkZ/Ei5WnkxYqioLVp+AQ0N/APugAQbINGCtaM/81EdEwEmNVPr0CP4yzB8b3k+qEyEGWq6/W9mwpbK0nq0amDyFpxX7wmtVJYdDvfkkv6iZr4SXqYu3ydiHhnHfCUGAM8lXAElg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763509940; c=relaxed/simple;
	bh=m4IThHDfkFGB9v1gh7HOGbHHsG0y9DxsqL4UFLapvxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZp4lkzfDztPeAOqYPb8+bTQ5UxeF581y9faJObIontY0LDmWp9Z4oAle8Hg1WidW889+MrRZ1XaETbvX9qcm8UvBFZyOwy6gtFNC8+Lwo3ZMNyft16bEBItuywvPACPb3ZSTfMFfWeEPe+Az679J2/LaRZSPGVx1orjOyuvy4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IvZKE8yl; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763509939; x=1795045939;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m4IThHDfkFGB9v1gh7HOGbHHsG0y9DxsqL4UFLapvxw=;
  b=IvZKE8yl2GXzzPiwQBkoJFo+qvU6MgyHtRoBrXjR4YPDYKyDPMOca6VJ
   HdcDe0hLf2nZwaKuwx434hM3Pl+3QHe/oQBvwBrwC8rVb0MrOPXyzQePz
   oB12au0lNdZGScruFNDvHj7TVwh6jOjUvDPHumAR8B1+NCXs4WYRIbfgN
   NUgIlwdlYZX5exyET7Cyq+D3Y0Nu3wU0IUfDtn9bNv76J2eE32AIlL3Sp
   HmE5gVzs7qYsQD4RoG/T5NdmLRdNW6IJENTf5pZKcGVLsWiUkdu5mkp4w
   qd8fsO+buujNERqRkFoRCLU7lPO+FTdZLqINfT14+0lIVHTedT25K44tn
   g==;
X-CSE-ConnectionGUID: zUHPeBunSJqktVgarUEiJA==
X-CSE-MsgGUID: ons1oHNXSjKAv1rnoD+uMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76225835"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="76225835"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 15:52:16 -0800
X-CSE-ConnectionGUID: HYrWdMa8S/yq+FNUZPpcAw==
X-CSE-MsgGUID: WsaRhgnlT0SymAVi1sVOiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="190699492"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 18 Nov 2025 15:52:16 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Emil Tantilov <emil.s.tantilov@intel.com>,
	anthony.l.nguyen@intel.com,
	joshua.a.hay@intel.com,
	willemb@google.com,
	horms@kernel.org,
	decot@google.com,
	Chittim Madhu <madhu.chittim@intel.com>,
	Samuel Salin <Samuel.salin@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net 1/2] idpf: fix possible vport_config NULL pointer deref in remove
Date: Tue, 18 Nov 2025 15:52:04 -0800
Message-ID: <20251118235207.2165495-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251118235207.2165495-1-anthony.l.nguyen@intel.com>
References: <20251118235207.2165495-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Tantilov <emil.s.tantilov@intel.com>

Attempting to remove the driver will cause a crash in cases where
the vport failed to initialize. Following trace is from an instance where
the driver failed during an attempt to create a VF:
[ 1661.543624] idpf 0000:84:00.7: Device HW Reset initiated
[ 1722.923726] idpf 0000:84:00.7: Transaction timed-out (op:1 cookie:2900 vc_op:1 salt:29 timeout:60000ms)
[ 1723.353263] BUG: kernel NULL pointer dereference, address: 0000000000000028
...
[ 1723.358472] RIP: 0010:idpf_remove+0x11c/0x200 [idpf]
...
[ 1723.364973] Call Trace:
[ 1723.365475]  <TASK>
[ 1723.365972]  pci_device_remove+0x42/0xb0
[ 1723.366481]  device_release_driver_internal+0x1a9/0x210
[ 1723.366987]  pci_stop_bus_device+0x6d/0x90
[ 1723.367488]  pci_stop_and_remove_bus_device+0x12/0x20
[ 1723.367971]  pci_iov_remove_virtfn+0xbd/0x120
[ 1723.368309]  sriov_disable+0x34/0xe0
[ 1723.368643]  idpf_sriov_configure+0x58/0x140 [idpf]
[ 1723.368982]  sriov_numvfs_store+0xda/0x1c0

Avoid the NULL pointer dereference by adding NULL pointer check for
vport_config[i], before freeing user_config.q_coalesce.

Fixes: e1e3fec3e34b ("idpf: preserve coalescing settings across resets")
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Chittim Madhu <madhu.chittim@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 8c46481d2e1f..8cf4ff697572 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -63,6 +63,8 @@ static void idpf_remove(struct pci_dev *pdev)
 	destroy_workqueue(adapter->vc_event_wq);
 
 	for (i = 0; i < adapter->max_vports; i++) {
+		if (!adapter->vport_config[i])
+			continue;
 		kfree(adapter->vport_config[i]->user_config.q_coalesce);
 		kfree(adapter->vport_config[i]);
 		adapter->vport_config[i] = NULL;
-- 
2.47.1


