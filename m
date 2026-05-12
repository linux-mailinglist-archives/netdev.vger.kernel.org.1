Return-Path: <netdev+bounces-287316-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UM9jBJGaA2p27wEAu9opvQ
	(envelope-from <netdev+bounces-287316-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:24:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E41F52A3CB
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 373AE30EA261
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 21:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F4537F8A8;
	Tue, 12 May 2026 21:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Q87QcAu9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com [209.85.210.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A2A37E315
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 21:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620913; cv=none; b=RWrnJeTMNEeGsMTXVYG1wt43ryBuAvAggp9qWi29fhKoT4t4bNiA03CEyCTYnS7JcoJd99LgQrxDQz+oN0BH32tTS6F7y+ERlqRL2ne2qok0oQwHkhKhjYscBdsynWhNg2ijt8Ali7cPBNTVeYZZTsz30SklrQ2rLZeZDfMPTpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620913; c=relaxed/simple;
	bh=2i6J52SUXaezBvMue+KL38TP7tPmy0/vTGCkdvz/xsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nU6iBvUGTt55HrZ7yZ9o5x+LNyGhMd5ikeUFMf2AaJq1nwFCIhZDO0XYdV1nb3yeZwh89sC/hMh9JD08mL4iFb8rpo0rQPz4jgt6caCWwEENJ5wgbVnxa9Gpwc/c5j3VPB9v+kZZ4yS3s4sL0e6CGW+c9D8XNlsmLZy+/VBTq2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Q87QcAu9; arc=none smtp.client-ip=209.85.210.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f100.google.com with SMTP id 46e09a7af769-7d4c383f2fcso4824732a34.0
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778620910; x=1779225710;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p+TPih0y8u9yWZG3vHrJncrYyYkqU3A9i4SCsl83w9A=;
        b=AdxIrwEq7vfTK49otHGcSQlzjl3TlMoPSZ4KFWucIwJYJ+6MsGI92Wve7YUSyGwoIq
         5t+p78mwWBFcwpDbiFabmw4d9PMBAGX1szmCrTYSZdvzwoDsUvrxUz0LaD9MQ87Y4w9B
         UcwFOlXD5bAFB+t/6JFDzV1wpJmcWDJwrrO2oXvCnRMmSOaErqPsGT1tv7nqNfQ30mGc
         v8Ot482RElvFUfdU+DMk0JPo1ug8YzxQJ+viySXDyLdjaFg6rGWkJSwt/QZiUABdmjoh
         n7WGB7lSlePZ7/YrYLCYW72HgwHMlzF6BnMfiFAtevmQHXu9QiVAPZS5UqcmkDZJqrYq
         D7ug==
X-Gm-Message-State: AOJu0Yyg50Hp6fSYAT3t9nQqsjbVv4qrp3giGkiK9RlVZf5stGIY0qV9
	x7vd6Q9cLH7bfb7nZJh5W+UnrtWdfIExVATq3oYjI16Ncb3u33nMa7UEr0qK98ck0UXl+XR7MNA
	RsXjdcpxWzOClo5DOdO3Dqgtsv0l3Xaw+n797KR/aQ2U2yEmrDxfA51sUvqgqlLQgeNTwWY4yyZ
	IzQ4HUJSjfkI6Y0eFjpqv6vWEQVG7SAIbCHfECZUfwJJlAW5A0kx6mj4I701to/gZu51vwXjqna
	83kMQSpWzQ=
X-Gm-Gg: Acq92OHhdAzGDq1P28/61HJjfz9d0pXpdGoQFh1DOVAvgOhecu0Bup+0bZ79K2Kd5GU
	w2h3sPclaO5KE96oyL8dPX6K22pMj86rS0r7WiNQ2kWzwI4l9bN+9xCcjXvRo0JUJj2CDOEJKGH
	Ru5NsN/QfDrtC0XFuBI/yff0EUzO4Z27sVL5uXTN3KQ4aA0bmADKuoULWjBu45DtzSw606c9jOC
	+ExT1s+FXcZG8qnmByWG/dvEUx6C2oMvTEtD0w+9FPsdXHnFfUBajtVhw/s+/wfAzRrXoiOo1H7
	HBw4dQzLL4SitoUN88oxZop+u1RYtU1MsveLDQjaJVpYOUC5kkz22G7UJtyrH+SzGm1+ob2T3x8
	gDtpir2hGCkrzOcPm+QL+tpuDiw0JI+oeEN42Zte1mnUa7CzpJnb3N+Q/+3UhJyrLVNN/+8H5PI
	wgq8Aa
X-Received: by 2002:a05:6820:2210:b0:68c:5bdb:8c12 with SMTP id 006d021491bc7-69b78e41c2dmr342667eaf.45.1778620910360;
        Tue, 12 May 2026 14:21:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-435570d47desm1616651fac.1.2026.05.12.14.21.49
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2026 14:21:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-13312be8a31so10383048c88.1
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778620909; x=1779225709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+TPih0y8u9yWZG3vHrJncrYyYkqU3A9i4SCsl83w9A=;
        b=Q87QcAu9BN5MFIpGoYqo+ZUlmzEUKHBoCkk460MphltmULdqaUR/Uuv/5vcPjXCkHa
         nm1ACq6wdX0yUS0r6fcVx1HXYqD5RwAIHtlW47fqgVB+0XPqokYQE2+aUFJQ3Dcvs3iC
         9GolMjO6Uaxw7pFjyEGE76zDkPO0Q1tlcHa5Q=
X-Received: by 2002:a05:7022:eace:b0:12d:fda1:e640 with SMTP id a92af1059eb24-1344054bb47mr402803c88.41.1778620908641;
        Tue, 12 May 2026 14:21:48 -0700 (PDT)
X-Received: by 2002:a05:7022:eace:b0:12d:fda1:e640 with SMTP id a92af1059eb24-1344054bb47mr402776c88.41.1778620908092;
        Tue, 12 May 2026 14:21:48 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-132787673ffsm26603202c88.15.2026.05.12.14.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:21:46 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v2 08/15] bnxt_en: Reserve crypto RX and TX key contexts on a PF
Date: Tue, 12 May 2026 14:20:58 -0700
Message-ID: <20260512212105.3488258-9-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260512212105.3488258-1-michael.chan@broadcom.com>
References: <20260512212105.3488258-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 6E41F52A3CB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287316-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:mid,broadcom.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

If kTLS crypto offload is supported, reserve RX and TX key contexts.
These keys will later be allocated during run-time to support offloading
TX and RX kTLS connections.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 15 ++++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     | 11 +++++++
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.c  | 31 +++++++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.h  |  7 +++++
 4 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e2b5f81b36a6..926665c8bb79 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7785,6 +7785,7 @@ static int bnxt_trim_rings(struct bnxt *bp, int *rx, int *tx, int max,
 static int bnxt_hwrm_get_rings(struct bnxt *bp)
 {
 	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
+	struct bnxt_hw_crypto_resc *crypto_resc;
 	struct hwrm_func_qcfg_output *resp;
 	struct hwrm_func_qcfg_input *req;
 	int rc;
@@ -7845,6 +7846,10 @@ static int bnxt_hwrm_get_rings(struct bnxt *bp)
 		}
 		hw_resc->resv_cp_rings = cp;
 		hw_resc->resv_stat_ctxs = stats;
+
+		crypto_resc = &hw_resc->crypto_resc;
+		crypto_resc->resv_tx_key_ctxs = le32_to_cpu(resp->num_ktls_tx_key_ctxs);
+		crypto_resc->resv_rx_key_ctxs = le32_to_cpu(resp->num_ktls_rx_key_ctxs);
 	}
 get_rings_exit:
 	hwrm_req_drop(bp, req);
@@ -7915,8 +7920,9 @@ __bnxt_hwrm_reserve_pf_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 		}
 		req->num_stat_ctxs = cpu_to_le16(hwr->stat);
 		req->num_vnics = cpu_to_le16(hwr->vnic);
+		bnxt_hwrm_reserve_pf_key_ctxs(bp, req);
 	}
-	req->enables = cpu_to_le32(enables);
+	req->enables |= cpu_to_le32(enables);
 	return req;
 }
 
@@ -9748,6 +9754,7 @@ int bnxt_hwrm_func_resc_qcaps(struct bnxt *bp, bool all)
 	struct hwrm_func_resource_qcaps_output *resp;
 	struct hwrm_func_resource_qcaps_input *req;
 	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
+	struct bnxt_hw_crypto_resc *crypto_resc;
 	int rc;
 
 	rc = hwrm_req_init(bp, req, HWRM_FUNC_RESOURCE_QCAPS);
@@ -9785,6 +9792,12 @@ int bnxt_hwrm_func_resc_qcaps(struct bnxt *bp, bool all)
 	    hw_resc->max_vnics * BNXT_LARGE_RSS_TO_VNIC_RATIO)
 		bp->rss_cap |= BNXT_RSS_CAP_LARGE_RSS_CTX;
 
+	crypto_resc = &hw_resc->crypto_resc;
+	crypto_resc->min_tx_key_ctxs = le32_to_cpu(resp->min_ktls_tx_key_ctxs);
+	crypto_resc->max_tx_key_ctxs = le32_to_cpu(resp->max_ktls_tx_key_ctxs);
+	crypto_resc->min_rx_key_ctxs = le32_to_cpu(resp->min_ktls_rx_key_ctxs);
+	crypto_resc->max_rx_key_ctxs = le32_to_cpu(resp->max_ktls_rx_key_ctxs);
+
 	if (bp->flags & BNXT_FLAG_CHIP_P5_PLUS) {
 		u16 max_msix = le16_to_cpu(resp->max_msix);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index f6ff55015ad0..b832780b783d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1362,6 +1362,15 @@ struct bnxt_hw_rings {
 	int rss_ctx;
 };
 
+struct bnxt_hw_crypto_resc {
+	u32	min_tx_key_ctxs;
+	u32	max_tx_key_ctxs;
+	u32	resv_tx_key_ctxs;
+	u32	min_rx_key_ctxs;
+	u32	max_rx_key_ctxs;
+	u32	resv_rx_key_ctxs;
+};
+
 struct bnxt_hw_resc {
 	u16	min_rsscos_ctxs;
 	u16	max_rsscos_ctxs;
@@ -1396,6 +1405,8 @@ struct bnxt_hw_resc {
 	u32	max_tx_wm_flows;
 	u32	max_rx_em_flows;
 	u32	max_rx_wm_flows;
+
+	struct bnxt_hw_crypto_resc	crypto_resc;
 };
 
 #define BNXT_LARGE_RSS_TO_VNIC_RATIO	7
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
index a5fee08eaa67..ee154f1e4e19 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
@@ -76,3 +76,34 @@ void bnxt_free_crypto_info(struct bnxt *bp)
 	kfree(bp->crypto_info);
 	bp->crypto_info = NULL;
 }
+
+/**
+ * bnxt_hwrm_reserve_pf_key_ctxs - Reserve key contexts with firmware
+ * @bp: pointer to bnxt device
+ * @req: pointer to HWRM function config request
+ *
+ * Populates the firmware request with key context reservation parameters
+ * for crypto offload. Calculates the minimum of driver requirements and
+ * firmware capabilities.
+ *
+ * Context: Process context during device configuration
+ */
+void bnxt_hwrm_reserve_pf_key_ctxs(struct bnxt *bp,
+				   struct hwrm_func_cfg_input *req)
+{
+	struct bnxt_crypto_info *crypto = bp->crypto_info;
+	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
+	struct bnxt_hw_crypto_resc *crypto_resc;
+	u32 tx, rx;
+
+	if (!crypto)
+		return;
+
+	crypto_resc = &hw_resc->crypto_resc;
+	tx = min(BNXT_TCK(crypto).max_ctx, crypto_resc->max_tx_key_ctxs);
+	rx = min(BNXT_RCK(crypto).max_ctx, crypto_resc->max_rx_key_ctxs);
+	req->num_ktls_tx_key_ctxs = cpu_to_le32(tx);
+	req->num_ktls_rx_key_ctxs = cpu_to_le32(rx);
+	req->enables |= cpu_to_le32(FUNC_CFG_REQ_ENABLES_KTLS_TX_KEY_CTXS |
+				    FUNC_CFG_REQ_ENABLES_KTLS_RX_KEY_CTXS);
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
index 629388fe1e6d..e090491006db 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
@@ -34,6 +34,8 @@ struct bnxt_crypto_info {
 void bnxt_alloc_crypto_info(struct bnxt *bp,
 			    struct hwrm_func_qcaps_output *resp);
 void bnxt_free_crypto_info(struct bnxt *bp);
+void bnxt_hwrm_reserve_pf_key_ctxs(struct bnxt *bp,
+				   struct hwrm_func_cfg_input *req);
 #else
 static inline void bnxt_alloc_crypto_info(struct bnxt *bp,
 					  struct hwrm_func_qcaps_output *resp)
@@ -43,5 +45,10 @@ static inline void bnxt_alloc_crypto_info(struct bnxt *bp,
 static inline void bnxt_free_crypto_info(struct bnxt *bp)
 {
 }
+
+static inline void bnxt_hwrm_reserve_pf_key_ctxs(struct bnxt *bp,
+						 struct hwrm_func_cfg_input *req)
+{
+}
 #endif	/* CONFIG_BNXT_TLS */
 #endif	/* BNXT_CRYPTO_H */
-- 
2.51.0


