Return-Path: <netdev+bounces-139373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4279B1B44
	for <lists+netdev@lfdr.de>; Sun, 27 Oct 2024 00:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4886281C2A
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 22:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A4F1D07B0;
	Sat, 26 Oct 2024 22:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jZ0JBTvU"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13B910E5
	for <netdev@vger.kernel.org>; Sat, 26 Oct 2024 22:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729981228; cv=none; b=d1pD4tslIMgLy2XxUDdT4dVL06IPpejKo16o926eiqcjo5XIPf2jrGX4qyeGoayB72FgzEGOwnHX9R3DBV7OBzuAG15go8u6MFt9ynSBOStNQhvG4mvv2rGa0JNVochAKVQrqJACTMQDxNRaI9G/qKLswxDTQ1YrKJgvDmEqoms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729981228; c=relaxed/simple;
	bh=SCAW8HJBFDci8GA/0OLt0jOazrv+ejehqdynjR8jfyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgl2skga8/H4v1z8RZbRMt8oonsPaf5BT9iyX9bo6gHXKH4wxg/yem6+VIbymXDtOpwdkhNcJDiKpcN/3hpPheE1v4IrinQ+tXLxFXjCvexBJolQa1twwmiZtZseDSD2zGFvyBz2RjzYT1lOcI+Q5IXnUETcU0TbNS3u/AOrN/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jZ0JBTvU; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2707c8e1-a939-4bad-9a4d-a446c7c89795@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729981221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=URCR9XL7o5Q69EMxBDVjy4NSd/rD3uA1Cfy/GXsRhCY=;
	b=jZ0JBTvUikXM/revSfTtEcoIo1rRnLZNN/nJq8vmuHY16M+M+KE1vZVswQae8sUYURXIZf
	7iLied3eV8nSQyYuyWwXvkYerKOIKGZjzFsgi/Xi5wMQ9jgaT/tR34WfDBaEL/dcym6+kT
	a+Ea0Xg+0yeFek54w02Y1iJkaP4sQvc=
Date: Sat, 26 Oct 2024 23:20:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 1/2] bnxt_en: cache only 24 bits of hw counter
To: Michael Chan <michael.chan@broadcom.com>
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>, Jakub Kicinski
 <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>
References: <20241025194753.3070604-1-vadfed@meta.com>
 <CACKFLikgQxsYQxkMZdXDusS=0=rZi8g9Fn6-nEnVw+g-hgzf4g@mail.gmail.com>
 <e89385ae-7d77-4890-8c80-b5904ac394b4@linux.dev>
 <CACKFLinHAXcXF45NTJueBg8JDbJfPTrPZiwHzR71K4LtvHxLVw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CACKFLinHAXcXF45NTJueBg8JDbJfPTrPZiwHzR71K4LtvHxLVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 25/10/2024 23:13, Michael Chan wrote:
> On Fri, Oct 25, 2024 at 2:53 PM Vadim Fedorenko
> <vadim.fedorenko@linux.dev> wrote:
>>
>> On 25/10/2024 22:31, Michael Chan wrote:
>>> On Fri, Oct 25, 2024 at 12:48 PM Vadim Fedorenko <vadfed@meta.com> wrote:
>>>>
>>>> This hardware can provide only 48 bits of cycle counter. We can leave
>>>> only 24 bits in the cache to extend RX timestamps from 32 bits to 48
>>>> bits. This make cache writes atomic even on 32 bit platforms and we can
>>>> simply use READ_ONCE()/WRITE_ONCE() pair and remove spinlock. The
>>>> configuration structure will be also reduced by 4 bytes.
>>>
>>> ptp->old_time serves 2 purposes: to cache the upper 16 bits of the HW
>>> counter and for rollover check.  With this patch reducing
>>> ptp->old_time to 24 bits, we now use the upper 16 bits for the cache
>>> and the next 8 bits for the rollover check.  I think this will work.
>>> But since the field is now 32-bit, why not use the full 32 bits
>>> instead of 24 bits?  Thanks.
>>
>> As you confirmed that the HW has 48 bits of cycle counter, we have to
>> cache 16 bits only. The other 8 bits are used for the rollover check. We
>> can even use less bits for it. What is the use for another 8 bits? With
>> this patch the rollover will happen every ~16 ms, but will be caught
>> even till ~4s. If we will cache upper 32 bits, the rollover will happen
>> every 64us and we will have to update cache value more often. But at the
>> same time it will not bring any value, because the upper limit will
>> still be ~4s. That's why I don't see any benefits of using all 32 bits.
> 
> I agree the extra bits have no value other than to fill the 32-bit
> field.  But it should not affect the frequency of caching
> ptp->old_time.  It should be updated in bnxt_ptp_ts_aux_work() at a
> fixed interval (1 second).

Ok, BNXT_LO_TIMER_MASK/BNXT_HI_TIMER_MASK use 24 bits only. I don't see
any reason to keep more bits out of 48 bit of counter and I tried to be
consistent across the code. It doesn't matter in terms of performance
should we shift 16 or 24 bits. But because there will be another version
(I forgot to remove one variable), I can change the code to fill 32-bit
field if you insist.

