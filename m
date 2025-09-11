Return-Path: <netdev+bounces-221929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1F9B525F8
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 03:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95DF21798F6
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 01:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A6E22DF9E;
	Thu, 11 Sep 2025 01:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0wRbOOA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0089122256B
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 01:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757555267; cv=none; b=iiks/WZSCIz7+1KSqSYyj9wxtvKs8esVODvOKJqH6FLmyfb7KdgKnbkilXNuGLevxF0SDMGppr9hOMYxfKg9RieoBuEjeiqYvrAa9ZhxbCkEVwtoX75IFdXCzbeMek6H1volmAJLlj9OUkCZ9s0/t2X9obdp5vrGWZ2aWH58HLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757555267; c=relaxed/simple;
	bh=tgzDj0vl1jz3M7DzzW1QWM6iNfyk0kgmchOlW29XDmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jON/Ff6Y8A4QMtxJWzxhYmz3X+LUXeM6IjYc0QL2AIliMlt3tqpc5UlBYE6PKi+UZdxQZFzHs7QRa4HFN4rXigKlCl1zPHW3nBm20+OcUKEHieqJjlvurRyxXl03oqp3hX8lKMss7jalPK22yDm/eOT6kF4gMNP7IYTcCcK54Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0wRbOOA; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e951dfcbc5bso125781276.3
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 18:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757555264; x=1758160064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRkmWJUMvQwzJDCSjY4HNiJ4qZzmbu/JmEWlKTTSCzY=;
        b=O0wRbOOASDqhCsUX8dIrVUNAymRrQcb1417NmUNDwBkEGjM6k3Grkn2taZ+AT1/iBD
         kMRzv4hPGyrHDsa0PljVlg26Lb+GmR93uYASRwdz/J+MiZi65W213yqUaali2ElJyD2P
         pk8l92Xj/+sB+6dyTQakqS31RlvV2qMAduANp4IPO11l+vlVEJuR/lzmBUPHKl7IK/fs
         oVRb1EOt862TkhpPEgG+rmLstFB2y5ZuFv+44MySeHN4/CgcZwtUsZMnpdbOhC3CAsX7
         1T6gLKRKVbdBeKL4P3x/xrekfWZx2RKiO/eZl1SXVapmJrYKfqg6+6+mR7K6K475xIrT
         orDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757555264; x=1758160064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRkmWJUMvQwzJDCSjY4HNiJ4qZzmbu/JmEWlKTTSCzY=;
        b=MwJl5gvTaKXG7ZkxQyBt/H//sQzhu7PbXS+6G/Hzwo+xEcCvbFxU/0Ji+Q2BtyJQUs
         lUtkNyTF/rNSfEt+RzReFUc9sjPR7+MUtj6SldQAueLsxC3OqXWy0xEB33JIn87hipGP
         LVBWHh4k/DuwiiRaRns8L3gQP4gALZO7+1zUJuepYuwWOmIc+IcToLDltKpejoZ2LIzK
         4XuZ/1b9IaRxiZCtOabos4mYyjo/8+HonOl2lh0r9VNyfjde2nWfjPxG6FQc1kcKmInK
         VsUQ80zXNT1EhAYsq+I84JrJr1pbcESMbrMjZnTpbVkxF5HZppvRGH3Mblg0fFkZ6+1o
         b3Xw==
X-Forwarded-Encrypted: i=1; AJvYcCVYit96lEBRqneIRkY6uPEeCqwOCncSgJorCL9RwAX/A/egchyuBw1P3PgXhwse0G8oz1P/PrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNfbXXQeygqNNI+JtvqyjDc6BcrVymMNg7QjXAsG0J2vgSswpR
	TiaRQiQx7wrfyfJjarl5AZUOzWrx5giUb+nGG730BMnRuqAPN+cKVOzX
X-Gm-Gg: ASbGnctj24sEKN68lfgHupHcmW5OzQLQtGXaI4Z5AUGTAdMfQm40nJ0/1O8wlWInKBh
	bUtTrm912mXfiPBIyyOEhOQ0Nb+VhnW1siSIjqK4nW/sIZP1WWg1wgSL4kxYlnsNBaHzMT1Ur1o
	8IMY1AC6w3cVlmAP9pYah6eB2AN2puFn2YoVergdyxwZ191h72+zhMqKR1TAmTANXuAq6C24596
	pHD7U963OU/WrnBqpBM+e6ETp6AakZWsMFpm3DQpDBLV2hsRrjmV3/sjiB6PiA4uryeTHxPXGKt
	9MeQVv6yGVRxx/EiQpfsv6kF8csoiJVpKNfoyI7oFuGyW9mQsyA5eRpwKRvtRLEJD6ryD7bj7te
	faeSsa9UllGYmhD3e3o6R53TXZm1UG5g=
X-Google-Smtp-Source: AGHT+IEsRikv2u+Qx5TBvfXQBQG1K4H5QjMLO3fFHrThooMA4WFnTnLB7fuxAXxbsPqX9VDL4FWitw==
X-Received: by 2002:a05:690e:434a:b0:604:3849:89cf with SMTP id 956f58d0204a3-610232fc78fmr10968069d50.11.1757555263639;
        Wed, 10 Sep 2025 18:47:43 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4e::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea3cf2656b1sm63859276.30.2025.09.10.18.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 18:47:42 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Raed Salem <raeds@nvidia.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Kiran Kella <kiran.kella@broadcom.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v11 04/19] tcp: add datapath logic for PSP with inline key exchange
Date: Wed, 10 Sep 2025 18:47:12 -0700
Message-ID: <20250911014735.118695-5-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250911014735.118695-1-daniel.zahka@gmail.com>
References: <20250911014735.118695-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Add validation points and state propagation to support PSP key
exchange inline, on TCP connections. The expectation is that
application will use some well established mechanism like TLS
handshake to establish a secure channel over the connection and
if both endpoints are PSP-capable - exchange and install PSP keys.
Because the connection can existing in PSP-unsecured and PSP-secured
state we need to make sure that there are no race conditions or
retransmission leaks.

On Tx - mark packets with the skb->decrypted bit when PSP key
is at the enqueue time. Drivers should only encrypt packets with
this bit set. This prevents retransmissions getting encrypted when
original transmission was not. Similarly to TLS, we'll use
sk->sk_validate_xmit_skb to make sure PSP skbs can't "escape"
via a PSP-unaware device without being encrypted.

On Rx - validation is done under socket lock. This moves the validation
point later than xfrm, for example. Please see the documentation patch
for more details on the flow of securing a connection, but for
the purpose of this patch what's important is that we want to
enforce the invariant that once connection is secured any skb
in the receive queue has been encrypted with PSP.

Add GRO and coalescing checks to prevent PSP authenticated data from
being combined with cleartext data, or data with non-matching PSP
state. On Rx, check skb's with psp_skb_coalesce_diff() at points
before psp_sk_rx_policy_check(). After skb's are policy checked and on
the socket receive queue, skb_cmp_decrypted() is sufficient for
checking for coalescable PSP state. On Tx, tcp_write_collapse_fence()
should be called when transitioning a socket into PSP Tx state to
prevent data sent as cleartext from being coalesced with PSP
encapsulated data.

This change only adds the validation points, for ease of review.
Subsequent change will add the ability to install keys, and flesh
the enforcement logic out

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Co-developed-by: Daniel Zahka <daniel.zahka@gmail.com>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v7:
    - add comments about GRO and TCP coalescing to the commit message.
    v4:
    - add comment to tcp_timewait_state_process() explaining TCP_TW_SYN
      case.
    - psp_twsk_init() accepts const pointer, so caller does not need to
      cast const away.
    - add missing psp_twsk_rx_policy_check() to TCP_TW_SYN case of
      do_timewait in tcp_v4_rcv().
    v3:
    - psp_reply_set_decrypted() does not use stuct sock* arg. Drop it.
    v2:
    - Add psp_reply_set_decrypted() to encapsulate ACKs, FINs, and RSTs
      sent from control socks on behalf of full or timewait socks with PSP
      state.
    v1:
    - https://lore.kernel.org/netdev/20240510030435.120935-5-kuba@kernel.org/

 include/net/dropreason-core.h |  6 +++
 include/net/psp/functions.h   | 77 +++++++++++++++++++++++++++++++++++
 net/core/gro.c                |  2 +
 net/ipv4/inet_timewait_sock.c |  2 +
 net/ipv4/ip_output.c          |  5 ++-
 net/ipv4/tcp.c                |  2 +
 net/ipv4/tcp_ipv4.c           | 14 ++++++-
 net/ipv4/tcp_minisocks.c      | 18 ++++++++
 net/ipv4/tcp_output.c         | 17 +++++---
 net/ipv6/tcp_ipv6.c           | 11 +++++
 net/psp/Kconfig               |  1 +
 11 files changed, 147 insertions(+), 8 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index d8ff24a33459..58d91ccc56e0 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -127,6 +127,8 @@
 	FN(CANXL_RX_INVALID_FRAME)	\
 	FN(PFMEMALLOC)	\
 	FN(DUALPI2_STEP_DROP)		\
+	FN(PSP_INPUT)			\
+	FN(PSP_OUTPUT)			\
 	FNe(MAX)
 
 /**
@@ -610,6 +612,10 @@ enum skb_drop_reason {
 	 * threshold of DualPI2 qdisc.
 	 */
 	SKB_DROP_REASON_DUALPI2_STEP_DROP,
+	/** @SKB_DROP_REASON_PSP_INPUT: PSP input checks failed */
+	SKB_DROP_REASON_PSP_INPUT,
+	/** @SKB_DROP_REASON_PSP_OUTPUT: PSP output checks failed */
+	SKB_DROP_REASON_PSP_OUTPUT,
 	/**
 	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
 	 * shouldn't be used as a real 'reason' - only for tracing code gen
diff --git a/include/net/psp/functions.h b/include/net/psp/functions.h
index d0043bd14299..1ccc5fc238b8 100644
--- a/include/net/psp/functions.h
+++ b/include/net/psp/functions.h
@@ -3,6 +3,8 @@
 #ifndef __NET_PSP_HELPERS_H
 #define __NET_PSP_HELPERS_H
 
+#include <linux/skbuff.h>
+#include <net/sock.h>
 #include <net/psp/types.h>
 
 struct inet_timewait_sock;
@@ -14,7 +16,82 @@ psp_dev_create(struct net_device *netdev, struct psp_dev_ops *psd_ops,
 void psp_dev_unregister(struct psp_dev *psd);
 
 /* Kernel-facing API */
+#if IS_ENABLED(CONFIG_INET_PSP)
 static inline void psp_sk_assoc_free(struct sock *sk) { }
+static inline void
+psp_twsk_init(struct inet_timewait_sock *tw, const struct sock *sk) { }
 static inline void psp_twsk_assoc_free(struct inet_timewait_sock *tw) { }
+static inline void
+psp_reply_set_decrypted(struct sk_buff *skb) { }
+
+static inline void
+psp_enqueue_set_decrypted(struct sock *sk, struct sk_buff *skb)
+{
+}
+
+static inline unsigned long
+__psp_skb_coalesce_diff(const struct sk_buff *one, const struct sk_buff *two,
+			unsigned long diffs)
+{
+	return diffs;
+}
+
+static inline enum skb_drop_reason
+psp_sk_rx_policy_check(struct sock *sk, struct sk_buff *skb)
+{
+	return 0;
+}
+
+static inline enum skb_drop_reason
+psp_twsk_rx_policy_check(struct inet_timewait_sock *tw, struct sk_buff *skb)
+{
+	return 0;
+}
+
+static inline struct psp_assoc *psp_skb_get_assoc_rcu(struct sk_buff *skb)
+{
+	return NULL;
+}
+#else
+static inline void psp_sk_assoc_free(struct sock *sk) { }
+static inline void
+psp_twsk_init(struct inet_timewait_sock *tw, const struct sock *sk) { }
+static inline void psp_twsk_assoc_free(struct inet_timewait_sock *tw) { }
+static inline void
+psp_reply_set_decrypted(struct sk_buff *skb) { }
+
+static inline void
+psp_enqueue_set_decrypted(struct sock *sk, struct sk_buff *skb) { }
+
+static inline unsigned long
+__psp_skb_coalesce_diff(const struct sk_buff *one, const struct sk_buff *two,
+			unsigned long diffs)
+{
+	return diffs;
+}
+
+static inline enum skb_drop_reason
+psp_sk_rx_policy_check(struct sock *sk, struct sk_buff *skb)
+{
+	return 0;
+}
+
+static inline enum skb_drop_reason
+psp_twsk_rx_policy_check(struct inet_timewait_sock *tw, struct sk_buff *skb)
+{
+	return 0;
+}
+
+static inline struct psp_assoc *psp_skb_get_assoc_rcu(struct sk_buff *skb)
+{
+	return NULL;
+}
+#endif
+
+static inline unsigned long
+psp_skb_coalesce_diff(const struct sk_buff *one, const struct sk_buff *two)
+{
+	return __psp_skb_coalesce_diff(one, two, 0);
+}
 
 #endif /* __NET_PSP_HELPERS_H */
diff --git a/net/core/gro.c b/net/core/gro.c
index b350e5b69549..5ba4504cfd28 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
+#include <net/psp.h>
 #include <net/gro.h>
 #include <net/dst_metadata.h>
 #include <net/busy_poll.h>
@@ -376,6 +377,7 @@ static void gro_list_prepare(const struct list_head *head,
 			diffs |= skb_get_nfct(p) ^ skb_get_nfct(skb);
 
 			diffs |= gro_list_prepare_tc_ext(skb, p, diffs);
+			diffs |= __psp_skb_coalesce_diff(skb, p, diffs);
 		}
 
 		NAPI_GRO_CB(p)->same_flow = !diffs;
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 5b5426b8ee92..1f83f333b8ac 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -16,6 +16,7 @@
 #include <net/inet_timewait_sock.h>
 #include <net/ip.h>
 #include <net/tcp.h>
+#include <net/psp.h>
 
 /**
  *	inet_twsk_bind_unhash - unhash a timewait socket from bind hash
@@ -219,6 +220,7 @@ struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk,
 		refcount_set(&tw->tw_refcnt, 0);
 
 		__module_get(tw->tw_prot->owner);
+		psp_twsk_init(tw, sk);
 	}
 
 	return tw;
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 2b96651d719b..5ca97ede979c 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -84,6 +84,7 @@
 #include <linux/netfilter_bridge.h>
 #include <linux/netlink.h>
 #include <linux/tcp.h>
+#include <net/psp.h>
 
 static int
 ip_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
@@ -1665,8 +1666,10 @@ void ip_send_unicast_reply(struct sock *sk, const struct sock *orig_sk,
 			  arg->csumoffset) = csum_fold(csum_add(nskb->csum,
 								arg->csum));
 		nskb->ip_summed = CHECKSUM_NONE;
-		if (orig_sk)
+		if (orig_sk) {
 			skb_set_owner_edemux(nskb, (struct sock *)orig_sk);
+			psp_reply_set_decrypted(nskb);
+		}
 		if (transmit_time)
 			nskb->tstamp_type = SKB_CLOCK_MONOTONIC;
 		if (txhash)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 588932c3cf1d..e851a9506ccb 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -275,6 +275,7 @@
 #include <net/proto_memory.h>
 #include <net/xfrm.h>
 #include <net/ip.h>
+#include <net/psp.h>
 #include <net/sock.h>
 #include <net/rstreason.h>
 
@@ -687,6 +688,7 @@ void tcp_skb_entail(struct sock *sk, struct sk_buff *skb)
 	tcb->seq     = tcb->end_seq = tp->write_seq;
 	tcb->tcp_flags = TCPHDR_ACK;
 	__skb_header_release(skb);
+	psp_enqueue_set_decrypted(sk, skb);
 	tcp_add_write_queue_tail(sk, skb);
 	sk_wmem_queued_add(sk, skb->truesize);
 	sk_mem_charge(sk, skb->truesize);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 1e58a8a9ff7a..0c5ce219f388 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -74,6 +74,7 @@
 #include <net/secure_seq.h>
 #include <net/busy_poll.h>
 #include <net/rstreason.h>
+#include <net/psp.h>
 
 #include <linux/inet.h>
 #include <linux/ipv6.h>
@@ -1905,6 +1906,10 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 	enum skb_drop_reason reason;
 	struct sock *rsk;
 
+	reason = psp_sk_rx_policy_check(sk, skb);
+	if (reason)
+		goto err_discard;
+
 	if (sk->sk_state == TCP_ESTABLISHED) { /* Fast path */
 		struct dst_entry *dst;
 
@@ -1966,6 +1971,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 	reason = SKB_DROP_REASON_TCP_CSUM;
 	trace_tcp_bad_csum(skb);
 	TCP_INC_STATS(sock_net(sk), TCP_MIB_CSUMERRORS);
+err_discard:
 	TCP_INC_STATS(sock_net(sk), TCP_MIB_INERRS);
 	goto discard;
 }
@@ -2067,7 +2073,9 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 	     (TCPHDR_ECE | TCPHDR_CWR | TCPHDR_AE)) ||
 	    !tcp_skb_can_collapse_rx(tail, skb) ||
 	    thtail->doff != th->doff ||
-	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)))
+	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)) ||
+	    /* prior to PSP Rx policy check, retain exact PSP metadata */
+	    psp_skb_coalesce_diff(tail, skb))
 		goto no_coalesce;
 
 	__skb_pull(skb, hdrlen);
@@ -2435,6 +2443,10 @@ int tcp_v4_rcv(struct sk_buff *skb)
 			__this_cpu_write(tcp_tw_isn, isn);
 			goto process;
 		}
+
+		drop_reason = psp_twsk_rx_policy_check(inet_twsk(sk), skb);
+		if (drop_reason)
+			break;
 	}
 		/* to ACK */
 		fallthrough;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 17ecdbc66f05..eddfd3f2f7a9 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -104,9 +104,16 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 	struct tcp_timewait_sock *tcptw = tcp_twsk((struct sock *)tw);
 	u32 rcv_nxt = READ_ONCE(tcptw->tw_rcv_nxt);
 	struct tcp_options_received tmp_opt;
+	enum skb_drop_reason psp_drop;
 	bool paws_reject = false;
 	int ts_recent_stamp;
 
+	/* Instead of dropping immediately, wait to see what value is
+	 * returned. We will accept a non psp-encapsulated syn in the
+	 * case where TCP_TW_SYN is returned.
+	 */
+	psp_drop = psp_twsk_rx_policy_check(tw, skb);
+
 	tmp_opt.saw_tstamp = 0;
 	ts_recent_stamp = READ_ONCE(tcptw->tw_ts_recent_stamp);
 	if (th->doff > (sizeof(*th) >> 2) && ts_recent_stamp) {
@@ -124,6 +131,9 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 	if (READ_ONCE(tw->tw_substate) == TCP_FIN_WAIT2) {
 		/* Just repeat all the checks of tcp_rcv_state_process() */
 
+		if (psp_drop)
+			goto out_put;
+
 		/* Out of window, send ACK */
 		if (paws_reject ||
 		    !tcp_in_window(TCP_SKB_CB(skb)->seq, TCP_SKB_CB(skb)->end_seq,
@@ -194,6 +204,9 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 	     (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq || th->rst))) {
 		/* In window segment, it may be only reset or bare ack. */
 
+		if (psp_drop)
+			goto out_put;
+
 		if (th->rst) {
 			/* This is TIME_WAIT assassination, in two flavors.
 			 * Oh well... nobody has a sufficient solution to this
@@ -247,6 +260,9 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 		return TCP_TW_SYN;
 	}
 
+	if (psp_drop)
+		goto out_put;
+
 	if (paws_reject) {
 		*drop_reason = SKB_DROP_REASON_TCP_RFC7323_TW_PAWS;
 		__NET_INC_STATS(twsk_net(tw), LINUX_MIB_PAWS_TW_REJECTED);
@@ -265,6 +281,8 @@ tcp_timewait_state_process(struct inet_timewait_sock *tw, struct sk_buff *skb,
 		return tcp_timewait_check_oow_rate_limit(
 			tw, skb, LINUX_MIB_TCPACKSKIPPEDTIMEWAIT);
 	}
+
+out_put:
 	inet_twsk_put(tw);
 	return TCP_TW_SUCCESS;
 }
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index e180364b8dda..2c23a2a0fc7d 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -40,6 +40,7 @@
 #include <net/tcp.h>
 #include <net/mptcp.h>
 #include <net/proto_memory.h>
+#include <net/psp.h>
 
 #include <linux/compiler.h>
 #include <linux/gfp.h>
@@ -403,13 +404,15 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 /* Constructs common control bits of non-data skb. If SYN/FIN is present,
  * auto increment end seqno.
  */
-static void tcp_init_nondata_skb(struct sk_buff *skb, u32 seq, u16 flags)
+static void tcp_init_nondata_skb(struct sk_buff *skb, struct sock *sk,
+				 u32 seq, u16 flags)
 {
 	skb->ip_summed = CHECKSUM_PARTIAL;
 
 	TCP_SKB_CB(skb)->tcp_flags = flags;
 
 	tcp_skb_pcount_set(skb, 1);
+	psp_enqueue_set_decrypted(sk, skb);
 
 	TCP_SKB_CB(skb)->seq = seq;
 	if (flags & (TCPHDR_SYN | TCPHDR_FIN))
@@ -1510,6 +1513,7 @@ static void tcp_queue_skb(struct sock *sk, struct sk_buff *skb)
 	/* Advance write_seq and place onto the write_queue. */
 	WRITE_ONCE(tp->write_seq, TCP_SKB_CB(skb)->end_seq);
 	__skb_header_release(skb);
+	psp_enqueue_set_decrypted(sk, skb);
 	tcp_add_write_queue_tail(sk, skb);
 	sk_wmem_queued_add(sk, skb->truesize);
 	sk_mem_charge(sk, skb->truesize);
@@ -3624,7 +3628,7 @@ void tcp_send_fin(struct sock *sk)
 		skb_reserve(skb, MAX_TCP_HEADER);
 		sk_forced_mem_schedule(sk, skb->truesize);
 		/* FIN eats a sequence byte, write_seq advanced by tcp_queue_skb(). */
-		tcp_init_nondata_skb(skb, tp->write_seq,
+		tcp_init_nondata_skb(skb, sk, tp->write_seq,
 				     TCPHDR_ACK | TCPHDR_FIN);
 		tcp_queue_skb(sk, skb);
 	}
@@ -3652,7 +3656,7 @@ void tcp_send_active_reset(struct sock *sk, gfp_t priority,
 
 	/* Reserve space for headers and prepare control bits. */
 	skb_reserve(skb, MAX_TCP_HEADER);
-	tcp_init_nondata_skb(skb, tcp_acceptable_seq(sk),
+	tcp_init_nondata_skb(skb, sk, tcp_acceptable_seq(sk),
 			     TCPHDR_ACK | TCPHDR_RST);
 	tcp_mstamp_refresh(tcp_sk(sk));
 	/* Send it off. */
@@ -4149,7 +4153,7 @@ int tcp_connect(struct sock *sk)
 	/* SYN eats a sequence byte, write_seq updated by
 	 * tcp_connect_queue_skb().
 	 */
-	tcp_init_nondata_skb(buff, tp->write_seq, TCPHDR_SYN);
+	tcp_init_nondata_skb(buff, sk, tp->write_seq, TCPHDR_SYN);
 	tcp_mstamp_refresh(tp);
 	tp->retrans_stamp = tcp_time_stamp_ts(tp);
 	tcp_connect_queue_skb(sk, buff);
@@ -4274,7 +4278,8 @@ void __tcp_send_ack(struct sock *sk, u32 rcv_nxt, u16 flags)
 
 	/* Reserve space for headers and prepare control bits. */
 	skb_reserve(buff, MAX_TCP_HEADER);
-	tcp_init_nondata_skb(buff, tcp_acceptable_seq(sk), TCPHDR_ACK | flags);
+	tcp_init_nondata_skb(buff, sk,
+			     tcp_acceptable_seq(sk), TCPHDR_ACK | flags);
 
 	/* We do not want pure acks influencing TCP Small Queues or fq/pacing
 	 * too much.
@@ -4320,7 +4325,7 @@ static int tcp_xmit_probe_skb(struct sock *sk, int urgent, int mib)
 	 * end to send an ack.  Don't queue or clone SKB, just
 	 * send it.
 	 */
-	tcp_init_nondata_skb(skb, tp->snd_una - !urgent, TCPHDR_ACK);
+	tcp_init_nondata_skb(skb, sk, tp->snd_una - !urgent, TCPHDR_ACK);
 	NET_INC_STATS(sock_net(sk), mib);
 	return tcp_transmit_skb(sk, skb, 0, (__force gfp_t)0);
 }
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 0562e939b2e3..c034486d4451 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -62,6 +62,7 @@
 #include <net/hotdata.h>
 #include <net/busy_poll.h>
 #include <net/rstreason.h>
+#include <net/psp.h>
 
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
@@ -972,6 +973,7 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 	if (sk) {
 		/* unconstify the socket only to attach it to buff with care. */
 		skb_set_owner_edemux(buff, (struct sock *)sk);
+		psp_reply_set_decrypted(buff);
 
 		if (sk->sk_state == TCP_TIME_WAIT)
 			mark = inet_twsk(sk)->tw_mark;
@@ -1604,6 +1606,10 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	if (skb->protocol == htons(ETH_P_IP))
 		return tcp_v4_do_rcv(sk, skb);
 
+	reason = psp_sk_rx_policy_check(sk, skb);
+	if (reason)
+		goto err_discard;
+
 	/*
 	 *	socket locking is here for SMP purposes as backlog rcv
 	 *	is currently called with bh processing disabled.
@@ -1683,6 +1689,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	reason = SKB_DROP_REASON_TCP_CSUM;
 	trace_tcp_bad_csum(skb);
 	TCP_INC_STATS(sock_net(sk), TCP_MIB_CSUMERRORS);
+err_discard:
 	TCP_INC_STATS(sock_net(sk), TCP_MIB_INERRS);
 	goto discard;
 
@@ -1987,6 +1994,10 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 			__this_cpu_write(tcp_tw_isn, isn);
 			goto process;
 		}
+
+		drop_reason = psp_twsk_rx_policy_check(inet_twsk(sk), skb);
+		if (drop_reason)
+			break;
 	}
 		/* to ACK */
 		fallthrough;
diff --git a/net/psp/Kconfig b/net/psp/Kconfig
index 55f9dd87446b..5e3908a40945 100644
--- a/net/psp/Kconfig
+++ b/net/psp/Kconfig
@@ -5,6 +5,7 @@
 config INET_PSP
 	bool "PSP Security Protocol support"
 	depends on INET
+	select SKB_DECRYPTED
 	help
 	Enable kernel support for the PSP protocol.
 	For more information see:
-- 
2.47.3


