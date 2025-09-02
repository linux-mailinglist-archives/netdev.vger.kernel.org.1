Return-Path: <netdev+bounces-219324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A7DB40F84
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA211B60B76
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 21:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E384F35CED8;
	Tue,  2 Sep 2025 21:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYLpV6MG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB92635CEA7;
	Tue,  2 Sep 2025 21:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756848996; cv=none; b=rlAtw7a2m8OHWTxYj7cOyg3SrFDaiUnOqpWVnhJ1bv6C8ub8pf5Aj9IdEUPesvJdyyHixB4xLAEcX4uGktu6sVbm3FBbVmFXb1XKYfzYGo40i3nVy/dJ7+lfx6PXqTzdNrYH7eXkVvqeIRePWYrfOrXVe1/RpNY4VJ7yzrd3e/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756848996; c=relaxed/simple;
	bh=fTF5UlpsheorT5Z8rIeEoGI0ZsC2W1CIHKjY4sKR0oQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nZkngCs+VMjh0meMWosTZfXqS9jNBFwpIxKird8ng4z+LCfJj6nYWyoYKk/NLv3ayFxc/q6LfVipwGtRHjOHEycDLZ+eWk+iSAGS385tHnfBqaF+t+cSgSRdTOi6q1m/Y1Bbd/I0h6YAANnWI5GTowcL0PsbXC4IcU87R05leHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYLpV6MG; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e98b64d7000so2396046276.3;
        Tue, 02 Sep 2025 14:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756848993; x=1757453793; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cfzx+u2OQDCo7JXOlZrh5oT7uzquk0WoiGrefk5dK28=;
        b=fYLpV6MGEqfTYUEDlm1r9X4RHO1Bg4U/nNny0+uJufK2w93t3lHTD0VPYmbZC/6r5U
         jj3BhlbDphZSyfLtiK2dPmsNKn4hlXk5tvk+3oDs60cjAD5P7YcO4zrLqoeUglGw0dre
         HXysuEKHRWJ60/3ND3KFyNmcRPHypN0P5JDqUN0fTrD+d1mnwvNPcgKpdeHb8oGMiSHk
         eSnfPotLYo2VYl3ZPdPvnELs+HsWOE3dLFOwCM/f6lP+ZJaS/ZqMcCvmVj18sGvKS6fd
         PAbo/7bLgREv+3SpV9TihFod/uAIAqOUW03fkQO2z6J9IA2/dVYUpEZ2fvYdGkmBpe0E
         qB9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756848993; x=1757453793;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfzx+u2OQDCo7JXOlZrh5oT7uzquk0WoiGrefk5dK28=;
        b=WzESgBUTC80VJGivV06FAKmZLbk88vfBz+8/mrKwOYNDZHqLwExzOf+EkGd63Rfd74
         nCs6qdU8bKsyDYA7KD7b8vaRrm/x31MfIMKweJuVFN+m+vVV28zdo/4s3OtVsIan/55I
         sb0XIYGeF+hrzA2Ti6ko/cxoNikAzuqB4fgtskTuh23mywMCjUPWD1RJA/C2uKzTJXQD
         97LNPn6MXrXJQo/GNMl624RRXL+eTy84WiCosbErbtCwx9sA0Rflj5Es8EngL60pE8fN
         LfuP0RItwo/dPSTjk9HYSKie8ukDi78LCN7Vn8zLSFCtYeI9zVIV0DRpnPC3I/+Ma+86
         FlGw==
X-Forwarded-Encrypted: i=1; AJvYcCVERCYt4NhieBQ7j3V5yhctE3uxM1pQLFKzA1mYvsR8AHPL0hw6uyFs0XCBqi2hd8wBGEM4/WVmSRVGj2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDgi6W8Upm+m1WWOHsDMP3Xoj0LBK//XZXVKHkWcUFglqEps95
	9/PZip82fVanrw6stv2gVjmyxxIDXs5/ke6O9nWeF0MJ25Wy9f07rKPmlpyPNiX4v62Nmw==
X-Gm-Gg: ASbGncugk3UeWRk/pXP6xVvXi50foZc409+TrQR+NpPIZShxCyrz3oCSQ4oQXJL2uCn
	xzLcXPs8z8I1wr9yjrwGqvRwVTK0aQeDrgYsHzHPskZU386Ws224/+2kqr7xn0gKR3EVitVNTmB
	UGZO+4gXFxLrsvlzjErWOoOHDJqeKMlPrCtp6pGmbpv/HkDpsAeDbTYvEPP9p4b2ZPWOlhRyB0d
	Iv+jUuoxqRmqXhKto/ZdwspiSoDSRcbIARCMjWwBUNF1QGwIbx7zY3OGnrRccwO2TDabHSGd3pL
	gZ02RCLgtw0qnKyKSOOiPnp19aOPUCcWZUGpLe4JyhkYhXg2iHMeowBL5bxnkWOVP81160Cglcs
	vFNj2ybnu+dDLiGE/7BvtsdiJb5RopBkz
X-Google-Smtp-Source: AGHT+IHDiMX9htBgqAhPYFlb7R7f62qsaXpBu4kYH7gKNdoseWGOPQfQG8qt4c7bEc3375l1O9qXug==
X-Received: by 2002:a05:6902:1544:b0:e98:9737:e8d9 with SMTP id 3f1490d57ef6-e98a5820d4amr15508339276.33.1756848993001;
        Tue, 02 Sep 2025 14:36:33 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:56::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9bbe08c80bsm926246276.29.2025.09.02.14.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 14:36:31 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 02 Sep 2025 14:36:28 -0700
Subject: [PATCH net-next 2/2] net: devmem: use niov array for token
 management
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-scratch-bobbyeshleman-devmem-tcp-token-upstream-v1-2-d946169b5550@meta.com>
References: <20250902-scratch-bobbyeshleman-devmem-tcp-token-upstream-v1-0-d946169b5550@meta.com>
In-Reply-To: <20250902-scratch-bobbyeshleman-devmem-tcp-token-upstream-v1-0-d946169b5550@meta.com>
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
 include/net/sock.h       |   5 ++-
 net/core/devmem.c        |  17 ++++----
 net/core/devmem.h        |   2 +-
 net/core/sock.c          |  24 +++++++----
 net/ipv4/tcp.c           | 107 +++++++++++++++--------------------------------
 net/ipv4/tcp_ipv4.c      |  40 +++++++++++++++---
 net/ipv4/tcp_minisocks.c |   2 -
 7 files changed, 99 insertions(+), 98 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 1e7f124871d2..70c97880229d 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -573,7 +573,10 @@ struct sock {
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
index b4c570d4f37a..50e92dcf5bf1 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -187,6 +187,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 	struct dma_buf *dmabuf;
 	unsigned int sg_idx, i;
 	unsigned long virtual;
+	gfp_t flags;
 	int err;
 
 	if (!dma_dev) {
@@ -230,14 +231,14 @@ net_devmem_bind_dmabuf(struct net_device *dev,
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
+	flags = (direction == DMA_FROM_DEVICE) ? __GFP_ZERO : 0;
+
+	binding->vec = kvmalloc_array(dmabuf->size / PAGE_SIZE,
+				      sizeof(struct net_iov *),
+				      GFP_KERNEL | flags);
+	if (!binding->vec) {
+		err = -ENOMEM;
+		goto err_unmap;
 	}
 
 	/* For simplicity we expect to make PAGE_SIZE allocations, but the
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
index 9a8290fcc35d..3a5cb4e10519 100644
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
@@ -1100,32 +1102,40 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
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
+			if (WARN_ONCE(token >= sk->sk_user_frags.binding->dmabuf->size / PAGE_SIZE,
+				      "invalid token passed from user"))
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
 
+			if (WARN_ONCE(atomic_dec_if_positive(&sk->sk_user_frags.urefs[token])
+						< 0, "user released token too many times"))
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
index 40b774b4f587..585b50fa8c00 100644
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
@@ -475,7 +476,8 @@ void tcp_init_sock(struct sock *sk)
 
 	set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
 	sk_sockets_allocated_inc(sk);
-	xa_init_flags(&sk->sk_user_frags, XA_FLAGS_ALLOC1);
+	sk->sk_user_frags.binding = NULL;
+	sk->sk_user_frags.urefs = NULL;
 }
 EXPORT_IPV6_MOD(tcp_init_sock);
 
@@ -2386,68 +2388,6 @@ static int tcp_inq_hint(struct sock *sk)
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
@@ -2456,14 +2396,11 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
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
 
@@ -2510,8 +2447,11 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 		 */
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+			struct net_devmem_dmabuf_binding *binding;
 			struct net_iov *niov;
 			u64 frag_offset;
+			size_t size;
+			u32 token;
 			int end;
 
 			/* !skb_frags_readable() should indicate that ALL the
@@ -2544,13 +2484,35 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
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
+					size = binding->dmabuf->size / PAGE_SIZE;
+					sk->sk_user_frags.urefs = kzalloc(size,
+									  GFP_KERNEL);
+					if (!sk->sk_user_frags.urefs) {
+						sk->sk_user_frags.binding = NULL;
+						err = -ENOMEM;
+						goto out;
+					}
+
+					net_devmem_dmabuf_binding_get(binding);
+				}
+
+				if (WARN_ONCE(sk->sk_user_frags.binding != binding,
+					      "binding changed for devmem socket")) {
+					err = -EFAULT;
 					goto out;
+				}
+
+				token = net_iov_virtual_addr(niov) >> PAGE_SHIFT;
+				binding->vec[token] = niov;
+				dmabuf_cmsg.frag_token = token;
 
 				/* Will perform the exchange later */
-				dmabuf_cmsg.frag_token = tcp_xa_pool.tokens[tcp_xa_pool.idx];
 				dmabuf_cmsg.dmabuf_id = net_devmem_iov_binding_id(niov);
 
 				offset += copy;
@@ -2563,8 +2525,9 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 				if (err)
 					goto out;
 
+				atomic_inc(&sk->sk_user_frags.urefs[token]);
+
 				atomic_long_inc(&niov->pp_ref_count);
-				tcp_xa_pool.netmems[tcp_xa_pool.idx++] = skb_frag_netmem(frag);
 
 				sent += copy;
 
@@ -2574,7 +2537,6 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 			start = end;
 		}
 
-		tcp_xa_pool_commit(sk, &tcp_xa_pool);
 		if (!remaining_len)
 			goto out;
 
@@ -2592,7 +2554,6 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 	}
 
 out:
-	tcp_xa_pool_commit(sk, &tcp_xa_pool);
 	if (!sent)
 		sent = err;
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 1e58a8a9ff7a..bdcb8cc003af 100644
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
@@ -2529,11 +2532,38 @@ static void tcp_md5sig_info_free_rcu(struct rcu_head *head)
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
+	net_devmem_dmabuf_binding_put(binding);
+	sk->sk_user_frags.binding = NULL;
+	kvfree(sk->sk_user_frags.urefs);
+	sk->sk_user_frags.urefs = NULL;
 #endif
 }
 
@@ -2543,8 +2573,6 @@ void tcp_v4_destroy_sock(struct sock *sk)
 
 	tcp_release_user_frags(sk);
 
-	xa_destroy(&sk->sk_user_frags);
-
 	trace_tcp_destroy_sock(sk);
 
 	tcp_clear_xmit_timers(sk);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index d1c9e4088646..4e8ea73daab7 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -639,8 +639,6 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 
 	__TCP_INC_STATS(sock_net(sk), TCP_MIB_PASSIVEOPENS);
 
-	xa_init_flags(&newsk->sk_user_frags, XA_FLAGS_ALLOC1);
-
 	return newsk;
 }
 EXPORT_SYMBOL(tcp_create_openreq_child);

-- 
2.47.3


