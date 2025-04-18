Return-Path: <netdev+bounces-184030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A20A92FA5
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 04:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9877C16BDF5
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0122673AA;
	Fri, 18 Apr 2025 02:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUjiiB87"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7924C266F1D;
	Fri, 18 Apr 2025 02:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744941816; cv=none; b=bkMqSWevv+KfBzGeQs+H9YVBikop6e48IxJLAa1yleFQW259oX+cSgYvObdmIC/Ms5WltlPurSPutjfFUHGb2cNU2ml2shF2roGTGxj45xBXvf6HIVRpkOiF/YOWqHjOQczF9vIJT/RwUlT3VI1jcCj85V3l7xyB1x1DkIIXoJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744941816; c=relaxed/simple;
	bh=WLDxpltDErOzVOTnkbVqExu2Ae4XJAF05H9tQcPPm4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQD4MTB4z9zx1pAW23zCCVelco+JVfKpiBNu45xxKQdV1+UT40+SIsbnMsfSj2ZbUmdxA2hvR36iiRcBTuARpetXVkntF0X3bKwfL0i1X0ENJVuWRNLH7zpn5DQuIkr1MjGs5nF9cYLkB/IADKT9GgVNpMwhN5zjK+Jqui7fdMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hUjiiB87; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c7913bab2cso131205385a.0;
        Thu, 17 Apr 2025 19:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744941813; x=1745546613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oo/SYU99E48j5meaZwc3qX5Cn/K5aoYJsX5SSwIrrhE=;
        b=hUjiiB87N+iLEjh9BJFr6ku1y3Wtp+v/6Vg7VW/ksRyRAB/DoNE0SK3Z1gX248ZQHC
         Za5uYRZjxNCek1KPNfZgm2RpRRoP+O35ZeVhXB1c298yhyHnlnhmGM4ZDI6O6FMRAd/r
         x7fTEDW95XOH0iJycbxr1Hk4REiHlO+vJyvcg6qfKYVg4a6IE33MoaObZdvYXww24cP0
         LNdrc4SQKW6dmcDyiHh+VJ5wBvZieKjDHoTBhuZ/y8C9AalX5Krf8uGCgYAQ3hWwmsgb
         1ik1T922dlcsRjBpLsyMfIG3vcreyQzgKsceTZvLMA6h6gGxRPcD52Sq/R1VpSRGqoc7
         4tFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744941813; x=1745546613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oo/SYU99E48j5meaZwc3qX5Cn/K5aoYJsX5SSwIrrhE=;
        b=Ld8+3zIqVN269NwMxmzUV2/aIz5KupcXttvYXj2R+S3/hP1UmBTKFoahp9K8KxxXYu
         tfMpGH8YF7yiaB+KOXgqcgxQf3yVmXCg15830Q+8N/BSzZVtHcAyQo2v/I9hJnONDecs
         CxPdBBIAo/ld2QWrxJGzQL/drKectNg7z4RgqJRBPrUqvVAPwtfGEFc05mPj8KTgURTD
         N/GyGPhVjk8A1IU5hgslRkWorPeOLrzJ9L8nhyPq6Qojj0/pkUQ8RKvfg0KK3mf/Zchh
         rqwd3IRKBsgEsyltrGS744syRst48ICH/W9av63UE5J9BEx21zz86FDdxnxvSHF2oKBX
         nc7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/v/OOtm4OzXfbclS+PxngmliqHReRxoUXP5zFdnj9fpy3oPxlRb8P6yQQRPbF1ayVlIx8qRvjdeUbXnew@vger.kernel.org, AJvYcCU2Qj8ZXCUqSr9uOHlmhCoNwBMQRpfdV+rx1i/kxCzy6OaubyswZhoh3I3J9oOlwpAn861jUC8t@vger.kernel.org, AJvYcCVSJCe4YT1QEkhoFKRPz79XyJWHl5FelYjY8dAoSW2wj8DMI8J9hoIAiUc3YkjUy3C4sKncCl1gJtmz@vger.kernel.org
X-Gm-Message-State: AOJu0YzjzP8fNPRGLwxMr+zri3h5H0vRiGXv0pQAiW/MgmWtV+Pxc0fT
	9VGuXagwoC4njFxXF2bUWGKhkHCLk1d+g4R1Lv5VqifNbuKcn/uC
X-Gm-Gg: ASbGncsqibBtTo/sqGkTcxa6cbcLOmFY5i0sOSQqM6Y6yyTHJDgASpRXnZQX7RgX8js
	iIcaxZ/s/ly7Q8TTcvfGAhBHNb1httOndyqvVfYaMzZro6M0EB3gOcddCYj4Cwa105cYLWjf4IK
	17y9Ik1eZexny0pqkppFckmcG4paZdZBGZlx63FQOj3jkYepa6AxvWViJTQNWkUCbgKRMsIp/6K
	W0T8YZd3QO9lov1KCa5o8rnmWAQOKQYfZ80ljBJjFaI7K5hD35EVKzoG5DArM+krM1CZOt5EjUK
	dXaZpdtmgMM81pkF
X-Google-Smtp-Source: AGHT+IH+YKx8zZs28YS6wYbQg0JlNTkgEFi5Q6vqgeUkpK1+4+JTc0ay2QWGOVpjNqMg1ZsOzDWH7A==
X-Received: by 2002:a05:620a:450d:b0:7c5:4788:a14e with SMTP id af79cd13be357-7c92801875emr157001285a.39.1744941813256;
        Thu, 17 Apr 2025 19:03:33 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47ae9c17a07sm5564621cf.7.2025.04.17.19.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 19:03:32 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/5] dt-bindings: soc: sophgo: Add SG2044 top syscon device
Date: Fri, 18 Apr 2025 10:03:20 +0800
Message-ID: <20250418020325.421257-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250418020325.421257-1-inochiama@gmail.com>
References: <20250418020325.421257-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SG2044 top syscon device provide PLL clock control and some other
misc feature of the SoC.

Add the compatible string for SG2044 top syscon device.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../soc/sophgo/sophgo,sg2044-top-syscon.yaml  | 49 +++++++++++++++++++
 include/dt-bindings/clock/sophgo,sg2044-pll.h | 27 ++++++++++
 2 files changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2044-top-syscon.yaml
 create mode 100644 include/dt-bindings/clock/sophgo,sg2044-pll.h

diff --git a/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2044-top-syscon.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2044-top-syscon.yaml
new file mode 100644
index 000000000000..a82cc3cae576
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2044-top-syscon.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/sophgo/sophgo,sg2044-top-syscon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo SG2044 SoC TOP system controller
+
+maintainers:
+  - Inochi Amaoto <inochiama@gmail.com>
+
+description:
+  The Sophgo SG2044 TOP system controller is a hardware block grouping
+  multiple small functions, such as clocks and some other internal
+  function.
+
+properties:
+  compatible:
+    items:
+      - const: sophgo,sg2044-top-syscon
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+    description:
+      See <dt-bindings/clock/sophgo,sg2044-pll.h> for valid clock.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    syscon@50000000 {
+      compatible = "sophgo,sg2044-top-syscon", "syscon";
+      reg = <0x50000000 0x1000>;
+      #clock-cells = <1>;
+      clocks = <&osc>;
+    };
diff --git a/include/dt-bindings/clock/sophgo,sg2044-pll.h b/include/dt-bindings/clock/sophgo,sg2044-pll.h
new file mode 100644
index 000000000000..817d45e700cc
--- /dev/null
+++ b/include/dt-bindings/clock/sophgo,sg2044-pll.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright (C) 2024 Inochi Amaoto <inochiama@gmail.com>
+ */
+
+#ifndef __DT_BINDINGS_SOPHGO_SG2044_PLL_H__
+#define __DT_BINDINGS_SOPHGO_SG2044_PLL_H__
+
+#define CLK_FPLL0			0
+#define CLK_FPLL1			1
+#define CLK_FPLL2			2
+#define CLK_DPLL0			3
+#define CLK_DPLL1			4
+#define CLK_DPLL2			5
+#define CLK_DPLL3			6
+#define CLK_DPLL4			7
+#define CLK_DPLL5			8
+#define CLK_DPLL6			9
+#define CLK_DPLL7			10
+#define CLK_MPLL0			11
+#define CLK_MPLL1			12
+#define CLK_MPLL2			13
+#define CLK_MPLL3			14
+#define CLK_MPLL4			15
+#define CLK_MPLL5			16
+
+#endif /* __DT_BINDINGS_SOPHGO_SG2044_PLL_H__ */
-- 
2.49.0


