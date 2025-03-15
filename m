Return-Path: <netdev+bounces-175060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EE8A62F68
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 16:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB083BA396
	for <lists+netdev@lfdr.de>; Sat, 15 Mar 2025 15:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A027204F99;
	Sat, 15 Mar 2025 15:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btL62ptb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F78E204C1D;
	Sat, 15 Mar 2025 15:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742053487; cv=none; b=DylL/084tJJQQc1z+2ZMztQQsAe5KI+49Z2T18CPnLwz9gTvQqQ/Miz901HNNafBnd/PTtEaNnjgGroF63LIjgICihWvqKPzWkOR//+C5j0DEhAROc9+kECVXV6Qxk8av6f5Vfw8bc6OdM6Oso7pRfVSDX4ir6hyE7Eb8cny5bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742053487; c=relaxed/simple;
	bh=yD1J4lIdXus0e15SA5y3QRtWVkUAobdRZ6hYZSmqWjk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LyDL8zIuK7kWy6QBrPCsP5x6eg28QBOqKiuWgTPNKIW6hBxamg329Rz2wChoI3HuOUb9keFKrS075O1mJi74ypUHFjz5ayZy/pImnxiNnN4GFEIifw9Ox+ctROfyvbZO6nQjpOlX4PVrG45yLhdQ1e6UFcQJmA0RU1TBYjqU4Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btL62ptb; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cf680d351so3539395e9.0;
        Sat, 15 Mar 2025 08:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742053484; x=1742658284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qe3n3ZQ5LVdeF6eehOPJZ7TfJ6ssfs/dDpnWYl0JxU0=;
        b=btL62ptbU+O4GgsN77GTNyCMKuvw6e3q1eSBpbGTl4BBDOQCY2QSu4qeGpcG+cxhEK
         zOdH2qxjbUKLvAozVH6GrGoowIgR/uxmCpM9Q46NxihseSagvjwpXm5Vk6dhCZ5GSGfN
         S7kDJ/Zcs+xCrMrQHl9SGe5MbV7d5yRUFRPkcKf/qLBWy+elC5xs6i1O9jKG5Irb5yHi
         Z6xcbL+o0sXlwUWQGsycfgtiO95L2cgqRIxWw0qp4it91CQv+MRhgjsOvmgx7fvirrHR
         S0KQ8fzCKoRu+SHnM5N4RkJVTMzw1AHbl9e2Eq5QqVWz1CByNLT+co1U83iE2gvg4eCO
         3New==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742053484; x=1742658284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qe3n3ZQ5LVdeF6eehOPJZ7TfJ6ssfs/dDpnWYl0JxU0=;
        b=AqQrI+ECf2t/ixuNvcBw1jSRERsgf0lRRFRkGqX0XgljPD2aiNWl0e5aD+5n9oEOQO
         kH5Me/kfsy5Q4zH3hq0i3yIzvs831KqQcG+1eM+lvLo+Ql6ADd7Udcsb+QwBg5A+UYhH
         JiXGGaESkkVGrrybup2+f9tTUz5tjEUD65IhVF/sG8iObP7C9ghoCPOgLOdD7tNV83oE
         Kr7FKN1GI5rcfOhOT2n4UZYTq1FlsWtJykyhBUrf4HTGwpxebYh41gDtRNeaYCUNPJtw
         e2sogFeupjlJeU754orKGdN13wLpvH94ChjRt+7KaO+i9RU5u9n5CVVnt5Jb90N6Xojj
         x65g==
X-Forwarded-Encrypted: i=1; AJvYcCV7xhpt6Jaxl6xzkISWfH+wtvoN9SCj87Pjhpnh+d/O3sWx1wtuZ14EO9AT+f08Tc4xN3oadI2D@vger.kernel.org, AJvYcCVlfmyu9ZQKxLsSDeTF6hOFDYGA6xhZNXk/06FLnw1f+UI59KkDkQB4UhG+vB5h7jsGmmiFjlF5oPRG18+l@vger.kernel.org, AJvYcCXCbfGvtOPfUepFsK+OAbugNg4sRpimdOiVQDrqbNObY/F+imUOkDcy4gnXxDlPZg/JZVECCxbDFavv@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc9+RSNmlz5JGAlzr4A1hPmxmZ0+o5TTY3pCJ/zFU9MjBLCZD6
	4nTzM5CbHxrj5i/M45EClz/gleQvbcdbqDw/uMwa8eqDUSxgACUZ
X-Gm-Gg: ASbGncsDQSuk0GFGgRVh03ki4tBJ8/vY7NievcJgzdlNTAcoDfbWtmugZMM2jW1gIdE
	U7nG4zkR+XGMEshubBnXYrYPn9ZXnXEf1wPdnTvAW3Yu8LP3EzR/oMY0VAwkG1hwqUVReAMr6Wl
	fn//sPiqzdo/QeBSKpR+XmpBykWWGGqxtag1qqIbtRLjxerLXlul8peyzAoIroF8d3gZkIKrrom
	rdCCMdPpA/8jh45pIk9FI0h1Q4MIaDNwFNqoeDqm9qkLJGSZJM+8XZMX/0IBQD/2m7mBdq/o9VJ
	PyHk6VdN8HD5Bx+5t4K7I7Wkck/iI+QMZIC3eYU5Ks4lvehlYmRJRhhsg4WAumZYIb7cj8s3BQ4
	GW6PSPO+9vmWMw0lB1hCDDeyQ
X-Google-Smtp-Source: AGHT+IGTFgETv3X0OQn9kvlEZkX9uQ97Mv1FK3vI4v+6bp7/gfuNtt5DkcoUjwWXNpHFChDijAtH+w==
X-Received: by 2002:a05:600c:3b87:b0:43b:ca8c:fca3 with SMTP id 5b1f17b1804b1-43d1f235e79mr82196265e9.11.1742053482562;
        Sat, 15 Mar 2025 08:44:42 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43d1fe0636dsm53464195e9.11.2025.03.15.08.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 08:44:42 -0700 (PDT)
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
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH v13 02/14] dt-bindings: net: Document support for Airoha AN8855 Switch Virtual MDIO
Date: Sat, 15 Mar 2025 16:43:42 +0100
Message-ID: <20250315154407.26304-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250315154407.26304-1-ansuelsmth@gmail.com>
References: <20250315154407.26304-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document support for Airoha AN8855 Virtual MDIO Passtrough. This is needed
as AN8855 require special handling as the same address on the MDIO bus is
shared for both Switch and PHY and special handling for the page
configuration is needed to switch accessing to Switch address space
or PHY.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/net/airoha,an8855-mdio.yaml      | 56 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml

diff --git a/Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml b/Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
new file mode 100644
index 000000000000..3078277bf478
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/airoha,an8855-mdio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha AN8855 MDIO Passtrough
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description:
+  Airoha AN8855 Virtual MDIO Passtrough. This is needed as AN8855
+  require special handling as the same address on the MDIO bus is
+  shared for both Switch and PHY and special handling for the page
+  configuration is needed to switch accessing to Switch address space
+  or PHY.
+
+$ref: /schemas/net/mdio.yaml#
+
+properties:
+  compatible:
+    const: airoha,an8855-mdio
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio {
+        compatible = "airoha,an8855-mdio";
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        internal_phy1: phy@1 {
+            reg = <1>;
+        };
+
+        internal_phy2: phy@2 {
+            reg = <2>;
+        };
+
+        internal_phy3: phy@3 {
+            reg = <3>;
+        };
+
+        internal_phy4: phy@4 {
+            reg = <4>;
+        };
+
+        internal_phy5: phy@5 {
+            reg = <5>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 576fa7eb7b55..1e8055b5e162 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -725,6 +725,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
 F:	Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
 
 AIROHA ETHERNET DRIVER
-- 
2.48.1


