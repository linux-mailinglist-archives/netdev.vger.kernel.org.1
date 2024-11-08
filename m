Return-Path: <netdev+bounces-143355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 593DC9C2240
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 17:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CF65288171
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 16:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BDA192B71;
	Fri,  8 Nov 2024 16:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxXCSOX2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB28187FE4;
	Fri,  8 Nov 2024 16:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731083932; cv=none; b=pcOUkSbKhwyzi7X7Qb6zL1hg4U23E33MnGIYEj1NiDR5vgAYARaSdfoMalcO239xKTfjdPr1O9hhVIZznEdOdQLulkjPdC6oUDC526r6Se3gBXjleMKZ9M5YDqnFJxPjNei0ZF+hNQqdhENu4HCg1V5ULxIy5tZ7HPRULtXLfiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731083932; c=relaxed/simple;
	bh=7y4w4g6pgWRAHU+RtQvNlJKKobnxl/GwhamPedecqyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qHaq6+WZznIPl6deCmndkS3VKHqiIcAJ5RwyZc48UeVXlymZ8cE18+tiqMz8MSslkTCVFqz5pZv6nNSil9E7DvVaq+9hVqEIZAbtVwrdFI0K6SCywjwOEdk80cM+fmT/vR98Dfc5h8o9kwtI33gn4J8PbwDXkv41N7CLNvrhAuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxXCSOX2; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c95a962c2bso3458878a12.2;
        Fri, 08 Nov 2024 08:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731083929; x=1731688729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jlsZwZjrrzoO7w76Bo0+/+iTbPjQm3oJ8vaYxJX0b9M=;
        b=IxXCSOX2ruTUyTu3ZV5Z9wn4+jxeElpvTwYjRIEZT2K4LLoNl6uqkvhx+Ai1NPl5Bw
         2yP5SQfP4Eb8UQnctn7cxH4YJRXWtLPOb6tcxVjf0+mon83e50ZaPAvZUAHWQWojeW1N
         /kNKV0OzpRmHLJA6Y6JfgCOHTuyWRl/9lA1RZcDw1gg/B/ValG4YO32EwBlKykccxwVj
         fw4D0gWmJqZYSELKMmPX5XwoZ17x20mZkS9z+sAE3B5562ISETBeDHN3KOdaDYhXhRTa
         jiw4lIcEJ+UytQ/ly+uvsg+T2KW3rHS5Yg4Nk5p+X27WW3cVA9wIID19hHCUH47oiZRW
         IpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731083929; x=1731688729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jlsZwZjrrzoO7w76Bo0+/+iTbPjQm3oJ8vaYxJX0b9M=;
        b=BKs7cY17oOaPVoJuquTGG5i2hQyNSPY6ZPRl4xXAvahZmNJzJFMHMMo5NSAID1Pzbk
         eeZBJxY59khS7iBT817OvciAl8VzRL7r9qYfcTvm+fv/9fGxZU4T5FK30mikwNO3cdWd
         4HCJy0P9UewFfVA5ywNNBX/IpN2y44fmwhWsL2plbZQ8LHoqQoJIc/ypYlx8SU+Dg3XZ
         e1hR1uEv7y4Y3WJ1m+rixKV2fVerZb9WrzZx1cfMcJ2J8L9ohRT7yfDgJjx8kup6ed1U
         vhPRmbQu5AnWhsjH94950btemYLJ70kgAP8vr8mTvl4Zlayf19UHeZaPg84OTLJtGGMl
         zFDg==
X-Forwarded-Encrypted: i=1; AJvYcCV5Kcsqa5uVVkEz1TabfB0vq24LacfRbyCOPk8n6PjuRjZwb+iGbNaAteG5cuvhtLO3uru42yhb@vger.kernel.org, AJvYcCXoYNpg8TDk0Hpv/KeZDL5/dt1tgZDYCzsEpYRLwpCX4IpGR8RVIyk81pZBz6Zoa4MLpG5xYxDpTuFszaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhnWIrjAXUbetOjkZiXpoyZzJf3c+VU4TLXzGAxIjKIwlkqqIJ
	3nbHbuSrz/OArOB+/A4UPvZBc3pEZVjw/fwqctHs983oDuARORtV
X-Google-Smtp-Source: AGHT+IET5sHmbMXQeci2ReHEWkG02ZQBs2HtSFnqm6Pl/jyBOM5N3GMLbQdvlK6FGBhPgQ34FisNiA==
X-Received: by 2002:a50:d5c7:0:b0:5cf:f82:edfd with SMTP id 4fb4d7f45d1cf-5cf0f82eebdmr2490202a12.3.1731083929280;
        Fri, 08 Nov 2024 08:38:49 -0800 (PST)
Received: from [192.168.42.14] ([85.255.233.6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c4ecaesm2141142a12.70.2024.11.08.08.38.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 08:38:48 -0800 (PST)
Message-ID: <39597ca8-11e4-4c1d-9970-1c73f1f5c62d@gmail.com>
Date: Fri, 8 Nov 2024 16:39:34 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/5] page_pool: disable sync for cpu for
 dmabuf memory provider
To: Stanislav Fomichev <stfomichev@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>, Samiullah Khawaja
 <skhawaja@google.com>, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20241107212309.3097362-1-almasrymina@google.com>
 <20241107212309.3097362-5-almasrymina@google.com>
 <20241108141812.GL35848@ziepe.ca> <Zy41HkR5dDmjVJwl@mini-arch>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <Zy41HkR5dDmjVJwl@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/8/24 15:58, Stanislav Fomichev wrote:
> On 11/08, Jason Gunthorpe wrote:
>> On Thu, Nov 07, 2024 at 09:23:08PM +0000, Mina Almasry wrote:
>>> dmabuf dma-addresses should not be dma_sync'd for CPU/device. Typically
>>> its the driver responsibility to dma_sync for CPU, but the driver should
>>> not dma_sync for CPU if the netmem is actually coming from a dmabuf
>>> memory provider.
>>
>> This is not completely true, it is not *all* dmabuf, just the parts of
>> the dmabuf that are actually MMIO.
>>
>> If you do this you may want to block accepting dmabufs that have CPU
>> pages inside them.
> 
> We still want udmabufs to work, so probably need some new helper to test
> whether a particular netmem is backed by the cpu memory?

Agree. I guess it's fair to assume that page pool is backed either
by one or another, so could be a page pool flag that devmem.c can set
on init.

-- 
Pavel Begunkov

