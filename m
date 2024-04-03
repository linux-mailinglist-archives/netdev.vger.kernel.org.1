Return-Path: <netdev+bounces-84344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7AE896A81
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 11:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC311C24DC0
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 09:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19A71327F9;
	Wed,  3 Apr 2024 09:28:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D472113475B
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 09:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712136484; cv=none; b=mMaYA3dlGhjmfqc9AT78LgmxtQjWOV4axC+KDS4GQw1v/t4TE3dyxgGNnJHjJDBlDVJ+sFfPRbR2us1HC3b7w6pbJFMJ/hknk0uxOecjPk6dQCIDzeq6pU9vw6pkCcZnlY1w23V5StFhfu38pOb4FIoMQTpLo6+E+//axdrsyG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712136484; c=relaxed/simple;
	bh=PrCPpzgIOKQ/5tUsNaF+Ck6n937qQT10nu6jePq0l54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8rJJO5yFqIGKwzJRASz7ahOfvmTSnZhGnJ+UzrT88EBbI8yP/kdgvKTKfR1dEw50WVgu9ZbzkJCrDS3rQeVJLOcfa2Du17+E5dKbdkEnhzmlq858f1C/u4u7O1UoktRIZ11sExgDZWX07Wm2CiIg1uCTdMUoEY8qxVqEiqRqo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtpsz9t1712136467tfldiyr
X-QQ-Originating-IP: DWX1YigIUl/o/e05m/yYCRrPtVwEJPg0QwljAEZdc7M=
Received: from localhost.localdomain ( [36.24.97.137])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Apr 2024 17:27:46 +0800 (CST)
X-QQ-SSF: 01400000000000O0Z000000A0000000
X-QQ-FEAT: +ynUkgUhZJnobuJISqktihreJmZjZ6niedhGbvwUE+A5Fv8l/DWHDzmlD89xd
	345w+Ea3OBoC018REwxy3nxYImyjqylh24jm1IeBkpUAvkwPChoCaA5D/SzfjDIn+FUNbS2
	aXNgEsxtOvoR7hJLikoUaTLGoX1CvGDQB14HsVf/wms8fHYRmgzECGjVwcxulUJZuIVu/yL
	a/157iUayTxmivDwcIG/PbzYtjdKFOHAoEKm/7aH31CshKM+/dAzOlZsvRyIB9r238Hz42D
	KkOj+XHDHcKFBsA0XH7r/wrOJaHG0c9qSh0cHN0duAHrUF8ogqG7VACy48SKbRoUKsnGP0I
	bAv3sJLckmNOay8eFIlu5AOFwLbl9lRGulMbjUd37T+pJD12wnVUiTWaGdM2PAk77mTlhDb
	XPP9JXwohPHutcnCkuK6jg==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 8025015621170279230
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v2 4/7] net: libwx: Redesign flow when sriov is enabled
Date: Wed,  3 Apr 2024 17:10:01 +0800
Message-ID: <834ADB284824D6A9+20240403092714.3027-5-mengyuanlou@net-swift.com>
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

Reallocate queue and int resources when sriov is enabled.
Redefine macro VMDQ to make it work in VT mode.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_hw.c   | 280 ++++++++++++++++++-
 drivers/net/ethernet/wangxun/libwx/wx_lib.c  | 146 +++++++++-
 drivers/net/ethernet/wangxun/libwx/wx_type.h |  27 +-
 3 files changed, 435 insertions(+), 18 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
index fd04386a7580..b597b6329bb5 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_hw.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_hw.c
@@ -10,6 +10,7 @@
 
 #include "wx_type.h"
 #include "wx_lib.h"
+#include "wx_sriov.h"
 #include "wx_hw.h"
 
 static int wx_phy_read_reg_mdi(struct mii_bus *bus, int phy_addr, int devnum, int regnum)
@@ -804,11 +805,28 @@ static void wx_sync_mac_table(struct wx *wx)
 	}
 }
 
+static void wx_full_sync_mac_table(struct wx *wx)
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
@@ -1048,6 +1066,35 @@ static void wx_update_mc_addr_list(struct wx *wx, struct net_device *netdev)
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
@@ -1065,6 +1112,9 @@ static int wx_write_mc_addr_list(struct net_device *netdev)
 
 	wx_update_mc_addr_list(wx, netdev);
 
+	if (test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags))
+		wx_restore_vf_multicasts(wx);
+
 	return netdev_mc_count(netdev);
 }
 
@@ -1085,7 +1135,7 @@ int wx_set_mac(struct net_device *netdev, void *p)
 	if (retval)
 		return retval;
 
-	wx_del_mac_filter(wx, wx->mac.addr, 0);
+	wx_del_mac_filter(wx, wx->mac.addr, VMDQ_P(0));
 	eth_hw_addr_set(netdev, addr->sa_data);
 	memcpy(wx->mac.addr, addr->sa_data, netdev->addr_len);
 
@@ -1180,6 +1230,10 @@ static int wx_hpbthresh(struct wx *wx)
 	/* Calculate delay value for device */
 	dv_id = WX_DV(link, tc);
 
+	/* Loopback switch introduces additional latency */
+	if (test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags))
+		dv_id += WX_B2BT(tc);
+
 	/* Delay value is calculated in bit times convert to KB */
 	kb = WX_BT2KB(dv_id);
 	rx_pba = rd32(wx, WX_RDB_PB_SZ(0)) >> WX_RDB_PB_SZ_SHIFT;
@@ -1235,12 +1289,93 @@ static void wx_pbthresh_setup(struct wx *wx)
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
+static void wx_configure_virtualization(struct wx *wx)
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
+		wr32m(wx, WX_PSR_VM_L2CTL(pool), WX_PSR_VM_L2CTL_AUPE, WX_PSR_VM_L2CTL_AUPE);
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
@@ -1299,6 +1434,83 @@ static void wx_vlan_strip_control(struct wx *wx, bool enable)
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
@@ -1311,7 +1523,7 @@ void wx_set_rx_mode(struct net_device *netdev)
 	/* Check for Promiscuous and All Multicast modes */
 	fctrl = rd32(wx, WX_PSR_CTL);
 	fctrl &= ~(WX_PSR_CTL_UPE | WX_PSR_CTL_MPE);
-	vmolr = rd32(wx, WX_PSR_VM_L2CTL(0));
+	vmolr = rd32(wx, WX_PSR_VM_L2CTL(VMDQ_P(0)));
 	vmolr &= ~(WX_PSR_VM_L2CTL_UPE |
 		   WX_PSR_VM_L2CTL_MPE |
 		   WX_PSR_VM_L2CTL_ROPE |
@@ -1332,7 +1544,10 @@ void wx_set_rx_mode(struct net_device *netdev)
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
@@ -1355,7 +1570,7 @@ void wx_set_rx_mode(struct net_device *netdev)
 	 * sufficient space to store all the addresses then enable
 	 * unicast promiscuous mode
 	 */
-	count = wx_write_uc_addr_list(netdev, 0);
+	count = wx_write_uc_addr_list(netdev, VMDQ_P(0));
 	if (count < 0) {
 		vmolr &= ~WX_PSR_VM_L2CTL_ROPE;
 		vmolr |= WX_PSR_VM_L2CTL_UPE;
@@ -1373,7 +1588,7 @@ void wx_set_rx_mode(struct net_device *netdev)
 
 	wr32(wx, WX_PSR_VLAN_CTL, vlnctrl);
 	wr32(wx, WX_PSR_CTL, fctrl);
-	wr32(wx, WX_PSR_VM_L2CTL(0), vmolr);
+	wr32(wx, WX_PSR_VM_L2CTL(VMDQ_P(0)), vmolr);
 
 	if ((features & NETIF_F_HW_VLAN_CTAG_RX) &&
 	    (features & NETIF_F_HW_VLAN_STAG_RX))
@@ -1381,6 +1596,10 @@ void wx_set_rx_mode(struct net_device *netdev)
 	else
 		wx_vlan_strip_control(wx, false);
 
+	if (features & NETIF_F_HW_VLAN_CTAG_FILTER)
+		wx_vlan_promisc_disable(wx);
+	else
+		wx_vlan_promisc_enable(wx);
 }
 EXPORT_SYMBOL(wx_set_rx_mode);
 
@@ -1623,6 +1842,13 @@ static void wx_setup_reta(struct wx *wx)
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
@@ -1640,10 +1866,40 @@ static void wx_setup_reta(struct wx *wx)
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
 
@@ -1673,16 +1929,11 @@ static void wx_setup_mrqc(struct wx *wx)
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
@@ -1730,6 +1981,7 @@ void wx_configure(struct wx *wx)
 {
 	wx_set_rxpba(wx);
 	wx_pbthresh_setup(wx);
+	wx_configure_virtualization(wx);
 	wx_configure_port(wx);
 
 	wx_set_rx_mode(wx->netdev);
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index 6dff2c85682d..b8fc4f45e4a5 100644
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
 
@@ -2089,7 +2223,8 @@ static void wx_set_ivar(struct wx *wx, s8 direction,
 		wr32(wx, WX_PX_MISC_IVAR, ivar);
 	} else {
 		/* tx or rx causes */
-		msix_vector += 1; /* offset for queue vectors */
+		if (!(wx->mac.type == wx_mac_em && wx->num_vfs == 7))
+			msix_vector += 1; /* offset for queue vectors */
 		msix_vector |= WX_PX_IVAR_ALLOC_VAL;
 		index = ((16 * (queue & 1)) + (8 * direction));
 		ivar = rd32(wx, WX_PX_IVAR(queue >> 1));
@@ -2134,10 +2269,17 @@ void wx_configure_vectors(struct wx *wx)
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
 		/* use EIAM to auto-mask when MSI-X interrupt is asserted
 		 * this saves a register write for every interrupt
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index 2e2b997f4572..b0ad9832af3a 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -19,6 +19,7 @@
 #define WX_PCIE_MSIX_TBL_SZ_MASK                0x7FF
 #define WX_PCI_LINK_STATUS                      0xB2
 #define WX_MAX_PF_MACVLANS                      15
+#define WX_MAX_VF_MC_ENTRIES                    30
 
 /**************** Global Registers ****************************/
 /* chip control Registers */
@@ -93,6 +94,7 @@
 #define WX_CFG_TAG_TPID(_i)          (0x14430 + ((_i) * 4))
 #define WX_CFG_PORT_CTL_NUM_VT_MASK  GENMASK(13, 12) /* number of TVs */
 
+#define WX_CFG_PORT_CTL_NUM_VT_NONE  0
 #define WX_CFG_PORT_CTL_NUM_VT_8     FIELD_PREP(GENMASK(13, 12), 1)
 #define WX_CFG_PORT_CTL_NUM_VT_32    FIELD_PREP(GENMASK(13, 12), 2)
 #define WX_CFG_PORT_CTL_NUM_VT_64    FIELD_PREP(GENMASK(13, 12), 3)
@@ -193,6 +195,7 @@
 /* mcasst/ucast overflow tbl */
 #define WX_PSR_MC_TBL(_i)            (0x15200  + ((_i) * 4))
 #define WX_PSR_UC_TBL(_i)            (0x15400 + ((_i) * 4))
+#define WX_PSR_VM_CTL_REPLEN         BIT(30) /* replication enabled */
 #define WX_PSR_VM_CTL_POOL_MASK      GENMASK(12, 7)
 
 /* VM L2 contorl */
@@ -237,6 +240,7 @@
 #define WX_PSR_VLAN_SWC              0x16220
 #define WX_PSR_VLAN_SWC_VM_L         0x16224
 #define WX_PSR_VLAN_SWC_VM_H         0x16228
+#define WX_PSR_VLAN_SWC_VM(_i)       (0x16224 + ((_i) * 4))
 #define WX_PSR_VLAN_SWC_IDX          0x16230         /* 64 vlan entries */
 /* VLAN pool filtering masks */
 #define WX_PSR_VLAN_SWC_VIEN         BIT(31)  /* filter is valid */
@@ -387,6 +391,15 @@ enum WX_MSCA_CMD_value {
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
@@ -451,7 +464,12 @@ enum WX_MSCA_CMD_value {
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
@@ -1021,6 +1039,8 @@ struct vf_data_storage {
 	u16 pf_qos;
 	bool pf_set_mac;
 
+	u16 vf_mc_hashes[WX_MAX_VF_MC_ENTRIES];
+	u16 num_vf_mc_hashes;
 	u16 vlan_count;
 	int link_state;
 };
@@ -1035,6 +1055,7 @@ struct vf_macvlans {
 
 enum wx_pf_flags {
 	WX_FLAG_VMDQ_ENABLED,
+	WX_FLAG2_VLAN_PROMISC,
 	WX_FLAG_SRIOV_ENABLED,
 	WX_PF_FLAGS_NBITS		/* must be last */
 };
@@ -1102,6 +1123,8 @@ struct wx {
 	struct wx_ring *tx_ring[64] ____cacheline_aligned_in_smp;
 	struct wx_ring *rx_ring[64];
 	struct wx_q_vector *q_vector[64];
+	int num_rx_pools; /* does not include pools assigned to VFs */
+	int num_rx_queues_per_pool;
 
 	unsigned int queues_per_pool;
 	struct msix_entry *msix_q_entries;
@@ -1135,7 +1158,7 @@ struct wx {
 	struct vf_data_storage *vfinfo;
 	struct vf_macvlans vf_mvs;
 	struct vf_macvlans *mv_list;
-
+	unsigned long fwd_bitmask; /* bitmask indicating in use pools */
 	int (*setup_tc)(struct net_device *netdev, u8 tc);
 };
 
-- 
2.43.2


