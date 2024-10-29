Return-Path: <netdev+bounces-140111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C79E59B543B
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 21:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEA3D1C22378
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 20:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743762076CE;
	Tue, 29 Oct 2024 20:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ww1vF0jl"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D7A19A2A2
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 20:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234508; cv=none; b=McH30VrzIdGeT6ES4ts65w3oYSIYr786AIxlNzql88h3KM6QHqbgEuBk0SgzeQfHDvTLhEowF/PJk7O7+b309U7cv5yvT8dPKK2jxYuHhLEou6E2FibqclnUKFtxRUjdLpbUL54r4ExYDT2cevWZ06T7OYJgEGE7/GBMd198uYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234508; c=relaxed/simple;
	bh=kTzbU6ETHAvLuzBySXO+cuBVPMHnm/kJqVL+rpbolfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ljL9BxedNsvFZkhhfJwg/UjhdgHvNbiKp7afI6N0dAu2pym4rzXzSbO+p5VN3T8aUUOZr1Qu8FX3tH9tf6xHXugikLg5lD47UF9UNkB4mvBZxwrdxFW51f/c8k9e21lN01fcNf1eQ6U00y3TwTZP/HbjxgAoowC67mWg/vXELPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ww1vF0jl; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2a538f3b-d66f-4fe2-a08e-0f852befb350@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730234503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qd/YeWYgCCFiw+ssPRNplrMtnQCmKC+iT84HL4A0XnY=;
	b=Ww1vF0jlF+Gqf7xoj1PL/FbwuJ2YEdWsnQ+GEfGQbwGze+YMmKP7dpPVqYq7PT5VQC+cpC
	KU92KVQAW8u7V8hjh7Sj4ySGzSkYOuzAqh5rFbqd4NbG1c6tfMGwyYlFQ2EMgv6AVDjDPe
	i92pwKbvWRmmStHAIK5fYNXjcSKnQI4=
Date: Tue, 29 Oct 2024 20:41:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 2/2] bnxt_en: replace PTP spinlock with
 seqlock
To: Michael Chan <michael.chan@broadcom.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, Jakub Kicinski
 <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>
References: <20241028185723.4065146-1-vadfed@meta.com>
 <20241028185723.4065146-2-vadfed@meta.com>
 <CACKFLimm96szzQd5AowWy-sQyfCKdoBCLgr5P68vOn6n0WKjWQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CACKFLimm96szzQd5AowWy-sQyfCKdoBCLgr5P68vOn6n0WKjWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 29/10/2024 20:34, Michael Chan wrote:
> On Mon, Oct 28, 2024 at 11:57 AM Vadim Fedorenko <vadfed@meta.com> wrote:
>>
>> We can see high contention on ptp_lock while doing RX timestamping
>> on high packet rates over several queues. Spinlock is not effecient
>> to protect timecounter for RX timestamps when reads are the most
>> usual operations and writes are only occasional. It's better to use
>> seqlock in such cases.
>>
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>> ---
>> v3:
>> - remove unused variable
>> v2:
>> - use read_excl lock to serialize reg access with FW reset
>> ---
>>   drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 19 +++--
>>   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 73 ++++++-------------
>>   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.h | 14 +++-
>>   3 files changed, 46 insertions(+), 60 deletions(-)
>>
> 
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
>> index 820c7e83e586..5ab52f7a282d 100644
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
>> @@ -67,19 +67,21 @@ static int bnxt_ptp_settime(struct ptp_clock_info *ptp_info,
>>          if (BNXT_PTP_USE_RTC(ptp->bp))
>>                  return bnxt_ptp_cfg_settime(ptp->bp, ns);
>>
>> -       spin_lock_irqsave(&ptp->ptp_lock, flags);
>> +       write_seqlock_irqsave(&ptp->ptp_lock, flags);
>>          timecounter_init(&ptp->tc, &ptp->cc, ns);
>> -       spin_unlock_irqrestore(&ptp->ptp_lock, flags);
>> +       write_sequnlock_irqrestore(&ptp->ptp_lock, flags);
>>          return 0;
>>   }
>>
>> -/* Caller holds ptp_lock */
>>   static int bnxt_refclk_read(struct bnxt *bp, struct ptp_system_timestamp *sts,
>>                              u64 *ns)
>>   {
>>          struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
>>          u32 high_before, high_now, low;
>> +       unsigned long flags;
>>
>> +       /* We have to serialize reg access and FW reset */
>> +       read_seqlock_excl_irqsave(&ptp->ptp_lock, flags);
>>          if (test_bit(BNXT_STATE_IN_FW_RESET, &bp->state))
> 
> I think we need read_sequnlock_excl_irqrestore() here before returning.

Yes, you are right, we need to unlock seqlock in case of error. I'll
post v4 soon, thanks!

> 
>>                  return -EIO;
>>
>> @@ -93,6 +95,7 @@ static int bnxt_refclk_read(struct bnxt *bp, struct ptp_system_timestamp *sts,
>>                  low = readl(bp->bar0 + ptp->refclk_mapped_regs[0]);
>>                  ptp_read_system_postts(sts);
>>          }
>> +       read_sequnlock_excl_irqrestore(&ptp->ptp_lock, flags);
>>          *ns = ((u64)high_now << 32) | low;
>>
>>          return 0;


