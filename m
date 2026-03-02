Return-Path: <netdev+bounces-262503-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOqRJrkjpWm14AUAu9opvQ
	(envelope-from <netdev+bounces-262503-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 06:44:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E871D3313
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 06:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8743930480E7
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 05:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DF5334681;
	Mon,  2 Mar 2026 05:40:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B09E32B9B6;
	Mon,  2 Mar 2026 05:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772430057; cv=none; b=VCsqEwm+vjKtvrk7yW8ANjT+zZxlLP4d609TokRk7rku/0+nWp3rsQplJPkSdc1M1n1PThkwDwL0HRW3qF6GPVTbtL53Yr50+oazwNmygzcATIPfmZl1P/mc0peJ1kDagAk0geJLr0woIYjfPURagIK4J4Zy6ZoZQKXAHsBzh/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772430057; c=relaxed/simple;
	bh=FM08I9KdPLzqTLMsfX00ulRCGnzCFAkdWqbtUs1yHH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XEGfnB+ofingALpR8M8rjzkD0NtVdbLY6vy94V6CXvy+BKlOhxCfgVpq5SDDPLsXJh9BdVgE4axfvFVzXIDCTvhAg4FimjMBqlNdHA/0RlJYkC3xBetN/UzTfZLkHu53B+gCMhoYIMY+49869nnsUTJfMIvFL2loKhJF+eRb33c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 50A1854CC71;
	Mon,  2 Mar 2026 06:40:54 +0100 (CET)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: bridge@lists.linux.dev
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
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
	shuah@kernel.org,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH net-next v3 10/14] net: bridge: mcast: track active state, bridge up/down
Date: Mon,  2 Mar 2026 06:40:04 +0100
Message-ID: <20260302054008.21638-11-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260302054008.21638-1-linus.luessing@c0d3.blue>
References: <20260302054008.21638-1-linus.luessing@c0d3.blue>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262503-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[c0d3.blue];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.956];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linus.luessing@c0d3.blue,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,blackwall.org,nvidia.com,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com,c0d3.blue];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,c0d3.blue:mid,c0d3.blue:email]
X-Rspamd-Queue-Id: 03E871D3313
X-Rspamd-Action: no action

This is mainly for switchdev and DSA later: To ensure that we switch
to inactive before destroying a bridge interface. A switchdev/DSA driver
might have allocated resources after we switched to an enabled multicast
active state. This gives switchdev/DSA drivers a chance to free these
resources again when we destroy the bridge (later).

Putting it into the ndo_stop / bridge interface down part instead of the
ndo_uninit / bridge destroy part though for a better semantic match. If
the bridge interface is down / stopped then it is also inactive.

No functional change for the fast/data path.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 include/uapi/linux/if_link.h |  8 ++++----
 net/bridge/br_multicast.c    | 12 ++++++++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index d963be8679b5..679368784643 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -748,14 +748,14 @@ enum in6_addr_gen_mode {
  * @IFLA_BR_MCAST_ACTIVE_V4
  *   Bridge IPv4 mcast active state, read only.
  *
- *   1 if *IFLA_BR_MCAST_SNOOPING* is enabled and an IGMP querier is present,
- *   0 otherwise.
+ *   1 if *IFLA_BR_MCAST_SNOOPING* is enabled, an IGMP querier is present
+ *   and the bridge interface is up, 0 otherwise.
  *
  * @IFLA_BR_MCAST_ACTIVE_V6
  *   Bridge IPv6 mcast active state, read only.
  *
- *   1 if *IFLA_BR_MCAST_SNOOPING* is enabled and an MLD querier is present,
- *   0 otherwise.
+ *   1 if *IFLA_BR_MCAST_SNOOPING* is enabled, an MLD querier is present
+ *   and the bridge interface is up, 0 otherwise.
  */
 enum {
 	IFLA_BR_UNSPEC,
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 02981bcbc389..8eedb98378b6 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1122,6 +1122,7 @@ static void br_multicast_notify_active(struct net_bridge_mcast *brmctx,
  *
  * The multicast active state is set, per protocol family, if:
  *
+ * - the bridge interface is up
  * - multicast snooping is enabled
  * - an IGMP/MLD querier is present
  * - for own IPv6 MLD querier: an IPv6 link-local address is configured on the bridge
@@ -1138,6 +1139,11 @@ static void br_multicast_update_active(struct net_bridge_mcast *brmctx)
 
 	lockdep_assert_held_once(&brmctx->br->multicast_lock);
 
+	if (!netif_running(brmctx->br->dev)) {
+		force_inactive = true;
+		goto update;
+	}
+
 	if (!br_opt_get(brmctx->br, BROPT_MULTICAST_ENABLED)) {
 		force_inactive = true;
 		goto update;
@@ -4405,6 +4411,9 @@ static void __br_multicast_open(struct net_bridge_mcast *brmctx)
 #if IS_ENABLED(CONFIG_IPV6)
 	__br_multicast_open_query(brmctx->br, &brmctx->ip6_own_query);
 #endif
+
+	/* bridge interface is up, maybe set multicast state to active */
+	br_multicast_update_active(brmctx);
 }
 
 static void br_multicast_open_locked(struct net_bridge *br)
@@ -4452,6 +4461,9 @@ static void __br_multicast_stop(struct net_bridge_mcast *brmctx)
 	timer_shutdown(&brmctx->ip6_other_query.delay_timer);
 	timer_shutdown(&brmctx->ip6_own_query.timer);
 #endif
+
+	/* bridge interface is down, set multicast state to inactive */
+	br_multicast_update_active(brmctx);
 }
 
 void br_multicast_update_vlan_mcast_ctx(struct net_bridge_vlan *v, u8 state)
-- 
2.51.0


