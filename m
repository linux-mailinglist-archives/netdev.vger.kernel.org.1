Return-Path: <netdev+bounces-293940-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GaPAJInHmpZhgkAu9opvQ
	(envelope-from <netdev+bounces-293940-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 02:45:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9CC626ADB
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 02:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F65D300AD70
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 00:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E25931E845;
	Tue,  2 Jun 2026 00:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b="IBR+5Yjh"
X-Original-To: netdev@vger.kernel.org
Received: from us.padl.com (us.padl.com [216.154.215.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9521C27281E;
	Tue,  2 Jun 2026 00:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.154.215.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780361090; cv=none; b=VrWsz0BQnq3lbBBXnr03ZRC4+2lXPOksG22tPAgx9botgbqWjdYkHQXUUT+29tNHoCWRf9OSFqHJSZa4VrXPBX0z14naAJpJvP4XXWX856SVxODNByWjWK2FHNaIqTNIDyCcSnpi836XmCz1Q6XwfN1+HHT5nsacqYg90gSmGVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780361090; c=relaxed/simple;
	bh=mHU84QHs3eHKfvrAIO05wgpOiyWHJNvco3SZyUD9LiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H+ucbS4UASOjhCBsL7IFvlal94D4752p8AEtyu2b/ZWghTXOdtG1kfgEDTEdBnhNu+tsLXSqN9w5UVVI0/S4PH5hnIWKH1StOubYFgLyLIZKNIAoOfHoizRpMLQBgE93gQI5mDEcWBtveUhxQuU6s2Utq65H70RbLL2/WorQm84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com; spf=pass smtp.mailfrom=padl.com; dkim=pass (2048-bit key) header.d=padl.com header.i=@padl.com header.b=IBR+5Yjh; arc=none smtp.client-ip=216.154.215.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=padl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=padl.com
Received: from auth (localhost [127.0.0.1]) by us.padl.com (8.14.7/8.14.7) with ESMTP id 6520hx8t030351
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 2 Jun 2026 01:44:19 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 us.padl.com 6520hx8t030351
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=padl.com; s=default;
	t=1780361065; bh=tgf1LYZBdih01ACp7b38OAPy09DbrKVKDxTLjAH6KNE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IBR+5Yjhnv+ho8B+/x1ddDPmOKsj7lhT4yt7IkqRwjob/0s/6kYtiKy3sfQDl683U
	 DEe9B6i+pcBOoYhHY31/fbyAib+o4QdxbOqkM2P2H6KXMJUBGwmuLgq5xXjrWcjb6J
	 Qihm6GoyluxtktPzdb8Pf2UacARwf1qe3F7QBzcS2vyZ5L6azmRAV7AefGeek93K27
	 JIaMj18Y2SBY/pwu5xXUvQgJEFDK4RtHIhebX6q8D9tortViQpFvt/QFxXznq0pDEl
	 pWEJ/R4QHhZRDvNyoAabYbbqQMFD5T5GWFH7rnS9+CmParchiYTqhDARWCndslJXZe
	 nQgJ4VLfud9qw==
From: Luke Howard <lukeh@padl.com>
Date: Tue, 02 Jun 2026 10:43:48 +1000
Subject: [PATCH net-next v2 3/6] net: bridge: add 802.1Qat stream
 reservation admission control
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-mv88e6xxx-8021qat-mqprio-v2-3-72be14522e7c@padl.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293940-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[resnulli.us,redhat.com,davemloft.net,google.com,kernel.org,blackwall.org,nvidia.com,lunn.ch,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.1:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukeh@padl.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[padl.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,padl.com:email,padl.com:mid,padl.com:dkim,0.0.0.0:email,bridge_mdb_stream_reserved.sh:url,tc_common.sh:url]
X-Rspamd-Queue-Id: 0A9CC626ADB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the BR_FILTER_STREAM_RESERVED bridge port flag, gated by
CONFIG_BRIDGE_8021Q_SRP, which may be used to enforce 802.1Qat admission
control on ports that have it set.

A frame received by a port with the flag set, and whose 802.1p priority
maps (via an MQPRIO/TAPRIO Qdisc on the bridge) to a non-zero traffic
class, is admitted only if it belongs to a reserved stream. Reserved
streams are multicast frames whose MDB entry has FLAGS_STREAM_RESERVED
set. Unicast and broadcast frames sharing this priority are dropped.

Non-admitted frames are dropped after source address learning.

Multicast snooping must be enabled on the bridge for admission control
to function correctly: with snooping disabled, no MDB entries exist and
all SR-class multicast frames on SR-filtered ports would be dropped.

There is no support for reserved unicast streams at present; although
permitted by 802.1Qat (SRP) they are rarely used in practice.

The choice to not allow configurable mapping of traffic classes was done
in the interest of simplicity and keeping the number of additional
instructions in the forwarding path to a minimum. It is anticipated this
will suffice for the common AVB/TSN use case.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Luke Howard <lukeh@padl.com>
---
 include/linux/if_bridge.h                          |   1 +
 include/uapi/linux/if_link.h                       |   9 +
 net/bridge/Kconfig                                 |  22 +
 net/bridge/br_input.c                              |  59 ++-
 net/bridge/br_netlink.c                            |   8 +-
 net/bridge/br_private.h                            |   3 +-
 net/bridge/br_switchdev.c                          |   3 +-
 net/core/rtnetlink.c                               |   2 +-
 tools/testing/selftests/net/forwarding/Makefile    |   1 +
 .../net/forwarding/bridge_mdb_stream_reserved.sh   | 536 +++++++++++++++++++++
 tools/testing/selftests/net/forwarding/config      |   2 +
 11 files changed, 641 insertions(+), 5 deletions(-)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index ec9ffea1e46ed..a5e91bace0464 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -62,6 +62,7 @@ struct br_ip_list {
 #define BR_PORT_MAB		BIT(22)
 #define BR_NEIGH_VLAN_SUPPRESS	BIT(23)
 #define BR_NEIGH_FORWARD_GRAT	BIT(24)
+#define BR_FILTER_STREAM_RESERVED	BIT(25)
 
 #define BR_DEFAULT_AGEING_TIME	(300 * HZ)
 
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 46413392b402c..80f5a2b4162c8 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1106,6 +1106,14 @@ enum {
  *   backup port that has VLAN tunnel mapping enabled (via the
  *   *IFLA_BRPORT_VLAN_TUNNEL* option). Setting a value of 0 (default) has
  *   the effect of not attaching any ID.
+ *
+ * @IFLA_BRPORT_FILTER_STREAM_RESERVED
+ *   Controls whether the port enforces 802.1Qat stream reservation
+ *   admission control. When enabled, a frame received on the port whose
+ *   802.1p priority maps (via an MQPRIO/TAPRIO Qdisc on the bridge) to a
+ *   non-zero traffic class is dropped at ingress unless it belongs to a
+ *   reserved stream, i.e. it is multicast and its destination address has a
+ *   stream-reserved MDB entry. The flag is off by default.
  */
 enum {
 	IFLA_BRPORT_UNSPEC,
@@ -1154,6 +1162,7 @@ enum {
 	IFLA_BRPORT_NEIGH_VLAN_SUPPRESS,
 	IFLA_BRPORT_BACKUP_NHID,
 	IFLA_BRPORT_NEIGH_FORWARD_GRAT,
+	IFLA_BRPORT_FILTER_STREAM_RESERVED,
 	__IFLA_BRPORT_MAX
 };
 #define IFLA_BRPORT_MAX (__IFLA_BRPORT_MAX - 1)
diff --git a/net/bridge/Kconfig b/net/bridge/Kconfig
index 318715c8fc9bc..7e46b791922a6 100644
--- a/net/bridge/Kconfig
+++ b/net/bridge/Kconfig
@@ -47,6 +47,28 @@ config BRIDGE_IGMP_SNOOPING
 
 	  If unsure, say Y.
 
+config BRIDGE_8021Q_SRP
+	bool "802.1Qat Stream Reservation Protocol (SRP) admission control"
+	depends on BRIDGE
+	default n
+	help
+	  If you say Y here, then the Ethernet bridge will enforce 802.1Qat
+	  stream reservation admission control in software on ingress ports
+	  that have the BR_FILTER_STREAM_RESERVED flag set: a frame whose
+	  802.1p priority maps (via an MQPRIO/TAPRIO Qdisc on the bridge) to
+	  a non-zero traffic class is dropped unless it is multicast and its
+	  destination address MDB_FLAGS_STREAM_RESERVED set on its MDB entry.
+
+	  This option only controls software enforcement. The
+	  BR_FILTER_STREAM_RESERVED port flag and MDB_FLAGS_STREAM_RESERVED
+	  MDB flag are always accepted from user space and propagated via
+	  switchdev so that hardware-offloading switches can enforce
+	  admission control even when this option is disabled.
+
+	  Say N to exclude software enforcement and reduce the binary size.
+
+	  If unsure, say N.
+
 config BRIDGE_VLAN_FILTERING
 	bool "VLAN filtering"
 	depends on BRIDGE
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 5787066b1f4cb..2e8aa19a9b542 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
+#include <linux/if_vlan.h>
 #include <linux/netfilter_bridge.h>
 #ifdef CONFIG_NETFILTER_FAMILY_BRIDGE
 #include <net/netfilter/nf_queue.h>
@@ -72,6 +73,57 @@ static int br_pass_frame_up(struct sk_buff *skb, bool promisc)
 		       br_netif_receive_skb);
 }
 
+#ifdef CONFIG_BRIDGE_8021Q_SRP
+/* Return false if the bridge has an MQPRIO/TAPRIO Qdisc that maps the
+ * frame's VLAN PCP to a non-zero traffic class.
+ */
+static bool br_skb_is_sr_class(const struct net_bridge *br,
+			       const struct sk_buff *skb)
+{
+	if (!skb_vlan_tag_present(skb) || !netdev_get_num_tc(br->dev))
+		return false;
+
+	return netdev_get_prio_tc_map(br->dev, skb_vlan_tag_get_prio(skb)) != 0;
+}
+
+/* 802.1Qat admission control: a frame whose priority maps to a non-zero
+ * TC and which ingresses a port with BR_FILTER_STREAM_RESERVED is admitted
+ * only if it belongs to a reserved stream. Only multicast can be a reserved
+ * stream: either via an MDB port-group member with MDB_PG_FLAGS_STREAM_RESERVED,
+ * or via a host-group entry marked BRIDGE_MDBE_F_HOST_STREAM_RESERVED.
+ */
+static bool br_sr_admission_denied(const struct net_bridge_port *p,
+				   const struct sk_buff *skb,
+				   const struct net_bridge_mdb_entry *mdst)
+{
+	const struct net_bridge_port_group *pg;
+
+	if (!(p->flags & BR_FILTER_STREAM_RESERVED) ||
+	    !br_skb_is_sr_class(p->br, skb))
+		return false;
+
+	if (!mdst)
+		return true;
+
+	if (mdst->flags & BRIDGE_MDBE_F_HOST_STREAM_RESERVED)
+		return false;
+
+	for (pg = rcu_dereference(mdst->ports); pg;
+	     pg = rcu_dereference(pg->next))
+		if (pg->flags & MDB_PG_FLAGS_STREAM_RESERVED)
+			return false;
+
+	return true;
+}
+#else
+static inline bool br_sr_admission_denied(const struct net_bridge_port *p,
+					  const struct sk_buff *skb,
+					  const struct net_bridge_mdb_entry *mdst)
+{
+	return false;
+}
+#endif
+
 /* note: already called with rcu_read_lock */
 int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
@@ -183,9 +235,14 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 				br_do_suppress_nd(skb, br, vid, p, msg);
 	}
 
+	mdst = pkt_type == BR_PKT_MULTICAST ?
+	       br_mdb_entry_skb_get(brmctx, skb, vid) : NULL;
+
+	if (br_sr_admission_denied(p, skb, mdst))
+		goto drop;
+
 	switch (pkt_type) {
 	case BR_PKT_MULTICAST:
-		mdst = br_mdb_entry_skb_get(brmctx, skb, vid);
 		if ((mdst || BR_INPUT_SKB_CB_MROUTERS_ONLY(skb)) &&
 		    br_multicast_querier_exists(brmctx, eth_hdr(skb), mdst)) {
 			if ((mdst && (mdst->flags & BRIDGE_MDBE_F_HOST_JOINED)) ||
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index a104b25c871d2..99e2a19255773 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -191,6 +191,7 @@ static inline size_t br_port_info_size(void)
 		+ nla_total_size(1)	/* IFLA_BRPORT_MAB */
 		+ nla_total_size(1)	/* IFLA_BRPORT_NEIGH_VLAN_SUPPRESS */
 		+ nla_total_size(1)	/* IFLA_BRPORT_NEIGH_FORWARD_GRAT */
+		+ nla_total_size(1)	/* IFLA_BRPORT_FILTER_STREAM_RESERVED */
 		+ nla_total_size(sizeof(struct ifla_bridge_id))	/* IFLA_BRPORT_ROOT_ID */
 		+ nla_total_size(sizeof(struct ifla_bridge_id))	/* IFLA_BRPORT_BRIDGE_ID */
 		+ nla_total_size(sizeof(u16))	/* IFLA_BRPORT_DESIGNATED_PORT */
@@ -285,7 +286,9 @@ static int br_port_fill_attrs(struct sk_buff *skb,
 	    nla_put_u8(skb, IFLA_BRPORT_NEIGH_VLAN_SUPPRESS,
 		       !!(p->flags & BR_NEIGH_VLAN_SUPPRESS)) ||
 	    nla_put_u8(skb, IFLA_BRPORT_NEIGH_FORWARD_GRAT,
-		       !!(p->flags & BR_NEIGH_FORWARD_GRAT)))
+		       !!(p->flags & BR_NEIGH_FORWARD_GRAT)) ||
+	    nla_put_u8(skb, IFLA_BRPORT_FILTER_STREAM_RESERVED,
+		       !!(p->flags & BR_FILTER_STREAM_RESERVED)))
 		return -EMSGSIZE;
 
 	timerval = br_timer_value(&p->message_age_timer);
@@ -906,6 +909,7 @@ static const struct nla_policy br_port_policy[IFLA_BRPORT_MAX + 1] = {
 	[IFLA_BRPORT_NEIGH_VLAN_SUPPRESS] = NLA_POLICY_MAX(NLA_U8, 1),
 	[IFLA_BRPORT_BACKUP_NHID] = { .type = NLA_U32 },
 	[IFLA_BRPORT_NEIGH_FORWARD_GRAT] = NLA_POLICY_MAX(NLA_U8, 1),
+	[IFLA_BRPORT_FILTER_STREAM_RESERVED] = NLA_POLICY_MAX(NLA_U8, 1),
 };
 
 /* Change the state of the port and notify spanning tree */
@@ -976,6 +980,8 @@ static int br_setport(struct net_bridge_port *p, struct nlattr *tb[],
 			 BR_NEIGH_VLAN_SUPPRESS);
 	br_set_port_flag(p, tb, IFLA_BRPORT_NEIGH_FORWARD_GRAT,
 			 BR_NEIGH_FORWARD_GRAT);
+	br_set_port_flag(p, tb, IFLA_BRPORT_FILTER_STREAM_RESERVED,
+			 BR_FILTER_STREAM_RESERVED);
 
 	if ((p->flags & BR_PORT_MAB) &&
 	    (!(p->flags & BR_PORT_LOCKED) || !(p->flags & BR_LEARNING))) {
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 1e0eefaf50dd1..4ae050ae4826e 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -373,7 +373,8 @@ struct net_bridge_port_group {
 	struct rcu_head			rcu;
 };
 
-#define BRIDGE_MDBE_F_HOST_JOINED	BIT(0)
+#define BRIDGE_MDBE_F_HOST_JOINED		BIT(0)
+#define BRIDGE_MDBE_F_HOST_STREAM_RESERVED	BIT(1)
 
 struct net_bridge_mdb_entry {
 	struct rhash_head		rhnode;
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 39535f1a6b8ce..7b531d483817c 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -76,7 +76,8 @@ bool nbp_switchdev_allowed_egress(const struct net_bridge_port *p,
 /* Flags that can be offloaded to hardware */
 #define BR_PORT_FLAGS_HW_OFFLOAD (BR_LEARNING | BR_FLOOD | BR_PORT_MAB | \
 				  BR_MCAST_FLOOD | BR_BCAST_FLOOD | BR_PORT_LOCKED | \
-				  BR_HAIRPIN_MODE | BR_ISOLATED | BR_MULTICAST_TO_UNICAST)
+				  BR_HAIRPIN_MODE | BR_ISOLATED | BR_MULTICAST_TO_UNICAST | \
+				  BR_FILTER_STREAM_RESERVED)
 
 int br_switchdev_set_port_flag(struct net_bridge_port *p,
 			       unsigned long flags,
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 652dd008955a9..8ad7f1d0357b2 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -63,7 +63,7 @@
 #include "dev.h"
 
 #define RTNL_MAX_TYPE		50
-#define RTNL_SLAVE_MAX_TYPE	45
+#define RTNL_SLAVE_MAX_TYPE	46
 
 struct rtnl_link {
 	rtnl_doit_func		doit;
diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
index bbaf4d937dd8b..3899551db05b9 100644
--- a/tools/testing/selftests/net/forwarding/Makefile
+++ b/tools/testing/selftests/net/forwarding/Makefile
@@ -10,6 +10,7 @@ TEST_PROGS := \
 	bridge_mdb_host.sh \
 	bridge_mdb_max.sh \
 	bridge_mdb_port_down.sh \
+	bridge_mdb_stream_reserved.sh \
 	bridge_mld.sh \
 	bridge_port_isolation.sh \
 	bridge_sticky_fdb.sh \
diff --git a/tools/testing/selftests/net/forwarding/bridge_mdb_stream_reserved.sh b/tools/testing/selftests/net/forwarding/bridge_mdb_stream_reserved.sh
new file mode 100755
index 0000000000000..a21dc2ec3e95c
--- /dev/null
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb_stream_reserved.sh
@@ -0,0 +1,536 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# Test 802.1Qat stream reservation admission control. A bridge port with the
+# BR_FILTER_STREAM_RESERVED flag set (bridge link set ... filter_stream_reserved
+# on) polices multicast it receives: a frame whose 802.1p priority maps (via an
+# mqprio/TC configuration on the bridge netdev) to a non-zero traffic class is
+# admitted only if its destination is a reserved stream, i.e. has an MDB entry
+# with the stream_reserved flag (the allow-list, typically maintained by an SRP
+# daemon). Other SR-class multicast is dropped at ingress, so it reaches neither
+# the host nor any port. TC 0 traffic, and traffic on ports without the flag,
+# is unaffected.
+#
+#                                +------------------------+
+#                                | H1 (vrf) - talker      |
+#                                | + $h1                  |
+#                                +----|-------------------+
+#                                     | PCP-tagged mcast
+# +-----------------------------------|------------------------------------+
+# | SW             $swp1 (filter_stream_reserved)   BR0 (802.1q, mqprio)    |
+# |                                   +                                     |
+# |                  + $swp2 (listener)        + $swp3 (listener)           |
+# +------------------|-------------------------|---------------------------+
+#                    |                         |
+#     +--------------|---------+   +-----------|------------+
+#     | H2 (vrf) - listener    |   | H3 (vrf) - listener    |
+#     | + $h2                  |   | + $h3                  |
+#     +------------------------+   +------------------------+
+
+ALL_TESTS="
+	cfg_test
+	fwd_sr_member_test
+	fwd_foreign_blocked_test
+	fwd_unicast_blocked_test
+	fwd_flag_gates_test
+	fwd_tc_toggle_test
+	fwd_flag_toggle_test
+	fwd_sr_ipv6_test
+"
+
+NUM_NETIFS=6
+source lib.sh
+source tc_common.sh
+
+# GRP is the stream-reserved group; GRP2 is a plain group that both swp2 and
+# swp3 join, used to show that a foreign SR-class group is dropped at ingress.
+GRP=239.1.1.1
+GRP_DMAC=01:00:5e:01:01:01
+GRP2=239.1.1.2
+GRP2_DMAC=01:00:5e:01:01:02
+GRP3=239.1.1.3
+GRP3_DMAC=01:00:5e:01:01:03
+# IPv6 (MLD) groups: GRP6 is stream-reserved, GRP6B is a plain group.
+GRP6=ff0e::1
+GRP6_DMAC=33:33:00:00:00:01
+GRP6B=ff0e::2
+GRP6B_DMAC=33:33:00:00:00:02
+# Source for the (S, G) configuration check.
+SRC=192.0.2.10
+# PCP 3 is SR class A; the mqprio map below sends it to TC 1.
+SR_PCP=3
+BE_PCP=0
+VID=10
+
+h1_create()
+{
+	simple_if_init $h1
+	vlan_create $h1 $VID v$h1 192.0.2.1/28
+}
+
+h1_destroy()
+{
+	vlan_destroy $h1 $VID
+	simple_if_fini $h1
+}
+
+h2_create()
+{
+	simple_if_init $h2
+	vlan_create $h2 $VID v$h2 192.0.2.2/28
+}
+
+h2_destroy()
+{
+	vlan_destroy $h2 $VID
+	simple_if_fini $h2
+}
+
+h3_create()
+{
+	simple_if_init $h3
+	vlan_create $h3 $VID v$h3 192.0.2.3/28
+}
+
+h3_destroy()
+{
+	vlan_destroy $h3 $VID
+	simple_if_fini $h3
+}
+
+switch_create()
+{
+	# The bridge must have multiple TX queues so that an mqprio qdisc (which
+	# populates the netdev prio->tc map the SR filter consults) can be
+	# attached, and a multicast querier so that the bridge forwards
+	# selectively.
+	ip link add name br0 numtxqueues 8 numrxqueues 8 type bridge \
+		vlan_filtering 1 vlan_default_pvid 0 \
+		mcast_snooping 1 mcast_igmp_version 3 mcast_mld_version 2 \
+		mcast_querier 1
+	bridge vlan add vid $VID dev br0 self
+	ip link set dev br0 up
+
+	# A link-local address lets the bridge act as the IPv6 (MLD) querier,
+	# mirroring the IGMP querier.
+	ip address add fe80::1/64 dev br0 nodad
+
+	local swp
+	for swp in $swp1 $swp2 $swp3; do
+		ip link set dev $swp master br0
+		ip link set dev $swp up
+		bridge vlan add vid $VID dev $swp
+	done
+
+	# PCP $SR_PCP -> TC 1, everything else -> TC 0 (software mode).
+	tc qdisc add dev br0 root handle 100: mqprio num_tc 2 \
+		map 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 \
+		queues 1@0 1@1 hw 0
+
+	tc qdisc add dev $h2 clsact
+	tc qdisc add dev $h3 clsact
+
+	# Wait for the bridge's own querier to become active.
+	sleep 10
+}
+
+switch_destroy()
+{
+	tc qdisc del dev $h3 clsact
+	tc qdisc del dev $h2 clsact
+	tc qdisc del dev br0 root handle 100: mqprio 2>/dev/null
+
+	local swp
+	for swp in $swp3 $swp2 $swp1; do
+		bridge vlan del vid $VID dev $swp
+		ip link set dev $swp down
+		ip link set dev $swp nomaster
+	done
+
+	ip link set dev br0 down
+	bridge vlan del vid $VID dev br0 self
+	ip link del dev br0
+}
+
+setup_prepare()
+{
+	h1=${NETIFS[p1]}
+	swp1=${NETIFS[p2]}
+	swp2=${NETIFS[p3]}
+	h2=${NETIFS[p4]}
+	swp3=${NETIFS[p5]}
+	h3=${NETIFS[p6]}
+
+	vrf_prepare
+	forwarding_enable
+
+	h1_create
+	h2_create
+	h3_create
+	switch_create
+}
+
+cleanup()
+{
+	pre_cleanup
+
+	switch_destroy
+	h3_destroy
+	h2_destroy
+	h1_destroy
+
+	forwarding_restore
+	vrf_cleanup
+}
+
+# Arm or disarm SR-class admission control on a bridge port
+# (BR_FILTER_STREAM_RESERVED).
+sr_filter()
+{
+	local dev=$1 onoff=$2
+
+	bridge link set dev $dev filter_stream_reserved $onoff
+}
+
+# Probe whether the running kernel and iproute2 understand the MDB flag and the
+# port flag. If not, the whole suite is skipped, so it is safe to invoke on an
+# unpatched system.
+stream_reserved_supported()
+{
+	bridge mdb add dev br0 port $swp2 grp $GRP permanent vid $VID \
+		stream_reserved 2>/dev/null
+	if [[ $? -ne 0 ]]; then
+		return 1
+	fi
+	bridge mdb del dev br0 port $swp2 grp $GRP permanent vid $VID
+
+	sr_filter $swp1 on 2>/dev/null || return 1
+	sr_filter $swp1 off
+	return 0
+}
+
+cfg_test()
+{
+	RET=0
+
+	# stream_reserved entries must be permanent.
+	bridge mdb add dev br0 port $swp2 grp $GRP vid $VID \
+		stream_reserved 2>/dev/null
+	check_fail $? "non-permanent stream_reserved port entry accepted"
+
+	# The flag must be rejected on host groups.
+	bridge mdb add dev br0 port br0 grp $GRP permanent vid $VID \
+		stream_reserved 2>/dev/null
+	check_fail $? "stream_reserved accepted on a host group"
+
+	# Add a port group with the flag and confirm it is reflected in dump.
+	bridge mdb add dev br0 port $swp2 grp $GRP permanent vid $VID \
+		stream_reserved
+	check_err $? "Failed to add stream_reserved entry"
+	bridge -d mdb show dev br0 | grep -q "$GRP.*stream_reserved"
+	check_err $? "stream_reserved flag not shown in dump"
+
+	# The other state flags must not be disturbed: a permanent entry stays
+	# permanent and carries no group timer when stream_reserved is set.
+	bridge -d mdb get dev br0 grp $GRP vid $VID | grep -q "permanent"
+	check_err $? "stream_reserved entry not kept \"permanent\""
+	bridge -d -s mdb get dev br0 grp $GRP vid $VID | grep -q " 0.00"
+	check_err $? "\"permanent\" stream_reserved entry has a pending group timer"
+
+	# The flag is also accepted, and reported, on a source-specific (S, G).
+	bridge mdb add dev br0 port $swp2 grp $GRP3 src $SRC permanent vid $VID \
+		stream_reserved
+	check_err $? "stream_reserved rejected on an (S, G) entry"
+	bridge -d mdb show dev br0 | grep "$SRC" | grep -q stream_reserved
+	check_err $? "stream_reserved flag not shown on (S, G) entry"
+	bridge mdb del dev br0 port $swp2 grp $GRP3 src $SRC vid $VID
+
+	# Replacing without the flag must clear it.
+	bridge mdb replace dev br0 port $swp2 grp $GRP permanent vid $VID
+	bridge -d mdb show dev br0 | grep -q "$GRP.*stream_reserved"
+	check_fail $? "stream_reserved flag not cleared on replace"
+
+	bridge mdb del dev br0 port $swp2 grp $GRP permanent vid $VID
+
+	# The port flag round-trips through netlink and is shown in the dump.
+	sr_filter $swp1 on
+	check_err $? "Failed to set filter_stream_reserved on a port"
+	bridge -d link show dev $swp1 | grep -q "filter_stream_reserved on"
+	check_err $? "filter_stream_reserved not shown in link dump"
+	sr_filter $swp1 off
+
+	log_test "MDB stream_reserved configuration"
+}
+
+rx_filter_install()
+{
+	local dev=$1 pref=$2 grp=$3 ethtype=${4:-ipv4}
+
+	tc filter add dev $dev ingress protocol 802.1q pref $pref handle $pref \
+		flower vlan_ethtype $ethtype vlan_id $VID dst_ip $grp action drop
+}
+
+rx_filter_uninstall()
+{
+	local dev=$1 pref=$2
+
+	tc filter del dev $dev ingress protocol 802.1q pref $pref handle $pref \
+		flower
+}
+
+send_mc()
+{
+	local grp=$1 dmac=$2 pcp=$3
+
+	$MZ $h1 -a own -b $dmac -c 1 -p 64 \
+		-A 192.0.2.1 -B $grp -t udp -Q $pcp:$VID -q
+}
+
+send_mc6()
+{
+	local grp=$1 dmac=$2 pcp=$3
+
+	$MZ -6 $h1 -a own -b $dmac -c 1 -p 64 \
+		-A 2001:db8:1::1 -B $grp -t udp -Q $pcp:$VID -q
+}
+
+# An arbitrary unicast DA: the bridge floods it as unknown unicast, so it
+# reaches h2 unless dropped at ingress.
+UC_DMAC=00:de:ad:be:ef:02
+
+send_uc()
+{
+	local dip=$1 pcp=$2
+
+	$MZ $h1 -a own -b $UC_DMAC -c 1 -p 64 \
+		-A 192.0.2.1 -B $dip -t udp -Q $pcp:$VID -q
+}
+
+# An SR-class frame for a reserved stream is admitted on a filtering port and
+# delivered to the stream's member.
+fwd_sr_member_test()
+{
+	RET=0
+
+	sr_filter $swp1 on
+	bridge mdb add dev br0 port $swp2 grp $GRP permanent vid $VID \
+		stream_reserved
+	rx_filter_install $h2 1 $GRP
+
+	send_mc $GRP $GRP_DMAC $SR_PCP
+	tc_check_packets "dev $h2 ingress" 1 1
+	check_err $? "reserved-stream SR-class frame not admitted to its member"
+
+	rx_filter_uninstall $h2 1
+	bridge mdb del dev br0 port $swp2 grp $GRP permanent vid $VID
+	sr_filter $swp1 off
+
+	log_test "MDB stream_reserved member delivery"
+}
+
+# swp1 filters SR-class ingress. A foreign (non-reserved) group GRP2 at SR class
+# is dropped at ingress, reaching neither listener, while a best-effort (TC 0)
+# frame is admitted and delivered to both.
+fwd_foreign_blocked_test()
+{
+	RET=0
+
+	sr_filter $swp1 on
+	bridge mdb add dev br0 port $swp2 grp $GRP2 permanent vid $VID
+	bridge mdb add dev br0 port $swp3 grp $GRP2 permanent vid $VID
+
+	rx_filter_install $h2 2 $GRP2
+	rx_filter_install $h3 2 $GRP2
+
+	# SR-class: dropped at ingress, reaches neither listener.
+	send_mc $GRP2 $GRP2_DMAC $SR_PCP
+	tc_check_packets "dev $h2 ingress" 2 0
+	check_err $? "foreign SR-class frame leaked to a listener"
+	tc_check_packets "dev $h3 ingress" 2 0
+	check_err $? "foreign SR-class frame leaked to a listener"
+
+	# Best-effort (TC 0): unaffected, delivered to both.
+	send_mc $GRP2 $GRP2_DMAC $BE_PCP
+	tc_check_packets "dev $h2 ingress" 2 1
+	check_err $? "best-effort frame not delivered"
+	tc_check_packets "dev $h3 ingress" 2 1
+	check_err $? "best-effort frame not delivered"
+
+	rx_filter_uninstall $h3 2
+	rx_filter_uninstall $h2 2
+
+	bridge mdb del dev br0 port $swp3 grp $GRP2 permanent vid $VID
+	bridge mdb del dev br0 port $swp2 grp $GRP2 permanent vid $VID
+	sr_filter $swp1 off
+
+	log_test "MDB stream_reserved blocks foreign SR-class group at ingress"
+}
+
+# Unicast cannot belong to a reserved stream, so an SR-class unicast frame is
+# dropped at a filtering ingress port (otherwise it would consume the AVB
+# queue's reserved bandwidth). A best-effort unicast frame is unaffected.
+fwd_unicast_blocked_test()
+{
+	RET=0
+
+	sr_filter $swp1 on
+	rx_filter_install $h2 5 192.0.2.2
+
+	send_uc 192.0.2.2 $SR_PCP
+	tc_check_packets "dev $h2 ingress" 5 0
+	check_err $? "SR-class unicast leaked through a filtering ingress port"
+
+	send_uc 192.0.2.2 $BE_PCP
+	tc_check_packets "dev $h2 ingress" 5 1
+	check_err $? "best-effort unicast not delivered"
+
+	rx_filter_uninstall $h2 5
+	sr_filter $swp1 off
+
+	log_test "MDB stream_reserved blocks SR-class unicast at ingress"
+}
+
+# Filtering is gated by the ingress port flag, not by the presence of a
+# reserved stream: with a reserved stream registered but the flag clear, a
+# foreign SR-class group is forwarded; setting the flag then blocks it.
+fwd_flag_gates_test()
+{
+	RET=0
+
+	bridge mdb add dev br0 port $swp2 grp $GRP permanent vid $VID \
+		stream_reserved
+	bridge mdb add dev br0 port $swp2 grp $GRP2 permanent vid $VID
+
+	rx_filter_install $h2 2 $GRP2
+
+	# Flag clear (default): the reserved stream does not engage the gate.
+	send_mc $GRP2 $GRP2_DMAC $SR_PCP
+	tc_check_packets "dev $h2 ingress" 2 1
+	check_err $? "SR-class frame blocked with filter flag clear"
+
+	# Flag set on the ingress port: the foreign group is now dropped.
+	sr_filter $swp1 on
+	send_mc $GRP2 $GRP2_DMAC $SR_PCP
+	tc_check_packets "dev $h2 ingress" 2 1
+	check_err $? "foreign SR-class frame leaked after filter flag set"
+
+	rx_filter_uninstall $h2 2
+	bridge mdb del dev br0 port $swp2 grp $GRP2 permanent vid $VID
+	bridge mdb del dev br0 port $swp2 grp $GRP permanent vid $VID
+	sr_filter $swp1 off
+
+	log_test "MDB stream_reserved gated by port flag, not membership"
+}
+
+# The gate only engages while the prio->tc map has a non-zero class. With the
+# mqprio qdisc removed, the foreign group is admitted again.
+fwd_tc_toggle_test()
+{
+	RET=0
+
+	sr_filter $swp1 on
+	bridge mdb add dev br0 port $swp2 grp $GRP2 permanent vid $VID
+
+	rx_filter_install $h2 2 $GRP2
+
+	send_mc $GRP2 $GRP2_DMAC $SR_PCP
+	tc_check_packets "dev $h2 ingress" 2 0
+	check_err $? "foreign SR-class frame leaked while TC enabled"
+
+	# Drop the TC configuration; the prio->tc map is gone, gate is inert.
+	tc qdisc del dev br0 root handle 100: mqprio
+
+	send_mc $GRP2 $GRP2_DMAC $SR_PCP
+	tc_check_packets "dev $h2 ingress" 2 1
+	check_err $? "frame not delivered after TC configuration removed"
+
+	tc qdisc add dev br0 root handle 100: mqprio num_tc 2 \
+		map 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 \
+		queues 1@0 1@1 hw 0
+
+	rx_filter_uninstall $h2 2
+
+	bridge mdb del dev br0 port $swp2 grp $GRP2 permanent vid $VID
+	sr_filter $swp1 off
+
+	log_test "MDB stream_reserved gate follows TC configuration"
+}
+
+# Clearing the port flag stops the port filtering, so the previously blocked
+# group is admitted again.
+fwd_flag_toggle_test()
+{
+	RET=0
+
+	sr_filter $swp1 on
+	bridge mdb add dev br0 port $swp2 grp $GRP2 permanent vid $VID
+
+	rx_filter_install $h2 2 $GRP2
+
+	send_mc $GRP2 $GRP2_DMAC $SR_PCP
+	tc_check_packets "dev $h2 ingress" 2 0
+	check_err $? "foreign SR-class frame leaked while ingress filtering"
+
+	# Disarm the filter on swp1.
+	sr_filter $swp1 off
+
+	send_mc $GRP2 $GRP2_DMAC $SR_PCP
+	tc_check_packets "dev $h2 ingress" 2 1
+	check_err $? "frame not delivered after filter flag cleared"
+
+	rx_filter_uninstall $h2 2
+
+	bridge mdb del dev br0 port $swp2 grp $GRP2 permanent vid $VID
+
+	log_test "MDB stream_reserved filtering disabled on port flag clear"
+}
+
+# The semantics are protocol-independent: a foreign IPv6/MLD group at SR class
+# is dropped at ingress, while best-effort is delivered.
+fwd_sr_ipv6_test()
+{
+	RET=0
+
+	sr_filter $swp1 on
+	bridge mdb add dev br0 port $swp2 grp $GRP6B permanent vid $VID
+	bridge mdb add dev br0 port $swp3 grp $GRP6B permanent vid $VID
+
+	rx_filter_install $h2 2 $GRP6B ipv6
+	rx_filter_install $h3 2 $GRP6B ipv6
+
+	send_mc6 $GRP6B $GRP6B_DMAC $SR_PCP
+	tc_check_packets "dev $h2 ingress" 2 0
+	check_err $? "foreign SR-class IPv6 frame leaked to a listener"
+	tc_check_packets "dev $h3 ingress" 2 0
+	check_err $? "foreign SR-class IPv6 frame leaked to a listener"
+
+	send_mc6 $GRP6B $GRP6B_DMAC $BE_PCP
+	tc_check_packets "dev $h2 ingress" 2 1
+	check_err $? "best-effort IPv6 frame not delivered"
+	tc_check_packets "dev $h3 ingress" 2 1
+	check_err $? "best-effort IPv6 frame not delivered"
+
+	rx_filter_uninstall $h3 2
+	rx_filter_uninstall $h2 2
+
+	bridge mdb del dev br0 port $swp3 grp $GRP6B permanent vid $VID
+	bridge mdb del dev br0 port $swp2 grp $GRP6B permanent vid $VID
+	sr_filter $swp1 off
+
+	log_test "MDB stream_reserved blocks foreign SR-class IPv6 group at ingress"
+}
+
+trap cleanup EXIT
+
+setup_prepare
+setup_wait
+
+if ! stream_reserved_supported; then
+	log_test_skip "MDB stream_reserved" \
+		"kernel or iproute2 lacks MDB_FLAGS_STREAM_RESERVED support"
+	exit $EXIT_STATUS
+fi
+
+tests_run
+
+exit $EXIT_STATUS
diff --git a/tools/testing/selftests/net/forwarding/config b/tools/testing/selftests/net/forwarding/config
index 75a6c3d3c1da3..d1fe9ec41340e 100644
--- a/tools/testing/selftests/net/forwarding/config
+++ b/tools/testing/selftests/net/forwarding/config
@@ -1,5 +1,6 @@
 CONFIG_BPF_SYSCALL=y
 CONFIG_BRIDGE=m
+CONFIG_BRIDGE_8021Q_SRP=y
 CONFIG_BRIDGE_IGMP_SNOOPING=y
 CONFIG_BRIDGE_VLAN_FILTERING=y
 CONFIG_CGROUP_BPF=y
@@ -40,6 +41,7 @@ CONFIG_NET_L3_MASTER_DEV=y
 CONFIG_NET_NS=y
 CONFIG_NET_SCH_ETS=m
 CONFIG_NET_SCH_INGRESS=m
+CONFIG_NET_SCH_MQPRIO=m
 CONFIG_NET_SCH_PRIO=m
 CONFIG_NET_SCH_RED=m
 CONFIG_NET_SCH_TBF=m

-- 
2.43.0


