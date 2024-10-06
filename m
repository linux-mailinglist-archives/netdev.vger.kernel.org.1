Return-Path: <netdev+bounces-132446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F933991C08
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 04:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C4501C20E95
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 02:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6963B15383A;
	Sun,  6 Oct 2024 02:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqcYtR1H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9F341C79;
	Sun,  6 Oct 2024 02:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728181730; cv=none; b=ofrIFKn2fddBhTsLNHbV5GIJ7FnJWLRWYeSo07V+fH7KtfR47CYjVclKFfjLdi/0/Yg6NyPZhBYycxaDX8VxNy2cts4kpNJ5V52Gs9hz6QiFTQ7KoBvxTEfAgWZHG2TkIx6kjp6rxWfrFrdn4Hkn6Om2gOGLPJVKSKCHg88AEwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728181730; c=relaxed/simple;
	bh=R3/zEAcwhIv1vvXu5eqLy8v9T/QO1blsvg8rxiWDF6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hzUI9aDGlTo5uTb+87SIPKGKzMu+huga2a5d/tZd1VBh+7hZCYWe9Tt58Cs+vZAswi0oY7BAVR59JSx/DuxZPKGNSkJgrsJyWyneIj1ZBFgJrZ0dZ/i8KFeT+PZNP7vdTKS6xAKqrBDrz1Yx76VsNaYTXubDMj0hcxaJgdYh+O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqcYtR1H; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71df468496fso820431b3a.1;
        Sat, 05 Oct 2024 19:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728181728; x=1728786528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DoSnKsCafEyqo0X8z8XwraZSkcHXlpNQF2EXgefwFyU=;
        b=CqcYtR1HnQK1mCuGKe1eSl5CbwOlOrs0WTuTM2joHB/JYIP0OoYKECFmOM3MLSVUNj
         fe0ZppqpeSJyovYRNAAVKcyZMyDFR4DtOpagM3/XVquXASNwsmuvTB25NLcaWz3L3Ucj
         0LN6xQ9ndwnaBGM+sk3pYUfdfOtXc5KgxT3cqRxk2OUBQOh1SU1FCEA7ec8VcAKYhjlQ
         TpAEskefgg5xmC8f90h6tOYs4iNzQFsMyH/TZjSk134bgvFDcQ6sBCXTAoZF3znkpObz
         zclEuugs+nDXk2Zz9B3R4SOrWYKccZD+h0sFl1xlcY7a2v8qFI6fnSFcdaOONl/2lBsA
         gvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728181728; x=1728786528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DoSnKsCafEyqo0X8z8XwraZSkcHXlpNQF2EXgefwFyU=;
        b=VTdpgMKvNqFBMVX3BPIrzzVJiqisdR6/nyUDhSWXac7wHM/IIh3/U+RvxXdkzGv2y9
         Haeiu7qDXieKU6n+1Qu8bf48CgO5UW7f//WmjiSw8DP1e5wSAyMroqRNdKJXa0Dp3W5f
         040K1JQCeWwCtV3b7+z5nQpODyQJ8heTeFZzETChybr6EvkegDRmmBVaVwH4YOyhxHKk
         IC6hgqWgNWnkCoAIfDmL+KQ+4oUwWXUGBU+6wlVq2klr+v7QVauYtZXQbPZ4R0a/lNrF
         4/M23VNOglgTAjCkQcESvSXKi5AilTNWX/3f8Bvsa8b6vSkC/6l64PquTixx8Bhofd7s
         YGeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVsEZA66l4AbRRWynrf/vu2s2lBBxx+CDkzCXt+gKc8lCmpSl4hubYSNfT2LF2h+OUv72dl6Te7HqvDVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw62sDVeDF6/+lZR2EAFW6ZmTyxeeOwqcVSDZUSP2YdFD/EkEgc
	+pq4d0+9IlCbved7gXEMYHVYETy+y3LhZDDxISqPIvziL6cPReLzaN/hmQ==
X-Google-Smtp-Source: AGHT+IFFynocdacD6Ln/TQul555D5kfu/nf14dPUR5eC+l/2etYoBBtuFiNT46qlQyy/Fwfd421c9g==
X-Received: by 2002:a05:6a00:1906:b0:70d:2621:5808 with SMTP id d2e1a72fcca58-71de23c6976mr11999143b3a.9.1728181728059;
        Sat, 05 Oct 2024 19:28:48 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbb9bcsm2103550b3a.6.2024.10.05.19.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 19:28:47 -0700 (PDT)
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
Subject: [PATCH net-next 01/14] net: ibm: emac: tah: use devm for kzalloc
Date: Sat,  5 Oct 2024 19:28:31 -0700
Message-ID: <20241006022844.1041039-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241006022844.1041039-1-rosenp@gmail.com>
References: <20241006022844.1041039-1-rosenp@gmail.com>
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


