Return-Path: <netdev+bounces-190155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EC0AB5561
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 14:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F493A3897
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 12:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3C5283FFE;
	Tue, 13 May 2025 12:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zarp+dSM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF3128D8DA;
	Tue, 13 May 2025 12:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747141026; cv=none; b=Fmzd3e8nqwLHnDjepLkOvHiNGZFlkQY+Rm/zEAzbkm1Aol5LzfNTcYY3Wp0dC+WvpsHYXpl0aO7As5wYpm3kNIVrQWBn4fvF+6DxFvY19LQY6RNi3RPeYyvJZIL2+yzl7DuOwb33qTJkPCyhTzQPWQ0jRcqSFQf+2tlKDHQ4nHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747141026; c=relaxed/simple;
	bh=Z/Q3OWGG4uUror9F6q9eZkrcruvRoD7ROPnVAldNGNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VI1+fwBAjhaQ41aGjx4nay6sHEG4piAAK3idynBVkmBJpF/klpYsIeu/78kXrGlWUJCyTBBw5zW6EFRSXzMkkW9IisQVL1EAP5WZJjvDmg/76CWuIoT2S9+ULRvP1ocLf0EsowYadBC14RbWaA1bcEYYNkY6OLDI/CwrfWuUeJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zarp+dSM; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so58043325e9.2;
        Tue, 13 May 2025 05:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747141022; x=1747745822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=03yBcZd1C5Kf3vXNHOpqaX6GbesxUIZrlQDHf/MdZ7A=;
        b=Zarp+dSMpYDswqd58AO9degVEQQvUkfWt0t8ymcAEcnlVviqvDps8vHUaCteJDeByv
         95ygLKB1QrmmWM6v25ZvizrKmFE4RCab7YVDQ/IDLgFJkvriWGc3ORDKh2BMtlwiGr2s
         9F0aZjR0UiPk5lYc083q/HWdRqXqI7AV2gjmS87fws+mCj0SZS5uNkU/A7jlSoukWYJ7
         Gpbbp/IRxJ1vkhxUkp3hXEb+XITKtGbTQNRzSXg9tpGJbhrPIfqRBuKvcXDUn2viyWaE
         tflkTkXWre5iJ1YLXdv0dM8vbWLLHMXFS6UlpMOZ3KbtUWR5ZerkwIC645VD8KCjhFOb
         FeIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747141022; x=1747745822;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=03yBcZd1C5Kf3vXNHOpqaX6GbesxUIZrlQDHf/MdZ7A=;
        b=V1snGHEB7/FKvu6D5+8lmRU3ejioH15hJtRQ7MKiOqGY5ibK5mnKZZht7ZdiprrcX4
         FM56INQ3CHNBetdlmX3bPlLURpauafkmKsr+NpOpn2r/LaSDt2Q0lQnO2Pajnm+Nf+N4
         dUiNPddS9zrDHSLyNqyRxRMCFOGg/uBVQrr7rJWN3W8jBceMcFlQtgnOwC6HFLghSBDL
         1pCeOgQ01VQLRbY/wBtW8ucu3Wukc6WGpZ8NLsh9Jf90aNDYeTiqAtYSKlHhq8eZVCnF
         pfS51YEW/CbV3LqJfeLHP4gJ/f4j8mGfb/zdWk7pqfMEQkwEqgCjfV5uOdWIJd1C7Gr5
         zgNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG/KR/RDhvI/MLbf9tWWINnUDWFRVSgZpIPgRS0MwH7FUdseU86Ald344IcUbs1k+g0pcOpr8RNK6q5WQ=@vger.kernel.org, AJvYcCUZBAb5pp2/pqm9nPeocd+CQAW4ThVGtotaMzD4GLf/rBobX0gOuFMN8F9rFK8NWIfr28ZtliLU@vger.kernel.org
X-Gm-Message-State: AOJu0YxWDMUMdpjrY/t+YkFBqMzwvK0JDk3sffMRJh3WhgChkoiyB7hE
	PWSYbn/CB8FvAOf5Iy8aTHD/CPMDEM2Tu3p2nJRHv2H/rnza606M
X-Gm-Gg: ASbGncuRj4ts7+NLOxcFqktZ4FrkDwwcyBK0lWJkpfaNMOFo+C0Y0haHRxV44OWO9Lr
	Y6hG6BtBzEYBasB8G1IygFrxuAwM2hvGWxMq1MHe9LmVG7QM1LEM+1XA56hRFeH16UqKwAWUVs/
	WzBIkWgaNe51nUqCCGcT2Nzhs9YleJFgpxPzTLF+lV7teub6O3cRMGDdwzrlWIDC6FGjj+9vEqo
	5u/1WYz2HNrRAZJO6lvM6i6qvg4XjG2d1Nzdao/sjt8ujDEkhoqEKPQbprk0PHL4RzettNMD9Sm
	PRm4VKcgVxRYsoL9y6yC3Qzxmdgl0TdoBWf68Goe/nplbMQ1R1GGPG0T5YihTGh0KGkyYBVj
X-Google-Smtp-Source: AGHT+IHZL9X1s2X9oNq/syLNUtLSYZBACUE3MU9l1yQ7kT7pQZhyTfvikRP2Kz0THW0u7ZtrcCNjbw==
X-Received: by 2002:a05:600c:4454:b0:43d:83a:417d with SMTP id 5b1f17b1804b1-442d6d44a31mr173268525e9.12.1747141022101;
        Tue, 13 May 2025 05:57:02 -0700 (PDT)
Received: from [192.168.8.100] ([148.252.146.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57ddde0sm16465597f8f.14.2025.05.13.05.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 05:57:01 -0700 (PDT)
Message-ID: <d08b9abf-9b42-47ae-9ec7-36b59931ffb5@gmail.com>
Date: Tue, 13 May 2025 13:58:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 01/19] netmem: rename struct net_iov to struct netmem_desc
To: Byungchul Park <byungchul@sk.com>, Mina Almasry <almasrymina@google.com>
Cc: willy@infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, kernel_team@skhynix.com,
 kuba@kernel.org, ilias.apalodimas@linaro.org, harry.yoo@oracle.com,
 hawk@kernel.org, akpm@linux-foundation.org, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 vishal.moola@gmail.com
References: <20250509115126.63190-1-byungchul@sk.com>
 <20250509115126.63190-2-byungchul@sk.com>
 <ea4f2f83-e9e4-4512-b4be-af91b3d6b050@gmail.com>
 <20250512132939.GF45370@system.software.com>
 <CAHS8izPoNw9qbtAZgsNxAAPYqu7czdRYSZAXVZbJo9pP-htfDg@mail.gmail.com>
 <20250513020007.GB577@system.software.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250513020007.GB577@system.software.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/13/25 03:00, Byungchul Park wrote:
> On Mon, May 12, 2025 at 12:14:13PM -0700, Mina Almasry wrote:
>> On Mon, May 12, 2025 at 6:29 AM Byungchul Park <byungchul@sk.com> wrote:
>>>
>>> On Mon, May 12, 2025 at 02:11:13PM +0100, Pavel Begunkov wrote:
>>>> On 5/9/25 12:51, Byungchul Park wrote:
>>>>> To simplify struct page, the page pool members of struct page should be
>>>>> moved to other, allowing these members to be removed from struct page.
>>>>>
>>>>> Reuse struct net_iov for also system memory, that already mirrored the
>>>>> page pool members.
>>>>>
>>>>> Signed-off-by: Byungchul Park <byungchul@sk.com>
>>>>> ---
>>>>>    include/linux/skbuff.h                  |  4 +--
>>>>>    include/net/netmem.h                    | 20 ++++++------
>>>>>    include/net/page_pool/memory_provider.h |  6 ++--
>>>>>    io_uring/zcrx.c                         | 42 ++++++++++++-------------
>>>>
>>>> You're unnecessarily complicating it for yourself. It'll certainly
>>>> conflict with changes in the io_uring tree, and hence it can't
>>>> be taken normally through the net tree.
>>>>
>>>> Why are you renaming it in the first place? If there are good
>>>
>>> It's because the struct should be used for not only io vetor things but
>>> also system memory.  Current network code uses struct page as system
>>> memory descriptor but struct page fields for page pool will be gone.
>>>
>>> So I had to reuse struct net_iov and I thought renaming it made more
>>> sense.  It'd be welcome if you have better idea.
>>>
>>
>> As I said in another thread, struct page should not embed struct
> 
> I don't understand here.  Can you explain more?  Do you mean do not use
> place holder?

I assume this:

struct netmem_desc {
	...
};

struct net_iov {
	netmem_desc desc;
};

struct page {
	union {
		// eventually will go away
		netmem_desc desc;
		...	
	};
};


And to avoid conflicts with io_uring, you can send something like the
following to the net tree, and finish the io_uring conversion later.

struct net_iov {
	struct_group_tagged(netmem_desc, desc,
		...
	);
};

-- 
Pavel Begunkov


