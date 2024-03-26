Return-Path: <netdev+bounces-82163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E25688C8F9
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 17:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF462A68DC
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 16:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7F413CA8E;
	Tue, 26 Mar 2024 16:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCkdmwi9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F2A13C91B;
	Tue, 26 Mar 2024 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711470198; cv=none; b=LLwBkbB1lZ24EeIijPrw56HClhdvUZbE10KtKLqHinhDnNkFksoiMorY/Ok2d1+CxwoTEAbpyPtI9H8bR3D/1w/PQnkc2xodKstRkT9REHfz4poQVkH34uqnEc98yTyad6FWF3/ixDm9U3eouCv6R7fFJ8aLllZB/AKHylGg0hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711470198; c=relaxed/simple;
	bh=iPOtwCgQENo5R6dSb6I691mI3RiGq3IBiaR5DR9Uvq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nL74MB91sxTFEXue4s3F/veQvLq7+178LSVaV0QiiO+EjMNrJidGe6Z5Dkp5RtI5xRvfqWEEOKs/RPTv4RhUTz2vdC55jGNiNkFWKm5Ox/134DnukGcTv7ZEEJocqH53hM9mYO2VMiFK1IHVNbY0Hh9Y66cmYgDm7/Kqkecw2Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCkdmwi9; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a4df5bd63fbso100918666b.2;
        Tue, 26 Mar 2024 09:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711470195; x=1712074995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1r9GtXpp87nA055yl7m2jzg8nZcGgHakpWwhF5+6+w=;
        b=fCkdmwi9mDD/eCR5scOjbJjT33t4vXvMQLDI14F8okwNRx5XOqMEnVJRxj3Liw6Rfb
         fttjYwzWk1lZU2f1jQmP27sMlxaiDYf+5fOrCPj2vGRzsO7tcmmznTsG0ShSY7S964Pc
         Zb1OVZWOalrBX1FL5aHKNVoTqlJaIAkAIIK4OPpjtacbbm7kz+dJk2M0swvxnLWQ2HWQ
         hZBvvj2ue+RUVVGFSb2STHTGbhLgfZEnwS/Np3I0FTEgUPlpp5VlfzviLHRJs/7CZeo3
         ZDN3xR74ejhE5mkG5NuIqrnrqJtAza8LqQ9yJfyXeMFOfkGO4ef+j6hShc0viiTY+Zsv
         2cwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711470195; x=1712074995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1r9GtXpp87nA055yl7m2jzg8nZcGgHakpWwhF5+6+w=;
        b=penlZCpcJ6Ke0xHVEq0mAZlpQBb/Odnj2tsFA7tQlcoRu0QTMBMkx+pCiQKI3uxpLY
         j7XvdEdGVq22et/jYB2cV58f95Tw54WmOSFFTdgKegy96j4MfLmzFge8CxzyBlznl9s1
         o6ty54zD40b3gderS4R73qfd80Nye9GxwKczPpfQ1wFtVg6F/J5kC+hDP1ahPrLsSqGH
         oC93m+MJcXcaIg/sxbV0r5x5RHQ/2t61PoD7Y+EUHigUHJB1HEdX1R9ZpwE3NR5y0APG
         e2QRk+l5OmUE9/d81H/zsfF+V3WpEwY9pm6pjSS5hQSN9zfBRY7G4OHhfmipCwtIZRVG
         WsJA==
X-Forwarded-Encrypted: i=1; AJvYcCUKdsPU/0gFPvDxpshXb2GE8otOplotJ9j+tmkch8/q8cTqSxTI5MLSeYhv1o6H+t/ZKjYxE5rXz7ax7E4CiHfMgga0PTevEKQm7g==
X-Gm-Message-State: AOJu0YzCS+Y+2fWYZDlV0TtVIeOaXvYjcfjPVOma6Cu65u5Hog0OhrSt
	9R3i78NQaAq2inNHpsazFQo2Ma1AjzGQV96s6mtBkVIpkbFNPr00
X-Google-Smtp-Source: AGHT+IHQ1q8Gh8Q1ajyS+8jJTHh7RbQqhdYLDi1jPPuuJ1HPCTeida1PjBpaKzz3CHMja6WzF4HVqg==
X-Received: by 2002:a17:906:1401:b0:a47:61d:7d38 with SMTP id p1-20020a170906140100b00a47061d7d38mr8542274ejc.0.1711470194966;
        Tue, 26 Mar 2024 09:23:14 -0700 (PDT)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id am11-20020a170906568b00b00a474690a946sm3961415ejc.48.2024.03.26.09.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 09:23:14 -0700 (PDT)
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
Subject: [PATCH v3 net-next 1/2] dt-bindings: net: airoha,en8811h: Add en8811h
Date: Tue, 26 Mar 2024 17:23:04 +0100
Message-ID: <20240326162305.303598-2-ericwouds@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240326162305.303598-1-ericwouds@gmail.com>
References: <20240326162305.303598-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the Airoha EN8811H 2.5 Gigabit PHY.

The en8811h phy can be set with serdes polarity reversed on rx and/or tx.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 .../bindings/net/airoha,en8811h.yaml          | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/airoha,en8811h.yaml

diff --git a/Documentation/devicetree/bindings/net/airoha,en8811h.yaml b/Documentation/devicetree/bindings/net/airoha,en8811h.yaml
new file mode 100644
index 000000000000..ecb5149ec6b0
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/airoha,en8811h.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/airoha,en8811h.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha EN8811H PHY
+
+maintainers:
+  - Eric Woudstra <ericwouds@gmail.com>
+
+description:
+  The Airoha EN8811H PHY has the ability to reverse polarity
+  on the lines to and/or from the MAC. It is reversed by
+  the booleans in the devicetree node of the phy.
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+
+properties:
+  compatible:
+    enum:
+      - ethernet-phy-id03a2.a411
+
+  reg:
+    maxItems: 1
+
+  airoha,pnswap-rx:
+    type: boolean
+    description:
+      Reverse rx polarity of the SERDES. This is the receiving
+      side of the lines from the MAC towards the EN881H.
+
+  airoha,pnswap-tx:
+    type: boolean
+    description:
+      Reverse tx polarity of SERDES. This is the transmitting
+      side of the lines from EN8811H towards the MAC.
+
+required:
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy@1 {
+            compatible = "ethernet-phy-id03a2.a411";
+            reg = <1>;
+            airoha,pnswap-rx;
+        };
+    };
-- 
2.42.1


