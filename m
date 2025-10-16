Return-Path: <netdev+bounces-230193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3997BE5391
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 21:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F08B1896F0E
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 19:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4B32D9EFA;
	Thu, 16 Oct 2025 19:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOBVKL98"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FE72DA742
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 19:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760642559; cv=none; b=s+piCGo/4qMpkM73+QfGPUcaeh4pV/KTSHQ7Icv+sxvo1M//MjoSX4Lo8tnOJAeTlAMOcUL//IudQwE7bk7tDPVRhR7rGrjbuko0JO00vl+AE+WDANMdf6q0h+/4MIymazMxKO39nT/7XjcMNT3dn4RbFCd1jxim1tN0t/oAkmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760642559; c=relaxed/simple;
	bh=iTb+bln8h1atDdReBjNVXxsV3ZeeXGirfIuo5MeHEHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+8HWmW9J/PzeZiMcUYsdEhFr67PQlIanMetetn5p7xeWJuLhNLfiE5/1OMahPKIrmWL/MqoPezJHe2iCtUNzYuCIy99rI72lth575m6LwiwhhDrJtF5068eRsMzJmcYmAcnp2E5thjRlimZpNncv0e+8hXjlgN0i6gskxv2xew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOBVKL98; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b4c89df6145so197182566b.3
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 12:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760642556; x=1761247356; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mazL4ZNhfMTuLBZtmB1izgS6Hwjzo50sqJKfKI4uQrM=;
        b=mOBVKL987jMFCkDFtCXlG4R1UbHnwWJ6ROd2dvuFdPpW/aWGz69f6WrBcmE2znHgz6
         v8mmlj1PgzqeEgYYSNFxA/u2RI4bdBQVCCwGkdsfY2YiYuS0AvG3PXN8Q2Uf7sZq6wPT
         t8xd8t59XCCts7aI0NDOmteHp0Iqt1jFzyl+WP2YR88qiCYpjp2ESiHCVHWgWIqJU2+k
         y/Fik34cs5sT137NU+lnjTi8ZFGd6Dkk4Tw9iLSLPMN2Apypnjqka1KmZTaocrrP+k3p
         f/xbcGYOXGbqANxdMwAD2APu7qprFXOE2dFRmZ3OzRk4BwsUQtTD3t2v9vLHsMrRl8yb
         Ijaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760642556; x=1761247356;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mazL4ZNhfMTuLBZtmB1izgS6Hwjzo50sqJKfKI4uQrM=;
        b=SRZPMIdBNsr6fWqFhFQRh5kJDNJeEOstC/7EEaW6j0+ZfumUWb6sNWMMb+DtVId1pG
         YyAFZ+RySUPDKYsmh0DpmW4hw1g9UkJDfPOf0VVMIVUbRqeTftvbxa2tqvBsWBy75pb+
         KFeKtmO3vvU5up0XkFGWDIQ61wKrUXNVFFpMPI2pBmFF/SqHKk39dJpw6vMkGkGtBcxh
         YwxOAY5R9ArsZgJ/4Pd8CEM06j7Ks5ZlCA9ErDieU9uGuFGaEPs6Byt28dHxMENLJgA5
         lE5e7sYdE4/QCuNRmj4y9HAOYspDiC5vKIeqiKpBK3Up/797nYOllsA1E3Ynz+Sohi0K
         cXKw==
X-Forwarded-Encrypted: i=1; AJvYcCXY8DgynNTZGLp0oHv5B0cVLQmI1nQ13uGdRmRrKS/obZ6TDB+V0VK+JZERummpfaA6uF16R3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL5EZ9XlV49yrgRuRMHhq6ITgTq1TbNpx5+XqhRhNNJNMwHCrQ
	7lTlotpoFSp/4aQGm3lY95to9n4rkBVPbRvFnlQRjcPB5hlVqHHVGHeR
X-Gm-Gg: ASbGncsG4WvKpNoJ8jPGU4f/Kvst6YrkD16AR+mo2oWbhp8KWfYoyUdeHqIQfaaRjRQ
	1XEJutynxl7rzFENHeIY7oCzyl4YtDzlaiLF98adjXTQlwl62lyHCY2YZagpawp+VY/J8OMqLI1
	hqmeNASZanBmN/kyuMxuncVuFZaat4sEGgtwqp1CS6OfV81Rf1OKvN+LYBMbWCTiwcLew5dk45p
	xd0BySpiNxp63AOXEKEOzdAGjnbAhmeHzRotS8sm4wtvXy0/Ch66Ar0bdtCg9cS8n1nb9W/flMy
	9AeltW8he2ePCl8pkeOgrntnh9tR59wfzk+5Nk0xXfRU4v+LzCJKwqTQ7a/cGPMGpgh5/5ebkJR
	3SeFkXym1QfgFFrFSoEB7Iux1H0aaAi853899nvWOJRj5Mgy5mxPTod/+EyIqgposiQMYwi8RrA
	VBh1qtaPmjNQW8Qu8eQjylDE+1UN37/qBqnYZwxsm3Pt/ls0oWg1lsbdXABnqd/05ILoKLBrWjX
	7O5FShBiZla2XqU5By6anvXRmQz3QZSiF3AMYRWlvfVtiwofAvnNQ==
X-Google-Smtp-Source: AGHT+IH9mzHjOyKNHjdw9p5Jii1PWL434NmhcyRz+io3PQPkjxsoa8nCFr7zQj8Se/rDSvYIl+YRiw==
X-Received: by 2002:a17:906:40c7:b0:b53:d97c:5203 with SMTP id a640c23a62f3a-b6474b3716cmr89629866b.42.1760642555882;
        Thu, 16 Oct 2025 12:22:35 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f27:2100:21e7:7c7d:15e0:869f? (p200300ea8f27210021e77c7d15e0869f.dip0.t-ipconnect.de. [2003:ea:8f27:2100:21e7:7c7d:15e0:869f])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b5cb965c3a9sm583152566b.16.2025.10.16.12.22.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 12:22:35 -0700 (PDT)
Message-ID: <9ece6040-58fd-4e87-bc05-a33b7341904a@gmail.com>
Date: Thu, 16 Oct 2025 21:22:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] r8169: reconfigure rx unconditionally before
 chip reset when resuming
To: Simon Horman <horms@kernel.org>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <418fbd41-6ec5-4c86-9bc3-e68d3333913f@gmail.com>
 <aPDlC12BWk6Q_bTY@horms.kernel.org>
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
In-Reply-To: <aPDlC12BWk6Q_bTY@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/2025 2:28 PM, Simon Horman wrote:
> On Wed, Oct 15, 2025 at 10:12:44PM +0200, Heiner Kallweit wrote:
>> There's a good chance that more chip versions suffer from the same
>> hw issue. So let's reconfigure rx unconditionally before the chip reset
>> when resuming. This shouldn't have any side effect on unaffected chip
>> versions.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> Hi Heiner,
> 
> This patch looks good to me. But I think it needs to be reposted - so that
> it applies to net-next - one net has been merged into net-next so the
> following patch is present.
> 
Thanks for the review. Right, I was under the impression that net was
already merged back. I'll resubmit.

> commit 70f92ab97042 ("r8169: fix packet truncation after S4 resume on RTL8168H/RTL8111H")
> 
> Please feel free to add.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> 


