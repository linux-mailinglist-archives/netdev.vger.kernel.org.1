Return-Path: <netdev+bounces-201168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AAEAE8536
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 15:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A7577AA294
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 13:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE692652A6;
	Wed, 25 Jun 2025 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9f1dISB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A526264616
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 13:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750859540; cv=none; b=G1iBXneNDf9vLMnEgX9EaThcClQmJTjEl0NMBWn0sZKb6H09ulK+BGUZ91OdyR+T8wgMxIZQdMO9zqJTU30e0GFxp5y0o6vb280GqEQaYCXaeyIOSGqYjiM9OgeCw6HYuL6j9VeZeQW9WPGSdb0WeqqRtTKlu91k762/1+LrVvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750859540; c=relaxed/simple;
	bh=6ONnQXR2dU76BoPoiTZ9smnDiHKsrvYzXzP8tch9Sxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFzrZ2lkToU3ZAFFfnLqLOnAdwECYCuzsVEIAucr7RkDoAaXq6vBRZuhPLPDn6xlMFeAfW0wJ0DTsY8OfM4h99T3DrL94UshuoTTj96fw3IISQYaWzCI6OM0XuPi+VfGBxHiSM15g1QhT7oSo4+kEmsjlviP4vITlvbrwQ+TPy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9f1dISB; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-710f39f5cb9so18562757b3.3
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 06:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750859538; x=1751464338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HzC/zLIfzRPBAOtSlLij+ZlV+IH7upN1LOCii50MvNg=;
        b=R9f1dISBkNtO5hxmxMX3ZpUUa189c+HKmbbqJ90Rr8SXkNjguoVmom4iNFBUZdlPq9
         vwGIrhALDymxnLQuAVpMZklbHQghhqwBMWsUTVrnawf6sfbYD8YFBdqdNDJzUU+sP/hy
         yKGwp8xcq2ktV3bT5i+xs7EFICeayS5hTv3DMQ9JNOVVv0y6rosmYfkkJipQwoRdlAsh
         yoP6RUxDju85Dde4ZmmJu6gfrljovGQTiKQHdiYPzHe+yoSdS0JFfOkjerBtBGyznsmb
         crEJjMePAAeKxMiWpisueklUvIzgU+XeIvCCfr6Q/iON4yLIRD+I7dqNVio/uUn13NS0
         y8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750859538; x=1751464338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HzC/zLIfzRPBAOtSlLij+ZlV+IH7upN1LOCii50MvNg=;
        b=o9V7DkAksNAL/6YiyDg37SVGA6wJOpdD/udXK5JyZ7GNZVxZfL263ai9RL1TAUnB9o
         HWqjU8vyAXOQkJJ5ikWvv5hhN1/1oAGTKP8KNrJ0kiJFWqjxflI38o13dlbZw3vIMNcO
         +bK//jfCbLTCYVeFoCHEYhWGaJ5X1U+vXozPR01WQDotoFnJYcaXcsxHzVOLSWtG2RUw
         d1FSuuOCOz8gYg/+0rk169dAdyoM23J7pmWuVrHfFcd5byc8zksUKZLCj83wy1IdsWIU
         of8f9u33SStWAetAw/zXFnWlbkyoATcT473TZWf6wVoMfMuPKJMOI5LHOICSyEGod7Y4
         FCwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFGVO2OhkAxh/2IfBBCnvSz4bJt2BWjy9qjikcYd+8gUZOtbTA/A+tn8xno4mNEr0XtxamdDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoeM/X8oDJwLutSpzbRryJzurSt1MLBbEfPyC0W7utlBE23OLY
	I1hKmP0Qt4YaEFAzk68PhYTPGn2wCHTDjnmIY7sXWIrISuBVqPCnxRQH
X-Gm-Gg: ASbGncvSoZY/G+Nw5QIUoNPaRtWqfsMHcMymOEtLYu1G0mu7+uQAUAAEj/IKtJLf9pl
	VfzPtRt4GqBYTlfZGWNdrLeaJas/iD9n07+lukY30EB3RIIpQX5fZlAGiCHA2hLkV71FdeTZRva
	wDjoBQLp8/amgBrJavAqPzuHStw8+IY4ykuUEkwP4yqEslW61szZdc25FhqJPzKvFUfWKUnxBKH
	XB64AKAHchqzVJL/7arVtf9uS5bzcNSjoipuST6zZ+ZVdoNidspmlzbxQFbs10+VwvajsvXfiHh
	Zmyr5jU/BFkezf6kbPkf0UVbCfRvgZR6hlfDrWlHp2HRQYRCiaz+MkJmeJQ=
X-Google-Smtp-Source: AGHT+IFI6etrXa0ussHj//RLDI0/Xcx2GwmqwIfS+NtmBrg5phSwEMd6z0DDDloBZ41kWqADLqMUsA==
X-Received: by 2002:a05:690c:c83:b0:710:f0fb:dc46 with SMTP id 00721157ae682-71508611231mr422077b3.7.1750859537915;
        Wed, 25 Jun 2025 06:52:17 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-712d45fcea9sm20325567b3.23.2025.06.25.06.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 06:52:17 -0700 (PDT)
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
Subject: [PATCH v2 05/17] psp: add op for rotation of device key
Date: Wed, 25 Jun 2025 06:51:55 -0700
Message-ID: <20250625135210.2975231-6-daniel.zahka@gmail.com>
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

Rotating the device key is a key part of the PSP protocol design.
Some external daemon needs to do it once a day, or so.
Add a netlink op to perform this operation.
Add a notification group for informing users that key has been
rotated and they should rekey (next rotation will cut them off).

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
index ba7e5c36975c..9191a88c349e 100644
--- a/include/net/psp/types.h
+++ b/include/net/psp/types.h
@@ -104,6 +104,11 @@ struct psp_dev_ops {
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


