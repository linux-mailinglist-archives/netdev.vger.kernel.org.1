Return-Path: <netdev+bounces-85244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D9E899E4B
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 15:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7DE4B21F3F
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 13:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5263516D4CE;
	Fri,  5 Apr 2024 13:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="NOGAmHFh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562AC1E52C
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 13:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712323805; cv=none; b=fg/famh3MXyZzNUtPDHRKYFSc/OLYQcUqgLG9iYDHUR0vhLsoqJdSzmOjj78aD146DQJ8QFi4dB+OZoF/z6SoPFiSVapq8Ithf9lbD0wy0/jCPjG7Ww03MGc+h56ryZdjfIah3nsVVrowuR5oTizexnMYODouyRCQZUQkJFfIMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712323805; c=relaxed/simple;
	bh=NSRVh2fWVwKb/raxIr/+4xuw/wAlsoAk/probWvhgQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GG7Pl6UDWoYSyWIAbw47RrgRz/VQv/Ug7dZX2Uq7rwumzfOrgfqbVq4x+y83U3n2GvwpwYGZq8ujkuKk+ATPN1AyprTxmCFjPwTVyLcgvAhcpYL2yhiPfH7BzJyrTdff1IGLRsshwsdF3voLPq/02JrDRw1a5Tdt0yH4oE5aifg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=NOGAmHFh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41632f56597so1435595e9.3
        for <netdev@vger.kernel.org>; Fri, 05 Apr 2024 06:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1712323801; x=1712928601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XBZ3+rnouDmjpWLY2BkF2Y/lXybGb138tyzpAw4jcxc=;
        b=NOGAmHFhsd5BrwCUJrbMDAyI7N8ADNzUjzYgOOb6wBxMiUdFqnur6KHQbeDcm2yjOJ
         vW/y4ZRITFNaAnRvthLCUGXZaUUJtZyoAdonGu9Hvr3p3VuSOJBqR64cUbA6J3KJATbK
         Peau+N4A6c2L0umOe5QXWI35IA+e9fTnqWLRy4QN83NTVUmJu12ffJNlohjfOi2pul9Q
         JZFfL0OTHxI1tScdDljpvuO9wq1cn4mG3wGJjqcaw/GoZg518u78aoIGPOP85NxYPai8
         RVm/QdXhj8vdjCdsadfihJd1qTsDPwxC2YduOQO1L8sWoehLiJXYWh9YJUE+/0a46Slf
         Y6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712323801; x=1712928601;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XBZ3+rnouDmjpWLY2BkF2Y/lXybGb138tyzpAw4jcxc=;
        b=sVBS87UmLc4RaDbWG6392mXs2P3a7hRhZ8C+0XyNHhBtsvGHg0eJ90qkNw5nTA+ZQH
         RM06l97Q2CEz+uOPqv/tUTEF/g12A+Nm5USsumD6G/FrsjlvZRWSnMXiXM523ywNraxJ
         DdYDTIEWfkbXU/NAoMqPIdmw+TV8zB4TFjTFgdclr9H6LgvRmXB7XDp74/K/T93vQpAk
         l7x8JrNYBnxNruROIzeEZGR0TgAIdb6FbZlrynYX1MOevbi79PwTWEY6tTR9ycgDHYV+
         Yxzcu89WAEeRUtjCbiz+eZfUrzu0fawEt7JUsD7ytzDVvFnx/YblPf7Vn2bQbc/QmEam
         0+1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8zrkltjwMdF/D03QKrsl4DkN9jGypoLT8tkmyXM2QlkcHcg2fz5MY22QOO4Ied9GkFtjjaLY8VQSN+skE+HFjDSbYzj7L
X-Gm-Message-State: AOJu0Yy3MnNTGuESvL3Z8jLP8fXjgD/6sItAi1SzzD8m1d0dUGR7ZPNP
	4H/jJPaduBuuvQc0SHpEvAIus3XtfbGn6dtkaYyXoF5FqG6xnycUzDb8ajheLFVvVUaipx5LSyV
	V
X-Google-Smtp-Source: AGHT+IGrmB/jho0EkYKk9YCG0agQGHh6o5CijfVxPX0LUm4fMi4vV5R9c+YyH4+nnqCQZGRfxYiQ2A==
X-Received: by 2002:a5d:4ad2:0:b0:343:44db:6153 with SMTP id y18-20020a5d4ad2000000b0034344db6153mr1070674wrs.42.1712323801484;
        Fri, 05 Apr 2024 06:30:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:94eb:2672:19d2:1567? ([2a01:e0a:b41:c160:94eb:2672:19d2:1567])
        by smtp.gmail.com with ESMTPSA id e16-20020adff350000000b00343ca138924sm2040967wrp.39.2024.04.05.06.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 06:30:00 -0700 (PDT)
Message-ID: <e90396a3-774f-439c-9c98-8ea5c74e7606@6wind.com>
Date: Fri, 5 Apr 2024 15:29:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH ipsec-next v5] xfrm: Add Direction to the SA in or out
To: Antony Antony <antony@phenome.org>
Cc: antony.antony@secunet.com, Herbert Xu <herbert@gondor.apana.org.au>,
 devel@linux-ipsec.org, netdev@vger.kernel.org,
 Eyal Birger <eyal.birger@gmail.com>, Leon Romanovsky <leon@kernel.org>,
 Steffen Klassert <steffen.klassert@secunet.com>
References: <0baa206a7e9c6257826504e1f57103a84ce17b41.1712219452.git.antony.antony@secunet.com>
 <13307e0d-11c8-4530-8182-37ecb2f8b8a3@6wind.com>
 <Zg_ukNvNpr6ANyvw@Antony2201.local>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <Zg_ukNvNpr6ANyvw@Antony2201.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 05/04/2024 à 14:29, Antony Antony a écrit :
> On Thu, Apr 04, 2024 at 04:08:42PM +0200, Nicolas Dichtel via Devel wrote:
>> Le 04/04/2024 à 10:32, Antony Antony a écrit :
>>> This patch introduces the 'dir' attribute, 'in' or 'out', to the
>>> xfrm_state, SA, enhancing usability by delineating the scope of values
>>> based on direction. An input SA will now exclusively encompass values
>>> pertinent to input, effectively segregating them from output-related
>>> values. This change aims to streamline the configuration process and
>>> improve the overall clarity of SA attributes.
>>>
>>> This feature sets the groundwork for future patches, including
>>> the upcoming IP-TFS patch. Additionally, the 'dir' attribute can
>>> serve purely informational purposes.
>>> It currently validates the XFRM_OFFLOAD_INBOUND flag for hardware
>>> offload capabilities.
>> Frankly, it's a poor API. It will be more confusing than useful.
>> This informational attribute could be wrong, there is no check.
>> Please consider use cases of people that don't do offload.
>>
>> The kernel could accept this attribute only in case of offload. This could be
>> relaxed later if needed. With no check at all, nothing could be done later, once
>> it's in the uapi.
> 
> It is a minor change. I will send a v6 with this check, and express my 
> preference for v5:)
Noted :)

With this check, everything is open for later ;-)


Thanks,
Nicolas

