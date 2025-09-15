Return-Path: <netdev+bounces-222983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB6DB576F4
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 12:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D3B3B4BF1
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 10:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2472FE593;
	Mon, 15 Sep 2025 10:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmS1tAYG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92822FE06F
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 10:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933163; cv=none; b=HrpnU22PVDIZITOR/G9MXlVN52PQfpcXqc19cvbvtpzjhWQZpjbioh5KU0p6shi8gLtQOauZAzShWwUGTFwnvmeyXwQFjtUgJ+ekg1MTWZAmE/F/cuAXYTscSvS1DyMqRywJYTfhLb0jIeOB7fenMmNaXoNP0PgWOSHKkf9twCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933163; c=relaxed/simple;
	bh=MZ6PxAvurXG1uH1QIJpzbJ63J+I3jr0ROI56K6VM/XA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MDAGAsm9nPIUlBOz3tqIowOp3280G3S1PB5k9nRTiOOFfpiBtMcItX7v3cQWgmQOHwcSJlm983rMYt2JrTD5CP1Se37iAow/4DGj+gvtMLSO8lb4O0vsOapNS5kd40gQzweRvdwBOzoEA1HdpCf44tBVatMGa7aN8YPuRoMsKfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmS1tAYG; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45df7dc1b98so27510615e9.1
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 03:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757933160; x=1758537960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S1Rt7Xhagla/1sOuAXTb1PZ0PCjuu0lMg8zPkfBBc8c=;
        b=PmS1tAYGx3YFhUrmcRcn78W0kBTXP+8FPEImz2UpvnpU9ktwkZxD+v41qXtG6E5SM0
         w6eG9OShEVgGS252a7Qmw7fsnxyef6EETkOyoOwu6IfibI301jxV0JXGc8L0SmOcEJdR
         +F8wTystCjySqKiNa0aZZqUEIdCsRKQC4cIMryJZQPzD/5vmlYEa66RmcZ/nLPHmruqD
         00T7srAgTVqJ/+aAdCkN8YBNL+muhc2UR8f8c21jNohA9KJM1Ya4yEIFmG3daiWbP9ND
         OMKxd1mnn2Cq6KLTTAMkTI0SgK1NxkWeQOXi4hWh7x/3iDNTiKVULPNShLbY8jVA1P6Q
         ROkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757933160; x=1758537960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1Rt7Xhagla/1sOuAXTb1PZ0PCjuu0lMg8zPkfBBc8c=;
        b=c/LarCeGAxyvKnEi9QRS4nocw0uECO25bfdMCnS2EbEjRUx7ig1MBE3Gg/kUoCMpHw
         fsj9AADMKRZJprA+Q+QlJ82kGK/ibGfiPZ/seXGZBoDuSG9VBya7DZUUjzXX5lScQJ0Y
         4TtBjl818c/41i48xOpZX853bYsWGGJvMhEeJ+nXcDb7PJEnhPH7FoYNFUrhRaL3WmVT
         uwyAVnMFSUXAcqT6P2uda2Vo34/MBTvRawpp7CpvEHcyU/m5wVWgXqTh1PlUfQ1DxuVB
         iSb9OvOhjYB5kRhmMs1TIfazugV63RI5v0t7u3IqhPINtrWWdrYWRYqr99e2WWFXDvFn
         sMyg==
X-Forwarded-Encrypted: i=1; AJvYcCWGPpI3AT3wnzJIadWHwoOnl+FNJQBfeR9SD4Yc4MB5sjjno1kNcT+v/Nh/lXvS2cETyIzy+IU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz0xeXqInZ0iPhJix92Wzc5I8RsEOHri62rrPKzDSPmZBAz4lD
	bvJXHWHp3v+kqUumnRqSSf+JnVsZm0YlGZI+i3bkJubk7R1QNy0qVXzt
X-Gm-Gg: ASbGncsSqkBfQsnF3FYIYmI9peIK+k8qCHhFGzdB5gfLqBF9hzGSRmX2ogAKTtq5aDx
	h541B2MBHRx7QpoHnQQtN+RHLmtPI7tKrFtxIMuOaQ/+IXetkL2eDlJ+XyNwWCyiRZgbVTgs261
	aNvnJsLFs89gZdIqqceXQEZ4ev7q/yR/uoqqTAjp00k2oXf1BDyrxezwNhIk7peEOnZ7RUdZFHo
	Off31j/hJkI4nR0Nk9Z+9Irfx4qfLuLVWXRfDCSsiH0MPmAQekzH1DoxU9uDEWJpDzxLSu9D6jU
	t9+oqK6JkEWBBo5ccVKIbgvRfBb+WnfRsa5eY1ldsjHsP6B+UlpxDe28TG/2K9Haml2DxyUMfyy
	jQwsW5IVRnnt3CnjcUjQnuqT48kXKyGQnRv9vdhXEPwgu2gs65zYn3VMMsZOU9KvRy0/7o7hCj1
	tfWy5gjw==
X-Google-Smtp-Source: AGHT+IHn4QLGPQ32OnxYflof94cfwBR4YL3okJ8ndlhTf6v4TgxqEb87g0moZGj6t1FQ3d/i+gVHEA==
X-Received: by 2002:a05:600c:4453:b0:459:dde3:1a55 with SMTP id 5b1f17b1804b1-45f211f2fbemr135949525e9.24.1757933160050;
        Mon, 15 Sep 2025 03:46:00 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45f2acbeee0sm67163365e9.0.2025.09.15.03.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:45:59 -0700 (PDT)
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
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v18 2/8] dt-bindings: net: Document support for AN8855 Switch Internal PHY
Date: Mon, 15 Sep 2025 12:45:38 +0200
Message-ID: <20250915104545.1742-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915104545.1742-1-ansuelsmth@gmail.com>
References: <20250915104545.1742-1-ansuelsmth@gmail.com>
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
defining in the PHY node the NVMEM cell properties.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/net/airoha,an8855-phy.yaml       | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml

diff --git a/Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml b/Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
new file mode 100644
index 000000000000..d2f86116badf
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
@@ -0,0 +1,83 @@
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
+dependentRequired:
+  nvmem-cells: [ nvmem-cell-names ]
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
+            nvmem-cells = <&shift_sel_port0_tx_a>,
+                          <&shift_sel_port0_tx_b>,
+                          <&shift_sel_port0_tx_c>,
+                          <&shift_sel_port0_tx_d>;
+            nvmem-cell-names = "tx_a", "tx_b", "tx_c", "tx_d";
+        };
+    };
-- 
2.51.0


