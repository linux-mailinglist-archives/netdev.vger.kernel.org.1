Return-Path: <netdev+bounces-257393-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLGhFAxRhWmV/wMAu9opvQ
	(envelope-from <netdev+bounces-257393-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 03:25:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FF7F9400
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 03:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C5313007214
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 02:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F30D2580EE;
	Fri,  6 Feb 2026 02:23:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-10.us.a.mail.aliyun.com (out198-10.us.a.mail.aliyun.com [47.90.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B67F2376FD;
	Fri,  6 Feb 2026 02:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770344636; cv=none; b=ifkyN87vtDaAPNOay8tcnvsqm9I+DCbIdYTcy0cDBR1glT3C8ESNxK0KoVnj39KyPNAJFTbAq5xCYsu+EvSz9fK5aJlTxcRvXtBRP6HXWgLQr8c4da1ZCDQ7mp8k0FX/3kT/5HkLfkYaDUf/PgNjt66UZKAlJ5gmjR7Ql43d2G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770344636; c=relaxed/simple;
	bh=62muWcoFEUjH0Z+/28MhTgkhXPTIL5n4+9Fi+Dqvmkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mb5P4KJ2IllQoV7GeY9XQDsX8G3ambPcJrY1dIYAtIMBFQR1UxL/Vb3dWKWZAzX9KK3faeBXut6poe7Zg7RL11xZXeyolSA4RcC2kZxbeW9fCmiVGgiTqZwZnAWvivSC7dIJC29AITphlQckeAi/rhA5bCAvgXfo2ZxEk2E0ZY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.gQHg4os_1770344298 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 06 Feb 2026 10:18:19 +0800
From: "illusion.wang" <illusion.wang@nebula-matrix.com>
To: dimon.zhao@nebula-matrix.com,
	illusion.wang@nebula-matrix.com,
	alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	corbet@lwn.net,
	kuba@kernel.org,
	linux-doc@vger.kernel.org,
	lorenzo@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com,
	edumazet@google.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 net-next 08/11] net/nebula-matrix: add vsi resource implementation
Date: Fri,  6 Feb 2026 10:16:00 +0800
Message-ID: <20260206021608.85381-9-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206021608.85381-1-illusion.wang@nebula-matrix.com>
References: <20260206021608.85381-1-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	DMARC_NA(0.00)[nebula-matrix.com];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257393-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.987];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nebula-matrix.com:mid,nebula-matrix.com:email,illusion.wang:url]
X-Rspamd-Queue-Id: 62FF7F9400
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
 .../nbl_hw_leonis/nbl_resource_leonis.c       |   6 +-
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   |   1 +
 .../nebula-matrix/nbl/nbl_hw/nbl_vsi.c        |  54 +++
 .../nebula-matrix/nbl/nbl_hw/nbl_vsi.h        |  12 +
 .../nbl/nbl_include/nbl_def_hw.h              |   4 +
 .../nbl/nbl_include/nbl_include.h             |  31 ++
 8 files changed, 514 insertions(+), 2 deletions(-)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index 2d1ac72352bd..5c07fd65ad32 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -11,6 +11,7 @@ nbl_core-objs +=       nbl_common/nbl_common.o \
 				nbl_hw/nbl_hw_leonis/nbl_hw_leonis_regs.o \
 				nbl_hw/nbl_resource.o \
 				nbl_hw/nbl_interrupt.o \
+				nbl_hw/nbl_vsi.o \
 				nbl_core/nbl_dispatch.o \
 				nbl_core/nbl_dev.o \
 				nbl_main.o
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
index 837a4591849d..a34dad884b47 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -5,6 +5,410 @@
  */
 
 #include "nbl_hw_leonis.h"
+#include "nbl_hw_leonis_regs.h"
+
+static u32 nbl_hw_get_quirks(struct nbl_hw_mgt *hw_mgt)
+{
+	u32 quirks;
+
+	nbl_hw_read_mbx_regs(hw_mgt, NBL_LEONIS_QUIRKS_OFFSET, (u8 *)&quirks,
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
+	nbl_hw_rd_regs(hw_mgt, NBL_DPED_L4_CK_CMD_40_ADDR, (u8 *)&l4_ck_cmd_40,
+		       sizeof(l4_ck_cmd_40));
+	l4_ck_cmd_40.info.en = 1;
+	nbl_hw_wr_regs(hw_mgt, NBL_DPED_L4_CK_CMD_40_ADDR, (u8 *)&l4_ck_cmd_40,
+		       sizeof(l4_ck_cmd_40));
+}
+
+static int nbl_dped_init(struct nbl_hw_mgt *hw_mgt)
+{
+	nbl_hw_wr32(hw_mgt, NBL_DPED_VLAN_OFFSET, 0xC);
+	nbl_hw_wr32(hw_mgt, NBL_DPED_DSCP_OFFSET_0, 0x8);
+	nbl_hw_wr32(hw_mgt, NBL_DPED_DSCP_OFFSET_1, 0x4);
+
+	// dped checksum offload
+	nbl_configure_dped_checksum(hw_mgt);
+
+	return 0;
+}
+
+static int nbl_uped_init(struct nbl_hw_mgt *hw_mgt)
+{
+	struct ped_hw_edit_profile hw_edit;
+
+	nbl_hw_rd_regs(hw_mgt, NBL_UPED_HW_EDT_PROF_TABLE(5), (u8 *)&hw_edit,
+		       sizeof(hw_edit));
+	hw_edit.l3_len = 0;
+	nbl_hw_wr_regs(hw_mgt, NBL_UPED_HW_EDT_PROF_TABLE(5), (u8 *)&hw_edit,
+		       sizeof(hw_edit));
+
+	nbl_hw_rd_regs(hw_mgt, NBL_UPED_HW_EDT_PROF_TABLE(6), (u8 *)&hw_edit,
+		       sizeof(hw_edit));
+	hw_edit.l3_len = 1;
+	nbl_hw_wr_regs(hw_mgt, NBL_UPED_HW_EDT_PROF_TABLE(6), (u8 *)&hw_edit,
+		       sizeof(hw_edit));
+
+	return 0;
+}
+
+static void nbl_shaping_eth_init(struct nbl_hw_mgt *hw_mgt, u8 eth_id, u8 speed)
+{
+	struct nbl_shaping_dvn_dport dvn_dport = { 0 };
+	struct nbl_shaping_dport dport = { 0 };
+	u32 rate, half_rate;
+
+	if (speed == NBL_FW_PORT_SPEED_100G) {
+		rate = NBL_SHAPING_DPORT_100G_RATE;
+		half_rate = NBL_SHAPING_DPORT_HALF_100G_RATE;
+	} else {
+		rate = NBL_SHAPING_DPORT_25G_RATE;
+		half_rate = NBL_SHAPING_DPORT_HALF_25G_RATE;
+	}
+
+	dport.cir = rate;
+	dport.pir = rate;
+	dport.depth = max(dport.cir * 2, NBL_LR_LEONIS_NET_BUCKET_DEPTH);
+	dport.cbs = dport.depth;
+	dport.pbs = dport.depth;
+	dport.valid = 1;
+
+	dvn_dport.cir = half_rate;
+	dvn_dport.pir = rate;
+	dvn_dport.depth = dport.depth;
+	dvn_dport.cbs = dvn_dport.depth;
+	dvn_dport.pbs = dvn_dport.depth;
+	dvn_dport.valid = 1;
+
+	nbl_hw_wr_regs(hw_mgt, NBL_SHAPING_DPORT_REG(eth_id), (u8 *)&dport,
+		       sizeof(dport));
+	nbl_hw_wr_regs(hw_mgt, NBL_SHAPING_DVN_DPORT_REG(eth_id),
+		       (u8 *)&dvn_dport, sizeof(dvn_dport));
+}
+
+static int nbl_shaping_init(struct nbl_hw_mgt *hw_mgt, u8 speed)
+{
+#define NBL_SHAPING_FLUSH_INTERVAL 128
+	struct nbl_shaping_net net_shaping = { 0 };
+	struct dsch_psha_en psha_en = { 0 };
+	int i;
+
+	for (i = 0; i < NBL_MAX_ETHERNET; i++)
+		nbl_shaping_eth_init(hw_mgt, i, speed);
+
+	psha_en.en = 0xF;
+	nbl_hw_wr_regs(hw_mgt, NBL_DSCH_PSHA_EN_ADDR, (u8 *)&psha_en,
+		       sizeof(psha_en));
+
+	for (i = 0; i < NBL_MAX_FUNC; i++) {
+		nbl_hw_wr_regs(hw_mgt, NBL_SHAPING_NET_REG(i),
+			       (u8 *)&net_shaping, sizeof(net_shaping));
+		if ((i % NBL_SHAPING_FLUSH_INTERVAL) == 0)
+			nbl_flush_writes(hw_mgt);
+	}
+	nbl_flush_writes(hw_mgt);
+	return 0;
+}
+
+static int nbl_dsch_qid_max_init(struct nbl_hw_mgt *hw_mgt)
+{
+	struct dsch_vn_quanta quanta = { 0 };
+
+	quanta.h_qua = NBL_HOST_QUANTA;
+	quanta.e_qua = NBL_ECPU_QUANTA;
+	nbl_hw_wr_regs(hw_mgt, NBL_DSCH_VN_QUANTA_ADDR, (u8 *)&quanta,
+		       sizeof(quanta));
+	nbl_hw_wr32(hw_mgt, NBL_DSCH_HOST_QID_MAX, NBL_MAX_QUEUE_ID);
+
+	nbl_hw_wr32(hw_mgt, NBL_DVN_ECPU_QUEUE_NUM, 0);
+	nbl_hw_wr32(hw_mgt, NBL_UVN_ECPU_QUEUE_NUM, 0);
+
+	return 0;
+}
+
+static int nbl_ustore_init(struct nbl_hw_mgt *hw_mgt, u8 eth_num)
+{
+	struct nbl_ustore_port_drop_th drop_th;
+	struct ustore_pkt_len pkt_len;
+	int i;
+
+	nbl_hw_rd_regs(hw_mgt, NBL_USTORE_PKT_LEN_ADDR, (u8 *)&pkt_len,
+		       sizeof(pkt_len));
+	/* min arp packet length 42 (14 + 28) */
+	pkt_len.min = 42;
+	nbl_hw_wr_regs(hw_mgt, NBL_USTORE_PKT_LEN_ADDR, (u8 *)&pkt_len,
+		       sizeof(pkt_len));
+
+	drop_th.en = 1;
+	if (eth_num == 1)
+		drop_th.disc_th = NBL_USTORE_SIGNLE_ETH_DROP_TH;
+	else if (eth_num == 2)
+		drop_th.disc_th = NBL_USTORE_DUAL_ETH_DROP_TH;
+	else
+		drop_th.disc_th = NBL_USTORE_QUAD_ETH_DROP_TH;
+
+	for (i = 0; i < 4; i++)
+		nbl_hw_wr_regs(hw_mgt, NBL_USTORE_PORT_DROP_TH_REG_ARR(i),
+			       (u8 *)&drop_th, sizeof(drop_th));
+
+	for (i = 0; i < NBL_MAX_ETHERNET; i++) {
+		nbl_hw_rd32(hw_mgt, NBL_USTORE_BUF_PORT_DROP_PKT(i));
+		nbl_hw_rd32(hw_mgt, NBL_USTORE_BUF_PORT_TRUN_PKT(i));
+	}
+
+	return 0;
+}
+
+static int nbl_dstore_init(struct nbl_hw_mgt *hw_mgt, u8 speed)
+{
+	struct dstore_port_drop_th drop_th;
+	struct dstore_d_dport_fc_th fc_th;
+	struct dstore_disc_bp_th bp_th;
+	int i;
+
+	for (i = 0; i < 6; i++) {
+		nbl_hw_rd_regs(hw_mgt, NBL_DSTORE_PORT_DROP_TH_REG(i),
+			       (u8 *)&drop_th, sizeof(drop_th));
+		drop_th.en = 0;
+		nbl_hw_wr_regs(hw_mgt, NBL_DSTORE_PORT_DROP_TH_REG(i),
+			       (u8 *)&drop_th, sizeof(drop_th));
+	}
+
+	nbl_hw_rd_regs(hw_mgt, NBL_DSTORE_DISC_BP_TH, (u8 *)&bp_th,
+		       sizeof(bp_th));
+	bp_th.en = 1;
+	nbl_hw_wr_regs(hw_mgt, NBL_DSTORE_DISC_BP_TH, (u8 *)&bp_th,
+		       sizeof(bp_th));
+
+	for (i = 0; i < 4; i++) {
+		nbl_hw_rd_regs(hw_mgt, NBL_DSTORE_D_DPORT_FC_TH_REG(i),
+			       (u8 *)&fc_th, sizeof(fc_th));
+		if (speed == NBL_FW_PORT_SPEED_100G) {
+			fc_th.xoff_th = NBL_DSTORE_DROP_XOFF_TH_100G;
+			fc_th.xon_th = NBL_DSTORE_DROP_XON_TH_100G;
+		} else {
+			fc_th.xoff_th = NBL_DSTORE_DROP_XOFF_TH;
+			fc_th.xon_th = NBL_DSTORE_DROP_XON_TH;
+		}
+
+		fc_th.fc_en = 1;
+		nbl_hw_wr_regs(hw_mgt, NBL_DSTORE_D_DPORT_FC_TH_REG(i),
+			       (u8 *)&fc_th, sizeof(fc_th));
+	}
+
+	return 0;
+}
+
+static void nbl_dvn_descreq_num_cfg(struct nbl_hw_mgt *hw_mgt, u32 descreq_num)
+{
+	u32 split_ring_prefect_num = (descreq_num >> 16) & 0xffff;
+	u32 packet_ring_prefect_num = descreq_num & 0xffff;
+	struct nbl_dvn_descreq_num_cfg num_cfg = { 0 };
+
+	packet_ring_prefect_num =
+		packet_ring_prefect_num > 32 ? 32 : packet_ring_prefect_num;
+	packet_ring_prefect_num =
+		packet_ring_prefect_num < 8 ? 8 : packet_ring_prefect_num;
+	num_cfg.packed_l1_num = (packet_ring_prefect_num - 8) / 4;
+
+	split_ring_prefect_num =
+		split_ring_prefect_num > 16 ? 16 : split_ring_prefect_num;
+	split_ring_prefect_num =
+		split_ring_prefect_num < 8 ? 8 : split_ring_prefect_num;
+	num_cfg.avring_cfg_num = split_ring_prefect_num > 8 ? 1 : 0;
+
+	nbl_hw_wr_regs(hw_mgt, NBL_DVN_DESCREQ_NUM_CFG, (u8 *)&num_cfg,
+		       sizeof(num_cfg));
+}
+
+static int nbl_dvn_init(struct nbl_hw_mgt *hw_mgt, u8 speed)
+{
+	struct nbl_dvn_desc_wr_merge_timeout timeout = { 0 };
+	struct nbl_dvn_dif_req_rd_ro_flag ro_flag = { 0 };
+
+	timeout.cfg_cycle = DEFAULT_DVN_DESC_WR_MERGE_TIMEOUT_MAX;
+	nbl_hw_wr_regs(hw_mgt, NBL_DVN_DESC_WR_MERGE_TIMEOUT, (u8 *)&timeout,
+		       sizeof(timeout));
+
+	ro_flag.rd_desc_ro_en = 1;
+	ro_flag.rd_data_ro_en = 1;
+	ro_flag.rd_avring_ro_en = 1;
+	nbl_hw_wr_regs(hw_mgt, NBL_DVN_DIF_REQ_RD_RO_FLAG, (u8 *)&ro_flag,
+		       sizeof(ro_flag));
+
+	if (speed == NBL_FW_PORT_SPEED_100G)
+		nbl_dvn_descreq_num_cfg(hw_mgt,
+					DEFAULT_DVN_100G_DESCREQ_NUMCFG);
+	else
+		nbl_dvn_descreq_num_cfg(hw_mgt, DEFAULT_DVN_DESCREQ_NUMCFG);
+
+	return 0;
+}
+
+static int nbl_uvn_init(struct nbl_hw_mgt *hw_mgt)
+{
+	struct uvn_desc_prefetch_init prefetch_init = { 0 };
+	struct uvn_desc_wr_timeout desc_wr_timeout = { 0 };
+	struct uvn_dif_req_ro_flag flag = { 0 };
+	struct uvn_queue_err_mask mask = { 0 };
+	u16 wr_timeout = 0x12c;
+	u32 timeout = 119760; /* 200us 200000/1.67 */
+	u32 quirks;
+
+	nbl_hw_wr32(hw_mgt, NBL_UVN_DESC_RD_WAIT, timeout);
+
+	desc_wr_timeout.num = wr_timeout;
+	nbl_hw_wr_regs(hw_mgt, NBL_UVN_DESC_WR_TIMEOUT, (u8 *)&desc_wr_timeout,
+		       sizeof(desc_wr_timeout));
+
+	flag.avail_rd = 1;
+	flag.desc_rd = 1;
+	flag.pkt_wr = 1;
+	flag.desc_wr = 0;
+	nbl_hw_wr_regs(hw_mgt, NBL_UVN_DIF_REQ_RO_FLAG, (u8 *)&flag,
+		       sizeof(flag));
+
+	nbl_hw_rd_regs(hw_mgt, NBL_UVN_QUEUE_ERR_MASK, (u8 *)&mask,
+		       sizeof(mask));
+	mask.dif_err = 1;
+	nbl_hw_wr_regs(hw_mgt, NBL_UVN_QUEUE_ERR_MASK, (u8 *)&mask,
+		       sizeof(mask));
+
+	prefetch_init.num = NBL_UVN_DESC_PREFETCH_NUM;
+	prefetch_init.sel = 0;
+	quirks = nbl_hw_get_quirks(hw_mgt);
+	if (!(quirks & BIT(NBL_QUIRKS_UVN_PREFETCH_ALIGN)))
+		prefetch_init.sel = 1;
+	nbl_hw_wr_regs(hw_mgt, NBL_UVN_DESC_PREFETCH_INIT, (u8 *)&prefetch_init,
+		       sizeof(prefetch_init));
+
+	return 0;
+}
+
+static int nbl_uqm_init(struct nbl_hw_mgt *hw_mgt)
+{
+	struct nbl_uqm_que_type que_type = { 0 };
+	u32 cnt = 0;
+	int i;
+
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_FWD_DROP_CNT, (u8 *)&cnt, sizeof(cnt));
+
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_DROP_PKT_CNT, (u8 *)&cnt, sizeof(cnt));
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_DROP_PKT_SLICE_CNT, (u8 *)&cnt,
+		       sizeof(cnt));
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_DROP_PKT_LEN_ADD_CNT, (u8 *)&cnt,
+		       sizeof(cnt));
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_DROP_HEAD_PNTR_ADD_CNT, (u8 *)&cnt,
+		       sizeof(cnt));
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_DROP_WEIGHT_ADD_CNT, (u8 *)&cnt,
+		       sizeof(cnt));
+
+	for (i = 0; i < NBL_UQM_PORT_DROP_DEPTH; i++) {
+		nbl_hw_wr_regs(hw_mgt,
+			       NBL_UQM_PORT_DROP_PKT_CNT + (sizeof(cnt) * i),
+			       (u8 *)&cnt, sizeof(cnt));
+		nbl_hw_wr_regs(hw_mgt,
+			       NBL_UQM_PORT_DROP_PKT_SLICE_CNT +
+				       (sizeof(cnt) * i),
+			       (u8 *)&cnt, sizeof(cnt));
+		nbl_hw_wr_regs(hw_mgt,
+			       NBL_UQM_PORT_DROP_PKT_LEN_ADD_CNT +
+				       (sizeof(cnt) * i),
+			       (u8 *)&cnt, sizeof(cnt));
+		nbl_hw_wr_regs(hw_mgt,
+			       NBL_UQM_PORT_DROP_HEAD_PNTR_ADD_CNT +
+				       (sizeof(cnt) * i),
+			       (u8 *)&cnt, sizeof(cnt));
+		nbl_hw_wr_regs(hw_mgt,
+			       NBL_UQM_PORT_DROP_WEIGHT_ADD_CNT +
+				       (sizeof(cnt) * i),
+			       (u8 *)&cnt, sizeof(cnt));
+	}
+
+	for (i = 0; i < NBL_UQM_DPORT_DROP_DEPTH; i++)
+		nbl_hw_wr_regs(hw_mgt,
+			       NBL_UQM_DPORT_DROP_CNT + (sizeof(cnt) * i),
+			       (u8 *)&cnt, sizeof(cnt));
+
+	que_type.bp_drop = 0;
+	nbl_hw_wr_regs(hw_mgt, NBL_UQM_QUE_TYPE, (u8 *)&que_type,
+		       sizeof(que_type));
+
+	return 0;
+}
+
+static int nbl_dp_init(struct nbl_hw_mgt *hw_mgt, u8 speed, u8 eth_num)
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
+
+	return 0;
+}
+
+static int nbl_host_padpt_init(struct nbl_hw_mgt *hw_mgt)
+{
+	/* padpt flow  control register */
+	nbl_hw_wr32(hw_mgt, NBL_HOST_PADPT_HOST_CFG_FC_CPLH_UP, 0x10400);
+	nbl_hw_wr32(hw_mgt, NBL_HOST_PADPT_HOST_CFG_FC_PD_DN, 0x10080);
+	nbl_hw_wr32(hw_mgt, NBL_HOST_PADPT_HOST_CFG_FC_PH_DN, 0x10010);
+	nbl_hw_wr32(hw_mgt, NBL_HOST_PADPT_HOST_CFG_FC_NPH_DN, 0x10010);
+
+	return 0;
+}
+
+static int nbl_intf_init(struct nbl_hw_mgt *hw_mgt)
+{
+	nbl_host_padpt_init(hw_mgt);
+	return 0;
+}
+
+static void nbl_hw_set_driver_status(struct nbl_hw_mgt *hw_mgt, bool active)
+{
+	u32 status = 0;
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
+	hw_mgt->version = nbl_hw_rd32(hw_mgt, NBL_HW_DUMMY_REG);
+
+	return 0;
+}
 
 static void nbl_hw_enable_mailbox_irq(struct nbl_hw_mgt *hw_mgt, u16 func_id,
 				      bool enable_msix, u16 global_vec_id)
@@ -205,6 +609,9 @@ static u32 nbl_hw_get_fw_eth_map(struct nbl_hw_mgt *hw_mgt)
 }
 
 static struct nbl_hw_ops hw_ops = {
+	.init_chip_module = nbl_hw_init_chip_module,
+	.deinit_chip_module = nbl_hw_deinit_chip_module,
+
 	.configure_msix_map = nbl_hw_configure_msix_map,
 	.configure_msix_info = nbl_hw_configure_msix_info,
 
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
index af58a3d55854..b7c0dd4c20c5 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
@@ -71,6 +71,10 @@ static int nbl_res_setup_ops(struct device *dev,
 
 	if (!is_ops_inited) {
 		ret = nbl_intr_setup_ops(&res_ops);
+		if (ret)
+			goto setup_fail;
+
+		ret = nbl_vsi_setup_ops(&res_ops);
 		if (ret)
 			goto setup_fail;
 		is_ops_inited = true;
@@ -262,7 +266,6 @@ int nbl_res_init_leonis(struct nbl_adapter *adap, struct nbl_init_param *param)
 	struct nbl_resource_mgt_leonis **mgt =
 		(struct nbl_resource_mgt_leonis **)&NBL_ADAP_TO_RES_MGT(adap);
 	struct device *dev = &adap->pdev->dev;
-
 	int ret = 0;
 
 	ret = nbl_res_setup_res_mgt(common, mgt);
@@ -279,7 +282,6 @@ int nbl_res_init_leonis(struct nbl_adapter *adap, struct nbl_init_param *param)
 	ret = nbl_res_setup_ops(dev, res_ops_tbl, *mgt);
 	if (ret)
 		goto setup_ops_fail;
-
 	return 0;
 
 setup_ops_fail:
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
index 45876ccc72a6..d4a1096a25f6 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
@@ -122,6 +122,7 @@ int nbl_res_func_id_to_bdf(struct nbl_resource_mgt *res_mgt, u16 func_id,
 			   u8 *bus, u8 *dev, u8 *function);
 int nbl_intr_mgt_start(struct nbl_resource_mgt *res_mgt);
 int nbl_intr_setup_ops(struct nbl_resource_ops *resource_ops);
+int nbl_vsi_setup_ops(struct nbl_resource_ops *resource_ops);
 void nbl_res_pf_dev_vsi_type_to_hw_vsi_type(u16 src_type,
 					    enum nbl_vsi_serv_type *dst_type);
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.c
new file mode 100644
index 000000000000..df879e6976d7
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#include "nbl_vsi.h"
+
+static void nbl_res_vsi_deinit_chip_module(struct nbl_resource_mgt *res_mgt)
+{
+	struct nbl_hw_ops *hw_ops;
+
+	hw_ops = res_mgt->hw_ops_tbl->ops;
+
+	hw_ops->deinit_chip_module(res_mgt->hw_ops_tbl->priv);
+}
+
+static int nbl_res_vsi_init_chip_module(struct nbl_resource_mgt *res_mgt)
+{
+	u8 eth_speed = res_mgt->resource_info->board_info.eth_speed;
+	u8 eth_num = res_mgt->resource_info->board_info.eth_num;
+	struct nbl_hw_ops *hw_ops = res_mgt->hw_ops_tbl->ops;
+	struct nbl_hw_mgt *p = res_mgt->hw_ops_tbl->priv;
+	int ret = 0;
+
+	ret = hw_ops->init_chip_module(p, eth_speed, eth_num);
+
+	return ret;
+}
+
+/* NBL_VSI_SET_OPS(ops_name, func)
+ *
+ * Use X Macros to reduce setup and remove codes.
+ */
+#define NBL_VSI_OPS_TBL							\
+do {									\
+	NBL_VSI_SET_OPS(init_chip_module,				\
+			nbl_res_vsi_init_chip_module);			\
+	NBL_VSI_SET_OPS(deinit_chip_module,				\
+			nbl_res_vsi_deinit_chip_module);		\
+} while (0)
+
+int nbl_vsi_setup_ops(struct nbl_resource_ops *res_ops)
+{
+#define NBL_VSI_SET_OPS(name, func)		\
+	do {					\
+		res_ops->NBL_NAME(name) = func;	\
+		;				\
+	} while (0)
+	NBL_VSI_OPS_TBL;
+#undef  NBL_VSI_SET_OPS
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.h
new file mode 100644
index 000000000000..94831e00b89a
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0*/
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+
+#ifndef _NBL_VSI_H_
+#define _NBL_VSI_H_
+
+#include "nbl_resource.h"
+
+#endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
index 80b152cad1b0..633bbc574aee 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_def_hw.h
@@ -10,6 +10,10 @@
 #include "nbl_include.h"
 struct nbl_hw_mgt;
 struct nbl_hw_ops {
+	int (*init_chip_module)(struct nbl_hw_mgt *hw_mgt, u8 eth_speed,
+				u8 eth_num);
+	void (*deinit_chip_module)(struct nbl_hw_mgt *hw_mgt);
+
 	void (*configure_msix_map)(struct nbl_hw_mgt *hw_mgt, u16 func_id,
 				   bool valid, dma_addr_t dma_addr, u8 bus,
 				   u8 devid, u8 function);
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
index 21fd0c09f654..d4c7faaee844 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_include/nbl_include.h
@@ -47,4 +47,35 @@ struct nbl_init_param {
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


