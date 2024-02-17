Return-Path: <netdev+bounces-72615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8687858D47
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 06:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 301D8B21DE3
	for <lists+netdev@lfdr.de>; Sat, 17 Feb 2024 05:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBF91C6AE;
	Sat, 17 Feb 2024 05:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="mgapmY7j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EF54A0A
	for <netdev@vger.kernel.org>; Sat, 17 Feb 2024 05:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708146263; cv=none; b=KItBzduoSAIAeMlNPAgBn22mtfnvd4yJD7nfOFkNO/eUNjnh+1v8uZs6x5c0uA0QBkRzGmXAWGxoo0cZGCItTeJhEZDe8zkKBuprEIX2dIuylWlKZS2uPEAD80pjY+0+VIcZYEiBQa8j9vIOHF+5lb0Rible5rR57Q+T7GEcp1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708146263; c=relaxed/simple;
	bh=PlrDauaSXJsrUEEP+2vAcDcSxafWJS7CE1uKjTQJTgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SNMiRn7FhahZJLV8Jwy9mhGTniI0ObZ3C/F3TJnEkhMQn3yxrZeLCBn/2+6sAgCg0urVOZDCgTKmh9B4j4ClMIBj0RjPUucB2rowj5bkF1hIhxBLoyl15+Km7tDiHFrpY4cHZ2YUHTEDuwV2qJkFgU3pJL2bMqtivCYLTtIi9SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=mgapmY7j; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-204f50f305cso1950600fac.3
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 21:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1708146261; x=1708751061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=McQEsHhHuU9oKMyDS4+y8U0TmMMTqMmyMgH+jRxqi8g=;
        b=mgapmY7jLCvLUXi3y82RM444zu0XRdNx384BpflYQi7yPkbIRvxuJ2KhPuZ0lmQS/m
         f6rDO0gVLCglklonI7q3Es6rIq/chRL8c37BBZxw9HbvT2IBRteXTizHsX2KjGAY64fH
         Oxj/Jjrr9zty29CBDUgIS1QZv9Sbt2t/cMKv1lx4ZmwnI7LHfZsFoHx9YfAqeuW8GNrb
         kHhTXWCQ/0R4BUk+9mzNK0mMRMCSFaGUkKH8A/ADgY/c6YVQTLeHlEAbNXT45QbJ0A99
         mUkrUtNy2gbem+aceTSLR4nFbudvm+Vv7xVsJ2A6EuAna8YFzwwsjrFpTGfi4ynvdI0k
         oTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708146261; x=1708751061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=McQEsHhHuU9oKMyDS4+y8U0TmMMTqMmyMgH+jRxqi8g=;
        b=bpk1Gl+N3cCbNE+TnafjfAzGiiTnqcaY89ZEDZtXP9xkllJg2ielFCYUXQKLKVGBEB
         cr4OXTzfNlLsIV89R8RkvdN3MDApSzYWBvu6AAK4mFyflkrtZQFIiw4pZ2mOLdV7F5cf
         1doTkmxwhef76LZToU50pEgaaAEjBry+nAFvxl3CBzvJX3kw8D/jJsNIt9CjEuZO23s4
         Xpfi1HgtdbqAy7olzgYKUacAzim6IImv2njni9eGTfbNIDDu5xvL2o9XhLyDzR3PW/om
         nd++PgvaUUrgh0xLT+Wqg4GW6hbQkOtTflEDXYPaSzCRGJFFTYgRTI0ZmYUwmig9eywW
         OLXA==
X-Forwarded-Encrypted: i=1; AJvYcCVamdAOfUaipveQFbczhG2yiuw+OaxpKC0OWWVyqRlTkeYtQQAg6F7FcPEbgk+jJlFKSJhv7kP66R60y8ht6pCpD9inyTV0
X-Gm-Message-State: AOJu0YzcPufBq+qQcp6oIF2x+LEmFm/zXarFHprbI8BBOX0/jpwUGiR/
	q0SaUYnQYLOp5bsDj7ZPp+zq1heoxTdGriGVozIVhNMdf2sWigIukDicGGl73tY=
X-Google-Smtp-Source: AGHT+IHc6e2Mx9sABYHzDGutuoapfmSoQfjpyxjsbraSjdBN3ZMP7LVYAYT3l0GFlP0ar4wQnxvapg==
X-Received: by 2002:a05:6870:8a06:b0:219:2d44:5db7 with SMTP id p6-20020a0568708a0600b002192d445db7mr7391692oaq.45.1708146261118;
        Fri, 16 Feb 2024 21:04:21 -0800 (PST)
Received: from localhost (fwdproxy-prn-018.fbsv.net. [2a03:2880:ff:12::face:b00c])
        by smtp.gmail.com with ESMTPSA id f2-20020a656282000000b005c662e103a1sm622918pgv.41.2024.02.16.21.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 21:04:20 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v12 1/4] netdevsim: allow two netdevsim ports to be connected
Date: Fri, 16 Feb 2024 21:04:15 -0800
Message-Id: <20240217050418.3125504-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240217050418.3125504-1-dw@davidwei.uk>
References: <20240217050418.3125504-1-dw@davidwei.uk>
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
index aedab1d9623a..438b862cb577 100644
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
+		put_net(ns_a);
+		return -EINVAL;
+	}
+
+	err = -EINVAL;
+	rtnl_lock();
+	dev_a = __dev_get_by_index(ns_a, ifidx_a);
+	if (!dev_a) {
+		pr_err("Could not find device with ifindex %u in netnsfd %d\n", ifidx_a, netnsfd_a);
+		goto out_err;
+	}
+
+	if (!netdev_is_nsim(dev_a)) {
+		pr_err("Device with ifindex %u in netnsfd %d is not a netdevsim\n", ifidx_a, netnsfd_a);
+		goto out_err;
+	}
+
+	dev_b = __dev_get_by_index(ns_b, ifidx_b);
+	if (!dev_b) {
+		pr_err("Could not find device with ifindex %u in netnsfd %d\n", ifidx_b, netnsfd_b);
+		goto out_err;
+	}
+
+	if (!netdev_is_nsim(dev_b)) {
+		pr_err("Device with ifindex %u in netnsfd %d is not a netdevsim\n", ifidx_b, netnsfd_b);
+		goto out_err;
+	}
+
+	if (dev_a == dev_b) {
+		pr_err("Cannot link a netdevsim to itself\n");
+		goto out_err;
+	}
+
+	err = 0;
+	nsim_a = netdev_priv(dev_a);
+	peer = rtnl_dereference(nsim_a->peer);
+	if (peer) {
+		pr_err("Netdevsim %d:%u is already linked\n", netnsfd_a, ifidx_a);
+		goto out_err;
+	}
+
+	nsim_b = netdev_priv(dev_b);
+	peer = rtnl_dereference(nsim_b->peer);
+	if (peer) {
+		pr_err("Netdevsim %d:%u is already linked\n", netnsfd_b, ifidx_b);
+		goto out_err;
+	}
+
+	rcu_assign_pointer(nsim_a->peer, nsim_b);
+	rcu_assign_pointer(nsim_b->peer, nsim_a);
+
+out_err:
+	put_net(ns_b);
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


