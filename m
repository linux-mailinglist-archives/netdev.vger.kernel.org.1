Return-Path: <netdev+bounces-130232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8164E9894C4
	for <lists+netdev@lfdr.de>; Sun, 29 Sep 2024 12:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D73B282469
	for <lists+netdev@lfdr.de>; Sun, 29 Sep 2024 10:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A68714D71E;
	Sun, 29 Sep 2024 10:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b="XQn8iSOJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE3D14AD3B
	for <netdev@vger.kernel.org>; Sun, 29 Sep 2024 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727605225; cv=none; b=BMncAFZgeYQPxHDPIdTfgkGPQ9SMob58nqNUQMPl+uQgsHGRsS//W2Wsjd3XzWC8K7Adb29/Fu7nJgYjuivzl29C58KADI9SiAuF1s4GXjz+j8XYtqJ3EmuuRG86RfbNoobIDNylSi+Nyp62yZpLgX/0rpcbgU86QBA4hJI/99k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727605225; c=relaxed/simple;
	bh=NkLl5gsxDTLxdsUCsN+OB6lT2jQwGPHLNHnOoY0++Is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HVOiN1YjaPWDmwxAzo56F2EXLR4VHN9TDJ0KU6gzdq19nxL9IXLoIj0mtyTt22SjDnI0OujqT1I5tgVXv/nxOEkxmsfOo+W3WUQbpMd/zduOrsrGB/3canASPn8ZoAC0kCpEzT2+usQ6ijC0hd3llv933QKKCqFUsEZ15zThK7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info; spf=pass smtp.mailfrom=shenghaoyang.info; dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b=XQn8iSOJ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shenghaoyang.info
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2dbde420d15so399804a91.3
        for <netdev@vger.kernel.org>; Sun, 29 Sep 2024 03:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenghaoyang.info; s=google; t=1727605223; x=1728210023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfdLdX1zgX8137zcwX9nVnD7H5S/KBA4KuLfzSbtSvU=;
        b=XQn8iSOJsQghfTrEysYONM9OWlhilXy+ncgniUa2qRtepLRSwhVHKoxlHM9VmtW9aa
         POrgqVoLSoozxqjJqcghRriW2GBLWt0w9TzqG4aEG6PvYHx9EyxHyvoPSBenQ4WKTJNB
         sMJteh6RUEws86nS7xwSwk8XI2CLk0ZPHyLKjI6kurtBbMu2K1nFNetzyPHcKHGtJZRc
         PphjwpmlghiQAtxqDyapWjnMDQ2XqbaD8k/myErdvrNXvMfxX1DN1OyogYdZD3AhOzT3
         RUGOBIzYVAIv8wTV6FR/o9aIN4Y0UI867AEVXOUN9JnzoOuqzDZsrwh4r6x4795UEyFX
         q3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727605223; x=1728210023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfdLdX1zgX8137zcwX9nVnD7H5S/KBA4KuLfzSbtSvU=;
        b=kewH8IjovHhcEHCvYlG/UBXTWTQmspDQK5wjhV4lDktCRfmP8o/BePg4/IKa7XeePf
         u+S5XvogffF+FKlRrqU1QKNPQY/iAx5i0Zqbc3qbVV09LIl4T+37daPPkyytKHuHeySE
         mu6FslBaWb5l46GBpvZxsQdm9TajQIcl2yB0nT1Vl35fDDcYLHLHZ46k2eGNb9MmShEM
         whw0Ls8xS+jNooB2TWOehaAvFKXW5yR2m3HTFwsLExW/xDoqMLssaKAony+vdynv9iF9
         2IYDLnkxQUzZl7mh7tf+47L3/WPM1SHZGb7ahT4UlQWw8+t84IGcUhdVAAQIFGu9Vl1L
         bm6Q==
X-Gm-Message-State: AOJu0YwYD+Ow9kDu9SwZFeLt+fTvkmKiV4lBkzhiW5mETnRlxn/Gc//X
	N4lU1dn8ZRyF45yRnnacGREWC5BhbwoPQo48JIlWZsZ/SS8K32USOku7bVNadLhYlcuCTQjvvvN
	DBZ/dBg==
X-Google-Smtp-Source: AGHT+IFwQAoPSuXV1uTHzlSLFrWH2LDEA6p0sOzvJqzKW91oLxSZgObZZjtSZcg5N9kxVo7KO9p+2A==
X-Received: by 2002:a17:902:d4c7:b0:205:861c:5c37 with SMTP id d9443c01a7336-20b37b48ca4mr53175645ad.6.1727605222869;
        Sun, 29 Sep 2024 03:20:22 -0700 (PDT)
Received: from localhost ([132.147.84.99])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-20b37e10196sm37547615ad.145.2024.09.29.03.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Sep 2024 03:20:22 -0700 (PDT)
From: Shenghao Yang <me@shenghaoyang.info>
To: netdev@vger.kernel.org
Cc: Shenghao Yang <me@shenghaoyang.info>,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	pavana.sharma@digi.com,
	ashkan.boldaji@digi.com,
	kabel@kernel.org,
	andrew@lunn.ch
Subject: [PATCH net 1/3] net: dsa: mv88e6xxx: group cycle counter coefficients
Date: Sun, 29 Sep 2024 18:19:45 +0800
Message-ID: <20240929101949.723658-2-me@shenghaoyang.info>
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

Instead of having them as individual fields in ptp_ops, wrap the
coefficients in a separate struct so they can be referenced together.

Fixes: de776d0d316f ("net: dsa: mv88e6xxx: add support for mv88e6393x family")
Signed-off-by: Shenghao Yang <me@shenghaoyang.info>
---
 drivers/net/dsa/mv88e6xxx/chip.h |  7 ++--
 drivers/net/dsa/mv88e6xxx/ptp.c  | 57 ++++++++++++++++----------------
 2 files changed, 31 insertions(+), 33 deletions(-)

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
index 56391e09b325..89040c9af9f3 100644
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
@@ -25,10 +32,12 @@
  * simplifies to
  * clkadj = scaled_ppm * 2^7 / 5^5
  */
-#define MV88E6250_CC_SHIFT	28
-#define MV88E6250_CC_MULT	(10 << MV88E6250_CC_SHIFT)
-#define MV88E6250_CC_MULT_NUM	(1 << 7)
-#define MV88E6250_CC_MULT_DEM	3125ULL
+const struct mv88e6xxx_cc_coeffs mv88e6250_cc_coeffs = {
+	.cc_shift = 28,
+	.cc_mult = 10 << 28,
+	.cc_mult_num = 1 << 7,
+	.cc_mult_dem = 3125ULL,
+};
 
 /* Other families:
  * Raw timestamps are in units of 8-ns clock periods.
@@ -37,10 +46,12 @@
  * simplifies to
  * clkadj = scaled_ppm * 2^9 / 5^6
  */
-#define MV88E6XXX_CC_SHIFT	28
-#define MV88E6XXX_CC_MULT	(8 << MV88E6XXX_CC_SHIFT)
-#define MV88E6XXX_CC_MULT_NUM	(1 << 9)
-#define MV88E6XXX_CC_MULT_DEM	15625ULL
+const struct mv88e6xxx_cc_coeffs mv88e6xxx_cc_coeffs = {
+	.cc_shift = 28,
+	.cc_mult = 8 << 28,
+	.cc_mult_num = 1 << 9,
+	.cc_mult_dem = 15625ULL
+};
 
 #define TAI_EVENT_WORK_INTERVAL msecs_to_jiffies(100)
 
@@ -214,10 +225,10 @@ static int mv88e6xxx_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
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
 
@@ -364,10 +375,7 @@ const struct mv88e6xxx_ptp_ops mv88e6165_ptp_ops = {
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
@@ -391,10 +399,7 @@ const struct mv88e6xxx_ptp_ops mv88e6250_ptp_ops = {
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
@@ -418,10 +423,7 @@ const struct mv88e6xxx_ptp_ops mv88e6352_ptp_ops = {
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
@@ -446,10 +448,7 @@ const struct mv88e6xxx_ptp_ops mv88e6390_ptp_ops = {
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
@@ -487,8 +486,8 @@ int mv88e6xxx_ptp_setup(struct mv88e6xxx_chip *chip)
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
2.46.1


