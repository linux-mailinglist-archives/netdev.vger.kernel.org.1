Return-Path: <netdev+bounces-134879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C8199B730
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 23:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 048E4B21D7D
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 21:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6457912DD88;
	Sat, 12 Oct 2024 21:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQwYkXJo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2A48F49
	for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 21:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728769390; cv=none; b=OIK0fvNEmVFVt4DTuQcQpOE9l0w6PX9dq/6s4Q+PvMiYVTsg/cr6+l7Kg/ESvwz84S1iONpxm0nlKspL89tTCnFUUumRmegkJaJPWp7UjnrJ/Y2X2V9uf0ht3ThUw2YCiVhWu0j/jfw8ohVYHDc2RR+d8OG/X5+rrKOsG+9pdvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728769390; c=relaxed/simple;
	bh=kjvR0XLw1MyolAcvK2G1gxD/5v2B7HTM+pm0X9EsRSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2Mm002sy9aeWF5fGD7kE4hV4+93MrCBJNIZmfWmcXQLGv9MH5/ZGtjw7JR0CEK0E1LOaZRfpkv8US6f1Lyq55NJgHQ7tiZujiqdGqnrktVbadQ1C1NlH2TQuT8P2n1r4gOi8GTFDKq0eDt3PaWUn6NhmsUwi6FX65usSqW8TBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQwYkXJo; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c937b5169cso4302180a12.1
        for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 14:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728769387; x=1729374187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=unfSO1Rl6gsexHLbuDFiV7O1fR+K92Y987pSScefUrU=;
        b=DQwYkXJo4E9dFXi61OPH1vln9Xb9POQMoZRNvsFKxQl4KP7zdmg5bdNGwqLEorpiGm
         8+OaJ0crc9nG64s16/+rQtZDBBGP2wRSFxULNl9r6z4T00gFqxgw+aXeJ7IP25v41+ad
         raaf39RFQ4in+xfAAnjGnxOFQ8q+uDWguieGcQKqujBqn+47p5pzhorJ4rIfoJWo18CZ
         8I4ydMn/GmAttmo/MyG6y0CGedsqFpnP4Rlwf5QySx4D/ZBXEZRPuqCqxJRmt0rJx8cS
         maoKuBT2XBpsib7i1/IP7LxwSp6Xr6Gqdioyi6EVOs1pszid5V0nTyMYKtPe32NiuJ0j
         HzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728769387; x=1729374187;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unfSO1Rl6gsexHLbuDFiV7O1fR+K92Y987pSScefUrU=;
        b=Psaf/A1v3I5M3yNy0u4O4Cb1LFhIPDzCw29NSsgrrQRIP9WXfDXkvV/4L0Lze603WB
         q1R+gWZQZpYdNoHdjp94XJwFjygqKczhmVWs+rSW4wTnaya6T25qGoBnanUTdidvD1oF
         GW9MiuJZ/5Z/QhaAQPP2NqFY6bKDPZ5nW/ly5Y+T+opU0n4iJOvz8D0n0Qa/4E7MNUYx
         Yiy6X1hNVOWfs6rod/ClMix5dNb0CchV0YjYocoEmLLn0P8nRfDxSdzHVTsK+0MD/fyN
         LAaf6aKC9gJiicISlqLR/Ozv78q5oCRosKsjglRhbVLqR6SEogY2rzywMsqBoHugSNy2
         vNYA==
X-Forwarded-Encrypted: i=1; AJvYcCUeKh4zhzofO81ZqogtKT16UrBX5xJN7loGYh5QZe3m1FpSvt3uYeBkoOX5AuiVG4KmUvKJ3J0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdaxiXOb8Ys/Izvu3t4V4oeNjx29i++ZbFB01ZGVPZTOZU4G7D
	DTbtD+DegujVmrGHVdEgD0OuGlwy4mOCw6e8QJbN+eumLKDon9Tp
X-Google-Smtp-Source: AGHT+IF3hKAUqIaTY2uZtpSsJIzB231/Nb8NZO9wup+Od7VyBJfQYKqWyqFW43ADZeDwXFGUrwjuWQ==
X-Received: by 2002:a05:6402:50d4:b0:5c8:843c:7a74 with SMTP id 4fb4d7f45d1cf-5c933577d95mr9660452a12.12.1728769386641;
        Sat, 12 Oct 2024 14:43:06 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9cf5:9500:7452:8738:f913:7c31? (dynamic-2a02-3100-9cf5-9500-7452-8738-f913-7c31.310.pool.telefonica.de. [2a02:3100:9cf5:9500:7452:8738:f913:7c31])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c9370d22f3sm3214416a12.20.2024.10.12.14.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Oct 2024 14:43:05 -0700 (PDT)
Message-ID: <2a11adb9-bcd9-4418-8fc8-b751c8ce13b4@gmail.com>
Date: Sat, 12 Oct 2024 23:43:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] r8169: use the extended tally counter
 available from RTL8125
To: Jakub Kicinski <kuba@kernel.org>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <a3b9d8d5-55e3-4881-ac47-aa98d1a86532@gmail.com>
 <20241011155816.09e4e3d5@kernel.org>
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
In-Reply-To: <20241011155816.09e4e3d5@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12.10.2024 00:58, Jakub Kicinski wrote:
> On Fri, 11 Oct 2024 14:40:58 +0200 Heiner Kallweit wrote:
>> +static const char rtl8125_gstrings[][ETH_GSTRING_LEN] = {
>> +	"tx_bytes",
>> +	"rx_bytes",
> 
> these I presume are covered by @get_eth_mac_stats ?
> 
>> +	"tx_pause_on",
>> +	"tx_pause_off",
>> +	"rx_pause_on",
>> +	"rx_pause_off",
> 
> and if you want to add custom pause string you should first
> implement @get_pause_stats

Thanks for the hints!

