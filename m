Return-Path: <netdev+bounces-206144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2056B01BB4
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 14:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA8921CA689D
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 12:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249612BEC31;
	Fri, 11 Jul 2025 12:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="UufDlM4j"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D59291880;
	Fri, 11 Jul 2025 12:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752236054; cv=none; b=g5pMIHl09uOGMVBtPFPGD/oW2zrkAiZ7I0DKZHMmxq6kzJ0PifO5I4hvE9tVGGSHrbkIA5P1MFPMVdSm6X/p/Jp8YnBVhh32xiMDdeJVaII0W5UzWGM9PmbbUquYaExL1kL1v8h/TQM1lh1PRV0wwbCaU+IskPbgbIzFsZxNknk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752236054; c=relaxed/simple;
	bh=FAuXKvgxx2avV/MzFYRQ8dHPe6YZl1NzZP3vkWXnPl0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bUFU9RW6c783sn/Xe/U3tOaRfEiiHXmBvUWcg1qi9Vd03nqXQM9ym0H1pFbcHipdwhqt8fnzev23+yNDsDtLqB8hlR7qYKz1hbCFzz8JfIhgrt5wtfrJSk2rtRVgx2tsfqkhaTJ1r0dyRY+Z9q1fL7U81Wq84Cy/TFsWgAUSYVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=UufDlM4j; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B7pgIT013966;
	Fri, 11 Jul 2025 05:14:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=i
	5twiUG+Sa7VEFBvqnTtUq6ZCtb42zSSEQkyBP6wbEs=; b=UufDlM4j5XKSaK+4x
	iLEwrEOHHeuBn1Tcb0kja7Cj1STL2bLuKbpDo34AE4sQAKko6n0f/NFoQ03ufH3Q
	Nx2n8hFVwM85dTXiYesOaxrHjUz/HxAWQ7cgti8Utv6b1KCjOWAfjRJ5pOGDzIu/
	hVXZ//CdF5GHnjKeEJoue0khKQQBvqqXG9cUdh/imi+oaMiTnRXVxtY2mtIQD7y2
	8r3aZ3t2isOE3EKaQLIjQ5e2Xe8ABDbeMdvFbHC80t7tl3xoy5AB86+At86ZU9sh
	n1/wW49ysXctYn4+hS8q52YtO0u+udR/fGNSO73ChQIgvHLsjD2Ek7zDtkS2tHif
	aH+GA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47txkg8dck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 05:14:08 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 11 Jul 2025 05:14:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 11 Jul 2025 05:14:07 -0700
Received: from optiplex.marvell.com (unknown [10.28.34.253])
	by maili.marvell.com (Postfix) with ESMTP id 08BAD3F7058;
	Fri, 11 Jul 2025 05:14:03 -0700 (PDT)
From: Tanmay Jagdale <tanmay@marvell.com>
To: <davem@davemloft.net>, <leon@kernel.org>, <horms@kernel.org>,
        <herbert@gondor.apana.org.au>, <sgoutham@marvell.com>,
        <bbhushan2@marvell.com>
CC: <linux-crypto@vger.kernel.org>, <netdev@vger.kernel.org>,
        Tanmay Jagdale
	<tanmay@marvell.com>
Subject: [PATCH net-next v3 08/14] octeontx2-pf: ipsec: Allocate Ingress SA table
Date: Fri, 11 Jul 2025 17:43:01 +0530
Message-ID: <20250711121317.340326-9-tanmay@marvell.com>
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
X-Proofpoint-GUID: Sq35kwInILDMW0pEvqVv1pwKvCzNiFeL
X-Proofpoint-ORIG-GUID: Sq35kwInILDMW0pEvqVv1pwKvCzNiFeL
X-Authority-Analysis: v=2.4 cv=OP0n3TaB c=1 sm=1 tr=0 ts=68710010 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=941-y9MuI4qzQJ12ibkA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA4NiBTYWx0ZWRfX2GeKyoRgd7nW xyjJ6MoJhdwpKI+cfjsMJPd/lX33cZzc9B0sOLT7iOlz8Y0jieXuU3Ip0P2QNOPYNY1hOBnucoI 9D/mhSUczRdwu3XlTZuP0uAKEObpBoQqh5LEa2KLHNn1qFQqQFHcHHP5QOn5wHlyhUwp7F4NZeC
 WHtIUhPzWc9p4s2NsPmclS9p4hmJQ2k39n6eA3y36HdMe+RXW/+zvyAJH5J00RMKdgbaA1R1q1Y jZbw5rPjri5cpQ4eZfZHDDGqNn1WUsANlvTUpRUc0DlZ2DEcv3NjiZGqO9b5TPabDTnAmRM9uwB e34BK6ojsarMTfg735mxiedPJ595blh5nDkmiyu9AsJV+9sa2nyFjdRfM1sBcd0ThznA8po8Kg8
 p+8vhvDMZ/oha3WwZ8TXU9qCLaxFqqzmPOP79n0LxtvWqd5N9nD0np0AWTo5gZXJe/rr9vod
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01

Every NIX LF has the facility to maintain a contiguous SA table that
is used by NIX RX to find the exact SA context pointer associated with
a particular flow. Allocate a 128-entry SA table where each entry is of
2048 bytes which is enough to hold the complete inbound SA context.

Add the structure definitions for SA context (cn10k_rx_sa_s) and
SA bookkeeping information (ctx_inb_ctx_info).

Also, initialize the inb_sw_ctx_list to track all the SA's and their
associated NPC rules and hash table related data.

Signed-off-by: Tanmay Jagdale <tanmay@marvell.com>
---
Changes in V3:
- None

Changes in V2:
- None

V1 Link: https://lore.kernel.org/netdev/20250502132005.611698-10-tanmay@marvell.com/
V2 Link: https://lore.kernel.org/netdev/20250618113020.130888-9-tanmay@marvell.com/

 .../marvell/octeontx2/nic/cn10k_ipsec.c       | 20 ++++
 .../marvell/octeontx2/nic/cn10k_ipsec.h       | 93 +++++++++++++++++++
 2 files changed, 113 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
index c691f0722154..ae2aa0b73e96 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.c
@@ -787,6 +787,7 @@ int cn10k_ipsec_init(struct net_device *netdev)
 {
 	struct otx2_nic *pf = netdev_priv(netdev);
 	u32 sa_size;
+	int err;
 
 	if (!is_dev_support_ipsec_offload(pf->pdev))
 		return 0;
@@ -797,6 +798,22 @@ int cn10k_ipsec_init(struct net_device *netdev)
 			 OTX2_ALIGN : sizeof(struct cn10k_tx_sa_s);
 	pf->ipsec.sa_size = sa_size;
 
+	/* Set sa_tbl_entry_sz to 2048 since we are programming NIX RX
+	 * to calculate SA index as SPI * 2048. The first 1024 bytes
+	 * are used for SA context and  the next half for bookkeeping data.
+	 */
+	pf->ipsec.sa_tbl_entry_sz = 2048;
+	err = qmem_alloc(pf->dev, &pf->ipsec.inb_sa, CN10K_IPSEC_INB_MAX_SA,
+			 pf->ipsec.sa_tbl_entry_sz);
+	if (err)
+		return err;
+
+	memset(pf->ipsec.inb_sa->base, 0,
+	       pf->ipsec.sa_tbl_entry_sz * CN10K_IPSEC_INB_MAX_SA);
+
+	/* List to track all ingress SAs */
+	INIT_LIST_HEAD(&pf->ipsec.inb_sw_ctx_list);
+
 	INIT_WORK(&pf->ipsec.sa_work, cn10k_ipsec_sa_wq_handler);
 	pf->ipsec.sa_workq = alloc_workqueue("cn10k_ipsec_sa_workq", 0, 0);
 	if (!pf->ipsec.sa_workq) {
@@ -828,6 +845,9 @@ void cn10k_ipsec_clean(struct otx2_nic *pf)
 	}
 
 	cn10k_outb_cpt_clean(pf);
+
+	/* Free Ingress SA table */
+	qmem_free(pf->dev, pf->ipsec.inb_sa);
 }
 EXPORT_SYMBOL(cn10k_ipsec_clean);
 
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h
index 43fbce0d6039..7ffbbedf26d5 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_ipsec.h
@@ -52,10 +52,14 @@ DECLARE_STATIC_KEY_FALSE(cn10k_ipsec_sa_enabled);
 #define CN10K_CPT_LF_NQX(a)		(CPT_LFBASE | 0x400 | (a) << 3)
 #define CN10K_CPT_LF_CTX_FLUSH		(CPT_LFBASE | 0x510)
 
+/* Inbound SA*/
+#define CN10K_IPSEC_INB_MAX_SA	128
+
 /* IPSEC Instruction opcodes */
 #define CN10K_IPSEC_MAJOR_OP_WRITE_SA 0x01UL
 #define CN10K_IPSEC_MINOR_OP_WRITE_SA 0x09UL
 #define CN10K_IPSEC_MAJOR_OP_OUTB_IPSEC 0x2AUL
+#define CN10K_IPSEC_MAJOR_OP_INB_IPSEC 0x29UL
 
 enum cn10k_cpt_comp_e {
 	CN10K_CPT_COMP_E_NOTDONE = 0x00,
@@ -81,6 +85,19 @@ enum cn10k_cpt_hw_state_e {
 	CN10K_CPT_HW_IN_USE
 };
 
+struct cn10k_inb_sw_ctx_info {
+	struct list_head list;
+	struct cn10k_rx_sa_s *sa_entry;
+	struct xfrm_state *x_state;
+	dma_addr_t sa_iova;
+	u32 npc_mcam_entry;
+	u32 sa_index;
+	__be32 spi;
+	u16 hash_index;	/* Hash index from SPI_TO_SA match */
+	u8 way;		/* SPI_TO_SA match table way index */
+	bool delete_npc_and_match_entry;
+};
+
 struct cn10k_ipsec {
 	/* Outbound CPT */
 	u64 io_addr;
@@ -92,6 +109,12 @@ struct cn10k_ipsec {
 	u32 outb_sa_count;
 	struct work_struct sa_work;
 	struct workqueue_struct *sa_workq;
+
+	/* For Inbound Inline IPSec flows */
+	u32 sa_tbl_entry_sz;
+	struct qmem *inb_sa;
+	struct list_head inb_sw_ctx_list;
+	DECLARE_BITMAP(inb_sa_table, CN10K_IPSEC_INB_MAX_SA);
 };
 
 /* CN10K IPSEC Security Association (SA) */
@@ -146,6 +169,76 @@ struct cn10k_tx_sa_s {
 	u64 hw_ctx[6];		/* W31 - W36 */
 };
 
+struct cn10k_rx_sa_s {
+	u64 inb_ar_win_sz	: 3; /* W0 */
+	u64 hard_life_dec	: 1;
+	u64 soft_life_dec	: 1;
+	u64 count_glb_octets	: 1;
+	u64 count_glb_pkts	: 1;
+	u64 count_mib_bytes	: 1;
+	u64 count_mib_pkts	: 1;
+	u64 hw_ctx_off		: 7;
+	u64 ctx_id		: 16;
+	u64 orig_pkt_fabs	: 1;
+	u64 orig_pkt_free	: 1;
+	u64 pkind		: 6;
+	u64 rsvd_w0_40		: 1;
+	u64 eth_ovrwr		: 1;
+	u64 pkt_output		: 2;
+	u64 pkt_format		: 1;
+	u64 defrag_opt		: 2;
+	u64 x2p_dst		: 1;
+	u64 ctx_push_size	: 7;
+	u64 rsvd_w0_55		: 1;
+	u64 ctx_hdr_size	: 2;
+	u64 aop_valid		: 1;
+	u64 rsvd_w0_59		: 1;
+	u64 ctx_size		: 4;
+
+	u64 rsvd_w1_31_0	: 32; /* W1 */
+	u64 cookie		: 32;
+
+	u64 sa_valid		: 1; /* W2 Control Word */
+	u64 sa_dir		: 1;
+	u64 rsvd_w2_2_3		: 2;
+	u64 ipsec_mode		: 1;
+	u64 ipsec_protocol	: 1;
+	u64 aes_key_len		: 2;
+	u64 enc_type		: 3;
+	u64 life_unit		: 1;
+	u64 auth_type		: 4;
+	u64 encap_type		: 2;
+	u64 et_ovrwr_ddr_en	: 1;
+	u64 esn_en		: 1;
+	u64 tport_l4_incr_csum	: 1;
+	u64 iphdr_verify	: 2;
+	u64 udp_ports_verify	: 1;
+	u64 l2_l3_hdr_on_error	: 1;
+	u64 rsvd_w25_31		: 7;
+	u64 spi			: 32;
+
+	u64 w3;			/* W3 */
+
+	u8 cipher_key[32];	/* W4 - W7 */
+	u32 rsvd_w8_0_31;	/* W8 : IV */
+	u32 iv_gcm_salt;
+	u64 rsvd_w9;		/* W9 */
+	u64 rsvd_w10;		/* W10 : UDP Encap */
+	u32 dest_ipaddr;	/* W11 - Tunnel mode: outer src and dest ipaddr */
+	u32 src_ipaddr;
+	u64 rsvd_w12_w30[19];	/* W12 - W30 */
+
+	u64 ar_base;		/* W31 */
+	u64 ar_valid_mask;	/* W32 */
+	u64 hard_sa_life;	/* W33 */
+	u64 soft_sa_life;	/* W34 */
+	u64 mib_octs;		/* W35 */
+	u64 mib_pkts;		/* W36 */
+	u64 ar_winbits;		/* W37 */
+
+	u64 rsvd_w38_w100[63];
+};
+
 /* CPT instruction parameter-1 */
 #define CN10K_IPSEC_INST_PARAM1_DIS_L4_CSUM		0x1
 #define CN10K_IPSEC_INST_PARAM1_DIS_L3_CSUM		0x2
-- 
2.43.0


