Return-Path: <netdev+bounces-126954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E12973624
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 13:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15E71C24387
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 11:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B63318C925;
	Tue, 10 Sep 2024 11:23:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E29F171671;
	Tue, 10 Sep 2024 11:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725967426; cv=none; b=Lp6DH4/2zfvX7/zJqj6jSV9gFPqHCPJ7ByGFslXmwdhNBueDX7BJgW3vE60phndpkRcWWXq/3bkNgu99GuitwS8a1RtweAaeXrdqlYOI8lzzw1WpywVTn0ct+OEimUVro2zmPDbmiwfMAMb7cLLxhZhPVxyOhqGOVh0KRFH9BRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725967426; c=relaxed/simple;
	bh=ZylxWksczSgEUECsADaiv61AwUrhoBUJsUxtli1fYTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gYSvZ2FDNjN8yNyQZ8tS97xVP8msIPqLedMGH75vCLZNoyRDoRH1SCu6mvgxj3jhGaaNcAkhh9p/VSPT3a6TNjCpdFwH7cO2rFIsJbE20u4/HMuNI8wQg8exy+d8adRrvJDXiTBgH5XYoFTKI4iTgd1i3lp1N0oRQ7tuDecfWDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4X31Wv3BP4z13wB7;
	Tue, 10 Sep 2024 19:22:35 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id B9E2A180AE6;
	Tue, 10 Sep 2024 19:23:40 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Sep 2024 19:23:39 +0800
Message-ID: <f2c219c8-0765-6942-8495-b5acf3756fb1@huawei.com>
Date: Tue, 10 Sep 2024 19:23:38 +0800
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
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

It seems more limited and is only used in timekeeping or
do_sys_settimeofday64().

And the timespec64_valid() is looser and wider used, which I think is
more appropriate here.

> 
> Thanks,
> Richard

