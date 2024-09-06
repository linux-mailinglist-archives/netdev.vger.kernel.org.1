Return-Path: <netdev+bounces-126103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F4296FE02
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 00:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79B04B226D5
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 22:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3EE15CD4E;
	Fri,  6 Sep 2024 22:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nVg83wU7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB0E15B97E
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 22:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725661821; cv=none; b=dmFumq82zoT29zK+0OwsrSEenIX5TjDZVV2S6Kj+fSn//x0UsnxcNukQk0FF435uf9QfO4T/jHiAQkTbuYbYHX6W0IKVGFRFpzqz5urkn4T5EyZOaMlFwtFkfDl2meHJ29cCHcWeNdubhFDwCM35cTUDlAhF/Z+aBJykLTyyCvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725661821; c=relaxed/simple;
	bh=QVQL7FrjNXpYRzLFRYJ7TKTFepqYDJzFPWrdNNO76GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RiBtRaIhQig7oKPpc9/Pq9MWuDhEAPbH1e14r2cXb4dvpGUdccqqy76DEPzEtEUbwXhpXBNhjge9iDdMSWt2K61BOYUqI39XxncLt6AsqtQ+HUPwMX6Eq3zQkdJIoEkkVTLAv3XYHUN+ByMMQXr9b1fMoeRW95HQS90O+ra4HDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nVg83wU7; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725661820; x=1757197820;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QVQL7FrjNXpYRzLFRYJ7TKTFepqYDJzFPWrdNNO76GQ=;
  b=nVg83wU7//AyRikMmkuG4BCXpbjndo8zaIHyrCIZ3ZrBm1ClvY9qPjWU
   7aZARCZT/ihPHggJZeQ52eVLkeEbJwsKW9xzzSwMBQVorVs+ezpQifM9W
   1B3ZJ2Ruh93U3i7lEBfxtnIsxOXNY8hHEI/dmNC/xRTn1Vj6cvNRi7OGB
   bPr+2dzw2VtCIdmw3lJDrcbXgvC3jc8YYWLBLb6DXt1Rk7NIrLDNLTyJ5
   yCjsl4J/tCexy7qrse6l16l9z83wGH+vVJA9hIzMBHyeZonx+UYrp6ZOC
   Uc57n4nijPY0a4eXSgjKU++00+PbFFUW7IuvPQdmxc1joCDSAfAlbeqUP
   A==;
X-CSE-ConnectionGUID: tLUOT8/hTRKvstkmpkxtdA==
X-CSE-MsgGUID: T+11mANkTLq8rdP5EsbeRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="35030756"
X-IronPort-AV: E=Sophos;i="6.10,209,1719903600"; 
   d="scan'208";a="35030756"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 15:30:19 -0700
X-CSE-ConnectionGUID: nRVM6R/VT96r9cdPsRqkQA==
X-CSE-MsgGUID: GKkNboTPTde6uoP+x+4kGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,209,1719903600"; 
   d="scan'208";a="70490462"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa005.fm.intel.com with ESMTP; 06 Sep 2024 15:30:18 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	jiri@nvidia.com,
	shayd@nvidia.com,
	wojciech.drewek@intel.com,
	horms@kernel.org,
	sridhar.samudrala@intel.com,
	mateusz.polchlopek@intel.com,
	kalesh-anakkur.purayil@broadcom.com,
	michal.kubiak@intel.com,
	pio.raczynski@gmail.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	maciej.fijalkowski@intel.com,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net-next v5 11/15] ice: check if SF is ready in ethtool ops
Date: Fri,  6 Sep 2024 15:30:02 -0700
Message-ID: <20240906223010.2194591-12-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240906223010.2194591-1-anthony.l.nguyen@intel.com>
References: <20240906223010.2194591-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Now there is another type of port representor. Correct checking if
parent device is ready to reflect also new PR type.

Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool.c |  7 +++----
 drivers/net/ethernet/intel/ice/ice_repr.c    | 12 ++++++++++++
 drivers/net/ethernet/intel/ice/ice_repr.h    |  1 +
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 793a64d44aa3..d5cc934d1359 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -4412,7 +4412,7 @@ ice_repr_get_drvinfo(struct net_device *netdev,
 {
 	struct ice_repr *repr = ice_netdev_to_repr(netdev);
 
-	if (ice_check_vf_ready_for_cfg(repr->vf))
+	if (repr->ops.ready(repr))
 		return;
 
 	__ice_get_drvinfo(netdev, drvinfo, repr->src_vsi);
@@ -4424,8 +4424,7 @@ ice_repr_get_strings(struct net_device *netdev, u32 stringset, u8 *data)
 	struct ice_repr *repr = ice_netdev_to_repr(netdev);
 
 	/* for port representors only ETH_SS_STATS is supported */
-	if (ice_check_vf_ready_for_cfg(repr->vf) ||
-	    stringset != ETH_SS_STATS)
+	if (repr->ops.ready(repr) || stringset != ETH_SS_STATS)
 		return;
 
 	__ice_get_strings(netdev, stringset, data, repr->src_vsi);
@@ -4438,7 +4437,7 @@ ice_repr_get_ethtool_stats(struct net_device *netdev,
 {
 	struct ice_repr *repr = ice_netdev_to_repr(netdev);
 
-	if (ice_check_vf_ready_for_cfg(repr->vf))
+	if (repr->ops.ready(repr))
 		return;
 
 	__ice_get_ethtool_stats(netdev, stats, data, repr->src_vsi);
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index 5ea8b512c421..229831fe2cd2 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -283,6 +283,16 @@ ice_repr_reg_netdev(struct net_device *netdev)
 	return register_netdev(netdev);
 }
 
+static int ice_repr_ready_vf(struct ice_repr *repr)
+{
+	return !ice_check_vf_ready_for_cfg(repr->vf);
+}
+
+static int ice_repr_ready_sf(struct ice_repr *repr)
+{
+	return !repr->sf->active;
+}
+
 /**
  * ice_repr_destroy - remove representor from VF
  * @repr: pointer to representor structure
@@ -420,6 +430,7 @@ struct ice_repr *ice_repr_create_vf(struct ice_vf *vf)
 	repr->vf = vf;
 	repr->ops.add = ice_repr_add_vf;
 	repr->ops.rem = ice_repr_rem_vf;
+	repr->ops.ready = ice_repr_ready_vf;
 
 	ether_addr_copy(repr->parent_mac, vf->hw_lan_addr);
 
@@ -466,6 +477,7 @@ struct ice_repr *ice_repr_create_sf(struct ice_dynamic_port *sf)
 	repr->sf = sf;
 	repr->ops.add = ice_repr_add_sf;
 	repr->ops.rem = ice_repr_rem_sf;
+	repr->ops.ready = ice_repr_ready_sf;
 
 	ether_addr_copy(repr->parent_mac, sf->hw_addr);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.h b/drivers/net/ethernet/intel/ice/ice_repr.h
index ee28632e87b4..35bd93165e1e 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.h
+++ b/drivers/net/ethernet/intel/ice/ice_repr.h
@@ -36,6 +36,7 @@ struct ice_repr {
 	struct {
 		int (*add)(struct ice_repr *repr);
 		void (*rem)(struct ice_repr *repr);
+		int (*ready)(struct ice_repr *repr);
 	} ops;
 };
 
-- 
2.42.0


