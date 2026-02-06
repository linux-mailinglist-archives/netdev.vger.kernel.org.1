Return-Path: <netdev+bounces-257428-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPx+BOFZhWnNAQQAu9opvQ
	(envelope-from <netdev+bounces-257428-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:02:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C07DDF9822
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 99A093006685
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 03:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFDD2C21F9;
	Fri,  6 Feb 2026 03:01:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4408321CFE0;
	Fri,  6 Feb 2026 03:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770346911; cv=none; b=QIcb56XcX40ctlosYxqqXFQMR2irJRglxqlmhx14wfMKd4BAVg2BlP13niPrb2rSlY8ZiCpiqs3ZIhJfHdezimOYhhgm6bMK9E2WcjIEYenduGgqctNl4E/F36jdah7MEi85Te90sHmBEl9fL6LC5IZiS3Wohdc+7cuKhDRLPtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770346911; c=relaxed/simple;
	bh=e7gYPxwjXSvowlpp+bHbVcMmnV+svvWXurup9/rR6Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AZS2tfytnfG5Y7z5VRlLGJzqm/ocQ3ud0LmHRimm8eDS4y8FmaRtJH2gh94YVczYx18JDrVvmryf6QDE6wBcMDFWI0BK70VWi5PYEfur+zuoRhrfruxyoxMnWp8fYtMjmyksBYZf/xcc1AK8QbzVybi79XmKQRV6sGvkOjz9znE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4FBE754CD34;
	Fri,  6 Feb 2026 04:01:49 +0100 (CET)
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
Subject: [PATCH net-next v2 12/14] net: bridge: mcast: use combined active state in netlink
Date: Fri,  6 Feb 2026 03:52:18 +0100
Message-ID: <20260206030123.5430-13-linus.luessing@c0d3.blue>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257428-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.964];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linus.luessing@c0d3.blue,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,blackwall.org,nvidia.com,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com,c0d3.blue];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[c0d3.blue:mid,c0d3.blue:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C07DDF9822
X-Rspamd-Action: no action

Use the new multicast ip{4,6}_active variables for the netlink output.
The result for the user should be the same. But this allows us to check
that from userspace tests, to ensure that ip{4,6}_active behave as intended
for the upcoming fast/data path changes.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/bridge/br_netlink.c      | 10 ++--------
 net/bridge/br_private.h      |  2 +-
 net/bridge/br_vlan_options.c | 16 +++-------------
 3 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 1b5ab1fb4558..e79fddf747f8 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1650,8 +1650,6 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
 	u32 ageing_time = jiffies_to_clock_t(br->ageing_time);
 	u32 stp_enabled = br->stp_enabled;
 	u16 priority = (br->bridge_id.prio[0] << 8) | br->bridge_id.prio[1];
-	struct ethhdr eth6 = { .h_proto = htons(ETH_P_IPV6) };
-	struct ethhdr eth4 = { .h_proto = htons(ETH_P_IP) };
 	u8 vlan_enabled = br_vlan_enabled(br->dev);
 	struct br_boolopt_multi bm;
 	u64 clockval;
@@ -1724,9 +1722,7 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
 	    nla_put_u8(skb, IFLA_BR_MCAST_IGMP_VERSION,
 		       br->multicast_ctx.multicast_igmp_version) ||
 	    nla_put_u8(skb, IFLA_BR_MCAST_ACTIVE_V4,
-		       netif_running(brdev) && br_opt_get(br, BROPT_MULTICAST_ENABLED) &&
-		       !br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED) &&
-		       br_multicast_querier_exists(&br->multicast_ctx, &eth4, NULL)) ||
+		       READ_ONCE(br->multicast_ctx.ip4_active)) ||
 	    br_multicast_dump_querier_state(skb, &br->multicast_ctx,
 					    IFLA_BR_MCAST_QUERIER_STATE))
 		return -EMSGSIZE;
@@ -1734,9 +1730,7 @@ static int br_fill_info(struct sk_buff *skb, const struct net_device *brdev)
 	if (nla_put_u8(skb, IFLA_BR_MCAST_MLD_VERSION,
 		       br->multicast_ctx.multicast_mld_version) ||
 	    nla_put_u8(skb, IFLA_BR_MCAST_ACTIVE_V6,
-		       netif_running(brdev) && br_opt_get(br, BROPT_MULTICAST_ENABLED) &&
-		       !br_opt_get(br, BROPT_MCAST_VLAN_SNOOPING_ENABLED) &&
-		       br_multicast_querier_exists(&br->multicast_ctx, &eth6, NULL)))
+		       READ_ONCE(br->multicast_ctx.ip6_active)))
 		return -EMSGSIZE;
 #endif
 	clockval = jiffies_to_clock_t(br->multicast_ctx.multicast_last_member_interval);
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index 4cc59abdb8e1..8150ecc2c919 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1899,7 +1899,7 @@ int br_vlan_rtm_process_global_options(struct net_device *dev,
 bool br_vlan_global_opts_can_enter_range(const struct net_bridge_vlan *v_curr,
 					 const struct net_bridge_vlan *r_end);
 bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
-			      struct net_bridge_vlan *v_opts);
+			      const struct net_bridge_vlan *v_opts);
 
 /* vlan state manipulation helpers using *_ONCE to annotate lock-free access,
  * while br_vlan_set_state() may access data protected by multicast_lock.
diff --git a/net/bridge/br_vlan_options.c b/net/bridge/br_vlan_options.c
index 6425fa509b95..dcb214b5507d 100644
--- a/net/bridge/br_vlan_options.c
+++ b/net/bridge/br_vlan_options.c
@@ -347,10 +347,8 @@ bool br_vlan_global_opts_can_enter_range(const struct net_bridge_vlan *v_curr,
 }
 
 bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
-			      struct net_bridge_vlan *v_opts)
+			      const struct net_bridge_vlan *v_opts)
 {
-	struct ethhdr eth6 = { .h_proto = htons(ETH_P_IPV6) };
-	struct ethhdr eth4 = { .h_proto = htons(ETH_P_IP) };
 	struct nlattr *nest2 __maybe_unused;
 	u64 clockval __maybe_unused;
 	struct nlattr *nest;
@@ -372,11 +370,7 @@ bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
 	    nla_put_u8(skb, BRIDGE_VLANDB_GOPTS_MCAST_IGMP_VERSION,
 		       v_opts->br_mcast_ctx.multicast_igmp_version) ||
 	    nla_put_u8(skb, BRIDGE_VLANDB_GOPTS_MCAST_ACTIVE_V4,
-		       netif_running(v_opts->br->dev) &&
-		       br_opt_get(v_opts->br, BROPT_MULTICAST_ENABLED) &&
-		       br_opt_get(v_opts->br, BROPT_MCAST_VLAN_SNOOPING_ENABLED) &&
-		       !br_multicast_ctx_vlan_global_disabled(&v_opts->br_mcast_ctx) &&
-		       br_multicast_querier_exists(&v_opts->br_mcast_ctx, &eth4, NULL)) ||
+		       READ_ONCE(v_opts->br_mcast_ctx.ip4_active)) ||
 	    nla_put_u32(skb, BRIDGE_VLANDB_GOPTS_MCAST_LAST_MEMBER_CNT,
 			v_opts->br_mcast_ctx.multicast_last_member_count) ||
 	    nla_put_u32(skb, BRIDGE_VLANDB_GOPTS_MCAST_STARTUP_QUERY_CNT,
@@ -433,11 +427,7 @@ bool br_vlan_global_opts_fill(struct sk_buff *skb, u16 vid, u16 vid_range,
 	if (nla_put_u8(skb, BRIDGE_VLANDB_GOPTS_MCAST_MLD_VERSION,
 		       v_opts->br_mcast_ctx.multicast_mld_version) ||
 	    nla_put_u8(skb, BRIDGE_VLANDB_GOPTS_MCAST_ACTIVE_V6,
-		       netif_running(v_opts->br->dev) &&
-		       br_opt_get(v_opts->br, BROPT_MULTICAST_ENABLED) &&
-		       br_opt_get(v_opts->br, BROPT_MCAST_VLAN_SNOOPING_ENABLED) &&
-		       !br_multicast_ctx_vlan_global_disabled(&v_opts->br_mcast_ctx) &&
-		       br_multicast_querier_exists(&v_opts->br_mcast_ctx, &eth6, NULL)))
+		       READ_ONCE(v_opts->br_mcast_ctx.ip6_active)))
 		goto out_err;
 #endif
 #endif
-- 
2.51.0


