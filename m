Return-Path: <netdev+bounces-172607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303FDA557F4
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 22:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1135E3A78F7
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D86204080;
	Thu,  6 Mar 2025 20:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GRN3NN6/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B855F1448E3
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 20:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741294799; cv=none; b=mJIDcCkaFWqwsEr48dgKeQWxn2Low+bgImxYMVxobvNNVSg4M7nLK9afWhX1X/MozROaY6LP1hwgrPdldfFd1UEYkuPYuH7av3fTNpV0v2XdpF0NDk69gSnrf2kkFAAUkTR+jBdgXYr/REbSACBY/xFPkhoqayU/xJzpoNJg59I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741294799; c=relaxed/simple;
	bh=Jll9uwzUUkr3aiLysb6/SAm4OZGRGu4qHkoBmNr0lM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZqUYoE2TkfoJxF8nopT52GNtGQRTrZ4ABOmaGFkeSmK2RS9OTCp/qBN2b+lgQn/2MZzOU/q/uG98RJmP9BNM7XFmFwev6sAYOerLZ/FkxFyNw1LIWvpGufiMcH7IioBXTbXZ/wcp8uVfSmgTpBGeIaeh2CDethnjB4JbH3q1iio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GRN3NN6/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741294796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YpHg0m1k8d9FZsb8xAlUmVSBB8dsbHdcpv9IFzYFBZE=;
	b=GRN3NN6/ltAK6w+82GlcXYFP6VQ12Te9UXdwZOqdExYXhNIZ6giu0KdwTrlw/F0ZjXouC2
	iguNJQqxZDVyPyxMZV1aIHoaFat4qYiTf6Me4h9wgzwBQSiM43Dimc415J7f/utlR9ZrpN
	6DrAmtLq4S+ZfM/h1fCmRnpSCo0WVDI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-1dDbTG87MriQWbzR0o7JCQ-1; Thu, 06 Mar 2025 15:59:50 -0500
X-MC-Unique: 1dDbTG87MriQWbzR0o7JCQ-1
X-Mimecast-MFC-AGG-ID: 1dDbTG87MriQWbzR0o7JCQ_1741294789
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4394040fea1so5998505e9.0
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 12:59:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741294789; x=1741899589;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YpHg0m1k8d9FZsb8xAlUmVSBB8dsbHdcpv9IFzYFBZE=;
        b=gC4N1gf1Vg9MlURWpLuprym05KnB0yItBb5PolM0ZBnj8S2E7oAJdQz8Ep+br+CGLf
         Uu6kdkcDW7Y7wdyx35zsEr805iraIO7P1fP4Vs5bw3S5fShXm//AwSl7r/Vz3/T/dE5g
         93oO+LsCj+VqwRLBbNMniGoMGI5sR4eJWFWCFp6cYke/k2hR4O81LyC+Ek+dwL7Vbdha
         FqjrtXDzG17pP518z6v8Pi7Q1k5GHytZBR4ruA9lTiA3Qn7vzdHy5rgRkj/kD/sFOaJD
         zZmbBrNYK8XANnCLZ2UqQG7hqmrKRlh1hcjLHMBFYMm21C8nL/sZLjvMVnYqNflr4R3R
         fI4A==
X-Gm-Message-State: AOJu0Yymt+3HfumWoz9iYry3jIZJqcNmJbtELpA9KYB/b6CaK6v9lJx4
	Y1IZ3xGdiGRHgJWeIgDelGJVnSqAcY6RMtbTt3c3EhFY2Q0TxZaoJ7gqvkJkREjwLJ3IymPRqtP
	Z68fEwrQQ6DOJA5vpM/BWb7GspRXIlQzuDS3aKF8yG5yr9NGW+7rQzg==
X-Gm-Gg: ASbGncvyb1l2VKwe+g6Ec7eMOvPgj7Y0W24LilHSNB4i0jWi0y/6tS7JuI7FmJZyQKl
	vDGb35FUT1kDC1ZV69tU/V54ncpZmq0SHhtHLlKMFdw9G/h0dy8bMVQii5K37PciJBortR5YOsx
	Poo3XMjRoZUhWEXR185Vj1nyxy1gh7VSs1EaY+jpgQSRMt8nFgQJnSdBAZAlAXNfqpNFybZOzee
	ddz51prDz14pBnoKKbALbHICcWaqeYciElaSaqSFF/NJZ55olhQ8JxNtt1LepCMMYWav9tf2K2q
	hG9rmT4x6YL1e9GNv1pWiOF5/9+5/+i6aOkGYTgO0ZDDkA==
X-Received: by 2002:a05:600c:3b17:b0:43b:c857:e9d7 with SMTP id 5b1f17b1804b1-43c5a6014b5mr6616685e9.5.1741294789135;
        Thu, 06 Mar 2025 12:59:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcMW55qO1daB++WVRwIZ73dCrFvwph9xafpV1HIbiGrPm/7uqZxv1dT2kb6qtCroQflv9igw==
X-Received: by 2002:a05:600c:3b17:b0:43b:c857:e9d7 with SMTP id 5b1f17b1804b1-43c5a6014b5mr6616605e9.5.1741294788787;
        Thu, 06 Mar 2025 12:59:48 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bdd8c3d61sm29677545e9.15.2025.03.06.12.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 12:59:48 -0800 (PST)
Message-ID: <0dc78208-ad16-4d83-a315-ae2c8bd3bbb8@redhat.com>
Date: Thu, 6 Mar 2025 21:59:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] udp_tunnel: GRO optimizations
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 David Ahern <dsahern@kernel.org>
References: <cover.1741275846.git.pabeni@redhat.com>
 <20250306105046.0aca16b3@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250306105046.0aca16b3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/6/25 7:50 PM, Jakub Kicinski wrote:
> On Thu,  6 Mar 2025 16:56:51 +0100 Paolo Abeni wrote:
>> The UDP tunnel GRO stage is source of measurable overhead for workload
>> based on UDP-encapsulated traffic: each incoming packets requires a full
>> UDP socket lookup and an indirect call.
>>
>> In the most common setups a single UDP tunnel device is used. In such
>> case we can optimize both the lookup and the indirect call.
>>
>> Patch 1 tracks per netns the active UDP tunnels and replaces the socket
>> lookup with a single destination port comparison when possible.
>>
>> Patch 2 tracks the different types of UDP tunnels and replaces the
>> indirect call with a static one when there is a single UDP tunnel type
>> active.
>>
>> I measure ~5% performance improvement in TCP over UDP tunnel stream
>> tests on top of this series.
> 
> Breaks the build with NET_UDP_TUNNEL=n (in contest) :(
> 
> net/ipv4/udp_offload.c: In function ‘udp_tunnel_gro_rcv’:
> net/ipv4/udp_offload.c:172:16: error: returning ‘struct sk_buff *’ from a function with incompatible return type ‘struct skbuff *’ [-Werror=incompatible-pointer-types]
>   172 |         return call_gro_receive_sk(udp_sk(sk)->gro_receive, sk, head, skb);
>       |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> net/ipv4/udp_offload.c: In function ‘udp_gro_receive’:
> net/ipv4/udp_offload.c:786:12: error: assignment to ‘struct sk_buff *’ from incompatible pointer type ‘struct skbuff *’ [-Werror=incompatible-pointer-types]
>   786 |         pp = udp_tunnel_gro_rcv(sk, head, skb);
>       |            ^
> In file included from ./include/linux/seqlock.h:19,
>                  from ./include/linux/dcache.h:11,
>                  from ./include/linux/fs.h:8,
>                  from ./include/linux/highmem.h:5,
>                  from ./include/linux/bvec.h:10,
>                  from ./include/linux/skbuff.h:17,
>                  from net/ipv4/udp_offload.c:9:
> net/ipv4/udp_offload.c: In function ‘udpv4_offload_init’:
> net/ipv4/udp_offload.c:936:21: error: ‘udp_tunnel_gro_type_lock’ undeclared (first use in this function); did you mean ‘udp_tunnel_gro_rcv’?
>   936 |         mutex_init(&udp_tunnel_gro_type_lock);
>       |                     ^~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/mutex.h:64:23: note: in definition of macro ‘mutex_init’
>    64 |         __mutex_init((mutex), #mutex, &__key);                          \
>       |                       ^~~~~
> net/ipv4/udp_offload.c:936:21: note: each undeclared identifier is reported only once for each function it appears in
>   936 |         mutex_init(&udp_tunnel_gro_type_lock);
>       |                     ^~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/mutex.h:64:23: note: in definition of macro ‘mutex_init’
>    64 |         __mutex_init((mutex), #mutex, &__key);                          \
>       |                       ^~~~~
> cc1: all warnings being treated as errors

whoops.. thanks will fix in v2!

/P


