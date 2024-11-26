Return-Path: <netdev+bounces-147506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6DD9D9E5E
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 21:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 577141644F8
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 20:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20CF1DE880;
	Tue, 26 Nov 2024 20:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIDWEWDX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D884A1DE2D3
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 20:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732652385; cv=none; b=b0cGaSAoc2t+ltjjeMwh67adzTtvNIuLi0QGTq+9U8t2mmR7R+XK9jTJOl1scPaWFLx7p5cVMdvYVBxqckj4rl8uFtNvd1PoLKcgTVzyFhGvTd9UpiKrJDcU68lNTrYPQSNwIo1r5M5agOhH7kZldeBMScvcsA/vHwjm40eAKa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732652385; c=relaxed/simple;
	bh=z74amAUWB1PrCjxQ9NA1lFyHx/fno7XJH0a2IcsTCEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QWlxEKnXm9wNh4ABP2jIrUUtHhQkGdy7D+vNCJpGBkSTqy8dxanHe8j2zxSOqyjVqRRdn6K7fRBKdFIfZ0d157BlElzBi10QWN9zH4Zyy4MnAoVzWEkkIinmDY/OyFpkqPMzADnX26rGX+eLgxkEPhB7rV5kCz1bnCk7V0BL954=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIDWEWDX; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa5366d3b47so461702366b.0
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 12:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732652382; x=1733257182; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bIdOM98L3EBQwsq5FQMMGgLWqa/7d6Lq3LNh7wTZfHQ=;
        b=kIDWEWDX4wiTxxWqGT8+HoGUmF9YepQliAuPV8yw6aHsebR+tA6YuUnokthtPILbge
         S7Mim0BLyhci4tCH5wA0DJ7ta+c0kK6qk/vtBnFgfbBbNhZyUheYZ7KpovpqU8JoDop2
         nGm8cC5OTWkbsqcO0vZLBPL1ly1JjoVKKRqkN95EEIPLqDdAAliKtskUj10OcwIRpHNC
         FweyFaLrE6/QkH/nxTOH3kQWfEDxt+prXFvdIN2aI+3EO3qg5/8TjzlnnM1TNMKKf+yD
         LtqXGwW4izwfZ+3wRD0BzxD/uFEFYUaTl2A5YAQEiI0Z6C+4LXE0QpZJCU9zLosySvvW
         oiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732652382; x=1733257182;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIdOM98L3EBQwsq5FQMMGgLWqa/7d6Lq3LNh7wTZfHQ=;
        b=dblGnAOioAr0YUQsPJtU9ZEiErx996f1bWDpp+xKk/RPeM17XSVpEkbQ32xBHZMhGt
         nLvwUhi3BTsLwoSvf/50PkbmcHt3X0cEJrP+0Boz+x3yN4hHroRXtpgFJxXSQb13Tddz
         lLyUsuSOB+1qmYcAIW6YDd5F0WCNk7e67ylGuGQJPWNWqI4LrFlJkFYZJYb+ZP6UEraq
         tFH/0umImeQsiJ/oq5c9IzDvFfQJR+vD7I4/EBj3CvAgGscQjz3J1MW5QetV3wK1quEe
         5nA90cr+Rrrp6NDstgKLhIUHlJHGP1aGGDGG+Ez3kXs8BqfcKEvo3cfM6pPswePrOeaH
         EouQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6HLShY/4n0H5ozXJzaAMhTHL3U7eXN6dQ+8HdKv+8t/tvRDH7N/mv39hGrf4+xcU5lnUWcbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrkA2lnc9Ht/cWKncQIG7iQ32nuCXPtIaoyJf0o3sjevwXwsfC
	aKfRjHZwTOrAYPsV7QUjvMzI2KaIqndkLSmvMjb0EhpL4Zvd1lAT
X-Gm-Gg: ASbGnctdNfz3NpZMLcdIXKwTKJwEvczmjT5uN4GT+/zGpNIheFlxsimZ5izbIdlYtZY
	mXnY9MRb33sdjI3P2OFoBPPlrqB5rD6Dz8N5/gFSWzzLHzzMpzJpdSnPuThVOBeyL0yyrsjv0Xk
	p0fT4E0n2v7atrbmAtsFyyI1iZ+KgY//kq6SlM0b0Pr868lTZq4EhrNuhfZfz6EE4Xuzc0HCHyP
	blxD3MMqNqYkJYM7Lr5VuMmaqxk+Ivetowx9wrLbYKDcINCSc95Qo6VyguMpx/on6z1GIVfwEcj
	vsbyJ7/O6SOH4R9s2zRTXzFYZNUq3NzmFr1E3sNpd5qWAB128DZO1odfbCPSvsG/0jELLTCL0qx
	yfh3dHVemKMdmEpHRffCz+PFInKfnWKLzrrUn1a5R4g==
X-Google-Smtp-Source: AGHT+IFJzXI+QGnug04VkzBBZH3/3gOfiit7iwiUpCdN3K1kV7d0P626vyqQmw6ZO1DajOX9UOmxZw==
X-Received: by 2002:a17:907:6ea6:b0:aa5:4c3a:3b55 with SMTP id a640c23a62f3a-aa580f5814amr26638366b.36.1732652381959;
        Tue, 26 Nov 2024 12:19:41 -0800 (PST)
Received: from ?IPV6:2a02:3100:b1b1:7000:f43f:954d:8ddd:f91b? (dynamic-2a02-3100-b1b1-7000-f43f-954d-8ddd-f91b.310.pool.telefonica.de. [2a02:3100:b1b1:7000:f43f:954d:8ddd:f91b])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aa50b3000e6sm628933066b.80.2024.11.26.12.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 12:19:40 -0800 (PST)
Message-ID: <fd994907-0d37-41a6-87fe-1064543bf9fc@gmail.com>
Date: Tue, 26 Nov 2024 21:19:39 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 03/23] net: phy: marvell: use
 phydev->eee_cfg.eee_enabled
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Bryan Whitehead <bryan.whitehead@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Oleksij Rempel <o.rempel@pengutronix.de>, Paolo Abeni <pabeni@redhat.com>,
 UNGLinuxDriver@microchip.com
References: <Z0XEWGqLJ8okNSIr@shell.armlinux.org.uk>
 <E1tFv3K-005yhZ-E8@rmk-PC.armlinux.org.uk>
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
In-Reply-To: <E1tFv3K-005yhZ-E8@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26.11.2024 13:52, Russell King (Oracle) wrote:
> Rather than calling genphy_c45_ethtool_get_eee() to retrieve whether
> EEE is enabled, use the value stored in the phy_device eee_cfg
> structure.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/phy/marvell.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
> index cd50cd6a7f75..1d117fa8c564 100644
> --- a/drivers/net/phy/marvell.c
> +++ b/drivers/net/phy/marvell.c
> @@ -1508,7 +1508,6 @@ static int m88e1540_get_fld(struct phy_device *phydev, u8 *msecs)
>  
>  static int m88e1540_set_fld(struct phy_device *phydev, const u8 *msecs)
>  {
> -	struct ethtool_keee eee;
>  	int val, ret;
>  
>  	if (*msecs == ETHTOOL_PHY_FAST_LINK_DOWN_OFF)
> @@ -1518,8 +1517,7 @@ static int m88e1540_set_fld(struct phy_device *phydev, const u8 *msecs)
>  	/* According to the Marvell data sheet EEE must be disabled for
>  	 * Fast Link Down detection to work properly
>  	 */
> -	ret = genphy_c45_ethtool_get_eee(phydev, &eee);
> -	if (!ret && eee.eee_enabled) {
> +	if (phydev->eee_cfg.eee_enabled) {
>  		phydev_warn(phydev, "Fast Link Down detection requires EEE to be disabled!\n");
>  		return -EBUSY;
>  	}

This one I had on my list too. Old and new check aren't waterproof as the user can still
enable EEE later, silently disabling FLD. But the check is better than nothing.

Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>


