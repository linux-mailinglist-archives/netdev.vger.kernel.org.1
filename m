Return-Path: <netdev+bounces-179110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F38A7A998
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 20:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2F2E188636E
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 18:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5EFB250C06;
	Thu,  3 Apr 2025 18:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmhmupSE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DC31DA5F;
	Thu,  3 Apr 2025 18:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743705487; cv=none; b=rvglYYviQappk62M9gmfq91N90rak1i0MpM9hFS+CYfmwjyiHNCppjbT4kOt3kYfs3/pbiicrY98bR7cMgN2ChsMLX/LkTkx3/P0j4FqM9rY0w3+RpC45k39wTtEE/H7r/krFsqAElVOHZ6qQBuhUdkhvzXwT2JZJHN7RTrQsCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743705487; c=relaxed/simple;
	bh=etqrvu6eqFXhJg9zVqWNF1ht4ENkca557JVME6Zz5eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nPekOxRKf/h/t4W4BWHBAgJN1RpNGQsyQ5SKO/78FM6OyCQNgScE9i5DTzQB3uZPgdbCbaZHjozgPIh+f9W0m4jcD3X4fOu/G8QAJ283bFZOnFDT8UhZN7Fxo/yG8ylxBpTtQzc0//f+UpVpEbWmWaSszMabU+WN+QMLSr8dChM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmhmupSE; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-60219a77334so623604eaf.1;
        Thu, 03 Apr 2025 11:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743705484; x=1744310284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4L3ln2jeTwthCguk4absdUq2mPo9WJoclx7MaUiCztw=;
        b=KmhmupSEGSVDR4oGwWcvMXum2di9gapWDurd40RIJ3rISFy85x/Ewxt9wAQKOMwcJp
         9oKgMY1MYHcllo05LRH+tHQTZ4FwwiSCWOENF+L5mEorNwuK7+dxxg1pEZvVd/SJ8uCj
         6MaF1yhzrKTrHgBqWqVvO+lhxL97TyPETOW8JvPqzpdZtQSPN9onUq+I69y2ADDrfwxW
         AD8/ECz3Xum+HlO+o8UafngCURD8z5NVHNWSpx79bqwTvczqTfzsvSHnNy6wIZuvkCPc
         nUhkmdJSKlri7uvfu+R0MGrAyVfSODOKhA0bBn+MBtx57tdfXQjt6pUnM5bnJZGeWrr8
         HXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743705484; x=1744310284;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4L3ln2jeTwthCguk4absdUq2mPo9WJoclx7MaUiCztw=;
        b=sGn/aXrZnpYqpKSDk3EKCHy2eNd+p755FUZRpGUjk3IlIIn9VJ/Ag8sQx7jWxDIH01
         vDsVz/juPM8k8ClE0NzU6vVXap7DY8lwZBUDGjSXa6WVIlsFxK2TbKdd8569jqEWLyzG
         DjisktYUfxtzCZ06UyQMjjJp5mfnHMkCK9GDIuUq/3/NAMSYZMlL68Hwxcog/p8hyqdV
         WRc+bH/aavEwNHDPffTEV77+/0Hn1SSn+UVV2OrSoyulvQeVEMzOikYoXRR7wMkF5Zet
         RAB1nuEbxUL4BAsYKhsXDZQhpVzb5ZaJCjDX0cnvkEJ2WXYJrKqAaIqtsRjzndikx8H4
         qDpw==
X-Forwarded-Encrypted: i=1; AJvYcCVJUsA2DsR36pDTn6aI4WXeliTrDebylqVwqVoQr/lU7a5q/yT17wcc2qkPhPow1UC/S88Zo+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgNTTY9sZcfc0LHqPshhIqLNEJvadqM9ktxbQUsVDRfFfBdyyD
	mOwt1jluzu83XWc8/hQXVC2oXlWY8JaiuCHWJAHzB+S6YIU5DMoknFRf2A==
X-Gm-Gg: ASbGncs+kw4b3liFbZGowQ6zk+eF7yqmnruF75A8iPJTNBdRKOTuhZNb5UfEk92XyNQ
	5gKgNPD5L9wsSbyC+eG5vMp5G8HAy7NRJ5X+0GvTZ3Cim7EAyF9LFRSbSW59eU8gYSL0f+wRLr9
	Zl80uRdnuTcx9j+OhvapSwercsbT/4xwcWgbsa3emsoTqHHvHtkmya52c2FfCEvMo1/gotRhGR+
	bbSl6KkBoREWQ7uX6prakJCZxueOFMo585W/L5AddKuSJusI0druibHhwcutDnjjHNJ68I4qLIM
	KpINK1NGT4ruU5lgJXfV0FnUjexK6XFD5HmkIUqbBKtIoiF1iJXlXxdCdR5EbR1iO48x6ahB
X-Google-Smtp-Source: AGHT+IGfWKBnS43OmkokpsQ/SDRgnDZNViE25/7bxtxC9l8m55KQzQc/PD+cDo2YWk0pIWeXkXyODw==
X-Received: by 2002:a05:6871:6083:b0:2c8:33ab:e80e with SMTP id 586e51a60fabf-2cca19d74b7mr16501fac.19.1743705484188;
        Thu, 03 Apr 2025 11:38:04 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72e305b66fcsm331037a34.65.2025.04.03.11.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 11:38:02 -0700 (PDT)
Message-ID: <0e2a50d9-ee7c-4c15-8c31-a42fff1522e6@gmail.com>
Date: Thu, 3 Apr 2025 11:37:58 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next PATCH 06/13] net: phy: Export some functions
To: Sean Anderson <sean.anderson@linux.dev>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>
Cc: linux-kernel@vger.kernel.org, Christian Marangi <ansuelsmth@gmail.com>,
 upstream@airoha.com, Heiner Kallweit <hkallweit1@gmail.com>
References: <20250403181907.1947517-1-sean.anderson@linux.dev>
 <20250403181907.1947517-7-sean.anderson@linux.dev>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250403181907.1947517-7-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/25 11:19, Sean Anderson wrote:
> Export a few functions so they can be used outside the phy subsystem:
> 
> get_phy_c22_id is useful when probing MDIO devices which present a
> phy-like interface despite not using the Linux ethernet phy subsystem.
> 
> mdio_device_bus_match is useful when creating MDIO devices manually
> (e.g. on non-devicetree platforms).
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
>   drivers/net/phy/mdio_device.c | 1 +
>   drivers/net/phy/phy_device.c  | 3 ++-
>   include/linux/phy.h           | 1 +
>   3 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
> index e747ee63c665..cce3f405d1a4 100644
> --- a/drivers/net/phy/mdio_device.c
> +++ b/drivers/net/phy/mdio_device.c
> @@ -45,6 +45,7 @@ int mdio_device_bus_match(struct device *dev, const struct device_driver *drv)
>   
>   	return strcmp(mdiodev->modalias, drv->name) == 0;
>   }
> +EXPORT_SYMBOL_GPL(mdio_device_bus_match);
>   
>   struct mdio_device *mdio_device_create(struct mii_bus *bus, int addr)
>   {
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 675fbd225378..45d8bc13eb64 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -859,7 +859,7 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr,
>    * valid, %-EIO on bus access error, or %-ENODEV if no device responds
>    * or invalid ID.
>    */
> -static int get_phy_c22_id(struct mii_bus *bus, int addr, u32 *phy_id)
> +int get_phy_c22_id(struct mii_bus *bus, int addr, u32 *phy_id)
>   {
>   	int phy_reg;
>   
> @@ -887,6 +887,7 @@ static int get_phy_c22_id(struct mii_bus *bus, int addr, u32 *phy_id)
>   
>   	return 0;
>   }
> +EXPORT_SYMBOL_GPL(get_phy_c22_id);
>   
>   /* Extract the phy ID from the compatible string of the form
>    * ethernet-phy-idAAAA.BBBB.
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index a2bfae80c449..c648f1699c5c 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -1754,6 +1754,7 @@ struct phy_device *phy_device_create(struct mii_bus *bus, int addr, u32 phy_id,
>   				     bool is_c45,
>   				     struct phy_c45_device_ids *c45_ids);
>   #if IS_ENABLED(CONFIG_PHYLIB)
> +int get_phy_c22_id(struct mii_bus *bus, int addr, u32 *phy_id);

Seems like you will need to provide an empty inline stub for when 
CONFIG_PHYLIB=n?
-- 
Florian

