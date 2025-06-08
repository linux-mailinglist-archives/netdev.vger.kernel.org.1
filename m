Return-Path: <netdev+bounces-195601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AE8AD15D0
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 01:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94E3B188B09A
	for <lists+netdev@lfdr.de>; Sun,  8 Jun 2025 23:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE16326B09D;
	Sun,  8 Jun 2025 23:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaBDSbrd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2655A8BFF;
	Sun,  8 Jun 2025 23:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749425415; cv=none; b=R4Cy1xQtHlhq7ULK7tHcAsrx31C8yFk8bpNL8ux7dWIpus0+DMq+vLOxcE4GMEYkl6ZXoZ/5J++ryNFtAp/K5SHD+g0v0n+YBUnGuXTL1ba5Yjp9plmHHhynv6T1dLQykq2QUctJeJJ1qJ8LFw4fT57wH4ExP21rOWgQGL9rBE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749425415; c=relaxed/simple;
	bh=WXIC7BXoL5VzZe6AB6ubEaNVlDunir6dDnybKM0E9Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z5XQtlPliJcdke8AsEe6b3BWqLF4bEvBNVp+QJMxK6T8654FwvEAOhlZ5vK5gKbl/zsHvRrN+NLRRC1kXBhbkys+MM8eEo/8+hi3qr5Rb34XZjZNLACzWwzWMnTZ6wEEhpCuyKCWJYWLb+eme3ejY7OwDJ/gQ84BaQgcHOcjaSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RaBDSbrd; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a43d2d5569so50643611cf.0;
        Sun, 08 Jun 2025 16:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749425413; x=1750030213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dF4yjXSJrUcpYvv+fh7N1bp9yrQ9N5XG6Cs9FRn2x8Y=;
        b=RaBDSbrdrBkSkz/EzcQGFblycHMpQGIGFZ0coy6RGke0fQZY1SlygaJSxhGaGLwYeo
         LoKiFhZu0MRtWWUMLMqIUCnPY+edW0ir3Ag4ri2RSk+K3a/BCVKubhXds/se8JdRj36T
         PEsqu0w+UV8vESGzpOZ7ooUOUFOlFpQvN47QS620wDG5JuiyyD2c28EqzMZCAcFZtEet
         YJRNbbLJSIqJnMKOZQyoJF925JMtRNRp1BmFusxhY8Xzpj8K6mpzUyAG5lxz84xenlcH
         6u8Eau3ttyZmdEbIjjFY+mndxaVYv6vKfG75Gh2PCJXflnC2OF7hRolvsFVtqRUHfLa1
         j74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749425413; x=1750030213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dF4yjXSJrUcpYvv+fh7N1bp9yrQ9N5XG6Cs9FRn2x8Y=;
        b=mKRX+Z6z4uzApzOOWzIhgBytrygO9BUANlexrwF2uEidy43nuxt+o70tu/mzPPA64/
         bcAnGO2M1f2l5y1BcIADg54N8RcT9fbfh2KFNksQT0p6U0afTBz6qYvU+6zoySSt1V3/
         FINjtAhL4Fky70TUvjFS2g1G2IOMdbOkg9qhyOyKPvepLfcBS9bggJMfQpr5g8yCE9zX
         RPCIrrsM/RiK2LI0Pa2kQQoJW1GN91/QLK09Mg9fHOqTtAsFNJfpmdJDQiV/RhZzpozu
         KGq8ZEXo8rqZPWZ6d89ctAozztbvgxgIInkHWfVZzzNXy0QhNwzetekEJlvPNzhIqM8e
         U5Hw==
X-Forwarded-Encrypted: i=1; AJvYcCUHT6wXYgFt2ER6D4FzaDq0OeCGBDptGR3McJROGrA5jFHLQCUy5pWai3AZ5rX2lt/ZiJ2OuHLRbqzxudow@vger.kernel.org, AJvYcCUTK6yxEXbXs7QhOrt58aWc9vUx6sp36PHqtNmk/tuFh98Qh7ZEwQdIVI9zZvShXMu0iPqZWb7J67Kl@vger.kernel.org, AJvYcCXm9BXW6BrLDH8aPGxb6d8OumEfA/mw7dCKOQm6AMPzbTUFlyriy78Z7ZRDUDpftYM32GTsyA5G@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0myqlMxJNYeq3sb95px5EYVNCH+32W83PDMxEpZHAH1/Eos6C
	+GD4rRE9wZbNf7ahKsn5kVuWcQ5+NEkgMvVtjklU4w9xfVnZuzs14sg5
X-Gm-Gg: ASbGncuILo21X05FOqmBS297JPoW5CFv8ZEW+swX1kiAP1oVDv8HayaAqGyuM5RZZPX
	izIodmbOb1gcctnHCXeGY6j6h/SHtwwFCXCbBTjfd/Y7gu9uaGfY41DliRAx5gQ39AW1Ywi+u5/
	3yZRKp/0a9VmEyW/YUHQv0WkFHl3cCAfPxZRshg4ISaqX81fEczSqyXT58mUv3RsMaL2wvPQWVX
	MVOFRCgI/LFdQhq5wgNVD7NFG78u80UsCRI3rsRHFE+R8hLLp1LSBUmEQio4ekAwmAmYIRcE08M
	+AkKgW6uLMmMuOJYVwLHwKs5SUvGDTtAkOXUyg==
X-Google-Smtp-Source: AGHT+IFJtdD36SLKzA4s4tQ2l6v6xrhKbEE2YacMHc2B6BFbqlcLwe3sQC6STy67hHJv2b5IpjtjiA==
X-Received: by 2002:ac8:530e:0:b0:4a6:ef6d:d608 with SMTP id d75a77b69052e-4a6ef6dd6f2mr102198141cf.38.1749425413058;
        Sun, 08 Jun 2025 16:30:13 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4a61115000bsm48297391cf.1.2025.06.08.16.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 16:30:12 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Longbin Li <looong.bin@gmail.com>
Cc: Han Gao <rabenda.cn@gmail.com>,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>
Subject: [PATCH 09/11] riscv: dts: sophgo: sg2044: Add pinctrl device
Date: Mon,  9 Jun 2025 07:28:33 +0800
Message-ID: <20250608232836.784737-10-inochiama@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250608232836.784737-1-inochiama@gmail.com>
References: <20250608232836.784737-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add pinctrl DT node and configuration for SG2044.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 arch/riscv/boot/dts/sophgo/sg2044.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2044.dtsi b/arch/riscv/boot/dts/sophgo/sg2044.dtsi
index bbf4191fb87d..be20efd8e2ac 100644
--- a/arch/riscv/boot/dts/sophgo/sg2044.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2044.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/clock/sophgo,sg2044-clk.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/pinctrl-sg2044.h>
 
 #include "sg2044-cpus.dtsi"
 #include "sg2044-reset.h"
@@ -329,6 +330,11 @@ syscon: syscon@7050000000 {
 			clocks = <&osc>;
 		};
 
+		pinctrl: pinctrl@7050001000 {
+			compatible = "sophgo,sg2044-pinctrl";
+			reg = <0x70 0x50001000 0x0 0x1000>;
+		};
+
 		clk: clock-controller@7050002000 {
 			compatible = "sophgo,sg2044-clk";
 			reg = <0x70 0x50002000 0x0 0x1000>;
-- 
2.49.0


