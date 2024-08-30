Return-Path: <netdev+bounces-123598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6469657C6
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 08:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4A7C284A7F
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 06:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD0414E2DE;
	Fri, 30 Aug 2024 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="onULnD5D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD88B14B086
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 06:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725000324; cv=none; b=u8UBGF/eCXUZ+GLTP1Z4d08KNXXiv8Xdk0SCnT4hd0S+s9NY0NZIf9jipJ+OKiHaUppx1/sUcKFZctyfDfzJItaA4TQPvj0T2gVI/cHMRnsy30sTNtTvmFPyQ0cJZO+PG1WFv6mAlTwgaxEygEN9aBgmK29ujGrQGW74jsgQXO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725000324; c=relaxed/simple;
	bh=z2tMGYCX6QIF8USqnak/joMuhfj1TNUKUkBSSXPLdCM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hhu3obWsCgQV88E1ZmiqEjyinDgI8mEkS7UZd227OOvXKjSDTwsj0TQPeUg4Bh89qJETPixbmzJ895AuxfKqx8KQ4bAqELW75bX0/IoGXlkRhb0n9GTefaLS95GxUlM8C7pSdo/F5OZTP5ARvyayzLOv5vgfeGXeKmImJKPRNW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=onULnD5D; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-498eb76145bso679701137.1
        for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 23:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725000322; x=1725605122; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rbpFfZAAGy+MvWzUwDXlPYpxkRy+IDxVTjCRFwW+Hxg=;
        b=onULnD5DYFXABHGCMnKSyHk14Xi4dryTbgdudbvQ7KFyHG49TPBLHFRPo00GcwxnR7
         1TzXAGo18BXREU+eLc2xl5Mc/pfyoBqiN6WgJtPP8AeAj6lRnFE+f2WlO93O9Aa9lFNI
         vZM8ATraLidDJOp4A9xBr5OioJsiYoJJyp143jbmT3i0moeD6U/DviT7wTIWYy6lWK9X
         nwjPyhwZkeTsAHkWLXIQemKG8JeEpxTPb5XenkB/p+ae0YzR3fsJmzeH/ZflaQPbdzAD
         9++ozQdjOPv4qi44Tu7RmA9NBQsfDEqM0yhnTcHGC9Hpnx2/KpA+PiicU8D3K+lmMOrd
         qs/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725000322; x=1725605122;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rbpFfZAAGy+MvWzUwDXlPYpxkRy+IDxVTjCRFwW+Hxg=;
        b=pN9WVten/i/sH/w9c07hpmv4rsrARGy6IV+yLSR6nu1cm/96gMuP05VP3V9Ncdd+1r
         XN7DvU6ZfqDcLlFaIUkv2NVgSK9m8MrRaakWtgmmZjT4udopHpqzVnG/99Qjzw43KS+I
         El89jb16kmeMq/76gBQfXzsK1BE71rqImzXv1Aw2I+B+scod7GgAXIGmXilhIrpgwaAE
         aJJZelXqgg9Aka9f4Fme4Mr52SU36CxxFcFMuHBEr9aCrgycv0dk8F79ghW7/DHB4wpg
         JZ0CMFU0SsxV4Spvy5DyQVqaROss0rZcl5fW8MtxFjiGkQlGkRGmC3xtTYVVOFrAeoe3
         1QFw==
X-Forwarded-Encrypted: i=1; AJvYcCXCs78ftewDZgGboz87V2lVtQM08jeX/3FO8vfiA4Ra+E4goBry93NFEmXEEQiANe5Hh7IF5VM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjKJYn8et2ZIl2Z1xs7k7LyromRQPRaW18vYKE7qMlWogT9Fns
	1SheNvUxx5D5QklSlRWRUp4RczWxP7erER6T2V5/9YAh2NsMEND/Es3EHhlO+GibOYIDvHL9JLp
	w+5QgXL6sL90V2YaDEuu0kMx2LGaj2NP4OuEeKw==
X-Google-Smtp-Source: AGHT+IGjtT+iRsWBRGw877rPBsoWnB7aehlawvTFpCsFP81H03YlByPMlEYvHuWNIHaoPnc0CqKmfajXR5onhPoZMMU=
X-Received: by 2002:a05:6102:3754:b0:498:ccd9:5b1e with SMTP id
 ada2fe7eead31-49a5b017424mr6994044137.4.1725000321654; Thu, 29 Aug 2024
 23:45:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 30 Aug 2024 12:15:10 +0530
Message-ID: <CA+G9fYtemFfuhc7=eNyP3TezM9Euc8sFtHe4GDR4Z9XdHzXSJA@mail.gmail.com>
Subject: net/xfrm/xfrm_policy.c:1286:8: error: variable 'dir' is uninitialized
 when used here [-Werror,-Wuninitialized]
To: clang-built-linux <llvm@lists.linux.dev>, Netdev <netdev@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"

The x86_64 defconfig builds failed on today's Linux next-20240829
due to following build warnings / errors.

Regressions:
* i386, build
  - clang-18-defconfig
  - clang-nightly-defconfig

* x86_64, build
  - clang-18-lkftconfig
  - clang-18-lkftconfig-compat
  - clang-18-lkftconfig-kcsan
  - clang-18-lkftconfig-no-kselftest-frag
  - clang-18-x86_64_defconfig
  - clang-nightly-lkftconfig
  - clang-nightly-lkftconfig-kselftest
  - clang-nightly-x86_64_defconfig
  - rustclang-nightly-lkftconfig-kselftest

first seen on next-20240829.
  Good: next-20240828
  BAD:  next-20240829

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

build log:
--------
net/xfrm/xfrm_policy.c:1286:8: error: variable 'dir' is uninitialized
when used here [-Werror,-Wuninitialized]
 1286 |                 if ((dir & XFRM_POLICY_MASK) == XFRM_POLICY_OUT) {
      |                      ^~~
net/xfrm/xfrm_policy.c:1257:9: note: initialize the variable 'dir' to
silence this warning
 1257 |         int dir;
      |                ^
      |                 = 0
1 error generated.

Build Log links,
--------
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240829/testrun/24977652/suite/build/test/clang-18-lkftconfig/log

Build failed comparison:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240829/testrun/24977652/suite/build/test/clang-18-lkftconfig/history/

metadata:
----
  git describe: next-20240829
  git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
  git sha: b18bbfc14a38b5234e09c2adcf713e38063a7e6e
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2lKF49FRX1FB3IVv46cfZc30s9y/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2lKF49FRX1FB3IVv46cfZc30s9y/
  toolchain: clang-18 and clang-nightly
  config: defconfig

Steps to reproduce:
---------
 - tuxmake --runtime podman --target-arch x86_64 --toolchain clang-18
--kconfig defconfig LLVM=1 LLVM_IAS=1

--
Linaro LKFT
https://lkft.linaro.org

