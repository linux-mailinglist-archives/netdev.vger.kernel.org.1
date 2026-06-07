Return-Path: <netdev+bounces-296129-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P5qvMHJnJGoR6AEAu9opvQ
	(envelope-from <netdev+bounces-296129-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 20:31:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2CA64E06B
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 20:31:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296129-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296129-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=chelsio.com (policy=reject);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 250E4302A6C7
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 18:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DF73B8124;
	Sat,  6 Jun 2026 18:21:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6F53B7757
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 18:21:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780770090; cv=none; b=MKgmKb6Vm19jQMieSc2Yss6wIRryAmEendWnO8KZ+EOuclbrut1tt4eLWgyKc8lkanrAR7hGvQxZZPOxCO3a/6uKkqkmK/nJa90dTSMFO0BrnOwOIGjkJdQaJ4LvZIqWql9y9Vu6v73lYAymwdSbFevEXhiSE/5wtlmi0uKg1+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780770090; c=relaxed/simple;
	bh=559ejcfM/jEnFgbDCOA03Gm7rQkjemun77nfJAnTgoo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PB+FALm6T8R+FmzPR/HacAKse9BWq7nEXcTdCx0P2rTr+oNoPOUlXgFUK7cHDW6690hxbH2KkoK/+POIHp2CPMVpDHv0fOe/OedYfU17W7iLNpElPn9boJnBa20Pa5NTX5F0oQ422jPu9BAEMtnOeQVLRdzTfbqsbp1jAvvBK3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Received: from mehrangarh-blr-asicdesigners-com.asicdesigners.com (mehrangarh.blr.asicdesigners.com [10.193.185.169])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 656IKSGK029679;
	Sat, 6 Jun 2026 11:21:13 -0700
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, bharat@chelsio.com
Subject: [PATCH net-next v1 10/10] cxgb4: Update SGE path and filtering logic for T7
Date: Sat,  6 Jun 2026 23:52:20 -0400
Message-Id: <20260607035220.528439-11-bharat@chelsio.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260607035220.528439-1-bharat@chelsio.com>
References: <20260607035220.528439-1-bharat@chelsio.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: add header
X-Spamd-Result: default: False [7.54 / 15.00];
	DATE_IN_FUTURE(4.00)[9];
	DMARC_POLICY_REJECT(2.00)[chelsio.com : SPF not aligned (relaxed), No valid DKIM,reject];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:bharat@chelsio.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296129-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,meta];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[bharat@chelsio.com,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[bharat@chelsio.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chelsio.com:mid,chelsio.com:from_mime,chelsio.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1E2CA64E06B
X-Spam: Yes

Optimize the SGE path and extend the hardware traffic filter engine to
support T7 active-open configurations.

Update the SGE ring management and transport paths to leverage T7 layout
features:
 - Replace the runtime register calculations MYPF_REG for doorbells by
   caching and reading physical tx_db_addr and rx_db_addr pointers.
 - Fix sizing boundaries within is_eth_imm to account for the permanent
   CPL header footprint.
 - Transition transmit descriptors within the Ethernet paths to track
   logical ports lport instead of transmit channels.
 - Export encapsulated offload validation helper capabilities for use
   by ULD modules.
 - Refactor the filter programming logic inside cxgb4_filter.c to handle
   T7 configuration flags, insert wide tuple structures like
   cpl_t7_act_open_req, and expand hardware CLIP cleanup checks.

Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 .../net/ethernet/chelsio/cxgb4/cxgb4_filter.c | 212 +++++++++++-------
 drivers/net/ethernet/chelsio/cxgb4/sge.c      | 122 +++++-----
 2 files changed, 209 insertions(+), 125 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
index 657d96b9e2f6..38c08ffb8a0b 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
@@ -66,9 +66,14 @@ static int set_tcb_field(struct adapter *adap, struct filter_entry *f,
 
 	req = (struct cpl_set_tcb_field *)__skb_put_zero(skb, sizeof(*req));
 	INIT_TP_WR_CPL(req, CPL_SET_TCB_FIELD, ftid);
-	req->reply_ctrl = htons(REPLY_CHAN_V(0) |
-				QUEUENO_V(adap->sge.fw_evtq.abs_id) |
-				NO_REPLY_V(no_reply));
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T7)
+		req->reply_ctrl = htons(T7_REPLY_CHAN_V(0) |
+					T7_QUEUENO_V(adap->sge.fw_evtq.abs_id) |
+					NO_REPLY_V(no_reply));
+	else
+		req->reply_ctrl = htons(REPLY_CHAN_V(0) |
+					QUEUENO_V(adap->sge.fw_evtq.abs_id) |
+					NO_REPLY_V(no_reply));
 	req->word_cookie = htons(TCB_WORD_V(word) | TCB_COOKIE_V(ftid));
 	req->mask = cpu_to_be64(mask);
 	req->val = cpu_to_be64(val);
@@ -249,32 +254,54 @@ static int validate_filter(struct net_device *dev,
 			   struct ch_filter_specification *fs)
 {
 	struct adapter *adapter = netdev2adap(dev);
-	u32 fconf, iconf;
+	u32 fconf, iconf, chip_ver;
 
+	chip_ver = CHELSIO_CHIP_VERSION(adapter->params.chip);
 	/* Check for unconfigured fields being used. */
 	iconf = adapter->params.tp.ingress_config;
 	fconf = fs->hash ? adapter->params.tp.filter_mask :
 			   adapter->params.tp.vlan_pri_map;
 
-	if (unsupported(fconf, FCOE_F, fs->val.fcoe, fs->mask.fcoe) ||
-	    unsupported(fconf, PORT_F, fs->val.iport, fs->mask.iport) ||
-	    unsupported(fconf, TOS_F, fs->val.tos, fs->mask.tos) ||
-	    unsupported(fconf, ETHERTYPE_F, fs->val.ethtype,
-			fs->mask.ethtype) ||
-	    unsupported(fconf, MACMATCH_F, fs->val.macidx, fs->mask.macidx) ||
-	    unsupported(fconf, MPSHITTYPE_F, fs->val.matchtype,
-			fs->mask.matchtype) ||
-	    unsupported(fconf, FRAGMENTATION_F, fs->val.frag, fs->mask.frag) ||
-	    unsupported(fconf, PROTOCOL_F, fs->val.proto, fs->mask.proto) ||
-	    unsupported(fconf, VNIC_ID_F, fs->val.pfvf_vld,
-			fs->mask.pfvf_vld) ||
-	    unsupported(fconf, VNIC_ID_F, fs->val.ovlan_vld,
-			fs->mask.ovlan_vld) ||
-	    unsupported(fconf, VNIC_ID_F, fs->val.encap_vld,
-			fs->mask.encap_vld) ||
-	    unsupported(fconf, VLAN_F, fs->val.ivlan_vld, fs->mask.ivlan_vld))
-		return -EOPNOTSUPP;
-
+	if (chip_ver >= CHELSIO_T7) {
+		if (unsupported(fconf, T7_FCOE_F, fs->val.fcoe, fs->mask.fcoe) ||
+		    unsupported(fconf, T7_PORT_F, fs->val.iport, fs->mask.iport) ||
+		    unsupported(fconf, T7_TOS_F, fs->val.tos, fs->mask.tos) ||
+		    unsupported(fconf, T7_ETHERTYPE_F, fs->val.ethtype,
+				fs->mask.ethtype) ||
+		    unsupported(fconf, T7_MACMATCH_F, fs->val.macidx, fs->mask.macidx) ||
+		    unsupported(fconf, T7_MPSHITTYPE_F, fs->val.matchtype,
+				fs->mask.matchtype) ||
+		    unsupported(fconf, T7_FRAGMENTATION_F, fs->val.frag, fs->mask.frag) ||
+		    unsupported(fconf, T7_PROTOCOL_F, fs->val.proto, fs->mask.proto) ||
+		    unsupported(fconf, T7_VNIC_ID_F, fs->val.pfvf_vld,
+				fs->mask.pfvf_vld) ||
+		    unsupported(fconf, T7_VNIC_ID_F, fs->val.ovlan_vld,
+				fs->mask.ovlan_vld) ||
+		    unsupported(fconf, T7_VNIC_ID_F, fs->val.encap_vld,
+				fs->mask.encap_vld) ||
+		    unsupported(fconf, T7_VLAN_F, fs->val.ivlan_vld, fs->mask.ivlan_vld) ||
+		    unsupported(fconf, SYNONLY_F, fs->val.synonly, fs->mask.synonly))
+			return -EOPNOTSUPP;
+	} else {
+		if (unsupported(fconf, FCOE_F, fs->val.fcoe, fs->mask.fcoe) ||
+		    unsupported(fconf, PORT_F, fs->val.iport, fs->mask.iport) ||
+		    unsupported(fconf, TOS_F, fs->val.tos, fs->mask.tos) ||
+		    unsupported(fconf, ETHERTYPE_F, fs->val.ethtype,
+				fs->mask.ethtype) ||
+		    unsupported(fconf, MACMATCH_F, fs->val.macidx, fs->mask.macidx) ||
+		    unsupported(fconf, MPSHITTYPE_F, fs->val.matchtype,
+				fs->mask.matchtype) ||
+		    unsupported(fconf, FRAGMENTATION_F, fs->val.frag, fs->mask.frag) ||
+		    unsupported(fconf, PROTOCOL_F, fs->val.proto, fs->mask.proto) ||
+		    unsupported(fconf, VNIC_ID_F, fs->val.pfvf_vld,
+				fs->mask.pfvf_vld) ||
+		    unsupported(fconf, VNIC_ID_F, fs->val.ovlan_vld,
+				fs->mask.ovlan_vld) ||
+		    unsupported(fconf, VNIC_ID_F, fs->val.encap_vld,
+				fs->mask.encap_vld) ||
+		    unsupported(fconf, VLAN_F, fs->val.ivlan_vld, fs->mask.ivlan_vld))
+			return -EOPNOTSUPP;
+	}
 	/* T4 inconveniently uses the same FT_VNIC_ID_W bits for both the Outer
 	 * VLAN Tag and PF/VF/VFvld fields based on VNIC_F being set
 	 * in TP_INGRESS_CONFIG.  Hense the somewhat crazy checks
@@ -293,6 +320,8 @@ static int validate_filter(struct net_device *dev,
 	    (is_field_set(fs->val.ovlan_vld, fs->mask.ovlan_vld) &&
 	     (iconf & VNIC_F)))
 		return -EOPNOTSUPP;
+	if (chip_ver <= CHELSIO_T6 && is_field_set(fs->val.synonly, fs->mask.synonly))
+		return -EOPNOTSUPP;
 	if (fs->val.pf > 0x7 || fs->val.vf > 0x7f)
 		return -ERANGE;
 	fs->mask.pf &= 0x7;
@@ -993,7 +1022,9 @@ void clear_filter(struct adapter *adap, struct filter_entry *f)
 		t4_free_encap_mac_filt(adap, pi->viid,
 				       f->fs.val.ovlan & 0x1ff, 0);
 
-	if ((f->fs.hash || is_t6(adap->params.chip)) && f->fs.type)
+	if ((f->fs.hash ||
+	     (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T6)) &&
+	    f->fs.type)
 		cxgb4_clip_release(f->dev, (const u32 *)&f->fs.val.lip, 1);
 
 	/* The zeroing of the filter rule below clears the filter valid,
@@ -1296,20 +1327,15 @@ static void mk_act_open_req6(struct filter_entry *f, struct sk_buff *skb,
 			     unsigned int qid_filterid, struct adapter *adap)
 {
 	struct cpl_t6_act_open_req6 *t6req = NULL;
+	struct cpl_t7_act_open_req6 *t7req = NULL;
 	struct cpl_act_open_req6 *req = NULL;
+	u32 chip_ver, opt2;
+	u64 opt0;
 
-	t6req = (struct cpl_t6_act_open_req6 *)__skb_put(skb, sizeof(*t6req));
-	INIT_TP_WR(t6req, 0);
-	req = (struct cpl_act_open_req6 *)t6req;
-	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_ACT_OPEN_REQ6, qid_filterid));
-	req->local_port = cpu_to_be16(f->fs.val.lport);
-	req->peer_port = cpu_to_be16(f->fs.val.fport);
-	req->local_ip_hi = *(__be64 *)(&f->fs.val.lip);
-	req->local_ip_lo = *(((__be64 *)&f->fs.val.lip) + 1);
-	req->peer_ip_hi = *(__be64 *)(&f->fs.val.fip);
-	req->peer_ip_lo = *(((__be64 *)&f->fs.val.fip) + 1);
-	req->opt0 = cpu_to_be64(NAGLE_V(f->fs.newvlan == VLAN_REMOVE ||
-					f->fs.newvlan == VLAN_REWRITE) |
+	chip_ver = CHELSIO_CHIP_VERSION(adap->params.chip);
+
+	opt0 = cpu_to_be64(NAGLE_V(f->fs.newvlan == VLAN_REMOVE ||
+				   f->fs.newvlan == VLAN_REWRITE) |
 				DELACK_V(f->fs.hitcnts) |
 				L2T_IDX_V(f->l2t ? f->l2t->idx : 0) |
 				SMAC_SEL_V((cxgb4_port_viid(f->dev) &
@@ -1319,52 +1345,87 @@ static void mk_act_open_req6(struct filter_entry *f, struct sk_buff *skb,
 				ULP_MODE_V(f->fs.nat_mode ?
 					   ULP_MODE_TCPDDP : ULP_MODE_NONE) |
 				TCAM_BYPASS_F | NON_OFFLOAD_F);
-	t6req->params = cpu_to_be64(FILTER_TUPLE_V(hash_filter_ntuple(&f->fs,
-								      f->dev)));
-	t6req->opt2 = htonl(RSS_QUEUE_VALID_F |
-			    RSS_QUEUE_V(f->fs.iq) |
-			    TX_QUEUE_V(f->fs.nat_mode) |
-			    T5_OPT_2_VALID_F |
-			    RX_CHANNEL_V(cxgb4_port_e2cchan(f->dev)) |
-			    PACE_V((f->fs.maskhash) |
+	opt2 = cpu_to_be32(RSS_QUEUE_VALID_F |
+			   RSS_QUEUE_V(f->fs.iq) |
+			   TX_QUEUE_V(f->fs.nat_mode) |
+			   T5_OPT_2_VALID_F |
+			   RX_CHANNEL_V(cxgb4_port_e2cchan(f->dev)) |
+			   PACE_V((f->fs.maskhash) |
 				   ((f->fs.dirsteerhash) << 1)));
+
+	if (chip_ver >= CHELSIO_T7) {
+		t7req = (struct cpl_t7_act_open_req6 *)__skb_put(skb, sizeof(*t7req));
+		INIT_TP_WR(t7req, 0);
+		req = (struct cpl_act_open_req6 *)t7req;
+		t7req->opt0 = opt0;
+		t7req->opt2 = opt2;
+		t7req->params = cpu_to_be64(T7_FILTER_TUPLE_V(hash_filter_ntuple(&f->fs, f->dev)));
+	} else {
+		t6req = (struct cpl_t6_act_open_req6 *)__skb_put(skb, sizeof(*t6req));
+		INIT_TP_WR(t6req, 0);
+		req = (struct cpl_act_open_req6 *)t6req;
+		t6req->opt0 = opt0;
+		t6req->opt2 = opt2;
+		t6req->params = cpu_to_be64(FILTER_TUPLE_V(hash_filter_ntuple(&f->fs, f->dev)));
+	}
+
+	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_ACT_OPEN_REQ6, qid_filterid));
+	req->local_port = cpu_to_be16(f->fs.val.lport);
+	req->peer_port = cpu_to_be16(f->fs.val.fport);
+	req->local_ip_hi = *(__be64 *)(&f->fs.val.lip);
+	req->local_ip_lo = *(((__be64 *)&f->fs.val.lip) + 1);
+	req->peer_ip_hi = *(__be64 *)(&f->fs.val.fip);
+	req->peer_ip_lo = *(((__be64 *)&f->fs.val.fip) + 1);
 }
 
 static void mk_act_open_req(struct filter_entry *f, struct sk_buff *skb,
 			    unsigned int qid_filterid, struct adapter *adap)
 {
 	struct cpl_t6_act_open_req *t6req = NULL;
+	struct cpl_t7_act_open_req *t7req = NULL;
 	struct cpl_act_open_req *req = NULL;
+	u32 chip_ver, opt2;
+	u64 opt0;
+
+	chip_ver = CHELSIO_CHIP_VERSION(adap->params.chip);
+
+	opt0 = cpu_to_be64(NAGLE_V(f->fs.newvlan == VLAN_REMOVE ||
+				   f->fs.newvlan == VLAN_REWRITE) |
+			   DELACK_V(f->fs.hitcnts) |
+			   L2T_IDX_V(f->l2t ? f->l2t->idx : 0) |
+			   SMAC_SEL_V((cxgb4_port_viid(f->dev) &
+				       0x7F) << 1) |
+			   TX_CHAN_V(f->fs.eport) |
+			   NO_CONG_V(f->fs.rpttid) |
+			   ULP_MODE_V(f->fs.nat_mode ?
+				      ULP_MODE_TCPDDP : ULP_MODE_NONE) |
+			   TCAM_BYPASS_F | NON_OFFLOAD_F);
+	opt2 = cpu_to_be32(RSS_QUEUE_VALID_F |
+			   RSS_QUEUE_V(f->fs.iq) |
+			   TX_QUEUE_V(f->fs.nat_mode) |
+			   T5_OPT_2_VALID_F |
+			   RX_CHANNEL_V(cxgb4_port_e2cchan(f->dev)) |
+			   PACE_V((f->fs.maskhash) |
+				  ((f->fs.dirsteerhash) << 1)));
+	if (chip_ver >= CHELSIO_T7) {
+		t7req = (struct cpl_t7_act_open_req *)__skb_put(skb, sizeof(*t7req));
+		INIT_TP_WR(t7req, 0);
+		req = (struct cpl_act_open_req *)t7req;
+		t7req->opt0 = opt0;
+		t7req->opt2 = opt2;
+		t7req->params = cpu_to_be64(T7_FILTER_TUPLE_V(hash_filter_ntuple(&f->fs, f->dev)));
+	} else {
+		t6req = (struct cpl_t6_act_open_req *)__skb_put(skb, sizeof(*t6req));
+		INIT_TP_WR(t6req, 0);
+		req = (struct cpl_act_open_req *)t6req;
+		t6req->opt0 = opt0;
+		t6req->opt2 = opt2;
+		t6req->params = cpu_to_be64(FILTER_TUPLE_V(hash_filter_ntuple(&f->fs, f->dev)));
+	}
 
-	t6req = (struct cpl_t6_act_open_req *)__skb_put(skb, sizeof(*t6req));
-	INIT_TP_WR(t6req, 0);
-	req = (struct cpl_act_open_req *)t6req;
-	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_ACT_OPEN_REQ, qid_filterid));
+	OPCODE_TID(req) = htonl(MK_OPCODE_TID(CPL_ACT_OPEN_REQ6, qid_filterid));
 	req->local_port = cpu_to_be16(f->fs.val.lport);
 	req->peer_port = cpu_to_be16(f->fs.val.fport);
-	memcpy(&req->local_ip, f->fs.val.lip, 4);
-	memcpy(&req->peer_ip, f->fs.val.fip, 4);
-	req->opt0 = cpu_to_be64(NAGLE_V(f->fs.newvlan == VLAN_REMOVE ||
-					f->fs.newvlan == VLAN_REWRITE) |
-				DELACK_V(f->fs.hitcnts) |
-				L2T_IDX_V(f->l2t ? f->l2t->idx : 0) |
-				SMAC_SEL_V((cxgb4_port_viid(f->dev) &
-					    0x7F) << 1) |
-				TX_CHAN_V(f->fs.eport) |
-				NO_CONG_V(f->fs.rpttid) |
-				ULP_MODE_V(f->fs.nat_mode ?
-					   ULP_MODE_TCPDDP : ULP_MODE_NONE) |
-				TCAM_BYPASS_F | NON_OFFLOAD_F);
-
-	t6req->params = cpu_to_be64(FILTER_TUPLE_V(hash_filter_ntuple(&f->fs,
-								      f->dev)));
-	t6req->opt2 = htonl(RSS_QUEUE_VALID_F |
-			    RSS_QUEUE_V(f->fs.iq) |
-			    TX_QUEUE_V(f->fs.nat_mode) |
-			    T5_OPT_2_VALID_F |
-			    RX_CHANNEL_V(cxgb4_port_e2cchan(f->dev)) |
-			    PACE_V((f->fs.maskhash) |
-				   ((f->fs.dirsteerhash) << 1)));
 }
 
 static int cxgb4_set_hash_filter(struct net_device *dev,
@@ -1663,9 +1724,9 @@ int __cxgb4_set_filter(struct net_device *dev, int ftid,
 	if (ret)
 		goto free_tid;
 
-	if (is_t6(adapter->params.chip) && fs->type &&
+	if (chip_ver >= CHELSIO_T6 && fs->type &&
 	    ipv6_addr_type((const struct in6_addr *)fs->val.lip) !=
-	    IPV6_ADDR_ANY) {
+		    IPV6_ADDR_ANY) {
 		ret = cxgb4_clip_get(dev, (const u32 *)&fs->val.lip, 1);
 		if (ret)
 			goto free_tid;
@@ -2140,12 +2201,13 @@ void filter_rpl(struct adapter *adap, const struct cpl_set_tcb_rpl *rpl)
 
 void init_hash_filter(struct adapter *adap)
 {
-	u32 reg;
+	u32 reg, chip_ver;
 
+	chip_ver = CHELSIO_CHIP_VERSION(adap->params.chip);
 	/* On T6, verify the necessary register configs and warn the user in
 	 * case of improper config
 	 */
-	if (is_t6(adap->params.chip)) {
+	if (chip_ver >= CHELSIO_T6) {
 		if (is_offload(adap)) {
 			if (!(t4_read_reg(adap, TP_GLOBAL_CONFIG_A)
 			   & ACTIVEFILTERCOUNTS_F)) {
diff --git a/drivers/net/ethernet/chelsio/cxgb4/sge.c b/drivers/net/ethernet/chelsio/cxgb4/sge.c
index 9fccb8ea9bcd..c0f3eb22ad8d 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -496,8 +496,8 @@ static inline void ring_fl_db(struct adapter *adap, struct sge_fl *q)
 		 * mechanism.
 		 */
 		if (unlikely(q->bar2_addr == NULL)) {
-			t4_write_reg(adap, MYPF_REG(SGE_PF_KDOORBELL_A),
-				     val | QID_V(q->cntxt_id));
+			writel(val | QID_V(q->cntxt_id),
+			       adap->sge.tx_db_addr);
 		} else {
 			writel(val | QID_V(q->bar2_qid),
 			       q->bar2_addr + SGE_UDB_KDOORBELL);
@@ -660,12 +660,13 @@ static void *alloc_ring(struct device *dev, size_t nelem, size_t elem_size,
 {
 	size_t len = nelem * elem_size + stat_size;
 	void *s = NULL;
-	void *p = dma_alloc_coherent(dev, len, phys, GFP_KERNEL);
+	void *p = dma_alloc_coherent(dev, len, phys, GFP_NOWAIT);
 
-	if (!p)
+	if (!p) {
 		return NULL;
+	}
 	if (sw_size) {
-		s = kcalloc_node(sw_size, nelem, GFP_KERNEL, node);
+		s = kcalloc_node(sw_size, nelem, GFP_NOWAIT, node);
 
 		if (!s) {
 			dma_free_coherent(dev, len, p, *phys);
@@ -734,14 +735,14 @@ static inline int is_eth_imm(const struct sk_buff *skb, unsigned int chip_ver)
 	if (skb->encapsulation && skb_shinfo(skb)->gso_size &&
 	    chip_ver > CHELSIO_T5) {
 		hdrlen = sizeof(struct cpl_tx_tnl_lso);
-		hdrlen += sizeof(struct cpl_tx_pkt_core);
 	} else if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) {
 		return 0;
 	} else {
 		hdrlen = skb_shinfo(skb)->gso_size ?
 			 sizeof(struct cpl_tx_pkt_lso_core) : 0;
-		hdrlen += sizeof(struct cpl_tx_pkt);
 	}
+
+	hdrlen += sizeof(struct cpl_tx_pkt);
 	if (skb->len <= MAX_IMM_TX_PKT_LEN - hdrlen)
 		return hdrlen;
 	return 0;
@@ -1027,8 +1028,8 @@ inline void cxgb4_ring_tx_db(struct adapter *adap, struct sge_txq *q, int n)
 		 */
 		spin_lock_irqsave(&q->db_lock, flags);
 		if (!q->db_disabled)
-			t4_write_reg(adap, MYPF_REG(SGE_PF_KDOORBELL_A),
-				     QID_V(q->cntxt_id) | val);
+			writel(val | QID_V(q->cntxt_id),
+			       adap->sge.tx_db_addr);
 		else
 			q->db_pidx_inc += n;
 		q->db_pidx = q->pidx;
@@ -1299,6 +1300,7 @@ enum cpl_tx_tnl_lso_type cxgb_encap_offload_supported(struct sk_buff *skb)
 
 	return tnl_type;
 }
+EXPORT_SYMBOL(cxgb_encap_offload_supported);
 
 static inline void t6_fill_tnl_lso(struct sk_buff *skb,
 				   struct cpl_tx_tnl_lso *tnl_lso,
@@ -1510,6 +1512,7 @@ static netdev_tx_t cxgb4_eth_xmit(struct sk_buff *skb, struct net_device *dev)
 	pi = netdev_priv(dev);
 	adap = pi->adapter;
 	ssi = skb_shinfo(skb);
+
 #if IS_ENABLED(CONFIG_CHELSIO_IPSEC_INLINE)
 	if (xfrm_offload(skb) && !ssi->gso_size)
 		return adap->uld[CXGB4_ULD_IPSEC].tx_handler(skb, dev);
@@ -1690,7 +1693,7 @@ static netdev_tx_t cxgb4_eth_xmit(struct sk_buff *skb, struct net_device *dev)
 #endif /* CONFIG_CHELSIO_T4_FCOE */
 	}
 
-	ctrl0 = TXPKT_OPCODE_V(CPL_TX_PKT_XT) | TXPKT_INTF_V(pi->tx_chan) |
+	ctrl0 = TXPKT_OPCODE_V(CPL_TX_PKT_XT) | TXPKT_INTF_V(pi->lport) |
 		TXPKT_PF_V(adap->pf);
 	if (ptp_enabled)
 		ctrl0 |= TXPKT_TSTAMP_F;
@@ -1996,7 +1999,7 @@ static netdev_tx_t cxgb4_vf_eth_xmit(struct sk_buff *skb,
 
 	 /* Fill in the TX Packet CPL message header. */
 	cpl->ctrl0 = cpu_to_be32(TXPKT_OPCODE_V(CPL_TX_PKT_XT) |
-				 TXPKT_INTF_V(pi->port_id) |
+				 TXPKT_INTF_V(pi->lport) |
 				 TXPKT_PF_V(0));
 	cpl->pack = cpu_to_be16(0);
 	cpl->len = cpu_to_be16(skb->len);
@@ -3036,6 +3039,7 @@ static void service_ofldq(struct sge_uld_txq *q)
 		__skb_unlink(skb, &q->sendq);
 		if (is_ofld_imm(skb))
 			kfree_skb(skb);
+
 	}
 	if (likely(written))
 		cxgb4_ring_tx_db(q->adap, &q->q, written);
@@ -3662,17 +3666,17 @@ static int cxgb4_validate_lb_pkt(struct port_info *pi, const struct pkt_gl *si)
 int t4_ethrx_handler(struct sge_rspq *q, const __be64 *rsp,
 		     const struct pkt_gl *si)
 {
-	bool csum_ok;
-	struct sk_buff *skb;
-	const struct cpl_rx_pkt *pkt;
 	struct sge_eth_rxq *rxq = container_of(q, struct sge_eth_rxq, rspq);
 	struct adapter *adapter = q->adap;
 	struct sge *s = &q->adap->sge;
 	int cpl_trace_pkt = is_t4(q->adap->params.chip) ?
 			    CPL_TRACE_PKT : CPL_TRACE_PKT_T5;
 	u16 err_vec, tnl_hdr_len = 0;
+	const struct cpl_rx_pkt *pkt;
+	struct sk_buff *skb;
 	struct port_info *pi;
 	int ret = 0;
+	bool csum_ok;
 
 	pi = netdev_priv(q->netdev);
 	/* If we're looking at TX Queue CIDX Update, handle that separately
@@ -4011,8 +4015,8 @@ static int napi_rx_handler(struct napi_struct *napi, int budget)
 	 * doorbell mechanism; otherwise use the new BAR2 mechanism.
 	 */
 	if (unlikely(q->bar2_addr == NULL)) {
-		t4_write_reg(q->adap, MYPF_REG(SGE_PF_GTS_A),
-			     val | INGRESSQID_V((u32)q->cntxt_id));
+		writel(val | INGRESSQID_V((u32)q->cntxt_id),
+		       q->adap->sge.rx_db_addr);
 	} else {
 		writel(val | INGRESSQID_V(q->bar2_qid),
 		       q->bar2_addr + SGE_UDB_GTS);
@@ -4346,6 +4350,9 @@ static void __iomem *bar2_address(struct adapter *adapter,
 	u64 bar2_qoffset;
 	int ret;
 
+	if (!adapter->bar2)
+		return NULL;
+
 	ret = t4_bar2_sge_qregs(adapter, qid, qtype, 0,
 				&bar2_qoffset, pbar2_qid);
 	if (ret)
@@ -4389,7 +4396,7 @@ int t4_sge_alloc_rxq(struct adapter *adap, struct sge_rspq *iq, bool fwevtq,
 		FW_IQ_CMD_IQANUD_V(UPDATEDELIVERY_INTERRUPT_X) |
 		FW_IQ_CMD_IQANDSTINDEX_V(intr_idx >= 0 ? intr_idx :
 							-intr_idx - 1));
-	c.iqdroprss_to_iqesize = htons(FW_IQ_CMD_IQPCIECH_V(pi->tx_chan) |
+	c.iqdroprss_to_iqesize = htons(FW_IQ_CMD_IQPCIECH_V(cxgb4_port_chan(dev)) |
 		FW_IQ_CMD_IQGTSMODE_F |
 		FW_IQ_CMD_IQINTCNTTHRESH_V(iq->pktcnt_idx) |
 		FW_IQ_CMD_IQESIZE_V(ilog2(iq->iqe_len) - 4));
@@ -4409,17 +4416,19 @@ int t4_sge_alloc_rxq(struct adapter *adap, struct sge_rspq *iq, bool fwevtq,
 		 * descriptor ring.  The free list size needs to be a multiple
 		 * of the Egress Queue Unit and at least 2 Egress Units larger
 		 * than the SGE's Egress Congrestion Threshold
-		 * (fl_starve_thres - 1).
+		 * (fl_starve_thres).
 		 */
-		if (fl->size < s->fl_starve_thres - 1 + 2 * 8)
-			fl->size = s->fl_starve_thres - 1 + 2 * 8;
+		if (fl->size < s->fl_starve_thres + 2 * 8)
+			fl->size = s->fl_starve_thres + 2 * 8;
 		fl->size = roundup(fl->size, 8);
 		fl->desc = alloc_ring(adap->pdev_dev, fl->size, sizeof(__be64),
 				      sizeof(struct rx_sw_desc), &fl->addr,
 				      &fl->sdesc, s->stat_len,
 				      dev_to_node(adap->pdev_dev));
-		if (!fl->desc)
-			goto fl_nomem;
+		if (!fl->desc) {
+			ret = -ENOMEM;
+			goto err;
+		}
 
 		flsz = fl->size / 8 + s->stat_len / sizeof(struct tx_desc);
 		c.iqns_to_fl0congen |= htonl(FW_IQ_CMD_FL0PACKEN_F |
@@ -4532,8 +4541,6 @@ int t4_sge_alloc_rxq(struct adapter *adap, struct sge_rspq *iq, bool fwevtq,
 
 	return 0;
 
-fl_nomem:
-	ret = -ENOMEM;
 err:
 	if (iq->desc) {
 		dma_free_coherent(adap->pdev_dev, iq->size * iq->iqe_len,
@@ -4576,7 +4583,7 @@ static void init_txq(struct adapter *adap, struct sge_txq *q, unsigned int id)
  */
 int t4_sge_alloc_eth_txq(struct adapter *adap, struct sge_eth_txq *txq,
 			 struct net_device *dev, struct netdev_queue *netdevq,
-			 unsigned int iqid, u8 dbqt)
+			 unsigned int iqid, u8 dbqt, int index)
 {
 	unsigned int chip_ver = CHELSIO_CHIP_VERSION(adap->params.chip);
 	struct port_info *pi = netdev_priv(dev);
@@ -4584,6 +4591,9 @@ int t4_sge_alloc_eth_txq(struct adapter *adap, struct sge_eth_txq *txq,
 	struct fw_eq_eth_cmd c;
 	int ret, nentries;
 
+	if (adap->params.num_up_cores > 1)
+		txq->group_id = index % adap->params.num_up_cores;
+
 	/* Add status entries */
 	nentries = txq->q.size + s->stat_len / sizeof(struct tx_desc);
 
@@ -4600,7 +4610,9 @@ int t4_sge_alloc_eth_txq(struct adapter *adap, struct sge_eth_txq *txq,
 			    FW_EQ_ETH_CMD_PFN_V(adap->pf) |
 			    FW_EQ_ETH_CMD_VFN_V(0));
 	c.alloc_to_len16 = htonl(FW_EQ_ETH_CMD_ALLOC_F |
-				 FW_EQ_ETH_CMD_EQSTART_F | FW_LEN16(c));
+				 FW_EQ_ETH_CMD_EQSTART_F |
+				 FW_EQ_ETH_CMD_COREGROUP_V(txq->group_id) |
+				 (sizeof(c) / 16));
 
 	/* For TX Ethernet Queues using the SGE Doorbell Queue Timer
 	 * mechanism, we use Ingress Queue messages for Hardware Consumer
@@ -4617,7 +4629,7 @@ int t4_sge_alloc_eth_txq(struct adapter *adap, struct sge_eth_txq *txq,
 		htonl(FW_EQ_ETH_CMD_HOSTFCMODE_V((chip_ver <= CHELSIO_T5) ?
 						 HOSTFCMODE_INGRESS_QUEUE_X :
 						 HOSTFCMODE_STATUS_PAGE_X) |
-		      FW_EQ_ETH_CMD_PCIECHN_V(pi->tx_chan) |
+		      FW_EQ_ETH_CMD_PCIECHN_V(cxgb4_port_chan(dev)) |
 		      FW_EQ_ETH_CMD_FETCHRO_F | FW_EQ_ETH_CMD_IQID_V(iqid));
 
 	/* Note that the CIDX Flush Threshold should match MAX_TX_RECLAIM. */
@@ -4644,18 +4656,12 @@ int t4_sge_alloc_eth_txq(struct adapter *adap, struct sge_eth_txq *txq,
 				    FW_EQ_ETH_CMD_TIMERIX_V(txq->dbqtimerix));
 
 	ret = t4_wr_mbox(adap, adap->mbox, &c, sizeof(c), &c);
-	if (ret) {
-		kfree(txq->q.sdesc);
-		txq->q.sdesc = NULL;
-		dma_free_coherent(adap->pdev_dev,
-				  nentries * sizeof(struct tx_desc),
-				  txq->q.desc, txq->q.phys_addr);
-		txq->q.desc = NULL;
-		return ret;
-	}
+	if (ret < 0)
+		goto out_free_txq;
 
 	txq->q.q_type = CXGB4_TXQ_ETH;
 	init_txq(adap, &txq->q, FW_EQ_ETH_CMD_EQID_G(ntohl(c.eqid_pkd)));
+
 	txq->txq = netdevq;
 	txq->tso = 0;
 	txq->uso = 0;
@@ -4663,19 +4669,30 @@ int t4_sge_alloc_eth_txq(struct adapter *adap, struct sge_eth_txq *txq,
 	txq->vlan_ins = 0;
 	txq->mapping_err = 0;
 	txq->dbqt = dbqt;
-
 	return 0;
+
+out_free_txq:
+	kfree(txq->q.sdesc);
+	txq->q.sdesc = NULL;
+	dma_free_coherent(adap->pdev_dev, nentries * sizeof(struct tx_desc),
+			  txq->q.desc, txq->q.phys_addr);
+	txq->q.desc = NULL;
+	return ret;
 }
 
 int t4_sge_alloc_ctrl_txq(struct adapter *adap, struct sge_ctrl_txq *txq,
 			  struct net_device *dev, unsigned int iqid,
-			  unsigned int cmplqid)
+			  unsigned int cmplqid, int index)
 {
 	unsigned int chip_ver = CHELSIO_CHIP_VERSION(adap->params.chip);
-	struct port_info *pi = netdev_priv(dev);
 	struct sge *s = &adap->sge;
 	struct fw_eq_ctrl_cmd c;
-	int ret, nentries;
+	int ret, nentries, ngroups;
+
+	ngroups = (adap->params.tid_qid_sel_mask >>
+			adap->params.tid_qid_sel_shift) + 1;
+	if (adap->params.tid_qid_sel_mask)
+		txq->tid_qid_group_id = index % ngroups;
 
 	/* Add status entries */
 	nentries = txq->q.size + s->stat_len / sizeof(struct tx_desc);
@@ -4691,12 +4708,14 @@ int t4_sge_alloc_ctrl_txq(struct adapter *adap, struct sge_ctrl_txq *txq,
 			    FW_EQ_CTRL_CMD_PFN_V(adap->pf) |
 			    FW_EQ_CTRL_CMD_VFN_V(0));
 	c.alloc_to_len16 = htonl(FW_EQ_CTRL_CMD_ALLOC_F |
-				 FW_EQ_CTRL_CMD_EQSTART_F | FW_LEN16(c));
+				 FW_EQ_CTRL_CMD_EQSTART_F |
+				 FW_EQ_CTRL_CMD_COREGROUP_V(txq->tid_qid_group_id) |
+				 (sizeof(c) / 16));
 	c.cmpliqid_eqid = htonl(FW_EQ_CTRL_CMD_CMPLIQID_V(cmplqid));
 	c.physeqid_pkd = htonl(0);
 	c.fetchszm_to_iqid =
 		htonl(FW_EQ_CTRL_CMD_HOSTFCMODE_V(HOSTFCMODE_STATUS_PAGE_X) |
-		      FW_EQ_CTRL_CMD_PCIECHN_V(pi->tx_chan) |
+		      FW_EQ_CTRL_CMD_PCIECHN_V(cxgb4_port_chan(dev)) |
 		      FW_EQ_CTRL_CMD_FETCHRO_F | FW_EQ_CTRL_CMD_IQID_V(iqid));
 	c.dcaen_to_eqsize =
 		htonl(FW_EQ_CTRL_CMD_FBMIN_V(chip_ver <= CHELSIO_T5
@@ -4708,21 +4727,23 @@ int t4_sge_alloc_ctrl_txq(struct adapter *adap, struct sge_ctrl_txq *txq,
 	c.eqaddr = cpu_to_be64(txq->q.phys_addr);
 
 	ret = t4_wr_mbox(adap, adap->mbox, &c, sizeof(c), &c);
-	if (ret) {
-		dma_free_coherent(adap->pdev_dev,
-				  nentries * sizeof(struct tx_desc),
-				  txq->q.desc, txq->q.phys_addr);
-		txq->q.desc = NULL;
-		return ret;
-	}
+	if (ret < 0)
+		goto out_free_ctrlq;
 
-	txq->q.q_type = CXGB4_TXQ_CTRL;
 	init_txq(adap, &txq->q, FW_EQ_CTRL_CMD_EQID_G(ntohl(c.cmpliqid_eqid)));
+
+	txq->q.q_type = CXGB4_TXQ_CTRL;
 	txq->adap = adap;
 	skb_queue_head_init(&txq->sendq);
 	tasklet_setup(&txq->qresume_tsk, restart_ctrlq);
 	txq->full = 0;
 	return 0;
+
+out_free_ctrlq:
+	dma_free_coherent(adap->pdev_dev, nentries * sizeof(struct tx_desc),
+			  txq->q.desc, txq->q.phys_addr);
+	txq->q.desc = NULL;
+	return ret;
 }
 
 int t4_sge_mod_ctrl_txq(struct adapter *adap, unsigned int eqid,
@@ -5182,6 +5203,7 @@ int t4_sge_init(struct adapter *adap)
 		egress_threshold = EGRTHRESHOLDPACKING_G(sge_conm_ctrl);
 		break;
 	case CHELSIO_T6:
+	case CHELSIO_T7:
 		egress_threshold = T6_EGRTHRESHOLDPACKING_G(sge_conm_ctrl);
 		break;
 	default:
-- 
2.39.1


