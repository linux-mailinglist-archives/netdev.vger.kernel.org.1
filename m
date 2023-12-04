Return-Path: <netdev+bounces-53435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D82802F9B
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 11:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010561F211CC
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 10:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B585B1EB4D;
	Mon,  4 Dec 2023 10:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="ArBkAWX5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF2DCC
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 02:08:25 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50bfa5a6cffso652247e87.0
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 02:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1701684504; x=1702289304; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nx9WOIwGojr3XHm97vyDaAcWYuGy4RnKZZSPft3u0+s=;
        b=ArBkAWX5oBdSuteY7cHqObSEF3vnSDapsWTJ7dHHaEwng5Bh8Jer+QUvOKFTx5Chtv
         XKb2s5WQojbpUHs+xgxeJxqQ5ZROLip7d/LZ0wwsc04alv/cZhL2XyA0Fr02czkkJpyd
         i8LdCV6U73A+awIe4GWJXI+vZhi0XS1UK6QJLwIxGp6Bktc9/0l5EtQOryLr0VCQ+3MH
         KkCAmokDuf8jRd5hG7mgm6/iYXzbIoSxhuox7HI0CQGr8yIKIwpjfvvjFJBsmFc11NAJ
         EYCqCtQJaHFO5HFDnXuVnQpZyQdH0C+m0nmnA7dJYLinOs8aAj3wh3KunQyibAwlmIpQ
         VLrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701684504; x=1702289304;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nx9WOIwGojr3XHm97vyDaAcWYuGy4RnKZZSPft3u0+s=;
        b=B/e6sNceXOC7Qhz7bk50K4uaXPemdJ9hCRiJFEcHP07Kv/5aWgATd9c/5Ym/iIXIeo
         X9e21/npiz1WqCR3q81CJdfpbJfiPTMh9CUeoeHixjIWJr7t1Y5dtnpDegE+T+RY/E50
         dJ9Erj3mPmDZQIfp8/2/5M6FasNLgKCfpiX7X7n+iRyFZVD6URXOc1kGiyFdQLMrBtgD
         9Pmp8ZAym56tUbYsj0U3P0kPGlJV9n7DIcK3iEKLwjaNI2NbzZCQmBMPorDECjElgbw9
         N5F02Czh98A7sKY2u5b8oj0eSHrFJz6zDcM0IIvfQ6sI0sWyibndR7o33ttA7bpnDeZ5
         szTg==
X-Gm-Message-State: AOJu0YyTJ5WQ1MczUMh8CC5bxlunV3aLJcWvDyJzU8yFZ3a62mDxl9uu
	K3HSWxnM0/DCwWq7LClw9f6pqA==
X-Google-Smtp-Source: AGHT+IEMnfPrYtWP0ptniVE06oR9DmKFVJAKnlPlvkCRslcOQFmNHCNA0+lv3WcYKBsQcuKMc7mx+Q==
X-Received: by 2002:ac2:4424:0:b0:50b:f509:a2e1 with SMTP id w4-20020ac24424000000b0050bf509a2e1mr607452lfl.0.1701684503845;
        Mon, 04 Dec 2023 02:08:23 -0800 (PST)
Received: from wkz-x13.addiva.ad (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id u29-20020a19791d000000b0050beead375bsm553643lfc.57.2023.12.04.02.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 02:08:22 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 net-next 1/3] arm64: dts: marvell: cp11x: Provide clock names for MDIO controllers
Date: Mon,  4 Dec 2023 11:08:09 +0100
Message-Id: <20231204100811.2708884-2-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204100811.2708884-1-tobias@waldekranz.com>
References: <20231204100811.2708884-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

This will let the driver figure out the rate of the core clk, such
that custom MDC frequencies can be supported.

Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
---
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
index 4ec1aae0a3a9..f268017498a9 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
@@ -180,6 +180,8 @@ CP11X_LABEL(mdio): mdio@12a200 {
 			reg = <0x12a200 0x10>;
 			clocks = <&CP11X_LABEL(clk) 1 9>, <&CP11X_LABEL(clk) 1 5>,
 				 <&CP11X_LABEL(clk) 1 6>, <&CP11X_LABEL(clk) 1 18>;
+			clock-names = "gop_clk", "mg_clk",
+				      "mg_core_clk", "axi_clk";
 			status = "disabled";
 		};
 
@@ -190,6 +192,8 @@ CP11X_LABEL(xmdio): mdio@12a600 {
 			reg = <0x12a600 0x10>;
 			clocks = <&CP11X_LABEL(clk) 1 5>,
 				 <&CP11X_LABEL(clk) 1 6>, <&CP11X_LABEL(clk) 1 18>;
+			clock-names = "mg_clk",
+				      "mg_core_clk", "axi_clk";
 			status = "disabled";
 		};
 
-- 
2.34.1


