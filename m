Return-Path: <netdev+bounces-202581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF37AEE4DA
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B2847A7E8A
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0424E293B61;
	Mon, 30 Jun 2025 16:42:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED2728FFEC
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 16:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751301758; cv=none; b=jOXPuwsKlABaAFVceNhAJ38D9ho6y2l1JpQEU+fgyTVcUVVIgV4sGBSJMqDZFmQOk0akKNa29sp+kNRYpXjlKvET7IUiQMrNBSfmo1ZI927hujXd1LoA9DXH45pvU5rJNyPkF3LxkYJ+Emst0d1eh/5YWMmjsdMfOmHUzzFU9bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751301758; c=relaxed/simple;
	bh=4GPgmqWAhgS8GfGazTF2DAgqeN1yefkamDu7GpsPQ2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eN6KXe3i4wkFcdPbxVHpm/OLPK7K1yIaI7UQ6hmPLa47/ntlbkTb9K8XmhPsvtc1pGUSufB551++9kmC8En99NrpCCXPGjs9AD0dHTD/yKbhZG0+a9tvFhL1Efcr9Aa4lhE4cn4/Y0jgaS88Fh1ZKxIWlt+9TaiLFVO7uZAm/+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-74af4af04fdso3381501b3a.1
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 09:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751301756; x=1751906556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yp9LuapRMB49e8jR+kUVa5SIk+6ceASoHvbHoQfijkU=;
        b=dxdP+omEIy56vfRpazG+v77Q09Tf024X+en4h+J56u65eSmY2kP8r3T9169Z2bpW0X
         pCkLYDGLs8ZCXiQHbqyynwsbt6YqWPa9mSlkpsWJo3xfF6LiRlrRy5TX5nFbvuflN0zO
         k/XvSxwyEV6TAPS9mEWZmB2cw1SQPrp2x1yyaVHasOpMB2/kt15J0eeqng3wDgU1NDsM
         jURQsj0s9FJOvWSDRFywvNwAiNAgMcKmNAKkVpSZLgQsSgO3tGtj2pn6jW2qar1uBDEC
         6MLg2TYJub5j3VOeIRPELMNSgBvwIgjT0WKxoNQOy3ds8EnBeTeWeQoLWqPLk60cDhdl
         yhiQ==
X-Gm-Message-State: AOJu0YyV6DgQEByNv6fdVcsvPKf7Zk+UIyPu7F+NQnJ6lwnnzWBP5GW9
	WGnXiiJ9mgng0RaCZK5PuNwzZJTtr5S50i15WkwWOX2OjU95oKqY+jWupar0
X-Gm-Gg: ASbGncsZXgsWp1OWyE13FmxCKoefUdMPqZ+cEJmvSv+wzjBZ6a5ThsfmmJwd32VbrrU
	YxqNBCdsP45KHs4AoZ/HqFcYyu27iOFavCIKX4HKw//MYWeP5TD/8uuhprXIuWxMr886EOaWeC7
	HKK9OzfbS+VqndwC6TxL3m7/BOKzaj2eUEfQjAN2rUcS0jkfBfv7JG1EmWDJTM+0Jqgq0YWJfBB
	CD/b1O7v87pmx57+6pMe2Baip6pvO0susv5CjrSIHjbwUA2QlR671JFvwKXy1Yye7eHXIlg+wDf
	5VPtwYZWd6FbgTs9Pm2iSY5YzEEJWc6QWoP52wuC/LvrS4J7DZm3upbj0kXb6hye+L/+PqjmZuX
	02pgbjBP1MVktQUDDOM3CAr8=
X-Google-Smtp-Source: AGHT+IFJdMRB/clEtYMUu26bL/VIQKmioHuOuZJINgvMR7+t8rSvdp5zCji4hNsaAQAKxqHH872yqg==
X-Received: by 2002:a05:6a00:66e7:b0:736:4c3d:2cba with SMTP id d2e1a72fcca58-74b3bcc1736mr313217b3a.9.1751301756188;
        Mon, 30 Jun 2025 09:42:36 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af557440fsm9949426b3a.74.2025.06.30.09.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 09:42:35 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v2 8/8] net: s/dev_close_many/netif_close_many/
Date: Mon, 30 Jun 2025 09:42:22 -0700
Message-ID: <20250630164222.712558-9-sdf@fomichev.me>
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

netif_close_many is used only by vlan/dsa and one mtk driver, so move it into
NETDEV_INTERNAL namespace.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c |  4 +++-
 include/linux/netdevice.h                   |  2 +-
 net/8021q/vlan.c                            |  4 +++-
 net/core/dev.c                              | 10 +++++-----
 net/dsa/dsa.c                               |  4 +++-
 net/dsa/user.c                              |  4 +++-
 6 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index f8a907747db4..004ece722a83 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -31,6 +31,8 @@
 #include "mtk_eth_soc.h"
 #include "mtk_wed.h"
 
+MODULE_IMPORT_NS("NETDEV_INTERNAL");
+
 static int mtk_msg_level = -1;
 module_param_named(msg_level, mtk_msg_level, int, 0);
 MODULE_PARM_DESC(msg_level, "Message level (-1=defaults,0=none,...,16=all)");
@@ -4960,7 +4962,7 @@ void mtk_eth_set_dma_device(struct mtk_eth *eth, struct device *dma_dev)
 		list_add_tail(&dev->close_list, &dev_list);
 	}
 
-	dev_close_many(&dev_list, false);
+	netif_close_many(&dev_list, false);
 
 	eth->dma_dev = dma_dev;
 
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
index df19a9c0c9d9..0296239dd7e7 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -35,6 +35,8 @@
 #include "vlan.h"
 #include "vlanproc.h"
 
+MODULE_IMPORT_NS("NETDEV_INTERNAL");
+
 #define DRV_VERSION "1.8"
 
 /* Global VLAN variables */
@@ -446,7 +448,7 @@ static int vlan_device_event(struct notifier_block *unused, unsigned long event,
 				list_add(&vlandev->close_list, &close_list);
 		}
 
-		dev_close_many(&close_list, false);
+		netif_close_many(&close_list, false);
 
 		list_for_each_entry_safe(vlandev, tmp, &close_list, close_list) {
 			vlan_stacked_transfer_operstate(dev, vlandev,
diff --git a/net/core/dev.c b/net/core/dev.c
index 13ad0faac996..9a9617f6844a 100644
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
index 436a7e1b412a..1d906f96bddc 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -28,6 +28,8 @@
 #include "tag.h"
 #include "user.h"
 
+MODULE_IMPORT_NS("NETDEV_INTERNAL");
+
 #define DSA_MAX_NUM_OFFLOADING_BRIDGES		BITS_PER_LONG
 
 static DEFINE_MUTEX(dsa2_mutex);
@@ -1621,7 +1623,7 @@ void dsa_switch_shutdown(struct dsa_switch *ds)
 	dsa_switch_for_each_cpu_port(dp, ds)
 		list_add(&dp->conduit->close_list, &close_list);
 
-	dev_close_many(&close_list, true);
+	netif_close_many(&close_list, true);
 
 	dsa_switch_for_each_user_port(dp, ds) {
 		conduit = dsa_port_to_conduit(dp);
diff --git a/net/dsa/user.c b/net/dsa/user.c
index e9334520c54a..59ea36802434 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -31,6 +31,8 @@
 #include "tag.h"
 #include "user.h"
 
+MODULE_IMPORT_NS("NETDEV_INTERNAL");
+
 struct dsa_switchdev_event_work {
 	struct net_device *dev;
 	struct net_device *orig_dev;
@@ -3604,7 +3606,7 @@ static int dsa_user_netdevice_event(struct notifier_block *nb,
 			list_add(&dp->user->close_list, &close_list);
 		}
 
-		dev_close_many(&close_list, true);
+		netif_close_many(&close_list, true);
 
 		return NOTIFY_OK;
 	}
-- 
2.49.0


