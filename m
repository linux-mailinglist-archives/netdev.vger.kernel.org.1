Return-Path: <netdev+bounces-127337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E69975147
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E94282BA1
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 11:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9E8187553;
	Wed, 11 Sep 2024 11:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWfdgcSI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C200183CB1;
	Wed, 11 Sep 2024 11:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726055904; cv=none; b=ad0Oy/GXG3Vs/tTZMgCPH8pP8xV7/zTtO9PhcfcWw6R5zkLYiUWQnE6sdxC6P9cvVtfHdvueGz51hJujDulxbhnmtVCOvtEGsz+580Om2yGNu4sftJd6ev0ARGgsxK2u/UgGHumdP/RAxV2GN/gsEpXkT6qvw7llVcJdArZdkgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726055904; c=relaxed/simple;
	bh=xABGdkgXo9X0O6nDbWsstjxEV2jCusNpcg1Cb/WtjJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z9ZF6OEgvNWdLGy2OfE8RRaHZml3FH+l7ZQz1BG/E/kfeeNXjHef8nZc7Ax4MRdPdBFA5SZUV3z3j4rlnOMzxAIRSlyz4xvD4HfsdeRHCK1fAQrJZhB6y/45SXYCjPkpkDohwCXYWcZAR6btaOfJFDTyxh+oWcVibq5EaP1IAZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWfdgcSI; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8d29b7edc2so598972466b.1;
        Wed, 11 Sep 2024 04:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726055900; x=1726660700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8/ykPbCcMBT1REl0oijXhNsOnxJmlkgZ9Y5nc979PUU=;
        b=ZWfdgcSIzAxPyrIHBHxPvB1ZU4KlxVKz7nQza/isRrrtm5iiPhuQSKyGK2rW+hUOeW
         8jtqUlQdyyRV2BYUe2SixLyu+bd9ZS4P9jYAxu0ncpGHYh+7dedNTIKF9WFNlItQQkDx
         aIBLkj/Uz7sk4iqUM/5e/yrIrKTuT+tz7pI6zFhjLvvuieBsMx1suYvFy1f3PVpcRuCX
         kJ55+MQ5jPVeTekLd+2a3uancaHkqXvSCiRSFHpKzSUQJv4TJx+EFc7BJhsybHYf09SR
         VWd5R275GV9SwpnW2r7dDDPxqLZEPz5KlBrOnMg+Su/hpnCC4zh6lCO9IOZakenJ0qFK
         dLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726055900; x=1726660700;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8/ykPbCcMBT1REl0oijXhNsOnxJmlkgZ9Y5nc979PUU=;
        b=ljyILDgbvCIuePMvXbE4OoMg8iE0knPed1MdroaxxAIrQGFjXy3B67ineyFcsOm9iB
         chTUR7pB6HmpM3C0LRcAkhD04RtHoRIP6seTmXXBcwUkKcaBm7tLg15CNyxFaHTgCuBy
         Ks42zKWhIScgeqqvSB14LxyQxhfHjudYCVadKi/J8V0xuHzw8ZwXvrtaz8NvTRlH1Qta
         czkbRPwiq4HOV0GCvJ0aNLgRfKrWfXLD4VO1Q/KizkuVsuvBRideUn0WhOhzVJfASXZ+
         ELEzwGvPDfMlHcEND3pfnRR+7gvRlCNDAHmzHjPsSv1oasRGE0UjAxAvauHqnXnmJq62
         GIAw==
X-Forwarded-Encrypted: i=1; AJvYcCV96tQjVW7xCgmeYkLCloRKlvbeZ6Y5Sc4M3xvbTjNIMOOmno9MDuiezKA7GKtlF7+AbsqA5hvfC7pTWgE=@vger.kernel.org, AJvYcCWXnyoXVhbb0PAvGctRIRSgolBQ9APOLg16AvgbPe9JmfDWeAf4rU1JdzbehGTEmhl3Bln+Mwpy@vger.kernel.org
X-Gm-Message-State: AOJu0YxO54oybmaxxXerRKBZxDHy7JulPXYa9On6u3ZiQa9yDJ6IWNbh
	wP+NHVv3dQngG+Z8RXY2I2fvn8bXt5xxaqnVlJ2H+ZRZmAl5tkOL
X-Google-Smtp-Source: AGHT+IH3JSUB2KliOsATn30560MS/cWUUIWxtdv4NPTXqG8oVMEcWu5jHjAPIoB4b0fHVckemwxnWQ==
X-Received: by 2002:a17:907:7245:b0:a8a:926a:d02a with SMTP id a640c23a62f3a-a8ffadc78d1mr353100366b.49.1726055900164;
        Wed, 11 Sep 2024 04:58:20 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c1da:1f00:88d9:a0e5:3a59:e160? (dynamic-2a01-0c23-c1da-1f00-88d9-a0e5-3a59-e160.c23.pool.telefonica.de. [2a01:c23:c1da:1f00:88d9:a0e5:3a59:e160])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a8d25c72e7fsm604765866b.109.2024.09.11.04.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 04:58:19 -0700 (PDT)
Message-ID: <166d0df9-e06e-420e-a074-c33abd422add@gmail.com>
Date: Wed, 11 Sep 2024 13:58:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] r8169: correct the reset timing of RTL8125 for
 link-change event
To: En-Wei WU <en-wei.wu@canonical.com>
Cc: nic_swsd@realtek.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuan-ying.lee@canonical.com,
 kai.heng.feng@canonical.com, me@lagy.org
References: <20240906083539.154019-1-en-wei.wu@canonical.com>
 <8707a2c6-644d-4ccd-989f-1fb66c48d34a@gmail.com>
 <CAMqyJG0FcY0hymX6xyZwiWbD8zdsYwWG7GMu2zcL9-bMkq-pMw@mail.gmail.com>
 <038166f4-9c47-4017-9543-4b4a5ca503f5@gmail.com>
 <CAMqyJG0-35Phq1i3XkTyJfjzk07BNuOvPyDpdbFECzbEPHp_ig@mail.gmail.com>
 <ed753ef5-3913-413a-ad46-2abe742489b2@gmail.com>
 <CAMqyJG1Z13Xkw28jrKKhthJphjBBxmEpsKTVPmuU0auHHz-fxQ@mail.gmail.com>
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
In-Reply-To: <CAMqyJG1Z13Xkw28jrKKhthJphjBBxmEpsKTVPmuU0auHHz-fxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11.09.2024 12:38, En-Wei WU wrote:
>> Also wrt ALDPS: Do you have the firmware for the NIC loaded?
> The firmware is rtl8125b-2_0.0.2 07/13/20
> 
Thanks. Question was because I found an older statement from Realtek
stating that ALDPS requires firmware to work correctly.

>> Just to be sure. Can you test with the following?
> Your patch works for our machine. Seems like the root cause is indeed the ALDPS.
> 
Great! Not sure what's going on, maybe a silicon bug. ALDPS may e.g. stop some
clock and hw misses to re-enable it on link-up. Then I will submit the change
to disable ALDPS. Later we maybe can remove the reset on link-down.

Not having ALDPS shouldn't be too much of an issue. Runtime PM (if enabled)
will put the NIC to D3hot after 10s anyway.

> On Wed, 11 Sept 2024 at 17:16, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> On 11.09.2024 09:01, En-Wei WU wrote:
>>>> What is the link partner in your case?
>>> My link partner is FS S3900-48T4S switch.
>>>
>>>>  If you put a simple switch in between, does this help?
>>> I just put a simple D-link switch in between with the original kernel,
>>> the issue remains (re-plugging it after 3 seconds).
>>>
>>>> It makes more the impression that after 3s of link-down the chip (PHY?)
>>>> transitions to a mode where it doesn't wake up after re-plugging the cable.
>>> I've done a ftrace on the r8169.ko and the phy driver (realtek.ko),
>>> and I found that the phy did wake up:
>>>
>>>    kworker/u40:4-267   [003]   297.026314: funcgraph_entry:
>>>        |      phy_link_change() {
>>> 3533    kworker/u40:4-267   [003]   297.026315: funcgraph_entry:
>>>  6.704 us   |        netif_carrier_on();
>>> 3534    kworker/u40:4-267   [003]   297.026322: funcgraph_entry:
>>>             |        r8169_phylink_handler() {
>>> 3535    kworker/u40:4-267   [003]   297.026322: funcgraph_entry:
>>>  0.257 us   |          rtl_link_chg_patch();
>>> 3536    kworker/u40:4-267   [003]   297.026324: funcgraph_entry:
>>>  4.026 us   |          netif_tx_wake_queue();
>>> 3537    kworker/u40:4-267   [003]   297.026328: funcgraph_entry:
>>>             |          phy_print_status() {
>>> 3538    kworker/u40:4-267   [003]   297.026329: funcgraph_entry:
>>>  0.245 us   |            phy_duplex_to_str();
>>> 3539    kworker/u40:4-267   [003]   297.026329: funcgraph_entry:
>>>  0.240 us   |            phy_speed_to_str();
>>> 3540    kworker/u40:4-267   [003]   297.026329: funcgraph_entry:
>>> + 12.798 us  |            netdev_info();
>>> 3541    kworker/u40:4-267   [003]   297.026343: funcgraph_exit:
>>> + 14.385 us  |          }
>>> 3542    kworker/u40:4-267   [003]   297.026343: funcgraph_exit:
>>> + 21.217 us  |        }
>>> 3543    kworker/u40:4-267   [003]   297.026343: funcgraph_exit:
>>> + 28.785 us  |      }
>>>
>>> So I doubt that the issue isn't necessarily related to the ALDPS,
>>> because the PHY seems to have woken up.
>>>
>>> After looking at the reset function (plus the TX queue issue
>>> previously reported by the user) , I'm wondering if the problem is
>>> related to DMA:
>>> static void rtl_reset_work(struct rtl8169_private *tp) {
>>>     ....
>>>     for (i = 0; i < NUM_RX_DESC; i++)
>>>          rtl8169_mark_to_asic(tp->RxDescArray + i);
>>>     ....
>>> }
>>>
>>> On Wed, 11 Sept 2024 at 01:06, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>>
>>>> On 09.09.2024 07:25, En-Wei WU wrote:
>>>>> Hi Heiner,
>>>>>
>>>>> Thank you for the quick response.
>>>>>
>>>>> On Sat, 7 Sept 2024 at 05:17, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>>>>
>>>>>> On 06.09.2024 10:35, En-Wei Wu wrote:
>>>>>>> The commit 621735f59064 ("r8169: fix rare issue with broken rx after
>>>>>>> link-down on RTL8125") set a reset work for RTL8125 in
>>>>>>> r8169_phylink_handler() to avoid the MAC from locking up, this
>>>>>>> makes the connection broken after unplugging then re-plugging the
>>>>>>> Ethernet cable.
>>>>>>>
>>>>>>> This is because the commit mistakenly put the reset work in the
>>>>>>> link-down path rather than the link-up path (The commit message says
>>>>>>> it should be put in the link-up path).
>>>>>>>
>>>>>> That's not what the commit message is saying. It says vendor driver
>>>>>> r8125 does it in the link-up path.
>>>>>> I moved it intentionally to the link-down path, because traffic may
>>>>>> be flowing already after link-up.
>>>>>>
>>>>>>> Moving the reset work from the link-down path to the link-up path fixes
>>>>>>> the issue. Also, remove the unnecessary enum member.
>>>>>>>
>>>>>> The user who reported the issue at that time confirmed that the original
>>>>>> change fixed the issue for him.
>>>>>> Can you explain, from the NICs perspective, what exactly the difference
>>>>>> is when doing the reset after link-up?
>>>>>> Including an explanation how the original change suppresses the link-up
>>>>>> interrupt. And why that's not the case when doing the reset after link-up.
>>>>>
>>>>> The host-plug test under original change does have the link-up
>>>>> interrupt and r8169_phylink_handler() called. There is not much clue
>>>>> why calling reset in link-down path doesn't work but in link-up does.
>>>>>
>>>>> After several new tests, I found that with the original change, the
>>>>> link won't break if I unplug and then plug the cable within about 3
>>>>> seconds. On the other hand, the connections always break if I re-plug
>>>>> the cable after a few seconds.
>>>>>
>>>> Interesting finding. 3 seconds sounds like it's unrelated to runtime pm,
>>>> because this has a 10s delay before the chip is transitioned to D3hot.
>>>> It makes more the impression that after 3s of link-down the chip (PHY?)
>>>> transitions to a mode where it doesn't wake up after re-plugging the cable.
>>>>
>>>> Just a wild guess: It may be some feature like ALDPS (advanced link-down
>>>> power saving). Depending on the link partner this may result in not waking
>>>> up again, namely if the link partner uses ALDPS too.
>>>> What is the link partner in your case? If you put a simple switch in between,
>>>> does this help?
>>>>
>>>> In the RTL8211F datasheet I found the following:
>>>>
>>>> Link Down Power Saving Mode.
>>>> 1: Reflects local device entered Link Down Power Saving Mode,
>>>> i.e., cable not plugged in (reflected after 3 sec)
>>>> 0: With cable plugged in
>>>>
>>>> This is a 1Gbps PHY, but Realtek may use the same ALDPS mechanism with the
>>>> integrated PHY of RTL8125. The 3s delay described there perfectly matches
>>>> your finding.
>>>>
>>>>> With this new patch (reset in link-up path), both of the tests work
>>>>> without any error.
>>>>>
>>>>>>
>>>>>> I simply want to be convinced enough that your change doesn't break
>>>>>> behavior for other users.
>>>>>>
>>>>>>> Fixes: 621735f59064 ("r8169: fix rare issue with broken rx after link-down on RTL8125")
>>>>>>> Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
>>>>>>> ---
>>>>>>>  drivers/net/ethernet/realtek/r8169_main.c | 11 +++++------
>>>>>>>  1 file changed, 5 insertions(+), 6 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>>>>>>> index 3507c2e28110..632e661fc74b 100644
>>>>>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>>>>>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>>>>>>> @@ -590,7 +590,6 @@ struct rtl8169_tc_offsets {
>>>>>>>  enum rtl_flag {
>>>>>>>       RTL_FLAG_TASK_ENABLED = 0,
>>>>>>>       RTL_FLAG_TASK_RESET_PENDING,
>>>>>>> -     RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE,
>>>>>>>       RTL_FLAG_TASK_TX_TIMEOUT,
>>>>>>>       RTL_FLAG_MAX
>>>>>>>  };
>>>>>>> @@ -4698,8 +4697,6 @@ static void rtl_task(struct work_struct *work)
>>>>>>>  reset:
>>>>>>>               rtl_reset_work(tp);
>>>>>>>               netif_wake_queue(tp->dev);
>>>>>>> -     } else if (test_and_clear_bit(RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE, tp->wk.flags)) {
>>>>>>> -             rtl_reset_work(tp);
>>>>>>>       }
>>>>>>>  out_unlock:
>>>>>>>       rtnl_unlock();
>>>>>>> @@ -4729,11 +4726,13 @@ static void r8169_phylink_handler(struct net_device *ndev)
>>>>>>>       if (netif_carrier_ok(ndev)) {
>>>>>>>               rtl_link_chg_patch(tp);
>>>>>>>               pm_request_resume(d);
>>>>>>> -             netif_wake_queue(tp->dev);
>>>>>>> -     } else {
>>>>>>> +
>>>>>>>               /* In few cases rx is broken after link-down otherwise */
>>>>>>>               if (rtl_is_8125(tp))
>>>>>>> -                     rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE);
>>>>>>> +                     rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
>>>>>>> +             else
>>>>>>> +                     netif_wake_queue(tp->dev);
>>>>>>
>>>>>> This call to netif_wake_queue() isn't needed any longer, it was introduced with
>>>>>> the original change only.
>>>>>>
>>>>>>> +     } else {
>>>>>>>               pm_runtime_idle(d);
>>>>>>>       }
>>>>>>>
>>>>>>
>>>>>
>>>>> CC. Martin Kjær Jørgensen  <me@lagy.org>, could you kindly test if
>>>>> this new patch works on your environment? Thanks!
>>>>>
>>>>> En-Wei,
>>>>> Best regards.
>>>>
>>
>> Just to be sure. Can you test with the following?
>>
>>
>> diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
>> index 2c8845e08..cf29b1208 100644
>> --- a/drivers/net/ethernet/realtek/r8169_phy_config.c
>> +++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
>> @@ -1060,6 +1060,7 @@ static void rtl8125a_2_hw_phy_config(struct rtl8169_private *tp,
>>         phy_modify_paged(phydev, 0xa86, 0x15, 0x0001, 0x0000);
>>         rtl8168g_enable_gphy_10m(phydev);
>>
>> +       rtl8168g_disable_aldps(phydev);
>>         rtl8125a_config_eee_phy(phydev);
>>  }
>>
>> @@ -1099,6 +1100,7 @@ static void rtl8125b_hw_phy_config(struct rtl8169_private *tp,
>>         phy_modify_paged(phydev, 0xbf8, 0x12, 0xe000, 0xa000);
>>
>>         rtl8125_legacy_force_mode(phydev);
>> +       rtl8168g_disable_aldps(phydev);
>>         rtl8125b_config_eee_phy(phydev);
>>  }
>>
>> --
>> 2.46.0
>>
>>


