Return-Path: <netdev+bounces-180692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACABA82242
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 12:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D75D3B20CE
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 10:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E4725522B;
	Wed,  9 Apr 2025 10:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="C6zosi2H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4636C1DA60F
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 10:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744194804; cv=none; b=AhwZLdQPK7mJeWSfqsRT79FtxNgUrhtM8Z8fN9CFI+iJpJzINOOxT2A9S9OJRLXgxKNitwd9b41wX9Q8kTlikKHKYTNT5M+f+s95oEmW1yHcLqlUNVoTYp4IBiIz5Apv3en91mZHFIoQObulrC3Lr+CN7uXem9kPe/Y0kxesjrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744194804; c=relaxed/simple;
	bh=zqBa8qyfz3XqnbkLny2u5Hws//r6LChLxkecT5EOKeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qnAwT4ISJUsgEqXUJeXXRCSsKNbR1RZx/hebFO4loqSrzVqx+0xf33j9hSU/ZVtXXTmj0trgShd3jk7savevp8xjnOqVwreKww2XbOGeQqL/f7/yf6ooEIvC83N2Y7giYWMoe+UTtL06fEdxDBykWxZwGnCskJGgVoyZpk+s3JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=C6zosi2H; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf257158fso46190585e9.2
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 03:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1744194800; x=1744799600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mBi4VOwBcb3oMnTsthtGachLyy7QtgkSFGvt4FX19+w=;
        b=C6zosi2HBQET3r55vuiOTKKvpdAQhr9ONzRPJuUWSuYAMdLTyMIgN00pwf42fhZ/g5
         Hy68EhQpmSdeH4RkQn6SPSW2mL+OhiR0bSGuVx0gS4hpFWdI8eRgaUA35vr4gjzoxJYu
         aheuHv4MV7rrEgO+P63VW01a9wjKX30SSKmMEwd5lYvaTcBIQvfvrH4zuLfSA0w2s92V
         StuxvAvbsTJ6MARcuLFu1cEqWs+S/2HHOGBcKb2/Gyh7Sk/2i+WIbabZf+sAUXp3yD/A
         EvrDplH7QpbqGgDcYEkoma0gov+IFFx+Y/yZ01p9SxxBXR2ZF2IaomBLHklLC1cRjMYC
         rBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744194800; x=1744799600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mBi4VOwBcb3oMnTsthtGachLyy7QtgkSFGvt4FX19+w=;
        b=YwJRC6Bx+9eMAYZ8Fp8t+YiIaAw0WHMAC/gUtgsNuttBJGzOIdxJCrqF28wNJrlRBH
         4StsXytyEbcL3x1sVuIXqeg6lXyzUTi4M/seoaFYOuXOFTrXh0ejykU5qSmHObmDGfs9
         5aOL3eSGhavk7A4p1mVZx9KikhBLco5pOHJB4ova3eH3IqdKvjq11rye/KTpE1xhDTPk
         lUZNx2rqKyISpQAYACWjPQ5NEgc5L0ilPn1IHnLiPIcsAwcDVttcV/p5DWVCr164QA81
         1XEi2pc6pExibh777kxEfEPIzTSLjSSN1rNV8pEKAPFLoaUoHl+CzRtrlZd6SoXl5+K+
         uehg==
X-Forwarded-Encrypted: i=1; AJvYcCUko3lkvSoKctvm3cyMnUHiDhfnq62M+BfRu6uZFISup93iHobtzF9ga+ng09RSvdTI0mdZqAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7v6nW/AHrcIFwkb7wWZldLJPRrNhpcvo/6w+I8IYJG9hpVsB5
	sTVL3Kr2lBM4oy2H0r+CaRwQel+xHkf4ziq6pAzWdDc8I1A3mRJoxiXXPBGlXKY=
X-Gm-Gg: ASbGnctFU3vhUAsleTNsUnk5eZocN3KCYGaRevsPI6GlR98nic/CNW+MJ7ngSQqOaAn
	7vDTHRNW8851y5ZIckUtRvDlXdL+7SzneOxD8+UzmO9N2DuGT7lW3QKGT+H3/kh9wZyEJU7gV0j
	7mW3WcB2qwCtwXV0oG+9Ban0nmMOKcD8kcDS80oqO1aTaAgsX5xZRIxZ6+gKb0kEOh8wDdRbuxM
	noiToxEieB21R9D+TiWGoetY5UteEItDoh39Sxx2RWcU5uDCmxtif2rhX6IankzPXFy/TVbW5WX
	kww+KKDQOGa9r4oO//eQxzQo2WNMFJhSM8WQpvaqdVDMHgGwTYEK5zrb0e7ybb9fik0S6PUpfBH
	AEanSLGU=
X-Google-Smtp-Source: AGHT+IF+VmnSjKoz4qUXSItqfvLwHlUV3cZ/MgW2aun1vPnXhsC5dMMx7i0pxZQLraz/SZM47liIVw==
X-Received: by 2002:a05:600c:2d48:b0:43c:f332:703a with SMTP id 5b1f17b1804b1-43f21ad389fmr11637865e9.31.1744194800136;
        Wed, 09 Apr 2025 03:33:20 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2338dc13sm12257075e9.3.2025.04.09.03.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 03:33:19 -0700 (PDT)
Message-ID: <7d88da06-e943-4d78-a483-66d7ce151f00@blackwall.org>
Date: Wed, 9 Apr 2025 13:33:18 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: bridge: Prevent unicast ARP/NS packets
 from being suppressed by bridge
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Cc: Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux.dev,
 mlxsw@nvidia.com, Denis Yulevych <denisyu@nvidia.com>,
 Amit Cohen <amcohen@nvidia.com>
References: <cover.1744123493.git.petrm@nvidia.com>
 <6bf745a149ddfe5e6be8da684a63aa574a326f8d.1744123493.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <6bf745a149ddfe5e6be8da684a63aa574a326f8d.1744123493.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/8/25 18:40, Petr Machata wrote:
> From: Amit Cohen <amcohen@nvidia.com>
> 
> When Proxy ARP or ARP/ND suppression are enabled, ARP/NS packets can be
> handled by bridge in br_do_proxy_suppress_arp()/br_do_suppress_nd().
> For broadcast packets, they are replied by bridge, but later they are not
> flooded. Currently, unicast packets are replied by bridge when suppression
> is enabled, and they are also forwarded, which results two replicas of
> ARP reply/NA - one from the bridge and second from the target.
> 
> RFC 1122 describes use case for unicat ARP packets - "unicast poll" -
> actively poll the remote host by periodically sending a point-to-point ARP
> request to it, and delete the entry if no ARP reply is received from N
> successive polls.
> 
> The purpose of ARP/ND suppression is to reduce flooding in the broadcast
> domain. If a host is sending a unicast ARP/NS, then it means it already
> knows the address and the switches probably know it as well and there
> will not be any flooding.
> 
> In addition, the use case of unicast ARP/NS is to poll a specific host,
> so it does not make sense to have the switch answer on behalf of the host.
> 
> According to RFC 9161:
> "A PE SHOULD reply to broadcast/multicast address resolution messages,
> i.e., ARP Requests, ARP probes, NS messages, as well as DAD NS messages.
> An ARP probe is an ARP Request constructed with an all-zero sender IP
> address that may be used by hosts for IPv4 Address Conflict Detection as
> specified in [RFC5227]. A PE SHOULD NOT reply to unicast address resolution
> requests (for instance, NUD NS messages)."
> 
> Forward such requests and prevent the bridge from replying to them.
> 
> Reported-by: Denis Yulevych <denisyu@nvidia.com>
> Signed-off-by: Amit Cohen <amcohen@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---
>  net/bridge/br_arp_nd_proxy.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
> index 115a23054a58..1e2b51769eec 100644
> --- a/net/bridge/br_arp_nd_proxy.c
> +++ b/net/bridge/br_arp_nd_proxy.c
> @@ -160,6 +160,9 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
>  	if (br_opt_get(br, BROPT_NEIGH_SUPPRESS_ENABLED)) {
>  		if (br_is_neigh_suppress_enabled(p, vid))
>  			return;
> +		if (is_unicast_ether_addr(eth_hdr(skb)->h_dest) &&
> +		    parp->ar_op == htons(ARPOP_REQUEST))
> +			return;
>  		if (parp->ar_op != htons(ARPOP_RREQUEST) &&
>  		    parp->ar_op != htons(ARPOP_RREPLY) &&
>  		    (ipv4_is_zeronet(sip) || sip == tip)) {
> @@ -410,6 +413,10 @@ void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
>  	if (br_is_neigh_suppress_enabled(p, vid))
>  		return;
>  
> +	if (is_unicast_ether_addr(eth_hdr(skb)->h_dest) &&
> +	    msg->icmph.icmp6_type == NDISC_NEIGHBOUR_SOLICITATION)
> +		return;
> +
>  	if (msg->icmph.icmp6_type == NDISC_NEIGHBOUR_ADVERTISEMENT &&
>  	    !msg->icmph.icmp6_solicited) {
>  		/* prevent flooding to neigh suppress ports */

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


