Return-Path: <netdev+bounces-262504-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EaOFvIjpWm14AUAu9opvQ
	(envelope-from <netdev+bounces-262504-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 06:45:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F4D1D3333
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 06:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0928330528BF
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 05:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6587D33A01E;
	Mon,  2 Mar 2026 05:40:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C151A324718;
	Mon,  2 Mar 2026 05:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772430059; cv=none; b=ARls/8WrQJzZ2XEz6N399KhWMOmifIngdUTxd2FBl/0I0JHH70WU54QhMEPR0AQVD3pkPvYm9fBIYS5L+Ph9e23P9kBJvyTuH1m27yTwUB6Xq9452iA6bAcALuaK2prxqnmdD8RPYAxQ+AMrgkLxkBSHOgbNv8pMV8MSthO6/cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772430059; c=relaxed/simple;
	bh=jvBSBWd5IWs/b49CVRn+6ZYlDfgfqyySBV3Fm4/20+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jMftndo9Ff23VFqeO0cMpdaIMXCfF5AXbQUbMmOg9jqfyBjshtDypwKCTM0mBaZBh9X7fMGwbMThiWpgrSf3LbEn3w//nisGML8kcmThEmemHA6lEmfu/jtAMZcrGdzfqgVriuM+cBkrn9VnGPvg19Fa5OMpcCGJRoSzeTWXg7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8128C54CC77;
	Mon,  2 Mar 2026 06:40:55 +0100 (CET)
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
Subject: [PATCH net-next v3 11/14] net: bridge: mcast: track active state, prepare for outside lock reads
Date: Mon,  2 Mar 2026 06:40:05 +0100
Message-ID: <20260302054008.21638-12-linus.luessing@c0d3.blue>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262504-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.954];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linus.luessing@c0d3.blue,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,blackwall.org,nvidia.com,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com,c0d3.blue];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,c0d3.blue:mid,c0d3.blue:email]
X-Rspamd-Queue-Id: A4F4D1D3333
X-Rspamd-Action: no action

We are updating ip{4,6}_active and check all variables their state relies
on while holding the bridge multicast spinlock. However we are going to
read it without this lock in a follow-up commit on fast/data path, too.

As these variables are only booleans this shouldn't be a problem,
ip{4,6}_active will be loaded and stored atomically. And those
read sides should converge eventually. But to allow tooling to verify
this use the READ_ONCE() and WRITE_ONCE macros.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/bridge/br_multicast.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 8eedb98378b6..715a0e0aa5ad 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1083,9 +1083,9 @@ static void br_ip4_multicast_update_active(struct net_bridge_mcast *brmctx,
 					   bool force_inactive)
 {
 	if (force_inactive)
-		brmctx->ip4_active = false;
+		WRITE_ONCE(brmctx->ip4_active, false);
 	else
-		brmctx->ip4_active = br_ip4_multicast_querier_exists(brmctx);
+		WRITE_ONCE(brmctx->ip4_active, br_ip4_multicast_querier_exists(brmctx));
 }
 
 static void br_ip6_multicast_update_active(struct net_bridge_mcast *brmctx,
@@ -1093,23 +1093,25 @@ static void br_ip6_multicast_update_active(struct net_bridge_mcast *brmctx,
 {
 #if IS_ENABLED(CONFIG_IPV6)
 	if (force_inactive)
-		brmctx->ip6_active = false;
+		WRITE_ONCE(brmctx->ip6_active, false);
 	else
-		brmctx->ip6_active = br_ip6_multicast_querier_exists(brmctx);
+		WRITE_ONCE(brmctx->ip6_active, br_ip6_multicast_querier_exists(brmctx));
 #endif
 }
 
 static void br_multicast_notify_active(struct net_bridge_mcast *brmctx,
 				       bool ip4_active_old, bool ip6_active_old)
 {
-	if (brmctx->ip4_active == ip4_active_old &&
-	    brmctx->ip6_active == ip6_active_old)
+	int ip4_active = brmctx->ip4_active;
+	int ip6_active = brmctx->ip6_active;
+
+	if (ip4_active == ip4_active_old &&
+	    ip6_active == ip6_active_old)
 		return;
 
 	br_debug(brmctx->br, "mc_active changed, vid: %i: v4: %i->%i, v6: %i->%i\n",
 		 brmctx->vlan ? brmctx->vlan->vid : -1,
-		 ip4_active_old, brmctx->ip4_active,
-		 ip6_active_old, brmctx->ip6_active);
+		 ip4_active_old, ip4_active, ip6_active_old, ip6_active);
 }
 
 /**
@@ -1134,7 +1136,8 @@ static void br_multicast_notify_active(struct net_bridge_mcast *brmctx,
  */
 static void br_multicast_update_active(struct net_bridge_mcast *brmctx)
 {
-	bool ip4_active_old = brmctx->ip4_active, ip6_active_old = brmctx->ip6_active;
+	bool ip4_active_old = brmctx->ip4_active;
+	bool ip6_active_old = brmctx->ip6_active;
 	bool force_inactive = false;
 
 	lockdep_assert_held_once(&brmctx->br->multicast_lock);
@@ -4261,13 +4264,13 @@ void br_multicast_ctx_init(struct net_bridge *br,
 	brmctx->multicast_membership_interval = 260 * HZ;
 
 	brmctx->ip4_querier.port_ifidx = 0;
-	brmctx->ip4_active = 0;
+	WRITE_ONCE(brmctx->ip4_active, 0);
 	seqcount_spinlock_init(&brmctx->ip4_querier.seq, &br->multicast_lock);
 	brmctx->multicast_igmp_version = 2;
 #if IS_ENABLED(CONFIG_IPV6)
 	brmctx->multicast_mld_version = 1;
 	brmctx->ip6_querier.port_ifidx = 0;
-	brmctx->ip6_active = 0;
+	WRITE_ONCE(brmctx->ip6_active, 0);
 	seqcount_spinlock_init(&brmctx->ip6_querier.seq, &br->multicast_lock);
 #endif
 
-- 
2.51.0


