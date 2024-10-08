Return-Path: <netdev+bounces-133048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AE09945BF
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 12:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 207D62825F5
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 10:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFD61C75F8;
	Tue,  8 Oct 2024 10:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nDTGzjsH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2033C2CA8
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 10:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728384412; cv=none; b=j7zRJzLOkcL4xvam1qfYRgkA+wKFmAoRsZUUPxN8iAFCyd4DJilQjjJcrvMCN3IIumdU63Gv057HIw6TChJXpntwm1vgW1DIIZNp1k9JeO8xKZPXLNyBHV5P6ZCGiZLaBiugYUwLA7BOtGwITbwb2q18IDbzQfAM8XQbMxUbSqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728384412; c=relaxed/simple;
	bh=UoAmwboXfl0dx/n5vCKy+W8UiCGvZRSMA44T82ncDk8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=G28Cpuc5p1XdCDq2+5//LF9Ja4qOvHrTnPz5NxHgD907yC/0dv+2vdKyuogfT/FzDzRx9q7C/6DBS/s46ZcobVk1qo1UNkDTwtU4Dn2l1yEthu2zaXT9yXOM9H9SXrVujYerSeRX489yrqnIERdApZD9UQBPNpC/MmG/V6ecJTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maheshb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nDTGzjsH; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maheshb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e2261adfdeso30070457b3.2
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 03:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728384410; x=1728989210; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cKHufooOccIS9KZNeyuA3tgPNAqmcVGZkAa71qf3l1I=;
        b=nDTGzjsHRWXwoDgsy3DWsWvBQPf7VBDH5CrSp4r+XVSnr7+4I62UW1vMlkaeT00AKh
         nj1pXd5Z45xGLgbOMo0gSfPjjq9JGKI7Yqn0608Vw5qwcMmL25dMvQg7sYNC33XSu1te
         7nMq4bVasgCK9e8THttDzEOARvxrqcXAw2J6lAjewomEjS+9pYEzsudOJgncRLOI3x73
         97zx+OYFKgDSzFmm996WmjbhZmtEbz8hvr65+u6b/e+LCy61YONskh/jUbbk/oXR0y/e
         UvvqhFYhN5R7/Cn3XijyXj/qJASH/43eFGrD9ee0MhjL9CiGalaxSUWo/pUxecSJmQyx
         i3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728384410; x=1728989210;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cKHufooOccIS9KZNeyuA3tgPNAqmcVGZkAa71qf3l1I=;
        b=DdkA0w5v12vL1wQhI8+4Gpr7BXWLe4m9QvkBErKvb7S1onatCMLQ6s1MadiwPNDQsF
         N1/1U7gJuOIb8QnbmXuftQqR0IRQNGxyQ9ELUq4sy4SOrcv4mbZe8u7rj9Mb3bSZHfrF
         LroIy+j2+Q1WtNTVZQoSOYT3bWGqgECA61h1CZsGh1pAKUG1PgcRGXGI5e8MKOnqNin1
         8R12vRIjfdLDSRdMwvg+sNckFTFri9GUFS1Lh3UvjArezHSaZxVhWGl1f4gIif96uvnJ
         hY9YNSHt64RQnoUy/WrEX2mdRypcI0XzuZKWEMQrrrderQX5PekInEEf5sURoyKPYp4J
         5zbg==
X-Gm-Message-State: AOJu0YxNJijUmzLwT/v3Oa016o+cKe+hSwn7yn8/4Kzv9cdom1BNZvL+
	bN6N6phbI4p0YlFrJRJ4FnrbqHpyue3FLtfUBNXZlJX2bvbPqUucbLzC3AxcXWSYJvpeqe7DMb0
	0q8E3caQXJ8+IBQC4U1vjw4D7/JfMDoLDTApTGOtkHrgsFoi1v06VpyRT4YjpbE1qngBFa1gpjF
	SyrXkxcE0L14v6qJe2j0+cpEczxxvxDxTxJQVFew==
X-Google-Smtp-Source: AGHT+IEZgvBEinujL2m7WuZWWUfhujmWUFsaspwSBwafWFHCt0vAe9RAr5KymVeSFDLrVoG+UMxuU4P3p213
X-Received: from coldfire.c.googlers.com ([fda3:e722:ac3:cc00:4e:3bc9:ac1c:310])
 (user=maheshb job=sendgmr) by 2002:a05:690c:4601:b0:6e3:1702:b3d8 with SMTP
 id 00721157ae682-6e31702d261mr63077b3.2.1728384409673; Tue, 08 Oct 2024
 03:46:49 -0700 (PDT)
Date: Tue,  8 Oct 2024 03:46:46 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241008104646.3276302-1-maheshb@google.com>
Subject: [PATCH net-next 1/2] mlx4: update mlx4_clock_read() to provide
 pre/post tstamps
From: Mahesh Bandewar <maheshb@google.com>
To: Netdev <netdev@vger.kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Yishai Hadas <yishaih@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Mahesh Bandewar <mahesh@bandewar.net>, 
	Mahesh Bandewar <maheshb@google.com>
Content-Type: text/plain; charset="UTF-8"

The mlx4_clock_read() function, when called by cycle_counter->read(),
previously only returned the raw cycle count. However, for PTP helpers
like gettimex64(), which require pre- and post-timestamps, simply
returning raw cycles is insufficient. It also needs to provide the
necessary timestamps.

This update modifies mlx4_clock_read() to return both the cycles and
the required timestamps. Additionally, mlx4_en_read_clock() is now
responsible for reading and updating the clock_cache. This allows
another function, mlx4_en_read_clock_cache(), to act as the cycle
reader for cycle_counter->read(), preserving the same interface.

Signed-off-by: Mahesh Bandewar <maheshb@google.com>
---
 drivers/net/ethernet/mellanox/mlx4/en_clock.c | 29 +++++++++++++++----
 drivers/net/ethernet/mellanox/mlx4/main.c     | 12 ++++++--
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h  |  1 +
 include/linux/mlx4/device.h                   |  3 +-
 4 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_clock.c b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
index cd754cd76bde..69c5e4c5e036 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_clock.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
@@ -36,15 +36,23 @@
 
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
+static void mlx4_en_read_clock(struct mlx4_en_dev *mdev,
+			       struct ptp_system_timestamp *sts)
+{
+	u64 cycles = mlx4_read_clock(mdev->dev, sts);
+
+	WRITE_ONCE(mdev->clock_cache, cycles);
 }
 
 u64 mlx4_en_get_cqe_ts(struct mlx4_cqe *cqe)
@@ -109,6 +117,9 @@ void mlx4_en_ptp_overflow_check(struct mlx4_en_dev *mdev)
 
 	if (timeout) {
 		write_seqlock_irqsave(&mdev->clock_lock, flags);
+		/* refresh the clock_cache */
+		mlx4_en_read_clock(mdev, NULL);
+
 		timecounter_read(&mdev->clock);
 		write_sequnlock_irqrestore(&mdev->clock_lock, flags);
 		mdev->last_overflow_check = jiffies;
@@ -135,6 +146,8 @@ static int mlx4_en_phc_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 	mult = (u32)adjust_by_scaled_ppm(mdev->nominal_c_mult, scaled_ppm);
 
 	write_seqlock_irqsave(&mdev->clock_lock, flags);
+	/* refresh the clock_cache */
+	mlx4_en_read_clock(mdev, NULL);
 	timecounter_read(&mdev->clock);
 	mdev->cycles.mult = mult;
 	write_sequnlock_irqrestore(&mdev->clock_lock, flags);
@@ -179,6 +192,8 @@ static int mlx4_en_phc_gettime(struct ptp_clock_info *ptp,
 	u64 ns;
 
 	write_seqlock_irqsave(&mdev->clock_lock, flags);
+	/* refresh the clock_cache */
+	mlx4_en_read_clock(mdev, NULL);
 	ns = timecounter_read(&mdev->clock);
 	write_sequnlock_irqrestore(&mdev->clock_lock, flags);
 
@@ -205,6 +220,8 @@ static int mlx4_en_phc_settime(struct ptp_clock_info *ptp,
 
 	/* reset the timecounter */
 	write_seqlock_irqsave(&mdev->clock_lock, flags);
+	/* refresh the clock_cache */
+	mlx4_en_read_clock(mdev, NULL);
 	timecounter_init(&mdev->clock, &mdev->cycles, ns);
 	write_sequnlock_irqrestore(&mdev->clock_lock, flags);
 
@@ -273,7 +290,7 @@ void mlx4_en_init_timestamp(struct mlx4_en_dev *mdev)
 	seqlock_init(&mdev->clock_lock);
 
 	memset(&mdev->cycles, 0, sizeof(mdev->cycles));
-	mdev->cycles.read = mlx4_en_read_clock;
+	mdev->cycles.read = mlx4_en_read_clock_cache;
 	mdev->cycles.mask = CLOCKSOURCE_MASK(48);
 	mdev->cycles.shift = freq_to_shift(dev->caps.hca_core_clock);
 	mdev->cycles.mult =
@@ -281,6 +298,8 @@ void mlx4_en_init_timestamp(struct mlx4_en_dev *mdev)
 	mdev->nominal_c_mult = mdev->cycles.mult;
 
 	write_seqlock_irqsave(&mdev->clock_lock, flags);
+	/* initialize the clock_cache */
+	mlx4_en_read_clock(mdev, NULL);
 	timecounter_init(&mdev->clock, &mdev->cycles,
 			 ktime_to_ns(ktime_get_real()));
 	write_sequnlock_irqrestore(&mdev->clock_lock, flags);
diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c
index febeadfdd5a5..d9ef6006ada3 100644
--- a/drivers/net/ethernet/mellanox/mlx4/main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/main.c
@@ -43,6 +43,7 @@
 #include <linux/io-mapping.h>
 #include <linux/delay.h>
 #include <linux/etherdevice.h>
+#include <linux/ptp_clock_kernel.h>
 #include <net/devlink.h>
 
 #include <uapi/rdma/mlx4-abi.h>
@@ -1925,7 +1926,7 @@ static void unmap_bf_area(struct mlx4_dev *dev)
 		io_mapping_free(mlx4_priv(dev)->bf_mapping);
 }
 
-u64 mlx4_read_clock(struct mlx4_dev *dev)
+u64 mlx4_read_clock(struct mlx4_dev *dev, struct ptp_system_timestamp *sts)
 {
 	u32 clockhi, clocklo, clockhi1;
 	u64 cycles;
@@ -1933,7 +1934,13 @@ u64 mlx4_read_clock(struct mlx4_dev *dev)
 	struct mlx4_priv *priv = mlx4_priv(dev);
 
 	for (i = 0; i < 10; i++) {
-		clockhi = swab32(readl(priv->clock_mapping));
+		if (sts) {
+			ptp_read_system_prets(sts);
+			clockhi = swab32(readl(priv->clock_mapping));
+			ptp_read_system_postts(sts);
+		} else {
+			clockhi = swab32(readl(priv->clock_mapping));
+		}
 		clocklo = swab32(readl(priv->clock_mapping + 4));
 		clockhi1 = swab32(readl(priv->clock_mapping));
 		if (clockhi == clockhi1)
@@ -1946,7 +1953,6 @@ u64 mlx4_read_clock(struct mlx4_dev *dev)
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
diff --git a/include/linux/mlx4/device.h b/include/linux/mlx4/device.h
index 27f42f713c89..265accc4e606 100644
--- a/include/linux/mlx4/device.h
+++ b/include/linux/mlx4/device.h
@@ -44,6 +44,7 @@
 #include <linux/refcount.h>
 
 #include <linux/timecounter.h>
+#include <linux/ptp_clock_kernel.h>
 
 #define DEFAULT_UAR_PAGE_SHIFT  12
 
@@ -1483,7 +1484,7 @@ int mlx4_get_roce_gid_from_slave(struct mlx4_dev *dev, int port, int slave_id,
 int mlx4_FLOW_STEERING_IB_UC_QP_RANGE(struct mlx4_dev *dev, u32 min_range_qpn,
 				      u32 max_range_qpn);
 
-u64 mlx4_read_clock(struct mlx4_dev *dev);
+u64 mlx4_read_clock(struct mlx4_dev *dev, struct ptp_system_timestamp *sts);
 
 struct mlx4_active_ports {
 	DECLARE_BITMAP(ports, MLX4_MAX_PORTS);
-- 
2.47.0.rc0.187.ge670bccf7e-goog


