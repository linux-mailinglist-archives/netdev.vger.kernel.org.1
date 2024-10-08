Return-Path: <netdev+bounces-133366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E53D995BC1
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18F881F25ADB
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825732194AC;
	Tue,  8 Oct 2024 23:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NM+wPD9M"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB39F218D7C
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 23:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728430496; cv=none; b=ClSzfb5HArRd8Xo9d0HogsalD60JY/5+JWa8XwpieqE4AjUEcNWH2UTH8cjY08d0B5soqt1GogJMAjY4NspTGUGOA1zRkhCcWz6pe+pmvp7nIF/fYNs4q+7PTsDSFlkIGniZx6hbGev/+LYXMGCWf6F74cndgbuw6JTrnPy2ENQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728430496; c=relaxed/simple;
	bh=bkEu2Y2Cd/v8lKBtaWIqWNfJOSRFirgagbgf6bUbiCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XqedG1djdUzs53ehDyR/42oCkw15EmKGDQHcbjA41acwgv7AbMH3yT/UO2Mmtsvwb8jOcnbIDxvOUK17AuSXj/VRrYdQ/+zwFcPURlueP3lBCO7x7xKM4iRtraDWM/ZgPij8lSbSn8FmiSHyGMfzFvA95I/zkGhXXZns2ZRU1wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NM+wPD9M; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728430494; x=1759966494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bkEu2Y2Cd/v8lKBtaWIqWNfJOSRFirgagbgf6bUbiCM=;
  b=NM+wPD9MfXfkyW3cFt/qO+qCVjidzdEEL4jP5jMstotnEYlA0jlSLKO/
   8K5mIb/gXePUw7HZcY7qRRoj18J+yVufZfTL5qNVKRznmrHhqXFuniUcI
   wfwGUUZTyzNIQMTLTLcz98A4I5qxLgoMrsOXEhNATjp5mxFhWGW+6EuTy
   Bc6/IVyiIBE7YWcJ9dpXFMTUYDN4q8yzzHvZsQR7Y59ijQQY8KBrmPQQ9
   7p0qf+fSl0RcgF1FkLJV6SLT82tGm8WZTN3iibfonC8iZ0b6u3t7SBDZS
   gs4vz4zO1Kqsu0Yb+iDuo/mdiiYB8h+dEDhx9ijVyMC+33FF+OnKKJYGf
   g==;
X-CSE-ConnectionGUID: tYbCPK5rSAuBfIwML0pGdA==
X-CSE-MsgGUID: EllPxnu5QAaFYQNZGco9jg==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27779900"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="27779900"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 16:34:49 -0700
X-CSE-ConnectionGUID: Jtv3ztWRS8eSsugPIe4/iQ==
X-CSE-MsgGUID: GgEPfjGBRCqYGwwjrVoJeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="106794197"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 08 Oct 2024 16:34:49 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Yue Haibing <yuehaibing@huawei.com>,
	anthony.l.nguyen@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH net-next 07/12] ice: Cleanup unused declarations
Date: Tue,  8 Oct 2024 16:34:33 -0700
Message-ID: <20241008233441.928802-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241008233441.928802-1-anthony.l.nguyen@intel.com>
References: <20241008233441.928802-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yue Haibing <yuehaibing@huawei.com>

Since commit fff292b47ac1 ("ice: add VF representors one by one")
ice_eswitch_configure() is not used anymore.
Commit 1b8f15b64a00 ("ice: refactor filter functions") removed
ice_vsi_cfg_mac_fltr() but leave declaration.
Commit a24b4c6e9aab ("ice: xsk: Do not convert to buff to frame for
XDP_TX") leave ice_xmit_xdp_buff() declaration.

Commit 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C
products") declared ice_phy_cfg_{rx,tx}_offset_eth56g(),
commit a1ffafb0b4a4 ("ice: Support configuring the device to Double
VLAN Mode") declared ice_pkg_buf_get_free_space(), and
commit 8a3a565ff210 ("ice: add admin commands to access cgu
configuration") declared ice_is_pca9575_present(), but all these never
be implemented.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_eswitch.h   | 5 -----
 drivers/net/ethernet/intel/ice/ice_flex_pipe.h | 3 ---
 drivers/net/ethernet/intel/ice/ice_lib.h       | 2 --
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h    | 3 ---
 drivers/net/ethernet/intel/ice/ice_txrx_lib.h  | 1 -
 5 files changed, 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_eswitch.h b/drivers/net/ethernet/intel/ice/ice_eswitch.h
index 20ce32dda69c..ac7db100e2cd 100644
--- a/drivers/net/ethernet/intel/ice/ice_eswitch.h
+++ b/drivers/net/ethernet/intel/ice/ice_eswitch.h
@@ -60,11 +60,6 @@ ice_eswitch_set_target_vsi(struct sk_buff *skb,
 static inline void
 ice_eswitch_update_repr(unsigned long *repr_id, struct ice_vsi *vsi) { }
 
-static inline int ice_eswitch_configure(struct ice_pf *pf)
-{
-	return 0;
-}
-
 static inline int ice_eswitch_mode_get(struct devlink *devlink, u16 *mode)
 {
 	return DEVLINK_ESWITCH_MODE_LEGACY;
diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.h b/drivers/net/ethernet/intel/ice/ice_flex_pipe.h
index 90b9b0993122..28b0897adf32 100644
--- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.h
+++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.h
@@ -23,9 +23,6 @@ int
 ice_get_sw_fv_list(struct ice_hw *hw, struct ice_prot_lkup_ext *lkups,
 		   unsigned long *bm, struct list_head *fv_list);
 int
-ice_pkg_buf_unreserve_section(struct ice_buf_build *bld, u16 count);
-u16 ice_pkg_buf_get_free_space(struct ice_buf_build *bld);
-int
 ice_aq_upload_section(struct ice_hw *hw, struct ice_buf_hdr *pkg_buf,
 		      u16 buf_size, struct ice_sq_cd *cd);
 bool
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 1a6cfc8693ce..10d6fc479a32 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -88,8 +88,6 @@ void ice_write_intrl(struct ice_q_vector *q_vector, u8 intrl);
 void ice_write_itr(struct ice_ring_container *rc, u16 itr);
 void ice_set_q_vector_intrl(struct ice_q_vector *q_vector);
 
-int ice_vsi_cfg_mac_fltr(struct ice_vsi *vsi, const u8 *macaddr, bool set);
-
 bool ice_is_safe_mode(struct ice_pf *pf);
 bool ice_is_rdma_ena(struct ice_pf *pf);
 bool ice_is_dflt_vsi_in_use(struct ice_port_info *pi);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 1a61d4826271..656daff3447e 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -405,7 +405,6 @@ int ice_phy_cfg_intr_e82x(struct ice_hw *hw, u8 quad, bool ena, u8 threshold);
 int ice_read_sma_ctrl(struct ice_hw *hw, u8 *data);
 int ice_write_sma_ctrl(struct ice_hw *hw, u8 data);
 int ice_read_pca9575_reg(struct ice_hw *hw, u8 offset, u8 *data);
-bool ice_is_pca9575_present(struct ice_hw *hw);
 int ice_ptp_read_sdp_ac(struct ice_hw *hw, __le16 *entries, uint *num_entries);
 enum dpll_pin_type ice_cgu_get_pin_type(struct ice_hw *hw, u8 pin, bool input);
 struct dpll_pin_frequency *
@@ -423,8 +422,6 @@ int ice_cgu_get_output_pin_state_caps(struct ice_hw *hw, u8 pin_id,
 int ice_ptp_read_tx_hwtstamp_status_eth56g(struct ice_hw *hw, u32 *ts_status);
 int ice_stop_phy_timer_eth56g(struct ice_hw *hw, u8 port, bool soft_reset);
 int ice_start_phy_timer_eth56g(struct ice_hw *hw, u8 port);
-int ice_phy_cfg_tx_offset_eth56g(struct ice_hw *hw, u8 port);
-int ice_phy_cfg_rx_offset_eth56g(struct ice_hw *hw, u8 port);
 int ice_phy_cfg_intr_eth56g(struct ice_hw *hw, u8 port, bool ena, u8 threshold);
 int ice_phy_cfg_ptp_1step_eth56g(struct ice_hw *hw, u8 port);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
index afcead4baef4..79f960c6680d 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
@@ -154,7 +154,6 @@ static inline u32 ice_set_rs_bit(const struct ice_tx_ring *xdp_ring)
 }
 
 void ice_finalize_xdp_rx(struct ice_tx_ring *xdp_ring, unsigned int xdp_res, u32 first_idx);
-int ice_xmit_xdp_buff(struct xdp_buff *xdp, struct ice_tx_ring *xdp_ring);
 int __ice_xmit_xdp_ring(struct xdp_buff *xdp, struct ice_tx_ring *xdp_ring,
 			bool frame);
 void ice_release_rx_desc(struct ice_rx_ring *rx_ring, u16 val);
-- 
2.42.0


