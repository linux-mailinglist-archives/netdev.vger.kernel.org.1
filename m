Return-Path: <netdev+bounces-221928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E97B5B525F6
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 03:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 852BA1C84151
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 01:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03B3221540;
	Thu, 11 Sep 2025 01:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zx/rhtG3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F25212B0A
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 01:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757555264; cv=none; b=a682xvHnrRsUwIQJ8/mFqP+oZs+WYzNUhFJ2PJIrTqP6/4QraTrK6s+5510hPNXT1oS8G7vI7FQxCM/a883iXw6Cd4aJhJsbgqMnF+o0yQlGbMP4yTkSl7FsRlN82G+LZ47/jXmyoeIRcK54t2x2R7ZliujizkQzfYHBclNBwBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757555264; c=relaxed/simple;
	bh=UK+FBLaw/SBKp7CfiGk9wNmBe2PBWw60Smrk8jo87YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNOpnIzcjvzkY3Hb6PS7IyUBSRvGw1dAX1ybaX1dAjiXwa5rjO2EaYAVPjwl+WY+ZawrEzpU1g3MWAIiIkjCHGHwsnylpEy4Ho/XnrOwnTVEF2tsm3FryAxpmzv20yQtd7fta3sQ/ylVYb+405c6jSHjRNSqP47bN+HPTPgoFiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zx/rhtG3; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-72485e14efbso1437647b3.3
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 18:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757555262; x=1758160062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaRxq4yLmEW6uGuW4a5X859Sdrrp2/z1N8un0kxNkTc=;
        b=Zx/rhtG3n3ogfyiffdP7EDemRV9Ia1Hv6Rr3f1qQ31Ztuwrfy/wuQ7LJQe++ZhyQRl
         hDTYQ7zkpCjWq4eDpsSjhqe+MwgoHj2fkcz2GoLg8yIi5T6MHBWihAz1lV684Eozecxk
         7840hyKslBPfiab2eU3NhyZPl3Ek2fuJM5e4nN6lA7OAtK1DggjORSdItZeS3iITK9aY
         nuc5Olop4NcPu+FKwDCeUnGsg+cWr9bw2u1LbV2trcFe3zkNiB2oATMUXEIqMipMABZL
         Z5YbL36lfaLeB7xB33mS7k6OHeCXtrgqQmLVwHs/NSET6ZDplcCOn9HoS40A5L4x5OzD
         Cjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757555262; x=1758160062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yaRxq4yLmEW6uGuW4a5X859Sdrrp2/z1N8un0kxNkTc=;
        b=SDRA24VJbqSjBOSgebCd+BBxNMPU+ZGMOATG3W7r9qYEDBUddhTRQvhzO00J70mWa1
         arfmkG1mSP+daq2m/hMt1mq+8IOVAWuV8fEmOe+TsfKf0+dUBm6elC5JwkuNgmW96PFF
         MWEIpbeO2kk9ko4Q5rqKfpsZHLrVz2IF6HQ3ZH+XPUzVOUnV/1ZEg9UnZcGCZbzPVHdL
         MzNxwcgqpkCiIfpO7yxgiEN79FTwAwu/rHlx3CCaiif/EovXwZMhlnnEKjrRcGuhQvP/
         O3+F4HBhb8nYV9z6OalP6JoqS3+GygzXuShhSr2WvOYg9jwtXT4JgVTFcUqRGWNg4UEH
         VH+g==
X-Forwarded-Encrypted: i=1; AJvYcCUGsaIH2PWtDVLueMohimmpaGCG4FsE4awukPjxy6Wh/sPAFe8Dc9uqM6YrLVlFQ9rDddI7V6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjhdfj49fdLeZUIeUP/M9Wt0E4mDyrbvdNKm6URLMecGgDzyoi
	oOKbx3TA2S9JY+8V2xxLjn1giQve7WzdYqEniXYIq4HCfDirvIYsOB5v
X-Gm-Gg: ASbGnctDaa8VLtdb/6odeNGu34V1CsAMO5UQuyoDMVhSHbcHMiZrjRu9MBz8EbvG7H+
	IqnQS/+kSDgaYy/k6uH1cIwhWQh5CGt4RNYRBM+2kg24yXHkrwrbrwn1UyGPKNdT85MBgcOs9rk
	o1xpzsQX6akAji9YqDuRAAJeAnKYFHIPVa12IJ5kqAzceuOoxSoBXrPJY/BEiaD2jvUgr2E7ioz
	qqWTR60OUMIwNlwkZiCrTptoldixi00/8FTkAsNTPR5PnVaHMSl50khBoGaQ0AH3F3JQqVfqv9k
	lT8s13UQ8PUyXFTh+0mDKRU6FZCMQgB1nJzPHDps6ZIbW2tKnNCrfs7A4UwfdIheeOfLkKoAndv
	iZy65RbJUD3P9fxgaOq2ag+YM4ts4Plk=
X-Google-Smtp-Source: AGHT+IFcQpmomxH+Q9ub4Kzz3ezp45szEBni/3rSEZv6T61NNSSYAOyYU6L1HANqj7HKr5a5paycDQ==
X-Received: by 2002:a05:690c:9c0f:b0:71f:b624:323a with SMTP id 00721157ae682-727f32a24e1mr169374997b3.22.1757555261932;
        Wed, 10 Sep 2025 18:47:41 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:42::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f768313c6sm378157b3.22.2025.09.10.18.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 18:47:41 -0700 (PDT)
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
Subject: [PATCH net-next v11 03/19] net: modify core data structures for PSP datapath support
Date: Wed, 10 Sep 2025 18:47:11 -0700
Message-ID: <20250911014735.118695-4-daniel.zahka@gmail.com>
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
index 896bec2d2176..ca06430d5145 100644
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
@@ -457,6 +458,9 @@ struct sock {
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


