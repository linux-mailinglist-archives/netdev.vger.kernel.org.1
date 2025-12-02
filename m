Return-Path: <netdev+bounces-243315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 32585C9CE12
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 21:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61F604E3F3E
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 20:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8316B2F362F;
	Tue,  2 Dec 2025 20:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b="q1tY+BeQ"
X-Original-To: netdev@vger.kernel.org
Received: from fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com [52.28.197.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453932F25F1;
	Tue,  2 Dec 2025 20:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.28.197.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764706329; cv=none; b=FXsB8Oer+AnzZ8NYfPaBeBnBL7QlFEBB4mjJRov6xLgF8RwLKzSYFIrOsDK094rE/a9gidjjcoFSawi4tN22pLEVRJExQm0ouD8vm5UPps58xFYtsXCC/SdmMl2miUKvDt4G9Lftf9EmUjRdPKkGR9ZuESDCnr1puiAXKSQoqRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764706329; c=relaxed/simple;
	bh=Fsj3pmw5yQQaqvWUUUBc+HPOsoYlv+wjOFoZLU/Tagc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dw58vW1fZypM31+DRTHXY2dpwQ+zWiBuULkniszGdKku6kp490bym/XN/HWH3hKO3GICfHaofgZj2Xk2K2VZGCD97L7d1KSaUYV5haaHjSAo03a5y/rRSDeAIllapmLtDaHzR2VzaBm4t9pP095gRfvvaHKTpzPMzQqxXak2ARI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b=q1tY+BeQ; arc=none smtp.client-ip=52.28.197.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
  t=1764706327; x=1796242327;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+XRX+zfeLkFYnkeD4QM7WrFm6Yhmh8DiQzSrma3Jqd8=;
  b=q1tY+BeQh8uztrEQ3k2qQ3mmcszsWuPspr2cU0M9r7D6IS2eMTDR936Q
   0gJ4XJDkX5Ifdklyl4u5mcHurwjae+XzcYCg0M7RUErcdFc4/6kaPVYee
   +9QpP9Yf0kVprrDGytfzUhnVhgvyhwvix7Gy4eNmFEkXhLFwp2irDU/0M
   /RM3xqU2qL4fYXPS0mQQu9rArsJ61kuME/uRrFuG87J9q/6eUkIUQmoCm
   rFazsWF2ocDWTTkM6JgtqsYkCAaI4oMK1HozRX797uJuaFJWpW8qhAwCq
   m5Phq7V4LrqLrqMKwr8HXjCn3htpU+2cW81sdirmvLJCXlEaraLlj2SRa
   w==;
X-CSE-ConnectionGUID: FCJ9coTHQ2KfQmKz72ceew==
X-CSE-MsgGUID: kA82ZogUTomQb9BT12wnCg==
X-IronPort-AV: E=Sophos;i="6.20,243,1758585600"; 
   d="scan'208";a="6028406"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-011.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 20:11:56 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.234:19834]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.33.168:2525] with esmtp (Farcaster)
 id ff878b85-38c1-4897-bf1b-02f6f1882526; Tue, 2 Dec 2025 20:11:56 +0000 (UTC)
X-Farcaster-Flow-ID: ff878b85-38c1-4897-bf1b-02f6f1882526
Received: from EX19D012EUA002.ant.amazon.com (10.252.50.32) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Tue, 2 Dec 2025 20:11:56 +0000
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19D012EUA002.ant.amazon.com (10.252.50.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Tue, 2 Dec 2025 20:11:56 +0000
Received: from EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719]) by
 EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719%3]) with mapi id
 15.02.2562.029; Tue, 2 Dec 2025 20:11:56 +0000
From: "Chalios, Babis" <bchalios@amazon.es>
To: "richardcochran@gmail.com" <richardcochran@gmail.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Chalios, Babis" <bchalios@amazon.es>, "Graf (AWS), Alexander"
	<graf@amazon.de>, "mzxreary@0pointer.de" <mzxreary@0pointer.de>, "Woodhouse,
 David" <dwmw@amazon.co.uk>
Subject: [PATCH v2 3/4] dt-bindings: clock: Add device tree bindings for
 vmclock
Thread-Topic: [PATCH v2 3/4] dt-bindings: clock: Add device tree bindings for
 vmclock
Thread-Index: AQHcY8fodA3Kt0qHa0qr5uQyHwjehw==
Date: Tue, 2 Dec 2025 20:11:55 +0000
Message-ID: <20251202201118.20209-4-bchalios@amazon.es>
References: <20251202201118.20209-1-bchalios@amazon.es>
In-Reply-To: <20251202201118.20209-1-bchalios@amazon.es>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

From: David Woodhouse <dwmw@amazon.co.uk>=0A=
=0A=
Add device tree bindings for the vmclock device, similar to the existing=0A=
vmgenid bindings. The vmclock device provides a PTP clock source and=0A=
precise timekeeping across live migration and snapshot/restore operations.=
=0A=
=0A=
The bindings specify a required memory region containing the vmclock_abi=0A=
structure and an optional interrupt for clock disruption notifications.=0A=
=0A=
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>=0A=
Signed-off-by: Babis Chalios <bchalios@amazon.es>=0A=
---=0A=
 .../bindings/clock/amazon,vmclock.yaml        | 46 +++++++++++++++++++=0A=
 1 file changed, 46 insertions(+)=0A=
 create mode 100644 Documentation/devicetree/bindings/clock/amazon,vmclock.=
yaml=0A=
=0A=
diff --git a/Documentation/devicetree/bindings/clock/amazon,vmclock.yaml b/=
Documentation/devicetree/bindings/clock/amazon,vmclock.yaml=0A=
new file mode 100644=0A=
index 000000000000..f7dfa022bf6f=0A=
--- /dev/null=0A=
+++ b/Documentation/devicetree/bindings/clock/amazon,vmclock.yaml=0A=
@@ -0,0 +1,46 @@=0A=
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)=0A=
+%YAML 1.2=0A=
+---=0A=
+$id: http://devicetree.org/schemas/clock/amazon,vmclock.yaml#=0A=
+$schema: http://devicetree.org/meta-schemas/core.yaml#=0A=
+=0A=
+title: Virtual Machine Clock=0A=
+=0A=
+maintainers:=0A=
+  - David Woodhouse <dwmw2@infradead.org>=0A=
+=0A=
+description:=0A=
+  The vmclock device provides a precise clock source and allows for=0A=
+  accurate timekeeping across live migration and snapshot/restore=0A=
+  operations. The full specification of the shared data structure=0A=
+  is available at https://david.woodhou.se/VMClock.pdf=0A=
+=0A=
+properties:=0A=
+  compatible:=0A=
+    const: amazon,vmclock=0A=
+=0A=
+  reg:=0A=
+    description:=0A=
+      Specifies the shared memory region containing the vmclock_abi struct=
ure.=0A=
+    maxItems: 1=0A=
+=0A=
+  interrupts:=0A=
+    description:=0A=
+      Interrupt used to notify when the contents of the vmclock_abi struct=
ure=0A=
+      have been updated.=0A=
+    maxItems: 1=0A=
+=0A=
+required:=0A=
+  - compatible=0A=
+  - reg=0A=
+=0A=
+additionalProperties: false=0A=
+=0A=
+examples:=0A=
+  - |=0A=
+    #include <dt-bindings/interrupt-controller/arm-gic.h>=0A=
+    vmclock@80000000 {=0A=
+      compatible =3D "amazon,vmclock";=0A=
+      reg =3D <0x80000000 0x1000>;=0A=
+      interrupts =3D <GIC_SPI 36 IRQ_TYPE_EDGE_RISING>;=0A=
+    };=0A=
-- =0A=
2.34.1=0A=
=0A=

