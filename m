Return-Path: <netdev+bounces-259854-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BQFBqqEmmn0cAMAu9opvQ
	(envelope-from <netdev+bounces-259854-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 05:23:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6664516E78B
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 05:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CE39300F198
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 04:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84688149C7B;
	Sun, 22 Feb 2026 04:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Be51feOX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D7441760
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 04:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771734181; cv=none; b=tfw3OoaVHvPQTvvcMnmUYwMtVZvun11IYvrdhr7yyaiUj4VVlBwox2cBE6yrS2h0IJdQMg8L9uP3YhlEa27X+tcOml3F/zRriJRYBeMTP1M2s5Lu3joe1JF92cbZ3p6dn7eSALmMNKs5wikksuWTKHRKpth9CaKC19JZENAopXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771734181; c=relaxed/simple;
	bh=l3Ja8vwZFVzQLtN+ODBurF4y2AVKYOAVGXK8mJN4Kvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+b6i6BqAc9RiuwKMceDrkMu3ZvDUHA/vwdUdu7vEJZ5om+bv0lVp2HQ2uO/HZ4paHL7hJIkeWY09xZ2/2YDknGBOAwkg15+H4iqb9vc00VS5Hj3MUKQOtH0mix0dQ2HWyLkCygWUNrqPGa2zylNNsv+9Tr7F4iiJ0Vj2iiUOtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Be51feOX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48378136adcso19556465e9.1
        for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 20:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771734178; x=1772338978; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ERJgIG0KEEQ+Wz9vRb5osw5bbYXqpU9oMnrM1A15MLk=;
        b=Be51feOXRtiFqXX656IEfF1b5AxPNu2O3N4IKfRJKXd/GRcwwyu8Bw46hlZbehfHXn
         4T7RmIanTiX2MHZ9JnbhAjd/pqRqMxF3gEUWFF4kz5tPsTRR9XKQCCZXNvmmGXDZLHGR
         i4FMxfoMK/DT8rdrrHuLnPpN9nUbBhx+2ojFCmWISup35dVTMowe+aDvEODiUZ9t8Qft
         /8w0M8bhHi2H+NQ2JZnnDCvGimdJRETa41l54uaqTH2IjaXHheO8pitCU/3cqbH4ZHoR
         9K6qyeLTUI6PBYd5Slg3FraaJm0WTqUReSnwyUsFf5Srmx/nEobPQDhzx1ZIiVUbkJiy
         3YtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771734178; x=1772338978;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ERJgIG0KEEQ+Wz9vRb5osw5bbYXqpU9oMnrM1A15MLk=;
        b=Cdvp5qEQUNHbNkWDM0cGLUcx5p+f7VMN7K3mFO8TqbU3tkCrxny6iFel5nww0GI4bM
         Siv5ysnqU/7jiPGKIdGYsiWVXQyxpSlM0V/Y+ocEYKURf3FX/nOwpEJ8AsfPF24JfVP3
         QKj1Jy5NNnUpJ8XGzZNZs5/zg7i8IUOtY9SJPbfv29AYsfdVhWEEzixj0zN7iMhYHUJa
         yq5ctWkKv8PFbNozSaLguFMwWklAK/R3OGkdSRtOUorrED/SBWdVG8CvtKzAhtCGJSIY
         K+d4crewk+PfPnYVXv0/y8MuJIaUDSFUPb7Hjq+bIULW7+MICM+HzZIbyJlYqBwRPwkP
         mdNg==
X-Forwarded-Encrypted: i=1; AJvYcCUjpBTO7FO+iuAMnqKXpL9tW22wrbghOfmpS1hxR1i1AEhZfOxxieOyT1Z24hsM2ub3sRd4AdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgzRvYa0u/tWTtLdfIm+d5iXB8XTmVKzo0cuNNGMfeUv345ItF
	HGDpyNetXHtViBytkzMPLO5r+5yuuzghu0axeF1/edf4od84bM832ep/
X-Gm-Gg: AZuq6aKIbhnLyoJcMDayybYsLIp8aIKQbyxR/p9SYHmT/2MHzyiU6YI34oy4ATcViS1
	1YGoXzhGowA6K+z2g4nAKfN/xE3GfVDm2mXT8d2gaFH+UdEhoyIPvAnrLfkJUyaRt/pr32Y63VU
	2WsjhWWr1cApHI2U7Idq9GtkjnvZ6y2gdsrLSYabjUnKffwa9PUbQLy7QTppwnppdUl3uoDdq2N
	gypbrlA+iQMtTBLGRDoQiSAHOKISm/p3B41Osfxj1RzdTTV6I0geP6GJxxK0FK/cax2rLAEXhZ1
	+f7WdA638KVtRwmgzQ0jrtZez5rDcZswIdh8rshUmFVwCJFvKaiNhd0FZV97F+omruGKEHWvlLp
	LCowNxMvK7BCSbCLeXodzKUHAZq0z8l8YvfVEt38gYxlY7+HFjP9dBLwT4UStvN9JP7+vSmVvSg
	IMhnEmpV0vILvpooNdA54cCQ9K4YdB3QCmEstjf41BAnByAdbKxG31vYDRnZ+9Vr+2Wo6Xu6Bh/
	JYnB9hOU6J7+6k=
X-Received: by 2002:a05:600c:820e:b0:482:e5d4:b7ca with SMTP id 5b1f17b1804b1-483a95f7d94mr66421395e9.8.1771734178198;
        Sat, 21 Feb 2026 20:22:58 -0800 (PST)
Received: from [10.0.0.98] (snat-2.cgn.sat-an.net. [176.222.226.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a316eb08sm195961615e9.0.2026.02.21.20.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Feb 2026 20:22:56 -0800 (PST)
Message-ID: <740e8351-d8a5-4f4c-91e4-c278e4b7d248@gmail.com>
Date: Sun, 22 Feb 2026 05:22:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net: phy: motorcomm: yt8821: disable MDIO
 broadcast address 0
To: Andrew Lunn <andrew@lunn.ch>
Cc: Daniel Golle <daniel@makrotopia.org>, Qingfang Deng <dqfext@gmail.com>,
 SkyLake Huang <SkyLake.Huang@mediatek.com>, Frank
 <Frank.Sae@motor-comm.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Sai Krishna <saikrishnag@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <d3bb9c36-5a0e-4339-901d-2dd21bdba395@gmail.com>
 <0308e736-c3e7-45d2-86f7-e729af9cb487@gmail.com>
 <3e64d8d1-87c1-45e0-9556-0ca844a90f73@lunn.ch>
Content-Language: en-US
From: =?UTF-8?Q?Jakub_Van=C4=9Bk?= <linuxtardis@gmail.com>
In-Reply-To: <3e64d8d1-87c1-45e0-9556-0ca844a90f73@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[makrotopia.org,gmail.com,mediatek.com,motor-comm.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,marvell.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-259854-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linuxtardis@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 6664516E78B
X-Rspamd-Action: no action

On 2/22/26 04:35, Andrew Lunn wrote:
> On Sun, Feb 22, 2026 at 03:32:45AM +0100, Jakub Vaněk wrote:
>> Hello Daniel, Qingfang, SkyLake,
>>
>> do you happen to know if the MediaTek Gigabit PHY in the MT7981B
>> can be remapped to a MDIO address other than address 0?
>>
>> I wasn't able to find public documentation describing the registers
>> of internal PHY or whether its MDIO address is configurable.
>>
>> Being able to move the internal PHY off address 0 in U-Boot could be
>> a better way of resolving a MDIO address conflict between the internal
>> PHY and the broadcast address used by an external Motorcomm YT8821 PHY.
>>
>> Any pointers would be appreciated.
> 
> Even if you can avoid the conflict, you still need to handle the fact
> the YT8821 appears on two addresses. phylib has no idea it is the same
> device in two places, so it can instantiate two struct phy_device for
> it. This can cause problems, i think suspend/resume will break, etc.

I had hoped this would not happen on the Cudy router. The MediaTek
Ethernet subsystem driver uses of_mdiobus_register(), so PHY address 0
should not be probed unless it is explicitly described in the device
tree. That said, I agree that with mdiobus_register() this would still
be an issue.

I was also hoping that moving the internal PHY would provide more
flexibility in the device tree description of the YT8821. If the
workaround were implemented in U-Boot by writing YT8821 MDIO registers
at boot time, Linux would not be able to assert the YT8821 reset pin
without losing that workaround.

Jakub

> There is nothing in IEEE 802.3 clause 22 or 45 that allows for this
> behaviour. So rather than living with all the issues it causes, you
> really do want to get the PHY into standards conformance.
> 
>        Andrew


