Return-Path: <netdev+bounces-66662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C0E84028F
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 11:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60571B20BE6
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 10:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52ECC55E58;
	Mon, 29 Jan 2024 10:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B315q8YN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9265855E6D
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 10:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706523227; cv=none; b=Z5RWXp6rJAHLGEtaVmmKIlIZpWo8aRJYbEM1kgEUlL87HGoUc4QdlghTXYB7dMOcd3RYN9xlFzi8ViIX0lftkyTpxWdEH7lgO2WVYgqYseHl2UQn+uce4tI+R5KluvOeF0iawIsFc8h8LDwi31SYIynrBu1hJP02eav/gKvBJeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706523227; c=relaxed/simple;
	bh=hHzbchKNLpFBT05iopn7jFJTc6c+GZL5mO4lIMdejY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TJFizlWzhqWZmqkGOLlSp6PrbZjCKmlHni+eADwauQDTZz9y6wqyiQ0xRgTg2/LegheK7n/09f9xg3E4kFpogrOnKu+1LFxhEU65yw3fa8ZpeutrPc8MSWudsPjyZ8JMG9ewNEG0QkSKTvt7Fmbf5j/tY/RAQ/SHUo2bSV/Dklk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B315q8YN; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40e9101b5f9so32362755e9.3
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 02:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706523223; x=1707128023; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WBeOoj1PBFxtTMLo40h4ucq08rAJAzqa9TL8UdT7bBI=;
        b=B315q8YNI8XeOn/yNV9/DG7mzC/O/ULZ4g8YB+fLTX+FJ8E6CIHJqcbo0kLIPLT54A
         RFJrpZCjVGTx4dq+HqH0auic2RpfuNKmlpRjQeilMRAeQHIueFjDpPKqJ4Sfxos0jM/X
         Wikf7VmCEGx9whVdiiPCLScKs0S0L3M2BCalmFdqgtQhrxvcH2lvqtxYruHfTkGB95Q7
         Gv/EvJK+b8iqDkDA3dtKWQSskCRQ3Q+ujtVxRUiz0BI8Kd10RxL3icbzpa0JY0shJ9WE
         DjO5rWi8p5Xppa6PALTCTl9Yqw21DD+TzUPndh4u9jXffjVmdJRrRJPxbvALNUQidNWC
         PAwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706523223; x=1707128023;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WBeOoj1PBFxtTMLo40h4ucq08rAJAzqa9TL8UdT7bBI=;
        b=wPxfzjbbHh/2DxXoo9eWmlmwI4XF05p2+jBB1HgCVt+wS7H9lyzBsLOZzjpVeenQ22
         n6rzX56YLYd4YJriPsw9ftAe1loPlSO0JSdCLTX0iSzZ1ru5y/QKhSU6xuSluweEhKpb
         /uB3gPG72SMY8qYP7ScEQzOw1h55qfhjX/uuUacFQxkw1Jf2owq0P5rhzvm7J2MSCSsN
         AHWQUqmttiq6tdZ/EtUJewl4i8ndKEThtTthREFBCNg/qievpR2AhxIRmtJc/4+rr6cK
         lpBqX/LTVI04biv+EfqHwYn3qhy8ldGkM6LqRyPptx+oGY33FAJX1dQjB6n2jxDjF5C7
         MleA==
X-Gm-Message-State: AOJu0Yw9KpSSbpJQkBmw0A0IuUfd1h3qGClb/BZe4WTTqOeK4CUJZkTG
	BX6XRiVh3xhDQKGhuk08MKZ/vgysNstQQ6lSUp2Fy7gqzLtFqSPi
X-Google-Smtp-Source: AGHT+IFcak1bA0s5fI4wUOivhfi3SOY0/cy8SbMP37AH4KAvAB016TBKnFaUtNEaCVV6Ey2ehpo1SQ==
X-Received: by 2002:a05:600c:4e89:b0:40e:4932:3995 with SMTP id f9-20020a05600c4e8900b0040e49323995mr3981884wmq.14.1706523223324;
        Mon, 29 Jan 2024 02:13:43 -0800 (PST)
Received: from ?IPV6:2a01:c22:7314:6100:6024:4c94:48b5:a1d8? (dynamic-2a01-0c22-7314-6100-6024-4c94-48b5-a1d8.c22.pool.telefonica.de. [2a01:c22:7314:6100:6024:4c94:48b5:a1d8])
        by smtp.googlemail.com with ESMTPSA id fc15-20020a05600c524f00b0040efb20fa6csm924987wmb.47.2024.01.29.02.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 02:13:42 -0800 (PST)
Message-ID: <87a8bd8e-d1a5-4b1a-b70a-555e9fc15799@gmail.com>
Date: Mon, 29 Jan 2024 11:13:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 0/6] ethtool: switch EEE netlink interface to
 use EEE linkmode bitmaps
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <7d82de21-9bde-4f66-99ce-f03ff994ef34@gmail.com>
 <0a352643-8cc5-47b7-b31c-dc36ec69fa19@lunn.ch>
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
In-Reply-To: <0a352643-8cc5-47b7-b31c-dc36ec69fa19@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29.01.2024 01:10, Andrew Lunn wrote:
> On Sat, Jan 27, 2024 at 02:24:05PM +0100, Heiner Kallweit wrote:
>> So far only 32bit legacy bitmaps are passed to userspace. This makes
>> it impossible to manage EEE linkmodes beyond bit 32, e.g. manage EEE
>> for 2500BaseT and 5000BaseT. This series adds support for passing
>> full linkmode bitmaps between kernel and userspace.
>>
>> Fortunately the netlink-based part of ethtool is quite smart and no
>> changes are needed in ethtool. However this applies to the netlink
>> interface only, the ioctl interface for now remains restricted to
>> legacy bitmaps.
>>
>> Next step will be adding support for the c45 EEE2 standard registers
>> (3.21, 7.62, 7.63) to the genphy_c45 functions dealing with EEE.
>> I have a follow-up series for this ready to be submitted.
> 
> I tend to disagree. The next step should be to work on each driver
> still using supported_32 etc and convert them to use plain supported.
> 
> What i don't want is this conversion left half done. I said i'm happy
> to help convert the remaining drivers, so lets work on that.
> 
Fine with me, EEE2 can wait until this is done.

> My happy to merge this patchset, its a good intermediary step which
> allows each driver to be converted on its own. But i'm likely to NACK
> EEE2 until the _32 are gone.
> 
>      Andrew
Heiner


