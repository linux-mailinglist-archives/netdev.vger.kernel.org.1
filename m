Return-Path: <netdev+bounces-92670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 759A88B83B9
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 02:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026521F2300C
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 00:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1023A4400;
	Wed,  1 May 2024 00:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BVXPixbK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367FB1396
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 00:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714523502; cv=none; b=JbUMrsohO30O99/u37431U9oeFlS40NNsknE2MMSvwjr/J3Jmb/tcZ2qUwgt7aYir1UU3JPjQo15oWJ4YbfgUNZUo349+UyJeo+sqGl+nE7jIEwoDdh9oXUvTyEsjxR7lKciyVbMsvscRgRZ/slEVDzUFh/udFoVgTLpPAmDLWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714523502; c=relaxed/simple;
	bh=UvdcPMNatHQO7YLpj9VCVesC64SQ9xOQOvMc6IgAG+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GlStDt7dSos57UcXzLkVbZXevh2XWChAMXOmJ4p4Zjn4rSr5M2gDe/xOnnDZJLOUSh0Pi8SGi3CjEmLn0lLJZH1cdBpZwKn/Xu8csAN5YzdtB2jWXZKxr1jFk6Uv83IpQTMvPOhTWAh9fzcSlRuSzspZbjfS5gxsWzH3KRvinVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BVXPixbK; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-61be674f5d1so19369477b3.2
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 17:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1714523499; x=1715128299; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wn1z9uZ6ZjakmLPsUlJwuwyrwc8Of/YwmJ14nkBh/Lo=;
        b=BVXPixbKEBFmGUAUwnyDDNCrN9rkoYvGvo0Q56oucq+JJATUlO6KCoOQd8+VA86FFY
         dCrxDtnOXIkGcMIf62Q4fdOGvSieDXzegc9WEgp5VeEp0U16mnsFLXGbRGiJ9vrgq2Kz
         uH+860PhW+boPHrlyzjkk2UT8DdyF5mRVxrME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714523499; x=1715128299;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wn1z9uZ6ZjakmLPsUlJwuwyrwc8Of/YwmJ14nkBh/Lo=;
        b=TYHleKlDTrhRPZOWRgP0TK2yafdnVt4n/m35Q/Tppg4uhsewDY8v2vnHcd4r7pllnL
         ZcYVRFrcptv45duYP2CmuflMnPWYeVbAQ5nXm5L2Qj/6iKMZ4Pk3GBzcz++vDrgoQLaQ
         wi1PkBi3QNydxqbu4UqApBRwbEPZupK7cU2d+cxfI4p7i5qw+vcRLYHrvvXsF3X9yVel
         fhR2cdB4Mu/gXTvZxKAvrIABFCSuE6HkQxCXHbZvJHmVcH12pvQmJR7P+9PeuAesBQA6
         pk4t1sku6znf93wCZVlUXtMLVq14gcL42YYb7yJGP8+gZ8lvYCc+u9R+0EHsIPxaHPwc
         59fw==
X-Gm-Message-State: AOJu0Yw+7qxaGGovn0MAYtlVvxK+uKIKwLHWjfmdtB0gYWC5h7P52CHZ
	r7xOfSzOi41024moIAD3h8J4pj9y7tGcqLWw1b7HP+yog45d2TyYrlC3J9uwTw==
X-Google-Smtp-Source: AGHT+IHHTZGenhz6xW79hZko/mhiXIbL6shSKm2SmSdzxOuY9kbT6vJ881w7CQKvO/VhASFPAM+PRA==
X-Received: by 2002:a5b:43:0:b0:de6:fe6:68a2 with SMTP id e3-20020a5b0043000000b00de60fe668a2mr1290972ybp.23.1714523498743;
        Tue, 30 Apr 2024 17:31:38 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id f15-20020ac8470f000000b0043a7cb47069sm4337935qtp.9.2024.04.30.17.31.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2024 17:31:38 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew.gospodarek@broadcom.com,
	Edwin Peer <edwin.peer@broadcom.com>
Subject: [PATCH net-next v2 1/6] bnxt_en: share NQ ring sw_stats memory with subrings
Date: Tue, 30 Apr 2024 17:30:51 -0700
Message-Id: <20240501003056.100607-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20240501003056.100607-1-michael.chan@broadcom.com>
References: <20240501003056.100607-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000002361d70617599cd6"

--0000000000002361d70617599cd6
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
index be96bb494ae6..98bff01b89ff 100644
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
@@ -10811,9 +10819,9 @@ static void bnxt_disable_napi(struct bnxt *bp)
 
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
@@ -12338,8 +12346,8 @@ static void bnxt_get_ring_stats(struct bnxt *bp,
 		stats->tx_dropped += BNXT_GET_RING_STATS64(sw, tx_error_pkts);
 
 		stats->rx_dropped +=
-			cpr->sw_stats.rx.rx_netpoll_discards +
-			cpr->sw_stats.rx.rx_oom_discards;
+			cpr->sw_stats->rx.rx_netpoll_discards +
+			cpr->sw_stats->rx.rx_oom_discards;
 	}
 }
 
@@ -12406,7 +12414,7 @@ static void bnxt_get_one_ring_err_stats(struct bnxt *bp,
 					struct bnxt_total_ring_err_stats *stats,
 					struct bnxt_cp_ring_info *cpr)
 {
-	struct bnxt_sw_stats *sw_stats = &cpr->sw_stats;
+	struct bnxt_sw_stats *sw_stats = cpr->sw_stats;
 	u64 *hw_stats = cpr->stats.sw_stats;
 
 	stats->rx_total_l4_csum_errors += sw_stats->rx.rx_l4_csum_errors;
@@ -13249,7 +13257,7 @@ static void bnxt_rx_ring_reset(struct bnxt *bp)
 		rxr->bnapi->in_reset = false;
 		bnxt_alloc_one_rx_ring(bp, i);
 		cpr = &rxr->bnapi->cp_ring;
-		cpr->sw_stats.rx.rx_resets++;
+		cpr->sw_stats->rx.rx_resets++;
 		if (bp->flags & BNXT_FLAG_AGG_RINGS)
 			bnxt_db_write(bp, &rxr->rx_agg_db, rxr->rx_agg_prod);
 		bnxt_db_write(bp, &rxr->rx_db, rxr->rx_prod);
@@ -13461,7 +13469,7 @@ static void bnxt_chk_missed_irq(struct bnxt *bp)
 			bnxt_dbg_hwrm_ring_info_get(bp,
 				DBG_RING_INFO_GET_REQ_RING_TYPE_L2_CMPL,
 				fw_ring_id, &val[0], &val[1]);
-			cpr->sw_stats.cmn.missed_irqs++;
+			cpr->sw_stats->cmn.missed_irqs++;
 		}
 	}
 }
@@ -14769,7 +14777,7 @@ static void bnxt_get_queue_stats_rx(struct net_device *dev, int i,
 	stats->bytes += BNXT_GET_RING_STATS64(sw, rx_mcast_bytes);
 	stats->bytes += BNXT_GET_RING_STATS64(sw, rx_bcast_bytes);
 
-	stats->alloc_fail = cpr->sw_stats.rx.rx_oom_discards;
+	stats->alloc_fail = cpr->sw_stats->rx.rx_oom_discards;
 }
 
 static void bnxt_get_queue_stats_tx(struct net_device *dev, int i,
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index ad57ef051798..631b0039d72b 100644
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


--0000000000002361d70617599cd6
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQbQYJKoZIhvcNAQcCoIIQXjCCEFoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3EMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBUwwggQ0oAMCAQICDF5AaMOe0cZvaJpCQjANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODIxMzhaFw0yNTA5MTAwODIxMzhaMIGO
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFTATBgNVBAMTDE1pY2hhZWwgQ2hhbjEoMCYGCSqGSIb3DQEJ
ARYZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoC
ggEBALhEmG7egFWvPKcrDxuNhNcn2oHauIHc8AzGhPyJxU4S6ZUjHM/psoNo5XxlMSRpYE7g7vLx
J4NBefU36XTEWVzbEkAuOSuJTuJkm98JE3+wjeO+aQTbNF3mG2iAe0AZbAWyqFxZulWitE8U2tIC
9mttDjSN/wbltcwuti7P57RuR+WyZstDlPJqUMm1rJTbgDqkF2pnvufc4US2iexnfjGopunLvioc
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
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIBNydO9g9DIRKPg52KMEDbiQAQVZh9WI
+pey7rz2AweRMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDUw
MTAwMzEzOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQBCy9itOnip6fQHiUmZtTdRVWdkNyZfAzMdrJIJb1L+YM+CGD6a
7mGTyZicS2myoiAQhcz3xpTN8gsSAGXxuja+uJIKSeA9PSsKNUkoSkgllT4IXB1CTXogSEQd+rqv
A/lwC5FN+AnfebtU/NmLiNzL8KDh4HKreYXdX299DxkPioZAC+bQoiNfmfDb0h3Mze+xe+i3r/5c
Q9QENTOTN8ZRS8oCDn3UOvaKFJF9n6ygwDyVe5K+Wy7K/uNi1hX3uedMG5Tc/HFZHMNKx7g6f0GQ
IeIhy4pjVuI5BSfLZlZ8Qn/XLV21iN37b4rmEst6BImtj/avIw1+nhfumPJA89/A
--0000000000002361d70617599cd6--

