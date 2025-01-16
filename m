Return-Path: <netdev+bounces-158825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BDDA136AD
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 10:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3104B1889C53
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 09:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0211DC9AD;
	Thu, 16 Jan 2025 09:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fvunAFni"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB411D90D9
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737019988; cv=none; b=S6UOMGyFT8VJtklwiZUOZ127+54QTR18v4tvK7CpmXg7BXADxxqo1U1chxiOwf53bLxlHf/eSOTt9F4mUl5yHsvgEgbiV+uYaASouKsv37tAT+/rE/Zl0f/+odxMTQ6eFLPqkv3q/uEkTIlQ0/2HdIOwIQSIDZttrNCnywqb4Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737019988; c=relaxed/simple;
	bh=29T95yXiVLPU5tu+O6sppTn5MDLD8y6Ai8fyQ2pgGhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dIdJIrnADxFjxLhcJ5HM93A5zPrguL2jgT55/UUxQzLcgTTYMEs2l8UR0vsLxcL4yN9Mk0M6a1LSfuvg5chY1INXqkrihQAlGcoyaWkBHYxr3NySTj26HVUAKbs3IlWfS0SxD77uWwWf1hmFlcjpUuxSAhF1+eEs7f06CYuOopc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fvunAFni; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737019985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=watVvtbZuBC3aoJqntqzXkKeLbDyxbUKeyqqbvNF8aM=;
	b=fvunAFniwEzUkRy4xmdHOITptUpFmiasX9eu/1SJ1dsztM82dPTBoiMk6tsvGe4dSCJmB7
	g1UaNAg12ndTEpn6nke6SoaZ8Yp41oyvl59hMuWc7PJwWx2cWRTZZKET3pFiAEGBnKqUzY
	Yr/G6OXKfqIGiqjpizjkOoE3QDuXmGs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-uTCbzHtXO6mtY-Xtt36iCg-1; Thu, 16 Jan 2025 04:33:01 -0500
X-MC-Unique: uTCbzHtXO6mtY-Xtt36iCg-1
X-Mimecast-MFC-AGG-ID: uTCbzHtXO6mtY-Xtt36iCg
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3862be3bfc9so421518f8f.3
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 01:33:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737019980; x=1737624780;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=watVvtbZuBC3aoJqntqzXkKeLbDyxbUKeyqqbvNF8aM=;
        b=T8vQBsiYtpO7/YGtGD1UC8Ch5yrqC9AzlUwroLOeVCpqpPO9OSy7o6xKm43VIkqcbE
         lMP60NOyoaGGBc1PfrfE1rwk9XaCoojWOxhbWywlYHqkbdh7sdIauuqBQfOgjJ5Sgbt2
         06s3jdA3wNadAR9WPe9vSN3Y32AvWUAo+z+zJO770OcL3i3J4FX263Z60v/ROOZopXtj
         DkGA54pB1CF2xacGDoCxLkJITmdMaHu3LhXN8XIK01eEcZ92Q+Ve/c8xXs8UJ9cE/oXW
         uyH8vo+6zKwoC0T5zj3tcOAr0Gv2x/P6crNDuPzKrtyryBzYuLQfLhcXogz4AfSCaIpq
         kjIg==
X-Forwarded-Encrypted: i=1; AJvYcCVDj/r/sG04LAcD0flE9QglSW7qj1ncXXWG8Ga2sYvcdrGpK+ENlRlUXTsXz0cMS+2duSLQNq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzjWkqPC0MeJGM+eCn+fwLv+VPR1vlDNysLSbwpHj+9nU6akCc
	wrWM3LUEDN81+LL5Boo516PwaJve7ZjtJTu6WPg4OP9CJtM2BR6O3Jvoiby4GAznsMgN9tGvHlI
	5gXP4+4DQlCHkfFw5OnYw72FJfSF+zNnWOz8+q35BBuo5H5taAAZin5mEHc6V8A==
X-Gm-Gg: ASbGncvAVJgKYmLcqPXnm96t7upHvxgz0TIrbDknHQOuuEYPGer2mDyzyGxg2rzGiU3
	OjaNOq6+aGjyNXP0lCZp3hZOFmAQDT7gG//y8gF2OvyK5sXjywG+aiPtL47ofMHnh+1yreFUNYq
	WyJWTPYI6zeUwgb+oG3Z8O2Bq7X3wn3vT4ZdsZO5Y2kSiON8xIybaKEC6mvCDSw2ijQixK7NB/w
	RGYSyX/P/jjFa+sb8WvSWCjAckYlOFT5lpvgn7euySCL57Dw6KGKKYTPFMN2B9813scpTrh7/Wn
	hpozC1/L3po=
X-Received: by 2002:a5d:64e9:0:b0:385:f7d2:7e29 with SMTP id ffacd0b85a97d-38a87304221mr31579605f8f.15.1737019980261;
        Thu, 16 Jan 2025 01:33:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8iEZL6HX7r7uVsWSRV5f1pdiPneCTDuEfM71Vc5/63jrcpNd1IPw/aOB2HPWVqsDu5ORGbQ==
X-Received: by 2002:a5d:64e9:0:b0:385:f7d2:7e29 with SMTP id ffacd0b85a97d-38a87304221mr31579567f8f.15.1737019979916;
        Thu, 16 Jan 2025 01:32:59 -0800 (PST)
Received: from [192.168.88.253] (146-241-15-169.dyn.eolo.it. [146.241.15.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a9407fd62sm18263992f8f.92.2025.01.16.01.32.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 01:32:59 -0800 (PST)
Message-ID: <32b6985e-3897-4317-bdf7-d78ffe89c38d@redhat.com>
Date: Thu, 16 Jan 2025 10:32:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH 1/2] net: dsa: microchip: Add emulated MIIM
 access to switch LED config registers
To: Marek Vasut <marex@denx.de>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Tristram Ha <tristram.ha@microchip.com>, UNGLinuxDriver@microchip.com,
 Vladimir Oltean <olteanv@gmail.com>, Woojung Huh
 <woojung.huh@microchip.com>, linux-kernel@vger.kernel.org
References: <20250113001543.296510-1-marex@denx.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250113001543.296510-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/25 1:15 AM, Marek Vasut wrote:
> The KSZ87xx switch DSA driver binds a simplified KSZ8795 switch PHY driver to
> each port. The KSZ8795 switch PHY driver is part of drivers/net/phy/micrel.c
> and uses generic PHY register accessors to access MIIM registers 0x00..0x05,
> 0x1d and 0x1f . The MII access is implemented by the KSZ87xx switch DSA driver
> and internally done over whichever interface the KSZ87xx switch is connected
> to the SoC.
> 
> In order to configure LEDs from the KSZ8795 switch PHY driver, it is necessary
> to expose the LED control registers to the PHY driver, however, the LED control
> registers are not part of the MIIM block, they are in Switch Config Registers
> block.
> 
> This preparatory patch exposes the LED control bits in those Switch Config
> Registers by mapping them at high addresses in the MIIM space, so the PHY
> driver can access those registers and surely not collide with the existing
> MIIM block registers. The two registers which are exposed are the global
> Register 11 (0x0B): Global Control 9 as MIIM block register 0x0b00 and
> port specific Register 29/45/61 (0x1D/0x2D/0x3D): Port 1/2/3 Control 10
> as MIIM block register 0x0d00 . The access to those registers is further
> restricted only to the LED configuration bits to prevent the PHY driver
> or userspace tools like 'phytool' from tampering with any other switch
> configuration through this interface.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Tristram Ha <tristram.ha@microchip.com>
> Cc: UNGLinuxDriver@microchip.com
> Cc: Vladimir Oltean <olteanv@gmail.com>
> Cc: Woojung Huh <woojung.huh@microchip.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: netdev@vger.kernel.org
> ---
>  drivers/net/dsa/microchip/ksz8.c | 47 ++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
> index da7110d675583..9698bf53378af 100644
> --- a/drivers/net/dsa/microchip/ksz8.c
> +++ b/drivers/net/dsa/microchip/ksz8.c
> @@ -1044,6 +1044,22 @@ int ksz8_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val)
>  			return ret;
>  
>  		break;
> +	/* Emulated access to Register 11 (0x0B): Global Control 9 */
> +	case (REG_SW_CTRL_9 << 8):

I think it's better to add a macro for the new registers

> +		ret = ksz_read8(dev, REG_SW_CTRL_9, &val1);
> +		if (ret)
> +			return ret;
> +
> +		data = val1 & 0x30;	/* LED Mode */

In a similar way, it's better to add meaningful macros for the relevant
register fields. You should consider using the *FIELD*() helpers, too.

/P


