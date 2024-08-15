Return-Path: <netdev+bounces-119010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 254BF953CEB
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 23:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A83441F25EEB
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 21:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A814F153BED;
	Thu, 15 Aug 2024 21:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDp929k1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED8724211
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 21:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723758499; cv=none; b=cHMtN5MEd0QghbRmJ5wEf3G7ivNe9S4YsRunwIWbx+27wkKiJqlV/yZIEO0WTVNB0m8oif2K0KzBgkqr7+voNcHxmXhXOM47igkZTr+RViZgsybjv6JTX/4JBX5rwaE1vTtxhuVv5yMkRLkn5+PtgNsqyfHqX+rOelwFAenlOGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723758499; c=relaxed/simple;
	bh=T3sBjgFmhykaP7al8p3PuOqD/jhjtK5gCZv6IAIZ7bA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tt6oVDlBUbgJRlxEpjLsD3Yl4kZxdRT+IJNt2DQK3nypV5i/PBDX/w66ISpGOFcPkboGAAznp4JG+tVXbdRVxtEw4xnOMMAePFGichmkszMPyHTiUfYkZpj3rQlYvgp/UTDSWvMaJaji/r7PC5h8VP+QhEu092cRrpD0shPxW20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDp929k1; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7095bfd6346so898758a34.0
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 14:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723758497; x=1724363297; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ECMYQPq6Og0mxfLfOkFNcJNvoC8n9jB0gREe+KRgqLM=;
        b=JDp929k1wIBpWVBEeUiukFsf5GNDNnowvznCdzwDI8KkCFJVWpJkcdXhQr2Q1X0a9G
         ayNCGizOh6UDTnXcZszWGvQ1tjbp8IWF/R41VfsHLKeYxVhWjiLIjeoWc7QrQjcn4gTv
         EVmvuLOO8sHadYGEoyLj0ubGQFrqeF+nr3o1tjmrTeFZqRpE/ktq57ZJYudGGwlkejtB
         EJE1l0rm2/uZAYX/ZxZl0dbm6DmNIMS3I5dWa1jWfvscWqG7vKPLu90NTidViO3mf3sw
         N+ZzKLPTqWqwGwOqyc+bn4Xo07dbFP54hXDsVhdBDTbXNj1Py+78IGY0zBl0v5j78ZD4
         /k/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723758497; x=1724363297;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ECMYQPq6Og0mxfLfOkFNcJNvoC8n9jB0gREe+KRgqLM=;
        b=geMY1IC8DdCJIWgz0ScGan9zDtJj+henffQkfoXZcTW7SmY60ogdkDgakn4J2GXVg+
         9IWHw5z3PliwL+EaI1WpuTrYqniTZI7mbIXiA1B22Gh1pbmrU4b6y5d+v9Ji9yclPC+G
         jMq16Sc/oSH+RLZv0DnhxEqct1T6AxT1exH42rSzpJky68DGzKcdHEgip7VEclrbOWq/
         8Im/yPTcEZzdy5dEf5XkB423urIYHbOyGfjTGG05Yuw5TcBmZr0W2GbncQS60fffV8F8
         fi0bhiS16xWcQkjZgV7n4QoS5HChX6Z0vYjpurIqGNIpE+AvGbfPwFwkNSZSrHZWIqA5
         OgvA==
X-Forwarded-Encrypted: i=1; AJvYcCWwTJfcEYBZc4VO38/pZDH9cN6Pr7GUa9mk+3RN8T69BysIvg2T3ZUzTRYNhsqc7Zom+d2o9D8jJ93uUIKrlgVN9pe+EQf1
X-Gm-Message-State: AOJu0YyN2U5LWdcgh7DScj/vpTAJ3s8GINOkxSpj+Q3jCtuOOBA+bySi
	NNvWswZ34MvtVAkIP5TDUJlyFNrfHB0pbYjn1PV054zCjb24ZDr6
X-Google-Smtp-Source: AGHT+IGSwNAH6F/+3pmM2NGrF0s9ulHzT2E/PYXCaucI47SLIf8KI/qlcEeRXzuVKY0cJbQ6AQG47g==
X-Received: by 2002:a05:6830:6dc5:b0:709:3de2:99ab with SMTP id 46e09a7af769-70cac85812bmr1148704a34.18.1723758497077;
        Thu, 15 Aug 2024 14:48:17 -0700 (PDT)
Received: from [10.64.61.212] ([129.93.161.236])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ccd6a4d5f3sm768253173.0.2024.08.15.14.48.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 14:48:16 -0700 (PDT)
Message-ID: <73788a78-ada2-4e3c-bf33-e5e8f266920b@gmail.com>
Date: Thu, 15 Aug 2024 16:48:15 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/3] tcp_cubic: fix to run bictcp_update() at least
 once per RTT
To: Neal Cardwell <ncardwell@google.com>
Cc: edumazet@google.com, davem@davemloft.net, netdev@vger.kernel.org,
 Lisong Xu <xu@unl.edu>
References: <20240815001718.2845791-1-mrzhang97@gmail.com>
 <20240815001718.2845791-2-mrzhang97@gmail.com>
 <CADVnQykHS1uPT1Wa4WjOdnJ2=bQh1ZkQUBK2GNXGwcg5u5SC3g@mail.gmail.com>
Content-Language: en-US
From: Mingrui Zhang <mrzhang97@gmail.com>
In-Reply-To: <CADVnQykHS1uPT1Wa4WjOdnJ2=bQh1ZkQUBK2GNXGwcg5u5SC3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/15/24 09:43, Neal Cardwell wrote:
> On Wed, Aug 14, 2024 at 8:19 PM Mingrui Zhang <mrzhang97@gmail.com> wrote:
>> The original code bypasses bictcp_update() under certain conditions
>> to reduce the CPU overhead. Intuitively, when last_cwnd==cwnd,
>> bictcp_update() is executed 32 times per second. As a result,
>> it is possible that bictcp_update() is not executed for several
>> RTTs when RTT is short (specifically < 1/32 second = 31 ms and
>> last_cwnd==cwnd which may happen in small-BDP networks),
>> thus leading to low throughput in these RTTs.
>>
>> The patched code executes bictcp_update() 32 times per second
>> if RTT > 31 ms or every RTT if RTT < 31 ms, when last_cwnd==cwnd.
>>
>> Thanks
>> Mingrui, and Lisong
>>
>> Fixes: 91a4599c2ad8 ("tcp_cubic: fix to run bictcp_update() at least once per RTT")
> The Fixes: footer is not for restating the commit title in your new
> patch. Instead, it should list the SHA1 and first commit message line
> from the old commit (potentially years ago) that has buggy behavior
> that you are fixing. That way the Linux maintainers know which Linux
> releases have the bug, and they know how far back in release history
> the fix should be applied, when backporting fixes to stable releases.
>
> More information:
>  https://www.kernel.org/doc/html/v6.10/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes
>
> Please update the Fixes footers in the three commits and repost. :-)
>
> Thanks!
> neal
>
Thank you again, Neal.
I appreciate your detailed instructions on Fixes footer. I misunderstood its meaning.

Thanks
Mingrui
>> Signed-off-by: Mingrui Zhang <mrzhang97@gmail.com>
>> Signed-off-by: Lisong Xu <xu@unl.edu>
>>
>> ---
>>  net/ipv4/tcp_cubic.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
>> index 5dbed91c6178..11bad5317a8f 100644
>> --- a/net/ipv4/tcp_cubic.c
>> +++ b/net/ipv4/tcp_cubic.c
>> @@ -218,8 +218,12 @@ static inline void bictcp_update(struct bictcp *ca, u32 cwnd, u32 acked)
>>
>>         ca->ack_cnt += acked;   /* count the number of ACKed packets */
>>
>> +       /* Update 32 times per second if RTT > 1/32 second,
>> +        *        every RTT if RTT < 1/32 second
>> +        *        even when last_cwnd == cwnd
>> +        */
>>         if (ca->last_cwnd == cwnd &&
>> -           (s32)(tcp_jiffies32 - ca->last_time) <= HZ / 32)
>> +           (s32)(tcp_jiffies32 - ca->last_time) <= min(HZ / 32, usecs_to_jiffies(ca->delay_min)))
>>                 return;
>>
>>         /* The CUBIC function can update ca->cnt at most once per jiffy.
>> --
>> 2.34.1
>>


