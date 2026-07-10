Return-Path: <netdev+bounces-306429-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CRv4MiN0UGopzQIAu9opvQ
	(envelope-from <netdev+bounces-306429-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 06:25:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEA37371ED
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 06:25:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=ctE7Sjgo;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306429-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306429-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0061E3025A63
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 04:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F3D36DA04;
	Fri, 10 Jul 2026 04:25:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f225.google.com (mail-qt1-f225.google.com [209.85.160.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E850C36B046
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 04:24:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783657500; cv=none; b=OUeHcwfRRR2YbhKBIVFFSZPFaITkHNaLaJtzsPycJTBWU0ZUKAjJDP+TXavzgAVkYHbvC/eFtvPQGy9XTAksf/BJQ+y10255VNl7ZI79AyB9Pws+SDB2OaqKccKNX6QznjFQ80S1Ub24W4odkkhfP/e8ktnvotH9/8cp0qdN920=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783657500; c=relaxed/simple;
	bh=6I67DjKG/iv4oE2liAT0TKP2kDdNLeLaoyk5MEuT5IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3GyV/YNJprGw3up0Ts/3z+xkOQpR/C26rCpk/jylFVd39tsd+b8hoEfVgY7CLMbaIOq5TdUap6YbpUS7utFFBIyBSeeZrpIiogTTirxjOK+S0Cz2ynPxKBEyQrkdQBbHWAUMrGjywqWk7FNw78lnyaNAgwRzrOvPVxnehU32rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ctE7Sjgo; arc=none smtp.client-ip=209.85.160.225
Received: by mail-qt1-f225.google.com with SMTP id d75a77b69052e-51bfad59921so2963891cf.0
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 21:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783657498; x=1784262298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IpO0TIefqazIi8ng/XuFSpnm4NkepZqLglgcy39UM5o=;
        b=Ik2cJK8xkQ+y0dNG+QShiMvjuoAUBsQT6hxjxy5iISApoRV2uR1kbar7xQpQ9t+OXB
         KPTdxjgWIPy+O7lAMVivwyMhoTGFPAgF7Xty3/fFElKewqFxnfkSM6YA0fLHvOeI1o4O
         9KW0giftzMfoYTHBDrmbf1X7cE/URnyU/qyMSbGVXC+zMx7TcZLoadHJpuFn6ltQrCE0
         Rsn0BW5WrhzP1ytThDj5u8Pa0YW8Fo8ZCYjSTegGA61F05HW2EGrrZ4A1D33G2VH6w/c
         dNFWhOnhxmnneNSzw9SRlCLZFzn4trqEJdgHb+edXWUggyHuZvEbd7xL51Y+zG+2mBG2
         UHvg==
X-Gm-Message-State: AOJu0YzUdA7StcW5AD6lvz9VpgI9E2LMof1Vsys8ETJOmkIhztVoMV+x
	IuoIyns9coFAPQyIaFm1OYgRMrifI/oWtyl1JmNXY2NUq9ysJyC9K1zUL94xcPXdNGxbisnmNeW
	CBUkhJ/5Iw7DBrcF0pFpTR+7nZ0HANVxIYpt07LJYohc03tE8bICkrE7KfmKM0/jhsJxtqgapSP
	Kpx8nm0ymSy2Uq4jAu5HPgsJ5HVcC8m/MEoiijSvWVazkhm+4tgiKXA4zQaVA5iLNa/+vIhyXC+
	yKlYvyx4b8=
X-Gm-Gg: AfdE7clK9TtLzInacl6KvFGDR+SWFpGv85pcrDQRLAhf8Tm9coutNtq3LRMPg0wRvv8
	GQog4XalPJ/D8KJSZgsNbmANug92zz7M+UUSJGizr6K9w1lBm1/FRDJxKFAQ8QJm+8MjISxmXwu
	QBk1meEtDznukyYubXHPdajKdMOccZ3ZfLcHkzK6c9htvMkS0WAR75dNkvn5yhOCcgrIGiiOJTB
	N4CtmvUjOPERlhIHeXeBxABLNwF88dF4t4KtFO8fTnzvKZzB02DkC61IyzJ6AiiYHolZhYN4pkG
	vGPHefwYYI+dGrvY/EDqaGo6PsmT5HVTltwfkEC4MMJlU9nxNN9KyVYEFl32Z0rC33zPh6FhP9H
	Vz2NYxyi462MvXHVIs8AzC1wos8MHpVTB6JmbTSsPpd7lrV94OmHwfR8IPh9B0RAP3DjnR8jqQA
	kAUmY3rG5uVru+/gjXpQ46BF1Jamzbbt4RW/IrZQ17202nhw==
X-Received: by 2002:a05:622a:11cb:b0:51b:fc54:c23b with SMTP id d75a77b69052e-51c8b4fda38mr109516191cf.69.1783657497787;
        Thu, 09 Jul 2026 21:24:57 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-51caab534a8sm533291cf.8.2026.07.09.21.24.56
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2026 21:24:57 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38827cee19eso658106a91.3
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 21:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783657496; x=1784262296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IpO0TIefqazIi8ng/XuFSpnm4NkepZqLglgcy39UM5o=;
        b=ctE7SjgoXSLAzCwksZv9FmOCZR23F/a+K/rx/dlQ+wMFk8/D1fxHB82Qco3g5D1B82
         VMBGnUfigdzGGvtp8QYLjJ6ljiJvDWZPGuftuk9NO5javrUrED+VRGRcTWsiYluwm7la
         ysE/DIzezBzdP4A8Abc9Kyz1HNit4HmdHp3Fc=
X-Received: by 2002:a17:90b:2701:b0:38d:a8be:a592 with SMTP id 98e67ed59e1d1-38da8bea6c9mr235289a91.19.1783657495822;
        Thu, 09 Jul 2026 21:24:55 -0700 (PDT)
X-Received: by 2002:a17:90b:2701:b0:38d:a8be:a592 with SMTP id 98e67ed59e1d1-38da8bea6c9mr235257a91.19.1783657495256;
        Thu, 09 Jul 2026 21:24:55 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b4cbafa1sm276627eec.6.2026.07.09.21.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 21:24:54 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v5 08/15] bnxt_en: Reserve crypto RX and TX key contexts on a PF
Date: Thu,  9 Jul 2026 21:23:53 -0700
Message-ID: <20260710042400.3996847-9-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710042400.3996847-1-michael.chan@broadcom.com>
References: <20260710042400.3996847-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[broadcom.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-306429-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:pavan.chebbi@broadcom.com,m:andrew.gospodarek@broadcom.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,broadcom.com:from_mime,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2CEA37371ED

If kTLS crypto offload is supported, reserve RX and TX key contexts.
These keys will later be allocated during run-time to support offloading
TX and RX kTLS connections.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v3:
Add missing ASSETS_TEST flag when checking reserved crypto keys.

v2:
https://lore.kernel.org/netdev/20260512212105.3488258-9-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 22 +++++++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     | 11 +++++++
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.c  | 32 +++++++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.h  |  7 ++++
 4 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index b663824cb559..27f9843f9c5d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7791,6 +7791,7 @@ static int bnxt_trim_rings(struct bnxt *bp, int *rx, int *tx, int max,
 static int bnxt_hwrm_get_rings(struct bnxt *bp)
 {
 	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
+	struct bnxt_hw_crypto_resc *crypto_resc;
 	struct hwrm_func_qcfg_output *resp;
 	struct hwrm_func_qcfg_input *req;
 	int rc;
@@ -7851,6 +7852,10 @@ static int bnxt_hwrm_get_rings(struct bnxt *bp)
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
@@ -7921,8 +7926,9 @@ __bnxt_hwrm_reserve_pf_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 		}
 		req->num_stat_ctxs = cpu_to_le16(hwr->stat);
 		req->num_vnics = cpu_to_le16(hwr->vnic);
+		bnxt_hwrm_reserve_pf_key_ctxs(bp, req);
 	}
-	req->enables = cpu_to_le32(enables);
+	req->enables |= cpu_to_le32(enables);
 	return req;
 }
 
@@ -8324,7 +8330,7 @@ static int bnxt_hwrm_check_vf_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 static int bnxt_hwrm_check_pf_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 {
 	struct hwrm_func_cfg_input *req;
-	u32 flags;
+	u32 flags, flags2 = 0;
 
 	req = __bnxt_hwrm_reserve_pf_rings(bp, hwr);
 	flags = FUNC_CFG_REQ_FLAGS_TX_ASSETS_TEST;
@@ -8338,9 +8344,14 @@ static int bnxt_hwrm_check_pf_rings(struct bnxt *bp, struct bnxt_hw_rings *hwr)
 				 FUNC_CFG_REQ_FLAGS_NQ_ASSETS_TEST;
 		else
 			flags |= FUNC_CFG_REQ_FLAGS_RING_GRP_ASSETS_TEST;
+		if (req->enables &
+		    cpu_to_le32(FUNC_CFG_REQ_ENABLES_KTLS_TX_KEY_CTXS |
+				FUNC_CFG_REQ_ENABLES_KTLS_RX_KEY_CTXS))
+			flags2 |= FUNC_CFG_REQ_FLAGS2_KTLS_KEY_CTX_ASSETS_TEST;
 	}
 
 	req->flags = cpu_to_le32(flags);
+	req->flags2 = cpu_to_le32(flags2);
 	return hwrm_req_send_silent(bp, req);
 }
 
@@ -9754,6 +9765,7 @@ int bnxt_hwrm_func_resc_qcaps(struct bnxt *bp, bool all)
 	struct hwrm_func_resource_qcaps_output *resp;
 	struct hwrm_func_resource_qcaps_input *req;
 	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
+	struct bnxt_hw_crypto_resc *crypto_resc;
 	int rc;
 
 	rc = hwrm_req_init(bp, req, HWRM_FUNC_RESOURCE_QCAPS);
@@ -9791,6 +9803,12 @@ int bnxt_hwrm_func_resc_qcaps(struct bnxt *bp, bool all)
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
index 621f275b49fd..1302c39a7af9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1363,6 +1363,15 @@ struct bnxt_hw_rings {
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
@@ -1397,6 +1406,8 @@ struct bnxt_hw_resc {
 	u32	max_tx_wm_flows;
 	u32	max_rx_em_flows;
 	u32	max_rx_wm_flows;
+
+	struct bnxt_hw_crypto_resc	crypto_resc;
 };
 
 #define BNXT_LARGE_RSS_TO_VNIC_RATIO	7
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
index 5bc31ee8d7fd..b2a96ac725ea 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
@@ -81,3 +81,35 @@ void bnxt_free_crypto_info(struct bnxt *bp)
 	bp->crypto_info = NULL;
 	bp->fw_cap &= ~BNXT_FW_CAP_KTLS;
 }
+
+/**
+ * bnxt_hwrm_reserve_pf_key_ctxs - Reserve key contexts with firmware
+ * @bp: pointer to bnxt device
+ * @req: pointer to HWRM function config request
+ *
+ * Populates the firmware request with key context reservation parameters
+ * for crypto offload based on current max settings and capabilities.
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
+	if (!crypto || !BNXT_SUPPORTS_KTLS(bp))
+		return;
+
+	crypto_resc = &hw_resc->crypto_resc;
+	tx = min(BNXT_TCK(crypto).max_ctx, crypto_resc->max_tx_key_ctxs);
+	rx = min(BNXT_RCK(crypto).max_ctx, crypto_resc->max_rx_key_ctxs);
+	req->num_ktls_tx_key_ctxs = cpu_to_le32(tx);
+	req->num_ktls_rx_key_ctxs = cpu_to_le32(rx);
+	if (tx)
+		req->enables |= cpu_to_le32(FUNC_CFG_REQ_ENABLES_KTLS_TX_KEY_CTXS);
+	if (rx)
+		req->enables |= cpu_to_le32(FUNC_CFG_REQ_ENABLES_KTLS_RX_KEY_CTXS);
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


