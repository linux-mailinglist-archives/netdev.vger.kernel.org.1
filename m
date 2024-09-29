Return-Path: <netdev+bounces-130233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 068EA9894C5
	for <lists+netdev@lfdr.de>; Sun, 29 Sep 2024 12:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F57DB21EBF
	for <lists+netdev@lfdr.de>; Sun, 29 Sep 2024 10:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6B014F9EF;
	Sun, 29 Sep 2024 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b="O7C2/eDJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B397224F0
	for <netdev@vger.kernel.org>; Sun, 29 Sep 2024 10:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727605233; cv=none; b=CP1f5EzbUBarbgElAyaqNopLAtVvvuW4MU9KxOq81KeVXYp/AhvF+Af39ogzpi99udtCWAJ4GWD+Hgw3kkmRnQfpaL7bBnDXHglY41x955HLgNMGHuForUokjjOrtLsePnwlwqTeR+Afgw4AtZXye7WdoU0SKFZ3szBVo7bD3TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727605233; c=relaxed/simple;
	bh=bWXKKukUfDGLBgNDgbpCIaFxSPIh/iK7KL0Fw7uPr3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4MMun/zlHlGKqt4yYmXSLGYEyK9TzpVODYDNZe1RAAOI2AO1Q0gO+OmXbMt2NDOe10dUa66/pVIqgqcfyUvVv+j4aaM92wVk3PC1Gk+dkbuHxq1juOvREgpLBhwxK1mqE8y7JHKf8KSwslEe+1DnPGZcq2LMLBl/KprEJAvc2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info; spf=pass smtp.mailfrom=shenghaoyang.info; dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b=O7C2/eDJ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shenghaoyang.info
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20b2ee7629fso3989695ad.3
        for <netdev@vger.kernel.org>; Sun, 29 Sep 2024 03:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenghaoyang.info; s=google; t=1727605231; x=1728210031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlFsh9kD8OU170rOMeLdTnYu0mvAnIYzA5x2ABPdqNc=;
        b=O7C2/eDJkrtnHJpN2MdfV7coKWBhwUJ8rx49INutbA2pJ+yKktUrfjMbfuslg7bJMR
         oN0h+cOu5GXETG5FC9g5VKA+6fE702NnJp0fTTwMhALC3Qhp62Mc4fn8d9EIys+omcGX
         mJCeh9QJs7ztJE9qza0KCEd9w5fOzVDjZlrCZQFhWl/Yr41ooI7G2MIj6qCn/iCeCsmf
         C4iOzIOL5WEkYSFh91+xuh75lGj5IVSEFGcFUfw5Cf1XwG/qOmUf6iAq1MIMDc2oOwxb
         BwZwbwGASeoJXp9fGFLjA0Q570Mva71HWKhQrbO2YS1MRuNklPBbei1KHqHQsM9hQEGn
         YQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727605231; x=1728210031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hlFsh9kD8OU170rOMeLdTnYu0mvAnIYzA5x2ABPdqNc=;
        b=ovJM+APNhvNEE2QIpzceeiurSutfAEIAjcfm2xpd8U9nKpfh0A4vTMfLL0/v0gE6L/
         64TCQ1wn4aBX5oWNTbI8qq97RoR12QFRWE6btlALCYvaEQ97MIWcuFI6Ren7RLcqP3t9
         TdBvwbIkRJnNe26IQUZwetq2tWN8YuUYkvCwVFilSPiaJxorw9tJXT9fYsG/gywM6Nwd
         SUx5kCrVWj1VH7irSvp3DzDjHOUnn4/TrB04nKcXNuMUIT0ACYmbD4QcVUro1zGuSzyE
         +DT7LwQ3VlsJ5Y00j7t2clLOgrHgOL02MLdOFYSppo6lLWeGgVOm6oM+6tSerqVDFnmd
         exiQ==
X-Gm-Message-State: AOJu0YwaaXy+CN/Y3B4SFWU9IQ3XMRQRHguNdJJb+ylLwSfUy1vUVMjJ
	54+FlVotjy5rKFBJWMTATGEvaH0pmvwjv3LQodsSwF9FllnYiFpbj0DJ23SeA1FP26QM97+FmuS
	IFXvpoQ==
X-Google-Smtp-Source: AGHT+IHvaM7deSJ09FJnirqvheexG43P/dcsJ0PcV/AzOKYDEqnVkX04i4h6LGvTwb+4wMNMQbsuSg==
X-Received: by 2002:a17:902:da92:b0:20b:21ed:96e3 with SMTP id d9443c01a7336-20b578e42bcmr28213225ad.6.1727605231050;
        Sun, 29 Sep 2024 03:20:31 -0700 (PDT)
Received: from localhost ([132.147.84.99])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-20b37d90c52sm37848155ad.86.2024.09.29.03.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Sep 2024 03:20:30 -0700 (PDT)
From: Shenghao Yang <me@shenghaoyang.info>
To: netdev@vger.kernel.org
Cc: Shenghao Yang <me@shenghaoyang.info>,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	pavana.sharma@digi.com,
	ashkan.boldaji@digi.com,
	kabel@kernel.org,
	andrew@lunn.ch
Subject: [PATCH net 2/3] net: dsa: mv88e6xxx: read cycle counter period from hardware
Date: Sun, 29 Sep 2024 18:19:46 +0800
Message-ID: <20240929101949.723658-3-me@shenghaoyang.info>
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

Instead of relying on a fixed mapping of hardware family to cycle
counter frequency, pull this information from the
MV88E6XXX_TAI_CLOCK_PERIOD register.

This lets us support switches with whose cycle counter frequencies
depend on board design.

Hardware with inaccessible clock period registers or unsupported periods
will fall back to the fixed mapping.

Fixes: de776d0d316f ("net: dsa: mv88e6xxx: add support for mv88e6393x family")
Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Shenghao Yang <me@shenghaoyang.info>
---
 drivers/net/dsa/mv88e6xxx/chip.h |  6 ++--
 drivers/net/dsa/mv88e6xxx/ptp.c  | 48 ++++++++++++++++++++++++--------
 2 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index bd66189a593f..8ff3f15e0d01 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -206,6 +206,7 @@ struct mv88e6xxx_gpio_ops;
 struct mv88e6xxx_avb_ops;
 struct mv88e6xxx_ptp_ops;
 struct mv88e6xxx_pcs_ops;
+struct mv88e6xxx_cc_coeffs;
 
 struct mv88e6xxx_irq {
 	u16 masked;
@@ -408,6 +409,7 @@ struct mv88e6xxx_chip {
 	struct cyclecounter	tstamp_cc;
 	struct timecounter	tstamp_tc;
 	struct delayed_work	overflow_work;
+	const struct mv88e6xxx_cc_coeffs *cc_coeffs;
 
 	struct ptp_clock	*ptp_clock;
 	struct ptp_clock_info	ptp_clock_info;
@@ -714,8 +716,6 @@ struct mv88e6xxx_avb_ops {
 	int (*tai_write)(struct mv88e6xxx_chip *chip, int addr, u16 data);
 };
 
-struct mv88e6xxx_cc_coeffs;
-
 struct mv88e6xxx_ptp_ops {
 	u64 (*clock_read)(const struct cyclecounter *cc);
 	int (*ptp_enable)(struct ptp_clock_info *ptp,
@@ -733,7 +733,7 @@ struct mv88e6xxx_ptp_ops {
 	int arr1_sts_reg;
 	int dep_sts_reg;
 	u32 rx_filters;
-	const struct mv88e6xxx_cc_coeffs *cc_coeffs;
+	const struct mv88e6xxx_cc_coeffs *default_cc_coeffs;
 };
 
 struct mv88e6xxx_pcs_ops {
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index 89040c9af9f3..be1fcbf75440 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -32,7 +32,7 @@ struct mv88e6xxx_cc_coeffs {
  * simplifies to
  * clkadj = scaled_ppm * 2^7 / 5^5
  */
-const struct mv88e6xxx_cc_coeffs mv88e6250_cc_coeffs = {
+const struct mv88e6xxx_cc_coeffs mv88e6xxx_cc_10ns_coeffs = {
 	.cc_shift = 28,
 	.cc_mult = 10 << 28,
 	.cc_mult_num = 1 << 7,
@@ -46,7 +46,7 @@ const struct mv88e6xxx_cc_coeffs mv88e6250_cc_coeffs = {
  * simplifies to
  * clkadj = scaled_ppm * 2^9 / 5^6
  */
-const struct mv88e6xxx_cc_coeffs mv88e6xxx_cc_coeffs = {
+const struct mv88e6xxx_cc_coeffs mv88e6xxx_cc_8ns_coeffs = {
 	.cc_shift = 28,
 	.cc_mult = 8 << 28,
 	.cc_mult_num = 1 << 9,
@@ -94,6 +94,30 @@ static int mv88e6352_set_gpio_func(struct mv88e6xxx_chip *chip, int pin,
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
+		dev_warn(chip->dev, "failed to read cycle counter period");
+		return chip->info->ops->ptp_ops->default_cc_coeffs;
+	}
+
+	switch (period_ps) {
+	case 8000:
+		return &mv88e6xxx_cc_8ns_coeffs;
+	case 10000:
+		return &mv88e6xxx_cc_10ns_coeffs;
+	default:
+		dev_warn(chip->dev, "unexpected cycle counter period of %u ps",
+			 period_ps);
+		return chip->info->ops->ptp_ops->default_cc_coeffs;
+	}
+}
+
 static u64 mv88e6352_ptp_clock_read(const struct cyclecounter *cc)
 {
 	struct mv88e6xxx_chip *chip = cc_to_chip(cc);
@@ -215,7 +239,6 @@ static void mv88e6352_tai_event_work(struct work_struct *ugly)
 static int mv88e6xxx_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 {
 	struct mv88e6xxx_chip *chip = ptp_to_chip(ptp);
-	const struct mv88e6xxx_ptp_ops *ptp_ops = chip->info->ops->ptp_ops;
 	int neg_adj = 0;
 	u32 diff, mult;
 	u64 adj;
@@ -225,10 +248,10 @@ static int mv88e6xxx_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
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
 
@@ -375,7 +398,7 @@ const struct mv88e6xxx_ptp_ops mv88e6165_ptp_ops = {
 		(1 << HWTSTAMP_FILTER_PTP_V2_EVENT) |
 		(1 << HWTSTAMP_FILTER_PTP_V2_SYNC) |
 		(1 << HWTSTAMP_FILTER_PTP_V2_DELAY_REQ),
-	.cc_coeffs = &mv88e6xxx_cc_coeffs
+	.default_cc_coeffs = &mv88e6xxx_cc_8ns_coeffs
 };
 
 const struct mv88e6xxx_ptp_ops mv88e6250_ptp_ops = {
@@ -399,7 +422,7 @@ const struct mv88e6xxx_ptp_ops mv88e6250_ptp_ops = {
 		(1 << HWTSTAMP_FILTER_PTP_V2_EVENT) |
 		(1 << HWTSTAMP_FILTER_PTP_V2_SYNC) |
 		(1 << HWTSTAMP_FILTER_PTP_V2_DELAY_REQ),
-	.cc_coeffs = &mv88e6250_cc_coeffs,
+	.default_cc_coeffs = &mv88e6xxx_cc_10ns_coeffs,
 };
 
 const struct mv88e6xxx_ptp_ops mv88e6352_ptp_ops = {
@@ -423,7 +446,7 @@ const struct mv88e6xxx_ptp_ops mv88e6352_ptp_ops = {
 		(1 << HWTSTAMP_FILTER_PTP_V2_EVENT) |
 		(1 << HWTSTAMP_FILTER_PTP_V2_SYNC) |
 		(1 << HWTSTAMP_FILTER_PTP_V2_DELAY_REQ),
-	.cc_coeffs = &mv88e6xxx_cc_coeffs,
+	.default_cc_coeffs = &mv88e6xxx_cc_8ns_coeffs,
 };
 
 const struct mv88e6xxx_ptp_ops mv88e6390_ptp_ops = {
@@ -448,7 +471,7 @@ const struct mv88e6xxx_ptp_ops mv88e6390_ptp_ops = {
 		(1 << HWTSTAMP_FILTER_PTP_V2_EVENT) |
 		(1 << HWTSTAMP_FILTER_PTP_V2_SYNC) |
 		(1 << HWTSTAMP_FILTER_PTP_V2_DELAY_REQ),
-	.cc_coeffs = &mv88e6xxx_cc_coeffs,
+	.default_cc_coeffs = &mv88e6xxx_cc_8ns_coeffs,
 };
 
 static u64 mv88e6xxx_ptp_clock_read(const struct cyclecounter *cc)
@@ -483,11 +506,12 @@ int mv88e6xxx_ptp_setup(struct mv88e6xxx_chip *chip)
 	int i;
 
 	/* Set up the cycle counter */
+	chip->cc_coeffs = mv88e6xxx_cc_coeff_get(chip);
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
2.46.1


