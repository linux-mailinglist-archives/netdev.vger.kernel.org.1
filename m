Return-Path: <netdev+bounces-216809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A40B3546C
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 08:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0EF3BB35C
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 06:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62362F9C2C;
	Tue, 26 Aug 2025 06:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cxqfT2Uv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f227.google.com (mail-yb1-f227.google.com [209.85.219.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3482F999A
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 06:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189268; cv=none; b=ToOHCG8Re0xA9l5vZDu42A4kCksKCRfAUgXFzB5iC2aAqQZ2ZoVvVO70JjdA8U3gfJJcwpCKfBEe1yQOrg4qpVZVuPFdYUPFUzYLb5fwMjDUBKoNT5tflqSZKHWejTfVDojdF3acRWdYJkzuLFVNQ8ggVTYfjw5fQIq9gdUOcQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189268; c=relaxed/simple;
	bh=ONvUs6gCM1AXz/svlHDmLstiRv7jgG5D+ybE8/LNI1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HM6VUQe48gmmVxb0wyHNnPBCdF488AE/7wME8q38chh/nRrEJJhywFbuDgHBy+yT2YL2Y0TkwLZjyqq/qPIH2Qc4dwIWHCcQjJzyG2/yXBk7bGPpfN/r/cyDNT7hQARRMZndXE7rGGNG0Q8cjXAFEW1V5Ol4zval6lPvuQKmXu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cxqfT2Uv; arc=none smtp.client-ip=209.85.219.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f227.google.com with SMTP id 3f1490d57ef6-e96e45e47daso37489276.3
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 23:21:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756189266; x=1756794066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uDT5ArH2GSLOx05FVKYh091ceB024UhDnWB5JU+LHP4=;
        b=fya96Bmat+4d3e9ovSPFf1a81ZHqQvHMmX1VzCi/UsjIcdfb7YaIcLne3GVBfq1LSi
         S+3vIyBWmp/v01QS0+H8Tg5jdlNOCBJ6roetC5tpNsrkevsIGEipfhsxcamGwS2r9X3V
         SvZn6o/rSWwygtO2qyX3FmOTiW1KhtspShck3gP2a2XsPEJdmoMafFE4jLJ8phUPUU6l
         /tlf1El6G+XZmrg4UWBiosBC+SlehT3Y4+ghKmVi9OOgIe0xuLuHaVSG1jBMreQa5Y/S
         uUjeK/ueDN/lRz61zNKwh8DlddxeEmXgbyPCE9KPbAp80I7lto8bfE2+UrerOLht0Fan
         5SOg==
X-Forwarded-Encrypted: i=1; AJvYcCWIbTF0bgyrnJ6a9ph5Jn1zEap+BFIgPRkNx+YUZzC8W7/KDEiyUoOi/Xx41PIiURyAoMm4xhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIhiUTLeLROoADyJI0NdS+b1PEeGr5LH2LLbDKaPLXhIxsBJEq
	i+Of1VhErv7e+guhLub8zeC4v5jc+tx2g1XyeXTfV1tdJ0GBoNnJZ9/3+IYZxi7V8dkNWH6Lj7a
	YTdd2mqI2t/vC9gt6Sy350br45BUnyZROUFl6wJHZmc1zMKYr62kb5gokIyZlvtvoe/pScW0MLG
	7ZZdBxY5C4q/ET3EGnzC+NCijZwhLNPfkgDhPlbUV028Ao88bkfN+ir2/Rtq7s6EjTpDDm8lvWV
	85cCvB+9lD9ZOrJCAyElkaL
X-Gm-Gg: ASbGnctnTMAn+kjN5IcuLw5OEjTBSuPYmHgx9Lyoqo3TQy3V0C/w3Y92b2BD50AOb07
	UOPXqTzkFD/IpG6oEDgKPzvCuCNPWR89GvAiUP5WQ3wLaGhkgA2AHHZs9+50dL135vDkNrrbNml
	Ldu/f1dBPFnA2FiL+Gz0bLsjk9hp3Pn0uRzwFWnMJyF1f081sjHWo0aNbVxv6Xv0MPErK7eSblR
	t6xkCcqrDfs/Ld1jIZQz0zIoL5k98wM6fF1Csq0VNFuBPbRZLSAc9dyAPNsulDEFHz/RL4qt1e/
	GU/f7htdrBPD8SP9szQy/Yl1z6Osawn0NoHYBNi2kvpBZ+yRy5RCuCZcWnLAnGKAgJOZvs9ismW
	lVYp0I3WaDiA9a0WRfWXr4PlvDBTgYZvM7E7dneM7sgFqEL+TuXg+UnflCgIbfKGq5TgJS4Ebsq
	suT9qoswXnWbAR
X-Google-Smtp-Source: AGHT+IFxVExAQEOPFhjxc7dXhknnpyszYPlTmY1B2SZCnozalLUQBQRx2ftxrYLkMK1cwASYqmweHFNlSDPX
X-Received: by 2002:a05:690c:4d88:b0:71c:414b:5227 with SMTP id 00721157ae682-71fdc2f16b1mr160361527b3.9.1756189266233;
        Mon, 25 Aug 2025 23:21:06 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-71ff16f6c06sm4768207b3.16.2025.08.25.23.21.05
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Aug 2025 23:21:06 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-24680b1905fso28144735ad.2
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 23:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756189265; x=1756794065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDT5ArH2GSLOx05FVKYh091ceB024UhDnWB5JU+LHP4=;
        b=cxqfT2Uv4y0tQWOyZHcPgZFPL7vF71+03KDRR2k7rH28acMt7dYUY+ihJJf894W4bw
         ZgZECirxYYQMy+i7iCuTop5it8LMg9sZgdCXRme0rQa28ykZmxU0AH8Oq+g8mYwao8Ob
         +Q1wfdt7rbija2InhcUCSRyAvmpnAwv9eVuMc=
X-Forwarded-Encrypted: i=1; AJvYcCVWkHP/zrFnqWVWPellH3FEP778VnVQEh1ei5PDkoZ1aVaa5gUzY4TRgTI4Xxo9MEGQSZM0rBI=@vger.kernel.org
X-Received: by 2002:a17:903:234c:b0:246:1c5c:775 with SMTP id d9443c01a7336-2462eddce8dmr173542925ad.1.1756189264999;
        Mon, 25 Aug 2025 23:21:04 -0700 (PDT)
X-Received: by 2002:a17:903:234c:b0:246:1c5c:775 with SMTP id d9443c01a7336-2462eddce8dmr173542685ad.1.1756189264611;
        Mon, 25 Aug 2025 23:21:04 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4c04c7522fsm4392543a12.5.2025.08.25.23.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:21:04 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	michael.chan@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Subject: [PATCH V2 rdma-next 10/10] RDMA/bnxt_re: Remove unnecessary condition checks
Date: Tue, 26 Aug 2025 11:55:22 +0530
Message-ID: <20250826062522.1036432-11-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250826062522.1036432-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250826062522.1036432-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The check for "rdev" and "en_dev" pointer validity always
return false.

Remove them.

Reviewed-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 3e1161721738..583199e90bdd 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -916,20 +916,12 @@ static void bnxt_re_deinitialize_dbr_pacing(struct bnxt_re_dev *rdev)
 static int bnxt_re_net_ring_free(struct bnxt_re_dev *rdev,
 				 u16 fw_ring_id, int type)
 {
-	struct bnxt_en_dev *en_dev;
+	struct bnxt_en_dev *en_dev = rdev->en_dev;
 	struct hwrm_ring_free_input req = {};
 	struct hwrm_ring_free_output resp;
 	struct bnxt_fw_msg fw_msg = {};
 	int rc = -EINVAL;
 
-	if (!rdev)
-		return rc;
-
-	en_dev = rdev->en_dev;
-
-	if (!en_dev)
-		return rc;
-
 	if (test_bit(BNXT_RE_FLAG_ERR_DEVICE_DETACHED, &rdev->flags))
 		return 0;
 
@@ -955,9 +947,6 @@ static int bnxt_re_net_ring_alloc(struct bnxt_re_dev *rdev,
 	struct bnxt_fw_msg fw_msg = {};
 	int rc = -EINVAL;
 
-	if (!en_dev)
-		return rc;
-
 	bnxt_re_init_hwrm_hdr((void *)&req, HWRM_RING_ALLOC);
 	req.enables = 0;
 	req.page_tbl_addr =  cpu_to_le64(ring_attr->dma_arr[0]);
@@ -990,9 +979,6 @@ static int bnxt_re_net_stats_ctx_free(struct bnxt_re_dev *rdev,
 	struct bnxt_fw_msg fw_msg = {};
 	int rc = -EINVAL;
 
-	if (!en_dev)
-		return rc;
-
 	if (test_bit(BNXT_RE_FLAG_ERR_DEVICE_DETACHED, &rdev->flags))
 		return 0;
 
@@ -1020,9 +1006,6 @@ static int bnxt_re_net_stats_ctx_alloc(struct bnxt_re_dev *rdev,
 
 	stats->fw_id = INVALID_STATS_CTX_ID;
 
-	if (!en_dev)
-		return rc;
-
 	bnxt_re_init_hwrm_hdr((void *)&req, HWRM_STAT_CTX_ALLOC);
 	req.update_period_ms = cpu_to_le32(1000);
 	req.stats_dma_addr = cpu_to_le64(stats->dma_map);
-- 
2.43.5


