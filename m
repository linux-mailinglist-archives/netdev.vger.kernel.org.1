Return-Path: <netdev+bounces-243402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E27C9F018
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 13:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E57C4E062A
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 12:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7082F6907;
	Wed,  3 Dec 2025 12:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b="djad5Cit"
X-Original-To: netdev@vger.kernel.org
Received: from fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.158.153.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038172F5492;
	Wed,  3 Dec 2025 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.158.153.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764765399; cv=none; b=JhF+eGhTNrqdjzDiIfgjHkzOAkpd6PbWPAwg1YkcXKdAlGiDx03QP1rLnKXdVFADphI0X81P/NodxemH4GWwZ1ppgHM/JorHbgsCHI2d2fKhjxzcP9YOyb138he9sVxMQ4hIkDJ3nt4uhCFlOjSxnX8I+nZhvbGl9AFkBjD2Z10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764765399; c=relaxed/simple;
	bh=OuEjjH9mSjBxM4QzRLxmxqV1VYqz4u7Jm9THFOEhO3E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=djgJluWZMe2cdtgMwUFBFSzCfXNzCvGJ3RiMxCRPE/wAlax0XIYcKkNw0Sg/menOgVaBVk6QG+tFbq8xuSV1Zdk+HYTMy9dlLVMjUXwnPgMOl7Ix5Pc4G+WkzoJnpI9/Ngh98ogO555NrUUsftcu5ybix/2Zf8SGFxgYE5etlms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b=djad5Cit; arc=none smtp.client-ip=18.158.153.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
  t=1764765397; x=1796301397;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pvySg+kPzP2QUTgbm9qU1oGJZWi4wW0xO2DMXB7Z/58=;
  b=djad5CitJ/sGRQxY7bURaoHxtoipmbpGq09ozpGW4bGdQ0C7f3VuFMfy
   pMYVbttBKFdB0JW13zX8CRtTp6jxVyhEXe3tmnf/E6VtMlRVjiWfuIBzh
   a+7uy3l6o0l7F9HnRU5l/e7AsFsDO8pT1lJ5CeZoW7hNbkPSE4hYgTzKl
   lUoxXkHbHAlZde6lpGryyGeBZli1LQxO7W2TEedQ1MgK+jBR968acjtxT
   lkweXOvefbuGiPYvdQhX1/PMLWiwth/8DseigSIm8W7fDyfo/HGGtX/vl
   F+Lo1AY/EXN4IbEdKWkWlTSaumWWtRnmUjtZq3QRlHIhCCLiNBxNs76W4
   Q==;
X-CSE-ConnectionGUID: A5/poB8oTpitxrkrQwmOPg==
X-CSE-MsgGUID: 4AL6i6nvQW2/7ZnX+uPaNA==
X-IronPort-AV: E=Sophos;i="6.20,245,1758585600"; 
   d="scan'208";a="6055405"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-015.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 12:36:16 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.225:31018]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.44.247:2525] with esmtp (Farcaster)
 id 8f35d449-7aa5-4bde-9dd9-5ea76daaf8be; Wed, 3 Dec 2025 12:36:15 +0000 (UTC)
X-Farcaster-Flow-ID: 8f35d449-7aa5-4bde-9dd9-5ea76daaf8be
Received: from EX19D012EUA003.ant.amazon.com (10.252.50.98) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Wed, 3 Dec 2025 12:36:15 +0000
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19D012EUA003.ant.amazon.com (10.252.50.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Wed, 3 Dec 2025 12:36:15 +0000
Received: from EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719]) by
 EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719%3]) with mapi id
 15.02.2562.029; Wed, 3 Dec 2025 12:36:15 +0000
From: "Chalios, Babis" <bchalios@amazon.es>
To: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Chalios,
 Babis" <bchalios@amazon.es>, "Graf (AWS), Alexander" <graf@amazon.de>,
	"mzxreary@0pointer.de" <mzxreary@0pointer.de>, "Cali, Marco"
	<xmarcalx@amazon.co.uk>, "Woodhouse, David" <dwmw@amazon.co.uk>
Subject: [PATCH v3 3/4] dt-bindings: ptp: Add amazon,vmclock
Thread-Topic: [PATCH v3 3/4] dt-bindings: ptp: Add amazon,vmclock
Thread-Index: AQHcZFFqvjaElh4u/EyqGPfxbtAyoA==
Date: Wed, 3 Dec 2025 12:36:15 +0000
Message-ID: <20251203123539.7292-4-bchalios@amazon.es>
References: <20251203123539.7292-1-bchalios@amazon.es>
In-Reply-To: <20251203123539.7292-1-bchalios@amazon.es>
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
The vmclock device provides a PTP clock source and precise timekeeping=0A=
across live migration and snapshot/restore operations.=0A=
=0A=
The binding has a required memory region containing the vmclock_abi=0A=
structure and an optional interrupt for clock disruption notifications.=0A=
=0A=
The full specification is at https://david.woodhou.se/VMClock.pdf=0A=
=0A=
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>=0A=
Signed-off-by: Babis Chalios <bchalios@amazon.es>=0A=
---=0A=
 .../bindings/ptp/amazon,vmclock.yaml          | 46 +++++++++++++++++++=0A=
 1 file changed, 46 insertions(+)=0A=
 create mode 100644 Documentation/devicetree/bindings/ptp/amazon,vmclock.ya=
ml=0A=
=0A=
diff --git a/Documentation/devicetree/bindings/ptp/amazon,vmclock.yaml b/Do=
cumentation/devicetree/bindings/ptp/amazon,vmclock.yaml=0A=
new file mode 100644=0A=
index 000000000000..b98fee20ce5f=0A=
--- /dev/null=0A=
+++ b/Documentation/devicetree/bindings/ptp/amazon,vmclock.yaml=0A=
@@ -0,0 +1,46 @@=0A=
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)=0A=
+%YAML 1.2=0A=
+---=0A=
+$id: http://devicetree.org/schemas/ptp/amazon,vmclock.yaml#=0A=
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
+    ptp@80000000 {=0A=
+      compatible =3D "amazon,vmclock";=0A=
+      reg =3D <0x80000000 0x1000>;=0A=
+      interrupts =3D <GIC_SPI 36 IRQ_TYPE_EDGE_RISING>;=0A=
+    };=0A=
-- =0A=
2.34.1=0A=
=0A=

