Return-Path: <netdev+bounces-137438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2C59A6547
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 12:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6321F20FD6
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 10:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF7A1E6DC2;
	Mon, 21 Oct 2024 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OKY6yUX0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BDF1E573F
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507783; cv=none; b=dxg6CZaeFyJj/vv8pbEShkVRUCdzy6j670KI8Bw67/Qde5mMHKRTGsFociDxPOjw+GeSOvf7dNLu7TiY221PLZLS0ZPxIMe+X3StcBpUpWxLQcCW4urCt3KgR8cCIoKNIZyCldERPlM/JJerrC5aBEIz6JEuwfPBLYQUh3yzOCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507783; c=relaxed/simple;
	bh=f25VOJ4jl4EZ6U5b3xJzeqopBjiOxy3HcpyoNBkD144=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=t7dvtZ5Hy+tQdqh7YNSmZXUUsoUyWRA5+CUV1g3jXnUSpL9QEkeg/0YKdJwJcE2Iws3C4QM1gC8XrhflSBZ1sFP6rwOKWLXC5a712rLWQR8qctZDmDeDg2cfK3hEH06ePUscFKLmvvAHncVTNkK69KCM3p3MtuIWkcKbP9Xrqy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OKY6yUX0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729507780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zl8NkxhsjOVprDoWW2Qzq8vxlGshkjvvdBctdUvmGdo=;
	b=OKY6yUX0B7vLNczEYoQU/BU0wEFoV4vB0A3ZnGOIIqcOuQO4qvqC8yPXJNURfDkbzdakM/
	eq3GxMU0sjo82MQI/4MaQWqSmBz/dAn48WOE70/yjVKiihD69K40Xr2HmbLN+dPlSQDOox
	6UmzJQ4i9gcjiHBz2t32UqXEaz3jmJo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-L7GQPuc4OKaLhp8z7QXCdw-1; Mon, 21 Oct 2024 06:49:39 -0400
X-MC-Unique: L7GQPuc4OKaLhp8z7QXCdw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4315e8e9b1cso20810785e9.1
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 03:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729507778; x=1730112578;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zl8NkxhsjOVprDoWW2Qzq8vxlGshkjvvdBctdUvmGdo=;
        b=cCb/vKYK6bTGeSj84AtDZUU7U4+Yrn6O6Od7yL4jn06i7k3+lqeQIsBMFQnQhQoGsq
         xzrVaY91rR8rWxsIHb55pzCMEJVfTN2VqpoWdXir7LEadNaKYVNySjAAvfxriDiNW7Nx
         pQEv/hmicdcZMbaE0H7iZ7yDa0q9Zh1530dZG343qoG0EZTr4VCSId3bJ30dFL9PNxU5
         xMeYWbU7sPhPuv/6gcKtQaforDQtD16FE3zq4mPlf0yE1p2LnlOp/dlWYWNZHK5LLzFa
         o3PQwCUaMImq454rQeH6kOHRAd+N6TgZf0BbxOsXGtNIQSor3lRtsTEl/0yMkhm2us31
         PuEg==
X-Forwarded-Encrypted: i=1; AJvYcCXk+9S7iom3XSm7ShQ9/SlpmDhnZqBQYNV5ZFlAEHPC1Zp1e3kgl8ReaxS9937g3NhiUGFT+GI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrs4A76RWS8SoXep0mNWdQj5C4AcFBYJOGFDm7rOB/Id+HNfdA
	bWhkaHllCpOhSsFg5ktVCzwGxRY1o+tonAPnhfeMxuzLsBqUI48A6WMLKZ3krX7wmnt0cKU+UZ0
	X2uUsoUyC0z7+fIetKKaTkpp2FXaF9ZX1kmqq8n/TLuYu2a85aGhW1Q==
X-Received: by 2002:a05:600c:1d27:b0:431:44aa:ee2c with SMTP id 5b1f17b1804b1-4316163bb0bmr68211725e9.9.1729507778221;
        Mon, 21 Oct 2024 03:49:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPmc6ba7ssou9GTOtZg5r3s7a95KOOzPAX+9aC1kAiYD6uc9w3/zs/WO4t3sdTFuEXumAz/A==
X-Received: by 2002:a05:600c:1d27:b0:431:44aa:ee2c with SMTP id 5b1f17b1804b1-4316163bb0bmr68211595e9.9.1729507777852;
        Mon, 21 Oct 2024 03:49:37 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5c2cb8sm53805945e9.31.2024.10.21.03.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 03:49:37 -0700 (PDT)
Message-ID: <f792a828-8a61-4a14-bef8-ff318b5a4ac3@redhat.com>
Date: Mon, 21 Oct 2024 12:49:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 07/10] net: ip: make ip_route_input_noref()
 return drop reasons
From: Paolo Abeni <pabeni@redhat.com>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 dsahern@kernel.org, pablo@netfilter.org, kadlec@netfilter.org,
 roopa@nvidia.com, razor@blackwall.org, gnault@redhat.com,
 bigeasy@linutronix.de, idosch@nvidia.com, ast@kernel.org,
 dongml2@chinatelecom.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bridge@lists.linux.dev, bpf@vger.kernel.org
References: <20241015140800.159466-1-dongml2@chinatelecom.cn>
 <20241015140800.159466-8-dongml2@chinatelecom.cn>
 <c6e8f053-32bb-4ebd-871b-af416d0b0531@redhat.com>
Content-Language: en-US
In-Reply-To: <c6e8f053-32bb-4ebd-871b-af416d0b0531@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/21/24 12:44, Paolo Abeni wrote:
> On 10/15/24 16:07, Menglong Dong wrote:
>> diff --git a/net/core/lwt_bpf.c b/net/core/lwt_bpf.c
>> index e0ca24a58810..a4652f2a103a 100644
>> --- a/net/core/lwt_bpf.c
>> +++ b/net/core/lwt_bpf.c
>> @@ -98,6 +98,7 @@ static int bpf_lwt_input_reroute(struct sk_buff *skb)
>>  		skb_dst_drop(skb);
>>  		err = ip_route_input_noref(skb, iph->daddr, iph->saddr,
>>  					   ip4h_dscp(iph), dev);
>> +		err = err ? -EINVAL : 0;
> 
> Please introduce and use a drop_reason variable here instead of 'err',
> to make it clear the type conversion.

Or even better, collapse the 2 statements:

		err = ip_route_input_noref(skb, iph->daddr, iph->saddr,
				   ip4h_dscp(iph), dev) ? -EINVAL : 0;

There are other places which could use a similar changes.

Thanks,

Paolo


