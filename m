Return-Path: <netdev+bounces-217908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AC0B3A646
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 18:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A652362DF3
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 16:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9040326D57;
	Thu, 28 Aug 2025 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7co2kWV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB732F9C38
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398602; cv=none; b=uWyYD4fgQYgwSMVSyJ+wI/9hOIYI2lqrGtu14AlNaCXeZmFHntXFte10qnxb9nNe5VSeFvr8p8I1FlSLJwMVGBMtS7ldq9rwhpiwIUhGRKjynNzaOfiXEQtfYYg/8trqMmPEozicKoExrfTcLy0uLcfE7MjuQGP6EzUwsb1gv+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398602; c=relaxed/simple;
	bh=ZdBksCJROPGqVzlSib93aav+yKOVCjEGwFCt5zfuTc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ojbm9aHIIi2P2bUGHaVUoXxYKHQH47ir2ZWSN30RJI6O24SHCyLdwL7HZ4kf2YcUFlErVmWEbzYmLuCLmlXDMa00nsNG4KTzJwcffkSou7aSiusxOXjtCUoWJx2YpVgUDY93Hgv1KOlKsfcoU5ZMmCCakrmKWv7lmNCk8u6YyCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7co2kWV; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e970f3c06b5so313416276.1
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 09:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756398599; x=1757003399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDYBCx5hnECJpxKvZxkFpoPdENR4N0yndoTm9qo9SJU=;
        b=i7co2kWVDr6t7E/3yRiJY9DLOadfNi0MeB+Uz4pjT6ptwQWvNXQmK9J1iSdHCm0T5S
         Gol9dBTY+9k38/XjPosUfrS+yCMTFcZNOKw98W+Gon0HhOv0mjClOS96JQXFU7vrQQ2d
         rXTc1ygHIT7qNLQFNIkwxWhJbOfT3P0xvjdR7t9/tpWNi3P/bChwQWDMbZU3oAeXBwSp
         +oEZTiRwbnU15If7SRkOvknbOgaF4seyGs3vD9bYR9KvJbqTtgYdG2/HM2ofWpXYvOGu
         OJNPZBqELZEWZmzkUS4nc51cbfU52WkY8BsKKQ/TuDPDue5MTOYyAT+96OaOi9+MtfsC
         vXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756398599; x=1757003399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDYBCx5hnECJpxKvZxkFpoPdENR4N0yndoTm9qo9SJU=;
        b=otM0fINXT1pAc7vq/lZA0n44kRAZ+2G0jCVn/dPSFjIZAoHjO2mFU/F0lsKiSLllgs
         q/Pd84F7Kye5HdyMWK4/SnO253ltU0rv4X/e3Pohplxxl7reFWvei9QjI6MmdK0CcIh7
         UNZBsnxY+puVwNWTwxL5IOxvtjTeLUBSnnq67kXo6nbjAill61ZJzs2x/cUh+S7ExUkb
         UGjFW2+GIrVkF9lwKyJYkWyJexQIcBwPKhTFBeBx/u8nk64KBXJZ8c1pOIOr2Dlhhu8M
         sIuVCL2qwAzEX5YNZkEe4l29xUDKPaz95bL1IB1UFcio84iNBzQh85pUECHBCi48vDm7
         ygyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXdOKPlxk3Z12PqlK2iKtzhnLoOpRbE+HVLi9UlVImWq42dh2SJNXMBV0l2W2V9NLMZJ4gO8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtUURD4vXVG88u7KQlfmMsisQoDJJzyeJLa4mvouTKZ54Qr9xj
	O/FzOgGUvpBqeaSb0tlQJvuD8s73GXuU0hHDCgNfySXOZPt8wg5y8cA0Nla7vA==
X-Gm-Gg: ASbGncuhs4rxdiBeltox/zly++GMEv9ALREuUZcoYxmZk117JdjYmZ5z2UxZ0qVJ+wa
	jxupcutRsxrEyDh3OJs8bWxN2N605Ley2ijxh8l4xtWY/qMRl73kCwFmBuf1NowXXNpIFjwbyPP
	Nl/ot0Pwm/briQKSFxU6QXs2j95+MG+KHZnJfk1kBzhHokg0hskvCdAQdoneIGtkQgshzeetw+x
	wu5Ynpv1SqhEV10pjPh/2dkbX/xx6TI9hOFdVdYFCDbqncdMXd2gZo7/+IgZ98J/b9j16V9q7Fp
	Wl0so49cbXfoiLjHrJfBizwVvAUDiIN/n8NYg486UP5DC881srU8jG9+pCqn8FH8FucUadpgwrN
	QA9934IKLeu15Bmxvosre
X-Google-Smtp-Source: AGHT+IHGbDtB4ot5RClGZrtA9aTAXwwXk0PvMQmaA9UZC6xH2xVLFRfkoLki/IowA1v3eS2ZILYPQQ==
X-Received: by 2002:a05:6902:721:b0:e93:48ae:fdbe with SMTP id 3f1490d57ef6-e951c3c387cmr27338171276.32.1756398598843;
        Thu, 28 Aug 2025 09:29:58 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:54::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96e5530a72sm2113101276.2.2025.08.28.09.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 09:29:58 -0700 (PDT)
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
Subject: [PATCH net-next v10 04/19] tcp: add datapath logic for PSP with inline key exchange
Date: Thu, 28 Aug 2025 09:29:30 -0700
Message-ID: <20250828162953.2707727-5-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250828162953.2707727-1-daniel.zahka@gmail.com>
References: <20250828162953.2707727-1-daniel.zahka@gmail.com>
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
index 9bc8317e92b7..ba5a23e5c261 100644
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
index 7c1d612afca1..f046e33f4c87 100644
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
index 06b26a6efd62..d680c1b8bb2b 100644
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
index b4e56b877273..7a88f67820a1 100644
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
@@ -1606,6 +1608,10 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	if (skb->protocol == htons(ETH_P_IP))
 		return tcp_v4_do_rcv(sk, skb);
 
+	reason = psp_sk_rx_policy_check(sk, skb);
+	if (reason)
+		goto err_discard;
+
 	/*
 	 *	socket locking is here for SMP purposes as backlog rcv
 	 *	is currently called with bh processing disabled.
@@ -1685,6 +1691,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	reason = SKB_DROP_REASON_TCP_CSUM;
 	trace_tcp_bad_csum(skb);
 	TCP_INC_STATS(sock_net(sk), TCP_MIB_CSUMERRORS);
+err_discard:
 	TCP_INC_STATS(sock_net(sk), TCP_MIB_INERRS);
 	goto discard;
 
@@ -1989,6 +1996,10 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
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


