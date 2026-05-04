Return-Path: <netdev+bounces-284106-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLE6Auky+WkG6gIAu9opvQ
	(envelope-from <netdev+bounces-284106-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 01:59:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8F84C50C4
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 01:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7371C301AB86
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 23:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF44238B150;
	Mon,  4 May 2026 23:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P2lG1jRq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com [209.85.210.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACA63FFABE
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 23:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777939173; cv=none; b=rC7On5gHO2hBY0TtDuxIJSo1uveUfuzvQNHqjK8gRnjtofauQzpP2G3DllJkAlHJ2VPxzGknM43QIUQysQqPzKwuDeXZkdt2fNQPPfJzU1NgDH9tQXMTTdcjqATaw0Cbsz9uxVQthsdYoQxmtBc7hCz5uDGXdQ3GnKZTMrjY7i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777939173; c=relaxed/simple;
	bh=amRRiu0aK0QZ4jEkCDVaAuE7T4x5CWoHYuIEU2VgNy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+vNSlH+rLa/dpMw2p4ifMx5t6eueu3Z2I2JGTAWKFZyxptSotvgUcj7/r8xnyCkLu5OIETcJtbqqXRixi6DUj8nlR9mp7e1gO4WSlNq7vM4ndomEEnU8Ip2DifXEosIMxMFQmFiy7NoXRFDNtzil/d/zKim1kQbjMCLmVVkpA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=P2lG1jRq; arc=none smtp.client-ip=209.85.210.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f100.google.com with SMTP id 46e09a7af769-7df05fc49e5so1207980a34.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 16:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777939171; x=1778543971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EN6Eb3kNOgIHgG2LCVa4RZoBVKiQH3T4+Te+iscrSxs=;
        b=TlIDFILnlPEipCmdqsJb9ilCCfNeKsxC73ePMZgs7V4gmGoxBNhdwAbzn6eigVYeYt
         Tcgv7jKk0aaTXAshsRoKvlKimdjVsI0GmgCHesnAAj49Lv55S73GRkN3Na5CIG9XJACD
         6XnKK6MscQBZU1lLHhyMg5LNMzrIQPX1EZAZ1K+tAkETIEVseU2iH5Kz8aAcmnI0M8SM
         kOtatzhR/h6occ8kInf79jPKSjM5NVRwueWG5mJJcpKN2XS5tWo+xsRpCA5AcVt5mw95
         3i8gisYYnubppiqNXb35yj2hwCvl9AqdA5vD+zLFmssTqHrP9/TvMRp3UM3w1HhdmNsm
         HzUw==
X-Gm-Message-State: AOJu0Yz8jNykv9zNtwlppNgLHof64iDtx3l8DBwlnM12wpfdv6bWEnPu
	hIuDEyluPejN6OqCO6h3XZGf1Q9qzIDzBYeV2Qwc5Uib2C7bStz99G/NfZakFe1H+V14OSTFe1a
	0lGeuFMAaPRUQ2WjfaPWfNPNqFarc6Bn6rqFpjE3E9std+d78mmMjc1+CWbT0QJm0lV743qjDg9
	yjvt/XDN+YqNAI6Q0k10fssa7TJymccUGGCLPjVrAJMAkGmVgv8s1RCCVCWlrwhyHrIP9ffjlOD
	tgstasrMk8=
X-Gm-Gg: AeBDieuTN4UoeY2nFPysSaEwRJWAA6J3R88tU5Nr8Y2ivkcPzeZkPHnwa+xsooEfeVR
	S7qJ6skVvEta7ZpoHkJMIV7U8tWNJNPP2XAz+ozityV4uqnXyv4hhpS2D43t2yHW0VGbg5RgIU2
	Fg5U2A9tjAJkpkTjev4LKAZQNyLL39pH9zbNhijifb9mfycAKJ/PMUTtqkstEIFIRLOO5kGx4sE
	oHf+eFEj90lB+jVentP6hTMOHAaIY9mnELDNWCtUWYcqRQ3MFYA/cSV/+a0YZ7J6qHJd759QK5i
	ZcLYVUgIszkdfauLGRJWH16rqDC1OUwniMJoiAi9bOJVimqppGBEzaXe1gFORZpKYfvyC1cqzZm
	Mt894raEvaAnscOjKFPbq8eWIz59nS0isMFq7Q15FBR6euMHkPj6M2qJKwIuceAwwB1l/aUIdc3
	z8Loua0dnu95rmkf4k4dDgASUTvZjSJVKeKY2ZwrZzuhqpYsFeF9h338cMMDicWm6DDRYzyg==
X-Received: by 2002:a05:6830:4117:b0:7de:4198:7a2f with SMTP id 46e09a7af769-7dee1431b12mr7753839a34.16.1777939170880;
        Mon, 04 May 2026 16:59:30 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7decab71957sm1362356a34.7.2026.05.04.16.59.30
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2026 16:59:30 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8b7e68098dcso46451116d6.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 16:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777939169; x=1778543969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EN6Eb3kNOgIHgG2LCVa4RZoBVKiQH3T4+Te+iscrSxs=;
        b=P2lG1jRqqdmBOgp8l3PNzmZTQ0nf6hpn2fI2vsO2Mao4ySUAOWAmV5JXFg27VXl6mI
         eeAAVII5dbMRmDI9u6NqsLy1LwLDUKcv5gM0wgqvxYnc/yMIlD+/pWztChLZSaUG1LTv
         OVVk+PGDFSm59I57jXyH88AOXZSPon+c82Pg8=
X-Received: by 2002:a05:6214:2403:b0:8b4:a0be:4b50 with SMTP id 6a1803df08f44-8b7b092fda0mr158812676d6.33.1777939167920;
        Mon, 04 May 2026 16:59:27 -0700 (PDT)
X-Received: by 2002:a05:6214:2403:b0:8b4:a0be:4b50 with SMTP id 6a1803df08f44-8b7b092fda0mr158812436d6.33.1777939167410;
        Mon, 04 May 2026 16:59:27 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b5396c4b7dsm132298246d6.18.2026.05.04.16.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 16:59:26 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next 08/15] bnxt_en: Reserve crypto RX and TX key contexts on a PF
Date: Mon,  4 May 2026 16:58:29 -0700
Message-ID: <20260504235836.3019499-9-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260504235836.3019499-1-michael.chan@broadcom.com>
References: <20260504235836.3019499-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 7A8F84C50C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-284106-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]

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
index 225edc6fd1c5..95177b03093a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7782,6 +7782,7 @@ static int bnxt_trim_rings(struct bnxt *bp, int *rx, int *tx, int max,
 static int bnxt_hwrm_get_rings(struct bnxt *bp)
 {
 	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
+	struct bnxt_hw_crypto_resc *crypto_resc;
 	struct hwrm_func_qcfg_output *resp;
 	struct hwrm_func_qcfg_input *req;
 	int rc;
@@ -7842,6 +7843,10 @@ static int bnxt_hwrm_get_rings(struct bnxt *bp)
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
@@ -7912,8 +7917,9 @@ __bnxt_hwrm_reserve_pf_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 		}
 		req->num_stat_ctxs = cpu_to_le16(hwr->stat);
 		req->num_vnics = cpu_to_le16(hwr->vnic);
+		bnxt_hwrm_reserve_pf_key_ctxs(bp, req);
 	}
-	req->enables = cpu_to_le32(enables);
+	req->enables |= cpu_to_le32(enables);
 	return req;
 }
 
@@ -9745,6 +9751,7 @@ int bnxt_hwrm_func_resc_qcaps(struct bnxt *bp, bool all)
 	struct hwrm_func_resource_qcaps_output *resp;
 	struct hwrm_func_resource_qcaps_input *req;
 	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
+	struct bnxt_hw_crypto_resc *crypto_resc;
 	int rc;
 
 	rc = hwrm_req_init(bp, req, HWRM_FUNC_RESOURCE_QCAPS);
@@ -9782,6 +9789,12 @@ int bnxt_hwrm_func_resc_qcaps(struct bnxt *bp, bool all)
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


