Return-Path: <netdev+bounces-302798-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3RX5F5m+QmrDAQoAu9opvQ
	(envelope-from <netdev+bounces-302798-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:51:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C2D6DE24A
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 20:51:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=GsHnxRVM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302798-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302798-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B55B630517D4
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 18:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA56B3F1AC5;
	Mon, 29 Jun 2026 18:50:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8491421F17
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 18:50:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782759015; cv=none; b=WultuK5swUyANcDKTd1Cy/M0MWOYr5PXth2FebIlcEYujHzVT8S2rcEZiRLQcQ66Mg1oa6iIBO2FeSR30gQXgt2lZlhQ2UBlYUdKS6aZS9DiCfCvF0KN3cPJj5kTOHfnrJbzIGJ3ZII9WtyDb7LuKUkQTOkTgT8BVqHV3giI/Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782759015; c=relaxed/simple;
	bh=BoyxQ+Kk0Tblqi6qLK+Cqp64e/xAZ2AdKkoSUTr2jY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bTVug+Di9l5kAY7fDmwN47EsQQ/SofPi7CJ18ZB+3qFluHS332fBjJzLEfgXWe4Ajf7GeuBPD/gPUml2QamFd0O/RGcMf0IDe4nlH3TCJ0ED6CGXNlw3puKzTjtvcnEE15bqQudikUl+4MwsSFprvv+LwIpvGEx4CcQX+BOx71A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GsHnxRVM; arc=none smtp.client-ip=209.85.216.97
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-37ffdc718f8so782061a91.0
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782759013; x=1783363813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JgGdbehU8XIYm8c9GZSF0t0gUVLsEG94KO6pmjLeZZ0=;
        b=ZruWs0ho5VK1hD3ah9Ox1iN6DNbESY9PzRBuUk0N43qGGRhdL4twzx7Ig4OsZFyMuW
         wIQH+oM/3aTbPpm0+9y7k2OvPglEYQ4mYQZ6GBkROpBDczaM5UXQ4880ajm20R+TyScF
         XN4K5i8bfgw9TZEsCdaGNVlEhh1jI1zInHfdm9gAbeupep/cuAkB7Qldhl/oklYOYyQR
         ea2/f9tQYfS9xYX4Ks6GHsVhdlX8bPtWy8TN4kVibuYjcbZW0q0h55T8Bai81SsFmlKc
         K4kJiRD2WPBec//swkQRWUScFr3rx2nwmmLMpkI8aeVixV0tAkpEWGGuAXLWCNM2FKjF
         kUzA==
X-Gm-Message-State: AOJu0YwowEbcrsWZ8kz6+zuIJ0FaARFCF/Fx2UvcfZ7dOuqxngz945DY
	QVvIxX3EMiRuydvv0JEopAweZ0UfKb+MCTTIz1O4cJ9CzvSJsYgd67IYay4zv9TRWTWRo50dHza
	fUTlv7284Vui5kOP94vMGh4OClT7BhLLU61XGrS65T6+k2+8Sf75IEPvgIuruWV2PxC3G1c74GZ
	7GPJNuTGLpGF1W/CMzQouXyMFY0CjyeCiwN/rvL3ZXFoqQv7MykqsiLvKEzTc73TPTpnIaG4tEZ
	QNtFDizf/M=
X-Gm-Gg: AfdE7cnh8WG5vZqWyGVYAt90P33UmNB/cJ6z5QJX1ndW4oMMkBtj2nQIzSnPLStZoSI
	OaCOwHiMhwaa9Ppz5/UAFUTrBw/ArT4u5F0UWD60pqzHNn81avCYNtpLcJ3yi+mwy55zWoIroVg
	rB68/If7HLQNW5HCfkYTluusmNOc4ZxScTDjOKjQCkmzLukqVt9yX8jutorqYC3KDsfAge2UwuK
	XwIC8I2STQqtCdcleSfMVcUaYFRMtIChAwb4EZpNwPs9xRSuAeGOKmdBnyih0CjEOTdqe40vTmB
	wCu8g9sVlY62vhtXoc+Gf2F8PN+Y65MJokRoKOhdNkQ/wASYERrtgHimhHaA3MERX9JCE+BaAqv
	DM5+1NkwL4gF+n6cmmQ/9zTPq6iOhMQcdVn+AmoEH6heQMTu4mngVShtH7+p4YgqmrqoaXemBEZ
	vrT6/aDR8gZnZvNiCvvDBymLvki49AikgzjK07cYCSeni0xw==
X-Received: by 2002:a17:90b:3c08:b0:368:78da:803 with SMTP id 98e67ed59e1d1-38052583a4emr365739a91.12.1782759013000;
        Mon, 29 Jun 2026 11:50:13 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c9bbd08993fsm34135a12.3.2026.06.29.11.50.12
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2026 11:50:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c0e702df8so7592961cf.2
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 11:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1782759011; x=1783363811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgGdbehU8XIYm8c9GZSF0t0gUVLsEG94KO6pmjLeZZ0=;
        b=GsHnxRVM0Ey59OgPxkAU2EDChF9JsNTXinGCw/ywFAbF2COF0cClNw9KfZys/gDJWu
         IzIu68aDFJxP9Lmx/4/ED43iG4/xEGIh8iXluLvc6aHcsporDnY/vXBC4ydwowkuJpXU
         rJJxTKQg/1k9nGq268vqFVCK2BfemWEesxTLs=
X-Received: by 2002:ac8:57c5:0:b0:50d:82db:773e with SMTP id d75a77b69052e-51c108952e0mr7047051cf.47.1782759011238;
        Mon, 29 Jun 2026 11:50:11 -0700 (PDT)
X-Received: by 2002:ac8:57c5:0:b0:50d:82db:773e with SMTP id d75a77b69052e-51c108952e0mr7046331cf.47.1782759010470;
        Mon, 29 Jun 2026 11:50:10 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c109ffbb3sm2176341cf.23.2026.06.29.11.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 11:50:09 -0700 (PDT)
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
Subject: [PATCH net-next v4 05/15] bnxt_en: Allocate and free MPC software structures
Date: Mon, 29 Jun 2026 11:49:11 -0700
Message-ID: <20260629184921.3496727-6-michael.chan@broadcom.com>
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
	TAGGED_FROM(0.00)[bounces-302798-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: E7C2D6DE24A

Each MPC consists of a special TX ring and a completion ring.  Use
existing structs bnxt_tx_ring_info and bnxt_cp_ring_info as control
structures.  The 2 MPC channels to TCE and RCE that share the MSIX
will use a shared completion ring.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  35 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  12 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c | 205 ++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h |  46 ++++
 4 files changed, 291 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6146d24a6397..228fe7aa4907 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3685,7 +3685,7 @@ static size_t __bnxt_copy_ring(struct bnxt *bp, struct bnxt_ring_mem_info *rmem,
 	return total_len;
 }
 
-static void bnxt_free_ring(struct bnxt *bp, struct bnxt_ring_mem_info *rmem)
+void bnxt_free_ring(struct bnxt *bp, struct bnxt_ring_mem_info *rmem)
 {
 	struct pci_dev *pdev = bp->pdev;
 	int i;
@@ -3718,7 +3718,7 @@ static void bnxt_free_ring(struct bnxt *bp, struct bnxt_ring_mem_info *rmem)
 	}
 }
 
-static int bnxt_alloc_ring(struct bnxt *bp, struct bnxt_ring_mem_info *rmem)
+int bnxt_alloc_ring(struct bnxt *bp, struct bnxt_ring_mem_info *rmem)
 {
 	struct pci_dev *pdev = bp->pdev;
 	u64 valid_bit = 0;
@@ -4325,6 +4325,8 @@ static int bnxt_alloc_cp_rings(struct bnxt *bp)
 			 (!sh && i >= bp->rx_nr_rings)) {
 			cp_count += tcs;
 			tx = 1;
+			if (bnxt_napi_has_mpc(bp, i))
+				cp_count++;
 		}
 
 		cpr->cp_ring_arr = kzalloc_objs(*cpr, cp_count);
@@ -4346,6 +4348,11 @@ static int bnxt_alloc_cp_rings(struct bnxt *bp)
 			} else {
 				int n, tc = k - rx;
 
+				/* MPC rings are at the highest k indices */
+				if (tc >= tcs) {
+					bnxt_set_mpc_cp_ring(bp, i, cpr2);
+					continue;
+				}
 				n = BNXT_TC_TO_RING_BASE(bp, tc) + j;
 				bp->tx_ring[n].tx_cpr = cpr2;
 				cpr2->cp_ring_type = BNXT_NQ_HDL_TYPE_TX;
@@ -4478,6 +4485,7 @@ static void bnxt_init_ring_struct(struct bnxt *bp)
 			rmem->vmem = (void **)&txr->tx_buf_ring;
 		}
 	}
+	bnxt_init_mpc_ring_struct(bp);
 }
 
 static void bnxt_init_rxbd_pages(struct bnxt_ring_struct *ring, u32 type)
@@ -5554,6 +5562,7 @@ static void bnxt_init_l2_fltr_tbl(struct bnxt *bp)
 static void bnxt_free_mem(struct bnxt *bp, bool irq_re_init)
 {
 	bnxt_free_vnic_attributes(bp);
+	bnxt_free_mpc_rings(bp);
 	bnxt_free_tx_rings(bp);
 	bnxt_free_rx_rings(bp);
 	bnxt_free_cp_rings(bp);
@@ -5567,6 +5576,7 @@ static void bnxt_free_mem(struct bnxt *bp, bool irq_re_init)
 			bnxt_free_port_stats(bp);
 		bnxt_free_ring_grps(bp);
 		bnxt_free_vnics(bp);
+		bnxt_free_mpcs(bp);
 		kfree(bp->tx_ring_map);
 		bp->tx_ring_map = NULL;
 		kfree(bp->tx_ring);
@@ -5676,6 +5686,10 @@ static int bnxt_alloc_mem(struct bnxt *bp, bool irq_re_init)
 				txr->tx_cpr = &bnapi2->cp_ring;
 		}
 
+		rc = bnxt_alloc_mpcs(bp);
+		if (rc)
+			goto alloc_mem_err;
+
 		rc = bnxt_alloc_stats(bp);
 		if (rc)
 			goto alloc_mem_err;
@@ -5704,6 +5718,10 @@ static int bnxt_alloc_mem(struct bnxt *bp, bool irq_re_init)
 	if (rc)
 		goto alloc_mem_err;
 
+	rc = bnxt_alloc_mpc_rings(bp);
+	if (rc)
+		goto alloc_mem_err;
+
 	rc = bnxt_alloc_cp_rings(bp);
 	if (rc)
 		goto alloc_mem_err;
@@ -7258,10 +7276,15 @@ static int hwrm_ring_alloc_send_msg(struct bnxt *bp,
 		req->cmpl_ring_id = cpu_to_le16(bnxt_cp_ring_for_tx(bp, txr));
 		req->length = cpu_to_le32(bp->tx_ring_mask + 1);
 		req->stat_ctx_id = cpu_to_le32(grp_info->fw_stats_ctx);
-		req->queue_id = cpu_to_le16(ring->queue_id);
-		if (bp->flags & BNXT_FLAG_TX_COAL_CMPL)
-			req->cmpl_coal_cnt =
-				RING_ALLOC_REQ_CMPL_COAL_CNT_COAL_64;
+		if (ring->queue_id == BNXT_MPC_QUEUE_ID) {
+			req->mpc_chnls_type = ring->mpc_chnl_type;
+			req->enables |= cpu_to_le32(RING_ALLOC_REQ_ENABLES_MPC_CHNLS_TYPE);
+		} else {
+			req->queue_id = cpu_to_le16(ring->queue_id);
+			if (bp->flags & BNXT_FLAG_TX_COAL_CMPL)
+				req->cmpl_coal_cnt =
+					RING_ALLOC_REQ_CMPL_COAL_CNT_COAL_64;
+		}
 		if ((bp->fw_cap & BNXT_FW_CAP_TX_TS_CMP) && bp->ptp_cfg)
 			flags |= RING_ALLOC_REQ_FLAGS_TX_PKT_TS_CMPL_ENABLE;
 		req->flags = cpu_to_le16(flags);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index f851ce0c4a18..5119977f661b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -686,6 +686,7 @@ struct nqe_cn {
 #define BNXT_NQ_HDL_TYPE_SHIFT	24
 #define BNXT_NQ_HDL_TYPE_RX	0x00
 #define BNXT_NQ_HDL_TYPE_TX	0x01
+#define BNXT_NQ_HDL_TYPE_MP	0x02
 
 #define BNXT_NQ_HDL_IDX(hdl)	((hdl) & BNXT_NQ_HDL_IDX_MASK)
 #define BNXT_NQ_HDL_TYPE(hdl)	(((hdl) & BNXT_NQ_HDL_TYPE_MASK) >>	\
@@ -951,6 +952,8 @@ struct bnxt_ring_struct {
 	};
 	u32			handle;
 	u8			queue_id;
+#define BNXT_MPC_QUEUE_ID	0xff
+	u8			mpc_chnl_type;
 };
 
 struct tx_push_bd {
@@ -991,12 +994,16 @@ struct bnxt_tx_ring_info {
 	u16			tx_cons;
 	u16			tx_hw_cons;
 	u16			txq_index;
+	/* index for tx_ring[] or tx_mpc_ring[] in struct bnxt_napi */
 	u8			tx_napi_idx;
 	u8			kick_pending;
 	struct bnxt_db_info	tx_db;
 
 	struct tx_bd		*tx_desc_ring[MAX_TX_PAGES];
-	struct bnxt_sw_tx_bd	*tx_buf_ring;
+	union {
+		struct bnxt_sw_tx_bd	*tx_buf_ring;
+		struct bnxt_sw_mpc_tx_bd	*tx_mpc_buf_ring;
+	};
 
 	dma_addr_t		tx_desc_mapping[MAX_TX_PAGES];
 
@@ -1242,6 +1249,7 @@ struct bnxt_napi {
 	struct bnxt_cp_ring_info	cp_ring;
 	struct bnxt_rx_ring_info	*rx_ring;
 	struct bnxt_tx_ring_info	*tx_ring[BNXT_MAX_TXR_PER_NAPI];
+	struct bnxt_tx_ring_info	**tx_mpc_ring;
 
 	void			(*tx_int)(struct bnxt *, struct bnxt_napi *,
 					  int budget);
@@ -2964,6 +2972,8 @@ int bnxt_alloc_rx_data(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 void bnxt_reuse_rx_data(struct bnxt_rx_ring_info *rxr, u16 cons, void *data);
 u32 bnxt_fw_health_readl(struct bnxt *bp, int reg_idx);
 bool bnxt_bs_trace_avail(struct bnxt *bp, u16 type);
+void bnxt_free_ring(struct bnxt *bp, struct bnxt_ring_mem_info *rmem);
+int bnxt_alloc_ring(struct bnxt *bp, struct bnxt_ring_mem_info *rmem);
 void bnxt_set_tpa_flags(struct bnxt *bp);
 void bnxt_set_ring_params(struct bnxt *);
 void bnxt_set_rx_skb_mode(struct bnxt *bp, bool page_mode);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
index 183f1a3726c7..7bf686459170 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
@@ -22,6 +22,8 @@ void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap)
 
 void bnxt_free_mpc_info(struct bnxt *bp)
 {
+	bnxt_free_mpc_rings(bp);
+	bnxt_free_mpcs(bp);
 	kfree(bp->mpc_info);
 	bp->mpc_info = NULL;
 }
@@ -47,6 +49,55 @@ int bnxt_mpc_cp_rings_in_use(struct bnxt *bp)
 	return mpc->mpc_cp_rings;
 }
 
+bool bnxt_napi_has_mpc(struct bnxt *bp, int i)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	struct bnxt_napi *bnapi = bp->bnapi[i];
+	struct bnxt_tx_ring_info *txr;
+
+	if (!mpc)
+		return false;
+
+	txr = bnapi->tx_ring[0];
+	if (txr && !(bnapi->flags & BNXT_NAPI_FLAG_XDP))
+		return txr->txq_index < mpc->mpc_cp_rings;
+	return false;
+}
+
+void bnxt_set_mpc_cp_ring(struct bnxt *bp, int bnapi_idx,
+			  struct bnxt_cp_ring_info *cpr)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	struct bnxt_napi *bnapi;
+	bool found = false;
+	int i, j;
+
+	if (!mpc)
+		return;
+	bnapi = bp->bnapi[bnapi_idx];
+	/* Check both TCE and RCE MPCs for the matching NAPI */
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		int num = mpc->mpc_ring_count[i];
+
+		for (j = 0; j < num; j++) {
+			struct bnxt_tx_ring_info *txr = &mpc->mpc_rings[i][j];
+
+			/* Only 1 ring with index j will use this NAPI */
+			if (txr->bnapi == bnapi) {
+				txr->tx_cpr = cpr;
+				txr->tx_napi_idx = i;
+				bnapi->tx_mpc_ring[i] = txr;
+				found = true;
+				break;
+			}
+		}
+	}
+	if (!found)
+		netdev_warn_once(bp->dev, "No MPC match for napi index %d\n",
+				 bnapi_idx);
+	cpr->cp_ring_type = BNXT_NQ_HDL_TYPE_MP;
+}
+
 void bnxt_trim_mpc_rings(struct bnxt *bp)
 {
 	struct bnxt_mpc_info *mpc = bp->mpc_info;
@@ -108,3 +159,157 @@ void bnxt_set_dflt_mpc_rings(struct bnxt *bp)
 	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++)
 		mpc->mpc_ring_count[i] = 0;
 }
+
+void bnxt_init_mpc_ring_struct(struct bnxt *bp)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	int i, j;
+
+	if (!BNXT_MPC_CRYPTO_CAPABLE(bp))
+		return;
+
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		int num = mpc->mpc_ring_count[i];
+
+		if (!mpc->mpc_rings[i])
+			continue;
+		for (j = 0; j < num; j++) {
+			struct bnxt_ring_mem_info *rmem;
+			struct bnxt_ring_struct *ring;
+			struct bnxt_tx_ring_info *txr;
+
+			txr = &mpc->mpc_rings[i][j];
+
+			txr->tx_ring_struct.ring_mem.flags =
+				BNXT_RMEM_RING_PTE_FLAG;
+			txr->bnapi = bp->tx_ring[bp->tx_ring_map[j]].bnapi;
+			txr->txq_index = j;
+
+			ring = &txr->tx_ring_struct;
+			rmem = &ring->ring_mem;
+			rmem->nr_pages = bp->tx_nr_pages;
+			rmem->page_size = HW_TXBD_RING_SIZE;
+			rmem->pg_arr = (void **)txr->tx_desc_ring;
+			rmem->dma_arr = txr->tx_desc_mapping;
+			rmem->vmem_size = SW_MPC_TXBD_RING_SIZE *
+					  bp->tx_nr_pages;
+			rmem->vmem = (void **)&txr->tx_mpc_buf_ring;
+		}
+	}
+}
+
+int bnxt_alloc_mpcs(struct bnxt *bp)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	int i, rc = 0;
+
+	if (!BNXT_MPC_CRYPTO_CAPABLE(bp))
+		return 0;
+
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		int num = mpc->mpc_ring_count[i];
+		struct bnxt_tx_ring_info *txr;
+
+		if (!num)
+			continue;
+		txr = kzalloc_objs(*txr, num);
+		if (!txr) {
+			rc = -ENOMEM;
+			goto alloc_mpcs_exit;
+		}
+		mpc->mpc_rings[i] = txr;
+	}
+
+	for (i = 0; i < bp->cp_nr_rings; i++) {
+		struct bnxt_napi *bnapi = bp->bnapi[i];
+
+		if (!bnxt_napi_has_mpc(bp, i))
+			continue;
+		bnapi->tx_mpc_ring = kzalloc_objs(*bnapi->tx_mpc_ring,
+						  BNXT_MPC_TYPE_MAX);
+		if (!bnapi->tx_mpc_ring) {
+			rc = -ENOMEM;
+			goto alloc_mpcs_exit;
+		}
+	}
+alloc_mpcs_exit:
+	if (rc)
+		bnxt_free_mpcs(bp);
+	return rc;
+}
+
+void bnxt_free_mpcs(struct bnxt *bp)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	int i;
+
+	if (!mpc)
+		return;
+
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		kfree(mpc->mpc_rings[i]);
+		mpc->mpc_rings[i] = NULL;
+	}
+	if (!bp->bnapi)
+		return;
+	for (i = 0; i < bp->cp_nr_rings; i++) {
+		struct bnxt_napi *bnapi = bp->bnapi[i];
+
+		kfree(bnapi->tx_mpc_ring);
+		bnapi->tx_mpc_ring = NULL;
+	}
+}
+
+int bnxt_alloc_mpc_rings(struct bnxt *bp)
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
+			struct bnxt_ring_struct *ring;
+
+			ring = &txr->tx_ring_struct;
+			rc = bnxt_alloc_ring(bp, &ring->ring_mem);
+			if (rc)
+				goto alloc_mpc_rings_exit;
+			ring->queue_id = BNXT_MPC_QUEUE_ID;
+			ring->mpc_chnl_type = i;
+			/* for stats context */
+			ring->grp_idx = txr->bnapi->index;
+			spin_lock_init(&txr->tx_lock);
+		}
+	}
+alloc_mpc_rings_exit:
+	if (rc)
+		bnxt_free_mpc_rings(bp);
+	return rc;
+}
+
+void bnxt_free_mpc_rings(struct bnxt *bp)
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
+		if (!mpc->mpc_rings[i])
+			continue;
+		for (j = 0; j < num; j++) {
+			struct bnxt_tx_ring_info *txr = &mpc->mpc_rings[i][j];
+			struct bnxt_ring_struct *ring = &txr->tx_ring_struct;
+
+			bnxt_free_ring(bp, &ring->ring_mem);
+		}
+	}
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
index 4ff8cad75a23..b54daf4ddd2f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
@@ -29,6 +29,12 @@ struct bnxt_mpc_info {
 	struct bnxt_tx_ring_info *mpc_rings[BNXT_MPC_TYPE_MAX];
 };
 
+struct bnxt_sw_mpc_tx_bd {
+	unsigned long handle;
+};
+
+#define SW_MPC_TXBD_RING_SIZE (sizeof(struct bnxt_sw_mpc_tx_bd) * TX_DESC_CNT)
+
 #define BNXT_MPC_CRYPTO_CAP    \
 	(FUNC_QCAPS_RESP_MPC_CHNLS_CAP_TCE | FUNC_QCAPS_RESP_MPC_CHNLS_CAP_RCE)
 
@@ -42,8 +48,16 @@ void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap);
 void bnxt_free_mpc_info(struct bnxt *bp);
 int bnxt_mpc_tx_rings_in_use(struct bnxt *bp);
 int bnxt_mpc_cp_rings_in_use(struct bnxt *bp);
+bool bnxt_napi_has_mpc(struct bnxt *bp, int i);
+void bnxt_set_mpc_cp_ring(struct bnxt *bp, int bnapi_idx,
+			  struct bnxt_cp_ring_info *cpr);
 void bnxt_trim_mpc_rings(struct bnxt *bp);
 void bnxt_set_dflt_mpc_rings(struct bnxt *bp);
+void bnxt_init_mpc_ring_struct(struct bnxt *bp);
+int bnxt_alloc_mpcs(struct bnxt *bp);
+void bnxt_free_mpcs(struct bnxt *bp);
+int bnxt_alloc_mpc_rings(struct bnxt *bp);
+void bnxt_free_mpc_rings(struct bnxt *bp);
 #else
 static inline void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap)
 {
@@ -63,6 +77,16 @@ static inline int bnxt_mpc_cp_rings_in_use(struct bnxt *bp)
 	return 0;
 }
 
+static inline bool bnxt_napi_has_mpc(struct bnxt *bp, int i)
+{
+	return false;
+}
+
+static inline void bnxt_set_mpc_cp_ring(struct bnxt *bp, int bnapi_idx,
+					struct bnxt_cp_ring_info *cpr)
+{
+}
+
 static inline void bnxt_trim_mpc_rings(struct bnxt *bp)
 {
 }
@@ -70,5 +94,27 @@ static inline void bnxt_trim_mpc_rings(struct bnxt *bp)
 static inline void bnxt_set_dflt_mpc_rings(struct bnxt *bp)
 {
 }
+
+static inline void bnxt_init_mpc_ring_struct(struct bnxt *bp)
+{
+}
+
+static inline int bnxt_alloc_mpcs(struct bnxt *bp)
+{
+	return 0;
+}
+
+static inline void bnxt_free_mpcs(struct bnxt *bp)
+{
+}
+
+static inline int bnxt_alloc_mpc_rings(struct bnxt *bp)
+{
+	return 0;
+}
+
+static inline void bnxt_free_mpc_rings(struct bnxt *bp)
+{
+}
 #endif	/* CONFIG_BNXT_TLS */
 #endif	/* BNXT_MPC_H */
-- 
2.51.0


