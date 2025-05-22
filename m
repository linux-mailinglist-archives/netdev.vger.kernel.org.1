Return-Path: <netdev+bounces-192670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BF3AC0C62
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 15:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BC4B7B804A
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 13:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB38D28C035;
	Thu, 22 May 2025 13:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ycq9YWdx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6D528C034
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747919527; cv=none; b=HHiedHoWnwo2Uo+tmMayJM+Ey3h/H1b4pthCRmnJgSC2DLoB+60MO5tUL/hsBzDqIkN6p0VUXChBnWdSgGebry3DrQgUnhPC9O9uZLydWNHssy3NJxkHdU+Wn0XWSJzSaWUx8L2KaWCXM00fbBTqGttbj53yo8e4LuKgbaIq2Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747919527; c=relaxed/simple;
	bh=VwD68oPdZR7QMQCqJ6VWvr3muJ2LNlzFhJmXibbXOuE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Fl8OsUL7BwJiAiWY2IO2fokGBuctWhXbZ3ci4Deb4hSd5l8C76M7mbzoliDWexwBTPes+XBdrkBiVNIU3OGszWlYmQ/TnaST7uvEb+hMonvtBOFE+uRMV+bZ5Zm7futIsPEefncsF4NPDGG6zI68bu3ahk2mmIXS7X5iQYX2Pvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ycq9YWdx; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c546334bdeso704803385a.2
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 06:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747919525; x=1748524325; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vVd3U96Y4i9Vlcsd5gesH7KRFcK58OXYVflQsNrla/c=;
        b=Ycq9YWdxpOKxxk0SxqS4VwJ7S6KlAP01OgpLJKe2MSknqqRLl8j6eNmyh6d9dBP1sK
         9xhsE6B5E9/bsIxiyaU8f91iv6DwjhpgF5L+CklhfTvgbEwHvu6kG1q5yjj/N9l7gL4Y
         x5Xi6WurPLgyAapCCweRVVkjMw/QxRg1pUGRW5QbMLenuhoGIHJSxysqFCSMu5xmA22v
         njlELzZkbGLLmRlmrvcGsjK3OOztjIbJMOETI9WxYk3/04IO4+5uSN0Vxu53YI5tDhR6
         cYX3tgim18mfC2AUoAPNkOssuFW79LALhEufAOnYhECet/wCBCZstHrnzRQUnd8bsU4u
         2wRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747919525; x=1748524325;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vVd3U96Y4i9Vlcsd5gesH7KRFcK58OXYVflQsNrla/c=;
        b=MDaa1wC9/39LeyftH1zxQV2m7CGmw0jImzbuXxfnijk7LXDBak+3CbJROWEN09DA+Y
         0r4qVZ+LBJ2FyIvU5ki2A+HBaTGjLdH1sMKxchGOcjgONXG7Ith74x7CA7vwa9EPXE4M
         vmPmnoD9llLiWj27UgdPtZP/uPVFRHMVCkcchLGoujya7QERuNFU3RKiNyIIO1nTO+kj
         94uVWvc4v7/PqmLiOrGqKSAm+IucavOqYQLfBKxJGO1HBqVZMQ4p9KEJqpEGCrvCKmFO
         UOf0Oy4Azx40KtuKSJizqAfXAgF+W6p+C1kjgojOYZsaszfb00lr1KMSf/u0IKg94ctV
         i+jA==
X-Forwarded-Encrypted: i=1; AJvYcCXqb+qxED27yiJ3BRrX2aecXB1vhwna8xw9qMMumQnafdzQg0DVa39GUw4G3/hg/c4F7ECe4kQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF7WoBB/c9AA8I1kmX6xEBAw3c6yzLlUIuVNwS4+ftoh+X+PhM
	k4RdtGKb67UKG6rVTedn31CkKjbN28nGOh1BA111PXONVTeVLG+nOgZ+tRwhVr2sMrjeaVRkhuH
	eRWsEfVQs9NqWhfSBWFgU1T/JKm0tGT5hbf36rGr8Ng==
X-Gm-Gg: ASbGncu2GkfQq8ekZNICqYD4UwJI8nUW1Y2XzAIl2bRu7jq7CQUhKT+waQTp4j1Slu4
	sLThqJAKA+bHdzcqL/+7uS4LUuxe5YOUQsrJNaSsEwnPM2oP+NISffqWFSGH6JrwKE4sWNNbE1r
	aLEy+jUekwvqLDIWGOb+g3aQtiS3tN6XtSY9IRHR2IcExEhJsrJBKmxuVuWG1KRMEJbA==
X-Google-Smtp-Source: AGHT+IFer49uV/0MlFOwzViAxidhmUTCovTOCELPmnDhegazhsSbbMo1dxe+RgiFPEHTV1iqxE1ZvAzIrmUV7Y4BUPA=
X-Received: by 2002:a05:620a:4405:b0:7ca:f3d0:e7c8 with SMTP id
 af79cd13be357-7cd47fed6f9mr3472211685a.52.1747919524812; Thu, 22 May 2025
 06:12:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 22 May 2025 18:41:52 +0530
X-Gm-Features: AX0GCFsHvByQyFYjjj2yI43kVVdpVcQ_KO3AH4tPajR5bk66xedIzcAuV4seOEA
Message-ID: <CA+G9fYssasMnOE36xLH5m7ky4fKxbzN7kX5mEE7icnuu+0hGuQ@mail.gmail.com>
Subject: arm64 gcc-8 defconfig call to '__field_overflow' declared with
 attribute error value doesn't fit into mask
To: open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-wireless@vger.kernel.org, 
	Netdev <netdev@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Johannes Berg <johannes.berg@intel.com>, 
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Content-Type: text/plain; charset="UTF-8"

Regressions on arm64 defconfig build failed with gcc-8 on the Linux next
tag next-20250512 and next-20250522.

First seen on the next-20250512
 Good: next-20250509
 Bad:  next-20250512

Regressions found on arm64:
 - build/gcc-8-defconfig

Regression Analysis:
 - New regression? Yes
 - Reproducible? Yes

Build regression: arm64 gcc-8 defconfig call to '__field_overflow'
declared with attribute error value doesn't fit into mask

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
-----
In file included from arch/arm64/include/asm/sysreg.h:1107,
                 from arch/arm64/include/asm/cputype.h:248,
                 from arch/arm64/include/asm/cache.h:43,
                 from include/vdso/cache.h:5,
                 from include/linux/cache.h:6,
                 from include/linux/time.h:5,
                 from include/linux/skbuff.h:15,
                 from include/linux/if_ether.h:19,
                 from include/linux/ieee80211.h:19,
                 from drivers/net/wireless/intel/iwlwifi/iwl-trans.h:10,
                 from drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c:6:
In function 'u32_encode_bits',
    inlined from 'iwl_pcie_ctxt_info_init' at
drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c:208:3:
include/linux/bitfield.h:195:3: error: call to '__field_overflow'
declared with attribute error: value doesn't fit into mask
   __field_overflow();     \
   ^~~~~~~~~~~~~~~~~~
include/linux/bitfield.h:215:2: note: in expansion of macro '____MAKE_OP'
  ____MAKE_OP(u##size,u##size,,)
  ^~~~~~~~~~~
include/linux/bitfield.h:218:1: note: in expansion of macro '__MAKE_OP'
 __MAKE_OP(32)
 ^~~~~~~~~

## Source
* Kernel version: 6.15.0-rc7
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git sha: 460178e842c7a1e48a06df684c66eb5fd630bcf7
* Git describe: next-20250522

## Build
* Build log: https://qa-reports.linaro.org/api/testruns/28517069/log_file/
* Build history:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250522/testrun/28517069/suite/build/test/gcc-8-defconfig/history/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2xRo9LbWebbQqL9EYIT8oB7qmNj/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2xRo9LbWebbQqL9EYIT8oB7qmNj/config

--
Linaro LKFT
https://lkft.linaro.org

