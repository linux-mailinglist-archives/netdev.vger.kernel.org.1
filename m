Return-Path: <netdev+bounces-134840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7746999B494
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 13:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE03DB2499C
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 11:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FC419B5B5;
	Sat, 12 Oct 2024 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="opm1zZm4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87076174EFC
	for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 11:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728733678; cv=none; b=gNM97Qy32ragO2wx4iqWqSIDRlTSeQK5cnX5Eo03ukGbfmqZXfnIowaSjW9pwuvteyqCrEquCO+GzdOO5X+rX59MfFQ2Yd3kGdfhX/GmxA8SN0oE+FTJSoU1+MvVCcc5aR/bY+dn3S2kQ5z2eWMrPs7LwqsaVtjVztzWJGveL2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728733678; c=relaxed/simple;
	bh=wMEzQDgxlBALIhduUpoQoDITHC5O1pOXtSgjt/0Igxs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eqDAq30zI3gMVFYDxg6GbV905n+ph8gNhR/tA0lSAIGV/Ub7TPPM6R4i8sC2F7v1FncLxxCbcQNLpC9C1dGtLL1gb/BQsI8KA4NQ0yI/+JvtTAmzfuzqrgMxVDTd5ZR56INMPj0Pgjm2+1sO43tMnPwK1RP+NRucHhLI3d+FOLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maheshb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=opm1zZm4; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maheshb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e26ba37314so52052767b3.0
        for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 04:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728733675; x=1729338475; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PC1TT8s5aJVZuPxi84fwP2du0aqC4j59rElSaUuKUNM=;
        b=opm1zZm4xvemSLXOIN3Qkf9GJ/9x7ikaunUKO8OLMZnN4hBe6/WLRxH9/hc0mawMEq
         A/aO4ad2dwxWClAiPIzkDgbgUTeyirYHTdbjGpKdoXBq+NbFqv1WPHK+PyqFDjtxw7Yl
         +RKFilrFQE4Vv6M3AxUBG1uPRgsZ3+u/Zs8W0o6cbGxoxDIXDTnx++iDisJiOsSuGLCn
         uI3ToFh8AMokVLQKykSWp6j6rJDe51KBQHVAFFqZElD1e4B8A9u7tiX/K2q2PRNw+JF8
         n2xbLX6Bz+w7Nlf7PvwyhzSas6c0LNn2ohpuUkiTk92DX1tdFh/miUAYJO9/6JSszgRQ
         0Vjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728733675; x=1729338475;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PC1TT8s5aJVZuPxi84fwP2du0aqC4j59rElSaUuKUNM=;
        b=T7lVBIrVyJ0KihwGszP/QbOSNcYMoJ8cVB9+rU+0m9uaJqc5PWKWmFp2UNRWJzvRAw
         1HyIGs51XvTZxYRL89nKlBk3mfOhdnDX+CE+efY2LRpfsNCr8yKsP4J/yxtKrfwTHfcT
         +aBOI0xnteAQj8NKd9wAmCpuyPTSRtiFxjDaVs5r1mPbf3xX2ETqmTO0jogTcnVNh7UJ
         sMaPM2XG2tCp9QqQyCFV8I1uoBrgp42jqC+zgF5HTad7fWybLNlsb0Eg0UoJvTgPi6oK
         1749ccF3Qzf+j4gN2yruyVT4RHcFv3LNDb/+v3ALgqcRNcnlWqwxRmm5qyH1V+Os8M4G
         eAGg==
X-Gm-Message-State: AOJu0Yx46M05bx2uJzQDVcZuMCIVKZjw/KKQjaXiZ4Z5b8+8xrAw8Kf6
	8l+t6vmxFixf4GzmP8fmuOuGCm/QjjHD3knroYDlNPfCzA/er3/ewiQivrAv96BMh3VqJkWfRa3
	Rxjst/CJZ4dV6z2kJ6gMp4GJ+Jd4ge6eA2WKY8yIcBw0bzxxy0Xg3kg51snO+OVQWt1WOIJP5um
	PMn4yk6sCJu1xS6e2TZcJfAbK9PdTUh7MJLHzmDA==
X-Google-Smtp-Source: AGHT+IG1a6pW1bKGlaOANRqkZC/AJNE7vuySbOR8Q4Y9nHHY4V5qhn7gR3kjNilliBxESLSlU6pNh5dVgRIG
X-Received: from coldfire.c.googlers.com ([fda3:e722:ac3:cc00:4e:3bc9:ac1c:310])
 (user=maheshb job=sendgmr) by 2002:a25:b810:0:b0:e25:17cb:352e with SMTP id
 3f1490d57ef6-e2919ff850emr3418276.9.1728733674480; Sat, 12 Oct 2024 04:47:54
 -0700 (PDT)
Date: Sat, 12 Oct 2024 04:47:51 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241012114751.2508834-1-maheshb@google.com>
Subject: [PATCHv2 net-next 1/3] mlx4: introduce the time_cache into the mlx4
 PTP implementation
From: Mahesh Bandewar <maheshb@google.com>
To: Netdev <netdev@vger.kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Yishai Hadas <yishaih@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Mahesh Bandewar <mahesh@bandewar.net>, 
	Mahesh Bandewar <maheshb@google.com>
Content-Type: text/plain; charset="UTF-8"

The mlx4_clock_read() function, when invoked by cycle_counter->read(),
previously returned only the raw cycle count. However, for PTP helpers
like gettimex64(), which require both pre- and post-timestamps,
returning just the raw cycles is insufficient; the necessary
timestamps must also be provided.

This patch introduces the time_cache into the implementation. As a
result, mlx4_en_read_clock() is now responsible for reading and
updating the clock_cache. This allows the function
mlx4_en_read_clock_cache() to serve as the cycle reader for
cycle_counter->read(), maintaining the same interface

Signed-off-by: Mahesh Bandewar <maheshb@google.com>
---
 drivers/net/ethernet/mellanox/mlx4/en_clock.c | 28 +++++++++++++++----
 drivers/net/ethernet/mellanox/mlx4/main.c     |  1 -
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h  |  1 +
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_clock.c b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
index cd754cd76bde..cab9221a0b26 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_clock.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
@@ -36,15 +36,22 @@
 
 #include "mlx4_en.h"
 
-/* mlx4_en_read_clock - read raw cycle counter (to be used by time counter)
+/* mlx4_en_read_clock_cache - read cached raw cycle counter (to be
+ * used by time counter)
  */
-static u64 mlx4_en_read_clock(const struct cyclecounter *tc)
+static u64 mlx4_en_read_clock_cache(const struct cyclecounter *tc)
 {
 	struct mlx4_en_dev *mdev =
 		container_of(tc, struct mlx4_en_dev, cycles);
-	struct mlx4_dev *dev = mdev->dev;
 
-	return mlx4_read_clock(dev) & tc->mask;
+	return READ_ONCE(mdev->clock_cache) & tc->mask;
+}
+
+static void mlx4_en_read_clock(struct mlx4_en_dev *mdev)
+{
+	u64 cycles = mlx4_read_clock(mdev->dev);
+
+	WRITE_ONCE(mdev->clock_cache, cycles);
 }
 
 u64 mlx4_en_get_cqe_ts(struct mlx4_cqe *cqe)
@@ -109,6 +116,9 @@ void mlx4_en_ptp_overflow_check(struct mlx4_en_dev *mdev)
 
 	if (timeout) {
 		write_seqlock_irqsave(&mdev->clock_lock, flags);
+		/* refresh the clock_cache */
+		mlx4_en_read_clock(mdev);
+
 		timecounter_read(&mdev->clock);
 		write_sequnlock_irqrestore(&mdev->clock_lock, flags);
 		mdev->last_overflow_check = jiffies;
@@ -135,6 +145,8 @@ static int mlx4_en_phc_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 	mult = (u32)adjust_by_scaled_ppm(mdev->nominal_c_mult, scaled_ppm);
 
 	write_seqlock_irqsave(&mdev->clock_lock, flags);
+	/* refresh the clock_cache */
+	mlx4_en_read_clock(mdev);
 	timecounter_read(&mdev->clock);
 	mdev->cycles.mult = mult;
 	write_sequnlock_irqrestore(&mdev->clock_lock, flags);
@@ -179,6 +191,8 @@ static int mlx4_en_phc_gettime(struct ptp_clock_info *ptp,
 	u64 ns;
 
 	write_seqlock_irqsave(&mdev->clock_lock, flags);
+	/* refresh the clock_cache */
+	mlx4_en_read_clock(mdev);
 	ns = timecounter_read(&mdev->clock);
 	write_sequnlock_irqrestore(&mdev->clock_lock, flags);
 
@@ -205,6 +219,8 @@ static int mlx4_en_phc_settime(struct ptp_clock_info *ptp,
 
 	/* reset the timecounter */
 	write_seqlock_irqsave(&mdev->clock_lock, flags);
+	/* refresh the clock_cache */
+	mlx4_en_read_clock(mdev);
 	timecounter_init(&mdev->clock, &mdev->cycles, ns);
 	write_sequnlock_irqrestore(&mdev->clock_lock, flags);
 
@@ -273,7 +289,7 @@ void mlx4_en_init_timestamp(struct mlx4_en_dev *mdev)
 	seqlock_init(&mdev->clock_lock);
 
 	memset(&mdev->cycles, 0, sizeof(mdev->cycles));
-	mdev->cycles.read = mlx4_en_read_clock;
+	mdev->cycles.read = mlx4_en_read_clock_cache;
 	mdev->cycles.mask = CLOCKSOURCE_MASK(48);
 	mdev->cycles.shift = freq_to_shift(dev->caps.hca_core_clock);
 	mdev->cycles.mult =
@@ -281,6 +297,8 @@ void mlx4_en_init_timestamp(struct mlx4_en_dev *mdev)
 	mdev->nominal_c_mult = mdev->cycles.mult;
 
 	write_seqlock_irqsave(&mdev->clock_lock, flags);
+	/* initialize the clock_cache */
+	mlx4_en_read_clock(mdev);
 	timecounter_init(&mdev->clock, &mdev->cycles,
 			 ktime_to_ns(ktime_get_real()));
 	write_sequnlock_irqrestore(&mdev->clock_lock, flags);
diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c
index febeadfdd5a5..9408313b0f4d 100644
--- a/drivers/net/ethernet/mellanox/mlx4/main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/main.c
@@ -1946,7 +1946,6 @@ u64 mlx4_read_clock(struct mlx4_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mlx4_read_clock);
 
-
 static int map_internal_clock(struct mlx4_dev *dev)
 {
 	struct mlx4_priv *priv = mlx4_priv(dev);
diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
index 28b70dcc652e..077b529eb01a 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4_en.h
@@ -435,6 +435,7 @@ struct mlx4_en_dev {
 	unsigned long		last_overflow_check;
 	struct ptp_clock	*ptp_clock;
 	struct ptp_clock_info	ptp_clock_info;
+	u64			clock_cache;
 	struct notifier_block	netdev_nb;
 	struct notifier_block	mlx_nb;
 };
-- 
2.47.0.rc1.288.g06298d1525-goog


