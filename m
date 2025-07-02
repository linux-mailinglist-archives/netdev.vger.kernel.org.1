Return-Path: <netdev+bounces-203448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E06B1AF5F9D
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 19:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B267483173
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 17:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D33030113A;
	Wed,  2 Jul 2025 17:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAQqyZDR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B21A301123
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 17:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476414; cv=none; b=JwJBu6LxBn/v6kALaCPOjVZGULY4nk/6Y4K58y1zKoqhildDHcR3P3hn7LBmuxITIOM0saDZNvbH9wMVnE02srBhPxDloPFUlhRWrwyQenqlHaT6UugNBB8c08BgW2KTrGgqQ80de26FYvXZ2/MAaRoqDrSeCi2XHh6Eo8S3tzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476414; c=relaxed/simple;
	bh=iDFtxwy+iWoIJaRizvX4SuL3uk5SoRX4aANGSbliKXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQILJhTwZRZaYOp2vnSxiACD8jogjH9Ud4mrd7wmtusiKGOMFESv1GdJKGnRjzyNzPa+rYELN4E7kvEzVc0AzgXnFXBv+j5nEfh4Sx27X0eaRui3E9pfis4kQ0UeEpKejBkKs6jV4TkfXHy4W3Joz1GKyGkn2EKowRKAB9ZV8dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAQqyZDR; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e7311e66a8eso4378486276.2
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 10:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751476411; x=1752081211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVzmXRtkepjAMphCsIzDdv46xD0xa/cRGlSolIORT9Q=;
        b=AAQqyZDRErd16LTb/2Dj0gk/QWUj20dpf9N4votqN4AUnvAZpOKDkQPoFXHRoE9vxi
         qbjKw2Bj9IdapE1FuByAOFvc8hqVk38Mz+SfIZjf2NZvqfpWY0cwA/bVQEUTGVvYqWwh
         Q6V6iJ+4PPcYaOY5gURmSKi5dU/4mBDqj1u0Y42nKngzQHtDWx0RK0b2prqO+7pAuldD
         FPd23qTUBH1g4qaZYnQXkULx1F69+zuOZEV/1eDsM1xBRLfslsOdBoc9TwiMzgQtVTE3
         PJgqlefyLTtR9tPpTkpu6lMmda70M8Bz8K4KiYEbNGixAfZTHjWLJp5bpWzm1cXxrt/o
         eBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751476411; x=1752081211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVzmXRtkepjAMphCsIzDdv46xD0xa/cRGlSolIORT9Q=;
        b=VW3wrmGtIqMZfP8XQhG2BskfSxhTFlfGNvS3xsVibiNRiI5EKRjWtgMpzyvb43CrvZ
         M9l5/4Dv1prf6kOCB5XdkFksN/Z0W+rHxGmvy/OakdpuM926UJ/WuR/bRh7IDPrsT1Jw
         srPZ/WXhMNNqrhXFMTzAP/OGzOAvadbJyrbI+y7d87buwAp7XWmhDdCa5wiQuAPOy8cr
         NPCfcx+G/2MUyhKe96pc9LB1d5VrMpxcWQttKk4Drr+C/DzBumkk4EQM87mjI3aeAlWg
         /28/CXXSce4u3Yks7ajCVVbhZni3Ok7zu14VWkX5/UWYVRiaa/3jbPaLMmZ5a/IMUONv
         RPVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVggvBjFMXuPWyxiexpCCrXPdNZMmQ4Z0FVRThpXUWjcfkZyEVAJfQBYAksb5036kyLytdHmYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxvWDBHZMZVckLJw3Yo3tyQfEct5gfd17CJlNtONMC4Ior0fs+
	/OlF6iJmOdSw+31xHP82VKBHE+5JDMv4YntCWflKLTKnPz53FsUDJ+5R
X-Gm-Gg: ASbGncvLOIwrZ8zuPlm30Xoiag/paJz7AstNLsnx8vIB9V6myST6Is88HknStt+fITk
	LNGLjuszB4NN1R6ABnCSmoeIMH6qmagG61z56z/hbFOupoM/rcaDNOTExfhzmrBMdchne94sIBo
	3ZyG0R2l8/wC/I7hg9DImvwT3Vpk2pvwsXgdX6/rIoJHCYPFdL++uzo+7Vyc850IUiwPgfG6QZ6
	0iIsnoMJ9y6bLh/wzEfkzCgFqGf8H7TsC7PxQd8O9qc3D20YAhFubPxe4f4p5DTB/ePK87T7rqS
	p3w6YMOUQKg0ixxK34oO9WTZN90HK8Gi/ZiyOKIR4DfCEtOIP/3oLWvfVtXE
X-Google-Smtp-Source: AGHT+IE/ADV73dfCC5HOM6TR9BD8WELaatDzwgNTp6hCjr3SBJHAsuUGpVHhV5GyPDu+msu16/slcA==
X-Received: by 2002:a05:690c:6204:b0:714:586:8486 with SMTP id 00721157ae682-7164d2c795bmr51022247b3.9.1751476411004;
        Wed, 02 Jul 2025 10:13:31 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:40::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e87a6bf1825sm3819964276.54.2025.07.02.10.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 10:13:30 -0700 (PDT)
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
Subject: [PATCH v3 03/19] net: modify core data structures for PSP datapath support
Date: Wed,  2 Jul 2025 10:13:08 -0700
Message-ID: <20250702171326.3265825-4-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702171326.3265825-1-daniel.zahka@gmail.com>
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
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
index 4f6dcb37bae8..0a9a3ce91226 100644
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
index dbc5423a53df..ba7e5c36975c 100644
--- a/include/net/psp/types.h
+++ b/include/net/psp/types.h
@@ -86,6 +86,13 @@ struct psp_dev_caps {
 #define PSP_V1_KEY	32
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
index 0f2443d4ec58..19a898846b08 100644
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
index d6420b74ea9c..689f7c6f5744 100644
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
index 43d7852ce07e..d0f49e6e3e35 100644
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


