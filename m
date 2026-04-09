Return-Path: <netdev+bounces-277032-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHB/E06+12mdSQgAu9opvQ
	(envelope-from <netdev+bounces-277032-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 16:57:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A430C3CC46A
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 16:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBFCC301DBA4
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 14:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8773C3BFB;
	Thu,  9 Apr 2026 14:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o3scCBWH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F7B3A4530
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775746591; cv=none; b=tY9f3XreWFHwfgdrEn9hHZ1jP5LNiyrtNsQl9tabf0VXxcqd0TUCuZI8twWLttBE+VzZY5hq+NzDWxVQ0LVQ+lDEtW4W5t1n4t1D1ztki+iARyv4OdKqey97bgOP3GVUj/jcRNXZS0dcop1zlZCKKWFMOi73M5sVGqYX3UZ13uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775746591; c=relaxed/simple;
	bh=f/BO4LfEXn3cNWZ/cbeKz2vnPf6DitJoyqF2EuF6Qr8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fQJvOcphKOoUnt9QGQvui4SrVJ7nlFKjChtGFqWlWiVCDFYCUW5WSnAc7VeYSU8ORB9D/6IhWm/yfQxCuTlo1qzj8aNRvOL6bwcIrSwv6/ccZYQBSsb0fhQoQJ5Pr05BcT85f+9HgE6le6L34Ptb3tZervsTc+017EbCRunP6CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o3scCBWH; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8cfc1634e43so97612685a.0
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 07:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775746588; x=1776351388; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f44dOgVDvsb9zeIo/lXcg0EZW5uwK6oe6PLXzbsPwnE=;
        b=o3scCBWHv+lfPeKRS+4ghC1K5/9lQxcevxvP4+zjj0pv9IzEqKALLryPAajFESYc5T
         0jWQA0hVNeYCq43kOEDva2IV3a3iOzDP5EOsEMxJX7KXsrK0ZKp4H3nqGKDz9cKBLADy
         Qvp1iq8FJiplwBSUbfu4zP1dBupldw2lBzGxzEm8hmHUccupL3agyc8Qcz6gqVLSYvYw
         eFLOZxu6JiMY/3X30eivoGgm/PNmQB6lynvqADmnIwS65/Ckwy3zxEfr5V4zWDhbWhP8
         YHiG/xKvvZqza7pavzGqkGLe+liOSDgcBtay5AMS2yEVj4UlyathHOShyJJn1iacS2I6
         1Vaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775746588; x=1776351388;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f44dOgVDvsb9zeIo/lXcg0EZW5uwK6oe6PLXzbsPwnE=;
        b=cFFFY7yiAIPzwJtl/xG3m5ohdTVCI/zjtWPwta9wXqx8Bvw0IhCyOE8z0ZQgWubO3E
         LCh38VShukWuhirEkt6YRC33uZKhtEL3nFHi5q+av2j2ePcdex9TfyWH5/oPxuqn0Q7A
         P/3zYXGOYmLyiBI0Le4D0yLlhFqvhEzWlLFq0mahTD8V2Kb+cTNxNKaDTfyhsywb1Oxw
         j5/dmGo+pzXy9TE2En7bK2sAEJeYVOkTVPZHpJpbowPrSwAyZzSSC4K4eu+nLTE3/pCh
         ukfUM9tCQGaR4rqTvOdLg5FuqrXe5qM7oy1FkgXs8vVAmLhPQarmRuxeayVvx4inAwnY
         u31A==
X-Forwarded-Encrypted: i=1; AJvYcCUpkXwSURf1UMnlr0gcJI1vzyHYDYRO0Oiw/hdgtuyEjLjC4PpVrVzHYafqNOUR7I137ZP6gdI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0eRHn3a7dTyf/Vuoyv2ic0kzHTTbU5NTmg3XIlkFsWHd+vpPG
	6NSGZbaQc59zU1jXhIQhZfnVfqrxocvXG5/qjtTV6YKRrDKNTYCoPMwBGRPpuxK3Sk6GE5Bpv9w
	qyxiv88RTQPfQbg==
X-Received: from qknwc5.prod.google.com ([2002:a05:620a:7205:b0:8d4:abda:a95])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:298f:b0:8cf:d3ca:535c with SMTP id af79cd13be357-8d4183df498mr3481833185a.4.1775746588297;
 Thu, 09 Apr 2026 07:56:28 -0700 (PDT)
Date: Thu,  9 Apr 2026 14:56:20 +0000
In-Reply-To: <20260409145625.2306224-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409145625.2306224-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409145625.2306224-2-edumazet@google.com>
Subject: [PATCH net-next 1/5] net: change sock_queue_rcv_skb_reason() to
 return a drop_reason
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277032-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vmlinux.new:url]
X-Rspamd-Queue-Id: A430C3CC46A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Change sock_queue_rcv_skb_reason() to return the drop_reason directly
instead of using a reference.

This is part of an effort to remove stack canaries and reduce bloat.

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/0 grow/shrink: 3/7 up/down: 79/-301 (-222)
Function                                     old     new   delta
vsock_queue_rcv_skb                           50      79     +29
ipmr_cache_report                           1290    1315     +25
ip6mr_cache_report                          1322    1347     +25
packet_rcv_spkt                              329     327      -2
sock_queue_rcv_skb_reason                    166     128     -38
raw_rcv_skb                                  122      80     -42
ping_queue_rcv_skb                           109      61     -48
ping_rcv                                     215     162     -53
rawv6_rcv_skb                                278     224     -54
raw_rcv                                      591     527     -64
Total: Before=29722890, After=29722668, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h     | 17 ++++++++++++++---
 net/can/bcm.c          |  5 ++---
 net/can/isotp.c        |  3 ++-
 net/can/j1939/socket.c |  3 ++-
 net/can/raw.c          |  3 ++-
 net/core/sock.c        | 20 ++++++--------------
 net/ipv4/ping.c        |  3 ++-
 net/ipv4/raw.c         |  3 ++-
 net/ipv6/raw.c         |  3 ++-
 9 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 7d51ac9e7d9a87a7f6f0453a3d3e2c6ed34dc151..5831a4d1ebe77e3d6f568d208fafb072f9635242 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2502,12 +2502,23 @@ int __sk_queue_drop_skb(struct sock *sk, struct sk_buff_head *sk_queue,
 					   struct sk_buff *skb));
 int __sock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb);
 
-int sock_queue_rcv_skb_reason(struct sock *sk, struct sk_buff *skb,
-			      enum skb_drop_reason *reason);
+enum skb_drop_reason
+sock_queue_rcv_skb_reason(struct sock *sk, struct sk_buff *skb);
 
 static inline int sock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 {
-	return sock_queue_rcv_skb_reason(sk, skb, NULL);
+	enum skb_drop_reason drop_reason = sock_queue_rcv_skb_reason(sk, skb);
+
+	switch (drop_reason) {
+	case SKB_DROP_REASON_SOCKET_RCVBUFF:
+		return -ENOMEM;
+	case SKB_DROP_REASON_PROTO_MEM:
+		return -ENOBUFS;
+	case 0:
+		return 0;
+	default:
+		return -EPERM;
+	}
 }
 
 int sock_queue_err_skb(struct sock *sk, struct sk_buff *skb);
diff --git a/net/can/bcm.c b/net/can/bcm.c
index fd9fa072881e22ced725fa77dd096dea07fb73a6..d6291381afb09c36b30557f1d1a328c9ed0579f7 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -363,7 +363,6 @@ static void bcm_send_to_user(struct bcm_op *op, struct bcm_msg_head *head,
 	struct sockaddr_can *addr;
 	struct sock *sk = op->sk;
 	unsigned int datalen = head->nframes * op->cfsiz;
-	int err;
 	unsigned int *pflags;
 	enum skb_drop_reason reason;
 
@@ -420,8 +419,8 @@ static void bcm_send_to_user(struct bcm_op *op, struct bcm_msg_head *head,
 	addr->can_family  = AF_CAN;
 	addr->can_ifindex = op->rx_ifindex;
 
-	err = sock_queue_rcv_skb_reason(sk, skb, &reason);
-	if (err < 0) {
+	reason = sock_queue_rcv_skb_reason(sk, skb);
+	if (reason) {
 		struct bcm_sock *bo = bcm_sk(sk);
 
 		sk_skb_reason_drop(sk, skb, reason);
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 2770f43f4951884658d54ac90bd1e0ae21c24102..c48b4a818297e2a1348a2b64016d0f4ff613e683 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -291,7 +291,8 @@ static void isotp_rcv_skb(struct sk_buff *skb, struct sock *sk)
 	addr->can_family = AF_CAN;
 	addr->can_ifindex = skb->dev->ifindex;
 
-	if (sock_queue_rcv_skb_reason(sk, skb, &reason) < 0)
+	reason = sock_queue_rcv_skb_reason(sk, skb);
+	if (reason)
 		sk_skb_reason_drop(sk, skb, reason);
 }
 
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 0502b030d23851652be252f1342861332ce97367..50a598ef5fd4a5f5e007816a341e04ddbcc724e6 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -333,7 +333,8 @@ static void j1939_sk_recv_one(struct j1939_sock *jsk, struct sk_buff *oskb)
 	if (skb->sk)
 		skcb->msg_flags |= MSG_DONTROUTE;
 
-	if (sock_queue_rcv_skb_reason(&jsk->sk, skb, &reason) < 0)
+	reason = sock_queue_rcv_skb_reason(&jsk->sk, skb);
+	if (reason)
 		sk_skb_reason_drop(&jsk->sk, skb, reason);
 }
 
diff --git a/net/can/raw.c b/net/can/raw.c
index eee244ffc31ecc0e1cc1aae29cd1d13a4e6b54ca..56c95c768778accaec42cb998c7d679a42c85894 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -207,7 +207,8 @@ static void raw_rcv(struct sk_buff *oskb, void *data)
 	if (oskb->sk == sk)
 		*pflags |= MSG_CONFIRM;
 
-	if (sock_queue_rcv_skb_reason(sk, skb, &reason) < 0)
+	reason = sock_queue_rcv_skb_reason(sk, skb);
+	if (reason)
 		sk_skb_reason_drop(sk, skb, reason);
 }
 
diff --git a/net/core/sock.c b/net/core/sock.c
index e821b95e00151ab6b4be89209abcbaa494234433..d39a4d6ccafd9e03f4e82482d3f3e46ce5d58771 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -520,32 +520,24 @@ int __sock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(__sock_queue_rcv_skb);
 
-int sock_queue_rcv_skb_reason(struct sock *sk, struct sk_buff *skb,
-			      enum skb_drop_reason *reason)
+enum skb_drop_reason
+sock_queue_rcv_skb_reason(struct sock *sk, struct sk_buff *skb)
 {
 	enum skb_drop_reason drop_reason;
 	int err;
 
 	err = sk_filter_reason(sk, skb, &drop_reason);
 	if (err)
-		goto out;
+		return drop_reason;
 
 	err = __sock_queue_rcv_skb(sk, skb);
 	switch (err) {
 	case -ENOMEM:
-		drop_reason = SKB_DROP_REASON_SOCKET_RCVBUFF;
-		break;
+		return SKB_DROP_REASON_SOCKET_RCVBUFF;
 	case -ENOBUFS:
-		drop_reason = SKB_DROP_REASON_PROTO_MEM;
-		break;
-	default:
-		drop_reason = SKB_NOT_DROPPED_YET;
-		break;
+		return SKB_DROP_REASON_PROTO_MEM;
 	}
-out:
-	if (reason)
-		*reason = drop_reason;
-	return err;
+	return SKB_NOT_DROPPED_YET;
 }
 EXPORT_SYMBOL(sock_queue_rcv_skb_reason);
 
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index bda245c808938cf2a26270bcd83c74898e5b36dd..1273d1028ed9ca91734481f65652bfc43efd039a 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -935,7 +935,8 @@ static enum skb_drop_reason __ping_queue_rcv_skb(struct sock *sk,
 
 	pr_debug("ping_queue_rcv_skb(sk=%p,sk->num=%d,skb=%p)\n",
 		 inet_sk(sk), inet_sk(sk)->inet_num, skb);
-	if (sock_queue_rcv_skb_reason(sk, skb, &reason) < 0) {
+	reason = sock_queue_rcv_skb_reason(sk, skb);
+	if (reason) {
 		sk_skb_reason_drop(sk, skb, reason);
 		pr_debug("ping_queue_rcv_skb -> failed\n");
 		return reason;
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 34859e537b4926f15996dd1a684ae59a55a1643a..319428bf06bb89932c0b4295a0f96c275f8ecab1 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -300,7 +300,8 @@ static int raw_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	/* Charge it to the socket. */
 
 	ipv4_pktinfo_prepare(sk, skb, true);
-	if (sock_queue_rcv_skb_reason(sk, skb, &reason) < 0) {
+	reason = sock_queue_rcv_skb_reason(sk, skb);
+	if (reason) {
 		sk_skb_reason_drop(sk, skb, reason);
 		return NET_RX_DROP;
 	}
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 0ac7046911000d30056e0d1f49a58964c61308cf..3cc58698cbbd3a16cf0145e0afff7a6cec8dc56f 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -369,7 +369,8 @@ static inline int rawv6_rcv_skb(struct sock *sk, struct sk_buff *skb)
 
 	/* Charge it to the socket. */
 	skb_dst_drop(skb);
-	if (sock_queue_rcv_skb_reason(sk, skb, &reason) < 0) {
+	reason = sock_queue_rcv_skb_reason(sk, skb);
+	if (reason) {
 		sk_skb_reason_drop(sk, skb, reason);
 		return NET_RX_DROP;
 	}
-- 
2.53.0.1213.gd9a14994de-goog


