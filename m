Return-Path: <netdev+bounces-158590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 352DAA129A3
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 18:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527171889F0D
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 17:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B76078289;
	Wed, 15 Jan 2025 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiGTUTyk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB00152E0C;
	Wed, 15 Jan 2025 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736961590; cv=none; b=K7sCZchwbUDn6RfI/8rPteuT3P010nHaoqoQ8stT9zbco06N8tAMYmgwFUAH/8gHamzLmkPSIDxqzo1kAJQAzJpIfmgEIk4yVspLCMUfNGVQW2lgsjOCo0ma/Qevmubmgxg+VwFN60ecEAKyvA1dOdoegjROpu+sojtLA6ZjyFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736961590; c=relaxed/simple;
	bh=gWwdZNhfL95dfPj6kyJGC7NDxta8RDH5Ki9MADe7dDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eWKn+7GMM6gpVV4R9tOK3nIWbAPIhMU3DD1qh1S+W7QGJChUUTGekP9zm3pXXEC61PfG+6vq3x1tC021v04FyKefVLQD4vDshaMvOeXX8t04lgCNrW7hxePddhtOfr/+4Gj+WKG4VcsOKKpQgncUdMJXlObSoxWe4OCXcBDP9zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MiGTUTyk; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4361815b96cso50050035e9.1;
        Wed, 15 Jan 2025 09:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736961587; x=1737566387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2BLsQsFtz/zdyPY3VilJvhDyXx4ZAc5YV13xaGB4QV0=;
        b=MiGTUTyk+rBHvReT/Xtudd/Hv+mCJy/LX3G7w/M/C2J5rtopmoNdA0/yrInlQ1EcFd
         wMkEfrFYi/yCJyWvScejlVUqWUEU/EEFPJXxTLuZ1Ux7Y+5uGo4QfH5zuT+XPtkjUzj0
         0AMI1cP5aml7W8U8fq+qrwdwgHi3bEqHRRbR/jpzreRGisHpRWIddigUzV1CHTg+yjoB
         R2L/bZQCqFmaHDuLyt7TIdxkHAs7nWpqOnnr0edQi5OxCg3ibyWZLz2Et/uux2p/jQKC
         d8C1XDkO6CUY8Jdk1jbwXjjyS6EMbDnGlRv40m3kwEj/2qvbLL6xyi75Ou49bEKTU+P9
         2K7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736961587; x=1737566387;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2BLsQsFtz/zdyPY3VilJvhDyXx4ZAc5YV13xaGB4QV0=;
        b=cP9/6k5ik8Z3Gpisr3Y9dHnrrPSoKxuzfcmMxqVsPHwUnyZDNkxlE59Qb9UgK9ecUP
         lwxskJKheTbwHMTCqUMJBIe7/qfyypO9egNZHz0cHK45A8wsqZ5F9WmQHJKsAssmLpFR
         5n4p/ET8u5Fg9zhxQN1IQEusPelXYk54LqlWn/G6Vfhonae8pYjZTUbON+Rixd9LB8w0
         MZ5COSgW5ywGuJoOy5kUJmcm/EfugB74uAswhWQC1rotx58blPJX0WoXbn4qoNB35stm
         X+J/XVDjqul9mp3qmPVw0WRvlt9L6Vef3C8OvwF9Da+GqOFg7iVD//N0A3IgcBjxB9kK
         f9Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUkZjlj3/E9rvTN6iSgmZw8NuCG4PqHfrcotFyOCSi1+OGy7gAtlNxUGJNzcr9DRGOS2x/ipTOFqv+Earw=@vger.kernel.org, AJvYcCVuCUGtgXbWLxkVfVug9jN37XAF0T9ikfrA+k3g+3jmeUBZABT3VUHpX9MazEnGU0rTDFq+JiBC@vger.kernel.org
X-Gm-Message-State: AOJu0YyL8HX/TXoB3Gme20HhVe7kLg38eJvmqlqU9oGkYq6qNIbEOCf8
	qGT78dhl7R07CUw5hQU+QBBjPDIGQ0kRSNDopj4DHRFfq4isENe9
X-Gm-Gg: ASbGncuopNn8m9Zm4jhzeWFHPuojC+DF2FdsAszSrxW18XbI4bnjkNB2fc0yOBxbiBn
	+b7GiyHYgzx6ms7B1308qy6kYn+aIWbchJ1EtgDoeff9HgPafN4S0KrJzb22IGbTFOmH0JGUy2C
	87+QDLOOA2Zmzt+2ywT3YsU+eeZSgkDVAB3ZbU2aWb7jTORj6kJTdTiQrT9BEzyICsHqXiW0EZM
	6m9Wx4pyhkzZ23nAF7u1beUU5L2EbwNTd3x6yheZXOltOwbUXuZNruFW8fW9OocwR4iyBS8OXgt
	OJSchZbU5f0F51v+SQ88aTJPmjCqXZAk1dmG3CiFWfY6zbIkCBjBCB4yuxQUD9XdTfqa1bXYV5P
	mCN8RSwH6gYFCnyOHbWN8wA8wFZMMu87UwlLxpxyt5gB9wkVt
X-Google-Smtp-Source: AGHT+IH1XpUQhhujlkVcJvxosxXL3b/CYLfyB9yGG10dz17hxUlBflzq3AeL3+vXzHHsj1Tk4V4ZqA==
X-Received: by 2002:a05:600c:4314:b0:434:a802:e9b2 with SMTP id 5b1f17b1804b1-436eedef4damr198309295e9.4.1736961586410;
        Wed, 15 Jan 2025 09:19:46 -0800 (PST)
Received: from ?IPV6:2a02:3100:a12d:8800:31e4:b62b:fba8:4627? (dynamic-2a02-3100-a12d-8800-31e4-b62b-fba8-4627.310.pool.telefonica.de. [2a02:3100:a12d:8800:31e4:b62b:fba8:4627])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-437c753cc1fsm30648255e9.39.2025.01.15.09.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2025 09:19:45 -0800 (PST)
Message-ID: <2e76c69d-a260-4067-a054-6a5d6cd18869@gmail.com>
Date: Wed, 15 Jan 2025 18:19:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/3] net: phy: realtek: fix status when link is down
To: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1736951652.git.daniel@makrotopia.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <cover.1736951652.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.01.2025 15:43, Daniel Golle wrote:
> The .read_status method for RealTek RTL822x PHYs (both C22 and C45) has
> multilpe issues which result in reporting bogus link partner advertised
> modes as well as speed and duplex while the link is down and no cable
> is plugged in.
> 
> Example: ethtool after disconnecting a 1000M/Full capable link partner,
> now with no wire plugged:
> 
> Settings for lan1:
>     Supported ports: [ TP ]
>     Supported link modes:   10baseT/Half 10baseT/Full
>                             100baseT/Half 100baseT/Full
>                             1000baseT/Full
>                             2500baseT/Full
>     Supported pause frame use: Symmetric Receive-only
>     Supports auto-negotiation: Yes
>     Supported FEC modes: Not reported
>     Advertised link modes:  10baseT/Half 10baseT/Full
>                             100baseT/Half 100baseT/Full
>                             1000baseT/Full
>                             2500baseT/Full
>     Advertised pause frame use: Symmetric Receive-only
>     Advertised auto-negotiation: Yes
>     Advertised FEC modes: Not reported
>     Link partner advertised link modes:  1000baseT/Full
>     Link partner advertised pause frame use: No
>     Link partner advertised auto-negotiation: No
>     Link partner advertised FEC modes: Not reported
>     Speed: 1000Mb/s
>     Duplex: Full
>     Auto-negotiation: on
>     Port: Twisted Pair
>     PHYAD: 7
>     Transceiver: external
>     MDI-X: Unknown
>     Supports Wake-on: d
>     Wake-on: d
>     Link detected: no
> 
> Fix this by making sure all of the fields populated by
> rtl822x_c45_read_status() or rtl822x_read_status() get reset, also in
> case the link is down.
> 
> Daniel Golle (3):
>   net: phy: realtek: clear 1000Base-T lpa bits if link is down
>   net: phy: realtek: clear master_slave_state if link is down
>   net: phy: realtek: always clear 10gbase-t link partner advertisement
> 
>  drivers/net/phy/realtek.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
Note that the Realtek PHY driver has just been moved to its own subdirectory.
So you have to rebase your patch set.


