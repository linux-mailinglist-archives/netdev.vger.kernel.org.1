Return-Path: <netdev+bounces-133088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7987999480B
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F119F1F22302
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 12:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313AE18CC12;
	Tue,  8 Oct 2024 12:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nf9ggylK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D44C320F
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 12:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389212; cv=none; b=o64YfliT57OsB7z7MrmpHQ4avX8dw4UTAA+30xBBWke8GyuMtJ8PXvOOtH4hQdu574KoHS7yx44kChKPxzt4Cx9ih+Unb4bOfpCgPq6/qmr8GVOnaFR1Je5fChV2mG/kA6mDgFedCFwSaUdasULw6YImfIWmXMmonkIo/n28nNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389212; c=relaxed/simple;
	bh=sBt6Fr8xpaDN3Rt5HQCTmPj1hAE8RdunMfWTC0miack=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PWdUMDRhmhNXpB/EjHRJhGTsDbnHRFF8yuGp6sQ0jeylyPalJ0GraM0PGyJcNBtKaYXaOldaVgusTauDS1h8e9NikTRFujSY9b/z4ghrAffmLTSOvGHIG8H/ix80swwKKFWuirac33raLpg9Yh5bJJmwZla7iRkiZatu419uZ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nf9ggylK; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c915308486so282987a12.0
        for <netdev@vger.kernel.org>; Tue, 08 Oct 2024 05:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728389209; x=1728994009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jt2zT/uj92nZnCMF7bhcX9pJquxLwl1YcCp27FcMXKI=;
        b=nf9ggylKJ60Tj2bk5fb6y/mVTc7a+iQ6Lq8Uhn4/btx5a8iLPn778bo2OfzXOshH4P
         VnzQcL9Tm14lRqSLfUKotPm4Au9beFhhqP+m4uKCCgU6e4cgwg7kwS4ds6AEXVPGVxOk
         yMCNv25QeAMsGqHgSCztnqREM9S4cyE2pMH5hP5RRqlTcRzMP7wvkGE5ivecqk57UJks
         uFVaxDx8In/615cfl0/HxOhsIFfULSM25Bmtv0QpY5mzZMq5FHsRgWlqFKyWRG8L3eun
         bCw9QfJRiSK/9KMB/0R+l37oDCtTUH6Wxp6EyCXlu0eTiaBbNDecs36TrxEuEG/GY/Dd
         JYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728389209; x=1728994009;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jt2zT/uj92nZnCMF7bhcX9pJquxLwl1YcCp27FcMXKI=;
        b=lVH+6rqChvtUlM98gu+luf+he+PaKzjN790QnChiJZwvg8r4dgTu1T273MK5sHp6bK
         XnY07GXFnsuASWr/8IcQxH9qtlglzoOIVSpeGn/yU9KU3hB/qF7z8rXa/LKcoGDk3oF9
         J4dm4MteqBpvEbPrBb0ENqSjXuDmwkJxrv4pk2eO70xSpLWnx+7mWHNWXNyfwChwEcMc
         CuJM5nY8KjNq+/z0gmN3YSG/ilzW/v22ls/BbKJNzluU4Ymn25hz7RnvjQpq9Ja4UV87
         yDUmQj1gD0qlrxfxri/s9e4iI7E0vBr1fIj7BHVi+F4ajpwHwPNoiowbYCzm8FxTPkcI
         CVjw==
X-Gm-Message-State: AOJu0YwUx3F5CCIRGgLFXA2EVwd7oZk4k4NtojGJnuGAs/vG/iWMj393
	99OlXk9ZJAxicKf4NstlcucxSp6xhgKb5M1v0SQRH6DthY03B9aQ
X-Google-Smtp-Source: AGHT+IEKrGiY+f+Ni4CfKMT293tJqtDuyWrhvmdceb2SJRQN1U5VgmY3SdRW+zOhUxcek4xqR0TVfw==
X-Received: by 2002:a17:907:6e8e:b0:a99:7e19:fd7b with SMTP id a640c23a62f3a-a997e1a1960mr68817166b.52.1728389208442;
        Tue, 08 Oct 2024 05:06:48 -0700 (PDT)
Received: from ?IPV6:2a02:3100:a123:2000:88c8:9903:b6fe:1345? (dynamic-2a02-3100-a123-2000-88c8-9903-b6fe-1345.310.pool.telefonica.de. [2a02:3100:a123:2000:88c8:9903:b6fe:1345])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a997ee645fbsm31754266b.133.2024.10.08.05.06.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 05:06:48 -0700 (PDT)
Message-ID: <846ac9e6-dfb0-48f0-91e4-158d300ccb38@gmail.com>
Date: Tue, 8 Oct 2024 14:06:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] r8169: Use improved RTL8125 hw stats
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <37b44c85-7090-48c8-a307-624244964405@gmail.com>
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
In-Reply-To: <37b44c85-7090-48c8-a307-624244964405@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07.10.2024 22:23, Heiner Kallweit wrote:
> The new hw stat fields partially duplicate existing fields, but with a
> larger field size now. Use these new fields to reduce the risk of
> overflows.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 6a9259d85..bd26b7b50 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -1873,6 +1873,14 @@ static void rtl8169_get_ethtool_stats(struct net_device *dev,
>  	data[10] = le32_to_cpu(counters->rx_multicast);
>  	data[11] = le16_to_cpu(counters->tx_aborted);
>  	data[12] = le16_to_cpu(counters->tx_underrun);
> +
> +	if (rtl_is_8125(tp)) {
> +		data[4] = le32_to_cpu(counters->rx_mac_missed);
> +		data[5] = le32_to_cpu(counters->align_errors32);
> +		data[10] = le64_to_cpu(counters->rx_multicast64);
> +		data[11] = le32_to_cpu(counters->tx_aborted32);
> +		data[12] = le32_to_cpu(counters->tx_underrun32);
> +	}
>  }
>  
>  static void rtl8169_get_strings(struct net_device *dev, u32 stringset, u8 *data)

When further testing I found an issue with an apparently incorrect counter value.
I have to check this with Realtek. Please drop the patch for now.


