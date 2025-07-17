Return-Path: <netdev+bounces-207986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2F1B09320
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 19:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 552D7A61046
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D362FE313;
	Thu, 17 Jul 2025 17:23:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985D02FE327
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 17:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752773021; cv=none; b=fWCPax3oiMYFVWMc4FT6+DTxbOU5iRxdtK9K7o61K8HnqtPNCLYdw8stiTZd3muQpuR090+JqIDNVS+5ppYy1lMEPUxA/8kja5Rw/N7NCY17bSJXfNrO7H/8j4t3+LxYocgb6Eaybm7cvrfHf8/PSXv54pJM2iXABL59R1ASLZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752773021; c=relaxed/simple;
	bh=SptXzlops36ItKi3UYcGVHIXMlPU5fyJKChoGVV6Z14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WImbcnAoaVrOK8KmRkUKFVVTAFXo3wADDVr7HXJ1ygcLkSpTh7rjTg3lu6QM6KLkweD9FF7kULQFmdLT+PXwzwA2OT0AZMsdlUw5L5hpsY91m4ZhIogU8PPOW4UY/SyzaEIrSE9Re6igqPlQgRCGteSrCKF1O2elvgEW5de/r8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-749248d06faso1149439b3a.2
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 10:23:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752773019; x=1753377819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mx5Y270VTgxFTfV1Q4IOr3jreEb83Q0BoJzXob0xpnM=;
        b=BdLbyaiTREUSAYbcv/lHcn/LfRn1EGcNOu8AfP8lD6YuS8ce/9Ox4JLaGxN5vJ9ObK
         7VrSq9RlEaOBf/o/A6apXlah0TBOvJKhafjcl9jVU7pPUd5w9CMV1d1JAB8O44YaCuai
         qMVmg7lRTsz7b2JbLrm450E27VmooNllZRwyFvNM8hyx4tUnK2IpMd+GPQ2CdMSYNuGl
         W4UCKQMDhQWTRnQqtGNF4zlXxqsiRCaoDfRNDMYoDhIfYWSyTDwOtfAbhP1clQ1X4d8l
         /NzZP8Jsk2xwvPZyB+MAVz7xPSLb9ibecnSNAG5LPDtrFWVMsoLlzhZBsi04Xpjsuujo
         KDsQ==
X-Gm-Message-State: AOJu0YyTzpZ2f8NzzVSlOJ99IKBKGP8i+b+qtq6/p/S08h1rMFILvV/K
	v1nwQHnn9rRD98HRfwqJp19BOJnPg+xykpwzz8Q3WMLY58dhId34AlqaT9dv
X-Gm-Gg: ASbGncsn4By6POb4RumHdhfUTMvCIO4jn9np9b9xWf2DFf6X7RdTGAMm2Yjuz2RgFgj
	g1NLfOne9BCe7/pOonlVRaOFpUOm5FAI67eCHYnj4HFat0TmljG3RHH2GVezmbyEykyIj0DxtsX
	J7E143G0TYLcMmyyNu5qJRGPsFXuDdGpZadWHfFCNvfbhrz3S5NgpcrOAgL17FPaMPnjU2+oduO
	wpaD04rwHzM0AoH1AmBmn+62Ir4hBaqj4w0Pa1QKRk/R3swcmvTIp434S3OA258gOM9MhDSB2Zc
	X0BedXo9tFngsUsulErTwNiFg/tb4IV5jORL3adRz/q2BLCyEDN6/Dgs+d2ItRIj2MIxhkcbM2O
	xIVt6ej4+mCGq5nm5gBxMUDUYvr+eT8WlObaeJIiVTCxVqFMY9cAlXJS1EBU=
X-Google-Smtp-Source: AGHT+IHrM8FcJKsOH550FzsbZVaEeN5O5bwLriuCRlwizThd2ESfdJHiPyZUTzZgdqrufy2aEWGn+w==
X-Received: by 2002:a05:6a00:240e:b0:749:464a:a77b with SMTP id d2e1a72fcca58-7584af4ad34mr5177281b3a.18.1752773018530;
        Thu, 17 Jul 2025 10:23:38 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74eb9f46a67sm15758808b3a.110.2025.07.17.10.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 10:23:38 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v5 4/7] net: s/__dev_set_mtu/__netif_set_mtu/
Date: Thu, 17 Jul 2025 10:23:30 -0700
Message-ID: <20250717172333.1288349-5-sdf@fomichev.me>
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
index 55c5cd9d1929..8978fbfbd644 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4211,7 +4211,7 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 			       struct netlink_ext_ack *extack);
 int dev_change_net_namespace(struct net_device *dev, struct net *net,
 			     const char *pat);
-int __dev_set_mtu(struct net_device *, int);
+int __netif_set_mtu(struct net_device *dev, int new_mtu);
 int netif_set_mtu(struct net_device *dev, int new_mtu);
 int dev_set_mtu(struct net_device *, int);
 int netif_pre_changeaddr_notify(struct net_device *dev, const char *addr,
diff --git a/net/core/dev.c b/net/core/dev.c
index 09851f042b86..ac8bca20a19a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -9590,7 +9590,7 @@ int netif_change_flags(struct net_device *dev, unsigned int flags,
 	return ret;
 }
 
-int __dev_set_mtu(struct net_device *dev, int new_mtu)
+int __netif_set_mtu(struct net_device *dev, int new_mtu)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
 
@@ -9601,7 +9601,7 @@ int __dev_set_mtu(struct net_device *dev, int new_mtu)
 	WRITE_ONCE(dev->mtu, new_mtu);
 	return 0;
 }
-EXPORT_SYMBOL(__dev_set_mtu);
+EXPORT_SYMBOL_NS_GPL(__netif_set_mtu, "NETDEV_INTERNAL");
 
 int dev_validate_mtu(struct net_device *dev, int new_mtu,
 		     struct netlink_ext_ack *extack)
@@ -9620,18 +9620,22 @@ int dev_validate_mtu(struct net_device *dev, int new_mtu,
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
 
@@ -9648,7 +9652,7 @@ int netif_set_mtu_ext(struct net_device *dev, int new_mtu,
 		return err;
 
 	orig_mtu = dev->mtu;
-	err = __dev_set_mtu(dev, new_mtu);
+	err = __netif_set_mtu(dev, new_mtu);
 
 	if (!err) {
 		err = call_netdevice_notifiers_mtu(NETDEV_CHANGEMTU, dev,
@@ -9658,7 +9662,7 @@ int netif_set_mtu_ext(struct net_device *dev, int new_mtu,
 			/* setting mtu back and notifying everyone again,
 			 * so that they have a chance to revert changes.
 			 */
-			__dev_set_mtu(dev, orig_mtu);
+			__netif_set_mtu(dev, orig_mtu);
 			call_netdevice_notifiers_mtu(NETDEV_CHANGEMTU, dev,
 						     new_mtu);
 		}
-- 
2.50.1


