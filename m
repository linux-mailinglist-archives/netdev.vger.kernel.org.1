Return-Path: <netdev+bounces-92161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F22AB8B5A4A
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 15:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2176E1C214EF
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 13:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8617C71B50;
	Mon, 29 Apr 2024 13:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kq/I+IBJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C020974E09
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398036; cv=none; b=Wai7vB24pbyD6F8ryYaR+iOgAUsBVG4dw1IJbZM8tB1YggOEpz9c5FbXjBC447Q3tJWoDbYV8cqL0L/DydHpKU5tkWVwR0Nlsi9ARKl3Dih3p2kq18bUT8vLvqmYRNGSBy6fSCzIS8AeIZACD9cUeF0SIyyuZHPlZhiKaH20uos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398036; c=relaxed/simple;
	bh=fIg0MfMNwSDO3L4o+Zp7tqwRu1d68+eflAMmSm1udvc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A9r+6BLeZbQwcLtjqaQpCYMBKBxmC2u5GMncrjGlTezNxxi6w2XkL4AK526t3YW+r92iDRCaFXMJoJsuaifMQSDef0dXLv+oJgS8LIXDvwZmnpHD3M+k8a+uuo8T6aRnq0yvA+GqNdL6RgfK+bT6VAAB1w9n9E6aJsSJs7MZS1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kq/I+IBJ; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-790f62a7046so138688485a.1
        for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 06:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714398033; x=1715002833; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oEFKwFXVmCaTrrUiwMT40XJKqg5rhAiy1a8h28o2bEs=;
        b=kq/I+IBJ5qTfcHPJhcKVbMXYjAvh9k3wNcoMDa4cv08KEaRbGC+Tgg98M1mhz52pdM
         3eLYB1NbYprJNqvICGDerNX0bMK7ArwUW6Istl+Bp6fuR4vj9OtUcq9UHQKj+FyoGgMD
         zPj4x8S3I69AO4wPqIQi3QiBhXgM7ZwCBZKT7KzYA+Zuz596mrcmrGpwvvxTDmWj2Hq1
         7OLpMbIeQJgDhrcOqOnTvBIdvCvcXWXqm6hBzvhqbsqzQpufB5up15GnWoyO493UKmO2
         OOJgaV09X++ZQ+uK5qTtwlXNGKkSIHbUYkrT12BSDODBFtmygmooIbCQkSH3O9fzBbfd
         RSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714398033; x=1715002833;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oEFKwFXVmCaTrrUiwMT40XJKqg5rhAiy1a8h28o2bEs=;
        b=CA2WnPzgvcwgBePNS9u0gpYbi5o9Ry5IbRGZBK/SeJoFk1q2SJ7/pqg8M2QOAsclbU
         c/Y46S+Q1lo9wH/nKyEoDemufDbobASCQF+aG+Rm4H/pWvEXU0uLAI6ck77+uHcQGA96
         Gtg/oyVXgzTpRoXubp76VINz4sBRz5EzIH6HPfGJxDZ+0QfsjvHj29XmSfTsrc35bfsJ
         lyiKaDUy8mXp82rJKMeOZEiHiX+CPU02+9OJs0Lct3aB6XQ80xI5bX+XuzKEo5ru/VpO
         77j/Lo/gjqbvdlXxD+5s1mj8cAnpnAf6nqWWiF2OqfI5TrZVfAi6fmMu3/epQXjJ+Up6
         pwnA==
X-Gm-Message-State: AOJu0YxIgPKvtxyz4/cuKz9X4fQu4hqTb4mcO48iIdteL+2WUf7IrtX6
	0IJZEv1lj/03Qjam6qznM6+9HWDK2dx+v/bk38Z2nLHejJEY7Vo0ewwm5lauob1JZkfxfWbHDqQ
	RVq74tHkguQ==
X-Google-Smtp-Source: AGHT+IFFTPe6n/49nVFY1ot7UhlNY4ksxPgiKzMWJr8uSMEmFHYJvkWgC9U+lyNFGDXgHbjVuedsF4sIjvwl0g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:620a:672:b0:790:c7f8:76c8 with SMTP
 id a18-20020a05620a067200b00790c7f876c8mr20630qkh.2.1714398033755; Mon, 29
 Apr 2024 06:40:33 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:40:24 +0000
In-Reply-To: <20240429134025.1233626-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240429134025.1233626-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429134025.1233626-5-edumazet@google.com>
Subject: [PATCH net-next 4/5] net: add <net/proto_memory.h>
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Move some proto memory definitions out of <net/sock.h>

Very few files need them, and following patch
will include <net/hotdata.h> from <net/proto_memory.h>

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/proto_memory.h | 83 ++++++++++++++++++++++++++++++++++++++
 include/net/sock.h         | 78 -----------------------------------
 net/core/sock.c            |  1 +
 net/core/sysctl_net_core.c |  1 +
 net/ipv4/proc.c            |  1 +
 net/ipv4/tcp.c             |  1 +
 net/ipv4/tcp_input.c       |  1 +
 net/ipv4/tcp_output.c      |  1 +
 net/sctp/sm_statefuns.c    |  1 +
 9 files changed, 90 insertions(+), 78 deletions(-)
 create mode 100644 include/net/proto_memory.h

diff --git a/include/net/proto_memory.h b/include/net/proto_memory.h
new file mode 100644
index 0000000000000000000000000000000000000000..41404d4bb6f08e84030838f0e63ef240587f65dd
--- /dev/null
+++ b/include/net/proto_memory.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _PROTO_MEMORY_H
+#define _PROTO_MEMORY_H
+
+#include <net/sock.h>
+
+/* 1 MB per cpu, in page units */
+#define SK_MEMORY_PCPU_RESERVE (1 << (20 - PAGE_SHIFT))
+extern int sysctl_mem_pcpu_rsv;
+
+static inline bool sk_has_memory_pressure(const struct sock *sk)
+{
+	return sk->sk_prot->memory_pressure != NULL;
+}
+
+static inline bool
+proto_memory_pressure(const struct proto *prot)
+{
+	if (!prot->memory_pressure)
+		return false;
+	return !!READ_ONCE(*prot->memory_pressure);
+}
+
+static inline bool sk_under_global_memory_pressure(const struct sock *sk)
+{
+	return proto_memory_pressure(sk->sk_prot);
+}
+
+static inline bool sk_under_memory_pressure(const struct sock *sk)
+{
+	if (!sk->sk_prot->memory_pressure)
+		return false;
+
+	if (mem_cgroup_sockets_enabled && sk->sk_memcg &&
+	    mem_cgroup_under_socket_pressure(sk->sk_memcg))
+		return true;
+
+	return !!READ_ONCE(*sk->sk_prot->memory_pressure);
+}
+
+static inline long
+proto_memory_allocated(const struct proto *prot)
+{
+	return max(0L, atomic_long_read(prot->memory_allocated));
+}
+
+static inline long
+sk_memory_allocated(const struct sock *sk)
+{
+	return proto_memory_allocated(sk->sk_prot);
+}
+
+static inline void proto_memory_pcpu_drain(struct proto *proto)
+{
+	int val = this_cpu_xchg(*proto->per_cpu_fw_alloc, 0);
+
+	if (val)
+		atomic_long_add(val, proto->memory_allocated);
+}
+
+static inline void
+sk_memory_allocated_add(const struct sock *sk, int val)
+{
+	struct proto *proto = sk->sk_prot;
+
+	val = this_cpu_add_return(*proto->per_cpu_fw_alloc, val);
+
+	if (unlikely(val >= READ_ONCE(sysctl_mem_pcpu_rsv)))
+		proto_memory_pcpu_drain(proto);
+}
+
+static inline void
+sk_memory_allocated_sub(const struct sock *sk, int val)
+{
+	struct proto *proto = sk->sk_prot;
+
+	val = this_cpu_sub_return(*proto->per_cpu_fw_alloc, val);
+
+	if (unlikely(val <= -READ_ONCE(sysctl_mem_pcpu_rsv)))
+		proto_memory_pcpu_drain(proto);
+}
+
+#endif /* _PROTO_MEMORY_H */
diff --git a/include/net/sock.h b/include/net/sock.h
index 48bcc845202f283c258803c7d35fb2b9a0fd6fe7..0450494a1766a0136fa7b446e63c7357afd4a6e6 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1371,75 +1371,6 @@ static inline int sk_under_cgroup_hierarchy(struct sock *sk,
 #endif
 }
 
-static inline bool sk_has_memory_pressure(const struct sock *sk)
-{
-	return sk->sk_prot->memory_pressure != NULL;
-}
-
-static inline bool sk_under_global_memory_pressure(const struct sock *sk)
-{
-	return sk->sk_prot->memory_pressure &&
-		!!READ_ONCE(*sk->sk_prot->memory_pressure);
-}
-
-static inline bool sk_under_memory_pressure(const struct sock *sk)
-{
-	if (!sk->sk_prot->memory_pressure)
-		return false;
-
-	if (mem_cgroup_sockets_enabled && sk->sk_memcg &&
-	    mem_cgroup_under_socket_pressure(sk->sk_memcg))
-		return true;
-
-	return !!READ_ONCE(*sk->sk_prot->memory_pressure);
-}
-
-static inline long
-proto_memory_allocated(const struct proto *prot)
-{
-	return max(0L, atomic_long_read(prot->memory_allocated));
-}
-
-static inline long
-sk_memory_allocated(const struct sock *sk)
-{
-	return proto_memory_allocated(sk->sk_prot);
-}
-
-/* 1 MB per cpu, in page units */
-#define SK_MEMORY_PCPU_RESERVE (1 << (20 - PAGE_SHIFT))
-extern int sysctl_mem_pcpu_rsv;
-
-static inline void proto_memory_pcpu_drain(struct proto *proto)
-{
-	int val = this_cpu_xchg(*proto->per_cpu_fw_alloc, 0);
-
-	if (val)
-		atomic_long_add(val, proto->memory_allocated);
-}
-
-static inline void
-sk_memory_allocated_add(const struct sock *sk, int val)
-{
-	struct proto *proto = sk->sk_prot;
-
-	val = this_cpu_add_return(*proto->per_cpu_fw_alloc, val);
-
-	if (unlikely(val >= READ_ONCE(sysctl_mem_pcpu_rsv)))
-		proto_memory_pcpu_drain(proto);
-}
-
-static inline void
-sk_memory_allocated_sub(const struct sock *sk, int val)
-{
-	struct proto *proto = sk->sk_prot;
-
-	val = this_cpu_sub_return(*proto->per_cpu_fw_alloc, val);
-
-	if (unlikely(val <= -READ_ONCE(sysctl_mem_pcpu_rsv)))
-		proto_memory_pcpu_drain(proto);
-}
-
 #define SK_ALLOC_PERCPU_COUNTER_BATCH 16
 
 static inline void sk_sockets_allocated_dec(struct sock *sk)
@@ -1466,15 +1397,6 @@ proto_sockets_allocated_sum_positive(struct proto *prot)
 	return percpu_counter_sum_positive(prot->sockets_allocated);
 }
 
-static inline bool
-proto_memory_pressure(struct proto *prot)
-{
-	if (!prot->memory_pressure)
-		return false;
-	return !!READ_ONCE(*prot->memory_pressure);
-}
-
-
 #ifdef CONFIG_PROC_FS
 #define PROTO_INUSE_NR	64	/* should be enough for the first time */
 struct prot_inuse {
diff --git a/net/core/sock.c b/net/core/sock.c
index fe9195186c13f51b113f8e8bc69ea25ea4a13aad..e0692b752369cc1cbf34253a40c06d18dcf350fe 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -127,6 +127,7 @@
 #include <net/net_namespace.h>
 #include <net/request_sock.h>
 #include <net/sock.h>
+#include <net/proto_memory.h>
 #include <linux/net_tstamp.h>
 #include <net/xfrm.h>
 #include <linux/ipsec.h>
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 118c78615543852eabd3067bbb7920418b7da7b3..a452a330d0ed649a2d1b8e65c81aaa3ff3d826f8 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -24,6 +24,7 @@
 #include <net/busy_poll.h>
 #include <net/pkt_sched.h>
 #include <net/hotdata.h>
+#include <net/proto_memory.h>
 #include <net/rps.h>
 
 #include "dev.h"
diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index 914bc9c35cc702395aee257fb010034294e501de..6c4664c681ca530d67b9ccc54f11cbb178d32c8e 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -33,6 +33,7 @@
 #include <net/protocol.h>
 #include <net/tcp.h>
 #include <net/mptcp.h>
+#include <net/proto_memory.h>
 #include <net/udp.h>
 #include <net/udplite.h>
 #include <linux/bottom_half.h>
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0a3aa30470837f27d7db1a0328228b2e3323bad0..e1f0efbb29d614ed81d4485ae81613f0f97db54a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -272,6 +272,7 @@
 #include <net/inet_common.h>
 #include <net/tcp.h>
 #include <net/mptcp.h>
+#include <net/proto_memory.h>
 #include <net/xfrm.h>
 #include <net/ip.h>
 #include <net/sock.h>
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 384fa5e2f0655389ac678b5d13553949598a9c74..233c34c0b49461ddf863373f0b441e01068fb92f 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -72,6 +72,7 @@
 #include <linux/prefetch.h>
 #include <net/dst.h>
 #include <net/tcp.h>
+#include <net/proto_memory.h>
 #include <net/inet_common.h>
 #include <linux/ipsec.h>
 #include <asm/unaligned.h>
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index ea7ad7d99245c26f4045ebb344bc42cd188afe37..57edf66ff91b3aebbb808604678603792025318c 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -39,6 +39,7 @@
 
 #include <net/tcp.h>
 #include <net/mptcp.h>
+#include <net/proto_memory.h>
 
 #include <linux/compiler.h>
 #include <linux/gfp.h>
diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 08fdf1251f46af2c7abb154b35d951913ae90fa1..5adf0c0a6c1acdb354a6815b4b77b63599e0166e 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -38,6 +38,7 @@
 #include <linux/inet.h>
 #include <linux/slab.h>
 #include <net/sock.h>
+#include <net/proto_memory.h>
 #include <net/inet_ecn.h>
 #include <linux/skbuff.h>
 #include <net/sctp/sctp.h>
-- 
2.44.0.769.g3c40516874-goog


