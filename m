Return-Path: <netdev+bounces-236716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2369C3F4CD
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 11:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26E1E188C580
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 10:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7599302768;
	Fri,  7 Nov 2025 10:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="fPL4W9M9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A622302153
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 10:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762509734; cv=none; b=gSAqG2qtTQURcqvXJBt1OqSPMivHfdtlfM5k06CEJY/a3e/9w41DuaCezPMHJ37EENGAKgvu7SH/FFjWEKcYaffhL2P5xj6RhzOyEaMQ9Xl8CEo5JnkpH3Xqki2S30FqV9BLjsZhhIPVuwUK8qbG36uUi4umA/LJ9KQxxSzRhho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762509734; c=relaxed/simple;
	bh=JJGs4zIda6s1YsKiNN6VSjbE0TevdnhAVZj4houk4zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ty7VX5dhLUH8Bdk9g5teD+M08lVm+uwgVRyJO8/GiT/GwvBPzYidw68PKXUnhJeSKj/BGH76nQn6zD99dAYyuzGfkkal1UNRo//OYAeClhZ8g0FPoNi6aLBYnCwn+f6Z7/WHrAD9gcMyDYwbXqQ1tkpt1hqrmOXvF+QHSq5zjy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=fPL4W9M9; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-640b06fa959so1028119a12.3
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 02:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1762509728; x=1763114528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sI3AaX9grHbjP5KjZYhTK6oQKUD2yVQSwBL3X3Q60WM=;
        b=fPL4W9M9YNIXN2+La4AF8emD2uG6M7TzB7mAg2wTgGhvckbXIXf6/8NJBdfPly1rM+
         a+q6hjcQn7G8Th/4D7HnLPIxv37Gf2Ty69LwmY2VXVnSWp8ZFJL90QhqfvgVnAWman7U
         fKkGaTfGbxG/7Eu6myq5wLxpQMFXsfplrsva4i8uXG6JWMFJIstyqlgP+ybUcNWiBkYy
         sEn1GAZgeGxDr02ZaN05DTORM6HIpHjKc3Efe9fteq80TzkRDBnQ4C5l4C1ZUNtj45QO
         ijtHpiWb6+h5I9zDa3OcEJ1WTiwr/z3oK7JV5QUAWvgwRLwdYYgB1QNiV0XPHJhgFW51
         DxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762509728; x=1763114528;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sI3AaX9grHbjP5KjZYhTK6oQKUD2yVQSwBL3X3Q60WM=;
        b=DmW/R7qltOKQUvfVdkidtNIKQtrTHfJGTkNsNKogh0b7IeXm+eIqkMNhB8XFxl5CX1
         dPNUQiIlctqYLJHDUchU6yswBYfyL3fg2YRKOoYXFUH98E4hmP9q2W4xcRt2s4YW3mjJ
         815msH2IlImH5jHpYyldeCpmdzR1KEXkNlNxK9htNWlVVcxUj5lfncpMc1Uk41VuA8SC
         2Kg0cHHgUeZ3sL+/TgZD24tTnhQaZp8pftWCobqqrTxqYCQEFfVupLnWoM3ReskLadlE
         ReN5qONru2hOh5wrIaoQksGEW32i5n7PYMqISf9K7zpZBnnJJq0e750RgxOGf9JTrsia
         WsDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg89qqQB1H7QlgPpI/V4cg9qQ/3jyLgAdHEdlDskTsAkGZJvr5HXubn5ipKGqF92qSbBIBp0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Lx4rKJc4K6XaBMm8fI8Ad4AUtsXgJGdB4lNsVgBBh0QIeZ9n
	Mojg0DZ7nxj20yQa2FHcECe/17B4sVEctsjku8P95mbMlmdbVaHBBJP0DsUDX4Kdrog=
X-Gm-Gg: ASbGncvHTohB0J9h+2aGFSgfQRGP4VLWxKzBCqKDuopZyMk/FJeocWEjfIHUPob8sua
	oGFp+3UrVBpcXXJHWCnzVRcWyG6xS0efQyPo/5GTNJ8ztZcRbCRYA7XyFahmGOk5jUDXa+0abzm
	aZzs8uGIfrbpflnvukCTvg3P5Eco7WmV6kPQfkTUVa3HkmDGQYDH0epfs+jEerIywVpOg2oA8Vt
	T1MBWiWpgnmydMxUESAkB3Bf/5oyJ+5C5acdqEsk8Pm9C5RBgCToJzW53xbTHHLVGQNvmWFnQZp
	64KA7fioE/uWyNFySYEM1xmJTaOvu5NUvuEF8f3PN/pf8VwrPdaA3uYmoW6z/gnjv7Gx0LmH0Ed
	C36Ihjo3faapae0W8Zx938iQ88wY293L3/MkmUKmMhC8nblkFkvthq6c8/XB9NMcPdGQHHzLabs
	k489zSHLBKNrd+pV2O0ym1RgzyHzs2BfrS4n5L
X-Google-Smtp-Source: AGHT+IHlT54Zkq9G78xurNR3OQ80FwPe+AHLLB41tVK7/67rPq4iDsWAMcHtSavKQD8aOgkIUNYv2g==
X-Received: by 2002:a05:6402:40d1:b0:640:b1cf:f800 with SMTP id 4fb4d7f45d1cf-6413f059b97mr2381350a12.4.1762509728210;
        Fri, 07 Nov 2025 02:02:08 -0800 (PST)
Received: from ?IPV6:2a02:810a:b98:a000::4e88? ([2a02:810a:b98:a000::4e88])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f8575eesm3693449a12.22.2025.11.07.02.02.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 02:02:07 -0800 (PST)
Message-ID: <03012c3b-ae9d-4591-8ac5-8cf302b794a5@cogentembedded.com>
Date: Fri, 7 Nov 2025 11:02:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 09/10] net: renesas: rswitch: add simple l3
 routing
To: Andrew Lunn <andrew@lunn.ch>, Michael Dege <michael.dege@renesas.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
 Paul Barker <paul@pbarker.dev>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, netdev@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <20251106-add_l3_routing-v1-0-dcbb8368ca54@renesas.com>
 <20251106-add_l3_routing-v1-9-dcbb8368ca54@renesas.com>
 <06213fb1-12dc-4045-803e-d2a65c7e9fc6@lunn.ch>
Content-Language: en-US, ru-RU
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <06213fb1-12dc-4045-803e-d2a65c7e9fc6@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> +static bool rmon_ipv4_dst_offload_hw_op(struct rswitch_route_monitor *rmon,
>> +					struct rmon_ipv4_dst_offload *offload,
>> +					u8 frame_type, bool install)
> 
> Why all this bool functions? Especially when you have calls returning
> error codes you are throwing away.

The original idea behind that was - this is "not success" from an optional optimization step, that is 
not exposed outside. If it fails to offload - then the stream will remain handled by software.


But, there is a more interesting question about this patchset (that actually stopped me from submitting 
it when it was originally developed).

What do people thing about the entire approach used to detect streams to offload?

The situation is:
- hardware is capable of doing L3 routing, with some (limited) packet update capabilities - rewrite DST 
MAC, decrease TTL,
- there is interest to use that, because software L3 routing even at 1Gbps consumes significant CPU 
load, and for 5Gbps will likely not keep the speed at all (we did not have hw to try),
- but - given the capabilities of hw are incomparably weaker than capabilities of linux networking, 
which approach to take to detect streams for offloading?

Second question - how exactly to get the routing decision from the kernel stack, to apply it in 
hardware? I was not able to find any existing implementations of something similar...

What the patchset actually implements is - maintains it's own shadow structures for (subset of) routing 
information, and generate offload rules based on that. This is definitely not elegant (because the same 
kernel where this code runs maintains full-scale routing structures).  Also this is definitely breaking 
any complex cases - actually anything more complex than simple destination mask based routing.

I was going to post this approach as RFC at some point, raising all these questions...  but 
unfortunately I did not have a resource to complete that :(

Nikita

