Return-Path: <netdev+bounces-205159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CE2AFDA07
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 23:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A18EA4E6A3D
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 21:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C3D248F68;
	Tue,  8 Jul 2025 21:38:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B258F248873
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 21:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752010721; cv=none; b=Av+70uGqu142coZGtR+atYNwgwbR9h6MNixDb1rBXJKnUFS3lrjGOpnrdDUJ62VHIn61TB3DtUEz+RAu1I39z79TcGldQBiONO0YMMrhtNxpuinFzCskYeLb+2Dk3WGpsTlM/RxDe9tQyEioYcHU0Jp5e85tqbq2ZAOcRUEeOTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752010721; c=relaxed/simple;
	bh=n1hMB4IWU44D4ySfWUQN9k3XstH/m9f3Pqs5ZrBVsQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NdF/ho1MJ/ozwnef+56fzcy6DS3TFWHVjUWJbnEpHaHU9tYtWBlzxPPF4ooi7vtZW5x8gulPCIiFfihEBrJoTp+rF0iemoaGymZYBwld5+V096s84FamuuP8/PNBdw3E5thz9lOJoiGbbgZfJE+vUHUT4JjO48BG+Q6ll+uAwTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b3182c6d03bso5736061a12.0
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 14:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752010718; x=1752615518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEy2AR6QKX0Rbi8sc8tu1BJnR7GN2dpcMD2hJqQ5yYY=;
        b=JBzBw+o/QE8PW1hUXjC9utppJWEHrFAowUL8s0R8BMn9KRT8IBb68DIBCqiqio724Z
         B8bRVofJhvbf7etrTZ/UsNRyG2i+PCWuNPoAhYh/Hw017VXNkRMeMmmBOfn90zjd44a2
         MHuBCMIvy+74nW2cED4xj99NJjNILOLYu0sEvxn5CNsLnlp4uKarVGIlhFp6FKYpowEv
         FASDMskdgd5eCqIydts8PTOCiR2pThVblZvNQwRodFMvYXZ1ZPsyp0t2YYrCv+Axlfmu
         RxnD4dT4gIHhNQh46exal8PCOfDq9oG4/+6pHZ+r60FSTsINc/A2M1CdjDIdozKx5CvJ
         N9Qg==
X-Gm-Message-State: AOJu0YyWhG5duz20BuJ7NEro6wpWGA0XsVl/4vSFcmLBy9bhPPloWTUu
	vxomGHuIHjaxu7pGEPhg131JZjzymgKAZwd8nlFv/kjJTWI1mwslxpNcM3nT
X-Gm-Gg: ASbGncst8uGjK+OEVkgnrWSWVJrj2O/jhsASFA67S5/ePhpROhygpUUCZER76BtxYZE
	FYIvl2oiv3oqj6onB5eQKrZZbJcHfkhnsH84EuN5gVqQufyvMdpxFNobWJ7uACVz/UPz64hAPNc
	wiajtmId/eYJPPcMDige4qbjrP6MROuTIgdt0/t8Owncu/8RqXJXQsJjJ4n8FZ5EQ79tRoScgKU
	c3KE+gH4rEWKDJ3jlJNI642Qaq7q3sBdUzziMPTQmdc903lejiu1rUH2Xm9ocbJtPaCOq+n7PRF
	kq5L191cVWqN6ZZ5ZKFOBxl2FUQpD3AOERNegjFjuC+jl2H88XcPPCDMfO1szvJ9YrYBN09NkgW
	A0PVgI2Xcgzu/FEf9fWrKzKI=
X-Google-Smtp-Source: AGHT+IEeUIeQTK3Zh3YO5K4LEsb7JSNreSsWpENU7Jdwk0e5R2BEkS4OJWO7r+mW6XcoF7QacFaE8Q==
X-Received: by 2002:a17:90b:3d06:b0:312:db8f:9a09 with SMTP id 98e67ed59e1d1-31c2fd00c80mr251880a91.14.1752010718592;
        Tue, 08 Jul 2025 14:38:38 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-31c300b88f8sm34330a91.32.2025.07.08.14.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 14:38:38 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v3 5/8] net: s/__dev_set_mtu/__netif_set_mtu/
Date: Tue,  8 Jul 2025 14:38:26 -0700
Message-ID: <20250708213829.875226-6-sdf@fomichev.me>
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

__netif_set_mtu is used only by bond, so move it into
NETDEV_INTERNAL namespace.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/bonding/bond_main.c |  2 +-
 include/linux/netdevice.h       |  2 +-
 net/core/dev.c                  | 20 +++++++++++---------
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 03413570520d..8aed8af88bed 100644
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
index 85c0dec0177e..454cf4bb513b 100644
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
index 3e2aec843645..3cf882a16805 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9567,7 +9567,7 @@ int netif_change_flags(struct net_device *dev, unsigned int flags,
 	return ret;
 }
 
-int __dev_set_mtu(struct net_device *dev, int new_mtu)
+int __netif_set_mtu(struct net_device *dev, int new_mtu)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
 
@@ -9578,7 +9578,7 @@ int __dev_set_mtu(struct net_device *dev, int new_mtu)
 	WRITE_ONCE(dev->mtu, new_mtu);
 	return 0;
 }
-EXPORT_SYMBOL(__dev_set_mtu);
+EXPORT_SYMBOL_NS_GPL(__netif_set_mtu, "NETDEV_INTERNAL");
 
 int dev_validate_mtu(struct net_device *dev, int new_mtu,
 		     struct netlink_ext_ack *extack)
@@ -9597,18 +9597,20 @@ int dev_validate_mtu(struct net_device *dev, int new_mtu,
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
  */
 int netif_set_mtu_ext(struct net_device *dev, int new_mtu,
 		      struct netlink_ext_ack *extack)
 {
 	int err, orig_mtu;
 
+	netdev_assert_locked_or_invisible(dev);
+
 	if (new_mtu == dev->mtu)
 		return 0;
 
@@ -9625,7 +9627,7 @@ int netif_set_mtu_ext(struct net_device *dev, int new_mtu,
 		return err;
 
 	orig_mtu = dev->mtu;
-	err = __dev_set_mtu(dev, new_mtu);
+	err = __netif_set_mtu(dev, new_mtu);
 
 	if (!err) {
 		err = call_netdevice_notifiers_mtu(NETDEV_CHANGEMTU, dev,
@@ -9635,7 +9637,7 @@ int netif_set_mtu_ext(struct net_device *dev, int new_mtu,
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


