Return-Path: <netdev+bounces-201680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F285AEA8BB
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 23:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79D1E189ED30
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 21:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD23263C9B;
	Thu, 26 Jun 2025 21:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRkIaJMP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50B726056F;
	Thu, 26 Jun 2025 21:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750973038; cv=none; b=ijyHM5aI7/CyRcWO3o232oWhtk6WhdLPaAtfz81iPrXXe1u0wHZUJlslS5+vbUloRrG6/3eBmpH87UZujD8/4L7M0CIOalPE3cA1SQEppLOZC8jsEAiDSFyBIO0kdiExCraZ202/cIkd6hwsQf/32fDRtdmT6fOCJGtWwp+CV3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750973038; c=relaxed/simple;
	bh=hYEZj3VvI3ZQMiwBhFBv1UrBmw38N4lAjKzwzw87GQQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gydc50mHMPypCxuXqqmI+TtozqjYNgArxS88TS8V52zh+OMonLN/6zJXpi2ng9bAbXdgeDDqtRdcUMOaAdttHz91bvojGplhx3OiWwgsiCTK8ZCd7934ZZizbLorsgV0I8hCXHq6fNzRwwzFbLTHEoqNcKwFe2x2eZhRdhLFJLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRkIaJMP; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a54690d369so1314309f8f.3;
        Thu, 26 Jun 2025 14:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750973035; x=1751577835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vw4EzE0K5e4aknCIY0FtGD//kTDf6e/8GmBlZiK8kXM=;
        b=GRkIaJMPyZAsSKh6r65BoSw9dG2rk1FvmW1x06omK4SdP3mTLm4BkWMDo7WtTjiQwg
         KDYLNNMon9eiNodgjUbbFU1BOYQ4767240Fo8Luw+yoqCEWuS32+mQs0dkCxgAJXd6q8
         NJctDNLVKTumHvX7jLq3400dyAYMNg035l8rD/CVyRrGQWuVaJvd7/BQejc/DZ6pcr7y
         G71WvKgiV2RbQlrL/9an92y4NCuTGUVq2DdnrwUc+slLLOFdslLxG3MhrclukTqlAWrD
         qcQrMqKep2L/nYLA/JmiQ0TNSNskajj3L9CAbFmHbQdpXqD7Yv/SaYtfpHZ5PPDplGCK
         kfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750973035; x=1751577835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vw4EzE0K5e4aknCIY0FtGD//kTDf6e/8GmBlZiK8kXM=;
        b=jyoAmlBxSI7DUNzeJFQQnayAJ8ZjNteFGG4GrflAIJjMKg4ROjgIvllhJmzs8XkC8n
         an4ubmg3hs8dbyAO/80LtXSr/HTDbFirR/AkSgDXOlyeNyIGlvd+I+3Anx5UYCIhjNvu
         79wD5P2gguJaGgr1pQadgWiZ931yX6EX07iSSlHKJGtHX2EIis6hwU6MuFpMJAp5EsM7
         pGwgKMjyQy/pBNe/S25kfwNE4vMPq97RRYTBrGF3B4+YEHfsyLJZvyAcczcRd12SRbFJ
         gQpY2egv1afFAb58OycZjt4VQMDZdcsa1UvmX7/PWTivvTJSV8F7U8p4+XUC8bsPqpdV
         BaNg==
X-Forwarded-Encrypted: i=1; AJvYcCU+HIQbStYECKVmvkuDfeJLSCnx4NiuI+gukdKWWSA1JsyoYWPOqfsqnuMxqdSOX5X8V9Mf2qcMS/qVkYZs@vger.kernel.org, AJvYcCWTIyBIY8X3ispwbftvPn5UNvba2du0p4vmF+HTRD/m5bB0djxr+Nn/CFszw8boHBdPbdBAzTEx@vger.kernel.org, AJvYcCWj/DDL3W6KAgFlt+DGsQzCIeo+vIe5RI5VNyTf8e3umHF9+rDWH6cNYUAhTskxlvZkb56FZZsh0iJA@vger.kernel.org
X-Gm-Message-State: AOJu0YyB0VVrj8/72IO6hoNzS8ak8wEjudmvTHJ8vJme30wREdb3Uwvd
	/tuBzW3dvHcm8/VnpYXcJsXW6cisCqE4gUSR9hy+PhQt9kjfYYkNtxSW
X-Gm-Gg: ASbGncvquES4UKry8oqN9dYzYWFQ/MhPIHCyir4FeDoPjQPPu3dzkE2ls5TRCetstDF
	kRTKoBSw/RYtjrm5284rTW2qwW21Hfg+juHV6SF1QjlXrwHoomQIEBNLxx1ogIpYO8Sf2lK8i7B
	g2us45nuLIftG7SI3iqKAnO3mVL4sv1HHgMxJQDuc+yc4JrhzjejvezkfWCW4B7vTSannWFAFAX
	O7OUHR9g1N8tSrS38gsDUiz1JgvP8Ysu8HUZT1+v4pW78IfZzJ9waWqkbtb2ykDzzlxNwFaufLa
	A4eHN1BMSqHyRg6ylSEhc9QWcN3C4yU3oXxe8BMJpJ4MXBc25MXzKhOwA0Z6KM3gVzT1XUnu+rr
	mDYSdbBZ0OtMt6i1jNQgt2hI69ndPawE=
X-Google-Smtp-Source: AGHT+IEe89a+1iGAR9o9V05xb+6jRk123zgYHX1NtDrWeh9wpQgDj975ljb14+WFNdYJILRtLM0UQA==
X-Received: by 2002:adf:b64c:0:b0:3a5:39e9:7997 with SMTP id ffacd0b85a97d-3a8fdeff435mr620062f8f.34.1750973034929;
        Thu, 26 Jun 2025 14:23:54 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-453835798acsm57186475e9.10.2025.06.26.14.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 14:23:54 -0700 (PDT)
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
	Srinivas Kandagatla <srini@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
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
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v15 02/12] dt-bindings: net: Document support for Airoha AN8855 Switch PBUS MDIO
Date: Thu, 26 Jun 2025 23:23:01 +0200
Message-ID: <20250626212321.28114-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250626212321.28114-1-ansuelsmth@gmail.com>
References: <20250626212321.28114-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for Airoha AN8855 PBUS MDIO. Airoha AN8855 Switch
expose a way to access internal PHYs via Switch register.
This is named internally PBUS and does the function of an MDIO bus
for the internal PHYs.

It does support a maximum of 5 PHYs (matching the number of port
the Switch support)

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/net/airoha,an8855-mdio.yaml      | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml

diff --git a/Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml b/Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
new file mode 100644
index 000000000000..c873103d2b66
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/airoha,an8855-mdio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha AN8855 PBUS MDIO
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description:
+  Airoha AN8855 Switch expose a way to access internal PHYs via
+  Switch register. This is named internally PBUS and does the function
+  of an MDIO bus for the internal PHYs.
+
+  It does support a maximum of 5 PHYs (matching the number of port
+  the Switch support)
+
+$ref: /schemas/net/mdio.yaml#
+
+properties:
+  compatible:
+    const: airoha,an8855-mdio
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio {
+        compatible = "airoha,an8855-mdio";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        internal_phy1: phy@1 {
+            reg = <1>;
+        };
+
+        internal_phy2: phy@2 {
+            reg = <2>;
+        };
+
+        internal_phy3: phy@3 {
+            reg = <3>;
+        };
+
+        internal_phy4: phy@4 {
+            reg = <4>;
+        };
+
+        internal_phy5: phy@5 {
+            reg = <5>;
+        };
+    };
-- 
2.48.1


