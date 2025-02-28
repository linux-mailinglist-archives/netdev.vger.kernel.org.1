Return-Path: <netdev+bounces-170467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB19A48D53
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 01:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A068E1891072
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 00:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200D4276D3B;
	Fri, 28 Feb 2025 00:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idKFZCYk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9702A748F;
	Fri, 28 Feb 2025 00:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740702495; cv=none; b=XxmJ9lfF0nBJGPJg1jz7MyVizfgoLCHMJWD+rmbgzovnZUunSCE1DnrwBAoh+y3LhgkJj3MCRFt3GfXSkMfNHQ6L+4IozvzbgXC3HKl+81QIe6ceaEWbm7/eKkB0c/npP9quguY8ZTEDr4JWxwIj4TODqVGQX4c7EEePeI3ITZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740702495; c=relaxed/simple;
	bh=CmmFdCBMqBIQcOispa1/8NGC8reWcFOTUI+kyCMnqOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NopLYE9acNgj2JBQrl0ttQQgp5wqsqYg1mp4/EtZ8FF7qAfQHspORvTia9Wqg+sRmtuPl/OXaZ8+OrlmYjYw4ibjSWlg9HS4Ye9i7/R77W6UPZnm7aHlXNXd+mWeXZEffhw/2+O5Z4k+xt5ht+QL1X0HuosxR7oJkS8k/m5umUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idKFZCYk; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2feb867849fso1170644a91.3;
        Thu, 27 Feb 2025 16:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740702493; x=1741307293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dw/5ipJeWLDI4CnudDbizBBgDe+lAH21LHzgScanhqQ=;
        b=idKFZCYkY2KsPCfb2IB1gMDfWaAreZYLJD6gbX3VPE5g64bRXQWG8QEWOCTf1wvvQN
         LK8eFEX5B201rFYWGSd1+2RYf1oZ6yrAiyNrba0Aa3uOWJg9wWMShlKDO3Ox0YnostUr
         d6n8cV/pzmOa9DbhXFSZicomHgGMYsV+d/lnm/Vu0OGb/8lOokwWvHRy3UJ1Ta2x8jR+
         EccaBsSfSCD6BQDAfFVVJyTQN/Ej8bKjke3Em08aRYmh/ont6VpRMuanMz4RVZRbcDN8
         phyhcWMLLAPKqZQ4KLt/pTtp69LO2kpKlp6NjN/T9Q40D/++Fab9K5GqPwL5stu9Zskz
         HhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740702493; x=1741307293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dw/5ipJeWLDI4CnudDbizBBgDe+lAH21LHzgScanhqQ=;
        b=StvEVW7q5CfiyHhoWrMseowEiDNrVUORgJwDa8EqY2Ku3kTV4qvDxdFW14r3bgs5eD
         M7/M1pZONLBqiB7+LeQEMrZhA157ZQme2TsI0dsc5qfoZTRS7SN0lU09CRt8FX/LQymp
         jXyZJTMaClTZ2W4CxkTG19fNIR8i1pVe8CEXmYzbJHYabtWSLdeTR4VMGW8J1mD6Fqal
         DBwdjxxHrBIHaP8hL4Dm1dIBjDsUt9pGxqz9XNOLGfY9SQSXBu5Aw5ZAouJGJOA0etun
         OJwrRqeWHlo8DqEkGFelVlUIrkaN/2evjB8mHozO1eG/0/mdvLISRij0M416YrxZJG8S
         NiRg==
X-Forwarded-Encrypted: i=1; AJvYcCUH6Gu0XWlAlzVjbAt2KYFaZyVAv7F4SlWAXXpAdsUJoHHz6TbPUb9+SWdq/usXuPkVE6p2Z4jZNYjus3DT@vger.kernel.org, AJvYcCUaeGwjMRct9GMUT5JV0vM5NQ6gE07ozS/8UPNOpR1hkXFesSD9AzndVePx9U8Cgpp1YynaUxQr@vger.kernel.org, AJvYcCXBzp3JisIV2bj+do88mbLZk8BguDbnawoMZ26AAa5EWRoTHpvLCIgioNSZnfElA2gjiJYkXRlC+zZd@vger.kernel.org
X-Gm-Message-State: AOJu0YyVPZ9YLJ+O+Unf5mJP309wAXlmqKg87Jfd6GaxDfhAedD8XlF1
	O93Ch8c9ilIiZoEiO/G0gOtKr845VFFJpCNNllVcm7AQHmYY6dB/
X-Gm-Gg: ASbGnctHLJRloSozuTeVePUA1bUi9QMtV17TrKHiA3QtlEUkCaR3snsadx8QgU3L3l8
	zLnEs69Pu+ZeELN5/XMl/LDc2bmdf0swcNpDH5EnzaUuEZOv9oY1sVjf8RpfwjErEzybyG8Dl0j
	9TZGOhgNH3w7iE/pSvzoNUjRr3ThKK+xAexfbSkFYrOLjlgiZWBFaiwUfDGi/qIWUorIOeqXu74
	T2BpiTqNTRcy3tHPOjvD11Dkp2VsBHeNRMCvipXxkBcD8UHuLfLZHDBpMSMjnP8RCwy50HpLVBm
	ulH9UthgHWa8ku2ZDNIKduWa1NYcV1qKEPmpLW5p1jzglg==
X-Google-Smtp-Source: AGHT+IFupZFS07Aa63Pooun4PPkecyE/Wd+GVXxlhhpVEAvBhqJddTKdJSnWkq7tFzZ5LxDPXe+7+g==
X-Received: by 2002:a17:90a:d605:b0:2ee:bbe0:98c6 with SMTP id 98e67ed59e1d1-2febab56ffemr2123735a91.8.1740702492716;
        Thu, 27 Feb 2025 16:28:12 -0800 (PST)
Received: from localhost.localdomain ([205.250.172.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe82840e62sm4511094a91.34.2025.02.27.16.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 16:28:12 -0800 (PST)
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
Subject: [PATCH v3 3/3] dt-bindings: net: phy: add BCM63268 GPHY
Date: Thu, 27 Feb 2025 16:27:17 -0800
Message-ID: <20250228002722.5619-4-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228002722.5619-1-kylehendrydev@gmail.com>
References: <20250228002722.5619-1-kylehendrydev@gmail.com>
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
 .../bindings/net/brcm,bcm63268-gphy.yaml      | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/brcm,bcm63268-gphy.yaml

diff --git a/Documentation/devicetree/bindings/net/brcm,bcm63268-gphy.yaml b/Documentation/devicetree/bindings/net/brcm,bcm63268-gphy.yaml
new file mode 100644
index 000000000000..415f5c03c1a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/brcm,bcm63268-gphy.yaml
@@ -0,0 +1,51 @@
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
+    description:
+      Phandle to the SoC GPIO controller which contains
+      PHY control registers
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


