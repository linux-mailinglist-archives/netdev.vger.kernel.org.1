Return-Path: <netdev+bounces-162407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C71A26C4C
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 07:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D4D1634D5
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 06:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410721F8AD3;
	Tue,  4 Feb 2025 06:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MghnXmPY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B96158524
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 06:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738652285; cv=none; b=pKcQr9f3szn1ZJrMC0mHzsk2gcmUHOYlgNLVCpbJ9doV+9DY8ENY9hPNbCbnZcR8BpvElItL9TPREKE4/r99IxkW6tp07yllbVtAOc4b1vnMuYN4C4v2xl1v7hsnBseCBtKq+33TMewCSmUA2friuaJysPDCn6kI8CI09xZbsJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738652285; c=relaxed/simple;
	bh=pO9DbMo9hC6+E1aFWzx3Ium/nHWkaE/QMJrHCC7fTKQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=odCoKjLs7Y7havdjomLolYTqta1y4qBalEE2YN9hqYleG25rPXBygnSQ1eNJcmaMhBljPOYx6wIbW/44XE+97KDWZU315ffLPHd+zbo/6E1q5KIrcc5Kd8RUMrRadm5rMKp3g8dj7RB8lOeQLLWjZrr+KvyaYHIkO0kvfUGdFgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MghnXmPY; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d3ecae02beso7159264a12.0
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 22:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738652282; x=1739257082; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ds6iWwU42aTPR6GW1S+LAxwBWTnIp1aFnf20q13ycmY=;
        b=MghnXmPYwxULxMg1SR5l+RDKWBXk9+yjSqNYTkP1reCW1+CU6N/N60veB2VqiILtwU
         OdrAqxsqaVES5fGyf4NVLd7kf51KyHeETIy+pag30Iiry231oVnQ7A9GfBKiq9lATmq3
         vzTshP3p3LljQut4C5Fe2rKV7dW8SkXDJbjxQ17DerW//ev2c44wwfmJ2jYqIPv/G290
         rjbk/d6QELsjRPtVDVfLTTgQy7woRstzrnEeh17Jjuh/E3lFNdXX6DuOSpWS3T5rZjmQ
         RORJT37cPSjWGnKjKhgTKD0mKbxyNB99GN3DPDTHfdCHFqJNlAX+ol1c2ZycPN8DH1ht
         IHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738652282; x=1739257082;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ds6iWwU42aTPR6GW1S+LAxwBWTnIp1aFnf20q13ycmY=;
        b=qZsMTiTYUo15XKa/2ybmUvIiLRFOnoGC3kybGKUVsfS2hfqky6Pva9pFWMrsbccbcJ
         e/I9CDGU5GaZ7oRMk+xRVCl2Vot6kdCwPyHEuWZsDXsqAOPfK1KIreCP+OwzSLZ8Q9lU
         /asrx1tOQXxPA4OvldlUmPNBbiRltNySaS5x0amJkBU5g1wo5yNOQJfPXoivmJ5riuA9
         0ZIgM4PtNbQP2uAqWaIE3ohloxsNGOoKsA9cfL+9dA3m8BTfTJCTdLBXvWfkutimqG8w
         KhPk5ylJbsYMO1JNu1TZRcUoHcW36E9u58EjakGNysz2eYaB3JGP19BVCsgKvNe9Duzq
         oJiw==
X-Gm-Message-State: AOJu0YySuNA9hJdNnZk0KkPG42lH+h3MWKj/wH1Q1CeDLIyFavNorBBn
	6PCLCggVL/DmGuWOWpvKyRE/z8GQ3zDkPZac0aqPIqn5cB1lSNvl
X-Gm-Gg: ASbGncsKY1j45QQof+cXwj3SIex9SvmcqH4E8GRRx9VQkyG93lUEXCwyTEr+LApUWtJ
	xRoZu7xwp41etjx5+L1uWzRmej+mxtYjz6AiaJSPnRjRIoamGnZES7peYnD220kINsq7+NnaLsK
	2PGBP3XXgb1j8fUgDIg+h8M7BZNPZ7HfQaXuOah2u+zB3AEOzWTSNUBotaVts+lpVs3P781BBz0
	GtPCl1XqLYp1YJaX6GT8S2njLhQt9e8d1iCWchieS7J/nmv0Wic8xtouYWJYy+uhEpFCgk2Iv4s
	tS8SnytWbrKiDrFiYIlR28PNekiHBjMD7bbcNiNUIwDypJi9mqaEcHU6evxoXzNRJ4oPjeH7e7g
	8VE2BZC8ci8A9gKdkMgU+2pIxDaDKaqm2IWEdXxrVuBcQKB7EhQNxmiRG2zgBdeSUL5NMNvU9ml
	lXVNcvR3E=
X-Google-Smtp-Source: AGHT+IHhP/Ykt4riJ36peq+TtWjjdNFink9cKnKwt6femji3HSO6LbzGmO9C/4+Wld/XRuxBZ6IPgQ==
X-Received: by 2002:a05:6402:2706:b0:5db:e6da:5ed3 with SMTP id 4fb4d7f45d1cf-5dc5eff42bamr23862513a12.21.1738652281375;
        Mon, 03 Feb 2025 22:58:01 -0800 (PST)
Received: from ?IPV6:2a02:3100:b3d9:8600:3060:df41:4ad7:b58a? (dynamic-2a02-3100-b3d9-8600-3060-df41-4ad7-b58a.310.pool.telefonica.de. [2a02:3100:b3d9:8600:3060:df41:4ad7:b58a])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5dc724c9d0asm8901832a12.77.2025.02.03.22.57.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 22:58:00 -0800 (PST)
Message-ID: <830637dd-4016-4a68-92b3-618fcac6589d@gmail.com>
Date: Tue, 4 Feb 2025 07:58:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 net-next] r8169: don't scan PHY addresses > 0
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The PHY address is a dummy, because r8169 PHY access registers
don't support a PHY address. Therefore scan address 0 only.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- Because of the IOCTL interface, don't remove the phyaddr > 0 checks.
---
 drivers/net/ethernet/realtek/r8169_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 5a5eba49c..7306c8e32 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5222,6 +5222,7 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 	new_bus->priv = tp;
 	new_bus->parent = &pdev->dev;
 	new_bus->irq[0] = PHY_MAC_INTERRUPT;
+	new_bus->phy_mask = GENMASK(31, 1);
 	snprintf(new_bus->id, MII_BUS_ID_SIZE, "r8169-%x-%x",
 		 pci_domain_nr(pdev->bus), pci_dev_id(pdev));
 
-- 
2.48.1




