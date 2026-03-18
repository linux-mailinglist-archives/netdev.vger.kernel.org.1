Return-Path: <netdev+bounces-268844-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPQBDXP/uWlBQQIAu9opvQ
	(envelope-from <netdev+bounces-268844-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 02:27:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D10262B4F28
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 02:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1C8530743C7
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 01:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C1823EA83;
	Wed, 18 Mar 2026 01:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkLfNeTB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB562356C6
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 01:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773797224; cv=none; b=G95ABZnsxfEQSfpPR+7XfOChlDkeuz4pE80l3mt/42hDkSPbvQM3iRudFYmrKXp2695NpiKUE603CvKBHoYCiaMZIAVHZLAJg5WAY4Kkj93o1rWg6DvZN2SUkkEH7iwaWTzV0fiUZ+AdUODbUckly1olp/E+Bw+rsR8YteDpMVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773797224; c=relaxed/simple;
	bh=ixYXi+/k0hGdcXem8PCM6XaaEWN9flbdQPgnzunHPV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S8513FLMw/5DeP4fz2p650a7m6hHAcE7ffyQFSIwSeTH8gDq7IXqUW5Ofc1M1GCaoHtjautvHqTRxA0Qruesj35K5lhB5mxQHYcAXo+RxXFg4BbCk3bGt9m5mQJk5tYqZbgSdBpO9B4Fee4/dohkwNnQJauRZ/p0fJEhH/acCWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkLfNeTB; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8f9568e074so894931666b.0
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 18:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773797222; x=1774402022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WNXLkEoBDNGwPbjZ/vooPOcdheELOMB3ucg5AbTB558=;
        b=SkLfNeTB/iEONLq+RVNYOrVMLfy1DJ4eX2cbMt/kMzmwn5B3ZcnAOiRZug0oiJNyDz
         83lFcgCILXjtN1+iQt2gWBvSiT7Zt7Ft8MpspummkBE+j4C+vqUx/P9eetn+aJII5lsK
         Y8aABM+mWc3gQuo/0qQBuwKXfkE56o3CMWW5WjYcxCIlW5gwPo9lrKdKz/vJTpY/GVWU
         8H2RvMENNN0yXYd80qdUMvdSr6joiIX6Zy3FAClJr7YvRrFKibtGe2TdABpOKWTp8jES
         KcCW7vnCk/YQCT9ECxjZftFqswHYXQM7j460mnjjQA9IwyOO/SlW2KVeflDkXOEGbHtV
         veeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773797222; x=1774402022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNXLkEoBDNGwPbjZ/vooPOcdheELOMB3ucg5AbTB558=;
        b=CLeQnt9EjkzJcTMk06M68tQ3+6d2EHZVQqnMu3p/3/rMlRM5sGntEn0PhHkO+EiqOE
         Gs5CY1mSjxBSw8pA+A3FgxsabWoAINDgNee1/d994ov9oZHckN9lpjTRP7dZZdReu55b
         83aZ+EEqBFyw+s/kFKA/o4rxcqSx115QWDHsfnPZqDufdMJnWOaskphYv8gPiUhLWNCO
         F2jgNlWtLSd+opUiDlVta6m2U9+H2Tix404EMUvOMZ5oV7Rn8PLw1qfKGyF+6vrHv+TG
         Qlv1w2NKf3T4I7V+z2A7do+NbFBlZ0iQgWNPrxPXuj63zwME2TxruCLGHNHT8QHMmsKA
         tXng==
X-Forwarded-Encrypted: i=1; AJvYcCUcYPP8khaMx+RTLHmxqvvPVsj+u1BdXGO+WJo2NRd4WRwTd5UvCDQI2+Fj+BOuSHHrkJ5tpJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT8+3Cwi/DtXchrkvOWZMXsHQJfHE1KDUQPT7LVg8VpPrIEpP5
	f/V+J591CPQkoktLpPSDfTy6g5EVr/QhlItRy785I57zDDzI41+QW27l
X-Gm-Gg: ATEYQzyi61KxdChq96uuF+LvIY5A8OsXuzglYRQglvFynB1Sr8/6qXeOMSa70fCvzM1
	n3rAkLG/1Cx3FVP8uauPEfKMKpWJcH/dCWZ+fJBfs2iZ+wDgMYqZfBF32MRnuFEktGGEwlJJ6OB
	YWURftJwN6mkw/gvuv0EC0swovrRvEuPoL4V7HpEclL4tqF8hilU8xaFHenHhejrZQsOwLtn/nB
	Cn5v5q5qR0RWSy6HZRCTeQLlWxDZU5UfEhBipFeK1iLbAHXtUijJcxII6qy3DpypfCg9TJqDK2F
	z91NxG2BIa8fUqHSz5gAuHNbrdsFuTHw0oDP8RJiUnykbimSnXonCnzXm+J/PRb2nsKvorVCN4f
	i3hF9KuSkl6Ql4sBz8lkmlyOQzPImS7EruE0xkpmltwa6Xeq39b5dOTKV34i+bCHu9m2T7C9R
X-Received: by 2002:a17:907:2da7:b0:b97:4e42:23e7 with SMTP id a640c23a62f3a-b97f484fb15mr100629266b.24.1773797221520;
        Tue, 17 Mar 2026 18:27:01 -0700 (PDT)
Received: from gmail.com ([2a09:bac1:5520::49b:45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f168c141sm91922766b.40.2026.03.17.18.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 18:27:00 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: stable@vger.kernel.org
Cc: linux-ppp@vger.kernel.org,
	James Chapman <jchapman@katalix.com>,
	Guillaume Nault <gnault@redhat.com>,
	netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH 6.6.y 6.1.y 5.15.y 5.10.y] l2tp: fix ppp_dev_name() use-after-free
Date: Wed, 18 Mar 2026 09:26:53 +0800
Message-ID: <20260318012653.232518-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268844-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D10262B4F28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[ Upstream commit 9b8c88f875c04d4cb9111bd5dd9291c7e9691bf5 ]

ppp_dev_name() directly returns netdev->name to the caller. The caller
must hold either RCU or RTNL lock, in order to prevent the netdev from
being freed while still being used.

The upstream commit expanded the RCU critical section to include
ppp_dev_name(), which inadvertently fixed the problem. So backport the
commit to fix the UAF in older stable versions.

Fixes: ee40fb2e1eb5 ("l2tp: protect sock pointer of struct pppol2tp_session with RCU")
Cc: Eric Dumazet <edumazet@google.com>
Signed-off-by: Qingfang Deng <dqfext@gmail.com>
---
 net/l2tp/l2tp_ppp.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 6146e4e67bbb..34d8582c0c07 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -130,22 +130,12 @@ static const struct ppp_channel_ops pppol2tp_chan_ops = {
 
 static const struct proto_ops pppol2tp_ops;
 
-/* Retrieves the pppol2tp socket associated to a session.
- * A reference is held on the returned socket, so this function must be paired
- * with sock_put().
- */
+/* Retrieves the pppol2tp socket associated to a session. */
 static struct sock *pppol2tp_session_get_sock(struct l2tp_session *session)
 {
 	struct pppol2tp_session *ps = l2tp_session_priv(session);
-	struct sock *sk;
 
-	rcu_read_lock();
-	sk = rcu_dereference(ps->sk);
-	if (sk)
-		sock_hold(sk);
-	rcu_read_unlock();
-
-	return sk;
+	return rcu_dereference(ps->sk);
 }
 
 /* Helpers to obtain tunnel/session contexts from sockets.
@@ -211,14 +201,13 @@ static int pppol2tp_recvmsg(struct socket *sock, struct msghdr *msg,
 
 static void pppol2tp_recv(struct l2tp_session *session, struct sk_buff *skb, int data_len)
 {
-	struct pppol2tp_session *ps = l2tp_session_priv(session);
-	struct sock *sk = NULL;
+	struct sock *sk;
 
 	/* If the socket is bound, send it in to PPP's input queue. Otherwise
 	 * queue it on the session socket.
 	 */
 	rcu_read_lock();
-	sk = rcu_dereference(ps->sk);
+	sk = pppol2tp_session_get_sock(session);
 	if (!sk)
 		goto no_sock;
 
@@ -528,13 +517,14 @@ static void pppol2tp_show(struct seq_file *m, void *arg)
 	struct l2tp_session *session = arg;
 	struct sock *sk;
 
+	rcu_read_lock();
 	sk = pppol2tp_session_get_sock(session);
 	if (sk) {
 		struct pppox_sock *po = pppox_sk(sk);
 
 		seq_printf(m, "   interface %s\n", ppp_dev_name(&po->chan));
-		sock_put(sk);
 	}
+	rcu_read_unlock();
 }
 
 static void pppol2tp_session_init(struct l2tp_session *session)
@@ -1540,6 +1530,7 @@ static void pppol2tp_seq_session_show(struct seq_file *m, void *v)
 		port = ntohs(inet->inet_sport);
 	}
 
+	rcu_read_lock();
 	sk = pppol2tp_session_get_sock(session);
 	if (sk) {
 		state = sk->sk_state;
@@ -1575,8 +1566,8 @@ static void pppol2tp_seq_session_show(struct seq_file *m, void *v)
 		struct pppox_sock *po = pppox_sk(sk);
 
 		seq_printf(m, "   interface %s\n", ppp_dev_name(&po->chan));
-		sock_put(sk);
 	}
+	rcu_read_unlock();
 }
 
 static int pppol2tp_seq_show(struct seq_file *m, void *v)
-- 
2.43.0


