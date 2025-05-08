Return-Path: <netdev+bounces-189064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D10DAB033D
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 20:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFB3D177517
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 18:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDBF2147F7;
	Thu,  8 May 2025 18:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CDaCOs7+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308842E659
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 18:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746730306; cv=none; b=Vq86F5dALYJtpsZ9aZygwIoqeejch+FbUj0cr5Fnnc8RVFdxd6wVDYzg6Bc6jHsho0aipuPqYM/lyc4H9vDhfguW1Os2+ZNpYjaQf7Y5KJq3sWqCVWPrR20odI257KXAeO0LSguB1g2SeOi2ZdApc0u6umVMnXz3GSfbOFY7txY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746730306; c=relaxed/simple;
	bh=0P1kq5V6Zl3XktHtUGDpPFQfVJIbRRJmT3vCTi9aT3Q=;
	h=From:To:Cc:Subject:Date:Message-Id; b=oQ/3NFveU5usa3ZjiXvX1nMlc7KAmvUvJ6KPg09lSV+4j6koRVILZ3XBc1e4if6C7TX1JLfXpBrNegyCzwdh4ABQuqxNLF4eB4x9n+wqsxiKkR6I3qd5u1RWI+/Hu8Rh2a1dMcZXz6BWYIsE2Mf1VHjbOvaOohfcn3A1arDmDUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CDaCOs7+; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746730305; x=1778266305;
  h=from:to:cc:subject:date:message-id;
  bh=0P1kq5V6Zl3XktHtUGDpPFQfVJIbRRJmT3vCTi9aT3Q=;
  b=CDaCOs7+Ne7D1QLpkrOZ7xtlb6EPg+HKNyOqB2RF5SZeIyjba7ai5hM1
   oHrSdZEImtmIgH6Kew2JHhXzQJL5GdHaAJom1CJWpdsqB6GJsz1y0rYw/
   okGBrcCzrEbIeDOR7JKpH3OnDTpze8+JM8cM21kfEj2c1VGiIZhlWAuxY
   AXuIyvKUYsnFQniXecV88UOjdSYLoeKrbyLocElCMGX6qDQgGFEm5jka8
   f8FJLG5swTHvjJBRrxroX05TZzBYm+EAnRDlnd7C54NuhkNWrvVpvgVzs
   Wfa1tkamiY5kWgf7V5eCwVm2eZbzDdtKBz+nKJGruS2PfxtbdCeVuahw7
   A==;
X-CSE-ConnectionGUID: cqEODU6vQae5deSe+CSXAw==
X-CSE-MsgGUID: fEIvHXqsSxe+sRdNNbi28g==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="52347338"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="52347338"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 11:51:44 -0700
X-CSE-ConnectionGUID: wOnEvQiaQaWmw2RaUmXskQ==
X-CSE-MsgGUID: hyVbqnEaSmurri8NKVJlTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,273,1739865600"; 
   d="scan'208";a="136095187"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by orviesa009.jf.intel.com with ESMTP; 08 May 2025 11:51:43 -0700
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
	madhu.chittim@intel.com,
	Aleksandr.Loktionov@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	joshua.a.hay@intel.com,
	ahmed.zaki@intel.com
Subject: [PATCH iwl-net] idpf: avoid mailbox timeout delays during reset
Date: Thu,  8 May 2025 11:47:15 -0700
Message-Id: <20250508184715.7631-1-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

Mailbox operations are not possible while the driver is in reset.
Operations that require MBX exchange with the control plane will result
in long delays if executed while a reset is in progress:

ethtool -L <inf> combined 8& echo 1 > /sys/class/net/<inf>/device/reset
idpf 0000:83:00.0: HW reset detected
idpf 0000:83:00.0: Device HW Reset initiated
idpf 0000:83:00.0: Transaction timed-out (op:504 cookie:be00 vc_op:504 salt:be timeout:2000ms)
idpf 0000:83:00.0: Transaction timed-out (op:508 cookie:bf00 vc_op:508 salt:bf timeout:2000ms)
idpf 0000:83:00.0: Transaction timed-out (op:512 cookie:c000 vc_op:512 salt:c0 timeout:2000ms)
idpf 0000:83:00.0: Transaction timed-out (op:510 cookie:c100 vc_op:510 salt:c1 timeout:2000ms)
idpf 0000:83:00.0: Transaction timed-out (op:509 cookie:c200 vc_op:509 salt:c2 timeout:60000ms)
idpf 0000:83:00.0: Transaction timed-out (op:509 cookie:c300 vc_op:509 salt:c3 timeout:60000ms)
idpf 0000:83:00.0: Transaction timed-out (op:505 cookie:c400 vc_op:505 salt:c4 timeout:60000ms)
idpf 0000:83:00.0: Failed to configure queues for vport 0, -62

Disable mailbox communication in case of a reset, unless it's done during
a driver load, where the virtchnl operations are needed to configure the
device.

Fixes: 8077c727561aa ("idpf: add controlq init and reset checks")
Co-developed-by: Joshua Hay <joshua.a.hay@intel.com>
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c     | 18 +++++++++++++-----
 .../net/ethernet/intel/idpf/idpf_virtchnl.c    |  2 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.h    |  1 +
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 3a033ce19cda..2ed801398971 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1816,11 +1816,19 @@ void idpf_vc_event_task(struct work_struct *work)
 	if (test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
 		return;
 
-	if (test_bit(IDPF_HR_FUNC_RESET, adapter->flags) ||
-	    test_bit(IDPF_HR_DRV_LOAD, adapter->flags)) {
-		set_bit(IDPF_HR_RESET_IN_PROG, adapter->flags);
-		idpf_init_hard_reset(adapter);
-	}
+	if (test_bit(IDPF_HR_FUNC_RESET, adapter->flags))
+		goto func_reset;
+
+	if (test_bit(IDPF_HR_DRV_LOAD, adapter->flags))
+		goto drv_load;
+
+	return;
+
+func_reset:
+	idpf_vc_xn_shutdown(adapter->vcxn_mngr);
+drv_load:
+	set_bit(IDPF_HR_RESET_IN_PROG, adapter->flags);
+	idpf_init_hard_reset(adapter);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 3d2413b8684f..5d2ca007f682 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -376,7 +376,7 @@ static void idpf_vc_xn_init(struct idpf_vc_xn_manager *vcxn_mngr)
  * All waiting threads will be woken-up and their transaction aborted. Further
  * operations on that object will fail.
  */
-static void idpf_vc_xn_shutdown(struct idpf_vc_xn_manager *vcxn_mngr)
+void idpf_vc_xn_shutdown(struct idpf_vc_xn_manager *vcxn_mngr)
 {
 	int i;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
index 83da5d8da56b..23271cf0a216 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -66,5 +66,6 @@ int idpf_send_get_stats_msg(struct idpf_vport *vport);
 int idpf_send_set_sriov_vfs_msg(struct idpf_adapter *adapter, u16 num_vfs);
 int idpf_send_get_set_rss_key_msg(struct idpf_vport *vport, bool get);
 int idpf_send_get_set_rss_lut_msg(struct idpf_vport *vport, bool get);
+void idpf_vc_xn_shutdown(struct idpf_vc_xn_manager *vcxn_mngr);
 
 #endif /* _IDPF_VIRTCHNL_H_ */
-- 
2.17.2


