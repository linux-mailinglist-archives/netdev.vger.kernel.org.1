Return-Path: <netdev+bounces-213634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE4AB25F43
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 10:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6E4D1C2082B
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 08:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149952DE709;
	Thu, 14 Aug 2025 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqrWXsyg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C83216E2A
	for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160918; cv=none; b=NNZQpzhjNNNeU34KHtMBnCUQdjRH/RoYoaZf1yq1geHS7HPJEAogf/VGbZDHZnzGPzJQxEOOjFAbvIsXJYD+IpsDcka0bAG0up6Evo8m4Lroee35lRubk0iExaOlZvUnCePJ6efPeVHzPiDos0llU5O/R9SVYvEhtpZyS5png5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160918; c=relaxed/simple;
	bh=5mA8OIhgPbDJJwCHdUQX152M7g3JJMqGIfTpMVer3Q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ip4Jhdw0dbP94LhJb4wzaEyfW5wFqfr1oPHCLTgM77f5d8IlOHtIWhdIPCswdx3qdRddjmzlkPjlwXET6/qn1MOcqeSUKVGu29nZGD/Zn7eutEdCAZsXxfmNvp3I8YT8qXwqGxI3onDahkNP24gOTnz570aBEc6BEjIoTwXVsQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqrWXsyg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a1b066b5eso3001275e9.1
        for <netdev@vger.kernel.org>; Thu, 14 Aug 2025 01:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755160914; x=1755765714; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8s1+5qxA+ElnmY4Tz35V1nQhfwJjwotidOiu2Pq56tw=;
        b=hqrWXsyghZJBK9s0GWIlja+aKSbI3mZwx9JHgj32XTOIn7O97pXxqpzYKfUEIu6Ys+
         KJslqXxYlscbK6QwyOppn5ZrlbrBTkxrDKUEnFgI4vvCDTxwtiR0bqbJH7/tBt/tHp3u
         vPFSTz3rOcyTT7SogeAdS22wl6TYBcsktpLv/f+Zt6HSbg+V6/zcVtkELEWG0LYbVzgh
         QX61xvZV6rpRYICfsxaCy6qO4jYw1YssFjwIbK0RQrUVkcHKwawKMW252qUORqR1YMuc
         QkEKbgZZWi49gaIfSe/Rtdu2Z2PIUOzYOfHotUsk4d6APpj2Y1bVUoCBksqw7AKQyCel
         h4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755160914; x=1755765714;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8s1+5qxA+ElnmY4Tz35V1nQhfwJjwotidOiu2Pq56tw=;
        b=DvhkdbfhgZGgLf39GqDCKYlIcMqOC9jiaQXFX3hFGfDaII3e4qnOmURvEiZCulLmpq
         UBLA6Mr5GKoskklDNsitLp0uktNCB/Ld5502NM6sa81B1vDp36NZbvKrfXexzGSjb6KX
         kqKsrbr1Oz6batv6QI7/hopy+I65IJ7wu05+Yxc5hReEzWiIteMLbMCuiqLhezRRVYYw
         ZFlalr0xv/fE7M9Dp0l+4SA2bbB2hyfhikuWPEMnJM5o2w2EV+G79Mg779qnjhyfZOBb
         tmGBbiCdGBAXBQgSOi5e36CBP1I0Go3y7nKyZjgyPddBJhezGSpP3ecFSrzsZ0H8hcot
         fxqQ==
X-Gm-Message-State: AOJu0Yz44UcdbJUFNBwIx3532/ps80qUuL2jpFhfVcX2tThFqhpVYdx8
	1LHorfRKKzAjPeTBEDQEWOeWNoa7+tOmkfFBFq9+0roEb4xjR+KQ6Usk
X-Gm-Gg: ASbGncsN9lHakqXw4OIUlCFs6H11TpB9hm8HQ33IKzgKZr2ZeRqPwslgOI+Nyco9tSa
	WZH14p9kUeiT1OwAfD9QMr0n05OGW3HXH38HjiNBCdjgKez7yBL6d3LbpnRsoWIY2X3WM5QT8zQ
	om1hm3KB2M4+tNnNNSDzT3DA3KBshlm5RZx/zl7Sw2bbefsS78Z4PXsG+1eD72484Jr5k+8jWXf
	cbjg0OTTRdVpfE8Oo3iXgC+FyDS1FYPYXGP46UVbjEU2iJUR8oPHuqLMeX22yl4k6uKrsyUKD6j
	70tBSInYP4JDKDvhxCWAOj9cP7QRCI5SKebj0PEosvJoafrMKCbozdRXqtomCunZ01EluaeEwNE
	8/5AmPSzqGCgMjkDDUF8suqAaHkTL9I3Ih98=
X-Google-Smtp-Source: AGHT+IGMp6vFll6oTynwlYbc3ykNLY2+QWGjS4qHEBnJ9oJmaPBzYMKa2wI9RDHA9mKa4h2fl1Sb/w==
X-Received: by 2002:a05:600c:3b83:b0:450:6b55:cf91 with SMTP id 5b1f17b1804b1-45a1bceddf1mr11684905e9.6.1755160914164;
        Thu, 14 Aug 2025 01:41:54 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::26f? ([2620:10d:c092:600::1:7acd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1b899338sm8471055e9.7.2025.08.14.01.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 01:41:53 -0700 (PDT)
Message-ID: <2d184613-657e-4aab-8395-336b7764d1d7@gmail.com>
Date: Thu, 14 Aug 2025 09:43:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v1 5/6] net: page_pool: convert refcounting helpers
 to nmdesc
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 davem@davemloft.net, sdf@fomichev.me, dw@davidwei.uk,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Byungchul Park <byungchul@sk.com>
References: <cover.1754929026.git.asml.silence@gmail.com>
 <7be7a705b9bac445e40c35cd227a4d5486d95dc9.1754929026.git.asml.silence@gmail.com>
 <CAHS8izOMhPLOGgxxWdQgx-FgAmbsUj=j7fEAZBRo1=Z4W=zYFg@mail.gmail.com>
 <35ca9ed2-8cce-4dc8-bd15-2cda0b2d2ec5@gmail.com>
 <CAHS8izMfqgzA75Wo9fkeLkHdCa512vqr+5iQ0u1zHKZX9uGoNQ@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izMfqgzA75Wo9fkeLkHdCa512vqr+5iQ0u1zHKZX9uGoNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/13/25 17:55, Mina Almasry wrote:
> On Wed, Aug 13, 2025 at 2:10 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>> ...>>   static inline bool page_pool_unref_and_test(netmem_ref netmem)
>>>> diff --git a/net/core/devmem.c b/net/core/devmem.c
>>>> index 24c591ab38ae..e084dad11506 100644
>>>> --- a/net/core/devmem.c
>>>> +++ b/net/core/devmem.c
>>>> @@ -440,14 +440,9 @@ void mp_dmabuf_devmem_destroy(struct page_pool *pool)
>>>>
>>>>    bool mp_dmabuf_devmem_release_page(struct page_pool *pool, netmem_ref netmem)
>>>>    {
>>>> -       long refcount = atomic_long_read(netmem_get_pp_ref_count_ref(netmem));
>>>> -
>>>>           if (WARN_ON_ONCE(!netmem_is_net_iov(netmem)))
>>>>                   return false;
>>>>
>>>> -       if (WARN_ON_ONCE(refcount != 1))
>>>> -               return false;
>>>> -
>>>
>>> Rest of the patch looks good to me, but this comes across as a
>>> completely unrelated clean up/change or something? Lets keep the
>>> WARN_ON_ONCE?
>> I was killing netmem_get_pp_ref_count_ref(), which is why it's here.
>> It checks an assumption that's guaranteed by page pools and shared
>> with non-mp pools, so not like devmem needs it, and it'd not catch
>> any recycling problems either. Regardless, I can leave the warning.
>>
> 
> Ack. I also agree the WARN_ON_ONCE is not necessary, even the one
> above it for the net_iov check is not necessary.
> 
> But since devmem was the first memory provider I'm paranoid that I got
> something wrong in the general memory provider infra or in the devmem
> implementation specifically; I think some paranoid WARN_ON_ONCEs are
> justified, maybe. I'd rather debug the warning firing rather than a
> very subtle refcounting issue or provider mixup or something at a
> later point. I'm still surprised there aren't many bug reports about
> any memory providers. They probably aren't used much in production
> yet.
> 
> I think after 2025 or 2026 LTS it's probably time to clean up these
> unnecessary WARN_ONs, but until then, let's keep them in if you don't
> mind.

No problem, thanks for the review!

-- 
Pavel Begunkov


