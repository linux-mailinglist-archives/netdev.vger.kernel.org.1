Return-Path: <netdev+bounces-107093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9385919BF0
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 02:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 353B61F22D34
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 00:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150CD1CD32;
	Thu, 27 Jun 2024 00:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOqb6FeS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA591CAB8;
	Thu, 27 Jun 2024 00:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719448933; cv=none; b=k3dE6vtuuY2cI1GHd68ATKV6BHf5Opjr2KbNiHKuGSjU2XKRhi97/tLXGoz3ZNzTzQ/q/wM8rt2TqDobVm3nEBKB6jVQqENug522FhtoWLdNML8eyvESK8WpThqr3eL57lyyrdJxOnO8mGQg0VWMTwN83wd2oNTXDy8zQ3QJ1jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719448933; c=relaxed/simple;
	bh=BtXiWse5a98o65/eZVQPb0b2C5Vyuh7oDFMyfxrKP6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PuIEjKot9iP3DUyNLSAKC/8Bkf9h3pK083wwNkR3eaxiar81UOAuU850djnaf6dR96V1TgmQ4u0ELfEqilQpMTJzY7MKwDMpgFC2r7ocvfdzzamlaVZAAgWZkfHgQRJrhfq3XKHVbo6+fubAJ1rjqWuIh8XiODkYAZDmWDWXE8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOqb6FeS; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52ce9ba0cedso5078493e87.2;
        Wed, 26 Jun 2024 17:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719448928; x=1720053728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sluU/GzQocR6QDFGF+L1FupcjsbjyxVkgp7GVqXJiqo=;
        b=QOqb6FeSsB9VVKoHwRGIdp7gpmiYPFOOlYhO5uVGcyDIihRQFjcHUbROl51EE5gZvb
         gA5VZiyN4R/sHagBkZG11G/De6O0nUc3WjAvgyI3rCgzzQFsDjQYWgOvYT8FM3PKxZr0
         2sRMSOv76f674vaLIR3qC6gdKC644rGmw+I8AIOHuKwtpJdIoq/GYrEOKYgHeoCCeg4C
         h/QmdEjPlu2ryi97qgIgVZgREQKwN/bcZ82Gb6D6Ch/3kkuD6rSeyA9dYfxWHA57nLDB
         YuFtsub/qf2AO8U+q1iMU6sUuPdlrwCFOwk9j7SovgqgQuYePfYWLHlpipjNgi22jAdY
         w9Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719448928; x=1720053728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sluU/GzQocR6QDFGF+L1FupcjsbjyxVkgp7GVqXJiqo=;
        b=CORnU3JuWDwgiE7lIcc6dzuy0E2pDrw8WF7jQ2OA0DmwON6g+FhN+7sqhhCCZJuXZT
         882N3/tWgxAWLVKtf6u0x4UaGAYmgIgSHYU0ic/rKiCkEx05hnKmnpFK9YMcncsJM67D
         8aIeZaHNlu1lubK4OV0hcya8XRvmMRnP0PlFv6jwTX99nn3qIQioxP7iDXFhgiPBkNw8
         laKr3CnEG78V4D9Dg8uKAW5VnqmmNeMN6kVIvUNvZMN3l9GQ23B+UnpGeOxnvQ4kItZu
         EIl8iI33eZhFAAyMojUaX6r/BRIPqQzDGtfso2jl98hIP1pRSS4zdTBw4mtg9/Pgl89K
         VcRw==
X-Forwarded-Encrypted: i=1; AJvYcCVcrMwDYq2FLnzwBLf8/R3Whz8qYrNY8knGcmjQM1mmNNqTfmlbL00TGMLEY8PHIrUhEPa4hAwUzxPbL9LpUaLXLbciyhhEfhSGPezYLi93xWqGaRu76RfaFiku4W/JYEaiGIb1vC5VOGwP8JedC4DaTNWurTUKhPqsP07WBBzxNA==
X-Gm-Message-State: AOJu0YzeLD6ieyNU925GIQEx49DdIdYL77tOyvKUe/nZiXWE5pwGFvSb
	R1aPnUV+V5VMSF90STZ/YDQ3XUBAE6wWTl64bb9Y1kEQDP82EZRW
X-Google-Smtp-Source: AGHT+IH/sFKlKiclYptlD5g6EMH+IfqUiJQ2oppdovVvXz/PCeqJa/8zBei5kHUoeLDCLgkh7vdY2A==
X-Received: by 2002:a05:6512:3056:b0:52c:e10b:cb33 with SMTP id 2adb3069b0e04-52ce18523bbmr11334696e87.50.1719448927963;
        Wed, 26 Jun 2024 17:42:07 -0700 (PDT)
Received: from localhost ([89.113.147.248])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e712a764fsm20196e87.25.2024.06.26.17.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 17:42:07 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Sagar Cheluvegowda <quic_scheluve@quicinc.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 06/10] dt-bindings: net: Add Synopsys DW xPCS bindings
Date: Thu, 27 Jun 2024 03:41:26 +0300
Message-ID: <20240627004142.8106-7-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627004142.8106-1-fancer.lancer@gmail.com>
References: <20240627004142.8106-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Synopsys DesignWare XPCS IP-core is a Physical Coding Sublayer (PCS) layer
providing an interface between the Media Access Control (MAC) and Physical
Medium Attachment Sublayer (PMA) through a Media independent interface.
From software point of view it exposes IEEE std. Clause 45 CSR space and
can be accessible either by MDIO or MCI/APB3 bus interfaces. In the former
case the PCS device is supposed to be defined under the respective MDIO
bus DT-node. In the later case the DW xPCS will be just a normal IO
memory-mapped device.

Besides of that DW XPCS DT-nodes can have an interrupt signal and clock
source properties specified. The former one indicates the Clause 73/37
auto-negotiation events like: negotiation page received, AN is completed
or incompatible link partner. The clock DT-properties can describe up to
three clock sources: peripheral bus clock source, internal reference clock
and the externally connected reference clock.

Finally the DW XPCS IP-core can be optionally synthesized with a
vendor-specific interface connected to the Synopsys PMA (also called
DesignWare Consumer/Enterprise PHY). Alas that isn't auto-detectable in a
portable way. So if the DW XPCS device has the respective PMA attached
then it should be reflected in the DT-node compatible string so the driver
would be aware of the PMA-specific device capabilities (mainly connected
with CSRs available for the fine-tunings).

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v2:
- Drop the Management Interface DT-node bindings. DW xPCS with MCI/APB3
  interface is just a normal memory-mapped device.

Changelog v3:
- Implement the ordered clocks constraint. (@Rob)
---
 .../bindings/net/pcs/snps,dw-xpcs.yaml        | 136 ++++++++++++++++++
 1 file changed, 136 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml

diff --git a/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml b/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
new file mode 100644
index 000000000000..d0f2c2bfbf35
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
@@ -0,0 +1,136 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/pcs/snps,dw-xpcs.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DesignWare Ethernet PCS
+
+maintainers:
+  - Serge Semin <fancer.lancer@gmail.com>
+
+description:
+  Synopsys DesignWare Ethernet Physical Coding Sublayer provides an interface
+  between Media Access Control and Physical Medium Attachment Sublayer through
+  the Media Independent Interface (XGMII, USXGMII, XLGMII, GMII, etc)
+  controlled by means of the IEEE std. Clause 45 registers set. The PCS can be
+  optionally synthesized with a vendor-specific interface connected to
+  Synopsys PMA (also called DesignWare Consumer/Enterprise PHY) although in
+  general it can be used to communicate with any compatible PHY.
+
+  The PCS CSRs can be accessible either over the Ethernet MDIO bus or directly
+  by means of the APB3/MCI interfaces. In the later case the XPCS can be mapped
+  right to the system IO memory space.
+
+properties:
+  compatible:
+    oneOf:
+      - description: Synopsys DesignWare XPCS with none or unknown PMA
+        const: snps,dw-xpcs
+      - description: Synopsys DesignWare XPCS with Consumer Gen1 3G PMA
+        const: snps,dw-xpcs-gen1-3g
+      - description: Synopsys DesignWare XPCS with Consumer Gen2 3G PMA
+        const: snps,dw-xpcs-gen2-3g
+      - description: Synopsys DesignWare XPCS with Consumer Gen2 6G PMA
+        const: snps,dw-xpcs-gen2-6g
+      - description: Synopsys DesignWare XPCS with Consumer Gen4 3G PMA
+        const: snps,dw-xpcs-gen4-3g
+      - description: Synopsys DesignWare XPCS with Consumer Gen4 6G PMA
+        const: snps,dw-xpcs-gen4-6g
+      - description: Synopsys DesignWare XPCS with Consumer Gen5 10G PMA
+        const: snps,dw-xpcs-gen5-10g
+      - description: Synopsys DesignWare XPCS with Consumer Gen5 12G PMA
+        const: snps,dw-xpcs-gen5-12g
+
+  reg:
+    items:
+      - description:
+          In case of the MDIO management interface this just a 5-bits ID
+          of the MDIO bus device. If DW XPCS CSRs space is accessed over the
+          MCI or APB3 management interfaces, then the space mapping can be
+          either 'direct' or 'indirect'. In the former case all Clause 45
+          registers are contiguously mapped within the address space
+          MMD '[20:16]', Reg '[15:0]'. In the later case the space is divided
+          to the multiple 256 register sets. There is a special viewport CSR
+          which is responsible for the set selection. The upper part of
+          the CSR address MMD+REG[20:8] is supposed to be written in there
+          so the corresponding subset would be mapped to the lowest 255 CSRs.
+
+  reg-names:
+    items:
+      - enum: [ direct, indirect ]
+
+  reg-io-width:
+    description:
+      The way the CSRs are mapped to the memory is platform depended. Since
+      each Clause 45 CSR is of 16-bits wide the access instructions must be
+      two bytes aligned at least.
+    default: 2
+    enum: [ 2, 4 ]
+
+  interrupts:
+    description:
+      System interface interrupt output (sbd_intr_o) indicating Clause 73/37
+      auto-negotiation events':' Page received, AN is completed or incompatible
+      link partner.
+    maxItems: 1
+
+  clocks:
+    description:
+      Both MCI and APB3 interfaces are supposed to be equipped with a clock
+      source connected via the clk_csr_i line.
+
+      PCS/PMA layer can be clocked by an internal reference clock source
+      (phyN_core_refclk) or by an externally connected (phyN_pad_refclk) clock
+      generator. Both clocks can be supplied at a time.
+    minItems: 1
+    maxItems: 3
+
+  clock-names:
+    oneOf:
+      - minItems: 1
+        items:
+          - enum: [core, pad]
+          - const: pad
+      - minItems: 1
+        items:
+          - const: pclk
+          - enum: [core, pad]
+          - const: pad
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    ethernet-pcs@1f05d000 {
+      compatible = "snps,dw-xpcs";
+      reg = <0x1f05d000 0x1000>;
+      reg-names = "indirect";
+
+      reg-io-width = <4>;
+
+      interrupts = <79 IRQ_TYPE_LEVEL_HIGH>;
+
+      clocks = <&ccu_pclk>, <&ccu_core>, <&ccu_pad>;
+      clock-names = "pclk", "core", "pad";
+    };
+  - |
+    mdio-bus {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      ethernet-pcs@0 {
+        compatible = "snps,dw-xpcs";
+        reg = <0>;
+
+        clocks = <&ccu_core>, <&ccu_pad>;
+        clock-names = "core", "pad";
+      };
+    };
+...
-- 
2.43.0


