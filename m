Return-Path: <netdev+bounces-283882-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJCvJlWx+GkdzAIAu9opvQ
	(envelope-from <netdev+bounces-283882-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:46:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9243E4BFFE4
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 16:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 15C27300B28E
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 14:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CABC3E5567;
	Mon,  4 May 2026 14:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/Q3xm3u"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653503E51D8
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904703; cv=none; b=YcVYQax9+6JTw9KWX5eq9OSAVT+iqU93H7M+skg2ROcvisLbxw+giWA73samZkEzyB/jw86qU48Q8DQ+ihCfl280TwQ1Rm0Ia3A7IsvXW+pKyVxrXKGTUata6Kld2/XlzNuMDE1BhsSd0wjHRc3upS33Oc30Iv92qMGz2st6Heo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904703; c=relaxed/simple;
	bh=yPN+lmUC+V9SjMLQPhkRnt+TgdSTwYMAW5C7MIsny0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5qDUyxj6ZKZsVEBAeFmI0aZQVJWblECyCzxXfijPZUfRufhNsYNulfMWUW8Y1i0zDgx8zV5xjF1GMQVY2HTvEuZR6Fvth3p0jEjmZcRLR+Kr8Pls22X/HwaF6iKnfltATAno1e76JKiUJLqVYOdhfnC38HBD7cE8+fp9Ob02yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/Q3xm3u; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777904702; x=1809440702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yPN+lmUC+V9SjMLQPhkRnt+TgdSTwYMAW5C7MIsny0I=;
  b=g/Q3xm3us+yxeP081PcecR52JD4+UI/EWdJRJPyQ5YbHZqMLODKsn8PX
   40mhEuaDUOzq7cl//5bmqpOGIT2YOwrR3KAMyvicefnGl+dzpLsNKoLsp
   JNBAJ76Zy4AbUa9dFTAdrxi1g9AjQpOLC0Z70Nmtplhjp2EoQD/KEPtO3
   CFuznYjJhrc6AuzOm7IjdoWhYEpxfshssRPLWNpt2/RxxuhCx6f5bHhXe
   OTR0USAK1YMhtug/5pyq4KGAVmtSVtiFlo+0GNwoTMOuGHkBG5irQse2C
   bpzst5yFsuSEdEc2fZxhx8Sqmz+4sHum18JO+0qrRLKvQhN6R+eOy/Ibl
   w==;
X-CSE-ConnectionGUID: OOn0b9/uStaSms/o5ELJIw==
X-CSE-MsgGUID: FCoxtAwwQaaQTwBvUaGGVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78691616"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78691616"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 07:25:02 -0700
X-CSE-ConnectionGUID: D9l56hhRQ/254amepnlPYQ==
X-CSE-MsgGUID: YJgxcTBSSxiDAfkMUbKdjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="230935411"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
  by fmviesa006.fm.intel.com with ESMTP; 04 May 2026 07:25:00 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org
Subject: [PATCH iwl-next v2 5/5] ice: use element-by-element comparison for DCB config changes
Date: Mon,  4 May 2026 16:24:51 +0200
Message-ID: <20260504142451.4161845-6-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260504142451.4161845-1-aleksandr.loktionov@intel.com>
References: <20260504142451.4161845-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9243E4BFFE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283882-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Comparing two ice_dcbx_cfg structs with memcmp() is unreliable on
non-packed structs due to uninitialised padding bytes.  The HW DCB
path already has ice_dcb_need_recfg() that compares fields
individually; export it and use it in the SW DCB netlink setters
(setets, setpfc, setapp, cee_set_all) instead of the unsafe memcmp.

Remove the now-redundant memcmp check from ice_pf_dcb_cfg() so that
function always attempts the HW reconfiguration when called.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 13 ++-------
 drivers/net/ethernet/intel/ice/ice_dcb_lib.h |  2 ++
 drivers/net/ethernet/intel/ice/ice_dcb_nl.c  | 30 ++++++++++++++++++--
 3 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
index bd77f1c..2e85fae 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
@@ -353,15 +353,11 @@ int ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dcbx_cfg *new_cfg, bool locked)
 	struct ice_dcbx_cfg *old_cfg, *curr_cfg;
 	struct device *dev = ice_pf_to_dev(pf);
 	struct iidc_rdma_event *event;
-	int ret = ICE_DCB_NO_HW_CHG;
 	struct ice_vsi *pf_vsi;
+	int ret;
 
 	curr_cfg = &pf->hw.port_info->qos_cfg.local_dcbx_cfg;
 
-	/* FW does not care if change happened */
-	if (!pf->hw.port_info->qos_cfg.is_sw_lldp)
-		ret = ICE_DCB_HW_CHG_RST;
-
 	/* Enable DCB tagging only when more than one TC */
 	if (ice_dcb_get_num_tc(new_cfg) > 1) {
 		dev_dbg(dev, "DCB tagging enabled (num TC > 1)\n");
@@ -377,11 +373,6 @@ int ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dcbx_cfg *new_cfg, bool locked)
 		clear_bit(ICE_FLAG_DCB_ENA, pf->flags);
 	}
 
-	if (!memcmp(new_cfg, curr_cfg, sizeof(*new_cfg))) {
-		dev_dbg(dev, "No change in DCB config required\n");
-		return ret;
-	}
-
 	if (ice_dcb_bwchk(pf, new_cfg))
 		return -EINVAL;
 
@@ -481,7 +472,7 @@ static void ice_cfg_etsrec_defaults(struct ice_port_info *pi)
  * @old_cfg: current DCB config
  * @new_cfg: new DCB config
  */
-static bool
+bool
 ice_dcb_need_recfg(struct ice_pf *pf, struct ice_dcbx_cfg *old_cfg,
 		   struct ice_dcbx_cfg *new_cfg)
 {
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.h b/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
index da9ba81..a7eaa2f9 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.h
@@ -20,6 +20,8 @@ u8 ice_dcb_get_num_tc(struct ice_dcbx_cfg *dcbcfg);
 void ice_vsi_set_dcb_tc_cfg(struct ice_vsi *vsi);
 bool ice_is_pfc_causing_hung_q(struct ice_pf *pf, unsigned int txqueue);
 u8 ice_dcb_get_tc(struct ice_vsi *vsi, int queue_index);
+bool ice_dcb_need_recfg(struct ice_pf *pf, struct ice_dcbx_cfg *old_cfg,
+			struct ice_dcbx_cfg *new_cfg);
 int
 ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dcbx_cfg *new_cfg, bool locked);
 int ice_dcb_bwchk(struct ice_pf *pf, struct ice_dcbx_cfg *dcbcfg);
diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
index a10c1c8d..13a52c1 100644
--- a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
+++ b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
@@ -108,11 +108,17 @@ static int ice_dcbnl_setets(struct net_device *netdev, struct ieee_ets *ets)
 	if (!bwrec)
 		new_cfg->etsrec.tcbwtable[0] = 100;
 
+	if (!ice_dcb_need_recfg(pf, &pf->hw.port_info->qos_cfg.local_dcbx_cfg,
+				new_cfg)) {
+		err = ICE_DCB_NO_HW_CHG;
+		goto ets_out;
+	}
+
 	err = ice_pf_dcb_cfg(pf, new_cfg, true);
 	/* return of zero indicates new cfg applied */
-	if (err == ICE_DCB_HW_CHG_RST)
+	if (!err)
 		ice_dcbnl_devreset(netdev);
-	if (err == ICE_DCB_NO_HW_CHG)
+	else if (err == ICE_DCB_NO_HW_CHG)
 		err = ICE_DCB_HW_CHG_RST;
 
 ets_out:
@@ -287,11 +293,18 @@ static int ice_dcbnl_setpfc(struct net_device *netdev, struct ieee_pfc *pfc)
 
 	new_cfg->pfc.pfcena = pfc->pfc_en;
 
+	if (!ice_dcb_need_recfg(pf, &pf->hw.port_info->qos_cfg.local_dcbx_cfg,
+				new_cfg)) {
+		err = ICE_DCB_NO_HW_CHG;
+		goto pfc_out;
+	}
+
 	err = ice_pf_dcb_cfg(pf, new_cfg, true);
 	if (err == ICE_DCB_HW_CHG_RST)
 		ice_dcbnl_devreset(netdev);
 	if (err == ICE_DCB_NO_HW_CHG)
 		err = ICE_DCB_HW_CHG_RST;
+pfc_out:
 	mutex_unlock(&pf->tc_mutex);
 	return err;
 }
@@ -845,6 +858,12 @@ static int ice_dcbnl_setapp(struct net_device *netdev, struct dcb_app *app)
 	new_cfg->dscp_map[app->protocol] = app->priority;
 	new_cfg->app[new_cfg->numapps++] = new_app;
 
+	if (!ice_dcb_need_recfg(pf, &pf->hw.port_info->qos_cfg.local_dcbx_cfg,
+				new_cfg)) {
+		ret = ICE_DCB_NO_HW_CHG;
+		goto setapp_out;
+	}
+
 	ret = ice_pf_dcb_cfg(pf, new_cfg, true);
 	/* return of zero indicates new cfg applied */
 	if (ret == ICE_DCB_HW_CHG_RST)
@@ -991,8 +1010,15 @@ static u8 ice_dcbnl_cee_set_all(struct net_device *netdev)
 
 	mutex_lock(&pf->tc_mutex);
 
+	if (!ice_dcb_need_recfg(pf, &pf->hw.port_info->qos_cfg.local_dcbx_cfg,
+				new_cfg)) {
+		err = ICE_DCB_NO_HW_CHG;
+		goto out;
+	}
+
 	err = ice_pf_dcb_cfg(pf, new_cfg, true);
 
+out:
 	mutex_unlock(&pf->tc_mutex);
 	return (err != ICE_DCB_HW_CHG_RST) ? ICE_DCB_NO_HW_CHG : err;
 }
-- 
2.52.0


