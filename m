Return-Path: <netdev+bounces-145314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D7D9CED3C
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 16:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C03D71F23FBC
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 15:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B3D1D5AA0;
	Fri, 15 Nov 2024 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Z0goEERp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB621D54DA
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 15:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731683787; cv=none; b=GEHyJZpRTayf0MBczgtf8ymxr6Lo8IgsVZzD2UBoD9/BUhQm5CiyKIjNDYhhb+rPRlLes2dNuRRqi9RL32NfEzMXEsAW6IcvipCAG0Fp0q8zi5S7nNvgSU0WVbrh67abdLW/UgxBLpaXpyYqmBY0tHPS16Lu9h47NeobsQPHKEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731683787; c=relaxed/simple;
	bh=C+wXm/jTIA0BHulTgGvp18vbWf/EgY55hi1tjzKHF6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NBu0Iww5nymXG9jrJdxtXo8hmS/gCFqxZWnEYdVfykerokj4rtC5hddiSD+G1C1gkGhbqzL0pyxWTjXxenLmQKtVf14BCZC8NulKKxAsTUJqtIgdc1Da8CLN8M/qg550JyUxjlydJ3U47EHGs/n89r22cl08Rq8kdMyp05lYzdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Z0goEERp; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20c9978a221so21944615ad.1
        for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 07:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731683785; x=1732288585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUxEDEgQWvAa4mqxGSeUYG3/BlbpgYHHioR8bCS6pRM=;
        b=Z0goEERpZTK47MfHVdfT/NwLgMegS2HR0NBesqJKUJy0gNi1DShgIpJU+8vcCjNTSp
         yT00PdKrQ+s6wzY6JaxbEFREpt1kY5QnXcFeyZHCY9ksBsOb5IHk+NtNlOW94wU0sfYm
         volFHpWKf6uOx25FwBrvghvlXffJY9orxyqsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731683785; x=1732288585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jUxEDEgQWvAa4mqxGSeUYG3/BlbpgYHHioR8bCS6pRM=;
        b=DqZC2F0Fd07lLDOsvjjiV1qH4mMFN0FovRpKmYAQEobjTGNRanjdboqD/geaEqkFxc
         Nnme5B5l587ioP3noOFxNc/69WEacjSX2NVwCXZNIiK72knQt6GfGdGUlhPZ0TxCRIqD
         aq1UjNu2N0PBCnZ29OfljNT+Y70gvIg/7K0sGBsvHztNbPtyXtgw0H8W46vGYfIGW0h9
         pmDV9/ZDeb1OAMoyageg4W6iYGYGCvdWcXJKfQxGep6e/jqwyK7bZ3rRSHYOJ797rUsw
         36jMbmAKPJoK4tu/gwNF0x/cUqgXTh/ScEINF4biNRWANCYTOvIR9lEyCrCOPQpRdOY/
         jpHg==
X-Gm-Message-State: AOJu0YxE47BInh5uCL3tXIq2XKfHVXccaOX8JxAZYhkBPJAqUZTYMXyQ
	t204q5F/02f05mgkILGoInkhbMTgFbvvoMEYmJKtt8EDXdiOjB4/bgFpw8qwPA==
X-Google-Smtp-Source: AGHT+IFse3eVsYty1z78Cx0zipJih6wuzUosmISdxMz/n+ptp8UqUKtqJG/wpULcodp6h+66qf1PIg==
X-Received: by 2002:a17:902:da81:b0:20b:9e14:c138 with SMTP id d9443c01a7336-211d0d70cabmr40924735ad.23.1731683784895;
        Fri, 15 Nov 2024 07:16:24 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0eca26fsm13357925ad.106.2024.11.15.07.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:16:24 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	andrew.gospodarek@broadcom.com,
	shruti.parab@broadcom.com,
	hongguang.gao@broadcom.com,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net-next v2 08/11] bnxt_en: Add functions to copy host context memory
Date: Fri, 15 Nov 2024 07:14:34 -0800
Message-ID: <20241115151438.550106-9-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20241115151438.550106-1-michael.chan@broadcom.com>
References: <20241115151438.550106-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sreekanth Reddy <sreekanth.reddy@broadcom.com>

Host context memory is used by the newer chips to store context
information for various L2 and RoCE states and FW logs.  This
information will be useful for debugging.  This patch adds the
functions to copy all pages of a context memory type to a contiguous
buffer.  The next patches will include the context memory dump
during ethtool -w coredump.

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
Co-developed-by: Shruti Parab <shruti.parab@broadcom.com>
Signed-off-by: Shruti Parab <shruti.parab@broadcom.com>
Signed-off-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v2: Fix git tags and kernel-doc comments
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 103 ++++++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |   4 +
 2 files changed, 107 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index b0f3b431708c..5f7bdafcf05d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3493,6 +3493,35 @@ static void bnxt_init_ctx_mem(struct bnxt_ctx_mem_type *ctxm, void *p, int len)
 		*(p2 + i + offset) = init_val;
 }
 
+static size_t __bnxt_copy_ring(struct bnxt *bp, struct bnxt_ring_mem_info *rmem,
+			       void *buf, size_t offset, size_t head,
+			       size_t tail)
+{
+	int i, head_page, start_idx, source_offset;
+	size_t len, rem_len, total_len, max_bytes;
+
+	head_page = head / rmem->page_size;
+	source_offset = head % rmem->page_size;
+	total_len = (tail - head) & MAX_CTX_BYTES_MASK;
+	if (!total_len)
+		total_len = MAX_CTX_BYTES;
+	start_idx = head_page % MAX_CTX_PAGES;
+	max_bytes = (rmem->nr_pages - start_idx) * rmem->page_size -
+		    source_offset;
+	total_len = min(total_len, max_bytes);
+	rem_len = total_len;
+
+	for (i = start_idx; rem_len; i++, source_offset = 0) {
+		len = min((size_t)(rmem->page_size - source_offset), rem_len);
+		if (buf)
+			memcpy(buf + offset, rmem->pg_arr[i] + source_offset,
+			       len);
+		offset += len;
+		rem_len -= len;
+	}
+	return total_len;
+}
+
 static void bnxt_free_ring(struct bnxt *bp, struct bnxt_ring_mem_info *rmem)
 {
 	struct pci_dev *pdev = bp->pdev;
@@ -8728,6 +8757,36 @@ static int bnxt_alloc_ctx_pg_tbls(struct bnxt *bp,
 	return rc;
 }
 
+static size_t bnxt_copy_ctx_pg_tbls(struct bnxt *bp,
+				    struct bnxt_ctx_pg_info *ctx_pg,
+				    void *buf, size_t offset, size_t head,
+				    size_t tail)
+{
+	struct bnxt_ring_mem_info *rmem = &ctx_pg->ring_mem;
+	size_t nr_pages = ctx_pg->nr_pages;
+	int page_size = rmem->page_size;
+	size_t len = 0, total_len = 0;
+	u16 depth = rmem->depth;
+
+	tail %= nr_pages * page_size;
+	do {
+		if (depth > 1) {
+			int i = head / (page_size * MAX_CTX_PAGES);
+			struct bnxt_ctx_pg_info *pg_tbl;
+
+			pg_tbl = ctx_pg->ctx_pg_tbl[i];
+			rmem = &pg_tbl->ring_mem;
+		}
+		len = __bnxt_copy_ring(bp, rmem, buf, offset, head, tail);
+		head += len;
+		offset += len;
+		total_len += len;
+		if (head >= nr_pages * page_size)
+			head = 0;
+	} while (head != tail);
+	return total_len;
+}
+
 static void bnxt_free_ctx_pg_tbls(struct bnxt *bp,
 				  struct bnxt_ctx_pg_info *ctx_pg)
 {
@@ -8888,6 +8947,50 @@ static int bnxt_backing_store_cfg_v2(struct bnxt *bp, u32 ena)
 	return 0;
 }
 
+/**
+ * __bnxt_copy_ctx_mem - copy host context memory
+ * @bp: The driver context
+ * @ctxm: The pointer to the context memory type
+ * @buf: The destination buffer or NULL to just obtain the length
+ * @offset: The buffer offset to copy the data to
+ * @head: The head offset of context memory to copy from
+ * @tail: The tail offset (last byte + 1) of context memory to end the copy
+ *
+ * This function is called for debugging purposes to dump the host context
+ * used by the chip.
+ *
+ * Return: Length of memory copied
+ */
+static size_t __bnxt_copy_ctx_mem(struct bnxt *bp,
+				  struct bnxt_ctx_mem_type *ctxm, void *buf,
+				  size_t offset, size_t head, size_t tail)
+{
+	struct bnxt_ctx_pg_info *ctx_pg = ctxm->pg_info;
+	size_t len = 0, total_len = 0;
+	int i, n = 1;
+
+	if (!ctx_pg)
+		return 0;
+
+	if (ctxm->instance_bmap)
+		n = hweight32(ctxm->instance_bmap);
+	for (i = 0; i < n; i++) {
+		len = bnxt_copy_ctx_pg_tbls(bp, &ctx_pg[i], buf, offset, head,
+					    tail);
+		offset += len;
+		total_len += len;
+	}
+	return total_len;
+}
+
+size_t bnxt_copy_ctx_mem(struct bnxt *bp, struct bnxt_ctx_mem_type *ctxm,
+			 void *buf, size_t offset)
+{
+	size_t tail = ctxm->max_entries * ctxm->entry_size;
+
+	return __bnxt_copy_ctx_mem(bp, ctxm, buf, offset, 0, tail);
+}
+
 static void bnxt_free_one_ctx_mem(struct bnxt *bp,
 				  struct bnxt_ctx_mem_type *ctxm, bool force)
 {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 4ebee79fbe52..2d63490b9f14 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1849,6 +1849,8 @@ struct bnxt_vf_rep {
 
 #define MAX_CTX_PAGES	(BNXT_PAGE_SIZE / 8)
 #define MAX_CTX_TOTAL_PAGES	(MAX_CTX_PAGES * MAX_CTX_PAGES)
+#define MAX_CTX_BYTES		((size_t)MAX_CTX_TOTAL_PAGES * BNXT_PAGE_SIZE)
+#define MAX_CTX_BYTES_MASK	(MAX_CTX_BYTES - 1)
 
 struct bnxt_ctx_pg_info {
 	u32		entries;
@@ -2863,6 +2865,8 @@ int bnxt_hwrm_vnic_alloc(struct bnxt *bp, struct bnxt_vnic_info *vnic,
 int __bnxt_hwrm_get_tx_rings(struct bnxt *bp, u16 fid, int *tx_rings);
 int bnxt_nq_rings_in_use(struct bnxt *bp);
 int bnxt_hwrm_set_coal(struct bnxt *);
+size_t bnxt_copy_ctx_mem(struct bnxt *bp, struct bnxt_ctx_mem_type *ctxm,
+			 void *buf, size_t offset);
 void bnxt_free_ctx_mem(struct bnxt *bp, bool force);
 int bnxt_num_tx_to_cp(struct bnxt *bp, int tx);
 unsigned int bnxt_get_max_func_stat_ctxs(struct bnxt *bp);
-- 
2.30.1


