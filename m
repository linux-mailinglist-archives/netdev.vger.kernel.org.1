Return-Path: <netdev+bounces-215175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A17B2D74C
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 10:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E97481BA8374
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 08:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD53D2D9788;
	Wed, 20 Aug 2025 08:56:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24012D9ED7;
	Wed, 20 Aug 2025 08:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680167; cv=none; b=AqVAqbApmCMI8WxE2iEDWr9DfsfZpr5QiKxgM4JrWUuumLIOUPOk5v+nQQWPzi5xMzIcx8bhJnirWJX8y2iz58H78knYCVyxhgQMRZyl14B/PI6l6GxEk+yoles4HgUU0f4fnL75FUF3ZKb+mWoIgkQMEAXR1RhvypnVKAWvdgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680167; c=relaxed/simple;
	bh=Oa1MLPlRQynULpEqvH73YEboBl1nBFJK5IJ20D1q2O8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SUPKvWdZ+szGjWwBbVb2pqNXwkL4hO36QDznECRBFL6iKAd/TcsBkravCDnjuHX5Apq0NIHmvW4/R8reX8mGfHo1643JwCWQ1X6Syc1NC4pM8HnIbnJmqNhpSIhgL7voIwip8EGbOCU0U6dfLLSSNW6SFAa/w1w2f5UKD0iV4fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4c6Kwj2hRKz2TSvg;
	Wed, 20 Aug 2025 16:53:09 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 594151A016C;
	Wed, 20 Aug 2025 16:55:58 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.55) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 20 Aug 2025 16:55:56 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Gur Stavi <gur.stavi@huawei.com>, Fan Gong <gongfan1@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas
	<helgaas@kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
	<guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>, Lee Trager
	<lee@trager.us>, Michael Ellerman <mpe@ellerman.id.au>, Suman Ghosh
	<sumang@marvell.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, Joe
 Damato <jdamato@fastly.com>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>
Subject: [PATCH net-next v14 1/1] hinic3: module initialization and tx/rx  logic
Date: Wed, 20 Aug 2025 16:55:26 +0800
Message-ID: <35f370e77ceaec7ebff5e160e9daee2f9c7b98f0.1746689795.git.gur.stavi@huawei.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1746689795.git.gur.stavi@huawei.com>
References: <cover.1746689795.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100013.china.huawei.com (7.202.181.12)

This is [1/3] part of hinic3 Ethernet driver initial submission.=0D
With this patch hinic3 is a valid kernel module but non-functional=0D
driver.=0D
=0D
The driver parts contained in this patch:=0D
Module initialization.=0D
PCI driver registration but with empty id_table.=0D
Auxiliary driver registration.=0D
Net device_ops registration but open/stop are empty stubs.=0D
tx/rx logic.=0D
=0D
All major data structures of the driver are fully introduced with the=0D
code that uses them but without their initialization code that requires=0D
management interface with the hw.=0D
=0D
Co-developed-by: Xin Guo <guoxin09@huawei.com>=0D
Signed-off-by: Xin Guo <guoxin09@huawei.com>=0D
Signed-off-by: Fan Gong <gongfan1@huawei.com>=0D
Co-developed-by: Gur Stavi <gur.stavi@huawei.com>=0D
Signed-off-by: Gur Stavi <gur.stavi@huawei.com>=0D
---=0D
 .../device_drivers/ethernet/huawei/hinic3.rst | 137 ++++=0D
 .../device_drivers/ethernet/index.rst         |   1 +=0D
 MAINTAINERS                                   |   7 +=0D
 drivers/net/ethernet/huawei/Kconfig           |   1 +=0D
 drivers/net/ethernet/huawei/Makefile          |   1 +=0D
 drivers/net/ethernet/huawei/hinic3/Kconfig    |  20 +=0D
 drivers/net/ethernet/huawei/hinic3/Makefile   |  21 +=0D
 .../ethernet/huawei/hinic3/hinic3_common.c    |  53 ++=0D
 .../ethernet/huawei/hinic3/hinic3_common.h    |  27 +=0D
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.c    |  25 +=0D
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.h    |  53 ++=0D
 .../ethernet/huawei/hinic3/hinic3_hw_comm.c   |  32 +=0D
 .../ethernet/huawei/hinic3/hinic3_hw_comm.h   |  13 +=0D
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   | 113 +++=0D
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.c |  24 +=0D
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.h |  81 +++=0D
 .../net/ethernet/huawei/hinic3/hinic3_hwif.c  |  21 +=0D
 .../net/ethernet/huawei/hinic3/hinic3_hwif.h  |  58 ++=0D
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   |  53 ++=0D
 .../net/ethernet/huawei/hinic3/hinic3_lld.c   | 414 +++++++++++=0D
 .../net/ethernet/huawei/hinic3/hinic3_lld.h   |  21 +=0D
 .../net/ethernet/huawei/hinic3/hinic3_main.c  | 357 +++++++++=0D
 .../net/ethernet/huawei/hinic3/hinic3_mbox.c  |  16 +=0D
 .../net/ethernet/huawei/hinic3/hinic3_mbox.h  |  15 +=0D
 .../net/ethernet/huawei/hinic3/hinic3_mgmt.h  |  13 +=0D
 .../huawei/hinic3/hinic3_mgmt_interface.h     | 105 +++=0D
 .../huawei/hinic3/hinic3_netdev_ops.c         |  78 ++=0D
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   | 233 ++++++=0D
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |  41 ++=0D
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |  89 +++=0D
 .../ethernet/huawei/hinic3/hinic3_nic_io.c    |  21 +=0D
 .../ethernet/huawei/hinic3/hinic3_nic_io.h    | 120 ++++=0D
 .../huawei/hinic3/hinic3_queue_common.c       |  68 ++=0D
 .../huawei/hinic3/hinic3_queue_common.h       |  54 ++=0D
 .../net/ethernet/huawei/hinic3/hinic3_rx.c    | 341 +++++++++=0D
 .../net/ethernet/huawei/hinic3/hinic3_rx.h    |  90 +++=0D
 .../net/ethernet/huawei/hinic3/hinic3_tx.c    | 678 ++++++++++++++++++=0D
 .../net/ethernet/huawei/hinic3/hinic3_tx.h    | 131 ++++=0D
 .../net/ethernet/huawei/hinic3/hinic3_wq.c    |  29 +=0D
 .../net/ethernet/huawei/hinic3/hinic3_wq.h    |  76 ++=0D
 40 files changed, 3731 insertions(+)=0D
=0D
diff --git a/Documentation/networking/device_drivers/ethernet/huawei/hinic3=
.rst b/Documentation/networking/device_drivers/ethernet/huawei/hinic3.rst=0D
new file mode 100644=0D
index 000000000000..e3dfd083fa52=0D
--- /dev/null=0D
+++ b/Documentation/networking/device_drivers/ethernet/huawei/hinic3.rst=0D
@@ -0,0 +1,137 @@=0D
+.. SPDX-License-Identifier: GPL-2.0=0D
+=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+Linux kernel driver for Huawei Ethernet Device Driver (hinic3) family=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+=0D
+Overview=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=0D
+=0D
+The hinic3 is a network interface card (NIC) for Data Center. It supports=
=0D
+a range of link-speed devices (10GE, 25GE, 100GE, etc.). The hinic3=0D
+devices can have multiple physical forms: LOM (Lan on Motherboard) NIC,=0D
+PCIe standard NIC, OCP (Open Compute Project) NIC, etc.=0D
+=0D
+The hinic3 driver supports the following features:=0D
+- IPv4/IPv6 TCP/UDP checksum offload=0D
+- TSO (TCP Segmentation Offload), LRO (Large Receive Offload)=0D
+- RSS (Receive Side Scaling)=0D
+- MSI-X interrupt aggregation configuration and interrupt adaptation.=0D
+- SR-IOV (Single Root I/O Virtualization).=0D
+=0D
+Content=0D
+=3D=3D=3D=3D=3D=3D=3D=0D
+=0D
+- Supported PCI vendor ID/device IDs=0D
+- Source Code Structure of Hinic3 Driver=0D
+- Management Interface=0D
+=0D
+Supported PCI vendor ID/device IDs=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+=0D
+19e5:0222 - hinic3 PF/PPF=0D
+19e5:375F - hinic3 VF=0D
+=0D
+Prime Physical Function (PPF) is responsible for the management of the=0D
+whole NIC card. For example, clock synchronization between the NIC and=0D
+the host. Any PF may serve as a PPF. The PPF is selected dynamically.=0D
+=0D
+Source Code Structure of Hinic3 Driver=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+hinic3_pci_id_tbl.h       Supported device IDs=0D
+hinic3_hw_intf.h          Interface between HW and driver=0D
+hinic3_queue_common.[ch]  Common structures and methods for NIC queues=0D
+hinic3_common.[ch]        Encapsulation of memory operations in Linux=0D
+hinic3_csr.h              Register definitions in the BAR=0D
+hinic3_hwif.[ch]          Interface for BAR=0D
+hinic3_eqs.[ch]           Interface for AEQs and CEQs=0D
+hinic3_mbox.[ch]          Interface for mailbox=0D
+hinic3_mgmt.[ch]          Management interface based on mailbox and AEQ=0D
+hinic3_wq.[ch]            Work queue data structures and interface=0D
+hinic3_cmdq.[ch]          Command queue is used to post command to HW=0D
+hinic3_hwdev.[ch]         HW structures and methods abstractions=0D
+hinic3_lld.[ch]           Auxiliary driver adaptation layer=0D
+hinic3_hw_comm.[ch]       Interface for common HW operations=0D
+hinic3_mgmt_interface.h   Interface between firmware and driver=0D
+hinic3_hw_cfg.[ch]        Interface for HW configuration=0D
+hinic3_irq.c              Interrupt request=0D
+hinic3_netdev_ops.c       Operations registered to Linux kernel stack=0D
+hinic3_nic_dev.h          NIC structures and methods abstractions=0D
+hinic3_main.c             Main Linux kernel driver=0D
+hinic3_nic_cfg.[ch]       NIC service configuration=0D
+hinic3_nic_io.[ch]        Management plane interface for TX and RX=0D
+hinic3_rss.[ch]           Interface for Receive Side Scaling (RSS)=0D
+hinic3_rx.[ch]            Interface for transmit=0D
+hinic3_tx.[ch]            Interface for receive=0D
+hinic3_ethtool.c          Interface for ethtool operations (ops)=0D
+hinic3_filter.c           Interface for MAC address=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+=0D
+Management Interface=0D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D
+=0D
+Asynchronous Event Queue (AEQ)=0D
+------------------------------=0D
+=0D
+AEQ receives high priority events from the HW over a descriptor queue.=0D
+Every descriptor is a fixed size of 64 bytes. AEQ can receive solicited or=
=0D
+unsolicited events. Every device, VF or PF, can have up to 4 AEQs.=0D
+Every AEQ is associated to a dedicated IRQ. AEQ can receive multiple types=
=0D
+of events, but in practice the hinic3 driver ignores all events except for=
=0D
+2 mailbox related events.=0D
+=0D
+Mailbox=0D
+-------=0D
+=0D
+Mailbox is a communication mechanism between the hinic3 driver and the HW.=
=0D
+Each device has an independent mailbox. Driver can use the mailbox to send=
=0D
+requests to management. Driver receives mailbox messages, such as response=
s=0D
+to requests, over the AEQ (using event HINIC3_AEQ_FOR_MBOX). Due to the=0D
+limited size of mailbox data register, mailbox messages are sent=0D
+segment-by-segment.=0D
+=0D
+Every device can use its mailbox to post request to firmware. The mailbox=
=0D
+can also be used to post requests and responses between the PF and its VFs=
.=0D
+=0D
+Completion Event Queue (CEQ)=0D
+----------------------------=0D
+=0D
+The implementation of CEQ is the same as AEQ. It receives completion event=
s=0D
+from HW over a fixed size descriptor of 32 bits. Every device can have up=
=0D
+to 32 CEQs. Every CEQ has a dedicated IRQ. CEQ only receives solicited=0D
+events that are responses to requests from the driver. CEQ can receive=0D
+multiple types of events, but in practice the hinic3 driver ignores all=0D
+events except for HINIC3_CMDQ that represents completion of previously=0D
+posted commands on a cmdq.=0D
+=0D
+Command Queue (cmdq)=0D
+--------------------=0D
+=0D
+Every cmdq has a dedicated work queue on which commands are posted.=0D
+Commands on the work queue are fixed size descriptor of size 64 bytes.=0D
+Completion of a command will be indicated using ctrl bits in the=0D
+descriptor that carried the command. Notification of command completions=0D
+will also be provided via event on CEQ. Every device has 4 command queues=
=0D
+that are initialized as a set (called cmdqs), each with its own type.=0D
+Hinic3 driver only uses type HINIC3_CMDQ_SYNC.=0D
+=0D
+Work Queues(WQ)=0D
+---------------=0D
+=0D
+Work queues are logical arrays of fixed size WQEs. The array may be spread=
=0D
+over multiple non-contiguous pages using indirection table. Work queues ar=
e=0D
+used by I/O queues and command queues.=0D
+=0D
+Global function ID=0D
+------------------=0D
+=0D
+Every function, PF or VF, has a unique ordinal identification within the d=
evice.=0D
+Many management commands (mbox or cmdq) contain this ID so HW can apply th=
e=0D
+command effect to the right function.=0D
+=0D
+PF is allowed to post management commands to a subordinate VF by specifyin=
g the=0D
+VFs ID. A VF must provide its own ID. Anti-spoofing in the HW will cause=0D
+command from a VF to fail if it contains the wrong ID.=0D
+=0D
diff --git a/Documentation/networking/device_drivers/ethernet/index.rst b/D=
ocumentation/networking/device_drivers/ethernet/index.rst=0D
index f9ed93c1da35..139b4c75a191 100644=0D
--- a/Documentation/networking/device_drivers/ethernet/index.rst=0D
+++ b/Documentation/networking/device_drivers/ethernet/index.rst=0D
@@ -28,6 +28,7 @@ Contents:=0D
    freescale/gianfar=0D
    google/gve=0D
    huawei/hinic=0D
+   huawei/hinic3=0D
    intel/e100=0D
    intel/e1000=0D
    intel/e1000e=0D
diff --git a/MAINTAINERS b/MAINTAINERS=0D
index 5c31814c9687..ff477b32ae9f 100644=0D
--- a/MAINTAINERS=0D
+++ b/MAINTAINERS=0D
@@ -10953,6 +10953,13 @@ S:	Maintained=0D
 F:	Documentation/networking/device_drivers/ethernet/huawei/hinic.rst=0D
 F:	drivers/net/ethernet/huawei/hinic/=0D
 =0D
+HUAWEI 3RD GEN ETHERNET DRIVER=0D
+M:	Fan Gong <gongfan1@huawei.com>=0D
+L:	netdev@vger.kernel.org=0D
+S:	Maintained=0D
+F:	Documentation/networking/device_drivers/ethernet/huawei/hinic3.rst=0D
+F:	drivers/net/ethernet/huawei/hinic3/=0D
+=0D
 HUAWEI MATEBOOK E GO EMBEDDED CONTROLLER DRIVER=0D
 M:	Pengyu Luo <mitltlatltl@gmail.com>=0D
 S:	Maintained=0D
diff --git a/drivers/net/ethernet/huawei/Kconfig b/drivers/net/ethernet/hua=
wei/Kconfig=0D
index c05fce15eb51..7d0feb1da158 100644=0D
--- a/drivers/net/ethernet/huawei/Kconfig=0D
+++ b/drivers/net/ethernet/huawei/Kconfig=0D
@@ -16,5 +16,6 @@ config NET_VENDOR_HUAWEI=0D
 if NET_VENDOR_HUAWEI=0D
 =0D
 source "drivers/net/ethernet/huawei/hinic/Kconfig"=0D
+source "drivers/net/ethernet/huawei/hinic3/Kconfig"=0D
 =0D
 endif # NET_VENDOR_HUAWEI=0D
diff --git a/drivers/net/ethernet/huawei/Makefile b/drivers/net/ethernet/hu=
awei/Makefile=0D
index 2549ad5afe6d..59865b882879 100644=0D
--- a/drivers/net/ethernet/huawei/Makefile=0D
+++ b/drivers/net/ethernet/huawei/Makefile=0D
@@ -4,3 +4,4 @@=0D
 #=0D
 =0D
 obj-$(CONFIG_HINIC) +=3D hinic/=0D
+obj-$(CONFIG_HINIC3) +=3D hinic3/=0D
diff --git a/drivers/net/ethernet/huawei/hinic3/Kconfig b/drivers/net/ether=
net/huawei/hinic3/Kconfig=0D
new file mode 100644=0D
index 000000000000..ce4331d1387b=0D
--- /dev/null=0D
+++ b/drivers/net/ethernet/huawei/hinic3/Kconfig=0D
@@ -0,0 +1,20 @@=0D
+# SPDX-License-Identifier: GPL-2.0-only=0D
+#=0D
+# Huawei driver configuration=0D
+#=0D
+=0D
+config HINIC3=0D
+	tristate "Huawei 3rd generation network adapters (HINIC3) support"=0D
+	# Fields of HW and management structures are little endian and are=0D
+	# currently not converted=0D
+	depends on !CPU_BIG_ENDIAN=0D
+	depends on X86 || ARM64 || COMPILE_TEST=0D
+	depends on PCI_MSI && 64BIT=0D
+	select AUXILIARY_BUS=0D
+	select PAGE_POOL=0D
+	help=0D
+	  This driver supports HiNIC 3rd gen Network Adapter (HINIC3).=0D
+	  The driver is supported on X86_64 and ARM64 little endian.=0D
+=0D
+	  To compile this driver as a module, choose M here.=0D
+	  The module will be called hinic3.=0D
diff --git a/drivers/net/ethernet/huawei/hinic3/Makefile b/drivers/net/ethe=
rnet/huawei/hinic3/Makefile=0D
new file mode 100644=0D
index 000000000000..509dfbfb0e96=0D
--- /dev/null=0D
+++ b/drivers/net/ethernet/huawei/hinic3/Makefile=0D
@@ -0,0 +1,21 @@=0D
+# SPDX-License-Identifier: GPL-2.0=0D
+# Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.=0D
+=0D
+obj-$(CONFIG_HINIC3) +=3D hinic3.o=0D
+=0D
+hinic3-objs :=3D hinic3_common.o \=0D
+	       hinic3_hw_cfg.o \=0D
+	       hinic3_hw_comm.o \=0D
+	       hinic3_hwdev.o \=0D
+	       hinic3_hwif.o \=0D
+	       hinic3_irq.o \=0D
+	       hinic3_lld.o \=0D
+	       hinic3_main.o \=0D
+	       hinic3_mbox.o \=0D
+	       hinic3_netdev_ops.o \=0D
+	       hinic3_nic_cfg.o \=0D
+	       hinic3_nic_io.o \=0D
+	       hinic3_queue_common.o \=0D
+	       hinic3_rx.o \=0D
+	       hinic3_tx.o \=0D
+	       hinic3_wq.o=0D
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_common.c b/drivers/n=
et/ethernet/huawei/hinic3/hinic3_common.c=0D
new file mode 100644=0D
index 000000000000..0aa42068728c=0D
--- /dev/null=0D
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_common.c=0D
@@ -0,0 +1,53 @@=0D
+// SPDX-License-Identifier: GPL-2.0=0D
+// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.=
=0D
+=0D
+#include <linux/delay.h>=0D
+#include <linux/dma-mapping.h>=0D
+=0D
+#include "hinic3_common.h"=0D
+=0D
+int hinic3_dma_zalloc_coherent_align(struct device *dev, u32 size, u32 ali=
gn,=0D
+				     gfp_t flag,=0D
+				     struct hinic3_dma_addr_align *mem_align)=0D
+{=0D
+	dma_addr_t paddr, align_paddr;=0D
+	void *vaddr, *align_vaddr;=0D
+	u32 real_size =3D size;=0D
+=0D
+	vaddr =3D dma_alloc_coherent(dev, real_size, &paddr, flag);=0D
+	if (!vaddr)=0D
+		return -ENOMEM;=0D
+=0D
+	align_paddr =3D ALIGN(paddr, align);=0D
+	if (align_paddr =3D=3D paddr) {=0D
+		align_vaddr =3D vaddr;=0D
+		goto out;=0D
+	}=0D
+=0D
+	dma_free_coherent(dev, real_size, vaddr, paddr);=0D
+=0D
+	/* realloc memory for align */=0D
+	real_size =3D size + align;=0D
+	vaddr =3D dma_alloc_coherent(dev, real_size, &paddr, flag);=0D
+	if (!vaddr)=0D
+		return -ENOMEM;=0D
+=0D
+	align_paddr =3D ALIGN(paddr, align);=0D
+	align_vaddr =3D vaddr + (align_paddr - paddr);=0D
+=0D
+out:=0D
+	mem_align->real_size =3D real_size;=0D
+	mem_align->ori_vaddr =3D vaddr;=0D
+	mem_align->ori_paddr =3D paddr;=0D
+	mem_align->align_vaddr =3D align_vaddr;=0D
+	mem_align->align_paddr =3D align_paddr;=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+void hinic3_dma_free_coherent_align(struct device *dev,=0D
+				    struct hinic3_dma_addr_align *mem_align)=0D
+{=0D
+	dma_free_coherent(dev, mem_align->real_size,=0D
+			  mem_align->ori_vaddr, mem_align->ori_paddr);=0D
+}=0D
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_common.h b/drivers/n=
et/ethernet/huawei/hinic3/hinic3_common.h=0D
new file mode 100644=0D
index 000000000000..bb795dace04c=0D
--- /dev/null=0D
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_common.h=0D
@@ -0,0 +1,27 @@=0D
+/* SPDX-License-Identifier: GPL-2.0 */=0D
+/* Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved. =
*/=0D
+=0D
+#ifndef _HINIC3_COMMON_H_=0D
+#define _HINIC3_COMMON_H_=0D
+=0D
+#include <linux/device.h>=0D
+=0D
+#define HINIC3_MIN_PAGE_SIZE  0x1000=0D
+=0D
+struct hinic3_dma_addr_align {=0D
+	u32        real_size;=0D
+=0D
+	void       *ori_vaddr;=0D
+	dma_addr_t ori_paddr;=0D
+=0D
+	void       *align_vaddr;=0D
+	dma_addr_t align_paddr;=0D
+};=0D
+=0D
+int hinic3_dma_zalloc_coherent_align(struct device *dev, u32 size, u32 ali=
gn,=0D
+				     gfp_t flag,=0D
+				     struct hinic3_dma_addr_align *mem_align);=0D
+void hinic3_dma_free_coherent_align(struct device *dev,=0D
+				    struct hinic3_dma_addr_align *mem_align);=0D
+=0D
+#endif=0D
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c b/drivers/n=
et/ethernet/huawei/hinic3/hinic3_hw_cfg.c=0D
new file mode 100644=0D
index 000000000000..87d9450c30ca=0D
--- /dev/null=0D
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.c=0D
@@ -0,0 +1,25 @@=0D
+// SPDX-License-Identifier: GPL-2.0=0D
+// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.=
=0D
+=0D
+#include <linux/device.h>=0D
+=0D
+#include "hinic3_hw_cfg.h"=0D
+#include "hinic3_hwdev.h"=0D
+#include "hinic3_hwif.h"=0D
+#include "hinic3_mbox.h"=0D
+=0D
+bool hinic3_support_nic(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	return hwdev->cfg_mgmt->cap.supp_svcs_bitmap &=0D
+	       BIT(HINIC3_SERVICE_T_NIC);=0D
+}=0D
+=0D
+u16 hinic3_func_max_qnum(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	return hwdev->cfg_mgmt->cap.nic_svc_cap.max_sqs;=0D
+}=0D
+=0D
+u8 hinic3_physical_port_id(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	return hwdev->cfg_mgmt->cap.port_id;=0D
+}=0D
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h b/drivers/n=
et/ethernet/huawei/hinic3/hinic3_hw_cfg.h=0D
new file mode 100644=0D
index 000000000000..e017b1ae9f05=0D
--- /dev/null=0D
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_cfg.h=0D
@@ -0,0 +1,53 @@=0D
+/* SPDX-License-Identifier: GPL-2.0 */=0D
+/* Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved. =
*/=0D
+=0D
+#ifndef _HINIC3_HW_CFG_H_=0D
+#define _HINIC3_HW_CFG_H_=0D
+=0D
+#include <linux/mutex.h>=0D
+#include <linux/pci.h>=0D
+=0D
+struct hinic3_hwdev;=0D
+=0D
+struct hinic3_irq {=0D
+	u32  irq_id;=0D
+	u16  msix_entry_idx;=0D
+	bool allocated;=0D
+};=0D
+=0D
+struct hinic3_irq_info {=0D
+	struct hinic3_irq *irq;=0D
+	u16               num_irq;=0D
+	/* device max irq number */=0D
+	u16               num_irq_hw;=0D
+	/* protect irq alloc and free */=0D
+	struct mutex      irq_mutex;=0D
+};=0D
+=0D
+struct hinic3_nic_service_cap {=0D
+	u16 max_sqs;=0D
+};=0D
+=0D
+/* Device capabilities */=0D
+struct hinic3_dev_cap {=0D
+	/* Bitmasks of services supported by device */=0D
+	u16                           supp_svcs_bitmap;=0D
+	/* Physical port */=0D
+	u8                            port_id;=0D
+	struct hinic3_nic_service_cap nic_svc_cap;=0D
+};=0D
+=0D
+struct hinic3_cfg_mgmt_info {=0D
+	struct hinic3_irq_info irq_info;=0D
+	struct hinic3_dev_cap  cap;=0D
+};=0D
+=0D
+int hinic3_alloc_irqs(struct hinic3_hwdev *hwdev, u16 num,=0D
+		      struct msix_entry *alloc_arr, u16 *act_num);=0D
+void hinic3_free_irq(struct hinic3_hwdev *hwdev, u32 irq_id);=0D
+=0D
+bool hinic3_support_nic(struct hinic3_hwdev *hwdev);=0D
+u16 hinic3_func_max_qnum(struct hinic3_hwdev *hwdev);=0D
+u8 hinic3_physical_port_id(struct hinic3_hwdev *hwdev);=0D
+=0D
+#endif=0D
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c b/drivers/=
net/ethernet/huawei/hinic3/hinic3_hw_comm.c=0D
new file mode 100644=0D
index 000000000000..434696ce7dc2=0D
--- /dev/null=0D
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.c=0D
@@ -0,0 +1,32 @@=0D
+// SPDX-License-Identifier: GPL-2.0=0D
+// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.=
=0D
+=0D
+#include <linux/delay.h>=0D
+=0D
+#include "hinic3_hw_comm.h"=0D
+#include "hinic3_hwdev.h"=0D
+#include "hinic3_hwif.h"=0D
+#include "hinic3_mbox.h"=0D
+=0D
+int hinic3_func_reset(struct hinic3_hwdev *hwdev, u16 func_id, u64 reset_f=
lag)=0D
+{=0D
+	struct comm_cmd_func_reset func_reset =3D {};=0D
+	struct mgmt_msg_params msg_params =3D {};=0D
+	int err;=0D
+=0D
+	func_reset.func_id =3D func_id;=0D
+	func_reset.reset_flag =3D reset_flag;=0D
+=0D
+	mgmt_msg_params_init_default(&msg_params, &func_reset,=0D
+				     sizeof(func_reset));=0D
+=0D
+	err =3D hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_COMM,=0D
+				       COMM_CMD_FUNC_RESET, &msg_params);=0D
+	if (err || func_reset.head.status) {=0D
+		dev_err(hwdev->dev, "Failed to reset func resources, reset_flag 0x%llx, =
err: %d, status: 0x%x\n",=0D
+			reset_flag, err, func_reset.head.status);=0D
+		return -EIO;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h b/drivers/=
net/ethernet/huawei/hinic3/hinic3_hw_comm.h=0D
new file mode 100644=0D
index 000000000000..c33a1c77da9c=0D
--- /dev/null=0D
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_comm.h=0D
@@ -0,0 +1,13 @@=0D
+/* SPDX-License-Identifier: GPL-2.0 */=0D
+/* Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved. =
*/=0D
+=0D
+#ifndef _HINIC3_HW_COMM_H_=0D
+#define _HINIC3_HW_COMM_H_=0D
+=0D
+#include "hinic3_hw_intf.h"=0D
+=0D
+struct hinic3_hwdev;=0D
+=0D
+int hinic3_func_reset(struct hinic3_hwdev *hwdev, u16 func_id, u64 reset_f=
lag);=0D
+=0D
+#endif=0D
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h b/drivers/=
net/ethernet/huawei/hinic3/hinic3_hw_intf.h=0D
new file mode 100644=0D
index 000000000000..22c84093efa2=0D
--- /dev/null=0D
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hw_intf.h=0D
@@ -0,0 +1,113 @@=0D
+/* SPDX-License-Identifier: GPL-2.0 */=0D
+/* Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved. =
*/=0D
+=0D
+#ifndef _HINIC3_HW_INTF_H_=0D
+#define _HINIC3_HW_INTF_H_=0D
+=0D
+#include <linux/bits.h>=0D
+#include <linux/types.h>=0D
+=0D
+#define MGMT_MSG_CMD_OP_SET   1=0D
+#define MGMT_MSG_CMD_OP_GET   0=0D
+=0D
+#define MGMT_STATUS_PF_SET_VF_ALREADY  0x4=0D
+#define MGMT_STATUS_EXIST              0x6=0D
+#define MGMT_STATUS_CMD_UNSUPPORTED    0xFF=0D
+=0D
+#define MGMT_MSG_POLLING_TIMEOUT 0=0D
+=0D
+struct mgmt_msg_head {=0D
+	u8 status;=0D
+	u8 version;=0D
+	u8 rsvd0[6];=0D
+};=0D
+=0D
+struct mgmt_msg_params {=0D
+	const void  *buf_in;=0D
+	u32         in_size;=0D
+	void        *buf_out;=0D
+	u32         expected_out_size;=0D
+	u32         timeout_ms;=0D
+};=0D
+=0D
+/* CMDQ MODULE_TYPE */=0D
+enum mgmt_mod_type {=0D
+	/* HW communication module */=0D
+	MGMT_MOD_COMM   =3D 0,=0D
+	/* L2NIC module */=0D
+	MGMT_MOD_L2NIC  =3D 1,=0D
+	/* Configuration module */=0D
+	MGMT_MOD_CFGM   =3D 7,=0D
+	MGMT_MOD_HILINK =3D 14,=0D
+};=0D
+=0D
+static inline void mgmt_msg_params_init_default(struct mgmt_msg_params *ms=
g_params,=0D
+						void *inout_buf, u32 buf_size)=0D
+{=0D
+	msg_params->buf_in =3D inout_buf;=0D
+	msg_params->buf_out =3D inout_buf;=0D
+	msg_params->in_size =3D buf_size;=0D
+	msg_params->expected_out_size =3D buf_size;=0D
+	msg_params->timeout_ms =3D 0;=0D
+}=0D
+=0D
+/* COMM Commands between Driver to fw */=0D
+enum comm_cmd {=0D
+	/* Commands for clearing FLR and resources */=0D
+	COMM_CMD_FUNC_RESET              =3D 0,=0D
+	COMM_CMD_FEATURE_NEGO            =3D 1,=0D
+	COMM_CMD_FLUSH_DOORBELL          =3D 2,=0D
+	COMM_CMD_START_FLUSH             =3D 3,=0D
+	COMM_CMD_GET_GLOBAL_ATTR         =3D 5,=0D
+	COMM_CMD_SET_FUNC_SVC_USED_STATE =3D 7,=0D
+=0D
+	/* Driver Configuration Commands */=0D
+	COMM_CMD_SET_CMDQ_CTXT           =3D 20,=0D
+	COMM_CMD_SET_VAT                 =3D 21,=0D
+	COMM_CMD_CFG_PAGESIZE            =3D 22,=0D
+	COMM_CMD_CFG_MSIX_CTRL_REG       =3D 23,=0D
+	COMM_CMD_SET_CEQ_CTRL_REG        =3D 24,=0D
+	COMM_CMD_SET_DMA_ATTR            =3D 25,=0D
+};=0D
+=0D
+enum comm_func_reset_bits {=0D
+	COMM_FUNC_RESET_BIT_FLUSH        =3D BIT(0),=0D
+	COMM_FUNC_RESET_BIT_MQM          =3D BIT(1),=0D
+	COMM_FUNC_RESET_BIT_SMF          =3D BIT(2),=0D
+	COMM_FUNC_RESET_BIT_PF_BW_CFG    =3D BIT(3),=0D
+=0D
+	COMM_FUNC_RESET_BIT_COMM         =3D BIT(10),=0D
+	/* clear mbox and aeq, The COMM_FUNC_RESET_BIT_COMM bit must be set */=0D
+	COMM_FUNC_RESET_BIT_COMM_MGMT_CH =3D BIT(11),=0D
+	/* clear cmdq and ceq, The COMM_FUNC_RESET_BIT_COMM bit must be set */=0D
+	COMM_FUNC_RESET_BIT_COMM_CMD_CH  =3D BIT(12),=0D
+	COMM_FUNC_RESET_BIT_NIC          =3D BIT(13),=0D
+};=0D
+=0D
+struct comm_cmd_func_reset {=0D
+	struct mgmt_msg_head head;=0D
+	u16                  func_id;=0D
+	u16                  rsvd1[3];=0D
+	u64                  reset_flag;=0D
+};=0D
+=0D
+#define COMM_MAX_FEATURE_QWORD  4=0D
+struct comm_cmd_feature_nego {=0D
+	struct mgmt_msg_head head;=0D
+	u16                  func_id;=0D
+	u8                   opcode;=0D
+	u8                   rsvd;=0D
+	u64                  s_feature[COMM_MAX_FEATURE_QWORD];=0D
+};=0D
+=0D
+/* Services supported by HW. HW uses these values when delivering events.=
=0D
+ * HW supports multiple services that are not yet supported by driver=0D
+ * (e.g. RoCE).=0D
+ */=0D
+enum hinic3_service_type {=0D
+	HINIC3_SERVICE_T_NIC =3D 0,=0D
+	/* MAX is only used by SW for array sizes. */=0D
+	HINIC3_SERVICE_T_MAX =3D 1,=0D
+};=0D
+=0D
+#endif=0D
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c b/drivers/ne=
t/ethernet/huawei/hinic3/hinic3_hwdev.c=0D
new file mode 100644=0D
index 000000000000..6e8788a64925=0D
--- /dev/null=0D
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.c=0D
@@ -0,0 +1,24 @@=0D
+// SPDX-License-Identifier: GPL-2.0=0D
+// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.=
=0D
+=0D
+#include "hinic3_hw_comm.h"=0D
+#include "hinic3_hwdev.h"=0D
+#include "hinic3_hwif.h"=0D
+#include "hinic3_mbox.h"=0D
+#include "hinic3_mgmt.h"=0D
+=0D
+int hinic3_init_hwdev(struct pci_dev *pdev)=0D
+{=0D
+	/* Completed by later submission due to LoC limit. */=0D
+	return -EFAULT;=0D
+}=0D
+=0D
+void hinic3_free_hwdev(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	/* Completed by later submission due to LoC limit. */=0D
+}=0D
+=0D
+void hinic3_set_api_stop(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	/* Completed by later submission due to LoC limit. */=0D
+}=0D
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h b/drivers/ne=
t/ethernet/huawei/hinic3/hinic3_hwdev.h=0D
new file mode 100644=0D
index 000000000000..62e2745e9316=0D
--- /dev/null=0D
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwdev.h=0D
@@ -0,0 +1,81 @@=0D
+/* SPDX-License-Identifier: GPL-2.0 */=0D
+/* Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved. =
*/=0D
+=0D
+#ifndef _HINIC3_HWDEV_H_=0D
+#define _HINIC3_HWDEV_H_=0D
+=0D
+#include <linux/auxiliary_bus.h>=0D
+#include <linux/pci.h>=0D
+=0D
+#include "hinic3_hw_intf.h"=0D
+=0D
+struct hinic3_cmdqs;=0D
+struct hinic3_hwif;=0D
+=0D
+enum hinic3_event_service_type {=0D
+	HINIC3_EVENT_SRV_COMM =3D 0,=0D
+	HINIC3_EVENT_SRV_NIC  =3D 1=0D
+};=0D
+=0D
+#define HINIC3_SRV_EVENT_TYPE(svc, type)    (((svc) << 16) | (type))=0D
+=0D
+/* driver-specific data of pci_dev */=0D
+struct hinic3_pcidev {=0D
+	struct pci_dev       *pdev;=0D
+	struct hinic3_hwdev  *hwdev;=0D
+	/* Auxiliary devices */=0D
+	struct hinic3_adev   *hadev[HINIC3_SERVICE_T_MAX];=0D
+=0D
+	void __iomem         *cfg_reg_base;=0D
+	void __iomem         *intr_reg_base;=0D
+	void __iomem         *db_base;=0D
+	u64                  db_dwqe_len;=0D
+	u64                  db_base_phy;=0D
+=0D
+	/* lock for attach/detach uld */=0D
+	struct mutex         pdev_mutex;=0D
+	unsigned long        state;=0D
+};=0D
+=0D
+struct hinic3_hwdev {=0D
+	struct hinic3_pcidev        *adapter;=0D
+	struct pci_dev              *pdev;=0D
+	struct device               *dev;=0D
+	int                         dev_id;=0D
+	struct hinic3_hwif          *hwif;=0D
+	struct hinic3_cfg_mgmt_info *cfg_mgmt;=0D
+	struct hinic3_aeqs          *aeqs;=0D
+	struct hinic3_ceqs          *ceqs;=0D
+	struct hinic3_mbox          *mbox;=0D
+	struct hinic3_cmdqs         *cmdqs;=0D
+	struct workqueue_struct     *workq;=0D
+	/* protect channel init and uninit */=0D
+	spinlock_t                  channel_lock;=0D
+	u64                         features[COMM_MAX_FEATURE_QWORD];=0D
+	u32                         wq_page_size;=0D
+	u8                          max_cmdq;=0D
+	ulong                       func_state;=0D
+};=0D
+=0D
+struct hinic3_event_info {=0D
+	/* enum hinic3_event_service_type */=0D
+	u16 service;=0D
+	u16 type;=0D
+	u8  event_data[104];=0D
+};=0D
+=0D
+struct hinic3_adev {=0D
+	struct auxiliary_device  adev;=0D
+	struct hinic3_hwdev      *hwdev;=0D
+	enum hinic3_service_type svc_type;=0D
+=0D
+	void (*event)(struct auxiliary_device *adev,=0D
+		      struct hinic3_event_info *event);=0D
+};=0D
+=0D
+int hinic3_init_hwdev(struct pci_dev *pdev);=0D
+void hinic3_free_hwdev(struct hinic3_hwdev *hwdev);=0D
+=0D
+void hinic3_set_api_stop(struct hinic3_hwdev *hwdev);=0D
+=0D
+#endif=0D
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c b/drivers/net=
/ethernet/huawei/hinic3/hinic3_hwif.c=0D
new file mode 100644=0D
index 000000000000..0865453bf0e7=0D
--- /dev/null=0D
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.c=0D
@@ -0,0 +1,21 @@=0D
+// SPDX-License-Identifier: GPL-2.0=0D
+// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.=
=0D
+=0D
+#include <linux/bitfield.h>=0D
+#include <linux/device.h>=0D
+#include <linux/io.h>=0D
+=0D
+#include "hinic3_common.h"=0D
+#include "hinic3_hwdev.h"=0D
+#include "hinic3_hwif.h"=0D
+=0D
+void hinic3_set_msix_state(struct hinic3_hwdev *hwdev, u16 msix_idx,=0D
+			   enum hinic3_msix_state flag)=0D
+{=0D
+	/* Completed by later submission due to LoC limit. */=0D
+}=0D
+=0D
+u16 hinic3_global_func_id(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	return hwdev->hwif->attr.func_global_idx;=0D
+}=0D
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h b/drivers/net=
/ethernet/huawei/hinic3/hinic3_hwif.h=0D
new file mode 100644=0D
index 000000000000..513c9680e6b6=0D
--- /dev/null=0D
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_hwif.h=0D
@@ -0,0 +1,58 @@=0D
+/* SPDX-License-Identifier: GPL-2.0 */=0D
+/* Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved. =
*/=0D
+=0D
+#ifndef _HINIC3_HWIF_H_=0D
+#define _HINIC3_HWIF_H_=0D
+=0D
+#include <linux/build_bug.h>=0D
+#include <linux/spinlock_types.h>=0D
+=0D
+struct hinic3_hwdev;=0D
+=0D
+enum hinic3_func_type {=0D
+	HINIC3_FUNC_TYPE_VF =3D 1,=0D
+};=0D
+=0D
+struct hinic3_db_area {=0D
+	unsigned long *db_bitmap_array;=0D
+	u32           db_max_areas;=0D
+	/* protect doorbell area alloc and free */=0D
+	spinlock_t    idx_lock;=0D
+};=0D
+=0D
+struct hinic3_func_attr {=0D
+	enum hinic3_func_type func_type;=0D
+	u16                   func_global_idx;=0D
+	u16                   global_vf_id_of_pf;=0D
+	u16                   num_irqs;=0D
+	u16                   num_sq;=0D
+	u8                    port_to_port_idx;=0D
+	u8                    pci_intf_idx;=0D
+	u8                    ppf_idx;=0D
+	u8                    num_aeqs;=0D
+	u8                    num_ceqs;=0D
+	u8                    msix_flex_en;=0D
+};=0D
+=0D
+static_assert(sizeof(struct hinic3_func_attr) =3D=3D 20);=0D
+=0D
+struct hinic3_hwif {=0D
+	u8 __iomem              *cfg_regs_base;=0D
+	u64                     db_base_phy;=0D
+	u64                     db_dwqe_len;=0D
+	u8 __iomem              *db_base;=0D
+	struct hinic3_db_area   db_area;=0D
+	struct hinic3_func_attr attr;=0D
+};=0D
+=0D
+enum hinic3_msix_state {=0D
+	HINIC3_MSIX_ENABLE,=0D
+	HINIC3_MSIX_DISABLE,=0D
+};=0D
+=0D
+void hinic3_set_msix_state(struct hinic3_hwdev *hwdev, u16 msix_idx,=0D
+			   enum hinic3_msix_state flag);=0D
+=0D
+u16 hinic3_global_func_id(struct hinic3_hwdev *hwdev);=0D
+=0D
+#endif=0D
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c b/drivers/net/=
ethernet/huawei/hinic3/hinic3_irq.c=0D
new file mode 100644=0D
index 000000000000..5e300826e70b=0D
--- /dev/null=0D
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c=0D
@@ -0,0 +1,53 @@=0D
+// SPDX-License-Identifier: GPL-2.0=0D
+// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.=
=0D
+=0D
+#include <linux/netdevice.h>=0D
+=0D
+#include "hinic3_hw_comm.h"=0D
+#include "hinic3_hwdev.h"=0D
+#include "hinic3_hwif.h"=0D
+#include "hinic3_nic_dev.h"=0D
+#include "hinic3_rx.h"=0D
+#include "hinic3_tx.h"=0D
+=0D
+static int hinic3_poll(struct napi_struct *napi, int budget)=0D
+{=0D
+	struct hinic3_irq_cfg *irq_cfg =3D=0D
+		container_of(napi, struct hinic3_irq_cfg, napi);=0D
+	struct hinic3_nic_dev *nic_dev;=0D
+	bool busy =3D false;=0D
+	int work_done;=0D
+=0D
+	nic_dev =3D netdev_priv(irq_cfg->netdev);=0D
+=0D
+	busy |=3D hinic3_tx_poll(irq_cfg->txq, budget);=0D
+=0D
+	if (unlikely(!budget))=0D
+		return 0;=0D
+=0D
+	work_done =3D hinic3_rx_poll(irq_cfg->rxq, budget);=0D
+	busy |=3D work_done >=3D budget;=0D
+=0D
+	if (busy)=0D
+		return budget;=0D
+=0D
+	if (likely(napi_complete_done(napi, work_done)))=0D
+		hinic3_set_msix_state(nic_dev->hwdev, irq_cfg->msix_entry_idx,=0D
+				      HINIC3_MSIX_ENABLE);=0D
+=0D
+	return work_done;=0D
+}=0D
+=0D
+void qp_add_napi(struct hinic3_irq_cfg *irq_cfg)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D netdev_priv(irq_cfg->netdev);=0D
+=0D
+	netif_napi_add(nic_dev->netdev, &irq_cfg->napi, hinic3_poll);=0D
+	napi_enable(&irq_cfg->napi);=0D
+}=0D
+=0D
+void qp_del_napi(struct hinic3_irq_cfg *irq_cfg)=0D
+{=0D
+	napi_disable(&irq_cfg->napi);=0D
+	netif_napi_del(&irq_cfg->napi);=0D
+}=0D
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c b/drivers/net/=
ethernet/huawei/hinic3/hinic3_lld.c=0D
new file mode 100644=0D
index 000000000000..4827326e6a59=0D
--- /dev/null=0D
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.c=0D
@@ -0,0 +1,414 @@=0D
+// SPDX-License-Identifier: GPL-2.0=0D
+// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.=
=0D
+=0D
+#include <linux/delay.h>=0D
+#include <linux/iopoll.h>=0D
+=0D
+#include "hinic3_hw_cfg.h"=0D
+#include "hinic3_hwdev.h"=0D
+#include "hinic3_lld.h"=0D
+#include "hinic3_mgmt.h"=0D
+=0D
+#define HINIC3_VF_PCI_CFG_REG_BAR  0=0D
+#define HINIC3_PCI_INTR_REG_BAR    2=0D
+#define HINIC3_PCI_DB_BAR          4=0D
+=0D
+#define HINIC3_EVENT_POLL_SLEEP_US   1000=0D
+#define HINIC3_EVENT_POLL_TIMEOUT_US 10000000=0D
+=0D
+static struct hinic3_adev_device {=0D
+	const char *name;=0D
+} hinic3_adev_devices[HINIC3_SERVICE_T_MAX] =3D {=0D
+	[HINIC3_SERVICE_T_NIC] =3D {=0D
+		.name =3D "nic",=0D
+	},=0D
+};=0D
+=0D
+static bool hinic3_adev_svc_supported(struct hinic3_hwdev *hwdev,=0D
+				      enum hinic3_service_type svc_type)=0D
+{=0D
+	switch (svc_type) {=0D
+	case HINIC3_SERVICE_T_NIC:=0D
+		return hinic3_support_nic(hwdev);=0D
+	default:=0D
+		break;=0D
+	}=0D
+=0D
+	return false;=0D
+}=0D
+=0D
+static void hinic3_comm_adev_release(struct device *dev)=0D
+{=0D
+	struct hinic3_adev *hadev =3D container_of(dev, struct hinic3_adev,=0D
+						 adev.dev);=0D
+=0D
+	kfree(hadev);=0D
+}=0D
+=0D
+static struct hinic3_adev *hinic3_add_one_adev(struct hinic3_hwdev *hwdev,=
=0D
+					       enum hinic3_service_type svc_type)=0D
+{=0D
+	struct hinic3_adev *hadev;=0D
+	const char *svc_name;=0D
+	int ret;=0D
+=0D
+	hadev =3D kzalloc(sizeof(*hadev), GFP_KERNEL);=0D
+	if (!hadev)=0D
+		return NULL;=0D
+=0D
+	svc_name =3D hinic3_adev_devices[svc_type].name;=0D
+	hadev->adev.name =3D svc_name;=0D
+	hadev->adev.id =3D hwdev->dev_id;=0D
+	hadev->adev.dev.parent =3D hwdev->dev;=0D
+	hadev->adev.dev.release =3D hinic3_comm_adev_release;=0D
+	hadev->svc_type =3D svc_type;=0D
+	hadev->hwdev =3D hwdev;=0D
+=0D
+	ret =3D auxiliary_device_init(&hadev->adev);=0D
+	if (ret) {=0D
+		dev_err(hwdev->dev, "failed init adev %s %u\n",=0D
+			svc_name, hwdev->dev_id);=0D
+		kfree(hadev);=0D
+		return NULL;=0D
+	}=0D
+=0D
+	ret =3D auxiliary_device_add(&hadev->adev);=0D
+	if (ret) {=0D
+		dev_err(hwdev->dev, "failed to add adev %s %u\n",=0D
+			svc_name, hwdev->dev_id);=0D
+		auxiliary_device_uninit(&hadev->adev);=0D
+		return NULL;=0D
+	}=0D
+=0D
+	return hadev;=0D
+}=0D
+=0D
+static void hinic3_del_one_adev(struct hinic3_hwdev *hwdev,=0D
+				enum hinic3_service_type svc_type)=0D
+{=0D
+	struct hinic3_pcidev *pci_adapter =3D hwdev->adapter;=0D
+	struct hinic3_adev *hadev;=0D
+	int timeout;=0D
+	bool state;=0D
+=0D
+	timeout =3D read_poll_timeout(test_and_set_bit, state, !state,=0D
+				    HINIC3_EVENT_POLL_SLEEP_US,=0D
+				    HINIC3_EVENT_POLL_TIMEOUT_US,=0D
+				    false, svc_type, &pci_adapter->state);=0D
+=0D
+	hadev =3D pci_adapter->hadev[svc_type];=0D
+	auxiliary_device_delete(&hadev->adev);=0D
+	auxiliary_device_uninit(&hadev->adev);=0D
+	pci_adapter->hadev[svc_type] =3D NULL;=0D
+	if (!timeout)=0D
+		clear_bit(svc_type, &pci_adapter->state);=0D
+}=0D
+=0D
+static int hinic3_attach_aux_devices(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	struct hinic3_pcidev *pci_adapter =3D hwdev->adapter;=0D
+	enum hinic3_service_type svc_type;=0D
+=0D
+	mutex_lock(&pci_adapter->pdev_mutex);=0D
+=0D
+	for (svc_type =3D 0; svc_type < HINIC3_SERVICE_T_MAX; svc_type++) {=0D
+		if (!hinic3_adev_svc_supported(hwdev, svc_type))=0D
+			continue;=0D
+=0D
+		pci_adapter->hadev[svc_type] =3D hinic3_add_one_adev(hwdev,=0D
+								   svc_type);=0D
+		if (!pci_adapter->hadev[svc_type])=0D
+			goto err_del_adevs;=0D
+	}=0D
+	mutex_unlock(&pci_adapter->pdev_mutex);=0D
+	return 0;=0D
+=0D
+err_del_adevs:=0D
+	while (svc_type > 0) {=0D
+		svc_type--;=0D
+		if (pci_adapter->hadev[svc_type]) {=0D
+			hinic3_del_one_adev(hwdev, svc_type);=0D
+			pci_adapter->hadev[svc_type] =3D NULL;=0D
+		}=0D
+	}=0D
+	mutex_unlock(&pci_adapter->pdev_mutex);=0D
+	return -ENOMEM;=0D
+}=0D
+=0D
+static void hinic3_detach_aux_devices(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	struct hinic3_pcidev *pci_adapter =3D hwdev->adapter;=0D
+	int i;=0D
+=0D
+	mutex_lock(&pci_adapter->pdev_mutex);=0D
+	for (i =3D 0; i < ARRAY_SIZE(hinic3_adev_devices); i++) {=0D
+		if (pci_adapter->hadev[i])=0D
+			hinic3_del_one_adev(hwdev, i);=0D
+	}=0D
+	mutex_unlock(&pci_adapter->pdev_mutex);=0D
+}=0D
+=0D
+struct hinic3_hwdev *hinic3_adev_get_hwdev(struct auxiliary_device *adev)=
=0D
+{=0D
+	struct hinic3_adev *hadev;=0D
+=0D
+	hadev =3D container_of(adev, struct hinic3_adev, adev);=0D
+	return hadev->hwdev;=0D
+}=0D
+=0D
+void hinic3_adev_event_register(struct auxiliary_device *adev,=0D
+				void (*event_handler)(struct auxiliary_device *adev,=0D
+						      struct hinic3_event_info *event))=0D
+{=0D
+	struct hinic3_adev *hadev;=0D
+=0D
+	hadev =3D container_of(adev, struct hinic3_adev, adev);=0D
+	hadev->event =3D event_handler;=0D
+}=0D
+=0D
+void hinic3_adev_event_unregister(struct auxiliary_device *adev)=0D
+{=0D
+	struct hinic3_adev *hadev;=0D
+=0D
+	hadev =3D container_of(adev, struct hinic3_adev, adev);=0D
+	hadev->event =3D NULL;=0D
+}=0D
+=0D
+static int hinic3_mapping_bar(struct pci_dev *pdev,=0D
+			      struct hinic3_pcidev *pci_adapter)=0D
+{=0D
+	pci_adapter->cfg_reg_base =3D pci_ioremap_bar(pdev,=0D
+						    HINIC3_VF_PCI_CFG_REG_BAR);=0D
+	if (!pci_adapter->cfg_reg_base) {=0D
+		dev_err(&pdev->dev, "Failed to map configuration regs\n");=0D
+		return -ENOMEM;=0D
+	}=0D
+=0D
+	pci_adapter->intr_reg_base =3D pci_ioremap_bar(pdev,=0D
+						     HINIC3_PCI_INTR_REG_BAR);=0D
+	if (!pci_adapter->intr_reg_base) {=0D
+		dev_err(&pdev->dev, "Failed to map interrupt regs\n");=0D
+		goto err_unmap_cfg_reg_base;=0D
+	}=0D
+=0D
+	pci_adapter->db_base_phy =3D pci_resource_start(pdev, HINIC3_PCI_DB_BAR);=
=0D
+	pci_adapter->db_dwqe_len =3D pci_resource_len(pdev, HINIC3_PCI_DB_BAR);=0D
+	pci_adapter->db_base =3D pci_ioremap_bar(pdev, HINIC3_PCI_DB_BAR);=0D
+	if (!pci_adapter->db_base) {=0D
+		dev_err(&pdev->dev, "Failed to map doorbell regs\n");=0D
+		goto err_unmap_intr_reg_base;=0D
+	}=0D
+=0D
+	return 0;=0D
+=0D
+err_unmap_intr_reg_base:=0D
+	iounmap(pci_adapter->intr_reg_base);=0D
+=0D
+err_unmap_cfg_reg_base:=0D
+	iounmap(pci_adapter->cfg_reg_base);=0D
+=0D
+	return -ENOMEM;=0D
+}=0D
+=0D
+static void hinic3_unmapping_bar(struct hinic3_pcidev *pci_adapter)=0D
+{=0D
+	iounmap(pci_adapter->db_base);=0D
+	iounmap(pci_adapter->intr_reg_base);=0D
+	iounmap(pci_adapter->cfg_reg_base);=0D
+}=0D
+=0D
+static int hinic3_pci_init(struct pci_dev *pdev)=0D
+{=0D
+	struct hinic3_pcidev *pci_adapter;=0D
+	int err;=0D
+=0D
+	pci_adapter =3D kzalloc(sizeof(*pci_adapter), GFP_KERNEL);=0D
+	if (!pci_adapter)=0D
+		return -ENOMEM;=0D
+=0D
+	pci_adapter->pdev =3D pdev;=0D
+	mutex_init(&pci_adapter->pdev_mutex);=0D
+=0D
+	pci_set_drvdata(pdev, pci_adapter);=0D
+=0D
+	err =3D pci_enable_device(pdev);=0D
+	if (err) {=0D
+		dev_err(&pdev->dev, "Failed to enable PCI device\n");=0D
+		goto err_free_pci_adapter;=0D
+	}=0D
+=0D
+	err =3D pci_request_regions(pdev, HINIC3_NIC_DRV_NAME);=0D
+	if (err) {=0D
+		dev_err(&pdev->dev, "Failed to request regions\n");=0D
+		goto err_disable_device;=0D
+	}=0D
+=0D
+	pci_set_master(pdev);=0D
+=0D
+	err =3D dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));=0D
+	if (err) {=0D
+		dev_err(&pdev->dev, "Failed to set DMA mask\n");=0D
+		goto err_release_regions;=0D
+	}=0D
+=0D
+	return 0;=0D
+=0D
+err_release_regions:=0D
+	pci_clear_master(pdev);=0D
+	pci_release_regions(pdev);=0D
+=0D
+err_disable_device:=0D
+	pci_disable_device(pdev);=0D
+=0D
+err_free_pci_adapter:=0D
+	pci_set_drvdata(pdev, NULL);=0D
+	mutex_destroy(&pci_adapter->pdev_mutex);=0D
+	kfree(pci_adapter);=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+static void hinic3_pci_uninit(struct pci_dev *pdev)=0D
+{=0D
+	struct hinic3_pcidev *pci_adapter =3D pci_get_drvdata(pdev);=0D
+=0D
+	pci_clear_master(pdev);=0D
+	pci_release_regions(pdev);=0D
+	pci_disable_device(pdev);=0D
+	pci_set_drvdata(pdev, NULL);=0D
+	mutex_destroy(&pci_adapter->pdev_mutex);=0D
+	kfree(pci_adapter);=0D
+}=0D
+=0D
+static int hinic3_func_init(struct pci_dev *pdev,=0D
+			    struct hinic3_pcidev *pci_adapter)=0D
+{=0D
+	int err;=0D
+=0D
+	err =3D hinic3_init_hwdev(pdev);=0D
+	if (err) {=0D
+		dev_err(&pdev->dev, "Failed to initialize hardware device\n");=0D
+		return err;=0D
+	}=0D
+=0D
+	err =3D hinic3_attach_aux_devices(pci_adapter->hwdev);=0D
+	if (err)=0D
+		goto err_free_hwdev;=0D
+=0D
+	return 0;=0D
+=0D
+err_free_hwdev:=0D
+	hinic3_free_hwdev(pci_adapter->hwdev);=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+static void hinic3_func_uninit(struct pci_dev *pdev)=0D
+{=0D
+	struct hinic3_pcidev *pci_adapter =3D pci_get_drvdata(pdev);=0D
+=0D
+	hinic3_detach_aux_devices(pci_adapter->hwdev);=0D
+	hinic3_free_hwdev(pci_adapter->hwdev);=0D
+}=0D
+=0D
+static int hinic3_probe_func(struct hinic3_pcidev *pci_adapter)=0D
+{=0D
+	struct pci_dev *pdev =3D pci_adapter->pdev;=0D
+	int err;=0D
+=0D
+	err =3D hinic3_mapping_bar(pdev, pci_adapter);=0D
+	if (err) {=0D
+		dev_err(&pdev->dev, "Failed to map bar\n");=0D
+		goto err_out;=0D
+	}=0D
+=0D
+	err =3D hinic3_func_init(pdev, pci_adapter);=0D
+	if (err)=0D
+		goto err_unmap_bar;=0D
+=0D
+	return 0;=0D
+=0D
+err_unmap_bar:=0D
+	hinic3_unmapping_bar(pci_adapter);=0D
+=0D
+err_out:=0D
+	dev_err(&pdev->dev, "PCIe device probe function failed\n");=0D
+	return err;=0D
+}=0D
+=0D
+static void hinic3_remove_func(struct hinic3_pcidev *pci_adapter)=0D
+{=0D
+	struct pci_dev *pdev =3D pci_adapter->pdev;=0D
+=0D
+	hinic3_func_uninit(pdev);=0D
+	hinic3_unmapping_bar(pci_adapter);=0D
+}=0D
+=0D
+static int hinic3_probe(struct pci_dev *pdev, const struct pci_device_id *=
id)=0D
+{=0D
+	struct hinic3_pcidev *pci_adapter;=0D
+	int err;=0D
+=0D
+	err =3D hinic3_pci_init(pdev);=0D
+	if (err)=0D
+		goto err_out;=0D
+=0D
+	pci_adapter =3D pci_get_drvdata(pdev);=0D
+	err =3D hinic3_probe_func(pci_adapter);=0D
+	if (err)=0D
+		goto err_uninit_pci;=0D
+=0D
+	return 0;=0D
+=0D
+err_uninit_pci:=0D
+	hinic3_pci_uninit(pdev);=0D
+=0D
+err_out:=0D
+	dev_err(&pdev->dev, "PCIe device probe failed\n");=0D
+	return err;=0D
+}=0D
+=0D
+static void hinic3_remove(struct pci_dev *pdev)=0D
+{=0D
+	struct hinic3_pcidev *pci_adapter =3D pci_get_drvdata(pdev);=0D
+=0D
+	hinic3_remove_func(pci_adapter);=0D
+	hinic3_pci_uninit(pdev);=0D
+}=0D
+=0D
+static const struct pci_device_id hinic3_pci_table[] =3D {=0D
+	/* Completed by later submission due to LoC limit. */=0D
+	{0, 0}=0D
+=0D
+};=0D
+=0D
+MODULE_DEVICE_TABLE(pci, hinic3_pci_table);=0D
+=0D
+static void hinic3_shutdown(struct pci_dev *pdev)=0D
+{=0D
+	struct hinic3_pcidev *pci_adapter =3D pci_get_drvdata(pdev);=0D
+=0D
+	pci_disable_device(pdev);=0D
+=0D
+	if (pci_adapter)=0D
+		hinic3_set_api_stop(pci_adapter->hwdev);=0D
+}=0D
+=0D
+static struct pci_driver hinic3_driver =3D {=0D
+	.name            =3D HINIC3_NIC_DRV_NAME,=0D
+	.id_table        =3D hinic3_pci_table,=0D
+	.probe           =3D hinic3_probe,=0D
+	.remove          =3D hinic3_remove,=0D
+	.shutdown        =3D hinic3_shutdown,=0D
+	.sriov_configure =3D pci_sriov_configure_simple=0D
+};=0D
+=0D
+int hinic3_lld_init(void)=0D
+{=0D
+	return pci_register_driver(&hinic3_driver);=0D
+}=0D
+=0D
+void hinic3_lld_exit(void)=0D
+{=0D
+	pci_unregister_driver(&hinic3_driver);=0D
+}=0D
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_lld.h b/drivers/net/=
ethernet/huawei/hinic3/hinic3_lld.h=0D
new file mode 100644=0D
index 000000000000..322b44803476=0D
--- /dev/null=0D
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_lld.h=0D
@@ -0,0 +1,21 @@=0D
+/* SPDX-License-Identifier: GPL-2.0 */=0D
+/* Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved. =
*/=0D
+=0D
+#ifndef _HINIC3_LLD_H_=0D
+#define _HINIC3_LLD_H_=0D
+=0D
+#include <linux/auxiliary_bus.h>=0D
+=0D
+struct hinic3_event_info;=0D
+=0D
+#define HINIC3_NIC_DRV_NAME "hinic3"=0D
+=0D
+int hinic3_lld_init(void);=0D
+void hinic3_lld_exit(void);=0D
+void hinic3_adev_event_register(struct auxiliary_device *adev,=0D
+				void (*event_handler)(struct auxiliary_device *adev,=0D
+						      struct hinic3_event_info *event));=0D
+void hinic3_adev_event_unregister(struct auxiliary_device *adev);=0D
+struct hinic3_hwdev *hinic3_adev_get_hwdev(struct auxiliary_device *adev);=
=0D
+=0D
+#endif=0D
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net=
/ethernet/huawei/hinic3/hinic3_main.c=0D
new file mode 100644=0D
index 000000000000..3bce868c8e42=0D
--- /dev/null=0D
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c=0D
@@ -0,0 +1,357 @@=0D
+// SPDX-License-Identifier: GPL-2.0=0D
+// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.=
=0D
+=0D
+#include <linux/etherdevice.h>=0D
+#include <linux/netdevice.h>=0D
+=0D
+#include "hinic3_common.h"=0D
+#include "hinic3_hw_comm.h"=0D
+#include "hinic3_hwdev.h"=0D
+#include "hinic3_hwif.h"=0D
+#include "hinic3_lld.h"=0D
+#include "hinic3_nic_cfg.h"=0D
+#include "hinic3_nic_dev.h"=0D
+#include "hinic3_nic_io.h"=0D
+#include "hinic3_rx.h"=0D
+#include "hinic3_tx.h"=0D
+=0D
+#define HINIC3_NIC_DRV_DESC  "Intelligent Network Interface Card Driver"=0D
+=0D
+#define HINIC3_RX_BUF_LEN            2048=0D
+#define HINIC3_LRO_REPLENISH_THLD    256=0D
+#define HINIC3_NIC_DEV_WQ_NAME       "hinic3_nic_dev_wq"=0D
+=0D
+#define HINIC3_SQ_DEPTH              1024=0D
+#define HINIC3_RQ_DEPTH              1024=0D
+=0D
+static int hinic3_alloc_txrxqs(struct net_device *netdev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D netdev_priv(netdev);=0D
+	struct hinic3_hwdev *hwdev =3D nic_dev->hwdev;=0D
+	int err;=0D
+=0D
+	err =3D hinic3_alloc_txqs(netdev);=0D
+	if (err) {=0D
+		dev_err(hwdev->dev, "Failed to alloc txqs\n");=0D
+		return err;=0D
+	}=0D
+=0D
+	err =3D hinic3_alloc_rxqs(netdev);=0D
+	if (err) {=0D
+		dev_err(hwdev->dev, "Failed to alloc rxqs\n");=0D
+		goto err_free_txqs;=0D
+	}=0D
+=0D
+	return 0;=0D
+=0D
+err_free_txqs:=0D
+	hinic3_free_txqs(netdev);=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+static void hinic3_free_txrxqs(struct net_device *netdev)=0D
+{=0D
+	hinic3_free_rxqs(netdev);=0D
+	hinic3_free_txqs(netdev);=0D
+}=0D
+=0D
+static int hinic3_init_nic_dev(struct net_device *netdev,=0D
+			       struct hinic3_hwdev *hwdev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D netdev_priv(netdev);=0D
+	struct pci_dev *pdev =3D hwdev->pdev;=0D
+=0D
+	nic_dev->netdev =3D netdev;=0D
+	SET_NETDEV_DEV(netdev, &pdev->dev);=0D
+	nic_dev->hwdev =3D hwdev;=0D
+	nic_dev->pdev =3D pdev;=0D
+=0D
+	nic_dev->rx_buf_len =3D HINIC3_RX_BUF_LEN;=0D
+	nic_dev->lro_replenish_thld =3D HINIC3_LRO_REPLENISH_THLD;=0D
+	nic_dev->nic_svc_cap =3D hwdev->cfg_mgmt->cap.nic_svc_cap;=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int hinic3_sw_init(struct net_device *netdev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D netdev_priv(netdev);=0D
+	struct hinic3_hwdev *hwdev =3D nic_dev->hwdev;=0D
+	int err;=0D
+=0D
+	nic_dev->q_params.sq_depth =3D HINIC3_SQ_DEPTH;=0D
+	nic_dev->q_params.rq_depth =3D HINIC3_RQ_DEPTH;=0D
+=0D
+	/* VF driver always uses random MAC address. During VM migration to a=0D
+	 * new device, the new device should learn the VMs old MAC rather than=0D
+	 * provide its own MAC. The product design assumes that every VF is=0D
+	 * suspectable to migration so the device avoids offering MAC address=0D
+	 * to VFs.=0D
+	 */=0D
+	eth_hw_addr_random(netdev);=0D
+	err =3D hinic3_set_mac(hwdev, netdev->dev_addr, 0,=0D
+			     hinic3_global_func_id(hwdev));=0D
+	if (err) {=0D
+		dev_err(hwdev->dev, "Failed to set default MAC\n");=0D
+		return err;=0D
+	}=0D
+=0D
+	err =3D hinic3_alloc_txrxqs(netdev);=0D
+	if (err) {=0D
+		dev_err(hwdev->dev, "Failed to alloc qps\n");=0D
+		goto err_del_mac;=0D
+	}=0D
+=0D
+	return 0;=0D
+=0D
+err_del_mac:=0D
+	hinic3_del_mac(hwdev, netdev->dev_addr, 0,=0D
+		       hinic3_global_func_id(hwdev));=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+static void hinic3_sw_uninit(struct net_device *netdev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D netdev_priv(netdev);=0D
+=0D
+	hinic3_free_txrxqs(netdev);=0D
+	hinic3_del_mac(nic_dev->hwdev, netdev->dev_addr, 0,=0D
+		       hinic3_global_func_id(nic_dev->hwdev));=0D
+}=0D
+=0D
+static void hinic3_assign_netdev_ops(struct net_device *netdev)=0D
+{=0D
+	hinic3_set_netdev_ops(netdev);=0D
+}=0D
+=0D
+static void netdev_feature_init(struct net_device *netdev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D netdev_priv(netdev);=0D
+	netdev_features_t cso_fts =3D 0;=0D
+	netdev_features_t tso_fts =3D 0;=0D
+	netdev_features_t dft_fts;=0D
+=0D
+	dft_fts =3D NETIF_F_SG | NETIF_F_HIGHDMA;=0D
+	if (hinic3_test_support(nic_dev, HINIC3_NIC_F_CSUM))=0D
+		cso_fts |=3D NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM | NETIF_F_RXCSUM;=0D
+	if (hinic3_test_support(nic_dev, HINIC3_NIC_F_SCTP_CRC))=0D
+		cso_fts |=3D NETIF_F_SCTP_CRC;=0D
+	if (hinic3_test_support(nic_dev, HINIC3_NIC_F_TSO))=0D
+		tso_fts |=3D NETIF_F_TSO | NETIF_F_TSO6;=0D
+=0D
+	netdev->features |=3D dft_fts | cso_fts | tso_fts;=0D
+}=0D
+=0D
+static int hinic3_set_default_hw_feature(struct net_device *netdev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D netdev_priv(netdev);=0D
+	struct hinic3_hwdev *hwdev =3D nic_dev->hwdev;=0D
+	int err;=0D
+=0D
+	err =3D hinic3_set_nic_feature_to_hw(nic_dev);=0D
+	if (err) {=0D
+		dev_err(hwdev->dev, "Failed to set nic features\n");=0D
+		return err;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static void hinic3_link_status_change(struct net_device *netdev,=0D
+				      bool link_status_up)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D netdev_priv(netdev);=0D
+=0D
+	if (!HINIC3_CHANNEL_RES_VALID(nic_dev))=0D
+		return;=0D
+=0D
+	if (link_status_up) {=0D
+		if (netif_carrier_ok(netdev))=0D
+			return;=0D
+=0D
+		nic_dev->link_status_up =3D true;=0D
+		netif_carrier_on(netdev);=0D
+		netdev_dbg(netdev, "Link is up\n");=0D
+	} else {=0D
+		if (!netif_carrier_ok(netdev))=0D
+			return;=0D
+=0D
+		nic_dev->link_status_up =3D false;=0D
+		netif_carrier_off(netdev);=0D
+		netdev_dbg(netdev, "Link is down\n");=0D
+	}=0D
+}=0D
+=0D
+static void hinic3_nic_event(struct auxiliary_device *adev,=0D
+			     struct hinic3_event_info *event)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D dev_get_drvdata(&adev->dev);=0D
+	struct net_device *netdev;=0D
+=0D
+	netdev =3D nic_dev->netdev;=0D
+=0D
+	switch (HINIC3_SRV_EVENT_TYPE(event->service, event->type)) {=0D
+	case HINIC3_SRV_EVENT_TYPE(HINIC3_EVENT_SRV_NIC,=0D
+				   HINIC3_NIC_EVENT_LINK_UP):=0D
+		hinic3_link_status_change(netdev, true);=0D
+		break;=0D
+	case HINIC3_SRV_EVENT_TYPE(HINIC3_EVENT_SRV_NIC,=0D
+				   HINIC3_NIC_EVENT_LINK_DOWN):=0D
+		hinic3_link_status_change(netdev, false);=0D
+		break;=0D
+	default:=0D
+		break;=0D
+	}=0D
+}=0D
+=0D
+static int hinic3_nic_probe(struct auxiliary_device *adev,=0D
+			    const struct auxiliary_device_id *id)=0D
+{=0D
+	struct hinic3_hwdev *hwdev =3D hinic3_adev_get_hwdev(adev);=0D
+	struct pci_dev *pdev =3D hwdev->pdev;=0D
+	struct hinic3_nic_dev *nic_dev;=0D
+	struct net_device *netdev;=0D
+	u16 max_qps, glb_func_id;=0D
+	int err;=0D
+=0D
+	if (!hinic3_support_nic(hwdev)) {=0D
+		dev_dbg(&adev->dev, "HW doesn't support nic\n");=0D
+		return 0;=0D
+	}=0D
+=0D
+	hinic3_adev_event_register(adev, hinic3_nic_event);=0D
+=0D
+	glb_func_id =3D hinic3_global_func_id(hwdev);=0D
+	err =3D hinic3_func_reset(hwdev, glb_func_id, COMM_FUNC_RESET_BIT_NIC);=0D
+	if (err) {=0D
+		dev_err(&adev->dev, "Failed to reset function\n");=0D
+		goto err_unregister_adev_event;=0D
+	}=0D
+=0D
+	max_qps =3D hinic3_func_max_qnum(hwdev);=0D
+	netdev =3D alloc_etherdev_mq(sizeof(*nic_dev), max_qps);=0D
+	if (!netdev) {=0D
+		dev_err(&adev->dev, "Failed to allocate netdev\n");=0D
+		err =3D -ENOMEM;=0D
+		goto err_unregister_adev_event;=0D
+	}=0D
+=0D
+	nic_dev =3D netdev_priv(netdev);=0D
+	dev_set_drvdata(&adev->dev, nic_dev);=0D
+	err =3D hinic3_init_nic_dev(netdev, hwdev);=0D
+	if (err)=0D
+		goto err_free_netdev;=0D
+=0D
+	err =3D hinic3_init_nic_io(nic_dev);=0D
+	if (err)=0D
+		goto err_free_netdev;=0D
+=0D
+	err =3D hinic3_sw_init(netdev);=0D
+	if (err)=0D
+		goto err_free_nic_io;=0D
+=0D
+	hinic3_assign_netdev_ops(netdev);=0D
+=0D
+	netdev_feature_init(netdev);=0D
+	err =3D hinic3_set_default_hw_feature(netdev);=0D
+	if (err)=0D
+		goto err_uninit_sw;=0D
+=0D
+	netif_carrier_off(netdev);=0D
+=0D
+	err =3D register_netdev(netdev);=0D
+	if (err)=0D
+		goto err_uninit_nic_feature;=0D
+=0D
+	return 0;=0D
+=0D
+err_uninit_nic_feature:=0D
+	hinic3_update_nic_feature(nic_dev, 0);=0D
+	hinic3_set_nic_feature_to_hw(nic_dev);=0D
+=0D
+err_uninit_sw:=0D
+	hinic3_sw_uninit(netdev);=0D
+=0D
+err_free_nic_io:=0D
+	hinic3_free_nic_io(nic_dev);=0D
+=0D
+err_free_netdev:=0D
+	free_netdev(netdev);=0D
+=0D
+err_unregister_adev_event:=0D
+	hinic3_adev_event_unregister(adev);=0D
+	dev_err(&pdev->dev, "NIC service probe failed\n");=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+static void hinic3_nic_remove(struct auxiliary_device *adev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D dev_get_drvdata(&adev->dev);=0D
+	struct net_device *netdev;=0D
+=0D
+	if (!hinic3_support_nic(nic_dev->hwdev))=0D
+		return;=0D
+=0D
+	netdev =3D nic_dev->netdev;=0D
+	unregister_netdev(netdev);=0D
+=0D
+	hinic3_update_nic_feature(nic_dev, 0);=0D
+	hinic3_set_nic_feature_to_hw(nic_dev);=0D
+	hinic3_sw_uninit(netdev);=0D
+=0D
+	hinic3_free_nic_io(nic_dev);=0D
+=0D
+	free_netdev(netdev);=0D
+}=0D
+=0D
+static const struct auxiliary_device_id hinic3_nic_id_table[] =3D {=0D
+	{=0D
+		.name =3D HINIC3_NIC_DRV_NAME ".nic",=0D
+	},=0D
+	{}=0D
+};=0D
+=0D
+static struct auxiliary_driver hinic3_nic_driver =3D {=0D
+	.probe    =3D hinic3_nic_probe,=0D
+	.remove   =3D hinic3_nic_remove,=0D
+	.suspend  =3D NULL,=0D
+	.resume   =3D NULL,=0D
+	.name     =3D "nic",=0D
+	.id_table =3D hinic3_nic_id_table,=0D
+};=0D
+=0D
+static __init int hinic3_nic_lld_init(void)=0D
+{=0D
+	int err;=0D
+=0D
+	pr_info("%s: %s\n", HINIC3_NIC_DRV_NAME, HINIC3_NIC_DRV_DESC);=0D
+=0D
+	err =3D hinic3_lld_init();=0D
+	if (err)=0D
+		return err;=0D
+=0D
+	err =3D auxiliary_driver_register(&hinic3_nic_driver);=0D
+	if (err) {=0D
+		hinic3_lld_exit();=0D
+		return err;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static __exit void hinic3_nic_lld_exit(void)=0D
+{=0D
+	auxiliary_driver_unregister(&hinic3_nic_driver);=0D
+=0D
+	hinic3_lld_exit();=0D
+}=0D
+=0D
+module_init(hinic3_nic_lld_init);=0D
+module_exit(hinic3_nic_lld_exit);=0D
+=0D
+MODULE_AUTHOR("Huawei Technologies CO., Ltd");=0D
+MODULE_DESCRIPTION(HINIC3_NIC_DRV_DESC);=0D
+MODULE_LICENSE("GPL");=0D
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c b/drivers/net=
/ethernet/huawei/hinic3/hinic3_mbox.c=0D
new file mode 100644=0D
index 000000000000..e74d1eb09730=0D
--- /dev/null=0D
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c=0D
@@ -0,0 +1,16 @@=0D
+// SPDX-License-Identifier: GPL-2.0=0D
+// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.=
=0D
+=0D
+#include <linux/dma-mapping.h>=0D
+=0D
+#include "hinic3_common.h"=0D
+#include "hinic3_hwdev.h"=0D
+#include "hinic3_hwif.h"=0D
+#include "hinic3_mbox.h"=0D
+=0D
+int hinic3_send_mbox_to_mgmt(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,=
=0D
+			     const struct mgmt_msg_params *msg_params)=0D
+{=0D
+	/* Completed by later submission due to LoC limit. */=0D
+	return -EFAULT;=0D
+}=0D
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h b/drivers/net=
/ethernet/huawei/hinic3/hinic3_mbox.h=0D
new file mode 100644=0D
index 000000000000..d7a6c37b7eff=0D
--- /dev/null=0D
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mbox.h=0D
@@ -0,0 +1,15 @@=0D
+/* SPDX-License-Identifier: GPL-2.0 */=0D
+/* Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved. =
*/=0D
+=0D
+#ifndef _HINIC3_MBOX_H_=0D
+#define _HINIC3_MBOX_H_=0D
+=0D
+#include <linux/bitfield.h>=0D
+#include <linux/mutex.h>=0D
+=0D
+struct hinic3_hwdev;=0D
+=0D
+int hinic3_send_mbox_to_mgmt(struct hinic3_hwdev *hwdev, u8 mod, u16 cmd,=
=0D
+			     const struct mgmt_msg_params *msg_params);=0D
+=0D
+#endif=0D
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.h b/drivers/net=
/ethernet/huawei/hinic3/hinic3_mgmt.h=0D
new file mode 100644=0D
index 000000000000..4edabeb32112=0D
--- /dev/null=0D
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.h=0D
@@ -0,0 +1,13 @@=0D
+/* SPDX-License-Identifier: GPL-2.0 */=0D
+/* Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved. =
*/=0D
+=0D
+#ifndef _HINIC3_MGMT_H_=0D
+#define _HINIC3_MGMT_H_=0D
+=0D
+#include <linux/types.h>=0D
+=0D
+struct hinic3_hwdev;=0D
+=0D
+void hinic3_flush_mgmt_workq(struct hinic3_hwdev *hwdev);=0D
+=0D
+#endif=0D
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h b/d=
rivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h=0D
new file mode 100644=0D
index 000000000000..c4434efdc7f7=0D
--- /dev/null=0D
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h=0D
@@ -0,0 +1,105 @@=0D
+/* SPDX-License-Identifier: GPL-2.0 */=0D
+/* Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved. =
*/=0D
+=0D
+#ifndef _HINIC3_MGMT_INTERFACE_H_=0D
+#define _HINIC3_MGMT_INTERFACE_H_=0D
+=0D
+#include <linux/bitfield.h>=0D
+#include <linux/bits.h>=0D
+#include <linux/if_ether.h>=0D
+=0D
+#include "hinic3_hw_intf.h"=0D
+=0D
+struct l2nic_cmd_feature_nego {=0D
+	struct mgmt_msg_head msg_head;=0D
+	u16                  func_id;=0D
+	u8                   opcode;=0D
+	u8                   rsvd;=0D
+	u64                  s_feature[4];=0D
+};=0D
+=0D
+enum l2nic_func_tbl_cfg_bitmap {=0D
+	L2NIC_FUNC_TBL_CFG_INIT        =3D 0,=0D
+	L2NIC_FUNC_TBL_CFG_RX_BUF_SIZE =3D 1,=0D
+	L2NIC_FUNC_TBL_CFG_MTU         =3D 2,=0D
+};=0D
+=0D
+struct l2nic_func_tbl_cfg {=0D
+	u16 rx_wqe_buf_size;=0D
+	u16 mtu;=0D
+	u32 rsvd[9];=0D
+};=0D
+=0D
+struct l2nic_cmd_set_func_tbl {=0D
+	struct mgmt_msg_head      msg_head;=0D
+	u16                       func_id;=0D
+	u16                       rsvd;=0D
+	u32                       cfg_bitmap;=0D
+	struct l2nic_func_tbl_cfg tbl_cfg;=0D
+};=0D
+=0D
+struct l2nic_cmd_set_mac {=0D
+	struct mgmt_msg_head msg_head;=0D
+	u16                  func_id;=0D
+	u16                  vlan_id;=0D
+	u16                  rsvd1;=0D
+	u8                   mac[ETH_ALEN];=0D
+};=0D
+=0D
+struct l2nic_cmd_update_mac {=0D
+	struct mgmt_msg_head msg_head;=0D
+	u16                  func_id;=0D
+	u16                  vlan_id;=0D
+	u16                  rsvd1;=0D
+	u8                   old_mac[ETH_ALEN];=0D
+	u16                  rsvd2;=0D
+	u8                   new_mac[ETH_ALEN];=0D
+};=0D
+=0D
+struct l2nic_cmd_force_pkt_drop {=0D
+	struct mgmt_msg_head msg_head;=0D
+	u8                   port;=0D
+	u8                   rsvd1[3];=0D
+};=0D
+=0D
+/* Commands between NIC to fw */=0D
+enum l2nic_cmd {=0D
+	/* FUNC CFG */=0D
+	L2NIC_CMD_SET_FUNC_TBL        =3D 5,=0D
+	L2NIC_CMD_SET_VPORT_ENABLE    =3D 6,=0D
+	L2NIC_CMD_SET_SQ_CI_ATTR      =3D 8,=0D
+	L2NIC_CMD_CLEAR_QP_RESOURCE   =3D 11,=0D
+	L2NIC_CMD_FEATURE_NEGO        =3D 15,=0D
+	L2NIC_CMD_SET_MAC             =3D 21,=0D
+	L2NIC_CMD_DEL_MAC             =3D 22,=0D
+	L2NIC_CMD_UPDATE_MAC          =3D 23,=0D
+	L2NIC_CMD_CFG_RSS             =3D 60,=0D
+	L2NIC_CMD_CFG_RSS_HASH_KEY    =3D 63,=0D
+	L2NIC_CMD_CFG_RSS_HASH_ENGINE =3D 64,=0D
+	L2NIC_CMD_SET_RSS_CTX_TBL     =3D 65,=0D
+	L2NIC_CMD_QOS_DCB_STATE       =3D 110,=0D
+	L2NIC_CMD_FORCE_PKT_DROP      =3D 113,=0D
+	L2NIC_CMD_MAX                 =3D 256,=0D
+};=0D
+=0D
+enum hinic3_nic_feature_cap {=0D
+	HINIC3_NIC_F_CSUM           =3D BIT(0),=0D
+	HINIC3_NIC_F_SCTP_CRC       =3D BIT(1),=0D
+	HINIC3_NIC_F_TSO            =3D BIT(2),=0D
+	HINIC3_NIC_F_LRO            =3D BIT(3),=0D
+	HINIC3_NIC_F_UFO            =3D BIT(4),=0D
+	HINIC3_NIC_F_RSS            =3D BIT(5),=0D
+	HINIC3_NIC_F_RX_VLAN_FILTER =3D BIT(6),=0D
+	HINIC3_NIC_F_RX_VLAN_STRIP  =3D BIT(7),=0D
+	HINIC3_NIC_F_TX_VLAN_INSERT =3D BIT(8),=0D
+	HINIC3_NIC_F_VXLAN_OFFLOAD  =3D BIT(9),=0D
+	HINIC3_NIC_F_FDIR           =3D BIT(11),=0D
+	HINIC3_NIC_F_PROMISC        =3D BIT(12),=0D
+	HINIC3_NIC_F_ALLMULTI       =3D BIT(13),=0D
+	HINIC3_NIC_F_RATE_LIMIT     =3D BIT(16),=0D
+};=0D
+=0D
+#define HINIC3_NIC_F_ALL_MASK           0x33bff=0D
+#define HINIC3_NIC_DRV_DEFAULT_FEATURE  0x3f03f=0D
+=0D
+#endif=0D
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drive=
rs/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c=0D
new file mode 100644=0D
index 000000000000..71104a6b8bef=0D
--- /dev/null=0D
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c=0D
@@ -0,0 +1,78 @@=0D
+// SPDX-License-Identifier: GPL-2.0=0D
+// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.=
=0D
+=0D
+#include <linux/etherdevice.h>=0D
+#include <linux/netdevice.h>=0D
+=0D
+#include "hinic3_hwif.h"=0D
+#include "hinic3_nic_cfg.h"=0D
+#include "hinic3_nic_dev.h"=0D
+#include "hinic3_nic_io.h"=0D
+#include "hinic3_rx.h"=0D
+#include "hinic3_tx.h"=0D
+=0D
+static int hinic3_open(struct net_device *netdev)=0D
+{=0D
+	/* Completed by later submission due to LoC limit. */=0D
+	return -EFAULT;=0D
+}=0D
+=0D
+static int hinic3_close(struct net_device *netdev)=0D
+{=0D
+	/* Completed by later submission due to LoC limit. */=0D
+	return -EFAULT;=0D
+}=0D
+=0D
+static int hinic3_change_mtu(struct net_device *netdev, int new_mtu)=0D
+{=0D
+	int err;=0D
+=0D
+	err =3D hinic3_set_port_mtu(netdev, new_mtu);=0D
+	if (err) {=0D
+		netdev_err(netdev, "Failed to change port mtu to %d\n",=0D
+			   new_mtu);=0D
+		return err;=0D
+	}=0D
+=0D
+	netdev_dbg(netdev, "Change mtu from %u to %d\n", netdev->mtu, new_mtu);=0D
+	WRITE_ONCE(netdev->mtu, new_mtu);=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int hinic3_set_mac_addr(struct net_device *netdev, void *addr)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D netdev_priv(netdev);=0D
+	struct sockaddr *saddr =3D addr;=0D
+	int err;=0D
+=0D
+	if (!is_valid_ether_addr(saddr->sa_data))=0D
+		return -EADDRNOTAVAIL;=0D
+=0D
+	if (ether_addr_equal(netdev->dev_addr, saddr->sa_data))=0D
+		return 0;=0D
+=0D
+	err =3D hinic3_update_mac(nic_dev->hwdev, netdev->dev_addr,=0D
+				saddr->sa_data, 0,=0D
+				hinic3_global_func_id(nic_dev->hwdev));=0D
+=0D
+	if (err)=0D
+		return err;=0D
+=0D
+	eth_hw_addr_set(netdev, saddr->sa_data);=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static const struct net_device_ops hinic3_netdev_ops =3D {=0D
+	.ndo_open             =3D hinic3_open,=0D
+	.ndo_stop             =3D hinic3_close,=0D
+	.ndo_change_mtu       =3D hinic3_change_mtu,=0D
+	.ndo_set_mac_address  =3D hinic3_set_mac_addr,=0D
+	.ndo_start_xmit       =3D hinic3_xmit_frame,=0D
+};=0D
+=0D
+void hinic3_set_netdev_ops(struct net_device *netdev)=0D
+{=0D
+	netdev->netdev_ops =3D &hinic3_netdev_ops;=0D
+}=0D
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c b/drivers/=
net/ethernet/huawei/hinic3/hinic3_nic_cfg.c=0D
new file mode 100644=0D
index 000000000000..5b1a91a18c67=0D
--- /dev/null=0D
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c=0D
@@ -0,0 +1,233 @@=0D
+// SPDX-License-Identifier: GPL-2.0=0D
+// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.=
=0D
+=0D
+#include <linux/if_vlan.h>=0D
+=0D
+#include "hinic3_hwdev.h"=0D
+#include "hinic3_hwif.h"=0D
+#include "hinic3_mbox.h"=0D
+#include "hinic3_nic_cfg.h"=0D
+#include "hinic3_nic_dev.h"=0D
+#include "hinic3_nic_io.h"=0D
+=0D
+static int hinic3_feature_nego(struct hinic3_hwdev *hwdev, u8 opcode,=0D
+			       u64 *s_feature, u16 size)=0D
+{=0D
+	struct l2nic_cmd_feature_nego feature_nego =3D {};=0D
+	struct mgmt_msg_params msg_params =3D {};=0D
+	int err;=0D
+=0D
+	feature_nego.func_id =3D hinic3_global_func_id(hwdev);=0D
+	feature_nego.opcode =3D opcode;=0D
+	if (opcode =3D=3D MGMT_MSG_CMD_OP_SET)=0D
+		memcpy(feature_nego.s_feature, s_feature, size * sizeof(u64));=0D
+=0D
+	mgmt_msg_params_init_default(&msg_params, &feature_nego,=0D
+				     sizeof(feature_nego));=0D
+=0D
+	err =3D hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,=0D
+				       L2NIC_CMD_FEATURE_NEGO, &msg_params);=0D
+	if (err || feature_nego.msg_head.status) {=0D
+		dev_err(hwdev->dev, "Failed to negotiate nic feature, err:%d, status: 0x=
%x\n",=0D
+			err, feature_nego.msg_head.status);=0D
+		return -EIO;=0D
+	}=0D
+=0D
+	if (opcode =3D=3D MGMT_MSG_CMD_OP_GET)=0D
+		memcpy(s_feature, feature_nego.s_feature, size * sizeof(u64));=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int hinic3_set_nic_feature_to_hw(struct hinic3_nic_dev *nic_dev)=0D
+{=0D
+	return hinic3_feature_nego(nic_dev->hwdev, MGMT_MSG_CMD_OP_SET,=0D
+				   &nic_dev->nic_io->feature_cap, 1);=0D
+}=0D
+=0D
+bool hinic3_test_support(struct hinic3_nic_dev *nic_dev,=0D
+			 enum hinic3_nic_feature_cap feature_bits)=0D
+{=0D
+	return (nic_dev->nic_io->feature_cap & feature_bits) =3D=3D feature_bits;=
=0D
+}=0D
+=0D
+void hinic3_update_nic_feature(struct hinic3_nic_dev *nic_dev, u64 feature=
_cap)=0D
+{=0D
+	nic_dev->nic_io->feature_cap =3D feature_cap;=0D
+}=0D
+=0D
+static int hinic3_set_function_table(struct hinic3_hwdev *hwdev, u32 cfg_b=
itmap,=0D
+				     const struct l2nic_func_tbl_cfg *cfg)=0D
+{=0D
+	struct l2nic_cmd_set_func_tbl cmd_func_tbl =3D {};=0D
+	struct mgmt_msg_params msg_params =3D {};=0D
+	int err;=0D
+=0D
+	cmd_func_tbl.func_id =3D hinic3_global_func_id(hwdev);=0D
+	cmd_func_tbl.cfg_bitmap =3D cfg_bitmap;=0D
+	cmd_func_tbl.tbl_cfg =3D *cfg;=0D
+=0D
+	mgmt_msg_params_init_default(&msg_params, &cmd_func_tbl,=0D
+				     sizeof(cmd_func_tbl));=0D
+=0D
+	err =3D hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,=0D
+				       L2NIC_CMD_SET_FUNC_TBL, &msg_params);=0D
+	if (err || cmd_func_tbl.msg_head.status) {=0D
+		dev_err(hwdev->dev,=0D
+			"Failed to set func table, bitmap: 0x%x, err: %d, status: 0x%x\n",=0D
+			cfg_bitmap, err, cmd_func_tbl.msg_head.status);=0D
+		return -EFAULT;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int hinic3_set_port_mtu(struct net_device *netdev, u16 new_mtu)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D netdev_priv(netdev);=0D
+	struct l2nic_func_tbl_cfg func_tbl_cfg =3D {};=0D
+	struct hinic3_hwdev *hwdev =3D nic_dev->hwdev;=0D
+=0D
+	func_tbl_cfg.mtu =3D new_mtu;=0D
+	return hinic3_set_function_table(hwdev, BIT(L2NIC_FUNC_TBL_CFG_MTU),=0D
+					 &func_tbl_cfg);=0D
+}=0D
+=0D
+static int hinic3_check_mac_info(struct hinic3_hwdev *hwdev, u8 status,=0D
+				 u16 vlan_id)=0D
+{=0D
+	if ((status && status !=3D MGMT_STATUS_EXIST) ||=0D
+	    ((vlan_id & BIT(15)) && status =3D=3D MGMT_STATUS_EXIST)) {=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int hinic3_set_mac(struct hinic3_hwdev *hwdev, const u8 *mac_addr, u16 vla=
n_id,=0D
+		   u16 func_id)=0D
+{=0D
+	struct l2nic_cmd_set_mac mac_info =3D {};=0D
+	struct mgmt_msg_params msg_params =3D {};=0D
+	int err;=0D
+=0D
+	if ((vlan_id & HINIC3_VLAN_ID_MASK) >=3D VLAN_N_VID) {=0D
+		dev_err(hwdev->dev, "Invalid VLAN number: %d\n",=0D
+			(vlan_id & HINIC3_VLAN_ID_MASK));=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	mac_info.func_id =3D func_id;=0D
+	mac_info.vlan_id =3D vlan_id;=0D
+	ether_addr_copy(mac_info.mac, mac_addr);=0D
+=0D
+	mgmt_msg_params_init_default(&msg_params, &mac_info, sizeof(mac_info));=0D
+=0D
+	err =3D hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,=0D
+				       L2NIC_CMD_SET_MAC, &msg_params);=0D
+	if (err || hinic3_check_mac_info(hwdev, mac_info.msg_head.status,=0D
+					 mac_info.vlan_id)) {=0D
+		dev_err(hwdev->dev,=0D
+			"Failed to update MAC, err: %d, status: 0x%x\n",=0D
+			err, mac_info.msg_head.status);=0D
+		return -EIO;=0D
+	}=0D
+=0D
+	if (mac_info.msg_head.status =3D=3D MGMT_STATUS_PF_SET_VF_ALREADY) {=0D
+		dev_warn(hwdev->dev, "PF has already set VF mac, Ignore set operation\n"=
);=0D
+		return 0;=0D
+	}=0D
+=0D
+	if (mac_info.msg_head.status =3D=3D MGMT_STATUS_EXIST) {=0D
+		dev_warn(hwdev->dev, "MAC is repeated. Ignore update operation\n");=0D
+		return 0;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int hinic3_del_mac(struct hinic3_hwdev *hwdev, const u8 *mac_addr, u16 vla=
n_id,=0D
+		   u16 func_id)=0D
+{=0D
+	struct l2nic_cmd_set_mac mac_info =3D {};=0D
+	struct mgmt_msg_params msg_params =3D {};=0D
+	int err;=0D
+=0D
+	if ((vlan_id & HINIC3_VLAN_ID_MASK) >=3D VLAN_N_VID) {=0D
+		dev_err(hwdev->dev, "Invalid VLAN number: %d\n",=0D
+			(vlan_id & HINIC3_VLAN_ID_MASK));=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	mac_info.func_id =3D func_id;=0D
+	mac_info.vlan_id =3D vlan_id;=0D
+	ether_addr_copy(mac_info.mac, mac_addr);=0D
+=0D
+	mgmt_msg_params_init_default(&msg_params, &mac_info, sizeof(mac_info));=0D
+=0D
+	err =3D hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,=0D
+				       L2NIC_CMD_DEL_MAC, &msg_params);=0D
+	if (err) {=0D
+		dev_err(hwdev->dev,=0D
+			"Failed to delete MAC, err: %d, status: 0x%x\n",=0D
+			err, mac_info.msg_head.status);=0D
+		return err;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int hinic3_update_mac(struct hinic3_hwdev *hwdev, const u8 *old_mac,=0D
+		      u8 *new_mac, u16 vlan_id, u16 func_id)=0D
+{=0D
+	struct l2nic_cmd_update_mac mac_info =3D {};=0D
+	struct mgmt_msg_params msg_params =3D {};=0D
+	int err;=0D
+=0D
+	if ((vlan_id & HINIC3_VLAN_ID_MASK) >=3D VLAN_N_VID) {=0D
+		dev_err(hwdev->dev, "Invalid VLAN number: %d\n",=0D
+			(vlan_id & HINIC3_VLAN_ID_MASK));=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	mac_info.func_id =3D func_id;=0D
+	mac_info.vlan_id =3D vlan_id;=0D
+	ether_addr_copy(mac_info.old_mac, old_mac);=0D
+	ether_addr_copy(mac_info.new_mac, new_mac);=0D
+=0D
+	mgmt_msg_params_init_default(&msg_params, &mac_info, sizeof(mac_info));=0D
+=0D
+	err =3D hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,=0D
+				       L2NIC_CMD_UPDATE_MAC, &msg_params);=0D
+	if (err || hinic3_check_mac_info(hwdev, mac_info.msg_head.status,=0D
+					 mac_info.vlan_id)) {=0D
+		dev_err(hwdev->dev,=0D
+			"Failed to update MAC, err: %d, status: 0x%x\n",=0D
+			err, mac_info.msg_head.status);=0D
+		return -EIO;=0D
+	}=0D
+	return 0;=0D
+}=0D
+=0D
+int hinic3_force_drop_tx_pkt(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	struct l2nic_cmd_force_pkt_drop pkt_drop =3D {};=0D
+	struct mgmt_msg_params msg_params =3D {};=0D
+	int err;=0D
+=0D
+	pkt_drop.port =3D hinic3_physical_port_id(hwdev);=0D
+=0D
+	mgmt_msg_params_init_default(&msg_params, &pkt_drop, sizeof(pkt_drop));=0D
+=0D
+	err =3D hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,=0D
+				       L2NIC_CMD_FORCE_PKT_DROP, &msg_params);=0D
+	if ((pkt_drop.msg_head.status !=3D MGMT_STATUS_CMD_UNSUPPORTED &&=0D
+	     pkt_drop.msg_head.status) || err) {=0D
+		dev_err(hwdev->dev,=0D
+			"Failed to set force tx packets drop, err: %d, status: 0x%x\n",=0D
+			err, pkt_drop.msg_head.status);=0D
+		return -EFAULT;=0D
+	}=0D
+=0D
+	return pkt_drop.msg_head.status;=0D
+}=0D
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h b/drivers/=
net/ethernet/huawei/hinic3/hinic3_nic_cfg.h=0D
new file mode 100644=0D
index 000000000000..bf9ce51dc401=0D
--- /dev/null=0D
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.h=0D
@@ -0,0 +1,41 @@=0D
+/* SPDX-License-Identifier: GPL-2.0 */=0D
+/* Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved. =
*/=0D
+=0D
+#ifndef _HINIC3_NIC_CFG_H_=0D
+#define _HINIC3_NIC_CFG_H_=0D
+=0D
+#include <linux/types.h>=0D
+=0D
+#include "hinic3_hw_intf.h"=0D
+#include "hinic3_mgmt_interface.h"=0D
+=0D
+struct hinic3_hwdev;=0D
+struct hinic3_nic_dev;=0D
+=0D
+#define HINIC3_MIN_MTU_SIZE          256=0D
+#define HINIC3_MAX_JUMBO_FRAME_SIZE  9600=0D
+=0D
+#define HINIC3_VLAN_ID_MASK          0x7FFF=0D
+=0D
+enum hinic3_nic_event_type {=0D
+	HINIC3_NIC_EVENT_LINK_DOWN =3D 0,=0D
+	HINIC3_NIC_EVENT_LINK_UP   =3D 1,=0D
+};=0D
+=0D
+int hinic3_set_nic_feature_to_hw(struct hinic3_nic_dev *nic_dev);=0D
+bool hinic3_test_support(struct hinic3_nic_dev *nic_dev,=0D
+			 enum hinic3_nic_feature_cap feature_bits);=0D
+void hinic3_update_nic_feature(struct hinic3_nic_dev *nic_dev, u64 feature=
_cap);=0D
+=0D
+int hinic3_set_port_mtu(struct net_device *netdev, u16 new_mtu);=0D
+=0D
+int hinic3_set_mac(struct hinic3_hwdev *hwdev, const u8 *mac_addr, u16 vla=
n_id,=0D
+		   u16 func_id);=0D
+int hinic3_del_mac(struct hinic3_hwdev *hwdev, const u8 *mac_addr, u16 vla=
n_id,=0D
+		   u16 func_id);=0D
+int hinic3_update_mac(struct hinic3_hwdev *hwdev, const u8 *old_mac,=0D
+		      u8 *new_mac, u16 vlan_id, u16 func_id);=0D
+=0D
+int hinic3_force_drop_tx_pkt(struct hinic3_hwdev *hwdev);=0D
+=0D
+#endif=0D
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h b/drivers/=
net/ethernet/huawei/hinic3/hinic3_nic_dev.h=0D
new file mode 100644=0D
index 000000000000..105f8fb92f30=0D
--- /dev/null=0D
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h=0D
@@ -0,0 +1,89 @@=0D
+/* SPDX-License-Identifier: GPL-2.0 */=0D
+/* Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved. =
*/=0D
+=0D
+#ifndef _HINIC3_NIC_DEV_H_=0D
+#define _HINIC3_NIC_DEV_H_=0D
+=0D
+#include <linux/netdevice.h>=0D
+=0D
+#include "hinic3_hw_cfg.h"=0D
+#include "hinic3_mgmt_interface.h"=0D
+=0D
+enum hinic3_flags {=0D
+	HINIC3_INTF_UP,=0D
+	HINIC3_RSS_ENABLE,=0D
+	HINIC3_CHANGE_RES_INVALID,=0D
+	HINIC3_RSS_DEFAULT_INDIR,=0D
+};=0D
+=0D
+#define HINIC3_CHANNEL_RES_VALID(nic_dev) \=0D
+	(test_bit(HINIC3_INTF_UP, &(nic_dev)->flags) && \=0D
+	 !test_bit(HINIC3_CHANGE_RES_INVALID, &(nic_dev)->flags))=0D
+=0D
+enum hinic3_rss_hash_type {=0D
+	HINIC3_RSS_HASH_ENGINE_TYPE_XOR  =3D 0,=0D
+	HINIC3_RSS_HASH_ENGINE_TYPE_TOEP =3D 1,=0D
+};=0D
+=0D
+struct hinic3_rss_type {=0D
+	u8 tcp_ipv6_ext;=0D
+	u8 ipv6_ext;=0D
+	u8 tcp_ipv6;=0D
+	u8 ipv6;=0D
+	u8 tcp_ipv4;=0D
+	u8 ipv4;=0D
+	u8 udp_ipv6;=0D
+	u8 udp_ipv4;=0D
+};=0D
+=0D
+struct hinic3_irq_cfg {=0D
+	struct net_device  *netdev;=0D
+	u16                msix_entry_idx;=0D
+	/* provided by OS */=0D
+	u32                irq_id;=0D
+	char               irq_name[IFNAMSIZ + 16];=0D
+	struct napi_struct napi;=0D
+	cpumask_t          affinity_mask;=0D
+	struct hinic3_txq  *txq;=0D
+	struct hinic3_rxq  *rxq;=0D
+};=0D
+=0D
+struct hinic3_dyna_txrxq_params {=0D
+	u16                        num_qps;=0D
+	u32                        sq_depth;=0D
+	u32                        rq_depth;=0D
+=0D
+	struct hinic3_dyna_txq_res *txqs_res;=0D
+	struct hinic3_dyna_rxq_res *rxqs_res;=0D
+	struct hinic3_irq_cfg      *irq_cfg;=0D
+};=0D
+=0D
+struct hinic3_nic_dev {=0D
+	struct pci_dev                  *pdev;=0D
+	struct net_device               *netdev;=0D
+	struct hinic3_hwdev             *hwdev;=0D
+	struct hinic3_nic_io            *nic_io;=0D
+=0D
+	u16                             max_qps;=0D
+	u16                             rx_buf_len;=0D
+	u32                             lro_replenish_thld;=0D
+	unsigned long                   flags;=0D
+	struct hinic3_nic_service_cap   nic_svc_cap;=0D
+=0D
+	struct hinic3_dyna_txrxq_params q_params;=0D
+	struct hinic3_txq               *txqs;=0D
+	struct hinic3_rxq               *rxqs;=0D
+=0D
+	u16                             num_qp_irq;=0D
+	struct msix_entry               *qps_msix_entries;=0D
+=0D
+	bool                            link_status_up;=0D
+};=0D
+=0D
+void hinic3_set_netdev_ops(struct net_device *netdev);=0D
+=0D
+/* Temporary prototypes. Functions become static in later submission. */=0D
+void qp_add_napi(struct hinic3_irq_cfg *irq_cfg);=0D
+void qp_del_napi(struct hinic3_irq_cfg *irq_cfg);=0D
+=0D
+#endif=0D
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c b/drivers/n=
et/ethernet/huawei/hinic3/hinic3_nic_io.c=0D
new file mode 100644=0D
index 000000000000..34a1f5bd5ac1=0D
--- /dev/null=0D
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c=0D
@@ -0,0 +1,21 @@=0D
+// SPDX-License-Identifier: GPL-2.0=0D
+// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.=
=0D
+=0D
+#include "hinic3_hw_comm.h"=0D
+#include "hinic3_hw_intf.h"=0D
+#include "hinic3_hwdev.h"=0D
+#include "hinic3_hwif.h"=0D
+#include "hinic3_nic_cfg.h"=0D
+#include "hinic3_nic_dev.h"=0D
+#include "hinic3_nic_io.h"=0D
+=0D
+int hinic3_init_nic_io(struct hinic3_nic_dev *nic_dev)=0D
+{=0D
+	/* Completed by later submission due to LoC limit. */=0D
+	return -EFAULT;=0D
+}=0D
+=0D
+void hinic3_free_nic_io(struct hinic3_nic_dev *nic_dev)=0D
+{=0D
+	/* Completed by later submission due to LoC limit. */=0D
+}=0D
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h b/drivers/n=
et/ethernet/huawei/hinic3/hinic3_nic_io.h=0D
new file mode 100644=0D
index 000000000000..865ba6878c48=0D
--- /dev/null=0D
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h=0D
@@ -0,0 +1,120 @@=0D
+/* SPDX-License-Identifier: GPL-2.0 */=0D
+/* Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved. =
*/=0D
+=0D
+#ifndef _HINIC3_NIC_IO_H_=0D
+#define _HINIC3_NIC_IO_H_=0D
+=0D
+#include <linux/bitfield.h>=0D
+=0D
+#include "hinic3_wq.h"=0D
+=0D
+struct hinic3_nic_dev;=0D
+=0D
+#define HINIC3_SQ_WQEBB_SHIFT      4=0D
+#define HINIC3_RQ_WQEBB_SHIFT      3=0D
+#define HINIC3_SQ_WQEBB_SIZE       BIT(HINIC3_SQ_WQEBB_SHIFT)=0D
+=0D
+/* ******************** RQ_CTRL ******************** */=0D
+enum hinic3_rq_wqe_type {=0D
+	HINIC3_NORMAL_RQ_WQE =3D 1,=0D
+};=0D
+=0D
+/* ******************** SQ_CTRL ******************** */=0D
+#define HINIC3_TX_MSS_DEFAULT  0x3E00=0D
+#define HINIC3_TX_MSS_MIN      0x50=0D
+#define HINIC3_MAX_SQ_SGE      18=0D
+=0D
+struct hinic3_io_queue {=0D
+	struct hinic3_wq  wq;=0D
+	u8                owner;=0D
+	u16               q_id;=0D
+	u16               msix_entry_idx;=0D
+	u8 __iomem        *db_addr;=0D
+	u16               *cons_idx_addr;=0D
+} ____cacheline_aligned;=0D
+=0D
+static inline u16 hinic3_get_sq_local_ci(const struct hinic3_io_queue *sq)=
=0D
+{=0D
+	const struct hinic3_wq *wq =3D &sq->wq;=0D
+=0D
+	return wq->cons_idx & wq->idx_mask;=0D
+}=0D
+=0D
+static inline u16 hinic3_get_sq_local_pi(const struct hinic3_io_queue *sq)=
=0D
+{=0D
+	const struct hinic3_wq *wq =3D &sq->wq;=0D
+=0D
+	return wq->prod_idx & wq->idx_mask;=0D
+}=0D
+=0D
+static inline u16 hinic3_get_sq_hw_ci(const struct hinic3_io_queue *sq)=0D
+{=0D
+	const struct hinic3_wq *wq =3D &sq->wq;=0D
+=0D
+	return READ_ONCE(*sq->cons_idx_addr) & wq->idx_mask;=0D
+}=0D
+=0D
+/* ******************** DB INFO ******************** */=0D
+#define DB_INFO_QID_MASK    GENMASK(12, 0)=0D
+#define DB_INFO_CFLAG_MASK  BIT(23)=0D
+#define DB_INFO_COS_MASK    GENMASK(26, 24)=0D
+#define DB_INFO_TYPE_MASK   GENMASK(31, 27)=0D
+#define DB_INFO_SET(val, member)  \=0D
+	FIELD_PREP(DB_INFO_##member##_MASK, val)=0D
+=0D
+#define DB_PI_LOW_MASK   0xFFU=0D
+#define DB_PI_HIGH_MASK  0xFFU=0D
+#define DB_PI_HI_SHIFT   8=0D
+#define DB_PI_LOW(pi)    ((pi) & DB_PI_LOW_MASK)=0D
+#define DB_PI_HIGH(pi)   (((pi) >> DB_PI_HI_SHIFT) & DB_PI_HIGH_MASK)=0D
+#define DB_ADDR(q, pi)   ((u64 __iomem *)((q)->db_addr) + DB_PI_LOW(pi))=0D
+#define DB_SRC_TYPE      1=0D
+=0D
+/* CFLAG_DATA_PATH */=0D
+#define DB_CFLAG_DP_SQ   0=0D
+#define DB_CFLAG_DP_RQ   1=0D
+=0D
+struct hinic3_nic_db {=0D
+	u32 db_info;=0D
+	u32 pi_hi;=0D
+};=0D
+=0D
+static inline void hinic3_write_db(struct hinic3_io_queue *queue, int cos,=
=0D
+				   u8 cflag, u16 pi)=0D
+{=0D
+	struct hinic3_nic_db db;=0D
+=0D
+	db.db_info =3D DB_INFO_SET(DB_SRC_TYPE, TYPE) |=0D
+		     DB_INFO_SET(cflag, CFLAG) |=0D
+		     DB_INFO_SET(cos, COS) |=0D
+		     DB_INFO_SET(queue->q_id, QID);=0D
+	db.pi_hi =3D DB_PI_HIGH(pi);=0D
+=0D
+	writeq(*((u64 *)&db), DB_ADDR(queue, pi));=0D
+}=0D
+=0D
+struct hinic3_nic_io {=0D
+	struct hinic3_io_queue *sq;=0D
+	struct hinic3_io_queue *rq;=0D
+=0D
+	u16                    num_qps;=0D
+	u16                    max_qps;=0D
+=0D
+	/* Base address for consumer index of all tx queues. Each queue is=0D
+	 * given a full cache line to hold its consumer index. HW updates=0D
+	 * current consumer index as it consumes tx WQEs.=0D
+	 */=0D
+	void                   *ci_vaddr_base;=0D
+	dma_addr_t             ci_dma_base;=0D
+=0D
+	u8 __iomem             *sqs_db_addr;=0D
+	u8 __iomem             *rqs_db_addr;=0D
+=0D
+	u16                    rx_buf_len;=0D
+	u64                    feature_cap;=0D
+};=0D
+=0D
+int hinic3_init_nic_io(struct hinic3_nic_dev *nic_dev);=0D
+void hinic3_free_nic_io(struct hinic3_nic_dev *nic_dev);=0D
+=0D
+#endif=0D
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_queue_common.c b/dri=
vers/net/ethernet/huawei/hinic3/hinic3_queue_common.c=0D
new file mode 100644=0D
index 000000000000..fab9011de9ad=0D
--- /dev/null=0D
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_queue_common.c=0D
@@ -0,0 +1,68 @@=0D
+// SPDX-License-Identifier: GPL-2.0=0D
+// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.=
=0D
+=0D
+#include <linux/device.h>=0D
+=0D
+#include "hinic3_hwdev.h"=0D
+#include "hinic3_queue_common.h"=0D
+=0D
+void hinic3_queue_pages_init(struct hinic3_queue_pages *qpages, u32 q_dept=
h,=0D
+			     u32 page_size, u32 elem_size)=0D
+{=0D
+	u32 elem_per_page;=0D
+=0D
+	elem_per_page =3D min(page_size / elem_size, q_depth);=0D
+=0D
+	qpages->pages =3D NULL;=0D
+	qpages->page_size =3D page_size;=0D
+	qpages->num_pages =3D max(q_depth / elem_per_page, 1);=0D
+	qpages->elem_size_shift =3D ilog2(elem_size);=0D
+	qpages->elem_per_pg_shift =3D ilog2(elem_per_page);=0D
+}=0D
+=0D
+static void __queue_pages_free(struct hinic3_hwdev *hwdev,=0D
+			       struct hinic3_queue_pages *qpages, u32 pg_cnt)=0D
+{=0D
+	while (pg_cnt > 0) {=0D
+		pg_cnt--;=0D
+		hinic3_dma_free_coherent_align(hwdev->dev,=0D
+					       qpages->pages + pg_cnt);=0D
+	}=0D
+	kfree(qpages->pages);=0D
+	qpages->pages =3D NULL;=0D
+}=0D
+=0D
+void hinic3_queue_pages_free(struct hinic3_hwdev *hwdev,=0D
+			     struct hinic3_queue_pages *qpages)=0D
+{=0D
+	__queue_pages_free(hwdev, qpages, qpages->num_pages);=0D
+}=0D
+=0D
+int hinic3_queue_pages_alloc(struct hinic3_hwdev *hwdev,=0D
+			     struct hinic3_queue_pages *qpages, u32 align)=0D
+{=0D
+	u32 pg_idx;=0D
+	int err;=0D
+=0D
+	qpages->pages =3D kcalloc(qpages->num_pages, sizeof(qpages->pages[0]),=0D
+				GFP_KERNEL);=0D
+	if (!qpages->pages)=0D
+		return -ENOMEM;=0D
+=0D
+	if (align =3D=3D 0)=0D
+		align =3D qpages->page_size;=0D
+=0D
+	for (pg_idx =3D 0; pg_idx < qpages->num_pages; pg_idx++) {=0D
+		err =3D hinic3_dma_zalloc_coherent_align(hwdev->dev,=0D
+						       qpages->page_size,=0D
+						       align,=0D
+						       GFP_KERNEL,=0D
+						       qpages->pages + pg_idx);=0D
+		if (err) {=0D
+			__queue_pages_free(hwdev, qpages, pg_idx);=0D
+			return err;=0D
+		}=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_queue_common.h b/dri=
vers/net/ethernet/huawei/hinic3/hinic3_queue_common.h=0D
new file mode 100644=0D
index 000000000000..ec4cae0a0929=0D
--- /dev/null=0D
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_queue_common.h=0D
@@ -0,0 +1,54 @@=0D
+/* SPDX-License-Identifier: GPL-2.0 */=0D
+/* Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved. =
*/=0D
+=0D
+#ifndef _HINIC3_QUEUE_COMMON_H_=0D
+#define _HINIC3_QUEUE_COMMON_H_=0D
+=0D
+#include <linux/types.h>=0D
+=0D
+#include "hinic3_common.h"=0D
+=0D
+struct hinic3_hwdev;=0D
+=0D
+struct hinic3_queue_pages {=0D
+	/* Array of DMA-able pages that actually holds the queue entries. */=0D
+	struct hinic3_dma_addr_align  *pages;=0D
+	/* Page size in bytes. */=0D
+	u32                           page_size;=0D
+	/* Number of pages, must be power of 2. */=0D
+	u16                           num_pages;=0D
+	u8                            elem_size_shift;=0D
+	u8                            elem_per_pg_shift;=0D
+};=0D
+=0D
+void hinic3_queue_pages_init(struct hinic3_queue_pages *qpages, u32 q_dept=
h,=0D
+			     u32 page_size, u32 elem_size);=0D
+int hinic3_queue_pages_alloc(struct hinic3_hwdev *hwdev,=0D
+			     struct hinic3_queue_pages *qpages, u32 align);=0D
+void hinic3_queue_pages_free(struct hinic3_hwdev *hwdev,=0D
+			     struct hinic3_queue_pages *qpages);=0D
+=0D
+/* Get pointer to queue entry at the specified index. Index does not have =
to be=0D
+ * masked to queue depth, only least significant bits will be used. Also=0D
+ * provides remaining elements in same page (including the first one) in c=
ase=0D
+ * caller needs multiple entries.=0D
+ */=0D
+static inline void *get_q_element(const struct hinic3_queue_pages *qpages,=
=0D
+				  u32 idx, u32 *remaining_in_page)=0D
+{=0D
+	const struct hinic3_dma_addr_align *page;=0D
+	u32 page_idx, elem_idx, elem_per_pg, ofs;=0D
+	u8 shift;=0D
+=0D
+	shift =3D qpages->elem_per_pg_shift;=0D
+	page_idx =3D (idx >> shift) & (qpages->num_pages - 1);=0D
+	elem_per_pg =3D 1 << shift;=0D
+	elem_idx =3D idx & (elem_per_pg - 1);=0D
+	if (remaining_in_page)=0D
+		*remaining_in_page =3D elem_per_pg - elem_idx;=0D
+	ofs =3D elem_idx << qpages->elem_size_shift;=0D
+	page =3D qpages->pages + page_idx;=0D
+	return (char *)page->align_vaddr + ofs;=0D
+}=0D
+=0D
+#endif=0D
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c b/drivers/net/e=
thernet/huawei/hinic3/hinic3_rx.c=0D
new file mode 100644=0D
index 000000000000..860163e9d66c=0D
--- /dev/null=0D
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c=0D
@@ -0,0 +1,341 @@=0D
+// SPDX-License-Identifier: GPL-2.0=0D
+// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.=
=0D
+=0D
+#include <linux/etherdevice.h>=0D
+#include <linux/if_vlan.h>=0D
+#include <linux/netdevice.h>=0D
+#include <net/gro.h>=0D
+#include <net/page_pool/helpers.h>=0D
+=0D
+#include "hinic3_hwdev.h"=0D
+#include "hinic3_nic_dev.h"=0D
+#include "hinic3_nic_io.h"=0D
+#include "hinic3_rx.h"=0D
+=0D
+#define HINIC3_RX_HDR_SIZE              256=0D
+#define HINIC3_RX_BUFFER_WRITE          16=0D
+=0D
+#define HINIC3_RX_TCP_PKT               0x3=0D
+#define HINIC3_RX_UDP_PKT               0x4=0D
+#define HINIC3_RX_SCTP_PKT              0x7=0D
+=0D
+#define HINIC3_RX_IPV4_PKT              0=0D
+#define HINIC3_RX_IPV6_PKT              1=0D
+#define HINIC3_RX_INVALID_IP_TYPE       2=0D
+=0D
+#define HINIC3_RX_PKT_FORMAT_NON_TUNNEL 0=0D
+#define HINIC3_RX_PKT_FORMAT_VXLAN      1=0D
+=0D
+#define HINIC3_LRO_PKT_HDR_LEN_IPV4     66=0D
+#define HINIC3_LRO_PKT_HDR_LEN_IPV6     86=0D
+#define HINIC3_LRO_PKT_HDR_LEN(cqe) \=0D
+	(RQ_CQE_OFFOLAD_TYPE_GET((cqe)->offload_type, IP_TYPE) =3D=3D \=0D
+	 HINIC3_RX_IPV6_PKT ? HINIC3_LRO_PKT_HDR_LEN_IPV6 : \=0D
+	 HINIC3_LRO_PKT_HDR_LEN_IPV4)=0D
+=0D
+int hinic3_alloc_rxqs(struct net_device *netdev)=0D
+{=0D
+	/* Completed by later submission due to LoC limit. */=0D
+	return -EFAULT;=0D
+}=0D
+=0D
+void hinic3_free_rxqs(struct net_device *netdev)=0D
+{=0D
+	/* Completed by later submission due to LoC limit. */=0D
+}=0D
+=0D
+static int rx_alloc_mapped_page(struct page_pool *page_pool,=0D
+				struct hinic3_rx_info *rx_info, u16 buf_len)=0D
+{=0D
+	struct page *page;=0D
+	u32 page_offset;=0D
+=0D
+	page =3D page_pool_dev_alloc_frag(page_pool, &page_offset, buf_len);=0D
+	if (unlikely(!page))=0D
+		return -ENOMEM;=0D
+=0D
+	rx_info->page =3D page;=0D
+	rx_info->page_offset =3D page_offset;=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static void rq_wqe_buf_set(struct hinic3_io_queue *rq, uint32_t wqe_idx,=0D
+			   dma_addr_t dma_addr, u16 len)=0D
+{=0D
+	struct hinic3_rq_wqe *rq_wqe;=0D
+=0D
+	rq_wqe =3D get_q_element(&rq->wq.qpages, wqe_idx, NULL);=0D
+	rq_wqe->buf_hi_addr =3D upper_32_bits(dma_addr);=0D
+	rq_wqe->buf_lo_addr =3D lower_32_bits(dma_addr);=0D
+}=0D
+=0D
+static u32 hinic3_rx_fill_buffers(struct hinic3_rxq *rxq)=0D
+{=0D
+	u32 i, free_wqebbs =3D rxq->delta - 1;=0D
+	struct hinic3_rx_info *rx_info;=0D
+	dma_addr_t dma_addr;=0D
+	int err;=0D
+=0D
+	for (i =3D 0; i < free_wqebbs; i++) {=0D
+		rx_info =3D &rxq->rx_info[rxq->next_to_update];=0D
+=0D
+		err =3D rx_alloc_mapped_page(rxq->page_pool, rx_info,=0D
+					   rxq->buf_len);=0D
+		if (unlikely(err))=0D
+			break;=0D
+=0D
+		dma_addr =3D page_pool_get_dma_addr(rx_info->page) +=0D
+			rx_info->page_offset;=0D
+		rq_wqe_buf_set(rxq->rq, rxq->next_to_update, dma_addr,=0D
+			       rxq->buf_len);=0D
+		rxq->next_to_update =3D (rxq->next_to_update + 1) & rxq->q_mask;=0D
+	}=0D
+=0D
+	if (likely(i)) {=0D
+		hinic3_write_db(rxq->rq, rxq->q_id & 3, DB_CFLAG_DP_RQ,=0D
+				rxq->next_to_update << HINIC3_NORMAL_RQ_WQE);=0D
+		rxq->delta -=3D i;=0D
+		rxq->next_to_alloc =3D rxq->next_to_update;=0D
+	}=0D
+=0D
+	return i;=0D
+}=0D
+=0D
+static void hinic3_add_rx_frag(struct hinic3_rxq *rxq,=0D
+			       struct hinic3_rx_info *rx_info,=0D
+			       struct sk_buff *skb, u32 size)=0D
+{=0D
+	struct page *page;=0D
+	u8 *va;=0D
+=0D
+	page =3D rx_info->page;=0D
+	va =3D (u8 *)page_address(page) + rx_info->page_offset;=0D
+	net_prefetch(va);=0D
+=0D
+	page_pool_dma_sync_for_cpu(rxq->page_pool, page, rx_info->page_offset,=0D
+				   rxq->buf_len);=0D
+=0D
+	if (size <=3D HINIC3_RX_HDR_SIZE && !skb_is_nonlinear(skb)) {=0D
+		memcpy(__skb_put(skb, size), va,=0D
+		       ALIGN(size, sizeof(long)));=0D
+		page_pool_put_full_page(rxq->page_pool, page, false);=0D
+=0D
+		return;=0D
+	}=0D
+=0D
+	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page,=0D
+			rx_info->page_offset, size, rxq->buf_len);=0D
+	skb_mark_for_recycle(skb);=0D
+}=0D
+=0D
+static void packaging_skb(struct hinic3_rxq *rxq, struct sk_buff *skb,=0D
+			  u32 sge_num, u32 pkt_len)=0D
+{=0D
+	struct hinic3_rx_info *rx_info;=0D
+	u32 temp_pkt_len =3D pkt_len;=0D
+	u32 temp_sge_num =3D sge_num;=0D
+	u32 sw_ci;=0D
+	u32 size;=0D
+=0D
+	sw_ci =3D rxq->cons_idx & rxq->q_mask;=0D
+	while (temp_sge_num) {=0D
+		rx_info =3D &rxq->rx_info[sw_ci];=0D
+		sw_ci =3D (sw_ci + 1) & rxq->q_mask;=0D
+		if (unlikely(temp_pkt_len > rxq->buf_len)) {=0D
+			size =3D rxq->buf_len;=0D
+			temp_pkt_len -=3D rxq->buf_len;=0D
+		} else {=0D
+			size =3D temp_pkt_len;=0D
+		}=0D
+=0D
+		hinic3_add_rx_frag(rxq, rx_info, skb, size);=0D
+=0D
+		/* clear contents of buffer_info */=0D
+		rx_info->page =3D NULL;=0D
+		temp_sge_num--;=0D
+	}=0D
+}=0D
+=0D
+static u32 hinic3_get_sge_num(struct hinic3_rxq *rxq, u32 pkt_len)=0D
+{=0D
+	u32 sge_num;=0D
+=0D
+	sge_num =3D pkt_len >> rxq->buf_len_shift;=0D
+	sge_num +=3D (pkt_len & (rxq->buf_len - 1)) ? 1 : 0;=0D
+=0D
+	return sge_num;=0D
+}=0D
+=0D
+static struct sk_buff *hinic3_fetch_rx_buffer(struct hinic3_rxq *rxq,=0D
+					      u32 pkt_len)=0D
+{=0D
+	struct sk_buff *skb;=0D
+	u32 sge_num;=0D
+=0D
+	skb =3D napi_alloc_skb(&rxq->irq_cfg->napi, HINIC3_RX_HDR_SIZE);=0D
+	if (unlikely(!skb))=0D
+		return NULL;=0D
+=0D
+	sge_num =3D hinic3_get_sge_num(rxq, pkt_len);=0D
+=0D
+	net_prefetchw(skb->data);=0D
+	packaging_skb(rxq, skb, sge_num, pkt_len);=0D
+=0D
+	rxq->cons_idx +=3D sge_num;=0D
+	rxq->delta +=3D sge_num;=0D
+=0D
+	return skb;=0D
+}=0D
+=0D
+static void hinic3_pull_tail(struct sk_buff *skb)=0D
+{=0D
+	skb_frag_t *frag =3D &skb_shinfo(skb)->frags[0];=0D
+	unsigned int pull_len;=0D
+	unsigned char *va;=0D
+=0D
+	va =3D skb_frag_address(frag);=0D
+=0D
+	/* we need the header to contain the greater of either ETH_HLEN or=0D
+	 * 60 bytes if the skb->len is less than 60 for skb_pad.=0D
+	 */=0D
+	pull_len =3D eth_get_headlen(skb->dev, va, HINIC3_RX_HDR_SIZE);=0D
+=0D
+	/* align pull length to size of long to optimize memcpy performance */=0D
+	skb_copy_to_linear_data(skb, va, ALIGN(pull_len, sizeof(long)));=0D
+=0D
+	/* update all of the pointers */=0D
+	skb_frag_size_sub(frag, pull_len);=0D
+	skb_frag_off_add(frag, pull_len);=0D
+=0D
+	skb->data_len -=3D pull_len;=0D
+	skb->tail +=3D pull_len;=0D
+}=0D
+=0D
+static void hinic3_rx_csum(struct hinic3_rxq *rxq, u32 offload_type,=0D
+			   u32 status, struct sk_buff *skb)=0D
+{=0D
+	u32 pkt_fmt =3D RQ_CQE_OFFOLAD_TYPE_GET(offload_type, TUNNEL_PKT_FORMAT);=
=0D
+	u32 pkt_type =3D RQ_CQE_OFFOLAD_TYPE_GET(offload_type, PKT_TYPE);=0D
+	u32 ip_type =3D RQ_CQE_OFFOLAD_TYPE_GET(offload_type, IP_TYPE);=0D
+	u32 csum_err =3D RQ_CQE_STATUS_GET(status, CSUM_ERR);=0D
+	struct net_device *netdev =3D rxq->netdev;=0D
+=0D
+	if (!(netdev->features & NETIF_F_RXCSUM))=0D
+		return;=0D
+=0D
+	if (unlikely(csum_err)) {=0D
+		/* pkt type is recognized by HW, and csum is wrong */=0D
+		skb->ip_summed =3D CHECKSUM_NONE;=0D
+		return;=0D
+	}=0D
+=0D
+	if (ip_type =3D=3D HINIC3_RX_INVALID_IP_TYPE ||=0D
+	    !(pkt_fmt =3D=3D HINIC3_RX_PKT_FORMAT_NON_TUNNEL ||=0D
+	      pkt_fmt =3D=3D HINIC3_RX_PKT_FORMAT_VXLAN)) {=0D
+		skb->ip_summed =3D CHECKSUM_NONE;=0D
+		return;=0D
+	}=0D
+=0D
+	switch (pkt_type) {=0D
+	case HINIC3_RX_TCP_PKT:=0D
+	case HINIC3_RX_UDP_PKT:=0D
+	case HINIC3_RX_SCTP_PKT:=0D
+		skb->ip_summed =3D CHECKSUM_UNNECESSARY;=0D
+		break;=0D
+	default:=0D
+		skb->ip_summed =3D CHECKSUM_NONE;=0D
+		break;=0D
+	}=0D
+}=0D
+=0D
+static void hinic3_lro_set_gso_params(struct sk_buff *skb, u16 num_lro)=0D
+{=0D
+	struct ethhdr *eth =3D (struct ethhdr *)(skb->data);=0D
+	__be16 proto;=0D
+=0D
+	proto =3D __vlan_get_protocol(skb, eth->h_proto, NULL);=0D
+=0D
+	skb_shinfo(skb)->gso_size =3D DIV_ROUND_UP(skb->len - skb_headlen(skb),=0D
+						 num_lro);=0D
+	skb_shinfo(skb)->gso_type =3D proto =3D=3D htons(ETH_P_IP) ?=0D
+				    SKB_GSO_TCPV4 : SKB_GSO_TCPV6;=0D
+	skb_shinfo(skb)->gso_segs =3D num_lro;=0D
+}=0D
+=0D
+static int recv_one_pkt(struct hinic3_rxq *rxq, struct hinic3_rq_cqe *rx_c=
qe,=0D
+			u32 pkt_len, u32 vlan_len, u32 status)=0D
+{=0D
+	struct net_device *netdev =3D rxq->netdev;=0D
+	struct sk_buff *skb;=0D
+	u32 offload_type;=0D
+	u16 num_lro;=0D
+=0D
+	skb =3D hinic3_fetch_rx_buffer(rxq, pkt_len);=0D
+	if (unlikely(!skb))=0D
+		return -ENOMEM;=0D
+=0D
+	/* place header in linear portion of buffer */=0D
+	if (skb_is_nonlinear(skb))=0D
+		hinic3_pull_tail(skb);=0D
+=0D
+	offload_type =3D rx_cqe->offload_type;=0D
+	hinic3_rx_csum(rxq, offload_type, status, skb);=0D
+=0D
+	num_lro =3D RQ_CQE_STATUS_GET(status, NUM_LRO);=0D
+	if (num_lro)=0D
+		hinic3_lro_set_gso_params(skb, num_lro);=0D
+=0D
+	skb_record_rx_queue(skb, rxq->q_id);=0D
+	skb->protocol =3D eth_type_trans(skb, netdev);=0D
+=0D
+	if (skb_has_frag_list(skb)) {=0D
+		napi_gro_flush(&rxq->irq_cfg->napi, false);=0D
+		netif_receive_skb(skb);=0D
+	} else {=0D
+		napi_gro_receive(&rxq->irq_cfg->napi, skb);=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D netdev_priv(rxq->netdev);=0D
+	u32 sw_ci, status, pkt_len, vlan_len;=0D
+	struct hinic3_rq_cqe *rx_cqe;=0D
+	u32 num_wqe =3D 0;=0D
+	int nr_pkts =3D 0;=0D
+	u16 num_lro;=0D
+=0D
+	while (likely(nr_pkts < budget)) {=0D
+		sw_ci =3D rxq->cons_idx & rxq->q_mask;=0D
+		rx_cqe =3D rxq->cqe_arr + sw_ci;=0D
+		status =3D rx_cqe->status;=0D
+		if (!RQ_CQE_STATUS_GET(status, RXDONE))=0D
+			break;=0D
+=0D
+		/* make sure we read rx_done before packet length */=0D
+		rmb();=0D
+=0D
+		vlan_len =3D rx_cqe->vlan_len;=0D
+		pkt_len =3D RQ_CQE_SGE_GET(vlan_len, LEN);=0D
+		if (recv_one_pkt(rxq, rx_cqe, pkt_len, vlan_len, status))=0D
+			break;=0D
+=0D
+		nr_pkts++;=0D
+		num_lro =3D RQ_CQE_STATUS_GET(status, NUM_LRO);=0D
+		if (num_lro)=0D
+			num_wqe +=3D hinic3_get_sge_num(rxq, pkt_len);=0D
+=0D
+		rx_cqe->status =3D 0;=0D
+=0D
+		if (num_wqe >=3D nic_dev->lro_replenish_thld)=0D
+			break;=0D
+	}=0D
+=0D
+	if (rxq->delta >=3D HINIC3_RX_BUFFER_WRITE)=0D
+		hinic3_rx_fill_buffers(rxq);=0D
+=0D
+	return nr_pkts;=0D
+}=0D
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h b/drivers/net/e=
thernet/huawei/hinic3/hinic3_rx.h=0D
new file mode 100644=0D
index 000000000000..1cca21858d40=0D
--- /dev/null=0D
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h=0D
@@ -0,0 +1,90 @@=0D
+/* SPDX-License-Identifier: GPL-2.0 */=0D
+/* Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved. =
*/=0D
+=0D
+#ifndef _HINIC3_RX_H_=0D
+#define _HINIC3_RX_H_=0D
+=0D
+#include <linux/bitfield.h>=0D
+#include <linux/netdevice.h>=0D
+=0D
+#define RQ_CQE_OFFOLAD_TYPE_PKT_TYPE_MASK           GENMASK(4, 0)=0D
+#define RQ_CQE_OFFOLAD_TYPE_IP_TYPE_MASK            GENMASK(6, 5)=0D
+#define RQ_CQE_OFFOLAD_TYPE_TUNNEL_PKT_FORMAT_MASK  GENMASK(11, 8)=0D
+#define RQ_CQE_OFFOLAD_TYPE_VLAN_EN_MASK            BIT(21)=0D
+#define RQ_CQE_OFFOLAD_TYPE_GET(val, member) \=0D
+	FIELD_GET(RQ_CQE_OFFOLAD_TYPE_##member##_MASK, val)=0D
+=0D
+#define RQ_CQE_SGE_VLAN_MASK  GENMASK(15, 0)=0D
+#define RQ_CQE_SGE_LEN_MASK   GENMASK(31, 16)=0D
+#define RQ_CQE_SGE_GET(val, member) \=0D
+	FIELD_GET(RQ_CQE_SGE_##member##_MASK, val)=0D
+=0D
+#define RQ_CQE_STATUS_CSUM_ERR_MASK  GENMASK(15, 0)=0D
+#define RQ_CQE_STATUS_NUM_LRO_MASK   GENMASK(23, 16)=0D
+#define RQ_CQE_STATUS_RXDONE_MASK    BIT(31)=0D
+#define RQ_CQE_STATUS_GET(val, member) \=0D
+	FIELD_GET(RQ_CQE_STATUS_##member##_MASK, val)=0D
+=0D
+/* RX Completion information that is provided by HW for a specific RX WQE =
*/=0D
+struct hinic3_rq_cqe {=0D
+	u32 status;=0D
+	u32 vlan_len;=0D
+	u32 offload_type;=0D
+	u32 rsvd3;=0D
+	u32 rsvd4;=0D
+	u32 rsvd5;=0D
+	u32 rsvd6;=0D
+	u32 pkt_info;=0D
+};=0D
+=0D
+struct hinic3_rq_wqe {=0D
+	u32 buf_hi_addr;=0D
+	u32 buf_lo_addr;=0D
+	u32 cqe_hi_addr;=0D
+	u32 cqe_lo_addr;=0D
+};=0D
+=0D
+struct hinic3_rx_info {=0D
+	struct page      *page;=0D
+	u32              page_offset;=0D
+};=0D
+=0D
+struct hinic3_rxq {=0D
+	struct net_device       *netdev;=0D
+=0D
+	u16                     q_id;=0D
+	u32                     q_depth;=0D
+	u32                     q_mask;=0D
+=0D
+	u16                     buf_len;=0D
+	u32                     buf_len_shift;=0D
+=0D
+	u32                     cons_idx;=0D
+	u32                     delta;=0D
+=0D
+	u32                     irq_id;=0D
+	u16                     msix_entry_idx;=0D
+=0D
+	/* cqe_arr and rx_info are arrays of rq_depth elements. Each element is=0D
+	 * statically associated (by index) to a specific rq_wqe.=0D
+	 */=0D
+	struct hinic3_rq_cqe   *cqe_arr;=0D
+	struct hinic3_rx_info  *rx_info;=0D
+	struct page_pool       *page_pool;=0D
+=0D
+	struct hinic3_io_queue *rq;=0D
+=0D
+	struct hinic3_irq_cfg  *irq_cfg;=0D
+	u16                    next_to_alloc;=0D
+	u16                    next_to_update;=0D
+	struct device          *dev; /* device for DMA mapping */=0D
+=0D
+	dma_addr_t             cqe_start_paddr;=0D
+} ____cacheline_aligned;=0D
+=0D
+int hinic3_alloc_rxqs(struct net_device *netdev);=0D
+void hinic3_free_rxqs(struct net_device *netdev);=0D
+=0D
+int hinic3_rx_poll(struct hinic3_rxq *rxq, int budget);=0D
+=0D
+#endif=0D
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c b/drivers/net/e=
thernet/huawei/hinic3/hinic3_tx.c=0D
new file mode 100644=0D
index 000000000000..e8ac67f09f78=0D
--- /dev/null=0D
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.c=0D
@@ -0,0 +1,678 @@=0D
+// SPDX-License-Identifier: GPL-2.0=0D
+// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.=
=0D
+=0D
+#include <linux/if_vlan.h>=0D
+#include <linux/iopoll.h>=0D
+#include <net/ip6_checksum.h>=0D
+#include <net/ipv6.h>=0D
+=0D
+#include "hinic3_hwdev.h"=0D
+#include "hinic3_nic_cfg.h"=0D
+#include "hinic3_nic_dev.h"=0D
+#include "hinic3_nic_io.h"=0D
+#include "hinic3_tx.h"=0D
+#include "hinic3_wq.h"=0D
+=0D
+#define MIN_SKB_LEN                32=0D
+=0D
+int hinic3_alloc_txqs(struct net_device *netdev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D netdev_priv(netdev);=0D
+	struct hinic3_hwdev *hwdev =3D nic_dev->hwdev;=0D
+	u16 q_id, num_txqs =3D nic_dev->max_qps;=0D
+	struct pci_dev *pdev =3D nic_dev->pdev;=0D
+	struct hinic3_txq *txq;=0D
+=0D
+	if (!num_txqs) {=0D
+		dev_err(hwdev->dev, "Cannot allocate zero size txqs\n");=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	nic_dev->txqs =3D kcalloc(num_txqs, sizeof(*nic_dev->txqs),  GFP_KERNEL);=
=0D
+	if (!nic_dev->txqs)=0D
+		return -ENOMEM;=0D
+=0D
+	for (q_id =3D 0; q_id < num_txqs; q_id++) {=0D
+		txq =3D &nic_dev->txqs[q_id];=0D
+		txq->netdev =3D netdev;=0D
+		txq->q_id =3D q_id;=0D
+		txq->q_depth =3D nic_dev->q_params.sq_depth;=0D
+		txq->q_mask =3D nic_dev->q_params.sq_depth - 1;=0D
+		txq->dev =3D &pdev->dev;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+void hinic3_free_txqs(struct net_device *netdev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D netdev_priv(netdev);=0D
+=0D
+	kfree(nic_dev->txqs);=0D
+}=0D
+=0D
+static void hinic3_set_buf_desc(struct hinic3_sq_bufdesc *buf_descs,=0D
+				dma_addr_t addr, u32 len)=0D
+{=0D
+	buf_descs->hi_addr =3D upper_32_bits(addr);=0D
+	buf_descs->lo_addr =3D lower_32_bits(addr);=0D
+	buf_descs->len  =3D len;=0D
+}=0D
+=0D
+static int hinic3_tx_map_skb(struct net_device *netdev, struct sk_buff *sk=
b,=0D
+			     struct hinic3_txq *txq,=0D
+			     struct hinic3_tx_info *tx_info,=0D
+			     struct hinic3_sq_wqe_combo *wqe_combo)=0D
+{=0D
+	struct hinic3_sq_wqe_desc *wqe_desc =3D wqe_combo->ctrl_bd0;=0D
+	struct hinic3_sq_bufdesc *buf_desc =3D wqe_combo->bds_head;=0D
+	struct hinic3_nic_dev *nic_dev =3D netdev_priv(netdev);=0D
+	struct hinic3_dma_info *dma_info =3D tx_info->dma_info;=0D
+	struct pci_dev *pdev =3D nic_dev->pdev;=0D
+	skb_frag_t *frag;=0D
+	u32 i, idx;=0D
+	int err;=0D
+=0D
+	dma_info[0].dma =3D dma_map_single(&pdev->dev, skb->data,=0D
+					 skb_headlen(skb), DMA_TO_DEVICE);=0D
+	if (dma_mapping_error(&pdev->dev, dma_info[0].dma))=0D
+		return -EFAULT;=0D
+=0D
+	dma_info[0].len =3D skb_headlen(skb);=0D
+=0D
+	wqe_desc->hi_addr =3D upper_32_bits(dma_info[0].dma);=0D
+	wqe_desc->lo_addr =3D lower_32_bits(dma_info[0].dma);=0D
+=0D
+	wqe_desc->ctrl_len =3D dma_info[0].len;=0D
+=0D
+	for (i =3D 0; i < skb_shinfo(skb)->nr_frags; i++) {=0D
+		frag =3D &(skb_shinfo(skb)->frags[i]);=0D
+		if (unlikely(i =3D=3D wqe_combo->first_bds_num))=0D
+			buf_desc =3D wqe_combo->bds_sec2;=0D
+=0D
+		idx =3D i + 1;=0D
+		dma_info[idx].dma =3D skb_frag_dma_map(&pdev->dev, frag, 0,=0D
+						     skb_frag_size(frag),=0D
+						     DMA_TO_DEVICE);=0D
+		if (dma_mapping_error(&pdev->dev, dma_info[idx].dma)) {=0D
+			err =3D -EFAULT;=0D
+			goto err_unmap_page;=0D
+		}=0D
+		dma_info[idx].len =3D skb_frag_size(frag);=0D
+=0D
+		hinic3_set_buf_desc(buf_desc, dma_info[idx].dma,=0D
+				    dma_info[idx].len);=0D
+		buf_desc++;=0D
+	}=0D
+=0D
+	return 0;=0D
+=0D
+err_unmap_page:=0D
+	while (idx > 1) {=0D
+		idx--;=0D
+		dma_unmap_page(&pdev->dev, dma_info[idx].dma,=0D
+			       dma_info[idx].len, DMA_TO_DEVICE);=0D
+	}=0D
+	dma_unmap_single(&pdev->dev, dma_info[0].dma, dma_info[0].len,=0D
+			 DMA_TO_DEVICE);=0D
+	return err;=0D
+}=0D
+=0D
+static void hinic3_tx_unmap_skb(struct net_device *netdev,=0D
+				struct sk_buff *skb,=0D
+				struct hinic3_dma_info *dma_info)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D netdev_priv(netdev);=0D
+	struct pci_dev *pdev =3D nic_dev->pdev;=0D
+	int i;=0D
+=0D
+	for (i =3D 0; i < skb_shinfo(skb)->nr_frags;) {=0D
+		i++;=0D
+		dma_unmap_page(&pdev->dev,=0D
+			       dma_info[i].dma,=0D
+			       dma_info[i].len, DMA_TO_DEVICE);=0D
+	}=0D
+=0D
+	dma_unmap_single(&pdev->dev, dma_info[0].dma,=0D
+			 dma_info[0].len, DMA_TO_DEVICE);=0D
+}=0D
+=0D
+union hinic3_ip {=0D
+	struct iphdr   *v4;=0D
+	struct ipv6hdr *v6;=0D
+	unsigned char  *hdr;=0D
+};=0D
+=0D
+union hinic3_l4 {=0D
+	struct tcphdr *tcp;=0D
+	struct udphdr *udp;=0D
+	unsigned char *hdr;=0D
+};=0D
+=0D
+enum hinic3_l3_type {=0D
+	HINIC3_L3_UNKNOWN         =3D 0,=0D
+	HINIC3_L3_IP6_PKT         =3D 1,=0D
+	HINIC3_L3_IP4_PKT_NO_CSUM =3D 2,=0D
+	HINIC3_L3_IP4_PKT_CSUM    =3D 3,=0D
+};=0D
+=0D
+enum hinic3_l4_offload_type {=0D
+	HINIC3_L4_OFFLOAD_DISABLE =3D 0,=0D
+	HINIC3_L4_OFFLOAD_TCP     =3D 1,=0D
+	HINIC3_L4_OFFLOAD_STCP    =3D 2,=0D
+	HINIC3_L4_OFFLOAD_UDP     =3D 3,=0D
+};=0D
+=0D
+/* initialize l4 offset and offload */=0D
+static void get_inner_l4_info(struct sk_buff *skb, union hinic3_l4 *l4,=0D
+			      u8 l4_proto, u32 *offset,=0D
+			      enum hinic3_l4_offload_type *l4_offload)=0D
+{=0D
+	switch (l4_proto) {=0D
+	case IPPROTO_TCP:=0D
+		*l4_offload =3D HINIC3_L4_OFFLOAD_TCP;=0D
+		/* To be same with TSO, payload offset begins from payload */=0D
+		*offset =3D (l4->tcp->doff << TCP_HDR_DATA_OFF_UNIT_SHIFT) +=0D
+			   TRANSPORT_OFFSET(l4->hdr, skb);=0D
+		break;=0D
+=0D
+	case IPPROTO_UDP:=0D
+		*l4_offload =3D HINIC3_L4_OFFLOAD_UDP;=0D
+		*offset =3D TRANSPORT_OFFSET(l4->hdr, skb);=0D
+		break;=0D
+	default:=0D
+		*l4_offload =3D HINIC3_L4_OFFLOAD_DISABLE;=0D
+		*offset =3D 0;=0D
+	}=0D
+}=0D
+=0D
+static int hinic3_tx_csum(struct hinic3_txq *txq, struct hinic3_sq_task *t=
ask,=0D
+			  struct sk_buff *skb)=0D
+{=0D
+	if (skb->ip_summed !=3D CHECKSUM_PARTIAL)=0D
+		return 0;=0D
+=0D
+	if (skb->encapsulation) {=0D
+		union hinic3_ip ip;=0D
+		u8 l4_proto;=0D
+=0D
+		task->pkt_info0 |=3D SQ_TASK_INFO0_SET(1, TUNNEL_FLAG);=0D
+=0D
+		ip.hdr =3D skb_network_header(skb);=0D
+		if (ip.v4->version =3D=3D 4) {=0D
+			l4_proto =3D ip.v4->protocol;=0D
+		} else if (ip.v4->version =3D=3D 6) {=0D
+			union hinic3_l4 l4;=0D
+			unsigned char *exthdr;=0D
+			__be16 frag_off;=0D
+=0D
+			exthdr =3D ip.hdr + sizeof(*ip.v6);=0D
+			l4_proto =3D ip.v6->nexthdr;=0D
+			l4.hdr =3D skb_transport_header(skb);=0D
+			if (l4.hdr !=3D exthdr)=0D
+				ipv6_skip_exthdr(skb, exthdr - skb->data,=0D
+						 &l4_proto, &frag_off);=0D
+		} else {=0D
+			l4_proto =3D IPPROTO_RAW;=0D
+		}=0D
+=0D
+		if (l4_proto !=3D IPPROTO_UDP ||=0D
+		    ((struct udphdr *)skb_transport_header(skb))->dest !=3D=0D
+		    VXLAN_OFFLOAD_PORT_LE) {=0D
+			/* Unsupported tunnel packet, disable csum offload */=0D
+			skb_checksum_help(skb);=0D
+			return 0;=0D
+		}=0D
+	}=0D
+=0D
+	task->pkt_info0 |=3D SQ_TASK_INFO0_SET(1, INNER_L4_EN);=0D
+=0D
+	return 1;=0D
+}=0D
+=0D
+static void get_inner_l3_l4_type(struct sk_buff *skb, union hinic3_ip *ip,=
=0D
+				 union hinic3_l4 *l4,=0D
+				 enum hinic3_l3_type *l3_type, u8 *l4_proto)=0D
+{=0D
+	unsigned char *exthdr;=0D
+	__be16 frag_off;=0D
+=0D
+	if (ip->v4->version =3D=3D 4) {=0D
+		*l3_type =3D HINIC3_L3_IP4_PKT_CSUM;=0D
+		*l4_proto =3D ip->v4->protocol;=0D
+	} else if (ip->v4->version =3D=3D 6) {=0D
+		*l3_type =3D HINIC3_L3_IP6_PKT;=0D
+		exthdr =3D ip->hdr + sizeof(*ip->v6);=0D
+		*l4_proto =3D ip->v6->nexthdr;=0D
+		if (exthdr !=3D l4->hdr) {=0D
+			ipv6_skip_exthdr(skb, exthdr - skb->data,=0D
+					 l4_proto, &frag_off);=0D
+		}=0D
+	} else {=0D
+		*l3_type =3D HINIC3_L3_UNKNOWN;=0D
+		*l4_proto =3D 0;=0D
+	}=0D
+}=0D
+=0D
+static void hinic3_set_tso_info(struct hinic3_sq_task *task, u32 *queue_in=
fo,=0D
+				enum hinic3_l4_offload_type l4_offload,=0D
+				u32 offset, u32 mss)=0D
+{=0D
+	if (l4_offload =3D=3D HINIC3_L4_OFFLOAD_TCP) {=0D
+		*queue_info |=3D SQ_CTRL_QUEUE_INFO_SET(1, TSO);=0D
+		task->pkt_info0 |=3D SQ_TASK_INFO0_SET(1, INNER_L4_EN);=0D
+	} else if (l4_offload =3D=3D HINIC3_L4_OFFLOAD_UDP) {=0D
+		*queue_info |=3D SQ_CTRL_QUEUE_INFO_SET(1, UFO);=0D
+		task->pkt_info0 |=3D SQ_TASK_INFO0_SET(1, INNER_L4_EN);=0D
+	}=0D
+=0D
+	/* enable L3 calculation */=0D
+	task->pkt_info0 |=3D SQ_TASK_INFO0_SET(1, INNER_L3_EN);=0D
+=0D
+	*queue_info |=3D SQ_CTRL_QUEUE_INFO_SET(offset >> 1, PLDOFF);=0D
+=0D
+	/* set MSS value */=0D
+	*queue_info &=3D ~SQ_CTRL_QUEUE_INFO_MSS_MASK;=0D
+	*queue_info |=3D SQ_CTRL_QUEUE_INFO_SET(mss, MSS);=0D
+}=0D
+=0D
+static __sum16 csum_magic(union hinic3_ip *ip, unsigned short proto)=0D
+{=0D
+	return (ip->v4->version =3D=3D 4) ?=0D
+		csum_tcpudp_magic(ip->v4->saddr, ip->v4->daddr, 0, proto, 0) :=0D
+		csum_ipv6_magic(&ip->v6->saddr, &ip->v6->daddr, 0, proto, 0);=0D
+}=0D
+=0D
+static int hinic3_tso(struct hinic3_sq_task *task, u32 *queue_info,=0D
+		      struct sk_buff *skb)=0D
+{=0D
+	enum hinic3_l4_offload_type l4_offload;=0D
+	enum hinic3_l3_type l3_type;=0D
+	union hinic3_ip ip;=0D
+	union hinic3_l4 l4;=0D
+	u8 l4_proto;=0D
+	u32 offset;=0D
+	int err;=0D
+=0D
+	if (!skb_is_gso(skb))=0D
+		return 0;=0D
+=0D
+	err =3D skb_cow_head(skb, 0);=0D
+	if (err < 0)=0D
+		return err;=0D
+=0D
+	if (skb->encapsulation) {=0D
+		u32 gso_type =3D skb_shinfo(skb)->gso_type;=0D
+		/* L3 checksum is always enabled */=0D
+		task->pkt_info0 |=3D SQ_TASK_INFO0_SET(1, OUT_L3_EN);=0D
+		task->pkt_info0 |=3D SQ_TASK_INFO0_SET(1, TUNNEL_FLAG);=0D
+=0D
+		l4.hdr =3D skb_transport_header(skb);=0D
+		ip.hdr =3D skb_network_header(skb);=0D
+=0D
+		if (gso_type & SKB_GSO_UDP_TUNNEL_CSUM) {=0D
+			l4.udp->check =3D ~csum_magic(&ip, IPPROTO_UDP);=0D
+			task->pkt_info0 |=3D SQ_TASK_INFO0_SET(1, OUT_L4_EN);=0D
+		}=0D
+=0D
+		ip.hdr =3D skb_inner_network_header(skb);=0D
+		l4.hdr =3D skb_inner_transport_header(skb);=0D
+	} else {=0D
+		ip.hdr =3D skb_network_header(skb);=0D
+		l4.hdr =3D skb_transport_header(skb);=0D
+	}=0D
+=0D
+	get_inner_l3_l4_type(skb, &ip, &l4, &l3_type, &l4_proto);=0D
+=0D
+	if (l4_proto =3D=3D IPPROTO_TCP)=0D
+		l4.tcp->check =3D ~csum_magic(&ip, IPPROTO_TCP);=0D
+=0D
+	get_inner_l4_info(skb, &l4, l4_proto, &offset, &l4_offload);=0D
+=0D
+	hinic3_set_tso_info(task, queue_info, l4_offload, offset,=0D
+			    skb_shinfo(skb)->gso_size);=0D
+=0D
+	return 1;=0D
+}=0D
+=0D
+static void hinic3_set_vlan_tx_offload(struct hinic3_sq_task *task,=0D
+				       u16 vlan_tag, u8 vlan_tpid)=0D
+{=0D
+	/* vlan_tpid: 0=3Dselect TPID0 in IPSU, 1=3Dselect TPID1 in IPSU=0D
+	 * 2=3Dselect TPID2 in IPSU, 3=3Dselect TPID3 in IPSU,=0D
+	 * 4=3Dselect TPID4 in IPSU=0D
+	 */=0D
+	task->vlan_offload =3D SQ_TASK_INFO3_SET(vlan_tag, VLAN_TAG) |=0D
+			     SQ_TASK_INFO3_SET(vlan_tpid, VLAN_TPID) |=0D
+			     SQ_TASK_INFO3_SET(1, VLAN_TAG_VALID);=0D
+}=0D
+=0D
+static u32 hinic3_tx_offload(struct sk_buff *skb, struct hinic3_sq_task *t=
ask,=0D
+			     u32 *queue_info, struct hinic3_txq *txq)=0D
+{=0D
+	u32 offload =3D 0;=0D
+	int tso_cs_en;=0D
+=0D
+	task->pkt_info0 =3D 0;=0D
+	task->ip_identify =3D 0;=0D
+	task->rsvd =3D 0;=0D
+	task->vlan_offload =3D 0;=0D
+=0D
+	tso_cs_en =3D hinic3_tso(task, queue_info, skb);=0D
+	if (tso_cs_en < 0) {=0D
+		offload =3D HINIC3_TX_OFFLOAD_INVALID;=0D
+		return offload;=0D
+	} else if (tso_cs_en) {=0D
+		offload |=3D HINIC3_TX_OFFLOAD_TSO;=0D
+	} else {=0D
+		tso_cs_en =3D hinic3_tx_csum(txq, task, skb);=0D
+		if (tso_cs_en)=0D
+			offload |=3D HINIC3_TX_OFFLOAD_CSUM;=0D
+	}=0D
+=0D
+#define VLAN_INSERT_MODE_MAX 5=0D
+	if (unlikely(skb_vlan_tag_present(skb))) {=0D
+		/* select vlan insert mode by qid, default 802.1Q Tag type */=0D
+		hinic3_set_vlan_tx_offload(task, skb_vlan_tag_get(skb),=0D
+					   txq->q_id % VLAN_INSERT_MODE_MAX);=0D
+		offload |=3D HINIC3_TX_OFFLOAD_VLAN;=0D
+	}=0D
+=0D
+	if (unlikely(SQ_CTRL_QUEUE_INFO_GET(*queue_info, PLDOFF) >=0D
+		     SQ_CTRL_MAX_PLDOFF)) {=0D
+		offload =3D HINIC3_TX_OFFLOAD_INVALID;=0D
+		return offload;=0D
+	}=0D
+=0D
+	return offload;=0D
+}=0D
+=0D
+static int hinic3_maybe_stop_tx(struct hinic3_txq *txq, u16 wqebb_cnt)=0D
+{=0D
+	if (likely(hinic3_wq_free_wqebbs(&txq->sq->wq) >=3D wqebb_cnt))=0D
+		return 0;=0D
+=0D
+	/* We need to check again in a case another CPU has just=0D
+	 * made room available.=0D
+	 */=0D
+	netif_stop_subqueue(txq->netdev, txq->q_id);=0D
+=0D
+	if (likely(hinic3_wq_free_wqebbs(&txq->sq->wq) < wqebb_cnt))=0D
+		return -EBUSY;=0D
+=0D
+	netif_start_subqueue(txq->netdev, txq->q_id);=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static u16 hinic3_get_and_update_sq_owner(struct hinic3_io_queue *sq,=0D
+					  u16 curr_pi, u16 wqebb_cnt)=0D
+{=0D
+	u16 owner =3D sq->owner;=0D
+=0D
+	if (unlikely(curr_pi + wqebb_cnt >=3D sq->wq.q_depth))=0D
+		sq->owner =3D !sq->owner;=0D
+=0D
+	return owner;=0D
+}=0D
+=0D
+static u16 hinic3_set_wqe_combo(struct hinic3_txq *txq,=0D
+				struct hinic3_sq_wqe_combo *wqe_combo,=0D
+				u32 offload, u16 num_sge, u16 *curr_pi)=0D
+{=0D
+	struct hinic3_sq_bufdesc *first_part_wqebbs, *second_part_wqebbs;=0D
+	u16 first_part_wqebbs_num, tmp_pi;=0D
+=0D
+	wqe_combo->ctrl_bd0 =3D hinic3_wq_get_one_wqebb(&txq->sq->wq, curr_pi);=0D
+	if (!offload && num_sge =3D=3D 1) {=0D
+		wqe_combo->wqe_type =3D SQ_WQE_COMPACT_TYPE;=0D
+		return hinic3_get_and_update_sq_owner(txq->sq, *curr_pi, 1);=0D
+	}=0D
+=0D
+	wqe_combo->wqe_type =3D SQ_WQE_EXTENDED_TYPE;=0D
+=0D
+	if (offload) {=0D
+		wqe_combo->task =3D hinic3_wq_get_one_wqebb(&txq->sq->wq,=0D
+							  &tmp_pi);=0D
+		wqe_combo->task_type =3D SQ_WQE_TASKSECT_16BYTES;=0D
+	} else {=0D
+		wqe_combo->task_type =3D SQ_WQE_TASKSECT_46BITS;=0D
+	}=0D
+=0D
+	if (num_sge > 1) {=0D
+		/* first wqebb contain bd0, and bd size is equal to sq wqebb=0D
+		 * size, so we use (num_sge - 1) as wanted weqbb_cnt=0D
+		 */=0D
+		hinic3_wq_get_multi_wqebbs(&txq->sq->wq, num_sge - 1, &tmp_pi,=0D
+					   &first_part_wqebbs,=0D
+					   &second_part_wqebbs,=0D
+					   &first_part_wqebbs_num);=0D
+		wqe_combo->bds_head =3D first_part_wqebbs;=0D
+		wqe_combo->bds_sec2 =3D second_part_wqebbs;=0D
+		wqe_combo->first_bds_num =3D first_part_wqebbs_num;=0D
+	}=0D
+=0D
+	return hinic3_get_and_update_sq_owner(txq->sq, *curr_pi,=0D
+					      num_sge + !!offload);=0D
+}=0D
+=0D
+static void hinic3_prepare_sq_ctrl(struct hinic3_sq_wqe_combo *wqe_combo,=
=0D
+				   u32 queue_info, int nr_descs, u16 owner)=0D
+{=0D
+	struct hinic3_sq_wqe_desc *wqe_desc =3D wqe_combo->ctrl_bd0;=0D
+=0D
+	if (wqe_combo->wqe_type =3D=3D SQ_WQE_COMPACT_TYPE) {=0D
+		wqe_desc->ctrl_len |=3D=0D
+		    SQ_CTRL_SET(SQ_NORMAL_WQE, DATA_FORMAT) |=0D
+		    SQ_CTRL_SET(wqe_combo->wqe_type, EXTENDED) |=0D
+		    SQ_CTRL_SET(owner, OWNER);=0D
+=0D
+		/* compact wqe queue_info will transfer to chip */=0D
+		wqe_desc->queue_info =3D 0;=0D
+		return;=0D
+	}=0D
+=0D
+	wqe_desc->ctrl_len |=3D SQ_CTRL_SET(nr_descs, BUFDESC_NUM) |=0D
+			      SQ_CTRL_SET(wqe_combo->task_type, TASKSECT_LEN) |=0D
+			      SQ_CTRL_SET(SQ_NORMAL_WQE, DATA_FORMAT) |=0D
+			      SQ_CTRL_SET(wqe_combo->wqe_type, EXTENDED) |=0D
+			      SQ_CTRL_SET(owner, OWNER);=0D
+=0D
+	wqe_desc->queue_info =3D queue_info;=0D
+	wqe_desc->queue_info |=3D SQ_CTRL_QUEUE_INFO_SET(1, UC);=0D
+=0D
+	if (!SQ_CTRL_QUEUE_INFO_GET(wqe_desc->queue_info, MSS)) {=0D
+		wqe_desc->queue_info |=3D=0D
+		    SQ_CTRL_QUEUE_INFO_SET(HINIC3_TX_MSS_DEFAULT, MSS);=0D
+	} else if (SQ_CTRL_QUEUE_INFO_GET(wqe_desc->queue_info, MSS) <=0D
+		   HINIC3_TX_MSS_MIN) {=0D
+		/* mss should not be less than 80 */=0D
+		wqe_desc->queue_info &=3D ~SQ_CTRL_QUEUE_INFO_MSS_MASK;=0D
+		wqe_desc->queue_info |=3D=0D
+		    SQ_CTRL_QUEUE_INFO_SET(HINIC3_TX_MSS_MIN, MSS);=0D
+	}=0D
+}=0D
+=0D
+static netdev_tx_t hinic3_send_one_skb(struct sk_buff *skb,=0D
+				       struct net_device *netdev,=0D
+				       struct hinic3_txq *txq)=0D
+{=0D
+	struct hinic3_sq_wqe_combo wqe_combo =3D {};=0D
+	struct hinic3_tx_info *tx_info;=0D
+	u32 offload, queue_info =3D 0;=0D
+	struct hinic3_sq_task task;=0D
+	u16 wqebb_cnt, num_sge;=0D
+	u16 saved_wq_prod_idx;=0D
+	u16 owner, pi =3D 0;=0D
+	u8 saved_sq_owner;=0D
+	int err;=0D
+=0D
+	if (unlikely(skb->len < MIN_SKB_LEN)) {=0D
+		if (skb_pad(skb, MIN_SKB_LEN - skb->len))=0D
+			goto err_out;=0D
+=0D
+		skb->len =3D MIN_SKB_LEN;=0D
+	}=0D
+=0D
+	num_sge =3D skb_shinfo(skb)->nr_frags + 1;=0D
+	/* assume normal wqe format + 1 wqebb for task info */=0D
+	wqebb_cnt =3D num_sge + 1;=0D
+	if (unlikely(hinic3_maybe_stop_tx(txq, wqebb_cnt)))=0D
+		return NETDEV_TX_BUSY;=0D
+=0D
+	offload =3D hinic3_tx_offload(skb, &task, &queue_info, txq);=0D
+	if (unlikely(offload =3D=3D HINIC3_TX_OFFLOAD_INVALID)) {=0D
+		goto err_drop_pkt;=0D
+	} else if (!offload) {=0D
+		wqebb_cnt -=3D 1;=0D
+		if (unlikely(num_sge =3D=3D 1 &&=0D
+			     skb->len > HINIC3_COMPACT_WQEE_SKB_MAX_LEN))=0D
+			goto err_drop_pkt;=0D
+	}=0D
+=0D
+	saved_wq_prod_idx =3D txq->sq->wq.prod_idx;=0D
+	saved_sq_owner =3D txq->sq->owner;=0D
+=0D
+	owner =3D hinic3_set_wqe_combo(txq, &wqe_combo, offload, num_sge, &pi);=0D
+	if (offload)=0D
+		*wqe_combo.task =3D task;=0D
+=0D
+	tx_info =3D &txq->tx_info[pi];=0D
+	tx_info->skb =3D skb;=0D
+	tx_info->wqebb_cnt =3D wqebb_cnt;=0D
+=0D
+	err =3D hinic3_tx_map_skb(netdev, skb, txq, tx_info, &wqe_combo);=0D
+	if (err) {=0D
+		/* Rollback work queue to reclaim the wqebb we did not use */=0D
+		txq->sq->wq.prod_idx =3D saved_wq_prod_idx;=0D
+		txq->sq->owner =3D saved_sq_owner;=0D
+		goto err_drop_pkt;=0D
+	}=0D
+=0D
+	hinic3_prepare_sq_ctrl(&wqe_combo, queue_info, num_sge, owner);=0D
+	hinic3_write_db(txq->sq, 0, DB_CFLAG_DP_SQ,=0D
+			hinic3_get_sq_local_pi(txq->sq));=0D
+=0D
+	return NETDEV_TX_OK;=0D
+=0D
+err_drop_pkt:=0D
+	dev_kfree_skb_any(skb);=0D
+=0D
+err_out:=0D
+	return NETDEV_TX_OK;=0D
+}=0D
+=0D
+netdev_tx_t hinic3_xmit_frame(struct sk_buff *skb, struct net_device *netd=
ev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D netdev_priv(netdev);=0D
+	u16 q_id =3D skb_get_queue_mapping(skb);=0D
+=0D
+	if (unlikely(!netif_carrier_ok(netdev)))=0D
+		goto err_drop_pkt;=0D
+=0D
+	if (unlikely(q_id >=3D nic_dev->q_params.num_qps))=0D
+		goto err_drop_pkt;=0D
+=0D
+	return hinic3_send_one_skb(skb, netdev, &nic_dev->txqs[q_id]);=0D
+=0D
+err_drop_pkt:=0D
+	dev_kfree_skb_any(skb);=0D
+	return NETDEV_TX_OK;=0D
+}=0D
+=0D
+static bool is_hw_complete_sq_process(struct hinic3_io_queue *sq)=0D
+{=0D
+	u16 sw_pi, hw_ci;=0D
+=0D
+	sw_pi =3D hinic3_get_sq_local_pi(sq);=0D
+	hw_ci =3D hinic3_get_sq_hw_ci(sq);=0D
+=0D
+	return sw_pi =3D=3D hw_ci;=0D
+}=0D
+=0D
+#define HINIC3_FLUSH_QUEUE_POLL_SLEEP_US   10000=0D
+#define HINIC3_FLUSH_QUEUE_POLL_TIMEOUT_US 10000000=0D
+static int hinic3_stop_sq(struct hinic3_txq *txq)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D netdev_priv(txq->netdev);=0D
+	int err, rc;=0D
+=0D
+	err =3D read_poll_timeout(hinic3_force_drop_tx_pkt, rc,=0D
+				is_hw_complete_sq_process(txq->sq) || rc,=0D
+				HINIC3_FLUSH_QUEUE_POLL_SLEEP_US,=0D
+				HINIC3_FLUSH_QUEUE_POLL_TIMEOUT_US,=0D
+				true, nic_dev->hwdev);=0D
+	if (rc)=0D
+		return rc;=0D
+	else=0D
+		return err;=0D
+}=0D
+=0D
+/* packet transmission should be stopped before calling this function */=0D
+void hinic3_flush_txqs(struct net_device *netdev)=0D
+{=0D
+	struct hinic3_nic_dev *nic_dev =3D netdev_priv(netdev);=0D
+	u16 qid;=0D
+	int err;=0D
+=0D
+	for (qid =3D 0; qid < nic_dev->q_params.num_qps; qid++) {=0D
+		err =3D hinic3_stop_sq(&nic_dev->txqs[qid]);=0D
+		if (err)=0D
+			netdev_err(netdev, "Failed to stop sq%u\n", qid);=0D
+	}=0D
+}=0D
+=0D
+#define HINIC3_BDS_PER_SQ_WQEBB \=0D
+	(HINIC3_SQ_WQEBB_SIZE / sizeof(struct hinic3_sq_bufdesc))=0D
+=0D
+bool hinic3_tx_poll(struct hinic3_txq *txq, int budget)=0D
+{=0D
+	struct net_device *netdev =3D txq->netdev;=0D
+	u16 hw_ci, sw_ci, q_id =3D txq->sq->q_id;=0D
+	struct hinic3_nic_dev *nic_dev;=0D
+	struct hinic3_tx_info *tx_info;=0D
+	u16 wqebb_cnt =3D 0;=0D
+	int pkts =3D 0;=0D
+=0D
+	nic_dev =3D netdev_priv(netdev);=0D
+	hw_ci =3D hinic3_get_sq_hw_ci(txq->sq);=0D
+	dma_rmb();=0D
+	sw_ci =3D hinic3_get_sq_local_ci(txq->sq);=0D
+=0D
+	do {=0D
+		tx_info =3D &txq->tx_info[sw_ci];=0D
+=0D
+		/* Did all wqebb of this wqe complete? */=0D
+		if (hw_ci =3D=3D sw_ci ||=0D
+		    ((hw_ci - sw_ci) & txq->q_mask) < tx_info->wqebb_cnt)=0D
+			break;=0D
+=0D
+		sw_ci =3D (sw_ci + tx_info->wqebb_cnt) & txq->q_mask;=0D
+		net_prefetch(&txq->tx_info[sw_ci]);=0D
+=0D
+		wqebb_cnt +=3D tx_info->wqebb_cnt;=0D
+		pkts++;=0D
+=0D
+		hinic3_tx_unmap_skb(netdev, tx_info->skb, tx_info->dma_info);=0D
+		napi_consume_skb(tx_info->skb, budget);=0D
+		tx_info->skb =3D NULL;=0D
+	} while (likely(pkts < HINIC3_TX_POLL_WEIGHT));=0D
+=0D
+	hinic3_wq_put_wqebbs(&txq->sq->wq, wqebb_cnt);=0D
+=0D
+	if (unlikely(__netif_subqueue_stopped(netdev, q_id) &&=0D
+		     hinic3_wq_free_wqebbs(&txq->sq->wq) >=3D 1 &&=0D
+		     test_bit(HINIC3_INTF_UP, &nic_dev->flags))) {=0D
+		struct netdev_queue *netdev_txq =3D=0D
+				netdev_get_tx_queue(netdev, q_id);=0D
+=0D
+		__netif_tx_lock(netdev_txq, smp_processor_id());=0D
+		/* avoid re-waking subqueue with xmit_frame */=0D
+		if (__netif_subqueue_stopped(netdev, q_id))=0D
+			netif_wake_subqueue(netdev, q_id);=0D
+=0D
+		__netif_tx_unlock(netdev_txq);=0D
+	}=0D
+=0D
+	return pkts =3D=3D HINIC3_TX_POLL_WEIGHT;=0D
+}=0D
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h b/drivers/net/e=
thernet/huawei/hinic3/hinic3_tx.h=0D
new file mode 100644=0D
index 000000000000..be3370ad25f4=0D
--- /dev/null=0D
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_tx.h=0D
@@ -0,0 +1,131 @@=0D
+/* SPDX-License-Identifier: GPL-2.0 */=0D
+/* Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved. =
*/=0D
+=0D
+#ifndef _HINIC3_TX_H_=0D
+#define _HINIC3_TX_H_=0D
+=0D
+#include <linux/bitops.h>=0D
+#include <linux/ip.h>=0D
+#include <linux/ipv6.h>=0D
+#include <linux/netdevice.h>=0D
+#include <net/checksum.h>=0D
+=0D
+#define VXLAN_OFFLOAD_PORT_LE            cpu_to_be16(4789)=0D
+#define TCP_HDR_DATA_OFF_UNIT_SHIFT      2=0D
+#define TRANSPORT_OFFSET(l4_hdr, skb)    ((l4_hdr) - (skb)->data)=0D
+=0D
+#define HINIC3_COMPACT_WQEE_SKB_MAX_LEN  16383=0D
+#define HINIC3_TX_POLL_WEIGHT		 64=0D
+=0D
+enum sq_wqe_data_format {=0D
+	SQ_NORMAL_WQE =3D 0,=0D
+};=0D
+=0D
+enum sq_wqe_ec_type {=0D
+	SQ_WQE_COMPACT_TYPE  =3D 0,=0D
+	SQ_WQE_EXTENDED_TYPE =3D 1,=0D
+};=0D
+=0D
+enum sq_wqe_tasksect_len_type {=0D
+	SQ_WQE_TASKSECT_46BITS  =3D 0,=0D
+	SQ_WQE_TASKSECT_16BYTES =3D 1,=0D
+};=0D
+=0D
+enum hinic3_tx_offload_type {=0D
+	HINIC3_TX_OFFLOAD_TSO     =3D BIT(0),=0D
+	HINIC3_TX_OFFLOAD_CSUM    =3D BIT(1),=0D
+	HINIC3_TX_OFFLOAD_VLAN    =3D BIT(2),=0D
+	HINIC3_TX_OFFLOAD_INVALID =3D BIT(3),=0D
+	HINIC3_TX_OFFLOAD_ESP     =3D BIT(4),=0D
+};=0D
+=0D
+#define SQ_CTRL_BUFDESC_NUM_MASK   GENMASK(26, 19)=0D
+#define SQ_CTRL_TASKSECT_LEN_MASK  BIT(27)=0D
+#define SQ_CTRL_DATA_FORMAT_MASK   BIT(28)=0D
+#define SQ_CTRL_EXTENDED_MASK      BIT(30)=0D
+#define SQ_CTRL_OWNER_MASK         BIT(31)=0D
+#define SQ_CTRL_SET(val, member) \=0D
+	FIELD_PREP(SQ_CTRL_##member##_MASK, val)=0D
+=0D
+#define SQ_CTRL_QUEUE_INFO_PLDOFF_MASK  GENMASK(9, 2)=0D
+#define SQ_CTRL_QUEUE_INFO_UFO_MASK     BIT(10)=0D
+#define SQ_CTRL_QUEUE_INFO_TSO_MASK     BIT(11)=0D
+#define SQ_CTRL_QUEUE_INFO_MSS_MASK     GENMASK(26, 13)=0D
+#define SQ_CTRL_QUEUE_INFO_UC_MASK      BIT(28)=0D
+=0D
+#define SQ_CTRL_QUEUE_INFO_SET(val, member) \=0D
+	FIELD_PREP(SQ_CTRL_QUEUE_INFO_##member##_MASK, val)=0D
+#define SQ_CTRL_QUEUE_INFO_GET(val, member) \=0D
+	FIELD_GET(SQ_CTRL_QUEUE_INFO_##member##_MASK, val)=0D
+=0D
+#define SQ_CTRL_MAX_PLDOFF  221=0D
+=0D
+#define SQ_TASK_INFO0_TUNNEL_FLAG_MASK  BIT(19)=0D
+#define SQ_TASK_INFO0_INNER_L4_EN_MASK  BIT(24)=0D
+#define SQ_TASK_INFO0_INNER_L3_EN_MASK  BIT(25)=0D
+#define SQ_TASK_INFO0_OUT_L4_EN_MASK    BIT(27)=0D
+#define SQ_TASK_INFO0_OUT_L3_EN_MASK    BIT(28)=0D
+#define SQ_TASK_INFO0_SET(val, member) \=0D
+	FIELD_PREP(SQ_TASK_INFO0_##member##_MASK, val)=0D
+=0D
+#define SQ_TASK_INFO3_VLAN_TAG_MASK        GENMASK(15, 0)=0D
+#define SQ_TASK_INFO3_VLAN_TPID_MASK       GENMASK(18, 16)=0D
+#define SQ_TASK_INFO3_VLAN_TAG_VALID_MASK  BIT(19)=0D
+#define SQ_TASK_INFO3_SET(val, member) \=0D
+	FIELD_PREP(SQ_TASK_INFO3_##member##_MASK, val)=0D
+=0D
+struct hinic3_sq_wqe_desc {=0D
+	u32 ctrl_len;=0D
+	u32 queue_info;=0D
+	u32 hi_addr;=0D
+	u32 lo_addr;=0D
+};=0D
+=0D
+struct hinic3_sq_task {=0D
+	u32 pkt_info0;=0D
+	u32 ip_identify;=0D
+	u32 rsvd;=0D
+	u32 vlan_offload;=0D
+};=0D
+=0D
+struct hinic3_sq_wqe_combo {=0D
+	struct hinic3_sq_wqe_desc *ctrl_bd0;=0D
+	struct hinic3_sq_task     *task;=0D
+	struct hinic3_sq_bufdesc  *bds_head;=0D
+	struct hinic3_sq_bufdesc  *bds_sec2;=0D
+	u16                       first_bds_num;=0D
+	u32                       wqe_type;=0D
+	u32                       task_type;=0D
+};=0D
+=0D
+struct hinic3_dma_info {=0D
+	dma_addr_t dma;=0D
+	u32        len;=0D
+};=0D
+=0D
+struct hinic3_tx_info {=0D
+	struct sk_buff         *skb;=0D
+	u16                    wqebb_cnt;=0D
+	struct hinic3_dma_info *dma_info;=0D
+};=0D
+=0D
+struct hinic3_txq {=0D
+	struct net_device       *netdev;=0D
+	struct device           *dev;=0D
+=0D
+	u16                     q_id;=0D
+	u32                     q_mask;=0D
+	u32                     q_depth;=0D
+=0D
+	struct hinic3_tx_info   *tx_info;=0D
+	struct hinic3_io_queue  *sq;=0D
+} ____cacheline_aligned;=0D
+=0D
+int hinic3_alloc_txqs(struct net_device *netdev);=0D
+void hinic3_free_txqs(struct net_device *netdev);=0D
+=0D
+netdev_tx_t hinic3_xmit_frame(struct sk_buff *skb, struct net_device *netd=
ev);=0D
+bool hinic3_tx_poll(struct hinic3_txq *txq, int budget);=0D
+void hinic3_flush_txqs(struct net_device *netdev);=0D
+=0D
+#endif=0D
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_wq.c b/drivers/net/e=
thernet/huawei/hinic3/hinic3_wq.c=0D
new file mode 100644=0D
index 000000000000..2ac7efcd1365=0D
--- /dev/null=0D
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_wq.c=0D
@@ -0,0 +1,29 @@=0D
+// SPDX-License-Identifier: GPL-2.0=0D
+// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.=
=0D
+=0D
+#include <linux/dma-mapping.h>=0D
+=0D
+#include "hinic3_hwdev.h"=0D
+#include "hinic3_wq.h"=0D
+=0D
+void hinic3_wq_get_multi_wqebbs(struct hinic3_wq *wq,=0D
+				u16 num_wqebbs, u16 *prod_idx,=0D
+				struct hinic3_sq_bufdesc **first_part_wqebbs,=0D
+				struct hinic3_sq_bufdesc **second_part_wqebbs,=0D
+				u16 *first_part_wqebbs_num)=0D
+{=0D
+	u32 idx, remaining;=0D
+=0D
+	idx =3D wq->prod_idx & wq->idx_mask;=0D
+	wq->prod_idx +=3D num_wqebbs;=0D
+	*prod_idx =3D idx;=0D
+	*first_part_wqebbs =3D get_q_element(&wq->qpages, idx, &remaining);=0D
+	if (likely(remaining >=3D num_wqebbs)) {=0D
+		*first_part_wqebbs_num =3D num_wqebbs;=0D
+		*second_part_wqebbs =3D NULL;=0D
+	} else {=0D
+		*first_part_wqebbs_num =3D remaining;=0D
+		idx +=3D remaining;=0D
+		*second_part_wqebbs =3D get_q_element(&wq->qpages, idx, NULL);=0D
+	}=0D
+}=0D
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_wq.h b/drivers/net/e=
thernet/huawei/hinic3/hinic3_wq.h=0D
new file mode 100644=0D
index 000000000000..b64268a8bbb4=0D
--- /dev/null=0D
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_wq.h=0D
@@ -0,0 +1,76 @@=0D
+/* SPDX-License-Identifier: GPL-2.0 */=0D
+/* Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved. =
*/=0D
+=0D
+#ifndef _HINIC3_WQ_H_=0D
+#define _HINIC3_WQ_H_=0D
+=0D
+#include <linux/io.h>=0D
+=0D
+#include "hinic3_queue_common.h"=0D
+=0D
+struct hinic3_sq_bufdesc {=0D
+	/* 31-bits Length, L2NIC only uses length[17:0] */=0D
+	u32 len;=0D
+	u32 rsvd;=0D
+	u32 hi_addr;=0D
+	u32 lo_addr;=0D
+};=0D
+=0D
+/* Work queue is used to submit elements (tx, rx, cmd) to hw.=0D
+ * Driver is the producer that advances prod_idx. cons_idx is advanced whe=
n=0D
+ * HW reports completions of previously submitted elements.=0D
+ */=0D
+struct hinic3_wq {=0D
+	struct hinic3_queue_pages qpages;=0D
+	/* Unmasked producer/consumer indices that are advanced to natural=0D
+	 * integer overflow regardless of queue depth.=0D
+	 */=0D
+	u16                       cons_idx;=0D
+	u16                       prod_idx;=0D
+=0D
+	u32                       q_depth;=0D
+	u16                       idx_mask;=0D
+=0D
+	/* Work Queue (logical WQEBB array) is mapped to hw via Chip Logical=0D
+	 * Address (CLA) using 1 of 2 levels:=0D
+	 *     level 0 - direct mapping of single wq page=0D
+	 *     level 1 - indirect mapping of multiple pages via additional page=0D
+	 *               table.=0D
+	 * When wq uses level 1, wq_block will hold the allocated indirection=0D
+	 * table.=0D
+	 */=0D
+	dma_addr_t                wq_block_paddr;=0D
+	__be64                    *wq_block_vaddr;=0D
+} ____cacheline_aligned;=0D
+=0D
+/* Get number of elements in work queue that are in-use. */=0D
+static inline u16 hinic3_wq_get_used(const struct hinic3_wq *wq)=0D
+{=0D
+	return wq->prod_idx - wq->cons_idx;=0D
+}=0D
+=0D
+static inline u16 hinic3_wq_free_wqebbs(struct hinic3_wq *wq)=0D
+{=0D
+	/* Don't allow queue to become completely full, report (free - 1). */=0D
+	return wq->q_depth - hinic3_wq_get_used(wq) - 1;=0D
+}=0D
+=0D
+static inline void *hinic3_wq_get_one_wqebb(struct hinic3_wq *wq, u16 *pi)=
=0D
+{=0D
+	*pi =3D wq->prod_idx & wq->idx_mask;=0D
+	wq->prod_idx++;=0D
+	return get_q_element(&wq->qpages, *pi, NULL);=0D
+}=0D
+=0D
+static inline void hinic3_wq_put_wqebbs(struct hinic3_wq *wq, u16 num_wqeb=
bs)=0D
+{=0D
+	wq->cons_idx +=3D num_wqebbs;=0D
+}=0D
+=0D
+void hinic3_wq_get_multi_wqebbs(struct hinic3_wq *wq,=0D
+				u16 num_wqebbs, u16 *prod_idx,=0D
+				struct hinic3_sq_bufdesc **first_part_wqebbs,=0D
+				struct hinic3_sq_bufdesc **second_part_wqebbs,=0D
+				u16 *first_part_wqebbs_num);=0D
+=0D
+#endif=0D
-- =0D
2.45.2=0D
=0D

