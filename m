Return-Path: <netdev+bounces-130654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9313998B023
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 00:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C17F1F2343E
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 22:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E56B1A2C39;
	Mon, 30 Sep 2024 22:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPHxr8sV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85D21A2871;
	Mon, 30 Sep 2024 22:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727736070; cv=none; b=BedfD5f+p5ZqfgElTMNAroGAl6fnmY+d4qigiYOCS/wiQsm0Xv5kNQt41RtfftKpyNmayR6FUiRwoB/PBG/bi+PUKCjJaQ5pJ1QWB5FYDbg8tQxyX7+SHPi1GKYCHI90MoL5BGAznuE7ArnRye97kncy8u9aBlsCDZFiOCFdPXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727736070; c=relaxed/simple;
	bh=O1JnaGDR92Hsq5CghCDvAJY6RbxyyGAsCKoBXpIV9w0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VGd2egwqF5i4hNfCMkZuaU6xYhR5GJGVwa0POiXrl+0AbqvKk6DWMMwfznN28q79L1kfNYRfd//eRuhPM5CB9vBJm68txMPH810JS51rxuZSI+MPEkeXyfiqIyCcRknh78E3w3EQDq/zzsLulXXMPoRXdoTyUtgTaT1onFU5NCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPHxr8sV; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71979bf5e7aso3574411b3a.1;
        Mon, 30 Sep 2024 15:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727736068; x=1728340868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/ZUwxmusPDGmPf3q3AUKBZNi8n/O0xq8YxGYUSv+QE=;
        b=SPHxr8sVj4q/26LiXm/RsOUs6oN/Bt80BbXhIcfpwb4TXN6qtA6jGWyrafI6+5VnWY
         wUHIyQq/JtIuRXxApuy6uJjURXYQ99OTEBXbXVhGwmVbM9yCV2yLdimvsFY5zw3TJlJ8
         QK8XnoXTNmLkZBfjust3yz+oAChsGzP86Sr1eEjjzKI46YD89QepOL064ebUTZC0Ttmk
         DGt+Pl3ikM+Ia5OFUKEL0PzeHoGHvVgrObfKGzcnesjpFTneVzjs8poncjMaQ07uAISe
         iiK4Y2kAlMJ23jX8TEGKjLUDBjSgTw4MBWKHTsoeC2AVJX8mJup8WLgFVX+hB7Vy3Ixt
         uQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727736068; x=1728340868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L/ZUwxmusPDGmPf3q3AUKBZNi8n/O0xq8YxGYUSv+QE=;
        b=F/cIutcDkEiyxQ1Twftaj87pYr+cxRZeYy9odIoCEIBfM2vONil4uBfhUu+vAUEFzE
         Qy1Tn4lrhavEEJ+G1OJKiooBB9Cjv+Tl3TqaEMzi5mZfWT34o7Dui7/BXu3gNHgzbYaD
         +e5thHCwABcHdvrVxXmx2BV0imygA/z5xl4gX6lHCmzp1NuPIbeqouEhWKNa0lP/NsWt
         Rj6Fzj0E8AnNFt0tLjO8J6fKt2cxEkWQp5JONA67SLNk24VPHwmlq9jNS1YXOhJlH78t
         vhKkQyCK/5OS/Vne3fmDt/FTLLXjNGEfuWFkFjhIq3BuC8eI2VosnytKQt1e4pgg8wcB
         hdIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDlIDKJjnHHfdzrMDb6iyoVx3iFV4NIVWsQQyROBu2UMx0EbmzcmmpW7aPxCUHy7aed5KmFEUAyvVB//0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQBwD6s2M+PnN5WQPEQzCEfmZMiIKke2RSFCEo2coOIyxwsLVV
	IwA+J1f0b7QlqokspNW+l8JRoTlt1Wja7jDmGbU79Edyrp7fPEOe4Z6miWS5
X-Google-Smtp-Source: AGHT+IGpHLEU5JVDyI2Q+/VJxRdfkXJT1VHBg+PDcnLmuUOHfSEUpqWMO5osjsPMxBv3F/nTzW/ZiA==
X-Received: by 2002:a05:6a21:2d8c:b0:1cf:4da0:d95c with SMTP id adf61e73a8af0-1d4fa6f9a33mr21254205637.23.1727736067735;
        Mon, 30 Sep 2024 15:41:07 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26515e40sm6786921b3a.117.2024.09.30.15.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 15:41:06 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	steve.glendinning@shawell.net
Subject: [PATCH net-next 6/8] net: smsc911x: remove debug stuff from _remove
Date: Mon, 30 Sep 2024 15:40:54 -0700
Message-ID: <20240930224056.354349-7-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930224056.354349-1-rosenp@gmail.com>
References: <20240930224056.354349-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not needed. Now only contains a single call to pm_runtime_disable.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/smsc/smsc911x.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index 4e0a277a5ee3..e757c5825620 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -2235,17 +2235,6 @@ static int smsc911x_init(struct net_device *dev)
 
 static void smsc911x_drv_remove(struct platform_device *pdev)
 {
-	struct net_device *dev;
-	struct smsc911x_data *pdata;
-
-	dev = platform_get_drvdata(pdev);
-	BUG_ON(!dev);
-	pdata = netdev_priv(dev);
-	BUG_ON(!pdata);
-	BUG_ON(!pdata->ioaddr);
-
-	SMSC_TRACE(pdata, ifdown, "Stopping driver");
-
 	pm_runtime_disable(&pdev->dev);
 }
 
-- 
2.46.2


