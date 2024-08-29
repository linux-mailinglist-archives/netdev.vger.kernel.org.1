Return-Path: <netdev+bounces-123518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A19965253
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 23:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5E51F227B1
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 21:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC641BD509;
	Thu, 29 Aug 2024 21:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1qLp3sX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6D41BCA1C;
	Thu, 29 Aug 2024 21:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724968131; cv=none; b=Z4tD8m9xkOR4411mgYAc2KPHHQBEP2DDnhHOxAdkWPT4+4Mi/5X+u40/acgw5EPtZp1rXpMS5SI7+hfoWzwIMRtzOLT7bBqDB1NCzmuQqNyBvyptuOrMOw355BtJPJTiRIgYCMu19c0Ffx2bk69v5/yM5IJ9sm7qVx5KbLG6nDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724968131; c=relaxed/simple;
	bh=ucTcsAY+kqN9GzD+02gq+D/PB42c0LiyiuaTnWEmv5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErBAxJt1aj0r6+e0U32lKtypf3cRf2iV1Vvl4c0vV6vVhcFimr5flYjA1BteAAfJdM2FCavEe1NYMK9Hi7BxHlvy4pkpZkPqc10x7wa+tRcVuRhNIAbQ4yJhHLy2vsOdKQn/uylp6YgK2mIqW1mFHFGiADGbUC44GIbm1qxxE18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1qLp3sX; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5dca997d29eso713646eaf.0;
        Thu, 29 Aug 2024 14:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724968128; x=1725572928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gxwfyCvWJYGaspIUiHH0ZRh6kN2LUZgRd1LYhB+9q8=;
        b=k1qLp3sXjnEcillV6S5QHAZjr0VcBfzS9QvJHltiyKDORKg+AAGG2M7c/Xo41Mmdcr
         VChSBT7VJBi8i8qbJtAVGF597yAZYIg35diEZXuDOEMFC3gdYsrOJCg6zk7iISaq64/L
         3xJY7KUUJQlOhMtm3gUqXDS2Kj8bQKuxEwSgajwiCmqojI+svd9z96/EYYoH3cnVFkfi
         acNPflbZuvyH0nqKbf0qpmSSVyylvTLa1Dm8ff6LvXXvXKJdI238qRKByu6wuTDEMNmx
         Vh15bJWKMl26+Y84Key1yisO6m2OX4o77CqZC6SAxp49wuXbfQyt0I/4N8MGAqFd3FBZ
         HLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724968128; x=1725572928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gxwfyCvWJYGaspIUiHH0ZRh6kN2LUZgRd1LYhB+9q8=;
        b=WHq6nkCfJWzvM9r66OLoh2H6EYZaShSiD+P0ZtE6B3f7mwkWzseqIhaRjGBcIOk1NL
         WdGT7Orw2qLiHEUrkuquV73qm3KCPxuD6ZJf25haM42OWbPgMkr+h8wIz1x75FHh9QOG
         krBfT1JXYBMGsDTdXTbOFcvo8J4eExpk0pogWlDWYk/NKBVWuhc+mt59VZgXpCPAYaRV
         8Pf5idxzZZkw03SM/vRxc2LNYAWOsj4G18J04Enli2AH+o0IgKmsRWBkwSYz4navS1w7
         vb0SXyeRCr4t+gC+fR7gDC2d4/xmddxRNjkS42V9wVPZ7FSNlNHh1mI2ne1/k1Demwjz
         50wQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTjSSg/eS68lfGdIcmvODD4+m1D5xkLmD+gJWmCmvp4EoletZncovRD/G4/3KiGJE83QcFvybXZCi1u2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzblLnw32B63BfPc2HznNyM7YPAsR/hWoVAlEvffrJM+GDMnBAc
	C2w5OKe2jCaEVzS+gYLWhAMdpqlKKhDFsLO69XrCAa2F1aFYvlRg4+eyAD8v
X-Google-Smtp-Source: AGHT+IHLKgMKoACCj+QUc4FceJpLB40WftvMxz3Koeq+UmBJcRt3Os0ofDailBmKn6qcWzklQ9cfpQ==
X-Received: by 2002:a05:6359:4c9f:b0:1b5:c561:a29e with SMTP id e5c5f4694b2df-1b603c01f2dmr522723855d.1.1724968128533;
        Thu, 29 Aug 2024 14:48:48 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e77a7besm1708029a12.37.2024.08.29.14.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 14:48:47 -0700 (PDT)
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
Subject: [PATCH net-next 6/6] net: ag71xx: disable napi interrupts during probe
Date: Thu, 29 Aug 2024 14:48:25 -0700
Message-ID: <20240829214838.2235031-7-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829214838.2235031-1-rosenp@gmail.com>
References: <20240829214838.2235031-1-rosenp@gmail.com>
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

This will become relevant when dual GMAC devices get added here.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 25e9de9aedbc..ed47914a0e0c 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -1850,6 +1850,12 @@ static int ag71xx_probe(struct platform_device *pdev)
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


