Return-Path: <netdev+bounces-200314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B8FAE47F2
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 17:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 989747A30FD
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 15:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C99F276033;
	Mon, 23 Jun 2025 15:08:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87703276026
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691309; cv=none; b=Zqq1MIGQexo6Eg1PFRK1r+Kv2hZGBfkb3yt1592PRAWJKbgF4N62AdHHpEClOI/JU2nZfGqxbi6NOyL0Ls5PNJvN38hcbpGdKEXvMv03K0upVRtsUP8mieet6I4sOjC3aEIRdCWr9VmBtN/YBt06FEAQjnvSJTPov0iMBsBbW0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691309; c=relaxed/simple;
	bh=98lyUqzfD7EZRUcZ94tyq+TOz6IPlGFFgY6/mq2H4zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f19NbCQyCp5C2N2cf/QdA9C07lhIVt+Hu2bUHFiG5bi6CR/Zhj6gnvygPubz7Fx6DVlwEKsPYJuEQtb3h+j3M675yhvsKSDsKSJI/CDH+boRai3iRZq2/PxLvysklFPaEeR8NMu3o0yJ0Eh+aG0rP6KBATWsDQ+Oqv6XZLZvcsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-748d982e97cso3820392b3a.1
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 08:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750691307; x=1751296107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GoykbQcVakXiirGiG8kpWchnqBZ3aa5Ymn0mKlx5JSM=;
        b=IgieWTYbM3JipI56jLujoqTH3+nPDMxvOyDKlUZzyQzw4aTy/SiKWLOiPwfjqhPv+p
         IzoonGOKyr0d4T0NO7yk4NeQQDdijAEV4024MVO5dCFCDeVrejGg6bagEcR0VUOvnAxT
         FVLKa4k2gxdDn3STHYaJclP+jtAnVBhBBfn667xI2Pf/FOZtHquY2lTCMja/cL5BFuts
         IPIkOMi21k96JiHD/4gT/OGQS9qIGgJUGIm0/r8naRRGSwkEv/wZPWyOvegO6yyYmQ1B
         tVNNCKIa8TZTBxDUxXcwxLgj9tXnLj1WOrJrgtTAYm68+quFx+h9K/0chaxnhAtjI6Kt
         uEGg==
X-Gm-Message-State: AOJu0YxEzm39g5f0WS0z2p/+jpWlKvfRTIB2as2d1w5z/QXggz5tVKOI
	dTf6u0+yxkwSb93Mya+YIK6cA9LX4NCPXF8k0zZp11kUrtEt8R6yfINV+mAh
X-Gm-Gg: ASbGnctDptqEjcULkEVZRkbAlndYmP3LcPLqpeI8oClGF5VAjVXmzpGdVCsOQ0ar6Kr
	fh7+x6D9QKwXvlqIJJrZVH7It0AXg/em9Vqn8R4z7++TdnVRkQgsyEJDb1ovbI88Edm7Ej31Qn6
	Ry+GxUUAoeQaCx/LBjBvsGe0yzWzcWJc3m+UNi7AZbBCrTfUS5C6a2Z4j6naWTbJTMFiYZhmwnQ
	vrySl/CIHt8U+qOGEc6GXPwGGNHH4jlTeE7rFcMG0DM71gZP9eb/1HKPiGu36+HHu5BMTrYR4Cu
	MT1dojiN691ovQ4hSnEF9qq8zwvl6f33U3I0JeexH5SizOwJL90S1YVL1yM8q11B0i4wL7BAjYq
	9fvB/izADxAAdITEbzHQZ0w4=
X-Google-Smtp-Source: AGHT+IEAQbM2nTf8U/qXlR0gcKs1WlWik75hztua9NLqJPebK8ATXfOr1nQ+BmoZ5yiBLgZ/0gJ7Tg==
X-Received: by 2002:a05:6a21:15c9:b0:1f5:8fe3:4e29 with SMTP id adf61e73a8af0-22026e13226mr20947474637.3.1750691306518;
        Mon, 23 Jun 2025 08:08:26 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b31f119f124sm8233391a12.32.2025.06.23.08.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 08:08:26 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next 8/8] net: s/dev_close_many/netif_close_many/
Date: Mon, 23 Jun 2025 08:08:14 -0700
Message-ID: <20250623150814.3149231-9-sdf@fomichev.me>
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
 drivers/net/ethernet/mediatek/mtk_eth_soc.c |  2 +-
 include/linux/netdevice.h                   |  2 +-
 net/8021q/vlan.c                            |  2 +-
 net/core/dev.c                              | 10 +++++-----
 net/dsa/dsa.c                               |  2 +-
 net/dsa/user.c                              |  2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index b38e4f2de674..04a65235a94f 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -4918,7 +4918,7 @@ void mtk_eth_set_dma_device(struct mtk_eth *eth, struct device *dma_dev)
 		list_add_tail(&dev->close_list, &dev_list);
 	}
 
-	dev_close_many(&dev_list, false);
+	netif_close_many(&dev_list, false);
 
 	eth->dma_dev = dma_dev;
 
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index dacc36ea1a21..25706261f79e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3351,7 +3351,7 @@ int netif_open(struct net_device *dev, struct netlink_ext_ack *extack);
 int dev_open(struct net_device *dev, struct netlink_ext_ack *extack);
 void netif_close(struct net_device *dev);
 void dev_close(struct net_device *dev);
-void dev_close_many(struct list_head *head, bool unlink);
+void netif_close_many(struct list_head *head, bool unlink);
 void netif_disable_lro(struct net_device *dev);
 void dev_disable_lro(struct net_device *dev);
 int dev_loopback_xmit(struct net *net, struct sock *sk, struct sk_buff *newskb);
diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index df19a9c0c9d9..18e243ec6f0f 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -446,7 +446,7 @@ static int vlan_device_event(struct notifier_block *unused, unsigned long event,
 				list_add(&vlandev->close_list, &close_list);
 		}
 
-		dev_close_many(&close_list, false);
+		netif_close_many(&close_list, false);
 
 		list_for_each_entry_safe(vlandev, tmp, &close_list, close_list) {
 			vlan_stacked_transfer_operstate(dev, vlandev,
diff --git a/net/core/dev.c b/net/core/dev.c
index 048abd75297d..89b9e78e1910 100644
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
+EXPORT_SYMBOL(netif_close_many);
 
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
@@ -12076,7 +12076,7 @@ void unregister_netdevice_many_notify(struct list_head *head,
 			netdev_lock(dev);
 		}
 	}
-	dev_close_many(&close_head, true);
+	netif_close_many(&close_head, true);
 	/* ... now unlock them and go over the rest. */
 	list_for_each_entry(dev, head, unreg_list) {
 		if (netdev_need_ops_lock(dev))
@@ -12084,7 +12084,7 @@ void unregister_netdevice_many_notify(struct list_head *head,
 		else
 			list_add_tail(&dev->close_list, &close_head);
 	}
-	dev_close_many(&close_head, true);
+	netif_close_many(&close_head, true);
 
 	list_for_each_entry(dev, head, unreg_list) {
 		/* And unlink it from device chain. */
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index 436a7e1b412a..dfe6463f7b8a 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -1621,7 +1621,7 @@ void dsa_switch_shutdown(struct dsa_switch *ds)
 	dsa_switch_for_each_cpu_port(dp, ds)
 		list_add(&dp->conduit->close_list, &close_list);
 
-	dev_close_many(&close_list, true);
+	netif_close_many(&close_list, true);
 
 	dsa_switch_for_each_user_port(dp, ds) {
 		conduit = dsa_port_to_conduit(dp);
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
2.49.0


