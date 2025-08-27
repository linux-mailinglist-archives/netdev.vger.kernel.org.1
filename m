Return-Path: <netdev+bounces-217352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE79DB3870C
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 17:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA9C06881CC
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 15:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D324304969;
	Wed, 27 Aug 2025 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rpon8wyA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836AA30146F
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310030; cv=none; b=dv64L0uPgJZY7lHCUT5Q/qxok/E7BJ0CAOZKEvDpm7CEk16UL3JHQOGn1DR21SSyP3BisCYVjqEmSoSq1f2W3XsZUr6a8vVWZSYaRVd0lYfvCDcUiSTJL/3ASvUKO+dGyFdEixhnkSgxrHvmO85pZkf7YkHb3veP/iVZTV2x2nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310030; c=relaxed/simple;
	bh=L3LoxzZ4PROtWS84UwW1svVSY4DgQPd/IdVh/5u4s18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BLhMvZKgq/TeyPahCJ7Ezy2SEe63C9m2LwqdgpcjjlDOKMSUw4fs6OStTBPbJmlq3uywwC8JlKcITgSyVoB7CVuVpTW+ILQBWPZH9Vl5Id/zCO4SSWBAwr5/Juxx9gY6JLIkJ8ObsABjiQ9UnBtqFlllVBzHmr1FLip0IoZexz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rpon8wyA; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e952a2d1813so3618628276.0
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 08:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756310027; x=1756914827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSdxdAknGMeWd2XIOB9nzII/aKO1TRQ9r3btsivLsPE=;
        b=Rpon8wyASI5ejnsD5C7bDnJ8HzU/8ogYDzWtvBsxoVLZ3crSfzmtWS9XgLcQ9biKhJ
         qjo4yXWWEE1c3pLnvLxpAD8iPRLFywzQOxkifIP4tSttDRSs0CKLVKb1yGa1qGoCFZCb
         jjAj8xFrR5VlTAb2UE8KqsZzs9pR5TpTUUj1oF5VA0Gt00tRf+uL+pvaD4qoiOXZGh8q
         Jj8Usd6s5nZVy1fzs+D7JzENwtmDFuzfLTm9D2QDf3+xkDejqTPUye+koGL/2fB8+JW7
         GrUsDwq723+pERavi73qXbhSQPduCkhUTSSTT1saAFoNsqSg0tfjQ7j1f13JnoovwAc7
         HM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756310027; x=1756914827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pSdxdAknGMeWd2XIOB9nzII/aKO1TRQ9r3btsivLsPE=;
        b=Oeyl3QQlY/hKzBoiq23eoFzYQ9N4fbJA/rGgo5NE23N1ipTDLsZoDZi2R7DMMscAIi
         Mtbi25nmElD77xNVxSv280kIP8iKJQL0VuIGDjU3ELMfsai2/o/OTRbYQ/i8IdIhK/vo
         YNIXbgn6mb88Pm3EAnf6UHjDCjilGsTGz+3PZKxjd3J4mjbv6TYTKqgHcDNMz6CS+s79
         Nca/IPQ0pY0J7dK6KKC4aY73jchI2YIL1F63vim2XUbmuqtmbx3hapABrwAvj5lAyidA
         urpnMrTEPY8ES0NTOJEOcHeyqqU3D7q/dcKHclXu+7aanT8kT+m/A1STGm1mEPGQuMv2
         b1/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJIM54GBl7nCMtt8/QLaFj5ZyrgWgCT8pUXWNF3Xl2lfjNwfZRgp15TVCXucYFbvg8qx4W8zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ0zSNWT5wGwdydjBBGfRJpPrsvO357KjJ/vXAxXbEZdd8lUrg
	9/Pdigd5xJgJlP1TDDAGZesYZkBvDTKWuzJFQqg2hZtb4Czt9pRhCET35483Mw==
X-Gm-Gg: ASbGncu+ICkvlagTuZHpN1m3vCu6X57WCCZqV1j6U2GwwFBQ9JMezjNkKiWgxjdRz8w
	Mi6hXS1Nd0mNxY2CTs+hdEFS3YDpZDEFdRyBxRiHQIHtl1k08l9mRK9wa4wRr17XrHGkD1qMHsa
	RWGDA4qf5PCCUcvgbJhQwaTMpQdVPVT4E7+tjICqRreVK7Og0ho6TwQQADdNfO1sJk1E9gAD6jN
	k+XQtQnCU3mQKveOpMGCV/fo+3OBJ2PX3bSXwlROsoDc0vqtzHzw3hn04YOnrctikVz7324yTS3
	BaEZ8awx93LHQXCPYi0mhoJ/QRleOJSxTIotXODzM6UqZ944q6mvzpl1Z7ReC+RTUCOOeg0rYHD
	dNgeWFtUfb+if33NPocWq+k+vmYpt3Bw=
X-Google-Smtp-Source: AGHT+IGgr3d63W1USnNtRl4DjcwkidDfxBUjkrt+YImWn8kN923LhJ5v9KO1/Afbn2VnahTT6eaakQ==
X-Received: by 2002:a05:6902:20ca:b0:e95:2422:6d1f with SMTP id 3f1490d57ef6-e9524226facmr18169798276.17.1756310027462;
        Wed, 27 Aug 2025 08:53:47 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:72::])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e952c25df8esm4174499276.7.2025.08.27.08.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:53:46 -0700 (PDT)
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
Subject: [PATCH net-next v9 05/19] psp: add op for rotation of device key
Date: Wed, 27 Aug 2025 08:53:22 -0700
Message-ID: <20250827155340.2738246-6-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250827155340.2738246-1-daniel.zahka@gmail.com>
References: <20250827155340.2738246-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

Rotating the device key is a key part of the PSP protocol design.
Some external daemon needs to do it once a day, or so.
Add a netlink op to perform this operation.
Add a notification group for informing users that key has been
rotated and they should rekey (next rotation will cut them off).

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---

Notes:
    v6:
    - use PSP_CMD_KEY_ROTATE_NTF instead of PSP_CMD_KEY_ROTATE as arg to
      genl_info_init_ntf()
    v1:
    - https://lore.kernel.org/netdev/20240510030435.120935-6-kuba@kernel.org/

 Documentation/netlink/specs/psp.yaml | 21 +++++++++++++++
 include/net/psp/types.h              |  5 ++++
 include/uapi/linux/psp.h             |  3 +++
 net/psp/psp-nl-gen.c                 | 15 +++++++++++
 net/psp/psp-nl-gen.h                 |  2 ++
 net/psp/psp_main.c                   |  3 ++-
 net/psp/psp_nl.c                     | 40 ++++++++++++++++++++++++++++
 7 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/psp.yaml b/Documentation/netlink/specs/psp.yaml
index 706f4baf8764..054cc02b65ad 100644
--- a/Documentation/netlink/specs/psp.yaml
+++ b/Documentation/netlink/specs/psp.yaml
@@ -88,9 +88,30 @@ operations:
       notify: dev-get
       mcgrp: mgmt
 
+    -
+      name: key-rotate
+      doc: Rotate the device key.
+      attribute-set: dev
+      do:
+        request:
+          attributes:
+            - id
+        reply:
+          attributes:
+            - id
+        pre: psp-device-get-locked
+        post: psp-device-unlock
+    -
+      name: key-rotate-ntf
+      doc: Notification about device key getting rotated.
+      notify: key-rotate
+      mcgrp: use
+
 mcast-groups:
   list:
     -
       name: mgmt
+    -
+      name: use
 
 ...
diff --git a/include/net/psp/types.h b/include/net/psp/types.h
index 4922fc8d42fd..66327fa80c92 100644
--- a/include/net/psp/types.h
+++ b/include/net/psp/types.h
@@ -102,6 +102,11 @@ struct psp_dev_ops {
 	 */
 	int (*set_config)(struct psp_dev *psd, struct psp_dev_config *conf,
 			  struct netlink_ext_ack *extack);
+
+	/**
+	 * @key_rotate: rotate the device key
+	 */
+	int (*key_rotate)(struct psp_dev *psd, struct netlink_ext_ack *extack);
 };
 
 #endif /* __NET_PSP_H */
diff --git a/include/uapi/linux/psp.h b/include/uapi/linux/psp.h
index 4a404f085190..cbfbf3f0f364 100644
--- a/include/uapi/linux/psp.h
+++ b/include/uapi/linux/psp.h
@@ -32,11 +32,14 @@ enum {
 	PSP_CMD_DEV_DEL_NTF,
 	PSP_CMD_DEV_SET,
 	PSP_CMD_DEV_CHANGE_NTF,
+	PSP_CMD_KEY_ROTATE,
+	PSP_CMD_KEY_ROTATE_NTF,
 
 	__PSP_CMD_MAX,
 	PSP_CMD_MAX = (__PSP_CMD_MAX - 1)
 };
 
 #define PSP_MCGRP_MGMT	"mgmt"
+#define PSP_MCGRP_USE	"use"
 
 #endif /* _UAPI_LINUX_PSP_H */
diff --git a/net/psp/psp-nl-gen.c b/net/psp/psp-nl-gen.c
index 859712e7c2c1..7f49577ac72f 100644
--- a/net/psp/psp-nl-gen.c
+++ b/net/psp/psp-nl-gen.c
@@ -21,6 +21,11 @@ static const struct nla_policy psp_dev_set_nl_policy[PSP_A_DEV_PSP_VERSIONS_ENA
 	[PSP_A_DEV_PSP_VERSIONS_ENA] = NLA_POLICY_MASK(NLA_U32, 0xf),
 };
 
+/* PSP_CMD_KEY_ROTATE - do */
+static const struct nla_policy psp_key_rotate_nl_policy[PSP_A_DEV_ID + 1] = {
+	[PSP_A_DEV_ID] = NLA_POLICY_MIN(NLA_U32, 1),
+};
+
 /* Ops table for psp */
 static const struct genl_split_ops psp_nl_ops[] = {
 	{
@@ -46,10 +51,20 @@ static const struct genl_split_ops psp_nl_ops[] = {
 		.maxattr	= PSP_A_DEV_PSP_VERSIONS_ENA,
 		.flags		= GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd		= PSP_CMD_KEY_ROTATE,
+		.pre_doit	= psp_device_get_locked,
+		.doit		= psp_nl_key_rotate_doit,
+		.post_doit	= psp_device_unlock,
+		.policy		= psp_key_rotate_nl_policy,
+		.maxattr	= PSP_A_DEV_ID,
+		.flags		= GENL_CMD_CAP_DO,
+	},
 };
 
 static const struct genl_multicast_group psp_nl_mcgrps[] = {
 	[PSP_NLGRP_MGMT] = { "mgmt", },
+	[PSP_NLGRP_USE] = { "use", },
 };
 
 struct genl_family psp_nl_family __ro_after_init = {
diff --git a/net/psp/psp-nl-gen.h b/net/psp/psp-nl-gen.h
index a099686cab5d..00a2d4ec59e4 100644
--- a/net/psp/psp-nl-gen.h
+++ b/net/psp/psp-nl-gen.h
@@ -20,9 +20,11 @@ psp_device_unlock(const struct genl_split_ops *ops, struct sk_buff *skb,
 int psp_nl_dev_get_doit(struct sk_buff *skb, struct genl_info *info);
 int psp_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
 int psp_nl_dev_set_doit(struct sk_buff *skb, struct genl_info *info);
+int psp_nl_key_rotate_doit(struct sk_buff *skb, struct genl_info *info);
 
 enum {
 	PSP_NLGRP_MGMT,
+	PSP_NLGRP_USE,
 };
 
 extern struct genl_family psp_nl_family;
diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
index e09499b7b14a..f60155493afc 100644
--- a/net/psp/psp_main.c
+++ b/net/psp/psp_main.c
@@ -54,7 +54,8 @@ psp_dev_create(struct net_device *netdev,
 	int err;
 
 	if (WARN_ON(!psd_caps->versions ||
-		    !psd_ops->set_config))
+		    !psd_ops->set_config ||
+		    !psd_ops->key_rotate))
 		return ERR_PTR(-EINVAL);
 
 	psd = kzalloc(sizeof(*psd), GFP_KERNEL);
diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
index fda5ce800f82..75f2702c1029 100644
--- a/net/psp/psp_nl.c
+++ b/net/psp/psp_nl.c
@@ -221,3 +221,43 @@ int psp_nl_dev_set_doit(struct sk_buff *skb, struct genl_info *info)
 	nlmsg_free(rsp);
 	return err;
 }
+
+int psp_nl_key_rotate_doit(struct sk_buff *skb, struct genl_info *info)
+{
+	struct psp_dev *psd = info->user_ptr[0];
+	struct genl_info ntf_info;
+	struct sk_buff *ntf, *rsp;
+	int err;
+
+	rsp = psp_nl_reply_new(info);
+	if (!rsp)
+		return -ENOMEM;
+
+	genl_info_init_ntf(&ntf_info, &psp_nl_family, PSP_CMD_KEY_ROTATE_NTF);
+	ntf = psp_nl_reply_new(&ntf_info);
+	if (!ntf) {
+		err = -ENOMEM;
+		goto err_free_rsp;
+	}
+
+	if (nla_put_u32(rsp, PSP_A_DEV_ID, psd->id) ||
+	    nla_put_u32(ntf, PSP_A_DEV_ID, psd->id)) {
+		err = -EMSGSIZE;
+		goto err_free_ntf;
+	}
+
+	err = psd->ops->key_rotate(psd, info->extack);
+	if (err)
+		goto err_free_ntf;
+
+	nlmsg_end(ntf, (struct nlmsghdr *)ntf->data);
+	genlmsg_multicast_netns(&psp_nl_family, dev_net(psd->main_netdev), ntf,
+				0, PSP_NLGRP_USE, GFP_KERNEL);
+	return psp_nl_reply_send(rsp, info);
+
+err_free_ntf:
+	nlmsg_free(ntf);
+err_free_rsp:
+	nlmsg_free(rsp);
+	return err;
+}
-- 
2.47.3


