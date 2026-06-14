Return-Path: <netdev+bounces-299168-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cdlzAe5XLmrytgQAu9opvQ
	(envelope-from <netdev+bounces-299168-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 09:27:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A3F6808F6
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 09:27:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=fI8QLzR8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299168-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299168-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=broadcom.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8204303742E
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 07:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4243932E9;
	Sun, 14 Jun 2026 07:25:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f227.google.com (mail-vk1-f227.google.com [209.85.221.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14493939B1
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 07:25:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781421937; cv=none; b=SVHALmFVTy+WSv6cgg0HGotCNRfR7i5S6ZAQfJJImUYVUorpdulNvDNBx6h/NP8MIrzY0dTZvxpgzZn/AtPeS/Yb2Py9TwhzPxY42ODNMIEqcuf6VZEI2N5ih+Q3gQrLcuxdlVtoHY/4C83MkFR3LCgT8G/SjK8HzZHEo35dWGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781421937; c=relaxed/simple;
	bh=wxy/qzCd8yeuz+Fcq9vVnLynoQISxnTe1ciqv9KEpkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbUVdiY35JEAKQwteAooWaBJ255CJqs/3SBupztk8By46fo/7Zq4y9Q49WRd86DXntZDxO6T2leMkU/fK8kUZfktweXBo9U2nwPi9L41I869aT6xaZ17LeMl6uvnH5zJXvwR8gIqQC9GroXuHXnRABEsfU3ABYXTBZNi0GmM8CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fI8QLzR8; arc=none smtp.client-ip=209.85.221.227
Received: by mail-vk1-f227.google.com with SMTP id 71dfb90a1353d-59ebf30a91dso879640e0c.1
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 00:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781421934; x=1782026734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N/E6bs9K0Hfh05tfyGfuMM8464HVjsInxnQWQDIDG5I=;
        b=SoQIchZHCdntbF0y+rnCzWiOkNw01H6goCPp7K3M3bb9RHgnImXo0viR8TqHr+nfgW
         ENryYT9m65iCBBg1cSVMwkXEZfyjPnDATvdWCL+YJNBM5DNlZ64oc/wEzKYjC0oJkiz0
         yHK4QaY49KVR3IvlShxxwcToGagg0fKeeNigHrpXwkyEGuE+uLFir/NCxV2bJcaecNqt
         6B3oinN0rcqv7aCrEimOx9MPNIkUjW6mvt4IzKizIgCEqNFHvAvQaPvUh8Th5dSKIfB9
         BlOWmGiv7fIKjBc7Dc5p5GZ3DYs9gvbCT3nHQIRgkSUw5D9dzXWxiQNTBuCVuzpHFQVf
         UCEA==
X-Gm-Message-State: AOJu0YyEMPxJnqPxeOBPfOjYHXs2e5KhraUCQXIAphRBNiIK5AMmvaYl
	+/8C6niY7+qZp8K6JD/kw9gH29qaEy5QkzPF/1XVKE6DPcXSxr1UpUrBeCYt9Kms1h7WTc6w7kc
	xTM1mgHnwqrD4UxQAJ4Wf0X92qxeZ2H06hG0AMJUAcUsX/Pifz2zvXTvmBvyIAUuC5JtcUZlReB
	CchgMSNNrjaKH8oJ7129um95pZc40f/Vld1149/yxmVYEjzN4rEX7iwmHkRtMe+p7Oph8WrqLM/
	wlBkydoM3s=
X-Gm-Gg: Acq92OENqFqJbSvSvfV0+uXT1YJnCF0MD6lwGm8bLKUKEWefoY2a4RtjvX0YIF5oXBe
	0B9k2jEmDeG4zHTiNIiyjXKEpVuQjN1dMywbhUljvCtTnGqE+tQk6Uz+CZEEVc3JD8/enjFGT3Z
	gobJwqrhRMyl2z8XZVNLEd3cWGpvLvO4a9JXUPA/kLJE7fed5UjW9B8G91xrIsg+9o+nU+MZgP9
	8IpM0ulfGwXTyTF+ff72rMfLTfattNCIHAAWkauBljoJFNnlEaMRduIk5jIsCAsZ0GWLJBwRVjf
	ewBYruSztHt6jvfqfTbxYZwesEezSR7aZkBQrf8qlvzB8A81wzzA2Zje5wfLpXt+66A+ceGSWUB
	GL/xqksiCLzVVyVX71U5kl4aciUddUfx3LQJWDGQ3xLSlaQFq7HVOq+XpEcVNEcF9/Bki8nXahS
	ah9W0amfgzTFiOuCkxLYn0GeZ1Nl4DvbEtfYxixRUNn0mgPnEKDnuvj0EW8+Y=
X-Received: by 2002:a05:6102:504c:b0:66a:4052:3e20 with SMTP id ada2fe7eead31-71f617142c8mr2807962137.26.1781421934552;
        Sun, 14 Jun 2026 00:25:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-966a04ad22fsm65802241.3.2026.06.14.00.25.33
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jun 2026 00:25:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-304e7fc90b1so2637700eec.1
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 00:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1781421933; x=1782026733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/E6bs9K0Hfh05tfyGfuMM8464HVjsInxnQWQDIDG5I=;
        b=fI8QLzR8wrjyKSexD+wo9lAFtLOp/vYcDCe+EGouaDYryBLq5GiOUrzKbKf984Ip7b
         jaeIcsbIfORbVOJyVt3SqcdprysxyJRdGUmoKICcit/Pxk1RZk32gxlJeM7eLCZ941k5
         ALKChFVA0LJkr1CqVlNVHEq3OWcEsskIjTIjk=
X-Received: by 2002:a05:7300:fe07:b0:304:2cc9:2ba8 with SMTP id 5a478bee46e88-3093ef21d25mr3058145eec.30.1781421932636;
        Sun, 14 Jun 2026 00:25:32 -0700 (PDT)
X-Received: by 2002:a05:7300:fe07:b0:304:2cc9:2ba8 with SMTP id 5a478bee46e88-3093ef21d25mr3058134eec.30.1781421931859;
        Sun, 14 Jun 2026 00:25:31 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea43bc7sm10043280eec.22.2026.06.14.00.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 00:25:31 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v3 10/15] bnxt_en: Add MPC transmit and completion functions
Date: Sun, 14 Jun 2026 00:24:02 -0700
Message-ID: <20260614072407.2761092-11-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20260614072407.2761092-1-michael.chan@broadcom.com>
References: <20260614072407.2761092-1-michael.chan@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-299168-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,broadcom.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 55A3F6808F6

Add transmit, ring selection, and completion functions for midpath rings.
These will be used to send control data to the crypto engines.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v3:
Use WRITE_ONCE() for TX prod/cons.

v2: 
https://lore.kernel.org/netdev/20260512212105.3488258-11-michael.chan@broadcom.com/

Fix unused variable warnings

v1:
https://lore.kernel.org/netdev/20260504235836.3019499-11-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c | 157 ++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h |  65 ++++++++
 4 files changed, 227 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6eef518a96b0..dc8957243cc6 100644
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
index 53fdc45f8020..7e24949f2238 100644
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
index cd104b7ff1d7..30f4b3bf181b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.c
@@ -405,3 +405,160 @@ void bnxt_hwrm_mpc_ring_free(struct bnxt *bp, bool close_path)
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
+	n = raw_smp_processor_id() % mpc->mpc_ring_count[ring_type];
+	return &mpc->mpc_rings[ring_type][n];
+}
+
+/**
+ * bnxt_start_xmit_mpc - Transmit message on an MPC ring
+ * @bp: pointer to bnxt device
+ * @txr: MPC TX ring structure pointer
+ * @data: MPC message pointer
+ * @len: MPC message length
+ * @handle: Non-zero handle passed back for the completion
+ *
+ * This function is called to transmit an MPC message on an MPC TX ring.
+ * The caller must hold txr->tx_lock.  When successful, the HW will return
+ * a completion and bnxt_crypto_mpc_cmp() will be called with the handle
+ * passed back.
+ *
+ * Return: zero on success, negative error code otherwise:
+ *	ENODEV: MPC TX ring is shutting down.
+ *	EBUSY: MPC TX ring is full
+ */
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
+	WRITE_ONCE(txr->tx_prod, prod);
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
+		if (TX_OPAQUE_RING(opaque) != txr->tx_napi_idx) {
+			netdev_warn(bp->dev, "Wrong opaque %x, expected ring %x, cons idx %x\n",
+				    opaque, txr->tx_napi_idx, txr->tx_cons);
+			goto cmp_done;
+		}
+		mpc_buf = &txr->tx_mpc_buf_ring[RING_TX(bp, tx_cons)];
+		mpc_buf->handle = 0;
+		tx_cons += mpc_buf->inline_bds;
+		WRITE_ONCE(txr->tx_cons, tx_cons);
+		txr->tx_hw_cons = RING_TX(bp, tx_cons);
+	}
+
+cmp_done:
+	*raw_cons = tmp_raw_cons;
+	return 0;
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_mpc.h
index cdc03a074963..aa7f2666f0ca 100644
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
+	 MPC_CMP_SUBTYPE) != MPC_CMP_SUBTYPE_SOLICITED)
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


