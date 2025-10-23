Return-Path: <netdev+bounces-232263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26897C037AF
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 23:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D68EF189352B
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 21:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843142D63F8;
	Thu, 23 Oct 2025 21:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aX+XiYa/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0DF2C0282
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 21:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761253238; cv=none; b=nPOYgbgueE4btTKwl/lEi9FNHqzGmyz1IqMxThORTuhT5agzH/xmF7LJvUYrScjQPiTQyC6vLMw8WYrViWTUGxPBrzDVle7xHILjC/5GLs1sdasSZ9p2/mQ2rsZnMbnU7EJP3dmM6Tmn4PsFT7nx61T4Xw8qMDRRBf9Si46HVkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761253238; c=relaxed/simple;
	bh=tiGZrIhQN7al1AkXsnsWbyfuAS+K9g0Elp5nN1f1Zzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KrRGBRGV9kUPd+RBmBr9HBB0gADOi9udSy25FmPoArsnQbjFfdFeqsQ7UBwzSsiuRWsxP0PvMdCgK6BaMd7314FHn3jb4JhcTGYOUgGHzdE39GdNLGmJ/HRFEnO5bfD+HO6YB8WCnCvW2o3dGbciug8CTaEdJdrJYwIh/I9t/wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aX+XiYa/; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-63e0dd765a0so1337932d50.3
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 14:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761253234; x=1761858034; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wfeloB3By7XpEZq45XGU8DD3RfucB12MG9BXvik3Dno=;
        b=aX+XiYa/ESIRN/H0J3BM1pFUzv+RNsK5umHwHLNyB2drhyemIsPcgGKoJyF0KEsYNs
         1rZvYZ/GZ4m2T7UPJ618cj00tJDWbNVBUpjYEVDJW7kySOKgEBtp1Ga7MAKihhvr5Fvw
         dS/bNfYjhHz85hnHjL5Oq0BjGzHoqzLymTq8m63fdad2StIx2LZHUkAzztjjh/UvfnkM
         /D2emrtZgeFe04to9Ksk9xfe3NxH/8UVqEoMjwWcDFy7jQBvuhSELKegnuh6qa0qhKWb
         oLUstgyJ64eTLxfbgQb4qTQgQ+E7XgRIxCoCvjN5EwR3FYD6p4pOq71YrFY5Jd54fYMY
         Y/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761253234; x=1761858034;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfeloB3By7XpEZq45XGU8DD3RfucB12MG9BXvik3Dno=;
        b=p9kfwSz4DpzaxSUFPqfa65addUic5UJOljqWxWQ8Dy/hMUrizEycWSuqwIw/YM5wi2
         /RHsDCY1o82GO9k37lXYs26L0+wxKbfd9yzX9lmWqs78S5bG+CbDtJIcNfGXvk2Poi9O
         eivIZdhJt/RtigC2ccNm11yITDuNdeG43H/+1nfdFiYXP9PfilsSVC25yBf2ao2uLh7b
         0XB338REN7Ia8KsVzqubRgCsh7aeOM+F/iqNr3jyGx3xqFYjNjlC5AbeBBitvk4Uuviy
         ElHphCMq2oR5tM4wqmGycNu+7wCBBsadcs1xqrUFWO3NDhATf+QOmfwVogWgykSgZIbu
         aHsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbxbRp39s8hirnyxDKYI44ISRhzR6psM2HxYcZo/AFs5SrzFwi0n4hWR/mxqrwv+W8HDye+Jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTK+nNapNVrSqOn7bDCuD0qPd7qQZTZ+LDYE3q4OtGTQyz+Bzq
	4RPbGiwOOjSmmVuHL1tstC0ExzjFj+twCN5UjLAWK4Nx7UE741icKofN
X-Gm-Gg: ASbGnctxlutA8CIoS7kDdhWvzrLtwa/QTwVtCwcHmhETj0DcjDREAkuiCL9FYES6Pz6
	tvvrZsEpzQkR5Lxgy9Uv7NhyIHGCWRZ77F1C7IN/lwQcqRuf5xORINTAt1vf+WNi0Om18vBbZ4v
	YWxscbxPTbbEtyMEN+efWh0gtAEW0I3mwxtcw1g0pKQ1LTnelftxuamc2KW62Frc+5ORiSY8r+S
	CKGUK5RX47kw8XlApQ8VxkQUPa2acpx1cvyGzr4gyhalgH5AwSpTUtY4giLj19I485u56MbJrZJ
	IZ6SNdHpoMduRM/usmDedzj+l2SIjwJhWJqlkRim9+escOR/hmx3KsL6hm4GikAJThyK5E/mneL
	t5sFUOu4CGAhxTUcf8uoKg+DgZeuwbYAE5DoG9GsToxBHwSShn7JDzUBL78AueoiaAI8OD5G0LB
	pMRjc0eO8Ag8zgIdpUkvkTaA==
X-Google-Smtp-Source: AGHT+IF2I0Van4Uv+serwEhwXlardkuhRZ5/eOKfgS426oDpqB9zEhrBv9MG+NXxfoFgWnMAxgJiAw==
X-Received: by 2002:a05:690c:4b13:b0:783:7266:58ee with SMTP id 00721157ae682-78372666210mr411883857b3.7.1761253233877;
        Thu, 23 Oct 2025 14:00:33 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:73::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-63f37a06e8dsm965631d50.14.2025.10.23.14.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 14:00:33 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 23 Oct 2025 13:58:22 -0700
Subject: [PATCH net-next v5 3/4] net: devmem: use niov array for token
 management
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-3-47cb85f5259e@meta.com>
References: <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-0-47cb85f5259e@meta.com>
In-Reply-To: <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-0-47cb85f5259e@meta.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, Neal Cardwell <ncardwell@google.com>, 
 David Ahern <dsahern@kernel.org>, Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Replace xarray-based token lookups with direct array access using page
offsets as dmabuf tokens. When enabled, this eliminates xarray overhead
and reduces CPU utilization in devmem RX threads by approximately 13%.

This patch changes the meaning of tokens. Tokens previously referred to
unique fragments of pages. In this patch tokens instead represent
references to pages, not fragments. Because of this, multiple tokens may
refer to the same page and so have identical value (e.g., two small
fragments may coexist on the same page). The token and offset pair that
the user receives uniquely identifies fragments if needed.  This assumes
that the user is not attempting to sort / uniq the token list using
tokens alone.

This introduces a restriction: devmem RX sockets cannot switch dmabuf
bindings. This is necessary because 32-bit tokens lack sufficient bits
to encode both large dmabuf page counts and binding/queue IDs. For
example, a system with 8 NICs and 32 queues needs 8 bits for binding
IDs, leaving only 24 bits for pages (64GB max). This restriction aligns
with common usage, as steering flows to different queues/devices is
often undesirable for TCP.

This patch adds an atomic uref counter to net_iov for tracking user
references via binding->vec. The pp_ref_count is only updated on uref
transitions from zero to one or from one to zero, to minimize atomic
overhead. If a user fails to refill and closes before returning all
tokens, the binding will finish the uref release when unbound.

A flag "autorelease" is added. This will be used for enabling the old
behavior of the kernel releasing references for the sockets upon
close(2) (autorelease), instead of requiring that socket users do this
themselves. The autorelease flag is always true in this patch, meaning
that the old (non-optimized) behavior is kept unconditionally. A future
patch supports a user-facing knob to toggle this feature and will change
the default to false for the improved performance.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v5:
- remove unused variables
- introduce autorelease flag, preparing for future patch toggle new
  behavior

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
 include/net/sock.h       |  8 ++++--
 net/core/devmem.c        | 45 ++++++++++++++++++++++-------
 net/core/devmem.h        | 11 ++++++-
 net/core/sock.c          | 75 ++++++++++++++++++++++++++++++++++++++++++++----
 net/ipv4/tcp.c           | 69 +++++++++++++++++++++++++++++++++-----------
 net/ipv4/tcp_ipv4.c      | 12 ++++++--
 net/ipv4/tcp_minisocks.c |  3 +-
 8 files changed, 185 insertions(+), 39 deletions(-)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 651e2c62d1dd..de39afaede8d 100644
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
index 01ce231603db..1963ab54c465 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -350,7 +350,7 @@ struct sk_filter;
   *	@sk_scm_rights: flagged by SO_PASSRIGHTS to recv SCM_RIGHTS
   *	@sk_scm_unused: unused flags for scm_recv()
   *	@ns_tracker: tracker for netns reference
-  *	@sk_user_frags: xarray of pages the user is holding a reference on.
+  *	@sk_devmem_info: the devmem binding information for the socket
   *	@sk_owner: reference to the real owner of the socket that calls
   *		   sock_lock_init_class_and_name().
   */
@@ -579,7 +579,11 @@ struct sock {
 	struct numa_drop_counters *sk_drop_counters;
 	struct rcu_head		sk_rcu;
 	netns_tracker		ns_tracker;
-	struct xarray		sk_user_frags;
+	struct {
+		struct xarray				frags;
+		struct net_devmem_dmabuf_binding	*binding;
+		bool					autorelease;
+	} sk_devmem_info;
 
 #if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
 	struct module		*sk_owner;
diff --git a/net/core/devmem.c b/net/core/devmem.c
index b4c570d4f37a..8f3199fe0f7b 100644
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
@@ -115,6 +116,29 @@ void net_devmem_free_dmabuf(struct net_iov *niov)
 	gen_pool_free(binding->chunk_pool, dma_addr, PAGE_SIZE);
 }
 
+static void
+net_devmem_dmabuf_binding_put_urefs(struct net_devmem_dmabuf_binding *binding)
+{
+	int i;
+
+	if (binding->autorelease)
+		return;
+
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
+		if (atomic_xchg(&niov->uref, 0) > 0)
+			WARN_ON_ONCE(!napi_pp_put_page(netmem));
+	}
+}
+
 void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 {
 	struct netdev_rx_queue *rxq;
@@ -142,6 +166,7 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
 		__net_mp_close_rxq(binding->dev, rxq_idx, &mp_params);
 	}
 
+	net_devmem_dmabuf_binding_put_urefs(binding);
 	net_devmem_dmabuf_binding_put(binding);
 }
 
@@ -230,14 +255,13 @@ net_devmem_bind_dmabuf(struct net_device *dev,
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
+	/* used by tx and also rx if !binding->autorelease */
+	binding->vec = kvmalloc_array(dmabuf->size / PAGE_SIZE,
+				      sizeof(struct net_iov *),
+				      GFP_KERNEL | __GFP_ZERO);
+	if (!binding->vec) {
+		err = -ENOMEM;
+		goto err_unmap;
 	}
 
 	/* For simplicity we expect to make PAGE_SIZE allocations, but the
@@ -291,10 +315,10 @@ net_devmem_bind_dmabuf(struct net_device *dev,
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
@@ -307,6 +331,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
 		goto err_free_chunks;
 
 	list_add(&binding->list, &priv->bindings);
+	binding->autorelease = true;
 
 	return binding;
 
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 2ada54fb63d7..7662e9e42c35 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -61,11 +61,20 @@ struct net_devmem_dmabuf_binding {
 
 	/* Array of net_iov pointers for this binding, sorted by virtual
 	 * address. This array is convenient to map the virtual addresses to
-	 * net_iovs in the TX path.
+	 * net_iovs.
 	 */
 	struct net_iov **vec;
 
 	struct work_struct unbind_w;
+
+	/* If true, outstanding tokens will be automatically released upon each
+	 * socket's close(2).
+	 *
+	 * If false, then sockets are responsible for releasing tokens before
+	 * close(2). The kernel will only release lingering tokens when the
+	 * dmabuf is unbound.
+	 */
+	bool autorelease;
 };
 
 #if defined(CONFIG_NET_DEVMEM)
diff --git a/net/core/sock.c b/net/core/sock.c
index e7b378753763..595b5a858d03 100644
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
@@ -1081,6 +1083,57 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
 #define MAX_DONTNEED_TOKENS 128
 #define MAX_DONTNEED_FRAGS 1024
 
+static noinline_for_stack int
+sock_devmem_dontneed_manual_release(struct sock *sk, struct dmabuf_token *tokens,
+				    unsigned int num_tokens)
+{
+	unsigned int netmem_num = 0;
+	int ret = 0, num_frags = 0;
+	netmem_ref netmems[16];
+	struct net_iov *niov;
+	unsigned int i, j, k;
+
+	for (i = 0; i < num_tokens; i++) {
+		for (j = 0; j < tokens[i].token_count; j++) {
+			struct net_iov *niov;
+			unsigned int token;
+			netmem_ref netmem;
+
+			token = tokens[i].token_start + j;
+			if (token >= sk->sk_devmem_info.binding->dmabuf->size / PAGE_SIZE)
+				break;
+
+			if (++num_frags > MAX_DONTNEED_FRAGS)
+				goto frag_limit_reached;
+			niov = sk->sk_devmem_info.binding->vec[token];
+			netmem = net_iov_to_netmem(niov);
+
+			if (!netmem || WARN_ON_ONCE(!netmem_is_net_iov(netmem)))
+				continue;
+
+			netmems[netmem_num++] = netmem;
+			if (netmem_num == ARRAY_SIZE(netmems)) {
+				for (k = 0; k < netmem_num; k++) {
+					niov = netmem_to_net_iov(netmems[k]);
+					if (atomic_dec_and_test(&niov->uref))
+						WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
+				}
+				netmem_num = 0;
+			}
+			ret++;
+		}
+	}
+
+frag_limit_reached:
+	for (k = 0; k < netmem_num; k++) {
+		niov = netmem_to_net_iov(netmems[k]);
+		if (atomic_dec_and_test(&niov->uref))
+			WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
+	}
+
+	return ret;
+}
+
 static noinline_for_stack int
 sock_devmem_dontneed_autorelease(struct sock *sk, struct dmabuf_token *tokens,
 				 unsigned int num_tokens)
@@ -1089,32 +1142,32 @@ sock_devmem_dontneed_autorelease(struct sock *sk, struct dmabuf_token *tokens,
 	int ret = 0, num_frags = 0;
 	netmem_ref netmems[16];
 
-	xa_lock_bh(&sk->sk_user_frags);
+	xa_lock_bh(&sk->sk_devmem_info.frags);
 	for (i = 0; i < num_tokens; i++) {
 		for (j = 0; j < tokens[i].token_count; j++) {
 			if (++num_frags > MAX_DONTNEED_FRAGS)
 				goto frag_limit_reached;
 
 			netmem_ref netmem = (__force netmem_ref)__xa_erase(
-				&sk->sk_user_frags, tokens[i].token_start + j);
+				&sk->sk_devmem_info.frags, tokens[i].token_start + j);
 
 			if (!netmem || WARN_ON_ONCE(!netmem_is_net_iov(netmem)))
 				continue;
 
 			netmems[netmem_num++] = netmem;
 			if (netmem_num == ARRAY_SIZE(netmems)) {
-				xa_unlock_bh(&sk->sk_user_frags);
+				xa_unlock_bh(&sk->sk_devmem_info.frags);
 				for (k = 0; k < netmem_num; k++)
 					WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
 				netmem_num = 0;
-				xa_lock_bh(&sk->sk_user_frags);
+				xa_lock_bh(&sk->sk_devmem_info.frags);
 			}
 			ret++;
 		}
 	}
 
 frag_limit_reached:
-	xa_unlock_bh(&sk->sk_user_frags);
+	xa_unlock_bh(&sk->sk_devmem_info.frags);
 	for (k = 0; k < netmem_num; k++)
 		WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
 
@@ -1135,6 +1188,12 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
 	    optlen > sizeof(*tokens) * MAX_DONTNEED_TOKENS)
 		return -EINVAL;
 
+	/* recvmsg() has never returned a token for this socket, which needs to
+	 * happen before we know if the dmabuf has autorelease set or not.
+	 */
+	if (!sk->sk_devmem_info.binding)
+		return -EINVAL;
+
 	num_tokens = optlen / sizeof(*tokens);
 	tokens = kvmalloc_array(num_tokens, sizeof(*tokens), GFP_KERNEL);
 	if (!tokens)
@@ -1145,7 +1204,11 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
 		return -EFAULT;
 	}
 
-	ret = sock_devmem_dontneed_autorelease(sk, tokens, num_tokens);
+	if (sk->sk_devmem_info.autorelease)
+		ret = sock_devmem_dontneed_autorelease(sk, tokens, num_tokens);
+	else
+		ret = sock_devmem_dontneed_manual_release(sk, tokens,
+							  num_tokens);
 
 	kvfree(tokens);
 	return ret;
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e15b38f6bd2d..cfa77c852e64 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -260,6 +260,7 @@
 #include <linux/memblock.h>
 #include <linux/highmem.h>
 #include <linux/cache.h>
+#include <linux/dma-buf.h>
 #include <linux/err.h>
 #include <linux/time.h>
 #include <linux/slab.h>
@@ -492,7 +493,9 @@ void tcp_init_sock(struct sock *sk)
 
 	set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
 	sk_sockets_allocated_inc(sk);
-	xa_init_flags(&sk->sk_user_frags, XA_FLAGS_ALLOC1);
+	xa_init_flags(&sk->sk_devmem_info.frags, XA_FLAGS_ALLOC1);
+	sk->sk_devmem_info.binding = NULL;
+	sk->sk_devmem_info.autorelease = false;
 }
 EXPORT_IPV6_MOD(tcp_init_sock);
 
@@ -2422,11 +2425,11 @@ static void tcp_xa_pool_commit_locked(struct sock *sk, struct tcp_xa_pool *p)
 
 	/* Commit part that has been copied to user space. */
 	for (i = 0; i < p->idx; i++)
-		__xa_cmpxchg(&sk->sk_user_frags, p->tokens[i], XA_ZERO_ENTRY,
+		__xa_cmpxchg(&sk->sk_devmem_info.frags, p->tokens[i], XA_ZERO_ENTRY,
 			     (__force void *)p->netmems[i], GFP_KERNEL);
 	/* Rollback what has been pre-allocated and is no longer needed. */
 	for (; i < p->max; i++)
-		__xa_erase(&sk->sk_user_frags, p->tokens[i]);
+		__xa_erase(&sk->sk_devmem_info.frags, p->tokens[i]);
 
 	p->max = 0;
 	p->idx = 0;
@@ -2437,11 +2440,11 @@ static void tcp_xa_pool_commit(struct sock *sk, struct tcp_xa_pool *p)
 	if (!p->max)
 		return;
 
-	xa_lock_bh(&sk->sk_user_frags);
+	xa_lock_bh(&sk->sk_devmem_info.frags);
 
 	tcp_xa_pool_commit_locked(sk, p);
 
-	xa_unlock_bh(&sk->sk_user_frags);
+	xa_unlock_bh(&sk->sk_devmem_info.frags);
 }
 
 static int tcp_xa_pool_refill(struct sock *sk, struct tcp_xa_pool *p,
@@ -2452,18 +2455,18 @@ static int tcp_xa_pool_refill(struct sock *sk, struct tcp_xa_pool *p,
 	if (p->idx < p->max)
 		return 0;
 
-	xa_lock_bh(&sk->sk_user_frags);
+	xa_lock_bh(&sk->sk_devmem_info.frags);
 
 	tcp_xa_pool_commit_locked(sk, p);
 
 	for (k = 0; k < max_frags; k++) {
-		err = __xa_alloc(&sk->sk_user_frags, &p->tokens[k],
+		err = __xa_alloc(&sk->sk_devmem_info.frags, &p->tokens[k],
 				 XA_ZERO_ENTRY, xa_limit_31b, GFP_KERNEL);
 		if (err)
 			break;
 	}
 
-	xa_unlock_bh(&sk->sk_user_frags);
+	xa_unlock_bh(&sk->sk_devmem_info.frags);
 
 	p->max = k;
 	p->idx = 0;
@@ -2477,6 +2480,7 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 			      unsigned int offset, struct msghdr *msg,
 			      int remaining_len)
 {
+	struct net_devmem_dmabuf_binding *binding = NULL;
 	struct dmabuf_cmsg dmabuf_cmsg = { 0 };
 	struct tcp_xa_pool tcp_xa_pool;
 	unsigned int start;
@@ -2534,6 +2538,7 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
 			struct net_iov *niov;
 			u64 frag_offset;
+			u32 token;
 			int end;
 
 			/* !skb_frags_readable() should indicate that ALL the
@@ -2566,13 +2571,35 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 					      start;
 				dmabuf_cmsg.frag_offset = frag_offset;
 				dmabuf_cmsg.frag_size = copy;
-				err = tcp_xa_pool_refill(sk, &tcp_xa_pool,
-							 skb_shinfo(skb)->nr_frags - i);
-				if (err)
+
+				binding = net_devmem_iov_binding(niov);
+
+				if (!sk->sk_devmem_info.binding) {
+					sk->sk_devmem_info.binding = binding;
+					sk->sk_devmem_info.autorelease =
+						binding->autorelease;
+				}
+
+				if (sk->sk_devmem_info.binding != binding) {
+					err = -EFAULT;
 					goto out;
+				}
+
+				if (binding->autorelease) {
+					err = tcp_xa_pool_refill(sk, &tcp_xa_pool,
+								 skb_shinfo(skb)->nr_frags - i);
+					if (err)
+						goto out;
+
+					dmabuf_cmsg.frag_token =
+						tcp_xa_pool.tokens[tcp_xa_pool.idx];
+				} else {
+					token = net_iov_virtual_addr(niov) >> PAGE_SHIFT;
+					dmabuf_cmsg.frag_token = token;
+				}
+
 
 				/* Will perform the exchange later */
-				dmabuf_cmsg.frag_token = tcp_xa_pool.tokens[tcp_xa_pool.idx];
 				dmabuf_cmsg.dmabuf_id = net_devmem_iov_binding_id(niov);
 
 				offset += copy;
@@ -2585,8 +2612,14 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 				if (err)
 					goto out;
 
-				atomic_long_inc(&niov->pp_ref_count);
-				tcp_xa_pool.netmems[tcp_xa_pool.idx++] = skb_frag_netmem(frag);
+				if (sk->sk_devmem_info.autorelease) {
+					atomic_long_inc(&niov->pp_ref_count);
+					tcp_xa_pool.netmems[tcp_xa_pool.idx++] =
+						skb_frag_netmem(frag);
+				} else {
+					if (atomic_inc_return(&niov->uref) == 1)
+						atomic_long_inc(&niov->pp_ref_count);
+				}
 
 				sent += copy;
 
@@ -2596,7 +2629,9 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 			start = end;
 		}
 
-		tcp_xa_pool_commit(sk, &tcp_xa_pool);
+		if (sk->sk_devmem_info.autorelease)
+			tcp_xa_pool_commit(sk, &tcp_xa_pool);
+
 		if (!remaining_len)
 			goto out;
 
@@ -2614,7 +2649,9 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
 	}
 
 out:
-	tcp_xa_pool_commit(sk, &tcp_xa_pool);
+	if (sk->sk_devmem_info.autorelease)
+		tcp_xa_pool_commit(sk, &tcp_xa_pool);
+
 	if (!sent)
 		sent = err;
 
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 40a76da5364a..feb15440cac4 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -89,6 +89,9 @@
 
 #include <crypto/md5.h>
 
+#include <linux/dma-buf.h>
+#include "../core/devmem.h"
+
 #include <trace/events/tcp.h>
 
 #ifdef CONFIG_TCP_MD5SIG
@@ -2493,7 +2496,7 @@ static void tcp_release_user_frags(struct sock *sk)
 	unsigned long index;
 	void *netmem;
 
-	xa_for_each(&sk->sk_user_frags, index, netmem)
+	xa_for_each(&sk->sk_devmem_info.frags, index, netmem)
 		WARN_ON_ONCE(!napi_pp_put_page((__force netmem_ref)netmem));
 #endif
 }
@@ -2502,9 +2505,12 @@ void tcp_v4_destroy_sock(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
-	tcp_release_user_frags(sk);
+	if (sk->sk_devmem_info.binding &&
+	    sk->sk_devmem_info.binding->autorelease)
+		tcp_release_user_frags(sk);
 
-	xa_destroy(&sk->sk_user_frags);
+	xa_destroy(&sk->sk_devmem_info.frags);
+	sk->sk_devmem_info.binding = NULL;
 
 	trace_tcp_destroy_sock(sk);
 
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index ded2cf1f6006..512a3dbb57a4 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -663,7 +663,8 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 
 	__TCP_INC_STATS(sock_net(sk), TCP_MIB_PASSIVEOPENS);
 
-	xa_init_flags(&newsk->sk_user_frags, XA_FLAGS_ALLOC1);
+	xa_init_flags(&newsk->sk_devmem_info.frags, XA_FLAGS_ALLOC1);
+	newsk->sk_devmem_info.binding = NULL;
 
 	return newsk;
 }

-- 
2.47.3


