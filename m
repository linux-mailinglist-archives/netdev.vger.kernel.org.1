Return-Path: <netdev+bounces-194430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 186FEAC96EB
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 23:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614EE1C0317D
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 21:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1D2283FCA;
	Fri, 30 May 2025 21:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lO2XG1b2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF602836A3
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 21:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748639551; cv=none; b=ancKU3ebrFjOAYNHDrS+J7gzv3BeNIV3xlzcU22MUCdFn5Ew+0E8UYk2+EN/jNoD1uS4me2InLHtMFn+mK2FU/l0JdsFBphLTZLUO+UHV+FIvjgJI9nFYhIXeJcee1xujlzfxBF5kfkmGWguKzDkVDQ0fXOSihFI075YCMtsYXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748639551; c=relaxed/simple;
	bh=P/YMCbwrpBbxLG+PWll5gP6eQ2Z8LW87NIhljRLyZaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZYdJ6YTFof/nX07/R3yh/6vo2M8uDPi1cem8jSZijDJPbOo6873mAPtrUvjwdRUKKNvSNUZiuse10iaRK0nuRIukVhqLp2UcrGR5jBDA1yrJ5brbto/qpqsEtPsCdYVm9BKl0OUplvMNX3f0ZNHXBt53kDD0iOue6hcMTs/Qwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lO2XG1b2; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748639550; x=1780175550;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P/YMCbwrpBbxLG+PWll5gP6eQ2Z8LW87NIhljRLyZaI=;
  b=lO2XG1b21NtJl6QwtOSMJLl6AMGrv9r/wsWyJWLh+uHWuLttAvif76Im
   i45LHzw2z+gIZOLWdp0vMucB7kYqMshOCEPBSSyD2m0t56CLHUrBjLekL
   c3AcGZedqHwhTMRSSLZHyUqX3sIey6j1Eh3MXWILbWaF73Wbx0rqfzds/
   /EgUa4WasCx487zNIiZjmV5LL7BJcQbJTkroHyxGpXGe2AS4gFjpGVlNN
   UTtORiYTZciShXh26vbfPau3rr10GvuKOs89vqTySSp1SubJt6edt/rvo
   022J2FWhsZUYots/+zeIt/fNjyh+BpC6M52Rw2dtwdYDQS4RK3YM+FhPp
   Q==;
X-CSE-ConnectionGUID: l4sF4wvLSseGjmDXfsn2PA==
X-CSE-MsgGUID: m0xQ/oSsQNGE4YUKwGp3+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="49862625"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="49862625"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 14:12:25 -0700
X-CSE-ConnectionGUID: OHon1pO9T7SsxI77U38aNw==
X-CSE-MsgGUID: 8YofVLytQsWr5H+uSQSVRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="144621687"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 30 May 2025 14:12:26 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Emil Tantilov <emil.s.tantilov@intel.com>,
	anthony.l.nguyen@intel.com,
	willemb@google.com,
	decot@google.com,
	madhu.chittim@intel.com,
	Joshua Hay <joshua.a.hay@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 5/5] idpf: avoid mailbox timeout delays during reset
Date: Fri, 30 May 2025 14:12:19 -0700
Message-ID: <20250530211221.2170484-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250530211221.2170484-1-anthony.l.nguyen@intel.com>
References: <20250530211221.2170484-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Tantilov <emil.s.tantilov@intel.com>

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
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c     | 18 +++++++++++++-----
 .../net/ethernet/intel/idpf/idpf_virtchnl.c    |  2 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.h    |  1 +
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index bab12ecb2df5..4eb20ec2accb 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1801,11 +1801,19 @@ void idpf_vc_event_task(struct work_struct *work)
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
index 07a9f5ae34fd..24febaaa8fbb 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -347,7 +347,7 @@ static void idpf_vc_xn_init(struct idpf_vc_xn_manager *vcxn_mngr)
  * All waiting threads will be woken-up and their transaction aborted. Further
  * operations on that object will fail.
  */
-static void idpf_vc_xn_shutdown(struct idpf_vc_xn_manager *vcxn_mngr)
+void idpf_vc_xn_shutdown(struct idpf_vc_xn_manager *vcxn_mngr)
 {
 	int i;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
index 3522c1238ea2..77578206bada 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.h
@@ -150,5 +150,6 @@ int idpf_send_get_stats_msg(struct idpf_vport *vport);
 int idpf_send_set_sriov_vfs_msg(struct idpf_adapter *adapter, u16 num_vfs);
 int idpf_send_get_set_rss_key_msg(struct idpf_vport *vport, bool get);
 int idpf_send_get_set_rss_lut_msg(struct idpf_vport *vport, bool get);
+void idpf_vc_xn_shutdown(struct idpf_vc_xn_manager *vcxn_mngr);
 
 #endif /* _IDPF_VIRTCHNL_H_ */
-- 
2.47.1


