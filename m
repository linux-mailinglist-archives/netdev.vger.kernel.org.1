Return-Path: <netdev+bounces-110023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FFC92AB28
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 23:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC34CB20C6A
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 21:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D545A14EC62;
	Mon,  8 Jul 2024 21:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="J21lZiy2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BB914900C
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 21:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720474031; cv=none; b=UhUVvCFp/VwVWebne5P0niYhdwPkuyC1tmXek7OpgsPdNGGCA6hBOtkJuvvz+qu1npe8+5zSaacqW+u6FHGCKJnN6cNKfhmxkcp+Sfmn2hUErkFGofOHIhfeCZ2xWoiDifSM5vV2SWqAGOhRC6PU4mj9zd6rQuH0u/d8P+FWcm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720474031; c=relaxed/simple;
	bh=SniqhF8I1MtrQLUR4CRh6ZHZqPszppuwMNrX5X0ZWno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZLHVTMC84eyFXM9iU5VAlt0FcZIkdjJx8fO636c4j15sr5C2tPFEKzUoMtdskumBmqolXyidTfVSwpb6u/SDiqWDsyk7pRiCT2e1S6GM5qbExGNBuB2iwk+nvzL+PfESF0TYXoec/VD32xvQTYfaoQQUivsD0itrLfh6M494fWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=J21lZiy2; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42662d80138so13703455e9.1
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 14:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1720474027; x=1721078827; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mUJXtS4XCBqKg2tFK9QNnd2kEKSKQvW0aQSHxBRf1sM=;
        b=J21lZiy2VDowY4EAqrRkq470fI2MzC3mrV4lAARaGSv7000fBUVz9o785drB+OX/Oy
         hyhz774z7mVTqcsVIEyBZ7435HgV7lQFCwd9sLLUpF5Ky4fCCBUhsxOSJ3nbyyBvBO6q
         gyj9fvw6MpX/o7zgOavEL23KfOqFrbcXpINBZSP8E49ClMUeW+oQ2WcMxwG5FScT083r
         GRD5CkndZLvRCbplJl4/jnOlNeNtBal/xPZiFQMc79/rZ7o6OBY9DJgLQUYCSqz14NBj
         7hDoisaiUvQ0q7g4se0T6FF1RlveqD7TMcXYivzRgrf6A9uJ3WNUTGjKTY6QPijIXHp6
         7OsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720474027; x=1721078827;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mUJXtS4XCBqKg2tFK9QNnd2kEKSKQvW0aQSHxBRf1sM=;
        b=H3lkEgIC9QMiu2siSHlPAQimqyMu52ZgtuwiNEKY3oi7iTraagHmoE8SbVITXx48Dk
         GW3b1wyc4ggyUEf3mNjFRcbwCmm2qL1BszYWB3z8KY3ooddwLvVGzfmxj/lvnbDHgj1a
         wfeLt8f48CXVwqEv/MVJ5PumQnFjMzOiDoWkMLeom+TDuMoHJyF5ypRmTOTNY5WCv0WF
         SBh0u7W6HYuZdTNDl28zY129ebdI0p5RTQxb1mHlL58u9jfq+Vcvv1FOth0teIR72EP7
         n0saMCKRub98ZNrYN/cG6yPkWTRdFkae8eAYp0viEs0rT6jvO0b/Pmj4yAD7SPrxAm2J
         aJog==
X-Forwarded-Encrypted: i=1; AJvYcCUIQO9PVGfW2PCoYNwYj71ZYkvE9T1I4rMcQT+R2GTCZa8pygcMwXJF9EvLtArq9xHBZG4Y+dIsbUZ3cjCBQDWYGdp/MkpV
X-Gm-Message-State: AOJu0YyLaG8mpmV3MKk+ha1qFILeIijcfOgB6HTM/3BsDPqGS9uUlFRM
	gDpdRJfBuXaP+8OVz9Q4g8BHchTlYYx73ftdy2GOpxTnRuz7+jwnMnP9AGqFTG0=
X-Google-Smtp-Source: AGHT+IEVB93tN4Egkr+2RhosAVQ5SVQV76/LL6hwcYWL5efR2MQgyf92hklwQZfPfu9HVVMG9C3GLA==
X-Received: by 2002:a05:600c:63d1:b0:426:5ee3:728b with SMTP id 5b1f17b1804b1-426707d8ac4mr4172345e9.13.1720474027560;
        Mon, 08 Jul 2024 14:27:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:f03c:44cd:8f8d:23c? ([2a01:e0a:b41:c160:f03c:44cd:8f8d:23c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6e0a07sm12282925e9.10.2024.07.08.14.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 14:27:06 -0700 (PDT)
Message-ID: <8d993975-e637-4594-8dd8-b725111705e8@6wind.com>
Date: Mon, 8 Jul 2024 23:27:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net v2 1/4] ipv4: fix source address selection with route
 leak
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 stable@vger.kernel.org
References: <20240705145302.1717632-1-nicolas.dichtel@6wind.com>
 <20240705145302.1717632-2-nicolas.dichtel@6wind.com>
 <339873c4-1c6c-4d9c-873c-75a007d4b162@kernel.org>
 <cc29ed8c-f0b2-4e6d-8347-21bb13d0bbbc@6wind.com>
 <20240708133233.732e2f0c@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20240708133233.732e2f0c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 08/07/2024 à 22:32, Jakub Kicinski a écrit :
> On Mon, 8 Jul 2024 20:13:56 +0200 Nicolas Dichtel wrote:
>>> long line length. separate setting the value:
>>>
>>> 		struct net_device *l3mdev;
>>>
>>> 		l3mdev = dev_get_by_index_rcu(net, fl4->flowi4_l3mdev);  
>> The checkpatch limit is 100-column.
>> If the 80-column limit needs to be enforced in net/, maybe a special case should
>> be added in checkpatch.
> 
> That'd be great. I'm pretty unsuccessful to at getting my patches
> accepted to checkpatch and get_maintainers so I gave up.
Oh, ok :/

> But I never tried with the line length limit.
Why not (:

