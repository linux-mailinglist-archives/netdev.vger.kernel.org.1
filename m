Return-Path: <netdev+bounces-284109-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2A2mHvIy+WkG6gIAu9opvQ
	(envelope-from <netdev+bounces-284109-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 01:59:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E524C50E2
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 01:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28B8D3022903
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 23:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D64440149E;
	Mon,  4 May 2026 23:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WDnP77Hp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f100.google.com (mail-yx1-f100.google.com [74.125.224.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A2A4014BC
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 23:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777939177; cv=none; b=jpGdfQSCPBAvDj9TpciwUz7pSrMggVJdGbdGPcZzrdpO8IOQ+899RSWpglF2y554UA5xgc+v1shhRhh8rT9CBlYEzEmioqEUlrhHvTJP64X84/Da2NfvWGf28LqA2asLX09cG938gLH6sb7VREwdyTfx5y8cmhpANHSyBPuyIbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777939177; c=relaxed/simple;
	bh=cm+tyJbUR9D3PRCe/Q3ic/iS43CpHVNQtBUmKE04zzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSbga60adzGWFuHHZvLwftVxXY1+tqH+wPta0DKO+Khd9eZeyyXIVt9X7ywCUkHnl2vc17aueZ04rYP98uXlGp1FgoIoHJ0dwBZCDjQO0aX41zq8xOWtghW+SBQ1JXM/Q2Gc1e7V9Bw7hpXs06YSc1zuqxk99gRAaxvX1lMkVRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WDnP77Hp; arc=none smtp.client-ip=74.125.224.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f100.google.com with SMTP id 956f58d0204a3-651d6347a69so1959697d50.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 16:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777939174; x=1778543974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NvrM7o5L0gdmlff9hqPVfwtLP5FZK6NYjKuTsf9Idaw=;
        b=ezLnEhlv7ljkIjH4wYMup4TofjBd/6+N9jDbwwCM5t7U/8/x4X399+rf3h3sNxtL6q
         virvfUhJibYDh3R1tdtbrqbbawY1AvRCYECM8RxCBo2R0kCHB83bbtsM2FVOCfMolh71
         jToeQmMOhfXSSHKyDuoslpUA0gvm5Iv211E+NGWd9kyidC2bwLF9huEKELdNEtXpL29C
         N0mnmq3GeZF4aFWayZJ6BxS+vsCittLw+JHgpJA+I2Busfa9hBtHUSA35ZLPFb5xmQ1I
         CnON71NSPMPqQ0sjqqyutqeYSJkQnIqN1vJpqPmv44h0b0xfiUDVk2xBnRtZUyX4XGMz
         hRfQ==
X-Gm-Message-State: AOJu0Yz1bAHMNiL78MCcNtbLXs+EmusAOfEsaRYmEdTlFrzR7Hx65xvB
	vPg2TzDQGzreE+aDvmtDlwtg/Xnst0VkGmIPsAnEfagawV5hbOcCj5sE9s0m/jcD7m8gL/eyScQ
	QKinuvqb2I0O8OwZ7f9CH1u16fhxrdjSzicHxW0hnBhBNeSLdm6yC9+rhJMyGlTP3540z5C+ztH
	Xfeic6w19pE3Ky6uBIpeZS69z2PfzTSj518YJxrSRxAs74ykT0PUugOyVoIxP9VK571dE0WrTjM
	BtdXCSrclQ=
X-Gm-Gg: AeBDietap+VLG1wnlSkopVgrXyK3NPD+kSK4A1tYRPWUTrO03Tb6bm8EXwRrFFXFMm4
	FcMjD3IVHNUVxepTS4oYNy8Fr29LWHg5fTFSTFlGJaTTczjo/HPZ5IwKKk4xmbsNCky9gsikRHz
	03HWfREdaphfJ6r0IqiRQSS0oKQR7o66jkJQjpIO86kMwu0UNAY63Hjj2jXE3Vgsx1aGS74/xjv
	DoZ7jd3UeEX9eNxglpe1W84yQKkbDDqXpeRG8zz7KrkZvTFtJ7189nRzBHBVwguzwQOigdaImnA
	q3xlX9pG2Egit198K/S9RbuVzw6Z7MpuXkUHEV8ulLRTUTIe2tWc/t1JcdUBEvOEjPxBm4Q/dPQ
	4WANCBzQwi9dU7jQtwgg4b61GvjF1T5IIqzjqBB1g4aiEwJznRNJ03mNKKyJ2/dSxnO3SxNwnxA
	JlI39YcWGdyrOsphOBGCPFm1vbfI77unwUTHgsj8Q+aYEf/yqETlBJ5XAwstLTKTup8+6H1Q==
X-Received: by 2002:a05:690e:1c20:b0:654:6a61:fb60 with SMTP id 956f58d0204a3-65c68008012mr1543192d50.26.1777939174488;
        Mon, 04 May 2026 16:59:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-65c2df6f28fsm921323d50.7.2026.05.04.16.59.34
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2026 16:59:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8acb0aa51c6so111237196d6.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 16:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777939173; x=1778543973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NvrM7o5L0gdmlff9hqPVfwtLP5FZK6NYjKuTsf9Idaw=;
        b=WDnP77HpiKNKCov/tNYbRBb6BT6mA5t+2WBOBbObo1rxXfGRqHZQenRtZmiXzIB8od
         TcCmoJgjk0DQQrIxNNY8oKjeujepv2aJtwKzjLLEQT/+o3oeJF9mwL9EllAw51706LDf
         Y+2UNN1YQvT9ElHMMSDDrKQVDW2WMBrivCcEU=
X-Received: by 2002:a05:6214:808e:b0:8ac:b0d8:65f3 with SMTP id 6a1803df08f44-8baa08a5855mr23089126d6.21.1777939173161;
        Mon, 04 May 2026 16:59:33 -0700 (PDT)
X-Received: by 2002:a05:6214:808e:b0:8ac:b0d8:65f3 with SMTP id 6a1803df08f44-8baa08a5855mr23088846d6.21.1777939172634;
        Mon, 04 May 2026 16:59:32 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b5396c4b7dsm132298246d6.18.2026.05.04.16.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 16:59:32 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next 11/15] bnxt_en: Add crypto MPC transmit/completion infrastructure
Date: Mon,  4 May 2026 16:58:32 -0700
Message-ID: <20260504235836.3019499-12-michael.chan@broadcom.com>
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
X-Rspamd-Queue-Id: 39E524C50E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-284109-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]

Add infrastructure to support sending crypto commands using the
midpath channels (MPCs).  bnxt_xmit_crypto_cmd() is used to send a
crypto command and sleep with timeout until the completion is received.
If it times out, we recover by resetting the MPC.   The next patch will
use this infrastructure to offload kTLS connections.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   2 +
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.c  | 145 ++++++++++++++++-
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.h  |  92 +++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c | 146 ++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h |   9 ++
 6 files changed, 395 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 5976f66e82bd..3861a672849f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -7711,7 +7711,7 @@ void bnxt_hwrm_cp_ring_free(struct bnxt *bp, struct bnxt_cp_ring_info *cpr)
 	ring->fw_ring_id = INVALID_HW_RING_ID;
 }
 
-static void bnxt_clear_one_cp_ring(struct bnxt *bp, struct bnxt_cp_ring_info *cpr)
+void bnxt_clear_one_cp_ring(struct bnxt *bp, struct bnxt_cp_ring_info *cpr)
 {
 	struct bnxt_ring_struct *ring = &cpr->cp_ring_struct;
 	int i, size = ring->ring_mem.page_size;
@@ -14365,7 +14365,7 @@ static int bnxt_hwrm_rx_ring_reset(struct bnxt *bp, int ring_nr)
 	return hwrm_req_send_silent(bp, req);
 }
 
-static void bnxt_reset_task(struct bnxt *bp, bool silent)
+void bnxt_reset_task(struct bnxt *bp, bool silent)
 {
 	if (!silent)
 		bnxt_dbg_dump_states(bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index f30e7c90471b..fc9fec10e753 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -3019,6 +3019,7 @@ int bnxt_hwrm_tx_ring_alloc(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 void bnxt_hwrm_tx_ring_free(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 			    bool close_path);
 void bnxt_hwrm_cp_ring_free(struct bnxt *bp, struct bnxt_cp_ring_info *cpr);
+void bnxt_clear_one_cp_ring(struct bnxt *bp, struct bnxt_cp_ring_info *cpr);
 int bnxt_total_tx_rings(struct bnxt *bp);
 int __bnxt_hwrm_get_tx_rings(struct bnxt *bp, u16 fid, int *tx_rings);
 int bnxt_nq_rings_in_use(struct bnxt *bp);
@@ -3064,6 +3065,7 @@ void bnxt_get_ring_drv_stats(struct bnxt *bp,
 bool bnxt_rfs_capable(struct bnxt *bp, bool new_rss_ctx);
 int bnxt_dbg_hwrm_rd_reg(struct bnxt *bp, u32 reg_off, u16 num_words,
 			 u32 *reg_buf);
+void bnxt_reset_task(struct bnxt *bp, bool silent);
 void bnxt_fw_exception(struct bnxt *bp);
 void bnxt_fw_reset(struct bnxt *bp);
 int bnxt_check_rings(struct bnxt *bp, int tx, int rx, bool sh, int tcs,
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
index 4ea3e67be9f5..02c12c8ee96f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
@@ -5,10 +5,12 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
+#include <linux/pci.h>
 #include <linux/bnxt/hsi.h>
 
 #include "bnxt.h"
 #include "bnxt_hwrm.h"
+#include "bnxt_mpc.h"
 #include "bnxt_crypto.h"
 
 static u32 bnxt_get_max_crypto_key_ctx(struct bnxt *bp, int key_type)
@@ -46,6 +48,7 @@ void bnxt_alloc_crypto_info(struct bnxt *bp,
 		return;
 	if (!crypto) {
 		struct bnxt_kctx *kctx;
+		char name[64];
 		int i;
 
 		crypto = kzalloc_obj(*crypto);
@@ -54,6 +57,15 @@ void bnxt_alloc_crypto_info(struct bnxt *bp,
 				    "Unable to allocate crypto info\n");
 			return;
 		}
+		snprintf(name, sizeof(name), "bnxt_crypto-%s",
+			 dev_name(&bp->pdev->dev));
+		crypto->mpc_cache =
+			kmem_cache_create(name,
+					  sizeof(struct bnxt_crypto_cmd_ctx),
+					  0, SLAB_HWCACHE_ALIGN, NULL);
+		if (!crypto->mpc_cache)
+			goto alloc_err;
+
 		for (i = 0; i < BNXT_MAX_CRYPTO_KEY_TYPE; i++) {
 			kctx = &crypto->kctx[i];
 			kctx->type = i;
@@ -66,6 +78,11 @@ void bnxt_alloc_crypto_info(struct bnxt *bp,
 		bp->crypto_info = crypto;
 	}
 	crypto->max_key_ctxs_alloc = max_keys;
+	return;
+
+alloc_err:
+	kfree(crypto);
+	bp->crypto_info = NULL;
 }
 
 /**
@@ -113,8 +130,13 @@ void bnxt_clear_crypto(struct bnxt *bp)
  */
 void bnxt_free_crypto_info(struct bnxt *bp)
 {
+	struct bnxt_crypto_info *crypto = bp->crypto_info;
+
+	if (!crypto)
+		return;
 	bnxt_clear_crypto(bp);
-	kfree(bp->crypto_info);
+	kmem_cache_destroy(crypto->mpc_cache);
+	kfree(crypto);
 	bp->crypto_info = NULL;
 }
 
@@ -333,6 +355,90 @@ int bnxt_key_ctx_alloc_one(struct bnxt *bp, struct bnxt_kctx *kctx, u8 kind,
 	return -EAGAIN;
 }
 
+#define BNXT_CMD_CTX_RETRY_MAX	10
+
+static void bnxt_crypto_timeout(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+				struct bnxt_crypto_cmd_ctx *ctx)
+{
+	int i;
+
+	bnxt_mpc_timeout(bp, txr);
+	/* Wait for the ctx to complete before proceeding */
+	for (i = 0; i < BNXT_CMD_CTX_RETRY_MAX &&
+	     !(ctx->status & BNXT_CMD_CTX_COMPLETED); i++)
+		msleep(20);
+	if (!(ctx->status & BNXT_CMD_CTX_COMPLETED))
+		netdev_warn(bp->dev,
+			    "Timed out waiting for cmd_ctx to complete for MPC ring %d\n",
+			    txr->txq_index);
+}
+
+#define BNXT_XMIT_CRYPTO_RETRY_MAX	10
+#define BNXT_XMIT_CRYPTO_MIN_TMO	100
+#define BNXT_XMIT_CRYPTO_MAX_TMO	150
+
+int bnxt_xmit_crypto_cmd(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			 void *cmd, unsigned int len, unsigned int tmo)
+{
+	struct bnxt_crypto_info *crypto = bp->crypto_info;
+	struct bnxt_crypto_cmd_ctx *ctx = NULL;
+	unsigned long tmo_left, handle = 0;
+	int rc, retry = 0;
+
+	if (tmo) {
+		u32 kid = CE_CMD_KID(cmd);
+
+		ctx = kmem_cache_alloc(crypto->mpc_cache, GFP_KERNEL);
+		if (!ctx)
+			return -ENOMEM;
+		init_completion(&ctx->cmp);
+		handle = (unsigned long)ctx;
+		ctx->kid = kid;
+		ctx->client = txr->tx_ring_struct.mpc_chnl_type;
+		ctx->status = 0;
+		retry = BNXT_XMIT_CRYPTO_RETRY_MAX;
+		might_sleep();
+	}
+	do {
+		spin_lock_bh(&txr->tx_lock);
+		rc = bnxt_start_xmit_mpc(bp, txr, cmd, len, handle);
+		spin_unlock_bh(&txr->tx_lock);
+		if (rc == -EBUSY && tmo && retry)
+			usleep_range(BNXT_XMIT_CRYPTO_MIN_TMO,
+				     BNXT_XMIT_CRYPTO_MAX_TMO);
+		else
+			break;
+	} while (retry--);
+	if (rc || !tmo)
+		goto xmit_done;
+
+	tmo_left = wait_for_completion_timeout(&ctx->cmp, msecs_to_jiffies(tmo));
+	if (!tmo_left) {
+		netdev_warn(bp->dev, "crypto MP cmd %08x timed out\n",
+			    *((u32 *)cmd));
+		bnxt_crypto_timeout(bp, txr, ctx);
+		rc = -ETIMEDOUT;
+		goto xmit_done;
+	}
+	if (ctx->status == BNXT_CMD_CTX_COMPLETED &&
+	    CE_CMPL_STATUS(&ctx->ce_cmp) == CE_CMPL_STATUS_OK)
+		rc = 0;
+	else
+		rc = -EIO;
+xmit_done:
+	if (rc) {
+		u8 status = ctx ? ctx->status : 0;
+
+		netdev_warn(bp->dev,
+			    "MPC transmit failed, ring idx %d, op 0x%x, kid 0x%x, status 0x%x\n",
+			    txr->bnapi->index, CE_CMD_OP(cmd), CE_CMD_KID(cmd),
+			    status);
+	}
+	if (ctx)
+		kmem_cache_free(crypto->mpc_cache, ctx);
+	return rc;
+}
+
 int bnxt_crypto_init(struct bnxt *bp)
 {
 	struct bnxt_crypto_info *crypto = bp->crypto_info;
@@ -364,3 +470,40 @@ int bnxt_crypto_init(struct bnxt *bp)
 
 	return 0;
 }
+
+void bnxt_crypto_mpc_cmp(struct bnxt *bp, u32 client, unsigned long handle,
+			 struct bnxt_cmpl_entry cmpl[], u32 entries)
+{
+	struct bnxt_crypto_cmd_ctx *ctx;
+	struct ce_cmpl *cmp;
+	u32 len, kid;
+
+	if (likely(cmpl))
+		cmp = cmpl[0].cmpl;
+	if (!handle || entries != 1) {
+		if (entries != 1 && cmpl) {
+			netdev_warn(bp->dev, "Invalid entries %d with handle %lx cmpl %08x in %s()\n",
+				    entries, handle, *(u32 *)cmp, __func__);
+		}
+		if (!handle)
+			return;
+	}
+	ctx = (void *)handle;
+	ctx->status = BNXT_CMD_CTX_COMPLETED;
+	if (unlikely(!cmpl)) {
+		ctx->status |= BNXT_CMD_CTX_RESET;
+		goto cmp_done;
+	}
+	kid = CE_CMPL_KID(cmp);
+	if (ctx->kid != kid || ctx->client != client) {
+		netdev_warn(bp->dev,
+			    "Invalid CE cmpl 0x%08x for client %d with status 0x%x, expected kid 0x%x and client %d\n",
+			    *(u32 *)cmp, client, ctx->status, ctx->kid,
+			    ctx->client);
+		ctx->status |= BNXT_CMD_CTX_ERROR;
+	}
+	len = min_t(u32, cmpl[0].len, sizeof(ctx->ce_cmp));
+	memcpy(&ctx->ce_cmp, cmpl[0].cmpl, len);
+cmp_done:
+	complete(&ctx->cmp);
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
index ecdf18ba6d83..c943bbdf2595 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
@@ -57,6 +57,79 @@ struct bnxt_crypto_info {
 	u16			max_key_ctxs_alloc;
 
 	struct bnxt_kctx	kctx[BNXT_MAX_CRYPTO_KEY_TYPE];
+
+	struct kmem_cache	*mpc_cache;
+};
+
+struct ce_delete_cmd {
+	__le32  ctx_kind_kid_opcode;
+	#define CE_DELETE_CMD_OPCODE_MASK		0xfUL
+	#define CE_DELETE_CMD_OPCODE_SFT		0
+	#define CE_DELETE_CMD_OPCODE_DEL		 0x2UL
+	#define CE_DELETE_CMD_KID_MASK			0xfffff0UL
+	#define CE_DELETE_CMD_KID_SFT			4
+	#define CE_DELETE_CMD_CTX_KIND_MASK		0x1f000000UL
+	#define CE_DELETE_CMD_CTX_KIND_SFT		24
+	#define CE_DELETE_CMD_CTX_KIND_CK_TX		 (0x11UL << 24)
+	#define CE_DELETE_CMD_CTX_KIND_CK_RX		 (0x12UL << 24)
+};
+
+#define CE_CMD_OP_MASK			0x00000fU
+#define CE_CMD_KID_MASK			0xfffff0U
+#define CE_CMD_KID_SFT			4
+
+#define CE_CMD_OP(cmd_p)					\
+	(*(u32 *)(cmd_p) & CE_CMD_OP_MASK)
+
+#define CE_CMD_KID(cmd_p)					\
+	((*(u32 *)(cmd_p) & CE_CMD_KID_MASK) >> CE_CMD_KID_SFT)
+
+struct ce_cmpl {
+	__le16	client_subtype_type;
+	#define CE_CMPL_TYPE_MASK			0x3fUL
+	#define CE_CMPL_TYPE_SFT			0
+	#define CE_CMPL_TYPE_MID_PATH_SHORT		 0x1eUL
+	#define CE_CMPL_SUBTYPE_MASK			0xf00UL
+	#define CE_CMPL_SUBTYPE_SFT			8
+	#define CE_CMPL_SUBTYPE_SOLICITED		 (0x0UL << 8)
+	#define CE_CMPL_SUBTYPE_ERR			 (0x1UL << 8)
+	#define CE_CMPL_SUBTYPE_RESYNC			 (0x2UL << 8)
+	#define CE_CMPL_MP_CLIENT_MASK			0xf000UL
+	#define CE_CMPL_MP_CLIENT_SFT			12
+	#define CE_CMPL_MP_CLIENT_TCE			 (0x0UL << 12)
+	#define CE_CMPL_MP_CLIENT_RCE			 (0x1UL << 12)
+	__le16	status;
+	#define CE_CMPL_STATUS_MASK			0xfUL
+	#define CE_CMPL_STATUS_SFT			0
+	#define CE_CMPL_STATUS_OK			 0x0UL
+	#define CE_CMPL_STATUS_CTX_LD_ERR		 0x1UL
+	#define CE_CMPL_STATUS_FID_CHK_ERR		 0x2UL
+	#define CE_CMPL_STATUS_CTX_VER_ERR		 0x3UL
+	#define CE_CMPL_STATUS_DST_ID_ERR		 0x4UL
+	#define CE_CMPL_STATUS_MP_CMD_ERR		 0x5UL
+	u32	opaque;
+	__le32	v;
+	#define CE_CMPL_V           0x1UL
+	__le32	kid;
+	#define CE_CMPL_KID_MASK    0xfffffUL
+	#define CE_CMPL_KID_SFT     0
+};
+
+#define CE_CMPL_STATUS(ce_cmpl)						\
+	(le16_to_cpu((ce_cmpl)->status) & CE_CMPL_STATUS_MASK)
+
+#define CE_CMPL_KID(ce_cmpl)						\
+	(le32_to_cpu((ce_cmpl)->kid) & CE_CMPL_KID_MASK)
+
+struct bnxt_crypto_cmd_ctx {
+	struct completion cmp;
+	struct ce_cmpl ce_cmp;
+	u32 kid;
+	u16 client;
+	u8 status;
+#define BNXT_CMD_CTX_COMPLETED	0x1
+#define BNXT_CMD_CTX_ERROR	0x2
+#define BNXT_CMD_CTX_RESET	0x4
 };
 
 #define BNXT_TCK(crypto)	((crypto)->kctx[BNXT_TX_CRYPTO_KEY_TYPE])
@@ -76,7 +149,11 @@ bool bnxt_kid_valid(struct bnxt_kctx *kctx, u32 id);
 void bnxt_free_one_kctx(struct bnxt_kctx *kctx, u32 id);
 int bnxt_key_ctx_alloc_one(struct bnxt *bp, struct bnxt_kctx *kctx, u8 kind,
 			   u32 *id);
+int bnxt_xmit_crypto_cmd(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			 void *cmd, unsigned int len, unsigned int tmo);
 int bnxt_crypto_init(struct bnxt *bp);
+void bnxt_crypto_mpc_cmp(struct bnxt *bp, u32 client, unsigned long handle,
+			 struct bnxt_cmpl_entry cmpl[], u32 entries);
 #else
 static inline void bnxt_alloc_crypto_info(struct bnxt *bp,
 					  struct hwrm_func_qcaps_output *resp)
@@ -112,9 +189,24 @@ static inline int bnxt_key_ctx_alloc_one(struct bnxt *bp,
 	return -EOPNOTSUPP;
 }
 
+static inline int bnxt_xmit_crypto_cmd(struct bnxt *bp,
+				       struct bnxt_tx_ring_info *txr,
+				       void *cmd, unsigned int len,
+				       unsigned int tmo)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int bnxt_crypto_init(struct bnxt *bp)
 {
 	return 0;
 }
+
+static inline void bnxt_crypto_mpc_cmp(struct bnxt *bp, u32 client,
+				       unsigned long handle,
+				       struct bnxt_cmpl_entry cmpl[],
+				       u32 entries)
+{
+}
 #endif	/* CONFIG_BNXT_TLS */
 #endif	/* BNXT_CRYPTO_H */
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
index b48938a2d04d..06da2440df7b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
@@ -9,6 +9,7 @@
 
 #include "bnxt.h"
 #include "bnxt_mpc.h"
+#include "bnxt_crypto.h"
 
 void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap)
 {
@@ -469,6 +470,150 @@ int bnxt_start_xmit_mpc(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 	return 0;
 }
 
+static bool bnxt_disable_mpc_ring(struct bnxt_mpc_info *mpc, int mpc_ring)
+{
+	struct bnxt_tx_ring_info *txr;
+	bool disabled = false;
+	int i;
+
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		if (mpc_ring >= mpc->mpc_ring_count[i])
+			continue;
+		txr = &mpc->mpc_rings[i][mpc_ring];
+		spin_lock_bh(&txr->tx_lock);
+		if (!READ_ONCE(txr->dev_state)) {
+			disabled = true;
+			WRITE_ONCE(txr->dev_state, BNXT_DEV_STATE_CLOSING);
+		}
+		spin_unlock_bh(&txr->tx_lock);
+		if (!disabled)
+			break;
+	}
+	return disabled;
+}
+
+static void bnxt_enable_mpc_ring(struct bnxt_mpc_info *mpc, int mpc_ring)
+{
+	struct bnxt_tx_ring_info *txr;
+	int i;
+
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		if (mpc_ring >= mpc->mpc_ring_count[i])
+			continue;
+		txr = &mpc->mpc_rings[i][mpc_ring];
+		WRITE_ONCE(txr->dev_state, 0);
+	}
+}
+
+static void bnxt_clear_one_mpc_entries(struct bnxt *bp,
+				       struct bnxt_tx_ring_info *txr)
+{
+	struct bnxt_sw_mpc_tx_bd *tx_buf;
+	unsigned long handle;
+	int i, max_idx;
+	u32 client;
+
+	max_idx = bp->tx_nr_pages * TX_DESC_CNT;
+
+	for (i = 0; i < max_idx; i++) {
+		tx_buf = &txr->tx_mpc_buf_ring[i];
+		handle = tx_buf->handle;
+		if (handle) {
+			client = txr->tx_ring_struct.mpc_chnl_type;
+			bnxt_crypto_mpc_cmp(bp, client, handle, NULL, 0);
+			tx_buf->handle = 0;
+		}
+	}
+}
+
+static void bnxt_mpc_ring_stop(struct bnxt *bp, struct bnxt_mpc_info *mpc,
+			       int mpc_ring)
+{
+	struct bnxt_tx_ring_info *txr;
+	struct bnxt_cp_ring_info *cpr;
+	int i;
+
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		if (mpc->mpc_ring_count[i] > mpc_ring) {
+			txr = &mpc->mpc_rings[i][mpc_ring];
+			bnxt_hwrm_tx_ring_free(bp, txr, true);
+		}
+	}
+	/* CP rings must be freed at the end to guarantee that the HWRM_DONE
+	 * responses for HWRM_RING_FREE can still be seen on the CP rings.
+	 */
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		if (mpc->mpc_ring_count[i] > mpc_ring) {
+			txr = &mpc->mpc_rings[i][mpc_ring];
+			cpr = txr->tx_cpr;
+			if (cpr) {
+				bnxt_hwrm_cp_ring_free(bp, cpr);
+				bnxt_clear_one_cp_ring(bp, cpr);
+			}
+			bnxt_clear_one_mpc_entries(bp, txr);
+		}
+	}
+}
+
+static int bnxt_mpc_ring_start(struct bnxt *bp, struct bnxt_mpc_info *mpc,
+			       int mpc_ring)
+{
+	struct bnxt_tx_ring_info *txr;
+	int i, rc;
+
+	for (i = 0; i < BNXT_MPC_TYPE_MAX; i++) {
+		if (mpc->mpc_ring_count[i] > mpc_ring) {
+			txr = &mpc->mpc_rings[i][mpc_ring];
+			txr->tx_prod = 0;
+			txr->tx_cons = 0;
+			txr->tx_hw_cons = 0;
+			rc = bnxt_hwrm_one_mpc_ring_alloc(bp, txr);
+			if (rc)
+				return rc;
+		}
+	}
+	return 0;
+}
+
+static int bnxt_mpc_ring_reset(struct bnxt *bp, int mpc_ring)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	int rc;
+
+	if (!mpc)
+		return 0;
+	if (mpc_ring >= mpc->mpc_cp_rings)
+		return -EINVAL;
+
+	if (!bnxt_disable_mpc_ring(mpc, mpc_ring))
+		return 0;
+
+	netdev_warn(bp->dev, "Resetting MPC ring %d\n", mpc_ring);
+	netdev_lock(bp->dev);
+	bnxt_mpc_ring_stop(bp, mpc, mpc_ring);
+
+	rc = bnxt_mpc_ring_start(bp, mpc, mpc_ring);
+	if (rc) {
+		netdev_err(bp->dev, "Error starting MPC ring %d, rc: %d, resetting device\n",
+			   mpc_ring, rc);
+		bnxt_mpc_ring_stop(bp, mpc, mpc_ring);
+		bnxt_reset_task(bp, true);
+		netdev_unlock(bp->dev);
+		/* Return here as bnxt_reset_task() will clear everything */
+		return rc;
+	}
+	netdev_unlock(bp->dev);
+	bnxt_enable_mpc_ring(mpc, mpc_ring);
+	return 0;
+}
+
+int bnxt_mpc_timeout(struct bnxt *bp, struct bnxt_tx_ring_info *txr)
+{
+	if (txr->tx_ring_struct.queue_id == BNXT_MPC_QUEUE_ID)
+		return bnxt_mpc_ring_reset(bp, txr->txq_index);
+	return -EINVAL;
+}
+
 static bool bnxt_mpc_unsolicit(struct mpc_cmp *mpcmp)
 {
 	u32 client = MPC_CMP_CLIENT_TYPE(mpcmp);
@@ -539,6 +684,7 @@ int bnxt_mpc_cmp(struct bnxt *bp, struct bnxt_cp_ring_info *cpr, u32 *raw_cons)
 		txr->tx_cons = tx_cons;
 		txr->tx_hw_cons = RING_TX(bp, tx_cons);
 	}
+	bnxt_crypto_mpc_cmp(bp, client, handle, cmpl_entry_arr, cmpl_num);
 
 cmp_done:
 	*raw_cons = tmp_raw_cons;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
index 9958d1749ffb..95ceb02b7cf6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
@@ -22,6 +22,8 @@ enum bnxt_mpc_type {
 #define BNXT_DFLT_MPC_TCE	BNXT_MAX_MPC
 #define BNXT_DFLT_MPC_RCE	BNXT_MAX_MPC
 
+#define BNXT_MPC_TMO_MSECS      1000
+
 struct bnxt_mpc_info {
 	u8			mpc_chnls_cap;
 	u8			mpc_cp_rings;
@@ -106,6 +108,7 @@ void bnxt_hwrm_mpc_ring_free(struct bnxt *bp, bool close_path);
 struct bnxt_tx_ring_info *bnxt_select_mpc_ring(struct bnxt *bp, int ring_type);
 int bnxt_start_xmit_mpc(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 			void *data, unsigned int len, unsigned long handle);
+int bnxt_mpc_timeout(struct bnxt *bp, struct bnxt_tx_ring_info *txr);
 int bnxt_mpc_cmp(struct bnxt *bp, struct bnxt_cp_ring_info *cpr, u32 *raw_cons);
 #else
 static inline void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap)
@@ -192,6 +195,12 @@ static inline int bnxt_start_xmit_mpc(struct bnxt *bp,
 	return -EOPNOTSUPP;
 }
 
+static inline int bnxt_mpc_timeout(struct bnxt *bp,
+				   struct bnxt_tx_ring_info *txr)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int bnxt_mpc_cmp(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 			       u32 *raw_cons)
 {
-- 
2.51.0


