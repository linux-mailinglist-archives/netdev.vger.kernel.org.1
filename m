Return-Path: <netdev+bounces-137256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E929A52E8
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 08:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4F61F223EE
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 06:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEDC182BC;
	Sun, 20 Oct 2024 06:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b="PXA2PPaL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A7117C9E
	for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 06:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729406351; cv=none; b=Yd1xE3INMrzQ+78HunEOQYvE+lcm8+YZLkYoptSYbH1EmUhOCPQKM9cVqL8OpwjDviaOqW2x1aH5QU16Hf333zdh827Oy3T0sRKhQn+ve3zsVtAa3S95tpmyQuRlDXFy96Fo/JgXB+Wc4k8qSgN1mxa1eG6Vi60hklW5zOhGelE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729406351; c=relaxed/simple;
	bh=9EzG27aDSsMQNFL50LEYcI1/U0LHkOAANLg23dwNkX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TUTx475EnJlHAz7hvzdyC+p550m+TFRXhPmAkqpX7vzCbaH6rV7IJxeX9rcG6Bqg5KeBD2IgOAONw4FdLtK1G5VVmutLLaQL2IOKDKAqhrSwHZ3yDidHLXN/xg5kZqMFeR99PYs2RFzj+okjI3Fwy6h/FoQCEqV06U1Ep2aq7as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info; spf=pass smtp.mailfrom=shenghaoyang.info; dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b=PXA2PPaL; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shenghaoyang.info
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c804409b0so3247965ad.2
        for <netdev@vger.kernel.org>; Sat, 19 Oct 2024 23:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenghaoyang.info; s=google; t=1729406348; x=1730011148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TwMk5pW/b5ZopgEmo1neAnp4jbPKklCTczX4aOTIv0=;
        b=PXA2PPaLnf5lCgtvoKZR++SFqmHBP1eB15epbZFgTwqPF1dMST0GV7SdmQJG02z/2b
         i+QpqQZ+muF4QdHafNWdJcMaQ5s9W9OqTnr0BM+k8/2gw1i56N+fECDYUQ01yIFmKUyA
         BbPlUNA5KY3QHjIyrtsj0beBUyi8tWZUDeLkTtn5wrjCtNPOIldYy6ZbZmo9Lkg6S3vT
         +8ElcT4WgbQcFusDLlbrGmL+NhOaF3nqjhrccMx1/J9YcWe0e7zV4eYhjE9aYcN1O0WC
         TE8lYRkH1SJeOU3h/veQ3v35P9KcQdudB8as/RIKiaagTwe5RcZ2ilG843G/GxYaCgnp
         2jjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729406348; x=1730011148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TwMk5pW/b5ZopgEmo1neAnp4jbPKklCTczX4aOTIv0=;
        b=De8/bd6kGUPtxbL0SM43WytnhErzekWzz8qoiMfW0eV1A9k/AitRulUJrAeQ3rEFxU
         FUtMKFoppJeMboClPh22dQIdmvozDOfA26WwgDd4SMJBOPeKPiRWrHBCrRXfdPZl0XZL
         mcI41a9z+e7opARnBe1ON6jbcHgSVMl6C6OCmf+9tVU9C9oi74UG9EA/VXG10/XuX/TP
         9A9apFF5cZXMjxMeqAzav0sod06QZZAhyUIXgnSpArelfLcPInLnm2FPemyI9q3zXOTd
         WyE7dSzc7ui0RNII0xeCpdUCZ5k/5QYdUXabAmUOdNTJcxTtz4Q+5q/uydliXA3qL3Wl
         KEPg==
X-Gm-Message-State: AOJu0YwXNaLvh0WWzZtIToLD/M9UgmBrkg08YiQIwu5iAOUi+80BoOGb
	w0Sv12EEW7tZxMKYdIgVaejlYqZZg9NvbYthozDJeDpLHv3lUxGdoTnrwPkRI8hmFRWXOVmPspc
	xJ3o=
X-Google-Smtp-Source: AGHT+IFYVv+B2FfXCysoJzCH0knY2rO7np6DqL3/tPkb9CS/ABJ8/7zFem9Qo4tX4OIYARI1eZ4IdA==
X-Received: by 2002:a17:902:d4c8:b0:20c:c482:1d6d with SMTP id d9443c01a7336-20e5a93fa83mr39761145ad.8.1729406348154;
        Sat, 19 Oct 2024 23:39:08 -0700 (PDT)
Received: from localhost ([132.147.84.99])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-20e7ef21d3bsm5787065ad.107.2024.10.19.23.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Oct 2024 23:39:07 -0700 (PDT)
From: Shenghao Yang <me@shenghaoyang.info>
To: netdev@vger.kernel.org
Cc: Shenghao Yang <me@shenghaoyang.info>,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	pavana.sharma@digi.com,
	ashkan.boldaji@digi.com,
	kabel@kernel.org,
	andrew@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	kuba@kernel.org
Subject: [PATCH net v3 2/3] net: dsa: mv88e6xxx: read cycle counter period from hardware
Date: Sun, 20 Oct 2024 14:38:29 +0800
Message-ID: <20241020063833.5425-3-me@shenghaoyang.info>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241020063833.5425-1-me@shenghaoyang.info>
References: <20241020063833.5425-1-me@shenghaoyang.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of relying on a fixed mapping of hardware family to cycle
counter frequency, pull this information from the
MV88E6XXX_TAI_CLOCK_PERIOD register.

This lets us support switches whose cycle counter frequencies depend on
board design.

Fixes: de776d0d316f ("net: dsa: mv88e6xxx: add support for mv88e6393x family")
Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Shenghao Yang <me@shenghaoyang.info>
---
 drivers/net/dsa/mv88e6xxx/chip.h |  2 +-
 drivers/net/dsa/mv88e6xxx/ptp.c  | 60 ++++++++++++++++++++++----------
 2 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 1d003a9deafa..a54682240839 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -409,6 +409,7 @@ struct mv88e6xxx_chip {
 	struct cyclecounter	tstamp_cc;
 	struct timecounter	tstamp_tc;
 	struct delayed_work	overflow_work;
+	const struct mv88e6xxx_cc_coeffs *cc_coeffs;
 
 	struct ptp_clock	*ptp_clock;
 	struct ptp_clock_info	ptp_clock_info;
@@ -732,7 +733,6 @@ struct mv88e6xxx_ptp_ops {
 	int arr1_sts_reg;
 	int dep_sts_reg;
 	u32 rx_filters;
-	const struct mv88e6xxx_cc_coeffs *cc_coeffs;
 };
 
 struct mv88e6xxx_pcs_ops {
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index 641af44e00af..a409b8661fad 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -32,10 +32,10 @@ struct mv88e6xxx_cc_coeffs {
  * simplifies to
  * clkadj = scaled_ppm * 2^7 / 5^5
  */
-#define MV88E6250_CC_SHIFT 28
-static const struct mv88e6xxx_cc_coeffs mv88e6250_cc_coeffs = {
-	.cc_shift = MV88E6250_CC_SHIFT,
-	.cc_mult = 10 << MV88E6250_CC_SHIFT,
+#define MV88E6XXX_CC_10NS_SHIFT 28
+static const struct mv88e6xxx_cc_coeffs mv88e6xxx_cc_10ns_coeffs = {
+	.cc_shift = MV88E6XXX_CC_10NS_SHIFT,
+	.cc_mult = 10 << MV88E6XXX_CC_10NS_SHIFT,
 	.cc_mult_num = 1 << 7,
 	.cc_mult_dem = 3125ULL,
 };
@@ -47,10 +47,10 @@ static const struct mv88e6xxx_cc_coeffs mv88e6250_cc_coeffs = {
  * simplifies to
  * clkadj = scaled_ppm * 2^9 / 5^6
  */
-#define MV88E6XXX_CC_SHIFT 28
-static const struct mv88e6xxx_cc_coeffs mv88e6xxx_cc_coeffs = {
-	.cc_shift = MV88E6XXX_CC_SHIFT,
-	.cc_mult = 8 << MV88E6XXX_CC_SHIFT,
+#define MV88E6XXX_CC_8NS_SHIFT 28
+static const struct mv88e6xxx_cc_coeffs mv88e6xxx_cc_8ns_coeffs = {
+	.cc_shift = MV88E6XXX_CC_8NS_SHIFT,
+	.cc_mult = 8 << MV88E6XXX_CC_8NS_SHIFT,
 	.cc_mult_num = 1 << 9,
 	.cc_mult_dem = 15625ULL
 };
@@ -96,6 +96,31 @@ static int mv88e6352_set_gpio_func(struct mv88e6xxx_chip *chip, int pin,
 	return chip->info->ops->gpio_ops->set_pctl(chip, pin, func);
 }
 
+static const struct mv88e6xxx_cc_coeffs *
+mv88e6xxx_cc_coeff_get(struct mv88e6xxx_chip *chip)
+{
+	u16 period_ps;
+	int err;
+
+	err = mv88e6xxx_tai_read(chip, MV88E6XXX_TAI_CLOCK_PERIOD, &period_ps, 1);
+	if (err) {
+		dev_err(chip->dev, "failed to read cycle counter period: %d\n",
+			err);
+		return ERR_PTR(err);
+	}
+
+	switch (period_ps) {
+	case 8000:
+		return &mv88e6xxx_cc_8ns_coeffs;
+	case 10000:
+		return &mv88e6xxx_cc_10ns_coeffs;
+	default:
+		dev_err(chip->dev, "unexpected cycle counter period of %u ps\n",
+			period_ps);
+		return ERR_PTR(-ENODEV);
+	}
+}
+
 static u64 mv88e6352_ptp_clock_read(const struct cyclecounter *cc)
 {
 	struct mv88e6xxx_chip *chip = cc_to_chip(cc);
@@ -217,7 +242,6 @@ static void mv88e6352_tai_event_work(struct work_struct *ugly)
 static int mv88e6xxx_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 {
 	struct mv88e6xxx_chip *chip = ptp_to_chip(ptp);
-	const struct mv88e6xxx_ptp_ops *ptp_ops = chip->info->ops->ptp_ops;
 	int neg_adj = 0;
 	u32 diff, mult;
 	u64 adj;
@@ -227,10 +251,10 @@ static int mv88e6xxx_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 		scaled_ppm = -scaled_ppm;
 	}
 
-	mult = ptp_ops->cc_coeffs->cc_mult;
-	adj = ptp_ops->cc_coeffs->cc_mult_num;
+	mult = chip->cc_coeffs->cc_mult;
+	adj = chip->cc_coeffs->cc_mult_num;
 	adj *= scaled_ppm;
-	diff = div_u64(adj, ptp_ops->cc_coeffs->cc_mult_dem);
+	diff = div_u64(adj, chip->cc_coeffs->cc_mult_dem);
 
 	mv88e6xxx_reg_lock(chip);
 
@@ -377,7 +401,6 @@ const struct mv88e6xxx_ptp_ops mv88e6165_ptp_ops = {
 		(1 << HWTSTAMP_FILTER_PTP_V2_EVENT) |
 		(1 << HWTSTAMP_FILTER_PTP_V2_SYNC) |
 		(1 << HWTSTAMP_FILTER_PTP_V2_DELAY_REQ),
-	.cc_coeffs = &mv88e6xxx_cc_coeffs
 };
 
 const struct mv88e6xxx_ptp_ops mv88e6250_ptp_ops = {
@@ -401,7 +424,6 @@ const struct mv88e6xxx_ptp_ops mv88e6250_ptp_ops = {
 		(1 << HWTSTAMP_FILTER_PTP_V2_EVENT) |
 		(1 << HWTSTAMP_FILTER_PTP_V2_SYNC) |
 		(1 << HWTSTAMP_FILTER_PTP_V2_DELAY_REQ),
-	.cc_coeffs = &mv88e6250_cc_coeffs,
 };
 
 const struct mv88e6xxx_ptp_ops mv88e6352_ptp_ops = {
@@ -425,7 +447,6 @@ const struct mv88e6xxx_ptp_ops mv88e6352_ptp_ops = {
 		(1 << HWTSTAMP_FILTER_PTP_V2_EVENT) |
 		(1 << HWTSTAMP_FILTER_PTP_V2_SYNC) |
 		(1 << HWTSTAMP_FILTER_PTP_V2_DELAY_REQ),
-	.cc_coeffs = &mv88e6xxx_cc_coeffs,
 };
 
 const struct mv88e6xxx_ptp_ops mv88e6390_ptp_ops = {
@@ -450,7 +471,6 @@ const struct mv88e6xxx_ptp_ops mv88e6390_ptp_ops = {
 		(1 << HWTSTAMP_FILTER_PTP_V2_EVENT) |
 		(1 << HWTSTAMP_FILTER_PTP_V2_SYNC) |
 		(1 << HWTSTAMP_FILTER_PTP_V2_DELAY_REQ),
-	.cc_coeffs = &mv88e6xxx_cc_coeffs,
 };
 
 static u64 mv88e6xxx_ptp_clock_read(const struct cyclecounter *cc)
@@ -485,11 +505,15 @@ int mv88e6xxx_ptp_setup(struct mv88e6xxx_chip *chip)
 	int i;
 
 	/* Set up the cycle counter */
+	chip->cc_coeffs = mv88e6xxx_cc_coeff_get(chip);
+	if (IS_ERR(chip->cc_coeffs))
+		return PTR_ERR(chip->cc_coeffs);
+
 	memset(&chip->tstamp_cc, 0, sizeof(chip->tstamp_cc));
 	chip->tstamp_cc.read	= mv88e6xxx_ptp_clock_read;
 	chip->tstamp_cc.mask	= CYCLECOUNTER_MASK(32);
-	chip->tstamp_cc.mult	= ptp_ops->cc_coeffs->cc_mult;
-	chip->tstamp_cc.shift	= ptp_ops->cc_coeffs->cc_shift;
+	chip->tstamp_cc.mult	= chip->cc_coeffs->cc_mult;
+	chip->tstamp_cc.shift	= chip->cc_coeffs->cc_shift;
 
 	timecounter_init(&chip->tstamp_tc, &chip->tstamp_cc,
 			 ktime_to_ns(ktime_get_real()));
-- 
2.47.0


