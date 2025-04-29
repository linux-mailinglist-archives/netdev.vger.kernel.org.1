Return-Path: <netdev+bounces-186660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7318DAA03B5
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 08:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5740B3B3564
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 06:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60565275105;
	Tue, 29 Apr 2025 06:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iyT3/HZg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CD6184E
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 06:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745909314; cv=none; b=Z+SEEAptr+lpR/45EabbmUtIGLgw/NG7EfBbWOF1v2iiy82FqyOxED1Y/KbB7xQHoCaiaK+doKrZVGzs3KHkjNV8rzh2rgJymZjf3PSeUzTp/VOvzE817yXLthtWwogbFkNhgDjKtOEVAcW/ixzY7a1MuK8ZaLWz2BFT9p1UlXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745909314; c=relaxed/simple;
	bh=9CyJ9vrui2u8M8iSVZFuwmIfqoRlB9IonBcSStjHu8I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=AOpNgIHZbyDh0qWePWocm1eDuLFpJKj6fWfPDpn5OvoDP2wwqR7P12uC3Ofyvwp8nMRL5gifRkU85WYYaX9pHe9Bhfaw8So7CxxT+Ssd2hInGMZI6eFa1kNi98cZElnN7qg6H/bBqQWhjlaNS4QKgVtFXsitejIZJAJoFwDvpig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iyT3/HZg; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-877d7fa49e0so2011942241.2
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 23:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745909310; x=1746514110; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sXi/SUjRC6MuKQgZypsU6mTKwVzFc0J4r/au1GEfB6U=;
        b=iyT3/HZgpiqmf7DF03di20xDkVBEbYu1C+QZNAiQqhAxDSO1UPEhw+NA4Vxa2dIWy7
         4cbL3hUzveYTlhwcg1p7NcPt1aC2/MPVmnkzmGkron4plEboNAkRtvOSV/WNE9XIMjSt
         xwv9+t2G58DRlPMGB0XPLbeVWgaxNyP9R9Z18PHhcY/7G2uchOLIfpYPA7iWVTNqTY7I
         rU6bP5s/WorU6jmn2JTB7DDtIZQ/HmjH7xBjtOAYsfxXsaqnRCXQLXDI2mcnpnvsx7fH
         QU/oCryrlLo+gsFKibT94x5udjn1HVT9XJXpo1FRPxhCq0C0iQc46eUwbXA/DrOzGpSt
         D3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745909310; x=1746514110;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sXi/SUjRC6MuKQgZypsU6mTKwVzFc0J4r/au1GEfB6U=;
        b=pZToVwG/MSZ1MK2dpZwXan38xQ4Ku+on6/DaXwNFmvauoDdZk1VDnJ1J6rUYzqfYwe
         PAe6hIJwpjlcmTlkpeWFqnn0S2Agitc93M44Mzy8UYIhV8qDsxFgYMK1D77DSvFFRPgi
         taVqfqDrX3hfhdJTwMgaGdLjX28jW5uEyspPUsq60SmfHE4B09C3yIIbYOZEbPjaQG47
         Qw8FiGIm2x7JSbU7oQWX4A39TtA2s5eAlbFGAZG5UPeBYEkiBN7syaSJKj0jXMDGordZ
         F8t7ygKp/RWtJ9QAgfiwlQPRRg6wjrOVYD//9chRap5zcEYT4TwqPQOi6+CtDpAvyQgc
         o/FQ==
X-Gm-Message-State: AOJu0YxDlgU9v5sQIHQK3VdC+WrXSx0xGiGzzzN0rd2ACV61nK35UbzK
	4aeD6/PVLX9nTycmJAs39z2lvPMv8tMwTrp9SvqbQk0WRxmaTjV/BpP9nnsmJB/NoFR83rBg+1t
	rkDZ3PdE2ohu8PEhnrPJOU2ha6UGwU6rqryFJOrsrR7FwXZa3DY4=
X-Gm-Gg: ASbGncu52NXw9BNqewymTurTW8HbWJ5L7IIJyzHZsGBGWU6nEFyTExaF13GUHdLclPi
	pcjskfNNjZZamGNYdD9Z/vP2I3MSk2TrvSRy8mMislLjl2+CklCLhQgKZOVnXqOjg9/6VyRHXq7
	JH7hTjKFkZA1Yr2L0VN+IUbxXUAjpcq4DygdZEAuDGAA53AgTMiefYaW8=
X-Google-Smtp-Source: AGHT+IE/wW4rey32KhYXnxm7YMuvinzWZGvhxBn7qZf2ls6SaJNTx93pWcEcAKsoRl631YWuZ2kxHHUmOj06rOZzMfs=
X-Received: by 2002:a05:6102:3f12:b0:4c1:71b6:6c with SMTP id
 ada2fe7eead31-4da7f52f85cmr1891727137.7.1745909309952; Mon, 28 Apr 2025
 23:48:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 29 Apr 2025 12:18:18 +0530
X-Gm-Features: ATxdqUFl-SyW1AweGtS7b9hyai4LUeaBQ5GoyXRjUVKMKKGjw-9Kv4VCa9Ay_TE
Message-ID: <CA+G9fYs+7-Jut2PM1Z8fXOkBaBuGt0WwTUvU=4cu2O8iQdwUYw@mail.gmail.com>
Subject: next-20250428: drivers/net/ethernet/qlogic/qede/qede_main.c error:
 field name not in record or union initializer
To: Netdev <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Regressions on arm64, s390 and riscv with allyesconfig config build failed
with gcc-13, clang-20 and clang-nightly toolchains on Linux next-20250428.

First seen on the next-20250428
 Good: next-20250424
 Bad:  next-20250428

Build regressions:
* arm64, build
* riscv, build
* s390, build
  - gcc-13-allyesconfig
  - clang-20-allyesconfig
  - clang-nightlty-allyesconfig

Regression Analysis:
 - New regression? Yes
 - Reproducibility? Yes

Build regression: arm64 riscv s390 allyesconfig qedf_main.c field name
not in record or union initializer

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build error:
drivers/scsi/qedf/qedf_main.c:702:9: error: positional initialization
of field in 'struct' declared with 'designated_init' attribute
[-Werror=designated-init]
  702 |         {
      |         ^
drivers/scsi/qedf/qedf_main.c:702:9: note: (near initialization for
'qedf_cb_ops')
drivers/net/ethernet/qlogic/qede/qede_main.c:206:9: error: braces
around scalar initializer [-Werror]
  206 |         {
      |         ^
drivers/net/ethernet/qlogic/qede/qede_main.c:206:9: note: (near
initialization for 'qede_ll_ops.ports_update')
drivers/net/ethernet/qlogic/qede/qede_main.c:208:17: error: field name
not in record or union initializer
  208 |                 .arfs_filter_op = qede_arfs_filter_op,
      |                 ^
drivers/net/ethernet/qlogic/qede/qede_main.c:208:17: note: (near
initialization for 'qede_ll_ops.ports_update')
drivers/net/ethernet/qlogic/qede/qede_main.c:208:35: error:
initialization of 'void (*)(void *, u16,  u16)' {aka 'void (*)(void *,
short unsigned int,  short unsigned int)'} from incompatible pointer
type 'void (*)(void *, void *, u8)' {aka 'void (*)(void *, void *,
unsigned char)'} [-Werror=incompatible-pointer-types]
  208 |                 .arfs_filter_op = qede_arfs_filter_op,
      |                                   ^~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/qlogic/qede/qede_main.c:210:17: note: (near
initialization for 'qede_ll_ops.ports_update')
drivers/net/ethernet/qlogic/qede/qede_main.c:210:32: error: excess
elements in scalar initializer [-Werror]
  210 |                 .link_update = qede_link_update,
      |                                ^~~~~~~~~~~~~~~~

## Source
* Kernel version: next-20250428
* Git tree:  https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git sha: 33035b665157558254b3c21c3f049fd728e72368
* Git describe: next-20250428
* Project details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250428/
* Architectures: arm64 s390 riscv
* Toolchains: gcc-13, clang-20, clang-nightly
* Kconfigs: allyesconfig

## Build
* Build log: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250428/testrun/28249321/suite/build/test/gcc-13-allyesconfig/log
* Build history:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250428/testrun/28249321/suite/build/test/gcc-13-allyesconfig/history/
* Build details:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250428/testrun/28249321/suite/build/test/gcc-13-allyesconfig/details/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2wMJhRaVybixSxTSIyLTw8JqNxe/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2wMJhRaVybixSxTSIyLTw8JqNxe/config

## Steps to reproduce on arm64
 # tuxmake --runtime podman --target-arch arm64 --toolchain gcc-13
--kconfig allyesconfig

--
Linaro LKFT
https://lkft.linaro.org

