Return-Path: <netdev+bounces-58279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5CD815B6C
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 20:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C6B1F238CE
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 19:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B130E321AF;
	Sat, 16 Dec 2023 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iE/anO1+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D5E328A6;
	Sat, 16 Dec 2023 19:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a22f59c6aeaso203974166b.2;
        Sat, 16 Dec 2023 11:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702755910; x=1703360710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vj41VeZNQFyL0rSwdtm6vNaa3BhzpzPMKgY30VuChQc=;
        b=iE/anO1+GlGjkgWaxGIiMcFoAdCJ5gsDYeLxd31Q9N5i6bfQpDbaTCuQ7Zw0Eh7NdK
         byHCPjGI5ErQkOpZgHawGb4p8xChR38BCN+AtR8Id5Cy+88KdrfGlZNIQPQONInCb8YZ
         AVAS8OKiTKPHyEhuWz97sO8IzrVCS18gsxMPw1AIQfh51xy3ayiHW2gMKv7QEFb1nPTu
         HqQvykzFQ8t97O4IRC5U0pyTAhW40LiQMSFTnUQxXRnXDXfFLuuEmfgltoignfj4pWzu
         AtSkreOi3m9moq17UaNQk+UDWfX6CCb9ad/UZCIAfShB1R6NMXT2jMZMgpV73f9etva8
         Nlmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702755910; x=1703360710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vj41VeZNQFyL0rSwdtm6vNaa3BhzpzPMKgY30VuChQc=;
        b=LRf7uvG1hJ4+EFH+w5WrdPxAg6vmnGmY1//tNyoGERVKMTzfDlFLCvmqBtkyYpshUq
         H10JtlRxPP5WObj/b7qzgXncHzfHDLs2Af/m2Nm/1w7bUPH5/qkAZY/DfDBxO9IHhMfh
         DBFl+DJysNP8PpO5djLzHGyFt642/zzFPzK0xt5MQiaUQRxY4QEMILZDCNlBTRAqqucu
         rTp4IDnII0DdFVRlVMlqeBSbNXP7OlAFpzeJ8VYebNWPLjAUYGfbNHzJZmJNCnY8UOFy
         CY5Ni6VcivhoUT8wXbFB+K0ofP9E0ZowhOBmZYmYIbAIogqNcUd/N4GXTSmoZWA3ybVj
         WRpA==
X-Gm-Message-State: AOJu0YxWiLSb9miNIRilZoLNGADwqVkT4ACV9qOAK0Bv48DrFT39ddjs
	ulWDS+MciDUjabVJSSZU1q0=
X-Google-Smtp-Source: AGHT+IEYBDRJyWE/t05L1R2LOLYnbmnq/+bNe3AIAANo7bxOB4TuGrYVe81ACdezWahp02FC7qldgQ==
X-Received: by 2002:a17:906:74cd:b0:a23:1000:56a2 with SMTP id z13-20020a17090674cd00b00a23100056a2mr2106350ejl.12.1702755910210;
        Sat, 16 Dec 2023 11:45:10 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id rg14-20020a1709076b8e00b00a23002c8059sm5211196ejc.70.2023.12.16.11.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 11:45:09 -0800 (PST)
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
Date: Sat, 16 Dec 2023 20:44:29 +0100
Message-ID: <20231216194432.18963-2-ericwouds@gmail.com>
X-Mailer: git-send-email 2.42.1
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


