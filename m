Return-Path: <netdev+bounces-202575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16502AEE4D5
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E070B1893EDE
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576A2292933;
	Mon, 30 Jun 2025 16:42:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B07478F2E
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751301749; cv=none; b=LJ7pnuW4+pEXqfmffvwFi6VYx38zg2r7u/TBQoOwH7fqI+UjzD8ORO7O0jXNE5uCSqzMXC8nnaSOwEC9VLRYrDTZ2sNdwH4jvdG1q8TwRxrUnwYCcSZtLD5SWZrKNEg6JgzGQYYobCZNrPAnuVeyciUmSZ7kScO5ewTh7JvmjJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751301749; c=relaxed/simple;
	bh=Ssnk9S1FqZbeod+8CaZe3KD0kHT2fKO+U7KulfNZcGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ctkMFR/lNfuSP8Miv4HRKqz5rajepfBJJ14YIJsxe8WIQ7McCPn7CmFzskucKCk0B3+OGh9h4KZ+bb60ZR8394Yrx9x8Go0x6s5IaVffs9VoFv1kbhLeOVz9TqgDmFC4zStGvF0z8QtRDjwAC7V207yPRSWM9ZckvQ9jwQRLuQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-235ef62066eso56077565ad.3
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 09:42:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751301746; x=1751906546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9JzC0yih8vbg7DAnvKzQuYOKBmSwrk0JiC9uI8Xs0nA=;
        b=IV0vr6aHmR2IgohqZmXHCI1IA5tsRpBSTOeYC5P3YjxGsVIq08G4ENQEdyBqGVDL8+
         Jh3WQrJgmUEB1b7lOX5NnV00+Bwmjv5yA7v145Gg/5JvFX8hnUC+HoA8kAi1rLyZhCb5
         +TJhwBrK8fe6at7ecwaMOkPhhLz7xmAxOHoVbFTni+8UuBgSD3opUE4Ncn9Qk/G+KIM3
         FEQNBblbbATO3icWEaKeEooESW7MQEzByRMLsWMgcfHjF0xbkvb1z5sv1pvLYoTLzcPy
         Ogp0T2+tOwla/XMczJwyBEEB1cGv2DtgmMWhSqBPJlgLu6VxWddG88lrL8UNKb91L2o9
         t3IA==
X-Gm-Message-State: AOJu0YzNTzt5RDSy7aNh29cDYg4imD0WWugPGiFCjMhIunFMZmbnYAXs
	Fn/hcMnzaEoz0xYPMlU6GaGHJSON2Q9GRIulV8RbV7heIJWQnRdIO66idAN6
X-Gm-Gg: ASbGncsZTM+M1/wVCFtiIH1vooaY3tVNNWjLMBa98iBSZNdwGJkHyP5DovvhB3k78hf
	GavVZamgUHLA6A6lrTKj9w3xeGZywZ8OS4zqw2QR0BdCxg4XohHoNeMbT2wR0ggYBW6JriMl7gx
	zfwndL4GpeuZLci5bxlAKNsoE+rPMVyxP5i1vkX9col9wwjXU+bRSFV0uSCxbl8BOkdNqCuFcGG
	DQ0b+9VKJrOTaUSPqTRBnTuCLaoFgC3ejccFzNSxjuE9LJf9rRsOod4O3cV/4+8aEK2ttzBLY/B
	uRwata0+0MuKUyzzvOS15kILTxFZgSSiD4avCmqzgUMxhfHnfaVXQpAWBPyLKWSABiBBjq6Y1VS
	XqndaeAJHGOmGTrZiMuGVAaA=
X-Google-Smtp-Source: AGHT+IEPMrnH8xr4KsPeg7fBbYwZBumtwPzHh/Vz7eVHB3bzaCG0soF84E7gu8CuTY2w5F+uCjQOJg==
X-Received: by 2002:a17:903:b8f:b0:235:88b:2d06 with SMTP id d9443c01a7336-23ac3bffd96mr184233345ad.6.1751301746349;
        Mon, 30 Jun 2025 09:42:26 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb3c4a65sm83745175ad.216.2025.06.30.09.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 09:42:25 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v2 2/8] net: s/dev_get_port_parent_id/netif_get_port_parent_id/
Date: Mon, 30 Jun 2025 09:42:16 -0700
Message-ID: <20250630164222.712558-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630164222.712558-1-sdf@fomichev.me>
References: <20250630164222.712558-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit cc34acd577f1 ("docs: net: document new locking reality")
introduced netif_ vs dev_ function semantics: the former expects locked
netdev, the latter takes care of the locking. We don't strictly
follow this semantics on either side, but there are more dev_xxx handlers
now that don't fit. Rename them to netif_xxx where appropriate.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |  2 +-
 include/linux/netdevice.h                     |  4 ++--
 net/bridge/br_switchdev.c                     |  2 +-
 net/core/dev.c                                | 23 +++++++++----------
 net/core/net-sysfs.c                          |  2 +-
 net/core/rtnetlink.c                          |  2 +-
 net/ipv4/ipmr.c                               |  2 +-
 7 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index fef418e1ed1a..32c07a8b03d1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -5446,7 +5446,7 @@ int mlx5e_tc_esw_init(struct mlx5_rep_uplink_priv *uplink_priv)
 		goto err_action_counter;
 	}
 
-	err = dev_get_port_parent_id(priv->netdev, &ppid, false);
+	err = netif_get_port_parent_id(priv->netdev, &ppid, false);
 	if (!err) {
 		memcpy(&key, &ppid.id, sizeof(key));
 		mlx5_esw_offloads_devcom_init(esw, key);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index eff09d110e25..ac6b9e68e858 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4222,8 +4222,8 @@ int dev_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
 int dev_set_mac_address_user(struct net_device *dev, struct sockaddr_storage *ss,
 			     struct netlink_ext_ack *extack);
 int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name);
-int dev_get_port_parent_id(struct net_device *dev,
-			   struct netdev_phys_item_id *ppid, bool recurse);
+int netif_get_port_parent_id(struct net_device *dev,
+			     struct netdev_phys_item_id *ppid, bool recurse);
 bool netdev_port_same_parent_id(struct net_device *a, struct net_device *b);
 
 struct sk_buff *validate_xmit_skb_list(struct sk_buff *skb, struct net_device *dev, bool *again);
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 95d7355a0407..1385ff604bbd 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -834,7 +834,7 @@ int br_switchdev_port_offload(struct net_bridge_port *p,
 	struct netdev_phys_item_id ppid;
 	int err;
 
-	err = dev_get_port_parent_id(dev, &ppid, false);
+	err = netif_get_port_parent_id(dev, &ppid, false);
 	if (err)
 		return err;
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 7198a833f697..7d38d080efe0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9816,16 +9816,15 @@ int dev_get_phys_port_name(struct net_device *dev,
 }
 
 /**
- *	dev_get_port_parent_id - Get the device's port parent identifier
- *	@dev: network device
- *	@ppid: pointer to a storage for the port's parent identifier
- *	@recurse: allow/disallow recursion to lower devices
+ * netif_get_port_parent_id() - Get the device's port parent identifier
+ * @dev: network device
+ * @ppid: pointer to a storage for the port's parent identifier
+ * @recurse: allow/disallow recursion to lower devices
  *
- *	Get the devices's port parent identifier
+ * Get the devices's port parent identifier
  */
-int dev_get_port_parent_id(struct net_device *dev,
-			   struct netdev_phys_item_id *ppid,
-			   bool recurse)
+int netif_get_port_parent_id(struct net_device *dev,
+			     struct netdev_phys_item_id *ppid, bool recurse)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
 	struct netdev_phys_item_id first = { };
@@ -9844,7 +9843,7 @@ int dev_get_port_parent_id(struct net_device *dev,
 		return err;
 
 	netdev_for_each_lower_dev(dev, lower_dev, iter) {
-		err = dev_get_port_parent_id(lower_dev, ppid, true);
+		err = netif_get_port_parent_id(lower_dev, ppid, true);
 		if (err)
 			break;
 		if (!first.id_len)
@@ -9855,7 +9854,7 @@ int dev_get_port_parent_id(struct net_device *dev,
 
 	return err;
 }
-EXPORT_SYMBOL(dev_get_port_parent_id);
+EXPORT_SYMBOL(netif_get_port_parent_id);
 
 /**
  *	netdev_port_same_parent_id - Indicate if two network devices have
@@ -9868,8 +9867,8 @@ bool netdev_port_same_parent_id(struct net_device *a, struct net_device *b)
 	struct netdev_phys_item_id a_id = { };
 	struct netdev_phys_item_id b_id = { };
 
-	if (dev_get_port_parent_id(a, &a_id, true) ||
-	    dev_get_port_parent_id(b, &b_id, true))
+	if (netif_get_port_parent_id(a, &a_id, true) ||
+	    netif_get_port_parent_id(b, &b_id, true))
 		return false;
 
 	return netdev_phys_item_id_same(&a_id, &b_id);
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 69109584efef..ebb5a6a11bb8 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -687,7 +687,7 @@ static ssize_t phys_switch_id_show(struct device *dev,
 	if (ret)
 		return ret;
 
-	ret = dev_get_port_parent_id(netdev, &ppid, false);
+	ret = netif_get_port_parent_id(netdev, &ppid, false);
 	if (!ret)
 		ret = sysfs_emit(buf, "%*phN\n", ppid.id_len, ppid.id);
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 6d75030aa70f..94c449bad59e 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1446,7 +1446,7 @@ static int rtnl_phys_switch_id_fill(struct sk_buff *skb, struct net_device *dev)
 	struct netdev_phys_item_id ppid = { };
 	int err;
 
-	err = dev_get_port_parent_id(dev, &ppid, false);
+	err = netif_get_port_parent_id(dev, &ppid, false);
 	if (err) {
 		if (err == -EOPNOTSUPP)
 			return 0;
diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 3a2044e6033d..e86a8a862c41 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -901,7 +901,7 @@ static int vif_add(struct net *net, struct mr_table *mrt,
 			vifc->vifc_flags | (!mrtsock ? VIFF_STATIC : 0),
 			(VIFF_TUNNEL | VIFF_REGISTER));
 
-	err = dev_get_port_parent_id(dev, &ppid, true);
+	err = netif_get_port_parent_id(dev, &ppid, true);
 	if (err == 0) {
 		memcpy(v->dev_parent_id.id, ppid.id, ppid.id_len);
 		v->dev_parent_id.id_len = ppid.id_len;
-- 
2.49.0


