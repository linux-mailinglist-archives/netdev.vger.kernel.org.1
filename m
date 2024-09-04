Return-Path: <netdev+bounces-125159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC2E96C1EF
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADB63B24FF6
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 15:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7054D1DCB26;
	Wed,  4 Sep 2024 15:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfOGV6pD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36D11DB55B;
	Wed,  4 Sep 2024 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725462636; cv=none; b=btuWM+Oph/GPUmHgMlFFnOCSnoI5L4ZZnVcUx8n/73vErVc5awDMl+pR8yw0BTdL2GBx60G9zwc2FPheLI6wGVXgJCDNiomW8iHZyJ0iTgs54tMJACj1HUnNRGscU5D03Xj467su0LAlxbk76m0lva37RjjcRTRcYFxyHwuALpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725462636; c=relaxed/simple;
	bh=QrUQcvnmZvtnPzZt8iGP4n9fjXwFPYGCz1cGar7E9G4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N1ZaV4hV2K61Fy/S6UGZ2DexuDyaCrdoUBWhY++s2/IgNQg5TPwjNi7OrAO8GoLD6RHtJJSMq3sleiwSkO9giLMoQpR+2m38NqFHZFs/bIj1LLhfNbKr2lurxgp/ZMDX3CUumGpPH2/CiCs0bQOz2FXNB1pQEQXKAMPhwhCEbPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfOGV6pD; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a86859e2fc0so765551966b.3;
        Wed, 04 Sep 2024 08:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725462633; x=1726067433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVYXpp6XlxrexNwfXvthb0cGeIQ6ry7hBWcPM5Sw6j4=;
        b=HfOGV6pDVkG2N7C83utqr78ghPQJYhdpA6/Agjni6tLTI2OfvNJZvVt3QqV/HQm5qe
         zDuWLm92EDRrw7+DWF900z576cwotTWDUWeHJ0dzF7RNU5ve++ou63uEy3hY4hlCj90r
         YpFFxGrNFgXBlNvKbl6HyBGoZjYdzSKl5U8O9LmRSor62sftUspRhifnn9nAPHYk1zeP
         o3EwEkSFNxXB8lVFVpN73njddk/SHl8hFteER/PcU5Y8EvySh9m0LrzJWEMe6YlsBOq6
         wz6VenjSCZ9GiLjDz37UhxhjxRcPR8MMHMddJy5HsYw+NWdY5nlC1QHKEFDcfzZHiC1k
         2NSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725462633; x=1726067433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVYXpp6XlxrexNwfXvthb0cGeIQ6ry7hBWcPM5Sw6j4=;
        b=T2CUax4Qu+UJQGUphdFvrlwFNVl7N2gZl4o2KgEcLVwzUJNKBalkQ4drb8SnyzTaNs
         djL8uOARD93i5Ixc5SZ6ylhRhhI4NyiUoYdNN8HN8P7aFnQ2o/qfqfjf+7IhphC6oy3h
         7SfTOVK5n402qtYJxJzfrkYX2WI3YD+c9rudRzNMpIAyKusL+u7G/nLAuxebieEuyPsJ
         it8EIykhn+847Mp6IgIjeC/2UqSljISTsceM5bHH4sFgZlS28iU0HqBJD1jIf8iLG2Nz
         lkxXxBL1ao2YsvFdShZ8SQv0zv3rn0tK5ygfiCKNVLLc/Rdpw8IIcN0OTswrDIkgIyxS
         nzUA==
X-Forwarded-Encrypted: i=1; AJvYcCWCJ6trrben93YLmmCcloRPZ3SdAX31bH8mxlqBdp/hTVOdJS4OrioNNEKACWrG0Et4w+QHEyivlNmjjEo=@vger.kernel.org, AJvYcCWJWBtyr4p3ZdkxWlRVi3ltaDR9IRmojOZ9apTqZbt80HgGPywJq1ldg+gZ9MYAN1sdOfReDFKa@vger.kernel.org
X-Gm-Message-State: AOJu0YxeqZN5YecAtgXggsSPLMK0/omyzQljba/pUAizsOjr++c9t7hw
	NQw5j9s0NEOsIoAPqfQNWQchYyoa5+MGWBkmS2lxi+JhlWLqcFil
X-Google-Smtp-Source: AGHT+IGoADnZ37PuQ6DBhcHpi5YGPHXGekJrXKMl+h/IZ5Am4rR4Uj7hDb49H0CjHG7JpiFGmzy3ug==
X-Received: by 2002:a17:907:3f21:b0:a7a:9ece:ea5f with SMTP id a640c23a62f3a-a8a32eda770mr313612966b.41.1725462632789;
        Wed, 04 Sep 2024 08:10:32 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:2f85:317:e13:c18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623a6c8bsm2956666b.146.2024.09.04.08.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 08:10:32 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: linus.walleij@linaro.org,
	alsi@bang-olufsen.dk,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	nico@fluxnic.net
Cc: leitao@debian.org,
	u.kleine-koenig@pengutronix.de,
	thorsten.blum@toblux.com,
	vassilisamir@gmail.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 1/3] net: dsa: realtek: rtl8365mb: Make use of irq_get_trigger_type()
Date: Wed,  4 Sep 2024 17:10:16 +0200
Message-Id: <20240904151018.71967-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240904151018.71967-1-vassilisamir@gmail.com>
References: <20240904151018.71967-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert irqd_get_trigger_type(irq_get_irq_data(irq)) cases to the more
simple irq_get_trigger_type(irq).

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index b9674f68b756..ad7044b295ec 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -1740,7 +1740,7 @@ static int rtl8365mb_irq_setup(struct realtek_priv *priv)
 	}
 
 	/* Configure chip interrupt signal polarity */
-	irq_trig = irqd_get_trigger_type(irq_get_irq_data(irq));
+	irq_trig = irq_get_trigger_type(irq);
 	switch (irq_trig) {
 	case IRQF_TRIGGER_RISING:
 	case IRQF_TRIGGER_HIGH:
-- 
2.25.1


