Return-Path: <netdev+bounces-221933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30016B525FE
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 03:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 971211C84669
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 01:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5852C22256B;
	Thu, 11 Sep 2025 01:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjOZz7UY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0F8241680
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 01:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757555274; cv=none; b=VEbg9i68g4UYs3a5R5eGKPQHOZ9FjX1PsUVTUz49FlH9xhbMDTJluE8iXiF0r1Gw/Juz1zFdUy9Qiy7Fb6MTM/tLnpAO5+/HKvQOX7ccGnpZA6Nyhsx2MJM2diLm0+qVunHbRZOZ4HA03/P0/NR+BMd7VwICgZp+VycB+NN1734=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757555274; c=relaxed/simple;
	bh=wlWZmIzREjUmFN9ez3TMWMB6ElECZsiZtNylCkPBqc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+3OWNYeg3wyOmHg/qTIbGWlcaVpYubfwIVbLBZ3r8Ze5tDujmnMVgA039RYyhDg/8LEMSVxM96UCxEiHbZa873+GVGcBu/pNgHnZkRvSN22Yx0YQwSlClafms5wfUC37Q5fvZRpcuwQNR+8CwcTKC6vUvW3IxMn9a+XbGMsnTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjOZz7UY; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d601859f5so1939097b3.0
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 18:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757555270; x=1758160070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DC2NEHUi+RtltCb2D1tSeGnaPmsU99CaS85avtI5hzs=;
        b=TjOZz7UYfMiYMLAZmgYCTYJSrKWIwtJI4Oy6hSFsJMhCHaSKEiRH0qWZpaMdKmzptD
         Mmp4Wmq3Etfl4FyCy0NufmSYfe7To8CqFPqSrQ5bFTUSGRTBMVpSl6BbC6HI/OLdAyv2
         uSoP+HovMvOEF8xg6QpP1Y5zD751tH1j07dHsKPMLsb7ocN50/I+vcXDquxpqep8Hfff
         XSFKCFnRsrvSoDuxbVepCbYnS6YhEbPPMmZIffz2N4Z0sZK+52l8rLef2xXkQRWYNKVD
         zy+M4vAkG0MPBguDRohSZ1KeJ69d4mzsTyT1Yzo9RI4TmIzfSvG2PXd4XarEeki4M2TT
         10UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757555270; x=1758160070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DC2NEHUi+RtltCb2D1tSeGnaPmsU99CaS85avtI5hzs=;
        b=H1Oj15Qi1qQ86Jx3ZlLzvnVSEe6XhrMPNAbl3ktR2lR7JuF92Slhm245G3x2UhUm/0
         IY/d4hXRA1pCijnDdAlRDbJi2VlFBrYVAkdv/qsWXsaVAmUFLgjmn+Zvb/lcMswbJwxS
         NLIXtSbewNl0PDSqDBYgyMD7x8OXkpIAnU5HdabtnWN61srDSaXfbv51uVzZGq+E+jl7
         4XLrAXIg/3KWNFcfjxoG7NDD1e6GQhzLA0CDep7u7z2KI9dQv2ExZA48mYib0uZ2ziWq
         DQbB+s5M9rjMehpjORG4V6MlZ8LXoxIdtOR+1W+vptvxY0CMV54OCzoFs11jnsmhU4qa
         DYkg==
X-Forwarded-Encrypted: i=1; AJvYcCUG1KjYLDsrylLOEqKzVOXRIQOhydddhRjlZ9+pmuMi/nhC4u/SnZ9K5Xk3MYHTgOPSJw9szzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3EZygm1gYPEg2TL9cBGo7MfMJ5+7cvCUkwShpuM1+TAFa0q1R
	r3fIWlCqzMB1LdHHnlTBmjMfSUzi5OEL5ZVaYnzVwlJXk9fe5ydRu3JT
X-Gm-Gg: ASbGnctr79bkN/kN0rR65j/jEAzChsCERZeEzS7Q/XDrkUsCl8amYrXcq9kEmibf+SS
	R14TqXgHDXoDGpWX7R0DFyDvrBkA9bfL+ZNgRjajDfqOGPkUDUzg2RX85t1+kTFl7rcz0WYPVOx
	l8QJam0CK019a70WhXTqGmka97xIR8AYPP5PxXNtWamhCW/RujGAfd2YNq2OlWQLwlrBLaAPXIR
	pbsQaN38FVW2ILQKnjUvDIymyp3uYMoif1muo9hqxxB1aYfs5xqz15xOFcetV/0uVNzFKu40tN8
	V0UD0/PYo+wwvb++nUcFkD8ct0eMoWB9Pdzdd8eE0PAtoGrERPyOmctZY0Bf9/F9+1DpOQrkene
	9diomxbUJRF7y4vC3suan
X-Google-Smtp-Source: AGHT+IHJFgJwYxTU3BayrAGEt24qSCQ4dHlMWd/Y6r/lSIDPOT5/eRZTScy206LwZSxqKTntZXFzpg==
X-Received: by 2002:a05:690c:62c8:b0:721:27f8:7ab2 with SMTP id 00721157ae682-727f553e44dmr167672297b3.39.1757555270042;
        Wed, 10 Sep 2025 18:47:50 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:56::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f79a8c8f7sm306797b3.69.2025.09.10.18.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 18:47:49 -0700 (PDT)
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
Subject: [PATCH net-next v11 08/19] net: psp: add socket security association code
Date: Wed, 10 Sep 2025 18:47:16 -0700
Message-ID: <20250911014735.118695-9-daniel.zahka@gmail.com>
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

Add the ability to install PSP Rx and Tx crypto keys on TCP
connections. Netlink ops are provided for both operations.
Rx side combines allocating a new Rx key and installing it
on the socket. Theoretically these are separate actions,
but in practice they will always be used one after the
other. We can add distinct "alloc" and "install" ops later.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Co-developed-by: Daniel Zahka <daniel.zahka@gmail.com>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v11:
    - move psp_twsk_rx_policy_check() into psp/functions.h
    v7:
    - check that 31 LSBs of the SPI are non-zero in psp_nl_parse_key()
    v6:
    - handle failed allocation from psp_assoc_dummy()
    v4:
    - fix EXPORT_IPV6_MOD_GPL(psp_reply_set_decrypted) semicolon
    - remove version from netlink rx-assoc reply
    - remove key_sz field from struct psp_assoc
    - rename psd_get_for_sock() to psp_dev_get_for_sock()
    - use sk_is_tcp() to check sock in psp_assoc_device_get_locked()
    v3:
    - lift pse/pas comparison code into new function:
      psp_pse_matches_pas().
    - explicitly mark rcu critical section psp_reply_set_decrypted()
    - use rcu_dereference_proteced() instead of rcu_read_lock() in
      psp_sk_assoc_free() and psp_twsk_assoc_free()
    - rename psp_is_nondata() to psp_is_allowed_nondata()
    - check for sk_is_inet() before casting to inet_twsk()
    - psp_reply_set_decrypted() should not call psp_sk_assoc()
    - lift common code into psp_sk_get_assoc_rcu()
    - Fix exports with EXPORT_IPV6_MOD_GPL()
    v2:
    - add pas->dev_id == pse->dev_id to policy checks
    - __psp_sk_rx_policy_check() now allows pure ACKs, FINs, and RSTs to
      be non-psp authenticated before "PSP Full" state.
    - assign tw_validate_skb funtion during psp_twsk_init()
    - psp_skb_get_rcu() also checks if sk is a tcp timewait sock when
      looking for psp assocs.
    - scan ofo queue non-psp data during psp_sock_recv_queue_check()
    - add tcp_write_collapse_fence() to psp_sock_assoc_set_tx()
    v1:
    - https://lore.kernel.org/netdev/20240510030435.120935-7-kuba@kernel.org/

 Documentation/netlink/specs/psp.yaml |  70 +++++++
 include/net/psp/functions.h          | 114 ++++++++++-
 include/net/psp/types.h              |  57 ++++++
 include/uapi/linux/psp.h             |  21 ++
 net/psp/Kconfig                      |   1 +
 net/psp/Makefile                     |   2 +-
 net/psp/psp-nl-gen.c                 |  39 ++++
 net/psp/psp-nl-gen.h                 |   7 +
 net/psp/psp.h                        |  22 +++
 net/psp/psp_main.c                   |  26 ++-
 net/psp/psp_nl.c                     | 232 +++++++++++++++++++++++
 net/psp/psp_sock.c                   | 274 +++++++++++++++++++++++++++
 12 files changed, 854 insertions(+), 11 deletions(-)
 create mode 100644 net/psp/psp_sock.c

diff --git a/Documentation/netlink/specs/psp.yaml b/Documentation/netlink/specs/psp.yaml
index 054cc02b65ad..944429e5c9a8 100644
--- a/Documentation/netlink/specs/psp.yaml
+++ b/Documentation/netlink/specs/psp.yaml
@@ -38,6 +38,44 @@ attribute-sets:
         type: u32
         enum: version
         enum-as-flags: true
+  -
+    name: assoc
+    attributes:
+      -
+        name: dev-id
+        doc: PSP device ID.
+        type: u32
+        checks:
+          min: 1
+      -
+        name: version
+        doc: |
+          PSP versions (AEAD and protocol version) used by this association,
+          dictates the size of the key.
+        type: u32
+        enum: version
+      -
+        name: rx-key
+        type: nest
+        nested-attributes: keys
+      -
+        name: tx-key
+        type: nest
+        nested-attributes: keys
+      -
+        name: sock-fd
+        doc: Sockets which should be bound to the association immediately.
+        type: u32
+  -
+    name: keys
+    attributes:
+      -
+        name: key
+        type: binary
+      -
+        name: spi
+        doc: Security Parameters Index (SPI) of the association.
+        type: u32
 
 operations:
   list:
@@ -107,6 +145,38 @@ operations:
       notify: key-rotate
       mcgrp: use
 
+    -
+      name: rx-assoc
+      doc: Allocate a new Rx key + SPI pair, associate it with a socket.
+      attribute-set: assoc
+      do:
+        request:
+          attributes:
+            - dev-id
+            - version
+            - sock-fd
+        reply:
+          attributes:
+            - dev-id
+            - rx-key
+        pre: psp-assoc-device-get-locked
+        post: psp-device-unlock
+    -
+      name: tx-assoc
+      doc: Add a PSP Tx association.
+      attribute-set: assoc
+      do:
+        request:
+          attributes:
+            - dev-id
+            - version
+            - tx-key
+            - sock-fd
+        reply:
+          attributes: []
+        pre: psp-assoc-device-get-locked
+        post: psp-device-unlock
+
 mcast-groups:
   list:
     -
diff --git a/include/net/psp/functions.h b/include/net/psp/functions.h
index 1ccc5fc238b8..0d7141230f47 100644
--- a/include/net/psp/functions.h
+++ b/include/net/psp/functions.h
@@ -4,7 +4,9 @@
 #define __NET_PSP_HELPERS_H
 
 #include <linux/skbuff.h>
+#include <linux/rcupdate.h>
 #include <net/sock.h>
+#include <net/tcp.h>
 #include <net/psp/types.h>
 
 struct inet_timewait_sock;
@@ -16,41 +18,130 @@ psp_dev_create(struct net_device *netdev, struct psp_dev_ops *psd_ops,
 void psp_dev_unregister(struct psp_dev *psd);
 
 /* Kernel-facing API */
+void psp_assoc_put(struct psp_assoc *pas);
+
+static inline void *psp_assoc_drv_data(struct psp_assoc *pas)
+{
+	return pas->drv_data;
+}
+
 #if IS_ENABLED(CONFIG_INET_PSP)
-static inline void psp_sk_assoc_free(struct sock *sk) { }
-static inline void
-psp_twsk_init(struct inet_timewait_sock *tw, const struct sock *sk) { }
-static inline void psp_twsk_assoc_free(struct inet_timewait_sock *tw) { }
-static inline void
-psp_reply_set_decrypted(struct sk_buff *skb) { }
+unsigned int psp_key_size(u32 version);
+void psp_sk_assoc_free(struct sock *sk);
+void psp_twsk_init(struct inet_timewait_sock *tw, const struct sock *sk);
+void psp_twsk_assoc_free(struct inet_timewait_sock *tw);
+void psp_reply_set_decrypted(struct sk_buff *skb);
+
+static inline struct psp_assoc *psp_sk_assoc(const struct sock *sk)
+{
+	return rcu_dereference_check(sk->psp_assoc, lockdep_sock_is_held(sk));
+}
 
 static inline void
 psp_enqueue_set_decrypted(struct sock *sk, struct sk_buff *skb)
 {
+	struct psp_assoc *pas;
+
+	pas = psp_sk_assoc(sk);
+	if (pas && pas->tx.spi)
+		skb->decrypted = 1;
 }
 
 static inline unsigned long
 __psp_skb_coalesce_diff(const struct sk_buff *one, const struct sk_buff *two,
 			unsigned long diffs)
 {
+	struct psp_skb_ext *a, *b;
+
+	a = skb_ext_find(one, SKB_EXT_PSP);
+	b = skb_ext_find(two, SKB_EXT_PSP);
+
+	diffs |= (!!a) ^ (!!b);
+	if (!diffs && unlikely(a))
+		diffs |= memcmp(a, b, sizeof(*a));
 	return diffs;
 }
 
+static inline bool
+psp_is_allowed_nondata(struct sk_buff *skb, struct psp_assoc *pas)
+{
+	bool fin = !!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_FIN);
+	u32 end_seq = TCP_SKB_CB(skb)->end_seq;
+	u32 seq = TCP_SKB_CB(skb)->seq;
+	bool pure_fin;
+
+	pure_fin = fin && end_seq - seq == 1;
+
+	return seq == end_seq || (pure_fin && seq == pas->upgrade_seq);
+}
+
+static inline bool
+psp_pse_matches_pas(struct psp_skb_ext *pse, struct psp_assoc *pas)
+{
+	return pse && pas->rx.spi == pse->spi &&
+	       pas->generation == pse->generation &&
+	       pas->version == pse->version &&
+	       pas->dev_id == pse->dev_id;
+}
+
+static inline enum skb_drop_reason
+__psp_sk_rx_policy_check(struct sk_buff *skb, struct psp_assoc *pas)
+{
+	struct psp_skb_ext *pse = skb_ext_find(skb, SKB_EXT_PSP);
+
+	if (!pas)
+		return pse ? SKB_DROP_REASON_PSP_INPUT : 0;
+
+	if (likely(psp_pse_matches_pas(pse, pas))) {
+		if (unlikely(!pas->peer_tx))
+			pas->peer_tx = 1;
+
+		return 0;
+	}
+
+	if (!pse) {
+		if (!pas->tx.spi ||
+		    (!pas->peer_tx && psp_is_allowed_nondata(skb, pas)))
+			return 0;
+	}
+
+	return SKB_DROP_REASON_PSP_INPUT;
+}
+
 static inline enum skb_drop_reason
 psp_sk_rx_policy_check(struct sock *sk, struct sk_buff *skb)
 {
-	return 0;
+	return __psp_sk_rx_policy_check(skb, psp_sk_assoc(sk));
 }
 
 static inline enum skb_drop_reason
 psp_twsk_rx_policy_check(struct inet_timewait_sock *tw, struct sk_buff *skb)
 {
-	return 0;
+	return __psp_sk_rx_policy_check(skb, rcu_dereference(tw->psp_assoc));
+}
+
+static inline struct psp_assoc *psp_sk_get_assoc_rcu(struct sock *sk)
+{
+	struct inet_timewait_sock *tw;
+	struct psp_assoc *pas;
+	int state;
+
+	state = 1 << READ_ONCE(sk->sk_state);
+	if (!sk_is_inet(sk) || state & TCPF_NEW_SYN_RECV)
+		return NULL;
+
+	tw = inet_twsk(sk);
+	pas = state & TCPF_TIME_WAIT ? rcu_dereference(tw->psp_assoc) :
+				       rcu_dereference(sk->psp_assoc);
+	return pas;
 }
 
 static inline struct psp_assoc *psp_skb_get_assoc_rcu(struct sk_buff *skb)
 {
-	return NULL;
+	if (!skb->decrypted || !skb->sk)
+		return NULL;
+
+	return psp_sk_get_assoc_rcu(skb->sk);
 }
 #else
 static inline void psp_sk_assoc_free(struct sock *sk) { }
@@ -60,6 +151,11 @@ static inline void psp_twsk_assoc_free(struct inet_timewait_sock *tw) { }
 static inline void
 psp_reply_set_decrypted(struct sk_buff *skb) { }
 
+static inline struct psp_assoc *psp_sk_assoc(const struct sock *sk)
+{
+	return NULL;
+}
+
 static inline void
 psp_enqueue_set_decrypted(struct sock *sk, struct sk_buff *skb) { }
 
diff --git a/include/net/psp/types.h b/include/net/psp/types.h
index 66327fa80c92..b0e32e7165a3 100644
--- a/include/net/psp/types.h
+++ b/include/net/psp/types.h
@@ -51,6 +51,7 @@ struct psp_dev_config {
  * @refcnt:	reference count for the instance
  * @id:		instance id
  * @config:	current device configuration
+ * @active_assocs:	list of registered associations
  *
  * @rcu:	RCU head for freeing the structure
  */
@@ -68,6 +69,8 @@ struct psp_dev {
 
 	struct psp_dev_config config;
 
+	struct list_head active_assocs;
+
 	struct rcu_head rcu;
 };
 
@@ -80,6 +83,12 @@ struct psp_dev_caps {
 	 * Set this field to 0 to indicate PSP is not supported at all.
 	 */
 	u32 versions;
+
+	/**
+	 * @assoc_drv_spc: size of driver-specific state in Tx assoc
+	 * Determines the size of struct psp_assoc::drv_spc
+	 */
+	u32 assoc_drv_spc;
 };
 
 #define PSP_MAX_KEY	32
@@ -91,6 +100,32 @@ struct psp_skb_ext {
 	u8 version;
 };
 
+struct psp_key_parsed {
+	__be32 spi;
+	u8 key[PSP_MAX_KEY];
+};
+
+struct psp_assoc {
+	struct psp_dev *psd;
+
+	u16 dev_id;
+	u8 generation;
+	u8 version;
+	u8 peer_tx;
+
+	u32 upgrade_seq;
+
+	struct psp_key_parsed tx;
+	struct psp_key_parsed rx;
+
+	refcount_t refcnt;
+	struct rcu_head rcu;
+	struct work_struct work;
+	struct list_head assocs_list;
+
+	u8 drv_data[] __aligned(8);
+};
+
 /**
  * struct psp_dev_ops - netdev driver facing PSP callbacks
  */
@@ -107,6 +142,28 @@ struct psp_dev_ops {
 	 * @key_rotate: rotate the device key
 	 */
 	int (*key_rotate)(struct psp_dev *psd, struct netlink_ext_ack *extack);
+
+	/**
+	 * @rx_spi_alloc: allocate an Rx SPI+key pair
+	 * Allocate an Rx SPI and resulting derived key.
+	 * This key should remain valid until key rotation.
+	 */
+	int (*rx_spi_alloc)(struct psp_dev *psd, u32 version,
+			    struct psp_key_parsed *assoc,
+			    struct netlink_ext_ack *extack);
+
+	/**
+	 * @tx_key_add: add a Tx key to the device
+	 * Install an association in the device. Core will allocate space
+	 * for the driver to use at drv_data.
+	 */
+	int (*tx_key_add)(struct psp_dev *psd, struct psp_assoc *pas,
+			  struct netlink_ext_ack *extack);
+	/**
+	 * @tx_key_del: remove a Tx key from the device
+	 * Remove an association from the device.
+	 */
+	void (*tx_key_del)(struct psp_dev *psd, struct psp_assoc *pas);
 };
 
 #endif /* __NET_PSP_H */
diff --git a/include/uapi/linux/psp.h b/include/uapi/linux/psp.h
index cbfbf3f0f364..607c42c39ba5 100644
--- a/include/uapi/linux/psp.h
+++ b/include/uapi/linux/psp.h
@@ -26,6 +26,25 @@ enum {
 	PSP_A_DEV_MAX = (__PSP_A_DEV_MAX - 1)
 };
 
+enum {
+	PSP_A_ASSOC_DEV_ID = 1,
+	PSP_A_ASSOC_VERSION,
+	PSP_A_ASSOC_RX_KEY,
+	PSP_A_ASSOC_TX_KEY,
+	PSP_A_ASSOC_SOCK_FD,
+
+	__PSP_A_ASSOC_MAX,
+	PSP_A_ASSOC_MAX = (__PSP_A_ASSOC_MAX - 1)
+};
+
+enum {
+	PSP_A_KEYS_KEY = 1,
+	PSP_A_KEYS_SPI,
+
+	__PSP_A_KEYS_MAX,
+	PSP_A_KEYS_MAX = (__PSP_A_KEYS_MAX - 1)
+};
+
 enum {
 	PSP_CMD_DEV_GET = 1,
 	PSP_CMD_DEV_ADD_NTF,
@@ -34,6 +53,8 @@ enum {
 	PSP_CMD_DEV_CHANGE_NTF,
 	PSP_CMD_KEY_ROTATE,
 	PSP_CMD_KEY_ROTATE_NTF,
+	PSP_CMD_RX_ASSOC,
+	PSP_CMD_TX_ASSOC,
 
 	__PSP_CMD_MAX,
 	PSP_CMD_MAX = (__PSP_CMD_MAX - 1)
diff --git a/net/psp/Kconfig b/net/psp/Kconfig
index 5e3908a40945..a7d24691a7e1 100644
--- a/net/psp/Kconfig
+++ b/net/psp/Kconfig
@@ -6,6 +6,7 @@ config INET_PSP
 	bool "PSP Security Protocol support"
 	depends on INET
 	select SKB_DECRYPTED
+	select SOCK_VALIDATE_XMIT
 	help
 	Enable kernel support for the PSP protocol.
 	For more information see:
diff --git a/net/psp/Makefile b/net/psp/Makefile
index 41b51d06e560..eb5ff3c5bfb2 100644
--- a/net/psp/Makefile
+++ b/net/psp/Makefile
@@ -2,4 +2,4 @@
 
 obj-$(CONFIG_INET_PSP) += psp.o
 
-psp-y := psp_main.o psp_nl.o psp-nl-gen.o
+psp-y := psp_main.o psp_nl.o psp_sock.o psp-nl-gen.o
diff --git a/net/psp/psp-nl-gen.c b/net/psp/psp-nl-gen.c
index 7f49577ac72f..9fdd6f831803 100644
--- a/net/psp/psp-nl-gen.c
+++ b/net/psp/psp-nl-gen.c
@@ -10,6 +10,12 @@
 
 #include <uapi/linux/psp.h>
 
+/* Common nested types */
+const struct nla_policy psp_keys_nl_policy[PSP_A_KEYS_SPI + 1] = {
+	[PSP_A_KEYS_KEY] = { .type = NLA_BINARY, },
+	[PSP_A_KEYS_SPI] = { .type = NLA_U32, },
+};
+
 /* PSP_CMD_DEV_GET - do */
 static const struct nla_policy psp_dev_get_nl_policy[PSP_A_DEV_ID + 1] = {
 	[PSP_A_DEV_ID] = NLA_POLICY_MIN(NLA_U32, 1),
@@ -26,6 +32,21 @@ static const struct nla_policy psp_key_rotate_nl_policy[PSP_A_DEV_ID + 1] = {
 	[PSP_A_DEV_ID] = NLA_POLICY_MIN(NLA_U32, 1),
 };
 
+/* PSP_CMD_RX_ASSOC - do */
+static const struct nla_policy psp_rx_assoc_nl_policy[PSP_A_ASSOC_SOCK_FD + 1] = {
+	[PSP_A_ASSOC_DEV_ID] = NLA_POLICY_MIN(NLA_U32, 1),
+	[PSP_A_ASSOC_VERSION] = NLA_POLICY_MAX(NLA_U32, 3),
+	[PSP_A_ASSOC_SOCK_FD] = { .type = NLA_U32, },
+};
+
+/* PSP_CMD_TX_ASSOC - do */
+static const struct nla_policy psp_tx_assoc_nl_policy[PSP_A_ASSOC_SOCK_FD + 1] = {
+	[PSP_A_ASSOC_DEV_ID] = NLA_POLICY_MIN(NLA_U32, 1),
+	[PSP_A_ASSOC_VERSION] = NLA_POLICY_MAX(NLA_U32, 3),
+	[PSP_A_ASSOC_TX_KEY] = NLA_POLICY_NESTED(psp_keys_nl_policy),
+	[PSP_A_ASSOC_SOCK_FD] = { .type = NLA_U32, },
+};
+
 /* Ops table for psp */
 static const struct genl_split_ops psp_nl_ops[] = {
 	{
@@ -60,6 +81,24 @@ static const struct genl_split_ops psp_nl_ops[] = {
 		.maxattr	= PSP_A_DEV_ID,
 		.flags		= GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= PSP_CMD_RX_ASSOC,
+		.pre_doit	= psp_assoc_device_get_locked,
+		.doit		= psp_nl_rx_assoc_doit,
+		.post_doit	= psp_device_unlock,
+		.policy		= psp_rx_assoc_nl_policy,
+		.maxattr	= PSP_A_ASSOC_SOCK_FD,
+		.flags		= GENL_CMD_CAP_DO,
+	},
+	{
+		.cmd		= PSP_CMD_TX_ASSOC,
+		.pre_doit	= psp_assoc_device_get_locked,
+		.doit		= psp_nl_tx_assoc_doit,
+		.post_doit	= psp_device_unlock,
+		.policy		= psp_tx_assoc_nl_policy,
+		.maxattr	= PSP_A_ASSOC_SOCK_FD,
+		.flags		= GENL_CMD_CAP_DO,
+	},
 };
 
 static const struct genl_multicast_group psp_nl_mcgrps[] = {
diff --git a/net/psp/psp-nl-gen.h b/net/psp/psp-nl-gen.h
index 00a2d4ec59e4..25268ed11fb5 100644
--- a/net/psp/psp-nl-gen.h
+++ b/net/psp/psp-nl-gen.h
@@ -11,8 +11,13 @@
 
 #include <uapi/linux/psp.h>
 
+/* Common nested types */
+extern const struct nla_policy psp_keys_nl_policy[PSP_A_KEYS_SPI + 1];
+
 int psp_device_get_locked(const struct genl_split_ops *ops,
 			  struct sk_buff *skb, struct genl_info *info);
+int psp_assoc_device_get_locked(const struct genl_split_ops *ops,
+				struct sk_buff *skb, struct genl_info *info);
 void
 psp_device_unlock(const struct genl_split_ops *ops, struct sk_buff *skb,
 		  struct genl_info *info);
@@ -21,6 +26,8 @@ int psp_nl_dev_get_doit(struct sk_buff *skb, struct genl_info *info);
 int psp_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 int psp_nl_dev_set_doit(struct sk_buff *skb, struct genl_info *info);
 int psp_nl_key_rotate_doit(struct sk_buff *skb, struct genl_info *info);
+int psp_nl_rx_assoc_doit(struct sk_buff *skb, struct genl_info *info);
+int psp_nl_tx_assoc_doit(struct sk_buff *skb, struct genl_info *info);
 
 enum {
 	PSP_NLGRP_MGMT,
diff --git a/net/psp/psp.h b/net/psp/psp.h
index 94d0cc31a61f..defd3e3fd5e7 100644
--- a/net/psp/psp.h
+++ b/net/psp/psp.h
@@ -4,6 +4,7 @@
 #define __PSP_PSP_H
 
 #include <linux/list.h>
+#include <linux/lockdep.h>
 #include <linux/mutex.h>
 #include <net/netns/generic.h>
 #include <net/psp.h>
@@ -17,15 +18,36 @@ int psp_dev_check_access(struct psp_dev *psd, struct net *net);
 
 void psp_nl_notify_dev(struct psp_dev *psd, u32 cmd);
 
+struct psp_assoc *psp_assoc_create(struct psp_dev *psd);
+struct psp_dev *psp_dev_get_for_sock(struct sock *sk);
+void psp_dev_tx_key_del(struct psp_dev *psd, struct psp_assoc *pas);
+int psp_sock_assoc_set_rx(struct sock *sk, struct psp_assoc *pas,
+			  struct psp_key_parsed *key,
+			  struct netlink_ext_ack *extack);
+int psp_sock_assoc_set_tx(struct sock *sk, struct psp_dev *psd,
+			  u32 version, struct psp_key_parsed *key,
+			  struct netlink_ext_ack *extack);
+
 static inline void psp_dev_get(struct psp_dev *psd)
 {
 	refcount_inc(&psd->refcnt);
 }
 
+static inline bool psp_dev_tryget(struct psp_dev *psd)
+{
+	return refcount_inc_not_zero(&psd->refcnt);
+}
+
 static inline void psp_dev_put(struct psp_dev *psd)
 {
 	if (refcount_dec_and_test(&psd->refcnt))
 		psp_dev_destroy(psd);
 }
 
+static inline bool psp_dev_is_registered(struct psp_dev *psd)
+{
+	lockdep_assert_held(&psd->lock);
+	return !!psd->ops;
+}
+
 #endif /* __PSP_PSP_H */
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index f60155493afc..a1ae3c8920c3 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -55,7 +55,10 @@ psp_dev_create(struct net_device *netdev,
 
 	if (WARN_ON(!psd_caps->versions ||
 		    !psd_ops->set_config ||
-		    !psd_ops->key_rotate))
+		    !psd_ops->key_rotate ||
+		    !psd_ops->rx_spi_alloc ||
+		    !psd_ops->tx_key_add ||
+		    !psd_ops->tx_key_del))
 		return ERR_PTR(-EINVAL);
 
 	psd = kzalloc(sizeof(*psd), GFP_KERNEL);
@@ -68,6 +71,7 @@ psp_dev_create(struct net_device *netdev,
 	psd->drv_priv = priv_ptr;
 
 	mutex_init(&psd->lock);
+	INIT_LIST_HEAD(&psd->active_assocs);
 	refcount_set(&psd->refcnt, 1);
 
 	mutex_lock(&psp_devs_lock);
@@ -107,6 +111,8 @@ void psp_dev_destroy(struct psp_dev *psd)
  */
 void psp_dev_unregister(struct psp_dev *psd)
 {
+	struct psp_assoc *pas, *next;
+
 	mutex_lock(&psp_devs_lock);
 	mutex_lock(&psd->lock);
 
@@ -119,6 +125,9 @@ void psp_dev_unregister(struct psp_dev *psd)
 	xa_store(&psp_devs, psd->id, NULL, GFP_KERNEL);
 	mutex_unlock(&psp_devs_lock);
 
+	list_for_each_entry_safe(pas, next, &psd->active_assocs, assocs_list)
+		psp_dev_tx_key_del(psd, pas);
+
 	rcu_assign_pointer(psd->main_netdev->psp_dev, NULL);
 
 	psd->ops = NULL;
@@ -130,6 +139,21 @@ void psp_dev_unregister(struct psp_dev *psd)
 }
 EXPORT_SYMBOL(psp_dev_unregister);
 
+unsigned int psp_key_size(u32 version)
+{
+	switch (version) {
+	case PSP_VERSION_HDR0_AES_GCM_128:
+	case PSP_VERSION_HDR0_AES_GMAC_128:
+		return 16;
+	case PSP_VERSION_HDR0_AES_GCM_256:
+	case PSP_VERSION_HDR0_AES_GMAC_256:
+		return 32;
+	default:
+		return 0;
+	}
+}
+EXPORT_SYMBOL(psp_key_size);
+
 static int __init psp_init(void)
 {
 	mutex_init(&psp_devs_lock);
diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
index 75f2702c1029..1b1d08fce637 100644
--- a/net/psp/psp_nl.c
+++ b/net/psp/psp_nl.c
@@ -79,9 +79,12 @@ void
 psp_device_unlock(const struct genl_split_ops *ops, struct sk_buff *skb,
 		  struct genl_info *info)
 {
+	struct socket *socket = info->user_ptr[1];
 	struct psp_dev *psd = info->user_ptr[0];
 
 	mutex_unlock(&psd->lock);
+	if (socket)
+		sockfd_put(socket);
 }
 
 static int
@@ -261,3 +264,232 @@ int psp_nl_key_rotate_doit(struct sk_buff *skb, struct genl_info *info)
 	nlmsg_free(rsp);
 	return err;
 }
+
+/* Key etc. */
+
+int psp_assoc_device_get_locked(const struct genl_split_ops *ops,
+				struct sk_buff *skb, struct genl_info *info)
+{
+	struct socket *socket;
+	struct psp_dev *psd;
+	struct nlattr *id;
+	int fd, err;
+
+	if (GENL_REQ_ATTR_CHECK(info, PSP_A_ASSOC_SOCK_FD))
+		return -EINVAL;
+
+	fd = nla_get_u32(info->attrs[PSP_A_ASSOC_SOCK_FD]);
+	socket = sockfd_lookup(fd, &err);
+	if (!socket)
+		return err;
+
+	if (!sk_is_tcp(socket->sk)) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    info->attrs[PSP_A_ASSOC_SOCK_FD],
+				    "Unsupported socket family and type");
+		err = -EOPNOTSUPP;
+		goto err_sock_put;
+	}
+
+	psd = psp_dev_get_for_sock(socket->sk);
+	if (psd) {
+		err = psp_dev_check_access(psd, genl_info_net(info));
+		if (err) {
+			psp_dev_put(psd);
+			psd = NULL;
+		}
+	}
+
+	if (!psd && GENL_REQ_ATTR_CHECK(info, PSP_A_ASSOC_DEV_ID)) {
+		err = -EINVAL;
+		goto err_sock_put;
+	}
+
+	id = info->attrs[PSP_A_ASSOC_DEV_ID];
+	if (psd) {
+		mutex_lock(&psd->lock);
+		if (id && psd->id != nla_get_u32(id)) {
+			mutex_unlock(&psd->lock);
+			NL_SET_ERR_MSG_ATTR(info->extack, id,
+					    "Device id vs socket mismatch");
+			err = -EINVAL;
+			goto err_psd_put;
+		}
+
+		psp_dev_put(psd);
+	} else {
+		psd = psp_device_get_and_lock(genl_info_net(info), id);
+		if (IS_ERR(psd)) {
+			err = PTR_ERR(psd);
+			goto err_sock_put;
+		}
+	}
+
+	info->user_ptr[0] = psd;
+	info->user_ptr[1] = socket;
+
+	return 0;
+
+err_psd_put:
+	psp_dev_put(psd);
+err_sock_put:
+	sockfd_put(socket);
+	return err;
+}
+
+static int
+psp_nl_parse_key(struct genl_info *info, u32 attr, struct psp_key_parsed *key,
+		 unsigned int key_sz)
+{
+	struct nlattr *nest = info->attrs[attr];
+	struct nlattr *tb[PSP_A_KEYS_SPI + 1];
+	u32 spi;
+	int err;
+
+	err = nla_parse_nested(tb, ARRAY_SIZE(tb) - 1, nest,
+			       psp_keys_nl_policy, info->extack);
+	if (err)
+		return err;
+
+	if (NL_REQ_ATTR_CHECK(info->extack, nest, tb, PSP_A_KEYS_KEY) ||
+	    NL_REQ_ATTR_CHECK(info->extack, nest, tb, PSP_A_KEYS_SPI))
+		return -EINVAL;
+
+	if (nla_len(tb[PSP_A_KEYS_KEY]) != key_sz) {
+		NL_SET_ERR_MSG_ATTR(info->extack, tb[PSP_A_KEYS_KEY],
+				    "incorrect key length");
+		return -EINVAL;
+	}
+
+	spi = nla_get_u32(tb[PSP_A_KEYS_SPI]);
+	if (!(spi & PSP_SPI_KEY_ID)) {
+		NL_SET_ERR_MSG_ATTR(info->extack, tb[PSP_A_KEYS_KEY],
+				    "invalid SPI: lower 31b must be non-zero");
+		return -EINVAL;
+	}
+
+	key->spi = cpu_to_be32(spi);
+	memcpy(key->key, nla_data(tb[PSP_A_KEYS_KEY]), key_sz);
+
+	return 0;
+}
+
+static int
+psp_nl_put_key(struct sk_buff *skb, u32 attr, u32 version,
+	       struct psp_key_parsed *key)
+{
+	int key_sz = psp_key_size(version);
+	void *nest;
+
+	nest = nla_nest_start(skb, attr);
+
+	if (nla_put_u32(skb, PSP_A_KEYS_SPI, be32_to_cpu(key->spi)) ||
+	    nla_put(skb, PSP_A_KEYS_KEY, key_sz, key->key)) {
+		nla_nest_cancel(skb, nest);
+		return -EMSGSIZE;
+	}
+
+	nla_nest_end(skb, nest);
+
+	return 0;
+}
+
+int psp_nl_rx_assoc_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct socket *socket = info->user_ptr[1];
+	struct psp_dev *psd = info->user_ptr[0];
+	struct psp_key_parsed key;
+	struct psp_assoc *pas;
+	struct sk_buff *rsp;
+	u32 version;
+	int err;
+
+	if (GENL_REQ_ATTR_CHECK(info, PSP_A_ASSOC_VERSION))
+		return -EINVAL;
+
+	version = nla_get_u32(info->attrs[PSP_A_ASSOC_VERSION]);
+	if (!(psd->caps->versions & (1 << version))) {
+		NL_SET_BAD_ATTR(info->extack, info->attrs[PSP_A_ASSOC_VERSION]);
+		return -EOPNOTSUPP;
+	}
+
+	rsp = psp_nl_reply_new(info);
+	if (!rsp)
+		return -ENOMEM;
+
+	pas = psp_assoc_create(psd);
+	if (!pas) {
+		err = -ENOMEM;
+		goto err_free_rsp;
+	}
+	pas->version = version;
+
+	err = psd->ops->rx_spi_alloc(psd, version, &key, info->extack);
+	if (err)
+		goto err_free_pas;
+
+	if (nla_put_u32(rsp, PSP_A_ASSOC_DEV_ID, psd->id) ||
+	    psp_nl_put_key(rsp, PSP_A_ASSOC_RX_KEY, version, &key)) {
+		err = -EMSGSIZE;
+		goto err_free_pas;
+	}
+
+	err = psp_sock_assoc_set_rx(socket->sk, pas, &key, info->extack);
+	if (err) {
+		NL_SET_BAD_ATTR(info->extack, info->attrs[PSP_A_ASSOC_SOCK_FD]);
+		goto err_free_pas;
+	}
+	psp_assoc_put(pas);
+
+	return psp_nl_reply_send(rsp, info);
+
+err_free_pas:
+	psp_assoc_put(pas);
+err_free_rsp:
+	nlmsg_free(rsp);
+	return err;
+}
+
+int psp_nl_tx_assoc_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct socket *socket = info->user_ptr[1];
+	struct psp_dev *psd = info->user_ptr[0];
+	struct psp_key_parsed key;
+	struct sk_buff *rsp;
+	unsigned int key_sz;
+	u32 version;
+	int err;
+
+	if (GENL_REQ_ATTR_CHECK(info, PSP_A_ASSOC_VERSION) ||
+	    GENL_REQ_ATTR_CHECK(info, PSP_A_ASSOC_TX_KEY))
+		return -EINVAL;
+
+	version = nla_get_u32(info->attrs[PSP_A_ASSOC_VERSION]);
+	if (!(psd->caps->versions & (1 << version))) {
+		NL_SET_BAD_ATTR(info->extack, info->attrs[PSP_A_ASSOC_VERSION]);
+		return -EOPNOTSUPP;
+	}
+
+	key_sz = psp_key_size(version);
+	if (!key_sz)
+		return -EINVAL;
+
+	err = psp_nl_parse_key(info, PSP_A_ASSOC_TX_KEY, &key, key_sz);
+	if (err < 0)
+		return err;
+
+	rsp = psp_nl_reply_new(info);
+	if (!rsp)
+		return -ENOMEM;
+
+	err = psp_sock_assoc_set_tx(socket->sk, psd, version, &key,
+				    info->extack);
+	if (err)
+		goto err_free_msg;
+
+	return psp_nl_reply_send(rsp, info);
+
+err_free_msg:
+	nlmsg_free(rsp);
+	return err;
+}
diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
new file mode 100644
index 000000000000..8ebccee94593
--- /dev/null
+++ b/net/psp/psp_sock.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/file.h>
+#include <linux/net.h>
+#include <linux/rcupdate.h>
+#include <linux/tcp.h>
+
+#include <net/ip.h>
+#include <net/psp.h>
+#include "psp.h"
+
+struct psp_dev *psp_dev_get_for_sock(struct sock *sk)
+{
+	struct dst_entry *dst;
+	struct psp_dev *psd;
+
+	dst = sk_dst_get(sk);
+	if (!dst)
+		return NULL;
+
+	rcu_read_lock();
+	psd = rcu_dereference(dst->dev->psp_dev);
+	if (psd && !psp_dev_tryget(psd))
+		psd = NULL;
+	rcu_read_unlock();
+
+	dst_release(dst);
+
+	return psd;
+}
+
+static struct sk_buff *
+psp_validate_xmit(struct sock *sk, struct net_device *dev, struct sk_buff *skb)
+{
+	struct psp_assoc *pas;
+	bool good;
+
+	rcu_read_lock();
+	pas = psp_skb_get_assoc_rcu(skb);
+	good = !pas || rcu_access_pointer(dev->psp_dev) == pas->psd;
+	rcu_read_unlock();
+	if (!good) {
+		kfree_skb_reason(skb, SKB_DROP_REASON_PSP_OUTPUT);
+		return NULL;
+	}
+
+	return skb;
+}
+
+struct psp_assoc *psp_assoc_create(struct psp_dev *psd)
+{
+	struct psp_assoc *pas;
+
+	lockdep_assert_held(&psd->lock);
+
+	pas = kzalloc(struct_size(pas, drv_data, psd->caps->assoc_drv_spc),
+		      GFP_KERNEL_ACCOUNT);
+	if (!pas)
+		return NULL;
+
+	pas->psd = psd;
+	pas->dev_id = psd->id;
+	psp_dev_get(psd);
+	refcount_set(&pas->refcnt, 1);
+
+	list_add_tail(&pas->assocs_list, &psd->active_assocs);
+
+	return pas;
+}
+
+static struct psp_assoc *psp_assoc_dummy(struct psp_assoc *pas)
+{
+	struct psp_dev *psd = pas->psd;
+	size_t sz;
+
+	lockdep_assert_held(&psd->lock);
+
+	sz = struct_size(pas, drv_data, psd->caps->assoc_drv_spc);
+	return kmemdup(pas, sz, GFP_KERNEL);
+}
+
+static int psp_dev_tx_key_add(struct psp_dev *psd, struct psp_assoc *pas,
+			      struct netlink_ext_ack *extack)
+{
+	return psd->ops->tx_key_add(psd, pas, extack);
+}
+
+void psp_dev_tx_key_del(struct psp_dev *psd, struct psp_assoc *pas)
+{
+	if (pas->tx.spi)
+		psd->ops->tx_key_del(psd, pas);
+	list_del(&pas->assocs_list);
+}
+
+static void psp_assoc_free(struct work_struct *work)
+{
+	struct psp_assoc *pas = container_of(work, struct psp_assoc, work);
+	struct psp_dev *psd = pas->psd;
+
+	mutex_lock(&psd->lock);
+	if (psd->ops)
+		psp_dev_tx_key_del(psd, pas);
+	mutex_unlock(&psd->lock);
+	psp_dev_put(psd);
+	kfree(pas);
+}
+
+static void psp_assoc_free_queue(struct rcu_head *head)
+{
+	struct psp_assoc *pas = container_of(head, struct psp_assoc, rcu);
+
+	INIT_WORK(&pas->work, psp_assoc_free);
+	schedule_work(&pas->work);
+}
+
+/**
+ * psp_assoc_put() - release a reference on a PSP association
+ * @pas: association to release
+ */
+void psp_assoc_put(struct psp_assoc *pas)
+{
+	if (pas && refcount_dec_and_test(&pas->refcnt))
+		call_rcu(&pas->rcu, psp_assoc_free_queue);
+}
+
+void psp_sk_assoc_free(struct sock *sk)
+{
+	struct psp_assoc *pas = rcu_dereference_protected(sk->psp_assoc, 1);
+
+	rcu_assign_pointer(sk->psp_assoc, NULL);
+	psp_assoc_put(pas);
+}
+
+int psp_sock_assoc_set_rx(struct sock *sk, struct psp_assoc *pas,
+			  struct psp_key_parsed *key,
+			  struct netlink_ext_ack *extack)
+{
+	int err;
+
+	memcpy(&pas->rx, key, sizeof(*key));
+
+	lock_sock(sk);
+
+	if (psp_sk_assoc(sk)) {
+		NL_SET_ERR_MSG(extack, "Socket already has PSP state");
+		err = -EBUSY;
+		goto exit_unlock;
+	}
+
+	refcount_inc(&pas->refcnt);
+	rcu_assign_pointer(sk->psp_assoc, pas);
+	err = 0;
+
+exit_unlock:
+	release_sock(sk);
+
+	return err;
+}
+
+static int psp_sock_recv_queue_check(struct sock *sk, struct psp_assoc *pas)
+{
+	struct psp_skb_ext *pse;
+	struct sk_buff *skb;
+
+	skb_rbtree_walk(skb, &tcp_sk(sk)->out_of_order_queue) {
+		pse = skb_ext_find(skb, SKB_EXT_PSP);
+		if (!psp_pse_matches_pas(pse, pas))
+			return -EBUSY;
+	}
+
+	skb_queue_walk(&sk->sk_receive_queue, skb) {
+		pse = skb_ext_find(skb, SKB_EXT_PSP);
+		if (!psp_pse_matches_pas(pse, pas))
+			return -EBUSY;
+	}
+	return 0;
+}
+
+int psp_sock_assoc_set_tx(struct sock *sk, struct psp_dev *psd,
+			  u32 version, struct psp_key_parsed *key,
+			  struct netlink_ext_ack *extack)
+{
+	struct psp_assoc *pas, *dummy;
+	int err;
+
+	lock_sock(sk);
+
+	pas = psp_sk_assoc(sk);
+	if (!pas) {
+		NL_SET_ERR_MSG(extack, "Socket has no Rx key");
+		err = -EINVAL;
+		goto exit_unlock;
+	}
+	if (pas->psd != psd) {
+		NL_SET_ERR_MSG(extack, "Rx key from different device");
+		err = -EINVAL;
+		goto exit_unlock;
+	}
+	if (pas->version != version) {
+		NL_SET_ERR_MSG(extack,
+			       "PSP version mismatch with existing state");
+		err = -EINVAL;
+		goto exit_unlock;
+	}
+	if (pas->tx.spi) {
+		NL_SET_ERR_MSG(extack, "Tx key already set");
+		err = -EBUSY;
+		goto exit_unlock;
+	}
+
+	err = psp_sock_recv_queue_check(sk, pas);
+	if (err) {
+		NL_SET_ERR_MSG(extack, "Socket has incompatible segments already in the recv queue");
+		goto exit_unlock;
+	}
+
+	/* Pass a fake association to drivers to make sure they don't
+	 * try to store pointers to it. For re-keying we'll need to
+	 * re-allocate the assoc structures.
+	 */
+	dummy = psp_assoc_dummy(pas);
+	if (!dummy) {
+		err = -ENOMEM;
+		goto exit_unlock;
+	}
+
+	memcpy(&dummy->tx, key, sizeof(*key));
+	err = psp_dev_tx_key_add(psd, dummy, extack);
+	if (err)
+		goto exit_free_dummy;
+
+	memcpy(pas->drv_data, dummy->drv_data, psd->caps->assoc_drv_spc);
+	memcpy(&pas->tx, key, sizeof(*key));
+
+	WRITE_ONCE(sk->sk_validate_xmit_skb, psp_validate_xmit);
+	tcp_write_collapse_fence(sk);
+	pas->upgrade_seq = tcp_sk(sk)->rcv_nxt;
+
+exit_free_dummy:
+	kfree(dummy);
+exit_unlock:
+	release_sock(sk);
+	return err;
+}
+
+void psp_twsk_init(struct inet_timewait_sock *tw, const struct sock *sk)
+{
+	struct psp_assoc *pas = psp_sk_assoc(sk);
+
+	if (pas)
+		refcount_inc(&pas->refcnt);
+	rcu_assign_pointer(tw->psp_assoc, pas);
+	tw->tw_validate_xmit_skb = psp_validate_xmit;
+}
+
+void psp_twsk_assoc_free(struct inet_timewait_sock *tw)
+{
+	struct psp_assoc *pas = rcu_dereference_protected(tw->psp_assoc, 1);
+
+	rcu_assign_pointer(tw->psp_assoc, NULL);
+	psp_assoc_put(pas);
+}
+
+void psp_reply_set_decrypted(struct sk_buff *skb)
+{
+	struct psp_assoc *pas;
+
+	rcu_read_lock();
+	pas = psp_sk_get_assoc_rcu(skb->sk);
+	if (pas && pas->tx.spi)
+		skb->decrypted = 1;
+	rcu_read_unlock();
+}
+EXPORT_IPV6_MOD_GPL(psp_reply_set_decrypted);
-- 
2.47.3


