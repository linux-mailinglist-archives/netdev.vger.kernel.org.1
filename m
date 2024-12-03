Return-Path: <netdev+bounces-148695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A6D9E2F11
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 23:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1E95B3CC54
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 21:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507CF20C02C;
	Tue,  3 Dec 2024 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BJOa44ls"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E1820B800
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 21:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733262934; cv=none; b=TfP4Q+Mv9T+TzI5eFl4I1uxNMKAa93HpH5XD3TlpnXQmU1r6RLCRWRPdDHJOVvMni/rzL/Q7D/Jb/RzXqT93mJ3jgyk4f+TkIsxHyxEWgJ74xL00aGvofkDbLAQYpnuLKa3OBvn5llhgk2FdEppcb/qF08ADWaD2W3DtdPbyGp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733262934; c=relaxed/simple;
	bh=xdGs9E5UYETH31RftHS1Y8AXWeuC9cJIca5yksIYcho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pMDQdhZ6YdWxC+5KHTmqLygBPhtWpkqZEiZ1lDgM+QvNG8itkW3Gp2tSxB8BKs2JoPJO3Gl9tA5F3selYPj9aMiF9cZu14CUMNS82dugmNQtyG1h52F3Uk6VA/8VZNX4TpvIzRl6N9q39QGcALI/xLG8vX6jN/68kqqhrwf20ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BJOa44ls; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733262932; x=1764798932;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xdGs9E5UYETH31RftHS1Y8AXWeuC9cJIca5yksIYcho=;
  b=BJOa44lsD97+8r+bOcvEbdvjFWdJU3BmVHABuaRLV4XFx3mBd6aGdlcZ
   cYuVBdRMLkxkZsRfj3/kdbuyBFEm8SlcrL+0m77/E0/uMJERBwhkknB/W
   a815TS+HiZ53bIYMw/9dRvTXr1cC1VfgxxHFyAjSpeNoFRkrmhHKSzMQf
   7PPUtQGqJOZ4bhehWEJc1NTO6tf/uQbDueqndGMQV4PXkXa1GR74YXjRm
   xvlyMOlFsbpYLCPVK8RxGgjsDPYN6ricbQIfT7Wf8ycNs5B6jXW9Xe5y/
   /0Z6U0ov0x53PsaDN1H9XE6oxJSgk0InPlTG8goTbxzclLtN4030rtiB5
   g==;
X-CSE-ConnectionGUID: R9sa7JrRQHOglwDI//1FdQ==
X-CSE-MsgGUID: 2pZcYGe2QzumkFeNsUC3tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="21087125"
X-IronPort-AV: E=Sophos;i="6.12,206,1728975600"; 
   d="scan'208";a="21087125"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 13:55:29 -0800
X-CSE-ConnectionGUID: qoHe6ofnRRG/kp15KlDQOg==
X-CSE-MsgGUID: OzpN/qYySlS1c0wg7PEiyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="98578873"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 03 Dec 2024 13:55:29 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Wojciech Drewek <wojciech.drewek@intel.com>,
	anthony.l.nguyen@intel.com,
	jiri@resnulli.us,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Subject: [PATCH net 3/9] ice: Fix NULL pointer dereference in switchdev
Date: Tue,  3 Dec 2024 13:55:12 -0800
Message-ID: <20241203215521.1646668-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241203215521.1646668-1-anthony.l.nguyen@intel.com>
References: <20241203215521.1646668-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wojciech Drewek <wojciech.drewek@intel.com>

Commit 608a5c05c39b ("virtchnl: support queue rate limit and quanta
size configuration") introduced new virtchnl ops:
- get_qos_caps
- cfg_q_bw
- cfg_q_quanta

New ops were added to ice_virtchnl_dflt_ops, in
commit 015307754a19 ("ice: Support VF queue rate limit and quanta
size configuration"), but not to the ice_virtchnl_repr_ops. Because
of that, if we get one of those messages in switchdev mode we end up
with NULL pointer dereference:

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

Fixes: 015307754a19 ("ice: Support VF queue rate limit and quanta size configuration")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
2.42.0


