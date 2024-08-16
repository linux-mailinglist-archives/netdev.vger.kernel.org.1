Return-Path: <netdev+bounces-119319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DFA95525A
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 23:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8F4BB236C7
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 21:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9741C57B4;
	Fri, 16 Aug 2024 21:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="A5RVxM6g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E681C57A2
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 21:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723843752; cv=none; b=TkgZp3CXZF6sEumAg6wIisN72vUp1utHr2PBIM4fnuX+SKp0E9D8DuTAbLZsPgjS891V5oVODHs/JJKxJ75dmZdMaxz+O5WOcV+6jaodCcK1MiVZgZkP1+D7S5WeU8jPByEXq/Vu6P0cdQpThwEWXksqK48vInJ8sUCz3543FuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723843752; c=relaxed/simple;
	bh=1nOV9NJhiAnXZXQKEFut1HoiD2NU3klj7LgbNmzIVog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGctRfEVYot2u7MX9moeTefBXug/0VKZHsaMxuTgn7rZdHXFQOdUujdns8OId6V/fcwt8BbOMD+aoXK1UVrxZCGJwCEhG0eLLHZMMwGJAUMk/v2vk94xbxRbBk7X1Vtw1xNKs1+ghoZ2OlRTtphPEl4TnTDtGK6FUZe7QsLiQxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=A5RVxM6g; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-45007373217so30872721cf.0
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 14:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723843750; x=1724448550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjME3nwxz9HWeGOa1mL9WO34Qnb+mfms6zKQSzQjD+8=;
        b=A5RVxM6gvUD8x9XcfLHlxU8xaktEeEu+hXWVcwwhVELi7hQWeIfHKzTOZk+5IhIy4I
         hLNzfLwGQEvRwVOEugMrrtSIxK+hCZUMCwWp2IZ3HMkzjfuZ2RJ2kdX7kM8W+wxO0Eo4
         pNAyHRLKfHRPWog391qhmTfwLj7fGZjs6u3bw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723843750; x=1724448550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjME3nwxz9HWeGOa1mL9WO34Qnb+mfms6zKQSzQjD+8=;
        b=LD4CjcuDOciEEjQC0T03mrzSc/zZCdxBvLhTffMjqE4WbljdAbpw+PaOSZYt9ukKrX
         qZaSO+qp1bJ7THPN4kqwR39kBTCWq4VUUFdoIQv/FFLMkF0GXQ1NyIVKVq2sbkOYPj6Z
         rffYELD0RwVhxG5AF1TqSePuq3iPjBZ1F4UOXChyXLNZyomETxPR1X3JV3nbXXXw93/l
         kfhrs+l3BuLi1sn4blSEZjHmXRkGfYkjcj+pcy3+eonS1Ap6Mh2eq6/E7gxOtfMCMA42
         Qdl8CFlDxlzFZW1uYJYrYJPrU+MMl3mcsn3BHyJp3OMpkdj/LgZxZ5ycXU1/dTGMYdcY
         BxGQ==
X-Gm-Message-State: AOJu0YwtMuAewqvsnUiYm5z8oTYgsI91z2uiYRmOWB82nwmLXsBL3Ahr
	8bMM4uwNC4wASI/ntKBAxAhgmMvlGwjBj0uzMG9eYQGh76DR0XBMPVnVff620g==
X-Google-Smtp-Source: AGHT+IGX4bWVhzhMxG90cNUb9KVlMZFP3xao8QguU6N8FMwSTkzepszpWV1KthkbNF8wOY04dYu78g==
X-Received: by 2002:a05:622a:260d:b0:451:8b27:381c with SMTP id d75a77b69052e-453751dff4emr81956431cf.14.1723843749958;
        Fri, 16 Aug 2024 14:29:09 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369fd72aasm20752221cf.9.2024.08.16.14.29.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2024 14:29:09 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/9] bnxt_en: add support for retrieving crash dump using ethtool
Date: Fri, 16 Aug 2024 14:28:25 -0700
Message-ID: <20240816212832.185379-3-michael.chan@broadcom.com>
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

Add support for retrieving crash dump using ethtool -w on the
supported interface.

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 .../ethernet/broadcom/bnxt/bnxt_coredump.c    | 83 +++++++++++++++++--
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 13 ++-
 2 files changed, 87 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
index ebbad9ccab6a..9ed915e4c618 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
@@ -372,14 +372,78 @@ static int __bnxt_get_coredump(struct bnxt *bp, void *buf, u32 *dump_len)
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
+		return -EEXIST;
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
+	bnxt_copy_crash_dump(bp, &sig, sizeof(u32));
+	if (!sig)
+		return false;
+
+	return true;
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
@@ -442,10 +506,17 @@ u32 bnxt_get_coredump_length(struct bnxt *bp, u16 dump_type)
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
index 39eed5831e3a..265956c45ff5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -4993,9 +4993,16 @@ static int bnxt_set_dump(struct net_device *dev, struct ethtool_dump *dump)
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


