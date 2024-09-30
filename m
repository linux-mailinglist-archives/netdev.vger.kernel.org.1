Return-Path: <netdev+bounces-130540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A079E98ABEE
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE8A71C20849
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0D719B3D7;
	Mon, 30 Sep 2024 18:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hwGgMr5S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507D219AD8B;
	Mon, 30 Sep 2024 18:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720313; cv=none; b=JDAY1JOx/EDm7dqyaj7GTSaOGT9bBFTbwYiAYUGooo2iWpR7b0wpuuyOtyBVBEV6/+cd7Ni+beG9FlRTwibf9WtxC4SyQMpuK1Q1EyMePevn08vqayPIYHJ4VuMlrK4HWQ/boE1+ElKPPjZUX6hN4sBQCmTsuyXm8IB1aypmHKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720313; c=relaxed/simple;
	bh=IXBYFs0iDJMEWJmoXZXSewI92WyeES9G4AqBRYsDqOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lhDscG+0t/YRrNCiMs7WRJzmwdglz9uYSsBm+ERruiqKe6yFpTFCTPVRd/7MCYiLulcy6cJvPmK19HU6CZ+9nDjSaMAn4NcbhlOVxhsl8NjXQatsSZJY+cJlC/qSMrotx2Ud4rVNwoScm7GvcEEruA+Mt1UFd/uwar8OS4iILuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hwGgMr5S; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20ba733b6faso3537515ad.0;
        Mon, 30 Sep 2024 11:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727720310; x=1728325110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NksXPSwBAvRuzYIT4BTX0jsTpGZ9Ko/iJdBXkmtOTI=;
        b=hwGgMr5S3xA0ga4e1da4soG6TVRDtaXahAT9fwxtoPE2XVatIfrjlUgFYOcJAK7Wge
         U9Q6Be8ze8t19MCdioTtWWJu1I4sjtEK47tjpZdLPmA3LbfgF82s/JlabdeeYcGVuHPq
         BwmT5dkGiSog3EXPCfROxL570fmhYVSu/eSqYVXczWbwPajfxnXQTo6BTNtnwmPiE9sM
         a89zlm7mZYxBN5tEWZulnwmQIYMK1dRysZq8W8YjoxnsnTIM3xfNWvJ2J/OgITpBHBOn
         MYWf1XPHEEOJvXpNBhKGVUt1iK9QbNNhE2ZXohdmDGEVhEfrLP3zFlMqEcotXPH/4SCG
         oDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727720310; x=1728325110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NksXPSwBAvRuzYIT4BTX0jsTpGZ9Ko/iJdBXkmtOTI=;
        b=US+zG0HY2Nh0fXKK9xuf3pIv+2NxayW2zTo5Ute9IbKrGAR6URlxEV3jYkB9JANNvX
         qBpmZuUY+4LmigzMirPdUEBW/SlUCJlf4h65n1rYkkJ/Libqcgff7Diqm1t+km1UX+dY
         zOBTtw2bgIpgNmaoGEz9BIk0O9akMc55CT4ccsmZbAx1hMGrKRpcWCz9nILy2pzaWbMl
         Y3hMhFEiBH0dajuT8+aqCT2VWb9T7eJl+zMsYZUt+pJ4Alqoh2Qem7KZ6aoay4DWR7IS
         Kv9vLzkdrNokRoA2cdp4IWGHr1WdtsQQUTT3rZNsW8M/SM1EQMuGtwYrmJp1JToHZ3rI
         /a2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWeOTi8FyHV80KsDgp2JkHwBNvkA//F/G5y+ikZWGo+vIMNq2DarCNcFL8qts0LwHAVJoDNTval0MIMIyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOgAqaVA9ce94rrcklA1IK5Z/BztW+yYgTgbQij6MP832uY2su
	2GwapODIpDNRN4fj3JKUNH/mXTPqqcXrUeVztRHCEyLgQcCIstjXHmDowOxv
X-Google-Smtp-Source: AGHT+IG2n2Dhs+MOq3zPa8niBB6RW0yHZT6wcWpvW27Ks3cX59EJG2nrlSCcl9hHydj0ezhefLLDRg==
X-Received: by 2002:a17:902:e749:b0:20b:9062:7b00 with SMTP id d9443c01a7336-20b90627dc7mr47505055ad.0.1727720310473;
        Mon, 30 Sep 2024 11:18:30 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37db029csm57444365ad.106.2024.09.30.11.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:18:30 -0700 (PDT)
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
Subject: [PATCH net-next 3/5] net: ag71xx: remove platform_set_drvdata
Date: Mon, 30 Sep 2024 11:18:21 -0700
Message-ID: <20240930181823.288892-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930181823.288892-1-rosenp@gmail.com>
References: <20240930181823.288892-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

platform_get_drvdata is never called as a result of all the devm
conversions.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 195354b0a187..ec360a3e9f0e 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -1915,8 +1915,6 @@ static int ag71xx_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	platform_set_drvdata(pdev, ndev);
-
 	err = ag71xx_phylink_setup(ag);
 	if (err)
 		return dev_err_probe(&pdev->dev, err,
@@ -1925,7 +1923,6 @@ static int ag71xx_probe(struct platform_device *pdev)
 	err = devm_register_netdev(&pdev->dev, ndev);
 	if (err) {
 		netif_err(ag, probe, ndev, "unable to register net device\n");
-		platform_set_drvdata(pdev, NULL);
 		return err;
 	}
 
-- 
2.46.2


