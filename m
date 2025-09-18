Return-Path: <netdev+bounces-222433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C49B4B542FA
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 08:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0E61C845B2
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 06:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D2A2D4B7A;
	Fri, 12 Sep 2025 06:29:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B512D3EDA;
	Fri, 12 Sep 2025 06:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757658546; cv=none; b=knH7Vi4sbByvGOxu/ydWtlJBQZfpS9lDHPnwStuuO9Eyb7qgTd3th1xddGuCBJMVv0ZoNVrdaAxmIhJ3ez0jJLsKuqfrj+lsLYwrwMGcKvKz91aS5Dz6YBcaBxwY1EzAsCUodKMgzsWfsC/RCn0wljreTHDumjJgXxPdpEVW/o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757658546; c=relaxed/simple;
	bh=9StRMdFsSZvQzpmkBiyPRuyFOiy6m+edJJMSfxgMqBo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hYhsPlb/HUT3bhs5L0UgK1BcwtPaFX6+BdbrDlOMLW8dYGP1lFLBZd5bp/HdfsH5g5iiJBfnOxaFvBZuUM1iBBmqQ2nKBoEn52YC4FTzG6kMdXOimgGm5Qweb8pzP8LqQIGArHIEwsUROz8Rm5mJrnEedwfU6shKpTiTMtTrLNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cNPdW6rfNz14N4q;
	Fri, 12 Sep 2025 14:28:47 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 08618180B69;
	Fri, 12 Sep 2025 14:29:02 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.55) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 12 Sep 2025 14:29:00 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas
	<helgaas@kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
	<guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>, Meny Yossefi
	<meny.yossefi@huawei.com>, Gur Stavi <gur.stavi@huawei.com>, Lee Trager
	<lee@trager.us>, Michael Ellerman <mpe@ellerman.id.au>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Suman Ghosh <sumang@marvell.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Joe Damato <jdamato@fastly.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH net-next v06 11/14] hinic3: Add Rss function
Date: Fri, 12 Sep 2025 14:28:28 +0800
Message-ID: <a69336e9b174950be5fe2c14f3450790f18eb293.1757653621.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1757653621.git.zhuyikai1@h-partners.com>
References: <cover.1757653621.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100013.china.huawei.com (7.202.181.12)

Initialize rss functions. Configure rss hash data and HW resources.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/Makefile   |   1 +
 .../net/ethernet/huawei/hinic3/hinic3_main.c  |   8 +-
 .../huawei/hinic3/hinic3_mgmt_interface.h     |  55 +++
 .../huawei/hinic3/hinic3_netdev_ops.c         |  18 +
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |   5 +
 .../net/ethernet/huawei/hinic3/hinic3_rss.c   | 336 ++++++++++++++++++
 .../net/ethernet/huawei/hinic3/hinic3_rss.h   |  14 +
 7 files changed, 436 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/Makefile b/drivers/net/ethernet/huawei/hinic3/Makefile
index a9f055cfef52..c3efa45a6a42 100644
--- a/drivers/net/ethernet/huawei/hinic3/Makefile
+++ b/drivers/net/ethernet/huawei/hinic3/Makefile
@@ -19,6 +19,7 @@ hinic3-objs := hinic3_cmdq.o \
 	       hinic3_nic_cfg.o \
 	       hinic3_nic_io.o \
 	       hinic3_queue_common.o \
+	       hinic3_rss.o \
 	       hinic3_rx.o \
 	       hinic3_tx.o \
 	       hinic3_wq.o
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
index a0b04fb07c76..6d87d4d895ba 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
@@ -12,6 +12,7 @@
 #include "hinic3_nic_cfg.h"
 #include "hinic3_nic_dev.h"
 #include "hinic3_nic_io.h"
+#include "hinic3_rss.h"
 #include "hinic3_rx.h"
 #include "hinic3_tx.h"
 
@@ -134,6 +135,8 @@ static int hinic3_sw_init(struct net_device *netdev)
 	nic_dev->q_params.sq_depth = HINIC3_SQ_DEPTH;
 	nic_dev->q_params.rq_depth = HINIC3_RQ_DEPTH;
 
+	hinic3_try_to_enable_rss(netdev);
+
 	/* VF driver always uses random MAC address. During VM migration to a
 	 * new device, the new device should learn the VMs old MAC rather than
 	 * provide its own MAC. The product design assumes that every VF is
@@ -145,7 +148,7 @@ static int hinic3_sw_init(struct net_device *netdev)
 			     hinic3_global_func_id(hwdev));
 	if (err) {
 		dev_err(hwdev->dev, "Failed to set default MAC\n");
-		return err;
+		goto err_clear_rss_config;
 	}
 
 	err = hinic3_alloc_txrxqs(netdev);
@@ -159,6 +162,8 @@ static int hinic3_sw_init(struct net_device *netdev)
 err_del_mac:
 	hinic3_del_mac(hwdev, netdev->dev_addr, 0,
 		       hinic3_global_func_id(hwdev));
+err_clear_rss_config:
+	hinic3_clear_rss_config(netdev);
 
 	return err;
 }
@@ -170,6 +175,7 @@ static void hinic3_sw_uninit(struct net_device *netdev)
 	hinic3_free_txrxqs(netdev);
 	hinic3_del_mac(nic_dev->hwdev, netdev->dev_addr, 0,
 		       hinic3_global_func_id(nic_dev->hwdev));
+	hinic3_clear_rss_config(netdev);
 }
 
 static void hinic3_assign_netdev_ops(struct net_device *netdev)
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
index 20d37670e133..7012130bba1d 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_mgmt_interface.h
@@ -87,9 +87,59 @@ struct l2nic_cmd_set_dcb_state {
 	u8                   rsvd[7];
 };
 
+#define L2NIC_RSS_TYPE_VALID_MASK         BIT(23)
+#define L2NIC_RSS_TYPE_TCP_IPV6_EXT_MASK  BIT(24)
+#define L2NIC_RSS_TYPE_IPV6_EXT_MASK      BIT(25)
+#define L2NIC_RSS_TYPE_TCP_IPV6_MASK      BIT(26)
+#define L2NIC_RSS_TYPE_IPV6_MASK          BIT(27)
+#define L2NIC_RSS_TYPE_TCP_IPV4_MASK      BIT(28)
+#define L2NIC_RSS_TYPE_IPV4_MASK          BIT(29)
+#define L2NIC_RSS_TYPE_UDP_IPV6_MASK      BIT(30)
+#define L2NIC_RSS_TYPE_UDP_IPV4_MASK      BIT(31)
+#define L2NIC_RSS_TYPE_SET(val, member)  \
+	FIELD_PREP(L2NIC_RSS_TYPE_##member##_MASK, val)
+#define L2NIC_RSS_TYPE_GET(val, member)  \
+	FIELD_GET(L2NIC_RSS_TYPE_##member##_MASK, val)
+
+#define L2NIC_RSS_INDIR_SIZE  256
+#define L2NIC_RSS_KEY_SIZE    40
+
 /* IEEE 802.1Qaz std */
 #define L2NIC_DCB_COS_MAX     0x8
 
+struct l2nic_cmd_set_rss_ctx_tbl {
+	struct mgmt_msg_head msg_head;
+	u16                  func_id;
+	u16                  rsvd1;
+	u32                  context;
+};
+
+struct l2nic_cmd_cfg_rss_engine {
+	struct mgmt_msg_head msg_head;
+	u16                  func_id;
+	u8                   opcode;
+	u8                   hash_engine;
+	u8                   rsvd1[4];
+};
+
+struct l2nic_cmd_cfg_rss_hash_key {
+	struct mgmt_msg_head msg_head;
+	u16                  func_id;
+	u8                   opcode;
+	u8                   rsvd1;
+	u8                   key[L2NIC_RSS_KEY_SIZE];
+};
+
+struct l2nic_cmd_cfg_rss {
+	struct mgmt_msg_head msg_head;
+	u16                  func_id;
+	u8                   rss_en;
+	u8                   rq_priority_number;
+	u8                   prio_tc[L2NIC_DCB_COS_MAX];
+	u16                  num_qps;
+	u16                  rsvd1;
+};
+
 /* Commands between NIC to fw */
 enum l2nic_cmd {
 	/* FUNC CFG */
@@ -110,6 +160,11 @@ enum l2nic_cmd {
 	L2NIC_CMD_MAX                 = 256,
 };
 
+struct l2nic_cmd_rss_set_indir_tbl {
+	__le32 rsvd[4];
+	__le16 entry[L2NIC_RSS_INDIR_SIZE];
+};
+
 /* NIC CMDQ MODE */
 enum l2nic_ucode_cmd {
 	L2NIC_UCODE_CMD_MODIFY_QUEUE_CTX  = 0,
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
index 9e1e219b2508..0f8b156fa206 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
@@ -8,6 +8,7 @@
 #include "hinic3_nic_cfg.h"
 #include "hinic3_nic_dev.h"
 #include "hinic3_nic_io.h"
+#include "hinic3_rss.h"
 #include "hinic3_rx.h"
 #include "hinic3_tx.h"
 
@@ -222,9 +223,25 @@ static int hinic3_configure(struct net_device *netdev)
 	/* Ensure DCB is disabled */
 	hinic3_sync_dcb_state(nic_dev->hwdev, 1, 0);
 
+	if (test_bit(HINIC3_RSS_ENABLE, &nic_dev->flags)) {
+		err = hinic3_rss_init(netdev);
+		if (err) {
+			netdev_err(netdev, "Failed to init rss\n");
+			return err;
+		}
+	}
+
 	return 0;
 }
 
+static void hinic3_remove_configure(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	if (test_bit(HINIC3_RSS_ENABLE, &nic_dev->flags))
+		hinic3_rss_uninit(netdev);
+}
+
 static int hinic3_alloc_channel_resources(struct net_device *netdev,
 					  struct hinic3_dyna_qp_params *qp_params,
 					  struct hinic3_dyna_txrxq_params *trxq_params)
@@ -305,6 +322,7 @@ static void hinic3_close_channel(struct net_device *netdev)
 {
 	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
 
+	hinic3_remove_configure(netdev);
 	hinic3_qps_irq_uninit(netdev);
 	hinic3_free_qp_ctxts(nic_dev);
 }
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
index 9fad834f9e92..5ba83261616c 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
@@ -73,6 +73,11 @@ struct hinic3_nic_dev {
 	struct hinic3_txq               *txqs;
 	struct hinic3_rxq               *rxqs;
 
+	enum hinic3_rss_hash_type       rss_hash_type;
+	struct hinic3_rss_type          rss_type;
+	u8                              *rss_hkey;
+	u16                             *rss_indir;
+
 	u16                             num_qp_irq;
 	struct msix_entry               *qps_msix_entries;
 
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
new file mode 100644
index 000000000000..4ff1b2f79838
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
@@ -0,0 +1,336 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
+
+#include <linux/ethtool.h>
+
+#include "hinic3_cmdq.h"
+#include "hinic3_hwdev.h"
+#include "hinic3_hwif.h"
+#include "hinic3_mbox.h"
+#include "hinic3_nic_cfg.h"
+#include "hinic3_nic_dev.h"
+#include "hinic3_rss.h"
+
+static void hinic3_fillout_indir_tbl(struct net_device *netdev, u16 *indir)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	u16 i, num_qps;
+
+	num_qps = nic_dev->q_params.num_qps;
+	for (i = 0; i < L2NIC_RSS_INDIR_SIZE; i++)
+		indir[i] = ethtool_rxfh_indir_default(i, num_qps);
+}
+
+static int hinic3_rss_cfg(struct hinic3_hwdev *hwdev, u8 rss_en, u16 num_qps)
+{
+	struct mgmt_msg_params msg_params = {};
+	struct l2nic_cmd_cfg_rss rss_cfg = {};
+	int err;
+
+	rss_cfg.func_id = hinic3_global_func_id(hwdev);
+	rss_cfg.rss_en = rss_en;
+	rss_cfg.rq_priority_number = 0;
+	rss_cfg.num_qps = num_qps;
+
+	mgmt_msg_params_init_default(&msg_params, &rss_cfg, sizeof(rss_cfg));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,
+				       L2NIC_CMD_CFG_RSS, &msg_params);
+	if (err || rss_cfg.msg_head.status) {
+		dev_err(hwdev->dev, "Failed to set rss cfg, err: %d, status: 0x%x\n",
+			err, rss_cfg.msg_head.status);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void hinic3_init_rss_parameters(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	nic_dev->rss_hash_type = HINIC3_RSS_HASH_ENGINE_TYPE_XOR;
+	nic_dev->rss_type.tcp_ipv6_ext = 1;
+	nic_dev->rss_type.ipv6_ext = 1;
+	nic_dev->rss_type.tcp_ipv6 = 1;
+	nic_dev->rss_type.ipv6 = 1;
+	nic_dev->rss_type.tcp_ipv4 = 1;
+	nic_dev->rss_type.ipv4 = 1;
+	nic_dev->rss_type.udp_ipv6 = 1;
+	nic_dev->rss_type.udp_ipv4 = 1;
+}
+
+static void decide_num_qps(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	unsigned int dev_cpus;
+
+	dev_cpus = netif_get_num_default_rss_queues();
+	nic_dev->q_params.num_qps = min(dev_cpus, nic_dev->max_qps);
+}
+
+static int alloc_rss_resource(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	nic_dev->rss_hkey = kmalloc_array(L2NIC_RSS_KEY_SIZE,
+					  sizeof(nic_dev->rss_hkey[0]),
+					  GFP_KERNEL);
+	if (!nic_dev->rss_hkey)
+		return -ENOMEM;
+
+	netdev_rss_key_fill(nic_dev->rss_hkey, L2NIC_RSS_KEY_SIZE);
+
+	nic_dev->rss_indir = kcalloc(L2NIC_RSS_INDIR_SIZE, sizeof(u16),
+				     GFP_KERNEL);
+	if (!nic_dev->rss_indir) {
+		kfree(nic_dev->rss_hkey);
+		nic_dev->rss_hkey = NULL;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int hinic3_rss_set_indir_tbl(struct hinic3_hwdev *hwdev,
+				    const u16 *indir_table)
+{
+	struct l2nic_cmd_rss_set_indir_tbl *indir_tbl;
+	struct hinic3_cmd_buf *cmd_buf;
+	__le64 out_param;
+	int err;
+	u32 i;
+
+	cmd_buf = hinic3_alloc_cmd_buf(hwdev);
+	if (!cmd_buf) {
+		dev_err(hwdev->dev, "Failed to allocate cmd buf\n");
+		return -ENOMEM;
+	}
+
+	cmd_buf->size = cpu_to_le16(sizeof(struct l2nic_cmd_rss_set_indir_tbl));
+	indir_tbl = cmd_buf->buf;
+	memset(indir_tbl, 0, sizeof(*indir_tbl));
+
+	for (i = 0; i < L2NIC_RSS_INDIR_SIZE; i++)
+		indir_tbl->entry[i] = cpu_to_le16(indir_table[i]);
+
+	hinic3_cmdq_buf_swab32(indir_tbl, sizeof(*indir_tbl));
+
+	err = hinic3_cmdq_direct_resp(hwdev, MGMT_MOD_L2NIC,
+				      L2NIC_UCODE_CMD_SET_RSS_INDIR_TBL,
+				      cmd_buf, &out_param);
+	if (err || out_param) {
+		dev_err(hwdev->dev, "Failed to set rss indir table\n");
+		err = -EFAULT;
+	}
+
+	hinic3_free_cmd_buf(hwdev, cmd_buf);
+
+	return err;
+}
+
+static int hinic3_set_rss_type(struct hinic3_hwdev *hwdev,
+			       struct hinic3_rss_type rss_type)
+{
+	struct l2nic_cmd_set_rss_ctx_tbl ctx_tbl = {};
+	struct mgmt_msg_params msg_params = {};
+	u32 ctx;
+	int err;
+
+	ctx_tbl.func_id = hinic3_global_func_id(hwdev);
+	ctx = L2NIC_RSS_TYPE_SET(1, VALID) |
+	      L2NIC_RSS_TYPE_SET(rss_type.ipv4, IPV4) |
+	      L2NIC_RSS_TYPE_SET(rss_type.ipv6, IPV6) |
+	      L2NIC_RSS_TYPE_SET(rss_type.ipv6_ext, IPV6_EXT) |
+	      L2NIC_RSS_TYPE_SET(rss_type.tcp_ipv4, TCP_IPV4) |
+	      L2NIC_RSS_TYPE_SET(rss_type.tcp_ipv6, TCP_IPV6) |
+	      L2NIC_RSS_TYPE_SET(rss_type.tcp_ipv6_ext, TCP_IPV6_EXT) |
+	      L2NIC_RSS_TYPE_SET(rss_type.udp_ipv4, UDP_IPV4) |
+	      L2NIC_RSS_TYPE_SET(rss_type.udp_ipv6, UDP_IPV6);
+	ctx_tbl.context = ctx;
+
+	mgmt_msg_params_init_default(&msg_params, &ctx_tbl, sizeof(ctx_tbl));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,
+				       L2NIC_CMD_SET_RSS_CTX_TBL, &msg_params);
+
+	if (ctx_tbl.msg_head.status == MGMT_STATUS_CMD_UNSUPPORTED) {
+		return MGMT_STATUS_CMD_UNSUPPORTED;
+	} else if (err || ctx_tbl.msg_head.status) {
+		dev_err(hwdev->dev, "mgmt Failed to set rss context offload, err: %d, status: 0x%x\n",
+			err, ctx_tbl.msg_head.status);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int hinic3_rss_cfg_hash_type(struct hinic3_hwdev *hwdev, u8 opcode,
+				    enum hinic3_rss_hash_type *type)
+{
+	struct l2nic_cmd_cfg_rss_engine hash_type_cmd = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	hash_type_cmd.func_id = hinic3_global_func_id(hwdev);
+	hash_type_cmd.opcode = opcode;
+
+	if (opcode == MGMT_MSG_CMD_OP_SET)
+		hash_type_cmd.hash_engine = *type;
+
+	mgmt_msg_params_init_default(&msg_params, &hash_type_cmd,
+				     sizeof(hash_type_cmd));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,
+				       L2NIC_CMD_CFG_RSS_HASH_ENGINE,
+				       &msg_params);
+	if (err || hash_type_cmd.msg_head.status) {
+		dev_err(hwdev->dev, "Failed to %s hash engine, err: %d, status: 0x%x\n",
+			opcode == MGMT_MSG_CMD_OP_SET ? "set" : "get",
+			err, hash_type_cmd.msg_head.status);
+		return -EIO;
+	}
+
+	if (opcode == MGMT_MSG_CMD_OP_GET)
+		*type = hash_type_cmd.hash_engine;
+
+	return 0;
+}
+
+static int hinic3_rss_set_hash_type(struct hinic3_hwdev *hwdev,
+				    enum hinic3_rss_hash_type type)
+{
+	return hinic3_rss_cfg_hash_type(hwdev, MGMT_MSG_CMD_OP_SET, &type);
+}
+
+static int hinic3_config_rss_hw_resource(struct net_device *netdev,
+					 u16 *indir_tbl)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int err;
+
+	err = hinic3_rss_set_indir_tbl(nic_dev->hwdev, indir_tbl);
+	if (err)
+		return err;
+
+	err = hinic3_set_rss_type(nic_dev->hwdev, nic_dev->rss_type);
+	if (err)
+		return err;
+
+	return hinic3_rss_set_hash_type(nic_dev->hwdev, nic_dev->rss_hash_type);
+}
+
+static int hinic3_rss_cfg_hash_key(struct hinic3_hwdev *hwdev, u8 opcode,
+				   u8 *key)
+{
+	struct l2nic_cmd_cfg_rss_hash_key hash_key = {};
+	struct mgmt_msg_params msg_params = {};
+	int err;
+
+	hash_key.func_id = hinic3_global_func_id(hwdev);
+	hash_key.opcode = opcode;
+
+	if (opcode == MGMT_MSG_CMD_OP_SET)
+		memcpy(hash_key.key, key, L2NIC_RSS_KEY_SIZE);
+
+	mgmt_msg_params_init_default(&msg_params, &hash_key, sizeof(hash_key));
+
+	err = hinic3_send_mbox_to_mgmt(hwdev, MGMT_MOD_L2NIC,
+				       L2NIC_CMD_CFG_RSS_HASH_KEY, &msg_params);
+	if (err || hash_key.msg_head.status) {
+		dev_err(hwdev->dev, "Failed to %s hash key, err: %d, status: 0x%x\n",
+			opcode == MGMT_MSG_CMD_OP_SET ? "set" : "get",
+			err, hash_key.msg_head.status);
+		return -EINVAL;
+	}
+
+	if (opcode == MGMT_MSG_CMD_OP_GET)
+		memcpy(key, hash_key.key, L2NIC_RSS_KEY_SIZE);
+
+	return 0;
+}
+
+static int hinic3_rss_set_hash_key(struct hinic3_hwdev *hwdev, u8 *key)
+{
+	return hinic3_rss_cfg_hash_key(hwdev, MGMT_MSG_CMD_OP_SET, key);
+}
+
+static int hinic3_set_hw_rss_parameters(struct net_device *netdev, u8 rss_en)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	int err;
+
+	err = hinic3_rss_set_hash_key(nic_dev->hwdev, nic_dev->rss_hkey);
+	if (err)
+		return err;
+
+	hinic3_fillout_indir_tbl(netdev, nic_dev->rss_indir);
+
+	err = hinic3_config_rss_hw_resource(netdev, nic_dev->rss_indir);
+	if (err)
+		return err;
+
+	err = hinic3_rss_cfg(nic_dev->hwdev, rss_en, nic_dev->q_params.num_qps);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+int hinic3_rss_init(struct net_device *netdev)
+{
+	return hinic3_set_hw_rss_parameters(netdev, 1);
+}
+
+void hinic3_rss_uninit(struct net_device *netdev)
+{
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+
+	hinic3_rss_cfg(nic_dev->hwdev, 0, 0);
+}
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
+	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
+	struct hinic3_hwdev *hwdev = nic_dev->hwdev;
+	int err;
+
+	nic_dev->max_qps = hinic3_func_max_qnum(hwdev);
+	if (nic_dev->max_qps <= 1 ||
+	    !hinic3_test_support(nic_dev, HINIC3_NIC_F_RSS))
+		goto err_reset_q_params;
+
+	err = alloc_rss_resource(netdev);
+	if (err) {
+		nic_dev->max_qps = 1;
+		goto err_reset_q_params;
+	}
+
+	set_bit(HINIC3_RSS_ENABLE, &nic_dev->flags);
+	decide_num_qps(netdev);
+	hinic3_init_rss_parameters(netdev);
+	err = hinic3_set_hw_rss_parameters(netdev, 0);
+	if (err) {
+		dev_err(hwdev->dev, "Failed to set hardware rss parameters\n");
+		hinic3_clear_rss_config(netdev);
+		nic_dev->max_qps = 1;
+		goto err_reset_q_params;
+	}
+
+	return;
+
+err_reset_q_params:
+	clear_bit(HINIC3_RSS_ENABLE, &nic_dev->flags);
+	nic_dev->q_params.num_qps = nic_dev->max_qps;
+}
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rss.h b/drivers/net/ethernet/huawei/hinic3/hinic3_rss.h
new file mode 100644
index 000000000000..78d82c2aca06
--- /dev/null
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rss.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved. */
+
+#ifndef _HINIC3_RSS_H_
+#define _HINIC3_RSS_H_
+
+#include <linux/netdevice.h>
+
+int hinic3_rss_init(struct net_device *netdev);
+void hinic3_rss_uninit(struct net_device *netdev);
+void hinic3_try_to_enable_rss(struct net_device *netdev);
+void hinic3_clear_rss_config(struct net_device *netdev);
+
+#endif
-- 
2.43.0


