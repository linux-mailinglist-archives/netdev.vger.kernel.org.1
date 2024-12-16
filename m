Return-Path: <netdev+bounces-152056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4D99F28B3
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 04:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C3A17A1A04
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 03:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A191531F9;
	Mon, 16 Dec 2024 03:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="QU4Z7gzu"
X-Original-To: netdev@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C0D15443C
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 03:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734318835; cv=none; b=UsIq6WlGW+dEB6oml3Ywt9jSmF2FUFkae3vvMp5Ly5ZLg02Bq9KCFnpyDS/T8P461R9LOboztMvuSJezm+W0mABBJkqTw911fzu7u4bu2ffJomSTyxDDz+ou9kmP5r8oYesIj1RnvGzPSxvwfUKS604d1fQLscyKXkH8qZXPOSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734318835; c=relaxed/simple;
	bh=EZMxsaSZyVTLl+wyd+Suo9rEvaWxLJNZbUuoR1n9dLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qm3sR7cK4XRf+r2DDEywoaEYRC6jNA+0us2tEXLE4kQrmrkS7No0CGFIaMhecJE0RXAd5QUAjUou6Zn5MAJmH39C8GLg0owCB9dPhOF2DPcPXv4UWYnu7uDwrWAEpnMQULaiDsLIxfRln+rl36t6/tBe0Mj20u332R3nTIji+uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=QU4Z7gzu; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 6D0702C06AE;
	Mon, 16 Dec 2024 16:13:49 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1734318829;
	bh=ija5y22i7nvrG7FYKFouDM3FeHuFJwf9xq2lkRzkIu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QU4Z7gzu5duX/ec9QI26WXFEswSBoXDvU9ERJ+T6+3LUxHrbA8Sf25OFH77LJjumN
	 +e5YLXkvJhn7YosxBfDDSActqYB5agQCAMe+aBKh1Xj033xCwVwDG6zjkM8x6gLMvh
	 HWUBvj/oOJ9Z8zzaQ5yTTdaBIz6cnFHhSO/agQWt7iF2l0dI29z0dj4IqIPN/JEhh2
	 Sw5+Q9mFsHdLPkVipL/mhqBQevHEnTwjTmH7M6t/IgGD54BOZN1jOhrzBHPcb9+Mlc
	 c4M9aT2VLfczYAMhw0rnmUjGhza8hmMal7UbNEZvHlRVZqZlUuROWygP8FraAdgkTG
	 vKNqjEB9S3gcQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B675f9aec0002>; Mon, 16 Dec 2024 16:13:49 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id E6D5313EE87;
	Mon, 16 Dec 2024 16:13:48 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id E1452280E23; Mon, 16 Dec 2024 16:13:48 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: lee@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	tsbogend@alpha.franken.de,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	markus.stockhausen@gmx.de
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-mips@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 2/4] dt-bindings: mfd: Add MDIO interface to rtl9301-switch
Date: Mon, 16 Dec 2024 16:13:44 +1300
Message-ID: <20241216031346.2626805-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241216031346.2626805-1-chris.packham@alliedtelesis.co.nz>
References: <20241216031346.2626805-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=BNQQr0QG c=1 sm=1 tr=0 ts=675f9aed a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=RZcAm9yDv7YA:10 a=0DcZ6JciK6r0_laEW2MA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

The MDIO controller is part of the switch on the RTL9300 family of
devices. Add a $ref to the mfd binding for these devices.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v2:
    - None

 .../bindings/mfd/realtek,rtl9301-switch.yaml      | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/realtek,rtl9301-switch=
.yaml b/Documentation/devicetree/bindings/mfd/realtek,rtl9301-switch.yaml
index f053303ab1e6..eeb08e7435fa 100644
--- a/Documentation/devicetree/bindings/mfd/realtek,rtl9301-switch.yaml
+++ b/Documentation/devicetree/bindings/mfd/realtek,rtl9301-switch.yaml
@@ -41,6 +41,9 @@ patternProperties:
   'i2c@[0-9a-f]+$':
     $ref: /schemas/i2c/realtek,rtl9301-i2c.yaml#
=20
+  'mdio@[0-9a-f]+$':
+    $ref: /schemas/net/realtek,rtl9301-mdio.yaml#
+
 required:
   - compatible
   - reg
@@ -110,5 +113,17 @@ examples:
           };
         };
       };
+
+      mdio0: mdio@ca00 {
+        compatible =3D "realtek,rtl9301-mdio";
+        reg =3D <0xca00 0x200>;
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        ethernet-phy@0 {
+          reg =3D <0>;
+          realtek,smi-address =3D <0 1>;
+        };
+      };
     };
=20
--=20
2.47.1


