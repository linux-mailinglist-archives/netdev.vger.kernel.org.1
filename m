Return-Path: <netdev+bounces-233215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A48F0C0E9C3
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 15:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DDC5734CD86
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 14:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A47F2D0611;
	Mon, 27 Oct 2025 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhtQ10Om"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C68D30C348
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576563; cv=none; b=HUEu5LbGKvz7PXZd3+9hmmeNfl2ycqvVPSdV//oJ9jh63v4Armt4dBdg5goNFKuOy5LncZzWy0Zfn9WgFMr9SvKjQ2Bcp80ebIXCSZHG+vEswlc0e0CXbd6vtVYcn4+xPp1cCQB0YjnuanrgDv59/vAPPuDZyf6Npu4dT2ITExw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576563; c=relaxed/simple;
	bh=CjrEwSgjiwD336OKAJb8KSdBV5+gSPyH1P76ISzvG+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j9CpSeELqdFS84LCK05Et2m6YaZqwyxNrkqo8u74ZKBAaUJ/aHD9CMSDPz/ppwNfJwyhqvtxXErZHRqL6XUiNKlLValnuzV6gHSU19SvCRWj8WowOwP3e+KFk9LvMRZlhaSQ+rdQRZxF/C9jl5HM5UJzoXGQF87yM7imFlFOaF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhtQ10Om; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7a27bf4fbcbso3890066b3a.1
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 07:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761576560; x=1762181360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ANPsngXgMHjdKcxNVoXIy4m28dyqI6/YbqpsmZo++8U=;
        b=ZhtQ10Om5KrAuJrdSG2IieDdMEj4t3PEbBbUO9JiGdmMWEGp/ybH0nYSTJowSBOfO3
         Kv+xB6KhIkTed5GbFbSDLLMBToFYM/4p52riKmmXkfRroSBgawvldnSVNA49w80Y7nYe
         q6eM3lpLJ7YM8EMvKNpdqvrykm51YCzp7+nh5iEYNGz34Nv1MkMzNBomy1AVvpEy8pz4
         mtKzC6MKeBD0i580ZUgTigSVyUkdm1EMKt0lfuqGbyksMZ9sJKg4x31gYFMR58xIdiBl
         lFjaha4a7XbiY3hEmjmD0fuQlyKLUZBEGeq6vVnZjre8+NtL5zPHe+zEPaI2yu79dDiK
         c7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761576560; x=1762181360;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ANPsngXgMHjdKcxNVoXIy4m28dyqI6/YbqpsmZo++8U=;
        b=q9OvAGN67IF5PCCO8rfnqxwEqVCE9hegIy6SNiMPcZm42QuEDQ8Rdjcq9D6zzMUcN+
         P5/h7OZ1/HvuU6msRHmjKRZckUAypm19IjGAxnIRHG4shH1Etr5yCFhtxFRLhwbsCwps
         Nl1H0JaoxJfTy8gIwCjncNdvAKnUI9jnyJhfIDYPQIC8NpxeSKd11y6PhzpAAhwd0IOZ
         e0lb2r1M16htz4zfpsZYjOCkNU8GzGQxxWWBHTYwsPdfOHW70aIZyRlE1HiQaYZUn8zH
         kZft4o+XNcay6UQnrcPk3bLH+DEDwikkFF9ZRO/QUqiBXYkFt/cjKd7GoORqRa99DBpx
         zBZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw3CDrn1uQRTGVX0+01GRv7/IR2IOLY2o+LqjdfGs+C7sUz2/VCgrsDhw+IKTPgL8porkyH4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpn2wuMX3zNQAt619gizyS2fH4r0xZ6W6sfOmX+z27Ols9Y4Qo
	tEomGo/NfwAIRVqEXDAzMv+kqMg5gbDq40IQDMRdclN3lvqkvHQj4C/r
X-Gm-Gg: ASbGncviQ3LUBAmfFk3IDCHMZtJm9ep+kS/SOxixCuXhpmGT4uGL4zMLouAAr1G/z+3
	pEbs6Xp8C6fH+FfmyELQfIn6zhP7sI9mjwVVDajp5pPBtRkUKpALc+NhXKWCJpB1Gl0cvrvCIrH
	Rge1y1UQXiwj9aKNllWE3kUhsyL10hu3sHR2cMd87/dwN4T+c9SVRCiUks7XPgnUurgVsRnqTD1
	Lo5uFHgk1hbLHwqwnCHwzzp8ZVoUjrt0hBGyK6EwP9Gp4kiPNKAgirHUygHbf47l7YxMBV13ie3
	v8mK+6vWNNgr5K+g9x0ESenJjwcrflaqpwMXIRo5sj94vN1vF6GJjYW3/vOWHCGTbRmzLCOJJFv
	1QjgbAN6tbY+PXhVxCFA4G+hH9Z2wDJObYwwv/u5tJaNd4gx6QIT+V7ibRzJaA43j3FzDUDInRV
	rFfSkjE0FU4F/52n5il4QGqdXc0J3L26vcVb5RCFwA8Y2Fqp+pyfxAXddzD3UNng==
X-Google-Smtp-Source: AGHT+IEok/bzITDTCab03QqNwX8lBfkK7cWFMLgw94U0uFNw9rZow3hQZEVr+kA8L+xnK5EFRYIn1Q==
X-Received: by 2002:a05:6a00:188b:b0:7a2:8343:1b1 with SMTP id d2e1a72fcca58-7a441c2edefmr272995b3a.17.1761576560215;
        Mon, 27 Oct 2025 07:49:20 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f4c:210:d7dc:fc1f:94d0:3318? ([2001:ee0:4f4c:210:d7dc:fc1f:94d0:3318])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41404987esm8217502b3a.36.2025.10.27.07.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 07:49:19 -0700 (PDT)
Message-ID: <8e2b6a66-787b-4a03-aa74-a00430b85236@gmail.com>
Date: Mon, 27 Oct 2025 21:49:12 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5] virtio-net: fix received length check in big
 packets
To: Parav Pandit <parav@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Minggang(Gavin) Li" <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20251024150649.22906-1-minhquangbui99@gmail.com>
 <CY8PR12MB71951A2ADD74508A9FC60956DCFEA@CY8PR12MB7195.namprd12.prod.outlook.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CY8PR12MB71951A2ADD74508A9FC60956DCFEA@CY8PR12MB7195.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/25 14:11, Parav Pandit wrote:
>> From: Bui Quang Minh <minhquangbui99@gmail.com>
>> Sent: 24 October 2025 08:37 PM
>>
>> Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big
>> packets"), when guest gso is off, the allocated size for big packets is not
>> MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on negotiated MTU. The
>> number of allocated frags for big packets is stored in vi-
>>> big_packets_num_skbfrags.
>> Because the host announced buffer length can be malicious (e.g. the host
>> vhost_net driver's get_rx_bufs is modified to announce incorrect length), we
>> need a check in virtio_net receive path. Currently, the check is not adapted to
>> the new change which can lead to NULL page pointer dereference in the below
>> while loop when receiving length that is larger than the allocated one.
>>
> This looks wrong.
> A device DMAed N bytes, and it reports N + M bytes in the completion?
> Such devices should be fixed.
>
> If driver allocated X bytes, and device copied X + Y bytes on receive packet, it will crash the driver host anyway.
>
> The fixes tag in this patch is incorrect because this is not a driver bug.
> It is just adding resiliency in driver for broken device. So driver cannot have fixes tag here.

Yes, I agree that the check is a protection against broken device.

The check is already there before this commit, but it is not correct 
since the changes in commit 4959aebba8c0 ("virtio-net: use mtu size as 
buffer length for big packets"). So this patch fixes the check 
corresponding to the new change. I think this is a valid use of Fixes tag.

Thanks,
Quang Minh.

>
>> This commit fixes the received length check corresponding to the new change.
>>
>> Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big
>> packets")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>> Changes in v5:
>> - Move the length check to receive_big
>> - Link to v4: https://lore.kernel.org/netdev/20251022160623.51191-1-
>> minhquangbui99@gmail.com/
>> Changes in v4:
>> - Remove unrelated changes, add more comments
>> - Link to v3: https://lore.kernel.org/netdev/20251021154534.53045-1-
>> minhquangbui99@gmail.com/
>> Changes in v3:
>> - Convert BUG_ON to WARN_ON_ONCE
>> - Link to v2: https://lore.kernel.org/netdev/20250708144206.95091-1-
>> minhquangbui99@gmail.com/
>> Changes in v2:
>> - Remove incorrect give_pages call
>> - Link to v1: https://lore.kernel.org/netdev/20250706141150.25344-1-
>> minhquangbui99@gmail.com/
>> ---
>>   drivers/net/virtio_net.c | 25 ++++++++++++-------------
>>   1 file changed, 12 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c index
>> a757cbcab87f..2c3f544add5e 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -910,17 +910,6 @@ static struct sk_buff *page_to_skb(struct
>> virtnet_info *vi,
>>   		goto ok;
>>   	}
>>
>> -	/*
>> -	 * Verify that we can indeed put this data into a skb.
>> -	 * This is here to handle cases when the device erroneously
>> -	 * tries to receive more than is possible. This is usually
>> -	 * the case of a broken device.
>> -	 */
>> -	if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
>> -		net_dbg_ratelimited("%s: too much data\n", skb->dev-
>>> name);
>> -		dev_kfree_skb(skb);
>> -		return NULL;
>> -	}
>>   	BUG_ON(offset >= PAGE_SIZE);
>>   	while (len) {
>>   		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset,
>> len); @@ -2107,9 +2096,19 @@ static struct sk_buff *receive_big(struct
>> net_device *dev,
>>   				   struct virtnet_rq_stats *stats)
>>   {
>>   	struct page *page = buf;
>> -	struct sk_buff *skb =
>> -		page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
>> +	struct sk_buff *skb;
>> +
>> +	/* Make sure that len does not exceed the allocated size in
>> +	 * add_recvbuf_big.
>> +	 */
>> +	if (unlikely(len > vi->big_packets_num_skbfrags * PAGE_SIZE)) {
>> +		pr_debug("%s: rx error: len %u exceeds allocate size %lu\n",
>> +			 dev->name, len,
>> +			 vi->big_packets_num_skbfrags * PAGE_SIZE);
>> +		goto err;
>> +	}
>>
>> +	skb = page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
>>   	u64_stats_add(&stats->bytes, len - vi->hdr_len);
>>   	if (unlikely(!skb))
>>   		goto err;
>> --
>> 2.43.0


