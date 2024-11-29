Return-Path: <netdev+bounces-146483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3289D3960
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 12:21:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A03B0B2CA97
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 11:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219DE19CD1B;
	Wed, 20 Nov 2024 11:14:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-146.mail.aliyun.com (out28-146.mail.aliyun.com [115.124.28.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C6317BB2E;
	Wed, 20 Nov 2024 11:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732101283; cv=none; b=ZwvKZsdNUB6NV0u8VCld3KwUfF7fQAopruEGznFWMtLZ1nqXw6cdNtTMiFb+mo/EiUr4u+Yn0BffcCWV7bYgeOiH81dfUcVHdhHPJfJGEDQ6RXLk6FS7MhiX0fh5yinq4b06BprCkfzDz7JP+qkksGK+/q4tpxwiQ+YaiJjf0Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732101283; c=relaxed/simple;
	bh=LF/ciXyDGlKq+0AAuzwtCw/dAYLOX9oY9FshN7SwNgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wp/Andjm6BgDRMXHT93Wi1wlH6JC1TUD7k0OCJc4tWAYASyIP02z1NbtLAZfPRszIToWd+ZmYpBB2oQhEU7jHrsk8qO9xHzwEgXqHCf38EXR+sConc+q8qUgTjGoiKxT/JoEqLjN2db55qHJt7PTbQG4V0kCZ+QxQ410IxIYxHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.aGmppZy_1732100203 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 20 Nov 2024 18:56:43 +0800
From: Frank Sae <Frank.Sae@motor-comm.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com,
	Frank.Sae@motor-comm.com
Subject: [PATCH net-next v2 09/21] motorcomm:yt6801: Implement some hw_ops function
Date: Wed, 20 Nov 2024 19:14:34 +0800
Message-Id: <20241120105625.22508-10-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
References: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement some hw_ops function to set default hardware settings, including
PHY control, Vlan related config, RX coalescing, Receive Side Scaling and
other basic function control.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 .../net/ethernet/motorcomm/yt6801/yt6801_hw.c | 2216 +++++++++++++++++
 1 file changed, 2216 insertions(+)
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/yt6801_hw.c

diff --git a/drivers/net/ethernet/motorcomm/yt6801/yt6801_hw.c b/drivers/net/ethernet/motorcomm/yt6801/yt6801_hw.c
new file mode 100644
index 000000000..1af26b0b4
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/yt6801/yt6801_hw.c
@@ -0,0 +1,2216 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) 2022 - 2024 Motorcomm Electronic Technology Co.,Ltd. */
+
+#include "yt6801_desc.h"
+#include "yt6801_net.h"
+
+static void fxgmac_disable_rx_csum(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mac(pdata, MAC_CR);
+	fxgmac_set_bits(&val, MAC_CR_IPC_POS, MAC_CR_IPC_LEN, 0);
+	wr32_mac(pdata, val, MAC_CR);
+}
+
+static void fxgmac_enable_rx_csum(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mac(pdata, MAC_CR);
+	fxgmac_set_bits(&val, MAC_CR_IPC_POS, MAC_CR_IPC_LEN, 1);
+	wr32_mac(pdata, val, MAC_CR);
+}
+
+static void fxgmac_disable_tx_vlan(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mac(pdata, MAC_VLANIR);
+	/* Set VLAN Tag input enable */
+	fxgmac_set_bits(&val, MAC_VLANIR_CSVL_POS, MAC_VLANIR_CSVL_LEN, 0);
+	fxgmac_set_bits(&val, MAC_VLANIR_VLTI_POS, MAC_VLANIR_VLTI_LEN, 1);
+	/* Set VLAN priority control disable */
+	fxgmac_set_bits(&val, MAC_VLANIR_VLP_POS, MAC_VLANIR_VLP_LEN, 0);
+	fxgmac_set_bits(&val, MAC_VLANIR_VLC_POS, MAC_VLANIR_VLC_LEN, 0);
+	wr32_mac(pdata, val, MAC_VLANIR);
+}
+
+static void fxgmac_enable_rx_vlan_stripping(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mac(pdata, MAC_VLANTR);
+	/* Put the VLAN tag in the Rx descriptor */
+	fxgmac_set_bits(&val, MAC_VLANTR_EVLRXS_POS, MAC_VLANTR_EVLRXS_LEN, 1);
+	/* Don't check the VLAN type */
+	fxgmac_set_bits(&val, MAC_VLANTR_DOVLTC_POS, MAC_VLANTR_DOVLTC_LEN, 1);
+	/* Check only C-TAG (0x8100) packets */
+	fxgmac_set_bits(&val, MAC_VLANTR_ERSVLM_POS, MAC_VLANTR_ERSVLM_LEN, 0);
+	/* Don't consider an S-TAG (0x88A8) packet as a VLAN packet */
+	fxgmac_set_bits(&val, MAC_VLANTR_ESVL_POS, MAC_VLANTR_ESVL_LEN, 0);
+	/* Enable VLAN tag stripping */
+	fxgmac_set_bits(&val, MAC_VLANTR_EVLS_POS, MAC_VLANTR_EVLS_LEN, 3);
+	wr32_mac(pdata, val, MAC_VLANTR);
+}
+
+static void fxgmac_disable_rx_vlan_stripping(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mac(pdata, MAC_VLANTR);
+	fxgmac_set_bits(&val, MAC_VLANTR_EVLS_POS, MAC_VLANTR_EVLS_LEN, 0);
+	wr32_mac(pdata, val, MAC_VLANTR);
+}
+
+static void fxgmac_enable_rx_vlan_filtering(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mac(pdata, MAC_PFR);
+	/* Enable VLAN filtering */
+	fxgmac_set_bits(&val, MAC_PFR_VTFE_POS, MAC_PFR_VTFE_LEN, 1);
+	wr32_mac(pdata, val, MAC_PFR);
+
+	val = rd32_mac(pdata, MAC_VLANTR);
+	/* Enable VLAN Hash Table filtering */
+	fxgmac_set_bits(&val, MAC_VLANTR_VTHM_POS, MAC_VLANTR_VTHM_LEN, 1);
+	/* Disable VLAN tag inverse matching */
+	fxgmac_set_bits(&val, MAC_VLANTR_VTIM_POS, MAC_VLANTR_VTIM_LEN, 0);
+	/* Only filter on the lower 12-bits of the VLAN tag */
+	fxgmac_set_bits(&val, MAC_VLANTR_ETV_POS, MAC_VLANTR_ETV_LEN, 1);
+}
+
+static void fxgmac_disable_rx_vlan_filtering(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mac(pdata, MAC_PFR);
+	fxgmac_set_bits(&val, MAC_PFR_VTFE_POS, MAC_PFR_VTFE_LEN, 0);
+	wr32_mac(pdata, val, MAC_PFR);
+}
+
+static u32 fxgmac_vid_crc32_le(__le16 vid_le)
+{
+	unsigned char *data = (unsigned char *)&vid_le;
+	unsigned char data_byte = 0;
+	u32 crc = ~0;
+	u32 temp = 0;
+	int i, bits;
+
+	bits = get_bitmask_order(VLAN_VID_MASK);
+	for (i = 0; i < bits; i++) {
+		if ((i % 8) == 0)
+			data_byte = data[i / 8];
+
+		temp = ((crc & 1) ^ data_byte) & 1;
+		crc >>= 1;
+		data_byte >>= 1;
+
+		if (temp)
+			crc ^= CRC32_POLY_LE;
+	}
+
+	return crc;
+}
+
+static void fxgmac_update_vlan_hash_table(struct fxgmac_pdata *pdata)
+{
+	u16 vid, vlan_hash_table = 0;
+	__le16 vid_le;
+	u32 val, crc;
+
+	/* Generate the VLAN Hash Table value */
+	for_each_set_bit(vid, pdata->active_vlans, VLAN_N_VID) {
+		/* Get the CRC32 value of the VLAN ID */
+		vid_le = cpu_to_le16(vid);
+		crc = bitrev32(~fxgmac_vid_crc32_le(vid_le)) >> 28;
+
+		vlan_hash_table |= (1 << crc);
+	}
+
+	/* Set the VLAN Hash Table filtering register */
+	val = rd32_mac(pdata, MAC_VLANHTR);
+	fxgmac_set_bits(&val, MAC_VLANHTR_VLHT_POS, MAC_VLANHTR_VLHT_LEN,
+			vlan_hash_table);
+	wr32_mac(pdata, val, MAC_VLANHTR);
+
+	yt_dbg(pdata, "fxgmac_update_vlan_hash_tabl done,hash tbl=%08x.\n",
+	       vlan_hash_table);
+}
+
+static void fxgmac_set_promiscuous_mode(struct fxgmac_pdata *pdata,
+					unsigned int enable)
+{
+	u32 val, en = enable ? 1 : 0;
+
+	val = rd32_mac(pdata, MAC_PFR);
+	if (FXGMAC_GET_BITS(val, MAC_PFR_PR_POS, MAC_PFR_PR_LEN) == en)
+		return;
+
+	fxgmac_set_bits(&val, MAC_PFR_PR_POS, MAC_PFR_PR_LEN, en);
+	wr32_mac(pdata, val, MAC_PFR);
+
+	/* Hardware will still perform VLAN filtering in promiscuous mode */
+	if (enable) {
+		fxgmac_disable_rx_vlan_filtering(pdata);
+		return;
+	}
+
+	if (pdata->netdev->features & NETIF_F_HW_VLAN_CTAG_FILTER)
+		fxgmac_enable_rx_vlan_filtering(pdata);
+}
+
+static void fxgmac_enable_rx_broadcast(struct fxgmac_pdata *pdata,
+				       unsigned int enable)
+{
+	u32 val, en = enable ? 0 : 1;
+
+	val = rd32_mac(pdata, MAC_PFR);
+	if (FXGMAC_GET_BITS(val, MAC_PFR_DBF_POS, MAC_PFR_DBF_LEN) == en)
+		return;
+
+	fxgmac_set_bits(&val, MAC_PFR_DBF_POS, MAC_PFR_DBF_LEN, en);
+	wr32_mac(pdata, val, MAC_PFR);
+}
+
+static void fxgmac_set_all_multicast_mode(struct fxgmac_pdata *pdata,
+					  unsigned int enable)
+{
+	u32 val, en = enable ? 1 : 0;
+
+	val = rd32_mac(pdata, MAC_PFR);
+	if (FXGMAC_GET_BITS(val, MAC_PFR_PM_POS, MAC_PFR_PM_LEN) == en)
+		return;
+
+	fxgmac_set_bits(&val, MAC_PFR_PM_POS, MAC_PFR_PM_LEN, en);
+	wr32_mac(pdata, val, MAC_PFR);
+}
+
+static void fxgmac_set_mac_reg(struct fxgmac_pdata *pdata,
+			       struct netdev_hw_addr *ha, unsigned int *mac_reg)
+{
+	unsigned int mac_hi, mac_lo;
+	u8 *mac_addr;
+
+	mac_lo = 0;
+	mac_hi = 0;
+
+	if (ha) {
+		mac_addr = (u8 *)&mac_lo;
+		mac_addr[0] = ha->addr[0];
+		mac_addr[1] = ha->addr[1];
+		mac_addr[2] = ha->addr[2];
+		mac_addr[3] = ha->addr[3];
+
+		mac_addr = (u8 *)&mac_hi;
+		mac_addr[0] = ha->addr[4];
+		mac_addr[1] = ha->addr[5];
+
+		fxgmac_set_bits(&mac_hi, MAC_MACA1HR_AE_POS,
+				MAC_MACA1HR_AE_LEN, 1);
+
+		yt_dbg(pdata, "adding mac address %pM at %#x\n", ha->addr,
+		       *mac_reg);
+	}
+
+	/* If "ha" is NULL, clear the additional MAC address entries */
+	wr32_mac(pdata, mac_hi, *mac_reg);
+	*mac_reg += MAC_MACA_INC;
+	wr32_mac(pdata, mac_lo, *mac_reg);
+	*mac_reg += MAC_MACA_INC;
+}
+
+static void fxgmac_set_mac_addn_addrs(struct fxgmac_pdata *pdata)
+{
+	struct net_device *netdev = pdata->netdev;
+	unsigned int addn_macs, mac_reg;
+	struct netdev_hw_addr *ha;
+
+	mac_reg = MAC_MACA1HR;
+	addn_macs = pdata->hw_feat.addn_mac;
+
+	if (netdev_uc_count(netdev) > addn_macs) {
+		fxgmac_set_promiscuous_mode(pdata, 1);
+	} else {
+		netdev_for_each_uc_addr(ha, netdev) {
+			fxgmac_set_mac_reg(pdata, ha, &mac_reg);
+			addn_macs--;
+		}
+
+		if (netdev_mc_count(netdev) > addn_macs) {
+			fxgmac_set_all_multicast_mode(pdata, 1);
+		} else {
+			netdev_for_each_mc_addr(ha, netdev) {
+				fxgmac_set_mac_reg(pdata, ha, &mac_reg);
+				addn_macs--;
+			}
+		}
+	}
+
+	/* Clear remaining additional MAC address entries */
+	while (addn_macs--)
+		fxgmac_set_mac_reg(pdata, NULL, &mac_reg);
+}
+
+#define GET_REG_AND_BIT_POS(reversalval, regout, bitout)                       \
+	do {                                                                   \
+		typeof(reversalval)(_reversalval) = (reversalval);             \
+		regout = (((_reversalval) >> 5) & 0x7);                        \
+		bitout = ((_reversalval) & 0x1f);                              \
+	} while (0)
+
+static u32 fxgmac_crc32(unsigned char *data, int length)
+{
+	u32 crc = ~0;
+
+	while (--length >= 0) {
+		unsigned char byte = *data++;
+		int bit;
+
+		for (bit = 8; --bit >= 0; byte >>= 1) {
+			if ((crc ^ byte) & 1) {
+				crc >>= 1;
+				crc ^= CRC32_POLY_LE;
+			} else {
+				crc >>= 1;
+			}
+		}
+	}
+
+	return ~crc;
+}
+
+/* Maximum MAC address hash table size (256 bits = 8 bytes) */
+#define FXGMAC_MAC_HASH_TABLE_SIZE 8
+
+static void fxgmac_config_multicast_mac_hash_table(struct fxgmac_pdata *pdata,
+						   unsigned char *pmc_mac,
+						   int b_add)
+{
+	unsigned int j, hash_reg, reg_bit;
+	u32 val, crc, reversal_crc;
+
+	if (!pmc_mac) {
+		for (j = 0; j < FXGMAC_MAC_HASH_TABLE_SIZE; j++) {
+			hash_reg = j;
+			hash_reg = (MAC_HTR0 + hash_reg * MAC_HTR_INC);
+			wr32_mac(pdata, 0, hash_reg);
+		}
+		return;
+	}
+
+	crc = fxgmac_crc32(pmc_mac, ETH_ALEN);
+
+	/* Reverse the crc */
+	for (j = 0, reversal_crc = 0; j < 32; j++) {
+		if (crc & ((u32)1 << j))
+			reversal_crc |= 1 << (31 - j);
+	}
+
+	GET_REG_AND_BIT_POS((reversal_crc >> 24), hash_reg, reg_bit);
+	/* Set the MAC Hash Table registers */
+	hash_reg = (MAC_HTR0 + hash_reg * MAC_HTR_INC);
+
+	val = rd32_mac(pdata, hash_reg);
+	fxgmac_set_bits(&val, reg_bit, 1, (b_add ? 1 : 0));
+	wr32_mac(pdata, val, hash_reg);
+}
+
+static void fxgmac_set_mac_hash_table(struct fxgmac_pdata *pdata)
+{
+	struct net_device *netdev = pdata->netdev;
+	struct netdev_hw_addr *ha;
+
+	fxgmac_config_multicast_mac_hash_table(pdata, NULL, 1);
+	netdev_for_each_mc_addr(ha, netdev) {
+		fxgmac_config_multicast_mac_hash_table(pdata, ha->addr, 1);
+	}
+}
+
+static void fxgmac_set_mc_addresses(struct fxgmac_pdata *pdata)
+{
+	if (pdata->hw_feat.hash_table_size)
+		fxgmac_set_mac_hash_table(pdata);
+	else
+		fxgmac_set_mac_addn_addrs(pdata);
+}
+
+static void fxgmac_set_multicast_mode(struct fxgmac_pdata *pdata,
+				      unsigned int enable)
+{
+	if (enable)
+		fxgmac_set_mc_addresses(pdata);
+	else
+		fxgmac_config_multicast_mac_hash_table(pdata, NULL, 1);
+}
+
+static void fxgmac_set_mac_address(struct fxgmac_pdata *pdata, u8 *addr)
+{
+	u32 mac_hi, mac_lo;
+
+	mac_lo = (u32)addr[0] | ((u32)addr[1] << 8) |
+		  ((u32)addr[2] << 16) | ((u32)addr[3] << 24);
+
+	mac_hi = (u32)addr[4] | ((u32)addr[5] << 8);
+
+	wr32_mac(pdata, mac_lo, MAC_MACA0LR);
+	wr32_mac(pdata, mac_hi, MAC_MACA0HR);
+}
+
+static void fxgmac_config_mac_address(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	fxgmac_set_mac_address(pdata, pdata->mac_addr);
+
+	val = rd32_mac(pdata, MAC_PFR);
+	fxgmac_set_bits(&val, MAC_PFR_HPF_POS, MAC_PFR_HPF_LEN, 1);
+	fxgmac_set_bits(&val, MAC_PFR_HUC_POS, MAC_PFR_HUC_LEN, 1);
+	fxgmac_set_bits(&val, MAC_PFR_HMC_POS, MAC_PFR_HMC_LEN, 1);
+	wr32_mac(pdata, val, MAC_PFR);
+}
+
+static void fxgmac_config_crc_check(struct fxgmac_pdata *pdata)
+{
+	u32 val, en = pdata->crc_check ? 0 : 1;
+
+	val = rd32_mac(pdata, MAC_ECR);
+	fxgmac_set_bits(&val, MAC_ECR_DCRCC_POS, MAC_ECR_DCRCC_LEN, en);
+	wr32_mac(pdata, val, MAC_ECR);
+}
+
+static void fxgmac_config_jumbo(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mac(pdata, MAC_CR);
+	fxgmac_set_bits(&val, MAC_CR_JE_POS, MAC_CR_JE_LEN, pdata->jumbo);
+	wr32_mac(pdata, val, MAC_CR);
+}
+
+static void fxgmac_config_checksum_offload(struct fxgmac_pdata *pdata)
+{
+	if (pdata->netdev->features & NETIF_F_RXCSUM)
+		fxgmac_enable_rx_csum(pdata);
+	else
+		fxgmac_disable_rx_csum(pdata);
+}
+
+static void fxgmac_config_vlan_support(struct fxgmac_pdata *pdata)
+{
+	/*  Configure dynamical vlanID from TX Context. */
+	fxgmac_disable_tx_vlan(pdata);
+
+	/* Set the current VLAN Hash Table register value */
+	fxgmac_update_vlan_hash_table(pdata);
+
+	if (pdata->vlan_filter)
+		fxgmac_enable_rx_vlan_filtering(pdata);
+	else
+		fxgmac_disable_rx_vlan_filtering(pdata);
+
+	if (pdata->vlan_strip)
+		fxgmac_enable_rx_vlan_stripping(pdata);
+	else
+		fxgmac_disable_rx_vlan_stripping(pdata);
+}
+
+static void fxgmac_config_rx_mode(struct fxgmac_pdata *pdata)
+{
+	u32 pr_mode, am_mode, mu_mode, bd_mode;
+
+	pr_mode = ((pdata->netdev->flags & IFF_PROMISC) != 0);
+	am_mode = ((pdata->netdev->flags & IFF_ALLMULTI) != 0);
+	mu_mode = ((pdata->netdev->flags & IFF_MULTICAST) != 0);
+	bd_mode = ((pdata->netdev->flags & IFF_BROADCAST) != 0);
+
+	fxgmac_enable_rx_broadcast(pdata, bd_mode);
+	fxgmac_set_promiscuous_mode(pdata, pr_mode);
+	fxgmac_set_all_multicast_mode(pdata, am_mode);
+	fxgmac_set_multicast_mode(pdata, mu_mode);
+}
+
+static void fxgmac_prepare_tx_stop(struct fxgmac_pdata *pdata,
+				   struct fxgmac_channel *channel)
+{
+	unsigned int tx_q_idx, tx_status;
+	unsigned int tx_dsr, tx_pos;
+	unsigned long tx_timeout;
+
+	/* Calculate the status register to read and the position within */
+	if (channel->queue_index < DMA_DSRX_FIRST_QUEUE) {
+		tx_dsr = DMA_DSR0;
+		tx_pos = (channel->queue_index * DMA_DSR_Q_LEN) +
+			 DMA_DSR0_TPS_START;
+	} else {
+		tx_q_idx = channel->queue_index - DMA_DSRX_FIRST_QUEUE;
+
+		tx_dsr = DMA_DSR1 + ((tx_q_idx / DMA_DSRX_QPR) * DMA_DSRX_INC);
+		tx_pos = ((tx_q_idx % DMA_DSRX_QPR) * DMA_DSR_Q_LEN) +
+			 DMA_DSRX_TPS_START;
+	}
+
+	/* The Tx engine cannot be stopped if it is actively processing
+	 * descriptors. Wait for the Tx engine to enter the stopped or
+	 * suspended state.
+	 */
+	tx_timeout = jiffies + (FXGMAC_DMA_STOP_TIMEOUT * HZ);
+
+	while (time_before(jiffies, tx_timeout)) {
+		tx_status = rd32_mac(pdata, tx_dsr);
+		tx_status = FXGMAC_GET_BITS(tx_status, tx_pos, DMA_DSR_TPS_LEN);
+		if (tx_status == DMA_TPS_STOPPED ||
+		    tx_status == DMA_TPS_SUSPENDED)
+			break;
+
+		fsleep(500);
+	}
+
+	if (!time_before(jiffies, tx_timeout))
+		yt_dbg(pdata,
+		       "timed out waiting for Tx DMA channel %u to stop\n",
+		       channel->queue_index);
+}
+
+static void fxgmac_enable_tx(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	u32 val;
+
+	/* Enable Tx DMA channel */
+	val = rd32_mac(pdata, FXGMAC_DMA_REG(channel, DMA_CH_TCR));
+	fxgmac_set_bits(&val, DMA_CH_TCR_ST_POS, DMA_CH_TCR_ST_LEN, 1);
+	wr32_mac(pdata, val, FXGMAC_DMA_REG(channel, DMA_CH_TCR));
+
+	/* Enable Tx queue */
+	val = rd32_mac(pdata, FXGMAC_MTL_REG(0, MTL_Q_TQOMR));
+	fxgmac_set_bits(&val, MTL_Q_TQOMR_TXQEN_POS,
+			MTL_Q_TQOMR_TXQEN_LEN, MTL_Q_ENABLED);
+	wr32_mac(pdata, val, FXGMAC_MTL_REG(0, MTL_Q_TQOMR));
+
+	/* Enable MAC Tx */
+	val = rd32_mac(pdata, MAC_CR);
+	fxgmac_set_bits(&val, MAC_CR_TE_POS, MAC_CR_TE_LEN, 1);
+	wr32_mac(pdata, val, MAC_CR);
+}
+
+static void fxgmac_disable_tx(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	u32 val;
+
+	/* Prepare for Tx DMA channel stop */
+	fxgmac_prepare_tx_stop(pdata, channel);
+
+	/* Disable MAC Tx */
+	val = rd32_mac(pdata, MAC_CR);
+	fxgmac_set_bits(&val, MAC_CR_TE_POS, MAC_CR_TE_LEN, 0);
+	wr32_mac(pdata, val, MAC_CR);
+
+	/* Disable Tx queue */
+	val = rd32_mac(pdata, FXGMAC_MTL_REG(0, MTL_Q_TQOMR));
+	fxgmac_set_bits(&val, MTL_Q_TQOMR_TXQEN_POS,
+			MTL_Q_TQOMR_TXQEN_LEN, 0);
+	wr32_mac(pdata, val, FXGMAC_MTL_REG(0, MTL_Q_TQOMR));
+
+	/* Disable Tx DMA channel */
+	val = rd32_mac(pdata, FXGMAC_DMA_REG(channel, DMA_CH_TCR));
+	fxgmac_set_bits(&val, DMA_CH_TCR_ST_POS,
+			DMA_CH_TCR_ST_LEN, 0);
+	wr32_mac(pdata, val, FXGMAC_DMA_REG(channel, DMA_CH_TCR));
+}
+
+static void fxgmac_prepare_rx_stop(struct fxgmac_pdata *pdata,
+				   unsigned int queue)
+{
+	unsigned int rx_status, rx_q, rx_q_sts;
+	unsigned long rx_timeout;
+
+	/* The Rx engine cannot be stopped if it is actively processing
+	 * packets. Wait for the Rx queue to empty the Rx fifo.
+	 */
+	rx_timeout = jiffies + (FXGMAC_DMA_STOP_TIMEOUT * HZ);
+
+	while (time_before(jiffies, rx_timeout)) {
+		rx_status = rd32_mac(pdata, FXGMAC_MTL_REG(queue, MTL_Q_RQDR));
+		rx_q = FXGMAC_GET_BITS(rx_status, MTL_Q_RQDR_PRXQ_POS,
+				       MTL_Q_RQDR_PRXQ_LEN);
+		rx_q_sts = FXGMAC_GET_BITS(rx_status, MTL_Q_RQDR_RXQSTS_POS,
+					   MTL_Q_RQDR_RXQSTS_LEN);
+		if (rx_q == 0 && rx_q_sts == 0)
+			break;
+
+		fsleep(500);
+	}
+
+	if (!time_before(jiffies, rx_timeout))
+		yt_dbg(pdata, "timed out waiting for Rx queue %u to empty\n",
+		       queue);
+}
+
+static void fxgmac_enable_rx(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	u32 val, i;
+
+	/* Enable each Rx DMA channel */
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		val = rd32_mac(pdata, FXGMAC_DMA_REG(channel, DMA_CH_RCR));
+		fxgmac_set_bits(&val, DMA_CH_RCR_SR_POS, DMA_CH_RCR_SR_LEN, 1);
+		wr32_mac(pdata, val, FXGMAC_DMA_REG(channel, DMA_CH_RCR));
+	}
+
+	/* Enable each Rx queue */
+	val = 0;
+	for (i = 0; i < pdata->rx_q_count; i++)
+		val |= (0x02 << (i << 1));
+
+	wr32_mac(pdata, val, MAC_RQC0R);
+
+	/* Enable MAC Rx */
+	val = rd32_mac(pdata, MAC_CR);
+	fxgmac_set_bits(&val, MAC_CR_CST_POS, MAC_CR_CST_LEN, 1);
+	fxgmac_set_bits(&val, MAC_CR_ACS_POS, MAC_CR_ACS_LEN, 1);
+	fxgmac_set_bits(&val, MAC_CR_RE_POS, MAC_CR_RE_LEN, 1);
+	wr32_mac(pdata, val, MAC_CR);
+}
+
+static void fxgmac_disable_rx(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	u32 val, i;
+
+	/* Disable MAC Rx */
+	val = rd32_mac(pdata, MAC_CR);
+	fxgmac_set_bits(&val, MAC_CR_CST_POS, MAC_CR_CST_LEN, 0);
+	fxgmac_set_bits(&val, MAC_CR_ACS_POS, MAC_CR_ACS_LEN, 0);
+	fxgmac_set_bits(&val, MAC_CR_RE_POS, MAC_CR_RE_LEN, 0);
+	wr32_mac(pdata, val, MAC_CR);
+
+	/* Prepare for Rx DMA channel stop */
+	for (i = 0; i < pdata->rx_q_count; i++)
+		fxgmac_prepare_rx_stop(pdata, i);
+
+	wr32_mac(pdata, 0, MAC_RQC0R); /* Disable each Rx queue */
+
+	/* Disable each Rx DMA channel */
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		val = rd32_mac(pdata, FXGMAC_DMA_REG(channel, DMA_CH_RCR));
+		fxgmac_set_bits(&val, DMA_CH_RCR_SR_POS, DMA_CH_RCR_SR_LEN, 0);
+		wr32_mac(pdata, val, FXGMAC_DMA_REG(channel, DMA_CH_RCR));
+	}
+}
+
+static void fxgmac_config_tx_flow_control(struct fxgmac_pdata *pdata)
+{
+	u32 val, i;
+
+	/* Set MTL flow control */
+	for (i = 0; i < pdata->rx_q_count; i++) {
+		val = rd32_mac(pdata, FXGMAC_MTL_REG(i, MTL_Q_RQOMR));
+		fxgmac_set_bits(&val, MTL_Q_RQOMR_EHFC_POS,
+				MTL_Q_RQOMR_EHFC_LEN, pdata->tx_pause);
+		wr32_mac(pdata, val, FXGMAC_MTL_REG(i, MTL_Q_RQOMR));
+	}
+
+	/* Set MAC flow control */
+	val = rd32_mac(pdata, MAC_Q0TFCR);
+	fxgmac_set_bits(&val, MAC_Q0TFCR_TFE_POS, MAC_Q0TFCR_TFE_LEN,
+			pdata->tx_pause);
+	if (pdata->tx_pause == 1)
+		/* Set pause time */
+		fxgmac_set_bits(&val, MAC_Q0TFCR_PT_POS,
+				MAC_Q0TFCR_PT_LEN, 0xffff);
+	wr32_mac(pdata, val, MAC_Q0TFCR);
+}
+
+static void fxgmac_config_rx_flow_control(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mac(pdata, MAC_RFCR);
+	fxgmac_set_bits(&val, MAC_RFCR_RFE_POS, MAC_RFCR_RFE_LEN,
+			pdata->rx_pause);
+	wr32_mac(pdata, val, MAC_RFCR);
+}
+
+static void fxgmac_config_rx_coalesce(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	u32 val;
+
+	for (u32 i = 0; i < pdata->channel_count; i++, channel++) {
+		if (!channel->rx_ring)
+			break;
+
+		val = rd32_mac(pdata, FXGMAC_DMA_REG(channel, DMA_CH_RIWT));
+		fxgmac_set_bits(&val, DMA_CH_RIWT_RWT_POS, DMA_CH_RIWT_RWT_LEN,
+				pdata->rx_riwt);
+		wr32_mac(pdata, val, FXGMAC_DMA_REG(channel, DMA_CH_RIWT));
+	}
+}
+
+static void fxgmac_config_rx_fep_disable(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	for (u32 i = 0; i < pdata->rx_q_count; i++) {
+		val = rd32_mac(pdata, FXGMAC_MTL_REG(i, MTL_Q_RQOMR));
+		/* Enable the rx queue forward packet with error status
+		 * (crc error,gmii_er, watch dog timeout.or overflow)
+		 */
+		fxgmac_set_bits(&val, MTL_Q_RQOMR_FEP_POS, MTL_Q_RQOMR_FEP_LEN,
+				MTL_FEP_ENABLE);
+		wr32_mac(pdata, val, FXGMAC_MTL_REG(i, MTL_Q_RQOMR));
+	}
+}
+
+static void fxgmac_config_rx_fup_enable(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	for (u32 i = 0; i < pdata->rx_q_count; i++) {
+		val = rd32_mac(pdata, FXGMAC_MTL_REG(i, MTL_Q_RQOMR));
+		fxgmac_set_bits(&val, MTL_Q_RQOMR_FUP_POS, MTL_Q_RQOMR_FUP_LEN,
+				1);
+		wr32_mac(pdata, val, FXGMAC_MTL_REG(i, MTL_Q_RQOMR));
+	}
+}
+
+static void fxgmac_config_rx_buffer_size(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	u32 val;
+
+	for (u32 i = 0; i < pdata->channel_count; i++, channel++) {
+		val = rd32_mac(pdata, FXGMAC_DMA_REG(channel, DMA_CH_RCR));
+		fxgmac_set_bits(&val, DMA_CH_RCR_RBSZ_POS, DMA_CH_RCR_RBSZ_LEN,
+				pdata->rx_buf_size);
+		wr32_mac(pdata, val, FXGMAC_DMA_REG(channel, DMA_CH_RCR));
+	}
+}
+
+static void fxgmac_config_tso_mode(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	u32 val;
+
+	val = rd32_mac(pdata, FXGMAC_DMA_REG(channel, DMA_CH_TCR));
+	fxgmac_set_bits(&val, DMA_CH_TCR_TSE_POS, DMA_CH_TCR_TSE_LEN,
+			pdata->hw_feat.tso);
+	wr32_mac(pdata, val, FXGMAC_DMA_REG(channel, DMA_CH_TCR));
+}
+
+static void fxgmac_config_sph_mode(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	u32 val;
+
+	for (u32 i = 0; i < pdata->channel_count; i++, channel++) {
+		val = rd32_mac(pdata, FXGMAC_DMA_REG(channel, DMA_CH_CR));
+		fxgmac_set_bits(&val, DMA_CH_CR_SPH_POS, DMA_CH_CR_SPH_LEN, 0);
+		wr32_mac(pdata, val, FXGMAC_DMA_REG(channel, DMA_CH_CR));
+	}
+
+	val = rd32_mac(pdata, MAC_ECR);
+	fxgmac_set_bits(&val, MAC_ECR_HDSMS_POS, MAC_ECR_HDSMS_LEN,
+			FXGMAC_SPH_HDSMS_SIZE_512B);
+	wr32_mac(pdata, val, MAC_ECR);
+}
+
+static unsigned int fxgmac_usec_to_riwt(struct fxgmac_pdata *pdata,
+					unsigned int usec)
+{
+	/* Convert the input usec value to the watchdog timer value. Each
+	 * watchdog timer value is equivalent to 256 clock cycles.
+	 * Calculate the required value as:
+	 *  ( usec * ( system_clock_mhz / 10^6) / 256
+	 */
+	return (usec * (pdata->sysclk_rate / 1000000)) / 256;
+}
+
+static void fxgmac_config_rx_threshold(struct fxgmac_pdata *pdata,
+				       unsigned int set_val)
+{
+	u32 val;
+
+	for (u32 i = 0; i < pdata->rx_q_count; i++) {
+		val = rd32_mac(pdata, FXGMAC_MTL_REG(i, MTL_Q_RQOMR));
+		fxgmac_set_bits(&val, MTL_Q_RQOMR_RTC_POS, MTL_Q_RQOMR_RTC_LEN,
+				set_val);
+		wr32_mac(pdata, val, FXGMAC_MTL_REG(i, MTL_Q_RQOMR));
+	}
+}
+
+static void fxgmac_config_mtl_mode(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	/* Set Tx to weighted round robin scheduling algorithm */
+	val = rd32_mac(pdata, MTL_OMR);
+	fxgmac_set_bits(&val, MTL_OMR_ETSALG_POS, MTL_OMR_ETSALG_LEN,
+			MTL_ETSALG_WRR);
+	wr32_mac(pdata, val, MTL_OMR);
+
+	/* Set Tx traffic classes to use WRR algorithm with equal weights */
+	val = rd32_mac(pdata, FXGMAC_MTL_REG(0, MTL_TC_QWR));
+	fxgmac_set_bits(&val, MTL_TC_QWR_QW_POS, MTL_TC_QWR_QW_LEN, 1);
+	wr32_mac(pdata, val, FXGMAC_MTL_REG(0, MTL_TC_QWR));
+
+	/* Set Rx to strict priority algorithm */
+	val = rd32_mac(pdata, MTL_OMR);
+	fxgmac_set_bits(&val, MTL_OMR_RAA_POS, MTL_OMR_RAA_LEN, MTL_RAA_SP);
+	wr32_mac(pdata, val, MTL_OMR);
+}
+
+static void fxgmac_config_queue_mapping(struct fxgmac_pdata *pdata)
+{
+	unsigned int ppq, ppq_extra, prio_queues;
+	unsigned int __maybe_unused prio;
+	unsigned int reg, val, mask;
+
+	/* Map the 8 VLAN priority values to available MTL Rx queues */
+	prio_queues =
+		min_t(unsigned int, IEEE_8021QAZ_MAX_TCS, pdata->rx_q_count);
+	ppq = IEEE_8021QAZ_MAX_TCS / prio_queues;
+	ppq_extra = IEEE_8021QAZ_MAX_TCS % prio_queues;
+
+	reg = MAC_RQC2R;
+	val = 0;
+	for (u32 i = 0, prio = 0; i < prio_queues;) {
+		mask = 0;
+		for (u32 j = 0; j < ppq; j++) {
+			yt_dbg(pdata, "PRIO%u mapped to RXq%u\n", prio, i);
+			mask |= (1 << prio);
+			prio++;
+		}
+
+		if (i < ppq_extra) {
+			yt_dbg(pdata, "PRIO%u mapped to RXq%u\n", prio, i);
+			mask |= (1 << prio);
+			prio++;
+		}
+
+		val |= (mask << ((i++ % MAC_RQC2_Q_PER_REG) << 3));
+
+		if ((i % MAC_RQC2_Q_PER_REG) && i != prio_queues)
+			continue;
+
+		wr32_mac(pdata, val, reg);
+		reg += MAC_RQC2_INC;
+		val = 0;
+	}
+
+	/* Configure one to one, MTL Rx queue to DMA Rx channel mapping
+	 * ie Q0 <--> CH0, Q1 <--> CH1 ... Q11 <--> CH11
+	 */
+	val = rd32_mac(pdata, MTL_RQDCM0R);
+	val |= (MTL_RQDCM0R_Q0MDMACH | MTL_RQDCM0R_Q1MDMACH |
+		MTL_RQDCM0R_Q2MDMACH | MTL_RQDCM0R_Q3MDMACH);
+
+	/* Selection to let RSS work, * ie, bit4,12,20,28 for
+	 * Q0,1,2,3 individual
+	 */
+	if (pdata->rss)
+		val |= (MTL_RQDCM0R_Q0DDMACH | MTL_RQDCM0R_Q1DDMACH |
+			MTL_RQDCM0R_Q2DDMACH | MTL_RQDCM0R_Q3DDMACH);
+
+	wr32_mac(pdata, val, MTL_RQDCM0R);
+
+	val = rd32_mac(pdata, MTL_RQDCM0R + MTL_RQDCM_INC);
+	val |= (MTL_RQDCM1R_Q4MDMACH | MTL_RQDCM1R_Q5MDMACH |
+		MTL_RQDCM1R_Q6MDMACH | MTL_RQDCM1R_Q7MDMACH);
+	wr32_mac(pdata, val, MTL_RQDCM0R + MTL_RQDCM_INC);
+}
+
+#define FXGMAC_MAX_FIFO 81920
+
+static unsigned int fxgmac_calculate_per_queue_fifo(unsigned int fifo_size,
+						    unsigned int queue_count)
+{
+	u32 q_fifo_size, p_fifo;
+
+	/* Calculate the configured fifo size */
+	q_fifo_size = 1 << (fifo_size + 7);
+
+	/* The configured value may not be the actual amount of fifo RAM */
+	q_fifo_size = min_t(unsigned int, FXGMAC_MAX_FIFO, q_fifo_size);
+	q_fifo_size = q_fifo_size / queue_count;
+
+	/* Each increment in the queue fifo size represents 256 bytes of
+	 * fifo, with 0 representing 256 bytes. Distribute the fifo equally
+	 * between the queues.
+	 */
+	p_fifo = q_fifo_size / 256;
+	if (p_fifo)
+		p_fifo--;
+
+	return p_fifo;
+}
+
+static u32 fxgmac_calculate_max_checksum_size(struct fxgmac_pdata *pdata)
+{
+	u32 fifo_size;
+
+	fifo_size = fxgmac_calculate_per_queue_fifo(pdata->hw_feat.tx_fifo_size,
+						    FXGMAC_TX_1_Q);
+
+	/* Each increment in the queue fifo size represents 256 bytes of
+	 * fifo, with 0 representing 256 bytes. Distribute the fifo equally
+	 * between the queues.
+	 */
+	fifo_size = (fifo_size + 1) * 256;
+
+	/* Packet size < TxQSize - (PBL + N)*(DATAWIDTH/8),
+	 * Datawidth = 128
+	 * If Datawidth = 32, N = 7, elseif Datawidth != 32, N = 5.
+	 * TxQSize is indicated by TQS field of MTL_TxQ#_Operation_Mode register
+	 * PBL = TxPBL field in the DMA_CH#_TX_Control register in all
+	 * DMA configurations.
+	 */
+	fifo_size -= (pdata->tx_pbl * (pdata->pblx8 ? 8 : 1) + 5) *
+		     (FXGMAC_DATA_WIDTH / 8);
+	fifo_size -= 256;
+
+	return fifo_size;
+}
+
+static void fxgmac_config_tx_fifo_size(struct fxgmac_pdata *pdata)
+{
+	u32 val, fifo_size;
+
+	fifo_size = fxgmac_calculate_per_queue_fifo(pdata->hw_feat.tx_fifo_size,
+						    FXGMAC_TX_1_Q);
+
+	val = rd32_mac(pdata, FXGMAC_MTL_REG(0, MTL_Q_TQOMR));
+	fxgmac_set_bits(&val, MTL_Q_TQOMR_TQS_POS, MTL_Q_TQOMR_TQS_LEN,
+			fifo_size);
+	wr32_mac(pdata, val, FXGMAC_MTL_REG(0, MTL_Q_TQOMR));
+
+	yt_dbg(pdata, "%d Tx hardware queues, %d byte fifo per queue\n",
+	       FXGMAC_TX_1_Q, ((fifo_size + 1) * 256));
+}
+
+static void fxgmac_config_rx_fifo_size(struct fxgmac_pdata *pdata)
+{
+	u32 val, fifo_size;
+
+	fifo_size = fxgmac_calculate_per_queue_fifo(pdata->hw_feat.rx_fifo_size,
+						    pdata->rx_q_count);
+
+	for (u32 i = 0; i < pdata->rx_q_count; i++) {
+		val = rd32_mac(pdata, FXGMAC_MTL_REG(i, MTL_Q_RQOMR));
+		fxgmac_set_bits(&val, MTL_Q_RQOMR_RQS_POS, MTL_Q_RQOMR_RQS_LEN,
+				fifo_size);
+		wr32_mac(pdata, val, FXGMAC_MTL_REG(i, MTL_Q_RQOMR));
+	}
+
+	yt_dbg(pdata, "%d Rx hardware queues, %d byte fifo per queue\n",
+	       pdata->rx_q_count, ((fifo_size + 1) * 256));
+}
+
+static void fxgmac_config_flow_control_threshold(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	for (u32 i = 0; i < pdata->rx_q_count; i++) {
+		val = rd32_mac(pdata, FXGMAC_MTL_REG(i, MTL_Q_RQOMR));
+		/* Activate flow control when less than 4k left in fifo */
+		fxgmac_set_bits(&val, MTL_Q_RQOMR_RFA_POS, MTL_Q_RQOMR_RFA_LEN,
+				6);
+		/* De-activate flow control when more than 6k left in fifo */
+		fxgmac_set_bits(&val, MTL_Q_RQOMR_RFD_POS, MTL_Q_RQOMR_RFD_LEN,
+				10);
+		wr32_mac(pdata, val, FXGMAC_MTL_REG(i, MTL_Q_RQOMR));
+	}
+}
+
+static void fxgmac_config_tx_threshold(struct fxgmac_pdata *pdata,
+				       unsigned int set_val)
+{
+	u32 val;
+
+	val = rd32_mac(pdata, FXGMAC_MTL_REG(0, MTL_Q_TQOMR));
+	fxgmac_set_bits(&val, MTL_Q_TQOMR_TTC_POS, MTL_Q_TQOMR_TTC_LEN,
+			set_val);
+	wr32_mac(pdata, val, FXGMAC_MTL_REG(0, MTL_Q_TQOMR));
+}
+
+static void fxgmac_config_rsf_mode(struct fxgmac_pdata *pdata,
+				   unsigned int set_val)
+{
+	u32 val;
+
+	for (u32 i = 0; i < pdata->rx_q_count; i++) {
+		val = rd32_mac(pdata, FXGMAC_MTL_REG(i, MTL_Q_RQOMR));
+		fxgmac_set_bits(&val, MTL_Q_RQOMR_RSF_POS, MTL_Q_RQOMR_RSF_LEN,
+				set_val);
+		wr32_mac(pdata, val, FXGMAC_MTL_REG(i, MTL_Q_RQOMR));
+	}
+}
+
+static void fxgmac_config_tsf_mode(struct fxgmac_pdata *pdata,
+				   unsigned int set_val)
+{
+	u32 val;
+
+	val = rd32_mac(pdata, FXGMAC_MTL_REG(0, MTL_Q_TQOMR));
+	fxgmac_set_bits(&val, MTL_Q_TQOMR_TSF_POS, MTL_Q_TQOMR_TSF_LEN,
+			set_val);
+	wr32_mac(pdata, val, FXGMAC_MTL_REG(0, MTL_Q_TQOMR));
+}
+
+static void fxgmac_config_osp_mode(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	u32 val;
+
+	val = rd32_mac(pdata, FXGMAC_DMA_REG(channel, DMA_CH_TCR));
+	fxgmac_set_bits(&val, DMA_CH_TCR_OSP_POS, DMA_CH_TCR_OSP_LEN,
+			pdata->tx_osp_mode);
+	wr32_mac(pdata, val, FXGMAC_DMA_REG(channel, DMA_CH_TCR));
+}
+
+static void fxgmac_config_pblx8(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	u32 val;
+
+	for (u32 i = 0; i < pdata->channel_count; i++, channel++) {
+		val = rd32_mac(pdata, FXGMAC_DMA_REG(channel, DMA_CH_CR));
+		fxgmac_set_bits(&val, DMA_CH_CR_PBLX8_POS, DMA_CH_CR_PBLX8_LEN,
+				pdata->pblx8);
+		wr32_mac(pdata, val, FXGMAC_DMA_REG(channel, DMA_CH_CR));
+	}
+}
+
+static void fxgmac_config_tx_pbl_val(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	u32 val;
+
+	val = rd32_mac(pdata, FXGMAC_DMA_REG(channel, DMA_CH_TCR));
+	fxgmac_set_bits(&val, DMA_CH_TCR_PBL_POS, DMA_CH_TCR_PBL_LEN,
+			pdata->tx_pbl);
+	wr32_mac(pdata, val, FXGMAC_DMA_REG(channel, DMA_CH_TCR));
+}
+
+static void fxgmac_config_rx_pbl_val(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	u32 val;
+
+	for (u32 i = 0; i < pdata->channel_count; i++, channel++) {
+		val = rd32_mac(pdata, FXGMAC_DMA_REG(channel, DMA_CH_RCR));
+		fxgmac_set_bits(&val, DMA_CH_RCR_PBL_POS, DMA_CH_RCR_PBL_LEN,
+				pdata->rx_pbl);
+		wr32_mac(pdata, val, FXGMAC_DMA_REG(channel, DMA_CH_RCR));
+	}
+}
+
+static void fxgmac_tx_mmc_int(struct fxgmac_pdata *yt)
+{
+	unsigned int mmc_isr = rd32_mac(yt, MMC_TISR);
+	struct fxgmac_stats *stats = &yt->stats;
+
+	if (mmc_isr & BIT(MMC_TISR_TXOCTETCOUNT_GB_POS))
+		stats->txoctetcount_gb += rd32_mac(yt, MMC_TXOCTETCOUNT_GB_LO);
+
+	if (mmc_isr & BIT(MMC_TISR_TXFRAMECOUNT_GB_POS))
+		stats->txframecount_gb += rd32_mac(yt, MMC_TXFRAMECOUNT_GB_LO);
+
+	if (mmc_isr & BIT(MMC_TISR_TXBROADCASTFRAMES_G_POS))
+		stats->txbroadcastframes_g +=
+			rd32_mac(yt, MMC_TXBROADCASTFRAMES_G_LO);
+
+	if (mmc_isr & BIT(MMC_TISR_TXMULTICASTFRAMES_G_POS))
+		stats->txmulticastframes_g +=
+			rd32_mac(yt, MMC_TXMULTICASTFRAMES_G_LO);
+
+	if (mmc_isr & BIT(MMC_TISR_TX64OCTETS_GB_POS))
+		stats->tx64octets_gb += rd32_mac(yt, MMC_TX64OCTETS_GB_LO);
+
+	if (mmc_isr & BIT(MMC_TISR_TX65TO127OCTETS_GB_POS))
+		stats->tx65to127octets_gb +=
+			rd32_mac(yt, MMC_TX65TO127OCTETS_GB_LO);
+
+	if (mmc_isr & BIT(MMC_TISR_TX128TO255OCTETS_GB_POS))
+		stats->tx128to255octets_gb +=
+			rd32_mac(yt, MMC_TX128TO255OCTETS_GB_LO);
+
+	if (mmc_isr & BIT(MMC_TISR_TX256TO511OCTETS_GB_POS))
+		stats->tx256to511octets_gb +=
+			rd32_mac(yt, MMC_TX256TO511OCTETS_GB_LO);
+
+	if (mmc_isr & BIT(MMC_TISR_TX512TO1023OCTETS_GB_POS))
+		stats->tx512to1023octets_gb +=
+			rd32_mac(yt, MMC_TX512TO1023OCTETS_GB_LO);
+
+	if (mmc_isr & BIT(MMC_TISR_TX1024TOMAXOCTETS_GB_POS))
+		stats->tx1024tomaxoctets_gb +=
+			rd32_mac(yt, MMC_TX1024TOMAXOCTETS_GB_LO);
+
+	if (mmc_isr & BIT(MMC_TISR_TXUNICASTFRAMES_GB_POS))
+		stats->txunicastframes_gb +=
+			rd32_mac(yt, MMC_TXUNICASTFRAMES_GB_LO);
+
+	if (mmc_isr & BIT(MMC_TISR_TXMULTICASTFRAMES_GB_POS))
+		stats->txmulticastframes_gb +=
+			rd32_mac(yt, MMC_TXMULTICASTFRAMES_GB_LO);
+
+	if (mmc_isr & BIT(MMC_TISR_TXBROADCASTFRAMES_GB_POS))
+		stats->txbroadcastframes_g +=
+			rd32_mac(yt, MMC_TXBROADCASTFRAMES_GB_LO);
+
+	if (mmc_isr & BIT(MMC_TISR_TXUNDERFLOWERROR_POS))
+		stats->txunderflowerror +=
+			rd32_mac(yt, MMC_TXUNDERFLOWERROR_LO);
+
+	if (mmc_isr & BIT(MMC_TISR_TXSINGLECOLLISION_G_POS))
+		stats->txsinglecollision_g +=
+			rd32_mac(yt, MMC_TXSINGLECOLLISION_G);
+
+	if (mmc_isr & BIT(MMC_TISR_TXMULTIPLECOLLISION_G_POS))
+		stats->txmultiplecollision_g +=
+			rd32_mac(yt, MMC_TXMULTIPLECOLLISION_G);
+
+	if (mmc_isr & BIT(MMC_TISR_TXDEFERREDFRAMES_POS))
+		stats->txdeferredframes += rd32_mac(yt, MMC_TXDEFERREDFRAMES);
+
+	if (mmc_isr & BIT(MMC_TISR_TXLATECOLLISIONFRAMES_POS))
+		stats->txlatecollisionframes +=
+			rd32_mac(yt, MMC_TXLATECOLLISIONFRAMES);
+
+	if (mmc_isr & BIT(MMC_TISR_TXEXCESSIVECOLLISIONFRAMES_POS))
+		stats->txexcessivecollisionframes +=
+			rd32_mac(yt, MMC_TXEXCESSIVECOLLSIONFRAMES);
+
+	if (mmc_isr & BIT(MMC_TISR_TXCARRIERERRORFRAMES_POS))
+		stats->txcarriererrorframes +=
+			rd32_mac(yt, MMC_TXCARRIERERRORFRAMES);
+
+	if (mmc_isr & BIT(MMC_TISR_TXOCTETCOUNT_G_POS))
+		stats->txoctetcount_g += rd32_mac(yt, MMC_TXOCTETCOUNT_G_LO);
+
+	if (mmc_isr & BIT(MMC_TISR_TXFRAMECOUNT_G_POS))
+		stats->txframecount_g += rd32_mac(yt, MMC_TXFRAMECOUNT_G_LO);
+
+	if (mmc_isr & BIT(MMC_TISR_TXEXCESSIVEDEFERRALFRAMES_POS))
+		stats->txexcessivedeferralerror +=
+			rd32_mac(yt, MMC_TXEXCESSIVEDEFERRALERROR);
+
+	if (mmc_isr & BIT(MMC_TISR_TXPAUSEFRAMES_POS))
+		stats->txpauseframes += rd32_mac(yt, MMC_TXPAUSEFRAMES_LO);
+
+	if (mmc_isr & BIT(MMC_TISR_TXVLANFRAMES_G_POS))
+		stats->txvlanframes_g += rd32_mac(yt, MMC_TXVLANFRAMES_G_LO);
+
+	if (mmc_isr & BIT(MMC_TISR_TXOVERSIZE_G_POS))
+		stats->txoversize_g += rd32_mac(yt, MMC_TXOVERSIZEFRAMES);
+}
+
+static void fxgmac_rx_mmc_int(struct fxgmac_pdata *yt)
+{
+	unsigned int mmc_isr = rd32_mac(yt, MMC_RISR);
+	struct fxgmac_stats *stats = &yt->stats;
+
+	if (mmc_isr & BIT(MMC_RISR_RXFRAMECOUNT_GB_POS))
+		stats->rxframecount_gb += rd32_mac(yt, MMC_RXFRAMECOUNT_GB_LO);
+
+	if (mmc_isr & BIT(MMC_RISR_RXOCTETCOUNT_GB_POS))
+		stats->rxoctetcount_gb += rd32_mac(yt, MMC_RXOCTETCOUNT_GB_LO);
+
+	if (mmc_isr & BIT(MMC_RISR_RXOCTETCOUNT_G_POS))
+		stats->rxoctetcount_g += rd32_mac(yt, MMC_RXOCTETCOUNT_G_LO);
+
+	if (mmc_isr & BIT(MMC_RISR_RXBROADCASTFRAMES_G_POS))
+		stats->rxbroadcastframes_g +=
+			rd32_mac(yt, MMC_RXBROADCASTFRAMES_G_LO);
+
+	if (mmc_isr & BIT(MMC_RISR_RXMULTICASTFRAMES_G_POS))
+		stats->rxmulticastframes_g +=
+			rd32_mac(yt, MMC_RXMULTICASTFRAMES_G_LO);
+
+	if (mmc_isr & BIT(MMC_RISR_RXCRCERROR_POS))
+		stats->rxcrcerror += rd32_mac(yt, MMC_RXCRCERROR_LO);
+
+	if (mmc_isr & BIT(MMC_RISR_RXALIGNERROR_POS))
+		stats->rxalignerror += rd32_mac(yt, MMC_RXALIGNERROR);
+
+	if (mmc_isr & BIT(MMC_RISR_RXRUNTERROR_POS))
+		stats->rxrunterror += rd32_mac(yt, MMC_RXRUNTERROR);
+
+	if (mmc_isr & BIT(MMC_RISR_RXJABBERERROR_POS))
+		stats->rxjabbererror += rd32_mac(yt, MMC_RXJABBERERROR);
+
+	if (mmc_isr & BIT(MMC_RISR_RXUNDERSIZE_G_POS))
+		stats->rxundersize_g += rd32_mac(yt, MMC_RXUNDERSIZE_G);
+
+	if (mmc_isr & BIT(MMC_RISR_RXOVERSIZE_G_POS))
+		stats->rxoversize_g += rd32_mac(yt, MMC_RXOVERSIZE_G);
+
+	if (mmc_isr & BIT(MMC_RISR_RX64OCTETS_GB_POS))
+		stats->rx64octets_gb += rd32_mac(yt, MMC_RX64OCTETS_GB_LO);
+
+	if (mmc_isr & BIT(MMC_RISR_RX65TO127OCTETS_GB_POS))
+		stats->rx65to127octets_gb +=
+			rd32_mac(yt, MMC_RX65TO127OCTETS_GB_LO);
+
+	if (mmc_isr & BIT(MMC_RISR_RX128TO255OCTETS_GB_POS))
+		stats->rx128to255octets_gb +=
+			rd32_mac(yt, MMC_RX128TO255OCTETS_GB_LO);
+
+	if (mmc_isr & BIT(MMC_RISR_RX256TO511OCTETS_GB_POS))
+		stats->rx256to511octets_gb +=
+			rd32_mac(yt, MMC_RX256TO511OCTETS_GB_LO);
+
+	if (mmc_isr & BIT(MMC_RISR_RX512TO1023OCTETS_GB_POS))
+		stats->rx512to1023octets_gb +=
+			rd32_mac(yt, MMC_RX512TO1023OCTETS_GB_LO);
+
+	if (mmc_isr & BIT(MMC_RISR_RX1024TOMAXOCTETS_GB_POS))
+		stats->rx1024tomaxoctets_gb +=
+			rd32_mac(yt, MMC_RX1024TOMAXOCTETS_GB_LO);
+
+	if (mmc_isr & BIT(MMC_RISR_RXUNICASTFRAMES_G_POS))
+		stats->rxunicastframes_g +=
+			rd32_mac(yt, MMC_RXUNICASTFRAMES_G_LO);
+
+	if (mmc_isr & BIT(MMC_RISR_RXLENGTHERROR_POS))
+		stats->rxlengtherror += rd32_mac(yt, MMC_RXLENGTHERROR_LO);
+
+	if (mmc_isr & BIT(MMC_RISR_RXOUTOFRANGETYPE_POS))
+		stats->rxoutofrangetype +=
+			rd32_mac(yt, MMC_RXOUTOFRANGETYPE_LO);
+
+	if (mmc_isr & BIT(MMC_RISR_RXPAUSEFRAMES_POS))
+		stats->rxpauseframes += rd32_mac(yt, MMC_RXPAUSEFRAMES_LO);
+
+	if (mmc_isr & BIT(MMC_RISR_RXFIFOOVERFLOW_POS))
+		stats->rxfifooverflow += rd32_mac(yt, MMC_RXFIFOOVERFLOW_LO);
+
+	if (mmc_isr & BIT(MMC_RISR_RXVLANFRAMES_GB_POS))
+		stats->rxvlanframes_gb += rd32_mac(yt, MMC_RXVLANFRAMES_GB_LO);
+
+	if (mmc_isr & BIT(MMC_RISR_RXWATCHDOGERROR_POS))
+		stats->rxwatchdogerror += rd32_mac(yt, MMC_RXWATCHDOGERROR);
+
+	if (mmc_isr & BIT(MMC_RISR_RXERRORFRAMES_POS))
+		stats->rxreceiveerrorframe +=
+			rd32_mac(yt, MMC_RXRECEIVEERRORFRAME);
+
+	if (mmc_isr & BIT(MMC_RISR_RXERRORCONTROLFRAMES_POS))
+		stats->rxcontrolframe_g += rd32_mac(yt, MMC_RXCONTROLFRAME_G);
+}
+
+static void fxgmac_config_mmc(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	/* Set counters to reset on read, Reset the counters */
+	val = rd32_mac(pdata, MMC_CR);
+	fxgmac_set_bits(&val, MMC_CR_ROR_POS, MMC_CR_ROR_LEN, 1);
+	fxgmac_set_bits(&val, MMC_CR_CR_POS, MMC_CR_CR_LEN, 1);
+	wr32_mac(pdata, val, MMC_CR);
+
+	wr32_mac(pdata, 0xffffffff, MMC_IPCRXINTMASK);
+}
+
+static u32 fxgmac_read_rss_options(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mem(pdata, MGMT_RSS_CTRL);
+	val = FXGMAC_GET_BITS(val, MGMT_RSS_CTRL_OPT_POS,
+			      MGMT_RSS_CTRL_OPT_LEN);
+
+	return val;
+}
+
+static void fxgmac_write_rss_options(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mem(pdata, MGMT_RSS_CTRL);
+	fxgmac_set_bits(&val, MGMT_RSS_CTRL_OPT_POS, MGMT_RSS_CTRL_OPT_LEN,
+			pdata->rss_options);
+	wr32_mem(pdata, val, MGMT_RSS_CTRL);
+}
+
+static void fxgmac_write_rss_hash_key(struct fxgmac_pdata *pdata)
+{
+	unsigned int key_regs = sizeof(pdata->rss_key) / sizeof(u32);
+	u32 *key = (u32 *)&pdata->rss_key;
+
+	while (key_regs--) {
+		wr32_mem(pdata, cpu_to_be32(*key),
+			 MGMT_RSS_KEY0 + key_regs * MGMT_RSS_KEY_INC);
+		key++;
+	}
+}
+
+static void fxgmac_write_rss_lookup_table(struct fxgmac_pdata *pdata)
+{
+	u32 i, j, val = 0;
+
+	for (i = 0, j = 0; i < ARRAY_SIZE(pdata->rss_table); i++, j++) {
+		if (j < MGMT_RSS_IDT_ENTRY_SIZE) {
+			val |= ((pdata->rss_table[i] & MGMT_RSS_IDT_ENTRY_MASK)
+				<< (j * 2));
+			continue;
+		}
+
+		wr32_mem(pdata, val,
+			 MGMT_RSS_IDT + (i / MGMT_RSS_IDT_ENTRY_SIZE - 1) *
+						MGMT_RSS_IDT_INC);
+		val = pdata->rss_table[i];
+		j = 0;
+	}
+
+	if (j != MGMT_RSS_IDT_ENTRY_SIZE)
+		return;
+
+	/* Last IDT */
+	wr32_mem(pdata, val,
+		 MGMT_RSS_IDT +
+			 (i / MGMT_RSS_IDT_ENTRY_SIZE - 1) * MGMT_RSS_IDT_INC);
+}
+
+static void fxgmac_set_rss_hash_key(struct fxgmac_pdata *pdata, const u8 *key)
+{
+	memcpy(pdata->rss_key, key, sizeof(pdata->rss_key));
+	fxgmac_write_rss_hash_key(pdata);
+}
+
+static u32 log2ex(u32 value)
+{
+	u32 i = 31;
+
+	while (i > 0) {
+		if (value & 0x80000000)
+			break;
+
+		value <<= 1;
+		i--;
+	}
+	return i;
+}
+
+static void fxgmac_enable_rss(struct fxgmac_pdata *pdata)
+{
+	u32 val, size = 0;
+
+	fxgmac_write_rss_hash_key(pdata);
+	fxgmac_write_rss_lookup_table(pdata);
+
+	/* Set RSS IDT table size, Enable RSS, Set the RSS options */
+	val = rd32_mem(pdata, MGMT_RSS_CTRL);
+	size = log2ex(FXGMAC_RSS_MAX_TABLE_SIZE) - 1;
+	fxgmac_set_bits(&val, MGMT_RSS_CTRL_TBL_SIZE_POS,
+			MGMT_RSS_CTRL_TBL_SIZE_LEN, size);
+	fxgmac_set_bits(&val, MGMT_RSS_CTRL_RSSE_POS, MGMT_RSS_CTRL_RSSE_LEN,
+			1);
+	fxgmac_set_bits(&val, MGMT_RSS_CTRL_OPT_POS, MGMT_RSS_CTRL_OPT_LEN,
+			pdata->rss_options);
+	wr32_mem(pdata, val, MGMT_RSS_CTRL);
+}
+
+static void fxgmac_disable_rss(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mem(pdata, MGMT_RSS_CTRL);
+	fxgmac_set_bits(&val, MGMT_RSS_CTRL_RSSE_POS, MGMT_RSS_CTRL_RSSE_LEN,
+			0);
+	wr32_mem(pdata, val, MGMT_RSS_CTRL);
+}
+
+static void fxgmac_config_rss(struct fxgmac_pdata *pdata)
+{
+	if (pdata->rss)
+		fxgmac_enable_rss(pdata);
+	else
+		fxgmac_disable_rss(pdata);
+}
+
+static int fxgmac_check_wake_pattern_fifo_pointer(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mac(pdata, MAC_PMT_STA);
+	fxgmac_set_bits(&val, MAC_PMT_STA_RWKFILTERST_POS,
+			MAC_PMT_STA_RWKFILTERST_LEN, 1);
+	wr32_mac(pdata, val, MAC_PMT_STA);
+
+	val = rd32_mac(pdata, MAC_PMT_STA);
+	val = FXGMAC_GET_BITS(val, MAC_PMT_STA_RWKPTR_POS,
+			      MAC_PMT_STA_RWKPTR_LEN);
+	if (val != 0) {
+		yt_err(pdata, "Remote fifo pointer is not 0\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void fxgmac_enable_dma_interrupts(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	u32 dma_ch;
+
+	for (u32 i = 0; i < pdata->channel_count; i++, channel++) {
+		/* Clear all the interrupts which are set */
+		dma_ch = rd32_mac(pdata, FXGMAC_DMA_REG(channel, DMA_CH_SR));
+		wr32_mac(pdata, dma_ch, FXGMAC_DMA_REG(channel, DMA_CH_SR));
+
+		dma_ch = 0; /* Clear all interrupt enable bits */
+
+		/* Enable following interrupts
+		 * NIE  - Normal Interrupt Summary Enable
+		 * FBEE - Fatal Bus Error Enable
+		 */
+		fxgmac_set_bits(&dma_ch, DMA_CH_IER_NIE_POS, DMA_CH_IER_NIE_LEN,
+				1);
+		fxgmac_set_bits(&dma_ch, DMA_CH_IER_FBEE_POS,
+				DMA_CH_IER_FBEE_LEN, 1);
+
+		if (FXGMAC_IS_CHANNEL_WITH_TX_IRQ(i) && channel->tx_ring) {
+			/* Enable the following Tx interrupts
+			 * TIE  - Transmit Interrupt Enable (unless using
+			 * per channel interrupts)
+			 */
+			fxgmac_set_bits(&dma_ch, DMA_CH_IER_TIE_POS,
+					DMA_CH_IER_TIE_LEN, 1);
+		}
+		if (channel->rx_ring) {
+			/* Enable following Rx interrupts
+			 * RBUE - Receive Buffer Unavailable Enable
+			 * RIE  - Receive Interrupt Enable (unless using
+			 * per channel interrupts)
+			 */
+			fxgmac_set_bits(&dma_ch, DMA_CH_IER_RBUE_POS,
+					DMA_CH_IER_RBUE_LEN, 1);
+			fxgmac_set_bits(&dma_ch, DMA_CH_IER_RIE_POS,
+					DMA_CH_IER_RIE_LEN, 1);
+		}
+
+		wr32_mac(pdata, dma_ch, FXGMAC_DMA_REG(channel, DMA_CH_IER));
+	}
+}
+
+static void fxgmac_enable_mtl_interrupts(struct fxgmac_pdata *pdata)
+{
+	unsigned int mtl_q_isr;
+
+	for (u32 i = 0; i < pdata->hw_feat.rx_q_cnt; i++) {
+		/* Clear all the interrupts which are set */
+		mtl_q_isr = rd32_mac(pdata, FXGMAC_MTL_REG(i, MTL_Q_ISR));
+		wr32_mac(pdata, mtl_q_isr, FXGMAC_MTL_REG(i, MTL_Q_ISR));
+
+		/* No MTL interrupts to be enabled */
+		wr32_mac(pdata, 0, FXGMAC_MTL_REG(i, MTL_Q_IER));
+	}
+}
+
+#define FXGMAC_MMC_IER_ALL_DEFAULT 0
+static void fxgmac_enable_mac_interrupts(struct fxgmac_pdata *pdata)
+{
+	u32 val, ier = 0;
+
+	/* Enable Timestamp interrupt */
+	fxgmac_set_bits(&ier, MAC_IER_TSIE_POS, MAC_IER_TSIE_LEN, 1);
+	wr32_mac(pdata, ier, MAC_IER);
+
+	val = rd32_mac(pdata, MMC_RIER);
+	fxgmac_set_bits(&val, MMC_RIER_ALL_INTERRUPTS_POS,
+			MMC_RIER_ALL_INTERRUPTS_LEN,
+			FXGMAC_MMC_IER_ALL_DEFAULT);
+	wr32_mac(pdata, val, MMC_RIER);
+
+	val = rd32_mac(pdata, MMC_TIER);
+	fxgmac_set_bits(&val, MMC_TIER_ALL_INTERRUPTS_POS,
+			MMC_TIER_ALL_INTERRUPTS_LEN,
+			FXGMAC_MMC_IER_ALL_DEFAULT);
+	wr32_mac(pdata, val, MMC_TIER);
+}
+
+static void fxgmac_config_mac_speed(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mac(pdata, MAC_CR);
+	if (pdata->phy_duplex != DUPLEX_UNKNOWN)
+		fxgmac_set_bits(&val, MAC_CR_DM_POS, MAC_CR_DM_LEN, pdata->phy_duplex);
+
+	switch (pdata->phy_speed) {
+	case SPEED_1000:
+		fxgmac_set_bits(&val, MAC_CR_PS_POS, MAC_CR_PS_LEN, 0);
+		fxgmac_set_bits(&val, MAC_CR_FES_POS, MAC_CR_FES_LEN, 0);
+		break;
+	case SPEED_100:
+		fxgmac_set_bits(&val, MAC_CR_PS_POS, MAC_CR_PS_LEN, 1);
+		fxgmac_set_bits(&val, MAC_CR_FES_POS, MAC_CR_FES_LEN, 1);
+		break;
+	case SPEED_10:
+		fxgmac_set_bits(&val, MAC_CR_PS_POS, MAC_CR_PS_LEN, 1);
+		fxgmac_set_bits(&val, MAC_CR_FES_POS, MAC_CR_FES_LEN, 0);
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	}
+
+	wr32_mac(pdata, val, MAC_CR);
+}
+
+static int mdio_loop_wait(struct fxgmac_pdata *pdata, u32 max_cnt)
+{
+	u32 val, i;
+
+	for (i = 0; i < max_cnt; i++) {
+		val = rd32_mac(pdata, MAC_MDIO_ADDRESS);
+		if ((val & MAC_MDIO_ADDR_BUSY) == 0)
+			break;
+
+		fsleep(10);
+	}
+
+	if (i >= max_cnt) {
+		WARN_ON(1);
+		yt_err(pdata, "%s timeout. used cnt:%d, reg_val=%x.\n",
+		       __func__, i + 1, val);
+
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+#define PHY_MDIO_MAX_TRY			50
+#define PHY_WR_CONFIG(reg_offset)		(0x8000205 + ((reg_offset) * 0x10000))
+static int fxgmac_phy_write_reg(struct fxgmac_pdata *pdata, u32 reg_id, u32 data)
+{
+	int ret;
+
+	wr32_mac(pdata, data, MAC_MDIO_DATA);
+	wr32_mac(pdata, PHY_WR_CONFIG(reg_id), MAC_MDIO_ADDRESS);
+	ret = mdio_loop_wait(pdata, PHY_MDIO_MAX_TRY);
+	if (ret < 0)
+		return ret;
+
+	yt_dbg(pdata, "%s, id:%x %s, ctrl:0x%08x, data:0x%08x\n", __func__,
+	       reg_id, (ret == 0) ? "ok" : "err", PHY_WR_CONFIG(reg_id), data);
+
+	return ret;
+}
+
+#define PHY_RD_CONFIG(reg_offset)		(0x800020d + ((reg_offset) * 0x10000))
+static int fxgmac_phy_read_reg(struct fxgmac_pdata *pdata, u32 reg_id)
+{
+	u32 val;
+	int ret;
+
+	wr32_mac(pdata, PHY_RD_CONFIG(reg_id), MAC_MDIO_ADDRESS);
+	ret =  mdio_loop_wait(pdata, PHY_MDIO_MAX_TRY);
+	if (ret < 0)
+		return ret;
+
+	val = rd32_mac(pdata, MAC_MDIO_DATA);  /* Read data */
+	yt_dbg(pdata, "%s, id:%x ok, ctrl:0x%08x, val:0x%08x.\n", __func__,
+	       reg_id, PHY_RD_CONFIG(reg_id), val);
+
+	return val;
+}
+
+static int fxgmac_config_flow_control(struct fxgmac_pdata *pdata)
+{
+	u32 val = 0;
+	int ret;
+
+	fxgmac_config_tx_flow_control(pdata);
+	fxgmac_config_rx_flow_control(pdata);
+
+	/* Set auto negotiation advertisement pause ability */
+	if (pdata->tx_pause || pdata->rx_pause)
+		val |= ADVERTISE_PAUSE_CAP | ADVERTISE_PAUSE_ASYM;
+
+	ret = phy_modify(pdata->phydev, MII_ADVERTISE,
+			 ADVERTISE_PAUSE_CAP | ADVERTISE_PAUSE_ASYM, val);
+	if (ret < 0)
+		return ret;
+
+	return phy_modify(pdata->phydev, MII_BMCR, BMCR_RESET, BMCR_RESET);
+}
+
+static void fxgmac_phy_reset(struct fxgmac_pdata *pdata)
+{
+	u32 val = 0;
+
+	fxgmac_set_bits(&val, EPHY_CTRL_RESET_POS, EPHY_CTRL_RESET_LEN,
+			EPHY_CTRL_STA_RESET);
+	wr32_mem(pdata, val, EPHY_CTRL);
+	fsleep(1500);
+}
+
+static void fxgmac_phy_release(struct fxgmac_pdata *pdata)
+{
+	u32 val = 0;
+
+	fxgmac_set_bits(&val, EPHY_CTRL_RESET_POS, EPHY_CTRL_RESET_LEN,
+			EPHY_CTRL_STA_RELEASE);
+	wr32_mem(pdata, val, EPHY_CTRL);
+	fsleep(100);
+}
+
+static void fxgmac_enable_channel_irq(struct fxgmac_channel *channel,
+				      enum fxgmac_int int_id)
+{
+	struct fxgmac_pdata *pdata = channel->pdata;
+	unsigned int dma_ch_ier;
+
+	dma_ch_ier = rd32_mac(pdata, FXGMAC_DMA_REG(channel, DMA_CH_IER));
+
+	switch (int_id) {
+	case FXGMAC_INT_DMA_CH_SR_TI:
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_TIE_POS,
+				DMA_CH_IER_TIE_LEN, 1);
+		break;
+	case FXGMAC_INT_DMA_CH_SR_TPS:
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_TXSE_POS,
+				DMA_CH_IER_TXSE_LEN, 1);
+		break;
+	case FXGMAC_INT_DMA_CH_SR_TBU:
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_TBUE_POS,
+				DMA_CH_IER_TBUE_LEN, 1);
+		break;
+	case FXGMAC_INT_DMA_CH_SR_RI:
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_RIE_POS,
+				DMA_CH_IER_RIE_LEN, 1);
+		break;
+	case FXGMAC_INT_DMA_CH_SR_RBU:
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_RBUE_POS,
+				DMA_CH_IER_RBUE_LEN, 1);
+		break;
+	case FXGMAC_INT_DMA_CH_SR_RPS:
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_RSE_POS,
+				DMA_CH_IER_RSE_LEN, 1);
+		break;
+	case FXGMAC_INT_DMA_CH_SR_TI_RI:
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_TIE_POS,
+				DMA_CH_IER_TIE_LEN, 1);
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_RIE_POS,
+				DMA_CH_IER_RIE_LEN, 1);
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_NIE_POS,
+				DMA_CH_IER_NIE_LEN, 1);
+		break;
+	case FXGMAC_INT_DMA_CH_SR_FBE:
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_FBEE_POS,
+				DMA_CH_IER_FBEE_LEN, 1);
+		break;
+	case FXGMAC_INT_DMA_ALL:
+		dma_ch_ier |= channel->saved_ier;
+		break;
+	default:
+		WARN_ON(1);
+		return;
+	}
+
+	wr32_mac(pdata, dma_ch_ier, FXGMAC_DMA_REG(channel, DMA_CH_IER));
+}
+
+static void fxgmac_disable_channel_irq(struct fxgmac_channel *channel,
+				       enum fxgmac_int int_id)
+{
+	struct fxgmac_pdata *pdata = channel->pdata;
+	u32 dma_ch_ier;
+
+	dma_ch_ier = rd32_mac(channel->pdata,
+			      FXGMAC_DMA_REG(channel, DMA_CH_IER));
+
+	switch (int_id) {
+	case FXGMAC_INT_DMA_CH_SR_TI:
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_TIE_POS,
+				DMA_CH_IER_TIE_LEN, 0);
+		break;
+	case FXGMAC_INT_DMA_CH_SR_TPS:
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_TXSE_POS,
+				DMA_CH_IER_TXSE_LEN, 0);
+		break;
+	case FXGMAC_INT_DMA_CH_SR_TBU:
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_TBUE_POS,
+				DMA_CH_IER_TBUE_LEN, 0);
+		break;
+	case FXGMAC_INT_DMA_CH_SR_RI:
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_RIE_POS,
+				DMA_CH_IER_RIE_LEN, 0);
+		break;
+	case FXGMAC_INT_DMA_CH_SR_RBU:
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_RBUE_POS,
+				DMA_CH_IER_RBUE_LEN, 0);
+		break;
+	case FXGMAC_INT_DMA_CH_SR_RPS:
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_RSE_POS,
+				DMA_CH_IER_RSE_LEN, 0);
+		break;
+	case FXGMAC_INT_DMA_CH_SR_TI_RI:
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_TIE_POS,
+				DMA_CH_IER_TIE_LEN, 0);
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_RIE_POS,
+				DMA_CH_IER_RIE_LEN, 0);
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_NIE_POS,
+				DMA_CH_IER_NIE_LEN, 0);
+		break;
+	case FXGMAC_INT_DMA_CH_SR_FBE:
+		fxgmac_set_bits(&dma_ch_ier, DMA_CH_IER_FBEE_POS,
+				DMA_CH_IER_FBEE_LEN, 0);
+		break;
+	case FXGMAC_INT_DMA_ALL:
+#define FXGMAC_DMA_INTERRUPT_MASK 0x31c7
+		channel->saved_ier = dma_ch_ier & FXGMAC_DMA_INTERRUPT_MASK;
+		dma_ch_ier &= ~FXGMAC_DMA_INTERRUPT_MASK;
+		break;
+	default:
+		WARN_ON(1);
+		return;
+	}
+
+	wr32_mac(pdata, dma_ch_ier, FXGMAC_DMA_REG(channel, DMA_CH_IER));
+}
+
+static void fxgmac_dismiss_all_int(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_channel *channel = pdata->channel_head;
+	u32 val, i;
+
+	for (i = 0; i < pdata->channel_count; i++, channel++) {
+		/* Clear all the interrupts which are set */
+		val = rd32_mac(pdata, FXGMAC_DMA_REG(channel, DMA_CH_SR));
+		wr32_mac(pdata, val, FXGMAC_DMA_REG(channel, DMA_CH_SR));
+	}
+
+	for (i = 0; i < pdata->hw_feat.rx_q_cnt; i++) {
+		/* Clear all the interrupts which are set */
+		val = rd32_mac(pdata, FXGMAC_MTL_REG(i, MTL_Q_ISR));
+		wr32_mac(pdata, val, FXGMAC_MTL_REG(i, MTL_Q_ISR));
+	}
+
+	rd32_mac(pdata, MAC_ISR); /* Clear all MAC interrupts */
+	/* Clear MAC tx/rx error interrupts */
+	rd32_mac(pdata, MAC_TX_RX_STA);
+	rd32_mac(pdata, MAC_PMT_STA);
+	rd32_mac(pdata, MAC_LPI_STA);
+
+	val = rd32_mac(pdata, MAC_DBG_STA);
+	wr32_mac(pdata, val, MAC_DBG_STA); /* Write clear */
+}
+
+static void fxgmac_set_interrupt_moderation(struct fxgmac_pdata *pdata)
+{
+	u32 val = 0, time;
+
+	time = (pdata->intr_mod) ? pdata->tx_usecs : 0;
+	fxgmac_set_bits(&val, INT_MOD_TX_POS, INT_MOD_TX_LEN, time);
+
+	time = (pdata->intr_mod) ? pdata->rx_usecs : 0;
+	fxgmac_set_bits(&val, INT_MOD_RX_POS, INT_MOD_RX_LEN, time);
+	wr32_mem(pdata, val, INT_MOD);
+}
+
+static void fxgmac_enable_msix_one_irq(struct fxgmac_pdata *pdata, u32 intid)
+{
+	wr32_mem(pdata, 0, MSIX_TBL_MASK + intid * 16);
+}
+
+static void fxgmac_disable_msix_one_irq(struct fxgmac_pdata *pdata, u32 intid)
+{
+	wr32_mem(pdata, 1, MSIX_TBL_MASK + intid * 16);
+}
+
+static void fxgmac_enable_mgm_irq(struct fxgmac_pdata *pdata)
+{
+	u32 val = 0;
+
+	fxgmac_set_bits(&val, MGMT_INT_CTRL0_INT_MASK_POS,
+			MGMT_INT_CTRL0_INT_MASK_LEN,
+			MGMT_INT_CTRL0_INT_MASK_DISABLE);
+	wr32_mem(pdata, val, MGMT_INT_CTRL0);
+}
+
+static void fxgmac_disable_mgm_irq(struct fxgmac_pdata *pdata)
+{
+	u32 val = 0;
+
+	fxgmac_set_bits(&val, MGMT_INT_CTRL0_INT_MASK_POS,
+			MGMT_INT_CTRL0_INT_MASK_LEN,
+			MGMT_INT_CTRL0_INT_MASK_MASK);
+	wr32_mem(pdata, val, MGMT_INT_CTRL0);
+}
+
+static int fxgmac_flush_tx_queues(struct fxgmac_pdata *pdata)
+{
+	u32 val, count;
+
+	val = rd32_mac(pdata, FXGMAC_MTL_REG(0, MTL_Q_TQOMR));
+	fxgmac_set_bits(&val, MTL_Q_TQOMR_FTQ_POS, MTL_Q_TQOMR_FTQ_LEN,
+			1);
+	wr32_mac(pdata, val, FXGMAC_MTL_REG(0, MTL_Q_TQOMR));
+
+	count = 2000;
+	do {
+		fsleep(20);
+		val = rd32_mac(pdata, FXGMAC_MTL_REG(0, MTL_Q_TQOMR));
+		val = FXGMAC_GET_BITS(val, MTL_Q_TQOMR_FTQ_POS,
+				      MTL_Q_TQOMR_FTQ_LEN);
+
+	} while (--count && val);
+
+	if (val)
+		return -EBUSY;
+
+	return 0;
+}
+
+static void fxgmac_config_dma_bus(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mac(pdata, DMA_SBMR);
+	/* Set enhanced addressing mode */
+	fxgmac_set_bits(&val, DMA_SBMR_EAME_POS, DMA_SBMR_EAME_LEN, 1);
+
+	/* Out standing read/write requests */
+	fxgmac_set_bits(&val, DMA_SBMR_RD_OSR_LMT_POS, DMA_SBMR_RD_OSR_LMT_LEN,
+			0x7);
+	fxgmac_set_bits(&val, DMA_SBMR_WR_OSR_LMT_POS, DMA_SBMR_WR_OSR_LMT_LEN,
+			0x7);
+
+	/* Set the System Bus mode */
+	fxgmac_set_bits(&val, DMA_SBMR_FB_POS, DMA_SBMR_FB_LEN, 0);
+	fxgmac_set_bits(&val, DMA_SBMR_BLEN_4_POS, DMA_SBMR_BLEN_4_LEN, 1);
+	fxgmac_set_bits(&val, DMA_SBMR_BLEN_8_POS, DMA_SBMR_BLEN_8_LEN, 1);
+	fxgmac_set_bits(&val, DMA_SBMR_BLEN_16_POS, DMA_SBMR_BLEN_16_LEN, 1);
+	fxgmac_set_bits(&val, DMA_SBMR_BLEN_32_POS, DMA_SBMR_BLEN_32_LEN, 1);
+	wr32_mac(pdata, val, DMA_SBMR);
+}
+
+static int fxgmac_phy_clear_interrupt(struct fxgmac_pdata *pdata)
+{
+	u32 stats_pre, stats;
+
+	if (mutex_trylock(&pdata->phydev->mdio.bus->mdio_lock) == 0) {
+		yt_dbg(pdata, "lock not ready!\n");
+		return 0;
+	}
+
+	stats_pre = fxgmac_phy_read_reg(pdata, PHY_INT_STATUS);
+	if (stats_pre < 0)
+		goto unlock;
+
+	stats = fxgmac_phy_read_reg(pdata, PHY_INT_STATUS);
+	if (stats < 0)
+		goto unlock;
+
+	phy_unlock_mdio_bus(pdata->phydev);
+
+#define LINK_DOWN	0x800
+#define LINK_UP		0x400
+#define LINK_CHANGE	(LINK_DOWN | LINK_UP)
+	if ((stats_pre & LINK_CHANGE) != (stats & LINK_CHANGE)) {
+		yt_dbg(pdata, "phy link change\n");
+		return 1;
+	}
+
+	return 0;
+unlock:
+	phy_unlock_mdio_bus(pdata->phydev);
+	yt_err(pdata, "fxgmac_phy_read_reg err!\n");
+	return  -ETIMEDOUT;
+}
+
+#define FXGMAC_WOL_WAIT_2_MS 2
+
+static void fxgmac_config_wol_wait_time(struct fxgmac_pdata *pdata)
+{
+	u32 val;
+
+	val = rd32_mem(pdata, WOL_CTRL);
+	fxgmac_set_bits(&val, WOL_WAIT_TIME_POS, WOL_WAIT_TIME_LEN,
+			FXGMAC_WOL_WAIT_2_MS);
+	wr32_mem(pdata, val, WOL_CTRL);
+}
+
+static void fxgmac_desc_rx_channel_init(struct fxgmac_channel *channel)
+{
+	struct fxgmac_pdata *pdata = channel->pdata;
+	struct fxgmac_ring *ring = channel->rx_ring;
+	unsigned int start_index = ring->cur;
+	struct fxgmac_desc_data *desc_data;
+
+	/* Initialize all descriptors */
+	for (u32 i = 0; i < ring->dma_desc_count; i++) {
+		desc_data = FXGMAC_GET_DESC_DATA(ring, i);
+
+		/* Initialize Rx descriptor */
+		fxgmac_desc_rx_reset(desc_data);
+	}
+
+	/* Update the total number of Rx descriptors */
+	wr32_mac(pdata, ring->dma_desc_count - 1, FXGMAC_DMA_REG(channel, DMA_CH_RDRLR));
+
+	/* Update the starting address of descriptor ring */
+	desc_data = FXGMAC_GET_DESC_DATA(ring, start_index);
+	wr32_mac(pdata, upper_32_bits(desc_data->dma_desc_addr),
+		 FXGMAC_DMA_REG(channel, DMA_CH_RDLR_HI));
+	wr32_mac(pdata, lower_32_bits(desc_data->dma_desc_addr),
+		 FXGMAC_DMA_REG(channel, DMA_CH_RDLR_LO));
+
+	/* Update the Rx Descriptor Tail Pointer */
+	desc_data = FXGMAC_GET_DESC_DATA(ring, start_index +
+					       ring->dma_desc_count - 1);
+	wr32_mac(pdata, lower_32_bits(desc_data->dma_desc_addr),
+		 FXGMAC_DMA_REG(channel, DMA_CH_RDTR_LO));
+}
+
+static void fxgmac_desc_rx_init(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_desc_data *desc_data;
+	struct fxgmac_dma_desc *dma_desc;
+	struct fxgmac_channel *channel;
+	dma_addr_t dma_desc_addr;
+	struct fxgmac_ring *ring;
+
+	channel = pdata->channel_head;
+	for (u32 i = 0; i < pdata->channel_count; i++, channel++) {
+		ring = channel->rx_ring;
+		dma_desc = ring->dma_desc_head;
+		dma_desc_addr = ring->dma_desc_head_addr;
+
+		for (u32 j = 0; j < ring->dma_desc_count; j++) {
+			desc_data = FXGMAC_GET_DESC_DATA(ring, j);
+			desc_data->dma_desc = dma_desc;
+			desc_data->dma_desc_addr = dma_desc_addr;
+
+			if (fxgmac_rx_buffe_map(pdata, ring, desc_data))
+				break;
+
+			dma_desc++;
+			dma_desc_addr += sizeof(struct fxgmac_dma_desc);
+		}
+
+		ring->cur = 0;
+		ring->dirty = 0;
+
+		fxgmac_desc_rx_channel_init(channel);
+	}
+}
+
+static void fxgmac_desc_tx_channel_init(struct fxgmac_channel *channel)
+{
+	struct fxgmac_pdata *pdata = channel->pdata;
+	struct fxgmac_ring *ring = channel->tx_ring;
+	struct fxgmac_desc_data *desc_data;
+	int start_index = ring->cur;
+
+	/* Initialize all descriptors */
+	for (u32 i = 0; i < ring->dma_desc_count; i++) {
+		desc_data = FXGMAC_GET_DESC_DATA(ring, i);
+		fxgmac_desc_tx_reset(desc_data); /* Initialize Tx descriptor */
+	}
+
+	/* Update the total number of Tx descriptors */
+	wr32_mac(pdata, channel->pdata->tx_desc_count - 1,
+		 FXGMAC_DMA_REG(channel, DMA_CH_TDRLR));
+
+	/* Update the starting address of descriptor ring */
+	desc_data = FXGMAC_GET_DESC_DATA(ring, start_index);
+	wr32_mac(pdata, upper_32_bits(desc_data->dma_desc_addr),
+		 FXGMAC_DMA_REG(channel, DMA_CH_TDLR_HI));
+	wr32_mac(pdata, lower_32_bits(desc_data->dma_desc_addr),
+		 FXGMAC_DMA_REG(channel, DMA_CH_TDLR_LO));
+}
+
+static void fxgmac_desc_tx_init(struct fxgmac_pdata *pdata)
+{
+	struct fxgmac_desc_data *desc_data;
+	struct fxgmac_dma_desc *dma_desc;
+	struct fxgmac_channel *channel;
+	dma_addr_t dma_desc_addr;
+	struct fxgmac_ring *ring;
+
+	channel = pdata->channel_head;
+	channel->tx_timer_active = 0; /* reset the tx timer status. */
+	ring = channel->tx_ring;
+	dma_desc = ring->dma_desc_head;
+	dma_desc_addr = ring->dma_desc_head_addr;
+
+	for (u32 j = 0; j < ring->dma_desc_count; j++) {
+		desc_data = FXGMAC_GET_DESC_DATA(ring, j);
+		desc_data->dma_desc = dma_desc;
+		desc_data->dma_desc_addr = dma_desc_addr;
+
+		dma_desc++;
+		dma_desc_addr += sizeof(struct fxgmac_dma_desc);
+	}
+
+	ring->cur = 0;
+	ring->dirty = 0;
+	memset(&ring->tx, 0, sizeof(ring->tx));
+	fxgmac_desc_tx_channel_init(pdata->channel_head);
+}
+
+static int fxgmac_hw_init(struct fxgmac_pdata *pdata)
+{
+	int ret;
+
+	/* Flush Tx queues */
+	ret = fxgmac_flush_tx_queues(pdata);
+	if (ret < 0) {
+		yt_err(pdata, "%s, flush tx queue err:%d\n", __func__, ret);
+		return ret;
+	}
+
+	/* Initialize DMA related features */
+	fxgmac_config_dma_bus(pdata);
+	fxgmac_config_osp_mode(pdata);
+	fxgmac_config_pblx8(pdata);
+	fxgmac_config_tx_pbl_val(pdata);
+	fxgmac_config_rx_pbl_val(pdata);
+	fxgmac_config_rx_coalesce(pdata);
+	fxgmac_config_rx_buffer_size(pdata);
+	fxgmac_config_tso_mode(pdata);
+	fxgmac_config_sph_mode(pdata);
+	fxgmac_config_rss(pdata);
+
+	fxgmac_desc_tx_init(pdata);
+	fxgmac_desc_rx_init(pdata);
+	fxgmac_enable_dma_interrupts(pdata);
+
+	/* Initialize MTL related features */
+	fxgmac_config_mtl_mode(pdata);
+	fxgmac_config_queue_mapping(pdata);
+	fxgmac_config_tsf_mode(pdata, pdata->tx_sf_mode);
+	fxgmac_config_rsf_mode(pdata, pdata->rx_sf_mode);
+	fxgmac_config_tx_threshold(pdata, pdata->tx_threshold);
+	fxgmac_config_rx_threshold(pdata, pdata->rx_threshold);
+	fxgmac_config_tx_fifo_size(pdata);
+	fxgmac_config_rx_fifo_size(pdata);
+	fxgmac_config_flow_control_threshold(pdata);
+	fxgmac_config_rx_fep_disable(pdata);
+	fxgmac_config_rx_fup_enable(pdata);
+	fxgmac_enable_mtl_interrupts(pdata);
+
+	/* Initialize MAC related features */
+	fxgmac_config_mac_address(pdata);
+	fxgmac_config_crc_check(pdata);
+	fxgmac_config_rx_mode(pdata);
+	fxgmac_config_jumbo(pdata);
+	ret = fxgmac_config_flow_control(pdata);
+	if (ret < 0) {
+		yt_err(pdata, "%s, fxgmac_config_flow_control err:%d\n",
+		       __func__, ret);
+		return ret;
+	}
+
+	fxgmac_config_mac_speed(pdata);
+	fxgmac_config_checksum_offload(pdata);
+	fxgmac_config_vlan_support(pdata);
+	fxgmac_config_mmc(pdata);
+	fxgmac_enable_mac_interrupts(pdata);
+	fxgmac_config_wol_wait_time(pdata);
+
+	ret = fxgmac_phy_irq_enable(pdata, true);
+
+	if (netif_msg_drv(pdata))
+		yt_dbg(pdata, "%s ok\n", __func__);
+
+	return ret;
+}
+
+static void fxgmac_save_nonstick_reg(struct fxgmac_pdata *pdata)
+{
+	for (u32 i = GLOBAL_CTRL0; i < MSI_PBA; i += 4) {
+		pdata->reg_nonstick[(i - GLOBAL_CTRL0) >> 2] =
+			rd32_mem(pdata, i);
+	}
+}
+
+static void fxgmac_restore_nonstick_reg(struct fxgmac_pdata *pdata)
+{
+	for (u32 i = GLOBAL_CTRL0; i < MSI_PBA; i += 4)
+		wr32_mem(pdata, pdata->reg_nonstick[(i - GLOBAL_CTRL0) >> 2],
+			 i);
+}
+
+static void fxgmac_hw_exit(struct fxgmac_pdata *pdata)
+{
+	u32 val = 0;
+
+	/* Issue a CHIP reset,
+	 * it will reset trigger circuit and reload efuse patch
+	 */
+	val = rd32_mem(pdata, SYS_RESET);
+	yt_dbg(pdata, "CHIP_RESET 0x%x\n", val);
+	fxgmac_set_bits(&val, SYS_RESET_POS, SYS_RESET_LEN, 1);
+	wr32_mem(pdata, val, SYS_RESET);
+	fsleep(9000);
+
+	fxgmac_phy_release(pdata);
+
+	/* Reset will clear nonstick registers. */
+	fxgmac_restore_nonstick_reg(pdata);
+}
+
+static void fxgmac_pcie_init(struct fxgmac_pdata *pdata)
+{
+	u32 val = 0;
+
+	fxgmac_set_bits(&val, LTR_IDLE_ENTER_REQUIRE_POS,
+			LTR_IDLE_ENTER_REQUIRE_LEN, LTR_IDLE_ENTER_REQUIRE);
+	fxgmac_set_bits(&val, LTR_IDLE_ENTER_SCALE_POS,
+			LTR_IDLE_ENTER_SCALE_LEN, LTR_IDLE_ENTER_SCALE_1024_NS);
+	fxgmac_set_bits(&val, LTR_IDLE_ENTER_POS, LTR_IDLE_ENTER_LEN,
+			LTR_IDLE_ENTER_900_US);
+	val = (val << 16) + val; /* snoopy + non-snoopy */
+	wr32_mem(pdata, val, LTR_IDLE_ENTER);
+
+	val = 0;
+	fxgmac_set_bits(&val, LTR_IDLE_EXIT_REQUIRE_POS,
+			LTR_IDLE_EXIT_REQUIRE_LEN, LTR_IDLE_EXIT_REQUIRE);
+	fxgmac_set_bits(&val, LTR_IDLE_EXIT_SCALE_POS, LTR_IDLE_EXIT_SCALE_LEN,
+			LTR_IDLE_EXIT_SCALE);
+	fxgmac_set_bits(&val, LTR_IDLE_EXIT_POS, LTR_IDLE_EXIT_LEN,
+			LTR_IDLE_EXIT_171_US);
+	val = (val << 16) + val; /* snoopy + non-snoopy */
+	wr32_mem(pdata, val, LTR_IDLE_EXIT);
+
+	val = 0;
+	fxgmac_set_bits(&val, PCIE_SERDES_PLL_AUTOOFF_POS,
+			PCIE_SERDES_PLL_AUTOOFF_LEN, 1);
+	wr32_mem(pdata, val, PCIE_SERDES_PLL);
+}
+
+static void fxgmac_clear_misc_int_status(struct fxgmac_pdata *pdata)
+{
+	u32 val, i;
+
+	if (fxgmac_phy_clear_interrupt(pdata) == 1)  /*  Link change */
+		phy_mac_interrupt(pdata->phydev);
+
+	/* Clear other interrupt status  */
+	val = rd32_mac(pdata, MAC_ISR);
+	if (val) {
+		if (val & BIT(MAC_ISR_PHYIF_STA_POS))
+			rd32_mac(pdata, MAC_PHYIF_STA);
+
+		if (val & (BIT(MAC_ISR_AN_SR0_POS) | BIT(MAC_ISR_AN_SR1_POS) |
+			   BIT(MAC_ISR_AN_SR2_POS)))
+			rd32_mac(pdata, MAC_AN_SR);
+
+		if (val & BIT(MAC_ISR_PMT_STA_POS))
+			rd32_mac(pdata, MAC_PMT_STA);
+
+		if (val & BIT(MAC_ISR_LPI_STA_POS))
+			rd32_mac(pdata, MAC_LPI_STA);
+
+		if (val & BIT(MAC_ISR_MMC_STA_POS)) {
+			if (val & BIT(MAC_ISR_RX_MMC_STA_POS))
+				fxgmac_rx_mmc_int(pdata);
+
+			if (val & BIT(MAC_ISR_TX_MMC_STA_POS))
+				fxgmac_tx_mmc_int(pdata);
+
+			if (val & BIT(MAC_ISR_IPCRXINT_POS))
+				rd32_mac(pdata, MMC_IPCRXINT);
+		}
+
+		if (val &
+		    (BIT(MAC_ISR_TX_RX_STA0_POS) | BIT(MAC_ISR_TX_RX_STA1_POS)))
+			rd32_mac(pdata, MAC_TX_RX_STA);
+
+		if (val & BIT(MAC_ISR_GPIO_SR_POS))
+			rd32_mac(pdata, MAC_GPIO_SR);
+	}
+
+	/* MTL_Interrupt_Status, write 1 clear */
+	val = rd32_mac(pdata, MTL_INT_SR);
+	if (val)
+		wr32_mac(pdata, val, MTL_INT_SR);
+
+	/* MTL_Q(#i)_Interrupt_Control_Status, write 1 clear */
+	for (i = 0; i < pdata->hw_feat.rx_q_cnt; i++) {
+		/* Clear all the interrupts which are set */
+		val = rd32_mac(pdata, MTL_Q_INT_CTL_SR + i * MTL_Q_INC);
+		if (val)
+			wr32_mac(pdata, val, MTL_Q_INT_CTL_SR + i * MTL_Q_INC);
+	}
+
+	/* MTL_ECC_Interrupt_Status, write 1 clear */
+	val = rd32_mac(pdata, MTL_ECC_INT_SR);
+	if (val)
+		wr32_mac(pdata, val, MTL_ECC_INT_SR);
+
+	/* DMA_ECC_Interrupt_Status, write 1 clear */
+	val = rd32_mac(pdata, DMA_ECC_INT_SR);
+	if (val)
+		wr32_mac(pdata, val, DMA_ECC_INT_SR);
+}
+
+void fxgmac_hw_ops_init(struct fxgmac_hw_ops *hw_ops)
+{
+	hw_ops->pcie_init = fxgmac_pcie_init;
+	hw_ops->init = fxgmac_hw_init;
+	hw_ops->exit = fxgmac_hw_exit;
+	hw_ops->save_nonstick_reg = fxgmac_save_nonstick_reg;
+	hw_ops->restore_nonstick_reg = fxgmac_restore_nonstick_reg;
+
+	hw_ops->enable_tx = fxgmac_enable_tx;
+	hw_ops->disable_tx = fxgmac_disable_tx;
+	hw_ops->enable_rx = fxgmac_enable_rx;
+	hw_ops->disable_rx = fxgmac_disable_rx;
+
+	hw_ops->enable_channel_irq = fxgmac_enable_channel_irq;
+	hw_ops->disable_channel_irq = fxgmac_disable_channel_irq;
+	hw_ops->set_interrupt_moderation = fxgmac_set_interrupt_moderation;
+	hw_ops->enable_msix_one_irq = fxgmac_enable_msix_one_irq;
+	hw_ops->disable_msix_one_irq = fxgmac_disable_msix_one_irq;
+	hw_ops->enable_mgm_irq = fxgmac_enable_mgm_irq;
+	hw_ops->disable_mgm_irq = fxgmac_disable_mgm_irq;
+
+	hw_ops->dismiss_all_int = fxgmac_dismiss_all_int;
+	hw_ops->clear_misc_int_status = fxgmac_clear_misc_int_status;
+
+	hw_ops->set_mac_address = fxgmac_set_mac_address;
+	hw_ops->set_mac_hash = fxgmac_set_mc_addresses;
+	hw_ops->config_rx_mode = fxgmac_config_rx_mode;
+	hw_ops->enable_rx_csum = fxgmac_enable_rx_csum;
+	hw_ops->disable_rx_csum = fxgmac_disable_rx_csum;
+	hw_ops->config_tso = fxgmac_config_tso_mode;
+	hw_ops->calculate_max_checksum_size =
+		fxgmac_calculate_max_checksum_size;
+	hw_ops->config_mac_speed = fxgmac_config_mac_speed;
+
+	/* PHY Control */
+	hw_ops->reset_phy = fxgmac_phy_reset;
+	hw_ops->release_phy = fxgmac_phy_release;
+	hw_ops->write_phy_reg = fxgmac_phy_write_reg;
+	hw_ops->read_phy_reg = fxgmac_phy_read_reg;
+
+	/* Vlan related config */
+	hw_ops->enable_rx_vlan_stripping = fxgmac_enable_rx_vlan_stripping;
+	hw_ops->disable_rx_vlan_stripping = fxgmac_disable_rx_vlan_stripping;
+	hw_ops->enable_rx_vlan_filtering = fxgmac_enable_rx_vlan_filtering;
+	hw_ops->disable_rx_vlan_filtering = fxgmac_disable_rx_vlan_filtering;
+	hw_ops->update_vlan_hash_table = fxgmac_update_vlan_hash_table;
+
+	/* RX coalescing */
+	hw_ops->config_rx_coalesce = fxgmac_config_rx_coalesce;
+	hw_ops->usec_to_riwt = fxgmac_usec_to_riwt;
+	/* Receive Side Scaling */
+	hw_ops->enable_rss = fxgmac_enable_rss;
+	hw_ops->disable_rss = fxgmac_disable_rss;
+	hw_ops->get_rss_options = fxgmac_read_rss_options;
+	hw_ops->set_rss_options = fxgmac_write_rss_options;
+	hw_ops->set_rss_hash_key = fxgmac_set_rss_hash_key;
+	hw_ops->write_rss_lookup_table = fxgmac_write_rss_lookup_table;
+}
-- 
2.34.1


