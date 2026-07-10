Return-Path: <netdev+bounces-306427-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uIZnGY50UGpEzQIAu9opvQ
	(envelope-from <netdev+bounces-306427-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 06:26:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD140737210
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 06:26:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=OHUlVMlZ;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306427-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306427-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 918F930393BE
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 04:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CED636CE14;
	Fri, 10 Jul 2026 04:24:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9771C36B046
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 04:24:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783657497; cv=none; b=gXbasr7UkxPqDqHaW0P47F6r9LKVrWIXMwTRpIKvUCzmy6CuUyok947MvDiRpv8MBfhA8412HMsptPf9Lpj36fbEdNybhPzuQ38n6mtDYYf9NQXPlrTDtGfClPN5V68rKF/h22Gz+9aoI3AlSIOmKsKrSyVm9XG1OF8NIXjtLbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783657497; c=relaxed/simple;
	bh=z+jfBRbHqRQjRP1cnTqrrtLClMtB3ustu8NR6y9LEDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovS/cnV4z/Kezo0S6OvBlO5QjmgqyTpXF3fRcF5h2r/zcDznmFL2t5x7TlPGSOn8Dj6h7co2PdkOSlWSMHSlyuNAWua3Ld4klsLY/sum5eNbZATQiewz+ZwIpfclnfmOnAWyTppswvutztg+OngLDqY00MtzFKJHYiVabXPNHCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OHUlVMlZ; arc=none smtp.client-ip=209.85.216.98
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3825c406ffeso548026a91.0
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 21:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783657495; x=1784262295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4pE9f3Tfpw7MtzTK/FW1aeiBJ4ASGNrFRRkkhHOHi4M=;
        b=sdFs5rP6F8yHTN7/lORC8qY8Cdwi92xBJogQxd8ndxrcjKOnsEwSVPIRzx9aQbIO+4
         MsFwfgjxzBJTfP6bnsmpdSlZmL+o4OXACB/StfDlS6ncxNejM0mQZZG6s7gdAEZkxZyG
         OjYLRVTcTmH91A4oh4oUYYmHR1d5pqr/oT3sfH25udfhsSWCcXOLCsJ+QF2X0ZiP42Qc
         RmW2YPjTVy13Ltvup19CHl2HBr+4Y6ptmGXohdBe5vr5eL/5yMN+GUcE/JDslRimjRp+
         ye6qn5rw7WLUs7iiiV/hKNebKWHR1cHYPLT3WUrPwjvARANTdfXdxwUadSwAIqDJkMgW
         6xhA==
X-Gm-Message-State: AOJu0Yw6/ddBeA1ffOgS7sCsczuSnFQD+erSho5oNjHfcbJqBIYmAKq7
	Ik3dZciodDJbeagJMRqN3ftBFLQhxcYIYeSZHLqec0bHlV1RZSsHv7FdFXDtjPlHO9qamnEsd4K
	8drd/gRs9v6R8jrZR5aeu/Avt9+kj8wVGwS2urcie710/KDmzbu2A8r+mklEViD+twsTUhmrlFl
	taonFWmrP2T6/sYRcOZ3+J0UwhH7JGmR2gY9/h8poLrKecBv9hT8hhez9/2/8v2phTZy7OBc8yI
	pFxSi6OR7I=
X-Gm-Gg: AfdE7cnrsd74fxKPIq+WVK3TVb5Iefqs79VddGCq4032vtUVAnvydHNCWCIT9cfDnrR
	jaVUEDCHERiQhPgy5h8lrAMJVbz74Gd/7V5z419U0knFLzdma2wNHHLnAOULYYFjZwjLBue3XjL
	nqoe0hRsf77KFkuOX843cIDqQkMTHO+H/xPaczpvU4GQcal9kB0yODMP2Mdoaa95OxIiunDOqYu
	cURVC5jM/0xBdbp7d4LgsenTVpM/SL4Hg5OgxZ/9NN80Q5yv+a6WJvVxGb62pzQmRJZ7ypu5/BB
	94ZDo74yEfQwh0yQZHHd6y0vcPY9U8SJ6tIez1B83z7uDc2zU4Jmdv4NBWPQaS/oqwoBpXlJmF1
	pQIW4AvOZL4HgR7hVWsXwQy3JADLia9NfxWOpPPSXOlf3dOa/fAiyKZ+h1lTAbSo6NkXViHVgCM
	ruzHzaZU69cQA4aWuVwImqkQN4w0n0iYfxp+5sgkqsms7DzQ==
X-Received: by 2002:a05:6a21:700b:b0:3c0:9c19:65a5 with SMTP id adf61e73a8af0-3c0bd3137b7mr13094471637.61.1783657494855;
        Thu, 09 Jul 2026 21:24:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-13b6593d84fsm198096c88.2.2026.07.09.21.24.54
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2026 21:24:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8486c3411c8so701829b3a.2
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 21:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783657493; x=1784262293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4pE9f3Tfpw7MtzTK/FW1aeiBJ4ASGNrFRRkkhHOHi4M=;
        b=OHUlVMlZNq0xfB/LtPRnoVVIekC8gdUNEmjWG85D4PRYY3llVPZVF88AtY745Ru97G
         bay/Od5fp8l4gj4024hAUisOPBXZg4ryUwWIJn1QNIOBYcwdzAd8kNrY/QYzA9aCL/cW
         UuuVJbG5hYr+Oj/GKrruPG0pivgbHrskvK/e0=
X-Received: by 2002:a05:6a20:d499:b0:3c0:9c19:65ad with SMTP id adf61e73a8af0-3c0bd37b743mr12026364637.69.1783657492860;
        Thu, 09 Jul 2026 21:24:52 -0700 (PDT)
X-Received: by 2002:a05:6a20:d499:b0:3c0:9c19:65ad with SMTP id adf61e73a8af0-3c0bd37b743mr12026331637.69.1783657492319;
        Thu, 09 Jul 2026 21:24:52 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b4cbafa1sm276627eec.6.2026.07.09.21.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 21:24:51 -0700 (PDT)
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
Subject: [PATCH net-next v5 06/15] bnxt_en: Allocate and free MPC channels from firmware
Date: Thu,  9 Jul 2026 21:23:51 -0700
Message-ID: <20260710042400.3996847-7-michael.chan@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-306427-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:pavan.chebbi@broadcom.com,m:andrew.gospodarek@broadcom.com,m:ajit.khaparde@broadcom.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:from_mime,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD140737210

Allocate and free the reserved MPC TX rings and completion rings from
firmware.  MPC backing store memory also needs to be configured in
order to successfully allocate the MPC TX rings.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 30 ++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  6 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c | 93 +++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h | 16 ++++
 4 files changed, 136 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index e606cce3af0f..e68b970bf21b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7479,8 +7479,7 @@ static int bnxt_hwrm_rx_agg_ring_alloc(struct bnxt *bp,
 	return 0;
 }
 
-static int bnxt_hwrm_cp_ring_alloc_p5(struct bnxt *bp,
-				      struct bnxt_cp_ring_info *cpr)
+int bnxt_hwrm_cp_ring_alloc_p5(struct bnxt *bp, struct bnxt_cp_ring_info *cpr)
 {
 	const u32 type = HWRM_RING_ALLOC_CMPL;
 	struct bnxt_napi *bnapi = cpr->bnapi;
@@ -7498,8 +7497,8 @@ static int bnxt_hwrm_cp_ring_alloc_p5(struct bnxt *bp,
 	return 0;
 }
 
-static int bnxt_hwrm_tx_ring_alloc(struct bnxt *bp,
-				   struct bnxt_tx_ring_info *txr, u32 tx_idx)
+int bnxt_hwrm_tx_ring_alloc(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			    u32 tx_idx)
 {
 	struct bnxt_ring_struct *ring = &txr->tx_ring_struct;
 	const u32 type = HWRM_RING_ALLOC_TX;
@@ -7584,6 +7583,9 @@ static int bnxt_hwrm_ring_alloc(struct bnxt *bp)
 				goto err_out;
 		}
 	}
+
+	rc = bnxt_hwrm_mpc_ring_alloc(bp);
+
 err_out:
 	return rc;
 }
@@ -7641,9 +7643,8 @@ static int hwrm_ring_free_send_msg(struct bnxt *bp,
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
@@ -7702,8 +7703,7 @@ static void bnxt_hwrm_rx_agg_ring_free(struct bnxt *bp,
 	bp->grp_info[grp_idx].agg_fw_ring_id = INVALID_HW_RING_ID;
 }
 
-static void bnxt_hwrm_cp_ring_free(struct bnxt *bp,
-				   struct bnxt_cp_ring_info *cpr)
+void bnxt_hwrm_cp_ring_free(struct bnxt *bp, struct bnxt_cp_ring_info *cpr)
 {
 	struct bnxt_ring_struct *ring;
 
@@ -7737,6 +7737,8 @@ static void bnxt_hwrm_ring_free(struct bnxt *bp, bool close_path)
 	if (!bp->bnapi)
 		return;
 
+	bnxt_hwrm_mpc_ring_free(bp, close_path);
+
 	for (i = 0; i < bp->tx_nr_rings; i++)
 		bnxt_hwrm_tx_ring_free(bp, &bp->tx_ring[i], close_path);
 
@@ -9374,12 +9376,21 @@ static int bnxt_hwrm_func_backing_store_cfg_v2(struct bnxt *bp,
 
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
@@ -11369,6 +11380,7 @@ static int bnxt_init_nic(struct bnxt *bp, bool irq_re_init)
 	bnxt_init_cp_rings(bp);
 	bnxt_init_rx_rings(bp);
 	bnxt_init_tx_rings(bp);
+	bnxt_init_mpc_rings(bp);
 	bnxt_init_ring_grps(bp, irq_re_init);
 	bnxt_init_vnics(bp);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 11edc5752d99..416ae86111fa 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -3002,6 +3002,12 @@ int bnxt_hwrm_vnic_cfg(struct bnxt *bp, struct bnxt_vnic_info *vnic);
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
index a595c9b36218..40351b7c0b82 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
@@ -325,3 +325,96 @@ void bnxt_free_mpc_rings(struct bnxt *bp)
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
+			WRITE_ONCE(txr->dev_state, 0);
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
index 90aec8e0955a..3210ecf29c76 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
@@ -61,6 +61,9 @@ int bnxt_alloc_mpcs(struct bnxt *bp);
 void bnxt_free_mpcs(struct bnxt *bp);
 int bnxt_alloc_mpc_rings(struct bnxt *bp);
 void bnxt_free_mpc_rings(struct bnxt *bp);
+void bnxt_init_mpc_rings(struct bnxt *bp);
+int bnxt_hwrm_mpc_ring_alloc(struct bnxt *bp);
+void bnxt_hwrm_mpc_ring_free(struct bnxt *bp, bool close_path);
 #else
 static inline void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap)
 {
@@ -128,5 +131,18 @@ static inline int bnxt_alloc_mpc_rings(struct bnxt *bp)
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


