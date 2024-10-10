Return-Path: <netdev+bounces-134362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1797998EBA
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 19:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E6BD280ABC
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 17:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AED519D88F;
	Thu, 10 Oct 2024 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1scUtVZL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00C619ABC6
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 17:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582504; cv=none; b=pAaOKpE/eDvJ8Uv2nfYuK73kqasQcVAcbhkNPe0u2+73STTK5wk7DKMRy0M/wm2xlc3CKQbGx1Ea/tG2UiaaztTfCawxyEdN0N04kXTydMxEHCRSUYVtBqSqo5UATr9EnU8TGsHDwwH/ujDSVhBDJRVa6pvJNDKoRUlGZt3mfCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582504; c=relaxed/simple;
	bh=q0ymEh3R3/S4uNyQ5q7zY0/XLw3g0RXbIdEqLudYaJs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cCIu7Lnr5oENT3g8ouwFNBHBuvLkhdr5r4hnAmXqVu0dvDa4ckKSLeXZlRUoRX5rCTrYcCEtLPh7B+tx+m10DEkqYdXV1cJ9qVupTvoHDDSTZNVGnbB6a8smJ+5XXc/gAZqwLgvuYpt0ZfS6G2aESZy7DuqmCYYQUHPAmLaHZrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1scUtVZL; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6dbbeee08f0so34194807b3.0
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 10:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728582501; x=1729187301; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XoMnp4Nry8CjnjfsHz9gkcWW9bq3s6INmjM+kPdCiJU=;
        b=1scUtVZLOjJQTn2968wZXg2iLQMSOabVt42By88qfGTqRoDg+9gC37gWyB+LNZCkjK
         WqelCHIKpC1LijjaKdhsWfkk+bEWQUCxxROMGOc5qRiOVTfMQcfG0kmm6OCDnBFCPUlr
         LzXseiyYvFetGRcQAnV6i3cufQjUrJcqOzqPFLvqusJO0ePmwmu1H1qrRJ54mFml2esq
         EpDbltrTOGbCwTANr+5ooNyiIZWGsazfBDq2EnzVlTlygv34THTV9PBrXaMVNOpInyFo
         ploq/FEKyGkWp9iThk7zyn+NsyeW0MPyye9AYlep67Tglrhm9jJk7onW2amnXwJsC9Bh
         jvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728582502; x=1729187302;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XoMnp4Nry8CjnjfsHz9gkcWW9bq3s6INmjM+kPdCiJU=;
        b=N1METCiZS7uyplNvOEUEJw0NVJoAiHfuiHChA+3NuDq/bUVy/6ecZB648nngrKbGY5
         dg5LqGEWttE/zSDFHTW0nVEubyMQcZcgsCGTw7SCsGUjFFXhYZqHHTEKp9MmfiI/Tnbo
         lxG4O3/o5cglZAWGnaZleO6EpkjqSIzlgeqap9d8Ji8fOL9clcxpUqwDiJPf7I7Y0NRU
         w1xT9ASiPrmXYi5Uswwv4IuOB98zkJM6joxBRmxom3jxJts1ie5SM7GAFA0jv9OwD+/h
         Gg+tv36LeqqG7I2Wv71hhboLVNIKE1rqFyVnayRdCTCmTsg+9uaaRT6JSaE/KLirUrwF
         0cnA==
X-Forwarded-Encrypted: i=1; AJvYcCVw0Vpfp9229jCFTa62BAxZJ6XHjfUn2lTpOBi9W2TXWIhFwdh7gCxZOuv/Vf9xaHFE5Eb7mdg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywedza12WtE9xdMG+Aan9t89oc8mNbBXDEGVc6sY6nQngivZfkm
	xoo9XSQ+Yj4XRPRS49oARTBXhBeeGuF5HB9AL4JWFjz7Fb20bjbzIEkFuFUCyqXaLYJknYJFABT
	M7fYVm222Mw==
X-Google-Smtp-Source: AGHT+IFd7PW72o3mET4chvQ8yYX2VyrAC6Vk/+fDf2YEWXTAmLfbdh8G9K7tEOjUFcQ8EI23xWRjS+0SxCTisg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1813:b0:e24:b971:c4cb with SMTP
 id 3f1490d57ef6-e290b7d67f3mr53411276.2.1728582501526; Thu, 10 Oct 2024
 10:48:21 -0700 (PDT)
Date: Thu, 10 Oct 2024 17:48:13 +0000
In-Reply-To: <20241010174817.1543642-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010174817.1543642-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241010174817.1543642-2-edumazet@google.com>
Subject: [PATCH v3 net-next 1/5] net: add TIME_WAIT logic to sk_to_full_sk()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Martin KaFai Lau <martin.lau@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Neal Cardwell <ncardwell@google.com>, Brian Vazquez <brianvv@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

TCP will soon attach TIME_WAIT sockets to some ACK and RST.

Make sure sk_to_full_sk() detects this and does not return
a non full socket.

v3: also changed sk_const_to_full_sk()

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/bpf-cgroup.h | 2 +-
 include/net/inet_sock.h    | 8 ++++++--
 net/core/filter.c          | 6 +-----
 3 files changed, 8 insertions(+), 8 deletions(-)

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
index f01dd273bea69d2eaf7a1d28274d7f980942b78a..56d8bc5593d3dfffd5f94cf7c6383948881917df 100644
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
@@ -331,8 +333,10 @@ static inline struct sock *sk_to_full_sk(struct sock *sk)
 static inline const struct sock *sk_const_to_full_sk(const struct sock *sk)
 {
 #ifdef CONFIG_INET
-	if (sk && sk->sk_state == TCP_NEW_SYN_RECV)
+	if (sk && READ_ONCE(sk->sk_state) == TCP_NEW_SYN_RECV)
 		sk = ((const struct request_sock *)sk)->rsk_listener;
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
2.47.0.rc1.288.g06298d1525-goog


