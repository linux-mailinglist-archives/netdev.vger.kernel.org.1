Return-Path: <netdev+bounces-209500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 537FBB0FB92
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 22:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7730A3BC9DA
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 20:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5808239570;
	Wed, 23 Jul 2025 20:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEMhU/2R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ED72376EF
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 20:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753302905; cv=none; b=peqi+FymdI2HsJ4kVQaM6fUFat6YU6pseHeJZjgnDXZvprVkYNKupFLrvApbCX/sH6UQDvojkmLavB+KBii+qRrX7kjDeKseWBrTkUl27TDw4lAdd1Jb69J+sETznUsst42g09F37i+8h49wPDaCPiQYJHXnbBAJcPwYQafRtWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753302905; c=relaxed/simple;
	bh=NF4o8Tn4ouimyD6iSnlv+oqVyFg3y78+9SWcrByfz/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqt0hOg+Y9sd8rbSIvbaSKm2FSOZKZs+0xmyQWBBIQxKJu/gN4JeSlz+Xjxo6NjR+YeT/Yv+A00z1xKlxz1rRPFaD/hJXD8fl9wPBkzKxsfQmuP4f4bYxUOfmP4vhWAIRXo4z0fSmaVhCWoRUnf3xjaqN61OBLn4UrfGx769Rdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEMhU/2R; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-719c4aa9b19so3922157b3.0
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 13:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753302903; x=1753907703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8iAuyU+gpnhIU1r6mAvhEWDRy7p+p94AvwOCNKeacA=;
        b=mEMhU/2RlS0NgU/PzeAG3Gux6X+ekW7CJRP6HEq60iK5WqW84tiKr17rvXP+ESgRMY
         5zvT4BYWzK1AtHR+T9YqKsUz9ar6P6H+gI8AIbTm8hyqHlNsBHnbFeYAiDREyQe/DX0X
         4KdST03kY8TIJNE1WipfmXV0ENCf0o0vRWxTm1/scEt/H4K3coz4fWw0MkPuwJf3ETZH
         EfjLqJN3ANKYWmUeapu1PiFyuT95uLs6TmITj2cAT828k5bVAhEajT+HwEiq3gtDA8tj
         RAY/M1ohxH9JxsFTMOGUyt7Xx7DusolFI07r0UZA0BYXn3QW60EkyUk2nbEZV9uuan7i
         I6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753302903; x=1753907703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m8iAuyU+gpnhIU1r6mAvhEWDRy7p+p94AvwOCNKeacA=;
        b=LcADkpPIRi1u9i45N3mIGxK/xVjtYpG5fQsTEY/th3iR980zP7/zHEdFPGgCbi5BdC
         1Im12AKjEYT/rpL1P4nymaeYzjL1H3y/hLE8J1/ao7eikiZMt0Ud6POOoss5eijeOJ9T
         N/AP3Dak4V9/sWhhYrPG9S7P2eFh9OuIenUZHhmj2uZ9nkfSKaNzqTV/tXmhrbGQec44
         LmLliMNqxE0NPFKAFE/XlZdsgGsJhmqQH3evARqXrSrX4B11+YcunC2I0gIaWHSoIwXF
         la5HHPkPn6KqjawbN9eIgxrnLepdPMdiI+zcdtmeF35+i5syRBOlEDiTR799If0w5yA7
         RZng==
X-Forwarded-Encrypted: i=1; AJvYcCUscAtQNqxifhqhpYWS5Eeb5jIZ3UG/B4cSzyOKgj2CWtmeniWrjhaVvGpnY3B7d9QzWtf5RJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyDMTYgS8Nf+GeEfWtyFT4HFnzH/1OjlvVQy2Yb/+Sj5755m7j
	a/ayJABLeNb769ucCBYGLTEuLlIySW1QuYQVAz+BeHCoIIDVmQq8zIbO
X-Gm-Gg: ASbGncsTO71y5dEpso0V9MAwVcDaX0CxtFOsz0RYVdkQMSW/naUZYbQqKA/+Aj2Q6Fo
	fozInQssoaRPU7WMARKb2yBZKLqzrv8PBwNi2gpz1OsiJFhorSrfY0aPH0MLFbSGwWv7glJhzk1
	qgBOYhOEsdtiboz/TrZUN5tbULlCIPoM4tkAPvSAMvn4kczsH3Cugk9W3Eu4oCYsTTg2Ow2xqNO
	qV2lFs8de8JCY26S0rEkBOwpDluuAFEbVwUfyQabz9X5VEwXIOy1SZefisz/daUBHCPRY9UCCGh
	yJ9lChtIl0zAdqEJqczwqXKCYVKo0jmCG1R3g3Xh+qNUMU2jOY5LJni3N8Wev61/PpSrr5H6KBi
	1NKAxuEDQv0ojW7E9
X-Google-Smtp-Source: AGHT+IGEdNQzCz8dOy4fIoW8KjDlcrrijaAG6imu9/icjtWBQxaiOf3dyCtqnt9Mpl/FVCx8VRwcZg==
X-Received: by 2002:a05:690c:6208:b0:711:af14:3981 with SMTP id 00721157ae682-719b42584d0mr66608917b3.31.1753302902515;
        Wed, 23 Jul 2025 13:35:02 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7195310b038sm30940267b3.16.2025.07.23.13.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 13:35:02 -0700 (PDT)
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
Subject: [PATCH net-next v5 05/19] psp: add op for rotation of device key
Date: Wed, 23 Jul 2025 13:34:16 -0700
Message-ID: <20250723203454.519540-6-daniel.zahka@gmail.com>
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
index fda5ce800f82..b7006e50dc87 100644
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
+	genl_info_init_ntf(&ntf_info, &psp_nl_family, PSP_CMD_KEY_ROTATE);
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
2.47.1


