Return-Path: <netdev+bounces-133049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 266639945C0
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 12:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A363AB25456
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 10:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D103217D341;
	Tue,  8 Oct 2024 10:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KolskoPQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477002CA8
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 10:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728384415; cv=none; b=c6MsQkUGf13y1oRwZgREwyCiUuhA9DQtf8jz5POAKgHTyxDhFggmF6jI77nZ525k02F5uCGLRcjTSpJUIxff4eVJ3HXXYOJFccCJVW95mk42ImkEy0iQiIlZStdM1sKrZe5oXtstKat9kRg5htHRjXDany9Kq3xuycpZn5TsV14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728384415; c=relaxed/simple;
	bh=2XHKjxhVpP9Cq007Iaww6vwzUAesCqn+KSMnFaYTpyc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DTR+YXWF1K8u4Fl3kjmRuueG7HFhKEh4G0xOrnU8ReYoQQIcvmUf84NYLH3uKV+thXRe4/w53C/l1Yp01fzoB7ChLeIPQ5naYR+nMTUq4Syd3k8yRPw9l0m1Q+ilCJaCs4IAR4Y1pXP3QHeEqudnSZm+RMMPoepyb1V6CTz9gV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maheshb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KolskoPQ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maheshb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e2261adfdeso30070767b3.2
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 03:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728384413; x=1728989213; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8i/iXTll5Mk17033sL9IhZ0hf+ByIYQ9zoCVD93ZzQY=;
        b=KolskoPQK8bKCS/rGttYjfcFVhF74HvpgTUORsNq2vpRtzNELpPk+w6HoKb8U7rOiA
         WXSWlBfDthujBcNh1HPaXy3tDcz0J+xNhbLVOMxn/2GISR9o6Yz42hC0nncjZl7Hepbb
         Ow8GhIX3SJyaSyAkWsc0+D9tu31R8x+ZsJfeuzYTgloqhiCG6xGBy9P5My9PXWJbam70
         J2fxh7PixD8MSaVpdLlO/GVvuHmIvmmTLpbpgren+DriC1QIWhUMadfWCLYrVkoZvIo8
         KY3jwFKBk1g7tPp0YhkuluBPd3hE9VoU5OjcxZj6iAl32GD0PKVj772AYEd4r0S8AwCr
         lZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728384413; x=1728989213;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8i/iXTll5Mk17033sL9IhZ0hf+ByIYQ9zoCVD93ZzQY=;
        b=KD5PHyaKA1ap/J5sQS6uJzQISL8kn1Usi5fB2uzg0hbQNXoToGMMHkbYmrLgcWZ5+J
         1wwTyp/Cm+h+nUVrzjo8Qc6uT9yNu8KtK2xSHerAZN9nEzac8NH2LY2MHw/m4EtRz6/a
         YBNFGarhqQsmsx9v2raVreK8Higsx7sAmHQ2o/F4m2nBwhSLK62zGB5a5q4uqUyYJgFk
         o65RsC2oMb+PpvYhLtcbkHPr8uGjSv9JWVSHyhR89XXlhNAf+rQnhpXH+gvFicUf99nh
         dtHPh0VvDxYtLpSWOy9dN7zx4lRa8FtLA5oYGrTWENhzuF98v5JqJbXMsnVOfXFyITXn
         5VNQ==
X-Gm-Message-State: AOJu0Yw08SaFlDwMynhdzMC96dMR4kxil03D8TUAj+8+mI4kgb88xGzL
	0qwIdus+zNCeljgWxVKRx8F5x2TD4QDoCoognoAociN4PX6pf9miMAiQ6qSQpL4YTMLl1Y4rIIr
	JDa//AasxxCz4YXrhaNnz7Lsha2Rl0ntozUQTSjLK3eg+XM9UwR++sDgVEbGhl6sfrOOJH3DKj0
	Ui52uqDIZPcNyK+M0AdOT326blfHVe8eejpNBJVg==
X-Google-Smtp-Source: AGHT+IEjq1tbUjCASqiGzqJRMUIzL3m1ZKdzWJheWchhVs5I3FPZx/iEuIsiXt/ACm0wCLSG3iwgEtr3VjbV
X-Received: from coldfire.c.googlers.com ([fda3:e722:ac3:cc00:4e:3bc9:ac1c:310])
 (user=maheshb job=sendgmr) by 2002:a25:c54f:0:b0:dfb:22ca:1efd with SMTP id
 3f1490d57ef6-e289394dc24mr54723276.9.1728384412698; Tue, 08 Oct 2024 03:46:52
 -0700 (PDT)
Date: Tue,  8 Oct 2024 03:46:50 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241008104650.3276569-1-maheshb@google.com>
Subject: [PATCH net-next 2/2] mlx4: add gettimex64() ptp method
From: Mahesh Bandewar <maheshb@google.com>
To: Netdev <netdev@vger.kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Yishai Hadas <yishaih@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Mahesh Bandewar <mahesh@bandewar.net>, 
	Mahesh Bandewar <maheshb@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce the gettimex64() PTP method implementation, which enhances
the PTP clock read operation by providing pre- and post-timestamps to
determine the clock-read-call-width.

Signed-off-by: Mahesh Bandewar <maheshb@google.com>
---
 drivers/net/ethernet/mellanox/mlx4/en_clock.c | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_clock.c b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
index 69c5e4c5e036..d3f6ece1531e 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_clock.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
@@ -202,6 +202,26 @@ static int mlx4_en_phc_gettime(struct ptp_clock_info *ptp,
 	return 0;
 }
 
+static int mlx4_en_phc_gettimex(struct ptp_clock_info *ptp,
+				struct timespec64 *ts,
+				struct ptp_system_timestamp *sts)
+{
+	struct mlx4_en_dev *mdev = container_of(ptp, struct mlx4_en_dev,
+						ptp_clock_info);
+	unsigned long flags;
+	u64 ns;
+
+	write_seqlock_irqsave(&mdev->clock_lock, flags);
+	/* refresh the clock_cache but get the pre/post ts */
+	mlx4_en_read_clock(mdev, sts);
+	ns = timecounter_read(&mdev->clock);
+	write_sequnlock_irqrestore(&mdev->clock_lock, flags);
+
+	*ts = ns_to_timespec64(ns);
+
+	return 0;
+}
+
 /**
  * mlx4_en_phc_settime - Set the current time on the hardware clock
  * @ptp: ptp clock structure
@@ -255,6 +275,7 @@ static const struct ptp_clock_info mlx4_en_ptp_clock_info = {
 	.adjfine	= mlx4_en_phc_adjfine,
 	.adjtime	= mlx4_en_phc_adjtime,
 	.gettime64	= mlx4_en_phc_gettime,
+	.gettimex64	= mlx4_en_phc_gettimex,
 	.settime64	= mlx4_en_phc_settime,
 	.enable		= mlx4_en_phc_enable,
 };
-- 
2.47.0.rc0.187.ge670bccf7e-goog


