Return-Path: <netdev+bounces-163652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8BBA2B25F
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 20:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433ED16AA97
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 19:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735CE1B0404;
	Thu,  6 Feb 2025 19:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVhtT+bU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B608C1AA1F4
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 19:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738870534; cv=none; b=MVLu/D5kZotvYNeFPfiwOB3+3NaQs2/B53wsVOSuhCgK414EvKg/WaxCuT73YHUpLMSAJuNLiJe0QBfDrzpyb1xSUOp34TcDB+Q+hKNZwf0cgXDTBkqnhMkXvwB3E5XuS6Cqb2Po0530166aS/FqOoSUY5FqVyiXVehumBw5BgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738870534; c=relaxed/simple;
	bh=LJ0/U1s5oUVPEk4S9BudypEhcVfmZideyM50xjvaOh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6H83f3XgeFUhdf/yQLQBkK54BS0yOkfig52ycxYgr4KsJht0Qv4pyk946N25JyWDZ7hyXBI14u7q5cmK/6xAmejBpFvm/qyMD112yD0ryuJFytoDniu5cRrO1jwzfVwXFind2waZNpXA1yAgh9dMtDzck0Ljmcz/+FJMk6mKLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVhtT+bU; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-467a6ecaa54so11289161cf.0
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 11:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738870531; x=1739475331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gau6dBJux1Cqdr4cJL8i+1DRll475j7858z0GE8Jeow=;
        b=XVhtT+bUswNJSNHBbqmFihQQELbg7fxAQyV3kLgE+3f1B7n243m/+/7oVaUD+LjuLe
         232rHV0LUym9hqxXMZBMkxQYlQweNuuO2NJNXzZmRG1k05+q/MgUWtSZCo1zXcjCzbGH
         pksNCcCLQfPVcqeyKvUI7duZKNBLmP6tzO/2MvuQIVzfOMUGG5/0Htm/JQP//inNL3S7
         taTgHmGBQld43AjZp9xC91C1KF+BSUtUYFv94Z+rkglCwt+w6pI5b3pVIO6T05vsRIcz
         2CsSwTqcf50yAUHX2C4YQU4OJTxAGoYeaP4uiD6IDOToIr5J/rMR6NFZGrGzUsFhJ2WF
         yhJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738870531; x=1739475331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gau6dBJux1Cqdr4cJL8i+1DRll475j7858z0GE8Jeow=;
        b=B+Vr4KD8E8PS1BW9KMDaTyxNIRNsHGQCHkHgJt2pepTWiu16abFoYR/juicrDIdz4K
         pTha5bkWW/XFJGJlaWYJTjF5xk0TMOiUplVsKGexBdkfcwt2o0jgcuyOAMBHy4pI/kOh
         wevazRpUJgPRYVRTqV+xD2pE2muDTbEBYrlYSrEXtmAWeyS6eptgn5sM/uxP2NtyOOaE
         pLjetIM3DOTfDbc1kfmef47/3dtJBFHkbdI0mjSaWj4n23s1HV5tVpMh/5/uyDcIg9RN
         OrPHQ9Mkjjc0lCKnJSDW1hRJlXfTcmmlGtEKpB6A2xT21CubdhQU7m/HVFNaXT0ELI7I
         hJrQ==
X-Gm-Message-State: AOJu0YxTOYF5Me7YqJ3xlfZb9/EFOVXd2mqnaNiwhmMQ8VrOwm+8cjaA
	bEIVvhi4wJ2ueQPmmw1IYtQxxp73/kOKh/zNwITWykkJP+ewQKBoNwkNTA==
X-Gm-Gg: ASbGnctDs3rSWAyq9TrK5f0/+bWVsiLuCki4BUHaKE4eNNB+KvthT4NfFtT8PE9WWrK
	WrdK6J8jk4gvUEqYKevbK1TOJFUNV7MMumhwij6xnfy73KmYWbjOD3deINd553ulqHUfQFErSju
	yy6oEWqYuiBeDAy5ywn4J4HermpHQOVZG6ISjs2Nr0FfhC7FTgqBckDsGptEOJ/Vy56JiRvU0zZ
	JhEAKHYxOJDxiuAEGgg51xx1ecSriXzEpIOoOvtcBtG0vg93TE8QnmrFvAwJZOJe6R8kdLOXPP8
	BNzq5rzp2fcnjiX43XeaJlemkmkXoMo5xzOz36h2wNgtVIAlbBdGv/JBhClzZmyc90WL2MUsox+
	EBQ+t02hVqg==
X-Google-Smtp-Source: AGHT+IH3ATPURaG6qWn3BMy6R2aiBAS1XaQd9oA1hMXSzXoTjMpOCymYzti38qXL9xN+7Oc8HUaFhA==
X-Received: by 2002:ac8:7f84:0:b0:466:a7d8:fd0c with SMTP id d75a77b69052e-47167a38d9amr5109801cf.30.1738870531401;
        Thu, 06 Feb 2025 11:35:31 -0800 (PST)
Received: from willemb.c.googlers.com.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471492accc2sm8349301cf.30.2025.02.06.11.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 11:35:30 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next 6/7] ipv6: replace ipcm6_init calls with ipcm6_init_sk
Date: Thu,  6 Feb 2025 14:34:53 -0500
Message-ID: <20250206193521.2285488-7-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
In-Reply-To: <20250206193521.2285488-1-willemdebruijn.kernel@gmail.com>
References: <20250206193521.2285488-1-willemdebruijn.kernel@gmail.com>
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
index 6671daa67f4f..8d1ef8e2fe1e 100644
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


