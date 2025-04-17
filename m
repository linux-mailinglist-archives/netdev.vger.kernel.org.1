Return-Path: <netdev+bounces-183857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD883A923EA
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 19:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE44F7B055A
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 17:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32D8255248;
	Thu, 17 Apr 2025 17:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IOklRELW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1362550D2
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 17:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744910731; cv=none; b=bVccgDVLXTvAXpfGVuwItTstiywK+huUEFffMUKgkxV0tBzczGKcJZs92BR4LYOxZa6L/2s7Zr/eee2RVm09wK+95hTT+6k7zXasZb1enShKBKQEg7wYXHeoFd4AT+cpg5I5KLHBYMi6h6VBNnU+9K8po++F+7h2DzKPgmgjPoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744910731; c=relaxed/simple;
	bh=OW2gJhUxk3smeevyoweR68z8NRE83N01HlX5nNLPeiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1BHlJsbVWaBh0PneAEXPdmlv5q/koIT5evJdNfFR/rhs46MwueTTkFhxmhcDAv1VCWGCkd+25wU+wS5Xw04y6VAKBxxPqvVEM95uaRQlhBs5Dn9MtaWZcsMn9U6pDFvoU7zLrgBfbChOunn17gQWMpVF1ubZmNRTLNGJPDzlw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IOklRELW; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-736ad42dfd6so981961b3a.3
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 10:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744910729; x=1745515529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Adu9Vv9aPN6vaxOCO+Bfb6Z7K/eIEjER/fselG8cw5g=;
        b=IOklRELWOjHOCjuy39OGbGKsLm4yT+iFELO++12If1+8IEokp/0xlcwLohOXqP+YeI
         7hmF3k4aAIi1WTxS9h3koVTBifmSgiJJywkX32S4W0M5/HaGH3zrW0Y2v7YsyGtgPApe
         qeTZy8GF8d/XWK0NeVmlEYJE2oz7qiL2Kr8Ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744910729; x=1745515529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Adu9Vv9aPN6vaxOCO+Bfb6Z7K/eIEjER/fselG8cw5g=;
        b=gpzp3Klr+9bi2+Sl0ulBdsjSE8PeKFZgEwfNa0UfJpNKV5KQeWd4yf8Zv8Fw06+PFY
         NCFW/cHj4e6XvjuMGQWCuHFfHUzKFJ4p7IhemcshyBxh96/T8Nmc5QwWkCKByjagBHNN
         qbsCNYvfEHZGfrHaXpx04EBRx/tdc8COrcEmH+jEioBZFEbxEPxATVfOkgZuY8a71SNv
         ViEDC5/qyjG4XfScDIixADUiwHv/WSDv/3M+oL1Xc340iixSDISRZqz5Iyw6pEyi+J8y
         wWoBsN//toj1jfUbUE/RXyHxGAwZGaRWUaWnyMFBo9VBfz2+UnVRKDH18eX2hRZIOmSb
         +KYg==
X-Gm-Message-State: AOJu0YxTORWx6bNxfw+5mbbqT1FEMdsIH3AzRlWhZ2NdK24ZLRj4nnUL
	oJ08QOu74Pz2yeNsUhiOlXJUm/cXL4JsjJFYE+nI2c61r7eSAEkRnrYDe3h5QA==
X-Gm-Gg: ASbGncubM6BfR7wSqY2l/2x7rOD/BtFHpH4MHRiHVIq6ngNzhnssxlppghg1KXLEhZF
	JVrXmRaJRlC95YXgK/cJqQqorLIe/7mSlxSVq+YboNekfTONebFBSGNnhrBqAIkIJV91sTSLlgG
	kUFpGRCdXcJFlUKHfd4ev3qqRSDRmt/vY6Tp1XUPDql6JK/5sXcD9ROiyw6W4RYk0YqLZ5+YCB0
	dZkVQzNrURwh59i6wDdMqKiJmqkvI0FvFShuj6he2Q8zXoh4JQQDdAEU3dCCzsPr+A3uRcbpYF2
	JIo9vTeUnhHU8OLS8YBpvUkncBJ/itFa7uVxoHcjQE16n8PlxofcUja/kVFuYkz5jQhl2C8ceJD
	5xpNHhc8wnSVabp8H
X-Google-Smtp-Source: AGHT+IHiplUVRjx/3CgkBC2/KAm0JdODThITBhUDsKX8gh4jA9yX7Pj0Yhn3qhyU1PWDGULKElYypw==
X-Received: by 2002:a05:6a00:2348:b0:736:a7ec:a366 with SMTP id d2e1a72fcca58-73c266f9c5bmr7506747b3a.9.1744910729250;
        Thu, 17 Apr 2025 10:25:29 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8ea9a4sm109879b3a.41.2025.04.17.10.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 10:25:28 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net-next v2 1/4] bnxt_en: Change FW message timeout warning
Date: Thu, 17 Apr 2025 10:24:45 -0700
Message-ID: <20250417172448.1206107-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250417172448.1206107-1-michael.chan@broadcom.com>
References: <20250417172448.1206107-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The firmware advertises a "hwrm_cmd_max_timeout" value to the driver
for NVRAM and coredump related functions that can take tens of seconds
to complete.  The driver polls for the operation to complete under
mutex and may trigger hung task watchdog warning if the wait is too long.
To warn the user about this, the driver currently prints a warning if
this advertised value exceeds 40 seconds:

Device requests max timeout of %d seconds, may trigger hung task watchdog

Initially, we chose 40 seconds, well below the kernel's default
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT (120 seconds) to avoid triggering
the hung task watchdog.  But 60 seconds is the timeout on most
production FW and cannot be reduced further.  Change the driver's warning
threshold to 60 seconds to avoid triggering this warning on all
production devices.  We also print the warning if the value exceeds
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT which may be set to architecture
specific defaults as low as 10 seconds.

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
v2: Add check for CONFIG_DEFAULT_HUNG_TASK_TIMEOUT

v1: https://lore.kernel.org/netdev/20250415174818.1088646-2-michael.chan@broadcom.com/
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c      | 11 +++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.h |  2 +-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 83608b7447f4..e16a3a8e96bb 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10110,7 +10110,7 @@ static int bnxt_hwrm_ver_get(struct bnxt *bp)
 	struct hwrm_ver_get_input *req;
 	u16 fw_maj, fw_min, fw_bld, fw_rsv;
 	u32 dev_caps_cfg, hwrm_ver;
-	int rc, len;
+	int rc, len, max_tmo_secs;
 
 	rc = hwrm_req_init(bp, req, HWRM_VER_GET);
 	if (rc)
@@ -10183,9 +10183,12 @@ static int bnxt_hwrm_ver_get(struct bnxt *bp)
 	bp->hwrm_cmd_max_timeout = le16_to_cpu(resp->max_req_timeout) * 1000;
 	if (!bp->hwrm_cmd_max_timeout)
 		bp->hwrm_cmd_max_timeout = HWRM_CMD_MAX_TIMEOUT;
-	else if (bp->hwrm_cmd_max_timeout > HWRM_CMD_MAX_TIMEOUT)
-		netdev_warn(bp->dev, "Device requests max timeout of %d seconds, may trigger hung task watchdog\n",
-			    bp->hwrm_cmd_max_timeout / 1000);
+	max_tmo_secs = bp->hwrm_cmd_max_timeout / 1000;
+	if (bp->hwrm_cmd_max_timeout > HWRM_CMD_MAX_TIMEOUT ||
+	    max_tmo_secs > CONFIG_DEFAULT_HUNG_TASK_TIMEOUT) {
+		netdev_warn(bp->dev, "Device requests max timeout of %d seconds, may trigger hung task watchdog (kernel default %ds)\n",
+			    max_tmo_secs, CONFIG_DEFAULT_HUNG_TASK_TIMEOUT);
+	}
 
 	if (resp->hwrm_intf_maj_8b >= 1) {
 		bp->hwrm_max_req_len = le16_to_cpu(resp->max_req_win_len);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.h
index 15ca51b5d204..fb5f5b063c3d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.h
@@ -58,7 +58,7 @@ void hwrm_update_token(struct bnxt *bp, u16 seq, enum bnxt_hwrm_wait_state s);
 
 #define BNXT_HWRM_MAX_REQ_LEN		(bp->hwrm_max_req_len)
 #define BNXT_HWRM_SHORT_REQ_LEN		sizeof(struct hwrm_short_input)
-#define HWRM_CMD_MAX_TIMEOUT		40000U
+#define HWRM_CMD_MAX_TIMEOUT		60000U
 #define SHORT_HWRM_CMD_TIMEOUT		20
 #define HWRM_CMD_TIMEOUT		(bp->hwrm_cmd_timeout)
 #define HWRM_RESET_TIMEOUT		((HWRM_CMD_TIMEOUT) * 4)
-- 
2.30.1


