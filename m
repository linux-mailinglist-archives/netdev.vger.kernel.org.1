Return-Path: <netdev+bounces-57669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A13813C8F
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 22:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E70B1281733
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 21:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D106DD0A;
	Thu, 14 Dec 2023 21:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Cyf3iykr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EE86DCE2
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 21:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6d099d316a8so4811293b3a.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 13:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1702589093; x=1703193893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfxMwaDm/UpAh8oyv+FTsTMGaJLyPSpoOmUmbTmoPUs=;
        b=Cyf3iykr9LHtJiO7lvTE5W1jYqxhZ/lGXBlUpgZtGVYuAurBydEEYyFi96oc36U79W
         QNN0t95661zD2t3Ut39NDy1AbYpaXS1iYMJKR5nu0I8bzzDLnVvSUJGwLuhN3/pn0u1V
         PDRYK1+12gYnbWvtVhNXWgTtoa39FJ/mI5HVUHROssvmcuN8WXjglJ/IdE5FA6jL6QqP
         hOMVq9KiYgU3GCnUfhT2zzuhTI1YZwCj+tPjXkeRCK0yOuOu/oFs5EwdE7ZB9kQ3ZXE1
         aLi1q72mEmPKQrmOiI8OgItgSTVPbGPr1M7PstKEDf+BIUv/Frdcx4lyGaQgXDVkkBrf
         iDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702589093; x=1703193893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfxMwaDm/UpAh8oyv+FTsTMGaJLyPSpoOmUmbTmoPUs=;
        b=HVtykzYXkL+ayzIVBRME1papt/OZOqvHR+v/Fjqfd34VaP1q3zwMqrMcgGVX7tPPy+
         jEFHwLXTzUjNWWeKPz/KlnYnbuOlKR1ORMhrrStYCUVrGzXMjheyYSNp2Z3uWfMXaRjA
         EcTgl+tGJ2dr5E4a6SG4Awuk7kD8myg4p+d/dngwDR9PjF+2JoHZk+Ga9qsKNSda2OsQ
         DXgBct5TtCLrKD5nf9QGbYZGc5bhbSwYTC1LCJdJi3ilBzqhMZPvPukWE6ijvmH17q8l
         qNoLiYDjb/aQhnt2vL9HYeJ0d05v3wum4NYq5/6vL1+8J7x4KqWasq01Y+S4+URXGJeP
         KrOw==
X-Gm-Message-State: AOJu0YwsM29bU8gzZ5BLtCnvUfwOUJMM133YfXxOsI0IpOJHrIAT2dr8
	uwY6LgeOBUD+Orro6ek+nE+mdQ==
X-Google-Smtp-Source: AGHT+IGgXqBBN+R+Av4CbpIbqg/owIy3ACk/aT0wccs7JZkjAcD5V5GenL7Ri4T50Xb8/ER3hYV7Kw==
X-Received: by 2002:a05:6a00:ccd:b0:6ce:6f37:fa42 with SMTP id b13-20020a056a000ccd00b006ce6f37fa42mr13716761pfv.12.1702589093703;
        Thu, 14 Dec 2023 13:24:53 -0800 (PST)
Received: from localhost (fwdproxy-prn-007.fbsv.net. [2a03:2880:ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id t27-20020a056a00139b00b006cd08377a13sm12173554pfg.190.2023.12.14.13.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 13:24:53 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v3 1/4] netdevsim: allow two netdevsim ports to be connected
Date: Thu, 14 Dec 2023 13:24:40 -0800
Message-Id: <20231214212443.3638210-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231214212443.3638210-1-dw@davidwei.uk>
References: <20231214212443.3638210-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a debugfs file in
/sys/kernel/debug/netdevsim/netdevsimN/ports/A/peer

Writing "M B" to this file will link port A of netdevsim N with port B of
netdevsim M.

Reading this file will return the linked netdevsim id and port, if any.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/netdevsim/bus.c       | 17 ++++++
 drivers/net/netdevsim/dev.c       | 88 +++++++++++++++++++++++++++++++
 drivers/net/netdevsim/netdev.c    |  6 +++
 drivers/net/netdevsim/netdevsim.h |  3 ++
 4 files changed, 114 insertions(+)

diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
index bcbc1e19edde..1ef95661a3f5 100644
--- a/drivers/net/netdevsim/bus.c
+++ b/drivers/net/netdevsim/bus.c
@@ -323,6 +323,23 @@ static struct device_driver nsim_driver = {
 	.owner		= THIS_MODULE,
 };
 
+struct nsim_bus_dev *nsim_bus_dev_get(unsigned int id)
+{
+	struct nsim_bus_dev *nsim_bus_dev;
+
+	mutex_lock(&nsim_bus_dev_list_lock);
+	list_for_each_entry(nsim_bus_dev, &nsim_bus_dev_list, list) {
+		if (nsim_bus_dev->dev.id == id) {
+			get_device(&nsim_bus_dev->dev);
+			mutex_unlock(&nsim_bus_dev_list_lock);
+			return nsim_bus_dev;
+		}
+	}
+	mutex_unlock(&nsim_bus_dev_list_lock);
+
+	return NULL;
+}
+
 int nsim_bus_init(void)
 {
 	int err;
diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index b4d3b9cde8bd..034145ba1861 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -388,6 +388,91 @@ static const struct file_operations nsim_dev_rate_parent_fops = {
 	.owner = THIS_MODULE,
 };
 
+static ssize_t nsim_dev_peer_read(struct file *file, char __user *data,
+				  size_t count, loff_t *ppos)
+{
+	struct nsim_dev_port *nsim_dev_port;
+	struct netdevsim *peer;
+	unsigned int id, port;
+	char buf[23];
+	ssize_t len;
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
+	len = scnprintf(buf, sizeof(buf), "%u %u\n", id, port);
+
+	rcu_read_unlock();
+	return simple_read_from_buffer(data, count, ppos, buf, len);
+}
+
+static ssize_t nsim_dev_peer_write(struct file *file,
+				   const char __user *data,
+				   size_t count, loff_t *ppos)
+{
+	struct nsim_dev_port *nsim_dev_port, *peer_dev_port;
+	struct nsim_bus_dev *peer_bus_dev;
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
+		pr_err("Format for adding a peer is \"id port\" (uint uint)");
+		return -EINVAL;
+	}
+
+	/* invalid netdevsim id */
+	peer_bus_dev = nsim_bus_dev_get(id);
+	if (!peer_bus_dev)
+		return -EINVAL;
+
+	ret = -EINVAL;
+	/* cannot link to self */
+	nsim_dev_port = file->private_data;
+	if (nsim_dev_port->ns->nsim_bus_dev == peer_bus_dev &&
+	    nsim_dev_port->port_index == port)
+		goto out;
+
+	peer_dev = dev_get_drvdata(&peer_bus_dev->dev);
+	list_for_each_entry(peer_dev_port, &peer_dev->port_list, list) {
+		if (peer_dev_port->port_index != port)
+			continue;
+		rcu_assign_pointer(nsim_dev_port->ns->peer, peer_dev_port->ns);
+		rcu_assign_pointer(peer_dev_port->ns->peer, nsim_dev_port->ns);
+		ret = count;
+		goto out;
+	}
+
+out:
+	put_device(&peer_bus_dev->dev);
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
@@ -418,6 +503,9 @@ static int nsim_dev_port_debugfs_init(struct nsim_dev *nsim_dev,
 	}
 	debugfs_create_symlink("dev", nsim_dev_port->ddir, dev_link_name);
 
+	debugfs_create_file("peer", 0600, nsim_dev_port->ddir,
+			    nsim_dev_port, &nsim_dev_peer_fops);
+
 	return 0;
 }
 
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index aecaf5f44374..e290c54b0e70 100644
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
@@ -407,9 +408,14 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
 void nsim_destroy(struct netdevsim *ns)
 {
 	struct net_device *dev = ns->netdev;
+	struct netdevsim *peer;
 
 	rtnl_lock();
+	peer = rtnl_dereference(ns->peer);
+	RCU_INIT_POINTER(ns->peer, NULL);
 	unregister_netdevice(dev);
+	if (peer)
+		RCU_INIT_POINTER(peer->peer, NULL);
 	if (nsim_dev_port_is_pf(ns->nsim_dev_port)) {
 		nsim_macsec_teardown(ns);
 		nsim_ipsec_teardown(ns);
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 028c825b86db..61ac3a80cf9a 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -125,6 +125,7 @@ struct netdevsim {
 	} udp_ports;
 
 	struct nsim_ethtool ethtool;
+	struct netdevsim __rcu *peer;
 };
 
 struct netdevsim *
@@ -415,5 +416,7 @@ struct nsim_bus_dev {
 	bool init;
 };
 
+struct nsim_bus_dev *nsim_bus_dev_get(unsigned int id);
+
 int nsim_bus_init(void);
 void nsim_bus_exit(void);
-- 
2.39.3


