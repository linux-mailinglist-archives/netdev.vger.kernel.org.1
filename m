Return-Path: <netdev+bounces-126689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF279723A1
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 22:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6A61B20D97
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 20:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BCE18A6BD;
	Mon,  9 Sep 2024 20:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dLUH2ff3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF7D189F5A
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 20:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725913675; cv=none; b=uLkV2xPA3xB8FnecR6vLpVVYdfH5weU4s1SJjZWV1FYz0xzcj5pAn1NIiDs6FiwegYM4n7KyJblENdH+6MEjO6M/Ulk253zQRMUFkmoz6y0rJBEX99UnQOHLmDG0AQ47BqUs2APtDiMYPXebknykYX9c7P/+jb8Bcu9n7slqw7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725913675; c=relaxed/simple;
	bh=IoMLM+pM4PI4PCaP0U82Z56e8odOqzBgITB4+hKYtYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j27ItxhleQFHXvqBK78gFIJpwht+6LuU6cDPpoTNYNWyGswZNpMDPyjCgnNMwmdCF9BT9kcyrhWy+pTE604kBJV3tZAOys+uuszLjr7qhBgtKA3/kiuz32OgMw2I3pQWoketUfKFYekE8cSPFAcYXmDJaYfvea3vTNOIEIkHiZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dLUH2ff3; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7d666fb3fb9so1873714a12.0
        for <netdev@vger.kernel.org>; Mon, 09 Sep 2024 13:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725913673; x=1726518473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilD7dyTO6/xNbxDdpuRmI8uD5Jsijx4sm+AvYWaLjOU=;
        b=dLUH2ff3pNUomPF5p8w4oizZiyzpl2nR7i3a3yA2/Ww/TG5NGiRai2jFi+PY1Dx7rK
         2/GtNXTsrKGQOGQ0inYUmv2g3EVCDLUTPJq+sf1SlJf+PZjyUncY2heCqsU0LJoStQwp
         9Ko+b803yCIAT4uDwjfuGLFfqdAgZsQH6JU1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725913673; x=1726518473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ilD7dyTO6/xNbxDdpuRmI8uD5Jsijx4sm+AvYWaLjOU=;
        b=tb94bGg+4x7iE8qbRKhCfXjJ+r6SmZbmPjLdaireLYExaaGGnBeoJM1n7O7/l9ogIY
         oG4nxXDIAK7Ws+kpD/qigwXG7NcZwPCNN1LdWqxaXU2sU/VxxOxzTJBl/DUDnzSjVrqB
         UACyo93/iM5V0K5HMRBUDP751857wizwCJEu4siiy8/7MFDTXvwMNR/vHKD6tlzdCuSs
         fzByTYQ9bC2mK8CDQUmmJfzfeT2FrMLf3sg/To8DBLTBYU/khyYXq3ZomUYReT1KusTc
         QTI8uF447FlLGv+Asf0FsNksdlweDf9jgtR05rGeaJ1SOLEm/uSVeEgdQl3RkjiZa/nl
         ptow==
X-Gm-Message-State: AOJu0Yz/ZroDodgyuiq/Dda2zUuHHP00Y7KifkPlF6jEcJYzNTnAoSUh
	zpwxjiK6M8C6Q3betrNNpCjsx5LrS31EFTpDD+zsGl/SkdfFMyIeROD51H2C5A==
X-Google-Smtp-Source: AGHT+IG979PCcxo5O60MSkVlmgolXHcRfZbp/R+3yKN1zc08vPtgo4KZ+UChrvxFqxcDePXRsxq/sQ==
X-Received: by 2002:a05:6a21:3e0a:b0:1cf:2d22:564e with SMTP id adf61e73a8af0-1cf4fd62e0emr1209289637.6.1725913672769;
        Mon, 09 Sep 2024 13:27:52 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d8259bccbcsm4427640a12.79.2024.09.09.13.27.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2024 13:27:51 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gospo@broadcom.com,
	selvin.xavier@broadcom.com,
	pavan.chebbi@broadcom.com,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: [PATCH net-next 1/3] bnxt_en: Increase the number of MSIX vectors for RoCE device
Date: Mon,  9 Sep 2024 13:27:35 -0700
Message-ID: <20240909202737.93852-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240909202737.93852-1-michael.chan@broadcom.com>
References: <20240909202737.93852-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If RocE is supported on the device, set the number of RoCE MSIX vectors
to the number of online CPUs + 1 and capped at these maximums:

VF: 2
NPAR: 5
PF: 64

For the PF, the maximum is now increased from the previous value
of 9 to get better performance for kernel applications.

Remove the unnecessary check for BNXT_FLAG_ROCE_CAP.
bnxt_set_dflt_ulp_msix() will only be called if the flag is set.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 14 ++++++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h |  6 ++++--
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index b9e7d3e7b15d..fdd6356f21ef 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -176,11 +176,17 @@ EXPORT_SYMBOL(bnxt_unregister_dev);
 
 static int bnxt_set_dflt_ulp_msix(struct bnxt *bp)
 {
-	u32 roce_msix = BNXT_VF(bp) ?
-			BNXT_MAX_VF_ROCE_MSIX : BNXT_MAX_ROCE_MSIX;
+	int roce_msix = BNXT_MAX_ROCE_MSIX;
 
-	return ((bp->flags & BNXT_FLAG_ROCE_CAP) ?
-		min_t(u32, roce_msix, num_online_cpus()) : 0);
+	if (BNXT_VF(bp))
+		roce_msix = BNXT_MAX_ROCE_MSIX_VF;
+	else if (bp->port_partition_type)
+		roce_msix = BNXT_MAX_ROCE_MSIX_NPAR_PF;
+
+	/* NQ MSIX vectors should match the number of CPUs plus 1 more for
+	 * the CREQ MSIX, up to the default.
+	 */
+	return min_t(int, roce_msix, num_online_cpus() + 1);
 }
 
 int bnxt_send_msg(struct bnxt_en_dev *edev,
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
index 4eafe6ec0abf..4f4914f5c84c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
@@ -15,8 +15,10 @@
 
 #define BNXT_MIN_ROCE_CP_RINGS	2
 #define BNXT_MIN_ROCE_STAT_CTXS	1
-#define BNXT_MAX_ROCE_MSIX	9
-#define BNXT_MAX_VF_ROCE_MSIX	2
+
+#define BNXT_MAX_ROCE_MSIX_VF		2
+#define BNXT_MAX_ROCE_MSIX_NPAR_PF	5
+#define BNXT_MAX_ROCE_MSIX		64
 
 struct hwrm_async_event_cmpl;
 struct bnxt;
-- 
2.30.1


