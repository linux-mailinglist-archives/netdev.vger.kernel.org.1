Return-Path: <netdev+bounces-87873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAA68A4D40
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 621371F267D8
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 11:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE115FB98;
	Mon, 15 Apr 2024 11:03:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE6A5DF0E
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 11:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713179037; cv=none; b=uwxqYg33Yoi6ryqEzfr4hQA8RZ94fCdGJP6o+gxi7Mos0/PMYQz7jgqcxBxLhGuNWqO4odQgCgbGQp2muXIq5SA444kr3INEGLa0KpQo1RkXH9M8uTFPTAtZNpe4/mQ7+HGJw6yopCMdYOJB01BYYIvLIIlkat5X93wdgXlmT5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713179037; c=relaxed/simple;
	bh=JnhiYhwTk60S+Qmxtb5F+kcbnaHI9un4pkB8tJL+joY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFfDVRbw0K+rcXX7PQOszw5cvK8B5qPrupr+nyQkDIO3JL/dugm3QjyXFuLfUiUhZH8LXNf4F3ueT5e5I187izEVs+tLHkUgaG2T5OYlPlP1LYPSpNiQU3KB+u7gyr4mEnjpQYrfFGddWJAF16HytUZ7VRUsUL6oMWmTDx36dxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp85t1713179019t1m49mm6
X-QQ-Originating-IP: WcO9JFlUK+knr94LYArJ39YCdaPbzx5JdPtgM/bssC8=
Received: from localhost.localdomain ( [125.119.246.177])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 15 Apr 2024 19:03:36 +0800 (CST)
X-QQ-SSF: 01400000000000O0Z000000A0000000
X-QQ-FEAT: zK0nlCs2Z6EF3SzFYcT9fnWbQPJ4aSFOR7OT/DaLTo5W/JxJTp2BLAIrt3xpv
	7oiNtRGJMJbMNHLtrj8yEGxfW7SqeCKjE/6A+ok9SlUBtBHDybmGEfnEanzWn0SSNtVgDvG
	EiOsvkUr9Tn7WGjunJTpeWiFUyLCUDZ3AVDAXfb4hvi/fLyBMHhzgMVAZLZmngJlVpwyCde
	VyG52z2N0o8ySX29Ux9yfbd2A9qi4vkvFuOACsXYGM8IDJqOpgGynqj2MbVVpXBx0HZnoSy
	VgF0t4rcx3hlLVTosvGpcvUWzoLMfqJqD4rg7YgGuQqQsbowh7UuZE+K3VsoaFR2zDBxXsR
	VTl9xRfd07Xn5BSM47WjsPuEcOkMmuCRQa1IIj2Ddhm5Uc5ush5eDoSfaqQwMHFkaH7j9V3
	bbCaN4Q+FjbC3/RvdhFLcQ==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 12588226617157206127
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v3 4/6] net: libwx: Add msg task func
Date: Mon, 15 Apr 2024 18:54:31 +0800
Message-ID: <15B2EB86E550526B+20240415110225.75132-5-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240415110225.75132-1-mengyuanlou@net-swift.com>
References: <20240415110225.75132-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrgz:qybglogicsvrgz6a-1

Implement wx_msg_task which is used to process mailbox
messages sent by vf.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |  12 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   4 +
 drivers/net/ethernet/wangxun/libwx/wx_mbx.h   |  50 ++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 748 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.h |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  17 +
 6 files changed, 828 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index f3b5705e8eaf..e18908bd68a2 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -851,7 +851,7 @@ void wx_flush_sw_mac_table(struct wx *wx)
 }
 EXPORT_SYMBOL(wx_flush_sw_mac_table);
 
-static int wx_add_mac_filter(struct wx *wx, u8 *addr, u16 pool)
+int wx_add_mac_filter(struct wx *wx, u8 *addr, u16 pool)
 {
 	u32 i;
 
@@ -881,8 +881,9 @@ static int wx_add_mac_filter(struct wx *wx, u8 *addr, u16 pool)
 	}
 	return -ENOMEM;
 }
+EXPORT_SYMBOL(wx_add_mac_filter);
 
-static int wx_del_mac_filter(struct wx *wx, u8 *addr, u16 pool)
+int wx_del_mac_filter(struct wx *wx, u8 *addr, u16 pool)
 {
 	u32 i;
 
@@ -905,6 +906,7 @@ static int wx_del_mac_filter(struct wx *wx, u8 *addr, u16 pool)
 	}
 	return -ENOMEM;
 }
+EXPORT_SYMBOL(wx_del_mac_filter);
 
 static int wx_available_rars(struct wx *wx)
 {
@@ -1309,7 +1311,7 @@ static void wx_set_ethertype_anti_spoofing(struct wx *wx, bool enable, int vf)
 	wr32(wx, WX_TDM_ETYPE_AS(reg_offset), pfvfspoof);
 }
 
-static int wx_set_vf_spoofchk(struct net_device *netdev, int vf, bool setting)
+int wx_set_vf_spoofchk(struct net_device *netdev, int vf, bool setting)
 {
 	u32 index = vf / 32, vf_bit = vf % 32;
 	struct wx *wx = netdev_priv(netdev);
@@ -1328,6 +1330,7 @@ static int wx_set_vf_spoofchk(struct net_device *netdev, int vf, bool setting)
 
 	return 0;
 }
+EXPORT_SYMBOL(wx_set_vf_spoofchk);
 
 static void wx_configure_virtualization(struct wx *wx)
 {
@@ -2352,7 +2355,7 @@ static int wx_set_vlvf(struct wx *wx, u32 vlan, u32 vind, bool vlan_on,
  *
  *  Turn on/off specified VLAN in the VLAN filter table.
  **/
-static int wx_set_vfta(struct wx *wx, u32 vlan, u32 vind, bool vlan_on)
+int wx_set_vfta(struct wx *wx, u32 vlan, u32 vind, bool vlan_on)
 {
 	u32 bitindex, vfta, targetbit;
 	bool vfta_changed = false;
@@ -2398,6 +2401,7 @@ static int wx_set_vfta(struct wx *wx, u32 vlan, u32 vind, bool vlan_on)
 
 	return 0;
 }
+EXPORT_SYMBOL(wx_set_vfta);
 
 /**
  *  wx_clear_vfta - Clear VLAN filter table
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.h b/drivers/net/ethernet/wangxun/libwx/wx_hw.h
index 9e219fa717a2..ea2b7c932274 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.h
@@ -25,9 +25,12 @@ void wx_init_eeprom_params(struct wx *wx);
 void wx_get_mac_addr(struct wx *wx, u8 *mac_addr);
 void wx_init_rx_addrs(struct wx *wx);
 void wx_mac_set_default_filter(struct wx *wx, u8 *addr);
+int wx_add_mac_filter(struct wx *wx, u8 *addr, u16 pool);
+int wx_del_mac_filter(struct wx *wx, u8 *addr, u16 pool);
 void wx_flush_sw_mac_table(struct wx *wx);
 int wx_set_mac(struct net_device *netdev, void *p);
 void wx_disable_rx(struct wx *wx);
+int wx_set_vf_spoofchk(struct net_device *netdev, int vf, bool setting);
 void wx_set_rx_mode(struct net_device *netdev);
 int wx_change_mtu(struct net_device *netdev, int new_mtu);
 void wx_disable_rx_queue(struct wx *wx, struct wx_ring *ring);
@@ -39,6 +42,7 @@ int wx_stop_adapter(struct wx *wx);
 void wx_reset_misc(struct wx *wx);
 int wx_get_pcie_msix_counts(struct wx *wx, u16 *msix_count, u16 max_msix_count);
 int wx_sw_init(struct wx *wx);
+int wx_set_vfta(struct wx *wx, u32 vlan, u32 vind, bool vlan_on);
 int wx_vlan_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid);
 int wx_vlan_rx_kill_vid(struct net_device *netdev, __be16 proto, u16 vid);
 int wx_fc_enable(struct wx *wx, bool tx_pause, bool rx_pause);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_mbx.h b/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
index 3c70654a8b14..00a9dda8365c 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
@@ -21,10 +21,60 @@
 #define WX_MBVFICR_VFREQ_MASK GENMASK(15, 0)
 #define WX_MBVFICR_VFACK_MASK GENMASK(31, 16)
 
+#define WX_VT_MSGTYPE_ACK     BIT(31)
+#define WX_VT_MSGTYPE_NACK    BIT(30)
+#define WX_VT_MSGTYPE_CTS     BIT(29)
+#define WX_VT_MSGINFO_SHIFT   16
 #define WX_VT_MSGINFO_MASK    GENMASK(23, 16)
 
+enum wx_pfvf_api_rev {
+	wx_mbox_api_null,
+	wx_mbox_api_10,      /* API version 1.0, linux/freebsd VF driver */
+	wx_mbox_api_11,      /* API version 1.1, linux/freebsd VF driver */
+	wx_mbox_api_12,      /* API version 1.2, linux/freebsd VF driver */
+	wx_mbox_api_13,      /* API version 1.3, linux/freebsd VF driver */
+	wx_mbox_api_20,      /* API version 2.0, solaris Phase1 VF driver */
+	wx_mbox_api_unknown, /* indicates that API version is not known */
+};
+
+/* mailbox API, legacy requests */
+#define WX_VF_RESET                  0x01 /* VF requests reset */
+#define WX_VF_SET_MAC_ADDR           0x02 /* VF requests PF to set MAC addr */
+#define WX_VF_SET_MULTICAST          0x03 /* VF requests PF to set MC addr */
+#define WX_VF_SET_VLAN               0x04 /* VF requests PF to set VLAN */
+
+/* mailbox API, version 1.0 VF requests */
+#define WX_VF_SET_LPE                0x05 /* VF requests PF to set VMOLR.LPE */
+#define WX_VF_SET_MACVLAN            0x06 /* VF requests PF for unicast filter */
+#define WX_VF_API_NEGOTIATE          0x08 /* negotiate API version */
+
+/* mailbox API, version 1.1 VF requests */
+#define WX_VF_GET_QUEUES             0x09 /* get queue configuration */
+
+/* mailbox API, version 1.2 VF requests */
+#define WX_VF_GET_RETA               0x0a    /* VF request for RETA */
+#define WX_VF_GET_RSS_KEY            0x0b    /* get RSS key */
+#define WX_VF_UPDATE_XCAST_MODE      0x0c
+#define WX_VF_GET_LINK_STATE         0x10 /* get vf link state */
+#define WX_VF_GET_FW_VERSION         0x11 /* get fw version */
+#define WX_VF_BACKUP                 0x8001 /* VF requests backup */
+
+#define WX_PF_CONTROL_MSG            BIT(8) /* PF control message */
+#define WX_PF_NOFITY_VF_LINK_STATUS  0x1
+#define WX_PF_NOFITY_VF_NET_NOT_RUNNING BIT(31)
+
+#define WX_VF_TX_QUEUES              1 /* number of Tx queues supported */
+#define WX_VF_RX_QUEUES              2 /* number of Rx queues supported */
+#define WX_VF_TRANS_VLAN             3 /* Indication of port vlan */
+#define WX_VF_DEF_QUEUE              4 /* Default queue offset */
+
+#define WX_VF_PERMADDR_MSG_LEN       4
+
 enum wxvf_xcast_modes {
 	WXVF_XCAST_MODE_NONE = 0,
+	WXVF_XCAST_MODE_MULTI,
+	WXVF_XCAST_MODE_ALLMULTI,
+	WXVF_XCAST_MODE_PROMISC,
 };
 
 int wx_write_mbx_pf(struct wx *wx, u32 *msg, u16 size, u16 vf);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
index 032b75f23460..22b2ee13f038 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
@@ -5,6 +5,7 @@
 #include <linux/pci.h>
 
 #include "wx_type.h"
+#include "wx_hw.h"
 #include "wx_mbx.h"
 #include "wx_sriov.h"
 
@@ -219,3 +220,750 @@ int wx_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
 	return num_vfs;
 }
 EXPORT_SYMBOL(wx_pci_sriov_configure);
+
+static int wx_set_vf_mac(struct wx *wx, u16 vf, unsigned char *mac_addr)
+{
+	int ret = 0;
+
+	wx_del_mac_filter(wx, wx->vfinfo[vf].vf_mac_addr, vf);
+	ret = wx_add_mac_filter(wx, mac_addr, vf);
+	if (ret >= 0)
+		memcpy(wx->vfinfo[vf].vf_mac_addr, mac_addr, ETH_ALEN);
+	else
+		memset(wx->vfinfo[vf].vf_mac_addr, 0, ETH_ALEN);
+
+	return ret;
+}
+
+static void wx_set_vmolr(struct wx *wx, u16 vf, bool aupe)
+{
+	u32 vmolr = rd32(wx, WX_PSR_VM_L2CTL(vf));
+
+	vmolr |=  WX_PSR_VM_L2CTL_BAM;
+	if (aupe)
+		vmolr |= WX_PSR_VM_L2CTL_AUPE;
+	else
+		vmolr &= ~WX_PSR_VM_L2CTL_AUPE;
+	wr32(wx, WX_PSR_VM_L2CTL(vf), vmolr);
+}
+
+static void wx_set_vmvir(struct wx *wx, u16 vid, u16 qos, u16 vf)
+{
+	u32 vmvir = vid | (qos << VLAN_PRIO_SHIFT) |
+		    WX_TDM_VLAN_INS_VLANA_DEFAULT;
+
+	wr32(wx, WX_TDM_VLAN_INS(vf), vmvir);
+}
+
+static int wx_set_vf_vlan(struct wx *wx, int add, int vid, u16 vf)
+{
+	/* VLAN 0 is a special case, don't allow it to be removed */
+	if (!vid && !add)
+		return 0;
+
+	return wx_set_vfta(wx, vid, vf, (bool)add);
+}
+
+/**
+ *  wx_set_vlan_anti_spoofing - Enable/Disable VLAN anti-spoofing
+ *  @wx: pointer to hardware structure
+ *  @enable: enable or disable switch for VLAN anti-spoofing
+ *  @vf: Virtual Function pool - VF Pool to set for VLAN anti-spoofing
+ *
+ **/
+static void wx_set_vlan_anti_spoofing(struct wx *wx, bool enable, int vf)
+{
+	u32 index = vf / 32, vf_bit = vf % 32;
+	u32 pfvfspoof;
+
+	pfvfspoof = rd32(wx, WX_TDM_VLAN_AS(index));
+	if (enable)
+		pfvfspoof |= BIT(vf_bit);
+	else
+		pfvfspoof &= ~BIT(vf_bit);
+	wr32(wx, WX_TDM_VLAN_AS(index), pfvfspoof);
+}
+
+static inline void wx_write_qde(struct wx *wx, u32 vf, u32 qde)
+{
+	struct wx_ring_feature *vmdq = &wx->ring_feature[RING_F_VMDQ];
+	u32 q_per_pool = __ALIGN_MASK(1, ~vmdq->mask);
+	u32 reg = 0, n = vf * q_per_pool / 32;
+	u32 i = vf * q_per_pool;
+
+	reg = rd32(wx, WX_RDM_PF_QDE(n));
+	for (i = (vf * q_per_pool - n * 32);
+	     i < ((vf + 1) * q_per_pool - n * 32);
+	     i++) {
+		if (qde == 1)
+			reg |= qde << i;
+		else
+			reg &= qde << i;
+	}
+
+	wr32(wx, WX_RDM_PF_QDE(n), reg);
+}
+
+static void wx_clear_vmvir(struct wx *wx, u32 vf)
+{
+	wr32(wx, WX_TDM_VLAN_INS(vf), 0);
+}
+
+static inline void wx_ping_vf(struct wx *wx, int vf)
+{
+	u32 ping;
+
+	ping = WX_PF_CONTROL_MSG;
+	if (wx->vfinfo[vf].clear_to_send)
+		ping |= WX_VT_MSGTYPE_CTS;
+	wx_write_mbx_pf(wx, &ping, 1, vf);
+}
+
+/**
+ * wx_set_vf_rx_tx - Set VF rx tx
+ * @wx: Pointer to wx struct
+ * @vf: VF identifier
+ *
+ * Set or reset correct transmit and receive for vf
+ **/
+static void wx_set_vf_rx_tx(struct wx *wx, int vf)
+{
+	u32 reg_cur_tx, reg_cur_rx, reg_req_tx, reg_req_rx;
+	u32 index, vf_bit;
+
+	vf_bit = vf % 32;
+	index = vf / 32;
+
+	reg_cur_tx = rd32(wx, WX_TDM_VF_TE(index));
+	reg_cur_rx = rd32(wx, WX_RDM_VF_RE(index));
+
+	if (wx->vfinfo[vf].link_enable) {
+		reg_req_tx = reg_cur_tx | BIT(vf_bit);
+		reg_req_rx = reg_cur_rx | BIT(vf_bit);
+		/* Enable particular VF */
+		if (reg_cur_tx != reg_req_tx)
+			wr32(wx, WX_TDM_VF_TE(index), reg_req_tx);
+		if (reg_cur_rx != reg_req_rx)
+			wr32(wx, WX_RDM_VF_RE(index), reg_req_rx);
+	} else {
+		reg_req_tx = BIT(vf_bit);
+		reg_req_rx = BIT(vf_bit);
+		/* Disable particular VF */
+		if (reg_cur_tx & reg_req_tx)
+			wr32(wx, WX_TDM_VFTE_CLR(index), reg_req_tx);
+		if (reg_cur_rx & reg_req_rx)
+			wr32(wx, WX_RDM_VFRE_CLR(index), reg_req_rx);
+	}
+}
+
+static int wx_get_vf_queues(struct wx *wx, u32 *msgbuf, u32 vf)
+{
+	struct wx_ring_feature *vmdq = &wx->ring_feature[RING_F_VMDQ];
+	unsigned int default_tc = 0;
+
+	/* verify the PF is supporting the correct APIs */
+	switch (wx->vfinfo[vf].vf_api) {
+	case wx_mbox_api_11 ... wx_mbox_api_20:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* only allow 1 Tx queue for bandwidth limiting */
+	msgbuf[WX_VF_TX_QUEUES] = __ALIGN_MASK(1, ~vmdq->mask);
+	msgbuf[WX_VF_RX_QUEUES] = __ALIGN_MASK(1, ~vmdq->mask);
+
+	if (wx->vfinfo[vf].pf_vlan || wx->vfinfo[vf].pf_qos)
+		msgbuf[WX_VF_TRANS_VLAN] = 1;
+	else
+		msgbuf[WX_VF_TRANS_VLAN] = 0;
+
+	/* notify VF of default queue */
+	msgbuf[WX_VF_DEF_QUEUE] = default_tc;
+
+	return 0;
+}
+
+static inline void wx_vf_reset_event(struct wx *wx, u16 vf)
+{
+	struct vf_data_storage *vfinfo = &wx->vfinfo[vf];
+	u8 num_tcs = netdev_get_num_tc(wx->netdev);
+
+	/* add PF assigned VLAN or VLAN 0 */
+	wx_set_vf_vlan(wx, true, vfinfo->pf_vlan, vf);
+
+	/* reset offloads to defaults */
+	wx_set_vmolr(wx, vf, !vfinfo->pf_vlan);
+
+	/* set outgoing tags for VFs */
+	if (!vfinfo->pf_vlan && !vfinfo->pf_qos && !num_tcs) {
+		wx_clear_vmvir(wx, vf);
+	} else {
+		if (vfinfo->pf_qos || !num_tcs)
+			wx_set_vmvir(wx, vfinfo->pf_vlan,
+				     vfinfo->pf_qos, vf);
+		else
+			wx_set_vmvir(wx, vfinfo->pf_vlan,
+				     wx->default_up, vf);
+	}
+
+	/* reset multicast table array for vf */
+	wx->vfinfo[vf].num_vf_mc_hashes = 0;
+
+	/* Flush and reset the mta with the new values */
+	wx_set_rx_mode(wx->netdev);
+
+	wx_del_mac_filter(wx, wx->vfinfo[vf].vf_mac_addr, vf);
+
+	/* reset VF api back to unknown */
+	wx->vfinfo[vf].vf_api = wx_mbox_api_10;
+}
+
+static void wx_vf_reset_msg(struct wx *wx, u16 vf)
+{
+	unsigned char *vf_mac = wx->vfinfo[vf].vf_mac_addr;
+	struct net_device *dev = wx->netdev;
+	u32 msgbuf[5] = {0, 0, 0, 0, 0};
+	u8 *addr = (u8 *)(&msgbuf[1]);
+	u32 reg = 0, index, vf_bit;
+	int pf_max_frame;
+
+	/* reset the filters for the device */
+	wx_vf_reset_event(wx, vf);
+
+	/* set vf mac address */
+	if (!is_zero_ether_addr(vf_mac))
+		wx_set_vf_mac(wx, vf, vf_mac);
+
+	vf_bit = vf % 32;
+	index = vf / 32;
+
+	/* force drop enable for all VF Rx queues */
+	wx_write_qde(wx, vf, 1);
+
+	/* set transmit and receive for vf */
+	wx_set_vf_rx_tx(wx, vf);
+
+	pf_max_frame = dev->mtu + ETH_HLEN;
+
+	if (pf_max_frame > ETH_FRAME_LEN)
+		reg = BIT(vf_bit);
+	wr32(wx, WX_RDM_VFRE_CLR(index), reg);
+
+	/* enable VF mailbox for further messages */
+	wx->vfinfo[vf].clear_to_send = true;
+
+	/* reply to reset with ack and vf mac address */
+	msgbuf[0] = WX_VF_RESET;
+	if (!is_zero_ether_addr(vf_mac)) {
+		msgbuf[0] |= WX_VT_MSGTYPE_ACK;
+		memcpy(addr, vf_mac, ETH_ALEN);
+	} else {
+		msgbuf[0] |= WX_VT_MSGTYPE_NACK;
+		wx_err(wx, "VF %d has no MAC address assigned", vf);
+	}
+
+	/* Piggyback the multicast filter type so VF can compute the
+	 * correct vectors
+	 */
+	msgbuf[3] = wx->mac.mc_filter_type;
+	wx_write_mbx_pf(wx, msgbuf, WX_VF_PERMADDR_MSG_LEN, vf);
+}
+
+static int wx_set_vf_mac_addr(struct wx *wx, u32 *msgbuf, u16 vf)
+{
+	u8 *new_mac = ((u8 *)(&msgbuf[1]));
+
+	if (!is_valid_ether_addr(new_mac)) {
+		wx_err(wx, "VF %d attempted to set invalid mac\n", vf);
+		return -EINVAL;
+	}
+
+	if (wx->vfinfo[vf].pf_set_mac &&
+	    memcmp(wx->vfinfo[vf].vf_mac_addr, new_mac, ETH_ALEN)) {
+		wx_err(wx,
+		       "VF %d attempted to set a MAC address but it already had a MAC address.",
+		       vf);
+		return -EBUSY;
+	}
+	return wx_set_vf_mac(wx, vf, new_mac) < 0;
+}
+
+static int wx_set_vf_multicasts(struct wx *wx, u32 *msgbuf, u32 vf)
+{
+	u16 entries = (msgbuf[0] & WX_VT_MSGINFO_MASK) >> WX_VT_MSGINFO_SHIFT;
+	struct vf_data_storage *vfinfo = &wx->vfinfo[vf];
+	u32 vmolr = rd32(wx, WX_PSR_VM_L2CTL(vf));
+	u32 vector_bit, vector_reg, mta_reg, i;
+	u16 *hash_list = (u16 *)&msgbuf[1];
+
+	/* only so many hash values supported */
+	entries = min_t(u16, entries, WX_MAX_VF_MC_ENTRIES);
+	/* salt away the number of multi cast addresses assigned
+	 * to this VF for later use to restore when the PF multi cast
+	 * list changes
+	 */
+	vfinfo->num_vf_mc_hashes = entries;
+
+	/* VFs are limited to using the MTA hash table for their multicast
+	 * addresses
+	 */
+	for (i = 0; i < entries; i++)
+		vfinfo->vf_mc_hashes[i] = hash_list[i];
+
+	for (i = 0; i < vfinfo->num_vf_mc_hashes; i++) {
+		vector_reg = (vfinfo->vf_mc_hashes[i] >> 5) & 0x7F;
+		vector_bit = vfinfo->vf_mc_hashes[i] & 0x1F;
+		/* errata 5: maintain a copy of the register table conf */
+		mta_reg = wx->mac.mta_shadow[vector_reg];
+		mta_reg |= (1 << vector_bit);
+		wx->mac.mta_shadow[vector_reg] = mta_reg;
+		wr32(wx, WX_PSR_MC_TBL(vector_reg), mta_reg);
+	}
+	vmolr |= WX_PSR_VM_L2CTL_ROMPE;
+	wr32(wx, WX_PSR_VM_L2CTL(vf), vmolr);
+
+	return 0;
+}
+
+static int wx_set_vf_lpe(struct wx *wx, u32 max_frame, u32 vf)
+{
+	struct net_device *netdev = wx->netdev;
+	u32 index, vf_bit, vfre;
+	u32 max_frs, reg_val;
+	int pf_max_frame;
+	int err = 0;
+
+	pf_max_frame = netdev->mtu + ETH_HLEN +  ETH_FCS_LEN + VLAN_HLEN;
+	switch (wx->vfinfo[vf].vf_api) {
+	case wx_mbox_api_11 ... wx_mbox_api_13:
+		/* Version 1.1 supports jumbo frames on VFs if PF has
+		 * jumbo frames enabled which means legacy VFs are
+		 * disabled
+		 */
+		if (pf_max_frame > ETH_FRAME_LEN)
+			break;
+		fallthrough;
+	default:
+		/* If the PF or VF are running w/ jumbo frames enabled
+		 * we need to shut down the VF Rx path as we cannot
+		 * support jumbo frames on legacy VFs
+		 */
+		if (pf_max_frame > ETH_FRAME_LEN ||
+		    (max_frame > (ETH_FRAME_LEN + ETH_FCS_LEN + VLAN_HLEN)))
+			err = -EINVAL;
+		break;
+	}
+
+	/* determine VF receive enable location */
+	vf_bit = vf % 32;
+	index = vf / 32;
+
+	/* enable or disable receive depending on error */
+	vfre = rd32(wx, WX_RDM_VF_RE(index));
+	if (err)
+		vfre &= ~BIT(vf_bit);
+	else
+		vfre |= BIT(vf_bit);
+	wr32(wx, WX_RDM_VF_RE(index), vfre);
+
+	if (err) {
+		wx_err(wx, "VF max_frame %d out of range\n", max_frame);
+		return err;
+	}
+	/* pull current max frame size from hardware */
+	max_frs = DIV_ROUND_UP(max_frame, 1024);
+	reg_val = rd32(wx, WX_MAC_WDG_TIMEOUT) & WX_MAC_WDG_TIMEOUT_WTO_MASK;
+	if (max_frs > (reg_val + WX_MAC_WDG_TIMEOUT_WTO_DELTA))
+		wr32(wx, WX_MAC_WDG_TIMEOUT, max_frs - WX_MAC_WDG_TIMEOUT_WTO_DELTA);
+
+	return 0;
+}
+
+static int wx_find_vlvf_entry(struct wx *wx, u32 vlan)
+{
+	int regindex;
+	u32 vlvf;
+
+	/* short cut the special case */
+	if (vlan == 0)
+		return 0;
+
+	/* Search for the vlan id in the VLVF entries */
+	for (regindex = 1; regindex < WX_PSR_VLAN_SWC_ENTRIES; regindex++) {
+		wr32(wx, WX_PSR_VLAN_SWC_IDX, regindex);
+		vlvf = rd32(wx, WX_PSR_VLAN_SWC);
+		if ((vlvf & VLAN_VID_MASK) == vlan)
+			break;
+	}
+
+	/* Return a negative value if not found */
+	if (regindex >= WX_PSR_VLAN_SWC_ENTRIES)
+		regindex = -EINVAL;
+
+	return regindex;
+}
+
+static int wx_set_vf_macvlan(struct wx *wx,
+			     u16 vf, int index, unsigned char *mac_addr)
+{
+	struct vf_macvlans *entry;
+	struct list_head *pos;
+	int retval = 0;
+
+	if (index <= 1) {
+		list_for_each(pos, &wx->vf_mvs.l) {
+			entry = list_entry(pos, struct vf_macvlans, l);
+			if (entry->vf == vf) {
+				entry->vf = -1;
+				entry->free = true;
+				entry->is_macvlan = false;
+				wx_del_mac_filter(wx, entry->vf_macvlan, vf);
+			}
+		}
+	}
+
+	/* If index was zero then we were asked to clear the uc list
+	 * for the VF.  We're done.
+	 */
+	if (!index)
+		return 0;
+
+	entry = NULL;
+
+	list_for_each(pos, &wx->vf_mvs.l) {
+		entry = list_entry(pos, struct vf_macvlans, l);
+		if (entry->free)
+			break;
+	}
+
+	/* If we traversed the entire list and didn't find a free entry
+	 * then we're out of space on the RAR table.  Also entry may
+	 * be NULL because the original memory allocation for the list
+	 * failed, which is not fatal but does mean we can't support
+	 * VF requests for MACVLAN because we couldn't allocate
+	 * memory for the list manangbeent required.
+	 */
+	if (!entry || !entry->free)
+		return -ENOSPC;
+
+	retval = wx_add_mac_filter(wx, mac_addr, vf);
+	if (retval >= 0) {
+		entry->free = false;
+		entry->is_macvlan = true;
+		entry->vf = vf;
+		memcpy(entry->vf_macvlan, mac_addr, ETH_ALEN);
+	}
+
+	return retval;
+}
+
+static int wx_set_vf_vlan_msg(struct wx *wx, u32 *msgbuf, u16 vf)
+{
+	int add = (msgbuf[0] & WX_VT_MSGINFO_MASK) >> WX_VT_MSGINFO_SHIFT;
+	int vid = (msgbuf[1] & WX_PSR_VLAN_SWC_VLANID_MASK);
+	int err;
+
+	if (add)
+		wx->vfinfo[vf].vlan_count++;
+	else if (wx->vfinfo[vf].vlan_count)
+		wx->vfinfo[vf].vlan_count--;
+
+	/* in case of promiscuous mode any VLAN filter set for a VF must
+	 * also have the PF pool added to it.
+	 */
+	if (add && wx->netdev->flags & IFF_PROMISC)
+		err = wx_set_vf_vlan(wx, add, vid, VMDQ_P(0));
+
+	err = wx_set_vf_vlan(wx, add, vid, vf);
+	if (!err && wx->vfinfo[vf].spoofchk_enabled)
+		wx_set_vlan_anti_spoofing(wx, true, vf);
+
+	/* Go through all the checks to see if the VLAN filter should
+	 * be wiped completely.
+	 */
+	if (!add && wx->netdev->flags & IFF_PROMISC) {
+		u32 bits = 0, vlvf;
+		int reg_ndx;
+
+		reg_ndx = wx_find_vlvf_entry(wx, vid);
+		if (reg_ndx < 0)
+			goto out;
+		wr32(wx, WX_PSR_VLAN_SWC_IDX, reg_ndx);
+		vlvf = rd32(wx, WX_PSR_VLAN_SWC);
+		/* See if any other pools are set for this VLAN filter
+		 * entry other than the PF.
+		 */
+		if (VMDQ_P(0) < 32) {
+			bits = rd32(wx, WX_PSR_VLAN_SWC_VM_L);
+			bits &= ~BIT(VMDQ_P(0));
+			if (wx->mac.type == wx_mac_sp)
+				bits |= rd32(wx, WX_PSR_VLAN_SWC_VM_H);
+		} else {
+			if (wx->mac.type == wx_mac_sp)
+				bits = rd32(wx, WX_PSR_VLAN_SWC_VM_H);
+			bits &= ~BIT(VMDQ_P(0) % 32);
+			bits |= rd32(wx, WX_PSR_VLAN_SWC_VM_L);
+		}
+		/* If the filter was removed then ensure PF pool bit
+		 * is cleared if the PF only added itself to the pool
+		 * because the PF is in promiscuous mode.
+		 */
+		if ((vlvf & VLAN_VID_MASK) == vid && !bits)
+			wx_set_vf_vlan(wx, add, vid, VMDQ_P(0));
+	}
+
+out:
+	return err;
+}
+
+static int wx_set_vf_macvlan_msg(struct wx *wx, u32 *msgbuf, u16 vf)
+{
+	int index = (msgbuf[0] & WX_VT_MSGINFO_MASK) >>
+		    WX_VT_MSGINFO_SHIFT;
+	u8 *new_mac = ((u8 *)(&msgbuf[1]));
+	int err;
+
+	if (wx->vfinfo[vf].pf_set_mac && index > 0) {
+		wx_err(wx, "VF %d requested MACVLAN filter but is administratively denied\n", vf);
+		return -EINVAL;
+	}
+
+	/* An non-zero index indicates the VF is setting a filter */
+	if (index) {
+		if (!is_valid_ether_addr(new_mac)) {
+			wx_err(wx, "VF %d attempted to set invalid mac\n", vf);
+			return -EINVAL;
+		}
+		/* If the VF is allowed to set MAC filters then turn off
+		 * anti-spoofing to avoid false positives.
+		 */
+		if (wx->vfinfo[vf].spoofchk_enabled)
+			wx_set_vf_spoofchk(wx->netdev, vf, false);
+	}
+
+	err = wx_set_vf_macvlan(wx, vf, index, new_mac);
+	if (err == -ENOSPC)
+		wx_err(wx,
+		       "VF %d has requested a MACVLAN filter but there is no space for it\n",
+		       vf);
+
+	return err < 0;
+}
+
+static int wx_negotiate_vf_api(struct wx *wx, u32 *msgbuf, u32 vf)
+{
+	int api = msgbuf[1];
+
+	switch (api) {
+	case wx_mbox_api_10 ... wx_mbox_api_13:
+		wx->vfinfo[vf].vf_api = api;
+		return 0;
+	default:
+		wx_err(wx, "VF %d requested invalid api version %u\n", vf, api);
+		return -EINVAL;
+	}
+}
+
+static int wx_get_vf_link_state(struct wx *wx, u32 *msgbuf, u32 vf)
+{
+	/* verify the PF is supporting the correct API */
+	switch (wx->vfinfo[vf].vf_api) {
+	case wx_mbox_api_12 ... wx_mbox_api_13:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	msgbuf[1] = wx->vfinfo[vf].link_enable;
+
+	return 0;
+}
+
+static int wx_get_fw_version(struct wx *wx, u32 *msgbuf, u32 vf)
+{
+	unsigned long fw_version = 0ULL;
+	int ret = 0;
+
+	/* verify the PF is supporting the correct API */
+	switch (wx->vfinfo[vf].vf_api) {
+	case wx_mbox_api_12 ... wx_mbox_api_13:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	ret = kstrtoul(wx->eeprom_id, 16, &fw_version);
+	if (ret)
+		return -EOPNOTSUPP;
+	msgbuf[1] = fw_version;
+
+	return 0;
+}
+
+static int wx_update_vf_xcast_mode(struct wx *wx, u32 *msgbuf, u32 vf)
+{
+	int xcast_mode = msgbuf[1];
+	u32 vmolr, disable, enable;
+
+	/* verify the PF is supporting the correct APIs */
+	switch (wx->vfinfo[vf].vf_api) {
+	case wx_mbox_api_12:
+		/* promisc introduced in 1.3 version */
+		if (xcast_mode == WXVF_XCAST_MODE_PROMISC)
+			return -EOPNOTSUPP;
+		fallthrough;
+	case wx_mbox_api_13:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	if (wx->vfinfo[vf].xcast_mode == xcast_mode)
+		goto out;
+
+	switch (xcast_mode) {
+	case WXVF_XCAST_MODE_NONE:
+		disable = WX_PSR_VM_L2CTL_BAM | WX_PSR_VM_L2CTL_ROMPE |
+			  WX_PSR_VM_L2CTL_MPE | WX_PSR_VM_L2CTL_UPE | WX_PSR_VM_L2CTL_VPE;
+		enable = 0;
+		break;
+	case WXVF_XCAST_MODE_MULTI:
+		disable = WX_PSR_VM_L2CTL_MPE | WX_PSR_VM_L2CTL_UPE | WX_PSR_VM_L2CTL_VPE;
+		enable = WX_PSR_VM_L2CTL_BAM | WX_PSR_VM_L2CTL_ROMPE;
+		break;
+	case WXVF_XCAST_MODE_ALLMULTI:
+		disable = WX_PSR_VM_L2CTL_UPE | WX_PSR_VM_L2CTL_VPE;
+		enable = WX_PSR_VM_L2CTL_BAM | WX_PSR_VM_L2CTL_ROMPE | WX_PSR_VM_L2CTL_MPE;
+		break;
+	case WXVF_XCAST_MODE_PROMISC:
+		disable = 0;
+		enable = WX_PSR_VM_L2CTL_BAM | WX_PSR_VM_L2CTL_ROMPE |
+			 WX_PSR_VM_L2CTL_MPE | WX_PSR_VM_L2CTL_UPE | WX_PSR_VM_L2CTL_VPE;
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	vmolr = rd32(wx, WX_PSR_VM_L2CTL(vf));
+	vmolr &= ~disable;
+	vmolr |= enable;
+	wr32(wx, WX_PSR_VM_L2CTL(vf), vmolr);
+
+	wx->vfinfo[vf].xcast_mode = xcast_mode;
+out:
+	msgbuf[1] = xcast_mode;
+
+	return 0;
+}
+
+static void wx_rcv_msg_from_vf(struct wx *wx, u16 vf)
+{
+	u16 mbx_size = WX_VXMAILBOX_SIZE;
+	u32 msgbuf[WX_VXMAILBOX_SIZE];
+	int retval;
+
+	retval = wx_read_mbx_pf(wx, msgbuf, mbx_size, vf);
+	if (retval) {
+		wx_err(wx, "Error receiving message from VF\n");
+		return;
+	}
+
+	/* this is a message we already processed, do nothing */
+	if (msgbuf[0] & (WX_VT_MSGTYPE_ACK | WX_VT_MSGTYPE_NACK))
+		return;
+
+	if (msgbuf[0] == WX_VF_RESET) {
+		wx_vf_reset_msg(wx, vf);
+		return;
+	}
+
+	/* until the vf completes a virtual function reset it should not be
+	 * allowed to start any configuration.
+	 */
+	if (!wx->vfinfo[vf].clear_to_send) {
+		msgbuf[0] |= WX_VT_MSGTYPE_NACK;
+		wx_write_mbx_pf(wx, msgbuf, 1, vf);
+		return;
+	}
+
+	switch ((msgbuf[0] & U16_MAX)) {
+	case WX_VF_SET_MAC_ADDR:
+		retval = wx_set_vf_mac_addr(wx, msgbuf, vf);
+		break;
+	case WX_VF_SET_MULTICAST:
+		retval = wx_set_vf_multicasts(wx, msgbuf, vf);
+		break;
+	case WX_VF_SET_VLAN:
+		retval = wx_set_vf_vlan_msg(wx, msgbuf, vf);
+		break;
+	case WX_VF_SET_LPE:
+		if (msgbuf[1] > WX_MAX_JUMBO_FRAME_SIZE) {
+			wx_err(wx, "VF max_frame %d out of range\n", msgbuf[1]);
+			return;
+		}
+		retval = wx_set_vf_lpe(wx, msgbuf[1], vf);
+		break;
+	case WX_VF_SET_MACVLAN:
+		retval = wx_set_vf_macvlan_msg(wx, msgbuf, vf);
+		break;
+	case WX_VF_API_NEGOTIATE:
+		retval = wx_negotiate_vf_api(wx, msgbuf, vf);
+		break;
+	case WX_VF_GET_QUEUES:
+		retval = wx_get_vf_queues(wx, msgbuf, vf);
+		break;
+	case WX_VF_GET_LINK_STATE:
+		retval = wx_get_vf_link_state(wx, msgbuf, vf);
+		break;
+	case WX_VF_GET_FW_VERSION:
+		retval = wx_get_fw_version(wx, msgbuf, vf);
+		break;
+	case WX_VF_UPDATE_XCAST_MODE:
+		retval = wx_update_vf_xcast_mode(wx, msgbuf, vf);
+		break;
+	case WX_VF_BACKUP:
+		break;
+	default:
+		wx_err(wx, "Unhandled Msg %8.8x\n", msgbuf[0]);
+		break;
+	}
+
+	/* notify the VF of the results of what it sent us */
+	if (retval)
+		msgbuf[0] |= WX_VT_MSGTYPE_NACK;
+	else
+		msgbuf[0] |= WX_VT_MSGTYPE_ACK;
+
+	msgbuf[0] |= WX_VT_MSGTYPE_CTS;
+
+	wx_write_mbx_pf(wx, msgbuf, mbx_size, vf);
+}
+
+static void wx_rcv_ack_from_vf(struct wx *wx, u16 vf)
+{
+	u32 msg = WX_VT_MSGTYPE_NACK;
+
+	/* if device isn't clear to send it shouldn't be reading either */
+	if (!wx->vfinfo[vf].clear_to_send)
+		wx_write_mbx_pf(wx, &msg, 1, vf);
+}
+
+void wx_msg_task(struct wx *wx)
+{
+	u16 vf;
+
+	for (vf = 0; vf < wx->num_vfs; vf++) {
+		/* process any reset requests */
+		if (!wx_check_for_rst_pf(wx, vf))
+			wx_vf_reset_event(wx, vf);
+
+		/* process any messages pending */
+		if (!wx_check_for_msg_pf(wx, vf))
+			wx_rcv_msg_from_vf(wx, vf);
+
+		/* process any acks */
+		if (!wx_check_for_ack_pf(wx, vf))
+			wx_rcv_ack_from_vf(wx, vf);
+	}
+}
+EXPORT_SYMBOL(wx_msg_task);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.h b/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
index 17b547ae8862..f311774a2a18 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
@@ -6,5 +6,6 @@
 
 int wx_disable_sriov(struct wx *wx);
 int wx_pci_sriov_configure(struct pci_dev *pdev, int num_vfs);
+void wx_msg_task(struct wx *wx);
 
 #endif /* _WX_SRIOV_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 7d39429a147b..28dd879060fd 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -77,6 +77,8 @@
 
 /*********************** Receive DMA registers **************************/
 #define WX_RDM_VF_RE(_i)             (0x12004 + ((_i) * 4))
+#define WX_RDM_PF_QDE(_i)            (0x12080 + ((_i) * 4))
+#define WX_RDM_VFRE_CLR(_i)          (0x120A0 + ((_i) * 4))
 #define WX_RDM_DRP_PKT               0x12500
 #define WX_RDM_PKT_CNT               0x12504
 #define WX_RDM_BYTE_CNT_LSB          0x12508
@@ -120,6 +122,7 @@
 #define WX_TDM_VF_TE(_i)             (0x18004 + ((_i) * 4))
 #define WX_TDM_MAC_AS(_i)            (0x18060 + ((_i) * 4))
 #define WX_TDM_VLAN_AS(_i)           (0x18070 + ((_i) * 4))
+#define WX_TDM_VFTE_CLR(_i)          (0x180A0 + ((_i) * 4))
 
 /* TDM CTL BIT */
 #define WX_TDM_CTL_TE                BIT(0) /* Transmit Enable */
@@ -200,6 +203,7 @@
 #define WX_PSR_VM_L2CTL(_i)          (0x15600 + ((_i) * 4))
 #define WX_PSR_VM_L2CTL_UPE          BIT(4) /* unicast promiscuous */
 #define WX_PSR_VM_L2CTL_VACC         BIT(6) /* accept nomatched vlan */
+#define WX_PSR_VM_L2CTL_VPE          BIT(7) /* vlan promiscuous mode */
 #define WX_PSR_VM_L2CTL_AUPE         BIT(8) /* accept untagged packets */
 #define WX_PSR_VM_L2CTL_ROMPE        BIT(9) /* accept packets in MTA tbl */
 #define WX_PSR_VM_L2CTL_ROPE         BIT(10) /* accept packets in UC tbl */
@@ -243,6 +247,7 @@
 /* VLAN pool filtering masks */
 #define WX_PSR_VLAN_SWC_VIEN         BIT(31)  /* filter is valid */
 #define WX_PSR_VLAN_SWC_ENTRIES      64
+#define WX_PSR_VLAN_SWC_VLANID_MASK  GENMASK(11, 0)
 
 /********************************* RSEC **************************************/
 /* general rsec */
@@ -256,6 +261,9 @@
 /*********************** Transmit DMA registers **************************/
 /* transmit global control */
 #define WX_TDM_ETYPE_AS(_i)          (0x18058 + ((_i) * 4))
+#define WX_TDM_VLAN_INS(_i)          (0x18100 + ((_i) * 4))
+/* Per VF Port VLAN insertion rules */
+#define WX_TDM_VLAN_INS_VLANA_DEFAULT BIT(30) /* Always use default VLAN*/
 
 /****************************** TDB ******************************************/
 #define WX_TDB_PB_SZ(_i)             (0x1CC00 + ((_i) * 4))
@@ -296,6 +304,9 @@
 #define WX_MAC_WDG_TIMEOUT           0x1100C
 #define WX_MAC_RX_FLOW_CTRL          0x11090
 #define WX_MAC_RX_FLOW_CTRL_RFE      BIT(0) /* receive fc enable */
+
+#define WX_MAC_WDG_TIMEOUT_WTO_MASK  GENMASK(3, 0)
+#define WX_MAC_WDG_TIMEOUT_WTO_DELTA 2
 /* MDIO Registers */
 #define WX_MSCA                      0x11200
 #define WX_MSCA_RA(v)                FIELD_PREP(U16_MAX, v)
@@ -1027,6 +1038,11 @@ struct vf_data_storage {
 	bool link_enable;
 	bool trusted;
 	int xcast_mode;
+	unsigned int vf_api;
+	bool clear_to_send;
+	u16 pf_vlan; /* When set, guest VLAN config not allowed. */
+	u16 pf_qos;
+	bool pf_set_mac;
 
 	u16 vf_mc_hashes[WX_MAX_VF_MC_ENTRIES];
 	u16 num_vf_mc_hashes;
@@ -1133,6 +1149,7 @@ struct wx {
 	u32 wol;
 
 	u16 bd_number;
+	bool default_up;
 
 	struct wx_hw_stats stats;
 	u64 tx_busy;
-- 
2.43.2


