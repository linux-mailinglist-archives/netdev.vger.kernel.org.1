Return-Path: <netdev+bounces-200309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB031AE47F7
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 17:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3FA0189CECA
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 15:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB26266B65;
	Mon, 23 Jun 2025 15:08:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2359261574
	for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 15:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691302; cv=none; b=EusAcXvY2jQpCGB0T1+Km+Obud3Kuoo3BqYOsVUm0dX5oaEf8OIsgqhf0xNUob4QUNgEGXuKjU/XJNa6TxEYNLZZDWCE3C44qYFGT7AXCkT8xv+DpD3ZakTdpyrGlFxgI7KTbZybMs2J456hkw+rJrSQWx/8yvr+TQ1NhdpozRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691302; c=relaxed/simple;
	bh=ZA1a7CfkWMKAOYYaJp8+LiMJidHV4/EYXy3EsicgI70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EnM4ByzqYDZle02REK8wAWr0axTbCiReDkoxEqULxlp1w+oUyWU5hAuFNRl80p/MAGfdchuG0yJs/HJxyiOKjxUlSLdoSKsiWJCtSUwrC2bOuYp5FkVgsAFokQjRF3MVw7uS0QjaPRs4q/yyosHVJZbZh2/pcUcnNbexwqCxQMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-23636167b30so39612265ad.1
        for <netdev@vger.kernel.org>; Mon, 23 Jun 2025 08:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750691300; x=1751296100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48l5CZGDXRCFpniKWXL+nbYFutAFOR0gp8JGrrtZrLY=;
        b=T1okhvmttVKcDkjKVWqy9Q0tJwAyjl6EeKdpFkHYs6WnUAUhW5pEd09x6UCRDUEJun
         BwGhbQTk2VV3i2sDzmNatkGcJ9XpGRS19uS96M7awHfPIRJDkWL5wZcfhbZ7ZnXRxZYx
         fSoLWobi8JUXsvv8g68jIJSQgwSLUIVQ6jNAFT2+yntFiJlRAbvSXMSGrgyvWG+diuR5
         rdxvq1dbNKoXoTcHAGC2uQn6e3/3bmI7ikGL5wkos3ANekjP/83hvf2PwafoMzhMZcA0
         Z/iCdiGS8JVxZs7OHCeNi4afCKMGL+1hSjGY9837d4RN8MiUR2IDUSGNPC7Nt2t4UwvI
         B7HA==
X-Gm-Message-State: AOJu0Yw/IUimtXWxDzYtHDhzcYxgqpQsLwUFpXid46OkfW5WAsB809/Q
	BQr7SC2TncjsJD/Z3pWbkMZILS5oc9cDf5kwRpDFFJBTUCjKR1i7apNPd8Ej
X-Gm-Gg: ASbGncv932RWVLrv15ZvA4LWlZTJUKTC+77ZWCECnSfxbF23UVaFGlCTVg+CPsCmk3i
	mxPKA3dK3Foq7X4m+r36A8ESrzfRhBxzzEW//MqdA96YAG0puZ1YePG6u+V1WzgitCgH9Fpt5bC
	7sRG3Jk0nipZYyn5lkzGojC1fEdFjAWMldB/bLCpv/QmMQDuDVRnMdFe+JnEy9YCacE+k8J3+Dz
	g4Wm8pTe8fttaOQpTMmjv97InZmZIxybQ9jJkrGAg1MqDfANh2PnUyB0C53WX4/ZZcCuRtma525
	yRdGDKi/087LBjTopbfCU4gDeUTzwZubTsiCZqB1Gs1wc0SLo7UGdHgfNF8aAj4xh5NoXkRx6Xe
	LWTaDXOy5eTwAj2gRFbjlizE=
X-Google-Smtp-Source: AGHT+IH0yqk2//6RSCnOulKQgzR01XSqMV0gfWBcNqVD70JRzj6RNp6vkF/gd8tfwQZlJn5SmTNFKA==
X-Received: by 2002:a17:903:2302:b0:235:7c6:ebbf with SMTP id d9443c01a7336-237d9967be8mr215524895ad.35.1750691299819;
        Mon, 23 Jun 2025 08:08:19 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-237f5c7f4f3sm33017725ad.198.2025.06.23.08.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 08:08:19 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next 3/8] net: s/dev_get_mac_address/netif_get_mac_address/
Date: Mon, 23 Jun 2025 08:08:09 -0700
Message-ID: <20250623150814.3149231-4-sdf@fomichev.me>
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
 drivers/net/tap.c         | 4 ++--
 drivers/net/tun.c         | 2 +-
 include/linux/netdevice.h | 2 +-
 net/core/dev.c            | 4 ++--
 net/core/dev_ioctl.c      | 3 ++-
 net/core/net-sysfs.c      | 2 +-
 6 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index bdf0788d8e66..600db04d44e4 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1000,8 +1000,8 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
 			return -ENOLINK;
 		}
 		ret = 0;
-		dev_get_mac_address((struct sockaddr *)&ss, dev_net(tap->dev),
-				    tap->dev->name);
+		netif_get_mac_address((struct sockaddr *)&ss, dev_net(tap->dev),
+				      tap->dev->name);
 		if (copy_to_user(&ifr->ifr_name, tap->dev->name, IFNAMSIZ) ||
 		    copy_to_user(&ifr->ifr_hwaddr, &ss, sizeof(ifr->ifr_hwaddr)))
 			ret = -EFAULT;
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index f8c5e2fd04df..043e8cbf5cc1 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3186,7 +3186,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 
 	case SIOCGIFHWADDR:
 		/* Get hw address */
-		dev_get_mac_address(&ifr.ifr_hwaddr, net, tun->dev->name);
+		netif_get_mac_address(&ifr.ifr_hwaddr, net, tun->dev->name);
 		if (copy_to_user(argp, &ifr, ifreq_len))
 			ret = -EFAULT;
 		break;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 874952e5ef81..f861edc5f539 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4228,7 +4228,7 @@ int dev_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
 			struct netlink_ext_ack *extack);
 int dev_set_mac_address_user(struct net_device *dev, struct sockaddr_storage *ss,
 			     struct netlink_ext_ack *extack);
-int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name);
+int netif_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name);
 int netif_get_port_parent_id(struct net_device *dev,
 			     struct netdev_phys_item_id *ppid, bool recurse);
 bool netdev_port_same_parent_id(struct net_device *a, struct net_device *b);
diff --git a/net/core/dev.c b/net/core/dev.c
index 7d38d080efe0..0307fa0727aa 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9737,7 +9737,7 @@ int netif_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
 DECLARE_RWSEM(dev_addr_sem);
 
 /* "sa" is a true struct sockaddr with limited "sa_data" member. */
-int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name)
+int netif_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name)
 {
 	size_t size = sizeof(sa->sa_data_min);
 	struct net_device *dev;
@@ -9763,7 +9763,7 @@ int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name)
 	up_read(&dev_addr_sem);
 	return ret;
 }
-EXPORT_SYMBOL(dev_get_mac_address);
+EXPORT_SYMBOL(netif_get_mac_address);
 
 int netif_change_carrier(struct net_device *dev, bool new_carrier)
 {
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 616479e71466..ceb2d63a818a 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -728,7 +728,8 @@ int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr,
 	switch (cmd) {
 	case SIOCGIFHWADDR:
 		dev_load(net, ifr->ifr_name);
-		ret = dev_get_mac_address(&ifr->ifr_hwaddr, net, ifr->ifr_name);
+		ret = netif_get_mac_address(&ifr->ifr_hwaddr, net,
+					    ifr->ifr_name);
 		if (colon)
 			*colon = ':';
 		return ret;
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index ebb5a6a11bb8..c2783323b589 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -256,7 +256,7 @@ static ssize_t name_assign_type_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(name_assign_type);
 
-/* use same locking rules as GIFHWADDR ioctl's (dev_get_mac_address()) */
+/* use same locking rules as GIFHWADDR ioctl's (netif_get_mac_address()) */
 static ssize_t address_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
-- 
2.49.0


