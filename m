Return-Path: <netdev+bounces-137255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C49BC9A52E7
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 08:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49FE21F222A6
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 06:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2730811713;
	Sun, 20 Oct 2024 06:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b="hSA431E8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C55A2F43
	for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 06:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729406345; cv=none; b=I2JIQKqDj1o7D3NcBM1eFjih1aFSyvv7Vixj/nQxmrotn29JZ5DuH5E7K46fUbCLOptTZhIn6ez/wlnBYBQVXBVQ6IFfPEl7J/e3sl0wi6Tzu68DmtNAoDAxM8rVESnLdf2NcI6Z18jGLk0P8c3+AtIDlbUh2q+/0m2ZM2dTCsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729406345; c=relaxed/simple;
	bh=I6B4JaYWlqYqj8edxQllva/4w6Iw8ZELunyS4G8VRA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t1WcXU5Nq1pzR2Y8UyMqVeGA7fLCbVAH/gAVpof4Xr/e+qncEQ1lgW1GvNboEHztXIzJQsWuEt0ZGZWFXj4R8ZRQ6N40qP3fTTzclzM8pSjq8ev1kARxBxRyKBcPv+NSGLh+9UquVYCWnko4+r1fo8lFFDN9y5tYbmzWLbsc6LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info; spf=pass smtp.mailfrom=shenghaoyang.info; dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b=hSA431E8; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shenghaoyang.info
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20c83c2e967so2021995ad.1
        for <netdev@vger.kernel.org>; Sat, 19 Oct 2024 23:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenghaoyang.info; s=google; t=1729406342; x=1730011142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4EpV9ySniWRaX8wwhrQpjQJ/PltCoB/m72FGqtY+LWU=;
        b=hSA431E8ldSSgpVc6IIaSXGnwh/Hz2ITTJnmQGJkf2aM27vavzykWk3HLJgGNAiPND
         jYAeQqiB49uaULi0sbGexGhlK2y1uem3h+ufYUB6CuXgH+k9LT0kB7uYaJd0gH6pW4Dk
         wsCjVFWLxsITklSOs+1G6xMfVDsvqHHF/qJVyxkCmSbDaFSF6F5kFybfdiV7I/7UcHqs
         dxnKUWS5EfEFv9oTLvngBysG3dO+6fDYcB+OOQYb3Uc97H4fMoplY5rXBKzcRUaJVhvr
         z7aRzYUyW+VbC2jDxom1r8tArGNtWlDkzuu104W1V0C4C9CpV8zzSmIqukXmu/SBnKJY
         flAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729406342; x=1730011142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4EpV9ySniWRaX8wwhrQpjQJ/PltCoB/m72FGqtY+LWU=;
        b=Q/O1aaZnP29fM3PtnnSACNlDCFPApRIB/g9RGTAK2dZQMGaMHK5jyQPDvMH8eQQTzb
         Krq22ngo6y/xAKk8r1KhyEs4iwGUgJPzE4hglGsMr5+VPvrpQeF2spcn+47wAj5eQ2T5
         HCuofXEt8LvKpyeT0FEUeEYCftLN8Fs1v2zpr+Rvc9Qvd9OP7kHJs7jH9TxuSVPoinh2
         LEd/rTWubOq+A3RHmZzr4nf5NJYCaYADSKcn3HKH2bdJmOz9gmvGhU0pa7arwm4WvICF
         p81wVCyKZpno8z9aNlYWhDGdnCliI9rUKDeHu7lF23V+TiUu+Vyh5o0K5c4yTOWahhzv
         orVA==
X-Gm-Message-State: AOJu0YxS8dw97Ug5PAUNo+fIIbD9WEkzHF9qcjqGYexQ97D6pnh/nhBK
	1Lwbz2jY8FDZ3SrxPis6ccQ7ALPVBN3MSxZCZ/9kDU/fKuj178gpIgmsGZaIL9qE78nHqcCwZ0t
	w0k0=
X-Google-Smtp-Source: AGHT+IEUlsRz77ARK3cyrFGsc4lZUsAuDjin8R4vukplj0aw6XFAZYmFlOG6/f6k57fxGDdchguO2w==
X-Received: by 2002:a17:902:ea0d:b0:20c:da9a:d5b9 with SMTP id d9443c01a7336-20e5a764fb8mr46647725ad.5.1729406341921;
        Sat, 19 Oct 2024 23:39:01 -0700 (PDT)
Received: from localhost ([132.147.84.99])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-20e7f0f35f8sm5681405ad.267.2024.10.19.23.38.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Oct 2024 23:39:01 -0700 (PDT)
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
Subject: [PATCH net v3 1/3] net: dsa: mv88e6xxx: group cycle counter coefficients
Date: Sun, 20 Oct 2024 14:38:28 +0800
Message-ID: <20241020063833.5425-2-me@shenghaoyang.info>
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

Instead of having them as individual fields in ptp_ops, wrap the
coefficients in a separate struct so they can be referenced together.

Fixes: de776d0d316f ("net: dsa: mv88e6xxx: add support for mv88e6393x family")
Signed-off-by: Shenghao Yang <me@shenghaoyang.info>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/mv88e6xxx/chip.h |  6 ++--
 drivers/net/dsa/mv88e6xxx/ptp.c  | 59 ++++++++++++++++----------------
 2 files changed, 32 insertions(+), 33 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index c34caf9815c5..1d003a9deafa 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -206,6 +206,7 @@ struct mv88e6xxx_gpio_ops;
 struct mv88e6xxx_avb_ops;
 struct mv88e6xxx_ptp_ops;
 struct mv88e6xxx_pcs_ops;
+struct mv88e6xxx_cc_coeffs;
 
 struct mv88e6xxx_irq {
 	u16 masked;
@@ -731,10 +732,7 @@ struct mv88e6xxx_ptp_ops {
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
2.47.0


