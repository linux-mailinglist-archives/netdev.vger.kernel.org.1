Return-Path: <netdev+bounces-172725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F65EA55CFF
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 02:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8243A1223
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 01:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB031624F9;
	Fri,  7 Mar 2025 01:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyQlDq6x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914A21624EA;
	Fri,  7 Mar 2025 01:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741310223; cv=none; b=lOXytokcR3V1EvgKkSL/hfiYfw/gCtNgRqETbP3dhTcnOy02DP64N81RCB0CNX7kkhgoJJN/WntUju2z4RE1usiLvqCFuIUtpJJkp7HhVbg//svxWLW1eljkBs3OYdxLs7RUR90IrLaYESmP83akrNhcSLzhSjdOHgBv6fNyDHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741310223; c=relaxed/simple;
	bh=2YOxMZ1rJ9grCKYeT9RzYTopZh2N4KaVA4yfVafpMYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZNL1dTvmJmaNqRkv081D7o/P4ABmtxYB3Y7kL+PSsabt5SLf9RRAUJvJmuFv1Sb6Nwd1P25nwtfVY1xcJxRRVq2Xy0Npa8nLUqdZ9mNuYZG9cBLDPc40JxuxL8ZwirkQRNtn1vTkS2ohqFlJEYlZbQVvlKoTHtjHE4G3jfro+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyQlDq6x; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6dd420f82e2so17519136d6.1;
        Thu, 06 Mar 2025 17:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741310220; x=1741915020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hjmCOU7/uhA2+L6wbt2c30nT+R/zwMCwKB+eVYC894=;
        b=HyQlDq6xB7k37nir9KumHTi9C45xsVVykIRbiRA3mTmPgPuQ9tl6e/LPRMOojic4Qq
         pyAhxYT0poQtvtV6WGtH23nqSilLHtowAbI3NbIq6/48OD19LWPqmvpObev5EWO+bNgM
         M4WCrGo87SMF2Xn2kkSpn+njqvBFoKQmBJbPSwmLFPWjcqWLrIrTU3Mdkebun9l9dMFk
         DQgHi8anR5IHBpcWGFQVEkN9j+rU82VgyJ8cJan15dijeFrT9pWpN3RJwZdT04vwj2bR
         q6xWuI05bM3xKyfvu9mCmG/S4yySMUbj/yABojYoeZpsXMtmtXcAgMv9eGUG4GPpJfIZ
         tQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741310220; x=1741915020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hjmCOU7/uhA2+L6wbt2c30nT+R/zwMCwKB+eVYC894=;
        b=Ot4FlHpn/cCH7z0cZHQgLkg486bXUY9I2ZJHHUSCwtVvj4+mzIw9PenypF4HX1WhCb
         +1UibPLkBngI7XXVo8mzJvLE5SRW+6BkgpRCkhagRPCd9yqP5ZTNKX848UVCH8EU3G+e
         i5ts6vHJLNOjWcskj6bdiNb4xxaIQW3okgTdHBPGTYHERxor0YYQgCmN05KWUxWfIkuF
         72VhpPXDewy1DZtOGPwLJF3LAp3NjBBbSXD3z4gRFMobEklPgZ/dREqzJJ6lJvYXU0kq
         yBhIGiUzRzimr9v6VZ+DJKJRgdP/NrF19hQooxele7G/5258WnegiLUufk/ocxVg9I5Y
         Zu6A==
X-Forwarded-Encrypted: i=1; AJvYcCVZgTCsbWGBu0sxeQN4DV6AChOMmAzFk2+VA3DCWbG7YqV+sJugnBJo76z+lNatQpErB+VeWTKO@vger.kernel.org, AJvYcCW2mYwaOr35g8Gy5I6/tyhJtIo9omde59qWw8CeAaFYpt7ChbxNloi/IPJmsRccRT/3W5sw3EQWPbzGaoOd@vger.kernel.org, AJvYcCXD4vLOAJWPIZZ5nq0pmFsH/LT674M+oeKsPpNnD8DjI2K7AVi66HMlJE1R5WrL9SXOOyvLD++NgatQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxtIvXmKTEc/OmQSIqLQAS2GYdqY8i6wOuL6OP3V/RLREmvCAG2
	Kn2yKhz2t/hcpPGuBlbPK+fdncoIG/SipqfOvD7h36uH5igXTtpL
X-Gm-Gg: ASbGncswjZx8z5iNcMle/Wv38ex0uYMJ3SqRZkw0PpGUcTCxnaU0AXPW1HMZrN1Nkwf
	bP2GlptdRuNedvoKGbEAAIkI2IiSMPLaRw6QcbwJGAyo18jTQimoSFHv6qw1NluBPrwwE4NneGi
	mM5y8rLDR6/0rVugp3ZrrbyhZ8nOxIVsqKnWv9QYDKf62Q+xlklrUwQYZuGLdaZJ6noXJmc5UG9
	YgYXODsboormT5t6iHYbALG0OqgqQd7l5QaYI2XmaNiH8aI8I3XSXGhLndqx+CGP2agV6WK5oFK
	e5hZ0nN0FVlSeeSvg9uj
X-Google-Smtp-Source: AGHT+IGLrdmWP/DPnT7w5ju6tPX8ko4QQGUEjeJXPFNnzgqBis94wAJsjfYZjIZPTsiSqztQL3GYoQ==
X-Received: by 2002:a05:6214:b69:b0:6e4:442c:2888 with SMTP id 6a1803df08f44-6e9006cb8e2mr17002256d6.39.1741310220402;
        Thu, 06 Mar 2025 17:17:00 -0800 (PST)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4751d96f378sm13978491cf.30.2025.03.06.17.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 17:16:59 -0800 (PST)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <olteanv@gmail.com>,
	Furong Xu <0x1207@gmail.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>,
	Lothar Rubusch <l.rubusch@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Jose Abreu <joabreu@synopsys.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next v7 1/4] dt-bindings: net: Add support for Sophgo SG2044 dwmac
Date: Fri,  7 Mar 2025 09:16:14 +0800
Message-ID: <20250307011623.440792-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307011623.440792-1-inochiama@gmail.com>
References: <20250307011623.440792-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GMAC IP on SG2044 is almost a standard Synopsys DesignWare
MAC (version 5.30a) with some extra clock.

Add necessary compatible string for this device.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/net/snps,dwmac.yaml   |   4 +
 .../bindings/net/sophgo,sg2044-dwmac.yaml     | 126 ++++++++++++++++++
 2 files changed, 130 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index c7004eaa8eae..3f0aa46d798e 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -32,6 +32,7 @@ select:
           - snps,dwmac-4.20a
           - snps,dwmac-5.10a
           - snps,dwmac-5.20
+          - snps,dwmac-5.30a
           - snps,dwxgmac
           - snps,dwxgmac-2.10
 
@@ -98,8 +99,10 @@ properties:
         - snps,dwmac-4.20a
         - snps,dwmac-5.10a
         - snps,dwmac-5.20
+        - snps,dwmac-5.30a
         - snps,dwxgmac
         - snps,dwxgmac-2.10
+        - sophgo,sg2044-dwmac
         - starfive,jh7100-dwmac
         - starfive,jh7110-dwmac
         - tesla,fsd-ethqos
@@ -632,6 +635,7 @@ allOf:
                 - snps,dwmac-4.20a
                 - snps,dwmac-5.10a
                 - snps,dwmac-5.20
+                - snps,dwmac-5.30a
                 - snps,dwxgmac
                 - snps,dwxgmac-2.10
                 - st,spear600-gmac
diff --git a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
new file mode 100644
index 000000000000..4dd2dc9c678b
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
@@ -0,0 +1,126 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/sophgo,sg2044-dwmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo SG2044 DWMAC glue layer
+
+maintainers:
+  - Inochi Amaoto <inochiama@gmail.com>
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - sophgo,sg2044-dwmac
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - const: sophgo,sg2044-dwmac
+      - const: snps,dwmac-5.30a
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: GMAC main clock
+      - description: PTP clock
+      - description: TX clock
+
+  clock-names:
+    items:
+      - const: stmmaceth
+      - const: ptp_ref
+      - const: tx
+
+  dma-noncoherent: true
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: stmmaceth
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+  - resets
+  - reset-names
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    ethernet@30006000 {
+      compatible = "sophgo,sg2044-dwmac", "snps,dwmac-5.30a";
+      reg = <0x30006000 0x4000>;
+      clocks = <&clk 151>, <&clk 152>, <&clk 154>;
+      clock-names = "stmmaceth", "ptp_ref", "tx";
+      interrupt-parent = <&intc>;
+      interrupts = <296 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "macirq";
+      resets = <&rst 30>;
+      reset-names = "stmmaceth";
+      snps,multicast-filter-bins = <0>;
+      snps,perfect-filter-entries = <1>;
+      snps,aal;
+      snps,tso;
+      snps,txpbl = <32>;
+      snps,rxpbl = <32>;
+      snps,mtl-rx-config = <&gmac0_mtl_rx_setup>;
+      snps,mtl-tx-config = <&gmac0_mtl_tx_setup>;
+      snps,axi-config = <&gmac0_stmmac_axi_setup>;
+      status = "disabled";
+
+      gmac0_mtl_rx_setup: rx-queues-config {
+        snps,rx-queues-to-use = <8>;
+        snps,rx-sched-wsp;
+        queue0 {};
+        queue1 {};
+        queue2 {};
+        queue3 {};
+        queue4 {};
+        queue5 {};
+        queue6 {};
+        queue7 {};
+      };
+
+      gmac0_mtl_tx_setup: tx-queues-config {
+        snps,tx-queues-to-use = <8>;
+        queue0 {};
+        queue1 {};
+        queue2 {};
+        queue3 {};
+        queue4 {};
+        queue5 {};
+        queue6 {};
+        queue7 {};
+      };
+
+      gmac0_stmmac_axi_setup: stmmac-axi-config {
+        snps,blen = <16 8 4 0 0 0 0>;
+        snps,wr_osr_lmt = <1>;
+        snps,rd_osr_lmt = <2>;
+      };
+    };
-- 
2.48.1


