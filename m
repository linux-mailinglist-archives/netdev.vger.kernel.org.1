Return-Path: <netdev+bounces-177338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE13A6FA9C
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 13:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C5203BB70A
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 11:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A27FE2580EA;
	Tue, 25 Mar 2025 11:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="fRl1iL5N"
X-Original-To: netdev@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF49257AD1;
	Tue, 25 Mar 2025 11:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903904; cv=none; b=Ecp2xlovYEIjeHbEqEOmUNQ+wXH64oGQg+oo5pYJH7KWW/CMRxf4D8dem/ASNebby7j7BV5kfgzG3RGnlwieKL+UvWxM2cZ8Z29nh40CliyuVASTovOyr0Xna67isdweRlM7uAYA83MU9TPU/lwhuIg8owOhvaxsud7C4iVf2+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903904; c=relaxed/simple;
	bh=khwhZj8H6C2NigmD2ejd2c8c+PTB4Fwok9JsLq0WomA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eDtVKWDXuWm6gwPay+wChOBflyz0dk1uBq9xTDwHNQOrUxh/INnxWN38WLwFFiysnegz0FxzS2m0CR9zzzLVC49ZrszPV0e1d6zGerwFwJ+3cdvzSvIHcqzxLWKIDE8BuB77eXX+FkaiRIqgWz+Ml9Sno4jxW9Eh2ZfatEIM4Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=fRl1iL5N; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6918C102EB802;
	Tue, 25 Mar 2025 12:58:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1742903900; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=NgHm99vQLnC3l+PaIOvp8HpQsfYyteeTPS/neTnwgPg=;
	b=fRl1iL5N86NB0V3k2iW8G3UZ0S70ZOKBdrgIhZIK81UK0B8ygdiReNfwNgvWZ08lZvsi0/
	NQkY6TKhqjdHMw6tZPjGNJxcSmvE2aJsSic4cQVFyoAHysvOw4gKgTwZgAVRJ4AJTMoVWW
	s3xcTURf2ntfgNlAMZ4VvlCRlZ++g7hDJYAI17OBzXYjXw5padR0lgU4RCK0q10s5Y+Hp+
	Tv8wtmj3BNPotlVVj6Qu8AmPcS8oLScHleTqAr1fBCcz0eLwK/N0DjSACMCrf6xFCphZVQ
	IO+RNdr4fj2y6L82njSgGOqHORV0rUxcV5Rv/cM2jT1PvjG+4wocNu03YL5dCw==
From: Lukasz Majewski <lukma@denx.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	davem@davemloft.net,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 3/5] arm: dts: Adjust the 'reg' range for imx287 L2 switch description
Date: Tue, 25 Mar 2025 12:57:34 +0100
Message-Id: <20250325115736.1732721-4-lukma@denx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325115736.1732721-1-lukma@denx.de>
References: <20250325115736.1732721-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The current range of 'reg' property is too small to allow full control
of the L2 switch on imx287.

As this IP block also uses ENET-MAC blocks for its operation, the address
range for it must be included as well.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
 arch/arm/boot/dts/nxp/mxs/imx28.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/mxs/imx28.dtsi b/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
index bbea8b77386f..8f2aa32208cf 100644
--- a/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
+++ b/arch/arm/boot/dts/nxp/mxs/imx28.dtsi
@@ -1321,8 +1321,8 @@ mac1: ethernet@800f4000 {
 			status = "disabled";
 		};
 
-		eth_switch: switch@800f8000 {
-			reg = <0x800f8000 0x8000>;
+		eth_switch: switch@800f0000 {
+			reg = <0x800f0000 0x20000>;
 			status = "disabled";
 		};
 	};
-- 
2.39.5


