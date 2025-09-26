Return-Path: <netdev+bounces-226744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09330BA4A59
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 18:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60E95179EB9
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 16:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D505C2FF14D;
	Fri, 26 Sep 2025 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfdT1bPS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8232ECD13
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904302; cv=none; b=X4yT/9alatTbH0bm4qXZoNEAMfgcCtgND0bZNVcJI2kJTeD2nUnhajE4Tv6yl81mmBkK+FUB9IOaNG0qzy6xAerGz8kF7rOjPIqV83plWN8bn6UjG/tXIhYfWjrBjnh5XuW1L2eEHoRpKjFmp8M8XChwwl4Mi1Mi1qWKj0UX4+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904302; c=relaxed/simple;
	bh=ciPcANRLds+EL/qXSVt8wo8GJ9bCXUfLzSDerdZbIZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P56+I+ehJHfiFgPaK5r36aWwpQGCMHMXTa+f689Av3tWLpttCcuoFAcZRV5HTZKkE0s1lypkTcfr/lqgynZMTb8U88+6bVik85bx1TAsXr8KTMpxS13N7oIdw3kIG5C84TQvboZ5N7HWpYCGIfRqumdP2CeGKSCD+tRT5pwBF64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfdT1bPS; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71d6083cc69so28776717b3.2
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 09:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758904299; x=1759509099; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D3eeKjAA3QDPJpcB3ypbzWNiO5HcF9cysir0M9RNVnE=;
        b=mfdT1bPSfjdekQaWzvwaoqiVOUKxsEcmudYW1TK+8D+hAeppb8zxNiLvyw7o1FWBB7
         wT2lv6/Cqml7zsX0ZgvDJsPwyH4Ewz/GN+wXRO9kVJvP2VdKciOm9udpOkHtjabSq+X2
         VFl+hbaz7T+uvPdC1GZIy9BkOZnlBBIKDD8nBOyr4yk4bCMrQsQCb4+LLX2QoIGVJkrI
         Ah+Dgku+hzMNSue9tgJMQK+7IydYGp6hzA1JOUOTdgQ7t4GAb4S311AqCj89x/QYXSu2
         RKLu0zCrBx8d7y1p2fdfXcR7S5+LWS1BWrOC2tpVpWVL5t3oWn2sXUhzWWIv53+6dDO8
         ugkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758904299; x=1759509099;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3eeKjAA3QDPJpcB3ypbzWNiO5HcF9cysir0M9RNVnE=;
        b=PSGCROeAQbkl9b9MGUIVvHlRTtXxhsixlA8ouldqPc9rIkBzj6kMAvqrQY5ejCuXds
         UEAfu/nKFwkz+J8Y/FQOXL7oidf0pYn+HffG6AwpSmY9D7/h4Fm9m/Ox+2B10zbAYyxz
         Ra2BVuEZF4WPtefL0A61yegZIFuGH/3JvSvVdutdnU8LpCtDzTMklEKLpOpH4d/zwLsS
         vpJn2bFZKZcJ8Z5W9nyggkmRqI6KCpig+n5P0q2QKUK6Guc7LOGSb5lpIrncueXHEn+R
         AYqtSGGP954x+6CzERn0ivJstFMiP2YZHibfm9Wzxh0mI8EVCPhAzWeAqSzQ0BVo7Qd8
         KnoA==
X-Gm-Message-State: AOJu0YwG+iOtGuyaJAXY7TY0S5E4xFtJ4yVTw1GH+eZRLqD1Oh4gkPeD
	yrKaf78qpmhnu2E4OWKJF/xT0Q5PjOyEex8RDDpsb+luZyeO58CAG2Jx
X-Gm-Gg: ASbGncsbnEc2uVGwdgH7h9xBNPPHZk7r4SdRg0crTlnjj/aLgbKDeBT06OfA+R9vqjB
	AXom/H1El5Li74lfLPUSTjqAzhxkjKqdxDxxowCphgfRmYKBEXyY+qh6JlB9/czI3WYNmQRzzvG
	/Kl/xDKp3ziw8J3MuGVMUY3Jmyz5ql/w7lro5VqU5rikDxnAk4wJt4Up3WUMZp4crjDdR8j9wE8
	pOkosdpM15bHciWKi/TbPUJZ/pY/6HhbNO0oHqI0GewS5H3YZNpyV/7GaK75UbSyy6vjnOEfLaS
	hSFDTLX+6WekdNBmEckKb9ZI0wTXGpGY08K/ZsBr1bzIR344z/4XTaCcCoP4SyRAycqpMYR+DxK
	gEaveHiFxZAPdIpCNlgC7azkp0BrDG4+zHTqfZYu9Og==
X-Google-Smtp-Source: AGHT+IFUA/3FtV2+rhLzNahbdpkvr1rVGc7TFGYlCqvNfnxh13n6Qlyf79YpNxDRpZv+ir4c7M/5Zw==
X-Received: by 2002:a05:690c:4b90:b0:76c:1926:8029 with SMTP id 00721157ae682-76c1926aadcmr45566797b3.54.1758904299381;
        Fri, 26 Sep 2025 09:31:39 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-765bd125bf5sm11717387b3.18.2025.09.26.09.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 09:31:38 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 26 Sep 2025 09:31:34 -0700
Subject: [PATCH net-next v4 2/2] net: devmem: use niov array for token
 management
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-scratch-bobbyeshleman-devmem-tcp-token-upstream-v4-2-39156563c3ea@meta.com>
References: <20250926-scratch-bobbyeshleman-devmem-tcp-token-upstream-v4-0-39156563c3ea@meta.com>
In-Reply-To: <20250926-scratch-bobbyeshleman-devmem-tcp-token-upstream-v4-0-39156563c3ea@meta.com>
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
references to pages, not fragments. Because of this, multiple tokens may
refer to the same page and so have identical value (e.g., two small
fragments may coexist on the same page). The token and offset pair that
the user receives uniquely identifies fragments if needed.  This assumes
that the user is not attempting to sort / uniq the token list using
tokens alone.

A new restriction is added to the implementation: devmem RX sockets
cannot switch dmabuf bindings. In practice, this is often a symptom of
invalid configuration as a flow would have to be steered to a different
queue or device where there is a different binding, which is generally
bad for TCP flows. This restriction is necessary because the 32-bit
dmabuf token does not have enough bits to represent both the pages in a
large dmabuf and also a binding or dmabuf ID. For example, a system with
8 NICs and 32 queues requires 8 bits for a binding / queue ID (8 NICs *
32 queues == 256 queues total == 2^8), which leaves only 24 bits for
dmabuf pages (2^24 * 4096 / (1<<30) == 64GB). This is insufficient for
the device and queue numbers on many current systems or systems that may
need larger GPU dmabufs (as for hard limits, my current H100 has 80GB
GPU memory per device).

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

This patch adds an atomic to net_iov to count the number of outstanding
user references (uref) and tracks them via binding->vec. The
pp_ref_count is only incremented / decremented when uref goes from zero
to one or from one to zero, to avoid adding more atomic overhead. If a
user fails to refill and closes before returning all tokens, the binding
will finish the uref release when unbound. pp_ref_count cannot be used
directly because when the binding performs cleanup it does not know how
many pp_ref_count references are due to socket users.

[1]: https://github.com/facebookexperimental/kperf

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v3:
- make urefs per-binding instead of per-socket, reducing memory
  footprint
- fallback to cleaning up references in dmabuf unbind if socket leaked
  tokens
- drop ethtool patch

Changes in v2:
- always use GFP_ZERO for binding->vec (Mina)
- remove WARN for changed binding (Mina)
- remove extraneous binding ref get (Mina)
- remove WARNs on invalid user input (Mina)
- pre-assign niovs in binding->vec for RX case (Mina)
- use atomic_set(, 0) to initialize sk_user_frags.urefs
- fix length of alloc for urefs
---
 include/net/netmem.h     |  1 +
 include/net/sock.h       |  4 +--
 net/core/devmem.c        | 34 ++++++++++++------
 net/core/devmem.h        |  2 +-
 net/core/sock.c          | 34 ++++++++++++------
 net/ipv4/tcp.c           | 94 +++++++++++-------------------------------------
 net/ipv4/tcp_ipv4.c      | 18 ++--------
 net/ipv4/tcp_minisocks.c |  2 +-
 8 files changed, 75 insertions(+), 114 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index f7dacc9e75fd..be6bc69c2f5a 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -116,6 +116,7 @@ struct net_iov {
 	};
 	struct net_iov_area *owner;
 	enum net_iov_type type;
+	atomic_t uref;
 };
 
 struct net_iov_area {
diff --git a/include/net/sock.h b/include/net/sock.h
index 8c5b64f41ab7..5dfeac963e66 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -347,7 +347,7 @@ struct sk_filter;
   *	@sk_scm_rights: flagged by SO_PASSRIGHTS to recv SCM_RIGHTS
   *	@sk_scm_unused: unused flags for scm_recv()
   *	@ns_tracker: tracker for netns reference
-  *	@sk_user_frags: xarray of pages the user is holding a reference on.
+  *	@sk_devmem_binding: the devmem binding used by the socket
   *	@sk_owner: reference to the real owner of the socket that calls
   *		   sock_lock_init_class_and_name().
   */
@@ -574,7 +574,7 @@ struct sock {
 	struct numa_drop_counters *sk_drop_counters;
 	struct rcu_head		sk_rcu;
 	netns_tracker		ns_tracker;
-	struct xarray		sk_user_frags;
+	struct net_devmem_dmabuf_binding	*sk_devmem_binding;
 
 #if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
 	struct module		*sk_owner;
diff --git a/net/core/devmem.c b/net/core/devmem.c
index b4c570d4f37a..865d8dee539f 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -11,6 +11,7 @@
 #include <linux/genalloc.h>
 #include <linux/mm.h>
 #include <linux/netdevice.h>
+#include <linux/skbuff_ref.h>
 #include <linux/types.h>
 #include <net/netdev_queues.h>
 #include <net/netdev_rx_queue.h>
@@ -120,6 +121,7 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 	struct netdev_rx_queue *rxq;
 	unsigned long xa_idx;
 	unsigned int rxq_idx;
+	int i;
 
 	xa_erase(&net_devmem_dmabuf_bindings, binding->id);
 
@@ -142,6 +144,20 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 		__net_mp_close_rxq(binding->dev, rxq_idx, &mp_params);
 	}
 
+	for (i = 0; i < binding->dmabuf->size / PAGE_SIZE; i++) {
+		struct net_iov *niov;
+		netmem_ref netmem;
+
+		niov = binding->vec[i];
+
+		if (!net_is_devmem_iov(niov))
+			continue;
+
+		netmem = net_iov_to_netmem(niov);
+		while (atomic_dec_and_test(&niov->uref))
+			WARN_ON_ONCE(!napi_pp_put_page(netmem));
+	}
+
 	net_devmem_dmabuf_binding_put(binding);
 }
 
@@ -230,14 +246,12 @@ net_devmem_bind_dmabuf(struct net_device *dev,
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
@@ -291,10 +305,10 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 			niov = &owner->area.niovs[i];
 			niov->type = NET_IOV_DMABUF;
 			niov->owner = &owner->area;
+			atomic_set(&niov->uref, 0);
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
index dc03d4b5909a..4ee10b4d1254 100644
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
@@ -1082,6 +1084,7 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
 	struct dmabuf_token *tokens;
 	int ret = 0, num_frags = 0;
 	netmem_ref netmems[16];
+	struct net_iov *niov;
 
 	if (!sk_is_tcp(sk))
 		return -EBADF;
@@ -1100,34 +1103,43 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
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
+			if (token >= sk->sk_devmem_binding->dmabuf->size / PAGE_SIZE)
+				break;
+
 			if (++num_frags > MAX_DONTNEED_FRAGS)
 				goto frag_limit_reached;
-
-			netmem_ref netmem = (__force netmem_ref)__xa_erase(
-				&sk->sk_user_frags, tokens[i].token_start + j);
+			niov = sk->sk_devmem_binding->vec[token];
+			netmem = net_iov_to_netmem(niov);
 
 			if (!netmem || WARN_ON_ONCE(!netmem_is_net_iov(netmem)))
 				continue;
 
 			netmems[netmem_num++] = netmem;
 			if (netmem_num == ARRAY_SIZE(netmems)) {
-				xa_unlock_bh(&sk->sk_user_frags);
-				for (k = 0; k < netmem_num; k++)
-					WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
+				for (k = 0; k < netmem_num; k++) {
+					niov = netmem_to_net_iov(netmems[k]);
+					if (atomic_dec_and_test(&niov->uref))
+						WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
+				}
 				netmem_num = 0;
-				xa_lock_bh(&sk->sk_user_frags);
 			}
 			ret++;
 		}
 	}
 
 frag_limit_reached:
-	xa_unlock_bh(&sk->sk_user_frags);
-	for (k = 0; k < netmem_num; k++)
-		WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
+	for (k = 0; k < netmem_num; k++) {
+		niov = netmem_to_net_iov(netmems[k]);
+		if (atomic_dec_and_test(&niov->uref))
+			WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
+	}
 
 	kvfree(tokens);
 	return ret;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 7949d16506a4..700e5c32ed84 100644
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
@@ -494,7 +495,7 @@ void tcp_init_sock(struct sock *sk)
 
 	set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
 	sk_sockets_allocated_inc(sk);
-	xa_init_flags(&sk->sk_user_frags, XA_FLAGS_ALLOC1);
+	sk->sk_devmem_binding = NULL;
 }
 EXPORT_IPV6_MOD(tcp_init_sock);
 
@@ -2406,68 +2407,6 @@ static int tcp_inq_hint(struct sock *sk)
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
@@ -2476,14 +2415,11 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
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
 
@@ -2530,8 +2466,12 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 		 */
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+			struct net_devmem_dmabuf_binding *binding;
 			struct net_iov *niov;
 			u64 frag_offset;
+			size_t size;
+			size_t len;
+			u32 token;
 			int end;
 
 			/* !skb_frags_readable() should indicate that ALL the
@@ -2564,13 +2504,21 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 					      start;
 				dmabuf_cmsg.frag_offset = frag_offset;
 				dmabuf_cmsg.frag_size = copy;
-				err = tcp_xa_pool_refill(sk, &tcp_xa_pool,
-							 skb_shinfo(skb)->nr_frags - i);
-				if (err)
+
+				binding = net_devmem_iov_binding(niov);
+
+				if (!sk->sk_devmem_binding)
+					sk->sk_devmem_binding = binding;
+
+				if (sk->sk_devmem_binding != binding) {
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
@@ -2583,8 +2531,8 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 				if (err)
 					goto out;
 
-				atomic_long_inc(&niov->pp_ref_count);
-				tcp_xa_pool.netmems[tcp_xa_pool.idx++] = skb_frag_netmem(frag);
+				if (atomic_inc_return(&niov->uref) == 1)
+					atomic_long_inc(&niov->pp_ref_count);
 
 				sent += copy;
 
@@ -2594,7 +2542,6 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 			start = end;
 		}
 
-		tcp_xa_pool_commit(sk, &tcp_xa_pool);
 		if (!remaining_len)
 			goto out;
 
@@ -2612,7 +2559,6 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 	}
 
 out:
-	tcp_xa_pool_commit(sk, &tcp_xa_pool);
 	if (!sent)
 		sent = err;
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index b1fcf3e4e1ce..a73424b88531 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -89,6 +89,9 @@
 #include <crypto/hash.h>
 #include <linux/scatterlist.h>
 
+#include <linux/dma-buf.h>
+#include "../core/devmem.h"
+
 #include <trace/events/tcp.h>
 
 #ifdef CONFIG_TCP_MD5SIG
@@ -2536,25 +2539,10 @@ static int tcp_v4_init_sock(struct sock *sk)
 	return 0;
 }
 
-static void tcp_release_user_frags(struct sock *sk)
-{
-#ifdef CONFIG_PAGE_POOL
-	unsigned long index;
-	void *netmem;
-
-	xa_for_each(&sk->sk_user_frags, index, netmem)
-		WARN_ON_ONCE(!napi_pp_put_page((__force netmem_ref)netmem));
-#endif
-}
-
 void tcp_v4_destroy_sock(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
-	tcp_release_user_frags(sk);
-
-	xa_destroy(&sk->sk_user_frags);
-
 	trace_tcp_destroy_sock(sk);
 
 	tcp_clear_xmit_timers(sk);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 2ec8c6f1cdcc..e006a3021db9 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -665,7 +665,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 
 	__TCP_INC_STATS(sock_net(sk), TCP_MIB_PASSIVEOPENS);
 
-	xa_init_flags(&newsk->sk_user_frags, XA_FLAGS_ALLOC1);
+	newsk->sk_devmem_binding = NULL;
 
 	return newsk;
 }

-- 
2.47.3


