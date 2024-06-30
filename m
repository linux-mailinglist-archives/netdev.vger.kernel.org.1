Return-Path: <netdev+bounces-107950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4EC91D23B
	for <lists+netdev@lfdr.de>; Sun, 30 Jun 2024 17:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2F51F21386
	for <lists+netdev@lfdr.de>; Sun, 30 Jun 2024 15:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02EF15279A;
	Sun, 30 Jun 2024 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BO+S1cBi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com [209.85.166.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AC237169;
	Sun, 30 Jun 2024 15:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719759943; cv=none; b=L39EdIDssg2bU+YWMJ3mQwO6gqIP5QspbbwV9RiNO/TG+GS1s2ZKUMvIag2GwTigS9JbsgYiL/G9v7AOg7bX8dkqTTvvAc83SjqGN8Mhi7SANrIAb61UjJ3QB55V2nfU++a7W/g4tQ9Wi9++WMJsPqmVrmHSIO/daJqmZuVib7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719759943; c=relaxed/simple;
	bh=dx3OCP5t7t92Mf5fN+e5eNI51y+3HJQnWDn1nZMKnVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eU12bj/XB5x5QqXp842cjWrUi64MxWRA08zxHBojVG9I8IJ/N+JrYReFaRorZc5L39YLvzsRJ39cN+tulR5w66dafx7tAtxv1wvUVauCEAg9+uyJg2irbHol5wTLCK1qQwuT2Uac9NTUIrTPLOXz16oSqbf73Y5Q2ZvS0Ky5oFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BO+S1cBi; arc=none smtp.client-ip=209.85.166.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f194.google.com with SMTP id e9e14a558f8ab-375f5c3ddb1so9742445ab.1;
        Sun, 30 Jun 2024 08:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719759941; x=1720364741; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pW+jLLcRjyIRN35ybG3Xi0qa84JdPP0aoNcuOxSBAw=;
        b=BO+S1cBiFS4SAQojPOyLtKPl9SPT0fCwHnNC7UNGUtT51YeWtaHKyF30rkg4EiYVTS
         JNi+JaUEOvQqvtWaGXgw7AsBY4V29itLAnvUZRw0Q7mgd59zt120cA3aVsLXSVsPfOVL
         MTPDMkFmveaj6jRIERi/aCOPjmCdT0VDf5/glnla6K5QylDwhJxWwkn3TeIqJFxfS9Df
         PNhXkRx0NYFr5WZF03zeCeqEq/BetPBkFZBAAsbmbNXF2Rdbqpsqjs9f26PZvCMxiEWD
         Il1246+kZ9/AXJgG9xI7bK0DbTK6H6RKTx0mgTOF53iVLZ2y4V/xqQIaqikw6VXTMdwp
         /jog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719759941; x=1720364741;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8pW+jLLcRjyIRN35ybG3Xi0qa84JdPP0aoNcuOxSBAw=;
        b=DWtJuuemQ5PdrpazKA0f5RE6esRFVAtEd27xeYLhpPw77urQU6p66XU6J776AaT9z0
         HVKO+9JvK8nN28YUcNZ7BqK8hO4wJhZKPpbh8bvzjE4R9LFlcATc6Eb6ywrXYHQuNYj2
         CJHL+29f2ZseDljgk1WeAAGIU1uz+xwYZnskg+yWYo+Dt2I6vlYYTgV7Vsg4ccht7zRz
         /iXxrsYHBsqyvjHzmTwHMZy1HLF+w4z1GUAy95WlyV6x67MgWdffD/5f6nH2vxiKQLOy
         hosr2/Qk4SC1AP9tjG9N5HXrZxOj+zO8XD7xc2Ves3uaJ12o7FYsVXcvkXQ9CSkWktNw
         Jkdw==
X-Forwarded-Encrypted: i=1; AJvYcCU6u1sxUTIvOFarxGJMNo9UV3iIiIAx+sjtc0hQbvdVo++7crKjdWtQMmXo6dgIeZrRhmzlABdbiRoLwFiIB08BqONmeMlStIds7l79yS0SSc68qQ/X0OWYVDeid7A05eY0Jzwk
X-Gm-Message-State: AOJu0YzGzNHnfzZjBTyDSHX18uYGP2AIvUyQyfk+KQlR7pW/yX+8sTwy
	CkduK5NoLrLsgZItKBU0feJGushIfO4r9Zzwj4Yjjc7Up+ZTvs01
X-Google-Smtp-Source: AGHT+IHwHse3in2PkiQPU0Xyop/sYo1K4tQUV+09TypRGky1b2Wvq0lTqu+sx/7oBcNPcDVIxVvMAw==
X-Received: by 2002:a05:6e02:2168:b0:374:a176:e26e with SMTP id e9e14a558f8ab-37cd3498a70mr33419805ab.31.1719759941163;
        Sun, 30 Jun 2024 08:05:41 -0700 (PDT)
Received: from ?IPV6:2409:8a55:301b:e120:19b7:87b2:860d:6c8d? ([2409:8a55:301b:e120:19b7:87b2:860d:6c8d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708044ac419sm4779020b3a.164.2024.06.30.08.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jun 2024 08:05:40 -0700 (PDT)
Message-ID: <15623dac-9358-4597-b3ee-3694a5956920@gmail.com>
Date: Sun, 30 Jun 2024 23:05:34 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 10/13] mm: page_frag: introduce
 prepare/probe/commit API
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org
References: <20240625135216.47007-1-linyunsheng@huawei.com>
 <20240625135216.47007-11-linyunsheng@huawei.com>
 <33c3c7fc00d2385e741dc6c9be0eade26c30bd12.camel@gmail.com>
 <38da183b-92ba-ce9d-5472-def199854563@huawei.com>
 <CAKgT0Ueg1u2S5LJuo0Ecs9dAPPDujtJ0GLcm8BTsfDx9LpJZVg@mail.gmail.com>
 <0a80e362-1eb7-40b0-b1b9-07ec5a6506ea@gmail.com>
 <CAKgT0UcRbpT6UFCSq0Wd9OHrCqOGR=BQ063-zNBZ4cVNmduZGw@mail.gmail.com>
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <CAKgT0UcRbpT6UFCSq0Wd9OHrCqOGR=BQ063-zNBZ4cVNmduZGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/30/2024 10:35 PM, Alexander Duyck wrote:
> On Sun, Jun 30, 2024 at 7:05 AM Yunsheng Lin <yunshenglin0825@gmail.com> wrote:
>>
>> On 6/30/2024 1:37 AM, Alexander Duyck wrote:
>>> On Sat, Jun 29, 2024 at 4:15 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> ...
>>
>>>>>
>>>>> Why is this a macro instead of just being an inline? Are you trying to
>>>>> avoid having to include a header due to the virt_to_page?
>>>>
>>>> Yes, you are right.
> 
> ...
> 
>>> I am pretty sure you just need to add:
>>> #include <asm/page.h>
>>
>> I am supposing you mean adding the above to page_frag_cache.h, right?
>>
>> It seems thing is more complicated for SPARSEMEM_VMEMMAP case, as it
>> needs the declaration of 'vmemmap'(some arch defines it as a pointer
>> variable while some arch defines it as a macro) and the definition of
>> 'struct page' for '(vmemmap + (pfn))' operation.
>>
>> Adding below for 'vmemmap' and 'struct page' seems to have some compiler
>> error caused by interdependence between linux/mm_types.h and asm/pgtable.h:
>> #include <asm/pgtable.h>
>> #include <linux/mm_types.h>
>>
> 
> Maybe you should just include linux/mm.h as that should have all the
> necessary includes to handle these cases. In any case though it

Including linux/mm.h seems to have similar compiler error, just the
interdependence is between linux/mm_types.h and linux/mm.h now.

As below, linux/mmap_lock.h obviously need the definition of
'struct mm_struct' from linux/mm_types.h, and linux/mm_types.h
has some a long dependency of linux/mm.h starting from
linux/uprobes.h if we add '#include <linux/mm.h>' in 
linux/page_frag_cache.h:

In file included from ./include/linux/mm.h:16,
                  from ./include/linux/page_frag_cache.h:6,
                  from ./include/linux/sched.h:49,
                  from ./include/linux/percpu.h:13,
                  from ./arch/x86/include/asm/msr.h:15,
                  from ./arch/x86/include/asm/tsc.h:10,
                  from ./arch/x86/include/asm/timex.h:6,
                  from ./include/linux/timex.h:67,
                  from ./include/linux/time32.h:13,
                  from ./include/linux/time.h:60,
                  from ./include/linux/jiffies.h:10,
                  from ./include/linux/ktime.h:25,
                  from ./include/linux/timer.h:6,
                  from ./include/linux/workqueue.h:9,
                  from ./include/linux/srcu.h:21,
                  from ./include/linux/notifier.h:16,
                  from ./arch/x86/include/asm/uprobes.h:13,
                  from ./include/linux/uprobes.h:49,
                  from ./include/linux/mm_types.h:16,
                  from ./include/linux/mmzone.h:22,
                  from ./include/linux/gfp.h:7,
                  from ./include/linux/slab.h:16,
                  from ./include/linux/crypto.h:17,
                  from arch/x86/kernel/asm-offsets.c:9:
./include/linux/mmap_lock.h: In function ‘mmap_assert_locked’:
./include/linux/mmap_lock.h:65:30: error: invalid use of undefined type 
‘const struct mm_struct’
    65 |         rwsem_assert_held(&mm->mmap_lock);
       |                              ^~

> doesn't make any sense to have a define in one include that expects
> the user to then figure out what other headers to include in order to
> make the define work they should be included in the header itself to
> avoid any sort of weird dependencies.

Perhaps there are some season why there are two headers for the mm 
subsystem, linux/mm_types.h and linux/mm.h?
And .h file is supposed to include the linux/mm_types.h while .c file
is supposed to include the linux/mm.h?
If the above is correct, it seems the above rule is broked by including 
linux/mm.h in linux/page_frag_cache.h.

