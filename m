Return-Path: <netdev+bounces-172617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C05A558A6
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 22:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEF503AA81F
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 21:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C083127425F;
	Thu,  6 Mar 2025 21:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QocXZtXO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD81627604A
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 21:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741296010; cv=none; b=oNQ9VEfLTIyznQVrMMM8mbX2gLvkVR+ZkwiOeqnxDBFn5aqgonLtF33Ea0R9+NqwDkSilOtTYfrkK40Z96ngsqyLbzNPAFrbliMyUhfobyagf7j/CoewIejKhaBsuGtFXCORbc2k2LwDAKJ8qVtO7Q+NG1DTbpDBudCaV0UajEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741296010; c=relaxed/simple;
	bh=MWyaA/wXp/49YLSpcBoDA2oV52EWTWcTe7PxH3yM7aQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ReUedE76Y1AWOG31/6TbMrzPSoT+r0uQEqgSWACQYJinNiGsmgk2CTVoaG25rDcYtAUImWFEvftffglYetySyhvBvmyYVEtfZKYUeV0YxsnPlBaWy0TMh6Rx3HuljWltWJriQv7UuQ0tZnkS2/T1p86lsw8twWmRH4ToeLsRmWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QocXZtXO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741296007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2AlfdTT3ny7ZX4l+1N98G7yPvo2PKCMNZ5L+Imm0SJE=;
	b=QocXZtXOy8zejy5KRbFKXQFLKCKi1xj0yooPwnl6ytiw0ydqLAdOMgKwqCLzSDTllSBdo4
	+ETiQSFHZrCtG7xbLiVtqcZBdY6rIRyKbbproPub/8SjMhjQL8HJ8doimPhRzmMC9V2RgS
	q2xuidrLHuP0PICavyfVtw1FkZ6a1tQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-5BTe_RuxNOqXiNpwARpBWQ-1; Thu, 06 Mar 2025 16:20:06 -0500
X-MC-Unique: 5BTe_RuxNOqXiNpwARpBWQ-1
X-Mimecast-MFC-AGG-ID: 5BTe_RuxNOqXiNpwARpBWQ_1741296005
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39131f2bbe5so155015f8f.3
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 13:20:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741296005; x=1741900805;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2AlfdTT3ny7ZX4l+1N98G7yPvo2PKCMNZ5L+Imm0SJE=;
        b=G7p3zt/OyNUP7OYO6QuKVg1C05HaF1emq/rG7lkKTVrvGXb+E8d69YrsHqDJb8/pWG
         DK2L12N51ZzNDNXC8T9ATQINt0DSDZFOcID4M4NhWFDdXa3OO5Kh9PDY5TX0JNP4RrQa
         98PSWK1i72r1JZrI3az3jQtiipYpsl8Fx2sGpzX8WoNFYeo+UcHp2YNMQoPzxdM9ZGvs
         HUaStClZL9q+5C14gnFCm/dafD+WqmkUJzEZOG3789PUOqwbMoRG4YnLj8nFZkhi3Yn8
         ab2DbIPOIOpds8qFtjzyNp9JAu1jaezj1oKsXW9fnptQ7x/jAfYSPQKctPpd3NyKsxzY
         TNUg==
X-Forwarded-Encrypted: i=1; AJvYcCX5MjQYCUhqeBjA6xQH/ZtyEa6TosFVsjMfpsQyxjioT6oMI4nxgFFMLAcx1FSxYmRmKwKiuuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxZmnQv+Dyci09YDYuL+nszF5CgdZwsTiAJ6FNJi8UQCOf8QHD
	NM8XbuVKBxSuc2yG4jtcB7Qs/XyWL++fmnAhDGYWN6QL4UHCwF3pZVPuVrvD4kWPvl/80eQ0cEP
	lr/fPpRUvNpq7xMnaXW2RBF718YNMDwufFxLv/JMgCueXvDo3VT3oCA==
X-Gm-Gg: ASbGnct/dw8IlKLhIzZVwp/eSq8B6lZbs21f0b6ffNGIHoigpy6TimbudkOOsDdhCxp
	PMrN1D4A5M+MHoYJzm+fKiiab13eclVro7hWarmXl5Ialpa7KJVcWpDMmqidtuvENajK2I46YtS
	HuvM20HcQDzte8RA54gUoRpjp08rUUxkDlSBXj5TITErKJHksOWaORGh/9kvdxq99RCRNSkBduC
	YUE9qHo4S2TgrMYraqM4ZiFfyjuvibsxlH9Yf9boeG3iZa3Z9Q+wDRexUgQOQpbhElDdcPGCcaZ
	q5zlLkODbbmbaYcq8usfCq26qM4fN6xm99jJSrWwmN8apA==
X-Received: by 2002:a05:6000:156f:b0:391:ba6:c066 with SMTP id ffacd0b85a97d-39132d9870emr691134f8f.35.1741296005030;
        Thu, 06 Mar 2025 13:20:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGo7jqUc+ullGC8UPfcJOZAMWJf/WBUb9tGIJsV3mTYhmFuw8Dpxqfmt0bCv5OTwco2J1SS2Q==
X-Received: by 2002:a05:6000:156f:b0:391:ba6:c066 with SMTP id ffacd0b85a97d-39132d9870emr691117f8f.35.1741296004680;
        Thu, 06 Mar 2025 13:20:04 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0195bfsm3148212f8f.48.2025.03.06.13.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 13:20:04 -0800 (PST)
Message-ID: <840bec2f-51a6-4036-bf9a-f215a4db1be5@redhat.com>
Date: Thu, 6 Mar 2025 22:20:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] udp_tunnel: create a fast-path GRO lookup.
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>
References: <cover.1741275846.git.pabeni@redhat.com>
 <ef5aa34bd772ec9b6759cf0fde2d2854b3e98913.1741275846.git.pabeni@redhat.com>
 <67c9fb8199ef0_15800294cc@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <67c9fb8199ef0_15800294cc@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/6/25 8:46 PM, Willem de Bruijn wrote:
> Paolo Abeni wrote:
>> Most UDP tunnels bind a socket to a local port, with ANY address, no
>> peer and no interface index specified.
>> Additionally it's quite common to have a single tunnel device per
>> namespace.
>>
>> Track in each namespace the UDP tunnel socket respecting the above.
>> When only a single one is present, store a reference in the netns.
>>
>> When such reference is not NULL, UDP tunnel GRO lookup just need to
>> match the incoming packet destination port vs the socket local port.
>>
>> The tunnel socket never set the reuse[port] flag[s], when bound to no
>> address and interface, no other socket can exist in the same netns
>> matching the specified local port.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> 
>> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
>> index c1a85b300ee87..ac6dd2703190e 100644
>> --- a/net/ipv4/udp_offload.c
>> +++ b/net/ipv4/udp_offload.c
>> @@ -12,6 +12,38 @@
>>  #include <net/udp.h>
>>  #include <net/protocol.h>
>>  #include <net/inet_common.h>
>> +#include <net/udp_tunnel.h>
>> +
>> +#if IS_ENABLED(CONFIG_NET_UDP_TUNNEL)
>> +static DEFINE_SPINLOCK(udp_tunnel_gro_lock);
>> +
>> +void udp_tunnel_update_gro_lookup(struct net *net, struct sock *sk, bool add)
>> +{
>> +	bool is_ipv6 = sk->sk_family == AF_INET6;
>> +	struct udp_sock *tup, *up = udp_sk(sk);
>> +	struct udp_tunnel_gro *udp_tunnel_gro;
>> +
>> +	spin_lock(&udp_tunnel_gro_lock);
>> +	udp_tunnel_gro = &net->ipv4.udp_tunnel_gro[is_ipv6];
> 
> It's a bit odd to have an ipv6 member in netns.ipv4. Does it
> significantly simplify the code vs a separate entry in netns.ipv6?

The code complexity should not change much. I place both the ipv4 and
ipv6 data there to allow cache-line based optimization, as all the netns
fast-path fields are under struct netns_ipv4.

Currently the UDP tunnel related fields share the same cache-line of
`udp_table`.

>> @@ -631,8 +663,13 @@ static struct sock *udp4_gro_lookup_skb(struct sk_buff *skb, __be16 sport,
>>  {
>>  	const struct iphdr *iph = skb_gro_network_header(skb);
>>  	struct net *net = dev_net_rcu(skb->dev);
>> +	struct sock *sk;
>>  	int iif, sdif;
>>  
>> +	sk = udp_tunnel_sk(net, false);
>> +	if (sk && dport == htons(sk->sk_num))
>> +		return sk;
>> +
> 
> This improves tunnel performance at a slight cost to everything else,
> by having the tunnel check before the normal socket path.
> 
> Does a 5% best case gain warrant that? Not snark, I don't have a
> good answer.

We enter this function only when udp_encap_needed_key is true: ~an UDP
tunnel has been configured[1].

When tunnels are enabled, AFAIK the single tunnel device is the most
common and most relevant scenario, and in such setup this gives
measurable performance improvement. Other tunnel-based scenarios will
see the additional cost of a single conditional (using data on an
already hot cacheline, due to the above layout).

If you are concerned about such cost, I can add an additional static
branch protecting the above code chunk, so that the conditional will be
performed only when there is a single UDP tunnel configured. Please, let
me know.

Thanks,

Paolo

[1] to be more accurate: an UDP tunnel or an UDP socket with GRO enabled


