Return-Path: <netdev+bounces-36158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D78BD7ADC88
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 17:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id DB773B20B76
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 15:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE6B219F4;
	Mon, 25 Sep 2023 15:59:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2438D2137B
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 15:59:27 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF11116
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 08:59:23 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3231d67aff2so3178244f8f.0
        for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 08:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695657562; x=1696262362; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VSKLdGVd5NzmmZLfJhJvnnpKNx3Fxm64KIP8jF0/b9c=;
        b=WOWjWSvone0/Ri2Dm7VLr/J5h26lDNrdbcKF7h/Wagtm3Rq08eLCpykWdg//6FApdy
         S6FYWmaW/P6KPt7ZA9eay4v8gclrUROuCiMRPu0JbIct7yvEgvHDSOjV+x/2s87gsBIb
         0MmzqrDvd3SdLAZA3JI+hfCdKPvAiXQyZEeYoxU+3kQ8k/Ez28B8vg74C97f70UUExHj
         e0JkMfoc+UekYpWgjfkV5puh51Hml3yIN6nYVsigUn4jN0lZRz7Sfc6iVBFLFPFnNmzG
         q+HyYfz4dDk/DTisKL+1NxaCc2aIRVaHKLjvspI138n710sSGqZq/gaWVWNVKc8ca8PL
         YkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695657562; x=1696262362;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VSKLdGVd5NzmmZLfJhJvnnpKNx3Fxm64KIP8jF0/b9c=;
        b=hSWO6P9rV8LbrkqmPmMlGgt0wwQjXX6ll6oDV6DFiY2p/nvJJk5SjkFZtkDNeQ4eAm
         yo0zIN3QS+pHK0MRczmX78kSYG5AbkKAMTlnVRBWOiwNscF1MKlP6bribS9HetZBo8X3
         Ixmj6KS3MG0sGlikH1/It55L1uajdiJvZZi7iQF1l8g8jWk1r4WwVxi3/SiePf369jpt
         KhBOFjapaQChc50x0e41Ou8pKbi8PIJtyHUaRR+kobPPHnicuiXVxwWmRihhiWQtro9a
         d2Wi0EW8e/Xbh9QGdRX/QEXymKEEqlX/A6ZA0vwbJVcERg6wQZI97BfBOsgeN1KYQKMO
         uAiw==
X-Gm-Message-State: AOJu0YykNiBMjpZ7AIaPW1yCraZdpowGAH61OcKSKE1xOp0nfmgzYOiV
	FzeQZcyC1WsPSjXkLWQDqbM=
X-Google-Smtp-Source: AGHT+IGdrsZamCTW42ZxkbE+Auas21nO6vWffP3eAfxXRBHiINOqiZy5jCqYJpgVHWl2DaXJjkYWcA==
X-Received: by 2002:adf:fdc8:0:b0:31f:9a0d:167f with SMTP id i8-20020adffdc8000000b0031f9a0d167fmr5823121wrs.50.1695657561380;
        Mon, 25 Sep 2023 08:59:21 -0700 (PDT)
Received: from ?IPV6:2a01:c23:bc3d:b00:d10d:a0be:a7f8:7e5e? (dynamic-2a01-0c23-bc3d-0b00-d10d-a0be-a7f8-7e5e.c23.pool.telefonica.de. [2a01:c23:bc3d:b00:d10d:a0be:a7f8:7e5e])
        by smtp.googlemail.com with ESMTPSA id a3-20020a5d5083000000b003198a9d758dsm12287378wrt.78.2023.09.25.08.59.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 08:59:20 -0700 (PDT)
Message-ID: <b0e2f6fb-2a1b-4452-bf49-739a30925fde@gmail.com>
Date: Mon, 25 Sep 2023 17:59:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: r8169 link up but no traffic, and watchdog error
Content-Language: en-US
To: =?UTF-8?Q?Martin_Kj=C3=A6r_J=C3=B8rgensen?= <me@lagy.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 nic_swsd@realtek.com
References: <87zg30a0h9.fsf@lagy.org> <20230809125805.2e3f86ac@kernel.org>
 <87a5taabs9.fsf@mkjws.danelec-net.lan>
 <4ed0991b-5473-409d-b00a-bf71f0877df5@gmail.com>
 <87y1guv5p7.fsf@mkjws.danelec-net.lan>
 <e391ca3b-c3e8-478a-a771-2554b8b828c0@gmail.com> <87ttriqmru.fsf@ws.c.lan>
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
In-Reply-To: <87ttriqmru.fsf@ws.c.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 25.09.2023 17:41, Martin Kjær Jørgensen wrote:
> 
> On Mon, Sep 25 2023, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> 
>> On 25.09.2023 13:30, Martin Kjær Jørgensen wrote:
>>>
>>> On Mon, Sep 25 2023, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>
>>>
>>> There are no PCI extension cards.
>>>
>>
>> Your BIOS signature indicates that the system is a Thinkstation P350.
>> According to the Lenovo website it comes with one Intel-based network port.
>> However you have additional 4 Realtek-based network ports on the mainboard?
>>
> 
> Yes. 2 PCIE cards with two Realtek ethernet controllers each.
> 
>>>> And does the problem occur with all of your NICs?
>>>
>>> No, only the Realtek ones.
>>>
>>>> The exact NIC type might provide a hint, best provide a full dmesg log.
>>> [ 1512.295490] RSP: 0018:ffffbc0240193e88 EFLAGS: 00000246
>>> [ 1512.295492] RAX: ffff998935680000 RBX: ffffdc023faa8e00 RCX: 000000000000001f
>>> [ 1512.295493] RDX: 0000000000000002 RSI: ffffffffb544f718 RDI: ffffffffb543bc32
>>> [ 1512.295494] RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000018
>>> [ 1512.295495] R10: ffff9989356b1dc4 R11: 00000000000058a8 R12: ffffffffb5d981a0
>>> [ 1512.295496] R13: 000001601bd198ef R14: 0000000000000003 R15: 0000000000000000
>>> [ 1512.295497]  ? cpuidle_enter_state+0xbd/0x440
>>> [ 1512.295499]  cpuidle_enter+0x2d/0x40
>>> [ 1512.295501]  do_idle+0x217/0x270
>>> [ 1512.295503]  cpu_startup_entry+0x1d/0x20
>>> [ 1512.295505]  start_secondary+0x11a/0x140
>>> [ 1512.295508]  secondary_startup_64_no_verify+0x17e/0x18b
>>> [ 1512.295510]  </TASK>
>>> [ 1512.295511] ---[ end trace 0000000000000000 ]---
>>> [ 1512.295526] r8169 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM control
>>> [ 1531.322039] r8169 0000:03:00.0 enp3s0: Link is Down
>>> [ 1534.138489] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - flow control rx/tx
>>> [ 1538.177385] r8169 0000:03:00.0 enp3s0: Link is Down
>>> [ 1566.174660] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - flow control rx/tx
>>> [ 1567.839082] r8169 0000:03:00.0 enp3s0: Link is Down
>>> [ 1570.621088] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - flow control rx/tx
>>> [ 1576.294267] r8169 0000:03:00.0: can't disable ASPM; OS doesn't have ASPM control
>>
>> Regarding the following: Issue occurs after few seconds of link-loss.
>> Was this an intentional link-down event?
> 
> Yes, I intentionally unplug the cable at the other end for the link to go down.
> 
>> And is issue always related to link-up after a link-loss period?
>>
> 
> Yes, it happends after cable is plugged in again, so after a link-loss period.
> 
Good to know. I heard this before, under unknown circumstances (Realtek doesn't publish
errata information) the NIC (unclear whether MAC or PHY) seems to hang up after link-loss
in rare cases. Vendor driver does a full hw init on each link-up, maybe this is to work
around the issue we talk about here.

> 
>>> [ 1488.643231] r8169 0000:03:00.0 enp3s0: Link is Down
>>> [ 1506.576941] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full - flow control rx/tx
>>> [ 1512.295215] ------------[ cut here ]------------
>>> [ 1512.295219] NETDEV WATCHDOG: enp3s0 (r8169): transmit queue 0 timed out 5368 ms


