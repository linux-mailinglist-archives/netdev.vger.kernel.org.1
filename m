Return-Path: <netdev+bounces-216950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F7CB366A3
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 15:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47CD6564A27
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAC134164F;
	Tue, 26 Aug 2025 13:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hOfyCw0P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E563B28314A
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215881; cv=none; b=cczhhQwLMLL3GLbxCVA7Sf7s1zhXHAYNgEOVCU38ZdcWTnWkREFH4YXijhqRXxF5iKEsrdRYdR0Mgcs4ZXR8ks4sLdk48K9k4hHbqCVVqzoHbDuD2IQOYOvB+gUx5YWImQuzJWpkmApRBwKdIWd8giSkuDPSYrltxLknNss0EQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215881; c=relaxed/simple;
	bh=zWAKrT5aXRacyvI/xWI4HTQPysUMECO5DqN9YWAZKbo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IwmwN/l1jlECJBF/wRrdrwiAeYt58/T201p0zu/pcOX/OUnkeZ/XVImwxBzGpzwBtuLqZsbIpPjLg4VixsrV1/Ewh/2C5EyKJUQDT8TuqHeskwR3Oq/TaSAHWcZUWRrmybdx79fQD6OFiCfZV+t1vDgjds5y/ZTFtSuD0WCUBPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hOfyCw0P; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4b109bc103bso127068881cf.2
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 06:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756215878; x=1756820678; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PXJn9qv3NI26YZtuMYTJM3upI2RbF2M/lJqKP/AvZlA=;
        b=hOfyCw0Pq/Xiw8eQaXZkt6SqeSeXk7qom9KCDTihKMuiqr+DgCBfzfzdDOWEDAQ3h7
         3xywx/BZcpfREG0ueqLbC3rQNSLCSl1NDMafIH9+iNAH0VN0dTPMm4x3CwqH7yTLIPSt
         A1FtmkzHCgWqrnNIQa7m6yaKW6Y7enrh033XrkO9e+DLueXyhz/Am5kQTXsOGM3YM3ar
         Y534KWSlnomkUQ85fPjuidU1wgluchH17N2Iv4y/bECe83LICKg6ixNlVVehTRtpkoWq
         HaHnkOiqhu6Ek+wwQcktHJdnXr5onnnFUq55NrF9gbshnr8cLE43JxxreOrnB+DRW1Zy
         CctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756215878; x=1756820678;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PXJn9qv3NI26YZtuMYTJM3upI2RbF2M/lJqKP/AvZlA=;
        b=cBRmY6MUytZBh40RaOTjhI7vWns0FcAedNqS+B5+uyvwA1ljJJfuD2QYlHJO9JWt09
         hK81Qufk+iRahqLa1h2hJvtW/BcEUSEG2HVZcu8hBKvEn+uudfJWZ2UHVBY7BQU1bpQ9
         a1c7ZoEroMB0f6y0vAUEG/agTFiLtFc+8/VDgZ6ewoo0mRtCHGkNwU0RmN5t7f29qVhN
         skrd2smAliGWs/dehG4mL9XTZhZUep+qxjcruoCPCGtmIbILoDT18X+YgtWJC3yp2IXI
         lQNFchuTwUHNbl/1ZY8kqaq16XCeMCQ01mW2RVqfYkvibzbp1Rn0KAMJKVlAyiG9Pf3+
         Ik4A==
X-Forwarded-Encrypted: i=1; AJvYcCWG1cl18mNgctGt7QPCXFgSxfWPC2BmgDmQfqBoIjZCtFumu4dQgQMHqw9lVs/A+dtwGJTMdsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YykhsPoAQsrd9Fz0/feuoNd6N8Pjy2R3JYerST41jy4/aEL6BZ9
	MaO1yiQ+5LSnTbswBNLkQXMNi2ZL0z5sqfn0Z+f6hJLlMQNf+xrflhpHZMGaA5SEMhxb/be2mkp
	ezbyRpUbD1lHETg==
X-Google-Smtp-Source: AGHT+IGwaBUKFtaV3pnv4At9fvfE9ITZTUMEQynRZL+fTM30rsInwVt7zF+OXf3h1NBfS+UH1oDJwIfEmJkcQg==
X-Received: from qkpf18.prod.google.com ([2002:a05:620a:2812:b0:7e6:83de:848c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:59c1:0:b0:4b1:2775:5721 with SMTP id d75a77b69052e-4b2aaa05f9amr227405091cf.16.1756215877140;
 Tue, 26 Aug 2025 06:44:37 -0700 (PDT)
Date: Tue, 26 Aug 2025 13:44:35 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250826134435.1683435-1-edumazet@google.com>
Subject: [PATCH net] l2tp: do not use sock_hold() in pppol2tp_session_get_sock()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, James Chapman <jchapman@katalix.com>, 
	Guillaume Nault <gnault@redhat.com>
Content-Type: text/plain; charset="UTF-8"

pppol2tp_session_get_sock() is using RCU, it must be ready
for sk_refcnt being zero.

Commit ee40fb2e1eb5 ("l2tp: protect sock pointer of
struct pppol2tp_session with RCU") was correct because it
had a call_rcu(..., pppol2tp_put_sk) which was later removed in blamed commit.

pppol2tp_recv() can use pppol2tp_session_get_sock() as well.

Fixes: c5cbaef992d6 ("l2tp: refactor ppp socket/session relationship")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: James Chapman <jchapman@katalix.com>
Cc: Guillaume Nault <gnault@redhat.com>
---
 net/l2tp/l2tp_ppp.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index fc5c2fd8f34c7ec23e6f5ab978ea96c9f48ac81d..5e12e7ce17d8a7cf4afc2486f1c3c42f98feddf1 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -129,22 +129,12 @@ static const struct ppp_channel_ops pppol2tp_chan_ops = {
 
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
-
-	rcu_read_lock();
-	sk = rcu_dereference(ps->sk);
-	if (sk)
-		sock_hold(sk);
-	rcu_read_unlock();
 
-	return sk;
+	return rcu_dereference(ps->sk);
 }
 
 /* Helpers to obtain tunnel/session contexts from sockets.
@@ -206,14 +196,13 @@ static int pppol2tp_recvmsg(struct socket *sock, struct msghdr *msg,
 
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
 
@@ -510,13 +499,14 @@ static void pppol2tp_show(struct seq_file *m, void *arg)
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
@@ -1530,6 +1520,7 @@ static void pppol2tp_seq_session_show(struct seq_file *m, void *v)
 		port = ntohs(inet->inet_sport);
 	}
 
+	rcu_read_lock();
 	sk = pppol2tp_session_get_sock(session);
 	if (sk) {
 		state = sk->sk_state;
@@ -1565,8 +1556,8 @@ static void pppol2tp_seq_session_show(struct seq_file *m, void *v)
 		struct pppox_sock *po = pppox_sk(sk);
 
 		seq_printf(m, "   interface %s\n", ppp_dev_name(&po->chan));
-		sock_put(sk);
 	}
+	rcu_read_unlock();
 }
 
 static int pppol2tp_seq_show(struct seq_file *m, void *v)
-- 
2.51.0.261.g7ce5a0a67e-goog


