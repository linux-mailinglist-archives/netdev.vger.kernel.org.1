Return-Path: <netdev+bounces-155120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C41A01246
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 05:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E96218844C8
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 04:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B391487C1;
	Sat,  4 Jan 2025 04:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="b8CbBaNP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DB985260
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 04:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735965571; cv=none; b=bYWJLjg53g//9z0p4X5/Fda6GEqybJY43PSwfKUm1h6Zjz/UlufDdNcNOOKYTFakR+H2EXONenlF4ybTej3Iq3xepk29fpuyzuO+qu11ZYFlDQLe/amg8WBvhDoN1J3ITMr4bM7Rq5hRY1G9OYJqfGsCEpp+pfOLKh/1VshMeYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735965571; c=relaxed/simple;
	bh=NBzR58wVcQbEp3y2dmpEa8QwQhSwwKY2KQvT8UTv5tA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJ4e01+lwZ9in4NpIzZttNqs9cDjUUNWVppgUt39DJF5cVCnAZK2X2AI3I1b3kpscB9uoYDCKn6WjyEd6CU08S/FhiiwkW5LWciTgY4vWq2iUM6QLEY0fYbX3E7M+C+sBEVX6cHEjXGdgEcr8v/5C3pa3XHbjokF7hpMdxTO078=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=b8CbBaNP; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2f441904a42so18513413a91.1
        for <netdev@vger.kernel.org>; Fri, 03 Jan 2025 20:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1735965569; x=1736570369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oR5YmATHFQKhrEU/48duKrrVookIk1tKxQefHsNYDkI=;
        b=b8CbBaNPJSJ4WCRkJ5Ah7tflY1S+938VVU9P/MIWcvMGXFYwzHvAn1Hfws3PQxUwGQ
         l33I7zx2lfVN1vv7omaGfyxYnh6bevXrMnmFxY3iqMovOt2bdFwL2vMJKguVCqv+2Kye
         HwLLWhpSrXI0MjiCP56ABHo88BhLuHEOBcaHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735965569; x=1736570369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oR5YmATHFQKhrEU/48duKrrVookIk1tKxQefHsNYDkI=;
        b=KcjR8c1mt3+6UKxOugBjhpfHODu2XwDk42WPfTuBAkp1R7sHVZQohpn4AzVmfI+Qic
         89DQjtiS4GzE6VIYClRvqIxaKdF9TvSbvsYP5kTbr5X7DprrAtnxobWtJY/671IYOzld
         G/vNriauRGmaYJy9YhYNE5GGjI52QxyZibFmiAimbVUq3gyQVchBHCAPDQKHiga/R6+h
         5BnH9BeVtQeEI6u66GE5kfZMBCO24AZB3c/j9cW6gbkj2hxN+eYOeLKdGSvxfy2w1ljC
         2VARbON8mxJ2F+ceQEc0ih3E/VfqwT53WP/BJCCUPYDXfjsIeSxjzAtaMXjsEYphZDTM
         Hhhg==
X-Gm-Message-State: AOJu0YwQF27rcZg9QOqmVefFvW8WQgA0uaD2qDGKsHKmQCikfmj4asbl
	648V3kVsNWU9lqjisvv4sqsfvagCXkLSCstro7h3us51cxaBJPhBus9gUQCG8w==
X-Gm-Gg: ASbGnctUNXaASJqtv6UnPE9oQb0aPcaYM0P0Bi0P4+W3JR7KsxaW9oOP1qOMfz9uYYr
	XscGYlizS3BfjMW9zPzsjbA9YLRZ18+sarytNuO8vkTJEj2sia2VU6f+fpX74ehIuRie5+l8cbR
	TXB5HuRCwwMe+EdvYF4kXArdwt93oyhmCWyUgvv+BpgzVuFZcQKdBexiVhoUOMS0w4R/w8P3FK8
	I4CVNVgJpDuhI5TlTYhcOKdN58Y4UZS5uPeHBEH4GWPRJkbZfxLFrGrAgHkl48Ht58otJ/J1rSx
	UUPK1gw50lyVdoksdmsAGhyKn99GCAFT
X-Google-Smtp-Source: AGHT+IF9XRnzeTumeq5iIKCUac38YJWx5PuP9Ot4xHKjKYoyc0LdRyc7mz4pJkrKBSkw/JDwKLCa4Q==
X-Received: by 2002:a05:6a00:410d:b0:725:f376:f4ff with SMTP id d2e1a72fcca58-72abde0b086mr75478783b3a.13.1735965569366;
        Fri, 03 Jan 2025 20:39:29 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad84eb5dsm27038105b3a.86.2025.01.03.20.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 20:39:28 -0800 (PST)
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
Subject: [PATCH net 1/2] bnxt_en: Fix possible memory leak when hwrm_req_replace fails
Date: Fri,  3 Jan 2025 20:38:47 -0800
Message-ID: <20250104043849.3482067-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250104043849.3482067-1-michael.chan@broadcom.com>
References: <20250104043849.3482067-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

When hwrm_req_replace() fails, the driver is not invoking bnxt_req_drop()
which could cause a memory leak.

Fixes: bbf33d1d9805 ("bnxt_en: update all firmware calls to use the new APIs")
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index b771c84cdd89..0ed26e3a28f4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -208,7 +208,7 @@ int bnxt_send_msg(struct bnxt_en_dev *edev,
 
 	rc = hwrm_req_replace(bp, req, fw_msg->msg, fw_msg->msg_len);
 	if (rc)
-		return rc;
+		goto drop_req;
 
 	hwrm_req_timeout(bp, req, fw_msg->timeout);
 	resp = hwrm_req_hold(bp, req);
@@ -220,6 +220,7 @@ int bnxt_send_msg(struct bnxt_en_dev *edev,
 
 		memcpy(fw_msg->resp, resp, resp_len);
 	}
+drop_req:
 	hwrm_req_drop(bp, req);
 	return rc;
 }
-- 
2.30.1


