Return-Path: <netdev+bounces-201174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D15CAE853F
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 15:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45F55A216C
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3CC2676D9;
	Wed, 25 Jun 2025 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hl79kmRt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E542F265292
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 13:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750859545; cv=none; b=Rhpmzzx0JDk6/qkZko1ms9Zbk33i74+tvzfINNkYOtCSVF2dXcQ4VaNXVdoePssZiK0IZU6Zp+MjSO9ZB+ddAOWbNxYb9PRnaA5fBvNDstDhlmUHgUsb057J05QGuWa+MxToZZxc0GEK3Ffyk5Gzs0bhafu8ApsRhir+tTlYz0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750859545; c=relaxed/simple;
	bh=g1Zf8IpTUnSpnlH9Wz6VOgCSmZq1BY0YiWHg8YNK05c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eN3L/Ol+Q9a2wsaSu2zVXcQF0tLP7VrhAsUr/AON8yNstZ8vosIXXTb7Iq8px9ASITAtAwg8OHZzbc84rCLQ6lx1KhVJr7a2q3DNmVOGzGhKTy8j7UkZsKJAAMTfakTaA6nsBPyxPEGaa+ZrMN5Y3OikhmAGZX9viNeK+GaBQSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hl79kmRt; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e84207a8aa3so4154148276.3
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 06:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750859543; x=1751464343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEIIwMEmIfyz+katoBrQ2miiHS/knGUfWgIz79EqNDk=;
        b=Hl79kmRtmzA4oyCPNtFiAF+X3ARskKVqsk6Kx8/HA/bYQ401vK5hFXDe+gOhkOcaRQ
         a6SsGD8vsMnIiWS6Te2MFZ5u5jZdOJjQHb4RzK/DHTuWThjVa5Zv8Yd78qFFL8HMMrtj
         6o5ywXlofwyHucMT3DmidPvle0sEB1EJbm6WdMHZvlJgwwkDR2GMg9NBNuqTPjzpUq/h
         uH38g2wqFJg8nAwp/8DwN6R0RcItwUPQLjYnsWHVM+bIcsZOOcwT4xNnis10a16aDuu5
         DMmiSX9wGVA7tLoR9zvLgqG1aZSbtp8rAfN1A4S3ols5ZJKbhXfGL3KoEEUJOgT8mYgn
         E+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750859543; x=1751464343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LEIIwMEmIfyz+katoBrQ2miiHS/knGUfWgIz79EqNDk=;
        b=tKEreTzfctVarQjCQQj5UoZOL4xcEXlYAZru615Zpns63UMxDNsKz2izV1tnFKKabS
         euXBWo8PWpnM+1FcOBNkbJCyx5Td+ijglYo0r2tuIky18M8qhgvlYwMvlJtiBLOyouPY
         kdNpX3YgFA/RiCyw6hv/dDgN19IP0qwbwhJIWumCp0BYMPmOn20uIcm4ImkGha0+mkV3
         AlKE/8oGCifnQOd63rr7IK27g2M0mh3ADi/IZmm9y5x5MG/fsVdlJVy5u25iMJu/reIJ
         WinfEv/y/JsKFQsYtzaR/9FYEJN6K91FfjAKzUzbbrhhufv1CMoz+iK6acFlEO9/zlQ1
         RIPw==
X-Forwarded-Encrypted: i=1; AJvYcCVJD9KqQ1xkdU/z8cIJBqTF3V/BQ7XQnE91fYpD3eIrSSJ3qh69UxpbQmjrc+HoCcqlrvshlpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQCt2Pad9Qa9O5Jmfw4UH5hDeQ7qh3TULR6+a8JxE2C3Yw8hBk
	zupcqUzbycn3Mycc8+drxUzEGSrWc8cHztuVK1+PEm0kO52OmJX/Lwod
X-Gm-Gg: ASbGncujiARkdVQU+1/7toNzG8kb/SBEwSRIeuZPTGD+vEKQbCNrStcz8sMVW2UVZ9t
	S0V9MX0pDRX9sWyEk/cs6JW6LAyCWE+1MSkD3TYJIqyeL4mMWWEBE5BdKXdHREj3p75k9TFtnCV
	re2ohCpjJugHTvKOVuwWO81dHNg6LhQedJa9Nh3TttiSFoh8+nbrmNl+V00Yk1k81tgufDAAaiZ
	LaaWh5KApt+SdGeBaT240Xv/SRpRRogLzxoBZtWgh+hJGyey5C8DBOWgV8z9qNuaz/WLma8ItKJ
	U29BHzYpQVEENMo0a203gnps9a7timon7UdR/5bZU3wqbtlZ3vjVVgK+/tbW
X-Google-Smtp-Source: AGHT+IFEqHQoN4zyoszWY8w7PfXGpPmcW76VeuOPkoo5fxsA2/9CJy0lPAOyWJD5yGU9/U5+3wmjng==
X-Received: by 2002:a05:6902:709:b0:e82:28a6:e828 with SMTP id 3f1490d57ef6-e860176b5ecmr3023856276.1.1750859542821;
        Wed, 25 Jun 2025 06:52:22 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:73::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e843304e7fesm3193081276.21.2025.06.25.06.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 06:52:22 -0700 (PDT)
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
Subject: [PATCH v2 10/17] psp: track generations of device key
Date: Wed, 25 Jun 2025 06:52:00 -0700
Message-ID: <20250625135210.2975231-11-daniel.zahka@gmail.com>
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
index 5b0c2474a042..383a1afab46d 100644
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
index bf1c704a1a40..99facb158abb 100644
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
index 4bfd8643de4e..80f21792a717 100644
--- a/net/psp/psp_sock.c
+++ b/net/psp/psp_sock.c
@@ -59,6 +59,7 @@ struct psp_assoc *psp_assoc_create(struct psp_dev *psd)
 
 	pas->psd = psd;
 	pas->dev_id = psd->id;
+	pas->generation = psd->generation;
 	psp_dev_get(psd);
 	refcount_set(&pas->refcnt, 1);
 
@@ -251,6 +252,21 @@ int psp_sock_assoc_set_tx(struct sock *sk, struct psp_dev *psd,
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
 void psp_twsk_init(struct inet_timewait_sock *tw, struct sock *sk)
 {
 	struct psp_assoc *pas = psp_sk_assoc(sk);
-- 
2.47.1


