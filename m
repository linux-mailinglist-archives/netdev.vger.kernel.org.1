Return-Path: <netdev+bounces-219264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2044B40D3F
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 20:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64E654E4B20
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 18:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32563093A5;
	Tue,  2 Sep 2025 18:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4sHXczy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91E4350829
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 18:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756838090; cv=none; b=EgAI0ktxwN1kvPK2Omzf+1zHYDu9nFTWrUg16XoOEJQizs1OBAg/RYl8AeN5zQ1e9eBgKTbDPK2VlRSyCAJjhLL0OtsRikvfhn+GgLquA65ZFKrVcMQUBRK5cevLbnna+iPjJhRCkFYtqlw/A/VPIjeMuSAbKiCPU6HPrvODbc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756838090; c=relaxed/simple;
	bh=ENBPh4ibNrgjVVEIpzjgopu0FZsLYqaSmz3+3FUnlrk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=myhMfvzs5Hm0uiUJ6qSv5AoRpD/Mf7riGmzMwYNRDVK8nTTxPwKQZldFVXWrRos6rthJelc7b1PhQPrnUspLhaVihqv8zwBp89e6fF1K7+108i4hJZv7dvCXUb4V+ProMnREaphzecy1VBnKi0tAHpuGiF9JemvXx1RIowrgpo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4sHXczy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45b87bc67a4so21265815e9.3
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 11:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756838087; x=1757442887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EqL6/pK5OwiW4KoacWn8DCDh95J44y9isSjvXLbHrNM=;
        b=R4sHXczypBqpFRyHDPlsq+PLn4qQ8T5Vl9m05i1Eh8GOTwUjytT9oyojofcXw2uAYD
         IX+5bRXl1vGEiE1Gg9Nsqmdyq7E8hTpvsPCo137VtRatHBeol96eFORMrt2ayjZHFqs3
         ZwBC92fq/FzBMUjvYVjipODEZTRqW0haEd3Q7PfRtBxaW8limVyD34uFZSDACmpYPVop
         GbLeBA06eRpV35pKymvdROTIOnV8cmUr5nHjmFFhGyqzJ/hoGrEocR/O772XparQ5+DG
         0alw8r50LMGpqWXVkBzMDlygYK2U2u50pktb4Q2zrVAu6JFTMEohhOyV7AZKIznrFAvN
         eTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756838087; x=1757442887;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EqL6/pK5OwiW4KoacWn8DCDh95J44y9isSjvXLbHrNM=;
        b=KYgoC67zTMDXaVbv4Hzsq0F7XhIIvxcuwYg1xDey6PwWmrFpaQjIBpc2QhwRSInPFD
         G5wujEbj6acoKIjnwvR8zjGxGd0olQaZSfPIjr9WEpXKNEX9dJqVkSrRWkm9STUmdWfs
         789EW92MgYahhPfL7C6DrxvaQs6nJmM94evADD9HZJIFy2wkuvoFaAcbZW5JpdO42yjV
         OD5W3Oh9/c2UsBAskhR1gXtiOSG9UXqYbR1vT3QbNdH4HCK5hEfefQgSr77jMT2o77eG
         WUZu3l/N1gJBCCsEh8NmXfGyJszfRBPkIAMiuZ+6tv2tlQ0ZKPr3n3JvoJgIxwTUW9Dp
         karw==
X-Gm-Message-State: AOJu0YxIHSJme0fO2zY1FwkIcXGQF9CvlvA5/Rnj4N8NFXuFTKd959GD
	JGRiFD//q3OeJsBOEsiToeHLiiLK+UJArfYrAS4xcAauOy8ucb/Yaif9AHEGtw==
X-Gm-Gg: ASbGnctYlUc4bahV54sEQ7rPQDYdoVA8/jMsjAESUNC/SYZWnNDb1VqtJUSurDgriZu
	43C1TN5UT46RwDs6doyOTi8XcuxcLRZM9+/GJZwpnl2SfHNNBp4avfd+6lhRryXiyjOjRgohG/L
	rZYbgKrvgcXLdq9yp2FDNjfc2yrJQK33JgPUjDdGHAmjDL2rB/HDW7VuKwXJ8YeoETSOKPJlsIq
	qF4Ij34Ol8a+WAeYTznzODeyFGZLDMmNjVgD00hwDJmk+hqZQoCiq5gP3OKER98sdL7cDo6WvF9
	PmdZ6kbr3nHpmwbaZoRF6DCYNuiK4GeZvVh8k54Jncu/4VkdyTG4lPlFBBnmuhBHzM+oCC9dY1u
	97kyWpJoBj6xuciFcIr4+VhOxzP2R1RgCVij43oaY10Bc2lZcUfsppnUCFJcTsMXAMG/iAmxjCW
	7CxscfmgfXMRj095KG8sGosMqQQ3VxTX40GlN68OjikX94LSaDf8qMQaJSifuINw==
X-Google-Smtp-Source: AGHT+IFj4k+a6IOfAzgnUBivkg+u3HczgpJsdHhAJpvEVoW9ggxbZ2jz46n3NZISvFqU4aF2qIWPrA==
X-Received: by 2002:a05:600c:4f41:b0:45b:8b3e:9f7c with SMTP id 5b1f17b1804b1-45b8b3ea0e1mr67861815e9.19.1756838086747;
        Tue, 02 Sep 2025 11:34:46 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f25:8100:e13f:d8aa:6a68:8455? (p200300ea8f258100e13fd8aa6a688455.dip0.t-ipconnect.de. [2003:ea:8f25:8100:e13f:d8aa:6a68:8455])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45b8a980011sm69908645e9.0.2025.09.02.11.34.45
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 11:34:46 -0700 (PDT)
Message-ID: <91def72c-254d-4bfa-a78c-e7d7ccec75df@gmail.com>
Date: Tue, 2 Sep 2025 20:34:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: fixed_phy: remove link gpio support
From: Heiner Kallweit <hkallweit1@gmail.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <5c9f80a8-1f4b-419b-a2fc-2f85f9602ae5@gmail.com>
Content-Language: en-US
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
In-Reply-To: <5c9f80a8-1f4b-419b-a2fc-2f85f9602ae5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/2025 10:27 PM, Heiner Kallweit wrote:
> The only user of fixed_phy gpio functionality was here:
> arch/arm/boot/dts/nxp/vf/vf610-zii-dev-rev-b.dts
> Support for the switch on this board was migrated to phylink
> (DSA - mv88e6xxx) years ago, so the the functionality is unused now.
> Therefore remove it.
> 
> Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/phy/fixed_phy.c | 68 +++----------------------------------
>  1 file changed, 4 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
> index 7f4e1a155..aae7bd4ce 100644
> --- a/drivers/net/phy/fixed_phy.c
> +++ b/drivers/net/phy/fixed_phy.c
> @@ -17,7 +17,6 @@
>  #include <linux/err.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>
> -#include <linux/gpio/consumer.h>
>  #include <linux/idr.h>
>  #include <linux/netdevice.h>
>  #include <linux/linkmode.h>
> @@ -36,7 +35,6 @@ struct fixed_phy {
>  	bool no_carrier;
>  	int (*link_update)(struct net_device *, struct fixed_phy_status *);
>  	struct list_head node;
> -	struct gpio_desc *link_gpiod;
>  };
>  
>  static struct fixed_mdio_bus platform_fmb = {
> @@ -62,12 +60,6 @@ int fixed_phy_change_carrier(struct net_device *dev, bool new_carrier)
>  }
>  EXPORT_SYMBOL_GPL(fixed_phy_change_carrier);
>  
> -static void fixed_phy_update(struct fixed_phy *fp)
> -{
> -	if (!fp->no_carrier && fp->link_gpiod)
> -		fp->status.link = !!gpiod_get_value_cansleep(fp->link_gpiod);
> -}
> -
>  static int fixed_mdio_read(struct mii_bus *bus, int phy_addr, int reg_num)
>  {
>  	struct fixed_mdio_bus *fmb = bus->priv;
> @@ -82,9 +74,6 @@ static int fixed_mdio_read(struct mii_bus *bus, int phy_addr, int reg_num)
>  				fp->link_update(fp->phydev->attached_dev,
>  						&fp->status);
>  
> -			/* Check the GPIO for change in status */
> -			fixed_phy_update(fp);
> -
>  			return swphy_read_reg(reg_num, &fp->status);
>  		}
>  	}
> @@ -125,9 +114,8 @@ int fixed_phy_set_link_update(struct phy_device *phydev,
>  }
>  EXPORT_SYMBOL_GPL(fixed_phy_set_link_update);
>  
> -static int fixed_phy_add_gpiod(unsigned int irq, int phy_addr,
> -			       const struct fixed_phy_status *status,
> -			       struct gpio_desc *gpiod)
> +static int __fixed_phy_add(unsigned int irq, int phy_addr,
> +			   const struct fixed_phy_status *status)
>  {
>  	int ret;
>  	struct fixed_mdio_bus *fmb = &platform_fmb;
> @@ -146,9 +134,6 @@ static int fixed_phy_add_gpiod(unsigned int irq, int phy_addr,
>  
>  	fp->addr = phy_addr;
>  	fp->status = *status;
> -	fp->link_gpiod = gpiod;
> -
> -	fixed_phy_update(fp);
>  
>  	list_add_tail(&fp->node, &fmb->phys);
>  
> @@ -157,7 +142,7 @@ static int fixed_phy_add_gpiod(unsigned int irq, int phy_addr,
>  
>  void fixed_phy_add(const struct fixed_phy_status *status)
>  {
> -	fixed_phy_add_gpiod(PHY_POLL, 0, status, NULL);
> +	__fixed_phy_add(PHY_POLL, 0, status);
>  }
>  EXPORT_SYMBOL_GPL(fixed_phy_add);
>  
> @@ -171,8 +156,6 @@ static void fixed_phy_del(int phy_addr)
>  	list_for_each_entry_safe(fp, tmp, &fmb->phys, node) {
>  		if (fp->addr == phy_addr) {
>  			list_del(&fp->node);
> -			if (fp->link_gpiod)
> -				gpiod_put(fp->link_gpiod);
>  			kfree(fp);
>  			ida_free(&phy_fixed_ida, phy_addr);
>  			return;
> @@ -180,48 +163,10 @@ static void fixed_phy_del(int phy_addr)
>  	}
>  }
>  
> -#ifdef CONFIG_OF_GPIO
> -static struct gpio_desc *fixed_phy_get_gpiod(struct device_node *np)
> -{
> -	struct device_node *fixed_link_node;
> -	struct gpio_desc *gpiod;
> -
> -	if (!np)
> -		return NULL;
> -
> -	fixed_link_node = of_get_child_by_name(np, "fixed-link");
> -	if (!fixed_link_node)
> -		return NULL;
> -
> -	/*
> -	 * As the fixed link is just a device tree node without any
> -	 * Linux device associated with it, we simply have obtain
> -	 * the GPIO descriptor from the device tree like this.
> -	 */
> -	gpiod = fwnode_gpiod_get_index(of_fwnode_handle(fixed_link_node),
> -				       "link", 0, GPIOD_IN, "mdio");
> -	if (IS_ERR(gpiod) && PTR_ERR(gpiod) != -EPROBE_DEFER) {
> -		if (PTR_ERR(gpiod) != -ENOENT)
> -			pr_err("error getting GPIO for fixed link %pOF, proceed without\n",
> -			       fixed_link_node);
> -		gpiod = NULL;
> -	}
> -	of_node_put(fixed_link_node);
> -
> -	return gpiod;
> -}
> -#else
> -static struct gpio_desc *fixed_phy_get_gpiod(struct device_node *np)
> -{
> -	return NULL;
> -}
> -#endif
> -
>  struct phy_device *fixed_phy_register(const struct fixed_phy_status *status,
>  				      struct device_node *np)
>  {
>  	struct fixed_mdio_bus *fmb = &platform_fmb;
> -	struct gpio_desc *gpiod;
>  	struct phy_device *phy;
>  	int phy_addr;
>  	int ret;
> @@ -229,17 +174,12 @@ struct phy_device *fixed_phy_register(const struct fixed_phy_status *status,
>  	if (!fmb->mii_bus || fmb->mii_bus->state != MDIOBUS_REGISTERED)
>  		return ERR_PTR(-EPROBE_DEFER);
>  
> -	/* Check if we have a GPIO associated with this fixed phy */
> -	gpiod = fixed_phy_get_gpiod(np);
> -	if (IS_ERR(gpiod))
> -		return ERR_CAST(gpiod);
> -
>  	/* Get the next available PHY address, up to PHY_MAX_ADDR */
>  	phy_addr = ida_alloc_max(&phy_fixed_ida, PHY_MAX_ADDR - 1, GFP_KERNEL);
>  	if (phy_addr < 0)
>  		return ERR_PTR(phy_addr);
>  
> -	ret = fixed_phy_add_gpiod(PHY_POLL, phy_addr, status, gpiod);
> +	ret = __fixed_phy_add(PHY_POLL, phy_addr, status);
>  	if (ret < 0) {
>  		ida_free(&phy_fixed_ida, phy_addr);
>  		return ERR_PTR(ret);

--
pw-bot: cr

