Return-Path: <netdev+bounces-193924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2736AC64B0
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 10:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A30B99E643D
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 08:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003EC26A092;
	Wed, 28 May 2025 08:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaMA9kRf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682DA24635E
	for <netdev@vger.kernel.org>; Wed, 28 May 2025 08:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748421804; cv=none; b=eazjmaoS09QHIOTkaTyOO0ngttFyvpOvIbilJZ+qZqrQ63cHpAJoestXD+fImE3/eKQMNgxVy7WFBxXKWHyC/PeJT8sAxctvKCJ+uqA3oL+qOHnqLHzJ++lR/BCafBg0ykK9wkGMilyi2UTN4pFaEuBH8bw4x53GlrTTJ7HP50U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748421804; c=relaxed/simple;
	bh=yxhEhoBz7qaYw/XJRNIf6vAQy7M0FuDpNnOOHahDEr4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I9XWl0vSXJclRrxNezQjnNPTm8aqobRuhx4BI+5NFdsleKdHGo+y6C6kPqmXlwV1s4HbkZl2Z3w3cC9zz4Hb+mgCP8N+bHWLQhG7n34qkt9uiB+tb/7NZhVtCR+wwx7UZ5JagEDiMas0NgrSc2kAiCyE/UC3ielokNmRU4lSX4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaMA9kRf; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3114560d74aso3167379a91.0
        for <netdev@vger.kernel.org>; Wed, 28 May 2025 01:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748421802; x=1749026602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g888CBxOK3KTLCYB5LemVbXDX0bJq5p0h5vR7u+0bvg=;
        b=DaMA9kRfmgepUs78wTvMaRecPIihbzySJ1QqCRLide64SXfVqdJeoSKC0zlhr+/+QC
         1P09Z8VW/xO0BanEriI1IkZrDltgG+qBlyox1mnpOIxSw/XFsUih+C9mq6caGFQtfYgd
         7pzIcogFcAnCm5411CPwCPBKtxZPRfQI7jmm7AfVPlMF+Bzf/K0xhZSW3AmER7NWb7Y1
         sUW6VDcmclms2fwJOVYWKVBHBuMPJ6lKv9en5jq64NWAnGoDwDzs9/eUFSg/CKc8vKVu
         giAUpjP2xfo8/gTVgBqQCkbZaenb20t8WBm7vsB6p2Y3UcjF3dlWOlN/+z3N7+co7bin
         XIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748421802; x=1749026602;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g888CBxOK3KTLCYB5LemVbXDX0bJq5p0h5vR7u+0bvg=;
        b=aFI0g1w+Jpm65htd4+1wNQ/KQd+Y2vGgT3CAD+mD/IbqFJk0q0uh9Gi9EPOWUbOPP9
         Otxt52oUEJOvtbKKcIBgaNvLaxYFfVKgNgGbkJ7J5S824nnB1gwHN2FT33Nl67C57ydc
         x9O2qFVfoLRrVMpuTEXa3L44R99I+ZCin0sRHD5Kwl6OrRlko4pkDoRK8Z0D+Tt8w2sR
         /iQa0FUV2X8YtUYPzmPV3VsAj7ioXwC1VRS9HHR9V2dUCX7eHZbbeyQCmqnEOxfeWA+x
         UHflfNYdMSpDEiNTB8bXNhT8m1GKpWuA9KmRE7LFYdiD8mHOHv0a55vqQrqvybjnIPjm
         DKow==
X-Forwarded-Encrypted: i=1; AJvYcCVlbpnzsgg/izRKcfCISrmVrOGPzpZgbxIJSc0RBNXrlCpxz2jQS2j08qmgy1s88gDUJanAux8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOeoqJ53LLFNYfeUTNuCpgi04ymnMli71i92QhHsgcLQjn9rCp
	V4E0cCMxGI1jTy/AM6qJtkV6cf4qJjN2OO/pFakeUiqiK4LyzD+hDbkE
X-Gm-Gg: ASbGncsUqdwLg4jy4zbau+6vLGR1fXxY7RlNreMAwZH00paFU07kl/0mTI0NhzJ3cwp
	wE63Go7JBMKRxX7A0PXkcB5aqHdKk1VOEsxR2YVP4SVU9qIrcVlHIBBB/hd4snSNCI3hCZrtS/a
	OvtgP7+g/+MPf43Yd0OwnUhiGlaGtIGfQDlkjizOHC1PUPH7pUfbfAZGLyYGU9GBV4SEkGYtaAy
	HW+fzgTF2qkGmAMU/edLrdMfmRpxer+dCWYcxj/MtF4hWXU/NZxhQwwP+gyZ7JIP6IJIw97bx2Y
	tTvw6xCCc4fnDgHJBI7J+mtLq/vLcxi5qZofD6EFQtbqD2MQLKn8YYplmAnBo2wLl4Tru3Prvwk
	uyJB36Pa9AAFP5NfUA8qhckKBv3cgRVEwc5GVM3o9
X-Google-Smtp-Source: AGHT+IE4e5WRNj+Klg1eLOb3Kn0QHnfZXPiISRnfdLcRp7Xcbhy+m52GO9srbabitegeavu2bfCf3A==
X-Received: by 2002:a17:90b:3ec1:b0:308:7270:d6ea with SMTP id 98e67ed59e1d1-3110f72c9ccmr21964510a91.30.1748421802457;
        Wed, 28 May 2025 01:43:22 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:a891:19f9:7518:3664? ([2001:ee0:4f0e:fb30:a891:19f9:7518:3664])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-311a4f6c4absm2737921a91.0.2025.05.28.01.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 01:43:22 -0700 (PDT)
Message-ID: <0bcbab9b-79c7-4396-8eb4-4ca3ebe274bc@gmail.com>
Date: Wed, 28 May 2025 15:43:17 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [selftests] 59dd07db92:
 kernel-selftests.drivers/net.queues.py.fail
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Jakub Kicinski <kuba@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org
References: <202505281004.6c3d0188-lkp@intel.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <202505281004.6c3d0188-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/28/25 11:57, kernel test robot wrote:
>
> Hello,
>
> kernel test robot noticed "kernel-selftests.drivers/net.queues.py.fail" on:
>
> commit: 59dd07db92c166ca3947d2a1bf548d57b7f03316 ("selftests: net: move xdp_helper to net/lib")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> [test failed on linux-next/master 176e917e010cb7dcc605f11d2bc33f304292482b]
>
> in testcase: kernel-selftests
> version: kernel-selftests-x86_64-7ff71e6d9239-1_20250215
> with following parameters:
>
> 	group: drivers
>
>
>
> config: x86_64-rhel-9.4-kselftests
> compiler: gcc-12
> test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-9980XE CPU @ 3.00GHz (Skylake) with 32G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202505281004.6c3d0188-lkp@intel.com
>
>
>
> # timeout set to 300
> # selftests: drivers/net: queues.py
> # TAP version 13
> # 1..4
> # ok 1 queues.get_queues
> # ok 2 queues.addremove_queues
> # ok 3 queues.check_down
> # # Exception| Traceback (most recent call last):
> # # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-59dd07db92c166ca3947d2a1bf548d57b7f03316/tools/testing/selftests/net/lib/py/ksft.py", line 223, in ksft_run
> # # Exception|     case(*args)
> # # Exception|   File "/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-59dd07db92c166ca3947d2a1bf548d57b7f03316/tools/testing/selftests/drivers/net/./queues.py", line 33, in check_xsk
> # # Exception|     raise KsftFailEx('unable to create AF_XDP socket')
> # # Exception| net.lib.py.ksft.KsftFailEx: unable to create AF_XDP socket
> # not ok 4 queues.check_xsk
> # # Totals: pass:3 fail:1 xfail:0 xpass:0 skip:0 error:0
> not ok 7 selftests: drivers/net: queues.py # exit=1
>
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250528/202505281004.6c3d0188-lkp@intel.com

Looking at the log file, it seems like the xdp_helper in net/lib is not 
compiled so calling this helper from the test fails. There is similar 
failures where xdp_dummy.bpf.o in net/lib is not compiled either.

Error opening object 
/usr/src/perf_selftests-x86_64-rhel-9.4-kselftests-59dd07db92c166ca3947d2a1bf548d57b7f03316/tools/testing/selftests/net/lib/xdp_dummy.bpf.o: 
No such file or directory

I'm still not sure what the root cause is. On my machine, these files 
are compiled correctly.

Thanks,
Quang Minh.

