Return-Path: <netdev+bounces-208682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CB3B0CBEC
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 22:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6D7544710
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 20:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A6423D2BD;
	Mon, 21 Jul 2025 20:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VGvdu/zN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574F523C514
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 20:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753130190; cv=none; b=PbuR7mWgEHCg0WFtrCxTQtrVRBPZldLvC5nNkdiItw9a4JQHo82kVLH6PiDne2taB6tTJXGrxr05QogXtcZPHbQqXuiOQMxiKdeE/7Mwsd1MaKc2LreMnvQm5I9JgxcqOr5DBdIm7I57YI7zUxCn4FXjnTw515iCr31lEAaCyEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753130190; c=relaxed/simple;
	bh=nQzbvBzPyuVJ5Itkp/dHQSG157Y+6VU++58CwOQo3D4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GHMrlnijCGoy0TKo8Pp63rDldsabneSsbMTdrv+y5PCF4tectwkF8bMgnY2BQ3rympvNN0DWZ8i+S8TuFaN9WFgHiQmroPUdlrBmEaPPgJlP3tCZAg3PxFMqXsaRTcNqAvOoJU9g++32hruqGkGvPBfiLpuQ5WQEq0QGhrN8qJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VGvdu/zN; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7494999de28so6253941b3a.1
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 13:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753130188; x=1753734988; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=P67Y4nPe97i+SWJPpvtux7JQJ2xYIXeLm24bM5pwnME=;
        b=VGvdu/zNlqQ12Bg1oPXurEpFu55DFOWPP2nkVQyQg8g1tmY+1WQnWvufGJpZSu6R2G
         BMVHPIqRH4zZ2ZrUuEbdg9uneDdPJOJQeRCM6hIJnhjaQyggPmioApXUHYENQO3rjL9f
         KQhYXZAsbxWGW5agrcatgW/FlXjiNUVQkmIe4MEdN932kCd1V4yo2DdvCnF6v56loxEY
         aY5uO1Sg/YlO2O9kCu6WyPumlXY4ckiEXg1xcF9Bk9FKIKlLs1Zk3evhuMzrSwsTcU4z
         Fj7xtcplbmxwclhyC9E9Upz8r6qQ2K8srFpRp+Uv/q3ShAN5b6EBG9zX2P1XDpCYG9Qd
         Ce6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753130188; x=1753734988;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P67Y4nPe97i+SWJPpvtux7JQJ2xYIXeLm24bM5pwnME=;
        b=MTjtx4ex+fjWmvtW7aWGsfwlIFZ4KEEBw3RNjW93FDYvj2Y8fozCDek1lSfIb+hd98
         prkGO+/JAiV7ZnrDr1FZfC4GyUBGDUnHc1lcaxJ7DcQJggrWbIlIvZSnUuikkJbLr7mr
         mqC3BrEAd4I1Wxczs7MCLd7/uPNFm1KXaOHzOEVEe+SkDTS0J5bfg9ihkho1YHdNSObm
         qqWApn1cWhEiefdLdMUYtlzcFxaaxILGpacazgcO9T+qUQuyJZax8lkVGLLhUQ7OezE8
         nKRjZka5PlmCjs589Zw22aP6t9Dog33gEHw6FCShcaQik5V3biSXYfGh2zTjGDhz8cmU
         4Mkw==
X-Forwarded-Encrypted: i=1; AJvYcCXu1dTMmL3mcIFPcFkymGZCeELmt+itkRAK9rov3Jbvv6WujZZ+ULV4dwJpLk9I+IohivGvQyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5GWSYQX+USJ1BLzpaBi6V5TDfkn4NefeunhCQUQSHxhzSwQm3
	1+KkJcAWNP7bQwpM2vd7CkRyH6y+dDjgR8FEJxh1QQKcuus/QlNQgEE5WkJKEg1q3/fXdLTZDzD
	PmwObYQ==
X-Google-Smtp-Source: AGHT+IGq5a7mBT9K4l6RJAVl9SuPJnfEZ/pSiUesxpLyMFOJ6g+rCdlI3WLMNPagI5cWYxYgX95XYihYFQ4=
X-Received: from pfbhb8.prod.google.com ([2002:a05:6a00:8588:b0:748:55b9:ffbe])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:e613:b0:21f:4631:811c
 with SMTP id adf61e73a8af0-2390dba61fbmr26139263637.19.1753130188582; Mon, 21
 Jul 2025 13:36:28 -0700 (PDT)
Date: Mon, 21 Jul 2025 20:35:20 +0000
In-Reply-To: <20250721203624.3807041-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250721203624.3807041-1-kuniyu@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250721203624.3807041-2-kuniyu@google.com>
Subject: [PATCH v1 net-next 01/13] mptcp: Fix up subflow's memcg when CONFIG_SOCK_CGROUP_DATA=n.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>
Cc: Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

When sk_alloc() allocates a socket, mem_cgroup_sk_alloc() sets
sk->sk_memcg based on the current task.

MPTCP subflow socket creation is triggered from userspace or
an in-kernel worker.

In the latter case, sk->sk_memcg is not what we want.  So, we fix
it up from the parent socket's sk->sk_memcg in mptcp_attach_cgroup().

Although the code is placed under #ifdef CONFIG_MEMCG, it is buried
under #ifdef CONFIG_SOCK_CGROUP_DATA.

The two configs are orthogonal.  If CONFIG_MEMCG is enabled without
CONFIG_SOCK_CGROUP_DATA, the subflow's memory usage is not charged
correctly.

Let's move the code out of the wrong ifdef guard.

Note that sk->sk_memcg is freed in sk_prot_free() and the parent
sk holds the refcnt of memcg->css here, so we don't need to use
css_tryget().

Fixes: 3764b0c5651e3 ("mptcp: attach subflow socket to parent cgroup")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/linux/memcontrol.h |  7 +++++++
 mm/memcontrol.c            | 10 ++++++++++
 net/mptcp/subflow.c        | 11 +++--------
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 87b6688f124a7..d8319ad5e8ea7 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1602,6 +1602,8 @@ extern struct static_key_false memcg_sockets_enabled_key;
 #define mem_cgroup_sockets_enabled static_branch_unlikely(&memcg_sockets_enabled_key)
 void mem_cgroup_sk_alloc(struct sock *sk);
 void mem_cgroup_sk_free(struct sock *sk);
+void mem_cgroup_sk_inherit(const struct sock *sk, struct sock *newsk);
+
 static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
 {
 #ifdef CONFIG_MEMCG_V1
@@ -1623,6 +1625,11 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg);
 #define mem_cgroup_sockets_enabled 0
 static inline void mem_cgroup_sk_alloc(struct sock *sk) { };
 static inline void mem_cgroup_sk_free(struct sock *sk) { };
+
+static inline void mem_cgroup_sk_inherit(const struct sock *sk, struct sock *newsk)
+{
+}
+
 static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
 {
 	return false;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 70fdeda1120b3..54eb25d8d555c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5090,6 +5090,16 @@ void mem_cgroup_sk_free(struct sock *sk)
 		css_put(&sk->sk_memcg->css);
 }
 
+void mem_cgroup_sk_inherit(const struct sock *sk, struct sock *newsk)
+{
+	if (sk->sk_memcg == newsk->sk_memcg)
+		return;
+
+	mem_cgroup_sk_free(newsk);
+	css_get(&sk->sk_memcg->css);
+	newsk->sk_memcg = sk->sk_memcg;
+}
+
 /**
  * mem_cgroup_charge_skmem - charge socket memory
  * @memcg: memcg to charge
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 1802bc5435a1a..f21d90fb1a19d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1716,19 +1716,14 @@ static void mptcp_attach_cgroup(struct sock *parent, struct sock *child)
 	/* only the additional subflows created by kworkers have to be modified */
 	if (cgroup_id(sock_cgroup_ptr(parent_skcd)) !=
 	    cgroup_id(sock_cgroup_ptr(child_skcd))) {
-#ifdef CONFIG_MEMCG
-		struct mem_cgroup *memcg = parent->sk_memcg;
-
-		mem_cgroup_sk_free(child);
-		if (memcg && css_tryget(&memcg->css))
-			child->sk_memcg = memcg;
-#endif /* CONFIG_MEMCG */
-
 		cgroup_sk_free(child_skcd);
 		*child_skcd = *parent_skcd;
 		cgroup_sk_clone(child_skcd);
 	}
 #endif /* CONFIG_SOCK_CGROUP_DATA */
+
+	if (mem_cgroup_sockets_enabled && parent->sk_memcg)
+		mem_cgroup_sk_inherit(parent, child);
 }
 
 static void mptcp_subflow_ops_override(struct sock *ssk)
-- 
2.50.0.727.gbf7dc18ff4-goog


