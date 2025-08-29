Return-Path: <netdev+bounces-218171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C69B3B682
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 10:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5501E1C87A55
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 08:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C85C2C3272;
	Fri, 29 Aug 2025 08:57:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4062BE63A;
	Fri, 29 Aug 2025 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756457869; cv=none; b=c0tWvP2R8av4zLT+8hdGbGg0UJY9c1+z3YOGVLF/2Wm8VT4y7hSsz+YBA8cq5qLUKz5mxODgP+N8GN4bmdBWfilRE4wMGdtTmoeeZiReGMhzE8Pa8giq2St0+ncnCLWnA7maV+BwQlyRWilvpvA34G3JQ23360H/rMRhWvVt0KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756457869; c=relaxed/simple;
	bh=bQOvgOoppceBzTNV4VcTZG5BOPE1ySioEcjDqcVOOkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ohCtOUT1a5ZF3FgWRNXv94o5wCD+HqbscFFqRo9RpCqFcLYiVztF/EIkxxjvZZgsWSLkuvkNz2MyWyHn+wkySauiqYy2HUgq0+B+3S2R+7DLxPftgx6sd8bMTKg9UvInwgFaFWlydM5wXnjsV7S3CpCPcnddoo3zWicnPkis88I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 60F9454F6B8;
	Fri, 29 Aug 2025 10:57:41 +0200 (CEST)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: bridge@lists.linux.dev
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH 5/9] net: bridge: mcast: export ip{4,6}_active state to netlink
Date: Fri, 29 Aug 2025 10:53:46 +0200
Message-ID: <20250829085724.24230-6-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250829085724.24230-1-linus.luessing@c0d3.blue>
References: <20250829085724.24230-1-linus.luessing@c0d3.blue>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Export the new ip{4,6}_active variables to netlink, to be able to
check from userspace that they are updated as intended.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 include/uapi/linux/if_bridge.h |  2 ++
 include/uapi/linux/if_link.h   | 12 ++++++++++++
 net/bridge/br_netlink.c        | 10 +++++++++-
 net/bridge/br_vlan_options.c   | 10 +++++++++-
 net/core/rtnetlink.c           |  2 +-
 5 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index 73876c0e2bba..c4d92df8d374 100644
--- a/include/uapi/linux/if_bridge.h
+++ b/include/uapi/linux/if_bridge.h
@@ -584,6 +584,8 @@ enum {
 	BRIDGE_VLANDB_GOPTS_MCAST_ROUTER_PORTS,
 	BRIDGE_VLANDB_GOPTS_MCAST_QUERIER_STATE,
 	BRIDGE_VLANDB_GOPTS_MSTI,
+	BRIDGE_VLANDB_GOPTS_MCAST_ACTIVE_V4,
+	BRIDGE_VLANDB_GOPTS_MCAST_ACTIVE_V6,
 	__BRIDGE_VLANDB_GOPTS_MAX
 };
 #define BRIDGE_VLANDB_GOPTS_MAX (__BRIDGE_VLANDB_GOPTS_MAX - 1)
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index 784ace3a519c..fcf2c42aa6c4 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -742,6 +742,16 @@ enum in6_addr_gen_mode {
  * @IFLA_BR_FDB_MAX_LEARNED
  *   Set the number of max dynamically learned FDB entries for the current
  *   bridge.
+ *
+ * @IFLA_BR_MCAST_ACTIVE_V4
+ *   Bridge IPv4 mcast active state, read only.
+ *
+ *   1 if an IGMP querier is present, 0 otherwise.
+ *
+ * @IFLA_BR_MCAST_ACTIVE_V6
+ *   Bridge IPv6 mcast active state, read only.
+ *
+ *   1 if an MLD querier is present, 0 otherwise.
  */
 enum {
 	IFLA_BR_UNSPEC,
@@ -794,6 +804,8 @@ enum {
 	IFLA_BR_MCAST_QUERIER_STATE,
 	IFLA_BR_FDB_N_LEARNED,
 	IFLA_BR_FDB_MAX_LEARNED,
+	IFLA_BR_MCAST_ACTIVE_V4,
+	IFLA_BR_MCAST_ACTIVE_V6,
 	__IFLA_BR_MAX,
 };
 
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 4e2d53b27221..5aa1721830d6 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1264,7 +1264,9 @@ static const struct nla_policy br_policy[IFLA_BR_MAX + 1] = {
 	[IFLA_BR_VLAN_STATS_ENABLED] = { .type = NLA_U8 },
 	[IFLA_BR_MCAST_STATS_ENABLED] = { .type = NLA_U8 },
 	[IFLA_BR_MCAST_IGMP_VERSION] = { .type = NLA_U8 },
+	[IFLA_BR_MCAST_ACTIVE_V4] = { .type = NLA_REJECT },
 	[IFLA_BR_MCAST_MLD_VERSION] = { .type = NLA_U8 },
+	[IFLA_BR_MCAST_ACTIVE_V6] = { .type = NLA_REJECT },
 	[IFLA_BR_VLAN_STATS_PER_PORT] = { .type = NLA_U8 },
 	[IFLA_BR_MULTI_BOOLOPT] =
 		NLA_POLICY_EXACT_LEN(sizeof(struct br_boolopt_multi)),
@@ -1625,7 +1627,9 @@ static size_t br_get_size(const struct net_device *brdev)
 	       nla_total_size_64bit(sizeof(u64)) + /* IFLA_BR_MCAST_QUERY_RESPONSE_INTVL */
 	       nla_total_size_64bit(sizeof(u64)) + /* IFLA_BR_MCAST_STARTUP_QUERY_INTVL */
 	       nla_total_size(sizeof(u8)) +	/* IFLA_BR_MCAST_IGMP_VERSION */
+	       nla_total_size(sizeof(u8)) +     /* IFLA_BR_MCAST_ACTIVE_V4 */
 	       nla_total_size(sizeof(u8)) +	/* IFLA_BR_MCAST_MLD_VERSION */
+	       nla_total_size(sizeof(u8)) +     /* IFLA_BR_MCAST_ACTIVE_V6 */
 	       br_multicast_querier_state_size() + /* IFLA_BR_MCAST_QUERIER_STATE */
 #endif
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
@@ -1717,12 +1721,16 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
 			br->multicast_ctx.multicast_startup_query_count) ||
 	    nla_put_u8(skb, IFLA_BR_MCAST_IGMP_VERSION,
 		       br->multicast_ctx.multicast_igmp_version) ||
+	    nla_put_u8(skb, IFLA_BR_MCAST_ACTIVE_V4,
+		       br->multicast_ctx.ip4_active) ||
 	    br_multicast_dump_querier_state(skb, &br->multicast_ctx,
 					    IFLA_BR_MCAST_QUERIER_STATE))
 		return -EMSGSIZE;
 #if IS_ENABLED(CONFIG_IPV6)
 	if (nla_put_u8(skb, IFLA_BR_MCAST_MLD_VERSION,
-		       br->multicast_ctx.multicast_mld_version))
+		       br->multicast_ctx.multicast_mld_version) ||
+	    nla_put_u8(skb, IFLA_BR_MCAST_ACTIVE_V6,
+		       br->multicast_ctx.ip6_active))
 		return -EMSGSIZE;
 #endif
 	clockval = jiffies_to_clock_t(br->multicast_ctx.multicast_last_member_interval);
diff --git a/net/bridge/br_vlan_options.c b/net/bridge/br_vlan_options.c
index 8fa89b04ee94..33f055d3a304 100644
--- a/net/bridge/br_vlan_options.c
+++ b/net/bridge/br_vlan_options.c
@@ -369,6 +369,8 @@ bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
 		       !!(v_opts->priv_flags & BR_VLFLAG_GLOBAL_MCAST_ENABLED)) ||
 	    nla_put_u8(skb, BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION,
 		       v_opts->br_mcast_ctx.multicast_igmp_version) ||
+	    nla_put_u8(skb, BRIDGE_VLANDB_GOPTS_MCAST_ACTIVE_V4,
+		       v_opts->br_mcast_ctx.ip4_active) ||
 	    nla_put_u32(skb, BRIDGE_VLANDB_GOPTS_MCAST_LAST_MEMBER_CNT,
 			v_opts->br_mcast_ctx.multicast_last_member_count) ||
 	    nla_put_u32(skb, BRIDGE_VLANDB_GOPTS_MCAST_STARTUP_QUERY_CNT,
@@ -423,7 +425,9 @@ bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
 
 #if IS_ENABLED(CONFIG_IPV6)
 	if (nla_put_u8(skb, BRIDGE_VLANDB_GOPTS_MCAST_MLD_VERSION,
-		       v_opts->br_mcast_ctx.multicast_mld_version))
+		       v_opts->br_mcast_ctx.multicast_mld_version) ||
+	    nla_put_u8(skb, BRIDGE_VLANDB_GOPTS_MCAST_ACTIVE_V6,
+		       v_opts->br_mcast_ctx.ip4_active))
 		goto out_err;
 #endif
 #endif
@@ -448,7 +452,9 @@ static size_t rtnl_vlan_global_opts_nlmsg_size(const struct net_bridge_vlan *v)
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
 		+ nla_total_size(sizeof(u8)) /* BRIDGE_VLANDB_GOPTS_MCAST_SNOOPING */
 		+ nla_total_size(sizeof(u8)) /* BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION */
+		+ nla_total_size(sizeof(u8)) /* BRIDGE_VLANDB_GOPTS_MCAST_ACTIVE_V4 */
 		+ nla_total_size(sizeof(u8)) /* BRIDGE_VLANDB_GOPTS_MCAST_MLD_VERSION */
+		+ nla_total_size(sizeof(u8)) /* BRIDGE_VLANDB_GOPTS_MCAST_ACTIVE_V6 */
 		+ nla_total_size(sizeof(u32)) /* BRIDGE_VLANDB_GOPTS_MCAST_LAST_MEMBER_CNT */
 		+ nla_total_size(sizeof(u32)) /* BRIDGE_VLANDB_GOPTS_MCAST_STARTUP_QUERY_CNT */
 		+ nla_total_size(sizeof(u64)) /* BRIDGE_VLANDB_GOPTS_MCAST_LAST_MEMBER_INTVL */
@@ -630,9 +636,11 @@ static const struct nla_policy br_vlan_db_gpol[BRIDGE_VLANDB_GOPTS_MAX + 1] = {
 	[BRIDGE_VLANDB_GOPTS_RANGE]	= { .type = NLA_U16 },
 	[BRIDGE_VLANDB_GOPTS_MCAST_SNOOPING]	= { .type = NLA_U8 },
 	[BRIDGE_VLANDB_GOPTS_MCAST_MLD_VERSION]	= { .type = NLA_U8 },
+	[BRIDGE_VLANDB_GOPTS_MCAST_ACTIVE_V6]	= { .type = NLA_REJECT },
 	[BRIDGE_VLANDB_GOPTS_MCAST_QUERY_INTVL]	= { .type = NLA_U64 },
 	[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER]	= { .type = NLA_U8 },
 	[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION]	= { .type = NLA_U8 },
+	[BRIDGE_VLANDB_GOPTS_MCAST_ACTIVE_V4]	= { .type = NLA_REJECT },
 	[BRIDGE_VLANDB_GOPTS_MCAST_LAST_MEMBER_CNT]	= { .type = NLA_U32 },
 	[BRIDGE_VLANDB_GOPTS_MCAST_STARTUP_QUERY_CNT]	= { .type = NLA_U32 },
 	[BRIDGE_VLANDB_GOPTS_MCAST_LAST_MEMBER_INTVL]	= { .type = NLA_U64 },
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 094b085cff20..cb24370b719f 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -62,7 +62,7 @@
 
 #include "dev.h"
 
-#define RTNL_MAX_TYPE		50
+#define RTNL_MAX_TYPE		52
 #define RTNL_SLAVE_MAX_TYPE	44
 
 struct rtnl_link {
-- 
2.50.1


