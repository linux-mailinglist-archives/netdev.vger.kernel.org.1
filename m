Return-Path: <netdev+bounces-212678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEEAB219C6
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 02:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9972F7AE259
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 00:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737742D543D;
	Tue, 12 Aug 2025 00:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeWSWylR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F902D541E
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 00:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754958619; cv=none; b=Z5qJPJ+tmoLLoT0uvxYHuod9A9Gf/rLr9zpx7OXukC/hvG7Qq5m7KGz3k0Z9QPtlc5xDM5R+o+DrVUB44v73x2hQDt5thp9r/wkBnOjOP9L4zj8jsEUkk3RF2hd+qPQK51qZTfPDRzE3sSNFV5LhKsFgX2uXuvrGp9V20O8lb9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754958619; c=relaxed/simple;
	bh=leg+pyFSUaMR8Ph+R7kgsT9P8sOSyAwMkVAT2PSjMYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/ohxTrXN4p2/RHVqIDUf8jtCZcyBuIUsqiy3fKeBAeqEkiNuZ1vdWZOtJlyXPLCPqhkgvEIfIEi63rwBedekOXyNlm4TNHecf0gLWllz3XOBV6MmBZhyyFNhTyU2GmFaqjHqhrP+yqeZ1cmGek7IiW1IlBTrb/v+gcCHZivagg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZeWSWylR; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-718409593b9so51004707b3.3
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 17:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754958616; x=1755563416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kb9VR7wDEbDUa+t0W5LA2zBu8/JG1SEXuoA74JEoVRo=;
        b=ZeWSWylRq8doebyyoAmygij4qSNUxcmD/ELmGWUww9XrWmvl9kFSLVu+tZHz2fWJGK
         SyuAR/hHL7bStEj9YB16L4soMcKFKC3gMdatFE2V3lA5u2RjJ7yUiE/y1kuig3pvhZwe
         ObtjYvBGjjnM1SKOm/MtGXc+pP+NNywOSItCojmc5/43l6v+QdRV6tddlAdOA4J4iYNr
         gYDTF7XSrIuUNxbLxpfArqjn43spcQj9lMrfapKwvPY9VxfJhgogWqonTITCCm7ZXfJp
         BzT8xqrJVXWzKpU5s75h/wacUW/XuhQW3DNvkn82U9zdQijh/KJYfofXi2IZ1u2C2dGR
         Wxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754958616; x=1755563416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kb9VR7wDEbDUa+t0W5LA2zBu8/JG1SEXuoA74JEoVRo=;
        b=LOPsxokwo+Jh5xRaTR1h4gSp19YOq3P7iS/eri/ODdOP0Pyc7nmo5/dDU7hlD3k+bs
         07oVUQC6hQfGCSN8G8fyHmd3LvX+W9j9z6F+2DWNuTuKyosEnrhH4wwTpUnkvXds8MDU
         WBMfqRty/vM8DtmI3vI13ed+iEvf0MRrW3r6C/9j9TR1gRpOkquh5sj/WNf+pnjROOd2
         DI8bz8ZuOVbDjAUd8zxpBf7hvFVFDEs26fJcyQ+fJTKGFsBAMs/zn5ftR5NvuqbyiV9T
         pDGmUmUew+aHvXCG5GjVphrYz2Zx9SvIV43wihWiDokI1EvX91RKvawlA0+DYoKZj8EZ
         Yr5Q==
X-Forwarded-Encrypted: i=1; AJvYcCViA2v7q3OV/eJMOFHFo5nFEFrRtSeorgtUwGmNmXG9ZlTFXlZpkDcJ2wk+h8VXLnerDw3QZ7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkGNqZDHg+lF0uyMYEAZTcXyFANormtTKVsYJyzkIBtCmoVffP
	lwZl1ekMC/NLb97YuyPpGIIjyEWKlbpQ9rG6vsoUF1JZ9ijlKfkDRubz
X-Gm-Gg: ASbGncs/JDg8C3woxGeieWHGYD8Af1SW74kB2OH/PA+pl9046hVS85+ioW9W73zG+dh
	6CE/HM/cmlVrobLgsfxW82uXxf9Wm+VX+sHHH/LhetAfCophIgUoskWey9oqWnre7wPcQq0UiqL
	l+XGogylG1mnxrnJtEQcHug82/9b/PXaYNJDBmdWmqvFuTt8gj8kIrs+kbqxWogxEVoye+gRo69
	rA/j+7AhdtVthrpwz3WxXEEtq+g1z6X0ZuTH3t5WQ0gsbU4yzPYZwNGcz9Q5JD6AWuSJci/mia7
	hM8HVEA5Jw8ZBOsNQfX3T+s19IwkuuErVOLK0Uu93QVlltIIV66yIV/k/m3t6pP94qE/mHEnw5C
	6+oWH+1tcu/Dkgvk2z2ogF6707NzEDrM=
X-Google-Smtp-Source: AGHT+IHJzIgEJxydStM7WFwtQZivEkDrFrEiSxR8daL41APPGdm6YWBV/Ke/wqeTe6fdKRclf/D9iQ==
X-Received: by 2002:a05:690c:650c:b0:71b:fa04:d16e with SMTP id 00721157ae682-71c4298a36amr27847767b3.16.1754958616540;
        Mon, 11 Aug 2025 17:30:16 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:42::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71c011b83e6sm21123887b3.6.2025.08.11.17.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 17:30:16 -0700 (PDT)
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
Subject: [PATCH net-next v6 05/19] psp: add op for rotation of device key
Date: Mon, 11 Aug 2025 17:29:52 -0700
Message-ID: <20250812003009.2455540-6-daniel.zahka@gmail.com>
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
index 35f69fe3d1a2..7f1a6cda6a7a 100644
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


