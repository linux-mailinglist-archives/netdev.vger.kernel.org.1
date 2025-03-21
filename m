Return-Path: <netdev+bounces-176702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A87A6B6C6
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 10:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF0723B7624
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 09:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AD91F12F4;
	Fri, 21 Mar 2025 09:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="akfmIdv4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3A31F12F1
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 09:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742548278; cv=none; b=qolAnCpzduOsQZYoSwbedWapXYfUNNQfDEcnAyft4cKB1xaAAbEz6IM6rvsIhxIw9rys1+Q9GFbYsiawRHAxz4dKWCBnObfL+lyGGVKk79oJjsWSoQaKrXFTcbyKRXsrcive2gdw5WGu8jM7BIWiTiAYN1yCX0uFUlFILpDtqEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742548278; c=relaxed/simple;
	bh=QG0ZmrsilwyjlJMAPb2rBe6fSZkKkH0QT6tEA11dogk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=irkVIUf5s5s++gh4uLvbu+Y4bNYOxsntQe0KilVMkEnbUKBb+WSys5YQe/ghqXDQhCJSC+rDKaV7BsX2QfNYyuduSKHY0MpC8A39wAtxLEQa/pcAhDNe/PPakkxokcqIRFRqSSeCIXbdaIN3gyGA+t33HWbYr/Ki76IEQFc5Mfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=akfmIdv4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742548274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qTmsG+4cdD/C6rW0RtbzJpphvMzCRykPisO3lshPB84=;
	b=akfmIdv4Tvr6MuwNWPswT/1suyBieUtVhpvVGJrCHYexN9ZoxBVZzoPikN0MLh3RrgiwpU
	xi6XO+IaOxyvEnR9HHQHZ6Mx7NzhZw8CL73L9Lxe5eoCsp2GTH1cc/c04fdWpKPwn13AFS
	5mMwcBuwNxAE+4/Zv5+FOq5N7Imy9nc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-VuPN_3JzNP6CNR-RfkoBuA-1; Fri, 21 Mar 2025 05:11:10 -0400
X-MC-Unique: VuPN_3JzNP6CNR-RfkoBuA-1
X-Mimecast-MFC-AGG-ID: VuPN_3JzNP6CNR-RfkoBuA_1742548267
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39979ad285bso1019769f8f.2
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 02:11:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742548267; x=1743153067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qTmsG+4cdD/C6rW0RtbzJpphvMzCRykPisO3lshPB84=;
        b=W/uzUE4MMi8B5PjWz7QwxdiGUx6x3o9NivNwpQb1unZ9Xu04xJmDrEciO2MfdKM0F3
         1e6r80awUmcy8bzpO9UxJicuixLv+YzqHp93OSOwVat87DIAQmYuh3nwGkPdGrjFWyYB
         lfHfR7E3GIPhrijS9mZOazub25oeAfdxjoLjjZmNzAk38zxCVFvY0Iml6LYdV/9ActxU
         N/SFb9iWL4Mf4r2U03eLRpMExcQ/95WyQI14FnSXw8SBwiicQviU/3/+iOmHV2iSQc/8
         v1/SAE5+OTW5lAPAM5r7iG4DSB4XDJOBMfdToj9sFbYmEgkd7UdwPGrc+X78F6sPQsX7
         Z7ug==
X-Gm-Message-State: AOJu0Yx7e1pH+FN0/wlLTrSPQG3HXJ00Ft3kwOAubZYT7cZ/mYD8lx7X
	1/72W9xAIg2J79IhYUs2jaMfFoOgjcOnXqWF4CsK7AqkzTQWRsWveRHnd/J56sP2Pl2Az9YoAtY
	sWSwA9bf4LgTDGjHWSiFXxN2zXh+IND/JGO+D+9cCncK13SF46gNTJg==
X-Gm-Gg: ASbGncs9GhZ4bxOpdhILlULzG4CPHe4zkHtbRApiiGEu0cNJFD8tXqhQ1bqL2cpQAZa
	F2IetsDyVOQAPiU8okQV7NBT7RZ5n3PuhU75Xc4oPQSYGqwOY6nyYv1yaG3aL9lldT+EArKfqEU
	CZDB9bDZFBp/xJhPvP+VsUS/mNdN5pHbHIo5xqfmHp8pGk45pMXisSeSwQpxBlbBvaL7K+Wfr67
	mgD5KoNYFdeaayrX+VmV4DozSEOqMk2ChnU5uUrqGe6WM0KFmewpmTp1XdnFLa/qOT+GO0NAksN
	oZweWbYZj7fX5vt1zgO31y+kGAKczWXaXuxaf9FbX7an+aqtf924ZCMP7g==
X-Received: by 2002:a05:6000:1543:b0:390:f987:26a1 with SMTP id ffacd0b85a97d-3997f911531mr2384800f8f.29.1742548267325;
        Fri, 21 Mar 2025 02:11:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFul8g/cxbwUHc7Ngy+sXegi0wooX8mgew9f2PDG/zp0tBNHzPm0pXKzSgLovtHHsJVo27ATg==
X-Received: by 2002:a05:6000:1543:b0:390:f987:26a1 with SMTP id ffacd0b85a97d-3997f911531mr2384764f8f.29.1742548266923;
        Fri, 21 Mar 2025 02:11:06 -0700 (PDT)
Received: from [192.168.1.14] (host-87-11-8-182.retail.telecomitalia.it. [87.11.8.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd26cecsm20857965e9.17.2025.03.21.02.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 02:11:06 -0700 (PDT)
Message-ID: <758dcdea-a75e-4888-891e-9f0b0f8481c1@redhat.com>
Date: Fri, 21 Mar 2025 10:11:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 2/2] udp_tunnel: use static call for GRO hooks
 when possible
To: Nathan Chancellor <nathan@kernel.org>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 kuniyu@amazon.com
References: <cover.1741718157.git.pabeni@redhat.com>
 <6fd1f9c7651151493ecab174e7b8386a1534170d.1741718157.git.pabeni@redhat.com>
 <20250321041612.GA2679131@ax162>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250321041612.GA2679131@ax162>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/21/25 5:16 AM, Nathan Chancellor wrote:
[...]
>> +#define UDP_MAX_TUNNEL_TYPES (IS_ENABLED(CONFIG_GENEVE) + \
>> +			      IS_ENABLED(CONFIG_VXLAN) * 2 + \
>> +			      IS_ENABLED(CONFIG_NET_FOU) * 2)
> 
> I am seeing a warning in one particular configuration in my matrix when
> building with clang:
> 
>   $ make -skj"$(nproc)" ARCH=mips LLVM=1 mrproper malta_defconfig net/ipv4/udp_offload.o
>   net/ipv4/udp_offload.c:130:8: warning: array index 0 is past the end of the array (that has type 'struct udp_tunnel_type_entry[0]') [-Warray-bounds]
>     130 |                                    udp_tunnel_gro_types[0].gro_receive);

[...]

> GCC is more noisy but -Warray-bounds is not on by default yet.
> 
>   $ make -skj"$(nproc)" ARCH=mips CROSS_COMPILE=mips-linux- KCFLAGS=-Warray-bounds mrproper malta_defconfig net/ipv4/udp_offload.o
>   In function 'udp_tunnel_update_gro_rcv',
>       inlined from 'udp_tunnel_update_gro_rcv' at net/ipv4/udp_offload.c:78:6:
>   net/ipv4/udp_offload.c:125:44: warning: array subscript <unknown> is outside array bounds of 'struct udp_tunnel_type_entry[0]' [-Warray-bounds=]
>     125 |                 *cur = udp_tunnel_gro_types[--udp_tunnel_gro_type_nr];
>         |                        ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~

[...]

> Should UDP_MAX_TUNNEL_TYPES be at least 1?

Indeed! thank you for reporting.

I'll send a patch soon. I must admit I did not expect NET_UDP_TUNNEL
enabled without any of vxlan, geneve and xfrm, but such configuration is
indeed possible.

Thanks,

Paolo


