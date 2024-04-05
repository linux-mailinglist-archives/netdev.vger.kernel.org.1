Return-Path: <netdev+bounces-85207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE35899C27
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 13:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FC90B21222
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 11:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE3A16C697;
	Fri,  5 Apr 2024 11:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKQeRtbK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF6B16190F
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 11:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712318160; cv=none; b=WVpoiozrZfjL57Ny3Lu3zdIe7mp+t58OiLcErgxx1vLrpvOsd46ZSw2dSIL6tecSvL9K3f89CyhRt46+eblkbZOY6Yi2rCFRPeP/3/hgRzsjV44jXkXNJjSA1d8aEuZS18VqQDQN3dnvKqRv16vnZ0V+G5ArYPqab+n8cTOd4q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712318160; c=relaxed/simple;
	bh=BaH3HUqETHBp+YDwb3eKkXbJdMc4upd2pVIADlznFyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vl3AXrv4g/lk+onKhdikgTNcSn7XNTaUqtuM14yMX95+nsm6rzzmoirR+O6LzWIPoghYSm4uha1tj9MD/kHRKWgvcgAznndKHhQsnSL0NJm2UmKcOzC1BPwn3H9cPEPAuWWkCgCB88nPJNy25+NUP/Ro5jICuBldlmlhqvjZEUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKQeRtbK; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so2327491a12.3
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 04:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712318157; x=1712922957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RFhGeI00lE+WP0SSLOUN/14s0MPc/IfXYrtMpjSb6xs=;
        b=cKQeRtbKqMikHIo/x0iNRPjtMhpF0X7UvNVSDH4bpyfTrEK0Rniel/7yjvFCY6d7id
         rqv3UlDUdGOUgTgXILAfDVsNdJxLO1S8g+uVhC1u9gFYsvOhh29OWsW8h37seZ9U/rt6
         TyYy3tz2NOzKIicJ1S0+5M5fg8rQax0qOtQOvWk9+BCWU2Kxy8VklsVDwTxGjYfxkDZD
         ki3PrXEGLM0oXQirRDrpIirVmWga9OQA/HAbxglafamJMDOb7qJ3iBLok1hGwderQK52
         UppZiDmh1Ku51NcAZXM7yktOcG5W8BRQh0ZQDcH8ZOHMySzTHZVPZYRMLUz1N61lBa5R
         mfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712318157; x=1712922957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RFhGeI00lE+WP0SSLOUN/14s0MPc/IfXYrtMpjSb6xs=;
        b=u/uuX35vPhbCAb8KTQbZF8X8j+dQkQhAWfxOpxES0tqr/Xeu5bmCJs6UYynmj6bE+f
         SrHewWNujS80lcYYsVKwEOn+pN2M5Ld7BW2r2MuZ0y/xJ+bJxm0wWkfPqhtK+TEhnVJ/
         51TVmcUL8JBjPiVp2j7EJpZw3EF47m4Y+SkH36DKuSTXu6kj/V4wIP2PyFTx0jx2C7g5
         CMX6gd5xfIZktrMoNhaxvYLlVBSZClzNd3zgNGcdoq2f18pjwENVWU/QsWBa736rGJE0
         ZfSgco/6aL7wfxc4K3fMD5VnoYrmXg1wIEoVAeHDGL+bQ6OziRlFyGGesEnJ/gxaWxOL
         Hj8g==
X-Gm-Message-State: AOJu0Yy5IAUemM1fn92i8xZC418iT46i26hTig5z4ipBU3E1jPtehAeh
	qvmvJp6C+DOHgB0jZXaqK5WVbwMPC3b9pqQpc7eq+R4TLTACDQ5t
X-Google-Smtp-Source: AGHT+IHq4KxrlEH2uRf1J3/BYp7RRWUsQZkvbzTM1aB22nR/jW+xjfd/NnV9xMz7dLm/LQZLq6Gilw==
X-Received: by 2002:a50:931d:0:b0:56e:3072:3cb4 with SMTP id m29-20020a50931d000000b0056e30723cb4mr908330eda.22.1712318157304;
        Fri, 05 Apr 2024 04:55:57 -0700 (PDT)
Received: from [192.168.42.78] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id w1-20020a056402128100b0056e2b351956sm706827edv.22.2024.04.05.04.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 04:55:57 -0700 (PDT)
Message-ID: <d475498f-f6db-476c-8c33-66c9f6685acf@gmail.com>
Date: Fri, 5 Apr 2024 12:55:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next v3] net: cache for same cpu
 skb_attempt_defer_free
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 pabeni@redhat.com, kuba@kernel.org
References: <00c5b7641c0c854b630a80038d0131d148c2c81a.1712270285.git.asml.silence@gmail.com>
 <CANn89i+XZtjD1RVBiFxfmsqZPMtN0156XgjUOkoOf8ohc7n+RQ@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CANn89i+XZtjD1RVBiFxfmsqZPMtN0156XgjUOkoOf8ohc7n+RQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/5/24 09:46, Eric Dumazet wrote:
> On Fri, Apr 5, 2024 at 1:38 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> Optimise skb_attempt_defer_free() when run by the same CPU the skb was
>> allocated on. Instead of __kfree_skb() -> kmem_cache_free() we can
>> disable softirqs and put the buffer into cpu local caches.
>>
>> CPU bound TCP ping pong style benchmarking (i.e. netbench) showed a 1%
>> throughput increase (392.2 -> 396.4 Krps). Cross checking with profiles,
>> the total CPU share of skb_attempt_defer_free() dropped by 0.6%. Note,
>> I'd expect the win doubled with rx only benchmarks, as the optimisation
>> is for the receive path, but the test spends >55% of CPU doing writes.
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>>
>> v3: rebased, no changes otherwise
>>
>> v2: pass @napi_safe=true by using __napi_kfree_skb()
>>
>>   net/core/skbuff.c | 15 ++++++++++++++-
>>   1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>> index 2a5ce6667bbb..c4d36e462a9a 100644
>> --- a/net/core/skbuff.c
>> +++ b/net/core/skbuff.c
>> @@ -6968,6 +6968,19 @@ void __skb_ext_put(struct skb_ext *ext)
>>   EXPORT_SYMBOL(__skb_ext_put);
>>   #endif /* CONFIG_SKB_EXTENSIONS */
>>
>> +static void kfree_skb_napi_cache(struct sk_buff *skb)
>> +{
>> +       /* if SKB is a clone, don't handle this case */
>> +       if (skb->fclone != SKB_FCLONE_UNAVAILABLE) {
>> +               __kfree_skb(skb);
>> +               return;
>> +       }
>> +
>> +       local_bh_disable();
>> +       __napi_kfree_skb(skb, SKB_DROP_REASON_NOT_SPECIFIED);
> 
> This needs to be SKB_CONSUMED

Net folks and yourself were previously strictly insisting that
every patch should do only one thing at a time without introducing
unrelated changes. Considering it replaces __kfree_skb, which
passes SKB_DROP_REASON_NOT_SPECIFIED, that should rather be a
separate patch.

-- 
Pavel Begunkov

