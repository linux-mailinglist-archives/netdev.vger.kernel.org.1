Return-Path: <netdev+bounces-148496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 867BB9E1D5C
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F8E9282D2F
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 13:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B261F12E8;
	Tue,  3 Dec 2024 13:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWcR3p7h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CD81EE024;
	Tue,  3 Dec 2024 13:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733231913; cv=none; b=Op8MJhbAJiEwzR8Xt7xO2U8wiOZa6Y5JF4ULyER28PM563Rso53ldMaOR+9AAWuTgkmEzDa2WBOKOZBERXiPxBAPh1VSdCMXiwESjLIBlWjrsk858HzeElyhlVYC0I3NvHiikkRXoN9qViPcRCe+2yED3zkwXTaKaesfyu9yRXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733231913; c=relaxed/simple;
	bh=pB2tSdh0U/0VXXziJXUn/gHy7SlMJOCjqWYTQIuIgv4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oo5wvYwT0TOr+cEKTyRvxYM8EA1WWw+kpidjr8qd8+uKXXAca4Yidwyo/Njhk5BxWSS3Cv+VH868DCuxBpw/dNEyVTuM7GkhjprEPQ9kAapKpo081tAlTSE15aGhw7DdBshg2deXSmTLeW/mKay+JKzPwhnjKT4yhrg9kbkvVGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWcR3p7h; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d0ca0f67b6so4510653a12.3;
        Tue, 03 Dec 2024 05:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733231909; x=1733836709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kxxus/9zcyh9wO8mCV8u9f3SmaylmS2FWV0Zg+5ddhk=;
        b=hWcR3p7hBEmo5E2+q0g634Iin4/guSEXxeI71JjgNE2o3tiozFZsRoMcEoEflljj2W
         ZsHBhAqsUowRkxzvHWT0EjGQo+9U6OLmpHPo7z3PhS3G27WQ3amHsckxz6dGmgEK1D5t
         QCvseOpl1G/Zzw1t3U1c3Cdhf2A6teQ/nLorMQnCMpvmvVL6qSv0qXU3DfEMjAIFoWEt
         +VK2+ljwgxKNIrP9BEDxqWAwLybjtuSogDcjpq7ykGIoAgUci32S0zVUqD0OH8yB0OyG
         mY+r2O9tMNRrkR63LrwR1YPaRy1DbX/hbVEqzEk6ZMIPbnU1KVtb0I/eBLjx/NQ8cqxX
         4+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733231909; x=1733836709;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kxxus/9zcyh9wO8mCV8u9f3SmaylmS2FWV0Zg+5ddhk=;
        b=YzrydXxSW67Xa57xJClGYqExC2pzyueCnjg5yuV5jMZmNO9ewg/ket3xPWOvCrf0Jg
         Ut+g2Y2z5brIcU4D+y0np+7ppKJ91CpvAObs+xjLSqXAySEeWhIL1nLpk9N21yjYuhjR
         YPDFAX/SXIMo8eC7ocuQnghq2ZX8aEKy/JR0hZdZzExbd2X7srxKO8ZD16RmViSzbdS/
         EX9p/51+0vAYAz778XrR3yp8e/lhZIvijLWfLgiOdslelWtEVo1mNWwQQzhWwy3Ap0+T
         U5SnN27IsklbbznNyJ9xx4r4IeyWh5dsdj4yO06PbIs5LHhqO+2dK3BBtAPMmIt+B6gJ
         urOA==
X-Forwarded-Encrypted: i=1; AJvYcCUZpRaVL7xMmg15441nzNUjrD/g9I6Iuq4xOGUc2MTZEYHzfYN8PZUtgpP+SxWIN8f2xliFeuNg@vger.kernel.org, AJvYcCXQrLkF2VEVqLMaQdVEoVfgoKv0Xsnkswc+o4v584ZeV+dvK3Vliqm+1gbdkjadSnjmEyEMZ1hPMXQrjuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YypAEfXTPEZrVJhxKzd+gIuiPa+J1S1Ufm9MplAVMfpbQjYtBY3
	CFIZ0EyzBjPruOHhX7bhcC2LZMJocD4ZkU9zxiLj+vNDFPxHeP95
X-Gm-Gg: ASbGnctAQystSJOaOj/Y2RjizYhWzmzr8og2zolIp209i3TWPcUoG1dgMg/VwPv4dua
	cdS5m8oZLW44bFDAYyowGckDGJQTKyrCFUavFcq3FpCzizgwRHS3xqqJRoZYlP3l4X5U1M0YVCu
	fAtSaT+u9p+aYZEOIWPEgm/7xBFfw/oomp7M41FNjb6KQ++jxjFsjuR2DcBJ+EUX+eDeiVuFmnD
	KHTNF10TdhOFYE70NSgfHEwg1t82P8y6bSN9pbPzt9bfs1wE4GOjPHMOi/rarCaGyMhDN395iVJ
	sDGca+RMzCZQG+uWWotIc9aHde3mNLjL1b7OQRKbDxnBYyUKn2MctfFtrhIBY4GTwsw+h+xC6uW
	HBckrFn/XdLb+ju6INbcK/C+LCppjSRgQSw4FcFY=
X-Google-Smtp-Source: AGHT+IFqEXyfy1iYnOBg1KXteFyEXlQWI0qjDLUV/+OHtxn/qkOcNSB/b1jlBBm5jy5iqgr4SOBG5w==
X-Received: by 2002:a05:6402:35d5:b0:5d0:c67e:e263 with SMTP id 4fb4d7f45d1cf-5d10cb565femr1845494a12.8.1733231909285;
        Tue, 03 Dec 2024 05:18:29 -0800 (PST)
Received: from ?IPV6:2a02:3100:9d09:7500:5db0:402d:a91:cf1f? (dynamic-2a02-3100-9d09-7500-5db0-402d-0a91-cf1f.310.pool.telefonica.de. [2a02:3100:9d09:7500:5db0:402d:a91:cf1f])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aa5996de557sm619677366b.69.2024.12.03.05.18.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 05:18:28 -0800 (PST)
Message-ID: <af9e2342-be01-41a8-9099-aeee6cbed258@gmail.com>
Date: Tue, 3 Dec 2024 14:18:27 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: realtek: disable broadcast address
 feature of rtl8211f
To: Zhiyuan Wan <kmlinuxm@gmail.com>, andrew@lunn.ch
Cc: linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, willy.liu@realtek.com
References: <20241203125430.2078090-1-kmlinuxm@gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 xsFNBF/0ZFUBEAC0eZyktSE7ZNO1SFXL6cQ4i4g6Ah3mOUIXSB4pCY5kQ6OLKHh0FlOD5/5/
 sY7IoIouzOjyFdFPnz4Bl3927ClT567hUJJ+SNaFEiJ9vadI6vZm2gcY4ExdIevYHWe1msJF
 MVE4yNwdS+UsPeCF/6CQQTzHc+n7DomE7fjJD5J1hOJjqz2XWe71fTvYXzxCFLwXXbBiqDC9
 dNqOe5odPsa4TsWZ09T33g5n2nzTJs4Zw8fCy8rLqix/raVsqr8fw5qM66MVtdmEljFaJ9N8
 /W56qGCp+H8Igk/F7CjlbWXiOlKHA25mPTmbVp7VlFsvsmMokr/imQr+0nXtmvYVaKEUwY2g
 86IU6RAOuA8E0J5bD/BeyZdMyVEtX1kT404UJZekFytJZrDZetwxM/cAH+1fMx4z751WJmxQ
 J7mIXSPuDfeJhRDt9sGM6aRVfXbZt+wBogxyXepmnlv9K4A13z9DVLdKLrYUiu9/5QEl6fgI
 kPaXlAZmJsQfoKbmPqCHVRYj1lpQtDM/2/BO6gHASflWUHzwmBVZbS/XRs64uJO8CB3+V3fa
 cIivllReueGCMsHh6/8wgPAyopXOWOxbLsZ291fmZqIR0L5Y6b2HvdFN1Xhc+YrQ8TKK+Z4R
 mJRDh0wNQ8Gm89g92/YkHji4jIWlp2fwzCcx5+lZCQ1XdqAiHQARAQABzSZIZWluZXIgS2Fs
 bHdlaXQgPGhrYWxsd2VpdDFAZ21haWwuY29tPsLBjgQTAQgAOBYhBGxfqY/yOyXjyjJehXLe
 ig9U8DoMBQJf9GRVAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHLeig9U8DoMSycQ
 AJbfg8HZEK0ljV4M8nvdaiNixWAufrcZ+SD8zhbxl8GispK4F3Yo+20Y3UoZ7FcIidJWUUJL
 axAOkpI/70YNhlqAPMsuudlAieeYZKjIv1WV5ucNZ3VJ7dC+dlVqQdAr1iD869FZXvy91KhJ
 wYulyCf+s4T9YgmLC6jLMBZghKIf1uhSd0NzjyCqYWbk2ZxByZHgunEShOhHPHswu3Am0ftt
 ePaYIHgZs+Vzwfjs8I7EuW/5/f5G9w1vibXxtGY/GXwgGGHRDjFM7RSprGOv4F5eMGh+NFUJ
 TU9N96PQYMwXVxnQfRXl8O6ffSVmFx4H9rovxWPKobLmqQL0WKLLVvA/aOHCcMKgfyKRcLah
 57vGC50Ga8oT2K1g0AhKGkyJo7lGXkMu5yEs0m9O+btqAB261/E3DRxfI1P/tvDZpLJKtq35
 dXsj6sjvhgX7VxXhY1wE54uqLLHY3UZQlmH3QF5t80MS7/KhxB1pO1Cpcmkt9hgyzH8+5org
 +9wWxGUtJWNP7CppY+qvv3SZtKJMKsxqk5coBGwNkMms56z4qfJm2PUtJQGjA65XWdzQACib
 2iaDQoBqGZfXRdPT0tC1H5kUJuOX4ll1hI/HBMEFCcO8++Bl2wcrUsAxLzGvhINVJX2DAQaF
 aNetToazkCnzubKfBOyiTqFJ0b63c5dqziAgzsFNBF/0ZFUBEADF8UEZmKDl1w/UxvjeyAeX
 kghYkY3bkK6gcIYXdLRfJw12GbvMioSguvVzASVHG8h7NbNjk1yur6AONfbUpXKSNZ0skV8V
 fG+ppbaY+zQofsSMoj5gP0amwbwvPzVqZCYJai81VobefTX2MZM2Mg/ThBVtGyzV3NeCpnBa
 8AX3s9rrX2XUoCibYotbbxx9afZYUFyflOc7kEpc9uJXIdaxS2Z6MnYLHsyVjiU6tzKCiVOU
 KJevqvzPXJmy0xaOVf7mhFSNQyJTrZpLa+tvB1DQRS08CqYtIMxRrVtC0t0LFeQGly6bOngr
 ircurWJiJKbSXVstLHgWYiq3/GmCSx/82ObeLO3PftklpRj8d+kFbrvrqBgjWtMH4WtK5uN5
 1WJ71hWJfNchKRlaJ3GWy8KolCAoGsQMovn/ZEXxrGs1ndafu47yXOpuDAozoHTBGvuSXSZo
 ythk/0EAuz5IkwkhYBT1MGIAvNSn9ivE5aRnBazugy0rTRkVggHvt3/7flFHlGVGpBHxFUwb
 /a4UjJBPtIwa4tWR8B1Ma36S8Jk456k2n1id7M0LQ+eqstmp6Y+UB+pt9NX6t0Slw1NCdYTW
 gJezWTVKF7pmTdXszXGxlc9kTrVUz04PqPjnYbv5UWuDd2eyzGjrrFOsJEi8OK2d2j4FfF++
 AzOMdW09JVqejQARAQABwsF2BBgBCAAgFiEEbF+pj/I7JePKMl6Fct6KD1TwOgwFAl/0ZFUC
 GwwACgkQct6KD1TwOgxUfg//eAoYc0Vm4NrxymfcY30UjHVD0LgSvU8kUmXxil3qhFPS7KA+
 y7tgcKLHOkZkXMX5MLFcS9+SmrAjSBBV8omKoHNo+kfFx/dUAtz0lot8wNGmWb+NcHeKM1eb
 nwUMOEa1uDdfZeKef/U/2uHBceY7Gc6zPZPWgXghEyQMTH2UhLgeam8yglyO+A6RXCh+s6ak
 Wje7Vo1wGK4eYxp6pwMPJXLMsI0ii/2k3YPEJPv+yJf90MbYyQSbkTwZhrsokjQEaIfjrIk3
 rQRjTve/J62WIO28IbY/mENuGgWehRlTAbhC4BLTZ5uYS0YMQCR7v9UGMWdNWXFyrOB6PjSu
 Trn9MsPoUc8qI72mVpxEXQDLlrd2ijEWm7Nrf52YMD7hL6rXXuis7R6zY8WnnBhW0uCfhajx
 q+KuARXC0sDLztcjaS3ayXonpoCPZep2Bd5xqE4Ln8/COCslP7E92W1uf1EcdXXIrx1acg21
 H/0Z53okMykVs3a8tECPHIxnre2UxKdTbCEkjkR4V6JyplTS47oWMw3zyI7zkaadfzVFBxk2
 lo/Tny+FX1Azea3Ce7oOnRUEZtWSsUidtIjmL8YUQFZYm+JUIgfRmSpMFq8JP4VH43GXpB/S
 OCrl+/xujzvoUBFV/cHKjEQYBxo+MaiQa1U54ykM2W4DnHb1UiEf5xDkFd4=
In-Reply-To: <20241203125430.2078090-1-kmlinuxm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03.12.2024 13:54, Zhiyuan Wan wrote:
> This feature is automatically enabled after a reset of this
> transceiver. When this feature is enabled, the phy not only
> responds to the configured PHY address by pin states on board,
> but also responds to address 0, the optional broadcast address
> of the MDIO bus.
> 
> But some MDIO device like mt7530 switch chip (integrated in mt7621
> SoC), also use address 0 to configure a specific port, when use
> mt7530 and rtl8211f together, it usually causes address conflict,
> leads to the port of rtl8211f stops working.
> 
> This patch disables broadcast address feature of rtl8211f, and
> returns -ENODEV if using broadcast address (0) as phy address.
> 
> Hardware design hint:
> This PHY only support address 1-7, and DO NOT tie all PHYAD pins
> ground when you connect more than one PHY on a MDIO bus.
> If you do that, this PHY will automatically take the first address
> appeared on the MDIO bus as it's address, causing address conflict.
> 
> Signed-off-by: Zhiyuan Wan <kmlinuxm@gmail.com>
> ---
>  drivers/net/phy/realtek.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> index f65d7f1f3..0ef636d7b 100644
> --- a/drivers/net/phy/realtek.c
> +++ b/drivers/net/phy/realtek.c
> @@ -31,6 +31,7 @@
>  #define RTL8211F_PHYCR1				0x18
>  #define RTL8211F_PHYCR2				0x19
>  #define RTL8211F_INSR				0x1d
> +#define RTL8211F_PHYAD0_EN			BIT(13)
>  
>  #define RTL8211F_LEDCR				0x10
>  #define RTL8211F_LEDCR_MODE			BIT(15)
> @@ -139,6 +140,17 @@ static int rtl821x_probe(struct phy_device *phydev)
>  		return dev_err_probe(dev, PTR_ERR(priv->clk),
>  				     "failed to get phy clock\n");
>  
> +	dev_dbg(dev, "disabling MDIO address 0 for this phy");
> +	ret = phy_modify_paged(phydev, 0xa43, RTL8211F_PHYCR1,
> +				       RTL8211F_PHYAD0_EN, 0);
> +	if (ret < 0) {
> +		return dev_err_probe(dev, PTR_ERR(ret),

Why PTR_ERR()? Did you even compile-test?

> +				     "disabling MDIO address 0 failed\n");
> +	}
> +	/* Deny broadcast address as PHY address */
> +	if (phydev->mdio.addr == 0)
> +		return -ENODEV;
> +
>  	ret = phy_read_paged(phydev, 0xa43, RTL8211F_PHYCR1);
>  	if (ret < 0)
>  		return ret;

And more formal hints:
- If you send a new version of a patch, annotate it accordingly.
- Allow 24h before sending a new version
- Include a change log

https://docs.kernel.org/process/submitting-patches.html
https://www.kernel.org/doc/html/v6.1/process/maintainer-netdev.html


