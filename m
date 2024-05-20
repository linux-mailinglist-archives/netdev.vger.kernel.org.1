Return-Path: <netdev+bounces-97164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDE08C9A56
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 11:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8481F21AF9
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 09:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875421CA87;
	Mon, 20 May 2024 09:29:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.der-flo.net (mx.der-flo.net [193.160.39.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F3F1B27D;
	Mon, 20 May 2024 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.160.39.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716197382; cv=none; b=BEN7wnMcRYt4WbCt4FhgYQM8Y+6I+VkrplI0JXPs9zrFjEDGraaZE1VF/GziomB7AdnffCU6B5axO47fzj8gKylpZzSgqi/5GXE5iXB+C/LXXqRNr5tY82mMolT5L/fdrfZgV2EI/j9LzaJZ4Lv3awhqUt0bchpTZ36xT3wQkZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716197382; c=relaxed/simple;
	bh=SZYZZ5m4hxbxr2qYdBFsTSgOkIcGmrJU4lQ37BRL5oc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iJUrJgjq8PzGvheL+gLnVu7FYVyNOPnr4lF2O+1RidAHCZSdmcb2r9zXT9ga9lc1biEacUn9BIxI47fIeU2G6IgnossfJgypFHiOqqGoXTm6I45rUXZmhbptUl//p3yiOgLR5AG/CUBcfJfn+6tkIHlNq7/xRJKprbo5XZwBynU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=der-flo.net; spf=pass smtp.mailfrom=der-flo.net; arc=none smtp.client-ip=193.160.39.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=der-flo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=der-flo.net
From: Florian Lehner <dev@der-flo.net>
To: linux-kernel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	Florian Lehner <dev@der-flo.net>
Subject: [PATCH] net: sync headers
Date: Mon, 20 May 2024 11:21:45 +0200
Message-ID: <20240520092145.13575-1-dev@der-flo.net>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header files include/uapi/linux/pkt_cls.h and
tools/include/uapi/linux/pkt_cls.h did become out of sync. Update the later
with the changes from the former.

Signed-off-by: Florian Lehner <dev@der-flo.net>
---
 tools/include/uapi/linux/pkt_cls.h | 230 ++++++++++++++++++++++++++++-
 1 file changed, 226 insertions(+), 4 deletions(-)

diff --git a/tools/include/uapi/linux/pkt_cls.h b/tools/include/uapi/linux/pkt_cls.h
index bd4b227ab..229fc925e 100644
--- a/tools/include/uapi/linux/pkt_cls.h
+++ b/tools/include/uapi/linux/pkt_cls.h
@@ -16,9 +16,40 @@ enum {
 	TCA_ACT_STATS,
 	TCA_ACT_PAD,
 	TCA_ACT_COOKIE,
+	TCA_ACT_FLAGS,
+	TCA_ACT_HW_STATS,
+	TCA_ACT_USED_HW_STATS,
+	TCA_ACT_IN_HW_COUNT,
 	__TCA_ACT_MAX
 };
 
+/* See other TCA_ACT_FLAGS_ * flags in include/net/act_api.h. */
+#define TCA_ACT_FLAGS_NO_PERCPU_STATS (1 << 0) /* Don't use percpu allocator for
+						* actions stats.
+						*/
+#define TCA_ACT_FLAGS_SKIP_HW	(1 << 1) /* don't offload action to HW */
+#define TCA_ACT_FLAGS_SKIP_SW	(1 << 2) /* don't use action in SW */
+
+/* tca HW stats type
+ * When user does not pass the attribute, he does not care.
+ * It is the same as if he would pass the attribute with
+ * all supported bits set.
+ * In case no bits are set, user is not interested in getting any HW statistics.
+ */
+#define TCA_ACT_HW_STATS_IMMEDIATE (1 << 0) /* Means that in dump, user
+					     * gets the current HW stats
+					     * state from the device
+					     * queried at the dump time.
+					     */
+#define TCA_ACT_HW_STATS_DELAYED (1 << 1) /* Means that in dump, user gets
+					   * HW stats that might be out of date
+					   * for some time, maybe couple of
+					   * seconds. This is the case when
+					   * driver polls stats updates
+					   * periodically or when it gets async
+					   * stats update from the device.
+					   */
+
 #define TCA_ACT_MAX __TCA_ACT_MAX
 #define TCA_OLD_COMPAT (TCA_ACT_MAX+1)
 #define TCA_ACT_MAX_PRIO 32
@@ -63,12 +94,53 @@ enum {
 #define TC_ACT_GOTO_CHAIN __TC_ACT_EXT(2)
 #define TC_ACT_EXT_OPCODE_MAX	TC_ACT_GOTO_CHAIN
 
+/* These macros are put here for binary compatibility with userspace apps that
+ * make use of them. For kernel code and new userspace apps, use the TCA_ID_*
+ * versions.
+ */
+#define TCA_ACT_GACT 5
+#define TCA_ACT_IPT 6 /* obsoleted, can be reused */
+#define TCA_ACT_PEDIT 7
+#define TCA_ACT_MIRRED 8
+#define TCA_ACT_NAT 9
+#define TCA_ACT_XT 10
+#define TCA_ACT_SKBEDIT 11
+#define TCA_ACT_VLAN 12
+#define TCA_ACT_BPF 13
+#define TCA_ACT_CONNMARK 14
+#define TCA_ACT_SKBMOD 15
+#define TCA_ACT_CSUM 16
+#define TCA_ACT_TUNNEL_KEY 17
+#define TCA_ACT_SIMP 22
+#define TCA_ACT_IFE 25
+#define TCA_ACT_SAMPLE 26
+
 /* Action type identifiers*/
-enum {
-	TCA_ID_UNSPEC=0,
-	TCA_ID_POLICE=1,
+enum tca_id {
+	TCA_ID_UNSPEC = 0,
+	TCA_ID_POLICE = 1,
+	TCA_ID_GACT = TCA_ACT_GACT,
+	TCA_ID_IPT = TCA_ACT_IPT, /* Obsoleted, can be reused */
+	TCA_ID_PEDIT = TCA_ACT_PEDIT,
+	TCA_ID_MIRRED = TCA_ACT_MIRRED,
+	TCA_ID_NAT = TCA_ACT_NAT,
+	TCA_ID_XT = TCA_ACT_XT,
+	TCA_ID_SKBEDIT = TCA_ACT_SKBEDIT,
+	TCA_ID_VLAN = TCA_ACT_VLAN,
+	TCA_ID_BPF = TCA_ACT_BPF,
+	TCA_ID_CONNMARK = TCA_ACT_CONNMARK,
+	TCA_ID_SKBMOD = TCA_ACT_SKBMOD,
+	TCA_ID_CSUM = TCA_ACT_CSUM,
+	TCA_ID_TUNNEL_KEY = TCA_ACT_TUNNEL_KEY,
+	TCA_ID_SIMP = TCA_ACT_SIMP,
+	TCA_ID_IFE = TCA_ACT_IFE,
+	TCA_ID_SAMPLE = TCA_ACT_SAMPLE,
+	TCA_ID_CTINFO,
+	TCA_ID_MPLS,
+	TCA_ID_CT,
+	TCA_ID_GATE,
 	/* other actions go here */
-	__TCA_ID_MAX=255
+	__TCA_ID_MAX = 255
 };
 
 #define TCA_ID_MAX __TCA_ID_MAX
@@ -120,6 +192,10 @@ enum {
 	TCA_POLICE_RESULT,
 	TCA_POLICE_TM,
 	TCA_POLICE_PAD,
+	TCA_POLICE_RATE64,
+	TCA_POLICE_PEAKRATE64,
+	TCA_POLICE_PKTRATE64,
+	TCA_POLICE_PKTBURST64,
 	__TCA_POLICE_MAX
 #define TCA_POLICE_RESULT TCA_POLICE_RESULT
 };
@@ -286,12 +362,19 @@ enum {
 
 /* Basic filter */
 
+struct tc_basic_pcnt {
+	__u64 rcnt;
+	__u64 rhit;
+};
+
 enum {
 	TCA_BASIC_UNSPEC,
 	TCA_BASIC_CLASSID,
 	TCA_BASIC_EMATCHES,
 	TCA_BASIC_ACT,
 	TCA_BASIC_POLICE,
+	TCA_BASIC_PCNT,
+	TCA_BASIC_PAD,
 	__TCA_BASIC_MAX
 };
 
@@ -438,17 +521,76 @@ enum {
 
 	TCA_FLOWER_IN_HW_COUNT,
 
+	TCA_FLOWER_KEY_PORT_SRC_MIN,	/* be16 */
+	TCA_FLOWER_KEY_PORT_SRC_MAX,	/* be16 */
+	TCA_FLOWER_KEY_PORT_DST_MIN,	/* be16 */
+	TCA_FLOWER_KEY_PORT_DST_MAX,	/* be16 */
+
+	TCA_FLOWER_KEY_CT_STATE,	/* u16 */
+	TCA_FLOWER_KEY_CT_STATE_MASK,	/* u16 */
+	TCA_FLOWER_KEY_CT_ZONE,		/* u16 */
+	TCA_FLOWER_KEY_CT_ZONE_MASK,	/* u16 */
+	TCA_FLOWER_KEY_CT_MARK,		/* u32 */
+	TCA_FLOWER_KEY_CT_MARK_MASK,	/* u32 */
+	TCA_FLOWER_KEY_CT_LABELS,	/* u128 */
+	TCA_FLOWER_KEY_CT_LABELS_MASK,	/* u128 */
+
+	TCA_FLOWER_KEY_MPLS_OPTS,
+
+	TCA_FLOWER_KEY_HASH,		/* u32 */
+	TCA_FLOWER_KEY_HASH_MASK,	/* u32 */
+
+	TCA_FLOWER_KEY_NUM_OF_VLANS,    /* u8 */
+
+	TCA_FLOWER_KEY_PPPOE_SID,	/* be16 */
+	TCA_FLOWER_KEY_PPP_PROTO,	/* be16 */
+
+	TCA_FLOWER_KEY_L2TPV3_SID,	/* be32 */
+
+	TCA_FLOWER_L2_MISS,		/* u8 */
+
+	TCA_FLOWER_KEY_CFM,		/* nested */
+
+	TCA_FLOWER_KEY_SPI,		/* be32 */
+	TCA_FLOWER_KEY_SPI_MASK,	/* be32 */
+
 	__TCA_FLOWER_MAX,
 };
 
 #define TCA_FLOWER_MAX (__TCA_FLOWER_MAX - 1)
 
+enum {
+	TCA_FLOWER_KEY_CT_FLAGS_NEW = 1 << 0, /* Beginning of a new connection. */
+	TCA_FLOWER_KEY_CT_FLAGS_ESTABLISHED = 1 << 1, /* Part of an existing connection. */
+	TCA_FLOWER_KEY_CT_FLAGS_RELATED = 1 << 2, /* Related to an established connection. */
+	TCA_FLOWER_KEY_CT_FLAGS_TRACKED = 1 << 3, /* Conntrack has occurred. */
+	TCA_FLOWER_KEY_CT_FLAGS_INVALID = 1 << 4, /* Conntrack is invalid. */
+	TCA_FLOWER_KEY_CT_FLAGS_REPLY = 1 << 5, /* Packet is in the reply direction. */
+	__TCA_FLOWER_KEY_CT_FLAGS_MAX,
+};
+
 enum {
 	TCA_FLOWER_KEY_ENC_OPTS_UNSPEC,
 	TCA_FLOWER_KEY_ENC_OPTS_GENEVE, /* Nested
 					 * TCA_FLOWER_KEY_ENC_OPT_GENEVE_
 					 * attributes
 					 */
+	TCA_FLOWER_KEY_ENC_OPTS_VXLAN,	/* Nested
+					 * TCA_FLOWER_KEY_ENC_OPT_VXLAN_
+					 * attributes
+					 */
+	TCA_FLOWER_KEY_ENC_OPTS_ERSPAN,	/* Nested
+					 * TCA_FLOWER_KEY_ENC_OPT_ERSPAN_
+					 * attributes
+					 */
+	TCA_FLOWER_KEY_ENC_OPTS_GTP,	/* Nested
+					 * TCA_FLOWER_KEY_ENC_OPT_GTP_
+					 * attributes
+					 */
+	TCA_FLOWER_KEY_ENC_OPTS_PFCP,	/* Nested
+					 * TCA_FLOWER_KEY_ENC_IPT_PFCP
+					 * attributes
+					 */
 	__TCA_FLOWER_KEY_ENC_OPTS_MAX,
 };
 
@@ -466,18 +608,98 @@ enum {
 #define TCA_FLOWER_KEY_ENC_OPT_GENEVE_MAX \
 		(__TCA_FLOWER_KEY_ENC_OPT_GENEVE_MAX - 1)
 
+enum {
+	TCA_FLOWER_KEY_ENC_OPT_VXLAN_UNSPEC,
+	TCA_FLOWER_KEY_ENC_OPT_VXLAN_GBP,		/* u32 */
+	__TCA_FLOWER_KEY_ENC_OPT_VXLAN_MAX,
+};
+
+#define TCA_FLOWER_KEY_ENC_OPT_VXLAN_MAX \
+		(__TCA_FLOWER_KEY_ENC_OPT_VXLAN_MAX - 1)
+
+enum {
+	TCA_FLOWER_KEY_ENC_OPT_ERSPAN_UNSPEC,
+	TCA_FLOWER_KEY_ENC_OPT_ERSPAN_VER,              /* u8 */
+	TCA_FLOWER_KEY_ENC_OPT_ERSPAN_INDEX,            /* be32 */
+	TCA_FLOWER_KEY_ENC_OPT_ERSPAN_DIR,              /* u8 */
+	TCA_FLOWER_KEY_ENC_OPT_ERSPAN_HWID,             /* u8 */
+	__TCA_FLOWER_KEY_ENC_OPT_ERSPAN_MAX,
+};
+
+#define TCA_FLOWER_KEY_ENC_OPT_ERSPAN_MAX \
+		(__TCA_FLOWER_KEY_ENC_OPT_ERSPAN_MAX - 1)
+
+enum {
+	TCA_FLOWER_KEY_ENC_OPT_GTP_UNSPEC,
+	TCA_FLOWER_KEY_ENC_OPT_GTP_PDU_TYPE,		/* u8 */
+	TCA_FLOWER_KEY_ENC_OPT_GTP_QFI,			/* u8 */
+
+	__TCA_FLOWER_KEY_ENC_OPT_GTP_MAX,
+};
+
+#define TCA_FLOWER_KEY_ENC_OPT_GTP_MAX \
+		(__TCA_FLOWER_KEY_ENC_OPT_GTP_MAX - 1)
+
+enum {
+	TCA_FLOWER_KEY_ENC_OPT_PFCP_UNSPEC,
+	TCA_FLOWER_KEY_ENC_OPT_PFCP_TYPE,		/* u8 */
+	TCA_FLOWER_KEY_ENC_OPT_PFCP_SEID,		/* be64 */
+	__TCA_FLOWER_KEY_ENC_OPT_PFCP_MAX,
+};
+
+#define TCA_FLOWER_KEY_ENC_OPT_PFCP_MAX \
+		(__TCA_FLOWER_KEY_ENC_OPT_PFCP_MAX - 1)
+
+enum {
+	TCA_FLOWER_KEY_MPLS_OPTS_UNSPEC,
+	TCA_FLOWER_KEY_MPLS_OPTS_LSE,
+	__TCA_FLOWER_KEY_MPLS_OPTS_MAX,
+};
+
+#define TCA_FLOWER_KEY_MPLS_OPTS_MAX (__TCA_FLOWER_KEY_MPLS_OPTS_MAX - 1)
+
+enum {
+	TCA_FLOWER_KEY_MPLS_OPT_LSE_UNSPEC,
+	TCA_FLOWER_KEY_MPLS_OPT_LSE_DEPTH,
+	TCA_FLOWER_KEY_MPLS_OPT_LSE_TTL,
+	TCA_FLOWER_KEY_MPLS_OPT_LSE_BOS,
+	TCA_FLOWER_KEY_MPLS_OPT_LSE_TC,
+	TCA_FLOWER_KEY_MPLS_OPT_LSE_LABEL,
+	__TCA_FLOWER_KEY_MPLS_OPT_LSE_MAX,
+};
+
+#define TCA_FLOWER_KEY_MPLS_OPT_LSE_MAX \
+		(__TCA_FLOWER_KEY_MPLS_OPT_LSE_MAX - 1)
+
 enum {
 	TCA_FLOWER_KEY_FLAGS_IS_FRAGMENT = (1 << 0),
 	TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST = (1 << 1),
 };
 
+enum {
+	TCA_FLOWER_KEY_CFM_OPT_UNSPEC,
+	TCA_FLOWER_KEY_CFM_MD_LEVEL,
+	TCA_FLOWER_KEY_CFM_OPCODE,
+	__TCA_FLOWER_KEY_CFM_OPT_MAX,
+};
+
+#define TCA_FLOWER_KEY_CFM_OPT_MAX (__TCA_FLOWER_KEY_CFM_OPT_MAX - 1)
+
+#define TCA_FLOWER_MASK_FLAGS_RANGE	(1 << 0) /* Range-based match */
+
 /* Match-all classifier */
 
+struct tc_matchall_pcnt {
+	__u64 rhit;
+};
+
 enum {
 	TCA_MATCHALL_UNSPEC,
 	TCA_MATCHALL_CLASSID,
 	TCA_MATCHALL_ACT,
 	TCA_MATCHALL_FLAGS,
+	TCA_MATCHALL_PCNT,
+	TCA_MATCHALL_PAD,
 	__TCA_MATCHALL_MAX,
 };
 
-- 
2.45.1


