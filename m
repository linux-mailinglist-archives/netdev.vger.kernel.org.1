Return-Path: <netdev+bounces-245095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F93BCC6B51
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 10:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9C5D30EF210
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 09:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5C2347BC7;
	Wed, 17 Dec 2025 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="j10g0qJq"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A81C346FB6;
	Wed, 17 Dec 2025 08:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765961508; cv=none; b=b6NMAXQu+AMauiSqc65nTaaOLeE+/vYIJyc4xokOlowJTmHwf5eBc5o/kiot0ZcNe/bIRJyO937MNITcND8D+w5pGajzUkoXqBNWgH3FOOmNOpa17WowSaZDh+3zbnICwN38yH8tFHFkwIOGs4aW3zqLyjcinX4Acpx5DRr2Cj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765961508; c=relaxed/simple;
	bh=2uajHW0lZ40KZxddO+TitNivgZ68j5laVLJLASSqaGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pqIzsEbKlUc/DmoE02uUXHbGgfBYJ4AVkPb3WLogov/98J302kYZv0PC0yfeiKWv2BsIeDwGHrhcf3Dx1mmWPz7GkO/PID1U8Vbg7eDFpwBNLczG/XS1qcQhSctZF2dw26to4D4zvZX7eZJe92ml1RSpImgCl2seJGoGD/4o6Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=j10g0qJq; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=gT
	r9cXlUolcdcafwK8bWD4/QDXm/K6s1AH54NIQvIJI=; b=j10g0qJqPpJtpnArfY
	KI8+hiYsFFe1mXhl2+cbmrKtxInvvV6sUSPN72lgIUua+D5VFSROfVHb1KKH+Rbs
	xMc5ahHWGf0EMN6UiFM+TEniB51kcCP0qxsyPoNvBCNtQ/tHXAfPqVA0vnw91ytp
	x7vSielfcg6C/lrTH+BCHZKak=
Received: from xwm-TianYi510Pro-14IMB.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wAXSZ7lbkJp2ZeZAw--.42656S6;
	Wed, 17 Dec 2025 16:50:47 +0800 (CST)
From: Xiong Weimin <15927021679@163.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	xiongweimin <xiongweimin@kylinos.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/rdma: Implement vhost-user RDMA device with PCI support
Date: Wed, 17 Dec 2025 16:49:49 +0800
Message-ID: <20251217085044.5432-3-15927021679@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217085044.5432-1-15927021679@163.com>
References: <20251217085044.5432-1-15927021679@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXSZ7lbkJp2ZeZAw--.42656S6
X-Coremail-Antispam: 1Uf129KBjvAXoWftr48Cw1DXFyrJry7Aw4kXrb_yoW5WF13to
	W7Jrya9F4rtw1UCFsY9r17ArW2gFyj9F17Cr4S9rZFqayxJw1DtF97Ka9rJ3yrCr4fK34x
	CryfG3yxGa15AFZ3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUwE__UUUUU
X-CM-SenderInfo: jprvmjixqsilmxzbiqqrwthudrp/xtbC0QjASWlCbuicHwAA3+

From: xiongweimin <xiongweimin@kylinos.cn>

This commit introduces a complete vhost-user RDMA device implementation
including PCI interface bindings. The implementation enables RDMA operations
through a vhost-user backend and provides a PCI device interface for guests.

Key components included:
1. PCI device binding layer:
   - Automatic MSI-X vector allocation (queues + 1)
   - Virtio 1.0 compliance (no legacy support)
   - Standard Red Hat vendor/device IDs
   - Bootindex property passthrough
   - Transitional/non-transitional device variants

2. Core vhost-user RDMA device:
   - Chardev-based backend communication
   - Dynamic connection management with reconnect
   - 256 virtqueues (512 entries each)
   - Feature negotiation (VIRTIO_F_VERSION_1, INDIRECT_DESC, etc.)
   - Config space handling with live updates
   - VM state preservation for migration
   - Graceful start/stop sequences
   - Host notifier management

3. Key functionalities:
   - Automatic backend connection management
   - Config change notification handling
   - Queue enablement on guest activity
   - Error handling for backend disconnections
   - Resource cleanup on device unrealize

The implementation follows virtio and vhost-user standards, providing
a foundation for RDMA virtualization using user-space backends.

CC: qemu-devel@nongnu.org
Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
Change-Id: I3299219282bc98800422e132298006ed1b3637da
---
 hw/rdma/Kconfig                             |   5 +
 hw/rdma/meson.build                         |   5 +
 hw/rdma/vhost-user-rdma.c                   | 463 ++++++++++++++++++++
 hw/virtio/meson.build                       |   1 +
 hw/virtio/vhost-user-rdma-pci.c             |  93 ++++
 hw/virtio/vhost-user.c                      |  11 +
 hw/virtio/vhost.c                           |   2 +
 hw/virtio/virtio.c                          |   1 +
 include/hw/pci/pci.h                        |   1 +
 include/hw/virtio/vhost-user-rdma.h         |  43 ++
 include/hw/virtio/virtio.h                  |   2 +-
 include/standard-headers/linux/virtio_ids.h |   1 +
 include/standard-headers/rdma/virtio_rdma.h |  60 +++
 13 files changed, 687 insertions(+), 1 deletion(-)
 create mode 100644 hw/rdma/vhost-user-rdma.c
 create mode 100644 hw/virtio/vhost-user-rdma-pci.c
 create mode 100644 include/hw/virtio/vhost-user-rdma.h
 create mode 100644 include/standard-headers/rdma/virtio_rdma.h

diff --git a/hw/rdma/Kconfig b/hw/rdma/Kconfig
index 840320bdc0..1cb7ee72ab 100644
--- a/hw/rdma/Kconfig
+++ b/hw/rdma/Kconfig
@@ -1,3 +1,8 @@
 config VMW_PVRDMA
     default y if PCI_DEVICES
     depends on PVRDMA && MSI_NONBROKEN && VMXNET3_PCI
+
+config VHOST_USER_RDMA
+    bool
+    default y if VIRTIO_PCI
+    depends on VIRTIO && VHOST_USER && LINUX
diff --git a/hw/rdma/meson.build b/hw/rdma/meson.build
index 363c9b8c83..51c47b2d44 100644
--- a/hw/rdma/meson.build
+++ b/hw/rdma/meson.build
@@ -10,3 +10,8 @@ specific_ss.add(when: 'CONFIG_VMW_PVRDMA', if_true: files(
   'vmw/pvrdma_dev_ring.c',
   'vmw/pvrdma_main.c',
 ))
+
+
+specific_ss.add(when: 'CONFIG_VHOST_USER_RDMA', if_true: files(
+  'vhost-user-rdma.c',
+))
diff --git a/hw/rdma/vhost-user-rdma.c b/hw/rdma/vhost-user-rdma.c
new file mode 100644
index 0000000000..e54b349ec4
--- /dev/null
+++ b/hw/rdma/vhost-user-rdma.c
@@ -0,0 +1,463 @@
+/*
+ * RDMA device interface
+ *
+ * Copyright (C) 2025 Kylinsoft
+ *
+ * Authors:
+ *		Xiong Weimin <xiongweimin@kylinos.cn>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/cutils.h"
+#include "hw/qdev-core.h"
+#include "hw/qdev-properties.h"
+#include "hw/virtio/vhost.h"
+#include "hw/virtio/vhost-user-rdma.h"
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/virtio-bus.h"
+#include "hw/virtio/virtio-access.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/runstate.h"
+
+#define VHOST_USER_RDMA_NUM_QUEUES 256
+#define VHOST_USER_RDMA_QUEUE_SIZE 512
+
+static const int user_feature_bits[] = {
+	VIRTIO_F_VERSION_1,
+	VIRTIO_RING_F_INDIRECT_DESC,
+	VIRTIO_RING_F_EVENT_IDX,
+	VIRTIO_F_NOTIFY_ON_EMPTY,
+	VHOST_INVALID_FEATURE_BIT
+};
+
+static void vhost_user_rdma_event(void *opaque, QEMUChrEvent event);
+
+static int vhost_user_rdma_start(VirtIODevice *vdev)
+{
+	VHostUserRdma *r = VHOST_USER_RDMA(vdev);
+	BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
+	VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+	int i, ret;
+
+	if (!k->set_guest_notifiers) {
+		error_report("binding does not support guest notifiers");
+		return -ENOSYS;
+	}
+
+	ret = vhost_dev_enable_notifiers(&r->dev, vdev);
+	if (ret < 0) {
+		error_report("Error enabling host notifiers: %d", -ret);
+		return ret;
+	}
+
+	ret = k->set_guest_notifiers(qbus->parent, r->dev.nvqs, true);
+	if (ret < 0) {
+		error_report("Error binding guest notifier: %d", -ret);
+		goto err_host_notifiers;
+	}
+
+	r->dev.acked_features = vdev->guest_features;
+
+	ret = vhost_dev_start(&r->dev, vdev, true);
+	if (ret < 0) {
+		error_report("Error starting vhost: %d", -ret);
+		goto err_guest_notifiers;
+	}
+	r->started_vu = true;
+
+	for (i = 0; i < r->dev.nvqs; i++) {
+		vhost_virtqueue_mask(&r->dev, vdev, i, false);
+	}
+
+	return ret;
+
+err_guest_notifiers:
+	k->set_guest_notifiers(qbus->parent, r->dev.nvqs, false);
+err_host_notifiers:
+	vhost_dev_disable_notifiers(&r->dev, vdev);
+	return ret;
+}
+
+static void vhost_user_rdma_stop(VirtIODevice *vdev)
+{
+	VHostUserRdma *r = VHOST_USER_RDMA(vdev);
+	BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
+	VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+	int ret;
+
+	if (!r->started_vu) {
+		return;
+	}
+	r->started_vu = false;
+
+	if (!k->set_guest_notifiers) {
+		return;
+	}
+
+	vhost_dev_stop(&r->dev, vdev, true);
+
+	ret = k->set_guest_notifiers(qbus->parent, r->dev.nvqs, false);
+	if (ret < 0) {
+		error_report("vhost guest notifier cleanup failed: %d", ret);
+		return;
+	}
+
+	vhost_dev_disable_notifiers(&r->dev, vdev);
+}
+
+static int vhost_user_rdma_handle_config_change(struct vhost_dev *dev)
+{
+	int ret;
+	VHostUserRdma *r = VHOST_USER_RDMA(dev->vdev);
+	Error *local_err = NULL;
+
+	ret = vhost_dev_get_config(dev, (uint8_t *)&r->rdmacfg,
+							sizeof(struct virtio_rdma_config), &local_err);
+	if (ret < 0) {
+		error_report("get config space failed");
+		return -1;
+	}
+
+	virtio_notify_config(dev->vdev);
+	return 0;
+}
+
+const VhostDevConfigOps rdma_ops = {
+	.vhost_dev_config_notifier = vhost_user_rdma_handle_config_change,
+};
+
+static int vhost_user_rdma_connect(DeviceState *dev)
+{
+	VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+	VHostUserRdma *r = VHOST_USER_RDMA(vdev);
+	int ret = 0;
+	Error *local_err = NULL;
+
+	info_report("vhost_user_rdma: vhost connect");
+
+	if (r->connected) {
+		return 0;
+	}
+	r->connected = true;
+
+	r->dev.nvqs = r->num_queues;
+	r->dev.vqs = r->vhost_vqs;
+	r->dev.vq_index = 0;
+	r->dev.backend_features = 0;
+
+	vhost_dev_set_config_notifier(&r->dev, &rdma_ops);
+
+	ret = vhost_dev_init(&r->dev, &r->vhost_user,
+						VHOST_BACKEND_TYPE_USER, 0, &local_err);
+	if (ret < 0) {
+		error_report("vhost-user-rdma: vhost initialization failed: %s",
+					strerror(-ret));
+		return ret;
+	}
+
+	/* restore vhost state */
+	if (virtio_device_started(vdev, vdev->status)) {
+		info_report("vhost_user_rdma: vhost ss?");
+		ret = vhost_user_rdma_start(vdev);
+		if (ret < 0) {
+			error_report("vhost-user-rdma: vhost start failed: %s",
+						strerror(-ret));
+			return ret;
+		}
+	}
+	info_report("vhost_user_rdma: vhost connect success");
+	return 0;
+}
+
+static void vhost_user_rdma_disconnect(DeviceState *dev)
+{
+	VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+	VHostUserRdma *s = VHOST_USER_RDMA(vdev);
+
+	if (!s->connected) {
+		return;
+	}
+	s->connected = false;
+
+	vhost_user_rdma_stop(vdev);
+
+	vhost_dev_cleanup(&s->dev);
+}
+
+static void vhost_user_rdma_chr_closed_bh(void *opaque)
+{
+	DeviceState *dev = opaque;
+	VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+	VHostUserRdma *r = VHOST_USER_RDMA(vdev);
+
+	vhost_user_rdma_disconnect(dev);
+	qemu_chr_fe_set_handlers(&r->chardev, NULL, NULL, vhost_user_rdma_event,
+			NULL, opaque, NULL, true);
+}
+
+static void vhost_user_rdma_event(void *opaque, QEMUChrEvent event)
+{
+	DeviceState *dev = opaque;
+	VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+	VHostUserRdma *r = VHOST_USER_RDMA(vdev);
+
+	switch (event) {
+	case CHR_EVENT_OPENED:
+		if (vhost_user_rdma_connect(dev) < 0) {
+			qemu_chr_fe_disconnect(&r->chardev);
+			return;
+		}
+		break;
+	case CHR_EVENT_CLOSED:
+		if (runstate_is_running()) {
+			AioContext *ctx = qemu_get_current_aio_context();
+
+			qemu_chr_fe_set_handlers(&r->chardev, NULL, NULL, NULL, NULL,
+					NULL, NULL, false);
+			aio_bh_schedule_oneshot(ctx, vhost_user_rdma_chr_closed_bh, opaque);
+		}
+
+		r->dev.started = false;
+		break;
+	case CHR_EVENT_BREAK:
+	case CHR_EVENT_MUX_IN:
+	case CHR_EVENT_MUX_OUT:
+		/* Ignore */
+		break;
+	}
+}
+
+static void vhost_user_rdma_handle_output(VirtIODevice *vdev, VirtQueue *vq)
+{
+	VHostUserRdma *r = VHOST_USER_RDMA(vdev);
+	int i, ret;
+
+	if (!vdev->start_on_kick) {
+		return;
+	}
+
+	if (!r->connected) {
+		return;
+	}
+
+	if (r->dev.started) {
+		return;
+	}
+
+	ret = vhost_user_rdma_start(vdev);
+	if (ret < 0) {
+		qemu_chr_fe_disconnect(&r->chardev);
+		return;
+	}
+
+	for (i = 0; i < r->dev.nvqs; i++) {
+		VirtQueue *kick_vq = virtio_get_queue(vdev, i);
+
+		if (!virtio_queue_get_desc_addr(vdev, i)) {
+			continue;
+		}
+		event_notifier_set(virtio_queue_get_host_notifier(kick_vq));
+	}
+}
+
+static void vhost_user_rdma_update_config(VirtIODevice *vdev, uint8_t *config)
+{
+	VHostUserRdma *r = VHOST_USER_RDMA(vdev);
+
+	memcpy(config, &r->rdmacfg, sizeof(struct virtio_rdma_config));
+}
+
+static void vhost_user_rdma_set_config(VirtIODevice *vdev,
+									const uint8_t *config)
+{
+	/* nothing to do */
+}
+
+static uint64_t vhost_user_rdma_get_features(VirtIODevice *vdev,
+											uint64_t features,
+											Error **errp)
+{
+	VHostUserRdma *s = VHOST_USER_RDMA(vdev);
+
+	return vhost_get_features(&s->dev, user_feature_bits, features);
+}
+
+static void vhost_user_rdma_set_status(VirtIODevice *vdev, uint8_t status)
+{
+	VHostUserRdma *r = VHOST_USER_RDMA(vdev);
+	bool should_start = virtio_device_started(vdev, status);
+	int ret;
+
+	if (!vdev->vm_running) {
+		should_start = false;
+	}
+
+	if (!r->connected) {
+		return;
+	}
+
+	if (r->dev.started == should_start) {
+		return;
+	}
+
+	if (should_start) {
+		ret = vhost_user_rdma_start(vdev);
+		if (ret < 0) {
+			error_report("vhost-user-rdma: vhost start failed: %s",
+						strerror(-ret));
+			qemu_chr_fe_disconnect(&r->chardev);
+		}
+	} else {
+		vhost_user_rdma_stop(vdev);
+	}
+}
+
+static void vhost_user_rdma_device_realize(DeviceState *dev, Error **errp)
+{
+	VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+	VHostUserRdma *r = VHOST_USER_RDMA(vdev);
+	Error *err = NULL;
+	int i, ret;
+
+	if (!r->chardev.chr) {
+		error_setg(errp, "vhost-user-rdma: chardev is mandatory");
+		return;
+	}
+
+	r->num_queues = VHOST_USER_RDMA_NUM_QUEUES;
+
+	if (r->num_queues > VIRTIO_QUEUE_MAX) {
+		error_setg(errp, "vhost-user-rdma: invalid number of IO queues");
+		return;
+	}
+
+	if (!vhost_user_init(&r->vhost_user, &r->chardev, errp)) {
+		return;
+	}
+
+	virtio_init(vdev, VIRTIO_ID_RDMA, sizeof(struct virtio_rdma_config));
+
+	r->virtqs = g_new(VirtQueue *, r->num_queues);
+
+	for (i = 0; i < r->num_queues; i++) {
+		r->virtqs[i] = virtio_add_queue(vdev, VHOST_USER_RDMA_QUEUE_SIZE,
+										vhost_user_rdma_handle_output);
+	}
+
+	r->vhost_vqs = g_new0(struct vhost_virtqueue, r->num_queues);
+	r->connected = false;
+
+	qemu_chr_fe_set_handlers(&r->chardev,  NULL, NULL, vhost_user_rdma_event,
+							NULL, (void *)dev, NULL, true);
+
+reconnect:
+	if (qemu_chr_fe_wait_connected(&r->chardev, &err) < 0) {
+		error_report_err(err);
+		goto virtio_err;
+	}
+
+	/* check whether vhost_user_rdma_connect() failed or not */
+	if (!r->connected) {
+		goto reconnect;
+	}
+
+	ret = vhost_dev_get_config(&r->dev, (uint8_t *)&r->rdmacfg,
+							sizeof(struct virtio_rdma_config), &err);
+	if (ret < 0) {
+		error_report("vhost-user-rdma: get rdma config failed");
+		goto reconnect;
+	}
+
+	return;
+
+virtio_err:
+	g_free(r->vhost_vqs);
+	r->vhost_vqs = NULL;
+	for (i = 0; i < r->num_queues; i++) {
+		virtio_delete_queue(r->virtqs[i]);
+	}
+	g_free(r->virtqs);
+	virtio_cleanup(vdev);
+	vhost_user_cleanup(&r->vhost_user);
+}
+
+static void vhost_user_rdma_device_unrealize(DeviceState *dev)
+{
+	VirtIODevice *vdev = VIRTIO_DEVICE(dev);
+	VHostUserRdma *r = VHOST_USER_RDMA(dev);
+	int i;
+
+	virtio_set_status(vdev, 0);
+	qemu_chr_fe_set_handlers(&r->chardev,  NULL, NULL, NULL,
+							NULL, NULL, NULL, false);
+	vhost_dev_cleanup(&r->dev);
+	g_free(r->vhost_vqs);
+	r->vhost_vqs = NULL;
+	for (i = 0; i < r->num_queues; i++) {
+		virtio_delete_queue(r->virtqs[i]);
+	}
+	g_free(r->virtqs);
+	virtio_cleanup(vdev);
+	vhost_user_cleanup(&r->vhost_user);
+}
+
+static void vhost_user_rdma_instance_init(Object *obj)
+{
+	VHostUserRdma *r = VHOST_USER_RDMA(obj);
+
+	device_add_bootindex_property(obj, &r->bootindex, "bootindex",
+								"bootindex", DEVICE(obj));
+}
+
+static const VMStateDescription vmstate_vhost_user_rdma = {
+	.name = "vhost-user-rdma",
+	.minimum_version_id = 1,
+	.version_id = 1,
+	.fields = (VMStateField[]) {
+		VMSTATE_VIRTIO_DEVICE,
+		VMSTATE_END_OF_LIST()
+	},
+};
+
+static Property vhost_user_rdma_properties[] = {
+	DEFINE_PROP_CHR("chardev", VHostUserRdma, chardev),
+	DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vhost_user_rdma_class_init(ObjectClass *klass, void *data)
+{
+	DeviceClass *dc = DEVICE_CLASS(klass);
+	VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
+
+	device_class_set_props(dc, vhost_user_rdma_properties);
+	dc->vmsd = &vmstate_vhost_user_rdma;
+	set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
+
+	vdc->realize = vhost_user_rdma_device_realize;
+	vdc->unrealize = vhost_user_rdma_device_unrealize;
+	vdc->get_config = vhost_user_rdma_update_config;
+	vdc->set_config = vhost_user_rdma_set_config;
+	vdc->get_features = vhost_user_rdma_get_features;
+	vdc->set_status = vhost_user_rdma_set_status;
+}
+
+static const TypeInfo vhost_user_rdma_info = {
+	.name = TYPE_VHOST_USER_RDMA,
+	.parent = TYPE_VIRTIO_DEVICE,
+	.instance_size = sizeof(VHostUserRdma),
+	.instance_init = vhost_user_rdma_instance_init,
+	.class_init = vhost_user_rdma_class_init,
+};
+
+static void virtio_register_types(void)
+{
+	type_register_static(&vhost_user_rdma_info);
+}
+
+type_init(virtio_register_types)
diff --git a/hw/virtio/meson.build b/hw/virtio/meson.build
index d7f18c96e6..3f0a7da910 100644
--- a/hw/virtio/meson.build
+++ b/hw/virtio/meson.build
@@ -63,6 +63,7 @@ virtio_pci_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock-pci.c'
 virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_VSOCK', if_true: files('vhost-user-vsock-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_BLK', if_true: files('vhost-user-blk-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_SCSI', if_true: files('vhost-user-scsi-pci.c'))
+virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_RDMA', if_true: files('vhost-user-rdma-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_SCSI', if_true: files('vhost-scsi-pci.c'))
 virtio_pci_ss.add(when: 'CONFIG_VHOST_USER_FS', if_true: files('vhost-user-fs-pci.c'))
 
diff --git a/hw/virtio/vhost-user-rdma-pci.c b/hw/virtio/vhost-user-rdma-pci.c
new file mode 100644
index 0000000000..6b95949c07
--- /dev/null
+++ b/hw/virtio/vhost-user-rdma-pci.c
@@ -0,0 +1,93 @@
+/*
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.  See the COPYING file in the
+ * top-level directory.
+ */
+
+#include "qemu/osdep.h"
+
+#include "standard-headers/rdma/virtio_rdma.h"
+#include "hw/virtio/virtio.h"
+#include "hw/virtio/vhost-user-rdma.h"
+#include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "qemu/module.h"
+#include "hw/virtio/virtio-pci.h"
+#include "qom/object.h"
+
+typedef struct VHostUserRdmaPCI VHostUserRdmaPCI;
+
+#define TYPE_VHOST_USER_RDMA_PCI "vhost-user-rdma-pci-base"
+DECLARE_INSTANCE_CHECKER(VHostUserRdmaPCI, VHOST_USER_RDMA_PCI,
+						TYPE_VHOST_USER_RDMA_PCI)
+
+struct VHostUserRdmaPCI {
+	VirtIOPCIProxy parent_obj;
+	VHostUserRdma vdev;
+};
+
+static Property vhost_user_rdma_pci_properties[] = {
+	DEFINE_PROP_UINT32("class", VirtIOPCIProxy, class_code, 0),
+	DEFINE_PROP_UINT32("vectors", VirtIOPCIProxy, nvectors,
+						DEV_NVECTORS_UNSPECIFIED),
+	DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vhost_user_rdma_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
+{
+	VHostUserRdmaPCI *dev = VHOST_USER_RDMA_PCI(vpci_dev);
+	DeviceState *vdev = DEVICE(&dev->vdev);
+
+	if (vpci_dev->nvectors == DEV_NVECTORS_UNSPECIFIED) {
+		vpci_dev->nvectors = dev->vdev.num_queues + 1;
+	}
+
+	virtio_pci_force_virtio_1(vpci_dev);
+
+	qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
+}
+
+static void vhost_user_rdma_pci_class_init(ObjectClass *klass, void *data)
+{
+	DeviceClass *dc = DEVICE_CLASS(klass);
+	VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
+	PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
+
+	set_bit(DEVICE_CATEGORY_NETWORK, dc->categories);
+	device_class_set_props(dc, vhost_user_rdma_pci_properties);
+	k->realize = vhost_user_rdma_pci_realize;
+	pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
+	pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_RDMA;
+	pcidev_k->revision = VIRTIO_PCI_ABI_VERSION;
+	pcidev_k->class_id = PCI_CLASS_NETWORK_OTHER;
+}
+
+static void vhost_user_rdma_pci_instance_init(Object *obj)
+{
+	VHostUserRdmaPCI *dev = VHOST_USER_RDMA_PCI(obj);
+
+	virtio_instance_init_common(obj, &dev->vdev, sizeof(dev->vdev),
+							TYPE_VHOST_USER_RDMA);
+
+	object_property_add_alias(obj, "bootindex", OBJECT(&dev->vdev),
+							"bootindex");
+}
+
+static const VirtioPCIDeviceTypeInfo vhost_user_rdma_pci_info = {
+	.base_name				= TYPE_VHOST_USER_RDMA_PCI,
+	.generic_name			= "vhost-user-rdma-pci",
+	.transitional_name		= "vhost-user-rdma-pci-transitional",
+	.non_transitional_name	= "vhost-user-rdma-pci-non-transitional",
+	.instance_size			= sizeof(VHostUserRdmaPCI),
+	.instance_init			= vhost_user_rdma_pci_instance_init,
+	.class_init				= vhost_user_rdma_pci_class_init,
+};
+
+static void vhost_user_rdma_pci_register(void)
+{
+	virtio_pci_types_register(&vhost_user_rdma_pci_info);
+}
+
+type_init(vhost_user_rdma_pci_register)
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index cdf9af4a4b..eb0813bddd 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -460,6 +460,7 @@ static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
     }
 
     if (shmfd) {
+        error_report("vhost_user_read: vhost_user_set_log_base");
         msg.hdr.size = 0;
         ret = vhost_user_read(dev, &msg);
         if (ret < 0) {
@@ -753,6 +754,7 @@ static int send_add_regions(struct vhost_dev *dev,
             if (track_ramblocks) {
                 uint64_t reply_gpa;
 
+                error_report("vhost_user_read: send_add_regions");
                 ret = vhost_user_read(dev, &msg_reply);
                 if (ret < 0) {
                     return ret;
@@ -930,6 +932,7 @@ static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
             return ret;
         }
 
+        error_report("vhost_user_read: vhost_user_set_mem_table_postcopy");
         ret = vhost_user_read(dev, &msg_reply);
         if (ret < 0) {
             return ret;
@@ -1287,6 +1290,7 @@ static int vhost_user_get_vring_base(struct vhost_dev *dev,
         return ret;
     }
 
+    error_report("vhost_user_read: vhost_user_get_vring_base");
     ret = vhost_user_read(dev, &msg);
     if (ret < 0) {
         return ret;
@@ -1433,6 +1437,7 @@ static int vhost_user_set_features(struct vhost_dev *dev,
      * VHOST_USER_F_PROTOCOL_FEATURES bit for enabling protocol
      * features.
      */
+
     ret = vhost_user_set_u64(dev, VHOST_USER_SET_FEATURES,
                               features | dev->backend_features,
                               log_enabled);
@@ -1673,6 +1678,7 @@ int vhost_user_get_shared_object(struct vhost_dev *dev, unsigned char *uuid,
         return ret;
     }
 
+    error_report("vhost_user_read: vhost_user_get_shared_object");
     ret = vhost_user_read(dev, &msg);
     if (ret < 0) {
         return ret;
@@ -1998,6 +2004,7 @@ static int vhost_user_postcopy_advise(struct vhost_dev *dev, Error **errp)
         return ret;
     }
 
+    error_report("vhost_user_read: vhost_user_postcopy_advise");
     ret = vhost_user_read(dev, &msg);
     if (ret < 0) {
         error_setg(errp, "Failed to get postcopy_advise reply from vhost");
@@ -2435,6 +2442,7 @@ static int vhost_user_get_config(struct vhost_dev *dev, uint8_t *config,
         return ret;
     }
 
+    error_report("vhost_user_read: vhost_user_get_config");
     ret = vhost_user_read(dev, &msg);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "vhost_get_config failed");
@@ -2578,6 +2586,7 @@ static int vhost_user_crypto_create_session(struct vhost_dev *dev,
         return ret;
     }
 
+    error_report("vhost_user_read: vhost_user_crypto_create_session");
     ret = vhost_user_read(dev, &msg);
     if (ret < 0) {
         error_report("vhost_user_read() return %d, create session failed",
@@ -2923,6 +2932,7 @@ static int vhost_user_set_device_state_fd(struct vhost_dev *dev,
         return ret;
     }
 
+    error_report("vhost_user_read: vhost_user_set_device_state_fd");
     ret = vhost_user_read(dev, &msg);
     if (ret < 0) {
         error_setg_errno(errp, -ret,
@@ -2985,6 +2995,7 @@ static int vhost_user_check_device_state(struct vhost_dev *dev, Error **errp)
         return ret;
     }
 
+    error_report("vhost_user_read: vhost_user_check_device_state");
     ret = vhost_user_read(dev, &msg);
     if (ret < 0) {
         error_setg_errno(errp, -ret,
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index f50180e60e..87cec36828 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -934,6 +934,7 @@ static int vhost_dev_set_features(struct vhost_dev *dev,
             features |= 0x1ULL << VIRTIO_F_IOMMU_PLATFORM;
        }
     }
+
     r = dev->vhost_ops->vhost_set_features(dev, features);
     if (r < 0) {
         VHOST_OPS_DEBUG(r, "vhost_set_features failed");
@@ -1804,6 +1805,7 @@ void vhost_ack_features(struct vhost_dev *hdev, const int *feature_bits,
                         uint64_t features)
 {
     const int *bit = feature_bits;
+    info_report("vhost_ack_features");
     while (*bit != VHOST_INVALID_FEATURE_BIT) {
         uint64_t bit_mask = (1ULL << *bit);
         if (features & bit_mask) {
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index fd2dfe3a6b..bee7156e6d 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -181,6 +181,7 @@ const char *virtio_device_names[] = {
     [VIRTIO_ID_FS] = "virtio-user-fs",
     [VIRTIO_ID_PMEM] = "virtio-pmem",
     [VIRTIO_ID_RPMB] = "virtio-rpmb",
+    [VIRTIO_ID_RDMA] = "virtio-rdma",
     [VIRTIO_ID_MAC80211_HWSIM] = "virtio-mac-hwsim",
     [VIRTIO_ID_VIDEO_ENCODER] = "virtio-vid-encoder",
     [VIRTIO_ID_VIDEO_DECODER] = "virtio-vid-decoder",
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index eaa3fc99d8..a1eccfb78b 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -85,6 +85,7 @@ extern bool pci_available;
 #define PCI_DEVICE_ID_VIRTIO_RNG         0x1005
 #define PCI_DEVICE_ID_VIRTIO_9P          0x1009
 #define PCI_DEVICE_ID_VIRTIO_VSOCK       0x1012
+#define PCI_DEVICE_ID_VIRTIO_RDMA        0x1016
 
 /*
  * modern virtio-pci devices get their id assigned automatically,
diff --git a/include/hw/virtio/vhost-user-rdma.h b/include/hw/virtio/vhost-user-rdma.h
new file mode 100644
index 0000000000..2d522cd676
--- /dev/null
+++ b/include/hw/virtio/vhost-user-rdma.h
@@ -0,0 +1,43 @@
+/*
+ * vhost-user-rdma host device
+ * Copyright(C) 2021 Bytedance Inc. All rights reserved.
+ *
+ * Authors:
+ *  Junji Wei <weijunji@bytedance.com>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2 or later.
+ * See the COPYING.LIB file in the top-level directory.
+ *
+ */
+
+#ifndef VHOST_USER_RDMA_H
+#define VHOST_USER_RDMA_H
+
+#include "standard-headers/rdma/virtio_rdma.h"
+#include "chardev/char-fe.h"
+#include "hw/virtio/vhost.h"
+#include "hw/virtio/vhost-user.h"
+#include "qom/object.h"
+
+#define TYPE_VHOST_USER_RDMA "vhost-user-rdma"
+OBJECT_DECLARE_SIMPLE_TYPE(VHostUserRdma, VHOST_USER_RDMA)
+
+struct VHostUserRdma {
+    VirtIODevice parent_obj;
+    CharBackend chardev;
+    int32_t bootindex;
+    struct virtio_rdma_config rdmacfg;
+    struct vhost_dev dev;
+    VhostUserState vhost_user;
+    struct vhost_virtqueue *vhost_vqs;
+    VirtQueue **virtqs;
+
+    int num_queues;
+
+    /* vhost_user_rdma_connect/vhost_user_rdma_disconnect */
+    bool connected;
+    /* vhost_user_rdma_start/vhost_user_rdma_stop */
+    bool started_vu;
+};
+
+#endif
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 7d5ffdc145..f74da61477 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -369,7 +369,7 @@ typedef struct VirtIORNGConf VirtIORNGConf;
     DEFINE_PROP_BIT64("packed", _state, _field, \
                       VIRTIO_F_RING_PACKED, false), \
     DEFINE_PROP_BIT64("queue_reset", _state, _field, \
-                      VIRTIO_F_RING_RESET, true)
+                      VIRTIO_F_RING_RESET, false)
 
 hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
 bool virtio_queue_enabled_legacy(VirtIODevice *vdev, int n);
diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
index 7aa2eb7662..ff2d0b01b4 100644
--- a/include/standard-headers/linux/virtio_ids.h
+++ b/include/standard-headers/linux/virtio_ids.h
@@ -68,6 +68,7 @@
 #define VIRTIO_ID_AUDIO_POLICY		39 /* virtio audio policy */
 #define VIRTIO_ID_BT			40 /* virtio bluetooth */
 #define VIRTIO_ID_GPIO			41 /* virtio gpio */
+#define VIRTIO_ID_RDMA          42 /* virtio rdma */
 
 /*
  * Virtio Transitional IDs
diff --git a/include/standard-headers/rdma/virtio_rdma.h b/include/standard-headers/rdma/virtio_rdma.h
new file mode 100644
index 0000000000..b493f973d8
--- /dev/null
+++ b/include/standard-headers/rdma/virtio_rdma.h
@@ -0,0 +1,60 @@
+/*
+ * Virtio RDMA Device
+ *
+ * Copyright (C) 2021 Bytedance Inc.
+ *
+ * Authors:
+ *  Junji Wei <weijunji@bytedance.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef _LINUX_VIRTIO_RDMA_H
+#define _LINUX_VIRTIO_RDMA_H
+
+#include <linux/types.h>
+#include <infiniband/verbs.h>
+
+#include "standard-headers/linux/virtio_ids.h"
+#include "standard-headers/linux/virtio_config.h"
+#include "standard-headers/linux/virtio_types.h"
+
+struct virtio_rdma_config {
+    __le32         phys_port_cnt;
+
+    __le64         sys_image_guid;
+    __le32         vendor_id;
+    __le32         vendor_part_id;
+    __le32         hw_ver;
+    __le64         max_mr_size;
+    __le64         page_size_cap;
+    __le32         max_qp;
+    __le32         max_qp_wr;
+    __le64         device_cap_flags;
+    __le32         max_send_sge;
+    __le32         max_recv_sge;
+    __le32         max_sge_rd;
+    __le32         max_cq;
+    __le32         max_cqe;
+    __le32         max_mr;
+    __le32         max_pd;
+    __le32         max_qp_rd_atom;
+    __le32         max_res_rd_atom;
+    __le32         max_qp_init_rd_atom;
+    __le32         atomic_cap;
+    __le32         max_mw;
+    __le32         max_mcast_grp;
+    __le32         max_mcast_qp_attach;
+    __le32         max_total_mcast_qp_attach;
+    __le32         max_ah;
+    __le32         max_fast_reg_page_list_len;
+    __le32         max_pi_fast_reg_page_list_len;
+    __le16         max_pkeys;
+    uint8_t        local_ca_ack_delay;
+
+    uint8_t           reserved[64];
+} QEMU_PACKED;
+
+#endif
-- 
2.43.0


