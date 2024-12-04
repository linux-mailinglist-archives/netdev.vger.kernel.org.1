Return-Path: <netdev+bounces-149133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 308B29E475B
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 23:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCE3AB2B2FB
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 21:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116B918FDC2;
	Wed,  4 Dec 2024 21:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="QHgbGh8U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C52818C932
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 21:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733347467; cv=none; b=AQkf+heQJ8uitNdlJLFkOmG8wpMUqA9QZfwmsuArN/ewjea31VsoUI8dMYpDtIvSw1jF5+faJMxFFFSzW1TGs+i6NaHeaD7uCTLDbiPp0V0BW3LNZ/fANziNwv8lWEBuiO1NZfHiwWzbPgluOgAw6hjKBvufa7TpRFAKqpGglqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733347467; c=relaxed/simple;
	bh=lANPNiZn9wCjpWgldRHJcgcPHj+OE9gFpeBp2mR2dBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lc8zkM4uO+pN6q6iXmgI9lwJHr9szaYXJ0uKfyPT2wt5HLeDuzqqyqbF/8+s8WvU/itQPiCx7xC3m6RwCkKYlprHstCYrE8DcHm8h/U+ug4mXl+IB7aAtdThAmNz8hBEmnbw4oy75XPE1+ujIhmqJV4D6qPsMw9HH0llPIKBQ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=QHgbGh8U; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-215348d1977so1524325ad.3
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 13:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1733347465; x=1733952265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HVxm73LRxMgGtdBIKKSOYaD34YEdUEHwzi3mWR3Ztqw=;
        b=QHgbGh8UQHqn6GT8KT3qSpyX3fDmg/ey2vLn8UR13TVHzFJ8nFM5sidZQJIld05373
         k/QAS8+TWxMgav6FgGjnnt94QmfML1g9bh9Xnr0jRluQAgrn5Ep03sR+mDEhOVkAuVSU
         KngvxeSC7S5TKtGMef15iO//jaEN+BIGnlvFX2OTF2ysrjG8ohom79koHPEJZlTOi2Er
         AEbbRGV7JvreXflOpWjs9+bvAGNKbzWeIH+2tBsPmTIiHgpFgJUHUiGtnRFI8i5kjEO0
         sPN6C/eS/GGYxxbVRbUIMixBC/cnYCJaPrKg/pls9Lx8n0a72jCerGjYsFHpDmnp3CoK
         P2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733347465; x=1733952265;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HVxm73LRxMgGtdBIKKSOYaD34YEdUEHwzi3mWR3Ztqw=;
        b=jA/1/8W7xe4rKVAEnQb6Hn72m7TpVqHYVQmFoUvALYRGcLwtprc30Wsc6XdbonL1/x
         TicOmTqHVwgwXh9HYHmaQLTaAsUmjzzbq6KSUH3WCtzBnVUh94UmMlH2uiFNj0HZ7o3Q
         JA2G7O6F3QzjNVkecldELavoK3NKyyBr3hKD55SN0h7CajuBXPSQ8kw/utdxsKccQnto
         2GXGLAdXhqvHncqn9agIyVUOagETbQ2Gq6nSjq0Me3UcvHuJMD5bVTm4LdELA5Na1ATV
         Y6SbJJmV+AM9SigpUh2aN+Yo8guG+czMqQj3V3+qt7nNAVr9MdbBRHyN46yIh8ffIq+J
         cHlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXt5/S/ZDGYKudLyZHLaEbLLguRP5UhgETPXtT4fwId/CZM5uzt0MurzWHQofAMWa+FPj9oqNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG4EXfQRj5/YcQqZZVEHeHeJsoczDb0BxL/2fOAP8PEj2JTOiP
	5QMyZNL/i4UvLGMxs6GG2aavnytaEnDGZcerBtYKQfiScftuG1XgmJR+X2c99Mg=
X-Gm-Gg: ASbGncsdGd0Bb66XMlND0ZvjW+zC8O0BALijABPmQkRcVNtUOggOreSQpRxXPH7nv0G
	2Dm246YxHj5/QqGHhSB8Q0qkZCFC4Lc7Yq+sTlDQQnSSz3mJcNJKJ7iC852msrw4u8XKz0Bwnp0
	VUlM9cRzphZgcA/Eimfj1ArlWOzxO26rDtX4ikNhv49X/VK3+n9ohvYAD9PXNZWpFXZzfbihjvG
	Be5RJrHyENoHllGxoe7VDrrZnna39jgdEaCT0dWOr31Sc13bFjTpG+hMqCDqwXqRLSeAtIkEWT1
	vlTyO0wcJ7pE
X-Google-Smtp-Source: AGHT+IHpTGPxyFhHO8MRwvjmGdmAjs1Zq0nyCPmZ/HjAV1D2bqZQUoG6G3AE/jVlEnKO6Sau+K1tmA==
X-Received: by 2002:a17:902:cf0c:b0:215:5aae:50a1 with SMTP id d9443c01a7336-215bd11fc28mr123227335ad.32.1733347464923;
        Wed, 04 Dec 2024 13:24:24 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:44f:b37e:6801:5444? ([2620:10d:c090:500::7:8999])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21530d2073esm109249945ad.73.2024.12.04.13.24.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 13:24:24 -0800 (PST)
Message-ID: <fdc742c6-6b5c-4a7d-b933-b67e22d7c60d@davidwei.uk>
Date: Wed, 4 Dec 2024 13:24:22 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 01/17] net: prefix devmem specific helpers
Content-Language: en-GB
To: Mina Almasry <almasrymina@google.com>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>,
 Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>,
 Pedro Tammela <pctammela@mojatatu.com>
References: <20241204172204.4180482-1-dw@davidwei.uk>
 <20241204172204.4180482-2-dw@davidwei.uk>
 <CAHS8izO=8C9nv2e0HKWA4Ksv-Hq7yoYH6c+rbZcUXvbVwevwwg@mail.gmail.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <CAHS8izO=8C9nv2e0HKWA4Ksv-Hq7yoYH6c+rbZcUXvbVwevwwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-12-04 13:00, Mina Almasry wrote:
> On Wed, Dec 4, 2024 at 9:22 AM David Wei <dw@davidwei.uk> wrote:
>>
>> From: Pavel Begunkov <asml.silence@gmail.com>
>>
>> Add prefixes to all helpers that are specific to devmem TCP, i.e.
>> net_iov_binding[_id].
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> Signed-off-by: David Wei <dw@davidwei.uk>
> 
> It may be good to retain Reviewed-by's from previous iterations.
> 
> Either way, this still looks good to me.
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> 

I'm sorry I forgot to do this. Will make sure it is propagated in the
next version.

