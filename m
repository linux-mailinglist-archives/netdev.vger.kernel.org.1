Return-Path: <netdev+bounces-293939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDKSIMIoHmpZhgkAu9opvQ
	(envelope-from <netdev+bounces-293939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 02:50:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0D1626BA2
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 02:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26D0030BA8EA
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 00:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D66C31D757;
	Tue,  2 Jun 2026 00:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="ya5IKVeF"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB6C30C37A;
	Tue,  2 Jun 2026 00:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780361090; cv=none; b=ZOi7gAfvxXmjTwPP6Wnw/CPkwyzOlt2/mkgfdQN2gao/7yTXR562V1iAAN5SFKf+qKsp1pOFnFP80QPr+c8ZZ05ciq9O6eO+VeecX02Yv0bMDN8ik92UVmBxnHGZKABJdcQY9BtadVVnnjiFbApnY1gwwhsFYbzvIPU96JIiu3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780361090; c=relaxed/simple;
	bh=Uh6j7QD6yQdlQzvF8zgN4sOOvBPGKcLznTRVRIwe/kk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fovu+lVhguHjMnE3uQXGPM3aFQUDfeH36cuVOOw5+eYQhlT0aY+RrqoQu8cbaxSc0Fi6Sgx+6McVZxbvsB3aUzh6NL1ZLD4C8XXT2kdp6Vl1RRHMA5PUPulxI5TdtQVCc+UVaH7Mhu8AR42uZRRoykCrSR366tzJOFSygO0nB2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=ya5IKVeF; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 6520hx8u030351
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 2 Jun 2026 01:44:26 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 6520hx8u030351
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780361071; bh=FmTpRWcsHfOWJMyG9JB8r3zI95oKTWcRMKaqT9D4G9Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ya5IKVeFkAAQP/NN2jQAh/mJc+IxQpC/7Cbxqk/83v7HAvu3i2KinmFW/fJpVWcTr
	 EwGm9arbnRWEK03pZHvkwAm2WT/aH4GVt5wJE7XUJi8Q74dpfwIll/AsahGekx7s02
	 O3CoHHV182ldrUP+I4ma4J46zB5yKaWbWt782FxUDyWoCuQ7JyTTBTEWAmoL2c10ZK
	 V6K4DTmW/jY7k/pdjDSbfz4026Ejrd/vVF5cjuZc894aLfCAD4cu9D+xdrQ97vsIZV
	 3NEwPDkI2QJaI6ROEHhVHKkojs16RQNn8LucMyfPh07GlLTy1+Z5wJmitzhhbwXuBq
	 eKdP1/zdsAtbA==
From: Luke Howard <lukeh@padl.com>
Date: Tue, 02 Jun 2026 10:43:49 +1000
Subject: [PATCH net-next v2 4/6] net: bridge: allow
 MDB_FLAGS_STREAM_RESERVED on host groups
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-mv88e6xxx-8021qat-mqprio-v2-4-72be14522e7c@padl.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293939-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,padl.com:email,padl.com:mid,padl.com:dkim]
X-Rspamd-Queue-Id: 2B0D1626BA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Allow the local bridge host to declare itself a reserved stream listener
for a MDB group, for example on a device which is both an AVB end station
and bridge.

Only MDB_FLAGS_STREAM_RESERVED is accepted on host groups; the other
MDB_FLAGS_* bits remain port-group-only.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Luke Howard <lukeh@padl.com>
---
 include/uapi/linux/if_bridge.h                     |   7 +-
 net/bridge/br_input.c                              |   2 +-
 net/bridge/br_mdb.c                                |  21 +++-
 net/bridge/br_multicast.c                          |  37 ++++--
 net/bridge/br_private.h                            |  15 ++-
 .../net/forwarding/bridge_mdb_stream_reserved.sh   | 125 ++++++++++++++++++++-
 6 files changed, 182 insertions(+), 25 deletions(-)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index 01955a575528c..989d13a866be4 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -748,9 +748,10 @@ enum {
  *    [MDBE_ATTR_xxx]
  *    ...
  *    [MDBE_ATTR_FLAGS]
- *       u32, a mask of MDB_FLAGS_* values to set on the entry. Valid only
- *       for port-group entries; currently only MDB_FLAGS_STREAM_RESERVED
- *       may be set from user space.
+ *       u32, a mask of MDB_FLAGS_* values to set on the entry. Currently
+ *       only MDB_FLAGS_STREAM_RESERVED may be set from user space, and is
+ *       accepted on both port-group and host-group entries (on the latter
+ *       it declares the local bridge host as a reserved-stream listener).
  * }
  */
 enum {
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 2e8aa19a9b542..649b819906bf8 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -105,7 +105,7 @@ static bool br_sr_admission_denied(const struct net_bridge_port *p,
 	if (!mdst)
 		return true;
 
-	if (mdst->flags & BRIDGE_MDBE_F_HOST_STREAM_RESERVED)
+	if ((mdst->flags & BRIDGE_MDBE_F_HOST_MASK) == BRIDGE_MDBE_F_HOST_MASK)
 		return false;
 
 	for (pg = rcu_dereference(mdst->ports); pg;
diff --git a/net/bridge/br_mdb.c b/net/bridge/br_mdb.c
index b95ca72ec6347..93127a8ea54f7 100644
--- a/net/bridge/br_mdb.c
+++ b/net/bridge/br_mdb.c
@@ -250,6 +250,9 @@ static int __mdb_fill_info(struct sk_buff *skb,
 	} else {
 		ifindex = mp->br->dev->ifindex;
 		mtimer = &mp->timer;
+		if (mp->flags & BRIDGE_MDBE_F_HOST_STREAM_RESERVED)
+			flags = MDB_PG_FLAGS_PERMANENT |
+				MDB_PG_FLAGS_STREAM_RESERVED;
 	}
 
 	__mdb_entry_fill_flags(&e, flags);
@@ -1059,7 +1062,10 @@ static int br_mdb_add_group(const struct br_mdb_config *cfg,
 			return -EEXIST;
 		}
 
-		br_multicast_host_join(brmctx, mp, false);
+		br_multicast_host_join(brmctx, mp,
+				       cfg->pg_flags & MDB_PG_FLAGS_STREAM_RESERVED ?
+				       BR_MCAST_SR_SET : BR_MCAST_SR_CLEAR,
+				       false);
 		br_mdb_notify(br->dev, mp, NULL, RTM_NEWMDB);
 
 		return 0;
@@ -1219,11 +1225,14 @@ static int br_mdb_config_attrs_init(struct nlattr *set_attrs,
 	}
 
 	if (mdb_attrs[MDBE_ATTR_FLAGS]) {
-		if (!cfg->p) {
-			NL_SET_ERR_MSG_MOD(extack, "Flags cannot be set for host groups");
+		u32 attr_flags = nla_get_u32(mdb_attrs[MDBE_ATTR_FLAGS]);
+
+		if (!cfg->p && (attr_flags & ~MDB_FLAGS_STREAM_RESERVED)) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "Only stream_reserved may be set on host groups");
 			return -EINVAL;
 		}
-		if (nla_get_u32(mdb_attrs[MDBE_ATTR_FLAGS]) & MDB_FLAGS_STREAM_RESERVED)
+		if (attr_flags & MDB_FLAGS_STREAM_RESERVED)
 			cfg->pg_flags |= MDB_PG_FLAGS_STREAM_RESERVED;
 	}
 
@@ -1320,8 +1329,8 @@ int br_mdb_add(struct net_device *dev, struct nlattr *tb[], u16 nlmsg_flags,
 
 	/* host join errors which can happen before creating the group */
 	if (!cfg.p && !br_group_is_l2(&cfg.group)) {
-		/* don't allow any flags for host-joined IP groups */
-		if (cfg.entry->state) {
+		if (cfg.entry->state &&
+		    !(cfg.pg_flags & MDB_PG_FLAGS_STREAM_RESERVED)) {
 			NL_SET_ERR_MSG_MOD(extack, "Flags are not allowed for host groups");
 			goto out;
 		}
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 4107bf7bd271f..e3fc61bb63092 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -397,10 +397,10 @@ static void br_multicast_sg_host_state(struct net_bridge_mdb_entry *star_mp,
 	sg_mp = br_mdb_ip_get(star_mp->br, &sg->key.addr);
 	if (!sg_mp)
 		return;
-	sg_mp->flags |= BRIDGE_MDBE_F_HOST_JOINED;
+	sg_mp->flags |= star_mp->flags & BRIDGE_MDBE_F_HOST_MASK;
 }
 
-/* set the host_joined state of all of *,G's S,G entries */
+/* set the host state of all of *,G's S,G entries */
 static void br_multicast_star_g_host_state(struct net_bridge_mdb_entry *star_mp)
 {
 	struct net_bridge *br = star_mp->br;
@@ -425,8 +425,8 @@ static void br_multicast_star_g_host_state(struct net_bridge_mdb_entry *star_mp)
 			sg_mp = br_mdb_ip_get(br, &sg_ip);
 			if (!sg_mp)
 				continue;
-			sg_mp->flags &= ~BRIDGE_MDBE_F_HOST_JOINED;
-			sg_mp->flags |= star_mp->flags & BRIDGE_MDBE_F_HOST_JOINED;
+			sg_mp->flags &= ~BRIDGE_MDBE_F_HOST_MASK;
+			sg_mp->flags |= star_mp->flags & BRIDGE_MDBE_F_HOST_MASK;
 		}
 	}
 }
@@ -454,7 +454,7 @@ static void br_multicast_sg_del_exclude_ports(struct net_bridge_mdb_entry *sgmp)
 	 * we treat it as EXCLUDE {}, so for an S,G it's considered a
 	 * STAR_EXCLUDE entry and we can safely leave it
 	 */
-	sgmp->flags &= ~BRIDGE_MDBE_F_HOST_JOINED;
+	sgmp->flags &= ~BRIDGE_MDBE_F_HOST_MASK;
 
 	for (pp = &sgmp->ports;
 	     (p = mlock_dereference(*pp, sgmp->br)) != NULL;) {
@@ -1470,10 +1470,18 @@ void br_multicast_del_port_group(struct net_bridge_port_group *p)
 }
 
 void br_multicast_host_join(const struct net_bridge_mcast *brmctx,
-			    struct net_bridge_mdb_entry *mp, bool notify)
+			    struct net_bridge_mdb_entry *mp,
+			    enum br_mcast_sr_op sr_op, bool notify)
 {
-	if (!(mp->flags & BRIDGE_MDBE_F_HOST_JOINED)) {
-		mp->flags |= BRIDGE_MDBE_F_HOST_JOINED;
+	u8 old_flags = mp->flags;
+
+	mp->flags |= BRIDGE_MDBE_F_HOST_JOINED;
+	if (sr_op == BR_MCAST_SR_SET)
+		mp->flags |= BRIDGE_MDBE_F_HOST_STREAM_RESERVED;
+	else if (sr_op == BR_MCAST_SR_CLEAR)
+		mp->flags &= ~BRIDGE_MDBE_F_HOST_STREAM_RESERVED;
+
+	if ((mp->flags ^ old_flags) & BRIDGE_MDBE_F_HOST_MASK) {
 		if (br_multicast_is_star_g(&mp->addr))
 			br_multicast_star_g_host_state(mp);
 		if (notify)
@@ -1483,6 +1491,14 @@ void br_multicast_host_join(const struct net_bridge_mcast *brmctx,
 	if (br_group_is_l2(&mp->addr))
 		return;
 
+	/* Host stream-reserved entries are permanent and have no timer; drop
+	 * any timer left from an earlier non-reserved host join.
+	 */
+	if (mp->flags & BRIDGE_MDBE_F_HOST_STREAM_RESERVED) {
+		timer_delete(&mp->timer);
+		return;
+	}
+
 	mod_timer(&mp->timer, jiffies + brmctx->multicast_membership_interval);
 }
 
@@ -1491,7 +1507,8 @@ void br_multicast_host_leave(struct net_bridge_mdb_entry *mp, bool notify)
 	if (!(mp->flags & BRIDGE_MDBE_F_HOST_JOINED))
 		return;
 
-	mp->flags &= ~BRIDGE_MDBE_F_HOST_JOINED;
+	mp->flags &= ~(BRIDGE_MDBE_F_HOST_JOINED |
+		       BRIDGE_MDBE_F_HOST_STREAM_RESERVED);
 	if (br_multicast_is_star_g(&mp->addr))
 		br_multicast_star_g_host_state(mp);
 	if (notify)
@@ -1520,7 +1537,7 @@ __br_multicast_add_group(struct net_bridge_mcast *brmctx,
 		return ERR_CAST(mp);
 
 	if (!pmctx) {
-		br_multicast_host_join(brmctx, mp, true);
+		br_multicast_host_join(brmctx, mp, BR_MCAST_SR_KEEP, true);
 		goto out;
 	}
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 4ae050ae4826e..fbb7a8156f347 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -375,6 +375,18 @@ struct net_bridge_port_group {
 
 #define BRIDGE_MDBE_F_HOST_JOINED		BIT(0)
 #define BRIDGE_MDBE_F_HOST_STREAM_RESERVED	BIT(1)
+#define BRIDGE_MDBE_F_HOST_MASK \
+	(BRIDGE_MDBE_F_HOST_JOINED | BRIDGE_MDBE_F_HOST_STREAM_RESERVED)
+
+/* How a host join treats BRIDGE_MDBE_F_HOST_STREAM_RESERVED. Only the MDB
+ * netlink path administers the flag (SET/CLEAR); data-path joins must leave an
+ * existing reservation intact (KEEP).
+ */
+enum br_mcast_sr_op {
+	BR_MCAST_SR_KEEP,
+	BR_MCAST_SR_CLEAR,
+	BR_MCAST_SR_SET,
+};
 
 struct net_bridge_mdb_entry {
 	struct rhash_head		rhnode;
@@ -1049,7 +1061,8 @@ int br_mdb_dump(struct net_device *dev, struct sk_buff *skb,
 int br_mdb_get(struct net_device *dev, struct nlattr *tb[], u32 portid, u32 seq,
 	       struct netlink_ext_ack *extack);
 void br_multicast_host_join(const struct net_bridge_mcast *brmctx,
-			    struct net_bridge_mdb_entry *mp, bool notify);
+			    struct net_bridge_mdb_entry *mp,
+			    enum br_mcast_sr_op sr_op, bool notify);
 void br_multicast_host_leave(struct net_bridge_mdb_entry *mp, bool notify);
 void br_multicast_star_g_handle_mode(struct net_bridge_port_group *pg,
 				     u8 filter_mode);
diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb_stream_reserved.sh b/tools/testing/selftests/net/forwarding/bridge_mdb_stream_reserved.sh
index a21dc2ec3e95c..4c5933455037a 100755
--- a/tools/testing/selftests/net/forwarding/bridge_mdb_stream_reserved.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb_stream_reserved.sh
@@ -30,6 +30,8 @@
 ALL_TESTS="
 	cfg_test
 	fwd_sr_member_test
+	fwd_sr_host_member_test
+	fwd_sr_host_persistence_test
 	fwd_foreign_blocked_test
 	fwd_unicast_blocked_test
 	fwd_flag_gates_test
@@ -217,11 +219,43 @@ cfg_test()
 	bridge mdb add dev br0 port $swp2 grp $GRP vid $VID \
 		stream_reserved 2>/dev/null
 	check_fail $? "non-permanent stream_reserved port entry accepted"
-
-	# The flag must be rejected on host groups.
-	bridge mdb add dev br0 port br0 grp $GRP permanent vid $VID \
+	bridge mdb add dev br0 port br0 grp $GRP vid $VID \
 		stream_reserved 2>/dev/null
-	check_fail $? "stream_reserved accepted on a host group"
+	check_fail $? "non-permanent stream_reserved host group accepted"
+
+	# A plain (non-SR) host join is still accepted, must not be permanent,
+	# and toggles cleanly with stream_reserved on replace.
+	bridge mdb add dev br0 port br0 grp $GRP vid $VID
+	check_err $? "plain host join rejected"
+	bridge mdb add dev br0 port br0 grp $GRP permanent vid $VID 2>/dev/null
+	check_fail $? "permanent flag accepted on a plain host group"
+	bridge -d mdb show dev br0 | grep "port br0" | grep "$GRP" | \
+		grep -q "stream_reserved"
+	check_fail $? "stream_reserved unexpectedly set on a plain host join"
+	bridge mdb replace dev br0 port br0 grp $GRP permanent vid $VID \
+		stream_reserved
+	check_err $? "Failed to replace plain host join with stream_reserved"
+	bridge mdb replace dev br0 port br0 grp $GRP vid $VID
+	check_err $? "Failed to replace stream_reserved host group with plain"
+	bridge -d mdb show dev br0 | grep "port br0" | grep "$GRP" | \
+		grep -q "stream_reserved"
+	check_fail $? "stream_reserved not cleared on host group replace"
+	bridge mdb del dev br0 port br0 grp $GRP vid $VID
+
+	# permanent + stream_reserved is accepted on host groups and the
+	# entry is dumped as both permanent and stream_reserved.
+	bridge mdb add dev br0 port br0 grp $GRP permanent vid $VID \
+		stream_reserved
+	check_err $? "stream_reserved rejected on a host group"
+	bridge -d mdb show dev br0 | grep "port br0" | grep "$GRP" | \
+		grep -q "stream_reserved"
+	check_err $? "stream_reserved flag not shown on host group"
+	bridge -d mdb get dev br0 grp $GRP vid $VID | grep -q permanent
+	check_err $? "host stream_reserved entry not reported as permanent"
+	bridge -d -s mdb get dev br0 grp $GRP vid $VID | grep "port br0" | \
+		grep -q " 0.00"
+	check_err $? "host stream_reserved entry has a pending group timer"
+	bridge mdb del dev br0 port br0 grp $GRP permanent vid $VID
 
 	# Add a port group with the flag and confirm it is reflected in dump.
 	bridge mdb add dev br0 port $swp2 grp $GRP permanent vid $VID \
@@ -328,6 +362,89 @@ fwd_sr_member_test()
 	log_test "MDB stream_reserved member delivery"
 }
 
+# An SR-class frame for a group the local bridge host has joined with
+# stream_reserved is delivered to the host (passed up via br0); without the
+# flag set on the host join, the same frame is denied at ingress.
+fwd_sr_host_member_test()
+{
+	RET=0
+
+	tc qdisc add dev br0 clsact
+	sr_filter $swp1 on
+
+	# Host join WITHOUT stream_reserved: SR-class frame must be dropped.
+	# A plain host-joined IP group cannot be permanent.
+	bridge mdb add dev br0 port br0 grp $GRP vid $VID
+	rx_filter_install br0 6 $GRP
+
+	send_mc $GRP $GRP_DMAC $SR_PCP
+	tc_check_packets "dev br0 ingress" 6 0
+	check_err $? "SR-class frame delivered to host without stream_reserved"
+
+	send_mc $GRP $GRP_DMAC $BE_PCP
+	tc_check_packets "dev br0 ingress" 6 1
+	check_err $? "best-effort frame not delivered to host"
+
+	# Replace host join WITH stream_reserved: SR-class frame admitted.
+	bridge mdb replace dev br0 port br0 grp $GRP permanent vid $VID \
+		stream_reserved
+	check_err $? "Failed to replace host group with stream_reserved"
+
+	send_mc $GRP $GRP_DMAC $SR_PCP
+	tc_check_packets "dev br0 ingress" 6 2
+	check_err $? "reserved-stream SR-class frame not delivered to host"
+
+	rx_filter_uninstall br0 6
+	bridge mdb del dev br0 port br0 grp $GRP permanent vid $VID
+	sr_filter $swp1 off
+	tc qdisc del dev br0 clsact
+
+	log_test "MDB stream_reserved host listener delivery"
+}
+
+# A permanent + stream_reserved host group has no group timer and must
+# outlive the membership interval, even when promoted from a plain (timer
+# armed) host join, which must not leave a stale group timer behind.
+fwd_sr_host_persistence_test()
+{
+	RET=0
+
+	ip link set dev br0 type bridge mcast_membership_interval 200
+
+	bridge mdb add dev br0 port br0 grp $GRP permanent vid $VID \
+		stream_reserved
+	check_err $? "Failed to add permanent stream_reserved host group"
+
+	sleep 3
+
+	bridge mdb get dev br0 grp $GRP vid $VID &>/dev/null
+	check_err $? "host stream_reserved entry expired"
+
+	bridge mdb del dev br0 port br0 grp $GRP permanent vid $VID
+
+	# A plain host join arms the group timer; promoting it to
+	# stream_reserved must cancel that timer, otherwise the reservation is
+	# torn down when the stale timer expires.
+	bridge mdb add dev br0 port br0 grp $GRP vid $VID
+	check_err $? "plain host join rejected"
+	bridge mdb replace dev br0 port br0 grp $GRP permanent vid $VID \
+		stream_reserved
+	check_err $? "Failed to promote plain host join to stream_reserved"
+	bridge -d -s mdb get dev br0 grp $GRP vid $VID | grep "port br0" | \
+		grep -q " 0.00"
+	check_err $? "stale group timer left after promotion to stream_reserved"
+
+	sleep 3
+
+	bridge mdb get dev br0 grp $GRP vid $VID &>/dev/null
+	check_err $? "promoted stream_reserved entry expired"
+
+	bridge mdb del dev br0 port br0 grp $GRP permanent vid $VID
+	ip link set dev br0 type bridge mcast_membership_interval 26000
+
+	log_test "MDB stream_reserved host entry persistence"
+}
+
 # swp1 filters SR-class ingress. A foreign (non-reserved) group GRP2 at SR class
 # is dropped at ingress, reaching neither listener, while a best-effort (TC 0)
 # frame is admitted and delivered to both.

-- 
2.43.0


