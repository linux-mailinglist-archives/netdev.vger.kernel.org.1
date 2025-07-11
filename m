Return-Path: <netdev+bounces-206148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3636FB01BBC
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 14:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76684767E30
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 12:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025AB29A32A;
	Fri, 11 Jul 2025 12:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="cEKS1v/p"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFBD2C08DF;
	Fri, 11 Jul 2025 12:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752236067; cv=none; b=HdlyJWj1Ft+ggAfyy3vZnv+E4HpQXCP8GaRlFtGMD6ypD4WfCUe0/BNmiIhGbgJEvLM1mzHMIpylRJ31DrnB0h6A7Iqs9kbuPO4/rUgXjYgtXg9UIYnhp/ak0k9YLfyONrZKehNaENi6IPhhZHMIC5AsK4RWJ+hoSiOc65Absw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752236067; c=relaxed/simple;
	bh=3yVM27eih8TXgalSZLk1pzAMRbcq4uA7w5PoD1BYAUw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qUesQgY/ZNDEn65/1Io0wnyz0Vav8iLjbAp5wwBgVuzAFQa1wz2wbFK7wsPfAkZ5P8nKuQNjYsKgwdUKQoDczSUaFjBruGT3n0HMEHkZm7EJ/h9QjRgDS+T6MYiJIt6/8fYKKBzYRAx92MUBF4JRDajxNP4JT7xSGwH79WSPm7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=cEKS1v/p; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BBYQsP006382;
	Fri, 11 Jul 2025 05:14:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=t
	uYj1Y5h338JYIuzW9NBSIQ8qZq2Fzxy4VwjkE9Eb9Q=; b=cEKS1v/plXw/HCmRx
	CJFLh45OOFmGHYhlTy4esUxhDA6mQ9Zl8kSSCJsoAfBk9Q9aNS3wtErMLzI0a4YT
	dfJI6g2O5dyW5s7Cm05G6o238WjY/cSpfmNe1gnh2nytUZp6Ai+Km/Q1c4o7cM2g
	6ppxQpKVZwB369QCsVl/MUozh+yuExMJ2qVEVHGw0Z+IWSsPlDfHhPsL+nXVPq4S
	X1MsOJSXTI3bxIKieRp9bOLl+jQfjBd/rEAUjy/VgTT+mLJGzHcn4NlijQCMyNdn
	qDcdy9P+yGHEIBftqdu5QIaeiyDlPrfe+db4CGtA9c4ALMyWTIOcDHvRUUbNPZl1
	B4FBQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47typ6g8pu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 05:14:21 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 11 Jul 2025 05:14:20 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 11 Jul 2025 05:14:20 -0700
Received: from optiplex.marvell.com (unknown [10.28.34.253])
	by maili.marvell.com (Postfix) with ESMTP id 3C7BC3F7058;
	Fri, 11 Jul 2025 05:14:16 -0700 (PDT)
From: Tanmay Jagdale <tanmay@marvell.com>
To: <davem@davemloft.net>, <leon@kernel.org>, <horms@kernel.org>,
        <herbert@gondor.apana.org.au>, <sgoutham@marvell.com>,
        <bbhushan2@marvell.com>
CC: <linux-crypto@vger.kernel.org>, <netdev@vger.kernel.org>,
        Tanmay Jagdale
	<tanmay@marvell.com>
Subject: [PATCH net-next v3 12/14] octeontx2-pf: ipsec: Process CPT metapackets
Date: Fri, 11 Jul 2025 17:43:05 +0530
Message-ID: <20250711121317.340326-13-tanmay@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711121317.340326-1-tanmay@marvell.com>
References: <20250711121317.340326-1-tanmay@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA4NiBTYWx0ZWRfX+6wQTcDLSNpN 4QbDwg25QaY/i6ySypBY6EakQ6jbRlSnwKIdRKRxD/V5ER7d8jTTsN7DFJDZ/b/XgqC+UXMWpJF s6qozMir7EDldMKu0aheQb9ii1ywpZ4QCDYL5S0k6GPqXMb7+kDtEMzZlieTbaY4k/sv6ZpR0cj
 3q+09b/0/8yXANDvEsf3PL/XHYaN5dNUG057ZZDJfzQDLzMRybxGJfNpOS4AEuHBtqnLFSp9+GE CK/U0uXFMYolUonxXo9PB8VsXU960nMx0soaaNpQ2NHMb8SMvvtRiErmhMyKkF4k1Z+j0tNnCTT ICuNVN4ukmhqEz7Dc+z+zs40mUsf9ejSNBiPZx17fyEqW9uEDKqO7EgAmcU78r7rkbsvCgUKwHP
 Yye/Xf50kr2Oa0s3syISapTFJAPdr86tXLxcQpQ/wN6GE2d7lYWV0F6n5xGMIuSLFyd7hva3
X-Authority-Analysis: v=2.4 cv=aPLwqa9m c=1 sm=1 tr=0 ts=6871001d cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=2V_QfZprvCi1FviU9xwA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: ZrRVuX_ZNA_ha7MmKcf2LQwyrHoat1jK
X-Proofpoint-GUID: ZrRVuX_ZNA_ha7MmKcf2LQwyrHoat1jK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01

CPT hardware forwards decrypted IPsec packets to NIX via the X2P bus
as metapackets which are of 256 bytes in length. Each metapacket
contains CPT_PARSE_HDR_S and initial bytes of the decrypted packet
that helps NIX RX in classifying and submitting to CPU. Additionally,
CPT also sets BIT(11) of the channel number to indicate that it's a
2nd pass packet from CPT.

Since the metapackets are not complete packets, they don't have to go
through L3/L4 layer length and checksum verification so these are
disabled via the NIX_LF_INLINE_RQ_CFG mailbox during IPsec initialization.

The CPT_PARSE_HDR_S contains a WQE pointer to the complete decrypted
packet. Add code in the rx NAPI handler to parse the header and extract
WQE pointer. Later, use this WQE pointer to construct the skb, set the
XFRM packet mode flags to indicate successful decryption before submitting
it to the network stack.

Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
---
Changes in V3:
- Updated cpt_parse_hdr_s structure to use __be64 type

Changes in V2:
- Removed unnecessary casts
- Don't convert complete cpt_parse_hdr from BE to LE and just
  convert required fields
- Fixed logic to avoid repeated calculation for start and end in sg

V1 Link: https://lore.kernel.org/netdev/20250502132005.611698-15-tanmay@marvell.com/
V2 Link: https://lore.kernel.org/netdev/20250618113020.130888-13-tanmay@marvell.com/

 .../marvell/octeontx2/nic/cn10k_ipsec.c       | 46 +++++++++++++++++++
 .../marvell/octeontx2/nic/cn10k_ipsec.h       | 46 +++++++++++++++++++
 .../marvell/octeontx2/nic/otx2_struct.h       | 16 +++++++
 .../marvell/octeontx2/nic/otx2_txrx.c         | 27 ++++++++++-
 4 files changed, 134 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
index 1edc38a8bd29..4ee5395a95f8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
@@ -346,6 +346,52 @@ static int cn10k_outb_cpt_init(struct net_device *netdev)
 	return ret;
 }
 
+struct nix_wqe_rx_s *cn10k_ipsec_process_cpt_metapkt(struct otx2_nic *pfvf,
+						     struct sk_buff *skb,
+						     dma_addr_t seg_addr)
+{
+	struct nix_wqe_rx_s *wqe = NULL;
+	struct cpt_parse_hdr_s *cptp;
+	struct xfrm_offload *xo;
+	struct xfrm_state *xs;
+	struct sec_path *sp;
+	u64 *sa_ptr;
+
+	/* CPT_PARSE_HDR_S is present in the beginning of the buffer */
+	cptp = phys_to_virt(otx2_iova_to_phys(pfvf->iommu_domain, seg_addr));
+
+	/* Convert the wqe_ptr from CPT_PARSE_HDR_S to a CPU usable pointer */
+	wqe = phys_to_virt(otx2_iova_to_phys(pfvf->iommu_domain,
+					     be64_to_cpu(cptp->wqe_ptr)));
+
+	/* Get the XFRM state pointer stored in SA context */
+	sa_ptr = pfvf->ipsec.inb_sa->base + 1024 +
+		 (be32_to_cpu(cptp->cookie) * pfvf->ipsec.sa_tbl_entry_sz);
+	xs = (struct xfrm_state *)*sa_ptr;
+
+	/* Set XFRM offload status and flags for successful decryption */
+	sp = secpath_set(skb);
+	if (!sp) {
+		netdev_err(pfvf->netdev, "Failed to secpath_set\n");
+		wqe = NULL;
+		goto err_out;
+	}
+
+	rcu_read_lock();
+	xfrm_state_hold(xs);
+	rcu_read_unlock();
+
+	sp->xvec[sp->len++] = xs;
+	sp->olen++;
+
+	xo = xfrm_offload(skb);
+	xo->flags = CRYPTO_DONE;
+	xo->status = CRYPTO_SUCCESS;
+
+err_out:
+	return wqe;
+}
+
 static int cn10k_inb_nix_inline_lf_cfg(struct otx2_nic *pfvf)
 {
 	struct nix_inline_ipsec_lf_cfg *req;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h
index 80bc0e4a9da6..ecb0cd8418e0 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h
@@ -8,6 +8,7 @@
 #define CN10K_IPSEC_H
 
 #include <linux/types.h>
+#include "otx2_struct.h"
 
 DECLARE_STATIC_KEY_FALSE(cn10k_ipsec_sa_enabled);
 
@@ -302,6 +303,41 @@ struct cpt_sg_s {
 	u64 rsvd_63_50	: 14;
 };
 
+/* CPT Parse Header Structure for Inbound packets */
+struct cpt_parse_hdr_s {
+	/* Word 0 */
+	__be64 pkt_out     : 2;
+	__be64 num_frags   : 3;
+	__be64 pad_len     : 3;
+	__be64 pkt_fmt     : 1;
+	__be64 et_owr      : 1;
+	__be64 reserved_53 : 1;
+	__be64 reas_sts    : 4;
+	__be64 err_sum     : 1;
+	__be64 match_id    : 16;
+	__be64 cookie      : 32;
+
+	/* Word 1 */
+	__be64 wqe_ptr;
+
+	/* Word 2 */
+	__be64 fi_offset   : 5;
+	__be64 fi_pad      : 3;
+	__be64 il3_off     : 8;
+	__be64 pf_func     : 16;
+	__be64 res_32_16   : 16;
+	__be64 frag_age    : 16;
+
+	/* Word 3 */
+	__be64 spi         : 32;
+	__be64 res3_32_16  : 16;
+	__be64 uc_ccode    : 8;
+	__be64 hw_ccode    : 8;
+
+	/* Word 4 */
+	__be64 misc;
+};
+
 /* CPT LF_INPROG Register */
 #define CPT_LF_INPROG_INFLIGHT	GENMASK_ULL(8, 0)
 #define CPT_LF_INPROG_GRB_CNT	GENMASK_ULL(39, 32)
@@ -330,6 +366,9 @@ bool cn10k_ipsec_transmit(struct otx2_nic *pf, struct netdev_queue *txq,
 			  struct otx2_snd_queue *sq, struct sk_buff *skb,
 			  int num_segs, int size);
 void cn10k_ipsec_free_aura_ptrs(struct otx2_nic *pfvf);
+struct nix_wqe_rx_s *cn10k_ipsec_process_cpt_metapkt(struct otx2_nic *pfvf,
+						     struct sk_buff *skb,
+						     dma_addr_t seg_addr);
 #else
 static inline __maybe_unused int cn10k_ipsec_init(struct net_device *netdev)
 {
@@ -366,5 +405,12 @@ void cn10k_ipsec_free_aura_ptrs(struct otx2_nic *pfvf)
 {
 }
 
+static inline __maybe_unused
+struct nix_wqe_rx_s *cn10k_ipsec_process_cpt_metapkt(struct otx2_nic *pfvf,
+						     struct sk_buff *skb,
+						     dma_addr_t seg_addr)
+{
+	return NULL;
+}
 #endif
 #endif // CN10K_IPSEC_H
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_struct.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_struct.h
index 4e5899d8fa2e..506fab414b7e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_struct.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_struct.h
@@ -175,6 +175,22 @@ struct nix_cqe_tx_s {
 	struct nix_send_comp_s comp;
 };
 
+/* NIX WQE header structure */
+struct nix_wqe_hdr_s {
+	u64 flow_tag              : 32;
+	u64 tt                    : 2;
+	u64 reserved_34_43        : 10;
+	u64 node                  : 2;
+	u64 q                     : 14;
+	u64 wqe_type              : 4;
+};
+
+struct nix_wqe_rx_s {
+	struct nix_wqe_hdr_s	hdr;
+	struct nix_rx_parse_s	parse;
+	struct nix_rx_sg_s	sg;
+};
+
 /* NIX SQE header structure */
 struct nix_sqe_hdr_s {
 	u64 total		: 18; /* W0 */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 99ace381cc78..a1256ecb29ed 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -205,11 +205,16 @@ static bool otx2_skb_add_frag(struct otx2_nic *pfvf, struct sk_buff *skb,
 		}
 	}
 
+	if (parse->chan & 0x800)
+		off = 0;
+
 	page = virt_to_page(va);
 	if (likely(skb_shinfo(skb)->nr_frags < MAX_SKB_FRAGS)) {
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page,
 				va - page_address(page) + off,
 				len - off, pfvf->rbsize);
+		if (parse->chan & 0x800)
+			return false;
 		return true;
 	}
 
@@ -333,6 +338,8 @@ static void otx2_rcv_pkt_handler(struct otx2_nic *pfvf,
 				 struct nix_cqe_rx_s *cqe, bool *need_xdp_flush)
 {
 	struct nix_rx_parse_s *parse = &cqe->parse;
+	struct nix_wqe_rx_s *orig_pkt_wqe = NULL;
+	u32 desc_sizem1 = parse->desc_sizem1;
 	struct nix_rx_sg_s *sg = &cqe->sg;
 	struct sk_buff *skb = NULL;
 	u64 *word = (u64 *)parse;
@@ -359,8 +366,26 @@ static void otx2_rcv_pkt_handler(struct otx2_nic *pfvf,
 	if (unlikely(!skb))
 		return;
 
+	if (parse->chan & 0x800) {
+		orig_pkt_wqe = cn10k_ipsec_process_cpt_metapkt(pfvf, skb, sg->seg_addr);
+		if (!orig_pkt_wqe) {
+			netdev_err(pfvf->netdev, "Invalid WQE in CPT metapacket\n");
+			napi_free_frags(napi);
+			cq->pool_ptrs++;
+			return;
+		}
+		/* Return metapacket buffer back to pool since it's no longer needed */
+		otx2_free_rcv_seg(pfvf, cqe, cq->cq_idx);
+
+		/* Switch *sg to the orig_pkt_wqe's *sg which has the actual
+		 * complete decrypted packet by CPT.
+		 */
+		sg = &orig_pkt_wqe->sg;
+		desc_sizem1 = orig_pkt_wqe->parse.desc_sizem1;
+	}
+
 	start = (void *)sg;
-	end = start + ((cqe->parse.desc_sizem1 + 1) * 16);
+	end = start + ((desc_sizem1 + 1) * 16);
 	while (start < end) {
 		sg = (struct nix_rx_sg_s *)start;
 		seg_addr = &sg->seg_addr;
-- 
2.43.0


