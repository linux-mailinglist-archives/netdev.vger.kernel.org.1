Return-Path: <netdev+bounces-234126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2D7C1CD75
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 19:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5C53A59C3
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 18:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057F6357A35;
	Wed, 29 Oct 2025 18:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hzzwgYlu"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AFB280A5B
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 18:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764166; cv=none; b=FsoL6ccMOU/sD/kspWvsGRaPIaSwMKenBZIdKR6M7Z5jMkoWpvA1xldWNiCQLwzQF/UYKlsQYmf5cGX1VbMZJns2UMM/afY++kh3sJMCIptShAw2c6rsaL3RvyPUlKUPuPvnnM0t6a2JGih5mg7ygkx5bhaKoVusbkBhDph/ALU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764166; c=relaxed/simple;
	bh=YyljAPDJiqtE/jnUOuW9bS3tb5HTi64M1ANWZDyljTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t77cVlbhcJLcpNsgAHIE3jndT1NENQiYgFruduTbHOFkjEfCRc9UlVm39WPKq2C9bzW6SthG6rt13pL5oTNoAhQ/0PDLDERuAujvy6zgxymJqsbd1OjvYku8r9wPTHcdgXdRzWa8R4To7KtsYWPqSPxxudmpFgjUAsFS65tGskk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hzzwgYlu; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b4d675a4-b7ad-4ecf-8d19-6bf08b452472@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761764162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+2pYp4p8PNxFqeH30IMWWJnC3qP005Egf5/0hOU6M/k=;
	b=hzzwgYlu7/H6J6edv0nYQwyTHO1vdUOF+qLxNlxIwVczMP8CpSRvGq8n2wEidIREbyXj+O
	QM1OfkCpdgoW6YiusQMYNujrnaVj6JfvwHfuXOwHUYOGPGvdHRB2EojK+OGpZ0dIfva4pD
	r5zS6WsGwz25FAzjTRiKB5+E3ShZxow=
Date: Wed, 29 Oct 2025 18:55:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ptp: guard ptp_clock_gettime() if neither gettimex64 nor
To: Tim Hostetler <thostet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Jakub Kicinski <kuba@kernel.org>,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, junjie.cao@intel.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com,
 syzbot+c8c0e7ccabd456541612@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <aQDOpeQIU1G4nA1F@hoboy.vegasvil.org>
 <20251028155318.2537122-1-kuniyu@google.com>
 <20251028161309.596beef2@kernel.org>
 <cd154e3c-0cac-4ead-a3d0-39dc617efa74@linux.dev>
 <CAAVpQUCYFoKhUn1MU47koeyhD6roCS0YpOFwEikKgj4Z_2M=YQ@mail.gmail.com>
 <9e1ccd0f-ecb6-438e-9763-5ba04bce5928@linux.dev>
 <CAByH8UvEjnh2P5UQUuVw4G0JBkJoRLfZmmS6UbbUsA7htGqbwQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAByH8UvEjnh2P5UQUuVw4G0JBkJoRLfZmmS6UbbUsA7htGqbwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 29/10/2025 16:37, Tim Hostetler wrote:
> On Tue, Oct 28, 2025 at 4:57 PM Vadim Fedorenko
> <vadim.fedorenko@linux.dev> wrote:
>>
>> On 28.10.2025 23:54, Kuniyuki Iwashima wrote:
>>> On Tue, Oct 28, 2025 at 4:45 PM Vadim Fedorenko
>>> <vadim.fedorenko@linux.dev> wrote:
>>>>
>>>> On 28.10.2025 23:13, Jakub Kicinski wrote:
>>>>> On Tue, 28 Oct 2025 15:51:50 +0000 Kuniyuki Iwashima wrote:
>>>>>> From: Richard Cochran <richardcochran@gmail.com>
>>>>>> Date: Tue, 28 Oct 2025 07:09:41 -0700
>>>>>>> On Tue, Oct 28, 2025 at 05:51:43PM +0800, Junjie Cao wrote:
>>>>>>>> Syzbot reports a NULL function pointer call on arm64 when
>>>>>>>> ptp_clock_gettime() falls back to ->gettime64() and the driver provides
>>>>>>>> neither ->gettimex64() nor ->gettime64(). This leads to a crash in the
>>>>>>>> posix clock gettime path.
>>>>>>>
>>>>>>> Drivers must provide a gettime method.
>>>>>>>
>>>>>>> If they do not, then that is a bug in the driver.
>>>>>>
>>>>>> AFAICT, only GVE does not have gettime() and settime(), and
>>>>>> Tim (CCed) was preparing a fix and mostly ready to post it.
>>>>>
>>>>> cc: Vadim who promised me a PTP driver test :) Let's make sure we
>>>>> tickle gettime/setting in that test..
>>>>
>>>> Heh, call gettime/settime is easy. But in case of absence of these callbacks
>>>> the kernel will crash - not sure we can gather good signal in such case?
>>>
>>> At least we could catch it on NIPA.
>>>
>>> but I suggested Tim adding WARN_ON_ONCE(!info->gettime64 &&
>>> !info-> getimex64) in ptp_clock_register() so that a developer can
>>> notice that even while loading a buggy module.
>>
>> Yeah, that looks like a solution
> 
> Yes, I was actually going to post the fix to gve today (I'll still do
> that as ptp_clock_gettime() is not the only function to assume a
> gettime64 or gettimex64 implementation) and shortly after posting
> Kuniyuki's suggested fix to ptp_clock_register() as such:
> 
> diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
> index ef020599b771..f2d9cf4a455e 100644
> --- a/drivers/ptp/ptp_clock.c
> +++ b/drivers/ptp/ptp_clock.c
> @@ -325,6 +325,9 @@ struct ptp_clock *ptp_clock_register(struct
> ptp_clock_info *info,
>          if (info->n_alarm > PTP_MAX_ALARMS)
>                  return ERR_PTR(-EINVAL);
> 
> +       if (WARN_ON_ONCE(!info->gettimex64 && !info->gettime64))
> +               return ERR_PTR(-EINVAL);
> +
>          /* Initialize a clock structure. */
>          ptp = kzalloc(sizeof(struct ptp_clock), GFP_KERNEL);
>          if (!ptp) {
> --
> 
> I also have a similar patch for checking for settime64's function pointer.
> 
> But I have no objections to Junjie posting a v2 in this manner instead
> of waiting for me.

WARN_ON_ONCE is better in terms of reducing the amount of review work.
Driver developers will be automatically notified about improper
implementation while Junjie's patch will simply hide the problem.

