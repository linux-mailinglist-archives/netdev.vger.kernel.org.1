Return-Path: <netdev+bounces-118318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 786DA9513D4
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 07:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B282E284E30
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 05:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BEB7346D;
	Wed, 14 Aug 2024 05:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWnIN5h2"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E273E139CFC
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 05:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723612981; cv=none; b=JW5CqsuzzwkCXilbyODp1mmgM0YCjtPnIkmXXtwv8s3Sj+g7cDhJJoHQCTSmrmkA0GIPPiR7Cipwc7HNus2SZVPQW80keK5nFVsltWGs5k+vr1TO+duLSw69f0iRY2CpSnyAZbcjAWRt634sQWAH1Wzy7zb4MoEvan8DZBzVWWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723612981; c=relaxed/simple;
	bh=EMCrxrqMWUEWg50MznJkR5ilSYqkdddgMLnx8bI7sgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1+uqi+MufqHUPM1a8wC1YEso0X4uSvj31PLcOkgDHnIJiFVQOGxI4ofOlyggpeYwCL9FKzmRjpes9HFLaD7MeeFVcTKGKFhbCvXZ8tMTZiVpEDL/IcS8dJLncmQ4ee3ifb7010aeP/30gzSwFprcUCsPpC4a6FIBOSIpmR2WDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BWnIN5h2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723612978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1jOClfDFj82MrlYt5le3/1sGJaM4WIw/5LIiPryuiRE=;
	b=BWnIN5h2e+Z1QUwG3Zn8ZrRa/vjXAPth1Mh2v5cIlLx02HBazlnuB9wLRyeAwKq0F1xuxZ
	LFvArLGHMc4V2kGITCVlYlnn287JjH7VKjzTy7VUetZTnANTDq5vaPio9kxAQKGSt/2B/W
	8fDsB/D5mG0E9RItOjZqmWeLI/QnNUA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-V06JQUrfMveKiyh8sI4coQ-1; Wed,
 14 Aug 2024 01:22:56 -0400
X-MC-Unique: V06JQUrfMveKiyh8sI4coQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFA0419560B4;
	Wed, 14 Aug 2024 05:22:54 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.38])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2DA6E1944A95;
	Wed, 14 Aug 2024 05:22:47 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	venkat.x.venkatsubra@oracle.com,
	gia-khanh.nguyen@oracle.com
Subject: [PATCH net-next v7 2/4] virtio: allow driver to disable the configure change notification
Date: Wed, 14 Aug 2024 13:22:26 +0800
Message-ID: <20240814052228.4654-3-jasowang@redhat.com>
In-Reply-To: <20240814052228.4654-1-jasowang@redhat.com>
References: <20240814052228.4654-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Sometime, it would be useful to disable the configure change
notification from the driver. So this patch allows this by introducing
a variable config_change_driver_disabled and only allow the configure
change notification callback to be triggered when it is allowed by
both the virtio core and the driver. It is set to false by default to
hold the current semantic so we don't need to change any drivers.

The first user for this would be virtio-net.

Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio.c | 39 ++++++++++++++++++++++++++++++++++++---
 include/linux/virtio.h  |  7 +++++++
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 6b692b0fa578..b9095751e43b 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -127,10 +127,12 @@ static void __virtio_config_changed(struct virtio_device *dev)
 {
 	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
 
-	if (!dev->config_core_enabled)
+	if (!dev->config_core_enabled || dev->config_driver_disabled)
 		dev->config_change_pending = true;
-	else if (drv && drv->config_changed)
+	else if (drv && drv->config_changed) {
 		drv->config_changed(dev);
+		dev->config_change_pending = false;
+	}
 }
 
 void virtio_config_changed(struct virtio_device *dev)
@@ -143,6 +145,38 @@ void virtio_config_changed(struct virtio_device *dev)
 }
 EXPORT_SYMBOL_GPL(virtio_config_changed);
 
+/**
+ * virtio_config_driver_disable - disable config change reporting by drivers
+ * @dev: the device to reset
+ *
+ * This is only allowed to be called by a driver and disabling can't
+ * be nested.
+ */
+void virtio_config_driver_disable(struct virtio_device *dev)
+{
+	spin_lock_irq(&dev->config_lock);
+	dev->config_driver_disabled = true;
+	spin_unlock_irq(&dev->config_lock);
+}
+EXPORT_SYMBOL_GPL(virtio_config_driver_disable);
+
+/**
+ * virtio_config_driver_enable - enable config change reporting by drivers
+ * @dev: the device to reset
+ *
+ * This is only allowed to be called by a driver and enabling can't
+ * be nested.
+ */
+void virtio_config_driver_enable(struct virtio_device *dev)
+{
+	spin_lock_irq(&dev->config_lock);
+	dev->config_driver_disabled = false;
+	if (dev->config_change_pending)
+		__virtio_config_changed(dev);
+	spin_unlock_irq(&dev->config_lock);
+}
+EXPORT_SYMBOL_GPL(virtio_config_driver_enable);
+
 static void virtio_config_core_disable(struct virtio_device *dev)
 {
 	spin_lock_irq(&dev->config_lock);
@@ -156,7 +190,6 @@ static void virtio_config_core_enable(struct virtio_device *dev)
 	dev->config_core_enabled = true;
 	if (dev->config_change_pending)
 		__virtio_config_changed(dev);
-	dev->config_change_pending = false;
 	spin_unlock_irq(&dev->config_lock);
 }
 
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index de6d3cc176d9..306137a15d07 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -119,6 +119,8 @@ struct virtio_admin_cmd {
  * @index: unique position on the virtio bus
  * @failed: saved value for VIRTIO_CONFIG_S_FAILED bit (for restore)
  * @config_core_enabled: configuration change reporting enabled by core
+ * @config_driver_disabled: configuration change reporting disabled by
+ *                          a driver
  * @config_change_pending: configuration change reported while disabled
  * @config_lock: protects configuration change reporting
  * @vqs_list_lock: protects @vqs.
@@ -136,6 +138,7 @@ struct virtio_device {
 	int index;
 	bool failed;
 	bool config_core_enabled;
+	bool config_driver_disabled;
 	bool config_change_pending;
 	spinlock_t config_lock;
 	spinlock_t vqs_list_lock;
@@ -166,6 +169,10 @@ void __virtqueue_break(struct virtqueue *_vq);
 void __virtqueue_unbreak(struct virtqueue *_vq);
 
 void virtio_config_changed(struct virtio_device *dev);
+
+void virtio_config_driver_disable(struct virtio_device *dev);
+void virtio_config_driver_enable(struct virtio_device *dev);
+
 #ifdef CONFIG_PM_SLEEP
 int virtio_device_freeze(struct virtio_device *dev);
 int virtio_device_restore(struct virtio_device *dev);
-- 
2.31.1


