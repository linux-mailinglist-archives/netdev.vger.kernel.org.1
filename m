Return-Path: <netdev+bounces-218338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A239AB3C096
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 18:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ADCE585227
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 16:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CA0326D54;
	Fri, 29 Aug 2025 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="YGS2dCDM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAE732C320
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 16:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756484613; cv=none; b=aYx7ZiWLrRfm2F5PZiYiatR4SA1Osn0zNnp9OmoKuHaVnhqBQWkv8aQbASdaXLgBmYRWNbJCWXz2MnvA3WnngRiCS3vE+BHab3CdTxIVnqhy5YxDLBCeR1l65orab6gFZ5CEQbvsnj6FVBAdFNLzzPGEh2//ga5+MZAoQ/hSAHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756484613; c=relaxed/simple;
	bh=IEH6aCSgySsvmxeMGyD6vtz2AyYfOBhMUEbE5AuvFws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EKROefP/KZZs6Uu/hzk9CszPjHjHpjb7EzCvl5fuRUdBbF7K9WiVpAF/wWTxE2E4yLzBNdz0XVU89ZCm6wMCL7rqVxWfpUGltq8fWJyaEYaxs7g4QOjJmmgCdt+lXutzNML2iwzFENX6L+ydpvFegIQ98X5uULstIisE8BhV1sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=YGS2dCDM; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55f474af957so2638338e87.1
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 09:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1756484610; x=1757089410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HXohgHhMg5Bl8uDBsv9pYaNNFIL5EofYTOVHQXzVcrk=;
        b=YGS2dCDMS9XUfLKpohJWkXpge77RQbgPfn3CTlT/7iUsiD/V1a1zhHYt6cv89hKdoN
         /sNDWoIcM7U8FeLscHnb7amSX2NE8n8v9dYUdScpJumYV8rnbGdFrn6Ce3m14lrl24V8
         zLvkJHH2j/FnvdC6zH6CPnaSfA2TM/ORU6VkWKWtjhA3Mn129AAFxTai3GwOAiUgOHe3
         ruyF8FblqmNcNxlHlxAvkup3QpkDsfxpwsc5mouSC3fHiw4AqHfxHEURrcNo18NJo6yr
         eq+9LkTJhyd32bjo1itZjiW/GlF6eZFsD88pothhtEaahI95mZh9YzMO+co7BT5Y7ucr
         5MUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756484610; x=1757089410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HXohgHhMg5Bl8uDBsv9pYaNNFIL5EofYTOVHQXzVcrk=;
        b=eizGn0lobhJYZNwgKubr0De1Afu6lJbXyikKuU8cA4xlvztP+cvLS27yzmNqg4cWr0
         gEoKfuqVvFk2eKnwJlRaj3K0WIJtNi56Mgui9xrMHZv9bOh1a8zsKmfYZFlelOFi3DPa
         Ylo2FN40YzE8YdtBP6iypQ4EsL7GdQkM0wdvEerFLEoGA8eTdKk8jfhwcLL+gj5xV5ru
         pjQ0NTai59f+upw5dUvvs/LSNWGrpi5bd1lBld2F9hD+shUtNTkU9yQ10iyfGOJ4WjZL
         6a52Nh7O7gdtkMAKqrMmgqvkVRRahZDCr13ss0H431XHMTDX/jh42EVeZ26m0bKWf3zu
         44KA==
X-Forwarded-Encrypted: i=1; AJvYcCVVsCyqpd52D/hg9c0NwZO3gvWjn2/feltt4mVbgu6qiE1q9xeVZoiVzVuendoVNv1v/v32ud4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAsGPuUfmG7FdA22TBVbD5QkY7pOnJObT5aEoNqrIb53PEoyCU
	VrHN31FBuMzYQXx+BP+Tfo59dmnsCs6TXUupyYppW4oYBaMPyArd/eYySIgUNY3V9Tw=
X-Gm-Gg: ASbGncsOayRZ9rg1gxqCc8Cn7ENbtB/GVnoFKAJF5Iz+C06uGEoAqyThD5PDYpcgt97
	LuiamgauI21K/F1peXa/3OxgOf6ZV4UI49QUstTyA+Ha5PKfwMXDmKhk+ICJRELTemLM77yAqjv
	RoGXxe4WrA4NdZqQ8qiVrD/FuePdp1bbUoN/2mKQnFTwkUyG/uat06KZNRZf//7p9XI92TcwINe
	Yd/sMz2HtVQGDyL8IWSlq9sAXXrgMthZiYUKoYcjLLyrKlGHkaud+wzddgc8y0/JCyNUwxsHaoJ
	AxT0w1maKnJh1BagRbQ++/v7qyasgimswH77FM5FMaxY6vdQZkTSXjJ6fTKT2vukw/dIQ8IcMPT
	rG28yFPoCQt/DytA4stSDVom7KVEXvgjZyDGDUNKF1a4q0d0vo0v/8sutmByjWbtxLIzhkDP/f0
	4THw==
X-Google-Smtp-Source: AGHT+IGkDyVgClqPhi+jy/rUB2ZmKr6ERUVBat7raNEZp8G3QswM+s5vCryFnVhmubSoyKXakx8cmA==
X-Received: by 2002:a2e:a99c:0:b0:336:bcbf:9e with SMTP id 38308e7fff4ca-336bcbf06ffmr6988971fa.20.1756484609848;
        Fri, 29 Aug 2025 09:23:29 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-336b468ac23sm5215941fa.23.2025.08.29.09.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 09:23:29 -0700 (PDT)
Message-ID: <bfb11627-64d5-42a0-911e-8be99e222396@blackwall.org>
Date: Fri, 29 Aug 2025 19:23:24 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] net: bridge: reduce multicast checks in fast path
To: Jakub Kicinski <kuba@kernel.org>, =?UTF-8?Q?Linus_L=C3=BCssing?=
 <linus.luessing@c0d3.blue>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>,
 Kuniyuki Iwashima <kuniyu@google.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Xiao Liang <shaw.leon@gmail.com>
References: <20250829085724.24230-1-linus.luessing@c0d3.blue>
 <20250829084747.55c6386f@kernel.org>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250829084747.55c6386f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/29/25 18:47, Jakub Kicinski wrote:
> On Fri, 29 Aug 2025 10:53:41 +0200 Linus Lüssing wrote:
>> This patchset introduces new state variables to combine and reduce the
>> number of checks we would otherwise perform on every multicast packet
>> in fast/data path.
>>    
>> The second reason for introducing these new, internal multicast active
>> variables is to later propagate a safety mechanism which was introduced
>> in b00589af3b04 ("bridge: disable snooping if there is no querier") to
>> switchdev/DSA, too. That is to notify switchdev/DSA if multicast
>> snooping can safely be applied without potential packet loss.
> 
> Please leave the git-generated diff stat in the cover letter.
> Please include tree designation in the subject, per:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
> 
> I'll leave the real review to the experts but this series appears
> to make kselftests unhappy:
> 

just fyi my email wasn't working for 2 days and unfortunately I missed this set
I took a look now on patchwork, I do have comments but it's difficult to reply as
I don't have the emails and have to do it manually to each, so I'd rather wait
for v2.

a few notes for v2:
- please use READ/WRTE_ONCE() for variables that are used without locking
- please make locking symmetric, I saw that br_multicast_open() expects the lock to be already held, while
   __br_multicast_stop() takes it itself
- target net-next
- is the mcast lock really necessary, would atomic ops do for this tracking?
- can you provide the full view somewhere, how would this tracking be used? I fear
   there might still be races.
- please add more details exactly what we save on the fast-path, I know but it'd be nice
   to have it in the commit message as well, all commits just say "reduce checks, save cycles"
   but there are no details what we save

I will try to give more detailed comments in v2.

Thank you,
  Nik


