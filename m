Return-Path: <netdev+bounces-173333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CF7A5861B
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 18:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E6B916689B
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 17:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C771EF37C;
	Sun,  9 Mar 2025 17:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l510Iqqy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D601E1E12;
	Sun,  9 Mar 2025 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741541273; cv=none; b=YngzhUZ6A5AU3bwXCPEgTgWcGCJG7G3PMh+GjcsexWRecnGQi5vJrtaNLgG7hoG8Rrsh27uQZ16J6Fyj+l/bEKrryc7wS1wG6Tu+wsEyWP8mMs3qQ8+jhuetUAydM3K+L8noRDMWCD++OpCu2cE4mtP8co+B2X8R0rFSVM/OBDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741541273; c=relaxed/simple;
	bh=yD1J4lIdXus0e15SA5y3QRtWVkUAobdRZ6hYZSmqWjk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bquGr5AfqhLdQHSINxbOIS53BvuWT8CK7EAxC1ZT2VkBRPLDKdxY4ffQL3O5J2Pw1t6U3wJK09PD/dR75tJppkXWBGy+4GzLmYeMmSWXhOQ0OU3+fPzDs6IyZ9PUjKTQhLYXFHF2r9vjJ/hNbVcmGBRE4FB1mIezW+zsgNZJQ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l510Iqqy; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so19925575e9.3;
        Sun, 09 Mar 2025 10:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741541269; x=1742146069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qe3n3ZQ5LVdeF6eehOPJZ7TfJ6ssfs/dDpnWYl0JxU0=;
        b=l510IqqyNgpkFMvUfwYjYwni/lXTbS2kA5D/GY+N7m+UkrVPrh2cPfqKbf9NtOY/d4
         HbYrZfXGrmVOlLdHpzZj4kFIIVWUmEkHy6l9CZzn5cN692IONNm83RV3Uv3xAxvlX3o5
         kWNnlJyzLimo8CarCQ6mc2zZ2N8qaj9kK5Y4GqnC/C+wsZcrTQwAUbvK2fJMHXSDJ67J
         YDSpi789Um3TT2KAq0br0K5fa601wRM3GasJx4kL3rmLrdgUtSu/EsyfK/LQjao94wFT
         0YjuVYv9HMR8fmen0LMwA/HQn5eHbtR0e3GYQuDOL/bmaDj9JAqzNp2JLfo8a/rbXmBG
         22+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741541269; x=1742146069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qe3n3ZQ5LVdeF6eehOPJZ7TfJ6ssfs/dDpnWYl0JxU0=;
        b=kvDHQzCA/NaJLmKsRHgKTpjK2TH1J47iB5mVG2ccV3J265O03U5jgs1zreg6J2za5d
         oVmCRrf0exFP5s+6RZHwi/s4pxh59nulysmBtFh9SKjxlWqM/stFdKlI8/gztN2Ozlwo
         MF4CHV95TXS7y1QaPcgq/6j06l3Z8jtuYtyn7GvYRXTyMUREGNlRrb+s8ntJlFqCPVQv
         LSXq+JD92Osl2AcK4NBcvCyGh+n+NOqlW9kRiGFyQ/30syZQaOUnBLUmPsI8qFM1CzsD
         hivSQyTzaKpdByUS8dn+qBfMygGT+P+MeRSqCooqbjT/SF/+Fz2PpSeQ58TmP0f/RkIB
         L4zA==
X-Forwarded-Encrypted: i=1; AJvYcCUE2oHUy+ye/pTRaXBmbw5EbSJ3Jm8oEHX2YGxQEELMhC0Nak6/4KmLc+KoX6C0HZIKEVA3QJB5X/eo@vger.kernel.org, AJvYcCWi84fcuANKKplowK/Cj9weDe8kfqKVATpytpxCIQ1y9dZELaj36KbMLk3PHxed2zcje7joocsp@vger.kernel.org, AJvYcCXRiZy26dHzYl41ttDLeMEDGLOUR3r6ce8oyDj7oRcf2wE73fVZlq3L7m0PMX/gCPjMw2leXdFj82URO8Kg@vger.kernel.org
X-Gm-Message-State: AOJu0YwcBL07OAcOjn7jTdFnLvvykZq+WiFszgyxCsTWJYWv7fkJh9TP
	obkeG8MFJvssHJeYAWyvVUBuOHtmvPJL4ZeQWfZJENSJJUV5Ec3s
X-Gm-Gg: ASbGncs3Iv2nGDPInd0JdMd2ugRf7I38y8ck106K0xVbNvzm+yVpXBDdhdoiLjBM9j0
	knlyzj3GEiMJEo5mAbJTnQjXmY+Sowg9daC/vXtoxUbtGqDYiM1RiQ+dESMzH5D3VfF/yLZOzGu
	I+4d44voXGKKfvOn98Gju1njp/DYmgl/AXciryvq7i2eRRHpBxHl0OGV4yUEYG5blXHl5iCvkFh
	Ti0/SY1XijdI1JSWehFZmLP2cuTL1GuRDa1nmG6FhfHdh6humBwY6i94xUftcldRCCI5EuMjqdU
	c7cIv9Q9uX03+w7s377mgBnxVtR17Am2aFjSmYffVyhW5hOUKBuDS8o5bKAKSVrPe/36PF5AeKm
	gs2V0XBNAN2csRA==
X-Google-Smtp-Source: AGHT+IE8jl5fwzucCdfNuxyx+ySkmGSPf06fqDN9KMw/7IGsP3/vKw8Xjz6SFrR9lc/ycFJLxcGb2w==
X-Received: by 2002:a05:600c:524c:b0:439:5747:7f2d with SMTP id 5b1f17b1804b1-43c5a63049dmr62147795e9.21.1741541269430;
        Sun, 09 Mar 2025 10:27:49 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912bfdfddcsm12564875f8f.35.2025.03.09.10.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 10:27:49 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
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
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH v12 02/13] dt-bindings: net: Document support for Airoha AN8855 Switch Virtual MDIO
Date: Sun,  9 Mar 2025 18:26:47 +0100
Message-ID: <20250309172717.9067-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309172717.9067-1-ansuelsmth@gmail.com>
References: <20250309172717.9067-1-ansuelsmth@gmail.com>
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
 MAINTAINERS                                   |  1 +
 2 files changed, 57 insertions(+)
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
diff --git a/MAINTAINERS b/MAINTAINERS
index 576fa7eb7b55..1e8055b5e162 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -725,6 +725,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
 F:	Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
 
 AIROHA ETHERNET DRIVER
-- 
2.48.1


