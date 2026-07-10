Return-Path: <netdev+bounces-306430-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P9XeMNB0UGpPzQIAu9opvQ
	(envelope-from <netdev+bounces-306430-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 06:28:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C81F737216
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 06:28:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=broadcom.com header.s=google header.b=PKo83Xlw;
	dmarc=pass (policy=reject) header.from=broadcom.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306430-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306430-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A88B2301E3F2
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 04:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9268248B;
	Fri, 10 Jul 2026 04:25:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1297136C9ED
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 04:25:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783657503; cv=none; b=elHluFYllKRQCH+bEXbIprRuqqIVu2TV6f2HRxjctna+hivqz7AW45QT/r6v0mxneaVtWdLenGCAdASPvUO00Cp4LH/SnHOxFJBPtNy0rWoydbl5ZmXY7n9PrbH8MdElpSPQawjk/gt0qeSLK20dua5b0b2OsxBZWFhNO228rYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783657503; c=relaxed/simple;
	bh=asO76Hi/zD9Qdt1/2awLcTZ8I0QZOqruzadM6BJ37d8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MwhCn3thg7bkW6ccVrnCN++2t4VHAapJBBVPx57ryZ7MlSKdHcrhdoyY/gLUrCXUNxUoDpDWQbvnI9ZUrkgEsoHvukTE/oipwGYVTeVw8Q3KfKwfYLHuHKCo2vAw8ulqtOO9e6PiDTnvrMReYEQWrx4rBh5aZotDKeEQcdbNg70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PKo83Xlw; arc=none smtp.client-ip=209.85.214.226
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso3112115ad.1
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 21:25:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783657500; x=1784262300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4pme/+XpwdSvI+euzt0/BYosdvjm6rJfhHlerTYG2wQ=;
        b=J9tSGmZesGxFS1FQb1IcJgk1DiQ2kH9Nqq/bNt2hecqykJVRTvA9KZEml561/RQ5xq
         9Zv84PGNNB9bIoKIaFca3Mr8wBlQLZdF57cV+oZdZ/EwRdb6Nc/X6Zq4A+jXfLMBACE7
         AFmRsUHPBBqqHRzVfjCEzjsQyissrszMSv7OkZ2GjfRYA+p2nD2feSY6/wFw4hoWFFi3
         wixJeXesjwuvw3CqFKNTJdHcqTmC/guAe5zjehUPI/FTsmCaXQ5mqMXalGlQi1V1Z+sP
         DFuGKi/t0D8C4ARRxjlyIwCTdmR1AXYlmBRpmesuAeGpN+lMgej3sdEj+S5uESL1iEXJ
         pXFQ==
X-Gm-Message-State: AOJu0YwuNFaag1EJ4vOPO+iQxx9DxnWC5L9eH8C5sdpPnNWGE7lBXcYL
	nQRUXXxPRVfFbOVm8DbH66ZdB32EpkKW3kyq8vGYb2Y9Mx5G18XnygYv4xhl8wpZZWxpfRiaSZv
	6quPHYksKlb5R70xIJ0+Oqo92vVmH7ETqMg/MsPLhqAvyulEQqhlRzlsq2lvHsbeZh3AD94V3HU
	u9rgQUUyc7tY898CMacqwGqqOIK400qbm3lAD5yPGBwdio+VWYSW0CqSd/qBsoZYPnKvs9dJThV
	j6EdKf+WaU=
X-Gm-Gg: AfdE7clLzqoXkFZIb7wpaDie5KuWFn1P2STASJTpi+/vU+kDZaqEZkhpB71I2jGDs3y
	ortRGye6FB1WCoqkLEtIDleqDuK78eUHSOtax35nyTLHvmcHJvuhvv9DdGINfxsYhcH7NknS4fa
	wDs/hMOuK8s/nPYFL6rmK3imh8L5oBoxUVhgw45kj+TC/79jw618kxo3I3o5SQEux/KKHkQlYhy
	yt/RRi+qZc82k4j72ff6Yqd5KnVIIJIXhQTfTulOL25Hnfq8TmvGoj73Lv3m/XMFz9LUkRuVj3m
	4KjtJEnKhAYSsHDHqzRRVFrLct53zgmat2WBHmHqVkApvlsWh2uRvoqUyB/PKjQFgF4MV8MTjoX
	MdvCDXcKFoilyvSaLVOeOw5Au8Fu//OzBwMMMEB4TpQyoZwGV8AtARZSeprR/0MGbOvA95FV0Ib
	wopc0SA1nMhdDT6zU7yA5fOCo+YUUcwrVhO9fzRMjVg72rPQ==
X-Received: by 2002:a17:902:f550:b0:2ca:caa5:9c04 with SMTP id d9443c01a7336-2ccea4295a2mr109031665ad.23.1783657500270;
        Thu, 09 Jul 2026 21:25:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ccc9cff240sm9721215ad.54.2026.07.09.21.24.59
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2026 21:25:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3810960140eso1043329a91.2
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 21:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1783657498; x=1784262298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4pme/+XpwdSvI+euzt0/BYosdvjm6rJfhHlerTYG2wQ=;
        b=PKo83Xlwszfb6MluMowwVoAYg3gXvgvuiJ58NZCbWWSDjFyuQlXpNRuF+3HYsogkWh
         oug9zO1U4Kk4Mws9ISlU670Hylx9jbWAasp/XhwPC7RFaAthV6sFOgTtNqCYarKhv2UL
         8MUP+R1MjMNxQzbboZAUDptma+JGdcfm6BDlM=
X-Received: by 2002:a17:90a:da8b:b0:380:9f17:6df3 with SMTP id 98e67ed59e1d1-3893fe5acfcmr9654160a91.4.1783657497669;
        Thu, 09 Jul 2026 21:24:57 -0700 (PDT)
X-Received: by 2002:a17:90a:da8b:b0:380:9f17:6df3 with SMTP id 98e67ed59e1d1-3893fe5acfcmr9654129a91.4.1783657496931;
        Thu, 09 Jul 2026 21:24:56 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b4cbafa1sm276627eec.6.2026.07.09.21.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 21:24:55 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v5 09/15] bnxt_en: Add infrastructure for crypto key context IDs
Date: Thu,  9 Jul 2026 21:23:54 -0700
Message-ID: <20260710042400.3996847-10-michael.chan@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	TAGGED_FROM(0.00)[bounces-306430-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,broadcom.com:from_mime,broadcom.com:email,broadcom.com:mid,broadcom.com:dkim];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C81F737216

Each kTLS connection requires a crypto key context ID (KID).  These KIDs
are allocated from the firmware in batches.  Add data structure to store
these IDs.  The bnxt_kid_info structure stores a batch of IDs and it can be
linked as we allocate more batches.  There is a bitmap in the structure
to keep track of which ones are in use.  Add APIs to allocate and free
these KIDs.

Once allocated, these KIDs are not freed during run-time.  They are
re-used for new connections.  FW reset or HWRM_FUNC_RESET will free
all KIDs.  Call bnxt_clear_crypto() to clear all KIDs in the driver's
structures during these reset events.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v5:
More clearly document and explain that bnxt_clear_crypto() has no
concurrent readers/writers.

Add comment to explain that the bnxt_free_one_ctx() caller is reponsible
to check the epoch value when needed.

v4:
https://lore.kernel.org/netdev/20260629184921.3496727-10-michael.chan@broadcom.com/

Fix kernel doc for bnxt_free_one_kctx().

Add BNXT_NEXT_EPOCH() to mask the epoch value.

v3:
https://lore.kernel.org/netdev/20260614072407.2761092-10-michael.chan@broadcom.com/

Use a larger (12-bit) epoch value for the keys.

Improve comments, kerneldoc, and dmesg.

Make sure bnxt_clear_crypto() is called during shutdown with the
BNXT_STATE_OPEN flag cleared.

v2:
https://lore.kernel.org/netdev/20260512212105.3488258-10-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  10 +
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.c  | 285 ++++++++++++++++++
 .../net/ethernet/broadcom/bnxt/bnxt_crypto.h  |  70 +++++
 3 files changed, 365 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 27f9843f9c5d..4f7042d91078 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -12899,6 +12899,8 @@ static int bnxt_hwrm_if_change(struct bnxt *bp, bool up)
 				bnxt_ulp_irq_stop(bp);
 			bnxt_free_ctx_mem(bp, false);
 			bnxt_dcb_free(bp);
+			if (fw_reset || caps_change)
+				bnxt_clear_crypto(bp);
 			rc = bnxt_fw_init_one(bp);
 			if (rc) {
 				clear_bit(BNXT_STATE_FW_RESET_DET, &bp->state);
@@ -14636,6 +14638,7 @@ static void bnxt_fw_reset_close(struct bnxt *bp)
 	bnxt_hwrm_func_drv_unrgtr(bp);
 	if (pci_is_enabled(bp->pdev))
 		pci_disable_device(bp->pdev);
+	bnxt_clear_crypto(bp);
 	bnxt_free_ctx_mem(bp, false);
 }
 
@@ -17292,6 +17295,12 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	rc = bnxt_dl_register(bp);
 	if (rc)
 		goto init_err_dl;
+	rc = bnxt_crypto_init(bp);
+	if (rc) {
+		bnxt_free_crypto_info(bp);
+		netdev_warn(bp->dev, "Failed to initialize crypto offload, err = %d\n",
+			    rc);
+	}
 
 	INIT_LIST_HEAD(&bp->usr_fltr_list);
 
@@ -17518,6 +17527,7 @@ static pci_ers_result_t bnxt_io_error_detected(struct pci_dev *pdev,
 
 	if (pci_is_enabled(pdev))
 		pci_disable_device(pdev);
+	bnxt_clear_crypto(bp);
 	bnxt_free_ctx_mem(bp, false);
 	netdev_unlock(netdev);
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
index b2a96ac725ea..72927c32bf0c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.c
@@ -8,6 +8,7 @@
 #include <linux/bnxt/hsi.h>
 
 #include "bnxt.h"
+#include "bnxt_hwrm.h"
 #include "bnxt_crypto.h"
 
 static u32 bnxt_get_max_crypto_key_ctx(struct bnxt *bp, int key_type)
@@ -55,6 +56,10 @@ void bnxt_alloc_crypto_info(struct bnxt *bp,
 		for (i = 0; i < BNXT_MAX_CRYPTO_KEY_TYPE; i++) {
 			kctx = &crypto->kctx[i];
 			kctx->type = i;
+			INIT_LIST_HEAD(&kctx->list);
+			spin_lock_init(&kctx->lock);
+			atomic_set(&kctx->alloc_pending, 0);
+			init_waitqueue_head(&kctx->alloc_pending_wq);
 		}
 		bp->crypto_info = crypto;
 	}
@@ -66,6 +71,43 @@ void bnxt_alloc_crypto_info(struct bnxt *bp,
 	bp->fw_cap |= BNXT_FW_CAP_KTLS;
 }
 
+/**
+ * bnxt_clear_crypto - Clear all crypto key contexts
+ * @bp: pointer to bnxt device
+ *
+ * Clears all key context allocations during shutdown or firmware reset.
+ * Frees all key info structures and bitmaps, and increments the epoch
+ * counter to invalidate any outstanding key references.
+ *
+ * Locking: the caller must have cleared BNXT_STATE_OPEN and waited for all
+ * in-flight kTLS control ops to drain.  Under these preconditions there are
+ * no concurrent readers or writers of the KID lists, so the lists can be
+ * walked without rcu_read_lock() or the kctx lock.
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
+	/* No concurrent access; see the locking note above. */
+	for (i = 0; i < BNXT_MAX_CRYPTO_KEY_TYPE; i++) {
+		kctx = &crypto->kctx[i];
+		list_for_each_entry_safe(kid, tmp, &kctx->list, list) {
+			list_del(&kid->list);
+			kfree(kid);
+		}
+		kctx->total_alloc = 0;
+		kctx->epoch = BNXT_NEXT_EPOCH(kctx->epoch);
+	}
+}
+
 /**
  * bnxt_free_crypto_info - Free crypto offload resources
  * @bp: pointer to bnxt device
@@ -77,6 +119,7 @@ void bnxt_alloc_crypto_info(struct bnxt *bp,
  */
 void bnxt_free_crypto_info(struct bnxt *bp)
 {
+	bnxt_clear_crypto(bp);
 	kfree(bp->crypto_info);
 	bp->crypto_info = NULL;
 	bp->fw_cap &= ~BNXT_FW_CAP_KTLS;
@@ -113,3 +156,245 @@ void bnxt_hwrm_reserve_pf_key_ctxs(struct bnxt *bp,
 	if (rx)
 		req->enables |= cpu_to_le32(FUNC_CFG_REQ_ENABLES_KTLS_RX_KEY_CTXS);
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
+		/* If we cannot store the IDs, they will be lost and only
+		 * reclaimed by the FW during reset/reinit.
+		 */
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
+		WRITE_ONCE(kctx->total_alloc,
+			   READ_ONCE(kctx->total_alloc) + kid->count);
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
+	if (num_alloc > num) {
+		netdev_warn(bp->dev,
+			    "FW allocated more type %d keys (%d) than requested (%d)\n",
+			    kctx->type, num_alloc, num);
+	} else if (!num_alloc) {
+		netdev_warn(bp->dev,
+			    "FW allocated 0 type %d keys\n", kctx->type);
+		rc = -ENOENT;
+		goto key_alloc_exit_wake;
+	} else {
+		num = num_alloc;
+	}
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
+/**
+ * bnxt_free_one_kctx - Free a key context for later re-use
+ * @kctx: pointer to bnxt_kctx key context structure
+ * @id: Key context ID
+ *
+ * This function is called to free a key context ID when the offload
+ * using the ID has successfully terminated or aborted.  If the offload
+ * cannot be terminated, the caller should not call this function to free
+ * the ID.  The ID will only be recycled by the FW during reset/reinit.
+ *
+ * The ID is matched by its hardware id only (epoch stripped), so the caller
+ * must ensure it is valid for the current epoch.
+ */
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
+		/* When approaching the max, multiple threads may proceed
+		 * and exceed the max.  Some may fail the serialized HWRM call
+		 * later when the max is exceeded.
+		 */
+		if ((READ_ONCE(kctx->total_alloc) + BNXT_KID_BATCH_SIZE) >
+		    kctx->max_ctx)
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
+	if (!crypto || !BNXT_SUPPORTS_KTLS(bp))
+		return 0;
+
+	crypto_resc = &hw_resc->crypto_resc;
+	BNXT_TCK(crypto).max_ctx = crypto_resc->resv_tx_key_ctxs;
+	BNXT_RCK(crypto).max_ctx = crypto_resc->resv_rx_key_ctxs;
+
+	if (!BNXT_TCK(crypto).max_ctx || !BNXT_RCK(crypto).max_ctx)
+		return -ENODEV;
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
index e090491006db..f88aa410efdd 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_crypto.h
@@ -16,11 +16,47 @@ enum bnxt_crypto_type {
 	BNXT_MAX_CRYPTO_KEY_TYPE,
 };
 
+/* Maximum keys supported by newer FW always multiples of 128 */
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
+	u16			epoch;
+	u32			total_alloc;
 	u32			max_ctx;
+	atomic_t		alloc_pending;
+#define BNXT_KCTX_ALLOC_PENDING_MAX	8
+	wait_queue_head_t	alloc_pending_wq;
 };
 
+#define BNXT_KID_HW_MASK	0x000fffff
+#define BNXT_KID_HW(kid)	((kid) & BNXT_KID_HW_MASK)
+#define BNXT_KID_EPOCH_MASK	0xfff00000
+#define BNXT_KID_EPOCH_SHIFT	20
+#define BNXT_KID_EPOCH(kid)	(((kid) & BNXT_KID_EPOCH_MASK) >>	\
+				 BNXT_KID_EPOCH_SHIFT)
+
+#define BNXT_NEXT_EPOCH(epoch)	\
+	(((epoch) + 1) & (BNXT_KID_EPOCH_MASK >> BNXT_KID_EPOCH_SHIFT))
+
+#define BNXT_SET_KID(kctx, kid)						\
+	((kid) | ((u32)(kctx)->epoch << BNXT_KID_EPOCH_SHIFT))
+
+#define BNXT_KCTX_ALLOC_OK(kctx)	\
+	(atomic_read(&((kctx)->alloc_pending)) < BNXT_KCTX_ALLOC_PENDING_MAX)
+
 struct bnxt_crypto_info {
 	u16			max_key_ctxs_alloc;
 
@@ -30,18 +66,31 @@ struct bnxt_crypto_info {
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
@@ -50,5 +99,26 @@ static inline void bnxt_hwrm_reserve_pf_key_ctxs(struct bnxt *bp,
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


