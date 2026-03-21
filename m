Return-Path: <netdev+bounces-270247-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PHUNSP1vmk0mAMAu9opvQ
	(envelope-from <netdev+bounces-270247-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 20:44:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F522E70D2
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 20:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D6813019FDA
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 19:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB48342CA9;
	Sat, 21 Mar 2026 19:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="Et/URfdg";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="fEgfIbLE"
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB023314C2
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 19:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774122255; cv=none; b=dKJ9WQgFP5B484cX8RK9wjFIkaRQa0p2s40YB9aOBHKJVwDI+l91aIUVzYht00EVeC4PzaXI93Ef1IESYGgZlQXVAaNnGnO6BGIBop4D4VJxoff93TyhHXuvkckI/fonySDlhcRhg4YnVKYWfV3CvGw2DevDG2OI3SSX+XHEr4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774122255; c=relaxed/simple;
	bh=zWRAcjCQ8xfhYi7+ArRyrwgND8OTbc/VDaZEGG/iICA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fxrCcFVFlAo9ynNHfwZbFL41G1fAF2JVkOdJ8LsZiqanWX44h+nppyyIZ5k8bRliNBbdN8ztvmPsr6bFhVpjF0Oik92FzY4qS0LuWGDzfaIF578LmhKs4X0KBOUmg5hNO/wzGIcDOo59pUiyuQTlvKJoSb/9b/9W5qN7/bnQc/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=Et/URfdg; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=fEgfIbLE; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=Et/URfdgU9P1jFfjxZlllF8BLwTVNrliZ5MSBj9wiN7luW3rtResrkZ8ObTX6W94NaEAyeMF+pF9RHLEIQWN6TQ/99Zxn+DujMpiP4oPYiQKqRLmDmwMe9ArbCZBU2OoHX4KX5glC3GAVb47aQzopVk9TeKR1CaRkhPEMf23nX8ZJ92/IFbl8GyjVk21COKkz/PRQmC9AMJnuge8pa3ut4GFe/CyM0alE4WTUTlDerdWmnhmproZ0in6uyqDmUmleHkqzrx9n2mEu+4hHfRRMeZw6XPi5tH4xd4a90KmayG9DFuvONbEB2n/WS1hJF4wgdxZVYklm81B0GGegsqzdA==; s=purelymail3; d=tinyisr.com; v=1; bh=zWRAcjCQ8xfhYi7+ArRyrwgND8OTbc/VDaZEGG/iICA=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=fEgfIbLEEI9u1QQffdqnQTxGuRFwvOMJjDg+nf3lJQLOWoG3kpxLGpPOZUUdDv8PoGJcgjfwck0Ljj5fTbgCtOqu3dXGJuf05ocMONaCRpPta45tiQAdQxfJ+OlYpNEa5R6ZIep5n7gADwv8adTSt3GZQICw2lFK3BDvF3cVggsPa3GRcsaCmFNz9YktlvuSexC+jfgkhLPUPUq7CkRyveQ3MV7CFlDdNMHuU+qiZ7eWqx/Iw+5ESKzw7AA4svbjCP6gnQLTCkG7bCDsnMg94FnFN3KxvsuPT8ThuWP5ZmaG9p/XIrPVyDmm8kdVLK0ke7JRYzp+p/XT6+l2EdMe0g==; s=purelymail3; d=purelymail.com; v=1; bh=zWRAcjCQ8xfhYi7+ArRyrwgND8OTbc/VDaZEGG/iICA=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 958892867;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 21 Mar 2026 19:44:11 +0000 (UTC)
From: Joris Vaisvila <joey@tinyisr.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	olteanv@gmail.com,
	Andrew Lunn <andrew@lunn.ch>,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joris Vaisvila <joey@tinyisr.com>
Subject: [RFC v3 1/4] dt-bindings: net: dsa: add MT7628 ESW
Date: Sat, 21 Mar 2026 21:43:37 +0200
Message-ID: <20260321194340.2140783-2-joey@tinyisr.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321194340.2140783-1-joey@tinyisr.com>
References: <20260321194340.2140783-1-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tinyisr.com,reject];
	R_DKIM_ALLOW(-0.20)[tinyisr.com:s=purelymail3,purelymail.com:s=purelymail3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270247-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,davemloft.net,gmail.com,lunn.ch,vger.kernel.org,tinyisr.com];
	DKIM_TRACE(0.00)[tinyisr.com:+,purelymail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joey@tinyisr.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28F522E70D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add bindings for MT7628 SoC's Embedded Switch.

Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
---
 .../bindings/net/dsa/mediatek,mt7628-esw.yaml | 136 ++++++++++++++++++
 1 file changed, 136 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/mediatek,mt76=
28-esw.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7628-esw.=
yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7628-esw.yaml
new file mode 100644
index 000000000000..5955c07a1be7
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7628-esw.yaml
@@ -0,0 +1,136 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/mediatek,mt7628-esw.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek MT7628 Embedded Ethernet Switch
+
+maintainers:
+  - Joris Vaisvila <joey@tinyisr.com>
+
+description:
+  The MT7628 SoC's built-in Ethernet Switch is a five port switch with
+  integrated 10/100 PHYs. The switch registers are directly mapped in the =
SoC's
+  memory. The switch has an internally connected 1G CPU port and 5 user po=
rts
+  connected to the built-in Fast Ethernet PHYs.
+
+unevaluatedProperties: false
+
+allOf:
+  - $ref: dsa.yaml#/$defs/ethernet-ports
+
+properties:
+  compatible:
+    const: mediatek,mt7628-esw
+
+  reg:
+    maxItems: 1
+    description: MMIO address of the switch
+
+  resets:
+    items:
+      - description: Phandle of system reset controller with ESW reset ind=
ex
+      - description: Phandle of system reset controller with EPHY reset in=
dex
+
+  reset-names:
+    items:
+      - const: esw
+      - const: ephy
+
+  mdio:
+    $ref: /schemas/net/mdio.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - resets
+  - reset-names
+
+examples:
+  - |
+    switch0: switch@10110000 {
+        reg =3D <0x10110000 0x8000>;
+
+        resets =3D <&sysc 23>, <&sysc 24>;
+        reset-names =3D "esw", "ephy";
+
+        compatible =3D "mediatek,mt7628-esw";
+
+        ports {
+            #address-cells =3D <1>;
+            #size-cells =3D <0>;
+
+            port@0 {
+                reg =3D <0>;
+                label =3D "swp0";
+                phy-handle =3D <&swp0_phy>;
+                phy-mode =3D "internal";
+            };
+
+            port@1 {
+                reg =3D <1>;
+                label =3D "swp1";
+                phy-handle =3D <&swp1_phy>;
+                phy-mode =3D "internal";
+            };
+
+            port@2 {
+                reg =3D <2>;
+                label =3D "swp2";
+                phy-handle =3D <&swp2_phy>;
+                phy-mode =3D "internal";
+            };
+
+            port@3 {
+                reg =3D <3>;
+                label =3D "swp3";
+                phy-handle =3D <&swp3_phy>;
+                phy-mode =3D "internal";
+            };
+
+            port@4 {
+                reg =3D <4>;
+                label =3D "swp4";
+                phy-handle =3D <&swp4_phy>;
+                phy-mode =3D "internal";
+            };
+
+            port@6 {
+                reg =3D <6>;
+                ethernet =3D <&ethernet>;
+                phy-mode =3D "rgmii";
+
+                fixed-link {
+                    speed =3D <1000>;
+                    full-duplex;
+                };
+            };
+        };
+
+        mdio {
+            #address-cells =3D <1>;
+            #size-cells =3D <0>;
+
+            swp0_phy: swp0_phy@0 {
+                reg =3D <0>;
+            };
+
+            swp1_phy: swp1_phy@1 {
+                reg =3D <1>;
+            };
+
+            swp2_phy: swp2_phy@2 {
+                reg =3D <2>;
+            };
+
+            swp3_phy: swp3_phy@3 {
+                reg =3D <3>;
+            };
+
+            swp4_phy: swp4_phy@4 {
+                reg =3D <4>;
+            };
+        };
+    };
--=20
2.53.0


