Return-Path: <netdev+bounces-207989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A0EB09323
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 19:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA242A4789F
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B37E2FD891;
	Thu, 17 Jul 2025 17:23:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25402FE399
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 17:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773024; cv=none; b=TP/Eb04oAPiJ0tM1BCKnbwU5UGVaT3n8siCaghArnm+FrJ03z6geBxzYqxlHo7bUhUfnTl0+eS5xiW9ACIxhacFloicGbntXUtF7XsAG81NcixhtVAHNeuFz9scR8/idmR0xSlKA9UORAEO1aMpicgxdi43hpzIXImwgGtl+WYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773024; c=relaxed/simple;
	bh=bKwuK3zVZKMwbcpf+eXx/SAOhgfDGG/80vGds3PVVl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejGBRZszD/aZi9Nc4J7CToa5uAw0rJQtT5z37qqPaKl5kgoYUOyNFJD/ahyIat/8djzEHCXTJvNoEdLoufuoTGFGL/asdIL8FPrucwgHKAzoAJ4+7bFGNWEgbEX8tur6o+auihPWye70EjVsHEOSelLg7IPLjsPPQgSfu/LcBRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-742c3d06de3so1466074b3a.0
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 10:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752773022; x=1753377822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ck7OCLf01Zi3+tl7N+A3zlLZm9WIGWSI8GXDVbraTo=;
        b=g+Sr934SSaKY99AtQUlZ9Qm/bkhqXa07XTb25bkokyw5azVsf2pvM5OOuNu7MjE7h3
         OlZ/jMcSKEWSqripjavZ2Qs02rM/kzZQ8M35bXhhcHn5jj7bz1R2b+uuxbxf7/oXf94j
         faNH5VhT6wOys7K7uLkexvBEaycmnZqhV7tON2sLfgRRr35y+hj2XU6c04DKNObyIomO
         pUeb188GVgJb3uVg8ALideZTE03eLlBzCs+nmCC8fzxzaULQm4dDe6NdrqLmO3tgoWYJ
         yWagyB4BNPSaT8Am2upqur6STBR/oZk6lp0WUSoFOzK/GTbVmnDsU6gLrv+Psc7ifs3W
         7NCw==
X-Gm-Message-State: AOJu0YzpdfLUO5eOf9GKckcSByA5Roop7TA1y2LlCaweoUsBpiWgO5Pm
	R/KvQyOC+xDDZ8kg91bTZMPsJbQs763UUk53EvfGsxrr2NZLplrQMfM+0+6A
X-Gm-Gg: ASbGnctHrqrpJ4jLSipUrds4TsuQelSgNyon/qzTd6x71Gl3tDD51dMzJf/q4p7Waks
	haQ7fuf28TXCZHBl1iF0Z8otDv1b0ky0RNqK0md3DrNjWACqk1OR1Bt1XqfmmOvHtV9xZ6bnZVB
	l2GHA08YZKt7fKqXK3o9FPWZSS72f8qWZXXtPLcDaTY0qAPQb2EJ10hQyPIQftO4967HN86OObj
	NSyyRNYLLuAWb+33hSSs5qO32g0qzp937xYqKtGOm4A0TopJRMGGrCroTGmopbj3z7TW8AD5C5w
	/e/3URhy/LhXSXH5mv/1/XT7ts8vUYBQgRziwio9P2DRwYxeMpDkSts3l5ug/zTIbLzJXqjHFwa
	L6Ocjbv0v/KQXVy2qfWwzMZ2FMK+LNn7xewihKbLEzBRYdz9nf3tWDKIe/tI=
X-Google-Smtp-Source: AGHT+IHoQCFlbbv4JlN9mxZLGSetcTRFT7aZB46REh3CfuxLZSAMeyi0DZ8jI4D9PsbgFlA4GwhqMw==
X-Received: by 2002:a05:6a21:6f13:b0:225:6703:1450 with SMTP id adf61e73a8af0-23812947efdmr11551682637.21.1752773021726;
        Thu, 17 Jul 2025 10:23:41 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74eb9f1d4dcsm16446649b3a.85.2025.07.17.10.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 10:23:41 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v5 7/7] net: s/dev_close_many/netif_close_many/
Date: Thu, 17 Jul 2025 10:23:33 -0700
Message-ID: <20250717172333.1288349-8-sdf@fomichev.me>
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
index 7929ddfd4433..5aee8d3895f4 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3343,7 +3343,7 @@ int netif_open(struct net_device *dev, struct netlink_ext_ack *extack);
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
index 99f1e87f8274..107e6ba46bb2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1768,7 +1768,7 @@ static void __dev_close(struct net_device *dev)
 	list_del(&single);
 }
 
-void dev_close_many(struct list_head *head, bool unlink)
+void netif_close_many(struct list_head *head, bool unlink)
 {
 	struct net_device *dev, *tmp;
 
@@ -1786,7 +1786,7 @@ void dev_close_many(struct list_head *head, bool unlink)
 			list_del_init(&dev->close_list);
 	}
 }
-EXPORT_SYMBOL(dev_close_many);
+EXPORT_SYMBOL_NS_GPL(netif_close_many, "NETDEV_INTERNAL");
 
 void netif_close(struct net_device *dev)
 {
@@ -1794,7 +1794,7 @@ void netif_close(struct net_device *dev)
 		LIST_HEAD(single);
 
 		list_add(&dev->close_list, &single);
-		dev_close_many(&single, true);
+		netif_close_many(&single, true);
 		list_del(&single);
 	}
 }
@@ -12095,7 +12095,7 @@ void unregister_netdevice_many_notify(struct list_head *head,
 			netdev_lock(dev);
 		}
 	}
-	dev_close_many(&close_head, true);
+	netif_close_many(&close_head, true);
 	/* ... now unlock them and go over the rest. */
 	list_for_each_entry(dev, head, unreg_list) {
 		if (netdev_need_ops_lock(dev))
@@ -12103,7 +12103,7 @@ void unregister_netdevice_many_notify(struct list_head *head,
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
2.50.1


