Return-Path: <netdev+bounces-185779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D19A9BB5C
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 01:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB094664F9
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 23:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F59E1F1520;
	Thu, 24 Apr 2025 23:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VJQg784L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118F628B4F2
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 23:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745537645; cv=none; b=pqabc38WpYf0hrrqCbgrk0Ry27jI9Y0yvozBv5jIC6pJEMXMRhJ3nKj5/FfmSAxN5fByjgmnuKnLnZ37WhhPxs6oDdihgkcoy9O1yW53H3RcM3bJ20WuPEeYFV7W9zAQYbcDaOdJNM898TK3AYMZ3ufb3IA6Gqagx3Sn0Hqxu5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745537645; c=relaxed/simple;
	bh=645Cr+11HOu7caSwajQ+fcQB6zjlFuO0uiN9ygi8GPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vBkdBtzNMF2Xs7AYtWwWqHDgK4oP9WYnWbDsZDxkBeS5MmgKnnUP9XFt2VipB1ARoOlechu1/nBqjuaCT4Z6MQoVWHRI0lx+/YkosI+nUmFyW+fzw6WxZ9UOgDh6GrbESaHoiy3FfBsFS7WxrQLGK1608Y0myav0w2f3sWWvRxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VJQg784L; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3cda56e1dffso9158355ab.1
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 16:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745537642; x=1746142442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WLSPdguY12OklzlGtECMN7dzaPzmkE8I+rLCggfy6Pw=;
        b=VJQg784LwPvzSfk4RcvtWjEXtz7PsyfeuKnNwEFjAANomevFvAip50wjfwzwV4T5BT
         EY9Escy0m/vi6R+qtvJVLStwzNTyJwcGd3jsXJAnooA0ajSlxBJBPjYlmutbKdDKpVrs
         91Cci7pTUpqo62C2lHvEU14tflDqRycAun4ic3e1AqU26Gl9IikGISAdfWO3yqDGh8EU
         EFYQESwQhK1hmQ5zprujmS3iAWF97U1ap2JZ+JBfo2TKoB6U28O6jFMCbPUMfjqOYwjv
         16cpU1MFsGNR1ZPelJjXaSBK/ueMS8wK9yJBOwoY4thCC/d57KWV+kIfyqT7Gq5GaIGD
         GCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745537642; x=1746142442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WLSPdguY12OklzlGtECMN7dzaPzmkE8I+rLCggfy6Pw=;
        b=NyWDxDlQCNyzefcNpv/VE5N8jzPzGkWNLnVuN1azYhnWVng9y24sm+4q8wdrSsDqsN
         foewPYvhqvKdG4tiYMkHL2aypqOxn+eATyhCDoNpwMylZrakEsN/BAzGTxGoFztR6SGm
         TqzUTVaBXYqE+wEFeUCe/ek/pL/daTPpyHLO7EqLDPjiit5DKV5PYdm44PjVNZ8UbUQB
         Lf2id88jY7euXKnh3861CXp4ttlvq2mrO/c19p/V8Z3OPWn4pD0GXBt97nmy+n4mh8VK
         Y4pClX5IH6BHBVS+r9DhXuJEPhodymg7F8s1B4WfG6NKqjnDDQpdQNGVF4WexKIkkcFH
         RZAg==
X-Forwarded-Encrypted: i=1; AJvYcCWwJZmqDt6VBhNmsjA+PGCFhsGSrguWCJ6WWPRXpCLkUZCJz++TWZOJHPpln9fpnJCUpNu/mGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgTdOhsHCSlbFRxsZW1RcFFS/r+cx6cV8hM1WoT9BIirInbSwa
	Fknkbdnf+o/FqeoPPmJHbi06+gHzm46SfkNNwIfSAWcq3xel8T2RTjCsjLO/AOM=
X-Gm-Gg: ASbGncvwVVYnVtPEI2lnFnTu2aEDvxIuaUSyBzeXJKj3HvA6OIeePf8iDwpXkVcgEnN
	0cgkFCSjMcbXttcVoHYjYNrwRiRN6rmQb7dOmSgRen7jUHhyy7gyc0Acu/mtIpZp2SyNuUm2V+n
	EoP+CVFAF60S+2N5IigJlypzjPS2Ze+7+Ni8oyXOpvD4kAwNjUec50orZ4n8tdsU5UQTsWnZePb
	/VY3rALIonas9lGh8cxlKmdv07NB1i6LqJ+FM1ZjhZcaLOjuoVM6iU39UIhqWav1CjHLLkKR1YZ
	p+dEIReAOw0g4NV4+3J2wuTn/TSELAgndQqU9w==
X-Google-Smtp-Source: AGHT+IHaXi2Gk8r4y/6xRxbhajXXa7YziQlK1Lp6d2KP4QYQkmwMHqQavhWqFld8XuKb8/iluMFHUQ==
X-Received: by 2002:a05:6e02:b24:b0:3d8:1a41:69a9 with SMTP id e9e14a558f8ab-3d93b453d9cmr2642865ab.12.1745537641971;
        Thu, 24 Apr 2025 16:34:01 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f824a3ba4fsm495331173.38.2025.04.24.16.34.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 16:34:01 -0700 (PDT)
Message-ID: <46deb974-5e60-477e-8f0c-9eb358369d73@kernel.dk>
Date: Thu, 24 Apr 2025 17:34:00 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] selftests: iou-zcrx: Get the page size at runtime
To: Jakub Kicinski <kuba@kernel.org>
Cc: io-uring@vger.kernel.org, Haiyue Wang <haiyuewa@163.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250419141044.10304-1-haiyuewa@163.com>
 <174553616879.1018402.4580438030053211278.b4-ty@kernel.dk>
 <20250424162923.3a0bdfc4@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250424162923.3a0bdfc4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/24/25 5:29 PM, Jakub Kicinski wrote:
> On Thu, 24 Apr 2025 17:09:28 -0600 Jens Axboe wrote:
>> On Sat, 19 Apr 2025 22:10:15 +0800, Haiyue Wang wrote:
>>> Use the API `sysconf()` to query page size at runtime, instead of using
>>> hard code number 4096.
>>>
>>> And use `posix_memalign` to allocate the page size aligned momory.
>>>
>>>   
>>
>> Applied, thanks!
>>
>> [1/1] selftests: iou-zcrx: Get the page size at runtime
>>       commit: 6f4cc653bf408ad0cc203c6ab3088b11f5da11df
> 
> Why are you applying this, Jens?

Nobody else had picked it up so far, and I already did the equivalent
one on the liburing side.
> 
> tools/testing/selftests/drivers/net/hw/iou-zcrx.c
>                         ^^^^^^^^^^^
> 
> This is a test which runs in netdev infra, and which we asked for.
> It was incorrectly initially routed via io-uring trees and then
> we had to deal with the breakage during the merge window because
> net/lib has diverged.

Come on, it was a one line conflict due to another added test, the
simplest of all conflicts. If that's "breakage" worth mentioning,
well...

> Please revert.

Sure, I can drop it. Doesn't matter to me, as long as gets merged.

-- 
Jens Axboe

