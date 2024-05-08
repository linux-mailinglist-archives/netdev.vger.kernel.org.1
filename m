Return-Path: <netdev+bounces-94486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 897D08BF9DE
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 11:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 351962869C2
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 09:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328EE75809;
	Wed,  8 May 2024 09:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="WFSRSki7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3640E3613C
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 09:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715162134; cv=none; b=kp5JS3VMRM0b2b1LSpE2QR0jHpo/uEPhFWTlsMlZugkokS9vasWesV7RbcD/Ntq6MxrO9MKoo+xrQT3Ob841HO71lIhLQ1hiEvltM+zMWyrV8g1k/juxCerZfw2vj3dbzmr6Olj7J0FOhR54un/VBi1XcISDUG/xzTcDdvq/SqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715162134; c=relaxed/simple;
	bh=dpEswMO9HUZpINXmS7RmuQ6wUrgcoKUwhzHVnyIgajk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a5tW/qLEith8yWMhVNsMf0ygvEunNTsAbH6tAAHtojnlTEzINIBZwQ7WX/iSibwg+PcAkMo5JPBE8AAMzD0LlxnImP1DSbu+EjsUcmQyp450fjvg2eSRQAFMUUdMBC/8gDKbjlLbIv1Xfk3krHzcdC2yiur+2B0notpkdgAKMZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=WFSRSki7; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41ba1ba55ffso3622285e9.1
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 02:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1715162130; x=1715766930; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yvXgET1wgRHDc11L6z5SMr8ojj2lOqF4QLVoaZK+Ky0=;
        b=WFSRSki7WaJB/p0xXoIPCrJIeVi8emQU7LjMZ0KcDK8fkzj99fMby2DzG8jYVCw/S0
         h1mch+HelR1ugo5zcSGY97FlwHLQXvln95hw8K+uBnnHe+S+MuDDyuHmFSeVVREOiRsR
         B4EtX9t4OdwSwryN8OMjw4KOfnuqYjMk6//h1GRa0adoGHI8r+y1WYJ3KRq5TPhFwB8x
         KOhdZOnDMuTQqX30mGh1o8DStq19EyNdmVW6U6mgiNElOK87clRJn5HDBQyKy7fMMYat
         M2OTwZFzGj8g5Hc/mflH1EZ0Kz8HSFnS2xOM+SoyNhS/N2USZwnCxleQtPQAe85VGvbT
         zNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715162130; x=1715766930;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvXgET1wgRHDc11L6z5SMr8ojj2lOqF4QLVoaZK+Ky0=;
        b=B2XrEbinLm/983NQpiAQgcryHZgQ0ZUgBwu81nwlyKE6XyTI3KmHgnzX6hIYuMW7HX
         QjTQQxQU8RW3RHa6SFAOJFzMKp+50Um7+9Pj2zlRAJLnGItS0Cw2obKusO1rrFvfXOsB
         IRB50g5MPt/jD/34hVon1oOPPG3x9gumYnnV/bgeWYt87s/2P5oZde+YEG6ZeENSpdRn
         B9XZAFhgXRvk4GqLVQtTX8i9EP4AVkP1NiK3x7vBTZjy6rSx4zNKDbI1GW5qBxIDItDH
         qArtAyZbOfKuAeGv0iyl5SW48GPZLesNVOKdpc2rLgM3Zd0geyJhBjTmOF7ZikdaDKqa
         vC9A==
X-Gm-Message-State: AOJu0Yy4YebSB+kqten7J6/jVjUs9tvcZNMAWVS4B2FJSKimZV1MY5lh
	s2M7raMregQJBL4vaEOH6SfB2FoSoxAtMaPpsZdBwJwDqAPtFhJLBImhzYHWzZU=
X-Google-Smtp-Source: AGHT+IFPYbCbxxMnDin61IlsyuUXmhKPBD+oNyo9ModbezVKcwPi0WL/05wpbUD+dKf6QuKAY1JLmA==
X-Received: by 2002:a05:600c:3c90:b0:418:c6a:1765 with SMTP id 5b1f17b1804b1-41f2da2d398mr45028905e9.16.1715162130535;
        Wed, 08 May 2024 02:55:30 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:9ca5:af56:50eb:bcf3? ([2001:67c:2fbc:0:9ca5:af56:50eb:bcf3])
        by smtp.gmail.com with ESMTPSA id je1-20020a05600c1f8100b00418a9961c47sm1696896wmb.47.2024.05.08.02.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 02:55:29 -0700 (PDT)
Message-ID: <239cdb0d-507f-4cf0-87a1-69ca6429d254@openvpn.net>
Date: Wed, 8 May 2024 11:56:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 00/24] Introducing OpenVPN Data Channel
 Offload
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240507164812.3ac8c7b5@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20240507164812.3ac8c7b5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/05/2024 01:48, Jakub Kicinski wrote:
> On Mon,  6 May 2024 03:16:13 +0200 Antonio Quartulli wrote:
>> I am finally back with version 3 of the ovpn patchset.
>> It took a while to address all comments I have received on v2, but I
>> am happy to say that I addressed 99% of the feedback I collected.
> 
> Nice, one more check / warning that pops up is missing kdoc.
> W=1 build only catches kdoc problems in C sources, for headers
> try running something like:
> 
> ./scripts/kernel-doc -none -Wall $new_files

I see there is one warning to fix due to a typ0 (eventS_wq vs event_wq), 
but I also get more warnings like this:

drivers/net/ovpn/peer.h:119: warning: Function parameter or struct 
member 'vpn_addrs' not described in 'ovpn_peer'

However vpn_addrs is an anonymous struct within struct ovpn_peer.
I have already documented all its members using the form:

@vpn_addrs.ipv4
@vpn_addrs.ipv6

Am I expected to document the vpn_addrs as well?
Or is this a false positive?

Regards,



-- 
Antonio Quartulli
OpenVPN Inc.

