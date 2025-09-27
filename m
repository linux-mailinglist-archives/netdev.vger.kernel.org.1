Return-Path: <netdev+bounces-226855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A384BA5A95
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 10:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94DB01BC65EA
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 08:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F3D2D47EF;
	Sat, 27 Sep 2025 08:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBWZEy5n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353D12D46B6
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 08:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758960654; cv=none; b=LZ+4zu1IcHT/xvdfD2L+ABYuvqfV/pgvxXiXMdr3sx+nrv6s0Xc/zx8EJQtBq0R3nITgFRQwNBUzPWx6koVVF72xFiIpWGH53c5dNgvplq1I2tKSAEVWx5pvf7E6FwGHx5k3/zNXQSMqlgV9Fffk+fQAN2osfWNyS7Gv9/+rMOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758960654; c=relaxed/simple;
	bh=ASAoL0wewSEbqehJdlhPMOC6Yab6jICgC6v+92dmYUE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gFcHzDouvdRRMsAr1DNplj6M/XSfWPE00Me4dZVjaISdmJ6N5k3jdHoYGaABZPZHUbh2BpNcuembRrIOSxkE707uVmZ8BALnd96UC9L5XUhZkpKQ/MPJ0DjTO1LgQOtAWyqpaqM0wLvgZiMRTC+LqonY+DIBmOZmSabeT/L4I2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBWZEy5n; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-90b79f42d15so82594839f.3
        for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 01:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758960652; x=1759565452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lQUetzEQMP4LAhqW9E/G21GQbOBqRaYhD1bJwLd7FZQ=;
        b=KBWZEy5nzzZ2sC3Gzd8pDpzBD1RWGPXxynpzUUTF1HbtCZDexGifo7xUMidYpIKPT/
         5cauUbBkMsVtQI0Z4irm8Hb6oGmoUJvEN9hv+hozcmUH3ypnO6jWkcuFkp26qO6i+HN9
         j2gWsc3wovepv8w1ySK6XAgbZCj66lS9LDXapyNsN5S/VponoqcT10SwSoSYmBEteO8x
         hhad31Ed+fvHKOZIHOVR8DJJfDaxOSeVdV5GA0Pcig6d/flExbJ9kTv8J6v/FflgXJbf
         W5ITKxBsdGY4W8TNmP8AJxylu4BiFWtGn4TO0eG+FzKgjzOu2TktfcKmq3jBvy/ZWs9W
         mr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758960652; x=1759565452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lQUetzEQMP4LAhqW9E/G21GQbOBqRaYhD1bJwLd7FZQ=;
        b=irHmlrXCpfFeDFCU9MLj2Eo8FEhkrBEveqE3zPOtL87wH2DnoXjAwkmlfRCdIhg6c/
         cEzDcETusiRe5v8nBnq5U56/Ca1c1osfLKAQ5+SRrMkYW0GY0tsbcfPe2/1GAvxO30Ob
         m/bCvRar5Zb7fzAJ1dCtYscJIIxqzILtYVRJkJ7qqS6e2aeATEg7eYpaWrlTDRZy6XyU
         11GPOGy/r83uxP31wibZ0VPoy53V91i6p6quaMMNm4XEAQHkdIS0sXUeDioGPEtS7eSP
         Yqif42h9OBP/2w790o4xpHAC0DDR4TKowRl5Jv/94f7praJx7pN0XsvgAMwfYG6jT0jC
         bhqg==
X-Gm-Message-State: AOJu0YwvLKEQ4EYHxQjXPI/cpUGo6rQaEuIRq0Odvf3Y3mmdcrLq7tBP
	R2woS5/oh9bIR8G/ZNlBIfCTf2jRU/RCyLKQawoT0yxeO3lG680kxWx9ZZFKnQ==
X-Gm-Gg: ASbGncvZah51O6/mHa0Ogm6YUZJ9r/KFMUMFoldR7y8Gvwa/Jn5wxvRoGZvBDa5z/oP
	n+AHDQJJD3xA0+IguSJ3wL5f6VLvZvHNJnJUFsLrjI89ago/kqSlD14NaMvyPOUYZ8tKoRb/eFM
	+TlV3084ys2iwpEjBaawj9Grtd/jHfZ18hlE6KtzkxvkkE0dz5Q6o3rqQR62nGxHVUHODlRg6lu
	Uc61SHkX8lanqsj/M7RBSboxi0OGPB/MMv17AT2d0OrpmLARFkr2u1c3MAXr/B80EVIHKy5kQRi
	Hx1f9PgOHwaiOXdRvIYNL4p7iGHNTH0MIM/nP3LY2sKEoOEk/xB0oUlPntl5ucfjueW78/NfS1A
	wdXQ1Q/ElDD/GfL7ksxsdESBuExZpNc/aMaJ1rw==
X-Google-Smtp-Source: AGHT+IH0IVO5vzLeRO4V6lWOrPlzDHkhJS4CVNTknktDnTu3FcBbSqcFVPYeFHLy8GA/XY52U+1p6w==
X-Received: by 2002:a05:6e02:1a27:b0:426:5a34:77ec with SMTP id e9e14a558f8ab-4265a347968mr138432705ab.11.1758960651856;
        Sat, 27 Sep 2025 01:10:51 -0700 (PDT)
Received: from orangepi5-plus.lan ([144.24.43.60])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4282de12fc8sm10852155ab.3.2025.09.27.01.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 01:10:51 -0700 (PDT)
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
	Furong Xu <0x1207@gmail.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v2] net: stmmac: Convert open-coded register polling to helper macro
Date: Sat, 27 Sep 2025 16:10:36 +0800
Message-ID: <20250927081036.10611-1-0x1207@gmail.com>
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

Also adjust the delay time to 10us which seems more reasonable.

Tested on NXP i.MX8MP and ROCKCHIP RK3588 boards,
the break condition was met right after the first polling,
no delay involved at all.
So the 10us delay should be long enough for most cases.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Furong Xu <0x1207@gmail.com>
---
V1 -> V2: fix code alignment, update commit message
V1: https://lore.kernel.org/all/20250924152217.10749-1-0x1207@gmail.com/
---
 .../ethernet/stmicro/stmmac/stmmac_hwtstamp.c | 28 ++++---------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index e2840fa241f2..bb110124f21e 100644
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
+					 !(value & PTP_TCR_TSADDREG),
+					 10, 100000);
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
+					 !(value & PTP_TCR_TSUPDT),
+					 10, 100000);
 }
 
 static void get_systime(void __iomem *ioaddr, u64 *systime)
-- 
2.43.0


