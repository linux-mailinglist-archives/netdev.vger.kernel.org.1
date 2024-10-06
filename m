Return-Path: <netdev+bounces-132542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 070DC99212A
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 22:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B18E1C2094B
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 20:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3583E189F2B;
	Sun,  6 Oct 2024 20:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bz0IT2Eg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C878158862
	for <netdev@vger.kernel.org>; Sun,  6 Oct 2024 20:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728246752; cv=none; b=FwcGDY1wza7KojzSgQy3hhypVORZnrHelbeLQI9YR6wPe5/nxuD1bhlWuu5eAmVBRxDMVc0oUD4u2oP741YjzYfJQ6YnwsEWrMUtrvzPliaUBEEFuHoQzNtePBl3XQtY4pjL4wGbeDm5a6RiKhyAE2q1/oT7dORS69d/NVMv6EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728246752; c=relaxed/simple;
	bh=yjClOwoGKCxCs7CExlSyEn9dlneuePw6WTmxaNZ323I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lYwzlgRjzEZf7LA/PbmbF603N8zvW1zPBJDknHeU+4BndQVDfYI0JpLXiUvDYH6ECImz85mhYTihuaArmNkABsTvcoRT9xi0BtKH9Ag5nWTD+4+e2G5CvT11FTNiAX4o/riqonoTpD/F+xFyJ1kN+0G+RACMlymtEYMfYJt5QUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bz0IT2Eg; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e2d1860a62so29412637b3.0
        for <netdev@vger.kernel.org>; Sun, 06 Oct 2024 13:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728246749; x=1728851549; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PZ6/WewJdBdhfP6ZBSehm4FgOeIcxqqUY3isW9WVj+g=;
        b=Bz0IT2Egxsl+doaiCXPHG/z6oRITAL3qBTLUlm3sWy0Ts0+lEB+6HC8WztHyLX6X+s
         GwI9+GZIxZzEbFGwz9WhLAA3/gbXVTyFUdWF7gRpDDGaLEf2o9wg1QHll6Oc90w17K5G
         j2Tkcx11VA93Yh6eZQJMiCcOAwL2/8B2LP4HRx8lWDOlyIgML5wmnHdT5a9ESeLuVYWo
         NP6J8KGFRvAteLgg6iYSW5g//ql2UUBnQjup/9twFvjQAlaV/IFDBAoIELSsmRKeysX1
         2lnVGmp//lIrOjEcTUOLIz02IzkuKZx5dxZHfAuOCdSyYeRiYuYseBbBjtLj9kEANsBW
         nm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728246749; x=1728851549;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZ6/WewJdBdhfP6ZBSehm4FgOeIcxqqUY3isW9WVj+g=;
        b=WARzecGQyNGDJUbvCPiXxpZaK16XYn8JYAXBzIpjsujmUQ8epSX9xGFhZW3Rs1lGfu
         dcfSS+pDhEXsbSS4fkfCmv5uEtgbREMyEq6VAZbc89J0nnvirZmca+pu1QmKyXeomu4R
         o8qhtOFaRECiRljbs4tlut/fydNkRd5Spd892gNbaqi0xAKzFD28t1ysbcJW5nr1AdSt
         jQi1tiD2ZiQaBKEU5oY2rfzfj0kYEmS9TPw2+shajXECcRTwMYWddlZWBNh39WzzFGR/
         GJyZLo1+1/TtkyUCK+waa2G4B9qzUtxLN8DwvOMwbSds+BqTKbE7WTX5dvN1hJ2Nn8WO
         yC/A==
X-Gm-Message-State: AOJu0YzlLaILCxiPKPCRVJQBxWqKGJ73mifH7w1J8is3JXzCRYc3zS7h
	nudM22Dyzs7aJxfZv7IgMfvrkFEmLYEzL2g54mCrPC0E7WLafxTdZk2GxgN6iAcxZZl/qx7v5ZQ
	ktoa9/lv5ZQ==
X-Google-Smtp-Source: AGHT+IGNqUQaV9xn1xSCdRIQEXM7nz8L9DDLaNQL8tyRkakHmxgj21l2HIWicgVWeoCrSv2AOZt2OhVRA10Y9g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:6908:0:b0:e22:624b:aea2 with SMTP id
 3f1490d57ef6-e28934fc7a7mr8251276.0.1728246749487; Sun, 06 Oct 2024 13:32:29
 -0700 (PDT)
Date: Sun,  6 Oct 2024 20:32:20 +0000
In-Reply-To: <20241006203224.1404384-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241006203224.1404384-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241006203224.1404384-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/5] net: add TIME_WAIT logic to sk_to_full_sk()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

TCP will soon attach TIME_WAIT sockets to some ACK and RST.

Make sure sk_to_full_sk() detects this and does not return
a non full socket.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/bpf-cgroup.h | 2 +-
 include/net/inet_sock.h    | 4 +++-
 net/core/filter.c          | 6 +-----
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index ce91d9b2acb9f8991150ceead4475b130bead438..f0f219271daf4afea2666c4d09fd4d1a8091f844 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -209,7 +209,7 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 	int __ret = 0;							       \
 	if (cgroup_bpf_enabled(CGROUP_INET_EGRESS) && sk) {		       \
 		typeof(sk) __sk = sk_to_full_sk(sk);			       \
-		if (sk_fullsock(__sk) && __sk == skb_to_full_sk(skb) &&	       \
+		if (__sk && __sk == skb_to_full_sk(skb) &&	       \
 		    cgroup_bpf_sock_enabled(__sk, CGROUP_INET_EGRESS))	       \
 			__ret = __cgroup_bpf_run_filter_skb(__sk, skb,	       \
 						      CGROUP_INET_EGRESS); \
diff --git a/include/net/inet_sock.h b/include/net/inet_sock.h
index f01dd273bea69d2eaf7a1d28274d7f980942b78a..39c5a93b353ad9ac3047031d1718190d749f0530 100644
--- a/include/net/inet_sock.h
+++ b/include/net/inet_sock.h
@@ -321,8 +321,10 @@ static inline unsigned long inet_cmsg_flags(const struct inet_sock *inet)
 static inline struct sock *sk_to_full_sk(struct sock *sk)
 {
 #ifdef CONFIG_INET
-	if (sk && sk->sk_state == TCP_NEW_SYN_RECV)
+	if (sk && READ_ONCE(sk->sk_state) == TCP_NEW_SYN_RECV)
 		sk = inet_reqsk(sk)->rsk_listener;
+	if (sk && READ_ONCE(sk->sk_state) == TCP_TIME_WAIT)
+		sk = NULL;
 #endif
 	return sk;
 }
diff --git a/net/core/filter.c b/net/core/filter.c
index bd0d08bf76bb8de39ca2ca89cda99a97c9b0a034..202c1d386e19599e9fc6e0a0d4a95986ba6d0ea8 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6778,8 +6778,6 @@ __bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
 		/* sk_to_full_sk() may return (sk)->rsk_listener, so make sure the original sk
 		 * sock refcnt is decremented to prevent a request_sock leak.
 		 */
-		if (!sk_fullsock(sk2))
-			sk2 = NULL;
 		if (sk2 != sk) {
 			sock_gen_put(sk);
 			/* Ensure there is no need to bump sk2 refcnt */
@@ -6826,8 +6824,6 @@ bpf_sk_lookup(struct sk_buff *skb, struct bpf_sock_tuple *tuple, u32 len,
 		/* sk_to_full_sk() may return (sk)->rsk_listener, so make sure the original sk
 		 * sock refcnt is decremented to prevent a request_sock leak.
 		 */
-		if (!sk_fullsock(sk2))
-			sk2 = NULL;
 		if (sk2 != sk) {
 			sock_gen_put(sk);
 			/* Ensure there is no need to bump sk2 refcnt */
@@ -7276,7 +7272,7 @@ BPF_CALL_1(bpf_get_listener_sock, struct sock *, sk)
 {
 	sk = sk_to_full_sk(sk);
 
-	if (sk->sk_state == TCP_LISTEN && sock_flag(sk, SOCK_RCU_FREE))
+	if (sk && sk->sk_state == TCP_LISTEN && sock_flag(sk, SOCK_RCU_FREE))
 		return (unsigned long)sk;
 
 	return (unsigned long)NULL;
-- 
2.47.0.rc0.187.ge670bccf7e-goog


