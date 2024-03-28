Return-Path: <netdev+bounces-82865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C5C89005B
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 14:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04088B2109B
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 13:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8037EEFD;
	Thu, 28 Mar 2024 13:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNkPBCNH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA7C7FBCD
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711632965; cv=none; b=RPaxMgcImc6HYt3s2/Kao2vrRTp0VuzR7GkCOvmDav4I55+2NGPLKUNypwZb+XZPS7YIwRHe8Ep0+QGpP0BHF+flKFSOAiqHTNnyqsnKjvDMCJhT5rgxkZQfm+y81mYNEZ0C4NKs2cLLypw3AKfCkPYthGAKX9p0F8ryQGxwssE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711632965; c=relaxed/simple;
	bh=afSWyp4SGOlayKC4baG6Dl/jStlqgHhaSrmYGHz5ZK8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r6R6sVOCHboqw/eoAC5BKOloxp+rXIhOdefq/RYDSB9llvvCE8psk26Ag+VPmihz8gx44EJNwKq41rvVt6iWOI1wM3osylrNa230I0oCdUu/mK58czrTnAXX4C9IX8CgVhHfY8w54somjkdstvxaN6GNhTrqG/U1Xk+NkJ6STzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNkPBCNH; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513d492c3cdso288656e87.0
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 06:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711632961; x=1712237761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yk1JFmB+78Xg7br165/GKmGhERp7Awzg64hnVY/1y9I=;
        b=XNkPBCNHV5m1VIiD6m5FCx9ps+9aFhTEBJ1141zpr+ZnAPB6QI+Y/ss06acJmmHFsz
         b4vdSEJcNv3BZZvOJl7GeqJazFTOv2ELEv1cogIDwtnX6f+ZwpYTxmv8+lEKMyjCUDRd
         DB4LnicH0XQQRmKIsJ7iekyAqZGWHUa0fuHGDWnlL8btPoZ0Cl9QqE16anHvRyyovevN
         6ltvlY41l6r5IpNtXU7BDvNeT78O8BMrdse5uW2/fVSxcWv5KO5vKt5tBUzmHVH/UbPC
         lVnQRCOqzGuIlvWk584hUTgVDuiwKMh7smppdTbdM+y5H8s4E3PT+C+xGL7X385jqgoe
         hfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711632961; x=1712237761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yk1JFmB+78Xg7br165/GKmGhERp7Awzg64hnVY/1y9I=;
        b=Pde9Wp8ezjN/FR6Xok4DeJyj89DY2dg/06dtOiUSjeFzTj9CdWEZT51fjUc+9+NyFb
         h+jj78CYfjAniPG5M5sC+CjzAlECnp+Cgx2vuEtSTfi+4tRDOMoCmHL14Rg1Dl4mhNp4
         Ev9wvxP/sZOYEXpbTfgJjR5lYh8Nz1EvPJCgiD40mT2yO9459+cAWN5MiSBXX9/NT8Pf
         hhOH7/x7sDURrPfLTlWsjaHkFqgTVg2ZOU9D4xDC342KF6Ina3oJIX1+QO6yFMK/JNDi
         lngP6lNkPPxSudMboDsmSgfjRhoQrR+UH0BYhzJ4+hVLvGCTKvyi3M9DDFI6JHDmml0X
         pgSg==
X-Gm-Message-State: AOJu0YxiRTu9UMXRn/17nn5YN02T21Cj1uX/kTNOAEk1KXCQjL1CbOAg
	pFNIFJ1spedWV2Cw6Bd9Bvv0bIOgA1Zhly6EKqlxknwKkxm0JrdxP/Fl/6DM/In4ne66
X-Google-Smtp-Source: AGHT+IGuu/ntgczcc55uop5j2oZ1vO48hkx/nlTiLC4zJU7QFUkMOG+swkCaU5zszPOBeMUjGOZroA==
X-Received: by 2002:a19:e017:0:b0:513:ec32:aa89 with SMTP id x23-20020a19e017000000b00513ec32aa89mr1871008lfg.2.1711632961079;
        Thu, 28 Mar 2024 06:36:01 -0700 (PDT)
Received: from localhost.localdomain ([83.217.198.104])
        by smtp.gmail.com with ESMTPSA id u15-20020a056512040f00b00515c1a97da2sm208215lfk.83.2024.03.28.06.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 06:36:00 -0700 (PDT)
From: Denis Kirjanov <kirjanov@gmail.com>
X-Google-Original-From: Denis Kirjanov <dkirjanov@suse.de>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	Denis Kirjanov <dkirjanov@suse.de>,
	syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
Subject: [PATCH v3 net] Subject: [PATCH] RDMA/core: fix UAF with ib_device_get_netdev()
Date: Thu, 28 Mar 2024 09:35:42 -0400
Message-Id: <20240328133542.28572-1-dkirjanov@suse.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A call to ib_device_get_netdev may lead to a race condition
while accessing a netdevice instance since we don't hold
the rtnl lock while checking
the registration state:
	if (res && res->reg_state != NETREG_REGISTERED) {

v2: unlock rtnl on error path
v3: update remaining callers of ib_device_get_netdev

Reported-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
Fixes: d41861942fc55 ("IB/core: Add generic function to extract IB speed from netdev")
Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
---
 drivers/infiniband/core/cache.c  |  2 ++
 drivers/infiniband/core/device.c | 15 ++++++++++++---
 drivers/infiniband/core/nldev.c  |  2 ++
 drivers/infiniband/core/verbs.c  |  6 ++++--
 4 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index c02a96d3572a..cf9c826cd520 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -1461,7 +1461,9 @@ static int config_non_roce_gid_cache(struct ib_device *device,
 		if (rdma_protocol_iwarp(device, port)) {
 			struct net_device *ndev;
 
+			rtnl_lock();
 			ndev = ib_device_get_netdev(device, port);
+			rtnl_unlock();
 			if (!ndev)
 				continue;
 			RCU_INIT_POINTER(gid_attr.ndev, ndev);
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 07cb6c5ffda0..53074a4b04c9 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2026,9 +2026,12 @@ static int iw_query_port(struct ib_device *device,
 
 	memset(port_attr, 0, sizeof(*port_attr));
 
+	rtnl_lock();
 	netdev = ib_device_get_netdev(device, port_num);
-	if (!netdev)
+	if (!netdev) {
+		rtnl_unlock();
 		return -ENODEV;
+	}
 
 	port_attr->max_mtu = IB_MTU_4096;
 	port_attr->active_mtu = ib_mtu_int_to_enum(netdev->mtu);
@@ -2052,6 +2055,7 @@ static int iw_query_port(struct ib_device *device,
 		rcu_read_unlock();
 	}
 
+	rtnl_unlock();
 	dev_put(netdev);
 	return device->ops.query_port(device, port_num, port_attr);
 }
@@ -2220,6 +2224,8 @@ struct net_device *ib_device_get_netdev(struct ib_device *ib_dev,
 	struct ib_port_data *pdata;
 	struct net_device *res;
 
+	ASSERT_RTNL();
+
 	if (!rdma_is_port_valid(ib_dev, port))
 		return NULL;
 
@@ -2306,12 +2312,15 @@ void ib_enum_roce_netdev(struct ib_device *ib_dev,
 
 	rdma_for_each_port (ib_dev, port)
 		if (rdma_protocol_roce(ib_dev, port)) {
-			struct net_device *idev =
-				ib_device_get_netdev(ib_dev, port);
+			struct net_device *idev;
+
+			rtnl_lock();
+			idev = ib_device_get_netdev(ib_dev, port);
 
 			if (filter(ib_dev, port, idev, filter_cookie))
 				cb(ib_dev, port, idev, cookie);
 
+			rtnl_unlock();
 			if (idev)
 				dev_put(idev);
 		}
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 4900a0848124..cfa204a224f2 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -360,6 +360,7 @@ static int fill_port_info(struct sk_buff *msg,
 	if (nla_put_u8(msg, RDMA_NLDEV_ATTR_PORT_PHYS_STATE, attr.phys_state))
 		return -EMSGSIZE;
 
+	rtnl_lock();
 	netdev = ib_device_get_netdev(device, port);
 	if (netdev && net_eq(dev_net(netdev), net)) {
 		ret = nla_put_u32(msg,
@@ -371,6 +372,7 @@ static int fill_port_info(struct sk_buff *msg,
 	}
 
 out:
+	rtnl_unlock();
 	dev_put(netdev);
 	return ret;
 }
diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 94a7f3b0c71c..6a3757b00c93 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1976,11 +1976,13 @@ int ib_get_eth_speed(struct ib_device *dev, u32 port_num, u16 *speed, u8 *width)
 	if (rdma_port_get_link_layer(dev, port_num) != IB_LINK_LAYER_ETHERNET)
 		return -EINVAL;
 
+	rtnl_lock();
 	netdev = ib_device_get_netdev(dev, port_num);
-	if (!netdev)
+	if (!netdev) {
+		rtnl_unlock();
 		return -ENODEV;
+	}
 
-	rtnl_lock();
 	rc = __ethtool_get_link_ksettings(netdev, &lksettings);
 	rtnl_unlock();
 
-- 
2.30.2


