Return-Path: <netdev+bounces-186593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E297AA9FD5D
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 01:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48A4A5A7415
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 23:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10390215048;
	Mon, 28 Apr 2025 22:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QgLP22k6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B117211A3F
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 22:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745881191; cv=none; b=Xy1xSYGraWZLL01hyqtAulUx0BzXMyUu1f/ZrLrowM9lM0dvy5Gky8LPRd2/POXcsU32ae4ph9TTansMvfyv1KYtIrBIg0lKfTQWjVdxJAicWt0KaV9j+e6LtNs9qVpj9VcnQnPBFzfhD+ysWoUCmz4TF3ZBfNxMKePDG/bX1os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745881191; c=relaxed/simple;
	bh=AuSDm0MqSeiB3jQUJxHmr67YuAOBAd5Nde2JJs8q6so=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xs8YibcTFr4gyBQgPdTHx6cFSTV/+xkBbkmGrE+/BJ9TWlxPHuG1qaPyT7g1Z/GFGKGG8GdLKH+oLzfypcZJlrfqByiTzK0CImWXg5168eIVlSddDC/+Xg0lK1ysX/HKC7aVRG33hfBA8yvpCdrHdyMrB/B1gK3iY13Hc2PC8ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QgLP22k6; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-736bfa487c3so4465979b3a.1
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 15:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745881188; x=1746485988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRyYBEXHccrCpYj7o5BW6EwRSwb+5ZAPMVQWlqirwHg=;
        b=QgLP22k67mNDK2ivyrU9wpMqGSdcNn9CuVIwLziIZXTUVfNlNRwVLr6ypsTqv0BOcX
         pHZGWYXLeiVIbQH50ltADbyFu9245uRIYHGK3u5oOa5tr6XZmVgFzC5SFl7TfQfKv7D9
         KzDOQJhwDMG3MgQInxM6uvxIVd1maTxVZREzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745881188; x=1746485988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRyYBEXHccrCpYj7o5BW6EwRSwb+5ZAPMVQWlqirwHg=;
        b=xUYh9qr+GAY+BK5HwyRmGEAnlVAnYC1MazDokvZ88tHeaK2s5A6jtQ9mCyYMq/tG+D
         Y8H7Ksx9GU9SLhLU64SgHVk2qTZeyLJ6UIgBTzT3XClkxwrFTxOk4KKdV5K6bv3ALTfV
         eC1xBMbd/I3KeoLL2sS1/YpyhIujrVR+IhNL3+Zr46CKiG87uIAvglazVbkgkmXXJhLZ
         zDBw/zajL1CWdmtunMsxeopXqnenLpRSBsHmDGi3kS01CvWQDfAUVHTBTy6xtI5Kutal
         R9eKaGn8JZBAQBYzapFokK2jtRLZWNeroe2ilrBZ5S+ecsuNATGCdkZRWZqgt5tfVcnQ
         HTAQ==
X-Gm-Message-State: AOJu0Ywsj9r6nSYB1oIDczO2/+a6Ty2mc3daK309jH7NGHJSWongotab
	Ezl2U5DgUtzjVQPAiiBz36iqHyKTwdkzWULbFsiBCz3LQeR1Cd4ip9X9HO1Svg==
X-Gm-Gg: ASbGnctebw0zfTb0R+XVgDEXBd+fdndQ3AfrYuzUN8MoksuFQ4Ms+/K3eiF9RYU80XQ
	RFDalb9kMyNMxJJtk7GbuBUe8ZWXrWpXvixzoTuDBBIhn0h99hJKvmgcuwvkcE0iUATPS0/m8pf
	10m+fA17oMJYxnYsTsox09/BM8tUKHn8A+2t3ti4Cq5kKze/laZFsG48indb43Kt+kezh7qOtN8
	UtDPF3e/lHg1YXf2TzoJLIb1Fac/T8IAtX6nJlGRUsFprdbaHs9zUKW6V0NF4YrIaFpJDothR7J
	DMUeJrNlyv9zPW4DE9EqmTym1jYI96HNQHhQNT82PXA3GIlAsX6szyJ9kNXyc+G6hrTISLAK6YE
	ALBX8y5C299rrlh/k
X-Google-Smtp-Source: AGHT+IGmbkopQOetZ303o3pqmAqV67WUEeaj7AidAClHb9BX7xzRQ6LqWvbTltE21gDErxzU5ULrVg==
X-Received: by 2002:a05:6a00:21c4:b0:736:54c9:df2c with SMTP id d2e1a72fcca58-73ff736a239mr13308708b3a.15.1745881188579;
        Mon, 28 Apr 2025 15:59:48 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25aca4e8sm8534344b3a.162.2025.04.28.15.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 15:59:48 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Shruti Parab <shruti.parab@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net 8/8] bnxt_en: Fix ethtool -d byte order for 32-bit values
Date: Mon, 28 Apr 2025 15:59:03 -0700
Message-ID: <20250428225903.1867675-9-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250428225903.1867675-1-michael.chan@broadcom.com>
References: <20250428225903.1867675-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For version 1 register dump that includes the PCIe stats, the existing
code incorrectly assumes that all PCIe stats are 64-bit values.  Fix it
by using an array containing the starting and ending index of the 32-bit
values.  The loop in bnxt_get_regs() will use the array to do proper
endian swap for the 32-bit values.

Fixes: b5d600b027eb ("bnxt_en: Add support for 'ethtool -d'")
Reviewed-by: Shruti Parab <shruti.parab@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 38 ++++++++++++++++---
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 7be37976f3e4..f5d490bf997e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -2062,6 +2062,17 @@ static int bnxt_get_regs_len(struct net_device *dev)
 	return reg_len;
 }
 
+#define BNXT_PCIE_32B_ENTRY(start, end)			\
+	 { offsetof(struct pcie_ctx_hw_stats, start),	\
+	   offsetof(struct pcie_ctx_hw_stats, end) }
+
+static const struct {
+	u16 start;
+	u16 end;
+} bnxt_pcie_32b_entries[] = {
+	BNXT_PCIE_32B_ENTRY(pcie_ltssm_histogram[0], pcie_ltssm_histogram[3]),
+};
+
 static void bnxt_get_regs(struct net_device *dev, struct ethtool_regs *regs,
 			  void *_p)
 {
@@ -2094,12 +2105,27 @@ static void bnxt_get_regs(struct net_device *dev, struct ethtool_regs *regs,
 	req->pcie_stat_host_addr = cpu_to_le64(hw_pcie_stats_addr);
 	rc = hwrm_req_send(bp, req);
 	if (!rc) {
-		__le64 *src = (__le64 *)hw_pcie_stats;
-		u64 *dst = (u64 *)(_p + BNXT_PXP_REG_LEN);
-		int i;
-
-		for (i = 0; i < sizeof(*hw_pcie_stats) / sizeof(__le64); i++)
-			dst[i] = le64_to_cpu(src[i]);
+		u8 *dst = (u8 *)(_p + BNXT_PXP_REG_LEN);
+		u8 *src = (u8 *)hw_pcie_stats;
+		int i, j;
+
+		for (i = 0, j = 0; i < sizeof(*hw_pcie_stats); ) {
+			if (i >= bnxt_pcie_32b_entries[j].start &&
+			    i <= bnxt_pcie_32b_entries[j].end) {
+				u32 *dst32 = (u32 *)(dst + i);
+
+				*dst32 = le32_to_cpu(*(__le32 *)(src + i));
+				i += 4;
+				if (i > bnxt_pcie_32b_entries[j].end &&
+				    j < ARRAY_SIZE(bnxt_pcie_32b_entries) - 1)
+					j++;
+			} else {
+				u64 *dst64 = (u64 *)(dst + i);
+
+				*dst64 = le64_to_cpu(*(__le64 *)(src + i));
+				i += 8;
+			}
+		}
 	}
 	hwrm_req_drop(bp, req);
 }
-- 
2.30.1


