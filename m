Return-Path: <netdev+bounces-180122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB72DA7FA53
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1E267AADDE
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 09:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBD9266EF5;
	Tue,  8 Apr 2025 09:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ax8sJgd+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C9D266594;
	Tue,  8 Apr 2025 09:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105938; cv=none; b=N9Wqi+SyByJA1xHCxeuSFz8eX//dIIiTI5pZ/A27xLsLyJwy8Ane7GvQnYa8m3xUcjoJ5hwZUGEbI9cwg6r2gZ0yoHw9Ohh6drEMrmWi0G070hkOEEVO9KQncU7cwa4WlsWRh4Jos41C6B8XDraccwJ9cYNKzaptFLtXwKAwFis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105938; c=relaxed/simple;
	bh=fL6SMWKFNH/epD5gVrIManfsydu6j65zMzUHhIgMOZ0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ayNWqAjuD9vJ3UBSNdJVW9tnS4HbGjuqIqht4qGnLYRK4dxm86YE+QsELkK61rhESPOjM7CPN869nd0f9SEnvDdVfVvz7URyq/ca/NNKHRnm/WLYOPMtB+wvHORQbPWZOaBh6tfb2jmNqmdUN5NeFrTn6AInEAFAHqREL9oZG7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ax8sJgd+; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39bf44be22fso3555928f8f.0;
        Tue, 08 Apr 2025 02:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744105933; x=1744710733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B9jOtwj6zr/UlgyzehUvwRXcqVoFIXeaFAL8YGh83i0=;
        b=Ax8sJgd+jg1fcXCAEjMgmhAOSf9vooh3WLrJYB44tWxmmikJWzpTYWxXteQlLS7uix
         JZlN0knRGEYDS/DLaKxvBvSEQ+Mvi/FF5p/CRmnNl51mMg+M9RFCiifrfuQeguH9Bk7V
         gPdeB3kaggk5c7aDfXT/Wivw68TsKrCrOSBKSTJ42ultu0EUoIqMqDFliSAGS8qj64Be
         gUczEW84lmWkZ8oIMfTKp1fXg3FI6V/UCIuXEcGsTYhS9ey32fiK/2bH24iBHk08co+l
         8q+xa1c01QAUQM6oxZW5iCI399lbhcBvGWSsd3edaUexwPVABGXv8MDW/hUcofgmfBi4
         xuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744105933; x=1744710733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B9jOtwj6zr/UlgyzehUvwRXcqVoFIXeaFAL8YGh83i0=;
        b=lp51QhS6esv8bBtefoFFNv/052C+b4m/EDfgWAQfFomI+DNC0EfamQyxBgQOtACVQO
         XCE5mQGp+bUL0gjsqdH4y4ODaLg/gociaLn3iSlcQce2eDvCnlVylycr/lyGygYLUl/u
         OY9oE05jxjbNm3FzQbV9YvzVfRBc9FGmJJ2IFP1Brd3ZuER7fhgWyfpx1CGH0C64C0kP
         sj3r27+Oal955fXGLZXp+E3r4EowCY2PHhTR95PQbxhWePG0FuztPV9oezUDsvWqDBcL
         qwZoiaioqVpQ6niXJ3d4ungkbk7ruglePcXZsvThs80rrKDdTgUfkvwT5Wkw6Ia9VWRD
         +mOw==
X-Forwarded-Encrypted: i=1; AJvYcCUCQCOSC/v2oSJ9CkeM9/5oD8Qr6Q+Xyu8Hi4VLa8RcSuyZJd0TgIKQqs5L8/9GxDUABTsDeLt7Y3po4rS5@vger.kernel.org, AJvYcCWSIGNubikUw+WCtbxHbTAD0HQ4wlN9FSAkbCF+wY06qmSg/jJnYGOKF/+fLjpmn8q0fxi2WrMc@vger.kernel.org, AJvYcCX7howbVhvTahOH9kia5c+dREj6YXCpMF/jTOtDII+fcO3wvfH1AcDr4ngRu/kUBI3tEZMzWB4mlQ5i@vger.kernel.org
X-Gm-Message-State: AOJu0Yzulo5pZKuk9q0OQ5pLGQyqBToFFhvy/Fy2cErruMl4WsdxgKFT
	CLZDGlKv5W6fjjlGu5xqD4PpEk1Q6HenY6nFRlwDuY1qfzGOOWr1
X-Gm-Gg: ASbGncteTvEvaAXSyBcMIKv/ne/TvWFmuVtJplB7HH0kHbiERnK1g9uwNG508f6l2PC
	+v8hH8tM08uA23eF+ObD5MDin1jZxFxb5R0b0inFbqkIj+nT/PFC11GBLpUTtSpmu+SsfznWNmB
	DOObH4x/31cnAeZkp6AJPMblc83O25bxgVSDEYeoO2FrLCjV8+9VlWzWLtKamqPd5ilopHTK60d
	lMNleapwBYq4RwXd8qmpdPeTpxNuEvX10B7v7zNv/10bQXlugQzwJUlu4KuU/hJ0TN7wYrUleLg
	Xtd0YcTY6yt3D+sHJ6+p93Aw5Y2cXwX2E+jpsVOjtEp8BoLsEjLjfTOiU8m2BnAnu8OIOmfXJOo
	vB8Rdl08uOVFFfQ==
X-Google-Smtp-Source: AGHT+IFwQXlkEkiv59tTOoBNbBWxAd5ev/Yt4wKxTnHPQXrrp31uVElCwlox+riOCqLgnYPJvB/0CA==
X-Received: by 2002:a05:6000:1862:b0:39c:12ce:1054 with SMTP id ffacd0b85a97d-39d6fc00e59mr9843048f8f.8.1744105932837;
        Tue, 08 Apr 2025 02:52:12 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39c3020dacfsm14493310f8f.72.2025.04.08.02.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 02:52:12 -0700 (PDT)
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
Subject: [net-next PATCH v14 01/16] dt-bindings: nvmem: Document support for Airoha AN8855 Switch EFUSE
Date: Tue,  8 Apr 2025 11:51:08 +0200
Message-ID: <20250408095139.51659-2-ansuelsmth@gmail.com>
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


