Return-Path: <netdev+bounces-53126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B45E8016A6
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 23:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDD38B20F3A
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 22:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44E53F8C6;
	Fri,  1 Dec 2023 22:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KUtTcwEK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A0810C2
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 14:40:01 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-42540e3520bso699651cf.3
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 14:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701470400; x=1702075200; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=6VgdmnqoeOxM7oZa/QST+yhZPiab6rNy9bKSv+IoHsg=;
        b=KUtTcwEKwNOu8NqdUW63ZgPznw4FNuNSF1pACg70LJ9DFWehUaxAYVSxxPt0pnXApx
         b62SFe2kbRxJrLw39Y7/G674csSTiM6ymKBSVq4taprFV8IMhfAQBPYFHAEbSxyeLbRF
         xbmKnI3BvpmILqBrVvEoTaRbk3WLpTfJ2TnWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701470400; x=1702075200;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6VgdmnqoeOxM7oZa/QST+yhZPiab6rNy9bKSv+IoHsg=;
        b=COVh83keUWnMWfLH52fbgD7IANJrz46tWPNOYW+gzVtLYe/eAs1HEKVMIfKkw6KY8q
         7sXLa6jXHYne79TjIywNnpvu8wEXnQ1SqCfcdJLwxu/OzQ7mgeh2bH0ob7hVGhn6JCII
         ZWUUDjeDfWHjrnNm5p38enZcZAdvlc3vmG0vB+Sbhjsla4ue0t4vzIXvJuz7Xys/hEzz
         XaQ32Lo+koKO6NZRUJyQpe89fxaA28EbDOCxbDnIBiV610J8Bu8hAowa9bv/t0/Bgm98
         DWkU+H8FnLXXkRXaMLH8RFkZrklNdmIbuNea5GAnoluVTJ55jQZmYmXQ0v2t9R8QBF2p
         bs/g==
X-Gm-Message-State: AOJu0YzhgcgtodIaLCGdiuAIzqFncaUW8lGlhgdz8+K2kIxDuzWUMw6Z
	Ja0yrE/fzsKyIlcXZCkaTKSgbQ==
X-Google-Smtp-Source: AGHT+IHcEClnf7tQVdxV+0a1gUTiq1180m0U0KpFPCH+ZayoZU9ltL2pF8Fg62w79DQHqWGWovPpiA==
X-Received: by 2002:ac8:4e45:0:b0:423:6edd:3158 with SMTP id e5-20020ac84e45000000b004236edd3158mr341085qtw.57.1701470400401;
        Fri, 01 Dec 2023 14:40:00 -0800 (PST)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id i14-20020ac8488e000000b004199c98f87dsm1878715qtq.74.2023.12.01.14.39.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Dec 2023 14:40:00 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com
Subject: [PATCH net-next 09/15] bnxt_en: Refactor and refine bnxt_tpa_start() and bnxt_tpa_end().
Date: Fri,  1 Dec 2023 14:39:18 -0800
Message-Id: <20231201223924.26955-10-michael.chan@broadcom.com>
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
	boundary="000000000000d5949d060b7a7219"

--000000000000d5949d060b7a7219
Content-Transfer-Encoding: 8bit

Refactor bnxt_tpa_start() by adding bnxt_tpa_metadata() to gather the
metadata from the TPA_START completion.  This makes it easier to
support the new P7 chip which has a modified TPA_START completion
structure with different metadata formats.  We also add vlan_valid
and cfa_code_valid fields to the bnxt_tpa_info structure so that the
VLAN and VF rep logic can be common for all chips.  The VLAN metadata
is now collected in bnxt_tpa_start() only when it is valid and the
vlan_valid field will be set.  bnxt_tpa_end() can now use common VLAN
logic for all chips.

Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 35 ++++++++++++++++-------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  2 ++
 2 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 9aca38b6f196..be016a2a9aac 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1315,8 +1315,22 @@ static u16 bnxt_lookup_agg_idx(struct bnxt_rx_ring_info *rxr, u16 agg_id)
 	return map->agg_id_tbl[agg_id];
 }
 
+static void bnxt_tpa_metadata(struct bnxt_tpa_info *tpa_info,
+			      struct rx_tpa_start_cmp *tpa_start,
+			      struct rx_tpa_start_cmp_ext *tpa_start1)
+{
+	tpa_info->cfa_code_valid = 1;
+	tpa_info->cfa_code = TPA_START_CFA_CODE(tpa_start1);
+	tpa_info->vlan_valid = 0;
+	if (tpa_info->flags2 & RX_CMP_FLAGS2_META_FORMAT_VLAN) {
+		tpa_info->vlan_valid = 1;
+		tpa_info->metadata =
+			le32_to_cpu(tpa_start1->rx_tpa_start_cmp_metadata);
+	}
+}
+
 static void bnxt_tpa_start(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
-			   struct rx_tpa_start_cmp *tpa_start,
+			   u8 cmp_type, struct rx_tpa_start_cmp *tpa_start,
 			   struct rx_tpa_start_cmp_ext *tpa_start1)
 {
 	struct bnxt_sw_rx_bd *cons_rx_buf, *prod_rx_buf;
@@ -1345,10 +1359,6 @@ static void bnxt_tpa_start(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 		bnxt_sched_reset_rxr(bp, rxr);
 		return;
 	}
-	/* Store cfa_code in tpa_info to use in tpa_end
-	 * completion processing.
-	 */
-	tpa_info->cfa_code = TPA_START_CFA_CODE(tpa_start1);
 	prod_rx_buf->data = tpa_info->data;
 	prod_rx_buf->data_ptr = tpa_info->data_ptr;
 
@@ -1383,8 +1393,8 @@ static void bnxt_tpa_start(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 		netif_warn(bp, rx_err, bp->dev, "TPA packet without valid hash\n");
 	}
 	tpa_info->flags2 = le32_to_cpu(tpa_start1->rx_tpa_start_cmp_flags2);
-	tpa_info->metadata = le32_to_cpu(tpa_start1->rx_tpa_start_cmp_metadata);
 	tpa_info->hdr_info = le32_to_cpu(tpa_start1->rx_tpa_start_cmp_hdr_info);
+	bnxt_tpa_metadata(tpa_info, tpa_start, tpa_start1);
 	tpa_info->agg_count = 0;
 
 	rxr->rx_prod = NEXT_RX(prod);
@@ -1619,6 +1629,7 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 {
 	struct bnxt_napi *bnapi = cpr->bnapi;
 	struct bnxt_rx_ring_info *rxr = bnapi->rx_ring;
+	struct net_device *dev = bp->dev;
 	u8 *data_ptr, agg_bufs;
 	unsigned int len;
 	struct bnxt_tpa_info *tpa_info;
@@ -1725,14 +1736,15 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 		}
 	}
 
-	skb->protocol =
-		eth_type_trans(skb, bnxt_get_pkt_dev(bp, tpa_info->cfa_code));
+	if (tpa_info->cfa_code_valid)
+		dev = bnxt_get_pkt_dev(bp, tpa_info->cfa_code);
+	skb->protocol = eth_type_trans(skb, dev);
 
 	if (tpa_info->hash_type != PKT_HASH_TYPE_NONE)
 		skb_set_hash(skb, tpa_info->rss_hash, tpa_info->hash_type);
 
-	if ((tpa_info->flags2 & RX_CMP_FLAGS2_META_FORMAT_VLAN) &&
-	    (skb->dev->features & BNXT_HW_FEATURE_VLAN_ALL_RX)) {
+	if (tpa_info->vlan_valid &&
+	    (dev->features & BNXT_HW_FEATURE_VLAN_ALL_RX)) {
 		__be16 vlan_proto = htons(tpa_info->metadata >>
 					  RX_CMP_FLAGS2_METADATA_TPID_SFT);
 		u16 vtag = tpa_info->metadata & RX_CMP_FLAGS2_METADATA_TCI_MASK;
@@ -1864,7 +1876,8 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	prod = rxr->rx_prod;
 
 	if (cmp_type == CMP_TYPE_RX_L2_TPA_START_CMP) {
-		bnxt_tpa_start(bp, rxr, (struct rx_tpa_start_cmp *)rxcmp,
+		bnxt_tpa_start(bp, rxr, cmp_type,
+			       (struct rx_tpa_start_cmp *)rxcmp,
 			       (struct rx_tpa_start_cmp_ext *)rxcmp1);
 
 		*event |= BNXT_RX_EVENT;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index ba9caae923f2..57694eb7feeb 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1027,6 +1027,8 @@ struct bnxt_tpa_info {
 
 	u16			cfa_code; /* cfa_code in TPA start compl */
 	u8			agg_count;
+	u8			vlan_valid:1;
+	u8			cfa_code_valid:1;
 	struct rx_agg_cmp	*agg_arr;
 };
 
-- 
2.30.1


--000000000000d5949d060b7a7219
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIID3BAePZJUqOoRIJMHC0ifzScfC4ktA
G8OWRgJWWM8OMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTIw
MTIyNDAwMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQCCT3nTr6Rd0816XfHAvZa7PO2U1hUTYaSNb3YswcNyN+l8ekd3
26W2IJFXjV4gw1/ai32xHDtaD/3eXaZcCyUnFogUv2Rn2SC9IDflwe76DjGiIJYJg1DkBZEknjM1
+/m9YIYvnJGeArNuPoHYgVItP+GIdrmvQeoeXwJRz+MqQLDlJb238FaVhi9NSV9CPi2Aw0aG6voj
BtPiEmAo4gc0Cz7gan9aWKU44ziWk2W35plJ67hH8oQ/HfkQXOvs5SmCdwZDJwqskjpyA4NzndJW
IX8QZoa/0nUQPuAnJeJ0UXuCcyfkcSRoUHsxNoIdIzUpFrgNblXLdh6Fta6z5o/W
--000000000000d5949d060b7a7219--

