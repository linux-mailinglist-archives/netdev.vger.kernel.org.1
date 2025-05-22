Return-Path: <netdev+bounces-192836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB099AC1554
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 22:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 336D11747F7
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 20:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219D62C0301;
	Thu, 22 May 2025 20:07:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DEF1C5F37;
	Thu, 22 May 2025 20:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747944434; cv=none; b=UJ3fLl6vMYC/zBZcHz9NaCDrgJrBS8Ww+Ctq93Hw8QM70xXSCOqGsFMukmcKKDyELxV9JNrnb4jUQq13qwIUNnYQ7P5O0v8N6LmCz1elKUfcW7qD/ahniz7kBrOhVDynHpS5p4I4eE/bogLOOqkcxGLiHG3CzCFoNLayBkYfXlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747944434; c=relaxed/simple;
	bh=O4tz9mowo94/3T3W6l3LeOmM7TMz65unkbTJRarvkeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LbF7ezS+Ij9zHqIG/tvvODIcva99Dc6L8KRonzhC21H0l099sTrYDUIwT3EbLRmH9MJngQu2qLaC4mySq3mmNMvl8lVz+PuGAp70KKVRrZzkjlyGuL8ZEt0VD9MDTH+jHTkr1Y+wE58HkCq6d8eNXtcdoNE0um2Wwq+umSBo9g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7720154E72C;
	Thu, 22 May 2025 22:00:12 +0200 (CEST)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: bridge@lists.linux.dev
Cc: netdev@vger.kernel.org,
	openwrt-devel@lists.openwrt.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Ivan Vecera <ivecera@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jonathan Corbet <corbet@lwn.net>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	Markus Stockhausen <markus.stockhausen@gmx.de>,
	Jan Hoffmann <jan.christian.hoffmann@gmail.com>,
	Birger Koblitz <git@birger-koblitz.de>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH net-next 2/5] net: bridge: mcast: export ip{4,6}_active state to netlink
Date: Thu, 22 May 2025 21:17:04 +0200
Message-ID: <20250522195952.29265-3-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250522195952.29265-1-linus.luessing@c0d3.blue>
References: <20250522195952.29265-1-linus.luessing@c0d3.blue>
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
index a5b743a2f775..fe26646c38c8 100644
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
index 318386cc5b0d..41f6c461ab32 100644
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
+ *   Bridge IPv4 mcast active state, read only.
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
index 6e337937d0d7..7829d2842851 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1264,7 +1264,9 @@ static const struct nla_policy br_policy[IFLA_BR_MAX + 1] = {
 	[IFLA_BR_VLAN_STATS_ENABLED] = { .type = NLA_U8 },
 	[IFLA_BR_MCAST_STATS_ENABLED] = { .type = NLA_U8 },
 	[IFLA_BR_MCAST_IGMP_VERSION] = { .type = NLA_U8 },
+	[IFLA_BR_MCAST_ACTIVE_V4] = { .type = NLA_U8 },
 	[IFLA_BR_MCAST_MLD_VERSION] = { .type = NLA_U8 },
+	[IFLA_BR_MCAST_ACTIVE_V6] = { .type = NLA_U8 },
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
index 8fa89b04ee94..a97657be51a7 100644
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
+	[BRIDGE_VLANDB_GOPTS_MCAST_ACTIVE_V6]	= { .type = NLA_U8 },
 	[BRIDGE_VLANDB_GOPTS_MCAST_QUERY_INTVL]	= { .type = NLA_U64 },
 	[BRIDGE_VLANDB_GOPTS_MCAST_QUERIER]	= { .type = NLA_U8 },
 	[BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION]	= { .type = NLA_U8 },
+	[BRIDGE_VLANDB_GOPTS_MCAST_ACTIVE_V4]	= { .type = NLA_U8 },
 	[BRIDGE_VLANDB_GOPTS_MCAST_LAST_MEMBER_CNT]	= { .type = NLA_U32 },
 	[BRIDGE_VLANDB_GOPTS_MCAST_STARTUP_QUERY_CNT]	= { .type = NLA_U32 },
 	[BRIDGE_VLANDB_GOPTS_MCAST_LAST_MEMBER_INTVL]	= { .type = NLA_U64 },
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index c5a7f41982a5..dee32084be59 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -62,7 +62,7 @@
 
 #include "dev.h"
 
-#define RTNL_MAX_TYPE		50
+#define RTNL_MAX_TYPE		52
 #define RTNL_SLAVE_MAX_TYPE	44
 
 struct rtnl_link {
-- 
2.49.0


