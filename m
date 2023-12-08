Return-Path: <netdev+bounces-55176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2DC809B2E
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 05:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36B44B20E61
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 04:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7575251;
	Fri,  8 Dec 2023 04:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQH+reP4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16D212E
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 20:51:45 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6ceb2501f1bso1154224b3a.0
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 20:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702011104; x=1702615904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sj+NGTLcVIm2x2Sna2sYJVoQeNn+dqA0+AshLQHmF+o=;
        b=IQH+reP4eDVUkB6BHPFkAV2l8z79FcUSwc3CD4gTsLV9FmRggyXR5Rox+R1lgLqn/C
         0OZqCF9ROwym56ICRSGvbJw4dppqeL2jd9PZBqGxjw+0J+MI5+uzJUH0wDw/NdZxa0Pa
         7oHA3ayVPfmQaC5zDIulQ7iAkPeRqyp4eEabkLMHyRcDz3Cnrr+5rM3qdHQFiaDeUOi9
         tr53rrsQEzrYNx6CyYbThfZ1fpHKTZfP4eTD6THL/zplswm1MJ8OfWubwBosZPR8YWQj
         PNh7AbjGTG76p3Hm74+ioOE6Ly1owlNI9xLxDJRFLJKVTZj/Huri3SrHlngx7aPwoNK9
         bCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702011104; x=1702615904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sj+NGTLcVIm2x2Sna2sYJVoQeNn+dqA0+AshLQHmF+o=;
        b=YCQedBQkJSYoVSwz0VLivEFqcSSe5yWDRBLDJNWtvH0lhvkKVB+MNcjXR8V2DTwPdR
         8vJP9jwXpuJTWAETsF0GifMukd4IPmGNEBQ0qV7ey+a2UU/pKPBABwlvSVysUyhhjg4P
         Bx4ls8Uzt5mmdBlwRYQnBNUl7sVVQRp2QxfXBBdl2S1t8oPCWdA2Qdxq7R9glMKWHb4Y
         91ImJlKoxQZ8Vmep5PQJXrtZnWTlrAWrHxfbDzSZWN9gpQtXxM8t45OnBEWIwm3dLimk
         mf5N7Kb9j8Mk16/XOfTLJWelw2E92/0aGILdKMA7BicDne2TaTXhmN0h96eZXUTI2PsL
         NXdg==
X-Gm-Message-State: AOJu0Yzdt63dvNjtehocNc4hv8IgdbeFEbDf5hyYF4g2k+dX43+U8zo3
	IDePu/ICmuFUj4y6QrQWBiwp6P61FT6jhBM4
X-Google-Smtp-Source: AGHT+IEA6Wcfhjn+312rzY5UMo1zhqifO11C3yBoAmFuBYkH8Z+lVVpGDfmiZ8j7i0NQujB2Yl5Myw==
X-Received: by 2002:a05:6a00:1249:b0:6ce:3aca:c5f1 with SMTP id u9-20020a056a00124900b006ce3acac5f1mr4372705pfi.50.1702011104549;
        Thu, 07 Dec 2023 20:51:44 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([2804:c:204:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id f18-20020a056a00229200b006cbae51f335sm657865pfe.144.2023.12.07.20.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 20:51:43 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	alsi@bang-olufsen.dk,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	arinc.unal@arinc9.com,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [PATCH net-next 1/7] net: dsa: realtek: drop cleanup from realtek_priv
Date: Fri,  8 Dec 2023 01:41:37 -0300
Message-ID: <20231208045054.27966-2-luizluca@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231208045054.27966-1-luizluca@gmail.com>
References: <20231208045054.27966-1-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was never used and never referenced.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/realtek.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/dsa/realtek/realtek.h b/drivers/net/dsa/realtek/realtek.h
index 790488e9c667..e9ee778665b2 100644
--- a/drivers/net/dsa/realtek/realtek.h
+++ b/drivers/net/dsa/realtek/realtek.h
@@ -91,7 +91,6 @@ struct realtek_ops {
 	int	(*detect)(struct realtek_priv *priv);
 	int	(*reset_chip)(struct realtek_priv *priv);
 	int	(*setup)(struct realtek_priv *priv);
-	void	(*cleanup)(struct realtek_priv *priv);
 	int	(*get_mib_counter)(struct realtek_priv *priv,
 				   int port,
 				   struct rtl8366_mib_counter *mib,
-- 
2.43.0


