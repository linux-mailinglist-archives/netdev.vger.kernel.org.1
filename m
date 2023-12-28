Return-Path: <netdev+bounces-60433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3846081F3EC
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 02:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C70D1C2282A
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 01:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106ED1842;
	Thu, 28 Dec 2023 01:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="b3ZGTz8Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1662568
	for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 01:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6d9b37f4804so1683341b3a.1
        for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 17:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1703727999; x=1704332799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyd3nrqtxjfL3K25CWzrFdKGTu8rTW64z3GVAZH6QeY=;
        b=b3ZGTz8Zv7tXe0Jx2Q73K/H6r4pqOaNbYmKColdkCZ+72vXyTr2zxfKtsjQNA5wclP
         wNvZsGMAB6zEvnpywbMUL8iv8AijzIlDGi2ldmWR12AS0e9ArgVIIez6wd87k182H56g
         Z/w1Umn19Tof6VQsNZsa043pBjtiEv5feEoP0Ehbu5xn3dSXPWoJpU76XFGYsn5mpCXk
         26Z/rRhmEqysP3gsiQtuJpj5REcVLMLa+RR2m2ipeQtlAtYpqFtg1NNEodzf8u6ofVgK
         rIzhqgr3tCOUnRtFoM51MC+Alqd787AMGCl0Md71c9BpFCv88P9n0avLHiUL/1MyMqjU
         yg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703727999; x=1704332799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pyd3nrqtxjfL3K25CWzrFdKGTu8rTW64z3GVAZH6QeY=;
        b=us+/QD9zfRglmzLwJzI8BvxMAsh2pWXCmYHKc/tHdbi/1nEiFK08Wm02CRO1czLdvv
         2X6aGeqsU7VplqzujiQ5ZMe+B9WzFwBa+K5c8XWSSIbcm7akjXMye03LMyA+M9IZL7qE
         acnfPy/oPoiRJ3ajmuOIhz3lRHT8NxxbbmV3p1DL62v4y4zwUGPvItYaXUIRYfPhW2lZ
         AWDq466HdjYNi8Z4J1T8GbCmQwWoRNwaVr1tCQ/FsoX1fieIeCRfqjGp3TWFhOwMGcwC
         uxmVGhGBijOVewJjyzYIPcghh8o52coLDMwWJBYoo69cHr71Dh5+d67T4zXnS8hEGs+q
         gmzQ==
X-Gm-Message-State: AOJu0YzRjCqtSk7/8NXPwDWRL1ZN5Dhek/8VwqmolIxyBag+VMbi5Wio
	zsQJazNJYVpWzi0cp91Qd01doxQKtPVqmw==
X-Google-Smtp-Source: AGHT+IFQs8fIM2ujsD2PVkHziOWJjBwssXWDnIFfLuTg6/xn765AqbmaHql4srgFm+MG+armjEh26g==
X-Received: by 2002:a05:6a21:1445:b0:196:3085:eb23 with SMTP id oc5-20020a056a21144500b001963085eb23mr1312151pzb.8.1703727998804;
        Wed, 27 Dec 2023 17:46:38 -0800 (PST)
Received: from localhost (fwdproxy-prn-116.fbsv.net. [2a03:2880:ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id f26-20020aa78b1a000000b006d97f80c4absm10934573pfd.41.2023.12.27.17.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 17:46:38 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v5 2/5] netdevsim: allow two netdevsim ports to be connected
Date: Wed, 27 Dec 2023 17:46:30 -0800
Message-Id: <20231228014633.3256862-3-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231228014633.3256862-1-dw@davidwei.uk>
References: <20231228014633.3256862-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a debugfs file in
/sys/kernel/debug/netdevsim/netdevsimN/ports/A/peer

Writing "M B" to this file will link port A of netdevsim N with port B
of netdevsim M. Reading this file will return the linked netdevsim id
and port, if any.

During nsim_dev_peer_write(), nsim_dev_list_lock prevents concurrent
modifications to nsim_dev and peer's devlink->lock prevents concurrent
modifications to the peer's port_list. rtnl_lock ensures netdevices do
not change during the critical section where a link is established.

The lock order is consistent with other parts that touch netdevsim and
should not deadlock.

During nsim_dev_peer_read(), RCU read critical section ensures valid
values even if stale.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/netdevsim/dev.c       | 134 +++++++++++++++++++++++++++---
 drivers/net/netdevsim/netdev.c    |   6 ++
 drivers/net/netdevsim/netdevsim.h |   1 +
 3 files changed, 128 insertions(+), 13 deletions(-)

diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index 8d477aa99f94..6d5e4ce08dfd 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -391,6 +391,124 @@ static const struct file_operations nsim_dev_rate_parent_fops = {
 	.owner = THIS_MODULE,
 };
 
+static struct nsim_dev *nsim_dev_find_by_id(unsigned int id)
+{
+	struct nsim_dev *dev;
+
+	list_for_each_entry(dev, &nsim_dev_list, list)
+		if (dev->nsim_bus_dev->dev.id == id)
+			return dev;
+
+	return NULL;
+}
+
+static struct nsim_dev_port *
+__nsim_dev_port_lookup(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
+		       unsigned int port_index)
+{
+	struct nsim_dev_port *nsim_dev_port;
+
+	port_index = nsim_dev_port_index(type, port_index);
+	list_for_each_entry(nsim_dev_port, &nsim_dev->port_list, list)
+		if (nsim_dev_port->port_index == port_index)
+			return nsim_dev_port;
+	return NULL;
+}
+
+static ssize_t nsim_dev_peer_read(struct file *file, char __user *data,
+				  size_t count, loff_t *ppos)
+{
+	struct nsim_dev_port *nsim_dev_port;
+	struct netdevsim *peer;
+	unsigned int id, port;
+	ssize_t ret = 0;
+	char buf[23];
+
+	nsim_dev_port = file->private_data;
+	rcu_read_lock();
+	peer = rcu_dereference(nsim_dev_port->ns->peer);
+	if (!peer) {
+		rcu_read_unlock();
+		return 0;
+	}
+
+	id = peer->nsim_bus_dev->dev.id;
+	port = peer->nsim_dev_port->port_index;
+	ret = scnprintf(buf, sizeof(buf), "%u %u\n", id, port);
+	ret = simple_read_from_buffer(data, count, ppos, buf, ret);
+
+	rcu_read_unlock();
+	return ret;
+}
+
+static ssize_t nsim_dev_peer_write(struct file *file,
+				   const char __user *data,
+				   size_t count, loff_t *ppos)
+{
+	struct nsim_dev_port *nsim_dev_port, *peer_dev_port;
+	struct nsim_dev *peer_dev;
+	unsigned int id, port;
+	char buf[22];
+	ssize_t ret;
+
+	if (count >= sizeof(buf))
+		return -ENOSPC;
+
+	ret = copy_from_user(buf, data, count);
+	if (ret)
+		return -EFAULT;
+	buf[count] = '\0';
+
+	ret = sscanf(buf, "%u %u", &id, &port);
+	if (ret != 2) {
+		pr_err("Format is peer netdevsim \"id port\" (uint uint)\n");
+		return -EINVAL;
+	}
+
+	ret = -EINVAL;
+	mutex_lock(&nsim_dev_list_lock);
+	peer_dev = nsim_dev_find_by_id(id);
+	if (!peer_dev) {
+		pr_err("Peer netdevsim %u does not exist\n", id);
+		goto out_mutex;
+	}
+
+	devl_lock(priv_to_devlink(peer_dev));
+	rtnl_lock();
+	nsim_dev_port = file->private_data;
+	peer_dev_port = __nsim_dev_port_lookup(peer_dev, NSIM_DEV_PORT_TYPE_PF,
+					       port);
+	if (!peer_dev_port) {
+		pr_err("Peer netdevsim %u port %u does not exist\n", id, port);
+		goto out_devl;
+	}
+
+	if (nsim_dev_port == peer_dev_port) {
+		pr_err("Cannot link netdevsim to itself\n");
+		goto out_devl;
+	}
+
+	rcu_assign_pointer(nsim_dev_port->ns->peer, peer_dev_port->ns);
+	rcu_assign_pointer(peer_dev_port->ns->peer, nsim_dev_port->ns);
+	ret = count;
+
+out_devl:
+	rtnl_unlock();
+	devl_unlock(priv_to_devlink(peer_dev));
+out_mutex:
+	mutex_unlock(&nsim_dev_list_lock);
+
+	return ret;
+}
+
+static const struct file_operations nsim_dev_peer_fops = {
+	.open = simple_open,
+	.read = nsim_dev_peer_read,
+	.write = nsim_dev_peer_write,
+	.llseek = generic_file_llseek,
+	.owner = THIS_MODULE,
+};
+
 static int nsim_dev_port_debugfs_init(struct nsim_dev *nsim_dev,
 				      struct nsim_dev_port *nsim_dev_port)
 {
@@ -421,6 +539,9 @@ static int nsim_dev_port_debugfs_init(struct nsim_dev *nsim_dev,
 	}
 	debugfs_create_symlink("dev", nsim_dev_port->ddir, dev_link_name);
 
+	debugfs_create_file("peer", 0600, nsim_dev_port->ddir,
+			    nsim_dev_port, &nsim_dev_peer_fops);
+
 	return 0;
 }
 
@@ -1704,19 +1825,6 @@ void nsim_drv_remove(struct nsim_bus_dev *nsim_bus_dev)
 	dev_set_drvdata(&nsim_bus_dev->dev, NULL);
 }
 
-static struct nsim_dev_port *
-__nsim_dev_port_lookup(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
-		       unsigned int port_index)
-{
-	struct nsim_dev_port *nsim_dev_port;
-
-	port_index = nsim_dev_port_index(type, port_index);
-	list_for_each_entry(nsim_dev_port, &nsim_dev->port_list, list)
-		if (nsim_dev_port->port_index == port_index)
-			return nsim_dev_port;
-	return NULL;
-}
-
 int nsim_drv_port_add(struct nsim_bus_dev *nsim_bus_dev, enum nsim_dev_port_type type,
 		      unsigned int port_index)
 {
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index aecaf5f44374..434322f6a565 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -388,6 +388,7 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
 	ns->nsim_dev = nsim_dev;
 	ns->nsim_dev_port = nsim_dev_port;
 	ns->nsim_bus_dev = nsim_dev->nsim_bus_dev;
+	RCU_INIT_POINTER(ns->peer, NULL);
 	SET_NETDEV_DEV(dev, &ns->nsim_bus_dev->dev);
 	SET_NETDEV_DEVLINK_PORT(dev, &nsim_dev_port->devlink_port);
 	nsim_ethtool_init(ns);
@@ -407,8 +408,13 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
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
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index babb61d7790b..24fc3fbda791 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -125,6 +125,7 @@ struct netdevsim {
 	} udp_ports;
 
 	struct nsim_ethtool ethtool;
+	struct netdevsim __rcu *peer;
 };
 
 struct netdevsim *
-- 
2.39.3


