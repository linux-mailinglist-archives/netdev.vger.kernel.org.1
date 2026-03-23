Return-Path: <netdev+bounces-270736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OObwJ9apwWmUUQQAu9opvQ
	(envelope-from <netdev+bounces-270736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:00:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AFD2FD821
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 22:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC656304EAAC
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F6E3E5EE5;
	Mon, 23 Mar 2026 20:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bHBwih9l"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CB33E5589
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 20:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774299533; cv=none; b=b3s6A1RNtF7GVFT3PFVGkxkKuSVWjqyZSsuk9POjiHGxYgH2JL86EG0ccmUNOTadkF/h2MiS36Iq4zi/qQDf3Wtzxd9GahvYboxm7ZVzUcJtElCRhhOYZfjN2Pj6oabTrPQNJl7ICICrmzp3tDE3px4lvgdH4rrbEmisr+lUsH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774299533; c=relaxed/simple;
	bh=lyKLy01eaa+1O2r2AnRDEIGqlqsZqUMGcIPFVgO/VsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SuWtzw9eDBbLg5BDwTDJj+JCa/B6X+P5lxR0UV9VLLL5iZxox2yAZU8CD4E3itapS7KYp6YiXVuLnQ9kvIwngwj7dlXwLF9ZjZhLtX64376O3sMdMslpdcwLLjw4TsMfBNKKduGEqVXIVErCI2c9jmjIu08y0cGhltXzhCL/bjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bHBwih9l; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774299532; x=1805835532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lyKLy01eaa+1O2r2AnRDEIGqlqsZqUMGcIPFVgO/VsE=;
  b=bHBwih9lgTQVUc67TAHKKjZpgVg8f1GeGCyKZZXD8pydrGL+OYX4e9Sx
   GBMap1Aregi/Bb79MslZQ/83gP8v77q2M2vLZ9si0DIg67OCmG78nJzck
   /3RMxAopf7ke1BLw8A0Twwya8U/dB1IK2FaG2tRg1SddQZ2s+o2FCVEWt
   9nNEd5SKieei2+4NA5zmB7EcXKtUot1rLO9Dn8uuyZR4+PeZZSGDf0Jxi
   O2HBhJ6uoRGWiLqJDBxdbbPzbAgWKabHQGycMlWSXNsx0riI7iXtDjmeT
   GCdR/6YxuG1/CHOTTqgElNr8Q/I/6iiGtkAczT4E3zM/T25zNUcOXnHi5
   w==;
X-CSE-ConnectionGUID: y+nkS42UT9OEz5ObnlC1WA==
X-CSE-MsgGUID: 5woAfe/aSzCJX7qO0nEEvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="75375502"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="75375502"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 13:58:49 -0700
X-CSE-ConnectionGUID: jETf3kLyTqCXXKbrbLOtZA==
X-CSE-MsgGUID: i7/EzU3eRWu09c3mr3UeXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="224114414"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa009.jf.intel.com with ESMTP; 23 Mar 2026 13:58:49 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net 1/6] ice: set max queues in alloc_etherdev_mqs()
Date: Mon, 23 Mar 2026 13:58:36 -0700
Message-ID: <20260323205843.624704-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260323205843.624704-1-anthony.l.nguyen@intel.com>
References: <20260323205843.624704-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-270736-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mpg.de:email]
X-Rspamd-Queue-Id: 23AFD2FD821
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

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
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h         | 22 ++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ethtool.c | 18 ----------------
 drivers/net/ethernet/intel/ice/ice_main.c    |  4 ++--
 3 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 2b2b22af42be..eb3a48330cc1 100644
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
index 301947d53ede..e4e1eab05bd5 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3773,24 +3773,6 @@ ice_get_ts_info(struct net_device *dev, struct kernel_ethtool_ts_info *info)
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
index e7308e381e2f..3c36e3641b9e 100644
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
2.47.1


