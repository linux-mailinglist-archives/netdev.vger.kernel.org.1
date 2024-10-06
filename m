Return-Path: <netdev+bounces-132498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FBC0991F35
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 17:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D8B4281787
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 15:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6D913C689;
	Sun,  6 Oct 2024 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b="eBFB6RIa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21C213CAA5
	for <netdev@vger.kernel.org>; Sun,  6 Oct 2024 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728226824; cv=none; b=Zkx4Hdmd7qapSTqq0wdev9i7lOuo6L9mcMwJzJqaJXrTAuFUINAqVY4H3C0aBi6ilPXWky9Gw++qLpBhXa7zaHsQgZhf83eAJY1bdiwqtzFJo2rk5TqFu7KciIsZOCv+iFXnKMZ+rZQJFmwWQ+UgDGNmx+uwE1aMwpGH4rPsRlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728226824; c=relaxed/simple;
	bh=BQ3+x7prRAhV9koOkQQ9oUYR9knw4wBRGfKMaXWTuPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNjv1tLCLWwHzl4eCWts2n/uBGn+iqYAbZKv5r1Kqj0ztEWF9C6WLi5pAjWLJPmc5/I7ZS1bSiKq4FmtFL9iTcjxHCFIHhR6qFoKg+ezucOU5pdVkJnGU5y+Z1v6ISghRMqJmDZBW5PnXSR/Tv+U+bPD5WhM/CKdwavMiOUOcvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info; spf=pass smtp.mailfrom=shenghaoyang.info; dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b=eBFB6RIa; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shenghaoyang.info
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7e9f6f5e7f4so326654a12.0
        for <netdev@vger.kernel.org>; Sun, 06 Oct 2024 08:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenghaoyang.info; s=google; t=1728226822; x=1728831622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FH/e3ateqxO/a6OUBfkAYjN9XDz5yLwvblbB3O1Gjjo=;
        b=eBFB6RIafItQvZrUqUQrKYLutii9qO9ZmUjvOurr7BqW3pys53xJ6BITq9QhgBNY9p
         yX9cF+KfYe86pNW/E7qZJocd/qZdX9RQY/hWfsnkoemMcl0dpsLqzVw/IYiOFhuzdK76
         kee5AQVY7R+E2uyKqkhUXvg6eSYeQA282bCpA6hSVGKJrjhXQ2jytdQ5XtZ1rKHPy37l
         LP3LhX0bnXlFYcWdxw+7gyUVQEzGAl9+GL0oz/xjSr4lCgMG3I6TkbmvQPpmt4uI3PKc
         P9SFj9X0RUa1qJThvpFhgzAZ9QUlHAwXNSkPgU+CeQhiy2SRsenxAKn0w3AF0FOqnYdR
         DxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728226822; x=1728831622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FH/e3ateqxO/a6OUBfkAYjN9XDz5yLwvblbB3O1Gjjo=;
        b=dt0b78yAD96HLFICeeU4Atp2Er9KksCTyNEMOTgij/Z6zhZdcw9b+cHRpxccZmEI7Q
         eZ69/BmgTJ1tLxTuWv9Jdf2biZ6sAUa52JouzjVZW86aFV8cHsXcNPsQDrRAdJ1SOx59
         aNSyZrPwYm+O6YASV6fqHWWi1O4mnRc0cG4H8hJm41f6fY2PC0KCdqkMIBwtoPr+2B3L
         elssyKTExrjvJY8+ZWM+aBcuO3WwcFcnHhqeIOdznhQcAMPa1A9JDKeCidSeHgA/5m+w
         GoruuL1fprjZPeEoSgd8fe/Hp51tMB7VgWLWIpROErOrqzRgBaDxQxAx3rBnX2WyBGFK
         XG7Q==
X-Gm-Message-State: AOJu0Yxm5YK6GKq0xpuh/q5aFzxmxTll05xU/yktVpm8BfPCM5CBkuRW
	uTHldm5p9Ern/bT8TDSOM9ovzfAa6iR+FpDPOWm4X85V1HqvNCHQ8+mJD5ADIVzj4361jsJtbw4
	4xTMvtQ==
X-Google-Smtp-Source: AGHT+IHcopJlvv1lXq4RA99A0luVRShdhujwAad6K1v+GY7kCJJJKYbUYsLb6NVvlMH7kYIZM1A9gA==
X-Received: by 2002:a17:903:190:b0:205:9112:6c38 with SMTP id d9443c01a7336-20bff049a65mr52460745ad.10.1728226821633;
        Sun, 06 Oct 2024 08:00:21 -0700 (PDT)
Received: from localhost ([132.147.84.99])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-20c1396cf8dsm26040945ad.229.2024.10.06.08.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2024 08:00:21 -0700 (PDT)
From: Shenghao Yang <me@shenghaoyang.info>
To: netdev@vger.kernel.org
Cc: Shenghao Yang <me@shenghaoyang.info>,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	pavana.sharma@digi.com,
	ashkan.boldaji@digi.com,
	kabel@kernel.org,
	andrew@lunn.ch
Subject: [PATCH net v2 1/3] net: dsa: mv88e6xxx: group cycle counter coefficients
Date: Sun,  6 Oct 2024 22:59:45 +0800
Message-ID: <20241006145951.719162-2-me@shenghaoyang.info>
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

Instead of having them as individual fields in ptp_ops, wrap the
coefficients in a separate struct so they can be referenced together.

Fixes: de776d0d316f ("net: dsa: mv88e6xxx: add support for mv88e6393x family")
Signed-off-by: Shenghao Yang <me@shenghaoyang.info>
---
 drivers/net/dsa/mv88e6xxx/chip.h |  7 ++--
 drivers/net/dsa/mv88e6xxx/ptp.c  | 59 ++++++++++++++++----------------
 2 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index c34caf9815c5..bd66189a593f 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -714,6 +714,8 @@ struct mv88e6xxx_avb_ops {
 	int (*tai_write)(struct mv88e6xxx_chip *chip, int addr, u16 data);
 };
 
+struct mv88e6xxx_cc_coeffs;
+
 struct mv88e6xxx_ptp_ops {
 	u64 (*clock_read)(const struct cyclecounter *cc);
 	int (*ptp_enable)(struct ptp_clock_info *ptp,
@@ -731,10 +733,7 @@ struct mv88e6xxx_ptp_ops {
 	int arr1_sts_reg;
 	int dep_sts_reg;
 	u32 rx_filters;
-	u32 cc_shift;
-	u32 cc_mult;
-	u32 cc_mult_num;
-	u32 cc_mult_dem;
+	const struct mv88e6xxx_cc_coeffs *cc_coeffs;
 };
 
 struct mv88e6xxx_pcs_ops {
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index 56391e09b325..641af44e00af 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -18,6 +18,13 @@
 
 #define MV88E6XXX_MAX_ADJ_PPB	1000000
 
+struct mv88e6xxx_cc_coeffs {
+	u32 cc_shift;
+	u32 cc_mult;
+	u32 cc_mult_num;
+	u32 cc_mult_dem;
+};
+
 /* Family MV88E6250:
  * Raw timestamps are in units of 10-ns clock periods.
  *
@@ -25,10 +32,13 @@
  * simplifies to
  * clkadj = scaled_ppm * 2^7 / 5^5
  */
-#define MV88E6250_CC_SHIFT	28
-#define MV88E6250_CC_MULT	(10 << MV88E6250_CC_SHIFT)
-#define MV88E6250_CC_MULT_NUM	(1 << 7)
-#define MV88E6250_CC_MULT_DEM	3125ULL
+#define MV88E6250_CC_SHIFT 28
+static const struct mv88e6xxx_cc_coeffs mv88e6250_cc_coeffs = {
+	.cc_shift = MV88E6250_CC_SHIFT,
+	.cc_mult = 10 << MV88E6250_CC_SHIFT,
+	.cc_mult_num = 1 << 7,
+	.cc_mult_dem = 3125ULL,
+};
 
 /* Other families:
  * Raw timestamps are in units of 8-ns clock periods.
@@ -37,10 +47,13 @@
  * simplifies to
  * clkadj = scaled_ppm * 2^9 / 5^6
  */
-#define MV88E6XXX_CC_SHIFT	28
-#define MV88E6XXX_CC_MULT	(8 << MV88E6XXX_CC_SHIFT)
-#define MV88E6XXX_CC_MULT_NUM	(1 << 9)
-#define MV88E6XXX_CC_MULT_DEM	15625ULL
+#define MV88E6XXX_CC_SHIFT 28
+static const struct mv88e6xxx_cc_coeffs mv88e6xxx_cc_coeffs = {
+	.cc_shift = MV88E6XXX_CC_SHIFT,
+	.cc_mult = 8 << MV88E6XXX_CC_SHIFT,
+	.cc_mult_num = 1 << 9,
+	.cc_mult_dem = 15625ULL
+};
 
 #define TAI_EVENT_WORK_INTERVAL msecs_to_jiffies(100)
 
@@ -214,10 +227,10 @@ static int mv88e6xxx_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 		scaled_ppm = -scaled_ppm;
 	}
 
-	mult = ptp_ops->cc_mult;
-	adj = ptp_ops->cc_mult_num;
+	mult = ptp_ops->cc_coeffs->cc_mult;
+	adj = ptp_ops->cc_coeffs->cc_mult_num;
 	adj *= scaled_ppm;
-	diff = div_u64(adj, ptp_ops->cc_mult_dem);
+	diff = div_u64(adj, ptp_ops->cc_coeffs->cc_mult_dem);
 
 	mv88e6xxx_reg_lock(chip);
 
@@ -364,10 +377,7 @@ const struct mv88e6xxx_ptp_ops mv88e6165_ptp_ops = {
 		(1 << HWTSTAMP_FILTER_PTP_V2_EVENT) |
 		(1 << HWTSTAMP_FILTER_PTP_V2_SYNC) |
 		(1 << HWTSTAMP_FILTER_PTP_V2_DELAY_REQ),
-	.cc_shift = MV88E6XXX_CC_SHIFT,
-	.cc_mult = MV88E6XXX_CC_MULT,
-	.cc_mult_num = MV88E6XXX_CC_MULT_NUM,
-	.cc_mult_dem = MV88E6XXX_CC_MULT_DEM,
+	.cc_coeffs = &mv88e6xxx_cc_coeffs
 };
 
 const struct mv88e6xxx_ptp_ops mv88e6250_ptp_ops = {
@@ -391,10 +401,7 @@ const struct mv88e6xxx_ptp_ops mv88e6250_ptp_ops = {
 		(1 << HWTSTAMP_FILTER_PTP_V2_EVENT) |
 		(1 << HWTSTAMP_FILTER_PTP_V2_SYNC) |
 		(1 << HWTSTAMP_FILTER_PTP_V2_DELAY_REQ),
-	.cc_shift = MV88E6250_CC_SHIFT,
-	.cc_mult = MV88E6250_CC_MULT,
-	.cc_mult_num = MV88E6250_CC_MULT_NUM,
-	.cc_mult_dem = MV88E6250_CC_MULT_DEM,
+	.cc_coeffs = &mv88e6250_cc_coeffs,
 };
 
 const struct mv88e6xxx_ptp_ops mv88e6352_ptp_ops = {
@@ -418,10 +425,7 @@ const struct mv88e6xxx_ptp_ops mv88e6352_ptp_ops = {
 		(1 << HWTSTAMP_FILTER_PTP_V2_EVENT) |
 		(1 << HWTSTAMP_FILTER_PTP_V2_SYNC) |
 		(1 << HWTSTAMP_FILTER_PTP_V2_DELAY_REQ),
-	.cc_shift = MV88E6XXX_CC_SHIFT,
-	.cc_mult = MV88E6XXX_CC_MULT,
-	.cc_mult_num = MV88E6XXX_CC_MULT_NUM,
-	.cc_mult_dem = MV88E6XXX_CC_MULT_DEM,
+	.cc_coeffs = &mv88e6xxx_cc_coeffs,
 };
 
 const struct mv88e6xxx_ptp_ops mv88e6390_ptp_ops = {
@@ -446,10 +450,7 @@ const struct mv88e6xxx_ptp_ops mv88e6390_ptp_ops = {
 		(1 << HWTSTAMP_FILTER_PTP_V2_EVENT) |
 		(1 << HWTSTAMP_FILTER_PTP_V2_SYNC) |
 		(1 << HWTSTAMP_FILTER_PTP_V2_DELAY_REQ),
-	.cc_shift = MV88E6XXX_CC_SHIFT,
-	.cc_mult = MV88E6XXX_CC_MULT,
-	.cc_mult_num = MV88E6XXX_CC_MULT_NUM,
-	.cc_mult_dem = MV88E6XXX_CC_MULT_DEM,
+	.cc_coeffs = &mv88e6xxx_cc_coeffs,
 };
 
 static u64 mv88e6xxx_ptp_clock_read(const struct cyclecounter *cc)
@@ -487,8 +488,8 @@ int mv88e6xxx_ptp_setup(struct mv88e6xxx_chip *chip)
 	memset(&chip->tstamp_cc, 0, sizeof(chip->tstamp_cc));
 	chip->tstamp_cc.read	= mv88e6xxx_ptp_clock_read;
 	chip->tstamp_cc.mask	= CYCLECOUNTER_MASK(32);
-	chip->tstamp_cc.mult	= ptp_ops->cc_mult;
-	chip->tstamp_cc.shift	= ptp_ops->cc_shift;
+	chip->tstamp_cc.mult	= ptp_ops->cc_coeffs->cc_mult;
+	chip->tstamp_cc.shift	= ptp_ops->cc_coeffs->cc_shift;
 
 	timecounter_init(&chip->tstamp_tc, &chip->tstamp_cc,
 			 ktime_to_ns(ktime_get_real()));
-- 
2.46.2


