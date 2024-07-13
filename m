Return-Path: <netdev+bounces-111289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3E19307BA
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 00:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05260282446
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 22:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E597146A6F;
	Sat, 13 Jul 2024 22:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="2ITqWotF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C8A6EB5C
	for <netdev@vger.kernel.org>; Sat, 13 Jul 2024 22:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720910123; cv=none; b=P3oAjw5DjcuhW+13mmRKMRE0yDGZFS5xkdqd3Vsh+iK+ZSt84+naSmPXQ6+FwtOJv64VDQHBHzkG5HiASuE5y7iYU/bVZIIqaz/8GhK8wVN7i2WQc9Moo1tIZkEv2Ykk1tItL4A2rSyvoO7Yy7LHZ0B3s15FqImXvkVGgYXN6Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720910123; c=relaxed/simple;
	bh=w/NbNx0hQrYCCt4fhGgjxPcsuaVQDgpxDwOcni8EUgY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=l9qvwynZuv2Jvvd5LQUTy7RfI037Gt/VIBHRFMuTalRBuIfmazTJKhW+Jh5puCsQBVHLqpQAHV212ZWJapAUzV+7uZnxA1nFy9wzILxxMtPgFjHaOlxI8YfF3a/BxMzwD1yBRLb/wx2W2OCZrFfPTrkra1p5XMcrgI7RDGiG+6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=2ITqWotF; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d9306100b5so2093911b6e.1
        for <netdev@vger.kernel.org>; Sat, 13 Jul 2024 15:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1720910121; x=1721514921; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=59P5oqU7NcCQSekZycQB8SHFulzZjU5cylTceccordQ=;
        b=2ITqWotFU+ZzxMUbo8IkFkrHewbH0jpZukP2QRtYK9xqqVdTuTJhfN5EnOJE92xtwr
         6TsQuksldBbxPAtaJHQfvTLWRejGxmrB9ubOjHUG+oRTTNaS/hZdUOz9oMEBx2GlZ2z0
         l1b93BNvq0ui96zXZUWdy3xZMATuGJGCpjeReMQE13Q3lJ7uIyJnPm32Fy+nV6E79/Bq
         X2u4ZRGwvqfjc9k+Og/+nPkaFtzkf+GKeJZs7/XHChtc6+qYFlqvbP1UAkQ4//XtPElS
         YLeWsoIdaBSGolBVIM8HuTiCEISXPBjlvYrbJMYmLrXeNyoA/EXXY68BOeUVOTkM0gHU
         +NBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720910121; x=1721514921;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=59P5oqU7NcCQSekZycQB8SHFulzZjU5cylTceccordQ=;
        b=Cj2FJYw2/oorajijIFamIam/B7BIg6w8I9Pt33MEPk3XMrwzU89FCz1RcblR7sIvZn
         1xomXRG1uHsK/aPN1crpcFc3o27C7W9pqnk/lZfAi9meP5ROwhdJdEe0wFpc40vcQIOV
         rHjI6x1E+2yiCdK+Lrms/EcA7eTL7x8oPo/Ly6LxzC8Rj6uvrFLJJaSKtnSh/HYq8Jky
         sUecdyIuAvVmkLgqQxCABQWVzSQBV2SNrryrM1rKo9ry91+Sxct4AB/3sx7jBypDares
         hpt8MEakbarX7lm0cWrT0WlGr/QsAOMtQiqnOT9wGbXKpGTxzf/ThqmdbkfywCxyqQQG
         /f4w==
X-Gm-Message-State: AOJu0YwfBhohUw2jTYcd6OqlbYh9KNGEIIDdMtF9kaBHErvkgmCZ98tE
	5laPyF6Di43lz1islEHN+a1WoLszzigaDK7CTgksn993FJzjwP3stI6TWMAcU/c=
X-Google-Smtp-Source: AGHT+IEg9antJl5Um5shbWWC4aJSAEXG1X4QgFtAyLnt8rqbE/pGgSXXmoU49K8Rk27lGnV7pllKRA==
X-Received: by 2002:a05:6808:19a8:b0:3d6:317b:a95c with SMTP id 5614622812f47-3d93c07512amr17596782b6e.38.1720910120935;
        Sat, 13 Jul 2024 15:35:20 -0700 (PDT)
Received: from [127.0.1.1] ([2601:1c2:1802:170:d7fc:57d0:ada6:13b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc4d9d8sm14640025ad.264.2024.07.13.15.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 15:35:20 -0700 (PDT)
From: Drew Fustini <drew@pdp7.com>
Subject: [PATCH RFC net-next 0/4] Add the dwmac driver support for T-HEAD
 TH1520 SoC.
Date: Sat, 13 Jul 2024 15:35:09 -0700
Message-Id: <20240713-thead-dwmac-v1-0-81f04480cd31@tenstorrent.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB4Bk2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDc0Mj3ZKM1MQU3ZTy3MRkXcMUE5NkE3OjpKQUUyWgjoKi1LTMCrBp0Up
 Bbs4gsbzUEt281IoSpdjaWgC5/rGAbgAAAA==
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, Jisheng Zhang <jszhang@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Emil Renner Berthing <emil.renner.berthing@canonical.com>, 
 Drew Fustini <drew@pdp7.com>, Guo Ren <guoren@kernel.org>, 
 Fu Wei <wefu@redhat.com>, Conor Dooley <conor@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720910119; l=2542;
 i=dfustini@tenstorrent.com; s=20230430; h=from:subject:message-id;
 bh=w/NbNx0hQrYCCt4fhGgjxPcsuaVQDgpxDwOcni8EUgY=;
 b=zhSGOkCGTA785OB0MaNJWsmX/0kLmkWTEMMzX8DoIdS3pa54QR5Rc1GW96RessAlJhjWKCsbm
 OZwPPbSVHNBARLIGPxYzRew0qKbsZpMAUxb9mzEk1yLH2//jZDwblTr
X-Developer-Key: i=dfustini@tenstorrent.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=

I am marking this as an RFC since it has been almost a year since the
previous series and Jisheng has handed it off to me. There was
discussion about the syscon for the APB registers in Jisheng's v2. I've
gone a different route and switched to adding a second memory region to
the gmac node:

  dwmac: DesignWare GMAC IP core registers
    apb: GMAC APB registers

This patch depends my clock controller series:

 [PATCH v3 0/7] clk: thead: Add support for TH1520 AP_SUBSYS clock controller
 https://lore.kernel.org/linux-riscv/20240711-th1520-clk-v3-0-6ff17bb318fb@tenstorrent.com/

and the pinctrl series from Emil:

 [PATCH v2 0/8] Add T-Head TH1520 SoC pin control
 https://lore.kernel.org/linux-riscv/20240103132852.298964-1-emil.renner.berthing@canonical.com

I have a branch with this series and the dependencies on top of 6.10-rc7:
 https://github.com/pdp7/linux/tree/b4/thead-dwmac

Changes since Jisheng v2:
 - remove thead,gmacapb that references syscon for APB registers
 - add a second memory region to gmac nodes for the APB registers
 - Link: https://lore.kernel.org/all/20230827091710.1483-1-jszhang@kernel.org/

Changes since Jisheng v1:
 - rebase on the lastest net-next
 - collect Reviewed-by tag
 - address Krzysztof's comment of the dt binding
 - fix "div is not initialised" issue pointed out by Simon
 - Link: https://lore.kernel.org/all/20230820120213.2054-1-jszhang@kernel.org/

---
Emil Renner Berthing (1):
      riscv: dts: thead: Add TH1520 ethernet nodes

Jisheng Zhang (3):
      dt-bindings: net: snps,dwmac: allow dwmac-3.70a to set pbl properties
      dt-bindings: net: add T-HEAD dwmac support
      net: stmmac: add glue layer for T-HEAD TH1520 SoC

 .../devicetree/bindings/net/snps,dwmac.yaml        |   2 +
 .../devicetree/bindings/net/thead,dwmac.yaml       |  81 ++++++
 MAINTAINERS                                        |   2 +
 arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts |  89 ++++++
 .../boot/dts/thead/th1520-lichee-module-4a.dtsi    | 131 +++++++++
 arch/riscv/boot/dts/thead/th1520.dtsi              |  55 +++-
 drivers/net/ethernet/stmicro/stmmac/Kconfig        |  11 +
 drivers/net/ethernet/stmicro/stmmac/Makefile       |   1 +
 drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c  | 300 +++++++++++++++++++++
 9 files changed, 670 insertions(+), 2 deletions(-)
---
base-commit: 568c4e4b646777f3373f383cc38864a3cd91bbb7
change-id: 20240712-thead-dwmac-1d44c472bbd5

Best regards,
-- 
Drew Fustini <dfustini@tenstorrent.com>


