Return-Path: <netdev+bounces-132499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA37991F36
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 17:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D19DA2829D6
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 15:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA2B136672;
	Sun,  6 Oct 2024 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b="ZbhO5RzE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05882482EF
	for <netdev@vger.kernel.org>; Sun,  6 Oct 2024 15:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728226830; cv=none; b=CRys5f3EjedJ06Qa6yXEhTZE6TUFlcJGRZk1tzMsM50mINBONpLgZkk9Tq5JTkSCj8Cl5J8Y5BzQ99rwuAp3AShdshDPx6a6lH1ntTx3k7SHgC7PAICYVy+S0fLM54tPqIx8rbJTcYlZzoAt1xMMCJA0jo3xTOEPNtmJma7StY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728226830; c=relaxed/simple;
	bh=n+yeDmQjSX5mGH3d/n7Wj1sP49IccgXphZJzEdRgJ2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tabXo+EZx+b0GomB0jJw0eKRjG9BuyRpihjqNCEwy2fxxCc3LLlWovK2Kwl5lv5IC/u4/8wFhuLjbmZBphfMQExhkn4pd5cVEQ6vIqk8bGnSaBhZrdQ739XV0jejjjLOReVLW6z/tLeicr7Wf1CNo+04QWbfxlzoIG4zTmYPph4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info; spf=pass smtp.mailfrom=shenghaoyang.info; dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b=ZbhO5RzE; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shenghaoyang.info
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7e9f8714b9bso99133a12.3
        for <netdev@vger.kernel.org>; Sun, 06 Oct 2024 08:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenghaoyang.info; s=google; t=1728226828; x=1728831628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4w60b7/GOYUxjBDyS6fctkzP4h/Je4fWr1JC8x965U=;
        b=ZbhO5RzETSpDp6kxxdh5rqqVD21rIxL1SNqErYAqmlnAbWyfDzRz9Qqpbmbm2IzOkx
         JTB0TfDPxQW28BTmkozex+QtENlfc4Wah/Q12uAyWZKikl02oKO0ji6buYWCFZgbeDC3
         Ni1T9fxlD0MUVJoYmIMyeaZ1J6BjI+Vk49VUJiT+fOqoa+3UgpmVkC6gR/pHTKe02pwz
         vNhQgVoBKM8OoY0L/3O+02jeuJCKDghZuAI7d1xkwlMv0TbA/4eaWYMyDeSCaOIwTnMA
         tKR11jPNN5sPE4Wo6Rz6at7xDfL/lSMOgaarxo1ckMn5aS96U+IQYGsffjFrPmCr6X9F
         vdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728226828; x=1728831628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4w60b7/GOYUxjBDyS6fctkzP4h/Je4fWr1JC8x965U=;
        b=JHCoFDTyWS5/EwL1zZz6rBk3yKs4zmy13pezSlF8h6LXyMNgzkGj7dxAZsj49fh7Bl
         BFtqVBFkvFBeg1yAjKVheK67N5gr6M4HLGexXIgn1KlqXB9hVLTd86x5JRmMAV/Td5Qd
         uVluBoarIWr7c9p3Z2aAwrD3/86ii0h8mqQkNvEhrCTVH8t0W1NjoENRBQiXxYvSLXAV
         fYB3QMUBzl5LUaG/6xffI6jvFXQmGGQ/G7SsdYnqnJxCHTgwguOJwGO+x8YVnNlK2tT+
         JMKk2Tn3ua4HFnwEpjs/71l2kvQ3KeWzy+Go44fi/7oMsvqLbEEw4moUr+sRR7I8Zoa2
         4/ow==
X-Gm-Message-State: AOJu0YyflE4f5tDH7jfumGzal9QE5fw1xgOV2RHByRvqueY+YmLwcNC5
	u4+YbeDyPuntD2dLxgx8F/3caKeFwA4eZcOcWqx2YCQG3KXKS1RDkay3+XQhHO2cWvRwRn5e1Cc
	ggKci2g==
X-Google-Smtp-Source: AGHT+IFf9lKbWrvCvbqkbQHjI6qNKs4tHwPOKb9Wg5dN9nm0QT+DAr8C/OenH+eIe1SVWHKlattCZA==
X-Received: by 2002:a17:902:e882:b0:20b:9822:66fe with SMTP id d9443c01a7336-20bfe01e37bmr57435785ad.1.1728226827712;
        Sun, 06 Oct 2024 08:00:27 -0700 (PDT)
Received: from localhost ([132.147.84.99])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-20c13934817sm26050435ad.158.2024.10.06.08.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2024 08:00:27 -0700 (PDT)
From: Shenghao Yang <me@shenghaoyang.info>
To: netdev@vger.kernel.org
Cc: Shenghao Yang <me@shenghaoyang.info>,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	pavana.sharma@digi.com,
	ashkan.boldaji@digi.com,
	kabel@kernel.org,
	andrew@lunn.ch
Subject: [PATCH net v2 2/3] net: dsa: mv88e6xxx: read cycle counter period from hardware
Date: Sun,  6 Oct 2024 22:59:46 +0800
Message-ID: <20241006145951.719162-3-me@shenghaoyang.info>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241006145951.719162-1-me@shenghaoyang.info>
References: <20241006145951.719162-1-me@shenghaoyang.info>
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
 drivers/net/dsa/mv88e6xxx/chip.h |  5 ++-
 drivers/net/dsa/mv88e6xxx/ptp.c  | 60 ++++++++++++++++++++++----------
 2 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index bd66189a593f..a54682240839 100644
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
@@ -733,7 +733,6 @@ struct mv88e6xxx_ptp_ops {
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
2.46.2


