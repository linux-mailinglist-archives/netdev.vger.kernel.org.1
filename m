Return-Path: <netdev+bounces-115612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE72E9473A6
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 05:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBBCDB21232
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 03:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D8E143C4C;
	Mon,  5 Aug 2024 03:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jCIYf0bU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D69A13D26B
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 03:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722826998; cv=none; b=trkFO9bLjwkoxh5bdi6il71EkWD4uj5DUIXr8lM0tobj2a8DqRbwfozCle4dYbN4+94s2gGDWEeBVRz1UH8NvE6hzNBZLFcx8m9MQe3zM6NuG4A/s2FubaQqG8s6MsRsA2QTNHAcEwro87zHGBuYKdzca9ghZGB+6ajHuz/jCeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722826998; c=relaxed/simple;
	bh=cMaNuKwtGB66k+wzRP58lh1DkYEBUYnziv7pbA2VBWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ignDS6dU64T8EAHzz3OsxOHR1ja2YcFJQbJL9FrfWssWnioRHBDKao0S+ANpgJddLA9Rtq2o2WNu9aeuROKXLgBbwUEPISdYpmmUOtIDVCnIfOAitYElfaSuwiTwmrVA2kbaOhxO9l/XkeqzBjljQZrNoy3g0UouMVyGzl2cEj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jCIYf0bU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722826995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fyqGi8WepnDEHHzpJw+aLOomcoq9K5r0l14qL5VCaSg=;
	b=jCIYf0bUl7VcmcnoxH3DaqvfL6vRCjiM+NL9zYZkOIvNTDhEwk61vIe0TKzPjYSB3y3M0O
	QBCwpQ36lKN9Oa2XDAWxtyNaK95AHscb3N3B+3JG/Er1zEIvzomnuci1JIgsrfqXeTLa3k
	UE8BwAKCvCmU8kvoIy9VyNf/+bEjFL8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-46-UJWlyp_wPAijYvaG6io5-g-1; Sun,
 04 Aug 2024 23:03:10 -0400
X-MC-Unique: UJWlyp_wPAijYvaG6io5-g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 77CCD19560AD;
	Mon,  5 Aug 2024 03:03:08 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.218])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 780711955E80;
	Mon,  5 Aug 2024 03:03:01 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>,
	Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Subject: [PATCH V5 net-next 2/3] virtio: allow driver to disable the configure change notification
Date: Mon,  5 Aug 2024 11:02:41 +0800
Message-ID: <20240805030242.62390-3-jasowang@redhat.com>
In-Reply-To: <20240805030242.62390-1-jasowang@redhat.com>
References: <20240805030242.62390-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Sometime, it would be useful to disable the configure change
notification from the driver. So this patch allows this by introducing
a variable config_change_driver_disabled and only allow the configure
change notification callback to be triggered when it is allowed by
both the virtio core and the driver. It is set to false by default to
hold the current semantic so we don't need to change any drivers.

The first user for this would be virtio-net.

Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio.c | 39 ++++++++++++++++++++++++++++++++++++---
 include/linux/virtio.h  |  7 +++++++
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index b24f08ff2a8c..0e9cd580fbdd 100644
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
+ * This is only allowed to be called by a driver and disalbing can't
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
index 98db6390c1be..11b2bfcf6a2f 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -116,6 +116,8 @@ struct virtio_admin_cmd {
  * @index: unique position on the virtio bus
  * @failed: saved value for VIRTIO_CONFIG_S_FAILED bit (for restore)
  * @config_core_enabled: configuration change reporting enabled by core
+ * @config_driver_disabled: configuration change reporting disabled by
+ *                          a driver
  * @config_change_pending: configuration change reported while disabled
  * @config_lock: protects configuration change reporting
  * @vqs_list_lock: protects @vqs.
@@ -133,6 +135,7 @@ struct virtio_device {
 	int index;
 	bool failed;
 	bool config_core_enabled;
+	bool config_driver_disabled;
 	bool config_change_pending;
 	spinlock_t config_lock;
 	spinlock_t vqs_list_lock;
@@ -163,6 +166,10 @@ void __virtqueue_break(struct virtqueue *_vq);
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


