Return-Path: <netdev+bounces-213596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F38BB25C46
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 08:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B407E7BE72A
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 06:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC7725E471;
	Thu, 14 Aug 2025 06:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4iASkEt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04B325B2E3;
	Thu, 14 Aug 2025 06:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755154460; cv=none; b=d3xQBEq0GcxHl6q+Fa8hhul5Asv1WztrSs2igJ622DbxzLC4LEYfr/94prjFLBb126FdF12LkIjG20yfNVjA7z0l4J+YgikoYaODs81oQ0Ibd47h+CM1NhvZBpLsxFL+osVcVqCOb8phgmUCXduFRNp8plibDwZsG+dhfhMnAjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755154460; c=relaxed/simple;
	bh=/lc3ZUDptVmF1fktza6voWnNaIP3BzcMOlxMJI0s4Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDS5yfwhdJnneuetRlVTH10lVx/CNjxO8H0kcKmhzIOYbJbs0OrTm1M0bucgOzpHQfEHhuwNh24Wp6F1qBh6RjgbjfUjxKBkevHBv9Rl4msiTBJb6M/ilPW0DWxddWf2DHU2yr1wRR0wKdUwdWaJWFPYV2EFGp4LYYNkSv4UbQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d4iASkEt; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32326e5f0bfso618386a91.3;
        Wed, 13 Aug 2025 23:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755154456; x=1755759256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LYBTeEc5Yls0GWqvuqG4WcYM/86q5K/nfmkdqM+HnI=;
        b=d4iASkEth4IZLMUhPTRGil4E8giotMdc/pm8ycMsVsJuRw4kGGwwv7iGfR/nMHF9jc
         JYIsg5h44w+xDw4+NQU0PItZY8bFi7+Eptno+/ReD5JI7S+WtTU7XTrIgPYj+UC7OabX
         3FGQLqkMgv3Ys3pdw+WJ0Iu749eAOK6G3H9SndVq5qe9qfY7D+RzTH9bVbW2MOlYYzwp
         BjiRPzNUg3lHRmkn6njfHH+NIjxvkb8tU4OkRRmKbMeSqA+E0zrKmynv0ICIILrEKRga
         kmYdSQFk0waDu0fu/X0oAfLFYpFjjfE2OantNu6bWd7XRuqV/8GxR4IbpvqeDmXaWEtS
         qVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755154456; x=1755759256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LYBTeEc5Yls0GWqvuqG4WcYM/86q5K/nfmkdqM+HnI=;
        b=cOzOMjgvKd1a3z3HORxI7+6NdWy0T51fJ1uGKX8W55WQO+qnX/BUms293ijbzErGu8
         XlncSdcmXflnpu1zvBfSoVcc47aYRgAFKrtOv9uerb4XO4J+PywGzVpOhqwJ/Y/AjIlb
         Y7zpzGbCWRIWLKMjszNx2kQPVZ8S8KrGmZOcR9YIwLs3S7PtL0+3q6AOED04HVpvHcs9
         dKta8opwe6F5n73dmr0R2GGiKvgyhXzmXiyvBY6yU6QD/GtdCShaeCK0uFAJGhrbneSf
         wXofWdjllD0hnAJB3AECleFaeUELJ6V4QAzMxA988XTVA0mZY91yJsWpC4d/x5PUn2aF
         mZZw==
X-Forwarded-Encrypted: i=1; AJvYcCU+QEspsWtjvmmIlKX7RejA2DFA2LBYYa8NcPpiNsW/DqA9slTUpN8hKFADOYD4/wJSNdn167lbU+t5@vger.kernel.org, AJvYcCWdbC+Pe1uWn0bwZcHRcriewtYzl/d1ghx+051/0jVlKehWf7y57+H7xSBr/Y7pUXYVkWh2LZ2Qs7bXvS/W@vger.kernel.org
X-Gm-Message-State: AOJu0YwAyFtaafdmAifo3xu5XtvCh7IUs0gsR/jtMVs+3XM/sgL43chf
	veC0+4sCSAhHeV0WTzpCfF1cZFZXYv29r4SHhBlYGzRvRftlkrJu4IM3AUd6M1POIEQ=
X-Gm-Gg: ASbGncsreShZJOgBhKfG9PGWPXhsxP84VBt+IaOimwetAN/N8WNaJXNLtGZrz1NxvQ8
	GpYMLAdKlecwlgh++O7/pIVShEzjAxSpGIqKbDPK1Q3lQeZJ7LMDuGIAaUv0YoRRMhRY5nzh5nX
	kirWxRkC4EfTeWcV2AXDs/DVoGJiVTKs0OL1n4AGQoMH3Ld1x6OGDQw7sQxvbYxpdJ2ivSnRXpp
	sjoP9OQlSkyuBnbepMRWyWFigY8uJvvJQgUjBqQZt79HvwKRUlQpYeh5UCdAmE5hniJXHnVzfXN
	ujpNswnkdNAiNisxN78D9sGf4P6ETLvrfMUTc1Jv+j7Rd+XyIpqqg7BLvJy6yKEn3XGZZF8hrPY
	UQ4eHmLnVMxTJLOB0nwEFDf52Uu2fuQ==
X-Google-Smtp-Source: AGHT+IGQV7BFFd+F1+B/89hwATVyHCHm+l1JISvrJHcz6cxSjGE4h5mLFrKgqhx9+lt05ReEyoRlBA==
X-Received: by 2002:a17:90a:fc43:b0:311:9c1f:8522 with SMTP id 98e67ed59e1d1-3232b2396a8mr2584444a91.10.1755154455501;
        Wed, 13 Aug 2025 23:54:15 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([89.208.250.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7bb0c0sm28425078a12.20.2025.08.13.23.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 23:54:14 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next 1/3] dt-bindings: net: dsa: yt921x: Add Motorcomm YT921x switch support
Date: Thu, 14 Aug 2025 14:50:20 +0800
Message-ID: <20250814065032.3766988-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250814065032.3766988-1-mmyangfl@gmail.com>
References: <20250814065032.3766988-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Motorcomm YT921x series is a family of Ethernet switches with up to
8 internal GbE PHYs and up to 2 GMACs.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 .../bindings/net/dsa/motorcomm,yt921x.yaml    | 121 ++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml b/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
new file mode 100644
index 000000000000..2f0e4532e73e
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
@@ -0,0 +1,121 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/motorcomm,yt921x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Motorcomm YT921x Ethernet switch family
+
+maintainers:
+  - David Yang <mmyangfl@gmail.com>
+
+description: |
+  The Motorcomm YT921x series is a family of Ethernet switches with up to 8
+  internal GbE PHYs and up to 2 GMACs, including YT9213NB, YT9214NB, YT9215RB,
+  YT9215S, YT9215SC, YT9218N, YT9218MB.
+
+  For now, only YT9215 is supported.
+
+properties:
+  compatible:
+    const: motorcomm,yt9215
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    description: Optional gpio specifier for a reset line
+    maxItems: 1
+
+  motorcomm,switch-id:
+    description: |
+      When managed via mdio, hard-configured switch id to distinguish between
+      multiple devices.
+    enum: [0, 1, 2, 3]
+    default: 0
+
+  mdio:
+    $ref: /schemas/net/mdio.yaml#
+    unevaluatedProperties: false
+    description: MDIO bus for the internal GbE PHYs.
+
+  mdio-external:
+    $ref: /schemas/net/mdio.yaml#
+    unevaluatedProperties: false
+    description: External MDIO bus.
+
+    properties:
+      compatible:
+        const: motorcomm,yt921x-mdio-external
+
+    required:
+      - compatible
+
+allOf:
+  - $ref: dsa.yaml#/$defs/ethernet-ports
+
+required:
+  - compatible
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
+        switch@1d {
+            compatible = "motorcomm,yt9215";
+            reg = <0x1d>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    label = "lan1";
+                    phy-mode = "internal";
+                };
+
+                port@1 {
+                    reg = <1>;
+                    label = "lan2";
+                    phy-mode = "internal";
+                };
+
+                port@2 {
+                    reg = <2>;
+                    label = "lan3";
+                    phy-mode = "internal";
+                };
+
+                port@3 {
+                    reg = <3>;
+                    label = "lan4";
+                    phy-mode = "internal";
+                };
+
+                port@4 {
+                    reg = <4>;
+                    label = "wan";
+                    phy-mode = "internal";
+                };
+
+                port@8 {
+                    reg = <8>;
+                    phy-mode = "sgmii";
+                    ethernet = <&eth0>;
+
+                    fixed-link {
+                        speed = <1000>;
+                        full-duplex;
+                        pause;
+                        asym-pause;
+                    };
+                };
+            };
+        };
+    };
-- 
2.47.2


