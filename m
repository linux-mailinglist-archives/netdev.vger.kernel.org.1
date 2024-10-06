Return-Path: <netdev+bounces-132500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B26A991F37
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 17:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F3F8B21965
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 15:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B498F13635D;
	Sun,  6 Oct 2024 15:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b="X66MvOd5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AF71F5F6
	for <netdev@vger.kernel.org>; Sun,  6 Oct 2024 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728226836; cv=none; b=NcR7G88nrFTDcYTKR1cpPOHpGcCCc8dVBY7UV7QfH6ilFkAJ7QhDu2qdkGpwF3qvV42kiW3kcThCycuijYr+YFyb10cj4fXJXlFFKm/u1B5WQVkAXqx4POBOMvphmH5Zj910/ynqrj+cdzhuxbYkjRBzYIXRk3kab34wyADS+O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728226836; c=relaxed/simple;
	bh=riK9FOolz1RE6hRQeW2Qv8d000EjlAHgMt/D8KJsaZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IMisF194XcaUGINLtu6GFBtPMx2KN0wRgdJzQ8Di0/tVI1EkdsqDvvvcGWq2G7GpG4ORmnAB4dEoqBB1/Kxn7wyh3xsRTe2a9TLte8Ku81bCEiYcrK3dMmvUXOce8GhSPih3GlenRWM7/yZojC1atnbGBnwlQeyvYOrh5u4GDPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info; spf=pass smtp.mailfrom=shenghaoyang.info; dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b=X66MvOd5; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shenghaoyang.info
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7e9f8714b9bso99153a12.3
        for <netdev@vger.kernel.org>; Sun, 06 Oct 2024 08:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenghaoyang.info; s=google; t=1728226834; x=1728831634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3HG943iTePzKfgDFq3MIKdj5dZkExEASCzhHW9hy/Kw=;
        b=X66MvOd5M1NdVmgw+tHlzM0XG2LE6PmyhbbVWkFMsOUthgDFlWE7gCa39gd6dZiXlD
         3Y2slI0JQaNIyzcrvqB/ZuFsmhgJ6IR+20Z2vqPngjMrm/w2ExWXc1g5z4c1ufxWA9Q8
         Nb4dyR2pJR04UY4O8RvtDkpeOdCp7uuQHWdaA8WMSAyTjoUwc1rXpkT2RJvYEXYcjfRn
         /29YFy+f0EZGSjU6UnzuCSSdtB2N2u1gMUIT39rHQTIR0EoshzR3R6vmBvpeZi2+2G2t
         iTQo+8YdCaH/QaBigF19dRmqBvuy7Hppn7f3L9IlbRjQaq9SwE7kLkWd0YhJVC1fkE8D
         uWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728226834; x=1728831634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3HG943iTePzKfgDFq3MIKdj5dZkExEASCzhHW9hy/Kw=;
        b=piQ5dFCSzKw4kteBjGS+TIzxfW2IlvY+O7T7wZAeilVf7BXU69tWrlVnMMbOEipDFc
         jRSJBuIw8ok913wtglVTJ2Y+X1MqCQ6euRKSPhe2q5bt4Ix3dboIg+M3kQShYjtOHjox
         6U5xjqwoKSnVgDYG0SpR+cjcyyu2q2oVXOhFnpEzhiOIcxUoQDMPUCmxygtF+DQDOg4a
         6j/mjCsb8ax9ZP+sAQYo+SpEHwqc/DZbTRWQ0qh4Bl91DS816HryNrUKMUiqnL1Qe5w5
         GPFLQHQpzmJVegdf2eJlofD/48/+7lbOtiztK7YyGl98sGXlk1Jp2gnfi9mpwus9GlPi
         DhoQ==
X-Gm-Message-State: AOJu0Yyq/G1mIIwqC7Ro0yCS9ZP3Hhb3lHdGbLTdgMAG8ZdPMjpidqPq
	rxFScciOhLw+7AoBwEtz3CfyPuTAGX1Lnk6mTsruAXVtHVI5zR2Qo0kd9OfQL4lifaRZAEgThZu
	Ryl/doA==
X-Google-Smtp-Source: AGHT+IFMPbKItnKFhWE1/IENn5IkrRk66SNE8x/c4MKJPSb+0wjC5t3YywAXG822M5q5aNQUvDQexQ==
X-Received: by 2002:a17:902:e882:b0:20b:9822:66fe with SMTP id d9443c01a7336-20bfe01e37bmr57437775ad.1.1728226834131;
        Sun, 06 Oct 2024 08:00:34 -0700 (PDT)
Received: from localhost ([132.147.84.99])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-20c138afc71sm26202155ad.47.2024.10.06.08.00.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2024 08:00:33 -0700 (PDT)
From: Shenghao Yang <me@shenghaoyang.info>
To: netdev@vger.kernel.org
Cc: Shenghao Yang <me@shenghaoyang.info>,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	pavana.sharma@digi.com,
	ashkan.boldaji@digi.com,
	kabel@kernel.org,
	andrew@lunn.ch
Subject: [PATCH net v2 3/3] net: dsa: mv88e6xxx: support 4000ps cycle counter period
Date: Sun,  6 Oct 2024 22:59:47 +0800
Message-ID: <20241006145951.719162-4-me@shenghaoyang.info>
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
 drivers/net/dsa/mv88e6xxx/ptp.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index a409b8661fad..aed4a4b07f34 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -40,7 +40,7 @@ static const struct mv88e6xxx_cc_coeffs mv88e6xxx_cc_10ns_coeffs = {
 	.cc_mult_dem = 3125ULL,
 };
 
-/* Other families:
+/* Other families except MV88E6393X in internal clock mode:
  * Raw timestamps are in units of 8-ns clock periods.
  *
  * clkadj = scaled_ppm * 8*2^28 / (10^6 * 2^16)
@@ -55,6 +55,21 @@ static const struct mv88e6xxx_cc_coeffs mv88e6xxx_cc_8ns_coeffs = {
 	.cc_mult_dem = 15625ULL
 };
 
+/* Family MV88E6393X using internal clock:
+ * Raw timestamps are in units of 4-ns clock periods.
+ *
+ * clkadj = scaled_ppm * 4*2^28 / (10^6 * 2^16)
+ * simplifies to
+ * clkadj = scaled_ppm * 2^8 / 5^6
+ */
+#define MV88E6XXX_CC_4NS_SHIFT 28
+static const struct mv88e6xxx_cc_coeffs mv88e6xxx_cc_4ns_coeffs = {
+	.cc_shift = MV88E6XXX_CC_4NS_SHIFT,
+	.cc_mult = 4 << MV88E6XXX_CC_4NS_SHIFT,
+	.cc_mult_num = 1 << 8,
+	.cc_mult_dem = 15625ULL
+};
+
 #define TAI_EVENT_WORK_INTERVAL msecs_to_jiffies(100)
 
 #define cc_to_chip(cc) container_of(cc, struct mv88e6xxx_chip, tstamp_cc)
@@ -110,6 +125,8 @@ mv88e6xxx_cc_coeff_get(struct mv88e6xxx_chip *chip)
 	}
 
 	switch (period_ps) {
+	case 4000:
+		return &mv88e6xxx_cc_4ns_coeffs;
 	case 8000:
 		return &mv88e6xxx_cc_8ns_coeffs;
 	case 10000:
@@ -483,10 +500,10 @@ static u64 mv88e6xxx_ptp_clock_read(const struct cyclecounter *cc)
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
2.46.2


