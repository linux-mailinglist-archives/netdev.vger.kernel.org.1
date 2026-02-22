Return-Path: <netdev+bounces-259852-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNdXJtdqmmm3bQMAu9opvQ
	(envelope-from <netdev+bounces-259852-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 03:32:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3807A16E6B7
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 03:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6C2153012BC4
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 02:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE622A1AA;
	Sun, 22 Feb 2026 02:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ds5wGORl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A8E3EBF08
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 02:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771727572; cv=none; b=OdViRmQyPoxQ9XJ+0eldm3eIUIjueVIgM/gAQzsckFPiGn5mFx2HZg2ujp4YrguoJfSWQOPZ+mfKLZqpKQ/Ymsi2CDxkv3RMtHHVZzORj1M5JVhFfPseg2vLoGnEGYKuXNO0C+35W3A/HNXozZqv1wicmAv1DQt0TCCMlAh7nMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771727572; c=relaxed/simple;
	bh=pWMU4YAElEBPc8VGhMUlqfh2xsS2WWNaHpUzvBCps60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LgnKUXiHfUEiGerVFPxX2LnTerYmgLEw1/rxup+cOelJrxzaXcGlDwiFQ2xJb72KkSfF9QyQRgDj5sqlDDq+MI8XD9aotkEaZ9pQ0sQsWUjMFydrazvdCdK9WqZy4ehXvHKzc1VmZcpEV2zfEltMvBz9MlPG+Xz4vLFqaZD5M+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ds5wGORl; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-436309f1ad7so2356023f8f.3
        for <netdev@vger.kernel.org>; Sat, 21 Feb 2026 18:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771727569; x=1772332369; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tjyOhdjvp7v7DJIPIoXt7eHEIjMpNe/vYYlSX/5NxyI=;
        b=Ds5wGORl24f+OlV5eV57Laco4qmP3iO3hGGiAuyBw5dbgeIvXdrEnmh5M1kYxYSHXf
         3dzGoJEONAp5Xf2EI191R9pQx60YaJBfJsAmWAgJBtMlWF7MPX4UFVaGMQ3MsF7MO6a1
         wca/d5gHEpThBI8ruNrqSAbFYa4io/1krk3nRQKji4rXHh79kYROleHiIo77heq3Rg01
         mdP9ybJzdpnohuGx9FBiixgeE6o5z9/dBVqHNTFMQe8Kp/5brpmecOVZmSpzvP8oeIC2
         923czDQSKvVI2BXNEnfX6YGMx3LA+cwIMOdOyHFHTZsH/Qty4umr469OJfSpztMDNgra
         ed3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771727569; x=1772332369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tjyOhdjvp7v7DJIPIoXt7eHEIjMpNe/vYYlSX/5NxyI=;
        b=Axw+wlcw7sQzgjv2Dxvemkt4bw9yqUwpCwKYjLbEX4EX89WOj/5DioUGqmaZha/uO5
         QkeeYFRP4x+3vco/tCjTpHolQedPTXi4hW6g79cXHc0jPhQoprMlt3uVGapV4rCJKXz7
         3fOlh0KGY57ZOkGmVzVdv+3oT7D41loW8ZKvw1J4DiDbR9WvKH6TbcAPhQCr3RwQ/H7/
         zekiEZ9Qzd78/JINlBURv3sFghh8UlFvugHbFOqujpjhJGFgSQivxWsjNMUDbxdGONc4
         A/el2G4OkYz/wZqP6lRSQYrisd8IW5KIUsNfRB3SkwRN5BHg08S8p7cssDrXDt6oMOGN
         N/4w==
X-Forwarded-Encrypted: i=1; AJvYcCWAinqPBbhaexfHlvSH/2Lw2U2XtqG0eKSgzFpGAxQ77Q6W63js+H3FBcBh89HqGNA9IrmyZPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVPf5kJUp4ZK4ep+sLcrqbswtByzKMWWiM1oG68zaGpOUg0ufS
	+ugvwO4zhc8V9nPYlUqJwti0e1GI2Ryt9XmoXzOwrnImxKmog5fqDF93
X-Gm-Gg: AZuq6aL+Q5l7qzP5BAM6Yt7fIP3dRWISmwnFcz2uctlVxflsdLBpdvYuvRXMIjEM+q8
	mIIIXMCDxmwNbqth1AUhy7YksSjZPLpzyfT9qTKJReQC4uIFX19IIe3f1daChYmlILktn+xBPyU
	WkTeprvHk/iEgwSAKOHdSfSLYzFS/tnYB/xEn2TG7umNsXKSY6cmd307PRJCiLzf8rv5kb+Ai9T
	/yvnJ0Z1nviSHCZ3vt1+R5us33heWnD2dUzEMoGvzUlrhfZeo1EUW7ur6QMYF9uRexx0zpSp4U4
	hxUeRbywdGyv9CK6ygnKD6/S4sZoNyV6KJ2qce+/VgGzb+4O5KcGlp//iHkGMpa8Wcb4nw/OrTc
	UkwR7yx9DegJ2MsK1RzIRENK5Am4OthrUmIJAJZRrpPCRRAR4OG2zrNIfm0zHpf1u8uJHFkDrQS
	gclD7Qjzv7xL15WFgAi72MomqdQI7VAprdT2a1sXEik0V+en1QOjlhUdfUY2tu+rIIQjqsyMXO1
	Kkr
X-Received: by 2002:a05:6000:290c:b0:436:1989:46b7 with SMTP id ffacd0b85a97d-4396f15e518mr6976249f8f.15.1771727569086;
        Sat, 21 Feb 2026 18:32:49 -0800 (PST)
Received: from [10.0.0.98] (snat-2.cgn.sat-an.net. [176.222.226.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d3ff1csm8365704f8f.20.2026.02.21.18.32.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Feb 2026 18:32:47 -0800 (PST)
Message-ID: <0308e736-c3e7-45d2-86f7-e729af9cb487@gmail.com>
Date: Sun, 22 Feb 2026 03:32:45 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] net: phy: motorcomm: yt8821: disable MDIO
 broadcast address 0
To: Daniel Golle <daniel@makrotopia.org>, Qingfang Deng <dqfext@gmail.com>,
 SkyLake Huang <SkyLake.Huang@mediatek.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Frank <Frank.Sae@motor-comm.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Sai Krishna <saikrishnag@marvell.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <d3bb9c36-5a0e-4339-901d-2dd21bdba395@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Jakub_Van=C4=9Bk?= <linuxtardis@gmail.com>
In-Reply-To: <d3bb9c36-5a0e-4339-901d-2dd21bdba395@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,motor-comm.com,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,marvell.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-259852-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[makrotopia.org,gmail.com,mediatek.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linuxtardis@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3807A16E6B7
X-Rspamd-Action: no action

Hello Daniel, Qingfang, SkyLake,

do you happen to know if the MediaTek Gigabit PHY in the MT7981B
can be remapped to a MDIO address other than address 0?

I wasn't able to find public documentation describing the registers
of internal PHY or whether its MDIO address is configurable.

Being able to move the internal PHY off address 0 in U-Boot could be
a better way of resolving a MDIO address conflict between the internal
PHY and the broadcast address used by an external Motorcomm YT8821 PHY.

Any pointers would be appreciated.

Best regards,
Jakub

On 2/22/26 00:46, Jakub Vaněk wrote:
> The YT8821 PHY responds on two MDIO addresses by default: the address
> selected by its strapping pins and the broadcast address 0.
> 
> On platforms where another PHY is hardwired to respond only on address 0
> (e.g. the internal Gigabit PHY in the MediaTek MT7981B SoC), this can lead
> to MDIO bus conflicts. The YT8821 may incorrectly respond to transactions
> intended for the other PHY, leaving it in an inconsistent state. The
> following issues were observed on a Cudy M3000 router:
> 
> - Achieving just 100 Mbps speeds on gigabit links. Dmesg would show
>   messages like
> 
>     [ 133.997177] YT8821 2.5Gbps PHY mdio-bus:01: Downshift occurred from negotiated speed 1Gbps to actual speed 100Mbps, check cabling!
>     [ 134.009400] mtk_soc_eth 15100000.ethernet eth0: Link is Up - 100Mbps/Full - flow control off
> 
> - Having the PHY report that the link is up, yet no data would flow.
> - The YT8821 would be affected by an "ip link set dev eth1 down"
>   command aimed at the other PHY.


