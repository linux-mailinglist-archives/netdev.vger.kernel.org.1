Return-Path: <netdev+bounces-284108-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHjUKO8y+WkG6gIAu9opvQ
	(envelope-from <netdev+bounces-284108-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 01:59:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D434C50DB
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 01:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AAA03020EC6
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 23:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7579638B15B;
	Mon,  4 May 2026 23:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="U38XZodn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD05E40149B
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 23:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777939176; cv=none; b=W9EtoRl1WwBS3pLD3+pMiyWrfL86Qq3I5fg92myjOFc1cXKDQSiXHe5hHij7NdZID+cCXSYJMOSgV3jEOhujjw+mY/AARi96onoK79QAZe5yKwrXjSFzo/L+pfpxA8GBOMqy1MQpp+BPBGEDfkF13o9LTSyKf47rfrpK5crwPds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777939176; c=relaxed/simple;
	bh=dig6uPrZoRew5Hy9y1KMMW4Xbts2kaocedIYq/ZJKPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qHpPTarxet1nSS0gOq27swQQUCWls2Ewx4HsBA/6oQl0/vqyY0TgAenKjoj+qSs3O4K2ZabAUWi2H4yv6riB4pHN8/3xvHifOO0GwpT/gDes3NnidK/T0sTwKtegzJSchy+A+0yecNaA6+kSMwGieYpvuS5WMWEXurH92HxKCkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=U38XZodn; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2ba17c8cfacso16382435ad.2
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 16:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777939174; x=1778543974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UrdMJ0FOF/Z9pGtbpAUWlge3/OLalndJGOM/HwuV4kM=;
        b=pfTkS1lSVimkDBCN+dD6KoyKSqlnoLLt7IpGxFwslpgc5HQrv0+QZ+NgQSOpgXbtI1
         8vjkNkNzjSJqxlss4xIYSz64UzTJqh8Wv13mIJjySWVYDzBDK1gDAFvZXJwKJs8SP7JE
         tYfzI4naM+WMO8rwLNxvIFIPLJaydlVTuZznJbitMKyhz2FTboaQbEfb6KRYNk0NHSiI
         vw4dapxrrf6pc+7a1upGZJFemPFKRIb8GNDlwza3NOoqNU1EyxKuefoQhD5Zoa5EufA8
         G/z7jw0IHCpYgcsk24y/3ev+W5wWkf604wtFjUS2vWnWEs3e0AkzqKADatfENnvAoiUf
         6bwA==
X-Gm-Message-State: AOJu0YxQ1v+ZtQ0g9ezJLacrfeJttEzEhlLSLTc52fds2Pa/6iUgeBYJ
	zC7RSpQfV64QR8UhOd7ZoaATtd1STl0uCdhde/0lmUbHMbVwdeyHyd23ySeXboRIcDS6rXT2IY7
	Wuz4Jq5NW4IqSf2yye7rQRW8Dubf5nQ43BkSNq3u6obnpKSEq+0d555L7MvzMFxV+b91mgAr45S
	sEqR7vvYtm4IVsQ7cjRfh6cSOZbDgHMo5n90Fw+c5cC8BVDXEGOV8JGCidIopZ/Fd7qzVxNWEl4
	+CiTpfRqLQ=
X-Gm-Gg: AeBDiesyZn/Bb4gsuWwKmmPWtUxprgWCmEsMYbCC6swPNXmz5oSlSmrbC8byy4WjDRj
	VPzMkdJZukiRVc8VjhXx3IQ61wgwTYxRqpuRXIsF4ijQMyhZ32v0f1d+EPbAp1oE0idkrAYUHDm
	hvoHh6w9jKg9DW2fAPRYh62/3n79efrkbs6aOMaZ9Ym3Gw/ztgoZuNwy+0SbADvVkgNpxSgBjHK
	rJ3vl9De4Lii7tG0TxqXDKJZMSjSZdgyZb+m8euUDAV2MaXXZgbBfyDilMwI16/S0sql0HwEenz
	qJdun9nTFON7lL31N1K+dg40P7GjPAb0ZKc+4J+MWfsNYURCDpyTIDcNlyBvOHnniE9B3IcDq2H
	x1SPUF8/e8scpWoprS16c/TZJ5sTKM/Z2ExVCgI0LzAf4YekQMXwZ4JWLs6SK09gU4Wf0Gc8GV1
	t9OmdLcKk6zmStRAg=
X-Received: by 2002:a17:903:acb:b0:2b2:5503:1b8d with SMTP id d9443c01a7336-2ba535c157emr6902005ad.6.1777939173861;
        Mon, 04 May 2026 16:59:33 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b9cab81ee8sm7655955ad.42.2026.05.04.16.59.32
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2026 16:59:33 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50fae95c82cso9694921cf.2
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 16:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777939171; x=1778543971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrdMJ0FOF/Z9pGtbpAUWlge3/OLalndJGOM/HwuV4kM=;
        b=U38XZodnFe4i4MX9cxQgsaB7h7oS8g5X3nTBEBoVIc2HxCIX22fpC2d/DPXPsGIhHP
         i97SREwrqiODnBASRUsBVe+ruuHznef3nEWefRHm5RJ4jdTBTdRR6+fbfMpchWYBSJZD
         QrLeUG0hbzDr4QUuCg96pKCkmgJzma4UyRonE=
X-Received: by 2002:a05:622a:344:b0:510:2506:1ba9 with SMTP id d75a77b69052e-51306ad104cmr14486671cf.49.1777939171255;
        Mon, 04 May 2026 16:59:31 -0700 (PDT)
X-Received: by 2002:a05:622a:344:b0:510:2506:1ba9 with SMTP id d75a77b69052e-51306ad104cmr14486451cf.49.1777939170817;
        Mon, 04 May 2026 16:59:30 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b5396c4b7dsm132298246d6.18.2026.05.04.16.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 16:59:30 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next 10/15] bnxt_en: Add MPC transmit and completion functions
Date: Mon,  4 May 2026 16:58:31 -0700
Message-ID: <20260504235836.3019499-11-michael.chan@broadcom.com>
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
X-Rspamd-Queue-Id: 19D434C50DB
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
	TAGGED_FROM(0.00)[bounces-284108-lists,netdev=lfdr.de];
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

Add transmit, ring selection, and completion functions for midpath rings.
These will be used to send control data to the crypto engines.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c | 141 ++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h |  65 ++++++++
 4 files changed, 211 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 754b0d3249da..5976f66e82bd 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3109,6 +3109,9 @@ static int __bnxt_poll_work(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 				rx_pkts++;
 			else if (rc == -EBUSY)	/* partial completion */
 				break;
+		} else if (cmp_type == CMP_TYPE_MPC_CMP) {
+			if (bnxt_mpc_cmp(bp, cpr, &raw_cons))
+				break;
 		} else if (unlikely(cmp_type == CMPL_BASE_TYPE_HWRM_DONE ||
 				    cmp_type == CMPL_BASE_TYPE_HWRM_FWD_REQ ||
 				    cmp_type == CMPL_BASE_TYPE_HWRM_ASYNC_EVENT)) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index b832780b783d..f30e7c90471b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -47,6 +47,7 @@ struct tx_bd {
 	__le32 tx_bd_len_flags_type;
 	#define TX_BD_TYPE					(0x3f << 0)
 	 #define TX_BD_TYPE_SHORT_TX_BD				 (0x00 << 0)
+	 #define TX_BD_TYPE_MPC_TX_BD				 (0x08 << 0)
 	 #define TX_BD_TYPE_LONG_TX_BD				 (0x10 << 0)
 	#define TX_BD_FLAGS_PACKET_END				(1 << 6)
 	#define TX_BD_FLAGS_NO_CMPL				(1 << 7)
@@ -160,6 +161,7 @@ struct tx_cmp {
 	 #define CMP_TYPE_RX_TPA_AGG_CMP			 22
 	 #define CMP_TYPE_RX_L2_V3_CMP				 23
 	 #define CMP_TYPE_RX_L2_TPA_START_V3_CMP		 25
+	 #define CMP_TYPE_MPC_CMP				 30
 	 #define CMP_TYPE_STATUS_CMP				 32
 	 #define CMP_TYPE_REMOTE_DRIVER_REQ			 34
 	 #define CMP_TYPE_REMOTE_DRIVER_RESP			 36
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
index e9d92b01438a..b48938a2d04d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
@@ -403,3 +403,144 @@ void bnxt_hwrm_mpc_ring_free(struct bnxt *bp, bool close_path)
 		}
 	}
 }
+
+struct bnxt_tx_ring_info *bnxt_select_mpc_ring(struct bnxt *bp, int ring_type)
+{
+	struct bnxt_mpc_info *mpc = bp->mpc_info;
+	int n;
+
+	if (!mpc || ring_type >= BNXT_MPC_TYPE_MAX ||
+	    !mpc->mpc_ring_count[ring_type])
+		return NULL;
+
+	n = smp_processor_id() % mpc->mpc_ring_count[ring_type];
+	return &mpc->mpc_rings[ring_type][n];
+}
+
+int bnxt_start_xmit_mpc(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			void *data, unsigned int len, unsigned long handle)
+{
+	u32 bds, total_bds, bd_space, free_size;
+	struct bnxt_sw_mpc_tx_bd *tx_buf;
+	struct tx_bd *txbd;
+	u16 prod;
+
+	if (READ_ONCE(txr->dev_state) == BNXT_DEV_STATE_CLOSING)
+		return -ENODEV;
+
+	bds = DIV_ROUND_UP(len, sizeof(*txbd));
+	total_bds = bds + 1;
+	free_size = bnxt_tx_avail(bp, txr);
+	if (free_size < total_bds)
+		return -EBUSY;
+
+	prod = txr->tx_prod;
+	txbd = &txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
+	tx_buf = &txr->tx_mpc_buf_ring[RING_TX(bp, prod)];
+	tx_buf->handle = handle;
+	tx_buf->inline_bds = total_bds;
+
+	txbd->tx_bd_len_flags_type =
+		cpu_to_le32((len << TX_BD_LEN_SHIFT) | TX_BD_TYPE_MPC_TX_BD |
+			    TX_BD_CNT(total_bds));
+	txbd->tx_bd_opaque = SET_TX_OPAQUE(bp, txr, prod, total_bds);
+
+	prod = NEXT_TX(prod);
+	txbd = &txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
+	bd_space = TX_DESC_CNT - TX_IDX(prod);
+	if (bd_space < bds) {
+		unsigned int len0 = bd_space * sizeof(*txbd);
+
+		memcpy(txbd, data, len0);
+		prod += bd_space;
+		txbd = &txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
+		bds -= bd_space;
+		len -= len0;
+		data += len0;
+	}
+	memcpy(txbd, data, len);
+	prod += bds;
+	txr->tx_prod = prod;
+
+	/* Sync BD data before updating doorbell */
+	wmb();
+	bnxt_db_write(bp, &txr->tx_db, prod);
+
+	return 0;
+}
+
+static bool bnxt_mpc_unsolicit(struct mpc_cmp *mpcmp)
+{
+	u32 client = MPC_CMP_CLIENT_TYPE(mpcmp);
+
+	if (client != MPC_CMP_CLIENT_TCE && client != MPC_CMP_CLIENT_RCE)
+		return false;
+	return MPC_CMP_UNSOLICIT_SUBTYPE(mpcmp);
+}
+
+int bnxt_mpc_cmp(struct bnxt *bp, struct bnxt_cp_ring_info *cpr, u32 *raw_cons)
+{
+	struct bnxt_cmpl_entry cmpl_entry_arr[2];
+	struct bnxt_napi *bnapi = cpr->bnapi;
+	u16 cons = RING_CMP(*raw_cons);
+	struct mpc_cmp *mpcmp, *mpcmp1;
+	u32 tmp_raw_cons = *raw_cons;
+	unsigned long handle = 0;
+	u32 client, cmpl_num;
+	u8 type;
+
+	mpcmp = (struct mpc_cmp *)
+		&cpr->cp_desc_ring[CP_RING(cons)][CP_IDX(cons)];
+	type = MPC_CMP_CMP_TYPE(mpcmp);
+	cmpl_entry_arr[0].cmpl = mpcmp;
+	cmpl_entry_arr[0].len = sizeof(*mpcmp);
+	cmpl_num = 1;
+	if (type == MPC_CMP_TYPE_MID_PATH_LONG) {
+		tmp_raw_cons = NEXT_RAW_CMP(tmp_raw_cons);
+		cons = RING_CMP(tmp_raw_cons);
+		mpcmp1 = (struct mpc_cmp *)
+			 &cpr->cp_desc_ring[CP_RING(cons)][CP_IDX(cons)];
+
+		if (!MPC_CMP_VALID(bp, mpcmp1, tmp_raw_cons))
+			return -EBUSY;
+		/* The valid test of the entry must be done first before
+		 * reading any further.
+		 */
+		dma_rmb();
+		if (mpcmp1 == mpcmp + 1) {
+			cmpl_entry_arr[cmpl_num - 1].len += sizeof(*mpcmp1);
+		} else {
+			cmpl_entry_arr[cmpl_num].cmpl = mpcmp1;
+			cmpl_entry_arr[cmpl_num].len = sizeof(*mpcmp1);
+			cmpl_num++;
+		}
+	}
+	client = MPC_CMP_CLIENT_TYPE(mpcmp) >> MPC_CMP_CLIENT_SFT;
+	if (client >= BNXT_MPC_TYPE_MAX)
+		goto cmp_done;
+
+	if (!bnxt_mpc_unsolicit(mpcmp)) {
+		struct bnxt_sw_mpc_tx_bd *mpc_buf;
+		struct bnxt_tx_ring_info *txr;
+		u16 tx_cons;
+		u32 opaque;
+
+		opaque = mpcmp->mpc_cmp_opaque;
+		txr = bnapi->tx_mpc_ring[client];
+		tx_cons = txr->tx_cons;
+		if (TX_OPAQUE_RING(opaque) != txr->tx_napi_idx)
+			netdev_warn(bp->dev, "Wrong opaque %x, expected ring %x, idx %x\n",
+				    opaque, txr->tx_napi_idx, txr->tx_cons);
+		mpc_buf = &txr->tx_mpc_buf_ring[RING_TX(bp, tx_cons)];
+		if (!READ_ONCE(txr->dev_state))
+			handle = mpc_buf->handle;
+		mpc_buf->handle = 0;
+		tx_cons += mpc_buf->inline_bds;
+		txr->tx_cons = tx_cons;
+		txr->tx_hw_cons = RING_TX(bp, tx_cons);
+	}
+
+cmp_done:
+	*raw_cons = tmp_raw_cons;
+	return 0;
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
index cdc03a074963..9958d1749ffb 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
@@ -30,11 +30,53 @@ struct bnxt_mpc_info {
 };
 
 struct bnxt_sw_mpc_tx_bd {
+	u8 inline_bds;
 	unsigned long handle;
 };
 
 #define SW_MPC_TXBD_RING_SIZE (sizeof(struct bnxt_sw_mpc_tx_bd) * TX_DESC_CNT)
 
+struct bnxt_cmpl_entry {
+	void *cmpl;
+	u32 len;
+};
+
+struct mpc_cmp {
+	__le32 mpc_cmp_client_subtype_type;
+	#define MPC_CMP_TYPE					(0x3f << 0)
+	 #define MPC_CMP_TYPE_MID_PATH_SHORT			 0x1e
+	 #define MPC_CMP_TYPE_MID_PATH_LONG			 0x1f
+	#define MPC_CMP_SUBTYPE					0xf00
+	#define MPC_CMP_SUBTYPE_SFT				 8
+	 #define MPC_CMP_SUBTYPE_SOLICITED			 (0x0 << 8)
+	 #define MPC_CMP_SUBTYPE_ERR				 (0x1 << 8)
+	 #define MPC_CMP_SUBTYPE_RESYNC				 (0x2 << 8)
+	#define MPC_CMP_CLIENT					(0xf << 12)
+	 #define MPC_CMP_CLIENT_SFT				 12
+	 #define MPC_CMP_CLIENT_TCE				 (0x0 << 12)
+	 #define MPC_CMP_CLIENT_RCE				 (0x1 << 12)
+	 #define MPC_CMP_CLIENT_TE_CFA				 (0x2 << 12)
+	 #define MPC_CMP_CLIENT_RE_CFA				 (0x3 << 12)
+	u32 mpc_cmp_opaque;
+	__le32 mpc_cmp_v;
+	#define MPC_CMP_V					(1 << 0)
+	__le32 mpc_cmp_filler;
+};
+
+#define MPC_CMP_CMP_TYPE(mpcmp)						\
+	(le32_to_cpu((mpcmp)->mpc_cmp_client_subtype_type) & MPC_CMP_TYPE)
+
+#define MPC_CMP_CLIENT_TYPE(mpcmp)					\
+	(le32_to_cpu((mpcmp)->mpc_cmp_client_subtype_type) & MPC_CMP_CLIENT)
+
+#define MPC_CMP_UNSOLICIT_SUBTYPE(mpcmp)				\
+	((le32_to_cpu((mpcmp)->mpc_cmp_client_subtype_type) &		\
+	 MPC_CMP_SUBTYPE) == MPC_CMP_SUBTYPE_ERR)
+
+#define MPC_CMP_VALID(bp, mpcmp, raw_cons)				\
+	(!!((mpcmp)->mpc_cmp_v & cpu_to_le32(MPC_CMP_V)) ==		\
+	 !((raw_cons) & (bp)->cp_bit))
+
 #define BNXT_MPC_CRYPTO_CAP    \
 	(FUNC_QCAPS_RESP_MPC_CHNLS_CAP_TCE | FUNC_QCAPS_RESP_MPC_CHNLS_CAP_RCE)
 
@@ -61,6 +103,10 @@ void bnxt_free_mpc_rings(struct bnxt *bp);
 void bnxt_init_mpc_rings(struct bnxt *bp);
 int bnxt_hwrm_mpc_ring_alloc(struct bnxt *bp);
 void bnxt_hwrm_mpc_ring_free(struct bnxt *bp, bool close_path);
+struct bnxt_tx_ring_info *bnxt_select_mpc_ring(struct bnxt *bp, int ring_type);
+int bnxt_start_xmit_mpc(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+			void *data, unsigned int len, unsigned long handle);
+int bnxt_mpc_cmp(struct bnxt *bp, struct bnxt_cp_ring_info *cpr, u32 *raw_cons);
 #else
 static inline void bnxt_alloc_mpc_info(struct bnxt *bp, u8 mpc_chnls_cap)
 {
@@ -132,5 +178,24 @@ static inline int bnxt_hwrm_mpc_ring_alloc(struct bnxt *bp)
 static inline void bnxt_hwrm_mpc_ring_free(struct bnxt *bp, bool close_path)
 {
 }
+
+static inline struct bnxt_tx_ring_info *bnxt_select_mpc_ring(struct bnxt *bp,
+							     int ring_type)
+{
+	return NULL;
+}
+
+static inline int bnxt_start_xmit_mpc(struct bnxt *bp,
+				      struct bnxt_tx_ring_info *txr, void *data,
+				      unsigned int len, unsigned long handle)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int bnxt_mpc_cmp(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
+			       u32 *raw_cons)
+{
+	return 0;
+}
 #endif	/* CONFIG_BNXT_TLS */
 #endif	/* BNXT_MPC_H */
-- 
2.51.0


