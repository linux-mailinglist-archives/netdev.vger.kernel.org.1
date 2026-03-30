Return-Path: <netdev+bounces-273293-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBKGMNPDymmL/wUAu9opvQ
	(envelope-from <netdev+bounces-273293-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 20:41:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1289135FD6C
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 20:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 104FF301AA4B
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E193DE44E;
	Mon, 30 Mar 2026 18:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b="FtDHxWDa";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="qjsli1Ms"
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8BF3939BC
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 18:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774896038; cv=none; b=msfNNW3WK22qmZYB2vtTUqQwwZQzQTq4h/pK8Qr10CtkTNn/BcR/JmSNsNFn1MLkFTv5RX4R9AGGOlPVtGcTuU/vnP2X0i1kLrsMLqeCMId90/Kz3nq1ZJavLUJdnJ5V3KziKgPziH8dIV6/aCxaL7di6yEmBZapoozg47CB14c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774896038; c=relaxed/simple;
	bh=ONH4qX4DHV4JBhJcpinBPBxK+OeMVLHsURxnEqYM8Co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IcYkE0GvZDallkASTZQIUSELdBlnml/QGlx2y8KaCSLU5cWBa5/XMT5PieLIOsjIe44OGjPEf7X2V6IlQLQTRsgutuQ2qDgXFKYbxEhZr6Xe0NTVTu4bkEKa4+MRn1uorO1UPwpSi2ws3uGZBA7szNuEQHfn0LLwONcFDOtuzKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=FtDHxWDa; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=qjsli1Ms; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinyisr.com
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=FtDHxWDazz41RbrNjNORhP3fvxR9GTGib3mlgbzAhK47BlmY+hdBKqXO3/vReAfRJtxWG4W8XHgAkWGkTNON16fKXcsL3ChwNigGFy2Ym5DIkeANKc96L57npU69n138CocUl58j+h6v1vop4mUeq/nA2WTVoxaIfp+lbHJwwSTnGL42nlCxbyydqEwTI9JAm68qve7pD3f/ZA5n5M1muk/jTIT6jbia9AsRg/6PQdkH9JnDauxTme409JSXEWyV5cMkG4caZdM2aa/G/dhHKjq3f4o6ww8LD8FDQVa7P9lb9FZIITA8uCZ+qfNG7X/GUq08wS123qYdIT7ga4+2WA==; s=purelymail1; d=tinyisr.com; v=1; bh=ONH4qX4DHV4JBhJcpinBPBxK+OeMVLHsURxnEqYM8Co=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=qjsli1MsM4Lt80Ak9nAOpa6bMbdKcQdngCM1+PspIiOPoedxqvfVtpEhj95nOzf4LjmNuW0LPvg9+/BCd43/nurxwT/7Og/8TUOdQYTyb/NB05ggi4/6KSMEtMJtQ/sAQxHOxjGHNK3F0ooTucpGBN+DS9OSXkyKAjyq0tNr0EtHzLkAJCkGLCev8LA9fKrEKb8UUwhOJjFG5pN+PX7g0RDlqj6Ti1jsJQh4w73mVcp/pxOJ1p+RYdtHX8GLX8qNsSouSk9giVqm42GjHuZDT2OogMtRshMpB3IXku4jhBDz/nlpD0LMaYiivO0vtBN1NCeHOg3FkpBzzlD9v82flQ==; s=purelymail1; d=purelymail.com; v=1; bh=ONH4qX4DHV4JBhJcpinBPBxK+OeMVLHsURxnEqYM8Co=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1431054842;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 30 Mar 2026 18:40:35 +0000 (UTC)
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
Subject: [PATCH net-next v2 1/4] dt-bindings: net: dsa: add MT7628 ESW
Date: Mon, 30 Mar 2026 21:40:14 +0300
Message-ID: <20260330184017.766200-2-joey@tinyisr.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330184017.766200-1-joey@tinyisr.com>
References: <20260330184017.766200-1-joey@tinyisr.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[tinyisr.com:s=purelymail1,purelymail.com:s=purelymail1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,davemloft.net,gmail.com,lunn.ch,vger.kernel.org,tinyisr.com];
	TAGGED_FROM(0.00)[bounces-273293-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.1:email,0.154.68.48:email,0.0.0.3:email];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joey@tinyisr.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tinyisr.com:+,purelymail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.0.0.6:email,0.0.0.0:email]
X-Rspamd-Queue-Id: 1289135FD6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add bindings for MT7628 SoC's Embedded Switch.

Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
---
 .../bindings/net/dsa/mediatek,mt7628-esw.yaml | 101 ++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/mediatek,mt76=
28-esw.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7628-esw.=
yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7628-esw.yaml
new file mode 100644
index 000000000000..d6c66ab677d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7628-esw.yaml
@@ -0,0 +1,101 @@
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
+                phy-mode =3D "internal";
+            };
+
+            port@1 {
+                reg =3D <1>;
+                phy-mode =3D "internal";
+            };
+
+            port@2 {
+                reg =3D <2>;
+                phy-mode =3D "internal";
+            };
+
+            port@3 {
+                reg =3D <3>;
+                phy-mode =3D "internal";
+            };
+
+            port@4 {
+                reg =3D <4>;
+                phy-mode =3D "internal";
+            };
+
+            port@6 {
+                reg =3D <6>;
+                phy-mode =3D "internal";
+                ethernet =3D <&ethernet>;
+
+                fixed-link {
+                    speed =3D <1000>;
+                    full-duplex;
+                };
+            };
+        };
+    };
--=20
2.53.0


