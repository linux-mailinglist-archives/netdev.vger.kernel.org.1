Return-Path: <netdev+bounces-67350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A07842EC4
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 22:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66B0E288CB5
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 21:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E87778B76;
	Tue, 30 Jan 2024 21:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="CQR/DxOd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8A514F61
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 21:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651186; cv=none; b=JJzlQD6JH3tYrj0U3WUuMlrabbvbc668Umc+pru6G+CeVMZtPtgDOJLT4/FMbuQJVhrr7AfvU/EJGCnTmgHjc19VnEYrMXJ4TnCwGP+h1fU9+HnI/F8qvuW29aTdKbjl1EP3Bt9ntoxdtBllA6vID9lFD4z/5NN8DWwu6qWfXxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651186; c=relaxed/simple;
	bh=uRqIih7HbMmsHIZREdM8+dFjPy/z+ERnHQRkPvSv22o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p+KLicbellbqz68XoGFndUrXnGseyxmvemY5eANs2tIt+DfGEwAjSEYizF7hyUfECTacZhs0Pd0iaMyCZj3svARln5GcEUCtkqfZg6B86yA6dt8w1Nn0U/JV6twd84yFBNLNq0Xuwvd5dni/pHzM4e2w1RjpurruQepCS1Ww14E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=CQR/DxOd; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-21432e87455so2712001fac.1
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 13:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1706651183; x=1707255983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXSlukVqYZVwFSmz/UgYPWSS8sRjQNlTzTCQ7rbEX1U=;
        b=CQR/DxOdr5SWCjDL9DF6VL8OcIJWWbwppI94I8QJNL8INQd4mE6TZNEhnruCp1h/aT
         sOFoL1rLilC+YluvvtGroYgQdsp9ycpG/WtPbDwTi7VjphP48Jljpx8aiKvb7NU6Tr90
         KiVqzMALAr6vvXCRQjg8hoK7zHD7Nxgq97knFzpK+xWcvBM2/z8GEQ2X2NVWMfQjQV6l
         V5R4KZSmaahgRoLb898in0FAGSu63F4S1GY9zL56YJMrIf1WFIDUIjGv0SQNE5ysORVC
         jUYI5ttVrVeh/sCgSZ1erL2llo5k2cCLcK9wrRAAoycVqVqvANn/3jbR5wCG1bgj8n6k
         1X5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706651183; x=1707255983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXSlukVqYZVwFSmz/UgYPWSS8sRjQNlTzTCQ7rbEX1U=;
        b=tcmwO0k7x414HkCN4KVDCpZRwqbARiCzartV9n6L42/0j2puyfagdDRwC+nIaEe+Rs
         g+TSp/k2uBRQshlu+vnamNUkwqRUacGovUIS5VBF1eb4GiJdFHZ4M+jOA7o1r5T861QJ
         RAWzuvpyuL+Zsh6ayVTqUMQtqna/iDRrCJSOPfAdPYD7faq7EuWqlDAbnLs/8hjsszKh
         ftxKZ7kzkSXS069ObSfndl0IJQKUKwHig3x0g8XoKf8ecenGc2arDiAb8R+4XUnKxRvP
         0XL68Rb/tkwmtB8oRQFKX/Pc3w+ItbS0pS0v5txgyx6yVlpJkDFMqLym+7uq4YVovgo4
         vQZw==
X-Gm-Message-State: AOJu0Yx0VUC6MXoHXn1WPfLvLOuOoLFCWUdqQJGZbE46/2DmIAPEgg+i
	Kvd5wLMvPo2uLPgRX6JQQcPGo7z7/o8Yg9DfVcRfxwNlyX2azjXSc6wLUrbQVuA=
X-Google-Smtp-Source: AGHT+IEzcUz/R9XiZOyRAtsPE9715/NceNJ+7u0TwNuL4Z+T8TqdnRdhQGfa89kyv7TvfN3PcD+KtQ==
X-Received: by 2002:a05:6871:5b0d:b0:218:73ae:30dc with SMTP id op13-20020a0568715b0d00b0021873ae30dcmr486166oac.54.1706651183225;
        Tue, 30 Jan 2024 13:46:23 -0800 (PST)
Received: from localhost (fwdproxy-prn-023.fbsv.net. [2a03:2880:ff:17::face:b00c])
        by smtp.gmail.com with ESMTPSA id i17-20020a63e451000000b005d8b8efac4csm6398596pgk.85.2024.01.30.13.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:46:22 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v8 1/4] netdevsim: allow two netdevsim ports to be connected
Date: Tue, 30 Jan 2024 13:46:17 -0800
Message-Id: <20240130214620.3722189-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240130214620.3722189-1-dw@davidwei.uk>
References: <20240130214620.3722189-1-dw@davidwei.uk>
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
 drivers/net/netdevsim/bus.c       | 132 ++++++++++++++++++++++++++++++
 drivers/net/netdevsim/netdev.c    |  11 +++
 drivers/net/netdevsim/netdevsim.h |   2 +
 3 files changed, 145 insertions(+)

diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
index bcbc1e19edde..57e28801bb51 100644
--- a/drivers/net/netdevsim/bus.c
+++ b/drivers/net/netdevsim/bus.c
@@ -232,9 +232,141 @@ del_device_store(const struct bus_type *bus, const char *buf, size_t count)
 }
 static BUS_ATTR_WO(del_device);
 
+static ssize_t link_device_store(const struct bus_type *bus, const char *buf, size_t count)
+{
+	unsigned int netnsid_a, netnsid_b, ifidx_a, ifidx_b;
+	struct netdevsim *nsim_a, *nsim_b, *peer;
+	struct net_device *dev_a, *dev_b;
+	struct net *ns_a, *ns_b;
+	int err;
+
+	err = sscanf(buf, "%u:%u %u:%u", &netnsid_a, &ifidx_a, &netnsid_b, &ifidx_b);
+	if (err != 4) {
+		pr_err("Format for linking two devices is \"netnsid_a:ifidx_a netnsid_b:ifidx_b\" (uint uint unit uint).\n");
+		return -EINVAL;
+	}
+
+	err = -EINVAL;
+	rtnl_lock();
+	ns_a = get_net_ns_by_id(current->nsproxy->net_ns, netnsid_a);
+	if (!ns_a) {
+		pr_err("Could not find netns with id: %u\n", netnsid_a);
+		goto out_unlock_rtnl;
+	}
+
+	dev_a = __dev_get_by_index(ns_a, ifidx_a);
+	if (!dev_a) {
+		pr_err("Could not find device with ifindex %u in netnsid %u\n", ifidx_a, netnsid_a);
+		goto out_put_netns_a;
+	}
+
+	if (!netdev_is_nsim(dev_a)) {
+		pr_err("Device with ifindex %u in netnsid %u is not a netdevsim\n", ifidx_a, netnsid_a);
+		goto out_put_netns_a;
+	}
+
+	ns_b = get_net_ns_by_id(current->nsproxy->net_ns, netnsid_b);
+	if (!ns_b) {
+		pr_err("Could not find netns with id: %u\n", netnsid_b);
+		goto out_put_netns_a;
+	}
+
+	dev_b = __dev_get_by_index(ns_b, ifidx_b);
+	if (!dev_b) {
+		pr_err("Could not find device with ifindex %u in netnsid %u\n", ifidx_b, netnsid_b);
+		goto out_put_netns_b;
+	}
+
+	if (!netdev_is_nsim(dev_b)) {
+		pr_err("Device with ifindex %u in netnsid %u is not a netdevsim\n", ifidx_b, netnsid_b);
+		goto out_put_netns_b;
+	}
+
+	err = 0;
+	nsim_a = netdev_priv(dev_a);
+	peer = rtnl_dereference(nsim_a->peer);
+	if (peer) {
+		pr_err("Netdevsim %u:%u is already linked\n", netnsid_a, ifidx_a);
+		goto out_put_netns_b;
+	}
+
+	nsim_b = netdev_priv(dev_b);
+	peer = rtnl_dereference(nsim_b->peer);
+	if (peer) {
+		pr_err("Netdevsim %u:%u is already linked\n", netnsid_b, ifidx_b);
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
+out_unlock_rtnl:
+	rtnl_unlock();
+
+	return !err ? count : err;
+}
+static BUS_ATTR_WO(link_device);
+
+static ssize_t unlink_device_store(const struct bus_type *bus, const char *buf, size_t count)
+{
+	struct netdevsim *nsim, *peer;
+	unsigned int netnsid, ifidx;
+	struct net_device *dev;
+	struct net *ns;
+	int err;
+
+	err = sscanf(buf, "%u:%u", &netnsid, &ifidx);
+	if (err != 2) {
+		pr_err("Format for unlinking a device is \"netnsid:ifidx\" (uint uint).\n");
+		return -EINVAL;
+	}
+
+	err = -EINVAL;
+	rtnl_lock();
+	ns = get_net_ns_by_id(current->nsproxy->net_ns, netnsid);
+	if (!ns) {
+		pr_err("Could not find netns with id: %u\n", netnsid);
+		goto out_unlock_rtnl;
+	}
+
+	dev = __dev_get_by_index(ns, ifidx);
+	if (!dev) {
+		pr_err("Could not find device with ifindex %u in netnsid %u\n", ifidx, netnsid);
+		goto out_put_netns;
+	}
+
+	if (!netdev_is_nsim(dev)) {
+		pr_err("Device with ifindex %u in netnsid %u is not a netdevsim\n", ifidx, netnsid);
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
+out_unlock_rtnl:
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
index 77e8250282a5..57883773e4fb 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -333,6 +333,7 @@ static int nsim_init_netdevsim(struct netdevsim *ns)
 		goto err_phc_destroy;
 
 	rtnl_lock();
+	RCU_INIT_POINTER(ns->peer, NULL);
 	err = nsim_bpf_init(ns);
 	if (err)
 		goto err_utn_destroy;
@@ -413,8 +414,13 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
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
@@ -427,6 +433,11 @@ void nsim_destroy(struct netdevsim *ns)
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


