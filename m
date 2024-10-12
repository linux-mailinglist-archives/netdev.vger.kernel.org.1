Return-Path: <netdev+bounces-134842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5542099B496
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 13:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03831F25441
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 11:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449EB19CC04;
	Sat, 12 Oct 2024 11:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rZuARbR0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC9519C555
	for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 11:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728733687; cv=none; b=ZRbU7FXaOw8jSx6VFNhwH0yjyWLghcDSCbkjFnWU3cMdHchs3ID5U8Cgmf3mVfr+z5WtRv67hqXLJsge/Ig1IfGwCGD4HLN0E/L5XL6+2QqDIBI4aqhQqR0mZ3qkAE4TLP7WPU7kfrb+ZM/r57dd+6eVxnUnJk3dzjikLexa9g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728733687; c=relaxed/simple;
	bh=FIq3S1rziFzdnFy88UW6etu84Y8qvKY6dst/hCQLK2I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eSPjsWW7omCcJ45CdC9f1PcC57u46Ey52prtf/BfI8ZU9+KTc4uXjgqfwyvh+SpgeWxGsgxVy2zK94pOOePiy/pGNA0r7xLHlTktetREmB77G9sxdEkjWziIneDcU+QghStWjo7JDl9YijQCOw8lw4NlR9E2a6Jys5pzf5JPQjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--maheshb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rZuARbR0; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--maheshb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e22f8dc491so51253867b3.1
        for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 04:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728733684; x=1729338484; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FiRzyXQ9xXdahikMNzOzVXG9Bvdh1qlBmql1pijis9U=;
        b=rZuARbR0RgKROKXwpo/+exdxS9FqezuKCVESx5cqJ4Je2V4yUMNMoyGnL5IP395qsX
         7QkByBgQHQI2TLmKZEQBYroOGldENFxoJL0xqSCMx2nYckLuIJeW6Gjd3hPVEbCkX1EN
         eJfF8/SwagjhuwN4c/u0XpntyCffnj8jkULHvtCRfmww9+b6XgYRGAU1K1GxZHJKhz+G
         QUck2ldTML+UgUV5nVhLBMWkwl8ws3MczvCLjrzbXP16469EahQcZ/ZbWIIExr+VsBfA
         Z3ASU9BtC1P5KOeHyLDIaeVjev8lWP2JkUyrKPm4EADiVxsppaErQN9vSrsFPTdaY3Um
         UpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728733684; x=1729338484;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FiRzyXQ9xXdahikMNzOzVXG9Bvdh1qlBmql1pijis9U=;
        b=avRdLk5ZynIUtueKQoHt7IFsoAJ0v7UU+G+LN+OjLZcO/bQI4dM3u/oNYj78yAFdZ5
         czjUtsDe5A1FotPtVspET52WdzMHAqHKQoC51ukpUjNMSuj5gvjSEzs6933Gpa+NmNV3
         AF1EUIt1OFTX2QW55AW7G/SGHStKGYndZ+X5ujRaf68ShzUJ0r3Uj9KhqzSe6qKNujGD
         S4oY4FRj5K2sCYCkIWZVEGvS1buI5be5XxX7AMWactP5dAv+VV0vDTbfkSsPlLOupIQ2
         qQqAqgHAmaanB7tW110cvZXDHq0eytCQjiH6ia7rImdsKM7v1KGkT1dlh+xEijrJOb+u
         PM6w==
X-Gm-Message-State: AOJu0Yznu3Q8uxCGSRgQrwo//MfWJqumsDuQTHgnZSeiaqWoKPAn3ujr
	SQ1giLQ4ZbQMWs3fix/1vwOsqr1/t+SsizK0Wd2pOf6jlD23ZLRuyd5AwFcdfahoxdHYiqCbqWl
	nj4ptfapbu39/kqB06p6nelDrKWjUSuSNw85iML9KfEAiHGezpHbWAUz5+YBONg+WMttxCZYnVI
	30tYSWabN57Lt4HHSsMlo3SyHPCE5H0S2uqVpeLg==
X-Google-Smtp-Source: AGHT+IFNKApunENsaO1A9Q6f6twMpZseHiJLXQj9C8k/rGbscD/LVbvgDHibTa3iJlMSAxdMbElyUr/mpowy
X-Received: from coldfire.c.googlers.com ([fda3:e722:ac3:cc00:4e:3bc9:ac1c:310])
 (user=maheshb job=sendgmr) by 2002:a05:690c:3304:b0:6e3:f32:5fc8 with SMTP id
 00721157ae682-6e3477bf10cmr140717b3.1.1728733684237; Sat, 12 Oct 2024
 04:48:04 -0700 (PDT)
Date: Sat, 12 Oct 2024 04:48:01 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241012114801.2509341-1-maheshb@google.com>
Subject: [PATCHv2 net-next 3/3] mlx4: add gettimex64() ptp method
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
2.47.0.rc1.288.g06298d1525-goog


