Return-Path: <netdev+bounces-245796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D50CD8016
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 04:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76CA0306C4AE
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 03:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B7A2DE70B;
	Tue, 23 Dec 2025 03:52:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-93.mail.aliyun.com (out28-93.mail.aliyun.com [115.124.28.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DE22D5C68;
	Tue, 23 Dec 2025 03:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766461934; cv=none; b=Hz2wzFA8XZ6UR2VmGCMZGyBycWeccDl057XOqZbSR+MkklwMzSO+D6RwOdE9OXNFTKd79GRxfk/pb3ziSKkmWbKqLhrqB7isIcRqObTZD7gokTSfmNRP09EJrNo9/Q7mHDSvJlHHhP4RWgiE4un3A5/9meoWjtpWBWJKczapZlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766461934; c=relaxed/simple;
	bh=ISJKMu9P61m8pMsu3KpvPyUkIRw550a2Q7pVoeJ/Nks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fUn6pnjbi3vgoigBJofUsf5WxwGPESnV8eiiy+AnLQpPEpt4b8BYvjdT6tj1VSGHEyltLiXLIwKRz9/kWkoS6gwuV4hYBL1hDVVPIWj6AdpYf+H83ciL5B0sH3WyDI9O/RK7lFeJ+ox+Ju4yTmmMvJkZKwF0P46AntGUatRn+74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.fqrxXA._1766461919 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 23 Dec 2025 11:52:01 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1 net-next 15/15] net/nebula-matrix: add kernel/user coexist mode support
Date: Tue, 23 Dec 2025 11:50:38 +0800
Message-ID: <20251223035113.31122-16-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223035113.31122-1-illusion.wang@nebula-matrix.com>
References: <20251223035113.31122-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

1. Coexistence Function Implementation
Create a virtual dev and wrap it with a VFIO group and VFIO mediated device (mdev) framework,
or use the traditional cdev approach.
2. Mode Switching During DPDK Startup/Shutdown in Coexistence Scenarios
The function nbl_userdev_switch_network handles mode transitions when starting/stopping DPDK
in coexistence environments.
3. User-Space Driver Scenarios: Coexistence vs. Non-Coexistence (UIO/VFIO)
Leonis PF0 is designated as the management Physical Function (PF).
If PF1 operates in kernel mode and DPDK is launched:
Coexistence mode:
Commands are issued via ioctl to the PF1 driver's kernel layer (nbl_userdev_channel_ioctl).
DPDK blocks on the ioctl call in kernel space.
PF1 intercepts and modifies the request, then forwards it via mailbox to PF0 for processing.
DPDK remains blocked, waiting for an ACK response from the mailbox.
Non-Coexistence mode:
Direct mailbox communication is used between PF1 and PF0 without kernel intervention.
4. Event Notification Mechanism
For PF0 to proactively send mailbox messages (e.g., link status updates) to other VFs/PFs:
A software ring buffer and eventfd are implemented for shared memory between kernel and user space.
The kernel copies subscribed messages into the ring buffer and triggers an eventfd wake-up to notify 
DPDK's interrupt thread.

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
Change-Id: Ic8253176aec7203388addfd871bc94c21c13261b
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |    1 +
 .../nbl/nbl_channel/nbl_channel.c             |  131 ++
 .../nbl/nbl_channel/nbl_channel.h             |    8 +
 .../nebula-matrix/nbl/nbl_core/nbl_dev.c      |    4 +
 .../nebula-matrix/nbl/nbl_core/nbl_dev.h      |   40 +
 .../nebula-matrix/nbl/nbl_core/nbl_dev_user.c | 1607 +++++++++++++++++
 .../nebula-matrix/nbl/nbl_core/nbl_dev_user.h |   76 +
 .../nebula-matrix/nbl/nbl_core/nbl_service.c  |   61 +
 .../nbl/nbl_include/nbl_def_channel.h         |    3 +
 .../nbl/nbl_include/nbl_def_common.h          |    8 +
 .../nbl/nbl_include/nbl_def_dev.h             |    3 +
 .../nbl/nbl_include/nbl_def_service.h         |    1 +
 .../nbl/nbl_include/nbl_include.h             |    9 +
 .../net/ethernet/nebula-matrix/nbl/nbl_main.c |    3 +
 14 files changed, 1955 insertions(+)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev_user.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev_user.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index ef4e5d4da034..d4777ea7afeb 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -21,6 +21,7 @@ nbl_core-objs +=       nbl_common/nbl_common.o \
 				nbl_core/nbl_service.o \
 				nbl_core/nbl_sysfs.o \
 				nbl_core/nbl_dev.o \
+				nbl_core/nbl_dev_user.o \
 				nbl_main.o
 
 # Do not modify include path, unless you are adding a new file which needs some headers in its
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
index f5465a890223..c38567064d0d 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.c
@@ -45,6 +45,18 @@ static int nbl_chan_init_msg_handler(struct nbl_channel_mgt *chan_mgt, u8 user_n
 	struct nbl_common_info *common = NBL_CHAN_MGT_TO_COMMON(chan_mgt);
 	int ret = 0;
 
+	struct device *dev = NBL_COMMON_TO_DEV(common);
+	struct nbl_chan_notify_userdev *notify;
+
+	if (user_notify) {
+		notify = devm_kzalloc(dev, sizeof(struct nbl_chan_notify_userdev), GFP_KERNEL);
+		if (!notify)
+			return -ENOMEM;
+
+		mutex_init(&notify->lock);
+		chan_mgt->notify = notify;
+	}
+
 	NBL_HASH_TBL_KEY_INIT(&tbl_key, NBL_COMMON_TO_DEV(common), sizeof(u16),
 			      sizeof(struct nbl_chan_msg_node_data),
 			      NBL_CHAN_HANDLER_TBL_BUCKET_SIZE, false);
@@ -58,6 +70,11 @@ static int nbl_chan_init_msg_handler(struct nbl_channel_mgt *chan_mgt, u8 user_n
 	return 0;
 
 alloc_hashtbl_failed:
+	if (user_notify) {
+		chan_mgt->notify = NULL;
+		devm_kfree(dev, notify);
+	}
+
 	return ret;
 }
 
@@ -66,6 +83,11 @@ static void nbl_chan_remove_msg_handler(struct nbl_channel_mgt *chan_mgt)
 	nbl_common_remove_hash_table(chan_mgt->handle_hash_tbl, NULL);
 
 	chan_mgt->handle_hash_tbl = NULL;
+
+	if (chan_mgt->notify) {
+		devm_kfree(NBL_COMMON_TO_DEV(chan_mgt->common), chan_mgt->notify);
+		chan_mgt->notify = NULL;
+	}
 }
 
 static bool nbl_chan_is_admiq(struct nbl_chan_info *chan_info)
@@ -782,6 +804,55 @@ static void nbl_chan_recv_ack_msg(void *priv, u16 srcid, u16 msgid,
 		wake_up(&wait_head->wait_queue);
 }
 
+static inline u16 nbl_unused_msg_ring_count(u32 head, u32 tail)
+{
+	return ((tail > head) ? 0 : NBL_USER_DEV_SHMMSGBUF_SIZE) + tail - head - 1;
+}
+
+static int nbl_chan_msg_forward_userdev(struct nbl_channel_mgt *chan_mgt,
+					struct nbl_chan_tx_desc *tx_desc)
+{
+	struct device *dev = NBL_COMMON_TO_DEV(chan_mgt->common);
+	void *shm_msg_ring = chan_mgt->notify->shm_msg_ring;
+	char *data = (char *)shm_msg_ring + 8;
+	u32 *head = (u32 *)shm_msg_ring, tmp;
+	u32 tail = *(head + 1);
+	u32 total_len = sizeof(struct nbl_chan_tx_desc) + sizeof(u32), copy_len;
+
+	if (!tx_desc->data_len)
+		total_len += ALIGN(tx_desc->buf_len, 4);
+
+	tmp = *head;
+	if (total_len > nbl_unused_msg_ring_count(tmp, tail)) {
+		dev_err(dev, "user msg ring not enough for msg\n");
+		return -E2BIG;
+	}
+
+	/* save total_len */
+	*(u32 *)(data + tmp) = total_len;
+	tmp += sizeof(u32);
+	total_len -= sizeof(u32);
+	if (tmp >= NBL_USER_DEV_SHMMSGBUF_SIZE)
+		tmp -= NBL_USER_DEV_SHMMSGBUF_SIZE;
+
+	copy_len = NBL_USER_DEV_SHMMSGBUF_SIZE - tmp;
+	copy_len = min(copy_len, total_len);
+	memcpy(data + tmp, tx_desc, copy_len);
+	if (total_len > copy_len)
+		memcpy(data, (char *)tx_desc + copy_len, total_len - copy_len);
+
+	tmp += total_len;
+	if (tmp >= NBL_USER_DEV_SHMMSGBUF_SIZE)
+		tmp -= NBL_USER_DEV_SHMMSGBUF_SIZE;
+
+	/* make sure to update head after content */
+	smp_wmb();
+	*head = tmp;
+	eventfd_signal(chan_mgt->notify->eventfd);
+
+	return 0;
+}
+
 static void nbl_chan_recv_msg(struct nbl_channel_mgt *chan_mgt, void *data, u32 data_len)
 {
 	struct nbl_chan_ack_info chan_ack;
@@ -814,6 +885,16 @@ static void nbl_chan_recv_msg(struct nbl_channel_mgt *chan_mgt, void *data, u32
 		msg_handler->func(msg_handler->priv, srcid, msgid, payload, payload_len);
 	}
 
+	if (chan_mgt->notify && msg_type < NBL_CHAN_MSG_MAILBOX_MAX) {
+		mutex_lock(&chan_mgt->notify->lock);
+		if (chan_mgt->notify->eventfd && test_bit(msg_type, chan_mgt->notify->msgtype) &&
+		    chan_mgt->notify->shm_msg_ring) {
+			warn = 0;
+			nbl_chan_msg_forward_userdev(chan_mgt, tx_desc);
+		}
+		mutex_unlock(&chan_mgt->notify->lock);
+	}
+
 send_warning:
 	if (warn) {
 		NBL_CHAN_ACK(chan_ack, srcid, msg_type, msgid, -EPERM, NULL, 0);
@@ -1108,6 +1189,51 @@ static bool nbl_chan_check_queue_exist(void *priv, u8 chan_type)
 	return chan_info ? true : false;
 }
 
+static int nbl_chan_set_listener_info(void *priv, void *shm_ring, struct eventfd_ctx *eventfd)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
+
+	mutex_lock(&chan_mgt->notify->lock);
+
+	chan_mgt->notify->shm_msg_ring = shm_ring;
+	if (chan_mgt->notify->eventfd)
+		eventfd_ctx_put(chan_mgt->notify->eventfd);
+	chan_mgt->notify->eventfd = eventfd;
+
+	mutex_unlock(&chan_mgt->notify->lock);
+
+	return 0;
+}
+
+static int nbl_chan_set_listener_msgtype(void *priv, int msgtype)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
+
+	if (msgtype >= NBL_CHAN_MSG_MAILBOX_MAX)
+		return -EINVAL;
+
+	mutex_lock(&chan_mgt->notify->lock);
+	set_bit(msgtype, chan_mgt->notify->msgtype);
+	mutex_unlock(&chan_mgt->notify->lock);
+
+	return 0;
+}
+
+static void nbl_chan_clear_listener_info(void *priv)
+{
+	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
+
+	mutex_lock(&chan_mgt->notify->lock);
+	if (chan_mgt->notify->eventfd)
+		eventfd_ctx_put(chan_mgt->notify->eventfd);
+	chan_mgt->notify->eventfd = NULL;
+
+	bitmap_zero(chan_mgt->notify->msgtype, NBL_CHAN_MSG_MAILBOX_MAX);
+	if (chan_mgt->notify->shm_msg_ring)
+		memset(chan_mgt->notify->shm_msg_ring, 0, NBL_USER_DEV_SHMMSGRING_SIZE);
+	mutex_unlock(&chan_mgt->notify->lock);
+}
+
 static void nbl_chan_keepalive_resp(void *priv, u16 srcid, u16 msgid, void *data, u32 data_len)
 {
 	struct nbl_channel_mgt *chan_mgt = (struct nbl_channel_mgt *)priv;
@@ -1226,6 +1352,11 @@ static struct nbl_channel_ops chan_ops = {
 	.teardown_queue			= nbl_chan_teardown_queue,
 	.clean_queue_subtask		= nbl_chan_clean_queue_subtask,
 
+	/* for mailbox register msg for userdev */
+	.set_listener_info		= nbl_chan_set_listener_info,
+	.set_listener_msgtype		= nbl_chan_set_listener_msgtype,
+	.clear_listener_info		= nbl_chan_clear_listener_info,
+
 	.setup_keepalive		= nbl_chan_setup_keepalive,
 	.remove_keepalive		= nbl_chan_remove_keepalive,
 	.register_chan_task		= nbl_chan_register_chan_task,
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
index 7f49c79b97bc..261a8d3b518a 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_channel/nbl_channel.h
@@ -139,6 +139,13 @@ struct nbl_chan_waitqueue_head {
 	u8 msg_index;
 };
 
+struct nbl_chan_notify_userdev {
+	DECLARE_BITMAP(msgtype, NBL_CHAN_MSG_MAILBOX_MAX);
+	struct mutex lock; /* used to protect eventfd and shm_msg_ring */
+	struct eventfd_ctx *eventfd;
+	void *shm_msg_ring;
+};
+
 #define NBL_CHAN_KEEPALIVE_DEFAULT_TIMEOUT			(10 * HZ)
 #define NBL_CHAN_KEEPALIVE_MAX_TIMEOUT				(1024 * HZ)
 #define NBL_CHAN_KEEPALIVE_TIMEOUT_UPDATE_GAP			(10 * HZ)
@@ -192,6 +199,7 @@ struct nbl_channel_mgt {
 	struct nbl_hw_ops_tbl *hw_ops_tbl;
 	struct nbl_chan_info *chan_info[NBL_CHAN_TYPE_MAX];
 	struct nbl_cmdq_mgt *cmdq_mgt;
+	struct nbl_chan_notify_userdev *notify;
 	void *handle_hash_tbl;
 };
 
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
index 45b75e1c4f53..c0e1048ed617 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.c
@@ -3207,6 +3207,9 @@ int nbl_dev_start(void *p, struct nbl_init_param *param)
 	if (ret)
 		goto start_net_dev_fail;
 
+	if (param->caps.has_user)
+		nbl_dev_start_user_dev(adapter);
+
 	return 0;
 
 start_net_dev_fail:
@@ -3221,6 +3224,7 @@ void nbl_dev_stop(void *p)
 {
 	struct nbl_adapter *adapter = (struct nbl_adapter *)p;
 
+	nbl_dev_stop_user_dev(adapter);
 	nbl_dev_stop_ctrl_dev(adapter);
 	nbl_dev_stop_net_dev(adapter);
 	nbl_dev_stop_common_dev(adapter);
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
index 41b1955f6bae..2836af71bfc8 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev.h
@@ -8,6 +8,7 @@
 #define _NBL_DEV_H_
 
 #include "nbl_core.h"
+#include "nbl_dev_user.h"
 #include "nbl_sysfs.h"
 
 #define NBL_DEV_MGT_TO_COMMON(dev_mgt)		((dev_mgt)->common)
@@ -228,6 +229,44 @@ struct nbl_dev_st_dev {
 	char real_st_name[NBL_RESTOOL_NAME_LEN];
 };
 
+struct nbl_dev_user_iommu_group {
+	struct mutex dma_tree_lock; /* lock dma tree */
+	struct list_head group_next;
+	struct kref     kref;
+	struct rb_root dma_tree;
+	struct iommu_group *iommu_group;
+	struct device *dev;
+	struct device *mdev;
+	struct vfio_device *vdev;
+};
+
+struct nbl_dev_user {
+	struct vfio_device *vdev;
+	struct device mdev;
+	struct notifier_block iommu_notifier;
+	struct device *dev;
+	struct nbl_adapter *adapter;
+	struct nbl_dev_user_iommu_group *group;
+	void *shm_msg_ring;
+	u64 dma_limit;
+	atomic_t open_cnt;
+	int minor;
+	int network_type;
+	bool iommu_status;
+	bool remap_status;
+	bool user_promisc_mode;
+	bool user_mcast_mode;
+	u16 user_vsi;
+};
+
+struct nbl_vfio_device {
+	struct vfio_device vdev;
+	struct nbl_dev_user *user;
+};
+
+#define NBL_USERDEV_TO_VFIO_DEV(user)	((user)->vdev)
+#define NBL_VFIO_DEV_TO_USERDEV(vdev)	(*(struct nbl_dev_user **)((vdev) + 1))
+
 struct nbl_dev_mgt {
 	struct nbl_common_info *common;
 	struct nbl_service_ops_tbl *serv_ops_tbl;
@@ -236,6 +275,7 @@ struct nbl_dev_mgt {
 	struct nbl_dev_ctrl *ctrl_dev;
 	struct nbl_dev_net *net_dev;
 	struct nbl_dev_st_dev *st_dev;
+	struct nbl_dev_user *user_dev;
 };
 
 struct nbl_dev_vsi_feature {
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev_user.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev_user.c
new file mode 100644
index 000000000000..5eccafa31436
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev_user.c
@@ -0,0 +1,1607 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+#include "nbl_dev.h"
+#include "nbl_service.h"
+#include <linux/vmalloc.h>
+
+#define VENDOR_PHYTIUM	0x70
+#define VENDOR_MASK	0xFF
+#define VENDOR_OFFSET	24
+
+static struct nbl_userdev {
+	struct cdev cdev;
+	struct class *cls;
+	struct xarray xa;
+	dev_t cdevt;
+	struct mutex clock; /* lock character device */
+	struct list_head glist;
+	struct mutex glock; /* lock iommu group list */
+	bool success;
+} nbl_userdev;
+
+struct nbl_vfio_batch {
+	unsigned long *pages_out;
+	unsigned long *pages_in;
+	int size;
+	int offset;
+	struct page **h_page;
+};
+
+struct nbl_userdev_dma {
+	struct rb_node node;
+	dma_addr_t iova;
+	unsigned long vaddr;
+	size_t size;
+	unsigned long pfn;
+};
+
+bool nbl_dma_iommu_status(struct pci_dev *pdev)
+{
+	struct device *dev = &pdev->dev;
+
+	if (dev->iommu_group && iommu_get_domain_for_dev(dev))
+		return 1;
+
+	return 0;
+}
+
+bool nbl_dma_remap_status(struct pci_dev *pdev, u64 *dma_limit)
+{
+	struct device *dev = &pdev->dev;
+	struct iommu_domain *domain;
+	dma_addr_t dma_mask = dma_get_mask(dev);
+
+	*dma_limit = min_not_zero(dma_mask, dev->bus_dma_limit);
+	domain = iommu_get_domain_for_dev(dev);
+	if (!domain)
+		return 0;
+
+	if (domain->geometry.force_aperture)
+		*dma_limit = min_t(u64, *dma_limit, domain->geometry.aperture_end);
+
+	if (domain->type & IOMMU_DOMAIN_IDENTITY)
+		return 0;
+
+	return 1;
+}
+
+static char *user_cdevnode(const struct device *dev, umode_t *mode)
+{
+	return kasprintf(GFP_KERNEL, "nbl_userdev/%s", dev_name(dev));
+}
+
+static void nbl_user_change_kernel_network(struct nbl_dev_user *user)
+{
+	struct nbl_adapter *adapter = user->adapter;
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct net_device *netdev = net_dev->netdev;
+	int ret;
+
+	if (user->network_type == NBL_KERNEL_NETWORK)
+		return;
+
+	ret = serv_ops->switch_traffic_default_dest(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+						    NBL_DEV_USER_TO_KERNEL);
+	if (ret) {
+		netdev_err(netdev, "network changes to kernel space failed %d\n", ret);
+		return;
+	}
+
+	user->network_type = NBL_KERNEL_NETWORK;
+	netdev_info(netdev, "network changes to kernel space\n");
+}
+
+static int nbl_user_change_user_network(struct nbl_dev_user *user)
+{
+	struct nbl_adapter *adapter = user->adapter;
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct net_device *netdev = net_dev->netdev;
+	int ret = 0;
+
+	if (user->network_type == NBL_USER_NETWORK)
+		return 0;
+
+	ret = serv_ops->switch_traffic_default_dest(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+						    NBL_DEV_KERNEL_TO_USER);
+
+	if (ret) {
+		netdev_err(netdev, "network changes to user space failed %u\n", ret);
+		return ret;
+	}
+
+	user->network_type = NBL_USER_NETWORK;
+	netdev_info(netdev, "network changes to user\n");
+
+	return ret;
+}
+
+static int nbl_cdev_open(struct inode *inode, struct file *filep)
+{
+	struct nbl_adapter *p;
+	struct nbl_dev_mgt *dev_mgt;
+	struct nbl_dev_user *user;
+	int opened;
+
+	mutex_lock(&nbl_userdev.clock);
+	p = xa_load(&nbl_userdev.xa, iminor(inode));
+	mutex_unlock(&nbl_userdev.clock);
+
+	if (!p)
+		return -ENODEV;
+
+	if (test_bit(NBL_FATAL_ERR, p->state))
+		return -EIO;
+
+	dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(p);
+	user = NBL_DEV_MGT_TO_USER_DEV(dev_mgt);
+	opened = atomic_cmpxchg(&user->open_cnt, 0, 1);
+	if (opened)
+		return -EBUSY;
+
+	rtnl_lock();
+	set_bit(NBL_USER, p->state);
+	rtnl_unlock();
+
+	filep->private_data = p;
+
+	return 0;
+}
+
+static int nbl_cdev_release(struct inode *inode, struct file *filp)
+{
+	struct nbl_adapter *adapter = filp->private_data;
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_dev_user *user = NBL_DEV_MGT_TO_USER_DEV(dev_mgt);
+
+	chan_ops->clear_listener_info(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt));
+	nbl_user_change_kernel_network(user);
+	serv_ops->clear_flow(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), user->user_vsi);
+	atomic_set(&user->open_cnt, 0);
+	user->user_promisc_mode = 0;
+	clear_bit(NBL_USER, adapter->state);
+
+	return 0;
+}
+
+static int nbl_userdev_common_mmap(struct nbl_adapter *adapter, struct vm_area_struct *vma)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dev_user *user = NBL_DEV_MGT_TO_USER_DEV(dev_mgt);
+	struct pci_dev *pdev = adapter->pdev;
+	unsigned int index;
+	u64 phys_len, req_len, req_start, pgoff;
+	int ret;
+
+	index = vma->vm_pgoff >> (NBL_DEV_USER_PCI_OFFSET_SHIFT - PAGE_SHIFT);
+	pgoff = vma->vm_pgoff & ((1U << (NBL_DEV_USER_PCI_OFFSET_SHIFT - PAGE_SHIFT)) - 1);
+
+	req_len = vma->vm_end - vma->vm_start;
+	req_start = pgoff << PAGE_SHIFT;
+
+	if (index == NBL_DEV_SHM_MSG_RING_INDEX)
+		phys_len = NBL_USER_DEV_SHMMSGRING_SIZE;
+	else
+		phys_len = PAGE_ALIGN(pci_resource_len(pdev, 0));
+
+	if (req_start + req_len > phys_len)
+		return -EINVAL;
+
+	if (index == NBL_DEV_SHM_MSG_RING_INDEX) {
+		struct page *page = virt_to_page((void *)((unsigned long)user->shm_msg_ring +
+				(pgoff << PAGE_SHIFT)));
+		vma->vm_pgoff = pgoff;
+		ret = remap_pfn_range(vma, vma->vm_start, page_to_pfn(page),
+				      req_len, vma->vm_page_prot);
+		return ret;
+	}
+
+	vma->vm_private_data = adapter;
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	vma->vm_pgoff = (pci_resource_start(pdev, 0) >> PAGE_SHIFT) + pgoff;
+
+	vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
+	ret = io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
+				 vma->vm_end - vma->vm_start, vma->vm_page_prot);
+	return ret;
+}
+
+static int nbl_cdev_mmap(struct file *filep, struct vm_area_struct *vma)
+{
+	struct nbl_adapter *adapter = filep->private_data;
+
+	return nbl_userdev_common_mmap(adapter, vma);
+}
+
+static int nbl_userdev_register_net(struct nbl_adapter *adapter, void *resp,
+				    struct nbl_chan_send_info *chan_send)
+{
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct nbl_register_net_result *result = (struct nbl_register_net_result *)resp;
+	struct nbl_dev_vsi *vsi;
+	int ret = 0;
+
+	vsi = net_dev->vsi_ctrl.vsi_list[NBL_VSI_USER];
+
+	memset(result, 0, sizeof(*result));
+	result->tx_queue_num = vsi->queue_num;
+	result->rx_queue_num = vsi->queue_num;
+	result->rdma_enable = 0;
+	result->queue_offset = vsi->queue_offset;
+	result->trusted = 1;
+
+	if (vsi->queue_num == 0)
+		ret = -ENOSPC;
+
+	chan_send->ack_len = sizeof(struct nbl_register_net_result);
+
+	return ret;
+}
+
+static int nbl_userdev_alloc_txrx_queues(struct nbl_adapter *adapter, void *resp,
+					 struct nbl_chan_send_info *chan_send)
+{
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct nbl_chan_param_alloc_txrx_queues *result;
+	struct nbl_dev_vsi *vsi;
+
+	vsi = net_dev->vsi_ctrl.vsi_list[NBL_VSI_USER];
+	result = (struct nbl_chan_param_alloc_txrx_queues *)resp;
+	result->queue_num = vsi->queue_num;
+	result->vsi_id = vsi->vsi_id;
+
+	chan_send->ack_len = sizeof(struct nbl_chan_param_alloc_txrx_queues);
+
+	return 0;
+}
+
+static int nbl_userdev_get_vsi_id(struct nbl_adapter *adapter, void *resp,
+				  struct nbl_chan_send_info *chan_send)
+{
+	struct nbl_dev_mgt *dev_mgt = NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct nbl_chan_param_get_vsi_id *result;
+	struct nbl_dev_vsi *vsi;
+
+	vsi = net_dev->vsi_ctrl.vsi_list[NBL_VSI_USER];
+	result = (struct nbl_chan_param_get_vsi_id *)resp;
+	result->vsi_id = vsi->vsi_id;
+
+	chan_send->ack_len = sizeof(struct nbl_chan_param_get_vsi_id);
+
+	return 0;
+}
+
+static void nbl_userdev_translate_register_vsi2q(struct nbl_chan_send_info *chan_send)
+{
+	struct nbl_chan_param_register_vsi2q *param = chan_send->arg;
+
+	param->vsi_index = NBL_VSI_USER;
+}
+
+static void nbl_userdev_translate_clear_queues(struct nbl_chan_send_info *chan_send)
+{
+	chan_send->msg_type = NBL_CHAN_MSG_REMOVE_RSS;
+}
+
+static long nbl_userdev_channel_ioctl(struct nbl_adapter *adapter, unsigned long arg)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct nbl_chan_send_info chan_send = {0};
+	struct nbl_dev_user_channel_msg *msg;
+	void *resp;
+	int ret = 0;
+
+	msg = vmalloc(sizeof(*msg));
+	if (!msg)
+		return -ENOMEM;
+
+	if (copy_from_user(msg, (void __user *)arg, sizeof(*msg))) {
+		vfree(msg);
+		return -EFAULT;
+	}
+
+	resp = (unsigned char *)msg->data + msg->arg_len;
+	resp = (void *)ALIGN((u64)resp, 4);
+	NBL_CHAN_SEND(chan_send, msg->dst_id, msg->msg_type, msg->data, msg->arg_len,
+		      resp, msg->ack_length, msg->ack);
+
+	dev_dbg(&adapter->pdev->dev, "msg_type %u, arg_len %u, request %llx, resp %llx\n",
+		msg->msg_type, msg->arg_len, (u64)msg->data, (u64)resp);
+
+	switch (msg->msg_type) {
+	case NBL_CHAN_MSG_REGISTER_NET:
+		ret = nbl_userdev_register_net(adapter, resp, &chan_send);
+		break;
+	case NBL_CHAN_MSG_ALLOC_TXRX_QUEUES:
+		ret = nbl_userdev_alloc_txrx_queues(adapter, resp, &chan_send);
+		break;
+	case NBL_CHAN_MSG_GET_VSI_ID:
+		ret = nbl_userdev_get_vsi_id(adapter, resp, &chan_send);
+		break;
+	case NBL_CHAN_MSG_UNREGISTER_NET:
+	case NBL_CHAN_MSG_ADD_MULTI_RULE:
+	case NBL_CHAN_MSG_DEL_MULTI_RULE:
+	case NBL_CHAN_MSG_FREE_TXRX_QUEUES:
+	case NBL_CHAN_MSG_CLEAR_FLOW:
+		break;
+	case NBL_CHAN_MSG_CLEAR_QUEUE:
+		nbl_userdev_translate_clear_queues(&chan_send);
+		ret = chan_ops->send_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), &chan_send);
+		break;
+	case NBL_CHAN_MSG_REGISTER_VSI2Q:
+		nbl_userdev_translate_register_vsi2q(&chan_send);
+		ret = chan_ops->send_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), &chan_send);
+		break;
+	default:
+		ret = chan_ops->send_msg(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), &chan_send);
+		break;
+	}
+
+	msg->ack_length = chan_send.ack_len;
+	msg->ack_err = ret;
+	ret = copy_to_user((void __user *)arg, msg, sizeof(*msg));
+
+	vfree(msg);
+
+	return ret;
+}
+
+static long nbl_userdev_switch_network(struct nbl_adapter *adapter, unsigned long arg)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_dev_user *user = NBL_DEV_MGT_TO_USER_DEV(dev_mgt);
+	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct nbl_dev_vsi *vsi;
+	int timeout = 50;
+	int type;
+
+	if (get_user(type, (unsigned long __user *)arg)) {
+		dev_err(NBL_ADAPTER_TO_DEV(adapter),
+			"switch network get type failed\n");
+		return -EFAULT;
+	}
+
+	if (type == user->network_type)
+		return 0;
+
+	while (test_bit(NBL_RESETTING, adapter->state)) {
+		timeout--;
+		if (!timeout) {
+			dev_err(NBL_ADAPTER_TO_DEV(adapter),
+				"Timeout while resetting in user change state\n");
+			return -EBUSY;
+		}
+		usleep_range(1000, 2000);
+	}
+
+	vsi = net_dev->vsi_ctrl.vsi_list[NBL_VSI_USER];
+	if (type == NBL_USER_NETWORK) {
+		nbl_user_change_user_network(user);
+		serv_ops->set_promisc_mode(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					   vsi->vsi_id, user->user_promisc_mode);
+		serv_ops->cfg_multi_mcast(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+					  vsi->vsi_id, user->user_mcast_mode);
+	} else {
+		nbl_user_change_kernel_network(user);
+	}
+
+	return 0;
+}
+
+static long nbl_userdev_get_ifindex(struct nbl_adapter *adapter, unsigned long arg)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct net_device *netdev = net_dev->netdev;
+	int ifindex, ret;
+
+	ifindex = netdev->ifindex;
+	ret = copy_to_user((void __user *)arg, &ifindex, sizeof(ifindex));
+	return ret;
+}
+
+static long nbl_userdev_clear_eventfd(struct nbl_adapter *adapter, unsigned long arg)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+
+	chan_ops->clear_listener_info(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt));
+
+	return 0;
+}
+
+static long nbl_userdev_set_listener(struct nbl_adapter *adapter, unsigned long arg)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	int msgtype;
+
+	if (get_user(msgtype, (unsigned long __user *)arg)) {
+		dev_err(NBL_ADAPTER_TO_DEV(adapter), "get listener msgtype failed\n");
+		return -EFAULT;
+	}
+
+	chan_ops->set_listener_msgtype(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), msgtype);
+
+	return 0;
+}
+
+static long nbl_userdev_set_eventfd(struct nbl_adapter *adapter, unsigned long arg)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dev_user *user = NBL_DEV_MGT_TO_USER_DEV(dev_mgt);
+	struct nbl_channel_ops *chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	struct eventfd_ctx *ctx;
+	struct fd eventfd;
+	int fd;
+	long ret = 0;
+
+	if (get_user(fd, (unsigned long __user *)arg)) {
+		dev_err(NBL_ADAPTER_TO_DEV(adapter), "get user fd failed\n");
+		return -EFAULT;
+	}
+
+	eventfd = fdget(fd);
+	if (!fd_file(eventfd)) {
+		dev_err(NBL_ADAPTER_TO_DEV(adapter), "get eventfd failed\n");
+		return -EBADF;
+	}
+
+	ctx = eventfd_ctx_fileget(fd_file(eventfd));
+	if (IS_ERR(ctx)) {
+		ret = PTR_ERR(ctx);
+		dev_err(NBL_ADAPTER_TO_DEV(adapter), "get eventfd ctx failed\n");
+		return ret;
+	}
+
+	chan_ops->set_listener_info(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt), user->shm_msg_ring, ctx);
+
+	return ret;
+}
+
+static long nbl_userdev_get_bar_size(struct nbl_adapter *adapter, unsigned long arg)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	size_t size = pci_resource_len(adapter->pdev, 0);
+	u8 __iomem *hw_addr;
+	int ret;
+
+	hw_addr = serv_ops->get_hw_addr(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), &size);
+	ret = copy_to_user((void __user *)arg, &size, sizeof(size));
+
+	return ret;
+}
+
+static long nbl_userdev_get_dma_limit(struct nbl_adapter *adapter, unsigned long arg)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dev_user *user = NBL_DEV_MGT_TO_USER_DEV(dev_mgt);
+
+	/**
+	 * Linux kernel perfers to use 32-bit IOVAs, when 32-bit address space has been used.
+	 * Then attempt to use high address space.
+	 * The order of allocation is from high address to low address.
+	 *
+	 * DPDK setting the starting address at 4GB, please reference eal_get_baseaddr.
+	 * So dpdk iova almost not conflict with kernel.
+	 * Like heap-stack, kernel alloc iova from high to low, dpdk alloc iova from low to high.
+	 *
+	 * But in the scene, linux kernel config is passthrough,
+	 * nbl device has been modify to DMA by sysfs,
+	 * concurrent dpdk attach a device base uio, now dpdk use pa as iova.
+	 * Now pa maybe below 4G, and iommu map(iova(pa)->pa) may conflict with kernel.
+	 *
+	 * So dpdk remap policy is when dpdk use iova, not set iova msb.
+	 * when dpdk use pa as iova, set iova msb.
+	 * The best way is call reserve_iova to keep consistent between dpdk and kernel.
+	 * But struct iommu_dma_cookie not export symbols, we cannot get struct iova_domain
+	 * by struct iommu_domain->iova_cookie->iovad except define struct iommu_dma_cookie
+	 * in driver code.
+	 */
+
+	return copy_to_user((void __user *)arg, &user->dma_limit, sizeof(user->dma_limit));
+}
+
+static long nbl_userdev_set_multi_mode(struct nbl_adapter *adapter, unsigned int cmd,
+				       unsigned long arg)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_service_ops *serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+	struct nbl_dev_user *user = NBL_DEV_MGT_TO_USER_DEV(dev_mgt);
+	struct nbl_dev_net *net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	struct nbl_dev_vsi *vsi;
+	u16 user_multi_mode;
+	int ret = 0;
+
+	if (get_user(user_multi_mode, (unsigned long __user *)arg)) {
+		dev_err(NBL_ADAPTER_TO_DEV(adapter),
+			"set promic mode get mode failed\n");
+		return -EFAULT;
+	}
+
+	if (cmd == NBL_DEV_USER_SET_PROMISC_MODE && user_multi_mode == user->user_promisc_mode)
+		return 0;
+
+	if (cmd == NBL_DEV_USER_SET_MCAST_MODE && user_multi_mode == user->user_mcast_mode)
+		return 0;
+
+	vsi = net_dev->vsi_ctrl.vsi_list[NBL_VSI_USER];
+	if (user->network_type == NBL_USER_NETWORK) {
+		if (cmd == NBL_DEV_USER_SET_PROMISC_MODE)
+			ret = serv_ops->set_promisc_mode(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+							 vsi->vsi_id, user_multi_mode);
+		else
+			ret = serv_ops->cfg_multi_mcast(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt),
+							vsi->vsi_id, user_multi_mode);
+	}
+
+	if (cmd == NBL_DEV_USER_SET_PROMISC_MODE)
+		user->user_promisc_mode = user_multi_mode;
+	else
+		user->user_mcast_mode = user_multi_mode;
+
+	return ret;
+}
+
+static long nbl_userdev_common_ioctl(struct nbl_adapter *adapter, unsigned int cmd,
+				     unsigned long arg)
+{
+	int ret = -EINVAL;
+
+	switch (cmd) {
+	case NBL_DEV_USER_CHANNEL:
+		ret = nbl_userdev_channel_ioctl(adapter, arg);
+		break;
+	case NBL_DEV_USER_MAP_DMA:
+	case NBL_DEV_USER_UNMAP_DMA:
+		break;
+	case NBL_DEV_USER_SWITCH_NETWORK:
+		ret = nbl_userdev_switch_network(adapter, arg);
+		break;
+	case NBL_DEV_USER_GET_IFINDEX:
+		ret = nbl_userdev_get_ifindex(adapter, arg);
+		break;
+	case NBL_DEV_USER_SET_EVENTFD:
+		ret = nbl_userdev_set_eventfd(adapter, arg);
+		break;
+	case NBL_DEV_USER_CLEAR_EVENTFD:
+		ret = nbl_userdev_clear_eventfd(adapter, arg);
+		break;
+	case NBL_DEV_USER_SET_LISTENER:
+		ret = nbl_userdev_set_listener(adapter, arg);
+		break;
+	case NBL_DEV_USER_GET_BAR_SIZE:
+		ret = nbl_userdev_get_bar_size(adapter, arg);
+		break;
+	case NBL_DEV_USER_GET_DMA_LIMIT:
+		ret = nbl_userdev_get_dma_limit(adapter, arg);
+		break;
+	case NBL_DEV_USER_SET_PROMISC_MODE:
+	case NBL_DEV_USER_SET_MCAST_MODE:
+		ret = nbl_userdev_set_multi_mode(adapter, cmd, arg);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static long nbl_cdev_unlock_ioctl(struct file *filep, unsigned int cmd,
+				  unsigned long arg)
+{
+	struct nbl_adapter *adapter = filep->private_data;
+
+	return nbl_userdev_common_ioctl(adapter, cmd, arg);
+}
+
+static ssize_t nbl_vfio_read(struct vfio_device *vdev, char __user *buf,
+			     size_t count, loff_t *ppos)
+{
+	return -EFAULT;
+}
+
+static ssize_t nbl_vfio_write(struct vfio_device *vdev, const char __user *buf,
+			      size_t count, loff_t *ppos)
+{
+	return count;
+}
+
+#define NBL_VFIO_BATCH_MAX_CAPACITY	(PAGE_SIZE / sizeof(unsigned long))
+
+static int nbl_vfio_batch_init(struct nbl_vfio_batch *batch)
+{
+	batch->offset = 0;
+	batch->size = 0;
+
+	batch->pages_in = (unsigned long *)__get_free_page(GFP_KERNEL);
+	if (!batch->pages_in)
+		return -ENOMEM;
+
+	batch->pages_out = (unsigned long *)__get_free_page(GFP_KERNEL);
+	if (!batch->pages_out) {
+		free_page((unsigned long)batch->pages_in);
+		return -ENOMEM;
+	}
+
+	batch->h_page = kzalloc(NBL_VFIO_BATCH_MAX_CAPACITY * sizeof(struct page *), GFP_KERNEL);
+	if (!batch->h_page) {
+		free_page((unsigned long)batch->pages_in);
+		free_page((unsigned long)batch->pages_out);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void nbl_vfio_batch_fini(struct nbl_vfio_batch *batch)
+{
+	if (batch->pages_in)
+		free_page((unsigned long)batch->pages_in);
+
+	if (batch->pages_out)
+		free_page((unsigned long)batch->pages_out);
+
+	kfree(batch->h_page);
+}
+
+static struct nbl_userdev_dma *nbl_userdev_find_dma(struct nbl_dev_user_iommu_group *group,
+						    dma_addr_t start, size_t size)
+{
+	struct rb_node *node = group->dma_tree.rb_node;
+
+	while (node) {
+		struct nbl_userdev_dma *dma = rb_entry(node, struct nbl_userdev_dma, node);
+
+		if (start + size <= dma->vaddr)
+			node = node->rb_left;
+		else if (start >= dma->vaddr + dma->size)
+			node = node->rb_right;
+		else
+			return dma;
+	}
+
+	return NULL;
+}
+
+static struct rb_node *nbl_userdev_find_dma_first_node(struct nbl_dev_user_iommu_group *group,
+						       dma_addr_t start, size_t size)
+{
+	struct rb_node *res = NULL;
+	struct rb_node *node = group->dma_tree.rb_node;
+	struct nbl_userdev_dma *dma_res = NULL;
+
+	while (node) {
+		struct nbl_userdev_dma *dma = rb_entry(node, struct nbl_userdev_dma, node);
+
+		if (start < dma->vaddr + dma->size) {
+			res = node;
+			dma_res = dma;
+			if (start >= dma->vaddr)
+				break;
+			node = node->rb_left;
+		} else {
+			node = node->rb_right;
+		}
+	}
+	if (res && size && dma_res->vaddr >= start + size)
+		res = NULL;
+	return res;
+}
+
+/**
+ * check dma conflict when multi devices in one iommu group, That is, when ACS not support.
+ * return -1 means multi devices conflict.
+ * return 1 means mapping exist and not conflict.
+ * return 0 means mapping not existed.
+ */
+static int nbl_userdev_check_dma_conflict(struct nbl_dev_user *user,
+					  unsigned long vaddr, dma_addr_t iova, size_t size)
+{
+	struct nbl_dev_user_iommu_group *group = user->group;
+	struct nbl_userdev_dma *dma;
+	struct rb_node *n;
+	struct page *h_page;
+	size_t unmapped = 0;
+	unsigned long vfn, pfn, vaddr_new;
+	dma_addr_t iova_new;
+	int ret;
+
+	dma = nbl_userdev_find_dma(group, vaddr, 1);
+	if (dma && dma->vaddr != vaddr)
+		return -1;
+
+	dma = nbl_userdev_find_dma(group, vaddr + size - 1, 0);
+	if (dma && dma->vaddr + dma->size != vaddr + size)
+		return -1;
+
+	if (!nbl_userdev_find_dma(group, vaddr, size))
+		return 0;
+	n = nbl_userdev_find_dma_first_node(group, vaddr, size);
+	vaddr_new = vaddr;
+	iova_new = iova;
+	while (n) {
+		dma = rb_entry(n, struct nbl_userdev_dma, node);
+		if (dma->iova >= iova + size)
+			break;
+
+		if (dma->vaddr >= vaddr + size)
+			break;
+
+		if (dma->vaddr != vaddr_new || dma->iova != iova_new)
+			break;
+
+		vfn = vaddr_new >> PAGE_SHIFT;
+		ret = vfio_pin_pages(NBL_USERDEV_TO_VFIO_DEV(user),
+				     vaddr_new, 1, IOMMU_READ | IOMMU_WRITE, &h_page);
+		if (ret <= 0)
+			break;
+		pfn = page_to_pfn(h_page);
+		vfio_unpin_pages(NBL_USERDEV_TO_VFIO_DEV(user), vaddr_new, 1);
+		if (pfn != dma->pfn)
+			break;
+
+		n = rb_next(n);
+		unmapped += dma->size;
+		vaddr_new += dma->size;
+		iova_new += dma->size;
+	}
+
+	if (unmapped != size)
+		return -1;
+
+	return 1;
+}
+
+static void nbl_userdev_link_dma(struct nbl_dev_user_iommu_group *group,
+				 struct nbl_userdev_dma *new)
+{
+	struct rb_node **link = &group->dma_tree.rb_node, *parent = NULL;
+	struct nbl_userdev_dma *dma;
+
+	while (*link) {
+		parent = *link;
+		dma = rb_entry(parent, struct nbl_userdev_dma, node);
+
+		if (new->vaddr + new->size <= dma->vaddr)
+			link = &(*link)->rb_left;
+		else
+			link = &(*link)->rb_right;
+	}
+
+	rb_link_node(&new->node, parent, link);
+	rb_insert_color(&new->node, &group->dma_tree);
+}
+
+#ifdef CONFIG_ARM64
+static int check_phytium_cpu(void)
+{
+	u32 midr = read_cpuid_id();
+	u32 vendor = (midr >> VENDOR_OFFSET) & VENDOR_MASK;
+
+	if (vendor == VENDOR_PHYTIUM)
+		return 1;
+
+	return 0;
+}
+#endif
+
+static void nbl_userdev_remove_dma(struct nbl_dev_user_iommu_group *group,
+				   struct nbl_userdev_dma *dma)
+{
+	struct nbl_vfio_batch batch;
+	size_t unmmaped;
+	long npage, batch_pages;
+	unsigned long vaddr;
+	int ret, caps;
+	unsigned long *ppfn, pfn;
+	int i = 0;
+
+	dev_dbg(group->dev, "dma remove: vaddr 0x%lx, iova 0x%llx, size 0x%lx\n",
+		dma->vaddr, dma->iova, dma->size);
+	unmmaped = iommu_unmap(iommu_get_domain_for_dev(group->dev), dma->iova, dma->size);
+	WARN_ON(unmmaped != dma->size);
+	/**
+	 * For kylin + FT Server, Exist dma invalid content when smmu translate mode.
+	 * We can flush iommu tlb force to avoid the problem.
+	 */
+#ifdef CONFIG_ARM64
+	if (check_phytium_cpu())
+		iommu_flush_iotlb_all(iommu_get_domain_for_dev(group->dev));
+#endif
+
+	ret = nbl_vfio_batch_init(&batch);
+	if (ret) {
+		caps = 1;
+		ppfn = &pfn;
+	} else {
+		caps = NBL_VFIO_BATCH_MAX_CAPACITY;
+		ppfn = batch.pages_in;
+	}
+
+	npage = dma->size >> PAGE_SHIFT;
+	vaddr = dma->vaddr;
+
+	while (npage) {
+		if (npage >= caps)
+			batch_pages = caps;
+		else
+			batch_pages = npage;
+
+		ppfn[0] = vaddr >> PAGE_SHIFT;
+		for (i = 1; i < batch_pages; i++)
+			ppfn[i] =  ppfn[i - 1] + 1;
+
+		vfio_unpin_pages(group->vdev, vaddr, batch_pages);
+		dev_dbg(group->dev, "unpin pages 0x%lx, npages %ld, ret %d\n",
+			ppfn[0], batch_pages, ret);
+		npage -= batch_pages;
+		vaddr += (batch_pages << PAGE_SHIFT);
+	}
+
+	nbl_vfio_batch_fini(&batch);
+	rb_erase(&dma->node, &group->dma_tree);
+	kfree(dma);
+}
+
+static long nbl_userdev_dma_map_ioctl(struct nbl_dev_user *user, unsigned long arg)
+{
+	struct nbl_dev_user_dma_map map;
+	struct nbl_adapter *adapter = user->adapter;
+	struct pci_dev *pdev = adapter->pdev;
+	struct device *dev = &pdev->dev;
+	struct nbl_vfio_batch batch;
+	struct nbl_userdev_dma *dma;
+	unsigned long minsz, pfn_base = 0, pfn;
+	unsigned long vaddr;
+	dma_addr_t iova;
+	u32 mask = NBL_DEV_USER_DMA_MAP_FLAG_READ | NBL_DEV_USER_DMA_MAP_FLAG_WRITE;
+	size_t size;
+	long npage, batch_pages, pinned = 0;
+	int i, ret = 0;
+	phys_addr_t phys;
+
+	minsz = offsetofend(struct nbl_dev_user_dma_map, size);
+
+	if (copy_from_user(&map, (void __user *)arg, minsz))
+		return -EFAULT;
+
+	if (map.argsz < minsz || map.flags & ~mask)
+		return -EINVAL;
+
+	npage = map.size >> PAGE_SHIFT;
+	vaddr = map.vaddr;
+	iova = map.iova;
+
+	if (!npage)
+		return ret;
+
+	mutex_lock(&user->group->dma_tree_lock);
+	ret = nbl_userdev_check_dma_conflict(user, vaddr, iova, map.size);
+	if (ret < 0) {
+		dev_err(dev, "multiple dma not equal\n");
+		ret = -EINVAL;
+		goto mutext_unlock;
+	}
+
+	if (ret) {
+		ret = 0;
+		goto mutext_unlock;
+	}
+
+	dma = kzalloc(sizeof(*dma), GFP_KERNEL);
+	if (!dma) {
+		ret = -ENOMEM;
+		goto mutext_unlock;
+	}
+
+	if (nbl_vfio_batch_init(&batch)) {
+		kfree(dma);
+		ret = -ENOMEM;
+		goto mutext_unlock;
+	}
+
+	while (npage) {
+		if (batch.size == 0) {
+			if (npage >= NBL_VFIO_BATCH_MAX_CAPACITY)
+				batch_pages = NBL_VFIO_BATCH_MAX_CAPACITY;
+			else
+				batch_pages = npage;
+			batch.pages_in[0] = vaddr >> PAGE_SHIFT;
+			for (i = 1; i < batch_pages; i++)
+				batch.pages_in[i] = batch.pages_in[i - 1] + 1;
+
+			ret = vfio_pin_pages(NBL_USERDEV_TO_VFIO_DEV(user), vaddr, batch_pages,
+					     IOMMU_READ | IOMMU_WRITE, batch.h_page);
+
+			dev_dbg(dev, "page %ld pages, return %d\n", batch_pages, batch.size);
+			if (ret <= 0) {
+				dev_err(dev, "pin page failed\n");
+				goto unwind;
+			}
+
+			for (i = 0; i < batch_pages; i++)
+				batch.pages_out[i] = page_to_pfn(batch.h_page[i]);
+
+			batch.offset = 0;
+			batch.size = ret;
+			if (!pfn_base) {
+				pfn_base = batch.pages_out[batch.offset];
+				dma->pfn = batch.pages_out[batch.offset];
+			}
+		}
+
+		while (batch.size) {
+			pfn = batch.pages_out[batch.offset];
+			if (pfn == (pfn_base + pinned)) {
+				pinned++;
+				vaddr += PAGE_SIZE;
+				batch.offset++;
+				batch.size--;
+				npage--;
+				continue;
+			}
+
+			size = pinned << PAGE_SHIFT;
+			phys = pfn_base << PAGE_SHIFT;
+
+			ret = iommu_map(iommu_get_domain_for_dev(dev), iova, phys,
+					size, IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE, GFP_KERNEL);
+
+			if (ret) {
+				dev_err(dev, "iommu_map failed\n");
+				goto unwind;
+			}
+			dev_dbg(dev, "iommu map succeed, iova 0x%llx, phys 0x%llx,\n"
+				"size 0x%llx\n", (u64)iova, (u64)phys, (u64)size);
+			pfn_base = pfn;
+			pinned = 0;
+			iova += size;
+		}
+	}
+
+	if (pinned) {
+		size = pinned << PAGE_SHIFT;
+		phys = pfn_base << PAGE_SHIFT;
+
+		ret = iommu_map(iommu_get_domain_for_dev(dev), iova, phys,
+				size, IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE, GFP_KERNEL);
+
+		if (ret) {
+			dev_err(dev, "iommu_map failed\n");
+			goto unwind;
+		}
+		dev_dbg(dev, "iommu map succeed, iova 0x%llx, phys 0x%llx,\n"
+			"size 0x%llx\n", (u64)iova, (u64)phys, (u64)size);
+	}
+	nbl_vfio_batch_fini(&batch);
+
+	dma->iova = map.iova;
+	dma->size = map.size;
+	dma->vaddr = map.vaddr;
+	nbl_userdev_link_dma(user->group, dma);
+
+	dev_info(dev, "dma map info: vaddr=0x%llx, iova=0x%llx, size=0x%llx\n",
+		 (u64)map.vaddr, (u64)map.iova, (u64)map.size);
+	mutex_unlock(&user->group->dma_tree_lock);
+
+	return ret;
+
+unwind:
+	if (iova > map.iova)
+		iommu_unmap(iommu_get_domain_for_dev(dev), map.iova, iova - map.iova);
+
+	if (batch.size)
+		vfio_unpin_pages(NBL_USERDEV_TO_VFIO_DEV(user), vaddr, batch.size);
+
+	npage = (vaddr - map.vaddr) >> PAGE_SHIFT;
+	vaddr = map.vaddr;
+
+	while (npage) {
+		if (npage >= NBL_VFIO_BATCH_MAX_CAPACITY)
+			batch_pages = NBL_VFIO_BATCH_MAX_CAPACITY;
+		else
+			batch_pages = npage;
+
+		batch.pages_in[0] = vaddr >> PAGE_SHIFT;
+		for (i = 1; i < batch_pages; i++)
+			batch.pages_in[i] =  batch.pages_in[i - 1] + 1;
+
+		vfio_unpin_pages(NBL_USERDEV_TO_VFIO_DEV(user), vaddr, batch_pages);
+		npage -= batch_pages;
+		vaddr += (batch_pages << PAGE_SHIFT);
+	}
+	nbl_vfio_batch_fini(&batch);
+
+mutext_unlock:
+	mutex_unlock(&user->group->dma_tree_lock);
+
+	return ret;
+}
+
+static long nbl_userdev_dma_unmap_ioctl(struct nbl_dev_user *user, unsigned long arg)
+{
+	struct nbl_adapter *adapter = user->adapter;
+	struct pci_dev *pdev = adapter->pdev;
+	struct device *dev = &pdev->dev;
+	struct nbl_dev_user_dma_unmap unmap;
+	struct nbl_userdev_dma *dma;
+	unsigned long minsz;
+	size_t unmapped = 0;
+	struct rb_node *n;
+
+	minsz = offsetofend(struct nbl_dev_user_dma_unmap, size);
+
+	if (copy_from_user(&unmap, (void __user *)arg, minsz))
+		return -EFAULT;
+
+	if (unmap.argsz < minsz)
+		return -EINVAL;
+
+	dev_info(dev, "dma unmap info: vaddr=0x%llx, iova=0x%llx, size=0x%llx\n",
+		 (u64)unmap.vaddr, (u64)unmap.iova, (u64)unmap.size);
+
+	mutex_lock(&user->group->dma_tree_lock);
+	user->group->vdev = NBL_USERDEV_TO_VFIO_DEV(user);
+	dma = nbl_userdev_find_dma(user->group, unmap.vaddr, 1);
+	if (dma && dma->vaddr != unmap.vaddr)
+		return -1;
+
+	dma = nbl_userdev_find_dma(user->group, unmap.vaddr + unmap.size - 1, 0);
+	if (dma && dma->vaddr + dma->size != unmap.vaddr + unmap.size)
+		goto unlock;
+
+	n = nbl_userdev_find_dma_first_node(user->group, unmap.vaddr, unmap.size);
+	while (n) {
+		dma = rb_entry(n, struct nbl_userdev_dma, node);
+		if (dma->vaddr >= unmap.vaddr + unmap.size)
+			break;
+
+		n = rb_next(n);
+		nbl_userdev_remove_dma(user->group, dma);
+		unmapped += dma->size;
+	}
+unlock:
+	mutex_unlock(&user->group->dma_tree_lock);
+	unmap.size = unmapped;
+
+	return 0;
+}
+
+static long nbl_vfio_ioctl(struct vfio_device *vdev, unsigned int cmd, unsigned long arg)
+{
+	struct nbl_dev_user *user;
+	long ret;
+
+	user = NBL_VFIO_DEV_TO_USERDEV(vdev);
+	switch (cmd) {
+	case NBL_DEV_USER_MAP_DMA:
+		ret = nbl_userdev_dma_map_ioctl(user, arg);
+		break;
+	case NBL_DEV_USER_UNMAP_DMA:
+		ret = nbl_userdev_dma_unmap_ioctl(user, arg);
+		break;
+	default:
+		ret = nbl_userdev_common_ioctl(user->adapter, cmd, arg);
+		break;
+	}
+
+	return ret;
+}
+
+static int nbl_vfio_mmap(struct vfio_device *vdev, struct vm_area_struct *vma)
+{
+	struct nbl_dev_user *user;
+
+	user = NBL_VFIO_DEV_TO_USERDEV(vdev);
+	return nbl_userdev_common_mmap(user->adapter, vma);
+}
+
+static void nbl_vfio_dma_unmap(struct vfio_device *vdev, u64 iova, u64 length)
+{
+	struct nbl_dev_user *user = NBL_VFIO_DEV_TO_USERDEV(vdev);
+	struct nbl_userdev_dma *dma;
+
+	dev_info(user->group->dev, "vdev notifyier iova 0x%llx, size 0x%llx\n",
+		 iova, length);
+
+	mutex_lock(&user->group->dma_tree_lock);
+	user->group->vdev = vdev;
+	dma = nbl_userdev_find_dma(user->group, (dma_addr_t)iova, (size_t)length);
+	if (dma)
+		nbl_userdev_remove_dma(user->group, dma);
+	mutex_unlock(&user->group->dma_tree_lock);
+}
+
+static void nbl_userdev_group_get(struct nbl_dev_user_iommu_group *group)
+{
+	kref_get(&group->kref);
+}
+
+static void nbl_userdev_release_group(struct kref *kref)
+{
+	struct nbl_dev_user_iommu_group *group;
+	struct rb_node *node;
+
+	group = container_of(kref, struct nbl_dev_user_iommu_group, kref);
+	list_del(&group->group_next);
+	mutex_unlock(&nbl_userdev.glock);
+	mutex_lock(&group->dma_tree_lock);
+	while ((node = rb_first(&group->dma_tree)))
+		nbl_userdev_remove_dma(group, rb_entry(node, struct nbl_userdev_dma, node));
+
+	iommu_group_put(group->iommu_group);
+	mutex_unlock(&group->dma_tree_lock);
+	kfree(group);
+}
+
+static void nbl_userdev_group_put(struct nbl_dev_user *user, struct nbl_dev_user_iommu_group *group)
+{
+	group->vdev = NBL_USERDEV_TO_VFIO_DEV(user);
+	kref_put_mutex(&group->kref, nbl_userdev_release_group, &nbl_userdev.glock);
+}
+
+static struct nbl_dev_user_iommu_group *
+	nbl_userdev_group_get_from_iommu(struct iommu_group *iommu_group)
+{
+	struct nbl_dev_user_iommu_group *group;
+
+	mutex_lock(&nbl_userdev.glock);
+	list_for_each_entry(group, &nbl_userdev.glist, group_next) {
+		if (group->iommu_group == iommu_group) {
+			nbl_userdev_group_get(group);
+			mutex_unlock(&nbl_userdev.glock);
+			return group;
+		}
+	}
+
+	mutex_unlock(&nbl_userdev.glock);
+
+	return NULL;
+}
+
+static
+struct nbl_dev_user_iommu_group *nbl_userdev_create_group(struct iommu_group *iommu_group,
+							  struct device *dev,
+							  struct vfio_device *vdev)
+{
+	struct nbl_dev_user_iommu_group *group, *tmp;
+
+	group = kzalloc(sizeof(*group), GFP_KERNEL);
+	if (!group)
+		return ERR_PTR(-ENOMEM);
+
+	kref_init(&group->kref);
+	mutex_init(&group->dma_tree_lock);
+	group->iommu_group = iommu_group;
+	group->dma_tree = RB_ROOT;
+	group->dev = dev;
+	group->vdev = vdev;
+
+	mutex_lock(&nbl_userdev.glock);
+	list_for_each_entry(tmp, &nbl_userdev.glist, group_next) {
+		if (tmp->iommu_group == iommu_group) {
+			nbl_userdev_group_get(tmp);
+			mutex_unlock(&nbl_userdev.glock);
+			kfree(group);
+			return tmp;
+		}
+	}
+
+	list_add(&group->group_next, &nbl_userdev.glist);
+	mutex_unlock(&nbl_userdev.glock);
+
+	return group;
+}
+
+static int nbl_vfio_open(struct vfio_device *vdev)
+{
+	struct nbl_dev_user *user;
+	struct nbl_dev_user_iommu_group *group;
+	struct iommu_group *iommu_group;
+	struct nbl_adapter *adapter;
+	struct pci_dev *pdev;
+	int ret = 0, opened;
+
+	user = NBL_VFIO_DEV_TO_USERDEV(vdev);
+	adapter = user->adapter;
+	pdev = adapter->pdev;
+
+	if (test_bit(NBL_FATAL_ERR, adapter->state))
+		return -EIO;
+
+	opened = atomic_cmpxchg(&user->open_cnt, 0, 1);
+	if (opened)
+		return -EBUSY;
+
+	rtnl_lock();
+
+	set_bit(NBL_USER, adapter->state);
+	rtnl_unlock();
+
+	/* add iommu group list */
+	iommu_group = iommu_group_get(&pdev->dev);
+	if (!iommu_group) {
+		dev_err(&pdev->dev, "nbl vfio open failed\n");
+		ret = -EINVAL;
+		goto clear_open_cnt;
+	}
+
+	group = nbl_userdev_group_get_from_iommu(iommu_group);
+	if (!group) {
+		group = nbl_userdev_create_group(iommu_group, &pdev->dev, vdev);
+		if (IS_ERR(group)) {
+			iommu_group_put(iommu_group);
+			ret = PTR_ERR(group);
+			goto clear_open_cnt;
+		}
+	} else {
+		iommu_group_put(iommu_group);
+	}
+
+	user->group = group;
+
+	dev_info(&pdev->dev, "nbl vfio open\n");
+
+	return ret;
+
+clear_open_cnt:
+	atomic_set(&user->open_cnt, 0);
+	clear_bit(NBL_USER, adapter->state);
+
+	return ret;
+}
+
+static void nbl_vfio_close(struct vfio_device *vdev)
+{
+	struct nbl_dev_user *user;
+	struct nbl_adapter *adapter;
+	struct pci_dev *pdev;
+	struct nbl_dev_mgt *dev_mgt;
+	struct nbl_dev_net *net_dev;
+	struct nbl_channel_ops *chan_ops;
+	struct nbl_service_ops *serv_ops;
+
+	user = NBL_VFIO_DEV_TO_USERDEV(vdev);
+	adapter = user->adapter;
+	pdev = adapter->pdev;
+	dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
+	net_dev = NBL_DEV_MGT_TO_NET_DEV(dev_mgt);
+	chan_ops = NBL_DEV_MGT_TO_CHAN_OPS(dev_mgt);
+	serv_ops = NBL_DEV_MGT_TO_SERV_OPS(dev_mgt);
+
+	if (user->group)
+		nbl_userdev_group_put(user, user->group);
+	user->group = NULL;
+
+	chan_ops->clear_listener_info(NBL_DEV_MGT_TO_CHAN_PRIV(dev_mgt));
+	nbl_user_change_kernel_network(user);
+	serv_ops->clear_flow(NBL_DEV_MGT_TO_SERV_PRIV(dev_mgt), user->user_vsi);
+	atomic_set(&user->open_cnt, 0);
+	clear_bit(NBL_USER, adapter->state);
+	user->user_promisc_mode = 0;
+
+	dev_info(&pdev->dev, "nbl vfio close\n");
+}
+
+static void nbl_vfio_release(struct vfio_device *vdev)
+{
+}
+
+static int nbl_vfio_init(struct vfio_device *vdev)
+{
+	return 0;
+}
+
+static const struct vfio_device_ops nbl_vfio_dev_ops = {
+	.name = "vfio-nbl",
+	.open_device = nbl_vfio_open,
+	.close_device = nbl_vfio_close,
+	.init = nbl_vfio_init,
+	.release = nbl_vfio_release,
+	.read = nbl_vfio_read,
+	.write = nbl_vfio_write,
+	.ioctl = nbl_vfio_ioctl,
+	.mmap = nbl_vfio_mmap,
+	.dma_unmap = nbl_vfio_dma_unmap,
+	.bind_iommufd = vfio_iommufd_emulated_bind,
+	.unbind_iommufd = vfio_iommufd_emulated_unbind,
+	.attach_ioas = vfio_iommufd_emulated_attach_ioas,
+	.detach_ioas = vfio_iommufd_emulated_detach_ioas,
+};
+
+static const struct file_operations nbl_cdev_fops = {
+	.owner = THIS_MODULE,
+	.open = nbl_cdev_open,
+	.unlocked_ioctl = nbl_cdev_unlock_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
+	.release = nbl_cdev_release,
+	.mmap = nbl_cdev_mmap,
+};
+
+static int nbl_bus_probe(struct device *dev)
+{
+	struct nbl_dev_user *user = container_of(dev, struct nbl_dev_user, mdev);
+	struct nbl_vfio_device *vdev;
+	int ret;
+
+	vdev = vfio_alloc_device(nbl_vfio_device, vdev, dev, &nbl_vfio_dev_ops);
+	if (IS_ERR(vdev))
+		return PTR_ERR(vdev);
+	user->vdev = &vdev->vdev;
+	vdev->user = user;
+
+	ret = vfio_register_emulated_iommu_dev(NBL_USERDEV_TO_VFIO_DEV(user));
+	if (ret) {
+		dev_err(dev, "vfio register iommu failed, ret %d\n", ret);
+		vfio_put_device(NBL_USERDEV_TO_VFIO_DEV(user));
+	}
+
+	return ret;
+}
+
+static void nbl_bus_remove(struct device *dev)
+{
+	struct nbl_dev_user *user = container_of(dev, struct nbl_dev_user, mdev);
+
+	vfio_unregister_group_dev(NBL_USERDEV_TO_VFIO_DEV(user));
+	vfio_put_device(NBL_USERDEV_TO_VFIO_DEV(user));
+}
+
+static int nbl_bus_match(struct device *dev, const struct device_driver *drv)
+{
+	return 0;
+}
+
+static const struct bus_type nbl_bus_type = {
+	.name = "nbl_bus_type",
+	.probe = nbl_bus_probe,
+	.remove = nbl_bus_remove,
+	.match = nbl_bus_match,
+};
+
+static struct device_driver nbl_userdev_driver = {
+	.bus = &nbl_bus_type,
+	.name = "nbl_userdev",
+	.owner = THIS_MODULE,
+	.mod_name = KBUILD_MODNAME,
+};
+
+static void nbl_mdev_device_release(struct device *dev)
+{
+	dev_info(dev, "nbl mdev device release\n");
+}
+
+void nbl_dev_start_user_dev(struct nbl_adapter *adapter)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_common_info *common = NBL_ADAPTER_TO_COMMON(adapter);
+	struct device *dev = NBL_COMMON_TO_DEV(common);
+	struct device *cdev = NULL, *mdev;
+	struct pci_dev *pdev = NBL_COMMON_TO_PDEV(common);
+	struct nbl_dev_user *user;
+	struct device_driver *drv;
+	void *shm_msg_ring;
+	struct nbl_dev_vsi *user_vsi;
+	u64 dma_limit;
+	bool iommu_status = 0, remap_status = 0;
+	int minor = 0, ret;
+
+	if (!nbl_userdev.success)
+		return;
+
+	if (!dev_is_dma_coherent(dev))
+		return;
+
+	user_vsi = nbl_dev_vsi_select(dev_mgt, NBL_VSI_USER);
+
+	ret = user_vsi->ops->setup(dev_mgt, &adapter->init_param, user_vsi);
+	if (ret) {
+		dev_err(NBL_DEV_MGT_TO_DEV(dev_mgt), "User-vsi setup failed");
+		return;
+	}
+	iommu_status = nbl_dma_iommu_status(pdev);
+	remap_status = nbl_dma_remap_status(pdev, &dma_limit);
+	/* 39bits with 3-level paging, 48bits with 4-level paging, 57bits with 5-level paging */
+	WARN_ON(fls64(dma_limit) < 39);
+	/* iommu passthrough must keep dpdk iova pa mode */
+	shm_msg_ring = kzalloc(NBL_USER_DEV_SHMMSGRING_SIZE, GFP_KERNEL);
+	if (!shm_msg_ring)
+		return;
+
+	user = devm_kzalloc(dev, sizeof(struct nbl_dev_user), GFP_KERNEL);
+	if (!user) {
+		kfree(shm_msg_ring);
+		return;
+	}
+
+	if (remap_status) {
+		/* mdev init */
+		mdev = &user->mdev;
+		mdev->bus = &nbl_bus_type;
+		drv = &nbl_userdev_driver;
+
+		device_initialize(mdev);
+		mdev->parent = dev;
+		mdev->release = nbl_mdev_device_release;
+
+		ret = dev_set_name(mdev, pci_name(pdev));
+		if (ret) {
+			dev_info(dev, "mdev set name failed\n");
+			goto free_dev;
+		}
+
+		ret = device_add(mdev);
+		if (ret) {
+			dev_err(dev, "mdev add failed\n");
+			goto free_dev;
+		}
+		dev_info(dev, "MDEV: created\n");
+
+		ret = device_driver_attach(drv, mdev);
+
+		if (ret) {
+			dev_err(dev, "driver attach failed %d\n", ret);
+			device_del(mdev);
+			put_device(mdev);
+			goto free_dev;
+		}
+	} else {
+		mutex_lock(&nbl_userdev.clock);
+		ret = xa_alloc(&nbl_userdev.xa, &minor, adapter,
+			       XA_LIMIT(1, MINORMASK + 1), GFP_KERNEL);
+		if (ret < 0) {
+			dev_err(dev, "alloc userdev dev minor failed\n");
+			mutex_unlock(&nbl_userdev.clock);
+			goto free_dev;
+		}
+
+		cdev = device_create(nbl_userdev.cls, NULL, MKDEV(MAJOR(nbl_userdev.cdevt), minor),
+				     NULL, pci_name(pdev));
+		if (IS_ERR(cdev)) {
+			dev_err(dev, "device create failed\n");
+			xa_erase(&nbl_userdev.xa, minor);
+			mutex_unlock(&nbl_userdev.clock);
+			goto free_dev;
+		}
+		mutex_unlock(&nbl_userdev.clock);
+		user->dev = cdev;
+		user->minor = minor;
+	}
+
+	user->shm_msg_ring = shm_msg_ring;
+	user->adapter = adapter;
+	user->iommu_status = iommu_status;
+	user->remap_status = remap_status;
+	user->dma_limit = dma_limit;
+	atomic_set(&user->open_cnt, 0);
+	user->network_type = NBL_KERNEL_NETWORK;
+	user->user_promisc_mode = 0;
+	user->user_mcast_mode = 0;
+	user->user_vsi = user_vsi->vsi_id;
+
+	NBL_DEV_MGT_TO_USER_DEV(dev_mgt) = user;
+
+	return;
+
+free_dev:
+	devm_kfree(dev, user);
+	kfree(shm_msg_ring);
+}
+
+void nbl_dev_stop_user_dev(struct nbl_adapter *adapter)
+{
+	struct nbl_dev_mgt *dev_mgt = (struct nbl_dev_mgt *)NBL_ADAPTER_TO_DEV_MGT(adapter);
+	struct nbl_dev_user *user = NBL_DEV_MGT_TO_USER_DEV(dev_mgt);
+	struct nbl_common_info *common = NBL_ADAPTER_TO_COMMON(adapter);
+	struct device *dev = NBL_COMMON_TO_DEV(common);
+	struct device *mdev;
+
+	if (!user)
+		return;
+
+	while (atomic_read(&user->open_cnt)) {
+		dev_info(dev, "userdev application need quit!\n");
+		msleep(2000);
+	}
+
+	kfree(user->shm_msg_ring);
+
+	if (user->remap_status) {
+		mdev = &user->mdev;
+		device_del(mdev);
+		put_device(mdev);
+		devm_kfree(dev, user);
+	} else if (user->dev) {
+		mutex_lock(&nbl_userdev.clock);
+		device_destroy(nbl_userdev.cls, MKDEV(MAJOR(nbl_userdev.cdevt), user->minor));
+		user->dev = NULL;
+		mutex_unlock(&nbl_userdev.clock);
+		devm_kfree(dev, user);
+	}
+
+	NBL_DEV_MGT_TO_USER_DEV(dev_mgt) = NULL;
+}
+
+void nbl_dev_user_module_init(void)
+{
+	int ret;
+
+	xa_init(&nbl_userdev.xa);
+	mutex_init(&nbl_userdev.clock);
+	mutex_init(&nbl_userdev.glock);
+	INIT_LIST_HEAD(&nbl_userdev.glist);
+
+	ret = bus_register(&nbl_bus_type);
+	if (ret) {
+		pr_err("nbl bus type register failed\n");
+		return;
+	}
+	ret = driver_register(&nbl_userdev_driver);
+	if (ret) {
+		pr_err("nbl userdev driver register failed\n");
+		bus_unregister(&nbl_bus_type);
+		return;
+	}
+	nbl_userdev.cls = class_create("nbl_userdev");
+	if (IS_ERR(nbl_userdev.cls)) {
+		pr_err("nbl_userdev class alloc failed\n");
+		goto err_create_cls;
+	}
+
+	nbl_userdev.cls->devnode = user_cdevnode;
+
+	ret = alloc_chrdev_region(&nbl_userdev.cdevt, 0, MINORMASK + 1, "nbl_userdev");
+	if (ret) {
+		pr_err("nbl_userdev alloc chrdev region failed\n");
+		goto err_alloc_chrdev;
+	}
+
+	cdev_init(&nbl_userdev.cdev, &nbl_cdev_fops);
+	ret = cdev_add(&nbl_userdev.cdev, nbl_userdev.cdevt, MINORMASK + 1);
+	if (ret) {
+		pr_err("nbl_userdev cdev add failed\n");
+		goto err_cdev_add;
+	}
+
+	nbl_userdev.success = 1;
+	pr_info("user_module init success\n");
+
+	return;
+
+err_cdev_add:
+	unregister_chrdev_region(nbl_userdev.cdevt, MINORMASK + 1);
+err_alloc_chrdev:
+	class_destroy(nbl_userdev.cls);
+	nbl_userdev.cls = NULL;
+err_create_cls:
+	driver_unregister(&nbl_userdev_driver);
+	bus_unregister(&nbl_bus_type);
+}
+
+void nbl_dev_user_module_destroy(void)
+{
+	if (nbl_userdev.success) {
+		cdev_del(&nbl_userdev.cdev);
+		unregister_chrdev_region(nbl_userdev.cdevt, MINORMASK + 1);
+		class_destroy(nbl_userdev.cls);
+		nbl_userdev.cls = NULL;
+		driver_unregister(&nbl_userdev_driver);
+		bus_unregister(&nbl_bus_type);
+		nbl_userdev.success = 0;
+	}
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev_user.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev_user.h
new file mode 100644
index 000000000000..4a4dd1785b73
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_dev_user.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_DEV_USER_H_
+#define _NBL_DEV_USER_H_
+
+#define NBL_DEV_USER_TYPE	('n')
+
+#define NBL_DEV_USER_PCI_OFFSET_SHIFT		40
+#define NBL_DEV_USER_OFFSET_TO_INDEX(off)	((off) >> NBL_DEV_USER_PCI_OFFSET_SHIFT)
+#define NBL_DEV_USER_INDEX_TO_OFFSET(index)	((u64)(index) << NBL_DEV_USER_PCI_OFFSET_SHIFT)
+#define NBL_DEV_SHM_MSG_RING_INDEX		(6)
+
+/* 8192 ioctl mailbox msg */
+struct nbl_dev_user_channel_msg {
+	u16 msg_type;
+	u16 dst_id;
+	u32 arg_len;
+	u32 ack_err;
+	u16 ack_length;
+	u16 ack;
+	u32 data[2044];
+};
+
+#define NBL_DEV_USER_CHANNEL		_IO(NBL_DEV_USER_TYPE, 0)
+
+struct nbl_dev_user_dma_map {
+	u32	argsz;
+	u32	flags;
+#define NBL_DEV_USER_DMA_MAP_FLAG_READ BIT(0)	/* readable from device */
+#define NBL_DEV_USER_DMA_MAP_FLAG_WRITE BIT(1)	/* writable from device */
+	u64	vaddr;				/* Process virtual address */
+	u64	iova;				/* IO virtual address */
+	u64	size;				/* Size of mapping (bytes) */
+};
+
+#define NBL_DEV_USER_MAP_DMA		_IO(NBL_DEV_USER_TYPE, 1)
+
+struct nbl_dev_user_dma_unmap {
+	u32	argsz;
+	u32	flags;
+	u64	vaddr;
+	u64	iova;				/* IO virtual address */
+	u64	size;				/* Size of mapping (bytes) */
+};
+
+#define NBL_DEV_USER_UNMAP_DMA		_IO(NBL_DEV_USER_TYPE, 2)
+
+#define NBL_KERNEL_NETWORK			0
+#define NBL_USER_NETWORK			1
+
+#define NBL_DEV_USER_SWITCH_NETWORK	_IO(NBL_DEV_USER_TYPE, 3)
+
+#define NBL_DEV_USER_GET_IFINDEX	_IO(NBL_DEV_USER_TYPE, 4)
+
+#define NBL_DEV_USER_SET_EVENTFD	_IO(NBL_DEV_USER_TYPE, 5)
+
+#define NBL_DEV_USER_CLEAR_EVENTFD	_IO(NBL_DEV_USER_TYPE, 6)
+
+#define NBL_DEV_USER_SET_LISTENER	_IO(NBL_DEV_USER_TYPE, 7)
+
+#define NBL_DEV_USER_GET_BAR_SIZE	_IO(NBL_DEV_USER_TYPE, 8)
+
+#define NBL_DEV_USER_GET_DMA_LIMIT	_IO(NBL_DEV_USER_TYPE, 9)
+
+#define NBL_DEV_USER_SET_PROMISC_MODE	_IO(NBL_DEV_USER_TYPE, 10)
+
+#define NBL_DEV_USER_SET_MCAST_MODE	_IO(NBL_DEV_USER_TYPE, 11)
+
+void nbl_dev_start_user_dev(struct nbl_adapter *adapter);
+void nbl_dev_stop_user_dev(struct nbl_adapter *adapter);
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
index 60d17b12e364..605bed4b266a 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_core/nbl_service.c
@@ -784,6 +784,65 @@ static struct nbl_mac_filter *nbl_add_filter(struct list_head *head,
 	return f;
 }
 
+static int nbl_serv_suspend_data_vsi_traffic(struct nbl_service_mgt *serv_mgt)
+{
+	struct nbl_serv_net_resource_mgt *net_resource_mgt = NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	struct net_device *dev = net_resource_mgt->netdev;
+	struct nbl_netdev_priv *net_priv = netdev_priv(dev);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+	struct nbl_serv_flow_mgt *flow_mgt = NBL_SERV_MGT_TO_FLOW_MGT(serv_mgt);
+
+	rtnl_lock();
+	disp_ops->cfg_multi_mcast(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+				  net_priv->data_vsi, 0);
+	disp_ops->set_promisc_mode(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt),
+				   net_priv->data_vsi, 0);
+
+	disp_ops->add_macvlan(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), flow_mgt->mac,
+			      0, net_priv->user_vsi);
+
+	flow_mgt->promisc &= ~BIT(NBL_PROMISC);
+	flow_mgt->promisc &= ~BIT(NBL_ALLMULTI);
+	flow_mgt->promisc |= BIT(NBL_USER_FLOW);
+	rtnl_unlock();
+
+	nbl_common_queue_work(&net_resource_mgt->rx_mode_async, false);
+
+	return 0;
+}
+
+static int nbl_serv_restore_vsi_traffic(struct nbl_service_mgt *serv_mgt)
+{
+	struct nbl_serv_net_resource_mgt *net_resource_mgt = NBL_SERV_MGT_TO_NET_RES_MGT(serv_mgt);
+	struct net_device *dev = net_resource_mgt->netdev;
+	struct nbl_netdev_priv *net_priv = netdev_priv(dev);
+	struct nbl_serv_flow_mgt *flow_mgt = NBL_SERV_MGT_TO_FLOW_MGT(serv_mgt);
+	struct nbl_dispatch_ops *disp_ops = NBL_SERV_MGT_TO_DISP_OPS(serv_mgt);
+
+	rtnl_lock();
+	disp_ops->del_macvlan(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), flow_mgt->mac,
+			      0, net_priv->user_vsi);
+	disp_ops->cfg_multi_mcast(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), net_priv->user_vsi, 0);
+	disp_ops->set_promisc_mode(NBL_SERV_MGT_TO_DISP_PRIV(serv_mgt), net_priv->user_vsi, 0);
+	flow_mgt->promisc &= ~BIT(NBL_USER_FLOW);
+	rtnl_unlock();
+	nbl_common_queue_work(&net_resource_mgt->rx_mode_async, false);
+
+	return 0;
+}
+
+static int nbl_serv_switch_traffic_default_dest(void *priv, int op)
+{
+	struct nbl_service_mgt *serv_mgt = (struct nbl_service_mgt *)priv;
+
+	if (op == NBL_DEV_KERNEL_TO_USER)
+		nbl_serv_suspend_data_vsi_traffic(serv_mgt);
+	else if (op == NBL_DEV_USER_TO_KERNEL)
+		nbl_serv_restore_vsi_traffic(serv_mgt);
+
+	return 0;
+}
+
 static int nbl_serv_abnormal_event_to_queue(int event_type)
 {
 	switch (event_type) {
@@ -4655,6 +4714,8 @@ static struct nbl_service_ops serv_ops = {
 
 	.vsi_open = nbl_serv_vsi_open,
 	.vsi_stop = nbl_serv_vsi_stop,
+	.switch_traffic_default_dest = nbl_serv_switch_traffic_default_dest,
+
 	/* For netdev ops */
 	.netdev_open = nbl_serv_netdev_open,
 	.netdev_stop = nbl_serv_netdev_stop,
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
index 4e441e0c2b17..1ef36f2c02da 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_channel.h
@@ -763,6 +763,9 @@ struct nbl_channel_ops {
 	int (*cfg_chan_qinfo_map_table)(void *priv, u8 chan_type);
 	bool (*check_queue_exist)(void *priv, u8 chan_type);
 	int (*setup_queue)(void *priv, u8 chan_type);
+	int (*set_listener_info)(void *priv, void *shm_ring, struct eventfd_ctx *eventfd);
+	int (*set_listener_msgtype)(void *priv, int msgtype);
+	void (*clear_listener_info)(void *priv);
 	int (*teardown_queue)(void *priv, u8 chan_type);
 	void (*clean_queue_subtask)(void *priv, u8 chan_type);
 	int (*setup_keepalive)(void *priv, u16 dest_id, u8 chan_type);
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
index cf6570b9a246..7e4ffb38df75 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_common.h
@@ -477,6 +477,9 @@ void nbl_common_flush_task(struct work_struct *task);
 
 void nbl_common_destroy_wq(void);
 int nbl_common_create_wq(void);
+
+bool nbl_dma_iommu_status(struct pci_dev *pdev);
+bool nbl_dma_remap_status(struct pci_dev *pdev, u64 *dma_limit);
 u32 nbl_common_pf_id_subtraction_mgtpf_id(struct nbl_common_info *common, u32 pf_id);
 void *nbl_common_init_index_table(struct nbl_index_tbl_key *key);
 void nbl_common_remove_index_table(void *priv, struct nbl_index_tbl_del_key *key);
@@ -489,6 +492,11 @@ int nbl_common_alloc_index(void *priv, void *key, struct nbl_index_key_extra *ex
 void nbl_common_free_index(void *priv, void *key);
 int nbl_common_find_available_idx(unsigned long *addr, u32 size, u32 idx_num, u32 multiple);
 
+enum nbl_dev_mode_switch_op {
+	NBL_DEV_KERNEL_TO_USER,
+	NBL_DEV_USER_TO_KERNEL,
+};
+
 void *nbl_common_init_hash_table(struct nbl_hash_tbl_key *key);
 void nbl_common_remove_hash_table(void *priv, struct nbl_hash_tbl_del_key *key);
 int nbl_common_alloc_hash_node(void *priv, void *key, void *data, void **out_data);
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
index eeade2432e66..4bf6f4aec3cd 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_dev.h
@@ -25,6 +25,9 @@ void nbl_dev_remove(void *p);
 int nbl_dev_start(void *p, struct nbl_init_param *param);
 void nbl_dev_stop(void *p);
 
+void nbl_dev_user_module_init(void);
+void nbl_dev_user_module_destroy(void);
+
 int nbl_dev_setup_vf_config(void *p, int num_vfs);
 void nbl_dev_remove_vf_config(void *p);
 void nbl_dev_register_dev_name(void *p);
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h
index 07b5e36fc1ec..7767826d5355 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_service.h
@@ -38,6 +38,7 @@ struct nbl_service_ops {
 	int (*vsi_open)(void *priv, struct net_device *netdev, u16 vsi_index,
 			u16 real_qps, bool use_napi);
 	int (*vsi_stop)(void *priv, u16 vsi_index);
+	int (*switch_traffic_default_dest)(void *priv, int op);
 
 	int (*netdev_open)(struct net_device *netdev);
 	int (*netdev_stop)(struct net_device *netdev);
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index f331cf1471a7..fafc9ab91f13 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -32,6 +32,11 @@
 #include <linux/if_bridge.h>
 #include <linux/rtnetlink.h>
 #include <linux/pci.h>
+#include <linux/dma-map-ops.h>
+#include <linux/dma-mapping.h>
+#include <linux/iommu.h>
+#include <linux/mdev.h>
+#include <linux/vfio.h>
 /*  ------  Basic definitions  -------  */
 #define NBL_DRIVER_NAME					"nbl_core"
 #define NBL_DRIVER_VERSION				"25.11-1.16"
@@ -57,6 +62,10 @@
 
 #define SET_DEV_MIN_MTU(netdev, mtu) ((netdev)->min_mtu = (mtu))
 #define SET_DEV_MAX_MTU(netdev, mtu) ((netdev)->max_mtu = (mtu))
+
+#define NBL_USER_DEV_SHMMSGRING_SIZE		(PAGE_SIZE)
+#define NBL_USER_DEV_SHMMSGBUF_SIZE		(NBL_USER_DEV_SHMMSGRING_SIZE - 8)
+
 /* Used for macros to pass checkpatch */
 #define NBL_NAME(x)					x
 
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
index f3fc67dbaa67..aa48cae7f5cf 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
@@ -436,6 +436,7 @@ static int __init nbl_module_init(void)
 {
 	int status;
 
+	nbl_dev_user_module_init();
 	status = nbl_common_create_wq();
 	if (status) {
 		pr_err("Failed to create wq, err = %d\n", status);
@@ -454,6 +455,7 @@ static int __init nbl_module_init(void)
 pci_register_driver_failed:
 	nbl_common_destroy_wq();
 wq_create_failed:
+	nbl_dev_user_module_destroy();
 	return status;
 }
 
@@ -465,6 +467,7 @@ static void __exit nbl_module_exit(void)
 
 	nbl_common_destroy_wq();
 
+	nbl_dev_user_module_destroy();
 	pr_info("nbl module unloaded\n");
 }
 
-- 
2.43.0


