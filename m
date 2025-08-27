Return-Path: <netdev+bounces-217350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC34B3870B
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 17:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99BBB6881F6
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 15:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD382FF172;
	Wed, 27 Aug 2025 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5CC/zQo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED282FC008
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310027; cv=none; b=X6nhexYUHhoveguOb1iuPyAO3zV6Xzps6i0IEHXbLXxfEZR8RkeKk994eYpTHQbc/NUG/HA+8qrs+hkyHCIsfRkdrzp06sIpM4o0gMR6NCDbjYDXa6cVPFy/WxcmrfU7IQ3KEFRfzWqvWMkiPbuhhOZa1KOwAfnCXVa3rB1ZNa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310027; c=relaxed/simple;
	bh=wXxb3T+ojKcAOnkcnRiZIVSxq2WhvzhMfNUH/C0QFkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GjTpSpIPyeYaE5wuRjwFzSjxOjCCIz23K9kBqHMJRedqNqx4VyQT4Z2aYhWkrGLSh8GvH6j85hLx8yjytImMOCUfYH4qN4MS6kMbVUgSkbvEZTmkyXncHNpzPSx1goQgZ79NMj9fF23wX3z4zEYH27TOgqETJTxve/bJxtA/Qpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5CC/zQo; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e931c71a1baso10120600276.0
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 08:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756310025; x=1756914825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkc+Q1yRDGa9YbcIEK8b5kG1vwMNmj84EpwkL+jH+GE=;
        b=E5CC/zQoWHdPNfQskSiWy9I/KDBmkBaPp4LyIx8+GsEWmZH5F5w6CMlE9PuDY8w+0n
         f5ZyspyB9n5B7P4iTa1y/3l3+AlG2JtUUjxawfOgyuDpfcHCSTfeGDHogK2AYHutTByS
         repO6EhMAp2GQsneUaG8ESmSmYofwWXmAiHTYU2DeMRM8N7jveg1AXKhKNF5ppoUH3Lo
         PahMEmbytFaB5R5/6lboAPKGnNLT3jLQImqH01hCKCKaKXR+uneWwWXGQC/N6DeBbGuW
         8k60W4ghdjkTtIR36T0QsL0Nz88iie3G/M8ctqyR/Dj0ie70uPUHCG6SchxyizFqVM7z
         y4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756310025; x=1756914825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nkc+Q1yRDGa9YbcIEK8b5kG1vwMNmj84EpwkL+jH+GE=;
        b=t1bBGPrmJmqe9dhPkl7AMUBsUcSgxsx7/RYAQE56Z2gR4s0wE/C7sQw9hsLzWiEMZj
         0o4GHC/dvSb1lIz9SoPZwC2BC4e3yI+ZYed9Ayzl4r2K4bNHqHppEJyl36RKnjMCeSUI
         PqPLJruv1IfdJleVOVOVZux1pgYYrmxlp1hFodgPugphSTu9+5OCwF7cFbOxQRSCHobb
         VJygjgCry+KSSrN5wYE1F1cVwS4QcwVx64nl3gJridkQgzzjBUS3bVuUOjGFB8qgcn/0
         CcEkJuBDGb9nXqX3C5rbck7YSwP3v27iDjyotSL9jArSFxE5J8rPdF5A8iYAUvLe2HDa
         4/GA==
X-Forwarded-Encrypted: i=1; AJvYcCUy7+WemSpjVfVxIYI4rhfndi9Pc+hKOBwqDm6SB0ScUtBzDLe0We69DUvSdU12RSoglYggmOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YysU5j4iqEYaUCwIp4mCw54r6j/CWonDWuv7YZt0JqaUJkeEEHX
	rPoxHC/EF6RogV3x1XiFN33tq++CrQ6VSgVzeuRhuFPeLCwcHRlAmHcv
X-Gm-Gg: ASbGnctTAu9slJErxCNj4rkyTESqojR1FEcaD36R0biIJgtV8kX1gtjUdkNF6D5FWKn
	pca8i0tehmjpFGPrl/08/EtdDjjCYI4zZLD7AOmEktV++X5FYOcLRlJu3mRd1qZpAlvtfzvGbgp
	/evbyJQpdZsxg2WOHmVArfZnstJoNbLh1dHSA9TPTZYGn+j2vicy2ZcgODqqHd0gqwEkS9MZQ9/
	nDW2L7VoaGNzE3XrNAZ1cccsAQK6KAyt8WbEhZ/IDaPWCdWPdD0/KwD6Irw738Wu/8mWyZ6QsFh
	pyzo90dYIANXBSoAn9GY1Oi3vmcbqOqhHlACpPLYqctvKmmjZ/J9lDtD9YOOJ7Hr7skjQkHe4K3
	4ZpK1L7ZfKgeTi1q/7APph1skQI9Oh5A=
X-Google-Smtp-Source: AGHT+IHeC+qSxSg2XBEsEBcpVoz2t0RExco4KpqjXOQa8VwGLuKd35QrH01hyvV0yOY7dsz+sIOiQQ==
X-Received: by 2002:a05:690c:c18:b0:721:21f7:e987 with SMTP id 00721157ae682-72121f7f333mr95484487b3.51.1756310025025;
        Wed, 27 Aug 2025 08:53:45 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4f::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff188128csm32003127b3.35.2025.08.27.08.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:53:44 -0700 (PDT)
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
Subject: [PATCH net-next v9 03/19] net: modify core data structures for PSP datapath support
Date: Wed, 27 Aug 2025 08:53:20 -0700
Message-ID: <20250827155340.2738246-4-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250827155340.2738246-1-daniel.zahka@gmail.com>
References: <20250827155340.2738246-1-daniel.zahka@gmail.com>
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
index ca8be45dd8be..4b77b856f025 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4899,6 +4899,9 @@ enum skb_ext_id {
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
index 63a6a48afb48..e589eef6ce0f 100644
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
@@ -448,6 +449,9 @@ struct sock {
 #endif
 #ifdef CONFIG_XFRM
 	struct xfrm_policy __rcu *sk_policy[2];
+#endif
+#if IS_ENABLED(CONFIG_INET_PSP)
+	struct psp_assoc __rcu	*psp_assoc;
 #endif
 	__cacheline_group_end(sock_read_rxtx);
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 23b776cd9879..d331e607edfb 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -79,6 +79,7 @@
 #include <net/mptcp.h>
 #include <net/mctp.h>
 #include <net/page_pool/helpers.h>
+#include <net/psp/types.h>
 #include <net/dropreason.h>
 
 #include <linux/uaccess.h>
@@ -5062,6 +5063,9 @@ static const u8 skb_ext_type_len[] = {
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
index d1c9e4088646..17ecdbc66f05 100644
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
 
 void tcp_twsk_purge(struct list_head *net_exit_list)
-- 
2.47.3


