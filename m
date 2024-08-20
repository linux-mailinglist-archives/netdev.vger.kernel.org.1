Return-Path: <netdev+bounces-119979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13263957C17
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 05:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61F1F2882D7
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 03:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6A83A1A8;
	Tue, 20 Aug 2024 03:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.jp header.i=@amazon.co.jp header.b="X4CGhDA1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADC21798C
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 03:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724125830; cv=none; b=armihA0j1gho0TLA13x7CPCGoX1+bfGMz/8eTUF8kyeXluytR0O0GbymvlHc/4wfFJO+uVbevfnTaGgrQ551yJXtEw9uJ7LsMGE8sjIr+Bya5qt2bZOGyw9hnK41zPmw5g0CDegSTcsYkuMkCFr7HCGY3NqF4Imcbb69D/Ys7MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724125830; c=relaxed/simple;
	bh=Pt5waskMZMVIKLtZnSPO44a1s/byvbPgd5xCGwpQyUU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FDO22Ott5TiIFDdZc8l+xXERcdmjqWp0MXp3CBTW5UbLwVz1zCxKxfDxSEodIAwt/Hj0aD+ABc+BoeiLhqxkaRdewNaKklyLygr/sN3I+rFX5PEOmJsog7ntxV+lMAmCr2YearkMKytWSD4V+n+rxOpafIkiBxPgwSb+4dgV+RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.jp; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.co.jp header.i=@amazon.co.jp header.b=X4CGhDA1; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.jp; i=@amazon.co.jp; q=dns/txt;
  s=amazon201209; t=1724125828; x=1755661828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tGKEukXxHIUnOPxa0EUkZ9/XpceVO6QUaDM+pLVigm4=;
  b=X4CGhDA1IfWw+w4lCKKaKTWxfOzqNIeZc98LB6Ok74t26uwdvtKb1FGm
   wIvWIDpC9iPZMLPdgC3o7QJdaXXEmabsnLjNRsxWlqFr2q9bZ1Q4hfM23
   BZInuuxXPoVMiAiCFOOXSHucttHGK5mWJGdZfGgp22Dudf6WAj5CLfQew
   0=;
X-IronPort-AV: E=Sophos;i="6.10,160,1719878400"; 
   d="scan'208";a="117047994"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 03:50:28 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:50615]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.141:2525] with esmtp (Farcaster)
 id 5f4b3d4a-1eba-4b7f-afc7-6cb843a0084c; Tue, 20 Aug 2024 03:50:28 +0000 (UTC)
X-Farcaster-Flow-ID: 5f4b3d4a-1eba-4b7f-afc7-6cb843a0084c
Received: from EX19D005ANA004.ant.amazon.com (10.37.240.178) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 20 Aug 2024 03:50:27 +0000
Received: from 682f678c4465.ant.amazon.com (10.119.0.197) by
 EX19D005ANA004.ant.amazon.com (10.37.240.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 20 Aug 2024 03:50:23 +0000
From: Takamitsu Iwai <takamitz@amazon.co.jp>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Takamitsu Iwai
	<takamitz@amazon.co.jp>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 1/2] tcp: Don't drop head OOB when queuing new OOB.
Date: Tue, 20 Aug 2024 12:49:19 +0900
Message-ID: <20240820034920.77419-2-takamitz@amazon.co.jp>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240820034920.77419-1-takamitz@amazon.co.jp>
References: <20240820034920.77419-1-takamitz@amazon.co.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC001.ant.amazon.com (10.13.139.233) To
 EX19D005ANA004.ant.amazon.com (10.37.240.178)

If OOB is not at the head of recvq, it's not dropped when a new OOB is
queued.

OTOH, as commit f5ea0768a255 ("selftest: af_unix: Add
non-TCP-compliant test cases in msg_oob.c.") points out, TCP drops OOB
data at the head of recvq when queuing a new OOB data subsequently.

This behavior has been introduced in tcp_check_urg() by deleting
preceding skb when next MSG_OOB data is received. This process is
weird OOB handling, and the comment also says this is wrong.

We remove this code block for appropriate OOB handling.

Now TCP works exactly the same way as AF_UNIX, so this patch enables
kernel to pass the test when removing tcp_incompliant braces.

 #  RUN           msg_oob.no_peek.inline_ex_oob_drop ...
 #            OK  msg_oob.no_peek.inline_ex_oob_drop
 ok 18 msg_oob.no_peek.inline_ex_oob_drop
 #  RUN           msg_oob.peek.ex_oob_drop ...
 #            OK  msg_oob.peek.ex_oob_drop
 ok 28 msg_oob.peek.ex_oob_drop
 #  RUN           msg_oob.peek.ex_oob_drop_2 ...
 #            OK  msg_oob.peek.ex_oob_drop_2
 ok 29 msg_oob.peek.ex_oob_drop_2

Fixes tag refers to the commit of Linux-2.6.12-rc2, but this code was
written at v2.4.4 which is older than this version.

This is a long-standing bug since then, and technically the patch
slightly changes uAPI, but RFC 6091, published in 2011, suggests TCP
urgent mechanism should not be used for newer applications in 2011.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Takamitsu Iwai <takamitz@amazon.co.jp>
---
 net/ipv4/tcp_input.c                          | 25 ---------
 tools/testing/selftests/net/af_unix/msg_oob.c | 55 ++++++++-----------
 2 files changed, 22 insertions(+), 58 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index e37488d3453f..648d0f3ade78 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5830,31 +5830,6 @@ static void tcp_check_urg(struct sock *sk, const struct tcphdr *th)
 	/* Tell the world about our new urgent pointer. */
 	sk_send_sigurg(sk);
 
-	/* We may be adding urgent data when the last byte read was
-	 * urgent. To do this requires some care. We cannot just ignore
-	 * tp->copied_seq since we would read the last urgent byte again
-	 * as data, nor can we alter copied_seq until this data arrives
-	 * or we break the semantics of SIOCATMARK (and thus sockatmark())
-	 *
-	 * NOTE. Double Dutch. Rendering to plain English: author of comment
-	 * above did something sort of 	send("A", MSG_OOB); send("B", MSG_OOB);
-	 * and expect that both A and B disappear from stream. This is _wrong_.
-	 * Though this happens in BSD with high probability, this is occasional.
-	 * Any application relying on this is buggy. Note also, that fix "works"
-	 * only in this artificial test. Insert some normal data between A and B and we will
-	 * decline of BSD again. Verdict: it is better to remove to trap
-	 * buggy users.
-	 */
-	if (tp->urg_seq == tp->copied_seq && tp->urg_data &&
-	    !sock_flag(sk, SOCK_URGINLINE) && tp->copied_seq != tp->rcv_nxt) {
-		struct sk_buff *skb = skb_peek(&sk->sk_receive_queue);
-		tp->copied_seq++;
-		if (skb && !before(tp->copied_seq, TCP_SKB_CB(skb)->end_seq)) {
-			__skb_unlink(skb, &sk->sk_receive_queue);
-			__kfree_skb(skb);
-		}
-	}
-
 	WRITE_ONCE(tp->urg_data, TCP_URG_NOTYET);
 	WRITE_ONCE(tp->urg_seq, ptr);
 
diff --git a/tools/testing/selftests/net/af_unix/msg_oob.c b/tools/testing/selftests/net/af_unix/msg_oob.c
index 535eb2c3d7d1..f3435575dfa5 100644
--- a/tools/testing/selftests/net/af_unix/msg_oob.c
+++ b/tools/testing/selftests/net/af_unix/msg_oob.c
@@ -484,20 +484,17 @@ TEST_F(msg_oob, ex_oob_drop)
 	epollpair(true);
 	siocatmarkpair(true);
 
-	sendpair("y", 1, MSG_OOB);		/* TCP drops "x" at this moment. */
+	sendpair("y", 1, MSG_OOB);
 	epollpair(true);
+	siocatmarkpair(false);
 
-	tcp_incompliant {
-		siocatmarkpair(false);
-
-		recvpair("x", 1, 1, 0);		/* TCP drops "y" by passing through it. */
-		epollpair(true);
-		siocatmarkpair(true);
+	recvpair("x", 1, 1, 0);
+	epollpair(true);
+	siocatmarkpair(true);
 
-		recvpair("y", 1, 1, MSG_OOB);	/* TCP returns -EINVAL. */
-		epollpair(false);
-		siocatmarkpair(true);
-	}
+	recvpair("y", 1, 1, MSG_OOB);
+	epollpair(false);
+	siocatmarkpair(true);
 }
 
 TEST_F(msg_oob, ex_oob_drop_2)
@@ -506,23 +503,17 @@ TEST_F(msg_oob, ex_oob_drop_2)
 	epollpair(true);
 	siocatmarkpair(true);
 
-	sendpair("y", 1, MSG_OOB);		/* TCP drops "x" at this moment. */
+	sendpair("y", 1, MSG_OOB);
 	epollpair(true);
-
-	tcp_incompliant {
-		siocatmarkpair(false);
-	}
+	siocatmarkpair(false);
 
 	recvpair("y", 1, 1, MSG_OOB);
 	epollpair(false);
+	siocatmarkpair(false);
 
-	tcp_incompliant {
-		siocatmarkpair(false);
-
-		recvpair("x", 1, 1, 0);		/* TCP returns -EAGAIN. */
-		epollpair(false);
-		siocatmarkpair(true);
-	}
+	recvpair("x", 1, 1, 0);
+	epollpair(false);
+	siocatmarkpair(true);
 }
 
 TEST_F(msg_oob, ex_oob_ahead_break)
@@ -692,22 +683,20 @@ TEST_F(msg_oob, inline_ex_oob_drop)
 	epollpair(true);
 	siocatmarkpair(true);
 
-	sendpair("y", 1, MSG_OOB);		/* TCP drops "x" at this moment. */
+	sendpair("y", 1, MSG_OOB);
 	epollpair(true);
 
 	setinlinepair();
 
-	tcp_incompliant {
-		siocatmarkpair(false);
+	siocatmarkpair(false);
 
-		recvpair("x", 1, 1, 0);		/* TCP recv()s "y". */
-		epollpair(true);
-		siocatmarkpair(true);
+	recvpair("x", 1, 1, 0);
+	epollpair(true);
+	siocatmarkpair(true);
 
-		recvpair("y", 1, 1, 0);		/* TCP returns -EAGAIN. */
-		epollpair(false);
-		siocatmarkpair(false);
-	}
+	recvpair("y", 1, 1, 0);
+	epollpair(false);
+	siocatmarkpair(false);
 }
 
 TEST_F(msg_oob, inline_ex_oob_siocatmark)
-- 
2.39.3 (Apple Git-145)


