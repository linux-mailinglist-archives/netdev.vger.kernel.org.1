Return-Path: <netdev+bounces-284556-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AcgGwQ4+mnHKwMAu9opvQ
	(envelope-from <netdev+bounces-284556-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 20:33:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 627564D2BB3
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 20:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1BE163049B74
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 18:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6096F4BCADA;
	Tue,  5 May 2026 18:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZKoLAeu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB814BCAD5
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 18:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778005665; cv=none; b=X7rBeTmZ1zfALMmchNBhWARounxj351dzptn21Xbaa7/Mf7pvdXKD8NXdN9ymXEz7qvnFac4P+TgCqhbVrnQ4sQR0t7eQor2tycTo03mTpcPsgCrZjqKMJLMqJm8kx4l6wuU9J7OJ7AscOFVdVU8AcfKI3GMAX0VMv65VSWqtRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778005665; c=relaxed/simple;
	bh=57tf4IVtaTKf4rXMfOx1/pGq9M7TpHDLMd/27uedaeM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GwnXce4f5wSTRRrpn7MfDgxprPWxvH1KxyVlH6q8c7NRBcHPs4Ak/ZWFs7zIi2P97PsP9wx2rkXAWJov5ytyCpWrWeJ8DGB9V67UsvYB93NatQL2iwyFTrVpvbAVvqbIDC10DSq9fnPKLeuD0x5UnNY9Olfsis05xerGOVxCdJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sZKoLAeu; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so53523135e9.2
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 11:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778005661; x=1778610461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2x1A+JAuzDdUiINu53XK8eGzEAE0up6CyLUPQxC/1W0=;
        b=sZKoLAeuz9TEXFLLGkonngja3pwPlrdVg8MXT/+kpHdMEpJ+Nchf+LZShzfT/DgpCT
         UmrAB2rYTsWR2lJJd1/8QZ2Pp5DojqzKYQJ6VxGvbSO+m4TeLLjvnZNq+2UIoXzbsJH0
         mAlNzCJIzeg5r7FmDgRiRvEt8MP9036h6k/SDDan10EyMOen5UxKHYJwtpZig1qdw4ea
         ZCxr1c1+Tl1w7nZ/xVl9Mic1JrtW12eX5/3cI+MJeviRvusqEyMP9aeWKvMiCnlSJNG8
         69jmQv4GXDuE+hQOREdDnQXWrNqArAMq9Qfd7xvBpj90F2/6MZBB9TYB7IFl7F/k+f8M
         p9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778005661; x=1778610461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2x1A+JAuzDdUiINu53XK8eGzEAE0up6CyLUPQxC/1W0=;
        b=EXv+1Rad7EpCpmDdhOEtq1tfealhLIYOLOJQ+K/FdZEYH7Ngezx26AjybPw5t9g3T7
         oWMwCL2ruSn+wHBQwfw4MmKQFCNGzmv5yD4wUB6KAWghikuT9CJam4Te0uGngrzzndpz
         EHTzMQEywMvdGnIl9YVLGhPR9BDZNtpryTk/rYTN+dS+KHRfE9jWO8N6sfQcl4ILJdj6
         Z99YZo3igNlxaTxsHLduQkqlCMnhEk9tVHy0+WL7IE0hc3L1wbu98MQ3Q+ybXKxg4Zr4
         XUhN4Bil+MgEZUqRQYMDmKQAdG82qP+If8AlicicdW3kwJ3F6wbHGb4rAV1MjnMaLKN1
         CCPg==
X-Forwarded-Encrypted: i=1; AFNElJ85QsLpDQp218/9TIQd+SYelegBAGQEMVyDsNzr2JrumM+KGTjcNh3d9dD6lzRIvxmrwhrgZI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUgYOlY7zIMNDMrRIS3Nip+3oRmBCUtmRNHiTCNG7hpCLO6WHS
	8MwCdMamdt08kZ5SoRKsEexxdOUDPzIXZvQRPXcRgEtUoUQb6iD2O6Q6
X-Gm-Gg: AeBDieuKCMkdhMElNG2rIE0j5PwCZq4YHaPg7WmUxxDrK49dcBgdvfTFEcqZ9HIhY6w
	QNNFhwb1s8tGSyqVHe6gqvcS672KyTHCya4xP7vSeceP+FQzHFzNnUtzHmVqtpZQ55JnDoRxr3b
	dWkcyIR/IzVZb8VOmk+MPDUe4P5wwPs6mDBVGVNPlX8/2HvXYsYURFASzMrPGMadH0rEqrYYXaT
	Yb7Jo5F9ssYyEwTpLNDgv1i/oXBKCIqeqdBJPjkLV7bzXputNQivYcw4XArAsTwXnQuYOqRqXKt
	8lHsS6r8IDOmEpf4hruIkWN+Iow5xZo8ykGQajpu+4weNR2l7vz6t3JsxfXAP7/SSunOO2rElFb
	eAMxTBkZec81i2mxhcTNq2qHVW56tM7GglqnLqDrvlOO2QxmX7mXrMcVe7gGD6Zq+i7OJBm1/hs
	XkFK7Ew+e1urLpivfxJxmD3e6FBxZqH4OHhgbVYO8sJQgG52wZdNs990s0d6QJA/wCt1lwAU6in
	7bQ0xIl7wRxGSDZkA==
X-Received: by 2002:a05:600c:1e8a:b0:488:fd7e:1063 with SMTP id 5b1f17b1804b1-48e51f4cdcdmr5427305e9.29.1778005661133;
        Tue, 05 May 2026 11:27:41 -0700 (PDT)
Received: from Ansuel-XPS24 (host-82-59-227-65.retail.telecomitalia.it. [82.59.227.65])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48a820c865esm408208245e9.5.2026.05.05.11.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 11:27:40 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [net-next RFC PATCH v5 08/10] dt-bindings: net: pcs: Document support for Airoha Ethernet PCS
Date: Tue,  5 May 2026 20:27:09 +0200
Message-ID: <20260505182713.27644-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505182713.27644-1-ansuelsmth@gmail.com>
References: <20260505182713.27644-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 627564D2BB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-284556-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,pengutronix.de,makrotopia.org,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt,lkml];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[1fa08000:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,1fa09000:email]

Document support for Airoha Ethernet PCS for AN7581 SoC.

Airoha AN7581 SoC expose multiple Physical Coding Sublayer (PCS) for
the various Serdes port supporting different Media Independent Interface
(10BASE-R, USXGMII, 2500BASE-X, 1000BASE-X, SGMII).

This follow the new PCS provider with the use of #pcs-cells property.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 .../bindings/net/pcs/airoha,pcs.yaml          | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/pcs/airoha,pcs.yaml

diff --git a/Documentation/devicetree/bindings/net/pcs/airoha,pcs.yaml b/Documentation/devicetree/bindings/net/pcs/airoha,pcs.yaml
new file mode 100644
index 000000000000..8bcf7757c728
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/pcs/airoha,pcs.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/pcs/airoha,pcs.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Airoha Ethernet PCS and Serdes
+
+maintainers:
+  - Christian Marangi <ansuelsmth@gmail.com>
+
+description:
+  Airoha AN7581 SoC expose multiple Physical Coding Sublayer (PCS) for
+  the various Serdes port supporting different Media Independent Interface
+  (10BASE-R, USXGMII, 2500BASE-X, 1000BASE-X, SGMII).
+
+properties:
+  compatible:
+    enum:
+      - airoha,an7581-pcs-eth
+      - airoha,an7581-pcs-pon
+
+  reg:
+    items:
+      - description: XFI MAC reg
+      - description: HSGMII AN reg
+      - description: HSGMII PCS reg
+      - description: MULTI SGMII reg
+      - description: USXGMII reg
+      - description: HSGMII rate adaption reg
+      - description: XFI Analog register
+      - description: XFI PMA (Physical Medium Attachment) register
+
+  reg-names:
+    items:
+      - const: xfi_mac
+      - const: hsgmii_an
+      - const: hsgmii_pcs
+      - const: multi_sgmii
+      - const: usxgmii
+      - const: hsgmii_rate_adp
+      - const: xfi_ana
+      - const: xfi_pma
+
+  resets:
+    items:
+      - description: MAC reset
+      - description: PHY reset
+
+  reset-names:
+    items:
+      - const: mac
+      - const: phy
+
+  "#pcs-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - resets
+  - reset-names
+  - "#pcs-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/reset/airoha,en7581-reset.h>
+
+    pcs@1fa08000 {
+        compatible = "airoha,an7581-pcs-pon";
+        reg = <0x1fa08000 0x1000>,
+              <0x1fa80000 0x60>,
+              <0x1fa80a00 0x164>,
+              <0x1fa84000 0x450>,
+              <0x1fa85900 0x338>,
+              <0x1fa86000 0x300>,
+              <0x1fa8a000 0x1000>,
+              <0x1fa8b000 0x1000>;
+        reg-names = "xfi_mac", "hsgmii_an", "hsgmii_pcs",
+                    "multi_sgmii", "usxgmii",
+                    "hsgmii_rate_adp", "xfi_ana", "xfi_pma";
+
+        resets = <&scuclk EN7581_XPON_MAC_RST>,
+                 <&scuclk EN7581_XPON_PHY_RST>;
+        reset-names = "mac", "phy";
+
+        #pcs-cells = <0>;
+    };
+
+    pcs@1fa09000 {
+        compatible = "airoha,an7581-pcs-eth";
+        reg = <0x1fa09000 0x1000>,
+              <0x1fa70000 0x60>,
+              <0x1fa70a00 0x164>,
+              <0x1fa74000 0x450>,
+              <0x1fa75900 0x338>,
+              <0x1fa76000 0x300>,
+              <0x1fa7a000 0x1000>,
+              <0x1fa7b000 0x1000>;
+        reg-names = "xfi_mac", "hsgmii_an", "hsgmii_pcs",
+                    "multi_sgmii", "usxgmii",
+                    "hsgmii_rate_adp", "xfi_ana", "xfi_pma";
+
+        resets = <&scuclk EN7581_XSI_MAC_RST>,
+                 <&scuclk EN7581_XSI_PHY_RST>;
+        reset-names = "mac", "phy";
+
+        #pcs-cells = <0>;
+    };
-- 
2.53.0


