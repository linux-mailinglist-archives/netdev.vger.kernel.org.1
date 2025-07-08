Return-Path: <netdev+bounces-205156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C9DAFDA04
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 23:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62CAC7A2E08
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 21:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B77246794;
	Tue,  8 Jul 2025 21:38:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0231A8F84
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 21:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752010717; cv=none; b=EzdeYtSMFm3aFMdCGPsGIVkpXHUFcFCI1g5CemkJYSMzN4ilXXRs/1TrWJM8LHDZduyAtDcXUS2h+stWKF4BuaYk1GpPdl3kgS0cvNeMlHh4Yw3b1Gqf4XLsYHG28+0UiIzSN+QvhsmSNXQWu9n2ARsJlOr8eOYCjFmyWafaQGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752010717; c=relaxed/simple;
	bh=RsRMk7LZwGGue36nElpAe7JZZaa3wqUeuAGfBjrmr0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YErQSkWl/aCZ/q7r3GSGrMDDIXT7ylJVLuQk6iXg+AAOmp+XJCn6A3C/wWn199zGX7+VxDvkK0o0vk+73vUq99o9RFPgdxafbqvBp2rtd0HmRdvUeV2PlEpQ2/0hTI6BDllC0vQneA8Cdz9igrpuYOxTxgFSPeWvIY6y79ehsqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2349f096605so70468655ad.3
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 14:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752010714; x=1752615514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Imxlyyiv0dsEhQg0qUGXxFCM6Ol/jpVEC4ctBkLlHtc=;
        b=S6YfdQgfUaNRuO+rcE/Z+0HWn4Xs8PxnIlmr0Mioaqm4A/GwkJT8H13x9WoabCOKTt
         GDF7/uN30Roirt7e2Z6WsCKA0qHU846Zm3uUhFmeM99wYn9JXlK2Lv9pmCHtwGH+re7+
         aPmYrG0ijFr8JmkOdB039MtsJBs3lM4CqEI8ackU1qzWAlQRKO6KD2V/qAIEFiLK7OU9
         28ToOKYdf7eVNol4qvZYqVZIO2Bj75Q8P2oW7W028uuiwSMjd/bJ0o9zBGAdnAdvvYmb
         xKxdAVy1rmx9R80QKLJAwWdmiDt5KXcyvsgtgrxFt6/GCpHNYxyIyS/9ZfhiOVtXBnZU
         uDMQ==
X-Gm-Message-State: AOJu0Yx/aivxkXN9onbUpp7rsDB2GV1zoVl35crJrzN2sqCRUbcTZIg7
	L18Z+PsHgv82Q7HNk776A+gEuKDg5J69ySN2DU2odaX+rmC8nU+xKqjRPjvH
X-Gm-Gg: ASbGncukYR2q39p/FK5UJNDE4mRiScONXtjAYyG6BTRdE+RpfnC/HSkdiPqSwMb5p7T
	79uDoL8nT+E+WkBKz/eVjC8+HrnWq1FTUyqTzFAG0HdgjF9OKSaEGiZsutUrj5QmxAtsJmH3xNp
	WTCC9B3apVEYAC52l1hJDV9zi/JfLcVF24SOxDUi0/UgvNCH4CopGZfVFn4zL9PFjpiIMd2ZXn/
	fjMqnkp/q2wKpA6OxDYWOoUR1Jep2WrTrgSLVPgZlHcFiKmFxe22oAXazyouB72cxToRpneYnXd
	hATMAGZ9SvIkzvstz91E8tHlnkOWlAxxmUHv4xX17mxrTSSdwigkxzMVRcDljpQgD4Hz4J8f4ta
	XA8v+/Ju/Rfs1n2cPb2cUxoY=
X-Google-Smtp-Source: AGHT+IE0BlVtxsLsZillCwGrewYnPBSgWZwEx+T+lFAXAWwlokNg+V3asENAUbz3e3oq9JtPpkNoZA==
X-Received: by 2002:a17:903:f90:b0:235:a9b:21e7 with SMTP id d9443c01a7336-23ddb377578mr466315ad.48.1752010714130;
        Tue, 08 Jul 2025 14:38:34 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23c8431e28csm122398255ad.24.2025.07.08.14.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 14:38:33 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v3 2/8] net: s/dev_get_port_parent_id/netif_get_port_parent_id/
Date: Tue,  8 Jul 2025 14:38:23 -0700
Message-ID: <20250708213829.875226-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708213829.875226-1-sdf@fomichev.me>
References: <20250708213829.875226-1-sdf@fomichev.me>
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
index 795a5d522cf8..9ef790a9fce0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9817,16 +9817,15 @@ int dev_get_phys_port_name(struct net_device *dev,
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
@@ -9845,7 +9844,7 @@ int dev_get_port_parent_id(struct net_device *dev,
 		return err;
 
 	netdev_for_each_lower_dev(dev, lower_dev, iter) {
-		err = dev_get_port_parent_id(lower_dev, ppid, true);
+		err = netif_get_port_parent_id(lower_dev, ppid, true);
 		if (err)
 			break;
 		if (!first.id_len)
@@ -9856,7 +9855,7 @@ int dev_get_port_parent_id(struct net_device *dev,
 
 	return err;
 }
-EXPORT_SYMBOL(dev_get_port_parent_id);
+EXPORT_SYMBOL(netif_get_port_parent_id);
 
 /**
  *	netdev_port_same_parent_id - Indicate if two network devices have
@@ -9869,8 +9868,8 @@ bool netdev_port_same_parent_id(struct net_device *a, struct net_device *b)
 	struct netdev_phys_item_id a_id = { };
 	struct netdev_phys_item_id b_id = { };
 
-	if (dev_get_port_parent_id(a, &a_id, true) ||
-	    dev_get_port_parent_id(b, &b_id, true))
+	if (netif_get_port_parent_id(a, &a_id, true) ||
+	    netif_get_port_parent_id(b, &b_id, true))
 		return false;
 
 	return netdev_phys_item_id_same(&a_id, &b_id);
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index b4cc116acd4b..b61cc04f1777 100644
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
index 1cb3a264030f..c75901e50a0c 100644
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
2.50.0


