Return-Path: <netdev+bounces-69903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D36CE84CF41
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 17:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 375F2285C35
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 16:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0061A81ABD;
	Wed,  7 Feb 2024 16:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYZXw1t5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F207F492
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 16:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324553; cv=none; b=Dgb1Ul2whMW7+DHI4PWnyg9qXyd9Evv8NZ/wgtUE3LY3mTCGjoB4Ng0HR4meuByaacA2T7Dtt3eqxpf7LdGK8Pz9NcZtiscUKUMNER2VK5dxAi94xyh8k0FF/CuWsBwgoBZ3OKckNFTKy93hmUwwrG+d4L2aDuAqrXrlxHGu46M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324553; c=relaxed/simple;
	bh=zrRAjObJ4scLuTU/7DNK2HqtLbvCofygM79ye/VFMfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZeM+ihXuYyQEwCs5DfeO0IZxMrbDiTF7ZxYj2kHZU++SQVVjJYdm7HbiybMGIMBBob/ijkUomZpFt7Ya6j5pTHkkCWcntWG+u69Yps73md+rv7Ht+lnkAFry6Uw4Cz4W+AKW8jDSSauHrPsrZuAV1tMQVOVSJbwerOKmPExH/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYZXw1t5; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a389a3b9601so49831066b.1
        for <netdev@vger.kernel.org>; Wed, 07 Feb 2024 08:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707324550; x=1707929350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9g4whTAnwjrZKe1H4Um+Av3GtPjXmu7XO9EsB5aSW04=;
        b=MYZXw1t5CKe3KAQxgZKN4pz0+tnYQLS2ZHtX9fXL95d3tOJpas2XtDN51lChbQ7X6T
         HXclCSZ+239nUxFgEMRtg8Me99GqqhAcBjzs/uPDKg4wTt56Rs8eDjPtAPEI/7JiBXpo
         Tt6sGYysePLsrgWqadH9qzEYXXJKFQR6tLkZsoMxL4JlgaS3+CWaFE3+aRiZHVdja4MY
         rMQRUWriXJkLb2rT6a8MIGps1Raigks+EWRLBrgPZOAVtZ/zYOfdh30n2oRhSmqaGqEg
         PpH2hRj2utGzTPQ1v4S9quRgGsPzhhasNPWl+siGz1RjabecPKgsxx7CheVgBBT3nVND
         GCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707324550; x=1707929350;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9g4whTAnwjrZKe1H4Um+Av3GtPjXmu7XO9EsB5aSW04=;
        b=r10WQmsgNAwMhzT3yUZsoDDE0BlwJznp6J/VHsCKmPRfRWEElBtpz9v007Ef4f7gZY
         8dRC5C6R15sPBkdbZGxvFosXwkS5o1hmsXtNkUMO8/ybKworpW14J7YqplwczKcrmW5l
         QBKcEnNA8le0tr0bonSNzCm3bpKO+nMCQ7TNc3G2nB1Csj5ACrU78hGx3r9qSU62GF1E
         mmptJ9OmfG69VgbZ6DnTDpz6eeeiQwL0X+zZLY2wOEZ9vYBUpxO/JcxkYjhtNgdS8teI
         HBkGy4xa1T5AGUegSD2v141kK7QeJBn3EscDl2X0kt0EsZjAnuLxvCiXsAm5p1/tFxYd
         E5zA==
X-Gm-Message-State: AOJu0Yw6/LOc2NEK9pgldYQTi0HSW/aKWbjNsOycfEd9nBp+iGpAZR/C
	HPIVcqSyKq2A2prQcE/2Ls1UeHho27TBfEKLvF6M8GJL8gR6AQ7K
X-Google-Smtp-Source: AGHT+IH4OSRojiwxnNOJCriZhfbdEWMw5qlN3qkI2HQCXMNWEComS9aA/wqFDZXLhJLQ6nGIf2SafA==
X-Received: by 2002:a17:907:7745:b0:a31:30c7:f4a8 with SMTP id kx5-20020a170907774500b00a3130c7f4a8mr3887897ejc.4.1707324550556;
        Wed, 07 Feb 2024 08:49:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUYkg42Ut+veyYH44mQSLICvXxpqs1Nmn014kLqdW8BsZ//CN2N5KZKaPa0GGZi4nf3wPhseqmbG6IxsZXF01S7PjRekH2mjNw+T9kJo3Xw8dQJ1FTurHPb/eLpm9OnMnGlOIXLkLhGzFcqnjLNag1r0PNMpTV+qyTMlOgQ99Yeq5rvr5zaHDipukcSuUWFjEfILkgl6neDyL9VeRit2AYGOldlETwLUJ2vkYphpzzYDA==
Received: from ?IPV6:2a01:c22:76b1:9500:5d1b:fc9d:6dc2:24a? (dynamic-2a01-0c22-76b1-9500-5d1b-fc9d-6dc2-024a.c22.pool.telefonica.de. [2a01:c22:76b1:9500:5d1b:fc9d:6dc2:24a])
        by smtp.googlemail.com with ESMTPSA id lj24-20020a170906f9d800b00a38599ba2d1sm929052ejb.118.2024.02.07.08.49.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 08:49:10 -0800 (PST)
Message-ID: <0a5411da-2ae0-4d09-bc35-fb123975507d@gmail.com>
Date: Wed, 7 Feb 2024 17:49:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net-next] bnxt: convert EEE handling to use linkmode
 bitmaps
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>
References: <37792c4f-6ad9-4af0-bb7b-ca9888a7339f@gmail.com>
 <a52c2a77-4d0c-48a9-88ea-3ec301212b31@gmail.com>
 <20240207075512.314da513@kernel.org>
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
In-Reply-To: <20240207075512.314da513@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07.02.2024 16:55, Jakub Kicinski wrote:
> On Wed, 7 Feb 2024 11:43:39 +0100 Heiner Kallweit wrote:
>>>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 21 +++---
>>>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 65 ++++++++-----------
>>>  .../net/ethernet/broadcom/bnxt/bnxt_ethtool.h |  4 +-
>>>  3 files changed, 40 insertions(+), 50 deletions(-)
>>>   
>> This patch has been set to "Not applicable" in patchwork. Why that?
> 
> I'm guessing Dave did that because the conversation on v1 was happening
> while v2 was already on the list. Repost.

OK, done. Thanks

