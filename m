Return-Path: <netdev+bounces-173905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E74A5C315
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 14:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAAD9165110
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 13:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89661D63DF;
	Tue, 11 Mar 2025 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ln4oPHjC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE941D5ADC
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 13:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741701340; cv=none; b=aYXofDEZ/3U+o2gvdSiBZTd0cfcjvSfr35wOdg6u2qBewt9mFmncvBDIkUu4EWzeq4XCG8gL79NtXBD30Ir0uMoJdAcMTkk4Iz2Pje6n/DM0BTNv9xaLR33KRDtWn22Uy0siecZTTiszvSmjBouVjyeihOAtNfKJ8CyI8jtyOps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741701340; c=relaxed/simple;
	bh=nCQfUjiBJVhAknsHBMl6lUZfQOxAeJgDsP3/7wxVBjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZdYRJSs3qawr6tvVQoRksjzcpXQ11OIliPJdi2YHw24hkbvJnbbnNcAuv0aSN2NzwAc61ech+mAtekQxWuUN8Eod/svOZj5ic94yEGxl3Rh4gDTZTkYogoz+4VC7XCIAfyJ3bu1higcGFK0CEB/HtCzJY1FKLqaTLn7hJypdsjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ln4oPHjC; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso16710385e9.0
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 06:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741701337; x=1742306137; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=olPkp2O9KY1y4Vp9DUUrYD6Uzd3YuaLXe2zFAWlewzA=;
        b=ln4oPHjCWF7vQE6bDa82mSbhDevg5cA3pAXhxwrLc5ee67FCfdR3hW4pimz8VCSdvU
         RbK6X0GNdtrjgItgWPXN+PDQ2zZkt5y+w1o1sp1J8qhygzm6myDt9L0gUPL6EhfUFThj
         Inf6g4YrVTXpc5kvv72t8Gw5hcl1cKPZOnGR9NmxAbatdhCqe1HJ2i3FSHPR12k4aPg0
         AqpAfvW+jMIA+vNsxLjsyH0jBv/Pnei3svoE9BfIfdwUFWizocFyosOb32BNx+6xro1t
         l4Afz0CbYZlL5i+xTDSrQ3U+ruYWfbT4cUr3U+flm5tKhTd9duIhgQN+j01IqQETgbgm
         L9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741701337; x=1742306137;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=olPkp2O9KY1y4Vp9DUUrYD6Uzd3YuaLXe2zFAWlewzA=;
        b=UtlNb6R1NVRRu3VC18YRYSJpOPQqtUge3qRC/nIkXxYXhmriT/o9p6eYtsKdn5nRcc
         LJa4vJ6HbyQajjx0NpBFKQ5UA1bO4dsXEtS7VKQ8niL6z6q2elaIUoUvUZwBktSoJS+u
         DVUbbYPIUz0SXwotI5Jn0hnePSkphfcNJWDbGvKb+HRXvrS+hKDKzQLDUxzy8SbBzU+V
         4j97xyTiRLpEtrIY/t7EkrGxun0WCMT5+ihxf/iwud8xqZqG9irEuVGpz9qTm0ViaR/e
         9mFU5HisFNJQl1Ls8z8II9cJtFe00GZG6M8AadZ2h7Xm5qPWosxtGxdp/3x/oZJDdXBN
         M6PQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9yAkMzfCT0wYoHl6yvCLyWuHWSAQr2yIkWXk4W7jw+lHx1Cj+H1EEAOHcz7SixOSHA9FuFJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY4YyFX9cSuESGps9AFkbm6yor9j5Np4kTdVcMlTSkQpPCphkh
	TGmhcHk8xhe5mpYV0ej87ywtJqWbJ57Vj8fBve0BlZVXeSYUlg1X
X-Gm-Gg: ASbGncszpGK1FA3oGBy2oE9VeUI3oQKtEOIlLbY2MzuLCwQJ6JeiLZ+lFvziIos6YXw
	XRCcWM/4fkGF0FVWvaSnpTszVrkH1p+oqYzUFoX28iaKmVgcWVEkZOsIFgHeumbq7t672nO/wn9
	c0g7508H1MVevgd/cYK3w9pLbCzUen/GLPoO1QNnxF1quKPACzHA56t0FECpN99Ft+swx3F4Yp2
	A2Ej5tM95gq8/+rTw7GnJe+OlZrKKI1+aPe1siPf6LLA1hHoalHo99XUwCXho3RHBsT7lHetTCz
	U/0B8vIdy5XAZKeeibMOHrSIo1TW58THBQBZzVDG1wcLUNSxE0MYwlnnFA==
X-Google-Smtp-Source: AGHT+IHP1YnKqFS0TUcb/23KdoKw+CIlDChMrdDZdpZH2VwP4MRmi/ox/dtAkSb7zrWgJJp7CpE4JQ==
X-Received: by 2002:a05:600c:3596:b0:43c:f8fc:f697 with SMTP id 5b1f17b1804b1-43cf8fcf8e0mr62627395e9.9.1741701337003;
        Tue, 11 Mar 2025 06:55:37 -0700 (PDT)
Received: from [192.168.116.141] ([148.252.129.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cf3bf0e48sm82732395e9.20.2025.03.11.06.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 06:55:36 -0700 (PDT)
Message-ID: <2cb9c1fd-db44-4f66-9c5b-03155c6187d6@gmail.com>
Date: Tue, 11 Mar 2025 13:56:29 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] page_pool: Track DMA-mapped pages and unmap
 them when destroying the pool
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Mina Almasry <almasrymina@google.com>, David Wei <dw@davidwei.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "David S. Miller" <davem@davemloft.net>,
 Yunsheng Lin <linyunsheng@huawei.com>, Yonglong Liu
 <liuyonglong@huawei.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-mm@kvack.org, netdev@vger.kernel.org
References: <20250308145500.14046-1-toke@redhat.com>
 <CAHS8izPLDaF8tdDrXgUp4zLCQ4M+3rz-ncpi8ACxtcAbCNSGrg@mail.gmail.com>
 <87cyeqml3d.fsf@toke.dk> <edc407d1-bd76-4c6b-a2b1-0f1313ca3be7@gmail.com>
 <87tt7ziswg.fsf@toke.dk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <87tt7ziswg.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/11/25 13:44, Toke Høiland-Jørgensen wrote:
> Pavel Begunkov <asml.silence@gmail.com> writes:
> 
>> On 3/9/25 12:42, Toke Høiland-Jørgensen wrote:
>>> Mina Almasry <almasrymina@google.com> writes:
...
>>> No, pp_magic was also my backup plan (see the other thread). Tried
>>> actually doing that now, and while there's a bit of complication due to
>>> the varying definitions of POISON_POINTER_DELTA across architectures,
>>> but it seems that this can be defined at compile time. I'll send a v2
>>> RFC with this change.
>>
>> FWIW, personally I like this one much more than an extra indirection
>> to pp.
>>
>> If we're out of space in the page, why can't we use struct page *
>> as indices into the xarray? Ala
>>
>> struct page *p = ...;
>> xa_store(xarray, index=(unsigned long)p, p);
>>
>> Indices wouldn't be nicely packed, but it's still a map. Is there
>> a problem with that I didn't consider?
> 
> Huh. As I just replied to Yunsheng, I was under the impression that this
> was not supported. But since you're now the second person to suggest
> this, I looked again, and it looks like I was wrong. There does indeed
> seem to be other places in the kernel that does this.

And I just noticed there is an entire discussion my email
client didn't pull :)

At least that's likely the easiest solution. Depends on how
complicated it is to fit the index in, but there is an option
to just go with it and continue the discussion on how to
improve it on top.

> As you say the indices won't be as densely packed, though. So I'm
> wondering if using the bits in pp_magic would be better in any case to
> get the better packing? I guess we can try benchmarking both approaches
> and see if there's a measurable difference.

-- 
Pavel Begunkov


