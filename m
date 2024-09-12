Return-Path: <netdev+bounces-127802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB823976916
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 14:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41584B217AE
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 12:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE431A42B2;
	Thu, 12 Sep 2024 12:25:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D862B1A3A96;
	Thu, 12 Sep 2024 12:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726143907; cv=none; b=YTPSzbEez5ErrjOETBJgbs6vE5ZbQksMdk27OjvYjCC8i+C4UC4m3UVJL3JrnVgk2z52j9kx9ud057pn7YpNi9mEb311v7DGzWyjn/DNql+5GBvng/KowsRdzdlvRfAjyVbEJiUAVHmZ2+KUjHAgXc7efsz078L8Rw4nS8C5VzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726143907; c=relaxed/simple;
	bh=AMuIaVSJHzuWYwJl7hvZoXf7g9cTP2qfMqoenAkyZYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Bg6Pl3bMyehKPlIfQ90lBihibvdbjw4L9v7/6J8mIMZVK+yieHIVmRsk6OjthgPYRbrFiFlq2/ZTwAS3Bg28nuvDIckmVgQ6/EBN8D7sV3l/eTQyrwP7GYmxWYqDOHnRPv/6SgFzIFf1H/l6nA5KNoPihQXmnRbyJ1W9QDI2+1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X4GpP2lFtz1j8Tj;
	Thu, 12 Sep 2024 20:24:29 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id E00AC14013B;
	Thu, 12 Sep 2024 20:24:59 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 12 Sep 2024 20:24:59 +0800
Message-ID: <46efd1be-688e-ecd0-a9e1-cf5f69d0110f@huawei.com>
Date: Thu, 12 Sep 2024 20:24:58 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next v3 1/2] posix-timers: Check timespec64 before call
 clock_set()
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, Richard Cochran
	<richardcochran@gmail.com>
CC: <bryan.whitehead@microchip.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<anna-maria@linutronix.de>, <frederic@kernel.org>,
	<UNGLinuxDriver@microchip.com>, <mbenes@suse.cz>, <jstultz@google.com>,
	<andrew@lunn.ch>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240909074124.964907-1-ruanjinjie@huawei.com>
 <20240909074124.964907-2-ruanjinjie@huawei.com>
 <Zt8SFUpFp7JDkNbM@hoboy.vegasvil.org>
 <ea351ea0-5095-d7ae-5592-ec3bd45c771c@huawei.com> <874j6l9ixk.ffs@tglx>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <874j6l9ixk.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/9/12 20:04, Thomas Gleixner wrote:
> On Thu, Sep 12 2024 at 10:53, Jinjie Ruan wrote:
> 
>> On 2024/9/9 23:19, Richard Cochran wrote:
>>> On Mon, Sep 09, 2024 at 03:41:23PM +0800, Jinjie Ruan wrote:
>>>> diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
>>>> index 1cc830ef93a7..34deec619e17 100644
>>>> --- a/kernel/time/posix-timers.c
>>>> +++ b/kernel/time/posix-timers.c
>>>> @@ -1137,6 +1137,9 @@ SYSCALL_DEFINE2(clock_settime, const clockid_t, which_clock,
>>>>  	if (get_timespec64(&new_tp, tp))
>>>>  		return -EFAULT;
>>>>  
>>>> +	if (!timespec64_valid(&new_tp))
>>>> +		return -ERANGE;
>>>
>>> Why not use timespec64_valid_settod()?
>>
>> There was already checks in following code, so it is not necessary to
>> check NULL or timespec64_valid() in ptp core and its drivers, only the
>> second patch is needed.
>>
>> 169 int do_sys_settimeofday64(const struct timespec64 *tv, const struct
>> timezone *tz)
>>  170 {
>>  171 >-------static int firsttime = 1;
>>  172 >-------int error = 0;
>>  173
>>  174 >-------if (tv && !timespec64_valid_settod(tv))
>>  175 >------->-------return -EINVAL;
> 
> How does this code validate timespecs for clock_settime(clockid) where
> clockid != CLOCK_REALTIME?

According to the man manual of clock_settime(), the other clockids are
not settable.

And in Linux kernel code, except for CLOCK_REALTIME which is defined in
posix_clocks array, the clock_set() hooks are not defined and will
return -EINVAL in SYSCALL_DEFINE2(clock_settime), so the check is not
necessary.

> 
> Thanks,
> 
>         tglx

