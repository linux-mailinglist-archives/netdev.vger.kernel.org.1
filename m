Return-Path: <netdev+bounces-119318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E076955258
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 23:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA74B284DA9
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 21:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5879C1C57A4;
	Fri, 16 Aug 2024 21:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="g43KNSq3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6611C4635
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 21:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723843751; cv=none; b=A2PczprzZsHw1xFPsN+2h8M/fBvQi54wgJtR9J3cqsygHL8e7D84fewYE5prB7KSHYXTwUpArfkZDuzd6hd74nuueM4XNQxgpqpVkhSPcGPp0GHyVIcwuyG6DXB+9F5bj2uCGfqinmLHhOmEnEs6F7qnEP1hi8N0dibLQf33skU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723843751; c=relaxed/simple;
	bh=dMyOTtbGeU08rlqhMaCTEY1xQhvMAnu0t7IGw0HYFh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U2l5Nu1aOt7MRgcLtrGln2Nko9kWefqnZMY1AELHYFoocmqoXciHRWfSvZ1vn79GeL2B2inCRsxy6Are465vnvg44L+CgSS1HxHjrpYZkGt0pgV5SnSSGGkLelefh2mxlKbjvnUbvCGH1JIbUR64c8RpIw4N4RrnxuO6Zlyl4V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=g43KNSq3; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-44ff6f3c427so13080751cf.1
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 14:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723843748; x=1724448548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhllNDGEPMByP4+mAbI5CDmYoRy/YZP9+zxlvzqePgE=;
        b=g43KNSq3guP51YXgKfKiyfHD0gb+fPibjyUjDa6Zh5bkb0ddKafLXXTIpDHuuV0m7N
         Bqt9XhVL/wZNleNXvUBUXAUXF+zVSnkYeyXMej7mWbVDUoEf2S1Fv+qmCu8yObIsoyuJ
         rm58tgZDvZN+74hgVcpurGkv1veiuMf9FLxOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723843748; x=1724448548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MhllNDGEPMByP4+mAbI5CDmYoRy/YZP9+zxlvzqePgE=;
        b=I/lpC1dIlhQgfJgK2rG8lCpI9RawDvDjFsHQbYvzhrj77M/Lpr4TaCZW4KIgqKNKLL
         UbTiJEHmrBHLKOhCyq9A4eSetIszFut5wNNLvjRDwGQF4WClfFdc6HhN9psjHxYJfs3q
         ZAaTMt5//MFbWIrmgTOZZ/wSA1wvsQk9e5Il0kF34mm3vaZMTddSO5HZHD4I6dplrS9i
         OdewjDs4ebUvwKg+UBFw9Zi1NSQVyNDfBUFK57ywHKnjhwfXX5a6pqZ4SsNLXZeAHkO6
         jbDftp87gnOmvXaG/7Hfq9OWmIR/9COsNgvPK8o7gzgMduSxh5lKH5cZf9vIZYHQ5uI2
         7pMA==
X-Gm-Message-State: AOJu0YweXaktkLXiFmuE5az9nynfBwXG37egVRa5zuLTmaly6q41Yo95
	FspQPi5LZF8vkXGcFa9WE/Kp/kiOjsuF1LYykG3FS+wJbMafcEoJVrjWTF4JnA==
X-Google-Smtp-Source: AGHT+IEpJoYbuNb3M3gujHGgsqumo1mP7HFtRE7nILIB23hHm7or8G7TA9C2nUtuHEX5Y1V5ZLsYyg==
X-Received: by 2002:a05:622a:4015:b0:447:eb4e:7cc1 with SMTP id d75a77b69052e-453743a9f52mr47445181cf.44.1723843748249;
        Fri, 16 Aug 2024 14:29:08 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369fd72aasm20752221cf.9.2024.08.16.14.29.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2024 14:29:07 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	horms@kernel.org,
	helgaas@kernel.org,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net-next v2 1/9] bnxt_en: add support for storing crash dump into host memory
Date: Fri, 16 Aug 2024 14:28:24 -0700
Message-ID: <20240816212832.185379-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240816212832.185379-1-michael.chan@broadcom.com>
References: <20240816212832.185379-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vikas Gupta <vikas.gupta@broadcom.com>

Newer firmware supports automatic DMA of crash dump to host memory
when it crashes.  If the feature is supported, allocate the required
memory using the existing context memory infrastructure.  Communicate
the page table containing the DMA addresses to the firmware.

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 93 +++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  3 +
 .../ethernet/broadcom/bnxt/bnxt_coredump.c    | 18 +++-
 .../ethernet/broadcom/bnxt/bnxt_coredump.h    |  8 ++
 4 files changed, 117 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 75e2cfed5769..017eefd78ba4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -69,6 +69,7 @@
 #include "bnxt_tc.h"
 #include "bnxt_devlink.h"
 #include "bnxt_debugfs.h"
+#include "bnxt_coredump.h"
 #include "bnxt_hwmon.h"
 
 #define BNXT_TX_TIMEOUT		(5 * HZ)
@@ -8946,6 +8947,82 @@ static int bnxt_alloc_ctx_mem(struct bnxt *bp)
 	return 0;
 }
 
+#define BNXT_SET_CRASHDUMP_PAGE_ATTR(attr)				\
+do {									\
+	if (BNXT_PAGE_SIZE == 0x2000)					\
+		attr = DBG_CRASHDUMP_MEDIUM_CFG_REQ_PG_SIZE_PG_8K;	\
+	else if (BNXT_PAGE_SIZE == 0x10000)				\
+		attr = DBG_CRASHDUMP_MEDIUM_CFG_REQ_PG_SIZE_PG_64K;	\
+	else								\
+		attr = DBG_CRASHDUMP_MEDIUM_CFG_REQ_PG_SIZE_PG_4K;	\
+} while (0)
+
+static int bnxt_hwrm_crash_dump_mem_cfg(struct bnxt *bp)
+{
+	struct hwrm_dbg_crashdump_medium_cfg_input *req;
+	u16 page_attr = 0;
+	int rc;
+
+	if (!(bp->fw_dbg_cap & DBG_QCAPS_RESP_FLAGS_CRASHDUMP_HOST_DDR))
+		return 0;
+
+	rc = hwrm_req_init(bp, req, HWRM_DBG_CRASHDUMP_MEDIUM_CFG);
+	if (rc)
+		return rc;
+
+	BNXT_SET_CRASHDUMP_PAGE_ATTR(page_attr);
+	req->pg_size_lvl = cpu_to_le16(page_attr |
+				       bp->fw_crash_mem->ring_mem.depth);
+	req->pbl = cpu_to_le64(bp->fw_crash_mem->ring_mem.pg_tbl_map);
+	req->size = cpu_to_le32(bp->fw_crash_len);
+	req->output_dest_flags = cpu_to_le16(BNXT_DBG_CR_DUMP_MDM_CFG_DDR);
+	return hwrm_req_send(bp, req);
+}
+
+static void bnxt_free_crash_dump_mem(struct bnxt *bp)
+{
+	if (bp->fw_crash_mem) {
+		bnxt_free_ctx_pg_tbls(bp, bp->fw_crash_mem);
+		kfree(bp->fw_crash_mem);
+		bp->fw_crash_len = 0;
+		bp->fw_crash_mem = NULL;
+	}
+}
+
+static int bnxt_alloc_crash_dump_mem(struct bnxt *bp)
+{
+	u32 mem_size = 0;
+	int rc;
+
+	if (!(bp->fw_dbg_cap & DBG_QCAPS_RESP_FLAGS_CRASHDUMP_HOST_DDR))
+		return 0;
+
+	rc = bnxt_hwrm_get_dump_len(bp, BNXT_DUMP_CRASH, &mem_size);
+	if (rc)
+		return rc;
+
+	mem_size = round_up(mem_size, 4);
+
+	if (bp->fw_crash_mem && mem_size == bp->fw_crash_len)
+		return 0;
+
+	bnxt_free_crash_dump_mem(bp);
+
+	bp->fw_crash_mem = kzalloc(sizeof(*bp->fw_crash_mem), GFP_KERNEL);
+	if (!bp->fw_crash_mem)
+		return -ENOMEM;
+
+	rc = bnxt_alloc_ctx_pg_tbls(bp, bp->fw_crash_mem, mem_size, 1, NULL);
+	if (rc) {
+		bnxt_free_crash_dump_mem(bp);
+		return rc;
+	}
+
+	bp->fw_crash_len = mem_size;
+
+	return 0;
+}
+
 int bnxt_hwrm_func_resc_qcaps(struct bnxt *bp, bool all)
 {
 	struct hwrm_func_resource_qcaps_output *resp;
@@ -13986,6 +14063,19 @@ static int bnxt_fw_init_one_p2(struct bnxt *bp)
 	if (rc)
 		return -ENODEV;
 
+	rc = bnxt_alloc_crash_dump_mem(bp);
+	if (rc)
+		netdev_warn(bp->dev, "crash dump mem alloc failure rc: %d\n",
+			    rc);
+	if (!rc) {
+		rc = bnxt_hwrm_crash_dump_mem_cfg(bp);
+		if (rc) {
+			bnxt_free_crash_dump_mem(bp);
+			netdev_warn(bp->dev,
+				    "hwrm crash dump mem failure rc: %d\n", rc);
+		}
+	}
+
 	if (bnxt_fw_pre_resv_vnics(bp))
 		bp->fw_cap |= BNXT_FW_CAP_PRE_RESV_VNICS;
 
@@ -15294,6 +15384,7 @@ static void bnxt_remove_one(struct pci_dev *pdev)
 	bp->fw_health = NULL;
 	bnxt_cleanup_pci(bp);
 	bnxt_free_ctx_mem(bp);
+	bnxt_free_crash_dump_mem(bp);
 	kfree(bp->rss_indir_tbl);
 	bp->rss_indir_tbl = NULL;
 	bnxt_free_port_stats(bp);
@@ -15933,6 +16024,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bp->fw_health = NULL;
 	bnxt_cleanup_pci(bp);
 	bnxt_free_ctx_mem(bp);
+	bnxt_free_crash_dump_mem(bp);
 	kfree(bp->rss_indir_tbl);
 	bp->rss_indir_tbl = NULL;
 
@@ -15986,6 +16078,7 @@ static int bnxt_suspend(struct device *device)
 	bnxt_hwrm_func_drv_unrgtr(bp);
 	pci_disable_device(bp->pdev);
 	bnxt_free_ctx_mem(bp);
+	bnxt_free_crash_dump_mem(bp);
 	rtnl_unlock();
 	return rc;
 }
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 62e637c5be31..2fa6572b6b1d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2649,6 +2649,9 @@ struct bnxt {
 #endif
 	u32			thermal_threshold_type;
 	enum board_idx		board_idx;
+
+	struct bnxt_ctx_pg_info	*fw_crash_mem;
+	u32			fw_crash_len;
 };
 
 #define BNXT_NUM_RX_RING_STATS			8
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
index c06789882036..ebbad9ccab6a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
@@ -385,7 +385,7 @@ int bnxt_get_coredump(struct bnxt *bp, u16 dump_type, void *buf, u32 *dump_len)
 	}
 }
 
-static int bnxt_hwrm_get_dump_len(struct bnxt *bp, u16 dump_type, u32 *dump_len)
+int bnxt_hwrm_get_dump_len(struct bnxt *bp, u16 dump_type, u32 *dump_len)
 {
 	struct hwrm_dbg_qcfg_output *resp;
 	struct hwrm_dbg_qcfg_input *req;
@@ -395,7 +395,8 @@ static int bnxt_hwrm_get_dump_len(struct bnxt *bp, u16 dump_type, u32 *dump_len)
 		return -EOPNOTSUPP;
 
 	if (dump_type == BNXT_DUMP_CRASH &&
-	    !(bp->fw_dbg_cap & DBG_QCAPS_RESP_FLAGS_CRASHDUMP_SOC_DDR))
+	    !(bp->fw_dbg_cap & DBG_QCAPS_RESP_FLAGS_CRASHDUMP_SOC_DDR ||
+	     (bp->fw_dbg_cap & DBG_QCAPS_RESP_FLAGS_CRASHDUMP_HOST_DDR)))
 		return -EOPNOTSUPP;
 
 	rc = hwrm_req_init(bp, req, HWRM_DBG_QCFG);
@@ -403,8 +404,12 @@ static int bnxt_hwrm_get_dump_len(struct bnxt *bp, u16 dump_type, u32 *dump_len)
 		return rc;
 
 	req->fid = cpu_to_le16(0xffff);
-	if (dump_type == BNXT_DUMP_CRASH)
-		req->flags = cpu_to_le16(DBG_QCFG_REQ_FLAGS_CRASHDUMP_SIZE_FOR_DEST_DEST_SOC_DDR);
+	if (dump_type == BNXT_DUMP_CRASH) {
+		if (bp->fw_dbg_cap & DBG_QCAPS_RESP_FLAGS_CRASHDUMP_SOC_DDR)
+			req->flags = cpu_to_le16(BNXT_DBG_FL_CR_DUMP_SIZE_SOC);
+		else
+			req->flags = cpu_to_le16(BNXT_DBG_FL_CR_DUMP_SIZE_HOST);
+	}
 
 	resp = hwrm_req_hold(bp, req);
 	rc = hwrm_req_send(bp, req);
@@ -412,7 +417,10 @@ static int bnxt_hwrm_get_dump_len(struct bnxt *bp, u16 dump_type, u32 *dump_len)
 		goto get_dump_len_exit;
 
 	if (dump_type == BNXT_DUMP_CRASH) {
-		*dump_len = le32_to_cpu(resp->crashdump_size);
+		if (bp->fw_dbg_cap & DBG_QCAPS_RESP_FLAGS_CRASHDUMP_SOC_DDR)
+			*dump_len = BNXT_CRASH_DUMP_LEN;
+		else
+			*dump_len = le32_to_cpu(resp->crashdump_size);
 	} else {
 		/* Driver adds coredump header and "HWRM_VER_GET response"
 		 * segment additionally to coredump.
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.h
index b1a1b2fffb19..a76d5c281413 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.h
@@ -111,7 +111,15 @@ struct hwrm_dbg_cmn_output {
 	#define HWRM_DBG_CMN_FLAGS_MORE	1
 };
 
+#define BNXT_DBG_FL_CR_DUMP_SIZE_SOC	\
+	DBG_QCFG_REQ_FLAGS_CRASHDUMP_SIZE_FOR_DEST_DEST_SOC_DDR
+#define BNXT_DBG_FL_CR_DUMP_SIZE_HOST	\
+	DBG_QCFG_REQ_FLAGS_CRASHDUMP_SIZE_FOR_DEST_DEST_HOST_DDR
+#define BNXT_DBG_CR_DUMP_MDM_CFG_DDR	\
+	DBG_CRASHDUMP_MEDIUM_CFG_REQ_TYPE_DDR
+
 int bnxt_get_coredump(struct bnxt *bp, u16 dump_type, void *buf, u32 *dump_len);
+int bnxt_hwrm_get_dump_len(struct bnxt *bp, u16 dump_type, u32 *dump_len);
 u32 bnxt_get_coredump_length(struct bnxt *bp, u16 dump_type);
 
 #endif
-- 
2.30.1


