Return-Path: <netdev+bounces-204421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95221AFA5F8
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 16:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C400189B7F8
	for <lists+netdev@lfdr.de>; Sun,  6 Jul 2025 14:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090C3264FA9;
	Sun,  6 Jul 2025 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IA+4OUC3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C58185E7F
	for <netdev@vger.kernel.org>; Sun,  6 Jul 2025 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751813161; cv=none; b=BaYhMl9WJZB1AGwCKOkEvTSHqCk9Vrtd06O024/TWnfR8nNHHl0WZ1VHqfFyQphr74GMTKdGaVzp4PaTV7JnrDXgI0az/jiKqzimpdmZYZZcpAPQmJmG6rMq4M1oWyaNOmiBvgq9++9qFDgOnJtlEPl2u0iM0vJtyWyhZjkNklc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751813161; c=relaxed/simple;
	bh=qS9faP9kZQFAWHiAA+TgHbu1PnNiZZIItnQH+/KIz9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OU9zzgqPVqXluwCFVSkWyVQjcqwY60hewg9n0oq2MRGi0JcnWAtyusnAEE/6JOLJzPGg2RGQpNKlZw1QSR54QUEhlbcolZueSCaXFK92qwYg6NwslsdtQijtIBmjG5e8eRFpskCXunI+QowhJqf3HflQxBaXqkzkhYLRODkRTFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IA+4OUC3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751813159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ou5038YfCMSsezsc+TuKk3LIuL7hz0k+oG8D9Fl1kDU=;
	b=IA+4OUC33aanEMX4/9QmpkxI4YLKHFO8wZt/l56ZBWEeAwc7OSGTSEd4RbPUYETiUSCP4f
	IqwPW3p2WXqeKasAy+I2UAyqQKz1nIjNISZlwxWqJhPt3ch7BqO3w+Cv6IZj7lLpWyUQ4i
	eI+VTefm1JxEJCVa4ZWbJeT7S3l1Leg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-lMNhe6FAPiCajt9vv1iWkg-1; Sun, 06 Jul 2025 10:45:57 -0400
X-MC-Unique: lMNhe6FAPiCajt9vv1iWkg-1
X-Mimecast-MFC-AGG-ID: lMNhe6FAPiCajt9vv1iWkg_1751813156
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-553a579a283so678122e87.0
        for <netdev@vger.kernel.org>; Sun, 06 Jul 2025 07:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751813156; x=1752417956;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ou5038YfCMSsezsc+TuKk3LIuL7hz0k+oG8D9Fl1kDU=;
        b=d48TqamZfHeto2HpLnW4yml8XN6qDzBks0YBXDv6aWELJ1l9w0CPH5/KXHM6m3/mlN
         PQQUAsuYm5suzew56Av6kTglBF7SDMQnHUWC0O9ksTPtPtcePFlJxrIRkAPbkJ9zOIcX
         r7Ufi1Lm2Z2HR2zHLfRMupqvZFRND/bGygr66fHwgs1p1EkjjQ02Y6qQASiiSa4bJj6o
         1hum7YpwQUpoVs2QNDSJgAUIqQw8lZpJSuxuolibBqhjaGRHa4rPbyD9AEPsNhUs78Rt
         P88RXS4mEJ6nBxII2m1P1WsckvI6y5Q7e5Bs0Rml6GpfkkzMJW0kgMzu5uMA8oktkcpp
         r8DQ==
X-Gm-Message-State: AOJu0YzRZAMJFIwWCNyG31geeNNoIP0t7mrVBBSLZ86Al7B430479oqo
	ozdMPtt5XCMfxMhFX0yIMQA7wgLsh2jkb72rsTevvGIbJlK0gicqpypCbd1lcGO/2OdjR63CQqx
	l6PNEHqZau+wEHoyRh+SJEQx2s+KPpCUlSjOPd52z2ekN/h9j81CCoRkWYQ==
X-Gm-Gg: ASbGncsho2Ckz1ePoPpf209IDcEjUfEJYQHWpjOmfEs2/dZfGzqK+58l0wVGLufixK2
	53pQ5oofxn2v57nW7rWPvRJMe0GoPH67b0ylS0L0F5/jWt+mBMD8RlsMGgAi0q9+/0dsZS4FuV1
	CfHVaKKMAEhiWRdW/4mc9TicONA/EuLwf+u8UkS7z2pQs449DAKe6hhkcMDmnahVQ09t0ljIHcA
	d71zCz1o0gDDR0389kPl98qxGbMG2W47e3F+Ne6Uzd0482/HwUydbs0gJ43np9uYJ2XkEtlXEXV
	AlPWp3gWOpKAKYIj4CaUCE7psTit9Sq+6WTJBKDpPPFZPuo=
X-Received: by 2002:a05:6512:2213:b0:553:24f2:c9d8 with SMTP id 2adb3069b0e04-557aa67e8bamr2482287e87.38.1751813156186;
        Sun, 06 Jul 2025 07:45:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZatRVTtoDTyTjYk1BcbGwnFAJc2M46BkHIPTPlx/Sgc0p+hpLQCcI6EKID4391rcMY9NDUw==
X-Received: by 2002:a05:6512:2213:b0:553:24f2:c9d8 with SMTP id 2adb3069b0e04-557aa67e8bamr2482282e87.38.1751813155679;
        Sun, 06 Jul 2025 07:45:55 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556384ba65csm983249e87.204.2025.07.06.07.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 07:45:54 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id EB8C01B89EAD; Sun, 06 Jul 2025 16:45:52 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Sun, 06 Jul 2025 16:45:31 +0200
Subject: [PATCH net-next v3 1/2] net: netdevsim: Support setting
 dev->perm_addr on port creation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250706-netdevsim-perm_addr-v3-1-88123e2b2027@redhat.com>
References: <20250706-netdevsim-perm_addr-v3-0-88123e2b2027@redhat.com>
In-Reply-To: <20250706-netdevsim-perm_addr-v3-0-88123e2b2027@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.14.2

Network management daemons that match on the device permanent address
currently have no virtual interface types to test against.
NetworkManager, in particular, has carried an out of tree patch to set
the permanent address on netdevsim devices to use in its CI for this
purpose.

To support this use case, support setting netdev->perm_addr when
creating a netdevsim port.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/netdevsim/bus.c       | 22 ++++++++++++++++++----
 drivers/net/netdevsim/dev.c       | 14 +++++++-------
 drivers/net/netdevsim/netdev.c    |  9 ++++++---
 drivers/net/netdevsim/netdevsim.h |  9 +++++----
 4 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
index 64c0cdd31bf85468ce4fa2b2af5c8aff4cfba897..422b3683afe154d9055878a601f95d7b39b30aaf 100644
--- a/drivers/net/netdevsim/bus.c
+++ b/drivers/net/netdevsim/bus.c
@@ -66,17 +66,31 @@ new_port_store(struct device *dev, struct device_attribute *attr,
 	       const char *buf, size_t count)
 {
 	struct nsim_bus_dev *nsim_bus_dev = to_nsim_bus_dev(dev);
+	u8 eth_addr[ETH_ALEN] = {};
 	unsigned int port_index;
+	bool addr_set = false;
 	int ret;
 
 	/* Prevent to use nsim_bus_dev before initialization. */
 	if (!smp_load_acquire(&nsim_bus_dev->init))
 		return -EBUSY;
-	ret = kstrtouint(buf, 0, &port_index);
-	if (ret)
-		return ret;
 
-	ret = nsim_drv_port_add(nsim_bus_dev, NSIM_DEV_PORT_TYPE_PF, port_index);
+	ret = sscanf(buf, "%u %hhx:%hhx:%hhx:%hhx:%hhx:%hhx", &port_index,
+		     &eth_addr[0], &eth_addr[1], &eth_addr[2], &eth_addr[3],
+		     &eth_addr[4], &eth_addr[5]);
+	switch (ret) {
+	case 7:
+		addr_set = true;
+		fallthrough;
+	case 1:
+		break;
+	default:
+		pr_err("Format for adding new port is \"id [perm_addr]\" (uint MAC).\n");
+		return -EINVAL;
+	}
+
+	ret = nsim_drv_port_add(nsim_bus_dev, NSIM_DEV_PORT_TYPE_PF, port_index,
+				addr_set ? eth_addr : NULL);
 	return ret ? ret : count;
 }
 
diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
index 3e0b61202f0c9824952040c8d4c79eb8775954c6..107b106be516bbc97735e93643a7f7cf3bfc0a73 100644
--- a/drivers/net/netdevsim/dev.c
+++ b/drivers/net/netdevsim/dev.c
@@ -576,7 +576,7 @@ static void nsim_dev_dummy_region_exit(struct nsim_dev *nsim_dev)
 
 static int
 __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
-		    unsigned int port_index);
+		    unsigned int port_index, u8 perm_addr[ETH_ALEN]);
 static void __nsim_dev_port_del(struct nsim_dev_port *nsim_dev_port);
 
 static int nsim_esw_legacy_enable(struct nsim_dev *nsim_dev,
@@ -600,7 +600,7 @@ static int nsim_esw_switchdev_enable(struct nsim_dev *nsim_dev,
 	int i, err;
 
 	for (i = 0; i < nsim_dev_get_vfs(nsim_dev); i++) {
-		err = __nsim_dev_port_add(nsim_dev, NSIM_DEV_PORT_TYPE_VF, i);
+		err = __nsim_dev_port_add(nsim_dev, NSIM_DEV_PORT_TYPE_VF, i, NULL);
 		if (err) {
 			NL_SET_ERR_MSG_MOD(extack, "Failed to initialize VFs' netdevsim ports");
 			pr_err("Failed to initialize VF id=%d. %d.\n", i, err);
@@ -1353,7 +1353,7 @@ static const struct devlink_ops nsim_dev_devlink_ops = {
 #define NSIM_DEV_TEST1_DEFAULT true
 
 static int __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
-			       unsigned int port_index)
+			       unsigned int port_index, u8 perm_addr[ETH_ALEN])
 {
 	struct devlink_port_attrs attrs = {};
 	struct nsim_dev_port *nsim_dev_port;
@@ -1390,7 +1390,7 @@ static int __nsim_dev_port_add(struct nsim_dev *nsim_dev, enum nsim_dev_port_typ
 	if (err)
 		goto err_dl_port_unregister;
 
-	nsim_dev_port->ns = nsim_create(nsim_dev, nsim_dev_port);
+	nsim_dev_port->ns = nsim_create(nsim_dev, nsim_dev_port, perm_addr);
 	if (IS_ERR(nsim_dev_port->ns)) {
 		err = PTR_ERR(nsim_dev_port->ns);
 		goto err_port_debugfs_exit;
@@ -1446,7 +1446,7 @@ static int nsim_dev_port_add_all(struct nsim_dev *nsim_dev,
 	int i, err;
 
 	for (i = 0; i < port_count; i++) {
-		err = __nsim_dev_port_add(nsim_dev, NSIM_DEV_PORT_TYPE_PF, i);
+		err = __nsim_dev_port_add(nsim_dev, NSIM_DEV_PORT_TYPE_PF, i, NULL);
 		if (err)
 			goto err_port_del_all;
 	}
@@ -1702,7 +1702,7 @@ __nsim_dev_port_lookup(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
 }
 
 int nsim_drv_port_add(struct nsim_bus_dev *nsim_bus_dev, enum nsim_dev_port_type type,
-		      unsigned int port_index)
+		      unsigned int port_index, u8 perm_addr[ETH_ALEN])
 {
 	struct nsim_dev *nsim_dev = dev_get_drvdata(&nsim_bus_dev->dev);
 	int err;
@@ -1711,7 +1711,7 @@ int nsim_drv_port_add(struct nsim_bus_dev *nsim_bus_dev, enum nsim_dev_port_type
 	if (__nsim_dev_port_lookup(nsim_dev, type, port_index))
 		err = -EEXIST;
 	else
-		err = __nsim_dev_port_add(nsim_dev, type, port_index);
+		err = __nsim_dev_port_add(nsim_dev, type, port_index, perm_addr);
 	devl_unlock(priv_to_devlink(nsim_dev));
 	return err;
 }
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index e36d3e846c2dc314182efd1af03b59270397b007..f316e44130f722759f0ac4e5baac6a2f6956dc7d 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -998,8 +998,9 @@ static void nsim_exit_netdevsim(struct netdevsim *ns)
 	mock_phc_destroy(ns->phc);
 }
 
-struct netdevsim *
-nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
+struct netdevsim *nsim_create(struct nsim_dev *nsim_dev,
+			      struct nsim_dev_port *nsim_dev_port,
+			      u8 perm_addr[ETH_ALEN])
 {
 	struct net_device *dev;
 	struct netdevsim *ns;
@@ -1010,6 +1011,9 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
 
+	if (perm_addr)
+		memcpy(dev->perm_addr, perm_addr, ETH_ALEN);
+
 	dev_net_set(dev, nsim_dev_net(nsim_dev));
 	ns = netdev_priv(dev);
 	ns->netdev = dev;
@@ -1031,7 +1035,6 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
 	ns->qr_dfs = debugfs_create_file("queue_reset", 0200,
 					 nsim_dev_port->ddir, ns,
 					 &nsim_qreset_fops);
-
 	return ns;
 
 err_free_netdev:
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 4a0c48c7a384e2036883c84dc847b82f992f1481..3a8b5510ec2914204beb15247ab60a5d9933f48d 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -143,8 +143,9 @@ struct netdevsim {
 	struct netdev_net_notifier nn;
 };
 
-struct netdevsim *
-nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port);
+struct netdevsim *nsim_create(struct nsim_dev *nsim_dev,
+			      struct nsim_dev_port *nsim_dev_port,
+			      u8 perm_addr[ETH_ALEN]);
 void nsim_destroy(struct netdevsim *ns);
 bool netdev_is_nsim(struct net_device *dev);
 
@@ -361,8 +362,8 @@ void nsim_dev_exit(void);
 int nsim_drv_probe(struct nsim_bus_dev *nsim_bus_dev);
 void nsim_drv_remove(struct nsim_bus_dev *nsim_bus_dev);
 int nsim_drv_port_add(struct nsim_bus_dev *nsim_bus_dev,
-		      enum nsim_dev_port_type type,
-		      unsigned int port_index);
+		      enum nsim_dev_port_type type, unsigned int port_index,
+		      u8 perm_addr[ETH_ALEN]);
 int nsim_drv_port_del(struct nsim_bus_dev *nsim_bus_dev,
 		      enum nsim_dev_port_type type,
 		      unsigned int port_index);

-- 
2.50.0


