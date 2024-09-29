Return-Path: <netdev+bounces-130234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB1F9894C6
	for <lists+netdev@lfdr.de>; Sun, 29 Sep 2024 12:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D0C2812F1
	for <lists+netdev@lfdr.de>; Sun, 29 Sep 2024 10:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF00014F9FE;
	Sun, 29 Sep 2024 10:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b="HaxT2brK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4C4224F0
	for <netdev@vger.kernel.org>; Sun, 29 Sep 2024 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727605253; cv=none; b=VEz+ypr7DaabgL1MZsLqEBAV8rERtBPm/P2TBc6nMra7VIVcXnQXsJh0Kahp13ZI2heKy2Ar42Z882IwISraBSUaG7rdEDndTcJrcTTIXJgBoIYY+Tj+Ssff/IEb1mKPXxs+cbBSsrsgovZNJ1p+JZA1qI9Ux0xDVtxORlxiKXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727605253; c=relaxed/simple;
	bh=Rd4epX5lHZBaUPRHYhWjPuJduEMmdwqaQFLyEATZAlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LPG7v42RZsDcke8pYLClbqvQ14qbBX8wohBDPJ70NyV0uNL4exJMEmEOpW1P99zAzQ/9X25o+yGyFl9gO+wlsBNHXFNlBX/jr7V2xI+zaWcExeOsNnHislQOe58KFiZq++IujBIuSlx3Xz23/QV457YQyXkm3T+rUgqEhZB/lo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info; spf=pass smtp.mailfrom=shenghaoyang.info; dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b=HaxT2brK; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shenghaoyang.info
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2dbde420d15so399865a91.3
        for <netdev@vger.kernel.org>; Sun, 29 Sep 2024 03:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenghaoyang.info; s=google; t=1727605251; x=1728210051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTe5Q1sUb4C/XZoppsAdlKd5S+bDT2a46Q521opqqHU=;
        b=HaxT2brK5Zlophj21NDjMD7AJOCkzCZ0eF48EQj3hcWXg9cspDAWavfCOq5IMSXIWd
         c7oSm5TlL94scnMpz8MhTAWn3/eW/fsquq7NUg6LF/Agu+3kTsGiZthKP2FM1kQOFb5s
         1u+/Zq4CXsFfFnyxJvVjW6QHE/JAHrS4JqYTo0D2fEHtn0N9Cxu69KljvoyQ0HOkRph/
         QmU47kmFyQnqTBZdIcDCS3Z7Wke4rWb3uzbw5sI2sNvY7OtXxPLwYrsYn4ZkhFejHDSa
         NS/O4AghRucxtBl5NY+rA2o0zptK/jkBBMR6salQ3fBhgukxlt2k2JGMyYAFs/DB4WkN
         xoEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727605251; x=1728210051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pTe5Q1sUb4C/XZoppsAdlKd5S+bDT2a46Q521opqqHU=;
        b=HvzsUdylqkJ7tObO2lyqGbbmmKHh0fiMgSjEYb7IazJaxPVRPpdMhlibDGOONHcq19
         Tiiel0ESMVqvbWlAsiamziFnAfYg4nMrFwKiY0jCGB4EZS2m1t7BrGUuIgZmlv9rd3ht
         aC14kJWg2Ri+A6bG3e1BHKuEzWhZKlnVjfn/xwaUJf6xd5z/P0XWtDIRwn4o8hEq1r98
         Fp3/tFlg0cERiF6F7ggwy0R9nzfUqYEpEqa0Nm5OG0vQCflhwneh03gkMb0uBMs91fUd
         qs6592NpbVcB45wzlOMJ+8RrKc+mbPW7Prv0GkHB5ASdgm7mJHeX9kUUevsxg3u1t/+v
         d4hA==
X-Gm-Message-State: AOJu0YxxlH29nVkA0kMRYEzrDT4Tm/GBVmhSW98pgoAQrEf14gOuBJJy
	+kjN+E/+BcTbg+1mAP9hcK0cU710m9wOQAuRGFUc1d3bueK2iyL7HQZLcKZQDraKzRJrpzIOjcy
	PS6kN5Q==
X-Google-Smtp-Source: AGHT+IFEehK7OzZYqRGc1110QuW0UCeDilriVKvJeteQhnSeE3YFUNWRnv8Z4T6ImYOsvOEoSxUGEg==
X-Received: by 2002:a05:6a20:8420:b0:1d4:f5e4:6a9a with SMTP id adf61e73a8af0-1d4fa810412mr5594672637.12.1727605251432;
        Sun, 29 Sep 2024 03:20:51 -0700 (PDT)
Received: from localhost ([132.147.84.99])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7e6db2c8704sm4580583a12.52.2024.09.29.03.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Sep 2024 03:20:51 -0700 (PDT)
From: Shenghao Yang <me@shenghaoyang.info>
To: netdev@vger.kernel.org
Cc: Shenghao Yang <me@shenghaoyang.info>,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	pavana.sharma@digi.com,
	ashkan.boldaji@digi.com,
	kabel@kernel.org,
	andrew@lunn.ch
Subject: [PATCH net 3/3] net: dsa: mv88e6xxx: support 4000ps cycle counter period
Date: Sun, 29 Sep 2024 18:19:48 +0800
Message-ID: <20240929101949.723658-5-me@shenghaoyang.info>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240929101949.723658-1-me@shenghaoyang.info>
References: <20240929101949.723658-1-me@shenghaoyang.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MV88E6393X family of devices can run its cycle counter off
an internal 250MHz clock instead of an external 125MHz one.

Add support for this cycle counter period by adding another set
of coefficients and lowering the periodic cycle counter read interval
to compensate for faster overflows at the increased frequency.

Otherwise, the PHC runs at 2x real time in userspace and cannot be
synchronized.

Fixes: de776d0d316f ("net: dsa: mv88e6xxx: add support for mv88e6393x family")
Signed-off-by: Shenghao Yang <me@shenghaoyang.info>
---
 drivers/net/dsa/mv88e6xxx/ptp.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index be1fcbf75440..6a88895845ea 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -39,7 +39,7 @@ const struct mv88e6xxx_cc_coeffs mv88e6xxx_cc_10ns_coeffs = {
 	.cc_mult_dem = 3125ULL,
 };
 
-/* Other families:
+/* Other families except MV88E6393X in internal clock mode:
  * Raw timestamps are in units of 8-ns clock periods.
  *
  * clkadj = scaled_ppm * 8*2^28 / (10^6 * 2^16)
@@ -53,6 +53,20 @@ const struct mv88e6xxx_cc_coeffs mv88e6xxx_cc_8ns_coeffs = {
 	.cc_mult_dem = 15625ULL
 };
 
+/* Family MV88E6393X using internal clock:
+ * Raw timestamps are in units of 4-ns clock periods.
+ *
+ * clkadj = scaled_ppm * 4*2^28 / (10^6 * 2^16)
+ * simplifies to
+ * clkadj = scaled_ppm * 2^8 / 5^6
+ */
+const struct mv88e6xxx_cc_coeffs mv88e6xxx_cc_4ns_coeffs = {
+	.cc_shift = 28,
+	.cc_mult = 4 << 28,
+	.cc_mult_num = 1 << 8,
+	.cc_mult_dem = 15625ULL
+};
+
 #define TAI_EVENT_WORK_INTERVAL msecs_to_jiffies(100)
 
 #define cc_to_chip(cc) container_of(cc, struct mv88e6xxx_chip, tstamp_cc)
@@ -107,6 +121,8 @@ mv88e6xxx_cc_coeff_get(struct mv88e6xxx_chip *chip)
 	}
 
 	switch (period_ps) {
+	case 4000:
+		return &mv88e6xxx_cc_4ns_coeffs;
 	case 8000:
 		return &mv88e6xxx_cc_8ns_coeffs;
 	case 10000:
@@ -484,10 +500,10 @@ static u64 mv88e6xxx_ptp_clock_read(const struct cyclecounter *cc)
 	return 0;
 }
 
-/* With a 125MHz input clock, the 32-bit timestamp counter overflows in ~34.3
+/* With a 250MHz input clock, the 32-bit timestamp counter overflows in ~17.2
  * seconds; this task forces periodic reads so that we don't miss any.
  */
-#define MV88E6XXX_TAI_OVERFLOW_PERIOD (HZ * 16)
+#define MV88E6XXX_TAI_OVERFLOW_PERIOD (HZ * 8)
 static void mv88e6xxx_ptp_overflow_check(struct work_struct *work)
 {
 	struct delayed_work *dw = to_delayed_work(work);
-- 
2.46.1


