Return-Path: <netdev+bounces-71091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F25378520E6
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 23:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 235451C21DB1
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 22:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6554D131;
	Mon, 12 Feb 2024 22:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="eQ1cbXui"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DFC4C63F
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 22:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707775553; cv=none; b=DhhDTNtnOkP4bbNP+toqcTsV1wEkBTLF7wIFohSxXzfNqnQbptl1+y4F8VbLsFG7o2axaRNZwvQ1rtwBHTegaj+wadD9/LWtQHbIKOoxg1NUbhH55NPoD6G2CNJJV8VAX/SJSNOG0LYBXs8wFV9c3vEf0Kloq3wQEVZl5ZZrLds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707775553; c=relaxed/simple;
	bh=0MOnMdwRFX+dop9REMdKnrHyttPB/b1CWskzz7FnzdQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pvV3xMmnR+UymQ1p1EBqKkiI2Mnqi/rgmUO88LViIO0dim5Dv8wUIPlUPoiyUtGXPgvPWxYBrXtFcXplk5mV4ZyBLRLIqM43MF5Pa400+x4zY0PDPTb4fgyEaWS7J0eAtZ7oCTd4fQoxBLhAU4xNhNFRc5yQ2SdzU2kGzLW7au4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=eQ1cbXui; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e0dcf0a936so674168b3a.0
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 14:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1707775551; x=1708380351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpvAV5bh7+9HTdlXs/ImEQRlIrypU0HqHp/bHD697NU=;
        b=eQ1cbXuiRPibLg0J1SvVVqmAM6FTKfPWknHq8wzRYg7MjOgoFjK54LnMCix3lY+71o
         7S2YFqi3hd5cwEHp9FtpWos2aR0wA7yk1cdZYpS5jUDgSEgv+hiGvuS8kSdjgi8jtUoS
         K5S9ie/iwR0njN2Rsqw3z7WM5PKCulHwsE6vIAixqJI74DxRuiF9ODf0Oj/H+iHPlXBY
         w/kMOdYMKOuV0c2wOX6zk2gL5+v6DreJuVTqHjXY0LT7GLxSfB4TYZillKgSIJIjvIOM
         sQa65cvQJpU0Bz/JnTSWYLF5enbzqGZShh8eC7Aw57/rryF3Igx+LdWFvTKjn4MH3it3
         6hKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707775551; x=1708380351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpvAV5bh7+9HTdlXs/ImEQRlIrypU0HqHp/bHD697NU=;
        b=CCOV5GAEZHR/jr8jVa2hp5FX6JG2ttX1CIyp7GCxJolbNe/wQ1tCGyIX7W0FGNA5nh
         YVxOS2UbCgtPjRSGI79mgZC3GwZD74wG4HyBGhIGxhL5zn3USicSyPQIVHCdGvJhpTFx
         2E8GPHJ6ysTMm0z+bQAACL8sRZzA67qbZJYTnbbCvewsUM0a3uEXKUAJCQvV2MMeGTUi
         Uarpg9n+b7GZ3dZK8WgGenGeGscysQj1hldPFqmneYfdIceLhkq/xKqe//+5ZhykntGU
         yZGEv7wamYMOqIv83XLQH7SggHSxEnqJrtlF1cxuzjbpKwL9JCOLr1MgJJxWFVuXGk95
         VZHw==
X-Forwarded-Encrypted: i=1; AJvYcCX4rmJAriPvQ60rolHtadnr3HGvzx0uCEhZGFP+wvlOr9Qixo7sjN/UNMKAZRxQWXMCl8eN5v3hMVkSV4nsqNV1QsO9vcC0
X-Gm-Message-State: AOJu0YwtdxVZWWSnZzFcoXE5b850nbdt5k0nl4JL9ni7RcmXmt5VQ/99
	61BAZn0o2k/eEho8FCewUBX67Bm7KJGMUkHgc52SPCob8kL4DBT9D0BEMYUhcmRbcg5QjpRXbcc
	E
X-Google-Smtp-Source: AGHT+IH57iJZKan8ozxVeAe7lbGTM9rMOlObt/b5dhsUHUR3iNFjQz4mpstd1a7QzCVJH3tp84uQUA==
X-Received: by 2002:aa7:980d:0:b0:6e0:eea0:3a34 with SMTP id e13-20020aa7980d000000b006e0eea03a34mr899222pfl.2.1707775551314;
        Mon, 12 Feb 2024 14:05:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVlNrf2sBPZHy0e7+BJNdfLXSj3hJ54wZky4YYnOa7GoJHfYoRCTwhh5OxZ3fv+55JLVebSr+SVLqo6EtCr3IEQXC02aO65qzYkuWLeDNZ/F4fQjGbYj/7Aq26DTaiaNVZ7X/0DyjWxOGrhphBC4C9nYsy9nAqlWqlbc1FoKhTTzPnfBwoBkjBuzejikiYAyBzulr9Y
Received: from localhost (fwdproxy-prn-116.fbsv.net. [2a03:2880:ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id ln18-20020a056a003cd200b006e0e24c71d7sm2221598pfb.62.2024.02.12.14.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 14:05:51 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v10 1/3] netdevsim: allow two netdevsim ports to be connected
Date: Mon, 12 Feb 2024 14:05:42 -0800
Message-Id: <20240212220544.70546-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240212220544.70546-1-dw@davidwei.uk>
References: <20240212220544.70546-1-dw@davidwei.uk>
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


