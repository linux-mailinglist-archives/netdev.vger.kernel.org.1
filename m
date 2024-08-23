Return-Path: <netdev+bounces-121500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC6995D752
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 22:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAE5A1F21258
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 20:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ABD192B7A;
	Fri, 23 Aug 2024 20:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPrd2Mdu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95722629D;
	Fri, 23 Aug 2024 20:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443478; cv=none; b=L1QNBJc/8qFRZ2o4qOZqYF+IE3pGt5KYy92Px2jBd49AEWra+32ci6sKwhhkvJ99xIq+OOyQW/FxC6INvtM0qMHiBrEHsONlFB/li0CPeW84u6+z8okiw5i8TJQ/7O3ko7t7nVl/nq/9xWL8mqi6GmJJ1IXF8zSafNMxD8/msdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443478; c=relaxed/simple;
	bh=vBMFW3S6/emgLYIA/pyWgD6xA2AxQPFZFD52j7NNL94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W5CGDYNEBH98PC17XWnjczh4sl/5B4dq8W+AQ66rpiD60i4GheKdKMungWnaaNEdMMWd8X0vPteqg4FpYlby7RvCYG7xKlZ/Gi6IXo1zto7aB/4PFTCJxenZ5NlkvpHKnJ+q7XMo86NHFv81D/5tGOpiaou49FEw9FiXu/AMBjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPrd2Mdu; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d3c05dc63eso1873621a91.0;
        Fri, 23 Aug 2024 13:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724443476; x=1725048276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=biUs/757bH5NsZ4eSYz1JE5GQhX8t4jdTgh1Ue+Vau0=;
        b=JPrd2Mdu/9nXRVMI2ZUMH0fmpXr7Lz7K4G5Kba4LN3rBhbZ6cJC74YXsxpVmHmt7vI
         uQF/pFNYfEhpsQ2yHgguqleIsKEN1bEWAmiqx7GIKDdbAR+oUMB8QR7g4Qgh6VbEDbi0
         BvqpsovEw3GEzp866sRKWAHrDh+nKWKfhoW7Jw3+WruaRBTnwgewZOwcPeB9oqvpvj5C
         TgbiNPhNZyma13cdTkkza6D0yLFAARagRW9SYxKI/1+y6O4G/y/Rmumw6kvMba4qgt+o
         3Zu3R0HRE/tFd/5L6hDucj+/pOZnRMww3SfEthIWnXik7ZzTkc/NljW93ELvVD52D+7u
         CiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724443476; x=1725048276;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=biUs/757bH5NsZ4eSYz1JE5GQhX8t4jdTgh1Ue+Vau0=;
        b=At4Q/9u2BDZ/KRFoYl4/88WNYm7BRTigw0O8R+++iW2nT7W5kMAACEkhHTAmjPPFaj
         qoQ9/XJcOO3aXEdsMGkyNT74P+IMwYin00fp8zddey6CEmjPWo82bnG/1Fmptgj2RMv8
         t/cXP5zTLxkK45WBJimbs/4mo+P8XNQ/zfi882aHzbsVE32QxDVQ2HXCUFcd7RzyyKDw
         GsjyHYSlIHJdI3bn9bcV66CtSanS6vpOWgyGxH6/MBUy8fJGZGaYeaH1DkQG7sHmqZNN
         uYwlSEouE9Fe37p9Arvv8wPZ04oMCoICryz2D2K71TD7IEFkgbPlRu0+TKL1FREe6Bt4
         BDCg==
X-Forwarded-Encrypted: i=1; AJvYcCUx1n9WcHL+3ceZdv2L7HKY6WbZrmT/eeNDaIWIi4MVbwQaREAi7vqFvtNCrekLac09Zxa2nwtoL9xFiQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHTCzO46NfoaDGfMUQqknENLIzySuuRAqWFBaLyQBeXqLSRb5s
	C/Paah2c/UUkUNrEK+HAOrx3g6hIvWUDaem+Iyo8U7Eljt9H9ZxDbWrLZA==
X-Google-Smtp-Source: AGHT+IGksbuUqVXKmHwr9EnBTGnKLIQjTNZSeuXT6qn5maGz7TOHNpL16d99Jikjl24oKoVew1NA+g==
X-Received: by 2002:a17:90a:4cc7:b0:2cd:2992:e8dc with SMTP id 98e67ed59e1d1-2d646bd1741mr3470448a91.5.1724443475600;
        Fri, 23 Aug 2024 13:04:35 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5ebbb007csm6852366a91.44.2024.08.23.13.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 13:04:35 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de
Subject: [PATCHv2 net-next] net: ag71xx: add missing reset_control_put
Date: Fri, 23 Aug 2024 13:04:18 -0700
Message-ID: <20240823200433.7542-1-rosenp@gmail.com>
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
 v2: don't call after ag71xx_mdio_probe. Already done.
 drivers/net/ethernet/atheros/ag71xx.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 89cd001b385f..7fbe95108067 100644
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
@@ -1924,12 +1926,14 @@ static int ag71xx_probe(struct platform_device *pdev)
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
@@ -1941,6 +1945,14 @@ static int ag71xx_probe(struct platform_device *pdev)
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
@@ -2025,6 +2037,7 @@ static const struct of_device_id ag71xx_match[] = {
 
 static struct platform_driver ag71xx_driver = {
 	.probe		= ag71xx_probe,
+	.remove_new	= ag71xx_remove,
 	.driver = {
 		.name	= "ag71xx",
 		.of_match_table = ag71xx_match,
-- 
2.46.0


