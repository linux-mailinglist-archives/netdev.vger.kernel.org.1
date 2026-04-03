Return-Path: <netdev+bounces-274895-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uH6PIJRXz2llvQYAu9opvQ
	(envelope-from <netdev+bounces-274895-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 08:00:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAA03914CD
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 08:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C314300E3B8
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 06:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4AE35F600;
	Fri,  3 Apr 2026 05:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VwbB2M8Y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840092DD5F6
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 05:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775195998; cv=none; b=LSpVT3prRRM0XViJJU4O/yL+GYE2/p1DKGtwlhFssWxMU6tGQPBfy3GmKDEBgVzg2J61rWhXsLOoJfXEL6r/IoEeVOqCc2NNOSXVD7uXGzLpVdCm4ETLu6gNcb5AyzzSUmf8QVBj3UyYiSk7EbNzitCFcz6vV5oUb6Qvi/K4YQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775195998; c=relaxed/simple;
	bh=hkh+Nmw/K44d7gAG5USnMmol1zayw7cvyPtDXFrWDIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fieM6XD6R+KQXIqGCSCi1r+CF7wBZMjgxBGC54i6XPKq65BwldFRmO2gL4nPVmj2swxEyppVFMGX17+NP7uiIjmg4HTWLLelpGWv8o8qQ4Vu8NzCB5mPIPpWYwqgTTLsI7H1uewCJBIlz6WL3dc/AvrFKm4zAgHgN3oNh7MIzUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VwbB2M8Y; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775195991; x=1806731991;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hkh+Nmw/K44d7gAG5USnMmol1zayw7cvyPtDXFrWDIM=;
  b=VwbB2M8Yifq908KyH+Udp7D0DWj341nCv/OqBbFmn/A6IpZgvilpq19d
   RQHdS42ixvBCTsyqPWErkZK/R64bZDfE5OHtVZHLaEV287ZjrWrGoOysp
   uTjfxUGIalycBuu9zToU08Li3hmuvvHe8APSDwl+/JPSFHRaamRsRoFf8
   sFDHF2AS0C8g4XvfTSzsdMC4hngKhZz6jwtHFD5JFOGNbMXb5dPT7f7ec
   RXSAncfMFpplp4KCjst9GPVHByrHZaTSwptYZi7n471vKccvBKFlsZqs1
   0taRVUpCYqKf/fhQPdi8e+xTVazgjQ9RjCW33HA5zj7SBudMc6/9ytRoH
   w==;
X-CSE-ConnectionGUID: 0gxRQQhFS+qVjq3PeXMsmA==
X-CSE-MsgGUID: Vba0DEstSRKp/5AVxyDltQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11747"; a="87649922"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="87649922"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 22:59:50 -0700
X-CSE-ConnectionGUID: BSKNbz52SEWx0SKtddhLcg==
X-CSE-MsgGUID: vaTLvJYRTYu3CScoQu0u8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="227426251"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by orviesa007.jf.intel.com with ESMTP; 02 Apr 2026 22:59:49 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-net] ice: fix netdev allocation with max queues instead of default
Date: Fri,  3 Apr 2026 07:59:48 +0200
Message-ID: <20260403055948.3800555-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274895-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CAAA03914CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit ee13aa1a2c5a ("ice: use netif_get_num_default_rss_queues()")
changed the default queue count from num_online_cpus() to
netif_get_num_default_rss_queues() which returns roughly half the CPU
count.  ice_cfg_netdev() passes vsi->alloc_txq and vsi->alloc_rxq to
alloc_etherdev_mqs(), so after that commit the netdevice is created with
only ~half the CPU count of Tx/Rx queues (dev->num_tx_queues).  However
ice_get_channels() still reports the old maximum (num_online_cpus()),
and ice_set_channels() accepts requests up to that limit.  When ethtool
 -L sets combined to the maximum, rings are assigned q_index values up to
num_online_cpus()-1, which exceed dev->num_tx_queues:

  # ethtool -L eth0 combined 96

  ice 0000:18:00.0: Failed to allocate 96 q_vectors for VSI 12, new value 49
  WARNING: CPU: 25 PID: 4484 at net/core/dev.c:2853 __netif_set_xps_queue+0x835/0x9a0
  [...]
  Call Trace:
   <TASK>
   netif_set_xps_queue+0x82/0xc0
   ice_vsi_cfg_txq+0x124/0x440 [ice]
   ice_vsi_cfg_lan_txqs+0x53/0x90 [ice]
   ice_vsi_cfg_lan+0x40/0x190 [ice]
   ice_vsi_open+0x2b/0x120 [ice]
   ice_vsi_recfg_qs+0x94/0x120 [ice]
   ice_set_channels+0x261/0x370 [ice]
   [...]

SUT: Intel S2600WFT, 96 CPUs (Xeon Platinum 8260), E810-C for QSFP

Reproduce:
  ethtool -L <iface> combined $(nproc)

Use min(num_online_cpus(), hw queue cap) for alloc_etherdev_mqs() to
size the netdevice for the actual maximum queue count, matching what
ice_get_channels() reports through ethtool.

Fixes: ee13aa1a2c5a ("ice: use netif_get_num_default_rss_queues()")
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 4da37ca..5c21c2a 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4699,8 +4699,11 @@ static int ice_cfg_netdev(struct ice_vsi *vsi)
 	struct net_device *netdev;
 	u8 mac_addr[ETH_ALEN];
 
-	netdev = alloc_etherdev_mqs(sizeof(*np), vsi->alloc_txq,
-				    vsi->alloc_rxq);
+	netdev = alloc_etherdev_mqs(sizeof(*np),
+				    min_t(int, num_online_cpus(),
+					   vsi->back->hw.func_caps.common_cap.num_txq),
+				    min_t(int, num_online_cpus(),
+					   vsi->back->hw.func_caps.common_cap.num_rxq));
 	if (!netdev)
 		return -ENOMEM;
 
-- 
2.43.0

