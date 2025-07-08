Return-Path: <netdev+bounces-205120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA4CAFD73A
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 21:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4431890B8A
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 19:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEB922126C;
	Tue,  8 Jul 2025 19:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="Nk96xAik"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7687221FF5F
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 19:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003618; cv=none; b=Z6zT/1L+4e9im1nBrZlml8nqbXMBG0c6RRQ1QjvgYtrwfUucdm79eGOTluOf44vtTGhXOMe4z4I9d36OTSSJnsb+FpdPHl5zLiBnwDIOByqLpDFRTyxFGyHOFiVj/R8Wl65mTCO0jwetIECXHWeVqhx8Gp2gMtqv3bobAyhBZcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003618; c=relaxed/simple;
	bh=HW19Gj00ljXfCX0psK9slnsYqhk6OgQsG54bKg7zn3c=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Jw9Oy/vA1N0SP3ljyS4XGDGpENLOU3/KfUgk4/0hAFB2sacytCTkhj2DxN76mrZZO/Xa22EE0r7EP6AiFA3MZ8RAhYJLz2V2bC034xynbF6VsI3rmJSCF9BW3qNI7EV4RvDryWN3ulDVEQ4s//roVqa+onm/KuovwiEtAC6nTAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=Nk96xAik; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae36e88a5daso938991066b.1
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 12:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1752003613; x=1752608413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jAfF6IjOYMAuFNwRXlzrzjjBqCz1ifTxiLxLA+WYDxk=;
        b=Nk96xAikC1tcrxGWnyToinsWlMa8mUbmZEDjN9d72BCPcIWjXoX3UVgCHr1vrUrrWd
         pYmqS+9Gf4m6yUrLYDBa0V+iYonizdYLZZrczBruRRYKHbji2P79itRjnegjoGpxR81u
         +KWVf0NpxaR/npcfQbelxJEPpb6f+Lj3UV4MHt+8KE28b8NoaU0wvSg5pXgK9etUUoIy
         4oMe4d3uEz8wJuMmezL4oKRq5iTIp9hekQ0c/XiRD3n6+m15YR6/aaOJTE+JsflpQIZj
         XoRPMY4kSOi+obMx1XAGFwBd1uhibQbYxyCV/J1BfJSDBb4j2OlZPPWOocaiPvjRoC85
         gWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752003613; x=1752608413;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jAfF6IjOYMAuFNwRXlzrzjjBqCz1ifTxiLxLA+WYDxk=;
        b=bRZTXp/FItnNTXdWSzcL2vSRL1sQAAGguu1CReDDdKDmzYyJFEs3CipKRiWb4vB1kd
         yjxfGT6AgrVRoOnuWAjZvmcAMmPZJ0WWQsNDVQdKNQ+gcViKRTd38jLTknmDdGjE80FB
         uMwV5wF0VWd+EH0u5rsfewPxGAw4MvN8LoVzrGHeS5xBE5RdpTAeSp6HkTH6oeZELSUH
         8aZSuO9wjgFOfGfekUyfrNyPspzAzg2xjyvYHfQuS8PnnvUS0A3G4DnRe0OkHT5CRvm8
         1YVTsxmnpMwFZNybMoBivcZXs+ES/j8ePKPQJPavcBTimdkEwSLb1PgYdBOLZpT4s+op
         if0w==
X-Forwarded-Encrypted: i=1; AJvYcCWPkGbogVzjJMl08i/VQ8rnDQqMe7/+VWcY5LNIRjmfZijPgWsBc51vKZQiYDXHt2NTQkbQjGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiN2ihOyQWAVTiFI1R4ji5pumlDFJ4Swt7U9FuimDAeiCTwCJ4
	odAC7nXXZXW/ElrtcvH8N9nAiY/9PX8hx2qbAZz8ZTjfQ+KPROCc2MRjI5YgCSMj0g==
X-Gm-Gg: ASbGnctbKAXI4g5beUmR7Q3GGwXzOsCGRGDbzmiX0Bub3Iy2kCAqHJCr5kqAPAowPhl
	2pI+8tzBlGX7pRQEHehbJ5vrHfH44jMUYfc7xe3m4pVdaja5MhlZG/mPDQ8kl0b3+uh4uvOMGIN
	xf+iHfRRSCVDY6htQ/TtFeehHZsb/GDfJdSN6mjDfogm2Y8DpHT0HkKV7wapxtFatPa18u4l3kg
	nEVh4lF1H+DW6oa7fMBK+Y/V9hrQuMClOIs6t4Vp1sC1xm7hwhcQBTM1sDMvP1crMEbKHyyg1Ij
	PRLgIYgJaUwbPEWaMLPi1rKcChP8t5JKNKewAFe7/OYo72ZiBiAuZZFjFQdD
X-Google-Smtp-Source: AGHT+IFFBksIRUKOd2HpO6z3IuGzi5/sf0uWTh1t4WBmlfBEqsrb0o0vxjcCW/dKCu2uAqDVrz+t9Q==
X-Received: by 2002:a17:907:1b1c:b0:ae0:d903:2bc1 with SMTP id a640c23a62f3a-ae3fbe32085mr1884498466b.49.1752003613463;
        Tue, 08 Jul 2025 12:40:13 -0700 (PDT)
Received: from [10.2.1.101] ([194.53.194.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae410e26785sm722615766b.17.2025.07.08.12.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 12:40:13 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <522a1e9d-0453-447b-b541-86b76fa245bd@jacekk.info>
Date: Tue, 8 Jul 2025 21:40:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v2 1/5] e1000: drop unnecessary constant casts to
 u16
To: Simon Horman <horms@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <b4ee0893-6e57-471d-90f4-fe2a7c0a2ada@jacekk.info>
 <e199da76-00d0-43d3-8f61-f433bc0352ad@jacekk.info>
 <20250708190635.GW452973@horms.kernel.org>
Content-Language: en-US
In-Reply-To: <20250708190635.GW452973@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> -		if ((old_vid != (u16)E1000_MNG_VLAN_NONE) &&
>> +		if ((old_vid != E1000_MNG_VLAN_NONE) &&
>
> Ditto.
>
> But more importantly, both Clang 20.1.7 W=1 builds (or at any rate,
> builds with -Wtautological-constant-out-of-range-compare), and Smatch
> complain that the comparison above is now always true because
> E1000_MNG_VLAN_NONE is -1, while old_vid is unsigned.

You are right - I have missed that E1000_MNG_VLAN_NONE is negative.
Therefore (u16)E1000_MNG_VLAN_NONE has a side effect of causing a 
wraparound.

It's even more interesting that (inadvertently) I have not made a 
similar change in e1000e:

./drivers/net/ethernet/intel/e1000e/netdev.c:
if (adapter->mng_vlan_id != (u16)E1000_MNG_VLAN_NONE) {


> Perhaps E1000_MNG_VLAN_NONE should be updated to be UINT16_MAX?

There's no UINT16_MAX in kernel as far as I know. I'd rather leave it as 
it was or, if you insist on further refactoring, use either one of:

#define E1000_MNG_VLAN_NONE (u16)(~((u16) 0))
mimick ACPI: #define ACPI_UINT16_MAX                 (u16)(~((u16) 0))

#define E1000_MNG_VLAN_NONE ((u16)-1)
move the cast into the constant

#define E1000_MNG_VLAN_NONE 0xFFFF
use ready-made value

(parentheses left only due to the constant being "(-1)" and not "-1").

-- 
Best regards,
   Jacek Kowalski

