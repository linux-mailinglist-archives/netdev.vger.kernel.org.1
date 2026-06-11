Return-Path: <netdev+bounces-297937-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UMa8IsxEKmrflQMAu9opvQ
	(envelope-from <netdev+bounces-297937-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 07:17:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF3866E768
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 07:16:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="T6/GJbZq";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297937-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297937-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAE983245877
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 04:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0843019C8;
	Thu, 11 Jun 2026 04:59:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD5A34EEEE
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 04:58:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781153940; cv=none; b=OVh1H42gDmlUeA+yF397m/efYkKadnqOXO6RgtxmSimWp+2/kcSCFeOz8RPXMc6fdR6bsDdX2jOYxf7HwKyEi8SN+l7WrrNdNBBd6bfaFLhjBWCA2Y/1/wA8SjAVYtY1C4wpE7eWrx6KvVq3uWzIiBYmu6LOUyBHeybDs7NwKyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781153940; c=relaxed/simple;
	bh=haEFlQ43eJYLYJtD2wpt0dw9pUdD/eYVnM/01ihqJlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2IK+lnuyE2GkrO5yaahrJy1dbvCl1IXw9oKJA7WLmGGD26g/6zrFQWHUBq8Im/HDkrgTbLm0SlZtFPu0/IvmsOSJY4YRnuAA5AX2Tq5n6o6QcltdfmddSLqQbww/l0bFJ709+I/7Je2+nKUfTrEVcVSjhQJVky4HbGQj5FdJRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T6/GJbZq; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781153925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C6P2SrUVRBsKiwwicpb7QjFCDKqa9XBbpkMcKHWq5XY=;
	b=T6/GJbZqvlcGXpa+3DWnXqUnrrwDcQ29yvbygBk689yv9AavpkCQL+Qj03Gh3VcdPq2KwN
	thXuN/kZZm3hbmkpq5knL4t2DmYRLeqiHAhFGGUPu6c4jnmxFQNQ38v4iOate4Q8hmcTNm
	4sW9NjPOUunkFUhvd+XOdVixuJhcFMY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-ooBgTeAwNdGusR_DgJg8bA-1; Thu,
 11 Jun 2026 00:58:42 -0400
X-MC-Unique: ooBgTeAwNdGusR_DgJg8bA-1
X-Mimecast-MFC-AGG-ID: ooBgTeAwNdGusR_DgJg8bA_1781153921
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFDE4195605E;
	Thu, 11 Jun 2026 04:58:40 +0000 (UTC)
Received: from antares.redhat.com (unknown [10.44.48.149])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AAC9C19541B0;
	Thu, 11 Jun 2026 04:58:36 +0000 (UTC)
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
Subject: [PATCH net-next v4 3/4] net: openvswitch: decouple flow_table from ovs_mutex
Date: Thu, 11 Jun 2026 06:58:10 +0200
Message-ID: <20260611045817.1302665-4-amorenoz@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297937-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CDF3866E768

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
 net/openvswitch/datapath.c   | 174 ++++++++++++++++++++++-------------
 net/openvswitch/flow_table.c |  46 +++++++--
 net/openvswitch/flow_table.h |  37 +++++++-
 3 files changed, 181 insertions(+), 76 deletions(-)

diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
index 72ad3ed12675..700ea79a324e 100644
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
 
@@ -1081,17 +1088,25 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
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
@@ -1105,7 +1120,7 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
 		error = ovs_flow_tbl_insert(table, new_flow, &mask);
 		if (unlikely(error)) {
 			acts = NULL;
-			goto err_unlock_ovs;
+			goto err_unlock_tbl;
 		}
 
 		if (unlikely(reply)) {
@@ -1117,7 +1132,6 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
 						       ufid_flags);
 			BUG_ON(error < 0);
 		}
-		ovs_unlock();
 	} else {
 		struct sw_flow_actions *old_acts;
 
@@ -1130,7 +1144,7 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
 		if (unlikely(info->nlhdr->nlmsg_flags & (NLM_F_CREATE
 							 | NLM_F_EXCL))) {
 			error = -EEXIST;
-			goto err_unlock_ovs;
+			goto err_unlock_tbl;
 		}
 		/* The flow identifier has to be the same for flow updates.
 		 * Look for any overlapping flow.
@@ -1143,7 +1157,7 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
 				flow = NULL;
 			if (!flow) {
 				error = -ENOENT;
-				goto err_unlock_ovs;
+				goto err_unlock_tbl;
 			}
 		}
 		/* Update actions. */
@@ -1159,20 +1173,23 @@ static int ovs_flow_cmd_new(struct sk_buff *skb, struct genl_info *info)
 						       ufid_flags);
 			BUG_ON(error < 0);
 		}
-		ovs_unlock();
-
 		ovs_nla_free_flow_actions_rcu(old_acts);
 		ovs_flow_free(new_flow, false);
 	}
 
+	mutex_unlock(&table->lock);
+	ovs_flow_tbl_put(table);
+
 	if (reply)
 		ovs_notify(&dp_flow_genl_family, reply, info);
 
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
@@ -1301,17 +1318,26 @@ static int ovs_flow_cmd_set(struct sk_buff *skb, struct genl_info *info)
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
@@ -1319,7 +1345,7 @@ static int ovs_flow_cmd_set(struct sk_buff *skb, struct genl_info *info)
 		flow = ovs_flow_tbl_lookup_exact(table, &match);
 	if (unlikely(!flow)) {
 		error = -ENOENT;
-		goto err_unlock_ovs;
+		goto err_unlock_tbl;
 	}
 
 	/* Update actions, if present. */
@@ -1345,14 +1371,16 @@ static int ovs_flow_cmd_set(struct sk_buff *skb, struct genl_info *info)
 
 		if (IS_ERR(reply)) {
 			error = PTR_ERR(reply);
-			goto err_unlock_ovs;
+			goto err_unlock_tbl;
 		}
 	}
 
 	/* Clear stats. */
 	if (a[OVS_FLOW_ATTR_CLEAR])
 		ovs_flow_stats_clear(flow, table);
-	ovs_unlock();
+
+	mutex_unlock(&table->lock);
+	ovs_flow_tbl_put(table);
 
 	if (reply)
 		ovs_notify(&dp_flow_genl_family, reply, info);
@@ -1361,8 +1389,10 @@ static int ovs_flow_cmd_set(struct sk_buff *skb, struct genl_info *info)
 
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
@@ -1400,17 +1430,24 @@ static int ovs_flow_cmd_get(struct sk_buff *skb, struct genl_info *info)
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
@@ -1429,10 +1466,12 @@ static int ovs_flow_cmd_get(struct sk_buff *skb, struct genl_info *info)
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
 
@@ -1462,17 +1501,24 @@ static int ovs_flow_cmd_del(struct sk_buff *skb, struct genl_info *info)
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
@@ -1489,7 +1535,7 @@ static int ovs_flow_cmd_del(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	ovs_flow_tbl_remove(table, flow);
-	ovs_unlock();
+	mutex_unlock(&table->lock);
 
 	reply = ovs_flow_cmd_alloc_info((const struct sw_flow_actions __force *) flow->sf_acts,
 					&flow->id, info, false, ufid_flags);
@@ -1516,10 +1562,12 @@ static int ovs_flow_cmd_del(struct sk_buff *skb, struct genl_info *info)
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
 
@@ -1545,7 +1593,7 @@ static int ovs_flow_cmd_dump(struct sk_buff *skb, struct netlink_callback *cb)
 		rcu_read_unlock();
 		return -ENODEV;
 	}
-	table = rcu_dereference_ovsl(dp->table);
+	table = rcu_dereference(dp->table);
 	if (!table) {
 		rcu_read_unlock();
 		return -ENODEV;
@@ -1650,10 +1698,6 @@ static int ovs_dp_cmd_fill_info(struct datapath *dp, struct sk_buff *skb,
 	struct flow_table *table;
 	int err, pids_len;
 
-	table = ovsl_dereference(dp->table);
-	if (!table)
-		return -ENODEV;
-
 	ovs_header = genlmsg_put(skb, portid, seq, &dp_datapath_genl_family,
 				 flags, cmd);
 	if (!ovs_header)
@@ -1678,8 +1722,12 @@ static int ovs_dp_cmd_fill_info(struct datapath *dp, struct sk_buff *skb,
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
@@ -1817,7 +1865,9 @@ static int ovs_dp_change(struct datapath *dp, struct nlattr *a[])
 			return -ENODEV;
 
 		cache_size = nla_get_u32(a[OVS_DP_ATTR_MASKS_CACHE_SIZE]);
+		mutex_lock(&table->lock);
 		err = ovs_flow_tbl_masks_cache_resize(table, cache_size);
+		mutex_unlock(&table->lock);
 		if (err)
 			return err;
 	}
@@ -1968,7 +2018,7 @@ static int ovs_dp_cmd_new(struct sk_buff *skb, struct genl_info *info)
 err_destroy_stats:
 	free_percpu(dp->stats_percpu);
 err_destroy_table:
-	call_rcu(&table->rcu, ovs_flow_tbl_destroy_rcu);
+	ovs_flow_tbl_put(table);
 err_destroy_dp:
 	kfree(dp);
 err_destroy_reply:
@@ -2003,16 +2053,11 @@ static void __dp_destroy(struct datapath *dp)
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
@@ -2656,9 +2701,12 @@ static void ovs_dp_masks_rebalance(struct work_struct *work)
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
 
diff --git a/net/openvswitch/flow_table.c b/net/openvswitch/flow_table.c
index 2ae168f31f50..3934873a44c3 100644
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
@@ -417,6 +427,10 @@ struct flow_table *ovs_flow_tbl_alloc(void)
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
@@ -449,6 +463,7 @@ struct flow_table *ovs_flow_tbl_alloc(void)
 free_mask_cache:
 	__mask_cache_destroy(mc);
 free_table:
+	mutex_destroy(&table->lock);
 	kfree(table);
 	return ERR_PTR(-ENOMEM);
 }
@@ -467,7 +482,7 @@ static void table_instance_flow_free(struct flow_table *table,
 				     struct sw_flow *flow)
 {
 	hlist_del_rcu(&flow->flow_table.node[ti->node_ver]);
-	table->count--;
+	WRITE_ONCE(table->count, table->count - 1);
 
 	if (ovs_identifier_is_ufid(&flow->id)) {
 		hlist_del_rcu(&flow->ufid_table.node[ufid_ti->node_ver]);
@@ -477,10 +492,10 @@ static void table_instance_flow_free(struct flow_table *table,
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
 
@@ -500,7 +515,7 @@ void table_instance_flow_flush(struct flow_table *table,
 
 	if (WARN_ON(table->count != 0 ||
 		    table->ufid_count != 0)) {
-		table->count = 0;
+		WRITE_ONCE(table->count, 0);
 		table->ufid_count = 0;
 	}
 }
@@ -513,7 +528,7 @@ static void table_instance_destroy(struct table_instance *ti,
 }
 
 /* No need for locking this function is called from RCU callback. */
-void ovs_flow_tbl_destroy_rcu(struct rcu_head *rcu)
+static void ovs_flow_tbl_destroy_rcu(struct rcu_head *rcu)
 {
 	struct flow_table *table = container_of(rcu, struct flow_table, rcu);
 
@@ -525,9 +540,22 @@ void ovs_flow_tbl_destroy_rcu(struct rcu_head *rcu)
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
@@ -1060,7 +1088,7 @@ static void flow_key_insert(struct flow_table *table, struct sw_flow *flow)
 	flow->flow_table.hash = flow_hash(&flow->key, &flow->mask->range);
 	ti = ovs_tbl_dereference(table->ti, table);
 	table_instance_insert(ti, flow);
-	table->count++;
+	WRITE_ONCE(table->count, table->count + 1);
 
 	/* Expand table, if necessary, to make room. */
 	if (table->count > ti->n_buckets)
diff --git a/net/openvswitch/flow_table.h b/net/openvswitch/flow_table.h
index 3e5e9845c28a..1b5242a97813 100644
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
@@ -72,11 +96,15 @@ struct flow_table {
 
 extern struct kmem_cache *flow_stats_cache;
 
+#ifdef CONFIG_LOCKDEP
+int lockdep_ovs_tbl_is_held(const struct flow_table *table);
+#else
 static inline int lockdep_ovs_tbl_is_held(const struct flow_table *table
 					  __always_unused)
 {
 	return 1;
 }
+#endif
 
 #define ASSERT_OVS_TBL(tbl)   WARN_ON(!lockdep_ovs_tbl_is_held(tbl))
 
@@ -95,7 +123,11 @@ struct sw_flow *ovs_flow_alloc(void);
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
 
@@ -125,8 +157,5 @@ void ovs_flow_mask_key(struct sw_flow_key *dst, const struct sw_flow_key *src,
 		       bool full, const struct sw_flow_mask *mask);
 
 void ovs_flow_masks_rebalance(struct flow_table *table);
-void table_instance_flow_flush(struct flow_table *table,
-			       struct table_instance *ti,
-			       struct table_instance *ufid_ti);
 
 #endif /* flow_table.h */
-- 
2.54.0


