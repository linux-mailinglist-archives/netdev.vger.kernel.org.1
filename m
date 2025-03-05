Return-Path: <netdev+bounces-172208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD952A50DC7
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 22:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB5763B12F8
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 21:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94CB25C707;
	Wed,  5 Mar 2025 21:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SBD2S2yd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A5F25BAD7
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 21:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210565; cv=none; b=KfWS/8NC/+Yd1uD8Q0yIxy4Y2GDNlb6j6i3J5r5vUTxaseQWdZB0riNSl0HLwPRxt2MM/kUr80Hit51yL1cuFk2jAROdgf4PyWkoQd7Nl8I2VUBS5Y2zLzuNzKBiBW8zmKED5yCGTcCRhN6wqx7eZhH5l4Y7NCr/llYH9PLPLB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210565; c=relaxed/simple;
	bh=uNRKKVqID7kZB9OgAHMn4nS931Qj79b5NBPgV2Wo9fY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqr30iwudkegsveUbFXLl+Q/fNSOZ36JG5sbDKYoF/7bRn9SYNjwVXIbC+0Wt4XojJgILE6HGZdkalpGT7E1zXjKyOl/Vu46HELajS1wOoG1+yRWTdXWrXgNIiWydUhXB8ODW48mswPtfk010pt+K81f6VBZ6J7amfSA+QluFhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SBD2S2yd; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741210564; x=1772746564;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uNRKKVqID7kZB9OgAHMn4nS931Qj79b5NBPgV2Wo9fY=;
  b=SBD2S2ydO1SiCN8r2ilvgKkyHYMDKUAUqlE3gXoPegaO+jgeK3fCUI9j
   ClQ5fOPBADtr+i7tucoNJvuQpYg8yc6yd/bBxbQrPOU5Z/ukd+qEZiVC9
   ncAxU4bIOvaX+0TBFdPnbyXydJG34uvVT40FXydqC/D69mEROeMQanSvV
   U+9Te6gdO9AygBA/sHjdGm4H+t5GN/21De9V1kcFZ/Iu2Ytf4z5Qn2b5k
   7eSU0uuaVNYvTltLi14JBZu8aaExU3XJGu4ZIJoUg+Vt8ZpcLk9oOyXu3
   u+Fsw6bRuwjlovdsYaqsd7l1KWZ4tNvR3HnN89I8xyaSEc7HoSceg4M0O
   Q==;
X-CSE-ConnectionGUID: lAFSCCvqR8KgK0D4/WmWQA==
X-CSE-MsgGUID: aR3dfUkbQ0io9UcQPAAcdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53606497"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="53606497"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 13:35:58 -0800
X-CSE-ConnectionGUID: Ga2Be8GyRtm+JnoU0n3NSQ==
X-CSE-MsgGUID: 1+NjlbOpRnW7fmldOVb1iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="123828483"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa004.jf.intel.com with ESMTP; 05 Mar 2025 13:35:55 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>,
	anthony.l.nguyen@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Simon Horman <horms@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net 2/4] ice: fix memory leak in aRFS after reset
Date: Wed,  5 Mar 2025 13:35:44 -0800
Message-ID: <20250305213549.1514274-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305213549.1514274-1-anthony.l.nguyen@intel.com>
References: <20250305213549.1514274-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

Fix aRFS (accelerated Receive Flow Steering) structures memory leak by
adding a checker to verify if aRFS memory is already allocated while
configuring VSI. aRFS objects are allocated in two cases:
- as part of VSI initialization (at probe), and
- as part of reset handling

However, VSI reconfiguration executed during reset involves memory
allocation one more time, without prior releasing already allocated
resources. This led to the memory leak with the following signature:

[root@os-delivery ~]# cat /sys/kernel/debug/kmemleak
unreferenced object 0xff3c1ca7252e6000 (size 8192):
  comm "kworker/0:0", pid 8, jiffies 4296833052
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 0):
    [<ffffffff991ec485>] __kmalloc_cache_noprof+0x275/0x340
    [<ffffffffc0a6e06a>] ice_init_arfs+0x3a/0xe0 [ice]
    [<ffffffffc09f1027>] ice_vsi_cfg_def+0x607/0x850 [ice]
    [<ffffffffc09f244b>] ice_vsi_setup+0x5b/0x130 [ice]
    [<ffffffffc09c2131>] ice_init+0x1c1/0x460 [ice]
    [<ffffffffc09c64af>] ice_probe+0x2af/0x520 [ice]
    [<ffffffff994fbcd3>] local_pci_probe+0x43/0xa0
    [<ffffffff98f07103>] work_for_cpu_fn+0x13/0x20
    [<ffffffff98f0b6d9>] process_one_work+0x179/0x390
    [<ffffffff98f0c1e9>] worker_thread+0x239/0x340
    [<ffffffff98f14abc>] kthread+0xcc/0x100
    [<ffffffff98e45a6d>] ret_from_fork+0x2d/0x50
    [<ffffffff98e083ba>] ret_from_fork_asm+0x1a/0x30
    ...

Fixes: 28bf26724fdb ("ice: Implement aRFS")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_arfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_arfs.c b/drivers/net/ethernet/intel/ice/ice_arfs.c
index 7cee365cc7d1..405ddd17de1b 100644
--- a/drivers/net/ethernet/intel/ice/ice_arfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_arfs.c
@@ -511,7 +511,7 @@ void ice_init_arfs(struct ice_vsi *vsi)
 	struct hlist_head *arfs_fltr_list;
 	unsigned int i;
 
-	if (!vsi || vsi->type != ICE_VSI_PF)
+	if (!vsi || vsi->type != ICE_VSI_PF || ice_is_arfs_active(vsi))
 		return;
 
 	arfs_fltr_list = kcalloc(ICE_MAX_ARFS_LIST, sizeof(*arfs_fltr_list),
-- 
2.47.1


