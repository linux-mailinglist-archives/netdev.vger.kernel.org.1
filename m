Return-Path: <netdev+bounces-128394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9DE979686
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 13:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0AB22826B8
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 11:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396011C462B;
	Sun, 15 Sep 2024 11:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b="KPAeGdg1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586B021340
	for <netdev@vger.kernel.org>; Sun, 15 Sep 2024 11:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726401454; cv=none; b=NjkWaYUCeyzZ7VCRG+rsrX9loD+I5QPOz/0T3XRNI+ni/tHhBCohX5YWpjp6VC13PfPwBc2ilnQCDkkjVR0/9awPwfcuZLtVAEe7EXYNVcvdeiWV/aqjQDzAARrdxXgZXk4qeH8n+pqHwpyle48648/CJsbSl7W8LXyNBbaJjo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726401454; c=relaxed/simple;
	bh=mIpgu8cQ/3aTt0+F0cq13Ec35DUu5Z2y7qh5YoiciMo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=VBGf+19LpErS/Akii5n38sZRDNhhBhTBoyOqow4qbZfZADlkImLnA2g+JmsSet06WXwpJamYnewz2PEnJfiErEMCexS/QBEiy54HyHdsn835tf9rKi7C4pGwZJAypq+gHwvSTQGjQlQzrzF+RTpkC6nRBihL6hYiiD37B7BTd6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info; spf=pass smtp.mailfrom=shenghaoyang.info; dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b=KPAeGdg1; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shenghaoyang.info
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7d21b0c8422so576749a12.0
        for <netdev@vger.kernel.org>; Sun, 15 Sep 2024 04:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenghaoyang.info; s=google; t=1726401451; x=1727006251; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTMEZra6bn5r22Vfpgz9rTyolr3locvhdnwiZWPYHHc=;
        b=KPAeGdg1dbMbvbITOaJYl91/Qw/W0HOC6KOdVFqKiDA9pO3QrnhAehwyyKPpYJN4fv
         MYRCO/3O2XwHPqgT8shDxrgX7qbMdHvWIuQunGePBX6kFdM/IQK+2sDYEsclci3uPhBf
         9o6OHgMORWSGF6SJP15xDtreqqZwvUcGxABeaNVAMHUS+tOTN2Yq1fNd/eOaW/VkWec7
         VJrEzkk8us7AH9InFTjBp0y9Ywn5rgUftXjkEXNxN0krdav0JxuZXYHP54PKRsmNXW/n
         ynjqcPQMuDbtnoyA7YJx/VeLP3JVqdR7N3PZuRZGbyhhYo9Jo9OfH6zMTx14SydNWRee
         uzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726401451; x=1727006251;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gTMEZra6bn5r22Vfpgz9rTyolr3locvhdnwiZWPYHHc=;
        b=KgfVOgLckQ37rfKf87I+jmzFok2E9sfXiHQDEUXfrdcFabSZz7Hh/uww5U16XFJUQd
         WFSl1FLZABWG4mi9COUdsrbK119G7vIgQR6i1+Hw0DMz1bmE6Vtue7whcm6Q8nDfnnaz
         2akzEJ1P0AYNhUD/HsEW97eMgRcAl/eA4HWOCUoIlPDdS9rZ1BfBLWM9vpzPDxhBPrt6
         QwkNIck64/vsd+b5IfXkXSEgJZTryM4U86U5rguxJboQnNZ3JC6jfYpn3y4azJ3F8CQs
         cNjkeer+gYei0J3999SDxFT7gRddQxrBZi0zebN4WMPrglbarB+7TykL5QuBarj5Lp/9
         gATg==
X-Gm-Message-State: AOJu0YzF/FNOhwoiZWwRdWgqo+43QFtIGJNasfHjlLGL7ApOsCZ9BSvO
	c9d+6Pge9X8zehsjVyWqo+MEGO9RaQ+e6pwb6mfhFclxhnHGeiWNVioI2lmhyIo+CZiy65A9ZLT
	f8eTwAg==
X-Google-Smtp-Source: AGHT+IGGKaDJ8bJuR9fRGaCyOySKp6n1qqw5VLpj8p5G9sRe9xBavMEmFcMbxulACLGZbILjGDH7Mw==
X-Received: by 2002:a05:6a20:6a20:b0:1cf:43e0:d75f with SMTP id adf61e73a8af0-1cf7648f937mr8083631637.7.1726401450793;
        Sun, 15 Sep 2024 04:57:30 -0700 (PDT)
Received: from [10.0.0.211] ([132.147.84.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944bca0f2sm2099491b3a.210.2024.09.15.04.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Sep 2024 04:57:30 -0700 (PDT)
Message-ID: <b940ddf9-745f-4f2a-a29e-d6efe64de9a8@shenghaoyang.info>
Date: Sun, 15 Sep 2024 19:57:27 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev@vger.kernel.org
Cc: f.fainelli@gmail.com, olteanv@gmail.com, pavana.sharma@digi.com,
 ashkan.boldaji@digi.com, kabel@kernel.org, andrew@lunn.ch
From: Shenghao Yang <me@shenghaoyang.info>
Subject: [RFC PATCH] net: dsa: mv88e6xxx: correct CC scale factor for 88E6393X
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Sending this as an RFC: no datasheet access - this
scaling factor may not be correct for all boards if this
4ns vs 8ns discrepancy is down to physical design.

If the counter is truly spec'd to always count at
250MHz other chips in the same family may need
correction too.

Tested on a MikroTik RB5009.

Fixes: de776d0d316f ("net: dsa: mv88e6xxx: add support for mv88e6393x family")
Signed-off-by: Shenghao Yang <me@shenghaoyang.info>
---
 drivers/net/dsa/mv88e6xxx/chip.c |  2 +-
 drivers/net/dsa/mv88e6xxx/ptp.c  | 43 ++++++++++++++++++++++++++++++--
 drivers/net/dsa/mv88e6xxx/ptp.h  |  2 ++
 3 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 5b4e2ce5470d..480fd93a336a 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5617,7 +5617,7 @@ static const struct mv88e6xxx_ops mv88e6393x_ops = {
 	/* TODO: serdes stats */
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6390_avb_ops,
-	.ptp_ops = &mv88e6352_ptp_ops,
+	.ptp_ops = &mv88e6393x_ptp_ops,
 	.phylink_get_caps = mv88e6393x_phylink_get_caps,
 	.pcs_ops = &mv88e6393x_pcs_ops,
 };
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index 56391e09b325..02bfff368be2 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -30,6 +30,18 @@
 #define MV88E6250_CC_MULT_NUM	(1 << 7)
 #define MV88E6250_CC_MULT_DEM	3125ULL
 
+/* Family MV88E6393X:
+ * Raw timestamps appear to be in units of 4-ns clock periods.
+ *
+ * clkadj = scaled_ppm * 4*2^28 / (10^6 * 2^16)
+ * simplifies to
+ * clkadj = scaled_ppm * 2^8 / 5^6
+ */
+#define MV88E6393X_CC_SHIFT	28
+#define MV88E6393X_CC_MULT	(4 << MV88E6393X_CC_SHIFT)
+#define MV88E6393X_CC_MULT_NUM	(1 << 8)
+#define MV88E6393X_CC_MULT_DEM	15625ULL
+
 /* Other families:
  * Raw timestamps are in units of 8-ns clock periods.
  *
@@ -452,6 +464,33 @@ const struct mv88e6xxx_ptp_ops mv88e6390_ptp_ops = {
 	.cc_mult_dem = MV88E6XXX_CC_MULT_DEM,
 };
 
+const struct mv88e6xxx_ptp_ops mv88e6393x_ptp_ops = {
+	.clock_read = mv88e6352_ptp_clock_read,
+	.ptp_enable = mv88e6352_ptp_enable,
+	.ptp_verify = mv88e6352_ptp_verify,
+	.event_work = mv88e6352_tai_event_work,
+	.port_enable = mv88e6352_hwtstamp_port_enable,
+	.port_disable = mv88e6352_hwtstamp_port_disable,
+	.n_ext_ts = 1,
+	.arr0_sts_reg = MV88E6XXX_PORT_PTP_ARR0_STS,
+	.arr1_sts_reg = MV88E6XXX_PORT_PTP_ARR1_STS,
+	.dep_sts_reg = MV88E6XXX_PORT_PTP_DEP_STS,
+	.rx_filters = (1 << HWTSTAMP_FILTER_NONE) |
+		(1 << HWTSTAMP_FILTER_PTP_V2_L4_EVENT) |
+		(1 << HWTSTAMP_FILTER_PTP_V2_L4_SYNC) |
+		(1 << HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ) |
+		(1 << HWTSTAMP_FILTER_PTP_V2_L2_EVENT) |
+		(1 << HWTSTAMP_FILTER_PTP_V2_L2_SYNC) |
+		(1 << HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ) |
+		(1 << HWTSTAMP_FILTER_PTP_V2_EVENT) |
+		(1 << HWTSTAMP_FILTER_PTP_V2_SYNC) |
+		(1 << HWTSTAMP_FILTER_PTP_V2_DELAY_REQ),
+	.cc_shift = MV88E6393X_CC_SHIFT,
+	.cc_mult = MV88E6393X_CC_MULT,
+	.cc_mult_num = MV88E6393X_CC_MULT_NUM,
+	.cc_mult_dem = MV88E6393X_CC_MULT_DEM,
+};
+
 static u64 mv88e6xxx_ptp_clock_read(const struct cyclecounter *cc)
 {
 	struct mv88e6xxx_chip *chip = cc_to_chip(cc);
@@ -462,10 +501,10 @@ static u64 mv88e6xxx_ptp_clock_read(const struct cyclecounter *cc)
 	return 0;
 }
 
-/* With a 125MHz input clock, the 32-bit timestamp counter overflows in ~34.3
+/* With a 125MHz input clock, the 32-bit timestamp counter overflows in ~17.2
  * seconds; this task forces periodic reads so that we don't miss any.
  */
-#define MV88E6XXX_TAI_OVERFLOW_PERIOD (HZ * 16)
+#define MV88E6XXX_TAI_OVERFLOW_PERIOD (HZ * 8)
 static void mv88e6xxx_ptp_overflow_check(struct work_struct *work)
 {
 	struct delayed_work *dw = to_delayed_work(work);
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.h b/drivers/net/dsa/mv88e6xxx/ptp.h
index 6c4d09adc93c..b236e11c6d78 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.h
+++ b/drivers/net/dsa/mv88e6xxx/ptp.h
@@ -152,6 +152,7 @@ extern const struct mv88e6xxx_ptp_ops mv88e6165_ptp_ops;
 extern const struct mv88e6xxx_ptp_ops mv88e6250_ptp_ops;
 extern const struct mv88e6xxx_ptp_ops mv88e6352_ptp_ops;
 extern const struct mv88e6xxx_ptp_ops mv88e6390_ptp_ops;
+extern const struct mv88e6xxx_ptp_ops mv88e6393x_ptp_ops;
 
 #else /* !CONFIG_NET_DSA_MV88E6XXX_PTP */
 
@@ -173,6 +174,7 @@ static const struct mv88e6xxx_ptp_ops mv88e6165_ptp_ops = {};
 static const struct mv88e6xxx_ptp_ops mv88e6250_ptp_ops = {};
 static const struct mv88e6xxx_ptp_ops mv88e6352_ptp_ops = {};
 static const struct mv88e6xxx_ptp_ops mv88e6390_ptp_ops = {};
+static const struct mv88e6xxx_ptp_ops mv88e6393x_ptp_ops = {};
 
 #endif /* CONFIG_NET_DSA_MV88E6XXX_PTP */
 
-- 
2.46.0


