Return-Path: <netdev+bounces-201169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF55AE8537
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 15:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2EA83A8A9B
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A796A265626;
	Wed, 25 Jun 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4b1MWLc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA00264A84
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750859541; cv=none; b=iKsDuONDXRndf6F6I3CzE4Dth3+2+043QCAG/MVjTt5TW63dpFDjIaWGW5fMza6Nv3Pgg49e/uQuIptflon+S2qXmC8elR5YlYeBRtISeTUa+UBlqLZjhr3WgIDjNNjzVox6gFYTeIyqr8/xl/fmYcDJ6LrqztR4TkLi28FqB8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750859541; c=relaxed/simple;
	bh=ptMAeViSGCRDoTWQhUEaxLpbXB1WClAj46dfLTIdSBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MSWxz2urEgNitUFi7qatTE02cTnPCo174Pw6R/f849ZiIXckX/kWz4qvlE6qAqIhByLHiCAKAicVWzMm2UG1zksVaqyrLa0QJTesztDD/jKf5ca7guSiKLKFdSPUxZcIxN+cL7IRtsml7YRwYT4Ik/VRxXmV9aCaorwdl7hMJNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4b1MWLc; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-70e77831d68so65187937b3.2
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 06:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750859536; x=1751464336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WFoerQ1r3xnvC4jQ6iKljaZ0Eqa/LDw3/egTokvgYA=;
        b=j4b1MWLcomO7yKsjmr1L1w2+4Ve3iSPhxQxpIc8gQQRu3OGZJHT3XPV6BC0druy9T7
         L2pI5J/N5q+TMgrs65G9u/pwIM0lNiUdZaUzNyy9YPNhG0v94JFr59xd+uUcmbWh2Ii5
         +3Ei4MRqNRsnZWWDcJjdFuFKcnGUap4p5QbNNbv/uegbASEggc505vBOXBGm5I1B7MXs
         s9fymCj50qp2FekGKV4jegjhS2ePlxvaooPrL9mvn+MGCFbh+Mo3HbiLnKd9yKN2Qo2e
         T52bFmCHqJx7q5yuiejAH0S54t6fIqYgelOREBXz1Tjtaja9+zQEXVio4eSjLe/U88pu
         dNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750859536; x=1751464336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WFoerQ1r3xnvC4jQ6iKljaZ0Eqa/LDw3/egTokvgYA=;
        b=FmEXSrFifV3L0MqttjjeaSy+q09+SJTlv/hbK2aVaauu9+0BNcDrUx1YPsyudhSZ0B
         wUhiab7mhsbiB5XjDBGmZN3twIRfYKwkYzXqFEWIPT58XKV/LmhZ/1y8Q5dJFT6vbDiH
         tZwmPra6xOQ2PqwB5kaKPskaqfqr5Yr2W4QG635U+H9iE55bh+XRDJz2mgYcfqlxo2xl
         QJSQGj3ABbvCMSkU2IkYueJ/ZyfJCUgjHhfIPgOKP+Wvv2uSO+Yc2VnBEAW0FEXxOu/U
         Gj+d7aX2yqw7uZ/bu6fMC1fNrU5CqexMp/ahzrKqu4mEAAV+rgQon3IFtqt1Ji29FLbf
         0ovw==
X-Forwarded-Encrypted: i=1; AJvYcCWsEBLhO2XMkBeb8E9BvMozHoPWZLJ66Kv8frh7X8VEUwVzrKEQADITBGr+jAsvzMtUpMc4xno=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/4iH0BaeINpi2rbeQ6683NgCtnqArMIArDpkTcp5R2d4IlWZy
	in7tDqC+v6fsC1MjSVDAoR2AFC3YMrUpqVEIdJIeyXijG4xmp3UXnvsc
X-Gm-Gg: ASbGncsWBTU9z7OPPuqLYgc+4q3zumg8ZNDTq1oiU+L6EM6WR5lPnP6X1NTtTtkab9F
	DSjsrlCVBeAmRlN4Lj+8ohex6mm0G13CRu9nvs69Iqot6sW7vpQx/n5JXrpblr6XnygSQTjNDYj
	/yuDVbCcLLRZDS4O0kCGFbmHabTTRv5vqbN67nXXU0zhTv7/BC4ooIyW0KgQcsROkkwpTJkMWJ6
	ZYiXLY1nPDnO4HiIc+6+l92RvM4BIJr6DWQdEjP6jMcOIX/zdIH/RwPsewLssAXh+FiiFwXhjz3
	7f1oK4qbw7leKl8NXkOLPu+bGwr8unP8kgDk7tvI2fLbsuL5iHJ803FAf1Y=
X-Google-Smtp-Source: AGHT+IEyNI1rHg/qQeRaytxl8jjZ1H7jh0bHoUHlSPrVt9Ku6xR1yAd7vtqafvb+jE3qaZv3VrNymw==
X-Received: by 2002:a05:690c:c0b:b0:70e:70de:64f6 with SMTP id 00721157ae682-71406b73a41mr41395437b3.0.1750859535555;
        Wed, 25 Jun 2025 06:52:15 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:2::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-712c4bdc533sm24305637b3.85.2025.06.25.06.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 06:52:14 -0700 (PDT)
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
Subject: [PATCH v2 03/17] net: modify core data structures for PSP datapath support
Date: Wed, 25 Jun 2025 06:51:53 -0700
Message-ID: <20250625135210.2975231-4-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250625135210.2975231-1-daniel.zahka@gmail.com>
References: <20250625135210.2975231-1-daniel.zahka@gmail.com>
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
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
Co-developed-by: Daniel Zahka <daniel.zahka@gmail.com>
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


