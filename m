Return-Path: <netdev+bounces-194515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D00A3AC9C5F
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 20:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 725D017B191
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 18:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71CA1B4F2C;
	Sat, 31 May 2025 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMi1NUGp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360791AF0B5;
	Sat, 31 May 2025 18:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748716801; cv=none; b=RySAEJDl0JzE9GiaC3ruTviB3chCdK8YwFCB/CmF1iTcZUhTrup6zyLuhlARKMmDjsg3IcVt56aJDCQM5JedNLJ2gqgM2lrNvLmgGcpIA/qwZPazDR1jZqDynwnH0tn+uy8Zm/dir0qWrIHpTqkR7dox+reAqqTcqV0VbplKJzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748716801; c=relaxed/simple;
	bh=8ROhfOx1dZXMzd/J/NH+P2v06NXrcGFScq6nUz4t7lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBPf9prlIS7ci29oeeB57pwTT5FGxn4emr88OJqsjp7ublu5YExULmiqjRpEeTkotQ3R1DKKGVzvK1/LZ/Gp2zlUj1cxjjc5C9rmSHvNSx0sx1IbOzPGjogDigNHoEiYPeL2DlRfMGhThP1oLrdckinoA9/a899BU0VTQfa1bHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMi1NUGp; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-74264d1832eso3347632b3a.0;
        Sat, 31 May 2025 11:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748716799; x=1749321599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dewp64/KSNaOuX5WwZpls97smF8ZBQ6NIUWA1VX9E64=;
        b=bMi1NUGpnRj2+t9Yy3S9V1H7piS+i4idtjiplnngoI7zryehHV5a9mEI4MorT+N13J
         M0daeaSkXYfBg3YxCVz52hUFR/zpmMjRDdB6IFsxk+Dep0yHITnY3BS3QU8MhCaDHYuh
         EmFde0p0z6mCm4H96zncSagSeW88dM07ADBfdzQ6FSoY8XqKZl6eUNomJ0rZPlKS9NXy
         4Wo6aZumAVhvaHF0IJvMCkjMiEsqeirv81wKxd4tREIJRtfJvG2gkiKTgM/ksBKyhjkU
         GXc5rqFoRFqI89VpfE8guyNoLkh6p0AllOi+YgTAhdWLSWc+YNs1kPrTGnEHtAEFT+SZ
         VXcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748716799; x=1749321599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dewp64/KSNaOuX5WwZpls97smF8ZBQ6NIUWA1VX9E64=;
        b=q06rU2A95yWuEUZdeY5w1AEBCnK4CB7mcs0T0ru00VH8N8IyVGoYcfyGC2wzdLDx1Y
         syCQyYJFf9Cpj7RquM5QGGGb+y9gUNV91DEBSDu80y4ppsqeaKgElo92G003Xnz8Emx9
         rfZYD8NeS1c8e3YT/upUj1w/TOCjM4a2G5zhj+0d+d/JxublNWJ646kZysNPOCmS76q+
         GpQx2Xl3SVyf7AJMfb7JzOW2hL2kCAbRcPJ0lquk/SXfMLH1kP0MaB/jxoMo+rCmtkQS
         7Z11UGAW4uxZ05sbDy7Nacl8kk9BWrK/tY/0PDR2iNmv+cSh8WgRc7FE1wZ7OnrRBVdZ
         JPiA==
X-Forwarded-Encrypted: i=1; AJvYcCVRwjsoTydn/9zDVrPFvi/R5J+jttfnTHK9aXfWhHVFRFJRQqBCNK5VIo1ZTP6cPMiG77ad74kIKEnp@vger.kernel.org, AJvYcCWR0e8BGEEnQwqPOv7xNOhzsi2iDhMoTWoI/ZqmPeaIFuR4zGNNaK3OPvrLnOidRIRuMdhBMOCwaWUYsJ2V@vger.kernel.org, AJvYcCXAy2TDHYXDzeWnMWLMxCZQrKtE48PNOGJHez7wcpVIhCEF6HSE93RfDGDgPzotS/J11rJImzMt@vger.kernel.org
X-Gm-Message-State: AOJu0YzWeY6Pux9j8EgyUR8yA00iqEWWSlCXF4fqs/UdbNQtzEaIVaUu
	C5g2QgBGDUBOwM7SjfPysZgHd9MnX6YqCfQlaVOx28GYDpR/xhsQlQlU
X-Gm-Gg: ASbGncsQ5qUPSKK5pvA3WNJHfng5Cll0qJlwYdcIiE/W/cSD0bdRqz4ZENmf7elNEW8
	3KJMSM/QLZyo72t4Ux+b3AdcJR0x5bhTl6IVxhazlLBMoO8cnGBLQXbIZso+nSub8t9VkRO2Uka
	crhH93AwBHMN1QnMO1QOStQN5UNOr3Br31jM4TQZHLsyctOeQvzgInAhxojT2FwS2Z99E9yIKPt
	wqk797FlHbrRnmhsyvbUKePHyhyOdbDbTmvX22CcAk+LZLvpTkyf0u7qRpKmYhqakKSdzauqSSb
	pVzZ6TP6sSf7c2xIRmqRWXF32Y8jbBTMQo8MZuS2VvUmCklNHyAvXNDvay/m7HlFkIGt
X-Google-Smtp-Source: AGHT+IHyLqkJOjcoRO5RDy/+OVCphIHcBDzG7Ali+Qrh1Tdt3SQjYclEn9txgHGNc6WiNTPHZPtQpw==
X-Received: by 2002:a05:6a21:600f:b0:1f5:931d:ca6d with SMTP id adf61e73a8af0-21ba110b894mr3825133637.1.1748716799414;
        Sat, 31 May 2025 11:39:59 -0700 (PDT)
Received: from localhost.localdomain ([64.114.250.86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afed34fdsm4888915b3a.75.2025.05.31.11.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 11:39:58 -0700 (PDT)
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
Subject: [PATCH RESEND net-next v4 3/3] dt-bindings: net: phy: add BCM63268 GPHY
Date: Sat, 31 May 2025 11:39:14 -0700
Message-ID: <20250531183919.561004-4-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250531183919.561004-1-kylehendrydev@gmail.com>
References: <20250531183919.561004-1-kylehendrydev@gmail.com>
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


