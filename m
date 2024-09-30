Return-Path: <netdev+bounces-130526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E910F98AB91
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 264121C20E0C
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2E819D8AD;
	Mon, 30 Sep 2024 18:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acTZOfQ3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DDA19CC17;
	Mon, 30 Sep 2024 18:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719260; cv=none; b=GdY93Mi5G2EAoLnhP83OM2fDkIu6GhkzleBLr2SR8eM9lG5h0JLUkwA465AqujXlaq5aUSGP9iaIcYZWYrql/WkyxD95OcMRDxFefNkk+CV7IxrW/o+pJRgQswX7qw9je5VHlWhPja4wAaFSM72p1fjDPz5K9ur7ep/uW+qHCBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719260; c=relaxed/simple;
	bh=/JFQ1f+yHsjb5Zt6+gt8OydljzAA9ds8/yUsrr7/NQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avqrzg1QAzxeSqVogvXMKSvuxc7KOD8sKICdhkFclYpLexoGjr8IUxW3PlcGEixFK7BwP4riFil0xsR8iihmB+Z2UEwWvYNlKUepO2wEKIBbN/PIFRWBVVfhzl5Ors0/UAkUED6d90PtydVQTwuppkghTCGtRhPVztWROqMGdXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acTZOfQ3; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71b8d10e9b3so2470139b3a.3;
        Mon, 30 Sep 2024 11:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727719258; x=1728324058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JLSo4Y+RlvJE8rHN+xUYDaCM/v2W+3AtNr9b9F2/l8E=;
        b=acTZOfQ3ft9NpqR1I3xeHxjC4DkjC6srTFmE5IKKzGsgdU3UmiaT/yoYSb2fuQBr8n
         usOXQM7ZEXhc4SeRjBZWi+d3XuQv08epnAvZuiqVgAJKuqj8MtKSTKXVB/KLMkLnmfcE
         CUEkOgMalj+dCQDj9FM7bBZIjVXCUaL66WPfvpFOYkKkbyvfblgkcIDbRPAnZY0+0Dug
         wSOUospH4W/H27Pb7cAXpAzxn1rud54dGqjYn6fIG2eezfsPYVx7NdIAYUr3l7MeyKxI
         qqHsMg5H3D8ibnqKp8bfHEqgUhPYarDlCsqh5DxRudWfQRll8U4ckqVmJxxksHqhnBy4
         oxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727719258; x=1728324058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JLSo4Y+RlvJE8rHN+xUYDaCM/v2W+3AtNr9b9F2/l8E=;
        b=w8K4oWOjqkRxbgR7Icjcri3sZ4o+ZwVhsmU7GTztV3oDqJyAMDPTyxB0pjraZbZuqK
         wbtRyXvRoSt55GU8hCA9ic1y2WDgUzfgCXGSG5uhVdgNDoDkTAq1hJvezOaHsgGtOOJf
         wyZEo5x+Ep5sxED3CnYNLx4E9la4V1cFuA7kWP71S+PK8PRyBLIyaEluCNjr0iey1mfp
         5gqe516Islis2rt7gifsqLOJjKE8XMjw+XzsezXS+IredHzYaz568llcORTE82QTMbrT
         jN8OocgbFZxKl8o3ZOMqxWp9+SPEP9/oSGkJGqUlvUnAxVdjkEON2HNzAj1wMHQIl0aK
         Gi5A==
X-Forwarded-Encrypted: i=1; AJvYcCVlYdRX7ETLZtsrUknasNOv2f6LY3ITrPykAlTPKRX6N0smZ1EqebBINquYkKSfJWIBGHL9OFiRFiLCjRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YydQdrtE6Q0bAG09H8uCY/qWgI1o/2Ar+k2kIJtAOUn1UXP6PCx
	QSPdsJV3p5OEsAao29dmQub4TdtbyMIfGCvoDn8Cbica/wfV4TIpbbP9SDEp
X-Google-Smtp-Source: AGHT+IEiCCpqp4BpRPIK04mYZRGvc4wRMeuiJR8i++/Bxk1tfb9TBwsJgDtaeJxDemG8V0/XAqJOLQ==
X-Received: by 2002:a05:6a20:c6cd:b0:1d4:ea81:b1ed with SMTP id adf61e73a8af0-1d4fa6c82cemr15747605637.27.1727719257244;
        Mon, 30 Sep 2024 11:00:57 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26524a56sm6740653b3a.149.2024.09.30.11.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:00:56 -0700 (PDT)
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
Subject: [PATCH net-next 11/13] net: ibm: emac: zmii: devm_platform_get_resource
Date: Mon, 30 Sep 2024 11:00:34 -0700
Message-ID: <20240930180036.87598-12-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930180036.87598-1-rosenp@gmail.com>
References: <20240930180036.87598-1-rosenp@gmail.com>
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
index c38eb6b3173e..abe14f4a8ea6 100644
--- a/drivers/net/ethernet/ibm/emac/zmii.c
+++ b/drivers/net/ethernet/ibm/emac/zmii.c
@@ -232,9 +232,7 @@ void *zmii_dump_regs(struct platform_device *ofdev, void *buf)
 
 static int zmii_probe(struct platform_device *ofdev)
 {
-	struct device_node *np = ofdev->dev.of_node;
 	struct zmii_instance *dev;
-	struct resource regs;
 
 	dev = devm_kzalloc(&ofdev->dev, sizeof(struct zmii_instance),
 			   GFP_KERNEL);
@@ -245,16 +243,10 @@ static int zmii_probe(struct platform_device *ofdev)
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
@@ -270,15 +262,6 @@ static int zmii_probe(struct platform_device *ofdev)
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
@@ -297,7 +280,6 @@ static struct platform_driver zmii_driver = {
 		.of_match_table = zmii_match,
 	},
 	.probe = zmii_probe,
-	.remove_new = zmii_remove,
 };
 
 module_platform_driver(zmii_driver);
-- 
2.46.2


