Return-Path: <netdev+bounces-207494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FC8B0787F
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 16:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34AB31C2072A
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 14:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723B02F2C5A;
	Wed, 16 Jul 2025 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvIMo/WZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54D02F2341
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677173; cv=none; b=dCNKP8jpUvGlXxQxiRtJ2wXRYGOIMbb2wlVn6RzQ33QC30DcahzNPIR7AORy0WkwjMqG3syZ/ESafZkoTdAJD9KJx7P1uEKAZEIgqIhz4teBWiXOZ6587wGD2qS9IQyV1yl1kwN4334G1IU6tRdMgA1T4t3G7uuqydUHLrhm9DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677173; c=relaxed/simple;
	bh=45iL8caNUZc7zH74cvgpu+rYbowtc469WyrGPiJmvto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gC6TfFmKSJHoyXZzDzAMrPgk+P1xpOAa6/g08mZ5MdFLNlgG8d+W2ConAkchj0yGqaUzyqcebotYnLD2s8TTSuVMoV9xANWZgep40JGNlT/s5KtfwduQ0uMmxj/xSRToNNXJhSELTfzYR/piNrkIXqYR26l/T4tTUoNgYPZmP34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvIMo/WZ; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-71840959355so4589577b3.1
        for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 07:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752677169; x=1753281969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSD+P3x8Y6K4AOH4XwL8ItL+b7DP/L+yE7GqhvU06/0=;
        b=UvIMo/WZ46gZg9H/qFl18M4dEPdySkNiwM64LVdAwo9Pcnt327xU8xKhFv3CTa8rn7
         M1j1T/GT8Ir7tFd08VdC4aVpn7B9iQ9qs8cjgBxRQkTOU9zZS5W2ak9xucuBm++mEFw0
         uTl0tghdooylfN8k1J8649fgnvYli6tPFBBrmBOvJR2anjhF6hMWIkL9Nmib4yU6KaXj
         Ilq1PpT+KMaN5NfG+LIEsC0ltAlhqcGY5SwUuqQiTwQ6jJMpUNbNT6SyktbVsGT3doYI
         qpoqU7TztXC7BuLsfuM9IysBlZqzHqCsZRLdwRw45EWOb/nkQdibdUfiYGjdY4pf0Yby
         6w5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677169; x=1753281969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSD+P3x8Y6K4AOH4XwL8ItL+b7DP/L+yE7GqhvU06/0=;
        b=qJ20eNXK1hwiR+MVyiRFZnVt4g1Qa7NliaWAMyq8IEvx3RK7sJPE2JeadPj3z361al
         SCkGDJarJ6PjgKjV5BwvdiSv9o8oSull9AqmAGuNP2XBEblHZWb/KlD1gr/CQc+w3QUm
         746LKqHPNMs4AlIirZSe0nulpdXMMR7qbE+YHbbxKf98zdw285tu2zwnIOP5txUdcqN9
         X1ubf1uQ6sO+9Kbsb9xE+nl4xWAZTj0G4hRbxoHeNOuqtKQM9Xl+ycGMLRL7SefMimQj
         //R/G3f50++4y8Lssh8RX+wGMSV249yiD5XYAs1BTxSQtxwISmIOgfltpKkEvO5E1lYM
         RPlw==
X-Forwarded-Encrypted: i=1; AJvYcCWc8aFEw7stZettx9movxtFjUM7JsbJR8kGdy915R5rFXorhTZk3wDDtO/a/UvV3iCx9srpA9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS1/4IEl4eWcSa6UxTKAE9Je+fg46z28AQeCaEleYNbif9ui5O
	G8Ert2/7euH82h7j/qmKt9vR1WRvjIIKxzVzG/aohaFm6MPU5CPQQ6bg
X-Gm-Gg: ASbGnctSmNbrowx56zqXnewRLNJjdBec2Plhrim2/IlTI042k5Xr3LNWLU/v/YnNEaE
	WS5uNjLoVPUfLnxxHuoLReOzMrBkqQTzJ2KaSJRt/YeTl8v5CQaOw5sVW9AabqQv1+ApoxGa2mI
	JCYf+OsaSj+p1YBeHIsdDdAd0sx6L9yZhwTI70dU4uSwe4U7iNDHIHl8wSTQoMQzkvBVPXV+YWH
	KCEQNghTEYrGWWfFV1mzSSBslh+ld+oulSycBqHHO0jMTfJtOcNts0iWN7vjHQsmTBDyFFHBoit
	AMi4NYMvHRBSSwShUp2aWqMZXLDaSoNszQ9una2P0ZN5qlyKMmjgWLG22vuDctKR7HUj8OZcTgY
	2NAJt9L78+mGQ2jaufHk=
X-Google-Smtp-Source: AGHT+IEtLTW40RftDvEAczoZJikTQz/XkV6L6fQskWkyp+DFA2pWhPYl5p4A6Mu4cGjMKBlwmooHKw==
X-Received: by 2002:a05:690c:4b04:b0:70e:7158:6fda with SMTP id 00721157ae682-71822c8e4c4mr112893327b3.9.1752677169195;
        Wed, 16 Jul 2025 07:46:09 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:9::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-717e4590f5dsm23087427b3.90.2025.07.16.07.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:46:08 -0700 (PDT)
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
Subject: [PATCH net-next v4 10/19] psp: track generations of device key
Date: Wed, 16 Jul 2025 07:45:31 -0700
Message-ID: <20250716144551.3646755-11-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250716144551.3646755-1-daniel.zahka@gmail.com>
References: <20250716144551.3646755-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

There is a (somewhat theoretical in absence of multi-host support)
possibility that another entity will rotate the key and we won't
know. This may lead to accepting packets with matching SPI but
which used different crypto keys than we expected.

The PSP Architecture specification mentions that an implementation
should track master key generation when master keys are managed by the
NIC. Some PSP implementations may opt to include this key generation
state in decryption metadata each time a master key is used to decrypt
a packet. If that is the case, that key generation counter can also be
used when policy checking a decrypted skb against a psp_assoc. This is
an optional feature that is not explicitly part of the PSP spec, but
can provide additional security in the case where an attacker may have
the ability to force key rotations faster than rekeying can occur.

Since we're tracking "key generations" more explicitly now,
maintain different lists for associations from different generations.
This way we can catch stale associations (the user space should
listen to rotation notifications and change the keys).

Drivers can "opt out" of generation tracking by setting
the generation value to 0.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v1:
    - https://lore.kernel.org/netdev/20240510030435.120935-9-kuba@kernel.org/

 include/net/psp/types.h | 10 ++++++++++
 net/psp/psp.h           |  1 +
 net/psp/psp_main.c      |  6 +++++-
 net/psp/psp_nl.c        | 10 ++++++++++
 net/psp/psp_sock.c      | 16 ++++++++++++++++
 5 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/include/net/psp/types.h b/include/net/psp/types.h
index f93ad0e6c04f..ec218747ced0 100644
--- a/include/net/psp/types.h
+++ b/include/net/psp/types.h
@@ -50,8 +50,12 @@ struct psp_dev_config {
  * @lock:	instance lock, protects all fields
  * @refcnt:	reference count for the instance
  * @id:		instance id
+ * @generation:	current generation of the device key
  * @config:	current device configuration
  * @active_assocs:	list of registered associations
+ * @prev_assocs:	associations which use old (but still usable)
+ *			device key
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
index defd3e3fd5e7..0f34e1a23fdd 100644
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
index 1359ee7f24f5..0fdfe6f65f87 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -72,6 +72,8 @@ psp_dev_create(struct net_device *netdev,
 
 	mutex_init(&psd->lock);
 	INIT_LIST_HEAD(&psd->active_assocs);
+	INIT_LIST_HEAD(&psd->prev_assocs);
+	INIT_LIST_HEAD(&psd->stale_assocs);
 	refcount_set(&psd->refcnt, 1);
 
 	mutex_lock(&psp_devs_lock);
@@ -120,7 +122,9 @@ void psp_dev_unregister(struct psp_dev *psd)
 	xa_store(&psp_devs, psd->id, NULL, GFP_KERNEL);
 	mutex_unlock(&psp_devs_lock);
 
-	list_for_each_entry_safe(pas, next, &psd->active_assocs, assocs_list)
+	list_splice_init(&psd->active_assocs, &psd->prev_assocs);
+	list_splice_init(&psd->prev_assocs, &psd->stale_assocs);
+	list_for_each_entry_safe(pas, next, &psd->stale_assocs, assocs_list)
 		psp_dev_tx_key_del(psd, pas);
 
 	rcu_assign_pointer(psd->main_netdev->psp_dev, NULL);
diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
index c4b1c5f9a602..89d9b2a2e8e3 100644
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
index 7aee69ed10cd..3941f5c912df 100644
--- a/net/psp/psp_sock.c
+++ b/net/psp/psp_sock.c
@@ -60,6 +60,7 @@ struct psp_assoc *psp_assoc_create(struct psp_dev *psd)
 
 	pas->psd = psd;
 	pas->dev_id = psd->id;
+	pas->generation = psd->generation;
 	psp_dev_get(psd);
 	refcount_set(&pas->refcnt, 1);
 
@@ -243,6 +244,21 @@ int psp_sock_assoc_set_tx(struct sock *sk, struct psp_dev *psd,
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
 void psp_twsk_init(struct inet_timewait_sock *tw, const struct sock *sk)
 {
 	struct psp_assoc *pas = psp_sk_assoc(sk);
-- 
2.47.1


