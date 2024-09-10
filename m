Return-Path: <netdev+bounces-126977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB92697375B
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 14:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B24C289B5C
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 12:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDBDB18A950;
	Tue, 10 Sep 2024 12:30:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE12188CB1;
	Tue, 10 Sep 2024 12:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725971429; cv=none; b=kt1PLn+epGl/NYf8/rN6nqTSeJknut/PcBUyMcxXJjvkm9eN6zFYo+t2fhd58F91JbFY/WGZLmjM81joiKUIJVgo7OxldS8RNTrLomeJcB9Q6GJWbfgksFPG/38RhNQ2aZS/a291eMVjH7bZAUdHp5bJDrU31utP0CXBYaujXb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725971429; c=relaxed/simple;
	bh=Urw6u8EdPl5oTOy8EOetqrp+LHS1jwg2yc+cH5bvHBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DBgxsPP+GzhVOUV2qMMF1yuIJvRefjhqpf3aoZ2dFBWHkst+V2Qa2d7QEAKsF/vDjUfU7RNTwcPLO3M0CE3ODPIv2bzM0L0q0S9j4jk10EQe5KQwR1q6l88fNdzd7OXSLtizcC6GrFXlrz43Rr+nkn/tsPn+gZKpScPD4JzNGaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X32y12lQDz1HJ6f;
	Tue, 10 Sep 2024 20:26:49 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 8119E1A016C;
	Tue, 10 Sep 2024 20:30:23 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Sep 2024 20:30:22 +0800
Message-ID: <1cae2765-65cc-7dc5-8321-76c8b7ef1b8c@huawei.com>
Date: Tue, 10 Sep 2024 20:30:22 +0800
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
 <f2c219c8-0765-6942-8495-b5acf3756fb1@huawei.com> <875xr3btou.ffs@tglx>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <875xr3btou.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/9/10 20:05, Thomas Gleixner wrote:
> On Tue, Sep 10 2024 at 19:23, Jinjie Ruan wrote:
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
>> It seems more limited and is only used in timekeeping or
>> do_sys_settimeofday64().
> 
> For a very good reason.
> 
>> And the timespec64_valid() is looser and wider used, which I think is
>> more appropriate here.
> 
> Can you please stop this handwaving and provide proper technical
> arguments?
> 
> Why would PTP have less strict requirements than settimeofday()?

I checked all the PTP driver, most of them use timespec64_to_ns()
convert them to ns which already have a check, but the others not check
them, and lan743x_ptp check them differently and more, so i think this
is a minimum check.

Use timespec64_to_ns()
- drivers/net/ethernet/amd/xgbe/xgbe-ptp.c
- drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c:
- drivers/net/ethernet/cavium/liquidio/lio_main.c:
- drivers/net/ethernet/engleder/tsnep_ptp.c
- drivers/net/ethernet/freescale/fec_ptp.c
- drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c:
- drivers/net/ethernet/intel/i40e/i40e_ptp.c
- drivers/net/ethernet/intel/ice/ice_ptp.c
- drivers/net/ethernet/intel/igc/igc_ptp.c
- drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
- drivers/net/ethernet/marvell/octeontx2/nic/otx2_ptp.c
- drivers/net/ethernet/qlogic/qede/qede_ptp.c
- drivers/ptp/ptp_idt82p33.c

Not check:
- drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
- drivers/net/ethernet/intel/igb/igb_ptp.c (only one igb_ptp_settime_i210())
- drivers/net/ethernet/marvell/mvpp2/mvpp2_tai.c
- drivers/net/ethernet/renesas/rcar_gen4_ptp.c
-
drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
- drivers/net/phy/micrel.c
- drivers/ptp/ptp_dfl_tod.c

Self check and check more:
- drivers/net/ethernet/microchip/lan743x_ptp.c

> 
> Thanks,
> 
>         tglx
> 
> 

