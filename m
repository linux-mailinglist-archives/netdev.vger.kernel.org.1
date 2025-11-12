Return-Path: <netdev+bounces-238129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A02C54730
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 21:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1B676349F16
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 20:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0403529ACD7;
	Wed, 12 Nov 2025 20:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtvujWCa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF7C290F
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 20:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762979288; cv=none; b=BsAnBQQWujSAicfqvTgG7kGttLJwk6Y53pfvbs7s25xph6Pd8f0JZ1Xu1FsZcNgTJCs0WwUP7ssGuXUanSrr/xY4o77f195khOCWZ8R7zh7bbjPO2nANQXg8mR3lmzsRhdU65+cjJhCyEuy3XEyunD+0s34d4PxRmm6gYdigyT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762979288; c=relaxed/simple;
	bh=i+qrJKd5GwqsNPtCvHrfbk/z+JDpoHaiC7DwuG62xA8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CBvK2C3NYGCbKr+Eb0jsjsPHq9LbITeOGQv0w0Nap409CB32vP0mLKSmVlFsfAOExKm8On+xKTnofMuuVhNVk7YOb3+8C0akf89n7noEgZ+RsDZptwfhDWTYzoqgqks4UcHEDssXU0h2pP/up8GPeIkA+WcfwA9F8wlxg6sDc6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtvujWCa; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b3c965ca9so51008f8f.1
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 12:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762979284; x=1763584084; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/1znxgw+VJKsyrPNvtyAbxwzu6c70w6nckL1EyaMxRA=;
        b=AtvujWCajDvligcZAUdap4Kux5V+0lv+T1IIKeeyaViKmmRhKqOcFr/8rEZwsG1z2p
         YHjVZU44lyRN8hRAx6D1f6MbWUlsK+ZZ5uyZlDTCZMEh/GmPgPlNEAkTVy3aHLD5kENh
         B/r/4zxv7V9FPt8DDbetwVuMl5DYNPeudv8GDeukH1DzhWowVuiWROMO+6ooReHhF5pP
         xbjA0YXUZrqqTGB0zTYPdWjadCJR57PUn0X6vzhHSNjyLdWE3ZoXLjq+Bjljya5zxmkT
         09pX+IjKBqUEvGY4TxavUn6QEF/N209zEC0Wz/cDc4issPA/MvyMot17qcUuFJaZHWPX
         qdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762979284; x=1763584084;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/1znxgw+VJKsyrPNvtyAbxwzu6c70w6nckL1EyaMxRA=;
        b=xH73O0hkqGWlgbjBMyCzYMzU0mDidb8oaHJ8R012PpTRlaH6IrYz/+L8Q9JrS2HUHM
         IstkMBE5OlShIaK7qDy/cygpjakusGOjtQMwsd1XIx5va2inNtvdZA/+O8Nos1mj6y38
         16XBZOgYksUZisNLoZjU+yPqLPwjryhBpUgdBOEvPL/QFG60nQieTiFbG8Mtfex2iC1c
         mcaxijU6l4vBWSBTcrXPMKMZ+TVtYnXBNc5Y2BR1iQh5JgHMRz34T0wJAJ7sJ5yMQ+SC
         /g8CtwjVY32oq43f+j1i1Kk/aXeNiomQEabJ69LsmpAVYLLEchuwuiJWspyvaql+pMWT
         gZDw==
X-Gm-Message-State: AOJu0YzlH64azBPG9mrk2NJjNuU7CAXFoZK2/sf03ZMjc63ZvBaYZ1dH
	Vnui/74jhYwcEriRYg9pTgNlVBiPDPQY+d0h+BiwQIOFUs/MXXjV9iEc
X-Gm-Gg: ASbGnct2a/v2jpg1DvRlsFTVpOznnYusvo8E4Ns3sVaqJVhbk5okFN42NbBhEd0PDFl
	F/SuUQiUNNjgQX/yfKNqz1XCoVlSNJTuFHtyRHyI2uTWF3A7cx1kB4YyJGFOsfOi1SRP1JAp9/W
	X+/2gCpN5x2S84uhkNYacYevXnomK/YYkE2mF2uHronHoeQ047PhxWANFOjHDLidyGzQdJRGZpo
	Cz2ON2q1ALj3ZZuNS19ot+Dg6727mP/OSdQIyWAUnRnyUkGZSchQ54Xm6ovZd/cUaFOMhG+Lo45
	z3XTKzbZdBEfKFceS10BaMNPujtSCgPorXglPP0kN8i2PAH/AN7Tq4sOmtUSknncVppDEEq0gNT
	BaWo2sIYzLRIvwp9aKwiypMqnwvRuLtCCiiSK4KQboABgSqqtV4REdDXyCvGPS4U0rkoS61UR2w
	y+VPRPBC9RSRE2j3zDf7t5xp70bpnUjTe5AfzmuqeytYxKrtfWWxSepR8frg659vf3HyQ0Vd0Jr
	vWEuoUP7Dc+eGPZJYtwbe9xos2WH/HiC0g1hKfBKcE=
X-Google-Smtp-Source: AGHT+IH2IEB8eZJepiyBR5s/YNBMx+r71ld8CYJU8TBuwnTgvgBxzat3EQGEstL3Y7mSduN7QqvGWw==
X-Received: by 2002:a05:6000:420b:b0:426:eef2:fa86 with SMTP id ffacd0b85a97d-42b4bb8b9fcmr3855739f8f.11.1762979284164;
        Wed, 12 Nov 2025 12:28:04 -0800 (PST)
Received: from ?IPV6:2003:ea:8f26:f700:b18b:e3d1:83c0:fb24? (p200300ea8f26f700b18be3d183c0fb24.dip0.t-ipconnect.de. [2003:ea:8f26:f700:b18b:e3d1:83c0:fb24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b3123036bsm28168151f8f.28.2025.11.12.12.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 12:28:03 -0800 (PST)
Message-ID: <f3ae628b-4cbd-4075-8e59-7e3d7ee872cf@gmail.com>
Date: Wed, 12 Nov 2025 21:28:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: fixed_phy: use genphy_read_abilities
 to simplify the code
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <ed9eb89b-8205-4ca3-9182-d7e091972846@gmail.com>
Content-Language: en-US
In-Reply-To: <ed9eb89b-8205-4ca3-9182-d7e091972846@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/2025 10:11 PM, Heiner Kallweit wrote:
> Populating phy->supported can be achieved easier by using
> genphy_read_abilities().
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/phy/fixed_phy.c | 23 +----------------------
>  1 file changed, 1 insertion(+), 22 deletions(-)
> 
> diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
> index 2e46b7aa6..32a9b99af 100644
> --- a/drivers/net/phy/fixed_phy.c
> +++ b/drivers/net/phy/fixed_phy.c
> @@ -18,7 +18,6 @@
>  #include <linux/of.h>
>  #include <linux/idr.h>
>  #include <linux/netdevice.h>
> -#include <linux/linkmode.h>
>  
>  #include "swphy.h"
>  
> @@ -157,27 +156,7 @@ struct phy_device *fixed_phy_register(const struct fixed_phy_status *status,
>  	phy->mdio.dev.of_node = np;
>  	phy->is_pseudo_fixed_link = true;
>  
> -	switch (status->speed) {
> -	case SPEED_1000:
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
> -				 phy->supported);
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> -				 phy->supported);
> -		fallthrough;
> -	case SPEED_100:
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT,
> -				 phy->supported);
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> -				 phy->supported);
> -		fallthrough;
> -	case SPEED_10:
> -	default:
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT,
> -				 phy->supported);
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT,
> -				 phy->supported);
> -	}
> -
> +	genphy_read_abilities(phy);
>  	phy_advertise_supported(phy);
>  
>  	ret = phy_device_register(phy);

After further checking, this code can be removed altogether.

--
pw-bot: cr

