Return-Path: <netdev+bounces-178916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC33CA798F9
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 01:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4082188F806
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 23:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8F31F7075;
	Wed,  2 Apr 2025 23:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="BIrnec7i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EC11F5822
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 23:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743637074; cv=none; b=hed3iIVrb8e/kmnsQa7oOWJQgiIRQkaKnIPjHnBea7t7YKdR25aC+9P0xdLyo0nmJyIB5XZYmLrUqrBUj4todmq2PjQ6vnJ2U/IvPXTRIBBTWOIVNc4KK+zxxfQ22c674LpZAYvYnMHIzeADBM9TK7sdik+mEda9A3WipsWpzz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743637074; c=relaxed/simple;
	bh=ZZsMtMrosl1AIceTIQnLYdW9Uz2x9VViE3xqFN0/+yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t1JJfBmkZaTA1nICv/8do9zOGTIRMVG7YIX78c+ZLF/ezIf8QFpud0WVkH0ugeX5xcabskAlPMe19sG3OtC38pxLRmoJ6roHHnVVZeXtJEoEogtEEAG0oIRt/TUYRQu2IdFxdpI7Ck6cjQWDA8iWZi8g5+8XpdtUgBcwz6yKndc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=BIrnec7i; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso2255565e9.0
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 16:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1743637070; x=1744241870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W61q1y0gCFvlI6JDcXrPYkIT1lseWSl+GG45DZFG1F0=;
        b=BIrnec7i4s/pFDUfbhKhz4Dp1diJaKQYlR0HXwaZUpOwSyod2PjZmLRkRUqxj6xpeN
         IJZIZtHo86uqgYj9+K6H8gFurh9BMOutZ9L0nUtvhsYJfMskXD25YfOjqKpH18q8wZem
         Cud5g2zRwEfg7u0wFluXAg64DRY2ajLL7yTl91vF/Lo4CLPnpH3KFSp908aY0o0RWaRx
         nxh1gOKRpaQD0ckEeYRLvwG6DEL9Kcl3B5eb82W7iYeM6s1M461/sipKlRWlhN0VRsCj
         VUfDTT714EpbB5c8ylg9dwnJiFR1CHj77HBZI+trQqv8mA+p97HccXLQu9Tkxo/MK3yP
         a3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743637070; x=1744241870;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W61q1y0gCFvlI6JDcXrPYkIT1lseWSl+GG45DZFG1F0=;
        b=anIPOrfhN0p7ONelByJZK+k5lgS/W4Lcx9C9rBdLaGa4ivxn1EzCF6QXrqYQLZIpXg
         AKxLmd2k2GXygKsIE7tuTWDht2cv+9YyjHTQtIVD3+l/yLCRhs1dabbK00/280edlj77
         urmKQ/f9FmthyYbAiBbaR7tnH8NcHFOuEUdbRw/A2SwnZrHAvSZ75FEDQpL5dcaspvHs
         682lEoxF16+ol8lAEQzga2x5Xme0RlGirP+9i52t0Nb3SZiYac7V8gh2Yw4vEBUJ9UNU
         qzW0EN/nvZ2AIkLOoPNk+RMar8AstjrBIaSCR3Ou5rfDohUWCcbjzd8aR9KGIfapURUc
         YTSg==
X-Gm-Message-State: AOJu0Yzs+GgsmNuqO+MLJbifx/8GSSo/Fdmw2op/vXwp1nmy2uHN/qf/
	DjQnO4dnUL2BygOt36/tja4sz7E1CkhJh/C4nz4EVgeBtS6zi9MPjn/o2mv6SU0AyU9hvL82tjB
	SUWRHgpui3bzWEv6VZ4AhRxLC3JyzEPCD1OOPfcbIQ2cPFkM=
X-Gm-Gg: ASbGncumR6L5Lsuby+0vmbuvG2E13PuuC7efaJuD9rT4F0sxMqNm1HOyQh4ugkNC6BR
	MV9oH6GuIIs6UiGt8frUwOQasXRcXbK2Kx1kNjg9qnvmWHNCAbUin2+5yfxCmAbQpLyktFNWD37
	pypeIOYY25SMPQ3YbnLYTRUSTRpfIRZXi+tyOXrzdQm1bPCIEkGqqZZrk3ShnfJWRs+Wd4XfIdz
	1jCrIhAU5/eEVmYy/8YQYBeZB6Qgt+hXVSPG5Hbklfoy12Rbd829czBNSuzq/CYy7L+k2HU40oE
	HCq51uPH3GZM0INupJrkgFXvZF2cFzAuu6Qp5H+BpfGzLf0D/FXs5NDNAgrjn5YRDtDLdoQnrsf
	ljjfX
X-Google-Smtp-Source: AGHT+IGmXfUesLAV8RjVVzxO44B2DnEvoYBx2M268pdRUhUh4bUu5rXcCLR84zMgAaAcbxmfSkxDjw==
X-Received: by 2002:a05:600c:3b0a:b0:43d:16a0:d98d with SMTP id 5b1f17b1804b1-43ebef77ba7mr9564345e9.15.1743637070303;
        Wed, 02 Apr 2025 16:37:50 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:c56:43d3:d3c0:365d? ([2001:67c:2fbc:1:c56:43d3:d3c0:365d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec16602bbsm5264215e9.9.2025.04.02.16.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 16:37:49 -0700 (PDT)
Message-ID: <d997447e-8348-48ba-9c72-5deb7fdac8ff@openvpn.net>
Date: Thu, 3 Apr 2025 01:37:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v24 06/23] ovpn: introduce the ovpn_socket object
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
 willemdebruijn.kernel@gmail.com
References: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
 <20250318-b4-ovpn-v24-6-3ec4ab5c4a77@openvpn.net> <Z-vkl4NqfrkoJn-l@krikkit>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z-vkl4NqfrkoJn-l@krikkit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/04/2025 15:05, Sabrina Dubroca wrote:
> 2025-03-18, 02:40:41 +0100, Antonio Quartulli wrote:
>> +void ovpn_socket_release(struct ovpn_peer *peer)
>> +{
>> +	struct ovpn_socket *sock;
>> +
>> +	might_sleep();
>> +
>> +	/* release may be invoked after socket was detached */
>> +	rcu_read_lock();
>> +	sock = rcu_dereference_protected(peer->sock, true);
>> +	if (!sock) {
>> +		rcu_read_unlock();
>> +		return;
>> +	}
>> +	rcu_assign_pointer(peer->sock, NULL);
> 
> minor nit: that could be rcu_replace_pointer instead of rcu_deref + rcu_assign_pointer
> 
> (and I don't think the rcu_read_lock does much here)

Right - will fix this too.

Regards,

> 

-- 
Antonio Quartulli
OpenVPN Inc.


