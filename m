Return-Path: <netdev+bounces-119348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0016E95548E
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 03:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D3141C2191F
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 01:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D318256E;
	Sat, 17 Aug 2024 01:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLsl0z1o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54F6443D
	for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 01:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723857683; cv=none; b=LK6dEPeO0jMpCEBpexyZKgTw4McWkKEM9uGsgS2ky0sxB9wm4L8KIgzGU2xLX5BRJOoilkjC0FKFvHT3PCI6I9YyWLLVYFJUfPj0yoc4nBkbffJNlaqUnYcH3ZW5efsp3H/keDhfdLzwNy0H2JHRzX8+PGoz+WiG8y68Bj7cjJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723857683; c=relaxed/simple;
	bh=OODqXCiJhPg+woCiq8WXdhOYLTNaos/7DCZCEwdXbew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rukl830KNvXfOT+tFN/Gb2ykBEfNi+ve4lsLCdpifnLOYT4NiPWNa/LWV3utdzA+j22eFWltvUFvK5IxaDyckHsZyN8GRFEIlE4hW2aYa6iiT9ZP8GRJlaLBxZK09Sp8fl2M1w4D6fjGcP421QKtNlkwP778FdAd2CubbyRwWPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLsl0z1o; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5d80752933bso1786667eaf.1
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 18:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723857680; x=1724462480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zXsUlx6Cs7x36yRBAbFP5lgG0Pv/3uIBTBdlRBKKqpg=;
        b=OLsl0z1oD08B6TLKBPq/aypL0GyNJykmTktaT9o4KpMjJxXTyU3ZJaLEnxJyNBcQ7w
         IaRDOT1ANJuU6AQDpYfPQoVOeeZCZgpedqba7veXGybxGPcxMNAIjC46QkiJhWzfNb/8
         51yH/mfLC+RwbMZrzwSYI/YaTy/ecVcjfs+tnU0wKzNAliddlTZMF0tCjitAfj/i0D6G
         nGJDMcGkDMOv4xhuMyRV3zPLUcm4CPJHCsOa/4erHBW9HOIoVPQVqb2/Dj2ouGvsLEIs
         Sc3RH1Zwv/769V0OYaWZIXPi3PkKAafmAcfqqOsB+zFvrJyvEylw9z2BsTItsFha6w2G
         d/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723857680; x=1724462480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zXsUlx6Cs7x36yRBAbFP5lgG0Pv/3uIBTBdlRBKKqpg=;
        b=jJLSOKZQjkizWlqp4gk4NmbczIZhFrBVyCteQaSS42Lnjhl4U8BZtNLW91RqSI4ZgO
         YZfbDUFmXig+1KOmskfJxGUGmrEOaTgwTcj5rMkDXFDHM7g9E5J1h3HnrBvrGQbDz6KV
         42dOH63pStLf7JRrkpTU1FdsotssGmUPZbS9smQW+SIedCUs8CGxatHUbXXzcAPz+liS
         XTj2As5n8mmVI2+q330xg5MfwNipafX+1EcpEYzLmOUa3x16mCnvZexmkZ9tjOrQ2AKK
         KyicuvH9P1xeXTYmm3BgcYY8nSjO8xz88Udc+uh1xjijgeVEdW3Ut0ygJsToEQITQis4
         UERA==
X-Forwarded-Encrypted: i=1; AJvYcCXByWA4zD6DXUGQNNyoX3LVEX+xJEHw2HGl9MB7VTuYvcQSRgabpsH/NgggUzfQlLy0yzyZSCuq+6Bk9QcmAVMpovjy1HKe
X-Gm-Message-State: AOJu0Yzqo5+owSCi4RsjImSc40Ly4yvMeWcjUCMVUKHWAn0NAPP+7eEy
	6jTe9PPPuYQaXVpDkv8jVK8GPgO4aXJVwXb2NjTo2BknCpNlHmFH
X-Google-Smtp-Source: AGHT+IF0mtPrumJFQx0mlav1Ul6vwsQYIZVV5FUqQpLsdrvKDrR/SgA1NL0V8P/XXo1F+uB+2mQDlQ==
X-Received: by 2002:a05:6359:a396:b0:1ac:f854:b68 with SMTP id e5c5f4694b2df-1b393312c35mr572877455d.29.1723857680565;
        Fri, 16 Aug 2024 18:21:20 -0700 (PDT)
Received: from [10.64.61.212] ([129.93.161.236])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff02c8a7sm232681585a.16.2024.08.16.18.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 18:21:20 -0700 (PDT)
Message-ID: <b91e1160-24c0-42c5-8a71-b10b3421147b@gmail.com>
Date: Fri, 16 Aug 2024 20:21:19 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 3/3] tcp_cubic: fix to use emulated Reno cwnd one
 RTT in the future
To: Neal Cardwell <ncardwell@google.com>
Cc: edumazet@google.com, davem@davemloft.net, netdev@vger.kernel.org,
 Lisong Xu <xu@unl.edu>
References: <20240815214035.1145228-1-mrzhang97@gmail.com>
 <20240815214035.1145228-4-mrzhang97@gmail.com>
 <CADVnQy=URvcxoU70b0TMJ9gpYVWgKE_CNwQXrP9r2ZJ3EGWgfg@mail.gmail.com>
Content-Language: en-US
From: Mingrui Zhang <mrzhang97@gmail.com>
In-Reply-To: <CADVnQy=URvcxoU70b0TMJ9gpYVWgKE_CNwQXrP9r2ZJ3EGWgfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/16/24 13:32, Neal Cardwell wrote:
> On Thu, Aug 15, 2024 at 5:41 PM Mingrui Zhang <mrzhang97@gmail.com> wrote:
>> The original code estimates RENO snd_cwnd using the estimated
>> RENO snd_cwnd at the current time (i.e., tcp_cwnd).
>>
>> The patched code estimates RENO snd_cwnd using the estimated
>> RENO snd_cwnd after one RTT (i.e., tcp_cwnd_next_rtt),
>> because ca->cnt is used to increase snd_cwnd for the next RTT.
>>
>> Fixes: 89b3d9aaf467 ("[TCP] cubic: precompute constants")
>> Signed-off-by: Mingrui Zhang <mrzhang97@gmail.com>
>> Signed-off-by: Lisong Xu <xu@unl.edu>
>> ---
>> v2->v3: Corrent the "Fixes:" footer content
>> v1->v2: Separate patches
>>
>>  net/ipv4/tcp_cubic.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/ipv4/tcp_cubic.c b/net/ipv4/tcp_cubic.c
>> index 7bc6db82de66..a1467f99a233 100644
>> --- a/net/ipv4/tcp_cubic.c
>> +++ b/net/ipv4/tcp_cubic.c
>> @@ -315,8 +315,11 @@ static inline void bictcp_update(struct bictcp *ca, u32 cwnd, u32 acked)
>>                         ca->tcp_cwnd++;
>>                 }
>>
>> -               if (ca->tcp_cwnd > cwnd) {      /* if bic is slower than tcp */
>> -                       delta = ca->tcp_cwnd - cwnd;
>> +               /* Reno cwnd one RTT in the future */
>> +               u32 tcp_cwnd_next_rtt = ca->tcp_cwnd + (ca->ack_cnt + cwnd) / delta;
>> +
>> +               if (tcp_cwnd_next_rtt > cwnd) {  /* if bic is slower than Reno */
>> +                       delta = tcp_cwnd_next_rtt - cwnd;
>>                         max_cnt = cwnd / delta;
>>                         if (ca->cnt > max_cnt)
>>                                 ca->cnt = max_cnt;
>> --
> I'm getting a compilation error with clang:
>
> net/ipv4/tcp_cubic.c:322:7: error: mixing declarations and code
> is incompatible with standards before C99
> [-Werror,-Wdeclaration-after-statement]
>     u32 tcp_cwnd_next_rtt = ca->tcp_cwnd + (ca->ack_cnt + cwnd) / delta;
>
> Can you please try something like the following:
>
> -               u32 scale = beta_scale;
> +               u32 scale = beta_scale, tcp_cwnd_next_rtt;
> ...
> +               tcp_cwnd_next_rtt = ca->tcp_cwnd + (ca->ack_cnt + cwnd) / delta;
>
> Thanks!
> neal
Thank you, Neal,
We have tried your suggested changes, and they also work for our compile and experiment tests.
We did not find this issue because we have only tried to compile with the default Makefile with GCC.
I agree with your changes, it is conform to the existing codes and compatible with that standards.

Thanks,
Mingrui

