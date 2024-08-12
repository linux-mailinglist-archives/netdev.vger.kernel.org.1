Return-Path: <netdev+bounces-117697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E32694ED60
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 14:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3176A1F21DF6
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A3E17B509;
	Mon, 12 Aug 2024 12:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cxhz+Oks"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBF717B505
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 12:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723467041; cv=none; b=aAM7oJX7O4cVkaq+4+mjeS7hpwkCn/yVfNczgAFO+OejHljjqmhCJSfMZtHczFf7mgWN3gqvcLqvoqsnwsJtzQTBqNC43CSUUs+JtcqPoFpSrvgMLaCYe2guDB09pctRZ9kbDxhj3PWNOjed5IJW4AQEvmj3k/JoVyIKHBgb54M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723467041; c=relaxed/simple;
	bh=21dfzZ9PvFGELI2d85s1nFPX0mWiceKT+bzfjD9mgPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DmnwZQvSOdadarJ7NuiEKjXcTY7DL5O20n1htNedKZ8qq4i9lTmjMeN6Q2fYAn8u8V6ayBMBpRaXJkeZsjtH+pxmebTF1yOkwUvHxBvh6RlD4zsPVeBO2G/TPvZnFHLZZG6sAQAAY0pM3VVOQ0FVdKgbz//BxQLT0wd1QwHZrKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cxhz+Oks; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723467040; x=1755003040;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=21dfzZ9PvFGELI2d85s1nFPX0mWiceKT+bzfjD9mgPc=;
  b=cxhz+OksxNZEsZEXUD3wSGTAiWHTzGMIS32ivn7gQD7qrSLrTP6NREHR
   RJtaHZEW3UIwoz2P38CH57xPkQ9Bn6u2tsCv1+GsYlvlbbPoJ/E9qcjFr
   qdpBdToLpUaNdYn6WpoHqLqZcicgGj5H14dRM0zR4Zv0TloPyuysl56Rw
   mqWTLrnjYs9ay2ojn7Dewa1jQZKHWc/fheueHvmARXM9qzvCohAB6KrAq
   2ZmwwYdM1uRbojBiLaj4VlleCoTvLE3CJFH3yN2yW6t5ALOgUgiJkxvhy
   Lw5nc6SUbA28avY0Aj3neXx5IcjZ7SFVYXIox0B7+XA/S1vkWEz248q6A
   g==;
X-CSE-ConnectionGUID: +SpwhStCSz6sFo3cYyXEDQ==
X-CSE-MsgGUID: cv6mmktNQLavwJ5jfJ/TPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21735941"
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="21735941"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 05:50:39 -0700
X-CSE-ConnectionGUID: QLvmH5lSRnap2gOtt/+EcQ==
X-CSE-MsgGUID: jE0bndQGT8ejCwIW2A4hoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="58211742"
Received: from pae-dbg-x10sri-f_n1_f.igk.intel.com (HELO localhost.igk.intel.com) ([10.91.240.220])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 05:50:37 -0700
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Igor Bagnucki <igor.bagnucki@intel.com>
Subject: [PATCH iwl-net v2] ice: Add netif_device_attach/detach into PF reset flow
Date: Mon, 12 Aug 2024 14:50:09 +0200
Message-ID: <20240812125009.62635-1-dawid.osuchowski@linux.intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ethtool callbacks can be executed while reset is in progress and try to
access deleted resources, e.g. getting coalesce settings can result in a
NULL pointer dereference seen below.

Reproduction steps:
Once the driver is fully initialized, trigger reset:
	# echo 1 > /sys/class/net/<interface>/device/reset
when reset is in progress try to get coalesce settings using ethtool:
	# ethtool -c <interface>

BUG: kernel NULL pointer dereference, address: 0000000000000020
PGD 0 P4D 0
Oops: Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 11 PID: 19713 Comm: ethtool Tainted: G S                 6.10.0-rc7+ #7
RIP: 0010:ice_get_q_coalesce+0x2e/0xa0 [ice]
RSP: 0018:ffffbab1e9bcf6a8 EFLAGS: 00010206
RAX: 000000000000000c RBX: ffff94512305b028 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff9451c3f2e588 RDI: ffff9451c3f2e588
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: ffff9451c3f2e580 R11: 000000000000001f R12: ffff945121fa9000
R13: ffffbab1e9bcf760 R14: 0000000000000013 R15: ffffffff9e65dd40
FS:  00007faee5fbe740(0000) GS:ffff94546fd80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000020 CR3: 0000000106c2e005 CR4: 00000000001706f0
Call Trace:
<TASK>
ice_get_coalesce+0x17/0x30 [ice]
coalesce_prepare_data+0x61/0x80
ethnl_default_doit+0xde/0x340
genl_family_rcv_msg_doit+0xf2/0x150
genl_rcv_msg+0x1b3/0x2c0
netlink_rcv_skb+0x5b/0x110
genl_rcv+0x28/0x40
netlink_unicast+0x19c/0x290
netlink_sendmsg+0x222/0x490
__sys_sendto+0x1df/0x1f0
__x64_sys_sendto+0x24/0x30
do_syscall_64+0x82/0x160
entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7faee60d8e27

Calling netif_device_detach() before reset makes the net core not call
the driver when ethtool command is issued, the attempt to execute an
ethtool command during reset will result in the following message:

    netlink error: No such device

instead of NULL pointer dereference. Once reset is done and
ice_rebuild() is executing, the netif_device_attach() is called to allow
for ethtool operations to occur again in a safe manner.

Fixes: fcea6f3da546 ("ice: Add stats and ethtool support")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
---
Changes since v1:
* Changed Fixes tag to point to another commit
* Minified the stacktrace

Suggestion from Kuba: https://lore.kernel.org/netdev/20240610194756.5be5be90@kernel.org/
Previous attempt: https://lore.kernel.org/netdev/20240722122839.51342-1-dawid.osuchowski@linux.intel.com/
---
 drivers/net/ethernet/intel/ice/ice_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index eaa73cc200f4..16b4920741ff 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -608,6 +608,8 @@ ice_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 			memset(&vsi->mqprio_qopt, 0, sizeof(vsi->mqprio_qopt));
 		}
 	}
+	if (vsi->netdev)
+		netif_device_detach(vsi->netdev);
 skip:
 
 	/* clear SW filtering DB */
@@ -7568,11 +7570,13 @@ static void ice_update_pf_netdev_link(struct ice_pf *pf)
 
 		ice_get_link_status(pf->vsi[i]->port_info, &link_up);
 		if (link_up) {
+			netif_device_attach(pf->vsi[i]->netdev);
 			netif_carrier_on(pf->vsi[i]->netdev);
 			netif_tx_wake_all_queues(pf->vsi[i]->netdev);
 		} else {
 			netif_carrier_off(pf->vsi[i]->netdev);
 			netif_tx_stop_all_queues(pf->vsi[i]->netdev);
+			netif_device_detach(pf->vsi[i]->netdev);
 		}
 	}
 }
-- 
2.44.0


