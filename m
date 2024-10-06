Return-Path: <netdev+bounces-132454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2236A991C18
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 04:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51A901C21018
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 02:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696F3176FC5;
	Sun,  6 Oct 2024 02:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEgdBaRk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314ED173346;
	Sun,  6 Oct 2024 02:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728181741; cv=none; b=OBVPGpAeHz2e5FN2GbligOstraQ1HzN9gvakJZMQQoVN6yxwPttQokNrRyHSvxIGSy2xbOgF5AdxYkbSYOeOYO1ziQKXUXPXyS8CP9VRKK3axwF6ndUzy1ggg7LVUewPtFYByHrE17ryIbi66s2Xu/dsvRQ5kcUxR93QDUXc5mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728181741; c=relaxed/simple;
	bh=CuSawRtUbFVk8tjigxOGLqZMKxwZi1krgDcvB/Wmy44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RQpkpFqZXU7gH0AB92TD+6ylh7gvbykFziFDB7lxhlGna3waaWy8wObMTkV/KjLBAoEEo1Z990yBpNWrX5TVif5xWAHmdYpuJRDr0nUOtSzHbqm+LtCmJ8od8JL6P43qVdqOrCj5a05T0HCHSJuExQZmyi5RWnAgQ8DIbHfPgcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEgdBaRk; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71def715ebdso1014005b3a.2;
        Sat, 05 Oct 2024 19:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728181735; x=1728786535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pu9sszKQ8Z1oBJqpg//vV/J/jxjAV4Pvvbpsa1C/uW0=;
        b=bEgdBaRkY0yAzNp2CBArwnxPG127eWLrQh+Ybkq/vdLRb9oSBSg+8CiSBb5NZ8nHP4
         EqE5tuD4rTGzStHcn8fov9nINsYuWkmv0uLU2I/EACZBIyJPLBzJG/mFj+umV7R+0MzO
         hmoOctBex/2ARnF19uWDbYTLRcAyOJpUzlkhiYRsmDqZAoBO6hwYZp3e6xyCBAubNIdj
         hX/HFEIiGAJUMmPiG3RHHVPktZe1JwoJDe70kYkg+6Zzn5JEAzcE9UY6veBp9dAIQL9v
         69Yiymy2TzO551jQwEiM69/UPPymK/jPBxTvGDAP+SuxGIymiPu0gY3zcPNtJzp5EMOM
         mYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728181735; x=1728786535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pu9sszKQ8Z1oBJqpg//vV/J/jxjAV4Pvvbpsa1C/uW0=;
        b=i1F4iOS6ivJJbAZgS8fqppXIVq3vL5pT2euj9kble7O1s9OWDmXVU71wfH4KUnmO8c
         IbsE0GggVBqc85h511F3zlxgpZXWgiu/pIonBOrnzGn7f4DXyZV9Rm+V4qg5SsK5bs17
         IvMWwSQFbXgaGgDQwv2KBODAhkKH9zodUNSkEXrmuWHRNOSxJXuXxun26hbD23C9QqDj
         iZ2jzGCtGIR3Jnr7fXEdpfXvoKl36sNxgXGbdtAf3Vg/PeG8ptIyDDvl9ObXzD5mT7k8
         2IAgGIBUl/QobsaRCKpSciVYLHwvI3R9tiXK1sc918lWMT/KiC+mqNZJ9l1wSRRWp8c1
         DjQw==
X-Forwarded-Encrypted: i=1; AJvYcCXmFJoV0ADGkBHSMmILtqZILYdtcozxLkbT0MUUCoRSCywDOOCvA1a2sjQqlnhNqK+AsgYaIfC7Z3e1uIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJFJlJFMTaftz4MAYg8YH5vhdWfcGdYt4SF/49JFARPFcpkjLU
	sRuA9Dl3skOalzjsUSpXHOLmJ+rh0xG6hKJ3lMzTuXxbziF07ZANNxTKVw==
X-Google-Smtp-Source: AGHT+IEBVX33/dzewGuMaHshwlOznwaF2SCKxizWB0cuhI0fzuszsfC0deJkrrfYvrPi0KNQOYffJQ==
X-Received: by 2002:a05:6a00:a88:b0:710:5825:5ba0 with SMTP id d2e1a72fcca58-71de2399c86mr11842372b3a.3.1728181735233;
        Sat, 05 Oct 2024 19:28:55 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbb9bcsm2103550b3a.6.2024.10.05.19.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 19:28:54 -0700 (PDT)
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
Subject: [PATCH net-next 06/14] net: ibm: emac: rgmii: devm_platform_get_resource
Date: Sat,  5 Oct 2024 19:28:36 -0700
Message-ID: <20241006022844.1041039-7-rosenp@gmail.com>
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

Simplifies the probe function by a bit and allows removing the _remove
function such that devm now handles all cleanup.

printk gets converted to dev_err as np is now gone.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/rgmii.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/rgmii.c b/drivers/net/ethernet/ibm/emac/rgmii.c
index c2d6db2e1d2d..6b61c49aa1f4 100644
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
-	.remove_new = rgmii_remove,
 };
 
 module_platform_driver(rgmii_driver);
-- 
2.46.2


