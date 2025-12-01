Return-Path: <netdev+bounces-243008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB76BC98137
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 16:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B10FC4E187A
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 15:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9283321C5;
	Mon,  1 Dec 2025 15:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="de9vEltu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF503321AB
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 15:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764603511; cv=none; b=NnFxDCDA+XEcIX/8nFCysBMhdSXH17Ury0jWzmjb6Joe72+45EcVOOEenW+ZFe+axXH9ybrbtE2yLKjOiDDd6Upbi9KqTjxbT40XYfzR0kHp7A/VDnJFI9EIwaNStKk8tEMPbAPekh2GUiKD7Ymrcd19jw0E8B/RfBXAGOFbUQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764603511; c=relaxed/simple;
	bh=4bJza8pueDZleBXIQhQLXlVQYB/hddHey7ZJ+R9VXGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ut4D++fJcudU4FLtrHjlOgTrBbEWLRKNdZsSEN5zB4dJmqT5k9W+YetRDf1//ezIYRQfHZkH7m8a16CcCEkUumXHfkd/E5USqO688loXwvqoyGskJxOXtPkQNo0gUOF1CYuaE/ECPWp80qYPFB6VwyYCDDKtQRQP79uBs2soNNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=de9vEltu; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4790f0347bfso4991315e9.1
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 07:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1764603507; x=1765208307; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2Y5rI/vnOu9xFnlB5/iHpRXRGNHiOm/CVsZz1c745g=;
        b=de9vEltuU+02KsDSRA+AZPpT5FNfkZ8nDfaREhPX6VQ2zMuDQ+6nOdSyhQJ3+q83jN
         FtfcIv+7a/Z1ZbdA1+Xn6+E1NEyjOEelQi9dY/3nsoEeiMnYrdnMOsZPb8XEeuqP0VDl
         xkBv7d8dNk+aP1RfvMuL0ARz5dyQecQz+sb6T6aFodrfJbMF0B01Yc1YOSxfRtofNSAi
         iKBaBL7JZXZZTTd79d9zeC+qYlZQBhE0vg5vFuObGvbUuNX55eiGZWMFZj3LvexDG9gf
         xgHUPsLhA5gH07vwx4An9jBkCjyiEqypIBsazsykIkYZGDkRQzk6XJrFvBN/UTX+bbWN
         3nYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764603507; x=1765208307;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2Y5rI/vnOu9xFnlB5/iHpRXRGNHiOm/CVsZz1c745g=;
        b=qGaPp5GIp1PwLB2p38wGhcZJGe7HuuXA7pz+kC+vfmuzOV8Cl1aEtEXp7HptyqDn3a
         U3FKn34hYPq7PFCs7JSvwjlXSFD87sabDC5pXszR77Xsfvt2Fp1YiwR+pLhaY0+tNGus
         FjAgLcZrh4GxN1fRYrhuemQeAtRwG1Xpj7yjCXlWN9hAWhZX0+GRFkyJJJUbY7YmsrO7
         VLSp083OqfFFaQNL08WKucPPclkaCUp5wpFV/MoUWbPx6pLalEnrBHP7Oxdq8RlW9Unz
         uq9/fkGWvfk+R7jzeMMPf777GSCEhgjeBwVYzM21LF77vrjobj4+5eSuthkRIMo1G903
         xD/A==
X-Forwarded-Encrypted: i=1; AJvYcCWMrhy7DeyHvYCidKXOMpvYUlTv/5A4B/XeCeABYXL2v3jpFCuQHJkW3Bp5J2ufO6BYuUo7fGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC++b7/rhHfwA/mTp/TmJlkhMDticHsib0Sw4pUbiym+DlmAYu
	lb9E6WemhHVJAhgOr8i/wOITVc0UgJQArGgTRcU/YyT1OgEsNN4dW3ZyJELotbNvEZU=
X-Gm-Gg: ASbGnctJlTL6GkoE1UBD2Zo7GNM37OVSLdbXNsPU+/lX4LOeECiPfanVAkzFTJMTmtG
	/TvtVxSUbro+K6o8OgXcyeRlRuOZzXI4CPhrhB1ccRDa4z7sFC9hqeBmVa0gTa3oqnBeGHTEmuN
	b+lHqo1bgLSU+m2AE6Nqq8xOh+uuisaIdEHfw6siXScAdaSu5ArghJtuS2xW9bDY/sZ2MUQcoeV
	gA39EIFlE4YNIZGfp/R4zDEC5m+oZFlYZjYB1e1gLhbaTtdmNXcb9CQSFM6pqNd+aBcLJ+w7hJ8
	MvixkmDCviYtCjUWtB0iBVwYlYDitwRdkUKqUirY/y/3LxWjchcdKnQEtGbg1V0JI2W6FCUFp5z
	9nj8W1bvgJw8FwM0Spa5zdBU/vVLR6kN9Ny/MCsGU5Mr5DRKxlxtbwk3u3E1lw5ra+S1rHCIrjP
	TGJDLZJ98GzGvGYI7MM+kTlN6rW1bxBOJ0LE9lufq4BeH1JhFmgECbMPhNdeD55IEDeZufT45bx
	Q==
X-Google-Smtp-Source: AGHT+IErJKv1q9m4cJJxeo+qG6to8LRvHNbExN+2Da3lRfFT78WtTFRvxTpTbbpp9JXzwwwbT6spdA==
X-Received: by 2002:a05:600c:46c3:b0:477:aed0:f402 with SMTP id 5b1f17b1804b1-477c020242cmr207800645e9.8.1764603507531;
        Mon, 01 Dec 2025 07:38:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790addeeaasm307027235e9.7.2025.12.01.07.38.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Dec 2025 07:38:26 -0800 (PST)
Message-ID: <dcbaec83-095e-40a7-a51c-8688cbcd0592@6wind.com>
Date: Mon, 1 Dec 2025 16:38:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v2] net/ipv6: allow device-only routes via the multipath
 API
To: azey <me@azey.net>
Cc: Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
References: <3k3facg5fiajqlpntjqf76cfc6vlijytmhblau2f2rdstiez2o@um2qmvus4a6b>
 <20251124190044.22959874@kernel.org>
 <19ac14b0748.af1e2f2513010.3648864297965639099@azey.net>
 <85a27a0d-de08-413d-af07-0eb3a3732602@6wind.com>
 <19ac5a2ee05.c5da832c80393.3479213523717146821@azey.net>
 <1d44e105-77bd-42e7-81f5-6e235fd12554@6wind.com>
 <19aca794ddd.105d1f97f173752.5540866508598154532@azey.net>
 <da447d68-8461-4ca5-87ae-dcfdec1308db@6wind.com>
 <19acb23fcf6.126ff53f1199305.3435243475109739554@azey.net>
 <19acb2c1318.fb2ad2c5200221.6191734529593487240@azey.net>
 <56a0ec5c-da92-4f92-9697-71127866049b@6wind.com>
 <19acb95fbde.c1def42b209419.2689462649051838277@azey.net>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <19acb95fbde.c1def42b209419.2689462649051838277@azey.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 28/11/2025 à 18:49, azey a écrit :
> On 2025-11-28 17:28:41 +0100  Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:
>> Le 28/11/2025 à 16:54, azey a écrit :
>>>> On 2025-11-28 09:38:07 +0100  Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:
>>>>> With IPv6, unlike IPv4, the ECMP next hops can be added one by one. Your commit
>>>>> doesn't allow this:
>>>
>>> Hold on, I think I understand what you actually meant by this, sorry.
>>> I got too focused on regressions from the discussion in v1, I'll make
>>> a v3 of the patch that allows dev-only routes to be added via append.
>> Yes, that is what I pointed out.
>>
>> Please, add some self-tests to show that there is no regression. You probably
>> have to test different combinations of NLM_F_* flags. See:
>>
>> https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/tree/ip/iproute.c#n2418
> 
> Will do, thanks for the pointer.
> One last thing I'd like to clarify though: would this behavior not also
> itself be considered a regression?
> 
> Currently the add and append routes get added separately, and someone
> could theoretically be relying on the kernel always picking the last
> route instead of making them multipath - essentially still the same
> v1 regression.
That's a good question. I let others speak.
But using the nexthop API would definitely close this question. I wonder why
using this API is not possible for you.

> 
> If not, would it also be acceptable for just any non-RTPROT_KERNEL
> routes to automatically be made multipath like this? It's a simple fix,
> it'd make appending work and it'd still prevent the specific v1
> regression for the case of two interfaces on the same subnet - example
> diff attached.

I don't think that the protocol field is reliable. The user can set it to
whatever he wants.

