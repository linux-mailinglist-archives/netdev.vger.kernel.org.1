Return-Path: <netdev+bounces-252580-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMKEMYrNcmlgpgAAu9opvQ
	(envelope-from <netdev+bounces-252580-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:23:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C0D6F05D
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 02:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17EC63045A91
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 01:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6684F239E6C;
	Fri, 23 Jan 2026 01:19:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-2.us.a.mail.aliyun.com (out198-2.us.a.mail.aliyun.com [47.90.198.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252B336E477;
	Fri, 23 Jan 2026 01:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769131160; cv=none; b=jzpX72Xdmu2fI/Y6MKZUrROHdaSIfR0xWFHLHCdfS835PTOJ/cvlql/An8kGg1/bBJziBV1JrD+AxoZLelVJ0R+OvrpOUMsJlJFTxSCa4WljVLqQ+APVym59U6IV+2Jqdpnx4FUusRepD0ltasCN0j0EDrrVLsDB3j65aOwi4lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769131160; c=relaxed/simple;
	bh=c39K83Pbf8TCIRiVqVd8S/H2KVoIG9ObtpxX7r8d1/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQM3nXOGEeUQmf9g2hMG11aAvMNPx7DQUv534IJDixq95evCpOyx+d6eepps5QSa3NyAJtll2W7CwG8iXFLAPn4NFKDHBjqsOYvEgacunp+zLZMFGQu1l6hPA3lRJCc2cYFvPS3JjI3izZTxEMH4apCChHdHRMY5vxSPWYlUwwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com; spf=pass smtp.mailfrom=nebula-matrix.com; arc=none smtp.client-ip=47.90.198.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nebula-matrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebula-matrix.com
Received: from localhost.localdomain(mailfrom:illusion.wang@nebula-matrix.com fp:SMTPD_---.gDSYW4w_1769131127 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 23 Jan 2026 09:18:48 +0800
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
	hawk@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	sdf@fomichev.me,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	edumazet@google.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 net-next 08/15] net/nebula-matrix: add vsi resource implementation
Date: Fri, 23 Jan 2026 09:17:45 +0800
Message-ID: <20260123011804.31263-9-illusion.wang@nebula-matrix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260123011804.31263-1-illusion.wang@nebula-matrix.com>
References: <20260123011804.31263-1-illusion.wang@nebula-matrix.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252580-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[nebula-matrix.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,lwn.net,kernel.org,vger.kernel.org,redhat.com,linux.dev,fomichev.me,iogearbox.net,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	FROM_NEQ_ENVFROM(0.00)[illusion.wang@nebula-matrix.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[22];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nebula-matrix.com:mid,nebula-matrix.com:email,illusion.wang:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 27C0D6F05D
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
 .../nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c  | 424 ++++++++++++++++++
 .../nbl_hw_leonis/nbl_resource_leonis.c       |  10 +
 .../nebula-matrix/nbl/nbl_hw/nbl_resource.h   |   4 +
 .../nebula-matrix/nbl/nbl_hw/nbl_vsi.c        | 120 +++++
 .../nebula-matrix/nbl/nbl_hw/nbl_vsi.h        |  12 +
 6 files changed, 571 insertions(+)
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.c
 create mode 100644 drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.h

diff --git a/drivers/net/ethernet/nebula-matrix/nbl/Makefile b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
index 1e873a4cd31e..f2a68245944a 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/Makefile
+++ b/drivers/net/ethernet/nebula-matrix/nbl/Makefile
@@ -13,6 +13,7 @@ nbl_core-objs +=       nbl_common/nbl_common.o \
 				nbl_hw/nbl_resource.o \
 				nbl_hw/nbl_interrupt.o \
 				nbl_hw/nbl_queue.o \
+				nbl_hw/nbl_vsi.o \
 				nbl_core/nbl_dispatch.o \
 				nbl_core/nbl_service.o \
 				nbl_core/nbl_dev.o \
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
index 9b3ba97428a9..43bb9d4af67a 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
@@ -25,6 +25,406 @@ static u32 nbl_hw_get_quirks(void *priv)
 	return quirks;
 }
 
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
+	struct nbl_shaping_dport dport = { 0 };
+	struct nbl_shaping_dvn_dport dvn_dport = { 0 };
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
+	struct dsch_psha_en psha_en = { 0 };
+	struct nbl_shaping_net net_shaping = { 0 };
+	int num = NBL_SHAPING_FLUSH_INTERVAL;
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
+		if ((i % num) == 0)
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
+	struct ustore_pkt_len pkt_len;
+	struct nbl_ustore_port_drop_th drop_th;
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
+	struct dstore_d_dport_fc_th fc_th;
+	struct dstore_port_drop_th drop_th;
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
+static void nbl_dvn_descreq_num_cfg(void *priv, u32 descreq_num)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+	struct nbl_dvn_descreq_num_cfg descreq_num_cfg = { 0 };
+	u32 packet_ring_prefect_num = descreq_num & 0xffff;
+	u32 split_ring_prefect_num = (descreq_num >> 16) & 0xffff;
+
+	packet_ring_prefect_num =
+		packet_ring_prefect_num > 32 ? 32 : packet_ring_prefect_num;
+	packet_ring_prefect_num =
+		packet_ring_prefect_num < 8 ? 8 : packet_ring_prefect_num;
+	descreq_num_cfg.packed_l1_num = (packet_ring_prefect_num - 8) / 4;
+
+	split_ring_prefect_num =
+		split_ring_prefect_num > 16 ? 16 : split_ring_prefect_num;
+	split_ring_prefect_num =
+		split_ring_prefect_num < 8 ? 8 : split_ring_prefect_num;
+	descreq_num_cfg.avring_cfg_num = split_ring_prefect_num > 8 ? 1 : 0;
+
+	nbl_hw_wr_regs(hw_mgt, NBL_DVN_DESCREQ_NUM_CFG, (u8 *)&descreq_num_cfg,
+		       sizeof(descreq_num_cfg));
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
+	struct uvn_queue_err_mask mask = { 0 };
+	struct uvn_dif_req_ro_flag flag = { 0 };
+	u32 timeout = 119760; /* 200us 200000/1.67 */
+	u16 wr_timeout = 0x12c;
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
+
+	quirks = nbl_hw_get_quirks(hw_mgt);
+
+	if (!(quirks & BIT(NBL_QUIRKS_UVN_PREFETCH_ALIGN)))
+		prefetch_init.sel = 1;
+
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
+static void nbl_hw_deinit_chip_module(void *priv)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+
+	nbl_hw_set_driver_status(hw_mgt, false);
+}
+
+static int nbl_hw_init_chip_module(void *priv, u8 eth_speed, u8 eth_num)
+{
+	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
+
+	nbl_debug(NBL_HW_MGT_TO_COMMON(hw_mgt), "hw_chip_init");
+
+	nbl_dp_init(hw_mgt, eth_speed, eth_num);
+	nbl_intf_init(hw_mgt);
+
+	nbl_write_all_regs(hw_mgt);
+	nbl_hw_set_driver_status(hw_mgt, true);
+	hw_mgt->version = nbl_hw_rd32(hw_mgt, NBL_HW_DUMMY_REG);
+
+	return 0;
+}
+
 static int nbl_hw_init_qid_map_table(void *priv)
 {
 	struct nbl_hw_mgt *hw_mgt = (struct nbl_hw_mgt *)priv;
@@ -1181,6 +1581,25 @@ static void nbl_hw_cfg_mailbox_qinfo(void *priv, u16 func_id, u16 bus,
 		       (u8 *)&mb_qinfo_map, sizeof(mb_qinfo_map));
 }
 
+static void nbl_hw_set_promisc_mode(void *priv, u16 vsi_id, u16 eth_id,
+				    u16 mode)
+{
+	struct nbl_ipro_upsport_tbl upsport;
+
+	nbl_hw_rd_regs(priv, NBL_IPRO_UP_SPORT_TABLE(eth_id), (u8 *)&upsport,
+		       sizeof(upsport));
+	if (mode) {
+		upsport.set_dport.dport.up.upcall_flag = AUX_FWD_TYPE_NML_FWD;
+		upsport.set_dport.dport.up.port_type = SET_DPORT_TYPE_VSI_HOST;
+		upsport.set_dport.dport.up.port_id = vsi_id;
+		upsport.set_dport.dport.up.next_stg_sel = NEXT_STG_SEL_NONE;
+	} else {
+		upsport.set_dport.data = 0xFFF;
+	}
+	nbl_hw_wr_regs(priv, NBL_IPRO_UP_SPORT_TABLE(eth_id), (u8 *)&upsport,
+		       sizeof(upsport));
+}
+
 static void nbl_hw_get_board_info(void *priv,
 				  struct nbl_board_port_info *board_info)
 {
@@ -1215,6 +1634,8 @@ static u32 nbl_hw_get_fw_eth_map(void *priv)
 }
 
 static struct nbl_hw_ops hw_ops = {
+	.init_chip_module = nbl_hw_init_chip_module,
+	.deinit_chip_module = nbl_hw_deinit_chip_module,
 	.init_qid_map_table = nbl_hw_init_qid_map_table,
 	.set_qid_map_table = nbl_hw_set_qid_map_table,
 	.set_qid_map_ready = nbl_hw_set_qid_map_ready,
@@ -1238,6 +1659,7 @@ static struct nbl_hw_ops hw_ops = {
 	.cfg_epro_rss_ret = nbl_hw_cfg_epro_rss_ret,
 	.set_epro_rss_pt = nbl_hw_set_epro_rss_pt,
 	.clear_epro_rss_pt = nbl_hw_clear_epro_rss_pt,
+	.set_promisc_mode = nbl_hw_set_promisc_mode,
 	.disable_dvn = nbl_hw_disable_dvn,
 	.disable_uvn = nbl_hw_disable_uvn,
 	.lso_dsch_drain = nbl_hw_lso_dsch_drain,
@@ -1264,10 +1686,12 @@ static struct nbl_hw_ops hw_ops = {
 	.enable_mailbox_irq = nbl_hw_enable_mailbox_irq,
 	.enable_msix_irq = nbl_hw_enable_msix_irq,
 	.get_msix_irq_enable_info = nbl_hw_get_msix_irq_enable_info,
+
 	.get_fw_eth_num = nbl_hw_get_fw_eth_num,
 	.get_fw_eth_map = nbl_hw_get_fw_eth_map,
 	.get_board_info = nbl_hw_get_board_info,
 	.get_quirks = nbl_hw_get_quirks,
+
 };
 
 /* Structure starts here, adding an op should not modify anything below */
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
index 032131d1b9fa..83f8bb280b93 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_resource_leonis.c
@@ -237,6 +237,10 @@ static int nbl_res_setup_ops(struct device *dev,
 		if (ret)
 			goto setup_fail;
 		ret = nbl_intr_setup_ops(&res_ops);
+		if (ret)
+			goto setup_fail;
+
+		ret = nbl_vsi_setup_ops(&res_ops);
 		if (ret)
 			goto setup_fail;
 		is_ops_inited = true;
@@ -440,6 +444,8 @@ static void nbl_res_stop(struct nbl_resource_mgt_leonis *res_mgt_leonis)
 	nbl_queue_mgt_stop(res_mgt);
 	nbl_intr_mgt_stop(res_mgt);
 
+	nbl_vsi_mgt_stop(res_mgt);
+
 	nbl_res_ctrl_dev_remove_vsi_info(res_mgt);
 	nbl_res_ctrl_dev_remove_eth_info(res_mgt);
 	nbl_res_ctrl_dev_sriov_info_remove(res_mgt);
@@ -483,6 +489,10 @@ static int nbl_res_start(struct nbl_resource_mgt_leonis *res_mgt_leonis,
 		if (ret)
 			goto start_fail;
 
+		ret = nbl_vsi_mgt_start(res_mgt);
+		if (ret)
+			goto start_fail;
+
 		ret = nbl_intr_mgt_start(res_mgt);
 		if (ret)
 			goto start_fail;
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
index 2195e4084040..27a9900ff009 100644
--- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_resource.h
@@ -426,6 +426,10 @@ int nbl_intr_setup_ops(struct nbl_resource_ops *resource_ops);
 int nbl_queue_mgt_start(struct nbl_resource_mgt *res_mgt);
 void nbl_queue_mgt_stop(struct nbl_resource_mgt *res_mgt);
 
+int nbl_vsi_mgt_start(struct nbl_resource_mgt *res_mgt);
+void nbl_vsi_mgt_stop(struct nbl_resource_mgt *res_mgt);
+int nbl_vsi_setup_ops(struct nbl_resource_ops *resource_ops);
+
 void nbl_res_pf_dev_vsi_type_to_hw_vsi_type(u16 src_type,
 					    enum nbl_vsi_serv_type *dst_type);
 #endif
diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.c
new file mode 100644
index 000000000000..068058a90363
--- /dev/null
+++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_vsi.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 Nebula Matrix Limited.
+ * Author:
+ */
+#include <linux/etherdevice.h>
+
+#include "nbl_vsi.h"
+
+static int nbl_res_set_promisc_mode(void *priv, u16 vsi_id, u16 mode)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	u16 pf_id = nbl_res_vsi_id_to_pf_id(res_mgt, vsi_id);
+	u16 eth_id = nbl_res_vsi_id_to_eth_id(res_mgt, vsi_id);
+
+	if (pf_id >= NBL_RES_MGT_TO_PF_NUM(res_mgt))
+		return -EINVAL;
+
+	hw_ops->set_promisc_mode(NBL_RES_MGT_TO_HW_PRIV(res_mgt), vsi_id,
+				 eth_id, mode);
+
+	return 0;
+}
+
+static void nbl_res_vsi_deinit_chip_module(void *priv)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	struct nbl_hw_ops *hw_ops;
+
+	hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+
+	hw_ops->deinit_chip_module(NBL_RES_MGT_TO_HW_PRIV(res_mgt));
+}
+
+static int nbl_res_vsi_init_chip_module(void *priv)
+{
+	struct nbl_resource_mgt *res_mgt = (struct nbl_resource_mgt *)priv;
+	void *p = NBL_RES_MGT_TO_HW_PRIV(res_mgt);
+	struct nbl_hw_ops *hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
+	u8 eth_speed = res_mgt->resource_info->board_info.eth_speed;
+	u8 eth_num = res_mgt->resource_info->board_info.eth_num;
+
+	int ret = 0;
+
+	if (!res_mgt)
+		return -EINVAL;
+
+	hw_ops = NBL_RES_MGT_TO_HW_OPS(res_mgt);
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
+	NBL_VSI_SET_OPS(set_promisc_mode, nbl_res_set_promisc_mode);	\
+} while (0)
+
+/* Structure starts here, adding an op should not modify anything below */
+static int nbl_vsi_setup_mgt(struct device *dev, struct nbl_vsi_mgt **vsi_mgt)
+{
+	*vsi_mgt = devm_kzalloc(dev, sizeof(struct nbl_vsi_mgt), GFP_KERNEL);
+	if (!*vsi_mgt)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void nbl_vsi_remove_mgt(struct device *dev, struct nbl_vsi_mgt **vsi_mgt)
+{
+	devm_kfree(dev, *vsi_mgt);
+	*vsi_mgt = NULL;
+}
+
+int nbl_vsi_mgt_start(struct nbl_resource_mgt *res_mgt)
+{
+	struct device *dev;
+	struct nbl_vsi_mgt **vsi_mgt;
+
+	dev = NBL_RES_MGT_TO_DEV(res_mgt);
+	vsi_mgt = &NBL_RES_MGT_TO_VSI_MGT(res_mgt);
+
+	return nbl_vsi_setup_mgt(dev, vsi_mgt);
+}
+
+void nbl_vsi_mgt_stop(struct nbl_resource_mgt *res_mgt)
+{
+	struct device *dev;
+	struct nbl_vsi_mgt **vsi_mgt;
+
+	dev = NBL_RES_MGT_TO_DEV(res_mgt);
+	vsi_mgt = &NBL_RES_MGT_TO_VSI_MGT(res_mgt);
+
+	if (!(*vsi_mgt))
+		return;
+
+	nbl_vsi_remove_mgt(dev, vsi_mgt);
+}
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
-- 
2.47.3


