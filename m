Return-Path: <netdev+bounces-166591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 266D6A36844
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 23:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8CE1896C17
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 22:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599421FDA86;
	Fri, 14 Feb 2025 22:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGjJFMFy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897A31FCFD9
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 22:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739572053; cv=none; b=Od/Q7nyK1tiqfJeYmjVohF5bsTXwK++YY5sKURPCDVeb2FGpzhoPbvV1zxsYY02l4qzA2GUCVgNtluD6yPsIpYuWq0ZN+lw93fGLxjkXJ3m0uGRgRfvJFrU2ECPPL5B1l98gdRCfJd2gPBsG0Oi6RUmbk4NeejATOLz598vCrzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739572053; c=relaxed/simple;
	bh=9F9LzCBnk6joQ0mN/TH5X4s1R83nxFwtBodGIZk3qI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jpwGcKwm1fyxFvZojxdvfFo0+lylb6b62vWceNjDaQYtELLs8Nj8uqQmUwSOZ6vfv+Erj+P+H17xHlU0favVMFENYwhuvtlVvszXsMgOHFtlh/jCaqugQUv8zFAy63yz460Ohed6iBu1ahAeE0DB3NfZBwEoKIZK3FIQVL8JYIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UGjJFMFy; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6dcdf23b4edso22646286d6.0
        for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 14:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739572050; x=1740176850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3C6DhsNzrCZfTSNf3dwNDQ3us1mEywrPwMErFIIvmY=;
        b=UGjJFMFy0I9r1JFxXQE3wdUxgQzplliuoEcdDFRfSzX0TFS1u9Xqv3gD2sp7s26D8H
         Z8OKcNBYMFHQymZDHRRHAM/OO41NphT4mQfw+cNeyw9pT91qaxKCFBkdpzqm4NTVzV6j
         XPlTPa0m2eXTf9h/uFu9SDzCWxpEghwXfXYvdXNePkyVdfl+ogoRpy+865tg41/xn4bL
         Qvh8KWbD+Tz6IW/W2dbjuLNHETLaVvBykdz6ICfRdgSi6nit2gwI01TaeLbI/ZQo6gp7
         UWZJLn3wk3+prgHdWDCzKmgnykTiq23z+WbFVFNdlKWprwdsoQAAcYO5WZTJ7yCDSTgc
         849Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739572050; x=1740176850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V3C6DhsNzrCZfTSNf3dwNDQ3us1mEywrPwMErFIIvmY=;
        b=ukn6oRRaj70VqBHMgLSCq9Z9xOOXeHpKBA75suBRsgX7npSDwgMNnipy95Xif6q4ay
         Osn7ng3gOd0ALlevNI8cuE07STxjc4ILi+mYnt3SR+Am56qTXLZ79YRZ92oXJvdG20qe
         CSw3KA0qpRF0sgxPyh/WvjJFjg5Y5SrTVQCugONMr9x+oavq7lewG7JP94hmgzV4g0jE
         bUfa829L0qob9+Bh4Jcjy3+SB+RqrqepzRW5WhnXljO88ayt5Mjbg9XGNyvrC6Sl5z4B
         QrpsqaD3OSzWD3V4JoZVtqRVUwsgCZS9zp8IbOWS5WLvLxD68dkIz9Yl1dhc0BUQN824
         9w7w==
X-Gm-Message-State: AOJu0Yzy6uIp3RwaYYTOYAzZqD4WjcP0dfpvWuzn/QWj6+MaLbcJZcAI
	vTlE8qdB2UGjQA85+U5R0l1c3alFbhxccW0AXnt8k+XfCcKvCeS+fPh0tw==
X-Gm-Gg: ASbGncvya0blrcFa6Ya+HbwcCCT94eU9wEB2kXv9fFFLAi1Ep0yhEdMPRGy73G7kwWR
	whRNbJ/5KXL/DeViMGa5rTs4DOAY9SBStzxjlue06y1ZwUPCcZVRDypujkYOzN7K/TnwdKKbslO
	8/4vicrw5QgCiZsgT/3+EBiVg3MsNpjoMU9VeuHFqw0dc/GHxdmj/vUSCQGSpSDPr5CFN6dPCeC
	80UZCoL5NyqXHeTzNch+7vx7hHfZMCD1oxhkvecvw1mUcd3j+uzcDikjeYinrBBl1OQz+IO9rXt
	1X4BVGMClLD1JVOsVmHwVaPzZ3JPTebPf0ThrqiKsIVNtdW477P3X6WIbhWr60M7zm18Z7UMCpC
	xlf20KSYJQw==
X-Google-Smtp-Source: AGHT+IFaRE1evWQhTW6DSXhsvnAP4wOeWlwZbIsAR63pkpF3Sf1B7M3acGRPiVKKo1Etbt19cmePfQ==
X-Received: by 2002:a05:6214:2422:b0:6e6:698f:cafd with SMTP id 6a1803df08f44-6e66cd0554fmr19288026d6.37.1739572050310;
        Fri, 14 Feb 2025 14:27:30 -0800 (PST)
Received: from willemb.c.googlers.com.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7848b7sm25832916d6.27.2025.02.14.14.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 14:27:29 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v3 6/7] ipv6: replace ipcm6_init calls with ipcm6_init_sk
Date: Fri, 14 Feb 2025 17:27:03 -0500
Message-ID: <20250214222720.3205500-7-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250214222720.3205500-1-willemdebruijn.kernel@gmail.com>
References: <20250214222720.3205500-1-willemdebruijn.kernel@gmail.com>
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
Reviewed-by: David Ahern <dsahern@kernel.org>
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
2.48.1.601.g30ceb7b040-goog


