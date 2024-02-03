Return-Path: <netdev+bounces-68851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5789684889F
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 20:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D39001F229EC
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 19:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986FE5EE68;
	Sat,  3 Feb 2024 19:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkmRm+KE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D428A5EE79
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 19:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706990092; cv=none; b=OVzgMSCv6W1vt/ZgF+fp+aWEo0QtqAxYhGDPIxVTqI7/cEpuYbHEVEHNd8AN7KC3fApAoY91UjZ1zBDdhmUcqIpcU8QgDEn+pn0q5bqP6/GufedYmMHrs3zFx+zM8eCIRjWYPFCnSIZRoeHAm6Q9R1EnkyN1ODJniH1ur7bjeIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706990092; c=relaxed/simple;
	bh=qc7g4Hmv/oX86EUlq8UNbs8uduzJjJ7tRToD1Q9kp4w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=R7v5zc0X9WX1EBqP7j7W1hH/pSr+iRaRFI9gEY47RQ6azKan7nsitck9p4y3LaBT0HBfZAqAcc39kLLNSxuOemZu+5YAdmH8cIceV8tPEQMtpxTIA716SHVktX4Iet7xI33mIzSbHCuY0w8g01tgM9R6VmCsAZOiuoSXrqPlz1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkmRm+KE; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55fe4534e9bso2505133a12.0
        for <netdev@vger.kernel.org>; Sat, 03 Feb 2024 11:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706990089; x=1707594889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xNYTqPh06HI8dgBx6hS/930xiBP8GYsiVYjtCayK4pE=;
        b=HkmRm+KEsFfyKTbuyEwShxII8pC+A6z5jFaF4H/hf/YwOMktV7LPsBN65YTb4YPYiD
         drvggQB0YO8Lj8QtOozdbb1Um03vKCfe/gt/+ElMkLxoPf+cs5Nk/HsIO3WkAogK65Jh
         OFB3j89ZQEV1b1wg88qrcTgxFNKZUvB/0UKthfJt0ksZqnwC7VfWsraWItHxPircVC4L
         7ycf3fIwpR+MvD1NmEs8svk6OVTfnzaNo1VLEnUoKgCPhu8NNObeZ3Glgv053+IpR41M
         FCJ9hLkRTzmxqbQhxOidr3T7MSyp8hHeriFF9xOYa2I6QqDJz50uNZbRwVxVkF2VxIPC
         MFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706990089; x=1707594889;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xNYTqPh06HI8dgBx6hS/930xiBP8GYsiVYjtCayK4pE=;
        b=wQ/KMVIzqbchXUQkulNW0NSKWtsRmxfTp1UFM0xISAoCznn39HXtZlYFbL+CXSWHvp
         MxV7nsNul55k2dDctC1gasUq2o+SXJx1gaTYBcrdWu8WH3VraLqp7qh78kDFvZJ33+u3
         T3bJOk8WtCW9PH2Dcyti+4fNjcY6lAHgswVKOmwXI5MythR6jAUYAgGk+GX5+kZKtBT0
         bAwRGPCHjaiKY+YSR+VlN+Eifv/sVnGRc1zwmdgH9bZDHc/GLcfKQg/PexJbdhS8wab5
         SrH3tWVA0AqIFUVK5zi44aPnuiDYhRdW6Gl2DbZYdnLCVAW9b1mjBaVI57yOwJI0s1RS
         pRjg==
X-Gm-Message-State: AOJu0Yw5qwLyrOtAulYiAKT0dvvEVxiQJZ8m5DC/Cj60sj9G97yCKIyw
	xGhpz95bg9c6uvXCHHUmiVUTZC5E66cGt/6cHfqfj5Hbkum5DNIaGaZuYCrw
X-Google-Smtp-Source: AGHT+IGRBYsihUYZdLeo2mRaddmBjyOCdckC57g2XpAMIIzyICOiOfXbp8P1porTac0yWehtQ9VY+Q==
X-Received: by 2002:a05:6402:1491:b0:560:7f1:9b24 with SMTP id e17-20020a056402149100b0056007f19b24mr2053728edv.3.1706990088754;
        Sat, 03 Feb 2024 11:54:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWriDDT60ABdyUn/C4SjWq77y6T1a+9GKdn1pZXq2sDhT8bZUZq1dkO2Jer8zNodeS5XZlw3lcImw6HOhETS2uit+rCtbJN4xpY78lxgR9Rut8UgeDZ695iumpEkobAkMBxnPT5T/iGlWd2aQFsgclhgdaGRco0jKQcGk8nmnx/i7Ef+E0bgiu/kwGdMoYgWRVBUQv91Iy5btmH3P14F8Fs62N3I0H+26CR
Received: from ?IPV6:2a01:c23:bde4:a000:48dd:a4bf:88d3:e6ac? (dynamic-2a01-0c23-bde4-a000-48dd-a4bf-88d3-e6ac.c23.pool.telefonica.de. [2a01:c23:bde4:a000:48dd:a4bf:88d3:e6ac])
        by smtp.googlemail.com with ESMTPSA id n22-20020a05640204d600b0055f50417843sm2039152edw.22.2024.02.03.11.54.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 11:54:48 -0800 (PST)
Message-ID: <ddedd82e-55da-4db5-acc6-9407c03f168c@gmail.com>
Date: Sat, 3 Feb 2024 20:54:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next v2 2/2] r8169: use new helper phy_advertise_eee_all
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <0d886510-b2b7-43f2-b8a6-fb770d97266d@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <0d886510-b2b7-43f2-b8a6-fb770d97266d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Use new helper phy_advertise_eee_all() to simplify the code.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index c70869539..b43db3c49 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5091,8 +5091,7 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 
 	tp->phydev->mac_managed_pm = true;
 	if (rtl_supports_eee(tp))
-		linkmode_copy(tp->phydev->advertising_eee,
-			      tp->phydev->supported_eee);
+		phy_advertise_eee_all(tp->phydev);
 	phy_support_asym_pause(tp->phydev);
 
 	/* PHY will be woken up in rtl_open() */
-- 
2.43.0



