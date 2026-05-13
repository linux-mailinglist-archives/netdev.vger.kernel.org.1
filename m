Return-Path: <netdev+bounces-287357-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AP/cMiXRA2oF/AEAu9opvQ
	(envelope-from <netdev+bounces-287357-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 03:17:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A6552BC4C
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 03:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B4961300BD68
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 01:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1EA358360;
	Wed, 13 May 2026 01:17:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-75.mail.aliyun.com (out28-75.mail.aliyun.com [115.124.28.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B7B356778;
	Wed, 13 May 2026 01:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778635032; cv=none; b=XWL1ZRvwFyF5gB4nZvarBX/L/yb1zn5DES3gNQHTKYx3hz/Ykq8FSAjOSOKpDcF8SJ1iuXxwUdCiu+sYZjAkgGLqQzsx3LmwQ9CIqh/gCaujkerN7pUl+Ld4kby9zF+zON9VVgSB5z1OZipbhscAVvFYeU5ZEq5k8b3ZjQP0iYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778635032; c=relaxed/simple;
	bh=jvyt8g10sXkOwN0TaSeHUaA/HnK+6DDS3twq0XqI3pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U4mqQAnxxjcdJUtLzmNrDnWeIhn4cikqcXebQmiGoGQH2HPPTW8URJQ/9UdMXNrjZq1d5DXjPK9hhB9AtvBJ2+M8XPFKst4vsBuGf1OxOdmjBqH5G0DWF1pyFKqBt3mmhUpFmltnxpTMqMosmorCkxTsMnGCdDboIuP+EA2bvYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=115.124.28.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06712908|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.012726-0.000417011-0.986857;FP=17390607207768809139|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033037017159;MF=illusion.wang@nebula-matrix.com;NM=1;PH=DS;RN=18;RT=18;SR=0;TI=SMTPD_---.hVp4DPb_1778635022;
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.hVp4DPb_1778635022 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 13 May 2026 09:17:03 +0800
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
Subject: [PATCH v14 net-next 08/11] net/nebula-matrix: add vsi resource implementation
Date: Wed, 13 May 2026 09:16:41 +0800
Message-ID: <20260513011649.4404-9-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513011649.4404-1-illusion.wang@nebula-matrix.com>
References: <20260513011649.4404-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A5A6552BC4C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287357-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[nebula-matrix.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,lwn.net,kernel.org,vger.kernel.org,redhat.com,linux.dev,google.com,gmail.com,linuxfoundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.977];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[18];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,illusion.wang:url]
X-Rspamd-Action: no action

The HW (Hardware) layer code can have a quick review since it is
highly chip-specific.
Chip initialization includes the initialization of the DP module, the
intf module, and the P4 registers.
The initialization of the DP module encompasses the initialization of
the dped(downstream pkt edit), uped(upstream pkt edit), dsch(downstream
schedule), ustore, dstore, dvn, uvn, and uqm modules.

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>
---
 .../net/ethernet/nebula-matrix/nbl/Makefile   |   1 +
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  | 407 ++++++++++++++++++
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h  |  12 +-
 .../nbl_hw_leonis/nbl_resource_leonis.c       |   2 +
 .../nebula-matrix/nbl/nbl_hw/nbl_vsi.c        |  26 ++
 .../nebula-matrix/nbl/nbl_hw/nbl_vsi.h        |  12 +
 .../nbl/nbl_include/nbl_def_hw.h              |   4 +
 .../nbl/nbl_include/nbl_include.h             |  31 ++
 8 files changed, 494 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index a56e722a5ac7..241bbb572b5e 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -10,6 +10,7 @@ nbl-objs +=       nbl_common/nbl_common.o \
 				nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.o \
 				nbl_hw/nbl_resource.o \
 				nbl_hw/nbl_interrupt.o \
+				nbl_hw/nbl_vsi.o \
 				nbl_core/nbl_dispatch.o \
 				nbl_core/nbl_dev.o \
 				nbl_main.o
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
index 612d6c9812b0..feb8d1f6fc23 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -9,6 +9,7 @@
 #include <linux/spinlock.h>
 #include <linux/bitfield.h>
 #include "nbl_hw_leonis.h"
+#include "nbl_hw_leonis_regs.h"
 
 static void nbl_hw_read_mbx_regs(struct nbl_hw_mgt *hw_mgt, u64 reg,
 				 u32 *data, u32 len)
@@ -64,6 +65,409 @@ static void nbl_hw_wr_regs(struct nbl_hw_mgt *hw_mgt, u64 reg, const u32 *data,
 	spin_unlock(&hw_mgt->reg_lock);
 }
 
+static u32 nbl_hw_get_quirks(struct nbl_hw_mgt *hw_mgt)
+{
+	u32 quirks;
+
+	nbl_hw_read_mbx_regs(hw_mgt, NBL_LEONIS_QUIRKS_OFFSET, &quirks,
+			     sizeof(u32));
+
+	if (quirks == NBL_LEONIS_ILLEGAL_REG_VALUE)
+		return 0;
+
+	return quirks;
+}
+
+static void nbl_configure_dped_checksum(struct nbl_hw_mgt *hw_mgt)
+{
+	union dped_l4_ck_cmd_40_u l4_ck_cmd_40;
+
+	/* DPED dped_l4_ck_cmd_40 for sctp */
+	nbl_hw_rd_regs(hw_mgt, NBL_DPED_L4_CK_CMD_40_ADDR, l4_ck_cmd_40.data,
+		       sizeof(l4_ck_cmd_40));
+	l4_ck_cmd_40.info.en = 1;
+	nbl_hw_wr_regs(hw_mgt, NBL_DPED_L4_CK_CMD_40_ADDR, l4_ck_cmd_40.data,
+		       sizeof(l4_ck_cmd_40));
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
+	union ped_hw_edit_profile_u hw_edit;
+
+	nbl_hw_rd_regs(hw_mgt, NBL_UPED_HW_EDT_PROF_TABLE(NBL_DPED_V4_TCP_IDX),
+		       &hw_edit.data, sizeof(hw_edit));
+	hw_edit.info.l3_len = 0;
+	nbl_hw_wr_regs(hw_mgt, NBL_UPED_HW_EDT_PROF_TABLE(NBL_DPED_V4_TCP_IDX),
+		       &hw_edit.data, sizeof(hw_edit));
+
+	nbl_hw_rd_regs(hw_mgt, NBL_UPED_HW_EDT_PROF_TABLE(NBL_DPED_V6_TCP_IDX),
+		       &hw_edit.data, sizeof(hw_edit));
+	hw_edit.info.l3_len = 1;
+	nbl_hw_wr_regs(hw_mgt, NBL_UPED_HW_EDT_PROF_TABLE(NBL_DPED_V6_TCP_IDX),
+		       &hw_edit.data, sizeof(hw_edit));
+}
+
+static void nbl_shaping_eth_init(struct nbl_hw_mgt *hw_mgt, u8 eth_id, u8 speed)
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
+		dev_err(hw_mgt->common->dev, "Unsupported port speed %u for eth%u\n",
+			speed, eth_id);
+		break;
+	}
+
+	half_rate = rate / 2;
+	depth =  max(rate * 2, NBL_LR_LEONIS_NET_BUCKET_DEPTH);
+	dport.info.low |= FIELD_PREP(DPORT_CIR_MASK, rate);
+	dport.info.low |= FIELD_PREP(DPORT_PIR_MASK, rate);
+	dport.info.low |= FIELD_PREP(DPORT_DEPTH_MASK, depth);
+	dport.info.low  |= FIELD_PREP(DPORT_CBS_MASK_LOW, depth & 0x3F);
+	dport.info.high  |= FIELD_PREP(DPORT_CBS_MASK_HIGH, depth >> 6);
+	dport.info.high  |= FIELD_PREP(DPORT_PBS_MASK, depth);
+	dport.info.low |= FIELD_PREP(DPORT_VALID_MASK, 1);
+
+	dvn_dport.info.low |= FIELD_PREP(DPORT_CIR_MASK, half_rate);
+	dvn_dport.info.low |= FIELD_PREP(DPORT_PIR_MASK, rate);
+	dvn_dport.info.low |= FIELD_PREP(DPORT_DEPTH_MASK, depth);
+	dvn_dport.info.low |= FIELD_PREP(DPORT_CBS_MASK_LOW, depth & 0x3F);
+	dvn_dport.info.high |= FIELD_PREP(DPORT_CBS_MASK_HIGH, depth >> 6);
+	dvn_dport.info.high |= FIELD_PREP(DPORT_PBS_MASK, depth);
+	dvn_dport.info.low |= FIELD_PREP(DPORT_VALID_MASK, 1);
+
+	nbl_hw_wr_regs(hw_mgt, NBL_SHAPING_DPORT_REG(eth_id), dport.data,
+		       sizeof(dport));
+	nbl_hw_wr_regs(hw_mgt, NBL_SHAPING_DVN_DPORT_REG(eth_id),
+		       dvn_dport.data, sizeof(dvn_dport));
+}
+
+static void nbl_shaping_init(struct nbl_hw_mgt *hw_mgt, u8 speed)
+{
+#define NBL_SHAPING_FLUSH_INTERVAL 128
+	union nbl_shaping_net_u net_shaping = { 0 };
+	union dsch_psha_en_u psha_en = { 0 };
+	int i;
+
+	for (i = 0; i < NBL_MAX_ETHERNET; i++)
+		nbl_shaping_eth_init(hw_mgt, i, speed);
+
+	psha_en.info.en = 0xF;
+	nbl_hw_wr_regs(hw_mgt, NBL_DSCH_PSHA_EN_ADDR, &psha_en.data,
+		       sizeof(psha_en));
+
+	for (i = 0; i < NBL_MAX_FUNC; i++) {
+		nbl_hw_wr_regs(hw_mgt, NBL_SHAPING_NET_REG(i),
+			       net_shaping.data, sizeof(net_shaping));
+		if ((i % NBL_SHAPING_FLUSH_INTERVAL) == 0)
+			nbl_flush_writes(hw_mgt);
+	}
+	nbl_flush_writes(hw_mgt);
+}
+
+static void nbl_dsch_qid_max_init(struct nbl_hw_mgt *hw_mgt)
+{
+	union dsch_vn_quanta_u quanta = { 0 };
+
+	quanta.info.h_qua = NBL_HOST_QUANTA;
+	quanta.info.e_qua = NBL_ECPU_QUANTA;
+	nbl_hw_wr_regs(hw_mgt, NBL_DSCH_VN_QUANTA_ADDR, &quanta.data,
+		       sizeof(quanta));
+	nbl_hw_wr32(hw_mgt, NBL_DSCH_HOST_QID_MAX, NBL_MAX_QUEUE_ID);
+
+	nbl_hw_wr32(hw_mgt, NBL_DVN_ECPU_QUEUE_NUM, 0);
+	nbl_hw_wr32(hw_mgt, NBL_UVN_ECPU_QUEUE_NUM, 0);
+}
+
+static void nbl_ustore_init(struct nbl_hw_mgt *hw_mgt, u8 eth_num)
+{
+	union nbl_ustore_port_drop_th_u drop_th = { 0 };
+	union ustore_pkt_len_u pkt_len;
+	int i;
+
+	/* Read current packet length config
+	 *(to preserve other fields while updating 'min')
+	 */
+	nbl_hw_rd_regs(hw_mgt, NBL_USTORE_PKT_LEN_ADDR, &pkt_len.data,
+		       sizeof(pkt_len));
+	/* min arp packet length 42 (14 + 28) */
+	pkt_len.info.min = 42;
+	nbl_hw_wr_regs(hw_mgt, NBL_USTORE_PKT_LEN_ADDR, &pkt_len.data,
+		       sizeof(pkt_len));
+
+	drop_th.info.en = 1;
+	if (eth_num == 1)
+		drop_th.info.disc_th = NBL_USTORE_SINGLE_ETH_DROP_TH;
+	else if (eth_num == 2)
+		drop_th.info.disc_th = NBL_USTORE_DUAL_ETH_DROP_TH;
+	else
+		drop_th.info.disc_th = NBL_USTORE_QUAD_ETH_DROP_TH;
+
+	for (i = 0; i < NBL_MAX_ETHERNET; i++)
+		nbl_hw_wr_regs(hw_mgt, NBL_USTORE_PORT_DROP_TH_REG_ARR(i),
+			       &drop_th.data, sizeof(drop_th));
+
+	/* Clear port drop/truncate counters by reading them
+	 * (hardware has read-to-clear behavior for these registers)
+	 */
+	for (i = 0; i < NBL_MAX_ETHERNET; i++) {
+		nbl_hw_rd32(hw_mgt, NBL_USTORE_BUF_PORT_DROP_PKT(i));
+		nbl_hw_rd32(hw_mgt, NBL_USTORE_BUF_PORT_TRUN_PKT(i));
+	}
+}
+
+static void nbl_dstore_init(struct nbl_hw_mgt *hw_mgt, u8 speed)
+{
+	union dstore_port_drop_th_u drop_th;
+	union dstore_d_dport_fc_th_u fc_th;
+	union dstore_disc_bp_th_u bp_th;
+	int i;
+
+	for (i = 0; i < NBL_DSTORE_PORT_DROP_TH_DEPTH; i++) {
+		nbl_hw_rd_regs(hw_mgt, NBL_DSTORE_PORT_DROP_TH_REG(i),
+			       drop_th.data, sizeof(drop_th));
+		drop_th.info.en = 0;
+		nbl_hw_wr_regs(hw_mgt, NBL_DSTORE_PORT_DROP_TH_REG(i),
+			       drop_th.data, sizeof(drop_th));
+	}
+
+	nbl_hw_rd_regs(hw_mgt, NBL_DSTORE_DISC_BP_TH, &bp_th.data,
+		       sizeof(bp_th));
+	bp_th.info.en = 1;
+	nbl_hw_wr_regs(hw_mgt, NBL_DSTORE_DISC_BP_TH, &bp_th.data,
+		       sizeof(bp_th));
+
+	for (i = 0; i < NBL_MAX_ETHERNET; i++) {
+		nbl_hw_rd_regs(hw_mgt, NBL_DSTORE_D_DPORT_FC_TH_REG(i),
+			       fc_th.data, sizeof(fc_th));
+		if (speed == NBL_FW_PORT_SPEED_100G) {
+			fc_th.info.xoff_th = NBL_DSTORE_DROP_XOFF_TH_100G;
+			fc_th.info.xon_th = NBL_DSTORE_DROP_XON_TH_100G;
+		} else {
+			fc_th.info.xoff_th = NBL_DSTORE_DROP_XOFF_TH;
+			fc_th.info.xon_th = NBL_DSTORE_DROP_XON_TH;
+		}
+
+		fc_th.info.fc_en = 1;
+		nbl_hw_wr_regs(hw_mgt, NBL_DSTORE_D_DPORT_FC_TH_REG(i),
+			       fc_th.data, sizeof(fc_th));
+	}
+}
+
+static void nbl_dvn_descreq_num_cfg(struct nbl_hw_mgt *hw_mgt, u32 descreq_num)
+{
+	u32 split_ring_num = (descreq_num >> 16) & 0xffff;
+	union nbl_dvn_descreq_num_cfg_u num_cfg = { 0 };
+	u32 packet_ring_num = descreq_num & 0xffff;
+
+	packet_ring_num =
+		clamp(packet_ring_num, PACKET_RING_MIN, PACKET_RING_MAX);
+	num_cfg.info.packed_l1_num =
+		(packet_ring_num - PACKET_RING_BASE) / PACKET_RING_DIV;
+
+	split_ring_num = clamp(split_ring_num, SPLIT_RING_MIN,
+			       SPLIT_RING_MAX);
+	num_cfg.info.avring_cfg_num = split_ring_num > SPLIT_RING_MIN ?
+					SPLIT_RING_CFG_16 :
+					SPLIT_RING_CFG_8;
+
+	nbl_hw_wr_regs(hw_mgt, NBL_DVN_DESCREQ_NUM_CFG, &num_cfg.data,
+		       sizeof(num_cfg));
+}
+
+static void nbl_dvn_init(struct nbl_hw_mgt *hw_mgt, u8 speed)
+{
+	union nbl_dvn_desc_wr_merge_timeout_u timeout = { 0 };
+	union nbl_dvn_dif_req_rd_ro_flag_u ro_flag = { 0 };
+
+	timeout.info.cfg_cycle = DEFAULT_DVN_DESC_WR_MERGE_TIMEOUT_MAX;
+	nbl_hw_wr_regs(hw_mgt, NBL_DVN_DESC_WR_MERGE_TIMEOUT, &timeout.data,
+		       sizeof(timeout));
+
+	ro_flag.info.rd_desc_ro_en = 1;
+	ro_flag.info.rd_data_ro_en = 1;
+	ro_flag.info.rd_avring_ro_en = 1;
+	nbl_hw_wr_regs(hw_mgt, NBL_DVN_DIF_REQ_RD_RO_FLAG, &ro_flag.data,
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
+	union uvn_desc_prefetch_init_u prefetch_init = { 0 };
+	union uvn_desc_wr_timeout_u desc_wr_timeout = { 0 };
+	union uvn_dif_req_ro_flag_u flag = { 0 };
+	union uvn_queue_err_mask_u mask = { 0 };
+	u16 wr_timeout = 0x12c;
+	u32 timeout = 119760; /* 200us 200000/1.67 */
+	u32 quirks;
+
+	nbl_hw_wr32(hw_mgt, NBL_UVN_DESC_RD_WAIT, timeout);
+
+	desc_wr_timeout.info.num = wr_timeout;
+	nbl_hw_wr_regs(hw_mgt, NBL_UVN_DESC_WR_TIMEOUT, &desc_wr_timeout.data,
+		       sizeof(desc_wr_timeout));
+
+	flag.info.avail_rd = 1;
+	flag.info.desc_rd = 1;
+	flag.info.pkt_wr = 1;
+	flag.info.desc_wr = 0;
+	nbl_hw_wr_regs(hw_mgt, NBL_UVN_DIF_REQ_RO_FLAG, &flag.data,
+		       sizeof(flag));
+
+	nbl_hw_rd_regs(hw_mgt, NBL_UVN_QUEUE_ERR_MASK, &mask.data,
+		       sizeof(mask));
+	mask.info.dif_err = 1;
+	nbl_hw_wr_regs(hw_mgt, NBL_UVN_QUEUE_ERR_MASK, &mask.data,
+		       sizeof(mask));
+
+	prefetch_init.info.num = NBL_UVN_DESC_PREFETCH_NUM;
+	prefetch_init.info.sel = 0;
+	quirks = nbl_hw_get_quirks(hw_mgt);
+	if (!(quirks & BIT(NBL_QUIRKS_UVN_PREFETCH_ALIGN)))
+		prefetch_init.info.sel = 1;
+	nbl_hw_wr_regs(hw_mgt, NBL_UVN_DESC_PREFETCH_INIT,
+		       &prefetch_init.data, sizeof(prefetch_init));
+}
+
+static void nbl_uqm_init(struct nbl_hw_mgt *hw_mgt)
+{
+	union nbl_uqm_que_type_u que_type = { 0 };
+	u32 cnt = 0;
+	int i;
+
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_FWD_DROP_CNT, &cnt, sizeof(cnt));
+
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_DROP_PKT_CNT, &cnt, sizeof(cnt));
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_DROP_PKT_SLICE_CNT, &cnt,
+		       sizeof(cnt));
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_DROP_PKT_LEN_ADD_CNT, &cnt,
+		       sizeof(cnt));
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_DROP_HEAD_PNTR_ADD_CNT, &cnt,
+		       sizeof(cnt));
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_DROP_WEIGHT_ADD_CNT, &cnt,
+		       sizeof(cnt));
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
+			       NBL_UQM_DPORT_DROP_CNT + (sizeof(cnt) * i),
+			       &cnt, sizeof(cnt));
+
+	que_type.info.bp_drop = 0;
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_QUE_TYPE, &que_type.data,
+		       sizeof(que_type));
+}
+
+static void nbl_dp_init(struct nbl_hw_mgt *hw_mgt, u8 speed, u8 eth_num)
+{
+	nbl_dped_init(hw_mgt);
+	nbl_uped_init(hw_mgt);
+	nbl_shaping_init(hw_mgt, speed);
+	nbl_dsch_qid_max_init(hw_mgt);
+	nbl_ustore_init(hw_mgt, eth_num);
+	nbl_dstore_init(hw_mgt, speed);
+	nbl_dvn_init(hw_mgt, speed);
+	nbl_uvn_init(hw_mgt);
+	nbl_uqm_init(hw_mgt);
+}
+
+static void nbl_host_padpt_init(struct nbl_hw_mgt *hw_mgt)
+{
+	/* padpt flow  control register */
+	nbl_hw_wr32(hw_mgt, NBL_HOST_PADPT_HOST_CFG_FC_CPLH_UP, 0x10400);
+	nbl_hw_wr32(hw_mgt, NBL_HOST_PADPT_HOST_CFG_FC_PD_DN, 0x10080);
+	nbl_hw_wr32(hw_mgt, NBL_HOST_PADPT_HOST_CFG_FC_PH_DN, 0x10010);
+	nbl_hw_wr32(hw_mgt, NBL_HOST_PADPT_HOST_CFG_FC_NPH_DN, 0x10010);
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
+static void nbl_hw_deinit_chip_module(struct nbl_hw_mgt *hw_mgt)
+{
+	nbl_hw_set_driver_status(hw_mgt, false);
+}
+
+static int nbl_hw_init_chip_module(struct nbl_hw_mgt *hw_mgt, u8 eth_speed,
+				   u8 eth_num)
+{
+	nbl_dp_init(hw_mgt, eth_speed, eth_num);
+	nbl_intf_init(hw_mgt);
+
+	nbl_write_all_regs(hw_mgt);
+	nbl_hw_set_driver_status(hw_mgt, true);
+	/*ensure registers written*/
+	nbl_flush_writes(hw_mgt);
+
+	return 0;
+}
+
 static void nbl_hw_enable_mailbox_irq(struct nbl_hw_mgt *hw_mgt, u16 func_id,
 				      bool enable_msix, u16 global_vec_id)
 {
@@ -270,6 +674,9 @@ static u32 nbl_hw_get_fw_eth_map(struct nbl_hw_mgt *hw_mgt)
 }
 
 static struct nbl_hw_ops hw_ops = {
+	.init_chip_module = nbl_hw_init_chip_module,
+	.deinit_chip_module = nbl_hw_deinit_chip_module,
+
 	.configure_msix_map = nbl_hw_configure_msix_map,
 	.configure_msix_info = nbl_hw_configure_msix_info,
 	.flush_write = nbl_flush_writes,
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
index 7eef749eeb69..75bb8b715f35 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.h
@@ -143,7 +143,8 @@ union nbl_function_msix_map_u {
 #define NBL_DPED_VLAN_OFFSET		(NBL_DP_DPED_BASE + 0x000003F4)
 #define NBL_DPED_DSCP_OFFSET_0		(NBL_DP_DPED_BASE + 0x000003F8)
 #define NBL_DPED_DSCP_OFFSET_1		(NBL_DP_DPED_BASE + 0x000003FC)
-
+#define NBL_DPED_V4_TCP_IDX		5
+#define NBL_DPED_V6_TCP_IDX		6
 /* DPED hw_edt_prof/ UPED hw_edt_prof */
 union ped_hw_edit_profile_u {
 	struct ped_hw_edit_profile {
@@ -258,6 +259,15 @@ union dsch_vn_quanta_u {
 
 #define DEFAULT_DVN_DESC_WR_MERGE_TIMEOUT_MAX	0x3FF
 
+#define PACKET_RING_MIN 8U
+#define PACKET_RING_MAX 32U
+#define SPLIT_RING_MIN 8U
+#define SPLIT_RING_MAX 16U
+#define PACKET_RING_BASE 8U
+#define PACKET_RING_DIV 4U
+#define SPLIT_RING_CFG_8 0U
+#define SPLIT_RING_CFG_16 1U
+
 union nbl_dvn_descreq_num_cfg_u {
 	struct nbl_dvn_descreq_num_cfg {
 		u32 avring_cfg_num:1; /* spilit ring descreq_num 0:8,1:16 */
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
index e0cfad759826..d29f69bae7d1 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
@@ -13,6 +13,8 @@ static struct nbl_resource_ops res_ops = {
 	.configure_msix_map = nbl_res_intr_configure_msix_map,
 	.destroy_msix_map = nbl_res_intr_destroy_msix_map,
 	.enable_mailbox_irq = nbl_res_intr_enable_mailbox_irq,
+	.init_chip_module = nbl_res_vsi_init_chip_module,
+	.deinit_chip_module = nbl_res_vsi_deinit_chip_module,
 };
 
 static struct nbl_resource_mgt *
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.c
new file mode 100644
index 000000000000..5d0076933eb8
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
+void nbl_res_vsi_deinit_chip_module(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
+
+	hw_ops->deinit_chip_module(res_mgt->hw_ops_tbl->priv);
+}
+
+int nbl_res_vsi_init_chip_module(struct nbl_resource_mgt *res_mgt)
+{
+	u8 eth_speed = res_mgt->resource_info->board_info.eth_speed;
+	u8 eth_num = res_mgt->resource_info->board_info.eth_num;
+	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
+	struct nbl_hw_mgt *p = res_mgt->hw_ops_tbl->priv;
+	int ret;
+
+	ret = hw_ops->init_chip_module(p, eth_speed, eth_num);
+
+	return ret;
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.h
new file mode 100644
index 000000000000..6089874fefae
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
+int nbl_res_vsi_init_chip_module(struct nbl_resource_mgt *res_mgt);
+void nbl_res_vsi_deinit_chip_module(struct nbl_resource_mgt *res_mgt);
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
index bfb7006d9379..bd08ddca08b3 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
@@ -11,6 +11,10 @@
 struct nbl_hw_mgt;
 struct nbl_adapter;
 struct nbl_hw_ops {
+	int (*init_chip_module)(struct nbl_hw_mgt *hw_mgt, u8 eth_speed,
+				u8 eth_num);
+	void (*deinit_chip_module)(struct nbl_hw_mgt *hw_mgt);
+
 	void (*configure_msix_map)(struct nbl_hw_mgt *hw_mgt, u16 func_id,
 				   bool valid, dma_addr_t dma_addr, u8 bus,
 				   u8 devid, u8 function);
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index e4f11e6ded94..5203bb2a9a5f 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -45,4 +45,35 @@ struct nbl_init_param {
 	bool pci_using_dac;
 };
 
+enum nbl_fw_port_speed {
+	NBL_FW_PORT_SPEED_10G,
+	NBL_FW_PORT_SPEED_25G,
+	NBL_FW_PORT_SPEED_50G,
+	NBL_FW_PORT_SPEED_100G,
+};
+
+#define NBL_OPS_CALL(func, para)		\
+do {						\
+	typeof(func) _func = (func);		\
+	if (_func)				\
+		_func para;			\
+} while (0)
+
+#define NBL_OPS_CALL_RET(func, para)		\
+({						\
+	typeof(func) _func = (func);		\
+	_func ? _func para : 0;			\
+})
+
+#define NBL_OPS_CALL_RET_PTR(func, para)	\
+({						\
+	typeof(func) _func = (func);		\
+	_func ? _func para : NULL;		\
+})
+
+enum nbl_performance_mode {
+	NBL_QUIRKS_NO_TOE,
+	NBL_QUIRKS_UVN_PREFETCH_ALIGN,
+};
+
 #endif
-- 
2.47.3


