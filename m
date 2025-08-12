Return-Path: <netdev+bounces-212677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5E0B219C5
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 02:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E6174282FC
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 00:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8032D5426;
	Tue, 12 Aug 2025 00:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBFeO4Id"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E43A20C004
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 00:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754958618; cv=none; b=a/mSnGKbkXz6/c7/4bFi0bvzga9sJZVGDgVYQikMbajKgnTANM4+VMNRJGnR22495bJh2OwfgKL0kGTj1ZKpGUlXnWl3mzGal+RujP+OpMwwXDuN9XN4NH+AsaMnSUahbk1g/LuBIJHKsMzWT/6Q+SqWZn5QJjxg//rynoACMO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754958618; c=relaxed/simple;
	bh=dKCf5SflQn/TvgOkSekIGzbcSiP+11tTQbayQqBfFwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EyL8PzumBRoq2rFqCjDVYOvOJCsFXgHK0e4XjHF0V2jnOpIc8M5wgn3IhleZH9EHjMH2DqwB4b1NRWGMuSiITBjEpJKd/vUziwsnb9+97kSjhA4i46SO0IV4nHIiVmZCAgB7zMivGi2pxYliV+6UZqxNz1U2YHeOjW6vxFSNpv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBFeO4Id; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e8e0c6f1707so3917577276.0
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 17:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754958614; x=1755563414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WL9AhanreN9+9NRqpuh0GEEgBVWYTEdzTQkDSDZxE60=;
        b=VBFeO4IdTg+J8Z6BYwjBPO3B1UeMhAFOruJVleJbPiFlAYdS7014/UqZnfvQXKdM6I
         YqcH7TLhLq+vjGQToNJTE+fWvHiTE0O1Q0i4loGcXJjyVgMlrR1jcAYd53LJ3eGht+KP
         5GPwxnPaKKSwE7PoqKcE+E8nrfhjQtpNtN8AffBb8BnJhRjcQB+gfWkU3GY+U3H9O1WQ
         p2toOcNK2L2DF76ckQTiiGf+0yommKB4cUKFl0HJ4e0DIg/XfTUWvNvWz14ogYxWNyMR
         V2siT2ggUIDtfCBl1JY3TccsVEx+ItMj2OyfU0ESuNZcuPqHQ5X/6YU/QouryRFEJyzR
         BSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754958614; x=1755563414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WL9AhanreN9+9NRqpuh0GEEgBVWYTEdzTQkDSDZxE60=;
        b=Q5/qKpvTNq8gRaFWnLsc/infnNSfqoWtY3X1w8LgsEPsNtHTb9SPDa03JddABSbN+o
         hhtO7Z8GaZTl80BG/ZmaeIFWFkI2Yf1M5yvfztTSAC/EAV7jvJawN4J1bR78AN3SKaNd
         ESY3c5vWjZ52/Lf27R1al7FSwLm/dWfIOFRngm18V9egmYa5Ewo7rmAH5SgzQLs5wih8
         ynFYLz3E/z5uY6xKdQsfyMhD0FrLI9FJN3H8gpv51aknSuhgRYUkjfOW0HNUXjAf34Tm
         dtK2dY412TaJPZ/7uCDqJoq7PZCne7XFciZ3IAaGNXgHpR2nx0JWZYbGVtEckGCDe71l
         n/dw==
X-Forwarded-Encrypted: i=1; AJvYcCXmlTiH+cJsTrGR6StnbXSjrkx9rh86hgITBCxWlcDlPbtQvfldmxSHkneVfhfOuWAUScREDBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYjDgBrddE1C/fcKdH3VC/fRuPsIjIwkQo0ngGZqFzB283q72m
	5WkYPDX+FLgum/8KwGqaQr2qs74NL5R2eSsfnnJ9vJoB0WyIcTtuvueg
X-Gm-Gg: ASbGncsQoiGvTcHQICk3P587i/SNP3y0R5rXJTYSgefpSYQJSLZ3fcC1jv6IT0Lv7fM
	82vzTWVZzvGhTHmkxK9Di2pNOdV7nFSEd5E5idYn4WF0zeokD8MhH9mCZmadBrdK+uGQ3/mqamo
	SMK5KWl/aVBP4T8gP7eHPaRxVAm1Oy074A3XT0QKgVo98LEu9PByUiL2EvEQfEVev1dhzESXOUG
	dMsx9DMLTghezIWEGlzt0nWCKK09gAa35nBp/hF8JZjtnZ0JcBcX6z2253fxz25D/BjtkmIv3+D
	lXvrksU23CjCqvoxjs5jjN6jCPIdlNcThgO78B0xR1xLbm8m6BK025gDOftY8fwbpDlxtGzL3yy
	f3glfvAh7FVsvrCuRezQh
X-Google-Smtp-Source: AGHT+IEM3Of780V/Ll/LZyggYBr5jlwBOrKmKFsHmMJWFZXcwHKvDWufxItw4rG1g57E0gH8UjrWJw==
X-Received: by 2002:a05:690c:4809:b0:71c:bf3:afa6 with SMTP id 00721157ae682-71c42a9b44amr21651937b3.42.1754958614376;
        Mon, 11 Aug 2025 17:30:14 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:46::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a3a9b23sm72563917b3.16.2025.08.11.17.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 17:30:13 -0700 (PDT)
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
Subject: [PATCH net-next v6 03/19] net: modify core data structures for PSP datapath support
Date: Mon, 11 Aug 2025 17:29:50 -0700
Message-ID: <20250812003009.2455540-4-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250812003009.2455540-1-daniel.zahka@gmail.com>
References: <20250812003009.2455540-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Add pointers to psp data structures to core networking structs,
and an SKB extension to carry the PSP information from the drivers
to the socket layer.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Co-developed-by: Daniel Zahka <daniel.zahka@gmail.com>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v2:
    - Add dev_id field to psp_skb_ext
    - Move psp_assoc from struct tcp_timewait_sock to struct
      inet_timewait_sock
    - Move psp_sk_assoc_free() from sk_common_release() to
      inet_sock_destruct()
    v1:
      - https://lore.kernel.org/netdev/20240510030435.120935-4-kuba@kernel.org/

 include/linux/skbuff.h           | 3 +++
 include/net/inet_timewait_sock.h | 3 +++
 include/net/psp/functions.h      | 6 ++++++
 include/net/psp/types.h          | 7 +++++++
 include/net/sock.h               | 4 ++++
 net/core/skbuff.c                | 4 ++++
 net/ipv4/af_inet.c               | 2 ++
 net/ipv4/tcp_minisocks.c         | 2 ++
 8 files changed, 31 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 14b923ddb6df..19ee1ad2c421 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4858,6 +4858,9 @@ enum skb_ext_id {
 #endif
 #if IS_ENABLED(CONFIG_MCTP_FLOWS)
 	SKB_EXT_MCTP,
+#endif
+#if IS_ENABLED(CONFIG_INET_PSP)
+	SKB_EXT_PSP,
 #endif
 	SKB_EXT_NUM, /* must be last */
 };
diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait_sock.h
index 67a313575780..c1295246216c 100644
--- a/include/net/inet_timewait_sock.h
+++ b/include/net/inet_timewait_sock.h
@@ -81,6 +81,9 @@ struct inet_timewait_sock {
 	struct timer_list	tw_timer;
 	struct inet_bind_bucket	*tw_tb;
 	struct inet_bind2_bucket	*tw_tb2;
+#if IS_ENABLED(CONFIG_INET_PSP)
+	struct psp_assoc __rcu	  *psp_assoc;
+#endif
 };
 #define tw_tclass tw_tos
 
diff --git a/include/net/psp/functions.h b/include/net/psp/functions.h
index 074f9df9afc3..d0043bd14299 100644
--- a/include/net/psp/functions.h
+++ b/include/net/psp/functions.h
@@ -5,10 +5,16 @@
 
 #include <net/psp/types.h>
 
+struct inet_timewait_sock;
+
 /* Driver-facing API */
 struct psp_dev *
 psp_dev_create(struct net_device *netdev, struct psp_dev_ops *psd_ops,
 	       struct psp_dev_caps *psd_caps, void *priv_ptr);
 void psp_dev_unregister(struct psp_dev *psd);
 
+/* Kernel-facing API */
+static inline void psp_sk_assoc_free(struct sock *sk) { }
+static inline void psp_twsk_assoc_free(struct inet_timewait_sock *tw) { }
+
 #endif /* __NET_PSP_HELPERS_H */
diff --git a/include/net/psp/types.h b/include/net/psp/types.h
index d242b1ecee7d..4922fc8d42fd 100644
--- a/include/net/psp/types.h
+++ b/include/net/psp/types.h
@@ -84,6 +84,13 @@ struct psp_dev_caps {
 
 #define PSP_MAX_KEY	32
 
+struct psp_skb_ext {
+	__be32 spi;
+	u16 dev_id;
+	u8 generation;
+	u8 version;
+};
+
 /**
  * struct psp_dev_ops - netdev driver facing PSP callbacks
  */
diff --git a/include/net/sock.h b/include/net/sock.h
index c8a4b283df6f..94ff9b701051 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -249,6 +249,7 @@ struct sk_filter;
   *	@sk_dst_cache: destination cache
   *	@sk_dst_pending_confirm: need to confirm neighbour
   *	@sk_policy: flow policy
+  *	@psp_assoc: PSP association, if socket is PSP-secured
   *	@sk_receive_queue: incoming packets
   *	@sk_wmem_alloc: transmit queue bytes committed
   *	@sk_tsq_flags: TCP Small Queues flags
@@ -446,6 +447,9 @@ struct sock {
 	struct mem_cgroup	*sk_memcg;
 #ifdef CONFIG_XFRM
 	struct xfrm_policy __rcu *sk_policy[2];
+#endif
+#if IS_ENABLED(CONFIG_INET_PSP)
+	struct psp_assoc __rcu	*psp_assoc;
 #endif
 	__cacheline_group_end(sock_read_rxtx);
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ee0274417948..d5aa80d90283 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -79,6 +79,7 @@
 #include <net/mptcp.h>
 #include <net/mctp.h>
 #include <net/page_pool/helpers.h>
+#include <net/psp/types.h>
 #include <net/dropreason.h>
 
 #include <linux/uaccess.h>
@@ -5060,6 +5061,9 @@ static const u8 skb_ext_type_len[] = {
 #if IS_ENABLED(CONFIG_MCTP_FLOWS)
 	[SKB_EXT_MCTP] = SKB_EXT_CHUNKSIZEOF(struct mctp_flow),
 #endif
+#if IS_ENABLED(CONFIG_INET_PSP)
+	[SKB_EXT_PSP] = SKB_EXT_CHUNKSIZEOF(struct psp_skb_ext),
+#endif
 };
 
 static __always_inline unsigned int skb_ext_total_length(void)
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 76e38092cd8a..e298dacb4a06 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -102,6 +102,7 @@
 #include <net/gro.h>
 #include <net/gso.h>
 #include <net/tcp.h>
+#include <net/psp.h>
 #include <net/udp.h>
 #include <net/udplite.h>
 #include <net/ping.h>
@@ -158,6 +159,7 @@ void inet_sock_destruct(struct sock *sk)
 	kfree(rcu_dereference_protected(inet->inet_opt, 1));
 	dst_release(rcu_dereference_protected(sk->sk_dst_cache, 1));
 	dst_release(rcu_dereference_protected(sk->sk_rx_dst, 1));
+	psp_sk_assoc_free(sk);
 }
 EXPORT_SYMBOL(inet_sock_destruct);
 
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 2994c9222c9c..b1b521a95c21 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -23,6 +23,7 @@
 #include <net/xfrm.h>
 #include <net/busy_poll.h>
 #include <net/rstreason.h>
+#include <net/psp.h>
 
 static bool tcp_in_window(u32 seq, u32 end_seq, u32 s_win, u32 e_win)
 {
@@ -400,6 +401,7 @@ void tcp_twsk_destructor(struct sock *sk)
 	}
 #endif
 	tcp_ao_destroy_sock(sk, true);
+	psp_twsk_assoc_free(inet_twsk(sk));
 }
 EXPORT_IPV6_MOD_GPL(tcp_twsk_destructor);
 
-- 
2.47.3


