Return-Path: <netdev+bounces-72181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62461856DF9
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 20:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90B7D284135
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 19:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825C713A87E;
	Thu, 15 Feb 2024 19:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="b9XYQeVj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FC613A26F
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 19:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708026210; cv=none; b=ryQ0w3qWolZP3Oa8Ofw/M679BGeGZnnvedMO/9Zv/LcQhGb7EQclcHZYzj9o2FG5ZxUnB/r2jGbeFRm6HkkIkmZl4pZHezBlH8/CnyEaadzSecTfmrMkAdmya5ijG+D6uao5uk4IldBAhS4GnkLBQtJ2osLiNnmlgmyPL3yS7BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708026210; c=relaxed/simple;
	bh=0MOnMdwRFX+dop9REMdKnrHyttPB/b1CWskzz7FnzdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rrZs6AipOXoW0vmun2Ke082KPzh0gD7DKcTscBSfsEUp1IDkyihRawW3cSmx/Ds5/K/J6GAJAMADP1jbFCqfQ5ekj4p8TI6f3uqQb8p0R8jkBslDEf+29j2WT3xcsanS/y5LKywm1MiLbiwMxoWFFv6jnN5nFevgL/6ZPfYW9Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=b9XYQeVj; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d7393de183so10824275ad.3
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 11:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1708026208; x=1708631008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpvAV5bh7+9HTdlXs/ImEQRlIrypU0HqHp/bHD697NU=;
        b=b9XYQeVju9pFEnYTc4oE7Wu5JLIonvO6X5w+R02tEQuVf7vVXXJSAR21RaNTX27fiN
         o6SaNNXnmPM16lZ9O7Fi8JtG203NOnFtabE0Uco9kfQ8ffCg5cdXD7W5iv0ULe2HJAK3
         TS7ZXwACmwE9kOhLRLZVALHb+n9Bmp14LGeekuNF+IUfa1RutF6hnulo1cg7soF+Ilv6
         aP7yxxyRMS5gLDWcFDOKe/diMzFruP0twgpaEIEGHCP9TlnJhXdyiKOM+3YP7PgcYElr
         KRwz64Xi11TaRGv+quQeLBtlJzFNSVvCaG7kzieYywpYspMJkZVP/nNtDg0pg0Aa+iNN
         CJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708026208; x=1708631008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpvAV5bh7+9HTdlXs/ImEQRlIrypU0HqHp/bHD697NU=;
        b=FVwFgqQk4A8BH4NqbiyALujipBZIZ4TC5Iy3KDZyvE3avjJ/MCkvbY5kkKr4HIUxZ+
         tamPJHYOZkqQkEB00NZ7mQCxAMc0D5ZwHqcQpqxjGVFwqCq2iPgEfOiDmitZxON98lO2
         WgGGJPaE+nUz9n2SBsZow5D+NhlC/NkUAjmkQ/9YBQrKexduwdQEmdWJhKZhgeodv2SX
         rHKF3evfETK/kdVucf1fvUGFwBsG8CpLPKKWFa1FdnEdLStqgtPHbXBcRuzpVepORl/g
         uVhpKjNKrVlkfyctsv1hy+p9os7HaVmyoP7FPQvudjeJsfG0UVE19C6dbYJtRlJP7Is8
         O7mQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1ctR6ihx2twCIX7NBZdeJXCqEjTNcUbHzh75FUpeDv5r4RwrlnO2HlkzRcuJKkoqlPrbY7eMx6Z5GachAfX4KaJ5LiMWg
X-Gm-Message-State: AOJu0YwMoGrOfQqU9YTyWSqnl8QEb3WCtypTF7Me1XDRU58tUAOjC/IJ
	GIKKy1YrCuUXPkWDHjVXW3Phh2uEmpBjQ4cirq8RvRhc8cezLxftqYKfFaZphO8=
X-Google-Smtp-Source: AGHT+IHvtUL8JyBysrGNoCKHBeUZ7+eoqKeI94qXNDs4gi+fj4sKHoQ+sF3B1e+OnYZ2U4ZmiZGFsw==
X-Received: by 2002:a17:903:25c2:b0:1d9:db3e:e3d8 with SMTP id jc2-20020a17090325c200b001d9db3ee3d8mr2188642plb.5.1708026208107;
        Thu, 15 Feb 2024 11:43:28 -0800 (PST)
Received: from localhost (fwdproxy-prn-016.fbsv.net. [2a03:2880:ff:10::face:b00c])
        by smtp.gmail.com with ESMTPSA id m18-20020a170902f21200b001db9d2c1874sm503836plc.29.2024.02.15.11.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 11:43:27 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v11 1/3] netdevsim: allow two netdevsim ports to be connected
Date: Thu, 15 Feb 2024 11:43:23 -0800
Message-Id: <20240215194325.1364466-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240215194325.1364466-1-dw@davidwei.uk>
References: <20240215194325.1364466-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two netdevsim bus attribute to sysfs:
/sys/bus/netdevsim/link_device
/sys/bus/netdevsim/unlink_device

Writing "A M B N" to link_device will link netdevsim M in netnsid A with
netdevsim N in netnsid B.

Writing "A M" to unlink_device will unlink netdevsim M in netnsid A from
its peer, if any.

rtnl_lock is taken to ensure nothing changes during the linking.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/netdevsim/bus.c       | 135 ++++++++++++++++++++++++++++++
 drivers/net/netdevsim/netdev.c    |  10 +++
 drivers/net/netdevsim/netdevsim.h |   2 +
 3 files changed, 147 insertions(+)

diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
index aedab1d9623a..819c74a7c625 100644
--- a/drivers/net/netdevsim/bus.c
+++ b/drivers/net/netdevsim/bus.c
@@ -232,9 +232,144 @@ del_device_store(const struct bus_type *bus, const char *buf, size_t count)
 }
 static BUS_ATTR_WO(del_device);
 
+static ssize_t link_device_store(const struct bus_type *bus, const char *buf, size_t count)
+{
+	struct netdevsim *nsim_a, *nsim_b, *peer;
+	struct net_device *dev_a, *dev_b;
+	unsigned int ifidx_a, ifidx_b;
+	int netnsfd_a, netnsfd_b, err;
+	struct net *ns_a, *ns_b;
+
+	err = sscanf(buf, "%d:%u %d:%u", &netnsfd_a, &ifidx_a, &netnsfd_b, &ifidx_b);
+	if (err != 4) {
+		pr_err("Format for linking two devices is \"netnsfd_a:ifidx_a netnsfd_b:ifidx_b\" (int uint int uint).\n");
+		return -EINVAL;
+	}
+
+	ns_a = get_net_ns_by_fd(netnsfd_a);
+	if (IS_ERR(ns_a)) {
+		pr_err("Could not find netns with fd: %d\n", netnsfd_a);
+		return -EINVAL;
+	}
+
+	ns_b = get_net_ns_by_fd(netnsfd_b);
+	if (IS_ERR(ns_b)) {
+		pr_err("Could not find netns with fd: %d\n", netnsfd_b);
+		return -EINVAL;
+	}
+
+	err = -EINVAL;
+	rtnl_lock();
+	dev_a = __dev_get_by_index(ns_a, ifidx_a);
+	if (!dev_a) {
+		pr_err("Could not find device with ifindex %u in netnsfd %d\n", ifidx_a, netnsfd_a);
+		goto out_put_netns_a;
+	}
+
+	if (!netdev_is_nsim(dev_a)) {
+		pr_err("Device with ifindex %u in netnsfd %d is not a netdevsim\n", ifidx_a, netnsfd_a);
+		goto out_put_netns_a;
+	}
+
+	dev_b = __dev_get_by_index(ns_b, ifidx_b);
+	if (!dev_b) {
+		pr_err("Could not find device with ifindex %u in netnsfd %d\n", ifidx_b, netnsfd_b);
+		goto out_put_netns_b;
+	}
+
+	if (!netdev_is_nsim(dev_b)) {
+		pr_err("Device with ifindex %u in netnsfd %d is not a netdevsim\n", ifidx_b, netnsfd_b);
+		goto out_put_netns_b;
+	}
+
+	if (dev_a == dev_b) {
+		pr_err("Cannot link a netdevsim to itself\n");
+		goto out_put_netns_b;
+	}
+
+	err = 0;
+	nsim_a = netdev_priv(dev_a);
+	peer = rtnl_dereference(nsim_a->peer);
+	if (peer) {
+		pr_err("Netdevsim %d:%u is already linked\n", netnsfd_a, ifidx_a);
+		goto out_put_netns_b;
+	}
+
+	nsim_b = netdev_priv(dev_b);
+	peer = rtnl_dereference(nsim_b->peer);
+	if (peer) {
+		pr_err("Netdevsim %d:%u is already linked\n", netnsfd_b, ifidx_b);
+		goto out_put_netns_b;
+	}
+
+	rcu_assign_pointer(nsim_a->peer, nsim_b);
+	rcu_assign_pointer(nsim_b->peer, nsim_a);
+
+out_put_netns_b:
+	put_net(ns_b);
+out_put_netns_a:
+	put_net(ns_a);
+	rtnl_unlock();
+
+	return !err ? count : err;
+}
+static BUS_ATTR_WO(link_device);
+
+static ssize_t unlink_device_store(const struct bus_type *bus, const char *buf, size_t count)
+{
+	struct netdevsim *nsim, *peer;
+	struct net_device *dev;
+	unsigned int ifidx;
+	int netnsfd, err;
+	struct net *ns;
+
+	err = sscanf(buf, "%u:%u", &netnsfd, &ifidx);
+	if (err != 2) {
+		pr_err("Format for unlinking a device is \"netnsfd:ifidx\" (int uint).\n");
+		return -EINVAL;
+	}
+
+	ns = get_net_ns_by_fd(netnsfd);
+	if (IS_ERR(ns)) {
+		pr_err("Could not find netns with fd: %d\n", netnsfd);
+		return -EINVAL;
+	}
+
+	err = -EINVAL;
+	rtnl_lock();
+	dev = __dev_get_by_index(ns, ifidx);
+	if (!dev) {
+		pr_err("Could not find device with ifindex %u in netnsfd %d\n", ifidx, netnsfd);
+		goto out_put_netns;
+	}
+
+	if (!netdev_is_nsim(dev)) {
+		pr_err("Device with ifindex %u in netnsfd %d is not a netdevsim\n", ifidx, netnsfd);
+		goto out_put_netns;
+	}
+
+	err = 0;
+	nsim = netdev_priv(dev);
+	peer = rtnl_dereference(nsim->peer);
+	if (!peer)
+		goto out_put_netns;
+
+	RCU_INIT_POINTER(nsim->peer, NULL);
+	RCU_INIT_POINTER(peer->peer, NULL);
+
+out_put_netns:
+	put_net(ns);
+	rtnl_unlock();
+
+	return !err ? count : err;
+}
+static BUS_ATTR_WO(unlink_device);
+
 static struct attribute *nsim_bus_attrs[] = {
 	&bus_attr_new_device.attr,
 	&bus_attr_del_device.attr,
+	&bus_attr_link_device.attr,
+	&bus_attr_unlink_device.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(nsim_bus);
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 77e8250282a5..9063f4f2971b 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -413,8 +413,13 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
 void nsim_destroy(struct netdevsim *ns)
 {
 	struct net_device *dev = ns->netdev;
+	struct netdevsim *peer;
 
 	rtnl_lock();
+	peer = rtnl_dereference(ns->peer);
+	if (peer)
+		RCU_INIT_POINTER(peer->peer, NULL);
+	RCU_INIT_POINTER(ns->peer, NULL);
 	unregister_netdevice(dev);
 	if (nsim_dev_port_is_pf(ns->nsim_dev_port)) {
 		nsim_macsec_teardown(ns);
@@ -427,6 +432,11 @@ void nsim_destroy(struct netdevsim *ns)
 	free_netdev(dev);
 }
 
+bool netdev_is_nsim(struct net_device *dev)
+{
+	return dev->netdev_ops == &nsim_netdev_ops;
+}
+
 static int nsim_validate(struct nlattr *tb[], struct nlattr *data[],
 			 struct netlink_ext_ack *extack)
 {
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 028c825b86db..c8b45b0d955e 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -125,11 +125,13 @@ struct netdevsim {
 	} udp_ports;
 
 	struct nsim_ethtool ethtool;
+	struct netdevsim __rcu *peer;
 };
 
 struct netdevsim *
 nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port);
 void nsim_destroy(struct netdevsim *ns);
+bool netdev_is_nsim(struct net_device *dev);
 
 void nsim_ethtool_init(struct netdevsim *ns);
 
-- 
2.39.3


