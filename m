Return-Path: <netdev+bounces-293938-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8C/bIognHmpZhgkAu9opvQ
	(envelope-from <netdev+bounces-293938-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 02:44:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3D8626AD3
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 02:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 99012300EEA1
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 00:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A7F3161BF;
	Tue,  2 Jun 2026 00:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="djUzM+qe"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B43227280A;
	Tue,  2 Jun 2026 00:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780361089; cv=none; b=HphAhyf7jPWrn6NUzYL6XOEVvFUN+sGIBz+N1qan15AqQZxhqCnudmtKSZwJXF2hQcId1yIHXPdJ6Yp41DhjO7HobEtC8TFHYO4QWdC6GFkbDBwkCy9z+ObXQJwIaiuAkQez3sZAZt3N8LR6VsTninxYXBjPR7AdiZfROldT9kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780361089; c=relaxed/simple;
	bh=xi0FIQ5jAy3sWwwekDGmVRBvo1d0KMgmluhLQNouxfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tLO7WaSJ3DVGDKuZjoJdwSOxD3Ys9l0ADJnc8HOlE5b7VOvzVNPmDpOrJW8qmErxaZfoohONMXNqIgkKTAa3bgIxH5fTsujCuhMXBbQfpZ1qjInsMln9sG1T2BosQikG7xEzl0eF9F7u5hupfEgTNJriduFIVpxKxYPwSjyfw2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=djUzM+qe; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 6520hx8r030351
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 2 Jun 2026 01:44:07 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 6520hx8r030351
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780361053; bh=VBt+YFq+LPhzcOHuz+8CXKj8MNiV7hS3KnijFkOeMBk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=djUzM+qetryoeIXZ3jzFqwOlhEIORMgi8zeip9UM7TytP4u1Km1PiE9axEHCnx//2
	 2Yy8MazhyMxkR89Ezof3QvzGD16erwxseGTUvOHX+QFsAgeG5Umg1g0ta4F55kG87z
	 Ckq6WRVvcullhdLHqK330v7jhwOQ35IyxVNyArkJgn0tiwOXtPmGN4S50QoNGhEoZk
	 YXgig52zghi35ZB9aZ+iCk4yaLku2792sSHqphMj15YMYjwRs0I1UbnIO6YT9VVa2X
	 JKmg8WSG3bSKiolVr1hVJLqGzcrzHtOrgo9sHC6faPGtm8PG4wYoHRiduM0BACoXpv
	 L38HzcSOAzy9w==
From: Luke Howard <lukeh@padl.com>
Date: Tue, 02 Jun 2026 10:43:46 +1000
Subject: [PATCH net-next v2 1/6] net: bridge: mdb: add
 MDB_FLAGS_STREAM_RESERVED flag
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-mv88e6xxx-8021qat-mqprio-v2-1-72be14522e7c@padl.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293938-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,padl.com:email,padl.com:mid,padl.com:dkim]
X-Rspamd-Queue-Id: 2D3D8626AD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a new MDB entry flag, MDB_FLAGS_STREAM_RESERVED, that user space
can set on RTM_NEWMDB to mark a multicast destination as belonging
to a reserved stream (typically, one managed by the IEEE 802.1Q Stream
Reservation Protocol).

The flag is settable via the new nested attribute MDBE_ATTR_FLAGS, an
NLA_U32 bitmask whose accepted bits are presently restricted to
MDB_FLAGS_STREAM_RESERVED by NLA_POLICY_MASK(). As with the other
per-port group attributes, it is rejected for host groups.

The flag is stored on the port group and propagated through switchdev
so it is visible to drivers.

MDB entries with this flag would typically be managed by a user space SRP
service, which would also be responsible for configuring a traffic shaper
on the egress port.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Luke Howard <lukeh@padl.com>
---
 include/net/switchdev.h        |  4 +++
 include/uapi/linux/if_bridge.h |  6 ++++
 net/bridge/br_mdb.c            | 74 ++++++++++++++++++++++++------------------
 net/bridge/br_private.h        |  2 ++
 net/bridge/br_switchdev.c      | 17 ++++++----
 5 files changed, 65 insertions(+), 38 deletions(-)

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
index 21a700c02ef76..01955a575528c 100644
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
@@ -746,6 +747,10 @@ enum {
 /* [MDBA_SET_ENTRY_ATTRS] = {
  *    [MDBE_ATTR_xxx]
  *    ...
+ *    [MDBE_ATTR_FLAGS]
+ *       u32, a mask of MDB_FLAGS_* values to set on the entry. Valid only
+ *       for port-group entries; currently only MDB_FLAGS_STREAM_RESERVED
+ *       may be set from user space.
  * }
  */
 enum {
@@ -760,6 +765,7 @@ enum {
 	MDBE_ATTR_IFINDEX,
 	MDBE_ATTR_SRC_VNI,
 	MDBE_ATTR_STATE_MASK,
+	MDBE_ATTR_FLAGS,
 	__MDBE_ATTR_MAX,
 };
 #define MDBE_ATTR_MAX (__MDBE_ATTR_MAX - 1)
diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index e0c7020b12f5f..3ddfbd536edb4 100644
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
@@ -739,14 +742,13 @@ __br_mdb_choose_context(struct net_bridge *br,
 static int br_mdb_replace_group_sg(const struct br_mdb_config *cfg,
 				   struct net_bridge_mdb_entry *mp,
 				   struct net_bridge_port_group *pg,
-				   struct net_bridge_mcast *brmctx,
-				   unsigned char flags)
+				   struct net_bridge_mcast *brmctx)
 {
 	unsigned long now = jiffies;
 
-	pg->flags = flags;
+	pg->flags = cfg->pg_flags;
 	pg->rt_protocol = cfg->rt_protocol;
-	if (!(flags & MDB_PG_FLAGS_PERMANENT) && !cfg->src_entry)
+	if (!(cfg->pg_flags & MDB_PG_FLAGS_PERMANENT) && !cfg->src_entry)
 		mod_timer(&pg->timer,
 			  now + brmctx->multicast_membership_interval);
 	else
@@ -760,7 +762,6 @@ static int br_mdb_replace_group_sg(const struct br_mdb_config *cfg,
 static int br_mdb_add_group_sg(const struct br_mdb_config *cfg,
 			       struct net_bridge_mdb_entry *mp,
 			       struct net_bridge_mcast *brmctx,
-			       unsigned char flags,
 			       struct netlink_ext_ack *extack)
 {
 	struct net_bridge_port_group __rcu **pp;
@@ -775,20 +776,19 @@ static int br_mdb_add_group_sg(const struct br_mdb_config *cfg,
 				NL_SET_ERR_MSG_MOD(extack, "(S, G) group is already joined by port");
 				return -EEXIST;
 			}
-			return br_mdb_replace_group_sg(cfg, mp, p, brmctx,
-						       flags);
+			return br_mdb_replace_group_sg(cfg, mp, p, brmctx);
 		}
 		if ((unsigned long)p->key.port < (unsigned long)cfg->p)
 			break;
 	}
 
-	p = br_multicast_new_port_group(cfg->p, &cfg->group, *pp, flags, NULL,
-					MCAST_INCLUDE, cfg->rt_protocol, extack);
+	p = br_multicast_new_port_group(cfg->p, &cfg->group, *pp, cfg->pg_flags,
+					NULL, MCAST_INCLUDE, cfg->rt_protocol, extack);
 	if (unlikely(!p))
 		return -ENOMEM;
 
 	rcu_assign_pointer(*pp, p);
-	if (!(flags & MDB_PG_FLAGS_PERMANENT) && !cfg->src_entry)
+	if (!(cfg->pg_flags & MDB_PG_FLAGS_PERMANENT) && !cfg->src_entry)
 		mod_timer(&p->timer,
 			  now + brmctx->multicast_membership_interval);
 	br_mdb_notify(cfg->br->dev, mp, p, RTM_NEWMDB);
@@ -818,7 +818,6 @@ static int br_mdb_add_group_src_fwd(const struct br_mdb_config *cfg,
 	struct net_bridge_mdb_entry *sgmp;
 	struct br_mdb_config sg_cfg;
 	struct br_ip sg_ip;
-	u8 flags = 0;
 
 	sg_ip = cfg->group;
 	sg_ip.src = src_ip->src;
@@ -828,12 +827,8 @@ static int br_mdb_add_group_src_fwd(const struct br_mdb_config *cfg,
 		return PTR_ERR(sgmp);
 	}
 
-	if (cfg->entry->state == MDB_PERMANENT)
-		flags |= MDB_PG_FLAGS_PERMANENT;
-	if (cfg->filter_mode == MCAST_EXCLUDE)
-		flags |= MDB_PG_FLAGS_BLOCKED;
-
 	memset(&sg_cfg, 0, sizeof(sg_cfg));
+
 	sg_cfg.br = cfg->br;
 	sg_cfg.p = cfg->p;
 	sg_cfg.entry = cfg->entry;
@@ -842,7 +837,11 @@ static int br_mdb_add_group_src_fwd(const struct br_mdb_config *cfg,
 	sg_cfg.filter_mode = MCAST_INCLUDE;
 	sg_cfg.rt_protocol = cfg->rt_protocol;
 	sg_cfg.nlflags = cfg->nlflags;
-	return br_mdb_add_group_sg(&sg_cfg, sgmp, brmctx, flags, extack);
+	sg_cfg.pg_flags = cfg->pg_flags;
+	if (cfg->filter_mode == MCAST_EXCLUDE)
+		sg_cfg.pg_flags |= MDB_PG_FLAGS_BLOCKED;
+
+	return br_mdb_add_group_sg(&sg_cfg, sgmp, brmctx, extack);
 }
 
 static int br_mdb_add_group_src(const struct br_mdb_config *cfg,
@@ -953,7 +952,6 @@ static int br_mdb_replace_group_star_g(const struct br_mdb_config *cfg,
 				       struct net_bridge_mdb_entry *mp,
 				       struct net_bridge_port_group *pg,
 				       struct net_bridge_mcast *brmctx,
-				       unsigned char flags,
 				       struct netlink_ext_ack *extack)
 {
 	unsigned long now = jiffies;
@@ -963,10 +961,10 @@ static int br_mdb_replace_group_star_g(const struct br_mdb_config *cfg,
 	if (err)
 		return err;
 
-	pg->flags = flags;
+	pg->flags = cfg->pg_flags;
 	pg->filter_mode = cfg->filter_mode;
 	pg->rt_protocol = cfg->rt_protocol;
-	if (!(flags & MDB_PG_FLAGS_PERMANENT) &&
+	if (!(cfg->pg_flags & MDB_PG_FLAGS_PERMANENT) &&
 	    cfg->filter_mode == MCAST_EXCLUDE)
 		mod_timer(&pg->timer,
 			  now + brmctx->multicast_membership_interval);
@@ -984,7 +982,6 @@ static int br_mdb_replace_group_star_g(const struct br_mdb_config *cfg,
 static int br_mdb_add_group_star_g(const struct br_mdb_config *cfg,
 				   struct net_bridge_mdb_entry *mp,
 				   struct net_bridge_mcast *brmctx,
-				   unsigned char flags,
 				   struct netlink_ext_ack *extack)
 {
 	struct net_bridge_port_group __rcu **pp;
@@ -1000,15 +997,14 @@ static int br_mdb_add_group_star_g(const struct br_mdb_config *cfg,
 				NL_SET_ERR_MSG_MOD(extack, "(*, G) group is already joined by port");
 				return -EEXIST;
 			}
-			return br_mdb_replace_group_star_g(cfg, mp, p, brmctx,
-							   flags, extack);
+			return br_mdb_replace_group_star_g(cfg, mp, p, brmctx, extack);
 		}
 		if ((unsigned long)p->key.port < (unsigned long)cfg->p)
 			break;
 	}
 
-	p = br_multicast_new_port_group(cfg->p, &cfg->group, *pp, flags, NULL,
-					cfg->filter_mode, cfg->rt_protocol,
+	p = br_multicast_new_port_group(cfg->p, &cfg->group, *pp, cfg->pg_flags,
+					NULL, cfg->filter_mode, cfg->rt_protocol,
 					extack);
 	if (unlikely(!p))
 		return -ENOMEM;
@@ -1018,7 +1014,7 @@ static int br_mdb_add_group_star_g(const struct br_mdb_config *cfg,
 		goto err_del_port_group;
 
 	rcu_assign_pointer(*pp, p);
-	if (!(flags & MDB_PG_FLAGS_PERMANENT) &&
+	if (!(cfg->pg_flags & MDB_PG_FLAGS_PERMANENT) &&
 	    cfg->filter_mode == MCAST_EXCLUDE)
 		mod_timer(&p->timer,
 			  now + brmctx->multicast_membership_interval);
@@ -1046,7 +1042,6 @@ static int br_mdb_add_group(const struct br_mdb_config *cfg,
 	struct net_bridge *br = cfg->br;
 	struct net_bridge_mcast *brmctx;
 	struct br_ip group = cfg->group;
-	unsigned char flags = 0;
 
 	brmctx = __br_mdb_choose_context(br, entry, extack);
 	if (!brmctx)
@@ -1069,13 +1064,10 @@ static int br_mdb_add_group(const struct br_mdb_config *cfg,
 		return 0;
 	}
 
-	if (entry->state == MDB_PERMANENT)
-		flags |= MDB_PG_FLAGS_PERMANENT;
-
 	if (br_multicast_is_star_g(&group))
-		return br_mdb_add_group_star_g(cfg, mp, brmctx, flags, extack);
+		return br_mdb_add_group_star_g(cfg, mp, brmctx, extack);
 	else
-		return br_mdb_add_group_sg(cfg, mp, brmctx, flags, extack);
+		return br_mdb_add_group_sg(cfg, mp, brmctx, extack);
 }
 
 static int __br_mdb_add(const struct br_mdb_config *cfg,
@@ -1225,6 +1217,15 @@ static int br_mdb_config_attrs_init(struct nlattr *set_attrs,
 		cfg->rt_protocol = nla_get_u8(mdb_attrs[MDBE_ATTR_RTPROT]);
 	}
 
+	if (mdb_attrs[MDBE_ATTR_FLAGS]) {
+		if (!cfg->p) {
+			NL_SET_ERR_MSG_MOD(extack, "Flags cannot be set for host groups");
+			return -EINVAL;
+		}
+		if (nla_get_u32(mdb_attrs[MDBE_ATTR_FLAGS]) & MDB_FLAGS_STREAM_RESERVED)
+			cfg->pg_flags |= MDB_PG_FLAGS_STREAM_RESERVED;
+	}
+
 	return 0;
 }
 
@@ -1280,6 +1281,9 @@ static int br_mdb_config_init(struct br_mdb_config *cfg, struct net_device *dev,
 		return -EINVAL;
 	}
 
+	if (cfg->entry->state == MDB_PERMANENT)
+		cfg->pg_flags |= MDB_PG_FLAGS_PERMANENT;
+
 	if (tb[MDBA_SET_ENTRY_ATTRS])
 		return br_mdb_config_attrs_init(tb[MDBA_SET_ENTRY_ATTRS], cfg,
 						extack);
@@ -1307,6 +1311,12 @@ int br_mdb_add(struct net_device *dev, struct nlattr *tb[], u16 nlmsg_flags,
 		return err;
 
 	err = -EINVAL;
+	if ((cfg.pg_flags & MDB_PG_FLAGS_STREAM_RESERVED) &&
+	    cfg.entry->state != MDB_PERMANENT) {
+		NL_SET_ERR_MSG_MOD(extack, "stream_reserved entries must be permanent");
+		goto out;
+	}
+
 	/* host join errors which can happen before creating the group */
 	if (!cfg.p && !br_group_is_l2(&cfg.group)) {
 		/* don't allow any flags for host-joined IP groups */
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 02671e648dac7..6a2dabd6f4bfb 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -111,6 +111,7 @@ struct br_mdb_config {
 	struct br_mdb_src_entry		*src_entries;
 	int				num_src_entries;
 	u8				rt_protocol;
+	u8				pg_flags;
 };
 #endif
 
@@ -317,6 +318,7 @@ struct net_bridge_fdb_flush_desc {
 #define MDB_PG_FLAGS_STAR_EXCL		BIT(3)
 #define MDB_PG_FLAGS_BLOCKED		BIT(4)
 #define MDB_PG_FLAGS_OFFLOAD_FAILED	BIT(5)
+#define MDB_PG_FLAGS_STREAM_RESERVED	BIT(6)
 
 #define PG_SRC_ENT_LIMIT	32
 
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index ee3ad9dfbab99..c46d8e49ce990 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -547,7 +547,8 @@ static void br_switchdev_mdb_complete(struct net_device *dev, int err, void *pri
 }
 
 static void br_switchdev_mdb_populate(struct switchdev_obj_port_mdb *mdb,
-				      const struct net_bridge_mdb_entry *mp)
+				      const struct net_bridge_mdb_entry *mp,
+				      const struct net_bridge_port_group *pg)
 {
 	if (mp->addr.proto == htons(ETH_P_IP))
 		ip_eth_mc_map(mp->addr.dst.ip4, mdb->addr);
@@ -559,6 +560,9 @@ static void br_switchdev_mdb_populate(struct switchdev_obj_port_mdb *mdb,
 		ether_addr_copy(mdb->addr, mp->addr.dst.mac_addr);
 
 	mdb->vid = mp->addr.vid;
+	mdb->flags = 0;
+	if (pg && (pg->flags & MDB_PG_FLAGS_STREAM_RESERVED))
+		mdb->flags |= SWITCHDEV_MDB_F_STREAM_RESERVED;
 }
 
 static void br_switchdev_host_mdb_one(struct net_device *dev,
@@ -574,7 +578,7 @@ static void br_switchdev_host_mdb_one(struct net_device *dev,
 		},
 	};
 
-	br_switchdev_mdb_populate(&mdb, mp);
+	br_switchdev_mdb_populate(&mdb, mp, NULL);
 
 	switch (type) {
 	case RTM_NEWMDB:
@@ -621,6 +625,7 @@ static int br_switchdev_mdb_queue_one(struct list_head *mdb_list,
 				      unsigned long action,
 				      enum switchdev_obj_id id,
 				      const struct net_bridge_mdb_entry *mp,
+				      const struct net_bridge_port_group *pg,
 				      struct net_device *orig_dev)
 {
 	struct switchdev_obj_port_mdb mdb = {
@@ -631,7 +636,7 @@ static int br_switchdev_mdb_queue_one(struct list_head *mdb_list,
 	};
 	struct switchdev_obj_port_mdb *pmdb;
 
-	br_switchdev_mdb_populate(&mdb, mp);
+	br_switchdev_mdb_populate(&mdb, mp, pg);
 
 	if (action == SWITCHDEV_PORT_OBJ_ADD &&
 	    switchdev_port_obj_act_is_deferred(dev, action, &mdb.obj)) {
@@ -670,7 +675,7 @@ void br_switchdev_mdb_notify(struct net_device *dev,
 	if (!pg)
 		return br_switchdev_host_mdb(dev, mp, type);
 
-	br_switchdev_mdb_populate(&mdb, mp);
+	br_switchdev_mdb_populate(&mdb, mp, pg);
 
 	mdb.obj.orig_dev = pg->key.port->dev;
 	switch (type) {
@@ -739,7 +744,7 @@ br_switchdev_mdb_replay(struct net_device *br_dev, struct net_device *dev,
 		if (mp->host_joined) {
 			err = br_switchdev_mdb_queue_one(&mdb_list, dev, action,
 							 SWITCHDEV_OBJ_ID_HOST_MDB,
-							 mp, br_dev);
+							 mp, NULL, br_dev);
 			if (err) {
 				spin_unlock_bh(&br->multicast_lock);
 				goto out_free_mdb;
@@ -753,7 +758,7 @@ br_switchdev_mdb_replay(struct net_device *br_dev, struct net_device *dev,
 
 			err = br_switchdev_mdb_queue_one(&mdb_list, dev, action,
 							 SWITCHDEV_OBJ_ID_PORT_MDB,
-							 mp, dev);
+							 mp, p, dev);
 			if (err) {
 				spin_unlock_bh(&br->multicast_lock);
 				goto out_free_mdb;

-- 
2.43.0


