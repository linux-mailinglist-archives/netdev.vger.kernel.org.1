Return-Path: <netdev+bounces-194675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE056ACBD46
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 00:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D3337A4B1E
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 22:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CC920E026;
	Mon,  2 Jun 2025 22:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GUFRRk28"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BC91482E7
	for <netdev@vger.kernel.org>; Mon,  2 Jun 2025 22:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748903086; cv=none; b=OQ0nDONZNKmr/m+k94uPqNCTQCcK4AR6uHxUd0y4T1J/h5er91DgRU3/m1jbwWIRFG1ctG6s0yFezZVzJVk8DocuNPo3qQCeii70Kz1AdVoURO/AMzbD76v85NzlmbT/qWqyUgPwpmXpL/0r8y134cvW5/QaTvVFlsBY9WSrtHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748903086; c=relaxed/simple;
	bh=/g+1lG97hH7nzbUuTK4MjNKBd7tgWrwgqsh7ks6lfDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cn35QiZgSHYIWRlCez9/YAuEPGcmx+DvdjiYTI0ambbaGEaR1a38q9r3I+A5/AoLLTBOU5Pqy8pbQrEiD0Jr4ltdcTjQ85hQDIXfwJc7Pxk4ezXFNowaELWZDDuDZLGkN16vS0GwrkbnGMCyPXfnjIisPhu0WP/MNn2KBxgU3o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GUFRRk28; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3dca2473129so39630525ab.2
        for <netdev@vger.kernel.org>; Mon, 02 Jun 2025 15:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748903084; x=1749507884; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/g+1lG97hH7nzbUuTK4MjNKBd7tgWrwgqsh7ks6lfDo=;
        b=GUFRRk28OpOQL19ikT4PHwTSapkMk/noXHCUXrgS323PzUWoFQaGZVpcucGQrS2FIC
         KCMNjVbzNgKH2DWaece/WKEEVinH8iPEnEqa8P/ung4GvoDYz37NDXc4S8GSfviXgwIF
         Wq+cIi8hiUCYGrKP63fBsahMHSOOq/M8N+Bcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748903084; x=1749507884;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/g+1lG97hH7nzbUuTK4MjNKBd7tgWrwgqsh7ks6lfDo=;
        b=neqxJwJSS9FqDUIVHqPfpwpQ2C0LnsXLRMuvEcGtG1QXYSfxIn/Yrn0TOQPbcRK1Uu
         e7aJC/H0CES+28p7rClU+18XXNNpw/HSUQOTizvtGTo8YQ9oxRVQlOwubZi7EjqrunVc
         1WD/QNLKRJlfRPb/vcvM4RjZL/M2vcx77TKiKFh+800JpeHxebGZQp2jOAvW47g5e44E
         xBYi1Wg7Gr4JjTYoo9kpyRVIJw8A2Da1v9GJT6SvZxPWtBtYM4owFw5MDSQhKbR7TcP8
         uaFt+/31zsFNXbIog9FCKs64UkoxMOjI/HA06/sVQM2qYYdXQ9YbEzbnHTyZa4Sr1dic
         FyUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUu6xzlOF7F2vLpfiJh29nUZTffbcs+QjYi7yo+DH6mDUl5WSBsgUhW2fB2b5zbj6Ru+9Sb/Pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGnwpFiCbB7o1vjix9g7+R5GQFLB3Z3gE5LWAG+uO7N93LQph7
	cseNaab255dER3K+Oe9zQqY02VxeEX93XIhW0p+K63aybL443qTRfmqWvoWpx/HiqMI=
X-Gm-Gg: ASbGncvg2lvfZM/GTMsebgPrrUaXza+bWXIifB3w9yzPA83ABa9xPHfkIkhqR2OR5/7
	bLkFW0NJg+pKZ5WNKIkxyRa03OEdDcCiUs6yTV594D6Jt6nDVeapFHiNM5qzBcSxUjdmAmMyBvl
	vMWDat4A8+onk1l4/ZHmjao5QqWzn43Xte+pD6OeXRpHc9BmWm/W0kQUO7fiig0COFVWe5bpuzE
	aoYl0xNijefEThh11gcsozWnX+4anxuAw+/thXfg5+X0vj1neB1fwz3DfEQHmC8Vh6b+HIKWrhn
	DThTJ/1pNO7MSrDbdA0BtHuJeI6SrrwY2drwqt8WPxJPSyhh73vEEC7lyqA8Yw==
X-Google-Smtp-Source: AGHT+IEoBt1WDQlTWQAcC5v2oWlv5fTd2KvSmZQf2T9kZlu31kwNdxUFhUjaMoZ7f5E6YihUTLo/9A==
X-Received: by 2002:a05:6e02:1a4b:b0:3da:71c7:5c7f with SMTP id e9e14a558f8ab-3dda3388352mr97576605ab.15.1748903084143;
        Mon, 02 Jun 2025 15:24:44 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fdd7ed8160sm1959548173.98.2025.06.02.15.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 15:24:43 -0700 (PDT)
Message-ID: <1e36801d-7bf5-46dd-bcc5-669fba575806@linuxfoundation.org>
Date: Mon, 2 Jun 2025 16:24:42 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] Revert "kunit: configs: Enable
 CONFIG_INIT_STACK_ALL_PATTERN in all_tests"
To: Richard Fitzgerald <rf@opensource.cirrus.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, brendan.higgins@linux.dev,
 davidgow@google.com, rmoar@google.com, broonie@kernel.org, mic@digikod.net,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250530135800.13437-1-kuba@kernel.org>
 <9628c61e-234f-45af-bc30-ab6db90f09c6@linuxfoundation.org>
 <20250530180750.4c722f71@kernel.org>
 <74d3a550-a828-4666-8664-d08d06fc6f0f@opensource.cirrus.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <74d3a550-a828-4666-8664-d08d06fc6f0f@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/2/25 07:34, Richard Fitzgerald wrote:
> On 31/05/2025 2:07 am, Jakub Kicinski wrote:
>> On Fri, 30 May 2025 10:59:54 -0600 Shuah Khan wrote:
>>> On 5/30/25 07:58, Jakub Kicinski wrote:
>>>> This reverts commit a571a9a1b120264e24b41eddf1ac5140131bfa84.
>>>>
>>>> The commit in question breaks kunit for older compilers:
>>>>> $ gcc --version
>>>>    gcc (GCC) 11.5.0 20240719 (Red Hat 11.5.0-5)
>>>>
>>>> $ ./tools/testing/kunit/kunit.py run  --alltests --json --arch=x86_64
>>>>    Configuring KUnit Kernel ...
>>>>    Regenerating .config ...
>>>>    Populating config with:
>>>>    $ make ARCH=x86_64 O=.kunit olddefconfig
>>>
>>>
>>>>    ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
>>>>    This is probably due to unsatisfied dependencies.
>>>>    Missing: CONFIG_INIT_STACK_ALL_PATTERN=y
>>>
>>> Does adding config option work for you?
>>> ./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_INIT_STACK_ALL_PATTERN
>>
>> Nope (with this patch applied):
>>
>> $ ./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_INIT_STACK_ALL_PATTERN=y
>> [18:02:47] Configuring KUnit Kernel ...
>> Regenerating .config ...
>> Populating config with:
>> $ make ARCH=um O=.kunit olddefconfig
>> ERROR:root:Not all Kconfig options selected in kunitconfig were in the generated .config.
>> This is probably due to unsatisfied dependencies.
>> Missing: CONFIG_INIT_STACK_ALL_PATTERN=y
>> Note: many Kconfig options aren't available on UML. You can try running on a different architecture with something like "--arch=x86_64".
>>
>>>> Link: https://lore.kernel.org/20250529083811.778bc31b@kernel.org
>>>> Fixes: a571a9a1b120 ("kunit: configs: Enable CONFIG_INIT_STACK_ALL_PATTERN in all_tests")
>>>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>>>> ---
>>>> I'd like to take this in via netdev since it fixes our CI.
>>>> We'll send it to Linus next week.
>>>
>>> I am good with reverting it for now.
>>>
>>> David, Brendan,
>>> We will have to enable this at a later time. Also we saw this problem
>>> before with other configs. Anyway way to fix this for alltests case?
>>
>> FWIW Richard commented in the linked thread, IIUC this was just for
>> added coverage but not a hard requirement.
> Correct. It's not required (for me). It found a bug in my code, so it
> seemed useful to have enabled while testing. I thought this was safe to
> do, I didn't know that this only works with certain platforms and
> compilers.

Thanks for clarifying. Looks good to me.

thanks,
-- Shuah


