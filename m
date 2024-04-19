Return-Path: <netdev+bounces-89699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A58738AB427
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 19:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B8D51F21DAD
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 17:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21B6139583;
	Fri, 19 Apr 2024 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YqAqJCJ1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A7B1369AA
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 17:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713546526; cv=none; b=rgrpZSUrfpxeDS/rfE3Ya27F7hKqPN3ySutuyIXUR4DN+pn6on1mvFHXbZq/NdGlbuCh9glW/YsFFBDCB1Y8rbscacQIXEoFC9Lm6pMX57nDa9m9ELFUeOZbboNZtRdQxWeyiprabCqmehbQHG3uttbEFmg7mE/PfZgzpUqaHuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713546526; c=relaxed/simple;
	bh=W9uxdBNPrzw8IEk83hy6OSC8VkEIk5v/qxhXr1JHaQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+TLLAvgxxgUGNqtoBJlCYuf8AqfRI9ojLFK4kNNC2udRpQHMr8hpjixsTUB+ZLQFHzr13Q2XOC3r3IPLP5DRzcXFBAYSsviS6UgLecTuF8kNSgYJU6aQ7Z0zuXPyGwb2BVh5RY9+H4kJbuD7gfiRSPgjqLgykx3SQ5YZh39LE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YqAqJCJ1; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713546525; x=1745082525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W9uxdBNPrzw8IEk83hy6OSC8VkEIk5v/qxhXr1JHaQw=;
  b=YqAqJCJ1QSitt92YRjG09lIWxxg5WtIwg8x+8HJ9Fxy1jIbEK0+KcmtK
   xN1ranvAhu8XGNv5ofEPhG89qsxOofwQBAMd0CYhfmZid56iimGbzSFbH
   BhzmFmmsp6UW87+YY0nteCGoGBDS1pz9KyKkiON4EMPS6TxKJxrdYz/tJ
   V5JB+ASI21s3hMBBlV5oshnK7jsaY+3clymMNgLWpywGGUb6Is3mekDNq
   MyMB9r9uIAwCMmZLC+dkEyhWM2XCo9hnBrSA/y73HqnohO0LyoAZJCg0O
   BGVmPc1R57oE5FDbB+yxe3MmJwFl86IHzOIwlFA9eZW8M5d7Uw6CDt0jF
   g==;
X-CSE-ConnectionGUID: GMbwLPwjSYWkPlAW0E/HxA==
X-CSE-MsgGUID: oPK96F7kQAyrLvGoadxrFA==
X-IronPort-AV: E=McAfee;i="6600,9927,11049"; a="26674288"
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="26674288"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2024 10:08:45 -0700
X-CSE-ConnectionGUID: TnO11aRUQcmeXEFYprK1Jg==
X-CSE-MsgGUID: 8uz1LTLZSkWgDKdT0JSymA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,214,1708416000"; 
   d="scan'208";a="27847163"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa005.fm.intel.com with ESMTP; 19 Apr 2024 10:08:42 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com,
	sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com,
	wojciech.drewek@intel.com,
	pio.raczynski@gmail.com,
	jiri@nvidia.com,
	mateusz.polchlopek@intel.com,
	shayd@nvidia.com
Subject: [iwl-next v1 1/4] ice: store representor ID in bridge port
Date: Fri, 19 Apr 2024 19:13:33 +0200
Message-ID: <20240419171336.11617-2-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240419171336.11617-1-michal.swiatkowski@linux.intel.com>
References: <20240419171336.11617-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is used to get representor structure during cleaning.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch_br.c | 4 +++-
 drivers/net/ethernet/intel/ice/ice_eswitch_br.h | 1 +
 drivers/net/ethernet/intel/ice/ice_repr.c       | 7 ++-----
 drivers/net/ethernet/intel/ice/ice_repr.h       | 1 +
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
index ac5beecd028b..f5aceb32bf4d 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.c
@@ -896,7 +896,8 @@ ice_eswitch_br_port_deinit(struct ice_esw_br *bridge,
 	if (br_port->type == ICE_ESWITCH_BR_UPLINK_PORT && vsi->back) {
 		vsi->back->br_port = NULL;
 	} else {
-		struct ice_repr *repr = ice_repr_get_by_vsi(vsi);
+		struct ice_repr *repr =
+			ice_repr_get(vsi->back, br_port->repr_id);
 
 		if (repr)
 			repr->br_port = NULL;
@@ -937,6 +938,7 @@ ice_eswitch_br_vf_repr_port_init(struct ice_esw_br *bridge,
 	br_port->vsi = repr->src_vsi;
 	br_port->vsi_idx = br_port->vsi->idx;
 	br_port->type = ICE_ESWITCH_BR_VF_REPR_PORT;
+	br_port->repr_id = repr->id;
 	repr->br_port = br_port;
 
 	err = xa_insert(&bridge->ports, br_port->vsi_idx, br_port, GFP_KERNEL);
diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch_br.h b/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
index 85a8fadb2928..c15c7344d7f8 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch_br.h
@@ -46,6 +46,7 @@ struct ice_esw_br_port {
 	enum ice_esw_br_port_type type;
 	u16 vsi_idx;
 	u16 pvid;
+	u32 repr_id;
 	struct xarray vlans;
 };
 
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.c b/drivers/net/ethernet/intel/ice/ice_repr.c
index d367f4c66dcd..fe83f305cc7d 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.c
+++ b/drivers/net/ethernet/intel/ice/ice_repr.c
@@ -415,12 +415,9 @@ struct ice_repr *ice_repr_add_vf(struct ice_vf *vf)
 	return ERR_PTR(err);
 }
 
-struct ice_repr *ice_repr_get_by_vsi(struct ice_vsi *vsi)
+struct ice_repr *ice_repr_get(struct ice_pf *pf, u32 id)
 {
-	if (!vsi->vf)
-		return NULL;
-
-	return xa_load(&vsi->back->eswitch.reprs, vsi->vf->repr_id);
+	return xa_load(&pf->eswitch.reprs, id);
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_repr.h b/drivers/net/ethernet/intel/ice/ice_repr.h
index cff730b15ca0..07842620d7a2 100644
--- a/drivers/net/ethernet/intel/ice/ice_repr.h
+++ b/drivers/net/ethernet/intel/ice/ice_repr.h
@@ -40,4 +40,5 @@ struct ice_repr *ice_repr_get_by_vsi(struct ice_vsi *vsi);
 void ice_repr_inc_tx_stats(struct ice_repr *repr, unsigned int len,
 			   int xmit_status);
 void ice_repr_inc_rx_stats(struct net_device *netdev, unsigned int len);
+struct ice_repr *ice_repr_get(struct ice_pf *pf, u32 id);
 #endif
-- 
2.42.0


