Return-Path: <netdev+bounces-131447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF1C98E84B
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 04:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FF69B25194
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 02:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0AB84D12;
	Thu,  3 Oct 2024 02:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0gGlbUq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F199E81ACA;
	Thu,  3 Oct 2024 02:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727921511; cv=none; b=BAw6wiCDJodhnN1zJ87VoF0zT/Tm0ee5CGknxTfgSuHKPigGYvX5Za1lJs8V7e/Lc2K66cB3nidaeArY1siHS349yhzM2oNtFy1g0+X4fsoncMJwnK5z5V1/0OdFO4dckX9gheT9I3hUyHYzngjcZqRCVbN9BEBmkiyPtgqPOe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727921511; c=relaxed/simple;
	bh=2IYzVGZB/me91vV9GKAMx/UOKfRS26DvtY0el6//X54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkzVSDIACc4xzzRmfxii176+WPnMSMxcqOqfJUsUERVISf44jHlRPTggbvCde0GHih4Lftiml88P/5nRA0a/eJ41mmaNCREZjsCL7qVDb+X32TUPCGSN7PKO1XX72vF+VmiSV/6FzRp1ZaPhJf6EoK2a2AdUUvCISVba7unAQn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0gGlbUq; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-718d606726cso373769b3a.3;
        Wed, 02 Oct 2024 19:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727921509; x=1728526309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGWXvjbdkPp+9wytWEPAL2W2KtxouZqemO4TuRcnCl0=;
        b=Q0gGlbUqy8tDgQ1nYZ8QSWyVH9uqm+l6+u9UlW8Dd5bkBAZWPvNgJQnu+BNKrDfPjR
         oWlZr72TGku0/6dfs1QsbNRrsi15fWA4Tpg98fEkgAwODNVqmvd7n08wcWbETcUT+NYs
         m9AeJ+iZ5tZiPl6AFElgiBIVDz4eiFBhxUDb2WFPwscNw982TkfYKkr0RDpwf5+Ks8mL
         cKBnAuaDwFjtmyJjFBY2vK+MdnsE6Sz8oG7DtuBOQPV3B5OgdrHxLIlM+BC29tMsF3gy
         yy0EnEn1Ph2+1C7baCTfb3FcWQ3KCJM4B6P9IMRRJW5adW7TxJMm/NT5PSEVmGVlv1sr
         N5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727921509; x=1728526309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGWXvjbdkPp+9wytWEPAL2W2KtxouZqemO4TuRcnCl0=;
        b=eav8JCdwJJ3tKZCKB3Li8/YYB8NaUzzpIP/uPPN8bqP0HEUMr0L/rdLnnvrmlGZwA8
         jRyoBUCSKORPvMn4gAgXOgUuzEVpbfrgSxyr3SdjQDP4HYVDbqO3L+ZOuoYCQ1Y6K8a/
         3TlODKR1VUmxxPZl1lGz/iiLuxC9H6MUZKhdrYARgvCyckvs/p4tA6dk2rw9bJuQeom5
         VAjumtqwU00+j3k4gGkryjWT0sCQsSghbtdnPtPzzJgg21cYLyKjo7ghqq2pPsO11NPH
         TzTMnB4V5SnD3zvmqAoPNDALOp6yg2pP1SRLW3zzVkoVSfHzw8uNcpdGYYwb/FgybrpY
         4YZw==
X-Forwarded-Encrypted: i=1; AJvYcCVtEMm8m0e3PKVQ8tIQHjcSxOEnAGySQ3HfEW5jj7fSMckn05GEwRRq5kGqqsgeQ6Ijw+zXEP4J3bsaQN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTzmYF0fOF6LtyRd3Gn88P21re20V6AWi1A7jhs/4wLpvgsoES
	5DFCMbOjYQ+M9oUXsQmCv07Wcvoxj9uauN3hAp7Bu/PRjIx5NPHwq0d6k2Wl
X-Google-Smtp-Source: AGHT+IGbkyk6+otLJKi2NzZaHWMVWHiLLN1ISYnD+BXh+raTDsIrgVxATxQPtN377dOGSmUeXhRMNw==
X-Received: by 2002:a05:6a00:3c94:b0:719:7475:f07e with SMTP id d2e1a72fcca58-71dc5c42b2amr8309277b3a.4.1727921509114;
        Wed, 02 Oct 2024 19:11:49 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9ddb3c2sm190176b3a.111.2024.10.02.19.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 19:11:48 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCH net-next v3 08/17] net: ibm: emac: tah: devm_platform_get_resources
Date: Wed,  2 Oct 2024 19:11:26 -0700
Message-ID: <20241003021135.1952928-9-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241003021135.1952928-1-rosenp@gmail.com>
References: <20241003021135.1952928-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies the probe function by a bit and allows removing the _remove
function such that devm now handles all cleanup.

printk gets converted to dev_err as np is now gone.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/tah.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/tah.c b/drivers/net/ethernet/ibm/emac/tah.c
index 03e0a4445569..27c1b3f77125 100644
--- a/drivers/net/ethernet/ibm/emac/tah.c
+++ b/drivers/net/ethernet/ibm/emac/tah.c
@@ -87,9 +87,7 @@ void *tah_dump_regs(struct platform_device *ofdev, void *buf)
 
 static int tah_probe(struct platform_device *ofdev)
 {
-	struct device_node *np = ofdev->dev.of_node;
 	struct tah_instance *dev;
-	struct resource regs;
 
 	dev = devm_kzalloc(&ofdev->dev, sizeof(struct tah_instance),
 			   GFP_KERNEL);
@@ -99,16 +97,10 @@ static int tah_probe(struct platform_device *ofdev)
 	mutex_init(&dev->lock);
 	dev->ofdev = ofdev;
 
-	if (of_address_to_resource(np, 0, &regs)) {
-		printk(KERN_ERR "%pOF: Can't get registers address\n", np);
-		return -ENXIO;
-	}
-
-	dev->base = (struct tah_regs __iomem *)ioremap(regs.start,
-					       sizeof(struct tah_regs));
-	if (dev->base == NULL) {
-		printk(KERN_ERR "%pOF: Can't map device registers!\n", np);
-		return -ENOMEM;
+	dev->base = devm_platform_ioremap_resource(ofdev, 0);
+	if (IS_ERR(dev->base)) {
+		dev_err(&ofdev->dev, "can't map device registers");
+		return PTR_ERR(dev->base);
 	}
 
 	platform_set_drvdata(ofdev, dev);
@@ -122,15 +114,6 @@ static int tah_probe(struct platform_device *ofdev)
 	return 0;
 }
 
-static void tah_remove(struct platform_device *ofdev)
-{
-	struct tah_instance *dev = platform_get_drvdata(ofdev);
-
-	WARN_ON(dev->users != 0);
-
-	iounmap(dev->base);
-}
-
 static const struct of_device_id tah_match[] =
 {
 	{
@@ -149,7 +132,6 @@ static struct platform_driver tah_driver = {
 		.of_match_table = tah_match,
 	},
 	.probe = tah_probe,
-	.remove_new = tah_remove,
 };
 
 module_platform_driver(tah_driver);
-- 
2.46.2


