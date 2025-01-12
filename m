Return-Path: <netdev+bounces-157538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB78A0A998
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 14:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED67118870EA
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 13:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE5F1B85CA;
	Sun, 12 Jan 2025 13:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qCOZm1Pl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FD31B6D04
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 13:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736688783; cv=none; b=rhUeruC1b71Q4Uj2rLVgoJISQmk32HGvK8l38xP0TApWa1jy0+UL0BW5ht4ikQNGjYkzfguAbKeQYt22SSwE0C3+6YdK8FgOk6HQ93bcrVaIdl+GurVCx163/a2H3/Vr/K5NG1CnFJrC+jS4uJBP2Mj+Cf372iVajJdso4y1AO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736688783; c=relaxed/simple;
	bh=/XBAGwsAFpwFBBQSU961+beyZLkCUNZ5sGTLi9rt57I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UAz5B+uHpVSPQwiPtcolpEUQKZvNb65psLwaLSY0S5f9jqRW6HjAoN+A7NTWauzVWmgaZJ2/nXoKA7I+QbZ4Byoz4P9OiMS0GsupRRe1RBqiP1zojyBkspVEsifgdlEb7MihyYb82GWbJ5pTzIPnvKFPrdsvyz16ythlwgfRfm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qCOZm1Pl; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3c0bd1cc4so553411a12.0
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 05:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736688780; x=1737293580; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mRUu7xwt0GOb8hs+BKrBffaLbY4C8ptCLopKQNeTlgY=;
        b=qCOZm1Ple6su6xubB3aUzkbcGZY5K7MO0zPdNroySwDfBp2vZjced97lXRs20mCMjD
         TpqNhAYOVSgXEyLUlwSKPK8myR7E4LM7lC0bH/6uVBe64Tw6gbFrweWAezRV31FuqUus
         ylxA6yfdVHaoAn60GnMlTomzQT83GX65ptlRn9yCLiAH2XouZZROH4/UZ6DND+mRAn3m
         GUPNcDrglp5bdhdfK13nsmnv2pEJb826beBvVUlt2J8Kq9/ewyIDbouux6zCTx0spjgy
         Z+S6m7i5vmbAAiB5JBlkomehkCUsVGaTHdlUqfxb7hRqcQ0eLGt/bFrrcX3k8TuXz5i4
         fTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736688780; x=1737293580;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRUu7xwt0GOb8hs+BKrBffaLbY4C8ptCLopKQNeTlgY=;
        b=HVKj/Ca+9Wsoa7sqWsPyIqNXkHjc/mDEsdKiIgLGCQKEd6mLE87BtsBGHokw5JEtWS
         JQPJgOCblrBqcf0cBbDzvB96P17joZntLPxy8aeo8VZaPE4Y6vQUx+YYS3uc/bCrcQ1Q
         nUZMMTnYHs1H4lD7l3KDg7qMX9QsvfrZXYuMdjvbNITbM/rfm/EhFqrdEYJ6iQOws4wv
         fY8zqhqxjQo0bm6QfCbYXXxuco1dpgzRQdFRFVJfoKIrqWxHa4hLL6j+TgBc+MdBkFCN
         QI6AMmTLYqueubRTKkt+bejF8aehRvhY48SmIvcR/viMNNvB/ae1VI9/xSbDj/lQx6Oe
         FsQw==
X-Forwarded-Encrypted: i=1; AJvYcCVw+zwoKgJxav4xsSJZIg82qx6BMwD8T1bJBXmDJoaDOh3KYLR/PeqR8zBz5V/Aa52yZtnHqkM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi200Rmeiq2u+G7wyFnUxXBh0QyugGI9jh3drlauJEwQfURZIh
	eZ165HqNM5tAOrinsCHqmuX1ln76qeTSlM6lgOqTMTV7h/ASxNlePPJIxdDVRTI=
X-Gm-Gg: ASbGncsTdvp6+QNVki8YFad57TUZJZbwSbZB1z+fZKBgzXmu8nVq3hECF4dckukfTp9
	RFAFXhH0fZN56XF1QfrR4h7AToyd7yVGqDo9CBmZyegohUFIyxet9/uxW46ieqLxtNCNwVIff4p
	sopcnQsydCIvzj1noaKKLl3iJx/NPAER89IT8vJAF09X6c8CL84gXNUVEo49rMiCzOYL5PWhAEG
	FAP4H4ohjUDKTq/TwGmFbC17gZhuFQcIconWVLX7B8H0nZIvVxcXSKa0DyLm62YCp29Xlvr
X-Google-Smtp-Source: AGHT+IHe7/2lTE7/Nj6QfvaBW+C/pcgDJDaV2DeHYFVEZqu1pr4HggBi1zI3dnd6icGke5g9aysmUg==
X-Received: by 2002:a05:6402:42ca:b0:5d0:eb6b:1a31 with SMTP id 4fb4d7f45d1cf-5d972e1eb67mr5915789a12.5.1736688780172;
        Sun, 12 Jan 2025 05:33:00 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9903c4477sm3584609a12.51.2025.01.12.05.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 05:32:59 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 12 Jan 2025 14:32:43 +0100
Subject: [PATCH net-next 1/5] net: ti: icssg-prueth: Do not print physical
 memory addresses
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250112-syscon-phandle-args-net-v1-1-3423889935f7@linaro.org>
References: <20250112-syscon-phandle-args-net-v1-0-3423889935f7@linaro.org>
In-Reply-To: <20250112-syscon-phandle-args-net-v1-0-3423889935f7@linaro.org>
To: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 imx@lists.linux.dev, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1232;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=/XBAGwsAFpwFBBQSU961+beyZLkCUNZ5sGTLi9rt57I=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBng8SBqm1C6n54I2y3MlkXEqlfvD/rdrdWXja7l
 F8+5Is0j1KJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ4PEgQAKCRDBN2bmhouD
 17VVD/4qthD2/zGGxdy7/UvqcrbSUvelem2TFjP4otSbOQQWt2FoBYJM9pNa/ia4nDRzVPRxvWp
 AB684QLqy1jsKUV6CGPT3D+zER5yVvYN4twzngQrr02IRwqmYMGieUhT4C5lGveMXOBMmGa2mfU
 udJ4cuPGtlhH3fISl4u+3noNIZKMzIg3tNCkfvRsZDOAxAPyLpaePpjLMBYlgfahKqDSJJ3Ymly
 +xpGJ/hwDta2luGxIuxazAdQWU4lIeXdwHWgMBrdSensqJLq59XmNTDvSvGOYe6RhYYZEOGkBh+
 dowV/JQhEousq+sLQk8Vg6rJ20bAffXxCqMtmMMKK0iPtwmP7eeWQipA3SOUCyoWyqstPFDnJef
 WwaKd5jhJ6isWq6wImBLMXOke7etQoi8jD70/MBSBHYv5utAytgbAPEPSfrKdDyrDKanOHAS3Uw
 3qfAbOu3ld+3DGyNuxGR9gKUfogV69mX1twFMUXFg01h/7HOcmqFUu4qyW79JH9Fm5zJO/kIneA
 HbwYf3HvIrn7L1rWNCiZIli0eXsOgM6StdpoUZ9ty2Vp8tBg21cFVNlkY77/RG/d4ZAsx89Kw1p
 bp3xe0sin6kUFa1weHxNQaVneoV7PfrWRYHktdBkv66MzEVc9Yneu5Hxr8HS3MmFxNSjVv5cFp0
 Mqd3su6GpsWZLIQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Debugging messages should not reveal anything about memory addresses.
This also solves arm compile test warnings:

  drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c:1034:49: error:
    format specifies type 'unsigned long long' but the argument has type 'phys_addr_t' (aka 'unsigned int') [-Werror,-Wformat]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
index 3dc86397c367d2b195badcf1fcb5f1ef39ffabd6..64a19ff39562fa4a6ba6f7e9de903f689a3d5715 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
@@ -1031,8 +1031,6 @@ static int prueth_probe(struct platform_device *pdev)
 						   (unsigned long)prueth->msmcram.va);
 	prueth->msmcram.size = msmc_ram_size;
 	memset_io(prueth->msmcram.va, 0, msmc_ram_size);
-	dev_dbg(dev, "sram: pa %llx va %p size %zx\n", prueth->msmcram.pa,
-		prueth->msmcram.va, prueth->msmcram.size);
 
 	prueth->iep0 = icss_iep_get_idx(np, 0);
 	if (IS_ERR(prueth->iep0)) {

-- 
2.43.0


