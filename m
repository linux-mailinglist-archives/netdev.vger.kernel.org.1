Return-Path: <netdev+bounces-182163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D14A88102
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20399178485
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 13:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFDF1799F;
	Mon, 14 Apr 2025 13:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CZLYlnOY"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67296433CB
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 13:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744635702; cv=none; b=hqVr/SV05ECqsgf92QLOEChJ253Oa4oB0DTmGqgy9vIQm4IscykAd27/8SzCv4QpbeJwpXx05gChhFK9ihdCKxU/sDc7nYo3X2BFQFRKusoQfngsvmsK9aFB+2aPIxkNOYCJ9XFKdwzmGvPGhY7bzFndzttcPRS/vVMaV7iymls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744635702; c=relaxed/simple;
	bh=cQpYBJT1BS6d2aNLlx3jhhLQ73c+7Qwy83avSo07Uaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HlAGZrO4mGw8vCAkX3l5CyvXV48mMUOz2NZGqMkAMfE/Lq6B/iUN+fZ9YvIjXzC7l3vmCgfArGEkg9eTzKOpjya6i1IebTsdAuu+BQH6K49vwotPz1KBOu+6S0xa+DaygO+9J5KbHbx8tJ+Sb1EutpbXmkiCVMD0RYTfTi1zqG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CZLYlnOY; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <39839bcb-90e9-4886-913d-311c75c92ad8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744635698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=92Ns63mKqKSi1Gpjb4z8VtgowBHrPaaCCaojmxVMIOU=;
	b=CZLYlnOYrK7MvKRVU8lfgTrDdE9WR+TaY23koug0t86L9mHPPxPReugOzKI/avqRADBrEP
	l1rh9yUYnwwH6MUjUlkwEIVzw/MtG/qio10CHcHluDYUrWOa8I5EeitQgXkwqiFc09hZbI
	pWiu0eZ2YwR7/QeNH7Rxvfdf4WWyjKs=
Date: Mon, 14 Apr 2025 14:01:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1] ptp: ocp: fix NULL deref in _signal_summary_show
To: Sagi Maimon <maimon.sagi@gmail.com>
Cc: jonathan.lemon@gmail.com, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250414085412.117120-1-maimon.sagi@gmail.com>
 <b6aea926-ebb6-48fe-a1be-6f428a648eae@linux.dev>
 <CAMuE1bG_+qj++Q0OXfBe3Z_aA-zFj3nmzr9CHCuKJ_Jr19oWEg@mail.gmail.com>
 <aa9a1485-0a0b-442b-b126-a00ee5d4801c@linux.dev>
 <CAMuE1bETL1+sGo9wq46O=Ad-_aa8xNLK0kWC63Mm5rTFdebp=w@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAMuE1bETL1+sGo9wq46O=Ad-_aa8xNLK0kWC63Mm5rTFdebp=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 14/04/2025 12:38, Sagi Maimon wrote:
> On Mon, Apr 14, 2025 at 2:09 PM Vadim Fedorenko
> <vadim.fedorenko@linux.dev> wrote:
>>
>> On 14/04/2025 11:56, Sagi Maimon wrote:
>>> On Mon, Apr 14, 2025 at 12:37 PM Vadim Fedorenko
>>> <vadim.fedorenko@linux.dev> wrote:
>>>>
>>>> On 14/04/2025 09:54, Sagi Maimon wrote:
>>>>> Sysfs signal show operations can invoke _signal_summary_show before
>>>>> signal_out array elements are initialized, causing a NULL pointer
>>>>> dereference. Add NULL checks for signal_out elements to prevent kernel
>>>>> crashes.
>>>>>
>>>>> Fixes: b325af3cfab9 ("ptp: ocp: Add signal generators and update sysfs nodes")
>>>>> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
>>>>> ---
>>>>>     drivers/ptp/ptp_ocp.c | 3 +++
>>>>>     1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
>>>>> index 7945c6be1f7c..4c7893539cec 100644
>>>>> --- a/drivers/ptp/ptp_ocp.c
>>>>> +++ b/drivers/ptp/ptp_ocp.c
>>>>> @@ -3963,6 +3963,9 @@ _signal_summary_show(struct seq_file *s, struct ptp_ocp *bp, int nr)
>>>>>         bool on;
>>>>>         u32 val;
>>>>>
>>>>> +     if (!bp->signal_out[nr])
>>>>> +             return;
>>>>> +
>>>>>         on = signal->running;
>>>>>         sprintf(label, "GEN%d", nr + 1);
>>>>>         seq_printf(s, "%7s: %s, period:%llu duty:%d%% phase:%llu pol:%d",
>>>>
>>>> That's not correct, the dereference of bp->signal_out[nr] happens before
>>>> the check. But I just wonder how can that even happen?
>>>>
>>> The scenario (our case): on ptp_ocp_adva_board_init we
>>> initiate only signals 0 and 1 so 2 and 3 are NULL.
>>> Later ptp_ocp_summary_show runs on all 4 signals and calls _signal_summary_show
>>> when calling signal 2 or 3  the dereference occurs.
>>> can you please explain: " the dereference of bp->signal_out[nr] happens before
>>> the check", where exactly? do you mean in those lines:
>>> struct signal_reg __iomem *reg = bp->signal_out[nr]->mem;
>>      ^^^
>> yes, this is the line which dereferences the pointer.
>>
>> but in case you have only 2 pins to configure, why the driver exposes 4
>> SMAs? You can simply adjust the attributes (adva_timecard_attrs).
>>
> I can (and will) expose only 2 sma in adva_timecard_attrs, but still
> ptp_ocp_summary_show runs
> on all 4 signals and not only on the on that exposed, is it not a bug?

Yeah, it's a bug, but different one, and we have to fix it other way.

>>> struct ptp_ocp_signal *signal = &bp->signal[nr];
>>>> I believe the proper fix is to move ptp_ocp_attr_group_add() closer to
>>>> the end of ptp_ocp_adva_board_init() like it's done for other boards.
>>>>
>>>> --
>>>> pw-bot: cr
>>


