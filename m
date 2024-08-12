Return-Path: <netdev+bounces-117641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF59294EAAE
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AAFB280D33
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 10:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FC616EBF0;
	Mon, 12 Aug 2024 10:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CpimI1zU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D7A166F1E
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723458171; cv=none; b=eJugNr5cKjRRXpKG/A303wxp43PLIc80cUiN62gwPfrHizyXsdfY67OODBN50ca9DGjk8e2LfD5vkvLt+PS41veqeDzusS8lvckhdUeoOL2CZg7hHy1jnK+6y1W4Ki2A9mpIBRCWxTY6JpqfEH/HsVO43dhxo2rhwL2fs3O8IdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723458171; c=relaxed/simple;
	bh=tYhLxclXaKVXswK+4W1XffGX3be84NWSNSrdlVKsJ1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C3xz1MuhPm/a7HG+w5PvMnNrsW5U66fTjelhR81uDB6ziSN/eZRwFJICxR8g+cvrursQ9ZcO5Ol0NXKjfR4MVNpTm6SM9n1BHLjC7g2tnZFxR1E8r03DTjlepregaANiW1Ael0DFy7vqGzMUoZXLoWvcH64GaTrSrF92RGfheyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CpimI1zU; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723458170; x=1754994170;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tYhLxclXaKVXswK+4W1XffGX3be84NWSNSrdlVKsJ1s=;
  b=CpimI1zUTsV6yN2mIePPCAa7npqlnjMxH95d3ZFDKrafPvG9zRs8dBAZ
   gZ9gu6OagrrDP5PCVhHyZQ2fzc56YsPq0Je/McShiH4WtSOATNLL/WhwD
   ZDNSEmxNxig1luM1UWv5gk/onHlyCTX4F40Je294cgjXh4Y8pO3Lt1kZ2
   /YyC5zc8U85ujTnZeM4HBGf8mlAWkomvcfNVuwjaBHNIDvW8sIXd5lq9x
   3g9SVoU9nTEIwhykuUCQA0rm2hwoiLEaiyf0e5iraQNR7Cn7Jm+vEsPSw
   nX1PHEpogs83dCf/b3TgE5+JriF3bszKUz/0KYVGI11UNa1PwUKC0IYkv
   w==;
X-CSE-ConnectionGUID: nVmDvo1BRQiiAJ/xXy6Prw==
X-CSE-MsgGUID: oB6+XBxETceJFCdziWH3cQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11161"; a="32136004"
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="32136004"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 03:22:46 -0700
X-CSE-ConnectionGUID: AJAwE+A4SI6iu6TITU8eXw==
X-CSE-MsgGUID: VElN2wIJQzuTEX2VSd5yuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="62613083"
Received: from pae-dbg-x10sri-f_n1_f.igk.intel.com (HELO localhost.igk.intel.com) ([10.91.240.220])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 03:22:45 -0700
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Igor Bagnucki <igor.bagnucki@intel.com>
Subject: [PATCH iwl-net] ice: Add netif_device_attach/detach into PF reset flow
Date: Mon, 12 Aug 2024 12:22:10 +0200
Message-ID: <20240812102210.61548-1-dawid.osuchowski@linux.intel.com>
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

Once the driver is fully initialized, trigger reset:
	# echo 1 > /sys/class/net/<interface>/device/reset
when reset is in progress try to get coalesce settings using ethtool:
        # ethtool -c <interface>

Calling netif_device_detach() before reset makes the net core not call
the driver when ethtool command is issued, the attempt to execute an
ethtool command during reset will result in the following message:

    netlink error: No such device

instead of NULL pointer dereference. Once reset is done and
ice_rebuild() is executing, the netif_device_attach() is called to allow
for ethtool operations to occur again in a safe manner.

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
Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
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


