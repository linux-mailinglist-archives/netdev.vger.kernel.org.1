Return-Path: <netdev+bounces-209498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4682EB0FB8F
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 22:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E59716AED6
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 20:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DF5237186;
	Wed, 23 Jul 2025 20:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1EJRHKl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA22236454
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 20:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302903; cv=none; b=rQjs+HCc7v5vRbMwm61zwjMutXdYo9p5cmuaJ5LOOiInCyFgPYPcA/t7/gldFZNUvLLHhG7ZyWlDEJ/HDj8wZ7dVd8MsgBSmpMxmQp3AmUNwU3ha1KxQH9NJD6UDwoQK20DJuM111iWCzbAwhYe+jLYK/rz0aVWhz7TQbY+D62I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302903; c=relaxed/simple;
	bh=Y0KHWKuQoBYfGz3M7eeIjrvzet36/ZhDz+Vy+AXcKwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7onI69v/xd2lFawQRHGERtsGVJYgwe2NDAOCuy2CECeL0wg/+FNoPlfqs3qF4nyzIb1fNqfNX/RM5Mpnj5wGtimATDMPjisNFgHdZAc5VWZwBMUHriFqqm2or4UBZqihKkzVr89OblXp80Beuh8dt/EZ0faAdP5SNx5Zjs1JfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1EJRHKl; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-70e302191a3so2999267b3.2
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 13:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753302901; x=1753907701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKoXF5iWTSL+YRmRsirX9AXlOV24qblPx9xDpZDep0I=;
        b=P1EJRHKlUEOCpq6kIZhm4IM2J6Fg10Z9tePZx8m3kAzk4sO3szBib17SZUJ1wm4mAe
         4D5TN1qaMhkNRChGz94Dy+f9rdPMjeZS8Y8Z9MRa5v+78+Gd32udiDe/13Eo2hd/mNCI
         rS+erwFkq1UTcNhF8c9BO8dBHSdy/JyiLfZLK0Lzt4y++gTe1Ux8/LuLlwGGrI6ms5K9
         VnLKicFMWEBgM+Ga2XOIaagx6rIkjNMbsk9dW2mRTCpb0Hf5mSSuDHCy3uvYee+z/xvS
         j1AK+m1/UZwxh+TsXRWETtrLCCmduzPHO0W7lNjE+JB2N4mGHuAEUYev7e0PhbP5kCEF
         HzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753302901; x=1753907701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKoXF5iWTSL+YRmRsirX9AXlOV24qblPx9xDpZDep0I=;
        b=Viu9slbUiVnNWyuFgJtUHSr8W3xH1s9dolfz1XMSLYjoa+1R5fXXIL3+bUu554opSl
         zdPP5I52H1VOYK8AHNjk+uBOOLN3I2/hRPIuKYlTaGbSLKjwM/m2kOZSNhz0R0XRhV7C
         QXawqqe9T4ns1/YYBKmpOYnhALWFsIS4rkbfPQ0NGBkP7GvljyuLHfztz+QfcAljIlUj
         3S8cF6wFX/tkxf9nJMoCo+eozNT8VRLanNBxMc8zMwWvmkkIm/AQiU5bk4sXL4GZVKyN
         3O7+xDRPY2MZ4KG0jPLCMfhywtSf74DlTIoF38gYpbFgbjq+/Kp/WZWcK83FZo0DSRMD
         6WhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6oWBmkWaGBjJPABYpZNSxy+Q2NEBQvLRXpKRglkskVGcqp0Dcu6RQ/kpTl9Xnw4/uRXdoERs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/55l6hHGUyykga/i5OH9jg3DWeE2ExF1yltJsZQ/dOlmXgg+J
	Ubzi4sDBa2E6zod02G0PpParYtcSSCnffQ/Tv3UkjT9I+zMWNVUHJKB5
X-Gm-Gg: ASbGncv1Oqrcy7YtqzPZ3PAvL7bdZY/NF7z5BkOj1d1B+JEF0YtdhZGB0vEhOC+h2x7
	Vy2s/66F3yOfNiPAeeiq88720Q6teHYNcUuon4qY7penEoCeQHrgLIJUBimzu+RjBmv4yxq3N3N
	yyZMNtLlAmXYHh1+kcx7KS+13TtqLsKLvetkZSLzr7VKXPak6CPo4gWUdxgqNPeqdRgJwsosETY
	Uj7KnlGHxvtpTKC/leRfwoFj+MsCPO1CuhHDJBBGhtqjMZtmffemUShLdTMuvt0imstX2Ku+717
	/k2tSEhopFvteRELFZ3rGvhhctnr3OcFIyOCLoszurlWOetJwFcX1IOAz44X8K/PxuM8JJvtUwq
	zXu8TEG20UhvAC9w3
X-Google-Smtp-Source: AGHT+IHHpzgfiE8XO3LX5w0aIK4wbFlIAYdbVv6xD4F1SvMArundQdQDvnafZLiFoSvcG2zhrZjxlA==
X-Received: by 2002:a05:690c:4a09:b0:711:16d4:60dd with SMTP id 00721157ae682-719b42931ebmr54332577b3.19.1753302899095;
        Wed, 23 Jul 2025 13:34:59 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719c95f188dsm657977b3.21.2025.07.23.13.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 13:34:58 -0700 (PDT)
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
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v5 03/19] net: modify core data structures for PSP datapath support
Date: Wed, 23 Jul 2025 13:34:14 -0700
Message-ID: <20250723203454.519540-4-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250723203454.519540-1-daniel.zahka@gmail.com>
References: <20250723203454.519540-1-daniel.zahka@gmail.com>
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
index b8b06e71b73e..237c6e452b71 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4835,6 +4835,9 @@ enum skb_ext_id {
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
2.47.1


