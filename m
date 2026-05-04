Return-Path: <netdev+bounces-284107-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHAIKdsz+WkG6gIAu9opvQ
	(envelope-from <netdev+bounces-284107-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 02:03:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F444C5144
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 02:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE490305D5D3
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 23:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F373FFAB5;
	Mon,  4 May 2026 23:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PVObMNr4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6997D3FFAAE
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 23:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777939174; cv=none; b=m00N2GBdPyXRCdQwEi7DlWhwCNR2RXAUr8OhFlL5eI1fEQz/1MPUvaZuIaa5UwSoEkfr6ZizTjAmXdkT4Sxkh/g8/xsQV3Fp1ElLCgTxAxLnR4RyU7dMsKAvQ7Wk5xhPBWMo0YXda4YC2JIDgJnDu9AtpgDU9r6gwtcdB5NGVXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777939174; c=relaxed/simple;
	bh=th+JXn8UweHObFpKTAQkzErSoVAEVTysup8bKiqz4aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BuKjj1a48vDEc4z3/jALtKBQOjGg1KR7D1eKGzCiNY7hbv8/3iodHF/n9enOA2lCIJi0z1yphi3JGZanbL8D6ISHtxw3BnS0vSXCIj+Fnf+Fd/EH85+kz6UUCEpEYpR76Ye4Kea/dFLoxqiHk/GWJ2Q7e/5bzQHfQAxlcDIbR3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PVObMNr4; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-8b6c9fdb68cso22443576d6.2
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 16:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777939171; x=1778543971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XwSweDBVyc3mh0jWSdzqhH73HrS8jzGMIqisgps/7lk=;
        b=DgFbm9/xQNRTOCi9Bc2ayuFbrnqumj386Rk0o8MVL8GwaKTDN5oJ7HSTLn+sjnVt1i
         uKnYyvgSJM3xH5hlLSXZj/JSgOH5dvaTXAhGRegsfclLtk5mKXCZN9wz+RUAIwvFOOHW
         s9loAQNoWvu8sqdgWZuHnMIXgHQt4AuQ2Pot6BpX7knmRYggNF8kfFWBl0JU/lXIXa8T
         le7lQQuR+Fs588kGngPHVOLjwE1gnYm0G6S16Vm8dhfe37MUK9vijlnIkzjXjjCduueh
         tLBivmym0hEm6dMXukcVvRg7RwliErqfilvePnaJZLe7bl8XiPb6zmHGdH94DeWKHOjd
         rcFQ==
X-Gm-Message-State: AOJu0YziehZY45BvMtuIXCMSZvz3pG2HCCcy/AwZ5WVHVkXcdcrzph+P
	Ni6sEe08YrO8BgVt0N7CdGXr27NQ9mOZr/Z1lzm0EqYGMIDZucJ6hTV6hM4WsxzqSrLrpB6tgAd
	MqGU68dNNdt5HK17cXXcLL/j1KDNTT75F2sw0xljV1Og4hX0x1jULLISrYGexqCYOHjZgqZW5Xl
	8oiv6JGewdAde26Uls9SYTB6x3HmEEGmEcGxelYmk32vYjU0Kpe3jlWPWsJyj0pt0FI7ZD9R09F
	YExyezyJYQ=
X-Gm-Gg: AeBDiesqIqqCOoQ5pFLPvI5zh/EVYcSV7ZZQzrvFPdniheoy714l5Ax12OcR77HR4o1
	XuhjWq3qjUOg9+diomY1XmYuZocHzyxAmkpy1rJGpmcgBpLTJeNwai9KE0+Fqb+8dkkm+5iMcv7
	7R4CLkSmeyQdc+N+E+8iQ59klgkxkv1BL2graRQukj0kxBJSAHNe0t8pQyA45TYLdwOfA+qryAH
	BsrNq72cObYwDFdxbUA5htNaJp7rExRtFfiRZebTinCeFQUXPbR2d0doFoAkPgXAZXSXOgpsEgo
	H8qSpIkB71ZZM0X8jogKZNYHCnAgrH/kB3yGmiWyLsDTIhU92+ygFlxku/KjA3fjBk1mK7vt0iF
	mpWg6eeKPx4MggQpHjb+F1GOJEZcqXnmZkag3ZbbxGhTlbiJsq6y2tYz+STphjZUDhkIOLTC5/p
	X+WNbjTBsvGXuJDflpm3jUSn1WTMA0PAAKDM+rfJrhdT4XTuTZ2kaH5VCkgp8hd3d2RDA=
X-Received: by 2002:a05:6214:3d9e:b0:8ac:b43a:42d8 with SMTP id 6a1803df08f44-8b666100048mr205107936d6.12.1777939171359;
        Mon, 04 May 2026 16:59:31 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8b538efd2bcsm10353176d6.10.2026.05.04.16.59.30
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2026 16:59:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8eb82634cbeso933723285a.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 16:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777939170; x=1778543970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwSweDBVyc3mh0jWSdzqhH73HrS8jzGMIqisgps/7lk=;
        b=PVObMNr4a2dJ72/1TTeP0I15g+VwLk4UmM3kcE6iQ50ObOjwWutM3jTrlGhrqT/66Z
         MbXsOg0bO/BtL13hcdwPRHA6nhRvGJRkE2BiN4ki2KDAHPbmA68VBQaDwplCFwy62rsc
         ISsJ4ofXaHJJP9zJfx1VEpdkdFrR0zmbi2j3Q=
X-Received: by 2002:a05:620a:2892:b0:8cf:d804:4569 with SMTP id af79cd13be357-8fd164c0726mr1851650885a.23.1777939169692;
        Mon, 04 May 2026 16:59:29 -0700 (PDT)
X-Received: by 2002:a05:620a:2892:b0:8cf:d804:4569 with SMTP id af79cd13be357-8fd164c0726mr1851647285a.23.1777939169099;
        Mon, 04 May 2026 16:59:29 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b5396c4b7dsm132298246d6.18.2026.05.04.16.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 16:59:28 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next 09/15] bnxt_en: Add infrastructure for crypto key context IDs
Date: Mon,  4 May 2026 16:58:30 -0700
Message-ID: <20260504235836.3019499-10-michael.chan@broadcom.com>
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
X-Rspamd-Queue-Id: 50F444C5144
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-284107-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:dkim,broadcom.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]

Each kTLS connection requires a crypto key context ID (KID).  These KIDs
are allocated from the firmware in batches.  Add data structure to store
these IDs.  The bnxt_kid_info structure stores a batch of IDs and it can be
linked as we allocate more batches.  There is a bitmap in the structure
to keep track of which ones are in use.  Add APIs to allocate and free
these KIDs.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   3 +
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.c  | 257 ++++++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.h  |  66 +++++
 3 files changed, 326 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 95177b03093a..754b0d3249da 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -17216,6 +17216,9 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	rc = bnxt_dl_register(bp);
 	if (rc)
 		goto init_err_dl;
+	rc = bnxt_crypto_init(bp);
+	if (rc)
+		bnxt_free_crypto_info(bp);
 
 	INIT_LIST_HEAD(&bp->usr_fltr_list);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
index ee154f1e4e19..4ea3e67be9f5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
@@ -8,6 +8,7 @@
 #include <linux/bnxt/hsi.h>
 
 #include "bnxt.h"
+#include "bnxt_hwrm.h"
 #include "bnxt_crypto.h"
 
 static u32 bnxt_get_max_crypto_key_ctx(struct bnxt *bp, int key_type)
@@ -57,12 +58,51 @@ void bnxt_alloc_crypto_info(struct bnxt *bp,
 			kctx = &crypto->kctx[i];
 			kctx->type = i;
 			kctx->max_ctx = bnxt_get_max_crypto_key_ctx(bp, i);
+			INIT_LIST_HEAD(&kctx->list);
+			spin_lock_init(&kctx->lock);
+			atomic_set(&kctx->alloc_pending, 0);
+			init_waitqueue_head(&kctx->alloc_pending_wq);
 		}
 		bp->crypto_info = crypto;
 	}
 	crypto->max_key_ctxs_alloc = max_keys;
 }
 
+/**
+ * bnxt_clear_crypto - Clear all crypto key contexts
+ * @bp: pointer to bnxt device
+ *
+ * Clears all key context allocations during shutdown or firmware reset.
+ * Frees all key info structures and bitmaps, and increments the epoch
+ * counter to invalidate any outstanding key references.
+ *
+ * This function assumes serialization (called during shutdown) and does
+ * not use locking.
+ *
+ * Context: Process context during shutdown/reset
+ */
+void bnxt_clear_crypto(struct bnxt *bp)
+{
+	struct bnxt_crypto_info *crypto = bp->crypto_info;
+	struct bnxt_kid_info *kid, *tmp;
+	struct bnxt_kctx *kctx;
+	int i;
+
+	if (!crypto)
+		return;
+
+	/* Shutting down or FW reset, no need to protect the lists. */
+	for (i = 0; i < BNXT_MAX_CRYPTO_KEY_TYPE; i++) {
+		kctx = &crypto->kctx[i];
+		list_for_each_entry_safe(kid, tmp, &kctx->list, list) {
+			list_del(&kid->list);
+			kfree(kid);
+		}
+		kctx->total_alloc = 0;
+		kctx->epoch++;
+	}
+}
+
 /**
  * bnxt_free_crypto_info - Free crypto offload resources
  * @bp: pointer to bnxt device
@@ -73,6 +113,7 @@ void bnxt_alloc_crypto_info(struct bnxt *bp,
  */
 void bnxt_free_crypto_info(struct bnxt *bp)
 {
+	bnxt_clear_crypto(bp);
 	kfree(bp->crypto_info);
 	bp->crypto_info = NULL;
 }
@@ -107,3 +148,219 @@ void bnxt_hwrm_reserve_pf_key_ctxs(struct bnxt *bp,
 	req->enables |= cpu_to_le32(FUNC_CFG_REQ_ENABLES_KTLS_TX_KEY_CTXS |
 				    FUNC_CFG_REQ_ENABLES_KTLS_RX_KEY_CTXS);
 }
+
+static int bnxt_key_ctx_store(struct bnxt_kctx *kctx, __le32 *key_buf, u32 num,
+			      bool contig, u8 kind, u32 *id)
+{
+	struct bnxt_kid_info *kid;
+	u32 i;
+
+	for (i = 0; i < num; ) {
+		kid = kzalloc_obj(*kid);
+		if (!kid)
+			return -ENOMEM;
+		kid->start_id = le32_to_cpu(key_buf[i]);
+		kid->type = kctx->type;
+		kid->kind = kind;
+		if (contig)
+			kid->count = num;
+		else
+			kid->count = 1;
+		bitmap_set(kid->ids, 0, kid->count);
+		if (id && !i) {
+			clear_bit(0, kid->ids);
+			*id = BNXT_SET_KID(kctx, kid->start_id);
+		}
+		spin_lock(&kctx->lock);
+		list_add_tail_rcu(&kid->list, &kctx->list);
+		kctx->total_alloc += kid->count;
+		spin_unlock(&kctx->lock);
+		i += kid->count;
+	}
+	return 0;
+}
+
+/* Note that the driver does not free the key contexts.  They are freed
+ * by the FW during FLR and HWRM_FUNC_RESET.
+ */
+static int bnxt_hwrm_key_ctx_alloc(struct bnxt *bp, struct bnxt_kctx *kctx,
+				   u8 kind, u32 num, u32 *id)
+{
+	struct bnxt_crypto_info *crypto = bp->crypto_info;
+	struct hwrm_func_key_ctx_alloc_output *resp;
+	struct hwrm_func_key_ctx_alloc_input *req;
+	dma_addr_t mapping;
+	int pending_count;
+	__le32 *key_buf;
+	u32 num_alloc;
+	bool contig;
+	int rc;
+
+	num = min3(num, crypto->max_key_ctxs_alloc, (u32)BNXT_KID_BATCH_SIZE);
+	rc = hwrm_req_init(bp, req, HWRM_FUNC_KEY_CTX_ALLOC);
+	if (rc)
+		return rc;
+
+	key_buf = hwrm_req_dma_slice(bp, req, num * 4, &mapping);
+	if (!key_buf) {
+		rc = -ENOMEM;
+		goto key_alloc_exit;
+	}
+	req->dma_bufr_size_bytes = cpu_to_le32(num * 4);
+	req->host_dma_addr = cpu_to_le64(mapping);
+	resp = hwrm_req_hold(bp, req);
+
+	req->key_ctx_type = kctx->type;
+	req->num_key_ctxs = cpu_to_le16(num);
+
+	pending_count = atomic_inc_return(&kctx->alloc_pending);
+	rc = hwrm_req_send(bp, req);
+	atomic_dec(&kctx->alloc_pending);
+	if (rc)
+		goto key_alloc_exit_wake;
+
+	num_alloc = le16_to_cpu(resp->num_key_ctxs_allocated);
+	if (num_alloc > num)
+		netdev_warn(bp->dev,
+			    "FW allocated more keys (%d) than requested (%d)\n",
+			    num_alloc, num);
+	else
+		num = num_alloc;
+	contig = resp->flags &
+		 FUNC_KEY_CTX_ALLOC_RESP_FLAGS_KEY_CTXS_CONTIGUOUS;
+	rc = bnxt_key_ctx_store(kctx, key_buf, num, contig, kind, id);
+
+key_alloc_exit_wake:
+	if (pending_count >= BNXT_KCTX_ALLOC_PENDING_MAX)
+		wake_up_all(&kctx->alloc_pending_wq);
+key_alloc_exit:
+	hwrm_req_drop(bp, req);
+	return rc;
+}
+
+bool bnxt_kid_valid(struct bnxt_kctx *kctx, u32 id)
+{
+	struct bnxt_kid_info *kid;
+	bool valid = false;
+	u32 epoch;
+
+	epoch = BNXT_KID_EPOCH(id);
+	if (epoch != kctx->epoch)
+		return false;
+
+	id = BNXT_KID_HW(id);
+	rcu_read_lock();
+	list_for_each_entry_rcu(kid, &kctx->list, list) {
+		if (id >= kid->start_id && id < kid->start_id + kid->count) {
+			if (!test_bit(id - kid->start_id, kid->ids)) {
+				valid = true;
+				break;
+			}
+		}
+	}
+	rcu_read_unlock();
+	return valid;
+}
+
+static int bnxt_alloc_one_kctx(struct bnxt_kctx *kctx, u8 kind, u32 *id)
+{
+	struct bnxt_kid_info *kid;
+	int rc = -ENOMEM;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(kid, &kctx->list, list) {
+		u32 idx = 0;
+
+		if (kid->kind != kind)
+			continue;
+		do {
+			idx = find_next_bit(kid->ids, kid->count, idx);
+			if (idx >= kid->count)
+				break;
+			if (test_and_clear_bit(idx, kid->ids)) {
+				*id = BNXT_SET_KID(kctx, kid->start_id + idx);
+				rc = 0;
+				goto alloc_done;
+			}
+		} while (1);
+	}
+
+alloc_done:
+	rcu_read_unlock();
+	return rc;
+}
+
+void bnxt_free_one_kctx(struct bnxt_kctx *kctx, u32 id)
+{
+	struct bnxt_kid_info *kid;
+
+	id = BNXT_KID_HW(id);
+	rcu_read_lock();
+	list_for_each_entry_rcu(kid, &kctx->list, list) {
+		if (id >= kid->start_id && id < kid->start_id + kid->count) {
+			set_bit(id - kid->start_id, kid->ids);
+			break;
+		}
+	}
+	rcu_read_unlock();
+}
+
+#define BNXT_KCTX_ALLOC_RETRY_MAX	3
+
+int bnxt_key_ctx_alloc_one(struct bnxt *bp, struct bnxt_kctx *kctx, u8 kind,
+			   u32 *id)
+{
+	int rc, retry = 0;
+
+	while (retry++ < BNXT_KCTX_ALLOC_RETRY_MAX) {
+		rc = bnxt_alloc_one_kctx(kctx, kind, id);
+		if (!rc)
+			return 0;
+
+		if ((kctx->total_alloc + BNXT_KID_BATCH_SIZE) > kctx->max_ctx)
+			return -ENOSPC;
+
+		if (!BNXT_KCTX_ALLOC_OK(kctx)) {
+			wait_event(kctx->alloc_pending_wq,
+				   BNXT_KCTX_ALLOC_OK(kctx));
+			continue;
+		}
+		rc = bnxt_hwrm_key_ctx_alloc(bp, kctx, kind,
+					     BNXT_KID_BATCH_SIZE, id);
+		if (!rc)
+			return 0;
+	}
+	return -EAGAIN;
+}
+
+int bnxt_crypto_init(struct bnxt *bp)
+{
+	struct bnxt_crypto_info *crypto = bp->crypto_info;
+	struct bnxt_hw_resc *hw_resc = &bp->hw_resc;
+	struct bnxt_hw_crypto_resc *crypto_resc;
+	int rc;
+
+	if (!crypto)
+		return 0;
+
+	crypto_resc = &hw_resc->crypto_resc;
+	BNXT_TCK(crypto).max_ctx = crypto_resc->resv_tx_key_ctxs;
+	BNXT_RCK(crypto).max_ctx = crypto_resc->resv_rx_key_ctxs;
+
+	if (!BNXT_TCK(crypto).max_ctx || !BNXT_RCK(crypto).max_ctx) {
+		bnxt_free_crypto_info(bp);
+		return 0;
+	}
+
+	rc = bnxt_hwrm_key_ctx_alloc(bp, &BNXT_TCK(crypto), BNXT_CTX_KIND_CK_TX,
+				     BNXT_KID_BATCH_SIZE, NULL);
+	if (rc)
+		return rc;
+
+	rc = bnxt_hwrm_key_ctx_alloc(bp, &BNXT_RCK(crypto), BNXT_CTX_KIND_CK_RX,
+				     BNXT_KID_BATCH_SIZE, NULL);
+	if (rc)
+		return rc;
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
index e090491006db..ecdf18ba6d83 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
@@ -16,11 +16,43 @@ enum bnxt_crypto_type {
 	BNXT_MAX_CRYPTO_KEY_TYPE,
 };
 
+#define BNXT_KID_BATCH_SIZE	128
+
+struct bnxt_kid_info {
+	struct list_head	list;
+	u8			type;
+	u8			kind;
+	u32			start_id;
+	u32			count;
+	DECLARE_BITMAP(ids, BNXT_KID_BATCH_SIZE);
+};
+
 struct bnxt_kctx {
+	struct list_head	list;
+	/* to serialize update to the linked list and total_alloc */
+	spinlock_t		lock;
 	u8			type;
+	u8			epoch;
+	u32			total_alloc;
 	u32			max_ctx;
+	atomic_t		alloc_pending;
+#define BNXT_KCTX_ALLOC_PENDING_MAX	8
+	wait_queue_head_t	alloc_pending_wq;
 };
 
+#define BNXT_KID_HW_MASK	0xffffff
+#define BNXT_KID_HW(kid)	((kid) & BNXT_KID_HW_MASK)
+#define BNXT_KID_EPOCH_MASK	0xff000000
+#define BNXT_KID_EPOCH_SHIFT	24
+#define BNXT_KID_EPOCH(kid)	(((kid) & BNXT_KID_EPOCH_MASK) >>	\
+				 BNXT_KID_EPOCH_SHIFT)
+
+#define BNXT_SET_KID(kctx, kid)						\
+	((kid) | ((kctx)->epoch << BNXT_KID_EPOCH_SHIFT))
+
+#define BNXT_KCTX_ALLOC_OK(kctx)	\
+	(atomic_read(&((kctx)->alloc_pending)) < BNXT_KCTX_ALLOC_PENDING_MAX)
+
 struct bnxt_crypto_info {
 	u16			max_key_ctxs_alloc;
 
@@ -30,18 +62,31 @@ struct bnxt_crypto_info {
 #define BNXT_TCK(crypto)	((crypto)->kctx[BNXT_TX_CRYPTO_KEY_TYPE])
 #define BNXT_RCK(crypto)	((crypto)->kctx[BNXT_RX_CRYPTO_KEY_TYPE])
 
+#define BNXT_CTX_KIND_CK_TX	0x11
+#define BNXT_CTX_KIND_CK_RX	0x12
+
 #ifdef CONFIG_BNXT_TLS
 void bnxt_alloc_crypto_info(struct bnxt *bp,
 			    struct hwrm_func_qcaps_output *resp);
+void bnxt_clear_crypto(struct bnxt *bp);
 void bnxt_free_crypto_info(struct bnxt *bp);
 void bnxt_hwrm_reserve_pf_key_ctxs(struct bnxt *bp,
 				   struct hwrm_func_cfg_input *req);
+bool bnxt_kid_valid(struct bnxt_kctx *kctx, u32 id);
+void bnxt_free_one_kctx(struct bnxt_kctx *kctx, u32 id);
+int bnxt_key_ctx_alloc_one(struct bnxt *bp, struct bnxt_kctx *kctx, u8 kind,
+			   u32 *id);
+int bnxt_crypto_init(struct bnxt *bp);
 #else
 static inline void bnxt_alloc_crypto_info(struct bnxt *bp,
 					  struct hwrm_func_qcaps_output *resp)
 {
 }
 
+static inline void bnxt_clear_crypto(struct bnxt *bp)
+{
+}
+
 static inline void bnxt_free_crypto_info(struct bnxt *bp)
 {
 }
@@ -50,5 +95,26 @@ static inline void bnxt_hwrm_reserve_pf_key_ctxs(struct bnxt *bp,
 						 struct hwrm_func_cfg_input *req)
 {
 }
+
+static inline bool bnxt_kid_valid(struct bnxt_kctx *kctx, u32 id)
+{
+	return false;
+}
+
+static inline void bnxt_free_one_kctx(struct bnxt_kctx *kctx, u32 id)
+{
+}
+
+static inline int bnxt_key_ctx_alloc_one(struct bnxt *bp,
+					 struct bnxt_kctx *kctx, u8 kind,
+					 u32 *id)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int bnxt_crypto_init(struct bnxt *bp)
+{
+	return 0;
+}
 #endif	/* CONFIG_BNXT_TLS */
 #endif	/* BNXT_CRYPTO_H */
-- 
2.51.0


