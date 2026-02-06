Return-Path: <netdev+bounces-257417-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGo1FJ9ZhWnNAQQAu9opvQ
	(envelope-from <netdev+bounces-257417-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:01:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBDFF97E6
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 051C3302F6BF
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 03:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5061829A322;
	Fri,  6 Feb 2026 03:01:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB34E2773F0;
	Fri,  6 Feb 2026 03:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770346899; cv=none; b=ixFVCU20+zELQxpqc8zyHvQovbpuIwmUY1BQveCrnMBTdcOcxOwnAnXreUKiccbExfZhUWdYa/CQUuaLWvs29Rp6Yvw1p2PchRmSI/OG37Oht/9p910MpdsClLg1nhhQrstVrP1pzJEFtp1vCu63+2X7nUNlx5M12UKBLK8J8qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770346899; c=relaxed/simple;
	bh=dz0XB9CYvpy8wlOF/lmO9X6VavxLxXyiD3askDODYG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BNqkb9zWSJl6RXCoCeCHRkR0k6w6XaYLtrxufw/DYbuLrbrnBoX2MEIeeSu59ov2UtCynJ9PjddO3IMFXBbMCgqnEqjwz6aCZD56SDylNaMBqOdtlPUPaKXRO18fUSO7hrLlKZ4sW3dVVKCkMZtFCvO9eePKfUDZ9ImeI+lpvC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2FB3A54CCE1;
	Fri,  6 Feb 2026 04:01:36 +0100 (CET)
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
Subject: [PATCH net-next v2 01/14] net: bridge: mcast: export ip{4,6}_active state to netlink
Date: Fri,  6 Feb 2026 03:52:07 +0100
Message-ID: <20260206030123.5430-2-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260206030123.5430-1-linus.luessing@c0d3.blue>
References: <20260206030123.5430-1-linus.luessing@c0d3.blue>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257417-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[c0d3.blue];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.982];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linus.luessing@c0d3.blue,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,blackwall.org,nvidia.com,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com,c0d3.blue];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[c0d3.blue:mid,c0d3.blue:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BDBDFF97E6
X-Rspamd-Action: no action

Export the new ip{4,6}_active variables to netlink, to be able to
check from userspace that they are updated as intended.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 include/uapi/linux/if_bridge.h |  2 ++
 include/uapi/linux/if_link.h   | 12 ++++++++++++
 net/bridge/br_netlink.c        | 16 +++++++++++++++-
 net/bridge/br_private.h        |  2 +-
 net/bridge/br_vlan_options.c   | 22 ++++++++++++++++++++--
 net/core/rtnetlink.c           |  2 +-
 6 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
index e52f8207ab27..910103b1ef03 100644
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
index e9b5f79e1ee1..3cb040aaa8dc 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -744,6 +744,16 @@ enum in6_addr_gen_mode {
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
@@ -796,6 +806,8 @@ enum {
 	IFLA_BR_MCAST_QUERIER_STATE,
 	IFLA_BR_FDB_N_LEARNED,
 	IFLA_BR_FDB_MAX_LEARNED,
+	IFLA_BR_MCAST_ACTIVE_V4,
+	IFLA_BR_MCAST_ACTIVE_V6,
 	__IFLA_BR_MAX,
 };
 
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 0264730938f4..1b5ab1fb4558 100644
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
@@ -1646,6 +1650,8 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
 	u32 ageing_time = jiffies_to_clock_t(br->ageing_time);
 	u32 stp_enabled = br->stp_enabled;
 	u16 priority = (br->bridge_id.prio[0] << 8) | br->bridge_id.prio[1];
+	struct ethhdr eth6 = { .h_proto = htons(ETH_P_IPV6) };
+	struct ethhdr eth4 = { .h_proto = htons(ETH_P_IP) };
 	u8 vlan_enabled = br_vlan_enabled(br->dev);
 	struct br_boolopt_multi bm;
 	u64 clockval;
@@ -1717,12 +1723,20 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
 			br->multicast_ctx.multicast_startup_query_count) ||
 	    nla_put_u8(skb, IFLA_BR_MCAST_IGMP_VERSION,
 		       br->multicast_ctx.multicast_igmp_version) ||
+	    nla_put_u8(skb, IFLA_BR_MCAST_ACTIVE_V4,
+		       netif_running(brdev) && br_opt_get(br, BROPT_MULTICAST_ENABLED) &&
+		       !br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED) &&
+		       br_multicast_querier_exists(&br->multicast_ctx, &eth4, NULL)) ||
 	    br_multicast_dump_querier_state(skb, &br->multicast_ctx,
 					    IFLA_BR_MCAST_QUERIER_STATE))
 		return -EMSGSIZE;
 #if IS_ENABLED(CONFIG_IPV6)
 	if (nla_put_u8(skb, IFLA_BR_MCAST_MLD_VERSION,
-		       br->multicast_ctx.multicast_mld_version))
+		       br->multicast_ctx.multicast_mld_version) ||
+	    nla_put_u8(skb, IFLA_BR_MCAST_ACTIVE_V6,
+		       netif_running(brdev) && br_opt_get(br, BROPT_MULTICAST_ENABLED) &&
+		       !br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED) &&
+		       br_multicast_querier_exists(&br->multicast_ctx, &eth6, NULL)))
 		return -EMSGSIZE;
 #endif
 	clockval = jiffies_to_clock_t(br->multicast_ctx.multicast_last_member_interval);
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index b9b2981c4841..4ab6a1f58116 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1892,7 +1892,7 @@ int br_vlan_rtm_process_global_options(struct net_device *dev,
 bool br_vlan_global_opts_can_enter_range(const struct net_bridge_vlan *v_curr,
 					 const struct net_bridge_vlan *r_end);
 bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
-			      const struct net_bridge_vlan *v_opts);
+			      struct net_bridge_vlan *v_opts);
 
 /* vlan state manipulation helpers using *_ONCE to annotate lock-free access,
  * while br_vlan_set_state() may access data protected by multicast_lock.
diff --git a/net/bridge/br_vlan_options.c b/net/bridge/br_vlan_options.c
index 8fa89b04ee94..6425fa509b95 100644
--- a/net/bridge/br_vlan_options.c
+++ b/net/bridge/br_vlan_options.c
@@ -347,8 +347,10 @@ bool br_vlan_global_opts_can_enter_range(const struct net_bridge_vlan *v_curr,
 }
 
 bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
-			      const struct net_bridge_vlan *v_opts)
+			      struct net_bridge_vlan *v_opts)
 {
+	struct ethhdr eth6 = { .h_proto = htons(ETH_P_IPV6) };
+	struct ethhdr eth4 = { .h_proto = htons(ETH_P_IP) };
 	struct nlattr *nest2 __maybe_unused;
 	u64 clockval __maybe_unused;
 	struct nlattr *nest;
@@ -369,6 +371,12 @@ bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
 		       !!(v_opts->priv_flags & BR_VLFLAG_GLOBAL_MCAST_ENABLED)) ||
 	    nla_put_u8(skb, BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION,
 		       v_opts->br_mcast_ctx.multicast_igmp_version) ||
+	    nla_put_u8(skb, BRIDGE_VLANDB_GOPTS_MCAST_ACTIVE_V4,
+		       netif_running(v_opts->br->dev) &&
+		       br_opt_get(v_opts->br, BROPT_MULTICAST_ENABLED) &&
+		       br_opt_get(v_opts->br, BROPT_MCAST_VLAN_SNOOPING_ENABLED) &&
+		       !br_multicast_ctx_vlan_global_disabled(&v_opts->br_mcast_ctx) &&
+		       br_multicast_querier_exists(&v_opts->br_mcast_ctx, &eth4, NULL)) ||
 	    nla_put_u32(skb, BRIDGE_VLANDB_GOPTS_MCAST_LAST_MEMBER_CNT,
 			v_opts->br_mcast_ctx.multicast_last_member_count) ||
 	    nla_put_u32(skb, BRIDGE_VLANDB_GOPTS_MCAST_STARTUP_QUERY_CNT,
@@ -423,7 +431,13 @@ bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
 
 #if IS_ENABLED(CONFIG_IPV6)
 	if (nla_put_u8(skb, BRIDGE_VLANDB_GOPTS_MCAST_MLD_VERSION,
-		       v_opts->br_mcast_ctx.multicast_mld_version))
+		       v_opts->br_mcast_ctx.multicast_mld_version) ||
+	    nla_put_u8(skb, BRIDGE_VLANDB_GOPTS_MCAST_ACTIVE_V6,
+		       netif_running(v_opts->br->dev) &&
+		       br_opt_get(v_opts->br, BROPT_MULTICAST_ENABLED) &&
+		       br_opt_get(v_opts->br, BROPT_MCAST_VLAN_SNOOPING_ENABLED) &&
+		       !br_multicast_ctx_vlan_global_disabled(&v_opts->br_mcast_ctx) &&
+		       br_multicast_querier_exists(&v_opts->br_mcast_ctx, &eth6, NULL)))
 		goto out_err;
 #endif
 #endif
@@ -448,7 +462,9 @@ static size_t rtnl_vlan_global_opts_nlmsg_size(const struct net_bridge_vlan *v)
 #ifdef CONFIG_BRIDGE_IGMP_SNOOPING
 		+ nla_total_size(sizeof(u8)) /* BRIDGE_VLANDB_GOPTS_MCAST_SNOOPING */
 		+ nla_total_size(sizeof(u8)) /* BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION */
+		+ nla_total_size(sizeof(u8)) /* BRIDGE_VLANDB_GOPTS_MCAST_ACTIVE_V4 */
 		+ nla_total_size(sizeof(u8)) /* BRIDGE_VLANDB_GOPTS_MCAST_MLD_VERSION */
+		+ nla_total_size(sizeof(u8)) /* BRIDGE_VLANDB_GOPTS_MCAST_ACTIVE_V6 */
 		+ nla_total_size(sizeof(u32)) /* BRIDGE_VLANDB_GOPTS_MCAST_LAST_MEMBER_CNT */
 		+ nla_total_size(sizeof(u32)) /* BRIDGE_VLANDB_GOPTS_MCAST_STARTUP_QUERY_CNT */
 		+ nla_total_size(sizeof(u64)) /* BRIDGE_VLANDB_GOPTS_MCAST_LAST_MEMBER_INTVL */
@@ -630,9 +646,11 @@ static const struct nla_policy br_vlan_db_gpol[BRIDGE_VLANDB_GOPTS_MAX + 1] = {
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
index b1ed55141d8a..7b29162e1f30 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -62,7 +62,7 @@
 
 #include "dev.h"
 
-#define RTNL_MAX_TYPE		50
+#define RTNL_MAX_TYPE		52
 #define RTNL_SLAVE_MAX_TYPE	44
 
 struct rtnl_link {
-- 
2.51.0


