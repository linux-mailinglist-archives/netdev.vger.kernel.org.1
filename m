Return-Path: <netdev+bounces-140540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C88129B6DD4
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 21:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74E1F1F22C81
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 20:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3403D21764E;
	Wed, 30 Oct 2024 20:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QavkYgpp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FEE21503D;
	Wed, 30 Oct 2024 20:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730320663; cv=none; b=GhjGETe+uS2gkfT4sfQMo24f8c/CH9dmxUv0LWPicsbPP4ln+kvevygtANk8/Bt0aWa3tBv5FuZZiilPzhiPONbx8cqHmF2qMEq+FsvMDFivAtYIoeY8ugCk0XcL2MXCYzMdThGsfQRSQKa8QuF6iRHSf+U8j8fUNczaOGU+ZK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730320663; c=relaxed/simple;
	bh=8H/HGfseD6Hcty/U1z5QkzaKDuq6wTTa2iAs5w8qdz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hy4IGja9tQ6zo8RzeQ+A2d9G5qoqlkrly2OhRTJqWmtn3VkVlMvcYvUny5FbA62vGbh5o1cQe/wFMq3PjeIOm2qmlgzEWkWditPE099XChpSeMb23PMNI+yQkea+nZTIbuGJdTbbFv5uQcA3GHTfcgRfL9e5bD2ne7dmL/jnM3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QavkYgpp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20b5affde14so2138865ad.3;
        Wed, 30 Oct 2024 13:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730320660; x=1730925460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1nVodfyPN+fRTJh2xp4PUTmWLc6YUs5p24LJwjzuGA=;
        b=QavkYgppk0dErnlqX/WOdqjZk99BT3owjdVTT53GQf0ZUv4cLdS5QEJg6J9Sh6kxLA
         J4eBCQvdtnOCy4Mn5VyzVtHqPb24EJsztFs53EBXtPA9b+6vJ9wVCsBX4OoyceyQefSJ
         ZubpFiFP4pqSNdaN7xV5d29qdd3uij+5T93Qg0GJ+SQnjClYNe2SC36BZEE6aFreLgBS
         gWE4a2ET1qYEixJe7qkLUJGd9gV68cJyhTjryxvQ1jHr/XSVoeugrzz3Hc754ZnI82Pq
         Yr7iPqsQPIVoDfS7oqRpPfQzGMilC4/us3DDrAMWIlYKhluRelalbQX7RDBmPACz8Z4b
         teHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730320660; x=1730925460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1nVodfyPN+fRTJh2xp4PUTmWLc6YUs5p24LJwjzuGA=;
        b=e0XywQDe9hZtZXSA/lL65D/IisRuJHyvWOsGppJ35aQbGIUBQuWNruD66hxEvATDgr
         85BT3lRAd/ck07F/Me9qWGxlt1s0fUhTJta86ljDRCWK/qTuZ5li20pB6wOH7OrRBQsr
         i0cIsSRfk+YUu/YpAmg6mqAIKyiw36itOeQDNA0ul2GnsDDrmNgEP82eTZ0IP3h+WPJz
         ihYWfmbhdeSpFfCOOJ6djFZzOE/UP4VawunF83RrA6kCxEngEs0i+auibtNIbh+2aU6I
         sAygQzCq9rvSENG4MVLkLLrRrf/GKPLOJ1sxgivA1Pyp3Es4pUPZmH9YdzZhRmaNAvvW
         jfjw==
X-Forwarded-Encrypted: i=1; AJvYcCXBeTrHitx2qBRWH62qIe6A9OcwroV5j0EO+nFmbX2OdUKacjjzU3LpN9diYc1XYlGUA3McFuCNjUD+VFs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/H7NDPjR85yI4XrJuEOxeH6dBNeAKX4/u6Cg7fpamlV+PJ3Zn
	OVRqJHo2rlIzNZRRNrNBlqu/GPCmzj0NC2h3b9rmHU3eh65LE0YDwRSCpjou
X-Google-Smtp-Source: AGHT+IGxprz3EHb/FK2QzLFyo0d6Petk3zgqKuGy5tkXioh0CukmsMpyiYLi4eLeNKwS+ZHywg7OgQ==
X-Received: by 2002:a17:902:db0f:b0:20c:cf39:fe3c with SMTP id d9443c01a7336-210c6c34824mr228108785ad.41.1730320660256;
        Wed, 30 Oct 2024 13:37:40 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056ed85dsm40645ad.5.2024.10.30.13.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:37:39 -0700 (PDT)
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
Subject: [PATCH net-next 03/12] net: ibm: emac: tah: devm_platform_get_resources
Date: Wed, 30 Oct 2024 13:37:18 -0700
Message-ID: <20241030203727.6039-4-rosenp@gmail.com>
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
 drivers/net/ethernet/ibm/emac/tah.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/tah.c b/drivers/net/ethernet/ibm/emac/tah.c
index 4b325505053b..09f6373ed2f9 100644
--- a/drivers/net/ethernet/ibm/emac/tah.c
+++ b/drivers/net/ethernet/ibm/emac/tah.c
@@ -87,9 +87,7 @@ void *tah_dump_regs(struct platform_device *ofdev, void *buf)
 
 static int tah_probe(struct platform_device *ofdev)
 {
-	struct device_node *np = ofdev->dev.of_node;
 	struct tah_instance *dev;
-	struct resource regs;
 	int err;
 
 	dev = devm_kzalloc(&ofdev->dev, sizeof(struct tah_instance),
@@ -103,16 +101,10 @@ static int tah_probe(struct platform_device *ofdev)
 
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
@@ -126,15 +118,6 @@ static int tah_probe(struct platform_device *ofdev)
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
@@ -153,7 +136,6 @@ static struct platform_driver tah_driver = {
 		.of_match_table = tah_match,
 	},
 	.probe = tah_probe,
-	.remove = tah_remove,
 };
 
 int __init tah_init(void)
-- 
2.47.0


