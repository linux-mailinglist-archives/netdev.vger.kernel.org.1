Return-Path: <netdev+bounces-199823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA62BAE1F86
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 17:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D41F33A253E
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A442D541A;
	Fri, 20 Jun 2025 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IPmdBcWG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7359185920
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 15:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750434727; cv=none; b=d6M5T2babM9rP8QtI4MMFlvmNE6Vw0vJdA+Fox7VuGD123udXhOxzLZFnhhG+/VxmvXLUKua0Bh3QEsPK8E5zftkiBtMgv9yO2dmj4wqOOYj3Q13ow3jc0P+mJjDxgzHS05XnWgA3LSOZl6X8k96TU4qA3ai09gjjnMIHNKDadA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750434727; c=relaxed/simple;
	bh=ckDONzAiWfQbODzdhCb1BEA2ziP1r949KvPH0mmrG8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ttK9tJqS0ZqYENRhgnMVvJJXfTcZz05w/o4w+fqD6xgEWx+o9BfD/zNlWiN3U9YHhPOR9YGEMtnONhtLxA+Xuwwm27d+CX3sj0+Q6BXWDmPtYey/6o3bO6zUoWQrcxHMm/Uy2W8s2ZV+F/MfmJ2giUjDFEY2G6c6d+M8gmW/ufQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IPmdBcWG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750434724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dCB9tx/qDzoua8Hwn8TAnXsl+dsyVwVdrD8I5gaE/Bo=;
	b=IPmdBcWGgHOTfsUh28Pkb51247mJfGn1d6oV6NX9tRSqsVh+E120yYCvNjNAnyxSH85wHc
	GZI+7tdc5K1xFXhXfeHNY7MWmXJLTyFXJVd4RIT0BjMg/rl90hJMqD9tIs2dvNRQGusWkt
	bM9OZ9Hc/HdBeYmxvIM1+FD2SYvUub0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-XxKQijP8PJOmz5pVeKSF4g-1; Fri, 20 Jun 2025 11:52:03 -0400
X-MC-Unique: XxKQijP8PJOmz5pVeKSF4g-1
X-Mimecast-MFC-AGG-ID: XxKQijP8PJOmz5pVeKSF4g_1750434722
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45334219311so10274535e9.2
        for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 08:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750434722; x=1751039522;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dCB9tx/qDzoua8Hwn8TAnXsl+dsyVwVdrD8I5gaE/Bo=;
        b=iU8GjFummGgMfaSKgudppoHvN9v+jzUE648bmEqHrc/6bUzMNr8ls086cOOckoVuLa
         D7Ajia7kcQAYf5nvEBT4CIuY+OLtbxoWJ+nvs67Cqwjh/O7YbxkCz/pOt3CH2nzoZois
         7w5piueyEWgMKoAAclTf775sbONpDxB34mWoEAjrdItGWVH8FWh0xJfAo2GwM66UJXxG
         Z6OgLX1Li4BUh5aTG5AIGoqgzqVjmfng78vkN9NMw0hPlTZ6K25s+BP1HC/uhup7d+mf
         kHCRN95kQ3QpHDg0EGngvhoHM4BiHaPlb0IzNH/duZ6e9QPbxs+2l8pOoT5t2vSG0XZK
         0zIg==
X-Forwarded-Encrypted: i=1; AJvYcCUtflFCIGJHTFsFi0fefIvqSencB/ExswzUoRzG88p79Kcw4uVEWWfl5kuimOPVcz2KnuvqVlA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoa8KGiYcDzhyvziahhdr6Fd7lok+xn4mFvEk6ln2pIOeyfsiI
	eGuXm5Xq5v13wOynjyTqAlzy1cQfh5nWcl4d8G8xJsqD07fJSM7Noe9ME28UG2vHluQGQXaVD7t
	G/uPUvxsga7hjfipp9LC6qzaGMaCU+GHYPOidA9R3u3+xnGkygeZodNwVtw==
X-Gm-Gg: ASbGncujVq1N0QJ7q5nBQ0eCROKANLoNB+dQWfMSX12ZlcKOacajon0PG1GFilha1Cl
	viLD7pvHyNSUCyE9+t8dV/+jemy/PI0T80PWuhyCa4MZV4orLVOGqem9nBP7Z/VYIhcWLw2UIsm
	dETFOFDxj9N57d3RuCfhfXwbqvh5gf6udAnIAgWMpV+bWJ+yCL1SDsG89RH9mazskEgAh/dDe/A
	fh53c8KMFH1/Bn9YUoscIZSMLH0KiLMZn1OUoySpA3RPQqSbmM1V9S7zK9I4fQqAS9iViJ/1XPe
	it9u1r9OPnob6Xe2hgsSDXYjGOOCHA==
X-Received: by 2002:a05:600c:524e:b0:451:dee4:cd08 with SMTP id 5b1f17b1804b1-453659ed141mr30430125e9.23.1750434722185;
        Fri, 20 Jun 2025 08:52:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGY2XysSqZgq6fd7ygwselGkrM66ibvmWSBpjeqJTEPicQyU5Y53Pm95lCHxpI0s/xAXEexjw==
X-Received: by 2002:a05:600c:524e:b0:451:dee4:cd08 with SMTP id 5b1f17b1804b1-453659ed141mr30429865e9.23.1750434721789;
        Fri, 20 Jun 2025 08:52:01 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271a:7310::f39? ([2a0d:3344:271a:7310::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d117c6b2sm2420927f8f.46.2025.06.20.08.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 08:52:01 -0700 (PDT)
Message-ID: <81b7e1a5-3c7c-484d-a588-de67eb907bbf@redhat.com>
Date: Fri, 20 Jun 2025 17:51:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 7/8] tun: enable gso over UDP tunnel support.
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <cover.1750176076.git.pabeni@redhat.com>
 <1c6ffd4bd0480ecc4c8442cef7c689fbfb5e0e56.1750176076.git.pabeni@redhat.com>
 <685572ce376c8_164a2946a@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <685572ce376c8_164a2946a@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/25 4:40 PM, Willem de Bruijn wrote:
> Paolo Abeni wrote:
>> @@ -1698,7 +1700,8 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>>  	struct sk_buff *skb;
>>  	size_t total_len = iov_iter_count(from);
>>  	size_t len = total_len, align = tun->align, linear;
>> -	struct virtio_net_hdr gso = { 0 };
>> +	struct virtio_net_hdr_v1_hash_tunnel hdr;
> 
> Not for this series.
> 
> But one day virtio will need a policy on how multiple optional
> features can be composed, and simple APIs to get to those optional
> headers. Perhaps something like skb extensions.
> 
> Now, each new extention means adding yet another struct and updating
> all sites that access it.
> 
> A minimal rule may be that options can be entirely independent, but
> if they exist at least their headers are always in a fixed order.
> Which is already implied by the current extensions, i.e., hash comes
> before tunnel if present.

If I read correctly, you are suggesting that negotiating tunnel and not
hash would yield this layout:

< basic vnet hdr> <tnl fields>

with no gaps/data between the basic header fields and the tunnel-related
one. Am I correct?

This has been discussed in the previous revisions, and a recent
specification update explicitly states differently: with tunnel support
and without hash report the only possible layout is:

< basic vnet hdr> <hash report field (unused)> <tnl fields>

Since it's in the spec it's too late to change it, unless we add yet
another feature for that. I'm gladly leaving that joy and fun to someone
else:)

FTR the initial revisions of this series, before I stumbled upon the
mentioned spec change, followed the schema you mentioned.

>> @@ -1721,7 +1733,12 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>>  	if (tun->flags & IFF_VNET_HDR) {
>>  		int vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
>>  
>> -		hdr_len = tun_vnet_hdr_get(vnet_hdr_sz, tun->flags, from, &gso);
>> +		if (vnet_hdr_sz >= TUN_VNET_TNL_SIZE)
>> +			features = NETIF_F_GSO_UDP_TUNNEL |
>> +				   NETIF_F_GSO_UDP_TUNNEL_CSUM;
> 
> Maybe a helper virtio_net_has_opt_tunnel(), to encapsulate whatever
> conditions have to be met. As those conditions are not obvious.
> 
> Especially if needed in multiple locations. Not sure if that is the
> case here, I have not checked that.

Yep, as an outcome of Ajihiko's review I'm encapsulation the above in
a new helper - tun_vnet_hdr_guest_features() to be more generic.

>> @@ -2812,6 +2849,8 @@ static void tun_get_iff(struct tun_struct *tun, struct ifreq *ifr)
>>  
>>  }
>>  
>> +#define PLAIN_GSO (NETIF_F_GSO_UDP_L4 | NETIF_F_TSO | NETIF_F_TSO6)
>> +
> 
> Minor/subjective: prefer const unsigned int at function scope over untyped
> file scope macros.

Unless it's blocking I would keep the current code here.

>> +static inline int
>> +tun_vnet_hdr_tnl_to_skb(unsigned int flags, netdev_features_t features,
>> +			struct sk_buff *skb,
>> +			const struct virtio_net_hdr_v1_hash_tunnel *hdr)
>> +{
>> +	return virtio_net_hdr_tnl_to_skb(skb, hdr,
>> +					 !!(features & NETIF_F_GSO_UDP_TUNNEL),
>> +					 !!(features & NETIF_F_GSO_UDP_TUNNEL_CSUM),
> 
> Double exclamation points not needed. Compiler does the right thing
> when arguments are of type bool.

Will drop in the next revision.

Thanks!

Paolo


