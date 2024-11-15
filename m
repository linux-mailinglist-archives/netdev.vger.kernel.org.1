Return-Path: <netdev+bounces-145316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E87C69CED4D
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 16:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 781411F23F2B
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 15:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B600A1D47DC;
	Fri, 15 Nov 2024 15:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aFqYPfwO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C8E1D47CB
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731683789; cv=none; b=VwMyfK9hMVkgyETgsnXWn523yFsnpmvuWcFpMNXFcb6YriaVp3GrUZQwoACKhkyC7kGvcrREgMh8dcsYlx8az8yLzukzfSRjTBLT0+vRE3Ndtqvmgr/SEmZBzmRRRr5qb9dHcaVHxFJNDR0c8kgc1tQWxH+vHR+/LcgogpCrjzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731683789; c=relaxed/simple;
	bh=PShrxj6B2qeoyoM+rhD7OEIZAs1dmi+xmB9uCeltk/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVBP+gpxXCt7bBBlF/otRcEbiaSilHrtdi9I1cQOxdJI/FhVrXMYCJXUUYGydKaQeqhd37llWXSSUme4JRgPmlBaPu3aL+7bNlHaVT2NTuGnGvSxl8QrQhRLs2djLmdT72fFv4EugqpwikFYont0/fh4I8jpQkiAN8dPqf1+mVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=aFqYPfwO; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20ce65c8e13so9376715ad.1
        for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 07:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731683787; x=1732288587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4XPGPPXk3zX36p2ylkwCbSqhIOn2fQn6QKxGaKXDYc=;
        b=aFqYPfwOcnZBb2P6pD5+o5i3gygxgLVl2Z6jR3z0TQnFJdALgo6eE7AwihTFJSAihH
         ZR8F/xxoSimQxox4BmtS5WjBMDPH+TiEG2MEHYkwAVwzdvgDMCtDs/fG6zJfWyCiUXfT
         NyCgbPDlhFKKpV9I3awjJrb6b+qLA2KmNmlB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731683787; x=1732288587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4XPGPPXk3zX36p2ylkwCbSqhIOn2fQn6QKxGaKXDYc=;
        b=PQGbiPW1Lc2Nr22Ed401hDAN9eddQWD0/Hgg56Kvnife2gnUk7aRuRk3uL1HYdSDc8
         YxD9tPhDPKlCWF6innwDbR+HttEZ2UalqrIf0cGZrRxmAiJ62xeeBzn1NnfT1GOiuVNV
         sus6rHjY7bAkCV5t+87/wMo9cEHVZ/9SSDxoPOqL7rjcGmJMunN8XWTSX6z1CW4vY0UG
         FWxrTLNBRGVmEhdJmcZ0IcNSyhd0hCnOkuKPxjWSlyzkwVtIOkoawa2ET5MLrC/ha0ZC
         NYqMgplwyGibzLQ8YKjbwxKo+PeHU1AP+QG1ll6l5ZMC/2WqA1Awl+DI0/woT0qLEDYt
         ZMVA==
X-Gm-Message-State: AOJu0YwdGEtjDqb8F1VZ5G05hZQBesXvs+KZZr7wmkWYjD5kzHBxNFIz
	g9X6d4+hVbamNKNp8H47d5fRfgGZklKoDZBtsm4N/vuRrLhxAEolgYFDgfBndqrFyQ/Paq/O6l0
	=
X-Google-Smtp-Source: AGHT+IEAi12STSVUPDbuZPf3ovWw25uIZdSJTiEubH1+SrCGjwvZIgd7o8BkCFb5HrcgeUc0Xi36+g==
X-Received: by 2002:a17:902:f705:b0:20c:b700:6e10 with SMTP id d9443c01a7336-211d0d83b0dmr44241325ad.34.1731683787374;
        Fri, 15 Nov 2024 07:16:27 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0eca26fsm13357925ad.106.2024.11.15.07.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 07:16:26 -0800 (PST)
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
	Selvin Thyparampil Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>
Subject: [PATCH net-next v2 10/11] bnxt_en: Add a new ethtool -W dump flag
Date: Fri, 15 Nov 2024 07:14:36 -0800
Message-ID: <20241115151438.550106-11-michael.chan@broadcom.com>
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

Add a new ethtool -W dump flag (2) to include driver coredump segments.
This patch adds the host backing store context memory pages used by the
chip and FW to store various states to the coredump.  The pages for
each context memory type is dumped into a separate coredump segment.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Selvin Thyparampil Xavier <selvin.xavier@broadcom.com>
Reviewed-by: Shruti Parab <shruti.parab@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Reviewed-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 .../ethernet/broadcom/bnxt/bnxt_coredump.c    | 77 +++++++++++++++++--
 .../ethernet/broadcom/bnxt/bnxt_coredump.h    | 15 ++++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  4 +-
 4 files changed, 90 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 2d63490b9f14..231e38933984 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2662,6 +2662,7 @@ struct bnxt {
 	u16			dump_flag;
 #define BNXT_DUMP_LIVE		0
 #define BNXT_DUMP_CRASH		1
+#define BNXT_DUMP_DRIVER	2
 
 	struct bpf_prog		*xdp_prog;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
index 4dfc26cfc979..ff92443db01b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
@@ -15,6 +15,18 @@
 #include "bnxt_hwrm.h"
 #include "bnxt_coredump.h"
 
+static const u16 bnxt_bstore_to_seg_id[] = {
+	[BNXT_CTX_QP]			= BNXT_CTX_MEM_SEG_QP,
+	[BNXT_CTX_SRQ]			= BNXT_CTX_MEM_SEG_SRQ,
+	[BNXT_CTX_CQ]			= BNXT_CTX_MEM_SEG_CQ,
+	[BNXT_CTX_VNIC]			= BNXT_CTX_MEM_SEG_VNIC,
+	[BNXT_CTX_STAT]			= BNXT_CTX_MEM_SEG_STAT,
+	[BNXT_CTX_STQM]			= BNXT_CTX_MEM_SEG_STQM,
+	[BNXT_CTX_FTQM]			= BNXT_CTX_MEM_SEG_FTQM,
+	[BNXT_CTX_MRAV]			= BNXT_CTX_MEM_SEG_MRAV,
+	[BNXT_CTX_TIM]			= BNXT_CTX_MEM_SEG_TIM,
+};
+
 static int bnxt_hwrm_dbg_dma_data(struct bnxt *bp, void *msg,
 				  struct bnxt_hwrm_dbg_dma_info *info)
 {
@@ -267,7 +279,47 @@ bnxt_fill_coredump_record(struct bnxt *bp, struct bnxt_coredump_record *record,
 	record->ioctl_high_version = 0;
 }
 
-static int __bnxt_get_coredump(struct bnxt *bp, void *buf, u32 *dump_len)
+static u32 bnxt_get_ctx_coredump(struct bnxt *bp, void *buf, u32 offset,
+				 u32 *segs)
+{
+	struct bnxt_coredump_segment_hdr seg_hdr;
+	struct bnxt_ctx_mem_info *ctx = bp->ctx;
+	u32 comp_id = BNXT_DRV_COMP_ID;
+	void *data = NULL;
+	size_t len = 0;
+	u16 type;
+
+	*segs = 0;
+	if (!ctx)
+		return 0;
+
+	if (buf)
+		buf += offset;
+	for (type = 0 ; type <= BNXT_CTX_TIM; type++) {
+		struct bnxt_ctx_mem_type *ctxm = &ctx->ctx_arr[type];
+		u32 seg_id = bnxt_bstore_to_seg_id[type];
+		size_t seg_len;
+
+		if (!ctxm->entry_size || !ctxm->pg_info || !seg_id)
+			continue;
+
+		if (buf)
+			data = buf + BNXT_SEG_HDR_LEN;
+		seg_len = bnxt_copy_ctx_mem(bp, ctxm, data, 0);
+		if (buf) {
+			bnxt_fill_coredump_seg_hdr(bp, &seg_hdr, NULL, seg_len,
+						   0, 0, 0, comp_id, seg_id);
+			memcpy(buf, &seg_hdr, BNXT_SEG_HDR_LEN);
+			buf += BNXT_SEG_HDR_LEN + seg_len;
+		}
+		len += BNXT_SEG_HDR_LEN + seg_len;
+		*segs += 1;
+	}
+	return len;
+}
+
+static int __bnxt_get_coredump(struct bnxt *bp, u16 dump_type, void *buf,
+			       u32 *dump_len)
 {
 	u32 ver_get_resp_len = sizeof(struct hwrm_ver_get_output);
 	u32 offset = 0, seg_hdr_len, seg_record_len, buf_len = 0;
@@ -298,6 +350,18 @@ static int __bnxt_get_coredump(struct bnxt *bp, void *buf, u32 *dump_len)
 		offset += ver_get_resp_len;
 	}
 
+	if (dump_type == BNXT_DUMP_DRIVER) {
+		u32 drv_len, segs = 0;
+
+		drv_len = bnxt_get_ctx_coredump(bp, buf, offset, &segs);
+		*dump_len += drv_len;
+		offset += drv_len;
+		if (buf)
+			coredump.total_segs += segs;
+		goto err;
+	}
+
+	seg_record_len = sizeof(*seg_record);
 	rc = bnxt_hwrm_dbg_coredump_list(bp, &coredump);
 	if (rc) {
 		netdev_err(bp->dev, "Failed to get coredump segment list\n");
@@ -442,7 +506,7 @@ int bnxt_get_coredump(struct bnxt *bp, u16 dump_type, void *buf, u32 *dump_len)
 		else
 			return -EOPNOTSUPP;
 	} else {
-		return __bnxt_get_coredump(bp, buf, dump_len);
+		return __bnxt_get_coredump(bp, dump_type, buf, dump_len);
 	}
 }
 
@@ -512,9 +576,12 @@ u32 bnxt_get_coredump_length(struct bnxt *bp, u16 dump_type)
 		return bp->fw_crash_len;
 	}
 
-	if (bnxt_hwrm_get_dump_len(bp, dump_type, &len)) {
-		if (dump_type != BNXT_DUMP_CRASH)
-			__bnxt_get_coredump(bp, NULL, &len);
+	if (dump_type != BNXT_DUMP_DRIVER) {
+		if (!bnxt_hwrm_get_dump_len(bp, dump_type, &len))
+			return len;
 	}
+	if (dump_type != BNXT_DUMP_CRASH)
+		__bnxt_get_coredump(bp, dump_type, NULL, &len);
+
 	return len;
 }
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.h
index f573e55f7e62..3a6084a51be8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.h
@@ -69,12 +69,27 @@ struct bnxt_coredump_record {
 };
 
 #define BNXT_VER_GET_COMP_ID	2
+#define BNXT_DRV_COMP_ID	0xd
+
+#define BNXT_CTX_MEM_SEG_ID_START  0x200
+
+#define BNXT_CTX_MEM_SEG_QP	(BNXT_CTX_MEM_SEG_ID_START + BNXT_CTX_QP)
+#define BNXT_CTX_MEM_SEG_SRQ	(BNXT_CTX_MEM_SEG_ID_START + BNXT_CTX_SRQ)
+#define BNXT_CTX_MEM_SEG_CQ	(BNXT_CTX_MEM_SEG_ID_START + BNXT_CTX_CQ)
+#define BNXT_CTX_MEM_SEG_VNIC	(BNXT_CTX_MEM_SEG_ID_START + BNXT_CTX_VNIC)
+#define BNXT_CTX_MEM_SEG_STAT	(BNXT_CTX_MEM_SEG_ID_START + BNXT_CTX_STAT)
+#define BNXT_CTX_MEM_SEG_STQM	(BNXT_CTX_MEM_SEG_ID_START + BNXT_CTX_STQM)
+#define BNXT_CTX_MEM_SEG_FTQM	(BNXT_CTX_MEM_SEG_ID_START + BNXT_CTX_FTQM)
+#define BNXT_CTX_MEM_SEG_MRAV	(BNXT_CTX_MEM_SEG_ID_START + BNXT_CTX_MRAV)
+#define BNXT_CTX_MEM_SEG_TIM	(BNXT_CTX_MEM_SEG_ID_START + BNXT_CTX_TIM)
 
 #define BNXT_CRASH_DUMP_LEN	(8 << 20)
 
 #define COREDUMP_LIST_BUF_LEN		2048
 #define COREDUMP_RETRIEVE_BUF_LEN	4096
 
+#define BNXT_SEG_HDR_LEN	sizeof(struct bnxt_coredump_segment_hdr)
+
 struct bnxt_coredump {
 	void		*data;
 	int		data_size;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index cfd2c65b1c90..18f57738c12a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -4984,8 +4984,8 @@ static int bnxt_set_dump(struct net_device *dev, struct ethtool_dump *dump)
 {
 	struct bnxt *bp = netdev_priv(dev);
 
-	if (dump->flag > BNXT_DUMP_CRASH) {
-		netdev_info(dev, "Supports only Live(0) and Crash(1) dumps.\n");
+	if (dump->flag > BNXT_DUMP_DRIVER) {
+		netdev_info(dev, "Supports only Live(0), Crash(1), Driver(2) dumps.\n");
 		return -EINVAL;
 	}
 
-- 
2.30.1


