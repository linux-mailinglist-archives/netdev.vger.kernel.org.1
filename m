Return-Path: <netdev+bounces-237291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 25453C4880A
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 19:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 136914E1C14
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 18:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4D3326D53;
	Mon, 10 Nov 2025 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dgR3VIP3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B69325707
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 18:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762798523; cv=none; b=tPSYE5SDCzDKgxkZMiXV7R+/rrt6ECP7Srx9UUxM5GRTUeDaU12tz1DAPg/GLLN6MMBe5H9oV2c4Zvdv+Ew9n8M4ogOkw+3Ns2eZ8fSmQ49UvR6b3aQYM/jJYwwOA2C8DcZikJNeuhd08D5/ud9aSFVxJZcEdb593CNDD3+l7k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762798523; c=relaxed/simple;
	bh=wLTUmV+ApT/9ZBDzo80caj17Ob/F6zvbzNLQMrOPOYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=H4I5Bze3w0DnbUUZiKzgByEMOnyz6RAHcU0Tbd1xYNmtD7NiEoCWDuA9XZKdhrxv+CsaXGOwCxQ3hZ5RiCxQ7ws4vrNGEWJGqaAqYijUZwXNhWNiCSe7NI/jhcUO8klwq1rNocCsUU4Q1wBLn0HsMZ9fuvZoFupjLqX0p6wEocg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dgR3VIP3; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762798522; x=1794334522;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=wLTUmV+ApT/9ZBDzo80caj17Ob/F6zvbzNLQMrOPOYY=;
  b=dgR3VIP3xAHafVg0vBvAY5cbhsVPkEj0KVewPLQl2xyB21F4JDmuHqUs
   L7xR/6OW0qsC1BEJ5G0TfpFak7YM0Dk6S2Y5eigMCO2nTvCaufX0LI4W/
   ff7yrVKAR7QxksgFl2O+UENuiCLsMVGENI8Ux28faVgNwcbqhfTuRgtWC
   PKumwewIbvNrm3kF+uE04DkaS3IfbPEY/y24ocFf/innfzlm5KjLZSRsn
   W53eUIR1IAWcENPUQgTODh3t5ylJrq7ohgsGs2XQSvcXurOSb+QkrvfPA
   Y2LJHYcduWZMWNrnzCMSOb8LBTA2riP0lidevig3yLcPA79uGzsfhSTJS
   w==;
X-CSE-ConnectionGUID: onvD6QdYR+qKIKrNG2SbgA==
X-CSE-MsgGUID: a9kVYFlsTL6kuqFRLP9tvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="87485207"
X-IronPort-AV: E=Sophos;i="6.19,294,1754982000"; 
   d="scan'208";a="87485207"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 10:15:20 -0800
X-CSE-ConnectionGUID: FRIphoFLRwu6bN73Sr2y6Q==
X-CSE-MsgGUID: 9AaKzJS4Rxmi/pl1+ip5fQ==
X-ExtLoop1: 1
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by fmviesa003.fm.intel.com with ESMTP; 10 Nov 2025 10:15:20 -0800
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Aleksandr.Loktionov@intel.com,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	decot@google.com,
	willemb@google.com,
	joshua.a.hay@intel.com,
	madhu.chittim@intel.com,
	aleksander.lobakin@intel.com,
	larysa.zaremba@intel.com,
	iamvivekkumar@google.com
Subject: [PATCH iwl-net 1/4] idpf: keep the netdev when a reset fails
Date: Mon, 10 Nov 2025 10:08:20 -0800
Message-Id: <20251110180823.18008-2-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20251110180823.18008-1-emil.s.tantilov@intel.com>
References: <20251110180823.18008-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

During a successful reset the driver would re-allocate vport resources
while keeping the netdevs intact. However, in case of an error in the
init task, the netdev of the failing vport will be unregistered,
effectively removing the network interface:

[  121.211076] idpf 0000:83:00.0: enabling device (0100 -> 0102)
[  121.221976] idpf 0000:83:00.0: Device HW Reset initiated
[  124.161229] idpf 0000:83:00.0 ens801f0: renamed from eth0
[  124.163364] idpf 0000:83:00.0 ens801f0d1: renamed from eth1
[  125.934656] idpf 0000:83:00.0 ens801f0d2: renamed from eth2
[  128.218429] idpf 0000:83:00.0 ens801f0d3: renamed from eth3

ip -br a
ens801f0         UP
ens801f0d1       UP
ens801f0d2       UP
ens801f0d3       UP
echo 1 > /sys/class/net/ens801f0/device/reset

[  145.885537] idpf 0000:83:00.0: resetting
[  145.990280] idpf 0000:83:00.0: reset done
[  146.284766] idpf 0000:83:00.0: HW reset detected
[  146.296610] idpf 0000:83:00.0: Device HW Reset initiated
[  211.556719] idpf 0000:83:00.0: Transaction timed-out (op:526 cookie:7700 vc_op:526 salt:77 timeout:60000ms)
[  272.996705] idpf 0000:83:00.0: Transaction timed-out (op:502 cookie:7800 vc_op:502 salt:78 timeout:60000ms)

ip -br a
ens801f0d1       DOWN
ens801f0d2       DOWN
ens801f0d3       DOWN

Re-shuffle the logic in the error path of the init task to make sure the
netdevs remain intact. This will allow the driver to attempt recovery via
subsequent resets, provided the FW is still functional.

The main change is to make sure that idpf_decfg_netdev() is not called
should the init task fail during a reset. The error handling is
consolidated under unwind_vports, as the removed labels had the same
cleanup logic split depending on the point of failure.

Fixes: ce1b75d0635c ("idpf: add ptypes and MAC filter support")
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index bd38ecc7872c..2a53f3d504d2 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1604,6 +1604,10 @@ void idpf_init_task(struct work_struct *work)
 		goto unwind_vports;
 	}
 
+	err = idpf_send_get_rx_ptype_msg(vport);
+	if (err)
+		goto unwind_vports;
+
 	index = vport->idx;
 	vport_config = adapter->vport_config[index];
 
@@ -1616,15 +1620,11 @@ void idpf_init_task(struct work_struct *work)
 	err = idpf_check_supported_desc_ids(vport);
 	if (err) {
 		dev_err(&pdev->dev, "failed to get required descriptor ids\n");
-		goto cfg_netdev_err;
+		goto unwind_vports;
 	}
 
 	if (idpf_cfg_netdev(vport))
-		goto cfg_netdev_err;
-
-	err = idpf_send_get_rx_ptype_msg(vport);
-	if (err)
-		goto handle_err;
+		goto unwind_vports;
 
 	/* Once state is put into DOWN, driver is ready for dev_open */
 	np = netdev_priv(vport->netdev);
@@ -1671,11 +1671,6 @@ void idpf_init_task(struct work_struct *work)
 
 	return;
 
-handle_err:
-	idpf_decfg_netdev(vport);
-cfg_netdev_err:
-	idpf_vport_rel(vport);
-	adapter->vports[index] = NULL;
 unwind_vports:
 	if (default_vport) {
 		for (index = 0; index < adapter->max_vports; index++) {
-- 
2.37.3


