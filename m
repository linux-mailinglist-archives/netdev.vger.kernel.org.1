Return-Path: <netdev+bounces-260034-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJCJGpZWnGkAEQQAu9opvQ
	(envelope-from <netdev+bounces-260034-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:31:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 741C0176F24
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A6AE30B101D
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 13:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61353A1D2;
	Mon, 23 Feb 2026 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kA80m0ek"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC16A2EB0F
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 13:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771853138; cv=none; b=ncrW5FoFX6CvO1Cgi/mxQ5SifWEoF7r3DN3Hh+7M5cDnkIwYxLVYh72ObvZ9KJmshZEd8006nxN8TPl58GchlAWfq7c0QNYA6Rfsb863Hx2ka1lsvnjHmBlZ1lL3JtDgmy7jsGj6YR9Fx2R0WXV35jCHz6G6GJszPOyaakGNEww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771853138; c=relaxed/simple;
	bh=8GljxCdIML4JwqSHoSvnhyZ8D7LTSTtgjk4jLabrviM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n9P+zOpRYszVAwMwMlAkKI26c2uAaKKkcPLjTw+UJX5vvmPOSS3Dia8jPEAa3cMa7q00t4Z+4KGdgomzsyusMbEHntVSMQtK5k4t2TJeOzinDeVGB7GdMIuHMUkqHPCHODRFySBNXFq6hfTZnk2UyGKWTvWrLunHZYeiJap82EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kA80m0ek; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771853136; x=1803389136;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8GljxCdIML4JwqSHoSvnhyZ8D7LTSTtgjk4jLabrviM=;
  b=kA80m0ekNjp5c9hODYl7qvqS3JITzIzxJ13GwJmHTFQIy5y+2CKndDUk
   SUIeTyhTSB1gfqy2Re0+9YUlSQoasHfPyodV8JX1q/JbmwIYVNPui7Ko7
   E5HDeUkH6hUtardu/j6p+YndxnOco1FT5q14e24sA5vGm2+Ar7IlvSK1P
   PHn4kIeyzcQQEERB9xTQX8w1VJn7tpSL6oIL5xyZinM9M6gYV8cCY0idi
   HOQMhB7a428DXIQcfV+mYgR3/UGgVdFVClvSySqwAs2xL60nsef1OpvOt
   SbdWldB0+hN4NBFY9JL8e4XBITRt2RuB6eWs2lxbkC7SyGdrGyQKERd50
   w==;
X-CSE-ConnectionGUID: KPM3A3POSYioSKMZzS5G4A==
X-CSE-MsgGUID: VjHyW37PRCm54c+d2Y8K+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="60421080"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="60421080"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 05:25:35 -0800
X-CSE-ConnectionGUID: qhMCWJpHSnazyPqUZFC/mQ==
X-CSE-MsgGUID: iBZk0vBrQy2MbjUHGKSngg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="253283464"
Received: from os-delivery.igk.intel.com ([10.102.21.165])
  by orviesa001.jf.intel.com with ESMTP; 23 Feb 2026 05:25:31 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net v1] ice: set max queues in alloc_etherdev_mqs()
Date: Mon, 23 Feb 2026 13:51:57 +0100
Message-ID: <20260223125157.819135-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260034-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michal.swiatkowski@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 741C0176F24
X-Rspamd-Action: no action

When allocating netdevice using alloc_etherdev_mqs() the maximum
supported queues number should be passed. The vsi->alloc_txq/rxq is
storing current number of queues, not the maximum ones.

Use the same function for getting max Tx and Rx queues which is used
during ethtool -l call to set maximum number of queues during netdev
allocation.

Reproduction steps:
$ethtool -l $pf # says current 16, max 64
$ethtool -S $pf # fine
$ethtool -L $pf combined 40 # crash

[491187.472594] Call Trace:
[491187.472829]  <TASK>
[491187.473067]  netif_set_xps_queue+0x26/0x40
[491187.473305]  ice_vsi_cfg_txq+0x265/0x3d0 [ice]
[491187.473619]  ice_vsi_cfg_lan_txqs+0x68/0xa0 [ice]
[491187.473918]  ice_vsi_cfg_lan+0x2b/0xa0 [ice]
[491187.474202]  ice_vsi_open+0x71/0x170 [ice]
[491187.474484]  ice_vsi_recfg_qs+0x17f/0x230 [ice]
[491187.474759]  ? dev_get_min_mp_channel_count+0xab/0xd0
[491187.474987]  ice_set_channels+0x185/0x3d0 [ice]
[491187.475278]  ethnl_set_channels+0x26f/0x340

Fixes: ee13aa1a2c5a ("ice: use netif_get_num_default_rss_queues()")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         | 22 ++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 18 ----------------
 drivers/net/ethernet/intel/ice/ice_main.c    |  4 ++--
 3 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index f6a56a864459..725b130dd3a2 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -839,6 +839,28 @@ static inline void ice_tx_xsk_pool(struct ice_vsi *vsi, u16 qid)
 	WRITE_ONCE(ring->xsk_pool, ice_get_xp_from_qid(vsi, qid));
 }
 
+/**
+ * ice_get_max_txq - return the maximum number of Tx queues for in a PF
+ * @pf: PF structure
+ *
+ * Return: maximum number of Tx queues
+ */
+static inline int ice_get_max_txq(struct ice_pf *pf)
+{
+	return min(num_online_cpus(), pf->hw.func_caps.common_cap.num_txq);
+}
+
+/**
+ * ice_get_max_rxq - return the maximum number of Rx queues for in a PF
+ * @pf: PF structure
+ *
+ * Return: maximum number of Rx queues
+ */
+static inline int ice_get_max_rxq(struct ice_pf *pf)
+{
+	return min(num_online_cpus(), pf->hw.func_caps.common_cap.num_rxq);
+}
+
 /**
  * ice_get_main_vsi - Get the PF VSI
  * @pf: PF instance
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index a897a6b22495..a0b0416f5aea 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3780,24 +3780,6 @@ ice_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *info)
 	return 0;
 }
 
-/**
- * ice_get_max_txq - return the maximum number of Tx queues for in a PF
- * @pf: PF structure
- */
-static int ice_get_max_txq(struct ice_pf *pf)
-{
-	return min(num_online_cpus(), pf->hw.func_caps.common_cap.num_txq);
-}
-
-/**
- * ice_get_max_rxq - return the maximum number of Rx queues for in a PF
- * @pf: PF structure
- */
-static int ice_get_max_rxq(struct ice_pf *pf)
-{
-	return min(num_online_cpus(), pf->hw.func_caps.common_cap.num_rxq);
-}
-
 /**
  * ice_get_combined_cnt - return the current number of combined channels
  * @vsi: PF VSI pointer
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index fa4095037be5..863ac81eebce 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -4699,8 +4699,8 @@ static int ice_cfg_netdev(struct ice_vsi *vsi)
 	struct net_device *netdev;
 	u8 mac_addr[ETH_ALEN];
 
-	netdev = alloc_etherdev_mqs(sizeof(*np), vsi->alloc_txq,
-				    vsi->alloc_rxq);
+	netdev = alloc_etherdev_mqs(sizeof(*np), ice_get_max_txq(vsi->back),
+				    ice_get_max_rxq(vsi->back));
 	if (!netdev)
 		return -ENOMEM;
 
-- 
2.49.0


