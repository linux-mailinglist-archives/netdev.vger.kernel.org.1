Return-Path: <netdev+bounces-92630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBDB8B82B8
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 00:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8BDFB214C6
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 22:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30ACC129E72;
	Tue, 30 Apr 2024 22:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ahPulP1H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E411CD21
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 22:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714517176; cv=none; b=tkQb0QB5Ke4ZhNtlX05Y0cjeXgzPrGdVdYWZ/xSuBa0Kts5Th5VLJX6D3vXFR7C2G+8hmd9fhnV8CfzHvzsYJcx3NdVA40HtH8JoPnjHo1pVkAcoXcMsPZqu4P7eYmZmU9FlOxdUUS2hu24lGdxaBRV3e8x7xVZghR0S91YsOzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714517176; c=relaxed/simple;
	bh=b9xN8kwZWqeZgpQmlkl0t17iScBMtGRr7qoWQ16qxIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hGqK7GXu8hMIu7ziGQfvu6KemMFxIhmspa8rZg7zpnJtiT1GtcReEmtOVL7eF+nu/i16TGwhcNOrXUE2bXiq5ZDjdjObK0gnYqNy7g3X3ySO3omTbnQwpILmR4dViKHtot/huTNM1bTaK2HbayKhGYMDCJfBMR5eb+dGZMlWlN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ahPulP1H; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e5c7d087e1so54314815ad.0
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 15:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1714517174; x=1715121974; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=firrJvki98oSDb8LiFa5e2fqHhjUz+5CIjU/D7FJC9I=;
        b=ahPulP1HdOvoSA8FsoMRwfELRXiuzLXf/3vmi/sT66Iv1esJtbziuCocdPjPAM7aW+
         lbjOOUD+Gv2yTUM61ruLW9uwY071U/Jm/L1IHZV3fW1JUNgjgXJPsCwZvGhVSCL+Lz/3
         0gVYDOSEuEJpuBcxBOilV7vyLol7xMIfTcU7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714517174; x=1715121974;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=firrJvki98oSDb8LiFa5e2fqHhjUz+5CIjU/D7FJC9I=;
        b=jQPo7qp14WEJ6JP3EHiiLvCle1XltzEj4tAemOU4MSJUMjN7pbBRHZa5hNZ/dvxsxn
         Gdceu/KSeaGWtwvE3Zq2MgcSteZOsUcnJTUe+gtbufv3p1vD55mk1dbJV8qDlhVT0G73
         KcYQOa22snNHpr0o+2/+pLTyRTNeDoW9+pw9halp46Ac94oF28zhbp0NT77ZzJpFnDBK
         brz+zNATefqM4jXPVITWVHpJndutfLtSGItqelbz3BKmPYrMwKp2Gtc32iGsYQAT2KFa
         3Yj5xIcEQixEej3YXvTP82S3ttyc48AjMuTX8FAIytDIRTdn31xo9XaJ8W+uRkNyvmjT
         ZfRg==
X-Gm-Message-State: AOJu0Yw6/Tae7ijMhm/SL9nL5y6OQGsKT3m4Ma/hlU5lndyTmvawJ9j2
	4uDrLB1/mpxuMDbI4rfPl1nW/Xk1ShBCioUpIETUr2j50RYaZC7cu0iBHm+tYw==
X-Google-Smtp-Source: AGHT+IE8WnWL/zt0HUpP+sFwaoeamR7xWaJZXK2ME3IFamrs23oUGXt4Kt2Pvpe266mOFuS0198vpg==
X-Received: by 2002:a17:902:d54d:b0:1eb:dae:714f with SMTP id z13-20020a170902d54d00b001eb0dae714fmr992904plf.9.1714517173359;
        Tue, 30 Apr 2024 15:46:13 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id s11-20020a170902a50b00b001eb2fb28eabsm7836476plq.227.2024.04.30.15.46.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2024 15:46:12 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew.gospodarek@broadcom.com,
	Edwin Peer <edwin.peer@broadcom.com>
Subject: [PATCH net-next 2/7] bnxt_en: share NQ ring sw_stats memory with subrings
Date: Tue, 30 Apr 2024 15:44:33 -0700
Message-Id: <20240430224438.91494-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240430224438.91494-1-michael.chan@broadcom.com>
References: <20240430224438.91494-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000020cbe506175823c9"

--00000000000020cbe506175823c9
Content-Transfer-Encoding: 8bit

From: Edwin Peer <edwin.peer@broadcom.com>

On P5_PLUS chips and later, the NQ rings have subrings for RX and TX
completions respectively. These subrings are passed to the poll
function instead of the base NQ, but each ring carries its own
copy of the software ring statistics.

For stats to be conveniently accessible in __bnxt_poll_work(), the
statistics memory should either be shared between the NQ and its
subrings or the subrings need to be included in the ethtool stats
aggregation logic. This patch opts for the former, because it's more
efficient and less confusing having the software statistics for a
ring exist in a single place.

Before this patch, the counter will not be displayed if the "wrong"
cpr->sw_stats was used to increment a counter.

Link: https://lore.kernel.org/netdev/CACKFLikEhVAJA+osD7UjQNotdGte+fth7zOy7yDdLkTyFk9Pyw@mail.gmail.com/
Signed-off-by: Edwin Peer <edwin.peer@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 40 +++++++++++--------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  4 +-
 3 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 0eb880766012..38134b995478 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1811,7 +1811,7 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 		skb = bnxt_copy_skb(bnapi, data_ptr, len, mapping);
 		if (!skb) {
 			bnxt_abort_tpa(cpr, idx, agg_bufs);
-			cpr->bnapi->cp_ring.sw_stats.rx.rx_oom_discards += 1;
+			cpr->sw_stats->rx.rx_oom_discards += 1;
 			return NULL;
 		}
 	} else {
@@ -1821,7 +1821,7 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 		new_data = __bnxt_alloc_rx_frag(bp, &new_mapping, GFP_ATOMIC);
 		if (!new_data) {
 			bnxt_abort_tpa(cpr, idx, agg_bufs);
-			cpr->bnapi->cp_ring.sw_stats.rx.rx_oom_discards += 1;
+			cpr->sw_stats->rx.rx_oom_discards += 1;
 			return NULL;
 		}
 
@@ -1837,7 +1837,7 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 		if (!skb) {
 			skb_free_frag(data);
 			bnxt_abort_tpa(cpr, idx, agg_bufs);
-			cpr->bnapi->cp_ring.sw_stats.rx.rx_oom_discards += 1;
+			cpr->sw_stats->rx.rx_oom_discards += 1;
 			return NULL;
 		}
 		skb_reserve(skb, bp->rx_offset);
@@ -1848,7 +1848,7 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 		skb = bnxt_rx_agg_pages_skb(bp, cpr, skb, idx, agg_bufs, true);
 		if (!skb) {
 			/* Page reuse already handled by bnxt_rx_pages(). */
-			cpr->bnapi->cp_ring.sw_stats.rx.rx_oom_discards += 1;
+			cpr->sw_stats->rx.rx_oom_discards += 1;
 			return NULL;
 		}
 	}
@@ -2106,7 +2106,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 
 		rc = -EIO;
 		if (rx_err & RX_CMPL_ERRORS_BUFFER_ERROR_MASK) {
-			bnapi->cp_ring.sw_stats.rx.rx_buf_errors++;
+			bnapi->cp_ring.sw_stats->rx.rx_buf_errors++;
 			if (!(bp->flags & BNXT_FLAG_CHIP_P5_PLUS) &&
 			    !(bp->fw_cap & BNXT_FW_CAP_RING_MONITOR)) {
 				netdev_warn_once(bp->dev, "RX buffer error %x\n",
@@ -2222,7 +2222,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	} else {
 		if (rxcmp1->rx_cmp_cfa_code_errors_v2 & RX_CMP_L4_CS_ERR_BITS) {
 			if (dev->features & NETIF_F_RXCSUM)
-				bnapi->cp_ring.sw_stats.rx.rx_l4_csum_errors++;
+				bnapi->cp_ring.sw_stats->rx.rx_l4_csum_errors++;
 		}
 	}
 
@@ -2259,7 +2259,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	return rc;
 
 oom_next_rx:
-	cpr->bnapi->cp_ring.sw_stats.rx.rx_oom_discards += 1;
+	cpr->sw_stats->rx.rx_oom_discards += 1;
 	rc = -ENOMEM;
 	goto next_rx;
 }
@@ -2308,7 +2308,7 @@ static int bnxt_force_rx_discard(struct bnxt *bp,
 	}
 	rc = bnxt_rx_pkt(bp, cpr, raw_cons, event);
 	if (rc && rc != -EBUSY)
-		cpr->bnapi->cp_ring.sw_stats.rx.rx_netpoll_discards += 1;
+		cpr->sw_stats->rx.rx_netpoll_discards += 1;
 	return rc;
 }
 
@@ -3951,6 +3951,7 @@ static int bnxt_alloc_cp_rings(struct bnxt *bp)
 			if (rc)
 				return rc;
 			cpr2->bnapi = bnapi;
+			cpr2->sw_stats = cpr->sw_stats;
 			cpr2->cp_idx = k;
 			if (!k && rx) {
 				bp->rx_ring[i].rx_cpr = cpr2;
@@ -4792,6 +4793,9 @@ static void bnxt_free_ring_stats(struct bnxt *bp)
 		struct bnxt_cp_ring_info *cpr = &bnapi->cp_ring;
 
 		bnxt_free_stats_mem(bp, &cpr->stats);
+
+		kfree(cpr->sw_stats);
+		cpr->sw_stats = NULL;
 	}
 }
 
@@ -4806,6 +4810,10 @@ static int bnxt_alloc_stats(struct bnxt *bp)
 		struct bnxt_napi *bnapi = bp->bnapi[i];
 		struct bnxt_cp_ring_info *cpr = &bnapi->cp_ring;
 
+		cpr->sw_stats = kzalloc(sizeof(*cpr->sw_stats), GFP_KERNEL);
+		if (!cpr->sw_stats)
+			return -ENOMEM;
+
 		cpr->stats.len = size;
 		rc = bnxt_alloc_stats_mem(bp, &cpr->stats, !i);
 		if (rc)
@@ -10807,9 +10815,9 @@ static void bnxt_disable_napi(struct bnxt *bp)
 
 		cpr = &bnapi->cp_ring;
 		if (bnapi->tx_fault)
-			cpr->sw_stats.tx.tx_resets++;
+			cpr->sw_stats->tx.tx_resets++;
 		if (bnapi->in_reset)
-			cpr->sw_stats.rx.rx_resets++;
+			cpr->sw_stats->rx.rx_resets++;
 		napi_disable(&bnapi->napi);
 		if (bnapi->rx_ring)
 			cancel_work_sync(&cpr->dim.work);
@@ -12334,8 +12342,8 @@ static void bnxt_get_ring_stats(struct bnxt *bp,
 		stats->tx_dropped += BNXT_GET_RING_STATS64(sw, tx_error_pkts);
 
 		stats->rx_dropped +=
-			cpr->sw_stats.rx.rx_netpoll_discards +
-			cpr->sw_stats.rx.rx_oom_discards;
+			cpr->sw_stats->rx.rx_netpoll_discards +
+			cpr->sw_stats->rx.rx_oom_discards;
 	}
 }
 
@@ -12402,7 +12410,7 @@ static void bnxt_get_one_ring_err_stats(struct bnxt *bp,
 					struct bnxt_total_ring_err_stats *stats,
 					struct bnxt_cp_ring_info *cpr)
 {
-	struct bnxt_sw_stats *sw_stats = &cpr->sw_stats;
+	struct bnxt_sw_stats *sw_stats = cpr->sw_stats;
 	u64 *hw_stats = cpr->stats.sw_stats;
 
 	stats->rx_total_l4_csum_errors += sw_stats->rx.rx_l4_csum_errors;
@@ -13245,7 +13253,7 @@ static void bnxt_rx_ring_reset(struct bnxt *bp)
 		rxr->bnapi->in_reset = false;
 		bnxt_alloc_one_rx_ring(bp, i);
 		cpr = &rxr->bnapi->cp_ring;
-		cpr->sw_stats.rx.rx_resets++;
+		cpr->sw_stats->rx.rx_resets++;
 		if (bp->flags & BNXT_FLAG_AGG_RINGS)
 			bnxt_db_write(bp, &rxr->rx_agg_db, rxr->rx_agg_prod);
 		bnxt_db_write(bp, &rxr->rx_db, rxr->rx_prod);
@@ -13457,7 +13465,7 @@ static void bnxt_chk_missed_irq(struct bnxt *bp)
 			bnxt_dbg_hwrm_ring_info_get(bp,
 				DBG_RING_INFO_GET_REQ_RING_TYPE_L2_CMPL,
 				fw_ring_id, &val[0], &val[1]);
-			cpr->sw_stats.cmn.missed_irqs++;
+			cpr->sw_stats->cmn.missed_irqs++;
 		}
 	}
 }
@@ -14765,7 +14773,7 @@ static void bnxt_get_queue_stats_rx(struct net_device *dev, int i,
 	stats->bytes += BNXT_GET_RING_STATS64(sw, rx_mcast_bytes);
 	stats->bytes += BNXT_GET_RING_STATS64(sw, rx_bcast_bytes);
 
-	stats->alloc_fail = cpr->sw_stats.rx.rx_oom_discards;
+	stats->alloc_fail = cpr->sw_stats->rx.rx_oom_discards;
 }
 
 static void bnxt_get_queue_stats_tx(struct net_device *dev, int i,
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 0c680032ab66..003c00b229f2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1152,7 +1152,7 @@ struct bnxt_cp_ring_info {
 	struct bnxt_stats_mem	stats;
 	u32			hw_stats_ctx_id;
 
-	struct bnxt_sw_stats	sw_stats;
+	struct bnxt_sw_stats	*sw_stats;
 
 	struct bnxt_ring_struct	cp_ring_struct;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 68444234b268..6de3cfcea90f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -631,13 +631,13 @@ static void bnxt_get_ethtool_stats(struct net_device *dev,
 			buf[j] = sw_stats[k];
 
 skip_tpa_ring_stats:
-		sw = (u64 *)&cpr->sw_stats.rx;
+		sw = (u64 *)&cpr->sw_stats->rx;
 		if (is_rx_ring(bp, i)) {
 			for (k = 0; k < NUM_RING_RX_SW_STATS; j++, k++)
 				buf[j] = sw[k];
 		}
 
-		sw = (u64 *)&cpr->sw_stats.cmn;
+		sw = (u64 *)&cpr->sw_stats->cmn;
 		for (k = 0; k < NUM_RING_CMN_SW_STATS; j++, k++)
 			buf[j] = sw[k];
 	}
-- 
2.30.1


--00000000000020cbe506175823c9
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIHlIaX8WRxOiKmL1gqZFkWWCLLBT0xa9
mq8bmubvgNkWMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDQz
MDIyNDYxNFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAjOhUUuZ77JoabpN5yUhDUefGRXfHDXfYGWzk5JoZCDQYIwh0T
WRq5Ee0M8+1nDZBOkYdbnw+LpAwC+x6WtT0LdyNmI4norIKBE+qGfyTwwMzMNGkbhAmUUoEhzxiM
sCfTZnnN3HHT4pwJcDoncpzRb5+ZufIoxxlnZC/k8SsF6v+eSuejZb38T2co5srLJrFZ/t7H93/X
KM0D+yRPYI4fGLl4xCxNfwiIAk/QtPvIwZ3D6bEIpe6v0tsjhR2yLS6J1nhKES18jId0IJJZupdi
Vo925wPAWFkRJJPdW7JE+g1dT5oJ0m3niyoJ8BSWatI4M5EDNFc5fnRnH3t+9yjn
--00000000000020cbe506175823c9--

