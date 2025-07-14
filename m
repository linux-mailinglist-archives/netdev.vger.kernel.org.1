Return-Path: <netdev+bounces-206866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4866B04A79
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D32B3A94CB
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 22:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C036288C88;
	Mon, 14 Jul 2025 22:19:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A714728727E
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 22:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752531546; cv=none; b=qo/bOt2MSX356UWrykS0EFP63lQCAp4/IyucX+7DQ8fYyeO8wCRROul7TlXjkh1cXlWXop8YEV6goLNKcV7EvIjHJaL16RwL/Z6v6U582lvJa7yHycuWFUZjWMtDFEJ3lyZj7NFtZ7xouoe7fuEk68XuWoFnxn7cHyVs/xX/Afk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752531546; c=relaxed/simple;
	bh=SS04PyxC0p4H1sqVvkb0iWWFC3v8l4LWbsK/8RCtTJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZuWcM+AnrISS/BDdhZTjgWapYNwUzJiwNhvDZVS+cTFUXZc23ioCTdkdd6I8SoM10anrE5R0t4ZB8j4H1LoOXPKQst1yqJi74cWMcweXoGhJj/66ZSCO8eVIhw+zESJVZosyBogKQncPjJLIdfwPGAds/imBmDXlrwXGd2I5EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-236377f00a1so45151435ad.3
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 15:19:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752531543; x=1753136343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7FNSXNwDG9aPRdYYyMLeSY8nXwXu2Xwhi3GoDUyh6g=;
        b=FTEMwQkXacbnC1bB5GluKPwfKsbyFL8SBiYrIMtY8vMJwZTYNrxAiWD16LdqGI+BBB
         uYvr+3QY2AlNCffK/sUavHHZUaxZKALyT4oatDyD1ygS8ceSxNYRPX/6TnxH2XAx4CZU
         HKCBDNvrpK+4KL+NVaqC9ogEkE1y7jsd0ktL8ptiGRmW4jqHrXjaxG4nrit99uSl6CiT
         /JQ+ansiLPwAkiboc2gNGAlXrgB6Oz9hvMC20t+6XN9fUJcy6ZNXANgf1sOWQScETZB2
         S5bMaf1WDqX7oR0WGJDm924IMo/Y2/D1GUB/QLrbE2H9Jw4EoBg/hYz8duY5q0scDU58
         VKpA==
X-Gm-Message-State: AOJu0YweHCg4QLisKy6U43DYdNjgZHyi1mMf7f+AphVR5DybcnFvdxXE
	i/SU+H6lR0WeiZLrv9YBo04eAPXBE/mUJeV4ScbUpvIV3XBkJM+j+6QzsfT8
X-Gm-Gg: ASbGncuXt9XF7oSgyQphvjDtpu33B8Zu2Vl48UhaWRcd92aStOKNkJzOLJQ+MOf/Y3z
	Ldri8PZYWKABD0j7utmHGkNdlFopUMkwv7xJaglrwSDTkJ8tnYez1Wv+U96v3lEq6RXCghaW6By
	iqXej7DT2DUt/N+vrAIubVy/o/UhMu7ZCIIV8fl9wpeYKGaGMp/C2lQbzr1Rzmqan1BVhYrUTBd
	ihZhzcQojgHbLEY5OI4RYQnZtkJjwb20ic4X51WDVjEiGHEK62OCY2R39Ga28Gkinx7D4MjnDhK
	PC2t7WeaZIb8ulsOxNw6Ua1eMlSDCZVA7RIw7cCV6oXMEBg8CKfbhbAyT2AUx5vcGAQCXg4qOvh
	/lJjmj4Vun2u3mz0iIl1rpmDpoI0X5puZhBT/M6Wg0TTPc7XqxY6n0MraR3E=
X-Google-Smtp-Source: AGHT+IFz7lEqiJ1K0XdkRDKCJyt6sD1Zs/TdV2XlXTZ6bQr+M4NVHo0DDXpCiwLZH3Izb9C4mnhh0Q==
X-Received: by 2002:a17:903:2343:b0:235:c973:ba20 with SMTP id d9443c01a7336-23e1b1bf89emr7119905ad.49.1752531543243;
        Mon, 14 Jul 2025 15:19:03 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23de43226c3sm103173555ad.117.2025.07.14.15.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 15:19:02 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v4 4/7] net: s/__dev_set_mtu/__netif_set_mtu/
Date: Mon, 14 Jul 2025 15:18:52 -0700
Message-ID: <20250714221855.3795752-5-sdf@fomichev.me>
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

__netif_set_mtu is used only by bond, so move it into
NETDEV_INTERNAL namespace.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/bonding/bond_main.c |  2 +-
 include/linux/netdevice.h       |  2 +-
 net/core/dev.c                  | 22 +++++++++++++---------
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index d8281c486a44..257333c88710 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2669,7 +2669,7 @@ static int __bond_release_one(struct net_device *bond_dev,
 
 	if (unregister) {
 		netdev_lock_ops(slave_dev);
-		__dev_set_mtu(slave_dev, slave->original_mtu);
+		__netif_set_mtu(slave_dev, slave->original_mtu);
 		netdev_unlock_ops(slave_dev);
 	} else {
 		dev_set_mtu(slave_dev, slave->original_mtu);
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index bae5d80ef6d0..2115050e1d25 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4210,7 +4210,7 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 			       struct netlink_ext_ack *extack);
 int dev_change_net_namespace(struct net_device *dev, struct net *net,
 			     const char *pat);
-int __dev_set_mtu(struct net_device *, int);
+int __netif_set_mtu(struct net_device *dev, int new_mtu);
 int netif_set_mtu(struct net_device *dev, int new_mtu);
 int dev_set_mtu(struct net_device *, int);
 int netif_pre_changeaddr_notify(struct net_device *dev, const char *addr,
diff --git a/net/core/dev.c b/net/core/dev.c
index 95a29ea255e8..750cf055c090 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9565,7 +9565,7 @@ int netif_change_flags(struct net_device *dev, unsigned int flags,
 	return ret;
 }
 
-int __dev_set_mtu(struct net_device *dev, int new_mtu)
+int __netif_set_mtu(struct net_device *dev, int new_mtu)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
 
@@ -9576,7 +9576,7 @@ int __dev_set_mtu(struct net_device *dev, int new_mtu)
 	WRITE_ONCE(dev->mtu, new_mtu);
 	return 0;
 }
-EXPORT_SYMBOL(__dev_set_mtu);
+EXPORT_SYMBOL_NS_GPL(__netif_set_mtu, "NETDEV_INTERNAL");
 
 int dev_validate_mtu(struct net_device *dev, int new_mtu,
 		     struct netlink_ext_ack *extack)
@@ -9595,18 +9595,22 @@ int dev_validate_mtu(struct net_device *dev, int new_mtu,
 }
 
 /**
- *	netif_set_mtu_ext - Change maximum transfer unit
- *	@dev: device
- *	@new_mtu: new transfer unit
- *	@extack: netlink extended ack
+ * netif_set_mtu_ext() - Change maximum transfer unit
+ * @dev: device
+ * @new_mtu: new transfer unit
+ * @extack: netlink extended ack
  *
- *	Change the maximum transfer size of the network device.
+ * Change the maximum transfer size of the network device.
+ *
+ * Return: 0 on success, -errno on failure.
  */
 int netif_set_mtu_ext(struct net_device *dev, int new_mtu,
 		      struct netlink_ext_ack *extack)
 {
 	int err, orig_mtu;
 
+	netdev_ops_assert_locked(dev);
+
 	if (new_mtu == dev->mtu)
 		return 0;
 
@@ -9623,7 +9627,7 @@ int netif_set_mtu_ext(struct net_device *dev, int new_mtu,
 		return err;
 
 	orig_mtu = dev->mtu;
-	err = __dev_set_mtu(dev, new_mtu);
+	err = __netif_set_mtu(dev, new_mtu);
 
 	if (!err) {
 		err = call_netdevice_notifiers_mtu(NETDEV_CHANGEMTU, dev,
@@ -9633,7 +9637,7 @@ int netif_set_mtu_ext(struct net_device *dev, int new_mtu,
 			/* setting mtu back and notifying everyone again,
 			 * so that they have a chance to revert changes.
 			 */
-			__dev_set_mtu(dev, orig_mtu);
+			__netif_set_mtu(dev, orig_mtu);
 			call_netdevice_notifiers_mtu(NETDEV_CHANGEMTU, dev,
 						     new_mtu);
 		}
-- 
2.50.0


