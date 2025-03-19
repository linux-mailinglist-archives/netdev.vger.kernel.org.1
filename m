Return-Path: <netdev+bounces-176286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A47A69A84
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 22:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456BB3ACE5E
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 21:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A910820AF69;
	Wed, 19 Mar 2025 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6nQZ6/x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2EC23A0;
	Wed, 19 Mar 2025 21:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742418031; cv=none; b=ls7WQ2M1OAcJiRin4wnWsEOrts7cv1gvnUl/p3ztuMUqD//YNJiApZmgAGbW5a8jstPtZw2XCcDaU40Rd+RdGUGU2BzAYc+fVTZs4WcwOXFTEwnAWuyOiEbB2qW9iQDkoYPZDKJHCVjVYaln0vZb1Z5cH+aZqENpVOr7ow/T2Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742418031; c=relaxed/simple;
	bh=6Ryghks2AsEpT+4dcTc0Baqr8eDQrlZQq/OAqvoz0XA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mStRBJLYVpH8T/6CWivKRr0QI6srVGA3heEpgV9MCA2L+qxGHai29Y1D6g0fRa/aEc3SeDKvGb1Gr8qeWoMCBtk+CWB7KLvrHRgPxIZvBOwaeQdGtwx9HmvPVSsIwpi/41n0IU/ojP6UUNL2VQ2n14mj2XKJ99j5GMuXzEkSJ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6nQZ6/x; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac25d2b2354so26484766b.1;
        Wed, 19 Mar 2025 14:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742418028; x=1743022828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YZEuMMwBHdsV0PW9zYMRi+SAoQwBsGvExXACH0lOtnY=;
        b=M6nQZ6/xqr3M8ivAS4m9GdCMD2gdhc56HQ0fa7g8b2VrMiCDKZAh2/9TA5TaH+244Y
         20aPanZLwPC8I9N+vy9QjRAu6VNICvg7VjTqzyDdSQvKil+m9bAJKqHbwQp+Jz412n95
         YYJgLwJfb9naky89m0pfvzFKxA6dLg4a2bTKA2LZQXIf1keD++NVQGOdiFYh8IM9uS+I
         GNjMU3fHejjPmw5dtdfgiUfsikYjTbsLrWdn55/9PkJ7wKvW0BEqEYEibw1p70htADez
         IGFH3xGN0Vg0Z+Gx0LMegp37sF8tttnrQPoSOv0ReJJNpxCzG1O97+WB9vJoy7jPTJS5
         9XIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742418028; x=1743022828;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZEuMMwBHdsV0PW9zYMRi+SAoQwBsGvExXACH0lOtnY=;
        b=bVUs//uB3WYk2txGxmuSWkBDVCgDKnFTA5vbpXlO3cM7LNMGYs37oB37gb4rpsVcVq
         ytRJdPBGCBWAsEQOJAJafNl1CeptsZhcrxn1bMQBc0mlM0lMFhVp9CZwzeet/5VuhSLV
         HBLs97tgItv/CIVCJ4udSVHlVNqQ0sXsHnoQ8ycCD3VwlbIUGCqWDNIW/SPJGPnoJBvB
         1l+GEqyXNf2xA/QWL9HrIJ3z889gbxKrhzYDy6Dd63PPimTwSISP2KqGkPAkEOI/r1lF
         u/cnOqrQb3w6BTsWnBOiUpVWV0W1TdIXKI6+iG3DuiD8JOWLoyWnidbKXJ5fvlNgQ++6
         qQXw==
X-Forwarded-Encrypted: i=1; AJvYcCVxIQChfJP0orNO83hHos8nSvMQeP39rZ9UzVFqCiogwT8uO60bLfLpKA/+ZOIrUPz9UsEl795se4c+Ckg=@vger.kernel.org, AJvYcCW+bmiOUDuTGOTofpm1LRgCMOSqi/slJhES43H/KASaXnRbGqOJ1BYghXzgnV8ED7gmr3uOluYZ@vger.kernel.org, AJvYcCWTEGfyIaqVrRK3ElQpRX8yRTEaWU8wtybKscaUae5lwoi9oxMFuS4vAUa/ws3l6DDPQKVgy27YIkyk@vger.kernel.org
X-Gm-Message-State: AOJu0YwKmQyoZL92cinvpeNUY76bGf2wI511fAC5i+LW4ppkLBbNVzB4
	+71/clwQCkIbZAzvEjQg6Z4iJpSX7jmh5p0iQy1uydc+WKMZ0B+G
X-Gm-Gg: ASbGncu6axwTt2zaRrpwXThytjx+y7qv7MZwmz4pJwE/P0K2Q0xG1MLX7i3mX4+XYdu
	+toi2FB/uSrpvXr6KySfk1cyJqIrg2WudlhEUsKXIrM8IcWJlmNKxI0RvIDqMKoApYNgL5UfMbh
	JWWWzfYFgfm1JZIYRMio9tCFkXi5bapYfHQz4+ADQq+ihnzp8ODm7+AuhBDkTxmgk/SIw+h0pEO
	lC2irCcN6i1eDDDO36PefmMQLqwBfwyDfz3Fi3T/fHUdJTnzB+933DatReJ0k98dOZGC+73PCvc
	odO9K/525xAvxkfqyUSKLPPrN9WLZuoN7Djqua1cUWAmwwKjexQJsBPM5PTXqQEZTMCXBeSng0I
	b49pjc6/+odwiHnPMUPeDDs0k3RBUJinulJfxcfN5j7nBL7iU/0BQOE4qsuUAmAZ0lrIdbWz27c
	OyZT3JnW07sbonLVD2899qR4NfIdRAosODatu5
X-Google-Smtp-Source: AGHT+IHXcOrzb9/b9sXiPro3kuhqulSHq0fLOSyIHObxV4GrG2gjterD3NdpkI76LYsUHZ65Nb2Y8A==
X-Received: by 2002:a17:907:3d8c:b0:ac2:b086:88ec with SMTP id a640c23a62f3a-ac3cdf7795dmr105009566b.5.1742418027760;
        Wed, 19 Mar 2025 14:00:27 -0700 (PDT)
Received: from ?IPV6:2a02:3100:a1d0:3200:e9ff:1d3c:4abb:ae78? (dynamic-2a02-3100-a1d0-3200-e9ff-1d3c-4abb-ae78.310.pool.telefonica.de. [2a02:3100:a1d0:3200:e9ff:1d3c:4abb:ae78])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ac3d4bb72fbsm12972966b.91.2025.03.19.14.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 14:00:27 -0700 (PDT)
Message-ID: <b9270400-4081-4df9-a644-0c6d22a1973e@gmail.com>
Date: Wed, 19 Mar 2025 22:00:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PHY: Fix no autoneg corner case
To: =?UTF-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev <netdev@vger.kernel.org>,
 Oliver Neukum <oneukum@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
 Ming Lei <ming.lei@redhat.com>
References: <m3plmhhx6d.fsf@t19.piap.pl>
 <c57a8f12-744c-4855-bd18-2197a8caf2a2@lunn.ch> <m3wmgnhnsb.fsf@t19.piap.pl>
 <2428ec56-f2db-4769-aaca-ca09e57b8162@lunn.ch> <m3serah8ch.fsf@t19.piap.pl>
 <f870d2c7-cf0a-4e78-80d6-faa490a13820@gmail.com> <m3ldwyh5yw.fsf@t19.piap.pl>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <m3ldwyh5yw.fsf@t19.piap.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 02.12.2024 08:57, Krzysztof Hałasa wrote:
> Heiner,
> 
> Heiner Kallweit <hkallweit1@gmail.com> writes:
> 
>> If autoneg is supported, then phylib defaults to enable it. I don't see
>> anything wrong with this. BaseT modes from 1000Mbps on require autoneg.
>> Your original commit message seems to refer to a use case where a certain
>> operation mode of the PHY doesn't support autoneg. Then the PHY driver
>> should detect this operation mode and clear the autoneg-supported bit.
> 
> I'm not sure about it, but if there is consensus it should stay this
> way, no problem.
> 
> WRT specific case, It seems the SFP port doesn't support autoneg on
> AX88772BL (I don't have any SFP copper 10/100 module).
> 
> The PHY registers (100BASE-FX, no link currently):
>           x0   x1   x2   x3   x4   x5   x6   x7   x8
>   0000: 2100 7809   3B 1881  501
>   0010:  250  80C 8620   20 2314  3C8 4716 724F 8024
> 
> BMCR: fixed speed 100 Mb/s
>       The datasheet says "autoneg is fixed to 1 and speed to 100", but
>       it's apparently the case only with 100BASE-TX, not FX.
> 
>       It seems autoneg, speed and duplex bits are read only
>       (bits 13, 12, 9, 8). So, basically, you can't enable autoneg at
>       all and this is maybe the source of the "bug".
> 
> BMSR: 10 and 100 Mb/s FD/HD autoneg support indicated. Hmm. R/O.
> 
> ANAR: quite standard, but doesn't matter since autoneg is disabled.
> 
> I will think about it a bit more.

The PHY in your case should be handled by the ax88796b driver, based on PHY ID
in your register dump being PHY_ID_ASIX_AX88772C. Maybe the PHY driver needs
an extension for handling fiber mode properly. That's something you should check
based on the datasheet. There are examples like the Marvell PHY driver which
has quite some fiber-specific handling.



