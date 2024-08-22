Return-Path: <netdev+bounces-121136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B21A95BECD
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 21:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44FD1285A4E
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 19:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4781CFEAF;
	Thu, 22 Aug 2024 19:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+ZPGhUf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFB7AD55;
	Thu, 22 Aug 2024 19:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354765; cv=none; b=srlBS7Cf/c7hoJsWvCtSyQ4yvzKBm6GxdAQ54Uaqe8Th58SvsxFgd/aridn315lapv2HyMSJ0msNdvClO+B2Mz/mpzFJFAuSufNg3V/0eIYp3dOb96t0dQAVWzVd2qHBLl4/8LRdJVPDZs7xIneID2OGB18tLcVur2T9PElfNbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354765; c=relaxed/simple;
	bh=WYbDZM7QUswidt3McqIDkUVNjOUQNL0rA2GhDxIgzkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aVDlpk7wqJ7xxCcwZspa8qhPrUNjrl1uy9OZmj0aw6cfxgcabfHJSQIAZ6KuMKCMgh5AXMUW/ksabLvx7oEnhDPgcuVAwVS5BSqWcSTonW8V7r4ZxZKFAhg+/wUx5ofAqbRqxFkTGYV3aVNhr7OB8ts38kvzQlurZgHGCk7mR4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+ZPGhUf; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71439adca73so840764b3a.0;
        Thu, 22 Aug 2024 12:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724354763; x=1724959563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Ydy6cWyKx848iGTedxTF3ZR0DvWdKpKUr5qmEWoCHI=;
        b=M+ZPGhUfneGWI6znwBwVP6Ir94e8Vcj9eL5mzma9SRo1i/nOVoERY2LoVyoDhPhBg7
         ugfGl5stPAilqbZrjRZDRbxQE7UvkwdcYjp04ONMvj9PQJ3XkmWXk2CZfB5feqrT+N1k
         dv+IHk/HQYas5azxMBIohsBcg4ZX5A3zpbix9IiqNVfLj2z7umZ+oCRKGTX68LIhUAAO
         ocudwnZ/jUtOG7wGPddhm2bjs1upNAya4/b+tLlwwIZl62JuBrZECmxaH+xTZyBXE+xj
         jWRFI/fn1nsa0vgRCd5kVlCxeHZEF3pSSfuPgInYAHca4mXSCK7Z1Fve1t9WooOdet7H
         V8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724354763; x=1724959563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Ydy6cWyKx848iGTedxTF3ZR0DvWdKpKUr5qmEWoCHI=;
        b=w+RK06YfbdwCxHussnw/0sT1QRI2Hc+Sznos+wX/xv/K8RCJdZqyTmgPLhmf6uD2Dm
         n882TKTJtrrjFYZ9zA6z+nIGhJXKn9UA+mpGnvzaq8A1NnU7io1W91X8R0PKrqoF6uh0
         OfbRYvN4j7Dg+u2XSItrNVZh8yogqEeb5l72q03CY3yAmrhYrW8PCqAKycxzzGbjAckS
         Men+/gJNvTc6dwWyZfu1hRygiXqRopklpEhZBEctZtkeGncdEbp7esnBieGoal4C801e
         +wU/f4ZPk9jgEPv1KeB3eXjqUq9gsuQas/lv8flJSKlyPxQ+bbllgzizmKSXItVzbjGq
         pKHA==
X-Forwarded-Encrypted: i=1; AJvYcCW04uH+fOzeDfAOhRmDZJz2/FJ7lUTwr9teraROfEG9OlcRmVlR5HLtS0Z3o8AD0X/3VG6C+2xnM2YhiXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKdGz5lrPvJ+KH8DEjdgdgjMfrk2Mn4ogO3Sah5mfydab83ajJ
	lnZKR6OfK3hby16oQ3keVGwmm5kF0l50yowmSidJ6l3KhiZaBRxzHM8Byg==
X-Google-Smtp-Source: AGHT+IGhJEpTDKSRtIlNjz4ySN3H0JID8PWU31zyiXoN+xvrg4+3fDuWn8jQxR82lpBg6yd4arlc8A==
X-Received: by 2002:a05:6a21:4603:b0:1ca:db9e:48aa with SMTP id adf61e73a8af0-1cc89d24aa4mr123032637.1.1724354763260;
        Thu, 22 Aug 2024 12:26:03 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143430cc6fsm1783702b3a.177.2024.08.22.12.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 12:26:02 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de,
	p.zabel@pengutronix.de
Subject: [PATCH net-next] net: ag71xx: add missing reset_control_put
Date: Thu, 22 Aug 2024 12:25:53 -0700
Message-ID: <20240822192600.141036-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original downstream driver used devm instead of of. The latter
requires reset_control_put to be called in all return paths.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 89cd001b385f..e2aaec223c97 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -722,8 +722,10 @@ static int ag71xx_mdio_probe(struct ag71xx *ag)
 	mnp = of_get_child_by_name(np, "mdio");
 	err = devm_of_mdiobus_register(dev, mii_bus, mnp);
 	of_node_put(mnp);
-	if (err)
+	if (err) {
+		reset_control_put(ag->mdio_reset);
 		return err;
+	}
 
 	return 0;
 }
@@ -1916,20 +1918,24 @@ static int ag71xx_probe(struct platform_device *pdev)
 	ag71xx_hw_init(ag);
 
 	err = ag71xx_mdio_probe(ag);
-	if (err)
+	if (err) {
+		reset_control_put(ag->mdio_reset);
 		return err;
+	}
 
 	platform_set_drvdata(pdev, ndev);
 
 	err = ag71xx_phylink_setup(ag);
 	if (err) {
 		netif_err(ag, probe, ndev, "failed to setup phylink (%d)\n", err);
+		reset_control_put(ag->mdio_reset);
 		return err;
 	}
 
 	err = devm_register_netdev(&pdev->dev, ndev);
 	if (err) {
 		netif_err(ag, probe, ndev, "unable to register net device\n");
+		reset_control_put(ag->mdio_reset);
 		platform_set_drvdata(pdev, NULL);
 		return err;
 	}
@@ -1941,6 +1947,14 @@ static int ag71xx_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static void ag71xx_remove(struct platform_device *pdev)
+{
+	struct net_device *ndev = platform_get_drvdata(pdev);
+	struct ag71xx *ag = ag = netdev_priv(ndev);
+
+	reset_control_put(ag->mdio_reset);
+}
+
 static const u32 ar71xx_fifo_ar7100[] = {
 	0x0fff0000, 0x00001fff, 0x00780fff,
 };
@@ -2025,6 +2039,7 @@ static const struct of_device_id ag71xx_match[] = {
 
 static struct platform_driver ag71xx_driver = {
 	.probe		= ag71xx_probe,
+	.remove_new	= ag71xx_remove,
 	.driver = {
 		.name	= "ag71xx",
 		.of_match_table = ag71xx_match,
-- 
2.46.0


