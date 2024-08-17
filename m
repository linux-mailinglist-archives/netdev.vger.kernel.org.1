Return-Path: <netdev+bounces-119353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7ADA9554CB
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 04:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4FCE1C215E7
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 02:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399394C6C;
	Sat, 17 Aug 2024 02:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEmJ7XKe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51F879CC
	for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 02:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723860536; cv=none; b=i93C0d3kuswvY/18PIYQZqBdxpAJYJdS8uTutm+4aFJm4zIRsrFK/Ppjm5N4+498ekdjiqIpVlZ3AVrY+I+5YyoVTnqnJVgNrXjGp+H/gu9cFBTFNuODrYeBePx80uB6vJoS0F98496Z2WgjrOunaR8NhReS+GjmvLUSw6fHIhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723860536; c=relaxed/simple;
	bh=QzhD3+72cdr+F0Mg7DecKWwrT6r6S3MzKNMMqX3MQN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tzZF6L8TsztJjKI60Yn9oFooApPkLxUKi8JFyFzeUaNpHP3udlc/Fd5kvi0a98fmS+Dd57RwgKfnSNlgsn84uZ5POrLZGIyQTUvJcWXqndWPnMB8ZILoq1kZi7TyUxU9jLLpywEWjCemmRUcKLNTFrnCUrfPy+FXkDRh+irBbIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEmJ7XKe; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-81fd925287eso107621339f.3
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 19:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723860534; x=1724465334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7j9GyH3pLRK3BW+daybQ1j9UKxj6nFS7Sr+XpRE7340=;
        b=iEmJ7XKeeF5m5s5vS6sYIqVFqoVSXke97HipZPLmk4ooKtYPAypVWGAM/V8V0YkCJw
         y0OXMWqZEG0nUrdF9n5Fv+aH16N5DXR+WIO/nOLNJ9uOqgxPfXxk9AHMdc0QahCIA4Aw
         rvfiIaIBaXROnOM78iRcyu7/Lfb3lWpovVZ6Vwo5ORO/DS7qnVBgeOR1NusXhjW2ZOmY
         dvWIb0O34GnLvI4VBLO6G/Z+O6kByti8x5QXMCUXLaPdpSlkYzv26S9zVrSgQ0SS/t1l
         sQqnnyR2wPRSmSMRbx4dc8ZCBuK54z3mDID/wWhSykGpkt9ZZmPOkIB3WDO0eNkOErcZ
         enZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723860534; x=1724465334;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7j9GyH3pLRK3BW+daybQ1j9UKxj6nFS7Sr+XpRE7340=;
        b=QFl9lO5OIeJZX0fXcxKudOGnWdELdI/1BtJtDgKvgtBp7Vh6xxoZqDfjYrksmjYWyM
         dzLJHRSxATZ1F3SC494F4iF94tizpZFK0tHFt6mIYqCSPwm1JcaRIji9a5VMnBfHUGog
         iEk1TXr5Tx1tDOihk/3y84e+S/lNmivceXBiW41+44ibANJCS5goE1yn2J40lqN4m4PD
         SxOjhS6buvS6VhhQ9JtCfvslI8MatbAuDj8c9njh7V3oKAidCdduj90fNOOw3ghBaFBK
         iCipsV5Ui4yf4TJ/fQeHXOcVegkTN/2sSjAE/XZN71+6k2I5EzjAO/7ZrWsT+RLdY97l
         7DVA==
X-Forwarded-Encrypted: i=1; AJvYcCXu0USS2JGlFO3/xWPGG23UfC5qCx60L8kREE5bdlf7ZCa7eXQxyhGxlYCGhjvRBMF5LVukvg6atZxLIDpk/zjSzTA+PA5f
X-Gm-Message-State: AOJu0YwmhQwdwvtwbD7bImjSeZTzYvwAz8jJe7pOtmile6W4c+Hr17oS
	Ip70VTkGW0NCl1cjOg4nmFf4VqKlm3DXPkRBhIrYyozRC5yNlyhW
X-Google-Smtp-Source: AGHT+IFgAJDg8vvTi09wiMB5SsrjNOLKoQdszfT6ib78Zu2fTPHIH+l7194WIsT13uhVhOr7d78Nuw==
X-Received: by 2002:a05:6602:6d19:b0:7fd:5a50:b217 with SMTP id ca18e2360f4ac-824f25eafddmr653309939f.3.1723860533547;
        Fri, 16 Aug 2024 19:08:53 -0700 (PDT)
Received: from [10.64.61.212] ([129.93.161.236])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ccd6f7d303sm1609562173.155.2024.08.16.19.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 19:08:53 -0700 (PDT)
Message-ID: <db480e4e-2601-488b-a2a6-2ee9272e0f93@gmail.com>
Date: Fri, 16 Aug 2024 21:08:52 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/3] tcp_cubic: fix to run bictcp_update() at least
 once per RTT
To: Neal Cardwell <ncardwell@google.com>
Cc: edumazet@google.com, davem@davemloft.net, netdev@vger.kernel.org,
 Lisong Xu <xu@unl.edu>
References: <20240815214035.1145228-1-mrzhang97@gmail.com>
 <20240815214035.1145228-2-mrzhang97@gmail.com>
 <CADVnQy=+Ad3cHHCxge37OKm=fHi6+aHyyy_0hp7p4VCSAGX4cw@mail.gmail.com>
Content-Language: en-US
From: Mingrui Zhang <mrzhang97@gmail.com>
In-Reply-To: <CADVnQy=+Ad3cHHCxge37OKm=fHi6+aHyyy_0hp7p4VCSAGX4cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/16/24 13:30, Neal Cardwell wrote:
> On Thu, Aug 15, 2024 at 5:41 PM Mingrui Zhang <mrzhang97@gmail.com> wrote:
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
>> Fixes: df3271f3361b ("[TCP] BIC: CUBIC window growth (2.0)")
>> Fixes: ac35f562203a ("tcp: bic, cubic: use tcp_jiffies32 instead of tcp_time_stamp")
>> Signed-off-by: Mingrui Zhang <mrzhang97@gmail.com>
>> Signed-off-by: Lisong Xu <xu@unl.edu>
>> ---
>> v2->v3: Corrent the "Fixes:" footer content
>> v1->v2: Separate patches
>>
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
> I'm getting a compiler error with our builds with clang:
>
> net/ipv4/tcp_cubic.c:230:46: error: comparison of distinct pointer
> types
> ('typeof (1000 / 32) *' (aka 'int *') and
> 'typeof (usecs_to_jiffies(ca->delay_min)) *' (aka 'unsigned long *'))
> [-Werror,-Wcompare-distinct-pointer-types]
>           (s32)(tcp_jiffies32 - ca->last_time) <= min(HZ / 32,
> usecs_to_jiffies(ca->delay_min)))
>
> Can you please try something like the following, which works for our build:
>
>            (s32)(tcp_jiffies32 - ca->last_time) <=
>            min_t(s32, HZ / 32, usecs_to_jiffies(ca->delay_min)))
>
> thanks,
> neal
Thank you, Neal,
We have tried your suggested changes, and they also work for our compile and experiment tests.
 
Thanks,
Mingrui

