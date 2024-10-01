Return-Path: <netdev+bounces-131052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FD098C721
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 23:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3BBE285E27
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 21:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDA01CFEBF;
	Tue,  1 Oct 2024 20:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5GvuRtp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0DD1CF7DD;
	Tue,  1 Oct 2024 20:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727816340; cv=none; b=p7zjX/nfrhCSZIGvSNYqEi8hI5ow+z/Jhqh2JLG+IHDPbK2+fkGZF6KduPYJ/dyheL9AAfvOyTFr71WG/5cMOpjFLYIk5yk1E3Wo04ATLIM8+PmlOBSnNX0cYBzc9Ev94x5Q5AHPBzFMTfy2XZqxkIsZCDO+dH8lXSdD9mMorK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727816340; c=relaxed/simple;
	bh=2IYzVGZB/me91vV9GKAMx/UOKfRS26DvtY0el6//X54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzWAqsaPanXivmvwpwGIsdZ680DVaI1b6hWm3kMM36REbvGlsjcCwgylQCcJFTSxro96ijzlZlpZmJ9HxgxNUkKT4dNpvyWCEeE5DfgxcsKVow46RLRy7erx6bHjTExPXNYYmeuhMZYnrzyldY9kdMRbRMoHcBGnGqu97pFYVTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5GvuRtp; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71afb729f24so4547962b3a.0;
        Tue, 01 Oct 2024 13:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727816338; x=1728421138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGWXvjbdkPp+9wytWEPAL2W2KtxouZqemO4TuRcnCl0=;
        b=c5GvuRtpRry3VayfA8BnHa/hxPvStslylhKTJjo18Ngb7mbyzfqJSC9WMDZJabYoqh
         +Be2ee4QfxSzozYtC9qemZOIC9811YhBI7D9LARcF8xZH01NEJ5X7SbQLB/FB/9kVWoj
         UR32CGQxQZ7BaaQyd+Q+8bk8l74GlxeBnTfU5NeucCw/FqICeW6mxTdSXEYlz/tdwnw3
         /o/lZmkGPcwm8S7FhB6Jo1UQfaOsHX9+uELbWyY0OjCOSLG+z5e7LQOD749KS+oe63Rw
         06wFVGxyBLI366BUTMmnlbZxUZeyJnzBDqPveTho3yE0gupwcyc247tAI7gLXshl1RWn
         Wteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727816338; x=1728421138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGWXvjbdkPp+9wytWEPAL2W2KtxouZqemO4TuRcnCl0=;
        b=D/kOYs8OPat18a4qq+7FIDIS+JoT4c0yB+kDPGbgsQry0ln6FLBHTlodN6FWroUAU+
         DY7h0qsSbH6gEt0vsF1oQEcDH6xFUXuPyfOkxnrpyzjKK9dQ2M/jvyT95C/Vc4d1u3VD
         UQQ6J0Qlaevwa6/2h7qubtDUu6IhdAyhS4CwEW1VtbDoOv7n/Yn7zG6AoZXRdhPYNLod
         YE93qf/tV9NFy5tkZAT7AJ8MZJP6WqGWXbViIm/Qu6BqKL9ARd6c2OqN0YvAQYcaKSAo
         vNXZuLFLU5u6y78IemXtbLqFRW2YI3gfCpZR4hkv1+XMDOLejaOihhJsDUaI21sZ+NQf
         JnRA==
X-Forwarded-Encrypted: i=1; AJvYcCVLqmN1yoExvgbno/CSCQAnuFiGOQpH9YhJ3n4NMwdgBQVVhcReCDvEOfxaw2X54qVPBlKvLhbQCqJ9OfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeLaqsWVaR8CBnmWVZ98qyB2OebWvLt74UsJA5u7sShJEVnoW9
	YPUo3u08E261B03jCj4SDZXeIZM1Yl/9GYIQhzlWmeQ/ipN0r5cfDr8GDeh2
X-Google-Smtp-Source: AGHT+IHJ5wb7WXFugRxlHlytowNGbzU87hF3FsPvGSL+Jk8nuv9NtGAtGlKQ8cP9CvB1ssiLsVg8cg==
X-Received: by 2002:a05:6a00:391b:b0:714:3acb:9d4b with SMTP id d2e1a72fcca58-71dc5d53786mr1102373b3a.18.1727816338362;
        Tue, 01 Oct 2024 13:58:58 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26518a2asm8545765b3a.107.2024.10.01.13.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:58:58 -0700 (PDT)
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
Subject: [PATCHv2 net-next 08/18] net: ibm: emac: tah: devm_platform_get_resources
Date: Tue,  1 Oct 2024 13:58:34 -0700
Message-ID: <20241001205844.306821-9-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001205844.306821-1-rosenp@gmail.com>
References: <20241001205844.306821-1-rosenp@gmail.com>
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


