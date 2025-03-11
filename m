Return-Path: <netdev+bounces-173765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3901AA5B95A
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 07:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC3601893B94
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 06:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C3321660F;
	Tue, 11 Mar 2025 06:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8nMuOJQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B160211C
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 06:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741675392; cv=none; b=L5aB4dqgLAHCax4hihJKQzo+3omn1pF2YjMCW/PSEdSTPF7WmWv3rJE7pGNqbGzts/1AR7nLJiVzguxcdKMg/Y+rB3gWogi6Q76cgClaZv/VMU2hlcQG7p8riTWZSXnvo1eBBs4SXqJu8dARzx/L6qBtR3JOKEh7Oz+7eby66mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741675392; c=relaxed/simple;
	bh=qsPz8qDndX2xCkq67cRAdLzeNcgzpYgT/fMbckVcl4I=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=N98E/jZaps1SQZwM2Ch8afF32flzglTt97uwNOUMRNg60Ih87rUEJsqkT3Be+7cOK19N6IZ9zU7TdziZW7QcLJwie0lehi7gdGO4JCsplrGGTm/e0TzNIoWRxz26QtErLP8yBsN8v762Ck+srxRk0ddStvluIoitGjvNyZqcDlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8nMuOJQ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac2bdea5a38so62678566b.0
        for <netdev@vger.kernel.org>; Mon, 10 Mar 2025 23:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741675388; x=1742280188; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=so/UCiVQWLNTR/kKkxpSo6Fq04PW2btLzfCk3bjqBkc=;
        b=V8nMuOJQv5gYj/jFZ7CTmGMzL+6XUNAFsantfFnA0klIL/71BAoMbS11AVxvsF9809
         cSSUkTmAv3tLbOZu+ocEhUeqXMYgMHNW5zst7D2CnTkbwtcZlOJ49dDi/TSVKYRGdhP2
         gtBtdb52CpufiXantR1jBySYfZIOJrwmgoPi6Ncz5BbRI2Bp4EhkI+ZpI4lUDjfkRb9q
         zXNBTepTNDGrsXwta31bPrg+RwGBG1SLihdXVh4Bo4Keqt71dSj1ZiTfbUkoimCqfxYo
         d6klMbGJ4VN1i9nKnZpjLe0BceC0mSawb8YR5s2mH3vqpQFU6T1YV2x1vgdT2KvM0cbt
         mIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741675388; x=1742280188;
        h=content-transfer-encoding:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=so/UCiVQWLNTR/kKkxpSo6Fq04PW2btLzfCk3bjqBkc=;
        b=AgDOYjZ6eqJ25mpn0SY6H6kY5Xge4WOpmi+i1IVJmcgTaLdEUnXSMuUrD989DB5UL3
         5TjVOaebt3Qie9T21LIXAhuLaMBNFjTvKBcVD6VYiqUnL3zfLICOwlvMdAe2TmeZ1YmO
         lL51SVjaEZwS67L77tf0rOtg5R/SKAZS4N+nd7GrhNFuzU3NF38ZnL9ZlH/0E9LUdFTZ
         trX1vzPR6S1WlN+OywDyLuGd5r/Liq5mTmvLXF2LP0ZrHRaWsu63E+7asNhHaJ400/oe
         JKEEmfpQnzi3nLVDUIKZVcUsc6OXBVDdzx3CglZbNzy8MxL7a3IFdiVFAB9y0cMv/pMC
         yDjw==
X-Gm-Message-State: AOJu0YwnH7pb7eQv8Ei3g9R87sg7WS8ON8oHC+z27UqV9/R+O3lPJOKZ
	+s69lsJskRHUDspJOTBk3qNkZQi6/5lG2AIcbQXtCVDrXH3FR9/i
X-Gm-Gg: ASbGncvVdcgM/RO3U9VIRNy6bcggVMtoioaohURRfyE7zn0S6N3NYu2Nkr3r+g58W2o
	KTsGOk9hU9Ichgvxlj9YnTL5hlajXBnoa03Nf+bb4tdTN6Y4P1dBGkBcvqusBSP73rzT7whdLuo
	22fIiVPchzbkduOqzvaJ+80UOztUdd4jvVZlOBoNAFK4hU4L+6aIZOnWEmxQWKAVS/jX5YY24SV
	pYi6n4SOcZ1gs22pfDi7zYHThiscVi9hi2Nb+OqFd2MitSEPrj6/5uxTMET9dIN2WwOOIcC458C
	e+XO2tz8fQpID1f4qsUvEcynW8yrDQjQVPvnE6qzB/WPMA0xwjA0vfmJd5D9NEcwl35WN6j14C4
	GhXyfL9q3YK4sfYULcTItyPIkYror1egUj6VSjRyigzhpOB5w2lahsa1ml5lhiuWKf/T5398Dvx
	/5aSxjThQbGKRW+gOSCEJ2pCHCEp8w10jIVydO
X-Google-Smtp-Source: AGHT+IHiv34jJbRhdyalbamIH+bSGq7meuAQ2I5vDWm2BJ5mfsBCwKuUrh0jaIhOGeqQN8x4K9oG9g==
X-Received: by 2002:a17:907:94cb:b0:abf:40a2:40c8 with SMTP id a640c23a62f3a-ac252ae1b6emr1691801366b.28.1741675387404;
        Mon, 10 Mar 2025 23:43:07 -0700 (PDT)
Received: from ?IPV6:2a02:3100:ad09:4d00:f159:4498:19a5:6163? (dynamic-2a02-3100-ad09-4d00-f159-4498-19a5-6163.310.pool.telefonica.de. [2a02:3100:ad09:4d00:f159:4498:19a5:6163])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ac2523d940csm751821066b.178.2025.03.10.23.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 23:43:06 -0700 (PDT)
Message-ID: <e463bc66-c684-4847-b865-1f59dbadee7e@gmail.com>
Date: Tue, 11 Mar 2025 07:43:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Doug Berger <opendmb@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: bcmgenet: use genphy_c45_eee_is_active
 directly, instead of phy_init_eee
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Use genphy_c45_eee_is_active directly instead of phy_init_eee,
this prepares for removing phy_init_eee. With the second
argument being Null, phy_init_eee doesn't initialize anything.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 3 ++-
 drivers/net/ethernet/broadcom/genet/bcmmii.c   | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 3e93f9574..c953559e3 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1350,7 +1350,8 @@ static int bcmgenet_set_eee(struct net_device *dev, struct ethtool_keee *e)
 	if (!p->eee_enabled) {
 		bcmgenet_eee_enable_set(dev, false, false);
 	} else {
-		active = phy_init_eee(dev->phydev, false) >= 0;
+		active = dev->phydev->drv &&
+			 genphy_c45_eee_is_active(dev->phydev, NULL) > 0;
 		bcmgenet_umac_writel(priv, e->tx_lpi_timer, UMAC_EEE_LPI_TIMER);
 		bcmgenet_eee_enable_set(dev, active, e->tx_lpi_enabled);
 	}
diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index c4a3698ce..5aa8e16fe 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -91,7 +91,7 @@ static void bcmgenet_mac_config(struct net_device *dev)
 	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
 	spin_unlock_bh(&priv->reg_lock);
 
-	active = phy_init_eee(phydev, 0) >= 0;
+	active = phydev->drv && genphy_c45_eee_is_active(phydev, NULL) > 0;
 	bcmgenet_eee_enable_set(dev,
 				priv->eee.eee_enabled && active,
 				priv->eee.tx_lpi_enabled);
-- 
2.48.1


