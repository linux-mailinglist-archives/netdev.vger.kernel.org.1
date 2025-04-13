Return-Path: <netdev+bounces-181992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AD0A8747F
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 00:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CE68188FD71
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 22:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC3618CC10;
	Sun, 13 Apr 2025 22:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqpS2TL1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873DF2367B7;
	Sun, 13 Apr 2025 22:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744584336; cv=none; b=LcAVEB9+6F7uGtaOd/l3ltiqU0Nj34a4kdc2NvyhLf83ldvxSKfBEvBxOO3VeufERkQA6yquBokOPTRErQ0vHXymSJoEqKknhQeGmjpS2silDKjIhV1nVY2LgkzoqeZDG+ZhhyKAOhVpy40aDG9TRx12UDyd+agtitq2wBj9Zz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744584336; c=relaxed/simple;
	bh=SdLZZ1h9MOoJBEvmI+iW761zRJgaR89JWkPra8d1nsA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=thbjE1zV3nU1U/5qdpDlncdto8vRzFsJV0B1tyNQyiBQ49u/RUWmOTkEV4ONygCYYvxHa6ZX2ku/ZWkWdECMXCQqg1FiMX1VKe36NTVFU0WEH8yEWZp2BlK494X8DA04sNhRT6q1fvqxRpoJ+95qPs5v1GlzH30F7GhXkheOLSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WqpS2TL1; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c5b8d13f73so401123485a.0;
        Sun, 13 Apr 2025 15:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744584333; x=1745189133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1yEG8Rwh4CvxK6iCp6DxsJEufqiqUGIzvjMR5YWVKIw=;
        b=WqpS2TL1panoWIiYxp+svNW1RjgrPW8AgIBWFLRK3z7HtuygrEiBvdWup/0rac5X63
         O7n7WbLe2Q2OQGLfdeqQcgZue8eHIBZICpTPnJTwOmf58PICBoSsiFC5FM0hdA/mgx9w
         kEoOj+3jwBuhae9TaxwPdCGFnpWGmFEGMMbhuMR6NzgqhnplGFQ8LHNUKCWeUq1ujzjJ
         xMmY2XtufKQK9YOoUkB4kT/HCcHfJtlw0GGGFtiTiYuI42miwzNuaHaZzw++0PtsogRX
         S/el2vXNfb6umaQBXhkQbC66dSPmP/QAMpT91mmKUI9iUSR5DOHmGtu3mql47A1tJitE
         XxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744584333; x=1745189133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1yEG8Rwh4CvxK6iCp6DxsJEufqiqUGIzvjMR5YWVKIw=;
        b=njHxC9RgW5hs1qw7Sh/m9+LIkFzJoaZET4aSMzczUWLyqTpIcwvHDhUv+qmdbqpWRZ
         fYE+xoiwMM3UQdSWfYW6YGMFbITm/6HXDmm4fvupI25ol3iwDshNRiSauGGje3WIo2pV
         cYDbqr1j83LDSw6q1v0TkpsE29dxxF2Kef/TAGjDsaQRaxy2EfS5tkHxqX1I1mqlaqcY
         F4Rk7IJnsSJIaXUPM2z7VtDnoV5CorbLTiYiHF/gzePkIu5b4tvJs9Vlpin7+yvl01Ph
         x+Ldc2Rpma1qzMVzBzmZIqoePax2K0gT6MS7SxLjCnEClOaXLR+7y4l2/k7NbvklwN03
         Oj3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6Np69rccFmXjZw566XzVOdsNi2+kHDxi6W6L4iTLOpUsU3KZxHkPvPGN5bqfD7w1x7onEsP+ZPZ+D@vger.kernel.org, AJvYcCVDatB4YG3NRtKRewXI/Rqz5hf/+wk7vKtTyw/Z+eZemxt2R8cwLxRKOZyYb1zalwCI9m189q3D@vger.kernel.org, AJvYcCXeMg3N/JVgZoc5luX59/TC4AEVRIIQGROYjbzAcggGwQi5pRvVUeNyYdfDQfmOJLe2iGaKpuc28KioA9j6@vger.kernel.org
X-Gm-Message-State: AOJu0YyBDRYsgIWkapioFHa6Jix9vMiDhSe1RzpuXCHOIFc2I43c7HmP
	l1XRtdJIr+Ej8UyOw8poQRbtGmbE8Z+kBI8QdZpeQZ2PJmG5jghU
X-Gm-Gg: ASbGncuIIaPJoxiw8+yK0o2MO45Bi7EI0Xpg0qL1kAey5NKiJTkqQzZ6jdKbL6SaiYZ
	OeqNQdzbOAXWlsuVESYpzNMh+YJKLUvPpRnxeB+JXDSwLBDkDgjfgMHH1T7e6RdqJFKzPGfdbS8
	Iw4dNz98mlk0YX7B7r0GIuo0hBNVFlh2zqaqr1hEKrbzZGNaRbo9EV+nryHoBKqECwSEoboiA4i
	AhQJ9BObrFE9hdkgq7GS1Wyu0mmcS3/w4hbyqNdLZOm7uqzNYk5XxUge7FXeyhpPz1D++IGlsvu
	puCehPOB0BrI9/9E
X-Google-Smtp-Source: AGHT+IFfZqLMdcGt4A1VgkvuhAuM9F2UXKgD0vPQ/x3qJW4kCkL5FkA1cOoFIYdzUiOewxsp1srBgQ==
X-Received: by 2002:a05:620a:4141:b0:7c5:b0b4:2cea with SMTP id af79cd13be357-7c7af1137f6mr1512437485a.38.1744584333493;
        Sun, 13 Apr 2025 15:45:33 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4796eb15c24sm62806241cf.21.2025.04.13.15.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 15:45:33 -0700 (PDT)
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
Subject: [PATCH v4 0/5] clk: sophgo: add SG2044 clock controller support
Date: Mon, 14 Apr 2025 06:44:44 +0800
Message-ID: <20250413224450.67244-1-inochiama@gmail.com>
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

Changed from v3:
- https://lore.kernel.org/all/20250226232320.93791-1-inochiama@gmail.com
1. patch 1,2: Add top syscon binding and aux driver.
2. patch 4: Separate the syscon pll driver to a standalone one.
3. patch 4: use abs_diff to compare pll clock.
4. patch 4: remove unnecessary else
5. patch 5: use clk_hw for parent clocks if possible.
6. patch 5: inline the header which is necessary.
7. patch 5: make common array as const.

Changed from v2:
- https://lore.kernel.org/all/20250204084439.1602440-1-inochiama@gmail.com/
1. Applied Chen Wang's tag
2. patch 2: fix author mail infomation

Changed from v1:
- https://lore.kernel.org/all/20241209082132.752775-1-inochiama@gmail.com/
1. patch 1: Applied Krzysztof's tag
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
 drivers/clk/sophgo/clk-sg2044-pll.c           |  629 ++++++
 drivers/clk/sophgo/clk-sg2044.c               | 1812 +++++++++++++++++
 drivers/soc/Kconfig                           |    1 +
 drivers/soc/Makefile                          |    1 +
 drivers/soc/sophgo/Kconfig                    |   21 +
 drivers/soc/sophgo/Makefile                   |    3 +
 drivers/soc/sophgo/sg2044-topsys.c            |   45 +
 include/dt-bindings/clock/sophgo,sg2044-clk.h |  153 ++
 include/dt-bindings/clock/sophgo,sg2044-pll.h |   27 +
 13 files changed, 2861 insertions(+)
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


