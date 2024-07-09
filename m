Return-Path: <netdev+bounces-110143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0860C92B1BD
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 10:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EF7DB222CA
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 08:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD0C153815;
	Tue,  9 Jul 2024 08:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2O119ZG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA7B13BC30
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 08:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720512169; cv=none; b=MLqukSxmDTasOQqTrUjp+8zteBMc8mB65I35hVzNb9dDRLm/PJgW+InmfOZ1Bwkbak7zCGsL5H0jIGSxf9dSlPuKnerjl1V965gb7RBMbiZC+IjioFMQDYV3j6Co3P7LBhQUG6BH/hgX9JekaLKv9rxqrQzx6DBUh56RMOi1LeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720512169; c=relaxed/simple;
	bh=doJuD6Ad6+WLmrSoHdYJY3eqzbQod0yKfr5czeLyavM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fqztt9JF1NLngM5tSpBQBp8lB0OlDFuXvrX0DVqbZr4LFgr6L+76qyq7SVU6V4DtOsTUyX9Prw+RgJsZz58RDwwCao3sLh3Z4xt4myflGPFNPco8EhraSCIEyIYyMKkF7SYizb1n+n+8zuP/2nFU0WnC04qsusyitiSYGERVGnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h2O119ZG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720512166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dHCaS+jY2Jg8S88jwIg+mBIv5Lor8XLl5Lwa81p6b8w=;
	b=h2O119ZGrPgJEM9eyCUuN8lhgfQ2iVOtckfq1KH65wiBNlb9Bjf7jD0wuOM8Gzu7z+LURZ
	Md2X9KsrGMoXdOHuZ7lda5nJXSB5Egv1i/WxWoTI79fWRGiq6vkD7dqm5csB0Q0w0caZGG
	5kUPCNRvNGgR/iqZppHnTR2Ijw7+S7k=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-nT-aBU6PO7epmALKVrmakw-1; Tue,
 09 Jul 2024 04:02:41 -0400
X-MC-Unique: nT-aBU6PO7epmALKVrmakw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B70B11977338;
	Tue,  9 Jul 2024 08:02:39 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.184])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 08B863000181;
	Tue,  9 Jul 2024 08:02:32 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>,
	Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Subject: [PATCH net-next v3 1/3] virtio: rename virtio_config_enabled to virtio_config_core_enabled
Date: Tue,  9 Jul 2024 16:02:12 +0800
Message-ID: <20240709080214.9790-2-jasowang@redhat.com>
In-Reply-To: <20240709080214.9790-1-jasowang@redhat.com>
References: <20240709080214.9790-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Following patch will allow the config interrupt to be disabled by a
specific driver via another boolean. So this patch renames
virtio_config_enabled and relevant helpers to
virtio_config_core_enabled.

Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio.c | 22 +++++++++++-----------
 include/linux/virtio.h  |  4 ++--
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index b968b2aa5f4d..73bab89b5326 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -127,7 +127,7 @@ static void __virtio_config_changed(struct virtio_device *dev)
 {
 	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
 
-	if (!dev->config_enabled)
+	if (!dev->config_core_enabled)
 		dev->config_change_pending = true;
 	else if (drv && drv->config_changed)
 		drv->config_changed(dev);
@@ -143,17 +143,17 @@ void virtio_config_changed(struct virtio_device *dev)
 }
 EXPORT_SYMBOL_GPL(virtio_config_changed);
 
-static void virtio_config_disable(struct virtio_device *dev)
+static void virtio_config_core_disable(struct virtio_device *dev)
 {
 	spin_lock_irq(&dev->config_lock);
-	dev->config_enabled = false;
+	dev->config_core_enabled = false;
 	spin_unlock_irq(&dev->config_lock);
 }
 
-static void virtio_config_enable(struct virtio_device *dev)
+static void virtio_config_core_enable(struct virtio_device *dev)
 {
 	spin_lock_irq(&dev->config_lock);
-	dev->config_enabled = true;
+	dev->config_core_enabled = true;
 	if (dev->config_change_pending)
 		__virtio_config_changed(dev);
 	dev->config_change_pending = false;
@@ -322,7 +322,7 @@ static int virtio_dev_probe(struct device *_d)
 	if (drv->scan)
 		drv->scan(dev);
 
-	virtio_config_enable(dev);
+	virtio_config_core_enable(dev);
 
 	return 0;
 
@@ -340,7 +340,7 @@ static void virtio_dev_remove(struct device *_d)
 	struct virtio_device *dev = dev_to_virtio(_d);
 	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
 
-	virtio_config_disable(dev);
+	virtio_config_core_disable(dev);
 
 	drv->remove(dev);
 
@@ -455,7 +455,7 @@ int register_virtio_device(struct virtio_device *dev)
 		goto out_ida_remove;
 
 	spin_lock_init(&dev->config_lock);
-	dev->config_enabled = false;
+	dev->config_core_enabled = false;
 	dev->config_change_pending = false;
 
 	INIT_LIST_HEAD(&dev->vqs);
@@ -512,14 +512,14 @@ int virtio_device_freeze(struct virtio_device *dev)
 	struct virtio_driver *drv = drv_to_virtio(dev->dev.driver);
 	int ret;
 
-	virtio_config_disable(dev);
+	virtio_config_core_disable(dev);
 
 	dev->failed = dev->config->get_status(dev) & VIRTIO_CONFIG_S_FAILED;
 
 	if (drv && drv->freeze) {
 		ret = drv->freeze(dev);
 		if (ret) {
-			virtio_config_enable(dev);
+			virtio_config_core_enable(dev);
 			return ret;
 		}
 	}
@@ -578,7 +578,7 @@ int virtio_device_restore(struct virtio_device *dev)
 	if (!(dev->config->get_status(dev) & VIRTIO_CONFIG_S_DRIVER_OK))
 		virtio_device_ready(dev);
 
-	virtio_config_enable(dev);
+	virtio_config_core_enable(dev);
 
 	return 0;
 
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 96fea920873b..a6f6df72f01a 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -115,7 +115,7 @@ struct virtio_admin_cmd {
  * struct virtio_device - representation of a device using virtio
  * @index: unique position on the virtio bus
  * @failed: saved value for VIRTIO_CONFIG_S_FAILED bit (for restore)
- * @config_enabled: configuration change reporting enabled
+ * @config_core_enabled: configuration change reporting enabled by core
  * @config_change_pending: configuration change reported while disabled
  * @config_lock: protects configuration change reporting
  * @vqs_list_lock: protects @vqs.
@@ -132,7 +132,7 @@ struct virtio_admin_cmd {
 struct virtio_device {
 	int index;
 	bool failed;
-	bool config_enabled;
+	bool config_core_enabled;
 	bool config_change_pending;
 	spinlock_t config_lock;
 	spinlock_t vqs_list_lock;
-- 
2.31.1


