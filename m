Return-Path: <netdev+bounces-185574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6272EA9AF03
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E7A5A3C5F
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 13:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7AA12CDA5;
	Thu, 24 Apr 2025 13:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S58U8n4J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCE52745E
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501488; cv=none; b=nf8JPrCf5Z++R6wzw/Y4CEMn/cEdsihr+hceE9tFfgfDl1Q+l9+UHDa3+lEVqF1H7y5+jQg3Vb3uBdVNmV7wI1B24df+LzNgCgZkFP5ZX96hhrC/G0kg8YH1JgK/0rVm5JEXgLDeG1SVWtL2gq+Nsgk6wkokh3ONHAy9SQxfs8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501488; c=relaxed/simple;
	bh=RZT+Bm4muaLofaD2erPNMsSdkXdWvtmeIvrNvvHsOeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lyKQ3J6IelbWbP5Xjqu3qUrreaGPdR6Kg3nyrCg4+tQr8++NrG+JbjRFhWdc+hOEN6/1jfR29JWFLnJLylyxUylHH7BdqRmPLYaa7+kmCORAgfXqiUSf3OnFYhTI5HC3+lG0q3bPwpkKM4u0PWA/uyFryr7cob0VV6/AnKgjr7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S58U8n4J; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-73c17c770a7so1287876b3a.2
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 06:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745501485; x=1746106285; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DJ7+5ltYRZmmCdAqp83XBsh7nNRI3/U1EM/A5Q+9eyo=;
        b=S58U8n4JI9htz8EgfYPAgjn6FrebuM+dYwKupyWHB1zThCYegh5a15NbQoDjJRrkps
         0i8/qZHi44ktPRgyFooGtm4DUD8RLkr92X/yo9lgSCmehpYhra1vReekDC8FsOuCeRUi
         0/znn+6fPNU9ge5od7OKxxVyfMjxel9tUbrdPZf3nIrMyfs3263bLLJwTRZwK4i5LrHn
         rb4LO5CMIXiSi3CKgDxKcVGbGvdplP+qx8FVeOdWvHmZ3K938dXwfzXDjfATSV3ytM0r
         srQUlPtPlzYQfcjwmGiSX7biMxbYdsyrsMyAHj0r3U+LF7rjwxGrUvRGklu+O0PxwBg9
         sh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745501485; x=1746106285;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DJ7+5ltYRZmmCdAqp83XBsh7nNRI3/U1EM/A5Q+9eyo=;
        b=EL4yAOtgF3eOy0hlqRjCAVoCFa0XwiKRPqqfCyLmc2ITNQbvNetAZEk3DIv/EPC17k
         DfT4Y4cST5C/RDzf1p9Eox4db4O7+Zsvsg+vP6De15r91E9TRXcBjar1u6Kth2UzkiL0
         3h3mvn4eHt07PT9Ktxj9yl2XgbK8n5j+XfRENrMPRVbcYeoRFjJSC6uSK8qTOJBdExrT
         FkxFWQj6Ku4HUYEvgkCuyOiCs18tqnUaNwOr2B7dvc+fEeiq6pWBQfRpL07BfJqiDrJw
         EHDvlRmntYCa4SUYXquB8J5oXZkO1BMZJa3tE/2xebBRf/b4GcVIYnxDur5zBiB9pLj6
         0+zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMzx3/5FcutTuXTgyOtovcwFXu7ue6CCUohNablUPX7xZavq1OLtxf1mPpSAXMFR/04KtQWWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNwfzXyqlvRKM0FWsaxBOlfB9tXyxetM68kt8fNWixP+chsasQ
	pXO5FGzJal/3RXU+Hk9SKJWN9nwFWRg08fFgZdtn5BYUN3+PzOh5J7geivOAobPKc8RVk2CrnMM
	+yQB6IiPjxoqpw7NIm0MKGdDui0/+9mehq/eKwLfGgWe/xffXxRk=
X-Gm-Gg: ASbGncsVzR9ekHfJZiqy8zFFHIzW3+XOoCqKO/15m4RvLZJYSQtUmHdQUcam5linmOO
	eymezktklUTcreHtVe2eiHDjUxyInEeiZM6URxDqUTiPlRqjR5a6dB/JpBWUoCzpnIjCN+kC9yO
	6mrX+886dbj6yz7fva8rJOZJ07eH/N3zkVRU5bi/bfIq3EFbNxdCP2b8ok
X-Google-Smtp-Source: AGHT+IGPQAdvPv130CtyW74bF5GLt9h9J0gOC9yqMjfZwUkVCJiQZ5jIuqZ653x0CDkSH9qNJMbaN+6YH6fuzBDQJEI=
X-Received: by 2002:a05:6122:c92:b0:529:1a6a:cc35 with SMTP id
 71dfb90a1353d-52a78396531mr1948197e0c.6.1745501474452; Thu, 24 Apr 2025
 06:31:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423142624.409452181@linuxfoundation.org>
In-Reply-To: <20250423142624.409452181@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 24 Apr 2025 19:01:02 +0530
X-Gm-Features: ATxdqUE3Swvm29VSdLjDBXXrmS_5N47lC-b7TJpDPawZ14stkRhW3kDUI9cl4yk
Message-ID: <CA+G9fYu+FEZ-3ye30Hk2sk1+LFsw7iO5AHueUa9H1Ub=JO-k2g@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/291] 6.1.135-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Netdev <netdev@vger.kernel.org>, 
	clang-built-linux <llvm@lists.linux.dev>, Anders Roxell <anders.roxell@linaro.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Nathan Chancellor <nathan@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Apr 2025 at 20:16, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.135 release.
> There are 291 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 25 Apr 2025 14:25:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.135-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regressions on arm, riscv and x86_64 with following kernel configs with
clang-20 and clang-nightly toolchains on stable-rc 6.1.135-rc1.

Build regressions:
* arm, build
  - clang-20-allmodconfig

* i386, build
  - clang-nightly-lkftconfig-kselftest

* riscv, build
  - clang-20-allmodconfig

* x86_64, build
  - clang-20-allmodconfig
  - clang-nightly-lkftconfig-kselftest

Regression Analysis:
 - New regression? Yes
 - Reproducibility? Yes

Build regression: arm allmodconfig variable 'is_redirect' is used
uninitialized whenever 'if' condition is true

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build error:
net/sched/act_mirred.c:265:6: error: variable 'is_redirect' is used
uninitialized whenever 'if' condition is true
[-Werror,-Wsometimes-uninitialized]
  265 |         if (unlikely(!(dev->flags & IFF_UP)) ||
!netif_carrier_ok(dev)) {
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

## Source
* Kernel version: 6.1.135-rc1
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git sha: b8b5da130779a27bf7d189bd3b40ebf59ee0e0e9
* Git describe: v6.1.134-292-gb8b5da130779
* Project details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.134-292-gb8b5da130779
* Architectures: arm riscv x86_64
* Toolchains: clang-20, clang-nightly
* Kconfigs: allmodconfig

## Build
* Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.134-292-gb8b5da130779/testrun/28211709/suite/build/test/clang-20-allmodconfig/log
* Build history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.134-292-gb8b5da130779/testrun/28211709/suite/build/test/clang-20-allmodconfig/history/
* Build details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.134-292-gb8b5da130779/testrun/28211709/suite/build/test/clang-20-allmodconfig/details/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2w8QtyR8377WMNLrbtsmGi2lkaI/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2w8QtyR8377WMNLrbtsmGi2lkaI/config

## Steps to reproduce on riscv
 - tuxmake --runtime podman --target-arch arm --toolchain clang-20
--kconfig allmodconfig LLVM=1 LLVM_IAS=1

--
Linaro LKFT
https://lkft.linaro.org

