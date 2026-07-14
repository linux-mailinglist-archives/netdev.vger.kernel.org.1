Return-Path: <netdev+bounces-307563-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cRKHIs2KVmq98gAAu9opvQ
	(envelope-from <netdev+bounces-307563-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 21:15:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 037EE758262
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 21:15:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=SAigRLSO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307563-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307563-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0046730D20F7
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA7E418A5A;
	Tue, 14 Jul 2026 19:14:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1972A418A56
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 19:14:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784056455; cv=none; b=Pv8MGTgIewhmwVdPw8aEQNbjqlWEQmWZWEbHf5l/7/jXkUYYK9E3eUNyvXXt/48zjgXFVQmjr/yIz2gwS3J8wW+FxK27lJwneXsy6yOuyqrjUSarlNgFFrQ+8dXTN1EkdW28pzchVXv1t4NvV1zvA3Q3GpGEDAQfhlFfhlPCBgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784056455; c=relaxed/simple;
	bh=aCAIB3Fx9iEVgSBKebY6vD7lWFtt97yz8FCDvVDuPCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DkfOb5T7y0LERX/mR4fXnB0xcHaVqtD+MNwx/SUAW0mBsAVihwVEV8zET2fX92YB/1+2igKi2DumqcbwysnF9jzEBhf5K7XZJC55vBYKiKw/Gtz8+fpw2nmNth217ZHX1W4UfWC+GuP/8QRTRwRNZVYogxNRTpkw2pgQOzU1P7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAigRLSO; arc=none smtp.client-ip=74.125.227.130
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2cad83a0aaeso20233535ad.0
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 12:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784056453; x=1784661253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=puD3SxDRZK2kLUJhdwB2OWJks0pBuRZ5Hw4UZYV+czY=;
        b=SAigRLSOjBGpDPVr/Lg6hEAJcXDMGDQ2jpsYAvPjQfEcLeSNgWT7yAnNkQFUvU1rr+
         ll2AjDnUS9g0c0ceuP0k0uzivlwFnXYcGBb7EM6S7Hf/35eXXe6+jlbGwlQCN9sMMzCv
         Ml8W0pUMahkZzhH0zmMzZ/xI5VptBDoV8TnaRXR4lyIwUjumaouEmPeJnGaSOYIZv4uX
         kaoVAPhlshbwvjh/54l5FrUAj4v6yI0AgRt5Mb1GYtBu2VfrI53RceIoixKkBdhRHAMP
         ZJx9qLX92pmIp0b0CehJgVYZByAPTR14mw+kL+6+izAuuWcYAojwgi/N+Y8nFIc1Svx/
         Jyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784056453; x=1784661253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=puD3SxDRZK2kLUJhdwB2OWJks0pBuRZ5Hw4UZYV+czY=;
        b=qEFh8fGqMSryF5KgDjkozBo4ZnpQNE6UfMdIK/o16WTCVW5YJaDTlgH5OWILBEOfES
         ivo66RM0sqGL2JNssErd+HlfC88pUSiXk0U+i7U9EUZwPnzHl9KGns1c/BsMIWJQZTIp
         IaUW/2TPB0+PeaA4X26TRblsgh27jfi3hLSO3/nwjJb4aVmnk5HoDqDgGVd8DqFekXms
         1LTNi/M/a5PBMB+vT78WqizXccrdXzCxZv9JM8yCJI/5ftO47fkDkblDJNa7HmGHimbo
         Bn+mLBDHH5bGeuQX3v573bj5yuyHR9ECpA3ciuAFOs53/VoV1CHXP9q82mDPDXh9XxGk
         +lsQ==
X-Gm-Message-State: AOJu0YzcQ9zDT34JtkgUgPVHS59jjFNBcVtwriS3iYIJqAHe5wIW0aIz
	fFYm7t/RPGSYr69tqpH3OtMjeOnTDhtjcL9NK2oktkdcWfrJfVJbF0v714iVI5D+Cm8INA==
X-Gm-Gg: AfdE7cnE8lqWubYtG6L3nFTi+GogiCZsJRoZXUjRMUY38DDAAYShzU1pCAaRqz9fL6H
	Hf3KQoCdyHT/vscpw6op3KWCpnF+vJK00bX7F9APwiH1MnvgW0aeFloHqbAhHCo88+uGNtrRLSk
	08aYGnTIDkFx6WWT0TmD9P403HPIn5MScSJI9xWBiAGHdzN+vClYMLUGP2ID42bgxNmtokLjJop
	xindrJpIGRhI+twZF9Gg9SaW8p8uKXjj5LuDzNmrHSKF5RD79Ds2dl11u+M/P6DfgBsN/q+NiyJ
	BDD9qpNPbeKuMwGpIQjChNZN/j/HZGUt0slyy7Q6hHKFX8GHPwM2HvWuoIWEJ20zTxca+Q9Mx3H
	8mruGoAu7z0UwpXUKcbz3r7Q6D/qm7rNB4kCK7KJGRWyltyLZz4XbK77uBlyqMbRviQQDiBi+n4
	qcN7KvTa3tGymc63XKwZBe6w==
X-Received: by 2002:a17:902:cec9:b0:2c9:d298:6c06 with SMTP id d9443c01a7336-2cef12fc6a4mr40014075ad.25.1784056453327;
        Tue, 14 Jul 2026 12:14:13 -0700 (PDT)
Received: from server.lan ([150.230.217.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3d451sm120763245ad.65.2026.07.14.12.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 12:14:11 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	robh@kernel.org,
	krzk+dt@kernel.org,
	heiko@sntech.de
Cc: netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	Coia Prant <coiaprant@gmail.com>
Subject: [RFC PATCH 04/10] dt-bindings: net: pcs: add rockchip,rk3568-xpcs binding
Date: Wed, 15 Jul 2026 03:08:32 +0800
Message-ID: <20260714191341.690906-5-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714191341.690906-1-coiaprant@gmail.com>
References: <20260714191341.690906-1-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307563-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[coiaprant@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:robh@kernel.org,m:krzk+dt@kernel.org,m:heiko@sntech.de,m:netdev@vger.kernel.org,m:linux-rockchip@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-phy@lists.infradead.org,m:coiaprant@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coiaprant@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devicetree.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 037EE758262

Add device tree binding documentation for the Synopsys DesignWare
XPCS integrated on the Rockchip RK3568 SoC.

The XPCS is accessed over the APB3 bus and internally connected to
a Naneng Combo SerDes PHY.  It supports 1000BASE-X, SGMII, and
QSGMII modes, with four MII ports.

The binding describes:
- Required properties: compatible, reg, clocks, clock-names
- Optional properties: phys, phy-names, power-domains
- pcs-mii sub-nodes for each MII port (reg 0..3)

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 .../bindings/net/pcs/rockchip-dwxpcs.yaml     | 126 ++++++++++++++++++
 1 file changed, 126 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/pcs/rockchip-dwxpcs.yaml

diff --git a/Documentation/devicetree/bindings/net/pcs/rockchip-dwxpcs.yaml b/Documentation/devicetree/bindings/net/pcs/rockchip-dwxpcs.yaml
new file mode 100644
index 0000000000000..14fadf67c793a
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/pcs/rockchip-dwxpcs.yaml
@@ -0,0 +1,126 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/pcs/rockchip-dwxpcs.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip RK3568 Synopsys DesignWare Ethernet PCS
+
+maintainers:
+  - Coia Prant <coiaprant@gmail.com>
+
+description: |
+  Rockchip RK3568 SoC integrates a Synopsys DesignWare Ethernet Physical
+  Coding Sublayer (XPCS).
+  The PCS provides an interface between the Media Access Control (MAC)
+  and the Physical Medium Attachment (PMA) sublayer through a Media
+  Independent Interface (GMII).
+
+  The XPCS is accessed over the APB3 bus and internally connected to a
+  Naneng Combo SerDes PHY.
+  It supports 1000BASE-X, SGMII and QSGMII modes.
+
+  The block contains four MII ports (pcs-mii@0..3) that can be
+  individually enabled and routed to one of the Ethernet GMAC controllers
+  via the pcs-handle property in the MAC device tree node.
+
+properties:
+  compatible:
+    const: rockchip,rk3568-xpcs
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  reg:
+    description: |
+      Base address and size of the XPCS register space mapped over the
+      APB3 bus.
+    maxItems: 1
+
+  clocks:
+    description: |
+      Clock sources for the XPCS:
+      - csr: APB3 bus interface clock (clk_csr_i), required for register
+        access.
+      - eee: EEE clock (clk_eee_i), required for Energy Efficient
+        Ethernet (EEE) operation.
+    minItems: 2
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: csr
+      - const: eee
+
+  phys:
+    description: |
+      The phandle of SerDes PHY (Naneng Combo PHY) that provides
+      the serial lanes for 1000BASE-X / SGMII / QSGMII.
+      The SerDes must be powered on and initialised before any XPCS
+      register access.
+    maxItems: 1
+
+  phy-names:
+    const: serdes
+
+  power-domains:
+    description: |
+      Power domain for the XPCS.
+      On RK3568 this is typically the PD_PIPE power domain, which also
+      supplies the SerDes PHY.
+    maxItems: 1
+
+patternProperties:
+  "^pcs-mii@[0-3]$":
+    type: object
+    description: |
+      One of the four MII ports of the XPCS.
+      The port number is specified by the reg property (0..3).
+      The port is linked to an Ethernet MAC controller via the
+      pcs-handle property in the MAC's device tree node.
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 3
+        description: |
+          MII port number of PCS.
+
+      status: true
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3568-cru.h>
+    #include <dt-bindings/power/rk3568-power.h>
+
+    pcs@fda00000 {
+      compatible = "rockchip,rk3568-xpcs";
+      #address-cells = <1>;
+      #size-cells = <0>;
+      reg = <0x0 0xfda00000 0x0 0x200000>;
+      clocks = <&cru PCLK_XPCS>, <&cru CLK_XPCS_EEE>;
+      clock-names = "csr", "eee";
+      phys = <&combphy2 PHY_TYPE_SGMII>;
+      phy-names = "serdes";
+      power-domains = <&power RK3568_PD_PIPE>;
+
+      pcs-mii@0 {
+        reg = <0>;
+      };
+    };
-- 
2.47.3


