Return-Path: <netdev+bounces-190803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 053F5AB8E5D
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 20:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7F8B189DF4A
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 18:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B828F2586C7;
	Thu, 15 May 2025 18:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LV2k/B8h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDAB143C5D;
	Thu, 15 May 2025 18:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747332085; cv=none; b=m9OdBUwbmLPkA4P5xnw9uhNDYmPcYFcLvtKEJMkVW/ZR+KZSKHcH37X3PXl2GH4o9YdqwMUbYuJcyCkZIm66P55R55zaXnrYJoIJiqAw8qUdhXRUc6Lz9hX6hbhvkwVIR0xJZpPkxylV5KEdZ3pgqHPapdR1iXlcTN6FjbSajlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747332085; c=relaxed/simple;
	bh=QNsvzp8+Y020QhH/c0iTZMAZvM6gN/18xTUJ7KgeZXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVmAQND/D8LywwbpjsZYu8+G61Lgybbo0cp0LNvEyZfnrpd4pNiZgWP+aDmePb7CkMTXdnO0NHSg1gSlF7Ec7v3JuFjT6mdG48lqLSeu+6ykf6CmuHGleA5/oqj4tnagdIpV6HDcVX+cCXnxyY/xFloAfTUCDTE+BWNMg1Umu34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LV2k/B8h; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-442ed8a275fso14124925e9.2;
        Thu, 15 May 2025 11:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747332082; x=1747936882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ftL1zu9G85h+3xwDkEOI0cxrRxUcnx00/pKAwf99vzk=;
        b=LV2k/B8hsjx2UgfSRqvTa6ekUK429Y/f53oa61hQ4jri9MyCJ2ppE1YuTZUGIi5mSK
         rk4LFRyzHUI+U14bqvMcvgR86BwCZC0TxeR+iWvwo77UrAFnOVQzGHTVwtV3ejX3dKLU
         faulSMKdeglpb+BABiP14caNFWDlB0QzyI66zYLrTsatBwcGZ5pwEN3vze6efj3je7VV
         97ua4AWZd4BBlPEGe56J3Ky5aSE0ERmJKJImAbhIVrRTRgXib865kGo7yti1CQDJA87R
         JePjbJWjuWHfAlRp+1T4N0xJXtCn/JGzI92vSW1ktcx/8qswRBnR0grp8A8QkkwYtHSV
         /nhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747332082; x=1747936882;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftL1zu9G85h+3xwDkEOI0cxrRxUcnx00/pKAwf99vzk=;
        b=ZFAdkk7JtRA4HiZhygn12Jglw4YYfEmfF0pCsLh1KPQKIQjLlmUcpu9DrHw9J6xt28
         QKpYg8p9apznstfKk0Zah8YjFbpRriR9JuGydOK4rN8fciiZqAYiIQR0BFyJMonp4Oh4
         zls8cRlqxIumrVmTzZw9gbll+vO9plpNT67PWuAkAT1oROTHxLT2bjEwpZgLFFDdI3Q2
         hEI9Mkxkiv0NmWismJ9iUN7W9c/EROWp4pl0/y1zTuI2Dmh2cQYJFmAzN5x0C/FMG1Gg
         xozIS/PMscBCG4ia4N8enxi00ZreRW4Bozgam5OrD3jaGrAmgkKvXsiX9ygUFLg4PBHt
         o+Zw==
X-Forwarded-Encrypted: i=1; AJvYcCX+xE8e15oAiomwBsC5hYD1wsxgrGQhdaxecepMjkWuOV/eqggItqrdgQNclbesHvJgAvgPvBtK38Z4s6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTk3EvEY8Qt9YEwpwgEiyvDH/fvXPjAzA3nDKmLZMTs9iBAA/w
	KQXAX//YthD/oBexrjOsvkKPOTwz1hoQdD8BYlgHTY/uXNRI8PjF0GQV
X-Gm-Gg: ASbGncvta9c4Xo1X4sPq6J71EDIJ/lO75Yt/BCUKJSeFGLcATsUXclzj5vGtXob68s/
	ipF/UsrKXYdRDe7+grRx45JS+MaCXcD9UsC5CvIupllNMOfiKIIg+xGCnoCKh1xdM1ArgoMoarZ
	13grwPgzWcdVZlTI4q9+WLaWTTU1jaBM5/0BZMmrcdkEPK9vGdXJ27KXJlsrOyMShO3dhzhsiGN
	dg8hTq4it+0Ows/3QMmTBbc2xtRIjKFeSZV1nUVc2yIqXYECpT1h+fieQ8ACl/l7zjIbnnolRsA
	ajHIHU7tROr72FDU/itNByxx7p86096u9vyq/x7bVFH1j2/MB24k2y6rcRkP4mn0e3TBaNk/XcZ
	2NkQ5YiQubPYVJDs2Wsf15Pq11wXAeZo94L+sCOypgiRFAlgBqVjZPYWYKg5+5Eeo4lylWXfrU/
	B+VQdsOrDDwg==
X-Google-Smtp-Source: AGHT+IHgeAM+8FzyBqZPg1R1yIQBqNvQ8UD9T6HygfSREDafkbuj7z9GEsOUiA8q4FoXVXqYMORHGg==
X-Received: by 2002:a05:600c:4e0d:b0:43d:ac5:11e8 with SMTP id 5b1f17b1804b1-442fd664a0dmr4465545e9.21.1747332081787;
        Thu, 15 May 2025 11:01:21 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f4a:2300:ec36:b14d:f12:70b? (p200300ea8f4a2300ec36b14d0f12070b.dip0.t-ipconnect.de. [2003:ea:8f4a:2300:ec36:b14d:f12:70b])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-442fd4a0a5dsm5329295e9.0.2025.05.15.11.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 11:01:21 -0700 (PDT)
Message-ID: <2898dcdd-1955-4aeb-959a-58bf8166102f@gmail.com>
Date: Thu, 15 May 2025 20:01:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] r8169: add support for RTL8127A
To: Hau <hau@realtek.com>, nic_swsd <nic_swsd@realtek.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250515030323.4602-1-hau@realtek.com>
 <c57f0ef9-62c6-4821-a695-e8e4724f1cb7@gmail.com>
 <a3bb102cb48f49179fae5167b1a6bacc@realtek.com>
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
In-Reply-To: <a3bb102cb48f49179fae5167b1a6bacc@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.05.2025 11:37, Hau wrote:
>>
>> On 15.05.2025 05:03, ChunHao Lin wrote:
>>> This adds support for 10Gbs chip RTL8127A.
>>>
>> Thanks, Hau. One question wrt EEE:
>> Curently we disable EEE at 5Gbps, likely because support in
>> RTL8126 still has some flaws. Not 100% sure, but I assume also 10Gbps
>> supports EEE. How about EEE support at 5Gbps and 10Gbps in RTL8127? Can it
>> be enabled or better not?
>>
> rtl8126 and rtl8127 EEE can be enabled at all supported speed now. 
> 
OK, then I will send a follow-up patch enabling EEE at 5Gbps for all
RTL8126 versions.

