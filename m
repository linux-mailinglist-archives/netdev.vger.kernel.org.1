Return-Path: <netdev+bounces-122922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 344649632BC
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 22:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B448DB231D8
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 20:48:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3911AD3E3;
	Wed, 28 Aug 2024 20:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/2Mf37s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AA41A76B5;
	Wed, 28 Aug 2024 20:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724877699; cv=none; b=JvGPCQUFTIWfile59g8hndnHMMxynvVh8CSY7e/jGM9R/vOf+xnIu0CDZy3fyetYl75ONaRwjkIn3GZUkAriZtmBwxRDHWM9c7ULMBoCZR5q77y/M3eoufwbKWe/MsKCKTFDfk3SOrNqO3YG7Zl0O4lS5KTr/ao6JmxDSwdfo1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724877699; c=relaxed/simple;
	bh=q/FpDL5p/ZR383G9c9VD8IJZyUfZRwCvyuxXsbdfrbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qd9ZLGHWTHWOx1NAuvXSzYnCK3hRsym3prxDNFXgJ7PaPgFqmIKyQ6UDba7lQGHfWtE5gWYmkukDuczBcGMsH5+UmVUVbOwbDQAel7vgBjy8ijpEAtmNUtej34LAHM8VxodtJR8dytgLYAHDWQ2GTqP0vx2BfGPVLpcRGT0XBys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/2Mf37s; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-202146e9538so65519825ad.3;
        Wed, 28 Aug 2024 13:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724877697; x=1725482497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K8wKQdBwMSY0PqXi0G2BoyDS+JfvmaQ+DKG7GTu3UaI=;
        b=l/2Mf37sodaJCmz7SV+ZE5Q5yBBQIAiuqK/nGyG8/JBf/kiYUsHEozv1gH99fLvT9R
         GtiXjOlIBYlDqbbFPwiaeVTroNynVTD7EyAXAMcYDcw5o0EmLoeF2sZRTfgS9GL7vAhE
         LcGu5gw46lAassziV+2VYZMnus6zzzWrbSMDaLXRELCHHdN0Vpv4hIL2jNhaTqDF83DL
         tZ8Y1aXRAGz8Cxt++Kn7rWrzVUCSL0I5lh0om8FOJ/GmA2JVs+Kb/VDNXxSn1UFp6U9+
         er+r2PbTHLiAQIPgweJxpiPjkj5NLERCSdKzAEkERBhD6Utkl/lmw3AQ4DoS5P8r+VVV
         QXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724877697; x=1725482497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K8wKQdBwMSY0PqXi0G2BoyDS+JfvmaQ+DKG7GTu3UaI=;
        b=f5wwkx/f7iJYD2OMgvCQJsjYkXfCgvLZDO1tugXS/K6IDgHGNzPIuR5DTwREQImF5R
         YeZrRtiFdVtJH+tRuvGO3vOXZpRV9j2cfGfp7cafZGlzz77Py2bxtepHjfCgNwu9Xe0o
         f1BX5uo4xslipnN6xoampVAbLqYTqd7Ti28X/sOQ8IQrXrRRT1FXoSPxeihfVV2EJX68
         rAToUE0TEruY1tEYssJKNWWP+FQEkgQpHDtjlUfDLYzt0srpvC1xdGkng6N9BowXotlj
         sTMWNxXHj32YQY5IzDtLQKfPp+BI6kwcIgQ+kdhtrNPfQSvjL+15PcZT0cMvBr6VJr8I
         jHcA==
X-Forwarded-Encrypted: i=1; AJvYcCUI+oQyCN8V1UmO8xyvjGL0J/1R6WFdywSXK3QcYD5M1pagbCsgTy51hmuFn6f65DPFVSPboutcIYdRPlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBsp/r5yn3WkbuJWFMn2lIJJdZbd00IGVJtJ8Taem+JKFhXwi7
	u4WPAx+zwiniyBTomD/puBdC0hU2mU8iBL6jNa6NUvpLCgV2NNHIGWk9dw==
X-Google-Smtp-Source: AGHT+IFzyTzyGdE15dIizsY2T2NWtmfxPTMzZ4bKsHxChogqx053ZMt2BhsyK0+DEsD6jEXqsJkOxA==
X-Received: by 2002:a17:902:ec88:b0:202:bc3:3e6e with SMTP id d9443c01a7336-2050c363669mr7796885ad.33.1724877697330;
        Wed, 28 Aug 2024 13:41:37 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385fbc901sm103206115ad.289.2024.08.28.13.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:41:36 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de,
	p.zabel@pengutronix.de
Subject: [PATCH net-next] net: ag71xx: disable napi interrupts during probe
Date: Wed, 28 Aug 2024 13:41:26 -0700
Message-ID: <20240828204135.6543-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

ag71xx_probe is registering ag71xx_interrupt as handler for gmac0/gmac1
interrupts. The handler is trying to use napi_schedule to handle the
processing of packets. But the netif_napi_add for this device is
called a lot later in ag71xx_probe.

It can therefore happen that a still running gmac0/gmac1 is triggering the
interrupt handler with a bit from AG71XX_INT_POLL set in
AG71XX_REG_INT_STATUS. The handler will then call napi_schedule and the
napi code will crash the system because the ag->napi is not yet
initialized.

The gmcc0/gmac1 must be brought in a state in which it doesn't signal a
AG71XX_INT_POLL related status bits as interrupt before registering the
interrupt handler. ag71xx_hw_start will take care of re-initializing the
AG71XX_REG_INT_ENABLE.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 0674a042e8d3..435c4b19acdd 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -1855,6 +1855,12 @@ static int ag71xx_probe(struct platform_device *pdev)
 	if (!ag->mac_base)
 		return -ENOMEM;
 
+	/* ensure that HW is in manual polling mode before interrupts are
+	 * activated. Otherwise ag71xx_interrupt might call napi_schedule
+	 * before it is initialized by netif_napi_add.
+	 */
+	ag71xx_int_disable(ag, AG71XX_INT_POLL);
+
 	ndev->irq = platform_get_irq(pdev, 0);
 	err = devm_request_irq(&pdev->dev, ndev->irq, ag71xx_interrupt,
 			       0x0, dev_name(&pdev->dev), ndev);
-- 
2.46.0


