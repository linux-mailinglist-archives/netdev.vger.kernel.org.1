Return-Path: <netdev+bounces-185543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE5AA9AD89
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 14:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C565E17E528
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 12:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF0B21FF2A;
	Thu, 24 Apr 2025 12:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULkH0948"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609BA8F58;
	Thu, 24 Apr 2025 12:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498089; cv=none; b=JB+t4ZznDA4vqTTk6znyshHeMpCsK//Gc7Unvhd7Vir4gOtyc4BCf7OxTHYxEVV3hwIJDwrFd8IhHPDTL2yzlJFyUZOj5R2pMUAegQh1Wf2gTllxS6URrYr18T9MH9XJwd8JjHHk65mp3Ha3yN4G8hbixVLLxccv/pzmKyi0DpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498089; c=relaxed/simple;
	bh=KrfLb3dYhENeadLHfclkVY2xhpyyeCIa9KSRop9mmSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y1AoVTcvi4SXFWnjAazH4ZeDJCRpSX8cfdRJl/2YxEQR/M9G+X2++CQTgsirBFkrQkkfRweYMt0/rATbtTLQKHoy7sIfimBVug1CItdvJJdBMtwX4smjk5IiBhXNXSVv4xlS93yaOh9Txteo3igfRPOVQAaC1jxHw1LMNpBLn00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULkH0948; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-72c7332128eso651858a34.0;
        Thu, 24 Apr 2025 05:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745498087; x=1746102887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hH0RZy6CEf9C9Do5GJselMNIXLtLdsql2uD0FyI/a1s=;
        b=ULkH0948c3z1cvHEkydWqYS9Y6qbE6BoQ3dP47JvEGDR7xzDR7YuvmActMRuW7/2/j
         50s4ksrMdKZJwetrxNMrZ/Pb+VnW5mpmpJMXSn+DaN8c6Xdub29UkAojr7toy0tC2ZBf
         YFmG+zp28sQuhHnEn8Fl+U735/rrIwMBaGlv27dQqnUbjajGV5UHJaSGYmiBS4ywTdRG
         /6L4kCTplLB2htdE2ixkkAOJPHYqvjJb9x8KE46gnaeFVQJuYtzFMYunS28Pa73cZoqq
         nJqmL4xa6Ocaj9VZeumxEyQAc7C4z6Q2UeE5+snduyKIPAS9bIeLzmT1HcOPHX2CIXje
         AJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745498087; x=1746102887;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hH0RZy6CEf9C9Do5GJselMNIXLtLdsql2uD0FyI/a1s=;
        b=ZCi1pxmecMPTDnJ4BJymBmhsRKcwsjuMgMiryPrk2IUvoPCsi9M2f/c8uTKygKw/yt
         nKE5aYOAWxmjHKKC+oDCHiKJymZQJVQdAmfCYt0Iz9RSQ5wZQ2ect33ebKZj+bk5pA6A
         FHX0e6Iv++d2tsyxnx/TI8Q0CuKtclq81cIpiEla07jzmTPAKWf0U1iX8Lxjbm1F8Wd+
         uZZb2lJ5fw5Q5ybAXCDFBWMeUFUSXrIdX9pG7bSFDiieNjsLSSCFXZCGkqwi/r/uu5Jw
         Dwe7KC4YMrkfnQtV7L0RWwXHyku0fmQ4fNj3C11aniNkr/7lOmthSRdyYksx3MJJ1jVn
         CCsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBV6Ii6Kqc5KZGMBsdQwyR2R1ST6LBuJWv/KQRN/2DFEiC3f+9SeBLjlIzmhHf/SSfLqlXCV7YrO9pCyA=@vger.kernel.org, AJvYcCXmOR1Ry4I7NVyoy07h03CV4KGQMzwhdgmz9V3wrHWziYHpl0gARidtNGlrgeSo1+jY+waPzVOX@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Mvn6jdq3tO+i4nBBEz2p7ub4qUyEPq26ZsS1FEjP7HLY+6Nk
	/x4Eevggqg5ug7ys8KMew+bJ4s9EgxZKR4yUGirbH9rG1Mtw8Izw
X-Gm-Gg: ASbGncuWTpcHyGgq+nntTH7oPGP++qUsdkRf83tppZO4XNoD4JpsWlSbXM1G7GM+iHA
	8lHZiYghyUCUVHpes07wPuCr2YIdoivDhstNIvNJZQHJMcn82SxOCPkSCMhS8rg2Z7L57KmimT0
	Wg9Y/ylUVszy9rv400SSD6CJiAPxXh6Gi6Qv5jQd7XK7kieQg86OmuimQqT+jwrLBUJxrFQeYGo
	flDyIq3NscS5hJ5enRX0j7EfbguWP1/OI/uQ+uQGmCs3EyAszcTFGWBmTYw+KQWQdx8rcso2U1J
	vTTztWi9mwVOtmHXOnX6NRv0pbJkYMHeRBhfRwCFmxK8KhQZBQtJS3Ldr/8JeZg=
X-Google-Smtp-Source: AGHT+IHHnpY0vXN6OOyWYgYLFGpW8V10YocXs8eLf50etzWl9N50LAEAeNZIA5w/aoCJKT6/yQBDKQ==
X-Received: by 2002:a05:6830:3810:b0:72b:9993:11a5 with SMTP id 46e09a7af769-7304da58821mr1701332a34.9.1745498087306;
        Thu, 24 Apr 2025 05:34:47 -0700 (PDT)
Received: from [10.54.6.12] ([89.207.171.92])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7304f37d46asm213864a34.51.2025.04.24.05.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 05:34:46 -0700 (PDT)
Message-ID: <04ac4aec-e6cd-4432-a31d-73088e762565@gmail.com>
Date: Thu, 24 Apr 2025 14:34:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: fix VLAN 0 filter imbalance when toggling
 filtering
To: Vladimir Oltean <olteanv@gmail.com>, Jonas Gorski <jonas.gorski@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250422184913.20155-1-jonas.gorski@gmail.com>
 <20250424102509.65u5zmxhbjsd5vun@skbuf>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250424102509.65u5zmxhbjsd5vun@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/24/2025 12:25 PM, Vladimir Oltean wrote:
> On Tue, Apr 22, 2025 at 08:49:13PM +0200, Jonas Gorski wrote:
>> When a net device has NETIF_F_HW_VLAN_CTAG_FILTER set, the 8021q code
>> will add VLAN 0 when enabling the device, and remove it on disabling it
>> again.
>>
>> But since we are changing NETIF_F_HW_VLAN_CTAG_FILTER during runtime in
>> dsa_user_manage_vlan_filtering(), user ports that are already enabled
>> may end up with no VLAN 0 configured, or VLAN 0 left configured.
>>
>> E.g.the following sequence would leave sw1p1 without VLAN 0 configured:
>>
>> $ ip link add br0 type bridge vlan_filtering 1
>> $ ip link set br0 up
>> $ ip link set sw1p1 up (filtering is 0, so no HW filter added)
>> $ ip link set sw1p1 master br0 (filtering gets set to 1, but already up)
>>
>> while the following sequence would work:
>>
>> $ ip link add br0 type bridge vlan_filtering 1
>> $ ip link set br0 up
>> $ ip link set sw1p1 master br0 (filtering gets set to 1)
>> $ ip link set sw1p1 up (filtering is 1, HW filter is added)
>>
>> Likewise, the following sequence would leave sw1p2 with a VLAN 0 filter
>> enabled on a vlan_filtering_is_global dsa switch:
>>
>> $ ip link add br0 type bridge vlan_filtering 1
>> $ ip link set br0 up
>> $ ip link set sw1p1 master br0 (filtering set to 1 for all devices)
>> $ ip link set sw1p2 up (filtering is 1, so VLAN 0 filter is added)
>> $ ip link set sw1p1 nomaster (filtering is reset to 0 again)
>> $ ip link set sw1p2 down (VLAN 0 filter is left configured)
>>
>> This even causes untagged traffic to break on b53 after undoing the
>> bridge (though this is partially caused by b53's own doing).
>>
>> Fix this by emulating 8021q's vlan_device_event() behavior when changing
>> the NETIF_F_HW_VLAN_CTAG_FILTER flag, including the printk, so that the
>> absence of it doesn't become a red herring.
>>
>> While vlan_vid_add() has a return value, vlan_device_event() does not
>> check its return value, so let us do the same.
>>
>> Fixes: 06cfb2df7eb0 ("net: dsa: don't advertise 'rx-vlan-filter' when not needed")
>> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
>> ---
> 
> Why does the b53 driver depend on VID 0? CONFIG_VLAN_8021Q can be
> disabled or be an unloaded module, how does it work in that case?

This is explained in this commit:

https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=64a81b24487f0d2fba0f033029eec2abc7d82cee

however the case of starting up with CONFIG_VLAN_8021Q and then loading 
the 8021q module was not thought about, arguably I am not sure what sort 
of notification or event we can hook onto in order to react properly to 
that module being loaded. Do you know?
-- 
Florian


