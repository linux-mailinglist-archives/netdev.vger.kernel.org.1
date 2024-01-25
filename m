Return-Path: <netdev+bounces-65991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1575B83CD0D
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 21:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B509C291927
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 20:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D24137C20;
	Thu, 25 Jan 2024 20:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRYaasqq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAFE13665E
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 20:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212856; cv=none; b=hjHCkBJU9eM8kdkLEql8SSg0Gqve+pGof93dHi0vcFQnE48TC6JU2q6AxHo5e4S7n3XtqDzHghMVKVnqlo5hjZeWRvJl/LpFucODcJBUp8RSrtO2jpnf+KMeGcW+bZpEVCEZpU+2gdrR6dS6wxIltDyHHjXFdnEKA1Ask3J6iBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212856; c=relaxed/simple;
	bh=jeG9KtuDfg3DfkKc0MUqn2kYyVo9XOrxZlbUQiCWlK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hj0+jaSi4kkUJ6rYtvhUZI0OQ4aDuhTNpLlnd3n+ImbJm4wMd33z6QRt5NIN9eBZpL/xGPqvpZTsq2ANpoMYpXZ+V0Pi2ibUqvMBhmijO4AdSsIkxCjAx2ZidBG3gYwLUmXxbjnvkBxMz83YXvNWOMzzcsZIV8t+cQZXL27pH6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRYaasqq; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6dd72c4eb4aso12164b3a.2
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 12:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706212854; x=1706817654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b5bJUL2lb+82v9aqcVmWPR40N9ZsslSu8rvuCqpGQ0c=;
        b=kRYaasqqktb6NJWzv6AWGrHSNaMQLkekssfQgwrUnPCJk8huq17mawtyVZ3Thq/70P
         EL955anhiqNFIu15snQwQk9CMok75K13+rxhoGq2E8HDXRSeJNjbLUKrY7D5hxOyeYQW
         ta5VO3i93gY4qVBNSRPriZF3D4Sou/Np/lTNpU1rySp36ccRlwlEZRlcrXc1lL7bcScN
         V4heW26RrCz7Lmcdh2GF+4TEg3AKB5wqm7IvTK/xx91X6a2CJC8VR4ob1LiWvj+Tkr4a
         /SzneR21/0xma/LooKt++kE6C1FYHjYVUF7appCkkRUaKp6IyrMU/ugBZaxpMwOQwGw8
         Os5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706212854; x=1706817654;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b5bJUL2lb+82v9aqcVmWPR40N9ZsslSu8rvuCqpGQ0c=;
        b=sZ9AbpSDhiC5YGP6X6c68t3QqN3njGM6QulrCaBX3+KFnp1pvQREl6nYfHRWBNOckn
         0ET9NmIskTy1Jxc229IY58DfsJVs9Ozy+nNb9FhomZdpHfK4iRZ70IowA9nW8P5WVE6F
         981mrwgcEU1RSkXpbL2M2retWJ7MCaQrgbKcRxhirTMmFpTTV7w0l4zo8x2nta04DYLs
         a4fzQe1Wl25BBofHvD4Sk7mR024i/vr3rvvpHnhzksjibClQRKCgssgRY6rMaKVRP253
         +wuhfFlmG52FzSRHPXN1DctCWP3U73spTfmujXHduXUODF3kZ9VmjJrl6Qyt2K19K7TK
         JEIw==
X-Gm-Message-State: AOJu0YzabH7Gjt4/AaZkoeBx6xkq4mmKMBWhBTUMp3DdTYkvw4itAiso
	5bjNb4tC4lt9wgCEGbW9EwmIAS18Kao14/O1cJWgKGAEhj5h5/+B
X-Google-Smtp-Source: AGHT+IH/fLsm2DMpo54VZ12r3gDyC4acm7XjB+4bcJwt9YSuMjoIOeIOgiR+hd0RxQD607FNTK80/w==
X-Received: by 2002:a05:6a20:2d25:b0:19c:4c8f:c8e5 with SMTP id g37-20020a056a202d2500b0019c4c8fc8e5mr190000pzl.83.1706212852766;
        Thu, 25 Jan 2024 12:00:52 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id h21-20020a17090a9c1500b0028e87ce1de0sm1897628pjp.51.2024.01.25.12.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 12:00:51 -0800 (PST)
Message-ID: <99682651-06b4-4c69-b693-a0a06947b2ca@gmail.com>
Date: Thu, 25 Jan 2024 12:00:46 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: stmmac on Banana PI CPU stalls since Linux 6.6
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, Marc Haber <mh+netdev@zugschlus.de>,
 Petr Tesarik <petr@tesarici.cz>
Cc: alexandre.torgue@foss.st.com, Jose Abreu <joabreu@synopsys.com>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Jisheng Zhang <jszhang@kernel.org>,
 netdev@vger.kernel.org
References: <Za173PhviYg-1qIn@torres.zugschlus.de>
 <8efb36c2-a696-4de7-b3d7-2238d4ab5ebb@lunn.ch>
 <ZbKiBKj7Ljkx6NCO@torres.zugschlus.de>
 <229642a6-3bbb-4ec8-9240-7b8e3dc57345@lunn.ch>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <229642a6-3bbb-4ec8-9240-7b8e3dc57345@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/25/24 11:54, Andrew Lunn wrote:
>> I have checked out 2eb85b750512cc5dc5a93d5ff00e1f83b99651db (which is
>> the first bad commit that the bisect eventually identified) and tried
>> running:
>>
>> [56/4504]mh@fan:~/linux/git/linux ((2eb85b750512...)) $ make BUILDARCH="amd64" ARCH="arm" KBUILD_DEBARCH="armhf" CROSS_COMPILE="arm-linux-gnueabihf-" drivers/net/ethernet/stmicro/stmmac/stmmac_main.lst
>>    SYNC    include/config/auto.conf.cmd
>>    SYSHDR  arch/arm/include/generated/uapi/asm/unistd-oabi.h
>>    SYSHDR  arch/arm/include/generated/uapi/asm/unistd-eabi.h
>>    HOSTCC  scripts/kallsyms
>>    UPD     include/config/kernel.release
>>    UPD     include/generated/uapi/linux/version.h
>>    UPD     include/generated/utsrelease.h
>>    SYSNR   arch/arm/include/generated/asm/unistd-nr.h
>>    SYSTBL  arch/arm/include/generated/calls-oabi.S
>>    SYSTBL  arch/arm/include/generated/calls-eabi.S
>>    CC      scripts/mod/empty.o
>>    MKELF   scripts/mod/elfconfig.h
>>    HOSTCC  scripts/mod/modpost.o
>>    CC      scripts/mod/devicetable-offsets.s
>>    UPD     scripts/mod/devicetable-offsets.h
>>    HOSTCC  scripts/mod/file2alias.o
>>    HOSTCC  scripts/mod/sumversion.o
>>    HOSTLD  scripts/mod/modpost
>>    CC      kernel/bounds.s
>>    CC      arch/arm/kernel/asm-offsets.s
>>    UPD     include/generated/asm-offsets.h
>>    CALL    scripts/checksyscalls.sh
>>    CHKSHA1 include/linux/atomic/atomic-arch-fallback.h
>>    CHKSHA1 include/linux/atomic/atomic-instrumented.h
>>    MKLST   drivers/net/ethernet/stmicro/stmmac/stmmac_main.lst
>> ./scripts/makelst: 1: arithmetic expression: expecting EOF: "0x - 0x00000000"
>> [57/4505]mh@fan:~/linux/git/linux ((2eb85b750512...)) $
>>
>> That is not what it was suppsoed to yield, right?
> 
> No. But did it actually generate
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.lst Sometime errors
> like this are not always fatal.
> 
>> My bisect eventually completed and identified
>> 2eb85b750512cc5dc5a93d5ff00e1f83b99651db as the first bad commit.
> 
> I can make a guess.
> 
> -       memset(&priv->xstats, 0, sizeof(struct stmmac_extra_stats));
> 
> Its removed, not moved later. Deep within this structure is the
> stmmac_txq_stats and stmmac_rxq_stats which this function is supposed
> to return, and the two syncp variables are in it as well.
> 
> My guess is, they have an invalid state, when this memset is missing.
> 
> Try putting the memset back.
> 
> I also guess that is not the real fix, there are missing calls to
> u64_stats_init().

Did not Petr try to address the same problem essentially:

https://lore.kernel.org/netdev/20240105091556.15516-1-petr@tesarici.cz/

this was not deemed the proper solution and I don't think one has been 
posted since then, but it looks about your issue here Marc.
-- 
Florian


