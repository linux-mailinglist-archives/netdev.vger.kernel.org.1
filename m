Return-Path: <netdev+bounces-173335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71924A58623
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 18:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 995B01880214
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 17:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDCC1F5846;
	Sun,  9 Mar 2025 17:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvTA/UER"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F5A1F4CA0;
	Sun,  9 Mar 2025 17:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741541278; cv=none; b=HksYpHA3rQb+mVC4Nu95Goguxpvb/bTVSHKx3WDDm4a8zw5qVOIk64FhoxAa8wunanY+Za8SKX7tPuIArUILDBZhPtvpJUzmpc+5QgLNh9YmbJ49PtCuq++lMjWoCEko/GCVTlR849HKGUuibzB7tjUL+hExOVSS72MGYBomU4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741541278; c=relaxed/simple;
	bh=PzdceJ+bG/4XrPO/7wWV0D1YWgp2D6iyTfJ0IeDpuU4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ViWKlWHAboiiCR8Lz/rSq24i3ooieBqqVfVvfxvME3due1RknvbkTyMQHUvg689B/6NAbS69lKDIeOhQB3SYK3lB/0LeozbvLk6MgCqkt5XrN7Lj4b/ftQV6TfPds5qR+3KfUFhqs3MNuPs4db2K9/rgmQrHv17Y2GaEui5xWSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvTA/UER; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39127512371so1890477f8f.0;
        Sun, 09 Mar 2025 10:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741541274; x=1742146074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mjF+FG5kURVzKYBbwEeIffikatQLM1KjL+4bR5mlF44=;
        b=FvTA/UERsiaoEQXyrDo03zkNiyW2YzySfjVJmlYVa0tMhsECXQHpcR/1ykiIbSiAQd
         6mH5mFMOdWPo70HSdM+bfaGl4gP9ARjuRNPLqICbWHEfVhsKelZXI2NIKV38HI8cdiCu
         59Ad4UnfJDQxT/tCT06mb2b4QzmxsIGEFFPT7I5AtWD3ZsHsTc159yu60eHCI68Z+JZz
         DV1NM5tC1YoJ95npJJ32dURoiwljpAKm69AqEzPhWB7fqq9+O3sPnXgTXi5ab6seXluz
         fvpd57xf2z2z24egERAHyGKjgdK4qBCUgxNvMef4vsngOuUooLOPXkO3Bbec786GY4rn
         ZKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741541274; x=1742146074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjF+FG5kURVzKYBbwEeIffikatQLM1KjL+4bR5mlF44=;
        b=uvLK5AcIhg44p3EmsOol1I1iVf+lsq8G9DTgaE7HYRpdu2pRWchOA5mMxfJHfaa33i
         h7tHtD9QDmBLol+PwA4YVqV0NlYO9SEaap/sCjge6Tt87YBl/QMefkOhCt/w5lJHxx78
         PCpZYBQDJGsImYgYm5ZcWj7tjzGQWZoJCkO3mjJl1j5ay/nq2SfHh0aEjXzxO//5ys/G
         Q+0GTX3SWEs/ckGRMXeEQoPcskdkQyKYWgR620xdiCLzQenT/wtFAzH5BzNdGES5OxGe
         dsrphIysENL1xYfsOcyaQv/iK1I3MRLOUh3kil3LUTKWQiIotTKEOaFA/EfMJEzt1d06
         +ioA==
X-Forwarded-Encrypted: i=1; AJvYcCUXFFdMI4I/jiDmUz4Cjsky10A33UtxlC0WBboGmw2/4rM8IgrfQFctXDtVtdj/cqLRfIV/HBkBLV5N@vger.kernel.org, AJvYcCWQ9rZM35CzicBbZS6nnC4Wh99BLT6efjDsG7Dv6qLmjIm7UPHl1R8ihi4ZkJJll7jCmGvdo+JN@vger.kernel.org, AJvYcCXd1/TH6ZUXtXXK8VwN1vhsTCTgd6Gj0wTN0+N6H6LM26Ld3qQqM0C8vG1mLZhBBo00XK7N9eME+o7JFFUn@vger.kernel.org
X-Gm-Message-State: AOJu0YxBN1WywzYKybZRD5RzQ1Bv4G+vSbwdy7vmzu7l+n9DCkkKUEGe
	QBLkE57AKTSqky0cHJBODv0zxDwqJwv2PqXsAcgA9Hk7gO54XOf9
X-Gm-Gg: ASbGncuur4FOX6eixIEkTikX5GlTinM+j5I6iA2IF+2vZSBGQB8FaslpZmUyilLs6i5
	zSvVMf4e2kXS8+yBDs0piVT8/KrXW1NP+6wlYFFnDdiyddj/04v8qgpIT5sictRQMdxuHfr2Zp6
	thcQqrJWuuEI2Gh3DDQQIJPy3R0E1rqrnD/zr9diVptYwV4tAxz4kYku35+9COB+uZEhA5AbxUM
	CEi4y4ocJ14bqdcnQWYMSKof1GM2q5eZ/6x33Q4jlXr9XY3FgL33enU4Mus+JtTVe+zLzpwZVEa
	zr44F8j+7SvyKcFtjqZ0fYYG8FH/4sC0MGZebDLg9gjGzrstY5X4IhXP2cO+41Nksudiq/bZO3a
	/AaE30lR6dyAL0Q==
X-Google-Smtp-Source: AGHT+IFtfdxDqXXA2G5tQIVP+5A9JdGmDp4Wkxt7tLFZwMIvzj00ZbodCqu7F1y3Wy6pDAAUQBU/yQ==
X-Received: by 2002:a5d:584e:0:b0:38d:cf33:31d6 with SMTP id ffacd0b85a97d-39132d68426mr6145575f8f.3.1741541273432;
        Sun, 09 Mar 2025 10:27:53 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912bfdfddcsm12564875f8f.35.2025.03.09.10.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 10:27:52 -0700 (PDT)
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
Subject: [net-next PATCH v12 04/13] dt-bindings: net: Document support for AN8855 Switch Internal PHY
Date: Sun,  9 Mar 2025 18:26:49 +0100
Message-ID: <20250309172717.9067-5-ansuelsmth@gmail.com>
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

Document support for AN8855 Switch Internal PHY.

Airoha AN8855 is a 5-port Gigabit Switch that expose the Internal
PHYs on the MDIO bus.

Each PHY might need to be calibrated to correctly work with the
use of the eFUSE provided by the Switch SoC. This can be enabled by
defining in the PHY node the "airoha,ext-surge" property.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/net/airoha,an8855-phy.yaml       | 93 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml

diff --git a/Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml b/Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
new file mode 100644
index 000000000000..301c46f84904
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/airoha,an8855-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha AN8855 Switch Internal PHY
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description: >
+  Airoha AN8855 is a 5-port Gigabit Switch that expose the Internal
+  PHYs on the MDIO bus.
+
+  Each PHY might need to be calibrated to correctly work with the
+  use of the eFUSE provided by the Switch SoC.
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - ethernet-phy-idc0ff.0410
+  required:
+    - compatible
+
+properties:
+  reg:
+    maxItems: 1
+
+  airoha,ext-surge:
+    description: enable PHY calibration with the use of SoC eFUSE.
+
+  nvmem-cells:
+    items:
+      - description: phandle to SoC eFUSE tx_a
+      - description: phandle to SoC eFUSE tx_b
+      - description: phandle to SoC eFUSE tx_c
+      - description: phandle to SoC eFUSE tx_d
+
+  nvmem-cell-names:
+    items:
+      - const: tx_a
+      - const: tx_b
+      - const: tx_c
+      - const: tx_d
+
+required:
+  - compatible
+  - reg
+
+if:
+  required:
+    - airoha,ext-surge
+then:
+  required:
+    - nvmem-cells
+    - nvmem-cell-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy@1 {
+            compatible = "ethernet-phy-idc0ff.0410",
+                         "ethernet-phy-ieee802.3-c45";
+
+            reg = <1>;
+        };
+
+        ethernet-phy@2 {
+            compatible = "ethernet-phy-idc0ff.0410",
+                         "ethernet-phy-ieee802.3-c45";
+
+            reg = <2>;
+
+            airoha,ext-surge;
+
+            nvmem-cells = <&shift_sel_port0_tx_a>,
+                <&shift_sel_port0_tx_b>,
+                <&shift_sel_port0_tx_c>,
+                <&shift_sel_port0_tx_d>;
+            nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 696ad8465ea8..45f4bb8deb0d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -726,6 +726,7 @@ L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
+F:	Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
 F:	Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
 F:	Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
 
-- 
2.48.1


