Return-Path: <netdev+bounces-66360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF1883EAD5
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 05:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D69AD28AB09
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 04:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C52D125C3;
	Sat, 27 Jan 2024 04:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="WALJNjJ+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2A213FE0
	for <netdev@vger.kernel.org>; Sat, 27 Jan 2024 04:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706328248; cv=none; b=Ni+WLiyG5gk1ZxpaMgY7fqxuOLzMLf6+fUgHp+aTYRlaQpGX8+cnr5Et7lSgKjsrgFJZTFVtO9DI72BRpa+DwcDdpVJISGM+rX3u8LOEgmPuorAAXnZSFnGptq3SMDW0FtzfBh1dGZpAAZX728M4Kxn9tb/plvnwbDBoeouTfZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706328248; c=relaxed/simple;
	bh=mRzVPhWEcoGAbg995ZW7hvCM/ykD2tvdYLsaeYZWcOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kiXOEKpLFiwH+uFC3DTtOZmViQgY1aCA5KrUJgzx/z+EtdgZ9iZJbEH5hGKq3HvPbTFDL0/JduRh6mvNkMHCjRJ/loyjA+5FoWcbgnPhfiDLHCHk/3rVRb3IDBHvWYrzRb2bEku6QXz0Z64JbUMbs3fAv/BZgWZjilIqU/kAR4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=WALJNjJ+; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6ddf05b1922so753907a34.2
        for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 20:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1706328246; x=1706933046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAmeDRjxtvH97QBxjdVjaXA34ZKaCeM5uAJh8ptpgD8=;
        b=WALJNjJ+iNWrKMaE/Vs6hubKe5dO7b9sV7kASafWPwbjYC/ObpqOguTjyeOgyskEcN
         xy5NjHPjg9qDJoapc0cCA220SNLamPa3gNGsTh+/slW+PHxSK8VtHNRodZiaf/ol71Wm
         G2xbUtAinV6MRSjb4qctHn+/sxm6gcYqqBlcTyVxxtscqQ2xcIsj7N1CI9bprkK/SkAl
         PkELcfJVUxFTwbO2+xp4BotpkifxbNI+T/0vu6lALHudBP5y3/bq0O/HJUE6qE69P/Q6
         16QQ3eE30fZag0YA80Sm1b21V3zp3sac0QFH6qYDOAZqDKSGlqE1fx8S9l9NQZeZ4RJT
         IZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706328246; x=1706933046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PAmeDRjxtvH97QBxjdVjaXA34ZKaCeM5uAJh8ptpgD8=;
        b=jxscIW406HUYN9x51Cq+O0vzhYmRUpbNfmEkRaiyyThEI3UD6IuCRhXZw6PFIzv9it
         HAGp0m7p+w6oa3P14FOEy99klZpUSDT/j1OJ8LfpO2FqrNSXVRf3hBM1+wy2gC28XMus
         GFmQvIlwF+4eLWLJEeQflvJeL+mD1/Nk3rc9Y/qN2f8A/zWHia37HX6/dPaXOrA50/+/
         YjzYoK5Y9xdYbBe/zYbxC4/4oi08hZ9X61f/WNAAY/7UBjr97E8IzDYR/ASj6gJ+Sv9S
         t01balEI+VCC9jbMwuefny0otMTEmJ0nQ3a5PMoNfl9qYez+5/0T6n/Zfc2VcD0PJSAJ
         FIuw==
X-Gm-Message-State: AOJu0YzNZ9rYfw77qT8C0C5Sdbf/lKUo1HOZte+a9x/b8ZoXmXAOFgRg
	LEE0xfEggo1+GMPKI62613En7t77CMZpevAKbwehra08daHP0WvhzxIuIBfPs9s3SCHeoT2YC1o
	9
X-Google-Smtp-Source: AGHT+IE/fptB3Z7N6WNpb5kMmbJUC8v9c2D613BFVZfLCRTLOJ5hAiAxtgVMEj5zAmXEhnd9l9xfWA==
X-Received: by 2002:a05:6830:114a:b0:6e1:f4f:fe52 with SMTP id x10-20020a056830114a00b006e10f4ffe52mr1048633otq.18.1706328246246;
        Fri, 26 Jan 2024 20:04:06 -0800 (PST)
Received: from localhost (fwdproxy-prn-026.fbsv.net. [2a03:2880:ff:1a::face:b00c])
        by smtp.gmail.com with ESMTPSA id k82-20020a628455000000b006dddeb19438sm1933144pfd.188.2024.01.26.20.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 20:04:05 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v7 1/4] netdevsim: allow two netdevsim ports to be connected
Date: Fri, 26 Jan 2024 20:03:51 -0800
Message-Id: <20240127040354.944744-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240127040354.944744-1-dw@davidwei.uk>
References: <20240127040354.944744-1-dw@davidwei.uk>
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
its peer and vice versa, if any.

rtnl_lock is taken to ensure nothing changes during the linking.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/netdevsim/bus.c       | 130 ++++++++++++++++++++++++++++++
 drivers/net/netdevsim/netdev.c    |  11 +++
 drivers/net/netdevsim/netdevsim.h |   2 +
 3 files changed, 143 insertions(+)

diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
index bcbc1e19edde..3162f88b88ec 100644
--- a/drivers/net/netdevsim/bus.c
+++ b/drivers/net/netdevsim/bus.c
@@ -232,9 +232,139 @@ del_device_store(const struct bus_type *bus, const char *buf, size_t count)
 }
 static BUS_ATTR_WO(del_device);
 
+static ssize_t link_device_store(const struct bus_type *bus, const char *buf, size_t count)
+{
+	unsigned int netnsid_a, netnsid_b, ifidx_a, ifidx_b;
+	struct netdevsim *nsim_a, *nsim_b;
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
+	if (nsim_a->peer) {
+		pr_err("Netdevsim %u:%u is already linked\n", netnsid_a, ifidx_a);
+		goto out_put_netns_b;
+	}
+
+	nsim_b = netdev_priv(dev_b);
+	if (nsim_b->peer) {
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
+	if (!nsim->peer)
+		goto out_put_netns;
+	peer = nsim->peer;
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
index 77e8250282a5..969248ffeca8 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -394,6 +394,7 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
 	ns->nsim_dev = nsim_dev;
 	ns->nsim_dev_port = nsim_dev_port;
 	ns->nsim_bus_dev = nsim_dev->nsim_bus_dev;
+	RCU_INIT_POINTER(ns->peer, NULL);
 	SET_NETDEV_DEV(dev, &ns->nsim_bus_dev->dev);
 	SET_NETDEV_DEVLINK_PORT(dev, &nsim_dev_port->devlink_port);
 	nsim_ethtool_init(ns);
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


