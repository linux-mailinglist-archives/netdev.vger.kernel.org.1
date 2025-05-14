Return-Path: <netdev+bounces-190367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B960EAB67E4
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 11:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73FFC1B668A2
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 09:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADB625A2C4;
	Wed, 14 May 2025 09:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="kRACjh5p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD997235040
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 09:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747215974; cv=none; b=WP3N4I6TzD0AehIGcBnEsPjavh9lFJZ+zzfYjUsHgfRybsLeiWKe2OF3ZcnprcF+Yxdtvoa+DgnkwC/8Yum36n6Bkn5BXuQ9zhKCVR3EW6Q0Bq4L8bX82BPkZgtGKZ0G1RB4fGd9RRPcEE0uJRRd+Cfm59i0tKmN5ROdKj6nNyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747215974; c=relaxed/simple;
	bh=5UTCjGPL42qHrp4iFlQWwlCgkjKbqALQYrpNOOc8vsU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PuhdR/mYayFOwDe11JI1xoIJRTOBO+RNaEk1A3M7eXaj/DY9ypCagososJUFZS7d+568JPnm1jNm1FK6O+rroTBYC1v7YRfgpzqhAOGZqIqc9QbQgyMYWoLTHMnAPcdiE86D5Tpa/Yn+UNN7zDfurR4JhwUfnqtLfKuwTe/Q0kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=kRACjh5p; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a0be321968so4064438f8f.2
        for <netdev@vger.kernel.org>; Wed, 14 May 2025 02:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1747215969; x=1747820769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6+8Lf0R/xWu4x0PfUpZdIuF4KPxFfRQWQjD7q1WLTrQ=;
        b=kRACjh5pSQY+2aoOT/JJwOJ0Cjvm6XamTKhG9XjnS0ni2SZ71uvCDzUTYtS4Hwn0CI
         qoL1ixfnlrXnX4L4JfyaTebe2pA9NTDG9pj+Ne57Lm3G5sUEhjd0HxuNc9LB723qJqI+
         PKEkXaKj5dUa3HKHFviKuiKvkVTSLxDHMQQFwnq305bw36vv7oTg5sJs/NcIFTpDpt32
         UivEcWWdsTGFw9QtYnmqGatz33jLDkYUoMLHGDBuNSiHgD4KFYoney91bOHTOXg94lqF
         Pad6E/RZQKZfp90V+eQJqT251iHcJc/XrYFVyYoQfIS0UkLqaFszaUsNNSI/Wm0FQ2ZH
         nHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747215969; x=1747820769;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+8Lf0R/xWu4x0PfUpZdIuF4KPxFfRQWQjD7q1WLTrQ=;
        b=TD4PLol4y3Rsn+OjOuFHxFcWR3MoTLj546GIgEcurJJyLzMT2ijE52TQA7D3HqfFVf
         z9GhkYECwNMylPN7STjhzmTvmgs5WyhuHHH6Ehyy0z9ZgbTldlLyvkkMLltYesuBUzMY
         vWWQiurPPfQvB65Si2j7QBbYo9oDnsBYDgyFfRvwSLJ5luvI9o57Jg3k3PKC47CPQ7wx
         lbXs/DFfc27zGIOEW4ocG7s5XcQBO8HW3ENZM+URf5lBHNsfplvkThGr0Y8s+yhkAtor
         WvUrzWoWVbfWRW8qUY4axnlSCR+H+Vp01Da8y0JJpUmIv10jFyDTkorNw51Jpfl569xk
         GAxA==
X-Forwarded-Encrypted: i=1; AJvYcCXBowup+lq8IhPKYIF7Ik3UujWIS6973kq8tU3wB598LkvabhouOmKhWMRNSrrP29dwWLGHImQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwumF8IJbkI4nxx07GALanZO0AeIikk/P1NHHx3OIHPZVln0xxz
	mmClPOC84cXNhaoYiDHXci2qh5QBGD/NFILJuXaP25Bm60eFKC14L8A/5IUcALA=
X-Gm-Gg: ASbGncvBKAL1JTcWNUYrk77LZjEa1j7T3XvQOXimZ5J8W6Tp05z0hjIQ5Lx62Ygl2x+
	JDuqjheDqz6jakUkVUFbfxYWy0TRJDzfXaNVppmQEi2rMNzYJyr5yxG9oWPRk3wuKwH2I1CLyY7
	EqhSPiJkOpwnlWDQ0hk5CkZ42c/zj3RzhEWDUlSP1UgoYbTe600/Ebend70wq3RBrwbQ4W2iHbN
	FANzqceJBuoElCqgaeN9PIHWJ1jyVBlLM5JotfCgKwjkN+qUE5HJy6i9QRtuY7UrfYtPqcRne0T
	MjLMg6wSkzTf8xy6cOdfgJhMyrVnJ2b6joFyEpyZ7+nqc74E86E0Tux9d+AmQWQPn11symfGUyv
	kE1+GfZxb+aO8E58JiQ==
X-Google-Smtp-Source: AGHT+IEt7ubaq5TU8sQtS4lbvdJFuJ+AjgLWAhv6jhuVIN6kjWx9qjlsAXxIL8e4gQP9oca2NHpe7g==
X-Received: by 2002:a05:6000:18a5:b0:391:454:5eb8 with SMTP id ffacd0b85a97d-3a34994bf17mr2215499f8f.48.1747215968876;
        Wed, 14 May 2025 02:46:08 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57ddfbesm19426929f8f.10.2025.05.14.02.46.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 02:46:08 -0700 (PDT)
Message-ID: <3df724e0-131b-4a36-9c36-66ae47ea2845@blackwall.org>
Date: Wed, 14 May 2025 12:46:07 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/4] net: bonding: add broadcast_neighbor
 option for 802.3ad
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Tonghao Zhang <tonghao@bamaicloud.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Zengbing Tu <tuzengbing@didiglobal.com>
References: <20250514092534.27472-1-tonghao@bamaicloud.com>
 <8D7575EB8AD0B297+20250514092534.27472-2-tonghao@bamaicloud.com>
 <7522bff2-eba5-40fd-8136-31392dac3e96@blackwall.org>
Content-Language: en-US
In-Reply-To: <7522bff2-eba5-40fd-8136-31392dac3e96@blackwall.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/25 12:36, Nikolay Aleksandrov wrote:
> On 5/14/25 12:25, Tonghao Zhang wrote:
>> Stacking technology is a type of technology used to expand ports on
>> Ethernet switches. It is widely used as a common access method in
>> large-scale Internet data center architectures. Years of practice
>> have proved that stacking technology has advantages and disadvantages
>> in high-reliability network architecture scenarios. For instance,
>> in stacking networking arch, conventional switch system upgrades
>> require multiple stacked devices to restart at the same time.
>> Therefore, it is inevitable that the business will be interrupted
>> for a while. It is for this reason that "no-stacking" in data centers
>> has become a trend. Additionally, when the stacking link connecting
>> the switches fails or is abnormal, the stack will split. Although it is
>> not common, it still happens in actual operation. The problem is that
>> after the split, it is equivalent to two switches with the same configuration
>> appearing in the network, causing network configuration conflicts and
>> ultimately interrupting the services carried by the stacking system.
>>
>> To improve network stability, "non-stacking" solutions have been increasingly
>> adopted, particularly by public cloud providers and tech companies
>> like Alibaba, Tencent, and Didi. "non-stacking" is a method of mimicing switch
>> stacking that convinces a LACP peer, bonding in this case, connected to a set of
>> "non-stacked" switches that all of its ports are connected to a single
>> switch (i.e., LACP aggregator), as if those switches were stacked. This
>> enables the LACP peer's ports to aggregate together, and requires (a)
>> special switch configuration, described in the linked article, and (b)
>> modifications to the bonding 802.3ad (LACP) mode to send all ARP / ND
>> packets across all ports of the active aggregator.
>>
>>   -----------     -----------
>>  |  switch1  |   |  switch2  |
>>   -----------     -----------
>>          ^           ^
>>          |           |
>>        -----------------
>>       |   bond4 lacp    |
>>        -----------------
>>          |           |
>>          | NIC1      | NIC2
>>        -----------------
>>       |     server      |
>>        -----------------
>>
>> - https://www.ruijie.com/fr-fr/support/tech-gallery/de-stack-data-center-network-architecture/
>>
>> Cc: Jay Vosburgh <jv@jvosburgh.net>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Cc: Simon Horman <horms@kernel.org>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
>> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
>> Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
>> ---
>>  Documentation/networking/bonding.rst |  6 ++++
>>  drivers/net/bonding/bond_main.c      | 42 ++++++++++++++++++++++++++++
>>  drivers/net/bonding/bond_options.c   | 35 +++++++++++++++++++++++
>>  include/net/bond_options.h           |  1 +
>>  include/net/bonding.h                |  3 ++
>>  5 files changed, 87 insertions(+)
>>
> 
> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
> 

Just in case anyone misses it - Jay has a few comments sent to v3 of this set:
https://lore.kernel.org/netdev/1338977.1747215491@vermin/T/#m695fa7cc6b4bf637391427bea8ad268ca7034709

It seems there will have to be another version, if you change the code please
don't add my reviewed-by tags to the changed patches because I'll have to
review them again.

Cheers,
 Nik


