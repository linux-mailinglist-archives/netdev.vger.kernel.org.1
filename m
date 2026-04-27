Return-Path: <netdev+bounces-281277-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2ATnCbUp72lE8AAAu9opvQ
	(envelope-from <netdev+bounces-281277-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 11:17:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA3046FB80
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 11:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E00CE301F4A3
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 09:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103F63A1A50;
	Mon, 27 Apr 2026 09:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gjhcYaKF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311D037DE87
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 09:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777281139; cv=none; b=HJIAv/2QU6olhD3PvTXDmHzCCmXP9LNhdErpgYsoh1WKp0BmaUx3/KW5WFWNing/ygbswvRNc+ZVwASF8kbd1giSrnAK0e6dZQSMCjqTg7Xs45yq4GOJpBhwKlFmaE4BpWIcbA/XrKWsarJQv0rsKRhqm393ZGrLBcys0N/A7Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777281139; c=relaxed/simple;
	bh=c8THx4Aa9gNZvrhZLJ7gaXLzZl9vwZjEwd2Uy6q9BM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bSps3x/kwR790ur5b3SXhtIfd6CIvz7Afkoj3qu9QIcpYR/6jIsoeXO9WpqvrXPJRVdkuMdjoBrxUrVfo6KJlUX8VaazrJOv2dnCFscbf/ehoRWgqsSKfA57+mLFjxIP3OpK3PL5AMeRhQhGsBHKoib3doffVb6ScsV1eHxXwpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gjhcYaKF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777281137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zjfHLvawIbqCLPfhB0oLblfB0S0mFOAhE4UGloe3qd4=;
	b=gjhcYaKFcSrfsTJiM+x3549ktxzsUwd6TS0Npc6nQxXFr6oG6tcS0wBuYMADPB2kckwIvS
	31KWRZQvcdTSgIvwbE3psRi4HPGsolFFcQ/c5GtoNkfPEK+ij8LrK3nCYMa98+pPr/yC9H
	5QlUL+C6gtHLKX7vYgs+OIuUgOlsiOM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-4CMJYahiPxGhoJrHyWcyrQ-1; Mon,
 27 Apr 2026 05:12:11 -0400
X-MC-Unique: 4CMJYahiPxGhoJrHyWcyrQ-1
X-Mimecast-MFC-AGG-ID: 4CMJYahiPxGhoJrHyWcyrQ_1777281130
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38B78195605A;
	Mon, 27 Apr 2026 09:12:10 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.44.33.10])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F02E11800446;
	Mon, 27 Apr 2026 09:12:04 +0000 (UTC)
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
Subject: [PATCH net-next v3 1/2] net: openvswitch: make flow_table an rcu pointer
Date: Mon, 27 Apr 2026 11:11:47 +0200
Message-ID: <20260427091153.3210301-2-amorenoz@redhat.com>
In-Reply-To: <20260427091153.3210301-1-amorenoz@redhat.com>
References: <20260427091153.3210301-1-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 7FA3046FB80
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
	TAGGED_FROM(0.00)[bounces-281277-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amorenoz@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,masks_rebalance.work:url]

This patch turns "flow_table" from being embedded into "datapath" to
being an rcu protected pointer. No functional change intended.

Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
---
 net/openvswitch/datapath.c   | 113 ++++++++++++++++++++++++++---------
 net/openvswitch/datapath.h   |   2 +-
 net/openvswitch/flow_table.c |  23 ++++---
 net/openvswitch/flow_table.h |   5 +-
 4 files changed, 105 insertions(+), 38 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index e209099218b4..b2243ba866a6 100644
--- a/net/openvswitch/datapath.c
+++ b/net/openvswitch/datapath.c
@@ -166,7 +166,6 @@ static void destroy_dp_rcu(struct rcu_head *rcu)
 {
 	struct datapath *dp = container_of(rcu, struct datapath, rcu);
 
-	ovs_flow_tbl_destroy(&dp->table);
 	free_percpu(dp->stats_percpu);
 	kfree(dp->ports);
 	ovs_meters_exit(dp);
@@ -247,6 +246,7 @@ void ovs_dp_process_packet(struct sk_buff *skb, struct sw_flow_key *key)
 	struct ovs_pcpu_storage *ovs_pcpu = this_cpu_ptr(ovs_pcpu_storage);
 	const struct vport *p = OVS_CB(skb)->input_vport;
 	struct datapath *dp = p->dp;
+	struct flow_table *table;
 	struct sw_flow *flow;
 	struct sw_flow_actions *sf_acts;
 	struct dp_stats_percpu *stats;
@@ -257,9 +257,16 @@ void ovs_dp_process_packet(struct sk_buff *skb, struct sw_flow_key *key)
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
@@ -752,12 +759,16 @@ static struct genl_family dp_packet_genl_family __ro_after_init = {
 static void get_dp_stats(const struct datapath *dp, struct ovs_dp_stats *stats,
 			 struct ovs_dp_megaflow_stats *mega_stats)
 {
+	struct flow_table *table = ovsl_dereference(dp->table);
 	int i;
 
 	memset(mega_stats, 0, sizeof(*mega_stats));
+	memset(stats, 0, sizeof(*stats));
 
-	stats->n_flows = ovs_flow_tbl_count(&dp->table);
-	mega_stats->n_masks = ovs_flow_tbl_num_masks(&dp->table);
+	if (table) {
+		stats->n_flows = ovs_flow_tbl_count(table);
+		mega_stats->n_masks = ovs_flow_tbl_num_masks(table);
+	}
 
 	stats->n_hit = stats->n_missed = stats->n_lost = 0;
 
@@ -998,6 +1009,7 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr **a = info->attrs;
 	struct ovs_header *ovs_header = genl_info_userhdr(info);
 	struct sw_flow *flow = NULL, *new_flow;
+	struct flow_table *table;
 	struct sw_flow_mask mask;
 	struct sk_buff *reply;
 	struct datapath *dp;
@@ -1070,17 +1082,22 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
 		error = -ENODEV;
 		goto err_unlock_ovs;
 	}
+	table = ovsl_dereference(dp->table);
+	if (!table) {
+		error = -ENODEV;
+		goto err_unlock_ovs;
+	}
 
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
 			goto err_unlock_ovs;
@@ -1115,7 +1132,7 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
 		 */
 		if (unlikely(!ovs_flow_cmp(flow, &match))) {
 			if (ovs_identifier_is_key(&flow->id))
-				flow = ovs_flow_tbl_lookup_exact(&dp->table,
+				flow = ovs_flow_tbl_lookup_exact(table,
 								 &match);
 			else /* UFID matches but key is different */
 				flow = NULL;
@@ -1244,6 +1261,7 @@ static int ovs_flow_cmd_set(struct sk_buff *skb, struct genl_info *info)
 	struct net *net = sock_net(skb->sk);
 	struct nlattr **a = info->attrs;
 	struct ovs_header *ovs_header = genl_info_userhdr(info);
+	struct flow_table *table;
 	struct sw_flow_key key;
 	struct sw_flow *flow;
 	struct sk_buff *reply = NULL;
@@ -1284,11 +1302,16 @@ static int ovs_flow_cmd_set(struct sk_buff *skb, struct genl_info *info)
 		error = -ENODEV;
 		goto err_unlock_ovs;
 	}
+	table = ovsl_dereference(dp->table);
+	if (!table) {
+		error = -ENODEV;
+		goto err_unlock_ovs;
+	}
 	/* Check that the flow exists. */
 	if (ufid_present)
-		flow = ovs_flow_tbl_lookup_ufid(&dp->table, &sfid);
+		flow = ovs_flow_tbl_lookup_ufid(table, &sfid);
 	else
-		flow = ovs_flow_tbl_lookup_exact(&dp->table, &match);
+		flow = ovs_flow_tbl_lookup_exact(table, &match);
 	if (unlikely(!flow)) {
 		error = -ENOENT;
 		goto err_unlock_ovs;
@@ -1346,6 +1369,7 @@ static int ovs_flow_cmd_get(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr **a = info->attrs;
 	struct ovs_header *ovs_header = genl_info_userhdr(info);
 	struct net *net = sock_net(skb->sk);
+	struct flow_table *table;
 	struct sw_flow_key key;
 	struct sk_buff *reply;
 	struct sw_flow *flow;
@@ -1376,11 +1400,16 @@ static int ovs_flow_cmd_get(struct sk_buff *skb, struct genl_info *info)
 		err = -ENODEV;
 		goto unlock;
 	}
+	table = ovsl_dereference(dp->table);
+	if (!table) {
+		err = -ENODEV;
+		goto unlock;
+	}
 
 	if (ufid_present)
-		flow = ovs_flow_tbl_lookup_ufid(&dp->table, &ufid);
+		flow = ovs_flow_tbl_lookup_ufid(table, &ufid);
 	else
-		flow = ovs_flow_tbl_lookup_exact(&dp->table, &match);
+		flow = ovs_flow_tbl_lookup_exact(table, &match);
 	if (!flow) {
 		err = -ENOENT;
 		goto unlock;
@@ -1405,6 +1434,7 @@ static int ovs_flow_cmd_del(struct sk_buff *skb, struct genl_info *info)
 	struct nlattr **a = info->attrs;
 	struct ovs_header *ovs_header = genl_info_userhdr(info);
 	struct net *net = sock_net(skb->sk);
+	struct flow_table *table;
 	struct sw_flow_key key;
 	struct sk_buff *reply;
 	struct sw_flow *flow = NULL;
@@ -1431,22 +1461,27 @@ static int ovs_flow_cmd_del(struct sk_buff *skb, struct genl_info *info)
 		err = -ENODEV;
 		goto unlock;
 	}
+	table = ovsl_dereference(dp->table);
+	if (!table) {
+		err = -ENODEV;
+		goto unlock;
+	}
 
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
+	ovs_flow_tbl_remove(table, flow);
 	ovs_unlock();
 
 	reply = ovs_flow_cmd_alloc_info((const struct sw_flow_actions __force *) flow->sf_acts,
@@ -1485,6 +1520,7 @@ static int ovs_flow_cmd_dump(struct sk_buff *skb, struct netlink_callback *cb)
 	struct nlattr *a[__OVS_FLOW_ATTR_MAX];
 	struct ovs_header *ovs_header = genlmsg_data(nlmsg_data(cb->nlh));
 	struct table_instance *ti;
+	struct flow_table *table;
 	struct datapath *dp;
 	u32 ufid_flags;
 	int err;
@@ -1501,8 +1537,13 @@ static int ovs_flow_cmd_dump(struct sk_buff *skb, struct netlink_callback *cb)
 		rcu_read_unlock();
 		return -ENODEV;
 	}
+	table = rcu_dereference_ovsl(dp->table);
+	if (!table) {
+		rcu_read_unlock();
+		return -ENODEV;
+	}
 
-	ti = rcu_dereference(dp->table.ti);
+	ti = rcu_dereference(table->ti);
 	for (;;) {
 		struct sw_flow *flow;
 		u32 bucket, obj;
@@ -1598,8 +1639,13 @@ static int ovs_dp_cmd_fill_info(struct datapath *dp, struct sk_buff *skb,
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
@@ -1625,7 +1671,7 @@ static int ovs_dp_cmd_fill_info(struct datapath *dp, struct sk_buff *skb,
 		goto nla_put_failure;
 
 	if (nla_put_u32(skb, OVS_DP_ATTR_MASKS_CACHE_SIZE,
-			ovs_flow_tbl_masks_cache_size(&dp->table)))
+			ovs_flow_tbl_masks_cache_size(table)))
 		goto nla_put_failure;
 
 	if (dp->user_features & OVS_DP_F_DISPATCH_UPCALL_PER_CPU && pids) {
@@ -1736,6 +1782,7 @@ u32 ovs_dp_get_upcall_portid(const struct datapath *dp, uint32_t cpu_id)
 static int ovs_dp_change(struct datapath *dp, struct nlattr *a[])
 {
 	u32 user_features = 0, old_features = dp->user_features;
+	struct flow_table *table;
 	int err;
 
 	if (a[OVS_DP_ATTR_USER_FEATURES]) {
@@ -1757,8 +1804,12 @@ static int ovs_dp_change(struct datapath *dp, struct nlattr *a[])
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
@@ -1810,6 +1861,7 @@ static int ovs_dp_vport_init(struct datapath *dp)
 static int ovs_dp_cmd_new(struct sk_buff *skb, struct genl_info *info)
 {
 	struct nlattr **a = info->attrs;
+	struct flow_table *table;
 	struct vport_parms parms;
 	struct sk_buff *reply;
 	struct datapath *dp;
@@ -1833,9 +1885,12 @@ static int ovs_dp_cmd_new(struct sk_buff *skb, struct genl_info *info)
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
@@ -1905,7 +1960,7 @@ static int ovs_dp_cmd_new(struct sk_buff *skb, struct genl_info *info)
 err_destroy_stats:
 	free_percpu(dp->stats_percpu);
 err_destroy_table:
-	ovs_flow_tbl_destroy(&dp->table);
+	call_rcu(&table->rcu, ovs_flow_tbl_destroy_rcu);
 err_destroy_dp:
 	kfree(dp);
 err_destroy_reply:
@@ -1917,7 +1972,7 @@ static int ovs_dp_cmd_new(struct sk_buff *skb, struct genl_info *info)
 /* Called with ovs_mutex. */
 static void __dp_destroy(struct datapath *dp)
 {
-	struct flow_table *table = &dp->table;
+	struct flow_table *table = ovsl_dereference(dp->table);
 	int i;
 
 	if (dp->user_features & OVS_DP_F_TC_RECIRC_SHARING)
@@ -1948,6 +2003,7 @@ static void __dp_destroy(struct datapath *dp)
 
 	/* RCU destroy the ports, meters and flow tables. */
 	call_rcu(&dp->rcu, destroy_dp_rcu);
+	call_rcu(&table->rcu, ovs_flow_tbl_destroy_rcu);
 }
 
 static int ovs_dp_cmd_del(struct sk_buff *skb, struct genl_info *info)
@@ -2554,13 +2610,16 @@ static void ovs_dp_masks_rebalance(struct work_struct *work)
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
+	list_for_each_entry(dp, &ovs_net->dps, list_node) {
+		table = ovsl_dereference(dp->table);
+		if (!table)
+			continue;
+		ovs_flow_masks_rebalance(table);
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
diff --git a/net/openvswitch/flow_table.c b/net/openvswitch/flow_table.c
index 67d5b8c0fe79..3b7518e3394d 100644
--- a/net/openvswitch/flow_table.c
+++ b/net/openvswitch/flow_table.c
@@ -406,15 +406,19 @@ int ovs_flow_tbl_masks_cache_resize(struct flow_table *table, u32 size)
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
 	mc = tbl_mask_cache_alloc(MC_DEFAULT_HASH_ENTRIES);
 	if (!mc)
-		return -ENOMEM;
+		goto free_table;
 
 	ma = tbl_mask_array_alloc(MASK_ARRAY_SIZE_MIN);
 	if (!ma)
@@ -435,7 +439,7 @@ int ovs_flow_tbl_init(struct flow_table *table)
 	table->last_rehash = jiffies;
 	table->count = 0;
 	table->ufid_count = 0;
-	return 0;
+	return table;
 
 free_ti:
 	__table_instance_destroy(ti);
@@ -443,7 +447,9 @@ int ovs_flow_tbl_init(struct flow_table *table)
 	__mask_array_destroy(ma);
 free_mask_cache:
 	__mask_cache_destroy(mc);
-	return -ENOMEM;
+free_table:
+	kfree(table);
+	return ERR_PTR(-ENOMEM);
 }
 
 static void flow_tbl_destroy_rcu_cb(struct rcu_head *rcu)
@@ -505,11 +511,11 @@ static void table_instance_destroy(struct table_instance *ti,
 	call_rcu(&ufid_ti->rcu, flow_tbl_destroy_rcu_cb);
 }
 
-/* No need for locking this function is called from RCU callback or
- * error path.
- */
-void ovs_flow_tbl_destroy(struct flow_table *table)
+/* No need for locking this function is called from RCU callback. */
+void ovs_flow_tbl_destroy_rcu(struct rcu_head *rcu)
 {
+	struct flow_table *table = container_of(rcu, struct flow_table, rcu);
+
 	struct table_instance *ti = rcu_dereference_raw(table->ti);
 	struct table_instance *ufid_ti = rcu_dereference_raw(table->ufid_ti);
 	struct mask_cache *mc = rcu_dereference_raw(table->mask_cache);
@@ -518,6 +524,7 @@ void ovs_flow_tbl_destroy(struct flow_table *table)
 	call_rcu(&mc->rcu, mask_cache_rcu_cb);
 	call_rcu(&ma->rcu, mask_array_rcu_cb);
 	table_instance_destroy(ti, ufid_ti);
+	kfree(table);
 }
 
 struct sw_flow *ovs_flow_tbl_dump_next(struct table_instance *ti,
diff --git a/net/openvswitch/flow_table.h b/net/openvswitch/flow_table.h
index f524dc3e4862..6211bcc72655 100644
--- a/net/openvswitch/flow_table.h
+++ b/net/openvswitch/flow_table.h
@@ -60,6 +60,7 @@ struct table_instance {
 };
 
 struct flow_table {
+	struct rcu_head rcu;
 	struct table_instance __rcu *ti;
 	struct table_instance __rcu *ufid_ti;
 	struct mask_cache __rcu *mask_cache;
@@ -77,9 +78,9 @@ void ovs_flow_exit(void);
 struct sw_flow *ovs_flow_alloc(void);
 void ovs_flow_free(struct sw_flow *, bool deferred);
 
-int ovs_flow_tbl_init(struct flow_table *);
+struct flow_table *ovs_flow_tbl_alloc(void);
+void ovs_flow_tbl_destroy_rcu(struct rcu_head *table);
 int ovs_flow_tbl_count(const struct flow_table *table);
-void ovs_flow_tbl_destroy(struct flow_table *table);
 int ovs_flow_tbl_flush(struct flow_table *flow_table);
 
 int ovs_flow_tbl_insert(struct flow_table *table, struct sw_flow *flow,
-- 
2.53.0


