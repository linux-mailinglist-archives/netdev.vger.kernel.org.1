Return-Path: <netdev+bounces-127650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB5E975F4D
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 04:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A27A51C22B96
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 02:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA55B13D50A;
	Thu, 12 Sep 2024 02:53:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4653E13AA5D;
	Thu, 12 Sep 2024 02:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726109631; cv=none; b=Dh74Dc5OmizHPPY/KazbF8/NO2MqkiOskmoDC4oc9WUYjR3pNAcQ6XpssYOiOmKj/NSTaNTRFiPWeplSUXyzhroqfuJDvXRxIRhJnXfE9YfBvYU6IaBj7zuG7JxBLfzX9+kVR0ZLkW9mFj9A1TeXqygJjwcjdGfPwvXkxQw8Sjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726109631; c=relaxed/simple;
	bh=rKKjoUamE/k8TvE++nL1Z700qyaVlVKJjrxktWUMzkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tTpe3kxZ79vF9u8mnsJh8zvlNaOpyeoruukB7s70/qdyCAAPwv6M+VuKgxvzdYt5yf3A36xwpvqi0dfbU+dnVSuzXdPDddCijB+bMGz9RB6jL1lE8A6FgaB0vT+ON2l48pTuxlGNox0qOutgpFkBtZosNeuHj36gFpmbrmPkV88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X426Z5Q21zyR4n;
	Thu, 12 Sep 2024 10:52:38 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 7FF6D180064;
	Thu, 12 Sep 2024 10:53:46 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 12 Sep 2024 10:53:45 +0800
Message-ID: <ea351ea0-5095-d7ae-5592-ec3bd45c771c@huawei.com>
Date: Thu, 12 Sep 2024 10:53:44 +0800
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
To: Richard Cochran <richardcochran@gmail.com>
CC: <bryan.whitehead@microchip.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<anna-maria@linutronix.de>, <frederic@kernel.org>, <tglx@linutronix.de>,
	<UNGLinuxDriver@microchip.com>, <mbenes@suse.cz>, <jstultz@google.com>,
	<andrew@lunn.ch>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240909074124.964907-1-ruanjinjie@huawei.com>
 <20240909074124.964907-2-ruanjinjie@huawei.com>
 <Zt8SFUpFp7JDkNbM@hoboy.vegasvil.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <Zt8SFUpFp7JDkNbM@hoboy.vegasvil.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/9/9 23:19, Richard Cochran wrote:
> On Mon, Sep 09, 2024 at 03:41:23PM +0800, Jinjie Ruan wrote:
>> diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
>> index 1cc830ef93a7..34deec619e17 100644
>> --- a/kernel/time/posix-timers.c
>> +++ b/kernel/time/posix-timers.c
>> @@ -1137,6 +1137,9 @@ SYSCALL_DEFINE2(clock_settime, const clockid_t, which_clock,
>>  	if (get_timespec64(&new_tp, tp))
>>  		return -EFAULT;
>>  
>> +	if (!timespec64_valid(&new_tp))
>> +		return -ERANGE;
> 
> Why not use timespec64_valid_settod()?

There was already checks in following code, so it is not necessary to
check NULL or timespec64_valid() in ptp core and its drivers, only the
second patch is needed.

169 int do_sys_settimeofday64(const struct timespec64 *tv, const struct
timezone *tz)
 170 {
 171 >-------static int firsttime = 1;
 172 >-------int error = 0;
 173
 174 >-------if (tv && !timespec64_valid_settod(tv))
 175 >------->-------return -EINVAL;



> 
> Thanks,
> Richard

