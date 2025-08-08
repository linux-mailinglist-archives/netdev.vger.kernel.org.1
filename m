Return-Path: <netdev+bounces-212298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FBFB1F022
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 23:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A9CB166F48
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 21:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AC7242D75;
	Fri,  8 Aug 2025 21:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/qwuqF2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9F91DE4E0;
	Fri,  8 Aug 2025 21:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754687055; cv=none; b=ec9HCpHMrbtGLe09pBEYGb7KN76PPjLCUKybcRBjZjqVN5Z3DlunKtSjdnC1Dl5+IEeroLREzmbWMkSZVGLKpsF6/u9blD+tQdYe0HG/ztNhOIe5ofwNGDN9idjsFoEwVg6TWtScsSx28UlxV6qMNCFOoQAsuxu0YmWBMZW2Pko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754687055; c=relaxed/simple;
	bh=0R9DVJRVv1zIZSGbH4MTRtSYFNAxYWfrefpd6OVZMEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nWnKiicRqvDto2tXV9b+X4pcO053GHdzM3BnnpgfyXLgF7UGb/7Rmxd4mtzaTwcRsLmnN/bdeiTAdK3ORT6NI7M9kfGzndIjRsNM6Osi4+DolBCT8+sMRCXhZh21Hh33c00lgBAi+MtjIWwmdNxFFUpvYkyoaZu6+xTz3g/ydZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/qwuqF2; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-adfb562266cso361219566b.0;
        Fri, 08 Aug 2025 14:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754687052; x=1755291852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o0kJ5OO6wKbrt+83v3pvG5co9xDM/9SYe+KlEk9T5G0=;
        b=Q/qwuqF2JGDQ/RglEbN+1gy4Yat21jXU7bWpGRMjhaHckWOVVM2TkXxibkI/ONCy4u
         sx0Dlk1NkEafKzNLAf3oojcJTVwIVYhjL8qsJree7/Fx4tUvZEA7i+18TND4nOLwINem
         1m5lWWbJl9jppOEf/kPNT09JkoLU1gK+N5jJzvVEMn6nX3YM/NOnLprst+KgfWcE3gFA
         ddr/4M7XyeS0XZfQVq0inB9rPj6d2h00T9l59c3id8o5BJgO3oMfELCu8AtgmSbGfwCi
         kB/2p1XAhhixzLNh+57JQUQ+GkzM62gpyVc1hVfYZhkB+OBYNbZn0yAajgtm9rV9sPw3
         YP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754687052; x=1755291852;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0kJ5OO6wKbrt+83v3pvG5co9xDM/9SYe+KlEk9T5G0=;
        b=b/2Hgw51S28E/pyOcJY8gUBwpIxuOQs3lQkdUUyy3kLkS8z0gNwOa/aCt5RcXFbcGy
         Nvy7oUMz8bVjbOspF0Dm8PkYWNTLEud0ANTPBWrmgKuv6IzKluApEeFCmsbuD+G8d1jF
         0t29EXV0+uXgdTEUF5MK7MDiCHuJho1akYqw5KUJVGXHGAU1zAhQPs6vopt9MIwkHemw
         qVzJdzn3J2cHhBCnmiAU8+/Cv8ubvW5XdjymyOvA1mMtbAp+NF+7FYI9SpdxAy5fdkBB
         kV8jzjTjLypiHowDw5pcAj7rxYms+llaRApSfxmGITdFGGpJ6FzY5uGancq0SLDZJpZo
         /d2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMUDaPc+LRTjujP8nUZ5wb9VWpIUV+208oWvokmPTscTVmVOgjhnGaGeiA13HVcumrBUoWeuW8F0cZTJQ=@vger.kernel.org, AJvYcCWVoId7pIr0Jh9wmuhL+qCac2jYPi8/5aBVpoOMjORFZkCemXo1xgieU8nfrwp4/puGHpB5DJDb@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ3KFLqJgFZ9tauG9CPXhrkHtlPEgBIp1D1b7ppSzZAPgM12LW
	WLqQfgQS4xLBvlQK8Y9IjO4hocsJFG/3OopflscBn3ybuCeCSeUIHvkI
X-Gm-Gg: ASbGncsq4qjC/rKkKsHc3FgAsj4jXr+cEAt2/mBanNhVmDSlzLj5f3SA5TDlKilIisz
	8z+YvGkqeZFPw+shsnsfpYhwihvKrUj0d927KNGdwX5C0N7Ccr7FXDcY1GUn8EkTu6P869jpOt/
	pVXGAIZ2UO3MJ/4yZsUW2Xf9vTD3T6sPfthG/cGCilvAbzYiTSoUbKc2vb7UwL7XM0jKdGH6t9Q
	dm1X656IABbVpYAcBDHzIc3tvjxflwdcdWcosQJkUsyyTDek4G0xfxyvPT6spt9L+e6cRaDVG9X
	JvhXDW8iKJM+cmjy0ABj+4RElJl+/o9wjPeg97REigG/bCOeV1NftUkU740LehQGMqMOdLy8YPy
	KdbZXW5oXpIk5EVR3Z4DMzXox4aptYoSBZhBwrmpBZvk=
X-Google-Smtp-Source: AGHT+IFdd53FaNfAT88WuN7ZC8Ft9J01HNDj+u6Ek36Jguxg9UxK2LS0fk4D/82//PotxynSRfss1A==
X-Received: by 2002:a17:907:a03:b0:af9:32bc:a365 with SMTP id a640c23a62f3a-af9c6506369mr381516466b.54.1754687047261;
        Fri, 08 Aug 2025 14:04:07 -0700 (PDT)
Received: from [192.168.8.100] ([148.252.141.111])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0763d8sm1573385766b.2.2025.08.08.14.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 14:04:06 -0700 (PDT)
Message-ID: <26725f8c-03e7-46d1-a017-8c36241ead92@gmail.com>
Date: Fri, 8 Aug 2025 22:05:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 17/24] eth: bnxt: adjust the fill level of agg queues
 with larger buffers
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>,
 Paolo Abeni <pabeni@redhat.com>, andrew+netdev@lunn.ch, horms@kernel.org,
 davem@davemloft.net, sdf@fomichev.me, almasrymina@google.com,
 dw@davidwei.uk, michael.chan@broadcom.com, dtatulea@nvidia.com,
 ap420073@gmail.com, linux-kernel@vger.kernel.org
References: <cover.1754657711.git.asml.silence@gmail.com>
 <0a4a4b58fa469dffea76535411c188429138cc81.1754657711.git.asml.silence@gmail.com>
 <aJY767C6oiezskdM@mini-arch>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <aJY767C6oiezskdM@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/25 19:03, Stanislav Fomichev wrote:
> On 08/08, Pavel Begunkov wrote:
...>>   static int bnxt_alloc_rx_page_pool(struct bnxt *bp,
>>   				   struct bnxt_rx_ring_info *rxr,
>>   				   int numa_node)
>>   {
>> -	const unsigned int agg_size_fac = PAGE_SIZE / BNXT_RX_PAGE_SIZE;
>> +	const unsigned int agg_size_fac = rxr->rx_page_size / BNXT_RX_PAGE_SIZE;
>>   	const unsigned int rx_size_fac = PAGE_SIZE / SZ_4K;
>>   	struct page_pool_params pp = { 0 };
>>   	struct page_pool *pool;
>>   
>> -	pp.pool_size = bp->rx_agg_ring_size / agg_size_fac;
> 
> [..]
> 
>> +	WARN_ON_ONCE(agg_size_fac == 0);
> 
> nit: do we need to make this if (WARN_ON_ONCE(...)) agg_size_fac = 1?
> Otherwise you're gonna divide by zero on the next line. Or properly
> return some EINVAL instead?
I can add it to be safe, but fwiw it shouldn't happen either way

> 
>> +
>> +	pp.pool_size = bnxt_rx_agg_ring_fill_level(bp, rxr) / agg_size_fac;

-- 
Pavel Begunkov


