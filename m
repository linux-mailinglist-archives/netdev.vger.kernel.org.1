Return-Path: <netdev+bounces-125798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8009A96EACB
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 08:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B0C31F256F3
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 06:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3283B1A2;
	Fri,  6 Sep 2024 06:38:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F3F13D243
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 06:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725604685; cv=none; b=sbZY9JnoKWAxWlK5Hwwz07eFfM0eJ4hOJhPfy49E3VmLUj7D4dSeUdHY/wutiS1WJVkk+J7dCGrxlG6jPluQ2RDlA6TARpsvXksubkDRCcX9COjbatORJxYSxc4kT6SPsnbWkJdpELYyrGHkjsdEj9ypNm77vvhh9J6pQU8QhH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725604685; c=relaxed/simple;
	bh=VVOG/dGCZSM+hPknlRWAhqkCS6XDASA+Ux6JBDbSUqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a0mh8g+vb/sbnwqFQADinIAdHSNIRkpskQaTtuGY9lWJHE5Nt3kZQOnfeQg7l9TjlGijrfFfYr0rJmw3KSOnmokwSuNmC+W7eSsJ43zj/01O3ksdnYttb0mO6bkVd4QrkUlbnhb02ohLeh/bDJz4L/8LwEr+DrFmaHKkc4tYExg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X0RHd2xlpz20nYT;
	Fri,  6 Sep 2024 14:33:01 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 784CC1402CD;
	Fri,  6 Sep 2024 14:38:00 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Sep 2024 14:37:59 +0800
Message-ID: <3815e749-a642-d5f3-7503-ee9d04a63938@huawei.com>
Date: Fri, 6 Sep 2024 14:37:58 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next v2 1/2] ptp: Check timespec64 before call
 settime64()
Content-Language: en-US
To: Richard Cochran <richardcochran@gmail.com>
CC: <bryan.whitehead@microchip.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>, <netdev@vger.kernel.org>
References: <20240906034806.1161083-1-ruanjinjie@huawei.com>
 <20240906034806.1161083-2-ruanjinjie@huawei.com>
 <ZtqEtVBEQQEp5gPV@hoboy.vegasvil.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <ZtqEtVBEQQEp5gPV@hoboy.vegasvil.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/9/6 12:27, Richard Cochran wrote:
> On Fri, Sep 06, 2024 at 11:48:05AM +0800, Jinjie Ruan wrote:
> 
>> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
>> index c56cd0f63909..cf75899a6681 100644
>> --- a/drivers/ptp/ptp_clock.c
>> +++ b/drivers/ptp/ptp_clock.c
>> @@ -100,6 +100,16 @@ static int ptp_clock_settime(struct posix_clock *pc, const struct timespec64 *tp
>>  		return -EBUSY;
>>  	}
>>  
>> +	if (!tp) {
>> +		pr_warn("ptp: tp == NULL\n");
>> +		return -EINVAL;
>> +	}
> 
> This check is pointless because `tp` cannot be null.

Yes, this one is unnecessary and it is also unnecessary in the
lan743x_ptpci_settime64().

> 
> See SYSCALL_DEFINE2(clock_settime, ...)
> 
>> +	if (!timespec64_valid(tp)) {
>> +		pr_warn("ptp: tv_sec or tv_usec out of range\n");
>> +		return -ERANGE;
>> +	}
> 
> Shouldn't this be done at the higher layer, in clock_settime() ?

Maybe it is more reasonable?

> 
> Thanks,
> Richard

