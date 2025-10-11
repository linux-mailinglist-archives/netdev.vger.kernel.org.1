Return-Path: <netdev+bounces-228604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68770BCFD32
	for <lists+netdev@lfdr.de>; Sun, 12 Oct 2025 00:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAB423BD344
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 22:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D41F188580;
	Sat, 11 Oct 2025 22:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtJaZHUD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821BC223DCE
	for <netdev@vger.kernel.org>; Sat, 11 Oct 2025 22:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760221721; cv=none; b=soQZjVwpgEp4F/02ikRPKMViR3t4vAbHCz4n60ME1C65mpNy4sPGWGXHPZN5KbB0KoIHSHXcfPpxWOqFN9nzcR6HmIbnZdFsUQz0tF9MEqsxO65N6GHF0O1YoetSoHrXWDd17puRyWuNiStgzfc3z0IOCLbAMvrRPct/Bis0wms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760221721; c=relaxed/simple;
	bh=1cxqa9/a6/4/IseLrjSRryZ7gaAyBeI1x1vSgmwzOzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Datnz1q9o9STI7KNds2ncn0RNoQcDMYRHr8ag1u82KXHHvgHWnAlk1Piy398RrN91lyVwdGsWRmSGdGUlfl0emv5PW1Q2RMm9uM4F4zh9h2v7/WoY7AjYA63wXifJH+tNGgNDbagUpVi8bd1NYIHn1THcLdMKzZao3xkhKE1dY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtJaZHUD; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f605f22easo2718711b3a.2
        for <netdev@vger.kernel.org>; Sat, 11 Oct 2025 15:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760221719; x=1760826519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlvIa089srhXVyQ7tc1Yl/MMFy8Ph9aqA9Fa75oaPQk=;
        b=GtJaZHUDTiW0YYS5+GF+yTSZZk9b1ZLOaYKylJuiJjIW+JO9jlvjgQQK0bEFwqcK44
         stYMCF5z0tDV5WFW9XpoB+4NRCExuUuHe1BXmyldX7rlXFG0NSAn2wJ7aQNa781s5Umn
         F/0f6dJJItxdF2Ixb68H/2MaQVzBinY+/w3c+9+WR8LsGftP5HItIyIimJtHZpzoFiLj
         H/79//KMKCjbPGXzS3qN00crVJR0lbjYTj/Jz9CKUBqAZKYDA8amZ3lo+B8iAwjfXPSl
         jftlwBuYB1oxqr5LZLAgRKXd/VsuTv2Vo1zb5Wo9chTbhruSaUTrjpwjSOu3obesTdfM
         kaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760221719; x=1760826519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VlvIa089srhXVyQ7tc1Yl/MMFy8Ph9aqA9Fa75oaPQk=;
        b=VqW+tX6PLcfmkAFVsa66WBEuQWtmAjQBEcmpCQkP7U9hrgzq5tWG3vYKA5Dfrq83X9
         XJ6zKf/tfg85fOXPV7eCj3qsUEMCNzY/MBPMFfQp5FHKybCrPZLhZ98gIvUnYXCZ+4wk
         WgDSgaI2IL/ueCcgEtj0P0rnssIwsJ+hF6BNr5m47IOtNuuTcQjyCy3JquQPNphXuUOW
         5QBEHnnij7iqjY/ZWy1sVbcMA5SBeenVt5hN0ZxONr2Cbf+SkFNgpL/LHIRw716hCir4
         p5C8CCD+vkrRVogpGpQDBTN5zUpwVeHF/nCFqRHsKPsZqG+S3X3hnEyLmoumg25cnKoG
         N/Hg==
X-Gm-Message-State: AOJu0YwXkth8VIklpxNomNrEpfheodYjH1S7k/lmdmTWZL6gu/YQDaFM
	ioWfsHorWgOxe2ykLXCz8rEAY+Iwx7uYHg3+Uq6hwVhHkYJEVNXZfuIEfHXp29Vs
X-Gm-Gg: ASbGncttcLvESmkeWvo07Y30vkCTzzLbz19/H8L+lkLF5+vasKwtnHmpX7G3VagNvvd
	Gu5ru8Kn5572RlBP81GOx16p2rpCf2G4P0mLfAs0XRdQHQuPTeoZY2jnJMbuDzYBfuVhfFzeQ1z
	qFlxg9iJMgcVRQSfGCplGB034CF/QjEHwqSlLA/7+/WFHpJeRncnuCafxHKNY8SSE/Fh7njSzJS
	R+EP/dWp6etFww2vSXMYUDckCXQnBf+RcHMcLrCcaq0KKv60GPu1ON6akxaQhr1Tq3vrIFGdt5o
	qpLgWmunIaPkwX6lTWkODENK87jwpbL2Qf3Ly+EjswB4tkF6o04IdDyULQHvq+COHjrvV8l5Jck
	mzM8NrHfKr/Ar8mGo7tR2AhJdqSJS7hF86RtkNK9cz3BwZQGEMFMEV239wsoh8kuHzpOy8/zEEY
	9IXK4=
X-Google-Smtp-Source: AGHT+IFpAevmluy6PVpI4+JhoBzCM1cXAIYugeSCfeKlLByV/r1c2Y80GrLDu+qYcotEOHagBNfZ2Q==
X-Received: by 2002:a05:6a20:748c:b0:24b:c7d9:88e4 with SMTP id adf61e73a8af0-32da83e5ef2mr22266244637.42.1760221719422;
        Sat, 11 Oct 2025 15:28:39 -0700 (PDT)
Received: from yijingzeng-mac.thefacebook.com ([2620:10d:c090:400::5:6972])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992dd854a2sm6870688b3a.76.2025.10.11.15.28.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 11 Oct 2025 15:28:38 -0700 (PDT)
From: Yijing Zeng <zengyijing19900106@gmail.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	me@pmachata.org,
	kuba@kernel.org,
	yijingzeng@meta.com
Subject: [PATCH v2] dcb: fix tc-maxrate unit conversions
Date: Sat, 11 Oct 2025 15:25:24 -0700
Message-ID: <20251011222829.25295-1-zengyijing19900106@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251008031640.25870-1-zengyijing19900106@gmail.com>
References: <20251008031640.25870-1-zengyijing19900106@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yijing Zeng <yijingzeng@meta.com>

The ieee_maxrate UAPI is defined as kbps, but dcb_maxrate uses Bps.
This fix patch converts Bps to kbps for parse by dividing 125,
and convert kbps to Bps for print_rate() by multiplying 125.

Fixes: 117939d9bd89 ("dcb: Add a subtool for the DCB maxrate object")
Signed-off-by: Yijing Zeng <yijingzeng@meta.com>
---
v2:
  - Address style comments
  - Avoid potential overflow

 dcb/dcb_maxrate.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/dcb/dcb_maxrate.c b/dcb/dcb_maxrate.c
index 1538c6d7..8c5a7e55 100644
--- a/dcb/dcb_maxrate.c
+++ b/dcb/dcb_maxrate.c
@@ -42,13 +42,20 @@ static void dcb_maxrate_help(void)
 
 static int dcb_maxrate_parse_mapping_tc_maxrate(__u32 key, char *value, void *data)
 {
-	__u64 rate;
+	__u64 rate_bytes_per_sec;
+	__u64 rate_kbits_per_sec;
 
-	if (get_rate64(&rate, value))
+	if (get_rate64(&rate_bytes_per_sec, value))
 		return -EINVAL;
 
+	/* get_rate64() returns Bps.
+	 * ieee_maxrate UAPI expects kbps.
+	 * convert Bps to kbps by dividing 125.
+	 */
+	rate_kbits_per_sec = rate_bytes_per_sec / 125;
+
 	return dcb_parse_mapping("TC", key, IEEE_8021QAZ_MAX_TCS - 1,
-				 "RATE", rate, -1,
+				 "RATE", rate_kbits_per_sec, -1,
 				 dcb_set_u64, data);
 }
 
@@ -62,8 +69,14 @@ static void dcb_maxrate_print_tc_maxrate(struct dcb *dcb, const struct ieee_maxr
 	print_string(PRINT_FP, NULL, "tc-maxrate ", NULL);
 
 	for (i = 0; i < size; i++) {
+		/* ieee_maxrate UAPI returns kbps.
+		 * print_rate() expects Bps for display.
+		 * convert kbps to Bps by multiplying 125.
+		 */
+		__u64 rate_bytes_per_sec  = maxrate->tc_maxrate[i] * 125;
+
 		snprintf(b, sizeof(b), "%zd:%%s ", i);
-		print_rate(dcb->use_iec, PRINT_ANY, NULL, b, maxrate->tc_maxrate[i]);
+		print_rate(dcb->use_iec, PRINT_ANY, NULL, b, rate_bytes_per_sec);
 	}
 
 	close_json_array(PRINT_JSON, "tc_maxrate");
-- 
2.50.1


