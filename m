Return-Path: <netdev+bounces-144054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C569C5881
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 14:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA23EB3D813
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 11:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A77215C5A;
	Tue, 12 Nov 2024 11:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBsrsGNC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DF62141C4;
	Tue, 12 Nov 2024 11:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731409401; cv=none; b=RrkSb+r0DJ566wi47pI+1deKKNik5yVZSGG4Lojqq6FLYda9lQJc/r63zIdGcyJILlRWtGd2qpg5+9YeF6dsJZEjlrpf41blqwr5gkF+aK3/ccJVTOPYsIzf1zxpcAxiEKI7p9PshPq4+bstetmZGLbH/30kmZIA6CIZmFDgPXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731409401; c=relaxed/simple;
	bh=53Nqbs9za9XY0KG8sAX7ob6M8swycoF5/HqMt++y1Rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l1+QnLdMiTUACMRNi4a/kNPnzLhM9gpbQIqh5CNrVFityPrmO9FRelSnWNkDoSj2gwsFx3G1MSXBBYEBmmUPviGoTfUVWLGNf6XuSAVGoyeoqEIwhGK6Z+Iq18t7ysHQ8dE9lVkNa1tM5l6i/d8NiLv8Fncyj5mDvBHbUMKi/k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBsrsGNC; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c9388a00cfso7019286a12.3;
        Tue, 12 Nov 2024 03:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731409397; x=1732014197; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iPcFHCJG8NGsuskBY+kZ5XWMDYsQmMFc2+wJS3PWRtM=;
        b=TBsrsGNCGk9wGUczYwdxhKT0zJUEn7ROZV1GnPh4oSwovZ2FI+qwRJY3ata6Bp0EBr
         UNKLXgbI7V4gFtcSwHXDn6Ce/4wlC41CZXiVLjWjVAbjOPdPGTMlOmIxvZULhf/CHl6h
         g9fAhp+XOz7iqIRliTnd+hy+eO/oi4q4pMFd6McwXZN3WCCPtG2JaSVuo4Bn8wiAPj5D
         hJu6xOF5ejn5wV9ER0XU4pUxyoPw+KTq8AhtQyYLqQ7gSaDNvTvfqLgQ6OgmWcLVXLI1
         a7IgtaBLbITN3zEdncNxw8gm9Duabnl5Y7iC4rAh56ImkQRlHmCR9NQIInY9K1ShMhV8
         Ee9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731409397; x=1732014197;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPcFHCJG8NGsuskBY+kZ5XWMDYsQmMFc2+wJS3PWRtM=;
        b=HKLQLzVjfxWI/2v1QySAPkdk2tAuUqCob1xlt2jH4Om+7vRiIE3upTTw2pyrOjzum9
         1x4s9ZExyxo7MYMTF+y7f9PAEnp4t7W2XJ/geymUWQpL6MnQj6MAG//2NHpZSR515nio
         5YxwDuZSvAgScGdgkH3zzltMaKhkQbQGXwDqyZW85QDlWvHNNNhugAdElTLpSuuKJg79
         8/p93xE2swc1Cr9BJUPpyybASQX9F97bwqht6F4ybbAed1obEmwKbg4zMUsaYM4QGlcW
         6JC3K0PxnDe0WyHoPCRmm0dcgPoAvo41lz4xyXeYlQ13FgG1q1TtnmxOBQtZC7tVzHyL
         OmCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI5HVDka+zEuctGwFlCPt4SDYOQj6vyDrl3KFZQDLnb7+X+vFz6wkCA/9FFrJFnxAyoq28gg7Ok/vxBYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt4KIVXKwD7dD4m2xJxbKBl1PWg9fgigoXofbsc6bXwoh02ncf
	rrhIQum1Gm8jmAMyWttE7Ym3g/PgcK8+ja/HfrdFp+L8DYU/CaUS
X-Google-Smtp-Source: AGHT+IHX4cUH9pyL7LKsapletYqx2kvV8JoES6EsVn/ceuKd30jkLRNMQcJatb/QouJT6jLYgTQnMA==
X-Received: by 2002:a05:6402:254b:b0:5cf:45c2:981a with SMTP id 4fb4d7f45d1cf-5cf45c29904mr4046359a12.34.1731409397257;
        Tue, 12 Nov 2024 03:03:17 -0800 (PST)
Received: from ?IPV6:2a02:3100:a46e:ea00:90f0:9049:6891:55f? (dynamic-2a02-3100-a46e-ea00-90f0-9049-6891-055f.310.pool.telefonica.de. [2a02:3100:a46e:ea00:90f0:9049:6891:55f])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03c4ecaesm5872673a12.70.2024.11.12.03.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 03:03:16 -0800 (PST)
Message-ID: <f8ec2c77-33fa-45a8-9b6b-4be15e5f3658@gmail.com>
Date: Tue, 12 Nov 2024 12:03:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 1/2] net: phy: Introduce phy_update_eee() to update
 eee_cfg values
To: Choong Yong Liang <yong.liang.choong@linux.intel.com>,
 Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
References: <20241112072447.3238892-1-yong.liang.choong@linux.intel.com>
 <20241112072447.3238892-2-yong.liang.choong@linux.intel.com>
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
In-Reply-To: <20241112072447.3238892-2-yong.liang.choong@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12.11.2024 08:24, Choong Yong Liang wrote:
> The commit fe0d4fd9285e ("net: phy: Keep track of EEE configuration")
> introduced eee_cfg, which is used to check the existing settings against
> the requested changes. When the 'ethtool --show-eee' command is issued,
> it reads the values from eee_cfg. However, the 'show-eee' command does
> not show the correct result after system boot-up, link up, and link down.
> 

In stmmac_ethtool_op_get_eee() you have the following:

edata->tx_lpi_timer = priv->tx_lpi_timer;
edata->tx_lpi_enabled = priv->tx_lpi_enabled;
return phylink_ethtool_get_eee(priv->phylink, edata);

You have to call phylink_ethtool_get_eee() first, otherwise the manually
set values will be overridden. However setting tx_lpi_enabled shouldn't
be needed if you respect phydev->enable_tx_lpi.

> For system boot-up, the commit 49168d1980e2
> ("net: phy: Add phy_support_eee() indicating MAC support EEE") introduced
> phy_support_eee to set eee_cfg as the default value. However, the values
> set were not always correct, as after autonegotiation or speed changes,
> the selected speed might not be supported by EEE.
> 
> phy_update_eee() was introduced to update the correct values for eee_cfg
> during link up and down, ensuring that 'ethtool --show-eee' shows
> the correct status.
> 
> Fixes: fe0d4fd9285e ("net: phy: Keep track of EEE configuration")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> ---
>  drivers/net/phy/phy_device.c | 24 ++++++++++++++++++++++++
>  include/linux/phy.h          |  2 ++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 499797646580..94dadf011ca6 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -3016,6 +3016,30 @@ void phy_support_eee(struct phy_device *phydev)
>  }
>  EXPORT_SYMBOL(phy_support_eee);
>  
> +/**
> + * phy_update_eee - Update the Energy Efficient Ethernet (EEE) settings
> + * @phydev: target phy_device struct
> + * @tx_lpi_enabled: boolean indicating if Low Power Idle (LPI) for
> + * transmission is enabled.
> + * @eee_enabled: boolean indicating if Energy Efficient Ethernet (EEE) is
> + * enabled.
> + * @tx_lpi_timer: the Low Power Idle (LPI) timer value (in microseconds) for
> + * transmission.
> + *
> + * Description:
> + * This function updates the Energy Efficient Ethernet (EEE) settings for the
> + * specified PHY device. It is typically called during link up and down events
> + * to configure the EEE parameters according to the current link state.
> + */
> +void phy_update_eee(struct phy_device *phydev, bool tx_lpi_enabled,
> +		    bool eee_enabled, u32 tx_lpi_timer)
> +{
> +	phydev->eee_cfg.tx_lpi_enabled = tx_lpi_enabled;
> +	phydev->eee_cfg.eee_enabled = eee_enabled;
> +	phydev->eee_cfg.tx_lpi_timer = tx_lpi_timer;
> +}
> +EXPORT_SYMBOL(phy_update_eee);
> +
>  /**
>   * phy_support_sym_pause - Enable support of symmetrical pause
>   * @phydev: target phy_device struct
> diff --git a/include/linux/phy.h b/include/linux/phy.h
> index a98bc91a0cde..6c300ba47a2d 100644
> --- a/include/linux/phy.h
> +++ b/include/linux/phy.h
> @@ -2004,6 +2004,8 @@ void phy_advertise_eee_all(struct phy_device *phydev);
>  void phy_support_sym_pause(struct phy_device *phydev);
>  void phy_support_asym_pause(struct phy_device *phydev);
>  void phy_support_eee(struct phy_device *phydev);
> +void phy_update_eee(struct phy_device *phydev, bool tx_lpi_enabled,
> +		    bool eee_enabled, u32 tx_lpi_timer);
>  void phy_set_sym_pause(struct phy_device *phydev, bool rx, bool tx,
>  		       bool autoneg);
>  void phy_set_asym_pause(struct phy_device *phydev, bool rx, bool tx);


