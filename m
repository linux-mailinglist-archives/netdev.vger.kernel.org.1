Return-Path: <netdev+bounces-115769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B24FE947C12
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 15:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C072814DD
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 13:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B06445948;
	Mon,  5 Aug 2024 13:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MUc2CjQD"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B3638DC3;
	Mon,  5 Aug 2024 13:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722865375; cv=none; b=kEO0UgK38dO7VLPpsHbYhdJsqJ/LIOXiSYNLJihxucB2Pk/LguPNz+0OS7Al87iUGwXaRfOM/9iyxXhRMF+e2Zi9DdDAkhZ7z7571WoqKYcrSX2y7BxcbR4jp5iB3a9los50+1Olr9XzdpgzFSJpeyM92SsbTeSfQJynblSqhQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722865375; c=relaxed/simple;
	bh=ZRwAk+/qwVeWa/LUL+N22KonKf706hHRSy5/Ph42a8o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WpGVAdMJtQR3+t4DsGM3qwYwqUBASp1O+sHv5W9nosTeLBSpseTNhG3VHwd3o6fyQLQnAqQvPW+Dzy8b/J78hZ0jnF+b+7qzmw/oYXFPnJcyV+0MiPgDXE5+z0nSnl0Pi9l/tKNvx23JIjqifnOJol3TtLMxUobLFkzfvPrv/6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=MUc2CjQD; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47590s9s025409;
	Mon, 5 Aug 2024 06:42:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=zr2OwnLXT6COncVrLd1LMAUcB
	sO6xdlA9CN/0vN5VEk=; b=MUc2CjQD908iFCoOh8/tERfdvtSiav6GpnmXAjNGW
	zydPK1xOS6Mh5ltCYu3gt/OGaEWPPN6vEK+Yr9YEa2uZ4VoCsRaK8JjSuLkkKweu
	bwLWQe02d5rCbg6uCNrGHObuVtKzpF3uUjbZqPRX6gV62/B6kx8ajVuW+Oq9lf+j
	OqkPymVRkYj8knD1lG5KfxXCKpc+r5whXnJ6qrjKq1B+EeZS9vJXcePGb6tUz9D+
	zAZ7CZHqZK+/VuNLHzi+NLxQIpCoszlZBPDyUMc1yJ6PLJSNZQaGYyzzUKKzKdNj
	b862z8c0DkJAhqyEoz7JP3xEthTL9nAOts4R95UDvsEVw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 40tuqugsmv-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 06:42:32 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 5 Aug 2024 06:42:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 5 Aug 2024 06:42:32 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 8E87A5B6EAA;
	Mon,  5 Aug 2024 06:18:35 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v10 05/11] octeontx2-af: Add packet path between representor and VF
Date: Mon, 5 Aug 2024 18:48:09 +0530
Message-ID: <20240805131815.7588-6-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240805131815.7588-1-gakula@marvell.com>
References: <20240805131815.7588-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: EISpNQHNjoF2AQWsbrTWn6EZeFJKjnhP
X-Proofpoint-GUID: EISpNQHNjoF2AQWsbrTWn6EZeFJKjnhP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-05_02,2024-08-02_01,2024-05-17_01

Current HW, does not support built-in switch which will forward pkts
between representee and representor. When representor is put under
a bridge and packets needs to be sent to representee, then packets from
representor are sent on a HW internal loopback channel, which again
will be punted to ingress pkt parser. Now the rules that this patch
installs are the MCAM filters/rules which will match against these
packets and forward them to representee.
The rules that this patch installs are for basic
representor <=> representee path similar to Tun/TAP between VM and
Host.

Signed-off-by: Geetha sowjanya <gakula@marvell.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 .../net/ethernet/marvell/octeontx2/af/mbox.h  |   7 +
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |   7 +-
 .../marvell/octeontx2/af/rvu_devlink.c        |   6 +
 .../ethernet/marvell/octeontx2/af/rvu_nix.c   |   7 +-
 .../ethernet/marvell/octeontx2/af/rvu_rep.c   | 247 ++++++++++++++++++
 .../marvell/octeontx2/af/rvu_switch.c         |  18 +-
 .../net/ethernet/marvell/octeontx2/nic/rep.c  |  18 ++
 7 files changed, 303 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
index d28bb302da8b..1e16c51ce483 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mbox.h
@@ -146,6 +146,7 @@ M(LMTST_TBL_SETUP,	0x00a, lmtst_tbl_setup, lmtst_tbl_setup_req,    \
 M(SET_VF_PERM,		0x00b, set_vf_perm, set_vf_perm, msg_rsp)	\
 M(PTP_GET_CAP,		0x00c, ptp_get_cap, msg_req, ptp_get_cap_rsp)	\
 M(GET_REP_CNT,		0x00d, get_rep_cnt, msg_req, get_rep_cnt_rsp)	\
+M(ESW_CFG,		0x00e, esw_cfg, esw_cfg_req, msg_rsp)	\
 /* CGX mbox IDs (range 0x200 - 0x3FF) */				\
 M(CGX_START_RXTX,	0x200, cgx_start_rxtx, msg_req, msg_rsp)	\
 M(CGX_STOP_RXTX,	0x201, cgx_stop_rxtx, msg_req, msg_rsp)		\
@@ -1534,6 +1535,12 @@ struct get_rep_cnt_rsp {
 	u64 rsvd;
 };
 
+struct esw_cfg_req {
+	struct mbox_msghdr hdr;
+	u8 ena;
+	u64 rsvd;
+};
+
 struct flow_msg {
 	unsigned char dmac[6];
 	unsigned char smac[6];
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 562c6f7e73da..776dd92910f0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -597,6 +597,7 @@ struct rvu {
 	u16			rep_pcifunc;
 	int			rep_cnt;
 	u16			*rep2pfvf_map;
+	u8			rep_mode;
 };
 
 static inline void rvu_write64(struct rvu *rvu, u64 block, u64 offset, u64 val)
@@ -1027,7 +1028,7 @@ int rvu_ndc_fix_locked_cacheline(struct rvu *rvu, int blkaddr);
 /* RVU Switch */
 void rvu_switch_enable(struct rvu *rvu);
 void rvu_switch_disable(struct rvu *rvu);
-void rvu_switch_update_rules(struct rvu *rvu, u16 pcifunc);
+void rvu_switch_update_rules(struct rvu *rvu, u16 pcifunc, bool ena);
 void rvu_switch_enable_lbk_link(struct rvu *rvu, u16 pcifunc, bool ena);
 
 int rvu_npc_set_parse_mode(struct rvu *rvu, u16 pcifunc, u64 mode, u8 dir,
@@ -1041,4 +1042,8 @@ int rvu_mcs_flr_handler(struct rvu *rvu, u16 pcifunc);
 void rvu_mcs_ptp_cfg(struct rvu *rvu, u8 rpm_id, u8 lmac_id, bool ena);
 void rvu_mcs_exit(struct rvu *rvu);
 
+/* Representor APIs */
+int rvu_rep_pf_init(struct rvu *rvu);
+int rvu_rep_install_mcam_rules(struct rvu *rvu);
+void rvu_rep_update_rules(struct rvu *rvu, u16 pcifunc, bool ena);
 #endif /* RVU_H */
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
index 7498ab429963..4d29c509ef6b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_devlink.c
@@ -1468,6 +1468,9 @@ static int rvu_devlink_eswitch_mode_get(struct devlink *devlink, u16 *mode)
 	struct rvu *rvu = rvu_dl->rvu;
 	struct rvu_switch *rswitch;
 
+	if (rvu->rep_mode)
+		return -EOPNOTSUPP;
+
 	rswitch = &rvu->rswitch;
 	*mode = rswitch->mode;
 
@@ -1481,6 +1484,9 @@ static int rvu_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 	struct rvu *rvu = rvu_dl->rvu;
 	struct rvu_switch *rswitch;
 
+	if (rvu->rep_mode)
+		return -EOPNOTSUPP;
+
 	rswitch = &rvu->rswitch;
 	switch (mode) {
 	case DEVLINK_ESWITCH_MODE_LEGACY:
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
index 68878b9b5af0..cdec650f0eb0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_nix.c
@@ -2741,7 +2741,7 @@ void rvu_nix_tx_tl2_cfg(struct rvu *rvu, int blkaddr, u16 pcifunc,
 	int schq;
 	u64 cfg;
 
-	if (!is_pf_cgxmapped(rvu, pf))
+	if (!is_pf_cgxmapped(rvu, pf) && !is_rep_dev(rvu, pcifunc))
 		return;
 
 	cfg = enable ? (BIT_ULL(12) | RVU_SWITCH_LBK_CHAN) : 0;
@@ -4376,8 +4376,6 @@ int rvu_mbox_handler_nix_set_mac_addr(struct rvu *rvu,
 	if (test_bit(PF_SET_VF_TRUSTED, &pfvf->flags) && from_vf)
 		ether_addr_copy(pfvf->default_mac, req->mac_addr);
 
-	rvu_switch_update_rules(rvu, pcifunc);
-
 	return 0;
 }
 
@@ -5169,7 +5167,7 @@ int rvu_mbox_handler_nix_lf_start_rx(struct rvu *rvu, struct msg_req *req,
 	pfvf = rvu_get_pfvf(rvu, pcifunc);
 	set_bit(NIXLF_INITIALIZED, &pfvf->flags);
 
-	rvu_switch_update_rules(rvu, pcifunc);
+	rvu_switch_update_rules(rvu, pcifunc, true);
 
 	return rvu_cgx_start_stop_io(rvu, pcifunc, true);
 }
@@ -5197,6 +5195,7 @@ int rvu_mbox_handler_nix_lf_stop_rx(struct rvu *rvu, struct msg_req *req,
 	if (err)
 		return err;
 
+	rvu_switch_update_rules(rvu, pcifunc, false);
 	rvu_cgx_tx_enable(rvu, pcifunc, true);
 
 	return 0;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
index cf13c5f0a3c5..5f2e2cbd165a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
@@ -13,6 +13,253 @@
 #include "rvu.h"
 #include "rvu_reg.h"
 
+static u16 rvu_rep_get_vlan_id(struct rvu *rvu, u16 pcifunc)
+{
+	int id;
+
+	for (id = 0; id < rvu->rep_cnt; id++)
+		if (rvu->rep2pfvf_map[id] == pcifunc)
+			return id;
+	return 0;
+}
+
+static int rvu_rep_tx_vlan_cfg(struct rvu *rvu,  u16 pcifunc,
+			       u16 vlan_tci, int *vidx)
+{
+	struct nix_vtag_config_rsp rsp = {};
+	struct nix_vtag_config req = {};
+	u64 etype = ETH_P_8021Q;
+	int err;
+
+	/* Insert vlan tag */
+	req.hdr.pcifunc = pcifunc;
+	req.vtag_size = VTAGSIZE_T4;
+	req.cfg_type = 0; /* tx vlan cfg */
+	req.tx.cfg_vtag0 = true;
+	req.tx.vtag0 = FIELD_PREP(NIX_VLAN_ETYPE_MASK, etype) | vlan_tci;
+
+	err = rvu_mbox_handler_nix_vtag_cfg(rvu, &req, &rsp);
+	if (err) {
+		dev_err(rvu->dev, "Tx vlan config failed\n");
+		return err;
+	}
+	*vidx = rsp.vtag0_idx;
+	return 0;
+}
+
+static int rvu_rep_rx_vlan_cfg(struct rvu *rvu, u16 pcifunc)
+{
+	struct nix_vtag_config req = {};
+	struct nix_vtag_config_rsp rsp;
+
+	/* config strip, capture and size */
+	req.hdr.pcifunc = pcifunc;
+	req.vtag_size = VTAGSIZE_T4;
+	req.cfg_type = 1; /* rx vlan cfg */
+	req.rx.vtag_type = NIX_AF_LFX_RX_VTAG_TYPE0;
+	req.rx.strip_vtag = true;
+	req.rx.capture_vtag = false;
+
+	return rvu_mbox_handler_nix_vtag_cfg(rvu, &req, &rsp);
+}
+
+static int rvu_rep_install_rx_rule(struct rvu *rvu, u16 pcifunc,
+				   u16 entry, bool rte)
+{
+	struct npc_install_flow_req req = {};
+	struct npc_install_flow_rsp rsp = {};
+	struct rvu_pfvf *pfvf;
+	u16 vlan_tci, rep_id;
+
+	pfvf = rvu_get_pfvf(rvu, pcifunc);
+
+	/* To steer the traffic from Representee to Representor */
+	rep_id = rvu_rep_get_vlan_id(rvu, pcifunc);
+	if (rte) {
+		vlan_tci = rep_id | BIT_ULL(8);
+		req.vf = rvu->rep_pcifunc;
+		req.op = NIX_RX_ACTIONOP_UCAST;
+		req.index = rep_id;
+	} else {
+		vlan_tci = rep_id;
+		req.vf = pcifunc;
+		req.op = NIX_RX_ACTION_DEFAULT;
+	}
+
+	rvu_rep_rx_vlan_cfg(rvu, req.vf);
+	req.entry = entry;
+	req.hdr.pcifunc = 0; /* AF is requester */
+	req.features = BIT_ULL(NPC_OUTER_VID) | BIT_ULL(NPC_VLAN_ETYPE_CTAG);
+	req.vtag0_valid = true;
+	req.vtag0_type = NIX_AF_LFX_RX_VTAG_TYPE0;
+	req.packet.vlan_etype = cpu_to_be16(ETH_P_8021Q);
+	req.mask.vlan_etype = cpu_to_be16(ETH_P_8021Q);
+	req.packet.vlan_tci = cpu_to_be16(vlan_tci);
+	req.mask.vlan_tci = cpu_to_be16(0xffff);
+
+	req.channel = RVU_SWITCH_LBK_CHAN;
+	req.chan_mask = 0xffff;
+	req.intf = pfvf->nix_rx_intf;
+
+	return rvu_mbox_handler_npc_install_flow(rvu, &req, &rsp);
+}
+
+static int rvu_rep_install_tx_rule(struct rvu *rvu, u16 pcifunc, u16 entry,
+				   bool rte)
+{
+	struct npc_install_flow_req req = {};
+	struct npc_install_flow_rsp rsp = {};
+	struct rvu_pfvf *pfvf;
+	int vidx, err;
+	u16 vlan_tci;
+	u8 lbkid;
+
+	pfvf = rvu_get_pfvf(rvu, pcifunc);
+	vlan_tci = rvu_rep_get_vlan_id(rvu, pcifunc);
+	if (rte)
+		vlan_tci |= BIT_ULL(8);
+
+	err = rvu_rep_tx_vlan_cfg(rvu, pcifunc, vlan_tci, &vidx);
+	if (err)
+		return err;
+
+	lbkid = pfvf->nix_blkaddr == BLKADDR_NIX0 ? 0 : 1;
+	req.hdr.pcifunc = 0; /* AF is requester */
+	if (rte) {
+		req.vf = pcifunc;
+	} else {
+		req.vf = rvu->rep_pcifunc;
+		req.packet.sq_id = vlan_tci;
+		req.mask.sq_id = 0xffff;
+	}
+
+	req.entry = entry;
+	req.intf = pfvf->nix_tx_intf;
+	req.op = NIX_TX_ACTIONOP_UCAST_CHAN;
+	req.index = (lbkid << 8) | RVU_SWITCH_LBK_CHAN;
+	req.set_cntr = 1;
+	req.vtag0_def = vidx;
+	req.vtag0_op = 1;
+	return rvu_mbox_handler_npc_install_flow(rvu, &req, &rsp);
+}
+
+int rvu_rep_install_mcam_rules(struct rvu *rvu)
+{
+	struct rvu_switch *rswitch = &rvu->rswitch;
+	u16 start = rswitch->start_entry;
+	struct rvu_hwinfo *hw = rvu->hw;
+	u16 pcifunc, entry = 0;
+	int pf, vf, numvfs;
+	int err, nixlf, i;
+	u8 rep;
+
+	for (pf = 1; pf < hw->total_pfs; pf++) {
+		if (!is_pf_cgxmapped(rvu, pf))
+			continue;
+
+		pcifunc = pf << RVU_PFVF_PF_SHIFT;
+		rvu_get_nix_blkaddr(rvu, pcifunc);
+		rep = true;
+		for (i = 0; i < 2; i++) {
+			err = rvu_rep_install_rx_rule(rvu, pcifunc,
+						      start + entry, rep);
+			if (err)
+				return err;
+			rswitch->entry2pcifunc[entry++] = pcifunc;
+
+			err = rvu_rep_install_tx_rule(rvu, pcifunc,
+						      start + entry, rep);
+			if (err)
+				return err;
+			rswitch->entry2pcifunc[entry++] = pcifunc;
+			rep = false;
+		}
+
+		rvu_get_pf_numvfs(rvu, pf, &numvfs, NULL);
+		for (vf = 0; vf < numvfs; vf++) {
+			pcifunc = pf << RVU_PFVF_PF_SHIFT |
+				  ((vf + 1) & RVU_PFVF_FUNC_MASK);
+			rvu_get_nix_blkaddr(rvu, pcifunc);
+
+			/* Skip installimg rules if nixlf is not attached */
+			err = nix_get_nixlf(rvu, pcifunc, &nixlf, NULL);
+			if (err)
+				continue;
+			rep = true;
+			for (i = 0; i < 2; i++) {
+				err = rvu_rep_install_rx_rule(rvu, pcifunc,
+							      start + entry,
+							      rep);
+				if (err)
+					return err;
+				rswitch->entry2pcifunc[entry++] = pcifunc;
+
+				err = rvu_rep_install_tx_rule(rvu, pcifunc,
+							      start + entry,
+							      rep);
+				if (err)
+					return err;
+				rswitch->entry2pcifunc[entry++] = pcifunc;
+				rep = false;
+			}
+		}
+	}
+	return 0;
+}
+
+void rvu_rep_update_rules(struct rvu *rvu, u16 pcifunc, bool ena)
+{
+	struct rvu_switch *rswitch = &rvu->rswitch;
+	struct npc_mcam *mcam = &rvu->hw->mcam;
+	u32 max = rswitch->used_entries;
+	int blkaddr;
+	u16 entry;
+
+	if (!rswitch->used_entries)
+		return;
+
+	blkaddr = rvu_get_blkaddr(rvu, BLKTYPE_NPC, 0);
+
+	if (blkaddr < 0)
+		return;
+
+	rvu_switch_enable_lbk_link(rvu, pcifunc, ena);
+	mutex_lock(&mcam->lock);
+	for (entry = 0; entry < max; entry++) {
+		if (rswitch->entry2pcifunc[entry] == pcifunc)
+			npc_enable_mcam_entry(rvu, mcam, blkaddr, entry, ena);
+	}
+	mutex_unlock(&mcam->lock);
+}
+
+int rvu_rep_pf_init(struct rvu *rvu)
+{
+	u16 pcifunc = rvu->rep_pcifunc;
+	struct rvu_pfvf *pfvf;
+
+	pfvf = rvu_get_pfvf(rvu, pcifunc);
+	set_bit(NIXLF_INITIALIZED, &pfvf->flags);
+	rvu_switch_enable_lbk_link(rvu, pcifunc, true);
+	rvu_rep_rx_vlan_cfg(rvu, pcifunc);
+	return 0;
+}
+
+int rvu_mbox_handler_esw_cfg(struct rvu *rvu, struct esw_cfg_req *req,
+			     struct msg_rsp *rsp)
+{
+	if (req->hdr.pcifunc != rvu->rep_pcifunc)
+		return 0;
+
+	rvu->rep_mode = req->ena;
+
+	if (req->ena)
+		rvu_switch_enable(rvu);
+	else
+		rvu_switch_disable(rvu);
+
+	return 0;
+}
+
 int rvu_mbox_handler_get_rep_cnt(struct rvu *rvu, struct msg_req *req,
 				 struct get_rep_cnt_rsp *rsp)
 {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
index ceb81eebf65e..268efb7c1c15 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_switch.c
@@ -166,6 +166,8 @@ void rvu_switch_enable(struct rvu *rvu)
 
 	alloc_req.contig = true;
 	alloc_req.count = rvu->cgx_mapped_pfs + rvu->cgx_mapped_vfs;
+	if (rvu->rep_mode)
+		alloc_req.count = alloc_req.count * 4;
 	ret = rvu_mbox_handler_npc_mcam_alloc_entry(rvu, &alloc_req,
 						    &alloc_rsp);
 	if (ret) {
@@ -189,7 +191,12 @@ void rvu_switch_enable(struct rvu *rvu)
 	rswitch->used_entries = alloc_rsp.count;
 	rswitch->start_entry = alloc_rsp.entry;
 
-	ret = rvu_switch_install_rules(rvu);
+	if (rvu->rep_mode) {
+		rvu_rep_pf_init(rvu);
+		ret = rvu_rep_install_mcam_rules(rvu);
+	} else {
+		ret = rvu_switch_install_rules(rvu);
+	}
 	if (ret)
 		goto uninstall_rules;
 
@@ -222,6 +229,9 @@ void rvu_switch_disable(struct rvu *rvu)
 	if (!rswitch->used_entries)
 		return;
 
+	if (rvu->rep_mode)
+		goto free_ents;
+
 	for (pf = 1; pf < hw->total_pfs; pf++) {
 		if (!is_pf_cgxmapped(rvu, pf))
 			continue;
@@ -249,6 +259,7 @@ void rvu_switch_disable(struct rvu *rvu)
 		}
 	}
 
+free_ents:
 	uninstall_req.start = rswitch->start_entry;
 	uninstall_req.end =  rswitch->start_entry + rswitch->used_entries - 1;
 	free_req.all = 1;
@@ -258,12 +269,15 @@ void rvu_switch_disable(struct rvu *rvu)
 	kfree(rswitch->entry2pcifunc);
 }
 
-void rvu_switch_update_rules(struct rvu *rvu, u16 pcifunc)
+void rvu_switch_update_rules(struct rvu *rvu, u16 pcifunc, bool ena)
 {
 	struct rvu_switch *rswitch = &rvu->rswitch;
 	u32 max = rswitch->used_entries;
 	u16 entry;
 
+	if (rvu->rep_mode)
+		return rvu_rep_update_rules(rvu, pcifunc, ena);
+
 	if (!rswitch->used_entries)
 		return;
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index a021350fe83a..b993b03622dd 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -28,6 +28,22 @@ MODULE_DESCRIPTION(DRV_STRING);
 MODULE_LICENSE("GPL");
 MODULE_DEVICE_TABLE(pci, rvu_rep_id_table);
 
+static int rvu_eswitch_config(struct otx2_nic *priv, u8 ena)
+{
+	struct esw_cfg_req *req;
+
+	mutex_lock(&priv->mbox.lock);
+	req = otx2_mbox_alloc_msg_esw_cfg(&priv->mbox);
+	if (!req) {
+		mutex_unlock(&priv->mbox.lock);
+		return -ENOMEM;
+	}
+	req->ena = ena;
+	otx2_sync_mbox_msg(&priv->mbox);
+	mutex_unlock(&priv->mbox.lock);
+	return 0;
+}
+
 static netdev_tx_t rvu_rep_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct rep_dev *rep = netdev_priv(dev);
@@ -161,6 +177,7 @@ void rvu_rep_destroy(struct otx2_nic *priv)
 	struct rep_dev *rep;
 	int rep_id;
 
+	rvu_eswitch_config(priv, false);
 	priv->flags |= OTX2_FLAG_INTF_DOWN;
 	rvu_rep_free_cq_rsrc(priv);
 	for (rep_id = 0; rep_id < priv->rep_cnt; rep_id++) {
@@ -221,6 +238,7 @@ int rvu_rep_create(struct otx2_nic *priv, struct netlink_ext_ack *extack)
 	if (err)
 		goto exit;
 
+	rvu_eswitch_config(priv, true);
 	return 0;
 exit:
 	while (--rep_id >= 0) {
-- 
2.25.1


