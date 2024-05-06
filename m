Return-Path: <netdev+bounces-93650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A718BC9C5
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 10:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CDA31C2195D
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 08:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A161419A0;
	Mon,  6 May 2024 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M+3aMTK7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D95140E40
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 08:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714984926; cv=none; b=syErif2s5wqC0iKmiAIfCqgaV8tFLBfboke/+Xg9wq4dpRzhtJBICabbjS0oPHyMQ6lelrxoFHDtuTkc4mJbe2BRqxiqYJwl4rXIfcLbEr+Gi85D8tSnvyWR4O8lNQvsr6ZLZRLTybpewbgw/EN0HGifPzUR/3kifBZ3I1kYOew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714984926; c=relaxed/simple;
	bh=W9uxdBNPrzw8IEk83hy6OSC8VkEIk5v/qxhXr1JHaQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0jlvGTXzmtDQTIKa+VJmwIvmVQdF3MNDC0JzycOTfqMcApsK5T7F2AZ46eNF7hJXRmshuLfOuKLjjRtPVQuFb5Eyx+3xAL8icoHDDzIJmaa+hX0zmzReJXoXFSS6QH1J/EgP5KC7egA4sROJunhB90kg3MJg+Aqhyzgc0DsvPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M+3aMTK7; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714984925; x=1746520925;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W9uxdBNPrzw8IEk83hy6OSC8VkEIk5v/qxhXr1JHaQw=;
  b=M+3aMTK77XC0pgW2t29XMEpMLZRo2X43nYwTlfM0LY8L7trkXtALz5CD
   2eL3+UkVbSe6c6fcey05mHd0PqWIyjzgkhuPfTwvygW2q0XR4RvJMtYNv
   3XucF1qvI03bTJ3ISxelpcx6U2tOFZuC9lLRlfEf4GZkvYfIMNArMUAJz
   Z8NUwEhwaqUPODCOD0BXxjdYsRZ7O9Ga71bl8MQGgheNjywosyTetdHDe
   rzl06kxO19BKvaejdYC1s/A78UaM8RRsNdEBOMCZUda5UbdECfvrTFXzP
   9pJZtLx97XXZB+FWvjvF6WlQIT8pdK3ICDFqGaH80vxmQzZ8GwhHS9eOA
   Q==;
X-CSE-ConnectionGUID: W3cRnlMXTCKM6RW0SQgvHQ==
X-CSE-MsgGUID: l0vyIO0CSreSXlHyiwtXDQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="14505077"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="14505077"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 01:42:05 -0700
X-CSE-ConnectionGUID: WIbooOaQRKaM75ePqTWeRQ==
X-CSE-MsgGUID: F4/gOcJ9TyKy8Qvebu0PxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="28050134"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa009.fm.intel.com with ESMTP; 06 May 2024 01:42:02 -0700
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
Subject: [iwl-next v2 1/4] ice: store representor ID in bridge port
Date: Mon,  6 May 2024 10:46:50 +0200
Message-ID: <20240506084653.532111-2-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240506084653.532111-1-michal.swiatkowski@linux.intel.com>
References: <20240506084653.532111-1-michal.swiatkowski@linux.intel.com>
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


