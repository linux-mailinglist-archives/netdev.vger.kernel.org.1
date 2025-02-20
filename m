Return-Path: <netdev+bounces-168261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B3AA3E45F
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 19:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE7FD3BEC57
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 18:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5616D2641D2;
	Thu, 20 Feb 2025 18:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="g8WdLfBS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03752641C9
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 18:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077778; cv=none; b=KBJWKsXpawrkbT+dbyZy0C5JFq1z9qqnDQbUW6jutvFfK3QEdI51raVtMG0NRpzOV0AQSyLrJf0dLQbP6faTIhHrLijZpZvRuCQi81aFKGB/vtWLSn/7l2kRTQ9fYzFYQTOXWvQ8gBnAoFih+1ooJFozb9qm6Mq6P3dRlOAbUPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077778; c=relaxed/simple;
	bh=qQmOt74s8s7ggF+1kRfXXp1O+t46qBBm4OZfmbYtmr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=HASXP0GgFoTkyKW+3l4OFJaHfebYP3Dt18EeZZ/HBN5hxb1Xp34A7ZqQwLco1HXEg07L+TmEI/WXJT8kKkzUr/C4DvTSGHJAHtwdBSdX4iUcAO82gUP0SBp5yBMxA/OyP1OIS/ciwN0pNHon4hup2QA13oReBHinYnPLFKmTOWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=g8WdLfBS; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-219f8263ae0so28600455ad.0
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 10:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740077776; x=1740682576; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=62gcd1c9eE38mVAGq05LCRcGvvb8fU0AO/xGYZf2u2I=;
        b=g8WdLfBSnGkXhRa46Gf+ocEWvUmmbxaAwBXO94k4mjRdWnGkklA70e7cTXCqco8ZNq
         LHveT4YHnR9e3wj6sbBsw8+2mQgfnqNvP8JNC8CLc8XJGw3qh+hJp2t3dQIIef6/tNHy
         SuQueltiNBy5U6Yf8YaYc6dpsi1fGWlhjdQPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740077776; x=1740682576;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=62gcd1c9eE38mVAGq05LCRcGvvb8fU0AO/xGYZf2u2I=;
        b=qn2SBb/unGjn5l8PN8cgepCLfhfccOG9TuNtP+X1cwDITXWp5thDUEzUAHOdlozwPL
         xJc1awvuvf8VlmTqJCH3av02JEkqXfswBHa5PkqsO7nM5frB04R3Zl64DXTgQ1KE7iho
         LkbIkk99r6RS4LCn+8WqVBlFQBbYKEuDsK4F5DNLRzjG6u01N7BojAc9hziNS1MFEa3/
         PN2vSRwX0G17P4RkqcWVzLpkB+0tpLsRBcaI9dcihUAF3d09H1ZiII/twBdU4CQgKyB2
         aiauH6gaK9xjYMuYd7yDMTeQiRbCNJrluDwnJ1n466OFdfbyH+J0AcY7w1NKEAFj/hkD
         Zbfg==
X-Forwarded-Encrypted: i=1; AJvYcCUWPuhgh11QiE8pnU45Omw+JwqE1q+6crPRIAKC9HfKIb5sTg1HleDPDg5pFj9Ta4djfIoo6Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIwWRdSEwJDCCw8Znkh12PG6S1e4dw1y++NoCcbJdx29QNxlUA
	N2RUgIbhh59ibu2a6tof68cVo9wcP+kG4QE8RmmFlehJXEwMVqZGzu7nehr0OQ==
X-Gm-Gg: ASbGncuA/3hJaKuikhQ0R8b9tWmkPXZWivrCrsTunB0DBM0sSjGorfQVuq8QqM+Tx5a
	x1LCT5ZWoWTsWtvAOWkPIfZ7rRcumX9KHqoI48/L7GmTeROgbtiWEKKqMKukCfVHguPfLjRpMn3
	LuTFRURHG7yaMEc+B1nyJ9dJJupB2R3xdRlN/C+dvtmbwooO6u2N/59NTIUHuzzt5DiXDGHSA//
	3fU1pWVXBfecopBm6EgPhDQHZAqLX/mRz+x3TVa3rEHTBxRypKvsvrjH734Z+F8ANCtWIwPj0pM
	6HBHyBJi2HtoUl6aJ5gSJhOXe3DEAecXcyJSAURgsIIibPbqNNNH/tuDTy0RQRYe/pR1r8c=
X-Google-Smtp-Source: AGHT+IEqTR1Tj8xQJb09Um5L3+18Y3HeubsWUM4BCPraVepPaC1Lc0gQGeDiUUcGWKdFr4E2tzR1LQ==
X-Received: by 2002:a05:6a21:6b0f:b0:1ee:e24d:8fd2 with SMTP id adf61e73a8af0-1eef3cbdfbdmr519522637.25.1740077776052;
        Thu, 20 Feb 2025 10:56:16 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-addee79a984sm9572262a12.32.2025.02.20.10.56.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Feb 2025 10:56:15 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	abeni@redhat.com,
	horms@kernel.org,
	michael.chan@broadcom.com,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next 7/9] RDMA/bnxt_re: Dump the debug information in snapdump
Date: Thu, 20 Feb 2025 10:34:54 -0800
Message-Id: <1740076496-14227-8-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1740076496-14227-1-git-send-email-selvin.xavier@broadcom.com>
References: <1740076496-14227-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

From: Saravanan Vajravel <saravanan.vajravel@broadcom.com>

Dump the cached debug information when the L2 driver
invokes the get_dump_data hook.

Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 109 +++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 76dd0fa..afde0ef 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -508,6 +508,106 @@ static void bnxt_re_dump_ctx(struct bnxt_re_dev *rdev, u32 seg_id, void *buf,
 {
 }
 
+/*
+ * bnxt_re_snapdump_qp - Log QP dump to the coredump buffer
+ * @rdev	-	Pointer to RoCE device instance
+ * @buf		-	Pointer to dump buffer
+ * @buf_len	-	Buffer length
+ *
+ * This function will invoke ULP logger to capture snapshot of
+ * SQ/RQ/SCQ/RCQ of a QP in ASCII format.
+ *
+ * Returns: Buffer length
+ */
+static u32 bnxt_re_snapdump_qp(struct bnxt_re_dev *rdev, void *buf, u32 buf_len)
+{
+	u32 index, len = 0, count = 0;
+	struct qdump_qpinfo *qpinfo;
+	struct qdump_array *qdump;
+
+	if (!rdev->qdump_head.qdump)
+		return 0;
+
+	mutex_lock(&rdev->qdump_head.lock);
+	index = rdev->qdump_head.index;
+	while (count < rdev->qdump_head.max_elements) {
+		count++;
+		index = (!index) ? (rdev->qdump_head.max_elements - 1) : (index - 1);
+		qdump = &rdev->qdump_head.qdump[index];
+		if (!qdump->valid || qdump->is_mr)
+			continue;
+
+		qpinfo = &qdump->qpinfo;
+		len += snprintf(buf + len, buf_len - len,
+				"qp_handle 0x%.8x 0x%.8x (xid %d) dest_qp %d type %s state %s ",
+				(u32)(qpinfo->qp_handle >> 32),
+				(u32)(qpinfo->qp_handle & 0xFFFFFFFF),
+				qpinfo->id, qpinfo->dest_qpid,
+				__to_qp_type_str(qpinfo->type),
+				__to_qp_state_str(qpinfo->state));
+		len += snprintf(buf + len, buf_len - len,
+				"is_usr %d scq_handle 0x%llx rcq_handle 0x%llx",
+				qpinfo->is_user, qpinfo->scq_handle, qpinfo->rcq_handle);
+		len += snprintf(buf + len, buf_len - len,
+				"scq_id %d rcq_id %d\n",
+				qpinfo->scq_id, qpinfo->rcq_id);
+		if (len >= buf_len)
+			goto dump_full;
+
+		if (len >= buf_len)
+			goto dump_full;
+	}
+	mutex_unlock(&rdev->qdump_head.lock);
+	return len;
+
+dump_full:
+	mutex_unlock(&rdev->qdump_head.lock);
+	return buf_len;
+}
+
+/*
+ * bnxt_re_snapdump_mr - Log PBL of MR to the coredump buffer
+ * @rdev	-	Pointer to RoCE device instance
+ * @buf		-	Pointer to dump buffer
+ * @buf_len	-	Buffer length
+ *
+ * This function will invoke ULP logger to capture PBL list of
+ * Memory Region in ASCII format.
+ *
+ * Returns: Buffer length
+ */
+static u32 bnxt_re_snapdump_mr(struct bnxt_re_dev *rdev, void *buf, u32 buf_len)
+{
+	u32 index, count = 0, len = 0;
+	struct qdump_array *qdump;
+
+	if (!rdev->qdump_head.qdump)
+		return 0;
+
+	mutex_lock(&rdev->qdump_head.lock);
+	index = rdev->qdump_head.index;
+	while (count < rdev->qdump_head.max_elements) {
+		count++;
+		index = (!index) ? (rdev->qdump_head.max_elements - 1) : (index - 1);
+		qdump = &rdev->qdump_head.qdump[index];
+		if (!qdump->valid || !qdump->is_mr)
+			continue;
+
+		len += snprintf(buf + len, buf_len - len,
+				"**MemoryRegion: type %d lkey 0x%x rkey 0x%x tot_sz %llu **\n",
+				qdump->mrinfo.type, qdump->mrinfo.lkey,
+				qdump->mrinfo.rkey, qdump->mrinfo.total_size);
+		if (len >= buf_len)
+			goto dump_full;
+	}
+	mutex_unlock(&rdev->qdump_head.lock);
+	return len;
+
+dump_full:
+	mutex_unlock(&rdev->qdump_head.lock);
+	return buf_len;
+}
+
 /* bnxt_re_snapdump - Collect RoCE debug data for coredump.
  * @rdev	-   rdma device instance
  * @buf		-	Pointer to dump buffer
@@ -520,6 +620,15 @@ static void bnxt_re_dump_ctx(struct bnxt_re_dev *rdev, u32 seg_id, void *buf,
  */
 static void bnxt_re_snapdump(struct bnxt_re_dev *rdev, void *buf, u32 buf_len)
 {
+	u32 len = 0;
+
+	len += bnxt_re_snapdump_qp(rdev, buf + len, buf_len - len);
+	if (len >= buf_len)
+		return;
+
+	len += bnxt_re_snapdump_mr(rdev, buf + len, buf_len - len);
+	if (len >= buf_len)
+		return;
 }
 
 #define BNXT_RE_TRACE_DUMP_SIZE	0x2000000
-- 
2.5.5


