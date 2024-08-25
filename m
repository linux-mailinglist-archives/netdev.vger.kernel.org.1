Return-Path: <netdev+bounces-121737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 673F795E49F
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 19:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C800B21288
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 17:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4B336AF2;
	Sun, 25 Aug 2024 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCzymMXF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD252B9A1
	for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 17:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724608030; cv=none; b=AbOJO6zf7FFANMyaGRpl5soijr1xLT/g8NVjZxVFZVGWpSdH2POSqk7rQwYkng/7PrrvKQQ0ZY6A5VuGexI3bEeBxV0QZe8bymdpOejmVNGyzzpGFFcBFvYNYYNwvJJ0PAuRcyaa5XiJJkMzGhbzV0VhTsRlE2S1tnTas0Y5KY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724608030; c=relaxed/simple;
	bh=ey9k7hjmaZJxdoFOwlpDq69ONTjkSFot2mJ2RCuRilY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uUsbp87cUaCOH5BJeA+IhKNhXS46gfd3TkxrOnMZYREQFbpemsq1F8Qy6KmC0jri0IENGAcDVbyqP5pikHd2rUmFyVjTuqhFW6V7x9vchk2a0N458dUgCAQ1+rtK2gg7gdee/Ks8Oxl6/Q6/2kshEob+yK0rqyf7XfF7HxfyoQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCzymMXF; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7a1d984ed52so220979385a.0
        for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 10:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724608028; x=1725212828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NU6sTP06V6hRin8eeF7Z1sDnC6Pz0jYeHQQu8JCrmwg=;
        b=FCzymMXFp3gKVJXM5sscvnQ8L1wBSrA81jAiRdHI+uZp1BuJ4qkyBtdL6+UijvkUZW
         l65UsLbVPWZWO8o72R+y79wyyIY90XpYIzKbHis1oD3Q+Yyxj0JGUXtqg8If/GmQo9/b
         u1ux5bwjlpANXSrnm9NKnC+eJdmMcUwWBTl7cuW83n6OwRPNbJmk1YCgPLVXkH9q/Ruw
         +sLmwZTS63xOyJ7/IqvpZT9lnq2/2GSmnxSTRxHQ8n4JRXwTXjnvx87SiXGd3ypHR6Xx
         ATnj3rWjRcjM3r5xiQcUE4zyNbxSdpDDB5hwGRLJJqKqIZLhL7TyMoxD/Q1zPpBDi83t
         spPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724608028; x=1725212828;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NU6sTP06V6hRin8eeF7Z1sDnC6Pz0jYeHQQu8JCrmwg=;
        b=ipyZdx3KSbkKOWswqQ6/RuPbQNmiF0EODdqNzCXLeCFvJYO/aWH0c+nHEO+un/+2xe
         vTVuR3WwSJqCkhxMTcO9hqlj+OiRGad3dCiAUoAY65Dy0QW/t+wNnpAcLzBzI62L8sM9
         ze9Yju73c4T/qvVSAIJzHALfXjWANFlXZKqU5Otapk9Tk01vdKJeIYdO4dqTcDdo6bjE
         2UdGqrdd7v8bzfVQTjt6OsV2kYuJYc45pkxK32wq2xYKRd63m5hwqWOAXour72ETkHy+
         nA2Rzivc7MX7rrHx/p/wORqdwcUXPAdv0P3eftA5bok4Y+ByLp2lDRn87tgZp4NP5yID
         WsSw==
X-Forwarded-Encrypted: i=1; AJvYcCWajZaaJ0PM5k6w/D60kNEENpw6ttKWii8h9w4cRMmB5xn4JI6Vt9USvHM0udBnXHaN1dc9GPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhoeXdtKKniGVKsOTaGOddORrVg84jFGUg4gJ2OHNJUeXtQOOg
	ffw0PFzCDtG1dUI9l0RPHL5k1zV6bWv8HMECLigyj1Q8Jmg/34bM
X-Google-Smtp-Source: AGHT+IGjtnwKaxka/Y5Fg6fRjkQhMWmfYQ8yUhqitDPa4GV2l6ZognzfYphVmx0xU/eaPstgo1gF2A==
X-Received: by 2002:a05:620a:3193:b0:7a6:4a55:a626 with SMTP id af79cd13be357-7a68979af7dmr970382685a.51.1724608028109;
        Sun, 25 Aug 2024 10:47:08 -0700 (PDT)
Received: from [10.64.61.212] ([129.93.161.236])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f327cfcsm380976785a.3.2024.08.25.10.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2024 10:47:07 -0700 (PDT)
Message-ID: <cf64e6ab-7a2b-4436-8fe2-1f381ead2862@gmail.com>
Date: Sun, 25 Aug 2024 12:47:06 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4 1/3] tcp_cubic: fix to run bictcp_update() at least
 once per RTT
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, ncardwell@google.com, netdev@vger.kernel.org,
 Lisong Xu <xu@unl.edu>
References: <20240817163400.2616134-1-mrzhang97@gmail.com>
 <20240817163400.2616134-2-mrzhang97@gmail.com>
 <CANn89iKwN8vCH4Dx0mYvLJexWEmz5TWkfvCFnxmqKGgTTzeraQ@mail.gmail.com>
 <573e24dc-81c7-471f-bdbf-2c6eb2dd488d@gmail.com>
 <CANn89i+yoe=GJXUO57V84WM3FHqQBOKsvEN3+9cdp_UKKbT4Mw@mail.gmail.com>
Content-Language: en-US
From: Mingrui Zhang <mrzhang97@gmail.com>
In-Reply-To: <CANn89i+yoe=GJXUO57V84WM3FHqQBOKsvEN3+9cdp_UKKbT4Mw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/20/24 07:53, Eric Dumazet wrote:
> On Mon, Aug 19, 2024 at 10:36 PM Mingrui Zhang <mrzhang97@gmail.com> wrote:
>> On 8/19/24 04:00, Eric Dumazet wrote:
>>> On Sat, Aug 17, 2024 at 6:35 PM Mingrui Zhang <mrzhang97@gmail.com> wrote:
>>>> The original code bypasses bictcp_update() under certain conditions
>>>> to reduce the CPU overhead. Intuitively, when last_cwnd==cwnd,
>>>> bictcp_update() is executed 32 times per second. As a result,
>>>> it is possible that bictcp_update() is not executed for several
>>>> RTTs when RTT is short (specifically < 1/32 second = 31 ms and
>>>> last_cwnd==cwnd which may happen in small-BDP networks),
>>>> thus leading to low throughput in these RTTs.
>>>>
>>>> The patched code executes bictcp_update() 32 times per second
>>>> if RTT > 31 ms or every RTT if RTT < 31 ms, when last_cwnd==cwnd.
>>>>
>>>> Fixes: df3271f3361b ("[TCP] BIC: CUBIC window growth (2.0)")
>>>> Fixes: ac35f562203a ("tcp: bic, cubic: use tcp_jiffies32 instead of tcp_time_stamp")
>>> I do not understand this Fixes: tag ?
>>>
>>> Commit  ac35f562203a was essentially a nop at that time...
>>>
>> I may misunderstood the use of Fixes tag and choose the latest commit of that line.
>>
>> Shall it supposed to be the very first commit with that behavior?
>> That is, the very first commit (df3271f3361b ("[TCP] BIC: CUBIC window growth (2.0)")) when the code was first introduced?
> I was referring to this line : Fixes: ac35f562203a ("tcp: bic, cubic:
> use tcp_jiffies32 instead of tcp_time_stamp")
>
> Commit ac35f562203a did not change the behavior at all.
>
> I see no particular reason to mention it, this is confusing.
>
>
>>>> Signed-off-by: Mingrui Zhang <mrzhang97@gmail.com>
>>>> Signed-off-by: Lisong Xu <xu@unl.edu>
>>>> ---
>>>> v3->v4: Replace min() with min_t()
>>>> v2->v3: Correct the "Fixes:" footer content
>>>> v1->v2: Separate patches
>>>>
>>>>  net/ipv4/tcp_cubic.c | 6 +++++-
>>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
>>>> index 5dbed91c6178..00da7d592032 100644
>>>> --- a/net/ipv4/tcp_cubic.c
>>>> +++ b/net/ipv4/tcp_cubic.c
>>>> @@ -218,8 +218,12 @@ static inline void bictcp_update(struct bictcp *ca, u32 cwnd, u32 acked)
>>>>
>>>>         ca->ack_cnt += acked;   /* count the number of ACKed packets */
>>>>
>>>> +       /* Update 32 times per second if RTT > 1/32 second,
>>>> +        * or every RTT if RTT < 1/32 second even when last_cwnd == cwnd
>>>> +        */
>>>>         if (ca->last_cwnd == cwnd &&
>>>> -           (s32)(tcp_jiffies32 - ca->last_time) <= HZ / 32)
>>>> +           (s32)(tcp_jiffies32 - ca->last_time) <=
>>>> +           min_t(s32, HZ / 32, usecs_to_jiffies(ca->delay_min)))
>>> This looks convoluted to me and still limited if HZ=250 (some distros
>>> still use 250 jiffies per second :/ )
>>>
>>> I would suggest switching to usec right away.
>> Thank you for the suggestion, however, I may need more time to discuss with another author for this revision. :)
>> Thank you
> No problem, there is no hurry.

Thank you, Eric, for your suggestion (switching ca->last_time from jiffies to usec)!
We thought about it and feel that it is more complicated and beyond the scope of this patch.

There are two blocks of code in bictcp_update().
* Block 1: cubic calculation, which is computationally intensive.
* Block 2: tcp friendliness, which emulates RENO.

There are two if statements to control how often these two blocks are called to reduce CPU overhead.
 * If statement 1:  if the condition is true, none of the two blocks are called.
if (ca->last_cwnd == cwnd &&
                    (s32)(tcp_jiffies32 - ca->last_time) <= HZ / 32)
                                return;

* If statement 2: If the condition is true, block 1 is not called. Intuitively, block 1 is called at most once per jiffy.
if (ca->epoch_start && tcp_jiffies32 == ca->last_time)
                                goto tcp_friendliness;


This patch changes only the first if statement. If we switch ca->last_time from jiffies to usec,
we need to change not only the first if statement but also the second if statement, as well as block 1.
* change the first if statement from jiffies to usec.
* change the second if statement from jiffies to usec. Need to determine how often (in usec) block 1 is called
* change block 1 from jiffies to usec. Should be fine, but need to make sure no calculation overflow.

Therefore, it might be better to keep the current patch as it is, and address the switch from jiffies to usec in future patches.

Thank you!
Lisong (Mingrui Send On Behalf of)

