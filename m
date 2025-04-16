Return-Path: <netdev+bounces-183182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B26B5A8B4E2
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 11:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C103AD255
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 09:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB430227E88;
	Wed, 16 Apr 2025 09:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NnU7F0y3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03130233145
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 09:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744794758; cv=none; b=NnGrsEuRCoQwxpRLkOfkUJYaDyKCuyrVb3nnGB1lp8tbpGrXyMNwsYsYyoqMqBoUM0Xq+QsLWNJ7p221cOkqo5NhJCaCuWkD/8bXMTIfUcgUM9HVv9n2fiwkI20vBGyXGiN9dSfo11FS/mKTZ+wq0j3v1/CEug9a7+Wi074Lj88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744794758; c=relaxed/simple;
	bh=DdBduBVN1aiuEELhS+bgtiJoh93nkdrDvgjDJAwAZrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pR7ww4YdQd03UQzxyXYM9pCZa9QQlEpJy5h5bASy0iZEFnCFY9fc8X3U0ElB5BffUpSa7H69usYnPrGy5WT5WMlmZ+rXLjA0RDV8R/5bUT8G3umoP6To9wnAo+zQxUwLE/d95TS5ZgKyI1jUh51czt7d+GT+mNg/0Dw8yos9p/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NnU7F0y3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744794756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zSKldmtkRUZnC3SbVPypBP6q4zcg4yzqJE1AophBFp8=;
	b=NnU7F0y3T2XZGCLe6JX1wg2vL3K6g5sU/Vfo78DqRxr9ltsV9RXso5z+proKSLp0R/L5+1
	T210UpPbT2nTOjWAUs4V7yRravC43BtZ/z6twsqGat1iFj21NWMDyzUtVh9BMMpjZbMLCP
	FiPI23/g57ZMcgLJDoMGVEZeTcLsYfM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-qY37Og77OU-AU5ym9MVg3g-1; Wed, 16 Apr 2025 05:12:34 -0400
X-MC-Unique: qY37Og77OU-AU5ym9MVg3g-1
X-Mimecast-MFC-AGG-ID: qY37Og77OU-AU5ym9MVg3g_1744794753
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43cf3168b87so34524215e9.2
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 02:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744794753; x=1745399553;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zSKldmtkRUZnC3SbVPypBP6q4zcg4yzqJE1AophBFp8=;
        b=Hiyj6iDaM7ySMMpYbO2mTUQX4IOoYJOC1Zez16mm8B9gRqvwORZq2dUpSXi5mZFVaq
         5oeK5Km2IhmS7tgFfJHceWHUguW8HViTlNyrxt719owZfA1UruJwYfaWBeOtaaVuC53S
         vt5hopDVgPlmnLp4AxmlprHPbN1cLAIvKFtKbMaf/eEa9bdvbq045qHi+uJmvXhkeswV
         d2w7a76oZdkRoz08DZ8N2xaNxfQ7r0LDqpijFolfFXn2N2UD5jBOpwovPSCu0Uf730eF
         92X3AfrOVjT+kHbYAp3grU8zGqfzC/o8dVx7hHmCaRJs2XnKRJfKC1C35R0/iYmLetxr
         uSfw==
X-Forwarded-Encrypted: i=1; AJvYcCV6sHsR4wmItUoA1mJ8tvhfx1x30a11Wtxh3zPTNskXZ5OQJd5L7/5VlwEVLHVhVSSMuxvCk9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb5TwyC5ayGTYl5t1sj/G+6EBmfeN8RYQobt72OjKcfyrMdjxL
	IAulRvLYKXats44PuF+ArmuxbdC192DSjlwv9QHUntmbBdmlAqbmAiEKfWboSUOb/q7L2xQHCFj
	8poR6ghVGqW49rZQzCQw+gCplP1NtZLhw1oabqH+oJ6z7wyqjxp1CIQ==
X-Gm-Gg: ASbGnctn3Y2h1q0NHWOTO9FOF0KUDROuq0D6tMyDqwjohHxWTvpGjPcLaRvzsPznnSW
	Rk+ypKpkfo3O7NPQHBViRirwSA+U/OQqk3Vp7Rj3GEeV/JBaHNeWfcXzp24B+HZKyDEtuvKPkZV
	xg3NYGunKLResFp46QF92AKQEx4DRSt6FT9qWkFFrWqiUdHJUNabyTMNW/5IaTNzrFjNxlQQqm9
	uGEnraXuHkXfB0V05CpfJd/WsVTCjLlATsZa8XDh0Fh++yqcGskaPA3onpBa5jyYYBSwO9lW/wU
	PaE76DLqzr0vl2nPLM74YNFBAbrUlWJ9Z9Ixx6A=
X-Received: by 2002:a5d:588f:0:b0:391:ab2:9e80 with SMTP id ffacd0b85a97d-39ee5b1838bmr831410f8f.24.1744794752955;
        Wed, 16 Apr 2025 02:12:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGPr/v4qfsXghUltHirftYSprOHbJ4NBHN3jzravpZa8EY0Neh50sGUIM5kwFOM8/k0aZ5PQ==
X-Received: by 2002:a5d:588f:0:b0:391:ab2:9e80 with SMTP id ffacd0b85a97d-39ee5b1838bmr831392f8f.24.1744794752519;
        Wed, 16 Apr 2025 02:12:32 -0700 (PDT)
Received: from [192.168.88.253] (146-241-34-52.dyn.eolo.it. [146.241.34.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4405b4c8263sm15423975e9.4.2025.04.16.02.12.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 02:12:32 -0700 (PDT)
Message-ID: <9903a135-1f30-4a76-9c14-36159eb413d6@redhat.com>
Date: Wed, 16 Apr 2025 11:12:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 net-next 06/14] ipv6: Split
 ip6_route_info_create().
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
References: <20250414181516.28391-1-kuniyu@amazon.com>
 <20250414181516.28391-7-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250414181516.28391-7-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/25 8:14 PM, Kuniyuki Iwashima wrote:
> We will get rid of RTNL from RTM_NEWROUTE and SIOCADDRT and rely
> on RCU to guarantee dev and nexthop lifetime.
> 
> Then, we want to allocate everything as possible before entering

Then, we want to allocate everything before ...

or

Then, we want to allocate as much as possible before ...

> the RCU section.
> 
> The RCU section will start in the middle of ip6_route_info_create(),
> and this is problematic for ip6_route_multipath_add() that calls
> ip6_route_info_create() multiple times.
> 
> Let's split ip6_route_info_create() into two parts; one for memory
> allocation and another for nexthop setup.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


