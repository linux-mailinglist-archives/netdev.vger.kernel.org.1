Return-Path: <netdev+bounces-227948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE318BBDDE5
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 13:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D677C18843A1
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 11:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B7F221FA8;
	Mon,  6 Oct 2025 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sICFFsxk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABC41805E
	for <netdev@vger.kernel.org>; Mon,  6 Oct 2025 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759750215; cv=none; b=XgkIjGxCebdsUAaP4N6iDZgDl5Az4itaH6SASSrY/FQt0V06rDZF6bjSOcCdXpm77XyGnxXaISUoK4x5OKVivfANO/tTddX4WfB0wt+kB4mtWLc10NlkyZv0izfINX1xuOTNJPxWzJ8At+my3nlMg+OWdO2kDaQo9NSM0Hx4/Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759750215; c=relaxed/simple;
	bh=osn5ew/lMxGyS0lnJ4uClg6NxZuq+qP+tS/nSidtHrw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=rytcxEC7pfRRehyjX71xSFziKAI2hHcjAF+Mt+2TkTQPncH/9G11ZiNDHJOCzXHkpciwcbVz19XvEyqLFTfnKMw6MLBfGN8vt3pQnaZ++rYvZz7T/htT0UY1/m7tWJhOj8ou6zfKIm0W+ueNv4o+sNpjWwkgtU1jkLwjBN0dAS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sICFFsxk; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-789fb76b466so4140962b3a.0
        for <netdev@vger.kernel.org>; Mon, 06 Oct 2025 04:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759750213; x=1760355013; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A1b4UieRxnHeJDLUzPk+Z3+ZvYx2PdGFKhNe67w07jY=;
        b=sICFFsxkdT+akEKw6iK/BVkjDyLG4VjCLi+FLFKz34htnKbZ+3xaJAgbKPuocf7mst
         ckVI4bTdGP8Uf9yF0StbFOsuHwu9VUuCabSMuGUzFCPIFzDOcK9aYWsATE5keWI2vC0x
         PXbGdjWL4U8Sn7ZC+gf/CmTUHZQRoSO0jII3cncmwl8TzKuY7MGqP38xnRiTj187sxlW
         vtm+cJr8j65AVVBfc55lYWVwavvpy6Pa/SHs1GyweOJe0aeehp+LJVBFuoXMf/UhouqG
         1UL0RJIYRYuiHSNAF+78/SRmChRmuYyu+ovzxeo6NcrQK9YLC8C5k80qJxnrXUxHMsVv
         y0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759750213; x=1760355013;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A1b4UieRxnHeJDLUzPk+Z3+ZvYx2PdGFKhNe67w07jY=;
        b=iIfbw3My2ypifxS9K+V/eOvOtKDQNEF23AX11p3rIlmMSt9lJtMLk0u52MtVyYjEMa
         E8KA3YttKnLPTtixaTNBzwJyUN5qdycR/Tvb383Eos/rXx9WEFfQlCib3h2loq8BvD9k
         ZtQ/uJxj/VB54dj9xtPrjpMzhkrByBuO4bsKbEnFXo1Wong6TXHpixF2bkE7SXZas9hk
         wVKa471MzjRuOzq7UnHbRLcjbVRx/6NyQ20TNUkqoEqU4OgLU6EPrj0Q0tlLnNAaDi1a
         sWio40ClouqtQkiYZy29LXdtR58XJh5lzE2OalKkjqLSUY2u1usibFluEsE7iQpoiFey
         2JSw==
X-Forwarded-Encrypted: i=1; AJvYcCW5ZCqyXxPO2O0eepewquJqYfTtL6/l7NAMRQMbNmvfBEP51S+dQJSYD1HeKWaDhVE37cF0JXw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8PVEw6WvEPDiBu6SuDGBU4rIhpWrzVmrGWI4POL7/KCSBZa0q
	VfRFHD8NGKMNEUQp7PJZC6AV/7UWR0oIM5vmDDkV09bqZSfpDYG8JuMfRAk3hkD6JUJVertQAOU
	BfIomS9nFZrxtBHxxYOD0yJ3J9HHB0gH5X5wZabMD6w==
X-Gm-Gg: ASbGncuS/5GAY0au1doew7fTeHji17S7ojW9rwWD4CDuCRdtizZinQ/WyStsj9w+LOh
	IImSjvBxRTOkvi+YntefDPxwIUi0SESC7gH/aIpjYihhFMT/SJnQ8/t0J9Ak9Br6sVi+p/7YhSg
	B4zLyN9DSPjl70gBci0nK2DLbRrozzJt5vY4uhLiuoS0rMwugiviYuJoXLhdX1Va3MK8zqQM7GY
	4Wz+5JoeNCzkumAVW4nN8l4n2ZgWOpPR3uVA4jSoBsOAl+LXrW7Lwa5pSA1p33KeF+Lb2D27g3Z
	vZ5EGfLVB7DgLKWmkDM7qcc=
X-Google-Smtp-Source: AGHT+IE7/BR9FHufOHH3BLOQUgqTtS1rfbVXN5odMkAwRA+sZP80yDXLfwd06HD6VkaXe09XBa5fi7EiEGqxb/9Ze6U=
X-Received: by 2002:a17:903:178e:b0:274:6d95:99d2 with SMTP id
 d9443c01a7336-28e9a6a90e8mr136255395ad.39.1759750213517; Mon, 06 Oct 2025
 04:30:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 6 Oct 2025 17:00:02 +0530
X-Gm-Features: AS18NWAcN9W702ErPzrjZGWWRgZjF5wGQGJwFYbwG9GAp2PHp_NMPerrOOnYfiE
Message-ID: <CA+G9fYu-5gS0Z6+18qp1xdrYRtHXG_FeTV0hYEbhavuGe_jGQg@mail.gmail.com>
Subject: next-20251002: arm64: gcc-8-defconfig: Assembler messages: Error:
 unknown architectural extension `simd;'
To: inux-rdma@vger.kernel.org, Netdev <netdev@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Patrisious Haddad <phaddad@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>, 
	Moshe Shemesh <moshe@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

[Resending with typo correction in the subject next tag]

The arm64 defconfig builds failed on the Linux next-20251002 tag build due
to following build warnings / errors with gcc-8 toolchain.

* arm64, build
  - gcc-8-defconfig

First seen on next-20251002
Good: next-20250929
Bad: next-20251002..next-20251003

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Build regression: next-20251002: arm64: gcc-8-defconfig: Assembler
messages: Error: unknown architectural extension `simd;'

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

### Build error log
/tmp/cclfMnj9.s: Assembler messages:
/tmp/cclfMnj9.s:656: Error: unknown architectural extension `simd;'
make[8]: *** [scripts/Makefile.build:287:
drivers/net/ethernet/mellanox/mlx5/core/wc.o] Error 1

Suspecting commit,
$ git blame -L 269 drivers/net/ethernet/mellanox/mlx5/core/wc.c
fd8c8216648cd8 (Patrisious Haddad 2025-09-29 00:08:08 +0300 269)
         (".arch_extension simd;\n\t"
fd8c8216648cd net/mlx5: Improve write-combining test reliability for
ARM64 Grace CPUs

## Source
* Kernel version: 6.17.0
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git commit: 47a8d4b89844f5974f634b4189a39d5ccbacd81c
* Architectures: arm64
* Toolchains: gcc-8
* Kconfigs: defconfig

## Build
* Build log: https://storage.tuxsuite.com/public/linaro/lkft/builds/33YUHcFKTLSBTOxNIJqF9vJqcxt/build.log
* Build details:
https://regressions.linaro.org/lkft/linux-next-master/next-20251003/build/gcc-8-defconfig/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/33YUHcFKTLSBTOxNIJqF9vJqcxt
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/33YUHcFKTLSBTOxNIJqF9vJqcxt/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/33YUHcFKTLSBTOxNIJqF9vJqcxt/config

## Steps to reproduce
  - tuxmake --runtime podman --target-arch arm64 --toolchain gcc-8
--kconfig defconfig



--
Linaro LKFT

