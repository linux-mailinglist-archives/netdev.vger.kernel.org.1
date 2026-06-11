Return-Path: <netdev+bounces-297936-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zuAAFcRAKmr3lAMAu9opvQ
	(envelope-from <netdev+bounces-297936-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 06:59:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 000EA66E56E
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 06:59:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="Ey+sN/NQ";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297936-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297936-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3615B3027722
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A592DCBE3;
	Thu, 11 Jun 2026 04:58:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111D4285CAA
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 04:58:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781153936; cv=none; b=AsxHn6us1Um1uFyfoTXw2nkjoxE8Ec1Hzpr5MEFwSIX3rtMzwz7FZ69FQ81DPhhwpFBk7RO4T3ePLJ9w0XLUsadfhWeA7UANpLgYm+3SkfxiS6QHaitAKMCfc5eT7LsgefrZ0olMiCfWy8oc46pJkk3LV2eh3uLUQVzw5yEGpDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781153936; c=relaxed/simple;
	bh=2qfnt+wZRj6JT1aj1K+syrX61MBdIAZkFgpsgDKWubg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAiuilLhx6EL5vPnzxXJjSsP1z/65rkMaryDbb2DjcoAvIrC30KJ97m3syMM/0ziZLtdHVWO8pW3XRgclPYPru11EPtLUrPEJmPvsjYacj1j4J34eRQsO8Ie8puRiwSm81HZKJcPqFfGaP2jJjjUGDznO6O7KBvd1CIp/a581LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ey+sN/NQ; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781153922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PFmJsf6MvdoHYejngdjqquJEZS9kJeMvjC/D3SO0e5E=;
	b=Ey+sN/NQL9941wEN+Ph5TYWVp+jeL2EAkejDHZDREzgbrpyQ/A1buu3+ev4Ur56HV53ZmC
	KJLYmoMSS0AatEb5QsADbd6hV5X3ERAIhmebCjQrFCieQ5g4fVqEZ31bBXAD/6LUWCj4wT
	nyCdFbEPIaR0Lt/q54sSRF+42708YcU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-UmuEbUNaPhKbhFaMQ0GUIA-1; Thu,
 11 Jun 2026 00:58:37 -0400
X-MC-Unique: UmuEbUNaPhKbhFaMQ0GUIA-1
X-Mimecast-MFC-AGG-ID: UmuEbUNaPhKbhFaMQ0GUIA_1781153915
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83019180AC4F;
	Thu, 11 Jun 2026 04:58:35 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.44.48.149])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B1D2C19541B0;
	Thu, 11 Jun 2026 04:58:30 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	pabeni@redhat.com,
	Adrian Moreno <amorenoz@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	dev@openvswitch.org (open list:OPENVSWITCH),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v4 2/4] net: openvswitch: add per-flow_table lockdep checks
Date: Thu, 11 Jun 2026 06:58:09 +0200
Message-ID: <20260611045817.1302665-3-amorenoz@redhat.com>
In-Reply-To: <20260611045817.1302665-1-amorenoz@redhat.com>
References: <20260611045817.1302665-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297936-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:aconole@redhat.com,m:pabeni@redhat.com,m:amorenoz@redhat.com,m:echaudro@redhat.com,m:i.maximets@ovn.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:dev@openvswitch.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[amorenoz@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amorenoz@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 000EA66E56E

A future patch will introduce a per-flow_table mutex that will protect
flow operations independently. In preparation for that, this patch
introduces a flow_table lockdep macro, and modifies some function
signatures to allow lockdep assertions to run.

For now, the actual lockdep check logic is a no-op, but adding the
infrastructure helps reduce the size of the upcoming patch.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 net/openvswitch/datapath.c   |  57 +++++++++-------
 net/openvswitch/flow.c       |  13 ++--
 net/openvswitch/flow.h       |   9 ++-
 net/openvswitch/flow_table.c | 127 ++++++++++++++++++++---------------
 net/openvswitch/flow_table.h |  16 +++++
 5 files changed, 137 insertions(+), 85 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index e78c28dd5d9d..72ad3ed12675 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -840,15 +840,16 @@ static size_t ovs_flow_cmd_msg_size(const struct sw_flow_actions *acts,
 		+ nla_total_size_64bit(8); /* OVS_FLOW_ATTR_USED */
 }
 
-/* Called with ovs_mutex or RCU read lock. */
+/* Called with table->lock or RCU read lock. */
 static int ovs_flow_cmd_fill_stats(const struct sw_flow *flow,
+				   const struct flow_table *table,
 				   struct sk_buff *skb)
 {
 	struct ovs_flow_stats stats;
 	__be16 tcp_flags;
 	unsigned long used;
 
-	ovs_flow_stats_get(flow, &stats, &used, &tcp_flags);
+	ovs_flow_stats_get(flow, table, &stats, &used, &tcp_flags);
 
 	if (used &&
 	    nla_put_u64_64bit(skb, OVS_FLOW_ATTR_USED, ovs_flow_used_time(used),
@@ -868,8 +869,9 @@ static int ovs_flow_cmd_fill_stats(const struct sw_flow *flow,
 	return 0;
 }
 
-/* Called with ovs_mutex or RCU read lock. */
+/* Called with RCU read lock or table->lock held. */
 static int ovs_flow_cmd_fill_actions(const struct sw_flow *flow,
+				     const struct flow_table *table,
 				     struct sk_buff *skb, int skb_orig_len)
 {
 	struct nlattr *start;
@@ -889,7 +891,7 @@ static int ovs_flow_cmd_fill_actions(const struct sw_flow *flow,
 	if (start) {
 		const struct sw_flow_actions *sf_acts;
 
-		sf_acts = rcu_dereference_ovsl(flow->sf_acts);
+		sf_acts = rcu_dereference_ovs_tbl(flow->sf_acts, table);
 		err = ovs_nla_put_actions(sf_acts->actions,
 					  sf_acts->actions_len, skb);
 
@@ -908,8 +910,10 @@ static int ovs_flow_cmd_fill_actions(const struct sw_flow *flow,
 	return 0;
 }
 
-/* Called with ovs_mutex or RCU read lock. */
-static int ovs_flow_cmd_fill_info(const struct sw_flow *flow, int dp_ifindex,
+/* Called with table->lock or RCU read lock. */
+static int ovs_flow_cmd_fill_info(const struct sw_flow *flow,
+				  const struct flow_table *table,
+				  int dp_ifindex,
 				  struct sk_buff *skb, u32 portid,
 				  u32 seq, u32 flags, u8 cmd, u32 ufid_flags)
 {
@@ -940,12 +944,12 @@ static int ovs_flow_cmd_fill_info(const struct sw_flow *flow, int dp_ifindex,
 			goto error;
 	}
 
-	err = ovs_flow_cmd_fill_stats(flow, skb);
+	err = ovs_flow_cmd_fill_stats(flow, table, skb);
 	if (err)
 		goto error;
 
 	if (should_fill_actions(ufid_flags)) {
-		err = ovs_flow_cmd_fill_actions(flow, skb, skb_orig_len);
+		err = ovs_flow_cmd_fill_actions(flow, table, skb, skb_orig_len);
 		if (err)
 			goto error;
 	}
@@ -979,8 +983,9 @@ static struct sk_buff *ovs_flow_cmd_alloc_info(const struct sw_flow_actions *act
 	return skb;
 }
 
-/* Called with ovs_mutex. */
+/* Called with table->lock. */
 static struct sk_buff *ovs_flow_cmd_build_info(const struct sw_flow *flow,
+					       const struct flow_table *table,
 					       int dp_ifindex,
 					       struct genl_info *info, u8 cmd,
 					       bool always, u32 ufid_flags)
@@ -988,12 +993,12 @@ static struct sk_buff *ovs_flow_cmd_build_info(const struct sw_flow *flow,
 	struct sk_buff *skb;
 	int retval;
 
-	skb = ovs_flow_cmd_alloc_info(ovsl_dereference(flow->sf_acts),
+	skb = ovs_flow_cmd_alloc_info(ovs_tbl_dereference(flow->sf_acts, table),
 				      &flow->id, info, always, ufid_flags);
 	if (IS_ERR_OR_NULL(skb))
 		return skb;
 
-	retval = ovs_flow_cmd_fill_info(flow, dp_ifindex, skb,
+	retval = ovs_flow_cmd_fill_info(flow, table, dp_ifindex, skb,
 					info->snd_portid, info->snd_seq, 0,
 					cmd, ufid_flags);
 	if (WARN_ON_ONCE(retval < 0)) {
@@ -1104,7 +1109,7 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
 		}
 
 		if (unlikely(reply)) {
-			error = ovs_flow_cmd_fill_info(new_flow,
+			error = ovs_flow_cmd_fill_info(new_flow, table,
 						       ovs_header->dp_ifindex,
 						       reply, info->snd_portid,
 						       info->snd_seq, 0,
@@ -1142,11 +1147,11 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
 			}
 		}
 		/* Update actions. */
-		old_acts = ovsl_dereference(flow->sf_acts);
+		old_acts = ovs_tbl_dereference(flow->sf_acts, table);
 		rcu_assign_pointer(flow->sf_acts, acts);
 
 		if (unlikely(reply)) {
-			error = ovs_flow_cmd_fill_info(flow,
+			error = ovs_flow_cmd_fill_info(flow, table,
 						       ovs_header->dp_ifindex,
 						       reply, info->snd_portid,
 						       info->snd_seq, 0,
@@ -1319,11 +1324,11 @@ static int ovs_flow_cmd_set(struct sk_buff *skb, struct genl_info *info)
 
 	/* Update actions, if present. */
 	if (likely(acts)) {
-		old_acts = ovsl_dereference(flow->sf_acts);
+		old_acts = ovs_tbl_dereference(flow->sf_acts, table);
 		rcu_assign_pointer(flow->sf_acts, acts);
 
 		if (unlikely(reply)) {
-			error = ovs_flow_cmd_fill_info(flow,
+			error = ovs_flow_cmd_fill_info(flow, table,
 						       ovs_header->dp_ifindex,
 						       reply, info->snd_portid,
 						       info->snd_seq, 0,
@@ -1333,7 +1338,8 @@ static int ovs_flow_cmd_set(struct sk_buff *skb, struct genl_info *info)
 		}
 	} else {
 		/* Could not alloc without acts before locking. */
-		reply = ovs_flow_cmd_build_info(flow, ovs_header->dp_ifindex,
+		reply = ovs_flow_cmd_build_info(flow, table,
+						ovs_header->dp_ifindex,
 						info, OVS_FLOW_CMD_SET, false,
 						ufid_flags);
 
@@ -1345,7 +1351,7 @@ static int ovs_flow_cmd_set(struct sk_buff *skb, struct genl_info *info)
 
 	/* Clear stats. */
 	if (a[OVS_FLOW_ATTR_CLEAR])
-		ovs_flow_stats_clear(flow);
+		ovs_flow_stats_clear(flow, table);
 	ovs_unlock();
 
 	if (reply)
@@ -1415,8 +1421,9 @@ static int ovs_flow_cmd_get(struct sk_buff *skb, struct genl_info *info)
 		goto unlock;
 	}
 
-	reply = ovs_flow_cmd_build_info(flow, ovs_header->dp_ifindex, info,
-					OVS_FLOW_CMD_GET, true, ufid_flags);
+	reply = ovs_flow_cmd_build_info(flow, table, ovs_header->dp_ifindex,
+					info, OVS_FLOW_CMD_GET, true,
+					ufid_flags);
 	if (IS_ERR(reply)) {
 		err = PTR_ERR(reply);
 		goto unlock;
@@ -1489,7 +1496,8 @@ static int ovs_flow_cmd_del(struct sk_buff *skb, struct genl_info *info)
 	if (likely(reply)) {
 		if (!IS_ERR(reply)) {
 			rcu_read_lock();	/*To keep RCU checker happy. */
-			err = ovs_flow_cmd_fill_info(flow, ovs_header->dp_ifindex,
+			err = ovs_flow_cmd_fill_info(flow, table,
+						     ovs_header->dp_ifindex,
 						     reply, info->snd_portid,
 						     info->snd_seq, 0,
 						     OVS_FLOW_CMD_DEL,
@@ -1554,8 +1562,8 @@ static int ovs_flow_cmd_dump(struct sk_buff *skb, struct netlink_callback *cb)
 		if (!flow)
 			break;
 
-		if (ovs_flow_cmd_fill_info(flow, ovs_header->dp_ifindex, skb,
-					   NETLINK_CB(cb->skb).portid,
+		if (ovs_flow_cmd_fill_info(flow, table, ovs_header->dp_ifindex,
+					   skb, NETLINK_CB(cb->skb).portid,
 					   cb->nlh->nlmsg_seq, NLM_F_MULTI,
 					   OVS_FLOW_CMD_GET, ufid_flags) < 0)
 			break;
@@ -1972,7 +1980,8 @@ static int ovs_dp_cmd_new(struct sk_buff *skb, struct genl_info *info)
 /* Called with ovs_mutex. */
 static void __dp_destroy(struct datapath *dp)
 {
-	struct flow_table *table = ovsl_dereference(dp->table);
+	struct flow_table *table = rcu_dereference_protected(dp->table,
+					lockdep_ovsl_is_held());
 	int i;
 
 	if (dp->user_features & OVS_DP_F_TC_RECIRC_SHARING)
diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
index 66366982f604..0a748cf20f53 100644
--- a/net/openvswitch/flow.c
+++ b/net/openvswitch/flow.c
@@ -124,8 +124,9 @@ void ovs_flow_stats_update(struct sw_flow *flow, __be16 tcp_flags,
 	spin_unlock(&stats->lock);
 }
 
-/* Must be called with rcu_read_lock or ovs_mutex. */
+/* Must be called with rcu_read_lock or table->lock held. */
 void ovs_flow_stats_get(const struct sw_flow *flow,
+			const struct flow_table *table,
 			struct ovs_flow_stats *ovs_stats,
 			unsigned long *used, __be16 *tcp_flags)
 {
@@ -136,7 +137,8 @@ void ovs_flow_stats_get(const struct sw_flow *flow,
 	memset(ovs_stats, 0, sizeof(*ovs_stats));
 
 	for_each_cpu(cpu, flow->cpu_used_mask) {
-		struct sw_flow_stats *stats = rcu_dereference_ovsl(flow->stats[cpu]);
+		struct sw_flow_stats *stats =
+			rcu_dereference_ovs_tbl(flow->stats[cpu], table);
 
 		if (stats) {
 			/* Local CPU may write on non-local stats, so we must
@@ -153,13 +155,14 @@ void ovs_flow_stats_get(const struct sw_flow *flow,
 	}
 }
 
-/* Called with ovs_mutex. */
-void ovs_flow_stats_clear(struct sw_flow *flow)
+/* Called with table->lock held. */
+void ovs_flow_stats_clear(struct sw_flow *flow, struct flow_table *table)
 {
 	unsigned int cpu;
 
 	for_each_cpu(cpu, flow->cpu_used_mask) {
-		struct sw_flow_stats *stats = ovsl_dereference(flow->stats[cpu]);
+		struct sw_flow_stats *stats =
+			ovs_tbl_dereference(flow->stats[cpu], table);
 
 		if (stats) {
 			spin_lock_bh(&stats->lock);
diff --git a/net/openvswitch/flow.h b/net/openvswitch/flow.h
index b5711aff6e76..e05ed6796e4e 100644
--- a/net/openvswitch/flow.h
+++ b/net/openvswitch/flow.h
@@ -23,6 +23,7 @@
 #include <net/dst_metadata.h>
 #include <net/nsh.h>
 
+struct flow_table;
 struct sk_buff;
 
 enum sw_flow_mac_proto {
@@ -280,9 +281,11 @@ static inline bool ovs_identifier_is_key(const struct sw_flow_id *sfid)
 
 void ovs_flow_stats_update(struct sw_flow *, __be16 tcp_flags,
 			   const struct sk_buff *);
-void ovs_flow_stats_get(const struct sw_flow *, struct ovs_flow_stats *,
-			unsigned long *used, __be16 *tcp_flags);
-void ovs_flow_stats_clear(struct sw_flow *);
+void ovs_flow_stats_get(const struct sw_flow *flow,
+			const struct flow_table *table,
+			struct ovs_flow_stats *stats, unsigned long *used,
+			__be16 *tcp_flags);
+void ovs_flow_stats_clear(struct sw_flow *flow, struct flow_table *table);
 u64 ovs_flow_used_time(unsigned long flow_jiffies);
 
 int ovs_flow_key_update(struct sk_buff *skb, struct sw_flow_key *key);
diff --git a/net/openvswitch/flow_table.c b/net/openvswitch/flow_table.c
index 3b7518e3394d..2ae168f31f50 100644
--- a/net/openvswitch/flow_table.c
+++ b/net/openvswitch/flow_table.c
@@ -249,12 +249,12 @@ static int tbl_mask_array_realloc(struct flow_table *tbl, int size)
 	if (!new)
 		return -ENOMEM;
 
-	old = ovsl_dereference(tbl->mask_array);
+	old = ovs_tbl_dereference(tbl->mask_array, tbl);
 	if (old) {
 		int i;
 
 		for (i = 0; i < old->max; i++) {
-			if (ovsl_dereference(old->masks[i]))
+			if (ovs_tbl_dereference(old->masks[i], tbl))
 				new->masks[new->count++] = old->masks[i];
 		}
 		call_rcu(&old->rcu, mask_array_rcu_cb);
@@ -268,7 +268,7 @@ static int tbl_mask_array_realloc(struct flow_table *tbl, int size)
 static int tbl_mask_array_add_mask(struct flow_table *tbl,
 				   struct sw_flow_mask *new)
 {
-	struct mask_array *ma = ovsl_dereference(tbl->mask_array);
+	struct mask_array *ma = ovs_tbl_dereference(tbl->mask_array, tbl);
 	int err, ma_count = READ_ONCE(ma->count);
 
 	if (ma_count >= ma->max) {
@@ -277,7 +277,7 @@ static int tbl_mask_array_add_mask(struct flow_table *tbl,
 		if (err)
 			return err;
 
-		ma = ovsl_dereference(tbl->mask_array);
+		ma = ovs_tbl_dereference(tbl->mask_array, tbl);
 	} else {
 		/* On every add or delete we need to reset the counters so
 		 * every new mask gets a fair chance of being prioritized.
@@ -285,7 +285,7 @@ static int tbl_mask_array_add_mask(struct flow_table *tbl,
 		tbl_mask_array_reset_counters(ma);
 	}
 
-	BUG_ON(ovsl_dereference(ma->masks[ma_count]));
+	WARN_ON_ONCE(ovs_tbl_dereference(ma->masks[ma_count], tbl));
 
 	rcu_assign_pointer(ma->masks[ma_count], new);
 	WRITE_ONCE(ma->count, ma_count + 1);
@@ -296,12 +296,12 @@ static int tbl_mask_array_add_mask(struct flow_table *tbl,
 static void tbl_mask_array_del_mask(struct flow_table *tbl,
 				    struct sw_flow_mask *mask)
 {
-	struct mask_array *ma = ovsl_dereference(tbl->mask_array);
+	struct mask_array *ma = ovs_tbl_dereference(tbl->mask_array, tbl);
 	int i, ma_count = READ_ONCE(ma->count);
 
 	/* Remove the deleted mask pointers from the array */
 	for (i = 0; i < ma_count; i++) {
-		if (mask == ovsl_dereference(ma->masks[i]))
+		if (mask == ovs_tbl_dereference(ma->masks[i], tbl))
 			goto found;
 	}
 
@@ -329,10 +329,10 @@ static void tbl_mask_array_del_mask(struct flow_table *tbl,
 static void flow_mask_remove(struct flow_table *tbl, struct sw_flow_mask *mask)
 {
 	if (mask) {
-		/* ovs-lock is required to protect mask-refcount and
+		/* table lock is required to protect mask-refcount and
 		 * mask list.
 		 */
-		ASSERT_OVSL();
+		ASSERT_OVS_TBL(tbl);
 		BUG_ON(!mask->ref_count);
 		mask->ref_count--;
 
@@ -386,7 +386,8 @@ static struct mask_cache *tbl_mask_cache_alloc(u32 size)
 }
 int ovs_flow_tbl_masks_cache_resize(struct flow_table *table, u32 size)
 {
-	struct mask_cache *mc = rcu_dereference_ovsl(table->mask_cache);
+	struct mask_cache *mc = rcu_dereference_ovs_tbl(table->mask_cache,
+							table);
 	struct mask_cache *new;
 
 	if (size == mc->cache_size)
@@ -578,7 +579,8 @@ static void ufid_table_instance_insert(struct table_instance *ti,
 	hlist_add_head_rcu(&flow->ufid_table.node[ti->node_ver], head);
 }
 
-static void flow_table_copy_flows(struct table_instance *old,
+static void flow_table_copy_flows(struct flow_table *table,
+				  struct table_instance *old,
 				  struct table_instance *new, bool ufid)
 {
 	int old_ver;
@@ -595,17 +597,18 @@ static void flow_table_copy_flows(struct table_instance *old,
 		if (ufid)
 			hlist_for_each_entry_rcu(flow, head,
 						 ufid_table.node[old_ver],
-						 lockdep_ovsl_is_held())
+						 lockdep_ovs_tbl_is_held(table))
 				ufid_table_instance_insert(new, flow);
 		else
 			hlist_for_each_entry_rcu(flow, head,
 						 flow_table.node[old_ver],
-						 lockdep_ovsl_is_held())
+						 lockdep_ovs_tbl_is_held(table))
 				table_instance_insert(new, flow);
 	}
 }
 
-static struct table_instance *table_instance_rehash(struct table_instance *ti,
+static struct table_instance *table_instance_rehash(struct flow_table *table,
+						    struct table_instance *ti,
 						    int n_buckets, bool ufid)
 {
 	struct table_instance *new_ti;
@@ -614,16 +617,19 @@ static struct table_instance *table_instance_rehash(struct table_instance *ti,
 	if (!new_ti)
 		return NULL;
 
-	flow_table_copy_flows(ti, new_ti, ufid);
+	flow_table_copy_flows(table, ti, new_ti, ufid);
 
 	return new_ti;
 }
 
+/* Must be called with flow_table->lock held. */
 int ovs_flow_tbl_flush(struct flow_table *flow_table)
 {
 	struct table_instance *old_ti, *new_ti;
 	struct table_instance *old_ufid_ti, *new_ufid_ti;
 
+	ASSERT_OVS_TBL(flow_table);
+
 	new_ti = table_instance_alloc(TBL_MIN_BUCKETS);
 	if (!new_ti)
 		return -ENOMEM;
@@ -631,8 +637,8 @@ int ovs_flow_tbl_flush(struct flow_table *flow_table)
 	if (!new_ufid_ti)
 		goto err_free_ti;
 
-	old_ti = ovsl_dereference(flow_table->ti);
-	old_ufid_ti = ovsl_dereference(flow_table->ufid_ti);
+	old_ti = ovs_tbl_dereference(flow_table->ti, flow_table);
+	old_ufid_ti = ovs_tbl_dereference(flow_table->ufid_ti, flow_table);
 
 	rcu_assign_pointer(flow_table->ti, new_ti);
 	rcu_assign_pointer(flow_table->ufid_ti, new_ufid_ti);
@@ -700,7 +706,8 @@ static bool ovs_flow_cmp_unmasked_key(const struct sw_flow *flow,
 	return cmp_key(flow->id.unmasked_key, key, key_start, key_end);
 }
 
-static struct sw_flow *masked_flow_lookup(struct table_instance *ti,
+static struct sw_flow *masked_flow_lookup(struct flow_table *tbl,
+					  struct table_instance *ti,
 					  const struct sw_flow_key *unmasked,
 					  const struct sw_flow_mask *mask,
 					  u32 *n_mask_hit)
@@ -716,7 +723,7 @@ static struct sw_flow *masked_flow_lookup(struct table_instance *ti,
 	(*n_mask_hit)++;
 
 	hlist_for_each_entry_rcu(flow, head, flow_table.node[ti->node_ver],
-				 lockdep_ovsl_is_held()) {
+				 lockdep_ovs_tbl_is_held(tbl)) {
 		if (flow->mask == mask && flow->flow_table.hash == hash &&
 		    flow_cmp_masked_key(flow, &masked_key, &mask->range))
 			return flow;
@@ -743,9 +750,9 @@ static struct sw_flow *flow_lookup(struct flow_table *tbl,
 	int i;
 
 	if (likely(*index < ma->max)) {
-		mask = rcu_dereference_ovsl(ma->masks[*index]);
+		mask = rcu_dereference_ovs_tbl(ma->masks[*index], tbl);
 		if (mask) {
-			flow = masked_flow_lookup(ti, key, mask, n_mask_hit);
+			flow = masked_flow_lookup(tbl, ti, key, mask, n_mask_hit);
 			if (flow) {
 				u64_stats_update_begin(&stats->syncp);
 				stats->usage_cntrs[*index]++;
@@ -761,11 +768,11 @@ static struct sw_flow *flow_lookup(struct flow_table *tbl,
 		if (i == *index)
 			continue;
 
-		mask = rcu_dereference_ovsl(ma->masks[i]);
+		mask = rcu_dereference_ovs_tbl(ma->masks[i], tbl);
 		if (unlikely(!mask))
 			break;
 
-		flow = masked_flow_lookup(ti, key, mask, n_mask_hit);
+		flow = masked_flow_lookup(tbl, ti, key, mask, n_mask_hit);
 		if (flow) { /* Found */
 			*index = i;
 			u64_stats_update_begin(&stats->syncp);
@@ -852,8 +859,8 @@ struct sw_flow *ovs_flow_tbl_lookup_stats(struct flow_table *tbl,
 struct sw_flow *ovs_flow_tbl_lookup(struct flow_table *tbl,
 				    const struct sw_flow_key *key)
 {
-	struct table_instance *ti = rcu_dereference_ovsl(tbl->ti);
-	struct mask_array *ma = rcu_dereference_ovsl(tbl->mask_array);
+	struct table_instance *ti = rcu_dereference_ovs_tbl(tbl->ti, tbl);
+	struct mask_array *ma = rcu_dereference_ovs_tbl(tbl->mask_array, tbl);
 	u32 __always_unused n_mask_hit;
 	u32 __always_unused n_cache_hit;
 	struct sw_flow *flow;
@@ -872,21 +879,22 @@ struct sw_flow *ovs_flow_tbl_lookup(struct flow_table *tbl,
 struct sw_flow *ovs_flow_tbl_lookup_exact(struct flow_table *tbl,
 					  const struct sw_flow_match *match)
 {
-	struct mask_array *ma = ovsl_dereference(tbl->mask_array);
+	struct mask_array *ma = ovs_tbl_dereference(tbl->mask_array, tbl);
 	int i;
 
-	/* Always called under ovs-mutex. */
+	/* Always called under tbl->lock. */
 	for (i = 0; i < ma->max; i++) {
-		struct table_instance *ti = rcu_dereference_ovsl(tbl->ti);
+		struct table_instance *ti =
+				rcu_dereference_ovs_tbl(tbl->ti, tbl);
 		u32 __always_unused n_mask_hit;
 		struct sw_flow_mask *mask;
 		struct sw_flow *flow;
 
-		mask = ovsl_dereference(ma->masks[i]);
+		mask = ovs_tbl_dereference(ma->masks[i], tbl);
 		if (!mask)
 			continue;
 
-		flow = masked_flow_lookup(ti, match->key, mask, &n_mask_hit);
+		flow = masked_flow_lookup(tbl, ti, match->key, mask, &n_mask_hit);
 		if (flow && ovs_identifier_is_key(&flow->id) &&
 		    ovs_flow_cmp_unmasked_key(flow, match)) {
 			return flow;
@@ -922,7 +930,7 @@ bool ovs_flow_cmp(const struct sw_flow *flow,
 struct sw_flow *ovs_flow_tbl_lookup_ufid(struct flow_table *tbl,
 					 const struct sw_flow_id *ufid)
 {
-	struct table_instance *ti = rcu_dereference_ovsl(tbl->ufid_ti);
+	struct table_instance *ti = rcu_dereference_ovs_tbl(tbl->ufid_ti, tbl);
 	struct sw_flow *flow;
 	struct hlist_head *head;
 	u32 hash;
@@ -930,7 +938,7 @@ struct sw_flow *ovs_flow_tbl_lookup_ufid(struct flow_table *tbl,
 	hash = ufid_hash(ufid);
 	head = find_bucket(ti, hash);
 	hlist_for_each_entry_rcu(flow, head, ufid_table.node[ti->node_ver],
-				 lockdep_ovsl_is_held()) {
+				 lockdep_ovs_tbl_is_held(tbl)) {
 		if (flow->ufid_table.hash == hash &&
 		    ovs_flow_cmp_ufid(flow, ufid))
 			return flow;
@@ -940,28 +948,33 @@ struct sw_flow *ovs_flow_tbl_lookup_ufid(struct flow_table *tbl,
 
 int ovs_flow_tbl_num_masks(const struct flow_table *table)
 {
-	struct mask_array *ma = rcu_dereference_ovsl(table->mask_array);
+	struct mask_array *ma = rcu_dereference_ovs_tbl(table->mask_array,
+							table);
 	return READ_ONCE(ma->count);
 }
 
 u32 ovs_flow_tbl_masks_cache_size(const struct flow_table *table)
 {
-	struct mask_cache *mc = rcu_dereference_ovsl(table->mask_cache);
+	struct mask_cache *mc = rcu_dereference_ovs_tbl(table->mask_cache,
+							table);
 
 	return READ_ONCE(mc->cache_size);
 }
 
-static struct table_instance *table_instance_expand(struct table_instance *ti,
+static struct table_instance *table_instance_expand(struct flow_table *table,
+						    struct table_instance *ti,
 						    bool ufid)
 {
-	return table_instance_rehash(ti, ti->n_buckets * 2, ufid);
+	return table_instance_rehash(table, ti, ti->n_buckets * 2, ufid);
 }
 
-/* Must be called with OVS mutex held. */
+/* Must be called with table mutex held. */
 void ovs_flow_tbl_remove(struct flow_table *table, struct sw_flow *flow)
 {
-	struct table_instance *ti = ovsl_dereference(table->ti);
-	struct table_instance *ufid_ti = ovsl_dereference(table->ufid_ti);
+	struct table_instance *ti = ovs_tbl_dereference(table->ti,
+							table);
+	struct table_instance *ufid_ti = ovs_tbl_dereference(table->ufid_ti,
+							     table);
 
 	BUG_ON(table->count == 0);
 	table_instance_flow_free(table, ti, ufid_ti, flow);
@@ -995,10 +1008,10 @@ static struct sw_flow_mask *flow_mask_find(const struct flow_table *tbl,
 	struct mask_array *ma;
 	int i;
 
-	ma = ovsl_dereference(tbl->mask_array);
+	ma = ovs_tbl_dereference(tbl->mask_array, tbl);
 	for (i = 0; i < ma->max; i++) {
 		struct sw_flow_mask *t;
-		t = ovsl_dereference(ma->masks[i]);
+		t = ovs_tbl_dereference(ma->masks[i], tbl);
 
 		if (t && mask_equal(mask, t))
 			return t;
@@ -1036,22 +1049,25 @@ static int flow_mask_insert(struct flow_table *tbl, struct sw_flow *flow,
 	return 0;
 }
 
-/* Must be called with OVS mutex held. */
+/* Must be called with table mutex held. */
 static void flow_key_insert(struct flow_table *table, struct sw_flow *flow)
 {
 	struct table_instance *new_ti = NULL;
 	struct table_instance *ti;
 
+	ASSERT_OVS_TBL(table);
+
 	flow->flow_table.hash = flow_hash(&flow->key, &flow->mask->range);
-	ti = ovsl_dereference(table->ti);
+	ti = ovs_tbl_dereference(table->ti, table);
 	table_instance_insert(ti, flow);
 	table->count++;
 
 	/* Expand table, if necessary, to make room. */
 	if (table->count > ti->n_buckets)
-		new_ti = table_instance_expand(ti, false);
+		new_ti = table_instance_expand(table, ti, false);
 	else if (time_after(jiffies, table->last_rehash + REHASH_INTERVAL))
-		new_ti = table_instance_rehash(ti, ti->n_buckets, false);
+		new_ti = table_instance_rehash(table, ti, ti->n_buckets,
+					       false);
 
 	if (new_ti) {
 		rcu_assign_pointer(table->ti, new_ti);
@@ -1060,13 +1076,15 @@ static void flow_key_insert(struct flow_table *table, struct sw_flow *flow)
 	}
 }
 
-/* Must be called with OVS mutex held. */
+/* Must be called with table mutex held. */
 static void flow_ufid_insert(struct flow_table *table, struct sw_flow *flow)
 {
 	struct table_instance *ti;
 
+	ASSERT_OVS_TBL(table);
+
 	flow->ufid_table.hash = ufid_hash(&flow->id);
-	ti = ovsl_dereference(table->ufid_ti);
+	ti = ovs_tbl_dereference(table->ufid_ti, table);
 	ufid_table_instance_insert(ti, flow);
 	table->ufid_count++;
 
@@ -1074,7 +1092,7 @@ static void flow_ufid_insert(struct flow_table *table, struct sw_flow *flow)
 	if (table->ufid_count > ti->n_buckets) {
 		struct table_instance *new_ti;
 
-		new_ti = table_instance_expand(ti, true);
+		new_ti = table_instance_expand(table, ti, true);
 		if (new_ti) {
 			rcu_assign_pointer(table->ufid_ti, new_ti);
 			call_rcu(&ti->rcu, flow_tbl_destroy_rcu_cb);
@@ -1082,12 +1100,14 @@ static void flow_ufid_insert(struct flow_table *table, struct sw_flow *flow)
 	}
 }
 
-/* Must be called with OVS mutex held. */
+/* Must be called with table mutex held. */
 int ovs_flow_tbl_insert(struct flow_table *table, struct sw_flow *flow,
 			const struct sw_flow_mask *mask)
 {
 	int err;
 
+	ASSERT_OVS_TBL(table);
+
 	err = flow_mask_insert(table, flow, mask);
 	if (err)
 		return err;
@@ -1106,10 +1126,11 @@ static int compare_mask_and_count(const void *a, const void *b)
 	return (s64)mc_b->counter - (s64)mc_a->counter;
 }
 
-/* Must be called with OVS mutex held. */
+/* Must be called with table->lock held. */
 void ovs_flow_masks_rebalance(struct flow_table *table)
 {
-	struct mask_array *ma = rcu_dereference_ovsl(table->mask_array);
+	struct mask_array *ma = rcu_dereference_ovs_tbl(table->mask_array,
+							table);
 	struct mask_count *masks_and_count;
 	struct mask_array *new;
 	int masks_entries = 0;
@@ -1124,7 +1145,7 @@ void ovs_flow_masks_rebalance(struct flow_table *table)
 		struct sw_flow_mask *mask;
 		int cpu;
 
-		mask = rcu_dereference_ovsl(ma->masks[i]);
+		mask = rcu_dereference_ovs_tbl(ma->masks[i], table);
 		if (unlikely(!mask))
 			break;
 
@@ -1178,7 +1199,7 @@ void ovs_flow_masks_rebalance(struct flow_table *table)
 	for (i = 0; i < masks_entries; i++) {
 		int index = masks_and_count[i].index;
 
-		if (ovsl_dereference(ma->masks[index]))
+		if (ovs_tbl_dereference(ma->masks[index], table))
 			new->masks[new->count++] = ma->masks[index];
 	}
 
diff --git a/net/openvswitch/flow_table.h b/net/openvswitch/flow_table.h
index 6211bcc72655..3e5e9845c28a 100644
--- a/net/openvswitch/flow_table.h
+++ b/net/openvswitch/flow_table.h
@@ -72,6 +72,22 @@ struct flow_table {
 
 extern struct kmem_cache *flow_stats_cache;
 
+static inline int lockdep_ovs_tbl_is_held(const struct flow_table *table
+					  __always_unused)
+{
+	return 1;
+}
+
+#define ASSERT_OVS_TBL(tbl)   WARN_ON(!lockdep_ovs_tbl_is_held(tbl))
+
+/* Lock-protected update-allowed dereferences.*/
+#define ovs_tbl_dereference(p, tbl)	\
+	rcu_dereference_protected(p, lockdep_ovs_tbl_is_held(tbl))
+
+/* Read dereferences can be protected by either RCU, table lock. */
+#define rcu_dereference_ovs_tbl(p, tbl) \
+	rcu_dereference_check(p, lockdep_ovs_tbl_is_held(tbl))
+
 int ovs_flow_init(void);
 void ovs_flow_exit(void);
 
-- 
2.54.0


