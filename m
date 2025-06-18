Return-Path: <netdev+bounces-198956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C9EADE6D8
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1C7617D720
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 09:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF7C288520;
	Wed, 18 Jun 2025 09:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TT4kL+GZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64D0288500
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 09:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750238687; cv=none; b=usj10+YIzrqHxHoNLBVdI8yGjDDk9vZxKJcyyR4TFNgRawJZqTdDngd14319HDyDlhJloGzevg7IkkSO0COsue/hkU31iXBnB4ChAJZO8Esz8kLC4bl0623fs5noaG66RPLtTHh2R/SLGMNRrUiYM/naBNzGsQchHXVqXuCJB0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750238687; c=relaxed/simple;
	bh=3vl6QDP6/oKInQpbUd/mwtNJqKOcafNUpwPOeaBo8Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A0LfLNN0XJHyY9EDLjd1Ln6tCQ3USMz5rTE7yXN5bHWi/bd7GDOsLcGaF7FtM3PaOzXrogAu9Msu3FtQ8xO2ttNDpiu94X8wYTZo9Z12Hh1N0GGc8L5A5RcPiFcaVJ9ztZ5mo1nSVxi3oH/a2JoeG8QdLccqScY3wSI/90Zvx/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TT4kL+GZ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-748c3afd0dbso1702287b3a.0
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 02:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1750238685; x=1750843485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZ8ourLzAapYlWvSPc5AJIM32EfKtOVtF0mK8gd87tE=;
        b=TT4kL+GZLwCB5b+jAxcql3Gw26gjrQD4LeVsaI7jPhVPHjzPuziA4KNQmBeyj7MkGw
         mykUZrdCbPRX0HbeNeRvOlpcv/XnIfthxvw7h/xiDia/CPYzcwpQMJVH4LI/3lC59RwM
         d1Hwb519mPNUpvczIOefhX70+l5VnuqG36oaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750238685; x=1750843485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZ8ourLzAapYlWvSPc5AJIM32EfKtOVtF0mK8gd87tE=;
        b=Wy1Nokk6Cfy4MST4pMLgEIilsq/elVKtC509Hj7TEu96o13LOEmplufPQjqXmMJWhP
         2c05RaoLeqsz945JTZzzmLgABd6JPVSqlSOAgbm2hA4oUkBFryUdBV5MW3XLLFOBMN+J
         ontiGKO6SNUngiFw6vzLS6DZaYUx9N2MOlNuIdUhdGChzDJbMfL1CGLWF1P+CC1qNYQs
         3ip+3mVF3NRbE2ApcvqpKC7r1yMWHuVoVfW8K9K+yxGkGlmmw6wDmgmmOrUNjLvmoe9o
         EHa1/FYgqo3Y+ZXO/kIQtGQQqFROo1qWohLvKo+OJtNphb1rIq+ON2quZ1mxZ+iz9fKT
         Mj5Q==
X-Gm-Message-State: AOJu0YxqZACd0OwODRFv8c26lInOolMxDZuh+ZoacNRLaxIMCIOOyliW
	QCL2/HfyACRvlf9jO4WBvM/+X4zBFYt+seqh313ty2140a/5Ct9ECgZkztZmg8ZtcQ==
X-Gm-Gg: ASbGncsgIRw2d4bBUf0YGi9c7Uza9qKifckkTkqCH3kItwYutlqmxTX4Zj78VIVnZIN
	RBLM+ffo0DoFiBMscttxAK/79dtBrCVH/1w5klyQMEzKj4voQsM1lBJ5FIWXWiFCz/8JvRAtk0b
	A9qonVXvA7iRNooeYH4BMjnQxQpRqgVbZPrsWiM6CbVAnGNnTKU7B9vMalWvHEaVf4WrN5Fzc/0
	mukdpaUqrdXaeg8svtmF5lD7olzOM3Vg3UqNh4pe2XqjyzTNsw7Vc8quydQpBE/BGF+mrg2+tJ6
	d0P33G4IRyrzhPgLAiQfT/2lfqMj41tDCMf/ro9gU1oAkqSyYnu0Y61dh1VDZFIY+Bmiph1ofuv
	BGW9dnUgrHz226ZlsGUlOKNPDZAIVWcJ07fAFyYE=
X-Google-Smtp-Source: AGHT+IGJOA4NXBDo/o4TPk7suDzL2KF36mR4Chmt7HOCORSeWUnsk1Toh4o5Zx9SBDeZZ7JnlDcymg==
X-Received: by 2002:a05:6a00:cd2:b0:736:9e40:13b1 with SMTP id d2e1a72fcca58-7489cfdb359mr23034981b3a.23.1750238685010;
        Wed, 18 Jun 2025 02:24:45 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffecd08sm10408993b3a.27.2025.06.18.02.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 02:24:44 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>,
	Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [net-next, 05/10] bng_en: Add ring memory allocation support
Date: Wed, 18 Jun 2025 14:47:35 +0000
Message-ID: <20250618144743.843815-6-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250618144743.843815-1-vikas.gupta@broadcom.com>
References: <20250618144743.843815-1-vikas.gupta@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ring allocation/free mechanism which help
to allocate rings (TX/RX/Completion) and backing
stores memory on the host for the device.
Future patches will use these functions.

Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/Makefile   |   3 +-
 .../net/ethernet/broadcom/bnge/bnge_rmem.c    | 101 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_rmem.h    |  35 ++++++
 3 files changed, 138 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_rmem.h

diff --git a/drivers/net/ethernet/broadcom/bnge/Makefile b/drivers/net/ethernet/broadcom/bnge/Makefile
index b8dbbc2d5972..1144594fc3f6 100644
--- a/drivers/net/ethernet/broadcom/bnge/Makefile
+++ b/drivers/net/ethernet/broadcom/bnge/Makefile
@@ -5,4 +5,5 @@ obj-$(CONFIG_BNGE) += bng_en.o
 bng_en-y := bnge_core.o \
 	    bnge_devlink.o \
 	    bnge_hwrm.o \
-	    bnge_hwrm_lib.o
+	    bnge_hwrm_lib.o \
+	    bnge_rmem.o
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
new file mode 100644
index 000000000000..ef232c4217bc
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2025 Broadcom.
+
+#include <linux/etherdevice.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/mm.h>
+#include <linux/dma-mapping.h>
+#include <linux/vmalloc.h>
+#include <linux/crash_dump.h>
+
+#include "bnge.h"
+#include "../bnxt/bnxt_hsi.h"
+#include "bnge_hwrm_lib.h"
+#include "bnge_rmem.h"
+
+void bnge_free_ring(struct bnge_dev *bd, struct bnge_ring_mem_info *rmem)
+{
+	struct pci_dev *pdev = bd->pdev;
+	int i;
+
+	if (!rmem->pg_arr)
+		goto skip_pages;
+
+	for (i = 0; i < rmem->nr_pages; i++) {
+		if (!rmem->pg_arr[i])
+			continue;
+
+		dma_free_coherent(&pdev->dev, rmem->page_size,
+				  rmem->pg_arr[i], rmem->dma_arr[i]);
+
+		rmem->pg_arr[i] = NULL;
+	}
+skip_pages:
+	if (rmem->pg_tbl) {
+		size_t pg_tbl_size = rmem->nr_pages * 8;
+
+		if (rmem->flags & BNGE_RMEM_USE_FULL_PAGE_FLAG)
+			pg_tbl_size = rmem->page_size;
+		dma_free_coherent(&pdev->dev, pg_tbl_size,
+				  rmem->pg_tbl, rmem->dma_pg_tbl);
+		rmem->pg_tbl = NULL;
+	}
+	if (rmem->vmem_size && *rmem->vmem) {
+		vfree(*rmem->vmem);
+		*rmem->vmem = NULL;
+	}
+}
+
+int bnge_alloc_ring(struct bnge_dev *bd, struct bnge_ring_mem_info *rmem)
+{
+	struct pci_dev *pdev = bd->pdev;
+	u64 valid_bit = 0;
+	int i;
+
+	if (rmem->flags & (BNGE_RMEM_VALID_PTE_FLAG | BNGE_RMEM_RING_PTE_FLAG))
+		valid_bit = PTU_PTE_VALID;
+
+	if ((rmem->nr_pages > 1 || rmem->depth > 0) && !rmem->pg_tbl) {
+		size_t pg_tbl_size = rmem->nr_pages * 8;
+
+		if (rmem->flags & BNGE_RMEM_USE_FULL_PAGE_FLAG)
+			pg_tbl_size = rmem->page_size;
+		rmem->pg_tbl = dma_alloc_coherent(&pdev->dev, pg_tbl_size,
+						  &rmem->dma_pg_tbl,
+						  GFP_KERNEL);
+		if (!rmem->pg_tbl)
+			return -ENOMEM;
+	}
+
+	for (i = 0; i < rmem->nr_pages; i++) {
+		u64 extra_bits = valid_bit;
+
+		rmem->pg_arr[i] = dma_alloc_coherent(&pdev->dev,
+						     rmem->page_size,
+						     &rmem->dma_arr[i],
+						     GFP_KERNEL);
+		if (!rmem->pg_arr[i])
+			return -ENOMEM;
+
+		if (rmem->nr_pages > 1 || rmem->depth > 0) {
+			if (i == rmem->nr_pages - 2 &&
+			    (rmem->flags & BNGE_RMEM_RING_PTE_FLAG))
+				extra_bits |= PTU_PTE_NEXT_TO_LAST;
+			else if (i == rmem->nr_pages - 1 &&
+				 (rmem->flags & BNGE_RMEM_RING_PTE_FLAG))
+				extra_bits |= PTU_PTE_LAST;
+			rmem->pg_tbl[i] =
+				cpu_to_le64(rmem->dma_arr[i] | extra_bits);
+		}
+	}
+
+	if (rmem->vmem_size) {
+		*rmem->vmem = vzalloc(rmem->vmem_size);
+		if (!(*rmem->vmem))
+			return -ENOMEM;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h
new file mode 100644
index 000000000000..56de31ed6613
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2025 Broadcom */
+
+#ifndef _BNGE_RMEM_H_
+#define _BNGE_RMEM_H_
+
+#define PTU_PTE_VALID             0x1UL
+#define PTU_PTE_LAST              0x2UL
+#define PTU_PTE_NEXT_TO_LAST      0x4UL
+
+struct bnge_ring_mem_info {
+	/* Number of pages to next level */
+	int			nr_pages;
+	int			page_size;
+	u16			flags;
+#define BNGE_RMEM_VALID_PTE_FLAG	1
+#define BNGE_RMEM_RING_PTE_FLAG		2
+#define BNGE_RMEM_USE_FULL_PAGE_FLAG	4
+
+	u16			depth;
+
+	void			**pg_arr;
+	dma_addr_t		*dma_arr;
+
+	__le64			*pg_tbl;
+	dma_addr_t		dma_pg_tbl;
+
+	int			vmem_size;
+	void			**vmem;
+};
+
+int bnge_alloc_ring(struct bnge_dev *bd, struct bnge_ring_mem_info *rmem);
+void bnge_free_ring(struct bnge_dev *bd, struct bnge_ring_mem_info *rmem);
+
+#endif /* _BNGE_RMEM_H_ */
-- 
2.47.1


