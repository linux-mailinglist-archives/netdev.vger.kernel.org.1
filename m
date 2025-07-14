Return-Path: <netdev+bounces-206869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0A9B04A7B
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD9551A64012
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 22:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35400289817;
	Mon, 14 Jul 2025 22:19:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9D0288C9C
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 22:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752531550; cv=none; b=gzoxQjqlwJ8tEu9YfOTtcKPcjoHAnVqGdK79iZlyMYCSNcEyX+EW4wXZTs72GwUe9PqyjqZbh7XgSNS/qs0GWmv3dMo8TA4yuKIv9h8IEksTAa3n+yqSUZY6EI8Z8rxnhsY3srpbjp4HtdU6yKvhwTeqIVBzyaESTgLV466MqIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752531550; c=relaxed/simple;
	bh=WvLsStrebJnK8Q/MUh6sAHBydM1B/AoYs/mb+Oep6r8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7T+A189nmrCecr4OzgZ/ZBr61DVH4nP0uQ1QxyNBGDowEP/KvpzQpgbqLA5Rvd/02dL1GN5YnuJVG623l1wGOWQQmFsK9OdB8SXzvZppjr+zTndxBwvCe2fHwTXbjegaPDEac8xOwS1ZA4PMf6BjAij9PojjGZ+DveDQPkYkb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-749068b9b63so3276661b3a.0
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 15:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752531547; x=1753136347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P9M//saJPuE88O9CpOU1r2acc8qBz1YkKh+TqxRJEJ4=;
        b=tEqt6oZWiaAHHAUgXSAG77etlagrPGOJ31JA/JHros06l/S3SPU9epzIGKuzFFQCN6
         AtjaurtfzqT2/TIPiSOhwvE4JM4AwbQqY/ZRKignDuCc5/mpK5hT6aKyMOWwbusoP6UD
         qvhFX9/krBHn3JgreN+ehD0xlDOAPYaZNDSocbsmXlMLEMBAYgiK+5rkUKFtMQs89Mxg
         48XQtkOeRBS6FVFXutgRXwx/vEfM/mIcHZd9hdr4QUeqvgcTfo/DpHuMHPAzwq46NOj5
         80UUb+2H2Ob0BdZjCfhjYJmgVIkrXCH9ZLRuxNex1PWJeMEKGU6x+uheCAOg79qbIhfy
         KejA==
X-Gm-Message-State: AOJu0YxyolT8TX0Y3/N/74yYEQvsZ/ijww136MsqlClYXsbGeTz65qPf
	//X2xZi8LPIrHGiBjLJV7usNWY8NcmS/7fBkHCHWeOb5rtTiGLGxtNlsMu11
X-Gm-Gg: ASbGnctt17bxdBTeFCMESoTOJhpOxVgJSmEgRh7Ki0PZi88nuVMgys3rHzmLYDN/W5l
	rvvvJQt1O+4m9oGg/9GDm4qsQ6QHZHcoqDnzCbj+t0y7ITOJ5NViI6+rmrz3yt8XISmSGcVGK5b
	AtGmSuxJNkRTZjfjoChH0hgoMLzO/w7LI98dXb/QEwkWukVq0mYl/CgySz6XyPFd+NCWElQbhke
	OkzSboBc81klskE35hIZciA4v/9M4FxA5n4pzwlhzqbMpYK/ufIrG/IgN85lP+wZV256C/O7ThM
	3EYUp6t2jdr/2IVUbEYrJcc3OfEzemsXQLFr5r4GYvxF8qHk8u1gVOgVynG8SJwCGFNJC9HMf1b
	RohLuVIbe3ljEgYV3+ZW7N4qJF6hKSR5QjRq7QNpM6Z7vc1cgK54WXaKjUao=
X-Google-Smtp-Source: AGHT+IE+HnVPnAVNwSL60Sg7aSl1BVUsFcpkMU2jC+/shMsN8nNe88YCUjuKPaWVT5c8U93oLcGJ0g==
X-Received: by 2002:a05:6a20:6a0e:b0:233:b51a:8597 with SMTP id adf61e73a8af0-233b51a8602mr13306534637.35.1752531547586;
        Mon, 14 Jul 2025 15:19:07 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b3bbe6c5660sm10674255a12.48.2025.07.14.15.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 15:19:07 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v4 7/7] net: s/dev_close_many/netif_close_many/
Date: Mon, 14 Jul 2025 15:18:55 -0700
Message-ID: <20250714221855.3795752-8-sdf@fomichev.me>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250714221855.3795752-1-sdf@fomichev.me>
References: <20250714221855.3795752-1-sdf@fomichev.me>
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

netif_close_many is used only by vlan/dsa and one mtk driver, so move it into
NETDEV_INTERNAL namespace.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c |  3 ++-
 include/linux/netdevice.h                   |  2 +-
 net/8021q/vlan.c                            |  3 ++-
 net/core/dev.c                              | 10 +++++-----
 net/dsa/dsa.c                               |  3 ++-
 net/dsa/user.c                              |  2 +-
 6 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 11ee7e1829bf..5a5fcde76dc0 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -4967,7 +4967,7 @@ void mtk_eth_set_dma_device(struct mtk_eth *eth, struct device *dma_dev)
 		list_add_tail(&dev->close_list, &dev_list);
 	}
 
-	dev_close_many(&dev_list, false);
+	netif_close_many(&dev_list, false);
 
 	eth->dma_dev = dma_dev;
 
@@ -5610,3 +5610,4 @@ module_platform_driver(mtk_driver);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("John Crispin <blogic@openwrt.org>");
 MODULE_DESCRIPTION("Ethernet driver for MediaTek SoC");
+MODULE_IMPORT_NS("NETDEV_INTERNAL");
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 295457fbcfd1..e6131c529af4 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3344,7 +3344,7 @@ int netif_open(struct net_device *dev, struct netlink_ext_ack *extack);
 int dev_open(struct net_device *dev, struct netlink_ext_ack *extack);
 void netif_close(struct net_device *dev);
 void dev_close(struct net_device *dev);
-void dev_close_many(struct list_head *head, bool unlink);
+void netif_close_many(struct list_head *head, bool unlink);
 void netif_disable_lro(struct net_device *dev);
 void dev_disable_lro(struct net_device *dev);
 int dev_loopback_xmit(struct net *net, struct sock *sk, struct sk_buff *newskb);
diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index df19a9c0c9d9..7b29e0be74bd 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -446,7 +446,7 @@ static int vlan_device_event(struct notifier_block *unused, unsigned long event,
 				list_add(&vlandev->close_list, &close_list);
 		}
 
-		dev_close_many(&close_list, false);
+		netif_close_many(&close_list, false);
 
 		list_for_each_entry_safe(vlandev, tmp, &close_list, close_list) {
 			vlan_stacked_transfer_operstate(dev, vlandev,
@@ -741,3 +741,4 @@ module_exit(vlan_cleanup_module);
 MODULE_DESCRIPTION("802.1Q/802.1ad VLAN Protocol");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(DRV_VERSION);
+MODULE_IMPORT_NS("NETDEV_INTERNAL");
diff --git a/net/core/dev.c b/net/core/dev.c
index dce23b445ad1..26253802f6cd 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1767,7 +1767,7 @@ static void __dev_close(struct net_device *dev)
 	list_del(&single);
 }
 
-void dev_close_many(struct list_head *head, bool unlink)
+void netif_close_many(struct list_head *head, bool unlink)
 {
 	struct net_device *dev, *tmp;
 
@@ -1785,7 +1785,7 @@ void dev_close_many(struct list_head *head, bool unlink)
 			list_del_init(&dev->close_list);
 	}
 }
-EXPORT_SYMBOL(dev_close_many);
+EXPORT_SYMBOL_NS_GPL(netif_close_many, "NETDEV_INTERNAL");
 
 void netif_close(struct net_device *dev)
 {
@@ -1793,7 +1793,7 @@ void netif_close(struct net_device *dev)
 		LIST_HEAD(single);
 
 		list_add(&dev->close_list, &single);
-		dev_close_many(&single, true);
+		netif_close_many(&single, true);
 		list_del(&single);
 	}
 }
@@ -12070,7 +12070,7 @@ void unregister_netdevice_many_notify(struct list_head *head,
 			netdev_lock(dev);
 		}
 	}
-	dev_close_many(&close_head, true);
+	netif_close_many(&close_head, true);
 	/* ... now unlock them and go over the rest. */
 	list_for_each_entry(dev, head, unreg_list) {
 		if (netdev_need_ops_lock(dev))
@@ -12078,7 +12078,7 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		else
 			list_add_tail(&dev->close_list, &close_head);
 	}
-	dev_close_many(&close_head, true);
+	netif_close_many(&close_head, true);
 
 	list_for_each_entry(dev, head, unreg_list) {
 		/* And unlink it from device chain. */
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 436a7e1b412a..5b01a0e43ebe 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -1621,7 +1621,7 @@ void dsa_switch_shutdown(struct dsa_switch *ds)
 	dsa_switch_for_each_cpu_port(dp, ds)
 		list_add(&dp->conduit->close_list, &close_list);
 
-	dev_close_many(&close_list, true);
+	netif_close_many(&close_list, true);
 
 	dsa_switch_for_each_user_port(dp, ds) {
 		conduit = dsa_port_to_conduit(dp);
@@ -1829,3 +1829,4 @@ MODULE_AUTHOR("Lennert Buytenhek <buytenh@wantstofly.org>");
 MODULE_DESCRIPTION("Driver for Distributed Switch Architecture switch chips");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:dsa");
+MODULE_IMPORT_NS("NETDEV_INTERNAL");
diff --git a/net/dsa/user.c b/net/dsa/user.c
index e9334520c54a..f59d66f0975d 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -3604,7 +3604,7 @@ static int dsa_user_netdevice_event(struct notifier_block *nb,
 			list_add(&dp->user->close_list, &close_list);
 		}
 
-		dev_close_many(&close_list, true);
+		netif_close_many(&close_list, true);
 
 		return NOTIFY_OK;
 	}
-- 
2.50.0


