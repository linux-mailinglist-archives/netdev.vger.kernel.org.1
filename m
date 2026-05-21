Return-Path: <netdev+bounces-290405-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4INGLVUCD2pfEAYAu9opvQ
	(envelope-from <netdev+bounces-290405-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:02:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F755A5520
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 41957309FEC4
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 12:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274143D9DA1;
	Thu, 21 May 2026 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PuHFYJRX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC77F3D45F2
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 12:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367825; cv=none; b=ETK7wki72YD6NKU/kQOle/0Y+8gz6Ji2jMcuBTlxSObpjeaLRGZXwM5upuvqL1cYx5MG+/0MYzCBncB4bJDtN5d8I8MbIGovD+Z1nxO4KBb8+uiQ5n6b0bhKIdLew9OmyY88P3AnwH1Apk23IFuYLaqws6xxfj017DodTPDiXbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367825; c=relaxed/simple;
	bh=nLCI968/8Oftnm9aTAuR1m0zLI334bt7uvy9RvOQVZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDLOQKHQgucH4I1CkDhi/SkA10AWfarVbhhY/aEN2Forl0slrAklM8zT8c2wv7qJz2Wa/mS1Y2Evcew8t4pGXj4ARQifet07h++VGREBfkJvAv2JKleDu35VZaOkRAXBrh9M8NePxKbUZO+9L2J4LtfHXoPT8w+x9MII7XUqplQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PuHFYJRX; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779367823; x=1810903823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nLCI968/8Oftnm9aTAuR1m0zLI334bt7uvy9RvOQVZQ=;
  b=PuHFYJRXzAaenoRHqPHHUzUxqOv+YixjclXonOiDTPwW0iqFIaahTu77
   /fRO0Qpx/XNejGNRzB2T/Xo1BnYzU5oS28s0uUtC/HdUPS1sgA+OhFS53
   358JSMopZIerU573PGNeOuOxButADjmp9d6jlsPsv4Rqvo+CxoV3YQtHw
   jxd79c3wvTrY2lqLfYD+niVgeHVGWOFe1jk41Ys0GSiQ7f7p7iia+0LmL
   IaeZO5CVvoxUHlXbOR9+/Hp79WuJmzE2q5UdigF1UF4+q0660Au7wUybR
   FY4Ympj23zKnO8HavEHSi5hYpXnc+XYlUY8gR7lEjQtu/TjqvYwX4Kq1P
   g==;
X-CSE-ConnectionGUID: Kw/90gW9ROOa8egd7Qnn2Q==
X-CSE-MsgGUID: 2nXNl1x+RxCa2tu5f8wO1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80013495"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="80013495"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 05:50:23 -0700
X-CSE-ConnectionGUID: Q4NM9oeGTyqQmS+AytVw6g==
X-CSE-MsgGUID: qtKtOwaxQqCWagnemYSFhA==
X-ExtLoop1: 1
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa003.fm.intel.com with ESMTP; 21 May 2026 05:50:19 -0700
Received: from gond.igk.intel.com (gond.igk.intel.com [10.123.220.52])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 973422877B;
	Thu, 21 May 2026 13:50:17 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	sandeep.penigalapati@intel.com,
	ananth.s@intel.com,
	alexander.duyck@gmail.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next v4 01/10] ice: rename shared Flow Director functions and structs
Date: Thu, 21 May 2026 13:49:51 +0200
Message-ID: <20260521115000.4637-2-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260521115000.4637-1-marcin.szycik@linux.intel.com>
References: <20260521115000.4637-1-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290405-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,linux.intel.com];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RSPAMD_EMAILBL_FAIL(0.00)[marcin.szycik.linux.intel.com:query timed out,anthony.l.nguyen.intel.com:query timed out,paul.m.stillwell.jr.intel.com:query timed out,aleksandr.loktionov.intel.com:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcin.szycik@linux.intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.intel.com:mid,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: A0F755A5520
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tony Nguyen <anthony.l.nguyen@intel.com>

Rename shared Flow Director functions and structs. These entities are
currently used to add Flow Director filters, however, they will be
expanded to also add ACL filters. Rename the functions and struct,
replacing 'fdir' to 'ntuple', to reflect that they are being used for
ntuple filters and are not solely used for Flow Director.

Rename the file to also reflect this change.

Co-developed-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Co-developed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
v2:
* Also rename struct ice_fdir_fltr and file
---
 drivers/net/ethernet/intel/ice/Makefile       |  2 +-
 drivers/net/ethernet/intel/ice/ice.h          |  6 +-
 drivers/net/ethernet/intel/ice/ice_arfs.h     |  2 +-
 drivers/net/ethernet/intel/ice/ice_fdir.h     | 12 ++--
 drivers/net/ethernet/intel/ice/ice_arfs.c     |  8 +--
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  4 +-
 ...ce_ethtool_fdir.c => ice_ethtool_ntuple.c} | 58 ++++++++++---------
 drivers/net/ethernet/intel/ice/ice_fdir.c     | 18 +++---
 drivers/net/ethernet/intel/ice/virt/fdir.c    | 28 ++++-----
 9 files changed, 70 insertions(+), 68 deletions(-)
 rename drivers/net/ethernet/intel/ice/{ice_ethtool_fdir.c => ice_ethtool_ntuple.c} (97%)

diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
index 5b2c666496e7..c310c209bc7d 100644
--- a/drivers/net/ethernet/intel/ice/Makefile
+++ b/drivers/net/ethernet/intel/ice/Makefile
@@ -24,7 +24,7 @@ ice-y := ice_main.o	\
 	 ice_vsi_vlan_ops.o \
 	 ice_vsi_vlan_lib.o \
 	 ice_fdir.o	\
-	 ice_ethtool_fdir.o \
+	 ice_ethtool_ntuple.o \
 	 ice_vlan_mode.o \
 	 ice_flex_pipe.o \
 	 ice_flow.o	\
diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 804f5aa8e9f5..ea1bddfa739d 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -1015,11 +1015,11 @@ void ice_deinit_rdma(struct ice_pf *pf);
 bool ice_is_wol_supported(struct ice_hw *hw);
 void ice_fdir_del_all_fltrs(struct ice_vsi *vsi);
 int
-ice_fdir_write_fltr(struct ice_pf *pf, struct ice_fdir_fltr *input, bool add,
+ice_fdir_write_fltr(struct ice_pf *pf, struct ice_ntuple_fltr *input, bool add,
 		    bool is_tun);
 void ice_vsi_manage_fdir(struct ice_vsi *vsi, bool ena);
-int ice_add_fdir_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd);
-int ice_del_fdir_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd);
+int ice_add_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd);
+int ice_del_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd);
 int ice_get_ethtool_fdir_entry(struct ice_hw *hw, struct ethtool_rxnfc *cmd);
 int
 ice_get_fdir_fltr_ids(struct ice_hw *hw, struct ethtool_rxnfc *cmd,
diff --git a/drivers/net/ethernet/intel/ice/ice_arfs.h b/drivers/net/ethernet/intel/ice/ice_arfs.h
index 9706293128c3..7393254b7e0a 100644
--- a/drivers/net/ethernet/intel/ice/ice_arfs.h
+++ b/drivers/net/ethernet/intel/ice/ice_arfs.h
@@ -13,7 +13,7 @@ enum ice_arfs_fltr_state {
 };
 
 struct ice_arfs_entry {
-	struct ice_fdir_fltr fltr_info;
+	struct ice_ntuple_fltr fltr_info;
 	struct hlist_node list_entry;
 	u64 time_activated;	/* only valid for UDP flows */
 	u32 flow_id;
diff --git a/drivers/net/ethernet/intel/ice/ice_fdir.h b/drivers/net/ethernet/intel/ice/ice_fdir.h
index 820023c0271f..26d79b1364e7 100644
--- a/drivers/net/ethernet/intel/ice/ice_fdir.h
+++ b/drivers/net/ethernet/intel/ice/ice_fdir.h
@@ -160,7 +160,7 @@ struct ice_fdir_extra {
 	__be16 vlan_tag;	/* VLAN tag info */
 };
 
-struct ice_fdir_fltr {
+struct ice_ntuple_fltr {
 	struct list_head fltr_node;
 	enum ice_fltr_ptype flow_type;
 
@@ -216,18 +216,18 @@ int ice_free_fd_res_cntr(struct ice_hw *hw, u16 cntr_id);
 int ice_alloc_fd_guar_item(struct ice_hw *hw, u16 *cntr_id, u16 num_fltr);
 int ice_alloc_fd_shrd_item(struct ice_hw *hw, u16 *cntr_id, u16 num_fltr);
 void
-ice_fdir_get_prgm_desc(struct ice_hw *hw, struct ice_fdir_fltr *input,
+ice_fdir_get_prgm_desc(struct ice_hw *hw, struct ice_ntuple_fltr *input,
 		       struct ice_fltr_desc *fdesc, bool add);
 int
-ice_fdir_get_gen_prgm_pkt(struct ice_hw *hw, struct ice_fdir_fltr *input,
+ice_fdir_get_gen_prgm_pkt(struct ice_hw *hw, struct ice_ntuple_fltr *input,
 			  u8 *pkt, bool frag, bool tun);
 int ice_get_fdir_cnt_all(struct ice_hw *hw);
 int ice_fdir_num_avail_fltr(struct ice_hw *hw, struct ice_vsi *vsi);
-bool ice_fdir_is_dup_fltr(struct ice_hw *hw, struct ice_fdir_fltr *input);
+bool ice_fdir_is_dup_fltr(struct ice_hw *hw, struct ice_ntuple_fltr *input);
 bool ice_fdir_has_frag(enum ice_fltr_ptype flow);
-struct ice_fdir_fltr *
+struct ice_ntuple_fltr *
 ice_fdir_find_fltr_by_idx(struct ice_hw *hw, u32 fltr_idx);
 void
 ice_fdir_update_cntrs(struct ice_hw *hw, enum ice_fltr_ptype flow, bool add);
-void ice_fdir_list_add_fltr(struct ice_hw *hw, struct ice_fdir_fltr *input);
+void ice_fdir_list_add_fltr(struct ice_hw *hw, struct ice_ntuple_fltr *input);
 #endif /* _ICE_FDIR_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_arfs.c b/drivers/net/ethernet/intel/ice/ice_arfs.c
index 53b6e2b09eb9..e0335f5e18fe 100644
--- a/drivers/net/ethernet/intel/ice/ice_arfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_arfs.c
@@ -302,7 +302,7 @@ ice_arfs_build_entry(struct ice_vsi *vsi, const struct flow_keys *fk,
 		     u16 rxq_idx, u32 flow_id)
 {
 	struct ice_arfs_entry *arfs_entry;
-	struct ice_fdir_fltr *fltr_info;
+	struct ice_ntuple_fltr *fltr_info;
 	u8 ip_proto;
 
 	arfs_entry = devm_kzalloc(ice_pf_to_dev(vsi->back),
@@ -392,8 +392,8 @@ ice_arfs_is_perfect_flow_set(struct ice_hw *hw, __be16 l3_proto, u8 l4_proto)
  * * false	- fltr_info and fk refer to different flows.
  */
 static bool
-ice_arfs_cmp(const struct ice_fdir_fltr *fltr_info, const struct flow_keys *fk,
-	     __be16 n_proto, u8 ip_proto)
+ice_arfs_cmp(const struct ice_ntuple_fltr *fltr_info,
+	     const struct flow_keys *fk, __be16 n_proto, u8 ip_proto)
 {
 	/* Determine if the filter is for IPv4 or IPv6 based on flow_type,
 	 * which is one of ICE_FLTR_PTYPE_NONF_IPV{4,6}_{TCP,UDP}.
@@ -485,7 +485,7 @@ ice_rx_flow_steer(struct net_device *netdev, const struct sk_buff *skb,
 	spin_lock_bh(&vsi->arfs_lock);
 	hlist_for_each_entry(arfs_entry, &vsi->arfs_fltr_list[idx],
 			     list_entry) {
-		struct ice_fdir_fltr *fltr_info;
+		struct ice_ntuple_fltr *fltr_info;
 
 		/* keep searching for the already existing arfs_entry flow */
 		if (arfs_entry->flow_id != flow_id)
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index 45e546ec85ad..88cc927e47ef 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3143,9 +3143,9 @@ static int ice_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
 
 	switch (cmd->cmd) {
 	case ETHTOOL_SRXCLSRLINS:
-		return ice_add_fdir_ethtool(vsi, cmd);
+		return ice_add_ntuple_ethtool(vsi, cmd);
 	case ETHTOOL_SRXCLSRLDEL:
-		return ice_del_fdir_ethtool(vsi, cmd);
+		return ice_del_ntuple_ethtool(vsi, cmd);
 	default:
 		break;
 	}
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
similarity index 97%
rename from drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
rename to drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
index 82ae237894de..15f67ccf82a0 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_ntuple.c
@@ -107,7 +107,7 @@ static bool ice_is_mask_valid(u64 mask, u64 field)
 int ice_get_ethtool_fdir_entry(struct ice_hw *hw, struct ethtool_rxnfc *cmd)
 {
 	struct ethtool_rx_flow_spec *fsp;
-	struct ice_fdir_fltr *rule;
+	struct ice_ntuple_fltr *rule;
 	int ret = 0;
 	u16 idx;
 
@@ -227,7 +227,7 @@ int
 ice_get_fdir_fltr_ids(struct ice_hw *hw, struct ethtool_rxnfc *cmd,
 		      u32 *rule_locs)
 {
-	struct ice_fdir_fltr *f_rule;
+	struct ice_ntuple_fltr *f_rule;
 	unsigned int cnt = 0;
 	int val = 0;
 
@@ -1462,10 +1462,10 @@ static void ice_update_per_q_fltr(struct ice_vsi *vsi, u32 q_index, bool inc)
  * @add: true adds filter and false removed filter
  * @is_tun: true adds inner filter on tunnel and false outer headers
  *
- * returns 0 on success and negative value on error
+ * Return: 0 on success and negative value on error
  */
 int
-ice_fdir_write_fltr(struct ice_pf *pf, struct ice_fdir_fltr *input, bool add,
+ice_fdir_write_fltr(struct ice_pf *pf, struct ice_ntuple_fltr *input, bool add,
 		    bool is_tun)
 {
 	struct device *dev = ice_pf_to_dev(pf);
@@ -1532,10 +1532,10 @@ ice_fdir_write_fltr(struct ice_pf *pf, struct ice_fdir_fltr *input, bool add,
  * @input: filter structure
  * @add: true adds filter and false removed filter
  *
- * returns 0 on success and negative value on error
+ * Return: 0 on success and negative value on error
  */
 static int
-ice_fdir_write_all_fltr(struct ice_pf *pf, struct ice_fdir_fltr *input,
+ice_fdir_write_all_fltr(struct ice_pf *pf, struct ice_ntuple_fltr *input,
 			bool add)
 {
 	u16 port_num;
@@ -1560,7 +1560,7 @@ ice_fdir_write_all_fltr(struct ice_pf *pf, struct ice_fdir_fltr *input,
  */
 void ice_fdir_replay_fltrs(struct ice_pf *pf)
 {
-	struct ice_fdir_fltr *f_rule;
+	struct ice_ntuple_fltr *f_rule;
 	struct ice_hw *hw = &pf->hw;
 
 	list_for_each_entry(f_rule, &hw->fdir_list_head, fltr_node) {
@@ -1605,7 +1605,7 @@ int ice_fdir_create_dflt_rules(struct ice_pf *pf)
  */
 void ice_fdir_del_all_fltrs(struct ice_vsi *vsi)
 {
-	struct ice_fdir_fltr *f_rule, *tmp;
+	struct ice_ntuple_fltr *f_rule, *tmp;
 	struct ice_pf *pf = vsi->back;
 	struct ice_hw *hw = &pf->hw;
 
@@ -1676,18 +1676,18 @@ ice_fdir_do_rem_flow(struct ice_pf *pf, enum ice_fltr_ptype flow_type)
 }
 
 /**
- * ice_fdir_update_list_entry - add or delete a filter from the filter list
+ * ice_ntuple_update_list_entry - add or delete a filter from the filter list
  * @pf: PF structure
  * @input: filter structure
  * @fltr_idx: ethtool index of filter to modify
  *
- * returns 0 on success and negative on errors
+ * Return: 0 on success and negative on errors
  */
 static int
-ice_fdir_update_list_entry(struct ice_pf *pf, struct ice_fdir_fltr *input,
-			   int fltr_idx)
+ice_ntuple_update_list_entry(struct ice_pf *pf, struct ice_ntuple_fltr *input,
+			     int fltr_idx)
 {
-	struct ice_fdir_fltr *old_fltr;
+	struct ice_ntuple_fltr *old_fltr;
 	struct ice_hw *hw = &pf->hw;
 	struct ice_vsi *vsi;
 	int err = -ENOENT;
@@ -1726,13 +1726,13 @@ ice_fdir_update_list_entry(struct ice_pf *pf, struct ice_fdir_fltr *input,
 }
 
 /**
- * ice_del_fdir_ethtool - delete Flow Director filter
+ * ice_del_ntuple_ethtool - delete Flow Director or ACL filter
  * @vsi: pointer to target VSI
- * @cmd: command to add or delete Flow Director filter
+ * @cmd: command to add or delete the filter
  *
- * Returns 0 on success and negative values for failure
+ * Return: 0 on success and negative values for failure
  */
-int ice_del_fdir_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
+int ice_del_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 {
 	struct ethtool_rx_flow_spec *fsp =
 		(struct ethtool_rx_flow_spec *)&cmd->fs;
@@ -1753,7 +1753,7 @@ int ice_del_fdir_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 		return -EBUSY;
 
 	mutex_lock(&hw->fdir_fltr_lock);
-	val = ice_fdir_update_list_entry(pf, NULL, fsp->location);
+	val = ice_ntuple_update_list_entry(pf, NULL, fsp->location);
 	mutex_unlock(&hw->fdir_fltr_lock);
 
 	return val;
@@ -1793,14 +1793,16 @@ ice_update_ring_dest_vsi(struct ice_vsi *vsi, u16 *dest_vsi, u32 *ring)
 }
 
 /**
- * ice_set_fdir_input_set - Set the input set for Flow Director
+ * ice_ntuple_set_input_set - Set the input set for Flow Director
  * @vsi: pointer to target VSI
  * @fsp: pointer to ethtool Rx flow specification
  * @input: filter structure
+ *
+ * Return: 0 on success, negative on failure
  */
 static int
-ice_set_fdir_input_set(struct ice_vsi *vsi, struct ethtool_rx_flow_spec *fsp,
-		       struct ice_fdir_fltr *input)
+ice_ntuple_set_input_set(struct ice_vsi *vsi, struct ethtool_rx_flow_spec *fsp,
+			 struct ice_ntuple_fltr *input)
 {
 	s16 q_index = ICE_FDIR_NO_QUEUE_IDX;
 	u16 orig_q_index = 0;
@@ -1943,17 +1945,17 @@ ice_set_fdir_input_set(struct ice_vsi *vsi, struct ethtool_rx_flow_spec *fsp,
 }
 
 /**
- * ice_add_fdir_ethtool - Add/Remove Flow Director filter
+ * ice_add_ntuple_ethtool - Add/Remove Flow Director or ACL filter
  * @vsi: pointer to target VSI
- * @cmd: command to add or delete Flow Director filter
+ * @cmd: command to add or delete the filter
  *
- * Returns 0 on success and negative values for failure
+ * Return: 0 on success and negative values for failure
  */
-int ice_add_fdir_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
+int ice_add_ntuple_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 {
 	struct ice_rx_flow_userdef userdata;
 	struct ethtool_rx_flow_spec *fsp;
-	struct ice_fdir_fltr *input;
+	struct ice_ntuple_fltr *input;
 	struct device *dev;
 	struct ice_pf *pf;
 	struct ice_hw *hw;
@@ -2009,7 +2011,7 @@ int ice_add_fdir_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 	if (!input)
 		return -ENOMEM;
 
-	ret = ice_set_fdir_input_set(vsi, fsp, input);
+	ret = ice_ntuple_set_input_set(vsi, fsp, input);
 	if (ret)
 		goto free_input;
 
@@ -2030,7 +2032,7 @@ int ice_add_fdir_ethtool(struct ice_vsi *vsi, struct ethtool_rxnfc *cmd)
 	input->comp_report = ICE_FXD_FLTR_QW0_COMP_REPORT_SW_FAIL;
 
 	/* input struct is added to the HW filter list */
-	ret = ice_fdir_update_list_entry(pf, input, fsp->location);
+	ret = ice_ntuple_update_list_entry(pf, input, fsp->location);
 	if (ret)
 		goto release_lock;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_fdir.c b/drivers/net/ethernet/intel/ice/ice_fdir.c
index b29fbdec9442..5b25f6414b58 100644
--- a/drivers/net/ethernet/intel/ice/ice_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_fdir.c
@@ -648,7 +648,7 @@ ice_set_fd_desc_val(struct ice_fd_fltr_desc_ctx *ctx,
  * @add: if add is true, this is an add operation, false implies delete
  */
 void
-ice_fdir_get_prgm_desc(struct ice_hw *hw, struct ice_fdir_fltr *input,
+ice_fdir_get_prgm_desc(struct ice_hw *hw, struct ice_ntuple_fltr *input,
 		       struct ice_fltr_desc *fdesc, bool add)
 {
 	struct ice_fd_fltr_desc_ctx fdir_fltr_ctx = { 0 };
@@ -855,7 +855,7 @@ static void ice_pkt_insert_mac_addr(u8 *pkt, u8 *addr)
  * @tun: true implies generate a tunnel packet
  */
 int
-ice_fdir_get_gen_prgm_pkt(struct ice_hw *hw, struct ice_fdir_fltr *input,
+ice_fdir_get_gen_prgm_pkt(struct ice_hw *hw, struct ice_ntuple_fltr *input,
 			  u8 *pkt, bool frag, bool tun)
 {
 	enum ice_fltr_ptype flow;
@@ -1138,10 +1138,10 @@ bool ice_fdir_has_frag(enum ice_fltr_ptype flow)
  *
  * Returns pointer to filter if found or null
  */
-struct ice_fdir_fltr *
+struct ice_ntuple_fltr *
 ice_fdir_find_fltr_by_idx(struct ice_hw *hw, u32 fltr_idx)
 {
-	struct ice_fdir_fltr *rule;
+	struct ice_ntuple_fltr *rule;
 
 	list_for_each_entry(rule, &hw->fdir_list_head, fltr_node) {
 		/* rule ID found in the list */
@@ -1158,9 +1158,9 @@ ice_fdir_find_fltr_by_idx(struct ice_hw *hw, u32 fltr_idx)
  * @hw: hardware structure
  * @fltr: filter node to add to structure
  */
-void ice_fdir_list_add_fltr(struct ice_hw *hw, struct ice_fdir_fltr *fltr)
+void ice_fdir_list_add_fltr(struct ice_hw *hw, struct ice_ntuple_fltr *fltr)
 {
-	struct ice_fdir_fltr *rule, *parent = NULL;
+	struct ice_ntuple_fltr *rule, *parent = NULL;
 
 	list_for_each_entry(rule, &hw->fdir_list_head, fltr_node) {
 		/* rule ID found or pass its spot in the list */
@@ -1215,7 +1215,7 @@ static int ice_cmp_ipv6_addr(__be32 *a, __be32 *b)
  * Returns true if the filters match
  */
 static bool
-ice_fdir_comp_rules(struct ice_fdir_fltr *a,  struct ice_fdir_fltr *b)
+ice_fdir_comp_rules(struct ice_ntuple_fltr *a,  struct ice_ntuple_fltr *b)
 {
 	enum ice_fltr_ptype flow_type = a->flow_type;
 
@@ -1275,9 +1275,9 @@ ice_fdir_comp_rules(struct ice_fdir_fltr *a,  struct ice_fdir_fltr *b)
  *
  * Returns true if the filter is found in the list
  */
-bool ice_fdir_is_dup_fltr(struct ice_hw *hw, struct ice_fdir_fltr *input)
+bool ice_fdir_is_dup_fltr(struct ice_hw *hw, struct ice_ntuple_fltr *input)
 {
-	struct ice_fdir_fltr *rule;
+	struct ice_ntuple_fltr *rule;
 	bool ret = false;
 
 	list_for_each_entry(rule, &hw->fdir_list_head, fltr_node) {
diff --git a/drivers/net/ethernet/intel/ice/virt/fdir.c b/drivers/net/ethernet/intel/ice/virt/fdir.c
index 74967edf27ad..f9d91212e0e0 100644
--- a/drivers/net/ethernet/intel/ice/virt/fdir.c
+++ b/drivers/net/ethernet/intel/ice/virt/fdir.c
@@ -38,7 +38,7 @@ enum ice_fdir_tunnel_type {
 };
 
 struct virtchnl_fdir_fltr_conf {
-	struct ice_fdir_fltr input;
+	struct ice_ntuple_fltr input;
 	enum ice_fdir_tunnel_type ttype;
 	u64 inset_flag;
 	u32 flow_id;
@@ -567,12 +567,12 @@ static bool
 ice_vc_fdir_has_prof_conflict(struct ice_vf *vf,
 			      struct virtchnl_fdir_fltr_conf *conf)
 {
-	struct ice_fdir_fltr *desc;
+	struct ice_ntuple_fltr *desc;
 
 	list_for_each_entry(desc, &vf->fdir.fdir_rule_list, fltr_node) {
 		struct virtchnl_fdir_fltr_conf *existing_conf;
 		enum ice_fltr_ptype flow_type_a, flow_type_b;
-		struct ice_fdir_fltr *a, *b;
+		struct ice_ntuple_fltr *a, *b;
 
 		existing_conf = to_fltr_conf_from_desc(desc);
 		a = &existing_conf->input;
@@ -748,7 +748,7 @@ static int
 ice_vc_fdir_config_input_set(struct ice_vf *vf, struct virtchnl_fdir_add *fltr,
 			     struct virtchnl_fdir_fltr_conf *conf, int tun)
 {
-	struct ice_fdir_fltr *input = &conf->input;
+	struct ice_ntuple_fltr *input = &conf->input;
 	struct device *dev = ice_pf_to_dev(vf->pf);
 	struct ice_flow_seg_info *seg;
 	enum ice_fltr_ptype flow;
@@ -924,8 +924,8 @@ ice_vc_fdir_parse_pattern(struct ice_vf *vf, struct virtchnl_fdir_add *fltr,
 	struct virtchnl_proto_hdrs *proto = &fltr->rule_cfg.proto_hdrs;
 	enum virtchnl_proto_hdr_type l3 = VIRTCHNL_PROTO_HDR_NONE;
 	enum virtchnl_proto_hdr_type l4 = VIRTCHNL_PROTO_HDR_NONE;
+	struct ice_ntuple_fltr *input = &conf->input;
 	struct device *dev = ice_pf_to_dev(vf->pf);
-	struct ice_fdir_fltr *input = &conf->input;
 	int i;
 
 	if (proto->count > VIRTCHNL_MAX_NUM_PROTO_HDRS) {
@@ -1150,8 +1150,8 @@ ice_vc_fdir_parse_action(struct ice_vf *vf, struct virtchnl_fdir_add *fltr,
 			 struct virtchnl_fdir_fltr_conf *conf)
 {
 	struct virtchnl_filter_action_set *as = &fltr->rule_cfg.action_set;
+	struct ice_ntuple_fltr *input = &conf->input;
 	struct device *dev = ice_pf_to_dev(vf->pf);
-	struct ice_fdir_fltr *input = &conf->input;
 	u32 dest_num = 0;
 	u32 mark_num = 0;
 	int i;
@@ -1249,8 +1249,8 @@ static bool
 ice_vc_fdir_comp_rules(struct virtchnl_fdir_fltr_conf *conf_a,
 		       struct virtchnl_fdir_fltr_conf *conf_b)
 {
-	struct ice_fdir_fltr *a = &conf_a->input;
-	struct ice_fdir_fltr *b = &conf_b->input;
+	struct ice_ntuple_fltr *a = &conf_a->input;
+	struct ice_ntuple_fltr *b = &conf_b->input;
 
 	if (conf_a->ttype != conf_b->ttype)
 		return false;
@@ -1288,7 +1288,7 @@ ice_vc_fdir_comp_rules(struct virtchnl_fdir_fltr_conf *conf_a,
 static bool
 ice_vc_fdir_is_dup_fltr(struct ice_vf *vf, struct virtchnl_fdir_fltr_conf *conf)
 {
-	struct ice_fdir_fltr *desc;
+	struct ice_ntuple_fltr *desc;
 	bool ret;
 
 	list_for_each_entry(desc, &vf->fdir.fdir_rule_list, fltr_node) {
@@ -1317,7 +1317,7 @@ static int
 ice_vc_fdir_insert_entry(struct ice_vf *vf,
 			 struct virtchnl_fdir_fltr_conf *conf, u32 *id)
 {
-	struct ice_fdir_fltr *input = &conf->input;
+	struct ice_ntuple_fltr *input = &conf->input;
 	int i;
 
 	/* alloc ID corresponding with conf */
@@ -1341,7 +1341,7 @@ static void
 ice_vc_fdir_remove_entry(struct ice_vf *vf,
 			 struct virtchnl_fdir_fltr_conf *conf, u32 id)
 {
-	struct ice_fdir_fltr *input = &conf->input;
+	struct ice_ntuple_fltr *input = &conf->input;
 
 	idr_remove(&vf->fdir.fdir_rule_idr, id);
 	list_del(&input->fltr_node);
@@ -1367,7 +1367,7 @@ ice_vc_fdir_lookup_entry(struct ice_vf *vf, u32 id)
 static void ice_vc_fdir_flush_entry(struct ice_vf *vf)
 {
 	struct virtchnl_fdir_fltr_conf *conf;
-	struct ice_fdir_fltr *desc, *temp;
+	struct ice_ntuple_fltr *desc, *temp;
 
 	list_for_each_entry_safe(desc, temp,
 				 &vf->fdir.fdir_rule_list, fltr_node) {
@@ -1390,7 +1390,7 @@ static int ice_vc_fdir_write_fltr(struct ice_vf *vf,
 				  struct virtchnl_fdir_fltr_conf *conf,
 				  bool add, bool is_tun)
 {
-	struct ice_fdir_fltr *input = &conf->input;
+	struct ice_ntuple_fltr *input = &conf->input;
 	struct ice_vsi *vsi, *ctrl_vsi;
 	struct ice_fltr_desc desc;
 	struct device *dev;
@@ -2315,7 +2315,7 @@ int ice_vc_del_fdir_fltr(struct ice_vf *vf, u8 *msg)
 	struct virtchnl_fdir_fltr_conf *conf;
 	struct ice_vf_fdir *fdir = &vf->fdir;
 	enum virtchnl_status_code v_ret;
-	struct ice_fdir_fltr *input;
+	struct ice_ntuple_fltr *input;
 	enum ice_fltr_ptype flow;
 	struct device *dev;
 	struct ice_pf *pf;
-- 
2.49.0


