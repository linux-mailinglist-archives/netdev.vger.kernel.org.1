Return-Path: <netdev+bounces-95862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C476F8C3B10
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 07:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B7782815F0
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 05:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08801474C5;
	Mon, 13 May 2024 05:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="E3hEufRd"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E651465A6;
	Mon, 13 May 2024 05:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715579223; cv=none; b=CnuDYL9gltvnm2AOFBgar1spnroM460RH8XHvqke/6cEHSFOZV9YIC7PQVHZstliIkQPfUsKHMdp7nJi3t2T2Wo9CSXRZKEt3SXbzerXVQu7moR5WlN010Vqf7kz2aS838kjm468nzWSe/41u6aQlxBJuRG4NeJznIWLE6OLxX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715579223; c=relaxed/simple;
	bh=ZvvbsE3Ps3u6dRB+s63zEIfloyzLm8bUm5nkqCtL1G8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fubEHAHRFSsWsukTnZo9EbOxfvWcM55z4LILV778UD0d1Wde7oxh6B5CgBYZT6bPioiWiZy+Y3mXyzt+PneAI17exwpzX1dRsVA6Y8esbyahoDBMDZQCu85fhcdNky/OiFuvNO6TTADpXKi0tz60jy0B/hSITE/5mn/w2d9uFDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=E3hEufRd; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44CLjKqF018797;
	Sun, 12 May 2024 22:46:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=z8MiNGLM0cgSrru9dlnnvbuIL6BXJO3+OEeJbyuxJnw=; b=E3h
	EufRdb2B0TAd6Ve32mrqNd+s+FXZpnZC8Wil+5FNgepsXYRlkiDq95QRbCEAP7Up
	le9U3pZGbujqxv1cgUHFNHkIcIKrxQaO2m7/LhlaYXcIxQDVZpZceTCgdoSdamah
	vLzgt6JZVtNRC/lyOYj2mnCNvHJKC3YmMKFpRfemNdPLn2bC/JSXPWtIjvsKhbOu
	qqG8kXhOli61lG8DM2ttTx91utZGXlKY9Mekx63xmOKtl1O6gISYHmgcL5TQVd4L
	pwbelcfytx2v12dGP0ntuKkKG+y5LNz3SlFihSEV/fR/sgadEDTjvaJXjoLiI6UB
	V2X5Ls5i9LkFimTWUZw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3y286jb8nt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 12 May 2024 22:46:55 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 12 May 2024 22:46:53 -0700
Received: from bharat-OptiPlex-3070.marvell.com (10.69.176.80) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Sun, 12 May 2024 22:46:50 -0700
From: Bharat Bhushan <bbhushan2@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>
CC: Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH 6/8] cn10k-ipsec: Process inline ipsec transmit offload
Date: Mon, 13 May 2024 11:16:21 +0530
Message-ID: <20240513054623.270366-7-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513054623.270366-1-bbhushan2@marvell.com>
References: <20240513054623.270366-1-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: mZA_JFqej_Co7WmuQO2pot9KvLlN6h8P
X-Proofpoint-ORIG-GUID: mZA_JFqej_Co7WmuQO2pot9KvLlN6h8P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_04,2024-05-10_02,2023-05-22_02

Prepare and submit crypto hardware (CPT) instruction for
outbound inline ipsec crypto mode offload. The CPT instruction
have authentication offset, IV offset and encapsulation offset
in input packet. Also provide SA context pointer which have
details about algo, keys, salt etc. Crypto hardware encrypt,
authenticate and provide the ESP packet to networking hardware.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
 .../marvell/octeontx2/nic/cn10k_ipsec.c       | 224 ++++++++++++++++++
 .../marvell/octeontx2/nic/cn10k_ipsec.h       |  40 ++++
 .../marvell/octeontx2/nic/otx2_common.c       |  23 ++
 .../marvell/octeontx2/nic/otx2_common.h       |   3 +
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   2 +
 .../marvell/octeontx2/nic/otx2_txrx.c         |  33 ++-
 .../marvell/octeontx2/nic/otx2_txrx.h         |   3 +
 7 files changed, 325 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
index db544dac0424..98a200879b3b 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
@@ -7,8 +7,11 @@
 #include <net/xfrm.h>
 #include <linux/netdevice.h>
 #include <linux/bitfield.h>
+#include <crypto/aead.h>
+#include <crypto/gcm.h>
 
 #include "otx2_common.h"
+#include "otx2_struct.h"
 #include "cn10k_ipsec.h"
 
 static bool is_dev_support_inline_ipsec(struct pci_dev *pdev)
@@ -820,3 +823,224 @@ void cn10k_ipsec_clean(struct otx2_nic *pf)
 	qmem_free(pf->dev, pf->ipsec.outb_sa);
 	cn10k_outb_cpt_clean(pf);
 }
+
+static u16 cn10k_ipsec_get_ip_data_len(struct xfrm_state *x,
+				       struct sk_buff *skb)
+{
+	struct ipv6hdr *ipv6h;
+	struct iphdr *iph;
+	u8 *src;
+
+	src = (u8 *)skb->data + ETH_HLEN;
+
+	if (x->props.family == AF_INET) {
+		iph = (struct iphdr *)src;
+		return ntohs(iph->tot_len);
+	}
+
+	ipv6h = (struct ipv6hdr *)src;
+	return ntohs(ipv6h->payload_len) + sizeof(struct ipv6hdr);
+}
+
+/* Prepare CPT and NIX SQE scatter/gather subdescriptor structure.
+ * SG of NIX and CPT are same in size.
+ * Layout of a NIX SQE and CPT SG entry:
+ *      -----------------------------
+ *     |     CPT Scatter Gather      |
+ *     |       (SQE SIZE)            |
+ *     |                             |
+ *      -----------------------------
+ *     |       NIX SQE               |
+ *     |       (SQE SIZE)            |
+ *     |                             |
+ *      -----------------------------
+ */
+bool otx2_sqe_add_sg_ipsec(struct otx2_nic *pfvf, struct otx2_snd_queue *sq,
+			   struct sk_buff *skb, int num_segs, int *offset)
+{
+	struct cpt_sg_s *cpt_sg = NULL;
+	struct nix_sqe_sg_s *sg = NULL;
+	u64 dma_addr, *iova = NULL;
+	u64 *cpt_iova = NULL;
+	u16 *sg_lens = NULL;
+	int seg, len;
+
+	sq->sg[sq->head].num_segs = 0;
+	cpt_sg = (struct cpt_sg_s *)(sq->sqe_base - sq->sqe_size);
+
+	for (seg = 0; seg < num_segs; seg++) {
+		if ((seg % MAX_SEGS_PER_SG) == 0) {
+			sg = (struct nix_sqe_sg_s *)(sq->sqe_base + *offset);
+			sg->ld_type = NIX_SEND_LDTYPE_LDD;
+			sg->subdc = NIX_SUBDC_SG;
+			sg->segs = 0;
+			sg_lens = (void *)sg;
+			iova = (void *)sg + sizeof(*sg);
+			/* Next subdc always starts at a 16byte boundary.
+			 * So if sg->segs is whether 2 or 3, offset += 16bytes.
+			 */
+			if ((num_segs - seg) >= (MAX_SEGS_PER_SG - 1))
+				*offset += sizeof(*sg) + (3 * sizeof(u64));
+			else
+				*offset += sizeof(*sg) + sizeof(u64);
+
+			cpt_sg += (seg / MAX_SEGS_PER_SG) * 4;
+			cpt_iova = (void *)cpt_sg + sizeof(*cpt_sg);
+		}
+		dma_addr = otx2_dma_map_skb_frag(pfvf, skb, seg, &len);
+		if (dma_mapping_error(pfvf->dev, dma_addr))
+			return false;
+
+		sg_lens[seg % MAX_SEGS_PER_SG] = len;
+		sg->segs++;
+		*iova++ = dma_addr;
+		*cpt_iova++ = dma_addr;
+
+		/* Save DMA mapping info for later unmapping */
+		sq->sg[sq->head].dma_addr[seg] = dma_addr;
+		sq->sg[sq->head].size[seg] = len;
+		sq->sg[sq->head].num_segs++;
+
+		*cpt_sg = *(struct cpt_sg_s *)sg;
+		cpt_sg->rsvd_63_50 = 0;
+	}
+
+	sq->sg[sq->head].skb = (u64)skb;
+	return true;
+}
+
+static inline u16 cn10k_ipsec_get_param1(u8 iv_offset)
+{
+	u16 param1_val;
+
+	/* Set Crypto mode, disable L3/L4 checksum */
+	param1_val = CN10K_IPSEC_INST_PARAM1_CRYPTO_MODE |
+		      CN10K_IPSEC_INST_PARAM1_DIS_L4_CSUM |
+		      CN10K_IPSEC_INST_PARAM1_DIS_L3_CSUM;
+	param1_val |= (u16)iv_offset << CN10K_IPSEC_INST_PARAM1_IV_OFFSET_SHIFT;
+	return param1_val;
+}
+
+bool cn10k_ipsec_transmit(struct otx2_nic *pf, struct netdev_queue *txq,
+			  struct otx2_snd_queue *sq, struct sk_buff *skb,
+			  int num_segs, int size)
+{
+	struct cpt_ctx_info_s *sa_info;
+	struct cpt_inst_s inst;
+	struct cpt_res_s *res;
+	struct xfrm_state *x;
+	dma_addr_t dptr_iova;
+	struct sec_path *sp;
+	u8 encap_offset;
+	u8 auth_offset;
+	u8 gthr_size;
+	u8 iv_offset;
+	u16 dlen;
+
+	/* Check for Inline IPSEC enabled */
+	if (!(pf->flags & OTX2_FLAG_INLINE_IPSEC_ENABLED)) {
+		netdev_err(pf->netdev, "Ipsec not enabled, drop packet\n");
+		goto drop;
+	}
+
+	sp = skb_sec_path(skb);
+	if (unlikely(!sp->len)) {
+		netdev_err(pf->netdev, "%s: no xfrm state len = %d\n",
+			   __func__, sp->len);
+		goto drop;
+	}
+
+	x = xfrm_input_state(skb);
+	if (unlikely(!x)) {
+		netdev_err(pf->netdev, "no xfrm_input_state()\n");
+		goto drop;
+	}
+
+	if (x->props.mode != XFRM_MODE_TRANSPORT &&
+	    x->props.mode != XFRM_MODE_TUNNEL) {
+		netdev_err(pf->netdev, "un supported offload mode %d\n",
+			   x->props.mode);
+		goto drop;
+	}
+
+	dlen = cn10k_ipsec_get_ip_data_len(x, skb);
+	if (dlen == 0) {
+		netdev_err(pf->netdev, "Invalid IP header, ip-length zero\n");
+		goto drop;
+	}
+
+	/* Check for valid SA context */
+	sa_info = (struct cpt_ctx_info_s *)x->xso.offload_handle;
+	if (!sa_info || !sa_info->sa_iova) {
+		netdev_err(pf->netdev, "Invalid SA conext\n");
+		goto drop;
+	}
+
+	memset(&inst, 0, sizeof(struct cpt_inst_s));
+
+	/* Get authentication offset */
+	if (x->props.family == AF_INET)
+		auth_offset = sizeof(struct iphdr);
+	else
+		auth_offset = sizeof(struct ipv6hdr);
+
+	/* IV offset is after ESP header */
+	iv_offset = auth_offset + sizeof(struct ip_esp_hdr);
+	/* Encap will start after IV */
+	encap_offset = iv_offset + GCM_RFC4106_IV_SIZE;
+
+	/* CPT Instruction word-1 */
+	res = (struct cpt_res_s *)(sq->cpt_resp->base + (64 * sq->head));
+	res->compcode = 0;
+	inst.res_addr = sq->cpt_resp->iova + (64 * sq->head);
+
+	/* CPT Instruction word-2 */
+	inst.rvu_pf_func = pf->pcifunc;
+
+	/* CPT Instruction word-3:
+	 * Set QORD to force CPT_RES_S write completion
+	 */
+	inst.qord = 1;
+
+	/* CPT Instruction word-4 */
+	inst.dlen = dlen + ETH_HLEN;
+	inst.opcode_major = CN10K_IPSEC_MAJOR_OP_OUTB_IPSEC;
+	inst.param1 = cn10k_ipsec_get_param1(iv_offset);
+
+	inst.param2 = encap_offset <<
+		       CN10K_IPSEC_INST_PARAM2_ENC_DATA_OFFSET_SHIFT;
+	inst.param2 |= (u16)auth_offset <<
+			CN10K_IPSEC_INST_PARAM2_AUTH_DATA_OFFSET_SHIFT;
+
+	/* CPT Instruction word-5 */
+	gthr_size = num_segs / MAX_SEGS_PER_SG;
+	gthr_size = (num_segs % MAX_SEGS_PER_SG) ? gthr_size + 1 : gthr_size;
+
+	gthr_size &= 0xF;
+	dptr_iova = (sq->sqe_ring->iova + (sq->head * (sq->sqe_size * 2)));
+	inst.dptr = dptr_iova | ((u64)gthr_size << 60);
+
+	/* CPT Instruction word-6 */
+	inst.rptr = inst.dptr;
+
+	/* CPT Instruction word-7 */
+	inst.cptr = sa_info->sa_iova;
+	inst.ctx_val = 1;
+	inst.egrp = CN10K_DEF_CPT_IPSEC_EGRP;
+
+	/* CPT Instruction word-0 */
+	inst.nixtxl = (size / 16) - 1;
+	inst.dat_offset = ETH_HLEN;
+	inst.nixtx_offset = sq->sqe_size;
+
+	netdev_tx_sent_queue(txq, skb->len);
+
+	/* Finally Flush the CPT instruction */
+	sq->head++;
+	sq->head &= (sq->sqe_cnt - 1);
+	cn10k_cpt_inst_flush(pf, &inst, sizeof(struct cpt_inst_s));
+	return true;
+drop:
+	dev_kfree_skb_any(skb);
+	return false;
+}
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h
index 00c0cfd9b698..f6c0cf6c86e0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h
@@ -56,6 +56,7 @@
 /* IPSEC Instruction opcodes */
 #define CN10K_IPSEC_MAJOR_OP_WRITE_SA 0x01UL
 #define CN10K_IPSEC_MINOR_OP_WRITE_SA 0x09UL
+#define CN10K_IPSEC_MAJOR_OP_OUTB_IPSEC 0x28UL
 
 enum cn10k_cpt_comp_e {
 	CN10K_CPT_COMP_E_NOTDONE = 0x00,
@@ -133,6 +134,16 @@ struct cn10k_tx_sa_s {
 	u64 hw_ctx[6];		/* W31 - W36 */
 };
 
+/* CPT instruction parameter-1 */
+#define CN10K_IPSEC_INST_PARAM1_DIS_L4_CSUM		0x1
+#define CN10K_IPSEC_INST_PARAM1_DIS_L3_CSUM		0x2
+#define CN10K_IPSEC_INST_PARAM1_CRYPTO_MODE		0x20
+#define CN10K_IPSEC_INST_PARAM1_IV_OFFSET_SHIFT		8
+
+/* CPT instruction parameter-2 */
+#define CN10K_IPSEC_INST_PARAM2_ENC_DATA_OFFSET_SHIFT	0
+#define CN10K_IPSEC_INST_PARAM2_AUTH_DATA_OFFSET_SHIFT	8
+
 /* CPT Instruction Structure */
 struct cpt_inst_s {
 	u64 nixtxl		: 3; /* W0 */
@@ -177,6 +188,15 @@ struct cpt_ctx_info_s {
 	dma_addr_t sa_iova;
 };
 
+/* CPT SG structure */
+struct cpt_sg_s {
+	u64 seg1_size	: 16;
+	u64 seg2_size	: 16;
+	u64 seg3_size	: 16;
+	u64 segs	: 2;
+	u64 rsvd_63_50	: 14;
+};
+
 /* CPT LF_INPROG Register */
 #define CPT_LF_INPROG_INFLIGHT	GENMASK_ULL(8, 0)
 #define CPT_LF_INPROG_GRB_CNT	GENMASK_ULL(39, 32)
@@ -199,6 +219,11 @@ struct cpt_ctx_info_s {
 int cn10k_ipsec_init(struct net_device *netdev);
 void cn10k_ipsec_clean(struct otx2_nic *pf);
 int cn10k_ipsec_ethtool_init(struct net_device *netdev, bool enable);
+bool otx2_sqe_add_sg_ipsec(struct otx2_nic *pfvf, struct otx2_snd_queue *sq,
+			   struct sk_buff *skb, int num_segs, int *offset);
+bool cn10k_ipsec_transmit(struct otx2_nic *pf, struct netdev_queue *txq,
+			  struct otx2_snd_queue *sq, struct sk_buff *skb,
+			  int num_segs, int size);
 #else
 static __maybe_unused int cn10k_ipsec_init(struct net_device *netdev)
 {
@@ -214,5 +239,20 @@ int cn10k_ipsec_ethtool_init(struct net_device *netdev, bool enable)
 {
 	return 0;
 }
+
+static __maybe_unused
+bool otx2_sqe_add_sg_ipsec(struct otx2_nic *pfvf, struct otx2_snd_queue *sq,
+			   struct sk_buff *skb, int num_segs, int *offset)
+{
+	return true;
+}
+
+static __maybe_unused
+bool cn10k_ipsec_transmit(struct otx2_nic *pf, struct netdev_queue *txq,
+			  struct otx2_snd_queue *sq, struct sk_buff *skb,
+			  int num_segs, int size)
+{
+	return true;
+}
 #endif
 #endif // CN10K_IPSEC_H
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index e9d2e039a322..eaa318012162 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -936,6 +936,29 @@ int otx2_sq_init(struct otx2_nic *pfvf, u16 qidx, u16 sqb_aura)
 	if (err)
 		return err;
 
+	/* Allocate memory for NIX SQE (which includes NIX SG) and CPT SG.
+	 * SG of NIX and CPT are same in size. Allocate memory for CPT SG
+	 * same as NIX SQE for base address alignment.
+	 * Layout of a NIX SQE and CPT SG entry:
+	 *      -----------------------------
+	 *     |     CPT Scatter Gather      |
+	 *     |       (SQE SIZE)            |
+	 *     |                             |
+	 *      -----------------------------
+	 *     |       NIX SQE               |
+	 *     |       (SQE SIZE)            |
+	 *     |                             |
+	 *      -----------------------------
+	 */
+	err = qmem_alloc(pfvf->dev, &sq->sqe_ring, qset->sqe_cnt,
+			 sq->sqe_size * 2);
+	if (err)
+		return err;
+
+	err = qmem_alloc(pfvf->dev, &sq->cpt_resp, qset->sqe_cnt, 64);
+	if (err)
+		return err;
+
 	if (qidx < pfvf->hw.tx_queues) {
 		err = qmem_alloc(pfvf->dev, &sq->tso_hdrs, qset->sqe_cnt,
 				 TSO_HEADER_SIZE);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 859bbc78e653..9471ee572625 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -54,6 +54,9 @@
 #define NIX_PF_PFC_PRIO_MAX			8
 #endif
 
+/* Number of segments per SG structure */
+#define MAX_SEGS_PER_SG 3
+
 enum arua_mapped_qtypes {
 	AURA_NIX_RQ,
 	AURA_NIX_SQ,
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index a7e17d870420..bc34074454b3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -1444,6 +1444,8 @@ static void otx2_free_sq_res(struct otx2_nic *pf)
 		if (!sq->sqe)
 			continue;
 		qmem_free(pf->dev, sq->sqe);
+		qmem_free(pf->dev, sq->sqe_ring);
+		qmem_free(pf->dev, sq->cpt_resp);
 		qmem_free(pf->dev, sq->tso_hdrs);
 		kfree(sq->sg);
 		kfree(sq->sqb_ptrs);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index f368eac28fdd..b0e1524ea4bd 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -11,6 +11,7 @@
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
 #include <net/ip6_checksum.h>
+#include <net/xfrm.h>
 
 #include "otx2_reg.h"
 #include "otx2_common.h"
@@ -32,6 +33,16 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 				     struct otx2_cq_queue *cq,
 				     bool *need_xdp_flush);
 
+static void otx2_sq_set_sqe_base(struct otx2_snd_queue *sq,
+				 struct sk_buff *skb)
+{
+	if (unlikely(xfrm_offload(skb)))
+		sq->sqe_base = sq->sqe_ring->base + sq->sqe_size +
+				(sq->head * (sq->sqe_size * 2));
+	else
+		sq->sqe_base = sq->sqe->base;
+}
+
 static int otx2_nix_cq_op_status(struct otx2_nic *pfvf,
 				 struct otx2_cq_queue *cq)
 {
@@ -580,7 +591,6 @@ void otx2_sqe_flush(void *dev, struct otx2_snd_queue *sq,
 	sq->head &= (sq->sqe_cnt - 1);
 }
 
-#define MAX_SEGS_PER_SG	3
 /* Add SQE scatter/gather subdescriptor structure */
 static bool otx2_sqe_add_sg(struct otx2_nic *pfvf, struct otx2_snd_queue *sq,
 			    struct sk_buff *skb, int num_segs, int *offset)
@@ -1116,6 +1126,11 @@ bool otx2_sq_append_skb(struct net_device *netdev, struct otx2_snd_queue *sq,
 	struct otx2_nic *pfvf = netdev_priv(netdev);
 	int offset, num_segs, free_desc;
 	struct nix_sqe_hdr_s *sqe_hdr;
+	int ipsec = 0;
+	bool ret;
+
+	if (unlikely(xfrm_offload(skb)))
+		ipsec = 1;
 
 	/* Check if there is enough room between producer
 	 * and consumer index.
@@ -1132,6 +1147,7 @@ bool otx2_sq_append_skb(struct net_device *netdev, struct otx2_snd_queue *sq,
 	/* If SKB doesn't fit in a single SQE, linearize it.
 	 * TODO: Consider adding JUMP descriptor instead.
 	 */
+
 	if (unlikely(num_segs > OTX2_MAX_FRAGS_IN_SQE)) {
 		if (__skb_linearize(skb)) {
 			dev_kfree_skb_any(skb);
@@ -1148,6 +1164,9 @@ bool otx2_sq_append_skb(struct net_device *netdev, struct otx2_snd_queue *sq,
 		return true;
 	}
 
+	/* Set sqe base address */
+	otx2_sq_set_sqe_base(sq, skb);
+
 	/* Set SQE's SEND_HDR.
 	 * Do not clear the first 64bit as it contains constant info.
 	 */
@@ -1160,7 +1179,12 @@ bool otx2_sq_append_skb(struct net_device *netdev, struct otx2_snd_queue *sq,
 	otx2_sqe_add_ext(pfvf, sq, skb, &offset);
 
 	/* Add SG subdesc with data frags */
-	if (!otx2_sqe_add_sg(pfvf, sq, skb, num_segs, &offset)) {
+	if (unlikely(ipsec))
+		ret = otx2_sqe_add_sg_ipsec(pfvf, sq, skb, num_segs, &offset);
+	else
+		ret = otx2_sqe_add_sg(pfvf, sq, skb, num_segs, &offset);
+
+	if (!ret) {
 		otx2_dma_unmap_skb_frags(pfvf, &sq->sg[sq->head]);
 		return false;
 	}
@@ -1169,11 +1193,14 @@ bool otx2_sq_append_skb(struct net_device *netdev, struct otx2_snd_queue *sq,
 
 	sqe_hdr->sizem1 = (offset / 16) - 1;
 
+	if (unlikely(ipsec))
+		return cn10k_ipsec_transmit(pfvf, txq, sq, skb, num_segs,
+					    offset);
+
 	netdev_tx_sent_queue(txq, skb->len);
 
 	/* Flush SQE to HW */
 	pfvf->hw_ops->sqe_flush(pfvf, sq, offset, qidx);
-
 	return true;
 }
 EXPORT_SYMBOL(otx2_sq_append_skb);
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
index 3f1d2655ff77..248fd78ef0e9 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.h
@@ -101,6 +101,9 @@ struct otx2_snd_queue {
 	struct queue_stats	stats;
 	u16			sqb_count;
 	u64			*sqb_ptrs;
+	/* SQE ring and CPT response queue for Inline IPSEC */
+	struct qmem		*sqe_ring;
+	struct qmem		*cpt_resp;
 } ____cacheline_aligned_in_smp;
 
 enum cq_type {
-- 
2.34.1


