Return-Path: <netdev+bounces-118589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6769522B5
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 21:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005A71C21074
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 19:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F741BD510;
	Wed, 14 Aug 2024 19:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWq9AvHu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BAC1B3745
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 19:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723663996; cv=none; b=oKV+gJFv3GaHDjrAzypgpqUe4yFcZTpRyf9MY3S+7pAne2dJRkbQefE3PYASKniJB5ph/G+weeL5AwN/b5FJrIpT6vsd0PagAdJU0diN4Q8OskuwLRLC28dyzWqN6X/DH5Bff2q1ZDZGYsi+N4immmFxR8P+mtVeUlbHw7/aulM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723663996; c=relaxed/simple;
	bh=221+k140RfY74tJjioTON0oe9SPB04VePvD0Wct14Jo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ihsy8KvhQtG0EJknzHcyx1/D87hFDGTkrU5d5arxViq2kcMpAP5hKzTE6q+aiRhlLbyonn+vvw+ulMcOBMe5eSSHDZtPLy2aQgTd61j7wlUGW7gWS+Gx8LZXWL063ShziHTTJ4hrDOAP7fjYwg5Y/bqEzYjEj/InlwznDeNI618=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWq9AvHu; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-39b3a4d2577so833975ab.3
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 12:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723663994; x=1724268794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SaAysDLJoXhfWWG0LCZtF+7ZYPBucbWLfz7zO3yyvCs=;
        b=nWq9AvHuCrkQovI2A6tnwmclBb0pIFx99l/x9z9MeNBknc89kG83ptNk9ybkvQRE1V
         V9l71g6BcCb5UDMI/tsLdzypl05FiIzirfCIvghkgwckH7PBzcJnWMh4WmvzCF/pyRg3
         TvqY+ZnzGiCz2cQl0Tnj+k34HvV+4HfX21J9uS/pp2qulyEXRP2jJZSkKZLgV52IHGTw
         CzC1A+SUDCAVdDeuoFyeSNJeXG/cciAPdkUIeVUIM0YETS++7MBVxZN5oI5UL9cGbfrH
         /HtdTc8neKtEnvHDhaXrmeYs87i7GUCoIPSWT/hGv165etQcu9FDzlxJAztHeW3D1YWa
         WMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723663994; x=1724268794;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SaAysDLJoXhfWWG0LCZtF+7ZYPBucbWLfz7zO3yyvCs=;
        b=oINvmDXneXdnY6euK1tVX6W9sNnOeCN4TnH/7/Ocq8Oea/jSK+XoEozuAv72t/SDyR
         OkFlaAl/2zkrdez9fP0/MhXLc2QT62TSWCHMd148DwmIQNz/rkGRwhwmW96mx+wSM9Xa
         0akkybCwrj/daXgOw9x0XZdNBtXk6O1efx+kbPsskzBJHkTFirk8Hj6jA0T1JqaFavli
         W3jP2QX+6dAHZBRzgLNZOBUPt/juwZe3PF04CcqubL4tClL5x8WNrxqFiWCSBGBADw8k
         Gwgjja6QUMbKpTCHlhcsC4weexAcZwXwfypkF+XnltXGsdghg/juqt7z+ktSv/MBanBF
         WWmA==
X-Forwarded-Encrypted: i=1; AJvYcCXYDk/gpuoj1NX7vRxVYjMsZNru2OnT2MnS7DZxLIO5HSMdovRaCxER4/v/PGEHSEkh814WZCQ2pxD5NmCLoP3Sr31mn70i
X-Gm-Message-State: AOJu0YwIl00vqgLwt7XWxmYAcQXuC02nDDU6d0TDbzzkhRw0McWz6nHE
	dlWTdTwa7+Jnxtn4uf1bSQEqI02I3+QbAipsDxkvH5CWA2Q72Q4M
X-Google-Smtp-Source: AGHT+IFiHrB/Aa9tA0r7scphzmtm3LEid5ziWP6aB0RaKQ7eIatapUoHN46Ro7tsUtBiPy2+8WCO7w==
X-Received: by 2002:a05:6e02:1c21:b0:39b:38c5:fa4e with SMTP id e9e14a558f8ab-39d124b58b3mr49027745ab.19.1723663994124;
        Wed, 14 Aug 2024 12:33:14 -0700 (PDT)
Received: from [10.64.61.212] ([129.93.161.236])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39c30a8a221sm36379035ab.19.2024.08.14.12.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 12:33:13 -0700 (PDT)
Message-ID: <c3774057-ee75-4a47-8d09-a4575aa42584@gmail.com>
Date: Wed, 14 Aug 2024 14:33:12 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tcp_cubic fix to achieve at least the same throughput
 as Reno
To: Neal Cardwell <ncardwell@google.com>
Cc: edumazet@google.com, davem@davemloft.net, netdev@vger.kernel.org,
 Lisong Xu <xu@unl.edu>
References: <20240810223130.379146-1-mrzhang97@gmail.com>
 <CADVnQykdo-EyGeZxPjLEmAFcT9HyNU5ijvV53urHRcobhOLJHw@mail.gmail.com>
Content-Language: en-US
From: Mingrui Zhang <mrzhang97@gmail.com>
In-Reply-To: <CADVnQykdo-EyGeZxPjLEmAFcT9HyNU5ijvV53urHRcobhOLJHw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/13/24 20:59, Neal Cardwell wrote:
> On Sat, Aug 10, 2024 at 6:34 PM Mingrui Zhang <mrzhang97@gmail.com> wrote:
>> This patch fixes some CUBIC bugs so that  "CUBIC achieves at least
>> the same throughput as Reno in small-BDP networks"
>> [RFC 9438: https://www.rfc-editor.org/rfc/rfc9438.html]
>>
>> It consists of three bug fixes, all changing function bictcp_update()
>> of tcp_cubic.c, which controls how fast CUBIC increases its
>> congestion window size snd_cwnd.
> Thanks for these fixes! I had some patches under development for bugs
> (2) and (3), but had not found the time to finish them up and send
> them out... And I had not noticed bug (1).  :-) So thanks for sending
> out these fixes! :-)
>
> A few comments:
>
> (1) Since these are three separate bug fixes, in accordance with Linux
> development standards, which use minimal/narrow/focused patches,
> please submit each of the 3 separate fixes as a separate patch, as
> part of a patch series (ideally using git format-patch).
>
> (2) I would suggest using the --cover-letter flag to git format-patch
> to create a cover letter for the 3-patch series. You could put the
> nice experiment data in the cover letter, since the cover letter
> applies to all patches, and so do the experiment results.
>
> (3) Please include a "Fixes:" footer in the git commit message
> footeres, to indicate which patch this is fixing, to enable backports
> of these fixes to stable kernels. You can see examples in the Linux
> git history. For example, you might use something like:
>
> Fixes: df3271f3361b ("[TCP] BIC: CUBIC window growth (2.0)")
>
> You can use the following to find the SHA1 of the patch you are fixing:
>
>    git blame -- net/ipv4/tcp_cubic.c
>
> (4) For each patch title, please use "tcp_cubic:" as the first token
> in the patch title to indicate the area of the kernel you are fixing,
> and have a brief description of the specifics of the fix. For example,
> some suggested titles:
>
> tcp_cubic: fix to run bictcp_update() at least once per round
>
> tcp_cubic: fix to match Reno additive increment
>
> tcp_cubic: fix to use emulated Reno cwnd one round in the future
>
> (5) Please run ./scripts/checkpatch.pl to look for issues before sending:
>
>   ./scripts/checkpatch.pl *patch
>
> (6) Please re-test before sending.

Thank you, Neal.
I appreciate your comments on the patch format, and I will follow your detailed instructions on patches.

>> Bug fix 1:
>>         ca->ack_cnt += acked;   /* count the number of ACKed packets */
>>
>>         if (ca->last_cwnd == cwnd &&
>> -           (s32)(tcp_jiffies32 - ca->last_time) <= HZ / 32)
>> +           (s32)(tcp_jiffies32 - ca->last_time) <= min(HZ / 32, usecs_to_jiffies(ca->delay_min)))
>>                 return;
>>
>>         /* The CUBIC function can update ca->cnt at most once per jiffy.
>>
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
>> Bug fix 2:
>>         if (tcp_friendliness) {
>>                 u32 scale = beta_scale;
>>
>> -               delta = (cwnd * scale) >> 3;
>> +               if (cwnd < ca->bic_origin_point)
>> +                       delta = (cwnd * scale) >> 3;
>> +               else
>> +                       delta = cwnd;
>>                 while (ca->ack_cnt > delta) {           /* update tcp cwnd */
>>                         ca->ack_cnt -= delta;
>>                         ca->tcp_cwnd++;
>>                 }
>>
>> The original code follows RFC 8312 (obsoleted CUBIC RFC).
>>
>> The patched code follows RFC 9438 (new CUBIC RFC).
>>
>> "Once _W_est_ has grown to reach the _cwnd_ at the time of most
>> recently setting _ssthresh_ -- that is, _W_est_ >= _cwnd_prior_ --
>> the sender SHOULD set α__cubic_ to 1 to ensure that it can achieve
>> the same congestion window increment rate as Reno, which uses AIMD
>> (1,0.5)."
> Since ca->bic_origin_point does not really hold _cwnd_prior_ in the
> case of fast_convergence (which is very common), I would suggest using
> a new field, perhaps called ca->cwnd_prior, to hold the actual
> _cwnd_prior_ value. Something like the following:
>
> -               delta = (cwnd * scale) >> 3;
> +               if (cwnd < ca->cwnd_prior)
> +                       delta = (cwnd * scale) >> 3;
> +               else
> +                       delta = cwnd;
>
> Then, in __bpf_kfunc static u32 cubictcp_recalc_ssthresh(struct sock *sk):
>
>          else
>                  ca->last_max_cwnd = tcp_snd_cwnd(tp);
>         +ca->cwnd_prior = tcp_snd_cwnd(tp);
>
> How does that sound?

Adding a new field is a good suggestion, and we will refine the patch accordingly.

>
> Thanks again for these fixes!
>
> Best regards,
> neal

Thank you for your valuable suggestions.

Best,
Mingrui


