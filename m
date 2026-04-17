Return-Path: <netdev+bounces-279191-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HzvLlyF4WkiuQAAu9opvQ
	(envelope-from <netdev+bounces-279191-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 02:57:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4CA415E33
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 02:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BBE63095490
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 00:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005E2213254;
	Fri, 17 Apr 2026 00:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0yTWfvg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10A023ABBF
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 00:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776387275; cv=none; b=FE4b0Z57lGnn9ucjWbWo3U9yneFl02+t62ea0MkDlNr8/GDypjx1WHIcuWjJYFAr4d2Z/L+D29dtjHo0ln1ZSVphM5OFsP5bi4w44GanHRnuy1lRd9mtAtfbrMOCn0O4CLhqM4ek0pmLcoK8E2H1uum1itVaKsX5hKmAr4CXDMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776387275; c=relaxed/simple;
	bh=z5F0QGWb8jEVuZutFWkDOpEedzM8CrAJYLNmJb6asVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kbTF6ezOCMQexg5LFSlM1yR6/DRO75wmpMNSGDqNdRUBVGLUvW2pb0pJHTkq+41h+amuN7L3VaRTKYmNtFfCVjkH4kL9Obv9Fun0Kk30PatpgIkRgEx7TTalzY2mBQyhZkP7AFHTh5RqcfvfmKbZ9qt0XzHd0JjjdteixPk37HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e0yTWfvg; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776387274; x=1807923274;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=z5F0QGWb8jEVuZutFWkDOpEedzM8CrAJYLNmJb6asVE=;
  b=e0yTWfvgdu2OvIP47qus3+r0pU1aDgKf/P1VSdJWz6UWnI5UfgMsmjqY
   U5lYng9/DUJDQ6cNLbuUk/tzajBCaxZga8L3yq4D8qctQDvUSc6WcXEfa
   spMOBYOFo2poq5h7e+iN+9athwfo5Wc3BFLW7rl3pv2Tl0X3aoMZwVTMG
   4BhUlWNm0hNVaAPr2uAs+PuhUDrKtdS/jXlNsZ3Dce+PBk9Sv4FUCOzCK
   zPvHqRdN0JpsOrWuHlXUO2dAo6SlRwz6ugdUMzYsLBGeSTor8a2K6m+eR
   Zieov7dZSIC5451uVxNja289xwQAJuKabPUff4w1KCMahBeB2pqvI+2Xr
   w==;
X-CSE-ConnectionGUID: MaYccvaURc+M4+RGEw/UEQ==
X-CSE-MsgGUID: mm4yQ53OSI6IFFnYApXNLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="81000541"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="81000541"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 17:54:30 -0700
X-CSE-ConnectionGUID: wRiN0Vn2StGerdeGMPAhCA==
X-CSE-MsgGUID: ojVCK7/PSOmOUUwULjz1sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226539869"
Received: from orcnseosdtjek.jf.intel.com (HELO [10.166.28.109]) ([10.166.28.109])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 17:54:29 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 16 Apr 2026 17:53:29 -0700
Subject: [PATCH net v2 05/12] ice: fix PHY config on media change with
 link-down-on-close
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-iwl-net-submission-2026-04-14-v2-5-686c33c9828d@intel.com>
References: <20260416-iwl-net-submission-2026-04-14-v2-0-686c33c9828d@intel.com>
In-Reply-To: <20260416-iwl-net-submission-2026-04-14-v2-0-686c33c9828d@intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>, 
 Paul Greenwalt <paul.greenwalt@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Sunitha Mekala <sunithax.d.mekala@intel.com>
X-Mailer: b4 0.16-dev-ea14f
X-Developer-Signature: v=1; a=openpgp-sha256; l=7992;
 i=jacob.e.keller@intel.com; h=from:subject:message-id;
 bh=6MFJKUktChwZJwW9IUaa/7v/fXGr94BbRlUcZQA8gJ8=;
 b=owGbwMvMwCWWNS3WLp9f4wXjabUkhsyHLYeWVS5Ouy/4xibMpccx5ModiR+mn+Yy/eq5khCT6
 FYmOUWko5SFQYyLQVZMkUXBIWTldeMJYVpvnOVg5rAygQxh4OIUgIl0/WFkmCCWP1UhQCTirlLV
 hZ29hpzn8vSV2znbjBx0DvSqc+kGMTLc4DvfuOn/WuZlD56cuGj3f+PSrMi5ZbZ2Au6zD1o9S5/
 IDwA=
X-Developer-Key: i=jacob.e.keller@intel.com; a=openpgp;
 fpr=204054A9D73390562AEC431E6A965D3E6F0F28E8
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279191-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F4CA415E33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Paul Greenwalt <paul.greenwalt@intel.com>

Commit 1a3571b5938c ("ice: restore PHY settings on media insertion")
introduced separate flows for setting PHY configuration on media
present: ice_configure_phy() when link-down-on-close is disabled, and
ice_force_phys_link_state() when enabled. The latter incorrectly uses
the previous configuration even after module change, causing link
issues such as wrong speed or no link.

Unify PHY configuration into a single ice_phy_cfg() function with a
link_en parameter, ensuring PHY capabilities are always fetched fresh
from hardware.

Fixes: 1a3571b5938c ("ice: restore PHY settings on media insertion")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Sunitha Mekala <sunithax.d.mekala@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 121 +++++++-----------------------
 1 file changed, 27 insertions(+), 94 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 3c36e3641b9e..ce3a0afe302d 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -1922,82 +1922,6 @@ static void ice_handle_mdd_event(struct ice_pf *pf)
 	ice_print_vfs_mdd_events(pf);
 }
 
-/**
- * ice_force_phys_link_state - Force the physical link state
- * @vsi: VSI to force the physical link state to up/down
- * @link_up: true/false indicates to set the physical link to up/down
- *
- * Force the physical link state by getting the current PHY capabilities from
- * hardware and setting the PHY config based on the determined capabilities. If
- * link changes a link event will be triggered because both the Enable Automatic
- * Link Update and LESM Enable bits are set when setting the PHY capabilities.
- *
- * Returns 0 on success, negative on failure
- */
-static int ice_force_phys_link_state(struct ice_vsi *vsi, bool link_up)
-{
-	struct ice_aqc_get_phy_caps_data *pcaps;
-	struct ice_aqc_set_phy_cfg_data *cfg;
-	struct ice_port_info *pi;
-	struct device *dev;
-	int retcode;
-
-	if (!vsi || !vsi->port_info || !vsi->back)
-		return -EINVAL;
-	if (vsi->type != ICE_VSI_PF)
-		return 0;
-
-	dev = ice_pf_to_dev(vsi->back);
-
-	pi = vsi->port_info;
-
-	pcaps = kzalloc_obj(*pcaps);
-	if (!pcaps)
-		return -ENOMEM;
-
-	retcode = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_ACTIVE_CFG, pcaps,
-				      NULL);
-	if (retcode) {
-		dev_err(dev, "Failed to get phy capabilities, VSI %d error %d\n",
-			vsi->vsi_num, retcode);
-		retcode = -EIO;
-		goto out;
-	}
-
-	/* No change in link */
-	if (link_up == !!(pcaps->caps & ICE_AQC_PHY_EN_LINK) &&
-	    link_up == !!(pi->phy.link_info.link_info & ICE_AQ_LINK_UP))
-		goto out;
-
-	/* Use the current user PHY configuration. The current user PHY
-	 * configuration is initialized during probe from PHY capabilities
-	 * software mode, and updated on set PHY configuration.
-	 */
-	cfg = kmemdup(&pi->phy.curr_user_phy_cfg, sizeof(*cfg), GFP_KERNEL);
-	if (!cfg) {
-		retcode = -ENOMEM;
-		goto out;
-	}
-
-	cfg->caps |= ICE_AQ_PHY_ENA_AUTO_LINK_UPDT;
-	if (link_up)
-		cfg->caps |= ICE_AQ_PHY_ENA_LINK;
-	else
-		cfg->caps &= ~ICE_AQ_PHY_ENA_LINK;
-
-	retcode = ice_aq_set_phy_cfg(&vsi->back->hw, pi, cfg, NULL);
-	if (retcode) {
-		dev_err(dev, "Failed to set phy config, VSI %d error %d\n",
-			vsi->vsi_num, retcode);
-		retcode = -EIO;
-	}
-
-	kfree(cfg);
-out:
-	kfree(pcaps);
-	return retcode;
-}
-
 /**
  * ice_init_nvm_phy_type - Initialize the NVM PHY type
  * @pi: port info structure
@@ -2066,7 +1990,7 @@ static void ice_init_link_dflt_override(struct ice_port_info *pi)
  * first time media is available. The ICE_LINK_DEFAULT_OVERRIDE_PENDING state
  * is used to indicate that the user PHY cfg default override is initialized
  * and the PHY has not been configured with the default override settings. The
- * state is set here, and cleared in ice_configure_phy the first time the PHY is
+ * state is set here, and cleared in ice_phy_cfg the first time the PHY is
  * configured.
  *
  * This function should be called only if the FW doesn't support default
@@ -2172,14 +2096,18 @@ static int ice_init_phy_user_cfg(struct ice_port_info *pi)
 }
 
 /**
- * ice_configure_phy - configure PHY
+ * ice_phy_cfg - configure PHY
  * @vsi: VSI of PHY
+ * @link_en: true/false indicates to set link to enable/disable
  *
  * Set the PHY configuration. If the current PHY configuration is the same as
- * the curr_user_phy_cfg, then do nothing to avoid link flap. Otherwise
- * configure the based get PHY capabilities for topology with media.
+ * the curr_user_phy_cfg and link_en hasn't changed, then do nothing to avoid
+ * link flap. Otherwise configure the PHY based get PHY capabilities for
+ * topology with media and link_en.
+ *
+ * Return: 0 on success, negative on failure
  */
-static int ice_configure_phy(struct ice_vsi *vsi)
+static int ice_phy_cfg(struct ice_vsi *vsi, bool link_en)
 {
 	struct device *dev = ice_pf_to_dev(vsi->back);
 	struct ice_port_info *pi = vsi->port_info;
@@ -2199,9 +2127,6 @@ static int ice_configure_phy(struct ice_vsi *vsi)
 	    phy->link_info.topo_media_conflict == ICE_AQ_LINK_TOPO_UNSUPP_MEDIA)
 		return -EPERM;
 
-	if (test_bit(ICE_FLAG_LINK_DOWN_ON_CLOSE_ENA, pf->flags))
-		return ice_force_phys_link_state(vsi, true);
-
 	pcaps = kzalloc_obj(*pcaps);
 	if (!pcaps)
 		return -ENOMEM;
@@ -2215,10 +2140,8 @@ static int ice_configure_phy(struct ice_vsi *vsi)
 		goto done;
 	}
 
-	/* If PHY enable link is configured and configuration has not changed,
-	 * there's nothing to do
-	 */
-	if (pcaps->caps & ICE_AQC_PHY_EN_LINK &&
+	/* Configuration has not changed. There's nothing to do. */
+	if (link_en == !!(pcaps->caps & ICE_AQC_PHY_EN_LINK) &&
 	    ice_phy_caps_equals_cfg(pcaps, &phy->curr_user_phy_cfg))
 		goto done;
 
@@ -2282,8 +2205,12 @@ static int ice_configure_phy(struct ice_vsi *vsi)
 	 */
 	ice_cfg_phy_fc(pi, cfg, phy->curr_user_fc_req);
 
-	/* Enable link and link update */
-	cfg->caps |= ICE_AQ_PHY_ENA_AUTO_LINK_UPDT | ICE_AQ_PHY_ENA_LINK;
+	/* Enable/Disable link and link update */
+	cfg->caps |= ICE_AQ_PHY_ENA_AUTO_LINK_UPDT;
+	if (link_en)
+		cfg->caps |= ICE_AQ_PHY_ENA_LINK;
+	else
+		cfg->caps &= ~ICE_AQ_PHY_ENA_LINK;
 
 	err = ice_aq_set_phy_cfg(&pf->hw, pi, cfg, NULL);
 	if (err)
@@ -2336,7 +2263,7 @@ static void ice_check_media_subtask(struct ice_pf *pf)
 		    test_bit(ICE_FLAG_LINK_DOWN_ON_CLOSE_ENA, vsi->back->flags))
 			return;
 
-		err = ice_configure_phy(vsi);
+		err = ice_phy_cfg(vsi, true);
 		if (!err)
 			clear_bit(ICE_FLAG_NO_MEDIA, pf->flags);
 
@@ -4892,9 +4819,15 @@ static int ice_init_link(struct ice_pf *pf)
 
 		if (!test_bit(ICE_FLAG_LINK_DOWN_ON_CLOSE_ENA, pf->flags)) {
 			struct ice_vsi *vsi = ice_get_main_vsi(pf);
+			struct ice_link_default_override_tlv *ldo;
+			bool link_en;
+
+			ldo = &pf->link_dflt_override;
+			link_en = !(ldo->options &
+				    ICE_LINK_OVERRIDE_AUTO_LINK_DIS);
 
 			if (vsi)
-				ice_configure_phy(vsi);
+				ice_phy_cfg(vsi, link_en);
 		}
 	} else {
 		set_bit(ICE_FLAG_NO_MEDIA, pf->flags);
@@ -9707,7 +9640,7 @@ int ice_open_internal(struct net_device *netdev)
 			}
 		}
 
-		err = ice_configure_phy(vsi);
+		err = ice_phy_cfg(vsi, true);
 		if (err) {
 			netdev_err(netdev, "Failed to set physical link up, error %d\n",
 				   err);
@@ -9748,7 +9681,7 @@ int ice_stop(struct net_device *netdev)
 	}
 
 	if (test_bit(ICE_FLAG_LINK_DOWN_ON_CLOSE_ENA, vsi->back->flags)) {
-		int link_err = ice_force_phys_link_state(vsi, false);
+		int link_err = ice_phy_cfg(vsi, false);
 
 		if (link_err) {
 			if (link_err == -ENOMEDIUM)

-- 
2.54.0.rc2.531.gaf818d63126a


