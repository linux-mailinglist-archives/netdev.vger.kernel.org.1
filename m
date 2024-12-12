Return-Path: <netdev+bounces-151509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DD69EFD9A
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 21:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD9EF188ACD6
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 20:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98B2193094;
	Thu, 12 Dec 2024 20:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KG9NGQ42"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDB054723;
	Thu, 12 Dec 2024 20:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734036354; cv=none; b=C+03BZknC9Ko0Zo+cy+krQKxpN3BIcEP34NC+mvV2f+WBgvVl9CvDIcMUobq8Ykb8MVUI6NA0D9BuooqkJKbnsKrjMBUR1rKQsGvp3RNS4wg5e1hw6DdBL4e79kZYT6yohL5jTniM9BF9Zv1rdCkP1n278oTEzOSQcfJV+xzrAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734036354; c=relaxed/simple;
	bh=Oq2EFU9WDsnfr81Zj1WqAMRGuoqvDhzFizCDkGLECJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lz/0jzCvPoUcwmMt2+90UAEzbJOEq05f4mBdjknjkz4rTFL0X1LsCiYpjJ1UvG2XApsrlqtvdJsqvaAu0bXPRRtQBjAkeJ5keiUGAD7RPbd3RXHfacHrFJZnbS5gIJpGdXeLOJd9cUyJtinOtOceV8cS74hnfoIOQV5GEQYM/NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KG9NGQ42; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385de59c1a0so646835f8f.2;
        Thu, 12 Dec 2024 12:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734036351; x=1734641151; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ly1t3TnwyoN3c6VsXr1J5N92980MTbNSgllWdxFRMq8=;
        b=KG9NGQ42HhUtgdKCNdTr9R/pAXtSK12Mgo0+f33YzYrtAGT36NRz0oyI0495JQQ5ri
         gMTNtRlXxyTkZo6t3DomMrAkoEJeOTonNcbRV+mEdaz9zCrML7ouGx6MDh8Ga+b+CrQM
         5ywrBecHwvHGMYzEhym+Ewyor3QssPFAXaweJIZebhVzTHf7j5qweuC//z5a8/D81YhU
         S9uz8a0WSXGb864uEWZ1XOZYp++kchqGzt07xhFbyg1vZuxmNK7qag37KEl9h1R0gB/w
         24T1kHLKx/rxCLAkIxdUT8LzSOYg41c+ONpUzLCMxSw5mTWE2h9G9EGp1tXCrwTHkNri
         ZRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734036351; x=1734641151;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ly1t3TnwyoN3c6VsXr1J5N92980MTbNSgllWdxFRMq8=;
        b=n7nKNlJbf1dgTqWmAAmFjxdbkdrhIPQtMdkzKYaAcWN58TQjRbDxuDEiwy1O+8sKWi
         P5TRt74Zlmw5QZseZOWoViEsPTJfS0cblGSzH7MtvIbRn2BjSiSvmyPW4e6XBLqGy6YR
         trpxBmfALLgXu2DhzQmI250B7wPobjnsHj2AGx+GH7i3M51EzVSLfhyzfm1nFTuQoE4g
         1Y5hyDfKpQYJ9UlE4+Xfi3/xj5GWJQpn1ZW2y02sEDa5cbKFGZD9ApR+tD6L9bEEwfll
         K78NFA1GriukdmD3uw4bOUAVPi5OuOWHWyVfnNPxfKMVCB7vm0tXxnPlIfnMRA/OoNlD
         DwRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUj1hR6ITddO7v1dsPoihBNOUYknMeuNQfVaiNMjIFrKOexbHeW0hgFhLZT8X3k/QkYrn37UIGsDuOIa4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0AyBufCRvdnbOi7bgSed6e6JPIwT0iVMUmLC4x0b5BtffbBfx
	QTZc/bn4EajuctabFPCpZuoFDPQ3tRrUYjkN6dpuDa+A4nj7dlJZ
X-Gm-Gg: ASbGncsMa7k8ZaX6iFGoKFWiSHvzifw8BuvdXK8UHVbiXLfIScimicVFRnBJAmEVqEJ
	WyOBnSOKc91b7kV1PK5/HAawH4xylTeq6BCsZYUGXZATW23wh394kAjuVAujWeH3sINT8Fd8pPN
	SZ9tuwWVZDQC0RpVBd8EFLqlhQuoEV8hnrfLv5W+tRSCYMDV93e0kpBetgbK2rastx2+uNN8cVw
	wJ4Qc2q+xRr/MRqdMUGNKZoh53z8Fs5HdPG8o295WSyDpEIpYULWs4MFiqX0coK121O6aXHgc//
	hYqBClvDwLyVmdxTnbW5H9fn3EJiXZUOLPQnpYNJ47bxqaT36YUncuO3OxtgsocA/W2bo7aaSMV
	GAnNE7xsZ+XuocvUMY/CgSrhLV8W8gxBzBzOGFr8T4zztr51/
X-Google-Smtp-Source: AGHT+IFDv94JBA9+LcWWy2M3OY37mEMqHLB6w0wd1FagvQCSz3Z0p9D9xxOxkRhcu+kwooxU+nQjxw==
X-Received: by 2002:a5d:59ac:0:b0:385:f349:fffb with SMTP id ffacd0b85a97d-3888e0ac3e9mr32174f8f.45.1734036351153;
        Thu, 12 Dec 2024 12:45:51 -0800 (PST)
Received: from ?IPV6:2a02:3100:b054:8800:ad6e:989a:d139:4bc6? (dynamic-2a02-3100-b054-8800-ad6e-989a-d139-4bc6.310.pool.telefonica.de. [2a02:3100:b054:8800:ad6e:989a:d139:4bc6])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38782514dcesm4889052f8f.65.2024.12.12.12.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 12:45:50 -0800 (PST)
Message-ID: <349290e5-5ce6-4ee7-b4d1-cee06751f86d@gmail.com>
Date: Thu, 12 Dec 2024 21:45:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] r8169: add support for RTL8125D rev.b
To: ChunHao Lin <hau@realtek.com>, nic_swsd@realtek.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241211062946.3716-1-hau@realtek.com>
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
In-Reply-To: <20241211062946.3716-1-hau@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11.12.2024 07:29, ChunHao Lin wrote:
> Add support for RTL8125D rev.b. Its XID is 0x689. It is basically
> based on the one with XID 0x688, but with different firmware file.
> 
> Signed-off-by: ChunHao Lin <hau@realtek.com>
> ---
>  drivers/net/ethernet/realtek/r8169.h          |  1 +
>  drivers/net/ethernet/realtek/r8169_main.c     | 32 +++++++++++--------
>  .../net/ethernet/realtek/r8169_phy_config.c   |  1 +
>  3 files changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
> index 8904aae41aca..5b87c89363b3 100644
> --- a/drivers/net/ethernet/realtek/r8169.h
> +++ b/drivers/net/ethernet/realtek/r8169.h
> @@ -71,6 +71,7 @@ enum mac_version {
>  	RTL_GIGA_MAC_VER_64,
>  	RTL_GIGA_MAC_VER_65,
>  	RTL_GIGA_MAC_VER_66,
> +	RTL_GIGA_MAC_VER_67,
>  	RTL_GIGA_MAC_NONE
>  };
>  
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 6934bdee2a91..c97cfbf876af 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -57,6 +57,7 @@
>  #define FIRMWARE_8125A_3	"rtl_nic/rtl8125a-3.fw"
>  #define FIRMWARE_8125B_2	"rtl_nic/rtl8125b-2.fw"
>  #define FIRMWARE_8125D_1	"rtl_nic/rtl8125d-1.fw"
> +#define FIRMWARE_8125D_2	"rtl_nic/rtl8125d-2.fw"
>  #define FIRMWARE_8126A_2	"rtl_nic/rtl8126a-2.fw"
>  #define FIRMWARE_8126A_3	"rtl_nic/rtl8126a-3.fw"
>  
> @@ -142,6 +143,7 @@ static const struct {
>  	[RTL_GIGA_MAC_VER_64] = {"RTL8125D",		FIRMWARE_8125D_1},
>  	[RTL_GIGA_MAC_VER_65] = {"RTL8126A",		FIRMWARE_8126A_2},
>  	[RTL_GIGA_MAC_VER_66] = {"RTL8126A",		FIRMWARE_8126A_3},
> +	[RTL_GIGA_MAC_VER_67] = {"RTL8125D",		FIRMWARE_8125D_2},
>  };
>  

Thanks for the patch, Hau. I think I will change the numbering of the RTL8125/8126
chip versions to be a little bit more consistent and leave room for further chip
versions. I will then submit the patch with the SoB from both of us.



