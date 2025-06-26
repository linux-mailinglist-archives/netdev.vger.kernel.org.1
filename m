Return-Path: <netdev+bounces-201681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E24D6AEA8BD
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 23:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E58E3BD81A
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 21:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A30026A0D0;
	Thu, 26 Jun 2025 21:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNpTQ0IX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78829262D14;
	Thu, 26 Jun 2025 21:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750973040; cv=none; b=GPZCgIW7ERoTFIUxIgu3etrWD/UQdnVNX1MRyNkWjVKqPWfH5sKOtgHtdmjRjcYnhIR+bSlh20NyqlUcmGmLx61WAawOFi/f5he3xpKrJj3iK2CObc//M2q75KQ5a1+ZTa9hmIRZNBUDjMEQ/xORwZXqsajZg+IhGNIsXMUp1+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750973040; c=relaxed/simple;
	bh=TcLcBxuZobMf7GWrGLLah6hinSz5HmSnzIgM0LDDAa0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yf85lQTc9YhHtbYwBM9KCdyEZT9rC7GdgxQ73btNn3+VXtbDz2qm4Po+m/IA6eC/JTyfI1hFBiXjdLgSa0i7WdW4+wz9ZN6xD/Jq54ykrypELVMc2EGKoxfcvdVWl4QO5Mx8ebdeotm43pQeU3uRdR3Z2b+L0kCRh+Np4sEaH/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNpTQ0IX; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-450ccda1a6eso10242895e9.2;
        Thu, 26 Jun 2025 14:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750973037; x=1751577837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=byJPrCHf6giAb360kl2C62a9VTaGkIRY65ltid6z7nk=;
        b=iNpTQ0IXEqk0JQug9AtWa/7lvS7uY73N+cRP0xdU1+HWlE/zajsR7Jyk3yfeCcz1jj
         jahwfa/PBGeaPw5CKC5NqjYm2pOQu/avzrdFNIzHF2LWzlSa9OIT+a3oyJWxafjnMIsG
         ieglvIpJYuKL7gs86cG8vYwda3TuoL8x8Hjmrembdlz18b5tcPJjV+ZIh0yvmWZHFD72
         U3LEdr3zhN2jDr1bKa1f5Ze+jyye1hA4ljwKTOBaCC2hPrN9MnR/VRUkdJWambx3LFv0
         9kikjqfvEmdxLu2glRl7wnR2xcW+j9aSSA2kqCoWo+qpbLUpkJP4YRmgkI0dtboh9P8w
         Udbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750973037; x=1751577837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=byJPrCHf6giAb360kl2C62a9VTaGkIRY65ltid6z7nk=;
        b=HdexF+AOpCIuQPiZyPbKZhCjm/X6CJpF79kiUV5b3te0aGIqGgXIEZg29crBUeWiOD
         UmYheDF51XNeqyi8EPwLMWFtliJRFPsfnpmQ+ECxXd1O2eSJCYy0E0VXMqf0eLmXQkTk
         hy9zkjuNUUoSqNO7DU0XMDO5sty+lJAwm5bB1gzQmXXZNnRPb96dCvhoLHtYxnpebqlo
         t2ZKIk4F4QW6OTR0l2I8FPKwEQExWkMvUPNbZeWRZn4TQkNPuUvN8JCDjWrh59Asuhw1
         Vi6EV+cUhF1zeL99TggWPy3WktKDm3uEMWRBoC/famrNTjm38DJcJg/5NLnveb3QHZsl
         GIHg==
X-Forwarded-Encrypted: i=1; AJvYcCUf4wLjxibV94L0QPDjXQCtEAW1sM5rp2Ah5L4BcwHmIpb6/vmQryLNYvYADfk9Qr7dh7PmjL4C@vger.kernel.org, AJvYcCVRiBE74AM2iLKAUh+QxCpfyDY1NgYGaMvuGCGw69nnHwlWTUh7dTGrqj0/7zH1d0ud/wHALYf+RxfH@vger.kernel.org, AJvYcCW9qNV0W0Z3vQ6i25TQXV0WNOTu2KYLZjbvKmPE+nWYwVgT0/F2YtFFm+rYvU6cA9+uz8OtvjTlLpj93+v/@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4P+4HMcnC2plGAVXVFnjOELSboKlsxWD3xB2/FqVl19o1ZS1G
	yCrJaO9p5wtvsmQH8cox3+5vdSJLUHZ96os5sKLKobxPs4hD0bbiZqK3
X-Gm-Gg: ASbGnctI9WqRpV+BOlo0XRg5xVgAkF2ro+uien/aEZ/hjHRNss1VXT9KRzp7ORM5AyF
	R05YpSHcYVMmfQ3thMX7HoX+eI32Fv1j+yj/x+u03B9CoZ9phaNyBehSHykXD01wzHzKPPdRqnG
	qmGZBlGnnL63wSMbVx9/I8gz7LO+gSpw8jI5Clp+aMR6oadkW3QAYMbkRXXlj4MS150JIAk5hmc
	73CAdvAwuGLPrVSYnf8Pe0W/iZoHuoolpVRzVfmTZbGiC325sHzSuc9D1ml4qpOkPq4v1AxL6Ht
	fEMaaw5KYFTJ4xO+zMjEaMI1eGZuPMWsSrwnkc21VgaHqnnT24iZJFOM+cC5qLbFhl/zEmh9rot
	+becMuYF3tPR9hL0ZhLTixxfWC5dBCQk=
X-Google-Smtp-Source: AGHT+IFMKGhyUMwSflKNYjaX0uu+JQoU7F+CyOs9Nm9VBop3WcpxumqKUUQB9vAKBq2BHW02dlZyBQ==
X-Received: by 2002:a05:600c:1d18:b0:444:34c7:3ed9 with SMTP id 5b1f17b1804b1-4538ee7995emr7407535e9.26.1750973036440;
        Thu, 26 Jun 2025 14:23:56 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-453835798acsm57186475e9.10.2025.06.26.14.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 14:23:56 -0700 (PDT)
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
Subject: [net-next PATCH v15 03/12] dt-bindings: net: dsa: Document support for Airoha AN8855 DSA Switch
Date: Thu, 26 Jun 2025 23:23:02 +0200
Message-ID: <20250626212321.28114-4-ansuelsmth@gmail.com>
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

Document support for Airoha AN8855 5-port Gigabit Switch.

It does expose the 5 Internal PHYs on the MDIO bus and each port
can access the Switch register space by configurting the PHY page.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
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
2.48.1


