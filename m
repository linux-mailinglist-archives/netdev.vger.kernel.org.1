Return-Path: <netdev+bounces-226420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6CDB9FF9C
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 16:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B8253A5308
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 14:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722F929B20A;
	Thu, 25 Sep 2025 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvFr3C41"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC93B1E50E
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758810127; cv=none; b=XA+TSkxp9fbu2f41uRYU6qpRucsg+CvhCixd4P6Kholc0MX5UjgaPv/sl4tIzlItv3UUvCgIMjC6h5CO6jxcnRoY9vswI6ldfnENWiOX93BTSqRLcINCBe2/MAhMx7f/4oj6sJ9rMadYpMWqeyGKauwuYQ0PoRHW0+ZgWW0G21A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758810127; c=relaxed/simple;
	bh=EKG2WXysLoCvoTe3QfEw3Qjx0gwEzluktK084EedUQs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CiG13XVKJc4+FZQIJD9IrL4JLGwwQyuUfH8KGngxz3tgbWRiOMYqsuuGpWAXWqq4E0auoMoLDQTzgC8HNMXmpnbTaTsWQsDUWyKH09occyFu4P47ylnLacJ+zYSeSxIFmtsOCtpB83Aj/Wpf46/4qcC1ExK5ABfqCebFkg22yNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hvFr3C41; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758810125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lV93FB3pFQVIaxq7ycuLXtCoCRvlOAi0eLumyxrNoUU=;
	b=hvFr3C41vborFmHnKpovlTvZ7t4pKrRTXmXRZvNqy5UksTGbH8DDV2sKmtXP+Zw+oLwzbz
	jgx5T5hqJMyGkuWosl0Yucmg5p5ro8bAgHyFdSLtDfmAvMj2RdT21cKrnaYB0I8ShQ7/A7
	u5fGNY6mSL+iSwzZsMXmFP6EncHk5u4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-IEq9H-TXM6GrqvWygTqDNw-1; Thu, 25 Sep 2025 10:22:03 -0400
X-MC-Unique: IEq9H-TXM6GrqvWygTqDNw-1
X-Mimecast-MFC-AGG-ID: IEq9H-TXM6GrqvWygTqDNw_1758810122
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ecdd80ea44so633741f8f.1
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 07:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758810122; x=1759414922;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lV93FB3pFQVIaxq7ycuLXtCoCRvlOAi0eLumyxrNoUU=;
        b=qjFY04z0Vg7k36gsYJZIkdqAhv6QCUapTuTAufDb7pVzOUhpJ5brEHizYZBCQ0kyua
         /Z+YYtPQCZAztmF4Ez5D5/VZUJNlqHgw//y8bOAbresPCrlzjHdVR72M+bxC4kc0vnvg
         vWTYCSlCbfDdNGjU4UlpY4xy8drvgbR9sXshO29F/N2k+T3tgSiQQ7CgiBqGocqpv12c
         Ok9VQgM1Jlcvok5Se3jpKjWP89sQRMaZ0KP9l7XdvQQRyNYq//JZys/fmPcY03JYLmld
         VM9iMjLn3qUqKYcM/6oSCMVCeURWZf3DA7r1SX7Og8d8U09DnzyIqGXQmjIJ2FTANCXy
         b+pA==
X-Gm-Message-State: AOJu0Yz2DKTP3qVWEBBZk05155wJhEHwwyccPNI3tOZz/ibppJ6KrCox
	z2iwP4t4lkyJb3q5dreaCPbwCIhN1o1ENOPPuixBy6/x9rFWuJ05OFMdRzAjJ/zM8CKSNK8fSal
	PPQQID/Dem3FbwGo/aIRrpaz+b3vTWtpbzbdl+d+HLD9wgP2l6AS2Um2KrA==
X-Gm-Gg: ASbGncs70qWjZAg2miy1G9zcW91NHX5x3MYoXnyjySQWAyIhmv2zbRxW673e7JG1unB
	LCLvobaLMlZ3D2wYpF6ouVM/JpnqsVCSxWXs+TxNW1tzvYCoGYcvtUdSq7urnzHAXrwIxxkuNLt
	3nUHoukw//Qs+qjYk2UvbnMv86V8jLmIxRFBxYwwQz8vDfwXOh0T/eKnWy75emZmSYr6m4aSeiZ
	bvR/j/SzjHkG2dSOZUVrVcC5ADSNpvQQQLPSlJWG46yO6h3dLqaVJ5sh3G1SK7L0IRdvHoNxz2q
	F6SkgmpplDqxvNvQA/VvU9R17xnFrjvXu9oUtNAwaU1tOBm+SIx0cWbWEsoFBaJJllzJHxqCafU
	RlWNJ80UY/yJw
X-Received: by 2002:a5d:64c4:0:b0:410:88db:1c6e with SMTP id ffacd0b85a97d-41088db1ec2mr1925576f8f.16.1758810122460;
        Thu, 25 Sep 2025 07:22:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdUOUgl1HpwHY5z7X62/FPsf6dceCEMiAL7qgjKbw/iE4srX6gn0oVY88kG0BvyMD3niC+EA==
X-Received: by 2002:a5d:64c4:0:b0:410:88db:1c6e with SMTP id ffacd0b85a97d-41088db1ec2mr1925552f8f.16.1758810122026;
        Thu, 25 Sep 2025 07:22:02 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33fede76sm33506345e9.14.2025.09.25.07.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 07:22:01 -0700 (PDT)
Message-ID: <61b001c3-bf6f-410b-aa56-2b0c2c93523e@redhat.com>
Date: Thu, 25 Sep 2025 16:22:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 13/17] udp: Support gro_ipv4_max_size > 65536
From: Paolo Abeni <pabeni@redhat.com>
To: Maxim Mikityanskiy <maxtram95@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 David Ahern <dsahern@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, tcpdump-workers@lists.tcpdump.org,
 Guy Harris <gharris@sonic.net>, Michael Richardson <mcr@sandelman.ca>,
 Denis Ovsienko <denis@ovsienko.info>, Xin Long <lucien.xin@gmail.com>,
 Maxim Mikityanskiy <maxim@isovalent.com>
References: <20250923134742.1399800-1-maxtram95@gmail.com>
 <20250923134742.1399800-14-maxtram95@gmail.com>
 <5b8ed8b5-2805-4cfb-8c9c-2a8fa4ca8fb2@redhat.com>
Content-Language: en-US
In-Reply-To: <5b8ed8b5-2805-4cfb-8c9c-2a8fa4ca8fb2@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/25/25 4:15 PM, Paolo Abeni wrote:
> On 9/23/25 3:47 PM, Maxim Mikityanskiy wrote:
>> From: Maxim Mikityanskiy <maxim@isovalent.com>
>>
>> From: Maxim Mikityanskiy <maxim@isovalent.com>
>>
>> Currently, gro_max_size and gro_ipv4_max_size can be set to values
>> bigger than 65536, and GRO will happily aggregate UDP to the configured
>> size (for example, with TCP traffic in VXLAN tunnels). However,
>> udp_gro_complete uses the 16-bit length field in the UDP header to store
>> the length of the aggregated packet. It leads to the packet truncation
>> later in __udp4_lib_rcv.
>>
>> Fix this by storing 0 to the UDP length field and by restoring the real
>> length from skb->len in __udp4_lib_rcv.
>>
>> Signed-off-by: Maxim Mikityanskiy <maxim@isovalent.com>
> 
> If I read correctly, after this patch plain UDP GRO can start
> aggregating packets up to a total len above 64K.

Re-reading the patch, I now thing the above is not true.

But geneve/vxlan will do that before the end of the series, so the
following should still stand:

> Potentially every point in the RX/TX path can unexpectedly process UDP
> GSO packets with uh->len == 0 and skb->len > 64K which sounds
> potentially dangerous. How about adding an helper to access the UDP len,
> and use it everywhere tree wide (except possibly H/W NIC rx path)?
> 
> You could pin-point all the relevant location changing in a local build
> of your the udphdr len field and looking for allmod build breakge.


