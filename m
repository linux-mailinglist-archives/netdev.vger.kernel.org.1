Return-Path: <netdev+bounces-174760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C636AA603A3
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 22:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07ADA17C550
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 21:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5331F542E;
	Thu, 13 Mar 2025 21:47:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ED71F561C
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 21:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741902471; cv=none; b=gC+Hyqd1VcqDQ2PgiRFt09X5a9tZ9wtWIPF0pyEwaZ5PmtcGszjyNzqCwxD1Z2agNnS8vBXSEQO3XGqvjwCzDgEcKDCspT/9zjtqwgMST4nC3VGXjK0nm3pxV3+2kSRZpG48tPwonCcijrANxTRE95/vIvhysl0kgghJ4RQONfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741902471; c=relaxed/simple;
	bh=jWKUexl4uBkgonCVGDz+/jbFW7W0Ki5DmrHrmss0J2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KMlBm/ANEk2OCXkUbpv2L++L87DVFxH3lhfu3OTWWyw0xtu4FxF1apnC4joEJHaXNf1Ir9DJUrFEQK8lNlmA1+zpsEB5Kp4M/vagnx41eHOmZYmrwoF684gmuQhU23sPIh5cH4eTIOVjTXni5g4xEOJggMiHKMLBHDspzuXyFM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtpip2t1741902438tgo2mk0
X-QQ-Originating-IP: mfsEiBoxe1eSBwYWC+96Ahhuf41/iTVPDin5QB3J7cI=
Received: from 192.168.1.21 ( [192.168.1.21])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 14 Mar 2025 05:47:16 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1146440627090573896
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [RESEND,PATCH net-next v8 2/6] net: libwx: Add sriov api for wangxun nics
Date: Fri, 14 Mar 2025 05:46:55 +0800
Message-Id: <20250313214659.2785-3-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20250313214659.2785-1-mengyuanlou@net-swift.com>
References: <20250313214659.2785-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NchHDkd43sBtqRrxIsb/Ailc9p8cahHOTMxJWwDLBKD9x9VCsgVnX31T
	VpqrlkDj9Q9rRNMngZ6GiX49Kw07f0ZxYHm8YT1Yx7k/zmWOfijYTIXWNxz/UjqX8Oi6xHI
	F9fRInlWcCumVGAX+GO56lAnRypCBmycsljpyYeOPaZ3cV1lIUKCT8ML2EqY/+ArIMkhV/X
	+BVyueARAUs9xxn74ZHgySAYvgUEul2GpmpKMaVA5rmXqKDnOZVumR8R093PpOkxlK2GItm
	YzX3s26MJnnvElGukUObl2qr1SB/YpD0reb9U3RpfFWXB9qhhoMGFM5ozxyVmUd8iqpt2xT
	gdE3L+oa+iwqdLTC/nx2q0JXd/wsHFpco9UyHGAIRcz3W6vEa18f4rWpt/SWYOfykRhX1oG
	V/IQly4Ljryf5QWptExYRJFm9a5ZONuQ+253PjO0CT0yhQjEWK8vV5i8xcky4hRnNbYzTiP
	D2z36u7TnR6Yo+eSHrPV8pN+hBTwK70YpiYZXAglCVjXke4RG72Sx78s4/7XbMI+92kctTT
	SmZD+XM6/XGPQqh7a4/zVOoSo3uxSLAFBT8S4Jd59Uu+d87cMrq8OxOWtVPGjHojpInz8Dw
	0Jy0M+VudyKOqbNrYc/S3ldIcgmLXUUd/GStNU9eUpcKZulQPjmy5D5fo8iRctTjNZZ71bO
	1iRDFtFT9UcbdxvjiWcCesGjOr5zsXkBfPMeR8fWdp6KUcqqA0uny3ay2NqFdmJy+xLUAtW
	M5cVm7IDvK96T+hUHEwOdFD0/Mgtnjn8kc54jO9xf4IK1TRuph32aJecUaAEsEoUpWBp/dL
	XbDtu7uvKRvVrjLaPm48zlY5WgHOUDQ/qZNLfqC88qocvQDxLbd6B4QrmsSce5gWd97jOmp
	R1Ncmx+VhGf374Ro9z1gwGBFkaMUl099F0NT/b6VWIBiLdfW86Z3iU9CPb8LCArSbLEFsEn
	+G395c4zklZ3vLPjOalS50acQWvKWF1c9Hz1H0fg6uxxyLP6RiuFDKLPIpLv3V1CG4N0CHW
	QVvym2fLpCBxtYzltEp391yZFmuulROVBtBltKxDsPvnYygWww
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Implement sriov_configure interface for wangxun nics in libwx.
Enable VT mode and initialize vf control structure, when sriov
is enabled. Do not be allowed to disable sriov when vfs are
assigned.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/Makefile   |   2 +-
 drivers/net/ethernet/wangxun/libwx/wx_mbx.h   |   4 +
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 201 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.h |  10 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  31 +++
 5 files changed, 247 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_sriov.c
 create mode 100644 drivers/net/ethernet/wangxun/libwx/wx_sriov.h

diff --git a/drivers/net/ethernet/wangxun/libwx/Makefile b/drivers/net/ethernet/wangxun/libwx/Makefile
index cd1675ef3253..9b78b604a94e 100644
--- a/drivers/net/ethernet/wangxun/libwx/Makefile
+++ b/drivers/net/ethernet/wangxun/libwx/Makefile
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_LIBWX) += libwx.o
 
-libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_ptp.o wx_mbx.o
+libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_ptp.o wx_mbx.o wx_sriov.o
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_mbx.h b/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
index c09b25f3e43d..172b46b9c14d 100644
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
index 000000000000..2392df341ad1
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2015 - 2025 Beijing WangXun Technology Co., Ltd. */
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
+static int wx_alloc_vf_macvlans(struct wx *wx, u8 num_vfs)
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
+		return -EINVAL;
+
+	mv_list = kcalloc(num_vf_macvlans, sizeof(struct vf_macvlans),
+			  GFP_KERNEL);
+	if (!mv_list)
+		return -ENOMEM;
+
+	for (i = 0; i < num_vf_macvlans; i++) {
+		mv_list[i].vf = -1;
+		mv_list[i].free = true;
+		list_add(&mv_list[i].mvlist, &wx->vf_mvs.mvlist);
+	}
+	wx->mv_list = mv_list;
+
+	return 0;
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
+	int i, ret = 0;
+	u32 value = 0;
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
+	ret = wx_alloc_vf_macvlans(wx, num_vfs);
+	if (ret)
+		return ret;
+
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
+	return ret;
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
+int wx_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
+{
+	struct wx *wx = pci_get_drvdata(pdev);
+	int err;
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
index 000000000000..a16877f89389
--- /dev/null
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2015 - 2025 Beijing WangXun Technology Co., Ltd. */
+
+#ifndef _WX_SRIOV_H_
+#define _WX_SRIOV_H_
+
+void wx_disable_sriov(struct wx *wx);
+int wx_pci_sriov_configure(struct pci_dev *pdev, int num_vfs);
+
+#endif /* _WX_SRIOV_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 18287b0ee040..26776dee6490 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -20,6 +20,7 @@
 /* MSI-X capability fields masks */
 #define WX_PCIE_MSIX_TBL_SZ_MASK                0x7FF
 #define WX_PCI_LINK_STATUS                      0xB2
+#define WX_MAX_PF_MACVLANS                      15
 
 /**************** Global Registers ****************************/
 #define WX_VF_REG_OFFSET(_v)         FIELD_GET(GENMASK(15, 5), (_v))
@@ -93,6 +94,9 @@
 #define WX_CFG_TAG_TPID(_i)          (0x14430 + ((_i) * 4))
 #define WX_CFG_PORT_CTL_NUM_VT_MASK  GENMASK(13, 12) /* number of TVs */
 
+#define WX_CFG_PORT_CTL_NUM_VT_8     FIELD_PREP(GENMASK(13, 12), 1)
+#define WX_CFG_PORT_CTL_NUM_VT_32    FIELD_PREP(GENMASK(13, 12), 2)
+#define WX_CFG_PORT_CTL_NUM_VT_64    FIELD_PREP(GENMASK(13, 12), 3)
 
 /* GPIO Registers */
 #define WX_GPIO_DR                   0x14800
@@ -168,6 +172,7 @@
 /******************************* PSR Registers *******************************/
 /* psr control */
 #define WX_PSR_CTL                   0x15000
+#define WX_PSR_VM_CTL                0x151B0
 /* Header split receive */
 #define WX_PSR_CTL_SW_EN             BIT(18)
 #define WX_PSR_CTL_RSC_ACK           BIT(17)
@@ -205,6 +210,7 @@
 /* mcasst/ucast overflow tbl */
 #define WX_PSR_MC_TBL(_i)            (0x15200  + ((_i) * 4))
 #define WX_PSR_UC_TBL(_i)            (0x15400 + ((_i) * 4))
+#define WX_PSR_VM_CTL_POOL_MASK      GENMASK(12, 7)
 
 /* VM L2 contorl */
 #define WX_PSR_VM_L2CTL(_i)          (0x15600 + ((_i) * 4))
@@ -1059,6 +1065,7 @@ struct wx_ring_feature {
 
 enum wx_ring_f_enum {
 	RING_F_NONE = 0,
+	RING_F_VMDQ,
 	RING_F_RSS,
 	RING_F_FDIR,
 	RING_F_ARRAY_SIZE  /* must be last in enum set */
@@ -1114,8 +1121,27 @@ enum wx_state {
 	WX_STATE_NBITS		/* must be last */
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
 	WX_FLAG_SWFW_RING,
+	WX_FLAG_VMDQ_ENABLED,
+	WX_FLAG_SRIOV_ENABLED,
 	WX_FLAG_FDIR_CAPABLE,
 	WX_FLAG_FDIR_HASH,
 	WX_FLAG_FDIR_PERFECT,
@@ -1220,10 +1246,15 @@ struct wx {
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
 	int (*ptp_setup_sdp)(struct wx *wx);
 
-- 
2.30.1 (Apple Git-130)


