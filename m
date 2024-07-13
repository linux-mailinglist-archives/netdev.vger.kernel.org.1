Return-Path: <netdev+bounces-111316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6197930816
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 01:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DC401F218C2
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 23:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0772215E5D0;
	Sat, 13 Jul 2024 23:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JVPrM1DU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24457158A3D
	for <netdev@vger.kernel.org>; Sat, 13 Jul 2024 23:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720914243; cv=none; b=OzcK7MGNfL1pJWfnxKywN26isawETTPmZGifJdV/KCY8sEKk7t5cQXL7kBSxV64fCKKZrcRfJ++FzpF7wbjlhCXcJp3HyZ0g5yLPygjer5N74qFn8cuHUnhoWucqwgWK2nC3Wcn7e6JXHOZlqg4eL0++GcmdaPzzjJeMdW/dbtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720914243; c=relaxed/simple;
	bh=5LGpVoNPv2zBHysh7o7ZZGAFjmz2XZV9kk5nlfvlgCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OjyhpVgGExOvPBCylXRe3VlxlnY5iv26lgsptCJUoOHO9e3unXQoHSwsbVFUcTXEvkOPv6ThHkgmdp0/CdSKCa91+EuXfjyop4wA9u3zsXlvvRuIGpxoQj+QfwZ/K9TYMqECtE3Gi0buZXTN7l63vJcArpEvpRhjiuThEdsnO8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JVPrM1DU; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-79f0e7faafcso247883485a.3
        for <netdev@vger.kernel.org>; Sat, 13 Jul 2024 16:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720914241; x=1721519041; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=tWbyFey4/Ke8Fix12qt6SfN37g8pC8iWjHgC0Z1CcYA=;
        b=JVPrM1DUgNp3jk/M4EFVx/HsZ0HuaczgARMZHU8kh9hAOWrcaxMD+So/oJ8nL0ebJX
         uraDqvUW2Y85FNmDN+YhNvcxqKQeOaHIeUCV2/rdtkNhqiFYYtO1+Jh2hnZbljraazkr
         X02yUZ3BOA4YSbSP9SKbO5SCjjQ8P42gu5vVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720914241; x=1721519041;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tWbyFey4/Ke8Fix12qt6SfN37g8pC8iWjHgC0Z1CcYA=;
        b=NdOurzJ6iGhleR9PGLFGh+cM3oSqNpzdDIIWZk1o/vN7RoA7Bn1JoN8oO6y+dk7dBr
         spDQJUXuFVZMb/WrQDIfKT3+1Lo1k4FVWPlgxk/iMEw+pkYHRlvXgPTeMmbNgj3cqrDt
         rVgpu0w/l908O+zaBfWScuQ8/28ETdTL7BlrwqKvZrOmZZCrYNBICiDB9c7D38cxnLLr
         +//MlomJ00iw/l/jfgxukL8deTFtq05DlBJeQ4ZziIA1DBO2UzfGGrHfT5Qefg5bGsY7
         aq11APQMKqC5PCMef8hJRY+TcviibsdR92OonI1PCkgiKntp7xsmqU6wOLzVZRrP4Q7M
         XH+Q==
X-Gm-Message-State: AOJu0YwHKJIQ3ZODxbh7f4jzFeA0MqGM/Xse4nBITGV5Llo6mDyYjTwz
	uqh+q2dZNC5/5o2+D5ogG7w+c0OwzjGk6bWizQaAviZAqaAH9JN9U7XWPvnBjQ==
X-Google-Smtp-Source: AGHT+IG5CxsgnSXS59LLrKItDi/ikqXtX83AUAeVCI/ayTOlLpFcTtPj5RfKXKvmrOWfSmU8YvhDOA==
X-Received: by 2002:a05:620a:468a:b0:79e:ff22:b23c with SMTP id af79cd13be357-79f199f62bamr2398925685a.9.1720914240611;
        Sat, 13 Jul 2024 16:44:00 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160bbe6f7sm78124585a.37.2024.07.13.16.43.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jul 2024 16:43:59 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net-next 1/9] bnxt_en: add support for storing crash dump into host memory
Date: Sat, 13 Jul 2024 16:43:31 -0700
Message-ID: <20240713234339.70293-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240713234339.70293-1-michael.chan@broadcom.com>
References: <20240713234339.70293-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000000c80ec061d2992f8"

--0000000000000c80ec061d2992f8
Content-Transfer-Encoding: 8bit

From: Vikas Gupta <vikas.gupta@broadcom.com>

Newer firmware supports automatic DMA of crash dump to host memory
when it crashes.  If the feature is supported, allocate the required
memory using the existing context memory infrastructure.  Communicate
the page table containing the DMA addresses to the firmware.

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 93 +++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  3 +
 .../ethernet/broadcom/bnxt/bnxt_coredump.c    | 18 +++-
 .../ethernet/broadcom/bnxt/bnxt_coredump.h    |  8 ++
 4 files changed, 117 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index bb3be33c1bbd..37da16b39f77 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -69,6 +69,7 @@
 #include "bnxt_tc.h"
 #include "bnxt_devlink.h"
 #include "bnxt_debugfs.h"
+#include "bnxt_coredump.h"
 #include "bnxt_hwmon.h"
 
 #define BNXT_TX_TIMEOUT		(5 * HZ)
@@ -8939,6 +8940,82 @@ static int bnxt_alloc_ctx_mem(struct bnxt *bp)
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
@@ -13959,6 +14036,19 @@ static int bnxt_fw_init_one_p2(struct bnxt *bp)
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
 
@@ -15237,6 +15327,7 @@ static void bnxt_remove_one(struct pci_dev *pdev)
 	bp->fw_health = NULL;
 	bnxt_cleanup_pci(bp);
 	bnxt_free_ctx_mem(bp);
+	bnxt_free_crash_dump_mem(bp);
 	kfree(bp->rss_indir_tbl);
 	bp->rss_indir_tbl = NULL;
 	bnxt_free_port_stats(bp);
@@ -15875,6 +15966,7 @@ static int bnxt_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	bp->fw_health = NULL;
 	bnxt_cleanup_pci(bp);
 	bnxt_free_ctx_mem(bp);
+	bnxt_free_crash_dump_mem(bp);
 	kfree(bp->rss_indir_tbl);
 	bp->rss_indir_tbl = NULL;
 
@@ -15928,6 +16020,7 @@ static int bnxt_suspend(struct device *device)
 	bnxt_hwrm_func_drv_unrgtr(bp);
 	pci_disable_device(bp->pdev);
 	bnxt_free_ctx_mem(bp);
+	bnxt_free_crash_dump_mem(bp);
 	rtnl_unlock();
 	return rc;
 }
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 6bbdc718c3a7..77bd36812293 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2644,6 +2644,9 @@ struct bnxt {
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


--0000000000000c80ec061d2992f8
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OnaLEot1MoQO7BIe5S9H4AcCEXXcrJJiAtMCl47ARpyHmvQFQFFTrHgUYEd9V+9bOzY7MBIGSV1N
/JfsT1sZw6HT0lJkSQefhPGpBniAob62DJP3qr11tu8CAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU31rAyTdZweIF0tJTFYwfOv2w
L4QwDQYJKoZIhvcNAQELBQADggEBACcuyaGmk0NSZ7Kio7O7WSZ0j0f9xXcBnLbJvQXFYM7JI5uS
kw5ozATEN5gfmNIe0AHzqwoYjAf3x8Dv2w7HgyrxWdpjTKQFv5jojxa3A5LVuM8mhPGZfR/L5jSk
5xc3llsKqrWI4ov4JyW79p0E99gfPA6Waixoavxvv1CZBQ4Stu7N660kTu9sJrACf20E+hdKLoiU
hd5wiQXo9B2ncm5P3jFLYLBmPltIn/uzdiYpFj+E9kS9XYDd+boBZhN1Vh0296zLQZobLfKFzClo
E6IFyTTANonrXvCRgodKS+QJEH8Syu2jSKe023aVemkuZjzvPK7o9iU7BKkPG2pzLPgxggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxeQGjDntHGb2iaQkIw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIK6POSkjsgeqnJA4mPRl3EeT5UM2xHGv
X57uRb3rF2+sMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDcx
MzIzNDQwMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAMdBx4O7Mst7ZAUKf4J6VvL2z0DYjtfvmjU9oTqgoxtsUPThst
32WsvqlNpiTtHSbyB29ue9X5U1OU3KN/k74XpPQwBDyIyPKKejKgz/ghRJ0xL4ajtEjvudzXSX5C
R6zW2hbLTqyDMaQ/WhwZgI8yQE/wDeyGUy4hRicL4YisnPZOGXU554BIHinwNVi38EmsFAQ+uOUi
PWnBzLvd7wnzwdCjqcqxyU5rkV7+3OZEpY7D3UiwHzQyzYvzQfy7gHzqRrtHKLXG9BDjzLTLIUcA
5Turgy27fB8HpJ1GZ+6p939CScnozbJMoRzxmmuf1ih68xjf+/AvmRR+irUcaKll
--0000000000000c80ec061d2992f8--

