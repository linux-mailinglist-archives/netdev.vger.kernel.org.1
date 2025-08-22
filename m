Return-Path: <netdev+bounces-215906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 293B6B30D36
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 06:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A30EB64528
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 04:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E85287276;
	Fri, 22 Aug 2025 04:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Xl+iEgpU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8147263C90
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 04:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755835401; cv=none; b=jkmFByDJ0QXLLwgERvSDf8TT8bPWKgOnlCxqo3hXCqdqJ2Nk28rKnZ6Gs0WeYInQLchCaqKoXTYqf4P02irDXQHJ0QdOxJFDirfa5N8XyiWk9c1XUrWPbS1NmK9/glKH/7hl6nNfPNTRE1vFbi9SM2618dvPGzh8pcTLv5agrDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755835401; c=relaxed/simple;
	bh=jvXFLpYVYHEIUc1iLOZbe4sL5yU9EXCDJbEwLbZOtJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWLSx6um8pYLaqfYvJSGtaTYZp2fEszewexE9CsNkDQbSP6ZzDhKEmB/ViBiU3IZK0diAIujuqZISn/OZOifdP45QLaGD1FFVHwUFbshSvWC/fTo6SYz8oDXa/zwDopHZSTM5GDDdTnrU1oS4j2pX2bz60SKWepG+thMPcDZD7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Xl+iEgpU; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-323267b7dfcso1606991a91.1
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 21:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755835397; x=1756440197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f53GRlIh8R+xAEhzUiUULZbbPM7pwilIyORgSUpiEzU=;
        b=J9Ikyl0evyhjK7r+uQaxGHJbPbtx0z96eohAPaFmf2MzumHeHewXUT8eW5GfB5wBWH
         q4dvOR8Mwd/Vae5w9NgmK3owedLvx95vIuHThKp5A8VMdAvwqIeOgY8wNgqMwD3f5OoM
         ZMk9yT5KQwWyytD1nlgVHVFyCd7xvS4+Jdiw5Ukf2bMyBrguiAGlIohpzOT0a766V2Ub
         IkOWlkitwd5wuJafttb8vmT8pHETDht0D5RrKxvG/jBZQF/INKJ64iBs/2CXViSWJ6R9
         4Kz7ghETg4KT4rwBzuVydy5veifwqVgggOFZdZ42wA66fuILF/5w5ALa8bMovjHZzDVI
         tpSw==
X-Forwarded-Encrypted: i=1; AJvYcCX4gJ5xf4lA2HbEBQ+vDFQBDg5T3hL3r7KTnOOaVLmuSavXRPePnkzBQQxY1UF3Lh9MSVs5R0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAp8UHzqWZjgS749odWXb9kMusp7ho6VJNuKdoO84K9Oa6Lnfj
	dTbOw10jH8NNI6TnYQeqXSwpjHnLEDKszXZGlGdG/7PPFya8m6GqbXYqq1Sn4ybWbLspVZI9Htx
	fvjiua2UnU+L3m5zwDXTGjuI8AIY93n4TVP26IpF0A5pMKybcYorP00rmjUt2CxA6C30hfiNzKj
	STNjGTsgHG9olykAbm3ckDffrwu5DNKJBO6icvt+05C5n/CXOYa3Tx5UtrPuGOxLWIOVzA9eHk6
	MfoHV8v8s7eLMnPfxAgEm+2
X-Gm-Gg: ASbGncuuJ+u15IZolypJU/w/RspfPqT63pJ2aW8SoWEV61Pu8Uiep6t8SNPZJEBd7UA
	EeEbe4mwAhIerhnBepe+iNO/0ujNgzPlmtw7TN/BQLwd8+Ea/Nfrw3DZ6yV8lev/28hDMG/9E2r
	8YrVNZDtGChKRR5YBv9u/8YiTXSOvQMQRGGbL5wmWMSoBiB/RC63waPmMQ5UACd2n7wVyHmkiOE
	cqZslXpbrj4/vuFniamGbnIj+ANVrZ0kdOy9GLH1NlrmSiHikc97lxbFlNMGlQjZn6ZdDMM942H
	58u2tY+8D2G/L0YW0o/groHlDYuWlX2czcG9kYx+eLQNGtFmFmpYUWGJT/3eJSrmbDyvGMkfKRa
	vtkL+rWgpMWH9jhP56NCTFLZje2VzYVP2gB5d1tHV89Rz8eJdKJ8fzVKOVzBIlwZdE7nENKGcqf
	mIhKceQ9rhPLxf
X-Google-Smtp-Source: AGHT+IEHa+61MQ6g7+CL4yBmRQze0nVhF752qc6IumkURQtRMlYZoI/lpGzdPMvnObu3VtfItD6nFlfBF0K8
X-Received: by 2002:a17:902:ebc5:b0:240:2953:4b6b with SMTP id d9443c01a7336-2462eded8f0mr23252035ad.2.1755835396881;
        Thu, 21 Aug 2025 21:03:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-245ed32ea84sm6888245ad.8.2025.08.21.21.03.16
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Aug 2025 21:03:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e55665b05so1582882b3a.2
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 21:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755835395; x=1756440195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f53GRlIh8R+xAEhzUiUULZbbPM7pwilIyORgSUpiEzU=;
        b=Xl+iEgpUKa/bzhcquYrK6c29hn8RN1c0MU19bDxxATuq9j+RIfN53+NtPXxzUDeAai
         tI7eO4LDhD9EvFvvpoMhR6CouJ3ZEl/RSUKJRH1GhaDsz/BoW3XL9///d5XIS+UKhl6Y
         IMdTsAxyJG+5LZVvTnxrz1zP+1tD2iYZ4mTCc=
X-Forwarded-Encrypted: i=1; AJvYcCWS47UnS1aXtxYFFbqg9b/k4ZQ6QEiQVwSwjMYClE/TITEYtyXJpqsi7MW2dr94d6GEEIHIXDM=@vger.kernel.org
X-Received: by 2002:a05:6a00:10c7:b0:76b:f24d:6d67 with SMTP id d2e1a72fcca58-7702fa62641mr2408570b3a.13.1755835395355;
        Thu, 21 Aug 2025 21:03:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:10c7:b0:76b:f24d:6d67 with SMTP id d2e1a72fcca58-7702fa62641mr2408534b3a.13.1755835394864;
        Thu, 21 Aug 2025 21:03:14 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d3abdsm9659814b3a.11.2025.08.21.21.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 21:03:14 -0700 (PDT)
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
Subject: [PATCH rdma-next 10/10] RDMA/bnxt_re: Remove unnecessary condition checks
Date: Fri, 22 Aug 2025 09:38:01 +0530
Message-ID: <20250822040801.776196-11-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250822040801.776196-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250822040801.776196-1-kalesh-anakkur.purayil@broadcom.com>
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
 drivers/infiniband/hw/bnxt_re/main.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 3e1161721738..43af0dba0749 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -922,14 +922,6 @@ static int bnxt_re_net_ring_free(struct bnxt_re_dev *rdev,
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


