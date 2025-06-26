Return-Path: <netdev+bounces-201679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F686AEA8B6
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 23:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187121893762
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 21:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2BA25F7BC;
	Thu, 26 Jun 2025 21:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jo6RelAJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A793825E460;
	Thu, 26 Jun 2025 21:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750973036; cv=none; b=ki/zddgqf0zq9shcPhqeZNm5cb9tn/huiSLVKsSIDVmh8ZOlKEzi326BK86NQJyPYfHmBLVCHQgFFbqTfnV51hpke14Ddb5nEHGchXcvl+YZpKwvyn1cfe4ah7tGzVJIq321fdB89W+6BdHH3WGp8DjoL9aYm7UVnRNxi0o6eDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750973036; c=relaxed/simple;
	bh=fL6SMWKFNH/epD5gVrIManfsydu6j65zMzUHhIgMOZ0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VfIIsBbrg90ZyXV3+8C228RTzcIE1c0Z+GyVrTdZM+8d+F2im1fcIV1wYQAZH+QLKXYxtSNHw3woVpTnFf/lL6fcb+JiZgvzOWQcvDieuRp7GPZ0Fa61k34QmPVqE6qQgq0Qan8C21ylabPgtgB3/TAa/AOW1viN2D+O8IVcEJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jo6RelAJ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-450ce671a08so8626265e9.3;
        Thu, 26 Jun 2025 14:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750973033; x=1751577833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B9jOtwj6zr/UlgyzehUvwRXcqVoFIXeaFAL8YGh83i0=;
        b=Jo6RelAJCpgvns37tVMCAOLhciLleF9GwkcjBhcC7vDsLMuCipY0aJ3FH7hRM1rZdf
         UWd6xEa0YlwB9oJzn0yGaUECrweFFO1rWYrY80ZWpgsGok8cyk7YPUMeDa3nMPNSaNUf
         +AMw5nNmCaJNizE1NgMypDf8TJQkGCABpIL1Duk/t3XE4pEZY9KFaIKSMmso8DyLok3e
         5vmOtPexNtN+aKnOSreVOBuu8sWg+OMgMcUpjfpJqLYBBnYoh4KJhqjI9HQWJ3dgzUQr
         Ce3/6n9sfuVHAtDNWtlRqAXBKFbC8NOzEKKTJl40f37GTs7deDK7FfWcUKQoYWxtGlOn
         Ppug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750973033; x=1751577833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9jOtwj6zr/UlgyzehUvwRXcqVoFIXeaFAL8YGh83i0=;
        b=uoVOA+FuAEpHo2aDjS4guhbCeAsNaoFWqt0dm7k2dO4kSyArQ+bG8i25rfwuaztPAy
         Zt1dQ0xJ91VK8HvBQFISyv1dP620cRDUxUDrNl55xeqQRvnKbwHo52+wbS9RICeuNRQI
         8YuV1DI755M1fW1mpYaf+8GrDtiQzx//2SOEJHtwNWYICLfRQEvxaAlLpFjAyW1pPTcf
         w0poyLWafN0uxxINsjZQrMPFTws7tZwiMdwVIXof5VUWfT1/CfKeYUCgFvQPqNGkGf2k
         Rf6DKAtf5w5dGrP9bo0cvbUddUjiZdMM/SKyutox3+T/SZUB8cxEZP8YY34hqSptHJIn
         hR6A==
X-Forwarded-Encrypted: i=1; AJvYcCU4J9vZ4yiLl472u4oT01y7CT1C1KUdqbMxmyK9JGv+7MXA8LBs0Q1c5MwK/FLgmcuiZbNv2i2lm1c9@vger.kernel.org, AJvYcCVqvvvxBPmzh4eN1c1bJANGgKm4S0YJwQGSTsYSdTO+x5v3Kq1Gm0gZBkUOlPG364XRjPJ2q+ER1WJ6djfw@vger.kernel.org, AJvYcCWJxXwtdkVc/9PIbsmQHXH8Vy8/e7C9EdrObxu0hO1RRE1dqfkrdsXae5i1BWHLNYHNgpS2KalD@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhw6S1xSPI+REM4oLNjEEIYwXvlWHR14kxbByeniisc5RjSuXD
	wadd6hAEn34r4z00C1yyqPhit3KY0oyJmf9VmlZJYQkRCVmxeVS/XYtK
X-Gm-Gg: ASbGncuGtcbsTBC+59HYkFsQPclfD96GFWtuNqHN0ek4x18L+jJSizrTWRjw7ISDths
	uaTfOu8ebasExeYBuuoK4dGNNcW4i1MjZdYhgTKikHIUoFw//sckKB5dGcYsSPi3I0po5ORq1WN
	9HgeSlLodPiBu9+GPVJ7pRh26unwaPjDZZe+ZOr+LorCj9JnwstQcpep428eGLgMeT8ynfM82Rw
	dLeddWwPGGJPoXkwbrr/e0HfpPqJMg9HdZ7i4IhIHbZ7jQh+0tKxNGLiDauPxR8auedPKCcsIVC
	8D041Fj65bY/q0EI4MW54bjnzQ604EVtAjEryI/s0Q66snXoAv0Fxaqinn+pLZBDvOCdmsEn2Wo
	WuzchwEoETpJvAnRg84Rv3KusS7HterQ=
X-Google-Smtp-Source: AGHT+IGDm5p4AvWVcr/tRWVfaBImDogqux+W5zqeZhlGIcThn/cb4rbmaTZF7QOp026vECvdHQ1fMw==
X-Received: by 2002:a05:600c:502c:b0:43d:160:cd97 with SMTP id 5b1f17b1804b1-4538ee709e9mr6059055e9.25.1750973032660;
        Thu, 26 Jun 2025 14:23:52 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-453835798acsm57186475e9.10.2025.06.26.14.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 14:23:52 -0700 (PDT)
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
Subject: [net-next PATCH v15 01/12] dt-bindings: nvmem: Document support for Airoha AN8855 Switch EFUSE
Date: Thu, 26 Jun 2025 23:23:00 +0200
Message-ID: <20250626212321.28114-2-ansuelsmth@gmail.com>
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

Document support for Airoha AN8855 Switch EFUSE used to calibrate
internal PHYs and store additional configuration info.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/nvmem/airoha,an8855-efuse.yaml   | 123 ++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml b/Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
new file mode 100644
index 000000000000..9802d9ea2176
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/airoha,an8855-efuse.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha AN8855 Switch EFUSE
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description:
+  Airoha AN8855 EFUSE used to calibrate internal PHYs and store additional
+  configuration info.
+
+$ref: nvmem.yaml#
+
+properties:
+  compatible:
+    const: airoha,an8855-efuse
+
+  '#nvmem-cell-cells':
+    const: 0
+
+required:
+  - compatible
+  - '#nvmem-cell-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    efuse {
+        compatible = "airoha,an8855-efuse";
+
+        #nvmem-cell-cells = <0>;
+
+        nvmem-layout {
+            compatible = "fixed-layout";
+            #address-cells = <1>;
+            #size-cells = <1>;
+
+            shift_sel_port0_tx_a: shift-sel-port0-tx-a@c {
+               reg = <0xc 0x4>;
+            };
+
+            shift_sel_port0_tx_b: shift-sel-port0-tx-b@10 {
+                reg = <0x10 0x4>;
+            };
+
+            shift_sel_port0_tx_c: shift-sel-port0-tx-c@14 {
+                reg = <0x14 0x4>;
+            };
+
+            shift_sel_port0_tx_d: shift-sel-port0-tx-d@18 {
+               reg = <0x18 0x4>;
+            };
+
+            shift_sel_port1_tx_a: shift-sel-port1-tx-a@1c {
+               reg = <0x1c 0x4>;
+            };
+
+            shift_sel_port1_tx_b: shift-sel-port1-tx-b@20 {
+               reg = <0x20 0x4>;
+            };
+
+            shift_sel_port1_tx_c: shift-sel-port1-tx-c@24 {
+               reg = <0x24 0x4>;
+            };
+
+            shift_sel_port1_tx_d: shift-sel-port1-tx-d@28 {
+               reg = <0x28 0x4>;
+            };
+
+            shift_sel_port2_tx_a: shift-sel-port2-tx-a@2c {
+                reg = <0x2c 0x4>;
+            };
+
+            shift_sel_port2_tx_b: shift-sel-port2-tx-b@30 {
+                reg = <0x30 0x4>;
+            };
+
+            shift_sel_port2_tx_c: shift-sel-port2-tx-c@34 {
+                reg = <0x34 0x4>;
+            };
+
+            shift_sel_port2_tx_d: shift-sel-port2-tx-d@38 {
+                reg = <0x38 0x4>;
+            };
+
+            shift_sel_port3_tx_a: shift-sel-port3-tx-a@4c {
+                reg = <0x4c 0x4>;
+            };
+
+            shift_sel_port3_tx_b: shift-sel-port3-tx-b@50 {
+                reg = <0x50 0x4>;
+            };
+
+            shift_sel_port3_tx_c: shift-sel-port3-tx-c@54 {
+               reg = <0x54 0x4>;
+            };
+
+            shift_sel_port3_tx_d: shift-sel-port3-tx-d@58 {
+               reg = <0x58 0x4>;
+            };
+
+            shift_sel_port4_tx_a: shift-sel-port4-tx-a@5c {
+                reg = <0x5c 0x4>;
+            };
+
+            shift_sel_port4_tx_b: shift-sel-port4-tx-b@60 {
+                reg = <0x60 0x4>;
+            };
+
+            shift_sel_port4_tx_c: shift-sel-port4-tx-c@64 {
+                reg = <0x64 0x4>;
+            };
+
+            shift_sel_port4_tx_d: shift-sel-port4-tx-d@68 {
+                reg = <0x68 0x4>;
+            };
+        };
+    };
-- 
2.48.1


