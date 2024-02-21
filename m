Return-Path: <netdev+bounces-73744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D9D85E13C
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 16:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 402E9B23761
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 15:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9D4811F2;
	Wed, 21 Feb 2024 15:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RYCU9UO1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAEE80C0E
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529567; cv=none; b=AMGbUj3xFOAiUI6Z9oEwnFbTVDOtAH7GVLtbGWvU99DR9qj89Ac/4bBOWCGMKh8k8HQ+tAOCys6LAkM9FqsWwVG/sKqW7gvOpJUPwUb+Y7ynbWGtp3jJVjlQZokqDytf2WrhWs4sTWeIEqE90fT8RfWFdPra5iBzfrAGJ+f4z1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529567; c=relaxed/simple;
	bh=y8Dc5zRviYFJTbHOro273wuf8Sz1qdtMgs7N6xJCV7M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=THxqi/YVc7u/8MjUKzlu4cFIr+Jl8AlD0g2LbaQ5KW77Zn+FtEJFnb0m5MaiayzBh2tyZI4DL/Phrgzt/cCrXLe0uaXU8KCzbnbkkcNDVfPXcjLvOIHQ3bZ2gY5KCqchDa6Cg9nYX7kbhBySap9IKMS937j5DQ+jXerijBUhjcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RYCU9UO1; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bbbc6e51d0so4123312b6e.3
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 07:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708529565; x=1709134365; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xoYMhckH3/qYBJk6QPSBgn05rtVqWkGGpi9nCOG/QGM=;
        b=RYCU9UO1l0W55yZWWYjjejS+CZScbyEGLVbPMp+jlWMgpH5wXEHcqqintU/AbEFcRI
         cN9j+5Me/dkEovZJujUu29vawCVNlCJ3yAmmp/nC9LIxKPMx2bJKWVtO5WEydgYpP8TB
         VT/vO21fjMMw/cl82lexAavdpoiuYuwQLBqZERkN27+DL9oHX/oHjFy47TL8Rwuxm5ky
         0EEJyE3yHdvo1mFkTrNKeAIPIWkzsF6Y25ImZh9m3m54wr0Lpw3OsgJjRdTQiit61+Qs
         o8ThURaKTGzhl2p83JR+7V6mGaV4PPV/9SMwSSb7CUvE+0z0u2VkHSXRgQH70nT8c3Uv
         XTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708529565; x=1709134365;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xoYMhckH3/qYBJk6QPSBgn05rtVqWkGGpi9nCOG/QGM=;
        b=L8+r5LdRwTJnk05b4eui1dWRZS1HFH6a54oxwHuvvivwSNanj6cHlYl9WYXWgFSiXO
         sNDxNCqDDvVOx+OXethBrdaZ4zERdWAszFruqg4CKpWWq7OYfFKvt6C+dHInTgw/hg4a
         2qOXuAgvMEMFUZnMi5tDaOWeZvlu55apNqD5HPcF0UPAP8EVK07vFCBkPlVRhUVJd7mh
         btq4KDIPNq/2m0QGVI/Pk/7t21vDLKblNg/Y7tIlsv+uZQPaMqzXgaED6PTeplmWL24z
         U4dqHoWqZwvlDOSUsysd2Jgg6B8DPbZOgZKrF559ySALrO0d5rCSRecvSbn0K14xTulr
         NtVg==
X-Forwarded-Encrypted: i=1; AJvYcCWdsoSV7yE5atxKigj0z8oTIVfA8+1Oo2xfTVZkh1FnGZvnsEttkeDoD4khzIO4C41h/7cbCzfMGlu9HdhepAulRkEq/K6T
X-Gm-Message-State: AOJu0Yxl1d3PCLtSUjgwlmc8uR9Jc9v3s1T2EJ0RqDokBZWiJF0HZa78
	txSsKHdc5XWvN0yftwRsOZHbmNxeP7rLWKZKb6GCMmkbyY1lz1IL1nwtMPYPz/nHqY8QWxnIkWU
	DeOS86nfaEgW4rF/LjD73UqQbNv8aOtD+vfR6HQ==
X-Google-Smtp-Source: AGHT+IGEd/3frv8oBIS2QpP2iJlzQrrW5W3omJJrefDfl8H0DyloByN19XPLH8ziQWRuDIW7m0trozsRiPjRQUQeW2A=
X-Received: by 2002:a05:6808:14cf:b0:3c1:4109:d147 with SMTP id
 f15-20020a05680814cf00b003c14109d147mr15706704oiw.9.1708529564791; Wed, 21
 Feb 2024 07:32:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 21 Feb 2024 21:02:33 +0530
Message-ID: <CA+G9fYtNbgy7C0bFhsptk9HfE-kxPf+gEpviL4=o1YePoY8xSw@mail.gmail.com>
Subject: x86: fortify-string.h:63:33: error: '__builtin_memcmp' specified
 bound exceeds maximum object size
To: open list <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, 
	lkft-triage@lists.linaro.org
Cc: Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Hao Luo <haoluo@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="UTF-8"

The x86 / i386 compilations encountered errors due to additional Kconfigs
incorporated from the selftests/net/*/config in the Linux next version.
The issue first appeared with the next-20240213 tag. This problem affects
the Linux next branch, but not the mainline Linus master branch.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

The bisection points to the following commit id,
# first bad commit: [64259ce2a20ce2dcc585a2cb83d1366fb04a6008] ubsan:
reintroduce signed overflow sanitizer

Build errors:
-------------
In function 'memcmp',
    inlined from 'nft_pipapo_insert' at
/builds/linux/net/netfilter/nft_set_pipapo.c:1258:7:
/builds/linux/include/linux/fortify-string.h:63:33: error:
'__builtin_memcmp' specified bound 18446744071562067968 exceeds
maximum object size 9223372036854775807 [-Werror=stringop-overread]
   63 | #define __underlying_memcmp     __builtin_memcmp
      |                                 ^
/builds/linux/include/linux/fortify-string.h:655:16: note: in
expansion of macro '__underlying_memcmp'
  655 |         return __underlying_memcmp(p, q, size);
      |                ^~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors

Steps to reproduce:
-----
tuxmake --runtime podman --target-arch x86_64 --toolchain gcc-13 \
 --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2cfazKeUY5ZIZx7MgVwRAYSVe4w/config
\
 debugkernel cpupower headers kernel kselftest modules

config link:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2cfazKeUY5ZIZx7MgVwRAYSVe4w/config
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2cfazKeUY5ZIZx7MgVwRAYSVe4w/

--
Linaro LKFT
https://lkft.linaro.org

