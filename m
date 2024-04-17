Return-Path: <netdev+bounces-88804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C0D8A8945
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 18:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37748B218B4
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 16:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8B6171082;
	Wed, 17 Apr 2024 16:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="qmJAnksk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D16171070
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 16:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372362; cv=none; b=aX3WmGuvw2RvYYeVkylvMbHEeRS4fbMbwhbXkReQsxdsKjbvacxFxw6bgOdZHCE9G3hbsyBS8xfGaGGEq19tdWujoT+jQys1oaWCejgaGGFxTmeKJ2LS2VYXbx/nre5BovpfMVgCL/8FmpMCxRTLsbEWQ+yIrCuh/R4Yj+bx+r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372362; c=relaxed/simple;
	bh=Z1jeF7qulVW1TKjqXw6uzDM0QuhOgT0g9J8apBaAcXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGU/263tua067hiOMAEMXoK2Nm5u//+QZKtI1YoHMI+9OgLCcqE6v+jSVeyuXHdawAhgFJI+7/uq/yRq2IH0Vg5eIxtQDPJQP83DkYkNDW5skg/dnUQN0O1BD33i5ov+S9eID+EHIUdUutOShbOOUPZlhlTS6qSdMRkC80qsIGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=qmJAnksk; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-518a56cdc03so5377237e87.1
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 09:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713372358; x=1713977158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ZJaM2/V0pnubO2BGW86GHU/5TxU4Qdi1H/FL0P6KP4=;
        b=qmJAnksk6ZPB9ue41zsOF0pIVAmIUa7i/7soZxGvi7h+XA+EaGL3fltM5dlsexCKCs
         8csRNZM6pBlN3c9po0j57uiCiIOi+3AC80wv9kakC6TlyiTxnPgYZ0GBy3fPtcYQ1kvP
         jMNOAPuRZ73wdxi+74O79eht5yHHshvn1Z1veaZGGJwlzP+Hm4BqEuN7wqF4it1NOS3+
         uxx4wXl88IL+XXl4FHMrThUOh+tXqnyR21Us1N7OVsNw5zO+l6c1lcFk6KqqCesgHWyd
         vpYDARM2IymtTYIG5VhfLeHoqy4+U8Qspkwfq1P7HesNWjOHRGRG/bXBb748IrC3z0Sh
         sWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713372358; x=1713977158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZJaM2/V0pnubO2BGW86GHU/5TxU4Qdi1H/FL0P6KP4=;
        b=aP4QA+ewaT8SQ6C5LIqy4bxO/WJ9cbqGh9fGoJ3dTxoMEOYIiEnHLqDIoYe6nurD7i
         nAwPlSQi/Noqwzq5PUonSJ4nece7OjFb77Q8oQc2EsmO3xIXgDR3/suqkyr3F+m7t/0y
         NbVnFb+jYW2suTfFJ8HspLSuHaAeafknmjezLIblwAeWOLZUvIh2fMcgTFBYKM/eficg
         9Wz8+LO8SfQpXTK5D6HaNYdrQYQ+gi1oTNdLZ2PFbm4NWZ41Nwxc5uC13KXVkcHBfoIs
         T/ViA0NNAk72LL/qLilpBtgHHUQrUjaQXxlqwsqj2DVXd8k0b6WPShJtD+tjc1lv62hC
         c1Tg==
X-Gm-Message-State: AOJu0YwGcrfudevzzUeaGIogTBo+YIKbrcrQ4Fql9y/pu0EgughphIbz
	TBUNRrneNWkLVY5PakQTwd/i+R8F+q5SFoyvrDf1f9JIyVon/d4ePGbfABScytVlTlODfMwv/8q
	D
X-Google-Smtp-Source: AGHT+IFJRy4WGVC99gUa+NMpTN/n+ZnaXpnDdQSDf7b49mSyGVi+4F9pz0oQ6VVETvmFdL+w8DRctw==
X-Received: by 2002:ac2:4906:0:b0:518:f2f8:edc6 with SMTP id n6-20020ac24906000000b00518f2f8edc6mr5025571lfi.63.1713372357840;
        Wed, 17 Apr 2024 09:45:57 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id h14-20020a1709070b0e00b00a518c69c4e3sm8261964ejl.23.2024.04.17.09.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 09:45:57 -0700 (PDT)
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
Subject: [patch net-next v3 1/6] virtio: add debugfs infrastructure to allow to debug virtio features
Date: Wed, 17 Apr 2024 18:45:49 +0200
Message-ID: <20240417164554.3651321-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417164554.3651321-1-jiri@resnulli.us>
References: <20240417164554.3651321-1-jiri@resnulli.us>
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
v2->v3:
- added missing kdoc for debugfs_filter_features struct field
---
 drivers/virtio/Kconfig        |   9 +++
 drivers/virtio/Makefile       |   1 +
 drivers/virtio/virtio.c       |   8 +++
 drivers/virtio/virtio_debug.c | 109 ++++++++++++++++++++++++++++++++++
 include/linux/virtio.h        |  35 +++++++++++
 5 files changed, 162 insertions(+)
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
index b0201747a263..c5f363b9f4d8 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -126,6 +126,8 @@ struct virtio_admin_cmd {
  * @vqs: the list of virtqueues for this device.
  * @features: the features supported by both driver and device.
  * @priv: private pointer for the driver's use.
+ * @debugfs_dir: debugfs directory entry.
+ * @debugfs_filter_features: features to be filtered set by debugfs.
  */
 struct virtio_device {
 	int index;
@@ -141,6 +143,10 @@ struct virtio_device {
 	struct list_head vqs;
 	u64 features;
 	void *priv;
+#ifdef CONFIG_VIRTIO_DEBUG
+	struct dentry *debugfs_dir;
+	u64 debugfs_filter_features;
+#endif
 };
 
 #define dev_to_virtio(_dev)	container_of_const(_dev, struct virtio_device, dev)
@@ -234,4 +240,33 @@ void virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq, dma_addr_t a
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


