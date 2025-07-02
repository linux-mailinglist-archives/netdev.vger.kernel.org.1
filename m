Return-Path: <netdev+bounces-203455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8DCAF5FA4
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 19:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95FF448725B
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 17:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10370303DFB;
	Wed,  2 Jul 2025 17:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0nizgjv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AE2301121
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 17:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751476422; cv=none; b=tWhBL+ClwrTwXqvB6Ms75v8EtU7er/Kwvmw3hnK8RYn+eB09kThXVEALZLaIhL0SPpOc+QKxF2iILppUXVR859Ko5jIuagJ7TA9sVksp2qpt7pnBzLi2R5XYCfQp88ddlVh1esqlIsSTO/BSb9jWFvns/xQCDzes7l4dyUpBePQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751476422; c=relaxed/simple;
	bh=W2VNVLkg3BllPkB04JqrXGhwB0XcV84LzLrYu/rfVPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcLDZfqZRMiWheIW21y/O5OfX5Ss6SCJIu5olDTtRaLIkyoHF1purc9Q5Zc6n1kV+oF0sEHuwnVXXZAZJ4ZY0M8GRx3tdJNOg+weFp5fyQ26O+L4de5Bu6KpLxZAMme8rsefJ2Ku3dI2NkZyx45iL63gCVhZqYKhqPpB9CthH6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0nizgjv; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-714078015edso51142757b3.2
        for <netdev@vger.kernel.org>; Wed, 02 Jul 2025 10:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751476419; x=1752081219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZdElbTPv2NSlU9Jg1h8q+VV5d/ifaczNlGWBbpLyH8Y=;
        b=J0nizgjvyuMK8I9f7/Yj/HHmFIA/BKS18QMkaMez4pYOBSGKy3zya6AGEhGNO6yxvs
         DJIHO7r7V0/5me42XqMN7BsyHCRFAF7L7Rky62sUgA35a7xz9FV/0TdVdCY2+byf4G+a
         wX6XM4M/tQ4GyiTJFZtohciGPnG/0TMeVIbx+GNK/SsbWwOzfHFV3qY1/zWzKkaNOXtk
         M39LD+JmVjsLNIokzWMuRJtk9mV4diG79FHEyI6mnb2uvMCXOjGCQN+5nG3rVpJeAjqT
         1YYg7gQuIgo7ZADleXvooWs4PyrTAIrnUIc1bqyfgPWw8/ppv20SomO58vQgVRaaNJJp
         UppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751476419; x=1752081219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZdElbTPv2NSlU9Jg1h8q+VV5d/ifaczNlGWBbpLyH8Y=;
        b=cGueBOySIlVbempNeHQ4JlWFvi+mNc4GuFw0AhkDe1qq1Y/N+nO50c1LPwhkYjL4K9
         y+sAt9mY5XU6wPmhVT7REqbkGGWGsw/yJaQI+pAAr7r5EyIwfHqYpGqW4BY0Zs10rejy
         TcjFVLCH6cslUVQIhLcMmtKWdbCiriYy8ZmxYWi6pkkdB1ty8OSFzSZ53idOtdOMTxAb
         v5Jyb6wkBjhL4QlPbs3x0DrG5Lwp0il3Am/fq53FtE8HAQRPJUZ6Zw0tvs+5GvWjHoaA
         eCkwL2MMbvllw9C8ZMGh/1YCzH0wCSqZpTY+LP2kXbpC/y3kvL2m+VVOo7RSrzJioIqT
         iBjw==
X-Forwarded-Encrypted: i=1; AJvYcCUhSec/jWoFeY2YT/DlvIvOaaWkSpNrAPYRtMJUje7baXttwBCu5ui/LVaNLfc0QLNBhRp6tsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyNikUVHS/bvADpVxufwaGK575InuX0pUfRCRUTdnxAgZwW0Xx
	DnUTVCMUOoYkAjYkTpXsGagR5v1hgca7q4femEI/Ryic8wo6zUDpt4R7
X-Gm-Gg: ASbGncsezI2+SYs8DPDrPABDc3uOV362Rd3a5PPZ7Lz5B1I0ih2fdNM/S2OhUaEK6FP
	E9iDoAA8sfN9urkGB3UyPjhc5jgGEQgbdXoWKs3iv8haHaZugUylCxrH9EzjwTJ/RSN+2eU579o
	ISJ1OOQ6czKPxG27KbtBSYhpIHPbVtLkxdnJFvixwZtJpMG8yy/Zo7huDJL5h9QmpE7nqiSslso
	WdfeSNF4V7IwoezQCxStWtXuz1rTs3yuekesnJbixdBrWS6N4sFiKQi6z3Zco5mbI6i/5PKhr7K
	80kGSb8fpb8PaaYdOBVcsxpBmYMO/jnTtI5MK+virtFLr2xSkYwCwz8s8hyx
X-Google-Smtp-Source: AGHT+IElBBwxPQj0IUFu4AcOvDT8Rvh4FnXe7thaKc7Y33TKIQvT3gpOjsZx1LMd2oRo/98NRKPDKg==
X-Received: by 2002:a05:690c:6c8c:b0:70d:ed5d:b4dd with SMTP id 00721157ae682-7164d46723amr52222917b3.25.1751476418948;
        Wed, 02 Jul 2025 10:13:38 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:53::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515c902a1sm25545577b3.74.2025.07.02.10.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 10:13:38 -0700 (PDT)
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
Subject: [PATCH v3 10/19] psp: track generations of device key
Date: Wed,  2 Jul 2025 10:13:15 -0700
Message-ID: <20250702171326.3265825-11-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702171326.3265825-1-daniel.zahka@gmail.com>
References: <20250702171326.3265825-1-daniel.zahka@gmail.com>
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
index f97441935d12..8b5cb31c2836 100644
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
 void psp_twsk_init(struct inet_timewait_sock *tw, struct sock *sk)
 {
 	struct psp_assoc *pas = psp_sk_assoc(sk);
-- 
2.47.1


