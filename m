Return-Path: <netdev+bounces-198488-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DD5ADC5F2
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 11:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37E37177412
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 09:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8400D23B615;
	Tue, 17 Jun 2025 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqNg+6fw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B772BEFE5;
	Tue, 17 Jun 2025 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750151845; cv=none; b=HPq7z0qBDqaBdqALMuMVjr8zbEzcKK5U4U/FXSTPhPDZUwxvUAUQtS9MXPGZSIWCwEeNcm/Y+3QVd8+pHBJ0kQAYCELBYiz2/Y9WMDbSS3TBVzD2r/cssOXQs4euIAoM/0Hs58XTg2UQl3cNBgDnWkQ/GUt+P+neMuz9Oq0Fdx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750151845; c=relaxed/simple;
	bh=AyowKU6nutE8p66nCJZ5edfdSKkics89RpedKvqqraE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=uLP7EdA5PFk1TxAESiFH19hGhAvhsL+QjI/uSJg4Jhl6H6225f+1AOL+kvhUJSG3jYWareCROg6YkkV4JPtDuUT2XzwipX0qXWms83kU2Xx5Wjtw/JlU8nSW8rOobgmu0CP6CYo7qpMZUziymDgnya95E5sGa/SJKSR3zOonGYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqNg+6fw; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a589d99963so297211f8f.1;
        Tue, 17 Jun 2025 02:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750151842; x=1750756642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WtJ8z0acx9WzqUIDNmSBAy+2NeTuKOKM78Z0uTGz09U=;
        b=RqNg+6fwK+2qbtGXCRXinm4tEsPPEZTAPiPBrF9xCVnY9fBr7AIOmKl1Z4DvjcATGU
         6E7X+g8fIwfaPdjgYn/Y+c+50Pc3rck8uo2Z7nvI5RPeYfOkC+ZOjIg2HfjdWuECvFZ7
         k6B5fpkc8BVf+yEGae2/HtBiE2+k0DeBiUQu4GyWZPPUMpvc0vmSF+n4fC1otjozkohY
         uNdIhOkbCKjJrjo/7hNH9+TUWbhRBA/EuktgWTwAidXKo6q6xytTVYvxZKuRhlPmTK9X
         28TvIqHcYis5WU7EloSwue54HyxaVoTq+EsGUjeWYnQ3htNTX40oAFabY8DB4hm2t1g1
         h+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750151842; x=1750756642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WtJ8z0acx9WzqUIDNmSBAy+2NeTuKOKM78Z0uTGz09U=;
        b=NSeyGDzthCZvWMRVAzlr3yA+VhO4+flLEWBUhcSyKVnrUuePfhxfo5fjeD9tLMMjxt
         XoAnX5YIks4kq8sH/Zi1nlaKD4FcNtBmlXwREzHAhzMXmjOxd3N52PNbD0iC+VrFaDzp
         CtpSroRDXqpn9PYmzVHpvMw3lqDVaOPGo58NbRIvfGdXn4To/dQVuM6YEXrNgAqMMU7f
         cJb5uAG8GL2ppDeIYhdpmFYgUc3d+c1BXoam/utEli899dCyZ7eOjenB1teTvihJCTWL
         2qa41/Ls2UtOkgUJeroVbLGz9p0923JrgXBQe0vPEk4WugU5WAlWMqAyDyLP9tAvvmlu
         VtsA==
X-Forwarded-Encrypted: i=1; AJvYcCVVYnE3JKR1EpW0x0hoWURkQem8cNtHd/yya2JQ6YrHPXAislcsEA8mRnhDYBSxMFN1NF9S7vtiZT86ExAT@vger.kernel.org, AJvYcCVkiEa/H3b4v/GZOscfcmuNmvQ4Zo+TjWLEDIs85mj/rE35WA9vV2Z9A+BjD85JVhKZ9s7wHBAcPhTx@vger.kernel.org, AJvYcCXJHcF+I4+KHnZKFwZE0INk5ZnTvpAqL9z8oEk+X26Io9zCEwDihcxbUuk5ra2Tul9Vr/ilj5Pv@vger.kernel.org
X-Gm-Message-State: AOJu0YyBVDb7XY0EIuRqEp0Ro+Ezf9WatYn3XzWGfO2v0HVN7H6GWN3q
	BS0dMQB5rgaL/imLqddx25K1WOssFmDQHAhjIXvowAfYS7nPYlUhMSZy
X-Gm-Gg: ASbGncudtWGf75o6ytHrJY1ZMvaAqylGIXI6q5A5ZwHI7qIV8Xp7R8pGaUm0A5uTZTA
	8rYlFTX8/z71CVHqTPc/Y+PHW83uIbNQ/LwhJODXtyK+nNiHGT34Yt+fOcfd/3WNrODY0gsyxmK
	ykQts9Fdf/QCAsW3tLCQXDAEqWvHQG7DJsQ6N+Jyg2IGn95LhfLHSkhNayMpivZsOKJuem81ALC
	QsHfw7G73P6dyyn+Nz/4n5vsTOmE6mTl88oG5RogsSZ/tsE0iv7wkoa/OZl2GNouwe7+p3umVTw
	x4wy4EyE1Tr26MPSVlnR6DeNGUGvU9tdsNFvBXeb0+cp5nh2trZ75EEVHQu/MyAUGBzWidbLKFM
	ngTrGCl0WXgy7ClAEo005+Uluw44eL5M=
X-Google-Smtp-Source: AGHT+IFfXOHX8qrEe+yi+IX1pV/kKCwmSDhiMLuDRfXvC3TUuSNiVwwa6WAoGFM8mq93D0dLSrmOWA==
X-Received: by 2002:a05:6000:26c9:b0:3a5:2cb5:63f8 with SMTP id ffacd0b85a97d-3a5723a39b3mr9856608f8f.29.1750151841738;
        Tue, 17 Jun 2025 02:17:21 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a568b74313sm13500439f8f.96.2025.06.17.02.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 02:17:21 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Christian Marangi <ansuelsmth@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v2 1/2] dt-bindings: net: Document support for Airoha AN7583 MDIO Controller
Date: Tue, 17 Jun 2025 11:16:52 +0200
Message-ID: <20250617091655.10832-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Airoha AN7583 SoC have 3 different MDIO Controller. One comes from
the intergated Switch based on MT7530. The other 2 live under the SCU
register and expose 2 dedicated MDIO controller.

Document the schema for the 2 dedicated MDIO controller.
Each MDIO controller can be independently reset with the SoC reset line.
Each MDIO controller have a dedicated clock configured to 2.5MHz by
default to follow MDIO bus IEEE 802.3 standard.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
Changes v2:
- Out of RFC
- Rework the schema to MDIO child nodes with dedicated reg
- Add clock property (required for clock-frequency)
- Make reset property mandatory

 .../bindings/net/airoha,an7583-mdio.yaml      | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,an7583-mdio.yaml

diff --git a/Documentation/devicetree/bindings/net/airoha,an7583-mdio.yaml b/Documentation/devicetree/bindings/net/airoha,an7583-mdio.yaml
new file mode 100644
index 000000000000..3e7e68ec1560
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/airoha,an7583-mdio.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/airoha,an7583-mdio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha AN7583 Dedicated MDIO Controller
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description:
+  Airoha AN7583 SoC have 3 different MDIO Controller.
+
+  One comes from the intergated Switch based on MT7530.
+
+  The other 2 (that this schema describe) live under the SCU
+  register supporting both C22 and C45 PHYs.
+
+$ref: mdio.yaml#
+
+properties:
+  compatible:
+    const: airoha,an7583-mdio
+
+  reg:
+    enum: [0xc8, 0xcc]
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  clock-frequency:
+    default: 2500000
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    system-controller {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        mdio-bus@c8 {
+            compatible = "airoha,an7583-mdio";
+            reg = <0xc8>;
+
+            clocks = <&scu>;
+            resets = <&scu>;
+        };
+    };
-- 
2.48.1


