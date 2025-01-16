Return-Path: <netdev+bounces-158835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C88A1372D
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 10:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 070BC1885E95
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 09:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911FE1DD0C7;
	Thu, 16 Jan 2025 09:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8+W1kNS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CF51DC997
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 09:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737021531; cv=none; b=bJkeGHPjGFK+KYpgDMnUa2hQvtlMBoQqgOMI2fLsf4AjA6hHwoSFKn0GUun6tFfOMT5ehwRCBtQQsqegLgtjgzoeklM0vDpyM85oESAmP5AvGLonnG9TPNDTkrq9TT5edaUxnu26NmtJd2DvRoUsfkh3t6JMfdH6IPpOLKxh+To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737021531; c=relaxed/simple;
	bh=Cyqv1j8F6DMV6z1elEYYVjcaLdtyX62sDpAusHZ4VIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TmrrIa97WIQzCh0oU4TLm40tRjjBAS9Cu+LSfBzpc+XpjisC36iJ8m7dKhAKkF7rfl5qBnG1i6drj5RolLR+tw6k3yuqF0hOW2wSjYCvNW3TVJUaM7wXtG3GHlD23mCMSPGKB99QE+A2NpX8V6JYhSsIQScEWAE1EolB8/oDJ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T8+W1kNS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737021528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L1XJosZW4NShn5dioApxiP1subq7KqxK4uXe93H7Ho8=;
	b=T8+W1kNSb2wed1yU9dChNhKSjhpNdf7zJ5JhBkqHVlN86MdxhdOSEL45EbADGdsUVeAxS+
	Oxfa9g/MyVc5qZA+qkZCyeJ/Xp6k+Uyuqz5Y+Kkb+I1Pe5425fWO5fPpPTVdO8EE2MurRN
	J5IC602ocOZDDaWxxJ2A2+uqjNubkuA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-VkXBN15UN9Kz5ua0CN5N0A-1; Thu, 16 Jan 2025 04:58:43 -0500
X-MC-Unique: VkXBN15UN9Kz5ua0CN5N0A-1
X-Mimecast-MFC-AGG-ID: VkXBN15UN9Kz5ua0CN5N0A
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7b6d0be4fb8so118059885a.2
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 01:58:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737021523; x=1737626323;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L1XJosZW4NShn5dioApxiP1subq7KqxK4uXe93H7Ho8=;
        b=VBI2ny8eHytHpOifDHZVzzXOB9BeQ4xy6xYQISmNqvCeYVduKYLkHdwuDE/NL29iQS
         7oA902RnbItsQSwUGk+mUYbcgglCwdNLrojQgNwi7D0t3gJSC+SQNTvs7rHxEVAaPRK8
         nnDePRNJusXSt1MCVRKeuFg8gJ/crofA3CXn4c4ozJ4zVmw9agqqxTuHcgWkpIGe3R7D
         tMLDq0Ka4jmYZOvFXiErwQmNgTKNBu4T0rwbtnS35N0pEYNp/fhQD6fCW78udZMHV57h
         bEHQpvRq1bP35r2Qc1vHEMduK8Zm9CGU1E2/McI/FMtRqM70Zr0qWsum+ChDQvlXNv2R
         K13A==
X-Forwarded-Encrypted: i=1; AJvYcCW2/duvypmKIBmSwL3jflQtjlYRT1kECwC0QqAZ/bGiRLmyVBfLA0RMgF4QQ1J571s7H2o173k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiUS8geGjlXByHMtwDV0I2Cccrb12nd8S9ShQa4E1dssV9IjAr
	0og11pDykHuKenIakADvqyObdKdX58nhrsfTySc7fzZXSHbp+IfE2V9FkdtY3GdCVJKZrYQpwJz
	mmN6ti2oPXuqub7zNa6vYHq9CONdLSis1Hjb4h2D/QWV2oEKQMUGhgA==
X-Gm-Gg: ASbGncsapmvzd0jM9KTr8fHKFIGwAnONULErrc0oVpIA0xzCdboAXPYv1O++vRipkcI
	WRYLZdy8r4oNsnqx20+f5uLVW5SmcWX21tC1Ce8k0jUN9BMm0R0MoJSBQOLIvGaMbb9qsCcx4Dj
	mCNvS+1BfWtNj/FWhuHQvozqd90+Y4qouCTMlRw33dllLJyw8NkvQmQGD31Jl/5ePZPkDcXMM3b
	lApixyfOUzaM2Z5TAzrdOUuGgS+8CB0tGJHxZB4NOPe5pM0+Ij02/IBPP9vSHSkUN44rEWLIQw4
	UFQAqnporQY=
X-Received: by 2002:a05:620a:17a2:b0:7b8:6331:a55e with SMTP id af79cd13be357-7bcd975a181mr5034591785a.44.1737021522817;
        Thu, 16 Jan 2025 01:58:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSzqYsRXFRHXmdcXRECfUeMtwN//Cgn8zDTTdXOVwpXVGGF5zjiCATJuBBM+fQrOcpaTKCnQ==
X-Received: by 2002:a05:620a:17a2:b0:7b8:6331:a55e with SMTP id af79cd13be357-7bcd975a181mr5034589585a.44.1737021522466;
        Thu, 16 Jan 2025 01:58:42 -0800 (PST)
Received: from [192.168.88.253] (146-241-15-169.dyn.eolo.it. [146.241.15.169])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce324828esm803620985a.45.2025.01.16.01.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2025 01:58:42 -0800 (PST)
Message-ID: <4d02f786-e87e-4588-87ed-b5fa414a4b5a@redhat.com>
Date: Thu, 16 Jan 2025 10:58:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH 2/2] net: phy: micrel: Add KSZ87XX Switch LED
 control
To: Marek Vasut <marex@denx.de>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Tristram Ha <tristram.ha@microchip.com>, UNGLinuxDriver@microchip.com,
 Vladimir Oltean <olteanv@gmail.com>, Woojung Huh
 <woojung.huh@microchip.com>, linux-kernel@vger.kernel.org
References: <20250113001543.296510-1-marex@denx.de>
 <20250113001543.296510-2-marex@denx.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250113001543.296510-2-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/13/25 1:15 AM, Marek Vasut wrote:
> The KSZ87xx switch contains LED control registers. There is one shared
> global control register bitfield which affects behavior of all LEDs on
> all ports, the Register 11 (0x0B): Global Control 9 bitfield [5:4].
> There is also one per-port Register 29/45/61 (0x1D/0x2D/0x3D): Port 1/2/3
> Control 10 bit 7 which controls enablement of both LEDs on each port
> separately.
> 
> Expose LED brightness control and HW offload support for both of the two
> programmable LEDs on this KSZ87XX Switch. Note that on KSZ87xx there are
> three or more instances of simple KSZ87XX Switch PHY, one for each port,
> however, the registers which control the LED behavior are mostly shared.
> 
> Introduce LED brightness control using Register 29/45/61 (0x1D/0x2D/0x3D):
> Port 1/2/3 Control 10 bit 7. This bit selects between LEDs disabled and
> LEDs set to Function mode. In case LED brightness is set to 0, both LEDs
> are turned off, otherwise both LEDs are configured to Function mode which
> follows the global Register 11 (0x0B): Global Control 9 bitfield [5:4]
> setting.

@Andrew, @Russel: can the above problem be address with the current phy
API? or does phy device need to expose a new brightness_get op?

[...]
> @@ -891,6 +892,112 @@ static int ksz8795_match_phy_device(struct phy_device *phydev)
>  	return ksz8051_ksz8795_match_phy_device(phydev, false);
>  }
>  
> +#define KSZ8795_LED_COUNT	2
> +
> +static const unsigned long ksz8795_led_rules_map[4][2] = {
> +	{
> +		/* Control Bits = 2'b00 => LEDx_0=Link/ACT LEDx_1=Speed */
> +		BIT(TRIGGER_NETDEV_LINK) | BIT(TRIGGER_NETDEV_RX) |
> +		BIT(TRIGGER_NETDEV_TX),
> +		BIT(TRIGGER_NETDEV_LINK_100)
> +	}, {
> +		/* Control Bits = 2'b01 => LEDx_0=Link     LEDx_1=ACT */
> +		BIT(TRIGGER_NETDEV_LINK),
> +		BIT(TRIGGER_NETDEV_RX) | BIT(TRIGGER_NETDEV_TX)
> +	}, {
> +		/* Control Bits = 2'b10 => LEDx_0=Link/ACT LEDx_1=Duplex */
> +		BIT(TRIGGER_NETDEV_LINK) | BIT(TRIGGER_NETDEV_RX) |
> +		BIT(TRIGGER_NETDEV_TX),
> +		BIT(TRIGGER_NETDEV_FULL_DUPLEX)
> +	}, {
> +		/* Control Bits = 2'b11 => LEDx_0=Link     LEDx_1=Duplex */
> +		BIT(TRIGGER_NETDEV_LINK),
> +		BIT(TRIGGER_NETDEV_FULL_DUPLEX)
> +	}
> +};
> +
> +static int ksz8795_led_brightness_set(struct phy_device *phydev, u8 index,
> +				      enum led_brightness value)
> +{
> +	/* Turn all LEDs on this port on or off */
> +	/* Emulated rmw of Register 29/45/61 (0x1D/0x2D/0x3D): Port 1/2/3 Control 10 */
> +	return phy_modify(phydev, 0x0d00, BIT(7), (value == LED_OFF) ? BIT(7) : 0);

Please defines macros for all the above 'magic numbers'

> +}
> +
> +static int ksz8795_led_hw_is_supported(struct phy_device *phydev, u8 index,
> +				       unsigned long rules)
> +{
> +	const unsigned long mask[2] = {
> +		BIT(TRIGGER_NETDEV_LINK) | BIT(TRIGGER_NETDEV_RX) |
> +		BIT(TRIGGER_NETDEV_TX),
> +		BIT(TRIGGER_NETDEV_LINK_100) | BIT(TRIGGER_NETDEV_RX) |
> +		BIT(TRIGGER_NETDEV_TX) | BIT(TRIGGER_NETDEV_FULL_DUPLEX)
> +	};
> +
> +	if (index >= KSZ8795_LED_COUNT)
> +		return -EINVAL;
> +
> +	/* Filter out any other unsupported triggers. */
> +	if (rules & ~mask[index])
> +		return -EOPNOTSUPP;
> +
> +	/* RX and TX are not differentiated, either both are set or not set. */
> +	if (!(rules & BIT(TRIGGER_NETDEV_RX)) ^ !(rules & BIT(TRIGGER_NETDEV_TX)))
> +		return -EOPNOTSUPP;
> +
> +	return 0;
> +}
> +
> +static int ksz8795_led_hw_control_get(struct phy_device *phydev, u8 index,
> +				      unsigned long *rules)
> +{
> +	int val;
> +
> +	if (index >= KSZ8795_LED_COUNT)
> +		return -EINVAL;
> +
> +	/* Emulated read of Register 11 (0x0B): Global Control 9 */
> +	val = phy_read(phydev, 0x0b00);
> +	if (val < 0)
> +		return val;
> +
> +	/* Extract bits [5:4] and look up matching LED configuration */
> +	*rules = ksz8795_led_rules_map[(val >> 4) & 0x3][index];

This calls for FIELD_GET() usage.

[...]
> @@ -5666,10 +5773,15 @@ static struct phy_driver ksphy_driver[] = {
>  }, {
>  	.name		= "Micrel KSZ87XX Switch",
>  	/* PHY_BASIC_FEATURES */
> +	.probe		= kszphy_probe,
>  	.config_init	= kszphy_config_init,
>  	.match_phy_device = ksz8795_match_phy_device,
>  	.suspend	= genphy_suspend,
>  	.resume		= genphy_resume,
> +	.led_brightness_set = ksz8795_led_brightness_set,
> +	.led_hw_is_supported = ksz8795_led_hw_is_supported,
> +	.led_hw_control_get = ksz8795_led_hw_control_get,
> +	.led_hw_control_set = ksz8795_led_hw_control_set,

The preferred style is to use an additional tab to align all the '=' in
this new block.

/P


