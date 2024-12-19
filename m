Return-Path: <netdev+bounces-153270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 268FA9F7800
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 10:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 894C57A1FFE
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 09:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DC4221DA8;
	Thu, 19 Dec 2024 09:09:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5C6149DF4;
	Thu, 19 Dec 2024 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734599349; cv=none; b=DjvaP2aNhFQjKbJaZMAsHb+vhT0Tt4NE2sVE7FaDikES1eBJH/WEuY/jUIqo3DWc3nFuZLg74gr/jcaxOze+18w8RXQDHElPKqA7gN/BTIfRaE5plJNYN06HKUTwDzLGTbSi2KvUONZ+q46htUO13ALrq25E/xSYMeTrbZx69tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734599349; c=relaxed/simple;
	bh=UHxF4SN++oH5YgK2W2fJNYQAW3v0Z7LJ+zkUlWV1MNM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WaHSXc+hUgM3enKGvsoe16xeX/QI8cUrtfSjonKjqpXnDKAWYCCc3I4WMBbfekx/m8PVix1QKiLkfGEqETemRsKyfsWvVqnFUVP4EMa6uU9lTYfp4Z9NwFS3nty/y/KxLFcRtQggOnZM2xJGQIRSyODk5Ec9CooqlYOGvQY2kyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YDPqZ0STyz6K6f8;
	Thu, 19 Dec 2024 17:08:58 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 1EC02140B55;
	Thu, 19 Dec 2024 17:09:01 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 19 Dec
 2024 10:08:50 +0100
From: Gur Stavi <gur.stavi@huawei.com>
To: Gur Stavi <gur.stavi@huawei.com>, gongfan <gongfan1@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas
	<helgaas@kernel.org>, Cai Huoqing <cai.huoqing@linux.dev>, Xin Guo
	<guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>
Subject: [PATCH net-next v01 1/1] hinic3: module initialization and tx/rx logic
Date: Thu, 19 Dec 2024 11:21:55 +0200
Message-ID: <161ef27561c90b8522bd66e4b278ef8d7496f60b.1734599672.git.gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1734599672.git.gur.stavi@huawei.com>
References: <cover.1734599672.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 frapeml500005.china.huawei.com (7.182.85.13)

From: gongfan <gongfan1@huawei.com>

This is [1/3] part of hinic3 Ethernet driver initial submission.
With this patch hinic3 is a valid kernel module but non-functional
driver.

The driver parts contained in this patch:
Module initialization.
PCI driver registration but with empty id_table.
Auxiliary driver registration.
Net device_ops registration but open/stop are empty stubs.
tx/rx logic.

All major data structures of the driver are fully introduced with the
code that uses them but without their initialization code that requires
management interface with the hw.

Submitted-by: Gur Stavi <gur.stavi@huawei.com>
Signed-off-by: Gur Stavi <gur.stavi@huawei.com>
Signed-off-by: Xin Guo <guoxin09@huawei.com>
Signed-off-by: gongfan <gongfan1@huawei.com>
---
 .../device_drivers/ethernet/huawei/hinic3.rst | 137 ++++
 MAINTAINERS                                   |   7 +
 drivers/net/ethernet/huawei/Kconfig           |   1 +
 drivers/net/ethernet/huawei/Makefile          |   1 +
 drivers/net/ethernet/huawei/hinic3/Kconfig    |  16 +
 drivers/net/ethernet/huawei/hinic3/Makefile   |  21 +
 .../ethernet/huawei/hinic3/hinic3_common.c    |  53 ++
 .../ethernet/huawei/hinic3/hinic3_common.h    |  27 +
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.c    |  30 +
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.h    |  58 ++
 .../ethernet/huawei/hinic3/hinic3_hw_comm.c   |  37 +
 .../ethernet/huawei/hinic3/hinic3_hw_comm.h   |  13 +
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   |  85 +++
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.c |  24 +
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.h |  82 +++
 .../net/ethernet/huawei/hinic3/hinic3_hwif.c  |  15 +
 .../net/ethernet/huawei/hinic3/hinic3_hwif.h  |  50 ++
 .../net/ethernet/huawei/hinic3/hinic3_lld.c   | 410 +++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_lld.h   |  20 +
 .../net/ethernet/huawei/hinic3/hinic3_main.c  | 415 +++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_mbox.c  |  17 +
 .../net/ethernet/huawei/hinic3/hinic3_mbox.h  |  16 +
 .../net/ethernet/huawei/hinic3/hinic3_mgmt.h  |  13 +
 .../huawei/hinic3/hinic3_mgmt_interface.h     | 111 +++
 .../huawei/hinic3/hinic3_netdev_ops.c         |  77 ++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   | 254 +++++++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |  45 ++
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   | 100 +++
 .../ethernet/huawei/hinic3/hinic3_nic_io.c    |  21 +
 .../ethernet/huawei/hinic3/hinic3_nic_io.h    | 117 +++
 .../huawei/hinic3/hinic3_queue_common.c       |  65 ++
 .../huawei/hinic3/hinic3_queue_common.h       |  51 ++
 .../net/ethernet/huawei/hinic3/hinic3_rss.c   |  24 +
 .../net/ethernet/huawei/hinic3/hinic3_rss.h   |  12 +
 .../net/ethernet/huawei/hinic3/hinic3_rx.c    | 401 ++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_rx.h    |  91 +++
 .../net/ethernet/huawei/hinic3/hinic3_tx.c    | 691 ++++++++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_tx.h    | 129 ++++
 .../net/ethernet/huawei/hinic3/hinic3_wq.c    |  29 +
 .../net/ethernet/huawei/hinic3/hinic3_wq.h    |  75 ++
 40 files changed, 3841 insertions(+)

diff --git a/Documentation/networking/device_drivers/ethernet/huawei/hinic3.rst b/Documentation/networking/device_drivers/ethernet/huawei/hinic3.rst
new file mode 100644
index 000000000000..fe4bd0aed85c
--- /dev/null
+++ b/Documentation/networking/device_drivers/ethernet/huawei/hinic3.rst
@@ -0,0 +1,137 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================================================================
+Linux kernel driver for Huawei Ethernet Device Driver (hinic3) family
+=====================================================================
+
+Overview
+========
+
+The hinic3 is a network interface card (NIC) for Data Center. It supports
+a range of link-speed devices (10GE, 25GE, 100GE, etc.). The hinic3
+devices can have multiple physical forms (LOM NIC, PCIe standard NIC,
+OCP NIC etc.).
+
+The hinic3 driver supports the following features:
+- IPv4/IPv6 TCP/UDP checksum offload
+- TSO (TCP Segmentation Offload), LRO (Large Receive Offload)
+- RSS (Receive Side Scaling)
+- MSI-X interrupt aggregation configuration and interrupt adaptation.
+- SR-IOV (Single Root I/O Virtualization).
+
+Content
+=======
+
+- Supported PCI vendor ID/device IDs
+- Source Code Structure of Hinic3 Driver
+- Management Interface
+
+Supported PCI vendor ID/device IDs
+==================================
+
+19e5:0222 - hinic3 PF/PPF
+19e5:375F - hinic3 VF
+
+Prime Physical Function (PPF) is responsible for the management of the
+whole NIC card. For example, clock synchronization between the NIC and
+the host. Any PF may serve as a PPF. The PPF is selected dynamically.
+
+Source Code Structure of Hinic3 Driver
+======================================
+
+========================  ================================================
+hinic3_pci_id_tbl.h       Supported device IDs
+hinic3_hw_intf.h          Interface between HW and driver
+hinic3_queue_common.[ch]  Common structures and methods for NIC queues
+hinic3_common.[ch]        Encapsulation of memory operations in Linux
+hinic3_csr.h              Register definitions in the BAR
+hinic3_hwif.[ch]          Interface for BAR
+hinic3_eqs.[ch]           Interface for AEQs and CEQs
+hinic3_mbox.[ch]          Interface for mailbox
+hinic3_mgmt.[ch]          Management interface based on mailbox and AEQ
+hinic3_wq.[ch]            Work queue data structures and interface
+hinic3_cmdq.[ch]          Command queue is used to post command to HW
+hinic3_hwdev.[ch]         HW structures and methods abstractions
+hinic3_lld.[ch]           Auxiliary driver adaptation layer
+hinic3_hw_comm.[ch]       Interface for common HW operations
+hinic3_mgmt_interface.h   Interface between firmware and driver
+hinic3_hw_cfg.[ch]        Interface for HW configuration
+hinic3_irq.c              Interrupt request
+hinic3_netdev_ops.c       Operations registered to Linux kernel stack
+hinic3_nic_dev.h          NIC structures and methods abstractions
+hinic3_main.c             Main Linux kernel driver
+hinic3_nic_cfg.[ch]       NIC service configuration
+hinic3_nic_io.[ch]        Management plane interface for TX and RX
+hinic3_rss.[ch]           Interface for Receive Side Scaling (RSS)
+hinic3_rx.[ch]            Interface for transmit
+hinic3_tx.[ch]            Interface for receive
+hinic3_ethtool.c          Interface for ethtool operations (ops)
+hinic3_filter.c           Interface for MAC address
+========================  ================================================
+
+Management Interface
+====================
+
+Asynchronous Event Queue (AEQ)
+------------------------------
+
+AEQ receives high priority events from the HW over a descriptor queue.
+Every descriptor is a fixed size of 64 bytes. AEQ can receive solicited or
+unsolicited events. Every device, VF or PF, can have up to 4 AEQs.
+Every AEQ is associated to a dedicated IRQ. AEQ can receive multiple types
+of events, but in practice the hinic3 driver ignores all events except for
+2 mailbox related events.
+
+Mailbox
+-------
+
+Mailbox is a communication mechanism between the hinic3 driver and the HW.
+Each device has an independent mailbox. Driver can use the mailbox to send
+requests to management. Driver receives mailbox messages, such as responses
+to requests, over the AEQ (using event HINIC3_AEQ_FOR_MBOX). Due to the
+limited size of mailbox data register, mailbox messages are sent
+segment-by-segment.
+
+Every device can use its mailbox to post request to firmware. The mailbox
+can also be used to post requests and responses between the PF and its VFs.
+
+Completion Event Queue (CEQ)
+--------------------------
+
+The implementation of CEQ is the same as AEQ. It receives completion events
+from HW over a fixed size descriptor of 32 bits. Every device can have up
+to 32 CEQs. Every CEQ has a dedicated IRQ. CEQ only receives solicited
+events that are responses to requests from the driver. CEQ can receive
+multiple types of events, but in practice the hinic3 driver ignores all
+events except for HINIC3_CMDQ that represents completion of previously
+posted commands on a cmdq.
+
+Command Queue (cmdq)
+--------------------
+
+Every cmdq has a dedicated work queue on which commands are posted.
+Commands on the work queue are fixed size descriptor of size 64 bytes.
+Completion of a command will be indicated using ctrl bits in the
+descriptor that carried the command. Notification of command completions
+will also be provided via event on CEQ. Every device has 4 command queues
+that are initialized as a set (called cmdqs), each with its own type.
+Hinic3 driver only uses type HINIC3_CMDQ_SYNC.
+
+Work Queues(WQ)
+---------------
+
+Work queues are logical arrays of fixed size WQEs. The array may be spread
+over multiple non-contiguous pages using indirection table. Work queues are
+used by I/O queues and command queues.
+
+Global function ID
+------------------
+
+Every function, PF or VF, has a unique ordinal identification within the device.
+Many commands to management (mbox or cmdq) contain this ID so HW can apply the
+command effect to the right function.
+
+PF is allowed to post management commands to a subordinate VF by specifying the
+VFs ID. A VF must provide its own ID. Anti-spoofing in the HW will cause
+command from a VF to fail if it contains the wrong ID.
+
diff --git a/MAINTAINERS b/MAINTAINERS
index af35519be320..64555a934d6b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10600,6 +10600,13 @@ S:	Maintained
 F:	Documentation/networking/device_drivers/ethernet/huawei/hinic.rst
 F:	drivers/net/ethernet/huawei/hinic/
 
+HUAWEI 3RD GEN ETHERNET DRIVER
+M:	gongfan <gongfan1@huawei.com>
+L:	netdev@vger.kernel.org
+S:	Supported
+F:	Documentation/networking/device_drivers/ethernet/huawei/hinic3.rst
+F:	drivers/net/ethernet/huawei/hinic3/
+
 HUGETLB SUBSYSTEM
 M:	Muchun Song <muchun.song@linux.dev>
 L:	linux-mm@kvack.org
diff --git a/drivers/net/ethernet/huawei/Kconfig b/drivers/net/ethernet/huawei/Kconfig
index c05fce15eb51..7d0feb1da158 100644
--- a/drivers/net/ethernet/huawei/Kconfig
+++ b/drivers/net/ethernet/huawei/Kconfig
@@ -16,5 +16,6 @@ config NET_VENDOR_HUAWEI
 if NET_VENDOR_HUAWEI
 
 source "drivers/net/ethernet/huawei/hinic/Kconfig"
+source "drivers/net/ethernet/huawei/hinic3/Kconfig"
 
 endif # NET_VENDOR_HUAWEI
diff --git a/drivers/net/ethernet/huawei/Makefile b/drivers/net/ethernet/huawei/Makefile
index 2549ad5afe6d..59865b882879 100644
--- a/drivers/net/ethernet/huawei/Makefile
+++ b/drivers/net/ethernet/huawei/Makefile
@@ -4,3 +4,4 @@
 #
 
 obj-$(CONFIG_HINIC) += hinic/
+obj-$(CONFIG_HINIC3) += hinic3/
diff --git a/drivers/net/ethernet/huawei/hinic3/Kconfig b/drivers/net/ethernet/huawei/hinic3/Kconfig
new file mode 100644
index 000000000000..5ab5c460bbc6
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Huawei driver configuration
+#
+
+config HINIC3
+	tristate "Huawei Intelligent Network Interface Card 3rd"
+	# Fields of HW and management structures are little endian and will not
+	# be explicitly converted
+	depends on 64BIT && !CPU_BIG_ENDIAN
+	depends on PCI_MSI && (X86 || ARM64)
+	help
+	  This driver supports HiNIC PCIE Ethernet cards.
+	  To compile this driver as part of the kernel, choose Y here.
+	  If unsure, choose N.
+	  The default is N.
diff --git a/drivers/net/ethernet/huawei/hinic3/Makefile b/drivers/net/ethernet/huawei/hinic3/Makefile
new file mode 100644
index 000000000000..02656853f629
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/Makefile
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+obj-$(CONFIG_HINIC3) += hinic3.o
+
+hinic3-objs := hinic3_hwdev.o \
+	       hinic3_lld.o \
+	       hinic3_common.o \
+	       hinic3_hwif.o \
+	       hinic3_hw_cfg.o \
+	       hinic3_queue_common.o \
+	       hinic3_mbox.o \
+	       hinic3_hw_comm.o \
+	       hinic3_wq.o \
+	       hinic3_nic_io.o \
+	       hinic3_nic_cfg.o \
+	       hinic3_tx.o \
+	       hinic3_rx.o \
+	       hinic3_netdev_ops.o \
+	       hinic3_rss.o \
+	       hinic3_main.o
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_common.c b/drivers/net/ethernet/huawei/hinic3/hinic3_common.c
new file mode 100644
index 000000000000..d416a6a00a8b
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_common.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/dma-mapping.h>
+#include <linux/delay.h>
+
+#include "hinic3_common.h"
+
+int hinic3_dma_zalloc_coherent_align(struct device *dev, u32 size, u32 align,
+				     gfp_t flag,
+				     struct hinic3_dma_addr_align *mem_align)
+{
+	dma_addr_t paddr, align_paddr;
+	void *vaddr, *align_vaddr;
+	u32 real_size = size;
+
+	vaddr = dma_alloc_coherent(dev, real_size, &paddr, flag);
+	if (!vaddr)
+		return -ENOMEM;
+
+	align_paddr = ALIGN(paddr, align);
+	if (align_paddr == paddr) {
+		align_vaddr = vaddr;
+		goto out;
+	}
+
+	dma_free_coherent(dev, real_size, vaddr, paddr);
+
+	/* realloc memory for align */
+	real_size = size + align;
+	vaddr = dma_alloc_coherent(dev, real_size, &paddr, flag);
+	if (!vaddr)
+		return -ENOMEM;
+
+	align_paddr = ALIGN(paddr, align);
+	align_vaddr = vaddr + (align_paddr - paddr);
+
+out:
+	mem_align->real_size = real_size;
+	mem_align->ori_vaddr = vaddr;
+	mem_align->ori_paddr = paddr;
+	mem_align->align_vaddr = align_vaddr;
+	mem_align->align_paddr = align_paddr;
+
+	return 0;
+}
+
+void hinic3_dma_free_coherent_align(struct device *dev,
+				    struct hinic3_dma_addr_align *mem_align)
+{
+	dma_free_coherent(dev, mem_align->real_size,
+			  mem_align->ori_vaddr, mem_align->ori_paddr);
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_common.h b/drivers/net/ethernet/huawei/hinic3/hinic3_common.h
new file mode 100644
index 000000000000..f8ff768c20ca
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_common.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_COMMON_H
+#define HINIC3_COMMON_H
+
+#include <linux/device.h>
+
+#define HINIC3_MIN_PAGE_SIZE  0x1000
+
+struct hinic3_dma_addr_align {
+	u32        real_size;
+
+	void       *ori_vaddr;
+	dma_addr_t ori_paddr;
+
+	void       *align_vaddr;
+	dma_addr_t align_paddr;
+};
+
+int hinic3_dma_zalloc_coherent_align(struct device *dev, u32 size, u32 align,
+				     gfp_t flag,
+				     struct hinic3_dma_addr_align *mem_align);
+void hinic3_dma_free_coherent_align(struct device *dev,
+				    struct hinic3_dma_addr_align *mem_align);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
new file mode 100644
index 000000000000..be1bc3f47c08
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/device.h>
+
+#include "hinic3_hw_cfg.h"
+#include "hinic3_hwdev.h"
+#include "hinic3_mbox.h"
+#include "hinic3_hwif.h"
+
+#define IS_NIC_TYPE(hwdev) \
+	(((u32)(hwdev)->cfg_mgmt->svc_cap.chip_svc_type) & BIT(SERVICE_T_NIC))
+
+bool hinic3_support_nic(struct hinic3_hwdev *hwdev)
+{
+	if (!IS_NIC_TYPE(hwdev))
+		return false;
+
+	return true;
+}
+
+u16 hinic3_func_max_qnum(struct hinic3_hwdev *hwdev)
+{
+	return hwdev->cfg_mgmt->svc_cap.nic_cap.max_sqs;
+}
+
+u8 hinic3_physical_port_id(struct hinic3_hwdev *hwdev)
+{
+	return hwdev->cfg_mgmt->svc_cap.port_id;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h
new file mode 100644
index 000000000000..cef311b8f642
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_HW_CFG_H
+#define HINIC3_HW_CFG_H
+
+#include <linux/mutex.h>
+
+struct hinic3_hwdev;
+
+struct irq_info {
+	u16 msix_entry_idx;
+	/* provided by OS */
+	u32 irq_id;
+};
+
+struct cfg_irq_alloc_info {
+	bool                     allocated;
+	struct irq_info          info;
+};
+
+struct cfg_irq_info {
+	struct cfg_irq_alloc_info *alloc_info;
+	u16                       num_irq;
+	/* device max irq number */
+	u16                       num_irq_hw;
+	/* protect irq alloc and free */
+	struct mutex              irq_mutex;
+};
+
+struct nic_service_cap {
+	u16 max_sqs;
+};
+
+/* device capability */
+struct service_cap {
+	/* HW supported service type, reference to service_bit_define */
+	u16                    chip_svc_type;
+	/* physical port */
+	u8                     port_id;
+	/* NIC capability */
+	struct nic_service_cap nic_cap;
+};
+
+struct cfg_mgmt_info {
+	struct cfg_irq_info irq_info;
+	struct service_cap  svc_cap;
+};
+
+int hinic3_alloc_irqs(struct hinic3_hwdev *hwdev, u16 num,
+		      struct irq_info *alloc_arr, u16 *act_num);
+void hinic3_free_irq(struct hinic3_hwdev *hwdev, u32 irq_id);
+
+bool hinic3_support_nic(struct hinic3_hwdev *hwdev);
+u16 hinic3_func_max_qnum(struct hinic3_hwdev *hwdev);
+u8 hinic3_physical_port_id(struct hinic3_hwdev *hwdev);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
new file mode 100644
index 000000000000..fc2efcfd22a1
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/delay.h>
+
+#include "hinic3_hw_comm.h"
+#include "hinic3_hwdev.h"
+#include "hinic3_mbox.h"
+#include "hinic3_hwif.h"
+
+static int comm_msg_to_mgmt_sync(struct hinic3_hwdev *hwdev, u16 cmd, const void *buf_in,
+				 u32 in_size, void *buf_out, u32 *out_size)
+{
+	return hinic3_send_mbox_to_mgmt(hwdev, HINIC3_MOD_COMM, cmd, buf_in,
+					in_size, buf_out, out_size, 0);
+}
+
+int hinic3_func_reset(struct hinic3_hwdev *hwdev, u16 func_id, u64 reset_flag)
+{
+	struct comm_cmd_func_reset func_reset;
+	u32 out_size = sizeof(func_reset);
+	int err;
+
+	memset(&func_reset, 0, sizeof(func_reset));
+	func_reset.func_id = func_id;
+	func_reset.reset_flag = reset_flag;
+	err = comm_msg_to_mgmt_sync(hwdev, COMM_MGMT_CMD_FUNC_RESET,
+				    &func_reset, sizeof(func_reset),
+				    &func_reset, &out_size);
+	if (err || !out_size || func_reset.head.status) {
+		dev_err(hwdev->dev, "Failed to reset func resources, reset_flag 0x%llx, err: %d, status: 0x%x, out_size: 0x%x\n",
+			reset_flag, err, func_reset.head.status, out_size);
+		return -EIO;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
new file mode 100644
index 000000000000..cb60d7d7826d
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_HW_COMM_H
+#define HINIC3_HW_COMM_H
+
+#include "hinic3_hw_intf.h"
+
+struct hinic3_hwdev;
+
+int hinic3_func_reset(struct hinic3_hwdev *hwdev, u16 func_id, u64 reset_flag);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
new file mode 100644
index 000000000000..5c2f8383bcbb
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_HW_INTF_H
+#define HINIC3_HW_INTF_H
+
+#include <linux/types.h>
+#include <linux/bits.h>
+
+#define MGMT_CMD_UNSUPPORTED  0xFF
+
+struct mgmt_msg_head {
+	u8 status;
+	u8 version;
+	u8 rsvd0[6];
+};
+
+enum hinic3_service_type {
+	SERVICE_T_NIC = 0,
+	SERVICE_T_MAX = 1,
+	/* Only used for interruption resource management, mark the request module */
+	SERVICE_T_INTF = (1 << 15),
+};
+
+/* CMDQ MODULE_TYPE */
+enum hinic3_mod_type {
+	/* HW communication module */
+	HINIC3_MOD_COMM   = 0,
+	/* L2NIC module */
+	HINIC3_MOD_L2NIC  = 1,
+	/* Configuration module */
+	HINIC3_MOD_CFGM   = 7,
+	HINIC3_MOD_HILINK = 14,
+};
+
+/* COMM Commands between Driver to fw */
+enum hinic3_mgmt_cmd {
+	/* Commands for clearing FLR and resources */
+	COMM_MGMT_CMD_FUNC_RESET              = 0,
+	COMM_MGMT_CMD_FEATURE_NEGO            = 1,
+	COMM_MGMT_CMD_FLUSH_DOORBELL          = 2,
+	COMM_MGMT_CMD_START_FLUSH             = 3,
+	COMM_MGMT_CMD_GET_GLOBAL_ATTR         = 5,
+	COMM_MGMT_CMD_SET_FUNC_SVC_USED_STATE = 7,
+
+	/* Driver Configuration Commands */
+	COMM_MGMT_CMD_SET_CMDQ_CTXT           = 20,
+	COMM_MGMT_CMD_SET_VAT                 = 21,
+	COMM_MGMT_CMD_CFG_PAGESIZE            = 22,
+	COMM_MGMT_CMD_CFG_MSIX_CTRL_REG       = 23,
+	COMM_MGMT_CMD_SET_CEQ_CTRL_REG        = 24,
+	COMM_MGMT_CMD_SET_DMA_ATTR            = 25,
+};
+
+enum func_reset_type_bits {
+	RESET_TYPE_FLUSH        = BIT(0),
+	RESET_TYPE_MQM          = BIT(1),
+	RESET_TYPE_SMF          = BIT(2),
+	RESET_TYPE_PF_BW_CFG    = BIT(3),
+
+	RESET_TYPE_COMM         = BIT(10),
+	/* clear mbox and aeq, The RESET_TYPE_COMM bit must be set */
+	RESET_TYPE_COMM_MGMT_CH = BIT(11),
+	/* clear cmdq and ceq, The RESET_TYPE_COMM bit must be set */
+	RESET_TYPE_COMM_CMD_CH  = BIT(12),
+	RESET_TYPE_NIC          = BIT(13),
+};
+
+struct comm_cmd_func_reset {
+	struct mgmt_msg_head head;
+	u16                  func_id;
+	u16                  rsvd1[3];
+	u64                  reset_flag;
+};
+
+#define COMM_MAX_FEATURE_QWORD  4
+struct comm_cmd_feature_nego {
+	struct mgmt_msg_head head;
+	u16                  func_id;
+	u8                   opcode;
+	u8                   rsvd;
+	u64                  s_feature[COMM_MAX_FEATURE_QWORD];
+};
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
new file mode 100644
index 000000000000..014fe4eeed5c
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include "hinic3_hwdev.h"
+#include "hinic3_mbox.h"
+#include "hinic3_mgmt.h"
+#include "hinic3_hw_comm.h"
+#include "hinic3_hwif.h"
+
+int hinic3_init_hwdev(struct pci_dev *pdev)
+{
+	/* Completed by later submission due to LoC limit. */
+	return -EFAULT;
+}
+
+void hinic3_free_hwdev(struct hinic3_hwdev *hwdev)
+{
+	/* Completed by later submission due to LoC limit. */
+}
+
+void hinic3_set_api_stop(struct hinic3_hwdev *hwdev)
+{
+	/* Completed by later submission due to LoC limit. */
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
new file mode 100644
index 000000000000..a1b094785d45
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_HWDEV_H
+#define HINIC3_HWDEV_H
+
+#include <linux/pci.h>
+#include <linux/auxiliary_bus.h>
+
+#include "hinic3_hw_intf.h"
+
+struct hinic3_cmdqs;
+struct hinic3_hwif;
+
+enum hinic3_event_service_type {
+	EVENT_SRV_COMM = 0,
+#define SERVICE_EVENT_BASE    (EVENT_SRV_COMM + 1)
+	EVENT_SRV_NIC  = SERVICE_EVENT_BASE + SERVICE_T_NIC,
+};
+
+#define HINIC3_SRV_EVENT_TYPE(svc, type)    ((((u32)(svc)) << 16) | (type))
+
+/* driver-specific data of pci_dev */
+struct hinic3_pcidev {
+	struct pci_dev       *pdev;
+	struct hinic3_hwdev  *hwdev;
+	/* Auxiliary devices */
+	struct hinic3_adev   *hadev[SERVICE_T_MAX];
+
+	void __iomem         *cfg_reg_base;
+	void __iomem         *intr_reg_base;
+	void __iomem         *db_base;
+	u64                  db_dwqe_len;
+	u64                  db_base_phy;
+
+	/* lock for attach/detach uld */
+	struct mutex         pdev_mutex;
+	unsigned long        state;
+};
+
+struct hinic3_hwdev {
+	struct hinic3_pcidev           *adapter;
+	struct pci_dev                 *pdev;
+	struct device                  *dev;
+	int                            dev_id;
+	struct hinic3_hwif             *hwif;
+	struct cfg_mgmt_info           *cfg_mgmt;
+	struct hinic3_aeqs             *aeqs;
+	struct hinic3_ceqs             *ceqs;
+	struct hinic3_mbox             *mbox;
+	struct hinic3_cmdqs            *cmdqs;
+	struct workqueue_struct        *workq;
+	/* protect channel init and deinit */
+	spinlock_t                     channel_lock;
+	u64                            features[COMM_MAX_FEATURE_QWORD];
+	u32                            wq_page_size;
+	u8                             max_cmdq;
+	ulong                          func_state;
+};
+
+struct hinic3_event_info {
+	/* enum hinic3_event_service_type */
+	u16 service;
+	u16 type;
+	u8  event_data[104];
+};
+
+struct hinic3_adev {
+	struct auxiliary_device  adev;
+	struct hinic3_hwdev      *hwdev;
+	enum hinic3_service_type svc_type;
+
+	void (*event)(struct auxiliary_device *adev,
+		      struct hinic3_event_info *event);
+};
+
+int hinic3_init_hwdev(struct pci_dev *pdev);
+void hinic3_free_hwdev(struct hinic3_hwdev *hwdev);
+
+void hinic3_set_api_stop(struct hinic3_hwdev *hwdev);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
new file mode 100644
index 000000000000..4e12670a9440
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/bitfield.h>
+
+#include "hinic3_hwdev.h"
+#include "hinic3_common.h"
+#include "hinic3_hwif.h"
+
+u16 hinic3_global_func_id(struct hinic3_hwdev *hwdev)
+{
+	return hwdev->hwif->attr.func_global_idx;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
new file mode 100644
index 000000000000..da502c4b6efb
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_HWIF_H
+#define HINIC3_HWIF_H
+
+#include <linux/spinlock_types.h>
+#include <linux/build_bug.h>
+
+struct hinic3_hwdev;
+
+enum func_type {
+	TYPE_VF = 1,
+};
+
+struct hinic3_db_area {
+	unsigned long *db_bitmap_array;
+	u32           db_max_areas;
+	/* protect doorbell area alloc and free */
+	spinlock_t    idx_lock;
+};
+
+struct hinic3_func_attr {
+	enum func_type func_type;
+	u16            func_global_idx;
+	u16            global_vf_id_of_pf;
+	u16            num_irqs;
+	u16            num_sq;
+	u8             port_to_port_idx;
+	u8             pci_intf_idx;
+	u8             ppf_idx;
+	u8             num_aeqs;
+	u8             num_ceqs;
+	u8             msix_flex_en;
+};
+
+static_assert(sizeof(struct hinic3_func_attr) == 20);
+
+struct hinic3_hwif {
+	u8 __iomem              *cfg_regs_base;
+	u64                     db_base_phy;
+	u64                     db_dwqe_len;
+	u8 __iomem              *db_base;
+	struct hinic3_db_area   db_area;
+	struct hinic3_func_attr attr;
+};
+
+u16 hinic3_global_func_id(struct hinic3_hwdev *hwdev);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
new file mode 100644
index 000000000000..604f7891b97b
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c
@@ -0,0 +1,410 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+
+#include "hinic3_lld.h"
+#include "hinic3_hwdev.h"
+#include "hinic3_hw_cfg.h"
+#include "hinic3_mgmt.h"
+
+#define HINIC3_VF_PCI_CFG_REG_BAR  0
+#define HINIC3_PCI_INTR_REG_BAR    2
+#define HINIC3_PCI_DB_BAR          4
+
+#define HINIC3_EVENT_POLL_SLEEP_US   1000
+#define HINIC3_EVENT_POLL_TIMEOUT_US 10000000
+
+static struct hinic3_adev_device {
+	const char *name;
+} hinic3_adev_devices[SERVICE_T_MAX] = {
+	[SERVICE_T_NIC] = {
+		.name = "nic",
+	},
+};
+
+static bool hinic3_adev_svc_supported(struct hinic3_hwdev *hwdev,
+				      enum hinic3_service_type svc_type)
+{
+	switch (svc_type) {
+	case SERVICE_T_NIC:
+		return hinic3_support_nic(hwdev);
+	default:
+		break;
+	}
+
+	return false;
+}
+
+static void hinic3_comm_adev_release(struct device *dev)
+{
+	struct hinic3_adev *hadev = container_of(dev, struct hinic3_adev, adev.dev);
+
+	kfree(hadev);
+}
+
+static struct hinic3_adev *hinic3_add_one_adev(struct hinic3_hwdev *hwdev,
+					       enum hinic3_service_type svc_type)
+{
+	struct hinic3_adev *hadev;
+	const char *svc_name;
+	int ret;
+
+	hadev = kzalloc(sizeof(*hadev), GFP_KERNEL);
+	if (!hadev)
+		return NULL;
+
+	svc_name = hinic3_adev_devices[svc_type].name;
+	hadev->adev.name = svc_name;
+	hadev->adev.id = hwdev->dev_id;
+	hadev->adev.dev.parent = hwdev->dev;
+	hadev->adev.dev.release = hinic3_comm_adev_release;
+	hadev->svc_type = svc_type;
+	hadev->hwdev = hwdev;
+
+	ret = auxiliary_device_init(&hadev->adev);
+	if (ret) {
+		dev_err(hwdev->dev, "failed init adev %s %u\n",
+			svc_name, hwdev->dev_id);
+		kfree(hadev);
+		return NULL;
+	}
+
+	ret = auxiliary_device_add(&hadev->adev);
+	if (ret) {
+		dev_err(hwdev->dev, "failed to add adev %s %u\n",
+			svc_name, hwdev->dev_id);
+		auxiliary_device_uninit(&hadev->adev);
+		return NULL;
+	}
+
+	return hadev;
+}
+
+static void hinic3_del_one_adev(struct hinic3_hwdev *hwdev,
+				enum hinic3_service_type svc_type)
+{
+	struct hinic3_pcidev *pci_adapter = hwdev->adapter;
+	struct hinic3_adev *hadev;
+	int timeout;
+	bool state;
+
+	timeout = read_poll_timeout(test_and_set_bit, state, !state,
+				    HINIC3_EVENT_POLL_SLEEP_US,
+				    HINIC3_EVENT_POLL_TIMEOUT_US,
+				    false, svc_type, &pci_adapter->state);
+
+	hadev = pci_adapter->hadev[svc_type];
+	auxiliary_device_delete(&hadev->adev);
+	auxiliary_device_uninit(&hadev->adev);
+	pci_adapter->hadev[svc_type] = NULL;
+	if (!timeout)
+		clear_bit(svc_type, &pci_adapter->state);
+}
+
+static int hinic3_attach_aux_devices(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_pcidev *pci_adapter = hwdev->adapter;
+	enum hinic3_service_type svc_type;
+
+	mutex_lock(&pci_adapter->pdev_mutex);
+
+	for (svc_type = 0; svc_type < SERVICE_T_MAX; svc_type++) {
+		if (!hinic3_adev_svc_supported(hwdev, svc_type))
+			continue;
+
+		pci_adapter->hadev[svc_type] = hinic3_add_one_adev(hwdev, svc_type);
+		if (!pci_adapter->hadev[svc_type])
+			goto err_add_one_adev;
+	}
+	mutex_unlock(&pci_adapter->pdev_mutex);
+	return 0;
+
+err_add_one_adev:
+	while (svc_type > 0) {
+		svc_type--;
+		if (pci_adapter->hadev[svc_type]) {
+			hinic3_del_one_adev(hwdev, svc_type);
+			pci_adapter->hadev[svc_type] = NULL;
+		}
+	}
+	mutex_unlock(&pci_adapter->pdev_mutex);
+	return -ENOMEM;
+}
+
+static void hinic3_detach_aux_devices(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_pcidev *pci_adapter = hwdev->adapter;
+	int i;
+
+	mutex_lock(&pci_adapter->pdev_mutex);
+	for (i = 0; i < ARRAY_SIZE(hinic3_adev_devices); i++) {
+		if (pci_adapter->hadev[i])
+			hinic3_del_one_adev(hwdev, i);
+	}
+	mutex_unlock(&pci_adapter->pdev_mutex);
+}
+
+struct hinic3_hwdev *adev_get_hwdev(struct auxiliary_device *adev)
+{
+	struct hinic3_adev *hadev;
+
+	hadev = container_of(adev, struct hinic3_adev, adev);
+	return hadev->hwdev;
+}
+
+int hinic3_adev_event_register(struct auxiliary_device *adev,
+			       void (*event_handler)(struct auxiliary_device *adev,
+						     struct hinic3_event_info *event))
+{
+	struct hinic3_adev *hadev;
+
+	hadev = container_of(adev, struct hinic3_adev, adev);
+	hadev->event = event_handler;
+	return 0;
+}
+
+static int mapping_bar(struct pci_dev *pdev,
+		       struct hinic3_pcidev *pci_adapter)
+{
+	pci_adapter->cfg_reg_base = pci_ioremap_bar(pdev,
+						    HINIC3_VF_PCI_CFG_REG_BAR);
+	if (!pci_adapter->cfg_reg_base) {
+		dev_err(&pdev->dev, "Failed to map configuration regs\n");
+		return -ENOMEM;
+	}
+
+	pci_adapter->intr_reg_base = pci_ioremap_bar(pdev,
+						     HINIC3_PCI_INTR_REG_BAR);
+	if (!pci_adapter->intr_reg_base) {
+		dev_err(&pdev->dev, "Failed to map interrupt regs\n");
+		goto err_undo_reg_bar;
+	}
+
+	pci_adapter->db_base_phy = pci_resource_start(pdev, HINIC3_PCI_DB_BAR);
+	pci_adapter->db_dwqe_len = pci_resource_len(pdev, HINIC3_PCI_DB_BAR);
+	pci_adapter->db_base = pci_ioremap_bar(pdev, HINIC3_PCI_DB_BAR);
+	if (!pci_adapter->db_base) {
+		dev_err(&pdev->dev, "Failed to map doorbell regs\n");
+		goto err_undo_intr_bar;
+	}
+
+	return 0;
+
+err_undo_intr_bar:
+	iounmap(pci_adapter->intr_reg_base);
+
+err_undo_reg_bar:
+	iounmap(pci_adapter->cfg_reg_base);
+
+	return -ENOMEM;
+}
+
+static void unmapping_bar(struct hinic3_pcidev *pci_adapter)
+{
+	iounmap(pci_adapter->db_base);
+	iounmap(pci_adapter->intr_reg_base);
+	iounmap(pci_adapter->cfg_reg_base);
+}
+
+static int hinic3_pci_init(struct pci_dev *pdev)
+{
+	struct hinic3_pcidev *pci_adapter;
+	int err;
+
+	pci_adapter = kzalloc(sizeof(*pci_adapter), GFP_KERNEL);
+	if (!pci_adapter)
+		return -ENOMEM;
+
+	pci_adapter->pdev = pdev;
+	mutex_init(&pci_adapter->pdev_mutex);
+
+	pci_set_drvdata(pdev, pci_adapter);
+
+	err = pci_enable_device(pdev);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to enable PCI device\n");
+		goto err_pci_enable;
+	}
+
+	err = pci_request_regions(pdev, HINIC3_NIC_DRV_NAME);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to request regions\n");
+		goto err_pci_regions;
+	}
+
+	pci_set_master(pdev);
+
+	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (err) {
+		dev_warn(&pdev->dev, "Couldn't set 64-bit DMA mask\n");
+		/* try 32 bit DMA mask if 64 bit fails */
+		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+		if (err) {
+			dev_err(&pdev->dev, "Failed to set DMA mask\n");
+			goto err_dma_mask;
+		}
+	}
+
+	return 0;
+
+err_dma_mask:
+	pci_clear_master(pdev);
+	pci_release_regions(pdev);
+
+err_pci_regions:
+	pci_disable_device(pdev);
+
+err_pci_enable:
+	pci_set_drvdata(pdev, NULL);
+	mutex_destroy(&pci_adapter->pdev_mutex);
+	kfree(pci_adapter);
+
+	return err;
+}
+
+static void hinic3_pci_deinit(struct pci_dev *pdev)
+{
+	struct hinic3_pcidev *pci_adapter = pci_get_drvdata(pdev);
+
+	pci_clear_master(pdev);
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+	pci_set_drvdata(pdev, NULL);
+	mutex_destroy(&pci_adapter->pdev_mutex);
+	kfree(pci_adapter);
+}
+
+static int hinic3_func_init(struct pci_dev *pdev, struct hinic3_pcidev *pci_adapter)
+{
+	int err;
+
+	err = hinic3_init_hwdev(pdev);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to initialize hardware device\n");
+		return -EFAULT;
+	}
+
+	err = hinic3_attach_aux_devices(pci_adapter->hwdev);
+	if (err)
+		goto err_attatch_aux_devices;
+
+	return 0;
+
+err_attatch_aux_devices:
+	hinic3_free_hwdev(pci_adapter->hwdev);
+
+	return err;
+}
+
+static void hinic3_func_deinit(struct pci_dev *pdev)
+{
+	struct hinic3_pcidev *pci_adapter = pci_get_drvdata(pdev);
+
+	hinic3_detach_aux_devices(pci_adapter->hwdev);
+	hinic3_free_hwdev(pci_adapter->hwdev);
+}
+
+static int hinic3_probe_func(struct hinic3_pcidev *pci_adapter)
+{
+	struct pci_dev *pdev = pci_adapter->pdev;
+	int err;
+
+	err = mapping_bar(pdev, pci_adapter);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to map bar\n");
+		goto err_map_bar;
+	}
+
+	err = hinic3_func_init(pdev, pci_adapter);
+	if (err)
+		goto err_func_init;
+
+	return 0;
+
+err_func_init:
+	unmapping_bar(pci_adapter);
+
+err_map_bar:
+	dev_err(&pdev->dev, "Pcie device probe function failed\n");
+	return err;
+}
+
+static int hinic3_remove_func(struct hinic3_pcidev *pci_adapter)
+{
+	struct pci_dev *pdev = pci_adapter->pdev;
+
+	hinic3_func_deinit(pdev);
+	unmapping_bar(pci_adapter);
+	return 0;
+}
+
+static int hinic3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct hinic3_pcidev *pci_adapter;
+	int err;
+
+	err = hinic3_pci_init(pdev);
+	if (err)
+		goto out;
+
+	pci_adapter = pci_get_drvdata(pdev);
+	err = hinic3_probe_func(pci_adapter);
+	if (err)
+		goto err_hinic3_probe_func;
+
+	return 0;
+
+err_hinic3_probe_func:
+	hinic3_pci_deinit(pdev);
+
+out:
+	dev_err(&pdev->dev, "Pcie device probe failed\n");
+	return err;
+}
+
+static void hinic3_remove(struct pci_dev *pdev)
+{
+	struct hinic3_pcidev *pci_adapter = pci_get_drvdata(pdev);
+
+	hinic3_remove_func(pci_adapter);
+	hinic3_pci_deinit(pdev);
+}
+
+static const struct pci_device_id hinic3_pci_table[] = {
+	/* Completed by later submission due to LoC limit. */
+	{0, 0}
+
+};
+
+MODULE_DEVICE_TABLE(pci, hinic3_pci_table);
+
+static void hinic3_shutdown(struct pci_dev *pdev)
+{
+	struct hinic3_pcidev *pci_adapter = pci_get_drvdata(pdev);
+
+	pci_disable_device(pdev);
+
+	if (pci_adapter)
+		hinic3_set_api_stop(pci_adapter->hwdev);
+}
+
+static struct pci_driver hinic3_driver = {
+	.name            = HINIC3_NIC_DRV_NAME,
+	.id_table        = hinic3_pci_table,
+	.probe           = hinic3_probe,
+	.remove          = hinic3_remove,
+	.shutdown        = hinic3_shutdown,
+	.sriov_configure = pci_sriov_configure_simple
+};
+
+int hinic3_lld_init(void)
+{
+	return pci_register_driver(&hinic3_driver);
+}
+
+void hinic3_lld_exit(void)
+{
+	pci_unregister_driver(&hinic3_driver);
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_lld.h b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.h
new file mode 100644
index 000000000000..b84b6641af42
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_LLD_H
+#define HINIC3_LLD_H
+
+#include <linux/auxiliary_bus.h>
+
+struct hinic3_event_info;
+
+#define HINIC3_NIC_DRV_NAME "hinic3"
+
+int hinic3_lld_init(void);
+void hinic3_lld_exit(void);
+int hinic3_adev_event_register(struct auxiliary_device *adev,
+			       void (*event_handler)(struct auxiliary_device *adev,
+						     struct hinic3_event_info *event));
+struct hinic3_hwdev *adev_get_hwdev(struct auxiliary_device *adev);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
new file mode 100644
index 000000000000..603fa2afde53
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
@@ -0,0 +1,415 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+
+#include "hinic3_common.h"
+#include "hinic3_hwdev.h"
+#include "hinic3_nic_cfg.h"
+#include "hinic3_tx.h"
+#include "hinic3_rx.h"
+#include "hinic3_lld.h"
+#include "hinic3_nic_dev.h"
+#include "hinic3_nic_io.h"
+#include "hinic3_hw_comm.h"
+#include "hinic3_rss.h"
+#include "hinic3_hwif.h"
+
+#define HINIC3_NIC_DRV_DESC  "Intelligent Network Interface Card Driver"
+
+#define HINIC3_RX_BUFF_LEN           2048
+#define HINIC3_RX_BUFF_NUM_PER_PAGE  2
+#define HINIC3_LRO_REPLENISH_THLD    256
+#define HINIC3_NIC_DEV_WQ_NAME       "hinic3_nic_dev_wq"
+
+#define HINIC3_SQ_DEPTH              1024
+#define HINIC3_RQ_DEPTH              1024
+
+#define HINIC3_DEAULT_TXRX_MSIX_PENDING_LIMIT       2
+#define HINIC3_DEAULT_TXRX_MSIX_COALESC_TIMER_CFG   25
+#define HINIC3_DEAULT_TXRX_MSIX_RESEND_TIMER_CFG    7
+
+static void init_intr_coal_param(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_intr_coal_info *info;
+	u16 i;
+
+	for (i = 0; i < nic_dev->max_qps; i++) {
+		info = &nic_dev->intr_coalesce[i];
+		info->pending_limt = HINIC3_DEAULT_TXRX_MSIX_PENDING_LIMIT;
+		info->coalesce_timer_cfg = HINIC3_DEAULT_TXRX_MSIX_COALESC_TIMER_CFG;
+		info->resend_timer_cfg = HINIC3_DEAULT_TXRX_MSIX_RESEND_TIMER_CFG;
+	}
+}
+
+static int hinic3_init_intr_coalesce(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	u64 size;
+
+	size = sizeof(*nic_dev->intr_coalesce) * nic_dev->max_qps;
+	if (!size) {
+		dev_err(hwdev->dev, "Cannot allocate zero size intr coalesce\n");
+		return -EINVAL;
+	}
+	nic_dev->intr_coalesce = kzalloc(size, GFP_KERNEL);
+	if (!nic_dev->intr_coalesce)
+		return -ENOMEM;
+
+	init_intr_coal_param(netdev);
+	return 0;
+}
+
+static void hinic3_free_intr_coalesce(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	kfree(nic_dev->intr_coalesce);
+}
+
+static int hinic3_alloc_txrxqs(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	int err;
+
+	err = hinic3_alloc_txqs(netdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to alloc txqs\n");
+		return err;
+	}
+
+	err = hinic3_alloc_rxqs(netdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to alloc rxqs\n");
+		goto err_alloc_rxqs;
+	}
+
+	err = hinic3_init_intr_coalesce(netdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to init_intr_coalesce\n");
+		goto err_init_intr;
+	}
+
+	return 0;
+
+err_init_intr:
+	hinic3_free_rxqs(netdev);
+
+err_alloc_rxqs:
+	hinic3_free_txqs(netdev);
+
+	return err;
+}
+
+static void hinic3_free_txrxqs(struct net_device *netdev)
+{
+	hinic3_free_intr_coalesce(netdev);
+	hinic3_free_rxqs(netdev);
+	hinic3_free_txqs(netdev);
+}
+
+static int hinic3_init_nic_dev(struct net_device *netdev,
+			       struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct pci_dev *pdev = hwdev->pdev;
+	u32 page_num;
+
+	nic_dev->netdev = netdev;
+	SET_NETDEV_DEV(netdev, &pdev->dev);
+	nic_dev->hwdev = hwdev;
+	nic_dev->pdev = pdev;
+
+	nic_dev->rx_buff_len = HINIC3_RX_BUFF_LEN;
+	nic_dev->dma_rx_buff_size = HINIC3_RX_BUFF_NUM_PER_PAGE * nic_dev->rx_buff_len;
+	page_num = nic_dev->dma_rx_buff_size / HINIC3_MIN_PAGE_SIZE;
+	nic_dev->page_order = page_num > 0 ? ilog2(page_num) : 0;
+	nic_dev->lro_replenish_thld = HINIC3_LRO_REPLENISH_THLD;
+	nic_dev->nic_cap = hwdev->cfg_mgmt->svc_cap.nic_cap;
+
+	return 0;
+}
+
+static int hinic3_sw_init(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	int err;
+
+	nic_dev->q_params.sq_depth = HINIC3_SQ_DEPTH;
+	nic_dev->q_params.rq_depth = HINIC3_RQ_DEPTH;
+
+	hinic3_try_to_enable_rss(netdev);
+
+	eth_hw_addr_random(netdev);
+	err = hinic3_set_mac(hwdev, netdev->dev_addr, 0,
+			     hinic3_global_func_id(hwdev));
+	if (err) {
+		dev_err(hwdev->dev, "Failed to set default MAC\n");
+		goto err_out;
+	}
+
+	err = hinic3_alloc_txrxqs(netdev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to alloc qps\n");
+		goto err_alloc_qps;
+	}
+
+	return 0;
+
+err_alloc_qps:
+	hinic3_del_mac(hwdev, netdev->dev_addr, 0, hinic3_global_func_id(hwdev));
+
+err_out:
+	hinic3_clear_rss_config(netdev);
+
+	return err;
+}
+
+static void hinic3_sw_deinit(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	hinic3_free_txrxqs(netdev);
+	hinic3_del_mac(nic_dev->hwdev, netdev->dev_addr, 0,
+		       hinic3_global_func_id(nic_dev->hwdev));
+	hinic3_clear_rss_config(netdev);
+}
+
+static void hinic3_assign_netdev_ops(struct net_device *netdev)
+{
+	hinic3_set_netdev_ops(netdev);
+}
+
+static void netdev_feature_init(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	netdev_features_t cso_fts = 0;
+	netdev_features_t tso_fts = 0;
+	netdev_features_t dft_fts;
+
+	dft_fts = NETIF_F_SG | NETIF_F_HIGHDMA;
+	if (hinic3_test_support(nic_dev, NIC_F_CSUM))
+		cso_fts |= NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM;
+	if (hinic3_test_support(nic_dev, NIC_F_SCTP_CRC))
+		cso_fts |= NETIF_F_SCTP_CRC;
+	if (hinic3_test_support(nic_dev, NIC_F_TSO))
+		tso_fts |= NETIF_F_TSO | NETIF_F_TSO6;
+
+	netdev->features |= dft_fts | cso_fts | tso_fts;
+}
+
+static int hinic3_set_default_hw_feature(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	int err;
+
+	err = hinic3_set_nic_feature_to_hw(nic_dev);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to set nic features\n");
+		return err;
+	}
+
+	return 0;
+}
+
+static void hinic3_link_status_change(struct net_device *netdev, bool link_status_up)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	if (!HINIC3_CHANNEL_RES_VALID(nic_dev))
+		return;
+
+	if (link_status_up) {
+		if (netif_carrier_ok(netdev))
+			return;
+
+		nic_dev->link_status_up = true;
+		netif_carrier_on(netdev);
+		netdev_dbg(netdev, "Link is up\n");
+	} else {
+		if (!netif_carrier_ok(netdev))
+			return;
+
+		nic_dev->link_status_up = false;
+		netif_carrier_off(netdev);
+		netdev_dbg(netdev, "Link is down\n");
+	}
+}
+
+static void nic_event(struct auxiliary_device *adev, struct hinic3_event_info *event)
+{
+	struct hinic3_nic_dev *nic_dev = dev_get_drvdata(&adev->dev);
+	struct net_device *netdev;
+
+	netdev = nic_dev->netdev;
+
+	switch (HINIC3_SRV_EVENT_TYPE(event->service, event->type)) {
+	case HINIC3_SRV_EVENT_TYPE(EVENT_SRV_NIC, EVENT_NIC_LINK_UP):
+		hinic3_link_status_change(netdev, true);
+		break;
+	case HINIC3_SRV_EVENT_TYPE(EVENT_SRV_NIC, EVENT_NIC_LINK_DOWN):
+		hinic3_link_status_change(netdev, false);
+		break;
+	default:
+		break;
+	}
+}
+
+static int nic_probe(struct auxiliary_device *adev, const struct auxiliary_device_id *id)
+{
+	struct hinic3_hwdev *hwdev = adev_get_hwdev(adev);
+	struct pci_dev *pdev = hwdev->pdev;
+	struct hinic3_nic_dev *nic_dev;
+	struct net_device *netdev;
+	u16 max_qps, glb_func_id;
+	int err;
+
+	if (!hinic3_support_nic(hwdev)) {
+		dev_dbg(&adev->dev, "Hw doesn't support nic\n");
+		return 0;
+	}
+
+	err = hinic3_adev_event_register(adev, nic_event);
+	if (err) {
+		err = -EINVAL;
+		goto err_out;
+	}
+
+	glb_func_id = hinic3_global_func_id(hwdev);
+	err = hinic3_func_reset(hwdev, glb_func_id, RESET_TYPE_NIC);
+	if (err) {
+		dev_err(&adev->dev, "Failed to reset function\n");
+		goto err_out;
+	}
+
+	max_qps = hinic3_func_max_qnum(hwdev);
+	netdev = alloc_etherdev_mq(sizeof(*nic_dev), max_qps);
+	if (!netdev) {
+		dev_err(&adev->dev, "Failed to allocate netdev\n");
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	nic_dev = netdev_priv(netdev);
+	dev_set_drvdata(&adev->dev, nic_dev);
+	err = hinic3_init_nic_dev(netdev, hwdev);
+	if (err)
+		goto err_undo_alloc_etherdev;
+
+	err = hinic3_init_nic_io(nic_dev);
+	if (err)
+		goto err_undo_alloc_etherdev;
+
+	err = hinic3_sw_init(netdev);
+	if (err)
+		goto err_sw_init;
+
+	hinic3_assign_netdev_ops(netdev);
+
+	netdev_feature_init(netdev);
+	err = hinic3_set_default_hw_feature(netdev);
+	if (err)
+		goto err_set_features;
+
+	err = register_netdev(netdev);
+	if (err) {
+		err = -ENOMEM;
+		goto err_netdev;
+	}
+
+	netif_carrier_off(netdev);
+	return 0;
+
+err_netdev:
+	hinic3_update_nic_feature(nic_dev, 0);
+	hinic3_set_nic_feature_to_hw(nic_dev);
+
+err_set_features:
+	hinic3_sw_deinit(netdev);
+
+err_sw_init:
+	hinic3_free_nic_io(nic_dev);
+
+err_undo_alloc_etherdev:
+	free_netdev(netdev);
+
+err_out:
+	dev_err(&pdev->dev, "NIC service probe failed\n");
+
+	return err;
+}
+
+static void nic_remove(struct auxiliary_device *adev)
+{
+	struct hinic3_nic_dev *nic_dev = dev_get_drvdata(&adev->dev);
+	struct net_device *netdev;
+
+	if (!hinic3_support_nic(nic_dev->hwdev))
+		return;
+
+	netdev = nic_dev->netdev;
+	unregister_netdev(netdev);
+
+	hinic3_update_nic_feature(nic_dev, 0);
+	hinic3_set_nic_feature_to_hw(nic_dev);
+	hinic3_sw_deinit(netdev);
+
+	hinic3_free_nic_io(nic_dev);
+
+	free_netdev(netdev);
+}
+
+static const struct auxiliary_device_id nic_id_table[] = {
+	{
+		.name = HINIC3_NIC_DRV_NAME ".nic",
+	},
+	{},
+};
+
+static struct auxiliary_driver nic_driver = {
+	.probe    = nic_probe,
+	.remove   = nic_remove,
+	.suspend  = NULL,
+	.resume   = NULL,
+	.name     = "nic",
+	.id_table = nic_id_table,
+};
+
+static __init int hinic3_nic_lld_init(void)
+{
+	int err;
+
+	pr_info("%s: %s\n", HINIC3_NIC_DRV_NAME, HINIC3_NIC_DRV_DESC);
+
+	err = hinic3_lld_init();
+	if (err)
+		return err;
+
+	err = auxiliary_driver_register(&nic_driver);
+	if (err) {
+		hinic3_lld_exit();
+		return err;
+	}
+
+	return 0;
+}
+
+static __exit void hinic3_nic_lld_exit(void)
+{
+	auxiliary_driver_unregister(&nic_driver);
+
+	hinic3_lld_exit();
+}
+
+module_init(hinic3_nic_lld_init);
+module_exit(hinic3_nic_lld_exit);
+
+MODULE_AUTHOR("Huawei Technologies CO., Ltd");
+MODULE_DESCRIPTION(HINIC3_NIC_DRV_DESC);
+MODULE_LICENSE("GPL");
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
new file mode 100644
index 000000000000..73b0357c0a07
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/dma-mapping.h>
+
+#include "hinic3_mbox.h"
+#include "hinic3_common.h"
+#include "hinic3_hwdev.h"
+#include "hinic3_hwif.h"
+
+int hinic3_send_mbox_to_mgmt(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
+			     const void *buf_in, u32 in_size, void *buf_out,
+			     u32 *out_size, u32 timeout)
+{
+	/* Completed by later submission due to LoC limit. */
+	return -EFAULT;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h
new file mode 100644
index 000000000000..5a90420230b4
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_MBOX_H
+#define HINIC3_MBOX_H
+
+#include <linux/mutex.h>
+#include <linux/bitfield.h>
+
+struct hinic3_hwdev;
+
+int hinic3_send_mbox_to_mgmt(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,
+			     const void *buf_in, u32 in_size, void *buf_out,
+			     u32 *out_size, u32 timeout);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.h b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.h
new file mode 100644
index 000000000000..9e044a8a81b5
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_MGMT_H
+#define HINIC3_MGMT_H
+
+#include <linux/types.h>
+
+struct hinic3_hwdev;
+
+void hinic3_flush_mgmt_workq(struct hinic3_hwdev *hwdev);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
new file mode 100644
index 000000000000..1ab9e09a3d2b
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
@@ -0,0 +1,111 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC_MGMT_INTERFACE_H
+#define HINIC_MGMT_INTERFACE_H
+
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/if_ether.h>
+
+#define HINIC3_CMD_OP_SET  1
+#define HINIC3_CMD_OP_GET  0
+
+enum nic_feature_cap {
+	NIC_F_CSUM           = BIT(0),
+	NIC_F_SCTP_CRC       = BIT(1),
+	NIC_F_TSO            = BIT(2),
+	NIC_F_LRO            = BIT(3),
+	NIC_F_UFO            = BIT(4),
+	NIC_F_RSS            = BIT(5),
+	NIC_F_RX_VLAN_FILTER = BIT(6),
+	NIC_F_RX_VLAN_STRIP  = BIT(7),
+	NIC_F_TX_VLAN_INSERT = BIT(8),
+	NIC_F_VXLAN_OFFLOAD  = BIT(9),
+	NIC_F_FDIR           = BIT(11),
+	NIC_F_PROMISC        = BIT(12),
+	NIC_F_ALLMULTI       = BIT(13),
+	NIC_F_RATE_LIMIT     = BIT(16),
+};
+
+#define NIC_F_ALL_MASK           0x33bff
+#define NIC_DRV_DEFAULT_FEATURE  0x3f03f
+
+struct hinic3_mgmt_msg_head {
+	u8 status;
+	u8 version;
+	u8 rsvd0[6];
+};
+
+struct hinic3_cmd_feature_nego {
+	struct hinic3_mgmt_msg_head msg_head;
+	u16                         func_id;
+	u8                          opcode;
+	u8                          rsvd;
+	u64                         s_feature[4];
+};
+
+enum hinic3_func_tbl_cfg_bitmap {
+	FUNC_CFG_INIT        = 0,
+	FUNC_CFG_RX_BUF_SIZE = 1,
+	FUNC_CFG_MTU         = 2,
+};
+
+struct hinic3_func_tbl_cfg {
+	u16 rx_wqe_buf_size;
+	u16 mtu;
+	u32 rsvd[9];
+};
+
+struct hinic3_cmd_set_func_tbl {
+	struct hinic3_mgmt_msg_head msg_head;
+	u16                         func_id;
+	u16                         rsvd;
+	u32                         cfg_bitmap;
+	struct hinic3_func_tbl_cfg  tbl_cfg;
+};
+
+struct hinic3_port_mac_set {
+	struct hinic3_mgmt_msg_head msg_head;
+	u16                         func_id;
+	u16                         vlan_id;
+	u16                         rsvd1;
+	u8                          mac[ETH_ALEN];
+};
+
+struct hinic3_port_mac_update {
+	struct hinic3_mgmt_msg_head msg_head;
+	u16                         func_id;
+	u16                         vlan_id;
+	u16                         rsvd1;
+	u8                          old_mac[ETH_ALEN];
+	u16                         rsvd2;
+	u8                          new_mac[ETH_ALEN];
+};
+
+struct hinic3_force_pkt_drop {
+	struct hinic3_mgmt_msg_head msg_head;
+	u8                          port;
+	u8                          rsvd1[3];
+};
+
+/* Commands between NIC to fw */
+enum hinic3_nic_cmd {
+	/* FUNC CFG */
+	HINIC3_NIC_CMD_SET_FUNC_TBL              = 5,
+	HINIC3_NIC_CMD_SET_VPORT_ENABLE          = 6,
+	HINIC3_NIC_CMD_SQ_CI_ATTR_SET            = 8,
+	HINIC3_NIC_CMD_CLEAR_QP_RESOURCE         = 11,
+	HINIC3_NIC_CMD_FEATURE_NEGO              = 15,
+	HINIC3_NIC_CMD_SET_MAC                   = 21,
+	HINIC3_NIC_CMD_DEL_MAC                   = 22,
+	HINIC3_NIC_CMD_UPDATE_MAC                = 23,
+	HINIC3_NIC_CMD_RSS_CFG                   = 60,
+	HINIC3_NIC_CMD_CFG_RSS_HASH_KEY          = 63,
+	HINIC3_NIC_CMD_CFG_RSS_HASH_ENGINE       = 64,
+	HINIC3_NIC_CMD_SET_RSS_CTX_TBL_INTO_FUNC = 65,
+	HINIC3_NIC_CMD_QOS_DCB_STATE             = 110,
+	HINIC3_NIC_CMD_FORCE_PKT_DROP            = 113,
+};
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
new file mode 100644
index 000000000000..d02dd714ce2e
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+
+#include "hinic3_nic_dev.h"
+#include "hinic3_nic_cfg.h"
+#include "hinic3_nic_io.h"
+#include "hinic3_tx.h"
+#include "hinic3_rx.h"
+#include "hinic3_rss.h"
+#include "hinic3_hwif.h"
+
+static int hinic3_open(struct net_device *netdev)
+{
+	/* Completed by later submission due to LoC limit. */
+	return -EFAULT;
+}
+
+static int hinic3_close(struct net_device *netdev)
+{
+	/* Completed by later submission due to LoC limit. */
+	return -EFAULT;
+}
+
+static int hinic3_change_mtu(struct net_device *netdev, int new_mtu)
+{
+	int err;
+
+	err = hinic3_set_port_mtu(netdev, new_mtu);
+	if (err) {
+		netdev_err(netdev, "Failed to change port mtu to %d\n", new_mtu);
+	} else {
+		netdev_dbg(netdev, "Change mtu from %u to %d\n", netdev->mtu, new_mtu);
+		WRITE_ONCE(netdev->mtu, new_mtu);
+	}
+
+	return err;
+}
+
+static int hinic3_set_mac_addr(struct net_device *netdev, void *addr)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct sockaddr *saddr = addr;
+	int err;
+
+	if (!is_valid_ether_addr(saddr->sa_data))
+		return -EADDRNOTAVAIL;
+
+	if (ether_addr_equal(netdev->dev_addr, saddr->sa_data))
+		return 0;
+
+	err = hinic3_update_mac(nic_dev->hwdev, netdev->dev_addr,
+				saddr->sa_data, 0,
+				hinic3_global_func_id(nic_dev->hwdev));
+
+	if (err)
+		return err;
+
+	eth_hw_addr_set(netdev, saddr->sa_data);
+
+	return 0;
+}
+
+static const struct net_device_ops hinic3_netdev_ops = {
+	.ndo_open             = hinic3_open,
+	.ndo_stop             = hinic3_close,
+	.ndo_change_mtu       = hinic3_change_mtu,
+	.ndo_set_mac_address  = hinic3_set_mac_addr,
+	.ndo_start_xmit       = hinic3_xmit_frame,
+};
+
+void hinic3_set_netdev_ops(struct net_device *netdev)
+{
+	netdev->netdev_ops = &hinic3_netdev_ops;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
new file mode 100644
index 000000000000..22db923101e2
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/if_vlan.h>
+
+#include "hinic3_nic_cfg.h"
+#include "hinic3_nic_io.h"
+#include "hinic3_hwdev.h"
+#include "hinic3_mbox.h"
+#include "hinic3_nic_dev.h"
+#include "hinic3_hwif.h"
+
+int l2nic_msg_to_mgmt_sync(struct hinic3_hwdev *hwdev, u16 cmd,
+			   const void *buf_in, u32 in_size,
+			   void *buf_out, u32 *out_size)
+{
+	return hinic3_send_mbox_to_mgmt(hwdev, HINIC3_MOD_L2NIC, cmd, buf_in,
+					in_size, buf_out, out_size, 0);
+}
+
+static int nic_feature_nego(struct hinic3_hwdev *hwdev, u8 opcode, u64 *s_feature, u16 size)
+{
+	struct hinic3_cmd_feature_nego feature_nego;
+	u32 out_size = sizeof(feature_nego);
+	int err;
+
+	memset(&feature_nego, 0, sizeof(feature_nego));
+	feature_nego.func_id = hinic3_global_func_id(hwdev);
+	feature_nego.opcode = opcode;
+	if (opcode == HINIC3_CMD_OP_SET)
+		memcpy(feature_nego.s_feature, s_feature, size * sizeof(u64));
+
+	err = l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_FEATURE_NEGO,
+				     &feature_nego, sizeof(feature_nego),
+				     &feature_nego, &out_size);
+	if (err || !out_size || feature_nego.msg_head.status) {
+		dev_err(hwdev->dev, "Failed to negotiate nic feature, err:%d, status: 0x%x, out_size: 0x%x\n",
+			err, feature_nego.msg_head.status, out_size);
+		return -EIO;
+	}
+
+	if (opcode == HINIC3_CMD_OP_GET)
+		memcpy(s_feature, feature_nego.s_feature, size * sizeof(u64));
+
+	return 0;
+}
+
+int hinic3_set_nic_feature_to_hw(struct hinic3_nic_dev *nic_dev)
+{
+	return nic_feature_nego(nic_dev->hwdev, HINIC3_CMD_OP_SET,
+				&nic_dev->nic_io->feature_cap, 1);
+}
+
+bool hinic3_test_support(struct hinic3_nic_dev *nic_dev,
+			 enum nic_feature_cap feature_bits)
+{
+	return (nic_dev->nic_io->feature_cap & feature_bits) == feature_bits;
+}
+
+void hinic3_update_nic_feature(struct hinic3_nic_dev *nic_dev, u64 feature_cap)
+{
+	nic_dev->nic_io->feature_cap = feature_cap;
+}
+
+static int hinic3_set_function_table(struct hinic3_hwdev *hwdev, u32 cfg_bitmap,
+				     const struct hinic3_func_tbl_cfg *cfg)
+{
+	struct hinic3_cmd_set_func_tbl cmd_func_tbl;
+	u32 out_size = sizeof(cmd_func_tbl);
+	int err;
+
+	memset(&cmd_func_tbl, 0, sizeof(cmd_func_tbl));
+	cmd_func_tbl.func_id = hinic3_global_func_id(hwdev);
+	cmd_func_tbl.cfg_bitmap = cfg_bitmap;
+	cmd_func_tbl.tbl_cfg = *cfg;
+
+	err = l2nic_msg_to_mgmt_sync(hwdev,
+				     HINIC3_NIC_CMD_SET_FUNC_TBL,
+				     &cmd_func_tbl, sizeof(cmd_func_tbl),
+				     &cmd_func_tbl, &out_size);
+	if (err || cmd_func_tbl.msg_head.status || !out_size) {
+		dev_err(hwdev->dev,
+			"Failed to set func table, bitmap: 0x%x, err: %d, status: 0x%x, out size: 0x%x\n",
+			cfg_bitmap, err, cmd_func_tbl.msg_head.status,
+			out_size);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+int hinic3_set_port_mtu(struct net_device *netdev, u16 new_mtu)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_func_tbl_cfg func_tbl_cfg = {};
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+
+	if (new_mtu < HINIC3_MIN_MTU_SIZE) {
+		dev_err(hwdev->dev,
+			"Invalid mtu size: %ubytes, mtu size < %ubytes\n",
+			new_mtu, HINIC3_MIN_MTU_SIZE);
+		return -EINVAL;
+	}
+
+	if (new_mtu > HINIC3_MAX_JUMBO_FRAME_SIZE) {
+		dev_err(hwdev->dev, "Invalid mtu size: %ubytes, mtu size > %ubytes\n",
+			new_mtu, HINIC3_MAX_JUMBO_FRAME_SIZE);
+		return -EINVAL;
+	}
+
+	func_tbl_cfg.mtu = new_mtu;
+	return hinic3_set_function_table(hwdev, BIT(FUNC_CFG_MTU),
+					 &func_tbl_cfg);
+}
+
+static int hinic3_check_mac_info(struct hinic3_hwdev *hwdev, u8 status, u16 vlan_id)
+{
+	if ((status && status != HINIC3_MGMT_STATUS_EXIST) ||
+	    ((vlan_id & CHECK_IPSU_15BIT) &&
+	     status == HINIC3_MGMT_STATUS_EXIST)) {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+#define HINIC_VLAN_ID_MASK  0x7FFF
+
+int hinic3_set_mac(struct hinic3_hwdev *hwdev, const u8 *mac_addr, u16 vlan_id, u16 func_id)
+{
+	struct hinic3_port_mac_set mac_info;
+	u32 out_size = sizeof(mac_info);
+	int err;
+
+	if ((vlan_id & HINIC_VLAN_ID_MASK) >= VLAN_N_VID) {
+		dev_err(hwdev->dev, "Invalid VLAN number: %d\n",
+			(vlan_id & HINIC_VLAN_ID_MASK));
+		return -EINVAL;
+	}
+
+	memset(&mac_info, 0, sizeof(mac_info));
+	mac_info.func_id = func_id;
+	mac_info.vlan_id = vlan_id;
+	ether_addr_copy(mac_info.mac, mac_addr);
+
+	err = l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_SET_MAC,
+				     &mac_info, sizeof(mac_info),
+				     &mac_info, &out_size);
+	if (err || !out_size ||
+	    hinic3_check_mac_info(hwdev, mac_info.msg_head.status,
+				  mac_info.vlan_id)) {
+		dev_err(hwdev->dev,
+			"Failed to update MAC, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, mac_info.msg_head.status, out_size);
+		return -EIO;
+	}
+
+	if (mac_info.msg_head.status == HINIC3_PF_SET_VF_ALREADY) {
+		dev_warn(hwdev->dev, "PF has already set VF mac, Ignore set operation\n");
+		return 0;
+	}
+
+	if (mac_info.msg_head.status == HINIC3_MGMT_STATUS_EXIST) {
+		dev_warn(hwdev->dev, "MAC is repeated. Ignore update operation\n");
+		return 0;
+	}
+
+	return 0;
+}
+
+int hinic3_del_mac(struct hinic3_hwdev *hwdev, const u8 *mac_addr, u16 vlan_id, u16 func_id)
+{
+	struct hinic3_port_mac_set mac_info;
+	u32 out_size = sizeof(mac_info);
+	int err;
+
+	if ((vlan_id & HINIC_VLAN_ID_MASK) >= VLAN_N_VID) {
+		dev_err(hwdev->dev, "Invalid VLAN number: %d\n",
+			(vlan_id & HINIC_VLAN_ID_MASK));
+		return -EINVAL;
+	}
+
+	memset(&mac_info, 0, sizeof(mac_info));
+	mac_info.func_id = func_id;
+	mac_info.vlan_id = vlan_id;
+	ether_addr_copy(mac_info.mac, mac_addr);
+
+	err = l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_DEL_MAC,
+				     &mac_info, sizeof(mac_info), &mac_info,
+				     &out_size);
+	if (err || !out_size) {
+		dev_err(hwdev->dev,
+			"Failed to delete MAC, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, mac_info.msg_head.status, out_size);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+int hinic3_update_mac(struct hinic3_hwdev *hwdev, const u8 *old_mac, u8 *new_mac,
+		      u16 vlan_id, u16 func_id)
+{
+	struct hinic3_port_mac_update mac_info;
+	u32 out_size = sizeof(mac_info);
+	int err;
+
+	if ((vlan_id & HINIC_VLAN_ID_MASK) >= VLAN_N_VID) {
+		dev_err(hwdev->dev, "Invalid VLAN number: %d\n",
+			(vlan_id & HINIC_VLAN_ID_MASK));
+		return -EINVAL;
+	}
+
+	memset(&mac_info, 0, sizeof(mac_info));
+	mac_info.func_id = func_id;
+	mac_info.vlan_id = vlan_id;
+	ether_addr_copy(mac_info.old_mac, old_mac);
+	ether_addr_copy(mac_info.new_mac, new_mac);
+
+	err = l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_UPDATE_MAC,
+				     &mac_info, sizeof(mac_info),
+				     &mac_info, &out_size);
+	if (err || !out_size ||
+	    hinic3_check_mac_info(hwdev, mac_info.msg_head.status,
+				  mac_info.vlan_id)) {
+		dev_err(hwdev->dev,
+			"Failed to update MAC, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, mac_info.msg_head.status, out_size);
+		return -EIO;
+	}
+	return 0;
+}
+
+int hinic3_force_drop_tx_pkt(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_force_pkt_drop pkt_drop;
+	u32 out_size = sizeof(pkt_drop);
+	int err;
+
+	memset(&pkt_drop, 0, sizeof(pkt_drop));
+	pkt_drop.port = hinic3_physical_port_id(hwdev);
+	err = l2nic_msg_to_mgmt_sync(hwdev, HINIC3_NIC_CMD_FORCE_PKT_DROP,
+				     &pkt_drop, sizeof(pkt_drop),
+				     &pkt_drop, &out_size);
+	if ((pkt_drop.msg_head.status != MGMT_CMD_UNSUPPORTED &&
+	     pkt_drop.msg_head.status) || err || !out_size) {
+		dev_err(hwdev->dev,
+			"Failed to set force tx packets drop, err: %d, status: 0x%x, out size: 0x%x\n",
+			err, pkt_drop.msg_head.status, out_size);
+		return -EFAULT;
+	}
+
+	return pkt_drop.msg_head.status;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
new file mode 100644
index 000000000000..00456994e55c
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_NIC_CFG_H
+#define HINIC3_NIC_CFG_H
+
+#include <linux/types.h>
+
+#include "hinic3_mgmt_interface.h"
+#include "hinic3_hw_intf.h"
+
+struct hinic3_hwdev;
+struct hinic3_nic_dev;
+
+#define HINIC3_MIN_MTU_SIZE             256
+#define HINIC3_MAX_JUMBO_FRAME_SIZE     9600
+
+#define HINIC3_PF_SET_VF_ALREADY        0x4
+#define HINIC3_MGMT_STATUS_EXIST        0x6
+#define CHECK_IPSU_15BIT                0x8000
+
+enum hinic3_nic_event_type {
+	EVENT_NIC_LINK_DOWN = 0,
+	EVENT_NIC_LINK_UP = 1,
+};
+
+int l2nic_msg_to_mgmt_sync(struct hinic3_hwdev *hwdev, u16 cmd,
+			   const void *buf_in, u32 in_size,
+			   void *buf_out, u32 *out_size);
+
+int hinic3_set_nic_feature_to_hw(struct hinic3_nic_dev *nic_dev);
+bool hinic3_test_support(struct hinic3_nic_dev *nic_dev,
+			 enum nic_feature_cap feature_bits);
+void hinic3_update_nic_feature(struct hinic3_nic_dev *nic_dev, u64 feature_cap);
+
+int hinic3_set_port_mtu(struct net_device *netdev, u16 new_mtu);
+
+int hinic3_set_mac(struct hinic3_hwdev *hwdev, const u8 *mac_addr, u16 vlan_id, u16 func_id);
+int hinic3_del_mac(struct hinic3_hwdev *hwdev, const u8 *mac_addr, u16 vlan_id, u16 func_id);
+int hinic3_update_mac(struct hinic3_hwdev *hwdev, const u8 *old_mac, u8 *new_mac, u16 vlan_id,
+		      u16 func_id);
+
+int hinic3_force_drop_tx_pkt(struct hinic3_hwdev *hwdev);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
new file mode 100644
index 000000000000..4daacc7b03b0
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_NIC_DEV_H
+#define HINIC3_NIC_DEV_H
+
+#include <linux/netdevice.h>
+
+#include "hinic3_hw_cfg.h"
+#include "hinic3_mgmt_interface.h"
+
+enum hinic3_flags {
+	HINIC3_INTF_UP,
+	HINIC3_RSS_ENABLE,
+	HINIC3_CHANGE_RES_INVALID,
+	HINIC3_RSS_DEFAULT_INDIR,
+};
+
+#define HINIC3_CHANNEL_RES_VALID(nic_dev) \
+	(test_bit(HINIC3_INTF_UP, &(nic_dev)->flags) && \
+	 !test_bit(HINIC3_CHANGE_RES_INVALID, &(nic_dev)->flags))
+
+enum hinic3_rss_hash_type {
+	HINIC3_RSS_HASH_ENGINE_TYPE_XOR  = 0,
+	HINIC3_RSS_HASH_ENGINE_TYPE_TOEP = 1,
+};
+
+struct nic_rss_type {
+	u8 tcp_ipv6_ext;
+	u8 ipv6_ext;
+	u8 tcp_ipv6;
+	u8 ipv6;
+	u8 tcp_ipv4;
+	u8 ipv4;
+	u8 udp_ipv6;
+	u8 udp_ipv4;
+};
+
+struct hinic3_irq {
+	struct net_device  *netdev;
+	u16                msix_entry_idx;
+	/* provided by OS */
+	u32                irq_id;
+	char               irq_name[IFNAMSIZ + 16];
+	struct napi_struct napi;
+	cpumask_t          affinity_mask;
+	struct hinic3_txq  *txq;
+	struct hinic3_rxq  *rxq;
+};
+
+struct hinic3_dyna_txrxq_params {
+	u16                        num_qps;
+	u32                        sq_depth;
+	u32                        rq_depth;
+
+	struct hinic3_dyna_txq_res *txqs_res;
+	struct hinic3_dyna_rxq_res *rxqs_res;
+	struct hinic3_irq          *irq_cfg;
+};
+
+struct hinic3_intr_coal_info {
+	u8  pending_limt;
+	u8  coalesce_timer_cfg;
+	u8  resend_timer_cfg;
+};
+
+struct hinic3_nic_dev {
+	struct pci_dev                  *pdev;
+	struct net_device               *netdev;
+	struct hinic3_hwdev             *hwdev;
+	struct hinic3_nic_io            *nic_io;
+
+	u16                             max_qps;
+	u32                             dma_rx_buff_size;
+	u16                             rx_buff_len;
+	u32                             page_order;
+	u32                             lro_replenish_thld;
+	unsigned long                   flags;
+	struct nic_service_cap          nic_cap;
+
+	struct hinic3_dyna_txrxq_params q_params;
+	struct hinic3_txq               *txqs;
+	struct hinic3_rxq               *rxqs;
+
+	enum hinic3_rss_hash_type       rss_hash_type;
+	struct nic_rss_type             rss_type;
+	u8                              *rss_hkey;
+	u32                             *rss_indir;
+
+	u16                             num_qp_irq;
+	struct irq_info                 *qps_irq_info;
+
+	struct hinic3_intr_coal_info    *intr_coalesce;
+
+	bool                            link_status_up;
+};
+
+void hinic3_set_netdev_ops(struct net_device *netdev);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
new file mode 100644
index 000000000000..fe79bf8013b9
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include "hinic3_nic_io.h"
+#include "hinic3_hwdev.h"
+#include "hinic3_nic_cfg.h"
+#include "hinic3_nic_dev.h"
+#include "hinic3_hw_comm.h"
+#include "hinic3_hw_intf.h"
+#include "hinic3_hwif.h"
+
+int hinic3_init_nic_io(struct hinic3_nic_dev *nic_dev)
+{
+	/* Completed by later submission due to LoC limit. */
+	return -EFAULT;
+}
+
+void hinic3_free_nic_io(struct hinic3_nic_dev *nic_dev)
+{
+	/* Completed by later submission due to LoC limit. */
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
new file mode 100644
index 000000000000..9308a11a1fb7
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
@@ -0,0 +1,117 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_NIC_IO_H
+#define HINIC3_NIC_IO_H
+
+#include <linux/bitfield.h>
+#include "hinic3_wq.h"
+
+struct hinic3_nic_dev;
+
+#define HINIC3_SQ_WQEBB_SHIFT      4
+#define HINIC3_RQ_WQEBB_SHIFT      3
+#define HINIC3_SQ_WQEBB_SIZE       BIT(HINIC3_SQ_WQEBB_SHIFT)
+
+/* ******************** RQ_CTRL ******************** */
+enum hinic3_rq_wqe_type {
+	HINIC3_NORMAL_RQ_WQE = 1,
+};
+
+/* ******************** SQ_CTRL ******************** */
+#define TX_MSS_DEFAULT     0x3E00
+#define TX_MSS_MIN         0x50
+#define HINIC3_MAX_SQ_SGE  18
+
+struct hinic3_io_queue {
+	struct hinic3_wq  wq;
+	u8                owner;
+	u16               q_id;
+	u16               msix_entry_idx;
+	u8 __iomem        *db_addr;
+	u16               *cons_idx_addr;
+} ____cacheline_aligned;
+
+static inline u16 hinic3_get_sq_local_ci(const struct hinic3_io_queue *sq)
+{
+	const struct hinic3_wq *wq = &sq->wq;
+
+	return wq->cons_idx & wq->idx_mask;
+}
+
+static inline u16 hinic3_get_sq_local_pi(const struct hinic3_io_queue *sq)
+{
+	const struct hinic3_wq *wq = &sq->wq;
+
+	return wq->prod_idx & wq->idx_mask;
+}
+
+static inline u16 hinic3_get_sq_hw_ci(const struct hinic3_io_queue *sq)
+{
+	const struct hinic3_wq *wq = &sq->wq;
+
+	return READ_ONCE(*sq->cons_idx_addr) & wq->idx_mask;
+}
+
+/* ******************** DB INFO ******************** */
+#define DB_INFO_QID_MASK    GENMASK(12, 0)
+#define DB_INFO_CFLAG_MASK  BIT(23)
+#define DB_INFO_COS_MASK    GENMASK(26, 24)
+#define DB_INFO_TYPE_MASK   GENMASK(31, 27)
+#define DB_INFO_SET(val, member)  \
+	FIELD_PREP(DB_INFO_##member##_MASK, val)
+
+#define DB_PI_LOW_MASK   0xFFU
+#define DB_PI_HIGH_MASK  0xFFU
+#define DB_PI_HI_SHIFT   8
+#define DB_PI_LOW(pi)    ((pi) & DB_PI_LOW_MASK)
+#define DB_PI_HIGH(pi)   (((pi) >> DB_PI_HI_SHIFT) & DB_PI_HIGH_MASK)
+#define DB_ADDR(q, pi)   ((u64 __iomem *)((q)->db_addr) + DB_PI_LOW(pi))
+#define SRC_TYPE         1
+
+/* CFLAG_DATA_PATH */
+#define SQ_CFLAG_DP             0
+#define RQ_CFLAG_DP             1
+
+struct hinic3_nic_db {
+	u32 db_info;
+	u32 pi_hi;
+};
+
+static inline void hinic3_write_db(struct hinic3_io_queue *queue, int cos,
+				   u8 cflag, u16 pi)
+{
+	struct hinic3_nic_db db;
+
+	db.db_info = DB_INFO_SET(SRC_TYPE, TYPE) | DB_INFO_SET(cflag, CFLAG) |
+			DB_INFO_SET(cos, COS) | DB_INFO_SET(queue->q_id, QID);
+	db.pi_hi = DB_PI_HIGH(pi);
+
+	writeq(*((u64 *)&db), DB_ADDR(queue, pi));
+}
+
+struct hinic3_nic_io {
+	struct hinic3_io_queue *sq;
+	struct hinic3_io_queue *rq;
+
+	u16                    num_qps;
+	u16                    max_qps;
+
+	/* Base address for consumer index of all tx queues. Each queue is
+	 * given a full cache line to hold its consumer index. HW updates
+	 * current consumer index as it consumes tx WQEs.
+	 */
+	void                   *ci_vaddr_base;
+	dma_addr_t             ci_dma_base;
+
+	u8 __iomem             *sqs_db_addr;
+	u8 __iomem             *rqs_db_addr;
+
+	u16                    rx_buff_len;
+	u64                    feature_cap;
+};
+
+int hinic3_init_nic_io(struct hinic3_nic_dev *nic_dev);
+void hinic3_free_nic_io(struct hinic3_nic_dev *nic_dev);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_queue_common.c b/drivers/net/ethernet/huawei/hinic3/hinic3_queue_common.c
new file mode 100644
index 000000000000..a5394ad3bffc
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_queue_common.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/device.h>
+
+#include "hinic3_queue_common.h"
+#include "hinic3_hwdev.h"
+
+void queue_pages_init(struct hinic3_queue_pages *qpages, u32 q_depth,
+		      u32 page_size, u32 elem_size)
+{
+	u32 elem_per_page;
+
+	elem_per_page = min(page_size / elem_size, q_depth);
+
+	qpages->pages = NULL;
+	qpages->page_size = page_size;
+	qpages->num_pages = max(q_depth / elem_per_page, 1);
+	qpages->elem_size_shift = ilog2(elem_size);
+	qpages->elem_per_pg_shift = ilog2(elem_per_page);
+}
+
+static void __queue_pages_free(struct hinic3_hwdev *hwdev,
+			       struct hinic3_queue_pages *qpages, u32 pg_cnt)
+{
+	while (pg_cnt > 0) {
+		pg_cnt--;
+		hinic3_dma_free_coherent_align(hwdev->dev,
+					       qpages->pages + pg_cnt);
+	}
+	kfree(qpages->pages);
+	qpages->pages = NULL;
+}
+
+void queue_pages_free(struct hinic3_hwdev *hwdev, struct hinic3_queue_pages *qpages)
+{
+	__queue_pages_free(hwdev, qpages, qpages->num_pages);
+}
+
+int queue_pages_alloc(struct hinic3_hwdev *hwdev, struct hinic3_queue_pages *qpages, u32 align)
+{
+	u32 pg_idx;
+	int err;
+
+	qpages->pages = kcalloc(qpages->num_pages, sizeof(qpages->pages[0]), GFP_KERNEL);
+	if (!qpages->pages)
+		return -ENOMEM;
+
+	if (align == 0)
+		align = qpages->page_size;
+
+	for (pg_idx = 0; pg_idx < qpages->num_pages; pg_idx++) {
+		err = hinic3_dma_zalloc_coherent_align(hwdev->dev,
+						       qpages->page_size,
+						       align,
+						       GFP_KERNEL,
+						       qpages->pages + pg_idx);
+		if (err) {
+			__queue_pages_free(hwdev, qpages, pg_idx);
+			return err;
+		}
+	}
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_queue_common.h b/drivers/net/ethernet/huawei/hinic3/hinic3_queue_common.h
new file mode 100644
index 000000000000..55305a8901f1
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_queue_common.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_QUEUE_COMMON_H
+#define HINIC3_QUEUE_COMMON_H
+
+#include <linux/types.h>
+#include "hinic3_common.h"
+
+struct hinic3_hwdev;
+
+struct hinic3_queue_pages {
+	/* Array of DMA-able pages that actually holds the queue entries. */
+	struct hinic3_dma_addr_align  *pages;
+	/* Page size in bytes. */
+	u32                           page_size;
+	/* Number of pages, must be power of 2. */
+	u16                           num_pages;
+	u8                            elem_size_shift;
+	u8                            elem_per_pg_shift;
+};
+
+void queue_pages_init(struct hinic3_queue_pages *qpages, u32 q_depth,
+		      u32 page_size, u32 elem_size);
+int queue_pages_alloc(struct hinic3_hwdev *hwdev, struct hinic3_queue_pages *qpages, u32 align);
+void queue_pages_free(struct hinic3_hwdev *hwdev, struct hinic3_queue_pages *qpages);
+
+/* Get pointer to queue entry at the specified index. Index does not have to be
+ * masked to queue depth, only least significant bits will be used. Also
+ * provides remaining elements in same page (including the first one) in case
+ * caller needs multiple entries.
+ */
+static inline void *get_q_element(const struct hinic3_queue_pages *qpages,
+				  u32 idx, u32 *remaining_in_page)
+{
+	const struct hinic3_dma_addr_align *page;
+	u32 page_idx, elem_idx, elem_per_pg, ofs;
+	u8 shift;
+
+	shift = qpages->elem_per_pg_shift;
+	page_idx = (idx >> shift) & (qpages->num_pages - 1);
+	elem_per_pg = 1U << shift;
+	elem_idx = idx & (elem_per_pg - 1);
+	if (remaining_in_page)
+		*remaining_in_page = elem_per_pg - elem_idx;
+	ofs = elem_idx << qpages->elem_size_shift;
+	page = qpages->pages + page_idx;
+	return (char *)page->align_vaddr + ofs;
+}
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
new file mode 100644
index 000000000000..7873a18fac65
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include "hinic3_rss.h"
+#include "hinic3_hwdev.h"
+#include "hinic3_nic_dev.h"
+#include "hinic3_nic_cfg.h"
+#include "hinic3_hwif.h"
+
+void hinic3_clear_rss_config(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	kfree(nic_dev->rss_hkey);
+	nic_dev->rss_hkey = NULL;
+
+	kfree(nic_dev->rss_indir);
+	nic_dev->rss_indir = NULL;
+}
+
+void hinic3_try_to_enable_rss(struct net_device *netdev)
+{
+	/* Completed by later submission due to LoC limit. */
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rss.h b/drivers/net/ethernet/huawei/hinic3/hinic3_rss.h
new file mode 100644
index 000000000000..4da23014d680
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rss.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_RSS_H
+#define HINIC3_RSS_H
+
+#include <linux/netdevice.h>
+
+void hinic3_try_to_enable_rss(struct net_device *netdev);
+void hinic3_clear_rss_config(struct net_device *netdev);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
new file mode 100644
index 000000000000..73b55217ab11
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
@@ -0,0 +1,401 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/etherdevice.h>
+#include <linux/if_vlan.h>
+
+#include "hinic3_rx.h"
+#include "hinic3_hwdev.h"
+#include "hinic3_nic_dev.h"
+#include "hinic3_nic_io.h"
+
+#define HINIC3_RX_HDR_SIZE              256
+#define HINIC3_RX_BUFFER_WRITE          16
+
+#define HINIC3_RX_TCP_PKT               0x3
+#define HINIC3_RX_UDP_PKT               0x4
+#define HINIC3_RX_SCTP_PKT              0x7
+
+#define HINIC3_RX_IPV4_PKT              0
+#define HINIC3_RX_IPV6_PKT              1
+#define HINIC3_RX_INVALID_IP_TYPE       2
+
+#define HINIC3_RX_PKT_FORMAT_NON_TUNNEL 0
+#define HINIC3_RX_PKT_FORMAT_VXLAN      1
+
+int hinic3_alloc_rxqs(struct net_device *netdev)
+{
+	/* Completed by later submission due to LoC limit. */
+	return -EFAULT;
+}
+
+void hinic3_free_rxqs(struct net_device *netdev)
+{
+	/* Completed by later submission due to LoC limit. */
+}
+
+static int rx_alloc_mapped_page(struct net_device *netdev, struct hinic3_rx_info *rx_info)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	dma_addr_t dma = rx_info->buf_dma_addr;
+	struct pci_dev *pdev = nic_dev->pdev;
+	struct page *page = rx_info->page;
+
+	if (likely(dma))
+		return 0;
+
+	page = alloc_pages_node(NUMA_NO_NODE, GFP_ATOMIC | __GFP_COMP,
+				nic_dev->page_order);
+	if (unlikely(!page))
+		return -ENOMEM;
+
+	dma = dma_map_page(&pdev->dev, page, 0, nic_dev->dma_rx_buff_size,
+			   DMA_FROM_DEVICE);
+	if (unlikely(dma_mapping_error(&pdev->dev, dma))) {
+		__free_pages(page, nic_dev->page_order);
+		return -ENOMEM;
+	}
+
+	rx_info->page = page;
+	rx_info->buf_dma_addr = dma;
+	rx_info->page_offset = 0;
+
+	return 0;
+}
+
+static void rq_wqe_buff_set(struct hinic3_io_queue *rq, uint32_t wqe_idx,
+			    dma_addr_t dma_addr, u16 len)
+{
+	struct hinic3_rq_wqe *rq_wqe;
+
+	rq_wqe = get_q_element(&rq->wq.qpages, wqe_idx, NULL);
+	rq_wqe->buf_hi_addr = upper_32_bits(dma_addr);
+	rq_wqe->buf_lo_addr = lower_32_bits(dma_addr);
+}
+
+static u32 hinic3_rx_fill_buffers(struct hinic3_rxq *rxq)
+{
+	struct net_device *netdev = rxq->netdev;
+	u32 i, free_wqebbs = rxq->delta - 1;
+	struct hinic3_nic_dev *nic_dev;
+	struct hinic3_rx_info *rx_info;
+	dma_addr_t dma_addr;
+	int err;
+
+	nic_dev = netdev_priv(netdev);
+	for (i = 0; i < free_wqebbs; i++) {
+		rx_info = &rxq->rx_info[rxq->next_to_update];
+
+		err = rx_alloc_mapped_page(netdev, rx_info);
+		if (unlikely(err))
+			break;
+
+		dma_addr = rx_info->buf_dma_addr + rx_info->page_offset;
+		rq_wqe_buff_set(rxq->rq, rxq->next_to_update, dma_addr,
+				nic_dev->rx_buff_len);
+		rxq->next_to_update = (u16)((rxq->next_to_update + 1) & rxq->q_mask);
+	}
+
+	if (likely(i)) {
+		hinic3_write_db(rxq->rq, rxq->q_id & 3, RQ_CFLAG_DP,
+				rxq->next_to_update << HINIC3_NORMAL_RQ_WQE);
+		rxq->delta -= i;
+		rxq->next_to_alloc = rxq->next_to_update;
+	}
+
+	return i;
+}
+
+static void hinic3_reuse_rx_page(struct hinic3_rxq *rxq,
+				 struct hinic3_rx_info *old_rx_info)
+{
+	struct hinic3_rx_info *new_rx_info;
+	u16 nta = rxq->next_to_alloc;
+
+	new_rx_info = &rxq->rx_info[nta];
+
+	/* update, and store next to alloc */
+	nta++;
+	rxq->next_to_alloc = (nta < rxq->q_depth) ? nta : 0;
+
+	new_rx_info->page = old_rx_info->page;
+	new_rx_info->page_offset = old_rx_info->page_offset;
+	new_rx_info->buf_dma_addr = old_rx_info->buf_dma_addr;
+
+	/* sync the buffer for use by the device */
+	dma_sync_single_range_for_device(rxq->dev, new_rx_info->buf_dma_addr,
+					 new_rx_info->page_offset,
+					 rxq->buf_len,
+					 DMA_FROM_DEVICE);
+}
+
+static void hinic3_add_rx_frag(struct hinic3_rxq *rxq,
+			       struct hinic3_rx_info *rx_info,
+			       struct sk_buff *skb, u32 size)
+{
+	struct page *page;
+	u8 *va;
+
+	page = rx_info->page;
+	va = (u8 *)page_address(page) + rx_info->page_offset;
+	prefetch(va);
+
+	dma_sync_single_range_for_cpu(rxq->dev,
+				      rx_info->buf_dma_addr,
+				      rx_info->page_offset,
+				      rxq->buf_len,
+				      DMA_FROM_DEVICE);
+
+	if (size <= HINIC3_RX_HDR_SIZE && !skb_is_nonlinear(skb)) {
+		memcpy(__skb_put(skb, size), va,
+		       ALIGN(size, sizeof(long)));
+
+		/* page is not reserved, we can reuse buffer as-is */
+		if (likely(page_to_nid(page) == numa_node_id()))
+			goto reuse_rx_page;
+
+		/* this page cannot be reused so discard it */
+		put_page(page);
+		goto err_reuse_buffer;
+	}
+
+	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page,
+			rx_info->page_offset, size, rxq->buf_len);
+
+	/* avoid re-using remote pages */
+	if (unlikely(page_to_nid(page) != numa_node_id()))
+		goto err_reuse_buffer;
+
+	/* if we are the only owner of the page we can reuse it */
+	if (unlikely(page_count(page) != 1))
+		goto err_reuse_buffer;
+
+	/* flip page offset to other buffer */
+	rx_info->page_offset ^= rxq->buf_len;
+	get_page(page);
+
+reuse_rx_page:
+	hinic3_reuse_rx_page(rxq, rx_info);
+	return;
+
+err_reuse_buffer:
+	/* we are not reusing the buffer so unmap it */
+	dma_unmap_page(rxq->dev, rx_info->buf_dma_addr, rxq->dma_rx_buff_size, DMA_FROM_DEVICE);
+}
+
+static void packaging_skb(struct hinic3_rxq *rxq, struct sk_buff *skb,
+			  u32 sge_num, u32 pkt_len)
+{
+	struct hinic3_rx_info *rx_info;
+	u32 temp_pkt_len = pkt_len;
+	u32 temp_sge_num = sge_num;
+	u32 sw_ci;
+	u32 size;
+
+	sw_ci = rxq->cons_idx & rxq->q_mask;
+	while (temp_sge_num) {
+		rx_info = &rxq->rx_info[sw_ci];
+		sw_ci = (sw_ci + 1) & rxq->q_mask;
+		if (unlikely(temp_pkt_len > rxq->buf_len)) {
+			size = rxq->buf_len;
+			temp_pkt_len -= rxq->buf_len;
+		} else {
+			size = temp_pkt_len;
+		}
+
+		hinic3_add_rx_frag(rxq, rx_info, skb, size);
+
+		/* clear contents of buffer_info */
+		rx_info->buf_dma_addr = 0;
+		rx_info->page = NULL;
+		temp_sge_num--;
+	}
+}
+
+static u32 hinic3_get_sge_num(struct hinic3_rxq *rxq, u32 pkt_len)
+{
+	u32 sge_num;
+
+	sge_num = pkt_len >> rxq->rx_buff_shift;
+	sge_num += (pkt_len & (rxq->buf_len - 1)) ? 1 : 0;
+
+	return sge_num;
+}
+
+static struct sk_buff *hinic3_fetch_rx_buffer(struct hinic3_rxq *rxq,
+					      u32 pkt_len)
+{
+	struct net_device *netdev = rxq->netdev;
+	struct sk_buff *skb;
+	u32 sge_num;
+
+	skb = netdev_alloc_skb_ip_align(netdev, HINIC3_RX_HDR_SIZE);
+	if (unlikely(!skb))
+		return NULL;
+
+	sge_num = hinic3_get_sge_num(rxq, pkt_len);
+
+	prefetchw(skb->data);
+	packaging_skb(rxq, skb, sge_num, pkt_len);
+
+	rxq->cons_idx += sge_num;
+	rxq->delta += sge_num;
+
+	return skb;
+}
+
+static void hinic3_pull_tail(struct sk_buff *skb)
+{
+	skb_frag_t *frag = &skb_shinfo(skb)->frags[0];
+	unsigned int pull_len;
+	unsigned char *va;
+
+	va = skb_frag_address(frag);
+
+	/* we need the header to contain the greater of either ETH_HLEN or
+	 * 60 bytes if the skb->len is less than 60 for skb_pad.
+	 */
+	pull_len = eth_get_headlen(skb->dev, va, HINIC3_RX_HDR_SIZE);
+
+	/* align pull length to size of long to optimize memcpy performance */
+	skb_copy_to_linear_data(skb, va, ALIGN(pull_len, sizeof(long)));
+
+	/* update all of the pointers */
+	skb_frag_size_sub(frag, pull_len);
+	skb_frag_off_add(frag, pull_len);
+
+	skb->data_len -= pull_len;
+	skb->tail += pull_len;
+}
+
+static void hinic3_rx_csum(struct hinic3_rxq *rxq, u32 offload_type,
+			   u32 status, struct sk_buff *skb)
+{
+	u32 pkt_fmt = RQ_CQE_OFFOLAD_TYPE_GET(offload_type, TUNNEL_PKT_FORMAT);
+	u32 pkt_type = RQ_CQE_OFFOLAD_TYPE_GET(offload_type, PKT_TYPE);
+	u32 ip_type = RQ_CQE_OFFOLAD_TYPE_GET(offload_type, IP_TYPE);
+	u32 csum_err = RQ_CQE_STATUS_GET(status, CSUM_ERR);
+	struct net_device *netdev = rxq->netdev;
+
+	if (!(netdev->features & NETIF_F_RXCSUM))
+		return;
+
+	if (unlikely(csum_err)) {
+		/* pkt type is recognized by HW, and csum is wrong */
+		skb->ip_summed = CHECKSUM_NONE;
+		return;
+	}
+
+	if (ip_type == HINIC3_RX_INVALID_IP_TYPE ||
+	    !(pkt_fmt == HINIC3_RX_PKT_FORMAT_NON_TUNNEL ||
+	      pkt_fmt == HINIC3_RX_PKT_FORMAT_VXLAN)) {
+		skb->ip_summed = CHECKSUM_NONE;
+		return;
+	}
+
+	switch (pkt_type) {
+	case HINIC3_RX_TCP_PKT:
+	case HINIC3_RX_UDP_PKT:
+	case HINIC3_RX_SCTP_PKT:
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+		break;
+	default:
+		skb->ip_summed = CHECKSUM_NONE;
+		break;
+	}
+}
+
+static void hinic3_lro_set_gso_params(struct sk_buff *skb, u16 num_lro)
+{
+	struct ethhdr *eth = (struct ethhdr *)(skb->data);
+	__be16 proto;
+
+	proto = __vlan_get_protocol(skb, eth->h_proto, NULL);
+
+	skb_shinfo(skb)->gso_size = (u16)DIV_ROUND_UP((skb->len - skb_headlen(skb)), num_lro);
+	skb_shinfo(skb)->gso_type = (proto == htons(ETH_P_IP)) ? SKB_GSO_TCPV4 : SKB_GSO_TCPV6;
+	skb_shinfo(skb)->gso_segs = num_lro;
+}
+
+static int recv_one_pkt(struct hinic3_rxq *rxq, struct hinic3_rq_cqe *rx_cqe,
+			u32 pkt_len, u32 vlan_len, u32 status)
+{
+	struct net_device *netdev = rxq->netdev;
+	struct sk_buff *skb;
+	u32 offload_type;
+	u16 num_lro;
+
+	skb = hinic3_fetch_rx_buffer(rxq, pkt_len);
+	if (unlikely(!skb))
+		return -ENOMEM;
+
+	/* place header in linear portion of buffer */
+	if (skb_is_nonlinear(skb))
+		hinic3_pull_tail(skb);
+
+	offload_type = rx_cqe->offload_type;
+	hinic3_rx_csum(rxq, offload_type, status, skb);
+
+	num_lro = RQ_CQE_STATUS_GET(status, NUM_LRO);
+	if (num_lro)
+		hinic3_lro_set_gso_params(skb, num_lro);
+
+	skb_record_rx_queue(skb, rxq->q_id);
+	skb->protocol = eth_type_trans(skb, netdev);
+
+	if (skb_has_frag_list(skb)) {
+		napi_gro_flush(&rxq->irq_cfg->napi, false);
+		netif_receive_skb(skb);
+	} else {
+		napi_gro_receive(&rxq->irq_cfg->napi, skb);
+	}
+
+	return 0;
+}
+
+#define LRO_PKT_HDR_LEN_IPV4    66
+#define LRO_PKT_HDR_LEN_IPV6    86
+#define LRO_PKT_HDR_LEN(cqe) \
+	(RQ_CQE_OFFOLAD_TYPE_GET((cqe)->offload_type, IP_TYPE) == \
+	 HINIC3_RX_IPV6_PKT ? LRO_PKT_HDR_LEN_IPV6 : LRO_PKT_HDR_LEN_IPV4)
+
+int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(rxq->netdev);
+	u32 sw_ci, status, pkt_len, vlan_len;
+	struct hinic3_rq_cqe *rx_cqe;
+	u32 num_wqe = 0;
+	int nr_pkts = 0;
+	u16 num_lro;
+
+	while (likely(nr_pkts < budget)) {
+		sw_ci = rxq->cons_idx & rxq->q_mask;
+		rx_cqe = rxq->cqe_arr + sw_ci;
+		status = rx_cqe->status;
+		if (!RQ_CQE_STATUS_GET(status, RXDONE))
+			break;
+
+		/* make sure we read rx_done before packet length */
+		rmb();
+
+		vlan_len = rx_cqe->vlan_len;
+		pkt_len = RQ_CQE_SGE_GET(vlan_len, LEN);
+		if (recv_one_pkt(rxq, rx_cqe, pkt_len, vlan_len, status))
+			break;
+
+		nr_pkts++;
+		num_lro = RQ_CQE_STATUS_GET(status, NUM_LRO);
+		if (num_lro)
+			num_wqe += hinic3_get_sge_num(rxq, pkt_len);
+
+		rx_cqe->status = 0;
+
+		if (num_wqe >= nic_dev->lro_replenish_thld)
+			break;
+	}
+
+	if (rxq->delta >= HINIC3_RX_BUFFER_WRITE)
+		hinic3_rx_fill_buffers(rxq);
+
+	return nr_pkts;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
new file mode 100644
index 000000000000..6a567647795e
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_RX_H
+#define HINIC3_RX_H
+
+#include <linux/netdevice.h>
+#include <linux/bitfield.h>
+
+#define RQ_CQE_OFFOLAD_TYPE_PKT_TYPE_MASK           GENMASK(4, 0)
+#define RQ_CQE_OFFOLAD_TYPE_IP_TYPE_MASK            GENMASK(6, 5)
+#define RQ_CQE_OFFOLAD_TYPE_TUNNEL_PKT_FORMAT_MASK  GENMASK(11, 8)
+#define RQ_CQE_OFFOLAD_TYPE_VLAN_EN_MASK            BIT(21)
+#define RQ_CQE_OFFOLAD_TYPE_GET(val, member) \
+	FIELD_GET(RQ_CQE_OFFOLAD_TYPE_##member##_MASK, val)
+
+#define RQ_CQE_SGE_VLAN_MASK  GENMASK(15, 0)
+#define RQ_CQE_SGE_LEN_MASK   GENMASK(31, 16)
+#define RQ_CQE_SGE_GET(val, member) \
+	FIELD_GET(RQ_CQE_SGE_##member##_MASK, val)
+
+#define RQ_CQE_STATUS_CSUM_ERR_MASK  GENMASK(15, 0)
+#define RQ_CQE_STATUS_NUM_LRO_MASK   GENMASK(23, 16)
+#define RQ_CQE_STATUS_RXDONE_MASK    BIT(31)
+#define RQ_CQE_STATUS_GET(val, member) \
+	FIELD_GET(RQ_CQE_STATUS_##member##_MASK, val)
+
+/* RX Completion information that is provided by HW for a specific RX WQE */
+struct hinic3_rq_cqe {
+	u32 status;
+	u32 vlan_len;
+	u32 offload_type;
+	u32 rsvd3;
+	u32 rsvd4;
+	u32 rsvd5;
+	u32 rsvd6;
+	u32 pkt_info;
+};
+
+struct hinic3_rq_wqe {
+	u32 buf_hi_addr;
+	u32 buf_lo_addr;
+	u32 cqe_hi_addr;
+	u32 cqe_lo_addr;
+};
+
+struct hinic3_rx_info {
+	dma_addr_t  buf_dma_addr;
+	struct page *page;
+	u32         page_offset;
+};
+
+struct hinic3_rxq {
+	struct net_device       *netdev;
+
+	u16                     q_id;
+	u32                     q_depth;
+	u32                     q_mask;
+
+	u16                     buf_len;
+	u32                     rx_buff_shift;
+	u32                     dma_rx_buff_size;
+
+	u32                     cons_idx;
+	u32                     delta;
+
+	u32                     irq_id;
+	u16                     msix_entry_idx;
+
+	/* cqe_arr and rx_info are arrays of rq_depth elements. Each element is
+	 * statically associated (by index) to a specific rq_wqe.
+	 */
+	struct hinic3_rq_cqe   *cqe_arr;
+	struct hinic3_rx_info  *rx_info;
+
+	struct hinic3_io_queue *rq;
+
+	struct hinic3_irq      *irq_cfg;
+	u16                    next_to_alloc;
+	u16                    next_to_update;
+	struct device          *dev; /* device for DMA mapping */
+
+	dma_addr_t             cqe_start_paddr;
+} ____cacheline_aligned;
+
+int hinic3_alloc_rxqs(struct net_device *netdev);
+void hinic3_free_rxqs(struct net_device *netdev);
+
+int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
new file mode 100644
index 000000000000..dfe96adab081
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c
@@ -0,0 +1,691 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/if_vlan.h>
+#include <linux/iopoll.h>
+#include <net/ipv6.h>
+
+#include "hinic3_tx.h"
+#include "hinic3_hwdev.h"
+#include "hinic3_nic_cfg.h"
+#include "hinic3_nic_dev.h"
+#include "hinic3_nic_io.h"
+#include "hinic3_wq.h"
+
+#define MAX_PAYLOAD_OFFSET         221
+#define MIN_SKB_LEN                32
+
+int hinic3_alloc_txqs(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	u16 q_id, num_txqs = nic_dev->max_qps;
+	struct pci_dev *pdev = nic_dev->pdev;
+	struct hinic3_txq *txq;
+	u64 txq_size;
+
+	txq_size = num_txqs * sizeof(*nic_dev->txqs);
+	if (!txq_size) {
+		dev_err(hwdev->dev, "Cannot allocate zero size txqs\n");
+		return -EINVAL;
+	}
+
+	nic_dev->txqs = kzalloc(txq_size, GFP_KERNEL);
+	if (!nic_dev->txqs)
+		return -ENOMEM;
+
+	for (q_id = 0; q_id < num_txqs; q_id++) {
+		txq = &nic_dev->txqs[q_id];
+		txq->netdev = netdev;
+		txq->q_id = q_id;
+		txq->q_depth = nic_dev->q_params.sq_depth;
+		txq->q_mask = nic_dev->q_params.sq_depth - 1;
+		txq->dev = &pdev->dev;
+	}
+
+	return 0;
+}
+
+void hinic3_free_txqs(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	kfree(nic_dev->txqs);
+}
+
+static void hinic3_set_buf_desc(struct hinic3_sq_bufdesc *buf_descs,
+				dma_addr_t addr, u32 len)
+{
+	buf_descs->hi_addr = upper_32_bits(addr);
+	buf_descs->lo_addr = lower_32_bits(addr);
+	buf_descs->len  = len;
+}
+
+static int tx_map_skb(struct net_device *netdev, struct sk_buff *skb,
+		      struct hinic3_txq *txq,
+		      struct hinic3_tx_info *tx_info,
+		      struct hinic3_sq_wqe_combo *wqe_combo)
+{
+	struct hinic3_sq_wqe_desc *wqe_desc = wqe_combo->ctrl_bd0;
+	struct hinic3_sq_bufdesc *buf_desc = wqe_combo->bds_head;
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_dma_info *dma_info = tx_info->dma_info;
+	struct pci_dev *pdev = nic_dev->pdev;
+	skb_frag_t *frag;
+	u32 j, i;
+	int err;
+
+	dma_info[0].dma = dma_map_single(&pdev->dev, skb->data, skb_headlen(skb), DMA_TO_DEVICE);
+	if (dma_mapping_error(&pdev->dev, dma_info[0].dma))
+		return -EFAULT;
+
+	dma_info[0].len = skb_headlen(skb);
+
+	wqe_desc->hi_addr = upper_32_bits(dma_info[0].dma);
+	wqe_desc->lo_addr = lower_32_bits(dma_info[0].dma);
+
+	wqe_desc->ctrl_len = dma_info[0].len;
+
+	for (i = 0; i < skb_shinfo(skb)->nr_frags;) {
+		frag = &(skb_shinfo(skb)->frags[i]);
+		if (unlikely(i == wqe_combo->first_bds_num))
+			buf_desc = wqe_combo->bds_sec2;
+
+		i++;
+		dma_info[i].dma = skb_frag_dma_map(&pdev->dev, frag, 0,
+						   skb_frag_size(frag),
+						   DMA_TO_DEVICE);
+		if (dma_mapping_error(&pdev->dev, dma_info[i].dma)) {
+			i--;
+			err = -EFAULT;
+			goto err_frag_map;
+		}
+		dma_info[i].len = skb_frag_size(frag);
+
+		hinic3_set_buf_desc(buf_desc, dma_info[i].dma,
+				    dma_info[i].len);
+		buf_desc++;
+	}
+
+	return 0;
+
+err_frag_map:
+	for (j = 0; j < i;) {
+		j++;
+		dma_unmap_page(&pdev->dev, dma_info[j].dma,
+			       dma_info[j].len, DMA_TO_DEVICE);
+	}
+	dma_unmap_single(&pdev->dev, dma_info[0].dma, dma_info[0].len,
+			 DMA_TO_DEVICE);
+	return err;
+}
+
+static void tx_unmap_skb(struct net_device *netdev,
+			 struct sk_buff *skb,
+			 struct hinic3_dma_info *dma_info)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct pci_dev *pdev = nic_dev->pdev;
+	int i;
+
+	for (i = 0; i < skb_shinfo(skb)->nr_frags;) {
+		i++;
+		dma_unmap_page(&pdev->dev,
+			       dma_info[i].dma,
+			       dma_info[i].len, DMA_TO_DEVICE);
+	}
+
+	dma_unmap_single(&pdev->dev, dma_info[0].dma,
+			 dma_info[0].len, DMA_TO_DEVICE);
+}
+
+static void tx_free_skb(struct net_device *netdev,
+			struct hinic3_tx_info *tx_info)
+{
+	tx_unmap_skb(netdev, tx_info->skb, tx_info->dma_info);
+	dev_kfree_skb_any(tx_info->skb);
+	tx_info->skb = NULL;
+}
+
+union hinic3_ip {
+	struct iphdr   *v4;
+	struct ipv6hdr *v6;
+	unsigned char  *hdr;
+};
+
+union hinic3_l4 {
+	struct tcphdr *tcp;
+	struct udphdr *udp;
+	unsigned char *hdr;
+};
+
+enum sq_l3_type {
+	UNKNOWN_L3TYPE               = 0,
+	IPV6_PKT                     = 1,
+	IPV4_PKT_NO_CHKSUM_OFFLOAD   = 2,
+	IPV4_PKT_WITH_CHKSUM_OFFLOAD = 3,
+};
+
+enum sq_l4offload_type {
+	OFFLOAD_DISABLE     = 0,
+	TCP_OFFLOAD_ENABLE  = 1,
+	SCTP_OFFLOAD_ENABLE = 2,
+	UDP_OFFLOAD_ENABLE  = 3,
+};
+
+/* initialize l4 offset and offload */
+static void get_inner_l4_info(struct sk_buff *skb, union hinic3_l4 *l4,
+			      u8 l4_proto, u32 *offset,
+			      enum sq_l4offload_type *l4_offload)
+{
+	switch (l4_proto) {
+	case IPPROTO_TCP:
+		*l4_offload = TCP_OFFLOAD_ENABLE;
+		/* To be same with TSO, payload offset begins from payload */
+		*offset = (l4->tcp->doff << TCP_HDR_DATA_OFF_UNIT_SHIFT) +
+			   TRANSPORT_OFFSET(l4->hdr, skb);
+		break;
+
+	case IPPROTO_UDP:
+		*l4_offload = UDP_OFFLOAD_ENABLE;
+		*offset = TRANSPORT_OFFSET(l4->hdr, skb);
+		break;
+	default:
+		*l4_offload = OFFLOAD_DISABLE;
+		*offset = 0;
+	}
+}
+
+static int hinic3_tx_csum(struct hinic3_txq *txq, struct hinic3_sq_task *task,
+			  struct sk_buff *skb)
+{
+	if (skb->ip_summed != CHECKSUM_PARTIAL)
+		return 0;
+
+	if (skb->encapsulation) {
+		union hinic3_ip ip;
+		u8 l4_proto;
+
+		task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, TUNNEL_FLAG);
+
+		ip.hdr = skb_network_header(skb);
+		if (ip.v4->version == 4) {
+			l4_proto = ip.v4->protocol;
+		} else if (ip.v4->version == 6) {
+			union hinic3_l4 l4;
+			unsigned char *exthdr;
+			__be16 frag_off;
+
+			exthdr = ip.hdr + sizeof(*ip.v6);
+			l4_proto = ip.v6->nexthdr;
+			l4.hdr = skb_transport_header(skb);
+			if (l4.hdr != exthdr)
+				ipv6_skip_exthdr(skb, exthdr - skb->data,
+						 &l4_proto, &frag_off);
+		} else {
+			l4_proto = IPPROTO_RAW;
+		}
+
+		if (l4_proto != IPPROTO_UDP ||
+		    ((struct udphdr *)skb_transport_header(skb))->dest != VXLAN_OFFLOAD_PORT_LE) {
+			/* Unsupported tunnel packet, disable csum offload */
+			skb_checksum_help(skb);
+			return 0;
+		}
+	}
+
+	task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, INNER_L4_EN);
+
+	return 1;
+}
+
+static void get_inner_l3_l4_type(struct sk_buff *skb, union hinic3_ip *ip,
+				 union hinic3_l4 *l4,
+				 enum sq_l3_type *l3_type, u8 *l4_proto)
+{
+	unsigned char *exthdr;
+	__be16 frag_off;
+
+	if (ip->v4->version == 4) {
+		*l3_type = IPV4_PKT_WITH_CHKSUM_OFFLOAD;
+		*l4_proto = ip->v4->protocol;
+	} else if (ip->v4->version == 6) {
+		*l3_type = IPV6_PKT;
+		exthdr = ip->hdr + sizeof(*ip->v6);
+		*l4_proto = ip->v6->nexthdr;
+		if (exthdr != l4->hdr) {
+			ipv6_skip_exthdr(skb, exthdr - skb->data,
+					 l4_proto, &frag_off);
+		}
+	} else {
+		*l3_type = UNKNOWN_L3TYPE;
+		*l4_proto = 0;
+	}
+}
+
+static void hinic3_set_tso_info(struct hinic3_sq_task *task, u32 *queue_info,
+				enum sq_l4offload_type l4_offload,
+				u32 offset, u32 mss)
+{
+	if (l4_offload == TCP_OFFLOAD_ENABLE) {
+		*queue_info |= SQ_CTRL_QUEUE_INFO_SET(1U, TSO);
+		task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, INNER_L4_EN);
+	} else if (l4_offload == UDP_OFFLOAD_ENABLE) {
+		*queue_info |= SQ_CTRL_QUEUE_INFO_SET(1U, UFO);
+		task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, INNER_L4_EN);
+	}
+
+	/* enable L3 calculation */
+	task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, INNER_L3_EN);
+
+	*queue_info |= SQ_CTRL_QUEUE_INFO_SET(offset >> 1, PLDOFF);
+
+	/* set MSS value */
+	*queue_info &= ~SQ_CTRL_QUEUE_INFO_MSS_MASK;
+	*queue_info |= SQ_CTRL_QUEUE_INFO_SET(mss, MSS);
+}
+
+static __sum16 csum_magic(union hinic3_ip *ip, unsigned short proto)
+{
+	return (ip->v4->version == 4) ?
+		csum_tcpudp_magic(ip->v4->saddr, ip->v4->daddr, 0, proto, 0) :
+		csum_ipv6_magic(&ip->v6->saddr, &ip->v6->daddr, 0, proto, 0);
+}
+
+static int hinic3_tso(struct hinic3_sq_task *task, u32 *queue_info,
+		      struct sk_buff *skb)
+{
+	enum sq_l4offload_type l4_offload;
+	enum sq_l3_type l3_type;
+	union hinic3_ip ip;
+	union hinic3_l4 l4;
+	u8 l4_proto;
+	u32 offset;
+	int err;
+
+	if (!skb_is_gso(skb))
+		return 0;
+
+	err = skb_cow_head(skb, 0);
+	if (err < 0)
+		return err;
+
+	if (skb->encapsulation) {
+		u32 gso_type = skb_shinfo(skb)->gso_type;
+		/* L3 checksum is always enabled */
+		task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, OUT_L3_EN);
+		task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, TUNNEL_FLAG);
+
+		l4.hdr = skb_transport_header(skb);
+		ip.hdr = skb_network_header(skb);
+
+		if (gso_type & SKB_GSO_UDP_TUNNEL_CSUM) {
+			l4.udp->check = ~csum_magic(&ip, IPPROTO_UDP);
+			task->pkt_info0 |= SQ_TASK_INFO0_SET(1U, OUT_L4_EN);
+		}
+
+		ip.hdr = skb_inner_network_header(skb);
+		l4.hdr = skb_inner_transport_header(skb);
+	} else {
+		ip.hdr = skb_network_header(skb);
+		l4.hdr = skb_transport_header(skb);
+	}
+
+	get_inner_l3_l4_type(skb, &ip, &l4, &l3_type, &l4_proto);
+
+	if (l4_proto == IPPROTO_TCP)
+		l4.tcp->check = ~csum_magic(&ip, IPPROTO_TCP);
+
+	get_inner_l4_info(skb, &l4, l4_proto, &offset, &l4_offload);
+
+	hinic3_set_tso_info(task, queue_info, l4_offload, offset,
+			    skb_shinfo(skb)->gso_size);
+
+	return 1;
+}
+
+static void hinic3_set_vlan_tx_offload(struct hinic3_sq_task *task,
+				       u16 vlan_tag, u8 vlan_tpid)
+{
+	/* vlan_tpid: 0=select TPID0 in IPSU, 1=select TPID1 in IPSU
+	 * 2=select TPID2 in IPSU, 3=select TPID3 in IPSU,
+	 * 4=select TPID4 in IPSU
+	 */
+	task->vlan_offload = SQ_TASK_INFO3_SET(vlan_tag, VLAN_TAG) |
+			     SQ_TASK_INFO3_SET(vlan_tpid, VLAN_TPID) |
+			     SQ_TASK_INFO3_SET(1U, VLAN_TAG_VALID);
+}
+
+static u32 hinic3_tx_offload(struct sk_buff *skb, struct hinic3_sq_task *task,
+			     u32 *queue_info, struct hinic3_txq *txq)
+{
+	u32 offload = 0;
+	int tso_cs_en;
+
+	task->pkt_info0 = 0;
+	task->ip_identify = 0;
+	task->rsvd = 0;
+	task->vlan_offload = 0;
+
+	tso_cs_en = hinic3_tso(task, queue_info, skb);
+	if (tso_cs_en < 0) {
+		offload = TX_OFFLOAD_INVALID;
+		return offload;
+	} else if (tso_cs_en) {
+		offload |= TX_OFFLOAD_TSO;
+	} else {
+		tso_cs_en = hinic3_tx_csum(txq, task, skb);
+		if (tso_cs_en)
+			offload |= TX_OFFLOAD_CSUM;
+	}
+
+#define VLAN_INSERT_MODE_MAX 5
+	if (unlikely(skb_vlan_tag_present(skb))) {
+		/* select vlan insert mode by qid, default 802.1Q Tag type */
+		hinic3_set_vlan_tx_offload(task, skb_vlan_tag_get(skb),
+					   txq->q_id % VLAN_INSERT_MODE_MAX);
+		offload |= TX_OFFLOAD_VLAN;
+	}
+
+	if (unlikely(SQ_CTRL_QUEUE_INFO_GET(*queue_info, PLDOFF) >
+		     MAX_PAYLOAD_OFFSET)) {
+		offload = TX_OFFLOAD_INVALID;
+		return offload;
+	}
+
+	return offload;
+}
+
+static int hinic3_maybe_stop_tx(struct hinic3_txq *txq, u16 wqebb_cnt)
+{
+	if (likely(hinic3_wq_free_wqebbs(&txq->sq->wq) >= wqebb_cnt))
+		return 0;
+
+	/* We need to check again in a case another CPU has just
+	 * made room available.
+	 */
+	netif_stop_subqueue(txq->netdev, txq->q_id);
+
+	if (likely(hinic3_wq_free_wqebbs(&txq->sq->wq) < wqebb_cnt))
+		return -EBUSY;
+
+	netif_start_subqueue(txq->netdev, txq->q_id);
+
+	return 0;
+}
+
+static u16 hinic3_get_and_update_sq_owner(struct hinic3_io_queue *sq,
+					  u16 curr_pi, u16 wqebb_cnt)
+{
+	u16 owner = sq->owner;
+
+	if (unlikely(curr_pi + wqebb_cnt >= sq->wq.q_depth))
+		sq->owner = !sq->owner;
+
+	return owner;
+}
+
+static u16 hinic3_set_wqe_combo(struct hinic3_txq *txq,
+				struct hinic3_sq_wqe_combo *wqe_combo,
+				u32 offload, u16 num_sge, u16 *curr_pi)
+{
+	struct hinic3_sq_bufdesc *second_part_wqebbs_addr;
+	u16 first_part_wqebbs_num, tmp_pi;
+	struct hinic3_sq_bufdesc *wqe;
+
+	wqe_combo->ctrl_bd0 = hinic3_wq_get_one_wqebb(&txq->sq->wq, curr_pi);
+	if (!offload && num_sge == 1) {
+		wqe_combo->wqe_type = SQ_WQE_COMPACT_TYPE;
+		return hinic3_get_and_update_sq_owner(txq->sq, *curr_pi, 1);
+	}
+
+	wqe_combo->wqe_type = SQ_WQE_EXTENDED_TYPE;
+
+	if (offload) {
+		wqe_combo->task = hinic3_wq_get_one_wqebb(&txq->sq->wq, &tmp_pi);
+		wqe_combo->task_type = SQ_WQE_TASKSECT_16BYTES;
+	} else {
+		wqe_combo->task_type = SQ_WQE_TASKSECT_46BITS;
+	}
+
+	if (num_sge > 1) {
+		/* first wqebb contain bd0, and bd size is equal to sq wqebb
+		 * size, so we use (num_sge - 1) as wanted weqbb_cnt
+		 */
+		hinic3_wq_get_multi_wqebbs(&txq->sq->wq, num_sge - 1, &tmp_pi,
+					   &wqe,
+					   &second_part_wqebbs_addr,
+					   &first_part_wqebbs_num);
+		wqe_combo->bds_head = wqe;
+		wqe_combo->bds_sec2 = second_part_wqebbs_addr;
+		wqe_combo->first_bds_num = first_part_wqebbs_num;
+	}
+
+	return hinic3_get_and_update_sq_owner(txq->sq, *curr_pi,
+					      num_sge + (u16)!!offload);
+}
+
+static void hinic3_prepare_sq_ctrl(struct hinic3_sq_wqe_combo *wqe_combo,
+				   u32 queue_info, int nr_descs, u16 owner)
+{
+	struct hinic3_sq_wqe_desc *wqe_desc = wqe_combo->ctrl_bd0;
+
+	if (wqe_combo->wqe_type == SQ_WQE_COMPACT_TYPE) {
+		wqe_desc->ctrl_len |=
+		    SQ_CTRL_SET(SQ_NORMAL_WQE, DATA_FORMAT) |
+		    SQ_CTRL_SET(wqe_combo->wqe_type, EXTENDED) |
+		    SQ_CTRL_SET(owner, OWNER);
+
+		/* compact wqe queue_info will transfer to chip */
+		wqe_desc->queue_info = 0;
+		return;
+	}
+
+	wqe_desc->ctrl_len |= SQ_CTRL_SET(nr_descs, BUFDESC_NUM) |
+			      SQ_CTRL_SET(wqe_combo->task_type, TASKSECT_LEN) |
+			      SQ_CTRL_SET(SQ_NORMAL_WQE, DATA_FORMAT) |
+			      SQ_CTRL_SET(wqe_combo->wqe_type, EXTENDED) |
+			      SQ_CTRL_SET(owner, OWNER);
+
+	wqe_desc->queue_info = queue_info;
+	wqe_desc->queue_info |= SQ_CTRL_QUEUE_INFO_SET(1U, UC);
+
+	if (!SQ_CTRL_QUEUE_INFO_GET(wqe_desc->queue_info, MSS)) {
+		wqe_desc->queue_info |=
+		    SQ_CTRL_QUEUE_INFO_SET(TX_MSS_DEFAULT, MSS);
+	} else if (SQ_CTRL_QUEUE_INFO_GET(wqe_desc->queue_info, MSS) <
+		   TX_MSS_MIN) {
+		/* mss should not be less than 80 */
+		wqe_desc->queue_info &= ~SQ_CTRL_QUEUE_INFO_MSS_MASK;
+		wqe_desc->queue_info |= SQ_CTRL_QUEUE_INFO_SET(TX_MSS_MIN, MSS);
+	}
+}
+
+static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,
+				       struct net_device *netdev,
+				       struct hinic3_txq *txq)
+{
+	struct hinic3_sq_wqe_combo wqe_combo = {};
+	struct hinic3_tx_info *tx_info;
+	u32 offload, queue_info = 0;
+	struct hinic3_sq_task task;
+	u16 wqebb_cnt, num_sge;
+	u16 saved_wq_prod_idx;
+	u16 owner, pi = 0;
+	u8 saved_sq_owner;
+	int err;
+
+	if (unlikely(skb->len < MIN_SKB_LEN)) {
+		if (skb_pad(skb, MIN_SKB_LEN - skb->len))
+			goto err_tx_skb_pad;
+
+		skb->len = MIN_SKB_LEN;
+	}
+
+	num_sge = skb_shinfo(skb)->nr_frags + 1;
+	/* assume normal wqe format + 1 wqebb for task info */
+	wqebb_cnt = num_sge + 1;
+	if (unlikely(hinic3_maybe_stop_tx(txq, wqebb_cnt)))
+		return NETDEV_TX_BUSY;
+
+	offload = hinic3_tx_offload(skb, &task, &queue_info, txq);
+	if (unlikely(offload == TX_OFFLOAD_INVALID)) {
+		goto tx_drop_pkts;
+	} else if (!offload) {
+		wqebb_cnt -= 1;
+		if (unlikely(num_sge == 1 && skb->len > COMPACET_WQ_SKB_MAX_LEN))
+			goto tx_drop_pkts;
+	}
+
+	saved_wq_prod_idx = txq->sq->wq.prod_idx;
+	saved_sq_owner = txq->sq->owner;
+
+	owner = hinic3_set_wqe_combo(txq, &wqe_combo, offload, num_sge, &pi);
+	if (offload)
+		*wqe_combo.task = task;
+
+	tx_info = &txq->tx_info[pi];
+	tx_info->skb = skb;
+	tx_info->wqebb_cnt = wqebb_cnt;
+
+	err = tx_map_skb(netdev, skb, txq, tx_info, &wqe_combo);
+	if (err) {
+		/* Rollback work queue to reclaim the wqebb we did not use */
+		txq->sq->wq.prod_idx = saved_wq_prod_idx;
+		txq->sq->owner = saved_sq_owner;
+		goto tx_drop_pkts;
+	}
+
+	hinic3_prepare_sq_ctrl(&wqe_combo, queue_info, num_sge, owner);
+	hinic3_write_db(txq->sq, 0, SQ_CFLAG_DP,
+			hinic3_get_sq_local_pi(txq->sq));
+
+	return NETDEV_TX_OK;
+
+tx_drop_pkts:
+	dev_kfree_skb_any(skb);
+
+err_tx_skb_pad:
+	return NETDEV_TX_OK;
+}
+
+netdev_tx_t hinic3_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u16 q_id = skb_get_queue_mapping(skb);
+	struct hinic3_txq *txq;
+
+	if (unlikely(!netif_carrier_ok(netdev))) {
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+
+	if (unlikely(q_id >= nic_dev->q_params.num_qps)) {
+		txq = &nic_dev->txqs[0];
+		goto tx_drop_pkts;
+	}
+	txq = &nic_dev->txqs[q_id];
+
+	return hinic3_send_one_skb(skb, netdev, txq);
+
+tx_drop_pkts:
+	dev_kfree_skb_any(skb);
+	return NETDEV_TX_OK;
+}
+
+static bool is_hw_complete_sq_process(struct hinic3_io_queue *sq)
+{
+	u16 sw_pi, hw_ci;
+
+	sw_pi = hinic3_get_sq_local_pi(sq);
+	hw_ci = hinic3_get_sq_hw_ci(sq);
+
+	return sw_pi == hw_ci;
+}
+
+#define HINIC3_FLUSH_QUEUE_POLL_SLEEP_US   10000
+#define HINIC3_FLUSH_QUEUE_POLL_TIMEOUT_US 10000000
+static int hinic3_stop_sq(struct hinic3_txq *txq)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(txq->netdev);
+	int err, rc;
+
+	err = read_poll_timeout(hinic3_force_drop_tx_pkt, rc,
+				is_hw_complete_sq_process(txq->sq) || rc,
+				HINIC3_FLUSH_QUEUE_POLL_SLEEP_US,
+				HINIC3_FLUSH_QUEUE_POLL_TIMEOUT_US,
+				true, nic_dev->hwdev);
+	if (rc)
+		return rc;
+	else
+		return err;
+}
+
+/* packet transmission should be stopped before calling this function */
+int hinic3_flush_txqs(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u16 qid;
+	int err;
+
+	for (qid = 0; qid < nic_dev->q_params.num_qps; qid++) {
+		err = hinic3_stop_sq(&nic_dev->txqs[qid]);
+		if (err)
+			netdev_err(netdev, "Failed to stop sq%u\n", qid);
+	}
+
+	return 0;
+}
+
+#define HINIC3_BDS_PER_SQ_WQEBB \
+	(HINIC3_SQ_WQEBB_SIZE / sizeof(struct hinic3_sq_bufdesc))
+
+int hinic3_tx_poll(struct hinic3_txq *txq, int budget)
+{
+	struct net_device *netdev = txq->netdev;
+	u16 hw_ci, sw_ci, q_id = txq->sq->q_id;
+	struct hinic3_nic_dev *nic_dev;
+	struct hinic3_tx_info *tx_info;
+	u16 wqebb_cnt = 0;
+	int pkts = 0;
+
+	nic_dev = netdev_priv(netdev);
+	hw_ci = hinic3_get_sq_hw_ci(txq->sq);
+	dma_rmb();
+	sw_ci = hinic3_get_sq_local_ci(txq->sq);
+
+	do {
+		tx_info = &txq->tx_info[sw_ci];
+
+		/* Did all wqebb of this wqe complete? */
+		if (hw_ci == sw_ci ||
+		    ((hw_ci - sw_ci) & txq->q_mask) < tx_info->wqebb_cnt)
+			break;
+
+		sw_ci = (sw_ci + tx_info->wqebb_cnt) & (u16)txq->q_mask;
+		prefetch(&txq->tx_info[sw_ci]);
+
+		wqebb_cnt += tx_info->wqebb_cnt;
+		pkts++;
+
+		tx_free_skb(netdev, tx_info);
+	} while (likely(pkts < budget));
+
+	hinic3_wq_put_wqebbs(&txq->sq->wq, wqebb_cnt);
+
+	if (unlikely(__netif_subqueue_stopped(netdev, q_id) &&
+		     hinic3_wq_free_wqebbs(&txq->sq->wq) >= 1 &&
+		     test_bit(HINIC3_INTF_UP, &nic_dev->flags))) {
+		struct netdev_queue *netdev_txq =
+				netdev_get_tx_queue(netdev, q_id);
+
+		__netif_tx_lock(netdev_txq, smp_processor_id());
+		/* avoid re-waking subqueue with xmit_frame */
+		if (__netif_subqueue_stopped(netdev, q_id))
+			netif_wake_subqueue(netdev, q_id);
+
+		__netif_tx_unlock(netdev_txq);
+	}
+
+	return pkts;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
new file mode 100644
index 000000000000..7b4cb4608353
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_TX_H
+#define HINIC3_TX_H
+
+#include <linux/netdevice.h>
+#include <linux/bitops.h>
+#include <net/checksum.h>
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+
+#define VXLAN_OFFLOAD_PORT_LE           cpu_to_be16(4789)
+
+#define COMPACET_WQ_SKB_MAX_LEN         16383
+
+#define TCP_HDR_DATA_OFF_UNIT_SHIFT     2
+#define TRANSPORT_OFFSET(l4_hdr, skb)   ((u32)((l4_hdr) - (skb)->data))
+
+enum tx_offload_type {
+	TX_OFFLOAD_TSO     = BIT(0),
+	TX_OFFLOAD_CSUM    = BIT(1),
+	TX_OFFLOAD_VLAN    = BIT(2),
+	TX_OFFLOAD_INVALID = BIT(3),
+	TX_OFFLOAD_ESP     = BIT(4),
+};
+
+enum sq_wqe_data_format {
+	SQ_NORMAL_WQE = 0,
+};
+
+enum sq_wqe_ec_type {
+	SQ_WQE_COMPACT_TYPE  = 0,
+	SQ_WQE_EXTENDED_TYPE = 1,
+};
+
+enum sq_wqe_tasksect_len_type {
+	SQ_WQE_TASKSECT_46BITS  = 0,
+	SQ_WQE_TASKSECT_16BYTES = 1,
+};
+
+#define SQ_CTRL_BUFDESC_NUM_MASK   GENMASK(26, 19)
+#define SQ_CTRL_TASKSECT_LEN_MASK  BIT(27)
+#define SQ_CTRL_DATA_FORMAT_MASK   BIT(28)
+#define SQ_CTRL_EXTENDED_MASK      BIT(30)
+#define SQ_CTRL_OWNER_MASK         BIT(31)
+#define SQ_CTRL_SET(val, member) \
+	FIELD_PREP(SQ_CTRL_##member##_MASK, val)
+
+#define SQ_CTRL_QUEUE_INFO_PLDOFF_MASK  GENMASK(9, 2)
+#define SQ_CTRL_QUEUE_INFO_UFO_MASK     BIT(10)
+#define SQ_CTRL_QUEUE_INFO_TSO_MASK     BIT(11)
+#define SQ_CTRL_QUEUE_INFO_MSS_MASK     GENMASK(26, 13)
+#define SQ_CTRL_QUEUE_INFO_UC_MASK      BIT(28)
+
+#define SQ_CTRL_QUEUE_INFO_SET(val, member) \
+	FIELD_PREP(SQ_CTRL_QUEUE_INFO_##member##_MASK, val)
+#define SQ_CTRL_QUEUE_INFO_GET(val, member) \
+	FIELD_GET(SQ_CTRL_QUEUE_INFO_##member##_MASK, val)
+
+#define SQ_TASK_INFO0_TUNNEL_FLAG_MASK  BIT(19)
+#define SQ_TASK_INFO0_INNER_L4_EN_MASK  BIT(24)
+#define SQ_TASK_INFO0_INNER_L3_EN_MASK  BIT(25)
+#define SQ_TASK_INFO0_OUT_L4_EN_MASK    BIT(27)
+#define SQ_TASK_INFO0_OUT_L3_EN_MASK    BIT(28)
+#define SQ_TASK_INFO0_SET(val, member) \
+	FIELD_PREP(SQ_TASK_INFO0_##member##_MASK, val)
+
+#define SQ_TASK_INFO3_VLAN_TAG_MASK        GENMASK(15, 0)
+#define SQ_TASK_INFO3_VLAN_TPID_MASK       GENMASK(18, 16)
+#define SQ_TASK_INFO3_VLAN_TAG_VALID_MASK  BIT(19)
+#define SQ_TASK_INFO3_SET(val, member) \
+	FIELD_PREP(SQ_TASK_INFO3_##member##_MASK, val)
+
+struct hinic3_sq_wqe_desc {
+	u32 ctrl_len;
+	u32 queue_info;
+	u32 hi_addr;
+	u32 lo_addr;
+};
+
+struct hinic3_sq_task {
+	u32 pkt_info0;
+	u32 ip_identify;
+	u32 rsvd;
+	u32 vlan_offload;
+};
+
+struct hinic3_sq_wqe_combo {
+	struct hinic3_sq_wqe_desc *ctrl_bd0;
+	struct hinic3_sq_task     *task;
+	struct hinic3_sq_bufdesc  *bds_head;
+	struct hinic3_sq_bufdesc  *bds_sec2;
+	u16                       first_bds_num;
+	u32                       wqe_type;
+	u32                       task_type;
+};
+
+struct hinic3_dma_info {
+	dma_addr_t dma;
+	u32        len;
+};
+
+struct hinic3_tx_info {
+	struct sk_buff         *skb;
+	u16                    wqebb_cnt;
+	struct hinic3_dma_info *dma_info;
+};
+
+struct hinic3_txq {
+	struct net_device       *netdev;
+	struct device           *dev;
+
+	u16                     q_id;
+	u32                     q_mask;
+	u32                     q_depth;
+
+	struct hinic3_tx_info   *tx_info;
+	struct hinic3_io_queue  *sq;
+} ____cacheline_aligned;
+
+int hinic3_alloc_txqs(struct net_device *netdev);
+void hinic3_free_txqs(struct net_device *netdev);
+
+netdev_tx_t hinic3_xmit_frame(struct sk_buff *skb, struct net_device *netdev);
+int hinic3_tx_poll(struct hinic3_txq *txq, int budget);
+int hinic3_flush_txqs(struct net_device *netdev);
+
+#endif
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_wq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_wq.c
new file mode 100644
index 000000000000..e4ed790f3de1
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_wq.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved.
+
+#include <linux/dma-mapping.h>
+
+#include "hinic3_wq.h"
+#include "hinic3_hwdev.h"
+
+void hinic3_wq_get_multi_wqebbs(struct hinic3_wq *wq,
+				u16 num_wqebbs, u16 *prod_idx,
+				struct hinic3_sq_bufdesc **first_wqebb,
+				struct hinic3_sq_bufdesc **second_part_wqebbs_addr,
+				u16 *first_part_wqebbs_num)
+{
+	u32 idx, remaining;
+
+	idx = wq->prod_idx & wq->idx_mask;
+	wq->prod_idx += num_wqebbs;
+	*prod_idx = idx;
+	*first_wqebb = get_q_element(&wq->qpages, idx, &remaining);
+	if (likely(remaining >= num_wqebbs)) {
+		*first_part_wqebbs_num = num_wqebbs;
+		*second_part_wqebbs_addr = NULL;
+	} else {
+		*first_part_wqebbs_num = remaining;
+		idx += remaining;
+		*second_part_wqebbs_addr = get_q_element(&wq->qpages, idx, NULL);
+	}
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_wq.h b/drivers/net/ethernet/huawei/hinic3/hinic3_wq.h
new file mode 100644
index 000000000000..ca33f4176eea
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_wq.h
@@ -0,0 +1,75 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2024. All rights reserved. */
+
+#ifndef HINIC3_WQ_H
+#define HINIC3_WQ_H
+
+#include <linux/io.h>
+#include "hinic3_queue_common.h"
+
+struct hinic3_sq_bufdesc {
+	/* 31-bits Length, L2NIC only uses length[17:0] */
+	u32 len;
+	u32 rsvd;
+	u32 hi_addr;
+	u32 lo_addr;
+};
+
+/* Work queue is used to submit elements (tx, rx, cmd) to hw.
+ * Driver is the producer that advances prod_idx. cons_idx is advanced when
+ * HW reports completions of previously submitted elements.
+ */
+struct hinic3_wq {
+	struct hinic3_queue_pages qpages;
+	/* Unmasked producer/consumer indices that are advanced to natural
+	 * integer overflow regardless of queue depth.
+	 */
+	u16                       cons_idx;
+	u16                       prod_idx;
+
+	u32                       q_depth;
+	u16                       idx_mask;
+
+	/* Work Queue (logical WQEBB array) is mapped to hw via Chip Logical
+	 * Address (CLA) using 1 of 2 levels:
+	 *     level 0 - direct mapping of single wq page
+	 *     level 1 - indirect mapping of multiple pages via additional page
+	 *               table.
+	 * When wq uses level 1, wq_block will hold the allocated indirection
+	 * table.
+	 */
+	dma_addr_t                wq_block_paddr;
+	__be64                    *wq_block_vaddr;
+} ____cacheline_aligned;
+
+/* Get number of elements in work queue that are in-use. */
+static inline u16 hinic3_wq_get_used(const struct hinic3_wq *wq)
+{
+	return wq->prod_idx - wq->cons_idx;
+}
+
+static inline u16 hinic3_wq_free_wqebbs(struct hinic3_wq *wq)
+{
+	/* Don't allow queue to become completely full, report (free - 1). */
+	return wq->q_depth - hinic3_wq_get_used(wq) - 1;
+}
+
+static inline void *hinic3_wq_get_one_wqebb(struct hinic3_wq *wq, u16 *pi)
+{
+	*pi = wq->prod_idx & wq->idx_mask;
+	wq->prod_idx++;
+	return get_q_element(&wq->qpages, *pi, NULL);
+}
+
+static inline void hinic3_wq_put_wqebbs(struct hinic3_wq *wq, u16 num_wqebbs)
+{
+	wq->cons_idx += num_wqebbs;
+}
+
+void hinic3_wq_get_multi_wqebbs(struct hinic3_wq *wq,
+				u16 num_wqebbs, u16 *prod_idx,
+				struct hinic3_sq_bufdesc **first_wqebb,
+				struct hinic3_sq_bufdesc **second_part_wqebbs_addr,
+				u16 *first_part_wqebbs_num);
+
+#endif
-- 
2.45.2


