Return-Path: <netdev+bounces-137521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89669A6C0B
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 16:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84AD4282340
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 14:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEA91FA26C;
	Mon, 21 Oct 2024 14:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CNljoHx8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85031FA248;
	Mon, 21 Oct 2024 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729520688; cv=none; b=nDnfkMlNMimGuBo4t0sP6s5ezpimUiSgymMCItxAYewrWIDWh1WlQE+Xp57+2oehH3/ekijsPyGRKDGgF5ynbzUw08nsTjsjfBglqRTafi5uL6RHs9thcIwYq3IlVeLLeO4EeyNstOpRaxPmgSyWj035uVUAcD+xXO76NoOyoy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729520688; c=relaxed/simple;
	bh=J909dl2X+WM6p84dhJEZhnAALeM6t0I3u1+vHBG9F9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=abmzDYUf+GdFdXwBPzKs4bye2fM7jNKE+A5v96UMfLFMeg7QPClYQg18JHyd6yzuZbVLZVRzaNDR9qb0fKu57orvbi0OSQjL4XsxBR6JmRfHPtYrkANwjTZMveQGtTHVR5n/HyN/DGeADmYq3QKQ/2OBBIgblg0vsZ+LYvJXSx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CNljoHx8; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729520686; x=1761056686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J909dl2X+WM6p84dhJEZhnAALeM6t0I3u1+vHBG9F9k=;
  b=CNljoHx8c3ROJLbRp9UpXpoF69GEoOfpZ9/H4dZeWoC3LUEB4wwGOf0f
   3ZXhYYpsoO8qccTNVUG76nzHonx9B5qUtyVaj+uwK/QHWIIHVVDNEuW3a
   Du8hQI79yGIlGx53mauYbtjY4Z/t958VkBmmBwiWC6Jz7SoOKWNtggdZL
   CGSvQuxacBN4okwnrgP4sLBygHp3JFhJaGb5eR434qKYK40JXzXKMZc5L
   DGCZGFWjRnsoeQbI/PHFeoxq34SuCOuArZNxPsRpFvyOwIAzoaXF+Tk7v
   uq63VknGZBV1o2HeL1QeoC8LoNw2QHMfpgEjL+12w/OQXFo7+6TCv8o5Z
   g==;
X-CSE-ConnectionGUID: 0os4PSCeRhaw/aD/Hn2keA==
X-CSE-MsgGUID: CVUQdE/fToCg+bxsXaUA/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28781499"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28781499"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 07:24:46 -0700
X-CSE-ConnectionGUID: yt24rj3ZQumqjdvCb+ZENQ==
X-CSE-MsgGUID: UufQ8RWnQGKIEJ3mQrHtpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="102857345"
Received: from amlin-018-114.igk.intel.com ([10.102.18.114])
  by fmviesa002.fm.intel.com with ESMTP; 21 Oct 2024 07:24:43 -0700
From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next 2/2] ice: ptp: add control over HW timestamp latch point
Date: Mon, 21 Oct 2024 16:19:55 +0200
Message-Id: <20241021141955.1466979-3-arkadiusz.kubalewski@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241021141955.1466979-1-arkadiusz.kubalewski@intel.com>
References: <20241021141955.1466979-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow user to control the latch point of ptp HW timestamps in E825
devices.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp.c    | 46 +++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 57 +++++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h |  2 +
 3 files changed, 105 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
index a999fface272..47444412ed9a 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
@@ -2509,6 +2509,50 @@ static int ice_ptp_parse_sdp_entries(struct ice_pf *pf, __le16 *entries,
 	return 0;
 }
 
+/**
+ * ice_get_ts_point - get the tx timestamp latch point
+ * @info: the driver's PTP info structure
+ * @point: return the configured tx timestamp latch point
+ *
+ * Return: 0 on success, negative on failure.
+ */
+static int
+ice_get_ts_point(struct ptp_clock_info *info, enum ptp_ts_point *point)
+{
+	struct ice_pf *pf = ptp_info_to_pf(info);
+	struct ice_hw *hw = &pf->hw;
+	bool sfd_ena;
+	int ret;
+
+	ice_ptp_lock(hw);
+	ret = ice_ptp_hw_ts_point_get(hw, &sfd_ena);
+	ice_ptp_unlock(hw);
+	if (!ret)
+		*point = sfd_ena ? PTP_TS_POINT_SFD : PTP_TS_POINT_POST_SFD;
+
+	return ret;
+}
+
+/**
+ * ice_set_ts_point - set the tx timestamp latch point
+ * @info: the driver's PTP info structure
+ * @point: requested tx timestamp latch point
+ */
+static int
+ice_set_ts_point(struct ptp_clock_info *info, enum ptp_ts_point point)
+{
+	bool sfd_ena = point == PTP_TS_POINT_SFD ? true : false;
+	struct ice_pf *pf = ptp_info_to_pf(info);
+	struct ice_hw *hw = &pf->hw;
+	int ret;
+
+	ice_ptp_lock(hw);
+	ret = ice_ptp_hw_ts_point_set(hw, sfd_ena);
+	ice_ptp_unlock(hw);
+
+	return ret;
+}
+
 /**
  * ice_ptp_set_funcs_e82x - Set specialized functions for E82X support
  * @pf: Board private structure
@@ -2529,6 +2573,8 @@ static void ice_ptp_set_funcs_e82x(struct ice_pf *pf)
 	if (ice_is_e825c(&pf->hw)) {
 		pf->ptp.ice_pin_desc = ice_pin_desc_e825c;
 		pf->ptp.info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e825c);
+		pf->ptp.info.set_ts_point = ice_set_ts_point;
+		pf->ptp.info.get_ts_point = ice_get_ts_point;
 	} else {
 		pf->ptp.ice_pin_desc = ice_pin_desc_e82x;
 		pf->ptp.info.n_pins = ICE_PIN_DESC_ARR_LEN(ice_pin_desc_e82x);
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index da88c6ccfaeb..d81525bc8a16 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -6303,3 +6303,60 @@ int ice_cgu_get_output_pin_state_caps(struct ice_hw *hw, u8 pin_id,
 
 	return 0;
 }
+
+/**
+ * ice_ptp_hw_ts_point_get - check if tx timestamping is latched on/post SFD
+ * @hw: pointer to the HW struct
+ * @sfd_ena: on success true if tx timestamping latched at beginning of SFD,
+ *	false if post sfd
+ *
+ * Verify if HW timestamping point is configured to measure at the beginning or
+ * post of SFD (Start of Frame Delimiter)
+ *
+ * Return: 0 on success, negative on error
+ */
+int ice_ptp_hw_ts_point_get(struct ice_hw *hw, bool *sfd_ena)
+{
+	u8 port = hw->port_info->lport;
+	u32 val;
+	int err;
+
+	err = ice_read_mac_reg_eth56g(hw, port, PHY_MAC_XIF_MODE, &val);
+	if (err)
+		return err;
+	if (val | PHY_MAC_XIF_TS_SFD_ENA_M)
+		*sfd_ena = true;
+	else
+		*sfd_ena = false;
+
+	return err;
+}
+
+/**
+ * ice_ptp_hw_ts_point_set - configure timestamping on/post SFD
+ * @hw: pointer to the HW struct
+ * @sfd_ena: true to enable timestamping at beginning of SFD, false post sfd
+ *
+ * Configure timestamping to measure at the beginning/post SFD (Start of Frame
+ * Delimiter)
+ *
+ * Return: 0 on success, negative on error
+ */
+int ice_ptp_hw_ts_point_set(struct ice_hw *hw, bool sfd_ena)
+{
+	u8 port = hw->port_info->lport;
+	int err, val;
+
+	err = ice_read_mac_reg_eth56g(hw, port, PHY_MAC_XIF_MODE, &val);
+	if (err)
+		return err;
+	if ((val | PHY_MAC_XIF_TS_SFD_ENA_M && sfd_ena) ||
+	    (!(val | PHY_MAC_XIF_TS_SFD_ENA_M) && !sfd_ena))
+		return -EINVAL;
+	if (sfd_ena)
+		val |= PHY_MAC_XIF_TS_SFD_ENA_M;
+	else
+		val &= ~PHY_MAC_XIF_TS_SFD_ENA_M;
+
+	return ice_write_mac_reg_eth56g(hw, port, PHY_MAC_XIF_MODE, val);
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 656daff3447e..cefedd01479a 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -348,6 +348,8 @@ void ice_ptp_init_hw(struct ice_hw *hw);
 int ice_get_phy_tx_tstamp_ready(struct ice_hw *hw, u8 block, u64 *tstamp_ready);
 int ice_ptp_one_port_cmd(struct ice_hw *hw, u8 configured_port,
 			 enum ice_ptp_tmr_cmd configured_cmd);
+int ice_ptp_hw_ts_point_get(struct ice_hw *hw, bool *sfd_ena);
+int ice_ptp_hw_ts_point_set(struct ice_hw *hw, bool sfd_ena);
 
 /* E822 family functions */
 int ice_read_quad_reg_e82x(struct ice_hw *hw, u8 quad, u16 offset, u32 *val);
-- 
2.38.1


