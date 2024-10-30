Return-Path: <netdev+bounces-140543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D9C9B6DDC
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 21:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC4951C21B30
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 20:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F73A218939;
	Wed, 30 Oct 2024 20:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1tt5xdk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6407821791A;
	Wed, 30 Oct 2024 20:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730320667; cv=none; b=YxW7NoZGJTjHWOGLUy/JCKFZZd4B6huGBKm5aOtcZQtJbvPuhedIxqfB+DL0mJXYKmjfpJ2nDnTxbLeOlPTCHu/8UI1hLr4a2UJTRzJqF/T0NUmgxDN+OjKqwrEdP0LAprvoT+wfaFbPd4JxMCx/7uiDSmV9+hvmndKYSlRj/LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730320667; c=relaxed/simple;
	bh=oUBWD/M0B0TffrY5t5Pz3/WjlPaOX+qXwTvhg8PD1rM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XXcHrp3UpsdgtiLFcWsSRQUHPR7lBkZQU0IMfnV/YI0m+uO/xvxjoT62GFnyBH6ph+edpRFue7/NPiR5bp1qem6oS1cLfv1O0AZhtep2rzkdS68hKvfyiWjgVn1jeH6p1JTS702mHwmpoRvi53aDLO/Kg4PZsaYwc1ZeW8zKGDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1tt5xdk; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20cb47387ceso2692575ad.1;
        Wed, 30 Oct 2024 13:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730320664; x=1730925464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QY2wE+4G57UieRa9G7ux/y9sqS3sWK/jiT39IANX1qc=;
        b=U1tt5xdkeNhXK8KnPPVsZhl7kJOWg7tIC1KALMOY2MmmZk1UwPprlrYOyFQCQ/Be2/
         UuwDsZGIV4DJg9FdHd79Rup80dUPKvSCoeD7ltASpX6jIYcwonB4G5nWfW31sIUyrPYY
         N8JQ4GFPGQ55TuAoD9Fm4ahKazgs50OfUOZfG/gv7za8DiOcw0Zv3EcRshHsOFaR/Gw4
         2j+eEAvo6e+uEyBTuA7BQf1EXQPLzP5Mz9RM9LdScV+X438c2o3Pe9JVIiV/KCWkr0e5
         3rzuPnfzj/fVVAlQD2v0LDJ7Xq7PD8/Z0k+OUeVvSA9wSs9J9qYJPfujLwin1XcQtjVI
         VTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730320664; x=1730925464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QY2wE+4G57UieRa9G7ux/y9sqS3sWK/jiT39IANX1qc=;
        b=f90w26r3OPyjboer6ko1Y8DjBSDU6Y/TmRx9brpfY1bKWt7f0eEahj/aLF/4nINRmC
         9twhcrR7zTB53ockLE45WKFPbtC1zANr2V2rOdcoqs805ioc4l/o7semVTS58eIw7c8X
         qM1uTzSlcQYcGNm/Z+Pvtnt+iqHI3ycCPfHz4orqKVGpUNH95c2HjVRv6fV996baQv3G
         aw5Y6aYHa/XBlR0iB2xawcHxA2aQIvueX46RHSsdf25BklqtEttJl/gQ6huLpbsK6aYW
         rpb5KiiJhLscoXWAN5A/4yyddqTRcWYAdfoNal/A9bvkrsvDjvSrPuaPzGP1xnwQ/IGd
         k0yw==
X-Forwarded-Encrypted: i=1; AJvYcCU1b/hRTZOjsFW/VKy0VSDzzBGECdw2mbhx2HrXtKyzHfTotR32Cx6u+xB2wFyROZanpyVLK4vt7I7I1Ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMsp5TrOCv/xUzUMVPG8vCC8kWGDV6f0OR7il5Pd106Leij/+v
	PXVVFH0cllH8tFtMs5aqzfGf8aDx2pvp/2dP700x2TCf0qR0qu/lzrxFZq2n
X-Google-Smtp-Source: AGHT+IE9J6nQTVU2LrVa5XQfz+8m3vQ+uL64pSHNLHmM4jQ4i6yuIh1VkqYbiXmc7uZ8QIRtEcPJlA==
X-Received: by 2002:a17:902:cec3:b0:20e:57c8:6ab3 with SMTP id d9443c01a7336-210c68739b0mr257368515ad.4.1730320664415;
        Wed, 30 Oct 2024 13:37:44 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056ed85dsm40645ad.5.2024.10.30.13.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 13:37:44 -0700 (PDT)
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
Subject: [PATCH net-next 06/12] net: ibm: emac: rgmii: devm_platform_get_resource
Date: Wed, 30 Oct 2024 13:37:21 -0700
Message-ID: <20241030203727.6039-7-rosenp@gmail.com>
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
 drivers/net/ethernet/ibm/emac/rgmii.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/rgmii.c b/drivers/net/ethernet/ibm/emac/rgmii.c
index 9063f0a17e25..b544dd8633b7 100644
--- a/drivers/net/ethernet/ibm/emac/rgmii.c
+++ b/drivers/net/ethernet/ibm/emac/rgmii.c
@@ -216,9 +216,7 @@ void *rgmii_dump_regs(struct platform_device *ofdev, void *buf)
 
 static int rgmii_probe(struct platform_device *ofdev)
 {
-	struct device_node *np = ofdev->dev.of_node;
 	struct rgmii_instance *dev;
-	struct resource regs;
 	int err;
 
 	dev = devm_kzalloc(&ofdev->dev, sizeof(struct rgmii_instance),
@@ -232,16 +230,10 @@ static int rgmii_probe(struct platform_device *ofdev)
 
 	dev->ofdev = ofdev;
 
-	if (of_address_to_resource(np, 0, &regs)) {
-		printk(KERN_ERR "%pOF: Can't get registers address\n", np);
-		return -ENXIO;
-	}
-
-	dev->base = (struct rgmii_regs __iomem *)ioremap(regs.start,
-						 sizeof(struct rgmii_regs));
-	if (dev->base == NULL) {
-		printk(KERN_ERR "%pOF: Can't map device registers!\n", np);
-		return -ENOMEM;
+	dev->base = devm_platform_ioremap_resource(ofdev, 0);
+	if (IS_ERR(dev->base)) {
+		dev_err(&ofdev->dev, "can't map device registers");
+		return PTR_ERR(dev->base);
 	}
 
 	/* Check for RGMII flags */
@@ -269,15 +261,6 @@ static int rgmii_probe(struct platform_device *ofdev)
 	return 0;
 }
 
-static void rgmii_remove(struct platform_device *ofdev)
-{
-	struct rgmii_instance *dev = platform_get_drvdata(ofdev);
-
-	WARN_ON(dev->users != 0);
-
-	iounmap(dev->base);
-}
-
 static const struct of_device_id rgmii_match[] =
 {
 	{
@@ -295,7 +278,6 @@ static struct platform_driver rgmii_driver = {
 		.of_match_table = rgmii_match,
 	},
 	.probe = rgmii_probe,
-	.remove = rgmii_remove,
 };
 
 int __init rgmii_init(void)
-- 
2.47.0


