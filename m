Return-Path: <netdev+bounces-119892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7235D9575C4
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 22:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29AB8283541
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 20:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BB915A87B;
	Mon, 19 Aug 2024 20:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jz5B4GRk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8076115A865
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 20:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724099766; cv=none; b=Dhi8qaO+OJJi7vrx+4OftgIOxU+gM7udxMbD70rsVaEq3CL+C+rUngyHC+ScAxVBbO1Mqzhuoxglw+xKay7CgCFcB4wDyqBCNclyUst5+lEcM8INcIaduwiUwtVORgps/xewkZIsGDuVbq0cxYosD1J8TvrctApNg940HgXR368=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724099766; c=relaxed/simple;
	bh=FmtN5mSr/DMJQjcJYp5hV4BTgJ/0W4lO/ULDziYHPuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HdfXLq5AdklfLtuGqEgEvEG47hOpM+ZKCQtxxv9QxFZzvBWa08TfdEEVKLxnAYpfTsqydKp96LkcdCVS9l8UOhuklfv1bGKJ0Is8SK/J6KE14qIvfgTccHYXKOmCNu4Sfm3yAlDDjWrTJkfdg74lOvCEGs5OUk5wniDgzgUBLKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jz5B4GRk; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-39d2e4d73bcso12314135ab.1
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 13:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724099763; x=1724704563; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SeaWSJ1lhdQoAfviB1aV+IvqYuXAqXEbjPeGzVPN2jI=;
        b=Jz5B4GRkVlMEw5KkuqhOTjZDtVU5h3UhXaQEcM/sek5jqUqHlTA4fhviZAaiTW4zt3
         64OsKwDxmHweadKbteUImu7Mi/+S4kYHJZvbCxcl7PmBtk3ynfKVM+XQwRrgWmUmubW+
         dJ6jJT7aMfS+xzbuYUDt/XBowghF8Lxqe019Pqy+7JZpZVHfNqgKe5d9iDCenC9NjrU4
         deAew+SNWdzl3gvaJIaNH66wcoD3cE+P7Dnhfh2TUqaBM/HjL2ywlaBvy0hdoYEsTXLQ
         VuHJp8/FvTkebYOYxWXSmzLib7Uv2zGriN78qKpU661gdVCfjYWj8y+x+5g8k/f65es8
         Et/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724099763; x=1724704563;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SeaWSJ1lhdQoAfviB1aV+IvqYuXAqXEbjPeGzVPN2jI=;
        b=CBEBvoa1fiT+IjQFGPrd96fdh6kl/6+JXn7+ks743VNnp+Vg5AQ9QVd8jdvEJ7dWWY
         dm4oCW4FiWtnlLfxQnL7JiXc+CiEw3ohp+vFKmgbfTb6Dsp+A5R0ZM3HldoB5MdLGpEJ
         Af1TfsrGHBbrYU9KvJLRJfUX1vb3LvZDpr3FbZqhFoZ81ul6a7dgMS09sY+wi0ZpkZQd
         vZaPrZ4zM5fHEHvrlE8lgRlCyfN3bq/oJe2JXJFXyrXqnA52aE5/h6dej83H3SSqjJwR
         SpTw2sBhLJVtthwMqpsL+eDLXadaIPSMUa2Lf49C9R9rpt37YBtOLVYPKVK2sfIwIRZx
         fjhw==
X-Forwarded-Encrypted: i=1; AJvYcCWTpoqesBerX3Bf+Cc9Hznyi9b9RtyZLI6nmrqqKeJk9/9zWf2Fvz1EV7rdLfk3vnS0wpSBMAbOHg71bsqc++SZiAaUhMTm
X-Gm-Message-State: AOJu0YwJiBVgUhV/UB5YOl2bZAnt6FdtEDcAwava5B2qhih8o5uH7xJ8
	1w4CYg18B50H35TV6BVuGtfe+tcEYu3txde9oKim9g7bps1tQQi3
X-Google-Smtp-Source: AGHT+IHX4ZxIhN7pIL3I1AD7nYbhhvmet51bRh+V8H6F6dK9KGVVeUyFXbIEKrHTx80hgqxjHAFzzA==
X-Received: by 2002:a05:6e02:1d1a:b0:39a:eb81:ff9a with SMTP id e9e14a558f8ab-39d585676a9mr1373305ab.10.1724099763356;
        Mon, 19 Aug 2024 13:36:03 -0700 (PDT)
Received: from [10.64.61.212] ([129.93.161.236])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ccd6f74b57sm3271235173.130.2024.08.19.13.36.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 13:36:03 -0700 (PDT)
Message-ID: <573e24dc-81c7-471f-bdbf-2c6eb2dd488d@gmail.com>
Date: Mon, 19 Aug 2024 15:36:02 -0500
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
Content-Language: en-US
From: Mingrui Zhang <mrzhang97@gmail.com>
In-Reply-To: <CANn89iKwN8vCH4Dx0mYvLJexWEmz5TWkfvCFnxmqKGgTTzeraQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/19/24 04:00, Eric Dumazet wrote:
> On Sat, Aug 17, 2024 at 6:35 PM Mingrui Zhang <mrzhang97@gmail.com> wrote:
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
> I do not understand this Fixes: tag ?
>
> Commit  ac35f562203a was essentially a nop at that time...
>
I may misunderstood the use of Fixes tag and choose the latest commit of that line.
 
Shall it supposed to be the very first commit with that behavior?
That is, the very first commit (df3271f3361b ("[TCP] BIC: CUBIC window growth (2.0)")) when the code was first introduced?
>> Signed-off-by: Mingrui Zhang <mrzhang97@gmail.com>
>> Signed-off-by: Lisong Xu <xu@unl.edu>
>> ---
>> v3->v4: Replace min() with min_t()
>> v2->v3: Correct the "Fixes:" footer content
>> v1->v2: Separate patches
>>
>>  net/ipv4/tcp_cubic.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
>> index 5dbed91c6178..00da7d592032 100644
>> --- a/net/ipv4/tcp_cubic.c
>> +++ b/net/ipv4/tcp_cubic.c
>> @@ -218,8 +218,12 @@ static inline void bictcp_update(struct bictcp *ca, u32 cwnd, u32 acked)
>>
>>         ca->ack_cnt += acked;   /* count the number of ACKed packets */
>>
>> +       /* Update 32 times per second if RTT > 1/32 second,
>> +        * or every RTT if RTT < 1/32 second even when last_cwnd == cwnd
>> +        */
>>         if (ca->last_cwnd == cwnd &&
>> -           (s32)(tcp_jiffies32 - ca->last_time) <= HZ / 32)
>> +           (s32)(tcp_jiffies32 - ca->last_time) <=
>> +           min_t(s32, HZ / 32, usecs_to_jiffies(ca->delay_min)))
> This looks convoluted to me and still limited if HZ=250 (some distros
> still use 250 jiffies per second :/ )
>
> I would suggest switching to usec right away.
Thank you for the suggestion, however, I may need more time to discuss with another author for this revision. :)
Thank you
>
> diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
> index 5dbed91c6178257df8d2ccd1c8690a10bdbaf56a..fae000a57bf7d3803c5dd854af64b6933c4e26dd
> 100644
> --- a/net/ipv4/tcp_cubic.c
> +++ b/net/ipv4/tcp_cubic.c
> @@ -211,26 +211,27 @@ static u32 cubic_root(u64 a)
>  /*
>   * Compute congestion window to use.
>   */
> -static inline void bictcp_update(struct bictcp *ca, u32 cwnd, u32 acked)
> +static inline void bictcp_update(struct tcp_sock *tp, struct bictcp *ca,
> +                                u32 cwnd, u32 acked)
>  {
>         u32 delta, bic_target, max_cnt;
>         u64 offs, t;
>
>         ca->ack_cnt += acked;   /* count the number of ACKed packets */
>
> -       if (ca->last_cwnd == cwnd &&
> -           (s32)(tcp_jiffies32 - ca->last_time) <= HZ / 32)
> +       delta = tp->tcp_mstamp - ca->last_time;
> +       if (ca->last_cwnd == cwnd && delta <= ca->delay_min)
>                 return;
>
> -       /* The CUBIC function can update ca->cnt at most once per jiffy.
> +       /* The CUBIC function can update ca->cnt at most once per ms.
>          * On all cwnd reduction events, ca->epoch_start is set to 0,
>          * which will force a recalculation of ca->cnt.
>          */
> -       if (ca->epoch_start && tcp_jiffies32 == ca->last_time)
> +       if (ca->epoch_start && delta < USEC_PER_MSEC)
>                 goto tcp_friendliness;
>
>         ca->last_cwnd = cwnd;
> -       ca->last_time = tcp_jiffies32;
> +       ca->last_time = tp->tcp_mstamp;
>
>         if (ca->epoch_start == 0) {
>                 ca->epoch_start = tcp_jiffies32;        /* record beginning */
> @@ -334,7 +335,7 @@ __bpf_kfunc static void cubictcp_cong_avoid(struct
> sock *sk, u32 ack, u32 acked)
>                 if (!acked)
>                         return;
>         }
> -       bictcp_update(ca, tcp_snd_cwnd(tp), acked);
> +       bictcp_update(tp, ca, tcp_snd_cwnd(tp), acked);
>         tcp_cong_avoid_ai(tp, ca->cnt, acked);
>  }


