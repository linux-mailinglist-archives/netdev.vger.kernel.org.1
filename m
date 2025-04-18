Return-Path: <netdev+bounces-184029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02858A92F9F
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 04:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51FCC7A66AE
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 02:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E30266F05;
	Fri, 18 Apr 2025 02:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J00mXHiG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597D7266EFA;
	Fri, 18 Apr 2025 02:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744941813; cv=none; b=CIrsugsJrMpA9LJygMJyDnm+WOeW09N+2BCfeJYh3JVsDtdGtiIGAClFJ0AUS+ukpws6dPyQzdjjju0ymfJdsGhcQ9URITsW0GTcNUvvYky8WZnKrEK5ABqQC/C8HharJqvBvbj9jYtfP954/p6/MLjutE5kgIzRXVjhyK9O2Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744941813; c=relaxed/simple;
	bh=H5q6z+kuaAQjDm2IXTAh6qpMlWwWMy8TFUHZl2eXCFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Co4s4arZOm8/8qokKeMbyiO5G0EQxHmvGIaV1MzAx3z6qQ7YNmTPIHYFGKBa1GRkSK9eX8SlnxIS1pmtNqahpb6YAC8hRg07zeuFdhVVS/supBYswt6k4tuxQIfpCMBXkYlw19rIe49EPI9votaeChkfJ8RPIZfUepefiQLxwW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J00mXHiG; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6ed0cc5eca4so26025196d6.1;
        Thu, 17 Apr 2025 19:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744941810; x=1745546610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QiJSTAombYT5YK5lOs7JKc1JprZJDm9gl9IdWPklRRU=;
        b=J00mXHiGAnNeXe1zloD/hLxI5QgZFwHRddiaLzR1ZPXOs9ptWieABE4rjPAE9SlOuV
         yXpCcQtZZopmTpkYwuz/ct7l+04Hg0ebDknXpdYsXm2sHxMj6rmO+e6FTlkYD/pDhfSe
         SS1McE7L3n+4knHvpzHhpF7IsPxMcsUxOuAhusxdvDWwd6khsMO7UWX8gkqO+gCJxjcw
         hIXudpsmGk+W+UvnTQjMfzNIueb6ettQkk8pY5SS9/kZmHg0s2rw3XrpcDgbfQ0ri9r6
         B7MnQjMoc/268azGGTQf72t/1KsWsmEvdmcQ/zSyoYL2NIhPH+Gi36Gyvas5M67LlMGl
         ykWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744941810; x=1745546610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QiJSTAombYT5YK5lOs7JKc1JprZJDm9gl9IdWPklRRU=;
        b=mHCtettRq2Uk9p1D0MnNrvK0sQRAVEsqavtcrkAm/+qPi9yvMPe4YJj91fsOtTCsIY
         6x0ilT0wJ2if/O/8bXVNS7RFDBQFPK8sZ1koaQzgnr8aro9cPJscRkqLhHQrsvR+REcu
         pa/fXQE4kBazIfMEVYg3FeM8fVwsj9vwaAT7Heu1a7s+8bMcWUclZL1KHgU/QsJzOrm8
         2sIW+zCs9ZwjIjLy0+Std2qMO342jqUaCS0iyBq5n0bcM1MmqqjYKX9mlxXKobwlLPDY
         NdOxHz5J27eBnv1BfL20w2unLehV2FP6vJdboDJAdwwgsMBGZ7qr1W0gibet9pm3mKiF
         Ubcw==
X-Forwarded-Encrypted: i=1; AJvYcCUZOzhpuGVMmhJlctDTehEylz4cBPctp1dy1r/1bZ9XPNE6iBlTcdH3wO2JURGkWydBgoWK/5gy@vger.kernel.org, AJvYcCVqEaYK2CdOAx3bP45XcoH4oVAtl6x3Q6KnTN2zIXgtCrMYyq5fhkjQ6ourhcCnhZ4f1BWvo+B315qFTbrS@vger.kernel.org, AJvYcCWpzGZ4SNDZo4WPPpnI2+YbLgNoPy3pSrIHHeHXc9Syjx1CKzHH2oEf7QE2fLUzu9aQMPOHMJalNyTM@vger.kernel.org
X-Gm-Message-State: AOJu0YyA6h8nPXrg6WHOaX20bMwNUlIziaXWCwXU9UE5ely2FJ/u55yr
	F9FCuL1R3m4qEJT2r6cN8qoDu8WzXqwX9xJGk2mRWJLoKU/uQ501
X-Gm-Gg: ASbGncthsW9TWXKwFehONk6sAZiGkhbiBeP0Ghnt18Fi4ZjH4FwOQwReOg8kXfccm0i
	Mb8TGZ69XkaSEGBpBvEUz+0MblY2nXfU2g9ADvsK9hw5NMVYM9oT+tcj505jR7I0yMxA/9hOs3B
	8Y7toTh34IkDDS87PIW3x2DhoDhWpwX/Y5HFBuYz8NPJQ8MWrcqCS+KNRZMZDiO79TDo5y5nUWA
	vsQsf6iC/scsTsghjEbUG5UwWP4PwVfWSR2JiAqpKrhJAtJfQtdZItyR6ZsXyKA9ApMxtpH39bY
	1oiG/2LN1Tbwu86J
X-Google-Smtp-Source: AGHT+IEB9i6YpWsKnz7rlzD/nehkmDd48Zhy2xDMAbnR9LFBTSUlrOuNsa3E9u2yLaM0AMch338igQ==
X-Received: by 2002:a05:6214:2686:b0:6e6:5f22:bb58 with SMTP id 6a1803df08f44-6f2c4ef8b65mr17022866d6.20.1744941810074;
        Thu, 17 Apr 2025 19:03:30 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f2c2bfd198sm5589856d6.71.2025.04.17.19.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 19:03:29 -0700 (PDT)
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
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v5 0/5] clk: sophgo: add SG2044 clock controller support
Date: Fri, 18 Apr 2025 10:03:19 +0800
Message-ID: <20250418020325.421257-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clock controller of SG2044 provides multiple clocks for various
IPs on the SoC, including PLL, mux, div and gates. As the PLL and
div have obvious changed and do not fit the framework of SG2042,
a new implement is provided to handle these.

Changed from v4:
1. patch 1,3: Applied Krzysztof's tag.
2. patch 1: fix header path in description.
3. patch 4: drop duplicated module alias.
4. patch 5: make sg2044_clk_desc_data const.

Changed from v3:
- https://lore.kernel.org/all/20250226232320.93791-1-inochiama@gmail.com
1. patch 1,2: Add top syscon binding and aux driver.
2. patch 4: Separate the syscon pll driver to a standalone one.
3. patch 4: use abs_diff to compare pll clock.
4. patch 4: remove unnecessary else.
5. patch 5: use clk_hw for parent clocks if possible.
6. patch 5: inline the header which is necessary.
7. patch 5: make common array as const.

Changed from v2:
- https://lore.kernel.org/all/20250204084439.1602440-1-inochiama@gmail.com/
1. Applied Chen Wang's tag.
2. patch 2: fix author mail infomation.

Changed from v1:
- https://lore.kernel.org/all/20241209082132.752775-1-inochiama@gmail.com/
1. patch 1: Applied Krzysztof's tag.
2. patch 2: Fix the build warning from bot.

Inochi Amaoto (5):
  dt-bindings: soc: sophgo: Add SG2044 top syscon device
  soc: sophgo: sg2044: Add support for SG2044 TOP syscon device
  dt-bindings: clock: sophgo: add clock controller for SG2044
  clk: sophgo: Add PLL clock controller support for SG2044 SoC
  clk: sophgo: Add clock controller support for SG2044 SoC

 .../bindings/clock/sophgo,sg2044-clk.yaml     |   99 +
 .../soc/sophgo/sophgo,sg2044-top-syscon.yaml  |   49 +
 drivers/clk/sophgo/Kconfig                    |   19 +
 drivers/clk/sophgo/Makefile                   |    2 +
 drivers/clk/sophgo/clk-sg2044-pll.c           |  628 ++++++
 drivers/clk/sophgo/clk-sg2044.c               | 1812 +++++++++++++++++
 drivers/soc/Kconfig                           |    1 +
 drivers/soc/Makefile                          |    1 +
 drivers/soc/sophgo/Kconfig                    |   21 +
 drivers/soc/sophgo/Makefile                   |    3 +
 drivers/soc/sophgo/sg2044-topsys.c            |   45 +
 include/dt-bindings/clock/sophgo,sg2044-clk.h |  153 ++
 include/dt-bindings/clock/sophgo,sg2044-pll.h |   27 +
 13 files changed, 2860 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sophgo,sg2044-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2044-top-syscon.yaml
 create mode 100644 drivers/clk/sophgo/clk-sg2044-pll.c
 create mode 100644 drivers/clk/sophgo/clk-sg2044.c
 create mode 100644 drivers/soc/sophgo/Kconfig
 create mode 100644 drivers/soc/sophgo/Makefile
 create mode 100644 drivers/soc/sophgo/sg2044-topsys.c
 create mode 100644 include/dt-bindings/clock/sophgo,sg2044-clk.h
 create mode 100644 include/dt-bindings/clock/sophgo,sg2044-pll.h

--
2.49.0


