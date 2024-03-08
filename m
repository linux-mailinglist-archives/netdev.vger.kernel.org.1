Return-Path: <netdev+bounces-78771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8812876647
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 15:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 085821C2093C
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 14:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9C1381C1;
	Fri,  8 Mar 2024 14:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="bpPfrAAk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B161256776
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709907676; cv=none; b=TdsG3h7JrHCwZw0lYvmf1I/wgdOyNfn/AaprMuZK+FrurYPRISgk4sNcjU2Q09bFHjHMjk5DsQycBQW9QQJDO9OQIQVWosb7yRVEfM8y8WlnlqrIiOB51B9zvd2KnewsumatQLta8htqSVXwrT+pRrUj4O6PeWXZUeQYqoP3gEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709907676; c=relaxed/simple;
	bh=IK9dhNpeG0AySVOKRbfjFfdEGa1vvginqoEB6dibqrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFDOQ42XPYqrqF6Xdku3Gw+6EzUI7kTdzFBVhGjAAV9MqYmudxVi309nkJIYVzmlmv9L7O+A4q0dRLqL3ry1eXs+RUTgmV7V7pWsclKs5f8sUvYBUZMm5kGCKOQ+VeW0M0L6b34Z31hum5r6mfoIrDiKhoxdyJ7thu8N53Aofck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=bpPfrAAk; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-567bac94719so1045765a12.0
        for <netdev@vger.kernel.org>; Fri, 08 Mar 2024 06:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709907672; x=1710512472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=obA/GMCLbo9wmMiWEpAG43SHG6n3I/JJRFJsaAcmuV8=;
        b=bpPfrAAkd58VA2HnYb2FNm1woBM9n+VMWWlJxhaz1Vd8qPaK0g1uxGZWui857M2Pt0
         mnjYj74RkqnUOsT/LAGyOZE37rEocUVcR4u8mU1mCFuRKUD/BgVEbptNbyfa4gNbM/ct
         qkeF37X7A/rv+ed4olQbXnLj3m4Gy09EcOsZ1bobMOekAYjKvmM4aMmjtu99nc1rn5Q+
         hzS+JDWFhAztilT8ZEWZRaG2uRQvRsf9nwO6a6AIASqX9m4aC1DEqF4QVLPShWn/04ZJ
         O2cUK1VUQaYPujITLFf/EmzktBQNts7w+isnDH6X6n0ovrho5R5qSPEzOUYqix7z0yrH
         4TJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709907672; x=1710512472;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obA/GMCLbo9wmMiWEpAG43SHG6n3I/JJRFJsaAcmuV8=;
        b=Q9xQgrfG+erTRs0PvYJ9JHAvIIzlkH8bGWzI5E0uSgPli/mDpcT9IstIIM8/ZGn8pK
         9CKqAKGnMUyXRfhY/keOHtOEcLbMdvvB+lD0mPqZyvDG0WONVpRxZMKe5agfTqqgQ9qq
         jfV5EwExmXDmWQnQY7NZYIMBkpv4u40JGTpgP/q3N7vXtsT/c3Ugsl1F/FOQVLxhOHOB
         KPnfgulOciLDwsGmtUqvdcolEAyZJK0IvZEIpbHM/7S+3kSBT1PK6UOACtesrMc/sBmq
         LFBkuzneDONhMqC2b47+SWZIU/eD0L/O0cx/FPIEqa2FMmd/PmKqX7+pYDk/HdHXqo7L
         +C8g==
X-Gm-Message-State: AOJu0Yz3X5gL0zJy5c/homtxD6r0KRWSxRmbWoCQYwdSnb7HLJxF4b/J
	8Iyi9e6PleBu9KbTo7XXsP4wlN7hQoVIb2A/Q9egYzIoKmDuqb16ef/sGv5Sz48=
X-Google-Smtp-Source: AGHT+IEI1bS5xFEB8VmY16Q9XF8XdySY/WIL/x+8Q7dBuA/7hSADChm00ymo1SGJUeJ6vQQ4iHFj/w==
X-Received: by 2002:a50:d6de:0:b0:566:b4e0:9aaf with SMTP id l30-20020a50d6de000000b00566b4e09aafmr2168638edj.29.1709907671997;
        Fri, 08 Mar 2024 06:21:11 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:0:b873:e280:4c85:26d8? ([2001:67c:2fbc:0:b873:e280:4c85:26d8])
        by smtp.gmail.com with ESMTPSA id ds9-20020a0564021cc900b00567f39a8b55sm2758230edb.39.2024.03.08.06.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 06:21:11 -0800 (PST)
Message-ID: <242383f1-a177-4f58-9e62-8465609b99b7@openvpn.net>
Date: Fri, 8 Mar 2024 15:21:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 04/22] ovpn: add basic interface
 creation/destruction/management routines
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-5-antonio@openvpn.net>
 <e89be898-bcbd-41f9-aaae-037e6f88069e@lunn.ch>
 <48188b78-9238-44cc-ab2f-efdddad90066@openvpn.net>
 <540ab521-5dab-44fa-b6b4-2114e376cbfa@lunn.ch>
 <a9341fa0-bca0-4764-b272-9691ad84b9f2@openvpn.net>
 <b3499947-f4b6-4974-9cc4-b2ff98fa20fc@lunn.ch>
 <d896bbd8-2709-4834-a637-f982fc51fc57@openvpn.net>
 <b1b50cad-30dd-4002-8950-0869d636b6a7@lunn.ch>
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <b1b50cad-30dd-4002-8950-0869d636b6a7@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/03/2024 14:13, Andrew Lunn wrote:
> You already have more patches than recommended for a series, but... I
> suggest you make the carrier_on in probe() a patch of its own with a
> good commit message based on the above. We then have a clear
> explanation in git why the carrier is always on.

ACK. will do.

Thanks for the recommendation.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.

