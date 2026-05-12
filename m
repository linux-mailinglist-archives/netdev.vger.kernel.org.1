Return-Path: <netdev+bounces-287314-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4E3IBF2aA2p27wEAu9opvQ
	(envelope-from <netdev+bounces-287314-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:23:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A664852A3BB
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D788730D3AC0
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 21:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D8437F019;
	Tue, 12 May 2026 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AbwssM0h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f99.google.com (mail-vs1-f99.google.com [209.85.217.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06C837C914
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 21:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620909; cv=none; b=U5Dv4DkKweyVvYktBs6XynWAECvPaDLl+/WNWmg8dTZ4ziiLA5ghfHwYObPXWdcJiZt1i69po1xPhP5+2DSLHp7WMj/thRDfRATmvq4wTs93V3pTy4HU1dpH0jxXo+uMoKXchj98aqPT3uMDRa/7W1UnHRWuY6c6LFNbpmAHfNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620909; c=relaxed/simple;
	bh=yNfV056uT0kG8t6TamaLpkdqtCq4JpJFmbBZwkzNTG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dh58VQrYcIlH8JncfDXx1qZU4UX+NDNj+VbN48nsRgPbpIHfQyO29xojSRSmwTyMgyWRy9aKgQIhHqjAwSDHmwNVAI7AqXzuV/jQRGqVy5KKM+ywLSRLF5jvuacInqaHCRWmYZaf9NwYQLlvZS83Z3EHX2q1764Ed+hYrHtuh4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AbwssM0h; arc=none smtp.client-ip=209.85.217.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f99.google.com with SMTP id ada2fe7eead31-63129bf2af0so2069411137.2
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:21:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778620907; x=1779225707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I/ICajttLlwSzVctMN0OPu4kN5k0cTwfrMgA+Q4Smjs=;
        b=lkWt9Vj8sNzLXsI0hw892Anxm0sIdGHSgIC9aJLYdhMVeNudTkSbq1036UA14PpiRU
         f0nGIhKK4GUsa/9OMYxc82gaqDOnyOVKa9WbTh+xsIJLmUHJY8XmJxQchQu0o/4F2tBr
         5qwQ92WAhB7HpbSSSLF29s5MMbq3bgz643u62RMOcD0vmwGU4k1WtdCo8GRDWufDRCqs
         qyruBK7TzApgZ1lUR5YVZg/U8y9Dd3l73BL40SNhyJ16xlUZhgJdkpPA1zumM8VkyUWi
         2ogohnfySm6ohhiHo9fEWUxh+y4f5XEsAqMKnlP442kwfadVYdzGPmuvyhwKuEMzCExW
         yZYg==
X-Gm-Message-State: AOJu0YxvUao7QTKhMldi7D3TWU4kuviQEwR/Hlgq0Giz7RKE26QayXpI
	6+0hYsXO4CbMdwqAlqGB2yGEWZkuLvCJ3aLvjiRBPH+VyXzDv6G+gOW5IKuECqd07Lz24Q7CJeP
	jroNx3bN3jgSpjxt7+y0BOgeQtNdQrUHFs7nOmQJTqUcQGINYYu1wEj7byk6JGlsGzTrSCk0OZD
	mmz95WxL/xBg/tHbqJyQPGBjsm+gzvH81m8TNGkETymInS6DCbbPiB9j40fn6/SgmDqSobl1fn1
	Zj2MZzjQS4=
X-Gm-Gg: Acq92OFDD9OaLws4jDgJumd99GKeJYstfrU21Fw/jS2EJDC2I1QPxIcpoQD/VeUg9tI
	My9yX7rIAtJHlplwjS6PhbG/NJQjo+iNEaPDSyR4MbuptCAVhrSdVqFMtR5rbIAhZEdayFm0UTS
	iSWUh19oQqixDgdwpw6usX8sU5atcH9fjqS2fLmekuUVt6F6X9MQvgII8CorktgnH4RdH+0ASun
	Cr+pOTyQ3BKqgSAF63kIK9NNr6UNDSenitt+fENmXBzQMhqvGh4jm+iHHclgP26Ix43RJC4oodm
	puF2vpNcLS4TeOO/2n90ToBJOcSHXaMPMI2Rpgkg3P4psiEusE21YxYI9xyGssJGReL+DVtUcnA
	UTbf7b4F8QyYfJv7PMlGlAAG3rs1adJSMKg9BPGxEYLGuQ838JeaUO5RdCTuUbiPxY2riX/GMyt
	hz+VV91FrCACtvJ3UUyM5B209/1f0u5CVIgQHt+GMi3SgSm+wjWP3Gghoa
X-Received: by 2002:a05:6102:1625:b0:631:3b92:9dcc with SMTP id ada2fe7eead31-637752e126bmr257655137.27.1778620906744;
        Tue, 12 May 2026 14:21:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-95f219c7bc3sm899694241.1.2026.05.12.14.21.45
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2026 14:21:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2ef37c3f773so7246127eec.1
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778620905; x=1779225705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/ICajttLlwSzVctMN0OPu4kN5k0cTwfrMgA+Q4Smjs=;
        b=AbwssM0hIo0kkUF60k2SUH19A+DAZ8DjL91N+sKEzhbhr6EiSHzJQvHROX5hM8RrUK
         HG9bXPoLZE1XW2+bT2q3NRw18DCIVVRiYqsM8niBn5xV1JoeR+x3nTj6i7V9mHGc6Mdi
         EiF33mJQs/Tu/cKpZMgeVD/jnpDQtfBQMBLuI=
X-Received: by 2002:a05:7022:419f:b0:130:ac5d:8f68 with SMTP id a92af1059eb24-1342ee39db3mr370398c88.3.1778620904568;
        Tue, 12 May 2026 14:21:44 -0700 (PDT)
X-Received: by 2002:a05:7022:419f:b0:130:ac5d:8f68 with SMTP id a92af1059eb24-1342ee39db3mr370379c88.3.1778620903970;
        Tue, 12 May 2026 14:21:43 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-132787673ffsm26603202c88.15.2026.05.12.14.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:21:43 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Ajit Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next v2 06/15] bnxt_en: Allocate and free MPC channels from firmware
Date: Tue, 12 May 2026 14:20:56 -0700
Message-ID: <20260512212105.3488258-7-michael.chan@broadcom.com>
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
X-Rspamd-Queue-Id: A664852A3BB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287314-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:mid,broadcom.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Allocate and free the reserved MPC TX rings and completion rings from
firmware.  MPC backing store memory also needs to be configured in
order to successfully allocate the MPC TX rings.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 30 ++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  6 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c | 92 +++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h | 16 ++++
 4 files changed, 135 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index b1789a4ea439..9620eb9624d4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7473,8 +7473,7 @@ static int bnxt_hwrm_rx_agg_ring_alloc(struct bnxt *bp,
 	return 0;
 }
 
-static int bnxt_hwrm_cp_ring_alloc_p5(struct bnxt *bp,
-				      struct bnxt_cp_ring_info *cpr)
+int bnxt_hwrm_cp_ring_alloc_p5(struct bnxt *bp, struct bnxt_cp_ring_info *cpr)
 {
 	const u32 type = HWRM_RING_ALLOC_CMPL;
 	struct bnxt_napi *bnapi = cpr->bnapi;
@@ -7492,8 +7491,8 @@ static int bnxt_hwrm_cp_ring_alloc_p5(struct bnxt *bp,
 	return 0;
 }
 
-static int bnxt_hwrm_tx_ring_alloc(struct bnxt *bp,
-				   struct bnxt_tx_ring_info *txr, u32 tx_idx)
+int bnxt_hwrm_tx_ring_alloc(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			    u32 tx_idx)
 {
 	struct bnxt_ring_struct *ring = &txr->tx_ring_struct;
 	const u32 type = HWRM_RING_ALLOC_TX;
@@ -7578,6 +7577,9 @@ static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
 				goto err_out;
 		}
 	}
+
+	rc = bnxt_hwrm_mpc_ring_alloc(bp);
+
 err_out:
 	return rc;
 }
@@ -7635,9 +7637,8 @@ static int hwrm_ring_free_send_msg(struct bnxt *bp,
 	return 0;
 }
 
-static void bnxt_hwrm_tx_ring_free(struct bnxt *bp,
-				   struct bnxt_tx_ring_info *txr,
-				   bool close_path)
+void bnxt_hwrm_tx_ring_free(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			    bool close_path)
 {
 	struct bnxt_ring_struct *ring = &txr->tx_ring_struct;
 	u32 cmpl_ring_id;
@@ -7696,8 +7697,7 @@ static void bnxt_hwrm_rx_agg_ring_free(struct bnxt *bp,
 	bp->grp_info[grp_idx].agg_fw_ring_id = INVALID_HW_RING_ID;
 }
 
-static void bnxt_hwrm_cp_ring_free(struct bnxt *bp,
-				   struct bnxt_cp_ring_info *cpr)
+void bnxt_hwrm_cp_ring_free(struct bnxt *bp, struct bnxt_cp_ring_info *cpr)
 {
 	struct bnxt_ring_struct *ring;
 
@@ -7731,6 +7731,8 @@ static void bnxt_hwrm_ring_free(struct bnxt *bp, bool close_path)
 	if (!bp->bnapi)
 		return;
 
+	bnxt_hwrm_mpc_ring_free(bp, close_path);
+
 	for (i = 0; i < bp->tx_nr_rings; i++)
 		bnxt_hwrm_tx_ring_free(bp, &bp->tx_ring[i], close_path);
 
@@ -9368,12 +9370,21 @@ static int bnxt_hwrm_func_backing_store_cfg_v2(struct bnxt *bp,
 
 static int bnxt_backing_store_cfg_v2(struct bnxt *bp)
 {
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
 	struct bnxt_ctx_mem_info *ctx = bp->ctx;
 	struct bnxt_ctx_mem_type *ctxm;
 	u16 last_type = BNXT_CTX_INV;
 	int rc = 0;
 	u16 type;
 
+	if (mpc && mpc->mpc_chnls_cap) {
+		ctxm = &ctx->ctx_arr[BNXT_CTX_MTQM];
+		rc = bnxt_setup_ctxm_pg_tbls(bp, ctxm, ctxm->max_entries, 1);
+		if (rc)
+			return rc;
+		last_type = BNXT_CTX_MTQM;
+	}
+
 	for (type = BNXT_CTX_SRT; type <= BNXT_CTX_QPC; type++) {
 		ctxm = &ctx->ctx_arr[type];
 		if (!bnxt_bs_trace_avail(bp, type))
@@ -11320,6 +11331,7 @@ static int bnxt_init_nic(struct bnxt *bp, bool irq_re_init)
 	bnxt_init_cp_rings(bp);
 	bnxt_init_rx_rings(bp);
 	bnxt_init_tx_rings(bp);
+	bnxt_init_mpc_rings(bp);
 	bnxt_init_ring_grps(bp, irq_re_init);
 	bnxt_init_vnics(bp);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 253c0739f680..72a0b511b7e9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2999,6 +2999,12 @@ int bnxt_hwrm_vnic_cfg(struct bnxt *bp, struct bnxt_vnic_info *vnic);
 int bnxt_hwrm_vnic_alloc(struct bnxt *bp, struct bnxt_vnic_info *vnic,
 			 unsigned int start_rx_ring_idx,
 			 unsigned int nr_rings);
+int bnxt_hwrm_cp_ring_alloc_p5(struct bnxt *bp, struct bnxt_cp_ring_info *cpr);
+int bnxt_hwrm_tx_ring_alloc(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			    u32 tx_idx);
+void bnxt_hwrm_tx_ring_free(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			    bool close_path);
+void bnxt_hwrm_cp_ring_free(struct bnxt *bp, struct bnxt_cp_ring_info *cpr);
 int bnxt_total_tx_rings(struct bnxt *bp);
 int __bnxt_hwrm_get_tx_rings(struct bnxt *bp, u16 fid, int *tx_rings);
 int bnxt_nq_rings_in_use(struct bnxt *bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
index b796cd3bfeee..a121bdcf9686 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
@@ -312,3 +312,95 @@ void bnxt_free_mpc_rings(struct bnxt *bp)
 		}
 	}
 }
+
+void bnxt_init_mpc_rings(struct bnxt *bp)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	int i, j;
+
+	if (!mpc)
+		return;
+
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		int num = mpc->mpc_ring_count[i];
+
+		for (j = 0; j < num; j++) {
+			struct bnxt_tx_ring_info *txr = &mpc->mpc_rings[i][j];
+			struct bnxt_ring_struct *ring = &txr->tx_ring_struct;
+
+			txr->tx_prod = 0;
+			txr->tx_cons = 0;
+			txr->tx_hw_cons = 0;
+			ring->fw_ring_id = INVALID_HW_RING_ID;
+		}
+	}
+}
+
+static int bnxt_hwrm_one_mpc_ring_alloc(struct bnxt *bp,
+					struct bnxt_tx_ring_info *txr)
+{
+	struct bnxt_cp_ring_info *cpr = txr->tx_cpr;
+	struct bnxt_ring_struct *ring;
+	int rc;
+
+	ring = &cpr->cp_ring_struct;
+	if (ring->fw_ring_id == INVALID_HW_RING_ID) {
+		rc = bnxt_hwrm_cp_ring_alloc_p5(bp, cpr);
+		if (rc)
+			return rc;
+	}
+	/* tx_idx not used on P5_PLUS, so set it to 0 */
+	return bnxt_hwrm_tx_ring_alloc(bp, txr, 0);
+}
+
+int bnxt_hwrm_mpc_ring_alloc(struct bnxt *bp)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	int i, j, rc = 0;
+
+	if (!mpc)
+		return 0;
+
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		int num = mpc->mpc_ring_count[i];
+
+		for (j = 0; j < num; j++) {
+			struct bnxt_tx_ring_info *txr = &mpc->mpc_rings[i][j];
+
+			rc = bnxt_hwrm_one_mpc_ring_alloc(bp, txr);
+			if (rc)
+				goto mpc_ring_alloc_exit;
+		}
+	}
+mpc_ring_alloc_exit:
+	if (rc)
+		bnxt_hwrm_mpc_ring_free(bp, false);
+	return rc;
+}
+
+void bnxt_hwrm_mpc_ring_free(struct bnxt *bp, bool close_path)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	struct bnxt_cp_ring_info *cpr;
+	int i, j;
+
+	if (!mpc)
+		return;
+
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		for (j = 0; j < mpc->mpc_ring_count[i]; j++)
+			bnxt_hwrm_tx_ring_free(bp, &mpc->mpc_rings[i][j],
+					       close_path);
+	}
+	/* CP rings must be freed at the end to guarantee that the HWRM_DONE
+	 * responses for HWRM_RING_FREE can still be seen on the CP rings.
+	 */
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		for (j = 0; j < mpc->mpc_ring_count[i]; j++) {
+			cpr = mpc->mpc_rings[i][j].tx_cpr;
+			if (cpr && cpr->cp_ring_struct.fw_ring_id !=
+			    INVALID_HW_RING_ID)
+				bnxt_hwrm_cp_ring_free(bp, cpr);
+		}
+	}
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
index b54daf4ddd2f..cdc03a074963 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
@@ -58,6 +58,9 @@ int bnxt_alloc_mpcs(struct bnxt *bp);
 void bnxt_free_mpcs(struct bnxt *bp);
 int bnxt_alloc_mpc_rings(struct bnxt *bp);
 void bnxt_free_mpc_rings(struct bnxt *bp);
+void bnxt_init_mpc_rings(struct bnxt *bp);
+int bnxt_hwrm_mpc_ring_alloc(struct bnxt *bp);
+void bnxt_hwrm_mpc_ring_free(struct bnxt *bp, bool close_path);
 #else
 static inline void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap)
 {
@@ -116,5 +119,18 @@ static inline int bnxt_alloc_mpc_rings(struct bnxt *bp)
 static inline void bnxt_free_mpc_rings(struct bnxt *bp)
 {
 }
+
+static inline void bnxt_init_mpc_rings(struct bnxt *bp)
+{
+}
+
+static inline int bnxt_hwrm_mpc_ring_alloc(struct bnxt *bp)
+{
+	return 0;
+}
+
+static inline void bnxt_hwrm_mpc_ring_free(struct bnxt *bp, bool close_path)
+{
+}
 #endif	/* CONFIG_BNXT_TLS */
 #endif	/* BNXT_MPC_H */
-- 
2.51.0


