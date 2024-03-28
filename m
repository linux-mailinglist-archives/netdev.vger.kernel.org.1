Return-Path: <netdev+bounces-82735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 656F888F815
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 07:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D69F21F23B70
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 06:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9171DA21;
	Thu, 28 Mar 2024 06:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/6mMKM0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28079386
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 06:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711608591; cv=none; b=qM52ptol1ZA4Fi5IbjC0jGTUuUVhJeMM0S2LEJSlB308D08LMq2JLIYNvC/RgCVMoxwqoxxLMvT7fQd+rwMmZcRtFzlIkwom5HRqvgCreN+FkxSg4Fk4hK7Ous4at6FDtLYS6m047FfT5cGoQkevcIEl0kWVR8l3tZWiEM6B1EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711608591; c=relaxed/simple;
	bh=ZrC3pr0hwy0QsgWyfhvgBQXDsGRT0oPPRWr/0BKX9oo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JhURT9UbVtJPMYEH2wh6OyVGKJ3knGBJxrxg/aKlspcGXmNZQBtp99qtju60ytSTSH3X16Oyh3C8n24tiWARHC/cNS+mjsfBbKI5IC3T0KTQJvx9I0UfGzLcBnR+2zOvdz/gwrvLtEcwZGWSPPEQHy7ag5szOyI8cRn+CYkMhmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/6mMKM0; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33ed6078884so903382f8f.1
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 23:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711608588; x=1712213388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rI6V37SnYDYbURnF1urBy7OvJmctsdnVYB8EYoTFMQ0=;
        b=c/6mMKM0Nz5VzSSVOM6w7ajLjJwCg701Z918nFdJLtaQNDDn4kpJyHkIJsBwiZGVLK
         ao++ZZl61N79NGbxkSsVR63pBehZ2GbdcXky0ax8LefYUDR9QsRycwvciIIt3MFZPDOc
         CEcaO5SdjEipsLmWG3C0dHW+CAef08N6MyowFEWA1LF3nrTEsBKxVjHACoNB3Wlt4ZeF
         WxaKZpq5thVOf1mgwaF0f9XDyrt/SfG15F/SZw4YYl8B9Q2jpjROl7J0eVfoxmWpQtej
         /WCGeMGPFRWKm1gybiAp5YodLJ/3Tox8p1FhwCiBY6x9hhAJxMORugGSQ+dcvkVRDuGB
         Sz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711608588; x=1712213388;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rI6V37SnYDYbURnF1urBy7OvJmctsdnVYB8EYoTFMQ0=;
        b=XtLjNGSGoB2dfMiCJW1j74OZVh/sa/krTyX9VdefRywV0mFrLSRDh0sozkq+vk8ACq
         MtudKsNXe9chMXJT7gOQt+tvdUzT6JMUKXptQVQ5yaLa20HgYvGFXN/3aZLEODBZdifi
         eX5629uMXpnLq7PBC7B3e4kMIEM5+YPpZNNkcLSX569OrvtYlqdSfFNSl4Ir4rQbP91m
         PCt6O65R9D5Rfv6LOhZr5ICmgWlmE/Jr4rBL3WPyCflP2LfQIPLBMc5PfQ4+R1xvH5p3
         AfN80PakAN7TsNPIIjFmptoHG/nNi2AKsfrglLx7D+I5EpsQ02T505UeXvM5IAbRZkb7
         sgng==
X-Gm-Message-State: AOJu0Yz9056rc3G88CTqVEZOwD5uenq7TO3wut6fp/Cb19+fPfLPpq+z
	84PXSGzzHVfSxS3ec9ZcWBbeFzsVtEx2ZGuLBun/TnG74FPfQJj2
X-Google-Smtp-Source: AGHT+IFOqw6coTgZhzwvW3ZOidrQ6g/VgACJDx6xVYfMfqAgKpNwzUvvncsKOLGdLa0I1FeE2skLvg==
X-Received: by 2002:a05:6000:883:b0:33e:6ef3:b68e with SMTP id cs3-20020a056000088300b0033e6ef3b68emr903079wrb.34.1711608588243;
        Wed, 27 Mar 2024 23:49:48 -0700 (PDT)
Received: from ?IPV6:2a01:c23:b9be:3500:b4fb:6405:2668:9580? (dynamic-2a01-0c23-b9be-3500-b4fb-6405-2668-9580.c23.pool.telefonica.de. [2a01:c23:b9be:3500:b4fb:6405:2668:9580])
        by smtp.googlemail.com with ESMTPSA id e11-20020a056000194b00b00341c6b53358sm870352wry.66.2024.03.27.23.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 23:49:47 -0700 (PDT)
Message-ID: <1c02e074-5511-4c4b-b9f3-b280d3d75a93@gmail.com>
Date: Thu, 28 Mar 2024 07:49:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] r8169: skip DASH fw status checks when DASH is
 disabled
To: Atlas Yu <atlas.yu@canonical.com>, nic_swsd@realtek.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org
References: <20240328055152.18443-1-atlas.yu@canonical.com>
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
In-Reply-To: <20240328055152.18443-1-atlas.yu@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28.03.2024 06:51, Atlas Yu wrote:
> On devices that support DASH, the current code in the "rtl_loop_wait" function
> raises false alarms when DASH is disabled. This occurs because the function
> attempts to wait for the DASH firmware to be ready, even though it's not
> relevant in this case.
> 
> r8169 0000:0c:00.0 eth0: RTL8168ep/8111ep, 38:7c:76:49:08:d9, XID 502, IRQ 86
> r8169 0000:0c:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
> r8169 0000:0c:00.0 eth0: DASH disabled
> ...
> r8169 0000:0c:00.0 eth0: rtl_ep_ocp_read_cond == 0 (loop: 30, delay: 10000).
> 
> This patch modifies the driver start/stop functions to skip checking the DASH
> firmware status when DASH is explicitly disabled. This prevents unnecessary
> delays and false alarms.
> 
> The patch has been tested on several ThinkStation P8/PX workstations.
> 
> Fixes: 0ab0c45d8aae ("r8169: add handling DASH when DASH is disabled")
> Signed-off-by: Atlas Yu <atlas.yu@canonical.com>

You sent a v2 already, so I think this is v3. And the change log is missing.
But as the change is more or less trivial, no need to resubmit IMO.

> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 31 ++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 5c879a5c86d7..4ac444eb269f 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -1314,17 +1314,40 @@ static void rtl8168ep_stop_cmac(struct rtl8169_private *tp)
>  	RTL_W8(tp, IBCR0, RTL_R8(tp, IBCR0) & ~0x01);
>  }
>  
> +static void rtl_dash_loop_wait(struct rtl8169_private *tp,
> +			       const struct rtl_cond *c,
> +			       unsigned long usecs, int n, bool high)
> +{
> +	if (!tp->dash_enabled)
> +		return;
> +	rtl_loop_wait(tp, c, usecs, n, high);
> +}
> +
> +static void rtl_dash_loop_wait_high(struct rtl8169_private *tp,
> +				    const struct rtl_cond *c,
> +				    unsigned long d, int n)
> +{
> +	rtl_dash_loop_wait(tp, c, d, n, true);
> +}
> +
> +static void rtl_dash_loop_wait_low(struct rtl8169_private *tp,
> +				   const struct rtl_cond *c,
> +				   unsigned long d, int n)
> +{
> +	rtl_dash_loop_wait(tp, c, d, n, false);
> +}
> +
>  static void rtl8168dp_driver_start(struct rtl8169_private *tp)
>  {
>  	r8168dp_oob_notify(tp, OOB_CMD_DRIVER_START);
> -	rtl_loop_wait_high(tp, &rtl_dp_ocp_read_cond, 10000, 10);
> +	rtl_dash_loop_wait_high(tp, &rtl_dp_ocp_read_cond, 10000, 10);
>  }
>  
>  static void rtl8168ep_driver_start(struct rtl8169_private *tp)
>  {
>  	r8168ep_ocp_write(tp, 0x01, 0x180, OOB_CMD_DRIVER_START);
>  	r8168ep_ocp_write(tp, 0x01, 0x30, r8168ep_ocp_read(tp, 0x30) | 0x01);
> -	rtl_loop_wait_high(tp, &rtl_ep_ocp_read_cond, 10000, 30);
> +	rtl_dash_loop_wait_high(tp, &rtl_ep_ocp_read_cond, 10000, 30);
>  }
>  
>  static void rtl8168_driver_start(struct rtl8169_private *tp)
> @@ -1338,7 +1361,7 @@ static void rtl8168_driver_start(struct rtl8169_private *tp)
>  static void rtl8168dp_driver_stop(struct rtl8169_private *tp)
>  {
>  	r8168dp_oob_notify(tp, OOB_CMD_DRIVER_STOP);
> -	rtl_loop_wait_low(tp, &rtl_dp_ocp_read_cond, 10000, 10);
> +	rtl_dash_loop_wait_low(tp, &rtl_dp_ocp_read_cond, 10000, 10);
>  }
>  
>  static void rtl8168ep_driver_stop(struct rtl8169_private *tp)
> @@ -1346,7 +1369,7 @@ static void rtl8168ep_driver_stop(struct rtl8169_private *tp)
>  	rtl8168ep_stop_cmac(tp);
>  	r8168ep_ocp_write(tp, 0x01, 0x180, OOB_CMD_DRIVER_STOP);
>  	r8168ep_ocp_write(tp, 0x01, 0x30, r8168ep_ocp_read(tp, 0x30) | 0x01);
> -	rtl_loop_wait_low(tp, &rtl_ep_ocp_read_cond, 10000, 10);
> +	rtl_dash_loop_wait_low(tp, &rtl_ep_ocp_read_cond, 10000, 10);
>  }
>  
>  static void rtl8168_driver_stop(struct rtl8169_private *tp)

Reviewed-by: Heiner Kallweit <hkallweit1@gmail.com>


