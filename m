Return-Path: <netdev+bounces-131446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDC898E849
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 04:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96E29B24ED4
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 02:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D23824A0;
	Thu,  3 Oct 2024 02:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YA23dAZd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C257DA7C;
	Thu,  3 Oct 2024 02:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727921510; cv=none; b=JQlefZGgf4KedqtLR5cUJDm7U22j0nf3+I48bXpElB8cDSCQDWSwVtSeElhXg+yvzUk1Te1CEk+7X+h4vbO/BAWafS0waoMf7lBkazM89+03WN1FQpKiBb3Ga5LjH+z7bscg7LO6tdK7P0Sbjdt7p/y6YUnuMDgHhtJrhMvL6sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727921510; c=relaxed/simple;
	bh=R3/zEAcwhIv1vvXu5eqLy8v9T/QO1blsvg8rxiWDF6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMheGixnMZvEv0BNpQWxyC1pnh9x5dT6lksHWpb3/+Gjqwt4R44n6m+Sg2Vn+fWoLoOOyGCPpDDV3LyyhsvAG4vua1OH3kNAdlZZr/LYKeYhkHlxwWxtvFj+bPqVxxrNCV4OulH0gEEpJRjZoUpUcmzCK8vWVfNXoYi3yFEAFU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YA23dAZd; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-718da0821cbso407188b3a.0;
        Wed, 02 Oct 2024 19:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727921508; x=1728526308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DoSnKsCafEyqo0X8z8XwraZSkcHXlpNQF2EXgefwFyU=;
        b=YA23dAZdQ7JWjbK5e1FxYbtjCVr089q9eQuhhBdKRcfyb9yULnr0fjmS3Cvkk+BrbI
         FXlhvBoLZ9WLssBBFJ6ah3ino1lPvPXkGDUyov+FVKnboNsV10479sACU40K3RyliV5G
         vR/4M2r+NpU3ajDEO5ryFvnRMARZ8hMoz8/ZFDqcUbHNCnORhxV5BiUcQMLsuIrmgC3Z
         gEXw+jffde4Gtl+W+AwnhejTrKsxs4A8Y1FRfH/TdowjDlroG6YNUQyATGjzUMRy20bZ
         YIb1DHJFTGkH3lTeN4Qagv26m4nynRKNDfya/YwvyjkTgIC1L6aBQOsLm7ak3rc4/h2g
         w4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727921508; x=1728526308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DoSnKsCafEyqo0X8z8XwraZSkcHXlpNQF2EXgefwFyU=;
        b=es8hqNLn7p0D0EAgO0zmg0cxl9IA0Jpm8+DVhHTd0itNYM5xrLxj8nzBCeyl6oHg5d
         1KGam0ubeZa6vaZEAW+qY10SXa/mCxXaaU3hGQuuFBSqdxizj7mimnDRaS7j06XQTDWP
         KNkWErjYnZyAwfyvNTOzBYY/colY6etJ7TYcMyEh3bF/pBXHdyKiQaPef28TsFQr6fhM
         PoRtcNGtyPTGuTTOoliHjDvDGIK0Zgg2eZln4BrSHsZUQPX5IqKjJQXmmKG9kN+NQvES
         DgoerA5UrIn2YxSj2aUHvzlvlNpOXyhWwngXkHdyPl/R1oMb6G5qN+iQLRcoUVSBGnEA
         1O0w==
X-Forwarded-Encrypted: i=1; AJvYcCVZ/k051c+yd9cK6Gr3i8dSkcW0UqZ6s+hBG6RczDw0Vdjet4JvZoChC3JinJ9mCXru5iwxe0RM9Pk6hHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+04lAQU8NDt0XBJ9EGUlmyOA5DfPU7uIgiYTwR3fIPafdyzh7
	ezvoA7GkppgxV/YEzMFz15lo50waCQczRVVjVgG005fw1JSTTLxPtTKdt1VL
X-Google-Smtp-Source: AGHT+IGgCjVNhDlPFVINLSkJ6RLQjb3KD4Mnho3sT/dN65Rh6kFxrISKOUAiirDcFZt8AQ98nOD7zQ==
X-Received: by 2002:a05:6a00:807:b0:705:a13b:e740 with SMTP id d2e1a72fcca58-71dc5d6a157mr7657929b3a.19.1727921507799;
        Wed, 02 Oct 2024 19:11:47 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9ddb3c2sm190176b3a.111.2024.10.02.19.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 19:11:47 -0700 (PDT)
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
Subject: [PATCH net-next v3 07/17] net: ibm: emac: tah: use devm for kzalloc
Date: Wed,  2 Oct 2024 19:11:25 -0700
Message-ID: <20241003021135.1952928-8-rosenp@gmail.com>
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

Simplifies the probe function by removing gotos.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/tah.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/tah.c b/drivers/net/ethernet/ibm/emac/tah.c
index 8407ff83b1d3..03e0a4445569 100644
--- a/drivers/net/ethernet/ibm/emac/tah.c
+++ b/drivers/net/ethernet/ibm/emac/tah.c
@@ -90,28 +90,25 @@ static int tah_probe(struct platform_device *ofdev)
 	struct device_node *np = ofdev->dev.of_node;
 	struct tah_instance *dev;
 	struct resource regs;
-	int rc;
 
-	rc = -ENOMEM;
-	dev = kzalloc(sizeof(struct tah_instance), GFP_KERNEL);
-	if (dev == NULL)
-		goto err_gone;
+	dev = devm_kzalloc(&ofdev->dev, sizeof(struct tah_instance),
+			   GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
 
 	mutex_init(&dev->lock);
 	dev->ofdev = ofdev;
 
-	rc = -ENXIO;
 	if (of_address_to_resource(np, 0, &regs)) {
 		printk(KERN_ERR "%pOF: Can't get registers address\n", np);
-		goto err_free;
+		return -ENXIO;
 	}
 
-	rc = -ENOMEM;
 	dev->base = (struct tah_regs __iomem *)ioremap(regs.start,
 					       sizeof(struct tah_regs));
 	if (dev->base == NULL) {
 		printk(KERN_ERR "%pOF: Can't map device registers!\n", np);
-		goto err_free;
+		return -ENOMEM;
 	}
 
 	platform_set_drvdata(ofdev, dev);
@@ -123,11 +120,6 @@ static int tah_probe(struct platform_device *ofdev)
 	wmb();
 
 	return 0;
-
- err_free:
-	kfree(dev);
- err_gone:
-	return rc;
 }
 
 static void tah_remove(struct platform_device *ofdev)
@@ -137,7 +129,6 @@ static void tah_remove(struct platform_device *ofdev)
 	WARN_ON(dev->users != 0);
 
 	iounmap(dev->base);
-	kfree(dev);
 }
 
 static const struct of_device_id tah_match[] =
-- 
2.46.2


