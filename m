Return-Path: <netdev+bounces-228162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A84D0BC331E
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 05:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7030B4E23BB
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 03:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7023729D294;
	Wed,  8 Oct 2025 03:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXJVG5UJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2474C120
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 03:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759893418; cv=none; b=dUJ9Hq8A3Lj9sO6pjz0S4CnkbsgNmraE1ZJTs94MlXIhOgD4HFA4ED9Czn4d2nCwbfiAhYqM2qRswuq1a29iI5chGfvdgtfIdrF74zi9c5rmLRcOgFgeJBNF5NLhrZMDcYNeK2/JDXRVDyTxTIGTcLx0utn8KxHRqb+PuaKXVdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759893418; c=relaxed/simple;
	bh=lxE21ZFjWqt1vCg/OmyVKc4EVfAALOkv+hCw3r4AiE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RsjqnKPoO/efWmON0ucQvtow5n6u6h/jgC1VJT7x3IQvTybE6xj5Vl1eMGk36p1SqeN/yNT0ctxupCVBql4suqgnDZxf+qlvrz60emnORgwPGlDHx+g5+0rdRJ/BG/oPW1/+gAMcus+O3eFaE+evyQkwn7XH/40vi0uwSXTkM0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXJVG5UJ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-279e2554b6fso46212325ad.2
        for <netdev@vger.kernel.org>; Tue, 07 Oct 2025 20:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759893416; x=1760498216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KQMmcQpwcVDLEiRU8ln9rZsdHE2gIdwABm+vFaUYQ8U=;
        b=PXJVG5UJYav2HvceZTFUCBQcLfvOxUYpPyMW8aGyBagPGX2FwmcYCVucqWL7Po5hAS
         BBqELIRcyJB/04sWT+srsvGzei+0z3Cdwqv5nIDedxsuLrMhhCk/NJWPsgfYHXt7tgzY
         i4xE0j6tWIa2DPZFzhmEelBjb44hiqTX5BmR74bSPvM22boPMVwwnpXnJ82MRPzXwko5
         Ex+FzFVXWkLO7PgOs9ZbmMLsFRPJfDBiGrk72yxx/Gwr8D87t8rVDcn40SWImLWhvGVS
         e2D2/UEjdLj8g3qmohvBogmyzNfMvjUASQlWN0LOKqMPlOS8/DS2PWUy3t295PEezX8V
         nsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759893416; x=1760498216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KQMmcQpwcVDLEiRU8ln9rZsdHE2gIdwABm+vFaUYQ8U=;
        b=JKFHh2DUQVZV47EypXgBpQV5u9ed99jzZZwP68nAzKHniHuHQ+GbqxudX3wWy4aMKh
         PIRzfucbmr1MQKwRTOAIq+RSq9U0Wf3tuw4yhrRAAcq+VYfcnSxk0uuz3pTEY9wzqJz5
         sWxyjzcW9Oj9IvYWr7xDkrgxy8IPmhZgjR7jb+HHAZ34BzfeS4cALnoFFSTYOV6TN6Za
         7CRBhTAZf1hP5WNiu8r3aLCQZMJeAHdQC4o366GmG97PkElLwl86pWGo/sXSVcOCbHF5
         4YFVjM5Cy0xv7mjWxH8TssCUVXVF3BP7BjMtnb7XgHqMg6kSAy2wul8EA2GVSWLFO1Cz
         Girg==
X-Gm-Message-State: AOJu0YywOk3ksvy2i80XOE0slx9i8XqU7mLpM/ngZL3ywul8mWuq3syQ
	55xHbJdkzQ4BGAynyOFpxSKQxM57p9gInJYmGPQ3o0m0VEwZlRM8YCQrLzKmnQ==
X-Gm-Gg: ASbGnctRpgf1nKebLDpSZpJs61oUQQXVPJabu2+GP8cpMlYabas2wqj7DY7ZNBvuVzc
	48U0uRcnc1ZJIn9I2ShzZ2NHMzXrAYfny7gXdykrFQRlay0XSJVKWtVMWOANrs3rx1Gc4x1Qidz
	EmuK+fxSF7i9g8OX8vzPKtWi2KHLkSWgdCD6lZ33FLYo0eiMfrLvizkppVwFK2Ar1zRULTbYH4t
	t2K+bxVSPbIDabkhHm1xWxErXL1/Zjd4dsghtiEcavd8lmUWeD99YrQCcnPlASWIsVGEY/XUaQV
	VyxchexIyd3l1wB2dU9kzSJtCeDfjxBrZxQvBOzZxDMnTAN0rOgRKX9DiudKjJ4d95JuHmbRaXl
	Glce7aeQjqGW68oMH+/VfMPMckh/67zbn+61J5uiOU7QdRSZ+dFQbtkNnMePwD2XqzizEhVm03w
	==
X-Google-Smtp-Source: AGHT+IEJpnjD17JcF1m07nTMFuWsE/Iu+9TlBgqFTitkpJsI23pJn7D99VrCreZs5QNwRefE51WbZg==
X-Received: by 2002:a17:902:f612:b0:277:9193:f2ca with SMTP id d9443c01a7336-290273564e8mr19114715ad.9.1759893415867;
        Tue, 07 Oct 2025 20:16:55 -0700 (PDT)
Received: from yijingzeng-mac.thefacebook.com ([2620:10d:c090:500::7:1460])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d110d91sm181136675ad.5.2025.10.07.20.16.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 07 Oct 2025 20:16:55 -0700 (PDT)
From: Yijing Zeng <zengyijing19900106@gmail.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	me@pmachata.org,
	kuba@kernel.org,
	yijingzeng@meta.com
Subject: [PATCH] dcb: fix tc-maxrate unit conversions
Date: Tue,  7 Oct 2025 20:16:40 -0700
Message-ID: <20251008031640.25870-1-zengyijing19900106@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yijing Zeng <yijingzeng@meta.com>

The ieee_maxrate UAPI is defined as kbps, but dcb_maxrate uses Bps.
This fix patch converts Bps to kbps for parse, and convert kbps to Bps for print_rate().

Fixes: 117939d9 ("dcb: Add a subtool for the DCB maxrate object")
Signed-off-by: Yijing Zeng <yijingzeng@meta.com>
---
 dcb/dcb_maxrate.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/dcb/dcb_maxrate.c b/dcb/dcb_maxrate.c
index 1538c6d7..af012dba 100644
--- a/dcb/dcb_maxrate.c
+++ b/dcb/dcb_maxrate.c
@@ -42,13 +42,16 @@ static void dcb_maxrate_help(void)
 
 static int dcb_maxrate_parse_mapping_tc_maxrate(__u32 key, char *value, void *data)
 {
-	__u64 rate;
+	__u64 rate_Bps;
 
-	if (get_rate64(&rate, value))
+	if (get_rate64(&rate_Bps, value))
 		return -EINVAL;
 
+	/* get_rate64() returns Bps. ieee_maxrate UAPI expects kbps. */
+	__u64 rate_kbps = (rate_Bps * 8) / 1000;
+
 	return dcb_parse_mapping("TC", key, IEEE_8021QAZ_MAX_TCS - 1,
-				 "RATE", rate, -1,
+				 "RATE", rate_kbps, -1,
 				 dcb_set_u64, data);
 }
 
@@ -62,8 +65,11 @@ static void dcb_maxrate_print_tc_maxrate(struct dcb *dcb, const struct ieee_maxr
 	print_string(PRINT_FP, NULL, "tc-maxrate ", NULL);
 
 	for (i = 0; i < size; i++) {
+		/* ieee_maxrate UAPI returns kbps. print_rate() expects Bps for display */
+		__u64 rate_Bps  = maxrate->tc_maxrate[i] * 1000 / 8;
+
 		snprintf(b, sizeof(b), "%zd:%%s ", i);
-		print_rate(dcb->use_iec, PRINT_ANY, NULL, b, maxrate->tc_maxrate[i]);
+		print_rate(dcb->use_iec, PRINT_ANY, NULL, b, rate_Bps);
 	}
 
 	close_json_array(PRINT_JSON, "tc_maxrate");
-- 
2.50.1


