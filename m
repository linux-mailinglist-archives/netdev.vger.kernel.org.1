Return-Path: <netdev+bounces-238786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255FDC5F615
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 22:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC21F3BE056
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 21:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB5B35BDAB;
	Fri, 14 Nov 2025 21:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYmLdc+f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC09F35BDD2
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 21:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763156013; cv=none; b=EmhafZZ9wwTt5BIOWyxcvErWbd4Kjlli61t/28tveU/yM4zrVBvViw5iC1kXx1YJ+abNkPCGYOYse+wqUYRx/8wMT1Uy1ZhyXPiQRIVvBxYncNntVyVqoJhWn+nGcdRWT0Ho+raQ9zLixhz7OBNmIqu7Goa/HEZNfSyH4zSzlLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763156013; c=relaxed/simple;
	bh=MOYTVcDtzKsEkfeemMCLvem2CzJMXD4U6pATpCM/TyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eiL/V5p3JyjDQ+arU9KbugAmDUE7PwMq/29NP7OotpxIiqtL88lBaYXSDdwT4lkJve6N2uEwLzqpX41pvPidXQa2HAAQk404Tjbqe/+kktBKfHUktiKHGt8unPCrdkblurvKboQwFPpy4hbTZsx9CxfBfWvQAVOad+snsWof0Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYmLdc+f; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47755de027eso18413795e9.0
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 13:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763156006; x=1763760806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qxt593s46vsT8zi56aoiZDVkzPOtzTy1Y0D8TbVwB9Y=;
        b=QYmLdc+f+Y8ZFaPOk/IbaU1Yy4h7/gUGDY0dfuRs/JZ4+JE2aD5Cwd6O9up2097Y87
         cuhRDxVjrH4SYbvPIHhBUwm9E1YYyrYpK1Fq52bP7wacC7Seyp/0ffWsDvkY1xz6n8se
         cwotyJpjjtj6n/UlW0lhz7pL5t/a6kGkBBitNRUmDSvMasy5Ee9l870rxy28qzXeVwFX
         bapAo7IZYY65BF2aCmOaRRJ0hRC98p7x02zVA9FXvx8bfMg32FsEkiVEbKNxo1hhhHwo
         5BChRLmC+KHEk4m053D6hSVdWbhjSp6H0BLyNqraVyoPndvDiaTaF9vwEgxTq2gnXgq6
         nkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763156006; x=1763760806;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qxt593s46vsT8zi56aoiZDVkzPOtzTy1Y0D8TbVwB9Y=;
        b=Or/njxoPFbBWIeG/lHAbcBgGHlLz3nmN0OO8bNWrDTzavwFKLYmVROTVSUu6kjlAiK
         zT+8U2H8WOYTWhEL14Ax9eR8u2T7ZzsO00ZC+Yr8c39AeQsMmM7lCDOCeqWNekIqu2pg
         oSHQd8S0tjgrzB31fW1VsUdum52nkbV4wJ3u+2Ogx8TRviiRiuXHzW1r1coucCpfzq98
         hKn6EoZqFMZxqCfhEVC8Sx0B/zXe8twjGnZMx8p+Xd1jTEQp7psHE8lnTTcn9kQMGjW4
         VtyJRZO92iqFKADMN3ccmOHo5QH2Xpjz7BYu6AdhcFQVlEOBwcLTBrcwHJjcwYcbAVSO
         Cqhg==
X-Forwarded-Encrypted: i=1; AJvYcCWT6ZmNQLfPLnU3ZZt+79tW0xJraKA1AZbg7hUR7EyA5D7KxYmwc9I5I2A8cVBkgJMf6BxQ88g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX8z+WzR+qqZMpe6h4hdG6qApVBvCZvJIWxN/ItkJocDOwJ1SV
	7LdsmNoBKAi4BAQ470G1SPp74UAQrs2tDhEmUyoJ4tI/Yd7oJ4iao8E7
X-Gm-Gg: ASbGncs2dx11INptj6/nyzSEpUWwI5eTs1srdKussLMOTFErAA6sTRivatcAVvZ9XPV
	rDUpERa22utuUrUe+6mx7UhgTj0n96bXRpeKL6wRAxwuB7LtZOIAzyfg8CErrNkXycdfbnNsWMS
	j1NQYqexZVsVlm+LYOGPhQZ0vxZyCRIPLA76YSMqgR6YyhMl3uid6MNF+1hXx5uOrmga0BJ5oPU
	xhjiJ5+yzI1yO66/Bj9jai4hwiN/3HOtPWUEY7Hx031fxCOgCeOSTfs9d8Rc4pfeX1fnJzkUN8c
	sntxso1Jnz711f1k49hkEcfutZgZINhT+GyaX1xlfbL7ChGdvcq+9aFxbUowk4m45MvYtw9uIzg
	vpEIoppB4QqSXa2pN8bO6wCyYs7/8dIoB+Lp9S+dnVSUe53JPA7D77MDeDtoHqikS0uQ+NgPLpl
	h5+zcwtkGLdkSRSBcxAEJ3nnYh+USalyEuR60Angd7i8za6rB4LajEXW/+ofMxEW21w54ldCbVh
	D2va/IcvBpBOvbDbWO1eol/Y/seLA8Cut5txCOnQfE=
X-Google-Smtp-Source: AGHT+IEOz0ZvjVSAEWnPoK+yFW6gvAByu0+IX8Nl1UGJkCVwFbBy1TSoJIPro4wzaqCTp8EEwAxxwQ==
X-Received: by 2002:a05:600c:3593:b0:477:557b:6917 with SMTP id 5b1f17b1804b1-4778fe4fdecmr47017405e9.18.1763156005922;
        Fri, 14 Nov 2025 13:33:25 -0800 (PST)
Received: from ?IPV6:2003:ea:8f28:ae00:8196:7cf4:6cfc:c017? (p200300ea8f28ae0081967cf46cfcc017.dip0.t-ipconnect.de. [2003:ea:8f28:ae00:8196:7cf4:6cfc:c017])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e35b7esm175416715e9.4.2025.11.14.13.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 13:33:25 -0800 (PST)
Message-ID: <1ec7a98b-ed61-4faf-8a0f-ec0443c9195e@gmail.com>
Date: Fri, 14 Nov 2025 22:33:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LAN8720: RX errors / packet loss when using smsc PHY driver on
 i.MX6Q
To: Fabio Estevam <festevam@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
 edumazet <edumazet@google.com>, netdev <netdev@vger.kernel.org>,
 Andrew Lunn <andrew@lunn.ch>
References: <CAOMZO5DFxJSK=XP5OwRy0_osU+UUs3bqjhT2ZT3RdNttv1Mo4g@mail.gmail.com>
 <e9c5ef6c-9b4c-4216-b626-c07e20bb0b6f@lunn.ch>
 <CAOMZO5BEcoQSLJpGUtsfiNXPUMVP3kbs1n9KXZxaWBzifZHoZw@mail.gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <CAOMZO5BEcoQSLJpGUtsfiNXPUMVP3kbs1n9KXZxaWBzifZHoZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/14/2025 10:15 PM, Fabio Estevam wrote:
> Hi Andrew,
> 
> On Thu, Nov 13, 2025 at 7:35 PM Andrew Lunn <andrew@lunn.ch> wrote:
> 
>> Maybe dump all 32 registers when genphy and smsc driver are being used
>> and compare them?
> 
> The dump of all the 32 registers are identical in both cases:
> 
> ./mii-diag -vvv
> mii-diag.c:v2.11 3/21/2005 Donald Becker (becker@scyld.com)
>  http://www.scyld.com/diag/index.html
> Using the default interface 'eth0'.
>   Using the new SIOCGMIIPHY value on PHY 0 (BMCR 0x3100).
>  The autonegotiated capability is 01e0.
> The autonegotiated media type is 100baseTx-FD.
>  Basic mode control register 0x3100: Auto-negotiation enabled.
>  You have link beat, and everything is working OK.
>    This transceiver is capable of  100baseTx-FD 100baseTx 10baseT-FD 10baseT.
>    Able to perform Auto-negotiation, negotiation complete.
>  Your link partner advertised cde1: Flow-control 100baseTx-FD
> 100baseTx 10baseT-FD 10baseT, w/ 802.3X flow control.
>    End of basic transceiver information.
> 
> libmii.c:v2.11 2/28/2005  Donald Becker (becker@scyld.com)
>  http://www.scyld.com/diag/index.html
>  MII PHY #0 transceiver registers:
>    3100 782d 0007 c0f1 05e1 cde1 0009 ffff
>    ffff ffff ffff ffff ffff ffff ffff 0000
>    0040 0002 60e0 ffff 0000 0000 0000 0000
>    ffff ffff 0000 000a 0000 00c8 0000 1058.
>  Basic mode control register 0x3100: Auto-negotiation enabled.
>  Basic mode status register 0x782d ... 782d.
>    Link status: established.
>    Capable of  100baseTx-FD 100baseTx 10baseT-FD 10baseT.
>    Able to perform Auto-negotiation, negotiation complete.
>  Vendor ID is 00:01:f0:--:--:--, model 15 rev. 1.
>    No specific information is known about this transceiver type.
>  I'm advertising 05e1: Flow-control 100baseTx-FD 100baseTx 10baseT-FD 10baseT
>    Advertising no additional info pages.
>    IEEE 802.3 CSMA/CD protocol.
>  Link partner capability is cde1: Flow-control 100baseTx-FD 100baseTx
> 10baseT-FD 10baseT.
>    Negotiation  completed.
> 
> After pinging with the Generic PHY driver:
> 
> # ethtool -S eth0 | grep error
>      tx_crc_errors: 0
>      rx_crc_errors: 0
>      rx_xdp_tx_errors: 0
>      tx_xdp_xmit_errors: 0
> 
> After pinging with the SMSC PHY driver:
> 
> # ethtool -S eth0 | grep err
>      tx_crc_errors: 0
>      IEEE_tx_macerr: 0
>      IEEE_tx_cserr: 0
>      rx_crc_errors: 19
>      IEEE_rx_macerr: 0
>      rx_xdp_tx_errors: 0
>      tx_xdp_xmit_errors: 0
> 
> Any ideas?
> 
The smsc PHY driver for LAN8720 has a number of callbacks and flags.
Try commenting them out one after the other until it works.

.read_status	= lan87xx_read_status,
.config_init	= smsc_phy_config_init,
.soft_reset	= smsc_phy_reset,
.config_aneg	= lan95xx_config_aneg_ext,
.suspend	= genphy_suspend,
.resume		= genphy_resume,
.flags		= PHY_RST_AFTER_CLK_EN,

All of them are optional. If all are commented out, you should have
the behavior of the genphy driver.

Once we know which callback is problematic, we have a starting point.

> Thanks


