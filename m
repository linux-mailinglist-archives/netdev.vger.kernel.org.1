Return-Path: <netdev+bounces-191131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA40EABA258
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 20:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1BC41BC84FF
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 18:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C0327990E;
	Fri, 16 May 2025 18:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="oJwnIq5j"
X-Original-To: netdev@vger.kernel.org
Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87FC26D4E8;
	Fri, 16 May 2025 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747418527; cv=none; b=WOLV1oqlBrrRvv9hhFADmtgw5k9uLlv+htr1pt4Zztapu1duUj01+wKZmUGD2WIuSVHlZ8yfO5DgtZEOv5MQpKuTsxsW0OKaWRqtQ0VpeRaVHdw54j08Zd+8KIEvqYTQx9Koknkg6AY0gbXWeQRmN/1esThlXMGTyXkOyM1dhAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747418527; c=relaxed/simple;
	bh=mWdG/PFdxPaC45mDzD8ma9Dem8YK1Y7OW36uBZGdz+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XXJyPMckmnjday3a5Ncu1bufRsSZVkcYZSzSl4sfdFgZqH35EZNTdsAkc9NwDur+CgjwjqOuUbTjvFgkY5i4Yl41jvtgmbgpMaFYD0gk9yUEHNdS50sJzV0mMZuL5CyL1p8f2URdy/QpsNP+l/NfBMEny0WxowCbdNBY19yIXMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=oJwnIq5j; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout1.routing.net (Postfix) with ESMTP id 1C40840504;
	Fri, 16 May 2025 18:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1747418517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F2n2o30Q/kVq/KYG6vVQ5aU24ZZC3guR83pv90r8Jms=;
	b=oJwnIq5jNUeLmQxVWrKPXhVsAyly2zJgpt4ZdJged5/coNw1NBVVKaMARgKMGRZuRpo6z6
	dvFM+whBi0n3GdIRcnVXoVn2tj4IRUE9vU1kMougYxGMFcO6muTH6+CxtUJt3uxglVTtsL
	QElvXrSxNtQjZQY/U3oGcLhK7gaD8aA=
Received: from frank-u24.. (fttx-pool-157.180.226.139.bambit.de [157.180.226.139])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id C82BC1226D6;
	Fri, 16 May 2025 18:01:56 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 05/14] arm64: dts: mediatek: mt7988: move uart0 and spi1 pins to soc dtsi
Date: Fri, 16 May 2025 20:01:36 +0200
Message-ID: <20250516180147.10416-7-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250516180147.10416-1-linux@fw-web.de>
References: <20250516180147.10416-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

In order to use uart0 or spi1 there is only 1 possible pin definition
so move them to soc dtsi to reuse them in other boards and avoiding
conflict if defined twice.

Suggested-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi  | 14 --------------
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi      | 18 ++++++++++++++++++
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
index 37e541a98ee1..23b267cd47ac 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi
@@ -328,13 +328,6 @@ mux {
 		};
 	};
 
-	uart0_pins: uart0-pins {
-		mux {
-			function = "uart";
-			groups =  "uart0";
-		};
-	};
-
 	snfi_pins: snfi-pins {
 		mux {
 			function = "flash";
@@ -356,13 +349,6 @@ mux {
 		};
 	};
 
-	spi1_pins: spi1-pins {
-		mux {
-			function = "spi";
-			groups = "spi1";
-		};
-	};
-
 	spi2_pins: spi2-pins {
 		mux {
 			function = "spi";
diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index 8c31935f4ab0..ab6fc09940b8 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -209,6 +209,20 @@ mux {
 						 "pcie_wake_n3_0";
 				};
 			};
+
+			spi1_pins: spi1-pins {
+				mux {
+					function = "spi";
+					groups = "spi1";
+				};
+			};
+
+			uart0_pins: uart0-pins {
+				mux {
+					function = "uart";
+					groups =  "uart0";
+				};
+			};
 		};
 
 		pwm: pwm@10048000 {
@@ -244,6 +258,8 @@ serial0: serial@11000000 {
 			clocks = <&topckgen CLK_TOP_UART_SEL>,
 				 <&infracfg CLK_INFRA_52M_UART0_CK>;
 			clock-names = "baud", "bus";
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_pins>;
 			status = "disabled";
 		};
 
@@ -338,6 +354,8 @@ spi1: spi@11008000 {
 				      "hclk";
 			#address-cells = <1>;
 			#size-cells = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi1_pins>;
 			status = "disabled";
 		};
 
-- 
2.43.0


