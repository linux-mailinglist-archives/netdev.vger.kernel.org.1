Return-Path: <netdev+bounces-168260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A621A3E467
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 20:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85BD01627E3
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 18:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65815265CC9;
	Thu, 20 Feb 2025 18:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="A4P0ySsn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B892A2638B6
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 18:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740077774; cv=none; b=MOAg4usnKohxZqEt9+q2C1x2D7ZSwtDCPVT4AZ1npdpyg2eNqxBbLRMTnZbx5DshqNgxReinFVwtj/ogDnK738VqnUdM6PKTyd9Xk5YRUAoEhreZ74BkCvQ/whs9fwKkm1lK2bUpVqOVFts2eZzTHL7ZmHn6YV38akXpjKmu+GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740077774; c=relaxed/simple;
	bh=TmVHhw+YyfHJXm1Tk11ATr1f5Ybq7UumTRqLxFLOUkE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=jzGgz3QRqgqP83Udyb5C56r8hW3mBLcNOvAqYxren5YTqkWVroJLRp1ZnC/m8/6V6uBHWQBN+5qAFCPYDCJa+d7k7nep27t2s/BcIS6QwQ8F4+CA0Ec4ELs5JjCFqBQU5dmUcpyMwmDfQHjj/Kh0cTdB4rIzURl2hO//6sBhxPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=A4P0ySsn; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220dc3831e3so37839195ad.0
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 10:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1740077772; x=1740682572; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wbEO2ZvYX8S6gkbKt5XzFSL0VmDi/kPQc2XpzR/hKDw=;
        b=A4P0ySsnPzFxVRD6vE8EOCLWwoe7fKSSyqjuK2KBBM8fHFuJlvZvkCwkT4sLlZhhxW
         EU2ZjwDDw5SwLnwyhj3fF/AnYVUYH7b6h8NIlzUIGdQ/3h+j8vcNnFXA4+aruqTH1vyU
         LpU52g45bPbV330Je7L38TcenQp0CKnUMKZ54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740077772; x=1740682572;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wbEO2ZvYX8S6gkbKt5XzFSL0VmDi/kPQc2XpzR/hKDw=;
        b=Ac7Pj3KLEf1D+nsTO3OlzlDmdLCZIHCo7U+ozZgf4PnuVwPWQVfqud2oCwGotCizVs
         EmcQmO6RwjABEnODTRDXa9JCXY9HyHgwsYLG9M9OpHMeYx8pa9dfvTUk0VS8y2D5gyJL
         /tL5P8z96bOZDMn9777ufH+IAG1HhaJ2KXhBMBYIjfuGVdw21gBoKJevT47pfHDzcP5y
         5oLFfPXVveoQfxad2ch/UyoMeNPuetky6R+TMroNL8Yvl3jrcWYB9L1Co86cu38guzWh
         NeeduLFgBdYwe7KloaTmwrErPzawsaTUwroxLwbaJwReWcYGgDXLsy1xgBpBxVyDE90J
         nzuw==
X-Forwarded-Encrypted: i=1; AJvYcCUWD3I0BynMfDP17NwFIHZMwBbRxqzlaCaO9Z+RtQWYLTfRklScI2R5X5UpDpgfMauKu6EgSHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUIkyxjkK7bSBKg9VPdx+YmldP0UifrvGb5HOJ5Chuwg7XgT3C
	gALeeQNvYVKS+zj39nKE4oT63vPh3ydXVKXgcJANxGXz8+Kf6jV0luE7ZoR4BA==
X-Gm-Gg: ASbGnctucvQ9rN22pNbpfuBra4w+A7D2yqxnuZr8AyJtAU2kKcHLiN+UU0xj4P83IKY
	uqRi4nv4b+OT9c8FMZd+jRJtawLyUs2V2aAkxTMt7tgd+YCU5Z2RrELMfB/1CCLNmcBfZyS+mhP
	l3IYD92mo/bhqrehEGh2Dwq2OHcpaCx4J6h9waya/0KdMoiHRRnpaUgI9XI0uoYbWoUCpQx/cbk
	+5Q2EVPupPqe4faNPHeTAW1YD5TOuxQE2cgOdyGz205FVHCoBXYIN3XhzzBjnGxdKTkwfrgdGjQ
	cJEMmiyPAkylARYdOKQXRzBxJtgz8fc4m3PJBRUfGid5iBoL4kJLirF34uq3Azxi/eoMVDc=
X-Google-Smtp-Source: AGHT+IHvxObTMqiJriOaCFcBkp4iNsiG0ly710DfyEz61MF6mHwZNyTEkxPtzIfoqhMu9KW7oIb1mA==
X-Received: by 2002:a05:6a20:7f9c:b0:1ee:a410:4aa5 with SMTP id adf61e73a8af0-1eef3dd0e8bmr314966637.17.1740077771979;
        Thu, 20 Feb 2025 10:56:11 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-addee79a984sm9572262a12.32.2025.02.20.10.56.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Feb 2025 10:56:11 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	abeni@redhat.com,
	horms@kernel.org,
	michael.chan@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next 6/9] RDMA/bnxt_re: Support the dump infrastructure
Date: Thu, 20 Feb 2025 10:34:53 -0800
Message-Id: <1740076496-14227-7-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1740076496-14227-1-git-send-email-selvin.xavier@broadcom.com>
References: <1740076496-14227-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

From: Michael Chan <michael.chan@broadcom.com>

Adds the stubs for the debug dump in bnxt_re
driver.
Each segment of the dump data holds a particalar resource
type. get_dump_info returns the number of segments and the size
of each segments. Driver currently supports segments for
QP/CQ/SRQ/MR and for the generic host logs.

While taking the dump, get_dump_data will be invoked for each
of the segments and bnxt_re driver returns the data associated
with each segment.

Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 85 +++++++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 6b5a169..76dd0fa 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -497,10 +497,93 @@ static void bnxt_re_start_irq(void *handle, struct bnxt_msix_entry *ent)
 	}
 }
 
+#define BNXT_SEGMENT_ROCE	255
+#define BNXT_SEGMENT_QP_CTX	256
+#define BNXT_SEGMENT_SRQ_CTX	257
+#define BNXT_SEGMENT_CQ_CTX	258
+#define BNXT_SEGMENT_MR_CTX	270
+
+static void bnxt_re_dump_ctx(struct bnxt_re_dev *rdev, u32 seg_id, void *buf,
+			     u32 buf_len)
+{
+}
+
+/* bnxt_re_snapdump - Collect RoCE debug data for coredump.
+ * @rdev	-   rdma device instance
+ * @buf		-	Pointer to dump buffer
+ * @buf_len	-	Buffer length
+ *
+ * This function will dump RoCE debug data to the coredump.
+ *
+ * Returns: Nothing
+ *
+ */
+static void bnxt_re_snapdump(struct bnxt_re_dev *rdev, void *buf, u32 buf_len)
+{
+}
+
+#define BNXT_RE_TRACE_DUMP_SIZE	0x2000000
+
+/* bnxt_re_get_dump_info - ULP callback from L2 driver to collect dump info
+ * @handle	- en_dev information. L2 and RoCE device information
+ * @dump_flags	- ethtool dump flags
+ * @dump	- ulp structure containing all coredump segment info
+ *
+ * This function is the callback from the L2 driver to provide the list of
+ * dump segments for the ethtool coredump.
+ *
+ * Returns: Nothing
+ *
+ */
+static void bnxt_re_get_dump_info(void *handle, u32 dump_flags,
+				  struct bnxt_ulp_dump *dump)
+{
+	struct bnxt_re_en_dev_info *en_info = auxiliary_get_drvdata(handle);
+	struct bnxt_ulp_dump_tbl *tbl = dump->seg_tbl;
+	struct bnxt_re_dev *rdev = en_info->rdev;
+
+	dump->segs = 5;
+	tbl[0].seg_id = BNXT_SEGMENT_QP_CTX;
+	tbl[0].seg_len = rdev->rcfw.qp_ctxm_size * BNXT_RE_MAX_QDUMP_ENTRIES;
+	tbl[1].seg_id = BNXT_SEGMENT_CQ_CTX;
+	tbl[1].seg_len = rdev->rcfw.cq_ctxm_size * BNXT_RE_MAX_QDUMP_ENTRIES;
+	tbl[2].seg_id = BNXT_SEGMENT_MR_CTX;
+	tbl[2].seg_len = rdev->rcfw.mrw_ctxm_size * BNXT_RE_MAX_QDUMP_ENTRIES;
+	tbl[3].seg_id = BNXT_SEGMENT_SRQ_CTX;
+	tbl[3].seg_len = rdev->rcfw.srq_ctxm_size * BNXT_RE_MAX_QDUMP_ENTRIES;
+	tbl[4].seg_id = BNXT_SEGMENT_ROCE;
+	tbl[4].seg_len = BNXT_RE_TRACE_DUMP_SIZE;
+}
+
+/* bnxt_re_get_dump_data - ULP callback from L2 driver to collect dump data
+ * @handle	- en_dev information. L2 and RoCE device information
+ * @seg_id	- segment ID of the dump
+ * @buf		- dump buffer pointer
+ * @len		- length of the buffer
+ *
+ * This function is the callback from the L2 driver to fill the buffer with
+ * coredump data for each segment.
+ *
+ * Returns: Nothing
+ *
+ */
+static void bnxt_re_get_dump_data(void *handle, u32 seg_id, void *buf, u32 len)
+{
+	struct bnxt_re_en_dev_info *en_info = auxiliary_get_drvdata(handle);
+	struct bnxt_re_dev *rdev = en_info->rdev;
+
+	if (seg_id == BNXT_SEGMENT_ROCE)
+		return bnxt_re_snapdump(rdev, buf, len);
+
+	bnxt_re_dump_ctx(rdev, seg_id, buf, len);
+}
+
 static struct bnxt_ulp_ops bnxt_re_ulp_ops = {
 	.ulp_async_notifier = bnxt_re_async_notifier,
 	.ulp_irq_stop = bnxt_re_stop_irq,
-	.ulp_irq_restart = bnxt_re_start_irq
+	.ulp_irq_restart = bnxt_re_start_irq,
+	.ulp_get_dump_info = bnxt_re_get_dump_info,
+	.ulp_get_dump_data = bnxt_re_get_dump_data,
 };
 
 /* RoCE -> Net driver */
-- 
2.5.5


