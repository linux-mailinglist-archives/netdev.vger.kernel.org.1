Return-Path: <netdev+bounces-222139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD3DB533F8
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 15:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A98631CC0ECD
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 13:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7BE32F770;
	Thu, 11 Sep 2025 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ie0IrCed"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B8332F76A;
	Thu, 11 Sep 2025 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598001; cv=none; b=UZotaVaDQC91SSETPYe+14ImnABt2XhGp1AGl4a972cCGmvPD67BFRwML+IkLxEsQPE6xYc2sZx/yekgZWPG5adtlAgJ/FdnRPB5QMdRhZP+p57Z3s+cbUeJJy+k5Q3WhKsndWjNs/dodOKxkgqhU3jYQ59luz/uqQBZsz4lvZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598001; c=relaxed/simple;
	bh=wqevN31+I7OZyioOqIjvw7gifqeYlgUgcrFM85GtAGk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RH5U1lhU8LgXg1mHL26Q0lB11i6ki0UjEj1YnfSexeoObPy5xdC+POHZpcaFYEy/+gxqSj7yq6BQ9955D9M6BOhCr9WrANevRolGorireYHHo330v29O2C7QCJIIf5263V80nS+VdqOKAIz8iNfZjg2Mil99nCIsXIazhkEc05U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ie0IrCed; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3e2fdddd01dso206680f8f.2;
        Thu, 11 Sep 2025 06:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757597998; x=1758202798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PzHcQ/oRDwg8w8+eycKtwGCbh/9deoJe9kKuhzidedQ=;
        b=ie0IrCedUsjecpfGShu0Rx6dT3oCy35s+pta3RTU8XMxfAQdRhwuw9cRP8Ql3pLtth
         22eMvdGu5s4iM8AM/nXqre0SVQbspg826GPPUa+s2VgBD4/sE89KGT30w2J8vuCNX+AE
         6H9EtPZY5RD77E4wklqM2Gk46shGmSZQlJl77sbwbexiI+D7wk+I1O0KB+FGlW29YcFB
         VLVjfbjrcOP0MkiLHEAV1qWfVKfgYK1TyGqyiJccAMLQus05QqaSauj+2O087dRH/F0A
         dc9MS6f/aqU2rHDnSIFgWvTanXQ905iwYZ8A/EFvGBfiQ38I5KUtQjy+vnBFvKzt4Dm7
         76cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757597998; x=1758202798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PzHcQ/oRDwg8w8+eycKtwGCbh/9deoJe9kKuhzidedQ=;
        b=fw/Yc47md5njYIdQ5hxZSkqHhkJMrwcQ08h95hnC855S4bDcqSDbKNgAQiLVxQc6Vp
         yJSuJMpXWKhlY7B384kKIkX5kjUOXDBu7ZufaSU3L1Iq4aJPZskd1DQ8fg3p2dgFwn9T
         19ckwkNXEdVl+Dr/+QRexsVRXo1G+YIOItYFwjpDqWoKZ9RvvDKywSopXnNgozC6Dc2Y
         61zBJFdwW5hFiBXGMwJXCaoo+TdkEuWZw5T0zDrv10M6RRAuAHNXCft+IyeDYSN7bKQv
         ga7jgXOHGbB126Y3P9Z3Ia9lY4fz9T8zQTCkI3buYRqY0EuACwMlovVoCiWCIBrLUkv6
         FBSw==
X-Forwarded-Encrypted: i=1; AJvYcCWLo0StgCeVDjySw3fgKeEi7PbsLs7ZmBHOgwEQIMo1J47csMOiWHAHQHQZ7rrn0cU7arwgbOa5@vger.kernel.org, AJvYcCX4sKa03CDtfqNeZuK3+FErUBae6M5HSOsXrikEPckQmUK/zCyKXSqlxooQyoLjNHoRLrH0Se/Z3ufSJ67F@vger.kernel.org, AJvYcCXjfP5gHmCQx7xW/SkSfov9ktEH73dxscQVnnTpxYpuBPSUhEC8HUGyhqYc376GWuFXDPojIeRx77QU@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7nMu9ryBMU+PxORyJCnKs3sXky2JoyuPSmnskUQ+QGVN618Nq
	UtU/wt3id7Nti7bJa+mBaiM2lJ3+e6mlrT2nn3rQVS+nOCyFm4NTxXZC
X-Gm-Gg: ASbGncupBRhFiNIrd2oVSUsCSkLuTWZPLldeVd2+q//+ZGtADlwgufQrQ4s/tq7xTyM
	xYN0YLEDi0fOXpibIywvo4A03X4dGqDGsy3enXj6PcXnL4t6yevC3FBUWfERjaIBRwLYnSdSt7X
	EdhS6M8SpbUmISlHzOTShVQ/W7U27NAOvBkVgnBUNwWgzx5QjAxozmuIlgpUFvGsJTiYS27aoYs
	UKgQShzJcZa78TjpyQ8GlPV41mg5sLL4y8goJqfLK5cy1E3AqQwuJ84f3ool6Swx9y5c5n4sCql
	Y4C2YO4AI7LUpcEZqZucOxiogzDSAMviop3i+lXTpUjjkR3DTc5wD/SIr7+mIqTOH2bDtlY+5uW
	DhWsF36Amqbj5fYpmqfOrH6fNb5fRBTqFdW4BnRbpyoGjKhAGMIzEzxyG5tY2o6xdmfDpWW4=
X-Google-Smtp-Source: AGHT+IHt78OUtg6Hm5nCYAHA3ij739YiNjPPViAgVLSIcJz1QECNiFuOyCXUze29kLC2iFDge+11tQ==
X-Received: by 2002:a05:6000:4211:b0:3e5:d2f1:403d with SMTP id ffacd0b85a97d-3e6440ef05fmr18685724f8f.36.1757597997739;
        Thu, 11 Sep 2025 06:39:57 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45e037d741asm23413475e9.23.2025.09.11.06.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 06:39:57 -0700 (PDT)
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
Subject: [net-next PATCH v17 1/8] dt-bindings: net: dsa: Document support for Airoha AN8855 DSA Switch
Date: Thu, 11 Sep 2025 15:39:16 +0200
Message-ID: <20250911133929.30874-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911133929.30874-1-ansuelsmth@gmail.com>
References: <20250911133929.30874-1-ansuelsmth@gmail.com>
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
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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
2.51.0


