Return-Path: <netdev+bounces-205755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD36AB00069
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 13:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA6691883369
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 11:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B1E2E5B05;
	Thu, 10 Jul 2025 11:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YChQvBwQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E572E54BB
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 11:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752146330; cv=none; b=YY4HBdPpy9+qIYJZnCBOmHnNwrcEoWKdmfDsVKZo7FBp+6jpntsJ5loQMKTLeKl8V8nBDUmmsRLW08X6dauUoBuiGnwVhi7ED2x++RO5SuZpP6esY9Q+FdldZAZgEuV5hkbf1x3cKrf3kVvH68+jXodHTvzQS8PJAQIe8nhj9OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752146330; c=relaxed/simple;
	bh=fdkBEYoeCQSyCv7uPVIvIK9U2VAgqzZUzkK/Fha/+38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AXM3TVtHIyrlTE8hneSfO5u3OMxUM13xe5bTMc1FnO87aa9rkg5/i0jzmd1zPa90HDfUNp5VuyE2G7471nRb5rSPvYIimq0BvHN1OdaA8Ej9hf2nEqtQh6anpRpBIum7jDlE8HCKwsV8+QgcNrd08V1/TB1u9helY4bAsT8mQeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YChQvBwQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752146328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zlu5eu1RxGOqWO3n0bwVX+uXFURvfqmL2qJ0yt7XUbk=;
	b=YChQvBwQbDOSS8QAFITCCcylj5o3HAVJW8gelYbB7ndHF68qHUqgjkksVH2WHpEkR436xG
	tp+Donh5uZ5CFR1ryDTn223C9pLOX/NGUmi5a09dXZ2ov2cKbbv/C1OhMW0yAQrAKhdthZ
	6AsyblHLDexfPq4tEm5F/xM3jyH9rrY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-tj-8kdWxM2uYBLj0o8xJJg-1; Thu, 10 Jul 2025 07:18:46 -0400
X-MC-Unique: tj-8kdWxM2uYBLj0o8xJJg-1
X-Mimecast-MFC-AGG-ID: tj-8kdWxM2uYBLj0o8xJJg_1752146325
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-32b3f6114cfso3031021fa.1
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 04:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752146325; x=1752751125;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zlu5eu1RxGOqWO3n0bwVX+uXFURvfqmL2qJ0yt7XUbk=;
        b=V9v9o0bN0uk1MUOaH0ncHzW9ViCFdcd40H0Y4tEae3ameVwLtByBROyQTNaWKkVCuW
         5/5kXyY2P+Gr07ZuatbEYtNtBPwjBTmnETJV4zUz+8n2FRQUmLNNBrXah3EN+/6EEJZV
         kKFe4DSD8ZaD39DKmx8Y1veV9dGQPI2xKkwNIg416c9uGLAOb52SaYQVE9abGnVDBqoM
         3uHq5oa9gMGOen2jP4cmwIpKwzsIAJccHycr3fv/oeIyFPdiieTB/MFnAWQQ/hm2htm9
         t9mNMBhXGd4KmtyzNu4TE2xq7egImO91g0T7nkrUbpXVldkwnuK8R1yI9I9rpMyI40P/
         R27A==
X-Gm-Message-State: AOJu0YyezlLK1f9f+8qX++Fr5C51hVifOASwVLds6vYb/KiT8K8n/Xl8
	kRS9zT2izgaMFzOot1U2eZK3PWiW1USA+1j7PaZU1k1J7dd1oY8MuBbVe7dKvWut0u0dTk1t+QA
	11tymsfmG7nVi94D8aJOtI4T4H8xRbL8aEEl2gdSc/uziLYhlvZTl4/REaTIGXg30rw==
X-Gm-Gg: ASbGncsFx/tEe1q+qFt++a/oMKYTCDqDz+jVodX9WePo7v0uE5mhBpONAgLDo9R613q
	TW7ST5TVIZqF8gwGyhAgasSMXDXQIYHHz+UqQB1F7lDqEUjWpwvzUS/3V//PkEK0hOwDX/Jw2+h
	M0P8ZiqbpPnbEDhqq6NNY0s2KZVcN8EI+2LmMXgg0CPMSRd+D5DRcgKPFyN5DOfAVAPLozM37zE
	ltLHV0vlfczQ/9Fo9AnqieEgEkSKuQ51TOVAstzyWz94MwlxF1QMG6CHSj3cG/h652o+CQNQ6Vy
	RiRjvOCQXZFBIhJgYsqDiMCZtIm/7ClL53GqlwfZNNR3Smg=
X-Received: by 2002:a05:6512:3503:b0:553:390a:e1d3 with SMTP id 2adb3069b0e04-55935b34e02mr755989e87.48.1752146324673;
        Thu, 10 Jul 2025 04:18:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBUlMZlibNQ1OD/CECYh4OxqU1R7mSnUVsCBaD8QA6FfBeRoyz7fPgch++WhPqBLTRV4MYXg==
X-Received: by 2002:a05:6512:3503:b0:553:390a:e1d3 with SMTP id 2adb3069b0e04-55935b34e02mr755974e87.48.1752146324133;
        Thu, 10 Jul 2025 04:18:44 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c9d0f1fsm331312e87.107.2025.07.10.04.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 04:18:43 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id F07561B8A3D8; Thu, 10 Jul 2025 13:18:41 +0200 (CEST)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Thu, 10 Jul 2025 13:18:33 +0200
Subject: [PATCH net-next v4 1/2] net: netdevsim: Support setting
 dev->perm_addr on port creation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250710-netdevsim-perm_addr-v4-1-c9db2fecf3bf@redhat.com>
References: <20250710-netdevsim-perm_addr-v4-0-c9db2fecf3bf@redhat.com>
In-Reply-To: <20250710-netdevsim-perm_addr-v4-0-c9db2fecf3bf@redhat.com>
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

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/netdevsim/bus.c       | 26 ++++++++++++++++++++++----
 drivers/net/netdevsim/dev.c       | 14 +++++++-------
 drivers/net/netdevsim/netdev.c    |  9 ++++++---
 drivers/net/netdevsim/netdevsim.h |  9 +++++----
 4 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
index 64c0cdd31bf85468ce4fa2b2af5c8aff4cfba897..830abcb98476587940b79be36705ee00f86b51d3 100644
--- a/drivers/net/netdevsim/bus.c
+++ b/drivers/net/netdevsim/bus.c
@@ -66,17 +66,35 @@ new_port_store(struct device *dev, struct device_attribute *attr,
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
+		if (!is_valid_ether_addr(eth_addr)) {
+			pr_err("The supplied perm_addr is not a valid MAC address\n");
+			return -EINVAL;
+		}
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


