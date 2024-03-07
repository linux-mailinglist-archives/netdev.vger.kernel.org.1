Return-Path: <netdev+bounces-78341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B69874BBE
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 11:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C014B252D0
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 10:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD1A8528F;
	Thu,  7 Mar 2024 09:58:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BB485284
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 09:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805511; cv=none; b=pIqvFyp061UJ2qdJLC+7xLqByPtHQFCpsjftymF8ImnG/tUx4YGJctAuwMWQXe8LdPN3FEfHKE3qUAS1BOyV1Wnu9KM61Xa0t8bR+xNM2gE0JQYwJ4FvHNjoh3CYMWeJ33bkTHbQVvTu7o6tGw6o84Dbm/MAW9JgKvnupnZY2bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805511; c=relaxed/simple;
	bh=epYiZcZWoiTf+j4S88OBTUwKXFOuY1aMfGNa9yiKSQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwJuoBfjElvp0tA9O1OIwsA6E6h4a89c3j+74J1j5iKEnQHRM6sEMS6iwbMVOf/l4aI6Ea+U/RnA4PcBB221TimOQ3ZHtV46g1T5JYL/63moyQQqhbl1QTw58Q4Sa46VYLXm2aBLu6/GH3FiPOhw+/UvGzrHXOAOlvFFoJRgmmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp87t1709805498tld4nmer
X-QQ-Originating-IP: WaZbx1uvUmOQb4UH9iW6WrfKo6rBkq0d+r8VoDNm83I=
Received: from localhost.localdomain ( [220.184.149.201])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 07 Mar 2024 17:58:16 +0800 (CST)
X-QQ-SSF: 01400000000000O0Z000000A0000000
X-QQ-FEAT: CR3LFp2JE4ku9MJOLtlxF1WHAENqDHsl0jE/LuN4AdDK2kKwt68iRG1kT5hJ/
	aIZjZfVjIKe3tw5Dzc1BmXKpLWSW68r/49wHXejqCtkr76iO/DtZaIh4NOnP75p9yL0w+TJ
	yG8n87rJVfgvV9DrJCyGrXB8JVl5o3sdvQ/9JXem6eIDDscezDm+p3rLdMYXgoy1fpyN8xF
	5uWlOMOX7p3eNoDzI2nnyT2xaIdepva1He8xkekmQ/BJvIHIBRcS2lDnMUY8ZQuY6+dmS6y
	3X4wdRHS+k6u0EcDeW8R4+9MbYL3a1Y2k65qId/QYcPZyN5sSN7w7j/7DtxDoIBlAHSetJD
	w8aSeZYUD6iqm3vVJAsVkEKIVxK7Ui1PTJ8YCEvf09UIbPo8qnGNxRRLJUNW0aCTRsT40DC
	PnuZsFD6qaA=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 17288580910219253101
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next 3/5] net: libwx: Add msg task api
Date: Thu,  7 Mar 2024 17:54:58 +0800
Message-ID: <74A88D8060E77248+20240307095755.7130-4-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240307095755.7130-1-mengyuanlou@net-swift.com>
References: <20240307095755.7130-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrgz:qybglogicsvrgz6a-1

Implement ndo_set_vf_spoofchk and ndo_set_vf_link_state
interfaces.
Implement wx_msg_task which is used to process mailbox
messages sent by vf.
Reallocate queue and int resources when sriov is enabled.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c    | 312 +++++-
 drivers/net/ethernet/wangxun/libwx/wx_hw.h    |   6 +
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   | 146 ++-
 drivers/net/ethernet/wangxun/libwx/wx_mbx.h   |  50 +
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 885 +++++++++++++++++-
 drivers/net/ethernet/wangxun/libwx/wx_sriov.h |   7 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  70 +-
 7 files changed, 1452 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index 945c13d1a982..aadcb847a837 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -11,6 +11,7 @@
 #include "wx_type.h"
 #include "wx_lib.h"
 #include "wx_hw.h"
+#include "wx_sriov.h"
 
 static int wx_phy_read_reg_mdi(struct mii_bus *bus, int phy_addr, int devnum, int regnum)
 {
@@ -804,11 +805,29 @@ static void wx_sync_mac_table(struct wx *wx)
 	}
 }
 
+void wx_full_sync_mac_table(struct wx *wx)
+{
+	int i;
+
+	for (i = 0; i < wx->mac.num_rar_entries; i++) {
+		if (wx->mac_table[i].state & WX_MAC_STATE_IN_USE) {
+			wx_set_rar(wx, i,
+				   wx->mac_table[i].addr,
+				   wx->mac_table[i].pools,
+				   WX_PSR_MAC_SWC_AD_H_AV);
+		} else {
+			wx_clear_rar(wx, i);
+		}
+		wx->mac_table[i].state &= ~(WX_MAC_STATE_MODIFIED);
+	}
+}
+EXPORT_SYMBOL(wx_full_sync_mac_table);
+
 /* this function destroys the first RAR entry */
 void wx_mac_set_default_filter(struct wx *wx, u8 *addr)
 {
 	memcpy(&wx->mac_table[0].addr, addr, ETH_ALEN);
-	wx->mac_table[0].pools = 1ULL;
+	wx->mac_table[0].pools = BIT(VMDQ_P(0));
 	wx->mac_table[0].state = (WX_MAC_STATE_DEFAULT | WX_MAC_STATE_IN_USE);
 	wx_set_rar(wx, 0, wx->mac_table[0].addr,
 		   wx->mac_table[0].pools,
@@ -833,7 +852,7 @@ void wx_flush_sw_mac_table(struct wx *wx)
 }
 EXPORT_SYMBOL(wx_flush_sw_mac_table);
 
-static int wx_add_mac_filter(struct wx *wx, u8 *addr, u16 pool)
+int wx_add_mac_filter(struct wx *wx, u8 *addr, u16 pool)
 {
 	u32 i;
 
@@ -863,8 +882,9 @@ static int wx_add_mac_filter(struct wx *wx, u8 *addr, u16 pool)
 	}
 	return -ENOMEM;
 }
+EXPORT_SYMBOL(wx_add_mac_filter);
 
-static int wx_del_mac_filter(struct wx *wx, u8 *addr, u16 pool)
+int wx_del_mac_filter(struct wx *wx, u8 *addr, u16 pool)
 {
 	u32 i;
 
@@ -887,6 +907,7 @@ static int wx_del_mac_filter(struct wx *wx, u8 *addr, u16 pool)
 	}
 	return -ENOMEM;
 }
+EXPORT_SYMBOL(wx_del_mac_filter);
 
 static int wx_available_rars(struct wx *wx)
 {
@@ -1046,6 +1067,35 @@ static void wx_update_mc_addr_list(struct wx *wx, struct net_device *netdev)
 	wx_dbg(wx, "Update mc addr list Complete\n");
 }
 
+static void wx_restore_vf_multicasts(struct wx *wx)
+{
+	u32 i, j, vector_bit, vector_reg;
+	struct vf_data_storage *vfinfo;
+
+	for (i = 0; i < wx->num_vfs; i++) {
+		u32 vmolr = rd32(wx, WX_PSR_VM_L2CTL(i));
+
+		vfinfo = &wx->vfinfo[i];
+		for (j = 0; j < vfinfo->num_vf_mc_hashes; j++) {
+			wx->addr_ctrl.mta_in_use++;
+			vector_reg = (vfinfo->vf_mc_hashes[j] >> 5) & GENMASK(6, 0);
+			vector_bit = vfinfo->vf_mc_hashes[j] & GENMASK(4, 0);
+			wr32m(wx, WX_PSR_MC_TBL(vector_reg),
+			      BIT(vector_bit), BIT(vector_bit));
+			/* errata 5: maintain a copy of the reg table conf */
+			wx->mac.mta_shadow[vector_reg] |= BIT(vector_bit);
+		}
+		if (vfinfo->num_vf_mc_hashes)
+			vmolr |= WX_PSR_VM_L2CTL_ROMPE;
+		else
+			vmolr &= ~WX_PSR_VM_L2CTL_ROMPE;
+		wr32(wx, WX_PSR_VM_L2CTL(i), vmolr);
+	}
+
+	/* Restore any VF macvlans */
+	wx_full_sync_mac_table(wx);
+}
+
 /**
  * wx_write_mc_addr_list - write multicast addresses to MTA
  * @netdev: network interface device structure
@@ -1063,6 +1113,9 @@ static int wx_write_mc_addr_list(struct net_device *netdev)
 
 	wx_update_mc_addr_list(wx, netdev);
 
+	if (test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags))
+		wx_restore_vf_multicasts(wx);
+
 	return netdev_mc_count(netdev);
 }
 
@@ -1083,7 +1136,7 @@ int wx_set_mac(struct net_device *netdev, void *p)
 	if (retval)
 		return retval;
 
-	wx_del_mac_filter(wx, wx->mac.addr, 0);
+	wx_del_mac_filter(wx, wx->mac.addr, VMDQ_P(0));
 	eth_hw_addr_set(netdev, addr->sa_data);
 	memcpy(wx->mac.addr, addr->sa_data, netdev->addr_len);
 
@@ -1178,6 +1231,10 @@ static int wx_hpbthresh(struct wx *wx)
 	/* Calculate delay value for device */
 	dv_id = WX_DV(link, tc);
 
+	/* Loopback switch introduces additional latency */
+	if (test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags))
+		dv_id += WX_B2BT(tc);
+
 	/* Delay value is calculated in bit times convert to KB */
 	kb = WX_BT2KB(dv_id);
 	rx_pba = rd32(wx, WX_RDB_PB_SZ(0)) >> WX_RDB_PB_SZ_SHIFT;
@@ -1233,12 +1290,94 @@ static void wx_pbthresh_setup(struct wx *wx)
 		wx->fc.low_water = 0;
 }
 
+/**
+ *  wx_set_ethertype_anti_spoofing - Enable/Disable Ethertype anti-spoofing
+ *  @wx: pointer to hardware structure
+ *  @enable: enable or disable switch for Ethertype anti-spoofing
+ *  @vf: Virtual Function pool - VF Pool to set for Ethertype anti-spoofing
+ *
+ **/
+static void wx_set_ethertype_anti_spoofing(struct wx *wx, bool enable, int vf)
+{
+	u32 pfvfspoof, reg_offset, vf_shift;
+
+	vf_shift = vf % 32;
+	reg_offset = vf / 32;
+
+	pfvfspoof = rd32(wx, WX_TDM_ETYPE_AS(reg_offset));
+	if (enable)
+		pfvfspoof |= BIT(vf_shift);
+	else
+		pfvfspoof &= ~BIT(vf_shift);
+	wr32(wx, WX_TDM_ETYPE_AS(reg_offset), pfvfspoof);
+}
+
+void wx_configure_virtualization(struct wx *wx)
+{
+	u16 pool = wx->num_rx_pools;
+	u32 reg_offset, vf_shift;
+	u32 i;
+
+	if (!test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags))
+		return;
+
+	wr32m(wx, WX_PSR_VM_CTL,
+	      WX_PSR_VM_CTL_POOL_MASK | WX_PSR_VM_CTL_REPLEN,
+	      FIELD_PREP(WX_PSR_VM_CTL_POOL_MASK, VMDQ_P(0)) |
+	      WX_PSR_VM_CTL_REPLEN);
+	while (pool--)
+		wr32m(wx, WX_PSR_VM_L2CTL(i), WX_PSR_VM_L2CTL_AUPE, WX_PSR_VM_L2CTL_AUPE);
+
+	if (wx->mac.type == wx_mac_sp) {
+		vf_shift = VMDQ_P(0) % 32;
+		reg_offset = VMDQ_P(0) / 32;
+
+		/* Enable only the PF pools for Tx/Rx */
+		wr32(wx, WX_RDM_VF_RE(reg_offset), GENMASK(31, vf_shift));
+		wr32(wx, WX_RDM_VF_RE(reg_offset ^ 1), reg_offset - 1);
+		wr32(wx, WX_TDM_VF_TE(reg_offset), GENMASK(31, vf_shift));
+		wr32(wx, WX_TDM_VF_TE(reg_offset ^ 1), reg_offset - 1);
+	} else {
+		vf_shift = BIT(VMDQ_P(0));
+		/* Enable only the PF pools for Tx/Rx */
+		wr32(wx, WX_RDM_VF_RE(0), vf_shift);
+		wr32(wx, WX_TDM_VF_TE(0), vf_shift);
+	}
+
+	/* clear VLAN promisc flag so VFTA will be updated if necessary */
+	clear_bit(WX_FLAG2_VLAN_PROMISC, wx->flags);
+
+	for (i = 0; i < wx->num_vfs; i++) {
+		if (!wx->vfinfo[i].spoofchk_enabled)
+			wx_ndo_set_vf_spoofchk(wx->netdev, i, false);
+		/* enable ethertype anti spoofing if hw supports it */
+		wx_set_ethertype_anti_spoofing(wx, true, i);
+	}
+}
+EXPORT_SYMBOL(wx_configure_virtualization);
+
 static void wx_configure_port(struct wx *wx)
 {
 	u32 value, i;
 
-	value = WX_CFG_PORT_CTL_D_VLAN | WX_CFG_PORT_CTL_QINQ;
+	if (wx->mac.type == wx_mac_em) {
+		value = (wx->num_vfs == 0) ?
+			WX_CFG_PORT_CTL_NUM_VT_NONE :
+			WX_CFG_PORT_CTL_NUM_VT_8;
+	} else {
+		if (test_bit(WX_FLAG_VMDQ_ENABLED, wx->flags)) {
+			if (wx->ring_feature[RING_F_RSS].indices == 4)
+				value = WX_CFG_PORT_CTL_NUM_VT_32;
+			else
+				value = WX_CFG_PORT_CTL_NUM_VT_64;
+		} else {
+			value = 0;
+		}
+	}
+
+	value |= WX_CFG_PORT_CTL_D_VLAN | WX_CFG_PORT_CTL_QINQ;
 	wr32m(wx, WX_CFG_PORT_CTL,
+	      WX_CFG_PORT_CTL_NUM_VT_MASK |
 	      WX_CFG_PORT_CTL_D_VLAN |
 	      WX_CFG_PORT_CTL_QINQ,
 	      value);
@@ -1297,6 +1436,83 @@ static void wx_vlan_strip_control(struct wx *wx, bool enable)
 	}
 }
 
+static void wx_vlan_promisc_enable(struct wx *wx)
+{
+	u32 vlnctrl, i, vind, bits, reg_idx;
+
+	vlnctrl = rd32(wx, WX_PSR_VLAN_CTL);
+	if (test_bit(WX_FLAG_VMDQ_ENABLED, wx->flags)) {
+		/* we need to keep the VLAN filter on in SRIOV */
+		vlnctrl |= WX_PSR_VLAN_CTL_VFE;
+		wr32(wx, WX_PSR_VLAN_CTL, vlnctrl);
+	} else {
+		vlnctrl &= ~WX_PSR_VLAN_CTL_VFE;
+		wr32(wx, WX_PSR_VLAN_CTL, vlnctrl);
+		return;
+	}
+	/* We are already in VLAN promisc, nothing to do */
+	if (test_bit(WX_FLAG2_VLAN_PROMISC, wx->flags))
+		return;
+	/* Set flag so we don't redo unnecessary work */
+	set_bit(WX_FLAG2_VLAN_PROMISC, wx->flags);
+	/* Add PF to all active pools */
+	for (i = WX_PSR_VLAN_SWC_ENTRIES; --i;) {
+		wr32(wx, WX_PSR_VLAN_SWC_IDX, i);
+		reg_idx = VMDQ_P(0) / 32;
+		vind = VMDQ_P(0) % 32;
+		bits = rd32(wx, WX_PSR_VLAN_SWC_VM(reg_idx));
+		bits |= BIT(vind);
+		wr32(wx, WX_PSR_VLAN_SWC_VM(reg_idx), bits);
+	}
+	/* Set all bits in the VLAN filter table array */
+	for (i = 0; i < wx->mac.vft_size; i++)
+		wr32(wx, WX_PSR_VLAN_TBL(i), U32_MAX);
+}
+
+static void wx_scrub_vfta(struct wx *wx)
+{
+	u32 i, vid, bits, vfta, vind, vlvf, reg_idx;
+
+	for (i = WX_PSR_VLAN_SWC_ENTRIES; --i;) {
+		wr32(wx, WX_PSR_VLAN_SWC_IDX, i);
+		vlvf = rd32(wx, WX_PSR_VLAN_SWC_IDX);
+		/* pull VLAN ID from VLVF */
+		vid = vlvf & ~WX_PSR_VLAN_SWC_VIEN;
+		if (vlvf & WX_PSR_VLAN_SWC_VIEN) {
+			/* if PF is part of this then continue */
+			if (test_bit(vid, wx->active_vlans))
+				continue;
+		}
+		/* remove PF from the pool */
+		reg_idx = VMDQ_P(0) / 32;
+		vind = VMDQ_P(0) % 32;
+		bits = rd32(wx, WX_PSR_VLAN_SWC_VM(reg_idx));
+		bits &= ~BIT(vind);
+		wr32(wx, WX_PSR_VLAN_SWC_VM(reg_idx), bits);
+	}
+	/* extract values from vft_shadow and write back to VFTA */
+	for (i = 0; i < wx->mac.vft_size; i++) {
+		vfta = wx->mac.vft_shadow[i];
+		wr32(wx, WX_PSR_VLAN_TBL(i), vfta);
+	}
+}
+
+static void wx_vlan_promisc_disable(struct wx *wx)
+{
+	u32 vlnctrl;
+
+	/* configure vlan filtering */
+	vlnctrl = rd32(wx, WX_PSR_VLAN_CTL);
+	vlnctrl |= WX_PSR_VLAN_CTL_VFE;
+	wr32(wx, WX_PSR_VLAN_CTL, vlnctrl);
+	/* We are not in VLAN promisc, nothing to do */
+	if (!test_bit(WX_FLAG2_VLAN_PROMISC, wx->flags))
+		return;
+	/* Set flag so we don't redo unnecessary work */
+	clear_bit(WX_FLAG2_VLAN_PROMISC, wx->flags);
+	wx_scrub_vfta(wx);
+}
+
 void wx_set_rx_mode(struct net_device *netdev)
 {
 	struct wx *wx = netdev_priv(netdev);
@@ -1309,7 +1525,7 @@ void wx_set_rx_mode(struct net_device *netdev)
 	/* Check for Promiscuous and All Multicast modes */
 	fctrl = rd32(wx, WX_PSR_CTL);
 	fctrl &= ~(WX_PSR_CTL_UPE | WX_PSR_CTL_MPE);
-	vmolr = rd32(wx, WX_PSR_VM_L2CTL(0));
+	vmolr = rd32(wx, WX_PSR_VM_L2CTL(VMDQ_P(0)));
 	vmolr &= ~(WX_PSR_VM_L2CTL_UPE |
 		   WX_PSR_VM_L2CTL_MPE |
 		   WX_PSR_VM_L2CTL_ROPE |
@@ -1330,7 +1546,10 @@ void wx_set_rx_mode(struct net_device *netdev)
 		fctrl |= WX_PSR_CTL_UPE | WX_PSR_CTL_MPE;
 		/* pf don't want packets routing to vf, so clear UPE */
 		vmolr |= WX_PSR_VM_L2CTL_MPE;
-		vlnctrl &= ~WX_PSR_VLAN_CTL_VFE;
+		if (test_bit(WX_FLAG_VMDQ_ENABLED, wx->flags) &&
+		    test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags))
+			vlnctrl |= WX_PSR_VLAN_CTL_VFE;
+		features &= ~NETIF_F_HW_VLAN_CTAG_FILTER;
 	}
 
 	if (netdev->flags & IFF_ALLMULTI) {
@@ -1353,7 +1572,7 @@ void wx_set_rx_mode(struct net_device *netdev)
 	 * sufficient space to store all the addresses then enable
 	 * unicast promiscuous mode
 	 */
-	count = wx_write_uc_addr_list(netdev, 0);
+	count = wx_write_uc_addr_list(netdev, VMDQ_P(0));
 	if (count < 0) {
 		vmolr &= ~WX_PSR_VM_L2CTL_ROPE;
 		vmolr |= WX_PSR_VM_L2CTL_UPE;
@@ -1371,7 +1590,7 @@ void wx_set_rx_mode(struct net_device *netdev)
 
 	wr32(wx, WX_PSR_VLAN_CTL, vlnctrl);
 	wr32(wx, WX_PSR_CTL, fctrl);
-	wr32(wx, WX_PSR_VM_L2CTL(0), vmolr);
+	wr32(wx, WX_PSR_VM_L2CTL(VMDQ_P(0)), vmolr);
 
 	if ((features & NETIF_F_HW_VLAN_CTAG_RX) &&
 	    (features & NETIF_F_HW_VLAN_STAG_RX))
@@ -1379,6 +1598,10 @@ void wx_set_rx_mode(struct net_device *netdev)
 	else
 		wx_vlan_strip_control(wx, false);
 
+	if (features & NETIF_F_HW_VLAN_CTAG_FILTER)
+		wx_vlan_promisc_disable(wx);
+	else
+		wx_vlan_promisc_enable(wx);
 }
 EXPORT_SYMBOL(wx_set_rx_mode);
 
@@ -1621,6 +1844,13 @@ static void wx_setup_reta(struct wx *wx)
 	u32 random_key_size = WX_RSS_KEY_SIZE / 4;
 	u32 i, j;
 
+	if (test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags)) {
+		if (wx->mac.type == wx_mac_sp)
+			rss_i = rss_i < 4 ? 4 : rss_i;
+		else if (wx->mac.type == wx_mac_em)
+			rss_i = 1;
+	}
+
 	/* Fill out hash function seeds */
 	for (i = 0; i < random_key_size; i++)
 		wr32(wx, WX_RDB_RSSRK(i), wx->rss_key[i]);
@@ -1638,10 +1868,40 @@ static void wx_setup_reta(struct wx *wx)
 	wx_store_reta(wx);
 }
 
+static void wx_setup_psrtype(struct wx *wx)
+{
+	int rss_i = wx->ring_feature[RING_F_RSS].indices;
+	u32 psrtype;
+	int pool;
+
+	psrtype = WX_RDB_PL_CFG_L4HDR |
+		  WX_RDB_PL_CFG_L3HDR |
+		  WX_RDB_PL_CFG_L2HDR |
+		  WX_RDB_PL_CFG_TUN_OUTL2HDR |
+		  WX_RDB_PL_CFG_TUN_TUNHDR;
+
+	if (wx->mac.type == wx_mac_sp) {
+		if (rss_i > 3)
+			psrtype |= FIELD_PREP(GENMASK(31, 29), 2);
+		else if (rss_i > 1)
+			psrtype |= FIELD_PREP(GENMASK(31, 29), 1);
+
+		for_each_set_bit(pool, &wx->fwd_bitmask, 32)
+			wr32(wx, WX_RDB_PL_CFG(VMDQ_P(pool)), psrtype);
+	} else {
+		for_each_set_bit(pool, &wx->fwd_bitmask, 8)
+			wr32(wx, WX_RDB_PL_CFG(VMDQ_P(pool)), psrtype);
+	}
+}
+
 static void wx_setup_mrqc(struct wx *wx)
 {
 	u32 rss_field = 0;
 
+	/* VT, and RSS do not coexist at the same time */
+	if (test_bit(WX_FLAG_VMDQ_ENABLED, wx->flags))
+		return;
+
 	/* Disable indicating checksum in descriptor, enables RSS hash */
 	wr32m(wx, WX_PSR_CTL, WX_PSR_CTL_PCSD, WX_PSR_CTL_PCSD);
 
@@ -1671,16 +1931,11 @@ static void wx_setup_mrqc(struct wx *wx)
  **/
 void wx_configure_rx(struct wx *wx)
 {
-	u32 psrtype, i;
 	int ret;
+	u32 i;
 
 	wx_disable_rx(wx);
-
-	psrtype = WX_RDB_PL_CFG_L4HDR |
-		  WX_RDB_PL_CFG_L3HDR |
-		  WX_RDB_PL_CFG_L2HDR |
-		  WX_RDB_PL_CFG_TUN_TUNHDR;
-	wr32(wx, WX_RDB_PL_CFG(0), psrtype);
+	wx_setup_psrtype(wx);
 
 	/* enable hw crc stripping */
 	wr32m(wx, WX_RSC_CTL, WX_RSC_CTL_CRC_STRIP, WX_RSC_CTL_CRC_STRIP);
@@ -1728,6 +1983,7 @@ void wx_configure(struct wx *wx)
 {
 	wx_set_rxpba(wx);
 	wx_pbthresh_setup(wx);
+	wx_configure_virtualization(wx);
 	wx_configure_port(wx);
 
 	wx_set_rx_mode(wx->netdev);
@@ -2080,7 +2336,7 @@ static int wx_set_vlvf(struct wx *wx, u32 vlan, u32 vind, bool vlan_on,
  *
  *  Turn on/off specified VLAN in the VLAN filter table.
  **/
-static int wx_set_vfta(struct wx *wx, u32 vlan, u32 vind, bool vlan_on)
+int wx_set_vfta(struct wx *wx, u32 vlan, u32 vind, bool vlan_on)
 {
 	u32 bitindex, vfta, targetbit;
 	bool vfta_changed = false;
@@ -2126,6 +2382,7 @@ static int wx_set_vfta(struct wx *wx, u32 vlan, u32 vind, bool vlan_on)
 
 	return 0;
 }
+EXPORT_SYMBOL(wx_set_vfta);
 
 /**
  *  wx_clear_vfta - Clear VLAN filter table
@@ -2150,6 +2407,27 @@ static void wx_clear_vfta(struct wx *wx)
 	}
 }
 
+/**
+ *  wx_set_vlan_anti_spoofing - Enable/Disable VLAN anti-spoofing
+ *  @wx: pointer to hardware structure
+ *  @enable: enable or disable switch for VLAN anti-spoofing
+ *  @vf: Virtual Function pool - VF Pool to set for VLAN anti-spoofing
+ *
+ **/
+void wx_set_vlan_anti_spoofing(struct wx *wx, bool enable, int vf)
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
+EXPORT_SYMBOL(wx_set_vlan_anti_spoofing);
+
 int wx_vlan_rx_add_vid(struct net_device *netdev,
 		       __be16 proto, u16 vid)
 {
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.h b/drivers/net/ethernet/wangxun/libwx/wx_hw.h
index 9e219fa717a2..ac9387a43002 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.h
@@ -24,11 +24,15 @@ int wx_read_ee_hostif_buffer(struct wx *wx,
 void wx_init_eeprom_params(struct wx *wx);
 void wx_get_mac_addr(struct wx *wx, u8 *mac_addr);
 void wx_init_rx_addrs(struct wx *wx);
+void wx_full_sync_mac_table(struct wx *wx);
 void wx_mac_set_default_filter(struct wx *wx, u8 *addr);
+int wx_add_mac_filter(struct wx *wx, u8 *addr, u16 pool);
+int wx_del_mac_filter(struct wx *wx, u8 *addr, u16 pool);
 void wx_flush_sw_mac_table(struct wx *wx);
 int wx_set_mac(struct net_device *netdev, void *p);
 void wx_disable_rx(struct wx *wx);
 void wx_set_rx_mode(struct net_device *netdev);
+void wx_configure_virtualization(struct wx *wx);
 int wx_change_mtu(struct net_device *netdev, int new_mtu);
 void wx_disable_rx_queue(struct wx *wx, struct wx_ring *ring);
 void wx_configure_rx(struct wx *wx);
@@ -39,6 +43,8 @@ int wx_stop_adapter(struct wx *wx);
 void wx_reset_misc(struct wx *wx);
 int wx_get_pcie_msix_counts(struct wx *wx, u16 *msix_count, u16 max_msix_count);
 int wx_sw_init(struct wx *wx);
+int wx_set_vfta(struct wx *wx, u32 vlan, u32 vind, bool vlan_on);
+void wx_set_vlan_anti_spoofing(struct wx *wx, bool enable, int vf);
 int wx_vlan_rx_add_vid(struct net_device *netdev, __be16 proto, u16 vid);
 int wx_vlan_rx_kill_vid(struct net_device *netdev, __be16 proto, u16 vid);
 int wx_fc_enable(struct wx *wx, bool tx_pause, bool rx_pause);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 6dff2c85682d..f15af24ad795 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -1558,6 +1558,73 @@ void wx_napi_disable_all(struct wx *wx)
 }
 EXPORT_SYMBOL(wx_napi_disable_all);
 
+/**
+ * wx_set_vmdq_queues: Allocate queues for VMDq devices
+ * @wx: board private structure to initialize
+ *
+ * When VMDq (Virtual Machine Devices queue) is enabled, allocate queues
+ * and VM pools where appropriate.  If RSS is available, then also try and
+ * enable RSS and map accordingly.
+ **/
+static bool wx_set_vmdq_queues(struct wx *wx)
+{
+	u16 vmdq_i = wx->ring_feature[RING_F_VMDQ].limit;
+	u16 rss_i = wx->ring_feature[RING_F_RSS].limit;
+	u16 rss_m = WX_RSS_DISABLED_MASK;
+	u16 vmdq_m = 0;
+
+	/* only proceed if VMDq is enabled */
+	if (!test_bit(WX_FLAG_VMDQ_ENABLED, wx->flags))
+		return false;
+	/* Add starting offset to total pool count */
+	vmdq_i += wx->ring_feature[RING_F_VMDQ].offset;
+
+	if (wx->mac.type == wx_mac_sp) {
+		/* double check we are limited to maximum pools */
+		vmdq_i = min_t(u16, 64, vmdq_i);
+
+		/* 64 pool mode with 2 queues per pool, or
+		 * 16/32/64 pool mode with 1 queue per pool
+		 */
+		if (vmdq_i > 32 || rss_i < 4) {
+			vmdq_m = WX_VMDQ_2Q_MASK;
+			rss_m = WX_RSS_2Q_MASK;
+			rss_i = min_t(u16, rss_i, 2);
+		/* 32 pool mode with 4 queues per pool */
+		} else {
+			vmdq_m = WX_VMDQ_4Q_MASK;
+			rss_m = WX_RSS_4Q_MASK;
+			rss_i = 4;
+		}
+	} else {
+		/* double check we are limited to maximum pools */
+		vmdq_i = min_t(u16, 8, vmdq_i);
+
+		/* when VMDQ on, disable RSS */
+		rss_i = 1;
+	}
+
+	/* remove the starting offset from the pool count */
+	vmdq_i -= wx->ring_feature[RING_F_VMDQ].offset;
+
+	/* save features for later use */
+	wx->ring_feature[RING_F_VMDQ].indices = vmdq_i;
+	wx->ring_feature[RING_F_VMDQ].mask = vmdq_m;
+
+	/* limit RSS based on user input and save for later use */
+	wx->ring_feature[RING_F_RSS].indices = rss_i;
+	wx->ring_feature[RING_F_RSS].mask = rss_m;
+
+	wx->queues_per_pool = rss_i;/*maybe same to num_rx_queues_per_pool*/
+	wx->num_rx_pools = vmdq_i;
+	wx->num_rx_queues_per_pool = rss_i;
+
+	wx->num_rx_queues = vmdq_i * rss_i;
+	wx->num_tx_queues = vmdq_i * rss_i;
+
+	return true;
+}
+
 /**
  * wx_set_rss_queues: Allocate queues for RSS
  * @wx: board private structure to initialize
@@ -1574,6 +1641,11 @@ static void wx_set_rss_queues(struct wx *wx)
 	f = &wx->ring_feature[RING_F_RSS];
 	f->indices = f->limit;
 
+	if (wx->mac.type == wx_mac_sp)
+		f->mask = WX_RSS_64Q_MASK;
+	else
+		f->mask = WX_RSS_8Q_MASK;
+
 	wx->num_rx_queues = f->limit;
 	wx->num_tx_queues = f->limit;
 }
@@ -1585,6 +1657,9 @@ static void wx_set_num_queues(struct wx *wx)
 	wx->num_tx_queues = 1;
 	wx->queues_per_pool = 1;
 
+	if (wx_set_vmdq_queues(wx))
+		return;
+
 	wx_set_rss_queues(wx);
 }
 
@@ -1665,6 +1740,10 @@ static int wx_set_interrupt_capability(struct wx *wx)
 	if (ret == 0 || (ret == -ENOMEM))
 		return ret;
 
+	/* Disable VMDq support */
+	dev_warn(&wx->pdev->dev, "Disabling VMQQ support\n");
+	clear_bit(WX_FLAG_VMDQ_ENABLED, wx->flags);
+
 	/* Disable RSS */
 	dev_warn(&wx->pdev->dev, "Disabling RSS support\n");
 	wx->ring_feature[RING_F_RSS].limit = 1;
@@ -1690,6 +1769,58 @@ static int wx_set_interrupt_capability(struct wx *wx)
 	return 0;
 }
 
+/**
+ * wx_cache_ring_vmdq - Descriptor ring to register mapping for VMDq
+ * @wx: board private structure to initialize
+ *
+ * Cache the descriptor ring offsets for VMDq to the assigned rings.  It
+ * will also try to cache the proper offsets if RSS/FCoE/SRIOV are enabled along
+ * with VMDq.
+ *
+ **/
+static bool wx_cache_ring_vmdq(struct wx *wx)
+{
+	struct wx_ring_feature *vmdq = &wx->ring_feature[RING_F_VMDQ];
+	struct wx_ring_feature *rss = &wx->ring_feature[RING_F_RSS];
+	u16 reg_idx;
+	int i;
+
+	/* only proceed if VMDq is enabled */
+	if (!test_bit(WX_FLAG_VMDQ_ENABLED, wx->flags))
+		return false;
+
+	if (wx->mac.type == wx_mac_sp) {
+		/* start at VMDq register offset for SR-IOV enabled setups */
+		reg_idx = vmdq->offset * __ALIGN_MASK(1, ~vmdq->mask);
+		for (i = 0; i < wx->num_rx_queues; i++, reg_idx++) {
+			/* If we are greater than indices move to next pool */
+			if ((reg_idx & ~vmdq->mask) >= rss->indices)
+				reg_idx = __ALIGN_MASK(reg_idx, ~vmdq->mask);
+			wx->rx_ring[i]->reg_idx = reg_idx;
+		}
+		reg_idx = vmdq->offset * __ALIGN_MASK(1, ~vmdq->mask);
+		for (i = 0; i < wx->num_tx_queues; i++, reg_idx++) {
+			/* If we are greater than indices move to next pool */
+			if ((reg_idx & rss->mask) >= rss->indices)
+				reg_idx = __ALIGN_MASK(reg_idx, ~vmdq->mask);
+			wx->tx_ring[i]->reg_idx = reg_idx;
+		}
+	} else {
+		/* start at VMDq register offset for SR-IOV enabled setups */
+		reg_idx = vmdq->offset;
+		for (i = 0; i < wx->num_rx_queues; i++)
+			/* If we are greater than indices move to next pool */
+			wx->rx_ring[i]->reg_idx = reg_idx + i;
+
+		reg_idx = vmdq->offset;
+		for (i = 0; i < wx->num_tx_queues; i++)
+			/* If we are greater than indices move to next pool */
+			wx->tx_ring[i]->reg_idx = reg_idx + i;
+	}
+
+	return true;
+}
+
 /**
  * wx_cache_ring_rss - Descriptor ring to register mapping for RSS
  * @wx: board private structure to initialize
@@ -1701,6 +1832,9 @@ static void wx_cache_ring_rss(struct wx *wx)
 {
 	u16 i;
 
+	if (wx_cache_ring_vmdq(wx))
+		return;
+
 	for (i = 0; i < wx->num_rx_queues; i++)
 		wx->rx_ring[i]->reg_idx = i;
 
@@ -2134,14 +2268,18 @@ void wx_configure_vectors(struct wx *wx)
 {
 	struct pci_dev *pdev = wx->pdev;
 	u32 eitrsel = 0;
-	u16 v_idx;
+	u16 v_idx, i;
 
 	if (pdev->msix_enabled) {
 		/* Populate MSIX to EITR Select */
+		if (wx->mac.type == wx_mac_sp) {
+			if (wx->num_vfs >= 32)
+				eitrsel = BIT(wx->num_vfs % 32) - 1;
+		} else if (wx->mac.type == wx_mac_em) {
+			for (i = 0; i < wx->num_vfs; i++)
+				eitrsel |= BIT(i);
+		}
 		wr32(wx, WX_PX_ITRSEL, eitrsel);
-		/* use EIAM to auto-mask when MSI-X interrupt is asserted
-		 * this saves a register write for every interrupt
-		 */
 		wr32(wx, WX_PX_GPIE, WX_PX_GPIE_MODEL);
 	} else {
 		/* legacy interrupts, use EIAM to auto-mask when reading EICR,
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
index 3d13e1c7e8b7..84410c807e4e 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
@@ -5,6 +5,7 @@
 #include <linux/pci.h>
 
 #include "wx_type.h"
+#include "wx_hw.h"
 #include "wx_mbx.h"
 #include "wx_sriov.h"
 
@@ -102,7 +103,7 @@ static void wx_sriov_reinit(struct wx *wx)
 	rtnl_unlock();
 }
 
-static int wx_disable_sriov(struct wx *wx)
+int wx_disable_sriov(struct wx *wx)
 {
 	/* If our VFs are assigned we cannot shut down SR-IOV
 	 * without causing issues, so just leave the hardware
@@ -137,6 +138,7 @@ static int wx_disable_sriov(struct wx *wx)
 
 	return 0;
 }
+EXPORT_SYMBOL(wx_disable_sriov);
 
 static int wx_pci_sriov_enable(struct pci_dev *dev,
 			       int num_vfs)
@@ -218,3 +220,884 @@ int wx_pci_sriov_configure(struct pci_dev *pdev, int num_vfs)
 	return num_vfs;
 }
 EXPORT_SYMBOL(wx_pci_sriov_configure);
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
+static void wx_clear_vmvir(struct wx *wx, u32 vf)
+{
+	wr32(wx, WX_TDM_VLAN_INS(vf), 0);
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
+static int wx_vf_reset_msg(struct wx *wx, u16 vf)
+{
+	unsigned char *vf_mac = wx->vfinfo[vf].vf_mac_addr;
+	struct net_device *dev = wx->netdev;
+	u32 msgbuf[5] = {0, 0, 0, 0, 0};
+	u8 *addr = (u8 *)(&msgbuf[1]);
+	u32 reg, index, vf_bit;
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
+
+	return 0;
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
+	u16 entries = (msgbuf[0] & WX_VT_MSGINFO_MASK)
+		      >> WX_VT_MSGINFO_SHIFT;
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
+			wx_ndo_set_vf_spoofchk(wx->netdev, vf, false);
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
+static int wx_rcv_msg_from_vf(struct wx *wx, u16 vf)
+{
+	u16 mbx_size = WX_VXMAILBOX_SIZE;
+	u32 msgbuf[WX_VXMAILBOX_SIZE];
+	int retval;
+
+	retval = wx_read_mbx_pf(wx, msgbuf, mbx_size, vf);
+	if (retval) {
+		wx_err(wx, "Error receiving message from VF\n");
+		return retval;
+	}
+
+	/* this is a message we already processed, do nothing */
+	if (msgbuf[0] & (WX_VT_MSGTYPE_ACK | WX_VT_MSGTYPE_NACK))
+		return retval;
+
+	if (msgbuf[0] == WX_VF_RESET)
+		return wx_vf_reset_msg(wx, vf);
+
+	/* until the vf completes a virtual function reset it should not be
+	 * allowed to start any configuration.
+	 */
+	if (!wx->vfinfo[vf].clear_to_send) {
+		msgbuf[0] |= WX_VT_MSGTYPE_NACK;
+		wx_write_mbx_pf(wx, msgbuf, 1, vf);
+		return retval;
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
+			return -EINVAL;
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
+		retval = -EBUSY;
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
+
+	return retval;
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
+	unsigned long flags;
+	u16 vf;
+
+	spin_lock_irqsave(&wx->vfs_lock, flags);
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
+	spin_unlock_irqrestore(&wx->vfs_lock, flags);
+}
+EXPORT_SYMBOL(wx_msg_task);
+
+/**
+ * wx_disable_vf_rx_tx - Set VF rx tx
+ * @wx: Pointer to wx struct
+ *
+ * Set or reset correct transmit and receive for vf
+ **/
+void wx_disable_vf_rx_tx(struct wx *wx)
+{
+	wr32(wx, WX_TDM_VFTE_CLR(0), 0);
+	wr32(wx, WX_RDM_VFRE_CLR(0), 0);
+	if (wx->mac.type == wx_mac_sp) {
+		wr32(wx, WX_TDM_VFTE_CLR(1), 0);
+		wr32(wx, WX_RDM_VFRE_CLR(1), 0);
+	}
+}
+EXPORT_SYMBOL(wx_disable_vf_rx_tx);
+
+static inline void wx_ping_vf(struct wx *wx, int vf)
+{
+	unsigned long flags;
+	u32 ping;
+
+	ping = WX_PF_CONTROL_MSG;
+	if (wx->vfinfo[vf].clear_to_send)
+		ping |= WX_VT_MSGTYPE_CTS;
+	spin_lock_irqsave(&wx->vfs_lock, flags);
+	wx_write_mbx_pf(wx, &ping, 1, vf);
+	spin_unlock_irqrestore(&wx->vfs_lock, flags);
+}
+
+void wx_ping_all_vfs_with_link_status(struct wx *wx, bool link_up)
+{
+	u32 msgbuf[2] = {0, 0};
+	unsigned long flags;
+	u16 i;
+
+	if (!wx->num_vfs)
+		return;
+	msgbuf[0] = WX_PF_NOFITY_VF_LINK_STATUS | WX_PF_CONTROL_MSG;
+	if (link_up)
+		msgbuf[1] = (wx->speed << 1) | link_up;
+	if (wx->vfinfo[i].clear_to_send)
+		msgbuf[0] |= WX_VT_MSGTYPE_CTS;
+	if (wx->notify_not_runnning)
+		msgbuf[1] |= WX_PF_NOFITY_VF_NET_NOT_RUNNING;
+	spin_lock_irqsave(&wx->vfs_lock, flags);
+	for (i = 0 ; i < wx->num_vfs; i++)
+		wx_write_mbx_pf(wx, msgbuf, 2, i);
+	spin_unlock_irqrestore(&wx->vfs_lock, flags);
+}
+EXPORT_SYMBOL(wx_ping_all_vfs_with_link_status);
+
+/**
+ * wx_set_vf_link_state - Set link state
+ * @wx: Pointer to adapter struct
+ * @vf: VF identifier
+ * @state: required link state
+ *
+ * Set a link force state on/off a single vf
+ **/
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
+
+/**
+ * wx_set_all_vfs - update vfs queues
+ * @wx: Pointer to wx struct
+ *
+ * Update setting transmit and receive queues for all vfs
+ **/
+void wx_set_all_vfs(struct wx *wx)
+{
+	int i;
+
+	for (i = 0 ; i < wx->num_vfs; i++)
+		wx_set_vf_link_state(wx, i, wx->vfinfo[i].link_state);
+}
+EXPORT_SYMBOL(wx_set_all_vfs);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.h b/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
index 6aef776b0894..99b497e43f93 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
@@ -5,5 +5,12 @@
 #define _WX_SRIOV_H_
 
 int wx_pci_sriov_configure(struct pci_dev *pdev, int num_vfs);
+int wx_disable_sriov(struct wx *wx);
+int wx_ndo_set_vf_spoofchk(struct net_device *netdev, int vf, bool setting);
+void wx_msg_task(struct wx *wx);
+void wx_disable_vf_rx_tx(struct wx *wx);
+void wx_ping_all_vfs_with_link_status(struct wx *wx, bool link_up);
+int wx_ndo_set_vf_link_state(struct net_device *netdev, int vf, int state);
+void wx_set_all_vfs(struct wx *wx);
 
 #endif /* _WX_SRIOV_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index c1bf8653b900..29427a299edf 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -19,6 +19,7 @@
 #define WX_PCIE_MSIX_TBL_SZ_MASK                0x7FF
 #define WX_PCI_LINK_STATUS                      0xB2
 #define WX_MAX_PF_MACVLANS                      15
+#define WX_MAX_VF_MC_ENTRIES                    30
 
 /**************** Global Registers ****************************/
 /* chip control Registers */
@@ -75,6 +76,10 @@
 #define WX_MAC_LXONOFFRXC            0x11E0C
 
 /*********************** Receive DMA registers **************************/
+/* receive control */
+#define WX_RDM_VF_RE(_i)             (0x12004 + ((_i) * 4))
+#define WX_RDM_VFRE_CLR(_i)          (0x120A0 + ((_i) * 4))
+#define WX_RDM_PF_QDE(_i)            (0x12080 + ((_i) * 4))
 #define WX_RDM_DRP_PKT               0x12500
 #define WX_RDM_PKT_CNT               0x12504
 #define WX_RDM_BYTE_CNT_LSB          0x12508
@@ -83,13 +88,16 @@
 /************************* Port Registers ************************************/
 /* port cfg Registers */
 #define WX_CFG_PORT_CTL              0x14400
+#define WX_CFG_PORT_CTL_PFRSTD       BIT(14)
 #define WX_CFG_PORT_CTL_DRV_LOAD     BIT(3)
 #define WX_CFG_PORT_CTL_QINQ         BIT(2)
 #define WX_CFG_PORT_CTL_D_VLAN       BIT(0) /* double vlan*/
 #define WX_CFG_TAG_TPID(_i)          (0x14430 + ((_i) * 4))
 #define WX_CFG_PORT_CTL_NUM_VT_MASK  GENMASK(13, 12) /* number of TVs */
 
+#define WX_CFG_PORT_CTL_NUM_VT_NONE  0
 #define WX_CFG_PORT_CTL_NUM_VT_8     FIELD_PREP(GENMASK(13, 12), 1)
+#define WX_CFG_PORT_CTL_NUM_VT_16    FIELD_PREP(GENMASK(13, 12), 1)
 #define WX_CFG_PORT_CTL_NUM_VT_32    FIELD_PREP(GENMASK(13, 12), 2)
 #define WX_CFG_PORT_CTL_NUM_VT_64    FIELD_PREP(GENMASK(13, 12), 3)
 
@@ -114,6 +122,8 @@
 /*********************** Transmit DMA registers **************************/
 /* transmit global control */
 #define WX_TDM_CTL                   0x18000
+#define WX_TDM_VF_TE(_i)             (0x18004 + ((_i) * 4))
+#define WX_TDM_VFTE_CLR(_i)          (0x180A0 + ((_i) * 4))
 /* TDM CTL BIT */
 #define WX_TDM_CTL_TE                BIT(0) /* Transmit Enable */
 #define WX_TDM_PB_THRE(_i)           (0x18020 + ((_i) * 4))
@@ -186,12 +196,22 @@
 /* mcasst/ucast overflow tbl */
 #define WX_PSR_MC_TBL(_i)            (0x15200  + ((_i) * 4))
 #define WX_PSR_UC_TBL(_i)            (0x15400 + ((_i) * 4))
+#define WX_PSR_VM_CTL_REPLEN         BIT(30) /* replication enabled */
 #define WX_PSR_VM_CTL_POOL_MASK      GENMASK(12, 7)
 
+/* etype switcher 1st stage */
+/* EType Queue Filter */
+#define WX_PSR_ETYPE_SWC(_i)         (0x15128 + ((_i) * 4))
+#define WX_PSR_ETYPE_SWC_TXANTISPOOF BIT(29)
+#define WX_PSR_ETYPE_SWC_FILTER_EN   BIT(31)
+#define WX_PSR_ETYPE_SWC_FILTER_LLDP 5
+#define WX_PSR_ETYPE_SWC_FILTER_FC   7
+
 /* VM L2 contorl */
 #define WX_PSR_VM_L2CTL(_i)          (0x15600 + ((_i) * 4))
 #define WX_PSR_VM_L2CTL_UPE          BIT(4) /* unicast promiscuous */
 #define WX_PSR_VM_L2CTL_VACC         BIT(6) /* accept nomatched vlan */
+#define WX_PSR_VM_L2CTL_VPE          BIT(7) /* vlan promiscuous mode */
 #define WX_PSR_VM_L2CTL_AUPE         BIT(8) /* accept untagged packets */
 #define WX_PSR_VM_L2CTL_ROMPE        BIT(9) /* accept packets in MTA tbl */
 #define WX_PSR_VM_L2CTL_ROPE         BIT(10) /* accept packets in UC tbl */
@@ -230,10 +250,12 @@
 #define WX_PSR_VLAN_SWC              0x16220
 #define WX_PSR_VLAN_SWC_VM_L         0x16224
 #define WX_PSR_VLAN_SWC_VM_H         0x16228
+#define WX_PSR_VLAN_SWC_VM(_i)       (0x16224 + ((_i) * 4))
 #define WX_PSR_VLAN_SWC_IDX          0x16230         /* 64 vlan entries */
 /* VLAN pool filtering masks */
 #define WX_PSR_VLAN_SWC_VIEN         BIT(31)  /* filter is valid */
 #define WX_PSR_VLAN_SWC_ENTRIES      64
+#define WX_PSR_VLAN_SWC_VLANID_MASK  GENMASK(11, 0)
 
 /********************************* RSEC **************************************/
 /* general rsec */
@@ -244,6 +266,15 @@
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
@@ -283,6 +314,9 @@
 #define WX_MAC_WDG_TIMEOUT           0x1100C
 #define WX_MAC_RX_FLOW_CTRL          0x11090
 #define WX_MAC_RX_FLOW_CTRL_RFE      BIT(0) /* receive fc enable */
+
+#define WX_MAC_WDG_TIMEOUT_WTO_MASK  GENMASK(3, 0)
+#define WX_MAC_WDG_TIMEOUT_WTO_DELTA 2
 /* MDIO Registers */
 #define WX_MSCA                      0x11200
 #define WX_MSCA_RA(v)                FIELD_PREP(U16_MAX, v)
@@ -371,6 +405,15 @@ enum WX_MSCA_CMD_value {
 /* Number of 80 microseconds we wait for PCI Express master disable */
 #define WX_PCI_MASTER_DISABLE_TIMEOUT        80000
 
+#define WX_RSS_64Q_MASK              0x3F
+#define WX_RSS_8Q_MASK               0x7
+#define WX_RSS_4Q_MASK               0x3
+#define WX_RSS_2Q_MASK               0x1
+#define WX_RSS_DISABLED_MASK         0x0
+
+#define WX_VMDQ_4Q_MASK              0x7C
+#define WX_VMDQ_2Q_MASK              0x7E
+
 /****************** Manageablility Host Interface defines ********************/
 #define WX_HI_MAX_BLOCK_BYTE_LENGTH  256 /* Num of bytes in range */
 #define WX_HI_COMMAND_TIMEOUT        1000 /* Process HI command limit */
@@ -435,7 +478,12 @@ enum WX_MSCA_CMD_value {
 #define WX_REQ_TX_DESCRIPTOR_MULTIPLE   8
 
 #define WX_MAX_JUMBO_FRAME_SIZE      9432 /* max payload 9414 */
-#define VMDQ_P(p)                    p
+/* must account for pools assigned to VFs. */
+#ifdef CONFIG_PCI_IOV
+#define VMDQ_P(p)       ((p) + wx->ring_feature[RING_F_VMDQ].offset)
+#else
+#define VMDQ_P(p)       (p)
+#endif
 
 /* Supported Rx Buffer Sizes */
 #define WX_RXBUFFER_256      256    /* Used for skb receive header */
@@ -1000,6 +1048,16 @@ struct vf_data_storage {
 	bool link_enable;
 	bool trusted;
 	int xcast_mode;
+	unsigned int vf_api;
+	bool clear_to_send;
+	u16 pf_vlan; /* When set, guest VLAN config not allowed. */
+	u16 pf_qos;
+	bool pf_set_mac;
+
+	u16 vf_mc_hashes[WX_MAX_VF_MC_ENTRIES];
+	u16 num_vf_mc_hashes;
+	u16 vlan_count;
+	int link_state;
 };
 
 struct vf_macvlans {
@@ -1012,7 +1070,9 @@ struct vf_macvlans {
 
 enum wx_pf_flags {
 	WX_FLAG_VMDQ_ENABLED,
+	WX_FLAG2_VLAN_PROMISC,
 	WX_FLAG_SRIOV_ENABLED,
+	WX_FLAG_SRIOV_VEPA_BRIDGE_MODE,
 	WX_PF_FLAGS_NBITS		/* must be last */
 };
 
@@ -1048,6 +1108,7 @@ struct wx {
 	enum wx_reset_type reset_type;
 
 	/* PHY stuff */
+	bool notify_not_runnning;
 	unsigned int link;
 	int speed;
 	int duplex;
@@ -1079,6 +1140,8 @@ struct wx {
 	struct wx_ring *tx_ring[64] ____cacheline_aligned_in_smp;
 	struct wx_ring *rx_ring[64];
 	struct wx_q_vector *q_vector[64];
+	int num_rx_pools; /* does not include pools assigned to VFs */
+	int num_rx_queues_per_pool;
 
 	unsigned int queues_per_pool;
 	struct msix_entry *msix_q_entries;
@@ -1099,6 +1162,7 @@ struct wx {
 	u32 wol;
 
 	u16 bd_number;
+	bool default_up;
 
 	struct wx_hw_stats stats;
 	u64 tx_busy;
@@ -1109,10 +1173,12 @@ struct wx {
 	u64 alloc_rx_buff_failed;
 
 	unsigned int num_vfs;
+	/* To lock recv msg_task and send msg_task */
+	spinlock_t vfs_lock;
 	struct vf_data_storage *vfinfo;
 	struct vf_macvlans vf_mvs;
 	struct vf_macvlans *mv_list;
-
+	unsigned long fwd_bitmask; /* bitmask indicating in use pools */
 	int (*setup_tc)(struct net_device *netdev, u8 tc);
 };
 
-- 
2.43.2


