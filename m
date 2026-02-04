Return-Path: <netdev+bounces-256752-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJvvIflqg2m3mgMAu9opvQ
	(envelope-from <netdev+bounces-256752-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:51:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AB0E97B8
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 16:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45F1B3089213
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 15:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45594423149;
	Wed,  4 Feb 2026 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JjJyxBH/"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D5E41C2FE;
	Wed,  4 Feb 2026 15:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770219871; cv=none; b=cSaOMsgM4X6/lUhsVmngJ69PMj05jEoz8FanVvjsfvR2NQxnCT2YX05i+7ytolsfa1wpsyaqVPJwJtVl2Mxbb8I5ah8lW7KAdJk88hQBM7CDSRo2/FBxEg9Vq/bQ+I/B3d++eCimUqD4stP4YAb2JOhe6eE4PgEAtp5iPGS+ZwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770219871; c=relaxed/simple;
	bh=VtWdhFUE9gOJbP7DjdO6rFEgJIeaxW8Qh0Bpnc0ITuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aynwB471B8ED5pmXN7MuKi8ZMSjlQbVg0FHJMEixqQHK3u4vOvNxLcQR0JK8fnNgZsGUTfN1T+lmiz+DzhiUWoIoFpRo6CKkYYBJnoFPabouVaYpRXS21nmvnhBXf1cbAJbVST8ln37wYoLfT9sci8Ur3PxlEDg7Yl6vp+ur1Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JjJyxBH/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770219870; x=1801755870;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VtWdhFUE9gOJbP7DjdO6rFEgJIeaxW8Qh0Bpnc0ITuA=;
  b=JjJyxBH/oeAHWOikgpSSFyKEG++wECuThyfIkD1Uy9+m/DBhdtBHLIbI
   AHOmZ8LAKImtBWnCHjaXVzf04rlOdffZtJcQ3lEb3TkC5N3OQR7K/LKhE
   Dz2n71eoNchcKC4JgCg5qitzFlZaXHBr5DaBsTPL8dHw+A42LJ/yZdx23
   MXwLYNrOfDjFz8WIj6rR9s+N9tptk0ko1Hs1OfWzWiRpNxD/8VqR0Scg4
   T1eud4btzML/i+gnz9K6dtjbfm/17Mv3tWnpXTHLaRNtTYYKrHsWMdrLX
   3VAEFHr6f/9sPNoeU+XqyYeBT/Ts3TioVKiiLgWoroJW2x1SLvGzo7tpf
   g==;
X-CSE-ConnectionGUID: 7JgllJ6qRuSUT47D4bwn4A==
X-CSE-MsgGUID: kWp7jOCPSyufD1DUkGpu/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="88987102"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="88987102"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 07:44:30 -0800
X-CSE-ConnectionGUID: cFOsk7zVSginhXY31HNwMw==
X-CSE-MsgGUID: a+e4FSwITle8ySiOHsA5fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="209494127"
Received: from hpe-dl385gen10.igk.intel.com ([10.91.240.117])
  by orviesa010.jf.intel.com with ESMTP; 04 Feb 2026 07:44:28 -0800
From: Jakub Slepecki <jakub.slepecki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	jakub.slepecki@intel.com,
	aleksandr.loktionov@intel.com
Subject: [PATCH iwl-next v4 4/7] ice: update mac,vlan rules when toggling between VEB and VEPA
Date: Wed,  4 Feb 2026 16:44:15 +0100
Message-ID: <20260204154418.1285309-5-jakub.slepecki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204154418.1285309-1-jakub.slepecki@intel.com>
References: <20260204154418.1285309-1-jakub.slepecki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-256752-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub.slepecki@intel.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 23AB0E97B8
X-Rspamd-Action: no action

When changing into VEPA mode MAC rules are modified to forward all traffic
to the wire instead of allowing some packets to go into the loopback.
MAC,VLAN rules may and will also be used to forward loopback traffic
in VEB, so when we switch to VEPA, we want them to behave similarly to
MAC-only rules.

ice_vsi_update_bridge_mode() will now attempt a rollback of switch
filters in case an update fails.  If the rollback also fails, we will
now return the rollback error instead of the initial error.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Jakub Slepecki <jakub.slepecki@intel.com>

---
Testing hints:
  MAC,VLAN rules are created only if entire series is applied.
  The easiest way to test that rules were adjusted is to run traffic
  and observe what packets are sent to LAN.  VEPA is expected to behave
  same as before the series.  VEB is expected to (a) behave like VEPA
  if loopback traffic would cross VLANs, or (b) behave as before.
  Traffic from/to external hosts is expected to remain unchanged.
  
  Refer to cover letter (0/7) for full network configuration.  To
  change hwmode use:

      # bridge link set dev $pf hwmode {veb,vepa}

No changes in v4.

Changes in v3:
  - Refer to reproduction in cover letter in current 4/7.

Changes in v2:
  - Close open parenthesis in ice_vsi_update_bridge_mode() description.
  - Explain returns in ice_vsi_update_bridge_mode().
---
 drivers/net/ethernet/intel/ice/ice_main.c   | 48 +++++++++++++++++----
 drivers/net/ethernet/intel/ice/ice_switch.c |  8 ++--
 drivers/net/ethernet/intel/ice/ice_switch.h |  3 +-
 3 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index cb80b77d29fd..7b3ab69b8300 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -8208,8 +8208,16 @@ static int ice_vsi_update_bridge_mode(struct ice_vsi *vsi, u16 bmode)
  *
  * Sets the bridge mode (VEB/VEPA) of the switch to which the netdev (VSI) is
  * hooked up to. Iterates through the PF VSI list and sets the loopback mode (if
- * not already set for all VSIs connected to this switch. And also update the
+ * not already set for all VSIs connected to this switch). And also update the
  * unicast switch filter rules for the corresponding switch of the netdev.
+ *
+ * Return:
+ * * %0 if mode was set, propagated to VSIs, and changes to filters were all
+ *   successful,
+ * * %-EINVAL if requested netlink attributes or bridge mode were invalid,
+ * * otherwise an error from VSI update, filter rollback, or filter update is
+ *   forwarded. This may include %-EINVAL. See ice_vsi_update_bridge_mode() and
+ *   ice_update_sw_rule_bridge_mode().
  */
 static int
 ice_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
@@ -8219,8 +8227,8 @@ ice_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
 	struct ice_pf *pf = ice_netdev_to_pf(dev);
 	struct nlattr *attr, *br_spec;
 	struct ice_hw *hw = &pf->hw;
+	int rem, v, rb_err, err = 0;
 	struct ice_sw *pf_sw;
-	int rem, v, err = 0;
 
 	pf_sw = pf->first_sw;
 	/* find the attribute in the netlink message */
@@ -8230,6 +8238,7 @@ ice_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
 
 	nla_for_each_nested_type(attr, IFLA_BRIDGE_MODE, br_spec, rem) {
 		__u16 mode = nla_get_u16(attr);
+		u8 old_evb_veb = hw->evb_veb;
 
 		if (mode != BRIDGE_MODE_VEPA && mode != BRIDGE_MODE_VEB)
 			return -EINVAL;
@@ -8251,17 +8260,38 @@ ice_bridge_setlink(struct net_device *dev, struct nlmsghdr *nlh,
 		/* Update the unicast switch filter rules for the corresponding
 		 * switch of the netdev
 		 */
-		err = ice_update_sw_rule_bridge_mode(hw);
+		err = ice_update_sw_rule_bridge_mode(hw, ICE_SW_LKUP_MAC);
+		if (err) {
+			/* evb_veb is expected to be already reverted in error
+			 * path because of the potential rollback.
+			 */
+			hw->evb_veb = old_evb_veb;
+			goto err_without_rollback;
+		}
+		err = ice_update_sw_rule_bridge_mode(hw, ICE_SW_LKUP_MAC_VLAN);
 		if (err) {
-			netdev_err(dev, "switch rule update failed, mode = %d err %d aq_err %s\n",
-				   mode, err,
+			/* ice_update_sw_rule_bridge_mode looks this up, so we
+			 * must revert it before attempting a rollback.
+			 */
+			hw->evb_veb = old_evb_veb;
+			goto err_rollback_mac;
+		}
+		pf_sw->bridge_mode = mode;
+		continue;
+
+err_rollback_mac:
+		rb_err = ice_update_sw_rule_bridge_mode(hw, ICE_SW_LKUP_MAC);
+		if (rb_err) {
+			netdev_err(dev, "switch rule update failed, mode = %d err %d; rollback failed, err %d aq_err %s\n",
+				   mode, err, rb_err,
 				   libie_aq_str(hw->adminq.sq_last_status));
-			/* revert hw->evb_veb */
-			hw->evb_veb = (pf_sw->bridge_mode == BRIDGE_MODE_VEB);
-			return err;
+			return rb_err;
 		}
 
-		pf_sw->bridge_mode = mode;
+err_without_rollback:
+		netdev_err(dev, "switch rule update failed, mode = %d err %d aq_err %s\n",
+			   mode, err, libie_aq_str(hw->adminq.sq_last_status));
+		return err;
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 3caccd798220..3b526383b8ed 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -3067,10 +3067,12 @@ ice_update_pkt_fwd_rule(struct ice_hw *hw, struct ice_fltr_info *f_info)
 /**
  * ice_update_sw_rule_bridge_mode
  * @hw: pointer to the HW struct
+ * @lkup: recipe/lookup type to update
  *
  * Updates unicast switch filter rules based on VEB/VEPA mode
  */
-int ice_update_sw_rule_bridge_mode(struct ice_hw *hw)
+int ice_update_sw_rule_bridge_mode(struct ice_hw *hw,
+				   enum ice_sw_lkup_type lkup)
 {
 	struct ice_switch_info *sw = hw->switch_info;
 	struct ice_fltr_mgmt_list_entry *fm_entry;
@@ -3078,8 +3080,8 @@ int ice_update_sw_rule_bridge_mode(struct ice_hw *hw)
 	struct mutex *rule_lock; /* Lock to protect filter rule list */
 	int status = 0;
 
-	rule_lock = &sw->recp_list[ICE_SW_LKUP_MAC].filt_rule_lock;
-	rule_head = &sw->recp_list[ICE_SW_LKUP_MAC].filt_rules;
+	rule_lock = &sw->recp_list[lkup].filt_rule_lock;
+	rule_head = &sw->recp_list[lkup].filt_rules;
 
 	mutex_lock(rule_lock);
 	list_for_each_entry(fm_entry, rule_head, list_entry) {
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.h b/drivers/net/ethernet/intel/ice/ice_switch.h
index 137eae878ab1..b442db4a2ce5 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.h
+++ b/drivers/net/ethernet/intel/ice/ice_switch.h
@@ -366,7 +366,8 @@ int
 ice_add_adv_rule(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 		 u16 lkups_cnt, struct ice_adv_rule_info *rinfo,
 		 struct ice_rule_query_data *added_entry);
-int ice_update_sw_rule_bridge_mode(struct ice_hw *hw);
+int ice_update_sw_rule_bridge_mode(struct ice_hw *hw,
+				   enum ice_sw_lkup_type lkup);
 int ice_add_vlan(struct ice_hw *hw, struct list_head *m_list);
 int ice_remove_vlan(struct ice_hw *hw, struct list_head *v_list);
 int ice_add_mac(struct ice_hw *hw, struct list_head *m_lst);
-- 
2.43.0


