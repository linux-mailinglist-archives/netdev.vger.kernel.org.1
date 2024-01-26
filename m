Return-Path: <netdev+bounces-66066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3033083D202
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 02:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B2A91C23FCF
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 01:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2659210F7;
	Fri, 26 Jan 2024 01:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Q54Wkknm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B728399
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 01:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706232243; cv=none; b=G+tpkxVO/mZPNAQ9gya7nKrx4NDtMhlTOUPFpsI96z7CEhluVyN1o6TjIj8uZy29LeuXx4TnnR0LsKW09hggd2uG77+7BhyxJiQ2nGzEWXZa29Px9j9wGqEDveYkwXus8STr4Muk50ZdsiHUCNYJ4kvXs9IrpYPLBM75zS64fsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706232243; c=relaxed/simple;
	bh=IBPIKdOKvY0WW5LdMDKnfSfvdbdzz92967TpjFSqs1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WVP8qjbDeaDaBPyR2Gg/e1mN2pxWQhnv5//hji6eT3ePIPnuJreLIEcQ12zoHu3/lIfojhX+Wcj71y/7MHUNS9m4v2IWWa0chV4Y8NycdZ9xbjX/+kYgcMfb2FnbYDLkqLVIkgYHGDtzZy+gpArVBBNc5B92xUljyv6+gY3tfoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=Q54Wkknm; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5cf765355ecso20496a12.0
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 17:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1706232241; x=1706837041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APMEWTkERNCaAJZd7Uy5jGDylwysKt0DpK+jOI64rCo=;
        b=Q54WkknmpSYKGN435uaLToD4pdQf9SsZbySmaacc7VWXUGqFN2DQFDklka6ePvZW2V
         YbWT1GgLqi5y8+pw0mH5xiR9XywifLJOKGRF6q+8eZtv4FeFNaXZ/SKxIiv5Cysb361i
         QM6oGAkw/o7+2ZMU6vl7aBTn0lnuGzp/fGMgTPQRnJ5KJjVRKMzBu/4Wws8RYL7ZYLLz
         u+1S6Av5C9NDk0bflczWaU9jc+ThJmFJsmbjnnohK0cK1QtsacNajuOorM/cvgZJ6vHy
         7RDy0d5FRJrYs5KLUhaAA74XUsqKaEb5LenTY2aaZtiiXLakV+s7yyR0NHQVuYRsa5vJ
         0QRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706232241; x=1706837041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=APMEWTkERNCaAJZd7Uy5jGDylwysKt0DpK+jOI64rCo=;
        b=XMdP7l07wUTpb4AZqBOsxUBt7U8AtTX1wcMckR2dsBxGf5vn6jWVD0ctBdwHR+ABG7
         pP45Cucjp/yO/FezT6/xtSmY2QhULXjYyu8374c/1w+xNGw+O+cgNZrG+uEws65i0vUU
         wz9pBULQTQt2S3FICXBcN40R683Bt1uEm9IUrQV2SyNEDz5cH0FD/MlLQtSJuqkSoBZo
         hwyEjPGjUBlWLhv5vmwd6I73h856c1g1HX06K983IW8qrOvkLFsJAj6o1lId+bEDU8XR
         V9UBn1YhvWOVLheFdoMZEcd/NuppuW1jIFj7cAqvuT4ioMKGqb8/PbneUtR9qECsFSpA
         Vsng==
X-Gm-Message-State: AOJu0YzISKtoadTk3ipgk/3nqjONuyWXuYNQzXh0jDWmGCAP0YGGZOlg
	wR4JjN9oPaQ88B7n9uzd+lXdVYrToJWafaf/XXLEq9zKg4STjyVqIWkBlbKGBQY=
X-Google-Smtp-Source: AGHT+IEpQ4Kbe3j6uJXbEYA0OmfK894+m07iEZtQ93vidPIVOFZGt3tp+DNAALmYA4GQO83zo+xr5A==
X-Received: by 2002:a17:90b:4ad1:b0:293:eeac:1588 with SMTP id mh17-20020a17090b4ad100b00293eeac1588mr92332pjb.10.1706232240903;
        Thu, 25 Jan 2024 17:24:00 -0800 (PST)
Received: from localhost (fwdproxy-prn-009.fbsv.net. [2a03:2880:ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id mf4-20020a17090b184400b0028cc9afaae9sm152299pjb.34.2024.01.25.17.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 17:24:00 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v6 1/4] netdevsim: allow two netdevsim ports to be connected
Date: Thu, 25 Jan 2024 17:23:54 -0800
Message-Id: <20240126012357.535494-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240126012357.535494-1-dw@davidwei.uk>
References: <20240126012357.535494-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a netdevsim bus attribute to sysfs:
/sys/bus/netdevsim/link_device

Writing "A M B N" to this file will link netdevsim M in netnsid A with
netdevsim N in netnsid B.

rtnl_lock is taken to ensure nothing changes during the linking.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/netdevsim/bus.c       | 72 +++++++++++++++++++++++++++++++
 drivers/net/netdevsim/netdev.c    | 11 +++++
 drivers/net/netdevsim/netdevsim.h |  2 +
 3 files changed, 85 insertions(+)

diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
index bcbc1e19edde..be8ac2e60c69 100644
--- a/drivers/net/netdevsim/bus.c
+++ b/drivers/net/netdevsim/bus.c
@@ -232,9 +232,81 @@ del_device_store(const struct bus_type *bus, const char *buf, size_t count)
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
+	err = sscanf(buf, "%u %u %u %u", &netnsid_a, &ifidx_a, &netnsid_b, &ifidx_b);
+	if (err != 4) {
+		pr_err("Format for linking two devices is \"netnsid_a ifidx_a netnsid_b ifidx_b\" (uint uint unit uint).\n");
+		return -EINVAL;
+	}
+
+	err = -EINVAL;
+	rtnl_lock();
+	ns_a = get_net_ns_by_id(current->nsproxy->net_ns, netnsid_a);
+	if (!ns_a) {
+		pr_err("Could not find netns with id: %d\n", netnsid_a);
+		goto out_unlock_rtnl;
+	}
+
+	dev_a = dev_get_by_index(ns_a, ifidx_a);
+	if (!dev_a) {
+		pr_err("Could not find device with ifindex %d in netnsid %d\n", ifidx_a, netnsid_a);
+		goto out_put_netns_a;
+	}
+
+	if (!netdev_is_nsim(dev_a)) {
+		pr_err("Device with ifindex %d in netnsid %d is not a netdevsim\n", ifidx_a, netnsid_a);
+		goto out_put_dev_a;
+	}
+
+	ns_b = get_net_ns_by_id(current->nsproxy->net_ns, netnsid_b);
+	if (!ns_b) {
+		pr_err("Could not find netns with id: %d\n", netnsid_b);
+		goto out_put_dev_a;
+	}
+
+	dev_b = dev_get_by_index(ns_b, ifidx_b);
+	if (!dev_b) {
+		pr_err("Could not find device with ifindex %d in netnsid %d\n", ifidx_b, netnsid_b);
+		goto out_put_netns_b;
+	}
+
+	if (!netdev_is_nsim(dev_b)) {
+		pr_err("Device with ifindex %d in netnsid %d is not a netdevsim\n", ifidx_b, netnsid_b);
+		goto out_put_dev_b;
+	}
+
+	err = 0;
+	nsim_a = netdev_priv(dev_a);
+	nsim_b = netdev_priv(dev_b);
+	rcu_assign_pointer(nsim_a->peer, nsim_b);
+	rcu_assign_pointer(nsim_b->peer, nsim_a);
+
+out_put_dev_b:
+	dev_put(dev_b);
+out_put_netns_b:
+	put_net(ns_b);
+out_put_dev_a:
+	dev_put(dev_a);
+out_put_netns_a:
+	put_net(ns_a);
+out_unlock_rtnl:
+	rtnl_unlock();
+
+	return !err ? count : err;
+}
+static BUS_ATTR_WO(link_device);
+
 static struct attribute *nsim_bus_attrs[] = {
 	&bus_attr_new_device.attr,
 	&bus_attr_del_device.attr,
+	&bus_attr_link_device.attr,
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


