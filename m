Return-Path: <netdev+bounces-247757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A0ACFDEDF
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 14:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69822300ACBE
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 13:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96ACE33F8BA;
	Wed,  7 Jan 2026 13:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b="s3WTaWwZ"
X-Original-To: netdev@vger.kernel.org
Received: from fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com [52.57.120.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220D333FE34;
	Wed,  7 Jan 2026 13:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.57.120.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767792441; cv=none; b=Z1XKRzs9qxZKBI00e5aacVGFMIbtrzCLeTZeDhbxfeDdw7BZwNtQFv9LV8FHwk/DCi+4bEbnV3DPqaN+f6uohcg0H2qhbIwvVospj9INEg6cFvsWmDrn7hAXYxx/jhTbJ1XbBV8oVic3erSm61ydGT8Ec8BtUd7svYGnADi8W5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767792441; c=relaxed/simple;
	bh=CMePqU7fDA/wHXd5/nycVWAvieQKAaHLSa+FSiuP0+0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qTgj5gENL8vlP+7xCr0d3upO/kUrXR6G2pZ5KtPho+XiGtXqp2r2LbdvjVG/fjehtjqvH9cABErqNLRBJF7GvL82/mpJFvUiGQ8LywA+507BDYKSicskWa4tiudCYHSwdS+ChZfLDAhyCVGBJemUrQb1VWf3wFfpVKTB3EhQ6v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b=s3WTaWwZ; arc=none smtp.client-ip=52.57.120.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
  t=1767792439; x=1799328439;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yIJepOPX3arqb5MyazZ+94RAcXRQ7bSmHnzahqj+Zso=;
  b=s3WTaWwZ/VkPvkT8U2YcwGAsQCUFaZON5tEUkPoPekbuDd3ZWdgxZM2e
   mCPHkJV++hfCYSfo6ByDO5xULbjsU5eu3j4dNZqe+WCSxttuozeYU6Dau
   LCElTnhDDNTECHT/+pl2uaEeBnBTKn2kFvsAGjgz6TwJfcfqKH7d251zl
   WyOmj0OraMIhMex9HXTLV830FC6u2SKuHaT+WhAKfVoMbRY56NThPdeG+
   CNdoASYGv2gK0w8aM/G43ilgGC57DC/H1/5clG8DIqsX1NmRXj5osydPq
   1YTQRUszgbb1GZ3La89kiCybj0X61sS0pthn/hy4jS7S+pSygMwedkc9a
   Q==;
X-CSE-ConnectionGUID: xOpZit2GTu+Kq2Ek5lFvJA==
X-CSE-MsgGUID: DXdAOuVoQ0mEwNsgDrfkfQ==
X-IronPort-AV: E=Sophos;i="6.21,208,1763424000"; 
   d="scan'208";a="7474660"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 13:25:51 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:25407]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.44.14:2525] with esmtp (Farcaster)
 id e68d9584-8813-4339-872d-da1bc2eb117d; Wed, 7 Jan 2026 13:25:50 +0000 (UTC)
X-Farcaster-Flow-ID: e68d9584-8813-4339-872d-da1bc2eb117d
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 7 Jan 2026 13:25:50 +0000
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19D012EUA001.ant.amazon.com (10.252.50.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 7 Jan 2026 13:25:50 +0000
Received: from EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719]) by
 EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719%3]) with mapi id
 15.02.2562.035; Wed, 7 Jan 2026 13:25:50 +0000
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
	<xmarcalx@amazon.co.uk>, "Woodhouse, David" <dwmw@amazon.co.uk>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v5 3/7] dt-bindings: ptp: Add amazon,vmclock
Thread-Topic: [PATCH v5 3/7] dt-bindings: ptp: Add amazon,vmclock
Thread-Index: AQHcf9kjlf9LyNdHpUqK8CP9OeMyQQ==
Date: Wed, 7 Jan 2026 13:25:50 +0000
Message-ID: <20260107132514.437-4-bchalios@amazon.es>
References: <20260107132514.437-1-bchalios@amazon.es>
In-Reply-To: <20260107132514.437-1-bchalios@amazon.es>
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
The full spec is at https://uapi-group.org/specifications/specs/vmclock/=0A=
=0A=
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>=0A=
Signed-off-by: Babis Chalios <bchalios@amazon.es>=0A=
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>=0A=
---=0A=
 .../bindings/ptp/amazon,vmclock.yaml          | 46 +++++++++++++++++++=0A=
 MAINTAINERS                                   |  1 +=0A=
 2 files changed, 47 insertions(+)=0A=
 create mode 100644 Documentation/devicetree/bindings/ptp/amazon,vmclock.ya=
ml=0A=
=0A=
diff --git a/Documentation/devicetree/bindings/ptp/amazon,vmclock.yaml b/Do=
cumentation/devicetree/bindings/ptp/amazon,vmclock.yaml=0A=
new file mode 100644=0A=
index 000000000000..357790df876f=0A=
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
+  operations. The full specification of the shared data structure is=0A=
+  available at https://uapi-group.org/specifications/specs/vmclock/=0A=
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
diff --git a/MAINTAINERS b/MAINTAINERS=0A=
index e8f06145fb54..171813ea76a3 100644=0A=
--- a/MAINTAINERS=0A=
+++ b/MAINTAINERS=0A=
@@ -20728,6 +20728,7 @@ PTP VMCLOCK SUPPORT=0A=
 M:	David Woodhouse <dwmw2@infradead.org>=0A=
 L:	netdev@vger.kernel.org=0A=
 S:	Maintained=0A=
+F:	Documentation/devicetree/bindings/ptp/amazon,vmclock.yaml=0A=
 F:	drivers/ptp/ptp_vmclock.c=0A=
 F:	include/uapi/linux/vmclock-abi.h=0A=
 =0A=
-- =0A=
2.34.1=0A=
=0A=

