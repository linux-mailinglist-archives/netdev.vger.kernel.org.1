Return-Path: <netdev+bounces-113707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AC593F9A6
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 17:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FEE2B21493
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 15:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6366615ECE9;
	Mon, 29 Jul 2024 15:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="JPhssaJA"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7033C15B13C
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267500; cv=none; b=lR/tm/ks4YFVsxMXSlX5s5tm0zE5wuvmBa6zir5N4NPnuAVjr3MFvNq+fVfwKKuFYVt7OAcnZQryC2GV4IUDojUmIKwtQmK3GBD+n6RskH9Jknkofj59NDD6ws1uasXlXY4niQ7kCf4AvU+tCSeesd5sKHZigbbIEvYDO5mye1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267500; c=relaxed/simple;
	bh=HU1Jpf+T2dUov3K5TBhbMvV98ArKtLsdpZviyxFo2is=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VJlo73BPmmkw5jr6mukawPHX/sTHYryxciZPAI1g91tq3wBBJXNR8gPShnFqSUyviWlO5TNgaUo2nrfB6TqpRetg0RP7BjyXAcjwysh0SX20pTFdTYyJ7R37E8qEsUltV8CPfHneDE03HOmzd5ShDavRIzHLjn8U2fhgcIi9FEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=JPhssaJA; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:6c24:bf58:f1fe:91c1])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 5BB5C7DCFB;
	Mon, 29 Jul 2024 16:38:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1722267496; bh=HU1Jpf+T2dUov3K5TBhbMvV98ArKtLsdpZviyxFo2is=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com|Subject:=20[PATCH=20n
	 et-next=2011/15]=20l2tp:=20prevent=20possible=20tunnel=20refcount=
	 20underflow|Date:=20Mon,=2029=20Jul=202024=2016:38:10=20+0100|Mess
	 age-Id:=20<4af28001f1fe201c3cff73b62c7cacaf98a513b2.1722265212.git
	 .jchapman@katalix.com>|In-Reply-To:=20<cover.1722265212.git.jchapm
	 an@katalix.com>|References:=20<cover.1722265212.git.jchapman@katal
	 ix.com>|MIME-Version:=201.0;
	b=JPhssaJA8A06EMueBC1rMNrhR9mmHa8VzDDvUmHMyJN9pp8SFZWAn/cnVhln0JFA/
	 QEPbIFlzCJUoNkMwasHb6xykCg5Hu2+bMjF/igPl+QihsfZy0LYWXiC9sdBd6nb5l7
	 HswXk1Rttxl+B+c7pPa2CuOuDa/N/UFhrZ+qLtOQN1JPINXzRzcu9RpR1ePiRAUBCH
	 iFUocwV2zrFJnVeEpJWrWpX3cQD3f1p8au0qDARMju9CF5OCpVedwvTBa5kswUpUMw
	 tOtiqencyY2yki/m2Tj8phrRC4y7cSMLWo4puZbpTm6dMb9oFQV7OtwBpVzkq86Kqw
	 Uj4PUk3iphh/A==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com
Subject: [PATCH net-next 11/15] l2tp: prevent possible tunnel refcount underflow
Date: Mon, 29 Jul 2024 16:38:10 +0100
Message-Id: <4af28001f1fe201c3cff73b62c7cacaf98a513b2.1722265212.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722265212.git.jchapman@katalix.com>
References: <cover.1722265212.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a session is created, it sets a backpointer to its tunnel. When
the session refcount drops to 0, l2tp_session_free drops the tunnel
refcount if session->tunnel is non-NULL. However, session->tunnel is
set in l2tp_session_create, before the tunnel refcount is incremented
by l2tp_session_register, which leaves a small window where
session->tunnel is non-NULL when the tunnel refcount hasn't been
bumped.

Moving the assignment to l2tp_session_register is trivial but
l2tp_session_create calls l2tp_session_set_header_len which uses
session->tunnel to get the tunnel's encap. Add an encap arg to
l2tp_session_set_header_len to avoid using session->tunnel.

If l2tpv3 sessions have colliding IDs, it is possible for
l2tp_v3_session_get to race with l2tp_session_register and fetch a
session which doesn't yet have session->tunnel set. Add a check for
this case.

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
---
 net/l2tp/l2tp_core.c    | 24 +++++++++++++++++-------
 net/l2tp/l2tp_core.h    |  3 ++-
 net/l2tp/l2tp_netlink.c |  4 +++-
 net/l2tp/l2tp_ppp.c     |  3 ++-
 4 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 4cf4aa271353..cbf117683fab 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -279,7 +279,14 @@ struct l2tp_session *l2tp_v3_session_get(const struct net *net, struct sock *sk,
 
 		hash_for_each_possible_rcu(pn->l2tp_v3_session_htable, session,
 					   hlist, key) {
-			if (session->tunnel->sock == sk &&
+			/* session->tunnel may be NULL if another thread is in
+			 * l2tp_session_register and has added an item to
+			 * l2tp_v3_session_htable but hasn't yet added the
+			 * session to its tunnel's session_list.
+			 */
+			struct l2tp_tunnel *tunnel = READ_ONCE(session->tunnel);
+
+			if (tunnel && tunnel->sock == sk &&
 			    refcount_inc_not_zero(&session->ref_count)) {
 				rcu_read_unlock_bh();
 				return session;
@@ -507,6 +514,7 @@ int l2tp_session_register(struct l2tp_session *session,
 	}
 
 	l2tp_tunnel_inc_refcount(tunnel);
+	WRITE_ONCE(session->tunnel, tunnel);
 	list_add(&session->list, &tunnel->session_list);
 
 	if (tunnel->version == L2TP_HDR_VER_3) {
@@ -822,7 +830,8 @@ void l2tp_recv_common(struct l2tp_session *session, struct sk_buff *skb,
 		if (!session->lns_mode && !session->send_seq) {
 			trace_session_seqnum_lns_enable(session);
 			session->send_seq = 1;
-			l2tp_session_set_header_len(session, tunnel->version);
+			l2tp_session_set_header_len(session, tunnel->version,
+						    tunnel->encap);
 		}
 	} else {
 		/* No sequence numbers.
@@ -843,7 +852,8 @@ void l2tp_recv_common(struct l2tp_session *session, struct sk_buff *skb,
 		if (!session->lns_mode && session->send_seq) {
 			trace_session_seqnum_lns_disable(session);
 			session->send_seq = 0;
-			l2tp_session_set_header_len(session, tunnel->version);
+			l2tp_session_set_header_len(session, tunnel->version,
+						    tunnel->encap);
 		} else if (session->send_seq) {
 			pr_debug_ratelimited("%s: recv data has no seq numbers when required. Discarding.\n",
 					     session->name);
@@ -1648,7 +1658,8 @@ static void l2tp_session_del_work(struct work_struct *work)
 /* We come here whenever a session's send_seq, cookie_len or
  * l2specific_type parameters are set.
  */
-void l2tp_session_set_header_len(struct l2tp_session *session, int version)
+void l2tp_session_set_header_len(struct l2tp_session *session, int version,
+				 enum l2tp_encap_type encap)
 {
 	if (version == L2TP_HDR_VER_2) {
 		session->hdr_len = 6;
@@ -1657,7 +1668,7 @@ void l2tp_session_set_header_len(struct l2tp_session *session, int version)
 	} else {
 		session->hdr_len = 4 + session->cookie_len;
 		session->hdr_len += l2tp_get_l2specific_len(session);
-		if (session->tunnel->encap == L2TP_ENCAPTYPE_UDP)
+		if (encap == L2TP_ENCAPTYPE_UDP)
 			session->hdr_len += 4;
 	}
 }
@@ -1671,7 +1682,6 @@ struct l2tp_session *l2tp_session_create(int priv_size, struct l2tp_tunnel *tunn
 	session = kzalloc(sizeof(*session) + priv_size, GFP_KERNEL);
 	if (session) {
 		session->magic = L2TP_SESSION_MAGIC;
-		session->tunnel = tunnel;
 
 		session->session_id = session_id;
 		session->peer_session_id = peer_session_id;
@@ -1710,7 +1720,7 @@ struct l2tp_session *l2tp_session_create(int priv_size, struct l2tp_tunnel *tunn
 			memcpy(&session->peer_cookie[0], &cfg->peer_cookie[0], cfg->peer_cookie_len);
 		}
 
-		l2tp_session_set_header_len(session, tunnel->version);
+		l2tp_session_set_header_len(session, tunnel->version, tunnel->encap);
 
 		refcount_set(&session->ref_count, 1);
 
diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
index 58d3977870de..c907687705b9 100644
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -258,7 +258,8 @@ void l2tp_recv_common(struct l2tp_session *session, struct sk_buff *skb,
 int l2tp_udp_encap_recv(struct sock *sk, struct sk_buff *skb);
 
 /* Transmit path helpers for sending packets over the tunnel socket. */
-void l2tp_session_set_header_len(struct l2tp_session *session, int version);
+void l2tp_session_set_header_len(struct l2tp_session *session, int version,
+				 enum l2tp_encap_type encap);
 int l2tp_xmit_skb(struct l2tp_session *session, struct sk_buff *skb);
 
 /* Pseudowire management.
diff --git a/net/l2tp/l2tp_netlink.c b/net/l2tp/l2tp_netlink.c
index d105030520f9..fc43ecbd128c 100644
--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -692,8 +692,10 @@ static int l2tp_nl_cmd_session_modify(struct sk_buff *skb, struct genl_info *inf
 		session->recv_seq = nla_get_u8(info->attrs[L2TP_ATTR_RECV_SEQ]);
 
 	if (info->attrs[L2TP_ATTR_SEND_SEQ]) {
+		struct l2tp_tunnel *tunnel = session->tunnel;
+
 		session->send_seq = nla_get_u8(info->attrs[L2TP_ATTR_SEND_SEQ]);
-		l2tp_session_set_header_len(session, session->tunnel->version);
+		l2tp_session_set_header_len(session, tunnel->version, tunnel->encap);
 	}
 
 	if (info->attrs[L2TP_ATTR_LNS_MODE])
diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 12a0a7162870..1b79a36d5756 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1189,7 +1189,8 @@ static int pppol2tp_session_setsockopt(struct sock *sk,
 			po->chan.hdrlen = val ? PPPOL2TP_L2TP_HDR_SIZE_SEQ :
 				PPPOL2TP_L2TP_HDR_SIZE_NOSEQ;
 		}
-		l2tp_session_set_header_len(session, session->tunnel->version);
+		l2tp_session_set_header_len(session, session->tunnel->version,
+					    session->tunnel->encap);
 		break;
 
 	case PPPOL2TP_SO_LNSMODE:
-- 
2.34.1


