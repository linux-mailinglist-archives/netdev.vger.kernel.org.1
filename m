Return-Path: <netdev+bounces-200308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D120AE47F4
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 17:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2245E189AB08
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 15:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5D2275864;
	Mon, 23 Jun 2025 15:08:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90563274FE7
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 15:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691301; cv=none; b=nKRaYcUihuxAvk0vU+BPA289RXAVp1TyIYz82skGnGEaoPLahxKxIY7jvC55oQ7IPCdMSD6HwQg1jgBungZXdZfJ71FAOZJEfX0tKNQa1QkaGmjqjoG1LqNO6ALJNZ8KRl9uK2ENeDikW7sRvY/PF8zhBvConSXichxnOeEMa2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691301; c=relaxed/simple;
	bh=H3uqAOrVcNZPmzwbNq4FN8LDrJCRJzT3t4r5iC4FkN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpam6NgeVenoa8JVZmTlQ9kp/1L3pcnarLGJafHKyriJlapONwRpdsFtjn5AjXHMnEw8JFBROT5bdtb1+xnmFOkjG2J8Ey2zHYWjCRHG80+7uAM+DvMw/zOo0fvMe83zKZT5lNZdHBMrBrqBAanDu65l4ZsHxyqengyK7ehPIW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2350fc2591dso36624215ad.1
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 08:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750691298; x=1751296098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6D3WigCtM77E4GXYR++svD4vYsKz0ESUjAS6mCXh5s=;
        b=a2cbEbRWgTao9F7SbNJUySpQoOLPrsaKnhl4OfL+rcQE2gCO2tUKyxc+Zh8iO3Nqmk
         sYj9O1F5+dtRdfqhv4e3EGV+BAV3JRdmWBreomPDQN2KiO3MyVsxBrKgWfjzQ5Jw0Dg9
         Dx4PK9/CaYo8XkXgYt1Q9Kg7Mo/ml2pqFadsxk7cAChPQMOo4mc3yTuitsgpa4ouxgqi
         5quc4x0inUJIt0cjCJnrjufyR7MX4CqJ0HNZroPV27PVUiUO7nxSfOzLputCfCvO9ULW
         gDYOJDWc9Zv163fu8XUnxuQhek9imbqIqsAjaZkf60V8ZRTcb4v5EVQHCrzMP0Xe8ZZw
         sTQQ==
X-Gm-Message-State: AOJu0Yx4jNn8xQCWzNgRx0Tc9tmhp4dOIDnVc1MwxG4LrefNNRMPSFUs
	anvnvFRgcb06+NPgueKPyT8QGT8fpr62Ky4vRhVEtQpVSdHh3jbR+sMN4x8O
X-Gm-Gg: ASbGncvE05rYDL9Bti2fMe7loPQ4JZRs/AKge7Rqurz9ODqeNBeoVxzPC1ol79oH9zh
	6J6ekkdxmE3TzY2XoFygYqDbo+Rqgr6LFN5G5pihJPBM7MPPERzsa6CYguKLPxeCusRf9+4IqDq
	vPJCOpfLloi749ek1V7q1SID+TwlCgu+WoQa5yfB2rLiRM0no00wMNf9wmyjKA8uT1qa9nA2jFr
	qjRuCnwzJGQstshM+7532zMsfb38AwmCmnfWcHeTrMF4+Hej8gZUZgDvromUkoWQ1DWfb61oqlU
	hN0gNqDx32/a5AuLWFo5gsWHAFW1BI3DE4kWOIaDHVolpiWjqetwxHhlRr2t6/j7KUMm4Vn+YiK
	qKNiyVMNkKfztloFu7PSS9qk=
X-Google-Smtp-Source: AGHT+IFRpg/BxY1hyDFtw7l4Igfgi2yDc04whGasKqZCZpxt05tfYAgd+w+BrVC6HYnfc/lj4S/iyQ==
X-Received: by 2002:a17:902:c94c:b0:215:58be:3349 with SMTP id d9443c01a7336-237db06ec92mr185903565ad.14.1750691298519;
        Mon, 23 Jun 2025 08:08:18 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-237d83937b1sm87727265ad.52.2025.06.23.08.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 08:08:18 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next 2/8] net: s/dev_get_port_parent_id/netif_get_port_parent_id/
Date: Mon, 23 Jun 2025 08:08:08 -0700
Message-ID: <20250623150814.3149231-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623150814.3149231-1-sdf@fomichev.me>
References: <20250623150814.3149231-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Maintain netif vs dev semantics.

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
index b9a7dd16eafe..874952e5ef81 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4229,8 +4229,8 @@ int dev_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
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
index f78c4e53dc8c..6acb13a78653 100644
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


