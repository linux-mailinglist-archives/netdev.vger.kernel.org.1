Return-Path: <netdev+bounces-206864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70301B04A77
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8A54A2117
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 22:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1772877EB;
	Mon, 14 Jul 2025 22:19:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA865277CA3
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 22:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752531543; cv=none; b=LL7VnHfKhQhXHiafwGsFpUiL+nUnnfUTEjfDHD3MNbRtMXdTFx6OfKEQJgB/Wkg/YvDwTG4db03JwL6F73BRpTCntXAjNqqGwMK/6H2IUCwGoAGDxTuz8G8LvY+magvVEws7OHzhvxXmMdO2ePs62HG7SiSLqnxaxkg2zSQUFTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752531543; c=relaxed/simple;
	bh=TDJoIoWdtwAlM8ihUczm9ltNdn1y2YBWmWEJQsgynYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMWnwkA3aJVpbDZx/2Z3n+zwJICLDVH1GuKhnCSSQCOW9XNw1ldMzAleSc1FSwI9m54+1t5ljnYFx//I/o2/BbcVZJcu/6ZECYAHEdQfOwbHAv3MZbkVE9kf68ke9p2baVXp9Ix5G2qcP5nPB0hs2n2iP5dQoobjHtuTNhucMns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-237311f5a54so41424745ad.2
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 15:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752531540; x=1753136340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=it81M9u+kCEh07rVGoaDRPSKp5QH8IvU09JKClmVyyk=;
        b=vfjnYSMSxKjtfRI+6Rn/WW7RXngbVbVX25263WnO7W3BCcMQJZ4vLXbmOEXJIOpBm5
         5IvbOzmn8imuE5QiClFj11BXQPD8dp8asaoc7tG3nc+niJUoe5D6zPADaNtc86oGzCFx
         5m31zFXeYM2Bjh0DiFrrsGfGwpyuipjBvo6A2SKx+dN92zjCTon3vRD5UUE6LxYtc2h6
         0Rt0Z5dgU7p+9yTb2DckQqmYYGaLyRu75w8immxDBRgnkfpVnlwRUR92nSLBU8ekZ0Km
         9yJJ70cqIroRuRHF2QCNiFW+nbRsMIbTZcIVFNd9blpXm7yz9/wHEWLcx0zwx/HPg9rD
         tXoQ==
X-Gm-Message-State: AOJu0YxDoxj1TZkq8rm5PszG4uqk39/OJdZQBvuPqaSnCX3Kkys/ALpE
	f8UgK0NPaeR9ImrKDg0YY4ihhIMPT1Qo/vGvVwDB9Q5fOB88btf+5/AAr1Qi
X-Gm-Gg: ASbGncvTdYmWdtnD3jA6hKMtfqMI9JrEHnsy2Xuu2i9QEgV6LyqhrEoz+EdvlZMvvDO
	S2C1xxR0kOOq82PaJgVyC8B3gMzo9mISR7xF8mgPf+oR5BxgXLA8XF35pZnjY9wtH+w5iulLwml
	Rn5xvyGhYJxRxPBmC4idpzPLNu2Wx3Hdc+VzIj3A6JeDCeZDrSX90NQ2LXQI6v/GT5mKAdub2H+
	ZQG5tVj/dXOPNM9SRizVLELNI3A27bO6deiC8UUWW8FGIN7sbCHbogkxJtr9z7Cpqec3JL0JQG/
	D9bhmda/iqzj3UsxK3TFOOARCpXUUeMogvjeMLxkuO6VsXUHk+HNSpeXj72qDqebxFE+GMcPXxG
	p4S1iVzX6WlSEdsd5H+SiRH6Qhw4pZvW1g6z1nlRw/86rdKBIk5OYXUM/l7Y=
X-Google-Smtp-Source: AGHT+IH7JHPAHI+K/7GHArVqByeDZvq8T5ldeAl6jdYH1Hr3VTxoGC9hAvM8bESAapPqB3iiv8ot6A==
X-Received: by 2002:a17:902:ce81:b0:234:ba37:879e with SMTP id d9443c01a7336-23dee28f3dfmr240214785ad.38.1752531540438;
        Mon, 14 Jul 2025 15:19:00 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23de435b7b0sm97032505ad.223.2025.07.14.15.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 15:18:59 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v4 2/7] net: s/dev_get_mac_address/netif_get_mac_address/
Date: Mon, 14 Jul 2025 15:18:50 -0700
Message-ID: <20250714221855.3795752-3-sdf@fomichev.me>
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
index a8a275fb05c3..b4fcf72e4b16 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4221,7 +4221,7 @@ int dev_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
 			struct netlink_ext_ack *extack);
 int dev_set_mac_address_user(struct net_device *dev, struct sockaddr_storage *ss,
 			     struct netlink_ext_ack *extack);
-int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name);
+int netif_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name);
 int netif_get_port_parent_id(struct net_device *dev,
 			     struct netdev_phys_item_id *ppid, bool recurse);
 bool netdev_port_same_parent_id(struct net_device *a, struct net_device *b);
diff --git a/net/core/dev.c b/net/core/dev.c
index 3567cd09920e..a0eb0ed3a1bd 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9736,7 +9736,7 @@ int netif_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
 DECLARE_RWSEM(dev_addr_sem);
 
 /* "sa" is a true struct sockaddr with limited "sa_data" member. */
-int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name)
+int netif_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name)
 {
 	size_t size = sizeof(sa->sa_data_min);
 	struct net_device *dev;
@@ -9762,7 +9762,7 @@ int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name)
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
2.50.0


