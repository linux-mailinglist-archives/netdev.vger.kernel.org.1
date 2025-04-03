Return-Path: <netdev+bounces-179107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA40A7A965
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 20:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8643C18853D3
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 18:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59E3253358;
	Thu,  3 Apr 2025 18:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N8pW6y6H"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A408250BF5
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 18:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743705035; cv=none; b=e5Pv3XYwqYCumgPEkA/CTbFW9Iiomm+Klqf0omDnbEXqalGQW2rTozCGkst3eWX+7IY1hwFTl0t0aopJGXBGwJKWbaBKJZBTlIFkTlXfik2r4NKhRqdvAfLBrSFcTwYqiAURIz9lfFbZP3/9a1GjE4vPfvWuGKkOy/zStWIDKkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743705035; c=relaxed/simple;
	bh=/oCj0Hk1g+sUvQ3GIO57Vo8U9NcTvnSSJUK+gndZU1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nSckxeWi9sNaMmYK9HImNZm/1keaOl+QRHgGc4FL0PM7I+ZzscrVvW5iPE8LPV2iF6lHR1tZcIKwu/8mBJUV8XvIXdRbOZCO20sJoOLEKNAycfSd6ZnXSlcenwZICHme3bzXvQ0C1I/AVg1byFr6CwFWeDpQc+p5Y3YM2hv3x4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N8pW6y6H; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743705031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UdDp1sO0IopfH7Iy+tgmsR53cIFBoLuTkzWc5BMhUC0=;
	b=N8pW6y6HFbeE9hCyE1ExGSseCusV1hXW05RIrKkHvLtrxfI0VTomHeIxrLZT6ZmnQ3pmZh
	lSJXxwl818uHQhTcRf7gnBYyXmnKddjhdtmAQLXBkvJhnGvL1/TCvKqwoRYKfZBYrMzjjA
	ZKlIFMCwdhALDB+60jfyWeIu+JHt1/4=
From: Sean Anderson <sean.anderson@linux.dev>
To: netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	linux-kernel@vger.kernel.org,
	upstream@airoha.com,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Naveen N Rao <naveen@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [RFC net-next PATCH 13/13] powerpc: dts: Add compatible strings for Lynx PCSs
Date: Thu,  3 Apr 2025 14:30:23 -0400
Message-Id: <20250403183023.1948676-1-sean.anderson@linux.dev>
In-Reply-To: <20250403181907.1947517-1-sean.anderson@linux.dev>
References: <20250403181907.1947517-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This adds appropriate compatible strings for Lynx PCSs on PowerPC QorIQ
platforms. This also changes the node name to avoid warnings from
ethernet-phy.yaml.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-0-best-effort.dtsi | 3 ++-
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-0.dtsi             | 3 ++-
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1-best-effort.dtsi | 3 ++-
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1.dtsi             | 3 ++-
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-2.dtsi             | 3 ++-
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-3.dtsi             | 3 ++-
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-0.dtsi              | 3 ++-
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-1.dtsi              | 3 ++-
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-2.dtsi              | 3 ++-
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-3.dtsi              | 3 ++-
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-4.dtsi              | 3 ++-
 arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-5.dtsi              | 3 ++-
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-0.dtsi             | 3 ++-
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-1.dtsi             | 3 ++-
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-0.dtsi              | 3 ++-
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-1.dtsi              | 3 ++-
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-2.dtsi              | 3 ++-
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-3.dtsi              | 3 ++-
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-4.dtsi              | 3 ++-
 arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-5.dtsi              | 3 ++-
 20 files changed, 40 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-0-best-effort.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-0-best-effort.dtsi
index 7e70977f282a..61d52044e7b4 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-0-best-effort.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-0-best-effort.dtsi
@@ -66,7 +66,8 @@ mdio@e1000 {
 		reg = <0xe1000 0x1000>;
 		fsl,erratum-a011043; /* must ignore read errors */
 
-		pcsphy0: ethernet-phy@0 {
+		pcsphy0: ethernet-pcs@0 {
+			compatible = "fsl,lynx-pcs";
 			reg = <0x0>;
 		};
 	};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-0.dtsi
index 5f89f7c1761f..78d6e49655f4 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-0.dtsi
@@ -70,7 +70,8 @@ mdio@f1000 {
 		reg = <0xf1000 0x1000>;
 		fsl,erratum-a011043; /* must ignore read errors */
 
-		pcsphy6: ethernet-phy@0 {
+		pcsphy6: ethernet-pcs@0 {
+			compatible = "fsl,lynx-pcs";
 			reg = <0x0>;
 		};
 	};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1-best-effort.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1-best-effort.dtsi
index 71eb75e82c2e..5ffd1c2efaee 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1-best-effort.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1-best-effort.dtsi
@@ -73,7 +73,8 @@ mdio@e3000 {
 		reg = <0xe3000 0x1000>;
 		fsl,erratum-a011043; /* must ignore read errors */
 
-		pcsphy1: ethernet-phy@0 {
+		pcsphy1: ethernet-pcs@0 {
+			compatible = "fsl,lynx-pcs";
 			reg = <0x0>;
 		};
 	};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1.dtsi
index fb7032ddb7fc..e0325f09ce5f 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-1.dtsi
@@ -70,7 +70,8 @@ mdio@f3000 {
 		reg = <0xf3000 0x1000>;
 		fsl,erratum-a011043; /* must ignore read errors */
 
-		pcsphy7: ethernet-phy@0 {
+		pcsphy7: ethernet-pcs@0 {
+			compatible = "fsl,lynx-pcs";
 			reg = <0x0>;
 		};
 	};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-2.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-2.dtsi
index 6b3609574b0f..8e6f6c5f0f2e 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-2.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-2.dtsi
@@ -38,7 +38,8 @@ mdio@e1000 {
 		reg = <0xe1000 0x1000>;
 		fsl,erratum-a011043; /* must ignore read errors */
 
-		pcsphy0: ethernet-phy@0 {
+		pcsphy0: ethernet-pcs@0 {
+			compatible = "fsl,lynx-pcs";
 			reg = <0x0>;
 		};
 	};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-3.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-3.dtsi
index 28ed1a85a436..2cd3f0688cb1 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-3.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-10g-3.dtsi
@@ -38,7 +38,8 @@ mdio@e3000 {
 		reg = <0xe3000 0x1000>;
 		fsl,erratum-a011043; /* must ignore read errors */
 
-		pcsphy1: ethernet-phy@0 {
+		pcsphy1: ethernet-pcs@0 {
+			compatible = "fsl,lynx-pcs";
 			reg = <0x0>;
 		};
 	};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-0.dtsi
index 1089d6861bfb..9f8c38a629cb 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-0.dtsi
@@ -62,7 +62,8 @@ mdio@e1000 {
 		reg = <0xe1000 0x1000>;
 		fsl,erratum-a011043; /* must ignore read errors */
 
-		pcsphy0: ethernet-phy@0 {
+		pcsphy0: ethernet-pcs@0 {
+			compatible = "fsl,lynx-pcs";
 			reg = <0x0>;
 		};
 	};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-1.dtsi
index a95bbb4fc827..248a57129d40 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-1.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-1.dtsi
@@ -69,7 +69,8 @@ mdio@e3000 {
 		reg = <0xe3000 0x1000>;
 		fsl,erratum-a011043; /* must ignore read errors */
 
-		pcsphy1: ethernet-phy@0 {
+		pcsphy1: ethernet-pcs@0 {
+			compatible = "fsl,lynx-pcs";
 			reg = <0x0>;
 		};
 	};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-2.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-2.dtsi
index 7d5af0147a25..73cef28db890 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-2.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-2.dtsi
@@ -69,7 +69,8 @@ mdio@e5000 {
 		reg = <0xe5000 0x1000>;
 		fsl,erratum-a011043; /* must ignore read errors */
 
-		pcsphy2: ethernet-phy@0 {
+		pcsphy2: ethernet-pcs@0 {
+			compatible = "fsl,lynx-pcs";
 			reg = <0x0>;
 		};
 	};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-3.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-3.dtsi
index 61e5466ec854..4657b6a8fb78 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-3.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-3.dtsi
@@ -69,7 +69,8 @@ mdio@e7000 {
 		reg = <0xe7000 0x1000>;
 		fsl,erratum-a011043; /* must ignore read errors */
 
-		pcsphy3: ethernet-phy@0 {
+		pcsphy3: ethernet-pcs@0 {
+			compatible = "fsl,lynx-pcs";
 			reg = <0x0>;
 		};
 	};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-4.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-4.dtsi
index 3ba0cdafc069..ac322e5803c2 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-4.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-4.dtsi
@@ -62,7 +62,8 @@ mdio@e9000 {
 		reg = <0xe9000 0x1000>;
 		fsl,erratum-a011043; /* must ignore read errors */
 
-		pcsphy4: ethernet-phy@0 {
+		pcsphy4: ethernet-pcs@0 {
+			compatible = "fsl,lynx-pcs";
 			reg = <0x0>;
 		};
 	};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-5.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-5.dtsi
index 51748de0a289..68ffa2c65e03 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-5.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-0-1g-5.dtsi
@@ -69,7 +69,8 @@ mdio@eb000 {
 		reg = <0xeb000 0x1000>;
 		fsl,erratum-a011043; /* must ignore read errors */
 
-		pcsphy5: ethernet-phy@0 {
+		pcsphy5: ethernet-pcs@0 {
+			compatible = "fsl,lynx-pcs";
 			reg = <0x0>;
 		};
 	};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-0.dtsi
index ee4f5170f632..caf28fcbd55c 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-0.dtsi
@@ -70,7 +70,8 @@ mdio@f1000 {
 		reg = <0xf1000 0x1000>;
 		fsl,erratum-a011043; /* must ignore read errors */
 
-		pcsphy14: ethernet-phy@0 {
+		pcsphy14: ethernet-pcs@0 {
+			compatible = "fsl,lynx-pcs";
 			reg = <0x0>;
 		};
 	};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-1.dtsi
index 83d2e0ce8f7b..6128b9fb5381 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-1.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-10g-1.dtsi
@@ -70,7 +70,8 @@ mdio@f3000 {
 		reg = <0xf3000 0x1000>;
 		fsl,erratum-a011043; /* must ignore read errors */
 
-		pcsphy15: ethernet-phy@0 {
+		pcsphy15: ethernet-pcs@0 {
+			compatible = "fsl,lynx-pcs";
 			reg = <0x0>;
 		};
 	};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-0.dtsi
index 3132fc73f133..a7dffe6bbe5b 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-0.dtsi
@@ -62,7 +62,8 @@ mdio@e1000 {
 		reg = <0xe1000 0x1000>;
 		fsl,erratum-a011043; /* must ignore read errors */
 
-		pcsphy8: ethernet-phy@0 {
+		pcsphy8: ethernet-pcs@0 {
+			compatible = "fsl,lynx-pcs";
 			reg = <0x0>;
 		};
 	};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-1.dtsi
index 75e904d96602..d0ad92f2ca2d 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-1.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-1.dtsi
@@ -69,7 +69,8 @@ mdio@e3000 {
 		reg = <0xe3000 0x1000>;
 		fsl,erratum-a011043; /* must ignore read errors */
 
-		pcsphy9: ethernet-phy@0 {
+		pcsphy9: ethernet-pcs@0 {
+			compatible = "fsl,lynx-pcs";
 			reg = <0x0>;
 		};
 	};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-2.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-2.dtsi
index 69f2cc7b8f19..b4b893eead2a 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-2.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-2.dtsi
@@ -69,7 +69,8 @@ mdio@e5000 {
 		reg = <0xe5000 0x1000>;
 		fsl,erratum-a011043; /* must ignore read errors */
 
-		pcsphy10: ethernet-phy@0 {
+		pcsphy10: ethernet-pcs@0 {
+			compatible = "fsl,lynx-pcs";
 			reg = <0x0>;
 		};
 	};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-3.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-3.dtsi
index b3aaf01d7da0..6c15a6ff0926 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-3.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-3.dtsi
@@ -69,7 +69,8 @@ mdio@e7000 {
 		reg = <0xe7000 0x1000>;
 		fsl,erratum-a011043; /* must ignore read errors */
 
-		pcsphy11: ethernet-phy@0 {
+		pcsphy11: ethernet-pcs@0 {
+			compatible = "fsl,lynx-pcs";
 			reg = <0x0>;
 		};
 	};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-4.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-4.dtsi
index 18e020432807..14fa4d067ffd 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-4.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-4.dtsi
@@ -62,7 +62,8 @@ mdio@e9000 {
 		reg = <0xe9000 0x1000>;
 		fsl,erratum-a011043; /* must ignore read errors */
 
-		pcsphy12: ethernet-phy@0 {
+		pcsphy12: ethernet-pcs@0 {
+			compatible = "fsl,lynx-pcs";
 			reg = <0x0>;
 		};
 	};
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-5.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-5.dtsi
index 55f329d13f19..64737187a577 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-5.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-fman3-1-1g-5.dtsi
@@ -69,7 +69,8 @@ mdio@eb000 {
 		reg = <0xeb000 0x1000>;
 		fsl,erratum-a011043; /* must ignore read errors */
 
-		pcsphy13: ethernet-phy@0 {
+		pcsphy13: ethernet-pcs@0 {
+			compatible = "fsl,lynx-pcs";
 			reg = <0x0>;
 		};
 	};
-- 
2.35.1.1320.gc452695387.dirty


