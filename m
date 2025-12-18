Return-Path: <netdev+bounces-245363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D1772CCC466
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 15:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E872305CB24
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 14:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECBF28D8DB;
	Thu, 18 Dec 2025 14:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b="YTHdQhGS"
X-Original-To: netdev@vger.kernel.org
Received: from fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com [52.57.120.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F3728F935;
	Thu, 18 Dec 2025 14:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.57.120.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766067911; cv=none; b=MXQi9ozko2wWQK1mZH44TRoGhM/PuTLA9Go6uKGYEBM89mKvS9rZMQyln63iYF8yF+0/XAAZPgGcvGjnHXeEPjQeWFhxF97u6ViK5/1nqgoKv8hGHBoSsq7FK9FzPCF3nl6M0Oxv7MDjpUByzJodYRK/Dc3b7Hqw2XTwBtc8vS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766067911; c=relaxed/simple;
	bh=CMePqU7fDA/wHXd5/nycVWAvieQKAaHLSa+FSiuP0+0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t2qD90m77l6eL7EqZXXtljYRwK7ZyfeiKaoYpzuwZKY750qTmj6gPh4O5zg1vSfHW6ocjc+q4xE/BVkVe4x249iEoTPMV0dXu/HYiqDn7Ae61AWLchkoDs9oFZe4SM7sp5iyyGycGvGjmK3bsZsH9Y3RltE2/XTcEejpFs2dTsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (2048-bit key) header.d=amazon.es header.i=@amazon.es header.b=YTHdQhGS; arc=none smtp.client-ip=52.57.120.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazoncorp2;
  t=1766067909; x=1797603909;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yIJepOPX3arqb5MyazZ+94RAcXRQ7bSmHnzahqj+Zso=;
  b=YTHdQhGS7MEfNuakoyeEMm9pSj/7m+viAiPtziJVw7VGjTcyLNkhlY4q
   iHo8VNrZp6jJXZpE+b0MzEXAI01PWVGT4PbbX/Oh6nYJHSPDc4UxHtscO
   JyuSFBhtwRA/VGywHvx/N93999JrlAgjVg5qj2OIfgwHoiN8vNDIdnXKG
   zTXG8YZhNLvVdKFPF4XyCbzPzw8ziRIQrBk9Gc2JQA3mjKraLNEodOh2S
   9dyOr4JRgp9ZhsnbJYDFAC0z0rOJBdxxkmDbgMvRk6ylDgVlxn/BOW4Yg
   0pNQuaknvndYm2w+lKRu5Dki3WT6QumZBhqqBT/ipG1//Vd8HYFPdXQaZ
   Q==;
X-CSE-ConnectionGUID: rgQK+gdMTs2pAUFYGqkPsw==
X-CSE-MsgGUID: qkRuJN0+RpGrXpcNDRiDJQ==
X-IronPort-AV: E=Sophos;i="6.21,158,1763424000"; 
   d="scan'208";a="6789740"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2025 14:24:50 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.233:1950]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.6.239:2525] with esmtp (Farcaster)
 id d3207552-f9d3-450f-ae81-f228cd5aab97; Thu, 18 Dec 2025 14:24:50 +0000 (UTC)
X-Farcaster-Flow-ID: d3207552-f9d3-450f-ae81-f228cd5aab97
Received: from EX19D012EUA002.ant.amazon.com (10.252.50.32) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 18 Dec 2025 14:24:44 +0000
Received: from EX19D012EUA001.ant.amazon.com (10.252.50.122) by
 EX19D012EUA002.ant.amazon.com (10.252.50.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Thu, 18 Dec 2025 14:24:44 +0000
Received: from EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719]) by
 EX19D012EUA001.ant.amazon.com ([fe80::b7ea:84f7:2c4b:2719%3]) with mapi id
 15.02.2562.035; Thu, 18 Dec 2025 14:24:44 +0000
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
Subject: [PATCH v4 3/7] dt-bindings: ptp: Add amazon,vmclock
Thread-Topic: [PATCH v4 3/7] dt-bindings: ptp: Add amazon,vmclock
Thread-Index: AQHccCoORHkz0txS5kuznCiIu4jEzA==
Date: Thu, 18 Dec 2025 14:24:44 +0000
Message-ID: <20251218142408.8395-4-bchalios@amazon.es>
References: <20251218142408.8395-1-bchalios@amazon.es>
In-Reply-To: <20251218142408.8395-1-bchalios@amazon.es>
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

