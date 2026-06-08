Return-Path: <netdev+bounces-296702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vY4DAvAYJ2qTrgIAu9opvQ
	(envelope-from <netdev+bounces-296702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 21:33:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3C965A14B
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 21:33:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tinyisr.com header.s=purelymail2 header.b=hMa03NrA;
	dkim=pass header.d=purelymail.com header.s=purelymail2 header.b=RK4QpAsy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296702-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296702-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=tinyisr.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D7FD30103B8
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 19:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BABE33374F;
	Mon,  8 Jun 2026 19:30:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F7B314A95
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 19:30:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780947032; cv=none; b=drnk9pIxZL4KFQi/I8wHqUSTe9S38ujWYMb2fUG5ZJZpPPpQVuiznjxvyMcuQnwe1NMcVVyGH0YQlnz+hdIpxv8FXB8zjY6PBbkrdvZ+el79bmXD/1zF7U591mcn9hOmICgUkncDPGPnUGemoD2kOiahVaQ9jeM4RLXqAATChbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780947032; c=relaxed/simple;
	bh=hzzuI+m1ZMqYpN7/Z1xREb/l5asqccEetkZ7Qt2IVPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PauAM2KZlL5rfyPDQn6A6Qmjol+ob/ng5J6Nw4uqTqgYVeFY7G25gA4/OdaCWsnqb10CqAhT4cDy3GooEx0d2Jmv0bxiunUWa8FvJwX30/xZCmVQLZr5nXFN9+hS3qKxGMBBoke5uIZHJ8HA8yl/COEJmBlbi6aVlbfMA5d4JKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tinyisr.com; spf=pass smtp.mailfrom=tinyisr.com; dkim=pass (2048-bit key) header.d=tinyisr.com header.i=@tinyisr.com header.b=hMa03NrA; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=RK4QpAsy; arc=none smtp.client-ip=34.202.193.197
DKIM-Signature: a=rsa-sha256; b=hMa03NrA+OZebmBBcq+l0f5/nXPAWGsmKe8N4o9fRqn5+PNmZJ12mu3W3nobpP+KDmdWBfer1JORRJMwTi9ua5V3ApboCPNWMsSmNdJqF7x0KoqTnyyid+3x7AkhLdtLMTRDF3lG1ttoa2lMsItfH96SeUtgOReEuxUg3XjqTXL1q9Tvu7pyX1EKxaVIadmU2LUM6M/t1IhcMe0CebUn5qGTLd2sP+s88SXiv7sdLxpi3bIHKnuUMgko0J2VCH7qVBAkdiiVsorA0s73fTxuO+xvBRNA7vI1+ceOKpNhqH+BdMpXL//lq2UDuBHp/mputDGhDL9I0efcvmYrPzS1Yw==; s=purelymail2; d=tinyisr.com; v=1; bh=hzzuI+m1ZMqYpN7/Z1xREb/l5asqccEetkZ7Qt2IVPE=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=RK4QpAsyrmiMivaXJEfZWeZM/2HbrolseIEAVfIiHJrNGXdN5xmmo0mqwn4wWTTog0m3r81vcrJ293omxY8sTGAtjTMAoSJ7RB1G/OSqCGQBF39LdHcyD0vui8U3cyetZWqTJx1EHW7PFYc2VWC9NCpSwnZOJxkECQp69Y5CwhluvQDcPqwebRwFeMPZkG9SUVSy9SYtXAm9c55ZyADgCHB0WycBu2kNPMIy0wDwZyiTjWggl9ixEpWv8k2wnfMx2oBGlNgI5DEor5xPGLPCNIkddNfO6v1CRFuxiYBylT278ijNW5PlK+D5z4bx7fCdk7tTeCxJNggLsWepxzkF9A==; s=purelymail2; d=purelymail.com; v=1; bh=hzzuI+m1ZMqYpN7/Z1xREb/l5asqccEetkZ7Qt2IVPE=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 99681:12517:null:purelymail
X-Pm-Original-To: netdev@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 305744462;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 08 Jun 2026 19:30:22 +0000 (UTC)
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
	=?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Joris Vaisvila <joey@tinyisr.com>
Subject: [PATCH net-next v4 1/4] dt-bindings: net: dsa: add MT7628 ESW
Date: Mon,  8 Jun 2026 22:29:45 +0300
Message-ID: <20260608192948.289745-2-joey@tinyisr.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608192948.289745-1-joey@tinyisr.com>
References: <20260608192948.289745-1-joey@tinyisr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tinyisr.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[tinyisr.com:s=purelymail2,purelymail.com:s=purelymail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296702-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:horms@kernel.org,m:pabeni@redhat.com,m:kuba@kernel.org,m:edumazet@google.com,m:davem@davemloft.net,m:olteanv@gmail.com,m:andrew@lunn.ch,m:devicetree@vger.kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:arinc.unal@arinc9.com,m:Landen.Chao@mediatek.com,m:dqfext@gmail.com,m:sean.wang@mediatek.com,m:daniel@makrotopia.org,m:joey@tinyisr.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER(0.00)[joey@tinyisr.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tinyisr.com:+,purelymail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joey@tinyisr.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,davemloft.net,gmail.com,lunn.ch,vger.kernel.org,arinc9.com,mediatek.com,makrotopia.org,tinyisr.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,purelymail.com:dkim,vger.kernel.org:from_smtp,tinyisr.com:dkim,tinyisr.com:email,tinyisr.com:mid,tinyisr.com:from_mime,devicetree.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E3C965A14B

Add device tree bindings for the MediaTek MT7628 embedded Ethernet
Switch.

The switch provides 5 external user ports and 1 internal CPU port, with
integrated 10/100 PHYs and fixed port to PHY mapping.

Signed-off-by: Joris Vaisvila <joey@tinyisr.com>
---
 .../bindings/net/dsa/mediatek,mt7628-esw.yaml | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/mediatek,mt76=
28-esw.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7628-esw.=
yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7628-esw.yaml
new file mode 100644
index 000000000000..0c16cf858035
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7628-esw.yaml
@@ -0,0 +1,97 @@
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
+  The MT7628 SoC's built-in Ethernet Switch has five user ports and one
+  internally connected CPU port. The user ports are all connected to the S=
oC's
+  integrated Fast Ethernet PHYs. The switch registers are directly mapped =
in
+  the SoC's memory.
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
+
+  resets:
+    items:
+      - description: internal switch block reset
+      - description: internal phy package reset
+
+  reset-names:
+    items:
+      - const: esw
+      - const: ephy
+
+required:
+  - compatible
+  - reg
+  - resets
+  - reset-names
+  - ethernet-ports
+
+examples:
+  - |
+    switch@10110000 {
+        compatible =3D "mediatek,mt7628-esw";
+
+        reg =3D <0x10110000 0x8000>;
+
+        resets =3D <&sysc 23>, <&sysc 24>;
+        reset-names =3D "esw", "ephy";
+
+        ethernet-ports {
+            #address-cells =3D <1>;
+            #size-cells =3D <0>;
+
+            ethernet-port@0 {
+                reg =3D <0>;
+                phy-mode =3D "internal";
+            };
+
+            ethernet-port@1 {
+                reg =3D <1>;
+                phy-mode =3D "internal";
+            };
+
+            ethernet-port@2 {
+                reg =3D <2>;
+                phy-mode =3D "internal";
+            };
+
+            ethernet-port@3 {
+                reg =3D <3>;
+                phy-mode =3D "internal";
+            };
+
+            ethernet-port@4 {
+                reg =3D <4>;
+                phy-mode =3D "internal";
+            };
+
+            ethernet-port@6 {
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
2.54.0


