Return-Path: <netdev+bounces-146819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2599D612A
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 16:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE512825C4
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 15:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB2C1DE3A2;
	Fri, 22 Nov 2024 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d0sl82Qh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F6113CA93
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288504; cv=none; b=D7ae/+N4X/a4okeFlNiX9iZf8NCb1KFH5+kExCZUWAe0XuMygdDcO5QKPMM90rnEuj02KnfwrbQTmk0Jxg054oLqhODarhDCu2A2ImLHCFNSOsrV0DqKwrrqKKrLg1alfd5XJ5tZNiJ4Sp47HONnaUbhuu64OkhAp7HEXh0FbkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288504; c=relaxed/simple;
	bh=G4ZWYFmDGGCQIedY71/8GZGdAfKcnsuVFa5JVn99a40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cPtX2lXV9NoL7dd5Y6TV9pTbfsrLKOZlG0u4OlqvnLcUj2XOO4SDzxcovac3cz0FCH55RIwNSrBdsdqqD0ih4Ksw5nhX2Gjo6EgY5qeSGHhA6aRc77bL3IpwGtiTDPNnUtlQhybwipNdi7t/w+sHleg8K2fVQ2csYqxYDbakW4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d0sl82Qh; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a76156af6bso7678555ab.2
        for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 07:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1732288500; x=1732893300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rmBxC4X0qWTi2jB3Mdi9nSIUH+PS6n9GSNvglpxej84=;
        b=d0sl82QhPnq84etKN05j5uIcVQ0fDAtllmUo3ENl6LHqc/FE29FuxkudCbEzHXaOLM
         SqfYgvVMwCmhCihB1tE4trzsr/522vvpr77e+qPZ7YYl4Eob17aV7Ea/Pa0+BFB126J3
         ZEan1Yo/R3EMd1RW3CYQAHlHwdDD8oCmh8aJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732288500; x=1732893300;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rmBxC4X0qWTi2jB3Mdi9nSIUH+PS6n9GSNvglpxej84=;
        b=mT5m2zKUXdF4EGNMfhlbNjE/Dn6AshTMm7ciLxB1VTt0rhe4b9kW+SpgpksaYAS8UD
         c5oQlM2v55DbzutGhXsPBw8Bbog/CnMEpX8kbcE90xFOnncAzVzPJUwGEKUMnJYAj5va
         xlYfw8dRwGlR/qizA3stJZSGo3Pb2fDqRP0dMUh07zVrsAwA3PnIEZuhBtqDr6iAlgEj
         yVB8dj6p2l0uIrE3aQ3rgjfcxrkBmRPP/sLMTJAH3wXDOsABhdxhG5BIzn9McYht1wYR
         r6zJaaP8qP1eL/0QNb0K5+ZXQGdNdEH30CeuNV+y90HiZap82m0sWASE2/h/tjatwl3C
         W2OQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9Kj2z3oxqXAHeKwZLvrccfK2KXuxPM6eAK0fdnh94RUinOIuGgrcXJHbSmZSt6Y7nakoMdu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDF5VGQ2GyrndAww9JGFTEAswFAGKUrN4ZeYAZlQeGYoK9SzF6
	eITg/FUKOd9H4eB3/faJeWAKjv8PrFIRR75JV/eEsp9jhMcVKVxRE/4PsCIu2a4=
X-Gm-Gg: ASbGncvMKOxrMUltDGuTBeBNC6dgQvG317ciBSfka/VKaamH3LCR2hZDGEG9AtEbIvp
	6dj+backq58TZFK0rScd9cufMWAFXDNaey3YxU3jN0O2YmK+m+h8m45pk86sjDFItvfzEOyoFdE
	YGTVwolpvu0E1r1UpMghesG3NA3VlIITllsINRbr4Di8SHcaEidFEgPOiFy9G7fpYTWlUdWxuAg
	DARowXcqADa/8AsTxCEao5C5lbKPJHiTSnQFBL6Zi5tZ0oTFJ1rPauDua3OsQ==
X-Google-Smtp-Source: AGHT+IHy5Cwa3AA3W2fNjldnU0Ki3uW2K71uWzdXCbgAWsASPCmhOBROw7+r3q6xtya9E03fAwzWCw==
X-Received: by 2002:a05:6602:3c6:b0:83b:47:8d5 with SMTP id ca18e2360f4ac-83ecdc538d9mr370017639f.3.1732288500377;
        Fri, 22 Nov 2024 07:15:00 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e1cfe1a0e2sm640295173.7.2024.11.22.07.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 07:14:59 -0800 (PST)
Message-ID: <93d96c99-4712-4054-a36f-3c65c80ab3f8@linuxfoundation.org>
Date: Fri, 22 Nov 2024 08:14:58 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kselftest] fix single bpf test
To: Jiayuan Chen <mrpre@163.com>, linux-kselftest@vger.kernel.org,
 Mark Brown <broonie@kernel.org>
Cc: song@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, martin.lau@linux.dev, andrii@kernel.org,
 ast@kernel.org, kpsingh@kernel.org, jolsa@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241118140608.53524-1-mrpre@163.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241118140608.53524-1-mrpre@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/18/24 07:06, Jiayuan Chen wrote:
> Currently, when testing a certain target in selftests, executing the
> command 'make TARGETS=XX -C tools/testing/selftests' succeeds for non-BPF,
> but a similar command fails for BPF:
> '''
> make TARGETS=bpf -C tools/testing/selftests
> 
> make: Entering directory '/linux-kselftest/tools/testing/selftests'
> make: *** [Makefile:197: all] Error 1
> make: Leaving directory '/linux-kselftest/tools/testing/selftests'
> '''
> 
> The reason is that the previous commit:
> commit 7a6eb7c34a78 ("selftests: Skip BPF seftests by default")
> led to the default filtering of bpf in TARGETS which make TARGETS empty.
> That commit also mentioned that building BPF tests requires external
> commands to run. This caused target like 'bpf' or 'sched_ext' defined
> in SKIP_TARGETS to need an additional specification of SKIP_TARGETS as
> empty to avoid skipping it, for example:
> '''
> make TARGETS=bpf SKIP_TARGETS="" -C tools/testing/selftests
> '''
> 
> If special steps are required to execute certain test, it is extremely
> unfair. We need a fairer way to treat different test targets.
> 

Note: Adding Mark, author for commit 7a6eb7c34a78 to the thread

The reason we did this was bpf test depends on newer versions
of LLVM tool chain.

A better solution would be to check for compile time dependencies in
bpf Makefile and check run-time dependencies from bpf test or a wrapper
script invoked from run_tests to the skip the test if test can't run.

I would like to see us go that route over addressing this problem
with SKIP_TARGETS solution.

The commit 7a6eb7c34a78 went in 4 years ago? DO we have a better
story for the LLVM tool chain to get rid of skipping bpf and sched_ext?

Running make -C tools/testing/selftests/bpf/ gave me the following error.
Does this mean we still can't include bpf in default run?

make -C tools/testing/selftests/bpf/
make: Entering directory '/linux/linux_6.12/tools/testing/selftests/bpf'

Auto-detecting system features:
...                                    llvm: [ OFF ]


   GEN     /linux/linux_6.12/tools/testing/selftests/bpf/tools/build/bpftool/vmlinux.h
libbpf: failed to find '.BTF' ELF section in /linux/linux_6.12/vmlinux
Error: failed to load BTF from /linux/linux_6.12/vmlinux: No data available
make[1]: *** [Makefile:209: /linux/linux_6.12/tools/testing/selftests/bpf/tools/build/bpftool/vmlinux.h] Error 195
make[1]: *** Deleting file '/linux/linux_6.12/tools/testing/selftests/bpf/tools/build/bpftool/vmlinux.h'
make: *** [Makefile:369: /linux/linux_6.12/tools/testing/selftests/bpf/tools/sbin/bpftool] Error 2
make: Leaving directory '/linux/linux_6.12/tools/testing/selftests/bpf'

> This commit provider a way: If a user has specified a single TARGETS,
> it indicates an expectation to run the specified target, and thus the
> object should not be skipped.
> 
> Another way is to change TARGETS to DEFAULT_TARGETS in the Makefile and
> then check if the user specified TARGETS and decide whether filter or not,
> though this approach requires too many modifications.
> Signed-off-by: Jiayuan Chen <mrpre@163.com>
> ---
>   tools/testing/selftests/Makefile | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 363d031a16f7..d76c1781ec09 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -116,7 +116,7 @@ TARGETS += vDSO
>   TARGETS += mm
>   TARGETS += x86
>   TARGETS += zram
> -#Please keep the TARGETS list alphabetically sorted
> +# Please keep the TARGETS list alphabetically sorted
>   # Run "make quicktest=1 run_tests" or
>   # "make quicktest=1 kselftest" from top level Makefile
>   
> @@ -132,12 +132,15 @@ endif
>   
>   # User can optionally provide a TARGETS skiplist. By default we skip
>   # targets using BPF since it has cutting edge build time dependencies
> -# which require more effort to install.
> +# If user provide custom TARGETS, we just ignore SKIP_TARGETS so that
> +# user can easy to test single target which defined in SKIP_TARGETS
>   SKIP_TARGETS ?= bpf sched_ext
>   ifneq ($(SKIP_TARGETS),)
> +ifneq ($(words $(TARGETS)), 1)
>   	TMP := $(filter-out $(SKIP_TARGETS), $(TARGETS))
>   	override TARGETS := $(TMP)
>   endif
> +endif
>   
>   # User can set FORCE_TARGETS to 1 to require all targets to be successfully
>   # built; make will fail if any of the targets cannot be built. If
> 
> base-commit: 67b6d342fb6d5abfbeb71e0f23141b9b96cf7bb1

thanks,
-- Shuah

