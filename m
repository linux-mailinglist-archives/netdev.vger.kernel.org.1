Return-Path: <netdev+bounces-113172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC1693D0CC
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 12:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9C5E1C2188D
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 10:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AFA178379;
	Fri, 26 Jul 2024 10:03:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.77.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E617F173332
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 10:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.77.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721988221; cv=none; b=DcShOmBw5GUBW6KzrOmHusCMEvjvJXA9FvhO7MjDJ645aE8QOlQVuAqtj9jJ1VknZfgyYw89DI8FgxUBk32qdEY636TO7HO8FcmXZXZ1v5y71SVT+qMMf+weVPTm7UiMHIXEZa+u1qE+WWAFpRpllPyyiSATyzX0bI2wJKF76+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721988221; c=relaxed/simple;
	bh=EqgwY+V6Jh/SfKS1iygzNr7b8Oh8X6n1B8iTdUmX/ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bRvXpZTKVi7ElGxaLWAfVsoZmhbPCoRApUCL0m07pyzwZ/AFGDHx7HA3Try10W3wzGMWmTSSvaNNf75dDknWj7KH7at+OaS8c+pcIPXlF019fFNuosDH6akGtS5VnufG2rxfY1KYuZsKsbR/m8JbDHi7l1pmWVAktAfFpnh31vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=114.132.77.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp81t1721988203tvmmrcd6
X-QQ-Originating-IP: hIXZJ/3sx5RjUFIeKeGOWYqCEXCPwz3ranJnhM2neqc=
Received: from localhost.localdomain ( [122.231.252.211])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 26 Jul 2024 18:03:22 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 14795770019563736396
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [RFC PATCH net-next v5 02/10] net: libwx: Add sriov api for wangxun nics
Date: Fri, 26 Jul 2024 18:02:53 +0800
Message-ID: <4437D4BD16BDFAEF+20240726100301.21416-3-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240726100301.21416-1-mengyuanlou@net-swift.com>
References: <20240726100301.21416-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0

Implement sriov_configure interface for wangxun nics in libwx.
Enable VT mode and initialize vf control structure, when sriov
is enabled. Do not be allowed to disable sriov when vfs are
assigned.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_mbx.h   |   4 +
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 210 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.h |  10 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  31 +++
 5 files changed, 256 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_sriov.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_sriov.h

diff --git a/drivers/net/ethernet/wangxun/libwx/Makefile b/drivers/net/ethernet/wangxun/libwx/Makefile
index 913a978c9032..5b996d973d29 100644
--- a/drivers/net/ethernet/wangxun/libwx/Makefile
+++ b/drivers/net/ethernet/wangxun/libwx/Makefile
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_LIBWX) += libwx.o
 
-libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_mbx.o
+libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_mbx.o wx_sriov.o
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_mbx.h b/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
index 1579096fb6ad..3c70654a8b14 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
@@ -23,6 +23,10 @@
 
 #define WX_VT_MSGINFO_MASK    GENMASK(23, 16)
 
+enum wxvf_xcast_modes {
+	WXVF_XCAST_MODE_NONE = 0,
+};
+
 int wx_write_mbx_pf(struct wx *wx, u32 *msg, u16 size, u16 vf);
 int wx_read_mbx_pf(struct wx *wx, u32 *msg, u16 size, u16 vf);
 int wx_check_for_rst_pf(struct wx *wx, u16 mbx_id);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
new file mode 100644
index 000000000000..6b0a150abd76
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2015 - 2023 Beijing WangXun Technology Co., Ltd. */
+
+#include <linux/etherdevice.h>
+#include <linux/pci.h>
+
+#include "wx_type.h"
+#include "wx_mbx.h"
+#include "wx_sriov.h"
+
+static void wx_vf_configuration(struct pci_dev *pdev, int event_mask)
+{
+	unsigned int vfn = (event_mask & GENMASK(5, 0));
+	struct wx *wx = pci_get_drvdata(pdev);
+
+	bool enable = ((event_mask & BIT(31)) != 0);
+
+	if (enable)
+		eth_zero_addr(wx->vfinfo[vfn].vf_mac_addr);
+}
+
+static void wx_alloc_vf_macvlans(struct wx *wx, u8 num_vfs)
+{
+	struct vf_macvlans *mv_list;
+	int num_vf_macvlans, i;
+
+	/* Initialize list of VF macvlans */
+	INIT_LIST_HEAD(&wx->vf_mvs.mvlist);
+
+	num_vf_macvlans = wx->mac.num_rar_entries -
+			  (WX_MAX_PF_MACVLANS + 1 + num_vfs);
+	if (!num_vf_macvlans)
+		return;
+
+	mv_list = kcalloc(num_vf_macvlans, sizeof(struct vf_macvlans),
+			  GFP_KERNEL);
+	if (mv_list) {
+		for (i = 0; i < num_vf_macvlans; i++) {
+			mv_list[i].vf = -1;
+			mv_list[i].free = true;
+			list_add(&mv_list[i].mvlist, &wx->vf_mvs.mvlist);
+		}
+		wx->mv_list = mv_list;
+	}
+}
+
+static void wx_sriov_clear_data(struct wx *wx)
+{
+	/* set num VFs to 0 to prevent access to vfinfo */
+	wx->num_vfs = 0;
+
+	/* free VF control structures */
+	kfree(wx->vfinfo);
+	wx->vfinfo = NULL;
+
+	/* free macvlan list */
+	kfree(wx->mv_list);
+	wx->mv_list = NULL;
+
+	/* set default pool back to 0 */
+	wr32m(wx, WX_PSR_VM_CTL, WX_PSR_VM_CTL_POOL_MASK, 0);
+	wx->ring_feature[RING_F_VMDQ].offset = 0;
+
+	clear_bit(WX_FLAG_SRIOV_ENABLED, wx->flags);
+	/* Disable VMDq flag so device will be set in NM mode */
+	if (wx->ring_feature[RING_F_VMDQ].limit == 1)
+		clear_bit(WX_FLAG_VMDQ_ENABLED, wx->flags);
+}
+
+static int __wx_enable_sriov(struct wx *wx, u8 num_vfs)
+{
+	u32 value = 0;
+	int i;
+
+	set_bit(WX_FLAG_SRIOV_ENABLED, wx->flags);
+	wx_err(wx, "SR-IOV enabled with %d VFs\n", num_vfs);
+
+	/* Enable VMDq flag so device will be set in VM mode */
+	set_bit(WX_FLAG_VMDQ_ENABLED, wx->flags);
+	if (!wx->ring_feature[RING_F_VMDQ].limit)
+		wx->ring_feature[RING_F_VMDQ].limit = 1;
+	wx->ring_feature[RING_F_VMDQ].offset = num_vfs;
+
+	wx->vfinfo = kcalloc(num_vfs, sizeof(struct vf_data_storage),
+			     GFP_KERNEL);
+	if (!wx->vfinfo)
+		return -ENOMEM;
+
+	wx_alloc_vf_macvlans(wx, num_vfs);
+	/* Initialize default switching mode VEB */
+	wr32m(wx, WX_PSR_CTL, WX_PSR_CTL_SW_EN, WX_PSR_CTL_SW_EN);
+
+	for (i = 0; i < num_vfs; i++) {
+		/* enable spoof checking for all VFs */
+		wx->vfinfo[i].spoofchk_enabled = true;
+		wx->vfinfo[i].link_enable = true;
+		/* untrust all VFs */
+		wx->vfinfo[i].trusted = false;
+		/* set the default xcast mode */
+		wx->vfinfo[i].xcast_mode = WXVF_XCAST_MODE_NONE;
+	}
+
+	if (wx->mac.type == wx_mac_sp) {
+		if (num_vfs < 32)
+			value = WX_CFG_PORT_CTL_NUM_VT_32;
+		else
+			value = WX_CFG_PORT_CTL_NUM_VT_64;
+	} else {
+		value = WX_CFG_PORT_CTL_NUM_VT_8;
+	}
+	wr32m(wx, WX_CFG_PORT_CTL,
+	      WX_CFG_PORT_CTL_NUM_VT_MASK,
+	      value);
+
+	return 0;
+}
+
+static void wx_sriov_reinit(struct wx *wx)
+{
+	rtnl_lock();
+	wx->setup_tc(wx->netdev, netdev_get_num_tc(wx->netdev));
+	rtnl_unlock();
+}
+
+void wx_disable_sriov(struct wx *wx)
+{
+	if (!pci_vfs_assigned(wx->pdev))
+		pci_disable_sriov(wx->pdev);
+	else
+		wx_err(wx, "Unloading driver while VFs are assigned.\n");
+
+	/* clear flags and free allloced data */
+	wx_sriov_clear_data(wx);
+}
+EXPORT_SYMBOL(wx_disable_sriov);
+
+static int wx_pci_sriov_enable(struct pci_dev *dev,
+			       int num_vfs)
+{
+	struct wx *wx = pci_get_drvdata(dev);
+	int err = 0, i;
+
+	err = __wx_enable_sriov(wx, num_vfs);
+	if (err)
+		return err;
+
+	wx->num_vfs = num_vfs;
+	for (i = 0; i < wx->num_vfs; i++)
+		wx_vf_configuration(dev, (i | BIT(31)));
+
+	/* reset before enabling SRIOV to avoid mailbox issues */
+	wx_sriov_reinit(wx);
+
+	err = pci_enable_sriov(dev, num_vfs);
+	if (err) {
+		wx_err(wx, "Failed to enable PCI sriov: %d\n", err);
+		goto err_out;
+	}
+
+	return num_vfs;
+err_out:
+	wx_sriov_clear_data(wx);
+	return err;
+}
+
+static void wx_pci_sriov_disable(struct pci_dev *dev)
+{
+	struct wx *wx = pci_get_drvdata(dev);
+
+	wx_disable_sriov(wx);
+	wx_sriov_reinit(wx);
+}
+
+static int wx_check_sriov_allowed(struct wx *wx, int num_vfs)
+{
+	u16 max_vfs;
+
+	max_vfs = (wx->mac.type == wx_mac_sp) ? 63 : 7;
+	if (num_vfs > max_vfs)
+		return -EPERM;
+
+	return 0;
+}
+
+int wx_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
+{
+	struct wx *wx = pci_get_drvdata(pdev);
+	int err;
+
+	err = wx_check_sriov_allowed(wx, num_vfs);
+	if (err)
+		return err;
+
+	if (!num_vfs) {
+		if (!pci_vfs_assigned(pdev)) {
+			wx_pci_sriov_disable(pdev);
+			return 0;
+		}
+
+		wx_err(wx, "can't free VFs because some are assigned to VMs.\n");
+		return -EBUSY;
+	}
+
+	err = wx_pci_sriov_enable(pdev, num_vfs);
+	if (err)
+		return err;
+
+	return num_vfs;
+}
+EXPORT_SYMBOL(wx_pci_sriov_configure);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.h b/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
new file mode 100644
index 000000000000..1ac03e9c0d55
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2015 - 2024 Beijing WangXun Technology Co., Ltd. */
+
+#ifndef _WX_SRIOV_H_
+#define _WX_SRIOV_H_
+
+void wx_disable_sriov(struct wx *wx);
+int wx_pci_sriov_configure(struct pci_dev *pdev, int num_vfs);
+
+#endif /* _WX_SRIOV_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 5b9d5fd7033d..c4f73c5a366f 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -18,6 +18,7 @@
 /* MSI-X capability fields masks */
 #define WX_PCIE_MSIX_TBL_SZ_MASK                0x7FF
 #define WX_PCI_LINK_STATUS                      0xB2
+#define WX_MAX_PF_MACVLANS                      15
 
 /**************** Global Registers ****************************/
 #define WX_VF_REG_OFFSET(_v)         ((_v) >> 5)
@@ -91,6 +92,9 @@
 #define WX_CFG_TAG_TPID(_i)          (0x14430 + ((_i) * 4))
 #define WX_CFG_PORT_CTL_NUM_VT_MASK  GENMASK(13, 12) /* number of TVs */
 
+#define WX_CFG_PORT_CTL_NUM_VT_8     FIELD_PREP(GENMASK(13, 12), 1)
+#define WX_CFG_PORT_CTL_NUM_VT_32    FIELD_PREP(GENMASK(13, 12), 2)
+#define WX_CFG_PORT_CTL_NUM_VT_64    FIELD_PREP(GENMASK(13, 12), 3)
 
 /* GPIO Registers */
 #define WX_GPIO_DR                   0x14800
@@ -166,6 +170,7 @@
 /******************************* PSR Registers *******************************/
 /* psr control */
 #define WX_PSR_CTL                   0x15000
+#define WX_PSR_VM_CTL                0x151B0
 /* Header split receive */
 #define WX_PSR_CTL_SW_EN             BIT(18)
 #define WX_PSR_CTL_RSC_ACK           BIT(17)
@@ -186,6 +191,7 @@
 /* mcasst/ucast overflow tbl */
 #define WX_PSR_MC_TBL(_i)            (0x15200  + ((_i) * 4))
 #define WX_PSR_UC_TBL(_i)            (0x15400 + ((_i) * 4))
+#define WX_PSR_VM_CTL_POOL_MASK      GENMASK(12, 7)
 
 /* VM L2 contorl */
 #define WX_PSR_VM_L2CTL(_i)          (0x15600 + ((_i) * 4))
@@ -984,6 +990,7 @@ struct wx_ring_feature {
 
 enum wx_ring_f_enum {
 	RING_F_NONE = 0,
+	RING_F_VMDQ,
 	RING_F_RSS,
 	RING_F_FDIR,
 	RING_F_ARRAY_SIZE  /* must be last in enum set */
@@ -1036,7 +1043,26 @@ enum wx_state {
 	WX_STATE_NBITS,		/* must be last */
 };
 
+struct vf_data_storage {
+	struct pci_dev *vfdev;
+	unsigned char vf_mac_addr[ETH_ALEN];
+	bool spoofchk_enabled;
+	bool link_enable;
+	bool trusted;
+	int xcast_mode;
+};
+
+struct vf_macvlans {
+	struct list_head mvlist;
+	int vf;
+	bool free;
+	bool is_macvlan;
+	u8 vf_macvlan[ETH_ALEN];
+};
+
 enum wx_pf_flags {
+	WX_FLAG_VMDQ_ENABLED,
+	WX_FLAG_SRIOV_ENABLED,
 	WX_FLAG_FDIR_CAPABLE,
 	WX_FLAG_FDIR_HASH,
 	WX_FLAG_FDIR_PERFECT,
@@ -1136,10 +1162,15 @@ struct wx {
 	u64 hw_csum_rx_good;
 	u64 hw_csum_rx_error;
 	u64 alloc_rx_buff_failed;
+	unsigned int num_vfs;
+	struct vf_data_storage *vfinfo;
+	struct vf_macvlans vf_mvs;
+	struct vf_macvlans *mv_list;
 
 	u32 atr_sample_rate;
 	void (*atr)(struct wx_ring *ring, struct wx_tx_buffer *first, u8 ptype);
 	void (*configure_fdir)(struct wx *wx);
+	int (*setup_tc)(struct net_device *netdev, u8 tc);
 	void (*do_reset)(struct net_device *netdev);
 };
 
-- 
2.43.2


