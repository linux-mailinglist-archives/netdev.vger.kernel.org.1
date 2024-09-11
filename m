Return-Path: <netdev+bounces-127294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BB8974E5D
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 11:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDB401C261FD
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 09:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3776313C80A;
	Wed, 11 Sep 2024 09:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sk8Pyq3s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D78045C18;
	Wed, 11 Sep 2024 09:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726046219; cv=none; b=Gww6tkqn07GlF4Awk9CA9sLpMbeG9zChJGmfP1DaCOMl5q0eQJm2bypZLyqFWt4FA05QF8WDW6Abk2xXkK0+quarqVz/+oNg0HO8duJKKToKWyszVN0QxdKf9jc3LLQTxFRXdm0IB1PwWg1KpdUcuE6s02WrCltKOPYdh7PHmno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726046219; c=relaxed/simple;
	bh=JpHWEKGUvczSI1BFX4NGLtsJoiCJ5oDKe+gRsjcHih4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SVhM0grBlV1esySwwgThv8M/9O0BtualMCSa/RoqH6KlFPOslWguyTFbNkat6c1ow3gJo5h3cWQx3SDgKmfN2iAWGvBTKcJMwCdVwGz6Rihx+zakY0y5uA68/mBPeMFx0AL4V5pPeNVyzsf97PDXzfaJnrxS56uU1MsiU1Gp9UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sk8Pyq3s; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7aa086b077so611126966b.0;
        Wed, 11 Sep 2024 02:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726046215; x=1726651015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cecQaMVM3YmEyPD0iYKbw+TnwWrhFb+Fl6dt1pnRIOk=;
        b=Sk8Pyq3saCrl4ysnxx0uIhypVBKgpPe8kWu6Yqj2nr1Y6LC5Wi9BpPFFx+fKMAAlDI
         BvRlrwxPMQmG79ejxGGKU7SyIGG7gMwscy+7uDjTkDqun0OLlpkyMNGQ2SZUq/aXXk3U
         vUDKIVFwLIXBDg/YWzRb0QZHxPdDEAJxUqBy1MfBQRfot9ZWvCUkRw0MiXwQ61N7ZSCY
         BnEVI1klwMjd2YeK7AItbHf7AQ8hYGNFVwXWtRfa4467vxGsfbuQDRWuGmciyw/zvrBr
         gCfbgjroc/RUFKbQH5nS8r5yJDb1zp8P+k5Xr/ieeQc9wPvxSauAgSSJ9vxt2XkRxADE
         0riw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726046215; x=1726651015;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cecQaMVM3YmEyPD0iYKbw+TnwWrhFb+Fl6dt1pnRIOk=;
        b=tCzStAiSDmIoB3B9MAvx6xulkV53N+RUI4g6a5S7kY2CnA1uwOAt/T27yf26k8gPqb
         864RwAmpIeLXs43ljmWp8CAHSYW2Ll1wtCjMhNZTAl21pncMOpW3eh6ej/3fJvmLmDxY
         n0oJVndaRipk5SitM0wxIlaLflFZfV64vsLvz9lzWeT0Xt2wrveIbAnc9qy8+3tqpT9d
         CFYKfh1Pqfd+m4ECxGWr2DAtkP6V40E47wPa48FGwG/GDcLTG+CRtjVDZSOTL5da2OpN
         tVxtYOz8XI7GuLBb+Vh3DA5e5KAzmGJFfefn1xJWc9TTb4bmL0r0gAYW16lWEqMNGDl+
         A7FA==
X-Forwarded-Encrypted: i=1; AJvYcCU3L/S/rvxsoxiHoXBcP03SFV+WchPnCTpbZtddBJvzznIegZgc2I05R+I2fSrvUKit1m89JJtCzTmooC0=@vger.kernel.org, AJvYcCU9JMFIADUvZ5ZuXkd63w77m61a6U/L//V0DJENgcV+y7/e0QJxzMGpAzRvTOPtGgaxDivqZR2v@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+87O9xkm9/hZHnAndsye+w5QjaYbAaJPL+hl19BP0Kb3Bgv8l
	XnxnArPDx+vF7nU6H4wx8woxw2aV+UrwBjC+IyG9cNmpe8hOXCF3
X-Google-Smtp-Source: AGHT+IEyJ0Pt9p4wBWUp5SqnL86ZooEkk2UywoiyQWfXg7S/SWy0RGvJLmK8kmRuPn33c8srJHg81g==
X-Received: by 2002:a17:906:794f:b0:a86:91c3:9517 with SMTP id a640c23a62f3a-a8ffab70902mr369210666b.35.1726046214926;
        Wed, 11 Sep 2024 02:16:54 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c1da:1f00:388c:fb65:b9fd:94c3? (dynamic-2a01-0c23-c1da-1f00-388c-fb65-b9fd-94c3.c23.pool.telefonica.de. [2a01:c23:c1da:1f00:388c:fb65:b9fd:94c3])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a8d25a4428fsm589441166b.97.2024.09.11.02.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 02:16:54 -0700 (PDT)
Message-ID: <ed753ef5-3913-413a-ad46-2abe742489b2@gmail.com>
Date: Wed, 11 Sep 2024 11:16:55 +0200
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
In-Reply-To: <CAMqyJG0-35Phq1i3XkTyJfjzk07BNuOvPyDpdbFECzbEPHp_ig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11.09.2024 09:01, En-Wei WU wrote:
>> What is the link partner in your case?
> My link partner is FS S3900-48T4S switch.
> 
>>  If you put a simple switch in between, does this help?
> I just put a simple D-link switch in between with the original kernel,
> the issue remains (re-plugging it after 3 seconds).
> 
>> It makes more the impression that after 3s of link-down the chip (PHY?)
>> transitions to a mode where it doesn't wake up after re-plugging the cable.
> I've done a ftrace on the r8169.ko and the phy driver (realtek.ko),
> and I found that the phy did wake up:
> 
>    kworker/u40:4-267   [003]   297.026314: funcgraph_entry:
>        |      phy_link_change() {
> 3533    kworker/u40:4-267   [003]   297.026315: funcgraph_entry:
>  6.704 us   |        netif_carrier_on();
> 3534    kworker/u40:4-267   [003]   297.026322: funcgraph_entry:
>             |        r8169_phylink_handler() {
> 3535    kworker/u40:4-267   [003]   297.026322: funcgraph_entry:
>  0.257 us   |          rtl_link_chg_patch();
> 3536    kworker/u40:4-267   [003]   297.026324: funcgraph_entry:
>  4.026 us   |          netif_tx_wake_queue();
> 3537    kworker/u40:4-267   [003]   297.026328: funcgraph_entry:
>             |          phy_print_status() {
> 3538    kworker/u40:4-267   [003]   297.026329: funcgraph_entry:
>  0.245 us   |            phy_duplex_to_str();
> 3539    kworker/u40:4-267   [003]   297.026329: funcgraph_entry:
>  0.240 us   |            phy_speed_to_str();
> 3540    kworker/u40:4-267   [003]   297.026329: funcgraph_entry:
> + 12.798 us  |            netdev_info();
> 3541    kworker/u40:4-267   [003]   297.026343: funcgraph_exit:
> + 14.385 us  |          }
> 3542    kworker/u40:4-267   [003]   297.026343: funcgraph_exit:
> + 21.217 us  |        }
> 3543    kworker/u40:4-267   [003]   297.026343: funcgraph_exit:
> + 28.785 us  |      }
> 
> So I doubt that the issue isn't necessarily related to the ALDPS,
> because the PHY seems to have woken up.
> 
> After looking at the reset function (plus the TX queue issue
> previously reported by the user) , I'm wondering if the problem is
> related to DMA:
> static void rtl_reset_work(struct rtl8169_private *tp) {
>     ....
>     for (i = 0; i < NUM_RX_DESC; i++)
>          rtl8169_mark_to_asic(tp->RxDescArray + i);
>     ....
> }
> 
> On Wed, 11 Sept 2024 at 01:06, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> On 09.09.2024 07:25, En-Wei WU wrote:
>>> Hi Heiner,
>>>
>>> Thank you for the quick response.
>>>
>>> On Sat, 7 Sept 2024 at 05:17, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>>
>>>> On 06.09.2024 10:35, En-Wei Wu wrote:
>>>>> The commit 621735f59064 ("r8169: fix rare issue with broken rx after
>>>>> link-down on RTL8125") set a reset work for RTL8125 in
>>>>> r8169_phylink_handler() to avoid the MAC from locking up, this
>>>>> makes the connection broken after unplugging then re-plugging the
>>>>> Ethernet cable.
>>>>>
>>>>> This is because the commit mistakenly put the reset work in the
>>>>> link-down path rather than the link-up path (The commit message says
>>>>> it should be put in the link-up path).
>>>>>
>>>> That's not what the commit message is saying. It says vendor driver
>>>> r8125 does it in the link-up path.
>>>> I moved it intentionally to the link-down path, because traffic may
>>>> be flowing already after link-up.
>>>>
>>>>> Moving the reset work from the link-down path to the link-up path fixes
>>>>> the issue. Also, remove the unnecessary enum member.
>>>>>
>>>> The user who reported the issue at that time confirmed that the original
>>>> change fixed the issue for him.
>>>> Can you explain, from the NICs perspective, what exactly the difference
>>>> is when doing the reset after link-up?
>>>> Including an explanation how the original change suppresses the link-up
>>>> interrupt. And why that's not the case when doing the reset after link-up.
>>>
>>> The host-plug test under original change does have the link-up
>>> interrupt and r8169_phylink_handler() called. There is not much clue
>>> why calling reset in link-down path doesn't work but in link-up does.
>>>
>>> After several new tests, I found that with the original change, the
>>> link won't break if I unplug and then plug the cable within about 3
>>> seconds. On the other hand, the connections always break if I re-plug
>>> the cable after a few seconds.
>>>
>> Interesting finding. 3 seconds sounds like it's unrelated to runtime pm,
>> because this has a 10s delay before the chip is transitioned to D3hot.
>> It makes more the impression that after 3s of link-down the chip (PHY?)
>> transitions to a mode where it doesn't wake up after re-plugging the cable.
>>
>> Just a wild guess: It may be some feature like ALDPS (advanced link-down
>> power saving). Depending on the link partner this may result in not waking
>> up again, namely if the link partner uses ALDPS too.
>> What is the link partner in your case? If you put a simple switch in between,
>> does this help?
>>
>> In the RTL8211F datasheet I found the following:
>>
>> Link Down Power Saving Mode.
>> 1: Reflects local device entered Link Down Power Saving Mode,
>> i.e., cable not plugged in (reflected after 3 sec)
>> 0: With cable plugged in
>>
>> This is a 1Gbps PHY, but Realtek may use the same ALDPS mechanism with the
>> integrated PHY of RTL8125. The 3s delay described there perfectly matches
>> your finding.
>>
>>> With this new patch (reset in link-up path), both of the tests work
>>> without any error.
>>>
>>>>
>>>> I simply want to be convinced enough that your change doesn't break
>>>> behavior for other users.
>>>>
>>>>> Fixes: 621735f59064 ("r8169: fix rare issue with broken rx after link-down on RTL8125")
>>>>> Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
>>>>> ---
>>>>>  drivers/net/ethernet/realtek/r8169_main.c | 11 +++++------
>>>>>  1 file changed, 5 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>>>>> index 3507c2e28110..632e661fc74b 100644
>>>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>>>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>>>>> @@ -590,7 +590,6 @@ struct rtl8169_tc_offsets {
>>>>>  enum rtl_flag {
>>>>>       RTL_FLAG_TASK_ENABLED = 0,
>>>>>       RTL_FLAG_TASK_RESET_PENDING,
>>>>> -     RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE,
>>>>>       RTL_FLAG_TASK_TX_TIMEOUT,
>>>>>       RTL_FLAG_MAX
>>>>>  };
>>>>> @@ -4698,8 +4697,6 @@ static void rtl_task(struct work_struct *work)
>>>>>  reset:
>>>>>               rtl_reset_work(tp);
>>>>>               netif_wake_queue(tp->dev);
>>>>> -     } else if (test_and_clear_bit(RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE, tp->wk.flags)) {
>>>>> -             rtl_reset_work(tp);
>>>>>       }
>>>>>  out_unlock:
>>>>>       rtnl_unlock();
>>>>> @@ -4729,11 +4726,13 @@ static void r8169_phylink_handler(struct net_device *ndev)
>>>>>       if (netif_carrier_ok(ndev)) {
>>>>>               rtl_link_chg_patch(tp);
>>>>>               pm_request_resume(d);
>>>>> -             netif_wake_queue(tp->dev);
>>>>> -     } else {
>>>>> +
>>>>>               /* In few cases rx is broken after link-down otherwise */
>>>>>               if (rtl_is_8125(tp))
>>>>> -                     rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE);
>>>>> +                     rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
>>>>> +             else
>>>>> +                     netif_wake_queue(tp->dev);
>>>>
>>>> This call to netif_wake_queue() isn't needed any longer, it was introduced with
>>>> the original change only.
>>>>
>>>>> +     } else {
>>>>>               pm_runtime_idle(d);
>>>>>       }
>>>>>
>>>>
>>>
>>> CC. Martin Kjær Jørgensen  <me@lagy.org>, could you kindly test if
>>> this new patch works on your environment? Thanks!
>>>
>>> En-Wei,
>>> Best regards.
>>

Just to be sure. Can you test with the following?


diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
index 2c8845e08..cf29b1208 100644
--- a/drivers/net/ethernet/realtek/r8169_phy_config.c
+++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
@@ -1060,6 +1060,7 @@ static void rtl8125a_2_hw_phy_config(struct rtl8169_private *tp,
 	phy_modify_paged(phydev, 0xa86, 0x15, 0x0001, 0x0000);
 	rtl8168g_enable_gphy_10m(phydev);
 
+	rtl8168g_disable_aldps(phydev);
 	rtl8125a_config_eee_phy(phydev);
 }
 
@@ -1099,6 +1100,7 @@ static void rtl8125b_hw_phy_config(struct rtl8169_private *tp,
 	phy_modify_paged(phydev, 0xbf8, 0x12, 0xe000, 0xa000);
 
 	rtl8125_legacy_force_mode(phydev);
+	rtl8168g_disable_aldps(phydev);
 	rtl8125b_config_eee_phy(phydev);
 }
 
-- 
2.46.0



