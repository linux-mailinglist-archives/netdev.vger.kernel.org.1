Return-Path: <netdev+bounces-207984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E4BB0931E
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 19:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A4CA601CE
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFC82F7CEC;
	Thu, 17 Jul 2025 17:23:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70162F94AA
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 17:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773019; cv=none; b=HypNSuoQ18WYAzwN0fBTpvpPG7q4AwuePlfRL6WHLYo4SiXsawoMbMg/L6vL11FyLYGyBbnYIFz9bI896JFSZ6fKdy26tB0Q1HlFFgtHfEXujCBIm6Nnvk27zaecVZRBR644k4JO9JLBU1T+wWxD5LrxGWQvaZKfrDjzK1vfFAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773019; c=relaxed/simple;
	bh=hN3C4xGXO57KLGfaiJMzpEugr9T77MGHo9n1gbeWjIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMPb1c+eO9xtS53w/txHGxY6oKzGluVfqefr4syV5ciSy0L4Z0gupg7VM5/54cVHEwh+iZnjvKm+n1LukYfBRSYcTIoYSAyGQuJ9vnbqgt88mzJiVwfi4F+lK+C2KNZvWygT+Tfls1PIqkX+rsl3CTDcfCSseu8Lq2pg97fO8Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so1405963b3a.1
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 10:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752773017; x=1753377817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZskD7+LnjkuSw8XKz4P4zcmEXsmdi3neqtiUYJG1hk=;
        b=UUZ47Bf8iuHTucTNOUu2AqW1vbtFrZbRLK9syV6f1i9dIoDmGZQixvlbfS2N7YDpTd
         0q4L2ic1f1wxNLoltzb9WW4KMNWFLyQ14zlI9ZQa8SMlR4QCdjhH+tygtXXuLsCIkvo+
         ENJPtryKOoGrGXvn5Op64/XgZDylow2XYUqJ+6mxdpX33xWasYrPnCBjb8W1upBiTqir
         sffLICSw0cd5tAgt9FwWdjwMZ8uipwn91Fsd37E3gcKVDsgPMkWoMRQy+rLHp/aqauYT
         vgnbd9+I7i7Z6/I2MbUcl/T+mXVYDs+5pcO4/q3hDTm8eWMmkeiSK0AubBHsN24U3BMU
         uP6Q==
X-Gm-Message-State: AOJu0YzAn2ksEKeQrEPlWtD7h9/4jTZXRZ/vpKeMKLiJCPUxuXX7WAM9
	i2BkEt5XWCj5IBh3aC01gu9soFcraWzQEoUlL/7DYikZvpQRlEocFSPKXDxU
X-Gm-Gg: ASbGncswdqeqDhXQDPquf+KpZ8B8iR+sE7AyVJ+X9Y+3uoBoInZ/UDbkfd0IwZvG+yG
	fxBIRb2MY0Dm0Q+OWKevX54tiY05d8lStrP4gaIeWq89z26f2c10cjcybvjIPwyGwDVyjAi15RO
	FJ9qxzUcTOk4iYU4Qze7BU8Jb9sHgtjAydJVP8Z78pbP0Ek6+gYGDBN+woGP0mE08E0WcdRDtwu
	anXR1cYfOwAEFL6t+1EwJBtP/Djy75SOnJNyIIVc8kvqELGOd+gKSreC/N+WLdmF+PkPjHn+9Ia
	hrkEeUOnxvz5DIqOX4x33aBWxMH6hrbqAdfygd1wI6ic6Y6v+ESVS2ZLCgp+s9H8H5lps2An7vj
	FVvV3k9JOc0uxNCfVlQzX9jrPxHAHRpLRPRU0KjVxpeiyUNXgi+pALgwhddA=
X-Google-Smtp-Source: AGHT+IFXqU2K4cePzLF0Sn4MpexbISgYG87UtNQcHT1J61sFwc8MdkgaoOstSlBhJgsK4hKl7qvu+w==
X-Received: by 2002:a05:6a21:695:b0:225:9ac1:7c6b with SMTP id adf61e73a8af0-2391a2d8cf3mr986487637.4.1752773016513;
        Thu, 17 Jul 2025 10:23:36 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b3bbe577853sm16222274a12.21.2025.07.17.10.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 10:23:36 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v5 2/7] net: s/dev_get_mac_address/netif_get_mac_address/
Date: Thu, 17 Jul 2025 10:23:28 -0700
Message-ID: <20250717172333.1288349-3-sdf@fomichev.me>
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

netif_get_mac_address is used only by tun/tap, so move it into
NETDEV_INTERNAL namespace.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/tap.c         | 5 +++--
 drivers/net/tun.c         | 3 ++-
 include/linux/netdevice.h | 2 +-
 net/core/dev.c            | 4 ++--
 net/core/dev_ioctl.c      | 3 ++-
 net/core/net-sysfs.c      | 2 +-
 6 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index d82eb7276a8b..1197f245e873 100644
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
@@ -1282,3 +1282,4 @@ MODULE_DESCRIPTION("Common library for drivers implementing the TAP interface");
 MODULE_AUTHOR("Arnd Bergmann <arnd@arndb.de>");
 MODULE_AUTHOR("Sainath Grandhi <sainath.grandhi@intel.com>");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("NETDEV_INTERNAL");
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 49bcd12a4ac8..4568fe4c7e58 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3225,7 +3225,7 @@ static long __tun_chr_ioctl(struct file *file, unsigned int cmd,
 
 	case SIOCGIFHWADDR:
 		/* Get hw address */
-		dev_get_mac_address(&ifr.ifr_hwaddr, net, tun->dev->name);
+		netif_get_mac_address(&ifr.ifr_hwaddr, net, tun->dev->name);
 		if (copy_to_user(argp, &ifr, ifreq_len))
 			ret = -EFAULT;
 		break;
@@ -3734,3 +3734,4 @@ MODULE_AUTHOR(DRV_COPYRIGHT);
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_MISCDEV(TUN_MINOR);
 MODULE_ALIAS("devname:net/tun");
+MODULE_IMPORT_NS("NETDEV_INTERNAL");
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index c6ba4ea66039..b3a48934b4cb 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4222,7 +4222,7 @@ int dev_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
 			struct netlink_ext_ack *extack);
 int dev_set_mac_address_user(struct net_device *dev, struct sockaddr_storage *ss,
 			     struct netlink_ext_ack *extack);
-int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name);
+int netif_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name);
 int netif_get_port_parent_id(struct net_device *dev,
 			     struct netdev_phys_item_id *ppid, bool recurse);
 bool netdev_port_same_parent_id(struct net_device *a, struct net_device *b);
diff --git a/net/core/dev.c b/net/core/dev.c
index a42d5c496c08..71597252313c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9761,7 +9761,7 @@ int netif_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
 DECLARE_RWSEM(dev_addr_sem);
 
 /* "sa" is a true struct sockaddr with limited "sa_data" member. */
-int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name)
+int netif_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name)
 {
 	size_t size = sizeof(sa->sa_data_min);
 	struct net_device *dev;
@@ -9787,7 +9787,7 @@ int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name)
 	up_read(&dev_addr_sem);
 	return ret;
 }
-EXPORT_SYMBOL(dev_get_mac_address);
+EXPORT_SYMBOL_NS_GPL(netif_get_mac_address, "NETDEV_INTERNAL");
 
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
index f7a6cc7aea79..e41ad1890e49 100644
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
2.50.1


