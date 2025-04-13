Return-Path: <netdev+bounces-181993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99569A87482
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 00:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 689F316E052
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 22:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EEF1A23A5;
	Sun, 13 Apr 2025 22:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJpb23pn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6597219CC3C;
	Sun, 13 Apr 2025 22:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744584340; cv=none; b=rUMFBuCBIp2fcoLMTMk0LDXfDT4CUP4vOJj1kYEa05/u+8xS0TpMesF/H4Mn9f+YJA2SLWW2U3NhtNX7I7ZSWo212/A8K4dA3R1O9Qz1aihjEnywtea3Q7+IMK2kMP3VhYek1iTtq+A07EwNgMGimSBEA+m6gGFLI8T6kE38ojg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744584340; c=relaxed/simple;
	bh=IgS0jySddCzILyzFOwKBzCA1CFn7BMJSRZKtoNDzOJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDFxbIiV4KQrYLmabtQ1Ok+1uOFFpDx27UGaRhcPX9dngKKlkOhT0luNgw7+rbl4c25tHcpT5qYXjpZ8xphdsP8U3MURepXcU41mbHjMJKpjZBonMzGfgPxY24rwTTTyKjfJI1/AGs41x72FXcDCDmml8y032LFLGVJtgAkB/XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJpb23pn; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4766cb762b6so36802661cf.0;
        Sun, 13 Apr 2025 15:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744584337; x=1745189137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KLv1Jm8c7NQl2IjDh48safa9dB7KVfLqnGCbo3rz2Wk=;
        b=DJpb23pn+CtB0CjS53jD779/AiCqWS+mhyt3paffmxUIxdg38xlBDpzZGOK2WRkI/J
         vPWc5SDBQfnb9TxE7lZx/vRrllXpRGonLWwPAoXN2foNCk3pTH7vQQuBkrT3ztkE1VFw
         IrcTY6ECejSl9BX4VBU256FQZz1RYkirL7A8tbP99BRFFm2je40EVCg+6FzK34/2h4Os
         EI5ce5OMXZeXBdExrngOP+Z+c2KsTsz+alY8xNS5SQHk4aKhXqDePpCWHud/kRwoZmbF
         GdjrRybFqUVii0A8T7gT3kbXJCHzyROUCiAYQHt78+Et5xKhrVH/R4H+CvRVyMVWE8Yu
         Su8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744584337; x=1745189137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KLv1Jm8c7NQl2IjDh48safa9dB7KVfLqnGCbo3rz2Wk=;
        b=qk4JOWZxsICMGwkuzjxXIuDPAqyQPJvZGuG5Z1IBPS0aUhxUNlOIr8gkxfLdDHvCVs
         GIxxLkSIXTADhOrOVp7Hzece+5RVvKJsu4SQRWsIWI71dRLyVTe3Db8Ysi3uWQkjirc6
         sdm9x7jOtGuR8X02cOI9hitbEYAyfQaJFxB5fwIIhG68Hqe/eZBhq0BzPIzP+Ax8sTll
         rGANRM+sG3brtnI+tjmWaW2EPXWr5RjP5VYagMGYyoRX+mB606j0D6Y3NumiuRbVAEN5
         0hWUBChJBoScKk8Hbg8/jMX7W1ZFd0SEr2/wuONiUq4aJ1mLn40tT7XQooQFhkN+VAfK
         ivdA==
X-Forwarded-Encrypted: i=1; AJvYcCU7o6rjl1UwLNWSMYhNkbbH5QaWCGPpmsCe7IHij80XYqK9Qa9VshDh+m2atsmzq5/8MvlcgCviQGdqX6ma@vger.kernel.org, AJvYcCUN/asSmx4u/ZiED0T1dLVzJqCZ5HuOMsG6LqKG+KRI2TdsIMDqwqpGzFVgD5tsbQc6WB/ULZiVuSf7@vger.kernel.org, AJvYcCX07+JfmgIzKv2Biy9SwxI+FiD8zRmeoo+oWroF2w7MJWbxnlAgAEK3ZXe/fcx7mtcKGsG4x4bY@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo1Y04uaKQqakRfXSBfyxjcmuHn/1IKdCnLB9zLhVblj7YXoci
	uyG25fd5QVpBWNDWa939QugTreiqTbDe64r3mTgp81R+sW4Nbr2X
X-Gm-Gg: ASbGncvBTb92hLvd2UCqW7/q+0kq/HWBzQ1qWvWre1uOJtUStEdp2jlZ7HZsSmTWP1O
	fxFRor2NDt7nJXvp20MlrobDgThu4n+M+hGojBEnCvZ6Eh7TuBuieyOj4xyv+K3ZKjzXcNPycAJ
	ZRf7HMzAtbSg0Ete/hRrkTzRZcN49pEDM7+M9f2KMZ+EEzrP7VIoX2GpVhhZLztwSNrt/gxYXhP
	Q7FBFvukflj34B+56CuQbzZvYoqqcW+Lt/pVr/m/06rQki0KOxHf4GRtojI5H1I8cufgaONK2fC
	eninXVF1wuheuChe7M80IW4tVHc=
X-Google-Smtp-Source: AGHT+IHWsY2Igh59MObycnfp1lr69NA2wpEqLo+C1nHbGkC3vdFYcXBFU36Hw70ORCEGaebGqBPvNQ==
X-Received: by 2002:ac8:5dcc:0:b0:476:afa6:3218 with SMTP id d75a77b69052e-47976d2f609mr153909371cf.14.1744584337110;
        Sun, 13 Apr 2025 15:45:37 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7b7cd5f4fsm298797485a.54.2025.04.13.15.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 15:45:36 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Nikita Shubin <nikita.shubin@maquefel.me>
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v4 1/5] dt-bindings: soc: sophgo: Add SG2044 top syscon device
Date: Mon, 14 Apr 2025 06:44:45 +0800
Message-ID: <20250413224450.67244-2-inochiama@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250413224450.67244-1-inochiama@gmail.com>
References: <20250413224450.67244-1-inochiama@gmail.com>
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


