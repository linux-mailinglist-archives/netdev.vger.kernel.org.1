Return-Path: <netdev+bounces-124288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3E6968D27
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 20:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CA672831E2
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 18:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FB11C62D6;
	Mon,  2 Sep 2024 18:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpw3eOUx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4433BB22;
	Mon,  2 Sep 2024 18:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725300936; cv=none; b=fSgsOiosxwxdcKbcW0E/3fArlycWD82jplHB0uYdo17/yHlc7tGuKNZQnqm68tEPQa2QmsVusjBnSBm6VlLr5To7hZTxqNQPPWYRiVk6XOQLvXmoc5q8qftFslIg4o7ZP7Xd2QwUp/YOZJ/zxUpn6+QoHsYWGo8NERbdzyULQmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725300936; c=relaxed/simple;
	bh=aZNu7iiv/TYq0BlMH229d2ccbsF2mWev0TPm5aNKaTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1V92qddAvF6iqRBlr6Oq4YqFHPEn5UcBX7rLlJZuGRzYGBgDYFKbyf/1VKLeQKs7/3Z0TB2AdRjl4aUVGr5pjwaA4WlpckXm50ebXZQS8h3/bRoFuI2xsug6zhbOd/FtJ5/ULKFerRAjJof8EBJgCiVm9A92Dj0MFIBjxm+k3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpw3eOUx; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-717594b4ce7so960922b3a.0;
        Mon, 02 Sep 2024 11:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725300934; x=1725905734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltddfl1/seB86FuPt28B0OUAnAVJMcJpdwKzmOTOXTQ=;
        b=lpw3eOUxp2Et7IBvzT0wDl9akX7a7rcknSTaxWjOUa29mK8qeXEUctKZMGC9MEMtvF
         j05Nr+kBZmY9niAeWb7bL4OdXHlSIKnMn9SEpbZz9Lj5PLlCwdgNCvhhDAoVSZeCK75f
         iUhDRcof+S60tWBVA/nbsWYUKifllQKclFsLsmyVGbNwyPEVTtPrumqPPEYqtzP97uI6
         JFSlS4NzAtwiwrbbXeiu8RCnkwrLpv3SaUBNzIo9CgkOFAf5mpLlRe9cCAGJSCrGokjE
         2mFOPjr2HSykpdLRpzKKcEeRTHuaB3wfoQTc8M8sH+0IKIXHs1mrXedLMWuCl/N0KWm+
         qQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725300934; x=1725905734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltddfl1/seB86FuPt28B0OUAnAVJMcJpdwKzmOTOXTQ=;
        b=e6sO+CAc4puC0Kil5/gIAnmz9F9O1/UGKt0YU3lvIYv4l5ebaPu61LHvj3iyak2W97
         JOcXcOfmuICJTygoAPJXSFv85GYy5Y1E7VwR7PMUnlKI/uZrTIsrzrLTkwqN+XF3giDp
         OnvEhQgQCNWAbEqg/by74jpGYU7ddyNZse6yBxGV1FH9yJgbKiZG6Mv3qoL8WspUoey+
         RdYKEaE5m5srNjZ2zstOgyXKiam5x4iMDsIAChCgPRlWvRlgFvAdN/7sZO1G7ddLna9e
         3ge9+bE71K2xHLbct5rp+8Z8H46iix/Km7bv+QhyMNjHakNVeAQXsjB8yVb3LzItewt7
         0pRg==
X-Forwarded-Encrypted: i=1; AJvYcCV1XcCdGYq2XdHd6Nkb6IvUoCa4ZX5DnLO1wRp8zd918qYjjeKHbgApasbIWlNXCZGawTvZtD3QgnbguS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWwx0Hj1oXCoZs+U0PbcqLAbopQasYWnx3FceBWo5ienHRcmF+
	CEKq4Lqzh5ohmXFxFRWr6ulolFbqSlWKq9Uvy30GJgBpE5ChKnkuqsE6T6KI
X-Google-Smtp-Source: AGHT+IH+EoF+mK4CtJKAyWIF/BV/EBXvbSOjjOqW3p9vQ9eJdwW0JI/bmrLic//uxm0aYn2bDVOo1Q==
X-Received: by 2002:a05:6a00:198d:b0:714:21f0:c799 with SMTP id d2e1a72fcca58-715dfb26b96mr16308074b3a.12.1725300933971;
        Mon, 02 Sep 2024 11:15:33 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56d7804sm7109167b3a.154.2024.09.02.11.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 11:15:33 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCH 1/6] net: ibm: emac: use devm for alloc_etherdev
Date: Mon,  2 Sep 2024 11:15:10 -0700
Message-ID: <20240902181530.6852-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902181530.6852-1-rosenp@gmail.com>
References: <20240902181530.6852-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows to simplify the code slightly. This is safe to do as free_netdev
gets called last.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index a19d098f2e2b..348702f462bd 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3053,7 +3053,7 @@ static int emac_probe(struct platform_device *ofdev)
 
 	/* Allocate our net_device structure */
 	err = -ENOMEM;
-	ndev = alloc_etherdev(sizeof(struct emac_instance));
+	ndev = devm_alloc_etherdev(&ofdev->dev, sizeof(struct emac_instance));
 	if (!ndev)
 		goto err_gone;
 
@@ -3072,7 +3072,7 @@ static int emac_probe(struct platform_device *ofdev)
 	/* Init various config data based on device-tree */
 	err = emac_init_config(dev);
 	if (err)
-		goto err_free;
+		goto err_gone;
 
 	/* Get interrupts. EMAC irq is mandatory, WOL irq is optional */
 	dev->emac_irq = irq_of_parse_and_map(np, 0);
@@ -3080,7 +3080,7 @@ static int emac_probe(struct platform_device *ofdev)
 	if (!dev->emac_irq) {
 		printk(KERN_ERR "%pOF: Can't map main interrupt\n", np);
 		err = -ENODEV;
-		goto err_free;
+		goto err_gone;
 	}
 	ndev->irq = dev->emac_irq;
 
@@ -3239,8 +3239,6 @@ static int emac_probe(struct platform_device *ofdev)
 		irq_dispose_mapping(dev->wol_irq);
 	if (dev->emac_irq)
 		irq_dispose_mapping(dev->emac_irq);
- err_free:
-	free_netdev(ndev);
  err_gone:
 	/* if we were on the bootlist, remove us as we won't show up and
 	 * wake up all waiters to notify them in case they were waiting
@@ -3289,7 +3287,6 @@ static void emac_remove(struct platform_device *ofdev)
 	if (dev->emac_irq)
 		irq_dispose_mapping(dev->emac_irq);
 
-	free_netdev(dev->ndev);
 }
 
 /* XXX Features in here should be replaced by properties... */
-- 
2.46.0


