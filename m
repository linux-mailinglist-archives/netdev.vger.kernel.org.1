Return-Path: <netdev+bounces-284270-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEqBMjuu+Wky+wIAu9opvQ
	(envelope-from <netdev+bounces-284270-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:45:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E99A4C8CFD
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 10:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C9773003631
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 08:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F0E30F545;
	Tue,  5 May 2026 08:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUl0WDMC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F5F3128B2
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777970611; cv=none; b=uMvQgzq+E2OarK7v7KvIjX1GCdrdODJLkwQeTZL624oT3eVrxlx52YyTSijF2cuOOhcRHKnARnDv1vU8aC8s4I5M71rwJa8+RvU2NhDeAK4svutyQ+zST9rSjOy/vuOz/CBHCbU4N/4TWXGq9lWrAlwT2AmqdaypQF08jDBqwRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777970611; c=relaxed/simple;
	bh=XHwId4epTsLSBU/AWiN4VyVmhgobprhIz9XXIr/Jak0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovJUkAx/hTM84T3eMn6A7T8ikVuzW1QkMQer/pq0CwDODy4UlG0w7e8Hnndnb1ZwKurBy6HATeU8tON7Jpm/bn4195fXw6DzaslscMudgsRGyYxJFJp2gTGOgt5OkK6BIhySJnYikDYjCadjMq2oYVbWQ4NvrZTLad/J0vOyt9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GUl0WDMC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777970607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C1Ux/ZdWHJcZKrxjhS8nRyzEyKLXdLtIejIfSYpTc90=;
	b=GUl0WDMCOspaxSfXu3+ho4WhVoLvCZ0B0P2bCKjujYHmEDhE/Jl3oclZ6p0YAfWh3Fit2+
	qGLa7R3zFN8P47bbPYPDO6ATDV9lHE7maRZiOa6vUj0d+Fh7KEU5YqpxBp3Aaq1JiEWuzf
	qrzmiQ7fALD9iOh36SdNZLDkREfDPgQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-wt5Xh3uAMsmZWAOuwxoawA-1; Tue,
 05 May 2026 04:43:23 -0400
X-MC-Unique: wt5Xh3uAMsmZWAOuwxoawA-1
X-Mimecast-MFC-AGG-ID: wt5Xh3uAMsmZWAOuwxoawA_1777970600
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 42A8019560BA;
	Tue,  5 May 2026 08:43:20 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.44.50.111])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 525FE19560A6;
	Tue,  5 May 2026 08:43:14 +0000 (UTC)
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
Subject: [PATCH net-next v3 2/2] net: openvswitch: decouple flow_table from ovs_mutex
Date: Tue,  5 May 2026 10:42:47 +0200
Message-ID: <20260505084253.998548-3-amorenoz@redhat.com>
In-Reply-To: <20260505084253.998548-1-amorenoz@redhat.com>
References: <20260505084253.998548-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: 0E99A4C8CFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284270-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amorenoz@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

In order to protect flow operations from RTNL contention, this patch
decouples flow_table modifications from ovs_mutex by means of the
following:

1 - Create a new mutex inside the flow_table that protects it from
concurrent modifications.
Putting the mutex inside flow_table makes it easier to consume for
functions inside flow_table.c that do not currently take pointers to the
datapath.
Some function signatures need to be changed to accept flow_table so that
lockdep checks can be performed.

2 - Create a reference count to temporarily extend rcu protection from
the datapath to the flow_table.
One reference is held by the datapath, the other is temporarily
increased during flow modifications.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 net/openvswitch/datapath.c   | 230 ++++++++++++++++++++++-------------
 net/openvswitch/flow.c       |  13 +-
 net/openvswitch/flow.h       |   9 +-
 net/openvswitch/flow_table.c | 173 ++++++++++++++++----------
 net/openvswitch/flow_table.h |  53 +++++++-
 5 files changed, 318 insertions(+), 160 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index e78c28dd5d9d..92989d4caa09 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -88,13 +88,17 @@ static void ovs_notify(struct genl_family *family,
  * DOC: Locking:
  *
  * All writes e.g. Writes to device state (add/remove datapath, port, set
- * operations on vports, etc.), Writes to other state (flow table
- * modifications, set miscellaneous datapath parameters, etc.) are protected
- * by ovs_lock.
+ * operations on vports, etc.) and writes to other datapath parameters
+ * are protected by ovs_lock.
+ *
+ * Writes to the flow table are NOT protected by ovs_lock. Instead, a per-table
+ * mutex and reference count are used (see comment above "struct flow_table"
+ * definition). On some few occasions, the per-flow table mutex is nested
+ * inside ovs_mutex.
  *
  * Reads are protected by RCU.
  *
- * There are a few special cases (mostly stats) that have their own
+ * There are a few other special cases (mostly stats) that have their own
  * synchronization but they nest under all of above and don't interact with
  * each other.
  *
@@ -759,16 +763,19 @@ static struct genl_family dp_packet_genl_family __ro_after_init = {
 static void get_dp_stats(const struct datapath *dp, struct ovs_dp_stats *stats,
 			 struct ovs_dp_megaflow_stats *mega_stats)
 {
-	struct flow_table *table = ovsl_dereference(dp->table);
+	struct flow_table *table;
 	int i;
 
 	memset(mega_stats, 0, sizeof(*mega_stats));
 	memset(stats, 0, sizeof(*stats));
 
+	rcu_read_lock();
+	table = rcu_dereference(dp->table);
 	if (table) {
 		stats->n_flows = ovs_flow_tbl_count(table);
 		mega_stats->n_masks = ovs_flow_tbl_num_masks(table);
 	}
+	rcu_read_unlock();
 
 	stats->n_hit = stats->n_missed = stats->n_lost = 0;
 
@@ -840,15 +847,16 @@ static size_t ovs_flow_cmd_msg_size(const struct sw_flow_actions *acts,
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
@@ -868,8 +876,9 @@ static int ovs_flow_cmd_fill_stats(const struct sw_flow *flow,
 	return 0;
 }
 
-/* Called with ovs_mutex or RCU read lock. */
+/* Called with RCU read lock or table->lock held. */
 static int ovs_flow_cmd_fill_actions(const struct sw_flow *flow,
+				     const struct flow_table *table,
 				     struct sk_buff *skb, int skb_orig_len)
 {
 	struct nlattr *start;
@@ -889,7 +898,7 @@ static int ovs_flow_cmd_fill_actions(const struct sw_flow *flow,
 	if (start) {
 		const struct sw_flow_actions *sf_acts;
 
-		sf_acts = rcu_dereference_ovsl(flow->sf_acts);
+		sf_acts = rcu_dereference_ovs_tbl(flow->sf_acts, table);
 		err = ovs_nla_put_actions(sf_acts->actions,
 					  sf_acts->actions_len, skb);
 
@@ -908,8 +917,10 @@ static int ovs_flow_cmd_fill_actions(const struct sw_flow *flow,
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
@@ -940,12 +951,12 @@ static int ovs_flow_cmd_fill_info(const struct sw_flow *flow, int dp_ifindex,
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
@@ -979,8 +990,9 @@ static struct sk_buff *ovs_flow_cmd_alloc_info(const struct sw_flow_actions *act
 	return skb;
 }
 
-/* Called with ovs_mutex. */
+/* Called with table->lock. */
 static struct sk_buff *ovs_flow_cmd_build_info(const struct sw_flow *flow,
+					       const struct flow_table *table,
 					       int dp_ifindex,
 					       struct genl_info *info, u8 cmd,
 					       bool always, u32 ufid_flags)
@@ -988,12 +1000,12 @@ static struct sk_buff *ovs_flow_cmd_build_info(const struct sw_flow *flow,
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
@@ -1076,17 +1088,25 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
 		goto err_kfree_acts;
 	}
 
-	ovs_lock();
+	rcu_read_lock();
 	dp = get_dp(net, ovs_header->dp_ifindex);
 	if (unlikely(!dp)) {
 		error = -ENODEV;
-		goto err_unlock_ovs;
+		rcu_read_unlock();
+		goto err_kfree_reply;
 	}
-	table = ovsl_dereference(dp->table);
-	if (!table) {
+	table = rcu_dereference(dp->table);
+	if (!table || !ovs_flow_tbl_get(table)) {
 		error = -ENODEV;
-		goto err_unlock_ovs;
+		rcu_read_unlock();
+		goto err_kfree_reply;
 	}
+	rcu_read_unlock();
+
+	/* It is safe to dereference "table" after leaving rcu read-protected
+	 * region because it's pinned by refcount.
+	 */
+	mutex_lock(&table->lock);
 
 	/* Check if this is a duplicate flow */
 	if (ovs_identifier_is_ufid(&new_flow->id))
@@ -1100,11 +1120,11 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
 		error = ovs_flow_tbl_insert(table, new_flow, &mask);
 		if (unlikely(error)) {
 			acts = NULL;
-			goto err_unlock_ovs;
+			goto err_unlock_tbl;
 		}
 
 		if (unlikely(reply)) {
-			error = ovs_flow_cmd_fill_info(new_flow,
+			error = ovs_flow_cmd_fill_info(new_flow, table,
 						       ovs_header->dp_ifindex,
 						       reply, info->snd_portid,
 						       info->snd_seq, 0,
@@ -1112,7 +1132,8 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
 						       ufid_flags);
 			BUG_ON(error < 0);
 		}
-		ovs_unlock();
+		mutex_unlock(&table->lock);
+		ovs_flow_tbl_put(table);
 	} else {
 		struct sw_flow_actions *old_acts;
 
@@ -1125,7 +1146,7 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
 		if (unlikely(info->nlhdr->nlmsg_flags & (NLM_F_CREATE
 							 | NLM_F_EXCL))) {
 			error = -EEXIST;
-			goto err_unlock_ovs;
+			goto err_unlock_tbl;
 		}
 		/* The flow identifier has to be the same for flow updates.
 		 * Look for any overlapping flow.
@@ -1138,15 +1159,15 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
 				flow = NULL;
 			if (!flow) {
 				error = -ENOENT;
-				goto err_unlock_ovs;
+				goto err_unlock_tbl;
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
@@ -1154,7 +1175,8 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
 						       ufid_flags);
 			BUG_ON(error < 0);
 		}
-		ovs_unlock();
+		mutex_unlock(&table->lock);
+		ovs_flow_tbl_put(table);
 
 		ovs_nla_free_flow_actions_rcu(old_acts);
 		ovs_flow_free(new_flow, false);
@@ -1166,8 +1188,10 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
 	kfree(key);
 	return 0;
 
-err_unlock_ovs:
-	ovs_unlock();
+err_unlock_tbl:
+	mutex_unlock(&table->lock);
+	ovs_flow_tbl_put(table);
+err_kfree_reply:
 	kfree_skb(reply);
 err_kfree_acts:
 	ovs_nla_free_flow_actions(acts);
@@ -1296,17 +1320,26 @@ static int ovs_flow_cmd_set(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
-	ovs_lock();
+	rcu_read_lock();
 	dp = get_dp(net, ovs_header->dp_ifindex);
 	if (unlikely(!dp)) {
 		error = -ENODEV;
-		goto err_unlock_ovs;
+		rcu_read_unlock();
+		goto err_free_reply;
 	}
-	table = ovsl_dereference(dp->table);
-	if (!table) {
+	table = rcu_dereference(dp->table);
+	if (!table || !ovs_flow_tbl_get(table)) {
+		rcu_read_unlock();
 		error = -ENODEV;
-		goto err_unlock_ovs;
+		goto err_free_reply;
 	}
+	rcu_read_unlock();
+
+	/* It is safe to dereference "table" after leaving rcu read-protected
+	 * region because it's pinned by refcount.
+	 */
+	mutex_lock(&table->lock);
+
 	/* Check that the flow exists. */
 	if (ufid_present)
 		flow = ovs_flow_tbl_lookup_ufid(table, &sfid);
@@ -1314,16 +1347,16 @@ static int ovs_flow_cmd_set(struct sk_buff *skb, struct genl_info *info)
 		flow = ovs_flow_tbl_lookup_exact(table, &match);
 	if (unlikely(!flow)) {
 		error = -ENOENT;
-		goto err_unlock_ovs;
+		goto err_unlock_tbl;
 	}
 
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
@@ -1333,20 +1366,22 @@ static int ovs_flow_cmd_set(struct sk_buff *skb, struct genl_info *info)
 		}
 	} else {
 		/* Could not alloc without acts before locking. */
-		reply = ovs_flow_cmd_build_info(flow, ovs_header->dp_ifindex,
+		reply = ovs_flow_cmd_build_info(flow, table,
+						ovs_header->dp_ifindex,
 						info, OVS_FLOW_CMD_SET, false,
 						ufid_flags);
 
 		if (IS_ERR(reply)) {
 			error = PTR_ERR(reply);
-			goto err_unlock_ovs;
+			goto err_unlock_tbl;
 		}
 	}
 
 	/* Clear stats. */
 	if (a[OVS_FLOW_ATTR_CLEAR])
-		ovs_flow_stats_clear(flow);
-	ovs_unlock();
+		ovs_flow_stats_clear(flow, table);
+	mutex_unlock(&table->lock);
+	ovs_flow_tbl_put(table);
 
 	if (reply)
 		ovs_notify(&dp_flow_genl_family, reply, info);
@@ -1355,8 +1390,10 @@ static int ovs_flow_cmd_set(struct sk_buff *skb, struct genl_info *info)
 
 	return 0;
 
-err_unlock_ovs:
-	ovs_unlock();
+err_unlock_tbl:
+	mutex_unlock(&table->lock);
+	ovs_flow_tbl_put(table);
+err_free_reply:
 	kfree_skb(reply);
 err_kfree_acts:
 	ovs_nla_free_flow_actions(acts);
@@ -1394,17 +1431,24 @@ static int ovs_flow_cmd_get(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		return err;
 
-	ovs_lock();
+	rcu_read_lock();
 	dp = get_dp(sock_net(skb->sk), ovs_header->dp_ifindex);
 	if (!dp) {
-		err = -ENODEV;
-		goto unlock;
+		rcu_read_unlock();
+		return -ENODEV;
 	}
-	table = ovsl_dereference(dp->table);
-	if (!table) {
-		err = -ENODEV;
-		goto unlock;
+	table = rcu_dereference(dp->table);
+	if (!table || !ovs_flow_tbl_get(table)) {
+		rcu_read_unlock();
+		return -ENODEV;
 	}
+	rcu_read_unlock();
+
+	/* It is safe to dereference "table" after leaving rcu read-protected
+	 * region because it's pinned by refcount.
+	 */
+	mutex_lock(&table->lock);
+
 
 	if (ufid_present)
 		flow = ovs_flow_tbl_lookup_ufid(table, &ufid);
@@ -1415,17 +1459,20 @@ static int ovs_flow_cmd_get(struct sk_buff *skb, struct genl_info *info)
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
 	}
 
-	ovs_unlock();
+	mutex_unlock(&table->lock);
+	ovs_flow_tbl_put(table);
 	return genlmsg_reply(reply, info);
 unlock:
-	ovs_unlock();
+	mutex_unlock(&table->lock);
+	ovs_flow_tbl_put(table);
 	return err;
 }
 
@@ -1455,17 +1502,24 @@ static int ovs_flow_cmd_del(struct sk_buff *skb, struct genl_info *info)
 			return err;
 	}
 
-	ovs_lock();
+	rcu_read_lock();
 	dp = get_dp(sock_net(skb->sk), ovs_header->dp_ifindex);
 	if (unlikely(!dp)) {
-		err = -ENODEV;
-		goto unlock;
+		rcu_read_unlock();
+		return -ENODEV;
 	}
-	table = ovsl_dereference(dp->table);
-	if (!table) {
-		err = -ENODEV;
-		goto unlock;
+	table = rcu_dereference(dp->table);
+	if (!table || !ovs_flow_tbl_get(table)) {
+		rcu_read_unlock();
+		return -ENODEV;
 	}
+	rcu_read_unlock();
+
+	/* It is safe to dereference "table" after leaving rcu read-protected
+	 * region because it's pinned by refcount.
+	 */
+	mutex_lock(&table->lock);
+
 
 	if (unlikely(!a[OVS_FLOW_ATTR_KEY] && !ufid_present)) {
 		err = ovs_flow_tbl_flush(table);
@@ -1482,14 +1536,15 @@ static int ovs_flow_cmd_del(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	ovs_flow_tbl_remove(table, flow);
-	ovs_unlock();
+	mutex_unlock(&table->lock);
 
 	reply = ovs_flow_cmd_alloc_info((const struct sw_flow_actions __force *) flow->sf_acts,
 					&flow->id, info, false, ufid_flags);
 	if (likely(reply)) {
 		if (!IS_ERR(reply)) {
 			rcu_read_lock();	/*To keep RCU checker happy. */
-			err = ovs_flow_cmd_fill_info(flow, ovs_header->dp_ifindex,
+			err = ovs_flow_cmd_fill_info(flow, table,
+						     ovs_header->dp_ifindex,
 						     reply, info->snd_portid,
 						     info->snd_seq, 0,
 						     OVS_FLOW_CMD_DEL,
@@ -1508,10 +1563,12 @@ static int ovs_flow_cmd_del(struct sk_buff *skb, struct genl_info *info)
 	}
 
 out_free:
+	ovs_flow_tbl_put(table);
 	ovs_flow_free(flow, true);
 	return 0;
 unlock:
-	ovs_unlock();
+	mutex_unlock(&table->lock);
+	ovs_flow_tbl_put(table);
 	return err;
 }
 
@@ -1537,7 +1594,7 @@ static int ovs_flow_cmd_dump(struct sk_buff *skb, struct netlink_callback *cb)
 		rcu_read_unlock();
 		return -ENODEV;
 	}
-	table = rcu_dereference_ovsl(dp->table);
+	table = rcu_dereference(dp->table);
 	if (!table) {
 		rcu_read_unlock();
 		return -ENODEV;
@@ -1554,8 +1611,8 @@ static int ovs_flow_cmd_dump(struct sk_buff *skb, struct netlink_callback *cb)
 		if (!flow)
 			break;
 
-		if (ovs_flow_cmd_fill_info(flow, ovs_header->dp_ifindex, skb,
-					   NETLINK_CB(cb->skb).portid,
+		if (ovs_flow_cmd_fill_info(flow, table, ovs_header->dp_ifindex,
+					   skb, NETLINK_CB(cb->skb).portid,
 					   cb->nlh->nlmsg_seq, NLM_F_MULTI,
 					   OVS_FLOW_CMD_GET, ufid_flags) < 0)
 			break;
@@ -1642,10 +1699,6 @@ static int ovs_dp_cmd_fill_info(struct datapath *dp, struct sk_buff *skb,
 	struct flow_table *table;
 	int err, pids_len;
 
-	table = ovsl_dereference(dp->table);
-	if (!table)
-		return -ENODEV;
-
 	ovs_header = genlmsg_put(skb, portid, seq, &dp_datapath_genl_family,
 				 flags, cmd);
 	if (!ovs_header)
@@ -1670,8 +1723,12 @@ static int ovs_dp_cmd_fill_info(struct datapath *dp, struct sk_buff *skb,
 	if (nla_put_u32(skb, OVS_DP_ATTR_USER_FEATURES, dp->user_features))
 		goto nla_put_failure;
 
-	if (nla_put_u32(skb, OVS_DP_ATTR_MASKS_CACHE_SIZE,
-			ovs_flow_tbl_masks_cache_size(table)))
+	rcu_read_lock();
+	table = rcu_dereference(dp->table);
+	err = table ? nla_put_u32(skb, OVS_DP_ATTR_MASKS_CACHE_SIZE,
+				  ovs_flow_tbl_masks_cache_size(table)) : 0;
+	rcu_read_unlock();
+	if (err)
 		goto nla_put_failure;
 
 	if (dp->user_features & OVS_DP_F_DISPATCH_UPCALL_PER_CPU && pids) {
@@ -1809,7 +1866,9 @@ static int ovs_dp_change(struct datapath *dp, struct nlattr *a[])
 			return -ENODEV;
 
 		cache_size = nla_get_u32(a[OVS_DP_ATTR_MASKS_CACHE_SIZE]);
+		mutex_lock(&table->lock);
 		err = ovs_flow_tbl_masks_cache_resize(table, cache_size);
+		mutex_unlock(&table->lock);
 		if (err)
 			return err;
 	}
@@ -1960,7 +2019,7 @@ static int ovs_dp_cmd_new(struct sk_buff *skb, struct genl_info *info)
 err_destroy_stats:
 	free_percpu(dp->stats_percpu);
 err_destroy_table:
-	call_rcu(&table->rcu, ovs_flow_tbl_destroy_rcu);
+	ovs_flow_tbl_put(table);
 err_destroy_dp:
 	kfree(dp);
 err_destroy_reply:
@@ -1972,7 +2031,8 @@ static int ovs_dp_cmd_new(struct sk_buff *skb, struct genl_info *info)
 /* Called with ovs_mutex. */
 static void __dp_destroy(struct datapath *dp)
 {
-	struct flow_table *table = ovsl_dereference(dp->table);
+	struct flow_table *table = rcu_dereference_protected(dp->table,
+					lockdep_ovsl_is_held());
 	int i;
 
 	if (dp->user_features & OVS_DP_F_TC_RECIRC_SHARING)
@@ -1994,16 +2054,11 @@ static void __dp_destroy(struct datapath *dp)
 	 */
 	ovs_dp_detach_port(ovs_vport_ovsl(dp, OVSP_LOCAL));
 
-	/* Flush sw_flow in the tables. RCU cb only releases resource
-	 * such as dp, ports and tables. That may avoid some issues
-	 * such as RCU usage warning.
-	 */
-	table_instance_flow_flush(table, ovsl_dereference(table->ti),
-				  ovsl_dereference(table->ufid_ti));
+	rcu_assign_pointer(dp->table, NULL);
+	ovs_flow_tbl_put(table);
 
-	/* RCU destroy the ports, meters and flow tables. */
+	/* RCU destroy the ports and meters. */
 	call_rcu(&dp->rcu, destroy_dp_rcu);
-	call_rcu(&table->rcu, ovs_flow_tbl_destroy_rcu);
 }
 
 static int ovs_dp_cmd_del(struct sk_buff *skb, struct genl_info *info)
@@ -2647,9 +2702,12 @@ static void ovs_dp_masks_rebalance(struct work_struct *work)
 	ovs_lock();
 	list_for_each_entry(dp, &ovs_net->dps, list_node) {
 		table = ovsl_dereference(dp->table);
-		if (!table)
+		if (!table || !ovs_flow_tbl_get(table))
 			continue;
+		mutex_lock(&table->lock);
 		ovs_flow_masks_rebalance(table);
+		mutex_unlock(&table->lock);
+		ovs_flow_tbl_put(table);
 	}
 	ovs_unlock();
 
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
index 3b7518e3394d..3934873a44c3 100644
--- a/net/openvswitch/flow_table.c
+++ b/net/openvswitch/flow_table.c
@@ -45,6 +45,16 @@
 static struct kmem_cache *flow_cache;
 struct kmem_cache *flow_stats_cache __read_mostly;
 
+#ifdef CONFIG_LOCKDEP
+int lockdep_ovs_tbl_is_held(const struct flow_table *table)
+{
+	if (debug_locks)
+		return lockdep_is_held(&table->lock);
+	else
+		return 1;
+}
+#endif
+
 static u16 range_n_bytes(const struct sw_flow_key_range *range)
 {
 	return range->end - range->start;
@@ -102,7 +112,7 @@ struct sw_flow *ovs_flow_alloc(void)
 
 int ovs_flow_tbl_count(const struct flow_table *table)
 {
-	return table->count;
+	return READ_ONCE(table->count);
 }
 
 static void flow_free(struct sw_flow *flow)
@@ -249,12 +259,12 @@ static int tbl_mask_array_realloc(struct flow_table *tbl, int size)
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
@@ -268,7 +278,7 @@ static int tbl_mask_array_realloc(struct flow_table *tbl, int size)
 static int tbl_mask_array_add_mask(struct flow_table *tbl,
 				   struct sw_flow_mask *new)
 {
-	struct mask_array *ma = ovsl_dereference(tbl->mask_array);
+	struct mask_array *ma = ovs_tbl_dereference(tbl->mask_array, tbl);
 	int err, ma_count = READ_ONCE(ma->count);
 
 	if (ma_count >= ma->max) {
@@ -277,7 +287,7 @@ static int tbl_mask_array_add_mask(struct flow_table *tbl,
 		if (err)
 			return err;
 
-		ma = ovsl_dereference(tbl->mask_array);
+		ma = ovs_tbl_dereference(tbl->mask_array, tbl);
 	} else {
 		/* On every add or delete we need to reset the counters so
 		 * every new mask gets a fair chance of being prioritized.
@@ -285,7 +295,7 @@ static int tbl_mask_array_add_mask(struct flow_table *tbl,
 		tbl_mask_array_reset_counters(ma);
 	}
 
-	BUG_ON(ovsl_dereference(ma->masks[ma_count]));
+	WARN_ON_ONCE(ovs_tbl_dereference(ma->masks[ma_count], tbl));
 
 	rcu_assign_pointer(ma->masks[ma_count], new);
 	WRITE_ONCE(ma->count, ma_count + 1);
@@ -296,12 +306,12 @@ static int tbl_mask_array_add_mask(struct flow_table *tbl,
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
 
@@ -329,10 +339,10 @@ static void tbl_mask_array_del_mask(struct flow_table *tbl,
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
 
@@ -386,7 +396,8 @@ static struct mask_cache *tbl_mask_cache_alloc(u32 size)
 }
 int ovs_flow_tbl_masks_cache_resize(struct flow_table *table, u32 size)
 {
-	struct mask_cache *mc = rcu_dereference_ovsl(table->mask_cache);
+	struct mask_cache *mc = rcu_dereference_ovs_tbl(table->mask_cache,
+							table);
 	struct mask_cache *new;
 
 	if (size == mc->cache_size)
@@ -416,6 +427,10 @@ struct flow_table *ovs_flow_tbl_alloc(void)
 	table = kzalloc_obj(*table, GFP_KERNEL);
 	if (!table)
 		return ERR_PTR(-ENOMEM);
+
+	mutex_init(&table->lock);
+	refcount_set(&table->refcnt, 1);
+
 	mc = tbl_mask_cache_alloc(MC_DEFAULT_HASH_ENTRIES);
 	if (!mc)
 		goto free_table;
@@ -448,6 +463,7 @@ struct flow_table *ovs_flow_tbl_alloc(void)
 free_mask_cache:
 	__mask_cache_destroy(mc);
 free_table:
+	mutex_destroy(&table->lock);
 	kfree(table);
 	return ERR_PTR(-ENOMEM);
 }
@@ -466,7 +482,7 @@ static void table_instance_flow_free(struct flow_table *table,
 				     struct sw_flow *flow)
 {
 	hlist_del_rcu(&flow->flow_table.node[ti->node_ver]);
-	table->count--;
+	WRITE_ONCE(table->count, table->count - 1);
 
 	if (ovs_identifier_is_ufid(&flow->id)) {
 		hlist_del_rcu(&flow->ufid_table.node[ufid_ti->node_ver]);
@@ -476,10 +492,10 @@ static void table_instance_flow_free(struct flow_table *table,
 	flow_mask_remove(table, flow->mask);
 }
 
-/* Must be called with OVS mutex held. */
-void table_instance_flow_flush(struct flow_table *table,
-			       struct table_instance *ti,
-			       struct table_instance *ufid_ti)
+/* Must be called with table mutex held. */
+static void table_instance_flow_flush(struct flow_table *table,
+				      struct table_instance *ti,
+				      struct table_instance *ufid_ti)
 {
 	int i;
 
@@ -499,7 +515,7 @@ void table_instance_flow_flush(struct flow_table *table,
 
 	if (WARN_ON(table->count != 0 ||
 		    table->ufid_count != 0)) {
-		table->count = 0;
+		WRITE_ONCE(table->count, 0);
 		table->ufid_count = 0;
 	}
 }
@@ -512,7 +528,7 @@ static void table_instance_destroy(struct table_instance *ti,
 }
 
 /* No need for locking this function is called from RCU callback. */
-void ovs_flow_tbl_destroy_rcu(struct rcu_head *rcu)
+static void ovs_flow_tbl_destroy_rcu(struct rcu_head *rcu)
 {
 	struct flow_table *table = container_of(rcu, struct flow_table, rcu);
 
@@ -524,9 +540,22 @@ void ovs_flow_tbl_destroy_rcu(struct rcu_head *rcu)
 	call_rcu(&mc->rcu, mask_cache_rcu_cb);
 	call_rcu(&ma->rcu, mask_array_rcu_cb);
 	table_instance_destroy(ti, ufid_ti);
+	mutex_destroy(&table->lock);
 	kfree(table);
 }
 
+void ovs_flow_tbl_put(struct flow_table *table)
+{
+	if (refcount_dec_and_test(&table->refcnt)) {
+		mutex_lock(&table->lock);
+		table_instance_flow_flush(table,
+					  ovs_tbl_dereference(table->ti, table),
+					  ovs_tbl_dereference(table->ufid_ti, table));
+		mutex_unlock(&table->lock);
+		call_rcu(&table->rcu, ovs_flow_tbl_destroy_rcu);
+	}
+}
+
 struct sw_flow *ovs_flow_tbl_dump_next(struct table_instance *ti,
 				       u32 *bucket, u32 *last)
 {
@@ -578,7 +607,8 @@ static void ufid_table_instance_insert(struct table_instance *ti,
 	hlist_add_head_rcu(&flow->ufid_table.node[ti->node_ver], head);
 }
 
-static void flow_table_copy_flows(struct table_instance *old,
+static void flow_table_copy_flows(struct flow_table *table,
+				  struct table_instance *old,
 				  struct table_instance *new, bool ufid)
 {
 	int old_ver;
@@ -595,17 +625,18 @@ static void flow_table_copy_flows(struct table_instance *old,
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
@@ -614,16 +645,19 @@ static struct table_instance *table_instance_rehash(struct table_instance *ti,
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
@@ -631,8 +665,8 @@ int ovs_flow_tbl_flush(struct flow_table *flow_table)
 	if (!new_ufid_ti)
 		goto err_free_ti;
 
-	old_ti = ovsl_dereference(flow_table->ti);
-	old_ufid_ti = ovsl_dereference(flow_table->ufid_ti);
+	old_ti = ovs_tbl_dereference(flow_table->ti, flow_table);
+	old_ufid_ti = ovs_tbl_dereference(flow_table->ufid_ti, flow_table);
 
 	rcu_assign_pointer(flow_table->ti, new_ti);
 	rcu_assign_pointer(flow_table->ufid_ti, new_ufid_ti);
@@ -700,7 +734,8 @@ static bool ovs_flow_cmp_unmasked_key(const struct sw_flow *flow,
 	return cmp_key(flow->id.unmasked_key, key, key_start, key_end);
 }
 
-static struct sw_flow *masked_flow_lookup(struct table_instance *ti,
+static struct sw_flow *masked_flow_lookup(struct flow_table *tbl,
+					  struct table_instance *ti,
 					  const struct sw_flow_key *unmasked,
 					  const struct sw_flow_mask *mask,
 					  u32 *n_mask_hit)
@@ -716,7 +751,7 @@ static struct sw_flow *masked_flow_lookup(struct table_instance *ti,
 	(*n_mask_hit)++;
 
 	hlist_for_each_entry_rcu(flow, head, flow_table.node[ti->node_ver],
-				 lockdep_ovsl_is_held()) {
+				 lockdep_ovs_tbl_is_held(tbl)) {
 		if (flow->mask == mask && flow->flow_table.hash == hash &&
 		    flow_cmp_masked_key(flow, &masked_key, &mask->range))
 			return flow;
@@ -743,9 +778,9 @@ static struct sw_flow *flow_lookup(struct flow_table *tbl,
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
@@ -761,11 +796,11 @@ static struct sw_flow *flow_lookup(struct flow_table *tbl,
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
@@ -852,8 +887,8 @@ struct sw_flow *ovs_flow_tbl_lookup_stats(struct flow_table *tbl,
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
@@ -872,21 +907,22 @@ struct sw_flow *ovs_flow_tbl_lookup(struct flow_table *tbl,
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
@@ -922,7 +958,7 @@ bool ovs_flow_cmp(const struct sw_flow *flow,
 struct sw_flow *ovs_flow_tbl_lookup_ufid(struct flow_table *tbl,
 					 const struct sw_flow_id *ufid)
 {
-	struct table_instance *ti = rcu_dereference_ovsl(tbl->ufid_ti);
+	struct table_instance *ti = rcu_dereference_ovs_tbl(tbl->ufid_ti, tbl);
 	struct sw_flow *flow;
 	struct hlist_head *head;
 	u32 hash;
@@ -930,7 +966,7 @@ struct sw_flow *ovs_flow_tbl_lookup_ufid(struct flow_table *tbl,
 	hash = ufid_hash(ufid);
 	head = find_bucket(ti, hash);
 	hlist_for_each_entry_rcu(flow, head, ufid_table.node[ti->node_ver],
-				 lockdep_ovsl_is_held()) {
+				 lockdep_ovs_tbl_is_held(tbl)) {
 		if (flow->ufid_table.hash == hash &&
 		    ovs_flow_cmp_ufid(flow, ufid))
 			return flow;
@@ -940,28 +976,33 @@ struct sw_flow *ovs_flow_tbl_lookup_ufid(struct flow_table *tbl,
 
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
@@ -995,10 +1036,10 @@ static struct sw_flow_mask *flow_mask_find(const struct flow_table *tbl,
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
@@ -1036,22 +1077,25 @@ static int flow_mask_insert(struct flow_table *tbl, struct sw_flow *flow,
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
-	table->count++;
+	WRITE_ONCE(table->count, table->count + 1);
 
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
@@ -1060,13 +1104,15 @@ static void flow_key_insert(struct flow_table *table, struct sw_flow *flow)
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
 
@@ -1074,7 +1120,7 @@ static void flow_ufid_insert(struct flow_table *table, struct sw_flow *flow)
 	if (table->ufid_count > ti->n_buckets) {
 		struct table_instance *new_ti;
 
-		new_ti = table_instance_expand(ti, true);
+		new_ti = table_instance_expand(table, ti, true);
 		if (new_ti) {
 			rcu_assign_pointer(table->ufid_ti, new_ti);
 			call_rcu(&ti->rcu, flow_tbl_destroy_rcu_cb);
@@ -1082,12 +1128,14 @@ static void flow_ufid_insert(struct flow_table *table, struct sw_flow *flow)
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
@@ -1106,10 +1154,11 @@ static int compare_mask_and_count(const void *a, const void *b)
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
@@ -1124,7 +1173,7 @@ void ovs_flow_masks_rebalance(struct flow_table *table)
 		struct sw_flow_mask *mask;
 		int cpu;
 
-		mask = rcu_dereference_ovsl(ma->masks[i]);
+		mask = rcu_dereference_ovs_tbl(ma->masks[i], table);
 		if (unlikely(!mask))
 			break;
 
@@ -1178,7 +1227,7 @@ void ovs_flow_masks_rebalance(struct flow_table *table)
 	for (i = 0; i < masks_entries; i++) {
 		int index = masks_and_count[i].index;
 
-		if (ovsl_dereference(ma->masks[index]))
+		if (ovs_tbl_dereference(ma->masks[index], table))
 			new->masks[new->count++] = ma->masks[index];
 	}
 
diff --git a/net/openvswitch/flow_table.h b/net/openvswitch/flow_table.h
index 6211bcc72655..1b5242a97813 100644
--- a/net/openvswitch/flow_table.h
+++ b/net/openvswitch/flow_table.h
@@ -59,7 +59,31 @@ struct table_instance {
 	u32 hash_seed;
 };
 
+/* Locking:
+ *
+ * flow_table is _not_ protected by ovs_lock (see comment above ovs_mutex
+ * in datapath.c).
+ *
+ * All writes to flow_table are protected by the embedded "lock".
+ * In order to ensure datapath destruction does not trigger the destruction
+ * of the flow_table, "refcnt" is used. Therefore, writers must:
+ * 1 - Enter rcu read-protected section
+ * 2 - Increase "table->refcnt"
+ * 3 - Leave rcu read-protected section (to avoid using mutexes inside rcu)
+ * 4 - Lock "table->lock"
+ * 5 - Perform modifications
+ * 6 - Release "table->lock"
+ * 7 - Decrease "table->refcnt"
+ *
+ * Reads are protected by RCU.
+ *
+ * Note with this schema, it's possible that a flow operation is performed on a
+ * flow_table that is about to be freed.
+ */
 struct flow_table {
+	/* Locks flow table writes. */
+	struct mutex lock;
+	refcount_t refcnt;
 	struct rcu_head rcu;
 	struct table_instance __rcu *ti;
 	struct table_instance __rcu *ufid_ti;
@@ -72,6 +96,26 @@ struct flow_table {
 
 extern struct kmem_cache *flow_stats_cache;
 
+#ifdef CONFIG_LOCKDEP
+int lockdep_ovs_tbl_is_held(const struct flow_table *table);
+#else
+static inline int lockdep_ovs_tbl_is_held(const struct flow_table *table
+					  __always_unused)
+{
+	return 1;
+}
+#endif
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
 
@@ -79,7 +123,11 @@ struct sw_flow *ovs_flow_alloc(void);
 void ovs_flow_free(struct sw_flow *, bool deferred);
 
 struct flow_table *ovs_flow_tbl_alloc(void);
-void ovs_flow_tbl_destroy_rcu(struct rcu_head *table);
+void ovs_flow_tbl_put(struct flow_table *table);
+static inline bool ovs_flow_tbl_get(struct flow_table *table)
+{
+	return refcount_inc_not_zero(&table->refcnt);
+}
 int ovs_flow_tbl_count(const struct flow_table *table);
 int ovs_flow_tbl_flush(struct flow_table *flow_table);
 
@@ -109,8 +157,5 @@ void ovs_flow_mask_key(struct sw_flow_key *dst, const struct sw_flow_key *src,
 		       bool full, const struct sw_flow_mask *mask);
 
 void ovs_flow_masks_rebalance(struct flow_table *table);
-void table_instance_flow_flush(struct flow_table *table,
-			       struct table_instance *ti,
-			       struct table_instance *ufid_ti);
 
 #endif /* flow_table.h */
-- 
2.53.0


