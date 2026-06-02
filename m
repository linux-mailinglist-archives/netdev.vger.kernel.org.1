Return-Path: <netdev+bounces-293937-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDTHN3EoHmpZhgkAu9opvQ
	(envelope-from <netdev+bounces-293937-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 02:48:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF29626B76
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 02:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29104309A7A6
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 00:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA0A311969;
	Tue,  2 Jun 2026 00:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="QaWyrNw4"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30502571DA;
	Tue,  2 Jun 2026 00:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780361088; cv=none; b=dgfB0D7HLcd2yc2PsLxZ7qyHLh+gjWhMnUspLU+CtpaPydAOCAaCv2tz2rBTJYldG3x3tO63lqmJVNcuSVH4WHE7tfA3hHINLpgpSzwcizzHhQP3+BDJwD6PXW9HBmigUXzTf+jzzC+bUNVadd3d/lfKkUC5OM+6cf/nfRHXNU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780361088; c=relaxed/simple;
	bh=uISa3Gs5+4UQ8Ihkemap9TC45mLAdfd44jCHHwyJ0pI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e3O3jShf9Bc60kTxQYMc2XHqT08UsseMSEp7BzbE6o9V7c9QDgn/cPpqu1dnCT7/7SuVVK10vUWuLUtGyva5cdtEOZmJpGUg+vzs18Vh/8zWJHZc9m2gV1QJecHdyyiCndzqE8NOuZz8ZyPkbq2cwvJ1nv/R9PJpuaiiwnDUWTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=QaWyrNw4; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 6520hx8s030351
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 2 Jun 2026 01:44:13 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 6520hx8s030351
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780361059; bh=WWSmBk6Kcp7gVwj8jchlZty7kXuRKwNCmKn14/NT6qU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QaWyrNw4Xj1cm8DZj35MXS6XPhcA5jeIS2hn87+WPKz277kSGgLFj2WNCohqq/ln8
	 tqdFQfzmokLg5IGhNkHZ9ob9xNKEHzrUVio0d0cH4B7ShkC4O7Yg8GWUP+pJW9+YCa
	 ozAEIPpXMnRDNHZuKbtWTX5f3YnT+o1VUAJEiHf6f8ngFkz0xuVKpEmdrxAh3LuekU
	 jy83FBiKTMeAvefpWFZQEUhe0dcRH6qKwKgX57IET2uSfZVh+pImwj9pFuYS0J0vW7
	 umLQjqhPzRNs3u/UkIDzJlpmBXj/4CBOAQ3d4ZpKXLLOhlUyp1gr9hai7CP2S6zZmq
	 nDEES5VWaDeQQ==
From: Luke Howard <lukeh@padl.com>
Date: Tue, 02 Jun 2026 10:43:47 +1000
Subject: [PATCH net-next v2 2/6] net: bridge: convert mdb_entry host_joined
 to a flags field
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-mv88e6xxx-8021qat-mqprio-v2-2-72be14522e7c@padl.com>
References: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
In-Reply-To: <20260602-mv88e6xxx-8021qat-mqprio-v2-0-72be14522e7c@padl.com>
To: Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bridge@lists.linux.dev, linux-kselftest@vger.kernel.org,
        Max Hunter <max@huntershome.org>, Kieran Tyrrell <kieran@sienda.com>,
        Luke Howard <lukeh@padl.com>
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293937-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[resnulli.us,redhat.com,davemloft.net,google.com,kernel.org,blackwall.org,nvidia.com,lunn.ch,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[padl.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,padl.com:email,padl.com:mid,padl.com:dkim]
X-Rspamd-Queue-Id: 8EF29626B76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace the bool host_joined in struct net_bridge_mdb_entry with a u8
flags field and a BRIDGE_MDBE_F_HOST_JOINED bit.

Signed-off-by: Luke Howard <lukeh@padl.com>
---
 net/bridge/br_input.c     |  2 +-
 net/bridge/br_mdb.c       | 14 ++++++++------
 net/bridge/br_multicast.c | 26 ++++++++++++++------------
 net/bridge/br_private.h   |  4 +++-
 net/bridge/br_switchdev.c |  2 +-
 5 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 470615675bdc0..5787066b1f4cb 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -188,7 +188,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 		mdst = br_mdb_entry_skb_get(brmctx, skb, vid);
 		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
 		    br_multicast_querier_exists(brmctx, eth_hdr(skb), mdst)) {
-			if ((mdst && mdst->host_joined) ||
+			if ((mdst && (mdst->flags & BRIDGE_MDBE_F_HOST_JOINED)) ||
 			    br_multicast_is_router(brmctx, skb) ||
 			    br->dev->flags & IFF_ALLMULTI) {
 				local_rcv = true;
diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index 3ddfbd536edb4..b95ca72ec6347 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -344,7 +344,7 @@ static int br_mdb_fill_info(struct sk_buff *skb, struct netlink_callback *cb,
 			break;
 		}
 
-		if (!s_pidx && mp->host_joined) {
+		if (!s_pidx && (mp->flags & BRIDGE_MDBE_F_HOST_JOINED)) {
 			err = __mdb_fill_info(skb, mp, NULL);
 			if (err) {
 				nla_nest_cancel(skb, nest2);
@@ -1053,7 +1053,8 @@ static int br_mdb_add_group(const struct br_mdb_config *cfg,
 
 	/* host join */
 	if (!port) {
-		if (mp->host_joined && !(cfg->nlflags & NLM_F_REPLACE)) {
+		if ((mp->flags & BRIDGE_MDBE_F_HOST_JOINED) &&
+		    !(cfg->nlflags & NLM_F_REPLACE)) {
 			NL_SET_ERR_MSG_MOD(extack, "Group is already joined by host");
 			return -EEXIST;
 		}
@@ -1381,7 +1382,8 @@ static int __br_mdb_del(const struct br_mdb_config *cfg)
 		goto unlock;
 
 	/* host leave */
-	if (entry->ifindex == mp->br->dev->ifindex && mp->host_joined) {
+	if (entry->ifindex == mp->br->dev->ifindex &&
+	    (mp->flags & BRIDGE_MDBE_F_HOST_JOINED)) {
 		br_multicast_host_leave(mp, false);
 		err = 0;
 		br_mdb_notify(br->dev, mp, NULL, RTM_DELMDB);
@@ -1619,7 +1621,7 @@ br_mdb_get_reply_alloc(const struct net_bridge_mdb_entry *mp)
 		     /* MDBA_MDB_ENTRY */
 		     nla_total_size(0);
 
-	if (mp->host_joined)
+	if (mp->flags & BRIDGE_MDBE_F_HOST_JOINED)
 		nlmsg_size += rtnl_mdb_nlmsg_pg_size(NULL);
 
 	for (pg = mlock_dereference(mp->ports, mp->br); pg;
@@ -1658,7 +1660,7 @@ static int br_mdb_get_reply_fill(struct sk_buff *skb,
 		goto cancel;
 	}
 
-	if (mp->host_joined) {
+	if (mp->flags & BRIDGE_MDBE_F_HOST_JOINED) {
 		err = __mdb_fill_info(skb, mp, NULL);
 		if (err)
 			goto cancel;
@@ -1702,7 +1704,7 @@ int br_mdb_get(struct net_device *dev, struct nlattr *tb[], u32 portid, u32 seq,
 	spin_lock_bh(&br->multicast_lock);
 
 	mp = br_mdb_ip_get(br, &group);
-	if (!mp || (!mp->ports && !mp->host_joined)) {
+	if (!mp || (!mp->ports && !(mp->flags & BRIDGE_MDBE_F_HOST_JOINED))) {
 		NL_SET_ERR_MSG_MOD(extack, "MDB entry not found");
 		err = -ENOENT;
 		goto unlock;
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 5d6fdfb43c046..4107bf7bd271f 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -391,13 +391,13 @@ static void br_multicast_sg_host_state(struct net_bridge_mdb_entry *star_mp,
 
 	if (WARN_ON(!br_multicast_is_star_g(&star_mp->addr)))
 		return;
-	if (!star_mp->host_joined)
+	if (!(star_mp->flags & BRIDGE_MDBE_F_HOST_JOINED))
 		return;
 
 	sg_mp = br_mdb_ip_get(star_mp->br, &sg->key.addr);
 	if (!sg_mp)
 		return;
-	sg_mp->host_joined = true;
+	sg_mp->flags |= BRIDGE_MDBE_F_HOST_JOINED;
 }
 
 /* set the host_joined state of all of *,G's S,G entries */
@@ -425,7 +425,8 @@ static void br_multicast_star_g_host_state(struct net_bridge_mdb_entry *star_mp)
 			sg_mp = br_mdb_ip_get(br, &sg_ip);
 			if (!sg_mp)
 				continue;
-			sg_mp->host_joined = star_mp->host_joined;
+			sg_mp->flags &= ~BRIDGE_MDBE_F_HOST_JOINED;
+			sg_mp->flags |= star_mp->flags & BRIDGE_MDBE_F_HOST_JOINED;
 		}
 	}
 }
@@ -453,7 +454,7 @@ static void br_multicast_sg_del_exclude_ports(struct net_bridge_mdb_entry *sgmp)
 	 * we treat it as EXCLUDE {}, so for an S,G it's considered a
 	 * STAR_EXCLUDE entry and we can safely leave it
 	 */
-	sgmp->host_joined = false;
+	sgmp->flags &= ~BRIDGE_MDBE_F_HOST_JOINED;
 
 	for (pp = &sgmp->ports;
 	     (p = mlock_dereference(*pp, sgmp->br)) != NULL;) {
@@ -824,7 +825,8 @@ void br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
 	hlist_add_head(&pg->mcast_gc.gc_node, &br->mcast_gc_list);
 	queue_work(system_long_wq, &br->mcast_gc_work);
 
-	if (!mp->ports && !mp->host_joined && netif_running(br->dev))
+	if (!mp->ports && !(mp->flags & BRIDGE_MDBE_F_HOST_JOINED) &&
+	    netif_running(br->dev))
 		mod_timer(&mp->timer, jiffies);
 }
 
@@ -1470,8 +1472,8 @@ void br_multicast_del_port_group(struct net_bridge_port_group *p)
 void br_multicast_host_join(const struct net_bridge_mcast *brmctx,
 			    struct net_bridge_mdb_entry *mp, bool notify)
 {
-	if (!mp->host_joined) {
-		mp->host_joined = true;
+	if (!(mp->flags & BRIDGE_MDBE_F_HOST_JOINED)) {
+		mp->flags |= BRIDGE_MDBE_F_HOST_JOINED;
 		if (br_multicast_is_star_g(&mp->addr))
 			br_multicast_star_g_host_state(mp);
 		if (notify)
@@ -1486,10 +1488,10 @@ void br_multicast_host_join(const struct net_bridge_mcast *brmctx,
 
 void br_multicast_host_leave(struct net_bridge_mdb_entry *mp, bool notify)
 {
-	if (!mp->host_joined)
+	if (!(mp->flags & BRIDGE_MDBE_F_HOST_JOINED))
 		return;
 
-	mp->host_joined = false;
+	mp->flags &= ~BRIDGE_MDBE_F_HOST_JOINED;
 	if (br_multicast_is_star_g(&mp->addr))
 		br_multicast_star_g_host_state(mp);
 	if (notify)
@@ -3537,7 +3539,7 @@ static void br_ip4_multicast_query(struct net_bridge_mcast *brmctx,
 
 	max_delay *= brmctx->multicast_last_member_count;
 
-	if (mp->host_joined &&
+	if ((mp->flags & BRIDGE_MDBE_F_HOST_JOINED) &&
 	    (timer_pending(&mp->timer) ?
 	     time_after(mp->timer.expires, now + max_delay) :
 	     timer_delete_sync_try(&mp->timer) >= 0))
@@ -3626,7 +3628,7 @@ static int br_ip6_multicast_query(struct net_bridge_mcast *brmctx,
 		goto out;
 
 	max_delay *= brmctx->multicast_last_member_count;
-	if (mp->host_joined &&
+	if ((mp->flags & BRIDGE_MDBE_F_HOST_JOINED) &&
 	    (timer_pending(&mp->timer) ?
 	     time_after(mp->timer.expires, now + max_delay) :
 	     timer_delete_sync_try(&mp->timer) >= 0))
@@ -3722,7 +3724,7 @@ br_multicast_leave_group(struct net_bridge_mcast *brmctx,
 		     brmctx->multicast_last_member_interval;
 
 	if (!pmctx) {
-		if (mp->host_joined &&
+		if ((mp->flags & BRIDGE_MDBE_F_HOST_JOINED) &&
 		    (timer_pending(&mp->timer) ?
 		     time_after(mp->timer.expires, time) :
 		     timer_delete_sync_try(&mp->timer) >= 0)) {
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 6a2dabd6f4bfb..1e0eefaf50dd1 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -373,12 +373,14 @@ struct net_bridge_port_group {
 	struct rcu_head			rcu;
 };
 
+#define BRIDGE_MDBE_F_HOST_JOINED	BIT(0)
+
 struct net_bridge_mdb_entry {
 	struct rhash_head		rhnode;
 	struct net_bridge		*br;
 	struct net_bridge_port_group __rcu *ports;
 	struct br_ip			addr;
-	bool				host_joined;
+	u8				flags;
 
 	struct timer_list		timer;
 	struct hlist_node		mdb_node;
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index c46d8e49ce990..39535f1a6b8ce 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -741,7 +741,7 @@ br_switchdev_mdb_replay(struct net_device *br_dev, struct net_device *dev,
 		struct net_bridge_port_group __rcu * const *pp;
 		const struct net_bridge_port_group *p;
 
-		if (mp->host_joined) {
+		if (mp->flags & BRIDGE_MDBE_F_HOST_JOINED) {
 			err = br_switchdev_mdb_queue_one(&mdb_list, dev, action,
 							 SWITCHDEV_OBJ_ID_HOST_MDB,
 							 mp, NULL, br_dev);

-- 
2.43.0


