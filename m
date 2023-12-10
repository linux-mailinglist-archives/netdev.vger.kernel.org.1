Return-Path: <netdev+bounces-55583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E1980B842
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 02:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52B28280F2C
	for <lists+netdev@lfdr.de>; Sun, 10 Dec 2023 01:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C47368;
	Sun, 10 Dec 2023 01:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="kA7dJMJq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD26FE
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 17:04:54 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-286d6c95b8cso3262115a91.0
        for <netdev@vger.kernel.org>; Sat, 09 Dec 2023 17:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1702170294; x=1702775094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Urjueb9GWfRKCUtnogLF8xlESFGo3375daOG48rl+n0=;
        b=kA7dJMJqHcphGYcyhCTK4qDQbIwqLmke6Km/fuQYp6uvyzdoeI19JJTP1+Sp8LHfnz
         IOhDCgYpyVNQXPMqA5JpXgNu2hVTPuX/QlqKSEiKcHw92DoS0yRu8LldBeCSgjBxFgV+
         LtVZ/Y1JmSkXzrLf4GBEQCTcm4yKpiVMlAgFOqtPHVon2J89Or0B/b4b5ulGus5DjQUj
         cMveKEJiNzkHypZkLUhVPWkcJvtHQMPFVPPZJzbDdeDTcn51R58GG98R9xetYhS0DeE/
         U9rPVfsuL3M7CrgenrGcaM0oxt4fpnH09rdSudZo4R3IkhRlhqSbiWujr6NpcIPuNneq
         LTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702170294; x=1702775094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Urjueb9GWfRKCUtnogLF8xlESFGo3375daOG48rl+n0=;
        b=bq9HvN0qBk++Q8bEVOIjz7pJg31vyvxG6GVbTqHblCxzItiZRy/LsOMst9AcEL37vJ
         sKtSkDAVJdePrOF2Xv0Gpnh0Xxm4A0NyUJcfnmhlYIXFI0xnUFty/tQoUhl2bEx/kqzD
         2P/m2qc7lqhMz1ql6yUXo3XsyZ+2UwlFDY5AhvnnsJw/OftD98d8SaxxC1ietJ6M8bAq
         M+nYPCz7XyiHoF4W+Sk7j9rAOi4/+egciyTFMHoNSWh397hf64LYdYTzZRcKcT9lFew3
         w3IBy83+P8+bijAyfjBYgegx30TNyxTGTRbstFP7/DpqPEUcc0089wIxlMJraUDflvJL
         EJkQ==
X-Gm-Message-State: AOJu0Yy1JptBLCBriioD5FB+HtVN9LjMqKIBI6jaDXSWiYZadH8+Rhxv
	x7W8KRAyDz3H1YW3Gg6wIMtsqw==
X-Google-Smtp-Source: AGHT+IGNuP18hFe07NdXZmxdkToykSf4D7MhH8ZcS96adOTD3N6M3deg5Hj8VlHgR6til4eYANyeFQ==
X-Received: by 2002:a17:902:7e82:b0:1d0:9416:efb7 with SMTP id z2-20020a1709027e8200b001d09416efb7mr2383123pla.108.1702170293717;
        Sat, 09 Dec 2023 17:04:53 -0800 (PST)
Received: from localhost (fwdproxy-prn-019.fbsv.net. [2a03:2880:ff:13::face:b00c])
        by smtp.gmail.com with ESMTPSA id x24-20020a170902821800b001d0c418174fsm3933659pln.117.2023.12.09.17.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 17:04:53 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 1/3] netdevsim: allow two netdevsim ports to be connected
Date: Sat,  9 Dec 2023 17:04:46 -0800
Message-Id: <20231210010448.816126-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231210010448.816126-1-dw@davidwei.uk>
References: <20231210010448.816126-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Wei <davidhwei@meta.com>

Add a debugfs file in
/sys/kernel/debug/netdevsim/netdevsimN/ports/A/peer

Writing "M B" to this file will link port A of netdevsim N with port B of
netdevsim M.

Reading this file will return the linked netdevsim id and port, if any.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/netdevsim/bus.c       | 10 ++++
 drivers/net/netdevsim/dev.c       | 85 +++++++++++++++++++++++++++++++
 drivers/net/netdevsim/netdev.c    |  6 +++
 drivers/net/netdevsim/netdevsim.h |  3 ++
 4 files changed, 104 insertions(+)

diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
index bcbc1e19edde..3e4378e9dbee 100644
--- a/drivers/net/netdevsim/bus.c
+++ b/drivers/net/netdevsim/bus.c
@@ -364,3 +364,13 @@ void nsim_bus_exit(void)
 	driver_unregister(&nsim_driver);
 	bus_unregister(&nsim_bus);
 }
+
+struct nsim_bus_dev *nsim_bus_dev_get(unsigned int id)
+{
+	struct nsim_bus_dev *nsim_bus_dev;
+	list_for_each_entry(nsim_bus_dev, &nsim_bus_dev_list, list) {
+		if (nsim_bus_dev->dev.id == id)
+			return nsim_bus_dev;
+	}
+	return NULL;
+}
diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index b4d3b9cde8bd..7af219ff6fa9 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -388,6 +388,88 @@ static const struct file_operations nsim_dev_rate_parent_fops = {
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
+		len = scnprintf(buf, sizeof(buf), "\n");
+		goto out;
+	}
+
+	id = peer->nsim_bus_dev->dev.id;
+	port = peer->nsim_dev_port->port_index;
+	len = scnprintf(buf, sizeof(buf), "%u %u\n", id, port);
+
+out:
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
+	/* cannot link to self */
+	nsim_dev_port = file->private_data;
+	if (nsim_dev_port->ns->nsim_bus_dev == peer_bus_dev &&
+	    nsim_dev_port->port_index == port)
+		return -EINVAL;
+
+	peer_dev = dev_get_drvdata(&peer_bus_dev->dev);
+	list_for_each_entry(peer_dev_port, &peer_dev->port_list, list) {
+		if (peer_dev_port->port_index != port)
+			continue;
+		rcu_assign_pointer(nsim_dev_port->ns->peer, peer_dev_port->ns);
+		rcu_assign_pointer(peer_dev_port->ns->peer, nsim_dev_port->ns);
+		return count;
+	}
+
+	return -EINVAL;
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
@@ -418,6 +500,9 @@ static int nsim_dev_port_debugfs_init(struct nsim_dev *nsim_dev,
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
index 028c825b86db..2601c3ad1d17 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -125,6 +125,7 @@ struct netdevsim {
 	} udp_ports;
 
 	struct nsim_ethtool ethtool;
+	struct netdevsim __rcu *peer;
 };
 
 struct netdevsim *
@@ -417,3 +418,5 @@ struct nsim_bus_dev {
 
 int nsim_bus_init(void);
 void nsim_bus_exit(void);
+
+struct nsim_bus_dev *nsim_bus_dev_get(unsigned int id);
-- 
2.39.3


