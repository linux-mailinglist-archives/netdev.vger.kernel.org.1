Return-Path: <netdev+bounces-215228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5E5B2DB12
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 13:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B7417BCA5B
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 11:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCDB305041;
	Wed, 20 Aug 2025 11:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwPHyinr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B53A3043A5
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 11:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689495; cv=none; b=qYfgWi8zWCTj9VtXSEKgJGSMu3/eoTnXi/iPSNZEXo6mKsnhSeQVqwsfAnZOrUf4qREVJf4zfA7l213EujlCayhkvDrUbobZQZPnLdtPpUTWf8EFyt7XFZ1DCTdrMsJedMj7/TK79Uph8NtqNplbHhk3d5VKMvD6Pg9L6IbNPlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689495; c=relaxed/simple;
	bh=rPRgzNL4bPU/i06ENpnBmYg7okrE/jti2fQ3NNQNN/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5dLZXHdrWT8rW2B8uX2i6aCPf2Pq1y9wXAE0tkjsn2v30ZQRZHSGkZmheote8EfAlTFQSbTHC6ZlkaLELuwDU0kJNaQi7BGUDkk58D1fop7Mc2orXV3kH+vEmoVQ0zt/TqHPmsgfXRd/2o8sCujvK3My8OlLjnHsL12sLSkIEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwPHyinr; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71e816e7f09so26548697b3.1
        for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 04:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755689493; x=1756294293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B/qzcyKs6Sijhx5eKCyG5tFaY81xPaszktH0lekGR70=;
        b=CwPHyinrLnRKUe6Nl6aL4DJSbHJaOe8VX7oG2+RuevqX19l1MUTxO/wSSPzp0OGdOs
         IFc01Kb6X9z7xhOc720zh5WHEDtXddDdrtFFYaj4RTAXNP9WkmqL3J/569NS+CL7fanD
         hdaig6cdTHukJ8O9mjBhRWZiLs6e9UaveI/mQtSRl/pkLJ2FnY7sEalF1SgSv7a9voBc
         yaL8kH0FIVu5f9uW62jtDChd8Xr0SRxvcJH0HjZeXjs0vfUJNv6uarmHBfcF/ZXY8tz1
         D0TtpBCS+Efdm4UCMiiELdqpjdEByZDGlRpMgN5jHPDhE4z27BEFFLXZU4gSTZoPoorw
         wnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755689493; x=1756294293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B/qzcyKs6Sijhx5eKCyG5tFaY81xPaszktH0lekGR70=;
        b=W9ZL79EWZsnnt/0Ip4zBqXnXHLIfTcp8NQRM+ukkUS4Kv2LprZy93qT0J91eRu2NC6
         twktNGf2HI/KfS6wbPIASTIJatsSYASiGMDKoD3KgQGpgcOP02pSmczd0EyOhQXlugT5
         EWf43KfBQo1JJQRhdr1msdObDJrJb/pQyXNtgV/vb5CmQJeQBZDqx8Rl38kysT1LDNTW
         fpqwwcoLNPc/glWmrTMNx72Hxod8neIgwnnFWjpr/r3GldGEg99/qd5eduR2ZE0y4QEp
         eHxeQP21rYN3IS9TzmWtQEMNNR7vs4edLa1Nqnepa+Zau5XkbfHAeBpCb3+ZB1mjzcqo
         9M+A==
X-Forwarded-Encrypted: i=1; AJvYcCVtdx6EzxZpM0X4N25h3fu/pv68AP6VK34WThpL9sPWARBR2HtqdL5wV2V8bMzZ/b6m6p0X+Ek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz43PZ8mgZ3AALde/24Uhkenhqv2ndBY7a5/bKmlGJwqtDGgtdg
	WwkFrnJff85tg4blzvZBCNJXR0kyq4Tmu5UjWm3arxoorrsskmmpzi6I
X-Gm-Gg: ASbGncsgeKX5dpmMjpAH+S5MO/Jnzonci4HrXI6uykmX7fDzzclz8AS5YaiBiqtdZOw
	cT3ax6lBbsRW5yPllvgO+YaSsHuS3Vu6ujaQRAulwdAs8IbFY2Sk2EHYOC7LdCUQcyQB1Qb6wQV
	+rYGZfoLLHcgmclVpmb+g8hwbu0qiT+lGdi40ctzd2Dk6i2n7RqBPI/B58UqxjIi9mxYcS/8FTB
	dnEzto1cWKC9LpFv0Yn8scGXc08gJ8PvJW0MlG+6Ggf1Eyvs+aRGbSFxX14OByL/2Ey8BUehDVE
	Je020IT5YCGzh5pAkYCAxvLWSB709kCxZ1bZZYBRAJPnT0YiQYq60ysy9Y3lOr+07k+aep3OjYA
	wi/KFw1ujfI+8v9gBz41WhwY230X8Kv4=
X-Google-Smtp-Source: AGHT+IFwrz52X85dTYN2sqAWqPb8LmJdSH5EAwPKt9q+rRPU5TT3/5Swnnt0qpvvuQyJ5JWkTvA89g==
X-Received: by 2002:a05:690c:63c7:b0:71d:5782:9d4c with SMTP id 00721157ae682-71fb32057b6mr31229057b3.28.1755689492923;
        Wed, 20 Aug 2025 04:31:32 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:59::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6e107145sm35830417b3.70.2025.08.20.04.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 04:31:32 -0700 (PDT)
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
Subject: [PATCH net-next v7 10/19] psp: track generations of device key
Date: Wed, 20 Aug 2025 04:31:08 -0700
Message-ID: <20250820113120.992829-11-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250820113120.992829-1-daniel.zahka@gmail.com>
References: <20250820113120.992829-1-daniel.zahka@gmail.com>
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
should track device key generation when device keys are managed by the
NIC. Some PSP implementations may opt to include this key generation
state in decryption metadata each time a device key is used to decrypt
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

Reviewed-by: Willem de Bruijn <willemb@google.com>
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
index a1ae3c8920c3..98ad8c85b58e 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -72,6 +72,8 @@ psp_dev_create(struct net_device *netdev,
 
 	mutex_init(&psd->lock);
 	INIT_LIST_HEAD(&psd->active_assocs);
+	INIT_LIST_HEAD(&psd->prev_assocs);
+	INIT_LIST_HEAD(&psd->stale_assocs);
 	refcount_set(&psd->refcnt, 1);
 
 	mutex_lock(&psp_devs_lock);
@@ -125,7 +127,9 @@ void psp_dev_unregister(struct psp_dev *psd)
 	xa_store(&psp_devs, psd->id, NULL, GFP_KERNEL);
 	mutex_unlock(&psp_devs_lock);
 
-	list_for_each_entry_safe(pas, next, &psd->active_assocs, assocs_list)
+	list_splice_init(&psd->active_assocs, &psd->prev_assocs);
+	list_splice_init(&psd->prev_assocs, &psd->stale_assocs);
+	list_for_each_entry_safe(pas, next, &psd->stale_assocs, assocs_list)
 		psp_dev_tx_key_del(psd, pas);
 
 	rcu_assign_pointer(psd->main_netdev->psp_dev, NULL);
diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
index 1b1d08fce637..8aaca62744c3 100644
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
index 66abf160e16c..d74c86437e9b 100644
--- a/net/psp/psp_sock.c
+++ b/net/psp/psp_sock.c
@@ -60,6 +60,7 @@ struct psp_assoc *psp_assoc_create(struct psp_dev *psd)
 
 	pas->psd = psd;
 	pas->dev_id = psd->id;
+	pas->generation = psd->generation;
 	psp_dev_get(psd);
 	refcount_set(&pas->refcnt, 1);
 
@@ -248,6 +249,21 @@ int psp_sock_assoc_set_tx(struct sock *sk, struct psp_dev *psd,
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
2.47.3


