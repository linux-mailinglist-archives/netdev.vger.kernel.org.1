Return-Path: <netdev+bounces-78890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0DF876E80
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 02:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FE281F2250C
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 01:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C605134AA;
	Sat,  9 Mar 2024 01:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b="uzTBdjTU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307ACB656
	for <netdev@vger.kernel.org>; Sat,  9 Mar 2024 01:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709947628; cv=none; b=It/vCd//ksmPPAmvYGXBfFIlMpkBEr3/GOSADzK6b7Li6yWoxFpz2LXSxtI0tiqY0Ns4wTdA73ey5VDQb8HbYXu7vcWy+6EUeZAI58q19ozWga4pZ1Kl+0AF5EKyQjrUV0zk38XIicQIu7Q3ZISpLzU8cviKyWYfwbBh1GYbAPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709947628; c=relaxed/simple;
	bh=3dUH0Zt+dXHQHozoH7XCkQhKbmijKAYGAP74RRtyxig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y97/XmYg4HIt3EH2jmbtft+tCP00p/03+CXBn2cc9KIIRva1gyIcdayG5Fmz5+lDA5qg8is7F/gAlFVByu1/OQeJ+2YQBYrv2CRaTszlPqnIf7mg9g8XgMPrcXh4R6amjMivQpQs1b7MruNvBQDZql8ukoknZi0znj296TaKUNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se; spf=pass smtp.mailfrom=ragnatech.se; dkim=pass (2048-bit key) header.d=ragnatech.se header.i=@ragnatech.se header.b=uzTBdjTU; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ragnatech.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ragnatech.se
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d204e102a9so33572361fa.0
        for <netdev@vger.kernel.org>; Fri, 08 Mar 2024 17:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech.se; s=google; t=1709947623; x=1710552423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XhVQmZ5y9DwT3fewTRMRWBUBAu8iGj/D4I/8ewM6Bfs=;
        b=uzTBdjTUyx7dIOsid9skmA6ZlgVCvMwHVxEfBgswrCJPCOgihNzuxYuwNlM9xWOWJX
         oXUBfieciqOSYkCFG7EXRzTRc1BSp6bf0V4tTDc8uF13oS0O4mXy7b/UHB94LL8RY8/I
         aJdH9xUUFbZmOxJfljU0vlVyKzHyqsm0J8l4TM9L7EL5/SKgYMs//IVEgP3ucfBtlrbQ
         6DcE7MYlELXi1Pkzxkk46yMq5z5SnepbmuKK+ABfwP2V7FHFZkJ1p5V4sweEDJhwRO+B
         lmU7/6EgroqYLrqozRAVXKQR1vY4c3XBY2tELoH+RLZWaDGfE/LoKRFpJRPhxY0aQgc1
         Z3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709947623; x=1710552423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XhVQmZ5y9DwT3fewTRMRWBUBAu8iGj/D4I/8ewM6Bfs=;
        b=SX9bosaHR3zw9s6Km2YmoPavJTBZqq/ez85tHGdWNuIxc0BzyzpnxwboNiksnO5FZJ
         TxRmIx5a1DREb9nv644onQI3AW342nT9aYc0IPXDCcXqQVGweoEUu05L4f/+nHl6+JYx
         bXGXjGnoEn60zCGJ26QhrWgMosxS5+E42QmVyRZXN2NRxx8Vd3fQLOFonP+rMlLeZTRr
         hdf/U4FYRFHOSUPF6Jy6Na64KhjQdVZaxHU5SotZFNt7My9hhzaWue9RmVe+MaRzLDB+
         J6G8R7eFZLrYdR1/yANWW9QTbsmAdJQrH3lq1CFBWO02yJ36crPn3ZuxBxQKnneogMGe
         9HOQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7X0xhKREZJfm7S12B6TmXs2vJhfB79j7N9mup1qXJPj4tAEV3asaXC7exGlK8sabRazymXHrOImEngs4IrR9nSNINiggr
X-Gm-Message-State: AOJu0YxuiKrsedEw1DawxG5R649Uc16cZ2uTVXctgqZYg7IgvZ0inQoZ
	kE5BEiWOD+JC1L+sa6avOts3n/jxhxonOGR1WJ7JYsGawHDbb2xSHFujB9RCY/yopModwqUANy2
	h+7g=
X-Google-Smtp-Source: AGHT+IEvBa0hrl+kogc4I8FzUMrSHkneR7bTpfzN5/rl3s2Uza/ABaW2Bf9Ndo6QneRpGwDZtFrP0Q==
X-Received: by 2002:a2e:8551:0:b0:2d4:6e5:2cd6 with SMTP id u17-20020a2e8551000000b002d406e52cd6mr455929ljj.25.1709947623080;
        Fri, 08 Mar 2024 17:27:03 -0800 (PST)
Received: from sleipner.berto.se (p4fcc8c6a.dip0.t-ipconnect.de. [79.204.140.106])
        by smtp.googlemail.com with ESMTPSA id 24-20020a508e58000000b00566f92f1facsm341474edx.36.2024.03.08.17.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 17:27:02 -0800 (PST)
From: =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
To: Sergey Shtylyov <s.shtylyov@omp.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Subject: [PATCH] dt-bindings: net: renesas,etheravb: Add MDIO bus reset properties
Date: Sat,  9 Mar 2024 02:25:38 +0100
Message-ID: <20240309012538.719518-1-niklas.soderlund+renesas@ragnatech.se>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The bindings for Renesas Ethernet AVB are from 2015 and contain some
oddities that are impossible to get right without breaking existing
bindings. One such thing is that the MDIO bus properties that should be
its own node are mixed with the node for the IP for Ethernet AVB.

Instead of a separate node for the MDIO bus,

    avb: ethernet@e6800000 {
            compatible = "renesas,etheravb-r8a7795",
                         "renesas,etheravb-rcar-gen3";
            reg = <0xe6800000 0x800>, <0xe6a00000 0x10000>;

            ...

            phy-handle = <&phy0>;

            mdio {
                #address-cells = <1>;
                #size-cells = <0>;

                phy0: ethernet-phy@0 {
                    ...
                };
            };
    };

The Ethernet AVB mix it in one,

    avb: ethernet@e6800000 {
            compatible = "renesas,etheravb-r8a7795",
                         "renesas,etheravb-rcar-gen3";
            reg = <0xe6800000 0x800>, <0xe6a00000 0x10000>;

            ...

            phy-handle = <&phy0>;

            #address-cells = <1>;
            #size-cells = <0>;

            phy0: ethernet-phy@0 {
                ...
            };
    };

This forces to all MDIO bus properties needed to be described in the
Ethernet AVB bindings directly. However not all MDIO bus properties are
described as they were not needed. This change adds the MDIO bus
properties to reset the MDIO bus in preparation for them being used.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
---
 .../bindings/net/renesas,etheravb.yaml        | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/renesas,etheravb.yaml b/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
index de7ba7f345a9..d87f00a25877 100644
--- a/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
+++ b/Documentation/devicetree/bindings/net/renesas,etheravb.yaml
@@ -93,6 +93,25 @@ properties:
     description: Number of size cells on the MDIO bus.
     const: 0
 
+  reset-gpios:
+    maxItems: 1
+    description:
+      The phandle and specifier for the GPIO that controls the RESET
+      lines of all devices on that MDIO bus.
+
+  reset-delay-us:
+    description:
+      RESET pulse width in microseconds. It applies to all MDIO devices
+      and must therefore be appropriately determined based on all devices
+      requirements (maximum value of all per-device RESET pulse widths).
+
+  reset-post-delay-us:
+    description:
+      Delay after reset deassert in microseconds. It applies to all MDIO
+      devices and it's determined by how fast all devices are ready for
+      communication. This delay happens just before e.g. Ethernet PHY
+      type ID auto detection.
+
   renesas,no-ether-link:
     type: boolean
     description:
-- 
2.44.0


