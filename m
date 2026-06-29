Return-Path: <netdev+bounces-302799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nq3YAKW+QmrGAQoAu9opvQ
	(envelope-from <netdev+bounces-302799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:51:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6920A6DE24D
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:51:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=aLcAM9kL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302799-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302799-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F352930566A8
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EF13C0A05;
	Mon, 29 Jun 2026 18:50:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC7F421F12
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 18:50:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782759018; cv=none; b=gDb3EgR3x9zWuDUKSa06+h30ACk2/En+KLAbQkMUynbFwnMNBQZ52hyfstl857vOLApwTNbfurOeja7iI4ViFJ0zIZ1O60fmYo2ubXbHInB0GzBCGDHxK4HEuj9WvGtToNA0EXeSGRUPElb5aTgGatGkV/QgnK9ltoiShw1S4Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782759018; c=relaxed/simple;
	bh=kWrWV78g+9/hRF3oulRgD2wZZtTv+uyZ7Wy9PpgIT90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TwOq/TmpjPhjGHK7M6ettROcviGQlQ6j+7pTKbJ/McppJSYFc1/I1GPGmvNEKFif85daCLAhZaU2SPcL7i6ve27GuiLu61/2gDSTssrgarFW0CgGfEWiBICYwZKj6exfrT/QWYdrDg4Iezqtw7XuRBfqnBTvAlmLRIME+6YWBx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aLcAM9kL; arc=none smtp.client-ip=209.85.222.225
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-9204711e831so455520785a.2
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782759016; x=1783363816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8p0946WshzvaYjUSOvlbUiDD1mAKSv6kioj5RG++IbU=;
        b=W1SwL8A9QPPev+xPWa8igrAkSYsnCCvCZkJLkuIxXyWvvrDsNGvU0SR/gZKdJRsnL8
         9UWPcbkGOnufOzFJm/vkfqPtAX64CCaR1ff5YpDsgNpmUzogGWGN+kZbXwxqZm0NGqMF
         +5yqustu0nf8Fb+6jjvuHCQyKo6WPLzxNwd3mgaF6Xj3cL8hH9pNyj9CD3N6bb57P/Vs
         YkJ0QsUhCJGjRTPq+QIKYMqpdtXzS/1xut4h3JWicr8dLJqEVrthUFI4CLvXEjJWZalQ
         oWBHrTD/C0s0vmkzOZGjDcAqZukk9Yp/Sli98QPTRsCAWpPE7Pk0ieg5jc9+OpCcXwdi
         sdCA==
X-Gm-Message-State: AOJu0YyjHHMYwWQAn/WAJJ6gHtIl72FPD0dn+/gQLMmSPIV15NxPEHW0
	aT1yTIf+QyrBiIBltXYEm/YlCqCHdQV1Ti0IZH4dvjX/aPvonga8FWZkE5NGm9ki4qLUYgH/yVH
	xeYF+aNcn5JPTxAhxx2WGWYqZmZ2stdocCZVaIGOI20tQF3LcP0KdeGPRIZlamzgDcFBHgbpJl8
	Tdg+SgnpmOaQEZPogCrkFa4kHOoDpHN62JnFeiD9CSO8U5p5/qX9mm9CuGoWe1jnaeg4Kju3rG1
	4mi1ppEju8=
X-Gm-Gg: AfdE7clqwBF1pUMcxA7q3ioVN+CEXcI3TF2XvI42LaBDU98WFxxqUZtYfoH+JwqS3IO
	vRc4Mm9j5l+zlU7vB71/1ZUFcfpzbF+LpUvWAz5EqzHSjBLeT6b8shHTC0rd8f8QnzhqjaPI0m+
	FVGDj/AgaIYWNfDQoBjxofhPo9HVH2X5tTv0Ht3ZHHEDyBIfhrTyxNp2Ma7PciJSu8hoIHr2F93
	RgLm88XP4OW8xaLknRrpVifw5QwvDEK89OCjzJzyvD8ZzWdubJNsaXJWS8FzKIltA69B89i4ZOs
	6MSkKTpDyJL85qN3xVfMn5dELRAFoHk4gpQJtF/a5H/9gw6b0QypmCgGSKeNHtZbSsRw1QQ4taX
	IkY1F+Haqrp6g3tIH21FAMXvxvXYAKONyVAl3Yoa5A/Ngdqimz34SzmvQKy8h+ApYNTtOC4xrkc
	CvfGUaQS+IokAvL1B0PFwnjiMml7dg2gUHAiD5xzse6NrwXA==
X-Received: by 2002:a05:620a:7088:b0:92b:6805:91b9 with SMTP id af79cd13be357-92e627f0b42mr135866685a.65.1782759015419;
        Mon, 29 Jun 2026 11:50:15 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-92e6229efcbsm3333285a.7.2026.06.29.11.50.14
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2026 11:50:15 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c0f0a0760so7926861cf.2
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1782759014; x=1783363814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8p0946WshzvaYjUSOvlbUiDD1mAKSv6kioj5RG++IbU=;
        b=aLcAM9kLz0GcaIDZgzGZ76ieHcnojJIREg74GozTD/88OLclMjTHkrZ8EET0GBKAKJ
         0r389p0NaCseqJXOsAbC0kAVpv2zS5rGkFeLSPyg8QJtxjb824DfGdCpXlnUYSM8iwEc
         gzsi/2mqRIfAj6386ZA5HSsoVSg4FJ9Xwk3mo=
X-Received: by 2002:a05:622a:1648:b0:51a:8c9a:8fb2 with SMTP id d75a77b69052e-51c108c67f3mr7486651cf.67.1782759013948;
        Mon, 29 Jun 2026 11:50:13 -0700 (PDT)
X-Received: by 2002:a05:622a:1648:b0:51a:8c9a:8fb2 with SMTP id d75a77b69052e-51c108c67f3mr7486041cf.67.1782759013095;
        Mon, 29 Jun 2026 11:50:13 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c109ffbb3sm2176341cf.23.2026.06.29.11.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 11:50:12 -0700 (PDT)
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
Subject: [PATCH net-next v4 06/15] bnxt_en: Allocate and free MPC channels from firmware
Date: Mon, 29 Jun 2026 11:49:12 -0700
Message-ID: <20260629184921.3496727-7-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629184921.3496727-1-michael.chan@broadcom.com>
References: <20260629184921.3496727-1-michael.chan@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-302799-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6920A6DE24D

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
index 228fe7aa4907..67a8b2729cc3 100644
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
index 5119977f661b..e7e2657d58b9 100644
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
index 7bf686459170..cd104b7ff1d7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
@@ -313,3 +313,95 @@ void bnxt_free_mpc_rings(struct bnxt *bp)
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


