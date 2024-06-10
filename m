Return-Path: <netdev+bounces-102364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 011B2902B40
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 00:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A131C225D0
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 22:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6016614E2E2;
	Mon, 10 Jun 2024 22:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="moEk0VkQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE02963D0
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 22:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718056928; cv=none; b=FzLxS6zaV9MuQGYBX9cUAzjrd94F2kUHHFpD4pxJ5zeTHhPzMTYUPI4eppGXqznc4256cyWJUOCrn9V/mw62cTXpKevbgaziSkjFIKhgknKcfSe/busgShfmss6stM5WKAsjO1PRwDrmcWjS8NsS2yTkluoj+q6UW2AL9qvL/OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718056928; c=relaxed/simple;
	bh=PafRIwovFnfXHbVTgvLC85/eYBEH0r0oPJMKHOmWSTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=coWR+VKzwNKaN2sAf3aLU5GnijsBVhGOV0miIa2YBoPsrFURHPJzLyUqyQzW4b/hm4S/idRuVS0XuhIleMXsgLZZ+k6vpxgZU/EUtJWOzSnDn2TiKCWkGrNq66IscReCmYQhRhr2bynPvW5FOOm886IpwPjmvUhFsg8HXk+gIlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=moEk0VkQ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70436048c25so1569492b3a.0
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 15:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1718056926; x=1718661726; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EAfg4f/5/dVkUyG3RYD6qxg5KYZdlXS7ai/rm20bU9s=;
        b=moEk0VkQGZ9UTo9C1gQJ8flt0S9CIkZMNECA8MpCnRtJcARyHX2p5QAYxdjuzwJa6S
         NC6zvncCqO0HGXea+7BrmJlWNRU8XGY1B0ZWsWeaCBTtxgDvYAaeowc4anQrKTZZPllu
         xZAx8FT8D758BwLjqh7rWjpato5BWh57huVd/hHIlcFY9eBO5aMSr2UoZw09Te0yWWKI
         seozb1OggT+tk8Ct1QTj5paJw0DfOaDcKtNq3/Qs/qGIj4S/6oAyoGWfEFjhLNEbnxgN
         Adr/7+SlClcjY3UkI+EnphzRztVDuXwgRSB67PwiPUSidbHGeIVN7RZ0+MoPkOm4gL+f
         2Tcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718056926; x=1718661726;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EAfg4f/5/dVkUyG3RYD6qxg5KYZdlXS7ai/rm20bU9s=;
        b=xHTM9Y8bcacQWuBMcOYTNmz3f+S38EDgxzrFFAqWIGLlf4k2vROvsuYKuFUJM1QxE2
         0CI8De3gnrLdGarHBYIzj4CrMOXX69G5ndsjnQO4T1FrKx3mfRW+dlIypda2o0ogvJAl
         LoD4SDjqvJ34kEZIHMA22nVpcrJlFEX4uAT0Gg0vrKRusFdCkm7YBhDj2cr1IZ4bjL8u
         tkcGpRFcSJ44cRpGkmKs3kY8BQybBb75J4+56Z7PU0kOkaalQNwrGHxvll4224V3rmNZ
         CoE8CE2ZmB+R09UiUqzIJ40+aDZf6e69Z1ogFcU9+BiNvnKokyxzsT6uxzMorRrAC+eG
         GO3g==
X-Forwarded-Encrypted: i=1; AJvYcCXqG8svW1vM/b8oMMHFZ05YGDi94MuM4FElB6Ce+W0kd9d1AsEGYQEbt6/dQLHohb+MB0NwJQXb7hz234j9qN/so6CHSBB8
X-Gm-Message-State: AOJu0YwWTNV76LspcYpaEi6x7q/3uMx5alGz6fj6VR0R2EU12c3n62X4
	imJa5Xu1rxT1XCEZQUqtWy5yhHvjuHqsascdRWOPuq6ovwCI2uC57kSgBgqIP2o=
X-Google-Smtp-Source: AGHT+IFmyMNEeWbrDLFRhuCTDKeMSb+Sfe65/953u5iQWxawp+c/Bjgge4wRCw4sJgBssbKqfTkH8Q==
X-Received: by 2002:a05:6a20:2443:b0:1b6:a1c1:b8ca with SMTP id adf61e73a8af0-1b6a1c1ba19mr4669035637.47.1718056926038;
        Mon, 10 Jun 2024 15:02:06 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:1cbd:da2b:a9f2:881? ([2620:10d:c090:500::4:4511])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd50d9ffsm7153947b3a.190.2024.06.10.15.02.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 15:02:05 -0700 (PDT)
Message-ID: <39856d06-c114-47c5-92a6-4bacbdd1fc49@davidwei.uk>
Date: Mon, 10 Jun 2024 15:02:04 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] [PATCH net-next v3 0/2] netdevsim: add NAPI support
Content-Language: en-GB
To: Maciek Machnikowski <maciek@machnikowski.net>
Cc: Jakub Kicinski <kuba@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <urn:uuid:d06a13bb-2b0d-5a01-067f-63ab4220cc82@localhost.localdomain>
 <708b796a-6751-4c64-9ee6-4095be0b62f2@machnikowski.net>
 <a8ac00ed-4ec1-4adf-ad37-2efa1681847d@davidwei.uk>
 <58F03FAF-855C-4938-A97D-55587A0E2E14@machnikowski.net>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <58F03FAF-855C-4938-A97D-55587A0E2E14@machnikowski.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-06-10 15:00, Maciek Machnikowski wrote:
> 
> 
>> On 6 Jun 2024, at 16:31, David Wei <dw@davidwei.uk> wrote:
>>
>> On 2024-06-05 12:38, Maciek Machnikowski wrote:
>>>
>>>
>>> On 24/04/2024 04:36, David Wei wrote:
>>>> Add NAPI support to netdevsim and register its Rx queues with NAPI
>>>> instances. Then add a selftest using the new netdev Python selftest
>>>> infra to exercise the existing Netdev Netlink API, specifically the
>>>> queue-get API.
>>>>
>>>> This expands test coverage and further fleshes out netdevsim as a test
>>>> device. It's still my goal to make it useful for testing things like
>>>> flow steering and ZC Rx.
>>>>
>>>> -----
>>>> Changes since v2:
>>>> * Fix null-ptr-deref on cleanup path if netdevsim is init as VF
>>>> * Handle selftest failure if real netdev fails to change queues
>>>> * Selftest addremove_queue test case:
>>>>  * Skip if queues == 1
>>>>  * Changes either combined or rx queue depending on how the netdev is
>>>>    configured
>>>>
>>>> Changes since v1:
>>>> * Use sk_buff_head instead of a list for per-rq skb queue
>>>> * Drop napi_schedule() if skb queue is not empty in napi poll
>>>> * Remove netif_carrier_on() in open()
>>>> * Remove unused page pool ptr in struct netdevsim
>>>> * Up the netdev in NetDrvEnv automatically
>>>> * Pass Netdev Netlink as a param instead of using globals
>>>> * Remove unused Python imports in selftest
>>>
>>> Hi!
>>>
>>> This change breaks netdevsim on my setup.
>>> Tested on Parallels ARM VM running on Mac with Fedora 40.
>>>
>>> When using netdevsim from the latest 6.10-rc2 (and -rc1) I can't pass
>>> any traffic (not completing any pings) nor complete
>>> tools/testing/selftests/drivers/net/netdevsim/peer.sh test (the test
>>> hangs at socat step trying to send anything through).
>>
>> Hi Maciek, I'm trying to reproduce the issue.
>>
>> Can you please share how you're setting up netdevsim to pass traffic?
> 
> I modified peer.sh to stop after creating and linking two netdevsim adapters
> and then ran the ping from one namespace to another. The same script
> and procedure worked fine when running 6.9.3, but failed with any 6.10-rc
> releases. And the only delta between these two netdevsims is this patch.

Thanks. I'll try and reproduce on my end.

> 
> 

