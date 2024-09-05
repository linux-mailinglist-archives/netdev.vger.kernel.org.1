Return-Path: <netdev+bounces-125681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5821696E3CB
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 22:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02D31F28231
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 20:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37F31A7251;
	Thu,  5 Sep 2024 20:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoygwAIX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA141A42A5;
	Thu,  5 Sep 2024 20:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725567316; cv=none; b=lzYI5LfbvTFNTDovJLx+A+XpXwpM+yEsSl4Z3hQ7UYRQtsosDvzs7dCgG+uAQuAc77SyxX6PhCyPX/16ye3Bu6xTHm0iaYERPYmcHwqq3aqpUJOhEx44TNhlBsJmYdAzy48+2U/80t4mU2q8EFqucdw6M8uX22pf5bcX9ZiIb78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725567316; c=relaxed/simple;
	bh=Kbytasq71n7TZ4AmPFNnHyoD8fiyS/BnZezEfZaL+kY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pUalapQpJjX8fvMRyBSxEFhmu0FDxGZTkU3D5uo5HBJqRwQQmRceLszl0ipK42edjIMU8E+utJCUu/wYo1nT4OA1CQTpjPDol8Nl9+Wh34NBUKacHqLTt+uQeGpTewQOp1+s8unUnIS8w1TlTcoAUecwafqzaO37UJd5rrTMnSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoygwAIX; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2054e22ce3fso12748815ad.2;
        Thu, 05 Sep 2024 13:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725567314; x=1726172114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twVF2G1UOixAdHqeKrG2eRrcvQZELS9sIkw44+Ffhao=;
        b=hoygwAIXJ8PW4PwJ3tl/JXVA321IIZlX0LJRe+eHgjtyh0oa5A2hptFc1Ug+yLehFR
         6PHxBF25MWDpOVdgetqBmJNNJKZrPdNt8X8lyANYDxSDAq4hL4UUfnyFZkuS0AIifD1J
         d3S9q4789EwPJ6WSmvTl+IlwBmdyYQ8TDHHRipku6XFnmt78s5YOVaPm8oVldUH98hM9
         Q2pbLTGzBUQTL3UAPTZfsKGO35pH7AtTQX6MVkrru5J4VkZSXcq95hWM81405l7mWhz4
         ghqc450sczChwAmSVJtnLSM7G6gsSDsKKL1NRJus6JnOkFyXqN2AqmMApFHCQf3almjY
         glnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725567314; x=1726172114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twVF2G1UOixAdHqeKrG2eRrcvQZELS9sIkw44+Ffhao=;
        b=rfBZHOqsvbbYOBuuez6ZTLiTlyBHjDJOAOGiZ5jZt7O2tg1GYpl3/PoLCj/njyO/dd
         a1QjxS0fIXIWiB8i7SN2DofRTcPAjcp0l7RL/VXADFZhap5KEZYYiyKbXPnpFOkVgbKS
         B6NmAD1GoIELwUWOVolcB7sa+idiStl8YU1D5if36D/0bDPFXw1zsCN9+fpENO5/0dQF
         wLVxqRiz0oN27jS0G53RBLpqf7sbq01rswEGRNAAwZd3hOfoLDuP8uVn3cqCepSxcuFe
         MrOTUmTsLetgv0RE2JfKwcgDiBlVLT1LP65PPAMGX2S9qVH6iQ/rxTWvBFesE26dvNWx
         2DOg==
X-Forwarded-Encrypted: i=1; AJvYcCXWO7nIVSAl/c8kUsDBdO3dg0IKB8nAvjRKA1ONQgqU9kQcQ8L3dEhoeihu9cAQ/RSBTHztxplrZkrsv98=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsGjt8z7ffMe+L69QEdY50kO1WTi5tnsQE7ls6OPSQxgQH8LFn
	zgiRWnFNP6GF+TKdBH2ALfm8Iqd9o46eL6d00EQqaBB/hcS38eHXZl91EGlE
X-Google-Smtp-Source: AGHT+IFnrt2HJU+gpTNxzE/4u1K/G+o6CpdxkIblRQ7lxhvT3E6kgbnrrHWro4hkwuipyENW2hqDsg==
X-Received: by 2002:a17:903:2287:b0:205:4e15:54ce with SMTP id d9443c01a7336-206f050f178mr2861355ad.20.1725567314424;
        Thu, 05 Sep 2024 13:15:14 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea68565sm32327075ad.294.2024.09.05.13.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 13:15:14 -0700 (PDT)
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
Subject: [PATCHv3 net-next 3/9] net: ibm: emac: use devm for of_iomap
Date: Thu,  5 Sep 2024 13:15:00 -0700
Message-ID: <20240905201506.12679-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905201506.12679-1-rosenp@gmail.com>
References: <20240905201506.12679-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows removing manual iounmap.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index 4e260abbaa56..459f893a0a56 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -3082,10 +3082,9 @@ static int emac_probe(struct platform_device *ofdev)
 
 	/* Map EMAC regs */
 	// TODO : platform_get_resource() and devm_ioremap_resource()
-	dev->emacp = of_iomap(np, 0);
-	if (dev->emacp == NULL) {
-		printk(KERN_ERR "%pOF: Can't map device registers!\n", np);
-		err = -ENOMEM;
+	dev->emacp = devm_of_iomap(&ofdev->dev, np, 0, NULL);
+	if (!dev->emacp) {
+		err = dev_err_probe(&ofdev->dev, -ENOMEM, "can't map device registers");
 		goto err_irq_unmap;
 	}
 
@@ -3095,7 +3094,7 @@ static int emac_probe(struct platform_device *ofdev)
 		printk(KERN_ERR
 		       "%pOF: Timeout waiting for dependent devices\n", np);
 		/*  display more info about what's missing ? */
-		goto err_reg_unmap;
+		goto err_irq_unmap;
 	}
 	dev->mal = platform_get_drvdata(dev->mal_dev);
 	if (dev->mdio_dev != NULL)
@@ -3228,8 +3227,6 @@ static int emac_probe(struct platform_device *ofdev)
 	mal_unregister_commac(dev->mal, &dev->commac);
  err_rel_deps:
 	emac_put_deps(dev);
- err_reg_unmap:
-	iounmap(dev->emacp);
  err_irq_unmap:
 	if (dev->wol_irq)
 		irq_dispose_mapping(dev->wol_irq);
@@ -3274,8 +3271,6 @@ static void emac_remove(struct platform_device *ofdev)
 	mal_unregister_commac(dev->mal, &dev->commac);
 	emac_put_deps(dev);
 
-	iounmap(dev->emacp);
-
 	if (dev->wol_irq)
 		irq_dispose_mapping(dev->wol_irq);
 }
-- 
2.46.0


