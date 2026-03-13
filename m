Return-Path: <netdev+bounces-267547-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPnhHgpKtGk4kAAAu9opvQ
	(envelope-from <netdev+bounces-267547-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 18:31:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A61288222
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 18:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1897D3026A8F
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 17:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9903C5DBD;
	Fri, 13 Mar 2026 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VnIzvKJC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7053AA4FB
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 17:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773423098; cv=none; b=MefRFdVj2DhAiXKJJmSIvHe5t8dqyJ6I4+Vb57w6LMO1ldalSX2uYmxmlEU/RfZ7xnrXzz87LXLsiBYXJd+FQk4sUuZkt0es3sdXATnqY/wc4OFhd1kbvfHNssuihk1cGajbbbLCzSNrtYGF7gr3deeNgk150mkU/OjFIAREywM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773423098; c=relaxed/simple;
	bh=wbySveCzDMiR2b7UjfcDsRx87JeLzCrInLhXESam6js=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qhRNDhMcicd/nlFOgz9bj/e8YQrmlUV6mGFV+lNaeQBafQv1VS7WYNsh1WdjISD5udl/Q/IW3zMsGLjLl+LyMJxTK7m8t3LdnOzuot3obJe3SmEcem4HsjOibcnJlGBYY3mneLj/hcUFW3Fm52Rj76pAcib8PzsPLDIFDdxr6y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VnIzvKJC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773423090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qXleTLXckz3JiDEiiLx2zxsQraqZ2MclTVDTHjc6ahA=;
	b=VnIzvKJCdcw18xTkOR+rQMrTe50l1Yq4808jNSq+QKVeJljz+whwcOEX8OkE1kftiNqGbi
	vLys1IlD0tkWvbZtFqcob7u+1g22hCjn7RPa6Ygl9c1q8Si+88KUC8DLDEWO1BfTYXspw+
	q6w4cwCDjVokh6T9/Q7AkUQYSghfSX8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-8LphzqyGOo2lVIuRj5L8Yw-1; Fri,
 13 Mar 2026 13:31:27 -0400
X-MC-Unique: 8LphzqyGOo2lVIuRj5L8Yw-1
X-Mimecast-MFC-AGG-ID: 8LphzqyGOo2lVIuRj5L8Yw_1773423085
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 563FC1800372;
	Fri, 13 Mar 2026 17:31:25 +0000 (UTC)
Received: from antares (unknown [10.45.224.13])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 61D1D30002DC;
	Fri, 13 Mar 2026 17:31:20 +0000 (UTC)
From: Adrian Moreno <amorenoz@redhat.com>
To: netdev@vger.kernel.org
Cc: Adrian Moreno <amorenoz@redhat.com>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v1] net: openvswitch: decouple flow_table from ovs_mutex
Date: Fri, 13 Mar 2026 18:31:12 +0100
Message-ID: <20260313173114.1220551-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267547-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amorenoz@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13A61288222
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently the entire ovs module is write-protected using the global
ovs_mutex. While this simple approach works fine for control-plane
operations (such as vport configurations), requiring the global mutex
for flow modifications can be problematic.

During periods of high control-plane operations, e.g: netdevs (vports)
coming and going, RTNL can suffer contention. This contention is easily
transferred to the ovs_mutex as RTNL nests inside ovs_mutex. Flow
modifications, however, are done as part of packet processing and having
them wait for RTNL pressure to go away can lead to packet drops.

This patch decouples flow_table modifications from ovs_mutex by means of
the following:

1 - Make flow_table an rcu-protected pointer inside the datapath.
This allows both objects to be protected independently while reducing the
amount of changes required in "flow_table.c".

2 - Create a new mutex inside the flow_table that protects it from
concurrent modifications.
Putting the mutex inside flow_table makes it easier to consume for
functions inside flow_table.c that do not currently take pointers to the
datapath.
Some function signatures need to be changed to accept flow_table so that
lockdep checks can be performed.

3 - Create a reference count to temporarily extend rcu protection from
the datapath to the flow_table.
In order to use the flow_table without locking ovs_mutex, the flow_table
pointer must be first dereferenced within an rcu-protected region.
Next, the table->mutex needs to be locked to protect it from
concurrent writes but mutexes must not be locked inside an rcu-protected
region, so the rcu-protected region must be left at which point the
datapath can be concurrently freed.
To extend the protection beyond the rcu region, a reference count is used.
One reference is held by the datapath, the other is temporarily
increased during flow modifications. For example:

Datapath deletion:

  ovs_lock();
  table = rcu_dereference_protected(dp->table, ...);
  rcu_assign_pointer(dp->table, NULL);
  ovs_flow_tbl_put(table);
  ovs_unlock();

Flow modification:

  rcu_read_lock();
  dp = get_dp(...);
  table = rcu_dereference(dp->table);
  ovs_flow_tbl_get(table);
  rcu_read_unlock();

  mutex_lock(&table->lock);
  /* Perform modifications on the flow_table */
  mutex_unlock(&table->lock);
  ovs_flow_tbl_put(table);

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 net/openvswitch/datapath.c   | 284 ++++++++++++++++++++++++-----------
 net/openvswitch/datapath.h   |   2 +-
 net/openvswitch/flow.c       |  13 +-
 net/openvswitch/flow.h       |   9 +-
 net/openvswitch/flow_table.c | 180 ++++++++++++++--------
 net/openvswitch/flow_table.h |  51 ++++++-
 6 files changed, 379 insertions(+), 160 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index d5b6e2002bc1..133701fb0c77 100644
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
@@ -166,7 +170,6 @@ static void destroy_dp_rcu(struct rcu_head *rcu)
 {
 	struct datapath *dp = container_of(rcu, struct datapath, rcu);
 
-	ovs_flow_tbl_destroy(&dp->table);
 	free_percpu(dp->stats_percpu);
 	kfree(dp->ports);
 	ovs_meters_exit(dp);
@@ -247,6 +250,7 @@ void ovs_dp_process_packet(struct sk_buff *skb, struct sw_flow_key *key)
 	struct ovs_pcpu_storage *ovs_pcpu = this_cpu_ptr(ovs_pcpu_storage);
 	const struct vport *p = OVS_CB(skb)->input_vport;
 	struct datapath *dp = p->dp;
+	struct flow_table *table;
 	struct sw_flow *flow;
 	struct sw_flow_actions *sf_acts;
 	struct dp_stats_percpu *stats;
@@ -257,9 +261,16 @@ void ovs_dp_process_packet(struct sk_buff *skb, struct sw_flow_key *key)
 	int error;
 
 	stats = this_cpu_ptr(dp->stats_percpu);
+	table = rcu_dereference(dp->table);
+	if (!table) {
+		net_dbg_ratelimited("ovs: no flow table on datapath %s\n",
+				    ovs_dp_name(dp));
+		kfree_skb(skb);
+		return;
+	}
 
 	/* Look up flow. */
-	flow = ovs_flow_tbl_lookup_stats(&dp->table, key, skb_get_hash(skb),
+	flow = ovs_flow_tbl_lookup_stats(table, key, skb_get_hash(skb),
 					 &n_mask_hit, &n_cache_hit);
 	if (unlikely(!flow)) {
 		struct dp_upcall_info upcall;
@@ -752,12 +763,16 @@ static struct genl_family dp_packet_genl_family __ro_after_init = {
 static void get_dp_stats(const struct datapath *dp, struct ovs_dp_stats *stats,
 			 struct ovs_dp_megaflow_stats *mega_stats)
 {
+	struct flow_table *table = ovsl_dereference(dp->table);
 	int i;
 
 	memset(mega_stats, 0, sizeof(*mega_stats));
 
-	stats->n_flows = ovs_flow_tbl_count(&dp->table);
-	mega_stats->n_masks = ovs_flow_tbl_num_masks(&dp->table);
+	if (table) {
+		stats->n_flows = ovs_flow_tbl_count(table);
+		mega_stats->n_masks = ovs_flow_tbl_num_masks(table);
+	}
+
 
 	stats->n_hit = stats->n_missed = stats->n_lost = 0;
 
@@ -829,15 +844,16 @@ static size_t ovs_flow_cmd_msg_size(const struct sw_flow_actions *acts,
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
@@ -857,8 +873,9 @@ static int ovs_flow_cmd_fill_stats(const struct sw_flow *flow,
 	return 0;
 }
 
-/* Called with ovs_mutex or RCU read lock. */
+/* Called with RCU read lock or table->lock held. */
 static int ovs_flow_cmd_fill_actions(const struct sw_flow *flow,
+				     const struct flow_table *table,
 				     struct sk_buff *skb, int skb_orig_len)
 {
 	struct nlattr *start;
@@ -878,7 +895,7 @@ static int ovs_flow_cmd_fill_actions(const struct sw_flow *flow,
 	if (start) {
 		const struct sw_flow_actions *sf_acts;
 
-		sf_acts = rcu_dereference_ovsl(flow->sf_acts);
+		sf_acts = rcu_dereference_ovs_tbl(flow->sf_acts, table);
 		err = ovs_nla_put_actions(sf_acts->actions,
 					  sf_acts->actions_len, skb);
 
@@ -897,8 +914,10 @@ static int ovs_flow_cmd_fill_actions(const struct sw_flow *flow,
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
@@ -929,12 +948,12 @@ static int ovs_flow_cmd_fill_info(const struct sw_flow *flow, int dp_ifindex,
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
@@ -968,8 +987,9 @@ static struct sk_buff *ovs_flow_cmd_alloc_info(const struct sw_flow_actions *act
 	return skb;
 }
 
-/* Called with ovs_mutex. */
+/* Called with table->lock. */
 static struct sk_buff *ovs_flow_cmd_build_info(const struct sw_flow *flow,
+					       const struct flow_table *table,
 					       int dp_ifindex,
 					       struct genl_info *info, u8 cmd,
 					       bool always, u32 ufid_flags)
@@ -977,12 +997,12 @@ static struct sk_buff *ovs_flow_cmd_build_info(const struct sw_flow *flow,
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
@@ -998,6 +1018,7 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr **a = info->attrs;
 	struct ovs_header *ovs_header = genl_info_userhdr(info);
 	struct sw_flow *flow = NULL, *new_flow;
+	struct flow_table *table;
 	struct sw_flow_mask mask;
 	struct sk_buff *reply;
 	struct datapath *dp;
@@ -1064,30 +1085,43 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
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
+	table = rcu_dereference(dp->table);
+	if (!table || !ovs_flow_tbl_get(table)) {
+		error = -ENODEV;
+		rcu_read_unlock();
+		goto err_kfree_reply;
+	}
+	rcu_read_unlock();
+
+	/* It is safe to dereference "table" after leaving rcu read-protected
+	 * region because it's pinned by refcount.
+	 */
+	mutex_lock(&table->lock);
 
 	/* Check if this is a duplicate flow */
 	if (ovs_identifier_is_ufid(&new_flow->id))
-		flow = ovs_flow_tbl_lookup_ufid(&dp->table, &new_flow->id);
+		flow = ovs_flow_tbl_lookup_ufid(table, &new_flow->id);
 	if (!flow)
-		flow = ovs_flow_tbl_lookup(&dp->table, key);
+		flow = ovs_flow_tbl_lookup(table, key);
 	if (likely(!flow)) {
 		rcu_assign_pointer(new_flow->sf_acts, acts);
 
 		/* Put flow in bucket. */
-		error = ovs_flow_tbl_insert(&dp->table, new_flow, &mask);
+		error = ovs_flow_tbl_insert(table, new_flow, &mask);
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
@@ -1095,7 +1129,8 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
 						       ufid_flags);
 			BUG_ON(error < 0);
 		}
-		ovs_unlock();
+		mutex_unlock(&table->lock);
+		ovs_flow_tbl_put(table);
 	} else {
 		struct sw_flow_actions *old_acts;
 
@@ -1108,28 +1143,28 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
 		if (unlikely(info->nlhdr->nlmsg_flags & (NLM_F_CREATE
 							 | NLM_F_EXCL))) {
 			error = -EEXIST;
-			goto err_unlock_ovs;
+			goto err_unlock_tbl;
 		}
 		/* The flow identifier has to be the same for flow updates.
 		 * Look for any overlapping flow.
 		 */
 		if (unlikely(!ovs_flow_cmp(flow, &match))) {
 			if (ovs_identifier_is_key(&flow->id))
-				flow = ovs_flow_tbl_lookup_exact(&dp->table,
+				flow = ovs_flow_tbl_lookup_exact(table,
 								 &match);
 			else /* UFID matches but key is different */
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
@@ -1137,7 +1172,8 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
 						       ufid_flags);
 			BUG_ON(error < 0);
 		}
-		ovs_unlock();
+		mutex_unlock(&table->lock);
+		ovs_flow_tbl_put(table);
 
 		ovs_nla_free_flow_actions_rcu(old_acts);
 		ovs_flow_free(new_flow, false);
@@ -1149,8 +1185,10 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
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
@@ -1244,6 +1282,7 @@ static int ovs_flow_cmd_set(struct sk_buff *skb, struct genl_info *info)
 	struct net *net = sock_net(skb->sk);
 	struct nlattr **a = info->attrs;
 	struct ovs_header *ovs_header = genl_info_userhdr(info);
+	struct flow_table *table;
 	struct sw_flow_key key;
 	struct sw_flow *flow;
 	struct sk_buff *reply = NULL;
@@ -1278,29 +1317,42 @@ static int ovs_flow_cmd_set(struct sk_buff *skb, struct genl_info *info)
 		}
 	}
 
-	ovs_lock();
+	rcu_read_lock();
 	dp = get_dp(net, ovs_header->dp_ifindex);
 	if (unlikely(!dp)) {
 		error = -ENODEV;
-		goto err_unlock_ovs;
+		goto err_free_reply;
 	}
+	table = rcu_dereference(dp->table);
+	if (!table || !ovs_flow_tbl_get(table)) {
+		rcu_read_unlock();
+		error = -ENODEV;
+		goto err_free_reply;
+	}
+	rcu_read_unlock();
+
+	/* It is safe to dereference "table" after leaving rcu read-protected
+	 * region because it's pinned by refcount.
+	 */
+	mutex_lock(&table->lock);
+
 	/* Check that the flow exists. */
 	if (ufid_present)
-		flow = ovs_flow_tbl_lookup_ufid(&dp->table, &sfid);
+		flow = ovs_flow_tbl_lookup_ufid(table, &sfid);
 	else
-		flow = ovs_flow_tbl_lookup_exact(&dp->table, &match);
+		flow = ovs_flow_tbl_lookup_exact(table, &match);
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
@@ -1310,20 +1362,22 @@ static int ovs_flow_cmd_set(struct sk_buff *skb, struct genl_info *info)
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
@@ -1332,8 +1386,10 @@ static int ovs_flow_cmd_set(struct sk_buff *skb, struct genl_info *info)
 
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
@@ -1346,6 +1402,7 @@ static int ovs_flow_cmd_get(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr **a = info->attrs;
 	struct ovs_header *ovs_header = genl_info_userhdr(info);
 	struct net *net = sock_net(skb->sk);
+	struct flow_table *table;
 	struct sw_flow_key key;
 	struct sk_buff *reply;
 	struct sw_flow *flow;
@@ -1370,33 +1427,48 @@ static int ovs_flow_cmd_get(struct sk_buff *skb, struct genl_info *info)
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
+	table = rcu_dereference(dp->table);
+	if (!table || !ovs_flow_tbl_get(table)) {
+		rcu_read_unlock();
+		return -ENODEV;
+	}
+	rcu_read_unlock();
+
+	/* It is safe to dereference "table" after leaving rcu read-protected
+	 * region because it's pinned by refcount.
+	 */
+	mutex_lock(&table->lock);
+
 
 	if (ufid_present)
-		flow = ovs_flow_tbl_lookup_ufid(&dp->table, &ufid);
+		flow = ovs_flow_tbl_lookup_ufid(table, &ufid);
 	else
-		flow = ovs_flow_tbl_lookup_exact(&dp->table, &match);
+		flow = ovs_flow_tbl_lookup_exact(table, &match);
 	if (!flow) {
 		err = -ENOENT;
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
 
@@ -1405,6 +1477,7 @@ static int ovs_flow_cmd_del(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr **a = info->attrs;
 	struct ovs_header *ovs_header = genl_info_userhdr(info);
 	struct net *net = sock_net(skb->sk);
+	struct flow_table *table;
 	struct sw_flow_key key;
 	struct sk_buff *reply;
 	struct sw_flow *flow = NULL;
@@ -1425,36 +1498,49 @@ static int ovs_flow_cmd_del(struct sk_buff *skb, struct genl_info *info)
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
+	table = rcu_dereference(dp->table);
+	if (!table || !ovs_flow_tbl_get(table)) {
+		rcu_read_unlock();
+		return -ENODEV;
+	}
+	rcu_read_unlock();
+
+	/* It is safe to dereference "table" after leaving rcu read-protected
+	 * region because it's pinned by refcount.
+	 */
+	mutex_lock(&table->lock);
+
 
 	if (unlikely(!a[OVS_FLOW_ATTR_KEY] && !ufid_present)) {
-		err = ovs_flow_tbl_flush(&dp->table);
+		err = ovs_flow_tbl_flush(table);
 		goto unlock;
 	}
 
 	if (ufid_present)
-		flow = ovs_flow_tbl_lookup_ufid(&dp->table, &ufid);
+		flow = ovs_flow_tbl_lookup_ufid(table, &ufid);
 	else
-		flow = ovs_flow_tbl_lookup_exact(&dp->table, &match);
+		flow = ovs_flow_tbl_lookup_exact(table, &match);
 	if (unlikely(!flow)) {
 		err = -ENOENT;
 		goto unlock;
 	}
 
-	ovs_flow_tbl_remove(&dp->table, flow);
-	ovs_unlock();
+	ovs_flow_tbl_remove(table, flow);
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
@@ -1473,10 +1559,12 @@ static int ovs_flow_cmd_del(struct sk_buff *skb, struct genl_info *info)
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
 
@@ -1485,6 +1573,7 @@ static int ovs_flow_cmd_dump(struct sk_buff *skb, struct netlink_callback *cb)
 	struct nlattr *a[__OVS_FLOW_ATTR_MAX];
 	struct ovs_header *ovs_header = genlmsg_data(nlmsg_data(cb->nlh));
 	struct table_instance *ti;
+	struct flow_table *table;
 	struct datapath *dp;
 	u32 ufid_flags;
 	int err;
@@ -1501,8 +1590,13 @@ static int ovs_flow_cmd_dump(struct sk_buff *skb, struct netlink_callback *cb)
 		rcu_read_unlock();
 		return -ENODEV;
 	}
+	table = rcu_dereference(dp->table);
+	if (!table) {
+		rcu_read_unlock();
+		return -ENODEV;
+	}
 
-	ti = rcu_dereference(dp->table.ti);
+	ti = rcu_dereference(table->ti);
 	for (;;) {
 		struct sw_flow *flow;
 		u32 bucket, obj;
@@ -1513,8 +1607,8 @@ static int ovs_flow_cmd_dump(struct sk_buff *skb, struct netlink_callback *cb)
 		if (!flow)
 			break;
 
-		if (ovs_flow_cmd_fill_info(flow, ovs_header->dp_ifindex, skb,
-					   NETLINK_CB(cb->skb).portid,
+		if (ovs_flow_cmd_fill_info(flow, table, ovs_header->dp_ifindex,
+					   skb, NETLINK_CB(cb->skb).portid,
 					   cb->nlh->nlmsg_seq, NLM_F_MULTI,
 					   OVS_FLOW_CMD_GET, ufid_flags) < 0)
 			break;
@@ -1598,8 +1692,13 @@ static int ovs_dp_cmd_fill_info(struct datapath *dp, struct sk_buff *skb,
 	struct ovs_dp_stats dp_stats;
 	struct ovs_dp_megaflow_stats dp_megaflow_stats;
 	struct dp_nlsk_pids *pids = ovsl_dereference(dp->upcall_portids);
+	struct flow_table *table;
 	int err, pids_len;
 
+	table = ovsl_dereference(dp->table);
+	if (!table)
+		return -ENODEV;
+
 	ovs_header = genlmsg_put(skb, portid, seq, &dp_datapath_genl_family,
 				 flags, cmd);
 	if (!ovs_header)
@@ -1625,7 +1724,7 @@ static int ovs_dp_cmd_fill_info(struct datapath *dp, struct sk_buff *skb,
 		goto nla_put_failure;
 
 	if (nla_put_u32(skb, OVS_DP_ATTR_MASKS_CACHE_SIZE,
-			ovs_flow_tbl_masks_cache_size(&dp->table)))
+			ovs_flow_tbl_masks_cache_size(table)))
 		goto nla_put_failure;
 
 	if (dp->user_features & OVS_DP_F_DISPATCH_UPCALL_PER_CPU && pids) {
@@ -1736,6 +1835,7 @@ u32 ovs_dp_get_upcall_portid(const struct datapath *dp, uint32_t cpu_id)
 static int ovs_dp_change(struct datapath *dp, struct nlattr *a[])
 {
 	u32 user_features = 0, old_features = dp->user_features;
+	struct flow_table *table;
 	int err;
 
 	if (a[OVS_DP_ATTR_USER_FEATURES]) {
@@ -1757,8 +1857,12 @@ static int ovs_dp_change(struct datapath *dp, struct nlattr *a[])
 		int err;
 		u32 cache_size;
 
+		table = ovsl_dereference(dp->table);
+		if (!table)
+			return -ENODEV;
+
 		cache_size = nla_get_u32(a[OVS_DP_ATTR_MASKS_CACHE_SIZE]);
-		err = ovs_flow_tbl_masks_cache_resize(&dp->table, cache_size);
+		err = ovs_flow_tbl_masks_cache_resize(table, cache_size);
 		if (err)
 			return err;
 	}
@@ -1812,6 +1916,7 @@ static int ovs_dp_vport_init(struct datapath *dp)
 static int ovs_dp_cmd_new(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr **a = info->attrs;
+	struct flow_table *table;
 	struct vport_parms parms;
 	struct sk_buff *reply;
 	struct datapath *dp;
@@ -1835,9 +1940,12 @@ static int ovs_dp_cmd_new(struct sk_buff *skb, struct genl_info *info)
 	ovs_dp_set_net(dp, sock_net(skb->sk));
 
 	/* Allocate table. */
-	err = ovs_flow_tbl_init(&dp->table);
-	if (err)
+	table = ovs_flow_tbl_alloc();
+	if (IS_ERR(table)) {
+		err = PTR_ERR(table);
 		goto err_destroy_dp;
+	}
+	rcu_assign_pointer(dp->table, table);
 
 	err = ovs_dp_stats_init(dp);
 	if (err)
@@ -1907,7 +2015,7 @@ static int ovs_dp_cmd_new(struct sk_buff *skb, struct genl_info *info)
 err_destroy_stats:
 	free_percpu(dp->stats_percpu);
 err_destroy_table:
-	ovs_flow_tbl_destroy(&dp->table);
+	ovs_flow_tbl_put(dp->table);
 err_destroy_dp:
 	kfree(dp);
 err_destroy_reply:
@@ -1919,7 +2027,8 @@ static int ovs_dp_cmd_new(struct sk_buff *skb, struct genl_info *info)
 /* Called with ovs_mutex. */
 static void __dp_destroy(struct datapath *dp)
 {
-	struct flow_table *table = &dp->table;
+	struct flow_table *table = rcu_dereference_protected(dp->table,
+					lockdep_ovsl_is_held());
 	int i;
 
 	if (dp->user_features & OVS_DP_F_TC_RECIRC_SHARING)
@@ -1941,14 +2050,10 @@ static void __dp_destroy(struct datapath *dp)
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
 }
 
@@ -2556,13 +2661,18 @@ static void ovs_dp_masks_rebalance(struct work_struct *work)
 {
 	struct ovs_net *ovs_net = container_of(work, struct ovs_net,
 					       masks_rebalance.work);
+	struct flow_table *table;
 	struct datapath *dp;
 
 	ovs_lock();
-
-	list_for_each_entry(dp, &ovs_net->dps, list_node)
-		ovs_flow_masks_rebalance(&dp->table);
-
+	list_for_each_entry_rcu(dp, &ovs_net->dps, list_node) {
+		table = ovsl_dereference(dp->table);
+		if (!table)
+			continue;
+		mutex_lock(&table->lock);
+		ovs_flow_masks_rebalance(table);
+		mutex_unlock(&table->lock);
+	}
 	ovs_unlock();
 
 	schedule_delayed_work(&ovs_net->masks_rebalance,
diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
index db0c3e69d66c..44773bf9f645 100644
--- a/net/openvswitch/datapath.h
+++ b/net/openvswitch/datapath.h
@@ -90,7 +90,7 @@ struct datapath {
 	struct list_head list_node;
 
 	/* Flow table. */
-	struct flow_table table;
+	struct flow_table __rcu *table;
 
 	/* Switch ports. */
 	struct hlist_head *ports;
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
index ffc72a741a50..188e9d39ce00 100644
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
@@ -250,12 +260,12 @@ static int tbl_mask_array_realloc(struct flow_table *tbl, int size)
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
@@ -269,7 +279,7 @@ static int tbl_mask_array_realloc(struct flow_table *tbl, int size)
 static int tbl_mask_array_add_mask(struct flow_table *tbl,
 				   struct sw_flow_mask *new)
 {
-	struct mask_array *ma = ovsl_dereference(tbl->mask_array);
+	struct mask_array *ma = ovs_tbl_dereference(tbl->mask_array, tbl);
 	int err, ma_count = READ_ONCE(ma->count);
 
 	if (ma_count >= ma->max) {
@@ -278,7 +288,7 @@ static int tbl_mask_array_add_mask(struct flow_table *tbl,
 		if (err)
 			return err;
 
-		ma = ovsl_dereference(tbl->mask_array);
+		ma = ovs_tbl_dereference(tbl->mask_array, tbl);
 	} else {
 		/* On every add or delete we need to reset the counters so
 		 * every new mask gets a fair chance of being prioritized.
@@ -286,7 +296,7 @@ static int tbl_mask_array_add_mask(struct flow_table *tbl,
 		tbl_mask_array_reset_counters(ma);
 	}
 
-	BUG_ON(ovsl_dereference(ma->masks[ma_count]));
+	WARN_ON_ONCE(ovs_tbl_dereference(ma->masks[ma_count], tbl));
 
 	rcu_assign_pointer(ma->masks[ma_count], new);
 	WRITE_ONCE(ma->count, ma_count + 1);
@@ -297,12 +307,12 @@ static int tbl_mask_array_add_mask(struct flow_table *tbl,
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
 
@@ -330,10 +340,10 @@ static void tbl_mask_array_del_mask(struct flow_table *tbl,
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
 
@@ -387,7 +397,8 @@ static struct mask_cache *tbl_mask_cache_alloc(u32 size)
 }
 int ovs_flow_tbl_masks_cache_resize(struct flow_table *table, u32 size)
 {
-	struct mask_cache *mc = rcu_dereference_ovsl(table->mask_cache);
+	struct mask_cache *mc = rcu_dereference_ovs_tbl(table->mask_cache,
+							table);
 	struct mask_cache *new;
 
 	if (size == mc->cache_size)
@@ -407,15 +418,23 @@ int ovs_flow_tbl_masks_cache_resize(struct flow_table *table, u32 size)
 	return 0;
 }
 
-int ovs_flow_tbl_init(struct flow_table *table)
+struct flow_table *ovs_flow_tbl_alloc(void)
 {
 	struct table_instance *ti, *ufid_ti;
+	struct flow_table *table;
 	struct mask_cache *mc;
 	struct mask_array *ma;
 
+	table = kzalloc_obj(*table, GFP_KERNEL);
+	if (!table)
+		return ERR_PTR(-ENOMEM);
+
+	mutex_init(&table->lock);
+	refcount_set(&table->refcnt, 1);
+
 	mc = tbl_mask_cache_alloc(MC_DEFAULT_HASH_ENTRIES);
 	if (!mc)
-		return -ENOMEM;
+		goto free_table;
 
 	ma = tbl_mask_array_alloc(MASK_ARRAY_SIZE_MIN);
 	if (!ma)
@@ -436,7 +455,7 @@ int ovs_flow_tbl_init(struct flow_table *table)
 	table->last_rehash = jiffies;
 	table->count = 0;
 	table->ufid_count = 0;
-	return 0;
+	return table;
 
 free_ti:
 	__table_instance_destroy(ti);
@@ -444,7 +463,10 @@ int ovs_flow_tbl_init(struct flow_table *table)
 	__mask_array_destroy(ma);
 free_mask_cache:
 	__mask_cache_destroy(mc);
-	return -ENOMEM;
+free_table:
+	mutex_destroy(&table->lock);
+	kfree(table);
+	return ERR_PTR(-ENOMEM);
 }
 
 static void flow_tbl_destroy_rcu_cb(struct rcu_head *rcu)
@@ -471,7 +493,7 @@ static void table_instance_flow_free(struct flow_table *table,
 	flow_mask_remove(table, flow->mask);
 }
 
-/* Must be called with OVS mutex held. */
+/* Must be called with table mutex held. */
 void table_instance_flow_flush(struct flow_table *table,
 			       struct table_instance *ti,
 			       struct table_instance *ufid_ti)
@@ -506,11 +528,11 @@ static void table_instance_destroy(struct table_instance *ti,
 	call_rcu(&ufid_ti->rcu, flow_tbl_destroy_rcu_cb);
 }
 
-/* No need for locking this function is called from RCU callback or
- * error path.
- */
-void ovs_flow_tbl_destroy(struct flow_table *table)
+/* No need for locking this function is called from RCU callback. */
+static void ovs_flow_tbl_destroy_rcu(struct rcu_head *rcu)
 {
+	struct flow_table *table = container_of(rcu, struct flow_table, rcu);
+
 	struct table_instance *ti = rcu_dereference_raw(table->ti);
 	struct table_instance *ufid_ti = rcu_dereference_raw(table->ufid_ti);
 	struct mask_cache *mc = rcu_dereference_raw(table->mask_cache);
@@ -519,6 +541,20 @@ void ovs_flow_tbl_destroy(struct flow_table *table)
 	call_rcu(&mc->rcu, mask_cache_rcu_cb);
 	call_rcu(&ma->rcu, mask_array_rcu_cb);
 	table_instance_destroy(ti, ufid_ti);
+	mutex_destroy(&table->lock);
+	kfree(table);
+}
+
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
 }
 
 struct sw_flow *ovs_flow_tbl_dump_next(struct table_instance *ti,
@@ -572,7 +608,8 @@ static void ufid_table_instance_insert(struct table_instance *ti,
 	hlist_add_head_rcu(&flow->ufid_table.node[ti->node_ver], head);
 }
 
-static void flow_table_copy_flows(struct table_instance *old,
+static void flow_table_copy_flows(struct flow_table *table,
+				  struct table_instance *old,
 				  struct table_instance *new, bool ufid)
 {
 	int old_ver;
@@ -589,17 +626,18 @@ static void flow_table_copy_flows(struct table_instance *old,
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
@@ -608,16 +646,19 @@ static struct table_instance *table_instance_rehash(struct table_instance *ti,
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
@@ -625,8 +666,8 @@ int ovs_flow_tbl_flush(struct flow_table *flow_table)
 	if (!new_ufid_ti)
 		goto err_free_ti;
 
-	old_ti = ovsl_dereference(flow_table->ti);
-	old_ufid_ti = ovsl_dereference(flow_table->ufid_ti);
+	old_ti = ovs_tbl_dereference(flow_table->ti, flow_table);
+	old_ufid_ti = ovs_tbl_dereference(flow_table->ufid_ti, flow_table);
 
 	rcu_assign_pointer(flow_table->ti, new_ti);
 	rcu_assign_pointer(flow_table->ufid_ti, new_ufid_ti);
@@ -694,7 +735,8 @@ static bool ovs_flow_cmp_unmasked_key(const struct sw_flow *flow,
 	return cmp_key(flow->id.unmasked_key, key, key_start, key_end);
 }
 
-static struct sw_flow *masked_flow_lookup(struct table_instance *ti,
+static struct sw_flow *masked_flow_lookup(struct flow_table *tbl,
+					  struct table_instance *ti,
 					  const struct sw_flow_key *unmasked,
 					  const struct sw_flow_mask *mask,
 					  u32 *n_mask_hit)
@@ -710,7 +752,7 @@ static struct sw_flow *masked_flow_lookup(struct table_instance *ti,
 	(*n_mask_hit)++;
 
 	hlist_for_each_entry_rcu(flow, head, flow_table.node[ti->node_ver],
-				 lockdep_ovsl_is_held()) {
+				 lockdep_ovs_tbl_is_held(tbl)) {
 		if (flow->mask == mask && flow->flow_table.hash == hash &&
 		    flow_cmp_masked_key(flow, &masked_key, &mask->range))
 			return flow;
@@ -737,9 +779,9 @@ static struct sw_flow *flow_lookup(struct flow_table *tbl,
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
@@ -755,11 +797,11 @@ static struct sw_flow *flow_lookup(struct flow_table *tbl,
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
@@ -846,8 +888,8 @@ struct sw_flow *ovs_flow_tbl_lookup_stats(struct flow_table *tbl,
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
@@ -866,21 +908,22 @@ struct sw_flow *ovs_flow_tbl_lookup(struct flow_table *tbl,
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
@@ -916,7 +959,7 @@ bool ovs_flow_cmp(const struct sw_flow *flow,
 struct sw_flow *ovs_flow_tbl_lookup_ufid(struct flow_table *tbl,
 					 const struct sw_flow_id *ufid)
 {
-	struct table_instance *ti = rcu_dereference_ovsl(tbl->ufid_ti);
+	struct table_instance *ti = rcu_dereference_ovs_tbl(tbl->ufid_ti, tbl);
 	struct sw_flow *flow;
 	struct hlist_head *head;
 	u32 hash;
@@ -924,7 +967,7 @@ struct sw_flow *ovs_flow_tbl_lookup_ufid(struct flow_table *tbl,
 	hash = ufid_hash(ufid);
 	head = find_bucket(ti, hash);
 	hlist_for_each_entry_rcu(flow, head, ufid_table.node[ti->node_ver],
-				 lockdep_ovsl_is_held()) {
+				 lockdep_ovs_tbl_is_held(tbl)) {
 		if (flow->ufid_table.hash == hash &&
 		    ovs_flow_cmp_ufid(flow, ufid))
 			return flow;
@@ -934,28 +977,33 @@ struct sw_flow *ovs_flow_tbl_lookup_ufid(struct flow_table *tbl,
 
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
@@ -989,10 +1037,10 @@ static struct sw_flow_mask *flow_mask_find(const struct flow_table *tbl,
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
@@ -1030,22 +1078,25 @@ static int flow_mask_insert(struct flow_table *tbl, struct sw_flow *flow,
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
@@ -1054,13 +1105,15 @@ static void flow_key_insert(struct flow_table *table, struct sw_flow *flow)
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
 
@@ -1068,7 +1121,7 @@ static void flow_ufid_insert(struct flow_table *table, struct sw_flow *flow)
 	if (table->ufid_count > ti->n_buckets) {
 		struct table_instance *new_ti;
 
-		new_ti = table_instance_expand(ti, true);
+		new_ti = table_instance_expand(table, ti, true);
 		if (new_ti) {
 			rcu_assign_pointer(table->ufid_ti, new_ti);
 			call_rcu(&ti->rcu, flow_tbl_destroy_rcu_cb);
@@ -1076,12 +1129,14 @@ static void flow_ufid_insert(struct flow_table *table, struct sw_flow *flow)
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
@@ -1100,10 +1155,11 @@ static int compare_mask_and_count(const void *a, const void *b)
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
@@ -1119,7 +1175,7 @@ void ovs_flow_masks_rebalance(struct flow_table *table)
 		struct sw_flow_mask *mask;
 		int cpu;
 
-		mask = rcu_dereference_ovsl(ma->masks[i]);
+		mask = rcu_dereference_ovs_tbl(ma->masks[i], table);
 		if (unlikely(!mask))
 			break;
 
@@ -1173,7 +1229,7 @@ void ovs_flow_masks_rebalance(struct flow_table *table)
 	for (i = 0; i < masks_entries; i++) {
 		int index = masks_and_count[i].index;
 
-		if (ovsl_dereference(ma->masks[index]))
+		if (ovs_tbl_dereference(ma->masks[index], table))
 			new->masks[new->count++] = ma->masks[index];
 	}
 
diff --git a/net/openvswitch/flow_table.h b/net/openvswitch/flow_table.h
index f524dc3e4862..cffd412c9045 100644
--- a/net/openvswitch/flow_table.h
+++ b/net/openvswitch/flow_table.h
@@ -59,7 +59,29 @@ struct table_instance {
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
+ */
 struct flow_table {
+	/* Locks flow table writes. */
+	struct mutex lock;
+	refcount_t refcnt;
+	struct rcu_head rcu;
 	struct table_instance __rcu *ti;
 	struct table_instance __rcu *ufid_ti;
 	struct mask_cache __rcu *mask_cache;
@@ -71,15 +93,40 @@ struct flow_table {
 
 extern struct kmem_cache *flow_stats_cache;
 
+#ifdef CONFIG_LOCKDEP
+int lockdep_ovs_tbl_is_held(const struct flow_table *table);
+#else
+static inline int lockdep_ovs_tbl_is_held(const struct flow_table *table)
+{
+	(void)table;
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
+/* Read dereferences can be protected by either RCU, table lock or ovs_mutex. */
+#define rcu_dereference_ovs_tbl(p, tbl) \
+	rcu_dereference_check(p,		\
+		lockdep_ovs_tbl_is_held(tbl) || lockdep_ovsl_is_held())
+
 int ovs_flow_init(void);
 void ovs_flow_exit(void);
 
 struct sw_flow *ovs_flow_alloc(void);
 void ovs_flow_free(struct sw_flow *, bool deferred);
 
-int ovs_flow_tbl_init(struct flow_table *);
+struct flow_table *ovs_flow_tbl_alloc(void);
+void ovs_flow_tbl_put(struct flow_table *table);
+static inline bool ovs_flow_tbl_get(struct flow_table *table)
+{
+	return refcount_inc_not_zero(&table->refcnt);
+}
 int ovs_flow_tbl_count(const struct flow_table *table);
-void ovs_flow_tbl_destroy(struct flow_table *table);
 int ovs_flow_tbl_flush(struct flow_table *flow_table);
 
 int ovs_flow_tbl_insert(struct flow_table *table, struct sw_flow *flow,
-- 
2.53.0


