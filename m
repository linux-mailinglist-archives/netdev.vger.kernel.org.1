Return-Path: <netdev+bounces-216613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7234EB34B4F
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 22:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E971892863
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 20:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A961285C98;
	Mon, 25 Aug 2025 20:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MX0eDERA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF86283FD0
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 20:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756152091; cv=none; b=afrlRY2NGHa8rqPcvT1yXI3ekEgXc6aQZDEfjMrMcxzYNDJadqSZwwp+ohDnzi7AX5kg8kFnQ/aTlbNLro4DMRNEcLlLhztJgG8tH/m06/IjS86Utei2sjCKl+oPbAmxss6tnI9R90+YPFT2RWkBt9tYhbUTwz0N/5H6+OWxwaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756152091; c=relaxed/simple;
	bh=NpWotFHd5NFwibUQn4/mL1XOzlyWtx40GrkjAJyKDjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uokX2HmOJ9aupp3LfR7jhBFW7Ig4L6cKVp1JGqBEq9oR3iNh5oapq8f3JBRn1zcACm6iCpPZkRmOtrX2d7lfIGO/M1aQDsAsHRnitLrhGnWNY2n59tEGKeW/BI6j5ThWlsNmH8FGCc2RaBJ+AJLmFg/WaPl9MUMQBOnUzxBtHqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MX0eDERA; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e931cad1fd8so4110841276.1
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 13:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756152080; x=1756756880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQdg0ANGfki4o3NRGbDInUsk2c3/njokVR4/R2cble0=;
        b=MX0eDERAzG2K8BFm4O7bZegxn2Hc4pWq1yupf6CjOkPpJJlo+van/xO2toZXjKZbQj
         B4xiG7LSXPMEe7vMxzKNzNM9seDgo9BuS6CO0h1PoVCwiMl9hJLYINfzMHGPw6qOF1ob
         FNFFkYygyjbS+5cTlEoUwjQFwLihRchhT+lka9oumAdmkwezS+/8pemfuCFZdV73LziF
         KkkwuDrNn7ZVCwEPJvZQczPtxUWREml7iWCFKTdP7D+CK31xQGF93185KZQQ1810CIFE
         8a7KYgpT+yxGlTYEn4SNCccNgS/Up52UNhRh1mVTyXELPX/lALTVfYKxwvfwc04ULJW/
         Kw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756152080; x=1756756880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQdg0ANGfki4o3NRGbDInUsk2c3/njokVR4/R2cble0=;
        b=H3jyrN3drVBWHAWSHw+ciIOadWUfxcRmuvud3o0QZBy+4NsPMymIPxm7dhEynE6Z3U
         YfIkU0mzA137vvi+cChqwpKX1+LlndhZ9vhc+BXvPQgzzpMQj6LsaK0pDQl+5IxhpSYi
         jW67+fen/3NUwKKE1wyAQQruEP8mKQeslsCp6q16b2XAhHsl0niw5ypk7W4Mv+2RTjXh
         ieZUJ/5gPQ5tkkPdNy7281v3Ek3bgfN5M7sgHv3mL97pDKHz8ndrmt/MQ5UAdvoPfC/U
         Eunz+6gL56MvQrw/O7bxOOUt6SRPYyJ5sUPvyPL3mv4/foApVYc12WHDC7nKoe5O0jio
         2gBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjYrkJ8faHMaLwQNXX+GogN7paR0bOIk1vmV8aECxipGgXKSnyd7KRnRB/GlqrxAqiLa0oQHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuGIgHWJ64BCQOXuqnijvdlEv1u2Mmykski9T88rzMqvIbl3VX
	OsdgCz9SC//CV2+l6Q6nk1TzTZfGsBsElVbr991fyUuEdXdmtwXJTbWj
X-Gm-Gg: ASbGncsSwE8YKotVUJsg7r0TwvJVmNmTuU6y8loLm/drljjq6Z4ggCBPSyk8hnk4Nfc
	UcQa+gABHveE6N/NwgtANi+D0y2Liy1O16HfDbQGUNX6LS/4+OLFaw5YkVcStJNWLkBZjwVOqzI
	5eyqqI38tS5kwzCZWHqodpTBTwMr9GyEbvpM9pvfLd4KDOgYPRBRS00OhftNMHQ/Z8IjZseKrQE
	DA5kMVXtgRnhq1f1h9eBRK1nhaJ5IFsopKjs9b/P6VDipv1eyOSXqe6Q7fAzSjQGngyX9hFOXO7
	8oiGHs8ZhQjq4c9UyP+ggtMLdfoIaYJQLpLpS3MCglJ4M/Xl58OqW202u2uq4mj14tnZQI8jURX
	nZ/7XUxBoOUg4GSCP0+DCO+Ez1SGaf5o=
X-Google-Smtp-Source: AGHT+IEsYmDQABMnFAqnvr6Ro0gMgwnUfB0wnMP8wp5L5U8q62iyLXXpPi/aGt7KKtSACInShbdSAQ==
X-Received: by 2002:a05:690c:680e:b0:721:7e7:4e3 with SMTP id 00721157ae682-72107e73cb3mr56817997b3.50.1756152079521;
        Mon, 25 Aug 2025 13:01:19 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:41::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff170321bsm19884817b3.8.2025.08.25.13.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 13:01:18 -0700 (PDT)
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
Subject: [PATCH net-next v8 04/19] tcp: add datapath logic for PSP with inline key exchange
Date: Mon, 25 Aug 2025 13:00:52 -0700
Message-ID: <20250825200112.1750547-5-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250825200112.1750547-1-daniel.zahka@gmail.com>
References: <20250825200112.1750547-1-daniel.zahka@gmail.com>
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
 net/ipv4/inet_timewait_sock.c |  3 +-
 net/ipv4/ip_output.c          |  5 ++-
 net/ipv4/tcp.c                |  2 +
 net/ipv4/tcp_ipv4.c           | 14 ++++++-
 net/ipv4/tcp_minisocks.c      | 18 ++++++++
 net/ipv4/tcp_output.c         | 17 +++++---
 net/ipv6/tcp_ipv6.c           | 11 +++++
 net/psp/Kconfig               |  1 +
 11 files changed, 147 insertions(+), 9 deletions(-)

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
index 875ff923a8ed..88b5faa656b4 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -15,7 +15,7 @@
 #include <net/inet_hashtables.h>
 #include <net/inet_timewait_sock.h>
 #include <net/ip.h>
-
+#include <net/psp.h>
 
 /**
  *	inet_twsk_bind_unhash - unhash a timewait socket from bind hash
@@ -218,6 +218,7 @@ struct inet_timewait_sock *inet_twsk_alloc(const struct sock *sk,
 		refcount_set(&tw->tw_refcnt, 0);
 
 		__module_get(tw->tw_prot->owner);
+		psp_twsk_init(tw, sk);
 	}
 
 	return tw;
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 84e7f8a2f50f..6693cec43cca 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -83,6 +83,7 @@
 #include <linux/netfilter_bridge.h>
 #include <linux/netlink.h>
 #include <linux/tcp.h>
+#include <net/psp.h>
 
 static int
 ip_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
@@ -1664,8 +1665,10 @@ void ip_send_unicast_reply(struct sock *sk, const struct sock *orig_sk,
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
index 99232903b03c..062289fe8d6d 100644
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
index 84d3d556ed80..35e2a1ce87b8 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -74,6 +74,7 @@
 #include <net/secure_seq.h>
 #include <net/busy_poll.h>
 #include <net/rstreason.h>
+#include <net/psp.h>
 
 #include <linux/inet.h>
 #include <linux/ipv6.h>
@@ -1907,6 +1908,10 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 	enum skb_drop_reason reason;
 	struct sock *rsk;
 
+	reason = psp_sk_rx_policy_check(sk, skb);
+	if (reason)
+		goto err_discard;
+
 	if (sk->sk_state == TCP_ESTABLISHED) { /* Fast path */
 		struct dst_entry *dst;
 
@@ -1968,6 +1973,7 @@ int tcp_v4_do_rcv(struct sock *sk, struct sk_buff *skb)
 	reason = SKB_DROP_REASON_TCP_CSUM;
 	trace_tcp_bad_csum(skb);
 	TCP_INC_STATS(sock_net(sk), TCP_MIB_CSUMERRORS);
+err_discard:
 	TCP_INC_STATS(sock_net(sk), TCP_MIB_INERRS);
 	goto discard;
 }
@@ -2070,7 +2076,9 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 	     (TCPHDR_ECE | TCPHDR_CWR | TCPHDR_AE)) ||
 	    !tcp_skb_can_collapse_rx(tail, skb) ||
 	    thtail->doff != th->doff ||
-	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)))
+	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)) ||
+	    /* prior to PSP Rx policy check, retain exact PSP metadata */
+	    psp_skb_coalesce_diff(tail, skb))
 		goto no_coalesce;
 
 	__skb_pull(skb, hdrlen);
@@ -2441,6 +2449,10 @@ int tcp_v4_rcv(struct sk_buff *skb)
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
index b1b521a95c21..b45894bd201d 100644
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
index 86892c8672ed..d7b68ed9479e 100644
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
index 7577e7eb2c97..6a89edda31c7 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -62,6 +62,7 @@
 #include <net/hotdata.h>
 #include <net/busy_poll.h>
 #include <net/rstreason.h>
+#include <net/psp.h>
 
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
@@ -973,6 +974,7 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 	if (sk) {
 		/* unconstify the socket only to attach it to buff with care. */
 		skb_set_owner_edemux(buff, (struct sock *)sk);
+		psp_reply_set_decrypted(buff);
 
 		if (sk->sk_state == TCP_TIME_WAIT)
 			mark = inet_twsk(sk)->tw_mark;
@@ -1608,6 +1610,10 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	if (skb->protocol == htons(ETH_P_IP))
 		return tcp_v4_do_rcv(sk, skb);
 
+	reason = psp_sk_rx_policy_check(sk, skb);
+	if (reason)
+		goto err_discard;
+
 	/*
 	 *	socket locking is here for SMP purposes as backlog rcv
 	 *	is currently called with bh processing disabled.
@@ -1687,6 +1693,7 @@ int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	reason = SKB_DROP_REASON_TCP_CSUM;
 	trace_tcp_bad_csum(skb);
 	TCP_INC_STATS(sock_net(sk), TCP_MIB_CSUMERRORS);
+err_discard:
 	TCP_INC_STATS(sock_net(sk), TCP_MIB_INERRS);
 	goto discard;
 
@@ -1992,6 +1999,10 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
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


