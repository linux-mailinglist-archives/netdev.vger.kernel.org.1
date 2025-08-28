Return-Path: <netdev+bounces-217907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4366EB3A647
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 18:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6741C3B8612
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 16:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77F4322DCD;
	Thu, 28 Aug 2025 16:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djhEfWFJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C852322DA8
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398601; cv=none; b=UlutK0bz6htFUy0LaE8iTTnROY3zO8f1iiydx9qrNArbkVeA2goVevS1hRkUszUjHe2EH1Bw6uDObsjAaIhufnk8X61X17uBWdAJaXXS8HjNJ97vPwOv/BXTvudufD9i39cPeuLNn2EwAob4L+lodqQJuA0VVTvrTJcOg6tFFkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398601; c=relaxed/simple;
	bh=fzdms5W8EXOTXKpDeR+oXsKGzMxJdqqu+0L/Ie/IIB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWDroJoresDD/Gfege+TZqB0pxjSAFnxlxnE+94SUE9vY/iyNhiXzZVuQ/sb1EuZAovSK9MUj5yF8QHQ9s4ju3EYYahXnfac7nzkdWjp+l0Yji8N6sbImixJFNJBdfia0wDMY1/MXJC0aGc2Jc5X8ZjnNQ02BiRqZZJzo5R8X6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djhEfWFJ; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e970599004aso484637276.0
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 09:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756398599; x=1757003399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWofgV7d8FNU3Gsejbp2vzQkRbIPWDYq5iBETtPry6I=;
        b=djhEfWFJIJZahd+q2Ar+O4l9pIziSJGCLj2cMAo1xoZ7q530C1q1It27K4wWIZrVF6
         t4l7HQFpwRPvXZadTwJFVW1fZSY2hTlNCLC/gaTOMkA+uak1vZbz/m3riNeWxW0g4az8
         g1L6ws43Ol9IkTes2AQt80gNBr3RpJ1YYqQfSTM/Qxj4VjzExuLBrffPmyb0MA+Mgltr
         AMxWZdE41NMNyI57bVTTWUEVBktuiPS5yF2XKdHYYZn0jbI8cwQoerFYa4Gbx+1Xzssl
         68sIp+45IbGZn6R76LVxJHRcMW+p4IFa7nyqMj56aPW+NWDOBIJOazi+6tuPoERoY/vU
         d6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756398599; x=1757003399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWofgV7d8FNU3Gsejbp2vzQkRbIPWDYq5iBETtPry6I=;
        b=OST7ebNgmQTHRetOqwTCg+HRrkb1y0i7slbU0lSrKAL/vK6lMzK4ExSHDGWO0v+A4B
         OWbqEO4UjPOjB3JYV1AmN9+gH8vZp5aFNxb+NDfUD2ZQPTStIgYXFImw+kmJxwoGmtCj
         iez51Wa+jvC/n7wHGgM5P2I/glTf6LrK6Ap7X0iQUgJxsg3MYpocHQwHQrOLrbcUkk+6
         6LjOKyVATSPvSW55IoQABehqk5bQUgnPXBBe/egUNa26o5YKq2KLwxAyjNDZsx/2fwGx
         qTVC64P1HEBITEU7Nd1SDA0esIPlLFAB1dH52gkqeLAYdoGtRcBPJIj6ZFuG32y5AI+0
         Z76g==
X-Forwarded-Encrypted: i=1; AJvYcCWeA8r84JahvJM66Db/axNhmwTPD2seUY1NPbJc+U8+h8zR9WyHppWPDPWOT14UG2kib0O6a/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoNb/6VDHL7N4LW+pHJYoJgjPPKi2MdjcraECHTwIZPYRAWCx/
	NUY1+ymqtNI6QCQPzG1VmEtMot4uBK5GI6WzUVfQhA0gEc12EslilC6v
X-Gm-Gg: ASbGncvC2yZMcWgkxz3pvqRvB88bxBQigAjTuCSlFyMEHeuXfg3pw67O3vZDBrO8hhE
	8sRVvu4hglRTcnCh3GyGHh1s0Vx7rsxZlED/p/jSELoxjD/DAtgC8b1RAeVZroeZmu1mxTnZnLi
	yX9KSzEfmgiz2RzfI4DZYSlshHdziI5W6thzXp/cWzSPPlGxbEc1offRwS5dqIhX12DprSHMnqZ
	ATN83JxqzVScvn7m5pjhkI6JsBNvhJ2f0HVp5Wd9tc3bTDzhRmb4hPGsRDSSoBJtJvUbp3AOEx4
	p8ca3V+y9cKmrIt5OImi+r/Rfi7eU3HPyEUEjULrsDh+lpBRK1L3+7j9Ogv3OjwHVEsZrU4G7Wv
	Tvgn55drw7ugFdXFrv3Q=
X-Google-Smtp-Source: AGHT+IGRPgvuKSF/FdwL0avbsM8MI0PPPF0FF1bvP8I4+I5LFHE2cU++DUf89GSPYp+RbCcdHOXViQ==
X-Received: by 2002:a05:6902:2a8e:b0:e95:2eea:a24d with SMTP id 3f1490d57ef6-e952eeaa4camr20309439276.32.1756398597948;
        Thu, 28 Aug 2025 09:29:57 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:2::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96ead08b37sm1870552276.21.2025.08.28.09.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 09:29:57 -0700 (PDT)
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
Subject: [PATCH net-next v10 03/19] net: modify core data structures for PSP datapath support
Date: Thu, 28 Aug 2025 09:29:29 -0700
Message-ID: <20250828162953.2707727-4-daniel.zahka@gmail.com>
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
index 73cd3316e288..6f47fd10e413 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -254,6 +254,7 @@ struct sk_filter;
   *	@sk_dst_cache: destination cache
   *	@sk_dst_pending_confirm: need to confirm neighbour
   *	@sk_policy: flow policy
+  *	@psp_assoc: PSP association, if socket is PSP-secured
   *	@sk_receive_queue: incoming packets
   *	@sk_wmem_alloc: transmit queue bytes committed
   *	@sk_tsq_flags: TCP Small Queues flags
@@ -456,6 +457,9 @@ struct sock {
 	struct xfrm_policy __rcu *sk_policy[2];
 #endif
 	struct socket_drop_counters *sk_drop_counters;
+#if IS_ENABLED(CONFIG_INET_PSP)
+	struct psp_assoc __rcu	*psp_assoc;
+#endif
 	__cacheline_group_end(sock_read_rxtx);
 
 	__cacheline_group_begin(sock_write_rxtx);
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


