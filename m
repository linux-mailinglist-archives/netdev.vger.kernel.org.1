Return-Path: <netdev+bounces-216623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9440AB34B57
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 22:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ADF93AED64
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 20:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8F53009E7;
	Mon, 25 Aug 2025 20:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6nScmo6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2128C1F09BF
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 20:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756152099; cv=none; b=Pr/s+oKIxiOYxQWt2mxzwG4Smxu0QTRWjOjLMmAemn6Y67wtpvJrAonaCoMExd59p0I4YHb0bub/nzHGkDktYE2DCcjX4VSTcqh+rgVXl1Qh0UfbkpPTZXNEov+lhm6Kpiwazms8cOsV8H7N2Ga2E5yGmrfX7P4MYjSlyIo30Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756152099; c=relaxed/simple;
	bh=Q/3uG6wx+KiLadWfnC5lQu7gF9hhqwvwQlFWTIP28qA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxhosKsEECv/g7r64W0KHbOl0oWAOYJzqYdyXjyk/bhnXAp5iSwHdT5pmuOUlvuHL1dfYc9n7xJpuGpUmRqoEVOBLxY657R76FNSxcx4FUv2PPsXBUl28s8jpGENv2xr1mhWSMY7rFDr6qS2SJQ2G2AsaGqoP4ZMhR0WCqbHFEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6nScmo6; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7200a651345so15446477b3.1
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 13:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756152078; x=1756756878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ppFSC+cu48kV6+OrLbJJgP18LdCX9jlB+a+WruA0xw=;
        b=T6nScmo6sTwuDiKApacXv4+0kYs6Pa2wKy5GWuhidYO9yv9pcwYlq9Tvs/LEVzEsoX
         8TADl1iqGyTN3uHs4HJmeERLXep+qt3mjnDB+ogLzUg9w30JFB6ojH88gbfTc0/1l7pI
         Vx/QWN/23C2B+8XoHvwbDwxpo0DszxIURveKzi3SV0caMBSe4HJOV13EEPSS7GOiEUCb
         N/Ub7GicUSsC5cF3ibhot3IsFW4Vxxmz8b0Vm3JaGrxnH/lOe1drhQ5sdDBwNA4lLa6+
         EEUg6u0zlJLFga9wlWJ4/AGueIaOcZfrVqaMJrNlbQvxANAs+v30aQ1+xSPlwTKDOF7x
         wHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756152078; x=1756756878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ppFSC+cu48kV6+OrLbJJgP18LdCX9jlB+a+WruA0xw=;
        b=ZEIrXu2eoKypJmE7/7DVEv/kJZK+Drr+pXR8sOpfSPF+wpPCknjy1+gvG7ez+5YgQq
         0z8oO0W6cw3Y8y0IHXYAIpIKs41w6yHfQulLAacuavKZW7awZ6DM2XZKPHSpRCVWGoF3
         IBLno+j8G97VQVbeV9BUYEgvOLXgLM/51nKVhTfw6JVSYkZjDRDJ/RM9B8wRHRCVL9Cf
         l61+CkbhJRe5CeCzGspFxuSFgmNF07KRysdrUdqxzIWwJ7JACkWcrbo0QJRm6o6N19UN
         XzNBQPBpCZMn/L8stT565i5STuES13seXiU7Qepr+EsAlikUE8es19xRffIYd5McDuZy
         9bDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiLQbjOguwi+VDqRsoYQgLXTw0dVfV3YTNkmrGVN8l1s/WtGABgEsMY1LcAfb64EDcMlW1VPI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy1kt2Qv/OpPUGJNWXzvHbJD/7fhSKdQQ/qxLK0KKDS7upTJw9
	u7WQXdDi3PX9wAEqQG8zkl2Cde8W6l95SZZFQvWleLpxi22c+4dYIYTj
X-Gm-Gg: ASbGncup8BGDeBGea0UOFa5HsGnvP8OEmb0LxurG3xbkMvp5ZM6KWAx+zF0apz0moPF
	UQQH8Viq0wtn8aRazHckTkAP8KSVMSC3Pccveslhw3N0qDPYKCfmXr7hj7JvbdT9weLSzFE3n/8
	N8GaDrgU0/9K2N0e3VZ7OsZS9xeeVWgTz0ClAjPJ00yn7EG0S2eQ5ejFv/kUMdg3D+D3/gMg5to
	OJXjWvfy3i6/tul+W1e86dBkGQZc9hMsMusvU/GVMWDgoqSk9qiiVcny4YDJFQmZxIPoidlx938
	ANt8IllEssOuWUHZWSobWRqz89ByO2UO8xwr5wMiisoGlMbEAZUkcyaXL8izKl7oNPdGXHYTMF3
	eHxzUF6nu3hhj+3AiprLQyKhcYNcabv8=
X-Google-Smtp-Source: AGHT+IEd5L6etpZqb1d6RPxPSJaxuJF2cUgnZuudiUzR4KcqT7KAcLy3kDtHvUTM6RoLUc1ciqen4w==
X-Received: by 2002:a05:690c:7005:b0:71c:1673:7bcd with SMTP id 00721157ae682-721265a77b7mr13273787b3.0.1756152078164;
        Mon, 25 Aug 2025 13:01:18 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:5e::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18ae99dsm19357287b3.54.2025.08.25.13.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 13:01:17 -0700 (PDT)
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
Subject: [PATCH net-next v8 03/19] net: modify core data structures for PSP datapath support
Date: Mon, 25 Aug 2025 13:00:51 -0700
Message-ID: <20250825200112.1750547-4-daniel.zahka@gmail.com>
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


