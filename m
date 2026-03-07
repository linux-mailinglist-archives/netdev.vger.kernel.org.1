Return-Path: <netdev+bounces-265077-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNwCJ7auq2nmfQEAu9opvQ
	(envelope-from <netdev+bounces-265077-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 05:51:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDB922A262
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 05:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E0B930AB63A
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 04:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE5D3603CF;
	Sat,  7 Mar 2026 04:46:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6D2355F5C;
	Sat,  7 Mar 2026 04:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772858780; cv=none; b=Yxgc+p2RLUEg9NNGZ+p2Vt3q+2y9iJS1YjmWsZimqEomU5XYsjH9Bc09Vf24G0NqBX5BEDES7UwZLm0/73vcz5gzMv3YodRCt2FnXzR7aoigrfY8xHJsg1OJAx2bVA3DutZbgo39uCtkKXrfb0w1IIbEQ6xFdIxf7wqGATTtOSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772858780; c=relaxed/simple;
	bh=qEndSg74IrSsHyC+dBq6x34fpvQkg8HB8RGj8cYl2Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gsDo6U6dVMXHZefNfQ1/GWc92br6JTVdhUz4Rm1p/+sg9Nn36NpycAgzwh72QKimOPbiYwaiGCp8XiPnseRCYl2eLZiKIVUSDAHxxyNDud8ts98MG5beWhzAhaHq/NuLfCM6aVCeu7TLJtONqjPakxwmdoj1XAIJTBK2AgaqsQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 174B554C936;
	Sat,  7 Mar 2026 05:46:16 +0100 (CET)
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
	petrm@nvidia.com,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH net-next v4 11/14] net: bridge: mcast: track active state, prepare for outside lock reads
Date: Sat,  7 Mar 2026 05:45:45 +0100
Message-ID: <20260307044548.5230-12-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260307044548.5230-1-linus.luessing@c0d3.blue>
References: <20260307044548.5230-1-linus.luessing@c0d3.blue>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 5DDB922A262
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265077-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[c0d3.blue];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.867];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linus.luessing@c0d3.blue,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,blackwall.org,nvidia.com,lunn.ch,kernel.org,redhat.com,google.com,davemloft.net,fomichev.me,gmail.com,c0d3.blue];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[c0d3.blue:mid,c0d3.blue:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
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
 net/bridge/br_multicast.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index cb78f9555db6..6faa484dede7 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1085,9 +1085,10 @@ static void br_ip4_multicast_update_active(struct net_bridge_mcast *brmctx,
 					   bool force_inactive)
 {
 	if (force_inactive)
-		brmctx->ip4_active = false;
+		WRITE_ONCE(brmctx->ip4_active, false);
 	else
-		brmctx->ip4_active = br_ip4_multicast_querier_exists(brmctx);
+		WRITE_ONCE(brmctx->ip4_active,
+			   br_ip4_multicast_querier_exists(brmctx));
 }
 
 static void br_ip6_multicast_update_active(struct net_bridge_mcast *brmctx,
@@ -1095,23 +1096,26 @@ static void br_ip6_multicast_update_active(struct net_bridge_mcast *brmctx,
 {
 #if IS_ENABLED(CONFIG_IPV6)
 	if (force_inactive)
-		brmctx->ip6_active = false;
+		WRITE_ONCE(brmctx->ip6_active, false);
 	else
-		brmctx->ip6_active = br_ip6_multicast_querier_exists(brmctx);
+		WRITE_ONCE(brmctx->ip6_active,
+			   br_ip6_multicast_querier_exists(brmctx));
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
@@ -4269,7 +4273,7 @@ void br_multicast_ctx_init(struct net_bridge *br,
 	brmctx->multicast_membership_interval = 260 * HZ;
 
 	brmctx->ip4_querier.port_ifidx = 0;
-	brmctx->ip4_active = 0;
+	WRITE_ONCE(brmctx->ip4_active, 0);
 	seqcount_spinlock_init(&brmctx->ip4_querier.seq, &br->multicast_lock);
 	brmctx->multicast_igmp_version = 2;
 #if IS_ENABLED(CONFIG_IPV6)
@@ -4277,7 +4281,7 @@ void br_multicast_ctx_init(struct net_bridge *br,
 	brmctx->ip6_querier.port_ifidx = 0;
 	seqcount_spinlock_init(&brmctx->ip6_querier.seq, &br->multicast_lock);
 #endif
-	brmctx->ip6_active = 0;
+	WRITE_ONCE(brmctx->ip6_active, 0);
 
 	timer_setup(&brmctx->ip4_mc_router_timer, NULL, 0);
 	timer_setup(&brmctx->ip4_other_query.timer, NULL, 0);
-- 
2.53.0


