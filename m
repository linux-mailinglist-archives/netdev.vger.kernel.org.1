Return-Path: <netdev+bounces-96058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A38D8C4218
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 15:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFE34B21D5F
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 13:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19921534F4;
	Mon, 13 May 2024 13:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mAYe55J9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35860153589
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607539; cv=none; b=lfqjxcC6Lkc+q9I/jr3f9Q56cFuIk1wIUxWnwJCvs3Zb3trV5IY9tlkn1TycGN39+2A5au6sG0f9r/gDaZVRWeGDuKgnXxG1fI4t8PmLC/nHCpWN/TF6z6Op3kQHlnoLJ5BrC3zw2nFQNO0HMrKrt+IEAmYLvjAVws4+jQIUjJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607539; c=relaxed/simple;
	bh=yad+NLnqJB+NY8pvEqjV83a82H+Ad681cswEqKRuHTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tts6iM+GDhq71yd8rgonxSdvTeibw/e+8UpHRWpKfF4/CxTzXWP1rXH/okyADiV4bmKqVIzi6HaoNS4jDFZp5jSQWcz8WQpMYrKnO3ox1KupkzI1Z83Emh8n9R+NGpadqs73WpbEl//wwsZv+B5NNMi7L0BnL4UOfgEO7UOcdx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mAYe55J9; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5231efd80f2so1447316e87.2
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 06:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715607536; x=1716212336; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IShrT5yQuOJLnp4MkXLB9zv8Aha2AZyV2GCpbrkWOnw=;
        b=mAYe55J94J4L7FDXmKGI5jvxm5mj799f+aJjZD+no+Wk3VuWWtXnivH8/LM1BB3XUu
         liQe3DqvNaK0bQqYQhAWO14mhxiJfEHPWRYsEiqGbPXW0BFYK8NU+p1WzOQtNZCpFEXR
         JBEXBQ5IUC7Sp/oyDGn8uGhHrctT3SA4QloZBySH4Wq0xXwnrIudgchZVP0aWo3Mdrzf
         2q2S5o+x5wLlt0jshILCBMrBSypUxwsIsq1x3X6OnGKkJgX1gLLyfprSWJHAV4TEPdpc
         zD7l1Ra/Zq6XTmW4mfitN1QszqrYxUmkdXORrMycUBQfabRPFxuesVllttELxdwho3Cc
         DqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715607536; x=1716212336;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IShrT5yQuOJLnp4MkXLB9zv8Aha2AZyV2GCpbrkWOnw=;
        b=nFTHvuXebyAhk7J72DbO1V/GO4J3uDgEl98adMFG+vBZ3pjU/emaGQpNvUmxdx5WK7
         dbLQqQ7nHbHxX8OdUab4h3cm0u3zewC4EnEYhjaf9Bo8feYSB3JkAtz9Ex47ctys4zBe
         o223/LdDyjZjgZvO9Fsa/rJg+r9t/9VFt7tAQ+86KEoYf7/eHyRXm6F6Mth47rAecX9c
         J/5pwO0pJ0GDUajZo73X0ldkGio6p7H1kyDfEepaueYZoQZIx18wa2axYrCZPZOLN6Ti
         wMBtaWjhMYPmlfIlBBAJe4TwNkyd1Oten6YC4CkKXDveY89AoGwizIVE3b/21UfuIUiI
         7QTw==
X-Gm-Message-State: AOJu0Yxim3rN/iupP6+lbOTZilhiDgR2Y970scoaqet+0++AdhDMnV84
	szoToRkk7gMsql2APQrnWUCJbyv0wbNQrrCS4Fo0gS/b9YZH7+q8wmX4sNUKh84=
X-Google-Smtp-Source: AGHT+IF5xgTTq9xugX6r8tG04ZnLx54oDx2UmKKNOSO0ztAV12QN4fEcS26CWvU+cTLRTH9DwdT2lw==
X-Received: by 2002:a19:f807:0:b0:51b:398f:ce40 with SMTP id 2adb3069b0e04-5220fb774demr5517448e87.10.1715607536280;
        Mon, 13 May 2024 06:38:56 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d899asm1757367e87.231.2024.05.13.06.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 06:38:55 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 May 2024 15:38:52 +0200
Subject: [PATCH net-next v3 5/5] net: ethernet: cortina: Implement
 .set_pauseparam()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240513-gemini-ethernet-fix-tso-v3-5-b442540cc140@linaro.org>
References: <20240513-gemini-ethernet-fix-tso-v3-0-b442540cc140@linaro.org>
In-Reply-To: <20240513-gemini-ethernet-fix-tso-v3-0-b442540cc140@linaro.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.13.0

The Cortina Gemini ethernet can very well set up TX or RX
pausing, so add this functionality to the driver in a
.set_pauseparam() callback.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 85a9777083ba..4ae25a064407 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -2146,6 +2146,20 @@ static void gmac_get_pauseparam(struct net_device *netdev,
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
+	gmac_set_flow_control(netdev, pparam->tx_pause, pparam->rx_pause);
+	phy_set_asym_pause(phydev, pparam->rx_pause, pparam->tx_pause);
+
+	return 0;
+}
+
 static void gmac_get_ringparam(struct net_device *netdev,
 			       struct ethtool_ringparam *rp,
 			       struct kernel_ethtool_ringparam *kernel_rp,
@@ -2266,6 +2280,7 @@ static const struct ethtool_ops gmac_351x_ethtool_ops = {
 	.set_link_ksettings = gmac_set_ksettings,
 	.nway_reset	= gmac_nway_reset,
 	.get_pauseparam	= gmac_get_pauseparam,
+	.set_pauseparam = gmac_set_pauseparam,
 	.get_ringparam	= gmac_get_ringparam,
 	.set_ringparam	= gmac_set_ringparam,
 	.get_coalesce	= gmac_get_coalesce,

-- 
2.45.0


