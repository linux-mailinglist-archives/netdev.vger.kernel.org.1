Return-Path: <netdev+bounces-222410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7769CB5420C
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 07:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9A1C7AC72E
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 05:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55782280305;
	Fri, 12 Sep 2025 05:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1hRzGnG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200DC2773D9
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 05:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757654920; cv=none; b=JIFEKHOTYtfkZo8aAIEzSmlLgklRJkOjnJG/kBkcXTYNO0CA1vl+CJ6z4Pw/6tZ+Lc/k7r3D5PjuEwUDZy/s60HyOvemPWLdGBBowh4SH2+de11GE7XYs+rXLyeRd77fbYNjmyLJIQaKNhgKw79xMosvez2wTwRqzvPvqnghYTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757654920; c=relaxed/simple;
	bh=zN4SN/j2ISft3iy7uc3CczU8w6NhqwXrwEh+is5t9QU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hP6+Gx5Ajy1lH1ZSMXx8p/oWrcBjxPfvbn/FxtN803TcMF3gmnC42jchA0U1YBTNFIgy/QBjTGpr5M7GOFFMIA4tHaKNMuxIK1rCEbEjRkntkdC7J5RPkb192uy1gzWfQBcPgeC+qxocA9wadKb3Y0G+7f6IDR7hTAw6jyEcoEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1hRzGnG; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d603cebd9so12631567b3.1
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 22:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757654917; x=1758259717; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEqnbE9/rgWsIS4LQviPEL5Xbu9Py0soYdydYPEU9K0=;
        b=A1hRzGnGITTSHsa+2iIumRNOOMQ/lWFilBywJr4Y+9Ga54PAjoUTp0XDQuIIo6U6/M
         vFlWmxEVDR9/WhpQQ/QAmqZVfVON3BSRGxvnRWuUvCViUVkN4O9BkBzdN8Db3qMwABsx
         DTda2p+WS+r4pMoI2hk1tQspSRrIV6SZGprvhHdqMkta/Ue4F0F2A1zynSZkwZymkn3i
         w28ZkVi4DzadVk4zZrvuibmgEU1eMtFDsk4/lm0Mr86pjy4y4tiN8kK591IzY5GnCqB3
         D5s5SR7fGPxp1g9kbpeILFSQoPHZImWjelROK4/wk1IeyqKB6gz4+d8E1VJZQHCTdMiR
         aDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757654917; x=1758259717;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PEqnbE9/rgWsIS4LQviPEL5Xbu9Py0soYdydYPEU9K0=;
        b=HcenCXrtKpYcIJMWSOh4vDrllYZeFTWSRLQg9/wghy8P8OUEGgTqsS7dCudU6ITot+
         K9Mz/Tuqpz+lBG117Cm/2UWcpT93TP9NeNLoyHi3pIjosGrsFDHpceqm9TE7KNULvN8X
         VTyS0Zuk9VlO7H9DxRVw+2p9Z+qDMHQdfMBp0CLI7+Rj7ECjWqb77qqS+o8+MJzAVkuV
         a3XnaD3MsdW3CNGj3bL+4WBtUpPp05PDisBLApGNQLFpA2wdngfubjJbyW8q0M7WgFi9
         9KHPnVU8wE2z7oO3jWuJrUT7FCuQ+qgfMxrIYYMXs4WYo7ogctKTLrx2T8JipeP8wFNH
         sdGg==
X-Gm-Message-State: AOJu0Ywxb3TOYTuq+lobYE9Il7LQOwEbw84YCsI7mDCulKnreIk+MlW4
	ewcjb/dQJDVJrKf9YvSPgqhTjZbIZ5vBK+LaeXas35v3eEtIVAnIQjV5
X-Gm-Gg: ASbGncvkQm+6/NW6y3chGxkFawndOC0kc0llV5Qnsg33nkR8XThaDBPLncagx/OrgCk
	4d1XBjMcnwz3O4jK/pTtVR3reKl4OLfouXX+bf7UUcvkMBr5aE6qQXX7P1JXI+HTUYWp2aKzI+a
	2kWgCPl7ZvnhiIhOArcsoGWz3hKos6sq+51y7PUSiie+AWrfoStY9X/2tlNHI+fFLUrkpVQL8s/
	dpHxFa+ObIix0XA7Qg1Xlx2havsKBMFf9n5tD3C2pfsQSdzdKlt8Ka6+d46k9mSr+UIOm/uCIQx
	3WGBMIctFFs+t311Pt4mRM8VkwRyl2pwo4WwAREq9V3yVAOuYyvkhmr81yfOv9yL5zIaJF1x9er
	99bnsOEubYEe8QnOog0Q1
X-Google-Smtp-Source: AGHT+IGk2MxFPWEVq4ijWMadHnGEJiVkiExVcRwLD7RgFfY3XTYFj6a+tI/I+l20YSJnSia7QLY9Xg==
X-Received: by 2002:a05:690c:6104:b0:72c:54a3:f051 with SMTP id 00721157ae682-730626d26c7mr16759827b3.1.1757654916965;
        Thu, 11 Sep 2025 22:28:36 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f791a3759sm8574067b3.36.2025.09.11.22.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 22:28:36 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 11 Sep 2025 22:28:16 -0700
Subject: [PATCH net-next v2 2/3] net: devmem: use niov array for token
 management
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-scratch-bobbyeshleman-devmem-tcp-token-upstream-v2-2-c80d735bd453@meta.com>
References: <20250911-scratch-bobbyeshleman-devmem-tcp-token-upstream-v2-0-c80d735bd453@meta.com>
In-Reply-To: <20250911-scratch-bobbyeshleman-devmem-tcp-token-upstream-v2-0-c80d735bd453@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Improve CPU performance of devmem token management by using page offsets
as dmabuf tokens and using them for direct array access lookups instead
of xarray lookups. Consequently, the xarray can be removed. The result
is an average 5% reduction in CPU cycles spent by devmem RX user
threads.

This patch changes the meaning of tokens. Tokens previously referred to
unique fragments of pages. In this patch tokens instead represent
references to pages, not fragments.  Because of this, multiple tokens
may refer to the same page and so have identical value (e.g., two small
fragments may coexist on the same page). The token and offset pair that
the user receives uniquely identifies fragments if needed.  This assumes
that the user is not attempting to sort / uniq the token list using
tokens alone.

A new restriction is added to the implementation: devmem RX sockets
cannot switch dmabuf bindings. In practice, this is a symptom of invalid
configuration as a flow would have to be steered to a different queue or
device where there is a different binding, which is generally bad for
TCP flows. This restriction is necessary because the 32-bit dmabuf token
does not have enough bits to represent both the pages in a large dmabuf
and also a binding or dmabuf ID. For example, a system with 8 NICs and
32 queues requires 8 bits for a binding / queue ID (8 NICs * 32 queues
== 256 queues total == 2^8), which leaves only 24 bits for dmabuf pages
(2^24 * 4096 / (1<<30) == 64GB). This is insufficient for the device and
queue numbers on many current systems or systems that may need larger
GPU dmabufs (as for hard limits, my current H100 has 80GB GPU memory per
device).

Using kperf[1] with 4 flows and workers, this patch improves receive
worker CPU util by ~4.9% with slightly better throughput.

Before, mean cpu util for rx workers ~83.6%:

Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
Average:       4    2.30    0.00   79.43    0.00    0.65    0.21    0.00    0.00    0.00   17.41
Average:       5    2.27    0.00   80.40    0.00    0.45    0.21    0.00    0.00    0.00   16.67
Average:       6    2.28    0.00   80.47    0.00    0.46    0.25    0.00    0.00    0.00   16.54
Average:       7    2.42    0.00   82.05    0.00    0.46    0.21    0.00    0.00    0.00   14.86

After, mean cpu util % for rx workers ~78.7%:

Average:     CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
Average:       4    2.61    0.00   73.31    0.00    0.76    0.11    0.00    0.00    0.00   23.20
Average:       5    2.95    0.00   74.24    0.00    0.66    0.22    0.00    0.00    0.00   21.94
Average:       6    2.81    0.00   73.38    0.00    0.97    0.11    0.00    0.00    0.00   22.73
Average:       7    3.05    0.00   78.76    0.00    0.76    0.11    0.00    0.00    0.00   17.32

Mean throughput improves, but falls within a standard deviation (~45GB/s
for 4 flows on a 50GB/s NIC, one hop).

This patch adds an array of atomics for counting the tokens returned to
the user for a given page. There is a 4-byte atomic per page in the
dmabuf per socket. Given a 2GB dmabuf, this array is 2MB.

[1]: https://github.com/facebookexperimental/kperf

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v2:
- always use GFP_ZERO for binding->vec (Mina)
- remove WARN for changed binding (Mina)
- remove extraneous binding ref get (Mina)
- remove WARNs on invalid user input (Mina)
- pre-assign niovs in binding->vec for RX case (Mina)
- use atomic_set(, 0) to initialize sk_user_frags.urefs
- fix length of alloc for urefs
---
 include/net/sock.h       |   5 ++-
 net/core/devmem.c        |  17 +++-----
 net/core/devmem.h        |   2 +-
 net/core/sock.c          |  23 +++++++---
 net/ipv4/tcp.c           | 111 ++++++++++++++++-------------------------------
 net/ipv4/tcp_ipv4.c      |  39 ++++++++++++++---
 net/ipv4/tcp_minisocks.c |   2 -
 7 files changed, 99 insertions(+), 100 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 896bec2d2176..304aad494764 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -575,7 +575,10 @@ struct sock {
 #endif
 	struct rcu_head		sk_rcu;
 	netns_tracker		ns_tracker;
-	struct xarray		sk_user_frags;
+	struct {
+		struct net_devmem_dmabuf_binding	*binding;
+		atomic_t				*urefs;
+	} sk_user_frags;
 
 #if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
 	struct module		*sk_owner;
diff --git a/net/core/devmem.c b/net/core/devmem.c
index b4c570d4f37a..1dae43934942 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -230,14 +230,12 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 		goto err_detach;
 	}
 
-	if (direction == DMA_TO_DEVICE) {
-		binding->vec = kvmalloc_array(dmabuf->size / PAGE_SIZE,
-					      sizeof(struct net_iov *),
-					      GFP_KERNEL);
-		if (!binding->vec) {
-			err = -ENOMEM;
-			goto err_unmap;
-		}
+	binding->vec = kvmalloc_array(dmabuf->size / PAGE_SIZE,
+				      sizeof(struct net_iov *),
+				      GFP_KERNEL | __GFP_ZERO);
+	if (!binding->vec) {
+		err = -ENOMEM;
+		goto err_unmap;
 	}
 
 	/* For simplicity we expect to make PAGE_SIZE allocations, but the
@@ -293,8 +291,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 			niov->owner = &owner->area;
 			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
 						      net_devmem_get_dma_addr(niov));
-			if (direction == DMA_TO_DEVICE)
-				binding->vec[owner->area.base_virtual / PAGE_SIZE + i] = niov;
+			binding->vec[owner->area.base_virtual / PAGE_SIZE + i] = niov;
 		}
 
 		virtual += len;
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 2ada54fb63d7..d4eb28d079bb 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -61,7 +61,7 @@ struct net_devmem_dmabuf_binding {
 
 	/* Array of net_iov pointers for this binding, sorted by virtual
 	 * address. This array is convenient to map the virtual addresses to
-	 * net_iovs in the TX path.
+	 * net_iovs.
 	 */
 	struct net_iov **vec;
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 1f8ef4d8bcd9..15e198842b4a 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -87,6 +87,7 @@
 
 #include <linux/unaligned.h>
 #include <linux/capability.h>
+#include <linux/dma-buf.h>
 #include <linux/errno.h>
 #include <linux/errqueue.h>
 #include <linux/types.h>
@@ -151,6 +152,7 @@
 #include <uapi/linux/pidfd.h>
 
 #include "dev.h"
+#include "devmem.h"
 
 static DEFINE_MUTEX(proto_list_mutex);
 static LIST_HEAD(proto_list);
@@ -1100,32 +1102,39 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
 		return -EFAULT;
 	}
 
-	xa_lock_bh(&sk->sk_user_frags);
 	for (i = 0; i < num_tokens; i++) {
 		for (j = 0; j < tokens[i].token_count; j++) {
+			struct net_iov *niov;
+			unsigned int token;
+			netmem_ref netmem;
+
+			token = tokens[i].token_start + j;
+			if (token >= sk->sk_user_frags.binding->dmabuf->size / PAGE_SIZE)
+				break;
+
 			if (++num_frags > MAX_DONTNEED_FRAGS)
 				goto frag_limit_reached;
-
-			netmem_ref netmem = (__force netmem_ref)__xa_erase(
-				&sk->sk_user_frags, tokens[i].token_start + j);
+			niov = sk->sk_user_frags.binding->vec[token];
+			netmem = net_iov_to_netmem(niov);
 
 			if (!netmem || WARN_ON_ONCE(!netmem_is_net_iov(netmem)))
 				continue;
 
+			if (atomic_dec_if_positive(&sk->sk_user_frags.urefs[token])
+						< 0)
+				continue;
+
 			netmems[netmem_num++] = netmem;
 			if (netmem_num == ARRAY_SIZE(netmems)) {
-				xa_unlock_bh(&sk->sk_user_frags);
 				for (k = 0; k < netmem_num; k++)
 					WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
 				netmem_num = 0;
-				xa_lock_bh(&sk->sk_user_frags);
 			}
 			ret++;
 		}
 	}
 
 frag_limit_reached:
-	xa_unlock_bh(&sk->sk_user_frags);
 	for (k = 0; k < netmem_num; k++)
 		WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 7f9c671b1ee0..438b8132ed89 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -261,6 +261,7 @@
 #include <linux/memblock.h>
 #include <linux/highmem.h>
 #include <linux/cache.h>
+#include <linux/dma-buf.h>
 #include <linux/err.h>
 #include <linux/time.h>
 #include <linux/slab.h>
@@ -491,7 +492,8 @@ void tcp_init_sock(struct sock *sk)
 
 	set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
 	sk_sockets_allocated_inc(sk);
-	xa_init_flags(&sk->sk_user_frags, XA_FLAGS_ALLOC1);
+	sk->sk_user_frags.binding = NULL;
+	sk->sk_user_frags.urefs = NULL;
 }
 EXPORT_IPV6_MOD(tcp_init_sock);
 
@@ -2402,68 +2404,6 @@ static int tcp_inq_hint(struct sock *sk)
 	return inq;
 }
 
-/* batch __xa_alloc() calls and reduce xa_lock()/xa_unlock() overhead. */
-struct tcp_xa_pool {
-	u8		max; /* max <= MAX_SKB_FRAGS */
-	u8		idx; /* idx <= max */
-	__u32		tokens[MAX_SKB_FRAGS];
-	netmem_ref	netmems[MAX_SKB_FRAGS];
-};
-
-static void tcp_xa_pool_commit_locked(struct sock *sk, struct tcp_xa_pool *p)
-{
-	int i;
-
-	/* Commit part that has been copied to user space. */
-	for (i = 0; i < p->idx; i++)
-		__xa_cmpxchg(&sk->sk_user_frags, p->tokens[i], XA_ZERO_ENTRY,
-			     (__force void *)p->netmems[i], GFP_KERNEL);
-	/* Rollback what has been pre-allocated and is no longer needed. */
-	for (; i < p->max; i++)
-		__xa_erase(&sk->sk_user_frags, p->tokens[i]);
-
-	p->max = 0;
-	p->idx = 0;
-}
-
-static void tcp_xa_pool_commit(struct sock *sk, struct tcp_xa_pool *p)
-{
-	if (!p->max)
-		return;
-
-	xa_lock_bh(&sk->sk_user_frags);
-
-	tcp_xa_pool_commit_locked(sk, p);
-
-	xa_unlock_bh(&sk->sk_user_frags);
-}
-
-static int tcp_xa_pool_refill(struct sock *sk, struct tcp_xa_pool *p,
-			      unsigned int max_frags)
-{
-	int err, k;
-
-	if (p->idx < p->max)
-		return 0;
-
-	xa_lock_bh(&sk->sk_user_frags);
-
-	tcp_xa_pool_commit_locked(sk, p);
-
-	for (k = 0; k < max_frags; k++) {
-		err = __xa_alloc(&sk->sk_user_frags, &p->tokens[k],
-				 XA_ZERO_ENTRY, xa_limit_31b, GFP_KERNEL);
-		if (err)
-			break;
-	}
-
-	xa_unlock_bh(&sk->sk_user_frags);
-
-	p->max = k;
-	p->idx = 0;
-	return k ? 0 : err;
-}
-
 /* On error, returns the -errno. On success, returns number of bytes sent to the
  * user. May not consume all of @remaining_len.
  */
@@ -2472,14 +2412,11 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 			      int remaining_len)
 {
 	struct dmabuf_cmsg dmabuf_cmsg = { 0 };
-	struct tcp_xa_pool tcp_xa_pool;
 	unsigned int start;
 	int i, copy, n;
 	int sent = 0;
 	int err = 0;
 
-	tcp_xa_pool.max = 0;
-	tcp_xa_pool.idx = 0;
 	do {
 		start = skb_headlen(skb);
 
@@ -2526,8 +2463,11 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 		 */
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+			struct net_devmem_dmabuf_binding *binding;
 			struct net_iov *niov;
 			u64 frag_offset;
+			size_t len;
+			u32 token;
 			int end;
 
 			/* !skb_frags_readable() should indicate that ALL the
@@ -2560,13 +2500,39 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 					      start;
 				dmabuf_cmsg.frag_offset = frag_offset;
 				dmabuf_cmsg.frag_size = copy;
-				err = tcp_xa_pool_refill(sk, &tcp_xa_pool,
-							 skb_shinfo(skb)->nr_frags - i);
-				if (err)
+
+				binding = net_devmem_iov_binding(niov);
+
+				if (!sk->sk_user_frags.binding) {
+					sk->sk_user_frags.binding = binding;
+
+					len = binding->dmabuf->size / PAGE_SIZE;
+					sk->sk_user_frags.urefs = kzalloc(len * sizeof(*sk->sk_user_frags.urefs),
+									  GFP_KERNEL);
+					if (!sk->sk_user_frags.urefs) {
+						sk->sk_user_frags.binding = NULL;
+						err = -ENOMEM;
+						goto out;
+					}
+
+					for (token = 0; token < len; token++)
+						atomic_set(&sk->sk_user_frags.urefs[token],
+							   0);
+
+					spin_lock_bh(&devmem_sockets_lock);
+					list_add(&sk->sk_devmem_list, &devmem_sockets_list);
+					spin_unlock_bh(&devmem_sockets_lock);
+				}
+
+				if (sk->sk_user_frags.binding != binding) {
+					err = -EFAULT;
 					goto out;
+				}
+
+				token = net_iov_virtual_addr(niov) >> PAGE_SHIFT;
+				dmabuf_cmsg.frag_token = token;
 
 				/* Will perform the exchange later */
-				dmabuf_cmsg.frag_token = tcp_xa_pool.tokens[tcp_xa_pool.idx];
 				dmabuf_cmsg.dmabuf_id = net_devmem_iov_binding_id(niov);
 
 				offset += copy;
@@ -2579,8 +2545,9 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 				if (err)
 					goto out;
 
+				atomic_inc(&sk->sk_user_frags.urefs[token]);
+
 				atomic_long_inc(&niov->pp_ref_count);
-				tcp_xa_pool.netmems[tcp_xa_pool.idx++] = skb_frag_netmem(frag);
 
 				sent += copy;
 
@@ -2590,7 +2557,6 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 			start = end;
 		}
 
-		tcp_xa_pool_commit(sk, &tcp_xa_pool);
 		if (!remaining_len)
 			goto out;
 
@@ -2608,7 +2574,6 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 	}
 
 out:
-	tcp_xa_pool_commit(sk, &tcp_xa_pool);
 	if (!sent)
 		sent = err;
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 2a0602035729..68ebf96d06f8 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -87,6 +87,9 @@
 #include <crypto/hash.h>
 #include <linux/scatterlist.h>
 
+#include <linux/dma-buf.h>
+#include "../core/devmem.h"
+
 #include <trace/events/tcp.h>
 
 #ifdef CONFIG_TCP_MD5SIG
@@ -2525,11 +2528,37 @@ static int tcp_v4_init_sock(struct sock *sk)
 static void tcp_release_user_frags(struct sock *sk)
 {
 #ifdef CONFIG_PAGE_POOL
-	unsigned long index;
-	void *netmem;
+	struct net_devmem_dmabuf_binding *binding;
+	struct net_iov *niov;
+	unsigned int token;
+	netmem_ref netmem;
+
+	if (!sk->sk_user_frags.urefs)
+		return;
+
+	binding = sk->sk_user_frags.binding;
+	if (!binding || !binding->vec)
+		return;
+
+	for (token = 0; token < binding->dmabuf->size / PAGE_SIZE; token++) {
+		niov = binding->vec[token];
+
+		/* never used by recvmsg() */
+		if (!niov)
+			continue;
+
+		if (!net_is_devmem_iov(niov))
+			continue;
+
+		netmem = net_iov_to_netmem(niov);
 
-	xa_for_each(&sk->sk_user_frags, index, netmem)
-		WARN_ON_ONCE(!napi_pp_put_page((__force netmem_ref)netmem));
+		while (atomic_dec_return(&sk->sk_user_frags.urefs[token]) >= 0)
+			WARN_ON_ONCE(!napi_pp_put_page(netmem));
+	}
+
+	sk->sk_user_frags.binding = NULL;
+	kvfree(sk->sk_user_frags.urefs);
+	sk->sk_user_frags.urefs = NULL;
 #endif
 }
 
@@ -2539,8 +2568,6 @@ void tcp_v4_destroy_sock(struct sock *sk)
 
 	tcp_release_user_frags(sk);
 
-	xa_destroy(&sk->sk_user_frags);
-
 	trace_tcp_destroy_sock(sk);
 
 	tcp_clear_xmit_timers(sk);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 7c2ae07d8d5d..6a44df3074df 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -630,8 +630,6 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 
 	__TCP_INC_STATS(sock_net(sk), TCP_MIB_PASSIVEOPENS);
 
-	xa_init_flags(&newsk->sk_user_frags, XA_FLAGS_ALLOC1);
-
 	return newsk;
 }
 EXPORT_SYMBOL(tcp_create_openreq_child);

-- 
2.47.3


