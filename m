Return-Path: <netdev+bounces-165359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D07A31BC0
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 03:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D9A18899AF
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 02:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AA71D515A;
	Wed, 12 Feb 2025 02:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaTB330s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D426F1C462D
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 02:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739326313; cv=none; b=ExrHg2Upx2sIox/Lytp7jcd9y+RP5/BYLHPZoMU4cgcoYc8L8+ESokqVLZycJWKDDpVw/UlbubDxkwFA15nD0Ow81EHJAHQUPT/kZrGeUE1Sno2cJEGQg0QiMTbIIzzick5NbYHEV3nsbKSxGxkIP4vYEFiASZqWQLNt5CDWuUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739326313; c=relaxed/simple;
	bh=m4S/w2T8OkBnZvB+e9Gt8KisVeTLYNX5SCtA76hGXHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YW2Sx41eFzzMxyW6lNe/t/x24IxI24piWv3zAx+p3rQ2MBdBdWB5q/mIJu8lvOTypMH0xl3kiyGD0pkN++jLFf0VER3SxbKhnG82nN2Wa5tOB4ZPt05o/Mcms1yIkTqSUpTo5nZcRnaZKLGkuAD1E+Uhfhcj2xBsfZTGxzANkm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FaTB330s; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e432beabbdso47266776d6.3
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 18:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739326311; x=1739931111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbajb8qUJqVRLMyDn6njuBObgVVKqIDxpjIdJ1kBpV0=;
        b=FaTB330sr7ZXWI+oDwk7jQ9WaeMu/4H9cZrOm9jE6P9DkhgNa22ifaMUtoNw55ZUie
         FQQ/DfU8dSyow+z7v2EbTCxDvXE0TWXOAba71HJ5mbk/TYwaRdHuYk0rMP7DMV8Q6Ig3
         SyRguNe3Ofhp3iLKV6w5y0+D1IHwb30+sX4Ni1gw4iKAQ1r3RSifWsd8L6WP6bmZu7Ay
         Mr2asAGjpPfq3MGiqfjfuIvRvimXdUjKb328WreyZ3/1jddLkxEmYzULNU4PZGFtdYWO
         KwgmG62mTXmElJq3cgLS8LDOB/ZGcu/9bPmA5h9IQijq/N5tkzycJNwbNMCmrlkJ8UPD
         M7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739326311; x=1739931111;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbajb8qUJqVRLMyDn6njuBObgVVKqIDxpjIdJ1kBpV0=;
        b=B3IzMikhxgol6rDgzvX6cVufzJ3K3qYlcA50MJgSsF402Z8vS9VJbIGYwyK3f8h68y
         CAptnhUx0dCmjtpW+TR+5ld9Ia5NQwNL9hmBv+qj6JEJrJCPhng/C0DSqpf8p6H/ofVR
         TKwA047hukYunQxruf3JMmzTk55lJYv5UDSjPIb2HlvX1cnf1vfdruZcz1uxO8BsedsB
         5lPUwsjsPdHw0B17J5fdpwOPm8R6xCu1kO5aFbmksxZg6bcZcnREz88ciWzxUKiqFfLq
         fyDQ2kGZna1Eb1jjPIyRK/6sHP1Ntv9I9EJDt0FngU3iANSIPVPwMAp9Tb9csnTR7fqP
         juzA==
X-Gm-Message-State: AOJu0Yxvm96qrBCNJdM9eCpWDSixNdO+e2/7N61f8Fh78WXLFMZB0Cfx
	3qG5skiwKq6OAXUznsVg8E1dRvO1rnkkTFnCtZMJ+RvQHsrC5spfTNQIMQ==
X-Gm-Gg: ASbGncuNMWu6TzntlRk/ABgE8P72ksAcdANP/FZ4T2yIw58WVEo9isLu69SGZAZBVyl
	9d8I/BC+ABLD5cLzrh9ckBZWwGgDn6BF2+KXihG/Wbp3iii9VvKF/Z+75AiHCsd3OD53uKk4WGk
	barBwTvmJjDOUX832G1njOS/GH84qr2rxmOg4RBxrdjhyFttFPjvDdq9z7eswIWuWYkigcTfeYh
	UjdnlpawdRAMFYHXGK7plRYlpMoru9sQ2NE8F+g5s72a1YrSwLLdAqDCn++QJQsu7jKwyuoaB78
	7Hkf7a5kmfE9IepZNL4B2EE4Dz9A10atC3NSKkcbko5tLqzZFwMr8cmzWMrh+ybyhsgPJJ7cg2u
	uS0fJXQxyVw==
X-Google-Smtp-Source: AGHT+IHEKDNNLaPHACXCSZMOfN7ollBlODSM8YsI+Z4mhTrlO2nSE/xzZCaYoXq2c3FAfYQ4X9Vurw==
X-Received: by 2002:a05:6214:d0c:b0:6e2:3721:f2c6 with SMTP id 6a1803df08f44-6e46edabd02mr26538586d6.33.1739326310719;
        Tue, 11 Feb 2025 18:11:50 -0800 (PST)
Received: from willemb.c.googlers.com.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e44a9a524esm58256126d6.5.2025.02.11.18.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 18:11:50 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 6/7] ipv6: replace ipcm6_init calls with ipcm6_init_sk
Date: Tue, 11 Feb 2025 21:09:52 -0500
Message-ID: <20250212021142.1497449-7-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
In-Reply-To: <20250212021142.1497449-1-willemdebruijn.kernel@gmail.com>
References: <20250212021142.1497449-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

This initializes tclass and dontfrag before cmsg parsing, removing the
need for explicit checks against -1 in each caller.

Leave hlimit set to -1, because its full initialization
(in ip6_sk_dst_hoplimit) requires more state (dst, flowi6, ..).

This also prepares for calling sockcm_init in a follow-on patch.

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 include/net/ipv6.h  | 9 ---------
 net/ipv6/raw.c      | 8 +-------
 net/ipv6/udp.c      | 7 +------
 net/l2tp/l2tp_ip6.c | 8 +-------
 4 files changed, 3 insertions(+), 29 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index f5c43ad1565e..46a679d9b334 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -363,15 +363,6 @@ struct ipcm6_cookie {
 	struct ipv6_txoptions *opt;
 };
 
-static inline void ipcm6_init(struct ipcm6_cookie *ipc6)
-{
-	*ipc6 = (struct ipcm6_cookie) {
-		.hlimit = -1,
-		.tclass = -1,
-		.dontfrag = -1,
-	};
-}
-
 static inline void ipcm6_init_sk(struct ipcm6_cookie *ipc6,
 				 const struct sock *sk)
 {
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index a45aba090aa4..ae68d3f7dd32 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -777,7 +777,7 @@ static int rawv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	fl6.flowi6_mark = READ_ONCE(sk->sk_mark);
 	fl6.flowi6_uid = sk->sk_uid;
 
-	ipcm6_init(&ipc6);
+	ipcm6_init_sk(&ipc6, sk);
 	ipc6.sockc.tsflags = READ_ONCE(sk->sk_tsflags);
 	ipc6.sockc.mark = fl6.flowi6_mark;
 	ipc6.sockc.priority = READ_ONCE(sk->sk_priority);
@@ -891,9 +891,6 @@ static int rawv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	if (hdrincl)
 		fl6.flowi6_flags |= FLOWI_FLAG_KNOWN_NH;
 
-	if (ipc6.tclass < 0)
-		ipc6.tclass = np->tclass;
-
 	fl6.flowlabel = ip6_make_flowinfo(ipc6.tclass, fl6.flowlabel);
 
 	dst = ip6_dst_lookup_flow(sock_net(sk), sk, &fl6, final_p);
@@ -904,9 +901,6 @@ static int rawv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	if (ipc6.hlimit < 0)
 		ipc6.hlimit = ip6_sk_dst_hoplimit(np, &fl6, dst);
 
-	if (ipc6.dontfrag < 0)
-		ipc6.dontfrag = inet6_test_bit(DONTFRAG, sk);
-
 	if (msg->msg_flags&MSG_CONFIRM)
 		goto do_confirm;
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index c6ea438b5c75..7096b7e84c10 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1494,7 +1494,7 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	int is_udplite = IS_UDPLITE(sk);
 	int (*getfrag)(void *, char *, int, int, int, struct sk_buff *);
 
-	ipcm6_init(&ipc6);
+	ipcm6_init_sk(&ipc6, sk);
 	ipc6.gso_size = READ_ONCE(up->gso_size);
 	ipc6.sockc.tsflags = READ_ONCE(sk->sk_tsflags);
 	ipc6.sockc.mark = READ_ONCE(sk->sk_mark);
@@ -1704,9 +1704,6 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	security_sk_classify_flow(sk, flowi6_to_flowi_common(fl6));
 
-	if (ipc6.tclass < 0)
-		ipc6.tclass = np->tclass;
-
 	fl6->flowlabel = ip6_make_flowinfo(ipc6.tclass, fl6->flowlabel);
 
 	dst = ip6_sk_dst_lookup_flow(sk, fl6, final_p, connected);
@@ -1752,8 +1749,6 @@ int udpv6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	WRITE_ONCE(up->pending, AF_INET6);
 
 do_append_data:
-	if (ipc6.dontfrag < 0)
-		ipc6.dontfrag = inet6_test_bit(DONTFRAG, sk);
 	up->len += ulen;
 	err = ip6_append_data(sk, getfrag, msg, ulen, sizeof(struct udphdr),
 			      &ipc6, fl6, dst_rt6_info(dst),
diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index f4c1da070826..b98d13584c81 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -547,7 +547,7 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	fl6.flowi6_mark = READ_ONCE(sk->sk_mark);
 	fl6.flowi6_uid = sk->sk_uid;
 
-	ipcm6_init(&ipc6);
+	ipcm6_init_sk(&ipc6, sk);
 
 	if (lsa) {
 		if (addr_len < SIN6_LEN_RFC2133)
@@ -634,9 +634,6 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	security_sk_classify_flow(sk, flowi6_to_flowi_common(&fl6));
 
-	if (ipc6.tclass < 0)
-		ipc6.tclass = np->tclass;
-
 	fl6.flowlabel = ip6_make_flowinfo(ipc6.tclass, fl6.flowlabel);
 
 	dst = ip6_dst_lookup_flow(sock_net(sk), sk, &fl6, final_p);
@@ -648,9 +645,6 @@ static int l2tp_ip6_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	if (ipc6.hlimit < 0)
 		ipc6.hlimit = ip6_sk_dst_hoplimit(np, &fl6, dst);
 
-	if (ipc6.dontfrag < 0)
-		ipc6.dontfrag = inet6_test_bit(DONTFRAG, sk);
-
 	if (msg->msg_flags & MSG_CONFIRM)
 		goto do_confirm;
 
-- 
2.48.1.502.g6dc24dfdaf-goog


