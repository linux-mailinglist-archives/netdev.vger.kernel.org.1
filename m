Return-Path: <netdev+bounces-240473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E883C75635
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0A1F33596F1
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 16:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC6E36C0A4;
	Thu, 20 Nov 2025 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuBwFOIQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FBB366DC7;
	Thu, 20 Nov 2025 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763656012; cv=none; b=EJY5YRfIuoCsu0zg2nMH82HUU/JsEGFcSk/G9Idds7cb4IpS49zWYHVWyAqy7LT6Trput6kUcN2KjQxewePlr8Oa5DXVWhB+VHFOjRY8aYYy9snAwTHwRsymi5yRznlaBGdXbM0WQ/1fsd+LfmI5ouYL8BayCWvMfqvPozhP8S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763656012; c=relaxed/simple;
	bh=rkNBjbwLoFq9BqcRqqIp3a/rpQWG6VvjMT67WwIxYzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtZP4voUcdRMu/W2qbSS8qW4451Vp+BgTEx/97FE8xbAm4Wej2bqs/ZS2mlrb28lOAqm95xsH1/qTASYnEstb3m7Ta34ggeN91MY26/uDSDB6XBAxPSQ1L+XnSiJ8PE0Efn6UyFFapTDkH0+XOYP8H9I5mmyb/bMLfsnAxGCz6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuBwFOIQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E8AC4CEF1;
	Thu, 20 Nov 2025 16:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763656012;
	bh=rkNBjbwLoFq9BqcRqqIp3a/rpQWG6VvjMT67WwIxYzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OuBwFOIQtvJZo4UvFhnNNYeKkLD2w5SzhLhRQTWxfYBdQ965AZrT+gm8T05WDE6/c
	 roNe31hpHWTh7xmbB+ZM4LrItzMwgO6mshm5Eq67KB31QjgKSGkW627WPO2DdGpYym
	 NvRXeKY9WyO8f6wTfOdew+02CiXs3iHjshf8h8V/SWdJW4JJX1tU7v293SR7p6h4kE
	 POfCwD7TGZkWoD1z8xHKlW59FVmuGGzIrO1ZpOXNGhGU1CGraNkrci4gqW7vdkzrIl
	 M/3lWIYLbAM+OTEYK+R1mTfT6f88RBRXKT+n+/7tsSWfQMn37wHz34XSPGIS3IkwZJ
	 C9VsCmHpMx3wg==
From: Conor Dooley <conor@kernel.org>
To: netdev@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Valentina.FernandezAlanis@microchip.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Neil Armstrong <narmstrong@baylibre.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Sean Anderson <sean.anderson@linux.dev>,
	Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
	Abin Joseph <abin.joseph@amd.com>
Subject: [RFC net-next v1 5/7] dt-bindings: net: macb: add property indicating timer adjust mode
Date: Thu, 20 Nov 2025 16:26:07 +0000
Message-ID: <20251120-drudge-disloyal-9b8a88079905@spud>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120-jubilant-purposely-67ec45ce4e2f@spud>
References: <20251120-jubilant-purposely-67ec45ce4e2f@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=NDamtq5JNE/kXNNE44aa9YujEMn703V/vjt2FaQ3+K8=; b=kA0DAAoWeLQxh6CCYtIByyZiAGkfQRuhTkDIGxVQJ8t/SMCYg4kOkb8JzlWdyFTz6FOW5pgU9 Yh1BAAWCgAdFiEEYduOhBqv/ES4Q4zteLQxh6CCYtIFAmkfQRsACgkQeLQxh6CCYtKeZAD/W+QW 1evt7Irt7dIdI65P4eITbL18e/FN8tPb5HbKQyQBANeQMpJgIgUt6nCK2WOnnI0Hu3iQkOkY8mH UTLhpneMM
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../devicetree/bindings/net/cdns,macb.yaml        | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index 1029786a855c..4cea288412b5 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -116,6 +116,12 @@ properties:
   power-domains:
     maxItems: 1
 
+  cdns,timer-adjust:
+    type: boolean
+    description:
+      Set when the hardware is operating in timer-adjust mode, where the timer
+      is controlled by the gem_tsu_inc_ctrl and gem_tsu_ms inputs.
+
   cdns,refclk-ext:
     type: boolean
     description:
@@ -182,6 +188,15 @@ allOf:
       properties:
         reg:
           maxItems: 1
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: microchip,mpfs-macb
+    then:
+      properties:
+        cdns,timer-adjust: false
 
 unevaluatedProperties: false
 
-- 
2.51.0


