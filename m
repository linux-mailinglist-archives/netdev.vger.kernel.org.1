Return-Path: <netdev+bounces-223801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBD7B7C584
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 13:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C23B1188DDEB
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 00:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6B23C465;
	Wed, 17 Sep 2025 00:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjZZsz4O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021FA2940B
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 00:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758067802; cv=none; b=S3WzRUQl89/PCI4z8O9VDJ4xQh8R2KG0/8RdDd59KmHGJ6znbm8O/IudZyP99bgpbdT0Fce2DPStv/7mr9tt9tyS8hJSTJ+/4HWZ+KOgJEY3lRLEsMwbAnDzU8g8oFS+ZyqqjY3jGCz4tMHOB6lRYnsD3Dr+U89fKCcKu7fXFnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758067802; c=relaxed/simple;
	bh=h/B66IK5GcZH06XeRm0M4HrGtzt/Qdwo40QnjxDEsjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VcZRgLpLs3kl42hJNTzcjj1DaJ+iuEvZ33G6lqelMRI7L6Dxus1w0ZT2MyfUdiz72XPkWIGtRrwqTvIvi+ghRjZltRQ+wAnSUb3XJCWH8NQm/sTQmThbbUi4tJHd++7ow1BZw+QjNZxa+nRGSfCs3mniywsCsPiS/lCLup3OoRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjZZsz4O; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-ea5c1e394a8so7861276.1
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 17:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758067800; x=1758672600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAq+hrOstUZZrJLVxw5yV5l8qN3m95PXG0IM/nmYVvI=;
        b=XjZZsz4O9sfm2craJsYTZhUGIZPwA0rdkv4s/kVDnrRT2aeewICtU7VldIMDhPt2z9
         996kSOnhcBkTdN8+RFK0oFe2ZPQwTyAn0UpCUf6Y4b9yrv1jdT2i0eW+kp3KZwgiIs2T
         0TzbYHzxorTIQoYYEIRLtlIPZZ8FR9Y56Ut0NG8UTU82vZVIsP8ajlQ5KofWLxWtyiW6
         VWl1BdnPlwr6lElM8fuInGRB/c1c9b6SZvcnCEOPSDYMY8cm1T1BDGy+IH6XPTEBGRgk
         4ovE55zqR8HUSVzLOUlAC6ZiFj9gmMAppa/FT/8K3DHlcB0F4ga1pPjRqyfCofC3ZAIX
         MZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758067800; x=1758672600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iAq+hrOstUZZrJLVxw5yV5l8qN3m95PXG0IM/nmYVvI=;
        b=vEWGHb3tiuVNOj45N3gzhUmTdWqUgvuub2wilQP65MGw6mQA5A1RwjhxW0pJoLozA1
         T+vRoK4iUQ/CW6lBv96cd/yO0g7qblj6Z1aOHTEVRdfahqA/ZVdP2hiPXshAblV5HVAa
         azs/1T1V4wr5TiuxnVglJ9vSIUiX3FC7m0qiUA3LsCROxZOQg5QCP43ghslsRnJ5V7Qq
         U5ohamsNmgBjWXCap/krdjRp0KANcF6qN7xVM+PxEtq6PeLapPoiNsMrrm8mZM0cioF7
         drLge+xTOuEwKlNenXa0i4xORo+8sgKMQK1YJSLvrKf8RVxs18FuA53XaoUPRTg7R2kv
         X71Q==
X-Forwarded-Encrypted: i=1; AJvYcCXgsUMNcyjNKHReaYsWvJBG+APu9mXmJpCGfyV1slQdl4gepVkpAyK/z/BjTIo13uukc01zyFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH3B24cmfjXpV8NyUxin5sBGjN7IUCCrzDPkxUenwyVZ3+OS4b
	pbxlMnQn4CtfzzFvYciPv7E+FrC1qiFs6iSX8afgxCfN91Q+tJu3bmr8
X-Gm-Gg: ASbGncuLQHVssX7ztajL2fFafyzkHN+YvFtNY+Z8vNhPQLv1yXwHLKwX/Px+Fj82NAT
	6AT64fSbOkatPz1fE/Quter8jBG4HjUOCWHP8TYflGhC7cw6/6DWx4sY1uyB3fm5x9WbWT3VoB7
	lMUvlbRX0kixnSxwPWAJ3zBupT/sXugE7b1GTV/yQalIOV8Bp2H8Ec5SzofTMAdM+/nMBA/WqQQ
	SrERC2FqolGV4vTeK2sjfDacIs2m96H0IDh4u+kj2a6Fy6AUlAozVeH9XrX40t0oeOKGh9oAAxG
	H7Zt+4c2Tnjg0/P+xGPwNBFcQyDcd/QeMlf5hLfoUUmqwHZU1PsxFZf24Em/GqVGyNa7ICnmNET
	P+c8eWPvPQ/1xdhCpcl5vU8tBx+nN91w=
X-Google-Smtp-Source: AGHT+IF+yEHX4BNHAj297y3izncBCCcJFobnoZ5PRrpC86J8Y2XKswaXmej3KpJgsopu2faSgBeHqw==
X-Received: by 2002:a05:690c:9512:b0:730:c83b:e9ff with SMTP id 00721157ae682-73892067897mr1252637b3.29.1758067799952;
        Tue, 16 Sep 2025 17:09:59 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:45::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f791a5d77sm44464657b3.47.2025.09.16.17.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 17:09:59 -0700 (PDT)
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
Subject: [PATCH net-next v13 03/19] net: modify core data structures for PSP datapath support
Date: Tue, 16 Sep 2025 17:09:30 -0700
Message-ID: <20250917000954.859376-4-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250917000954.859376-1-daniel.zahka@gmail.com>
References: <20250917000954.859376-1-daniel.zahka@gmail.com>
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
index 62e7addccdf6..78ecfa7d00d0 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4901,6 +4901,9 @@ enum skb_ext_id {
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
index 0fd465935334..d1d3d36e39ae 100644
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
@@ -450,6 +451,9 @@ struct sock {
 #endif
 #ifdef CONFIG_XFRM
 	struct xfrm_policy __rcu *sk_policy[2];
+#endif
+#if IS_ENABLED(CONFIG_INET_PSP)
+	struct psp_assoc __rcu	*psp_assoc;
 #endif
 	struct numa_drop_counters *sk_drop_counters;
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
index 7c2ae07d8d5d..06d6491239db 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -23,6 +23,7 @@
 #include <net/xfrm.h>
 #include <net/busy_poll.h>
 #include <net/rstreason.h>
+#include <net/psp.h>
 
 static bool tcp_in_window(u32 seq, u32 end_seq, u32 s_win, u32 e_win)
 {
@@ -391,6 +392,7 @@ void tcp_twsk_destructor(struct sock *sk)
 	}
 #endif
 	tcp_ao_destroy_sock(sk, true);
+	psp_twsk_assoc_free(inet_twsk(sk));
 }
 
 void tcp_twsk_purge(struct list_head *net_exit_list)
-- 
2.47.3


