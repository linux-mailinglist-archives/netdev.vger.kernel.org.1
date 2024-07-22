Return-Path: <netdev+bounces-112412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61369938F11
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 14:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2198B20FB1
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 12:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD46C16CD3B;
	Mon, 22 Jul 2024 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cLFacz+q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F011754B
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 12:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721651387; cv=none; b=j24DWkbwG6zrtEHJWkZJlinx/C8PkpCcKFiuRThQcpZy38CaNMPkZrFqTifvlmQB0ymvxxSJK2IZqCRN5U9mnGMtx8jrucS5nT5p4XTXBVsiLarwnX6LhhUwMIauNBhDuphPGzee3iR/NhwSRihpaaow0E1az3igM7mVp4c0voY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721651387; c=relaxed/simple;
	bh=+ccc8M/ClTchN4DNxP88CEU+RwmMuJAPuydZ4/srS5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pcs6y/xNZmsalQzIt29Q4yiuzFmvLLt27YqRy31jm0gfREOqHHvycMMe+9NYMBxlsenKlu/2S1yMVe3sM8+YehZ3vcNrLIyhOYgpCWEJ0PF8Dx6bL6J1gWY71R+NUaXn17KaRsU3kMQmR0XC6bpIlqjbwAMEezj/QV+zYHeh/6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cLFacz+q; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721651386; x=1753187386;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+ccc8M/ClTchN4DNxP88CEU+RwmMuJAPuydZ4/srS5I=;
  b=cLFacz+qRGlgf14n+JeIEfYZbOq+toEKbLNnjhHvr0vjeDtX48mu0xjZ
   d0DdE/00q6By9JGxwMh3tmnlF0mSJQfVi4ijEsZHJRX3XFzbvSSJ/32hy
   WCqY3gvwDXL36/waPnwuXClyE+nGePl0Z+AT5oXXUH9Y9pcdi4jU62Xhg
   EQEAhIUvexp31R+xlcolfEC85zB3TROIM8RQor3SnI7wqkgGjiZbeCLRX
   ZyqHOH2WGUHm33+TZhvh/TOqMlWgm4ypNGPbfcrDxzGQ9WbeBwx5Gob8g
   sn5OAMV5/HOKT6KTl4ALDJMtfDK176Ev0wDJAySMh6d1ogy5ybLH2MayX
   w==;
X-CSE-ConnectionGUID: 18WAw63GTAGmRC5ANd9jTQ==
X-CSE-MsgGUID: dWbyUTxRTraLcyBovITY2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="29801327"
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; 
   d="scan'208";a="29801327"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 05:29:30 -0700
X-CSE-ConnectionGUID: SjUXvpbuRgWcwQ0hKBo2xA==
X-CSE-MsgGUID: sDlORgOhS0acS3krLrcxug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; 
   d="scan'208";a="56429594"
Received: from pae-dbg-x10sri-f_n1_f.igk.intel.com (HELO localhost.igk.intel.com) ([10.91.240.220])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 05:29:27 -0700
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH iwl-net] ice: Introduce netif_device_attach/detach into reset flow
Date: Mon, 22 Jul 2024 14:28:39 +0200
Message-ID: <20240722122839.51342-1-dawid.osuchowski@linux.intel.com>
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

[  +0.000105] BUG: kernel NULL pointer dereference, address: 0000000000000020
[  +0.000027] #PF: supervisor read access in kernel mode
[  +0.000011] #PF: error_code(0x0000) - not-present page
[  +0.000011] PGD 0 P4D 0
[  +0.000008] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
[  +0.000012] CPU: 11 PID: 19713 Comm: ethtool Tainted: G S                 6.10.0-rc7+ #7
[  +0.000015] Hardware name: Supermicro Super Server/X10SRi-F, BIOS 2.0 12/17/2015
[  +0.000013] RIP: 0010:ice_get_q_coalesce+0x2e/0xa0 [ice]
[  +0.000090] Code: 00 55 53 48 89 fb 48 89 f7 48 83 ec 08 0f b7 8b 86 04 00 00 0f b7 83 82 04 00 00 39 d1 7e 30 48 8b 4b 18 48 63 ea 48 8b 0c e9 <48> 8b 71 20 48 81 c6 a0 01 00 00 39 c2 7c 32 e8 ee fe ff ff 85 c0
[  +0.000029] RSP: 0018:ffffbab1e9bcf6a8 EFLAGS: 00010206
[  +0.000012] RAX: 000000000000000c RBX: ffff94512305b028 RCX: 0000000000000000
[  +0.000012] RDX: 0000000000000000 RSI: ffff9451c3f2e588 RDI: ffff9451c3f2e588
[  +0.000012] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[  +0.000013] R10: ffff9451c3f2e580 R11: 000000000000001f R12: ffff945121fa9000
[  +0.000012] R13: ffffbab1e9bcf760 R14: 0000000000000013 R15: ffffffff9e65dd40
[  +0.000012] FS:  00007faee5fbe740(0000) GS:ffff94546fd80000(0000) knlGS:0000000000000000
[  +0.000014] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000011] CR2: 0000000000000020 CR3: 0000000106c2e005 CR4: 00000000001706f0
[  +0.000012] Call Trace:
[  +0.000009]  <TASK>
[  +0.000007]  ? __die+0x23/0x70
[  +0.000012]  ? page_fault_oops+0x173/0x510
[  +0.000011]  ? ice_get_q_coalesce+0x2e/0xa0 [ice]
[  +0.000071]  ? search_module_extables+0x19/0x60
[  +0.000013]  ? search_bpf_extables+0x5f/0x80
[  +0.000012]  ? exc_page_fault+0x7e/0x180
[  +0.000013]  ? asm_exc_page_fault+0x26/0x30
[  +0.000014]  ? ice_get_q_coalesce+0x2e/0xa0 [ice]
[  +0.000070]  ice_get_coalesce+0x17/0x30 [ice]
[  +0.000070]  coalesce_prepare_data+0x61/0x80
[  +0.000012]  ethnl_default_doit+0xde/0x340
[  +0.000012]  genl_family_rcv_msg_doit+0xf2/0x150
[  +0.000013]  genl_rcv_msg+0x1b3/0x2c0
[  +0.000009]  ? __pfx_ethnl_default_doit+0x10/0x10
[  +0.000011]  ? __pfx_genl_rcv_msg+0x10/0x10
[  +0.000010]  netlink_rcv_skb+0x5b/0x110
[  +0.000013]  genl_rcv+0x28/0x40
[  +0.000007]  netlink_unicast+0x19c/0x290
[  +0.000012]  netlink_sendmsg+0x222/0x490
[  +0.000011]  __sys_sendto+0x1df/0x1f0
[  +0.000013]  __x64_sys_sendto+0x24/0x30
[  +0.000340]  do_syscall_64+0x82/0x160
[  +0.000309]  ? __mod_memcg_lruvec_state+0xa6/0x150
[  +0.000309]  ? __lruvec_stat_mod_folio+0x68/0xa0
[  +0.000311]  ? folio_add_file_rmap_ptes+0x86/0xb0
[  +0.000309]  ? next_uptodate_folio+0x89/0x290
[  +0.000309]  ? filemap_map_pages+0x521/0x5f0
[  +0.000302]  ? do_fault+0x26e/0x470
[  +0.000293]  ? __handle_mm_fault+0x7dc/0x1060
[  +0.000295]  ? __count_memcg_events+0x58/0xf0
[  +0.000289]  ? count_memcg_events.constprop.0+0x1a/0x30
[  +0.000292]  ? handle_mm_fault+0xae/0x320
[  +0.000284]  ? do_user_addr_fault+0x33a/0x6a0
[  +0.000280]  ? exc_page_fault+0x7e/0x180
[  +0.000289]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  +0.000271] RIP: 0033:0x7faee60d8e27

Fixes: 67fe64d78c43 ("ice: Implement getting and setting ethtool coalesce")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index ec636be4d17d..eb199fd3c989 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -6744,6 +6744,7 @@ static int ice_up_complete(struct ice_vsi *vsi)
 	    (vsi->port_info->phy.link_info.link_info & ICE_AQ_LINK_UP) &&
 	    vsi->netdev && vsi->type == ICE_VSI_PF) {
 		ice_print_link_msg(vsi, true);
+		netif_device_attach(vsi->netdev);
 		netif_tx_start_all_queues(vsi->netdev);
 		netif_carrier_on(vsi->netdev);
 		ice_ptp_link_change(pf, pf->hw.pf_id, true);
@@ -7220,6 +7221,7 @@ int ice_down(struct ice_vsi *vsi)
 		ice_ptp_link_change(vsi->back, vsi->back->hw.pf_id, false);
 		netif_carrier_off(vsi->netdev);
 		netif_tx_disable(vsi->netdev);
+		netif_device_detach(vsi->netdev);
 	}
 
 	ice_vsi_dis_irq(vsi);
-- 
2.44.0


