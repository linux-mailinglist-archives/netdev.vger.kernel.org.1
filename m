Return-Path: <netdev+bounces-122888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB68696300F
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 20:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A491C20DC0
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 18:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B05C1AAE29;
	Wed, 28 Aug 2024 18:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SaX3kCLZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B858E194A40
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869983; cv=none; b=pIoazec9d5DfOe38x8rsLEk5isO5dLlMUyagQlD7GEGuUA6O5sNpCfWmf6pIhnNiJwOQO4okn/ptisdsgla6pF7t1+4zLGJUWKYQVPd3mzjVY23gkh5eU22hK6kd+ra7FH3emYXH+Q3jgpvK0miCgNWWD9riEYzA2KkS5rBEN44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869983; c=relaxed/simple;
	bh=p/Hh7YzexZ6Cek3mLObiHs1Y+/vZrPiBs7ASdZ3o0Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YlfKqty5wguObgitHKxoP9iMB7mg23W1+vt+uytK34iLUkMmJ5jUG9WAGZd0Hf6nnnK7dM/jb6/UHA3PkP0T/laCpk/4dsrdL881jH1RDd7NMprAfDpGmv/ugOyse3YcDIu0n+tysrrBqagP8THPG7rx6Q0NsHNbMa8eC3Xy+OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SaX3kCLZ; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6bf999ac52bso34858116d6.2
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 11:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724869980; x=1725474780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGvR6GdaT5T/PVKxJdkjtQc6O/COK+biMtyRnUMP/MY=;
        b=SaX3kCLZdAml4JUqpMaaO37pM4BoLu1W7GZLpeTlcfxRORpCMeiPq9cG2B1hd2ELIe
         sza78nfyvGFrqTZRHo5NZ0KEnkl5UzmY2x1Gx4ecKzJNTMD2rzbP5ZAZA1L6WxvS5RUV
         0OMPg3zlwawJmteD9jr4qzkzvv0a9VVyAMkoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724869980; x=1725474780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGvR6GdaT5T/PVKxJdkjtQc6O/COK+biMtyRnUMP/MY=;
        b=SNXKm3WCqdtlAsX9U466huarYBRypKVsHpQKlrTiTYsCNzR67OMnJOLok3QAThizZB
         7STsKaypQD3FXTzaueNvjz8TlMC0TXbv1I6phh90Ap5BNyoyUlhHm/J0bYahOblm+Qss
         R4QhTvaXZ9Ij4wDal/nb7qS73MaS/br/T9OCx3Wsd1TWl9apquiKpQxRWWAqCbZ7tQzY
         rw0YikJv+V8e8j+kdc249dDJWCL8el5/RNqMqiu1gzqTz21GWxUCWGxbf7zNvEHFjQ9x
         NLKGGLP1FdS+YlLcugiy+k7N4m4YGi+72FXugsetXS1Uya1IzaC4zqNlBSTkWR8BLyhg
         gGQQ==
X-Gm-Message-State: AOJu0YwpEZQ1vIvW1ENCSewfosAAqRNsj1Wn5XUPukLCx03VvXACBzVJ
	02QKhSBpz6+aFg5kCPCzs0189Y64PD1jSBSOlEd1jNfk1MHJaowimmtBzt9Jlw==
X-Google-Smtp-Source: AGHT+IEMio/2o76kUnYjQKytzHrpEj8PmyDPbOloqjY2meRcJEJgZGrj5CIlUedZQwAGZwdr/I8a4w==
X-Received: by 2002:a05:6214:5b10:b0:6bf:6bf5:699a with SMTP id 6a1803df08f44-6c33e5e806bmr5050356d6.1.1724869980548;
        Wed, 28 Aug 2024 11:33:00 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d4c36esm68126866d6.43.2024.08.28.11.32.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2024 11:33:00 -0700 (PDT)
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
Subject: [PATCH net-next v4 2/9] bnxt_en: add support for retrieving crash dump using ethtool
Date: Wed, 28 Aug 2024 11:32:28 -0700
Message-ID: <20240828183235.128948-3-michael.chan@broadcom.com>
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

Add support for retrieving crash dump using ethtool -w on the
supported interface.

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v3:
1. Use -ENOENT
2. Optimize bnxt_crash_dump_avail()
---
 .../ethernet/broadcom/bnxt/bnxt_coredump.c    | 80 +++++++++++++++++--
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 13 ++-
 2 files changed, 84 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
index ebbad9ccab6a..4e2b938ed1f7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
@@ -372,14 +372,75 @@ static int __bnxt_get_coredump(struct bnxt *bp, void *buf, u32 *dump_len)
 	return rc;
 }
 
+static u32 bnxt_copy_crash_data(struct bnxt_ring_mem_info *rmem, void *buf,
+				u32 dump_len)
+{
+	u32 data_copied = 0;
+	u32 data_len;
+	int i;
+
+	for (i = 0; i < rmem->nr_pages; i++) {
+		data_len = rmem->page_size;
+		if (data_copied + data_len > dump_len)
+			data_len = dump_len - data_copied;
+		memcpy(buf + data_copied, rmem->pg_arr[i], data_len);
+		data_copied += data_len;
+		if (data_copied >= dump_len)
+			break;
+	}
+	return data_copied;
+}
+
+static int bnxt_copy_crash_dump(struct bnxt *bp, void *buf, u32 dump_len)
+{
+	struct bnxt_ring_mem_info *rmem;
+	u32 offset = 0;
+
+	if (!bp->fw_crash_mem)
+		return -ENOENT;
+
+	rmem = &bp->fw_crash_mem->ring_mem;
+
+	if (rmem->depth > 1) {
+		int i;
+
+		for (i = 0; i < rmem->nr_pages; i++) {
+			struct bnxt_ctx_pg_info *pg_tbl;
+
+			pg_tbl = bp->fw_crash_mem->ctx_pg_tbl[i];
+			offset += bnxt_copy_crash_data(&pg_tbl->ring_mem,
+						       buf + offset,
+						       dump_len - offset);
+			if (offset >= dump_len)
+				break;
+		}
+	} else {
+		bnxt_copy_crash_data(rmem, buf, dump_len);
+	}
+
+	return 0;
+}
+
+static bool bnxt_crash_dump_avail(struct bnxt *bp)
+{
+	u32 sig = 0;
+
+	/* First 4 bytes(signature) of crash dump is always non-zero */
+	bnxt_copy_crash_dump(bp, &sig, sizeof(sig));
+	return !!sig;
+}
+
 int bnxt_get_coredump(struct bnxt *bp, u16 dump_type, void *buf, u32 *dump_len)
 {
 	if (dump_type == BNXT_DUMP_CRASH) {
+		if (bp->fw_dbg_cap & DBG_QCAPS_RESP_FLAGS_CRASHDUMP_HOST_DDR)
+			return bnxt_copy_crash_dump(bp, buf, *dump_len);
 #ifdef CONFIG_TEE_BNXT_FW
-		return tee_bnxt_copy_coredump(buf, 0, *dump_len);
-#else
-		return -EOPNOTSUPP;
+		else if (bp->fw_dbg_cap & DBG_QCAPS_RESP_FLAGS_CRASHDUMP_SOC_DDR)
+			return tee_bnxt_copy_coredump(buf, 0, *dump_len);
 #endif
+		else
+			return -EOPNOTSUPP;
 	} else {
 		return __bnxt_get_coredump(bp, buf, dump_len);
 	}
@@ -442,10 +503,17 @@ u32 bnxt_get_coredump_length(struct bnxt *bp, u16 dump_type)
 {
 	u32 len = 0;
 
+	if (dump_type == BNXT_DUMP_CRASH &&
+	    bp->fw_dbg_cap & DBG_QCAPS_RESP_FLAGS_CRASHDUMP_HOST_DDR &&
+	    bp->fw_crash_mem) {
+		if (!bnxt_crash_dump_avail(bp))
+			return 0;
+
+		return bp->fw_crash_len;
+	}
+
 	if (bnxt_hwrm_get_dump_len(bp, dump_type, &len)) {
-		if (dump_type == BNXT_DUMP_CRASH)
-			len = BNXT_CRASH_DUMP_LEN;
-		else
+		if (dump_type != BNXT_DUMP_CRASH)
 			__bnxt_get_coredump(bp, NULL, &len);
 	}
 	return len;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 194f47316c77..7392a716f28d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -4989,9 +4989,16 @@ static int bnxt_set_dump(struct net_device *dev, struct ethtool_dump *dump)
 		return -EINVAL;
 	}
 
-	if (!IS_ENABLED(CONFIG_TEE_BNXT_FW) && dump->flag == BNXT_DUMP_CRASH) {
-		netdev_info(dev, "Cannot collect crash dump as TEE_BNXT_FW config option is not enabled.\n");
-		return -EOPNOTSUPP;
+	if (dump->flag == BNXT_DUMP_CRASH) {
+		if (bp->fw_dbg_cap & DBG_QCAPS_RESP_FLAGS_CRASHDUMP_SOC_DDR &&
+		    (!IS_ENABLED(CONFIG_TEE_BNXT_FW))) {
+			netdev_info(dev,
+				    "Cannot collect crash dump as TEE_BNXT_FW config option is not enabled.\n");
+			return -EOPNOTSUPP;
+		} else if (!(bp->fw_dbg_cap & DBG_QCAPS_RESP_FLAGS_CRASHDUMP_HOST_DDR)) {
+			netdev_info(dev, "Crash dump collection from host memory is not supported on this interface.\n");
+			return -EOPNOTSUPP;
+		}
 	}
 
 	bp->dump_flag = dump->flag;
-- 
2.30.1


