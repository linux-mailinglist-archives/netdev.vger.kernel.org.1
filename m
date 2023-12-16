Return-Path: <netdev+bounces-58277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D69815B67
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 20:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1361F23A70
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 19:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB00328BC;
	Sat, 16 Dec 2023 19:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLaHngSt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1878321AD;
	Sat, 16 Dec 2023 19:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50e2786e71fso779639e87.0;
        Sat, 16 Dec 2023 11:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702755820; x=1703360620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vj41VeZNQFyL0rSwdtm6vNaa3BhzpzPMKgY30VuChQc=;
        b=KLaHngStkinQQx/vI5C8crfxThL0jc/1yjIcKcMHR6FFQmvV0dQFzoDX7Lu3HYy4p+
         uc86QRMaonIhGfjNGVdDchYQ924vrDbGvesqrGBjro0R0ecUpUk47njACdcKKLjnd6RH
         x/pxlo9VWvIGh0qVw6MdUDGDPQc1TfYH+troyQeIm2StCkvTAeyctEM6DwqKQfAhhNDV
         MdDF9LA2OL48B3sarXd9m5aTYujdKjixMBD96VPRzxnZB8e7Bnffbby78CnuVYkShsAB
         GiI67rNFyG6Nk2eiRAPJpir98xHmH2uIjfxvRqPe4wIpEYE7BncRbEHgsWaTRWpnfFM+
         kJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702755820; x=1703360620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vj41VeZNQFyL0rSwdtm6vNaa3BhzpzPMKgY30VuChQc=;
        b=ZHjOk+3y0+LVMCV5fcu8pZEKRlhNLUkYplw1Sp+jv3g2+wruz9lNGxtkqTMUER9koa
         zG7e2zrXkVCNPUiCSnOydtX9w744bOU3oF+1yqtI5AFb4nOPqC83wMcI4SF+Vl4q+3ab
         9x+0Wj/1d4Zc4zrvZ59J+fBogBONptkcvD1uKu9zED2IPhQyABK/VBPEszUZxrPREQvW
         NGrZ/D2L5Obm1x3qVRNWVFhdgM38QjLcKVnNYfkvGT/2zb5YNnqDuYvvtYY0Ds+mnvJ3
         vpzHzdfYlKxummL5urUvY48MPu2B4qgYzRDoAICMsYSyUahshAhlMGTh35ASK/HEV1kL
         kz9g==
X-Gm-Message-State: AOJu0YwNY2IAtqsL6S4nZRV/2Yk1cTkehPQ9vlxcrYJGln0uzXx51B7U
	M51cid9Qt6shalteWBOLjjKFBPYs3R95Gw==
X-Google-Smtp-Source: AGHT+IGcHXIm8/rGlCOZxHVfo4xhSoyRmjgqQ+uOot+goQUBmjligQW9CUbSvQwO6mT2uymAWgfBHw==
X-Received: by 2002:a05:6512:1294:b0:50e:19ac:89ac with SMTP id u20-20020a056512129400b0050e19ac89acmr2793217lfs.22.1702755819673;
        Sat, 16 Dec 2023 11:43:39 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id t16-20020a056402241000b00552743342c8sm2781953eda.59.2023.12.16.11.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 11:43:38 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Lucien Jheng  <lucien.jheng@airoha.com>,
	Zhi-Jun You <hujy652@protonmail.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH RFC net-next 1/2] Add en8811h bindings documentation yaml
Date: Sat, 16 Dec 2023 20:43:17 +0100
Message-ID: <20231216194321.18928-2-ericwouds@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231216194321.18928-1-ericwouds@gmail.com>
References: <20231216194321.18928-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The en8811h phy can be set with serdes polarity reversed on rx and/or tx.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 .../bindings/net/airoha,en8811h.yaml          | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,en8811h.yaml

diff --git a/Documentation/devicetree/bindings/net/airoha,en8811h.yaml b/Documentation/devicetree/bindings/net/airoha,en8811h.yaml
new file mode 100644
index 000000000000..96febd8ed6fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/airoha,en8811h.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/airoha,en8811h.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha EN8811H PHY
+
+maintainers:
+  - Someone <someone@somemail.com>
+
+description:
+  Bindings for Airoha EN8811H PHY
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+
+properties:
+  airoha,rx-pol-reverse:
+    type: boolean
+    description:
+      Reverse rx polarity of SERDES.
+
+
+  airoha,tx-pol-reverse:
+    type: boolean
+    description:
+      Reverse tx polarity of SERDES.
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethphy1: ethernet-phy@1 {
+                reg = <1>;
+                airoha,rx-pol-reverse;
+        };
+    };
-- 
2.42.1


