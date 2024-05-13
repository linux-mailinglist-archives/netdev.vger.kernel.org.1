Return-Path: <netdev+bounces-95937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 344858C3E27
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 11:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E48F1F22302
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 09:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60C61487E6;
	Mon, 13 May 2024 09:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="gNWiK+O/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2171474B1
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 09:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715592708; cv=none; b=BNce7U4ww1lO6hwNe2ITE9m6+LKaUoG4EgkjqF15H781wgUpsJYv4d3ncSBWcKwMH9/ongnIcSaYeHOjPGGoNoZs+mZi6+VBNgtH9zlJJerofP2pSV/PLevWyIJTIEwoG9I4s9f9OeJ+PItv4iyGa0Hmn1RLa2mjBqSMAhv92mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715592708; c=relaxed/simple;
	bh=ZHLHrLEIKqkYkqB76vMfGr0ZZqadUcDF/H5Z79PziIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jtj24BjmHAhmEmwbizi2nzHV2yf8FGlv1XPGjmLfgw5vA2WyLpPauwbGY4/ELp3y2CU2/IVbGD5HyyOdBVpzFmrzGKcZsmtZNjwzh+gaB4EBP2PyKIzogj6fXdFgJtxzlb+YdbmC16KVvEftu3HjGxJmqZllHkK8yqJGfN5Okgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=gNWiK+O/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41ffad242c8so17776135e9.3
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 02:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1715592704; x=1716197504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RfMSVAy5fNk1eJoLJdNzw5ugMJreN9ffXxikfBLEVUA=;
        b=gNWiK+O/jev0MzRA2jA6swiM69doKlATz56ZhXsxHOeZR/Df61X/nLYeL1yeJbMx9R
         huWlWM2oqHZXoPu4SDac8ehcREa/cw2xowJFEE6Iis20DxysFN3mxndlk+4D/cpGHg49
         R6U3Nw5ORgb+DXwfDbINlfV98K47BkW3TknYSsnAdYwVW61LOVG234AXLBic66YmPeIe
         ZPu3+MrRUM+Zrlnx2uKp3ti/OWe6i7qfiiqEcr97xUD1tc6vTkpIESj/Puvw9TCiOzGE
         zyz2qhhSnbpzLNYCw1V5TzaZzWwN8O38YRUkCldB7/dmP3aCt0zs92JAtVyrocCUFadV
         JiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715592704; x=1716197504;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfMSVAy5fNk1eJoLJdNzw5ugMJreN9ffXxikfBLEVUA=;
        b=KQ61U6tvVQEDv3gbrkwdnmj/KEJpoXFOX+QoWOaegcqyR/wWYdzAyBf+Sfe5JeuU68
         GKyVA3IA+DYekbVozVG11cXz2tQ7VrzKqGUGADvJ+eyEV5GNBZPE/ektscrsRTmAbIkI
         MIKbwvZCH2Vqda7Ofco1o4Xrw2hZRNjKWb3bgD2NHhKzz71QwowhbBwYw1d8HozAPQtI
         vdjmmFJXVrV9Dx8zqh0t0WfwRFyYthqXn1Cy4Qn3ZaXpz57K+fdlq0re04Fr4GHlCZav
         9cHrL1fuqCGXXPlL2qzuub2c0l669ZY33ayjWtBdJsaKrBztgZZdIWnhrHodElNX7H0T
         qF9g==
X-Gm-Message-State: AOJu0YyUHvV8u0PMWI96jR4jb3ZnqWVD5XPPXaAu6UjTI7Voy/jR/0Bw
	QRRAu7UAj5C0ZmhB9cM3eocEBt8StNjuUPb8f+mUyFt+I4VBEYrBe55ZCkjyzNKjHCqiC3+kudm
	Z
X-Google-Smtp-Source: AGHT+IF+wVYW+HEatrmsM30XLOxJtqQzUJWVYjacYAbKKaxCgL68b26tmWmsXqtJanCAIGo/S29psg==
X-Received: by 2002:a05:600c:1f87:b0:41a:aa6:b59e with SMTP id 5b1f17b1804b1-41fea931b71mr116849215e9.5.1715592704123;
        Mon, 13 May 2024 02:31:44 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:b0a4:8921:8456:9b28? ([2001:67c:2fbc:0:b0a4:8921:8456:9b28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42014f563adsm38852415e9.38.2024.05.13.02.31.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 02:31:43 -0700 (PDT)
Message-ID: <81f2c217-e1ac-4f72-949f-b3e2ec5c4650@openvpn.net>
Date: Mon, 13 May 2024 11:33:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 12/24] ovpn: store tunnel and transport
 statistics
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Esben Haabendal <esben@geanix.com>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-13-antonio@openvpn.net> <ZkCCPvzuRED57RKL@hog>
 <f4d2dfc1-5585-4e87-b53d-28890eec4c13@openvpn.net> <ZkHbEKr1k9Q7vgIu@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZkHbEKr1k9Q7vgIu@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/05/2024 11:19, Sabrina Dubroca wrote:
> 2024-05-13, 09:25:29 +0200, Antonio Quartulli wrote:
>> On 12/05/2024 10:47, Sabrina Dubroca wrote:
>>> 2024-05-06, 03:16:25 +0200, Antonio Quartulli wrote:
>>>> Byte/packet counters for in-tunnel and transport streams
>>>> are now initialized and updated as needed.
>>>>
>>>> To be exported via netlink.
>>>>
>>>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
>>>> ---
>>>>    drivers/net/ovpn/Makefile |  1 +
>>>>    drivers/net/ovpn/io.c     | 10 ++++++++
>>>>    drivers/net/ovpn/peer.c   |  3 +++
>>>>    drivers/net/ovpn/peer.h   | 13 +++++++---
>>>>    drivers/net/ovpn/stats.c  | 21 ++++++++++++++++
>>>>    drivers/net/ovpn/stats.h  | 52 +++++++++++++++++++++++++++++++++++++++
>>>
>>> What I'm seeing in this patch are "success" counters. I don't see any
>>> stats for dropped packets that would help the user figure out why
>>> their VPN isn't working, or why their CPU is burning up decrypting
>>> packets that don't show up on the host, etc. You can guess there are
>>> issues by subtracting the link and vpn stats, but that's very limited.
>>
>> This stats are just the bare minimum to make our current userspace happy :-)
>>
>> But we can always extend the stats reporting later on, no?
>>
>>>
>>> For example:
>>>    - counter for packets dropped during the udp encap/decap
>>>    - counter for failed encrypt/decrypt (especially failed decrypt)
>>>    - counter for replay protection failures
>>>    - counter for malformed packets
>>>
>>> Maybe not a separate counter for each of the prints you added in the
>>> rx/tx code, but at least enough of them to start figuring out what's
>>> going on without enabling all the prints and parsing dmesg.
>>
>> Definitely a good suggestion! I'd just postpone it for later, unless you
>> think it's a blocker.
> 
> I'm not sure. It's not strictly necessary to make the driver work, but
> from a user/admin's point of view, I think counters would be really
> useful.
> 
> Maybe at least increment the rx_dropped/rx_errors/etc counters from
> rtnl_link_stats on the netdevice?

Ok, will start with this and see how much work is to add the err 
counters right away.

Thanks for the hint!


-- 
Antonio Quartulli
OpenVPN Inc.

