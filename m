Return-Path: <netdev+bounces-209525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A378B0FBB7
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 22:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 059857BA1C9
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 20:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84A9245012;
	Wed, 23 Jul 2025 20:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIH95vRv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD6F20D4E9
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 20:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302933; cv=none; b=t2nGU+GuTPOU8aqb/9DkLySXGmgIcc4Jouhwsc8AJgXhX3mZjsvatnUghLpAeXPB0SkwYps2k+nIwTX8urkeU/ZwerjnUFSGWXemznBZtM3whzoNgWsilg/KOB2B2uc+k8I0rEtv4XKvi0B7Q7Nut5aVUUB2Eq1+rg0vChs/Q90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302933; c=relaxed/simple;
	bh=45iL8caNUZc7zH74cvgpu+rYbowtc469WyrGPiJmvto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JxKGZi5kf4U4pTxBSATU2LAy4SYcPJKYbnK1JPiyWflKGwsMlR8G7wb++6JNdgUbBmdZmSa8CfyseL/r8AkBxzvu34Afr+MfoZak1AfW35cf0d69Y36scK9eTL+cd1t+kBkWOAWcjaFloLG3fdDUSJVjEBz1zRY4J5o2M6QQ/Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIH95vRv; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e8bd171826cso193693276.3
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 13:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753302931; x=1753907731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DSD+P3x8Y6K4AOH4XwL8ItL+b7DP/L+yE7GqhvU06/0=;
        b=nIH95vRvg9F0cdlJ9aT6ZdNpB5FAOwPv21wIXrk3Hq2cOODjQLwMpvMHbHlXn1DCo6
         sSjWHuNsSO5auLvmu6HkhPEeai07DUyDec7GijHUbXBsA5pnWONH2XZLohGBL5v4AH/B
         nu41EZoWH8HboOnTYw6ZzjQebzjCl8vqyTk+liqRWTWYmhl+jWXZECz8Rg/7PqyYuCbo
         J15LJVJ3NmZRcO+rvSH/q+PVuDVAF5CEPAcJDea4A738yGiqQ4aVZs/P821zS1L88Uya
         k5zRa+Hw/W9IC6dsqrZ+AHiaOv/I1EwmzbmR4YQVNhLubkdx617m21X37Kdg1btUgtQe
         uKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753302931; x=1753907731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DSD+P3x8Y6K4AOH4XwL8ItL+b7DP/L+yE7GqhvU06/0=;
        b=ltD/zXznGk5XgDZ4f+YKikpn0HFARlLscfY0CKRLPzsvhY6Vea1avYKbki/nRuP7Fh
         73x/czaiQHkKhggLMnLrChx1GwKxckPYu2qcHfe1uQ2mapXy3ALZ7KLFgEud931GnYI2
         lKk3VSI9gSpR8k5TLFENnALwy2B+CvWFmGbsX0mKu51SudAqirmGGuOe4LO5j0umx6g/
         hQYWq60+9aX6fuBzavuXSDtqSF8z3lQybtBsbaBIGpCSboQntvUT1Ov/ePQIwgWCvVbJ
         lBZQ4Eq1D89GJQajyVlAl2+i+gIoLsb7T+N8Wj0Ra0Ze0wVChxxnDMxQFDuJdVfBQMDy
         tOXw==
X-Forwarded-Encrypted: i=1; AJvYcCXiLdSx99jm2+VzKQ9Uc8hXM+XnOUkrs/jr1eMcB/aeMSMpkwTIwbmSirQHVlujqLaP3QY9e9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyktfidNsIV5aol7HnWeOt3PuiENBfYukpLUNQQQADg4sL4SjOO
	arsu7Hc3tD2OyiEEZc3SMMdpo2/nurD066RL1XDSmJhfn4e9b0OtRGK8
X-Gm-Gg: ASbGncuZPzcQX3V9o0CLJJChvKYRIRF7UZ1d1AwRdJ0YIETvlnJj/xw2YIy9nkSsouc
	THgNQdK+99EVuXWjCkbxPjbafLBqF02GGw4TaCCHawUvkxsCFSRpezYhSwxqHf5aRPDSneNUOM4
	MlDH7kcTNLpZo8WBWQO90spwwll9jxMuGJOZcPiUc96E7MjySvkq0sI73800BlizsA3AiqwWx7O
	mpGTE8oBYjtWVlHo5f75Kc5h57Rq/zemD0nF83fS1pO+FYOAn7ld9SdDQumEQVgkdAPZg3xHpmg
	D1FWxWHgQck/EFNOHUV7qav2i+EI/jGU539QHoSuX4uzByUEh6j2+UhG56hrwhbIAKpV+sxHcrW
	iMheuUrhFKEYbMj1lpsjv
X-Google-Smtp-Source: AGHT+IGGExOvmacphOSHra8C1DhkozlKiX97c50VK18FgVYRZqDlKNOosUwlFBWVSFXtUNk/BJIIIQ==
X-Received: by 2002:a05:690c:601:b0:719:a8db:c7f1 with SMTP id 00721157ae682-719b416ad6fmr61746097b3.17.1753302930816;
        Wed, 23 Jul 2025 13:35:30 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:46::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719532c7e4fsm32252357b3.72.2025.07.23.13.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 13:35:30 -0700 (PDT)
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
Subject: [PATCH net-next v5.0 10/19] psp: track generations of device key
Date: Wed, 23 Jul 2025 13:34:41 -0700
Message-ID: <20250723203454.519540-31-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250723203454.519540-1-daniel.zahka@gmail.com>
References: <20250723203454.519540-1-daniel.zahka@gmail.com>
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


