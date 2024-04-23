Return-Path: <netdev+bounces-90446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5498AE273
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 12:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D02091C21B1A
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 10:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38814762E8;
	Tue, 23 Apr 2024 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="p4oE/O5F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A73575802
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 10:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868880; cv=none; b=NV6nd8BtriK1etBOu+ZTHruVjiCFww5BPe0YdQ52aM/xCRLQ0gt/KLN5tw3ChS1N5vpu++kNeIcXc6ImcX0HNd03aWFOSae6GsH+XC2GliYjjMDC2ZAvt7/Jz/25kM88WMOEgzqRenkaUmojO/EUOQSbr3twMAuF3EtCCuug7gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868880; c=relaxed/simple;
	bh=6+cdGuSohVVcZsEtEaB+WUeWNhRp735twxzPhawYX2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PhaZ8x2kyXhXoBP2ZZFmGG7CqXLyIcuy15wbi7XDqEjO5YD6zOu2tPs/sH1obwU/5iq7peRymixHddn/+IgyjKjh4jIl+s0RTpcZCoWQYQvIMTY3uDDgO4wG1Zi9xzFfXAbl/tG+yPZdvfIeE4Xydob/xAjgbD4K11UK1gdb7DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=p4oE/O5F; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a557044f2ddso604275666b.2
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 03:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713868876; x=1714473676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIem1pG4tCyS+CC0IvtQjtNP5aTmhFvjHO5o/QyAp+k=;
        b=p4oE/O5FmezdJwNBmdTLAR98Tbm5AqcogyUyfT3W5x2F6SGGKcXTnnes8A+pCDkQhB
         yLyH0MD5+Ax5Izb8qyiSpXWWmL8MUxGYuUSht+aNMu7BTY72rJYPepDjj/yJ9m7njBgb
         YbQTSwkpDdnsVEGsE5zPMbdx/x/HaMIrVWujaVSDaePBekxdy1RJFk29LWu1dcr927sI
         +Fy1YNHGcb0HTeAhxSCMp0kX1GJlBuggYPQr2QZaoRSbNXAUwqdF3fJvZoF3aEOjEAn3
         V9f7IScplENBKt+5dxeIgerOLadmK6gLQws/eHipQ4WtrziC6ODFW+6nqQn43ZvSnag7
         nEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713868876; x=1714473676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIem1pG4tCyS+CC0IvtQjtNP5aTmhFvjHO5o/QyAp+k=;
        b=ORfEAdKo/oI4L1+I600ulV5kII2WgVSo8RL06/5O6zmgaVCWMo1pHkqJZ4I9aawvDu
         4uxd4eGMz6Y7HCvOiwnHNykHPrezi4W5VQjIb/JZ1UtCAGMboPQCWzugYlBLPzCCKH+h
         6bc2hXU4kydoWXy4k9MUppJlpHr8zDvHzyfpPk1inDyXbgX3EoeEMjkx+UELCJl3prlX
         Z6J58q+OR2JkXGjFnqB8EXUP4rx7hdWza2XOcYImuqsGPVdZ+fpcZ7KTq7NvYB+Ubjf4
         0nEjOpu06P+wjXO1W1POunnS9ciGasoEPNIWn7Y54Iaolnbj8Y9OHyY5ccw0BPM2FSyY
         ZlRg==
X-Gm-Message-State: AOJu0YyUspYkwEtMkpkJ3cedkVc3VKJR3rELV1XTTjKzYdp9tlJgl20w
	Eu13PDWtxR+be0800/4Nc6oowNyQflxZN8O/+kTDwm8w6K2I57JcibsUjaQtD2w2vdb53s4Pi8J
	i
X-Google-Smtp-Source: AGHT+IHjeDuPAaOV0jcKax6AfPSCrin/KVoZ3J4C4kw2DxcV76sXDsmxsEQE2SlHmnIHrLboHOhYYA==
X-Received: by 2002:a17:906:3196:b0:a51:b3cb:cdca with SMTP id 22-20020a170906319600b00a51b3cbcdcamr9428625ejy.26.1713868876199;
        Tue, 23 Apr 2024 03:41:16 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id z15-20020a170906668f00b00a51d073da7esm6856212ejo.82.2024.04.23.03.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 03:41:14 -0700 (PDT)
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
Subject: [patch net-next v5 repost 1/5] virtio: add debugfs infrastructure to allow to debug virtio features
Date: Tue, 23 Apr 2024 12:41:05 +0200
Message-ID: <20240423104109.3880713-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423104109.3880713-1-jiri@resnulli.us>
References: <20240423104109.3880713-1-jiri@resnulli.us>
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

Note that sysfs "features" now already exists, this patch does not
touch it.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v4->v5:
- added exported symbols, adjusted Kconfig a bit (whitespace)
v3->v4:
- s/know/now/ typo fix in description
v2->v3:
- added missing kdoc for debugfs_filter_features struct field
---
 drivers/virtio/Kconfig        |  10 +++
 drivers/virtio/Makefile       |   1 +
 drivers/virtio/virtio.c       |   8 +++
 drivers/virtio/virtio_debug.c | 114 ++++++++++++++++++++++++++++++++++
 include/linux/virtio.h        |  35 +++++++++++
 5 files changed, 168 insertions(+)
 create mode 100644 drivers/virtio/virtio_debug.c

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index c17193544268..6284538a8184 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -178,4 +178,14 @@ config VIRTIO_DMA_SHARED_BUFFER
 	 This option adds a flavor of dma buffers that are backed by
 	 virtio resources.
 
+config VIRTIO_DEBUG
+	bool "Debug facilities"
+	depends on VIRTIO
+	help
+	  Enable this to expose debug facilities over debugfs.
+	  This allows to debug features, to see what features the device
+	  advertises and to set filter for features used by driver.
+
+	  If unsure, say N.
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
index 9510c551dce8..b968b2aa5f4d 100644
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
@@ -465,6 +468,8 @@ int register_virtio_device(struct virtio_device *dev)
 	/* Acknowledge that we've seen the device. */
 	virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
 
+	virtio_debug_device_init(dev);
+
 	/*
 	 * device_add() causes the bus infrastructure to look for a matching
 	 * driver.
@@ -496,6 +501,7 @@ void unregister_virtio_device(struct virtio_device *dev)
 	int index = dev->index; /* save for after device release */
 
 	device_unregister(&dev->dev);
+	virtio_debug_device_exit(dev);
 	ida_free(&virtio_index_ida, index);
 }
 EXPORT_SYMBOL_GPL(unregister_virtio_device);
@@ -590,11 +596,13 @@ static int virtio_init(void)
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
index 000000000000..95c8fc7705bb
--- /dev/null
+++ b/drivers/virtio/virtio_debug.c
@@ -0,0 +1,114 @@
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
+EXPORT_SYMBOL_GPL(virtio_debug_device_init);
+
+void virtio_debug_device_filter_features(struct virtio_device *dev)
+{
+	dev->features &= ~dev->debugfs_filter_features;
+}
+EXPORT_SYMBOL_GPL(virtio_debug_device_filter_features);
+
+void virtio_debug_device_exit(struct virtio_device *dev)
+{
+	debugfs_remove_recursive(dev->debugfs_dir);
+}
+EXPORT_SYMBOL_GPL(virtio_debug_device_exit);
+
+void virtio_debug_init(void)
+{
+	virtio_debugfs_dir = debugfs_create_dir("virtio", NULL);
+}
+EXPORT_SYMBOL_GPL(virtio_debug_init);
+
+void virtio_debug_exit(void)
+{
+	debugfs_remove_recursive(virtio_debugfs_dir);
+}
+EXPORT_SYMBOL_GPL(virtio_debug_exit);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 26c4325aa373..96fea920873b 100644
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
@@ -237,4 +243,33 @@ void virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq, dma_addr_t a
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


