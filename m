Return-Path: <netdev+bounces-127915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4765E9770CE
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 20:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8051F2A7F1
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 18:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABE21BF81D;
	Thu, 12 Sep 2024 18:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtZbPS53"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A639126BED;
	Thu, 12 Sep 2024 18:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726165606; cv=none; b=KV2xN4KsPXxCWQXVzEPvSiQDgKYmaMHqkHE8VoRIVI7nuUthNd0o1Xk9DMT4ApbaWVTCPMXLEZz4BDKEaue07HBcDmhmc/yHgqpJzraNUS4Ug21rNC2Yzsmc4Z0XoHERNt1PjO7RSP19kAiCO9YfrTOlWiISkxcq/5XpghQpdLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726165606; c=relaxed/simple;
	bh=dzgJ0SuVVxEqB5P+kZx/4Eda8ssR++a8/IbP/jLSzBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nEnHX223f3soKlSP9wGuVktQYG0B6rCxaa/6wHVJO9C7m2SNQrAznlkJkm6dHM3jGm+cWISmx0cdr9YoXM/KEt0m5ZIvY/p+zSrqUG9Sc76OflR+snvmSNBiz13TtOPPVQz7HGQ8gCAQkaSa+vvT+rPAXVhrdI48vf2s6UCcU9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UtZbPS53; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-205909af9b5so642715ad.3;
        Thu, 12 Sep 2024 11:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726165605; x=1726770405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q7IUJddT5t+h7kKgtiyWdLDVTVlZ6mnCwmmoGotr+JU=;
        b=UtZbPS53X4dUHuHXLnb9/8J9uGMANWpMEwjGec4xolws4KiF5VjZx1PbkaZlENDsb7
         iEkPHKd772gTMsL3Cbwmps9J+tO4Ld1nazn9ATqY6tGhdZssmRiQS8vRyFQJigiYTvCY
         LXZnnLzF95S5mYekwpQrXr8mzSUqoV9vxflZ6D0PjC2vz3XbhOSYE1kpykO0qlRtMd7k
         gwUj2djUBoB5lwrBgcLmwfvZct7uqbOGjHHOb2qZwDMbA/k1MPCUwCN/WpTR+/fOtycZ
         y2A3yy6UlxDK19I7oQskyGWT7835jTFvI9Q3GDQutoyH50yJBcb5SkkACW8y1Z3kuwZt
         FGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726165605; x=1726770405;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7IUJddT5t+h7kKgtiyWdLDVTVlZ6mnCwmmoGotr+JU=;
        b=vgury4z3zrJDTr4HjjN2UxVpUf9kq7PCbVYqE+GvWS7hHyOTpfLkI+P9K1s35HK/GV
         dCTqYyLfVo2DJNVtVNx90B/faygUh5wWs87qn0cBIe8LzwrGPDulj+NMXJp4+u54Oalb
         7zOIxPus6XwL4bze3L69zG2mE1VttF6jwvqJxxssVEO4CV1Uy4AI5sYwNpwffUpMRo1n
         PVEvc3z2nXDB0m9Yt501raUrP1aYkk6M7CAqPBaQM9q2QSgwDpII3TJhEj21RSB0SfEO
         EBrbGHGb2uPzaSLUc74O44zMtBj//Tcl83YI69JHih8Dqy2jecM/uf+Tt2vB2pvOWem9
         dUCw==
X-Forwarded-Encrypted: i=1; AJvYcCUMqjtoBGCcd37KQIpB6Y4g940y34aCRXHjLWhuA6k9bPDmS4QlF3V79KboXaWrXKn0xmS0ccd+2ywWt9s=@vger.kernel.org, AJvYcCUVU7qUdU1PYb6W+LGIoyfweJi8vtALso8JSIY3qzBk3K6Xia92rnxmTIiMOAAHMUJ9RxCjR3yX@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1e75rLo8yQWLtgx70rAkJoP50cokgq94o/sy9+hBWrcvpCnA1
	i+GyU8A4jeC9oHhcSBZyXx+ChJr47MElEP+XemkIM8wvMGf9ps+T
X-Google-Smtp-Source: AGHT+IG19uqq1ZSZn/qf7SEVHiag/lTIAfawWmOhaZvjVYdaLp575w3F3YmS93Pu3uy11W6i36E4YQ==
X-Received: by 2002:a17:902:ec89:b0:202:38d8:173 with SMTP id d9443c01a7336-2078252a2a5mr984135ad.29.1726165604443;
        Thu, 12 Sep 2024 11:26:44 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076af252e2sm17199145ad.6.2024.09.12.11.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 11:26:43 -0700 (PDT)
Message-ID: <8372fe02-110a-4fca-839a-a4fa6a2dea74@gmail.com>
Date: Thu, 12 Sep 2024 11:26:41 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/7] Allow controlling PHY loopback and isolate
 modes
To: Andrew Lunn <andrew@lunn.ch>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Herve Codina <herve.codina@bootlin.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, =?UTF-8?Q?K=C3=B6ry_Maincent?=
 <kory.maincent@bootlin.com>, Oleksij Rempel <o.rempel@pengutronix.de>
References: <20240911212713.2178943-1-maxime.chevallier@bootlin.com>
 <aae18d69-fc00-47f2-85d8-2a45d738261b@lunn.ch>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <aae18d69-fc00-47f2-85d8-2a45d738261b@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/24 11:21, Andrew Lunn wrote:
>> The loopback control from that API is added as it fits the API
>> well, and having the ability to easily set the PHY in MII-loopback
>> mode is a helpful tool to have when bringing-up a new device and
>> troubleshooting the link setup.
> 
> We might want to take a step back and think about loopback some more.
> 
> Loopback can be done at a number of points in the device(s). Some
> Marvell PHYs can do loopback in the PHY PCS layer. Some devices also
> support loopback in the PHY SERDES layer. I've not seen it for Marvell
> devices, but maybe some PHYs allow loopback much closer to the line?
> And i expect some MAC PCS allow loopback.
> 
> So when talking about loopback, we might also want to include the
> concept of where the loopback occurs, and maybe it needs to be a NIC
> wide concept, not a PHY concept?

Agreed, you can loop pretty much anywhere in the data path, assuming the 
hardware allows it. For the hardware I maintain, we can loop back within 
the MAC as close as possible from the interface to DRAM, or as "far" as 
possible, within the MII signals, but without actually involving the PHY.

Similarly, the PHY can loop as close as possible from the electrical 
data lines, or as far as possible by looping the *MII pins, before 
hitting the MAC.

So if nothing else, we have at least 4 kinds of loopbacks that could be 
supported, it is not clear whether we want to define all of those as 
standardized "modes" within Linux, and let drivers implement the ones 
they can, or if we just let drivers implement the mode they have, and 
advertise those. Meaning your user experience could vary.
-- 
Florian

