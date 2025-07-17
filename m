Return-Path: <netdev+bounces-207983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A8EB0931C
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 19:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B88EA47ADB
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4842F2FD896;
	Thu, 17 Jul 2025 17:23:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8A61F8755
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 17:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773018; cv=none; b=AiSOtLScuY446nxhF45eFjWsEbC246MLa5ekSFvtOyWv5AzA3/oSYX3Aem8a+uqIdaDaV1KpFpscTp6xuth+ZuOxLPZn/LVTwtfzk3Y7B6c5309L4+Lpp1IuA5XPYU2Bi+Z/tHVlja9Tf1mAG6xwAVA0BgIklB2lGcX64FlsS1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773018; c=relaxed/simple;
	bh=T06rwcvz/jUQGIN2Ot0MrtOzs++iUr1ez/TK9EfAq7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kPjbIaCnOyGiEfaDsvINzttzYV6mnJhB1xf1AONA9wED0qsn4bbx/Hy1POEaYBeqzOGDkv9vnGzG/ZHOEJiX3cPl9jBhNgBQayXX2rkfPRsoD4dW+x3pliZTPDF7BWTcaIN7Sd796NDmxdK5yrUBZpltC7CXRJSpaww6DmK50Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3137c20213cso1217357a91.3
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 10:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752773016; x=1753377816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGwkYTpBwy+x4AnyYcUIEXeIqNN/LD1kqM3ULlcojsY=;
        b=DTHR1vMg3pY7BijB29D0+DoTNRTEfWYYywjqgRzQWptkteAYCoxII5lxIBc4qMh2Uk
         iYR9ZKhdlqqqiZb3DAIFBzDaLTW9uZ0O8N7M/cJVQmY/M/TvTaantB0ln5oVlh7oCkp8
         khmK9Bz4fNJvUA820D3jqf9OfnlYTyM4gxJSZLJdmRWUsgWVAWHCkqbr/X5Fr/yEnoo1
         0soRKmjd9rlpucOhIf3oQLcvSJrKGcBOoyN4Jrg8Hw0UMttyVI7LJ05KZ3dSLegNY+1g
         g9PSZ12v7Po69+5C+s/sVBsuE1ogfzpx6epK7fHjAhQZA6e7An0oaScxoEfvZ1Pv4bcQ
         FLeg==
X-Gm-Message-State: AOJu0YxEY7hvpWkMEHQa/7wCAWiTEaiSCBuw+u0J7CdtgN1PJ+cMw2iH
	MiBQtZFOtrQ+7BCZV8JUnmMJ1997mVy/WtIzuIxIuUO62QwOagMpzB9vJi7s
X-Gm-Gg: ASbGncuTr3rQlTiqY9jutNV9n8phJL5Amj/5axtDpeWjnkjmnsgqY4WWJ4Ivv41B0DG
	x2QrvD9Bd6ax7sfMdvgzeVTnHLTwf3rvmT76WrYVMNs/c8z2KZ7Mor86G2Q1W3qjTr7IUWrCiJ7
	7QPudkGKaNIdc5mogq8EVZ1lC9cm0Ivlfjy8HpOxZNlavgjB/fly81oYihTNZbRcZu+THMpnFI3
	4eEUz5eq19C8sb64XZFtjOkMYg9tYmunom0+p7vcsp8MqZ4JrD37A4WsAcckJu2LOzs1T2s/mgI
	6bDPqsLeZVZ9V4Gozn9ecAUEZuGWnTtxH3FHKvFBZWZ8szO5FJ7peqNGaMXO+0MLk4aGjXHyrVD
	F6zlYqwjk6S9lKxBsc0tCiXYV5d9o7x/JkPRFz/qivcREOclDRE5eThQQwZx4VL3vf4NzPA==
X-Google-Smtp-Source: AGHT+IFL8xpCjCgHAdKP0m9R2SuQc677FXFHioDDIyti13GFPwbSUD4ILrB4HPolDtFA1lku6ncJTQ==
X-Received: by 2002:a17:90b:5307:b0:313:db0b:75e4 with SMTP id 98e67ed59e1d1-31c9f48a241mr13666617a91.33.1752773015461;
        Thu, 17 Jul 2025 10:23:35 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-31caf80503esm1871348a91.33.2025.07.17.10.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 10:23:35 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v5 1/7] net: s/dev_get_port_parent_id/netif_get_port_parent_id/
Date: Thu, 17 Jul 2025 10:23:27 -0700
Message-ID: <20250717172333.1288349-2-sdf@fomichev.me>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717172333.1288349-1-sdf@fomichev.me>
References: <20250717172333.1288349-1-sdf@fomichev.me>
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
 include/linux/netdevice.h                     |  4 +--
 net/bridge/br_switchdev.c                     |  2 +-
 net/core/dev.c                                | 25 ++++++++++---------
 net/core/net-sysfs.c                          |  2 +-
 net/core/rtnetlink.c                          |  2 +-
 net/ipv4/ipmr.c                               |  2 +-
 7 files changed, 20 insertions(+), 19 deletions(-)

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
index e49d8c98d284..c6ba4ea66039 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4223,8 +4223,8 @@ int dev_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
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
index 621a639aeba1..a42d5c496c08 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9840,16 +9840,17 @@ int dev_get_phys_port_name(struct net_device *dev,
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
+ *
+ * Get the devices's port parent identifier.
  *
- *	Get the devices's port parent identifier
+ * Return: 0 on success, -errno on failure.
  */
-int dev_get_port_parent_id(struct net_device *dev,
-			   struct netdev_phys_item_id *ppid,
-			   bool recurse)
+int netif_get_port_parent_id(struct net_device *dev,
+			     struct netdev_phys_item_id *ppid, bool recurse)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
 	struct netdev_phys_item_id first = { };
@@ -9868,7 +9869,7 @@ int dev_get_port_parent_id(struct net_device *dev,
 		return err;
 
 	netdev_for_each_lower_dev(dev, lower_dev, iter) {
-		err = dev_get_port_parent_id(lower_dev, ppid, true);
+		err = netif_get_port_parent_id(lower_dev, ppid, true);
 		if (err)
 			break;
 		if (!first.id_len)
@@ -9879,7 +9880,7 @@ int dev_get_port_parent_id(struct net_device *dev,
 
 	return err;
 }
-EXPORT_SYMBOL(dev_get_port_parent_id);
+EXPORT_SYMBOL(netif_get_port_parent_id);
 
 /**
  *	netdev_port_same_parent_id - Indicate if two network devices have
@@ -9892,8 +9893,8 @@ bool netdev_port_same_parent_id(struct net_device *a, struct net_device *b)
 	struct netdev_phys_item_id a_id = { };
 	struct netdev_phys_item_id b_id = { };
 
-	if (dev_get_port_parent_id(a, &a_id, true) ||
-	    dev_get_port_parent_id(b, &b_id, true))
+	if (netif_get_port_parent_id(a, &a_id, true) ||
+	    netif_get_port_parent_id(b, &b_id, true))
 		return false;
 
 	return netdev_phys_item_id_same(&a_id, &b_id);
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 8f897e2c8b4f..f7a6cc7aea79 100644
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
index a9555bfc372f..108995b6eced 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1448,7 +1448,7 @@ static int rtnl_phys_switch_id_fill(struct sk_buff *skb, struct net_device *dev)
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
2.50.1


