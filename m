Return-Path: <netdev+bounces-305660-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CvGEAJLzTWoxAgIAu9opvQ
	(envelope-from <netdev+bounces-305660-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 08:52:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E84D57225A6
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 08:52:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305660-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305660-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B0D7B30228BF
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 06:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F9E3EBF13;
	Wed,  8 Jul 2026 06:48:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-220.mail.aliyun.com (out28-220.mail.aliyun.com [115.124.28.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B4F3E7BA5;
	Wed,  8 Jul 2026 06:48:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783493288; cv=none; b=A/1gujSabZjtd7UeqbJYDqviBU479b72IZ7PHWhaIrrdcMd6o07Raa1Is82Hve1GkfgRlpt+ivfcslOplrfLCIVx+TcbgKphGxZlT9fJWztu1HcL1wkZbue2pE+Uxggj9vgSjsCxNl/+iK1Em/xibIpkizjUzBonn8EW+af1+KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783493288; c=relaxed/simple;
	bh=2oAUWPuoCIEahdTnE0CBqRYLqGn1R9kWoixmB9HjKww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AdkxaIqKmxkeVB5MiprFEqcenRBQ1wiGEwK7q3yrzr9RF6JsTUAZccXHA0JClleDE1gMW/iVfAiBs+qJ0dgQcwc3YdKz6f6wbJ9VSMs4EHvhFlnzOE5bff3m+WSV7+HD+Oy/eWuZ4hv7c2ri0wQie1HqBiHmWSVgBhLfGwpi7ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.220
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0332102-0.000329299-0.966461;FP=17462663837594967731|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033040074035;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.iG5uJ7Y_1783493273;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.iG5uJ7Y_1783493273 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 08 Jul 2026 14:47:53 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	corbet@lwn.net,
	kuba@kernel.org,
	horms@kernel.org,
	linux-doc@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	enelsonmoore@gmail.com,
	skhan@linuxfoundation.org,
	hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v21 net-next 07/12] net/nebula-matrix: add vsi resource implementation
Date: Wed,  8 Jul 2026 14:47:33 +0800
Message-ID: <20260708064742.35391-8-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708064742.35391-1-illusion.wang@nebula-matrix.com>
References: <20260708064742.35391-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-305660-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[nebula-matrix.com];
	FORGED_RECIPIENTS(0.00)[m:dimon.zhao@nebula-matrix.com,m:illusion.wang@nebula-matrix.com,m:alvin.wang@nebula-matrix.com,m:sam.chen@nebula-matrix.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:corbet@lwn.net,m:kuba@kernel.org,m:horms@kernel.org,m:linux-doc@vger.kernel.org,m:pabeni@redhat.com,m:vadim.fedorenko@linux.dev,m:lukas.bulwahn@redhat.com,m:edumazet@google.com,m:enelsonmoore@gmail.com,m:skhan@linuxfoundation.org,m:hkallweit1@gmail.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,lwn.net,kernel.org,vger.kernel.org,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nebula-matrix.com:from_mime,nebula-matrix.com:email,nebula-matrix.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E84D57225A6

From: illusion wang <illusion.wang@nebula-matrix.com>

net/nebula-matrix: add vsi resource implementation

This patch adds the VSI (Virtual Station Interface) resource
implementation for the Nebula Matrix Leonis hardware, wiring up
chip module init/deinit logic that configures data-path engines,
traffic shaping, flow-control registers, and the driver_status
hardware flag consumed by firmware.

This driver only supports little-endian architecture.

HW layer overview:
The HW layer code is highly chip-specific and may benefit from
additional review since it cannot be cross-checked against other
implementations.

DP sub-init modules (called from nbl_dp_init()):
- dped, uped:     Data/User Packet Engine Driver
- dsch:           Scheduler core (qid limit init, PSHA enable inside shaping init)
- ustore, dstore: Buffer Store modules
- dvn, uvn:       Virtual Descriptor Network modules
- uqm:            Queue Manager
- nbl_shaping_init():      Per-port traffic shaping + DSCH PSHA config

Chip init sequence (nbl_hw_init_chip_module()):
1. nbl_dp_init()          — All DP sub-modules listed above
2. nbl_intf_init()        — Host adapter padpt flow control
   - nbl_host_padpt_init() — Host padpt flow control registers
3. nbl_hw_set_driver_status() + nbl_flush_writes()

Chip deinit logic relies on firmware cleanup: only driver_status flag
is cleared and flushed; FW releases partial hardware state automatically.

Signed-off-by: illusion wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   1 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  | 501 ++++++++++++++++++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h  | 242 +++++++++
 .../nbl_hw_leonis/nbl_resource_leonis.c       |   2 +
 .../nbl_hw_leonis/nbl_resource_leonis.h       |   1 +
 .../nebula-matrix/nbl/nbl_hw/nbl_vsi.c        |  26 +
 .../nebula-matrix/nbl/nbl_hw/nbl_vsi.h        |  12 +
 .../nbl/nbl_include/nbl_def_hw.h              |   3 +
 .../nbl/nbl_include/nbl_def_resource.h        |   3 +
 .../nbl/nbl_include/nbl_include.h             |  12 +
 10 files changed, 803 insertions(+)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index bcedf278bab2..523aa26d727c 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -9,4 +9,5 @@ nbl-objs +=       nbl_common/nbl_common.o \
 				nbl_hw/nbl_hw_leonis/nbl_resource_leonis.o \
 				nbl_hw/nbl_resource.o \
 				nbl_hw/nbl_interrupt.o \
+				nbl_hw/nbl_vsi.o \
 				nbl_main.o
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
index 34e3d938e0b2..e5f65867403b 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -97,6 +97,504 @@ static u32 nbl_hw_get_fw_eth_map(struct nbl_hw_mgt *hw_mgt)
 	return FIELD_GET(NBL_FW_BOARD_DW6_ETH_BITMAP_MASK, data);
 }
 
+static u32 nbl_hw_get_quirks(struct nbl_hw_mgt *hw_mgt)
+{
+	u32 quirks;
+
+	nbl_hw_read_mbx_regs(hw_mgt, NBL_LEONIS_QUIRKS_OFFSET, &quirks,
+			     sizeof(u32));
+
+	if (quirks == NBL_LEONIS_ILLEGAL_REG_VALUE || quirks == ~0u)
+		return 0;
+
+	return quirks;
+}
+
+static void nbl_configure_dped_checksum(struct nbl_hw_mgt *hw_mgt)
+{
+	u32 data;
+
+	/* DPED dped_l4_ck_cmd_40 for sctp */
+	spin_lock(&hw_mgt->reg_lock);
+	nbl_hw_rd_regs(hw_mgt, NBL_DPED_L4_CK_CMD_40_ADDR, &data, sizeof(data));
+	data |= FIELD_PREP(NBL_DPED_L4_CK_CMD_40_EN_MASK, 1);
+	nbl_hw_wr_regs(hw_mgt, NBL_DPED_L4_CK_CMD_40_ADDR, &data, sizeof(data));
+	spin_unlock(&hw_mgt->reg_lock);
+}
+
+static void nbl_dped_init(struct nbl_hw_mgt *hw_mgt)
+{
+	nbl_hw_wr32(hw_mgt, NBL_DPED_VLAN_OFFSET, 0xC);
+	nbl_hw_wr32(hw_mgt, NBL_DPED_DSCP_OFFSET_0, 0x8);
+	nbl_hw_wr32(hw_mgt, NBL_DPED_DSCP_OFFSET_1, 0x4);
+
+	/* dped checksum offload */
+	nbl_configure_dped_checksum(hw_mgt);
+}
+
+static void nbl_uped_init(struct nbl_hw_mgt *hw_mgt)
+{
+	u32 hw_edit;
+
+	/* V4 TCP: l3_len = 0 */
+	spin_lock(&hw_mgt->reg_lock);
+	nbl_hw_rd_regs(hw_mgt, NBL_UPED_HW_EDT_PROF_TABLE(NBL_UPED_V4_TCP_IDX),
+		       &hw_edit, sizeof(hw_edit));
+	hw_edit &= ~NBL_PED_HW_EDIT_PROFILE_L3_LEN_MASK;
+	nbl_hw_wr_regs(hw_mgt, NBL_UPED_HW_EDT_PROF_TABLE(NBL_UPED_V4_TCP_IDX),
+		       &hw_edit, sizeof(hw_edit));
+
+	/* V6 TCP: l3_len = 1 */
+	nbl_hw_rd_regs(hw_mgt, NBL_UPED_HW_EDT_PROF_TABLE(NBL_UPED_V6_TCP_IDX),
+		       &hw_edit, sizeof(hw_edit));
+	hw_edit = (hw_edit & ~NBL_PED_HW_EDIT_PROFILE_L3_LEN_MASK) |
+		  FIELD_PREP(NBL_PED_HW_EDIT_PROFILE_L3_LEN_MASK, 1);
+	nbl_hw_wr_regs(hw_mgt, NBL_UPED_HW_EDT_PROF_TABLE(NBL_UPED_V6_TCP_IDX),
+		       &hw_edit, sizeof(hw_edit));
+	spin_unlock(&hw_mgt->reg_lock);
+}
+
+static int nbl_shaping_eth_init(struct nbl_hw_mgt *hw_mgt, u8 eth_id, u8 speed)
+{
+	union nbl_shaping_dvn_dport_u dvn_dport = { 0 };
+	union nbl_shaping_dport_u dport = { 0 };
+	u32 rate, half_rate;
+	u32 depth;
+
+	switch (speed) {
+	case NBL_FW_PORT_SPEED_100G:
+		rate = 100000;
+		break;
+	case NBL_FW_PORT_SPEED_50G:
+		rate = 50000;
+		break;
+	case NBL_FW_PORT_SPEED_25G:
+		rate = 25000;
+		break;
+	case NBL_FW_PORT_SPEED_10G:
+		rate = 10000;
+		break;
+	default:
+		dev_err(hw_mgt->common->dev,
+			"Unsupported port speed %u for eth%u\n", speed, eth_id);
+		return -EINVAL;
+	}
+
+	half_rate = rate / 2;
+	depth = max(rate * 2, NBL_LR_LEONIS_NET_BUCKET_DEPTH);
+
+	/* 1. clear valid first
+	 * dport and dvn_dport are zero-initialised above, so VALID=0 already
+	 */
+	nbl_hw_wr_regs(hw_mgt, NBL_SHAPING_DPORT_REG(eth_id), dport.data,
+		       sizeof(dport));
+	nbl_hw_wr_regs(hw_mgt, NBL_SHAPING_DVN_DPORT_REG(eth_id),
+		       dvn_dport.data, sizeof(dvn_dport));
+
+	/* 2. write config words (valid=0, safe) */
+	dport.info.low = FIELD_PREP(DPORT_CIR_MASK, rate) |
+			 FIELD_PREP(DPORT_PIR_MASK, rate) |
+			 FIELD_PREP(DPORT_DEPTH_MASK, depth) |
+			 FIELD_PREP(DPORT_CBS_MASK_LOW, depth & 0x3F);
+	dport.info.high = FIELD_PREP(DPORT_CBS_MASK_HIGH, depth >> 6) |
+			  FIELD_PREP(DPORT_PBS_MASK, depth);
+
+	dvn_dport.info.low = FIELD_PREP(DPORT_CIR_MASK, half_rate) |
+			     FIELD_PREP(DPORT_PIR_MASK, rate) |
+			     FIELD_PREP(DPORT_DEPTH_MASK, depth) |
+			     FIELD_PREP(DPORT_CBS_MASK_LOW, depth & 0x3F);
+	dvn_dport.info.high = FIELD_PREP(DPORT_CBS_MASK_HIGH, depth >> 6) |
+			      FIELD_PREP(DPORT_PBS_MASK, depth);
+	nbl_hw_wr_regs(hw_mgt, NBL_SHAPING_DPORT_REG(eth_id), dport.data,
+		       sizeof(dport));
+	nbl_hw_wr_regs(hw_mgt, NBL_SHAPING_DVN_DPORT_REG(eth_id),
+		       dvn_dport.data, sizeof(dvn_dport));
+	/* 3. commit: set valid last */
+	dport.info.low |= FIELD_PREP(DPORT_VALID_MASK, 1);
+	dvn_dport.info.low |= FIELD_PREP(DPORT_VALID_MASK, 1);
+	nbl_hw_wr_regs(hw_mgt, NBL_SHAPING_DPORT_REG(eth_id), dport.data,
+		       sizeof(dport));
+	nbl_hw_wr_regs(hw_mgt, NBL_SHAPING_DVN_DPORT_REG(eth_id),
+		       dvn_dport.data, sizeof(dvn_dport));
+	return 0;
+}
+
+static int nbl_shaping_init(struct nbl_hw_mgt *hw_mgt, u8 speed)
+{
+#define NBL_SHAPING_FLUSH_INTERVAL 128
+	union nbl_shaping_net_u net_shaping = { 0 };
+	u32 psha_en = 0;
+	int ret;
+	int i;
+
+	for (i = 0; i < NBL_MAX_ETHERNET; i++) {
+		if (!(nbl_hw_get_fw_eth_map(hw_mgt) & BIT(i)))
+			continue;
+		ret = nbl_shaping_eth_init(hw_mgt, i, speed);
+		if (ret)
+			return ret;
+	}
+	psha_en = FIELD_PREP(NBL_DSCH_PSHA_EN_MASK, 0xF);
+	nbl_hw_wr_regs(hw_mgt, NBL_DSCH_PSHA_EN_ADDR, &psha_en,
+		       sizeof(psha_en));
+
+	for (i = 0; i < NBL_MAX_FUNC; i++) {
+		nbl_hw_wr_regs(hw_mgt, NBL_SHAPING_NET_REG(i), net_shaping.data,
+			       sizeof(net_shaping));
+		if ((i + 1) % NBL_SHAPING_FLUSH_INTERVAL == 0)
+			nbl_flush_writes(hw_mgt);
+	}
+	nbl_flush_writes(hw_mgt);
+	return 0;
+}
+
+static void nbl_dsch_qid_max_init(struct nbl_hw_mgt *hw_mgt)
+{
+	u32 quanta = 0;
+
+	quanta = FIELD_PREP(NBL_DSCH_VN_QUANTA_H_QUA_MASK, NBL_HOST_QUANTA) |
+		 FIELD_PREP(NBL_DSCH_VN_QUANTA_E_QUA_MASK, NBL_ECPU_QUANTA);
+	nbl_hw_wr_regs(hw_mgt, NBL_DSCH_VN_QUANTA_ADDR, &quanta,
+		       sizeof(quanta));
+	nbl_hw_wr32(hw_mgt, NBL_DSCH_HOST_QID_MAX, NBL_MAX_QUEUE_ID);
+
+	nbl_hw_wr32(hw_mgt, NBL_DVN_ECPU_QUEUE_NUM, 0);
+	nbl_hw_wr32(hw_mgt, NBL_UVN_ECPU_QUEUE_NUM, 0);
+}
+
+static int nbl_ustore_init(struct nbl_hw_mgt *hw_mgt, u8 eth_num)
+{
+	u32 drop_th = 0;
+	u32 pkt_len;
+	int i;
+
+	if (eth_num != 1 && eth_num != 2 && eth_num != 4)
+		return -EINVAL;
+	/* Read current packet length config
+	 *(to preserve other fields while updating 'min')
+	 */
+	spin_lock(&hw_mgt->reg_lock);
+	nbl_hw_rd_regs(hw_mgt, NBL_USTORE_PKT_LEN_ADDR, &pkt_len,
+		       sizeof(pkt_len));
+	/* min arp packet length 42 (14 + 28) */
+	pkt_len &= ~NBL_USTORE_PKT_LEN_MIN_MASK;
+	pkt_len |= FIELD_PREP(NBL_USTORE_PKT_LEN_MIN_MASK, 42);
+	nbl_hw_wr_regs(hw_mgt, NBL_USTORE_PKT_LEN_ADDR, &pkt_len,
+		       sizeof(pkt_len));
+	spin_unlock(&hw_mgt->reg_lock);
+	drop_th |= FIELD_PREP(NBL_USTORE_PORT_DROP_TH_EN_MASK, 1);
+	if (eth_num == 1)
+		drop_th |= FIELD_PREP(NBL_USTORE_PORT_DROP_TH_DISC_TH_MASK,
+				      NBL_USTORE_SINGLE_ETH_DROP_TH);
+	else if (eth_num == 2)
+		drop_th |= FIELD_PREP(NBL_USTORE_PORT_DROP_TH_DISC_TH_MASK,
+				      NBL_USTORE_DUAL_ETH_DROP_TH);
+	else
+		drop_th |= FIELD_PREP(NBL_USTORE_PORT_DROP_TH_DISC_TH_MASK,
+				      NBL_USTORE_QUAD_ETH_DROP_TH);
+	for (i = 0; i < NBL_MAX_ETHERNET; i++) {
+		if (!(nbl_hw_get_fw_eth_map(hw_mgt) & BIT(i)))
+			continue;
+		nbl_hw_wr_regs_lock(hw_mgt, NBL_USTORE_PORT_DROP_TH_REG_ARR(i),
+				    &drop_th, sizeof(drop_th));
+	}
+
+	/* Clear port drop/truncate counters by reading them
+	 * (hardware has read-to-clear behavior for these registers)
+	 */
+	for (i = 0; i < NBL_MAX_ETHERNET; i++) {
+		if (!(nbl_hw_get_fw_eth_map(hw_mgt) & BIT(i)))
+			continue;
+		nbl_hw_rd32(hw_mgt, NBL_USTORE_BUF_PORT_DROP_PKT(i));
+		nbl_hw_rd32(hw_mgt, NBL_USTORE_BUF_PORT_TRUN_PKT(i));
+	}
+	return 0;
+}
+
+static void nbl_dstore_init(struct nbl_hw_mgt *hw_mgt, u8 speed)
+{
+	u32 drop_th;
+	u32 fc_th;
+	u32 bp_th;
+	int i;
+
+	for (i = 0; i < NBL_DSTORE_PORT_DROP_TH_DEPTH; i++) {
+		spin_lock(&hw_mgt->reg_lock);
+		nbl_hw_rd_regs(hw_mgt, NBL_DSTORE_PORT_DROP_TH_REG(i), &drop_th,
+			       sizeof(drop_th));
+		drop_th &= ~NBL_DSTORE_PORT_DROP_EN_MASK;
+		nbl_hw_wr_regs(hw_mgt, NBL_DSTORE_PORT_DROP_TH_REG(i), &drop_th,
+			       sizeof(drop_th));
+		spin_unlock(&hw_mgt->reg_lock);
+	}
+
+	spin_lock(&hw_mgt->reg_lock);
+	nbl_hw_rd_regs(hw_mgt, NBL_DSTORE_DISC_BP_TH, &bp_th, sizeof(bp_th));
+	bp_th |= FIELD_PREP(NBL_DSTORE_DISC_BP_TH_EN_MASK, 1);
+	nbl_hw_wr_regs(hw_mgt, NBL_DSTORE_DISC_BP_TH, &bp_th, sizeof(bp_th));
+	spin_unlock(&hw_mgt->reg_lock);
+
+	for (i = 0; i < NBL_MAX_ETHERNET; i++) {
+		if (!(nbl_hw_get_fw_eth_map(hw_mgt) & BIT(i)))
+			continue;
+		spin_lock(&hw_mgt->reg_lock);
+		nbl_hw_rd_regs(hw_mgt, NBL_DSTORE_D_DPORT_FC_TH_REG(i), &fc_th,
+			       sizeof(fc_th));
+		fc_th &= ~(NBL_DSTORE_D_DPORT_FC_XOFF_TH_MASK |
+			   NBL_DSTORE_D_DPORT_FC_XON_TH_MASK);
+		if (speed == NBL_FW_PORT_SPEED_100G) {
+			fc_th |=
+				FIELD_PREP(NBL_DSTORE_D_DPORT_FC_XOFF_TH_MASK,
+					   NBL_DSTORE_DROP_XOFF_TH_100G) |
+				FIELD_PREP(NBL_DSTORE_D_DPORT_FC_XON_TH_MASK,
+					   NBL_DSTORE_DROP_XON_TH_100G);
+		} else {
+			fc_th |=
+				FIELD_PREP(NBL_DSTORE_D_DPORT_FC_XOFF_TH_MASK,
+					   NBL_DSTORE_DROP_XOFF_TH) |
+				FIELD_PREP(NBL_DSTORE_D_DPORT_FC_XON_TH_MASK,
+					   NBL_DSTORE_DROP_XON_TH);
+		}
+
+		fc_th |= FIELD_PREP(NBL_DSTORE_D_DPORT_FC_FC_EN_MASK, 1);
+		nbl_hw_wr_regs(hw_mgt, NBL_DSTORE_D_DPORT_FC_TH_REG(i), &fc_th,
+			       sizeof(fc_th));
+		spin_unlock(&hw_mgt->reg_lock);
+	}
+}
+
+static void nbl_dvn_descreq_num_cfg(struct nbl_hw_mgt *hw_mgt, u8 descreq_num)
+{
+	u8 split_ring_num = (descreq_num >> 3) & 0x1;
+	u8 ring_num = descreq_num & 0x7;
+	u32 num_cfg = 0;
+
+	num_cfg = FIELD_PREP(NBL_DVN_DESCREQ_NUM_CFG_AVRING_DESREQ_NUM_CFG_MASK,
+			     split_ring_num) |
+		  FIELD_PREP(NBL_DVN_DESCREQ_NUM_CFG_PACKED_L1_NUM_MASK,
+			     ring_num);
+
+	nbl_hw_wr_regs_lock(hw_mgt, NBL_DVN_DESCREQ_NUM_CFG, &num_cfg,
+			    sizeof(num_cfg));
+}
+
+static void nbl_dvn_init(struct nbl_hw_mgt *hw_mgt, u8 speed)
+{
+	u32 timeout = 0;
+	u32 ro_flag = 0;
+
+	timeout = FIELD_PREP(NBL_DVN_DESC_WR_MERGE_TIMEOUT_CFG_CYCLE_MASK,
+			     DEFAULT_DVN_DESC_WR_MERGE_TIMEOUT_MAX);
+	nbl_hw_wr_regs(hw_mgt, NBL_DVN_DESC_WR_MERGE_TIMEOUT, &timeout,
+		       sizeof(timeout));
+	if (pcie_relaxed_ordering_enabled(hw_mgt->common->pdev)) {
+		ro_flag =
+			FIELD_PREP(NBL_DVN_DIF_REQ_RD_RO_FLAG_DESC_RO_EN_MASK,
+				   1) |
+			FIELD_PREP(NBL_DVN_DIF_REQ_RD_RO_FLAG_DATA_RO_EN_MASK,
+				   1) |
+			FIELD_PREP(NBL_DVN_DIF_REQ_RD_RO_FLAG_AVRING_RO_EN_MASK,
+				   1);
+	}
+	nbl_hw_wr_regs(hw_mgt, NBL_DVN_DIF_REQ_RD_RO_FLAG, &ro_flag,
+		       sizeof(ro_flag));
+
+	if (speed == NBL_FW_PORT_SPEED_100G)
+		nbl_dvn_descreq_num_cfg(hw_mgt,
+					DEFAULT_DVN_100G_DESCREQ_NUMCFG);
+	else
+		nbl_dvn_descreq_num_cfg(hw_mgt, DEFAULT_DVN_DESCREQ_NUMCFG);
+}
+
+static void nbl_uvn_init(struct nbl_hw_mgt *hw_mgt)
+{
+	u16 wr_timeout = NBL_UVN_DESC_WR_TIMEOUT_VAL;
+	u32 timeout = NBL_UVN_DESC_RD_WAIT_TICKS;
+	u32 desc_wr_timeout = 0;
+	u32 prefetch_init = 0;
+	bool ro_enabled;
+	u32 flag = 0;
+	u32 mask = 0;
+	u32 quirks;
+
+	nbl_hw_wr32(hw_mgt, NBL_UVN_DESC_RD_WAIT, timeout);
+	desc_wr_timeout =
+		FIELD_PREP(NBL_UVN_DESC_WR_TIMEOUT_NUM_MASK, wr_timeout);
+	nbl_hw_wr_regs_lock(hw_mgt, NBL_UVN_DESC_WR_TIMEOUT, &desc_wr_timeout,
+			    sizeof(desc_wr_timeout));
+	ro_enabled = pcie_relaxed_ordering_enabled(hw_mgt->common->pdev);
+	if (ro_enabled)
+		flag = FIELD_PREP(NBL_UVN_DIF_REQ_RO_FLAG_AVAIL_RD_MASK, 1) |
+		FIELD_PREP(NBL_UVN_DIF_REQ_RO_FLAG_DESC_RD_MASK, 1) |
+		FIELD_PREP(NBL_UVN_DIF_REQ_RO_FLAG_PKT_WR_MASK, 1) |
+		FIELD_PREP(NBL_UVN_DIF_REQ_RO_FLAG_DESC_WR_MASK, 0);
+
+	nbl_hw_wr_regs_lock(hw_mgt, NBL_UVN_DIF_REQ_RO_FLAG, &flag,
+			    sizeof(flag));
+
+	spin_lock(&hw_mgt->reg_lock);
+	nbl_hw_rd_regs(hw_mgt, NBL_UVN_QUEUE_ERR_MASK, &mask, sizeof(mask));
+	mask |= FIELD_PREP(NBL_UVN_QUEUE_ERR_MASK_DIF_ERR_MASK, 1);
+
+	nbl_hw_wr_regs(hw_mgt, NBL_UVN_QUEUE_ERR_MASK, &mask, sizeof(mask));
+	spin_unlock(&hw_mgt->reg_lock);
+	quirks = nbl_hw_get_quirks(hw_mgt);
+	/*
+	 * sel=0: use configured num; sel=1: use internal calc (max 32)
+	 * Default is sel=1, unless NBL_QUIRKS_UVN_PREFETCH_ALIGN is set,
+	 * in which case override to sel=0.
+	 */
+	prefetch_init =
+		FIELD_PREP(NBL_UVN_DESC_PREFETCH_INIT_NUM_MASK,
+			   NBL_UVN_DESC_PREFETCH_NUM) |
+		FIELD_PREP(NBL_UVN_DESC_PREFETCH_INIT_SEL_MASK,
+			   (quirks & BIT(NBL_QUIRKS_UVN_PREFETCH_ALIGN)) ? 0 :
+									   1);
+
+	nbl_hw_wr_regs_lock(hw_mgt, NBL_UVN_DESC_PREFETCH_INIT, &prefetch_init,
+			    sizeof(prefetch_init));
+}
+
+static void nbl_uqm_init(struct nbl_hw_mgt *hw_mgt)
+{
+	u32 que_type = 0;
+	u32 cnt = 0;
+	int i;
+
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_FWD_DROP_CNT, &cnt, sizeof(cnt));
+
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_DROP_PKT_CNT, &cnt, sizeof(cnt));
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_DROP_PKT_SLICE_CNT, &cnt, sizeof(cnt));
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_DROP_PKT_LEN_ADD_CNT, &cnt, sizeof(cnt));
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_DROP_HEAD_PNTR_ADD_CNT, &cnt,
+		       sizeof(cnt));
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_DROP_WEIGHT_ADD_CNT, &cnt, sizeof(cnt));
+
+	for (i = 0; i < NBL_UQM_PORT_DROP_DEPTH; i++) {
+		nbl_hw_wr_regs(hw_mgt,
+			       NBL_UQM_PORT_DROP_PKT_CNT + (sizeof(cnt) * i),
+			       &cnt, sizeof(cnt));
+		nbl_hw_wr_regs(hw_mgt,
+			       NBL_UQM_PORT_DROP_PKT_SLICE_CNT +
+				       (sizeof(cnt) * i),
+			       &cnt, sizeof(cnt));
+		nbl_hw_wr_regs(hw_mgt,
+			       NBL_UQM_PORT_DROP_PKT_LEN_ADD_CNT +
+				       (sizeof(cnt) * i),
+			       &cnt, sizeof(cnt));
+		nbl_hw_wr_regs(hw_mgt,
+			       NBL_UQM_PORT_DROP_HEAD_PNTR_ADD_CNT +
+				       (sizeof(cnt) * i),
+			       &cnt, sizeof(cnt));
+		nbl_hw_wr_regs(hw_mgt,
+			       NBL_UQM_PORT_DROP_WEIGHT_ADD_CNT +
+				       (sizeof(cnt) * i),
+			       &cnt, sizeof(cnt));
+	}
+
+	for (i = 0; i < NBL_UQM_DPORT_DROP_DEPTH; i++)
+		nbl_hw_wr_regs(hw_mgt,
+			       NBL_UQM_DPORT_DROP_CNT + (sizeof(cnt) * i), &cnt,
+			       sizeof(cnt));
+	/* bit 0: bp mode , bit1: drop mode, resv bit1-31 */
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_QUE_TYPE, &que_type, sizeof(que_type));
+}
+
+static int nbl_dp_init(struct nbl_hw_mgt *hw_mgt, u8 speed, u8 eth_num)
+{
+	int ret;
+
+	nbl_dped_init(hw_mgt);
+	nbl_uped_init(hw_mgt);
+	ret = nbl_shaping_init(hw_mgt, speed);
+	if (ret)
+		return ret;
+	nbl_dsch_qid_max_init(hw_mgt);
+	ret = nbl_ustore_init(hw_mgt, eth_num);
+	if (ret)
+		return ret;
+	nbl_dstore_init(hw_mgt, speed);
+	nbl_dvn_init(hw_mgt, speed);
+	nbl_uvn_init(hw_mgt);
+	nbl_uqm_init(hw_mgt);
+	return 0;
+}
+
+static void nbl_host_padpt_init(struct nbl_hw_mgt *hw_mgt)
+{
+	/* padpt flow  control register */
+	nbl_hw_wr32(hw_mgt, NBL_HOST_PADPT_HOST_CFG_FC_CPLH_UP,
+		    NBL_HOST_PADPT_CFG_FC_CPLH_UP_VAL);
+	nbl_hw_wr32(hw_mgt, NBL_HOST_PADPT_HOST_CFG_FC_PD_DN,
+		    NBL_HOST_PADPT_CFG_FC_PD_DN_VAL);
+	nbl_hw_wr32(hw_mgt, NBL_HOST_PADPT_HOST_CFG_FC_PH_DN,
+		    NBL_HOST_PADPT_CFG_FC_PH_DN_VAL);
+	nbl_hw_wr32(hw_mgt, NBL_HOST_PADPT_HOST_CFG_FC_NPH_DN,
+		    NBL_HOST_PADPT_CFG_FC_NPH_DN_VAL);
+}
+
+static void nbl_intf_init(struct nbl_hw_mgt *hw_mgt)
+{
+	nbl_host_padpt_init(hw_mgt);
+}
+
+static void nbl_hw_set_driver_status(struct nbl_hw_mgt *hw_mgt, bool active)
+{
+	u32 status;
+
+	status = nbl_hw_rd32(hw_mgt, NBL_DRIVER_STATUS_REG);
+
+	status = (status & ~(1 << NBL_DRIVER_STATUS_BIT)) |
+		 (active << NBL_DRIVER_STATUS_BIT);
+
+	nbl_hw_wr32(hw_mgt, NBL_DRIVER_STATUS_REG, status);
+}
+
+/*
+ * This design is intentional. Setting driver status to false is the
+ * official teardown mechanism: it notifies firmware to perform full
+ * cleanup of all per-PF hardware state, including qinfo registers.
+ * An inverse helper would duplicate work that the firmware already
+ * does, and would add error-path complexity for no benefit. We keep
+ * the deinit path minimal and rely on firmware cleanup for correctness,
+ * including abnormal hardware reset scenarios.
+ */
+static void nbl_hw_deinit_module(struct nbl_hw_mgt *hw_mgt)
+{
+	nbl_hw_set_driver_status(hw_mgt, false);
+	/* ensure registers written */
+	nbl_flush_writes(hw_mgt);
+}
+
+/*
+ * Full chip hardware initialization is handled by firmware.
+ * This function only configures driver-level table entries and registers.
+ */
+static int nbl_hw_init_module(struct nbl_hw_mgt *hw_mgt, u8 eth_speed,
+			      u8 eth_num)
+{
+	int ret;
+
+	ret = nbl_dp_init(hw_mgt, eth_speed, eth_num);
+	if (ret)
+		goto notify_fw;
+	nbl_intf_init(hw_mgt);
+	nbl_hw_set_driver_status(hw_mgt, true);
+	/*ensure registers written*/
+	nbl_flush_writes(hw_mgt);
+
+	return 0;
+notify_fw:
+	/*
+	 * On failure path we set driver_status=false directly.
+	 * The FW checks this flag and cleans up partial state,
+	 * so no explicit rollback is needed.
+	 */
+	nbl_hw_set_driver_status(hw_mgt, false);
+	nbl_flush_writes(hw_mgt);
+	return ret;
+}
+
 /*
  * nbl_hw_set_mailbox_irq - read-modify-write of NBL_MAILBOX_QINFO_MAP_REG_ARR
  *
@@ -305,6 +803,9 @@ static void nbl_hw_get_board_info(struct nbl_hw_mgt *hw_mgt,
 }
 
 static struct nbl_hw_ops hw_ops = {
+	.init_module = nbl_hw_init_module,
+	.deinit_module = nbl_hw_deinit_module,
+
 	.configure_msix_map = nbl_hw_configure_msix_map,
 	.configure_msix_info = nbl_hw_configure_msix_info,
 	.flush_write = nbl_flush_writes,
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
index 1d6d614be7d6..55951ff7b25a 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
@@ -11,6 +11,9 @@
 #include "../../nbl_include/nbl_include.h"
 #include "../nbl_hw_reg.h"
 
+#define NBL_DRIVER_STATUS_REG			0x1300444
+#define NBL_DRIVER_STATUS_BIT			16
+
 /*  ----------  REG BASE ADDR  ----------  */
 /* Interface modules base addr */
 #define NBL_INTF_HOST_PCOMPLETER_BASE		0x00f08000
@@ -70,6 +73,17 @@ struct nbl_mailbox_qinfo_cfg_table {
 #define NBL_PCIE_BUS_MASK	GENMASK(12, 5)
 
 /*  --------  HOST_PADPT  --------  */
+#define NBL_HOST_PADPT_HOST_CFG_FC_PD_DN (NBL_INTF_HOST_PADPT_BASE + 0x00000160)
+#define NBL_HOST_PADPT_HOST_CFG_FC_PH_DN (NBL_INTF_HOST_PADPT_BASE + 0x00000164)
+#define NBL_HOST_PADPT_HOST_CFG_FC_NPH_DN \
+	(NBL_INTF_HOST_PADPT_BASE + 0x0000016C)
+#define NBL_HOST_PADPT_HOST_CFG_FC_CPLH_UP \
+	(NBL_INTF_HOST_PADPT_BASE + 0x00000170)
+
+#define NBL_HOST_PADPT_CFG_FC_CPLH_UP_VAL      0x10400
+#define NBL_HOST_PADPT_CFG_FC_PD_DN_VAL        0x10080
+#define NBL_HOST_PADPT_CFG_FC_PH_DN_VAL        0x10010
+#define NBL_HOST_PADPT_CFG_FC_NPH_DN_VAL       0x10010
 /* host_padpt host_msix_info */
 #define NBL_PADPT_HOST_MSIX_INFO_REG_ARR(vector_id) \
 	(NBL_INTF_HOST_PADPT_BASE + 0x00010000 +    \
@@ -110,6 +124,231 @@ struct nbl_function_msix_map {
 	u32 data[NBL_FUNC_MSIX_MAP_DWLEN];
 };
 
+/*  ----------  DPED  ----------  */
+#define NBL_DPED_VLAN_OFFSET		(NBL_DP_DPED_BASE + 0x000003F4)
+#define NBL_DPED_DSCP_OFFSET_0		(NBL_DP_DPED_BASE + 0x000003F8)
+#define NBL_DPED_DSCP_OFFSET_1		(NBL_DP_DPED_BASE + 0x000003FC)
+/* DPED hw_edt_prof/ UPED hw_edt_prof */
+
+#define NBL_DPED_L4_CK_CMD_40_ADDR 0x75c338
+#define NBL_DPED_L4_CK_CMD_40_DEPTH 1
+#define NBL_DPED_L4_CK_CMD_40_WIDTH 32
+#define NBL_DPED_L4_CK_CMD_40_DWLEN 1
+
+#define NBL_DPED_L4_CK_CMD_40_VALUE_MASK	GENMASK(7, 0)
+#define NBL_DPED_L4_CK_CMD_40_LEN_IN_OFT_MASK	GENMASK(14, 8)
+#define NBL_DPED_L4_CK_CMD_40_LEN_PHID_MASK	GENMASK(16, 15)
+#define NBL_DPED_L4_CK_CMD_40_LEN_VLD_MASK	BIT(17)
+#define NBL_DPED_L4_CK_CMD_40_DATA_VLD_MASK	GENMASK(18, 18)
+#define NBL_DPED_L4_CK_CMD_40_IN_OFT_MASK	GENMASK(25, 19)
+#define NBL_DPED_L4_CK_CMD_40_PHID_MASK		GENMASK(27, 26)
+#define NBL_DPED_L4_CK_CMD_40_FLAG_MASK		BIT(28)
+#define NBL_DPED_L4_CK_CMD_40_MODE_MASK		BIT(29)
+#define NBL_DPED_L4_CK_CMD_40_RSV_MASK		BIT(30)
+#define NBL_DPED_L4_CK_CMD_40_EN_MASK		BIT(31)
+
+/*  ----------  UPED  ----------  */
+/* UPED uped_hw_edt_prof */
+#define NBL_UPED_HW_EDT_PROF_TABLE(i) \
+	(NBL_DP_UPED_BASE + 0x00001000 + (i) * sizeof(u32))
+#define NBL_UPED_V4_TCP_IDX		5
+#define NBL_UPED_V6_TCP_IDX		6
+#define NBL_PED_HW_EDIT_PROFILE_L3_LEN_MASK GENMASK(3, 2)
+
+/*  ----------  DSCH  ----------  */
+#define NBL_DSCH_PSHA_EN_MASK  GENMASK(3, 0)
+/* DSCH dsch maxqid */
+#define NBL_DSCH_HOST_QID_MAX (NBL_DP_DSCH_BASE + 0x00000118)
+#define NBL_DSCH_VN_QUANTA_ADDR (NBL_DP_DSCH_BASE + 0x00000134)
+
+#define NBL_MAX_QUEUE_ID	0x7ff
+#define NBL_HOST_QUANTA		0x8000
+#define NBL_ECPU_QUANTA		0x1000
+
+#define NBL_DSCH_VN_QUANTA_H_QUA_MASK GENMASK(15, 0)
+#define NBL_DSCH_VN_QUANTA_E_QUA_MASK GENMASK(31, 16)
+
+/*  ----------  DVN  ----------  */
+/* DVN dvn_queue_table */
+#define NBL_DVN_ECPU_QUEUE_NUM			(NBL_DP_DVN_BASE + 0x0000041C)
+#define NBL_DVN_DESCREQ_NUM_CFG			(NBL_DP_DVN_BASE + 0x00000430)
+#define NBL_DVN_DESC_WR_MERGE_TIMEOUT		(NBL_DP_DVN_BASE + 0x00000480)
+#define NBL_DVN_DIF_REQ_RD_RO_FLAG		(NBL_DP_DVN_BASE + 0x0000045C)
+
+#define DEFAULT_DVN_DESCREQ_NUMCFG		0x03
+#define DEFAULT_DVN_100G_DESCREQ_NUMCFG		0x07
+
+#define DEFAULT_DVN_DESC_WR_MERGE_TIMEOUT_MAX	0x3FF
+
+/* spilit ring descreq_num 0:8,1:16 */
+#define NBL_DVN_DESCREQ_NUM_CFG_AVRING_DESREQ_NUM_CFG_MASK BIT(0)
+/* packet ring descreq_num
+ * 0:8,1:12,2:16;3:20,4:24,5:26;6:32,7:32
+ */
+#define NBL_DVN_DESCREQ_NUM_CFG_PACKED_L1_NUM_MASK GENMASK(6, 4)
+
+#define NBL_DVN_DESC_WR_MERGE_TIMEOUT_CFG_CYCLE_MASK GENMASK(9, 0)
+
+#define NBL_DVN_DIF_REQ_RD_RO_FLAG_DESC_RO_EN_MASK BIT(0)
+#define NBL_DVN_DIF_REQ_RD_RO_FLAG_DATA_RO_EN_MASK BIT(1)
+#define NBL_DVN_DIF_REQ_RD_RO_FLAG_AVRING_RO_EN_MASK BIT(2)
+
+/*  ----------  UVN  ----------  */
+/* UVN uvn_queue_table */
+
+#define NBL_UVN_DESC_RD_WAIT			(NBL_DP_UVN_BASE + 0x0000020C)
+#define NBL_UVN_QUEUE_ERR_MASK			(NBL_DP_UVN_BASE + 0x00000224)
+#define NBL_UVN_ECPU_QUEUE_NUM			(NBL_DP_UVN_BASE + 0x0000023C)
+#define NBL_UVN_DESC_WR_TIMEOUT			(NBL_DP_UVN_BASE + 0x00000214)
+#define NBL_UVN_DIF_REQ_RO_FLAG			(NBL_DP_UVN_BASE + 0x00000250)
+#define NBL_UVN_DESC_PREFETCH_INIT		(NBL_DP_UVN_BASE + 0x00000204)
+#define NBL_UVN_DESC_PREFETCH_NUM		4
+
+#define NBL_UVN_DIF_REQ_RO_FLAG_AVAIL_RD_MASK BIT(0)
+#define NBL_UVN_DIF_REQ_RO_FLAG_DESC_RD_MASK BIT(1)
+#define NBL_UVN_DIF_REQ_RO_FLAG_PKT_WR_MASK BIT(2)
+#define NBL_UVN_DIF_REQ_RO_FLAG_DESC_WR_MASK BIT(3)
+
+#define NBL_UVN_DESC_WR_TIMEOUT_NUM_MASK GENMASK(14, 0)
+#define NBL_UVN_DESC_WR_TIMEOUT_MASK_MASK BIT(15)
+
+#define NBL_UVN_QUEUE_ERR_MASK_DIF_ERR_MASK BIT(5)
+
+#define NBL_UVN_DESC_PREFETCH_INIT_NUM_MASK GENMASK(7, 0)
+#define NBL_UVN_DESC_PREFETCH_INIT_SEL_MASK BIT(16)
+
+#define NBL_UVN_DESC_WR_TIMEOUT_VAL 0x12c
+/* 200us = 200000ns / 1.67ns per tick = 119760 ticks */
+#define NBL_UVN_DESC_RD_WAIT_TICKS 119760
+
+/*  --------  USTORE  --------  */
+#define NBL_USTORE_PKT_LEN_ADDR (NBL_DP_USTORE_BASE + 0x00000108)
+#define NBL_USTORE_PORT_DROP_TH_REG_ARR(port_id) \
+	(NBL_DP_USTORE_BASE + 0x00000150 + (port_id) * sizeof(u32))
+#define NBL_USTORE_BUF_PORT_DROP_PKT(eth_id) \
+	(NBL_DP_USTORE_BASE + 0x00002500 + (eth_id) * sizeof(u32))
+#define NBL_USTORE_BUF_PORT_TRUN_PKT(eth_id) \
+	(NBL_DP_USTORE_BASE + 0x00002540 + (eth_id) * sizeof(u32))
+
+#define NBL_USTORE_SINGLE_ETH_DROP_TH		0xC80
+#define NBL_USTORE_DUAL_ETH_DROP_TH		0x640
+#define NBL_USTORE_QUAD_ETH_DROP_TH		0x320
+
+/* USTORE pkt_len */
+#define NBL_USTORE_PKT_LEN_MIN_MASK GENMASK(6, 0)
+
+/* USTORE port_drop_th */
+#define NBL_USTORE_PORT_DROP_TH_DISC_TH_MASK GENMASK(11, 0)
+#define NBL_USTORE_PORT_DROP_TH_EN_MASK BIT(31)
+
+/* UQM*/
+#define NBL_UQM_QUE_TYPE			(NBL_DP_UQM_BASE + 0x0000013c)
+#define NBL_UQM_DROP_PKT_CNT			(NBL_DP_UQM_BASE + 0x000009C0)
+#define NBL_UQM_DROP_PKT_SLICE_CNT		(NBL_DP_UQM_BASE + 0x000009C4)
+#define NBL_UQM_DROP_PKT_LEN_ADD_CNT		(NBL_DP_UQM_BASE + 0x000009C8)
+#define NBL_UQM_DROP_HEAD_PNTR_ADD_CNT		(NBL_DP_UQM_BASE + 0x000009CC)
+#define NBL_UQM_DROP_WEIGHT_ADD_CNT		(NBL_DP_UQM_BASE + 0x000009D0)
+#define NBL_UQM_PORT_DROP_PKT_CNT		(NBL_DP_UQM_BASE + 0x000009D4)
+#define NBL_UQM_PORT_DROP_PKT_SLICE_CNT		(NBL_DP_UQM_BASE + 0x000009F4)
+#define NBL_UQM_PORT_DROP_PKT_LEN_ADD_CNT	(NBL_DP_UQM_BASE + 0x00000A14)
+#define NBL_UQM_PORT_DROP_HEAD_PNTR_ADD_CNT	(NBL_DP_UQM_BASE + 0x00000A34)
+#define NBL_UQM_PORT_DROP_WEIGHT_ADD_CNT	(NBL_DP_UQM_BASE + 0x00000A54)
+#define NBL_UQM_FWD_DROP_CNT			(NBL_DP_UQM_BASE + 0x00000A80)
+#define NBL_UQM_DPORT_DROP_CNT			(NBL_DP_UQM_BASE + 0x00000B74)
+
+#define NBL_UQM_PORT_DROP_DEPTH			6
+#define NBL_UQM_DPORT_DROP_DEPTH		16
+
+/*  ---------  SHAPING  ---------  */
+#define NBL_SHAPING_NET(i)                  \
+	(NBL_DP_SHAPING_BASE + 0x00001800 + \
+	 (i) * sizeof(struct nbl_shaping_net))
+
+/* cir 1, bandwidth 1kB/s in protol environment */
+/* cir 1, bandwidth 1Mb/s */
+#define NBL_LR_LEONIS_NET_BUCKET_DEPTH		9600
+#define NBL_SHAPING_DPORT_ADDR 0x504700
+#define NBL_SHAPING_DPORT_DWLEN 4
+#define NBL_SHAPING_DPORT_REG(r) \
+	(NBL_SHAPING_DPORT_ADDR + (NBL_SHAPING_DPORT_DWLEN * 4) * (r))
+#define NBL_SHAPING_DVN_DPORT_ADDR 0x504750
+#define NBL_SHAPING_DVN_DPORT_DWLEN 4
+#define NBL_SHAPING_DVN_DPORT_REG(r) \
+	(NBL_SHAPING_DVN_DPORT_ADDR + (NBL_SHAPING_DVN_DPORT_DWLEN * 4) * (r))
+#define NBL_DSCH_PSHA_EN_ADDR 0x404314
+#define NBL_SHAPING_NET_ADDR 0x505800
+#define NBL_SHAPING_NET_DWLEN 4
+#define NBL_SHAPING_NET_REG(r) \
+	(NBL_SHAPING_NET_ADDR + (NBL_SHAPING_NET_DWLEN * 4) * (r))
+
+#define DPORT_VALID_MASK (0x1ULL << 0)
+#define DPORT_DEPTH_MASK (0x7FFFFULL << 1)	// [19:1]
+#define DPORT_CIR_MASK (0x7FFFFULL << 20)	// [38:20]
+#define DPORT_PIR_MASK (0x7FFFFULL << 39)	// [57:39]
+#define DPORT_CBS_MASK_LOW (0x3FULL << 58)		// [63:58]
+#define DPORT_CBS_MASK_HIGH (0x7FFFULL << (0)) // [78:64] -> high[14:0]
+#define DPORT_PBS_MASK (0x1FFFFFULL << (79 - 64)) // [99:79] -> high[35:15]
+
+/* SHAPING shaping_net */
+union nbl_shaping_net_u {
+	struct nbl_shaping_net {
+		u64 low;
+		u64 high;
+	} info;
+	u32 data[NBL_SHAPING_NET_DWLEN];
+};
+
+union nbl_shaping_dport_u {
+	struct nbl_shaping_dport {
+		u64 low;
+		u64 high;
+	} info;
+	u32 data[NBL_SHAPING_DPORT_DWLEN];
+};
+
+union nbl_shaping_dvn_dport_u {
+	struct nbl_shaping_dvn_dport {
+		u64 low;
+		u64 high;
+	} info;
+	u32 data[NBL_SHAPING_DVN_DPORT_DWLEN];
+};
+
+/*  --------  DSTORE  --------  */
+#define NBL_DSTORE_D_DPORT_FC_TH_ADDR  0x704600
+#define NBL_DSTORE_D_DPORT_FC_TH_DEPTH 5
+#define NBL_DSTORE_D_DPORT_FC_TH_WIDTH 32
+#define NBL_DSTORE_D_DPORT_FC_TH_DWLEN 1
+
+#define NBL_DSTORE_D_DPORT_FC_XOFF_TH_MASK GENMASK(10, 0)
+#define NBL_DSTORE_D_DPORT_FC_XON_TH_MASK GENMASK(26, 16)
+#define NBL_DSTORE_D_DPORT_FC_FC_EN_MASK BIT(31)
+
+#define NBL_DSTORE_D_DPORT_FC_TH_REG(r)  \
+	(NBL_DSTORE_D_DPORT_FC_TH_ADDR + \
+	 (NBL_DSTORE_D_DPORT_FC_TH_DWLEN * 4) * (r))
+#define NBL_DSTORE_PORT_DROP_TH_ADDR 0x704150
+#define NBL_DSTORE_PORT_DROP_TH_DEPTH 6
+#define NBL_DSTORE_PORT_DROP_TH_WIDTH 32
+#define NBL_DSTORE_PORT_DROP_TH_DWLEN 1
+
+#define NBL_DSTORE_PORT_DROP_DISC_TH_MASK GENMASK(9, 0)
+#define NBL_DSTORE_PORT_DROP_EN_MASK BIT(31)
+
+#define NBL_DSTORE_DROP_XOFF_TH			0xC8
+#define NBL_DSTORE_DROP_XON_TH			0x64
+
+#define NBL_DSTORE_DROP_XOFF_TH_100G		0x1F4
+#define NBL_DSTORE_DROP_XON_TH_100G		0x12C
+
+#define NBL_DSTORE_DISC_BP_TH (NBL_DP_DSTORE_BASE + 0x00000630)
+
+#define NBL_DSTORE_DISC_BP_TH_EN_MASK BIT(31)
+
+#define NBL_DSTORE_PORT_DROP_TH_REG(r)  \
+	(NBL_DSTORE_PORT_DROP_TH_ADDR + \
+	 (NBL_DSTORE_PORT_DROP_TH_DWLEN * 4) * (r))
+
 #define NBL_FW_BOARD_CONFIG			0x200
 #define NBL_FW_BOARD_DW3_OFFSET			(NBL_FW_BOARD_CONFIG + 12)
 #define NBL_FW_BOARD_DW6_OFFSET			(NBL_FW_BOARD_CONFIG + 24)
@@ -123,4 +362,7 @@ struct nbl_function_msix_map {
 #define NBL_FW_BOARD_DW6_LANE_BITMAP_MASK GENMASK(7, 0)
 #define NBL_FW_BOARD_DW6_ETH_BITMAP_MASK GENMASK(15, 8)
 
+#define NBL_LEONIS_QUIRKS_OFFSET	0x00000140
+#define NBL_LEONIS_ILLEGAL_REG_VALUE	0xDEADBEEF
+
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
index e070ade09fee..8b0223381cff 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
@@ -13,6 +13,8 @@ static struct nbl_resource_ops res_ops = {
 	.configure_msix_map = nbl_res_intr_configure_msix_map,
 	.destroy_msix_map = nbl_res_intr_destroy_msix_map,
 	.set_mailbox_irq = nbl_res_intr_set_mailbox_irq,
+	.init_module = nbl_res_vsi_init_module,
+	.deinit_module = nbl_res_vsi_deinit_module,
 };
 
 static struct nbl_resource_mgt *
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
index 1da2abcaf00f..5c41983890bd 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.h
@@ -8,4 +8,5 @@
 
 #include "../nbl_resource.h"
 #include "../nbl_interrupt.h"
+#include "../nbl_vsi.h"
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.c
new file mode 100644
index 000000000000..b746b702755e
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+#include <linux/device.h>
+#include "nbl_vsi.h"
+
+void nbl_res_vsi_deinit_module(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
+
+	hw_ops->deinit_module(res_mgt->hw_ops_tbl->priv);
+}
+
+int nbl_res_vsi_init_module(struct nbl_resource_mgt *res_mgt)
+{
+	u8 eth_speed = res_mgt->resource_info->board_info.eth_speed;
+	u8 eth_num = res_mgt->resource_info->board_info.eth_num;
+	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
+	struct nbl_hw_mgt *p = res_mgt->hw_ops_tbl->priv;
+	int ret;
+
+	ret = hw_ops->init_module(p, eth_speed, eth_num);
+
+	return ret;
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.h
new file mode 100644
index 000000000000..233352f9fad4
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ */
+
+#ifndef _NBL_VSI_H_
+#define _NBL_VSI_H_
+
+#include "nbl_resource.h"
+int nbl_res_vsi_init_module(struct nbl_resource_mgt *res_mgt);
+void nbl_res_vsi_deinit_module(struct nbl_resource_mgt *res_mgt);
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
index 57ea3c64648d..4f4a23c95c1b 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
@@ -11,6 +11,9 @@
 struct nbl_hw_mgt;
 struct nbl_adapter;
 struct nbl_hw_ops {
+	int (*init_module)(struct nbl_hw_mgt *hw_mgt, u8 eth_speed, u8 eth_num);
+	void (*deinit_module)(struct nbl_hw_mgt *hw_mgt);
+
 	void (*configure_msix_map)(struct nbl_hw_mgt *hw_mgt, u16 func_id,
 				   bool valid, dma_addr_t dma_addr, u8 bus,
 				   u8 devid, u8 function);
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
index 9e6995ff6c6f..6aa1342a93c8 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_resource.h
@@ -12,6 +12,9 @@ struct nbl_resource_mgt;
 struct nbl_adapter;
 
 struct nbl_resource_ops {
+	int (*init_module)(struct nbl_resource_mgt *res_mgt);
+	void (*deinit_module)(struct nbl_resource_mgt *res_mgt);
+
 	int (*configure_msix_map)(struct nbl_resource_mgt *res_mgt, u16 func_id,
 				  u16 num_net_msix, u16 num_others_msix,
 				  bool net_msix_mask_en);
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index b0abbb2b58d2..5cd0dac5a776 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -35,4 +35,16 @@ struct nbl_init_param {
 	struct nbl_func_caps caps;
 };
 
+enum nbl_fw_port_speed {
+	NBL_FW_PORT_SPEED_10G,
+	NBL_FW_PORT_SPEED_25G,
+	NBL_FW_PORT_SPEED_50G,
+	NBL_FW_PORT_SPEED_100G,
+};
+
+enum nbl_performance_mode {
+	NBL_QUIRKS_NO_TOE,
+	NBL_QUIRKS_UVN_PREFETCH_ALIGN,
+};
+
 #endif
-- 
2.47.3


