Return-Path: <netdev+bounces-84343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B50C896A80
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 11:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E871F26DC2
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 09:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8C5131BC9;
	Wed,  3 Apr 2024 09:28:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg156.qq.com (smtpbg156.qq.com [15.184.82.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72229130A64
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 09:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.82.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712136483; cv=none; b=MtVIDW4dexEQf3Crus0o+U8/Mn7E9fO5nOoxLTWVzw4XAYkoB3jn8ue2gPPnmyrIEtbMBtQqVDmbrThSApXORp2PaVEh6Cl4pb6r/asUTqa4MX5k4aZ4bI6icS4s1u/ezPIf4RYm3eNgcGn6MTYntH2rRDlirsC5ESUQV/i7jbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712136483; c=relaxed/simple;
	bh=GK7193iXEhFN7rcTqnRCoP18HUoAKXzF6tmrRlfxAOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NR6I/Upy3PcKCOFdMEnamOIwZRDAVqcw77W8p0AKscsnqWb/ysHJMm71M8rdMsO2Dh5eFxsN+7qMEpREGbuJU8R72PhoUQm6gm9puhbxC0GWrGobvB8s5At68HaI/D1q2S/PIQqnukY6DGMRnD/cstJg0Zgg3rzHBFaOIHNBpIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=15.184.82.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtpsz9t1712136471tmrk453
X-QQ-Originating-IP: oSPFla+EaVkHAogMuy3WFX+smbRHpvu6gG4vgtglxXs=
Received: from localhost.localdomain ( [36.24.97.137])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Apr 2024 17:27:50 +0800 (CST)
X-QQ-SSF: 01400000000000O0Z000000A0000000
X-QQ-FEAT: CUshK5VlFGkqcuCAo5LZw1zNhaRzMeAibAN/oIHx+WgKjriCxGov8rxuMBFIz
	VzsnTZaELRz1vMsEThj5JNHjhAyhu4+pCYxof4cQErgD0nsalJRDx1pxjnGptu4pOadwmvH
	iPIOenwIfCUguZVX/PdfWlwYq1mV5RKbnIz2CRxw47HyUJpNywpxq2mef1yjKLuhIqj/hhS
	ds9Iw1vbXW36/aZEKHRBcVNSOr0DQ6Ju+jAWwFElZPMzd1lG2EiyNRTZfkjfd8qYmmyQKEB
	3f2lu30hX/25uDIX5qIVEMntIuxi1gR7aQaJ9cJqHG4DME08Sljdw3spMP+nKU09U64E/On
	D5hDmZ/0GG29GJ4ixVXsWTDmHFkJgpv3t5AFNU0aD57XDXEc966rYF0rGe1+f+zpli0CvnJ
	dvSKj4vpLSY=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 14955995085311124775
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v2 5/7] net: libwx: Add msg task func
Date: Wed,  3 Apr 2024 17:10:02 +0800
Message-ID: <B16DD99967A50ADF+20240403092714.3027-6-mengyuanlou@net-swift.com>
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

Implement wx_msg_task which is used to process mailbox
messages sent by vf.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_mbx.h   |  45 ++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.c | 621 ++++++++++++++++++
 drivers/net/ethernet/wangxun/libwx/wx_sriov.h |   1 +
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |   7 +
 4 files changed, 674 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_mbx.h b/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
index 201efbc2db9a..ba5a24e0c2cd 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
@@ -21,13 +21,58 @@
 #define WX_MBVFICR_VFREQ_MASK GENMASK(15, 0)
 #define WX_MBVFICR_VFACK_MASK GENMASK(31, 16)
 
+#define WX_VT_MSGTYPE_ACK     BIT(31)
+#define WX_VT_MSGTYPE_NACK    BIT(30)
 #define WX_VT_MSGTYPE_CTS     BIT(29)
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
 #define WX_PF_CONTROL_MSG            BIT(8) /* PF control message */
 
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
index decef4af3ee4..97510ee8f37b 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c
@@ -510,6 +510,14 @@ static void wx_set_vf_rx_tx(struct wx *wx, int vf)
 	}
 }
 
+/**
+ * wx_set_vf_link_state - Set link state
+ * @wx: Pointer to adapter struct
+ * @vf: VF identifier
+ * @state: required link state
+ *
+ * Set a link force state on/off a single vf
+ **/
 static void wx_set_vf_link_state(struct wx *wx, int vf, int state)
 {
 	wx->vfinfo[vf].link_state = state;
@@ -570,3 +578,616 @@ int wx_ndo_set_vf_link_state(struct net_device *netdev, int vf, int state)
 	return ret;
 }
 EXPORT_SYMBOL(wx_ndo_set_vf_link_state);
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
index 6ee1fdff492b..dc8a77563846 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_sriov.h
@@ -11,5 +11,6 @@ int wx_ndo_set_vf_vlan(struct net_device *netdev, int vf, u16 vlan, u8 qos, __be
 int wx_ndo_set_vf_mac(struct net_device *netdev, int vf, u8 *mac);
 int wx_ndo_set_vf_spoofchk(struct net_device *netdev, int vf, bool setting);
 int wx_ndo_set_vf_link_state(struct net_device *netdev, int vf, int state);
+void wx_msg_task(struct wx *wx);
 
 #endif /* _WX_SRIOV_H_ */
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index b0ad9832af3a..3544cbb56b26 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -202,6 +202,7 @@
 #define WX_PSR_VM_L2CTL(_i)          (0x15600 + ((_i) * 4))
 #define WX_PSR_VM_L2CTL_UPE          BIT(4) /* unicast promiscuous */
 #define WX_PSR_VM_L2CTL_VACC         BIT(6) /* accept nomatched vlan */
+#define WX_PSR_VM_L2CTL_VPE          BIT(7) /* vlan promiscuous mode */
 #define WX_PSR_VM_L2CTL_AUPE         BIT(8) /* accept untagged packets */
 #define WX_PSR_VM_L2CTL_ROMPE        BIT(9) /* accept packets in MTA tbl */
 #define WX_PSR_VM_L2CTL_ROPE         BIT(10) /* accept packets in UC tbl */
@@ -245,6 +246,7 @@
 /* VLAN pool filtering masks */
 #define WX_PSR_VLAN_SWC_VIEN         BIT(31)  /* filter is valid */
 #define WX_PSR_VLAN_SWC_ENTRIES      64
+#define WX_PSR_VLAN_SWC_VLANID_MASK  GENMASK(11, 0)
 
 /********************************* RSEC **************************************/
 /* general rsec */
@@ -303,6 +305,9 @@
 #define WX_MAC_WDG_TIMEOUT           0x1100C
 #define WX_MAC_RX_FLOW_CTRL          0x11090
 #define WX_MAC_RX_FLOW_CTRL_RFE      BIT(0) /* receive fc enable */
+
+#define WX_MAC_WDG_TIMEOUT_WTO_MASK  GENMASK(3, 0)
+#define WX_MAC_WDG_TIMEOUT_WTO_DELTA 2
 /* MDIO Registers */
 #define WX_MSCA                      0x11200
 #define WX_MSCA_RA(v)                FIELD_PREP(U16_MAX, v)
@@ -1034,6 +1039,7 @@ struct vf_data_storage {
 	bool link_enable;
 	bool trusted;
 	int xcast_mode;
+	unsigned int vf_api;
 	bool clear_to_send;
 	u16 pf_vlan; /* When set, guest VLAN config not allowed. */
 	u16 pf_qos;
@@ -1145,6 +1151,7 @@ struct wx {
 	u32 wol;
 
 	u16 bd_number;
+	bool default_up;
 
 	struct wx_hw_stats stats;
 	u64 tx_busy;
-- 
2.43.2


