Return-Path: <netdev+bounces-73881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B03D85F0B7
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 06:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A2B3284F48
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 05:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8799E6FB5;
	Thu, 22 Feb 2024 05:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="2p8XIf6n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E439553AC
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 05:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708578525; cv=none; b=S3akyygA2OyJXwGPIvpcBCeGhoIjCqwt6ULqtyDr8sz2PwFYdu/7EznuRwMQwRDzmKhm0zxk6sPec4Ioe9ov4CcEZU4Dl+Se6Cs3uspeczEHIZtpI8yWWMyxi6EmMWboxFrGKpBMRByRICAckV/s740yOx0RPM151obD0goZcwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708578525; c=relaxed/simple;
	bh=8zlsgHn01/nTBoGvTvVbQPv/D/gUieZwvJy7J3dtx6c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rzdy1GLQY3FAkNK0ma9L3sBR4tCJ4JpwrMBACcebljmLNlgSEF53ubx7eZQGco9EXuWkT0P6WHUB2cQmglSSZGLjaMJRkBCKb5tt3vNsOfpYeGfH6CpI3xE+UlGm9oxgHZFaSF4e6lmaaQD+JpuJO5QX3lkVbajf2etQkt+huXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=2p8XIf6n; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e3ffafa708so4660249b3a.1
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 21:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1708578523; x=1709183323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdfR7zWvyTebUkxzjTusqS23eJLm6NJsG7DbC2Ao9DQ=;
        b=2p8XIf6nX9YNnGd+eAvAvsEKo85JV1FIbsUVsd6hYy6IS1r9yKybsxBr6QkQW+Fs9q
         yUgpPJ1eiL0V3Mu/QAjw1cGfucOMt/dV9Kxz39iFiuL5UD1lWAlpshUcS5EVZeRwPcT8
         b29Jsv5yvtxS0X0Gttm8IGiMPYYe0kAeXHXWlsH7q1vPoNDvAPLY3op1vuxjGPlUsG1H
         pH2PijjDrL1BxinAgDygSrlBGFDep7K+UuWSQq94GWC/AEppK19jr6di/EnRTzi7vtrs
         OMa0jUjIEEJsr8/VCkbkcAB27RsyHA/qaSzT0+t2WF5kCwmhbqiqHltd5WM6yPtPFkOC
         9DnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708578523; x=1709183323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdfR7zWvyTebUkxzjTusqS23eJLm6NJsG7DbC2Ao9DQ=;
        b=kkAVcJ+S74LqIGj98AMHL7bTuN7ksvk6xmtDDl4qPFwJBqQ4qO7Bh3ZXvTWAjESosx
         R8BTD1WAYRgIFhSMfvkXJDSqjQDvxeVg2xMAUzKj5qTKQQLpAxmpk4pdS2xpZU5tlfGH
         dIMDodI3olAC78lLTPuvN5+Fvzk/la5H2zoEqti2rJQG6H20RCkBJE/6PqxdyoW7c+W+
         x8UWLmj5DKd3YeqgOd4JgZ8021lpFreVK7gffXWrVR8ww0c09Fzk/CUDA0j1YAwy59lr
         e94vZbEuiz34mpGr3sgt3fc+8RO+Ea/t3C/mVZdjbQlcN0cjFKq5t1ssiODXg31CpaZ2
         2mjw==
X-Forwarded-Encrypted: i=1; AJvYcCURS7O1ik1UJ3cRrZ8YKyUKJ3cIDoGX6kjjAy9op/HGWiJc0GuSyoP8jtC9ufl1s4uanrYnczvj9VgQuT5c5VQhNwcTGVC+
X-Gm-Message-State: AOJu0Ywn4ByVeaEV6KlGYLMs1tjEkqVtxhqlfWWMnPeE3WT15zzCH7AQ
	zx24Ih/dYyqdsY+dkDWdUofoHCGeolCISKOvIWhYy9j34hOvrmNrTaj09Zqu3VL9JYpVsqwPoqO
	f
X-Google-Smtp-Source: AGHT+IFWTBusrNRHO5IBjDNrAobRHNtcJceBeZebbEbJgeh9YHQ++csfKWiDgiztjw7Ngy9JnER5wg==
X-Received: by 2002:aa7:8b47:0:b0:6e1:3ab9:614c with SMTP id i7-20020aa78b47000000b006e13ab9614cmr17397524pfd.16.1708578523245;
        Wed, 21 Feb 2024 21:08:43 -0800 (PST)
Received: from localhost (fwdproxy-prn-014.fbsv.net. [2a03:2880:ff:e::face:b00c])
        by smtp.gmail.com with ESMTPSA id z16-20020a62d110000000b006e38ea2e058sm9219777pfg.164.2024.02.21.21.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 21:08:42 -0800 (PST)
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
Subject: [PATCH net-next v13 1/4] netdevsim: allow two netdevsim ports to be connected
Date: Wed, 21 Feb 2024 21:08:37 -0800
Message-Id: <20240222050840.362799-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240222050840.362799-1-dw@davidwei.uk>
References: <20240222050840.362799-1-dw@davidwei.uk>
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
index 0c5aff63d242..202fa35716db 100644
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


