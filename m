Return-Path: <netdev+bounces-140546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D7A9B6DE2
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 21:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4E4A1C21B82
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 20:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A889219CA0;
	Wed, 30 Oct 2024 20:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGF/ZFNB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE2E2139A2;
	Wed, 30 Oct 2024 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730320671; cv=none; b=s6ZExe29yAnG/O/WKl8g3uheCTdFmenWiDgLpHeEPw1FfwFxxLZ2uk7b0YdAmGY2hePlO3UA+4KA39UBtoLRHh+u281c2rOStV08oum2C/gMV58WxATO37CoFI3SfrcffSY+UwDXp9rBVYVfcXOvLaTP5JHqT2C9dRlWKmkp84s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730320671; c=relaxed/simple;
	bh=Q7rnMMxa/pvWqWYaaxB3zFX1k6+sjf9uJXOd0B/QvXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rrmMqpp0jQsT0F4KcYZOYfthJXBF5X4E83VKXrCBimuHCxiwfCoJLfEU9dvRYlccIjK2y7ZqgSiZjxPgz3gRrdU2DqHy4SvNp3vayiNQNgh9ZH95FvMdzHcuTQg+iLSVmR8IiLWbyOA06yCTsEnMgVuTrrbGxcuGnb8PtCE9G18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGF/ZFNB; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20e6981ca77so2923345ad.2;
        Wed, 30 Oct 2024 13:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730320668; x=1730925468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIpfNz/rRY9sLm3UcQVmGGrsDelYAZ0JJmvbVWZ2784=;
        b=FGF/ZFNBw2N2x+T8lfsOdfChQb7JMCClJOBWaywYIsUa80jjYDwdxp9CLO9IEpWol5
         un4WgfKztxt9GyNg5DStLldArXaSRKNgaEU4Vct8NLq9MI2hVCVYqaUhB4/Ijy8oRLsL
         tmuN6mRlpIhhhEvlO2+9RHa7W3+PCq5MFICMzz6L4u7VxTBmKZyd8Acbkm6FBX4NqqVX
         mbq6qnhh+V6VDOvpItyePrQyRKGPfXKjegDsgzhtd3cYGsOvapmqUQVmXVfE/HXhjIAk
         s4WeB5mEse6CsZgAUp0iNRzO+lof9bWo8uMglAaCgK6uAFdZYl/LvSCfntqkqbR/WMPH
         86XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730320668; x=1730925468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CIpfNz/rRY9sLm3UcQVmGGrsDelYAZ0JJmvbVWZ2784=;
        b=snbN/38ph1VfAos7eAlkusyVMaxYsDdKWPcE9eHJQifaM4+cjsweiqYeBUHdo9Ue0O
         IREOoEKQZXAF78xyTf5eDctK4CHKTHWaAuzoRJm+KAEdotaJfs3RHCzrbcEKBFmcWODn
         sQXeVRkyozTKucPzHaJCl6TKE862dfpouPiesC9JjZTvV80TGesfuN8ZGnN/wTrOZnAE
         E27cHSWZ1vKO/Bru1mQno+VT7GMjLT3yHKPb9aJ0+tvNhfEBBDTfTaGG3GkwE88pxKLS
         Zvc2AXgyY6OyKiSFjjjiokzIoOoWclxXk1Dl1TKh3nNjWNk/LaSN3U6TMO0alPtTJomU
         RUpw==
X-Forwarded-Encrypted: i=1; AJvYcCUlmZpOB0a7TbWTiZqRi/Xn3agwhykYafW4mKgPvpgsRzFvwJAbYRMkEbq3LjaiWoAnCw0oz8tujkoulL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx52DuPEIQzk+eMFyJD6GsROgxU/hHe1pTqU8z5K2cmOdo/lwwb
	1PHIPESv+nO/56qbEIar+g06zkwdUreGDF2cS4p4Md9Fvwub8ttAC1f9IEgH
X-Google-Smtp-Source: AGHT+IHBvENisdwEiQtDJivAouMTS01+pVIhmfTqy5w4GQXQm63+Gkmh38WH6n7msfnf3u2xto7ltw==
X-Received: by 2002:a17:903:2286:b0:20c:5fd7:d71 with SMTP id d9443c01a7336-21103ace2aemr10627135ad.22.1730320668561;
        Wed, 30 Oct 2024 13:37:48 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056ed85dsm40645ad.5.2024.10.30.13.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:37:48 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rosen Penev <rosenp@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 09/12] net: ibm: emac: zmii: devm_platform_get_resource
Date: Wed, 30 Oct 2024 13:37:24 -0700
Message-ID: <20241030203727.6039-10-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241030203727.6039-1-rosenp@gmail.com>
References: <20241030203727.6039-1-rosenp@gmail.com>
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
 drivers/net/ethernet/ibm/emac/zmii.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/zmii.c b/drivers/net/ethernet/ibm/emac/zmii.c
index cb57c960b34d..69ca6065de1c 100644
--- a/drivers/net/ethernet/ibm/emac/zmii.c
+++ b/drivers/net/ethernet/ibm/emac/zmii.c
@@ -232,9 +232,7 @@ void *zmii_dump_regs(struct platform_device *ofdev, void *buf)
 
 static int zmii_probe(struct platform_device *ofdev)
 {
-	struct device_node *np = ofdev->dev.of_node;
 	struct zmii_instance *dev;
-	struct resource regs;
 	int err;
 
 	dev = devm_kzalloc(&ofdev->dev, sizeof(struct zmii_instance),
@@ -249,16 +247,10 @@ static int zmii_probe(struct platform_device *ofdev)
 	dev->ofdev = ofdev;
 	dev->mode = PHY_INTERFACE_MODE_NA;
 
-	if (of_address_to_resource(np, 0, &regs)) {
-		printk(KERN_ERR "%pOF: Can't get registers address\n", np);
-		return -ENXIO;
-	}
-
-	dev->base = (struct zmii_regs __iomem *)ioremap(regs.start,
-						sizeof(struct zmii_regs));
-	if (!dev->base) {
-		printk(KERN_ERR "%pOF: Can't map device registers!\n", np);
-		return -ENOMEM;
+	dev->base = devm_platform_ioremap_resource(ofdev, 0);
+	if (IS_ERR(dev->base)) {
+		dev_err(&ofdev->dev, "can't map device registers");
+		return PTR_ERR(dev->base);
 	}
 
 	/* We may need FER value for autodetection later */
@@ -274,15 +266,6 @@ static int zmii_probe(struct platform_device *ofdev)
 	return 0;
 }
 
-static void zmii_remove(struct platform_device *ofdev)
-{
-	struct zmii_instance *dev = platform_get_drvdata(ofdev);
-
-	WARN_ON(dev->users != 0);
-
-	iounmap(dev->base);
-}
-
 static const struct of_device_id zmii_match[] =
 {
 	{
@@ -301,7 +284,6 @@ static struct platform_driver zmii_driver = {
 		.of_match_table = zmii_match,
 	},
 	.probe = zmii_probe,
-	.remove = zmii_remove,
 };
 
 int __init zmii_init(void)
-- 
2.47.0


