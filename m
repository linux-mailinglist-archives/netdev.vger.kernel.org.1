Return-Path: <netdev+bounces-128314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E573D978F50
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 11:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34853B245E2
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 09:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914C61369BC;
	Sat, 14 Sep 2024 09:00:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CE04C80;
	Sat, 14 Sep 2024 09:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726304452; cv=none; b=AYPyJbJfWtLUzBmuAv7ZBC1rjQVLwwIQm4mIJPEEZ8owHK2Mx23vdWEI87lOuAS570L1YGP+MEa5yKYY3AlrfqUdtiSG94qpDIUF57RRUwGJ2wmlbd1QIMoy/qDXXvQhrHDUqwYFJ0dEp9LgpqFR3Zdyk7Q8XuLCMMeQyJYIfBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726304452; c=relaxed/simple;
	bh=eKOQYWLXaPne6jFaVaOzWLjZsel1T4Pgwevi6Fg7Khg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pMfqz/pVkjQrTDV+k5HlD8D9U+kHqBi1tXl3HeJT4OY2NS6br2mdWsASb708m8HWTOws2gmkvFfcooiRQ+KEEEnp1PqZfc0UV77uJYQJ9nqj82dmg6EAZkmzVYMkqZpq9UrLpqwnPxRJgavvcZ5P/+BKrq7b/CzJ559GkiuoIR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4X5Q7v2bRzzfc9N;
	Sat, 14 Sep 2024 16:58:35 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 494F214035F;
	Sat, 14 Sep 2024 17:00:47 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 14 Sep 2024 17:00:46 +0800
Message-ID: <315a63f5-712e-c6a0-c447-9dd70253e3aa@huawei.com>
Date: Sat, 14 Sep 2024 17:00:45 +0800
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
 <46efd1be-688e-ecd0-a9e1-cf5f69d0110f@huawei.com> <87v7yz96gr.ffs@tglx>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <87v7yz96gr.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/9/13 18:46, Thomas Gleixner wrote:
> On Thu, Sep 12 2024 at 20:24, Jinjie Ruan wrote:
>> On 2024/9/12 20:04, Thomas Gleixner wrote:
>>> How does this code validate timespecs for clock_settime(clockid) where
>>> clockid != CLOCK_REALTIME?
>>
>> According to the man manual of clock_settime(), the other clockids are
>> not settable.
>>
>> And in Linux kernel code, except for CLOCK_REALTIME which is defined in
>> posix_clocks array, the clock_set() hooks are not defined and will
>> return -EINVAL in SYSCALL_DEFINE2(clock_settime), so the check is not
>> necessary.
> 
> You clearly understand the code you are modifying:
> 
> const struct k_clock clock_posix_dynamic = {
> 	.clock_getres           = pc_clock_getres,
>         .clock_set              = pc_clock_settime, 
> 
> which is what PTP clocks use and that's what this is about, no?

Yes, it uses the dynamic one rather than the static ones.

> 
> Thanks,
> 
>         tglx

