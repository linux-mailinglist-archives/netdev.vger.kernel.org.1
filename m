Return-Path: <netdev+bounces-205162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D58CCAFDA0D
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 23:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375D81BC67B7
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 21:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF81F24DD0E;
	Tue,  8 Jul 2025 21:38:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A56C1A8F84
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 21:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752010725; cv=none; b=tCAcc15I51yEOcOByihx6s+jL5lQ0LlZM7hvtoakX5TDv6zyTHTVRhALPV4BQlseKWalRiBfGMSqahSU9pNNhQhV0raXoUWXCX5RwlxmCQe9wJvsUogQ1WciWikpBx+GiRrIGRu7zbLnNt8tbsMK4L5KMWvTaZ03L4Vtd8RVKRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752010725; c=relaxed/simple;
	bh=ivIYs8dSvb1YRpMrBKboxvB/79SyH+j1H+7bZYqyV0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JG/4Nbdj9aAqEsEU87B5CAvLQpMktNuCrSyIq7hL3pughBpshhkhOY8hh7RVgHH+SAXwYPLNK64NPOy9w6tHDAU8VSsceSY2AkjI00NipKozt/0l9CpnwkWl6Mj5QojRSv91OVcx/CUZ8WgqOs+cBM3gpqu8YdVaM4nLHWKBQBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso3951738b3a.2
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 14:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752010723; x=1752615523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LlKBJdtGqV1/C5Ucj7xiZF5hC1Tub9ejcu9cDIV/4Q=;
        b=QVSkJ8HwAyomeg9z5wTnb+XkDXGx2R96pka6Wy48I6o+iIbHmEE7Vddh2jnIcgc4uA
         d82z7NrWTN7YE9LQY+p61PJzWMP3q1NtHdqmYsPwu8NJd6/2u5BsTlPxX9TmlJNWIDzX
         3rq447LucputqgA/kCbGVYddWSXcGjlzOuh+wyOwBMrfnkYUDLxtmyd2sRNaA0mPT0AQ
         YEgZbQic/tEGTF6lG4XfyqyhGE5nJ+1UcFRRK0wAKKnWfMWRSV7PEfEmr9PBOhGjTA8z
         c3EqTyBrvN32R3t+xSHk4SDlePVA98i5HO13e2mBLhf+mOiVJLTc0O+BzcijFPY0KV9j
         PDFw==
X-Gm-Message-State: AOJu0Yy2DYU0tztDzPx5Fk5yYmvpeALaN7W3PeXegm4PHqENysteyRSF
	LPDP4qVYn03NP6PtUT4dQzk+BA9LsEJHpJ2zXAg/yrvRhVpcqNNs2kMdn2j+
X-Gm-Gg: ASbGncuNzbg9Tu123iDWTZhAE9U4XI9GpoZACat9cyvnlTBB1X3XqqYahZDQWflB1Ll
	0I+PYJ1xLmzNN3ib/1BKdFOXOQS/IHfM7byeDkKsSsnZCrp33mYvLc1/qSVTF9b8j4bW6dnfZy4
	HZdifMjnl7e19idbKJ5FV3FjSBvRnd/jhJCbtP6vyjgWiwri0y2R+shqbWDZ6kHkQ78T8AJDkHW
	WX6uqZcasCgCDmnDtH+AT757ZCu8OEJI/cRU0T7mFnO+tqY5GrF9wG9+E/V90hV2nHb2j8m5WWd
	hEzJU0IvrPpk88q8DvzT0aA0CXynUuLASxUAgmI8frMSiLg823fJRXbEukFfKUg9XWnt0fOhRvU
	zs5YDV0Nq2a3YoUDGt3kLYU0=
X-Google-Smtp-Source: AGHT+IG4LUF/k2d0wr1VVbJB7KySIRvOFkn02xRKGbzh3OkrAjSRYyM5kPopRzPnuJ9Ur2JjoI9qmA==
X-Received: by 2002:a05:6a00:854:b0:736:d297:164 with SMTP id d2e1a72fcca58-74ea642dbbcmr248538b3a.1.1752010723003;
        Tue, 08 Jul 2025 14:38:43 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b399d206351sm1064322a12.68.2025.07.08.14.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 14:38:42 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v3 8/8] net: s/dev_close_many/netif_close_many/
Date: Tue,  8 Jul 2025 14:38:29 -0700
Message-ID: <20250708213829.875226-9-sdf@fomichev.me>
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
index 558b29d34f2e..e5aae0ecf138 100644
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
index 3e33505a8b3c..ae79dc1fda1d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1769,7 +1769,7 @@ static void __dev_close(struct net_device *dev)
 	list_del(&single);
 }
 
-void dev_close_many(struct list_head *head, bool unlink)
+void netif_close_many(struct list_head *head, bool unlink)
 {
 	struct net_device *dev, *tmp;
 
@@ -1787,7 +1787,7 @@ void dev_close_many(struct list_head *head, bool unlink)
 			list_del_init(&dev->close_list);
 	}
 }
-EXPORT_SYMBOL(dev_close_many);
+EXPORT_SYMBOL_NS_GPL(netif_close_many, "NETDEV_INTERNAL");
 
 void netif_close(struct net_device *dev)
 {
@@ -1795,7 +1795,7 @@ void netif_close(struct net_device *dev)
 		LIST_HEAD(single);
 
 		list_add(&dev->close_list, &single);
-		dev_close_many(&single, true);
+		netif_close_many(&single, true);
 		list_del(&single);
 	}
 }
@@ -12066,7 +12066,7 @@ void unregister_netdevice_many_notify(struct list_head *head,
 			netdev_lock(dev);
 		}
 	}
-	dev_close_many(&close_head, true);
+	netif_close_many(&close_head, true);
 	/* ... now unlock them and go over the rest. */
 	list_for_each_entry(dev, head, unreg_list) {
 		if (netdev_need_ops_lock(dev))
@@ -12074,7 +12074,7 @@ void unregister_netdevice_many_notify(struct list_head *head,
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


