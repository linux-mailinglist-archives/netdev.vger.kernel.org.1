Return-Path: <netdev+bounces-214179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2937B286FB
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 22:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51E7216E818
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 20:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB85829B8C7;
	Fri, 15 Aug 2025 20:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArIU8Aly"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4D81A9F9D;
	Fri, 15 Aug 2025 20:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755288851; cv=none; b=PLzb6hvXGCfkMU23OtZiozmcPbkYjHWh6l6wlAC+1YZvbcMouRvt4BHAV3p+gFexM3Y5EFAsKWqP6XwAo0/IAo1gBkm++7vJePGnQFu9wCIC2ASzIpXd5sq5f+bz0EqvE5Xz48NjbTr/WK69dc6DJLZj2aunl5YTvgPgaRXMx18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755288851; c=relaxed/simple;
	bh=OVuyTG5nhwMFG0/VcvCQJLlP8ZSEufOwxgfWizbedKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLDVhtLXsL+vset3x5EczSaNc+v/JGCALtBleQOkcB9wxq08DrZWQN/1BP9uF4Zdg33ptnZdx5csj9enCd2IlJq/HfLLBFTtnuyjBssAVdD2sWE9RSSnQbPlq5FuiPuZtKHjEAKok3n7G2OJZK0yBkIyAci85HA7JX873qum/Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArIU8Aly; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb78d5dcbso330894966b.1;
        Fri, 15 Aug 2025 13:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755288848; x=1755893648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=COhSb7HrWWdD2eumi5rQzVn0swC6LORO2wNxh+3c4p4=;
        b=ArIU8AlyDKsx8zmTMmcNkjD5PvCxGF8qwz1bgHh38OfiEO1BYbsQ3Xm6UOa6r52s4E
         WVJR7DhsPPVA8S0NTaoCwTdYCI1050rsB4iUwuXSZyfPD84kdqKm7rOkaK0l50+i+VYc
         x3J9wo1+fGBw/OkWRR3L8ciUHci/jj6mZTcjVtwA/yIMqAtXvYf4WvIuXnezAIgi3Tre
         wbwJQXQmCXc41Um4cW5KrU4q42UK6qTHV+g+7fAG7T3fmGaPA04d3nH/Ye3vI2kZuqSv
         yR9vFHamNvY7Ksi91AJLF0Dnbji1JVdiMsM+wdxRiFp50jWV99ODFjqG01OdHPOMdgEE
         +IOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755288848; x=1755893648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=COhSb7HrWWdD2eumi5rQzVn0swC6LORO2wNxh+3c4p4=;
        b=vkGVMRPbEr82nnCjhju88peGK22XEHjJR7FxPhClWE2hkZ0dY+u0BZZcw2B94KOJXx
         ERTmHyACHD5XhKPC70iAdVGHJ9UN0MU+Bvys6MML4q1fTHYoVWt0WKWojHd8Bkp583Z+
         L0fzazN85L/W4scJK9XgU2v35VD5JzsG2Wb8zTAbv2q/kDBGfh/7fUYj7ogifkG1ERka
         en0hBFfT88hfuPeeyF1tDTYHH1aHPfgGnobzoCjCo+SK19wPSyg9zZrQIe2SEDpbrCjO
         +FHpUkoQpWLC2HDU7vukf23EOls1t25VKuBp40wdXMnRkMNl3ZdCcMi1LOaT7FNEGc9S
         Qc1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBFLVonyk8IF8D8uTrGV/KZqRJYzo4sueRxvKJ4pBNF61pXYogxhDkFO1FvJOPfH5oDo4hspVe@vger.kernel.org, AJvYcCWsKx7mb0xbFylgT5y7G5LFNSK4dFGhJo8h7i4nVFi+ZjhwT7BJRVlWV/VsZKPkAwl77vu55Z+xtxX01YE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ8dKAyp0WXBlEgkupuL1D+ZRO4Vax1A/o4uHNlbIFj4OknDd3
	INu4GoLDndLpUtzxAH+nKkUnV26i2ra1hgvNIqzjbFolsp5ttswmsWeK
X-Gm-Gg: ASbGncvpUvh2Lf2KmjC5O/uB6scTWLULhJScK83dEIY5xKmhdEbNHPqT+15P9r6Ra9U
	tLGXuQ36PyyET7EjAQZU9/7iJhu5V/P/10JQFe0F7CfYrkSrChIjetfxuSFHc6B3yEFWk3JQ6pL
	6eXH4QhRyifp/0dqEVzDTH7EpOEdsvfpWnBo/7qlf2ERazX6WiwQxTPGVKdj36ndqZ99ePBMblD
	poDwEn4w5FQJ9dK/KxHNHMzi1RRkpZwUBMJ6ZrQp1HnNwf7kGx7uIrWxwRNYKAE+rRCo95EnXWJ
	zL3xGQzCwRB6ESv2c68vmPgXro4CH/awa3H4706GLG9sCqKIcChtUzpc2QZuFetcBQZQMAqe48U
	mN+p1KG+hWLjIBP8VlN8zcLtGcl/+teqA
X-Google-Smtp-Source: AGHT+IGhaqijyQFoFzM8w64aYLTtJpGY+cHcW4Cpo+Dh+QYVANebZy8fOXOSzUZWqeSyiZ4t4U8Z5g==
X-Received: by 2002:a17:907:60d6:b0:ae3:4f99:a5aa with SMTP id a640c23a62f3a-afcdc206232mr313713966b.4.1755288847938;
        Fri, 15 Aug 2025 13:14:07 -0700 (PDT)
Received: from [192.168.8.100] ([148.252.132.122])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdcfcb2d1sm207666766b.62.2025.08.15.13.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 13:14:07 -0700 (PDT)
Message-ID: <ac041a47-98b1-4fac-86d7-487421b939e9@gmail.com>
Date: Fri, 15 Aug 2025 21:15:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 00/24] Per queue configs and large rx buffer support for
 zcrx
To: Dragos Tatulea <dtatulea@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, Willem de Bruijn
 <willemb@google.com>, Paolo Abeni <pabeni@redhat.com>,
 andrew+netdev@lunn.ch, horms@kernel.org, davem@davemloft.net,
 sdf@fomichev.me, almasrymina@google.com, dw@davidwei.uk,
 michael.chan@broadcom.com, ap420073@gmail.com, linux-kernel@vger.kernel.org
References: <cover.1754657711.git.asml.silence@gmail.com>
 <ul2vfq7upoqwoyop7mhznjmsjau7e4ei2t643gx7t7egoez3vn@lhnf5h2dpeb5>
 <dbd3784b-2704-4628-9e48-43b17b4980b1@gmail.com>
 <rekaw6n6fsfkh46tbkyms47wjf7cdllwsihpsvp46bcrhxsxp4@ytymllzp72u6>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <rekaw6n6fsfkh46tbkyms47wjf7cdllwsihpsvp46bcrhxsxp4@ytymllzp72u6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/15/25 17:44, Dragos Tatulea wrote:
> On Thu, Aug 14, 2025 at 11:46:35AM +0100, Pavel Begunkov wrote:
...>> "-A1" here is for using huge pages, so don't forget to configure
>> /proc/sys/vm/nr_hugepages.
>>
>> # client
>> examples/send-zerocopy -6 tcp -D <ip addr> -p <port>
>>                         -t <runtime secs>
>>                         -l -b1 -n1 -z1 -d -s<send size>
>>
> Thanks a lot for the branch and the instructions Pavel! I am playing
> with them now and seeing some preliminary good results. Will post
> them once we share the patches.

Sounds good

>> I had to play with the client a bit for it to keep up with
>> the server. "-l" enables huge pages, and had to bump up the
>> send size. You can also add -v to both for a basic payload
>> verification.
>>
> I see what you mean. I also had to make the rx memory larger once

Forgot to mention that the tool doesn't consider CPU affinities,
so I had to configure task and irq affinities by hand.

> rx-buf-len >= 32K. Otherwise the traffic was hanging after a second or
> so. This is probably related to the currently known issue where if a
> page_pool is too small due to incorrect sizing of the buffer, mlx5 hangs
> on first refill. That still needs fixing.

-- 
Pavel Begunkov


