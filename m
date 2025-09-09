Return-Path: <netdev+bounces-221008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0CDB49E2D
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 02:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61BBC445470
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 00:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C2E21ABD0;
	Tue,  9 Sep 2025 00:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eq6BOeGK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D71212564;
	Tue,  9 Sep 2025 00:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757378639; cv=none; b=jJmEDZvJV/n2SaUigO8u01PNScIY3aMqQm4xjP4NVY/wNXjrt4big5Bu7eriBtjYleGhJFyJgzloZZmacro/0OELWRpjbPbOGtivdxJ5e4l13ul93wRLZZIZ7C+GI3+6+AFHe/cuohlKJvf9f6BxENlqTYGq3pe5XGoTXopuueU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757378639; c=relaxed/simple;
	bh=iu6cAJ208koTziScEeo2ANl0vd5jvexFeobSmKdVgIo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b3YPsKm+IDu1YwEh+ekxY4Bf/REKmiECxqogW3Dx6yqdlps7+T4Jl55DjfSzNl+bm9bnJ0Hsh16E6TitOjGgjfEZEaDlbxvFoz/WcpN0iGVHuIxyMPGb1XbU4WUBp5yr3eMHpIBTKf+asEzjebDwq0nv2A4nyV9BmALSErC5EWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eq6BOeGK; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3df726ecff3so2630681f8f.3;
        Mon, 08 Sep 2025 17:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757378636; x=1757983436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wBMh6U7IINZK0L3FC9uf7py/PwEZtlMrxhEeK3aMbd8=;
        b=Eq6BOeGK6rWKauyJQsL6++qadckRSit1WRIPkvFk51heUV8KmLedkUxXkGriCG43st
         oNbvMYyLSIR7NRW2SWUXo5figfJsC3WYdbcUcp+QotN5H6Z2C5roy3xesTpC7T4nIRJW
         bpeqb+LA4R4Yj+TdW3S4+V2q7yb7kggZn8V8bNDTqOO/kSgvDhjBPioRKWHuPkOc5KCL
         YwxMKoN6E17n1DB528vLm1yCxTV3VLd8zdVmco3EO3ghFlMI3E+wvCcQN7kN91MYLRcM
         8WJ/W4uhkTxKYy+X/N2C5U7SNY7vKbZaKkLA7vyNa3wBcFQbsHsBV1GXzIOxUo/rwloN
         ks3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757378636; x=1757983436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wBMh6U7IINZK0L3FC9uf7py/PwEZtlMrxhEeK3aMbd8=;
        b=bqVAmUdGbyRTRG12iqL26fe/7ls5iX2aXjOaQ6OX+i5BBJV93YXnRhIDjoehpmyPcc
         oS4S5oZpZe4gXcKR171i1+yDm6Hr5rAPjA/APlf6aZrBdpqMKhX/LkZiq4tFFx9tIDx7
         M153wW1IEcAn56Gv/I7tz4SjI3mskgXLTYePV02FgNbGBVgAM8LPYV95YhNut+EhUPlr
         4FA395uuR4z6dTzvVatoAyXUZJQhQOuvJjRAzPhYaBl+QP09Pq1/QhmqeSOS1aMH/2p0
         5GDdP6apKi2rWPvM/s6Aey/pk/JlH7Q5kC6LWrtXFD9+SpzsEU2/IS25cKi9OafydKNW
         ebUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU75co7jUx2lzC/W4ktRyFW/Ps8ysYo2VrVmGhD2V/iU3tbxKlAwAku6NNvU5bEtP4J9wy9A85let5UfqFK@vger.kernel.org, AJvYcCWEOaF2zuspS6F1bGC8SI34/0aIQNBzzxL0fD8hWFPR+MrwGK2DDp5ViCihE436yP1QOtPwO4PY@vger.kernel.org, AJvYcCXgVbqtrOH2q/4ARKbgbKKwkLAlC2goTyE47iZum+P+T/KYcwlgB2/viR0penHmMXkbA/cxLSkSPePk@vger.kernel.org
X-Gm-Message-State: AOJu0YzEKMcjLEMrq17f90HGeEl70MV14tT+44i0vMPej2CEPi3tOnfY
	ciLixYOKZeuEy5rIUstZShUHDdRWT1nxWStj2ztQzLNREgPfR5m98tvA
X-Gm-Gg: ASbGncvVqlF2jvv0zmUEGVWQybBIRxs0LGVpDcm6eT2DEhgh+i4i64MUyc34+ReE/k9
	r4iev3C3OkS8uHK858+vPQ/wIJixNJpAraj4o18eGaO71E0lUVcOWfoy7HiJwoEUEnELWf6CyuF
	K3Mes66/Vl+tfXL0QsxGqNM/wxw4Y8xFm5bg+oLh25hEfFuSspM4FztzbMF01+IX9gk9DBXnCJW
	jeqodkum/pAUli1WwHC5fSQimrym9cI/A8y8v4c1cIeFo6xIQrW1QUkkTEgn5wrdINM7rB20w1k
	r8oJJnpoD/ZRppNqXfYwirLO9EHFB2Tya/0Fky9WUpdbCSrSi6F4lUheE4rT8D16SUQzwiNUPgL
	czLPyk4wFIYZiYPbm50aF+0vf81boiL/8tkyDvSMQ4IU31zioYu/QCNR7PYRe+df6iMKwwGQ=
X-Google-Smtp-Source: AGHT+IEe96rQnJG/KyahmEcxLBJAxrwyA1aQw4dCdJG3eGjrRHrabggE4KXYCT2knLVEDci25hiPVg==
X-Received: by 2002:a05:6000:3109:b0:3dc:f2f:d43f with SMTP id ffacd0b85a97d-3e641a60681mr8139409f8f.15.1757378636062;
        Mon, 08 Sep 2025 17:43:56 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45decf8759esm13526385e9.23.2025.09.08.17.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 17:43:55 -0700 (PDT)
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
Subject: [net-next PATCH v16 02/10] dt-bindings: net: dsa: Document support for Airoha AN8855 DSA Switch
Date: Tue,  9 Sep 2025 02:43:33 +0200
Message-ID: <20250909004343.18790-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909004343.18790-1-ansuelsmth@gmail.com>
References: <20250909004343.18790-1-ansuelsmth@gmail.com>
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
2.51.0


