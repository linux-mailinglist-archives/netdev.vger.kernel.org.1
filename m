Return-Path: <netdev+bounces-241276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 53141C82260
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 19:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 55ABD4E7DF0
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 18:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1A12BE035;
	Mon, 24 Nov 2025 18:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LTwcq41a"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E02256D
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 18:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764010110; cv=none; b=O458KZAjed0VN/hRZCEXECkN9qMpnPH8mc3p1Igf068q5Yqear9R+ELM02jlKR8v/glGiHktm/AbSUQ/QRLVt3QUPjCouaDrzOk7OI/2Ad2EyRXlPx2LTrKMgSbyg75PdUL83h2T+yznyDWclX31/ez40nKnrEnu8AnP6D5PO0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764010110; c=relaxed/simple;
	bh=5FXsQs1lAU6pJyz8/irRopjoaZ3UazGSsZDK/mLRxKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KJhzqKHjV/FabClawanplIrfNejvoBYLmW6P4w/f0/kg3IB1IVsK/VjH/omFWqX/eZ9aZaQp/rhtlmnQyHaOPwz1Q2FALskXmESP1kVQALeFhnQa6HUL7kLc5vn7D9apEU1NVyCAZm0XKQv6mFhdboFt1+qotfzVaqDkm6rufV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LTwcq41a; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764010109; x=1795546109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5FXsQs1lAU6pJyz8/irRopjoaZ3UazGSsZDK/mLRxKI=;
  b=LTwcq41ayV1stlm3VkDf7bLejSX0WKF7VjG95sZQiG7pcqlQZkVTU7o8
   i3OHpnNzcskoHplO2C0A75ZBDUAmwNC468+hrZkTq/cOPBRASxSCmWxxU
   OWIiscJ6KteayEtCNNLj2/r1mpOIo2XltarY/7bJZNfBwBOTQJptLwfaB
   eU2lvYVpccHpns3hnNOR+o4W0tHN9F7tZlODFZ5mEOlc1LiygzDMJ/OHe
   PgbT7YCgAMyntRA3GjHqB6TPAmA5RAhTd2/K/VZK8to2s0xdwDL5W78ML
   NhY/A/GBBiDUuFKM5WHnzKTMOi3gFUuOG7HWw1HygmrxUQURMPumuQUtN
   w==;
X-CSE-ConnectionGUID: Re/6JSZzSOSLuhUz7WqWoQ==
X-CSE-MsgGUID: Ryb0UrGLQUSvMw6iXqu2WQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11623"; a="76341837"
X-IronPort-AV: E=Sophos;i="6.20,223,1758610800"; 
   d="scan'208";a="76341837"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 10:48:29 -0800
X-CSE-ConnectionGUID: BsOPzP+BStyKVzACB2JTmA==
X-CSE-MsgGUID: B2cI28YNSXCTBE4hb+wBQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,223,1758610800"; 
   d="scan'208";a="196575008"
Received: from aus-labsrv3.an.intel.com ([10.123.116.23])
  by orviesa003.jf.intel.com with ESMTP; 24 Nov 2025 10:48:28 -0800
From: Sreedevi Joshi <sreedevi.joshi@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Sreedevi Joshi <sreedevi.joshi@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>
Subject: [PATCH iwl-net v2 2/3] idpf: Fix RSS LUT configuration on down interfaces
Date: Mon, 24 Nov 2025 12:47:49 -0600
Message-Id: <20251124184750.3625097-3-sreedevi.joshi@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251124184750.3625097-1-sreedevi.joshi@intel.com>
References: <20251124184750.3625097-1-sreedevi.joshi@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RSS LUT provisioning and queries on a down interface currently return
silently without effect. Users should be able to configure RSS settings
even when the interface is down.

Fix by maintaining RSS configuration changes in the driver's soft copy and
deferring HW programming until the interface comes up.

Fixes: 02cbfba1add5 ("idpf: add ethtool callbacks")
Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Reviewed-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
index 4c6e52253ae4..eb807e89d91a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ethtool.c
@@ -393,7 +393,10 @@ static u32 idpf_get_rxfh_indir_size(struct net_device *netdev)
  * @netdev: network interface device structure
  * @rxfh: pointer to param struct (indir, key, hfunc)
  *
- * Reads the indirection table directly from the hardware. Always returns 0.
+ * RSS LUT and Key information are read from driver's cached
+ * copy. When rxhash is off, rss lut will be displayed as zeros.
+ *
+ * Return: 0 on success, -errno otherwise.
  */
 static int idpf_get_rxfh(struct net_device *netdev,
 			 struct ethtool_rxfh_param *rxfh)
@@ -401,10 +404,13 @@ static int idpf_get_rxfh(struct net_device *netdev,
 	struct idpf_netdev_priv *np = netdev_priv(netdev);
 	struct idpf_rss_data *rss_data;
 	struct idpf_adapter *adapter;
+	struct idpf_vport *vport;
+	bool rxhash_ena;
 	int err = 0;
 	u16 i;
 
 	idpf_vport_ctrl_lock(netdev);
+	vport = idpf_netdev_to_vport(netdev);
 
 	adapter = np->adapter;
 
@@ -414,9 +420,8 @@ static int idpf_get_rxfh(struct net_device *netdev,
 	}
 
 	rss_data = &adapter->vport_config[np->vport_idx]->user_config.rss_data;
-	if (np->state != __IDPF_VPORT_UP)
-		goto unlock_mutex;
 
+	rxhash_ena = idpf_is_feature_ena(vport, NETIF_F_RXHASH);
 	rxfh->hfunc = ETH_RSS_HASH_TOP;
 
 	if (rxfh->key)
@@ -424,7 +429,7 @@ static int idpf_get_rxfh(struct net_device *netdev,
 
 	if (rxfh->indir) {
 		for (i = 0; i < rss_data->rss_lut_size; i++)
-			rxfh->indir[i] = rss_data->rss_lut[i];
+			rxfh->indir[i] = rxhash_ena ? rss_data->rss_lut[i] : 0;
 	}
 
 unlock_mutex:
@@ -464,8 +469,6 @@ static int idpf_set_rxfh(struct net_device *netdev,
 	}
 
 	rss_data = &adapter->vport_config[vport->idx]->user_config.rss_data;
-	if (np->state != __IDPF_VPORT_UP)
-		goto unlock_mutex;
 
 	if (rxfh->hfunc != ETH_RSS_HASH_NO_CHANGE &&
 	    rxfh->hfunc != ETH_RSS_HASH_TOP) {
@@ -481,6 +484,8 @@ static int idpf_set_rxfh(struct net_device *netdev,
 			rss_data->rss_lut[lut] = rxfh->indir[lut];
 	}
 
+	if (np->state != __IDPF_VPORT_UP)
+		goto unlock_mutex;
 	err = idpf_config_rss(vport);
 
 unlock_mutex:
-- 
2.43.0


