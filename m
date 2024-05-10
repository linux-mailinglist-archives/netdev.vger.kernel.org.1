Return-Path: <netdev+bounces-95602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 888BA8C2C76
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 00:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44CA9284285
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 22:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAC913D295;
	Fri, 10 May 2024 22:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gDDyRqxc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3622513D275
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 22:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715378942; cv=none; b=Pi/pSzVm2RBN3TkQFPgzK/DJI68t/GGP8BLT8351GcvsCSqz79KklGlwn+YLmJa8yG4YafGSShiD2K9UHytIjtr+oOlG9Jbjr+tHuGzuxA9VHt6Fvm4m4dnhw2bSU/Mw+EIerYDbcHK+NHYtR/uelA5RUbhfmB3+0+lZl9pnN9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715378942; c=relaxed/simple;
	bh=hK1AwCcD4OmTuWhTNoyavke80bEp/QmDUm1yjQRGk/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YBi0p2JZ8au9PPp31MQ7khJYHpfEiMapvfjkjURXG0KpcXYqwxO6hMv1u1C3s8QdrOmPkWpC2DAxyNIi+hFFJXn8qd5ilaptyAkPM4OSlup43iHrmys375KLwanQxb2EoN01cx5zoOOP3FnzCQxUxOq+ZtUhLVQQwR2AFqUepLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gDDyRqxc; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51f12ccff5eso3427890e87.1
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 15:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715378939; x=1715983739; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eqHQx/qPXsoWvKvCs+iR2iSoM0kbh7ImNwOPcq13Hhs=;
        b=gDDyRqxc47OybD/9Cd8gfbWnNvFzG/vQ4DUCTVaFlWj4EAmN0THsgCwHCepy4s6LFj
         DiIEOUv7j5ISq/jxmx8HE/3PQfWi+knjpolNXgKBCDv/hQpzGU8H12JiJzphPm9VN1/T
         SbOVIyjGYlYl2egqgrWgUDAfs6WRNmyZpLvBNYl+oIt+xH/jAfShufoTh70MDBmhQd+3
         hC1P2/Lylbt65f5SQ4Xh4ws83KxSsrjT0UE5Djbuvhpo5QjyYR7cpOVchQ2XhHs96N7S
         nIw4mrV0ChnmduJC+K04mnCJ33zMW7e/2T5ct8oxGQXqDVNvHUUded9RSL272lTHJcar
         m0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715378939; x=1715983739;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eqHQx/qPXsoWvKvCs+iR2iSoM0kbh7ImNwOPcq13Hhs=;
        b=U4yjoDI4rnirJeFHctHyxN9OMvEBJ3MWznyIsxgpA65HYCcDud1MuwSmgIgkPXevZf
         70phC5BYL94CuIwOMwt1nqlQ2J1lQHNhnt5BVzf0fMe6QsdcvJkFce3qhsJRN3dNTN1i
         ZtvDhLrepk4mx7FuEA5dIEAmdE2xn69egRxtBwtYkVtfSomQ+vCzS1tR+60ugv2gJC6O
         8Oa0ZAtickpOxKFCM6kJXgFktYjud5t0gNLY9BUgA3jAG2HjCsGR+dycjJpNnQ5Xo5xV
         o0fPJu2TykEE+lh8s6fL1ErFvgazeWFfc0u/7y0vp6zsQAk3wSAUFps1FkWzFFzeqd20
         xmkQ==
X-Gm-Message-State: AOJu0Yx/XXTkVBP82LazfDG8Dywjj/nF2bCnW3ihttrrQsoevp1FvQa5
	C0u3yGdBy+/6bYfdPYRR/loWAjyqYkgE6R2Tx6Q0goCj/HcUNDC7rf2kVhIbtWY=
X-Google-Smtp-Source: AGHT+IG9etHAzRkra2Pva4AqH5dC9t3zCo3LQlQjK11jutNSxDdpm+VlkAopy+jbZCKqeOE6gCyhAA==
X-Received: by 2002:ac2:4c2f:0:b0:518:96b5:f2c5 with SMTP id 2adb3069b0e04-5221057923bmr2490205e87.46.1715378939428;
        Fri, 10 May 2024 15:08:59 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781ce3fsm228219866b.4.2024.05.10.15.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 15:08:59 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 11 May 2024 00:08:43 +0200
Subject: [PATCH net-next v2 5/5] net: ethernet: cortina: Implement
 .set_pauseparam()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240511-gemini-ethernet-fix-tso-v2-5-2ed841574624@linaro.org>
References: <20240511-gemini-ethernet-fix-tso-v2-0-2ed841574624@linaro.org>
In-Reply-To: <20240511-gemini-ethernet-fix-tso-v2-0-2ed841574624@linaro.org>
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
 drivers/net/ethernet/cortina/gemini.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index d3134db032a2..137242a4977c 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -2145,6 +2145,17 @@ static void gmac_get_pauseparam(struct net_device *netdev,
 	pparam->autoneg = true;
 }
 
+static int gmac_set_pauseparam(struct net_device *netdev,
+			       struct ethtool_pauseparam *pparam)
+{
+	struct phy_device *phydev = netdev->phydev;
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
@@ -2265,6 +2276,7 @@ static const struct ethtool_ops gmac_351x_ethtool_ops = {
 	.set_link_ksettings = gmac_set_ksettings,
 	.nway_reset	= gmac_nway_reset,
 	.get_pauseparam	= gmac_get_pauseparam,
+	.set_pauseparam = gmac_set_pauseparam,
 	.get_ringparam	= gmac_get_ringparam,
 	.set_ringparam	= gmac_set_ringparam,
 	.get_coalesce	= gmac_get_coalesce,

-- 
2.45.0


