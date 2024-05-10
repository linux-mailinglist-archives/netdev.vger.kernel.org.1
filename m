Return-Path: <netdev+bounces-95269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D709C8C1CB6
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 05:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F61C1F226D5
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 03:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC73149E12;
	Fri, 10 May 2024 03:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrDVB9d6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAD4148840
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 03:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715310290; cv=none; b=utBuJ4QTPliZPZGVUHFCxuMDOOcODkphQb5htnrCNVVtdvWMHpYfrRqqvK+mqC0EFHuGtMWAOEgKe4uOJrLEJbG9lHmp8vPmwQkK5sgix+yE8Umym/7Iyi5oLibqTgKdqeAENu7aVnIjZbLYQSXN5jeSO5qFosUY5KmMN0npFc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715310290; c=relaxed/simple;
	bh=XvObPRnmyqwdGUB9ixy/MMsyTMFrwTNz3Ndw/Y6vDhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=peY9jfdh0jQT3iK9Vd3+Jg5WsE0pg3XwkLux57LSzVRohpAjkoWzyOHqxHbEnpK1LqUFRoQzkP6NfSU/J8NUeia/63n6XbRGQ7WmhUEEiK32unYBc//TEL9RzyMsAL7JACfuRAYE0U8t2JeRyDOYtqHO88D/O9iavFvR7yyqxZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrDVB9d6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E814C3277B;
	Fri, 10 May 2024 03:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715310290;
	bh=XvObPRnmyqwdGUB9ixy/MMsyTMFrwTNz3Ndw/Y6vDhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PrDVB9d6OC31LgBhux4hfgqqVtftoB22K11jc4G/I9EX4OgfHMJAv/DiAn8SUJQrq
	 0v1pzf26HzYnQDzHxK3+edGLgfC77dZcNDbiK+agP9bPQdKoQhs9SHQbXNZlDpylh1
	 rtne2AyJToLWK2orBlPK0YZun6mhTbcaQ604ocXVUbCBtJ9sLcQuZ1s/tek+HYWxO3
	 p6gLr7sGHarI+etCvBKiynNzN8E0Ey/22mB9jVddoMRbGYM27Pnas/e6bGwB0aftys
	 c6lOXUtFaLI9ExfpPJScNcv7qosImCJNEjReDuNqecb3ox9xc8A99lDhGuceMcIUDY
	 hvsHQvB8U/K1w==
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
Subject: [RFC net-next 08/15] psp: track generations of secret state
Date: Thu,  9 May 2024 20:04:28 -0700
Message-ID: <20240510030435.120935-9-kuba@kernel.org>
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

There is a (somewhat theoretical in absence of multi-host support)
possibility that another entity will rotate the key and we won't
know. This may lead to accepting packets with matching SPI but
which used different crypto keys than we expected. Maintain and
compare "key generation" per PSP spec.

Since we're tracking "key generations" more explicitly now,
maintain different lists for associations from different generations.
This way we can catch stale associations (the user space should
listen to rotation notifications and change the keys).

Drivers can "opt out" of generation tracking by setting
the generation value to 0.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/psp/types.h | 10 ++++++++++
 net/psp/psp.h           |  1 +
 net/psp/psp_main.c      |  6 +++++-
 net/psp/psp_nl.c        | 10 ++++++++++
 net/psp/psp_sock.c      | 16 ++++++++++++++++
 5 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/include/net/psp/types.h b/include/net/psp/types.h
index aad836c1c2ca..a9e406c979a8 100644
--- a/include/net/psp/types.h
+++ b/include/net/psp/types.h
@@ -50,8 +50,12 @@ struct psp_dev_config {
  * @lock:	instance lock, protects all fields
  * @refcnt:	reference count for the instance
  * @id:		instance id
+ * @generation:	current generation of the secret state
  * @config:	current device configuration
  * @active_assocs:	list of registered associations
+ * @prev_assocs:	associations which use old (but still usable)
+ *			secret state
+ * @stale_assocs:	associations which use a rotated out key
  *
  * @rcu:	RCU head for freeing the structure
  */
@@ -67,13 +71,19 @@ struct psp_dev {
 
 	u32 id;
 
+	u8 generation;
+
 	struct psp_dev_config config;
 
 	struct list_head active_assocs;
+	struct list_head prev_assocs;
+	struct list_head stale_assocs;
 
 	struct rcu_head rcu;
 };
 
+#define PSP_GEN_VALID_MASK	0x7f
+
 /**
  * struct psp_dev_caps - PSP device capabilities
  */
diff --git a/net/psp/psp.h b/net/psp/psp.h
index b4092936bc64..a511ec85e1c7 100644
--- a/net/psp/psp.h
+++ b/net/psp/psp.h
@@ -27,6 +27,7 @@ int psp_sock_assoc_set_rx(struct sock *sk, struct psp_assoc *pas,
 int psp_sock_assoc_set_tx(struct sock *sk, struct psp_dev *psd,
 			  u32 version, struct psp_key_parsed *key,
 			  struct netlink_ext_ack *extack);
+void psp_assocs_key_rotated(struct psp_dev *psd);
 
 static inline void psp_dev_get(struct psp_dev *psd)
 {
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index 59066c4db048..f9c5ee57df78 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -72,6 +72,8 @@ psp_dev_create(struct net_device *netdev,
 
 	mutex_init(&psd->lock);
 	INIT_LIST_HEAD(&psd->active_assocs);
+	INIT_LIST_HEAD(&psd->prev_assocs);
+	INIT_LIST_HEAD(&psd->stale_assocs);
 	refcount_set(&psd->refcnt, 1);
 
 	mutex_lock(&psp_devs_lock);
@@ -116,7 +118,9 @@ void psp_dev_unregister(struct psp_dev *psd)
 	xa_erase(&psp_devs, psd->id);
 	mutex_unlock(&psp_devs_lock);
 
-	list_for_each_entry_safe(pas, next, &psd->active_assocs, assocs_list)
+	list_splice_init(&psd->active_assocs, &psd->prev_assocs);
+	list_splice_init(&psd->prev_assocs, &psd->stale_assocs);
+	list_for_each_entry_safe(pas, next, &psd->stale_assocs, assocs_list)
 		psp_dev_tx_key_del(psd, pas);
 
 	rcu_assign_pointer(psd->main_netdev->psp_dev, NULL);
diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
index 58508e642185..7b8a1d390cde 100644
--- a/net/psp/psp_nl.c
+++ b/net/psp/psp_nl.c
@@ -230,6 +230,7 @@ int psp_nl_key_rotate_doit(struct sk_buff *skb, struct genl_info *info)
 	struct psp_dev *psd = info->user_ptr[0];
 	struct genl_info ntf_info;
 	struct sk_buff *ntf, *rsp;
+	u8 prev_gen;
 	int err;
 
 	rsp = psp_nl_reply_new(info);
@@ -249,10 +250,19 @@ int psp_nl_key_rotate_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_free_ntf;
 	}
 
+	/* suggest the next gen number, driver can override */
+	prev_gen = psd->generation;
+	psd->generation = (prev_gen + 1) & PSP_GEN_VALID_MASK;
+
 	err = psd->ops->key_rotate(psd, info->extack);
 	if (err)
 		goto err_free_ntf;
 
+	WARN_ON_ONCE((psd->generation && psd->generation == prev_gen) ||
+		     psd->generation & ~PSP_GEN_VALID_MASK);
+
+	psp_assocs_key_rotated(psd);
+
 	nlmsg_end(ntf, (struct nlmsghdr *)ntf->data);
 	genlmsg_multicast_netns(&psp_nl_family, dev_net(psd->main_netdev), ntf,
 				0, PSP_NLGRP_USE, GFP_KERNEL);
diff --git a/net/psp/psp_sock.c b/net/psp/psp_sock.c
index bcef042cb8a5..7a791703850c 100644
--- a/net/psp/psp_sock.c
+++ b/net/psp/psp_sock.c
@@ -58,6 +58,7 @@ struct psp_assoc *psp_assoc_create(struct psp_dev *psd)
 		return NULL;
 
 	pas->psd = psd;
+	pas->generation = psd->generation;
 	psp_dev_get(psd);
 	refcount_set(&pas->refcnt, 1);
 
@@ -235,6 +236,21 @@ int psp_sock_assoc_set_tx(struct sock *sk, struct psp_dev *psd,
 	return err;
 }
 
+void psp_assocs_key_rotated(struct psp_dev *psd)
+{
+	struct psp_assoc *pas, *next;
+
+	/* Mark the stale associations as invalid, they will no longer
+	 * be able to Rx any traffic.
+	 */
+	list_for_each_entry_safe(pas, next, &psd->prev_assocs, assocs_list)
+		pas->generation |= ~PSP_GEN_VALID_MASK;
+	list_splice_init(&psd->prev_assocs, &psd->stale_assocs);
+	list_splice_init(&psd->active_assocs, &psd->prev_assocs);
+
+	/* TODO: we should inform the sockets that got shut down */
+}
+
 void psp_twsk_init(struct tcp_timewait_sock *tw, struct sock *sk)
 {
 	struct psp_assoc *pas = psp_sk_assoc(sk);
-- 
2.45.0


