Return-Path: <netdev+bounces-137257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A799A52E9
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 08:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B50F1C21364
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 06:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77013101E6;
	Sun, 20 Oct 2024 06:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b="Pq3nuGHq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93197BA2D
	for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 06:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729406357; cv=none; b=RuWBmOFUBZm0C1uHidmAssgpbzXCgaw1p3KkHtiq6KIazIpbO0aVFQqawugELoB7LM8TqanO5aOT8haYJ9ijSIsyld94iFOsqWIDAuQPBZraqdanRfA8Gl7EIkVHikkajXK3Zm5lpEcBL3ds9rKpwCjSVKWpwVW4N6OdbYk6D2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729406357; c=relaxed/simple;
	bh=c+voke0UwtLpxByecxqlCsREclrCblYKqWQVd8w361w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=er6b0RLQKkLZNsoCI9dTxi5Bd2MVzOUhY6bmkrFG3JYXX5+PiFH0RFQctqAArDhtPhqLw6roNSXI9sv95iD70D7MMHQzCGboi5Suw0dciFh4nRWQl4Vsoh+hCDw2BIRvDup+ok9529uz5NNW9syS1AFjf5obiRyYKNRfN0Pfdso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info; spf=pass smtp.mailfrom=shenghaoyang.info; dkim=pass (2048-bit key) header.d=shenghaoyang.info header.i=@shenghaoyang.info header.b=Pq3nuGHq; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shenghaoyang.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shenghaoyang.info
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7ea535890e0so382861a12.2
        for <netdev@vger.kernel.org>; Sat, 19 Oct 2024 23:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shenghaoyang.info; s=google; t=1729406354; x=1730011154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kkGYvoNJK8XD/BfoAkj+1NBiJ2xPPhsGc9BrWekg1Kw=;
        b=Pq3nuGHqxuJpNYdJ1TsXg249gXE/rV44RUFycCSSMlWR82tSfVcnNS5c+NCR7GDAGC
         fNPtfbSQBa7pcakN2Yr0v16315ts9O+3FkvAKkZML8T6t2NQikI0lrqSwpmE+982SKLW
         VGumvtq26+194yB6JpvZuFQMNvEsO7VPLXeb50t/MpsVjRjDE9u9XP2/6lq+UTKm3PzN
         dfOMKfluRzkPTNcxCjCAfKYjQtyLn4F9R00uNMupnFmvwoyh+TqbfwFnQ5x/B3rtxiUL
         4XYZzqquXqONuL8zUzlYBOwxt0dQsXRKXV7f9FjOeEntR7OLU/Cn3Hef87zAhsQtfe5y
         Ftkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729406354; x=1730011154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkGYvoNJK8XD/BfoAkj+1NBiJ2xPPhsGc9BrWekg1Kw=;
        b=pZ+EHsH7FXUmdwtWbwJBqOSYlPHMDf9gGu7HzvG8GJfKR6/1OebgJp8r9pv1K0p82B
         YLu2ML3REBUfcnyKrhrwaVlmoPeP7bqLHGphAW4HcHfXEDPbGROEdyoo/USyKRn5469C
         Z8Qvh+hq1/+AUa+Ar83UsKgjDZWVjfnPSjiEgr2f0Blj8E3rFo7h2P3U1QB2+UD/9x+s
         i4Ej3jzxp00dKEO30AGWzn+Znb1WuLI+c5VVYkMecDmeQfo0BsDzORO9XUX0wNgWVVVx
         IA1lqgp/DGTkYly9bLR8g4l+59mHKOMHt7CE2ZAITo/ScLigVp1loukCawgegEanW6QV
         7GHA==
X-Gm-Message-State: AOJu0YydcMD5EbEGZIYIFzzjycly3DGhXFFa7ylyekdWP464s7eartIl
	l4xKfiNVKMWtLUMypyfIYJw9CKuOkv1IJsKJ3/1GSS22/u7f1Lnkeu6wcfgr5ptQgg78kz3b16l
	/Ty4=
X-Google-Smtp-Source: AGHT+IGpdwixsBPCWly7FsH7ZmFSPDpaGOfpgVlI9u1qZUFw4lTEhyvy+YWXHxnZQw0hYabVFgw7hQ==
X-Received: by 2002:a05:6a00:21c9:b0:71e:6895:fe9e with SMTP id d2e1a72fcca58-71ea334077bmr4654954b3a.6.1729406354244;
        Sat, 19 Oct 2024 23:39:14 -0700 (PDT)
Received: from localhost ([132.147.84.99])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-71ec13eaaafsm683994b3a.170.2024.10.19.23.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Oct 2024 23:39:13 -0700 (PDT)
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
Subject: [PATCH net v3 3/3] net: dsa: mv88e6xxx: support 4000ps cycle counter period
Date: Sun, 20 Oct 2024 14:38:30 +0800
Message-ID: <20241020063833.5425-4-me@shenghaoyang.info>
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

The MV88E6393X family of devices can run its cycle counter off
an internal 250MHz clock instead of an external 125MHz one.

Add support for this cycle counter period by adding another set
of coefficients and lowering the periodic cycle counter read interval
to compensate for faster overflows at the increased frequency.

Otherwise, the PHC runs at 2x real time in userspace and cannot be
synchronized.

Fixes: de776d0d316f ("net: dsa: mv88e6xxx: add support for mv88e6393x family")
Signed-off-by: Shenghao Yang <me@shenghaoyang.info>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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
2.47.0


