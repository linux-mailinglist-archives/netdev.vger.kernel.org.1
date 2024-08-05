Return-Path: <netdev+bounces-115745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D507947A73
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 13:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FC771C21406
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 11:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5A8157499;
	Mon,  5 Aug 2024 11:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="1IY0sYuh"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DA0155C8D
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 11:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722857745; cv=none; b=XuebOaEFusSxF1oRcO6XxF4qgPUPQ3Sp36lfwFR0PMnHiBGn1VroLI4Lsrsrdm8S8Ys/b1rPZZiOefzkzOoGOHdBx113/PKPXMJ+aelfO0BetZgZN/SpJNuxryHrzX7rO4Sww0cJUuLiqa2b8GKryYJidD8yFV1ZRO+qUylddcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722857745; c=relaxed/simple;
	bh=uK0/GlDRL5AwTg+/+MmmlECsr0RKXXmg79h5mSDgBlk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QUBT3t8YrPuxeawAMQVTNyq3ekb4YSNqTamgh6pwNPFnm4CCO6TuokCJz6yZDjeO7EWP+MZXasTBwUoAqKXw4SPcmtl0JOx591lFC8gWeqo6q5TG80L6sXgqzf53QeBaAcb6TTSJLKrKqGZagfXdfMD3DpP8zLMHLPNev2npIWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=1IY0sYuh; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:326:9405:f27f:a659])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 586C17DD01;
	Mon,  5 Aug 2024 12:35:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1722857735; bh=uK0/GlDRL5AwTg+/+MmmlECsr0RKXXmg79h5mSDgBlk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com|Subject:=20[PATCH=20n
	 et-next=204/9]=20l2tp:=20add=20tunnel/session=20get_next=20helpers
	 |Date:=20Mon,=20=205=20Aug=202024=2012:35:28=20+0100|Message-Id:=2
	 0<4067ff5019040bf8ee2bd3c06db9e3d27ca39ded.1722856576.git.jchapman
	 @katalix.com>|In-Reply-To:=20<cover.1722856576.git.jchapman@katali
	 x.com>|References:=20<cover.1722856576.git.jchapman@katalix.com>|M
	 IME-Version:=201.0;
	b=1IY0sYuhYz7VxZnY75MwkzXd9IAj4kmd2FKecVrOVqgr/oe++5s9eVmP/ZCMegKQm
	 12AmmxQCqJocd2CgZkXWaU67T2Ga0RLS5Fbm1ovD4XJYPJ9cQ1WU7lEZgh9R4m3JxS
	 y/n2FfewKv4/8jNC5VUDE5uxKwXxiiHpzHaUT3vvRJ4qkFroAqauWm5/qvW5GnxH8s
	 J3Ypw+4YuoG7Q9UDHM91CvcoAF4rZEzYVlXwmPLWtZXEu1mtyHscUUduCKVK3/M09S
	 rjuUHLbDvZm/u/4MRKMlj9Rg/w/QNyjSiEA2o604u69iVb5kwEWe1bBiWjNhtN5Gnd
	 xlgplZQTKXUTQ==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com
Subject: [PATCH net-next 4/9] l2tp: add tunnel/session get_next helpers
Date: Mon,  5 Aug 2024 12:35:28 +0100
Message-Id: <4067ff5019040bf8ee2bd3c06db9e3d27ca39ded.1722856576.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722856576.git.jchapman@katalix.com>
References: <cover.1722856576.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

l2tp management APIs and procfs/debugfs iterate over l2tp tunnel and
session lists. Since these lists are now implemented using IDR, we can
use IDR get_next APIs to iterate them. Add tunnel/session get_next
functions to do so.

The session get_next functions get the next session in a given tunnel
and need to account for l2tpv2 and l2tpv3 differences:

 * l2tpv2 sessions are keyed by tunnel ID / session ID. Iteration for
   a given tunnel ID, TID, can therefore start with a key given by
   TID/0 and finish when the next entry's tunnel ID is not TID. This
   is possible only because the tunnel ID part of the key is the upper
   16 bits and the session ID part the lower 16 bits; when idr_next
   increments the key value, it therefore finds the next sessions of
   the current tunnel before those of the next tunnel. Entries with
   session ID 0 are always skipped because they are used internally by
   pppol2tp.

 * l2tpv3 sessions are keyed by session ID. Iteration starts at the
   first IDR entry and skips entries where the tunnel does not
   match. Iteration must also consider session ID collisions and walk
   the list of colliding sessions (if any) for one which matches the
   supplied tunnel.

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
---
 net/l2tp/l2tp_core.c | 122 +++++++++++++++++++++++++++++++++++++++++++
 net/l2tp/l2tp_core.h |   3 ++
 2 files changed, 125 insertions(+)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 0c661d499a6f..05e388490cd9 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -257,6 +257,28 @@ struct l2tp_tunnel *l2tp_tunnel_get_nth(const struct net *net, int nth)
 }
 EXPORT_SYMBOL_GPL(l2tp_tunnel_get_nth);
 
+struct l2tp_tunnel *l2tp_tunnel_get_next(const struct net *net, unsigned long *key)
+{
+	struct l2tp_net *pn = l2tp_pernet(net);
+	struct l2tp_tunnel *tunnel = NULL;
+
+	rcu_read_lock_bh();
+again:
+	tunnel = idr_get_next_ul(&pn->l2tp_tunnel_idr, key);
+	if (tunnel) {
+		if (refcount_inc_not_zero(&tunnel->ref_count)) {
+			rcu_read_unlock_bh();
+			return tunnel;
+		}
+		(*key)++;
+		goto again;
+	}
+	rcu_read_unlock_bh();
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(l2tp_tunnel_get_next);
+
 struct l2tp_session *l2tp_v3_session_get(const struct net *net, struct sock *sk, u32 session_id)
 {
 	const struct l2tp_net *pn = l2tp_pernet(net);
@@ -347,6 +369,106 @@ struct l2tp_session *l2tp_session_get_nth(struct l2tp_tunnel *tunnel, int nth)
 }
 EXPORT_SYMBOL_GPL(l2tp_session_get_nth);
 
+static struct l2tp_session *l2tp_v2_session_get_next(const struct net *net, u16 tid, unsigned long *key)
+{
+	struct l2tp_net *pn = l2tp_pernet(net);
+	struct l2tp_session *session = NULL;
+
+	/* Start searching within the range of the tid */
+	if (*key == 0)
+		*key = l2tp_v2_session_key(tid, 0);
+
+	rcu_read_lock_bh();
+again:
+	session = idr_get_next_ul(&pn->l2tp_v2_session_idr, key);
+	if (session) {
+		struct l2tp_tunnel *tunnel = READ_ONCE(session->tunnel);
+
+		/* ignore sessions with id 0 as they are internal for pppol2tp */
+		if (session->session_id == 0) {
+			(*key)++;
+			goto again;
+		}
+
+		if (tunnel && tunnel->tunnel_id == tid &&
+		    refcount_inc_not_zero(&session->ref_count)) {
+			rcu_read_unlock_bh();
+			return session;
+		}
+
+		(*key)++;
+		if (tunnel->tunnel_id == tid)
+			goto again;
+	}
+	rcu_read_unlock_bh();
+
+	return NULL;
+}
+
+static struct l2tp_session *l2tp_v3_session_get_next(const struct net *net, u32 tid, struct sock *sk, unsigned long *key)
+{
+	struct l2tp_net *pn = l2tp_pernet(net);
+	struct l2tp_session *session = NULL;
+
+	rcu_read_lock_bh();
+again:
+	session = idr_get_next_ul(&pn->l2tp_v3_session_idr, key);
+	if (session && !hash_hashed(&session->hlist)) {
+		struct l2tp_tunnel *tunnel = READ_ONCE(session->tunnel);
+
+		if (tunnel && tunnel->tunnel_id == tid &&
+		    refcount_inc_not_zero(&session->ref_count)) {
+			rcu_read_unlock_bh();
+			return session;
+		}
+
+		(*key)++;
+		goto again;
+	}
+
+	/* If we get here and session is non-NULL, the IDR entry may be one
+	 * where the session_id collides with one in another tunnel. Check
+	 * session_htable for a match. There can only be one session of a given
+	 * ID per tunnel so we can return as soon as a match is found.
+	 */
+	if (session && hash_hashed(&session->hlist)) {
+		unsigned long hkey = l2tp_v3_session_hashkey(sk, session->session_id);
+		u32 sid = session->session_id;
+
+		hash_for_each_possible_rcu(pn->l2tp_v3_session_htable, session,
+					   hlist, hkey) {
+			struct l2tp_tunnel *tunnel = READ_ONCE(session->tunnel);
+
+			if (session->session_id == sid &&
+			    tunnel && tunnel->tunnel_id == tid &&
+			    refcount_inc_not_zero(&session->ref_count)) {
+				rcu_read_unlock_bh();
+				return session;
+			}
+		}
+
+		/* If no match found, the colliding session ID isn't in our
+		 * tunnel so try the next session ID.
+		 */
+		(*key)++;
+		goto again;
+	}
+
+	rcu_read_unlock_bh();
+
+	return NULL;
+}
+
+struct l2tp_session *l2tp_session_get_next(const struct net *net, struct sock *sk, int pver,
+					   u32 tunnel_id, unsigned long *key)
+{
+	if (pver == L2TP_HDR_VER_2)
+		return l2tp_v2_session_get_next(net, tunnel_id, key);
+	else
+		return l2tp_v3_session_get_next(net, tunnel_id, sk, key);
+}
+EXPORT_SYMBOL_GPL(l2tp_session_get_next);
+
 /* Lookup a session by interface name.
  * This is very inefficient but is only used by management interfaces.
  */
diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
index c907687705b9..cc464982a7d9 100644
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -220,12 +220,15 @@ void l2tp_session_dec_refcount(struct l2tp_session *session);
  */
 struct l2tp_tunnel *l2tp_tunnel_get(const struct net *net, u32 tunnel_id);
 struct l2tp_tunnel *l2tp_tunnel_get_nth(const struct net *net, int nth);
+struct l2tp_tunnel *l2tp_tunnel_get_next(const struct net *net, unsigned long *key);
 
 struct l2tp_session *l2tp_v3_session_get(const struct net *net, struct sock *sk, u32 session_id);
 struct l2tp_session *l2tp_v2_session_get(const struct net *net, u16 tunnel_id, u16 session_id);
 struct l2tp_session *l2tp_session_get(const struct net *net, struct sock *sk, int pver,
 				      u32 tunnel_id, u32 session_id);
 struct l2tp_session *l2tp_session_get_nth(struct l2tp_tunnel *tunnel, int nth);
+struct l2tp_session *l2tp_session_get_next(const struct net *net, struct sock *sk, int pver,
+					   u32 tunnel_id, unsigned long *key);
 struct l2tp_session *l2tp_session_get_by_ifname(const struct net *net,
 						const char *ifname);
 
-- 
2.34.1


