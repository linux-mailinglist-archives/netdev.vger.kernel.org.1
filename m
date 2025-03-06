Return-Path: <netdev+bounces-172309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 462D2A5422A
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 06:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5C7E7A3BC9
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 05:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631FE1A727D;
	Thu,  6 Mar 2025 05:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZqwIb23"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00531A2846;
	Thu,  6 Mar 2025 05:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741239116; cv=none; b=h6SVP88zMCdP3xtPKmu47yn7d9zjI4KVhtGqO161zcDuTYxaPr+d3q0LCqhaxckcjUYgZqBYRhf6wnBnHxACQAn6bVGqkcJLdttD1X2TuufxjSHUuBAaNVYhvEYvuOhs2pqiu9Y4F8Jac5K/3N8JX+focLVkhMf7TFAEVaThbc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741239116; c=relaxed/simple;
	bh=8ROhfOx1dZXMzd/J/NH+P2v06NXrcGFScq6nUz4t7lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WI2S6v+AkJRGTlpR1I48gyRzjWRCRNrRyz1SBB1hRmBHh9xaRUTf+xAgMsKHLUruEGlI+e8YQcM+u8zCOJdZyJe+jMtSW12MtcgjgCgKh+tAU2OUFsF1skwjQgodUTYseFh5cMEUkHD5clG2XpN9iOmno9b1QuKX9xpiYDGYwMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZqwIb23; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2235189adaeso4308115ad.0;
        Wed, 05 Mar 2025 21:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741239114; x=1741843914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dewp64/KSNaOuX5WwZpls97smF8ZBQ6NIUWA1VX9E64=;
        b=fZqwIb23Fov3jQhxAeEkUhWP7yO4Ys9oez/Hl1684o7NhzS0Lz8feQxocbUW5ufCil
         P/YwbUIPqvq+9dSjFq7LqG40DbCsXwvWRK9ldtgZtsG7n04l41oy4r7kbDjQNkEHUL+V
         jFf6KnqoYa12y62okXWIqiI19D9GRdbQoqgKNJSsrhHA6N4jS1Eh3guGliLMZ0xAHErh
         OOHNTy7xUhJw3Et5CznBx89PCfxvnbp9gZ2DdNhHsJZZWcQjKdiTITKLQ+J4pZFHvY1t
         9pnLTDP33AqPOfxPhkiBl68wze7/QqXsu3gkzzjy0MtqkeJ02RmCC/u1ms8pyP0D7G0p
         H2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741239114; x=1741843914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dewp64/KSNaOuX5WwZpls97smF8ZBQ6NIUWA1VX9E64=;
        b=pKnlgFyO9Z/N9Ygs1RxzCv8ONABWaSSeqwqjhzEQKtsy+HnXrzYdH4iOpdaTfDJWqG
         5oUouEyBXYYbgaVGClIMKEzPwSFGbvhS8UNDdrZ0vFNZ4eckh3WZnnEaFJ9rYLBOLU5L
         Uf/p+7/eagIcnPwr2YY1pwQZxv+ZgR2AOWsgxxVB4h/V0vB0uH9zdxLbyHSVwZ1/RShM
         7S7/F2weTfHUKDOu/Q8Xzczz9Q20dAcTgbt+7VxaTrNEerNcE1KvXpfN308SeXOSmvNm
         BnushPX4LVv4qNw42Yf8LIiN37Y3eokUelCmVMfe1OeS3vP9EjmyzO9wPf9Gj0KPv8wW
         wiZw==
X-Forwarded-Encrypted: i=1; AJvYcCWAuxu668mM7k9ij4/ilgch9iKKm40EWQA3S3mKJrySpmr/0o7fOm9yBClHSExpZJlMN6yrSf6k@vger.kernel.org, AJvYcCX0etoH9h9xENv7s93LXM+euiPbaaYbBkkxoVgiGw39YBAlic6e55f76wiUth3qY55CSh+dl8M2zoH5/PJU@vger.kernel.org, AJvYcCXDZgOKUseA/iO2TV1Ad/ak2ZsjkpbfD1ko4/2/bL6L11WWUnE0ytVXrc+ZhIXyLJYYN0XeO7sTXiqb@vger.kernel.org
X-Gm-Message-State: AOJu0YxMCm+j2wekMgZwzCAuGLPLx5eqFGSKq3a4YfSfwmzhWq0gMcxb
	KDIG2aO0NsyublUaJju3WWu8eJ0hVPSkBg8ZMLeKjctdZbUSO/Sf
X-Gm-Gg: ASbGncuvI6dyP2Da/A9vOlwKdrCzyciRS6ZX5HkVUZ+CsXTu8VM8F1Gl2MKYRQzNGLZ
	MPIJXZ5wreGBohkIJiFbhGxHu24OVKzd2bomMgYvhQlyINbDNpob4RbFmB4cyHzMw5JWHOyrVsp
	sa68JpjrP+3dnAcftcV/mDhHtnaXBjChHHiGqqnEkx7zxnf3YTguzoVmGJpbYrKtlNnsYsRN6ai
	EbUgMhUTyKdmALMbkddAgeWMFtk8TzIvPnXeaf96guc8UUCo6VCI2s9bx1ndERXXc0kz090DzBB
	nV9Lazqfg65iC10b1DWVLyd2zyas8SBPo3OngFjW/usZmD6WQDGyYeJH61Xmqb/8
X-Google-Smtp-Source: AGHT+IFFNhVexhviW4ohvV+ytpsYfyWraMYcfdVeAh5qkcC9E9DhSXWZrr/uyRb1xkwuKz6sp+LNMA==
X-Received: by 2002:a17:902:d4c2:b0:215:ba2b:cd55 with SMTP id d9443c01a7336-224093e4b75mr29532775ad.2.1741239113953;
        Wed, 05 Mar 2025 21:31:53 -0800 (PST)
Received: from localhost.localdomain ([205.250.198.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410aa8ae4sm3470045ad.243.2025.03.05.21.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 21:31:53 -0800 (PST)
From: Kyle Hendry <kylehendrydev@gmail.com>
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
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: noltari@gmail.com,
	jonas.gorski@gmail.com,
	Kyle Hendry <kylehendrydev@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 3/3] dt-bindings: net: phy: add BCM63268 GPHY
Date: Wed,  5 Mar 2025 21:31:00 -0800
Message-ID: <20250306053105.41677-4-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306053105.41677-1-kylehendrydev@gmail.com>
References: <20250306053105.41677-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add YAML bindings for BCM63268 internal GPHY

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 .../bindings/net/brcm,bcm63268-gphy.yaml      | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/brcm,bcm63268-gphy.yaml

diff --git a/Documentation/devicetree/bindings/net/brcm,bcm63268-gphy.yaml b/Documentation/devicetree/bindings/net/brcm,bcm63268-gphy.yaml
new file mode 100644
index 000000000000..1f91cf0541eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/brcm,bcm63268-gphy.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/brcm,bcm63268-gphy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM63268 GPHY
+
+description: Broadcom's internal gigabit ethernet PHY on BCM63268 SoC
+
+maintainers:
+  - TBD
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+
+properties:
+  compatible:
+    const: ethernet-phy-id0362.5f50
+
+  reg:
+    maxItems: 1
+
+  brcm,gpio-ctrl:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Phandle to the SoC GPIO controller
+      which contains PHY control registers
+
+required:
+  - reg
+  - brcm,gpio-ctrl
+  - resets
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/reset/bcm63268-reset.h>
+
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy@4 {
+            compatible = "ethernet-phy-id0362.5f50";
+            reg = <4>;
+
+            resets = <&periph_rst BCM63268_RST_GPHY>;
+
+            brcm,gpio-ctrl = <&gpio_cntl>;
+        };
+    };
-- 
2.43.0


