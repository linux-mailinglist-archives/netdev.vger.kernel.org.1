Return-Path: <netdev+bounces-212684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 416A0B219CB
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 02:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01EF4171AF4
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 00:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DB32D6417;
	Tue, 12 Aug 2025 00:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bt33F+lR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536C12D5A01
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 00:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754958625; cv=none; b=oSMyNgh+Z6jO7cs9MYc8QgSnmpvrg8ouD/ajgl2pLaSdpijxgGLdh1HX41Dz4cesC3tZLlobwjAdNgPjHYfZtp6urNBKiaFiSiC2iPb293j5yiHX4QOWil6Vb/Tc23fHuI1pm+et2K8Labs5/EvMK9XOJf9WNF4eP6XkrK3JLsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754958625; c=relaxed/simple;
	bh=57ARZPugAnAwMxgVfrCNDY29Q62sQS6PGto+HqXT544=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POrQa52uUDt4lAj1ioNeD1ZY2efVtYM8UYgwL9No++gXZt0LA7UynNVtzVrO9jtaydVN3qTHVQ9hcmb52rYLM0NtQIOfSjWlk4HJx2+uTCVxc0ZQ6IGvcdTxZodCzVSboe1WFx1Qx+Z3YMCOWXEXFPUJl8wFdG5k1KVMQw6ztqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bt33F+lR; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71b71a8d561so56036237b3.0
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 17:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754958622; x=1755563422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGorfvGeHkUL+IMdnYp67EncfF5X/CD/lz9CXTBi6so=;
        b=bt33F+lRnmrY/SgXVr1sK8N1vLnd0IZHCY8R8Sf6fvL+MRo0FGLwMi6fRz6urpmi0/
         KIFhVk+zhWPDzLn+OVMETzjDIw6rOAoXTbmGo1niTXFVjYVWpbV5L0iwluB8K8GAZuGt
         TVXgTDumyDcYb1H6zU38qP/CmgpWOvbNbKrVf7N0LMPV6BZSJXF8mHrOZ92V60CjiPJ9
         HAFLKBTDYuwyvNYsufKhVSigjkz/GWkyOGqlsZ0Cpmv8k6RpZCiDdBqJO0HeEAVJ3Coc
         APCFq6XtYfNjEBiiazHSIEWtfL5S7SRupHXKQoi3xKFW02NLKKhqRE9PTmaKQhevYdP9
         3mSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754958622; x=1755563422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wGorfvGeHkUL+IMdnYp67EncfF5X/CD/lz9CXTBi6so=;
        b=pY1W83+fD5n3fXtOm6eAWeKxB1rVh6Shvq956S+5QB1+zPVMgmmmKgMGDe77Jklzgd
         PYCAL/j3YYz7EWNY5CvwYZS83B0AKwpVCyZk4ZRKLRRNir80PmLk7B7BKAhOZIVypfpN
         2z6eEwouYG5A5UgT0mA8UaX7xQxrA9KvMpnSZ8wP2ZhBzKdJ7D0PiC4eBoSTZjgtfH0X
         4igdClf4oUEgrkJaAw2CKBqmKTIna1UlxDi/h1Ae4e9H1bStOu3JWODESLQXUwG3t/cW
         Er7vZptZ3BJtIYyDOjpCFz8OIqPt70gZ7HxwD5xfVDay2Mi362AxtpLvDGC7TDeTY0D0
         H+TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWONnVhG5jI9doKWqUAkj4gMrnbdpk0bbgSm84LWdJV/TL+5esuvbKzImIGJlJos5A8XCCulPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLkP8RcyPg8n6FhCscsNVrKBux4sgeM/yqXAEkHgVwW7nzs2Or
	tzO6UQ9GuBQn5fKxWOGhrxuuL/VPdZx5I5FU+A8MYdIdo9Jxh4MgVDsy
X-Gm-Gg: ASbGncs5+Nq59wu4V5P/hJsQHaR2USwqIzxHBPn1Sr1om+N0q/Jkq3d1gadEqpD/lTq
	tsyEiVhxezGHrro7vM31JgrvBwCd77ShxeQj49Vn9t9IFP9j74K6mDi+i6lbjEPEuN6YJfrhOAa
	deweAKr/hRKETU+ZFnAVrrMn0T7jsm09AcTvFJ5KJH/aDr7WYoPwFnNdBu+CRo8RVeEvIObJwJG
	BnwEtFtM+6xDfetskrRaGBUfC07JlDDQh/8eGVcbdabR0X7YDA+a4xnKsELpjiLO1IyA+Fz7VJT
	7luupHBJ65wI0b/kAziViznMowYaIiP+mL766jiMjHpnFHgc1whDU1Wnr0OawvpayUhnnbJwDoJ
	V1j9nNrCojGMEFiTWRE+w
X-Google-Smtp-Source: AGHT+IEtSqHPxM50EHYsORRQz5FOhKAwlV8jU3lYWk1qS9Q/ClpJ0S5wGHpUTQFfri6bW3lv5M+nQw==
X-Received: by 2002:a05:690c:38c:b0:71c:f09:e3f0 with SMTP id 00721157ae682-71c42f97562mr22683767b3.20.1754958622180;
        Mon, 11 Aug 2025 17:30:22 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:71::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a5cdfc5sm72469567b3.77.2025.08.11.17.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 17:30:21 -0700 (PDT)
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
Subject: [PATCH net-next v6 10/19] psp: track generations of device key
Date: Mon, 11 Aug 2025 17:29:57 -0700
Message-ID: <20250812003009.2455540-11-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250812003009.2455540-1-daniel.zahka@gmail.com>
References: <20250812003009.2455540-1-daniel.zahka@gmail.com>
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
index 50302ac9fcee..7fded3d798f6 100644
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


