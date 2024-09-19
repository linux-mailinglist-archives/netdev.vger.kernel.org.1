Return-Path: <netdev+bounces-128910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D93797C670
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 10:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0D6B282F22
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 08:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53A01991D8;
	Thu, 19 Sep 2024 08:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="wATe4rx+"
X-Original-To: netdev@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11491991AB;
	Thu, 19 Sep 2024 08:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726736343; cv=none; b=CWTQUkhSNLBVfSYCULIhG7rLNSO3vTqjkMZIE0nioK+jspPpxvJYkJUmFSVs/E/g/gNMxOGOvBSl0jNRxy647CXe0DZLRgVvvuRXOEuuSUWmak/mrcBUdy2c7F0WlxS6t5QTuRzwn3BKJhYE9zKbyqCvWLu6JJw2NEFp8kYcSIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726736343; c=relaxed/simple;
	bh=L7QGvSkLKo+9WVpQ8DHQ2y3WVAdH+jWwUDMJ6EiZ+Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YmXnnbXYNiGgLk0b06qiJ7STAU8fJEuEzobRRKmkYeqrtytoCyEO7i87cvsfEARJp4duVP7uQCbRWd3x0zfnb6Se1R3LQrNId3IzNV0TiITT3KPlyrSwGKk+zOuhzTe3Qr7qHyeG9BBygr9G9/7QmF/fdvh9DErfb3L/80tQR9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=wATe4rx+; arc=none smtp.client-ip=212.42.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1726736337; bh=L7QGvSkLKo+9WVpQ8DHQ2y3WVAdH+jWwUDMJ6EiZ+Vo=;
	h=From:To:Cc:Subject:Date:Reply-To:From;
	b=wATe4rx+Aih0Dii7vZhdiFZUwjBRoTDyhQ2PcHNBdNIHyGbCdOL3NgbzuLcGWmZc2
	 7+wEgQdJLNSRWc6YS1goHMp5mw2oAeH1nZPio2zjWe4NlImFJyWcJgIbmhVqwDGC02
	 p/ooeKM/QYvB3OB3oacaCmGLgqNMF35TjziS/Fy0=
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Thu, 19 Sep 2024 10:58:57 +0200 (CEST)
From: Thomas Martitz <tmartitz-oss@avm.de>
To: Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Nixdorf <jnixdorf-oss@avm.de>,
	Thomas Martitz <tmartitz-oss@avm.de>,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next] net: bridge: drop packets with a local source
Date: Thu, 19 Sep 2024 10:58:02 +0200
Message-ID: <20240919085803.105430-1-tmartitz-oss@avm.de>
Reply-To: <20240911125820.471469-1-tmartitz-oss@avm.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1726736337-70AC7E44-6E73E10B/0/0
X-purgate-type: clean
X-purgate-size: 3382
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

Currently, there is only a warning if a packet enters the bridge
that has the bridge's or one port's MAC address as source.

Clearly this indicates a network loop (or even spoofing) so we
generally do not want to process the packet. Therefore, move the check
already done for 802.1x scenarios up and do it unconditionally.

For example, a common scenario we see in the field:
In a accidental network loop scenario, if an IGMP join
loops back to us, it would cause mdb entries to stay indefinitely
even if there's no actual join from the outside. Therefore
this change can effectively prevent multicast storms, at least
for simple loops.

Signed-off-by: Thomas Martitz <tmartitz-oss@avm.de>
---
 net/bridge/br_fdb.c   |  4 +---
 net/bridge/br_input.c | 17 ++++++++++-------
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
index ad7a42b505ef..f97203c56394 100644
--- a/net/bridge/br_fdb.c
+++ b/net/bridge/br_fdb.c
@@ -900,9 +900,7 @@ void br_fdb_update(struct net_bridge *br, struct net_bridge_port *source,
 	if (likely(fdb)) {
 		/* attempt to update an entry for a local interface */
 		if (unlikely(test_bit(BR_FDB_LOCAL, &fdb->flags))) {
-			if (net_ratelimit())
-				br_warn(br, "received packet on %s with own address as source address (addr:%pM, vlan:%u)\n",
-					source->dev->name, addr, vid);
+			return;
 		} else {
 			unsigned long now = jiffies;
 			bool fdb_modified = false;
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index ceaa5a89b947..06db92d03dd3 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -77,7 +77,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 {
 	struct net_bridge_port *p = br_port_get_rcu(skb->dev);
 	enum br_pkt_type pkt_type = BR_PKT_UNICAST;
-	struct net_bridge_fdb_entry *dst = NULL;
+	struct net_bridge_fdb_entry *fdb_src, *dst = NULL;
 	struct net_bridge_mcast_port *pmctx;
 	struct net_bridge_mdb_entry *mdst;
 	bool local_rcv, mcast_hit = false;
@@ -108,10 +108,14 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 				&state, &vlan))
 		goto out;
 
-	if (p->flags & BR_PORT_LOCKED) {
-		struct net_bridge_fdb_entry *fdb_src =
-			br_fdb_find_rcu(br, eth_hdr(skb)->h_source, vid);
-
+	fdb_src = br_fdb_find_rcu(br, eth_hdr(skb)->h_source, vid);
+	if (fdb_src && test_bit(BR_FDB_LOCAL, &fdb_src->flags)) {
+		/* Spoofer or short-curcuit on the network. Drop the packet. */
+		if (net_ratelimit())
+			br_warn(br, "received packet on %s with own address as source address (addr:%pM, vlan:%u)\n",
+				p->dev->name, eth_hdr(skb)->h_source, vid);
+		goto drop;
+	} else if (p->flags & BR_PORT_LOCKED) {
 		if (!fdb_src) {
 			/* FDB miss. Create locked FDB entry if MAB is enabled
 			 * and drop the packet.
@@ -120,8 +124,7 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 				br_fdb_update(br, p, eth_hdr(skb)->h_source,
 					      vid, BIT(BR_FDB_LOCKED));
 			goto drop;
-		} else if (READ_ONCE(fdb_src->dst) != p ||
-			   test_bit(BR_FDB_LOCAL, &fdb_src->flags)) {
+		} else if (READ_ONCE(fdb_src->dst) != p) {
 			/* FDB mismatch. Drop the packet without roaming. */
 			goto drop;
 		} else if (test_bit(BR_FDB_LOCKED, &fdb_src->flags)) {
-- 
2.46.1


