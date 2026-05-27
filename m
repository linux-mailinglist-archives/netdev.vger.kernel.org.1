Return-Path: <netdev+bounces-292018-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BhhKGM+FmomjwcAu9opvQ
	(envelope-from <netdev+bounces-292018-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:44:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FEC5DE04C
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 16CE5300981B
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606822DC798;
	Wed, 27 May 2026 00:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="OmlI09XK"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9F5138490;
	Wed, 27 May 2026 00:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779842648; cv=none; b=MiQ1tkzUXnmNJUlHnAYq8B7Yp6ElSLq9BGW6SdsYeOi/053Pf4pxMxC7PwNkInjgPkW2JxwdKEAl2WXEF3sPE9s/9+U1BQTz7q4O4ZOJjNsuLjnKndc9v+qH+nF0JfayewUzWmGv1TfJuxWWMcPhW45vOyYDYr1x/ZeX42WRkzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779842648; c=relaxed/simple;
	bh=OPvk6kNcEqW9pE2w9TlV94v17TjNQ/zyncqpHm20ogg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cYS9N5kVP8JsOxYWakWjs4Uur6rLz1Drl17YQoAAH9+eKRwWpdE3bu0x5QCjwKWhHQvmtOsr91XMpFB/wlztUPCw5lEL9Geulm9fjDeKi8BDaNR1SIKHG8OquDD0Td3FoIih79PT/TTEyQyWdPWoYo3AOYQwmrbkSEODUFh9g4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=OmlI09XK; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 64R0h2tE030932
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 27 May 2026 01:43:08 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 64R0h2tE030932
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1779842614; bh=YRieJS/p07GCEeSJQbZsvPsVYeisfBSd+V3RqjVJImE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OmlI09XKg2TBEXair9f5vsglhj84q+wpSsQ+qj5fCvm9wiycbMT3NIwCJttUFlGVn
	 kY/eNfpK3UcuEKqt4NqyhB1BzVtNcAyl4ZhMCXH0WFa1YiZGGxzqNh5fM5XNy9u4Z1
	 fZUZy9k0jBlvyhfofKFDb25LIYh9kWh22Yo9bw8Y+OvwYiMLtsKc3s6wbJdeDZAayt
	 sNSMwOHdACSGLXJVMqcqdnbHQ4Gaq73jzU07dMjCjm6oT+h2lAw/69VC9eMU0Tw9S1
	 e4iFpWFmR+932hPX8LZj32VZMtgXztZFtlXKnz9pJq7dvO0Yt1zJJzLALKYk4MxPLe
	 6IziSIVREwuDQ==
From: Luke Howard <lukeh@padl.com>
To: netdev@vger.kernel.org
Cc: Luke Howard <lukeh@padl.com>, Kieran Tyrrell <kieran@sienda.com>,
        Max Hunter <max@huntershome.org>,
        Cedric Jehasse <cedric.jehasse@luminex.be>,
        Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Ido Schimmel <idosch@nvidia.com>, linux-kernel@vger.kernel.org,
        bridge@lists.linux.dev
Subject: [PATCH net-next 1/6] net: bridge: mdb: add MDB_FLAGS_STREAM_RESERVED flag
Date: Wed, 27 May 2026 10:42:47 +1000
Message-ID: <45e7cd01f9449c8ef15a5affd587fe7645ecddb7.1779841530.git.lukeh@padl.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1779841530.git.lukeh@padl.com>
References: <cover.1779841530.git.lukeh@padl.com>
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
	DMARC_POLICY_ALLOW(-0.50)[padl.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[padl.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-292018-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[padl.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,padl.com:email,padl.com:mid,padl.com:dkim]
X-Rspamd-Queue-Id: B2FEC5DE04C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a new MDB entry flag, MDB_FLAGS_STREAM_RESERVED, that userspace
can set on RTM_NEWMDB to mark a multicast destination as belonging
to a reserved stream (e.g. IEEE 802.1Q Stream Reservation Protocol /
IEEE 1722 / TSN). The bridge core does no admission control on the
basis of the flag; it is metadata propagated through switchdev to
hardware drivers that can themselves enforce admission of AVB / SR
priority traffic only to flagged destinations.

The flag is settable via the new nested attribute MDBE_ATTR_FLAGS
(NLA_U32 bitmask, validated against MDB_FLAGS_SETTABLE_MASK), and is
reflected in dump output via br_mdb_entry.flags as is done today for
the OFFLOAD/BLOCKED/STAR_EXCL flags.

Assisted-by: Claude:claude-4.7-opus
Signed-off-by: Luke Howard <lukeh@padl.com>
---
 include/net/switchdev.h        |  4 ++++
 include/uapi/linux/if_bridge.h |  2 ++
 net/bridge/br_mdb.c            | 12 ++++++++++++
 net/bridge/br_private.h        |  2 ++
 net/bridge/br_switchdev.c      | 17 +++++++++++------
 5 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index ee500706496b0..03d176708b768 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -111,10 +111,14 @@ struct switchdev_obj_port_vlan {
 	container_of((OBJ), struct switchdev_obj_port_vlan, obj)
 
 /* SWITCHDEV_OBJ_ID_PORT_MDB */
+
+#define SWITCHDEV_MDB_F_STREAM_RESERVED		BIT(0)
+
 struct switchdev_obj_port_mdb {
 	struct switchdev_obj obj;
 	unsigned char addr[ETH_ALEN];
 	u16 vid;
+	u32 flags;
 };
 
 #define SWITCHDEV_OBJ_PORT_MDB(OBJ) \
diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index 21a700c02ef76..51ec314994bec 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -705,6 +705,7 @@ struct br_mdb_entry {
 #define MDB_FLAGS_STAR_EXCL		(1 << 2)
 #define MDB_FLAGS_BLOCKED		(1 << 3)
 #define MDB_FLAGS_OFFLOAD_FAILED	(1 << 4)
+#define MDB_FLAGS_STREAM_RESERVED	(1 << 5)
 	__u8 flags;
 	__u16 vid;
 	struct {
@@ -760,6 +761,7 @@ enum {
 	MDBE_ATTR_IFINDEX,
 	MDBE_ATTR_SRC_VNI,
 	MDBE_ATTR_STATE_MASK,
+	MDBE_ATTR_FLAGS,
 	__MDBE_ATTR_MAX,
 };
 #define MDBE_ATTR_MAX (__MDBE_ATTR_MAX - 1)
diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index e0c7020b12f5f..1320ccd81b0a1 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -146,6 +146,8 @@ static void __mdb_entry_fill_flags(struct br_mdb_entry *e, unsigned char flags)
 		e->flags |= MDB_FLAGS_BLOCKED;
 	if (flags & MDB_PG_FLAGS_OFFLOAD_FAILED)
 		e->flags |= MDB_FLAGS_OFFLOAD_FAILED;
+	if (flags & MDB_PG_FLAGS_STREAM_RESERVED)
+		e->flags |= MDB_FLAGS_STREAM_RESERVED;
 }
 
 static void __mdb_entry_to_br_ip(struct br_mdb_entry *entry, struct br_ip *ip,
@@ -664,6 +666,7 @@ static const struct nla_policy br_mdbe_attrs_pol[MDBE_ATTR_MAX + 1] = {
 						  MCAST_INCLUDE),
 	[MDBE_ATTR_SRC_LIST] = NLA_POLICY_NESTED(br_mdbe_src_list_pol),
 	[MDBE_ATTR_RTPROT] = NLA_POLICY_MIN(NLA_U8, RTPROT_STATIC),
+	[MDBE_ATTR_FLAGS] = NLA_POLICY_MASK(NLA_U32, MDB_FLAGS_STREAM_RESERVED),
 };
 
 static bool is_valid_mdb_source(struct nlattr *attr, __be16 proto,
@@ -1072,6 +1075,8 @@ static int br_mdb_add_group(const struct br_mdb_config *cfg,
 	if (entry->state == MDB_PERMANENT)
 		flags |= MDB_PG_FLAGS_PERMANENT;
 
+	flags |= cfg->pg_flags;
+
 	if (br_multicast_is_star_g(&group))
 		return br_mdb_add_group_star_g(cfg, mp, brmctx, flags, extack);
 	else
@@ -1225,6 +1230,13 @@ static int br_mdb_config_attrs_init(struct nlattr *set_attrs,
 		cfg->rt_protocol = nla_get_u8(mdb_attrs[MDBE_ATTR_RTPROT]);
 	}
 
+	if (mdb_attrs[MDBE_ATTR_FLAGS]) {
+		u32 user_flags = nla_get_u32(mdb_attrs[MDBE_ATTR_FLAGS]);
+
+		if (user_flags & MDB_FLAGS_STREAM_RESERVED)
+			cfg->pg_flags |= MDB_PG_FLAGS_STREAM_RESERVED;
+	}
+
 	return 0;
 }
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 02671e648dac7..b9ee19448e38b 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -111,6 +111,7 @@ struct br_mdb_config {
 	struct br_mdb_src_entry		*src_entries;
 	int				num_src_entries;
 	u8				rt_protocol;
+	unsigned char			pg_flags;
 };
 #endif
 
@@ -317,6 +318,7 @@ struct net_bridge_fdb_flush_desc {
 #define MDB_PG_FLAGS_STAR_EXCL		BIT(3)
 #define MDB_PG_FLAGS_BLOCKED		BIT(4)
 #define MDB_PG_FLAGS_OFFLOAD_FAILED	BIT(5)
+#define MDB_PG_FLAGS_STREAM_RESERVED	BIT(6)
 
 #define PG_SRC_ENT_LIMIT	32
 
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 18b558a931ad9..bc05cda2f5350 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -548,7 +548,8 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
 }
 
 static void br_switchdev_mdb_populate(struct switchdev_obj_port_mdb *mdb,
-				      const struct net_bridge_mdb_entry *mp)
+				      const struct net_bridge_mdb_entry *mp,
+				      const struct net_bridge_port_group *pg)
 {
 	if (mp->addr.proto == htons(ETH_P_IP))
 		ip_eth_mc_map(mp->addr.dst.ip4, mdb->addr);
@@ -560,6 +561,9 @@ static void br_switchdev_mdb_populate(struct switchdev_obj_port_mdb *mdb,
 		ether_addr_copy(mdb->addr, mp->addr.dst.mac_addr);
 
 	mdb->vid = mp->addr.vid;
+	mdb->flags = 0;
+	if (pg && (pg->flags & MDB_PG_FLAGS_STREAM_RESERVED))
+		mdb->flags |= SWITCHDEV_MDB_F_STREAM_RESERVED;
 }
 
 static void br_switchdev_host_mdb_one(struct net_device *dev,
@@ -575,7 +579,7 @@ static void br_switchdev_host_mdb_one(struct net_device *dev,
 		},
 	};
 
-	br_switchdev_mdb_populate(&mdb, mp);
+	br_switchdev_mdb_populate(&mdb, mp, NULL);
 
 	switch (type) {
 	case RTM_NEWMDB:
@@ -622,6 +626,7 @@ static int br_switchdev_mdb_queue_one(struct list_head *mdb_list,
 				      unsigned long action,
 				      enum switchdev_obj_id id,
 				      const struct net_bridge_mdb_entry *mp,
+				      const struct net_bridge_port_group *pg,
 				      struct net_device *orig_dev)
 {
 	struct switchdev_obj_port_mdb mdb = {
@@ -632,7 +637,7 @@ static int br_switchdev_mdb_queue_one(struct list_head *mdb_list,
 	};
 	struct switchdev_obj_port_mdb *pmdb;
 
-	br_switchdev_mdb_populate(&mdb, mp);
+	br_switchdev_mdb_populate(&mdb, mp, pg);
 
 	if (action == SWITCHDEV_PORT_OBJ_ADD &&
 	    switchdev_port_obj_act_is_deferred(dev, action, &mdb.obj)) {
@@ -671,7 +676,7 @@ void br_switchdev_mdb_notify(struct net_device *dev,
 	if (!pg)
 		return br_switchdev_host_mdb(dev, mp, type);
 
-	br_switchdev_mdb_populate(&mdb, mp);
+	br_switchdev_mdb_populate(&mdb, mp, pg);
 
 	mdb.obj.orig_dev = pg->key.port->dev;
 	switch (type) {
@@ -740,7 +745,7 @@ br_switchdev_mdb_replay(struct net_device *br_dev, struct net_device *dev,
 		if (mp->host_joined) {
 			err = br_switchdev_mdb_queue_one(&mdb_list, dev, action,
 							 SWITCHDEV_OBJ_ID_HOST_MDB,
-							 mp, br_dev);
+							 mp, NULL, br_dev);
 			if (err) {
 				spin_unlock_bh(&br->multicast_lock);
 				goto out_free_mdb;
@@ -754,7 +759,7 @@ br_switchdev_mdb_replay(struct net_device *br_dev, struct net_device *dev,
 
 			err = br_switchdev_mdb_queue_one(&mdb_list, dev, action,
 							 SWITCHDEV_OBJ_ID_PORT_MDB,
-							 mp, dev);
+							 mp, p, dev);
 			if (err) {
 				spin_unlock_bh(&br->multicast_lock);
 				goto out_free_mdb;
-- 
2.43.0


