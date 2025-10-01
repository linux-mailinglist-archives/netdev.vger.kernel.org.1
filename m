Return-Path: <netdev+bounces-227427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B01BAF029
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 04:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C49A7A29EB
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 02:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADE326FDAC;
	Wed,  1 Oct 2025 02:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkYJZ5qT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5503522D9E9
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 02:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759285471; cv=none; b=LMJdJHjUZiV4B8MnZn8Ph1Bvautmx8I6g9mhqJwNLS9OuXkZLK1RRDBYNxb/+Sa3ccNAMJNDCbTQ7OUqtNAH+ljnR3mHoThwveRdOIMWGLNJJW+l/6SPRqHEIYcKlzs/CPoPhkzEQHyhrDHhQltreScEhy+ag0rWFFnxsL9WZgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759285471; c=relaxed/simple;
	bh=n6xDsteRLsE/ZRZjmO1Yn9bGgXgMqHOW5Lc6maqkkb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QsrtflrHp98G+IjHg18Hgtf/AQl2YzYfx//vl5/YNSqpE27chOLYhOdEtt+TTnc9/q+MuLadLFtaDwzE/oqbb1r2I1qkVvIQo+cQhUFqkAzw/xOtK/bWjHY6SbqMIahSFo7AvXds8b2+leZoiOHbFn8qqIkKerSQuTApaBzqafA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkYJZ5qT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66035C113D0;
	Wed,  1 Oct 2025 02:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759285470;
	bh=n6xDsteRLsE/ZRZjmO1Yn9bGgXgMqHOW5Lc6maqkkb8=;
	h=From:To:Cc:Subject:Date:From;
	b=MkYJZ5qT9bEdrNliyL8VCf80OwK8qerGdiIpDU4pH4sXojnyJQefjfwQCHhUf6yrG
	 O+kp1M9dGTeblQb1eJiFYJe9KbATvLpdPjUDSDG9Zc2WT9cW4vpOydO/jumVqBSIyi
	 WETXqD704qKVe8BC31mrX+J1aZ4+8nSDwTQnRzM8CztHQ7KYvleqsmNvGZCIj0tkTR
	 aIhTuHFsunTbrkvX040Mz+bG1ZvfU6QR+zedoXDyIRt3yUUEt4cTdl1cPqK4EgOMqN
	 xtY0kIAnISCf2iwFyxEXHbPQcITYhyR4JFnnlRQvapbcpniFkusF6mMFd6eobS42Cq
	 7UPu3tNsFK1wA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	ncardwell@google.com,
	kuniyu@google.com,
	daniel.zahka@gmail.com,
	willemb@google.com
Subject: [PATCH net-next] net: psp: don't assume reply skbs will have a socket
Date: Tue, 30 Sep 2025 19:24:26 -0700
Message-ID: <20251001022426.2592750-1-kuba@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rx path may be passing around unreferenced sockets, which means
that skb_set_owner_edemux() may not set skb->sk and PSP will crash:

  KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
  RIP: 0010:psp_reply_set_decrypted (./include/net/psp/functions.h:132 net/psp/psp_sock.c:287)
    tcp_v6_send_response.constprop.0 (net/ipv6/tcp_ipv6.c:979)
    tcp_v6_send_reset (net/ipv6/tcp_ipv6.c:1140 (discriminator 1))
    tcp_v6_do_rcv (net/ipv6/tcp_ipv6.c:1683)
    tcp_v6_rcv (net/ipv6/tcp_ipv6.c:1912)

Fixes: 659a2899a57d ("tcp: add datapath logic for PSP with inline key exchange")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: ncardwell@google.com
CC: kuniyu@google.com
CC: daniel.zahka@gmail.com
CC: willemb@google.com
---
 include/net/psp/functions.h | 4 ++--
 net/ipv4/ip_output.c        | 2 +-
 net/ipv6/tcp_ipv6.c         | 2 +-
 net/psp/psp_sock.c          | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/net/psp/functions.h b/include/net/psp/functions.h
index ef7743664da3..c5c23a54774e 100644
--- a/include/net/psp/functions.h
+++ b/include/net/psp/functions.h
@@ -34,7 +34,7 @@ unsigned int psp_key_size(u32 version);
 void psp_sk_assoc_free(struct sock *sk);
 void psp_twsk_init(struct inet_timewait_sock *tw, const struct sock *sk);
 void psp_twsk_assoc_free(struct inet_timewait_sock *tw);
-void psp_reply_set_decrypted(struct sk_buff *skb);
+void psp_reply_set_decrypted(const struct sock *sk, struct sk_buff *skb);
 
 static inline struct psp_assoc *psp_sk_assoc(const struct sock *sk)
 {
@@ -160,7 +160,7 @@ static inline void
 psp_twsk_init(struct inet_timewait_sock *tw, const struct sock *sk) { }
 static inline void psp_twsk_assoc_free(struct inet_timewait_sock *tw) { }
 static inline void
-psp_reply_set_decrypted(struct sk_buff *skb) { }
+psp_reply_set_decrypted(const struct sock *sk, struct sk_buff *skb) { }
 
 static inline struct psp_assoc *psp_sk_assoc(const struct sock *sk)
 {
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 5ca97ede979c..ff11d3a85a36 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1668,7 +1668,7 @@ void ip_send_unicast_reply(struct sock *sk, const struct sock *orig_sk,
 		nskb->ip_summed = CHECKSUM_NONE;
 		if (orig_sk) {
 			skb_set_owner_edemux(nskb, (struct sock *)orig_sk);
-			psp_reply_set_decrypted(nskb);
+			psp_reply_set_decrypted(orig_sk, nskb);
 		}
 		if (transmit_time)
 			nskb->tstamp_type = SKB_CLOCK_MONOTONIC;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 9622c2776ade..59c4977a811a 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -974,7 +974,7 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 	if (sk) {
 		/* unconstify the socket only to attach it to buff with care. */
 		skb_set_owner_edemux(buff, (struct sock *)sk);
-		psp_reply_set_decrypted(buff);
+		psp_reply_set_decrypted(sk, buff);
 
 		if (sk->sk_state == TCP_TIME_WAIT)
 			mark = inet_twsk(sk)->tw_mark;
diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
index 5324a7603bed..a931d825d1cc 100644
--- a/net/psp/psp_sock.c
+++ b/net/psp/psp_sock.c
@@ -279,12 +279,12 @@ void psp_twsk_assoc_free(struct inet_timewait_sock *tw)
 	psp_assoc_put(pas);
 }
 
-void psp_reply_set_decrypted(struct sk_buff *skb)
+void psp_reply_set_decrypted(const struct sock *sk, struct sk_buff *skb)
 {
 	struct psp_assoc *pas;
 
 	rcu_read_lock();
-	pas = psp_sk_get_assoc_rcu(skb->sk);
+	pas = psp_sk_get_assoc_rcu(sk);
 	if (pas && pas->tx.spi)
 		skb->decrypted = 1;
 	rcu_read_unlock();
-- 
2.51.0


