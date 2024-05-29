Return-Path: <netdev+bounces-99046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 844FE8D3889
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 16:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 105701F24219
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 14:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C59E1D54F;
	Wed, 29 May 2024 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pSfkrGDm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F521C2AF
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716991208; cv=none; b=V2U14ryTgxBsElcO9LezCZGcM2v9QwMot8jQn/ZwKitBT0SN/XsLYJKTwfZhd8bNG38I/ibhoBomUnk1nYfeDV2qvClVHzJiK9QY2unmiRI49We7x4E6AOY+iRppDpkBwrWj/VRz6tiT27HFOJnSE5sIZxYaTx5A9i5HAxn3seQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716991208; c=relaxed/simple;
	bh=TJPbq5B5PYjU4jcKUJT1hZOXh+OR/yO3wdqOI3U1t/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z7FL6TfMh2rACb2p6p2/nj1skGC4ggqWoNZ3bx2JzlyPmcHJl3+uf2IcPqF/rBjuoGUZFVOJTYwb3S2et8CHnoT+TLqZRBdtkMPNAjGY0I15X0zhAM1wuzcEsUOi3Dx5tmuhi5eG7epqKTS9UV/7nSoXupxawudIrS+AKIbV7wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pSfkrGDm; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e974857588so21995601fa.3
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 07:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716991204; x=1717596004; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BnVXJx+XKagAI+2d0mf3dDbP/l7i5ROp1lXxEdfr9iU=;
        b=pSfkrGDmQN+wLD8XV6rTahFNzcL227gBbi1oICe6Zgriq6GzoH1etEScz0Tle5/2gZ
         IQsaOmKuqOBmmbtKd20u7pDWtAe+KupxWtk/Vc0ABCyhe0AfaKBxsBzwajjmNwsYjXW/
         3yyHl8NMzU61OTsPWTFwXg2JYicrOu+Xj1G8Ae4D0L3azLRE3QEJFZWlJB2EFfKwBumJ
         10XKC7TwgM1a02xbAasVD6Tr6qCQF9QS06iAoEoZmt0eiD7fPQkst+f1pr5o1CANsO0a
         mEDiMZvDM8vU8vgUmUq5SI3GngVAQ2lAR38PuKn1uW1D0JE/19+qa8wjRBpqs2iV7hWZ
         l1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716991204; x=1717596004;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnVXJx+XKagAI+2d0mf3dDbP/l7i5ROp1lXxEdfr9iU=;
        b=v4MxFVq0o7FRfr1A1bjOKKU5NAPMMGIzxP7ASEk3/QQCoxve3TyZ8RpYMkPZNKaETy
         LfPOBHY23M/KYqMZpVgvDAtdN3KwzTW7N9vSzSjisLOCGaqPjAZQ5TT3iOv8Dp1UhUZ0
         db3dyyabPH9sswaBKe/RkBASqd8HG0Wm8z3iA9+yO1L1qUrSjnOzP1rEQ/sPQI5fJJVX
         fwDStWCoG6KWvnknQSRf0f4hT1cyluXcP2d08ifIsOquLGnHR6cnsNY4nCEY1tHRTDXs
         uVKSFyukveWlZsro7fc/4uAY8bwsLzswc5QJEsj4Ab7YeKnZRWEC8mDx4ZqgprYeTBWv
         LZhQ==
X-Gm-Message-State: AOJu0YzfCge32FkAxn26/2S95CVPMwNFTfPtEDq6jp8QtzOH7tLYsllB
	56JIzzHu4KERMWF9yl9jFXw8XXJ6tZWOVo5GbAcgDrtVD0t7jkcI+KE4Qew4tr0=
X-Google-Smtp-Source: AGHT+IFd/62Te6X6COZOHKjKdhsA9gM4v7qxHasEOJNOk6Yk7jejeBI8TPABcwrxhuo9A3Uu1JBV6w==
X-Received: by 2002:a2e:a170:0:b0:2ea:2b91:4f6c with SMTP id 38308e7fff4ca-2ea2b915150mr13454481fa.4.1716991204649;
        Wed, 29 May 2024 07:00:04 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bcc47bfsm25472551fa.20.2024.05.29.07.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 07:00:03 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 29 May 2024 16:00:02 +0200
Subject: [PATCH net-next v4 3/3] net: ethernet: cortina: Implement
 .set_pauseparam()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-gemini-phylib-fixes-v4-3-16487ca4c2fe@linaro.org>
References: <20240529-gemini-phylib-fixes-v4-0-16487ca4c2fe@linaro.org>
In-Reply-To: <20240529-gemini-phylib-fixes-v4-0-16487ca4c2fe@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.13.0

The Cortina Gemini ethernet can very well set up TX or RX
pausing, so add this functionality to the driver in a
.set_pauseparam() callback. Essentially just call down to
phylib and let phylib deal with this, .adjust_link()
will respect the setting from phylib.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index b33f9798471e..318c521b135b 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -2111,6 +2111,19 @@ static void gmac_get_pauseparam(struct net_device *netdev,
 	pparam->autoneg = true;
 }
 
+static int gmac_set_pauseparam(struct net_device *netdev,
+			       struct ethtool_pauseparam *pparam)
+{
+	struct phy_device *phydev = netdev->phydev;
+
+	if (!pparam->autoneg)
+		return -EOPNOTSUPP;
+
+	phy_set_asym_pause(phydev, pparam->rx_pause, pparam->tx_pause);
+
+	return 0;
+}
+
 static void gmac_get_ringparam(struct net_device *netdev,
 			       struct ethtool_ringparam *rp,
 			       struct kernel_ethtool_ringparam *kernel_rp,
@@ -2231,6 +2244,7 @@ static const struct ethtool_ops gmac_351x_ethtool_ops = {
 	.set_link_ksettings = gmac_set_ksettings,
 	.nway_reset	= gmac_nway_reset,
 	.get_pauseparam	= gmac_get_pauseparam,
+	.set_pauseparam = gmac_set_pauseparam,
 	.get_ringparam	= gmac_get_ringparam,
 	.set_ringparam	= gmac_set_ringparam,
 	.get_coalesce	= gmac_get_coalesce,

-- 
2.45.1


