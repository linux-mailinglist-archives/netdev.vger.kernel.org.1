Return-Path: <netdev+bounces-169834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7EAA45E0D
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 13:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8346D168A9D
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 12:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2080E19259A;
	Wed, 26 Feb 2025 12:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="MEfhioKc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF04E258CD0
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 12:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571221; cv=none; b=a7nUsdLx42+k3KURuUhPAJH+VQwZMBl5OOmzF2In43wE/a2WD9FkIbyhBS0usruRUiSs4gz5Rteho5lzUKyAATkMX72bbWUyDfhmYMnHqUz4J3nLjthUDMywTxMSiis1y83vmGmeo4aFrgokHUdtxcUs9olmcXlXFJ/5ELO8Yqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571221; c=relaxed/simple;
	bh=er1Ww+9tyyTFAXp8hSUNX19VPi7rncOd1/8Keq3RpDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kbw2PEf91hTHu0z4ImMiwYQOOcQNgs6TNtJBJWprhrVybPtUEbMajz+PUOG+ffn8YsHzPfLp4R/cJyj4mLC0bN5qWUzpAYIUP1crJuQVYeBbM95WxSaGLt50/VXV9LmBw1oEoO6QlhGwRytBJ4TVQiBgYUUr7+k0I/Qk/RzBF+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=MEfhioKc; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e095d47a25so12304525a12.0
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 04:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1740571216; x=1741176016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CH6e+f5O+dsI1InOjSydazsysZESkO1ORdvNZDtHKnk=;
        b=MEfhioKcgAEo8Z2rqBYXecA7HD1Jx8XfRqgYHS0M7U7vVzt0GFtTh8iYb52/D/knWA
         r/8Q+YLWswUZHkdDrEdkeLtJGXEFkD+qR9L+945YxJqBO8G/L6cZDMdvZnmr4hfB0fhU
         DdaqIVEBl5lc1Sa4EDBFiyxOaIRWMd38b7SFs6Fy8C/c0BOGAy4QfPWZzFCXS7bXyxKw
         pg+RAoHZqWWk9LUvg2rcNZqp7TqNAMtCxMrayg+39MIcqPzGe0O4TUxb3qAVpEUBhkrI
         WjYvBl0JRwBx1pY0JTfKjdJeEpS4PDYVHdIYJZjBeDXgLOEN/5VAcmjJD2I1t6itVrZv
         zyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740571216; x=1741176016;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CH6e+f5O+dsI1InOjSydazsysZESkO1ORdvNZDtHKnk=;
        b=DN4xjZ6bsWoDfWloeWQ1fUJdxfHetro5JDkqgPIsemAPumlnYAwNuJppH/2bgIG/G1
         Tz3Y8KFZDTivOC4Xvy+G4kLpGB7K1ObxDrGrZyltJdba6GbLk0Zt/lT6PPQMsbt4ugvc
         oTib5xloHH8j3GamX6cUQkgJgOl4qJ2XV3DYmAO/KFSuoQJJK1Z5Z+xjPyAT8GUbUQna
         XsB2+GPqF0KessiMPFYFqYrUUA8g82DQ4FLlQ4hnOik/4U17UIIIXaticGM+qdKh8yN9
         JXx67NucboV+OjLNp0w4GEWtofCZkTTT1OnvLQyStEALCv4xr/pOJkJyur6xt8Fy8wpb
         h4AA==
X-Forwarded-Encrypted: i=1; AJvYcCWiZw9OWZqfiK3ruDRt5clybd4LU+W2/s7arewdLh68Zz76OmTIOnS22bl7lg46q/bI7KsaQ3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoIz5RhcC2mAlmIIkkAh9d2vzADA5PiJMnopRXAr0GxL1urL6M
	bEfUveO00q8VoQr20IBnz1+mOxkezee5xvUFpanrbnSDcpTOa9kPtskmh2qsGjvWhwu+LfRYn5+
	U
X-Gm-Gg: ASbGncuK0kEhatnQGaw3zPqvhaZxCABQRglFb1SohFVHRSxqHjwBZHFDDCnAbQ97CcS
	aQfCzMfsde7TBsMdFCCKq8yY0B7pDrYfAjS7G5PUmSE/ZRrF2lTG+L+l278XngQncOYwFP00wHE
	3mDBhESu2+N3i9ttS9ePrI3AXfhMhM4NWkU8e69+685s7Y6wo0v3SP0MC/trby+6eJD/68+03gV
	0ZQd/BnfCrBqYiRKH8NeD31sGsu/1Mu2M5pU6U9JTAer3QjzLeqjqRaXcObb11lyOYAQ/pHpGFG
	MF0Mo+3aPUqOpf5nLNEvoRwan+u8g5j4F2G2K09+ClmF7YOSWUJRj0EC5Q==
X-Google-Smtp-Source: AGHT+IGplmOUv11HYnINOeH5sEwVT7SLeB09pZLQYiAZ6MnTV77r6NQHr5JSXaRwvS8VPhSiHYcznQ==
X-Received: by 2002:a05:6402:50c7:b0:5e0:90b5:a06e with SMTP id 4fb4d7f45d1cf-5e0b70bbf5bmr21415238a12.7.1740571215545;
        Wed, 26 Feb 2025 04:00:15 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e462127029sm2725233a12.78.2025.02.26.04.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 04:00:14 -0800 (PST)
Message-ID: <ed6723e3-4e47-4dac-bc42-b65f7d42cbea@blackwall.org>
Date: Wed, 26 Feb 2025 14:00:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [6.12.15][be2net?] Voluntary context switch within RCU read-side
 critical section!
To: Ian Kumlien <ian.kumlien@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Linux Kernel Network Developers <netdev@vger.kernel.org>
References: <CAA85sZveppNgEVa_FD+qhOMtG_AavK9_mFiU+jWrMtXmwqefGA@mail.gmail.com>
 <CAA85sZuv3kqb1B-=UP0m2i-a0kfebNZy-994Dw_v5hd-PrxEGw@mail.gmail.com>
 <20250225170545.315d896c@kernel.org>
 <CAA85sZuYbXDKAEHpXxcDvntSjtkDEBGxU-FbXevZ+YH+eL6bEQ@mail.gmail.com>
 <CAA85sZswKt7cvogeze4FQH_h5EuibF0Zc7=OAS18FxXCiEki-g@mail.gmail.com>
 <a6753983-df29-4d79-a25c-e1339816bd02@blackwall.org>
 <CAA85sZsSTod+-tS1CuB+iZSfAjCS0g+jx+1iCEWxh2=9y-M7oQ@mail.gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <CAA85sZsSTod+-tS1CuB+iZSfAjCS0g+jx+1iCEWxh2=9y-M7oQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/26/25 13:52, Ian Kumlien wrote:
> On Wed, Feb 26, 2025 at 11:33 AM Nikolay Aleksandrov
> <razor@blackwall.org> wrote:
>>
>> On 2/26/25 11:55, Ian Kumlien wrote:
>>> On Wed, Feb 26, 2025 at 10:24 AM Ian Kumlien <ian.kumlien@gmail.com> wrote:
>>>>
>>>> On Wed, Feb 26, 2025 at 2:05 AM Jakub Kicinski <kuba@kernel.org> wrote:
>>>>>
>>>>> On Tue, 25 Feb 2025 11:13:47 +0100 Ian Kumlien wrote:
>>>>>> Same thing happens in 6.13.4, FYI
>>>>>
>>>>> Could you do a minor bisection? Does it not happen with 6.11?
>>>>> Nothing jumps out at quick look.
>>>>
>>>> I have to admint that i haven't been tracking it too closely until it
>>>> turned out to be an issue
>>>> (makes network traffic over wireguard, through that node very slow)
>>>>
>>>> But i'm pretty sure it was ok in early 6.12.x - I'll try to do a bisect though
>>>> (it's a gw to reach a internal server network in the basement, so not
>>>> the best setup for this)
>>>
>>> Since i'm at work i decided to check if i could find all the boot
>>> logs, which is actually done nicely by systemd
>>> first known bad: 6.11.7-300.fc41.x86_64
>>> last known ok: 6.11.6-200.fc40.x86_64
>>>
>>> Narrows the field for a bisect at least, =)
>>>
>>
>> Saw bridge, took a look. :)
>>
>> I think there are multiple issues with benet's be_ndo_bridge_getlink()
>> because it calls be_cmd_get_hsw_config() which can sleep in multiple
>> places, e.g. the most obvious is the mutex_lock() in the beginning of
>> be_cmd_get_hsw_config(), then we have the call trace here which is:
>> be_cmd_get_hsw_config -> be_mcc_notify_wait -> be_mcc_wait_compl -> usleep_range()
>>
>> Maybe you updated some tool that calls down that path along with the kernel and system
>> so you started seeing it in Fedora 41?
> 
> Could be but it's pretty barebones
> 
>> IMO this has been problematic for a very long time, but obviously it depends on the
>> chip type. Could you share your benet chip type to confirm the path?
> 
> I don't know how to find the actual chip information but it's identified as:
> Emulex Corporation OneConnect NIC (Skyhawk) (rev 10)
> 

Good, that confirms it. The skyhawk chip falls in the "else" of the block in
be_ndo_bridge_getlink() which calls be_cmd_get_hsw_config().

>> For the blamed commit I'd go with:
>>  commit b71724147e73
>>  Author: Sathya Perla <sathya.perla@broadcom.com>
>>  Date:   Wed Jul 27 05:26:18 2016 -0400
>>
>>      be2net: replace polling with sleeping in the FW completion path
>>
>> This one changed the udelay() (which is safe) to usleep_range() and the spinlock
>> to a mutex.
> 
> So, first try will be to try without that patch then, =)
> 

That would be a good try, yes. It is not a straight-forward revert though since a lot
of changes have happened since that commit. Let me know if you need help with that,
I can prepare the revert to test.

>> Cheers,
>>  Nik
>>


