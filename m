Return-Path: <netdev+bounces-190779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FDBAB8AF0
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 17:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99DDC4C315C
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 15:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100A321771C;
	Thu, 15 May 2025 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="qA10momE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AE120B7FE
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747323388; cv=none; b=S172taTWxwe+EXanJ3j/iVoZ/6Zi0hthcJkXyir7lUTFSUCyvsuPHNRdCH1rHn333oTUFe+ZIeInLxy21IByGpTAW8jBQm1D3oAvFSuICLlDixRF2vyLdjXkeLEQ2e/6PHqrM9TTaoxf+aFG9OmUhLIsNo/ZdulTEv+PB+VBfPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747323388; c=relaxed/simple;
	bh=czKg2FsFT1Uwx+ZZLxsBMzwmQcMN+jJQWzv7DBrPeRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R2+nh4h2fO0QPI/3IxbAYvvwtgvvZlcg5b6PQja9gsnw9fk8+WIKuA6dRQUCEq/nZ9UZh/xv5ZsLzAlseiVzuza6hvD9ASJZKLVq07s3vRDmpiNwbS6P+elbitAp3EMLcZmsdcUhmX07KRcx7BnaR1p1SPRx4jEsJseaYL4nl8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=qA10momE; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5fc8c68dc9fso2164780a12.1
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 08:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1747323384; x=1747928184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C9hm5OJVbBIj5FyioW9V7d0NGSFqie3wmW9PRCafSTw=;
        b=qA10momECCJdKjota9vMLWZ5hEGp7sGsNRzzdfyYoS2TF2gTIDzQZBKFTX6TqR3vhB
         iKtuY1aS8v3PPzBzKBy2HVx8IbVvKUF5UCHGsZESQM/1lunfj9fQikHqC96HhKShAqOl
         LNpYnvk1E1cNKLmv0OwJrKwbsgQEToXHjtKSringKTc4O0BXwIdCaIzEOaj2ALLZG0cF
         EINJkwlNvkd9qRlc+nHM3kKBbxBLrsW9p9W3uxxGXAib6nbkvIydOzZVESbHzU4ruxW2
         L5fbB/FKBVSEWTDFR6lGWhc60uDT/7Yb0BH0sqfEqJNv7AsS6meAbxRkyQkCs6gDQ4w3
         YG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747323384; x=1747928184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C9hm5OJVbBIj5FyioW9V7d0NGSFqie3wmW9PRCafSTw=;
        b=NUMZiP9+6HMDofQXzNcNtdDTIR6DglYL8JpBtKv3joOi/CxpEODy/FYaENGoIKxDjp
         dCrdkCgYWR2zkFI8EwHQ4k8oXRnh3P+Z31WeFNbDNrkHcNjE7RR7gjiuvMrnu0cJWb/T
         XoduMVP9g9qY6RZy1ldA8YOfYSwgAOJQEiOcFnMe7OUH9bzUz9XTjeqKmucft20DEULp
         OZOcahT3Prm/mVO8vEq9gR8WEIYf0tROs/skNnUItDyeOWOXPxsiPorFH6D7ZFeliELB
         jSatR1V5POYSWeqizmFmIJ6IWC8LDTvcEgee+vtH5db3YurQ02rYxHWXNodhm7H0S/7/
         mBAg==
X-Forwarded-Encrypted: i=1; AJvYcCWutMy+Z8vndY6YblMMvyPQsRzZiHIKS5dqT5PE8jv9Hl9ue6nZ+0Bf1Ll8Pia4eVx82noapF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzadMv+Z+7S/NuKyRLmvO3X0dfneE1o29kzyDjagBUu6YGnqyro
	2rZx/O2YQzQPgqPpK1YTroc3BpBFGOMd1RwP7fwSIwvHycEExwMK5nVwp+6NHYRQfwU=
X-Gm-Gg: ASbGncvKXP3xbasX2ARWF0ZgEs2PGEW0GQdXtTvXyG+y4R8ZXJDVqDpOJPzdBiwAIlC
	VB0XQsL/pb8PC3lgjPPbfVgmB40bXW1ZHu1a5np3L9pMmLq3J642DYz/xslc6L47aGqOJVU46BZ
	hagSJsvK1eu84dj2mIURMrn6sngJFi4tBPchUsx82/ZKTd3jwB2VGmkX81qvaTY/2ewgpzi11Ju
	qplitS0cL+DWx/NE5xPQeULbvo9U/negFO+mWr9rF4aSYuNNFZaaLkFTjolOv3ZSMohJwvYB+WY
	jRuR8Tkctv6ChPs3rOY04fwDOfCZUQn/EnbYh4bUpv/QE9NkizF3D+l0H9s=
X-Google-Smtp-Source: AGHT+IEPjbaCSAbzc2xrFZQp3EVHuzfnNM2s5oxAFnC2rwIBxm63qHEQgetTL+T7uEvlpJXarMIjwQ==
X-Received: by 2002:a17:906:f594:b0:ad2:2ba6:2012 with SMTP id a640c23a62f3a-ad52d45ac6bmr19710866b.11.1747323384165;
        Thu, 15 May 2025 08:36:24 -0700 (PDT)
Received: from [100.115.92.205] ([212.180.210.124])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d490794sm4518466b.131.2025.05.15.08.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 08:36:23 -0700 (PDT)
Message-ID: <7855995f-6908-4684-b5be-dbff8415843e@blackwall.org>
Date: Thu, 15 May 2025 17:36:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bridge: netfilter: Fix forwarding of fragmented
 packets
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux.dev
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, venkat.x.venkatsubra@oracle.com, horms@kernel.org,
 pablo@netfilter.org, fw@strlen.de
References: <20250515084848.727706-1-idosch@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250515084848.727706-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/25 10:48, Ido Schimmel wrote:
> When netfilter defrag hooks are loaded (due to the presence of conntrack
> rules, for example), fragmented packets entering the bridge will be
> defragged by the bridge's pre-routing hook (br_nf_pre_routing() ->
> ipv4_conntrack_defrag()).
> 
> Later on, in the bridge's post-routing hook, the defragged packet will
> be fragmented again. If the size of the largest fragment is larger than
> what the kernel has determined as the destination MTU (using
> ip_skb_dst_mtu()), the defragged packet will be dropped.
> 
> Before commit ac6627a28dbf ("net: ipv4: Consolidate ipv4_mtu and
> ip_dst_mtu_maybe_forward"), ip_skb_dst_mtu() would return dst_mtu() as
> the destination MTU. Assuming the dst entry attached to the packet is
> the bridge's fake rtable one, this would simply be the bridge's MTU (see
> fake_mtu()).
> 
> However, after above mentioned commit, ip_skb_dst_mtu() ends up
> returning the route's MTU stored in the dst entry's metrics. Ideally, in
> case the dst entry is the bridge's fake rtable one, this should be the
> bridge's MTU as the bridge takes care of updating this metric when its
> MTU changes (see br_change_mtu()).
> 
> Unfortunately, the last operation is a no-op given the metrics attached
> to the fake rtable entry are marked as read-only. Therefore,
> ip_skb_dst_mtu() ends up returning 1500 (the initial MTU value) and
> defragged packets are dropped during fragmentation when dealing with
> large fragments and high MTU (e.g., 9k).
> 
> Fix by moving the fake rtable entry's metrics to be per-bridge (in a
> similar fashion to the fake rtable entry itself) and marking them as
> writable, thereby allowing MTU changes to be reflected.
> 
> Fixes: 62fa8a846d7d ("net: Implement read-only protection and COW'ing of metrics.")
> Fixes: 33eb9873a283 ("bridge: initialize fake_rtable metrics")
> Reported-by: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> Closes: https://lore.kernel.org/netdev/PH0PR10MB4504888284FF4CBA648197D0ACB82@PH0PR10MB4504.namprd10.prod.outlook.com/
> Tested-by: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   net/bridge/br_nf_core.c | 7 ++-----
>   net/bridge/br_private.h | 1 +
>   2 files changed, 3 insertions(+), 5 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


