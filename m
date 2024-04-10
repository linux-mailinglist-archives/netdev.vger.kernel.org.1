Return-Path: <netdev+bounces-86426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D99489EC33
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 09:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307791C2112B
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 07:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE7913D269;
	Wed, 10 Apr 2024 07:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="QG4qJNtQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC29C13C9D7
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 07:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734513; cv=none; b=UQ5Q+dtNpOXQx92ywC5Tj4ul7NHudolQlNKjEwwgff+YtYDi28svXFjJFBaTJF2JuUlYGa6fNbkfCO5dCc74TXXoLmN9rBj3NOZZGDCt8r0Ek4YIQ289mpInneS4AUGpMnlGn9eI5l9HMwy8pDH0FgVyFJU7kRCi5cr6Zh7xiyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734513; c=relaxed/simple;
	bh=Iw6asYLTwHW+ukRQlTXowics+RU1YDaahRwTy7x0FLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ipa6Lnep8ounAkdKpZxnbsU2r+Fv6FKAtXVcFwsiGZEKkujni7NxyGS+KVyqROXjJLGi5irTPGE+Ge2mJ1GbLVd/IDn/2aX2sWC+hDevVQwEOGAQye9kDc0rnE7Lgkwk7DrNh5j70ctGT0WheGIRWxBBIYjnmpYmcExINQsPB98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=QG4qJNtQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4173f9e5df7so1212675e9.1
        for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 00:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1712734510; x=1713339310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S5RYfbuAx7u5Y2bsp9/M0Y8H7rPqD6wG8VzkszI8nOo=;
        b=QG4qJNtQyfKugQhdJtQrZe6FkeaUJVauD+/IpAgilLN9SDh8oR5nSDDap7K62XYYNW
         KkiMA7Tbx7jg/g9BQW32ZXKZ+Ze5SKRnjC7ZpZsxfOfw767j6i6F4/oPZporVD/hvdr5
         YTI5UK8l+52hVg49iKDOppKJe6E+wIlBsodBISIHFjCt7vlHZ46+8FXC4cjtMWqs8z2z
         vxALtfDDyB7136AxgwUfHRVlmgMALdu6vumsxfz8oMlS6Q9Uz8xNDBAmuy7cLYqli4Ju
         7by6vx7MwbBvISNzCaYAXSeSEDbfNVA7wd1yvN1FxMQ2Gz4VAztImA4C0+nhp1P/2hyw
         Kf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712734510; x=1713339310;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S5RYfbuAx7u5Y2bsp9/M0Y8H7rPqD6wG8VzkszI8nOo=;
        b=JDSsjkeqljAnuDEBjKqqwi3djyWQ+CrtkZKDqmdSFg77M4/bCla2IWMzrXTkgownoq
         1YDW7H+p0py4vzmcD3bzY0hVpF4V1c9qS2iaCDxw2aCzVgMj3jO69Xhska1vehqeflkZ
         8eI7NsOJ350iRXhBIg9uLspKkrhrIOccOUOb0swflcg4aSLO0MRy3wn2UbC+BsTbptEc
         xDfhn1sRvOUHhpGM5pM6TjNtN2Pj4EdyCUiRWtp7jwkqeILon50C/wuXd9dV53deflqV
         fenhJz1a2vD46xYRHrHMmz+gYmG3VOEddlbqN7nDs7zFZ/3Yy8jEnWlf2W2Lqpkb7CUq
         qtCA==
X-Forwarded-Encrypted: i=1; AJvYcCUFQi2FACTWOWJRjDuEN/lOZ/4rlzQULhwd06FCld6BL/Wid60eABo5ytmldYSAcCOhNOYjfyCkOPI/StJf5/xPXIDTokGI
X-Gm-Message-State: AOJu0Yz0UQxaN+EyB195OFlnOe3kY0sz1qU6sj/PD7ViwfH6D07er4GI
	ng2wCTsGD5UPKHjq9dePhQlcINn6/aB5/TskS5/ilDcHYsUFdDZa0w5b4CcgKIDkKonuoBWwfLb
	Z
X-Google-Smtp-Source: AGHT+IEeRr7BYqqbgoTVKUbt/uL8pXr8QwtmzOmw6N+4KCDW2pVJ96WuJ/6zNko3m83ykDBWA4eAXA==
X-Received: by 2002:a05:600c:35ce:b0:416:a731:3df5 with SMTP id r14-20020a05600c35ce00b00416a7313df5mr1295558wmq.31.1712734510110;
        Wed, 10 Apr 2024 00:35:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:ea6e:5384:4ff9:abac? ([2a01:e0a:b41:c160:ea6e:5384:4ff9:abac])
        by smtp.gmail.com with ESMTPSA id j9-20020a05600c190900b004166b960469sm1414035wmq.38.2024.04.10.00.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 00:35:09 -0700 (PDT)
Message-ID: <f2c52a01-925c-4e3a-8a42-aeb809364cc9@6wind.com>
Date: Wed, 10 Apr 2024 09:35:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH ipsec-next v9] xfrm: Add Direction to the SA in or out
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: antony.antony@secunet.com, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, devel@linux-ipsec.org,
 Leon Romanovsky <leon@kernel.org>, Eyal Birger <eyal.birger@gmail.com>
References: <bb191b37cd631341552ee87eb349f0525b90f14f.1712685187.git.antony.antony@secunet.com>
 <0a51d41e-124e-479e-afd7-50246e3b0520@6wind.com> <ZhY_EE8miFAgZkkC@hog>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <ZhY_EE8miFAgZkkC@hog>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 10/04/2024 à 09:26, Sabrina Dubroca a écrit :
> 2024-04-10, 08:32:20 +0200, Nicolas Dichtel wrote:
>> Le 09/04/2024 à 19:56, Antony Antony a écrit :
>>> This patch introduces the 'dir' attribute, 'in' or 'out', to the
>>> xfrm_state, SA, enhancing usability by delineating the scope of values
>>> based on direction. An input SA will now exclusively encompass values
>>> pertinent to input, effectively segregating them from output-related
>>> values. This change aims to streamline the configuration process and
>>> improve the overall clarity of SA attributes.
>>>
>>> This feature sets the groundwork for future patches, including
>>> the upcoming IP-TFS patch.
>>>
>>> Signed-off-by: Antony Antony <antony.antony@secunet.com>
>>> ---
>>> v8->v9:
>>>  - add validation XFRM_STATE_ICMP not allowed on OUT SA.
>>>
>>> v7->v8:
>>>  - add extra validation check on replay window and seq
>>>  - XFRM_MSG_UPDSA old and new SA should match "dir"
>>>
>>> v6->v7:
>>>  - add replay-window check non-esn 0 and ESN 1.
>>>  - remove :XFRMA_SA_DIR only allowed with HW OFFLOAD
>> Why? I still think that having an 'input' SA used in the output path is wrong
>> and confusing.
>> Please, don't drop this check.
> 
> Limiting XFRMA_SA_DIR to only HW offload makes no sense. It's
> completely redundant with an existing property. We should also try to
> limit the divergence between offload and non-offload configuration. If
Sure.

> something is clearly only for offloaded configs, then fine, but
> otherwise the APIs should be identical.
But right now, the property is enforced for offload and but not for non-offload.
In that sense, the api is not identical. I'm only asking to make this explicit.

> 
> And based on what Antony says, this is intended in large part for
> IPTFS, which is not going to be offloaded any time soon (or probably
> ever), so that restriction would have to be lifted immediately. I'm
> not sure why Antony accepted your request.
I don't see the problem with that. The attribute can be relaxed later for IPTFS
if needed.
But there are use cases without offload and without IPTFS.
Why isn't it possible to restrict the use of an input SA to the input path and
output SA to xmit path?


Regards,
Nicolas

