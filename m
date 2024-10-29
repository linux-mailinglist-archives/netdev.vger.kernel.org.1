Return-Path: <netdev+bounces-139841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8A89B4603
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 10:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34B541F236D4
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 09:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA6A204003;
	Tue, 29 Oct 2024 09:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h9/0VNeT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0308E7464
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 09:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730195500; cv=none; b=Mz4c6bUpxIKMaBUQbdX103pvCc/91eA24rXVs46S2ITjVOIzaeH6xYPM59ll0PV8L8UErDicBxwbsggPgShQ+ePAaCRgp46OZFQSwk8ufm5GL1PIDt1UE5AfaWv+1jNEkaa8BAgORDAnK6ZSRk4IizGBjQl5vKtXKLNqSmZJJ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730195500; c=relaxed/simple;
	bh=LWcVgKbdjdNQE5gW0KATWpKMbLMhrYuych0y7SeJhe8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JRIkafdtcYNTLwGdnjkfusZLGkn+z5cb1EMKLkfX/w6fuHoU+shKx7phXU8FVdlZQ0UtCjf/GEHtNw2V4O+Fsv+Tc2yWEVOE/jNXVsnk3E4oTaz7VZ6yVOcq5Kmg0JsFJxddA6yvJewrr82G6IwrsIkeFBoTxLwzyJXmoGcJ3bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h9/0VNeT; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730195499; x=1761731499;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LWcVgKbdjdNQE5gW0KATWpKMbLMhrYuych0y7SeJhe8=;
  b=h9/0VNeT4zbc0cuRd4GZ/0wQrbVafE5DfQZ2JJIvNYuLF20UBmb/rD0u
   8RjYlvbZDwvLebnv4SvnznpOfBYUj3OL9dXTWbm6JoHMPFLigHMwViIM/
   wzz5XspjZZ2NXnnBEH96nnHFPRmmTZriNCTx/96+gsukLHDOr1dACdWOF
   fg0C+Ytqr+BAOo3grAbWjX7vjAJt0dMVY/NsunmlQ2HTOVxLtKgjDdtWO
   YN7K8EkscMDarLsSA2CJDRQ9NivTH6F4mEYn/wse6L+ZroC9hgT1ua7l9
   DnL6kH8tQsq9AD0uWBKPhgDykMBF/EfRKSV8MugeExDw5PBXVD1CCuGbO
   A==;
X-CSE-ConnectionGUID: hMKTpbnDTGGk7LQCkZVRtA==
X-CSE-MsgGUID: Wwv2hzk/QaqnJukx0xiCsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33523476"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33523476"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 02:51:38 -0700
X-CSE-ConnectionGUID: 1WE0v/03TCW7uxcINi9mow==
X-CSE-MsgGUID: j62VbXldQsuDHASkKtEdvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,241,1725346800"; 
   d="scan'208";a="87036796"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa004.jf.intel.com with ESMTP; 29 Oct 2024 02:51:36 -0700
Received: from os-delivery.igk.intel.com (unknown [10.123.220.34])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id A824C27BC4;
	Tue, 29 Oct 2024 09:51:35 +0000 (GMT)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next] ice: Fix NULL pointer dereference in switchdev
Date: Tue, 29 Oct 2024 10:42:59 +0100
Message-Id: <20241029094259.77738-1-wojciech.drewek@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ("virtchnl: support queue rate limit and quanta size
configuration") introduced new virtchnl ops:
- get_qos_caps
- cfg_q_bw
- cfg_q_quanta

New ops were added to ice_virtchnl_dflt_ops but not to the
ice_virtchnl_repr_ops. Because of that, if we get one of those
messages in switchdev mode we end up with NULL pointer dereference:

[ 1199.794701] BUG: kernel NULL pointer dereference, address: 0000000000000000
[ 1199.794804] Workqueue: ice ice_service_task [ice]
[ 1199.794878] RIP: 0010:0x0
[ 1199.795027] Call Trace:
[ 1199.795033]  <TASK>
[ 1199.795039]  ? __die+0x20/0x70
[ 1199.795051]  ? page_fault_oops+0x140/0x520
[ 1199.795064]  ? exc_page_fault+0x7e/0x270
[ 1199.795074]  ? asm_exc_page_fault+0x22/0x30
[ 1199.795086]  ice_vc_process_vf_msg+0x6e5/0xd30 [ice]
[ 1199.795165]  __ice_clean_ctrlq+0x734/0x9d0 [ice]
[ 1199.795207]  ice_service_task+0xccf/0x12b0 [ice]
[ 1199.795248]  process_one_work+0x21a/0x620
[ 1199.795260]  worker_thread+0x18d/0x330
[ 1199.795269]  ? __pfx_worker_thread+0x10/0x10
[ 1199.795279]  kthread+0xec/0x120
[ 1199.795288]  ? __pfx_kthread+0x10/0x10
[ 1199.795296]  ret_from_fork+0x2d/0x50
[ 1199.795305]  ? __pfx_kthread+0x10/0x10
[ 1199.795312]  ret_from_fork_asm+0x1a/0x30
[ 1199.795323]  </TASK>

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index f445e33b2028..ff4ad788d96a 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -4128,6 +4128,9 @@ static const struct ice_virtchnl_ops ice_virtchnl_dflt_ops = {
 	.get_qos_caps = ice_vc_get_qos_caps,
 	.cfg_q_bw = ice_vc_cfg_q_bw,
 	.cfg_q_quanta = ice_vc_cfg_q_quanta,
+	/* If you add a new op here please make sure to add it to
+	 * ice_virtchnl_repr_ops as well.
+	 */
 };
 
 /**
@@ -4258,6 +4261,9 @@ static const struct ice_virtchnl_ops ice_virtchnl_repr_ops = {
 	.dis_vlan_stripping_v2_msg = ice_vc_dis_vlan_stripping_v2_msg,
 	.ena_vlan_insertion_v2_msg = ice_vc_ena_vlan_insertion_v2_msg,
 	.dis_vlan_insertion_v2_msg = ice_vc_dis_vlan_insertion_v2_msg,
+	.get_qos_caps = ice_vc_get_qos_caps,
+	.cfg_q_bw = ice_vc_cfg_q_bw,
+	.cfg_q_quanta = ice_vc_cfg_q_quanta,
 };
 
 /**
-- 
2.39.3


