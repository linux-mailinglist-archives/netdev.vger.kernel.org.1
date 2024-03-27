Return-Path: <netdev+bounces-82441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6CF88DC8C
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 12:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D87429B4A8
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 11:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13DB7F7CD;
	Wed, 27 Mar 2024 11:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="rACv5S+T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8EC7F7CB
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 11:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711539039; cv=none; b=gxwnvuegQa08X2V4TJ4R3fi33GWhHZkGhOze2vYNcM8rr01OtMxbkg4wO4/2O+U+R0Ryva9Qd61PAdM0h72HLC13ikt7CglFD/EY0pOJ0P/Zxo+00AZ3uV7KhRnHaXaN6wP8L2OtLaiy3nQMLx5MvvMmRQr8IMqcLvaLf0Z85AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711539039; c=relaxed/simple;
	bh=JwkWMoE6/Cnci5NscGLNDrRSmDoeYlNTnB0n/TZ3vvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YykobP6qVEQ+ge5F9GKm919MFf75ioyTcRwepNuzFQjqnw/sxTv+T2/0JaqXzW/pA9JEBZyG1Ttvvil2rcdegHaaFYP3gp9tijyU3zcspZXASp7kUD2miBy8RSBzHN5hEDVhtRbB3sOkV4v5CLi5PB+ncViErV9fp3iAtS1CRaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=rACv5S+T; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dcbc6a6808fso6245303276.2
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 04:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1711539037; x=1712143837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JwkWMoE6/Cnci5NscGLNDrRSmDoeYlNTnB0n/TZ3vvk=;
        b=rACv5S+TeA+kY/93yVxfY0khvLu3vhOhecNEzOpAs4BIcVjjKtU52Fw/OoD8gIrXQH
         YcDaPhtOU1lTYxglgyRjo9s4EYXoPM1S3P/VoOLzeE0EXuwSge8OfqEk1TWXlaanLdXx
         ZhChAM/hSdHuE6VEtR/SJkyySAqdhfvrZ9T1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711539037; x=1712143837;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwkWMoE6/Cnci5NscGLNDrRSmDoeYlNTnB0n/TZ3vvk=;
        b=TzhwU6JU2iHBjBYZqbAtT85nZ9LHAHQZdwotQPR2cC5gUnfNBoixHN6E8XydH7H9Zq
         MJT7jGDfbmXEPHMhQbtd0g+JGd36avAcvSjtWNz+MA1GXm6gLmwojUfl7G6ghSNKd8Sq
         onNtJE6UlEGSYjw/8yJpyg1vIO1JG2k8F1cxo/3Lc+xLGnDhlAMon8zS03FkTNXsnTqW
         VOzLWIkWyOsBD8rmo0lLHHsHaa/Kp7pvXjJgYmOElGcCsXAY2EhH/FlmVkyc/McjJGGT
         IbjnAtVGA4jL9xzjJPBQG1utJT8vi3ryhQ7es1TO2JfT99jg/L2K8sbuUgnddtpJ+Ets
         AT4g==
X-Gm-Message-State: AOJu0YzBTmwii6Q38O5iQ0Ptc+nDN6p5/NJdTad58+08peDQfmnxcbmV
	1h3FPEFZk5LPJRoh4bIiwwLr7xoQycVG+Bj5DMkZEBgKerl0wclG0KY8QEWBSJMy5Jdfrysb/V3
	crqg=
X-Google-Smtp-Source: AGHT+IHW1xP80WA4jBBNUeS1sdHJRAi/twm/YEYC2sGOn/0MA+8E2ktTda2jarA94MPUChe2JY843g==
X-Received: by 2002:a25:8009:0:b0:dcc:7b05:4cbb with SMTP id m9-20020a258009000000b00dcc7b054cbbmr674348ybk.31.1711539036992;
        Wed, 27 Mar 2024 04:30:36 -0700 (PDT)
Received: from [10.80.67.139] (default-46-102-197-194.interdsl.co.uk. [46.102.197.194])
        by smtp.gmail.com with ESMTPSA id r15-20020a056214212f00b0069698528727sm2175211qvc.90.2024.03.27.04.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 04:30:36 -0700 (PDT)
Message-ID: <4df81c9b-fa7f-4585-a4a7-9f9189baa028@citrix.com>
Date: Wed, 27 Mar 2024 11:30:33 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Xen NIC driver have page_pool memory leaks
To: Jesper Dangaard Brouer <hawk@kernel.org>, paul@xen.org,
 Arthur Borsboom <arthurborsboom@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Netdev <netdev@vger.kernel.org>, Wei Liu <wei.liu@kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 kda@linux-powerpc.org, Xen Security <security@xen.org>
References: <CALUcmUncphE8v8j1Xme0BcX4JRhqd+gB0UUzS-U=3XXw_3iUiw@mail.gmail.com>
 <1cde0059-d319-4a4f-a68d-3b3ffeb3da20@kernel.org>
 <857282f5-5df6-4ed7-b17e-92aae0cf484a@xen.org>
 <ba4ac0f4-7a95-4fb2-b128-d7b248e4137a@kernel.org>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
Autocrypt: addr=andrew.cooper3@citrix.com; keydata=
 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
 6+ahAA==
In-Reply-To: <ba4ac0f4-7a95-4fb2-b128-d7b248e4137a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/03/2024 11:27 am, Jesper Dangaard Brouer wrote:
>
>
> On 25/03/2024 13.33, Paul Durrant wrote:
>> On 25/03/2024 12:21, Jesper Dangaard Brouer wrote:
>>> Hi Arthur,
>>>
>>> (Answer inlined below, which is custom on this mailing list)
>>>
>>> On 23/03/2024 14.23, Arthur Borsboom wrote:
>>>> Hi Jesper,
>>>>
>>>> After a recent kernel upgrade 6.7.6 > 6.8.1 all my Xen guests on Arch
>>>> Linux are dumping kernel traces.
>>>> It seems to be indirectly caused by the page pool memory leak
>>>> mechanism, which is probably a good thing.
>>>>
>>>> I have created a bug report, but there is no response.
>>>>
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=218618
>>>>
>>>> I am uncertain where and to whom I need to report this page leak.
>>>> Can you help me get this issue fixed?
>>>
>>> I'm the page_pool maintainer, but as you say yourself in comment 2 then
>>> since dba1b8a7ab68 ("mm/page_pool: catch page_pool memory leaks") this
>>> indicated there is a problem in the xen_netfront driver, which was
>>> previously not visible.
>>>
>>> Cc'ing the "XEN NETWORK BACKEND DRIVER" maintainers, as this is a
>>> driver
>>> bug.  What confuses me it that I cannot find any modules named
>>> "xen_netfront" in the upstream tree.
>>>
>>
>> You should have tried '-' rather than '_' :-)
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/xen-netfront.c
>>
>>
>
> Looking at this driver, I think it is missing a call to
> skb_mark_for_recycle().
>
> I'll will submit at patch for this, with details for stable maintainers.
>
> As I think it dates back to v5.9 via commit 6c5aa6fc4def ("xen
> networking: add basic XDP support for xen-netfront"). I think this
> commit is missing a call to page_pool_release_page()
> between v5.9 to v5.14, after which is should have used
> skb_mark_for_recycle().
>
> Since v6.6 the call page_pool_release_page() were removed (in
> 535b9c61bdef ("net: page_pool: hide page_pool_release_page()") and
> remaining callers converted (in commit 6bfef2ec0172 ("Merge branch
> 'net-page_pool-remove-page_pool_release_page'")).
>
> This leak became visible in v6.8 via commit dba1b8a7ab68 ("mm/page_pool:
> catch page_pool memory leaks").

Thankyou very much for your help here.  Please CC
security@xenproject.org too, because we'll want to issue an XSA (Xen
Security Advisory) when this fix is ready.

~Andrew

