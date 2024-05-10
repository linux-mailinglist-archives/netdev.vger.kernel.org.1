Return-Path: <netdev+bounces-95267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 939F88C1CB4
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 05:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 424ED280EAE
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 03:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADF5149DE7;
	Fri, 10 May 2024 03:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJ4BVLl2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D6D149DE6
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 03:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715310289; cv=none; b=Htp8gN4SG0/XfNB2i3pfRrs7hg7eYy5NBRANwhaUk97inc0mVLN7uxMSyuO3Fw7GRX86AjqTb/0zMf1G1MZNVT0IQeQSwDcDacDRjGtPHOeM5rxZf8/JNYeHv8ywRlTcaolPcdH1cXrUqfGLouorAQlh+WXcEXOrdYxxyves1NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715310289; c=relaxed/simple;
	bh=RuKLxb3Y6oarj0HN/kjKDoGKGa0lwH6zpcHkkrbcooI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgTrmjP6fZGkYy3bOUgmgKB0hiOg6/mbsNoClLcFf1CBbnbRtZPzX5k75SkE68kBt+cF+EAo55qyS9e54OXJbBQElZOZOjXnTTjVSsdZYpI084R95kJk2cPAR5PDcnafMh9UgE3gS1cHeuPFV0N4GCSkPotmIvAOsD41xZcNjyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJ4BVLl2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E109C32781;
	Fri, 10 May 2024 03:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715310288;
	bh=RuKLxb3Y6oarj0HN/kjKDoGKGa0lwH6zpcHkkrbcooI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LJ4BVLl2oOUD7HHhJIeipY7VjSf9JrWSSt/A3KRllcQzjd1pUQjm/1UPgO908nYnl
	 tJ4dCUSMQQ9x2Xf7bHxLiy4Z++Ox08TsPWr7sAhFE/kChquvLqRj37zbTiam6Xswo0
	 y6XvACszjiVcRR/ivPRrfNQbdw0wtc973SqxX0QKA0yOpZhsviDKImRKmttUVUeQIw
	 boKHNyMJHJltnPAJt79D5iEw4l549T7YSWsai3w/K3IltXc022PMQTpneteCZVQgAH
	 O5z8FNct36amQ6g2AU8RkgWFrl1pf4rX0qDZS3hu3T5ortdCBpubzUpeV0EBTA+nTx
	 2EQZh3aMITPOw==
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	borisp@nvidia.com,
	gal@nvidia.com,
	cratiu@nvidia.com,
	rrameshbabu@nvidia.com,
	steffen.klassert@secunet.com,
	tariqt@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 06/15] net: psp: add socket security association code
Date: Thu,  9 May 2024 20:04:26 -0700
Message-ID: <20240510030435.120935-7-kuba@kernel.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240510030435.120935-1-kuba@kernel.org>
References: <20240510030435.120935-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the ability to install PSP Rx and Tx crypto keys on TCP
connections. Netlink ops are provided for both operations.
Rx side combines allocating a new Rx key and installing it
on the socket. Theoretically these are separate actions,
but in practice they will always be used one after the
other. We can add distinct "alloc" and "install" ops later.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/psp.yaml |  71 ++++++++
 include/net/psp/functions.h          |  69 ++++++--
 include/net/psp/types.h              |  55 ++++++
 include/uapi/linux/psp.h             |  21 +++
 net/psp/Kconfig                      |   1 +
 net/psp/Makefile                     |   2 +-
 net/psp/psp-nl-gen.c                 |  39 ++++
 net/psp/psp-nl-gen.h                 |   7 +
 net/psp/psp.h                        |  22 +++
 net/psp/psp_main.c                   |  11 +-
 net/psp/psp_nl.c                     | 244 +++++++++++++++++++++++++
 net/psp/psp_sock.c                   | 255 +++++++++++++++++++++++++++
 12 files changed, 783 insertions(+), 14 deletions(-)
 create mode 100644 net/psp/psp_sock.c

diff --git a/Documentation/netlink/specs/psp.yaml b/Documentation/netlink/specs/psp.yaml
index 6ae598a60b3f..a81f19e7b20d 100644
--- a/Documentation/netlink/specs/psp.yaml
+++ b/Documentation/netlink/specs/psp.yaml
@@ -38,6 +38,44 @@ name: psp
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
@@ -107,6 +145,39 @@ name: psp
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
+            - version
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
index 7a3b897ecc69..ad81322dd4ed 100644
--- a/include/net/psp/functions.h
+++ b/include/net/psp/functions.h
@@ -4,6 +4,7 @@
 #define __NET_PSP_HELPERS_H
 
 #include <linux/skbuff.h>
+#include <linux/rcupdate.h>
 #include <net/sock.h>
 #include <net/psp/types.h>
 
@@ -16,39 +17,78 @@ psp_dev_create(struct net_device *netdev, struct psp_dev_ops *psd_ops,
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
-psp_twsk_init(struct tcp_timewait_sock *tw, struct sock *sk) { }
-static inline void psp_twsk_assoc_free(struct tcp_timewait_sock *tw) { }
+void psp_sk_assoc_free(struct sock *sk);
+void psp_twsk_init(struct tcp_timewait_sock *tw, struct sock *sk);
+void psp_twsk_assoc_free(struct tcp_timewait_sock *tw);
+enum skb_drop_reason
+psp_twsk_rx_policy_check(struct tcp_timewait_sock *tw, struct sk_buff *skb);
+
+static inline struct psp_assoc *psp_sk_assoc(struct sock *sk)
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
 
+static inline enum skb_drop_reason
+__psp_sk_rx_policy_check(struct psp_skb_ext *pse, struct psp_assoc *pas)
+{
+	if (!pse) {
+		if (pas && READ_ONCE(pas->rx_required))
+			return SKB_DROP_REASON_PSP_INPUT;
+		return 0;
+	}
+
+	if (pas && pas->rx.spi == pse->spi &&
+	    pas->generation == pse->generation &&
+	    pas->version == pse->version)
+		return 0;
+	return SKB_DROP_REASON_PSP_INPUT;
+}
+
 static inline enum skb_drop_reason
 psp_sk_rx_policy_check(struct sock *sk, struct sk_buff *skb)
 {
-	return 0;
-}
-
-static inline enum skb_drop_reason
-psp_twsk_rx_policy_check(struct tcp_timewait_sock *tw, struct sk_buff *skb)
-{
-	return 0;
+	return __psp_sk_rx_policy_check(skb_ext_find(skb, SKB_EXT_PSP),
+					psp_sk_assoc(sk));
 }
 
 static inline struct psp_assoc *psp_skb_get_assoc_rcu(struct sk_buff *skb)
 {
-	return NULL;
+	if (!skb->decrypted || !skb->sk || !sk_fullsock(skb->sk))
+		return NULL;
+	return rcu_dereference(skb->sk->psp_assoc);
 }
 #else
 static inline void psp_sk_assoc_free(struct sock *sk) { }
@@ -56,6 +96,11 @@ static inline void
 psp_twsk_init(struct tcp_timewait_sock *tw, struct sock *sk) { }
 static inline void psp_twsk_assoc_free(struct tcp_timewait_sock *tw) { }
 
+static inline struct psp_assoc *psp_sk_assoc(struct sock *sk)
+{
+	return NULL;
+}
+
 static inline void
 psp_enqueue_set_decrypted(struct sock *sk, struct sk_buff *skb) { }
 
diff --git a/include/net/psp/types.h b/include/net/psp/types.h
index 43950caf70f1..e39abf10c03c 100644
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
 
 #define PSP_V0_KEY	16
@@ -93,6 +102,30 @@ struct psp_skb_ext {
 	u16 version;
 };
 
+struct psp_key_parsed {
+	__be32 spi;
+	u8 key[PSP_MAX_KEY];
+};
+
+struct psp_assoc {
+	struct psp_dev *psd;
+
+	u8 generation;
+	u8 version;
+	u8 key_sz;
+	u8 rx_required;
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
@@ -109,6 +142,28 @@ struct psp_dev_ops {
 	 * @key_rotate: rotate the secret state
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
index 94d0cc31a61f..b4092936bc64 100644
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
+struct psp_dev *psd_get_for_sock(struct sock *sk);
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
index 536f50d82fb2..59066c4db048 100644
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
@@ -103,6 +107,8 @@ void psp_dev_destroy(struct psp_dev *psd)
  */
 void psp_dev_unregister(struct psp_dev *psd)
 {
+	struct psp_assoc *pas, *next;
+
 	mutex_lock(&psp_devs_lock);
 	mutex_lock(&psd->lock);
 
@@ -110,6 +116,9 @@ void psp_dev_unregister(struct psp_dev *psd)
 	xa_erase(&psp_devs, psd->id);
 	mutex_unlock(&psp_devs_lock);
 
+	list_for_each_entry_safe(pas, next, &psd->active_assocs, assocs_list)
+		psp_dev_tx_key_del(psd, pas);
+
 	rcu_assign_pointer(psd->main_netdev->psp_dev, NULL);
 
 	psd->ops = NULL;
diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
index b7006e50dc87..58508e642185 100644
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
@@ -261,3 +264,244 @@ int psp_nl_key_rotate_doit(struct sk_buff *skb, struct genl_info *info)
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
+	struct sock *sk;
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
+	sk = socket->sk;
+	if (sk->sk_family != AF_INET && sk->sk_family != AF_INET6) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    info->attrs[PSP_A_ASSOC_SOCK_FD],
+				    "Unsupported socket family");
+		err = -EOPNOTSUPP;
+		goto err_sock_put;
+	}
+
+	psd = psd_get_for_sock(socket->sk);
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
+static unsigned int psp_nl_assoc_key_size(u32 version)
+{
+	switch (version) {
+	case PSP_VERSION_HDR0_AES_GCM_128:
+	case PSP_VERSION_HDR0_AES_GMAC_128:
+		return 16;
+	case PSP_VERSION_HDR0_AES_GCM_256:
+	case PSP_VERSION_HDR0_AES_GMAC_256:
+		return 32;
+	default:
+		/* Netlink policies should prevent us from getting here */
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+}
+
+static int
+psp_nl_parse_key(struct genl_info *info, u32 attr, struct psp_key_parsed *key,
+		 unsigned int key_sz)
+{
+	struct nlattr *nest = info->attrs[attr];
+	struct nlattr *tb[PSP_A_KEYS_SPI + 1];
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
+	key->spi = cpu_to_be32(nla_get_u32(tb[PSP_A_KEYS_SPI]));
+	memcpy(key->key, nla_data(tb[PSP_A_KEYS_KEY]), key_sz);
+
+	return 0;
+}
+
+static int
+psp_nl_put_key(struct sk_buff *skb, u32 attr, u32 version,
+	       struct psp_key_parsed *key)
+{
+	int key_sz = psp_nl_assoc_key_size(version);
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
+	pas->key_sz = psp_nl_assoc_key_size(version);
+
+	err = psd->ops->rx_spi_alloc(psd, version, &key, info->extack);
+	if (err)
+		goto err_free_pas;
+
+	if (nla_put_u32(rsp, PSP_A_ASSOC_DEV_ID, psd->id) ||
+	    nla_put_u32(rsp, PSP_A_ASSOC_VERSION, version) ||
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
+	key_sz = psp_nl_assoc_key_size(version);
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
index 000000000000..42b881e681b9
--- /dev/null
+++ b/net/psp/psp_sock.c
@@ -0,0 +1,255 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/file.h>
+#include <linux/net.h>
+#include <linux/rcupdate.h>
+#include <linux/tcp.h>
+
+#include <net/psp.h>
+#include "psp.h"
+
+struct psp_dev *psd_get_for_sock(struct sock *sk)
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
+	rcu_read_lock();
+	psp_assoc_put(rcu_dereference(sk->psp_assoc));
+	rcu_assign_pointer(sk->psp_assoc, NULL);
+	rcu_read_unlock();
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
+static int psp_sock_recv_queue_check(struct sock *sk)
+{
+	struct sk_buff *skb;
+
+	skb_queue_walk(&sk->sk_receive_queue, skb) {
+		if (psp_sk_rx_policy_check(sk, skb))
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
+	WRITE_ONCE(pas->rx_required, 1);
+	err = psp_sock_recv_queue_check(sk);
+	if (err) {
+		NL_SET_ERR_MSG(extack, "Socket has incompatible segments already in the recv queue");
+		goto exit_clear_rx;
+	}
+
+	/* Pass a fake association to drivers to make sure they don't
+	 * try to store pointers to it. For re-keying we'll need to
+	 * re-allocate the assoc structures.
+	 */
+	dummy = psp_assoc_dummy(pas);
+	memcpy(&dummy->tx, key, sizeof(*key));
+	err = psp_dev_tx_key_add(psd, dummy, extack);
+	if (err)
+		goto exit_free_dummy;
+
+	memcpy(pas->drv_data, dummy->drv_data, psd->caps->assoc_drv_spc);
+	memcpy(&pas->tx, key, sizeof(*key));
+
+	WRITE_ONCE(sk->sk_validate_xmit_skb, psp_validate_xmit);
+
+exit_free_dummy:
+	kfree(dummy);
+exit_clear_rx:
+	if (err)
+		WRITE_ONCE(pas->rx_required, 0);
+exit_unlock:
+	release_sock(sk);
+	return err;
+}
+
+void psp_twsk_init(struct tcp_timewait_sock *tw, struct sock *sk)
+{
+	struct psp_assoc *pas = psp_sk_assoc(sk);
+
+	if (pas)
+		refcount_inc(&pas->refcnt);
+	rcu_assign_pointer(tw->psp_assoc, pas);
+}
+
+void psp_twsk_assoc_free(struct tcp_timewait_sock *tw)
+{
+	rcu_read_lock();
+	psp_assoc_put(rcu_dereference(tw->psp_assoc));
+	rcu_assign_pointer(tw->psp_assoc, NULL);
+	rcu_read_unlock();
+}
+
+enum skb_drop_reason
+psp_twsk_rx_policy_check(struct tcp_timewait_sock *tw, struct sk_buff *skb)
+{
+	return __psp_sk_rx_policy_check(skb_ext_find(skb, SKB_EXT_PSP),
+					rcu_dereference(tw->psp_assoc));
+}
-- 
2.45.0


