Return-Path: <netdev+bounces-151248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A10529EDA0B
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 23:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 542F8280AB1
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 22:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54578204C38;
	Wed, 11 Dec 2024 22:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jw0sBUcY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2894B2046A6
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 22:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956366; cv=none; b=B84FYue8OTtCvqSvrx4o8YHS0w0ME3/eYjTzXnjTwydx13tmJ2GYpeIpDvu1UWMNiagHOeH+DOh8P5kUT6uMgtuQQH85hyzmO3kqVLoS2tVbFScwF8bazoj2Y/GgsWIFr6XiQEIvLjqhqM9h3BBE/6M4GmeaJ08dCq2UvsjCIrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956366; c=relaxed/simple;
	bh=Btbce94nYPEGod4BC7F/cbhBgqtefqG66pIe6Ym/Sqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OX6HRwCR0vfChRZwW4LPmjwDHMhwOaes9oDmqXQ0FyZ6RMS0x5vTzRA2Zh8XtgHFjPSatR3mTRPCHDX1gtw7W8zAEiwem7Rg+ZA+8w2zrei9CPi9CsQ1AXbWftdHvfGOtr46RrL/F8T+PGNS8S2H8OFz6pMKGl/PdOvvXhXOIvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jw0sBUcY; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733956364; x=1765492364;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Btbce94nYPEGod4BC7F/cbhBgqtefqG66pIe6Ym/Sqo=;
  b=Jw0sBUcYKwXzd5IdWdvJEhTOyXG4eyuopzExCc4JgrP+f7pZudv5x/zH
   gpO5+6cIfszshgOuWlEjuGw06AisUYv5ywND95wnm3NexI7VY6MvWKQCm
   SYyX6BqS/ALxRb1H8+SB6sesvz+d4W2eiCUUMVvkDAJPPqXE7k4Epbq4T
   zpU4g3ZNSB57OY+QHyc+R5vMcyQC5O2DLpS8+0mY+6uzVFSBCyNfL7wkc
   nLcuQ+l1G4Q3hjkRqEGO4M+5BzynpTOZx2HhpRlOAJj9zS+tt6AN4OoFa
   +4w1lAckErzQQaEqeeIahwsqHgkTgcHoA3jIm/q2lrYQIBx/wGmm28peZ
   w==;
X-CSE-ConnectionGUID: VsM1WWa8R4ysXMc16Xoy1A==
X-CSE-MsgGUID: CsloYDMKQxCKYR7ogiMJSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34599663"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="34599663"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 14:32:41 -0800
X-CSE-ConnectionGUID: +R/ALqBNQX2vc8S1xv6kdQ==
X-CSE-MsgGUID: Ix+EB42YTZmylwhr/NgloQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="96192952"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa008.fm.intel.com with ESMTP; 11 Dec 2024 14:32:41 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Ben Shelton <benjamin.h.shelton@intel.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	wojciech.drewek@intel.com,
	mateusz.polchlopek@intel.com,
	joe@perches.com,
	horms@kernel.org,
	jiri@resnulli.us,
	apw@canonical.com,
	lukas.bulwahn@gmail.com,
	dwaipayanray1@gmail.com,
	Igor Bagnucki <igor.bagnucki@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net-next 7/7] ice: Add MDD logging via devlink health
Date: Wed, 11 Dec 2024 14:32:15 -0800
Message-ID: <20241211223231.397203-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241211223231.397203-1-anthony.l.nguyen@intel.com>
References: <20241211223231.397203-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ben Shelton <benjamin.h.shelton@intel.com>

Add a devlink health reporter for MDD events. The 'dump' handler will
return the information captured in each call to ice_handle_mdd_event().
A device reset (CORER/PFR) will put the reporter back in healthy state.

Signed-off-by: Ben Shelton <benjamin.h.shelton@intel.com>
Reviewed-by: Igor Bagnucki <igor.bagnucki@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Co-developed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../net/ethernet/intel/ice/devlink/health.c   | 77 +++++++++++++++++++
 .../net/ethernet/intel/ice/devlink/health.h   | 11 +++
 drivers/net/ethernet/intel/ice/ice_main.c     |  6 ++
 3 files changed, 94 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/devlink/health.c b/drivers/net/ethernet/intel/ice/devlink/health.c
index b0abb6d4e3e4..d9b852ccf99e 100644
--- a/drivers/net/ethernet/intel/ice/devlink/health.c
+++ b/drivers/net/ethernet/intel/ice/devlink/health.c
@@ -27,6 +27,79 @@ static void ice_devlink_health_report(struct devlink_health_reporter *reporter,
 	devlink_health_report(reporter, msg, priv_ctx);
 }
 
+struct ice_mdd_event {
+	enum ice_mdd_src src;
+	u16 vf_num;
+	u16 queue;
+	u8 pf_num;
+	u8 event;
+};
+
+static const char *ice_mdd_src_to_str(enum ice_mdd_src src)
+{
+	switch (src) {
+	case ICE_MDD_SRC_TX_PQM:
+		return "tx_pqm";
+	case ICE_MDD_SRC_TX_TCLAN:
+		return "tx_tclan";
+	case ICE_MDD_SRC_TX_TDPU:
+		return "tx_tdpu";
+	case ICE_MDD_SRC_RX:
+		return "rx";
+	default:
+		return "invalid";
+	}
+}
+
+static int
+ice_mdd_reporter_dump(struct devlink_health_reporter *reporter,
+		      struct devlink_fmsg *fmsg, void *priv_ctx,
+		      struct netlink_ext_ack *extack)
+{
+	struct ice_mdd_event *mdd_event = priv_ctx;
+	const char *src;
+
+	if (!mdd_event)
+		return 0;
+
+	src = ice_mdd_src_to_str(mdd_event->src);
+
+	devlink_fmsg_obj_nest_start(fmsg);
+	devlink_fmsg_put(fmsg, "src", src);
+	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, mdd_event, pf_num);
+	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, mdd_event, vf_num);
+	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, mdd_event, event);
+	ICE_DEVLINK_FMSG_PUT_FIELD(fmsg, mdd_event, queue);
+	devlink_fmsg_obj_nest_end(fmsg);
+
+	return 0;
+}
+
+/**
+ * ice_report_mdd_event - Report an MDD event through devlink health
+ * @pf: the PF device structure
+ * @src: the HW block that was the source of this MDD event
+ * @pf_num: the pf_num on which the MDD event occurred
+ * @vf_num: the vf_num on which the MDD event occurred
+ * @event: the event type of the MDD event
+ * @queue: the queue on which the MDD event occurred
+ *
+ * Report an MDD event that has occurred on this PF.
+ */
+void ice_report_mdd_event(struct ice_pf *pf, enum ice_mdd_src src, u8 pf_num,
+			  u16 vf_num, u8 event, u16 queue)
+{
+	struct ice_mdd_event ev = {
+		.src = src,
+		.pf_num = pf_num,
+		.vf_num = vf_num,
+		.event = event,
+		.queue = queue,
+	};
+
+	ice_devlink_health_report(pf->health_reporters.mdd, "MDD event", &ev);
+}
+
 static void ice_dump_ethtool_stats_to_fmsg(struct devlink_fmsg *fmsg,
 					   struct net_device *netdev)
 {
@@ -168,6 +241,7 @@ ice_init_devlink_rep(struct ice_pf *pf,
 	.dump = ice_ ## _name ## _reporter_dump, \
 }
 
+ICE_DEFINE_HEALTH_REPORTER_OPS(mdd);
 ICE_DEFINE_HEALTH_REPORTER_OPS(tx_hang);
 
 /**
@@ -180,6 +254,7 @@ void ice_health_init(struct ice_pf *pf)
 {
 	struct ice_health *reps = &pf->health_reporters;
 
+	reps->mdd = ice_init_devlink_rep(pf, &ice_mdd_reporter_ops);
 	reps->tx_hang = ice_init_devlink_rep(pf, &ice_tx_hang_reporter_ops);
 }
 
@@ -201,6 +276,7 @@ static void ice_deinit_devl_reporter(struct devlink_health_reporter *reporter)
  */
 void ice_health_deinit(struct ice_pf *pf)
 {
+	ice_deinit_devl_reporter(pf->health_reporters.mdd);
 	ice_deinit_devl_reporter(pf->health_reporters.tx_hang);
 }
 
@@ -220,5 +296,6 @@ void ice_health_assign_healthy_state(struct devlink_health_reporter *reporter)
  */
 void ice_health_clear(struct ice_pf *pf)
 {
+	ice_health_assign_healthy_state(pf->health_reporters.mdd);
 	ice_health_assign_healthy_state(pf->health_reporters.tx_hang);
 }
diff --git a/drivers/net/ethernet/intel/ice/devlink/health.h b/drivers/net/ethernet/intel/ice/devlink/health.h
index 92e40d790e72..a08c7bd174cf 100644
--- a/drivers/net/ethernet/intel/ice/devlink/health.h
+++ b/drivers/net/ethernet/intel/ice/devlink/health.h
@@ -16,9 +16,17 @@
 struct ice_pf;
 struct ice_tx_ring;
 
+enum ice_mdd_src {
+	ICE_MDD_SRC_TX_PQM,
+	ICE_MDD_SRC_TX_TCLAN,
+	ICE_MDD_SRC_TX_TDPU,
+	ICE_MDD_SRC_RX,
+};
+
 /**
  * struct ice_health - stores ice devlink health reporters and accompanied data
  * @tx_hang: devlink health reporter for tx_hang event
+ * @mdd: devlink health reporter for MDD detection event
  * @tx_hang_buf: pre-allocated place to put info for Tx hang reporter from
  *               non-sleeping context
  * @tx_ring: ring that the hang occured on
@@ -27,6 +35,7 @@ struct ice_tx_ring;
  * @vsi_num: VSI owning the queue that the hang occured on
  */
 struct ice_health {
+	struct devlink_health_reporter *mdd;
 	struct devlink_health_reporter *tx_hang;
 	struct_group_tagged(ice_health_tx_hang_buf, tx_hang_buf,
 		struct ice_tx_ring *tx_ring;
@@ -43,6 +52,8 @@ void ice_health_clear(struct ice_pf *pf);
 
 void ice_prep_tx_hang_report(struct ice_pf *pf, struct ice_tx_ring *tx_ring,
 			     u16 vsi_num, u32 head, u32 intr);
+void ice_report_mdd_event(struct ice_pf *pf, enum ice_mdd_src src, u8 pf_num,
+			  u16 vf_num, u8 event, u16 queue);
 void ice_report_tx_hang(struct ice_pf *pf);
 
 #endif /* _HEALTH_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 316f5109bd3f..1701f7143f24 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1816,6 +1816,8 @@ static void ice_handle_mdd_event(struct ice_pf *pf)
 		if (netif_msg_tx_err(pf))
 			dev_info(dev, "Malicious Driver Detection event %d on TX queue %d PF# %d VF# %d\n",
 				 event, queue, pf_num, vf_num);
+		ice_report_mdd_event(pf, ICE_MDD_SRC_TX_PQM, pf_num, vf_num,
+				     event, queue);
 		wr32(hw, GL_MDET_TX_PQM, 0xffffffff);
 	}
 
@@ -1829,6 +1831,8 @@ static void ice_handle_mdd_event(struct ice_pf *pf)
 		if (netif_msg_tx_err(pf))
 			dev_info(dev, "Malicious Driver Detection event %d on TX queue %d PF# %d VF# %d\n",
 				 event, queue, pf_num, vf_num);
+		ice_report_mdd_event(pf, ICE_MDD_SRC_TX_TCLAN, pf_num, vf_num,
+				     event, queue);
 		wr32(hw, GL_MDET_TX_TCLAN_BY_MAC(hw), U32_MAX);
 	}
 
@@ -1842,6 +1846,8 @@ static void ice_handle_mdd_event(struct ice_pf *pf)
 		if (netif_msg_rx_err(pf))
 			dev_info(dev, "Malicious Driver Detection event %d on RX queue %d PF# %d VF# %d\n",
 				 event, queue, pf_num, vf_num);
+		ice_report_mdd_event(pf, ICE_MDD_SRC_RX, pf_num, vf_num, event,
+				     queue);
 		wr32(hw, GL_MDET_RX, 0xffffffff);
 	}
 
-- 
2.42.0


