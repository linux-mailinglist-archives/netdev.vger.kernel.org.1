Return-Path: <netdev+bounces-128856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7E397C02F
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 20:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F8D32834C0
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 18:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C711C8FC8;
	Wed, 18 Sep 2024 18:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cx31pznc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CA0163A97
	for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 18:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726685118; cv=none; b=HNnMFJZceaSiJK9Ntm+5KFeZP4Fsz/w/VX3+V7zgRKCBe5yNHwHSYTBo1+3u02tbiBLuU1/uFVuChhM6KmrvZw0lruWlVFPRIcJ/RJykcilqNBKzMJ56cR9nKahqYtaL3f0qmbn8H5t3v8DeDdcJGUNkf6L7NAw/KdEK9l5hsCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726685118; c=relaxed/simple;
	bh=URCB2a7dbylivflZu1RwV0j6wnD3YU55l7XX63jbb8o=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=qi0ea17vUtOai00brN4fnQb7WaSnKqHe1TuToLdbtwhAr4Fb/7hK9fbrpgFXTHTxunuBeYPBtRwv6deU1wobPnKhalaoE2h7Qtab+DlXBj0x8uu0L4cd0kfLd7Kz5ueCFS1XEu1+PlVjuzLe4Vz8bouKF/RTW41RGUyVjSdY2pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cx31pznc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cbb08a1a5so69005115e9.3
        for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 11:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726685115; x=1727289915; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ndcpTU1kHWEs7pGtV3++AaFoX9S53+hZHYqZ5+GZyxE=;
        b=cx31pzncr2Vv2+mtcoKP1vDbrPBueQ2xuQBEzaJwPCUZYWT6ZeNbXiMwK23ga+EuYA
         lJyFhBjrEql3hm5bVh59OO4J/LuzOgFwB9wRziI/RNt0mFzojiGyS9AHSPaRJyhgzQtA
         JnRAoZLAVm2YUnhpDNLQioBG9GkznB6wsNXz1xIDDOHmfhjHsm6IYc3qY33QA7HGeHpZ
         m+6dBRiUyGjr3w5Utgk8pNNr0SOpE09Q374Kfm2HcYLVsTjaGajzWo6PCthlll+mKJzR
         aHXWQ7w7X0oEr7vTFI2lZArvqeSjakLte00a9zmJh1LUoe8/Ulf+9zqKtDpXvA41MpLH
         yJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726685115; x=1727289915;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ndcpTU1kHWEs7pGtV3++AaFoX9S53+hZHYqZ5+GZyxE=;
        b=ISy2i8fNsHAOZ8iV4Zm1iSLaMZyY+EoYz2mWA0YCfFKgxnw/aw6rZGPDBUDvF4wSmu
         bu96V856azHsziOn24aRanbxxTdQo5IxmICVdtEDKNl9JMLi95dBJMPtTm1rAnBD8C/O
         1YF6EVjz1Vc6H77c43uP+qUkhlfc/jdaLXwz6HYarDfG8pebLv97daPIIqZbkuJOGuGW
         Ft4dQ0NYjoSKxeSOoV6HvjhBHTVxG+LgcmgiElgcz7reu7pNN3xt1bnW+a8WQI3ClCqv
         H/DGhUWH6Fv9j9oCT/g9txWray2nNi/5+zsnwcbF1F6SP1H8rIZhbNEHteAoFRMR/V+U
         c2cQ==
X-Gm-Message-State: AOJu0YwEgdkuB9lojTubyd/lid/c/ZhXj5Ts3IzH6xjIieu4qWP6pAeC
	t45prTMcRYTwGl9lwE0E6MgECHaikHdLqohBCETCibSJEKZaESPK
X-Google-Smtp-Source: AGHT+IFvifFFk+mv3/GHV5PNeR3cgne+avrYkRq1yQOZD+5VB1J0Oa10OcnE6UBBr2ePXAUirF7chw==
X-Received: by 2002:a05:600c:3509:b0:42c:df54:1908 with SMTP id 5b1f17b1804b1-42cdf541bf6mr143126215e9.18.1726685114567;
        Wed, 18 Sep 2024 11:45:14 -0700 (PDT)
Received: from ?IPV6:2a02:3100:a092:b200:749e:d158:4f33:1a60? (dynamic-2a02-3100-a092-b200-749e-d158-4f33-1a60.310.pool.telefonica.de. [2a02:3100:a092:b200:749e:d158:4f33:1a60])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-378e73e80fcsm12986244f8f.36.2024.09.18.11.45.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 11:45:14 -0700 (PDT)
Message-ID: <bb307611-d129-43f5-a7ff-bdb6b4044fce@gmail.com>
Date: Wed, 18 Sep 2024 20:45:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 ChunHao Lin <hau@realtek.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net] r8169: add missing MODULE_FIRMWARE entry for RTL8126A
 rev.b
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add a missing MODULE_FIRMWARE entry.

Fixes: 69cb89981c7a ("r8169: add support for RTL8126A rev.b")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 8240ca64f..1bebba771 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -708,6 +708,7 @@ MODULE_FIRMWARE(FIRMWARE_8107E_2);
 MODULE_FIRMWARE(FIRMWARE_8125A_3);
 MODULE_FIRMWARE(FIRMWARE_8125B_2);
 MODULE_FIRMWARE(FIRMWARE_8126A_2);
+MODULE_FIRMWARE(FIRMWARE_8126A_3);
 
 static inline struct device *tp_to_dev(struct rtl8169_private *tp)
 {
-- 
2.46.1


