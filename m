Return-Path: <netdev+bounces-194224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9960BAC7F76
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 16:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC6831BC20C5
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 14:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF6920101D;
	Thu, 29 May 2025 14:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="o7DULGKg"
X-Original-To: netdev@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85411F4CA2
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748527342; cv=none; b=VseRLlUXqTVmKaf9tKQbIzUQTOAe8qcGBJt6lieV0pDckgQTM02YUC5NmE7sSyiDXSOp5dXeMfXlyR0HyNigL6R7VPXRNU5002UWhbEQbQUSwrnAzQyxM39XfWGXjsScOX+r5LqgUNbup+VPO+B0qeR0uZtYLHGPOoIHDd9kLq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748527342; c=relaxed/simple;
	bh=qKdugrmQLLT92YFM4L2XaakBvHBfNyW+E8uZS38rrCY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=ivAWnuMaiTC81JuuDdFylHmvFiMX6oqhFT9eqNh341EIP4AUtO+wJdFT6dOIIgqchOIOvzASVxsnOa9F6I0aSmraCp3uBulpuizNnW7yTMkm2xFPlQrjRgQ/mA0zTjBG+kHVf1bULEOFV0GeZ3EbaXRoYH/ntPod+wRZWyIUJ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=o7DULGKg; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250529140218epoutp045b5f0e7f25585d0a193d08e3ee2c43fe~EBFnGfZpJ1989119891epoutp04g
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 14:02:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250529140218epoutp045b5f0e7f25585d0a193d08e3ee2c43fe~EBFnGfZpJ1989119891epoutp04g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748527338;
	bh=dEQVnSXNcADAPNr8Vpuf31N+TYCmlqjl+Z9v+bKhkww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o7DULGKgRrp26rt3lue+SXg5q7OF8TBJjHeN6MwNdl36QYWSzN5iqaG9L824DDK5R
	 lABHqEqVdq+/urBDAg42ZsNDGVRc1lBd+U2LNNHC9QSkWA1URK8Jnwt4qQLuM+fTDa
	 XeJHNQ+UxUcVK9alWjb2/a5w0DPpoTDCZwQbllVI=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250529140218epcas5p11f374155f57fd3838844c34da90fcd27~EBFmSUuqJ0930209302epcas5p1F;
	Thu, 29 May 2025 14:02:18 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.179]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4b7Sjh1QvTz3hhT9; Thu, 29 May
	2025 14:02:16 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250529111711epcas5p48afd16e6f771a18e3b287b07edd83c22~D_1cg0zhQ0050500505epcas5p4D;
	Thu, 29 May 2025 11:17:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250529111711epsmtrp22cda4d46bd3bef49a5d102273189f718~D_1ceoxwZ2239822398epsmtrp2n;
	Thu, 29 May 2025 11:17:11 +0000 (GMT)
X-AuditID: b6c32a29-566fe7000000223e-86-68384237b5bb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	21.3F.08766.73248386; Thu, 29 May 2025 20:17:11 +0900 (KST)
Received: from bose.samsungds.net (unknown [107.108.83.9]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250529111708epsmtip18ee66a6c22c4e25c250128c22cb04975~D_1ZtzbuI2102821028epsmtip1E;
	Thu, 29 May 2025 11:17:08 +0000 (GMT)
From: Raghav Sharma <raghav.s@samsung.com>
To: krzk@kernel.org, s.nawrocki@samsung.com, cw00.choi@samsung.com,
	alim.akhtar@samsung.com, mturquette@baylibre.com, sboyd@kernel.org,
	robh@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com,
	sunyeal.hong@samsung.com, shin.son@samsung.com
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	chandan.vn@samsung.com, karthik.sun@samsung.com, dev.tailor@samsung.com,
	Raghav Sharma <raghav.s@samsung.com>
Subject: [PATCH v3 2/4] dt-bindings: clock: exynosautov920: add hsi2 clock
 definitions
Date: Thu, 29 May 2025 16:56:38 +0530
Message-Id: <20250529112640.1646740-3-raghav.s@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250529112640.1646740-1-raghav.s@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZdlhJTtfcySLDYM5JQ4sH87axWUz4EmGx
	Zu85JovrX56zWtzbsYzdYv6Rc6wWjTPeMFmcP7+B3WLT42usFh977rFaXN41h81ixvl9TBYX
	T7laHFsgZvF95R1GiyNnXjBb/N+zg93i8Jt2Vot/1zayWEw+vpbVomnZeiYHUY/3N1rZPXbO
	usvusWlVJ5vH5iX1Hn1bVjF6fN4kF8AWxWWTkpqTWZZapG+XwJXx9BhrwXyxihnznzE1MF4S
	6GLk5JAQMJGYNuEVYxcjF4eQwG5Gib6Ob4wQCQmJff9/Q9nCEiv/PWeHKHrLKNH/bA4TSIJN
	QEviyvZ3bCAJEYEuJolz/16xgDjMAjuZJNoebwNq4eAQFgiT6G93B2lgEVCVWPXsHQtImFfA
	WuLErkqIBfIS+w+eZQaxOQVsJO7efM4CYgsBlXzcfgYszisgKHFy5hOwODNQffPW2cwTGAVm
	IUnNQpJawMi0ilEytaA4Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjOMa0NHcwbl/1Qe8QIxMH
	4yFGCQ5mJRHeJnuzDCHelMTKqtSi/Pii0pzU4kOM0hwsSuK84i96U4QE0hNLUrNTUwtSi2Cy
	TBycUg1MMttc034xZZh/mfZ6y9I5Uy6FyLBulFa+E3nu2WPO57If/s7PWHnvpXWEe/XdUPOs
	Gy+7jhj055mqJp0+UbbUJCaDi+Pavgf/z0s99m69v++5/CJJqbMeF6YZ1ksX9p4IKJiS8uB+
	0+RtqTVC9YrTLKqbig0Kz2anf/I1lY9Y0u2bdnTPNHXZyWy6W6Y3mXJwf3VIv7dka1Jq3qsY
	21c3Na0Y1pVZTK6unpr+9YVHRqDCztdf38smHTTUYPi7/aIq38r0f29uKqU72CeHs+1qZrvV
	1fHj32aJXTUVPYG1PuHWwnYJn88/79IoPbCi7nbju6I2vmfn5Cdnxl0xYvPIfdVYq2fHmZe7
	KvvphW4lluKMREMt5qLiRAAkiQpIIAMAAA==
X-CMS-MailID: 20250529111711epcas5p48afd16e6f771a18e3b287b07edd83c22
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-543,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250529111711epcas5p48afd16e6f771a18e3b287b07edd83c22
References: <20250529112640.1646740-1-raghav.s@samsung.com>
	<CGME20250529111711epcas5p48afd16e6f771a18e3b287b07edd83c22@epcas5p4.samsung.com>

Add device tree clock binding definitions for CMU_HSI2

Signed-off-by: Raghav Sharma <raghav.s@samsung.com>
---
 .../clock/samsung,exynosautov920-clock.yaml   | 29 +++++++++++++++++--
 .../clock/samsung,exynosautov920.h            |  9 ++++++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/samsung,exynosautov920-clock.yaml b/Documentation/devicetree/bindings/clock/samsung,exynosautov920-clock.yaml
index 77117b887e19..72f59db73f76 100644
--- a/Documentation/devicetree/bindings/clock/samsung,exynosautov920-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/samsung,exynosautov920-clock.yaml
@@ -37,6 +37,7 @@ properties:
       - samsung,exynosautov920-cmu-cpucl2
       - samsung,exynosautov920-cmu-hsi0
       - samsung,exynosautov920-cmu-hsi1
+      - samsung,exynosautov920-cmu-hsi2
       - samsung,exynosautov920-cmu-misc
       - samsung,exynosautov920-cmu-peric0
       - samsung,exynosautov920-cmu-peric1
@@ -44,11 +45,11 @@ properties:
 
   clocks:
     minItems: 1
-    maxItems: 4
+    maxItems: 5
 
   clock-names:
     minItems: 1
-    maxItems: 4
+    maxItems: 5
 
   "#clock-cells":
     const: 1
@@ -201,6 +202,30 @@ allOf:
             - const: usbdrd
             - const: mmc_card
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: samsung,exynosautov920-cmu-hsi2
+
+    then:
+      properties:
+        clocks:
+          items:
+            - description: External reference clock (38.4 MHz)
+            - description: CMU_HSI2 NOC clock (from CMU_TOP)
+            - description: CMU_HSI2 NOC UFS clock (from CMU_TOP)
+            - description: CMU_HSI2 UFS EMBD clock (from CMU_TOP)
+            - description: CMU_HSI2 ETHERNET clock (from CMU_TOP)
+
+        clock-names:
+          items:
+            - const: oscclk
+            - const: noc
+            - const: ufs
+            - const: embd
+            - const: ethernet
+
 required:
   - compatible
   - "#clock-cells"
diff --git a/include/dt-bindings/clock/samsung,exynosautov920.h b/include/dt-bindings/clock/samsung,exynosautov920.h
index 5e6896e9627f..93e6233d1358 100644
--- a/include/dt-bindings/clock/samsung,exynosautov920.h
+++ b/include/dt-bindings/clock/samsung,exynosautov920.h
@@ -286,4 +286,13 @@
 #define CLK_MOUT_HSI1_USBDRD_USER	3
 #define CLK_MOUT_HSI1_USBDRD		4
 
+/* CMU_HSI2 */
+#define FOUT_PLL_ETH                    1
+#define CLK_MOUT_HSI2_NOC_UFS_USER      2
+#define CLK_MOUT_HSI2_UFS_EMBD_USER     3
+#define CLK_MOUT_HSI2_ETHERNET          4
+#define CLK_MOUT_HSI2_ETHERNET_USER     5
+#define CLK_DOUT_HSI2_ETHERNET          6
+#define CLK_DOUT_HSI2_ETHERNET_PTP      7
+
 #endif /* _DT_BINDINGS_CLOCK_EXYNOSAUTOV920_H */
-- 
2.34.1


