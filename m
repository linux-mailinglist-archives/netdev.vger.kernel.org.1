Return-Path: <netdev+bounces-168636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87038A3FFB6
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 20:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6641744EC
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 19:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64492528F6;
	Fri, 21 Feb 2025 19:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmmT5RMp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D0F5223;
	Fri, 21 Feb 2025 19:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740166106; cv=none; b=bKSZ+7PQ+IEw9K8fAXnlmtBMk5c0f7M+k8OTvFi16EaO28lPQyDOqS7mi9KQCpYKzzaOWDqgXuuYesBfnR9HAYQCrFPSjFrhiJ+Xuq3TpNzWDKQOz+KAn117IMIKfQ+467+qWnu3i11Jm4216m8q63hzoNXG2ctndVNW042HOb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740166106; c=relaxed/simple;
	bh=dlRKNBeJMRXqES9M0nAN1yjHVw71VN9OvhgFqz4xVG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMXdvV5YssC7lLObVg2ZZB7pZZJc/KK+UnBClD86VBkgPrNiNPee/J0oJg5bPIfHZx0c0wRK97V95R2uO04XTF8wsXinxb02He0PoLrycIS35qQ/I9G1JBvb+9EuFfJe9xJ0swUQLKj+VlqUGBJVUfwG/GiubgyfDvjPKDlfhDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmmT5RMp; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38f2f783e4dso2107018f8f.3;
        Fri, 21 Feb 2025 11:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740166103; x=1740770903; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R7kEWZ+g4lTHwK1AjqsYO7gqCaMrbFvzrDx/uNooTjY=;
        b=LmmT5RMpZYOVz5qScPVJQ4KnEK/qoDUt+vXWbAaJH0KwKoZXi260svjnAjdTfge6bd
         V3omxU8YMMwTTe578V91QKvLZFejVICUMH5eYbArOw38jbf0fH8f7NsUQcQAElUe89Yd
         Yt/+e67G3UePIwLQdQYMrdZ9ews9MK6ZAELkd6Vf87R3FHAjclAdO/a5uXsCIycLVLY1
         26C364j5MNzKnZsxW66nB6TOuuFg+grCWMUQbVbkZbyXKi/8h90k7unJPltYbtfG/KIW
         XwjLyJ4VUOj+fBVJ8dBy5/bV3kKaYlKTHVy2kDqUQ63+Xd+OfUZRL13DiQswSB5HCGQi
         0RsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740166103; x=1740770903;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7kEWZ+g4lTHwK1AjqsYO7gqCaMrbFvzrDx/uNooTjY=;
        b=gveOuQVWigrnuZJHGeY3P9vMyHocqaktMmYSo6kNT6a7eXZcvMuKLRRelJbPW+6Ycf
         ZPUS/QTAfQ7/+0+RavZpyXMkXZ+pbphblguFWI4TUoTs2A6nzptSxfH0XwfccuOQafGZ
         19CE2v6UsY2WISxJQUuzQfDzJRdfH5Hu2ZABn/SbfIyHZY9R5o7fBpgy9c8Q6cqEaaiF
         iMFShwtZ65n1xIYfSEcWYS3ELu0hmBBsd2yBLMV4t/vHC5RAUqlm4O825K2X9J+D5/As
         zGh1AuyY8N0+Z5mckZKNM2+xKHKTF1z2zPLh3kwmbbWkWx1Vd/aKrmUuMfhK7zZkqm2V
         ZpjA==
X-Forwarded-Encrypted: i=1; AJvYcCVXl7n36qncHRp/BLIrc52qXAhTmOY1EDKGW6Hns0BILofz14Db3emUyJsz7qwgf6xh3hAVZFAJt20K7pA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw35tN4W5GDDAqhVzw690rUpC+vWrn5pa3POanhlXx4/RH38s4U
	gGHF/05M9el0v4Jf0hVa4RPpnFmGvVMQl+iM82PBWXhJI4NMVPaO
X-Gm-Gg: ASbGncvRNXMmKQVfbFAtbxH5TMmN69m1xOjwNGrXCrYAM/FHxOQGAUAaol7KnKFPVWO
	YpPpJZEFu3z8Z7EiOYVAFqMO3WxwFQFIBVuybzZ/gb8BTR6gAFwtVyP7pVvItL7vnQfwAJtwcRT
	cM3whPhqt20pYqMMfJqVx2WwvCQAN0Fz9VuWeG8FWoZquMDpigDCHouxvd79FH43TcXIfUT6gHK
	gjNilum8I3fwxOvCOBzkCNgHCUsV9Iq/8EtIODEdHF2LzTB6Wy3QAtpfhO8RVSDyOb0XkQMlcAU
	jkFqAoleyUAYMjCCiMYAUQuuBSdT2vhzXs0odY2EiPPzqbPxrBDjrkYy9H5ZmfUKT6Mzl94c1Xs
	e6a20Za20/Le31/LF7XdZgT3aDoU9hBNqKwOr6BzCbZQ+MQ+xvYfyrKPyOx22r/PdAGVJdEYVSn
	X+oOI5wv0Qa9sC
X-Google-Smtp-Source: AGHT+IFIjC0Sz8Vjr18fPCHsdkpGy9mfAI+z0yf+VrUNob3joJNAWO9nEj01BGIfSw8TwIhA6uvMpA==
X-Received: by 2002:a05:6000:144f:b0:38d:bec9:c8d with SMTP id ffacd0b85a97d-38f6f0c6be9mr4799874f8f.53.1740166102975;
        Fri, 21 Feb 2025 11:28:22 -0800 (PST)
Received: from ?IPV6:2a02:3100:b29e:900:9dc2:647a:dfc:6311? (dynamic-2a02-3100-b29e-0900-9dc2-647a-0dfc-6311.310.pool.telefonica.de. [2a02:3100:b29e:900:9dc2:647a:dfc:6311])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-439b02f23c2sm26760335e9.17.2025.02.21.11.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 11:28:22 -0800 (PST)
Message-ID: <6bfca9cc-6edb-4ced-93fa-40c415999a0e@gmail.com>
Date: Fri, 21 Feb 2025 20:29:11 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] r8169: enable RTL8168H/RTL8168EP/RTL8168FP
 ASPM support
To: ChunHao Lin <hau@realtek.com>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250221071828.12323-439-nic_swsd@realtek.com>
 <20250221071828.12323-440-nic_swsd@realtek.com>
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
In-Reply-To: <20250221071828.12323-440-nic_swsd@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21.02.2025 08:18, ChunHao Lin wrote:
> This patch will enable RTL8168H/RTL8168EP/RTL8168FP ASPM support on
> the platforms that have tested with ASPM enabled.
> 
> Signed-off-by: ChunHao Lin <hau@realtek.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>

