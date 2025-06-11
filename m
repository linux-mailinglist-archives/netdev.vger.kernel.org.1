Return-Path: <netdev+bounces-196457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5555AD4E8B
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 10:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7822C3A7D6F
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 08:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964CB23D2BD;
	Wed, 11 Jun 2025 08:37:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.58.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B49E23E25A
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 08:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.58.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749631020; cv=none; b=JMKf++Z86r4oee7a12FqoiXgrqyj05v8xKoFcXHOVT17XdoXU5pAxeaj2bzyMoIJDinK++sHua2s3umRyvHC+w9r2f2wMZAVxx4MX0jX4b+s8W6vrp7nYJlXMMI+vf0Voc4ONjHpiqwfdN+riFP6w7sowLDfBpaS9Wg2wTxQe+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749631020; c=relaxed/simple;
	bh=8YCMylCTGfPTxX9TGbyGtzMAQirY2YQq4RzBt3UwoCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fXTcAY2k3yOMPKsym0km22iOoiXKUJhen4cn0NBNumve+kcWfz7aipduRE4XVimqPZn0ma8E5DtCIT1haLuc4Ug+Sb04yiO8PU6EQT6YWT2Mq23yYNCNPsGzmre/RS/587Ci3vK6wIz0lx2OMWUeQqoktneC2BAFlmaCrIqGTMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=114.132.58.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpgz1t1749630971t569e103c
X-QQ-Originating-IP: CjvRLQfNe88i9rNQMzgiV+7VnA64yLawpYE7HPPxFYg=
Received: from localhost.localdomain ( [36.20.60.58])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 11 Jun 2025 16:36:10 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 502629808313405026
EX-QQ-RecipientCnt: 9
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	duanqiangwen@net-swift.com,
	linglingzhang@trustnetic.com,
	jiawenwu@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next 03/12] net: libwx: add wangxun vf common api
Date: Wed, 11 Jun 2025 16:35:50 +0800
Message-Id: <20250611083559.14175-4-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20250611083559.14175-1-mengyuanlou@net-swift.com>
References: <20250611083559.14175-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MyirvGjpKb1jmA4kzgpnr9I23sPpw5gq7Kfi0am72tai6y2oksj2YKzb
	Srw5lIqSlN7I3JOPp/qx6XXDDqhWhEKFud4so5lrusSITN+1Qt7aYC7b59Ul2+U9/EMo9X6
	Dk2w6TySx8mjv/x0WCt5sRF3pt20EfemRMuN/D777geA3v3uY8tX15QATKThNelpUYvdGPo
	MukXvl64Jzlp72CQO4GaRE5qvVO5zO2NRX7IfK28QQSF+QtjXWhpQ1snLjEoo5VMGewGAoJ
	3jcY8ce9vABzbuMHvSR3DKSGgxMasZeBpwVHATCRzdY186Ffc1HWm9EI77ycuVyvc98r/BB
	ipWBZ7Tv6iFDm1ccfF33Qcv1u3rSVBz7b0uPkOWjH6lVI8tY2OiqrJZRf3CJJGH1CDSEYew
	q8O0lM5kmZfOH9IB2n40cZJrwKl10+GJN2jHVMi/wNEegA5iNAtSvT8/X7ojX32s/vnRvAN
	3iRB1rppFMxwQBoCJqF2lBrKYGz4zQA1lOvX0xT7FsFjQUp0mdw/TQskT0cA2PqdQd+8XO+
	B1RRh1j1aSBRP9Yfv1Ax6f2AzbeisvTL5WI5uTo8qaf5m5hj5tdkP3g5QRgOlIA6ZsoW5Dt
	L64eIRQAJPz+7xERufoGCZw1Fh2sSIZT/l1tFUczZuTcRcPS4X+YBjhyUu/S9avLDlEgBRp
	cYoVbRADmegxgffDHB8lBSw2P0PH1dfTqtVF1bBWFxKpx9dFqXZT/hQUq3KpRW1LVT7ixzl
	ZnbGsN8DVZRD+N+kdg3dmvtwzqS59XtyJHA2ruJF2LRFpwEcOlmoLPU3JK78sFY7J9CiLBN
	6vQJvFmT802eH/OEQWFx21GPgk8HZDl/ysJ/No6H1bteTQkOIYIn5ANBrAWrXFia3nU9TZM
	dbQYzb2mWjAkXlBOpYjkAfsRCBzsNDk9I/jA48TJNCH5ay5KVozAc+3KCBvha1yVv9vT7dp
	VdwApfXLJaKi0zRfosB5rO8Sa58YoFHKVVDqwhq2zeeWliBVFcd95jS8VkQTGJbK4NlAFyq
	P3LqU4jT7EwomlE26pFnLH9QRLXv6brwZeqSpNoDbK6oE2diSe1yiiAC8DPukLdNt1Srq0J
	yncRzmnMeW1i6tqX56iJOg=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Add common wx_configure_vf and wx_set_mac_vf for
ngbevf and txgbevf.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |   3 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   4 +
 drivers/net/ethernet/wangxun/libwx/wx_vf.h    |  49 +++
 .../net/ethernet/wangxun/libwx/wx_vf_common.c | 194 ++++++++++++
 .../net/ethernet/wangxun/libwx/wx_vf_common.h |  14 +
 .../net/ethernet/wangxun/libwx/wx_vf_lib.c    | 290 ++++++++++++++++++
 .../net/ethernet/wangxun/libwx/wx_vf_lib.h    |  14 +
 9 files changed, 569 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_vf_lib.h

diff --git a/drivers/net/ethernet/wangxun/libwx/Makefile b/drivers/net/ethernet/wangxun/libwx/Makefile
index ddf0bb921676..a71b0ad77de3 100644
--- a/drivers/net/ethernet/wangxun/libwx/Makefile
+++ b/drivers/net/ethernet/wangxun/libwx/Makefile
@@ -5,4 +5,4 @@
 obj-$(CONFIG_LIBWX) += libwx.o
 
 libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_ptp.o wx_mbx.o wx_sriov.o
-libwx-objs += wx_vf.o
+libwx-objs += wx_vf.o wx_vf_lib.o wx_vf_common.o
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 82dd76f0326e..27bb33788701 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -1827,7 +1827,7 @@ void wx_disable_rx_queue(struct wx *wx, struct wx_ring *ring)
 }
 EXPORT_SYMBOL(wx_disable_rx_queue);
 
-static void wx_enable_rx_queue(struct wx *wx, struct wx_ring *ring)
+void wx_enable_rx_queue(struct wx *wx, struct wx_ring *ring)
 {
 	u8 reg_idx = ring->reg_idx;
 	u32 rxdctl;
@@ -1843,6 +1843,7 @@ static void wx_enable_rx_queue(struct wx *wx, struct wx_ring *ring)
 		       reg_idx);
 	}
 }
+EXPORT_SYMBOL(wx_enable_rx_queue);
 
 static void wx_configure_srrctl(struct wx *wx,
 				struct wx_ring *rx_ring)
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.h b/drivers/net/ethernet/wangxun/libwx/wx_hw.h
index 718015611da6..2393a743b564 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.h
@@ -38,6 +38,7 @@ void wx_enable_sec_rx_path(struct wx *wx);
 void wx_set_rx_mode(struct net_device *netdev);
 int wx_change_mtu(struct net_device *netdev, int new_mtu);
 void wx_disable_rx_queue(struct wx *wx, struct wx_ring *ring);
+void wx_enable_rx_queue(struct wx *wx, struct wx_ring *ring);
 void wx_configure_rx(struct wx *wx);
 void wx_configure(struct wx *wx);
 void wx_start_hw(struct wx *wx);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index d2d0764792d4..63bb7785fd19 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -828,6 +828,8 @@ struct wx_mbx_info {
 	u32 mailbox;
 	u32 udelay;
 	u32 timeout;
+	/* lock mbx access */
+	spinlock_t mbx_lock;
 };
 
 struct wx_thermal_sensor_data {
@@ -1288,6 +1290,8 @@ struct wx {
 	u32 *isb_mem;
 	u32 isb_tag[WX_ISB_MAX];
 	bool misc_irq_domain;
+	u32 eims_other;
+	u32 eims_enable_mask;
 
 #define WX_MAX_RETA_ENTRIES 128
 #define WX_RSS_INDIR_TBL_MAX 64
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf.h b/drivers/net/ethernet/wangxun/libwx/wx_vf.h
index eb40048f46eb..3bb70421622a 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf.h
@@ -11,6 +11,7 @@
 #define WX_VXMRQC                0x78
 #define WX_VXICR                 0x100
 #define WX_VXIMS                 0x108
+#define WX_VXIMC                 0x10C
 #define WX_VF_IRQ_CLEAR_MASK     7
 #define WX_VF_MAX_TX_QUEUES      4
 #define WX_VF_MAX_RX_QUEUES      4
@@ -19,6 +20,11 @@
 #define WX_VXRXDCTL_ENABLE       BIT(0)
 #define WX_VXTXDCTL_FLUSH        BIT(26)
 
+#define WX_VXITR(i)              (0x200 + (4 * (i))) /* i=[0,1] */
+#define WX_VXITR_CNT_WDIS        BIT(31)
+#define WX_VXIVAR_MISC           0x260
+#define WX_VXIVAR(i)             (0x240 + (4 * (i))) /* i=[0,3] */
+
 #define WX_VXRXDCTL_RSCMAX(f)    FIELD_PREP(GENMASK(24, 23), f)
 #define WX_VXRXDCTL_BUFLEN(f)    FIELD_PREP(GENMASK(6, 1), f)
 #define WX_VXRXDCTL_BUFSZ(f)     FIELD_PREP(GENMASK(11, 8), f)
@@ -41,6 +47,49 @@
 #define WX_RX_HDR_SIZE           256
 #define WX_RX_BUF_SIZE           2048
 
+#define WX_RXBUFFER_2048         (2048)
+#define WX_RXBUFFER_3072         3072
+
+/* Receive Path */
+#define WX_VXRDBAL(r)            (0x1000 + (0x40 * (r)))
+#define WX_VXRDBAH(r)            (0x1004 + (0x40 * (r)))
+#define WX_VXRDT(r)              (0x1008 + (0x40 * (r)))
+#define WX_VXRDH(r)              (0x100C + (0x40 * (r)))
+
+#define WX_VXRXDCTL_RSCEN        BIT(29)
+#define WX_VXRXDCTL_DROP         BIT(30)
+#define WX_VXRXDCTL_VLAN         BIT(31)
+
+#define WX_VXTDBAL(r)            (0x3000 + (0x40 * (r)))
+#define WX_VXTDBAH(r)            (0x3004 + (0x40 * (r)))
+#define WX_VXTDT(r)              (0x3008 + (0x40 * (r)))
+#define WX_VXTDH(r)              (0x300C + (0x40 * (r)))
+
+#define WX_VXTXDCTL_ENABLE       BIT(0)
+#define WX_VXTXDCTL_BUFLEN(f)    FIELD_PREP(GENMASK(6, 1), f)
+#define WX_VXTXDCTL_PTHRESH(f)   FIELD_PREP(GENMASK(11, 8), f)
+#define WX_VXTXDCTL_WTHRESH(f)   FIELD_PREP(GENMASK(22, 16), f)
+
+#define WX_VXMRQC_PSR(f)         FIELD_PREP(GENMASK(5, 1), f)
+#define WX_VXMRQC_PSR_MASK       GENMASK(5, 1)
+#define WX_VXMRQC_PSR_L4HDR      BIT(0)
+#define WX_VXMRQC_PSR_L3HDR      BIT(1)
+#define WX_VXMRQC_PSR_L2HDR      BIT(2)
+#define WX_VXMRQC_PSR_TUNHDR     BIT(3)
+#define WX_VXMRQC_PSR_TUNMAC     BIT(4)
+
+#define WX_VXRSSRK(i)            (0x80 + ((i) * 4)) /* i=[0,9] */
+#define WX_VXRETA(i)             (0xC0 + ((i) * 4)) /* i=[0,15] */
+
+#define WX_VXMRQC_RSS(f)         FIELD_PREP(GENMASK(31, 16), f)
+#define WX_VXMRQC_RSS_MASK       GENMASK(31, 16)
+#define WX_VXMRQC_RSS_ALG_IPV4_TCP   BIT(0)
+#define WX_VXMRQC_RSS_ALG_IPV4       BIT(1)
+#define WX_VXMRQC_RSS_ALG_IPV6       BIT(4)
+#define WX_VXMRQC_RSS_ALG_IPV6_TCP   BIT(5)
+#define WX_VXMRQC_RSS_EN             BIT(8)
+#define WX_VXMRQC_RSS_HASH(f)    FIELD_PREP(GENMASK(15, 13), f)
+
 void wx_start_hw_vf(struct wx *wx);
 void wx_init_hw_vf(struct wx *wx);
 int wx_reset_hw_vf(struct wx *wx);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
new file mode 100644
index 000000000000..861adf97e801
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2015 - 2025 Beijing WangXun Technology Co., Ltd. */
+
+#include <linux/etherdevice.h>
+#include <linux/pci.h>
+
+#include "wx_type.h"
+#include "wx_mbx.h"
+#include "wx_lib.h"
+#include "wx_vf.h"
+#include "wx_vf_lib.h"
+#include "wx_vf_common.h"
+
+static irqreturn_t wx_msix_misc_vf(int __always_unused irq, void *data)
+{
+	struct wx *wx = data;
+
+	/* Clear the interrupt */
+	if (netif_running(wx->netdev))
+		wr32(wx, WX_VXIMC, wx->eims_other);
+
+	return IRQ_HANDLED;
+}
+
+int wx_request_msix_irqs_vf(struct wx *wx)
+{
+	struct net_device *netdev = wx->netdev;
+	int vector, err;
+
+	for (vector = 0; vector < wx->num_q_vectors; vector++) {
+		struct wx_q_vector *q_vector = wx->q_vector[vector];
+		struct msix_entry *entry = &wx->msix_q_entries[vector];
+
+		if (q_vector->tx.ring && q_vector->rx.ring)
+			snprintf(q_vector->name, sizeof(q_vector->name) - 1,
+				 "%s-TxRx-%d", netdev->name, entry->entry);
+		else
+			/* skip this unused q_vector */
+			continue;
+
+		err = request_irq(entry->vector, wx_msix_clean_rings, 0,
+				  q_vector->name, q_vector);
+		if (err) {
+			wx_err(wx, "request_irq failed for MSIX interrupt %s Error: %d\n",
+			       q_vector->name, err);
+			goto free_queue_irqs;
+		}
+	}
+
+	err = request_irq(wx->msix_entry->vector,
+			  wx_msix_misc_vf, 0, netdev->name, wx);
+	if (err) {
+		wx_err(wx, "request_irq for msix_other failed: %d\n", err);
+		goto free_queue_irqs;
+	}
+
+	return 0;
+
+free_queue_irqs:
+	while (vector) {
+		vector--;
+		free_irq(wx->msix_q_entries[vector].vector,
+			 wx->q_vector[vector]);
+	}
+	wx_reset_interrupt_capability(wx);
+	return err;
+}
+EXPORT_SYMBOL(wx_request_msix_irqs_vf);
+
+void wx_negotiate_api_vf(struct wx *wx)
+{
+	int api[] = {
+		     wx_mbox_api_13,
+		     wx_mbox_api_null};
+	int err = 0, idx = 0;
+
+	spin_lock_bh(&wx->mbx.mbx_lock);
+	while (api[idx] != wx_mbox_api_null) {
+		err = wx_negotiate_api_version(wx, api[idx]);
+		if (!err)
+			break;
+		idx++;
+	}
+	spin_unlock_bh(&wx->mbx.mbx_lock);
+}
+EXPORT_SYMBOL(wx_negotiate_api_vf);
+
+void wx_reset_vf(struct wx *wx)
+{
+	struct net_device *netdev = wx->netdev;
+	int ret = 0;
+
+	ret = wx_reset_hw_vf(wx);
+	if (!ret)
+		wx_init_hw_vf(wx);
+	wx_negotiate_api_vf(wx);
+	if (is_valid_ether_addr(wx->mac.addr)) {
+		eth_hw_addr_set(netdev, wx->mac.addr);
+		ether_addr_copy(netdev->perm_addr, wx->mac.addr);
+	}
+}
+EXPORT_SYMBOL(wx_reset_vf);
+
+void wx_set_rx_mode_vf(struct net_device *netdev)
+{
+	struct wx *wx = netdev_priv(netdev);
+	unsigned int flags = netdev->flags;
+	int xcast_mode;
+
+	xcast_mode = (flags & IFF_ALLMULTI) ? WXVF_XCAST_MODE_ALLMULTI :
+		     (flags & (IFF_BROADCAST | IFF_MULTICAST)) ?
+		     WXVF_XCAST_MODE_MULTI : WXVF_XCAST_MODE_NONE;
+	/* request the most inclusive mode we need */
+	if (flags & IFF_PROMISC)
+		xcast_mode = WXVF_XCAST_MODE_PROMISC;
+	else if (flags & IFF_ALLMULTI)
+		xcast_mode = WXVF_XCAST_MODE_ALLMULTI;
+	else if (flags & (IFF_BROADCAST | IFF_MULTICAST))
+		xcast_mode = WXVF_XCAST_MODE_MULTI;
+	else
+		xcast_mode = WXVF_XCAST_MODE_NONE;
+
+	spin_lock_bh(&wx->mbx.mbx_lock);
+	wx_update_xcast_mode_vf(wx, xcast_mode);
+	wx_update_mc_addr_list_vf(wx, netdev);
+	wx_write_uc_addr_list_vf(netdev);
+	spin_unlock_bh(&wx->mbx.mbx_lock);
+}
+EXPORT_SYMBOL(wx_set_rx_mode_vf);
+
+/**
+ * wx_configure_rx_vf - Configure Receive Unit after Reset
+ * @wx: board private structure
+ *
+ * Configure the Rx unit of the MAC after a reset.
+ **/
+static void wx_configure_rx_vf(struct wx *wx)
+{
+	struct net_device *netdev = wx->netdev;
+	int i, ret;
+
+	wx_setup_psrtype_vf(wx);
+	wx_setup_vfmrqc_vf(wx);
+
+	spin_lock_bh(&wx->mbx.mbx_lock);
+	ret = wx_rlpml_set_vf(wx, netdev->mtu + ETH_HLEN + ETH_FCS_LEN);
+	spin_unlock_bh(&wx->mbx.mbx_lock);
+	if (ret)
+		wx_dbg(wx, "Failed to set MTU at %d\n", netdev->mtu);
+
+	/* Setup the HW Rx Head and Tail Descriptor Pointers and
+	 * the Base and Length of the Rx Descriptor Ring
+	 */
+	for (i = 0; i < wx->num_rx_queues; i++) {
+		struct wx_ring *rx_ring = wx->rx_ring[i];
+#ifdef HAVE_SWIOTLB_SKIP_CPU_SYNC
+		wx_set_rx_buffer_len_vf(wx, rx_ring);
+#endif
+		wx_configure_rx_ring_vf(wx, rx_ring);
+	}
+}
+
+void wx_configure_vf(struct wx *wx)
+{
+	wx_set_rx_mode_vf(wx->netdev);
+	wx_configure_tx_vf(wx);
+	wx_configure_rx_vf(wx);
+}
+EXPORT_SYMBOL(wx_configure_vf);
+
+int wx_set_mac_vf(struct net_device *netdev, void *p)
+{
+	struct wx *wx = netdev_priv(netdev);
+	struct sockaddr *addr = p;
+	int ret;
+
+	ret = eth_prepare_mac_addr_change(netdev, addr);
+	if (ret)
+		return ret;
+
+	spin_lock_bh(&wx->mbx.mbx_lock);
+	ret = wx_set_rar_vf(wx, 1, (u8 *)addr->sa_data, 1);
+	spin_unlock_bh(&wx->mbx.mbx_lock);
+
+	if (ret)
+		return -EPERM;
+
+	memcpy(wx->mac.addr, addr->sa_data, netdev->addr_len);
+	memcpy(wx->mac.perm_addr, addr->sa_data, netdev->addr_len);
+	eth_hw_addr_set(netdev, addr->sa_data);
+
+	return 0;
+}
+EXPORT_SYMBOL(wx_set_mac_vf);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
new file mode 100644
index 000000000000..9bee9de86cb2
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2015 - 2025 Beijing WangXun Technology Co., Ltd. */
+
+#ifndef _WX_VF_COMMON_H_
+#define _WX_VF_COMMON_H_
+
+int wx_request_msix_irqs_vf(struct wx *wx);
+void wx_negotiate_api_vf(struct wx *wx);
+void wx_reset_vf(struct wx *wx);
+void wx_set_rx_mode_vf(struct net_device *netdev);
+void wx_configure_vf(struct wx *wx);
+int wx_set_mac_vf(struct net_device *netdev, void *p);
+
+#endif /* _WX_VF_COMMON_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
new file mode 100644
index 000000000000..b234d18153b5
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.c
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2015 - 2025 Beijing WangXun Technology Co., Ltd. */
+
+#include <linux/etherdevice.h>
+#include <linux/pci.h>
+
+#include "wx_type.h"
+#include "wx_hw.h"
+#include "wx_lib.h"
+#include "wx_vf.h"
+#include "wx_vf_lib.h"
+
+static void wx_write_eitr_vf(struct wx_q_vector *q_vector)
+{
+	struct wx *wx = q_vector->wx;
+	int v_idx = q_vector->v_idx;
+	u32 itr_reg;
+
+	itr_reg = q_vector->itr & GENMASK(8, 0);
+
+	/* set the WDIS bit to not clear the timer bits and cause an
+	 * immediate assertion of the interrupt
+	 */
+	itr_reg |= WX_VXITR_CNT_WDIS;
+
+	wr32(wx, WX_VXITR(v_idx), itr_reg);
+}
+
+static void wx_set_ivar_vf(struct wx *wx, s8 direction, u8 queue,
+			   u8 msix_vector)
+{
+	u32 ivar, index;
+
+	if (direction == -1) {
+		/* other causes */
+		msix_vector |= WX_PX_IVAR_ALLOC_VAL;
+		ivar = rd32(wx, WX_VXIVAR_MISC);
+		ivar &= ~0xFF;
+		ivar |= msix_vector;
+		wr32(wx, WX_VXIVAR_MISC, ivar);
+	} else {
+		/* tx or rx causes */
+		msix_vector |= WX_PX_IVAR_ALLOC_VAL;
+		index = ((16 * (queue & 1)) + (8 * direction));
+		ivar = rd32(wx, WX_VXIVAR(queue >> 1));
+		ivar &= ~(0xFF << index);
+		ivar |= (msix_vector << index);
+		wr32(wx, WX_VXIVAR(queue >> 1), ivar);
+	}
+}
+
+void wx_configure_msix_vf(struct wx *wx)
+{
+	int v_idx;
+
+	wx->eims_enable_mask = 0;
+	for (v_idx = 0; v_idx < wx->num_q_vectors; v_idx++) {
+		struct wx_q_vector *q_vector = wx->q_vector[v_idx];
+		struct wx_ring *ring;
+
+		wx_for_each_ring(ring, q_vector->rx)
+			wx_set_ivar_vf(wx, 0, ring->reg_idx, v_idx);
+
+		wx_for_each_ring(ring, q_vector->tx)
+			wx_set_ivar_vf(wx, 1, ring->reg_idx, v_idx);
+
+		/* add q_vector eims value to global eims_enable_mask */
+		wx->eims_enable_mask |= BIT(v_idx);
+		wx_write_eitr_vf(q_vector);
+	}
+
+	wx_set_ivar_vf(wx, -1, 1, v_idx);
+
+	/* setup eims_other and add value to global eims_enable_mask */
+	wx->eims_other = BIT(v_idx);
+	wx->eims_enable_mask |= wx->eims_other;
+}
+
+int wx_write_uc_addr_list_vf(struct net_device *netdev)
+{
+	struct wx *wx = netdev_priv(netdev);
+	int count = 0;
+
+	if (!netdev_uc_empty(netdev)) {
+		struct netdev_hw_addr *ha;
+
+		netdev_for_each_uc_addr(ha, netdev)
+			wx_set_uc_addr_vf(wx, ++count, ha->addr);
+	} else {
+		/*
+		 * If the list is empty then send message to PF driver to
+		 * clear all macvlans on this VF.
+		 */
+		wx_set_uc_addr_vf(wx, 0, NULL);
+	}
+
+	return count;
+}
+
+/**
+ * wx_configure_tx_ring_vf - Configure Tx ring after Reset
+ * @wx: board private structure
+ * @ring: structure containing ring specific data
+ *
+ * Configure the Tx descriptor ring after a reset.
+ **/
+static void wx_configure_tx_ring_vf(struct wx *wx, struct wx_ring *ring)
+{
+	u8 reg_idx = ring->reg_idx;
+	u64 tdba = ring->dma;
+	u32 txdctl = 0;
+	int ret;
+
+	/* disable queue to avoid issues while updating state */
+	wr32(wx, WX_VXTXDCTL(reg_idx), WX_VXTXDCTL_FLUSH);
+	wr32(wx, WX_VXTDBAL(reg_idx), tdba & DMA_BIT_MASK(32));
+	wr32(wx, WX_VXTDBAH(reg_idx), tdba >> 32);
+
+	/* enable relaxed ordering */
+	pcie_capability_clear_and_set_word(wx->pdev, PCI_EXP_DEVCTL,
+					   0, PCI_EXP_DEVCTL_RELAX_EN);
+
+	/* reset head and tail pointers */
+	wr32(wx, WX_VXTDH(reg_idx), 0);
+	wr32(wx, WX_VXTDT(reg_idx), 0);
+	ring->tail = wx->hw_addr + WX_VXTDT(reg_idx);
+
+	/* reset ntu and ntc to place SW in sync with hardwdare */
+	ring->next_to_clean = 0;
+	ring->next_to_use = 0;
+
+	txdctl |= WX_VXTXDCTL_BUFLEN(wx_buf_len(ring->count));
+	txdctl |= WX_VXTXDCTL_ENABLE;
+
+	/* set WTHRESH to encourage burst writeback, it should not be set
+	 * higher than 1 when ITR is 0 as it could cause false TX hangs
+	 *
+	 * In order to avoid issues WTHRESH + PTHRESH should always be equal
+	 * to or less than the number of on chip descriptors, which is
+	 * currently 40.
+	 */
+	/* reinitialize tx_buffer_info */
+	memset(ring->tx_buffer_info, 0,
+	       sizeof(struct wx_tx_buffer) * ring->count);
+
+	wr32(wx, WX_VXTXDCTL(reg_idx), txdctl);
+	/* poll to verify queue is enabled */
+	ret = read_poll_timeout(rd32, txdctl, txdctl & WX_VXTXDCTL_ENABLE,
+				1000, 10000, true, wx, WX_VXTXDCTL(reg_idx));
+	if (ret == -ETIMEDOUT)
+		wx_err(wx, "Could not enable Tx Queue %d\n", reg_idx);
+}
+
+/**
+ * wx_configure_tx_vf - Configure Transmit Unit after Reset
+ * @wx: board private structure
+ *
+ * Configure the Tx unit of the MAC after a reset.
+ **/
+void wx_configure_tx_vf(struct wx *wx)
+{
+	u32 i;
+
+	/* Setup the HW Tx Head and Tail descriptor pointers */
+	for (i = 0; i < wx->num_tx_queues; i++)
+		wx_configure_tx_ring_vf(wx, wx->tx_ring[i]);
+}
+
+static void wx_configure_srrctl_vf(struct wx *wx, struct wx_ring *ring,
+				   int index)
+{
+	u32 srrctl;
+
+	srrctl = rd32m(wx, WX_VXRXDCTL(index),
+		       (u32)~(WX_VXRXDCTL_HDRSZ_MASK | WX_VXRXDCTL_BUFSZ_MASK));
+	srrctl |= WX_VXRXDCTL_DROP;
+	srrctl |= WX_VXRXDCTL_HDRSZ(wx_hdr_sz(WX_RX_HDR_SIZE));
+	srrctl |= WX_VXRXDCTL_BUFSZ(wx_buf_sz(WX_RX_BUF_SIZE));
+
+	wr32(wx, WX_VXRXDCTL(index), srrctl);
+}
+
+void wx_setup_psrtype_vf(struct wx *wx)
+{
+	/* PSRTYPE must be initialized */
+	u32 psrtype = WX_VXMRQC_PSR_L2HDR |
+		      WX_VXMRQC_PSR_L3HDR |
+		      WX_VXMRQC_PSR_L4HDR |
+		      WX_VXMRQC_PSR_TUNHDR |
+		      WX_VXMRQC_PSR_TUNMAC;
+
+	if (wx->num_rx_queues > 1)
+		psrtype |= BIT(14);
+
+	wr32m(wx, WX_VXMRQC, WX_VXMRQC_PSR_MASK, WX_VXMRQC_PSR(psrtype));
+}
+
+void wx_setup_vfmrqc_vf(struct wx *wx)
+{
+	u16 rss_i = wx->num_rx_queues;
+	u32 vfmrqc = 0, vfreta = 0;
+	u8 i, j;
+
+	/* Fill out hash function seeds */
+	netdev_rss_key_fill(wx->rss_key, sizeof(wx->rss_key));
+	for (i = 0; i < 10; i++)
+		wr32(wx, WX_VXRSSRK(i), wx->rss_key[i]);
+
+	for (i = 0, j = 0; i < 128; i++, j++) {
+		if (j == rss_i)
+			j = 0;
+
+		wx->rss_indir_tbl[i] = j;
+
+		vfreta |= j << (i & 0x3) * 8;
+		if ((i & 3) == 3) {
+			wr32(wx, WX_VXRETA(i >> 2), vfreta);
+			vfreta = 0;
+		}
+	}
+
+	/* Perform hash on these packet types */
+	vfmrqc |= WX_VXMRQC_RSS_ALG_IPV4 |
+		  WX_VXMRQC_RSS_ALG_IPV4_TCP |
+		  WX_VXMRQC_RSS_ALG_IPV6 |
+		  WX_VXMRQC_RSS_ALG_IPV6_TCP;
+
+	vfmrqc |= WX_VXMRQC_RSS_EN;
+
+	if (wx->num_rx_queues > 3)
+		vfmrqc |= WX_VXMRQC_RSS_HASH(2);
+	else if (wx->num_rx_queues > 1)
+		vfmrqc |= WX_VXMRQC_RSS_HASH(1);
+	wr32m(wx, WX_VXMRQC, WX_VXMRQC_RSS_MASK, WX_VXMRQC_RSS(vfmrqc));
+}
+
+void wx_configure_rx_ring_vf(struct wx *wx, struct wx_ring *ring)
+{
+	u8 reg_idx = ring->reg_idx;
+	union wx_rx_desc *rx_desc;
+	u64 rdba = ring->dma;
+	u32 rxdctl;
+
+	/* disable queue to avoid issues while updating state */
+	rxdctl = rd32(wx, WX_VXRXDCTL(reg_idx));
+	wx_disable_rx_queue(wx, ring);
+
+	wr32(wx, WX_VXRDBAL(reg_idx), rdba & DMA_BIT_MASK(32));
+	wr32(wx, WX_VXRDBAH(reg_idx), rdba >> 32);
+
+	/* enable relaxed ordering */
+	pcie_capability_clear_and_set_word(wx->pdev, PCI_EXP_DEVCTL,
+					   0, PCI_EXP_DEVCTL_RELAX_EN);
+
+	/* reset head and tail pointers */
+	wr32(wx, WX_VXRDH(reg_idx), 0);
+	wr32(wx, WX_VXRDT(reg_idx), 0);
+	ring->tail = wx->hw_addr + WX_VXRDT(reg_idx);
+
+	/* initialize rx_buffer_info */
+	memset(ring->rx_buffer_info, 0,
+	       sizeof(struct wx_rx_buffer) * ring->count);
+
+	/* initialize Rx descriptor 0 */
+	rx_desc = WX_RX_DESC(ring, 0);
+	rx_desc->wb.upper.length = 0;
+
+	/* reset ntu and ntc to place SW in sync with hardwdare */
+	ring->next_to_clean = 0;
+	ring->next_to_use = 0;
+	ring->next_to_alloc = 0;
+
+	wx_configure_srrctl_vf(wx, ring, reg_idx);
+
+	/* allow any size packet since we can handle overflow */
+	rxdctl &= ~WX_VXRXDCTL_BUFLEN_MASK;
+	rxdctl |= WX_VXRXDCTL_BUFLEN(wx_buf_len(ring->count));
+	rxdctl |= WX_VXRXDCTL_ENABLE | WX_VXRXDCTL_VLAN;
+
+	/* enable RSC */
+	rxdctl &= ~WX_VXRXDCTL_RSCMAX_MASK;
+	rxdctl |= WX_VXRXDCTL_RSCMAX(0);
+	rxdctl |= WX_VXRXDCTL_RSCEN;
+
+	wr32(wx, WX_VXRXDCTL(reg_idx), rxdctl);
+
+	/* pf/vf reuse */
+	wx_enable_rx_queue(wx, ring);
+	wx_alloc_rx_buffers(ring, wx_desc_unused(ring));
+}
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.h b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.h
new file mode 100644
index 000000000000..43ea126b79eb
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_lib.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2015 - 2025 Beijing WangXun Technology Co., Ltd. */
+
+#ifndef _WX_VF_LIB_H_
+#define _WX_VF_LIB_H_
+
+void wx_configure_msix_vf(struct wx *wx);
+int wx_write_uc_addr_list_vf(struct net_device *netdev);
+void wx_setup_psrtype_vf(struct wx *wx);
+void wx_setup_vfmrqc_vf(struct wx *wx);
+void wx_configure_tx_vf(struct wx *wx);
+void wx_configure_rx_ring_vf(struct wx *wx, struct wx_ring *ring);
+
+#endif /* _WX_VF_LIB_H_ */
-- 
2.30.1


