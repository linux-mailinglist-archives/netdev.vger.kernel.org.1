Return-Path: <netdev+bounces-68777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E17E3847FF6
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 04:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35B21C21AF7
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 03:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB17F514;
	Sat,  3 Feb 2024 03:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V//f1bjH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C1CF9D8
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 03:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706932461; cv=none; b=pRoKB0OVq8sdMcymG7sGiY67cGlXkWzfLRzHYs5HFKV0+Qx+jF/PnCZsqISdEbXr1GPHx86hmuYpzhaolaDbEQJbq4ioYnnrv8iNZ5ZyLA4gAJhDKSrMHYTb8Pa/HaKY6AMUj8j2ombnhI3sXNJK7L+3gKCEjBLYXb+0Mb4b/lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706932461; c=relaxed/simple;
	bh=2vtD7+lj0SR271YIcIMlwabKGu1Co46XNZqyL6r9u8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=txPRwNfih5FGnX3EiDRFm4FLpBfTotzHhYNb/mIDLLmd4WQijHM+LXdBRn+ItLfP+ZTQGAUiz0CqHKTDfrmFK1xIf5nJLX9jOaM3j5OMc935f4kLdwsZyW3VgZXG7jrEIYrWURSgWe4lUVk/ssdr8d1m7FKwGiYTMPMe0BcNceI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V//f1bjH; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-296043e44caso2287944a91.0
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 19:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706932459; x=1707537259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0xYkddXUrDJAfgUpGpWm0VMdQ+xvDjPP8EfmN3Ikdgg=;
        b=V//f1bjHaoMnYruaA0jumqpPG2LIfjB4YmmSAx2ayyX0Cx1tnX9hTmE6T5254fLi6h
         BHFGNVci2wqLqkEwAleQCu07mPZ4t5Bhd6AzMsIIg/Pu1sI/n4boC0xrlrYTI+AXn9z9
         y7ZjuiEp/KbPTBYywjlILcoH+/xMzzcO7NvElnEp4ZxAqRFVWNxpgqMmcDGhNKXwGMwe
         A+WmPdDrVyqzT5gdQrVueyq+U1ipQq9kVeZpJBi4FmVFVCJ0D/6jsn2OUwJuVf23FF4t
         4w9cyXS/rEZRt/ZEFc8rqtvUcC83i0wUfA0MZtTKijQH98B4do5T4kIIEZ0MWgX2La9b
         nFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706932459; x=1707537259;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0xYkddXUrDJAfgUpGpWm0VMdQ+xvDjPP8EfmN3Ikdgg=;
        b=Ipl9kUt4EKRNcxTSzF9kqhHAznjc//NgR5xOt4qDPsY0QZWlNw2vTO07HdGDU6vetv
         CFuzDZMmcK/dl3PESZggEISg7LO5jTKxRFJ8GTjB4oznWkHl3b/NzjZ7xeiBa2mY7QGV
         xjezGEsw1VDXHMaeoNUmzjfD8rOTv7wNvJ9vBxit32Gk2WdsBTpsY7kiNCdY7BdRcQNV
         hu9qmiYT1dD3aJhXdHB6q1Z7/c/tAILseqoLjna2biWqBc8l6EoGjD3m8+vdWTjlOU6N
         1igebhx070bo9yxw2id2CPh36wYT8HtrZM6r70cTc7Kii4jBug1cWXJZXR1ylR+NEio/
         Mnkg==
X-Gm-Message-State: AOJu0YzII+HQUKcK6BeYgx7Ww5S1omQwLZsczoIXK9ycZbf9ychq5DXd
	YAPDO4/xYXe8ApCP7eP+ohN+qaWLsdu4SOd2Ai/cjfO4H77ecEhC
X-Google-Smtp-Source: AGHT+IG2VEsTjF9/hgvp324MjfICUu/SUoBr7Zfgdyz8s7NrtoRxECFxCNheppCUG0C8Ol6gxP2W9Q==
X-Received: by 2002:a17:902:e84c:b0:1d9:7124:a89a with SMTP id t12-20020a170902e84c00b001d97124a89amr4258525plg.58.1706932459502;
        Fri, 02 Feb 2024 19:54:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVCGsRf8eDVhA4x7CsvGBEE73XNzjXxdXamxgkcfslXY5eu1BRCDqnZFHffpLQVxj0K7dTK5MEpxRquT1MDUvRAcWqJplCpyNGJdZfZ7/Gb0btjym7RoBWZ1SOQWiYjf606VzTuvYk3HTtEISc=
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k10-20020a170902f28a00b001d6f8b31ddcsm2371164plc.3.2024.02.02.19.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 19:54:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <bd9fa2f7-ffc5-44f6-a301-ea9be91285ab@roeck-us.net>
Date: Fri, 2 Feb 2024 19:54:17 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Persistent problem with handshake unit tests
Content-Language: en-US
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
 kernel-tls-handshake <kernel-tls-handshake@lists.linux.dev>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <b22d1b62-a6b1-4dd6-9ccb-827442846f3c@roeck-us.net>
 <20240202112248.7df97993@kernel.org>
 <f76d66dd-5920-4bf1-95f5-dd64f19826d4@roeck-us.net>
 <39a8176f-7c22-41ac-a027-dac10e349c51@roeck-us.net>
 <3C9375EF-D773-48CF-98D3-920B33E02F5A@oracle.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <3C9375EF-D773-48CF-98D3-920B33E02F5A@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/2/24 19:46, Chuck Lever III wrote:
> 
> 
>> On Feb 2, 2024, at 3:51 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 2/2/24 12:49, Guenter Roeck wrote:
>>> On 2/2/24 11:22, Jakub Kicinski wrote:
>>>> On Fri, 2 Feb 2024 09:21:22 -0800 Guenter Roeck wrote:
>>>>> when running handshake kunit tests in qemu, I always get the following
>>>>> failure.
>>>>
>>>> Sorry for sidetracking - how do you run kunit to get all the tests?
>>>> We run:
>>>>
>>>>      ./tools/testing/kunit/kunit.py run --alltests
>>>>
>>>> but more and more I feel like the --alltests is a cruel joke.
>>> I have CONFIG_NET_HANDSHAKE_KUNIT_TEST=y enabled in my configuration.
>>> The tests run during boot, so no additional work is needed. I don't run all
>>> tests because many take too long to execute in qemu.
>>
>> Follow-up: If this test isn't supposed to run during boot, please
>> let me know and I'll drop it.
> 
> These are pretty simple tests that should run quickly. I don't see
> a reason to exclude them. Generally the memory environment in the
> Kunit test harness is significantly different than the one at boot,
> so problems like this do crop up for qemu vs. boot time on occasion.
> 
> Question is, has this test started to fail only recently, or has it
> been broken since it was merged?
> 

I am wuite sure that it has been broken since it was merged. I only recently
started actually checking test results, so I missed the problem for a while.
Also, I am not sure if anyone besides me is actually running those tests ;-)

Guenter


