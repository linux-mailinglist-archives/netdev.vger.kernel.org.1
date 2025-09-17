Return-Path: <netdev+bounces-223808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E33B7C643
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901101889615
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 00:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA95A1898F8;
	Wed, 17 Sep 2025 00:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZwItjQAa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8F9288DA
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 00:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758067810; cv=none; b=ZgZG8h+xhqahdgNMsj1teZjrqZP64IYt9RKuGFo0QMT8Y2ZPDtQ9MrpCdhZBDUq8GPhH6mASA4g8TATmmOK9QortN4C8DUy8bIk7e1AN/x+I6pcgh0ekGJuBLWIZC1RBwgTv2bsxXpehjAIQhoULQ/zn6NM1gtwKvT5YqNYYVno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758067810; c=relaxed/simple;
	bh=2AFIwmU8FSYYIhlxMB6VkOuMgvDm95ic7bhTckFrNko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jtEZY1hKAol2q0cszjjCXK5f364DcnAbQOwggv72sS1eluDhsfO4fFGS2zoUvhELVy/Z4XxYlU6xLwh+ZYky2ajSG6CaHjr26yabgV7S0MoJMIVLtvQ1mhDUVwNtX4pSbyW5THtbdnd8oRZfQWv4Q/8Zkg0QmSTt580TLwwhIxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZwItjQAa; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e951dfcbc5bso5879414276.3
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 17:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758067808; x=1758672608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=euYPHbO3IfGpmle4Iw4Hxb9thWUKXY+ytnj3U1MAOTo=;
        b=ZwItjQAaKZR7TddaZVUEMW2XsiEbWj68pUzXbceStPCWY5EcSc2MByaneYbqvk9v15
         Fz8RRb6bajKw5ir7Qqtrl7ofH9KMwng7schmm+YmaNOtW0L9kOg0aPGcSPmF3sleeWqA
         RRb0REP83KCRIwU3NBDKXi9ye/PRMXJ8L6b2AHzAzfsD4xxSLadfLdR9GNqHb6smBOZC
         J9D54yyP7AD8wK+OSTAc7uYqLHX2Bn1tMiIfcICCYog1C8jpL3TfSCsA0DHpEnIufEjv
         /ZfUzE/WPpABhqoEjzonPMeMQbxIZ8qHDLIk2VSTgJ4XiMDEuGKwFj854Zfrs8H9jnXN
         xJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758067808; x=1758672608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euYPHbO3IfGpmle4Iw4Hxb9thWUKXY+ytnj3U1MAOTo=;
        b=JsrFo0D2ROFcNr54A50z0DoCHdzcQ//xBdwhVMaN6bUrXZ8XxXTHngb5XUlJzJZn1E
         iUvQetmknpCFQb8a0Vqatcxf4Zd7vUv4u8usjvSAP2DicHlFv9nE0sGX9WG/Di9jQRIx
         jeuIsKNoo2ITqZhKHLJl3xyCXTwEW7Fcl7h6vIzsLQaWzpYCy9mMmR5VBgQ1TXwk97a+
         FCNw6nxpgpZcHHl1DGxcTKzL/HcAWfzBPKF/FioI9y2afTLvEW/wlnf5Bhgso1y1y65W
         GfuCcmqD70sV0KCdPUiWcVu/U59aMHLj8HOABEhwTHYYXwBerUtuUPkNLTwogirsUvuN
         dEIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy10E9ipYzZzjsK3UOswODC7dUP/J1ENkIHCzIdOCE6UZjchDPDblyXSX8tgUO/zIHSMillkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzwF+Kj/wNT59GOVCsZmFUN5O1lK7k6XomG9j9M/+SLsX90Wrh
	HS26b3vNITkTFFIhzUS5SR0Cg+xAzfwIGY6FFbfr8a9zR+lWWwQVAtzV
X-Gm-Gg: ASbGncs4pz4Pzz92bxf+1O7P7kZKiVugGq8AmKGzjhf+JZleeV6Yg7TaET7u0WghE5a
	cFPPsh5DTTvDNRBrCOUCUihbSEDdlkkVYz7mLO8nZj5Jplvh+1barVKpG4rHY7m/CtZL5zFiInN
	rZBc1u2AfCHI/t2glglcc5YELOWvNgzJoV6jcXpw40VjxrarCPJKIGLB0avlMSV2/kcE0JIyGf3
	WnpeQI4hU/Fh3s0DBgJWlYUZu3zBITLceTzv0quPYlADetJ+5T/sEpUQbM4Ihg5HZHWPpFlZV6g
	KgscufiG1RoRsc2I5ySFysL1gahdRb6xL7OreFlzNnMYnYB4hkl7gYLQqskmUli2ase8nr+zyrL
	fhC1Qx6t/YNHpSg0iHbc=
X-Google-Smtp-Source: AGHT+IHkWiHHfEVIZwZV8mkaUOfE04BR3AroR6s664Or29fCyKeGHTYDlLqFXhQTsX89VuU4wOIcIw==
X-Received: by 2002:a05:6902:dca:b0:e97:cf:fde8 with SMTP id 3f1490d57ef6-ea5c057cf36mr292935276.21.1758067807848;
        Tue, 16 Sep 2025 17:10:07 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:2::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea412f48afdsm2238973276.23.2025.09.16.17.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 17:10:07 -0700 (PDT)
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
Subject: [PATCH net-next v13 10/19] psp: track generations of device key
Date: Tue, 16 Sep 2025 17:09:37 -0700
Message-ID: <20250917000954.859376-11-daniel.zahka@gmail.com>
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
index 10e1fda30aa0..afa966c6b69d 100644
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


