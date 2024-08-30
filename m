Return-Path: <netdev+bounces-123589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9ED9656F4
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 07:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2019D1C21863
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 05:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61C014D294;
	Fri, 30 Aug 2024 05:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIPUwH0M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D317D13BAFA;
	Fri, 30 Aug 2024 05:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724996051; cv=none; b=riCITLE3pHoOv8cpRE0uLW3m+jqB/6elYxLRUcdd3/DAGvkFmWSnVQrOBcZGnIrni/c0QrRVByV+HgOtVmqPnZR/H0GQoG2r2RMOYCJdAKtXlJUqL547O389VYDRTvqpr78Qe+Dtrk9gXSJbUqB77g1AnwML9qesEhMcThMAeDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724996051; c=relaxed/simple;
	bh=k4NfdQBKon4Sbmj3TuNxJfWIqXmCA1KN7zUsR09RxM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wt56JIdw2wIN3MIYVXoRZJApRxkYt8EnagQ8j0WX50K0OTybo6nPuIBHOlYvAuim8n0q9FID9lPG/rdv3ysdoLlMv+BUuvMDX3m/Wvsg50MtChBF0cZU7NhD+XrmFkn9J6JAEf+7CjSm5iZnsBaRrghQoG2ibu1l3FaA/Swyu5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nIPUwH0M; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5333b2fbedaso2294797e87.0;
        Thu, 29 Aug 2024 22:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724996048; x=1725600848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dhHyd/34NXNRu7snoCGQmLy+2+psD5BzB5SWBQ1gBKk=;
        b=nIPUwH0MaGDEa5sf98J3MOEQ+kBo31M0W4KR/+zLKOLOXwhDAF3i391yIutwmu2Z9O
         PbJBnlIZOdBiyImlIM1K4RVincHlAhEvWEK2g3XNIOWvbC+ILtxLshoBHWn1LXDlgyCY
         +dYIL7jDv9XgUghQxrAyUd5YQPeyxw+93DHX/UnRXOfAAnbwpBbbGmUnP6U1zOy7ixHM
         Hns/1AbBBqH0FxWUqDT9w58tc/As6RFWeyDAOrD5BCRvuSZFJ+8pyjAKVecF2v+0crt8
         7QhGFWhohR88k2XVfe+0/LC81NGOZzXsfSS135WDtlBEflGQ6JpArHZQdyhooRLgjxyn
         6uaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724996048; x=1725600848;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhHyd/34NXNRu7snoCGQmLy+2+psD5BzB5SWBQ1gBKk=;
        b=RTlEsv8+5pnnpuauxgetTR1EJpCSaWo1QAizYBimPdgIwQuPH+BAH6uwIwCItlRzxo
         QOO8SrfJIu77j/CPgMEK3AvgIYxOOoeiA1jfKVxQM9HbP5a9yrEVeWMXLjlI7ixwR5je
         gS/Qci/ploSdEsDYtp0xLJ1sdVdZAO7kX7a80VrYPLsheg3QHG/jnLRINBoDTuvUhe3a
         EJ1xAtX+Ttlxa83iFDZVmYi7riSNzFKibGsQr0djLmDWRRDexVr9/WtNc3QRsJM1VxyV
         jtUOXT+uICeXutno/Mg7x3n568ooSOSkZcXm789+LEdT5dGK0cwVQ7DfkdC5psV4OZuZ
         xPzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs4NMP/9hlRdTKDxjqsswe1TBZMSo1ah+O44hN6e+1cs8W0dVJ0XCEdgfSvdoXuJeVSlHojHWDVddMxJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRsNkSpMa9DKxbjxViEGtS3dYOdBLe+u8g/O4vS1KJxi6bizfw
	XCaGwqYqMhg2Zpt/nIAT9v1K4vKurxiqXPhVtpx6HghhWIZpZM9QJkZmGNd/
X-Google-Smtp-Source: AGHT+IEM5+gUV7rRgiaiWvGJlD3+UrMsxA9Bj1RbY3nA5oexUAjPwCq7stKygNlHQJcMVgQK0JH3aA==
X-Received: by 2002:a05:6512:33c9:b0:52e:9beb:a2e2 with SMTP id 2adb3069b0e04-53546b13ecemr672644e87.19.1724996047516;
        Thu, 29 Aug 2024 22:34:07 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c577:dc00:45fe:38ba:a095:abab? (dynamic-2a01-0c23-c577-dc00-45fe-38ba-a095-abab.c23.pool.telefonica.de. [2a01:c23:c577:dc00:45fe:38ba:a095:abab])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a898922295csm167081866b.198.2024.08.29.22.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 22:34:06 -0700 (PDT)
Message-ID: <d2c681d6-2213-4cad-8b01-783ee5f864b0@gmail.com>
Date: Fri, 30 Aug 2024 07:34:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] r8169: add support for RTL8126A rev.b
To: ChunHao Lin <hau@realtek.com>, nic_swsd@realtek.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240830021810.11993-1-hau@realtek.com>
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
In-Reply-To: <20240830021810.11993-1-hau@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30.08.2024 04:18, ChunHao Lin wrote:
> Add support for RTL8126A rev.b. Its XID is 0x64a. It is basically
> based on the one with XID 0x649, but with different firmware file.
> 
> Signed-off-by: ChunHao Lin <hau@realtek.com>
> ---
>  drivers/net/ethernet/realtek/r8169.h          |  1 +
>  drivers/net/ethernet/realtek/r8169_main.c     | 42 ++++++++++++-------
>  .../net/ethernet/realtek/r8169_phy_config.c   |  1 +
>  3 files changed, 29 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
> index 00882ffc7a02..e2db944e6fa8 100644
> --- a/drivers/net/ethernet/realtek/r8169.h
> +++ b/drivers/net/ethernet/realtek/r8169.h
> @@ -69,6 +69,7 @@ enum mac_version {
>  	RTL_GIGA_MAC_VER_61,
>  	RTL_GIGA_MAC_VER_63,
>  	RTL_GIGA_MAC_VER_65,
> +	RTL_GIGA_MAC_VER_66,
>  	RTL_GIGA_MAC_NONE
>  };
>  
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 3507c2e28110..3cb1c4f5c91a 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -56,6 +56,7 @@
>  #define FIRMWARE_8125A_3	"rtl_nic/rtl8125a-3.fw"
>  #define FIRMWARE_8125B_2	"rtl_nic/rtl8125b-2.fw"
>  #define FIRMWARE_8126A_2	"rtl_nic/rtl8126a-2.fw"
> +#define FIRMWARE_8126A_3	"rtl_nic/rtl8126a-3.fw"
>  

I checked linux-firmware repo, the new firmware isn't available
there yet. Are you going to submit the firmware file?

Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>

