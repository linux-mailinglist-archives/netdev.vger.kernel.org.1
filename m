Return-Path: <netdev+bounces-84341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 659B1896A7E
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 11:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C34B2839CB
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 09:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FACA131BDE;
	Wed,  3 Apr 2024 09:27:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBACE71B4F
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712136476; cv=none; b=dCnjrsDH0w2uej0ISJ/QQ1rkUiP3cAAWam3L/t/lh7gcfRwpU2HCjMf8FIUyOeotkHU7/stPTRm8PSw2rzdW65MGfjdDQeHplE2vF3KakdRsn2r+tvdZ5EwLcsfDTmCCUtbLqHd22lDvRyGwRXGmIBznoovyGBvaLjAmg3ALHg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712136476; c=relaxed/simple;
	bh=WEamhaJuOUY7FTxvK4s3lFJfUkFdpmy9oo10pW4aF2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GyIYsfTsWjfWzPMMTzGZ7ptmY7SEu6YEsJxF3oituJ6EkxWP1biJD/ePyzwC/BhjQy46sLqnKAGGutkfUqSpJuB3OMtkOtzrCoYQbo0TaKyMi4KouZeMj8sS9qVOFN3x2ZglII8OEJ1oP5jkBjYKnXpoCNew63gXJQ6Od2iHxuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtpsz9t1712136463tmkawj4
X-QQ-Originating-IP: f9CQNfYLdoz1tgqpo9WHzAwACB98n1xRTMY2gnsw4NY=
Received: from localhost.localdomain ( [36.24.97.137])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Apr 2024 17:27:42 +0800 (CST)
X-QQ-SSF: 01400000000000O0Z000000A0000000
X-QQ-FEAT: Pbidb3+knnHAJ7CUDBLLjH7cCySSCw+8Zt9QrHsqRQNIsjToYixPzgPT8j5LF
	cyTUHiZFIFzURnZNQlmJ6IAZTxSf7A5ZwNvB2SfOwWynBrcx/REP6PWDC8PknRb0ueWFiPv
	PFq+W0WxwPgqSd6mbUMsFP4YBafjZQy1DHjAoVo426hCDuLjeakJdXLaPTtfRCYjaNaJKTK
	cQEKo1yeEZusf7J9GjkS/HDnYlm+Uiuzua2bscEW5UiiyXgv2cffGWAqzwkxef+ve30LsAJ
	KIcetSucSPf04JawLqjE/KEuZO44i+gA0MQrmpJMYHdVh1MWluPRYQutZ/RDY9rNOrH7Keb
	55FqkngLpRWsGRJn0ZNNJjnq5KAr/DUqMbt8cul/PvIw8s92outxA2HfG25Vf/rwjAJ75nR
	PJsyTVcZ4AU=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 6749961609247454752
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v2 3/7] net: libwx: Implement basic funcs for vf setting
Date: Wed,  3 Apr 2024 17:10:00 +0800
Message-ID: <BA6594D4D47BD732+20240403092714.3027-4-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240403092714.3027-1-mengyuanlou@net-swift.com>
References: <20240403092714.3027-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz6a-1

Implements ndo_get_vf_config, ndo_set_vf_vlan,
ndo_set_vf_mac, ndo_set_vf_spoofchk and
ndo_set_vf_link_state for wangxun pf drivers.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    |   9 +-
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   3 +
 drivers/net/ethernet/wangxun/libwx/wx_mbx.h   |   3 +
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 351 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.h |   5 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  23 ++
 6 files changed, 391 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 945c13d1a982..fd04386a7580 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -833,7 +833,7 @@ void wx_flush_sw_mac_table(struct wx *wx)
 }
 EXPORT_SYMBOL(wx_flush_sw_mac_table);
 
-static int wx_add_mac_filter(struct wx *wx, u8 *addr, u16 pool)
+int wx_add_mac_filter(struct wx *wx, u8 *addr, u16 pool)
 {
 	u32 i;
 
@@ -863,8 +863,9 @@ static int wx_add_mac_filter(struct wx *wx, u8 *addr, u16 pool)
 	}
 	return -ENOMEM;
 }
+EXPORT_SYMBOL(wx_add_mac_filter);
 
-static int wx_del_mac_filter(struct wx *wx, u8 *addr, u16 pool)
+int wx_del_mac_filter(struct wx *wx, u8 *addr, u16 pool)
 {
 	u32 i;
 
@@ -887,6 +888,7 @@ static int wx_del_mac_filter(struct wx *wx, u8 *addr, u16 pool)
 	}
 	return -ENOMEM;
 }
+EXPORT_SYMBOL(wx_del_mac_filter);
 
 static int wx_available_rars(struct wx *wx)
 {
@@ -2080,7 +2082,7 @@ static int wx_set_vlvf(struct wx *wx, u32 vlan, u32 vind, bool vlan_on,
  *
  *  Turn on/off specified VLAN in the VLAN filter table.
  **/
-static int wx_set_vfta(struct wx *wx, u32 vlan, u32 vind, bool vlan_on)
+int wx_set_vfta(struct wx *wx, u32 vlan, u32 vind, bool vlan_on)
 {
 	u32 bitindex, vfta, targetbit;
 	bool vfta_changed = false;
@@ -2126,6 +2128,7 @@ static int wx_set_vfta(struct wx *wx, u32 vlan, u32 vind, bool vlan_on)
 
 	return 0;
 }
+EXPORT_SYMBOL(wx_set_vfta);
 
 /**
  *  wx_clear_vfta - Clear VLAN filter table
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.h b/drivers/net/ethernet/wangxun/libwx/wx_hw.h
index 9e219fa717a2..f2717fdf83cd 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.h
@@ -25,6 +25,8 @@ void wx_init_eeprom_params(struct wx *wx);
 void wx_get_mac_addr(struct wx *wx, u8 *mac_addr);
 void wx_init_rx_addrs(struct wx *wx);
 void wx_mac_set_default_filter(struct wx *wx, u8 *addr);
+int wx_add_mac_filter(struct wx *wx, u8 *addr, u16 pool);
+int wx_del_mac_filter(struct wx *wx, u8 *addr, u16 pool);
 void wx_flush_sw_mac_table(struct wx *wx);
 int wx_set_mac(struct net_device *netdev, void *p);
 void wx_disable_rx(struct wx *wx);
@@ -39,6 +41,7 @@ int wx_stop_adapter(struct wx *wx);
 void wx_reset_misc(struct wx *wx);
 int wx_get_pcie_msix_counts(struct wx *wx, u16 *msix_count, u16 max_msix_count);
 int wx_sw_init(struct wx *wx);
+int wx_set_vfta(struct wx *wx, u32 vlan, u32 vind, bool vlan_on);
 int wx_vlan_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid);
 int wx_vlan_rx_kill_vid(struct net_device *netdev, __be16 proto, u16 vid);
 int wx_fc_enable(struct wx *wx, bool tx_pause, bool rx_pause);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_mbx.h b/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
index 3c70654a8b14..201efbc2db9a 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
@@ -21,8 +21,11 @@
 #define WX_MBVFICR_VFREQ_MASK GENMASK(15, 0)
 #define WX_MBVFICR_VFACK_MASK GENMASK(31, 16)
 
+#define WX_VT_MSGTYPE_CTS     BIT(29)
 #define WX_VT_MSGINFO_MASK    GENMASK(23, 16)
 
+#define WX_PF_CONTROL_MSG            BIT(8) /* PF control message */
+
 enum wxvf_xcast_modes {
 	WXVF_XCAST_MODE_NONE = 0,
 };
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
index 032b75f23460..decef4af3ee4 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
@@ -5,6 +5,7 @@
 #include <linux/pci.h>
 
 #include "wx_type.h"
+#include "wx_hw.h"
 #include "wx_mbx.h"
 #include "wx_sriov.h"
 
@@ -219,3 +220,353 @@ int wx_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
 	return num_vfs;
 }
 EXPORT_SYMBOL(wx_pci_sriov_configure);
+
+int wx_ndo_get_vf_config(struct net_device *netdev, int vf, struct ifla_vf_info *ivi)
+{
+	struct wx *wx = netdev_priv(netdev);
+
+	if (vf >= wx->num_vfs)
+		return -EINVAL;
+	ivi->vf = vf;
+	memcpy(&ivi->mac, wx->vfinfo[vf].vf_mac_addr, ETH_ALEN);
+
+	ivi->vlan = wx->vfinfo[vf].pf_vlan;
+	ivi->qos = wx->vfinfo[vf].pf_qos;
+	ivi->spoofchk = wx->vfinfo[vf].spoofchk_enabled;
+
+	ivi->trusted = wx->vfinfo[vf].trusted;
+	ivi->linkstate = wx->vfinfo[vf].link_state;
+
+	return 0;
+}
+EXPORT_SYMBOL(wx_ndo_get_vf_config);
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
+int wx_ndo_set_vf_mac(struct net_device *netdev, int vf, u8 *mac)
+{
+	struct wx *wx = netdev_priv(netdev);
+	int retval = 0;
+
+	if (!is_valid_ether_addr(mac) || vf >= wx->num_vfs)
+		return -EINVAL;
+
+	retval = wx_set_vf_mac(wx, vf, mac);
+	if (retval >= 0) {
+		wx->vfinfo[vf].pf_set_mac = true;
+		if (!netif_running(wx->netdev))
+			wx_err(wx, "Bring the PF device up before use vfs\n");
+	} else {
+		wx_err(wx, "The VF MAC address was NOT set due to invalid\n");
+	}
+
+	return retval;
+}
+EXPORT_SYMBOL(wx_ndo_set_vf_mac);
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
+static inline void wx_write_hide_vlan(struct wx *wx, u32 vf, u32 hide_vlan)
+{
+	struct wx_ring_feature *vmdq = &wx->ring_feature[RING_F_VMDQ];
+	u32 q_per_pool = __ALIGN_MASK(1, ~vmdq->mask);
+	u32 reg = 0, i = vf * q_per_pool;
+	u32 n = i / 32;
+
+	reg = rd32(wx, WX_RDM_PF_HIDE(n));
+	for (i = (vf * q_per_pool - n * 32);
+	     i < ((vf + 1) * q_per_pool - n * 32);
+	     i++) {
+		if (hide_vlan == 1)
+			reg |= hide_vlan << i;
+		else
+			reg &= hide_vlan << i;
+	}
+
+	wr32(wx, WX_RDM_PF_HIDE(n), reg);
+}
+
+static int wx_enable_port_vlan(struct wx *wx, int vf, u16 vlan, u8 qos)
+{
+	int err = 0;
+
+	err = wx_set_vf_vlan(wx, true, vlan, vf);
+	if (err)
+		return err;
+	wx_set_vmvir(wx, vlan, qos, vf);
+	wx_set_vmolr(wx, vf, false);
+	if (wx->vfinfo[vf].spoofchk_enabled)
+		wx_set_vlan_anti_spoofing(wx, true, vf);
+	wx->vfinfo[vf].vlan_count++;
+	/* enable hide vlan */
+	wx_write_qde(wx, vf, 1);
+	wx_write_hide_vlan(wx, vf, 1);
+	wx->vfinfo[vf].pf_vlan = vlan;
+	wx->vfinfo[vf].pf_qos = qos;
+
+	return err;
+}
+
+static void wx_clear_vmvir(struct wx *wx, u32 vf)
+{
+	wr32(wx, WX_TDM_VLAN_INS(vf), 0);
+}
+
+static int wx_disable_port_vlan(struct wx *wx, int vf)
+{
+	int err;
+
+	err = wx_set_vf_vlan(wx, false, wx->vfinfo[vf].pf_vlan, vf);
+	wx_clear_vmvir(wx, vf);
+	wx_set_vmolr(wx, vf, true);
+	wx_set_vlan_anti_spoofing(wx, false, vf);
+	if (wx->vfinfo[vf].vlan_count)
+		wx->vfinfo[vf].vlan_count--;
+	/* disable hide vlan */
+	wx_write_hide_vlan(wx, vf, 0);
+	wx->vfinfo[vf].pf_vlan = 0;
+	wx->vfinfo[vf].pf_qos = 0;
+
+	return err;
+}
+
+int wx_ndo_set_vf_vlan(struct net_device *netdev, int vf, u16 vlan,
+		       u8 qos, __be16 vlan_proto)
+{
+	struct wx *wx = netdev_priv(netdev);
+	int err = 0;
+
+	/* VLAN IDs accepted range 0-4094 */
+	if (vf >= wx->num_vfs || vlan > VLAN_VID_MASK - 1 || qos > 7)
+		return -EINVAL;
+
+	if (vlan || qos) {
+		/* Check if there is already a port VLAN set, if so
+		 * we have to delete the old one first before we
+		 * can set the new one.  The usage model had
+		 * previously assumed the user would delete the
+		 * old port VLAN before setting a new one but this
+		 * is not necessarily the case.
+		 */
+		if (wx->vfinfo[vf].pf_vlan) {
+			err = wx_disable_port_vlan(wx, vf);
+			if (err)
+				return err;
+		}
+		err = wx_enable_port_vlan(wx, vf, vlan, qos);
+
+	} else {
+		err = wx_disable_port_vlan(wx, vf);
+	}
+
+	return err;
+}
+EXPORT_SYMBOL(wx_ndo_set_vf_vlan);
+
+int wx_ndo_set_vf_spoofchk(struct net_device *netdev, int vf, bool setting)
+{
+	u32 index = vf / 32, vf_bit = vf % 32;
+	struct wx *wx = netdev_priv(netdev);
+	u32 regval;
+
+	if (vf >= wx->num_vfs)
+		return -EINVAL;
+
+	wx->vfinfo[vf].spoofchk_enabled = setting;
+
+	regval = (setting << vf_bit);
+	wr32m(wx, WX_TDM_MAC_AS(index), regval | BIT(vf_bit), regval);
+
+	if (wx->vfinfo[vf].vlan_count)
+		wr32m(wx, WX_TDM_VLAN_AS(index), regval | BIT(vf_bit), regval);
+
+	return 0;
+}
+EXPORT_SYMBOL(wx_ndo_set_vf_spoofchk);
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
+static void wx_set_vf_link_state(struct wx *wx, int vf, int state)
+{
+	wx->vfinfo[vf].link_state = state;
+	switch (state) {
+	case IFLA_VF_LINK_STATE_AUTO:
+		if (netif_running(wx->netdev))
+			wx->vfinfo[vf].link_enable = true;
+		else
+			wx->vfinfo[vf].link_enable = false;
+		break;
+	case IFLA_VF_LINK_STATE_ENABLE:
+		wx->vfinfo[vf].link_enable = true;
+		break;
+	case IFLA_VF_LINK_STATE_DISABLE:
+		wx->vfinfo[vf].link_enable = false;
+		break;
+	}
+	/* restart the VF */
+	wx->vfinfo[vf].clear_to_send = false;
+	wx_ping_vf(wx, vf);
+
+	wx_set_vf_rx_tx(wx, vf);
+}
+
+/**
+ * wx_ndo_set_vf_link_state - Set link state
+ * @netdev: network interface device structure
+ * @vf: VF identifier
+ * @state: required link state
+ *
+ * Set the link state of a specified VF, regardless of physical link state
+ **/
+int wx_ndo_set_vf_link_state(struct net_device *netdev, int vf, int state)
+{
+	struct wx *wx = netdev_priv(netdev);
+	int ret = 0;
+
+	if (vf < 0 || vf >= wx->num_vfs) {
+		wx_err(wx, "NDO set VF link - invalid VF identifier %d\n", vf);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	switch (state) {
+	case IFLA_VF_LINK_STATE_ENABLE:
+		wx_err(wx, "NDO set VF %d link state %d - not supported\n",
+		       vf, state);
+		break;
+	case IFLA_VF_LINK_STATE_DISABLE:
+	case IFLA_VF_LINK_STATE_AUTO:
+		wx_set_vf_link_state(wx, vf, state);
+		break;
+	default:
+		wx_err(wx, "NDO set VF %d - invalid link state %d\n", vf, state);
+		ret = -EINVAL;
+	}
+out:
+	return ret;
+}
+EXPORT_SYMBOL(wx_ndo_set_vf_link_state);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.h b/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
index 17b547ae8862..6ee1fdff492b 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
@@ -6,5 +6,10 @@
 
 int wx_disable_sriov(struct wx *wx);
 int wx_pci_sriov_configure(struct pci_dev *pdev, int num_vfs);
+int wx_ndo_get_vf_config(struct net_device *netdev, int vf, struct ifla_vf_info *ivi);
+int wx_ndo_set_vf_vlan(struct net_device *netdev, int vf, u16 vlan, u8 qos, __be16 vlan_proto);
+int wx_ndo_set_vf_mac(struct net_device *netdev, int vf, u8 *mac);
+int wx_ndo_set_vf_spoofchk(struct net_device *netdev, int vf, bool setting);
+int wx_ndo_set_vf_link_state(struct net_device *netdev, int vf, int state);
 
 #endif /* _WX_SRIOV_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index c1bf8653b900..2e2b997f4572 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -75,6 +75,10 @@
 #define WX_MAC_LXONOFFRXC            0x11E0C
 
 /*********************** Receive DMA registers **************************/
+#define WX_RDM_VF_RE(_i)             (0x12004 + ((_i) * 4))
+#define WX_RDM_PF_QDE(_i)            (0x12080 + ((_i) * 4))
+#define WX_RDM_PF_HIDE(_i)           (0x12090 + ((_i) * 4))
+#define WX_RDM_VFRE_CLR(_i)          (0x120A0 + ((_i) * 4))
 #define WX_RDM_DRP_PKT               0x12500
 #define WX_RDM_PKT_CNT               0x12504
 #define WX_RDM_BYTE_CNT_LSB          0x12508
@@ -114,6 +118,9 @@
 /*********************** Transmit DMA registers **************************/
 /* transmit global control */
 #define WX_TDM_CTL                   0x18000
+#define WX_TDM_VF_TE(_i)             (0x18004 + ((_i) * 4))
+#define WX_TDM_VFTE_CLR(_i)          (0x180A0 + ((_i) * 4))
+
 /* TDM CTL BIT */
 #define WX_TDM_CTL_TE                BIT(0) /* Transmit Enable */
 #define WX_TDM_PB_THRE(_i)           (0x18020 + ((_i) * 4))
@@ -244,6 +251,15 @@
 #define WX_RSC_ST                    0x17004
 #define WX_RSC_ST_RSEC_RDY           BIT(0)
 
+/*********************** Transmit DMA registers **************************/
+/* transmit global control */
+#define WX_TDM_ETYPE_AS(_i)          (0x18058 + ((_i) * 4))
+#define WX_TDM_MAC_AS(_i)            (0x18060 + ((_i) * 4))
+#define WX_TDM_VLAN_AS(_i)           (0x18070 + ((_i) * 4))
+#define WX_TDM_VLAN_INS(_i)          (0x18100 + ((_i) * 4))
+/* Per VF Port VLAN insertion rules */
+#define WX_TDM_VLAN_INS_VLANA_DEFAULT BIT(30) /* Always use default VLAN*/
+
 /****************************** TDB ******************************************/
 #define WX_TDB_PB_SZ(_i)             (0x1CC00 + ((_i) * 4))
 #define WX_TXPKT_SIZE_MAX            0xA /* Max Tx Packet size */
@@ -1000,6 +1016,13 @@ struct vf_data_storage {
 	bool link_enable;
 	bool trusted;
 	int xcast_mode;
+	bool clear_to_send;
+	u16 pf_vlan; /* When set, guest VLAN config not allowed. */
+	u16 pf_qos;
+	bool pf_set_mac;
+
+	u16 vlan_count;
+	int link_state;
 };
 
 struct vf_macvlans {
-- 
2.43.2


