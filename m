Return-Path: <netdev+bounces-173329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4FEA58589
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 16:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9291A16A7F1
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 15:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8F21DED5E;
	Sun,  9 Mar 2025 15:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cjXzsOaS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246C61D47C7
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741535830; cv=none; b=b1tFDTnpOlW6c8LAtSlSuKvxw9CrdLRPUQ1HZEFS9d/8ZaLD4v87AqrX+lQFrX+tNGhOVly2a5hLc9DbYG+eXd60Qea0i9LK2v94iYVpT2TLOf7wnmL6WJiGnjhOVDY2ysDIPB6dbexHKPn/4uCTkB1HKsNFRWOMH4WytOXJJhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741535830; c=relaxed/simple;
	bh=d/dqbZIOBI3L/39sQjZRTu74WSZOB2fRliCAIzOZdOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BPa1FusRpFPQSezhPwFwwVdTGIDf8nN9aqS7OiyrDNbmTgcDvFsbevpXwwV/Bbt2nRQ8Zgquov5wxs4DvgExbjUK0CRT5D5z5xsfXqitYSJ1VH7aOVZztoMRJEBwzibcGg2vvexE9hvmnd4KgRj4wj1S5SXuQpPZgPNDZMh17vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cjXzsOaS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741535827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YLUFl2VPA9R+MN8KD36+27nxwaeHXagFx2iScOkxQ7Q=;
	b=cjXzsOaSFXVN7NjIuUitlnRuttiedqLpFTlx8GDVmPxx0U8xX10VffpQlo23ruvZ5ccjjN
	L8D09yxjIVmQjQL4JCPZliv7k6vhHvycs+BgnHahTJH7iXcHvFp2lbmL7BcI9bO56M4LnK
	onaSkmqtcj5Y/YDLLxEQeYvuerQPvGU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-VSPy23aGNJWpijcanPt6HA-1; Sun, 09 Mar 2025 11:57:06 -0400
X-MC-Unique: VSPy23aGNJWpijcanPt6HA-1
X-Mimecast-MFC-AGG-ID: VSPy23aGNJWpijcanPt6HA_1741535825
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3912fe32b08so1606291f8f.3
        for <netdev@vger.kernel.org>; Sun, 09 Mar 2025 08:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741535825; x=1742140625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YLUFl2VPA9R+MN8KD36+27nxwaeHXagFx2iScOkxQ7Q=;
        b=ZRGXNkDa4zlKl1wZBHK4Ke11Qc0IhecJzoPqWisJ4LtxB1gfI5iLBgf882lDwzftwf
         jZWVyYbsfcaXOL/UBkgJ/DjOIxrYKBvbgXsyFgcCN5bAqaG9820wyjXIQmDydlCmnsei
         3kjoDvUgZ7hAEErKcY5JXyM5Y8jj/38GniF34SOVsvkvOdUd/Ay29xjBEohee4JQlyJD
         9MvJN2yuHlHIMTeITU7DW+qClLG3XgzPrnRcvreCpelFtSpJ+XRcGMYGR6Wpm8T4volM
         JARNYVtSdK5pOJFnvErzU/38c/GlTQwLbfAQGE5Q1ldh+z3f9A4S++VDupAOgUKVzugW
         +H9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXfg9LA93pRo0wnEjzj5H0MsqGjIPt0F/QV+Bg5qMYAAmqbNYbHXp5LkMsp8FLPXDzh8lUTNxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXUGoiha9nKkSk5sV/XG/myjjfngWo881PG+MGVAgMQPpqamC5
	P9mDmFdryh2VVDufkHolgNrHPGEfeE9qja48A51Rm12YiPTUmpVFViVB+sZfaSfhbreVb83BZVQ
	Nkz6C1RrX2+fhgHf7btbmAyVOvnHitWuWFKmtnxSjb7BKofGpTbFrAQ==
X-Gm-Gg: ASbGnctMG6so4mmJQxjCHie+u+8lKVHHEkqc+NB4uIcfiVsugNteiOi71ahb7x+9JZv
	ufuTBn4K4f3ormdZnkDzzFvfrmVc/NsU2uIGhJeNisfkzeOD+NwlkH4NuK/NMjczqFAtn9AaX0h
	XUovFsVjjXw2nD8X+hQWIDm+YvbDoPXA7mqivZyAjCGgEAJb3MQ2crHekUXcFkrgyI5JH/UGm6z
	ndt3xE6E+e1QlxGjp8WYP8ktqOyDylAuX96UkuEYzUmsyEnm61KDzNxZ82oVC0rN32u4NJzMiqx
	ldWTMwbRUWwt4uQWL2rp3T9o8pVTvuCO6ua8zQoWWS91UA==
X-Received: by 2002:a5d:5e0d:0:b0:391:4231:416 with SMTP id ffacd0b85a97d-39142310601mr1339515f8f.36.1741535825091;
        Sun, 09 Mar 2025 08:57:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUl5f1t5K8P+0ZYD9alD4Fe65fDoQd/vRvHNN8uYv2+iOUIpuLr4KzZSBB9UsLpO/xt/6UoQ==
X-Received: by 2002:a5d:5e0d:0:b0:391:4231:416 with SMTP id ffacd0b85a97d-39142310601mr1339510f8f.36.1741535824798;
        Sun, 09 Mar 2025 08:57:04 -0700 (PDT)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce48165c0sm64111615e9.26.2025.03.09.08.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Mar 2025 08:57:04 -0700 (PDT)
Message-ID: <2dfd7292-901c-4155-9c80-954d2b0c7507@redhat.com>
Date: Sun, 9 Mar 2025 16:57:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next 2/2] udp_tunnel: use static call for GRO hooks
 when possible
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>
References: <cover.1741338765.git.pabeni@redhat.com>
 <8c8263ab59b1e9366f245eec4dfdccd368496e3d.1741338765.git.pabeni@redhat.com>
 <67cc8f317e5e0_14b9f9294b5@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <67cc8f317e5e0_14b9f9294b5@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/8/25 7:40 PM, Willem de Bruijn wrote:
> Paolo Abeni wrote:
>> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
>> index 054d4d4a8927f..f06dd82d28562 100644
>> --- a/net/ipv4/udp_offload.c
>> +++ b/net/ipv4/udp_offload.c
>> @@ -15,6 +15,39 @@
>>  #include <net/udp_tunnel.h>
>>  
>>  #if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
>> +
>> +/*
>> + * Dummy GRO tunnel callback; should never be invoked, exists
>> + * mainly to avoid dangling/NULL values for the udp tunnel
>> + * static call.
>> + */
>> +static struct sk_buff *dummy_gro_rcv(struct sock *sk,
>> +				     struct list_head *head,
>> +				     struct sk_buff *skb)
>> +{
>> +	WARN_ON_ONCE(1);
>> +	NAPI_GRO_CB(skb)->flush = 1;
>> +	return NULL;
>> +}
>> +
>> +typedef struct sk_buff *(*udp_tunnel_gro_rcv_t)(struct sock *sk,
>> +						struct list_head *head,
>> +						struct sk_buff *skb);
>> +
>> +struct udp_tunnel_type_entry {
>> +	udp_tunnel_gro_rcv_t gro_receive;
>> +	refcount_t count;
>> +};
>> +
>> +#define UDP_MAX_TUNNEL_TYPES (IS_ENABLED(CONFIG_GENEVE) + \
>> +			      IS_ENABLED(CONFIG_VXLAN) * 2 + \
>> +			      IS_ENABLED(CONFIG_FOE) * 2)
> 
> CONFIG_BAREUDP

Why? AFAICS BAREUDP does not implement the gro_receive callback. UDP
tunnel without such callback are irrelevant here.

Thanks,

Paolo


