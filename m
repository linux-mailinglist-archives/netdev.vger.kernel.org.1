Return-Path: <netdev+bounces-226011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CE6B9A932
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 17:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E70DC7BB00A
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 15:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE72030DEC4;
	Wed, 24 Sep 2025 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqGAOMwO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEEE8488
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727347; cv=none; b=bgevxCAyDS91w2fl26UgEcv64jJw4Rh8lIvjavZLoqhVmF+r1jglApusDmroZFAv9syEKl7gK54wFoBYETqdEzI0sBYinqsKw/8pq1o3O9YZ/ta5R1CpF4wlwvF98xSpIoCiriH+jP4x1Hlt4w4f3Y1nnv1voYGFv6uaG6sgY7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727347; c=relaxed/simple;
	bh=FS4csAU4UjODPSrVFMni0m6zQChg9uz5gLxhc+eDh+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CqlYHwc2EvIa6h9Wsx+eY5o4vvthESstQqMmN1UcmlOJ8VfQKcmXP8tITG36xlRW1IGy/lSJ5bRKDzvYWx85oZ/D6Rpx0UP2nsj65Tn9f5HtZwV2m2s2NmVc+4IcM5iWO2QYYtRti3JWABpecbYbG79LNkmKmG3bO0GNqxNeoZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NqGAOMwO; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-4258bd8c19bso10192185ab.2
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 08:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758727345; x=1759332145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GpJzLeRv3JvJ6Rn4+qItSuKPl8oje1EaG6ybTvv5B8g=;
        b=NqGAOMwOBBW4yUoMAVWeMzIY7jxBGG0nujY8MV3krvqjLQO6f3cEwSN4km8hj+1vvP
         HCL+UL76Iwa2QdEaJqPxdQd+A0vtfHf1nzWvpYcmSguZponlereQrs6h5hDVZOl7Ve2b
         m/8ItzFObPEcKnucCGJn1S9Pw5KRcsrqMzYAUGayRiHhpGBFkFCHCU+8Us0s5E5QdeLO
         6UyuDjEzjwPJVUip0lH20o6/LiVkGziIscUVYUufEJKZdt5nG26BIfmT1o9eWE6DRQLR
         YqekAPROxllE6eIIaxC6F1RN2Q7z99oX814VHraP4GyuHDJBFBvwKqTUFkN0CvRBUxpW
         m+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758727345; x=1759332145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GpJzLeRv3JvJ6Rn4+qItSuKPl8oje1EaG6ybTvv5B8g=;
        b=GWsC+DMHefkmv/4iv/vUkjFqZVFn3L4GBcjO/6L3y00QF4Y/BGgaF7G8cTfZSmLFZ1
         fAb9D296JEIj/xM5m1Ev9wwAgLPzINbLE94iqpbpfMJVkd+gR0AVPm6yw2S0+Gg6Kf8x
         LInzjrvGEtRGHywxtcNnEYN3WD4sHgx54XoLxOn8QluMAw2ksQ8TWTpNbvudGDikdo7G
         Ts6tviMw1rgztz/k5idOC+vczpmdeYcZJ9NxabK+EBtAA543B/yOBMEkLNdz+5TY1l/s
         RTCK9fXl0Ez3BNaqVusIjOROK456TjKaS575dPa4hMERPplOO2+RsBxKP8piFRy8cIvq
         ApWA==
X-Gm-Message-State: AOJu0YyIeISZyx5BZo4K7KH+YhsiDXgV46fweveAnKhRFs32Ubm8AVQ/
	zFevV5Tp6kGa24BU98x+dI7YM5Ej5nMiJQ9rqdCQylDXLPMj1ePx2v5AFm+bNA==
X-Gm-Gg: ASbGncvyVJfGw5wqN3ytqvsrN9Cq+FTOWlM7uuk52QbKbIyjLCFC8wznh/5Rxd61bCM
	1Qyhn9+9zRYuG0YcXkvI8N1mW7pnlIILyMLyaJM0QYX+EjuzBBcPZeFwDIkj3qZhoWKB43TNOZn
	hXcT7H0SWEd+l7Rj+/Ybri2f2m9boS5A+GKbRnJMHIEt94nw8OJqjU2RhuxJtn3NgTyEssrqrEq
	ZDclHx6KsTdekL/vNcqewaLId2RYV9fuxlzKi5AD82ZwM/tlqBzsnQV1O3dsfKWJXuRlHVC4LeB
	xCz13z5TV2lC0LQtqy8am0aHV3Vo6kO2Ggd1uZ+JEPAKHKWf+2irIKIX++xSizxvIHXff0TV/pV
	Pktet4POA2oj1Qxaodx3ZQW7HKM0=
X-Google-Smtp-Source: AGHT+IGIwXjPAbpzXy2+r7fwj/06ZO4SrCKju2WlzvWmjdH68NQxMQU95BaeD2UiUHkahmoqPGREIw==
X-Received: by 2002:a05:6e02:228f:b0:3e5:4e4f:65df with SMTP id e9e14a558f8ab-42581e0fb6emr107166725ab.9.1758727344790;
        Wed, 24 Sep 2025 08:22:24 -0700 (PDT)
Received: from orangepi5-plus.lan ([144.24.43.60])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-56150787e91sm2786797173.51.2025.09.24.08.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 08:22:24 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next] net: stmmac: Convert open-coded register polling to helper macro
Date: Wed, 24 Sep 2025 23:22:17 +0800
Message-ID: <20250924152217.10749-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the open-coded register polling routines.
Use readl_poll_timeout_atomic() in atomic state.

Compile tested only.
No functional change intended.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 .../ethernet/stmicro/stmmac/stmmac_hwtstamp.c | 28 ++++---------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index e2840fa241f2..9e445ad1aa77 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -135,7 +135,6 @@ static int init_systime(void __iomem *ioaddr, u32 sec, u32 nsec)
 static int config_addend(void __iomem *ioaddr, u32 addend)
 {
 	u32 value;
-	int limit;
 
 	writel(addend, ioaddr + PTP_TAR);
 	/* issue command to update the addend value */
@@ -144,23 +143,15 @@ static int config_addend(void __iomem *ioaddr, u32 addend)
 	writel(value, ioaddr + PTP_TCR);
 
 	/* wait for present addend update to complete */
-	limit = 10;
-	while (limit--) {
-		if (!(readl(ioaddr + PTP_TCR) & PTP_TCR_TSADDREG))
-			break;
-		mdelay(10);
-	}
-	if (limit < 0)
-		return -EBUSY;
-
-	return 0;
+	return readl_poll_timeout_atomic(ioaddr + PTP_TCR, value,
+				!(value & PTP_TCR_TSADDREG),
+				10, 100000);
 }
 
 static int adjust_systime(void __iomem *ioaddr, u32 sec, u32 nsec,
 		int add_sub, int gmac4)
 {
 	u32 value;
-	int limit;
 
 	if (add_sub) {
 		/* If the new sec value needs to be subtracted with
@@ -187,16 +178,9 @@ static int adjust_systime(void __iomem *ioaddr, u32 sec, u32 nsec,
 	writel(value, ioaddr + PTP_TCR);
 
 	/* wait for present system time adjust/update to complete */
-	limit = 10;
-	while (limit--) {
-		if (!(readl(ioaddr + PTP_TCR) & PTP_TCR_TSUPDT))
-			break;
-		mdelay(10);
-	}
-	if (limit < 0)
-		return -EBUSY;
-
-	return 0;
+	return readl_poll_timeout_atomic(ioaddr + PTP_TCR, value,
+				!(value & PTP_TCR_TSUPDT),
+				10, 100000);
 }
 
 static void get_systime(void __iomem *ioaddr, u64 *systime)
-- 
2.43.0


