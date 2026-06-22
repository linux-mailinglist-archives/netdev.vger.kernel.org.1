Return-Path: <netdev+bounces-300945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tCNyEEevOGrBfwcAu9opvQ
	(envelope-from <netdev+bounces-300945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 05:43:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F406AC519
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 05:43:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=gz60gyNy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300945-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300945-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C66D300BDA0
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 03:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03963385BE;
	Mon, 22 Jun 2026 03:43:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0FE126BF7;
	Mon, 22 Jun 2026 03:42:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782099780; cv=none; b=DYVDzL/CInwQ690uNsaxYpyLisYVmADn4f5m12aKVPzvK5Da5lH+JSNCr40CRkoC6xU7LUZhIOEzaUHjKOFWHeq2nm9Z/o0o0+/RZxCe2277dkc4Way12IpoWvp8hQw15mCKtQBpCGzl5HIRL0HxTT5aW3uakVnCiF1SWMma2Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782099780; c=relaxed/simple;
	bh=PXeeo3T6RhZ0LynB31ujkqcOdo+kGOxkEynHKrn0xXs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=da+FcSinDmFs8CFn2t319BAMhCALVKLKnUG/18Jp/zxwLuSNyH9BmYautpciqi09f/uQlTQcrXDmwFVcMyb0VyoIIUby577KfbxoXuHwqdZ1tKa6/Tq8rNIEXXOc7aCuZaXEVBeTEBONbNmIEkYRfyPc5YcvFJ/63ex88C3fKF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=gz60gyNy; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65LLti2Z1055769;
	Sun, 21 Jun 2026 20:42:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=ISjx4fIlRNIV9DBQ8H4bu6R
	5aZqTJuKWZdj0giCNa8U=; b=gz60gyNyuA1NVmxot7gFo/+HjhJimA8p4Kt4rCZ
	LoxCwY7agDZNp632GP5eV6d4AuF+sSlN603e4R3qhl9q16emJuswbXK1djFofcEj
	7/zjSiF4dLr+cR3nGTLUx0SJnWq0KuSIwgttdAUe7JnD0bOuJmJztL87WP95uVQV
	5747e9Txes1dseslUREM3+eL0xF/pUvBv6Gn7eUgA14FtIT4YwAKYFVxJtvst/vh
	EY4ZEeEymnUl2QT2YhUdZojGY0uTkOUM/dCPI5cS9EQMOQTpf5i6Zy2YKywa8C8s
	+2K3MZB8CJIQD81tPLtxt2NfraxJ6MNtUbhaVdDgMDDIIfg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4ewr7hc3r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 21 Jun 2026 20:42:36 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Sun, 21 Jun 2026 20:42:36 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Sun, 21 Jun 2026 20:42:35 -0700
Received: from rkannoth-OptiPlex-7090.. (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with ESMTP id E3B213F7061;
	Sun, 21 Jun 2026 20:42:31 -0700 (PDT)
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: <davem@davemloft.net>, <hkelam@marvell.com>, <lcherian@marvell.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>, <sgoutham@marvell.com>
CC: <andrew+netdev@lunn.ch>, <edumazet@google.com>, <kuba@kernel.org>,
        Ratheesh Kannoth <rkannoth@marvell.com>,
        Yuho Choi <dbgh9129@gmail.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net v2] octeontx2-af: fix CGX debugfs RVU AF PCI reference leaks
Date: Mon, 22 Jun 2026 09:12:29 +0530
Message-ID: <20260622034229.2254145-1-rkannoth@marvell.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDAzMiBTYWx0ZWRfX2CRTJ/FhV+v+
 1NHDV4ljWRWHzoYHjKtzELhNHFn8Mk88T0WdnL+CpNDcanfiuMZFQFTyoBNB9u202ao7GhpNvp9
 64udeLy+C7ZzIeB0zqlKs4Ws10ayzQysbnL/iAg8wd4ThByVAPxRznYl6UufCoH5sUpY08LfMb9
 d2LMvFd9Hcu75IPEoEAPSBTwjbWej2MLuE3R4gACiwwGP4es3FyJUnM+1eU/cDAz1gnW0uKyT7M
 biCRTrVA02GD3q+8PwY72EkbGUWiIzeMlH0OBFi263v/FzCpz+L47Dnsoy5chH/v/PCo891dopn
 xBEXH3L6WEaAZDp++lzisaWzhDMp9ECF9T8aQPVKyL/ehDN70tDhU17czKJqrv8LUxf94GT3Rmq
 HXqzFYKx3yUzRoBgiL+Rs3oWOl9XAXy9aEaBOhny85dFIqrviW9FQ91NdwjT2hQef2kSGHPccfc
 YXjZTh73jHZVQq2Ki0w==
X-Proofpoint-ORIG-GUID: eUN4K8TWFn7K3kuzRID6WlgXR3FaLwzB
X-Authority-Analysis: v=2.4 cv=aJTAb79m c=1 sm=1 tr=0 ts=6a38af2c cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=pGLkceISAAAA:8
 a=a4YZzIsXFeaM3Y4ekB4A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDAzMiBTYWx0ZWRfXy1ydW6bYHPSq
 Unrk3O6VEq0wqIqxNHF7IA/9AbPkiMdK4FDhh6ldvq1i67ojSvQYrcQVV0bEzkrXpRSQYnEQ/kq
 6OrKAWTo2YmB+JrD1p8bKxAnDKRbBpU=
X-Proofpoint-GUID: eUN4K8TWFn7K3kuzRID6WlgXR3FaLwzB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-21_02,2026-06-18_03,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300945-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[lunn.ch,google.com,kernel.org,marvell.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:hkelam@marvell.com,m:lcherian@marvell.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:kuba@kernel.org,m:rkannoth@marvell.com,m:dbgh9129@gmail.com,m:horms@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rkannoth@marvell.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 84F406AC519

CGX per-lmac debugfs seq readers obtained struct rvu via
pci_get_drvdata(pci_get_device(..., PCI_DEVID_OCTEONTX2_RVU_AF, ...)),
which leaks a PCI device reference on every read. Store rvu and the CGX
handle in debugfs inode private data when creating stats, mac_filter,
and fwdata files (one context per CGX), and use debugfs aux numbers for
fwdata so lmac_id matches the other CGX debugfs entries.

Fixes: f967488d095e ("octeontx2-af: Add per CGX port level NIX Rx/Tx counters")
Fixes: dbc52debf95f ("octeontx2-af: Debugfs support for DMAC filters")
Fixes: 49f02e6877d1 ("Octeontx2-af: Debugfs support for firmware data")
Cc: Linu Cherian <lcherian@marvell.com>
Reported-by: Yuho Choi <dbgh9129@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>

--
v1 -> v2: Addressed Simon/Jakub comments
	https://lore.kernel.org/netdev/20260621144405.0abfc627@kernel.org/
---
 .../marvell/octeontx2/af/rvu_debugfs.c        | 76 ++++++++++---------
 1 file changed, 41 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index ca2704b188a5..5f4679604a53 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -2810,6 +2810,14 @@ static void rvu_dbg_npa_init(struct rvu *rvu)
 			    &rvu_dbg_npa_ndc_hits_miss_fops);
 }
 
+/* Per-lmac CGX debugfs files need both RVU and CGX handle; inode->i_private
+ * points here so seq_file ops avoid pci_get_device(PCI_DEVID_OCTEONTX2_RVU_AF).
+ */
+struct rvu_cgx_lmac_dbgfs_ctx {
+	struct rvu	*rvu;
+	void		*cgxd;
+};
+
 #define PRINT_CGX_CUML_NIXRX_STATUS(idx, name)				\
 	({								\
 		u64 cnt;						\
@@ -2832,18 +2840,14 @@ static void rvu_dbg_npa_init(struct rvu *rvu)
 
 static int cgx_print_stats(struct seq_file *s, int lmac_id)
 {
+	struct rvu_cgx_lmac_dbgfs_ctx *dctx = s->private;
 	struct cgx_link_user_info linfo;
+	struct rvu *rvu = dctx->rvu;
 	struct mac_ops *mac_ops;
-	void *cgxd = s->private;
+	void *cgxd = dctx->cgxd;
 	u64 ucast, mcast, bcast;
 	int stat = 0, err = 0;
 	u64 tx_stat, rx_stat;
-	struct rvu *rvu;
-
-	rvu = pci_get_drvdata(pci_get_device(PCI_VENDOR_ID_CAVIUM,
-					     PCI_DEVID_OCTEONTX2_RVU_AF, NULL));
-	if (!rvu)
-		return -ENODEV;
 
 	mac_ops = get_mac_ops(cgxd);
 	/* There can be no CGX devices at all */
@@ -2950,20 +2954,16 @@ RVU_DEBUG_SEQ_FOPS(cgx_stat, cgx_stat_display, NULL);
 
 static int cgx_print_dmac_flt(struct seq_file *s, int lmac_id)
 {
+	struct rvu_cgx_lmac_dbgfs_ctx *dctx = s->private;
+	struct rvu *rvu = dctx->rvu;
 	struct pci_dev *pdev = NULL;
-	void *cgxd = s->private;
+	void *cgxd = dctx->cgxd;
 	char *bcast, *mcast;
 	u16 index, domain;
 	u8 dmac[ETH_ALEN];
-	struct rvu *rvu;
 	u64 cfg, mac;
 	int pf;
 
-	rvu = pci_get_drvdata(pci_get_device(PCI_VENDOR_ID_CAVIUM,
-					     PCI_DEVID_OCTEONTX2_RVU_AF, NULL));
-	if (!rvu)
-		return -ENODEV;
-
 	pf = cgxlmac_to_pf(rvu, cgx_get_cgxid(cgxd), lmac_id);
 	domain = 2;
 
@@ -3010,17 +3010,13 @@ RVU_DEBUG_SEQ_FOPS(cgx_dmac_flt, cgx_dmac_flt_display, NULL);
 
 static int cgx_print_fwdata(struct seq_file *s, int lmac_id)
 {
+	struct rvu_cgx_lmac_dbgfs_ctx *dctx = s->private;
 	struct cgx_lmac_fwdata_s *fwdata;
-	void *cgxd = s->private;
+	struct rvu *rvu = dctx->rvu;
+	void *cgxd = dctx->cgxd;
 	struct phy_s *phy;
-	struct rvu *rvu;
 	int cgx_id, i;
 
-	rvu = pci_get_drvdata(pci_get_device(PCI_VENDOR_ID_CAVIUM,
-					     PCI_DEVID_OCTEONTX2_RVU_AF, NULL));
-	if (!rvu)
-		return -ENODEV;
-
 	if (!rvu->fwdata)
 		return -EAGAIN;
 
@@ -3101,6 +3097,7 @@ RVU_DEBUG_SEQ_FOPS(cgx_fwdata, cgx_fwdata_display, NULL);
 
 static void rvu_dbg_cgx_init(struct rvu *rvu)
 {
+	struct rvu_cgx_lmac_dbgfs_ctx *ctx;
 	struct mac_ops *mac_ops;
 	unsigned long lmac_bmap;
 	int i, lmac_id;
@@ -3127,20 +3124,29 @@ static void rvu_dbg_cgx_init(struct rvu *rvu)
 		rvu->rvu_dbg.cgx = debugfs_create_dir(dname,
 						      rvu->rvu_dbg.cgx_root);
 
-		for_each_set_bit(lmac_id, &lmac_bmap, rvu->hw->lmac_per_cgx) {
-			/* lmac debugfs dir */
-			sprintf(dname, "lmac%d", lmac_id);
-			rvu->rvu_dbg.lmac =
-				debugfs_create_dir(dname, rvu->rvu_dbg.cgx);
-
-			debugfs_create_file_aux_num("stats", 0600, rvu->rvu_dbg.lmac,
-					    cgx, lmac_id, &rvu_dbg_cgx_stat_fops);
-			debugfs_create_file_aux_num("mac_filter", 0600,
-					    rvu->rvu_dbg.lmac, cgx, lmac_id,
-					    &rvu_dbg_cgx_dmac_flt_fops);
-			debugfs_create_file("fwdata", 0600,
-					    rvu->rvu_dbg.lmac, cgx,
-					    &rvu_dbg_cgx_fwdata_fops);
+		{
+			ctx = devm_kzalloc(rvu->dev, sizeof(*ctx), GFP_KERNEL);
+			if (!ctx)
+				continue;
+
+			ctx->rvu = rvu;
+			ctx->cgxd = cgx;
+
+			for_each_set_bit(lmac_id, &lmac_bmap, rvu->hw->lmac_per_cgx) {
+				/* lmac debugfs dir */
+				sprintf(dname, "lmac%d", lmac_id);
+				rvu->rvu_dbg.lmac =
+					debugfs_create_dir(dname, rvu->rvu_dbg.cgx);
+
+				debugfs_create_file_aux_num("stats", 0600, rvu->rvu_dbg.lmac,
+							    ctx, lmac_id, &rvu_dbg_cgx_stat_fops);
+				debugfs_create_file_aux_num("mac_filter", 0600,
+							    rvu->rvu_dbg.lmac, ctx, lmac_id,
+							    &rvu_dbg_cgx_dmac_flt_fops);
+				debugfs_create_file_aux_num("fwdata", 0600,
+							    rvu->rvu_dbg.lmac, ctx,
+							    lmac_id, &rvu_dbg_cgx_fwdata_fops);
+			}
 		}
 	}
 }
-- 
2.43.0


