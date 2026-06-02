Return-Path: <netdev+bounces-294012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIZIKiJjHmrCiwkAu9opvQ
	(envelope-from <netdev+bounces-294012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 06:59:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2C5628477
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 06:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B75E8300D768
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 04:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F164C2DECCB;
	Tue,  2 Jun 2026 04:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Rs+uT+PA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD282E173B;
	Tue,  2 Jun 2026 04:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780376349; cv=none; b=WYGkEIpGgGchKgQdT8ykSR4Jm+ckDjK1uyvS+etD2tsACVPo4iFGPTzJ1lYiC9lQNfLdDB653GooSR5J6R/JUK84x5nkOwYupMRM7cdh3p6MICArgPCl330xUMZFP9M35VYUWUira51TL+8CqkGCQbD03g7GIDj17ejv6MNboqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780376349; c=relaxed/simple;
	bh=5IkMsK2r6qbiNI7EJZ//9juAuxxeOqvGl+x9taE72GE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mT0ECPZG7co4OnbvGYnbPn1OXwJpbecczBXEo3+DlBs2IzoqrTAz2jeakf9zBRHePUrn8a4EFD9w85QtAJDw+RN9pWtCvviiDeDCNFQK0VYEfQBU6x6o7/zu298A+Bgio/g/gVhlm5x8raJA7rX/nLOHflp9HHlfjOOPNMUef0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Rs+uT+PA; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651Jx8KZ2671986;
	Mon, 1 Jun 2026 21:59:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=2CEtvbR7IuJFu2tdddPb+Jk
	oNQbegp7LR9cdD/TJ+p4=; b=Rs+uT+PAYuUxqfxJq39W6aUXkOjphzQPUwDNAWs
	EGR2ADF+jqOpZi74PaZbyfx9OZswiLykAkB93ti0LmRUweNpQ1hT/wJ8GIm0TmYw
	hV5pJowI84sbE7WpeI/fp1b+KGWrsUzK2BnKEoEbO1ycoewTvYlb1d2PIydEMS3G
	i7PDKd02E4Axu2m0cPPE2CRkr1IfXjVx0ikuI7J0xttqUBBBMLX1PTsyvbe0ziBb
	QFRAEq+QVQKwq83ItyHCyfoTdB9ZbMWmCR91VufSbtsK9xYYeEnIm+3wxMxEnwWV
	KqjsnqSJT/zDxZAGPjAt9wggb57DFCbB1tVaw+mwtdf+c6w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4egm56p1c6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 21:59:00 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 1 Jun 2026 21:58:59 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 1 Jun 2026 21:58:59 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id 3785C3F7062;
	Mon,  1 Jun 2026 21:58:55 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <naveenm@marvell.com>, <netdev@vger.kernel.org>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>,
        Nithin Dabilpuram
	<ndabilpuram@marvell.com>,
        Ratheesh Kannoth <rkannoth@marvell.com>
Subject: [PATCH v2 net] octeontx2-af: npc: Fix CPT channel mask in npc_install_flow
Date: Tue, 2 Jun 2026 10:28:53 +0530
Message-ID: <20260602045853.1558530-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: vlxedUy7FtToLCRW_aLATJ1uI0AoFZ4Z
X-Proofpoint-ORIG-GUID: vlxedUy7FtToLCRW_aLATJ1uI0AoFZ4Z
X-Authority-Analysis: v=2.4 cv=ZeYt8MVA c=1 sm=1 tr=0 ts=6a1e6314 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=4EvExXkf6CeaTzh4v_IA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA0MyBTYWx0ZWRfX1ArtFAogOCyg
 Vuvh2likSgz0G0vUsllpA5zfjqxjHrZ7fO1KryHS3smsLCxY4smTMrYHm4/hm3ASOumxRbAC1Na
 mvmGCFHAWoD2lswI72jnYeCbfSE/E3aBlHNQgDdT0LzunyBBvMeIR/FQV6RQBn32VlM0T5afv/k
 50sv/s2L9ZE+EFGqnpN/510dtgJbifi8A+V/nkIhbE9W2+D7enjYXAVK0wRCLvAMCW4NsP910lE
 YIwgC2WfwtqolUiK3cgbvFAzOG6l+3VESChJgXvcI2euGy7YUWbI4b5pXTDYh43/gv9xPpMOFfK
 XceMXAt85GgB5g8uEnQYr2KbPO8DKsdru0AmwXHbTCkw3N9JlvkmSam5tCAfQiah0WuMhSZw0sQ
 vAq0PGFDOgjN0wv32m83gHEu/f8Zr37aK13MwNMd87XyM5pLVo0232A51Jw15WSZH5UR0o+1lmj
 ZXoY7eO3vEbguegpUTQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294012-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[marvell.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: AB2C5628477
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Nithin Dabilpuram <ndabilpuram@marvell.com>

Use the CPT-aware NIX channel mask in the npc_install_flow path so that
when the host PF installs steering rules in kernel for a VF used from
userspace (e.g. DPDK), MCAM entries see the same channel mask semantics as
other RX paths.

Fixes: 56bcef528bd8 ("octeontx2-af: Use npc_install_flow API for promisc and broadcast entries")
Cc: Naveen Mamindlapalli <naveenm@marvell.com>
Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/rvu.h   |  1 +
 .../ethernet/marvell/octeontx2/af/rvu_npc.c   | 32 +++++++++----------
 .../marvell/octeontx2/af/rvu_npc_fs.c         |  2 +-
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index de3fbd3d15d6..65397daae4c2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -1145,6 +1145,7 @@ int rvu_cpt_lf_teardown(struct rvu *rvu, u16 pcifunc, int blkaddr, int lf,
 			int slot);
 int rvu_cpt_ctx_flush(struct rvu *rvu, u16 pcifunc);
 int rvu_cpt_init(struct rvu *rvu);
+u32 rvu_get_cpt_chan_mask(struct rvu *rvu);

 #define NDC_AF_BANK_MASK       GENMASK_ULL(7, 0)
 #define NDC_AF_BANK_LINE_MASK  GENMASK_ULL(31, 16)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
index 607d0cf1a778..12074f3b3e39 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
@@ -701,6 +701,19 @@ void npc_set_mcam_action(struct rvu *rvu, struct npc_mcam *mcam,
 	return rvu_write64(rvu, blkaddr, reg, cfg);
 }

+u32 rvu_get_cpt_chan_mask(struct rvu *rvu)
+{
+	/* For cn10k the upper two bits of the channel number are
+	 * cpt channel number. with masking out these bits in the
+	 * mcam entry, same entry used for NIX will allow packets
+	 * received from cpt for parsing.
+	 */
+	if (!is_rvu_otx2(rvu))
+		return NIX_CHAN_CPT_X2P_MASK;
+	else
+		return 0xFFFu;
+}
+
 void rvu_npc_install_ucast_entry(struct rvu *rvu, u16 pcifunc,
 				 int nixlf, u64 chan, u8 *mac_addr)
 {
@@ -750,7 +763,7 @@ void rvu_npc_install_ucast_entry(struct rvu *rvu, u16 pcifunc,
 	eth_broadcast_addr((u8 *)&req.mask.dmac);
 	req.features = BIT_ULL(NPC_DMAC);
 	req.channel = chan;
-	req.chan_mask = 0xFFFU;
+	req.chan_mask = rvu_get_cpt_chan_mask(rvu);
 	req.intf = pfvf->nix_rx_intf;
 	req.op = action.op;
 	req.hdr.pcifunc = 0; /* AF is requester */
@@ -845,11 +858,7 @@ void rvu_npc_install_promisc_entry(struct rvu *rvu, u16 pcifunc,
 	 * mcam entry, same entry used for NIX will allow packets
 	 * received from cpt for parsing.
 	 */
-	if (!is_rvu_otx2(rvu)) {
-		req.chan_mask = NIX_CHAN_CPT_X2P_MASK;
-	} else {
-		req.chan_mask = 0xFFFU;
-	}
+	req.chan_mask = rvu_get_cpt_chan_mask(rvu);

 	if (chan_cnt > 1) {
 		if (!is_power_of_2(chan_cnt)) {
@@ -1053,16 +1062,7 @@ void rvu_npc_install_allmulti_entry(struct rvu *rvu, u16 pcifunc, int nixlf,
 	ether_addr_copy(req.mask.dmac, mac_addr);
 	req.features = BIT_ULL(NPC_DMAC);

-	/* For cn10k the upper two bits of the channel number are
-	 * cpt channel number. with masking out these bits in the
-	 * mcam entry, same entry used for NIX will allow packets
-	 * received from cpt for parsing.
-	 */
-	if (!is_rvu_otx2(rvu))
-		req.chan_mask = NIX_CHAN_CPT_X2P_MASK;
-	else
-		req.chan_mask = 0xFFFU;
-
+	req.chan_mask = rvu_get_cpt_chan_mask(rvu);
 	req.channel = chan;
 	req.intf = pfvf->nix_rx_intf;
 	req.entry = index;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
index 6ae9cdcb608b..34f1e066707b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_fs.c
@@ -1820,7 +1820,7 @@ int rvu_mbox_handler_npc_install_flow(struct rvu *rvu,

 	/* ignore chan_mask in case pf func is not AF, revisit later */
 	if (!is_pffunc_af(req->hdr.pcifunc))
-		req->chan_mask = 0xFFF;
+		req->chan_mask = rvu_get_cpt_chan_mask(rvu);

 	err = npc_check_unsupported_flows(rvu, req->features, req->intf);
 	if (err) {
--
2.43.0

--
v1 -> v2:  Addressed Sashiko comments
	https://lore.kernel.org/netdev/20260601023221.858168-1-rkannoth@marvell.com/

