Return-Path: <netdev+bounces-180121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1572FA7FA55
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2142F174B0E
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06AB266B73;
	Tue,  8 Apr 2025 09:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQqkeU1A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2301D1E1E04;
	Tue,  8 Apr 2025 09:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105937; cv=none; b=uitNktFRIhQZzZewPgKN3QJnajmBMTtvhZlTp8W3nT8JaNThVfejdIS+bkSLDvBT4B5BbnepHfjdqyTBO2HQDJGpj6EhjAnttrCrVnAKXAQT5tOBz54h+XkJfYQdd9FqCCpiXYe47MheNET5Rx5mKn2G8cjiziO9cALihcbL2yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105937; c=relaxed/simple;
	bh=RviuwahNLVc/MWWR/qFiIokPdkbJbRzURQbmTGIMI24=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QcoST3PK2PToN7hiLnAIeOVLB2diarZYwFwOEI5kiUpL6PphQu0JWuXVnHNsp1RB77nmAa9tfDbDMVDOL+2FYMrCKOD6erwZRalQ/a4439tLjFfPDnQe6sO4HLyOib9xobs3VfnXqN2s2wMSk+HsNsXcjOsA0GvgetRSRCmAGAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQqkeU1A; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39d83782ef6so290090f8f.0;
        Tue, 08 Apr 2025 02:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744105934; x=1744710734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r9WVqBNjVDARAuAcOpCm7nO6NK//qFgMIDPPMTwzB9Y=;
        b=KQqkeU1AORkhClhYXvamxAAvrUjzfzWTk4QWkjQmLM6kDVm5OUEPXXSvcfHusAhdXL
         HmxU5bR4fbsS2kxNelMeCXn1PyoNDHovvHoRp2YoPVeAJpnzeoSivKgp8JBSI36ALGAG
         Oe7/HwbBT77UG2uIfgHJUEGROqLabicRMuVLZ2z6OQ1AOAneonUNxcg5bMHfTQDvCNTb
         fhbmhk3pCkDnrznQhq6GZhSwKKdpDusUbBFVFYpCAPQhXtW+u6YMI+NRGNOfJAQ3bZHC
         okZ+JNuaDRlGMU1jPZe+J30lgrp5LCOc5EMMH2xvQSpUsMlIDGoqOypXu1DHo9Nz0ulp
         9INA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744105934; x=1744710734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r9WVqBNjVDARAuAcOpCm7nO6NK//qFgMIDPPMTwzB9Y=;
        b=rXUSabw9UfM4h+lLJ3cOURdgSoGL/gYMS+2H8Oz96blh2WCEJVnoSRc20PGOtESu45
         yFybannznBX3cb4kgZXmc2twj2L2G5WmaYRIyaF505OpGpSfj0iQW0JenFk2QhCu+aWx
         pPxhf2lWz7OD4ihKxvP2YmBxOnOHzjwDyZ5T8K/Je5A2BiXdFApvd14gRyYT1QlnnDBI
         WcmTKWjpTYSFtAtygonGkKKoWdHz+/uT2Jy/iUk0Y32tNgEGu99Mwm4DVqvRIbeI7mwP
         6ojK0D3WhNtrBoYZHxJFJLVnGI50mpc1Me4AAgprsVxdXHQIIF0YBxKYrtwBhoIB5EQ7
         IHkg==
X-Forwarded-Encrypted: i=1; AJvYcCX+8G0on7HfTTRMwMSygUGevAs6OvyrYiQrUyoOP7gUSL3+TUQmqG2sH6Zi1SMjGVckamr/8LRP@vger.kernel.org, AJvYcCX0KqeIEGWg2Jp/gWTPw27+2KAi3lGQ1N3L4HR1XE982qWMeB9krdfCG2xydNi1XDczu/eA/cfRYQm39POO@vger.kernel.org, AJvYcCXfBfF4jom1+xNBh8eqnsVjAqg2MT9lT1qUzaxsHtJ/F9JgorVzsk40G4cUsRtglxN2o/V/xsjnghmE@vger.kernel.org
X-Gm-Message-State: AOJu0YwdKY7Y+7jKZ+aEpK+wnfaqAqHJCd0ZvcAPCAnl7BzrNCAz94AQ
	MTl2Hj1i84yASi9mhQLVv4kTHWfGYJqtRxE0BWRhJYZtTvHWic+5
X-Gm-Gg: ASbGncuXVFi1ix8aaYSRPVDonFrM9QdNrpvx/8i27YiSegkD4MoqFi9weZ2ebYUMWbO
	FeEcJ+8Q3ExK+dyLsPK2hYB6I5LAIx/BIUXHJj9J4KdCDEvudO+U4j80ldO1t+ydJgpYvqBMQky
	l36a3QfOPDwsJGuE89u1UihG8ff8jcsX7/q7jsxIYR8DiqTfJQZm/HeunfvZ3aEfReQH4JQ95EK
	+sJc+69QBjRT+kfBlG+rSg5/CY54Uzw+f/CfTzs0oYs7clYzWb1OtHB9QQo62k7cpx8w3pxHZO4
	lenm9WLNMP7DyvnDBfQpi72FclnsbEzVuyF5PddExzosX89nagh5ltrUsgS01TgtT1EDVFtdJoR
	2vL/aLSA4c8QuWw==
X-Google-Smtp-Source: AGHT+IEVrAoJHAtIp9Eap+mm2qROvOpwdlWe6t15SZ+SKIAaChNthcm1sv/OWGyYjhXa68oUZgPklQ==
X-Received: by 2002:a05:6000:290c:b0:39c:1f02:44d8 with SMTP id ffacd0b85a97d-39d820ab532mr2192973f8f.4.1744105934317;
        Tue, 08 Apr 2025 02:52:14 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39c3020dacfsm14493310f8f.72.2025.04.08.02.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 02:52:14 -0700 (PDT)
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
Subject: [net-next PATCH v14 02/16] dt-bindings: net: Document support for Airoha AN8855 Switch Virtual MDIO
Date: Tue,  8 Apr 2025 11:51:09 +0200
Message-ID: <20250408095139.51659-3-ansuelsmth@gmail.com>
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

Document support for Airoha AN8855 Virtual MDIO Passtrough. This is needed
as AN8855 require special handling as the same address on the MDIO bus is
shared for both Switch and PHY and special handling for the page
configuration is needed to switch accessing to Switch address space
or PHY.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/net/airoha,an8855-mdio.yaml      | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml

diff --git a/Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml b/Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
new file mode 100644
index 000000000000..3078277bf478
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/airoha,an8855-mdio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha AN8855 MDIO Passtrough
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description:
+  Airoha AN8855 Virtual MDIO Passtrough. This is needed as AN8855
+  require special handling as the same address on the MDIO bus is
+  shared for both Switch and PHY and special handling for the page
+  configuration is needed to switch accessing to Switch address space
+  or PHY.
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


