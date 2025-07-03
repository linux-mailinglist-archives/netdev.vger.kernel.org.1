Return-Path: <netdev+bounces-203707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D352AF6CC9
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 10:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA4483A94E2
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 08:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1B0298CBC;
	Thu,  3 Jul 2025 08:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="da1qKQSs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6112C376B
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751531135; cv=none; b=cxd8Nje7gBmhPqIycP8H78KBJ43Rk0c91n/StGdKicb/U7V9G+vMH2zPHGcfMQp8exdzhyqApNhIE0MmacDhwUFNv+m6o0HIbmNDpMpqaN3EnzgwtSmeTbwY5HFyCNZzcMeJceIXXqXaTi+Bixj8rg9LLFsfoEoxVDBpuql/Ivw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751531135; c=relaxed/simple;
	bh=WsMySF/XcB+enG7DyeH/BxabpZ75lzse82G/1yaBK/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hyQBvTmIe/6lMWPjg8XBFA7EIyoGNAcchu5LP7zbM2EIpo0PxRV1EGRScTthpYjN+trHSofZ0jk/+pnZ0cA8aR18Tm6gsMcrFyB+tLerdCX74IahMJx8eqV/PYFhNkJQmTeHr7yNv/pZ5T7qoNu6DeQCJU2pdd3vSJsZRvzuo/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=da1qKQSs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751531132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w+hX6eInL9oS4rYK6xxO61v+vUhZrgAJU3jCZ1aDIZs=;
	b=da1qKQSsGw/sI95vUZpyBUBnm9D2o/KbaF0wyojOWIzshOdc7kZuesI1gVF1NrGHXQ7iit
	LuyxR4aVzgx55vH6wj1HQS8YZlX0sRLQbKPjBuS98rWKFCssEnPHY9yNWU4ZR6U89QCZ53
	7sDqVTduCJmeIDfr2lvxmQkpNqHUbGE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313--OlK8m42OsiQj0RulT3gyg-1; Thu, 03 Jul 2025 04:25:31 -0400
X-MC-Unique: -OlK8m42OsiQj0RulT3gyg-1
X-Mimecast-MFC-AGG-ID: -OlK8m42OsiQj0RulT3gyg_1751531130
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4eb6fcd88so3878636f8f.1
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 01:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751531130; x=1752135930;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w+hX6eInL9oS4rYK6xxO61v+vUhZrgAJU3jCZ1aDIZs=;
        b=HJE4ewUXAAtbEIGFKj9Q3xmczOBIuwqCA8EW7h6heYj0tP4Zr7knFyGWihfX4ImnP3
         DMV5+R1rlaSojSXHYu8GBG7vEq5qLFL1tghP3zzNXHFpG9DplTVxYNVaHsItAJwwJBS5
         QE63vF9CURbof2BnvvxuMbML1ZM8nXMLhFivgfXnWhBWuizt7F2rT8TouDdmXMtSRgTk
         kZeyMQtbuh9YWxlc/YJGtX1DMMG2xPk6U3Y3ABelbA3yEnYR9/u5e8Lzm7Zoyb+UELDU
         ZJdpVPoWq7JcaKCRXh+RGtG3yelYmzul8NTdYdMD/X/ZAz40gfD5qk8VU664XPG/2skG
         2thA==
X-Forwarded-Encrypted: i=1; AJvYcCXCd/ls7NWJewi8b+2l4qBRSB2mGUXmWBnOOysZI0OmcvJMXEnLF47+m5mExb847DosjTd+7Nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ4uReEBp1nMV7dfRwOHSR4DMzFiljh40bDnNJXG0OLGC22IaW
	bAGgoMHEoIApuGWiOcQGQyPCANLQjZifHUwVrUDCw0DQc2t+Vn8oDt2FVauKsoB5JqPTTDGMVzj
	6lMGl2YdkTdE4JhfNhEn7+ci4YZf8v/A2JDQGv6Xs4Y2KXri4+17/4yCLVA==
X-Gm-Gg: ASbGncuXXZIwagbzzRxPuYOHPhP8V0Z8RBMMU74O8jOEmt8eK8RD5XPj72kE3AArEyb
	MrRlYxcGaG7z8wXrDz3th1gvDoyRSZXvxBWTeHCWikZYNX5ZtLr39oE1kcV3lKlSZhJaViDIptm
	x2g+s8nDvKSPiD5M7JbCTU82qO9qUMY1+oL3O81avzFQ3y72IajdGxGkFL9es5suiSKBIdtv1Hl
	1Yi5nAS9hyezrLsk4OtR42YSsdV1qWxQUdZVRpI4CIr91H1ol1H/90ozuAnsT/2s4FBItL2O1Jw
	n1YiSoX7naF63G4hiq0/4azoLpOmxRe/Gk/KjbMy0f1dj+awkl7sWnCh92btFid01lk=
X-Received: by 2002:a05:6000:41f8:b0:3a4:cfbf:519b with SMTP id ffacd0b85a97d-3b200f21705mr5119908f8f.44.1751531129581;
        Thu, 03 Jul 2025 01:25:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt0wGhX/7QeWiSV7/qkFnswJ1nG7iTz3wiXK6fyl4Kn+gzD3l6Je4qzbU7ES8yFJrUvN2IHw==
X-Received: by 2002:a05:6000:41f8:b0:3a4:cfbf:519b with SMTP id ffacd0b85a97d-3b200f21705mr5119870f8f.44.1751531129068;
        Thu, 03 Jul 2025 01:25:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314? ([2a0d:3344:270a:b10:5fbf:faa5:ef2b:6314])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e5f923sm17612340f8f.89.2025.07.03.01.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 01:25:28 -0700 (PDT)
Message-ID: <807503bf-4213-4423-b38b-ffdc11aaaeee@redhat.com>
Date: Thu, 3 Jul 2025 10:25:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net: netfilter: Add IPIP flowtable SW
 acceleration
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
 Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Jozsef Kadlecsik <kadlec@netfilter.org>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 linux-kselftest@vger.kernel.org
References: <20250627-nf-flowtable-ipip-v2-0-c713003ce75b@kernel.org>
 <20250627-nf-flowtable-ipip-v2-1-c713003ce75b@kernel.org>
 <aF6ygRse7xSy949F@calendula> <aF-6M-4SjQgRQw1j@lore-desk>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aF-6M-4SjQgRQw1j@lore-desk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/28/25 11:47 AM, Lorenzo Bianconi wrote:
>> On Fri, Jun 27, 2025 at 02:45:28PM +0200, Lorenzo Bianconi wrote:
>>> Introduce SW acceleration for IPIP tunnels in the netfilter flowtable
>>> infrastructure.
>>> IPIP SW acceleration can be tested running the following scenario where
>>> the traffic is forwarded between two NICs (eth0 and eth1) and an IPIP
>>> tunnel is used to access a remote site (using eth1 as the underlay device):
>>>
>>> ETH0 -- TUN0 <==> ETH1 -- [IP network] -- TUN1 (192.168.100.2)
>>>
>>> $ip addr show
>>> 6: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>>>     link/ether 00:00:22:33:11:55 brd ff:ff:ff:ff:ff:ff
>>>     inet 192.168.0.2/24 scope global eth0
>>>        valid_lft forever preferred_lft forever
>>> 7: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>>>     link/ether 00:11:22:33:11:55 brd ff:ff:ff:ff:ff:ff
>>>     inet 192.168.1.1/24 scope global eth1
>>>        valid_lft forever preferred_lft forever
>>> 8: tun0@NONE: <POINTOPOINT,NOARP,UP,LOWER_UP> mtu 1480 qdisc noqueue state UNKNOWN group default qlen 1000
>>>     link/ipip 192.168.1.1 peer 192.168.1.2
>>>     inet 192.168.100.1/24 scope global tun0
>>>        valid_lft forever preferred_lft forever
>>>
>>> $ip route show
>>> default via 192.168.100.2 dev tun0
>>> 192.168.0.0/24 dev eth0 proto kernel scope link src 192.168.0.2
>>> 192.168.1.0/24 dev eth1 proto kernel scope link src 192.168.1.1
>>> 192.168.100.0/24 dev tun0 proto kernel scope link src 192.168.100.1
>>>
>>> $nft list ruleset
>>> table inet filter {
>>>         flowtable ft {
>>>                 hook ingress priority filter
>>>                 devices = { eth0, eth1 }
>>>         }
>>>
>>>         chain forward {
>>>                 type filter hook forward priority filter; policy accept;
>>>                 meta l4proto { tcp, udp } flow add @ft
>>>         }
>>> }
>>
>> Is there a proof that this accelerates forwarding?
> 
> I reproduced the scenario described above using veths (something similar to
> what is done in nft_flowtable.sh) and I got the following results:
> 
> - flowtable configured as above between the two router interfaces
> - TCP stream between client and server going via the IPIP tunnel
> - TCP stream transmitted into the IPIP tunnel:
>   - net-next:				~41Gbps
>   - net-next + IPIP flowtbale support:	~40Gbps
> - TCP stream received from the IPIP tunnel:
>   - net-next:				~35Gbps
>   - net-next + IPIP flowtbale support:	~49Gbps
> 
>>
>>> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>>> ---
>>>  net/ipv4/ipip.c                  | 21 +++++++++++++++++++++
>>>  net/netfilter/nf_flow_table_ip.c | 28 ++++++++++++++++++++++++++--
>>>  2 files changed, 47 insertions(+), 2 deletions(-)
>>>
> 
> [...]
> 
>>>  static bool nf_flow_skb_encap_protocol(struct sk_buff *skb, __be16 proto,
>>>  				       u32 *offset)
>>>  {
>>>  	struct vlan_ethhdr *veth;
>>>  	__be16 inner_proto;
>>> +	u16 size;
>>>  
>>>  	switch (skb->protocol) {
>>> +	case htons(ETH_P_IP):
>>> +		if (nf_flow_ip4_encap_proto(skb, &size))
>>> +			*offset += size;
>>
>> This is blindly skipping the outer IP header.
> 
> Do you mean we are supposed to validate the outer IP header performing the
> sanity checks done in nf_flow_tuple_ip()?

Yes.

Note that we could always obtain a possibly considerably tput
improvement stripping required validation ;)

I guess this should go via the netfilter tree, please adjust the patch
prefix accordingly.

Also why IP over IP specifically? I guess other kind of encapsulations
may benefit from similar path and are more ubiquitous.


/P


