Return-Path: <netdev+bounces-105221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A45910289
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78EC0B21821
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 11:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1201AB904;
	Thu, 20 Jun 2024 11:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="T0XzM/WC"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1491AB8E2
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 11:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718883042; cv=none; b=Bn+QvflHyXNDpLoEDhzwivm8sqj3yCOM+q/J1SenHjJ4B6hdI76tjNipIYCTqjHvAdgTtI5UXPHgn/K1T8ukh57p0wWpP6dFQO17oHUyS3l+L2SXHCYJ3X/bPI2TixDLe6+8gn8+aXN2h7COFVmd6kTgwMrNr8L4tFSaWC0BIBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718883042; c=relaxed/simple;
	bh=W57DVDgiQsZS2lcnuFARDpi4Gj0TVIYGcy70mGrob9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kinoSdHOHJwY/5ly9EJSw9zxzSIL0lloALcGsasGTauvbDrUmCNNMJGQfuVaqcbpYGiMycnVWX/Cb/M365VMs4QoWxYr0VpaWPuJpVgmMLTriRdUbigxgiHFbBIK6/MlktzHehmQQ6PPz0JxqjBPwjatXTysCezGqVZu9GN0EgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=T0XzM/WC; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:530f:c40e:e1d0:8f13])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id A7FBD7DAE8;
	Thu, 20 Jun 2024 12:22:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1718882565; bh=W57DVDgiQsZS2lcnuFARDpi4Gj0TVIYGcy70mGrob9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20gnault@redhat.com,=0D=0A=09samuel.thibault@ens-
	 lyon.org,=0D=0A=09ridge.kennedy@alliedtelesis.co.nz|Subject:=20[PA
	 TCH=20net-next=204/8]=20l2tp:=20refactor=20udp=20recv=20to=20looku
	 p=20to=20not=20use=20sk_user_data|Date:=20Thu,=2020=20Jun=202024=2
	 012:22:40=20+0100|Message-Id:=20<fcdb19fad2c6464f27cdcc24c302a424e
	 f8dbb4d.1718877398.git.jchapman@katalix.com>|In-Reply-To:=20<cover
	 .1718877398.git.jchapman@katalix.com>|References:=20<cover.1718877
	 398.git.jchapman@katalix.com>|MIME-Version:=201.0;
	b=T0XzM/WCAHc2WZCZrBd0v+Kt7IqPvv3okmB6lUwUE+PyhB0OLpf0qDAbZET6nzRQ0
	 0rPikzI/qIBqCv+v8i6V8PnrBs77xwDbxSiWH58Ee5r9QruTwJ8Cy5LYm81e1uYwA4
	 NNpQJELcaWvoRe74llnYgR+GnqeJs126D40uTbIzhNtj9Wz1p4fzhJssZvxcDddYJz
	 sX/Y0um+zQgRJZRqVi1gQ2mtYahRa0AVTnTME4sPSJykbV9aaU6STaqJHRKkHgr6UE
	 L9Q812UUwVVU76LEDzKDNT2DSaEJ55QWQzs5Obk5sDvqSdub4IfA4ZRlLIyLKD2THO
	 aoncKN+S8DddA==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: gnault@redhat.com,
	samuel.thibault@ens-lyon.org,
	ridge.kennedy@alliedtelesis.co.nz
Subject: [PATCH net-next 4/8] l2tp: refactor udp recv to lookup to not use sk_user_data
Date: Thu, 20 Jun 2024 12:22:40 +0100
Message-Id: <fcdb19fad2c6464f27cdcc24c302a424ef8dbb4d.1718877398.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718877398.git.jchapman@katalix.com>
References: <cover.1718877398.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify UDP decap to not use the tunnel pointer which comes from the
sock's sk_user_data when parsing the L2TP header. By looking up the
destination session using only the packet contents we avoid potential
UDP 5-tuple aliasing issues which arise from depending on the socket
that received the packet.

Drop the useless error messages on short packet or on failing to find
a session since the tunnel pointer might point to a different tunnel
if multiple sockets use the same 5-tuple.

Short packets (those not big enough to contain an L2TP header) are no
longer counted in the tunnel's invalid counter because we can't derive
the tunnel until we parse the l2tp header to lookup the session.

l2tp_udp_encap_recv was a small wrapper around l2tp_udp_recv_core which
used sk_user_data to derive a tunnel pointer in an RCU-safe way. But
we no longer need the tunnel pointer, so remove that code and combine
the two functions.

Signed-off-by: James Chapman <jchapman@katalix.com>
Reviewed-by: Tom Parkin <tparkin@katalix.com>
---
 net/l2tp/l2tp_core.c | 96 ++++++++++----------------------------------
 1 file changed, 21 insertions(+), 75 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 6f30b347fd46..2c6378a9f384 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -926,19 +926,14 @@ static void l2tp_session_queue_purge(struct l2tp_session *session)
 	}
 }
 
-/* Internal UDP receive frame. Do the real work of receiving an L2TP data frame
- * here. The skb is not on a list when we get here.
- * Returns 0 if the packet was a data packet and was successfully passed on.
- * Returns 1 if the packet was not a good data packet and could not be
- * forwarded.  All such packets are passed up to userspace to deal with.
- */
-static int l2tp_udp_recv_core(struct l2tp_tunnel *tunnel, struct sk_buff *skb)
+/* UDP encapsulation receive handler. See net/ipv4/udp.c for details. */
+int l2tp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
 {
 	struct l2tp_session *session = NULL;
-	struct l2tp_tunnel *orig_tunnel = tunnel;
+	struct l2tp_tunnel *tunnel = NULL;
+	struct net *net = sock_net(sk);
 	unsigned char *ptr, *optr;
 	u16 hdrflags;
-	u32 tunnel_id, session_id;
 	u16 version;
 	int length;
 
@@ -948,11 +943,8 @@ static int l2tp_udp_recv_core(struct l2tp_tunnel *tunnel, struct sk_buff *skb)
 	__skb_pull(skb, sizeof(struct udphdr));
 
 	/* Short packet? */
-	if (!pskb_may_pull(skb, L2TP_HDR_SIZE_MAX)) {
-		pr_debug_ratelimited("%s: recv short packet (len=%d)\n",
-				     tunnel->name, skb->len);
-		goto invalid;
-	}
+	if (!pskb_may_pull(skb, L2TP_HDR_SIZE_MAX))
+		goto pass;
 
 	/* Point to L2TP header */
 	optr = skb->data;
@@ -975,6 +967,8 @@ static int l2tp_udp_recv_core(struct l2tp_tunnel *tunnel, struct sk_buff *skb)
 	ptr += 2;
 
 	if (version == L2TP_HDR_VER_2) {
+		u16 tunnel_id, session_id;
+
 		/* If length is present, skip it */
 		if (hdrflags & L2TP_HDRFLAG_L)
 			ptr += 2;
@@ -982,49 +976,35 @@ static int l2tp_udp_recv_core(struct l2tp_tunnel *tunnel, struct sk_buff *skb)
 		/* Extract tunnel and session ID */
 		tunnel_id = ntohs(*(__be16 *)ptr);
 		ptr += 2;
-
-		if (tunnel_id != tunnel->tunnel_id) {
-			/* We are receiving trafic for another tunnel, probably
-			 * because we have several tunnels between the same
-			 * IP/port quadruple, look it up.
-			 */
-			struct l2tp_tunnel *alt_tunnel;
-
-			alt_tunnel = l2tp_tunnel_get(tunnel->l2tp_net, tunnel_id);
-			if (!alt_tunnel)
-				goto pass;
-			tunnel = alt_tunnel;
-		}
-
 		session_id = ntohs(*(__be16 *)ptr);
 		ptr += 2;
+
+		session = l2tp_v2_session_get(net, tunnel_id, session_id);
 	} else {
+		u32 session_id;
+
 		ptr += 2;	/* skip reserved bits */
-		tunnel_id = tunnel->tunnel_id;
 		session_id = ntohl(*(__be32 *)ptr);
 		ptr += 4;
-	}
 
-	/* Check protocol version */
-	if (version != tunnel->version) {
-		pr_debug_ratelimited("%s: recv protocol version mismatch: got %d expected %d\n",
-				     tunnel->name, version, tunnel->version);
-		goto invalid;
+		session = l2tp_v3_session_get(net, sk, session_id);
 	}
 
-	/* Find the session context */
-	session = l2tp_tunnel_get_session(tunnel, session_id);
 	if (!session || !session->recv_skb) {
 		if (session)
 			l2tp_session_dec_refcount(session);
 
 		/* Not found? Pass to userspace to deal with */
-		pr_debug_ratelimited("%s: no session found (%u/%u). Passing up.\n",
-				     tunnel->name, tunnel_id, session_id);
 		goto pass;
 	}
 
-	if (tunnel->version == L2TP_HDR_VER_3 &&
+	tunnel = session->tunnel;
+
+	/* Check protocol version */
+	if (version != tunnel->version)
+		goto invalid;
+
+	if (version == L2TP_HDR_VER_3 &&
 	    l2tp_v3_ensure_opt_in_linear(session, skb, &ptr, &optr)) {
 		l2tp_session_dec_refcount(session);
 		goto invalid;
@@ -1033,9 +1013,6 @@ static int l2tp_udp_recv_core(struct l2tp_tunnel *tunnel, struct sk_buff *skb)
 	l2tp_recv_common(session, skb, ptr, optr, hdrflags, length);
 	l2tp_session_dec_refcount(session);
 
-	if (tunnel != orig_tunnel)
-		l2tp_tunnel_dec_refcount(tunnel);
-
 	return 0;
 
 invalid:
@@ -1045,42 +1022,11 @@ static int l2tp_udp_recv_core(struct l2tp_tunnel *tunnel, struct sk_buff *skb)
 	/* Put UDP header back */
 	__skb_push(skb, sizeof(struct udphdr));
 
-	if (tunnel != orig_tunnel)
-		l2tp_tunnel_dec_refcount(tunnel);
-
-	return 1;
-}
-
-/* UDP encapsulation receive and error receive handlers.
- * See net/ipv4/udp.c for details.
- *
- * Note that these functions are called from inside an
- * RCU-protected region, but without the socket being locked.
- *
- * Hence we use rcu_dereference_sk_user_data to access the
- * tunnel data structure rather the usual l2tp_sk_to_tunnel
- * accessor function.
- */
-int l2tp_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
-{
-	struct l2tp_tunnel *tunnel;
-
-	tunnel = rcu_dereference_sk_user_data(sk);
-	if (!tunnel)
-		goto pass_up;
-	if (WARN_ON(tunnel->magic != L2TP_TUNNEL_MAGIC))
-		goto pass_up;
-
-	if (l2tp_udp_recv_core(tunnel, skb))
-		goto pass_up;
-
-	return 0;
-
-pass_up:
 	return 1;
 }
 EXPORT_SYMBOL_GPL(l2tp_udp_encap_recv);
 
+/* UDP encapsulation receive error handler. See net/ipv4/udp.c for details. */
 static void l2tp_udp_encap_err_recv(struct sock *sk, struct sk_buff *skb, int err,
 				    __be16 port, u32 info, u8 *payload)
 {
-- 
2.34.1


