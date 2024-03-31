Return-Path: <netdev+bounces-83684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA4F893547
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 19:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FFA21C2392B
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 17:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FB914535B;
	Sun, 31 Mar 2024 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WCsvNNkZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5BD12DD96
	for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 17:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711907369; cv=none; b=G2L5SDmMyG2nWgj3OAih9OEpPTBaU3Av81zVNWaYryYGBx+n0jPGnVhvrJjErXIxT7VIya0/WTPn4uvbQMDo/wdcD4+zGjYX3DQFEEBZIgoBgojLvSrwn50fCQSSRxoNijWYRgILbMRmFHjcLVYVh6huZF2gQRqDIfhbu+pJbMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711907369; c=relaxed/simple;
	bh=M9PKvfM1XUlJ0yz9fk8ZoJ3lQb4yr51ocsoenz5m5wU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CjCRt78aUndlF/7uq7KV/hvfcMvZQzKQ959uGAtaDHeIytg3zwUEEGzxangfayipg/5KDqKPhoGoMssMyqJrFpPYpXL37yMTHkB4sTtI5P01h5vxwujdgNkadsg2Hb89uqHjQMy62y3nTpI5Jiyt+e7FrA04PEBsYoVszj6FAz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=WCsvNNkZ; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7cc01644f51so190169939f.2
        for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 10:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711907367; x=1712512167; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wfXG+wF/tlnzwlpe6WnuuMRMbwNdJXyeLBAyx26A1ms=;
        b=WCsvNNkZbr0QOheJJPKfdpCrPQuw8lubWFXMKkpnzzAiddBfOm58EVKY/3yHFLAzxN
         37D6vkD9MeK9UlTW0W3a3wQPhhpV1UMRbkWok8ITOdkICQra0flPbJF9EY7Ck3dP1X7O
         +/V0NaaqLd0sns+6nrvUb7mpmzwuPLDUeI7zr8aseEFvYEPLyvxj0JElNFYrPZn2b08C
         5Gk5sJfSVvRqQeQQa7Ax0dZITu/4W+cOxPuyI0ydLBZmj0aI4P/eVit2SN4RRlMaLYvx
         Jm/Oq8i9dU2k+xQ3PIuCIBkGCYarWFX297oeqA+pySYdk+W/zSdmOK0jzvb86lIvfo8m
         Wr4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711907367; x=1712512167;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wfXG+wF/tlnzwlpe6WnuuMRMbwNdJXyeLBAyx26A1ms=;
        b=PBEj3212k7HmhP+kEhm1fc95Bd1pcomIECCXc1ZSMzMhbNpZ3xoEWvXpzVpXejjcHx
         8R1+MSkvbfNzoRKLdzD4U+gbTElo3OdPAefOL2xtjx3XPPqG4TIK+qYkaZVDyJc+U72C
         64yqK7mZ03WwnlkqnopKl8oBMzSsn9R79xcjODyCo+RYY+QB8GKcPE1BCrC6P6X5Gdw0
         s5PGVgkw9aFoUVg+EN/mNPiDkLaI1hnER37ZCg2995Cq5v9BGZqdPC7BfsUPAEiAxjfQ
         9TrW66ubP1GE3XI8kldeSdQipj+/pu3RcQW1NJ6WNSJ4VSX/uoF92pYPreRrGIuSMPae
         0EBw==
X-Forwarded-Encrypted: i=1; AJvYcCWujzwK6bLrnlD7bSHMilHEMZt4jer9KZ1zLNzrrgeTIcrBZHDGkuqT5AdAoeZeTSqmbbNM+hNJaiWu7AhED6ZCB3fbF4n1
X-Gm-Message-State: AOJu0YwuuTTLIsiEIWCTxDKqMmKNxWxp84OcyQghClY+hEkAWNHZ8V6h
	vKqN7o5nb5V+kP+ZQ/ypWSr2qbpX0qwHnZ/CxIqjUUPUFMhLeZSkU03PijoD6Tg=
X-Google-Smtp-Source: AGHT+IH22sqGdmww4qFmYTNoUoblTRsZ8MDo9UbAH2NhKT2PnzajCNIkvwGlbGpFRCb0Dt+t3AU9/g==
X-Received: by 2002:a6b:6e0b:0:b0:7d0:bee7:b660 with SMTP id d11-20020a6b6e0b000000b007d0bee7b660mr2804375ioh.4.1711907366685;
        Sun, 31 Mar 2024 10:49:26 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.6.190])
        by smtp.gmail.com with ESMTPSA id d11-20020a5d964b000000b007cc840d1d0bsm2217439ios.25.2024.03.31.10.49.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Mar 2024 10:49:26 -0700 (PDT)
Message-ID: <c8e3507b-cab0-4215-9936-cd706f043103@sifive.com>
Date: Sun, 31 Mar 2024 12:49:23 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/5] riscv, bpf: Relax restrictions on Zbb
 instructions
To: Conor Dooley <conor.dooley@microchip.com>, Conor Dooley <conor@kernel.org>
Cc: Stefan O'Rear <sorear@fastmail.com>, Pu Lehui <pulehui@huaweicloud.com>,
 bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 netdev@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Manu Bretelle <chantr4@gmail.com>, Pu Lehui <pulehui@huawei.com>
References: <20240328124916.293173-1-pulehui@huaweicloud.com>
 <20240328124916.293173-3-pulehui@huaweicloud.com>
 <3ed9fe94-2610-41eb-8a00-a9f37fcf2b1a@app.fastmail.com>
 <20240328-ferocity-repose-c554f75a676c@spud>
 <20240329-linguini-uncured-380cb4cff61c@wendy>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20240329-linguini-uncured-380cb4cff61c@wendy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Conor,

Looks good except for one typo.

On 2024-03-29 6:23 AM, Conor Dooley wrote:
> On Thu, Mar 28, 2024 at 10:07:23PM +0000, Conor Dooley wrote:
> 
>> As I said on IRC to you earlier, I think the Kconfig options here are in
>> need of a bit of a spring cleaning - they should be modified to explain
>> their individual purposes, be that enabling optimisations in the kernel
>> or being required for userspace. I'll try to send a patch for that if
>> I remember tomorrow.
> 
> Something like this:
> 
> -- >8 --
> commit 5125504beaedd669b082bf74b02003a77360670f
> Author: Conor Dooley <conor.dooley@microchip.com>
> Date:   Fri Mar 29 11:13:22 2024 +0000
> 
>     RISC-V: clarify what some RISCV_ISA* config options do
>     
>     During some discussion on IRC yesterday and on Pu's bpf patch [1]
>     I noticed that these RISCV_ISA* Kconfig options are not really clear
>     about their implications. Many of these options have no impact on what
>     userspace is allowed to do, for example an application can use Zbb
>     regardless of whether or not the kernel does. Change the help text to
>     try and clarify whether or not an option affects just the kernel, or
>     also userspace. None of these options actually control whether or not an
>     extension is detected dynamically as that's done regardless of Kconfig
>     options, so drop any text that implies the option is required for
>     dynamic detection, rewording them as "do x when y is detected".
>     
>     Link: https://lore.kernel.org/linux-riscv/20240328-ferocity-repose-c554f75a676c@spud/ [1]
>     Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>     ---
>     I did this based on top of Samuel's changes dropping the MMU
>     requurements just in case, but I don't think there's a conflict:
>     https://lore.kernel.org/linux-riscv/20240227003630.3634533-4-samuel.holland@sifive.com/
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index d8a777f59402..f327a8ac648f 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -501,8 +501,8 @@ config RISCV_ISA_SVNAPOT
>  	depends on RISCV_ALTERNATIVE
>  	default y
>  	help
> -	  Allow kernel to detect the Svnapot ISA-extension dynamically at boot
> -	  time and enable its usage.
> +	  Add support for the Svnapot ISA-extension when it is detected by
> +	  the kernel at boot.
>  
>  	  The Svnapot extension is used to mark contiguous PTEs as a range
>  	  of contiguous virtual-to-physical translations for a naturally
> @@ -520,9 +520,9 @@ config RISCV_ISA_SVPBMT
>  	depends on RISCV_ALTERNATIVE
>  	default y
>  	help
> -	   Adds support to dynamically detect the presence of the Svpbmt
> -	   ISA-extension (Supervisor-mode: page-based memory types) and
> -	   enable its usage.
> +	   Add support for the Svpbmt ISA-extension (Supervisor-mode:
> +	   page-based memory types) when it is detected by the kernel at
> +	   boot.
>  
>  	   The memory type for a page contains a combination of attributes
>  	   that indicate the cacheability, idempotency, and ordering
> @@ -541,14 +541,15 @@ config TOOLCHAIN_HAS_V
>  	depends on AS_HAS_OPTION_ARCH
>  
>  config RISCV_ISA_V
> -	bool "VECTOR extension support"
> +	bool "Vector extension support"
>  	depends on TOOLCHAIN_HAS_V
>  	depends on FPU
>  	select DYNAMIC_SIGFRAME
>  	default y
>  	help
>  	  Say N here if you want to disable all vector related procedure
> -	  in the kernel.
> +	  in the kernel. Without this option enabled, neither the kernel nor
> +	  userspace may use vector.
>  
>  	  If you don't know what to do here, say Y.
>  
> @@ -606,8 +607,8 @@ config RISCV_ISA_ZBB
>  	depends on RISCV_ALTERNATIVE
>  	default y
>  	help
> -	   Adds support to dynamically detect the presence of the ZBB
> -	   extension (basic bit manipulation) and enable its usage.
> +	   Add support for enabling optimisations in the kernel when the
> +	   Zbb extension is detected at boot.
>  
>  	   The Zbb extension provides instructions to accelerate a number
>  	   of bit-specific operations (count bit population, sign extending,
> @@ -623,9 +624,9 @@ config RISCV_ISA_ZICBOM
>  	select RISCV_DMA_NONCOHERENT
>  	select DMA_DIRECT_REMAP
>  	help
> -	   Adds support to dynamically detect the presence of the ZICBOM
> -	   extension (Cache Block Management Operations) and enable its
> -	   usage.
> +	   Add support for the Zicbom extension (Cache Block Management
> +	   Operations) and enable its use in the kernel when it is detected
> +	   at boot.
>  
>  	   The Zicbom extension can be used to handle for example
>  	   non-coherent DMA support on devices that need it.
> @@ -684,7 +685,8 @@ config FPU
>  	default y
>  	help
>  	  Say N here if you want to disable all floating-point related procedure
> -	  in the kernel.
> +	  in the kernel. Without this option enabled, neither the kernel nor
> +	  userspace may use vector.

s/vector/floating point/ here.

Regards,
Samuel

>  
>  	  If you don't know what to do here, say Y.
>  
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


