Return-Path: <netdev+bounces-159172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A93A149D2
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 07:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04E433A2C04
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 06:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5975A1F78ED;
	Fri, 17 Jan 2025 06:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="QLiKBGoQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D969D1F7577
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 06:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737096666; cv=none; b=Wtr9WlhjSGGbO4UmTxT4MNa72dxK5xFvKCuV9QS5VMM5+7klzszfI6FfX50d/Ao2EG4A9P7j0ood5N67RXWCk51DvY8ntaCNYteJzBwPtbatfDQQms1BPwiQMnfTm3mXuLLEWLR3fSbWR/dTFC7idesh6yfDBMiLCiSqmyhWD28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737096666; c=relaxed/simple;
	bh=2u2YVfoxLd7Cvn3rxair1v5iw/Nh3ozWpr+rXKeCIOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IfNt49jdPC3DkkhSLQL459/vm+xoP3xIv7rKVsM4ya69NYJlUgg8As4lESoY5GCuZH7lYxYNnXlI5GiSmq1HbkJY4FTsJQgI5jb1iMK3HjwuvsB7MZEn1+UKFsW/aMGw64TJsFLKp8AAHXP47teOZuRam/8SLMcSxFGKcca6nu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=QLiKBGoQ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21a7ed0155cso26840905ad.3
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 22:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1737096663; x=1737701463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bxvFAOToWR486xbEC+Pgvw2Hl5TN/daUG+P6fxzoIwU=;
        b=QLiKBGoQt0T6tjkOmTb+aOtVzDU7f3+enxY5ZgBTnWVm3ThPt5O1mkaIPzjb7wstT3
         x8U9pZCHf+RepsooVDM0hQAhRQhoEdrOGDJNPj2zUkalprfz/eu5cMOjwttJ3jQycoLv
         BbXeo4dAx7MwEtQOIq131MmUIN+URbtM9dYBmgj5A0hQEEfo7qh0/7BYqcZY06Y7rKYB
         7yI4TmAYvsVogpELX/K4EGIRAB3Y7wQuZydBkxP5zlHdry0ys3J0dHQzK8RpAl4nJDAA
         M1jdSK2DnvVNhTC9ba6mTwDo0Dn4fdNkpjZMjyGwDqsDDdsYyN5y5UFp/WTn86WYOhAk
         oNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737096663; x=1737701463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bxvFAOToWR486xbEC+Pgvw2Hl5TN/daUG+P6fxzoIwU=;
        b=lQH4Oq4TpyRlituDa5nY28jzgGTA9hzk3+UUPZgcDbaAeoaNcerxb2m+Svy2azXiMM
         8G/YJqBMhtbi0CzZ9yc4S6JNS4SBnou+WpghkHCKzqIWSi64IfHZULO/UzutfJrOSqwC
         ab16zw8jQP7TVUkCAdFBC9d3u270B/E6m3+nann/TiLsJ785tvEy0X6RxsgKyysKAeJ3
         3o3/kfETHoZifM51YO2JbLFkmiefvfdrD61dlevUIWJhJdzHAApaH/8eASjmVSvocF4x
         TK8tMg4Z7Pfj7PIaTDTdEVr7rLYRt0hc77UJH0VxOMehKTCz14fJwNzFtpBp8mVTpl3C
         MjpA==
X-Forwarded-Encrypted: i=1; AJvYcCWYk/n4f3z9T5X6ZGJOBrhUMw5qQ07R8Ec7HYc2oH7xYbT+fxkXej40pN4kAwPmskeyZnJZQfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbMx97kbwAD4JvROIToijaQ4czeDg3BC0xtqJoqtaaPPcN8Xti
	QvpdKBLek3/yh63FSWteWml3pDg7QCDLXxvwh3VCu6gQBAt4337AErhaDQ9kUAo=
X-Gm-Gg: ASbGncvKEzbAkNmtKfohcmhuVFHgrVpKEZUDG13PpnewrpwJoeU6lqGfnM+O45jhAv5
	tf13NduzMArtmOyHDb7piuV13ooGcprUtxLnJFZC5VGPikQdTIQCwGl7ltTAceWxQTLNTNeJPI5
	8c6oV3940Onvmi1JqDUr+1JWr6kjySdFMgCjkCu8BZsjcYYZvX/5xJs0loheNA9yuCZbXk/ae6v
	e6m70a9pJXeisfnX6CbU1AnOJuGRWWgBhN7uRxQGIAdOn8XcfnQr3/c8SUOnsHkDbA=
X-Google-Smtp-Source: AGHT+IHEp4jaCJNggzbZ2ij/bh9rzGAo+Mt5lP+zOwoLCq8mYHxh8b68OP5RujQgDJEqW/JvnG0eSA==
X-Received: by 2002:a05:6a00:2296:b0:72a:8b90:92e9 with SMTP id d2e1a72fcca58-72daf931244mr2463308b3a.5.1737096662981;
        Thu, 16 Jan 2025 22:51:02 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dab7f07b9sm1110387b3a.3.2025.01.16.22.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 22:51:02 -0800 (PST)
Message-ID: <1a419eb7-0ca4-43ea-9420-da0c35e5f1a9@daynix.com>
Date: Fri, 17 Jan 2025 15:50:56 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 0/9] tun: Unify vnet implementation
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 devel@daynix.com
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
 <20250116031331-mutt-send-email-mst@kernel.org>
 <678901682ff09_3710bc2944f@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <678901682ff09_3710bc2944f@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/01/16 21:54, Willem de Bruijn wrote:
> Michael S. Tsirkin wrote:
>> On Thu, Jan 16, 2025 at 05:08:03PM +0900, Akihiko Odaki wrote:
>>> When I implemented virtio's hash-related features to tun/tap [1],
>>> I found tun/tap does not fill the entire region reserved for the virtio
>>> header, leaving some uninitialized hole in the middle of the buffer
>>> after read()/recvmesg().
>>>
>>> This series fills the uninitialized hole. More concretely, the
>>> num_buffers field will be initialized with 1, and the other fields will
>>> be inialized with 0. Setting the num_buffers field to 1 is mandated by
>>> virtio 1.0 [2].
>>>
>>> The change to virtio header is preceded by another change that refactors
>>> tun and tap to unify their virtio-related code.
>>>
>>> [1]: https://lore.kernel.org/r/20241008-rss-v5-0-f3cf68df005d@daynix.com
>>> [2]: https://lore.kernel.org/r/20241227084256-mutt-send-email-mst@kernel.org/
>>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>
>> Will review. But this does not look like net material to me.
>> Not really a bugfix. More like net-next.
> 
> +1. I said basically the same in v2.
> 
> Perhaps the field initialization is net material, though not
> critical until hashing is merged, so not stable.
> 
> The deduplication does not belong in net.
> 
> IMHO it should all go to net-next.

I will post the future version for net-next. I also intend to post the 
field initialization for net-next too.

