Return-Path: <netdev+bounces-205026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6321AFCE5C
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 16:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 458CC18840DF
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 14:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EC82E0917;
	Tue,  8 Jul 2025 14:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXkOTZ0R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F314A2E0914;
	Tue,  8 Jul 2025 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986714; cv=none; b=Mhs8d9bNwT3KZzFyt0uSCwurkPWeIajPXcNwk9IZc5M/Tuw5jEULLkanRgMv4hsIYWnd+oKJeKqjIWjrNqDNkDd8lRDwAByOGAndh2T893tuYCWtBPivn3b3ZDmqppQ8vBAVR6/O6IS9fJOFEzeOC+6sSsJlJDhqH6SmAHysHLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986714; c=relaxed/simple;
	bh=+NqjU4uQXlMtOkNUF+YqZyMgp92MuypF4BvPFXX8Ve0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NxucAh/6T6Yvd/3DU+eOrWREqqmVrWv18dEwKKwG37nMOipSkiWv15wtCqVdhJz8faH3PmVyYC9MSSfoEOF+QIMny8hHtjoz6utq52JefeZO0E//LeMICXInxSfIjY8OXp1x9P6qIqgyGQz67UyaSBotSj3wBGjNPh/diLBOt9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXkOTZ0R; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-235d6de331fso58333215ad.3;
        Tue, 08 Jul 2025 07:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751986712; x=1752591512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UWScCBjnLf2R/TIfIIUf9QArMhSADm4WDSoogHlveqE=;
        b=KXkOTZ0Re8fWuo3lkOgCn+bjmW4Y+V04GITXg5C5W9iA5k/nO3uk6RMKQZBPuPRkyp
         Sb4gLoo/uFvSeAYOq+3A1M/kuRiubdbCWLaUKX2Nvc1D+POtgfqj42dj59QYaBxLIRTl
         Gww+wZgmFiJToy8ViegUBAWAdyMlzukrEcNJEG59HUMup+G1rqx7GtMzqvi55sJIHycn
         jdatu0/vP1aWQ/zrEBzJB1P12C1ZUohIwsqnuvYpIiBYRftsWN9gUgapjYiuGXoXVXKu
         DOjK3bp3pINTToJoXvahP4H6yHa5l3AUFL7F2q8Iaz/Et4a/bVe1A5DvZAxb6oWa4DuS
         J3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751986712; x=1752591512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UWScCBjnLf2R/TIfIIUf9QArMhSADm4WDSoogHlveqE=;
        b=XHZUK7h9Ocr1uCEvKd89P71xc2oECMdy5lIDWDSEe73rEY7CUBOrYP0GbcU3ebIdsT
         bt6m2gqSyP1cilC2PAkssSdoqZktcGneZ1/rJGm0sDfwki7lNGACUjGJ81b8x9ZxqCEV
         /tJ7C2eGwf9qnONHEtnhqnGVxcUwtU7DkMJsHGSPrtcztgdCLvMlvG0VMOAzOlf7mSp3
         PaRt4oiDDhmApovgm2h3J8VbcSxKDv7yCZapASpzTUO2sAWcON9YgY2y0eIusIigA+37
         TrGoP0SSvyFo70XcVgKy18Hn9mov25vPLcJ+0xxWquWobL/Ni83G6QKlMk4z90dBwZv4
         4opA==
X-Forwarded-Encrypted: i=1; AJvYcCWIYeoJ6HqmAFl5onHnKK0xpKABYTvpnQs4vG4CY0JAAWOaXiBnXFrf0Ju5BU1PXOWZnNu5ycDH@vger.kernel.org, AJvYcCWr2Y0G7Hc/suEj3elMeVev6XNz4UfdlDljdiRfsXGCDjgzqPLoa5ye4Zt5w6Jf2keOyfYiegv6Il0V8JA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyovaksIN4eatNru+XiJXxnkvQHrP/3POxoKuqbg0Bwab71ll8e
	uz0XWpS+8fn0IDV+sJnmOWOusYW4KHcQVj51StwgjdQCjru2DxXzsBsh
X-Gm-Gg: ASbGnct30YhYVGbZg5m46nhL3WHEzf0rJcKnbJ5qofK+msSW8Z3dLhfWuDw1+JJ7sGW
	xhgFySCZmKq5VwNyR0HxfB9z/iEfHLOmffm6hKDROQWP3lDmjqh4s2b9IGjr3zwreO3MgsiAy1U
	pRelrg5Bl5Zz9s2z/QpttRoVpZkqAfu81BMjJyzqQ7l6NmChpd8pyD2PyXWv2koS4zF4u2jCtUX
	QB+XJUQU4qZfetha3Y1gbVp1mzQsGYizi8DrkLOp3rFO15AiHalttgnfvwZEK6f5FGgtgL2m4Ap
	l90k7y4DWnTusB1gkY9zqHrnentRaMuKCBfrqp1vA/KCHYiF6/PVO9YBEFPYeSekL5L42Su+kJ7
	+lGcuGMgsLccUQJHR/MjV/+vu7WHUeVvSalkJ1nVt
X-Google-Smtp-Source: AGHT+IGsiWMFIFsAbr8aNOe79of4TnBXH6qxow/kWKTKfQRaWTwycD8M4/HGPfM50XdIS7N54Zneag==
X-Received: by 2002:a17:903:40d1:b0:235:ca87:37ae with SMTP id d9443c01a7336-23c85eb057dmr299625885ad.41.1751986712178;
        Tue, 08 Jul 2025 07:58:32 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:37c0:6356:b7b4:119a? ([2001:ee0:4f0e:fb30:37c0:6356:b7b4:119a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455d153sm115207925ad.94.2025.07.08.07.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 07:58:31 -0700 (PDT)
Message-ID: <a9def060-375b-4980-8ee5-e5a54fc6cb8c@gmail.com>
Date: Tue, 8 Jul 2025 21:58:24 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] virtio-net: fix received length check in big
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250708144206.95091-1-minhquangbui99@gmail.com>
 <CY8PR12MB7195AC4C23690D748ABAD675DC4EA@CY8PR12MB7195.namprd12.prod.outlook.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CY8PR12MB7195AC4C23690D748ABAD675DC4EA@CY8PR12MB7195.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/25 21:52, Parav Pandit wrote:
>> From: Bui Quang Minh <minhquangbui99@gmail.com>
>> Sent: 08 July 2025 08:12 PM
>>
>> Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big
>> packets"), the allocated size for big packets is not MAX_SKB_FRAGS *
>> PAGE_SIZE anymore but depends on negotiated MTU. The number of
>> allocated frags for big packets is stored in
>> vi->big_packets_num_skbfrags. This commit fixes the received length
>> check corresponding to that change. The current incorrect check can lead to
>> NULL page pointer dereference in the below while loop when erroneous
>> length is received.
> Do you mean a device has copied X bytes in receive buffer but device reports X+Y bytes in the ring?

Yes, that's what I mean. AFAIK, it's not checked in the ring level.


Thanks,
Quang Minh.

>
>> Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big
>> packets")
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>> Changes in v2:
>> - Remove incorrect give_pages call
>> ---
>>   drivers/net/virtio_net.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c index
>> 5d674eb9a0f2..3a7f435c95ae 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -823,7 +823,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info
>> *vi,  {
>>   	struct sk_buff *skb;
>>   	struct virtio_net_common_hdr *hdr;
>> -	unsigned int copy, hdr_len, hdr_padded_len;
>> +	unsigned int copy, hdr_len, hdr_padded_len, max_remaining_len;
>>   	struct page *page_to_free = NULL;
>>   	int tailroom, shinfo_size;
>>   	char *p, *hdr_p, *buf;
>> @@ -887,12 +887,15 @@ static struct sk_buff *page_to_skb(struct
>> virtnet_info *vi,
>>   	 * tries to receive more than is possible. This is usually
>>   	 * the case of a broken device.
>>   	 */
>> -	if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
>> +	BUG_ON(offset >= PAGE_SIZE);
>> +	max_remaining_len = (unsigned int)PAGE_SIZE - offset;
>> +	max_remaining_len += vi->big_packets_num_skbfrags * PAGE_SIZE;
>> +	if (unlikely(len > max_remaining_len)) {
>>   		net_dbg_ratelimited("%s: too much data\n", skb->dev-
>>> name);
>>   		dev_kfree_skb(skb);
>>   		return NULL;
>>   	}
>> -	BUG_ON(offset >= PAGE_SIZE);
>> +
>>   	while (len) {
>>   		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset,
>> len);
>>   		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
>> --
>> 2.43.0


