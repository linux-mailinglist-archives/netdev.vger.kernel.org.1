Return-Path: <netdev+bounces-82247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FE888CEF0
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 21:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E78B3409B8
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 20:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D337A13D622;
	Tue, 26 Mar 2024 20:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXcexzRN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F205013D602
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 20:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484940; cv=none; b=UWlVK5cmfMtaDyhN1erqo2iHSaNadzHMH+5u29Lkpiey6TbeCFpVHVKPl1SJkJXZ8VWS62QICOSk/3AOjMP8kqAeUUUbqYJ4Ts4wR+PdDAZobDl0KdGdZuaH7vSNVfYn5GduxCt7rFAKSkcLkl1M/qUAHVwE7AViijuElAD+OMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484940; c=relaxed/simple;
	bh=ZoYZ8gc0NEU0CpX4gMjwUOLgrEs4OBh8iMq1K9e/yR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ORxXN7ikcir3dgHwIMrCIfKKwjOJ+5ScfrASBlrXkPalHSLA8DOkMP3Ks/WJft4gwXy2egmt4JiR/LTFDgUldpXcBHmD2W9VOnpfl/H1wkBnj8NFTL6DUh75fGHhupSKmVLqk/KoA1j/Z+SRxfJeouItRGse/dYPsGvXO8UUUyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXcexzRN; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5688eaf1165so8259242a12.1
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 13:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711484937; x=1712089737; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Zvo2zzFudCCON+Ag8HAc7SAYQkVnkQ6j9Ni1iDJor50=;
        b=FXcexzRNK/BosaIYJsqC8sDe9GenQUSntT8+rD0sD0cvwZLur/P65WZz7bN6fNpUFz
         DWNxiSQ2veDf/44WWVLDfQCXqX4m/xewPMR9CmVYiHoZ9BxxdE2TeepQrsNmEWdRK42B
         JFOYmCjwELcBQslHRkd4g+WWLC4HAnm/KB3/MpVhiFjDy3n/r9+HPUVcLmhJVRPrQwe9
         eNWgFRdsFPMlADra8owUIDDI+L3i3kHUBNkPWSH2+WCFV6jB7DCdRDUNafi1peyKBIg7
         ry7oXi1t/Z/DlO4sUhXhxCrkfzBklxmPmqHMCBkC7n4t8cgse/X7d9K5+tkTFb3uPfSP
         BUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711484937; x=1712089737;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zvo2zzFudCCON+Ag8HAc7SAYQkVnkQ6j9Ni1iDJor50=;
        b=u2GOdBIgmA9jkWO3xEyso0nFN4OpLgdYIu1NZuXIHvLzl1dvs2HlEKguLcYYGn7Zb0
         cXddeuR6xbF2RB2Hg2x2pYvg5NZAAK0oOTqb63JeDZtXq8LdaeHy9QOX5pG4EHN1JTsR
         eaCfjzMk0bojDIlVunL9qSUPNtG5Fc/vaR/BKiNF2ixOjUtdFmzGEMSbCGfNYlcVCppy
         y6Hr8tLCQXILu53PO0p4aPdKUMLoto1qI827fFF1O8a1whHTdXXEU0/PoCbr4WfJezUK
         5wsyzhK/Suw88pGHwT0EpcK0f/bGqYhgiMgpufmcprdXs3MGxjg+Cy5DO0XF4ddzfiNC
         v3/g==
X-Forwarded-Encrypted: i=1; AJvYcCVIsGoVg0mmENLzy7zqqozukjPlXRsIT4NdtvaxcAHuyzfD3iJlCKplF9YzdYl4Hq7+LPA4cYd8CEmyWBBpNniYiaL/HdWD
X-Gm-Message-State: AOJu0YyGr+ES3Bb5+AYmtJrYdSwKt0cUc9yGmXqo85jUrI3ZaX+jq2L+
	6wjtvTlFrgARGy+dYHIuGgwF/o0RoyGbQ8y74e8cA+CaktL7Elt57L+LohgD
X-Google-Smtp-Source: AGHT+IH03zfrlBSE2xbskqEjigLYvUv/uKzkqfikalanvIR1RjL57vsR+XPeeaDwvTcEnQ0rclvlow==
X-Received: by 2002:a50:954e:0:b0:56b:f2d4:8d9 with SMTP id v14-20020a50954e000000b0056bf2d408d9mr7770049eda.40.1711484936792;
        Tue, 26 Mar 2024 13:28:56 -0700 (PDT)
Received: from ?IPV6:2a01:c22:6f11:a700:a877:8eb2:587c:b36f? (dynamic-2a01-0c22-6f11-a700-a877-8eb2-587c-b36f.c22.pool.telefonica.de. [2a01:c22:6f11:a700:a877:8eb2:587c:b36f])
        by smtp.googlemail.com with ESMTPSA id h28-20020a056402095c00b0056b2c5c58d2sm4470642edz.21.2024.03.26.13.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 13:28:56 -0700 (PDT)
Message-ID: <146be1ba-c0fb-4ed2-8515-319151b1406b@gmail.com>
Date: Tue, 26 Mar 2024 21:28:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: DRY rules - extract into rtl_cond_loop_wait_high()
To: Atlas Yu <atlas.yu@canonical.com>
Cc: davem@davemloft.net, edumazet@google.com, hau@realtek.com,
 kuba@kernel.org, netdev@vger.kernel.org, nic_swsd@realtek.com,
 pabeni@redhat.com
References: <bdfd3a4938e2eb37272a9550c869bb557fb70cab.camel@redhat.com>
 <20240326100802.51343-1-atlas.yu@canonical.com>
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
In-Reply-To: <20240326100802.51343-1-atlas.yu@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26.03.2024 11:08, Atlas Yu wrote:
> On Tue, Mar 26, 2024 at 5:09 PM Paolo Abeni <pabeni@redhat.com> wrote:
> 
>>>  drivers/net/ethernet/realtek/r8169_main.c | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>>> index 5c879a5c86d7..a39520a3f41d 100644
>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>>> @@ -1317,6 +1317,8 @@ static void rtl8168ep_stop_cmac(struct rtl8169_private *tp)
>>>  static void rtl8168dp_driver_start(struct rtl8169_private *tp)
>>>  {
>>>  	r8168dp_oob_notify(tp, OOB_CMD_DRIVER_START);
>>> +	if (!tp->dash_enabled)
>>> +		return;
>>>  	rtl_loop_wait_high(tp, &rtl_dp_ocp_read_cond, 10000, 10);
>>
>> You are replicating this chunk several times. It would probably be
>> better to create a new helper - say rtl_cond_loop_wait_high() or
>> something similar - and use it where needed.
> 
> Sure, will do, thanks for the suggestion.

cond like conditional would be a little too generic here IMO.
Something like rtl_dash_loop_wait_high()/low() would make clear
that the poll loop is relevant only if DASH is enabled.


