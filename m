Return-Path: <netdev+bounces-53127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3BA8016A8
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 23:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2534B20B06
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 22:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC7A619DB;
	Fri,  1 Dec 2023 22:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LRyo+HQt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C36D54
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 14:40:02 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-67a99dbb21fso6239896d6.0
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 14:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701470402; x=1702075202; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=l3Z4SKdK0KfjS0ZnVOmxzo/8kntDZMb9ALk65Hxh9Gg=;
        b=LRyo+HQt4828b9b84tU5vILdVnT0cukR4dJa+3dX/LBJWWJ8Zo3k5kFrqDt+CDUhzE
         +GIAgdj43+PNDxMiR3GKc+/BoGf8GYw6z6IOc2eDrcxd78TYIpF0r3s8oYS28PqcVWfW
         687apmEWF4TO32SVvLNlIk2/6TAJu4QCB3lCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701470402; x=1702075202;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l3Z4SKdK0KfjS0ZnVOmxzo/8kntDZMb9ALk65Hxh9Gg=;
        b=HY3oawYALSapXLlzeo72OZsBwBIXsJKGg3o173ikfuScGA2GebLrVjxCcupXZnzpIw
         iGGfynap2BbuyyjXnjG/ucfVd1hpyRSFohnvvBZNkHSh9lLz6uhaoqlHEbUfWag/IqTe
         yLAM/D9LbJ65l6IZ00re+3ytOgTauZNF/IboW7Exrfy4ETPRffTVFn8YDum84h60b5tz
         LwnXyM65HdEEStYxty3xaGQjDM9siUsxFVKMWbmj7fig927U/pXkLC/TUWL+x60gRTPg
         Grg5U3oao1VxXtarZUv57JfpYQrbR2SmUUfV4DXdZlW7OT/g4nBkCLiDqK5bZXpiAtkJ
         pFLQ==
X-Gm-Message-State: AOJu0YxEebx61UXBQbYS+Rv/MIdT6TidubxjwntCI5l12x9ECEDqvt/h
	vuWX0Ni9N87Gvq4E74LsedXCXg==
X-Google-Smtp-Source: AGHT+IHa/gR9QibubSgB+dLPvqYNRuwdhI6PQ8hXbGebfRAG0p0VRZDZ+dqXcDJTR1G9dHmVtOGRwA==
X-Received: by 2002:ad4:4c05:0:b0:67a:a721:784b with SMTP id bz5-20020ad44c05000000b0067aa721784bmr197553qvb.112.1701470401763;
        Fri, 01 Dec 2023 14:40:01 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id i14-20020ac8488e000000b004199c98f87dsm1878715qtq.74.2023.12.01.14.40.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Dec 2023 14:40:01 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com
Subject: [PATCH net-next 10/15] bnxt_en: Add support for new RX and TPA_START completion types for P7
Date: Fri,  1 Dec 2023 14:39:19 -0800
Message-Id: <20231201223924.26955-11-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231201223924.26955-1-michael.chan@broadcom.com>
References: <20231201223924.26955-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ec1401060b7a7245"

--000000000000ec1401060b7a7245
Content-Transfer-Encoding: 8bit

These new completion types are supported on the new P7 chips.
These new types have commonalities with the legacy types.  After
the refactoring, we mainly have to add new functions to handle the
the new meta data formats and the RX hash information in the new
types.

Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 109 ++++++++++++++----
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |   3 +-
 2 files changed, 89 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index be016a2a9aac..3b0ced2a5f32 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1329,6 +1329,23 @@ static void bnxt_tpa_metadata(struct bnxt_tpa_info *tpa_info,
 	}
 }
 
+static void bnxt_tpa_metadata_v2(struct bnxt_tpa_info *tpa_info,
+				 struct rx_tpa_start_cmp *tpa_start,
+				 struct rx_tpa_start_cmp_ext *tpa_start1)
+{
+	tpa_info->vlan_valid = 0;
+	if (TPA_START_VLAN_VALID(tpa_start)) {
+		u32 tpid_sel = TPA_START_VLAN_TPID_SEL(tpa_start);
+		u32 vlan_proto = ETH_P_8021Q;
+
+		tpa_info->vlan_valid = 1;
+		if (tpid_sel == RX_TPA_START_METADATA1_TPID_8021AD)
+			vlan_proto = ETH_P_8021AD;
+		tpa_info->metadata = vlan_proto << 16 |
+				     TPA_START_METADATA0_TCI(tpa_start1);
+	}
+}
+
 static void bnxt_tpa_start(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 			   u8 cmp_type, struct rx_tpa_start_cmp *tpa_start,
 			   struct rx_tpa_start_cmp_ext *tpa_start1)
@@ -1378,12 +1395,13 @@ static void bnxt_tpa_start(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 		le32_to_cpu(tpa_start->rx_tpa_start_cmp_len_flags_type) >>
 				RX_TPA_START_CMP_LEN_SHIFT;
 	if (likely(TPA_START_HASH_VALID(tpa_start))) {
-		u32 hash_type = TPA_START_HASH_TYPE(tpa_start);
-
 		tpa_info->hash_type = PKT_HASH_TYPE_L4;
 		tpa_info->gso_type = SKB_GSO_TCPV4;
+		if (TPA_START_IS_IPV6(tpa_start1))
+			tpa_info->gso_type = SKB_GSO_TCPV6;
 		/* RSS profiles 1 and 3 with extract code 0 for inner 4-tuple */
-		if (hash_type == 3 || TPA_START_IS_IPV6(tpa_start1))
+		else if (cmp_type == CMP_TYPE_RX_L2_TPA_START_CMP &&
+			 TPA_START_HASH_TYPE(tpa_start) == 3)
 			tpa_info->gso_type = SKB_GSO_TCPV6;
 		tpa_info->rss_hash =
 			le32_to_cpu(tpa_start->rx_tpa_start_cmp_rss_hash);
@@ -1394,7 +1412,10 @@ static void bnxt_tpa_start(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 	}
 	tpa_info->flags2 = le32_to_cpu(tpa_start1->rx_tpa_start_cmp_flags2);
 	tpa_info->hdr_info = le32_to_cpu(tpa_start1->rx_tpa_start_cmp_hdr_info);
-	bnxt_tpa_metadata(tpa_info, tpa_start, tpa_start1);
+	if (cmp_type == CMP_TYPE_RX_L2_TPA_START_CMP)
+		bnxt_tpa_metadata(tpa_info, tpa_start, tpa_start1);
+	else
+		bnxt_tpa_metadata_v2(tpa_info, tpa_start, tpa_start1);
 	tpa_info->agg_count = 0;
 
 	rxr->rx_prod = NEXT_RX(prod);
@@ -1816,6 +1837,19 @@ static struct sk_buff *bnxt_rx_vlan(struct sk_buff *skb, u8 cmp_type,
 			__vlan_hwaccel_put_tag(skb, vlan_proto, vtag);
 		else
 			goto vlan_err;
+	} else if (cmp_type == CMP_TYPE_RX_L2_V3_CMP) {
+		if (RX_CMP_VLAN_VALID(rxcmp)) {
+			u32 tpid_sel = RX_CMP_VLAN_TPID_SEL(rxcmp);
+
+			if (tpid_sel == RX_CMP_METADATA1_TPID_8021Q)
+				vlan_proto = htons(ETH_P_8021Q);
+			else if (tpid_sel == RX_CMP_METADATA1_TPID_8021AD)
+				vlan_proto = htons(ETH_P_8021AD);
+			else
+				goto vlan_err;
+			vtag = RX_CMP_METADATA0_TCI(rxcmp1);
+			__vlan_hwaccel_put_tag(skb, vlan_proto, vtag);
+		}
 	}
 	return skb;
 vlan_err:
@@ -1823,6 +1857,23 @@ static struct sk_buff *bnxt_rx_vlan(struct sk_buff *skb, u8 cmp_type,
 	return NULL;
 }
 
+static enum pkt_hash_types bnxt_rss_ext_op(struct bnxt *bp,
+					   struct rx_cmp *rxcmp)
+{
+	u8 ext_op;
+
+	ext_op = RX_CMP_V3_HASH_TYPE(bp, rxcmp);
+	switch (ext_op) {
+	case EXT_OP_INNER_4:
+	case EXT_OP_OUTER_4:
+	case EXT_OP_INNFL_3:
+	case EXT_OP_OUTFL_3:
+		return PKT_HASH_TYPE_L4;
+	default:
+		return PKT_HASH_TYPE_L3;
+	}
+}
+
 /* returns the following:
  * 1       - 1 packet successfully received
  * 0       - successful TPA_START, packet not completed yet
@@ -1839,7 +1890,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	struct rx_cmp *rxcmp;
 	struct rx_cmp_ext *rxcmp1;
 	u32 tmp_raw_cons = *raw_cons;
-	u16 cfa_code, cons, prod, cp_cons = RING_CMP(tmp_raw_cons);
+	u16 cons, prod, cp_cons = RING_CMP(tmp_raw_cons);
 	struct bnxt_sw_rx_bd *rx_buf;
 	unsigned int len;
 	u8 *data_ptr, agg_bufs, cmp_type;
@@ -1875,7 +1926,8 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	dma_rmb();
 	prod = rxr->rx_prod;
 
-	if (cmp_type == CMP_TYPE_RX_L2_TPA_START_CMP) {
+	if (cmp_type == CMP_TYPE_RX_L2_TPA_START_CMP ||
+	    cmp_type == CMP_TYPE_RX_L2_TPA_START_V3_CMP) {
 		bnxt_tpa_start(bp, rxr, cmp_type,
 			       (struct rx_tpa_start_cmp *)rxcmp,
 			       (struct rx_tpa_start_cmp_ext *)rxcmp1);
@@ -2030,17 +2082,27 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	}
 
 	if (RX_CMP_HASH_VALID(rxcmp)) {
-		u32 hash_type = RX_CMP_HASH_TYPE(rxcmp);
-		enum pkt_hash_types type = PKT_HASH_TYPE_L4;
+		enum pkt_hash_types type;
 
-		/* RSS profiles 1 and 3 with extract code 0 for inner 4-tuple */
-		if (hash_type != 1 && hash_type != 3)
-			type = PKT_HASH_TYPE_L3;
+		if (cmp_type == CMP_TYPE_RX_L2_V3_CMP) {
+			type = bnxt_rss_ext_op(bp, rxcmp);
+		} else {
+			u32 hash_type = RX_CMP_HASH_TYPE(rxcmp);
+
+			/* RSS profiles 1 and 3 with extract code 0 for inner
+			 * 4-tuple
+			 */
+			if (hash_type != 1 && hash_type != 3)
+				type = PKT_HASH_TYPE_L3;
+			else
+				type = PKT_HASH_TYPE_L4;
+		}
 		skb_set_hash(skb, le32_to_cpu(rxcmp->rx_cmp_rss_hash), type);
 	}
 
-	cfa_code = RX_CMP_CFA_CODE(rxcmp1);
-	skb->protocol = eth_type_trans(skb, bnxt_get_pkt_dev(bp, cfa_code));
+	if (cmp_type == CMP_TYPE_RX_L2_CMP)
+		dev = bnxt_get_pkt_dev(bp, RX_CMP_CFA_CODE(rxcmp1));
+	skb->protocol = eth_type_trans(skb, dev);
 
 	if (skb->dev->features & BNXT_HW_FEATURE_VLAN_ALL_RX) {
 		skb = bnxt_rx_vlan(skb, cmp_type, rxcmp, rxcmp1);
@@ -2127,7 +2189,8 @@ static int bnxt_force_rx_discard(struct bnxt *bp,
 	 */
 	dma_rmb();
 	cmp_type = RX_CMP_TYPE(rxcmp);
-	if (cmp_type == CMP_TYPE_RX_L2_CMP) {
+	if (cmp_type == CMP_TYPE_RX_L2_CMP ||
+	    cmp_type == CMP_TYPE_RX_L2_V3_CMP) {
 		rxcmp1->rx_cmp_cfa_code_errors_v2 |=
 			cpu_to_le32(RX_CMPL_ERRORS_CRC_ERROR);
 	} else if (cmp_type == CMP_TYPE_RX_L2_TPA_END_CMP) {
@@ -2651,6 +2714,7 @@ static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	cpr->has_more_work = 0;
 	cpr->had_work_done = 1;
 	while (1) {
+		u8 cmp_type;
 		int rc;
 
 		cons = RING_CMP(raw_cons);
@@ -2663,7 +2727,8 @@ static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 		 * reading any further.
 		 */
 		dma_rmb();
-		if (TX_CMP_TYPE(txcmp) == CMP_TYPE_TX_L2_CMP) {
+		cmp_type = TX_CMP_TYPE(txcmp);
+		if (cmp_type == CMP_TYPE_TX_L2_CMP) {
 			u32 opaque = txcmp->tx_cmp_opaque;
 			struct bnxt_tx_ring_info *txr;
 			u16 tx_freed;
@@ -2681,7 +2746,8 @@ static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 					cpr->has_more_work = 1;
 				break;
 			}
-		} else if ((TX_CMP_TYPE(txcmp) & 0x30) == 0x10) {
+		} else if (cmp_type >= CMP_TYPE_RX_L2_CMP &&
+			   cmp_type <= CMP_TYPE_RX_L2_TPA_START_V3_CMP) {
 			if (likely(budget))
 				rc = bnxt_rx_pkt(bp, cpr, &raw_cons, &event);
 			else
@@ -2698,12 +2764,9 @@ static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 				rx_pkts++;
 			else if (rc == -EBUSY)	/* partial completion */
 				break;
-		} else if (unlikely((TX_CMP_TYPE(txcmp) ==
-				     CMPL_BASE_TYPE_HWRM_DONE) ||
-				    (TX_CMP_TYPE(txcmp) ==
-				     CMPL_BASE_TYPE_HWRM_FWD_REQ) ||
-				    (TX_CMP_TYPE(txcmp) ==
-				     CMPL_BASE_TYPE_HWRM_ASYNC_EVENT))) {
+		} else if (unlikely(cmp_type == CMPL_BASE_TYPE_HWRM_DONE ||
+				    cmp_type == CMPL_BASE_TYPE_HWRM_FWD_REQ ||
+				    cmp_type == CMPL_BASE_TYPE_HWRM_ASYNC_EVENT)) {
 			bnxt_hwrm_handler(bp, txcmp);
 		}
 		raw_cons = NEXT_RAW_CMP(raw_cons);
@@ -5826,6 +5889,8 @@ static int bnxt_hwrm_vnic_qcaps(struct bnxt *bp)
 			bp->fw_cap |= BNXT_FW_CAP_VLAN_RX_STRIP;
 		if (flags & VNIC_QCAPS_RESP_FLAGS_RSS_HASH_TYPE_DELTA_CAP)
 			bp->rss_cap |= BNXT_RSS_CAP_RSS_HASH_TYPE_DELTA;
+		if (flags & VNIC_QCAPS_RESP_FLAGS_RSS_PROF_TCAM_MODE_ENABLED)
+			bp->rss_cap |= BNXT_RSS_CAP_RSS_TCAM;
 		bp->max_tpa_v2 = le16_to_cpu(resp->max_aggs_supported);
 		if (bp->max_tpa_v2) {
 			if (BNXT_CHIP_P5(bp))
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 14cb0512ee93..ad0b93682771 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -3919,7 +3919,8 @@ static int bnxt_poll_loopback(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 		 * reading any further.
 		 */
 		dma_rmb();
-		if (TX_CMP_TYPE(txcmp) == CMP_TYPE_RX_L2_CMP) {
+		if (TX_CMP_TYPE(txcmp) == CMP_TYPE_RX_L2_CMP ||
+		    TX_CMP_TYPE(txcmp) == CMP_TYPE_RX_L2_V3_CMP) {
 			rc = bnxt_rx_loopback(bp, cpr, raw_cons, pkt_size);
 			raw_cons = NEXT_RAW_CMP(raw_cons);
 			raw_cons = NEXT_RAW_CMP(raw_cons);
-- 
2.30.1


--000000000000ec1401060b7a7245
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEII/SqkbdFvQ1P+J/QRbP1ZLy7k6jcQGw
omsHkldkFCUaMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIw
MTIyNDAwMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQB/29USsR9CTl8Y1Agm51Gsn1krW3AeBGCcIaMEbL7Ky9jFtcxb
IOv7VZa9yFUNRZRPJeJy1v6tsEJFbZRnx+qUIF12JQ+hQK3x2pcMjlzvFAKN6ukSAsggEiy0rx23
v2Na12TIPEhERIYGSWFyvH3xCXsW9d5A6Y63+HuQD9ewyXp/4S8BgcMj9KFjeVm2zfKTO4kDH7f0
22XCaZu+clj0i/qoW27rb7E4RxPEpEF3UsXePxKUtQfD+iesRjF2jsTHdERAq3dFdSO5NX2vTmi/
VXgAteB/kCaK96pIW73F/Mfvs0q7KbUpr0uBlL7W5Ic4Ypspkg7K6w1z3+MUCO3o
--000000000000ec1401060b7a7245--

