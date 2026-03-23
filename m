Return-Path: <netdev+bounces-270457-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EE2aCAYVwWn5QQQAu9opvQ
	(envelope-from <netdev+bounces-270457-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:25:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B75A2EFFCE
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9172330435F6
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 10:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF0338B122;
	Mon, 23 Mar 2026 10:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKMGs0fF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D08738B145
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 10:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774261089; cv=none; b=j42r3EocsY++s1gwUG2IHmQlPFpJOzvDajodm2v0c5UDStAUNzfp5cVxpcdS/nOaaG+oGiQ+uAzwZjoO2G4VhQX1fdjdV4N+aihdVA666WyQA9kv2S2bUFaEC1+nlseGjJyzsBc+4mIgstT5h9p7qQ+gWOtsa3jKfn+EDc1tWFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774261089; c=relaxed/simple;
	bh=inaWaAqFrl/RRSGGSiCftox16Qz2GHyEHZxNuyQj1Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFONmlJgahONxna9Ci8pMfaDoHv0YK/SrlTrwz8OKo/dezsiQXVCnxoDwzPTUdIGAOkerwqAkXxHKDsL9sHAuZtI87hUu+P87J4r8oAnFfL58QRSyu02DdHX2W97abosaMvzuY9OXHn2KMwIk/4w9p5zCyeau0hAr9eH9+/63WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKMGs0fF; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8299f1ca894so2463838b3a.2
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 03:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774261088; x=1774865888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oyXu0gtjiBhx9nuUYM0Mf+9SNK/PonIri6dLaS9aeOY=;
        b=DKMGs0fFXDTxj0LwCACalOF2w9xVMtJcbttiLmCaCXPgbaEsxum48NmO4XuDIQwdZ6
         7gWv8qO61X7w1q+EdYNbHZWZWyTZ2WNApzAwcUtzc7Du5WalB3oexwrTJP6yU/+o7GC/
         RN7RHsNPHyQJEfF32fGa8QUQPvm2yaoHjVBRfvvPLO0Tin03TdvWKMWExgXhH82mou6z
         +6Fd1w32I51iiTAlkB/xJ7IzncfvOn1ApGbB8jA/AavT9TbG4zK8g3llZeeZ8gVGGXjZ
         EKftQJRyvFs4aNtYZRfXbyEek7BKQRLSxWIZMsXHz0vjnmhSxXCdsrH2qAzjTpimVKv+
         CBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774261088; x=1774865888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oyXu0gtjiBhx9nuUYM0Mf+9SNK/PonIri6dLaS9aeOY=;
        b=UYKy/H5lgW4Wr4Wd2bKc7EBn0/o7qEvgP9dE6EC3bD1N511XVg8WxhGQWfkVtv4+uI
         tJh6pYsZOSLUaRYchB3zZMpV3H1bKfLaEQvh1fU5LYaH8goByemDWddYBxWjXCH1L0JZ
         xy0wOy9NC8h12xDJqoVZnVdYh+mpzW+XJyhwXGuI6wbp6p7y8xwYGt6dzYoo0agQHJjf
         U0ekV7iGCOpzz1iD4qFPGBJub0qUV58VzmGmyi6W9WsLq7nHILQdeXa+piwzFcgiJfFp
         tnPj764woMWnOm1M6YxeGTu9OP84kBJtaEDRlYa8rCdAte7X3ZAWe3LbLT19IVV5w+LC
         iDrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8ebOjZQAnKljeeKF6Ej6sC/IgrGshhos01hbJHvfP+6763hpccK0quKisQ/4rCGCLXH5YST0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7xsv9mlwmXQxbQaU8NqB6LNFoiuOyG1bXCtQPctCBp84KkFa0
	xwxxBvbsUTIHOL23Dikcz1qMvSl6RjUfz/xLoARjWLgbKfm2KA1NTgdg
X-Gm-Gg: ATEYQzzU8PA5WadW/tOcGmWJrdHeHxpbr67UoKYENCyCt3oK3D1WcLklPaSWH99K4Xb
	ijbdOtGraUOcvOB1atrasGEyrHp7zsuRXBKw5+CWM+X19cwNfsZzjtpWWUpT1ZVHWqh1lktMbkQ
	euzz/P0YLzOAjtXo70lUpwhMMRS+YBGhPRCLp9vERWtNmZ1NHVUGjab76GJjae5FyTxerFiL1Eh
	7+IP4IeerfB7msdjsfA4OVfaVylZgJTSuE2BFP1508RL1u0cyWXyil3k4yZVpYKPr5+mOQBhRYy
	5uSWYGg6lR5qJda7sZPelKbC9JfdsMeXmCogMpjKGFzWtp8lsGkIBidRfflNKqkNUOGs06qy1lc
	4parP6i0bRgaMXubgyx5sPJkU5dN4o0Mpj6xOwDUhSRzbxoFphQHw/j/+YdjjamccmLeoVkOhW8
	itQj+aCMVZSGOewEIXkQLsRkCcVCrlkMR6o2fvZijDVv7I9ePJSrEyLP+PpCkgEtNYTP2UIG5+k
	K+4LeHF/iC2vEkj7xrOWX8=
X-Received: by 2002:a05:6a00:1c83:b0:829:9f46:280d with SMTP id d2e1a72fcca58-82a8c23fb65mr8571011b3a.1.1774261088009;
        Mon, 23 Mar 2026 03:18:08 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b04220d9asm8630779b3a.60.2026.03.23.03.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 03:18:07 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com,
	richardcochran@gmail.com
Cc: alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	ychuang3@nuvoton.com,
	schung@nuvoton.com,
	yclu4@nuvoton.com,
	peppe.cavallaro@st.com,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Joey Lu <a0987203069@gmail.com>
Subject: [PATCH net-next v15 1/3] dt-bindings: net: nuvoton: Add schema for Nuvoton MA35 family GMAC
Date: Mon, 23 Mar 2026 18:17:54 +0800
Message-ID: <20260323101756.81849-2-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323101756.81849-1-a0987203069@gmail.com>
References: <20260323101756.81849-1-a0987203069@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[foss.st.com,synopsys.com,nuvoton.com,st.com,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,st-md-mailman.stormreply.com,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-270457-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a0987203069@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,0.0.0.0:email,nuvoton.com:email,2.100.46.192:email,devicetree.org:url]
X-Rspamd-Queue-Id: 1B75A2EFFCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Create initial schema for Nuvoton MA35 family Gigabit MAC.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Joey Lu <a0987203069@gmail.com>
---
 .../bindings/net/nuvoton,ma35d1-dwmac.yaml    | 140 ++++++++++++++++++
 .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
 2 files changed, 141 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml

diff --git a/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml b/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
new file mode 100644
index 000000000000..ab18702e53f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/nuvoton,ma35d1-dwmac.yaml
@@ -0,0 +1,140 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/nuvoton,ma35d1-dwmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton DWMAC glue layer controller
+
+maintainers:
+  - Joey Lu <yclu4@nuvoton.com>
+
+description:
+  Nuvoton 10/100/1000Mbps Gigabit Ethernet MAC Controller is based on
+  Synopsys DesignWare MAC (version 3.73a).
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - nuvoton,ma35d1-dwmac
+  required:
+    - compatible
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: nuvoton,ma35d1-dwmac
+      - const: snps,dwmac-3.70a
+
+  reg:
+    maxItems: 1
+    description:
+      Register range should be one of the GMAC interface.
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: MAC clock
+      - description: PTP clock
+
+  clock-names:
+    items:
+      - const: stmmaceth
+      - const: ptp_ref
+
+  nuvoton,sys:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to access syscon registers.
+          - description: GMAC interface ID.
+            enum:
+              - 0
+              - 1
+    description:
+      A phandle to the syscon with one argument that configures system registers
+      for MA35D1's two GMACs. The argument specifies the GMAC interface ID.
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: stmmaceth
+
+  phy-mode:
+    enum:
+      - rmii
+      - rgmii
+      - rgmii-id
+      - rgmii-txid
+      - rgmii-rxid
+
+  tx-internal-delay-ps:
+    default: 0
+    minimum: 0
+    maximum: 2000
+    description:
+      RGMII TX path delay used only when PHY operates in RGMII mode with
+      internal delay (phy-mode is 'rgmii-id' or 'rgmii-txid') in pico-seconds.
+      Allowed values are from 0 to 2000.
+
+  rx-internal-delay-ps:
+    default: 0
+    minimum: 0
+    maximum: 2000
+    description:
+      RGMII RX path delay used only when PHY operates in RGMII mode with
+      internal delay (phy-mode is 'rgmii-id' or 'rgmii-rxid') in pico-seconds.
+      Allowed values are from 0 to 2000.
+
+required:
+  - clocks
+  - clock-names
+  - nuvoton,sys
+  - resets
+  - reset-names
+  - phy-mode
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
+    ethernet@40120000 {
+        compatible = "nuvoton,ma35d1-dwmac", "snps,dwmac-3.70a";
+        reg = <0x40120000 0x10000>;
+        interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "macirq";
+        clocks = <&clk EMAC0_GATE>, <&clk EPLL_DIV8>;
+        clock-names = "stmmaceth", "ptp_ref";
+
+        nuvoton,sys = <&sys 0>;
+        resets = <&sys MA35D1_RESET_GMAC0>;
+        reset-names = "stmmaceth";
+        snps,multicast-filter-bins = <0>;
+        snps,perfect-filter-entries = <8>;
+        rx-fifo-depth = <4096>;
+        tx-fifo-depth = <2048>;
+
+        phy-mode = "rgmii-id";
+        phy-handle = <&eth_phy0>;
+        mdio {
+            compatible = "snps,dwmac-mdio";
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            eth_phy0: ethernet-phy@0 {
+                reg = <0>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 98ebb6276bc6..c25903c74484 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -69,6 +69,7 @@ properties:
         - ingenic,x2000-mac
         - loongson,ls2k-dwmac
         - loongson,ls7a-dwmac
+        - nuvoton,ma35d1-dwmac
         - nxp,s32g2-dwmac
         - qcom,qcs404-ethqos
         - qcom,sa8775p-ethqos
-- 
2.43.0


