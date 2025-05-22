Return-Path: <netdev+bounces-192605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A372FAC07C5
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 10:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ED197AF81B
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 08:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B0124E4C6;
	Thu, 22 May 2025 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L988hToX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112331624E5
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 08:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747903941; cv=none; b=soqZvL2h0kvrJgjFyUQM4BEeL/v28BBa7H0yk2MnDpBtDJJ++7I+7A4EWgJbFnXzfv9vqpnKM1ZUqmeJVaOMRUwfUIFpkOBveFVK/NsIAWmpahGCzpX6y4h3BdNBeIMj2CCacq3W9dQXxfA9Aqyl+j1Oct0CMcvKeBACq1oj1PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747903941; c=relaxed/simple;
	bh=0+8eI1HxrSZFjYuny+D0+8nQ3/TGskQCq0fRWoB+Eas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mr0jHuSTRZ/v3cbyQftSkXMciQKoEPEqYWcwuSqJ+zF4tslxCHG+5EsWeCe0ZOx3jDfKc1g9IK2gdp5jEBlfw9hLqsepjt/rzvwmyyvLqx0/PZG065d09chrsmj3pLmYRZRqUZSX8K0rIjYnWMyp9yZN1lUM7tDSJxSRKVG9XyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L988hToX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747903940; x=1779439940;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0+8eI1HxrSZFjYuny+D0+8nQ3/TGskQCq0fRWoB+Eas=;
  b=L988hToXN0za0L3fFyNrezX0yKfQ9eyQvsNYISa7Ee+93gd6ltfEIDPv
   BhWiALMwNORAKWbSsCjGatDzUIRZXMa6c55YCayqA16xT90ryGTmDMAhP
   h1QapJt7Rf6OgIaYVXPMJV+Yr9lImevHX9Hy4GCRnKuOeyKS6N3bTI0Nd
   WZEW39rUDcG759RyI40XLREOF1eUQ4pY1XJ2ue04p6UNCUD6FInzLUh6X
   sVJFIGMzSpG2nJSesZLjUvgd3vwKM2eQaEr2Irkf/+v072SLI99Idup5G
   V3wyvc1wmoxqWHjinPXw+vnn9hlAtT+jKRvFsqP2okc9JeJWPdIpaLiwN
   w==;
X-CSE-ConnectionGUID: aHKlw48+TeSkFOn4WYpi6Q==
X-CSE-MsgGUID: +hjcgc5kRm24K6XY5A5mOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="75313061"
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="75313061"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 01:52:19 -0700
X-CSE-ConnectionGUID: cF7LHSLRQJSLoecNMXXQYA==
X-CSE-MsgGUID: C4rqEeTFR4+bQmFsaQsdzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="141419693"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by orviesa008.jf.intel.com with ESMTP; 22 May 2025 01:52:18 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH iwl-net v1] idpf: return 0 size for RSS key if not supported
Date: Thu, 22 May 2025 10:52:06 +0200
Message-ID: <20250522085206.1119209-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Returning -EOPNOTSUPP from function returning u32 is leading to
cast and invalid size value as a result.

-EOPNOTSUPP as a size probably will lead to allocation fail.

Command: ethtool -x eth0
It is visible on all devices that don't have RSS caps set.

[  136.615917] Call Trace:
[  136.615921]  <TASK>
[  136.615927]  ? __warn+0x89/0x130
[  136.615942]  ? __alloc_frozen_pages_noprof+0x322/0x330
[  136.615953]  ? report_bug+0x164/0x190
[  136.615968]  ? handle_bug+0x58/0x90
[  136.615979]  ? exc_invalid_op+0x17/0x70
[  136.615987]  ? asm_exc_invalid_op+0x1a/0x20
[  136.616001]  ? rss_prepare_get.constprop.0+0xb9/0x170
[  136.616016]  ? __alloc_frozen_pages_noprof+0x322/0x330
[  136.616028]  __alloc_pages_noprof+0xe/0x20
[  136.616038]  ___kmalloc_large_node+0x80/0x110
[  136.616072]  __kmalloc_large_node_noprof+0x1d/0xa0
[  136.616081]  __kmalloc_noprof+0x32c/0x4c0
[  136.616098]  ? rss_prepare_get.constprop.0+0xb9/0x170
[  136.616105]  rss_prepare_get.constprop.0+0xb9/0x170
[  136.616114]  ethnl_default_doit+0x107/0x3d0
[  136.616131]  genl_family_rcv_msg_doit+0x100/0x160
[  136.616147]  genl_rcv_msg+0x1b8/0x2c0
[  136.616156]  ? __pfx_ethnl_default_doit+0x10/0x10
[  136.616168]  ? __pfx_genl_rcv_msg+0x10/0x10
[  136.616176]  netlink_rcv_skb+0x58/0x110
[  136.616186]  genl_rcv+0x28/0x40
[  136.616195]  netlink_unicast+0x19b/0x290
[  136.616206]  netlink_sendmsg+0x222/0x490
[  136.616215]  __sys_sendto+0x1fd/0x210
[  136.616233]  __x64_sys_sendto+0x24/0x30
[  136.616242]  do_syscall_64+0x82/0x160
[  136.616252]  ? __sys_recvmsg+0x83/0xe0
[  136.616265]  ? syscall_exit_to_user_mode+0x10/0x210
[  136.616275]  ? do_syscall_64+0x8e/0x160
[  136.616282]  ? __count_memcg_events+0xa1/0x130
[  136.616295]  ? count_memcg_events.constprop.0+0x1a/0x30
[  136.616306]  ? handle_mm_fault+0xae/0x2d0
[  136.616319]  ? do_user_addr_fault+0x379/0x670
[  136.616328]  ? clear_bhb_loop+0x45/0xa0
[  136.616340]  ? clear_bhb_loop+0x45/0xa0
[  136.616349]  ? clear_bhb_loop+0x45/0xa0
[  136.616359]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  136.616369] RIP: 0033:0x7fd30ba7b047
[  136.616376] Code: 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b8 0f 1f 00 f3 0f 1e fa 80 3d bd d5 0c 00 00 41 89 ca 74 10 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 71 c3 55 48 83 ec 30 44 89 4c 24 2c 4c 89 44
[  136.616381] RSP: 002b:00007ffde1796d68 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
[  136.616388] RAX: ffffffffffffffda RBX: 000055d7bd89f2a0 RCX: 00007fd30ba7b047
[  136.616392] RDX: 0000000000000028 RSI: 000055d7bd89f3b0 RDI: 0000000000000003
[  136.616396] RBP: 00007ffde1796e10 R08: 00007fd30bb4e200 R09: 000000000000000c
[  136.616399] R10: 0000000000000000 R11: 0000000000000202 R12: 000055d7bd89f340
[  136.616403] R13: 000055d7bd89f3b0 R14: 000055d78943f200 R15: 0000000000000000

Fixes: 02cbfba1add5 ("idpf: add ethtool callbacks")
Reviewed-by: Ahmed Zaki <ahmed.zaki@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 59b1a1a09996..f72420cf6821 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -46,7 +46,7 @@ static u32 idpf_get_rxfh_key_size(struct net_device *netdev)
 	struct idpf_vport_user_config_data *user_config;
 
 	if (!idpf_is_cap_ena_all(np->adapter, IDPF_RSS_CAPS, IDPF_CAP_RSS))
-		return -EOPNOTSUPP;
+		return 0;
 
 	user_config = &np->adapter->vport_config[np->vport_idx]->user_config;
 
@@ -65,7 +65,7 @@ static u32 idpf_get_rxfh_indir_size(struct net_device *netdev)
 	struct idpf_vport_user_config_data *user_config;
 
 	if (!idpf_is_cap_ena_all(np->adapter, IDPF_RSS_CAPS, IDPF_CAP_RSS))
-		return -EOPNOTSUPP;
+		return 0;
 
 	user_config = &np->adapter->vport_config[np->vport_idx]->user_config;
 
-- 
2.42.0


