Return-Path: <netdev+bounces-122887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8261596300E
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 20:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA3ACB2289B
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 18:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B15619F470;
	Wed, 28 Aug 2024 18:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hFTevBJx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CC21A76BC
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 18:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869982; cv=none; b=drv6AXQzJ2ElwhsRXrUEWKOcCjf5w61sDHWjA7WG/B6gsRA6xnisAtuBFxOD+NYLny8QKA56SjbgeJf2L46TlF7D59P5HlCgDlkhp5+xwXKGOJVyh+XSxwwuhsMln1Z9UHjkW4G7erFl5YiTWmEwKz3x2dgSAerffMpt1tkOL9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869982; c=relaxed/simple;
	bh=OPkHgywan4pAdjeDTTRklzZigZ/niNTose8FVg24H6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKNheVXNR5FKB5J2cZ7WfS4eVhaCUK+VWgamyeOyI9J1rv0OkR8k4iMXTVoCXjuSv4n4DBJ1UMek9W4+q1DnGDXGSCT1sRtzGl+ppBfvcygbcdNqs7f7eKyOdFnwl/7HmQWTMMLnWAJ/DM2c8t67DjREPsWIuX0B6zw8G5bszYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hFTevBJx; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6bf8a662467so34471866d6.3
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 11:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724869979; x=1725474779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htnpmBn0SVgwb0Npl2UPKffsYy++gKd/KngsYfEY4Po=;
        b=hFTevBJx1ghgh9npsGbEqS1iEg9ZGa2Qnu6dnBDD75HtAWXDTTG/WefBX7HTnrMBsN
         +jgKBSyuEBiMrSaTP3rD0jFg9TN/NZbw44kAf/Ykmw+454HtKUcS8ytFxgGrEdnY458l
         /zentukS7Wfw4OBdpFZ0styWnP0FY2/ZosMoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724869979; x=1725474779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htnpmBn0SVgwb0Npl2UPKffsYy++gKd/KngsYfEY4Po=;
        b=LyfiZ5yz5dGTujUDxQtqBwIv2Ut+XRcDC9Q2w6m5jPu/IYMKV/ZwKTkgDqJ4CCccqv
         zc7y4+V3y2PiyBgyfS/jkx1t1y3yq36TbjH0kJe4/I6bpOz7ekO3AKML1oUEQ2uAfqQm
         iunmJJiF+ZM+C5Gp7unPGc5bOuapgFh3ZbRl3SZRnZGwaWh/BPAX/XBLeG2u7UMlqtYa
         40yRbmVnScua9pk3+gMvC/O3N+Dxb2NLt+13euUa4fjMF3YhcCV1jN/2lzVC4xuSwP8T
         QUje/pDxyE/1QbFpBMCZISKFuUUI+OO7ix/s+i0uCc7GEIj7Bw4F2e+uvFSZa1a+zv2F
         nvog==
X-Gm-Message-State: AOJu0Yx6RDx74mWdvYEC6O/KrW4J1XPH2zsJH5ezN3QNg4qPssme4LOI
	Oalg45WNQU2o2XpzIkrGrGaXnXz3PE+gIsZu5v+rbDxiITZWRaRGFOA59gDSVw==
X-Google-Smtp-Source: AGHT+IH6x/4JcAXtKjmho2NzzkmKqB+DiefvSwjtQfPZ06rmZjEdQwJTLYfyBDreGHvQmfy/X03wrQ==
X-Received: by 2002:a05:6214:459d:b0:6bf:7a04:f246 with SMTP id 6a1803df08f44-6c33e622b6fmr5393496d6.13.1724869978704;
        Wed, 28 Aug 2024 11:32:58 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d4c36esm68126866d6.43.2024.08.28.11.32.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2024 11:32:58 -0700 (PDT)
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
	przemyslaw.kitszel@intel.com,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net-next v4 1/9] bnxt_en: add support for storing crash dump into host memory
Date: Wed, 28 Aug 2024 11:32:27 -0700
Message-ID: <20240828183235.128948-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240828183235.128948-1-michael.chan@broadcom.com>
References: <20240828183235.128948-1-michael.chan@broadcom.com>
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
v3:
1. Remove one-time use BNXT_SET_CRASHDUMP_PAGE_ATTR() macro
2. Optimize memory reallocation if the existing pages can support the
new memory size
3. Fix suspend/resume code paths
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 92 +++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  3 +
 .../ethernet/broadcom/bnxt/bnxt_coredump.c    | 18 +++-
 .../ethernet/broadcom/bnxt/bnxt_coredump.h    |  8 ++
 4 files changed, 116 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index b26a7e2aa132..671dc598324a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -69,6 +69,7 @@
 #include "bnxt_tc.h"
 #include "bnxt_devlink.h"
 #include "bnxt_debugfs.h"
+#include "bnxt_coredump.h"
 #include "bnxt_hwmon.h"
 
 #define BNXT_TX_TIMEOUT		(5 * HZ)
@@ -8946,6 +8947,80 @@ static int bnxt_alloc_ctx_mem(struct bnxt *bp)
 	return 0;
 }
 
+static int bnxt_hwrm_crash_dump_mem_cfg(struct bnxt *bp)
+{
+	struct hwrm_dbg_crashdump_medium_cfg_input *req;
+	u16 page_attr;
+	int rc;
+
+	if (!(bp->fw_dbg_cap & DBG_QCAPS_RESP_FLAGS_CRASHDUMP_HOST_DDR))
+		return 0;
+
+	rc = hwrm_req_init(bp, req, HWRM_DBG_CRASHDUMP_MEDIUM_CFG);
+	if (rc)
+		return rc;
+
+	if (BNXT_PAGE_SIZE == 0x2000)
+		page_attr = DBG_CRASHDUMP_MEDIUM_CFG_REQ_PG_SIZE_PG_8K;
+	else if (BNXT_PAGE_SIZE == 0x10000)
+		page_attr = DBG_CRASHDUMP_MEDIUM_CFG_REQ_PG_SIZE_PG_64K;
+	else
+		page_attr = DBG_CRASHDUMP_MEDIUM_CFG_REQ_PG_SIZE_PG_4K;
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
+	/* keep and use the existing pages */
+	if (bp->fw_crash_mem &&
+	    mem_size <= bp->fw_crash_mem->nr_pages * BNXT_PAGE_SIZE)
+		goto alloc_done;
+
+	if (bp->fw_crash_mem)
+		bnxt_free_ctx_pg_tbls(bp, bp->fw_crash_mem);
+	else
+		bp->fw_crash_mem = kzalloc(sizeof(*bp->fw_crash_mem),
+					   GFP_KERNEL);
+	if (!bp->fw_crash_mem)
+		return -ENOMEM;
+
+	rc = bnxt_alloc_ctx_pg_tbls(bp, bp->fw_crash_mem, mem_size, 1, NULL);
+	if (rc) {
+		bnxt_free_crash_dump_mem(bp);
+		return rc;
+	}
+
+alloc_done:
+	bp->fw_crash_len = mem_size;
+	return 0;
+}
+
 int bnxt_hwrm_func_resc_qcaps(struct bnxt *bp, bool all)
 {
 	struct hwrm_func_resource_qcaps_output *resp;
@@ -13986,6 +14061,19 @@ static int bnxt_fw_init_one_p2(struct bnxt *bp)
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
 
@@ -15294,6 +15382,7 @@ static void bnxt_remove_one(struct pci_dev *pdev)
 	bp->fw_health = NULL;
 	bnxt_cleanup_pci(bp);
 	bnxt_free_ctx_mem(bp);
+	bnxt_free_crash_dump_mem(bp);
 	kfree(bp->rss_indir_tbl);
 	bp->rss_indir_tbl = NULL;
 	bnxt_free_port_stats(bp);
@@ -15933,6 +16022,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bp->fw_health = NULL;
 	bnxt_cleanup_pci(bp);
 	bnxt_free_ctx_mem(bp);
+	bnxt_free_crash_dump_mem(bp);
 	kfree(bp->rss_indir_tbl);
 	bp->rss_indir_tbl = NULL;
 
@@ -16024,6 +16114,8 @@ static int bnxt_resume(struct device *device)
 		rc = -ENODEV;
 		goto resume_exit;
 	}
+	if (bp->fw_crash_mem)
+		bnxt_hwrm_crash_dump_mem_cfg(bp);
 
 	bnxt_get_wol_settings(bp);
 	if (netif_running(dev)) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 610c0fe468ad..e7dcb59c3cdd 100644
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


