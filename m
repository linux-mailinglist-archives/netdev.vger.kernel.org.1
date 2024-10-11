Return-Path: <netdev+bounces-134688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EB499AD30
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 21:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 175341F23073
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 19:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE6E1E202D;
	Fri, 11 Oct 2024 19:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dq+FPWu3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF0A1DC182;
	Fri, 11 Oct 2024 19:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728676593; cv=none; b=VDTye1grCxcG+DQsY7771G5UYW/sJkTu44nvSZpZdOkB4SEnYW5KHWBEKiG+Ku/zUZChynVo8TcqG+e7IS9Rn4BoKMBV7QtJ7D9lk9GDN/2dNL/4Up3pQHrItMvZjo0NioxgYNdOFoZhY3rYQ1HLHP9cWJNdVf+pEfqTnv1pv1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728676593; c=relaxed/simple;
	bh=QV1W4Kc4VLGRNtRwL6p3Ya8X6twJW+la+Nteg5jhrpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgnBJ3op9BVcGhmD5Xyx5jYOpT/oRfOzXDBKhIWPfPEnajpX2FArJpe5iDM4YHzbxzw6xTuvsCxzhF5AmEl59wsQaruCCk0aNKgSarQJsyFSo3xRMGnCrkE6hoz7bpiN+qKcpamXs20PXyY7dDRnW0A+XpuVxxoabiIc27cySC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dq+FPWu3; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a3bb6a020dso1832595ab.2;
        Fri, 11 Oct 2024 12:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728676591; x=1729281391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5gK0xTOYXUXTEJtX13WwQH4aVPq/amuVyUotISmIoU=;
        b=Dq+FPWu3TFHPTOTUE7sCZAB0Z2rFq2Yu3lhUS6bp9D7zhP1/zJPl2NCzS0vZ3lfTYC
         RQOv7vGaGqtIZNyHCxhcZg6atac6QXzYmlngw4QzAQ6BCM98sdkWCU6dcsWoXbct9Qkx
         fl8LGSreMTQqmvelAz22H4BfLawN9d4D+yX9gi2HClDBBGkKQD6cFABuJtmGkzxGFNTO
         bT9Zo6GBR6gWus3RN8D+mkCJ9YVyojC2Gk/XqvAGjvKDT4gkK5jNZGNPBC/vmCVRuvPg
         GbO1x8jqXnPOIeM8A9OIjeS4VV60lWY2DYUnKrZOk+RGrlPJ4KkFAdGnsSOG5ekTIuta
         SAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728676591; x=1729281391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5gK0xTOYXUXTEJtX13WwQH4aVPq/amuVyUotISmIoU=;
        b=tuSrk4OqxhpM9eTCvj7xLczHiclJd5fXdvHh5jw9BUNiaMO4PAxKv7ZdN6bh5pmUcC
         DjFDmrFLxE+WKAtzUTR5coOH1ZJPa/9eGzo9cHqR6TglHXF5eMOsANMrJ6VI8BZ3/JXK
         d+MD7CfzF5LVrBpW3AedKz7NP5lqE6CBAcwfuPJUW/o/E+vGSTOwSame9zM33DiAZKpb
         cBA3J4i39zaD1Xo2RzDPzTQToF6M823C0D/osRaWB542JQ79wC/NeMbOfNnLp3S8gI+E
         rNxdYjGCPK+XLVmGfdQx7k/vA/P8OAMZaRp1IzoOUyAXHtX6cXvmP/i+y2bkKY96u2HB
         4j3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXfEMscg0+xW3lE0jiJ4MQlrtCQp40xDxnAXR16yCMH7tCqK1PZAd5CfxCKnY/G/V7qXvKEPMo8VmyLKkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuksOOWO5P0Re7bhwvlMCQii3JdseJhJOmr7ePxayMnokG5mGm
	foz/uACX0XYiGD1/2VU7JUkvYRyqHKWC9b0+IKC8rZzfB3np/ePqwTD5B55W
X-Google-Smtp-Source: AGHT+IE6qVJXB0PklUn7SNveERcWh5F3gMsKRfzV536/jy+qw94Smr5y03U2tQFe9f2vX0deaQh7uA==
X-Received: by 2002:a05:6e02:1d15:b0:3a0:9238:d38 with SMTP id e9e14a558f8ab-3a3b5f95ee6mr32901115ab.10.1728676591045;
        Fri, 11 Oct 2024 12:56:31 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea44907ea9sm2846025a12.40.2024.10.11.12.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 12:56:30 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shannon Nelson <shannon.nelson@amd.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Breno Leitao <leitao@debian.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv6 net-next 4/7] net: ibm: emac: use platform_get_irq
Date: Fri, 11 Oct 2024 12:56:19 -0700
Message-ID: <20241011195622.6349-5-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241011195622.6349-1-rosenp@gmail.com>
References: <20241011195622.6349-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No need for irq_of_parse_and_map since we have platform_device.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 438b08e8e956..f8478f0026af 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3031,15 +3031,8 @@ static int emac_probe(struct platform_device *ofdev)
 	if (err)
 		goto err_gone;
 
-	/* Get interrupts. EMAC irq is mandatory */
-	dev->emac_irq = irq_of_parse_and_map(np, 0);
-	if (!dev->emac_irq) {
-		printk(KERN_ERR "%pOF: Can't map main interrupt\n", np);
-		err = -ENODEV;
-		goto err_gone;
-	}
-
 	/* Setup error IRQ handler */
+	dev->emac_irq = platform_get_irq(ofdev, 0);
 	err = devm_request_irq(&ofdev->dev, dev->emac_irq, emac_irq, 0, "EMAC",
 			       dev);
 	if (err) {
-- 
2.47.0


