Return-Path: <netdev+bounces-165260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB9FA314E6
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 20:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A77AE3A729B
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 19:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F0E26217C;
	Tue, 11 Feb 2025 19:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/uw3QzO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44482505DF
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 19:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301680; cv=none; b=gZIig8m4epFslrt6SjWMNu0NXF9M/GY7zXakaoS4WrpqFJSnWPXmM1TQ82pIhfASfKBhr2Ahb4dHr8oi2ozacQqAOMElm9E1ndExm0eQBdgV77GPG7sQSnNnspDYRVX/Jc9A2DbqvpHIvCfOH40mA2EBT89js8J74EnnbtGlU84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301680; c=relaxed/simple;
	bh=xBzVGJzscjX8iRDFYsKGaIUHmxpBHFrz5+NDDB33N2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cWdpGNoA+80qXDnjWH+oikb5m4oGytxEZgpq/urT0IGWPOzQLESl6g32EsP5GScLxldvFgBxs088wYYS45sgIFaZuojU5fa7SKAl0hHeQvZHGELnH7tfEpXwH7xUp22e+IkbIKwoi2z0yRrQE1FP+sA+SmbvVuxfpwjyNWLzuwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/uw3QzO; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38dd9b3419cso1644074f8f.0
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 11:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739301677; x=1739906477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4wfqBPN/C6N4wiMIClsrUs16EX2Qd7DuCWHS4RsO5Kc=;
        b=f/uw3QzOe0BJp9WxFltP9PWmnYMb4UwXL1Kq4R2xtqfPY0lOAH0Qqeah1OQdR/lvKa
         LaDpfsMeVQOIzBQ3NMFaQiKVZbLnsxBSVSk4KGEn1MT+9Ly1pU7VtK21XDKflpRtDVr+
         w13Ygq/OiyRwXLCqoqpV392GARRZCZeYAkyMy9xs2xa8WO2V553dgk7KlLtAgnHGCdDl
         ZwCtiZkKYJLsft2GgJBFw0LccRvZO9nxiPNd1XSWRKTWscLF9riR5URLU5u92L4lbFEh
         mUwewPFc7KXvG4QG4fV778/+Sf1wOGGDbh+lua1oXCLtE0bmO7tCouF3rcLSsixHc5+6
         HBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739301677; x=1739906477;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4wfqBPN/C6N4wiMIClsrUs16EX2Qd7DuCWHS4RsO5Kc=;
        b=PB6kiZK6r9h1L3WJpvJccvgmpaENJLdWO3AGepF9vgvaWMfkSRvX+KJmRCxuW8qc7S
         nEprVGaqTpdHU0oZ2Z3xE/Yh+SoX75Hma2vhwjoLmGCoWWSkhmWcp4xs7b7RlwDnEytD
         fx8Sk0E9I5HIn2mwnc/4+Q5TL7J6kIUph/M8zli6n9wQG/TVON4qbGLgDPNrVh+vh8Fv
         INJn4G2fQ9g5QtT67/5ktvY7s4lokOfwFbtmLWvSIRlQ3f/E2e+ah0vGlQtM4Qhyux1F
         kVQkBapamJCIb/3gheZpA7D1h9zQPnv2Fw9GmBoZkrgex/SrUQ7sHLv6lnl7FVrxCxrb
         90Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUzGdYGJuVWpPikjDxR1B81NiV352XPJU7Q26a42U4RMPP5NqpdNH1e2TaN7U9U1UnhuwSOwI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD2NDhDnnn/RTIyrH8czMIcEHDwZVvrqlthJ4CAtYoljEyvUMM
	X/GPSvk/DkE4tPQ+nsyNPsnIs7aERi0mrDj+AzZUfwPAwZFXYqwZ
X-Gm-Gg: ASbGncvK9eGohHX1SSa1KD+pnqKuIkW86O7KphAJhoY9a/9NKiImP/XvLmmay2Qw8/5
	kQTL0XGdwZxR0w3O+tt0PjaRwqf8fi/pK+toHVMxmfPPqSYj/X2aBGGes6w20MLpgjrjJ2rdFDO
	7N6ki3ZBlj5Y52KYBreKItqq39cMP57EteWry7sL3Cm2WlhjyfNYA2d8WQmG93jbotI6/FkQavj
	LmQOl6aX+STrAZSz+cfxMgwDHGSIhvoSxqi6/5IWaYiQXctI6a2WgE31BV6fJqlsBtPDBlgYGBD
	HkckmUVUmvyFvRKuPxr8J6nH0R2PqKQ1ahKW
X-Google-Smtp-Source: AGHT+IG13YTihRjB7bv2ofbN0ijCm5EY+TeYLNnvbprA4cCWuhpdsJODQZ5oaySK2Kx3dTW/Klvf7w==
X-Received: by 2002:a05:6000:1a8d:b0:385:e30a:e0f7 with SMTP id ffacd0b85a97d-38dea3d7cedmr109817f8f.22.1739301676393;
        Tue, 11 Feb 2025 11:21:16 -0800 (PST)
Received: from [172.27.54.124] ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dcaf3e4bcsm12592311f8f.41.2025.02.11.11.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 11:21:16 -0800 (PST)
Message-ID: <587688ee-2e81-49f5-a1a2-4198c14ac184@gmail.com>
Date: Tue, 11 Feb 2025 21:21:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] eth: mlx4: create a page pool for Rx
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 tariqt@nvidia.com, hawk@kernel.org
References: <20250205031213.358973-1-kuba@kernel.org>
 <20250205031213.358973-2-kuba@kernel.org>
 <76129ce2-37a7-4e97-81f6-f73f72723a17@gmail.com>
 <20250206150434.4aff906b@kernel.org>
 <18dc77ac-5671-43ed-ac88-1c145bc37a00@gmail.com>
 <20250211110635.16a43562@kernel.org>
 <ed868c30-d5e5-4496-8ea2-b40f6111f8ad@gmail.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <ed868c30-d5e5-4496-8ea2-b40f6111f8ad@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/02/2025 21:11, Tariq Toukan wrote:
> 
> 
> On 11/02/2025 21:06, Jakub Kicinski wrote:
>> On Tue, 11 Feb 2025 20:01:08 +0200 Tariq Toukan wrote:
>>>> The pool_size is just the size of the cache, how many unallocated
>>>> DMA mapped pages we can keep around before freeing them to system
>>>> memory. It has no implications for correctness.
>>>
>>> Right, it doesn't hurt correctness.
>>> But, we better have the cache size derived from the overall ring buffer
>>> size, so that the memory consumption/footprint reflects the user
>>> configuration.
>>>
>>> Something like:
>>>
>>> ring->size * (priv->frag_info[i].frag_stride for i < num_frags).
>>>
>>> or roughly ring->size * MLX4_EN_EFF_MTU(dev->mtu).
>>
>> These calculations appear to produce byte count?
> 
> Yes.
> Of course, need to align and translate to page size.
> 
>> The ring size is in *pages*. Frag is also somewhat irrelevant, given
>> that we're talking about full pages here, not 2k frags. So I think
>> I'll go with:
>>
>>     pp.pool_size =
>>         size * DIV_ROUND_UP(MLX4_EN_EFF_MTU(dev->mtu), PAGE_SIZE);
> 

Can use priv->rx_skb_size as well, it hosts the eff mtu value.

> 
> LGTM.


