Return-Path: <netdev+bounces-134841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB2799B495
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 13:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE80A1C235C0
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 11:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F47619C56B;
	Sat, 12 Oct 2024 11:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pifHjNqk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FFF19C555
	for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 11:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728733684; cv=none; b=NnYNgezFG7p+bD7cCI/w9SE4c0CgRUXlvyfywgifBk7ad4eEbXc0HSrovN+Db/e01E14XiWALkl4tDWFtnEp8xsjuWAmvdErPx/LXaqF8NsokBFuuD8c8FMi5QQ6q1w7BSSCpKSEGrvQa5uhipOEAWQYM1MpxdLrrZLWqbzJgk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728733684; c=relaxed/simple;
	bh=1g1b1pXyjZxGa3Qh7WC8Q0JOQpG0CNJqkMWxx8Yuzls=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HzRGB2PNdBnI90uphW3ROunQPICjt80Xr0YqdujPAUo4xmrSYCmF+AJa1JVEc3P4AeIawiwXeEj6rC/w6fNXpXFjA+zmrvO5xca1h9k5qdeQzD62TF7QFUmHMjGDDFEK/parTVlU6C1yruDt4AVFi8wUOBDuuIaoFeVopcgC0gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maheshb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pifHjNqk; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maheshb.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6886cd07673so59923747b3.3
        for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 04:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728733681; x=1729338481; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l0ebcgRIRh90MOHtpCFWoKc1X14VIpR1q5b48hz4kwg=;
        b=pifHjNqkOGUBdr1l7shFlWBDuHonJCjC+XRBl4f9+upAsuiBgA7ikDhgU4SwSar362
         4rm/gVNkpIB2hb3sZxEQSkFSK/D4/zYoAUFqHIVA9rfICOr0+apJJ27Xxk/fN68Xq4E9
         HJxrV8roGnZsfGpAw011ODkZ8LYdbFFqA5V9LJMIl9fS9nfvn/rOt7Pr/wJ+znfLiozH
         AHslwnI9DqOhd56YKiCtKSezKsGTR5vNdTJDEnrEug/PTdYwtzZ75xYZ3HgXwk9MCLCg
         BPeAa8lmVIHHwcCcnQHqSM5NdB83GLVqNlCfoiyCMmPWDS9Zpmx8T/6ovH5m75xXUKwO
         YSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728733681; x=1729338481;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l0ebcgRIRh90MOHtpCFWoKc1X14VIpR1q5b48hz4kwg=;
        b=mpi4QW8Okwb5XzEkdCk5RP2OdZJ8yH8sSjBOMcVn27Yh0fz0VtPEYLSsTHOsec40t+
         FIAlc+GWg6sLgaFYCwgBjmFU/IUodzViRxXgyIPV+/ZpnjTZvqjGoYLuWCN04a9j97ze
         56V1JRYbw7D/Kx6GkoJxIuL9ucD/py+qtBM75bjb8S2TC2bCe8Sd8Jthld6Ig7Rkp69q
         SIsdeZw08/An07bEM3zOy0SNjACJ0k8djcprGVHV/ryRpipPZqdUkIZaCkOUZmjPjZ74
         qZUYICWbrK0m4szp/ARDgZqRFArQoeT2qPK1+Emq4FMPYAbrpuateJkyDn264RFyZyUg
         OW/A==
X-Gm-Message-State: AOJu0YyipY9WIxrkl+euwJsdD4ZAnMTbAihNJ3HCWN0zstDH3mNbl2Mv
	AkYvZacaOiUwy3DmBMttMD72yjb92vIXMKgpQhHWuIWWzKME8FZ9rTnZuZYZopYdYLtFdjc5OTL
	YGt+F60dOnpEcbVKnWVNOEh67trooMkjmZ3dUmiurkbtc+vn5Ujoa3f8t93DADJr0eynuaRWlg0
	/xzlPEWKPhAqcACijEW4Peg/boDb8b9uxfUL+YoQ==
X-Google-Smtp-Source: AGHT+IHBcjkOzufjEfEoPQNGwufFOu2yHyx49mK+6RbzmHVvWGQyI/65rI0vW1TEmJHlur6M6YIduz03sT+/
X-Received: from coldfire.c.googlers.com ([fda3:e722:ac3:cc00:4e:3bc9:ac1c:310])
 (user=maheshb job=sendgmr) by 2002:a05:690c:7446:b0:62c:f6fd:5401 with SMTP
 id 00721157ae682-6e347b4b2edmr294907b3.6.1728733680865; Sat, 12 Oct 2024
 04:48:00 -0700 (PDT)
Date: Sat, 12 Oct 2024 04:47:54 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241012114755.2509083-1-maheshb@google.com>
Subject: [PATCHv2 net-next 2/3] mlx4: update mlx4_read_clock() to provide
 pre/post timestamps
From: Mahesh Bandewar <maheshb@google.com>
To: Netdev <netdev@vger.kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Yishai Hadas <yishaih@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Mahesh Bandewar <mahesh@bandewar.net>, 
	Mahesh Bandewar <maheshb@google.com>
Content-Type: text/plain; charset="UTF-8"

Enhance mlx4_read_clock() and mlx4_en_read_clock() to provide
both pre- and post-timestamps along with the raw cycle count,
which are required to support the gettimex64() operation.

Signed-off-by: Mahesh Bandewar <maheshb@google.com>
---
 drivers/net/ethernet/mellanox/mlx4/en_clock.c | 15 ++++++++-------
 drivers/net/ethernet/mellanox/mlx4/main.c     | 11 +++++++++--
 include/linux/mlx4/device.h                   |  3 ++-
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_clock.c b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
index cab9221a0b26..69c5e4c5e036 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_clock.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
@@ -47,9 +47,10 @@ static u64 mlx4_en_read_clock_cache(const struct cyclecounter *tc)
 	return READ_ONCE(mdev->clock_cache) & tc->mask;
 }
 
-static void mlx4_en_read_clock(struct mlx4_en_dev *mdev)
+static void mlx4_en_read_clock(struct mlx4_en_dev *mdev,
+			       struct ptp_system_timestamp *sts)
 {
-	u64 cycles = mlx4_read_clock(mdev->dev);
+	u64 cycles = mlx4_read_clock(mdev->dev, sts);
 
 	WRITE_ONCE(mdev->clock_cache, cycles);
 }
@@ -117,7 +118,7 @@ void mlx4_en_ptp_overflow_check(struct mlx4_en_dev *mdev)
 	if (timeout) {
 		write_seqlock_irqsave(&mdev->clock_lock, flags);
 		/* refresh the clock_cache */
-		mlx4_en_read_clock(mdev);
+		mlx4_en_read_clock(mdev, NULL);
 
 		timecounter_read(&mdev->clock);
 		write_sequnlock_irqrestore(&mdev->clock_lock, flags);
@@ -146,7 +147,7 @@ static int mlx4_en_phc_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 
 	write_seqlock_irqsave(&mdev->clock_lock, flags);
 	/* refresh the clock_cache */
-	mlx4_en_read_clock(mdev);
+	mlx4_en_read_clock(mdev, NULL);
 	timecounter_read(&mdev->clock);
 	mdev->cycles.mult = mult;
 	write_sequnlock_irqrestore(&mdev->clock_lock, flags);
@@ -192,7 +193,7 @@ static int mlx4_en_phc_gettime(struct ptp_clock_info *ptp,
 
 	write_seqlock_irqsave(&mdev->clock_lock, flags);
 	/* refresh the clock_cache */
-	mlx4_en_read_clock(mdev);
+	mlx4_en_read_clock(mdev, NULL);
 	ns = timecounter_read(&mdev->clock);
 	write_sequnlock_irqrestore(&mdev->clock_lock, flags);
 
@@ -220,7 +221,7 @@ static int mlx4_en_phc_settime(struct ptp_clock_info *ptp,
 	/* reset the timecounter */
 	write_seqlock_irqsave(&mdev->clock_lock, flags);
 	/* refresh the clock_cache */
-	mlx4_en_read_clock(mdev);
+	mlx4_en_read_clock(mdev, NULL);
 	timecounter_init(&mdev->clock, &mdev->cycles, ns);
 	write_sequnlock_irqrestore(&mdev->clock_lock, flags);
 
@@ -298,7 +299,7 @@ void mlx4_en_init_timestamp(struct mlx4_en_dev *mdev)
 
 	write_seqlock_irqsave(&mdev->clock_lock, flags);
 	/* initialize the clock_cache */
-	mlx4_en_read_clock(mdev);
+	mlx4_en_read_clock(mdev, NULL);
 	timecounter_init(&mdev->clock, &mdev->cycles,
 			 ktime_to_ns(ktime_get_real()));
 	write_sequnlock_irqrestore(&mdev->clock_lock, flags);
diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c
index 9408313b0f4d..d9ef6006ada3 100644
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
2.47.0.rc1.288.g06298d1525-goog


