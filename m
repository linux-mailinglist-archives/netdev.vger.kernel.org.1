Return-Path: <netdev+bounces-120669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D087695A26B
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 18:07:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87C68287E17
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 16:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1F81E522;
	Wed, 21 Aug 2024 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z15ji9I1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7724014D2AC
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724256436; cv=none; b=Goae+WQhxu6/JX0Iv4poCK5/gWDJpnoPuVHInRuk9+H+97fUmbKpqf6j1LVLcS+nz8EmymXqchj2v1xDolCvFQvKXC9rGEZDa8xQHBQYMLfd495Te/sX/73tqQxcYZ/8V3mDHDx4m6sTKxNpapNA1bTmEiLlFL4NNMmx1Wt0Oow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724256436; c=relaxed/simple;
	bh=vcAarlNiWxCYVaWvlTC56pd2ZvIzPVoa4xthXKdDffg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RBsJ4CtWyFlwgKSUKdecE7stq9ICmKEzVd88vtHEhpU1F4zEJVIy6y7W0wztARuCIJ77hbJyBzg5t7sXrwqrmNaaK3cITU/fbeCHUaLtVj4yPfwYu/UebYYs2SvGQf2ZJxk7tuTJeaQZ5EPgELs0U06klCGGLRfWIlwoeIBUMkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z15ji9I1; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724256434; x=1755792434;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vcAarlNiWxCYVaWvlTC56pd2ZvIzPVoa4xthXKdDffg=;
  b=Z15ji9I1ewcEpFDAk4mlL2hnNsxXgekHh+ot4eIpbK3vlbYr3rwjAwnD
   zpO4imAjVYBeMS+ZGOiqzXUAcelOl3yP5joqt8TqYoRLdZtMT9Q3K1PND
   pCtgk9tVbJUyTrgQKoVmCXnqTCMMETtr+FLh6qETNmHkXJ3qcfQRH/44K
   VkbmS033RmnWWwcRSo66B5q+BNT4RB+iJPlG+ez4X7j5m31wgIE04tQHV
   dE3xlLaGoXQf+MAef6dmfuzOR97B7XJnUmUzXuuwW6rnCPhoEYY9FHihP
   lO/GtPlNxiPU7AyrTb0k7u/THyzLLOATs0g1dmZWGYI01x6epEk0r2+lf
   Q==;
X-CSE-ConnectionGUID: hf/tvaqfRf6K9vTex6g6gw==
X-CSE-MsgGUID: b5wzuP/0RIKCAq7QwV0wlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="33287533"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="33287533"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 09:07:14 -0700
X-CSE-ConnectionGUID: Zzh7UKx8Stivls2z20FXUg==
X-CSE-MsgGUID: 5r9slJyKTRmyxVJ1T+0lkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="91921772"
Received: from pae-dbg-x10sri-f_n1_f.igk.intel.com (HELO localhost.igk.intel.com) ([10.91.240.220])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 09:07:12 -0700
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	larysa.zaremba@intel.com,
	maciej.fijalkowski@intel.com,
	kalesh-anakkur.purayil@broadcom.com,
	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Igor Bagnucki <igor.bagnucki@intel.com>
Subject: [PATCH iwl-net v5] ice: Add netif_device_attach/detach into PF reset flow
Date: Wed, 21 Aug 2024 18:06:40 +0200
Message-ID: <20240821160640.115552-1-dawid.osuchowski@linux.intel.com>
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
Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
---
Changes since v1:
* Changed Fixes tag to point to another commit
* Minified the stacktrace

Changes since v2:
* Moved netif_device_attach() directly into ice_rebuild() and perform it
  only on main vsi

Changes since v3:
* Style changes requested by Przemek Kitszel

Changes since v4:
* Applied reverse xmas tree rule to declaration of ice_vsi *vsi variable

Suggestion from Kuba: https://lore.kernel.org/netdev/20240610194756.5be5be90@kernel.org/
Previous attempt (dropped because it introduced regression with link up): https://lore.kernel.org/netdev/20240722122839.51342-1-dawid.osuchowski@linux.intel.com/
---
 drivers/net/ethernet/intel/ice/ice_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index eaa73cc200f4..71bd7bbfb447 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -608,6 +608,9 @@ ice_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 			memset(&vsi->mqprio_qopt, 0, sizeof(vsi->mqprio_qopt));
 		}
 	}
+
+	if (vsi->netdev)
+		netif_device_detach(vsi->netdev);
 skip:
 
 	/* clear SW filtering DB */
@@ -7589,6 +7592,7 @@ static void ice_update_pf_netdev_link(struct ice_pf *pf)
  */
 static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 {
+	struct ice_vsi *vsi = ice_get_main_vsi(pf);
 	struct device *dev = ice_pf_to_dev(pf);
 	struct ice_hw *hw = &pf->hw;
 	bool dvm;
@@ -7731,6 +7735,9 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 		ice_rebuild_arfs(pf);
 	}
 
+	if (vsi && vsi->netdev)
+		netif_device_attach(vsi->netdev);
+
 	ice_update_pf_netdev_link(pf);
 
 	/* tell the firmware we are up */
-- 
2.44.0


