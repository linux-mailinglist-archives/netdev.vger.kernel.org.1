Return-Path: <netdev+bounces-227743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0954BB66FC
	for <lists+netdev@lfdr.de>; Fri, 03 Oct 2025 12:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54B644E0501
	for <lists+netdev@lfdr.de>; Fri,  3 Oct 2025 10:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E395F2E8E1F;
	Fri,  3 Oct 2025 10:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJHztxpx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC68EAC7
	for <netdev@vger.kernel.org>; Fri,  3 Oct 2025 10:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759486976; cv=none; b=QV2Z0f9n2YZgzDn6nIyNABy3MUqUH55eAgLMeBLhHa58oLA8MKkZqqos9iWATfdyWqiS8OtjZ4osEV/HiUGwHIRaBtD4NDz8MrDEH9P+t3tp/GdGsxy6ymlxmKcfPKTcY8NsB4+SdLXSJ+WZCpHhlvZqBWf4z3iQMz0xlkQohA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759486976; c=relaxed/simple;
	bh=3xxXRyy3Jq92ZQAfd3xiufGuemMTntOY4GZPwSM1RdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AsbJ+wAhBA6dsYZYbG7M+Yr+P8tsT6Gg5Y5OB88Ql+QrV1epgYlILeiAnAlF17Jyz55smAnhqubo5FoB7gemDcGZHi12s2Gbc4pM3qunU0lRdc458SUFAJpI/2Q0V9ns5hLoKPiy+nuG0iUNGtuqR57mcLUbLbbsTBwWs2h5L28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJHztxpx; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e44310dbeso2302475e9.0
        for <netdev@vger.kernel.org>; Fri, 03 Oct 2025 03:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759486973; x=1760091773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/EmsAJimqXkpHX/eRAgnIzY2He0pg7LXBAkhLwOqkjM=;
        b=cJHztxpx641ZTNDWh+gaT/c4lT8TKHIHwnbhiTUT91JvCH0t4RrGiMSddDp6n8kZVn
         5k056BFG2aTaW7QxfoPm2sEt7KDwbeaYdG+GZIlk+5bsnRd4swFM755I1FV734lhmR2v
         h1S6b8UzSA5AaSasFYcSMbUcyRLZQHU9uJ0z872QPnGRzbuKGTeltVUY16MatI5/0GL0
         6Kso98o4tHimWbNVX+N7/z5/EOE34c2QoIkI6K4HYYKROZScPfDlM8TQ/pSAnzHZ0Tkk
         WWsUl1PgTqVeNIiZeP4rCY/Wky8Ux9q+RkGqQN2E287BD7C0/4hxPwwvzjS6wULzeX+n
         L4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759486973; x=1760091773;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/EmsAJimqXkpHX/eRAgnIzY2He0pg7LXBAkhLwOqkjM=;
        b=cR1r5UUOYRmCLZu2CQ9T7Uzud3yYMn2EcajEilmDxseqGhUkpcOArnmeoNpew/y2br
         E20dtnRF/jaoGWkmJqZ/AO7sJuzVDJqZL+QSno+TVatKTkvFiG2o1jXAt7kgAu21vpKA
         uYwyg/5cHVW42IoitS4jF7nkyphAtf7V127bLYcr7/vjNn7UHq6tb7Zduu4JYFySgS7X
         TPT887gTnxGSxmWQ970wMHomw8xxM2HF4eOhxKdW6E6ZMbNeJTEoYnDn8lgdYOBDzYrj
         WC7ySzrqTwZ8DUjV0/mgxbeGCEAn59DAu2BCeI04O0RJuIRo8tM5uP2XMCkKBIwLNhpd
         MLHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV6KFn0JBLa5S3kBF+UDw6Xlyea+kRMaEzs4nnzsfDTqz607pPzJGxRLYMZo7PmtpO/IOkf5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlPPtjGOBfbIVxA+iZ87KG5wE0WdWw9/FetsCBfUBm+3J6oxGi
	YdMz8nwvT7PqAbkyr9eh1KcbdVxySgUpRAFQNxY6Gbl/ha4f4MGYCtbU
X-Gm-Gg: ASbGncvPUZCKznxdRUJQj+4BRmqHYH7A9+IykDp8/SRgPHXRFzs9aPcMI6Q0/p59JAa
	9xg3CDThke9CZcRdgp83soQ3QXXeo4cDGnyLCr8gptr4qboFj/rEDqOC7VUt0KFl2j1bM2BC6Ug
	6SXROi/SH680c7LlGS+p5mnhATo0ogonH9Xh71xcBDRLh+HB+HONk/X88m8KNQZMpyCvMx2CFg1
	ajE8PVeRFOenIw3sC3JGFW2VKLyt4K4rv4S7QqgdzI9m4f6Rt8JOKNkTkgbfmn8EtJb8JmN4OLF
	0KvbbVZmFajHtj99ZqGMYQcSD91/OeyqXoyEh+FuHV1a7Ot0v46ufjrtO0qdPWUjXbHlz0EiidT
	qNMSW1ewZXDB+tzXfv/R7Nb55TA4xkgj0G7E7cGnsSr+Hj9xzL+wN/qPPYmbWIYIuuj+OZG0=
X-Google-Smtp-Source: AGHT+IFt4JMwkbHAeDRH+Dl59b7w80xOYVWqcuo4WePcDsLt6VvfV3mFWwVaPjA3o9A7APxzKtcgQQ==
X-Received: by 2002:a05:600c:3b21:b0:46e:32d8:3f4f with SMTP id 5b1f17b1804b1-46e7115cf80mr8170935e9.8.1759486973128;
        Fri, 03 Oct 2025 03:22:53 -0700 (PDT)
Received: from [192.168.100.179] ([102.171.6.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e723593d8sm27790825e9.11.2025.10.03.03.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 03:22:52 -0700 (PDT)
Message-ID: <870cb6c9-3bd5-4251-8c61-7327b8a6f9f9@gmail.com>
Date: Fri, 3 Oct 2025 11:23:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/bpf: Add -Wsign-compare C compilation flag
To: David Laight <david.laight.linux@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, linux@jordanrome.com,
 ameryhung@gmail.com, toke@redhat.com, houtao1@huawei.com,
 emil@etsalapatis.com, yatsenko@meta.com, isolodrai@meta.com,
 a.s.protopopov@gmail.com, dxu@dxuuu.xyz, memxor@gmail.com,
 vmalik@redhat.com, bigeasy@linutronix.de, tj@kernel.org,
 gregkh@linuxfoundation.org, paul@paul-moore.com,
 bboscaccy@linux.microsoft.com, James.Bottomley@HansenPartnership.com,
 mrpre@163.com, jakub@cloudflare.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com
References: <20250924162408.815137-1-mehdi.benhadjkhelifa@gmail.com>
 <20250926124555.009bfcd6@pumpkin>
 <e3a0d8ff-d03d-4854-bf04-8ff8265b0257@gmail.com>
 <20251002200047.2b9f9ef9@pumpkin>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <20251002200047.2b9f9ef9@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/2/25 8:00 PM, David Laight wrote:
> On Mon, 29 Sep 2025 17:03:29 +0100
> Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com> wrote:
> 
>> On 9/26/25 12:45 PM, David Laight wrote:
>>> On Wed, 24 Sep 2025 17:23:49 +0100
>>> Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com> wrote:
>>>    
>>>> -Change all the source files and the corresponding headers
>>>> to having matching sign comparisons.
>>
>> Hi david,
>> sorry for the late reply.
>>
>>> 'Fixing' -Wsign-compare by adding loads of casts doesn't seem right.
>>> The only real way is to change all the types to unsigned ones.
>> The last v3 did only do that with no casting as it was suggested by
>> David too.
>>
>>> Consider the following:
>>> 	int x = read(fd, buf, len);
>>> 	if (x < 0)
>>> 		return -1;
>>> 	if (x > sizeof (struct fubar))
>>> 		return -1;
>>> That will generate a 'sign-compare' error, but min(x, sizeof (struct fubar))
>>> doesn't generate an error because the compiler knows 'x' isn't negative.
>>
>>    Yes,-Wsign-compare does add errors with -Werror enabled in that case
>> and many other cases where the code is perfectly fine which is one of
>> it's drawbacks.
>> Also I though that because of GCC/Clang heuristics
>> sometimes min() suppress the warning not because that the compiler knows
>> that x isn't negative.I'm probably wrong here.
> 
> That sentence doesn't make sense.
> The statically_true() test in min() uses the 'value' tracking done by modern
> versions of gcc and clang.
> This means it can let signed types be promoted to unsigned ones because the
> compiler knows the value isn't negative.
> OTOH -Wsign-compare is a much older warning and is only based on the types.

Ah, I Understand now. Didn't know about value tracking in modern 
compilers before.
>>> A well known compiler also rejects:
>>> 	unsigned char a;
>>> 	unsigned int b;
>>> 	if (b > a)
>>> 		return;
>>> because 'a' is promoted to 'signed int' before it does the check.
>>
>> In my knowledge,compilers don't necessarily reject the above code by
>> default. Since -Wall in GCC includes -Wsign-compare but -Wall in clang
>> doesn't, doing -Wall -Werror for clang compiler won't trigger an error
>> in the case above not even a warning.My changes are to make those
>> comparisons produce an error since the -Werror flag is already enabled
>> in the Makefile.
> 
> This isn't about whether -Wsign-compare is enabled or not (or even what
> the option is called).
> It is about whether the compiler's 'sign-compare' warning triggers for that code.
> The one that detects the warning/error isn't gcc or clang but is probably
> used far more than clang.
> 
Yes, -Wsign-compare will trigger a warning for that code. And an error 
if -Werror is enabled. And also yes, tools like sparse which I think is 
what you are referring to here would catch that warning as well.

>>
>>> So until the compilers start looking at the known domain of the value
>>> (not just the type) I enabling -Wsign-compare' is pretty pointless.
>>
>> I agree that enabling -Wsign-compare is pretty noisy. But it does have
>> some usefulness. Take for example this code:
>> 	int n = -5;
>> 	for (unsigned i = 0; i < n; i++) {
>>       	// ...
>> 	}
>> Since this is valid code by the compiler, it will allow it but n here is
>> promoted to an unsigned which converts -5 to being 4294967291 thus
>> making the loop run more than what was desired.of course,here the
>> example is much easy to follow and variables are very well set but the
>> point is that these could cause issues when hidden inside a lot of macro
>> code.
> 
> There is plenty of broken code out there.
> It isn't hard to find places where explicit casts make things worse.
> The problem is that, even for the above example, the -5 could come from
> way earlier up the code.
> If you 'fix' the warning by changing it to 'i < (unsigned)n' the code is
> still just as likely to be buggy.

Yes,But we aren't changing a buggy code. We are changing normal running 
code for the sake of future code to not have those bugs which wouldn't 
cause any issue (espacially when only changing variable types and not 
casting like in my V3 of this patch[1]).

> 
>>
>>> As a matter of interest did you actually find any bugs?
>>
>> No,I have not found any bug related to the current state of code in bpf
>> selftests but It works as a prevention mechanism for future bugs.Rather
>> than wait until something breaks in future code.
> 
> That's what I expected...
> 
I'm by no means trying to fix buggy code.Although I searched for bugs 
when changing before and after and found none. But as I said the patch 
is to prevent future bugs from occurring.
You think I should abort working on this since the benefit is minimal?
Regards,
Mehdi>>> 	David
>>>    
>>
>> Thank you for your time David.I would appreciate if you suggest on how I
>> can have a useful patch on this or if I should drop this.
>> Best Regards,
>> Mehdi
>>>    
>>>>
>>>> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
>>>> ---
>>>> As suggested by the TODO, -Wsign-compare was added to the C compilation
>>>> flags for the selftests/bpf/Makefile and all corresponding files in
>>>> selftests and a single file under tools/lib/bpf/usdt.bpf.h have been
>>>> carefully changed to account for correct sign comparisons either by
>>>> explicit casting or changing the variable type.Only local variables
>>>> and variables which are in limited scope have been changed in cases
>>>> where it doesn't break the code.Other struct variables or global ones
>>>> have left untouched to avoid other conflicts and opted to explicit
>>>> casting in this case.This change will help avoid implicit type
>>>> conversions and have predictable behavior.
>>>>
>>>> I have already compiled all bpf tests with no errors as well as the
>>>> kernel and have ran all the selftests with no obvious side effects.
>>>> I would like to know if it's more convinient to have all changes as
>>>> a single patch like here or if it needs to be divided in some way
>>>> and sent as a patch series.
>>>>
>>>> Best Regards,
>>>> Mehdi Ben Hadj Khelifa
>>> ...
>>
> 


