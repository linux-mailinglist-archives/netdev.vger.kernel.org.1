Return-Path: <netdev+bounces-226708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C41ABA4565
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 17:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10BD717D236
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 15:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D51214A64;
	Fri, 26 Sep 2025 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1pAtvRL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1011FBE87
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 15:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758898983; cv=none; b=Jame3JF/Y7UUoyNykJaIpz1ALUaekXv/5sgkp4LIgbiB7V4BBPc04ZgbpDtX8+/5+plpwk5BvZcVTRiQO1KeZg35GRrT8/YbeLS3lKlxRa6K9YC+Sls/RwaHP6zuUeAX7TnT+OvEn5DTjo/HughYTfE6mCJ9lejSPbT2wkioJOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758898983; c=relaxed/simple;
	bh=6/uR3WEy+jnB3S0iD+gtnGVpojDLROYCEct8n2VUiP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oJihVAhM5sLb1xUu+VuDFUZJYOHcDsmDF/FWIEmPTb/soQTtTYt/gHlzrHXzDzATCT1xv/CUR/0UE/wpvvGlmOVp/Cbcb2LsENvOm8+liGPcXu2B91kruUzXanhF3uc+LP1+SMUwSowjZIk7tOSI+c3/euQyCeuXNEudd+QFzzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1pAtvRL; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d603a269cso21800497b3.1
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 08:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758898980; x=1759503780; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2gbkDr3WiAXPeKPcYqAsq8bhq6pe+Lv1O12W/lPTimk=;
        b=T1pAtvRLTAH6s6SstnEcYjH3EErAYyks/jjz1Laa+bQechxr7opHoQA7Miga9O7LgX
         IW7QGp4mPNJpYcyEYO5K/wLCyGtsyLlFPOQctjLSMUHLKLo/qugTvUh8RHENINkixDk8
         ua914jkce763PSl8cPS+Y3A82xE7r4TKiiSgQ43zGkgL1amxJ2QmThFCAkQZD/Hni5S0
         wTEYDwMX4WD4FZx3B+xzHuX35Cw1cfe5d6s3wgRxQhg/2HdAd5Pla8X6bl5zwooWt+pR
         +qmPh2x1rZrenSUTDvuUGs0PpHKWAW4pIK7qYbpTHFEKwUToypeE6/M0L2ARr2vu/864
         GK6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758898980; x=1759503780;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2gbkDr3WiAXPeKPcYqAsq8bhq6pe+Lv1O12W/lPTimk=;
        b=ndmpi4yhCZ8Np//kTu73fFDIo+oIdGw+A0vFXfHVIjT5h8AvEHql3+X+OYVuZv9T/a
         02qVhptK0IME3/3kypyvIqInXMGv1C2MWB4iRr49J34UL25qjIrRVrV15ENfg2Pd+9Xf
         Cn0jDBU2pdpHY86F8Re0Vdb2kxbpOJ7a/1C50SZBm4Lcza6B1iDmX8ihdiHFILld/KOG
         y1BjfiiIcpUz9B8NsKjElxB0D61w4MvGPNl2DcVaFRummEaH7w80fsFTzJM5SZoW7HxY
         ZV9uwdCdElx/mlbtSQto5DsfpEn46Il0TgZna4CNp6ZB32TVeWa2PLzWLkePQxCdStHm
         XJcA==
X-Gm-Message-State: AOJu0YzseSX1GCZvRQR9b//dTM+s5bburvIZxYk0HmlbtL/XJeb9bVZT
	smFLdc4pBUiYMv3ub3fiywTgwgh7J6d2ZyOzvv4QeEMxUeWE8idKfdHv
X-Gm-Gg: ASbGnct8s6TnCOrWxlLPzGjdAYmz1Z8inCRSYE/K29smrKhzkfPGlE5eVrMrDYR2/fG
	ZzKtRSBdlEFbcJ5ALRTWi86Ss2jmt2lrwDhyD2TCmYerVFIgXCgsuKSu+9+Olz6bx5WaOTSf6uL
	/+RBcoiG2O9LyrdsMLMFBbpJX+rSZ+oJ8CDu5flqSr+TAAeLpgpyZooT8RV0DRyza37u8j2o+MY
	4kJkYruuuPVNEgRfRa3GbNuTckQbl+OjMLj/l5cgCb2eYmZNnxeCwMDv14YHaIWaHAhHwN0aJnL
	GDr5qnE7o/5Zh15+sdEDF+I5KHt2j3KuiqzXpG0hKzrIVaVDIRRuzoYwkEu4jMXQRra7PX7/KLZ
	vpvlr30M09eqqBluLcFsNrSfKjUlxQI3g
X-Google-Smtp-Source: AGHT+IEQUonaybOUDkaT888XsdJ/MQ9QTAzvbRfmoZqDcoNZRoPArcbQcwhudig+gMTdt0QAKHEIUA==
X-Received: by 2002:a05:690c:9c0d:b0:734:81fb:8ba0 with SMTP id 00721157ae682-763fb38cd62mr79991167b3.19.1758898979700;
        Fri, 26 Sep 2025 08:02:59 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:41::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-765bd127c3fsm11472217b3.20.2025.09.26.08.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 08:02:58 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 26 Sep 2025 08:02:54 -0700
Subject: [PATCH net-next v3 2/2] net: devmem: use niov array for token
 management
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-scratch-bobbyeshleman-devmem-tcp-token-upstream-v3-2-084b46bda88f@meta.com>
References: <20250926-scratch-bobbyeshleman-devmem-tcp-token-upstream-v3-0-084b46bda88f@meta.com>
In-Reply-To: <20250926-scratch-bobbyeshleman-devmem-tcp-token-upstream-v3-0-084b46bda88f@meta.com>
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
directly becuase when the binding performs cleanup it does not know how
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
 net/core/sock.c          | 38 ++++++++++++++------
 net/ipv4/tcp.c           | 94 +++++++++++-------------------------------------
 net/ipv4/tcp_ipv4.c      | 18 ++--------
 net/ipv4/tcp_minisocks.c |  2 --
 8 files changed, 78 insertions(+), 115 deletions(-)

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
index 1e7f124871d2..e51ae567c121 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -350,7 +350,7 @@ struct sk_filter;
   *	@sk_scm_rights: flagged by SO_PASSRIGHTS to recv SCM_RIGHTS
   *	@sk_scm_unused: unused flags for scm_recv()
   *	@ns_tracker: tracker for netns reference
-  *	@sk_user_frags: xarray of pages the user is holding a reference on.
+  *	@sk_devmem_binding: the devmem binding used by the socket
   *	@sk_owner: reference to the real owner of the socket that calls
   *		   sock_lock_init_class_and_name().
   */
@@ -573,7 +573,7 @@ struct sock {
 #endif
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
index 9a8290fcc35d..08d865ba04ea 100644
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
@@ -1100,34 +1103,47 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
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
 
+			if (atomic_dec_if_positive(&sk->sk_user_frags.urefs[token])
+						< 0)
+				continue;
+
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
index 40b774b4f587..813d73f23c87 100644
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
@@ -475,7 +476,7 @@ void tcp_init_sock(struct sock *sk)
 
 	set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
 	sk_sockets_allocated_inc(sk);
-	xa_init_flags(&sk->sk_user_frags, XA_FLAGS_ALLOC1);
+	sk->sk_devmem_binding = NULL;
 }
 EXPORT_IPV6_MOD(tcp_init_sock);
 
@@ -2386,68 +2387,6 @@ static int tcp_inq_hint(struct sock *sk)
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
@@ -2456,14 +2395,11 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
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
 
@@ -2510,8 +2446,12 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
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
@@ -2544,13 +2484,21 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
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
@@ -2563,8 +2511,8 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 				if (err)
 					goto out;
 
-				atomic_long_inc(&niov->pp_ref_count);
-				tcp_xa_pool.netmems[tcp_xa_pool.idx++] = skb_frag_netmem(frag);
+				if (atomic_inc_return(&niov->uref) == 1)
+					atomic_long_inc(&niov->pp_ref_count);
 
 				sent += copy;
 
@@ -2574,7 +2522,6 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 			start = end;
 		}
 
-		tcp_xa_pool_commit(sk, &tcp_xa_pool);
 		if (!remaining_len)
 			goto out;
 
@@ -2592,7 +2539,6 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 	}
 
 out:
-	tcp_xa_pool_commit(sk, &tcp_xa_pool);
 	if (!sent)
 		sent = err;
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 1e58a8a9ff7a..0afa5461de33 100644
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
@@ -2526,25 +2529,10 @@ static void tcp_md5sig_info_free_rcu(struct rcu_head *head)
 }
 #endif
 
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


