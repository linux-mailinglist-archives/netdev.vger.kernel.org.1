Return-Path: <netdev+bounces-150207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1C49E979B
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5510B165690
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 13:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A9D1ACECC;
	Mon,  9 Dec 2024 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFRaJsOH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC4D1A238E;
	Mon,  9 Dec 2024 13:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751946; cv=none; b=f0tzWMwTuz7V2FVEd793ZqZxFvrHBNyXTfCY0sFzskt+vKDggNsyDc/359Z0bqpPOeGJIErrhCitkVMljkhBEAfnjSG6uDiFZwaE+sAtTmSDkgNa+14VCHgREPkFnLp/t95P9dkE7/gzJw+JOapGWLe2o8E534E5XhABKY0jdAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751946; c=relaxed/simple;
	bh=8W/NFx6VyxxCQOWCkDGcsfEqrv4eNi4NkkbGvNUCYAw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uz99MoGNGIvQfkK3FmTxC3PyNxtXTqlgoYNnA7CoBEhUTS6HY48nmJJ0ypZ3+wvncuSErTyn3cg9g63U21rQB1BxKp5CAyuBbkj3fZhtS6an3DOsNrYnExvtDGA7cYcT+6RKJlbtw1W13OdqFsT3K2s3d8wzjD/0KcVaD/tFj4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFRaJsOH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4349f160d62so29126075e9.2;
        Mon, 09 Dec 2024 05:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733751942; x=1734356742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UrfKZP3tJ9WsEejHMZ4V/5fjg5zBVFfkgDQECLE5uKc=;
        b=FFRaJsOHfgnpog2AG8gknvvxDaVQmsfeMLrJ4pbpvNF961wNEsOq3/jYphz1fPgri8
         xd4FY/9j6cMhAPS+WXtZcP2KL8aEWCYTNB2dqzSfByM0IP9d85QtuTEC+EMlqoMUPen6
         q0AQpehkT0c7N5nl4l05u5XEQRw1miPZ9MNKBddm7Y8Dspe0mNpf9/GH9emR45DaqL84
         c72VYNRqMGBMWLcaIdPt4t6SFStbthFNf2L7hh5k9Xje1sWsxFnbWMos1WzjAzMLAukB
         UrybFEIw1Lyek2ZUZ4jG9PPP5b9KXglpS5qK15F1zf0edTNRbzHrGNwzM4Jx6ZXmHs++
         i4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733751942; x=1734356742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UrfKZP3tJ9WsEejHMZ4V/5fjg5zBVFfkgDQECLE5uKc=;
        b=b1+Qp2+gOsfR1jEbBevmt23NFQu4mFlU+oXFle8RXirRcC8NQYyXicZ6ap9Foayf7f
         ohlLqYTcPKFQ2Y1ux7Rh99VtQxrg51xXovh4V6sfoPACljdID+PeqyuK5pyHTiSNzqZm
         ZHgVyLQzqSLsYDApNKnBHPuvVBxJD9KbYvmySSJmRc1J+owdw0llagfSBY/uIEl1Mf2v
         Fjs2aOk53gCwNXU4TeTfdhBGbaDt4mz3eMKmKq7n+r1pwdPI5/wA+UHWWi7Rl60K6mfI
         mfNRdyF7yv1VlFqs6p4XqWnfMvuMPus+/Q9MkMUyl8zZULOjTSqRCtFNeNx0VFWDzh+u
         Ybsg==
X-Forwarded-Encrypted: i=1; AJvYcCWHXimGrlNpH3BQ9giGLZMtXssLUCI2ZiR80T8t11nL+zj2SdYy14S+Xgsm5KjfH9OrkxxqT70l@vger.kernel.org, AJvYcCWTZRd+WQeSIOfPXafBPfLGvzqcop3e8PsN8ZAN1kCmEU8xxBpIfFu7ZDghZ5s2quOPOZjcvx15gAVIMp3L@vger.kernel.org, AJvYcCWpCZkCMJZSjZ+NowU54KWTYQtvrOHisc3ed+YHMzoLKizfJ72A4KHgnbc5WWNPkJKduIbknafs8QWz@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqr+r7jCi2WYEwl+fvILNVwpmTbgy6LheHBQCLb2akFP3x/FVM
	0zYlQZgSLmujeeNDeNLND2e3xF6gnJQMvOLt2Cn34gE1TN+rSyOc
X-Gm-Gg: ASbGncuyHZ1vKVbN0p9sc9jiNRgOwyDPzGjIxm2XaSNvONkbk4H3Zg0hY1W/bgyrPia
	ATOHXVtt6v2JvyoiJ4ytTbB0KBQ1h1B+AWfMeMLq+QEyCxZzQhwrkvrMTzpeaDRuL+FVofxkszq
	feOO/OlCtaLKEORYEyCUmPgSoBLHhxvn2ZhQ+xkMduZY0+VDHr7HFHocy+3hvPqdOMa/wOeKMAu
	fn838zN2UwHuJ/DkGgn8EvK6GKls6OAdv05TlX3/I6x7k/64+noVhnllFRHJhrO4Xkamh4Huhgj
	ScWWwG9oTwfCZw35oNo=
X-Google-Smtp-Source: AGHT+IG1t0zuoMvdGZ8S9jBd3wrS4chupreEkuLilib87ae3Cn8VtV9KroYa6SltKRQXEwSb9kONag==
X-Received: by 2002:a05:6000:178b:b0:385:f821:e97e with SMTP id ffacd0b85a97d-386453d2c19mr375325f8f.9.1733751942262;
        Mon, 09 Dec 2024 05:45:42 -0800 (PST)
Received: from localhost.localdomain (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-434f30bceadsm62705135e9.41.2024.12.09.05.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 05:45:41 -0800 (PST)
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
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: [net-next PATCH v11 2/9] dt-bindings: net: Document support for Airoha AN8855 Switch Virtual MDIO
Date: Mon,  9 Dec 2024 14:44:19 +0100
Message-ID: <20241209134459.27110-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241209134459.27110-1-ansuelsmth@gmail.com>
References: <20241209134459.27110-1-ansuelsmth@gmail.com>
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
index 53ef66eef473..e3569fe5f3de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -717,6 +717,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 L:	netdev@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/net/airoha,an8855-mdio.yaml
 F:	Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
 
 AIROHA ETHERNET DRIVER
-- 
2.45.2


