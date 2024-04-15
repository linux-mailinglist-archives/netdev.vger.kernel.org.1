Return-Path: <netdev+bounces-88052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 943E48A57A8
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 18:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70F41C2204B
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 16:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5CD3E48F;
	Mon, 15 Apr 2024 16:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="LkBU9nNm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A53980C03
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 16:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713198342; cv=none; b=Kn62MQTBGsr4pGChAE6o2vBYw8qA9Avt4uEFpuV7aUZWh6iwktIA6RXbMPK6FG5v2kgLQ5guTYziLRPou6WnEd1xsH/HHTSZQ744JOoDrF+DYYL8Le32nKmkVBzmF9x6FiM9SwxHqth9/59cb7p999iHls0aK4HbeOVlWz84bT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713198342; c=relaxed/simple;
	bh=H3pjtAzG8pQcFoMfgL2Fil38d0Ryh7wHYYt0AdNSf3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Er235WzHs/WHWWcMIqMNy5+zZqbzQ3HqtW8kLvEUFHxY6dVBcp35HhsjLHso2jGZUtb3wC5nGmR6MapZ4JWk87z5us9HS8Zxu1j2v6duHq2n/+gbHtIB06ow/3t/c713xpb0CPr7hntElGWmQdlqapKJSBTfSR8C/arf43jA96o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=LkBU9nNm; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5701de9e971so1676813a12.1
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 09:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713198338; x=1713803138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oxBkGe7SdmsJXy9vmp58aQDE3BF9aWZY5P/z4wlEcJY=;
        b=LkBU9nNmHFbLE+nwdI5PYT00Oh90EHD0y2kbZUaNBA2GuHmoPqTNOWUHYGj+OT9Nwu
         5qC0bnlaiOEhNqMfkpEhUylg8lsuQlXzRN2dC+dpzsf3l+VZF0SdyXCvzomovdIcGLER
         vVwwoXqbH/nJy4qQWvXMlV8LKr6donfYpoLM2xUpeAehcndvTcCeENmd3b8HVQxYpaTA
         jyecMx9O4jz9XuYAdwwbExHu2G0MLNm7T/0Pbws4Oqj6rn8872x34/ABUo1Tlbi6Y9SV
         CwONFIuKIxcy0d4KGAgwesSwVs91Lqb13QIiy+UhHPilmrX0BWFsNO6ysNUPGDI5QJfE
         dWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713198338; x=1713803138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oxBkGe7SdmsJXy9vmp58aQDE3BF9aWZY5P/z4wlEcJY=;
        b=LMJccz8I8aLsLWtmj8gVTZ3ATX28bEnhlGsOLVmCZIKpgUJs4mfZ4PNXwf168freuG
         m6C/8lYIFgMUyZ4IEwBIXdf5eOcMq3DODceFdoWk/Ohsk9DdXoNyqtsf0ig2lCTuiWih
         x61S/Iq3csIL7OhFoxKJvJK7M3bfg8lFZXgbtGTG1uwBmw4CHYh8ENoGXs7DtuWp/elz
         CJ3c2RswLpfk2zhOrX/yDFN0dc1SbuQoauBfG2vseDRs6u+aqR8oONofzBCLPcTGZSk5
         D5ADwB+0F2grjgr6/pRXEY7w1wlAtlBQwTR0fEB1YRXa1FDGS9dTy/hTzgb6/2rJuQT8
         z7yQ==
X-Gm-Message-State: AOJu0YxW9gcg1zn/+MPnPKnIuYs2x+pJd+NhH/Y9BDCylvUAoK3Q0Ife
	ypj2F5I7868cSyqJdlx3YVp6nC5YDRpW02pPHjh3GySkdpyUteFcpigRZvfFi/u7i6Enb7318hH
	2
X-Google-Smtp-Source: AGHT+IEafLM3OBi1Kh3R8pGDCh1rQ1+aO4Z3tp7LQrYp//KbR28f9IwLSGyt4rGxRCauKWQSjR6NUA==
X-Received: by 2002:a17:907:6088:b0:a52:1e58:4e0f with SMTP id ht8-20020a170907608800b00a521e584e0fmr8554550ejc.55.1713198338111;
        Mon, 15 Apr 2024 09:25:38 -0700 (PDT)
Received: from localhost (37-48-2-146.nat.epc.tmcz.cz. [37.48.2.146])
        by smtp.gmail.com with ESMTPSA id k21-20020a17090666d500b00a518bcb41c1sm5628404ejp.126.2024.04.15.09.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 09:25:37 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	parav@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	shuah@kernel.org,
	petrm@nvidia.com,
	liuhangbin@gmail.com,
	vladimir.oltean@nxp.com,
	bpoirier@nvidia.com,
	idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: [patch net-next v2 1/6] virtio: add debugfs infrastructure to allow to debug virtio features
Date: Mon, 15 Apr 2024 18:25:25 +0200
Message-ID: <20240415162530.3594670-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415162530.3594670-1-jiri@resnulli.us>
References: <20240415162530.3594670-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Currently there is no way for user to set what features the driver
should obey or not, it is hard wired in the code.

In order to be able to debug the device behavior in case some feature is
disabled, introduce a debugfs infrastructure with couple of files
allowing user to see what features the device advertises and
to set filter for features used by driver.

Example:
$cat /sys/bus/virtio/devices/virtio0/features
1110010111111111111101010000110010000000100000000000000000000000
$ echo "5" >/sys/kernel/debug/virtio/virtio0/filter_feature_add
$ cat /sys/kernel/debug/virtio/virtio0/filter_features
5
$ echo "virtio0" > /sys/bus/virtio/drivers/virtio_net/unbind
$ echo "virtio0" > /sys/bus/virtio/drivers/virtio_net/bind
$ cat /sys/bus/virtio/devices/virtio0/features
1110000111111111111101010000110010000000100000000000000000000000

Note that sysfs "features" know already exists, this patch does not
touch it.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/virtio/Kconfig        |   9 +++
 drivers/virtio/Makefile       |   1 +
 drivers/virtio/virtio.c       |   8 +++
 drivers/virtio/virtio_debug.c | 109 ++++++++++++++++++++++++++++++++++
 include/linux/virtio.h        |  34 +++++++++++
 5 files changed, 161 insertions(+)
 create mode 100644 drivers/virtio/virtio_debug.c

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index c17193544268..fc839a354958 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -178,4 +178,13 @@ config VIRTIO_DMA_SHARED_BUFFER
 	 This option adds a flavor of dma buffers that are backed by
 	 virtio resources.
 
+config VIRTIO_DEBUG
+        bool "Debug facilities"
+        help
+          Enable this to expose debug facilities over debugfs.
+	  This allows to debug features, to see what features the device
+	  advertises and to set filter for features used by driver.
+
+          If unsure, say N.
+
 endif # VIRTIO_MENU
diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index 73ace62af440..58b2b0489fc9 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_VIRTIO_INPUT) += virtio_input.o
 obj-$(CONFIG_VIRTIO_VDPA) += virtio_vdpa.o
 obj-$(CONFIG_VIRTIO_MEM) += virtio_mem.o
 obj-$(CONFIG_VIRTIO_DMA_SHARED_BUFFER) += virtio_dma_buf.o
+obj-$(CONFIG_VIRTIO_DEBUG) += virtio_debug.o
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index f173587893cb..8d9871145e28 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -274,6 +274,9 @@ static int virtio_dev_probe(struct device *_d)
 	else
 		dev->features = driver_features_legacy & device_features;
 
+	/* When debugging, user may filter some features by hand. */
+	virtio_debug_device_filter_features(dev);
+
 	/* Transport features always preserved to pass to finalize_features. */
 	for (i = VIRTIO_TRANSPORT_F_START; i < VIRTIO_TRANSPORT_F_END; i++)
 		if (device_features & (1ULL << i))
@@ -463,6 +466,8 @@ int register_virtio_device(struct virtio_device *dev)
 	/* Acknowledge that we've seen the device. */
 	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
 
+	virtio_debug_device_init(dev);
+
 	/*
 	 * device_add() causes the bus infrastructure to look for a matching
 	 * driver.
@@ -494,6 +499,7 @@ void unregister_virtio_device(struct virtio_device *dev)
 	int index = dev->index; /* save for after device release */
 
 	device_unregister(&dev->dev);
+	virtio_debug_device_exit(dev);
 	ida_free(&virtio_index_ida, index);
 }
 EXPORT_SYMBOL_GPL(unregister_virtio_device);
@@ -588,11 +594,13 @@ static int virtio_init(void)
 {
 	if (bus_register(&virtio_bus) != 0)
 		panic("virtio bus registration failed");
+	virtio_debug_init();
 	return 0;
 }
 
 static void __exit virtio_exit(void)
 {
+	virtio_debug_exit();
 	bus_unregister(&virtio_bus);
 	ida_destroy(&virtio_index_ida);
 }
diff --git a/drivers/virtio/virtio_debug.c b/drivers/virtio/virtio_debug.c
new file mode 100644
index 000000000000..28cf30948939
--- /dev/null
+++ b/drivers/virtio/virtio_debug.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/virtio.h>
+#include <linux/virtio_config.h>
+#include <linux/debugfs.h>
+
+static struct dentry *virtio_debugfs_dir;
+
+static int virtio_debug_device_features_show(struct seq_file *s, void *data)
+{
+	struct virtio_device *dev = s->private;
+	u64 device_features;
+	unsigned int i;
+
+	device_features = dev->config->get_features(dev);
+	for (i = 0; i < BITS_PER_LONG_LONG; i++) {
+		if (device_features & (1ULL << i))
+			seq_printf(s, "%u\n", i);
+	}
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(virtio_debug_device_features);
+
+static int virtio_debug_filter_features_show(struct seq_file *s, void *data)
+{
+	struct virtio_device *dev = s->private;
+	unsigned int i;
+
+	for (i = 0; i < BITS_PER_LONG_LONG; i++) {
+		if (dev->debugfs_filter_features & (1ULL << i))
+			seq_printf(s, "%u\n", i);
+	}
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(virtio_debug_filter_features);
+
+static int virtio_debug_filter_features_clear(void *data, u64 val)
+{
+	struct virtio_device *dev = data;
+
+	if (val == 1)
+		dev->debugfs_filter_features = 0;
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(virtio_debug_filter_features_clear_fops, NULL,
+			 virtio_debug_filter_features_clear, "%llu\n");
+
+static int virtio_debug_filter_feature_add(void *data, u64 val)
+{
+	struct virtio_device *dev = data;
+
+	if (val >= BITS_PER_LONG_LONG)
+		return -EINVAL;
+	dev->debugfs_filter_features |= BIT_ULL_MASK(val);
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(virtio_debug_filter_feature_add_fops, NULL,
+			 virtio_debug_filter_feature_add, "%llu\n");
+
+static int virtio_debug_filter_feature_del(void *data, u64 val)
+{
+	struct virtio_device *dev = data;
+
+	if (val >= BITS_PER_LONG_LONG)
+		return -EINVAL;
+	dev->debugfs_filter_features &= ~BIT_ULL_MASK(val);
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(virtio_debug_filter_feature_del_fops, NULL,
+			 virtio_debug_filter_feature_del, "%llu\n");
+
+void virtio_debug_device_init(struct virtio_device *dev)
+{
+	dev->debugfs_dir = debugfs_create_dir(dev_name(&dev->dev),
+					      virtio_debugfs_dir);
+	debugfs_create_file("device_features", 0400, dev->debugfs_dir, dev,
+			    &virtio_debug_device_features_fops);
+	debugfs_create_file("filter_features", 0400, dev->debugfs_dir, dev,
+			    &virtio_debug_filter_features_fops);
+	debugfs_create_file("filter_features_clear", 0200, dev->debugfs_dir, dev,
+			    &virtio_debug_filter_features_clear_fops);
+	debugfs_create_file("filter_feature_add", 0200, dev->debugfs_dir, dev,
+			    &virtio_debug_filter_feature_add_fops);
+	debugfs_create_file("filter_feature_del", 0200, dev->debugfs_dir, dev,
+			    &virtio_debug_filter_feature_del_fops);
+}
+
+void virtio_debug_device_filter_features(struct virtio_device *dev)
+{
+	dev->features &= ~dev->debugfs_filter_features;
+}
+
+void virtio_debug_device_exit(struct virtio_device *dev)
+{
+	debugfs_remove_recursive(dev->debugfs_dir);
+}
+
+void virtio_debug_init(void)
+{
+	virtio_debugfs_dir = debugfs_create_dir("virtio", NULL);
+}
+
+void virtio_debug_exit(void)
+{
+	debugfs_remove_recursive(virtio_debugfs_dir);
+}
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index b0201747a263..ab3f36c39686 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -126,6 +126,7 @@ struct virtio_admin_cmd {
  * @vqs: the list of virtqueues for this device.
  * @features: the features supported by both driver and device.
  * @priv: private pointer for the driver's use.
+ * @debugfs_dir: debugfs directory entry.
  */
 struct virtio_device {
 	int index;
@@ -141,6 +142,10 @@ struct virtio_device {
 	struct list_head vqs;
 	u64 features;
 	void *priv;
+#ifdef CONFIG_VIRTIO_DEBUG
+	struct dentry *debugfs_dir;
+	u64 debugfs_filter_features;
+#endif
 };
 
 #define dev_to_virtio(_dev)	container_of_const(_dev, struct virtio_device, dev)
@@ -234,4 +239,33 @@ void virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq, dma_addr_t a
 void virtqueue_dma_sync_single_range_for_device(struct virtqueue *_vq, dma_addr_t addr,
 						unsigned long offset, size_t size,
 						enum dma_data_direction dir);
+
+#ifdef CONFIG_VIRTIO_DEBUG
+void virtio_debug_device_init(struct virtio_device *dev);
+void virtio_debug_device_exit(struct virtio_device *dev);
+void virtio_debug_device_filter_features(struct virtio_device *dev);
+void virtio_debug_init(void);
+void virtio_debug_exit(void);
+#else
+static inline void virtio_debug_device_init(struct virtio_device *dev)
+{
+}
+
+static inline void virtio_debug_device_exit(struct virtio_device *dev)
+{
+}
+
+static inline void virtio_debug_device_filter_features(struct virtio_device *dev)
+{
+}
+
+static inline void virtio_debug_init(void)
+{
+}
+
+static inline void virtio_debug_exit(void)
+{
+}
+#endif
+
 #endif /* _LINUX_VIRTIO_H */
-- 
2.44.0


