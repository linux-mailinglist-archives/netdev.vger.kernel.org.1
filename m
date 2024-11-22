Return-Path: <netdev+bounces-146870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAD99D65E3
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 23:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9820B212B5
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 22:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225D1198E7B;
	Fri, 22 Nov 2024 22:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FEhjdTjv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C89218CC01
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 22:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732315604; cv=none; b=nxyX8Ua+N2jy4r2LbjXauNOic1EvGuI9UFy8MkV1CV6K1GZ0JUxXP06pt0SuP1vDWiIb6nQaacCD9zlapeQMgkGjY6IGdnwh1vV4kuAaO2e+ulBja87nORAsm/Bec+iIc1OLVwxmNvHM7/iFHBdqQIhCaAsgW9ej8BqRxet1NLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732315604; c=relaxed/simple;
	bh=tpDB/KjwXA76ztECG35BWNye1OarOFtto7jb4FKHLZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWpdt7Ufa8vgglrtikP9tUvprpUavzBXNPXTjVcD6VYon4+n5mu3T8A3Wo8MDNd8cvZyQYpXPuonnokHuJhNcUwdSnJi9iEZkQ+/hggudx9DT0zOWY2+HcL/RGNYu43oMRSYMCwmqmkmO9BTEmnb2LsXXkUaMlujZ6jTl5WKgII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FEhjdTjv; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b1488fde46so168496285a.2
        for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 14:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1732315601; x=1732920401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgwBv+z+X5JHvhiLz4pnaKO3DgsfjRU+fNdFaB0544g=;
        b=FEhjdTjvg5xi5jttHKjim/0b1yOK8GzSDh6QdRah758+OM8nvtpkJne8uKjy9/gxTj
         2Sd2P4HLRgLDTEH32h0NdhexqAJs3qCYXfztLP+Y6P5RkkYniEzeoBnURqxAR5d3fnuX
         /uHRiKTbFgtwbtRxHK7BBjSaQi147v2Yysc9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732315601; x=1732920401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgwBv+z+X5JHvhiLz4pnaKO3DgsfjRU+fNdFaB0544g=;
        b=ikCCUH8uks6IzSILqcfRTIXVtIWtHeeuJawhzFzT3jE+iLCDnsxke+psLZb7nXlfEK
         0PbbnZstvB/S4fUA8ZyxDr5AEuGX7bcyBA3TS+zbdd9n8igQj7cSZN5RRnHED1lu/QF1
         BcD1el7+T3N81LrYy0dgaw+pi9Cf0JYFeFKPWcFfys8moyMQ1oXC2AzqSc0tuzwQ88f7
         JJOp0R77W+wmPphw/9qZAl+Zm8Q8OyPVPr8ghe3DnOQNuKvBDNpddPlqGWsWvLPVGaAX
         JP76GkJ9DgI6i15AHy3H84VyOo51w12KMtxjkEWRrEcUI38Gc3sTSJ+8H/hym0GWlZJE
         UiVQ==
X-Gm-Message-State: AOJu0YwlvkV/ZlRMOs598+lzQTEbJBvHgeJ+OC/RZDXEN6pgSzk/lMbk
	05bm6+9YgiWWiz3zMtZ2Snc8ANEh63Mx05IhrwjRXnY2zWrPKHzMf10P7OSlzQ==
X-Gm-Gg: ASbGnctMztMhvXPbvXo4RpHHWxFF+Wd1sizvw+742bfo2lKxgG8+lXsg51h20cuebqr
	kBfQjVa8qqJI2gzhUFpyxgTb+iZSqZFQCeACtFlndvpieNPxm7TYdPvbK4Z4Ihr22OV51RjlBMp
	cT914rYEycaK9D8X5wbNkvMTvMYpubrrTB4wPy9upA24djYeRbgaWFx9gl/JlC2QUXrnF3VbnTP
	hKUufP8w+CdEChmD3S+OdGKizHtWvel9WcxgolNj/nqUQJA99fzO3NYTJ4Wtr6+y/jl7h+HCQ+W
	8jg1NRM1ArNBXJ38RYSbl7bkuw==
X-Google-Smtp-Source: AGHT+IHaxk0crG0vc0RCYHbNvUcnG8kFVlWMyKR8uUN6MouTs53sNGNEl2P/AbIafHwLo0GTr5De9g==
X-Received: by 2002:a05:620a:24d6:b0:7ac:b197:3004 with SMTP id af79cd13be357-7b514516442mr566788785a.29.1732315601219;
        Fri, 22 Nov 2024 14:46:41 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b51415286esm131270485a.101.2024.11.22.14.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 14:46:40 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net 5/6] bnxt_en: Refactor bnxt_ptp_init()
Date: Fri, 22 Nov 2024 14:45:45 -0800
Message-ID: <20241122224547.984808-6-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20241122224547.984808-1-michael.chan@broadcom.com>
References: <20241122224547.984808-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of passing the 2nd parameter phc_cfg to bnxt_ptp_init().
Store it in bp->ptp_cfg so that the caller doesn't need to know what
the value should be.

In the next patch, we'll need to call bnxt_ptp_init() in bnxt_resume()
and this will make it easier.

Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 6 +++---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 4 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h | 3 ++-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index b7541156fe46..9c4b8ea22bf9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -9296,7 +9296,6 @@ static int __bnxt_hwrm_ptp_qcfg(struct bnxt *bp)
 	struct hwrm_port_mac_ptp_qcfg_output *resp;
 	struct hwrm_port_mac_ptp_qcfg_input *req;
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
-	bool phc_cfg;
 	u8 flags;
 	int rc;
 
@@ -9343,8 +9342,9 @@ static int __bnxt_hwrm_ptp_qcfg(struct bnxt *bp)
 		rc = -ENODEV;
 		goto exit;
 	}
-	phc_cfg = (flags & PORT_MAC_PTP_QCFG_RESP_FLAGS_RTC_CONFIGURED) != 0;
-	rc = bnxt_ptp_init(bp, phc_cfg);
+	ptp->rtc_configured =
+		(flags & PORT_MAC_PTP_QCFG_RESP_FLAGS_RTC_CONFIGURED) != 0;
+	rc = bnxt_ptp_init(bp);
 	if (rc)
 		netdev_warn(bp->dev, "PTP initialization failed.\n");
 exit:
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
index 075ccd589845..2d4e19b96ee7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
@@ -1038,7 +1038,7 @@ static void bnxt_ptp_free(struct bnxt *bp)
 	}
 }
 
-int bnxt_ptp_init(struct bnxt *bp, bool phc_cfg)
+int bnxt_ptp_init(struct bnxt *bp)
 {
 	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
 	int rc;
@@ -1061,7 +1061,7 @@ int bnxt_ptp_init(struct bnxt *bp, bool phc_cfg)
 
 	if (BNXT_PTP_USE_RTC(bp)) {
 		bnxt_ptp_timecounter_init(bp, false);
-		rc = bnxt_ptp_init_rtc(bp, phc_cfg);
+		rc = bnxt_ptp_init_rtc(bp, ptp->rtc_configured);
 		if (rc)
 			goto out;
 	} else {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
index c7851f8c971c..a95f05e9c579 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h
@@ -135,6 +135,7 @@ struct bnxt_ptp_cfg {
 					 BNXT_PTP_MSG_PDELAY_REQ |	\
 					 BNXT_PTP_MSG_PDELAY_RESP)
 	u8			tx_tstamp_en:1;
+	u8			rtc_configured:1;
 	int			rx_filter;
 	u32			tstamp_filters;
 
@@ -168,7 +169,7 @@ void bnxt_tx_ts_cmp(struct bnxt *bp, struct bnxt_napi *bnapi,
 		    struct tx_ts_cmp *tscmp);
 void bnxt_ptp_rtc_timecounter_init(struct bnxt_ptp_cfg *ptp, u64 ns);
 int bnxt_ptp_init_rtc(struct bnxt *bp, bool phc_cfg);
-int bnxt_ptp_init(struct bnxt *bp, bool phc_cfg);
+int bnxt_ptp_init(struct bnxt *bp);
 void bnxt_ptp_clear(struct bnxt *bp);
 static inline u64 bnxt_timecounter_cyc2time(struct bnxt_ptp_cfg *ptp, u64 ts)
 {
-- 
2.30.1


