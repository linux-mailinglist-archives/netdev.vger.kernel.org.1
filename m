Return-Path: <netdev+bounces-83740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5148939E1
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 12:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C39281D27
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 10:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE4F10A3E;
	Mon,  1 Apr 2024 10:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fi/H/oGC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0310713AC0
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711965637; cv=none; b=hw53JLT9JfFxD36IKmz0qdfXIJo2hTgHiTHfAhlC2mBdorwQZK6n58MyBpdcza9M9Whzk+d2q9O9ykMOFKPqHQUzU4Dakt5ElKTDC+EZIHHzb5uVMxkeRcWiDkFpDPdM+0V8usAny2d7rTjJjm9llA3e7gy2hh98amB5TJRhRqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711965637; c=relaxed/simple;
	bh=KRQmYjcoCafeSW6+aU/cnOD5VYE3flnQoxeLnfJ6Gdw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LtQqh3gLMiUT6h1wlnHJ3ZhBBLXi1QCJHoTHjjyrebXs7gGQOqwRoHE/TnE4WOrkS3IXyTYaUKIqhN7ZQu+0tL1WOVuj6OL/LJk91PjhMjH1RGA1VKuSukf5Tx3AWAhPnQ+t7RRlI3FrSIAXCO1/UyKn8PbneyjpwKlWvQOCUis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fi/H/oGC; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e4e36c09cso1092092e87.1
        for <netdev@vger.kernel.org>; Mon, 01 Apr 2024 03:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711965633; x=1712570433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DpPO2m0xMLjgiV69ATedClGX90CGKRb+nCXn2d7UK0E=;
        b=Fi/H/oGCJdfFqwcmuEfDjj4IqwONfEEDYE84qU7IgmfsqeGG1Vexz0Egv0teXGKNFq
         YRfrXDZwLV/Sc0qT3oc+jmUzqQt2MwegotNTIvU53Ww9Tvy6itaqUBHA7VJUBerdEpu4
         u+rPkPKEV+YCWLfLOM61znr/9OWVG/uTDPOE8mgm+iuvEt1QBeNBFeYjmj2v7Z58wFSe
         zReqk8QPebNXkFa2IPyAzqh8KOETVxSFDl+ZO/DttNMDvgHMaJgzeza7/H8/r+0/Zhjx
         gz6mKPk1uQBwKv18729/V2E2pT5WoLy5uMw7IVqzweeVgpoq4wEzsThSCHNh0esLgXcL
         9SVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711965633; x=1712570433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DpPO2m0xMLjgiV69ATedClGX90CGKRb+nCXn2d7UK0E=;
        b=K53VL+6Ej4ZM41juCLXzPttcX39iQz+FS+459GQqXPicWTZn495Bq8NY55Gj1xM3yM
         sB1+RJpYFJPhtNqQhtRvL322dVxowvwHqooN6WR1ir4+rAJNClcpSUGj0JH5PywDOK0O
         5a6dXWkn5/SfOE3BFdBK/XdaFm3+v9pMKztaBp+pz5DcDqKlaze9Hn+bm8asQgXyU8R3
         4+/7wRtva6N7+thYvOXyaexSx8E+U1kE7LITxp/y/lihBn4hPtK1jsNOwi566Uz8Xs7r
         3NtHFabpALQvSzPhXq3JLUL6AJuvF/4rtkNpwnU5uAKBzTvTVE6FGbuFRgWOloXJXw4C
         tW3w==
X-Gm-Message-State: AOJu0Yz53g2Vk+Tubj0MfHHGtzFWnixjrIzjhfPQ2l36oj4Vc7q33zwW
	WMK1K4H0Q1NL3FmOarKvyOojbE5j5dxCxV8qYn+3RnZeR8P2Wvkp3S51hJRwFHqihg==
X-Google-Smtp-Source: AGHT+IH/gkxQYL0XmPaFaFwpMZFsYK4eMlQXtHjMYhvEte4dlGat0IzQwM1/pGXKdJsM1s76i8AsUw==
X-Received: by 2002:ac2:5b0c:0:b0:513:6982:d940 with SMTP id v12-20020ac25b0c000000b005136982d940mr5549882lfn.1.1711965632925;
        Mon, 01 Apr 2024 03:00:32 -0700 (PDT)
Received: from localhost.localdomain ([83.217.198.104])
        by smtp.gmail.com with ESMTPSA id g17-20020a19ee11000000b00513d021afd1sm1381737lfb.103.2024.04.01.03.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 03:00:31 -0700 (PDT)
From: Denis Kirjanov <kirjanov@gmail.com>
X-Google-Original-From: Denis Kirjanov <dkirjanov@suse.de>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	Denis Kirjanov <dkirjanov@suse.de>,
	syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
Subject: [PATCH 4 net] RDMA/core: fix UAF with ib_device_get_netdev()
Date: Mon,  1 Apr 2024 06:00:05 -0400
Message-Id: <20240401100005.1799-1-dkirjanov@suse.de>
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
v4: don't call a cb with rtnl lock in ib_enum_roce_netdev

Reported-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
Fixes: d41861942fc55 ("IB/core: Add generic function to extract IB speed from netdev")
Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
---
 drivers/infiniband/core/cache.c  |  2 ++
 drivers/infiniband/core/device.c | 15 ++++++++++++---
 drivers/infiniband/core/nldev.c  |  3 +++
 drivers/infiniband/core/verbs.c  |  6 ++++--
 4 files changed, 21 insertions(+), 5 deletions(-)

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
index 07cb6c5ffda0..25edb50d2b64 100644
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
 
@@ -2306,8 +2312,11 @@ void ib_enum_roce_netdev(struct ib_device *ib_dev,
 
 	rdma_for_each_port (ib_dev, port)
 		if (rdma_protocol_roce(ib_dev, port)) {
-			struct net_device *idev =
-				ib_device_get_netdev(ib_dev, port);
+			struct net_device *idev;
+
+			rtnl_lock();
+			idev = ib_device_get_netdev(ib_dev, port);
+			rtnl_unlock();
 
 			if (filter(ib_dev, port, idev, filter_cookie))
 				cb(ib_dev, port, idev, cookie);
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index 4900a0848124..5cf7cdae8925 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -360,7 +360,9 @@ static int fill_port_info(struct sk_buff *msg,
 	if (nla_put_u8(msg, RDMA_NLDEV_ATTR_PORT_PHYS_STATE, attr.phys_state))
 		return -EMSGSIZE;
 
+	rtnl_lock();
 	netdev = ib_device_get_netdev(device, port);
+
 	if (netdev && net_eq(dev_net(netdev), net)) {
 		ret = nla_put_u32(msg,
 				  RDMA_NLDEV_ATTR_NDEV_INDEX, netdev->ifindex);
@@ -371,6 +373,7 @@ static int fill_port_info(struct sk_buff *msg,
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


