Return-Path: <netdev+bounces-121490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A3A95D649
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 21:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3EC1C21209
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 19:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A2C192B94;
	Fri, 23 Aug 2024 19:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="E+UElyha"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573BF192B89
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 19:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443069; cv=none; b=Cm7Jv3UbAJdHwd8rMcD2ucYmY7QYHY0CDS/CloOyejplXyGNBXDeOLlGxMX2fbOv9KsqTKe+HQ/PsAc5cifB49uRI/+cHAIDjh9VIM0FWnn9mDHL8lAbomrvJvQHmZtteuj9j+F8vG7FnEchdexOMY8I1ppLQ0OmXnwUIdqIGbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443069; c=relaxed/simple;
	bh=p/Hh7YzexZ6Cek3mLObiHs1Y+/vZrPiBs7ASdZ3o0Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbazl8UoGjp6XGn9XkA1t3XVi6pvxBismZlw1Snif0rUT4YFrAWqVKjTZqKDGxAK86WjCzo6szh+ZWE6Q2YbToBKO3strugXxefG93iUHDeHS0anpc+ViQProiuW4A65hZOzaOkTxw4KnxMYIs+7lS6Ajjy9rUXiP+FFkzX5Khw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=E+UElyha; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7c691c8f8dcso1660561a12.1
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 12:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724443067; x=1725047867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGvR6GdaT5T/PVKxJdkjtQc6O/COK+biMtyRnUMP/MY=;
        b=E+UElyha4gKDf5su47rP4GAUY702eWBvIvE2mlC85wQtEsgj00x9zCg8pWjRW2ekJI
         1oJVYYgNBe+Jn+z148bzZf/Slsin06JDtHbH1HiTcI0+7Ynd/hgxWevshtfId9S/iJ2R
         R5CYqeBqDPWf0Kkn1fHNOy3Ps4oh8+AxjWlz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724443067; x=1725047867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGvR6GdaT5T/PVKxJdkjtQc6O/COK+biMtyRnUMP/MY=;
        b=Lvno2RDwuoA4piyPM0D3Rz1MGgGIWP0nhls4w09yKDqwYauB3x7YJMSj5Mh2gP2x0x
         RYgyWLUCbD2RLuGS5FfrV9ZrviniBs6+yGC0wfTD08FPUnTq/1pzgDmjK2/6c+Vdhhtr
         uKo5HGczV1k/CCvDppj9L/1QA3DYUZfC5ygeVjuGxMu3W4V6+E7uOHXbuVzaTi5T+JGn
         qxO6Ez6VqwC9aiNtGBO0aE2JeV35XXgARGH4rOTDbkP3N9Ypcwu6OE1HBo2ZB789SfBn
         FFQtkVDQlX6s6IJjx/NR/lhZ8Sw6LQPPXC2SpBRq9C6ZdjC5vgJ42c2Htlj3aMD5wJZr
         x5uw==
X-Gm-Message-State: AOJu0YydLyYN0P3SQt0FYWy4xzv+DLvPWvA45II9omOWGj9NisznJWNE
	Gg7pf99T3+ZkqAirUOXDFckTmNG6bDDrhkHknm2OKVjcbPN+J8Qt9MseCNYnhS6E+JABzBwYD08
	=
X-Google-Smtp-Source: AGHT+IG9l+/R9WI3vs1yRLoaXhXnL3y7IyfzXyl3dyaUHXN0pJyqLzcb37ROVGh8J6LMFcsCgwrMmw==
X-Received: by 2002:a05:6a20:d497:b0:1c4:230b:5ec7 with SMTP id adf61e73a8af0-1cc89d4cbe4mr3914323637.15.1724443067250;
        Fri, 23 Aug 2024 12:57:47 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434253dbesm3417424b3a.76.2024.08.23.12.57.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2024 12:57:46 -0700 (PDT)
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
Subject: [PATCH net-next v3 2/9] bnxt_en: add support for retrieving crash dump using ethtool
Date: Fri, 23 Aug 2024 12:56:50 -0700
Message-ID: <20240823195657.31588-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240823195657.31588-1-michael.chan@broadcom.com>
References: <20240823195657.31588-1-michael.chan@broadcom.com>
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


