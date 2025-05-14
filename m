Return-Path: <netdev+bounces-190462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39502AB6DC7
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 16:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E143AE6FA
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 14:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FB413DBB1;
	Wed, 14 May 2025 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="K9LLRaXg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8109D70838
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 14:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747231346; cv=none; b=nkoiNLsPqegPpmpxXuEt0iL/3zofKa0wzOripYmVxQbBkG+YwDR6ZlKASDnleBGSPuDloQ7Lae/bmEFhTu1L1afwKE9X5AW2pFIQ/03R90nRWvqhftrI+mVyyl1Srb3oGywT1PYn+rpYHJ0RQCkTjrB7Um2w2HRSC1ZRgV3Ltg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747231346; c=relaxed/simple;
	bh=ZLYx2KgjIpxbUCsHOroamaAsHkSh0bmq90hNIY4g2RQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LN5e3EnYnIeqD08IxGwWufQt2IHf5qNs4axiDR5Ylcf0KVuqOBqnWwsrDEfFVotqJ/IXT93f2I+CUgQIdwgVhwPfIY9w5evp2LrBGaEfID7uqFV7DQE91smZ/7ttUO9/YAFOG4NeDKw91+iAuCtxdsTyXJFQGdNXT3WKL9k7kUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=K9LLRaXg; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54d3ee30af1so7470071e87.0
        for <netdev@vger.kernel.org>; Wed, 14 May 2025 07:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1747231342; x=1747836142; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Gkwo6x7AbcziSYyeKFrBoM5H+hTAGKKuhXz2NAg3gZ0=;
        b=K9LLRaXgbbYAp9w2ymXarFy6AS3Z8Hj+L2iLv7zu0yw2Ic7Ep4zI5qsQfaws3YgPnq
         NkpIRtmhnWJw8h6jTLBh9dhgFzYnE4q1Sggy0fP+WCaPlxY1nQdpAAAU2q2suKKMZYdd
         Jr3Hg9QbzsUeEZ4KBA62+yTpwWXZ4NYaZ1i9DD2/BsMqiaBr4haommYYjz+yz9DW1MDy
         oBWedK43CgStkcstpdD1Z3bvO5wSnoqv882RJMm8GQiSXxJgybJ2rUurkBcnRdOxjIVT
         xkwsXneL286AKWh7O449wXpTwidXopcdeVbtgU64JR0nrM/la9CZZejEoFT7o/VDCR3A
         OtAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747231342; x=1747836142;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gkwo6x7AbcziSYyeKFrBoM5H+hTAGKKuhXz2NAg3gZ0=;
        b=iBF2Cd/a5Zjdfx+2wPgiX9JQJ4pTtfGzqvlJls4CdOOr5w8pkxHnArioOAoE3kV/9w
         llriETvIjJbX5pvytSNJsAJSrgbD3tukEP2cvL/s+1SCxMRfgPZvuV7dOwNOmnJrKsVU
         sL7DRIRuRxaVN18gvRIoGOXvRIXWeA0WwsnS6VbPIfkyAQeivwjZ4hlYdWV4akCZxNzN
         1Y+/BViEBiGfF9uJPCvthCvMZhV3Vd62aF6lcpX4DnHxjQaxWbnwZhRqtqkeDUAkjd6M
         Dr2M0HZru6CbHYgezffPx53JzOEZ6oOoeGS8heHXTV6tFo7YE0YEMlT3QcnplUQwewbX
         zcfg==
X-Gm-Message-State: AOJu0YxRI9PLz96nSE1BRiEiuvlJVI/eGthX0ILmeNKcryUPZJlWeJRh
	b5/9vSdco4j9Loje6M2vI7d+DCLWNBN2YnhHGkHN3v+Rfavgc4Uew53SeTZBVGqJ5qDpNnaGx+b
	9+DhU5bROnOGsOt9jwriB14cJ62uVD6i8qKuJIYGDrasGZwE=
X-Gm-Gg: ASbGncuAj30h6Nv5gB0CYHTqsJm5eWeeZZJwtqvR8PUz7ykon4BCE1Z23Ou9E2Adsbn
	2eXvTKtaT1MMrliui1tdoWGukd3JUf5Ap+lGsCIT5omhHC9BWGdX4gPiJzymIs+epfBH9qsOqCZ
	bhDkC9+lHDSGw6b80y2TGTcyr/JFFPoc5wRvKFffWTJk53FeB+23GIEThRv3YTezOKR7X5KBSB0
	+3za2w/OMM5ZUSKgi2X3DJC55aiTovKFr3FbEpyu2RlzKdRg+k+UcF1Iu9Y22fEZ41mZfspbjGP
	fPTWlu75vYRi0MBiHKIK0u5JAq0dQI14Kr2ucuul6jbDj8guZQjnihh7fZEGDaZD3HjH7WKpK3r
	TTrQO8yKV28Zq0Q==
X-Google-Smtp-Source: AGHT+IHo2MwVA8VqW4tDrQaW0PEvDpy8nyYmPD56cE2FdV92P6+33k6O2yMEMRcLBoQeRuwkhDrCrA==
X-Received: by 2002:a05:6512:258b:b0:550:d4f3:84a0 with SMTP id 2adb3069b0e04-550d5fa50fdmr1458461e87.32.1747231341980;
        Wed, 14 May 2025 07:02:21 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:885b:396d:f436:2d38? ([2001:67c:2fbc:1:885b:396d:f436:2d38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f39e851bsm32378445e9.28.2025.05.14.07.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 07:02:21 -0700 (PDT)
Message-ID: <f74314d4-c5ab-4346-8dac-3ae8e97fb74a@openvpn.net>
Date: Wed, 14 May 2025 16:02:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ovpn: properly deconfigure UDP-tunnel
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Sabrina Dubroca <sd@queasysnail.net>,
 David Ahern <dsahern@kernel.org>
References: <20250514095842.12067-1-antonio@openvpn.net>
 <20250514065048.3c14a599@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20250514065048.3c14a599@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/05/2025 15:50, Jakub Kicinski wrote:
> On Wed, 14 May 2025 11:58:42 +0200 Antonio Quartulli wrote:
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +	if (READ_ONCE(sk->sk_family) == PF_INET6)
>> +		static_branch_dec(&udpv6_encap_needed_key);
> 
> udpv6_encap_needed_key is only exported for ipv6.ko
> I think you need to correct the export, because with IPV6=y
> and UDP_TUNNEL=m we get:
> 
> ERROR: modpost: "udpv6_encap_needed_key" [net/ipv4/udp_tunnel.ko] undefined!

Or define and export udpv6_encap_enable() which calls only the 
static_branch_dec()?
Basically the same as the current udpv6_encap_enable().

This way we don't need to touch the export for udpv6_encap_needed_key.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


