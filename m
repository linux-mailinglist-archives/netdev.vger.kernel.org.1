Return-Path: <netdev+bounces-180123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 382BCA7FA5B
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C85787A6221
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921472673BD;
	Tue,  8 Apr 2025 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrDAHNYs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCE9266EF4;
	Tue,  8 Apr 2025 09:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105940; cv=none; b=jAplCCoobejomWl79DCz0Zt3YZ7/fSlkP6KjVgqhq7JV/iaY5lRaIikhJvuLh+ewBsijyd0Zt/NmwTM1QmxujxanrFmmPz1nWmflIrfLDEn6UV1KGwQ0wFqQgfE/b9HW6tpDLHkuuHtJ70ykgBQQ5xJVZFemERQP71Q3ao7celA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105940; c=relaxed/simple;
	bh=TcLcBxuZobMf7GWrGLLah6hinSz5HmSnzIgM0LDDAa0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XjB0RQ8B/TtmpuDrF9N4WAJa1FvI62W04M5r8VoZo8DvdTVAfzgm8bXqqY8rjpZq0cYtZFeFU2xGUyRvU75K1DGevfR1ji/fPR4zelu6WBrhmup0tHuulbD1e/9eZ7PSb4rUU1et+rt1XtnMTbIbVt9sp1NyTUaABoNzifjF5vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrDAHNYs; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-391342fc1f6so4698237f8f.1;
        Tue, 08 Apr 2025 02:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744105936; x=1744710736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=byJPrCHf6giAb360kl2C62a9VTaGkIRY65ltid6z7nk=;
        b=lrDAHNYsShgTWDXUqDPu/Vg9C+FyIrC09X70Vzzxtz7elikdLpVegMXgPSZdKiWGvv
         9JF9VY9qmG3I1oBs4Vmo0rcOM+bHhEVXJ73QGkOCVXMbFZNtT9oBXk2BmF06u+MzBZOC
         NsnOaCPUmPjZXCTZJWvzUsZ6x1Ot9sDpnvtvZzuM5Xk9AMU5ZwwoNWlTMib+pOEPuoGz
         NpD/2OcR0gWc99WdYkkAhVKZIQZicsP0qcjedpupVf6BIOiNeQOWqAW9+Yf9l1KC+BQv
         oUxhNErRFy0r3HNLulgkWf4LD504jxNvwRPmV/et9155gQJ0fpG5sjJnR+93zExJSwwl
         KNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744105936; x=1744710736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=byJPrCHf6giAb360kl2C62a9VTaGkIRY65ltid6z7nk=;
        b=YjVw41IyrM2qwjSbye+gjijl2Q2kzdO0UsgbC4Y6HZS/xz0mYoexYG7ae/+m5oeNo+
         6T3DflJR29Yxzu8XYYE1R/0298vNCmirK5HQrzfwhtFTSpmtZ90Jp3uKz7EQpfz9Chtw
         n3f9werlnP1ftuMr/ZTEQqRt20+vKGkzhDL0IhaTyF0uUKlUVlvg7NiGThmdBJHwMfF/
         Pvg9zz12EV4VQR/77y9EBqVDkumDJ/JR3rT93P8b+85NzsfR/ZDOh4pbWw32g2ZvTbng
         6+I/G/bdFkERQ5tQ+coufryExsSG76FsDNLspel4Bk6zPhnmPLT4xZFFFRZxRDc4o8Rs
         FFOA==
X-Forwarded-Encrypted: i=1; AJvYcCX0zpW4Dhu0wmwTtm2L0VYF9Hm+Ie/EVHfxP5qyza/d2EqgtCEwT6cRmHB6Qv5wTOgryzAOun7dBPSH@vger.kernel.org, AJvYcCX5apfc2wpjqJKsAx9qknT5zmXIfw6MNrPA8pWGI7eU2R/8PRVc1jIqTjEny+aITb/xX5lrG0nsh1cUBRlW@vger.kernel.org, AJvYcCXtmJ035CUBDuDNErp82/GVXWOG1XpMBgcJAhbB6NDVJozhK6jY2emCGEAjSlcHJy0fr0c9/t/3@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2s+q4EdqpBblO54ECM4prGLZmEBcF4IbFpJvbemgLEp42Pirc
	XuplV2bmwIj1fY9WRY9w8ycqu7qspdO3nnKcC4qsvnWWqK9BSenb
X-Gm-Gg: ASbGnctwVT4uaLij35d7b+mIIdxDXAWylHrHKkTTxK2cG3HBckKM09wjYAnKrcA7cnO
	Fkiu0hDvYSrSmlWttXSmi7tnCOUFhQmdZ56FUKUAwkWCNXujXKtrnhcrux4/GGIDfd+b2fhyjYi
	S226hbmst/ucvQfGD/hr4xGoQ4h8odsta9z9FVg7CfFzMdjEXzZrNZN+oDzesmpN+ejoS7+RvzB
	OKKLBWDYN8yWCk0DgR1mRRz055xEyw6sM4oJ+f3kuM3FMZZgAYnxCpN2A8BFa+xJK9ZJlo2eLGE
	ju7LRrmlVTiMljj/bFHZQdFsRNzYU1mJZNQmDVjeo4+pRxtC2RlFuhkb04yo1TYtGVQ+lxhh25G
	J41+j6X6nUAykzg==
X-Google-Smtp-Source: AGHT+IGo880VawF4/5TDQUaFDegWLI9yM3ZULhdWp4WgfxOq5TQRzqsaKPB2/AwFAxQmOfQoB66hEA==
X-Received: by 2002:a05:6000:2285:b0:394:ef93:9afc with SMTP id ffacd0b85a97d-39d0de17c21mr12141377f8f.18.1744105935819;
        Tue, 08 Apr 2025 02:52:15 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39c3020dacfsm14493310f8f.72.2025.04.08.02.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 02:52:15 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Simon Horman <horms@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH v14 03/16] dt-bindings: net: dsa: Document support for Airoha AN8855 DSA Switch
Date: Tue,  8 Apr 2025 11:51:10 +0200
Message-ID: <20250408095139.51659-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250408095139.51659-1-ansuelsmth@gmail.com>
References: <20250408095139.51659-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for Airoha AN8855 5-port Gigabit Switch.

It does expose the 5 Internal PHYs on the MDIO bus and each port
can access the Switch register space by configurting the PHY page.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../net/dsa/airoha,an8855-switch.yaml         | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml b/Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
new file mode 100644
index 000000000000..fbb9219fadae
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/airoha,an8855-switch.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha AN8855 Gigabit Switch
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: >
+  Airoha AN8855 is a 5-port Gigabit Switch.
+
+  It does expose the 5 Internal PHYs on the MDIO bus and each port
+  can access the Switch register space by configurting the PHY page.
+
+$ref: dsa.yaml#/$defs/ethernet-ports
+
+properties:
+  compatible:
+    const: airoha,an8855-switch
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    ethernet-switch {
+        compatible = "airoha,an8855-switch";
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                label = "lan1";
+                phy-mode = "internal";
+                phy-handle = <&internal_phy1>;
+            };
+
+            port@1 {
+                reg = <1>;
+                label = "lan2";
+                phy-mode = "internal";
+                phy-handle = <&internal_phy2>;
+            };
+
+            port@2 {
+                reg = <2>;
+                label = "lan3";
+                phy-mode = "internal";
+                phy-handle = <&internal_phy3>;
+            };
+
+            port@3 {
+                reg = <3>;
+                label = "lan4";
+                phy-mode = "internal";
+                phy-handle = <&internal_phy4>;
+            };
+
+            port@4 {
+                reg = <4>;
+                label = "wan";
+                phy-mode = "internal";
+                phy-handle = <&internal_phy5>;
+            };
+
+            port@5 {
+                reg = <5>;
+                label = "cpu";
+                ethernet = <&gmac0>;
+                phy-mode = "2500base-x";
+
+                fixed-link {
+                    speed = <2500>;
+                    full-duplex;
+                    pause;
+                };
+            };
+        };
+    };
-- 
2.48.1


