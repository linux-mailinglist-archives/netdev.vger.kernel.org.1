Return-Path: <netdev+bounces-141346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88D79BA844
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 22:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1F541C20999
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 21:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3FF14F9FD;
	Sun,  3 Nov 2024 21:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ILfNt8Ai"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4CC33FE
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 21:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730668640; cv=none; b=pQ78O5CzrQy84O0514hvsT6gGKm/zQ6iR63Q6hKr7HTQS+nATUGsFJt8IjkU7SCTc4WCelYnBjJHR4yNWweBGpUvSmBthKD4BWlGLOIE+LCnygAlESqu0UBuelUBX8DVNCr33INMPZ+dJCtIio1A2nH/+qPDAaVnEUh0lBQI2WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730668640; c=relaxed/simple;
	bh=Ve6d5AeHyrbItHEFc/hB3AYzdES2gURMsdjTalqSAdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rG0cRqHz0WeG+V2a0igMlb4tkRhcqKBfJa0gJ4u4K6bZ1mvA0h8soQF73osk2Z+0G3rEiM42YTn8S5wXfDALNRy5ZL76LvU40I3P4Q1Jw+9cJWNP4HedP20rj842rh+cI+CzGqOzJfPFJOs7x73mE55dzn0BFL6Siwt1z3/Mktc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ILfNt8Ai; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8a67398a-48c1-4aad-9df6-d05688d6c951@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730668630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WaM6+1bXnSk9QKJO3BK6168A3ZS+5e4kyvOzSG/WKJM=;
	b=ILfNt8Ai/9nUVFbPElHz9KaCFo7nQ35bMytoam9pOl4mMafuwZJWQgrGkIobicoHogiZ+o
	q4/dbKTQ0HyMQf5hK4Tz2CyXKvfsb/S0P5SCrdTP7x79cjuUzmO2nDWDjJ63KNhtNSrtvV
	w8o+Bsk6OfmNS6qBRRuoy6X/oChfF2Y=
Date: Sun, 3 Nov 2024 21:17:05 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 1/2] bnxt_en: cache only 24 bits of hw counter
To: Jakub Kicinski <kuba@kernel.org>, Vadim Fedorenko <vadfed@meta.com>
Cc: Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>
References: <20241029205453.2290688-1-vadfed@meta.com>
 <20241103112234.1b057a75@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241103112234.1b057a75@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 03/11/2024 19:22, Jakub Kicinski wrote:
> On Tue, 29 Oct 2024 13:54:52 -0700 Vadim Fedorenko wrote:
>> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
>> index fa514be87650..820c7e83e586 100644
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c
>> @@ -106,7 +106,7 @@ static void bnxt_ptp_get_current_time(struct bnxt *bp)
>>   	if (!ptp)
>>   		return;
>>   	spin_lock_irqsave(&ptp->ptp_lock, flags);
>> -	WRITE_ONCE(ptp->old_time, ptp->current_time);
>> +	WRITE_ONCE(ptp->old_time, (u32)(ptp->current_time >> BNXT_HI_TIMER_SHIFT));
> 
> the casts to u32 seem unnecessary since write to u32 will truncate
> the value, anyway, and they make the lines go over 80 columns
> 
>>   	bnxt_refclk_read(bp, NULL, &ptp->current_time);
>>   	spin_unlock_irqrestore(&ptp->ptp_lock, flags);
>>   }
>> @@ -174,7 +174,7 @@ void bnxt_ptp_update_current_time(struct bnxt *bp)
>>   	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
>>   
>>   	bnxt_refclk_read(ptp->bp, NULL, &ptp->current_time);
>> -	WRITE_ONCE(ptp->old_time, ptp->current_time);
>> +	WRITE_ONCE(ptp->old_time, (u32)(ptp->current_time >> BNXT_HI_TIMER_SHIFT));
>>   }
>>   
>>   static int bnxt_ptp_adjphc(struct bnxt_ptp_cfg *ptp, s64 delta)
>> @@ -813,7 +813,7 @@ int bnxt_get_rx_ts_p5(struct bnxt *bp, u64 *ts, u32 pkt_ts)
>>   	if (!ptp)
>>   		return -ENODEV;
>>   
>> -	BNXT_READ_TIME64(ptp, time, ptp->old_time);
>> +	time = (u64)(READ_ONCE(ptp->old_time) << BNXT_HI_TIMER_SHIFT);
> 
> And this cast looks misplaced, I presume you want the shift to operate
> on 64b. The way this is written the shift will be truncated to 32b,
> and then we will promote, with top 32b being all 0.

Indeed, this cast is misplaced. I'll do v5 soon, thanks!


