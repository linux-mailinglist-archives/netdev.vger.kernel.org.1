Return-Path: <netdev+bounces-142753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 158C89C03AE
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 12:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64B1FB21ED5
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 11:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46241EE01A;
	Thu,  7 Nov 2024 11:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ixzNmIhS"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CF31DDC02
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 11:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730978265; cv=none; b=AKPAuTEXdP/mbfT2K5o95Cheq9RbeTKf4Vw54WN1VU5sF13rC+2NbE8af35N2Kn2f1U9Ok8lW3msA+ryrQVRvcAUdhw4qXocqssrpIv1q0XjJkzT3F+yOpcqdZ4YQkxNX0fyT9CSH4mdRcHzX1ou2V8avbb3Yxn7vGpNwvHpqaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730978265; c=relaxed/simple;
	bh=nbfuvoaTshaZg7Os/FowEXqZwFl3hZKOXgDiktG21PU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fVz/utj7aJDPi2bYKPUbZ73NAHgRbqZfejbU+0LLAj2fAhJd3mLnVPDVVi/XhnVm37TTfNHirMeI50oMeGBOyCQMgAYxu2s1dHZNgbUsPqWGz96DB6kZx04d7MPFdmdd1X1jM3zF1rZAw6uVtjTxoQag3i1S4lXtVaPHlGQ+hPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ixzNmIhS; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <90aea4dd-cb37-4dab-99ef-d45915514787@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730978261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qjDWmkLTBJBXtzM5U8NSw/r8gdTMhsrk5eveOCxgIT8=;
	b=ixzNmIhS3k83qjGAXnvkpMoamepvxRUq8RAptAc9HJNRoUVsPH+kRfuXGdwLS+xea3+Qlm
	FQy7taI4WbNwmj3kzitQGZdltB2pvbV843GsXGopqCwOVl8uEWJccC8kiLcl9xPCmqxL6V
	11nUW8z25uKLxZSY5luZUBWy25Gdh8Y=
Date: Thu, 7 Nov 2024 11:17:34 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] bnxt_en: add unlocked version of
 bnxt_refclk_read
To: Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Vadim Fedorenko <vadfed@meta.com>
Cc: Michael Chan <michael.chan@broadcom.com>, Jakub Kicinski
 <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>
References: <20241106213203.3997563-1-vadfed@meta.com>
 <CALs4sv1VTT7L9t+BjuvW8naO7fm5Wq0qKgVkv2DW4nrNe1bucA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CALs4sv1VTT7L9t+BjuvW8naO7fm5Wq0qKgVkv2DW4nrNe1bucA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 07/11/2024 04:30, Pavan Chebbi wrote:
> On Thu, Nov 7, 2024 at 3:02 AM Vadim Fedorenko <vadfed@meta.com> wrote:
>>
>> Serialization of PHC read with FW reset mechanism uses ptp_lock which
>> also protects timecounter updates. This means we cannot grab it when
>> called from bnxt_cc_read(). Let's move locking into different function.
>>
>> Fixes: 6c0828d00f07 ("bnxt_en: replace PTP spinlock with seqlock")
>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>> ---
>>   drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c | 29 ++++++++++++-------
>>   1 file changed, 19 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
>> index f74afdab4f7d..5395f125b601 100644
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
>> @@ -73,19 +73,15 @@ static int bnxt_ptp_settime(struct ptp_clock_info *ptp_info,
>>          return 0;
>>   }
>>
>> -static int bnxt_refclk_read(struct bnxt *bp, struct ptp_system_timestamp *sts,
>> -                           u64 *ns)
>> +/* Caller holds ptp_lock */
>> +static int __bnxt_refclk_read(struct bnxt *bp, struct ptp_system_timestamp *sts,
>> +                             u64 *ns)
>>   {
>>          struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
>>          u32 high_before, high_now, low;
>> -       unsigned long flags;
>>
>> -       /* We have to serialize reg access and FW reset */
>> -       read_seqlock_excl_irqsave(&ptp->ptp_lock, flags);
>> -       if (test_bit(BNXT_STATE_IN_FW_RESET, &bp->state)) {
>> -               read_sequnlock_excl_irqrestore(&ptp->ptp_lock, flags);
>> +       if (test_bit(BNXT_STATE_IN_FW_RESET, &bp->state))
>>                  return -EIO;
>> -       }
>>
>>          high_before = readl(bp->bar0 + ptp->refclk_mapped_regs[1]);
>>          ptp_read_system_prets(sts);
>> @@ -97,12 +93,25 @@ static int bnxt_refclk_read(struct bnxt *bp, struct ptp_system_timestamp *sts,
>>                  low = readl(bp->bar0 + ptp->refclk_mapped_regs[0]);
>>                  ptp_read_system_postts(sts);
>>          }
>> -       read_sequnlock_excl_irqrestore(&ptp->ptp_lock, flags);
>>          *ns = ((u64)high_now << 32) | low;
>>
>>          return 0;
>>   }
>>
>> +static int bnxt_refclk_read(struct bnxt *bp, struct ptp_system_timestamp *sts,
>> +                           u64 *ns)
>> +{
>> +       struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
>> +       unsigned long flags;
>> +       int rc;
>> +
>> +       /* We have to serialize reg access and FW reset */
>> +       read_seqlock_excl_irqsave(&ptp->ptp_lock, flags);
>> +       rc = __bnxt_refclk_read(bp, sts, ns);
>> +       read_sequnlock_excl_irqrestore(&ptp->ptp_lock, flags);
>> +       return rc;
>> +}
>> +
>>   static void bnxt_ptp_get_current_time(struct bnxt *bp)
>>   {
>>          struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
>> @@ -674,7 +683,7 @@ static u64 bnxt_cc_read(const struct cyclecounter *cc)
>>          struct bnxt_ptp_cfg *ptp = container_of(cc, struct bnxt_ptp_cfg, cc);
>>          u64 ns = 0;
>>
>> -       bnxt_refclk_read(ptp->bp, NULL, &ns);
>> +       __bnxt_refclk_read(ptp->bp, NULL, &ns);
> 
> With this change, bnxt_cc_read() is executed without protection during
> timecounter_init(), right?
> I think we should hold the ptp_lock inside bnxt_ptp_timecounter_init()
> just like we do in bnxt_ptp_init_rtc()

Well, yes, that's correct. Technically we have to hold this lock (and I
will add it in v2), but if think a bit wider, do we expect
bnxt_fw_reset()/bnxt_force_fw_reset() to be called during device init
phase? If yes, we have proper time frame between bnxt_ptp_cfg allocation
in __bnxt_hwrm_ptp_qcfg() (which assigns it to bp->ptp) and spinlock
initialization in bnxt_ptp_init(), during which spinlock must not be
accessed. And if we imagine the situation when fw_reset request can be
initiated during initialization, the next flow can happen:

CPU0:                           CPU1:
__bnxt_hwrm_ptp_qcfg()
   ptp_cfg = kzalloc()
   bp->ptp = ptp_cfg
				bnxt_force_fw_reset()
				  if (bp->ptp)
				    spin_lock_irqsave(bp->ptp->ptp_lock)
   bnxt_ptp_init()
     spinlock_init(ptp_lock)


So we either should not have an option of resetting FW during init
phase (and then there will be no need to use lock), or we have to
re-think FW reset serialization completley. WDYT?

>>          return ns;
>>   }
>>
>> --
>> 2.43.5
>>


