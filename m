Return-Path: <netdev+bounces-216612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFA4B34B4C
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 22:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E00A7189B987
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 20:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E550228725B;
	Mon, 25 Aug 2025 19:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0xcEDyof"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402472882BD
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 19:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756151999; cv=none; b=aYiFCJj9SfBaaZAnRL3yUTM/t0koDT/m3s/7dlBf0YfxcjE5CSHqz0Mrft2ZurZrXD+3OBnyBttQrVDArrfkRHKylo2HG8rAw0udPGHQOd7sR7/Ecq+q4cGXULE4joJOyux7uxD50+NkrzUrTdp5WdLD/BhOWdjxQBI9fL/SvI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756151999; c=relaxed/simple;
	bh=d5nX7Q4W7R5H7RRRUm99KGdgbVMujbqX/r46wQls//Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ShpeBrW32aKQH8g56vRajzSbPYcqT6m78XQrZkWU/BXFodsyTAwNy8TzESXVIQnTGDi+qLp9MABK7j/F78dILAyCeOBYHwaw3O0/+bnVTcLdMbWj6i9mbPwtZfkyLEx+2fut1MKB/X4Alhph6L1xmiYF72gjQg6OJyVXx4am7dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0xcEDyof; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7e87063051dso576328285a.2
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 12:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756151997; x=1756756797; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5W5iuOjavrPfm/DTgjuk/iKsy8TSdGBcBJmfGX4RxRQ=;
        b=0xcEDyofUxBcfa6D05vxDUmFDCJ+U26q+IKVx5ZNaRW0HtTdXLjbZSUfW3FWP/jmD7
         8vPM47s3lEJ050ce/ceNI20nMBLsBCtDTWCsf8vkQcFQdBP4VK7uiDS1ZZNrxNuO8rqP
         mNJEzgOqEYVZvSwX5wHhD2172Hv7Jslibor2WMEZWxTWQp/Ecns7lLpqhSP5tSP58Jt/
         YTmzn4lUaRBKyEUQ+ZjrJL5lt45s+BGEz0vAYkQHT8ujBCv4jEgp+tWTwAyeCHouM6tm
         Ervxb/LZtR4qJbb2riWJOGbujymiryaq1U+cG8eMmBRrA7sUW+1FKDXQQGR5MiEo3qRS
         TGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756151997; x=1756756797;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5W5iuOjavrPfm/DTgjuk/iKsy8TSdGBcBJmfGX4RxRQ=;
        b=CVv/x0Wxrqj40GoGN6ridwe4sln7qo98G/5RszIOafTmP0ykdIOtGmO9FUw3xiNyWp
         N1hIEw4rpgVY+PWekBNzFjtgRiUWZecGrDPewESVowlaFiyuKZffrek4w2F4cwc4EWrO
         srVKGfJ5IbPylqOwMurmSnl5c37jdtcm+YfCBHbnFGUo+3HDh9XDhlE0oVPpe7jHsmqg
         dGqbHnAKnTILZYskcLRyUlZlbfHIFGu/Qn0BZfqBFeRjUZrUN3vWuZk4NEO2ZbR7Wu5j
         QycFk3XxIDk7pWMH5tc58agqwWmu3nLfjKL4hDb7KJs+TC3jsTqhl/h09EJFEpauu3F1
         XvYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYZtbOh/EN/VhrkWIeAowY//pK5mTA5KFGPinK8JhPKsODr9Iqqrp+uZvFqK3q4slaXWhkxKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW7GRxDqXCBGmpEE5qU6vdOWge3W3VIoGPKhRuOyq4JTxZsN56
	ziko8cgj2Hu+3+l2YCWWD5gVsxw/8jtKi4kVWxUvfCybJRguICi40+IXOUWP5W3/VPpaTi2fNuU
	6s62u+HTWTbbXfw==
X-Google-Smtp-Source: AGHT+IFG3I7DvAZitzi1ZsY7gwQAW1DZQYWaqSzCFwHVXPi9qD9t3nVn1W39NwSEw23Iv+Vn+1eAj4I7E2xRLw==
X-Received: from qknru6.prod.google.com ([2002:a05:620a:6846:b0:7e6:36d3:ccf2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:170b:b0:7f2:c056:ec4c with SMTP id af79cd13be357-7f2c056f4bemr356505285a.52.1756151997139;
 Mon, 25 Aug 2025 12:59:57 -0700 (PDT)
Date: Mon, 25 Aug 2025 19:59:47 +0000
In-Reply-To: <20250825195947.4073595-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250825195947.4073595-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250825195947.4073595-4-edumazet@google.com>
Subject: [PATCH net-next 3/3] net: add new sk->sk_drops1 field
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

sk->sk_drops can be heavily contended when
changed from many cpus.

Instead using too expensive per-cpu data structure,
add a second sk->sk_drops1 field and change
sk_drops_inc() to be NUMA aware.

This patch adds 64 bytes per socket.

For hosts having more than two memory nodes, sk_drops_inc()
might not be optimal and can be refined later.

Tested with the following stress test, sending about 11 Mpps
to a dual socket AMD EPYC 7B13 64-Core.

super_netperf 20 -t UDP_STREAM -H DUT -l10 -- -n -P,1000 -m 120
Note: due to socket lookup, only one UDP socket will receive
packets on DUT.

Then measure receiver (DUT) behavior. We can see
consumer and BH handlers can process more packets per second.

Before:

nstat -n ; sleep 1 ; nstat | grep Udp
Udp6InDatagrams                 855592             0.0
Udp6InErrors                    5621467            0.0
Udp6RcvbufErrors                5621467            0.0

After:
nstat -n ; sleep 1 ; nstat | grep Udp
Udp6InDatagrams                 914537             0.0
Udp6InErrors                    6888487            0.0
Udp6RcvbufErrors                6888487            0.0

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h                            | 20 +++++++++++++++++++
 .../selftests/bpf/progs/bpf_iter_netlink.c    |  3 ++-
 .../selftests/bpf/progs/bpf_iter_udp4.c       |  2 +-
 .../selftests/bpf/progs/bpf_iter_udp6.c       |  2 +-
 4 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index f40e3c4883be32c8282694ab215bcf79eb87cbd7..318169eb1a3d40eefac50147012551614abc6f7a 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -282,6 +282,7 @@ struct sk_filter;
   *	@sk_err_soft: errors that don't cause failure but are the cause of a
   *		      persistent failure not just 'timed out'
   *	@sk_drops: raw/udp drops counter
+  *	@sk_drops1: second drops counter
   *	@sk_ack_backlog: current listen backlog
   *	@sk_max_ack_backlog: listen backlog set in listen()
   *	@sk_uid: user id of owner
@@ -571,6 +572,11 @@ struct sock {
 	atomic_t		sk_drops ____cacheline_aligned_in_smp;
 	struct rcu_head		sk_rcu;
 	netns_tracker		ns_tracker;
+#if defined(CONFIG_NUMA)
+	atomic_t		sk_drops1 ____cacheline_aligned_in_smp;
+#else
+	atomic_t		sk_drops1;
+#endif
 };
 
 struct sock_bh_locked {
@@ -2684,17 +2690,31 @@ struct sock_skb_cb {
 
 static inline void sk_drops_inc(struct sock *sk)
 {
+#if defined(CONFIG_NUMA)
+	int n = numa_node_id() % 2;
+
+	if (n)
+		atomic_inc(&sk->sk_drops1);
+	else
+		atomic_inc(&sk->sk_drops);
+#else
 	atomic_inc(&sk->sk_drops);
+#endif
 }
 
 static inline int sk_drops_read(const struct sock *sk)
 {
+#if defined(CONFIG_NUMA)
+	return atomic_read(&sk->sk_drops) + atomic_read(&sk->sk_drops1);
+#else
 	return atomic_read(&sk->sk_drops);
+#endif
 }
 
 static inline void sk_drops_reset(struct sock *sk)
 {
 	atomic_set(&sk->sk_drops, 0);
+	atomic_set(&sk->sk_drops1, 0);
 }
 
 static inline void
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c b/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c
index 00b2ceae81fb0914f2de3634eb342004e8bc3c5b..31ad9fcc6022d5d31b9c6a35daacaad7c887a51f 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_netlink.c
@@ -57,7 +57,8 @@ int dump_netlink(struct bpf_iter__netlink *ctx)
 		inode = SOCK_INODE(sk);
 		bpf_probe_read_kernel(&ino, sizeof(ino), &inode->i_ino);
 	}
-	BPF_SEQ_PRINTF(seq, "%-8u %-8lu\n", s->sk_drops.counter, ino);
+	BPF_SEQ_PRINTF(seq, "%-8u %-8lu\n",
+		       s->sk_drops.counter + s->sk_drops1.counter, ino);
 
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c b/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c
index ffbd4b116d17ffbb9f14440c788e50490fb0f4e0..192ab5693a7131c1ec5879e539651c21f6f3c9ae 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_udp4.c
@@ -64,7 +64,7 @@ int dump_udp4(struct bpf_iter__udp *ctx)
 		       0, 0L, 0, ctx->uid, 0,
 		       sock_i_ino(&inet->sk),
 		       inet->sk.sk_refcnt.refs.counter, udp_sk,
-		       inet->sk.sk_drops.counter);
+		       inet->sk.sk_drops.counter + inet->sk.sk_drops1.counter);
 
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c b/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c
index 47ff7754f4fda4c9db92fbf1dc2e6a68f044174e..5170bdf458fa1b9a4eea9240fbaa5934182a7776 100644
--- a/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c
+++ b/tools/testing/selftests/bpf/progs/bpf_iter_udp6.c
@@ -72,7 +72,7 @@ int dump_udp6(struct bpf_iter__udp *ctx)
 		       0, 0L, 0, ctx->uid, 0,
 		       sock_i_ino(&inet->sk),
 		       inet->sk.sk_refcnt.refs.counter, udp_sk,
-		       inet->sk.sk_drops.counter);
+		       inet->sk.sk_drops.counter + inet->sk.sk_drops1.counter);
 
 	return 0;
 }
-- 
2.51.0.261.g7ce5a0a67e-goog


