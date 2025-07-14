Return-Path: <netdev+bounces-206865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD66FB04A78
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4C463B9542
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 22:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080EC28850C;
	Mon, 14 Jul 2025 22:19:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0379C280327
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 22:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752531544; cv=none; b=EN7xjRiujVcv0dyhHLzq8ApKjt5uVzJIpmE3RAOMtVoNzIhpg7ZfW/kkDb/eaT05ioI2DCL0INBuVkoq7z4ZMtsS39vHcXThWIw05aN+a2wor20OIJ+AWPqIrBJk9BFbzFptC8Tgewrb4QX8kT5gmkvhmmAzvHKw987P3+fiNU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752531544; c=relaxed/simple;
	bh=UND44REaw8fNLqc07BVPF45R4pIAFqGAoq99ARRNyJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qu42vJ257daUxDXqHonE0f+gZDkBQZnn6ewa1EtXevvARxcaT0Fpyh3V81qCocvL7+5sR/2v7r0ZObsSNwUQjCqT8gh33Jl1+msDBTDu1FWZYltUTgDnohHtEHksrZIBSJYKzswxIHNMEorxMHsx38SRU2DzTWcr/nOylLTU+tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b26f5f47ba1so3868012a12.1
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 15:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752531542; x=1753136342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FhxI1rtjfNtCnSACvA50pe6MyH6p7p1fjad1sVZ/Grk=;
        b=X6daEcMhYGo0nBuiCexZX24ysrZxeeomE3nA3FIFHWyzHhLveinNE6/KNs971RQ0WF
         b9sZ9Pbx9FFRm4TELlagQU2NRohW8FfVW9bga3jrReCPjp7j9X7TtEFyS2wFUSvqOdjF
         bhxqgSoO4xre/zUVYqQwe3vD7LAOIgFEU6+usOJ1F3UKqT8EYqOiWhLfPw2Oy3UQQ3hE
         LIm++8pV4bnL2Gpb8bAJHj3kIGUUwZbv496L2JcqEwuMQt/mK8VVEl7Sc1GNYT4bbGM9
         8M+9x6cg/49qumMr1Vj1jChYPY5AkXypS3cP6bSO4NBQzpEgp6a1iM8/z4LWk4gNgho8
         1b7A==
X-Gm-Message-State: AOJu0YyYkcZIHsxyfNrgDNWEwOSPENeLzCKZmLDqja2grXCdjCSRP4IF
	rvwuE4V9Qcj94rFY+OePVbdA9/7I/Ud0zgeVyhst7cQQ+/Wkm86YxnZ92mro
X-Gm-Gg: ASbGncvwQSWnA67gx9ARVCd8FbU6a61Z5wDlvbFn7x9KwI1iHs2VRQ7lpjVu97BXHh+
	yGzJZn1QDWYF7f4fRcnK3IsAE9jFJnorefRUmp5vRm/q8jVAPUCrv1N+llGivjqByxCsz+GszR7
	mgka3EcEPQOxgQgzPzOsj8oX0sHLowITPkMHrLdEFtfCdSnJK3efRAMNifs8m4QVo+EDRhd0j+I
	H2XT8aV/xCA8pga2witnChfXOdJb/wJ/K5bRkcTf5iTNUluYe/b2jd0pE/aum2ch0wukPppcyk0
	D95GrPEaTeYjHFn559dJQs9vgLWFupOCwtjLwllQvpeB5KQcUm/5zYri+WrZaQS28WvMaSO4X25
	s5mYBmSJUthlCdb0JngkTlPet3HiPFWF7nljtbdSFrrQjXNLF4+8LMn+JOlI=
X-Google-Smtp-Source: AGHT+IFLmq6ak/pKmSY+5uQ0VMtkYiCVBv4Va7lTj/hZ+xrGwhUyfiJm0joKvX9sJ+0BqrgSiI37Sg==
X-Received: by 2002:a17:90b:3a08:b0:313:283e:e881 with SMTP id 98e67ed59e1d1-31c4ca84a5fmr25222211a91.11.1752531541882;
        Mon, 14 Jul 2025 15:19:01 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23de42ad9efsm103693785ad.58.2025.07.14.15.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 15:19:01 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v4 3/7] net: s/dev_pre_changeaddr_notify/netif_pre_changeaddr_notify/
Date: Mon, 14 Jul 2025 15:18:51 -0700
Message-ID: <20250714221855.3795752-4-sdf@fomichev.me>
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

netif_pre_changeaddr_notify is used only by ipvlan/bond, so move it into
NETDEV_INTERNAL namespace.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/bonding/bond_main.c  |  3 ++-
 drivers/net/ipvlan/ipvlan_main.c |  7 ++++---
 include/linux/netdevice.h        |  4 ++--
 net/bridge/br.c                  |  7 ++++---
 net/bridge/br_if.c               |  3 ++-
 net/core/dev.c                   | 18 ++++++++++--------
 net/core/dev_addr_lists.c        |  2 +-
 7 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 17c7542be6a5..d8281c486a44 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1040,7 +1040,7 @@ static int bond_set_dev_addr(struct net_device *bond_dev,
 
 	slave_dbg(bond_dev, slave_dev, "bond_dev=%p slave_dev=%p slave_dev->addr_len=%d\n",
 		  bond_dev, slave_dev, slave_dev->addr_len);
-	err = dev_pre_changeaddr_notify(bond_dev, slave_dev->dev_addr, NULL);
+	err = netif_pre_changeaddr_notify(bond_dev, slave_dev->dev_addr, NULL);
 	if (err)
 		return err;
 
@@ -6743,3 +6743,4 @@ module_exit(bonding_exit);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION(DRV_DESCRIPTION);
 MODULE_AUTHOR("Thomas Davis, tadavis@lbl.gov and many others");
+MODULE_IMPORT_NS("NETDEV_INTERNAL");
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 0ed2fd833a5d..660f3db11766 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -784,9 +784,9 @@ static int ipvlan_device_event(struct notifier_block *unused,
 	case NETDEV_PRE_CHANGEADDR:
 		prechaddr_info = ptr;
 		list_for_each_entry(ipvlan, &port->ipvlans, pnode) {
-			err = dev_pre_changeaddr_notify(ipvlan->dev,
-						    prechaddr_info->dev_addr,
-						    extack);
+			err = netif_pre_changeaddr_notify(ipvlan->dev,
+							  prechaddr_info->dev_addr,
+							  extack);
 			if (err)
 				return notifier_from_errno(err);
 		}
@@ -1094,3 +1094,4 @@ MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Mahesh Bandewar <maheshb@google.com>");
 MODULE_DESCRIPTION("Driver for L3 (IPv6/IPv4) based VLANs");
 MODULE_ALIAS_RTNL_LINK("ipvlan");
+MODULE_IMPORT_NS("NETDEV_INTERNAL");
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b4fcf72e4b16..bae5d80ef6d0 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4213,8 +4213,8 @@ int dev_change_net_namespace(struct net_device *dev, struct net *net,
 int __dev_set_mtu(struct net_device *, int);
 int netif_set_mtu(struct net_device *dev, int new_mtu);
 int dev_set_mtu(struct net_device *, int);
-int dev_pre_changeaddr_notify(struct net_device *dev, const char *addr,
-			      struct netlink_ext_ack *extack);
+int netif_pre_changeaddr_notify(struct net_device *dev, const char *addr,
+				struct netlink_ext_ack *extack);
 int netif_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
 			  struct netlink_ext_ack *extack);
 int dev_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
diff --git a/net/bridge/br.c b/net/bridge/br.c
index 0adeafe11a36..1885d0c315f0 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -74,9 +74,9 @@ static int br_device_event(struct notifier_block *unused, unsigned long event, v
 		if (br->dev->addr_assign_type == NET_ADDR_SET)
 			break;
 		prechaddr_info = ptr;
-		err = dev_pre_changeaddr_notify(br->dev,
-						prechaddr_info->dev_addr,
-						extack);
+		err = netif_pre_changeaddr_notify(br->dev,
+						  prechaddr_info->dev_addr,
+						  extack);
 		if (err)
 			return notifier_from_errno(err);
 		break;
@@ -484,3 +484,4 @@ MODULE_LICENSE("GPL");
 MODULE_VERSION(BR_VERSION);
 MODULE_ALIAS_RTNL_LINK("bridge");
 MODULE_DESCRIPTION("Ethernet bridge driver");
+MODULE_IMPORT_NS("NETDEV_INTERNAL");
diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index 2450690f98cf..98c5b9c3145f 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -668,7 +668,8 @@ int br_add_if(struct net_bridge *br, struct net_device *dev,
 		/* Ask for permission to use this MAC address now, even if we
 		 * don't end up choosing it below.
 		 */
-		err = dev_pre_changeaddr_notify(br->dev, dev->dev_addr, extack);
+		err = netif_pre_changeaddr_notify(br->dev, dev->dev_addr,
+						  extack);
 		if (err)
 			goto err6;
 	}
diff --git a/net/core/dev.c b/net/core/dev.c
index a0eb0ed3a1bd..95a29ea255e8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9687,13 +9687,15 @@ void netif_set_group(struct net_device *dev, int new_group)
 }
 
 /**
- *	dev_pre_changeaddr_notify - Call NETDEV_PRE_CHANGEADDR.
- *	@dev: device
- *	@addr: new address
- *	@extack: netlink extended ack
+ * netif_pre_changeaddr_notify() - Call NETDEV_PRE_CHANGEADDR.
+ * @dev: device
+ * @addr: new address
+ * @extack: netlink extended ack
+ *
+ * Return: 0 on success, -errno on failure.
  */
-int dev_pre_changeaddr_notify(struct net_device *dev, const char *addr,
-			      struct netlink_ext_ack *extack)
+int netif_pre_changeaddr_notify(struct net_device *dev, const char *addr,
+				struct netlink_ext_ack *extack)
 {
 	struct netdev_notifier_pre_changeaddr_info info = {
 		.info.dev = dev,
@@ -9705,7 +9707,7 @@ int dev_pre_changeaddr_notify(struct net_device *dev, const char *addr,
 	rc = call_netdevice_notifiers_info(NETDEV_PRE_CHANGEADDR, &info.info);
 	return notifier_to_errno(rc);
 }
-EXPORT_SYMBOL(dev_pre_changeaddr_notify);
+EXPORT_SYMBOL_NS_GPL(netif_pre_changeaddr_notify, "NETDEV_INTERNAL");
 
 int netif_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
 			  struct netlink_ext_ack *extack)
@@ -9719,7 +9721,7 @@ int netif_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
 		return -EINVAL;
 	if (!netif_device_present(dev))
 		return -ENODEV;
-	err = dev_pre_changeaddr_notify(dev, ss->__data, extack);
+	err = netif_pre_changeaddr_notify(dev, ss->__data, extack);
 	if (err)
 		return err;
 	if (memcmp(dev->dev_addr, ss->__data, dev->addr_len)) {
diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
index 90716bd736f3..76c91f224886 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -603,7 +603,7 @@ int dev_addr_add(struct net_device *dev, const unsigned char *addr,
 
 	ASSERT_RTNL();
 
-	err = dev_pre_changeaddr_notify(dev, addr, NULL);
+	err = netif_pre_changeaddr_notify(dev, addr, NULL);
 	if (err)
 		return err;
 	err = __hw_addr_add(&dev->dev_addrs, addr, dev->addr_len, addr_type);
-- 
2.50.0


