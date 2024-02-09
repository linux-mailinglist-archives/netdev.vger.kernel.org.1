Return-Path: <netdev+bounces-70590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28CA84FAB4
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 18:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7621B2415F
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 17:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA457BAE4;
	Fri,  9 Feb 2024 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="dVUuITe3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E55F33CF1
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498671; cv=none; b=OmflH9rtblTSbJTScX94NJ89/N1rQ6weVB6AT4ramVANAil1jVVzJshXFNPoBcKdWUYMnYwv+mLBUBfAaw591zQgsD5Eo+ynIlHx0telBWgnMcmbz5xhjR46P6KmRovp0A/SeEteS+ourv7MPqE2RWQU2MrrZ+OwiUmuzxrkRwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498671; c=relaxed/simple;
	bh=5ZsTToELeTEic97zEXF9t8x9jAl6Un+bZuoAfSGJkw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d2EIArEMdWuhlWPqb1MBByAJvxsTxakeNsdAQH1mYJvc/Xxu+P9AKX1Mi8KcF3dWdjAi2BORYwUI8BlJJlw0Vgju/GW4a1RyEBzJjNFXzBblU+/7MUeyQUPBmEC3/GWfHFxRHtTbe9nNBJZv+1yEmdlf/uap22PNXzC0tPXsKps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=dVUuITe3; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7853a9eb5daso47333185a.2
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 09:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707498669; x=1708103469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AC6peH3Vi0jzTZPfWmZBU03AF49L7S/5YHrYxXp/0Y8=;
        b=dVUuITe3fbUUJjDJpSIbGjfPXYboGPkBBPE5Hsg10bxM29ovVBUuWRkdK32wnTKDPb
         xdP1on30FO63JjLNKdxMWzlQjQQKpGORSpdGsXkHZFTrSpSfSd8bFWJwwcwGNbX1h+QO
         8RbLw8jYRsYe3VKodVi8hGM+6Mj2j9hdlfpDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707498669; x=1708103469;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AC6peH3Vi0jzTZPfWmZBU03AF49L7S/5YHrYxXp/0Y8=;
        b=nA7Ws6Vi2aJpBIHPbJdzA1SE8+TVfp7Xn/ANtj2oUZ64Mau7u+0xqd6VI/Q4gbA7Pu
         sih70ncovzDuu6gZcJaivlpsH7JvaVdzs1/MoPBdX+jzSpD1zw1l73oCOT/cCaARti8K
         ZbIt4q5B3n7GxoDcOEDN6VgkdIe9YRrgC9fz8fwhFuB7S0YRi3X/XRcSw3UrCtYIQutf
         U+Ji/uEdRe+2CkTYLcJ0WuIedo4ckZCMScgjXS6KUF6qextNSfqIeJnZFYtGsLEjzYTp
         nqdhnY0wasn+o5+Li4NkEkz4VnmtirAHPnKP+qh5WxOwv9XC+BZDDyfW2HwjrqxlGsd9
         t/7Q==
X-Gm-Message-State: AOJu0YyEfdQrfUNxw2uXcKXHSI1zSPjFjsCmsP56id8zX/Cr6hb1TKg3
	ZMNNCCOWNtv+bksMSCvY32Gb2EwYmAEeR11gyj2sRlpaee/Fe03c4jfYbXkUihw=
X-Google-Smtp-Source: AGHT+IGI83bwYT4zJlgoXT69qlGae4FnUKgaQE7IegW7KT7883SJq6T8eO9v6cv6QzTolmAk5Za1bA==
X-Received: by 2002:a05:620a:66e:b0:784:ba4:7042 with SMTP id a14-20020a05620a066e00b007840ba47042mr1958349qkh.69.1707498668849;
        Fri, 09 Feb 2024 09:11:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXnfKttf/5gPzOrPq2zx9/3JrWv8NHI9IxmYySK27TXOp9k5u/VcTZwhSvcD7BcN5iXRYmnrdi+a103h/7mFvdhKWNKmxGCvCM9nq8gPP2KSKYvjfhxSghEMgEzrzcmPJqgI+9g2JOaO9QY0bFoOzL5V/LJ3ufu6R21TENJcLR/Nn6LU4ZMBaTR0tRxYjhs2/fXuu/aJp8YFb38Sc7AZVRQv0/B5yv8vo2THnhn1UwQKDbBT816CkN6B5XVuN43aHfJ/a9k11iARhip9UAs7qCO+5yGEVGZgjsqu+eUupIhfJpwtHJaCACH6A==
Received: from [192.168.1.159] (pool-71-191-90-13.washdc.fios.verizon.net. [71.191.90.13])
        by smtp.gmail.com with ESMTPSA id dv25-20020a05620a1b9900b00785bdc9d08esm313282qkb.32.2024.02.09.09.11.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 09:11:08 -0800 (PST)
Message-ID: <9d636726-514b-417f-ab46-6f570a563eed@fastly.com>
Date: Fri, 9 Feb 2024 12:11:07 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net] ipv4: Fix broken PMTUD when using L4 multipath hash
Content-Language: en-US
To: "Nabil S. Alramli" <nalramli@fastly.com>, David Ahern
 <dsahern@kernel.org>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: jdamato@fastly.com, srao@fastly.com, dev@nalramli.com
References: <20231012005721.2742-2-nalramli@fastly.com>
 <20231012234025.4025-1-nalramli@fastly.com>
 <e18c52e8-116e-f258-7f2c-030a80e88343@kernel.org>
 <4be64c29-f495-4fdb-a565-2540745d5412@fastly.com>
From: Suresh Bhogavilli <sbhogavilli@fastly.com>
In-Reply-To: <4be64c29-f495-4fdb-a565-2540745d5412@fastly.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi David,

On 10/16/23 2:51 PM, Nabil S. Alramli wrote:
> On 10/13/2023 12:19 PM, David Ahern wrote:
>>> On a node with multiple network interfaces, if we enable layer 4 hash
>>> policy with net.ipv4.fib_multipath_hash_policy=1, path MTU discovery is
>>> broken and TCP connection does not make progress unless the incoming
>>> ICMP Fragmentation Needed (type 3, code 4) message is received on the
>>> egress interface of selected nexthop of the socket.
>> known problem.
>>
>>> This is because build_sk_flow_key() does not provide the sport and dport
>>> from the socket when calling flowi4_init_output(). This appears to be a
>>> copy/paste error of build_skb_flow_key() -> __build_flow_key() ->
>>> flowi4_init_output() call used for packet forwarding where an skb is
>>> present, is passed later to fib_multipath_hash() call, and can scrape
>>> out both sport and dport from the skb if L4 hash policy is in use.
>> are you sure?
>>
>> As I recall the problem is that the ICMP can be received on a different
>> path. When it is processed, the exception is added to the ingress device
>> of the ICMP and not the device the original packet egressed. I have
>> scripts that somewhat reliably reproduced the problem; I started working
>> on a fix and got distracted.
> With net.ipv4.fib_multipath_hash_policy=1 (layer 4 hashing), when an
> ICMP packet too big (PTB) message is received on an interface different
> from the socket egress interface, we see a cache entry added to the
> ICMP ingress interface but with parameters matching the route entry
> rather than the MTU reported in the ICMP message.
>
> On the below node, ICMP PTB messages arrive on an interface named
> vlan100. With net.ipv4.fib_multipath_hash_policy=0 - layer3 hashing -
> the path from this cache to 139.162.188.91 is via another interface
> named vlan200.
>
> When the ICMP PTB message arrives on vlan100, an exception entry does
> get added to vlan200 and the socket's cached mtu gets updated too. TCP
> connection makes progress (not shown).
>
> sbhogavilli@node20:~$ ip route sh cache 139.162.188.91 | head
> 139.162.188.91 encap mpls 152702 via 172.18.146.1 dev vlan200
>    cache expires 363sec mtu 905 advmss 1460
> 139.162.188.91 encap mpls 152702 via 172.18.146.1 dev vlan200
>    cache expires 363sec mtu 905 advmss 1460
>
> With net.ipv4.fib_multipath_hash_policy=1 (layer 4 hashing), when TCP
> traffic egresses over vlan200 (with ICMP PTB message arriving on vlan100
> still), the cache entry still shows mtu of 1500 on the TCP egress
> interface of vlan200. No exception entry gets added to vlan100 as you noted:
>
> sbhogavilli@node20:~$ ip route sh cache 139.162.188.91 | head
> 139.162.188.91 encap mpls 152702 via 172.18.146.1 dev vlan200
>    cache mtu 1500 advmss 1460
> 139.162.188.91 encap mpls 152702 via 172.18.146.1 dev vlan200
>    cache mtu 1500 advmss 1460
>
> In this case, the TCP connection does not make progress, ultimately
> timing out.
>
> If we retry TCP connections until one uses vlan100 to egress, then the
> exception entry does get added with an MTU matching those reported in
> the ICMP PTB message:
>
> sbhogavilli@node20:~$ ip route sh cache 139.162.188.91 | head
> 139.162.188.91 encap mpls 240583 via 172.18.144.1 dev vlan100
>    cache expires 153sec mtu 905 advmss 1460
> 139.162.188.91 encap mpls 152702 via 172.18.146.1 dev vlan200
>    cache mtu 1500 advmss 1460
>
> In this case the TCP connection over vlan100 does make progress.
>
> With the proposed patch applied, an exception entry does get created on
> the socket egress interface even when that is different from the ICMP
> PTB ingress interface. Below is the output after different TCP
> connections have used the two interfaces this node has:
>
> sbhogavilli@node20:~$ ip route sh cache 139.162.188.91 | head
> 139.162.188.91 encap mpls 240583 via 172.18.144.1 dev vlan100
>    cache expires 565sec mtu 905 advmss 1460
> 139.162.188.91 encap mpls 152702 via 172.18.146.1 dev vlan200
>    cache expires 562sec mtu 905 advmss 1460
>
> Thank you.

Does that answer your question? Do you need me to make any changes to 
get your Reviewed-by?

Best regards,
Suresh


