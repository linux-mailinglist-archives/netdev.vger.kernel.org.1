Return-Path: <netdev+bounces-175059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D45CA62F6B
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 16:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84CB27AB86C
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 15:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8F9204F7D;
	Sat, 15 Mar 2025 15:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYoktQqG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7628204C0A;
	Sat, 15 Mar 2025 15:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742053487; cv=none; b=YjqaqB3SZho1Vb+3bowWIEDqW3lgIN2IWGEB04nvtabTdETJ2rL0hbNnKOEjx7a0HGkx+bAPqveko4T2CuXogNQ2Cd7qRN9hpphTwUll1Ox+O4zaiZPtX4FNgFTER64DC4DEIaB8PopNDSs1BqD8hhHnfiqW5lpRGtz/Rtt72RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742053487; c=relaxed/simple;
	bh=ViorCjFj71CKzPSVMFnCxYOQfoRQl3M0xqZqwPtVzyo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3hfKwswK/WHhhU37l/AJvHk6YGprCcm2CxaTCiEend3obgZXCHwkqh+18siwBK2Mp5tPyO4AQSUUucrweQIMrMjd9ZZ6fK2RtBv750qx+oMTWYDNxfY9EYFS68/ycuIL3hpawYfvWYmZM3D/tNyy2kEVz5kJMFyIhJHSgVSjdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYoktQqG; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3913d129c1aso2422123f8f.0;
        Sat, 15 Mar 2025 08:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742053484; x=1742658284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qKzguv5FZbUbvmSzUVMgTGlbeTysJjbKI0MLUuKQXJY=;
        b=cYoktQqGJXxEhjMZUKM+z7pHi30DX53KCNs84WHa+qqSzeJa5+lMhyf5IjfORtJGmv
         asupLdbtQ61Wtez/EsEnNuJsPTh3D2HuHosO9koWbgm/k1EDSLyGNytkCbLm8YkourlZ
         UfMm1cgfPDFsCPraOWJu84+cmCrS0+2S79zTZjPvTdvLZ25PGY6rAQOKofaZbMJIf7ou
         530ifnEpBXmyYwqj7bNBhP6WBJRrL6g+fAyvbHywO4aSc/D7j2ZvwQKsBzx+6tWieo00
         n7tUq4A6u/ojixWX1XgHzttPYDKoQTxbwZkIJbwc0rFygszynSpPq1w72q5+RMot+wpg
         OdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742053484; x=1742658284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKzguv5FZbUbvmSzUVMgTGlbeTysJjbKI0MLUuKQXJY=;
        b=pL5sD4rdtvvpc33MHnVkdWJ4SW5MV1FFSuq7NZYWVsHDTPiSyTDjiHDJWFHPeVQico
         S+8Hsqu4xi2FIevcUWK2J8TS8jLH9wD/7fus1GlYRA4NsvQAgg5DzvH+kPn0C/FUpeLK
         Yol+WR83jX0FLtEx2UN2HtvXT/IXuCTcGR3g5n7ndKxr9Ceq3Qg9xmx5N2mxwPfcz13+
         01MNTxJ8TUrEbIO2eJp7bU6m8sxXcTyDqclwiFVUvGCAa2JoSg/Hpw2XGmUHDFosXjjc
         Uk/cDnD/h76WJPfj9RqGEfUnfP6YLJ8fOlYd4AEtr3MJGv/+ikQVAWzxSiAvKUtJvtoA
         vZLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCunE10UoOpKqwfs660waODA3vo8S53wGrVJr/ct585J57H3GKbGOotEAuXlcyrTb+0uAmUsVP@vger.kernel.org, AJvYcCVfZ9lUAnqsNOTYY/3USozR+o4pDIdMUeemfmOkx8OgdG+JIZzWm6V7FAqp1IaMMmqNcJwZij3jtU5KraOE@vger.kernel.org, AJvYcCXVg2r/uNMh69wXWv/hpEr2CsYKHXEL7LGjHbwHXtPxuOMJYGA3cAlgERJd/EW94JJXQXYim4T+4Ton@vger.kernel.org
X-Gm-Message-State: AOJu0YwpQCjHjHoJEQ9bwdz4ijtFJjwsMMddDu44ohFHXS8vkY/6OGU/
	w5Y7Zn5Uk7ThYxbYhcTbdsMvr93rNqNKOqGtxHDOXy5BuS+Fxzyb
X-Gm-Gg: ASbGncsj8Zv/HQMKtbf3hA/2f0E4GHeimdBvDI5fbem4viKwPzNQe+QEqVw45ax6tAw
	Koonf6hNHyq0IWCkX7h0sD+dt+GJYjNjFSOd1TmfT0cqZNe6MMFG/+5XH8EfcjdKUtqe4hDpBD1
	so0zggWaZQY7BuNXXvjAEXbK38rhST65KNkGyPxbh3vZv93jamLSYx8L1ynPDFEHq7nIhh1QlMD
	QbDRO4pdHymZrtC/Vpc5WViOuCb5FALmNK5A+NAYSqsdDXFzw0vlKkv43jQY0d0N0jJo0EaeCpH
	uyRJbxvshRm3KI2sf3SlG/cw0tNleJm5M2WJ4yOJG3VjP8SLxT2VKMMJuKhv6cNBKAHiZ5MajtP
	SZlC35hUOy+tEbrUukQ7FoH/J
X-Google-Smtp-Source: AGHT+IE49+rfPRWkhQnonyxaadm1sq1c5PFRzPYaCltbYtN0FqVKUN0uyr5WSerVe16ioqfKocwosw==
X-Received: by 2002:a05:6000:1869:b0:38d:df15:2770 with SMTP id ffacd0b85a97d-395b4231bacmr12639946f8f.0.1742053483995;
        Sat, 15 Mar 2025 08:44:43 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d1fe0636dsm53464195e9.11.2025.03.15.08.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 08:44:43 -0700 (PDT)
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
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH v13 03/14] dt-bindings: net: dsa: Document support for Airoha AN8855 DSA Switch
Date: Sat, 15 Mar 2025 16:43:43 +0100
Message-ID: <20250315154407.26304-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250315154407.26304-1-ansuelsmth@gmail.com>
References: <20250315154407.26304-1-ansuelsmth@gmail.com>
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
 MAINTAINERS                                   |  1 +
 2 files changed, 87 insertions(+)
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
diff --git a/MAINTAINERS b/MAINTAINERS
index 1e8055b5e162..696ad8465ea8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -726,6 +726,7 @@ L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
+F:	Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
 F:	Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
 
 AIROHA ETHERNET DRIVER
-- 
2.48.1


