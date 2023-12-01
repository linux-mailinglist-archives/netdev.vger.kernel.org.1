Return-Path: <netdev+bounces-53013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC2D8011CA
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 881A2B20EE4
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 17:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B8F4E60D;
	Fri,  1 Dec 2023 17:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="Qfnfntxa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72644D40
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 09:36:10 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c9c82a976bso30240941fa.3
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 09:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1701452168; x=1702056968; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Nx9WOIwGojr3XHm97vyDaAcWYuGy4RnKZZSPft3u0+s=;
        b=Qfnfntxab/ga5GPX2MCaKsARsFrVOV9VG+T9fwSJAW7NpI/6y8YmsJOa6KbrKCpC7k
         kCyuilOQcG0Fm6hsV3LXHoduv8QhlG6bhB1xamyRvEdem9B1P4Ru4NmZs55hyFduhlfk
         8jxY2jvw+Y2q3+ExEYnEx7CZnLfUwSkF/svu8cKQ7Yjg++/7F0blffYw1JJXNa5pDqwW
         GtwgkY9G5K0qaK/CBqOyTroLxT0AFKOwmudSevdP0hLzZZzvnHmKKvp2SvGwZoeUfQbb
         wkkHhuwUqnkt/3xdP73eLQB6t618pvKOfzItxpuXlvBHh7EZrXp6DW8aWt214SD1lFZF
         rqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701452168; x=1702056968;
        h=content-transfer-encoding:organization:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nx9WOIwGojr3XHm97vyDaAcWYuGy4RnKZZSPft3u0+s=;
        b=EprOItWqWrYb/i3/IKmWj8rUZTMOMMFF5Gkvh7rrjUE1VNSZK2djHSUyPmUStDmccU
         hglXe6cxX+Fs0wyj13nA2/OMh0VTl0/M+qIX6UtsLHoyhXnSA6xkXWmU2/y3nyw1vlCZ
         +DxTeTpSlRgYKL42pOmL/lGesFO498L1DJFhymim41eoiZt2ZijFI/w17h5DlzfFVrm3
         GYc0l3KRLIFIn5Oo25D2SxJBOGdcYKdHrlP5p+nV3F+m7xwec8oxOk1YaQbuIjhWTlFx
         Uu5m9b2SCq238zxNXJ1xQ1x5Mtc2XglMRkUYU75bWCzgssIZQsRGv+NmMWSJBhLrKn+x
         greA==
X-Gm-Message-State: AOJu0Yw0jGc8LfZmzX9Aq9u7BySaiBaLmB2dbcc1CBlEUhQxoGOmjZNE
	I06AQshfjnxBM5ksH+iwRJKnKg==
X-Google-Smtp-Source: AGHT+IFinpOyTubfZclV9z5rQA4LeOo8mpjRd6hue0YchpTznWYq1vNOthrjg3UPav/x34o9bUoWpg==
X-Received: by 2002:a2e:a202:0:b0:2c9:d874:20dd with SMTP id h2-20020a2ea202000000b002c9d87420ddmr1199216ljm.103.1701452168551;
        Fri, 01 Dec 2023 09:36:08 -0800 (PST)
Received: from wkz-x13.addiva.ad (h-176-10-137-178.NA.cust.bahnhof.se. [176.10.137.178])
        by smtp.gmail.com with ESMTPSA id y9-20020a2eb009000000b002c120b99f8csm470327ljk.134.2023.12.01.09.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 09:36:07 -0800 (PST)
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
Subject: [PATCH net-next 1/3] arm64: dts: marvell: cp11x: Provide clock names for MDIO controllers
Date: Fri,  1 Dec 2023 18:35:43 +0100
Message-Id: <20231201173545.1215940-2-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201173545.1215940-1-tobias@waldekranz.com>
References: <20231201173545.1215940-1-tobias@waldekranz.com>
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


