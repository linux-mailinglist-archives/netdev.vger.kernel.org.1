Return-Path: <netdev+bounces-75944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D44F86BC20
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 00:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8B08B25FD6
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 23:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE0C13D314;
	Wed, 28 Feb 2024 23:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="SeS7lGYT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6859513D306
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 23:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709162579; cv=none; b=qltmkZB4k79/vohwsAOS0fD3/VqKPUf2ArivVhuu5PY4zQXVeOpEuEk/Nlb/TqfI0TywAzLMs/fGQnV68CDxFR97DYfzbZzlSm627ze+EqDCLuJdW7FZ3+h8vGgKMglMhTfWuErA9CTd9wrxSLGjPXUfGzRgNDUMc5FmMTX+Aws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709162579; c=relaxed/simple;
	bh=y1S2eetl14xWG3tddS2FMiEcu4pRLxGLIJD7nUZduQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DfPb65xL1qs6eJpCZu9RzCk+L5sM1cTiEdDcQXZDJcSXKxr3D/Eac6W3/H734lV88WCYkGu72gDBUK7keWVs/ddJvxfUbkoxIZrx5i3yCo3H711Dc3wlO5yY93b7V0+gcAl6yU3SJV73Y5BWvJCd/EpefrmQeT6piyN5ieqkv2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=SeS7lGYT; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-608e0b87594so3055817b3.1
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 15:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1709162576; x=1709767376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEoci8r9fYh9X8Ih0f8ErkspCwERkY2nhtYsuarWoIs=;
        b=SeS7lGYTDE4wSMSylMbin+yUqEKCT2iNbVNp7MOPBQ5xsaDOvHzdPTZZkqcREAdZGT
         XKwAE3H4CPXbKfAxPiBtcpHKNC0t2vAZuKQ6mB7v6KUxz/76gVZMt4Io4Uwp6u4WXvSm
         LM7umvByWkZLLdJyILSTAnp2Xb6tdB8J/WruxV7IorfNcCOGqR7DyG9VEID3bRQTUufP
         q00Ej51BPiM+d7d5nezEJ9tM97IL1nDbCm5YS0wHcUlX9CMYYvC8Ef2zQJ9TxTnOSwWH
         1O+ru8teTpW0AvkPQ3MWihIAsXbTMg3R00zRDeibU9Vw+uCuHlJ882OHD5Sw7EaavIjt
         4f0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709162576; x=1709767376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LEoci8r9fYh9X8Ih0f8ErkspCwERkY2nhtYsuarWoIs=;
        b=Eco4Cu4kBsXdwsM/i8FQiIV1zIUQCBONKKhWDX9oCN7dlLennd0xyVn86gD+32P3UL
         gDuNwEeLg42g1rCUDDJn9JtFDA0dGgsWh3TCpm5A9MFW2RNfRpNPEnI7F21+Zh+hBwFR
         7Oa+9UyIoLpugQI068IhZnbWwRkHPTcLhivSzzfjT/za0QHqeQCbzckDHgbGVPbjrKaM
         oD0e/zV57MVouh1iiqugzpQwDuQKnM7YYAgAfzXaeiIN+OF9hl2is2gjNETGvxTUIORX
         dBof7NU5lCxhrYkOJvaiYBu1irkRliQV2g1fJk4l86ZqnP+UFLPHbichDLhBa0w8hpoR
         jbLw==
X-Forwarded-Encrypted: i=1; AJvYcCVzyBZurdcInQuMi1Ps0Sd0I9Dh6Nghicv4wdJ3ImlLJR1h6T3SMjcyyN7p2Q8FPEl2KyzRlDjlHdZfngYO56XNSwIf5qXU
X-Gm-Message-State: AOJu0YxI3g0MsIW5bLc+/saMxa32EF0WWhcK/WRzu1+QPUO70SAwDRxl
	2LSzFbhcMg6ItFph7kykZeLlfpZiq/CVtshWblhM0jjEqzn+/pim7rauGLccwZo=
X-Google-Smtp-Source: AGHT+IEWlCaGFOxfnYNme0k/rb+Q4cZUqLCOgslY6A2UP+lO1rwExTCZM94ijFoPwM3leW7RaYlq7g==
X-Received: by 2002:a81:4742:0:b0:608:af6:afa4 with SMTP id u63-20020a814742000000b006080af6afa4mr507087ywa.39.1709162576393;
        Wed, 28 Feb 2024 15:22:56 -0800 (PST)
Received: from localhost (fwdproxy-prn-116.fbsv.net. [2a03:2880:ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id d10-20020a81e90a000000b006095684c480sm29190ywm.30.2024.02.28.15.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 15:22:56 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	maciek@machnikowski.net,
	horms@kernel.org,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v14 1/5] netdevsim: allow two netdevsim ports to be connected
Date: Wed, 28 Feb 2024 15:22:49 -0800
Message-ID: <20240228232253.2875900-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228232253.2875900-1-dw@davidwei.uk>
References: <20240228232253.2875900-1-dw@davidwei.uk>
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
 drivers/net/netdevsim/bus.c       | 145 ++++++++++++++++++++++++++++++
 drivers/net/netdevsim/netdev.c    |  10 +++
 drivers/net/netdevsim/netdevsim.h |   2 +
 3 files changed, 157 insertions(+)

diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
index 0c5aff63d242..64c0cdd31bf8 100644
--- a/drivers/net/netdevsim/bus.c
+++ b/drivers/net/netdevsim/bus.c
@@ -232,9 +232,154 @@ del_device_store(const struct bus_type *bus, const char *buf, size_t count)
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
+	err = sscanf(buf, "%d:%u %d:%u", &netnsfd_a, &ifidx_a, &netnsfd_b,
+		     &ifidx_b);
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
+		pr_err("Could not find device with ifindex %u in netnsfd %d\n",
+		       ifidx_a, netnsfd_a);
+		goto out_err;
+	}
+
+	if (!netdev_is_nsim(dev_a)) {
+		pr_err("Device with ifindex %u in netnsfd %d is not a netdevsim\n",
+		       ifidx_a, netnsfd_a);
+		goto out_err;
+	}
+
+	dev_b = __dev_get_by_index(ns_b, ifidx_b);
+	if (!dev_b) {
+		pr_err("Could not find device with ifindex %u in netnsfd %d\n",
+		       ifidx_b, netnsfd_b);
+		goto out_err;
+	}
+
+	if (!netdev_is_nsim(dev_b)) {
+		pr_err("Device with ifindex %u in netnsfd %d is not a netdevsim\n",
+		       ifidx_b, netnsfd_b);
+		goto out_err;
+	}
+
+	if (dev_a == dev_b) {
+		pr_err("Cannot link a netdevsim to itself\n");
+		goto out_err;
+	}
+
+	err = -EBUSY;
+	nsim_a = netdev_priv(dev_a);
+	peer = rtnl_dereference(nsim_a->peer);
+	if (peer) {
+		pr_err("Netdevsim %d:%u is already linked\n", netnsfd_a,
+		       ifidx_a);
+		goto out_err;
+	}
+
+	nsim_b = netdev_priv(dev_b);
+	peer = rtnl_dereference(nsim_b->peer);
+	if (peer) {
+		pr_err("Netdevsim %d:%u is already linked\n", netnsfd_b,
+		       ifidx_b);
+		goto out_err;
+	}
+
+	err = 0;
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
+		pr_err("Could not find device with ifindex %u in netnsfd %d\n",
+		       ifidx, netnsfd);
+		goto out_put_netns;
+	}
+
+	if (!netdev_is_nsim(dev)) {
+		pr_err("Device with ifindex %u in netnsfd %d is not a netdevsim\n",
+		       ifidx, netnsfd);
+		goto out_put_netns;
+	}
+
+	nsim = netdev_priv(dev);
+	peer = rtnl_dereference(nsim->peer);
+	if (!peer)
+		goto out_put_netns;
+
+	err = 0;
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
2.43.0


