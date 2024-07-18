Return-Path: <netdev+bounces-112021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B637D9349B4
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 10:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 917861F23538
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 08:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DE76F2FE;
	Thu, 18 Jul 2024 08:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="VNbwKDmN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD06259C
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 08:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721290711; cv=none; b=h6KKyVBn8jsxNGsu5aKK66eD94ZqvfbmyXfG/jWP9gjZzGrMJ8zKFRc562txqvcN+ckn3Ac4aidgMtVgbD3HfMN9FTAMCyA+u+oWsloW4XIyM+FbfwaLjKCh03rTiusQccdo2LP0uKMWG3ldUzrSkOxz4KceLeFEXsz8Wg24eDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721290711; c=relaxed/simple;
	bh=c0EdNXhF/mHADTm/wW2vUlH5osdZUZdjebbxJ4IcuJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YPp7DqZzzF/Z2zgar9KqAF/NJiAwtw8poY4QxsOgvdk83UsWEvJesPwWZxvihDkCjW3yhGlGJ5AqI1hXvjim8U7qPQYVn8GuE4apLVJ6Em25VN7VWYRdgaaa/AV02czQRrHKGJdNZ+5dHhnt8Y3k01hsupDUbmapKHhZ3fNM2Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=VNbwKDmN; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eede876fbfso7861561fa.1
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 01:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1721290708; x=1721895508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5Q08I7A36j9GTa0xUy5+vGoZ3L97gJAXKemYWBCEJwE=;
        b=VNbwKDmNnmHSeUudiq9fUFXMn695M63Ruv3ndFVlr1rMlSkDVTa5Gf9nGGTPh9y/n1
         3GJj3HPIckP7asdxNQO3a0JlZ9fNfFG3ttxNQrI2Gkvkt/JUEVcscUvkLQCAI6gAgkhL
         bbKnggLWFwMWjzlt2RqtMk9+D/Un4vYyoS60NSvkhsO/24kHW0JECS4GUoknKDZ+3UT2
         efdsrdhziQD8FRruNKHitIqJm0B24NVKYiJFaCYv/MwcGYUpuRowC+4rqJAnsV0O5yJx
         bLksRVyVueBQc02v/XL4v30R0oYeIbDQ4A58cBR77vTbazGGkl9BxSJd+IXzUkDhufPQ
         2dSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721290708; x=1721895508;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Q08I7A36j9GTa0xUy5+vGoZ3L97gJAXKemYWBCEJwE=;
        b=mi4/8+qTcBbIHolKvq03Bob8XhTOFBA9mCSlmfMOcSDKumMsOy5/zcsYNcHA1KjBKz
         zOJgUXoCcgoaIGALfCdrCjZlxbFs4m2ZywZwT6onoh+nD4JQVSAT8gr3xcKSfjTr+FVF
         8dKoZQ8+ZeFQUKHfqp0YxcZAbzP84mepYEgzq5IkXxrzjdUofQtUC9jda7Nv6PRXdzXU
         hVoflr3pFc3mMk0tqhpM8MZ/ID5NN+A7qsaSKzgwr5t4T38pAWeMd97Xvv2WfGiwVe3H
         NXXxovEgmxUrOJUT/cxDyBzmDmkQlOjj3IlAIXnUCR+t8TRvLcUviLTnGhbve1Qq5AA3
         jajQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQkIrEDtOZuQ9s2uK3Y/MYGOt6BS6popbTobTgAQGncT6yShm3wrVj5BgDzt1YOJCVaTYOQ/haQJezlS7nDJpbJGEXdYWF
X-Gm-Message-State: AOJu0Yy/IqM8JYS3A0OGBTtUvHNyyQAz5VEkcl5mb5biZDmkAmmjZsio
	lPsCuGVCA81NM5uKslGouXIjrLrRu+6PYER9Ul7V3UZljvZvWRhcw3oUGT2VqvI=
X-Google-Smtp-Source: AGHT+IF/i2QIw7bcKapihjOyD4JdeOC4Fd87wTsIFGY0GUNr17V4WhDQqeRF8vfa7RNCKM/ubd8+rQ==
X-Received: by 2002:a2e:88c1:0:b0:2ec:5172:dbb8 with SMTP id 38308e7fff4ca-2ef05c57aaemr11013081fa.7.1721290707666;
        Thu, 18 Jul 2024 01:18:27 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:14d5:6a6d:7aec:1e83? ([2001:67c:2fbc:1:14d5:6a6d:7aec:1e83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2b1336asm689785e9.3.2024.07.18.01.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 01:18:27 -0700 (PDT)
Message-ID: <a6b2a432-e955-4e2a-a1e1-1ed0a4d14b3e@openvpn.net>
Date: Thu, 18 Jul 2024 10:20:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 17/25] ovpn: implement keepalive mechanism
To: Eyal Birger <eyal.birger@gmail.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
 kuba@kernel.org, ryazanov.s.a@gmail.com, pabeni@redhat.com,
 edumazet@google.com, andrew@lunn.ch
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-18-antonio@openvpn.net> <ZpU15_ZNAV5ysnCC@hog>
 <73a305c5-57c1-40d9-825e-9e8390e093db@openvpn.net>
 <CAHsH6Gu56r75v9JuSKYWWNhPTc0bjN9CoGQ+kN-G5oJwaqYWmQ@mail.gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <CAHsH6Gu56r75v9JuSKYWWNhPTc0bjN9CoGQ+kN-G5oJwaqYWmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Eyal,

thanks a lot for chiming in.

On 17/07/2024 18:19, Eyal Birger wrote:
> Hi,
> 
> On Wed, Jul 17, 2024 at 8:29 AM Antonio Quartulli <antonio@openvpn.net> wrote:
>>
>> On 15/07/2024 16:44, Sabrina Dubroca wrote:
> 
>>> This (and ovpn_peer_keepalive_xmit_reset) is going to be called for
>>> each packet. I wonder how well the timer subsystem deals with one
>>> timer getting updated possibly thousands of time per second.
>>>
>>
>> May it even introduce some performance penalty?
>>
>> Maybe we should get rid of the timer object and introduce a periodic
>> (1s) worker which checks some last_recv timestamp on every known peer?
>> What do you think?
> 
> FWIW In NATT keepalive for IPsec the first RFC was using timers and
> the workqueue
> approach was suggested [1], and later implemented [2].
> The code is currently in net-next.
> 
> Eyal.
> 
> [1] https://linux-ipsec.org/pipermail/devel/2023/000283.html
> [2] https://patchwork.kernel.org/project/netdevbpf/patch/20240528032914.2551267-1-eyal.birger@gmail.com/

Thanks for these pointers.

Basically this is pretty much what I had in mind, but rather than 
running the worker every second, the next run is scheduled based on the 
closest expiration time.

I like it!

Since this worker has no other housekeeping to do, I will go with this 
approach as well.


Thanks!
Regards,


-- 
Antonio Quartulli
OpenVPN Inc.

