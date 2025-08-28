Return-Path: <netdev+bounces-217713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF013B399E5
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A4493B4867
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 10:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46F630F546;
	Thu, 28 Aug 2025 10:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yj2PLTpH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F055530F559
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 10:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376872; cv=none; b=FAI7U+RtEJwj/EcqZl20o/1nK5/SpBsxUhDHxIzYYs9y83NfI8ZRHLDXkPE7mdH6EqjK7akFt6LAp6NjVOlbrsVGLms5cFEQCoFbsZZmJeHQEme8OVVap70mYV9HQkQgBYn5csbYzEYs98SRRVCWI59ORZLpxxaOf9IiCTxx3sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376872; c=relaxed/simple;
	bh=4TtNelkUjlH0tUFjiXW91Z6vtVX2uLozVmg7La8/Q3U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eqm6b2YVs8/dfGbckEO19/L083WRuaTWyPLElKj066bqWsoArcaw9DD8rRSKMau2NC8w9BytRHHsbfqQC9WDLyaUsPlf9fCKLZSTIts5Sd4grZB8bJt+34mlHlb2gzVxWpDUaxPZm0O4KJ7Y9oF/wOHfE8TA/2Y3F4Q9MY5u3G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yj2PLTpH; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7f7ff7acb97so135500485a.0
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 03:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756376870; x=1756981670; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m9DxzgnAnz7BGjpOcStz/nAZu/+W7i8+pyAs5dRRYDQ=;
        b=yj2PLTpHaIq1jPll41CcjxGsIQfPgG33TuFN/GYkXNaHYssdAwZwVMVTUqlfVi9l7Z
         WxwYCVbRVXyqE7lxm8gqkWgVJdjN7bQ6rdQyYphdwJ6WiHs5vjRECsvsLhXTkyZbfYNK
         9+a3/lPg1fysc1vCPxr0jggWJNjzEr8WD4+/2Faut5/ZApNpoK4eDaREsC7to55JP2pJ
         SF9hTWyo+xexiUr3+4GKu44SRUt2Q/bNg5/4Dl+XDwDx06foHmwuFshcNVNYzh6vKMAR
         hOB9eulbfrVb7Xf+XVAonFHhLQtZfbA3UnswXuyLaro3Pi0ivj8GdJ04yk2A8mOZ7VZX
         Qjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376870; x=1756981670;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m9DxzgnAnz7BGjpOcStz/nAZu/+W7i8+pyAs5dRRYDQ=;
        b=E3m8C3zRR4iIzZOPMNkpm9phEm2sX8qIBGNFW7uK+CJKjm5mz4terA1mcIshRtxo9m
         SSorqiXGs4XjK3Kh+FQf4VfhrazURYk6JOEkLOMcJbBI8AFGRBzM2Drfu+faE0FCZVAr
         KtcSDfWbiBm/YtxXG5Bs3LcX/uBA0llnRSJ6hgyh7iQtuLnJZ3jJ6M8pG6nTVMq4c8fb
         C8t0yAIIkYCzWRuApzJhMCaNxVuY5dsPRBewt61ydDKZbgA0bv/Tj9+ofExBwca05CyS
         ExM06GvQOQ3LNohUwzOAT2PJ0RxE7QZdGZU2C9eK94WGzIMdBA0CpmumHPXRmetHv8M+
         9tWw==
X-Forwarded-Encrypted: i=1; AJvYcCUsdvdgW9BvZfufK4jPo2FOOKaUn+nD5+kryHQDMvWCbALOsprP/oD+BUG3fypm+MjWh57VMbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyW7TQA9xsuYz0qpxk+rosQ3MGxAoYtNVm0qSBUt3xX3gbbvBs
	fzo9hWEb+LTOeSEhgZfxX6YEdfb+zgLOV1KB2dhwgjuz6IL1MWErvPFMSEC5KSlo+17RXs1T/wE
	M4mqSyibj2yKuHw==
X-Google-Smtp-Source: AGHT+IGxi7a5xVybIFMRwxaCxcV7hcBeMwFNQPTLzATy7q+s7n5fvmp4SAJbind3+MaavoBddYIBB19vGjlFwg==
X-Received: from qkntz8.prod.google.com ([2002:a05:620a:6908:b0:7e6:2365:6c9c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:d6a:b0:70d:b3de:ced3 with SMTP id 6a1803df08f44-70db3dedb2amr228053336d6.25.1756376869842;
 Thu, 28 Aug 2025 03:27:49 -0700 (PDT)
Date: Thu, 28 Aug 2025 10:27:38 +0000
In-Reply-To: <20250828102738.2065992-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828102738.2065992-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828102738.2065992-6-edumazet@google.com>
Subject: [PATCH net-next 5/5] inet_diag: avoid cache line misses in inet_diag_bc_sk()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

inet_diag_bc_sk() pulls five cache lines per socket,
while most filters only need the two first ones.

Add three booleans to struct inet_diag_dump_data,
that are selectively set if a filter needs specific socket fields.

- mark_needed       /* INET_DIAG_BC_MARK_COND present. */
- cgroup_needed     /* INET_DIAG_BC_CGROUP_COND present. */
- userlocks_needed  /* INET_DIAG_BC_AUTO present. */

This removes millions of cache lines misses per ss invocation
when simple filters are specified on busy servers.

offsetof(struct sock, sk_userlocks) = 0xf3
offsetof(struct sock, sk_mark) = 0x20c
offsetof(struct sock, sk_cgrp_data) = 0x298

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/inet_diag.h |  5 ++++
 net/ipv4/inet_diag.c      | 52 +++++++++++++++++++++++----------------
 2 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/include/linux/inet_diag.h b/include/linux/inet_diag.h
index 86a0641ec36e1bf25483a8e6c3412073b9893d36..704fd415c2b497dfba591a7ef46009dec7824d75 100644
--- a/include/linux/inet_diag.h
+++ b/include/linux/inet_diag.h
@@ -38,6 +38,11 @@ struct inet_diag_dump_data {
 #define inet_diag_nla_bpf_stgs req_nlas[INET_DIAG_REQ_SK_BPF_STORAGES]
 
 	struct bpf_sk_storage_diag *bpf_stg_diag;
+	bool mark_needed;	/* INET_DIAG_BC_MARK_COND present. */
+#ifdef CONFIG_SOCK_CGROUP_DATA
+	bool cgroup_needed;	/* INET_DIAG_BC_CGROUP_COND present. */
+#endif
+	bool userlocks_needed;	/* INET_DIAG_BC_AUTO present. */
 };
 
 struct inet_connection_sock;
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 11710304268781581b3559aca770d50dc0090ef3..f0b6c5a411a2008e2a039ed37e262f3f132e58ac 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -605,18 +605,22 @@ int inet_diag_bc_sk(const struct inet_diag_dump_data *cb_data, struct sock *sk)
 	entry.sport = READ_ONCE(inet->inet_num);
 	entry.dport = ntohs(READ_ONCE(inet->inet_dport));
 	entry.ifindex = READ_ONCE(sk->sk_bound_dev_if);
-	entry.userlocks = sk_fullsock(sk) ? READ_ONCE(sk->sk_userlocks) : 0;
-	if (sk_fullsock(sk))
-		entry.mark = READ_ONCE(sk->sk_mark);
-	else if (sk->sk_state == TCP_NEW_SYN_RECV)
-		entry.mark = inet_rsk(inet_reqsk(sk))->ir_mark;
-	else if (sk->sk_state == TCP_TIME_WAIT)
-		entry.mark = inet_twsk(sk)->tw_mark;
-	else
-		entry.mark = 0;
+	if (cb_data->userlocks_needed)
+		entry.userlocks = sk_fullsock(sk) ? READ_ONCE(sk->sk_userlocks) : 0;
+	if (cb_data->mark_needed) {
+		if (sk_fullsock(sk))
+			entry.mark = READ_ONCE(sk->sk_mark);
+		else if (sk->sk_state == TCP_NEW_SYN_RECV)
+			entry.mark = inet_rsk(inet_reqsk(sk))->ir_mark;
+		else if (sk->sk_state == TCP_TIME_WAIT)
+			entry.mark = inet_twsk(sk)->tw_mark;
+		else
+			entry.mark = 0;
+	}
 #ifdef CONFIG_SOCK_CGROUP_DATA
-	entry.cgroup_id = sk_fullsock(sk) ?
-		cgroup_id(sock_cgroup_ptr(&sk->sk_cgrp_data)) : 0;
+	if (cb_data->cgroup_needed)
+		entry.cgroup_id = sk_fullsock(sk) ?
+			cgroup_id(sock_cgroup_ptr(&sk->sk_cgrp_data)) : 0;
 #endif
 
 	return inet_diag_bc_run(bc, &entry);
@@ -716,16 +720,21 @@ static bool valid_cgroupcond(const struct inet_diag_bc_op *op, int len,
 }
 #endif
 
-static int inet_diag_bc_audit(const struct nlattr *attr,
+static int inet_diag_bc_audit(struct inet_diag_dump_data *cb_data,
 			      const struct sk_buff *skb)
 {
-	bool net_admin = netlink_net_capable(skb, CAP_NET_ADMIN);
+	const struct nlattr *attr = cb_data->inet_diag_nla_bc;
 	const void *bytecode, *bc;
 	int bytecode_len, len;
+	bool net_admin;
+
+	if (!attr)
+		return 0;
 
-	if (!attr || nla_len(attr) < sizeof(struct inet_diag_bc_op))
+	if (nla_len(attr) < sizeof(struct inet_diag_bc_op))
 		return -EINVAL;
 
+	net_admin = netlink_net_capable(skb, CAP_NET_ADMIN);
 	bytecode = bc = nla_data(attr);
 	len = bytecode_len = nla_len(attr);
 
@@ -757,14 +766,18 @@ static int inet_diag_bc_audit(const struct nlattr *attr,
 				return -EPERM;
 			if (!valid_markcond(bc, len, &min_len))
 				return -EINVAL;
+			cb_data->mark_needed = true;
 			break;
 #ifdef CONFIG_SOCK_CGROUP_DATA
 		case INET_DIAG_BC_CGROUP_COND:
 			if (!valid_cgroupcond(bc, len, &min_len))
 				return -EINVAL;
+			cb_data->cgroup_needed = true;
 			break;
 #endif
 		case INET_DIAG_BC_AUTO:
+			cb_data->userlocks_needed = true;
+			fallthrough;
 		case INET_DIAG_BC_JMP:
 		case INET_DIAG_BC_NOP:
 			break;
@@ -841,13 +854,10 @@ static int __inet_diag_dump_start(struct netlink_callback *cb, int hdrlen)
 		kfree(cb_data);
 		return err;
 	}
-	nla = cb_data->inet_diag_nla_bc;
-	if (nla) {
-		err = inet_diag_bc_audit(nla, skb);
-		if (err) {
-			kfree(cb_data);
-			return err;
-		}
+	err = inet_diag_bc_audit(cb_data, skb);
+	if (err) {
+		kfree(cb_data);
+		return err;
 	}
 
 	nla = cb_data->inet_diag_nla_bpf_stgs;
-- 
2.51.0.268.g9569e192d0-goog


