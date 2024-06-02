Return-Path: <netdev+bounces-99993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C73F8D7653
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 16:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4590281444
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 14:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30916EB73;
	Sun,  2 Jun 2024 14:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llpKECYN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D7B664C6;
	Sun,  2 Jun 2024 14:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717339017; cv=none; b=Mp3qW2yrCAgOUiYvZjVqc7rckb3MvktLQWhzxJhT7rPMP/BYv2XR6XeVanRWDx49DAAUFtYNJFjT3rRGarMspgxqXvKNglDxOyycdhoS1xj7Ad7FTV2cFtnmuJPXh/S0hafBIa45asxEBYJrNRXzZICaIqWVKAYcTZ7M6bZAUhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717339017; c=relaxed/simple;
	bh=GHLa9eW7nXLKJN7GAD/YbS+QvkHmlF6GBBzmHwVUH8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjcQ9hQuXgk1pCqq6qQyR4HHpHI5zn9Y+0ivRxikM0VJiQDjLImbdb82wHmUjaHYWkp8J16X/BQPiFvrU8D+x3xXDT6vEEV6d6CphuqYRXi5SC8OMmQPhxFG5/5nQkIZfwhmq84bwGsFtmRrbPymomPAY3PUYBLsw4ziVtu75E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llpKECYN; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52b8e0e98adso2511481e87.0;
        Sun, 02 Jun 2024 07:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717339014; x=1717943814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dl+LGarOyxT8j4YojtyaSAfvFQWXeJMpYxDCX8TzbE4=;
        b=llpKECYNGlbJa0Nk5hYu/22IzEa+WLX4KOVxlCPjQE/A+1CyteiQo5/vR3CGc/7FE8
         3qGDyX+AFH6Jt7qoEj9LgPQ3cDN46Vv1A0HJYbPsCW48ibb7lBxCmOyM1P6w1+tYiNFU
         EX1eVBXzxRlm8SxCe/diyBqF/bT+UfbvcQsA/j4V9ayoL/fPkuuH/T1/yg2wi7XHw3WY
         mArePKfv6oZuiJtVuZMC+7pc2PW/ZlodADS/4ITR3f0tNEU5XrW6Y9ebpTvHOUFASx95
         /QsPaKuUoo0X6flYAYLLJ1yquESHJ3EWfO2BVAbs8AfL+sL/RGSsW73K/OWjT3886M4N
         cfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717339014; x=1717943814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dl+LGarOyxT8j4YojtyaSAfvFQWXeJMpYxDCX8TzbE4=;
        b=kvZwx4WkSA8+NbsjBlz3gH8gU1fgg+1UAhMdXazPIE6sqSLSNQWPan5qKV0uQpgr1i
         nhPk5e0rnCutscD+tDm3Ef4YKtG/j1uO46wyRAlCizH3tWgQhgrbdr4kyAqSXH+t0jKk
         Bk9qxT01zs0oEHJ9wilytJ5TGcuzFyk/80C1FPZrhOPPgPTzsZFMgBSeyvpVWOe6WDHX
         ox4S5mencF3dFEtEutxAFUyPViryVmBO6cYqa0hmZttBXcGFaY1VFJ1KFx2jq1fM31nx
         l8YlmMp96tHy9xzwiUNYocyrY+m6v6+vDVFzvz6utd4PqDK7GmYPbFKBoDWi/LL0REQ3
         FzOg==
X-Forwarded-Encrypted: i=1; AJvYcCUku9v+46ySDgA0CLoKbWoSFLrRT5Djzisv8uR9wTlvHJyAfZKSfn+0wfL7++3xnX6h9f22vhn5QGCzrzf07aY5RyMHH5HBYxnWfUmhAa1pm6ouJh7NkZS0kSU/gjTak30mszJrIJTkdG5yx+4gkiga5eIoZAri/ngU2n9nBZQDew==
X-Gm-Message-State: AOJu0Yy//5nXHfC7ZZ6IqE93fpGgwK9zx08xz/ipOoQKu7NcxY8kSz6s
	hkUDb2WNDbIGCGUE6vMmhJ9Sisitwyg7atOUxq7UXz9J1MTi37df
X-Google-Smtp-Source: AGHT+IG9A9+aPM7LWHLUZMZ13ql+h6wgBzijmSAf5TnSE582UtzoIEOPiQkQaci+dc385JZ92IKbhg==
X-Received: by 2002:a19:384d:0:b0:529:c0c6:faad with SMTP id 2adb3069b0e04-52b89596984mr4646645e87.28.1717339014019;
        Sun, 02 Jun 2024 07:36:54 -0700 (PDT)
Received: from localhost ([178.178.142.64])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d764bbsm956841e87.179.2024.06.02.07.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 07:36:53 -0700 (PDT)
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
	Rob Herring <robh@kernel.org>
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
Subject: [PATCH net-next v2 06/10] dt-bindings: net: Add Synopsys DW xPCS bindings
Date: Sun,  2 Jun 2024 17:36:20 +0300
Message-ID: <20240602143636.5839-7-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240602143636.5839-1-fancer.lancer@gmail.com>
References: <20240602143636.5839-1-fancer.lancer@gmail.com>
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
---
 .../bindings/net/pcs/snps,dw-xpcs.yaml        | 133 ++++++++++++++++++
 1 file changed, 133 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml

diff --git a/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml b/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
new file mode 100644
index 000000000000..7927bceefbf3
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/pcs/snps,dw-xpcs.yaml
@@ -0,0 +1,133 @@
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
+    minItems: 1
+    maxItems: 3
+    anyOf:
+      - items:
+          enum: [ core, pad ]
+      - items:
+          enum: [ pclk, core, pad ]
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


