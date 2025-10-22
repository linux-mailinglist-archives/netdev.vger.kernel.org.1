Return-Path: <netdev+bounces-231845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E8BBFDF1D
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 20:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 15B8D4E2DC0
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 18:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367C12EBB9B;
	Wed, 22 Oct 2025 18:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="PUBN45MA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C894C34D4F1
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 18:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761159397; cv=none; b=RosuqmU5BmbEQpv8aqHjP4k6qvtFx4naiosHoCHF7qK5AqO3O/+R6tyHlfeJfrqun+2T5WAawfxOIMpXo/hR+FP2OxxYz3xMKU4tB7dfUeGOPCQgOLcSzB//5ZU9I8WUpsHaEU5xoPiqaufF52kievLuPu9so8NMPhe0qVs6sYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761159397; c=relaxed/simple;
	bh=/RVtcH/u7iWfm2o9vgeKfQ7ivd+HQa0+OoDrKazmqnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oTksNA4aZdWkkuJPXTHAEc/86AOsxIiDjgPF79Q6tJGGopYhlJH5NqhAd5catNLqyO9lLs1bS5icJKDbxVZ6sfWBkSGXD8T94EbU07X5469AX1/69H66imrTnW+irZ5g+LRXVOjdq60zlTZyHLHIqetcl30q64wTzI3icPgHnOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=PUBN45MA; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b6d2f5c0e8eso333127166b.3
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 11:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1761159393; x=1761764193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ldVYHaLpW+euOSC9ObMmwQbYCKGkzzAB2Gt5PKa8Qog=;
        b=PUBN45MAPwbCbpa1va0T11UJyXUrJJ+wS8vaS1QftKRZZmNzv+KB2hTSEobP0Jzgis
         N1txbUwAYQwAjiSRHxgGh/Zc57b3LW7B0bQ03uqLSz3HEEbSlz85qMlf7nkuUgPP5HDg
         zcsxMIJIkEwBYelVqEsHdff+nwpA+snV4L3rd1V3EF7FmGKJD4CUSVQJN9KxAofe8wGG
         zhuiYp3/YfZ/p2V/Zge8UIII/TzBQMggy88xz9D7aI6g9PPEMf83Szr2iRAWuaADin3E
         6ERXj/1MjC+fBIni6C2QVSYFEr+0PRebwZ1v16o64eMPZ/UO6VXGR4jWGwnKP3ObYHcM
         Ttqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761159393; x=1761764193;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldVYHaLpW+euOSC9ObMmwQbYCKGkzzAB2Gt5PKa8Qog=;
        b=aaVpCCkIgmGkiyQHs+9l/3VcOjUZwtXKhzXcII+eTD76np2zSIYPok8iLbYCpTU9Zx
         02UD/h1MxE2NOFABi3DXBOJjgdulLMESG1HXvkonXGMfsK2WaIEKwQEKRFZsaJjriGdc
         RcQ69e2Gx6Gz6m4bZ7kkU0fSnqS4vg2NM+yMh4DvMf6Ss6sPQ2+YNG4KVCyzbaJgDoHE
         ps7lSrAhQ9a5I3wpnq8rhfxxolKTd6az4d4CEevziYs1hgwpd9jsDaISahGbRI06XDrk
         Jbd036SDbSSpgNd+4Z6FCyII9FiYKMEcdwEMGD/OE+92vHNlebhQ0GzkUX2RAu5vRCkM
         UZBg==
X-Forwarded-Encrypted: i=1; AJvYcCUTdgEK7uYlt7H87ThueWsg5oSoj2EdiMWcvewj1vnBONiAK5wXzkpAD5Q3TglAOh/NfS66gfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFsoeI6p3JBfnuV84MEw0VjfGs2Ybn1AjOjfngK6MafvfX0xYo
	YNWqh99ZMTLvrp7jz70O6hflL5gGokhiNhbUJGZZLPeG5fUIVB7HwYEyajmtdlfUVUslFe25YEU
	rKS9s9TwulMps7Dqba2Qq0Ibyr4yKN+cl8DNB4iNgMtdEzbSsnAk=
X-Gm-Gg: ASbGncsUYnYy14Z2GEZvmu7/DM9wdOr5TBF5JHPpV/c/w74KTtfgyyypjYvYSBg4XVf
	XB8pA3TpFnpmcAWr8MZwyRh1fi3eaqm084k1r/NGTosuY+TB0NtXblUAYyLZsTliKcMvGC3+4Ac
	PnQ7ubPugWStLDQ2odnsfH6yDz6Ru8lG/Me5Tpy1KtM0vfKwwf2UMWyoh208nlO6kbBZ2HU8Vws
	63tBs+vIOSI9/KrgJ8fGA1DZvg3miEsqBL6bQyvn2uUBLqvPP5W/FTjT17tvQB58ivSWskBQNTv
	LchT9izk4n76i62dlbGZq9czIO6KQLkLR33+aWzR/kN67rooIshSdPKC92SoU2GYvdsSJQ3VbsB
	nifAPTFNWgmzKQGbh32zfy6JCFm3F0HiK1cA+VhEH4Hoj471CnkejuUQ88dyvDvyryugTpQ3p/w
	0ZoT5k26isvkfodOsxTqXCa6K1bPUr3i/D3jtsKKM=
X-Google-Smtp-Source: AGHT+IFoaZWW0RUuXchQuLGszdhX8rQoRFFhk2svxVmhQUlsTL2tJ4y4vLuUdq4Q+Z/mDzYu1Nxcvw==
X-Received: by 2002:a17:906:2615:b0:b64:76fc:ea5c with SMTP id a640c23a62f3a-b6476fceab3mr1803858866b.52.1761159393009;
        Wed, 22 Oct 2025 11:56:33 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:df21:10eb:f32f:be16? ([2001:67c:2fbc:1:df21:10eb:f32f:be16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb525f48sm1407863566b.60.2025.10.22.11.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 11:56:32 -0700 (PDT)
Message-ID: <7333eeaf-e28a-45c3-802e-bde9717c8b0d@openvpn.net>
Date: Wed, 22 Oct 2025 20:56:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/3] net: datagram: introduce datagram_poll_queue
 for custom receive queues
To: Ralf Lici <ralf@mandelbit.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Mina Almasry <almasrymina@google.com>, Eric Biggers <ebiggers@google.com>,
 Sabrina Dubroca <sd@queasysnail.net>
References: <20251021100942.195010-1-ralf@mandelbit.com>
 <20251021100942.195010-2-ralf@mandelbit.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20251021100942.195010-2-ralf@mandelbit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/10/2025 12:09, Ralf Lici wrote:
> Some protocols using TCP encapsulation (e.g., espintcp, openvpn) deliver
> userspace-bound packets through a custom skb queue rather than the
> standard sk_receive_queue.
> 
> Introduce datagram_poll_queue that accepts an explicit receive queue,
> and convert datagram_poll into a wrapper around datagram_poll_queue.
> This allows protocols with custom skb queues to reuse the core polling
> logic without relying on sk_receive_queue.
> 
> Cc: Sabrina Dubroca <sd@queasysnail.net>
> Cc: Antonio Quartulli <antonio@openvpn.net>
> Signed-off-by: Ralf Lici <ralf@mandelbit.com>

Reviewed-by: Antonio Quartulli <antonio@openvpn.net>


-- 
Antonio Quartulli
OpenVPN Inc.


