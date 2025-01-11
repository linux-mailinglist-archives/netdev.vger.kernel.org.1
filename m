Return-Path: <netdev+bounces-157449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27502A0A52F
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 19:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22F173A40C6
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 18:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6D01B4250;
	Sat, 11 Jan 2025 18:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ldd0Lz1I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC36153803;
	Sat, 11 Jan 2025 18:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736618800; cv=none; b=rPFGr6apBIqJJvUePaBIMjyFgx0AJyMUalgidzYlszvL45o7t0S17FwVJhV/D/9sMDrMR36RjnbwBD86KLUXOyLKElGyzWOa4OlbUK+uTvDqQatiNUP3AIYPCeDHGByx7nBFoe7SoT25x8bv30CsEmn+lcx2j38Guh/ZbRdb1Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736618800; c=relaxed/simple;
	bh=kTQY1YxQKx42JgEq2w4FT4D0tVSnPuyxuGoDOeU9INs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jWJl9oOGgJ3gm64pfgpaJDTFpoNTTxowfcu997awGup5+DKKVxQAReYFYB4uW/HXWwzK6jf3uJCE7Bdz+U+fdEeOMZqyOP6WXLDGe0x2585aOWJhbh1k6i01nIRnLlws1p0wJ1f3q/Vuw7kzDuvlj0a+GqjOeHn4uv9hnYpXPqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ldd0Lz1I; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43690d4605dso21959895e9.0;
        Sat, 11 Jan 2025 10:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736618797; x=1737223597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rJeWGKjb49p0WeZYShgBVGJdiPImGZP8QXf3UpDVWfg=;
        b=Ldd0Lz1Ia/rLYf04Nr8jD2U3t+vIXbv24boDOchTY7F+Pz4OG+qqvSk9h0wcTX1/bL
         38U6IochfXYuUdwlcbUPx2pj3PB/kAxyg5pF53uOK4XESgcFyZxAAEl7lT10tx3W6zBA
         /psbi/Gd1wqwdhmGg9HKFVL9NZ3etBtWOaykaULZ0nac606UfjL5Tkd+dAE/ijew010q
         ldC8bqnkr0MiUrptxq8iO5snxzXGG4+kqyV7m7XY2UlLmcFymWeAKnqV2p6EYhClSmjA
         CUmm3odqXkYD2s3Msjr7/C8C2cNY1sReSAaEH5MFTE6tyrFTAkkp3Ls/JCKM0NWy/WDd
         2qTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736618797; x=1737223597;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJeWGKjb49p0WeZYShgBVGJdiPImGZP8QXf3UpDVWfg=;
        b=DaPUgdDPASQOfjO+nfdUHnZeJWsRSr5vT86UlqpchQXvb+Rlk5YNRIP3/ih0qyC5iN
         L5lOu4goWvnSkDV7SlI/x9QeW6YwKPor28el7i3e2Pj9h4SydtqFcACpLFsCOi/ZgKGe
         zxGXUHr0sw0a4imuOdVHWY3b/XgPLap1uhMr2eq5KuW0xEfzVW11OUQoiwNurEZkx1jJ
         2hCsNc849xqlSjce8hcMrz+NnnJ/WwxMXAyW1vkrsT0MNqwvZ6QbVqgML4Ltc2X78vBf
         69oeOASjn/q5eiMrg3TZ8P2kXma+1yUCi3iU6Evd6czP4jo1fyH4MIZaj21JmQjuwQxX
         6gdA==
X-Forwarded-Encrypted: i=1; AJvYcCU7PgLA9RhFvrrjQgcLPW2pg3PSU2Rgl7npZcBebgSBRqnVehBkP8ZGOpaIVA/sRmoXVM+2YdgY@vger.kernel.org, AJvYcCV6qrnChI8370t1Z/UGufSfzkNT80Cxd/d3SjztFx28w6CTQcDTzc0Z6Ul3gnwAYCE+bbKnDEb15qTwxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjiM1U/grzEiJcqhxm2J11A0Wb27T9M3+uymDMXe2Ks+0PP1Va
	NPEmQQczkPXnSFRsdF6Hgwnc7oz5kSFwD/c3BsblPa5oKxWIvgLw
X-Gm-Gg: ASbGnctScfEly3qlmO7f/Sa52FBBLNi27IwWR/WGGIQHqbmOQCX7d7nFALsT/FvWZxu
	pqD5YfxO26u3PKqkY+kRRBiBBlB/bmFqf8Sg1yDLUYyOna7/8g/2VEiPo1lDS02XMFPGUNj26Kn
	yalXmCeAvF1xZSNq5VUn33fDjPiLA/1Jv9dLZJUTBuEgEWaP/ZwX08jndYsOAwwN48scsI3jFZu
	dhkP5/inMUgdAaJIOB0tXSbqQ+N1B/Sr2ciw3+rsuvd6ASUCEzxYoUPR+XCuiFiELymlil7jh12
	R4UTJlOJ3FroDdx6qCvbN+YP+S9hFlM4avRK0L/Vu3gnxIs0TRtHzCoZ5RoLn3M+T8yjDmVw76O
	YFtiXUr24PjUqI/dYA3afK8NBWjbKJgQqb860hA//E6PiRB5p
X-Google-Smtp-Source: AGHT+IFpdZHe9ob7vXRoPC5BYJzRe00VNnrZDXdrmvs0q5OYvRunHrL4szaQ90GZPweWuHubuy+lMg==
X-Received: by 2002:a05:6000:1acc:b0:385:db39:2cf with SMTP id ffacd0b85a97d-38a872c943fmr12515774f8f.12.1736618797574;
        Sat, 11 Jan 2025 10:06:37 -0800 (PST)
Received: from ?IPV6:2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd? (dynamic-2a02-3100-a90d-e100-d8f1-2ffc-4f48-89fd.310.pool.telefonica.de. [2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-436ed48f4b2sm75881935e9.24.2025.01.11.10.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 10:06:36 -0800 (PST)
Message-ID: <e103582e-b627-4499-8aa8-db24dbb9daee@gmail.com>
Date: Sat, 11 Jan 2025 19:06:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: phy: realtek: add hwmon support for
 temp sensor on RTL822x
To: Andrew Lunn <andrew@lunn.ch>
Cc: Guenter Roeck <linux@roeck-us.net>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 Jean Delvare <jdelvare@suse.com>
References: <3e2784e3-4670-4d54-932f-b25440747b65@gmail.com>
 <dbfeb139-808f-4345-afe8-830b7f4da26a@gmail.com>
 <8d052f8f-d539-45ba-ba21-0a459057f313@lunn.ch>
 <a0ddf522-e4d0-47c9-b4c0-9fc127c74f11@gmail.com>
 <0adfb0e4-72b2-48c1-bf65-da75213a5f18@lunn.ch>
 <e8bd6c18-1c71-49b0-a513-e38bacac90e7@gmail.com>
 <eaa27d71-2532-4060-8d6d-db0c76d16876@lunn.ch>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <eaa27d71-2532-4060-8d6d-db0c76d16876@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11.01.2025 18:44, Andrew Lunn wrote:
>> On my system the over-temp threshold set by the BIOS (?) is 120°C.
>> Even w/o heat sink I can hardly imagine that this threshold is ever
>> reached.
> 
> So this is to some extent a theoretical problem, in your setup. So i
> would not spend too much time on it.
> 
Yes, I think I'll omit the alarm feature and just expose current
temperature and over-temp threshold.

> 	Andrew

Heiner

