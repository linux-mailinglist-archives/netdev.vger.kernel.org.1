Return-Path: <netdev+bounces-78998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC0C8774D7
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 02:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C04E1F2127C
	for <lists+netdev@lfdr.de>; Sun, 10 Mar 2024 01:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1A910EB;
	Sun, 10 Mar 2024 01:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="xGejeRVD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D91210E9
	for <netdev@vger.kernel.org>; Sun, 10 Mar 2024 01:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710035556; cv=none; b=mXQTEJhdjGA73oWMu3GTkw+cTjrdDwugIHWwF3BVSBKVIYGGXcRY5Hegkrdi+jTDWRwtJ7D9JIPH2sOY9rBVGREewcsgLhacrXCO5GvEZO9ipzQBaq94HJkq1pSjSc7OHwuHr2xp6GB+u58gY2pRzyQsJCrstL6xyS5Qd1mb85U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710035556; c=relaxed/simple;
	bh=uJzJ7mrR80+gzTak8hTwccOzN3tGl7a1ffD/Od/cVeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P+1nPcMc+X1ivXJM7UkkgPoq3/S7iwSCNcuG6tiWRQZmFxQ9wmVOsJbvb/OGJuPNv+Aj/0nTQc4Z0CQhxCshewYCsQhS42nIpQSsqTLMmGy7SomWBs+EdU0Dw32MJPVlLVNtO7hu8+lhMtZz3Nf2Z8J3lsFLbJZimH5UdxvPZAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=xGejeRVD; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e66e8fcc2dso1740087b3a.3
        for <netdev@vger.kernel.org>; Sat, 09 Mar 2024 17:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1710035554; x=1710640354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HU4CiUDZCWgP6EQMaH7OtOKisk6p6eqn0o1p/P5RI90=;
        b=xGejeRVDhv4zKS3pVc5/mEJUuEmLbQuLLwD5NY0sHdkHIo80dp8FjRJwxera9RZr4L
         KlOKqHfPebtLq66W7GkxUe942SgwXzxf6xBFPGoNLWv/pcDHc7gvJuMQFpgud0knpqqn
         tFsq7aAN5bNW7+bRLgkkGpvLA/5hgWctkpfbAnOAgX4ycpMWVaN/5DhRhJo5Ua/dLVZB
         0yIcEco9CpzQGrbIL8p5Vwos8YL21CiZVB4O7txPbYwDZfj8/4l7GR4L8odi3g9/pWMx
         IsC6C0i4k8PynPGOCHKU/HdmZeKp2NItNB78hzQ7Tgbg0lSg9fsdBfQEz/sMOQD0r28r
         6MnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710035554; x=1710640354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HU4CiUDZCWgP6EQMaH7OtOKisk6p6eqn0o1p/P5RI90=;
        b=ZlMgyf+GIa+00CzrDi4hA4vHeoym98i4MbdXASTbNq2VNFe1R6Y16/ArmKFJs40RE6
         PQ1yElB4HaR+he1FHWyAGR/Juns/nmYI8bVs24LDpMj2R9ZZL5sRPLU8ey73RZHoJwFq
         w0MGuGSI4AuspIfgb33kCbT7HYTKFijA+7aSZjgQB4X4qNOmoFHYXGa2FGE7hq+L8fvr
         HDY0czNbZQOzvFFoOPuCgEkji2QQabeKQcxbBzG61TJqylNKWZ0qi4GBnOHNjGKnQfOZ
         5bmKq0UJw02zeycmfoktUTZ0jNNDylUDmGW/okp+woluV/gihGtiyPTmPWAxmPLhiCch
         nX7A==
X-Forwarded-Encrypted: i=1; AJvYcCWH2Ujd5AUv0WQ3F7TecXyOSLy6cHs1wXpbfM2Ki1q8AvmPUiCfFcC/Eu/4p1gQhbt3Beu7tYEGh9vDAvxUrSMwI195AFZG
X-Gm-Message-State: AOJu0YwLdRe0rPYh8umXuSKTS6zdqp28xOLJGfqURHi3zttfldA7hIeh
	T4T4wnttgZy1LQxHelJcAj2abKtpwbtgK8p+7AlBVkW2OMi0TrGJfKLOgNukdF0=
X-Google-Smtp-Source: AGHT+IEYhJwQVmb2AyV2d01V7m3afZAakaeH4/yUYHE7dhJvPSPZrS2gjOFHvZmt63erS6DOkWzTYw==
X-Received: by 2002:a17:903:278c:b0:1dd:7829:6a2b with SMTP id jw12-20020a170903278c00b001dd78296a2bmr2299827plb.35.1710035554085;
        Sat, 09 Mar 2024 17:52:34 -0800 (PST)
Received: from localhost (fwdproxy-prn-117.fbsv.net. [2a03:2880:ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id l8-20020a170902f68800b001db5079b705sm1899939plg.36.2024.03.09.17.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 17:52:32 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v1] netdevsim: replace pr_err with {dev,netdev,}_err wherever possible
Date: Sat,  9 Mar 2024 17:52:15 -0800
Message-ID: <20240310015215.4011872-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace pr_err() in netdevsim with {dev,netdev,}_err if possible,
preferring the most specific device available.

Not all instances of pr_err() can be replaced however, as there may not
be a device to associate the error with, or a device might not be
available.

Tested by building and running netdevsim/peer.sh selftest.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/netdevsim/bus.c    | 22 +++++++++++-----------
 drivers/net/netdevsim/dev.c    | 23 +++++++++++++----------
 drivers/net/netdevsim/fib.c    |  4 ++--
 drivers/net/netdevsim/netdev.c |  2 +-
 4 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
index 64c0cdd31bf8..84ad23db15d7 100644
--- a/drivers/net/netdevsim/bus.c
+++ b/drivers/net/netdevsim/bus.c
@@ -270,8 +270,8 @@ static ssize_t link_device_store(const struct bus_type *bus, const char *buf, si
 	}
 
 	if (!netdev_is_nsim(dev_a)) {
-		pr_err("Device with ifindex %u in netnsfd %d is not a netdevsim\n",
-		       ifidx_a, netnsfd_a);
+		netdev_err(dev_a, "Device with ifindex %u in netnsfd %d is not a netdevsim\n",
+			   ifidx_a, netnsfd_a);
 		goto out_err;
 	}
 
@@ -283,13 +283,13 @@ static ssize_t link_device_store(const struct bus_type *bus, const char *buf, si
 	}
 
 	if (!netdev_is_nsim(dev_b)) {
-		pr_err("Device with ifindex %u in netnsfd %d is not a netdevsim\n",
-		       ifidx_b, netnsfd_b);
+		netdev_err(dev_b, "Device with ifindex %u in netnsfd %d is not a netdevsim\n",
+			   ifidx_b, netnsfd_b);
 		goto out_err;
 	}
 
 	if (dev_a == dev_b) {
-		pr_err("Cannot link a netdevsim to itself\n");
+		netdev_err(dev_a, "Cannot link a netdevsim to itself\n");
 		goto out_err;
 	}
 
@@ -297,16 +297,16 @@ static ssize_t link_device_store(const struct bus_type *bus, const char *buf, si
 	nsim_a = netdev_priv(dev_a);
 	peer = rtnl_dereference(nsim_a->peer);
 	if (peer) {
-		pr_err("Netdevsim %d:%u is already linked\n", netnsfd_a,
-		       ifidx_a);
+		netdev_err(dev_a, "Netdevsim %d:%u is already linked\n",
+			   netnsfd_a, ifidx_a);
 		goto out_err;
 	}
 
 	nsim_b = netdev_priv(dev_b);
 	peer = rtnl_dereference(nsim_b->peer);
 	if (peer) {
-		pr_err("Netdevsim %d:%u is already linked\n", netnsfd_b,
-		       ifidx_b);
+		netdev_err(dev_b, "Netdevsim %d:%u is already linked\n",
+			   netnsfd_b, ifidx_b);
 		goto out_err;
 	}
 
@@ -353,8 +353,8 @@ static ssize_t unlink_device_store(const struct bus_type *bus, const char *buf,
 	}
 
 	if (!netdev_is_nsim(dev)) {
-		pr_err("Device with ifindex %u in netnsfd %d is not a netdevsim\n",
-		       ifidx, netnsfd);
+		netdev_err(dev, "Device with ifindex %u in netnsfd %d is not a netdevsim\n",
+			   ifidx, netnsfd);
 		goto out_put_netns;
 	}
 
diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index 92a7a36b93ac..b675660b37e6 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -111,7 +111,7 @@ static ssize_t nsim_dev_take_snapshot_write(struct file *file,
 
 	err = devlink_region_snapshot_id_get(devlink, &id);
 	if (err) {
-		pr_err("Failed to get snapshot id\n");
+		dev_err(&nsim_dev->nsim_bus_dev->dev, "Failed to get snapshot id\n");
 		kfree(dummy_data);
 		return err;
 	}
@@ -119,7 +119,7 @@ static ssize_t nsim_dev_take_snapshot_write(struct file *file,
 					     dummy_data, id);
 	devlink_region_snapshot_id_put(devlink, id);
 	if (err) {
-		pr_err("Failed to create region snapshot\n");
+		dev_err(&nsim_dev->nsim_bus_dev->dev, "Failed to create region snapshot\n");
 		kfree(dummy_data);
 		return err;
 	}
@@ -428,6 +428,8 @@ static void nsim_dev_port_debugfs_exit(struct nsim_dev_port *nsim_dev_port)
 
 static int nsim_dev_resources_register(struct devlink *devlink)
 {
+	struct nsim_dev *nsim_dev = devlink_priv(devlink);
+
 	struct devlink_resource_size_params params = {
 		.size_max = (u64)-1,
 		.size_granularity = 1,
@@ -441,7 +443,7 @@ static int nsim_dev_resources_register(struct devlink *devlink)
 				     DEVLINK_RESOURCE_ID_PARENT_TOP,
 				     &params);
 	if (err) {
-		pr_err("Failed to register IPv4 top resource\n");
+		dev_err(&nsim_dev->nsim_bus_dev->dev, "Failed to register IPv4 top resource\n");
 		goto err_out;
 	}
 
@@ -449,7 +451,7 @@ static int nsim_dev_resources_register(struct devlink *devlink)
 				     NSIM_RESOURCE_IPV4_FIB,
 				     NSIM_RESOURCE_IPV4, &params);
 	if (err) {
-		pr_err("Failed to register IPv4 FIB resource\n");
+		dev_err(&nsim_dev->nsim_bus_dev->dev, "Failed to register IPv4 FIB resource\n");
 		goto err_out;
 	}
 
@@ -457,7 +459,7 @@ static int nsim_dev_resources_register(struct devlink *devlink)
 				     NSIM_RESOURCE_IPV4_FIB_RULES,
 				     NSIM_RESOURCE_IPV4, &params);
 	if (err) {
-		pr_err("Failed to register IPv4 FIB rules resource\n");
+		dev_err(&nsim_dev->nsim_bus_dev->dev, "Failed to register IPv4 FIB rules resource\n");
 		goto err_out;
 	}
 
@@ -467,7 +469,7 @@ static int nsim_dev_resources_register(struct devlink *devlink)
 				     DEVLINK_RESOURCE_ID_PARENT_TOP,
 				     &params);
 	if (err) {
-		pr_err("Failed to register IPv6 top resource\n");
+		dev_err(&nsim_dev->nsim_bus_dev->dev, "Failed to register IPv6 top resource\n");
 		goto err_out;
 	}
 
@@ -475,7 +477,7 @@ static int nsim_dev_resources_register(struct devlink *devlink)
 				     NSIM_RESOURCE_IPV6_FIB,
 				     NSIM_RESOURCE_IPV6, &params);
 	if (err) {
-		pr_err("Failed to register IPv6 FIB resource\n");
+		dev_err(&nsim_dev->nsim_bus_dev->dev, "Failed to register IPv6 FIB resource\n");
 		goto err_out;
 	}
 
@@ -483,7 +485,7 @@ static int nsim_dev_resources_register(struct devlink *devlink)
 				     NSIM_RESOURCE_IPV6_FIB_RULES,
 				     NSIM_RESOURCE_IPV6, &params);
 	if (err) {
-		pr_err("Failed to register IPv6 FIB rules resource\n");
+		dev_err(&nsim_dev->nsim_bus_dev->dev, "Failed to register IPv6 FIB rules resource\n");
 		goto err_out;
 	}
 
@@ -493,7 +495,7 @@ static int nsim_dev_resources_register(struct devlink *devlink)
 				     DEVLINK_RESOURCE_ID_PARENT_TOP,
 				     &params);
 	if (err) {
-		pr_err("Failed to register NEXTHOPS resource\n");
+		dev_err(&nsim_dev->nsim_bus_dev->dev, "Failed to register NEXTHOPS resource\n");
 		goto err_out;
 	}
 	return 0;
@@ -603,7 +605,8 @@ static int nsim_esw_switchdev_enable(struct nsim_dev *nsim_dev,
 		err = __nsim_dev_port_add(nsim_dev, NSIM_DEV_PORT_TYPE_VF, i);
 		if (err) {
 			NL_SET_ERR_MSG_MOD(extack, "Failed to initialize VFs' netdevsim ports");
-			pr_err("Failed to initialize VF id=%d. %d.\n", i, err);
+			dev_err(&nsim_dev->nsim_bus_dev->dev,
+				"Failed to initialize VF id=%d. %d.\n", i, err);
 			goto err_port_add_vfs;
 		}
 	}
diff --git a/drivers/net/netdevsim/fib.c b/drivers/net/netdevsim/fib.c
index a1f91ff8ec56..991087a47ba0 100644
--- a/drivers/net/netdevsim/fib.c
+++ b/drivers/net/netdevsim/fib.c
@@ -1587,7 +1587,7 @@ struct nsim_fib_data *nsim_fib_create(struct devlink *devlink,
 	err = register_nexthop_notifier(devlink_net(devlink), &data->nexthop_nb,
 					extack);
 	if (err) {
-		pr_err("Failed to register nexthop notifier\n");
+		dev_err(&nsim_dev->nsim_bus_dev->dev, "Failed to register nexthop notifier\n");
 		goto err_rhashtable_fib_destroy;
 	}
 
@@ -1595,7 +1595,7 @@ struct nsim_fib_data *nsim_fib_create(struct devlink *devlink,
 	err = register_fib_notifier(devlink_net(devlink), &data->fib_nb,
 				    nsim_fib_dump_inconsistent, extack);
 	if (err) {
-		pr_err("Failed to register fib notifier\n");
+		dev_err(&nsim_dev->nsim_bus_dev->dev, "Failed to register fib notifier\n");
 		goto err_nexthop_nb_unregister;
 	}
 
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 8330bc0bcb7e..a31e3b50859e 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -132,7 +132,7 @@ static int nsim_set_vf_rate(struct net_device *dev, int vf, int min, int max)
 	struct nsim_dev *nsim_dev = ns->nsim_dev;
 
 	if (nsim_esw_mode_is_switchdev(ns->nsim_dev)) {
-		pr_err("Not supported in switchdev mode. Please use devlink API.\n");
+		netdev_err(dev, "Not supported in switchdev mode. Please use devlink API.\n");
 		return -EOPNOTSUPP;
 	}
 
-- 
2.43.0


