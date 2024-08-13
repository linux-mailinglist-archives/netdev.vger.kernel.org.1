Return-Path: <netdev+bounces-118140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164A3950B23
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 19:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6ED32878CF
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 17:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A498198A3D;
	Tue, 13 Aug 2024 17:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPOxKoGm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009E91A2C01;
	Tue, 13 Aug 2024 17:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568771; cv=none; b=XdTm7ZT+XyWO+rqm3BORCGs8Mv1par/4u9BCsYnuJImPQRMp6moxphdhDmcR/3dMQ3vfKNUzYhNoQ8m+l5mdzsHUk1ckPBgyBAGKUG9OS6fvZ4j/o2ZfcCZV9rk7wP57i27C8hTzyS1jvIoHV/tRZt57/9C7wICE/9hmvAeit4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568771; c=relaxed/simple;
	bh=dWbaslV3ImDpvRvaMLnGXkIpncnPCFLL0dppXw0Goew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m16FTV0WgZHbbIK2dXqiC++WbwWnfC64wZpZGZU4yYdhCunSy/Ehf2Ehij62BUMmLmJaRxeWLm0IXO4V6JHKwAaqMvghEAq5fQtu12sUy3LIhOC2mkTxgOw8AZLzzh/tbvCFLeNrdFU8FPA7nYWfXZmIloKIu2aib45RiyQkOAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPOxKoGm; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-81fbbd4775bso222883839f.3;
        Tue, 13 Aug 2024 10:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723568769; x=1724173569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0sZsb6ltlwXBeuXfPHSdXrF6cY3aDT1sNvM6eUoQL8=;
        b=DPOxKoGmAMfATjexjiknVR3UCwIrZEYjPdIVbMAMFaTTVCHruFPIJmmWlhbE6wtI0q
         7IAs5/VV2tsL9O+dD7jMzzx3cG+p06K+jP6e5bA62YC9TnCU1slINY2WmOyM6xPk9mk3
         LXDBkcMbE6XzV7uX6r+GYLCE6BJwf/wdfkPzH43gtxW5AoVpB2DenOzn7YSXkmJy+SSc
         AGwCs2nL0UsIY5iHiWCs6rfGOZWeYWOLoNwq9Xq4w+fscPGQBNYOX50Ff92S/NAN2JQ8
         RDKoMQexuxy7pJf15KjNASFWjXe+NH41RGnS6ocbznbIOaq/NEvo0wp2eVbJiquO3gBj
         +5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723568769; x=1724173569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c0sZsb6ltlwXBeuXfPHSdXrF6cY3aDT1sNvM6eUoQL8=;
        b=VDMCkWkblT+zpvS1kTVzm17Ib4b9JHPRoHXjVgre28CGDv0CqEJAdLrtAryFA9f45W
         H54iY/Nt/XukeWTHkZuGEB7ABs9pMUHiJOJkmTw5sUg1YWfmRVfTuui+FUsTcDS6QXsk
         JjqtSbca7ExerzZWPGmenOo5kdTOnqrGRwtffo5UnZvasYvrN5jybu5DkgMy+g2ZbS/z
         j/tAuuxo6rMTV4LD/feg4gm7n32LX98he9Y4+/SyYkHqtSe5/QlsfXSI3lrnD/wESP/8
         ZiHWUTzoeF4VoW8InJrDtEqfejFewW1MCocGoo374WTdPm1smTPfMnJW+pWAXjRgy27r
         hnJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUz+MwPqkUzJwpwLepH14vuUaIouo6Z6BZvowtDVFXXSkOK1zjxGdmF9JkYhZGwbguAiULj6fvtD4bR+dxRg0GxAfoJ6p3NEl6i3dZ
X-Gm-Message-State: AOJu0Yxi4Y2dawkcbVhyhLBzLLwoz42bfddEafJ7XvQHq0tFanXMb9/g
	5KGW1Jv0M32/x6pA8b6sMVTVwe4ZQ9YY/kVfRZbEwT8/oT4nbDAwlRvG/kLI
X-Google-Smtp-Source: AGHT+IESjOSkHOg1sqqE8IWaty0EbuhRg33ls2pxHZr3llzO5NHrG0AsvgMrxRBsP/ADgZRQADvFBQ==
X-Received: by 2002:a17:903:1208:b0:1fd:a0b9:2be7 with SMTP id d9443c01a7336-201d638d72fmr2751805ad.13.1723568721909;
        Tue, 13 Aug 2024 10:05:21 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1a947fsm15946425ad.140.2024.08.13.10.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 10:05:21 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de
Subject: [PATCH net-next v2 3/3] net: ag71xx: use devm for register_netdev
Date: Tue, 13 Aug 2024 10:04:59 -0700
Message-ID: <20240813170516.7301-4-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240813170516.7301-1-rosenp@gmail.com>
References: <20240813170516.7301-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows completely removing the remove function. Nothing is being done
manually now.

Tested on TP-LINK Archer C7v2.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/atheros/ag71xx.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/atheros/ag71xx.c b/drivers/net/ethernet/atheros/ag71xx.c
index 3c16f6c5e75c..b74856760be3 100644
--- a/drivers/net/ethernet/atheros/ag71xx.c
+++ b/drivers/net/ethernet/atheros/ag71xx.c
@@ -1917,7 +1917,7 @@ static int ag71xx_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	err = register_netdev(ndev);
+	err = devm_register_netdev(&pdev->dev, ndev);
 	if (err) {
 		netif_err(ag, probe, ndev, "unable to register net device\n");
 		platform_set_drvdata(pdev, NULL);
@@ -1931,17 +1931,6 @@ static int ag71xx_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void ag71xx_remove(struct platform_device *pdev)
-{
-	struct net_device *ndev = platform_get_drvdata(pdev);
-
-	if (!ndev)
-		return;
-
-	unregister_netdev(ndev);
-	platform_set_drvdata(pdev, NULL);
-}
-
 static const u32 ar71xx_fifo_ar7100[] = {
 	0x0fff0000, 0x00001fff, 0x00780fff,
 };
@@ -2026,7 +2015,6 @@ static const struct of_device_id ag71xx_match[] = {
 
 static struct platform_driver ag71xx_driver = {
 	.probe		= ag71xx_probe,
-	.remove_new	= ag71xx_remove,
 	.driver = {
 		.name	= "ag71xx",
 		.of_match_table = ag71xx_match,
-- 
2.46.0


