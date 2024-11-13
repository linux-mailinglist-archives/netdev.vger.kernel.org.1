Return-Path: <netdev+bounces-144321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E579C68D1
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 06:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DE02B24146
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 05:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B12316DEB2;
	Wed, 13 Nov 2024 05:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="W6n2D3Kn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1740183CAE
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 05:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731476406; cv=none; b=pqFs1Pf8TZFamFEijFHw63GtdXANoOx98iQ3dVdXOT4jt7rn0n9HZ01h9HXKCCJFddnGGEnkO8IuYW/uQVULRjyNPVq7N+t3Oi20O1d3N8XcErBPtdFLS8O6nQcWIOK0Pn2uaXahaa0I8LKVvATvB5ADlGDalspKWkbw9cwNVX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731476406; c=relaxed/simple;
	bh=/aJcOUUQ+XCQruZWVmDw6azuiIwYAwSCd55aPLh1aRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=npoeuF4mxZl7cHxrgwSl3k9b2D63MVYJGv9eUTjyoQr4QKMkgzBdFcC3Vjxni/Q7qULkXpN1m5ndZBXD4GWYBX7rLbXFEIEmINZODpxVk6233fj9CGNLh+9OG+1gaSKCyb50JVQ6XaBp5+NuROqnNRBMfqNbmjgqwdXGnDjx2Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=W6n2D3Kn; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-460ab1bc2aeso43121131cf.3
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 21:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731476404; x=1732081204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4RI0XuQ5W/mbQ4P8HCEVzj+CNo943fvZCGjie8RFAM=;
        b=W6n2D3Knqz9dC/sMYIIhtsEu79CLKah8xlVZSbFrpCqgxkoAoryqA/PTGIqaxaMz99
         13KUQovsnMpWNei4T4U6GzN5PtzQkVGVWPlgUxRTgmROZQN4wjAgrSyuyhXpZ0dFweLX
         2fuluSxjTs34l85J7jDNxkbI6dkJFS1W1am0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731476404; x=1732081204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4RI0XuQ5W/mbQ4P8HCEVzj+CNo943fvZCGjie8RFAM=;
        b=Bot8z53Gv14Z8h4z4twbQOMNt1GTo4FsPyl+ZEAh6gSOjRDLOgXn4u6ZYrlIXNYDx3
         M4XaJ4Ve7zBMFG1JF4YqnBMjiPit9WAVOhaZ9OG9LibPLcmGjx1YTlJ7WdChGhgJEp6/
         o6HQVwYVCrdljTH/CGZvwcvMoqe0HAaxt3lJUSa1iPBCkzCgWNLWGpAwl9+9cpg+nx4X
         Fx3H9WZrdwZPI+ue9WnTJxIbUZFGP9UyRHERJMMPiJELhx69aQZjwxvqTkXHp8kPmu1L
         vZvtg73pBvaJO/OEv91lv3WvLSN/c6UkWN7btrpcjRv+BWWxZth9EqHSdynC6HMEbJdv
         wdRA==
X-Gm-Message-State: AOJu0Yy1b8RL7McyZq+UpvThXPRjMYkTifQfqW+FhhIpOfV3gA4kN2Fp
	cc8wyiq/ey6Nh6WPF9cVg1Nhr+4e0qE7EKchdndfOVxd4TgNtW7fWROOkAMsDQ==
X-Google-Smtp-Source: AGHT+IG4YS0tF0gCr/wjK1yzVNjJmxQVgSAGXWjd1veqcuuuK7bKlfKUBN73IL+XC/8dcHXb+f0QaQ==
X-Received: by 2002:a05:622a:15ca:b0:45e:f2df:2ed3 with SMTP id d75a77b69052e-46309354ba9mr255852711cf.32.1731476403772;
        Tue, 12 Nov 2024 21:40:03 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff5e14f9sm83457491cf.86.2024.11.12.21.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 21:40:02 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	andrew.gospodarek@broadcom.com,
	hongguang.gao@broadcom.com,
	shruti.parab@broadcom.com,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net-next 08/11] bnxt_en: Add functions to copy host context memory
Date: Tue, 12 Nov 2024 21:36:46 -0800
Message-ID: <20241113053649.405407-9-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20241113053649.405407-1-michael.chan@broadcom.com>
References: <20241113053649.405407-1-michael.chan@broadcom.com>
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
Signed-off-by: Shruti Parab <shruti.parab@broadcom.com>
Signed-off-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 101 ++++++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |   4 +
 2 files changed, 105 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c5c40981b879..921315660a05 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3505,6 +3505,35 @@ static void bnxt_init_ctx_mem(struct bnxt_ctx_mem_type *ctxm, void *p, int len)
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
@@ -8725,6 +8754,36 @@ static int bnxt_alloc_ctx_pg_tbls(struct bnxt *bp,
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
@@ -8885,6 +8944,48 @@ static int bnxt_backing_store_cfg_v2(struct bnxt *bp, u32 ena)
 	return 0;
 }
 
+/**
+ * __bnxt_copy_ctx_mem - copy host context memory
+ * @bp: The driver context
+ * @ctxm: The pointer to the context memory type
+ * @buf: The destination buffer
+ * @offset: The buffer offset to copy the data to
+ * @head: The head offset of context memory to copy from
+ * @tail: The tail offset (last byte + 1) of context memory to end the copy
+ *
+ * This function is called for debugging purposes to dump the host context
+ * used by the chip.
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
index d3697e531d67..b4cc5d77a55a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1848,6 +1848,8 @@ struct bnxt_vf_rep {
 
 #define MAX_CTX_PAGES	(BNXT_PAGE_SIZE / 8)
 #define MAX_CTX_TOTAL_PAGES	(MAX_CTX_PAGES * MAX_CTX_PAGES)
+#define MAX_CTX_BYTES		((size_t)MAX_CTX_TOTAL_PAGES * BNXT_PAGE_SIZE)
+#define MAX_CTX_BYTES_MASK	(MAX_CTX_BYTES - 1)
 
 struct bnxt_ctx_pg_info {
 	u32		entries;
@@ -2862,6 +2864,8 @@ int bnxt_hwrm_vnic_alloc(struct bnxt *bp, struct bnxt_vnic_info *vnic,
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


