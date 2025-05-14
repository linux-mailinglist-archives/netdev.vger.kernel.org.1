Return-Path: <netdev+bounces-190467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CFAAB6DF4
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 16:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9506D4C00A1
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 14:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421FA13B284;
	Wed, 14 May 2025 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="SY79hOxk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CDD18E377
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 14:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747232297; cv=none; b=VWIuVtMVFrgSEq7Ai383a50eqhDghwbLXrfFPzwFvc6A4amF9gvY/RmYloTKvFuE9/OPHGs4+TFMZPU4nC7iQJWLufksViyvsjxD/hfp5XYDJ0OfcnnAfVvjZf+b1FKTXzhjO2KvtENVS6SEOVqgYYH022VJv4OLcrgXhuCXXA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747232297; c=relaxed/simple;
	bh=0bHYo2XIYUmHNmyvpKqSkKFCp1rKycf2xoc16jelWo4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=l2ErjsL9YyXo0fDnL0HvXT0C0ILJYOHTSPVXDwjGBwjO4xNSFjLBWUpoh8qHpgRQZz5VB8nHUCKNMwYV+3oabs1Wd5Et/KmDSlylWu2gyjjbNW/uhrEFqE3xHjOYnfRIxEVhcyDdeXeSfc6eipuA+5qHzAM4jEnZ6M20o4zgw1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=SY79hOxk; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so77650845e9.3
        for <netdev@vger.kernel.org>; Wed, 14 May 2025 07:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1747232293; x=1747837093; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QS/gvn6s9evGDI7J8+gONd6hLkshn08JJh0QsMw/dQI=;
        b=SY79hOxk21aih7WmuWD88k7Sacxz3TniIXQAYAksE6evXBc12RIemXYZ8dYXABYdPU
         cPZ/M3p6NyCbZb67p9hlVkJ2T5H1YzwZWSrVb5eRQYvlAEyvkrZKJjSNzd0zLbEwA4Fu
         o5NCChDDC9dmsAYhxdOjF8o6k+bBFPyb3cZFs4Yoew9Sj+e8WEGhQ+XlHfZOVUjoaoF5
         9D4I89Q+f/r8vYiODdEAWHuYgnXD1iMG4/UL6ZvPNliZMY/puwGvmERmfEtq2FJPXpl8
         0Fps8yHjkCrTLubVtcv8qs8bmMI4Benphixpp5Tr1v6/5d3ZjYceIM36XuQFCAdwnciM
         ON/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747232293; x=1747837093;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QS/gvn6s9evGDI7J8+gONd6hLkshn08JJh0QsMw/dQI=;
        b=NMNXV3QpNbxHD2smMQMuAPUNQz6KgZk7/ncpbGMHWVkCUCYvkZJrX1jOiwhYmqU3q1
         Ixu0pbYvOPMn24o39/XmvgikLGKfECk0Dwljk1aj6VCFaeP4kWzxmlW2lyxtjeL7B0by
         40a0kzDAy5IJb8vOmMpgQq2uSm4PnN0LgYXcnW3QNlH8/F73hVjCxpzeLALHZBkR8cDp
         GHKecNO4hKzE7fjkDC2opiVkkdIttaR6G9ZHVqugUgnNK0L/fPslD78R3JpwgeETJgpa
         GUfiZMjS2vCQitB5EVBVh1KUtRdP3Q5J8OgnkBGEvbs7JMb3J+A0XFL9vPbDlCTGeUtW
         x6Sw==
X-Gm-Message-State: AOJu0Yw8kUfzEVWHPN0g4Wa0PDe0GDUwwFEhUpJ1SDu47xKdjJD7L/Ub
	y+P2qfuLbBq6w8PXbGcmjK6gago1vK4CwjyZBcNEyt01YwP1F40n8+aSBZMY61+JhopwKzAr9Qx
	skjVXDazybJCULw5ER9VLtaz1tf3ZKpdzyp3wmhjPst8+MZQnkva0rrMiAD9o
X-Gm-Gg: ASbGncsJnNWXc1BQ2rFVFLfykx6Bo0P5kNvNbivLaL+8qiNYxMWew0RgwHcLbUU6A9+
	Zkjw9nU5767fnrVbr9oPo6+HU3izbH8sVLEKH+tuYWxiFUl/HdyxUwoOXRus4hTl2+laG0VB6Kg
	A1Wpit4GW0nVZE/OJVNBC5Ox8wW9pDmbB3dVuG5RoDzHd32YECaqSlm7wa2A5tNLqN772MG8gcZ
	6TbJmMYY2u7coppxfNdAcOlF3bXpr4TpbYfD/RoDtO3dlVWNvKgM4a117A63rgtAQXQ3igU1/ie
	cKrYgRGPALDwwBxIccCB/62FPbwOcnJrL/cMbq0RoH9SM49dx794XJNTWU+c83lFk2YjQYfco4z
	42zih2plTaeJ3DU+q+jeOov5/
X-Google-Smtp-Source: AGHT+IGvzeunYQw2/8sARBt7cicj9sUMQj5XtiIYitTk+nTybk0zG0wJnz4H6zhzR0SFon3LLxffmg==
X-Received: by 2002:a05:600c:154a:b0:441:d437:e3b8 with SMTP id 5b1f17b1804b1-442f2161baamr29121325e9.23.1747232293243;
        Wed, 14 May 2025 07:18:13 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:885b:396d:f436:2d38? ([2001:67c:2fbc:1:885b:396d:f436:2d38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f33690a1sm33460925e9.3.2025.05.14.07.18.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 07:18:12 -0700 (PDT)
Message-ID: <47be0947-809d-4ca1-bfa0-018853ab4df2@openvpn.net>
Date: Wed, 14 May 2025 16:18:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ovpn: properly deconfigure UDP-tunnel
From: Antonio Quartulli <antonio@openvpn.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Sabrina Dubroca <sd@queasysnail.net>,
 David Ahern <dsahern@kernel.org>
References: <20250514095842.12067-1-antonio@openvpn.net>
 <20250514065048.3c14a599@kernel.org>
 <f74314d4-c5ab-4346-8dac-3ae8e97fb74a@openvpn.net>
Content-Language: en-US
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <f74314d4-c5ab-4346-8dac-3ae8e97fb74a@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/05/2025 16:02, Antonio Quartulli wrote:
> 
> 
> On 14/05/2025 15:50, Jakub Kicinski wrote:
>> On Wed, 14 May 2025 11:58:42 +0200 Antonio Quartulli wrote:
>>> +#if IS_ENABLED(CONFIG_IPV6)
>>> +    if (READ_ONCE(sk->sk_family) == PF_INET6)
>>> +        static_branch_dec(&udpv6_encap_needed_key);
>>
>> udpv6_encap_needed_key is only exported for ipv6.ko
>> I think you need to correct the export, because with IPV6=y
>> and UDP_TUNNEL=m we get:
>>
>> ERROR: modpost: "udpv6_encap_needed_key" [net/ipv4/udp_tunnel.ko] 
>> undefined!
> 
> Or define and export udpv6_encap_enable() which calls only the 

EDIT: I meant udpv6_encap_disable() here ^^

> static_branch_dec()?
> Basically the same as the current udpv6_encap_enable().
> 
> This way we don't need to touch the export for udpv6_encap_needed_key.
> 
> Regards,
> 

-- 
Antonio Quartulli
OpenVPN Inc.


