Return-Path: <netdev+bounces-81375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C11F8887839
	for <lists+netdev@lfdr.de>; Sat, 23 Mar 2024 12:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71BE2281D84
	for <lists+netdev@lfdr.de>; Sat, 23 Mar 2024 11:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FA312E6C;
	Sat, 23 Mar 2024 11:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XerLme4p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD79FC08
	for <netdev@vger.kernel.org>; Sat, 23 Mar 2024 11:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711192710; cv=none; b=gymBQJ3cO9v1hMm37najPkezUFRM5QH22QTRsTnBolj/di3cibm1VIgMQv61X6kCLntgO9PeHiEWSIVtAuhtL3j4Ffd3VEOPIFCrGvkRW8iM6VvufgrXG+p22pzuyfepYgUEE2U2cu+UbKID8shvtEoYPnkT3eaBOIvLZca6skU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711192710; c=relaxed/simple;
	bh=t7H9VddIgNF7Le3I22pMEXzKPFTNVBSEPoukdsqogEs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NW5VpOfc4XlHciy0Hh1in9F4mEwTKmfbi80gOqY2tK8/QPZQWgpeWGV94smlje9ma25nrPY5hvJGC3KDc8zH6o2qoufqoSy21aKRuqAf9cwtuBoBEpXwyVre1RNDQH3GU5jRrjKCJBrQLtky3r8yxiuHBELbBeZVXgghuglKDLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XerLme4p; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56b8248e2d8so3520132a12.1
        for <netdev@vger.kernel.org>; Sat, 23 Mar 2024 04:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711192707; x=1711797507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qGelnZczWxZ/3TH8vMBqp78W1ieQbyvOVjs7YcsbCrw=;
        b=XerLme4pc4jAZ8tIYap83cNPkASTuF8a2XmoLH8h04cKzROE/ArDJPTyWAQDk19hEt
         u21po2gNi8C7WUjnnih9olE28vwX5no3lZDUqv63bErQcUOn4QPLrKd8vf5YyWt5MHMP
         7IrbL7DoXCOddx8SGX5G9w1FJgmZUWtajmzYSrIOexah/ekxa2SrLoMubmSmG0MutjnT
         38XLyG14kyOo/sZb1iv2+yprdpHZ8RFNKTjXNqDEmfqoCHimLSn96KlrlB7SNo571WFK
         gJh1IHSA4pH9V8PKh+3YMA1OdjzNTjy6NZAcoj8sB/PLbfOtrPOZn5PR+Z3d4BLpW8gj
         e93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711192707; x=1711797507;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qGelnZczWxZ/3TH8vMBqp78W1ieQbyvOVjs7YcsbCrw=;
        b=faesXbZddG+WzyPqzhk7ho3fc0N6LQQbA/Yg9Nwah/Wd6+LY32dY1E6TclTSNQZ36p
         RsNl4UaivOUBt6OdSSRuv50X/VUBrW+bE997JMC+kSd5wxZtT2dQmboqlcb2oJOgfeRC
         KbybWPMmjLX1DnkliAB8o3jc1hy9+ROmPTYMiiiaWXExBKqzfmQf48dXEd/ifIuGfhhc
         bAdhFKL76nZx0aTvVMzB68/3Wa7/xCInBYUx5Or2LDI1Id1HoCeuea8sWhEx2Np/2Rfc
         kIweeVFYROJT1GLGKGarbZf/BBnd+q6JOgIFtasgzQrI6BeIIX2zeYDPxCUrXun0n1OQ
         sUTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoy4DAzPcMpM0fCjdKwckHIu1UqoaeOjPm5qK2+bJEM2IiTxFe1QJbbuVQ31+jhVJbDvDSFIkHxvf+BC7fnn01+KAl5ZYZ
X-Gm-Message-State: AOJu0Yx77QHMPZNnYwefmuoZbK41DDE19ytLbd02klNl5Wow47XzkwR9
	GcmrhjJGEilQKRNsWWTLBd8NLclgavCWh7rSs07CkjAB81NqIEqb7LAzHnbJ
X-Google-Smtp-Source: AGHT+IGANwPb9E8o8zWjnDqkodT4bSHjc43YwNlhbEbAiUFMH1YSV82OR3pXXbA055qx4MC2F58Gmg==
X-Received: by 2002:a50:d4cf:0:b0:568:b484:8a04 with SMTP id e15-20020a50d4cf000000b00568b4848a04mr1456498edj.35.1711192706554;
        Sat, 23 Mar 2024 04:18:26 -0700 (PDT)
Received: from ?IPV6:2a01:c23:bc38:af00:d7:3466:9e54:a813? (dynamic-2a01-0c23-bc38-af00-00d7-3466-9e54-a813.c23.pool.telefonica.de. [2a01:c23:bc38:af00:d7:3466:9e54:a813])
        by smtp.googlemail.com with ESMTPSA id i1-20020aa7c9c1000000b005667a11b951sm781396edt.86.2024.03.23.04.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Mar 2024 04:18:25 -0700 (PDT)
Message-ID: <22546b48-27dd-4ac3-924d-aa2ed0386bb0@gmail.com>
Date: Sat, 23 Mar 2024 12:18:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: r8169 link up but no traffic, and watchdog error
From: Heiner Kallweit <hkallweit1@gmail.com>
To: =?UTF-8?Q?Martin_Kj=C3=A6r_J=C3=B8rgensen?= <me@lagy.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 nic_swsd@realtek.com
References: <87zg30a0h9.fsf@lagy.org> <20230809125805.2e3f86ac@kernel.org>
 <87a5taabs9.fsf@mkjws.danelec-net.lan>
 <4ed0991b-5473-409d-b00a-bf71f0877df5@gmail.com>
 <87y1guv5p7.fsf@mkjws.danelec-net.lan>
 <e391ca3b-c3e8-478a-a771-2554b8b828c0@gmail.com> <87ttriqmru.fsf@ws.c.lan>
 <b0e2f6fb-2a1b-4452-bf49-739a30925fde@gmail.com> <871q82fqpk.fsf@lagy.org>
 <d4ec2b3c-4b6a-49d2-a8d9-58eacdeae3b5@gmail.com>
Content-Language: en-US
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
In-Reply-To: <d4ec2b3c-4b6a-49d2-a8d9-58eacdeae3b5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 22.03.2024 13:26, Heiner Kallweit wrote:
> On 22.03.2024 12:28, Martin Kj=C3=A6r J=C3=B8rgensen wrote:
>>
>> On Mon, Sep 25 2023, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>>> On 25.09.2023 17:41, Martin Kj=C3=A6r J=C3=B8rgensen wrote:
>>>>
>>>> On Mon, Sep 25 2023, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>>
>>>>> On 25.09.2023 13:30, Martin Kj=C3=A6r J=C3=B8rgensen wrote:
>>>>>>
>>>>>> On Mon, Sep 25 2023, Heiner Kallweit <hkallweit1@gmail.com> wrote:=

>>>>>>
>>>>>>
>>>>>> There are no PCI extension cards.
>>>>>>
>>>>>
>>>>> Your BIOS signature indicates that the system is a Thinkstation P35=
0.
>>>>> According to the Lenovo website it comes with one Intel-based netwo=
rk port.
>>>>> However you have additional 4 Realtek-based network ports on the ma=
inboard?
>>>>>
>>>>
>>>> Yes. 2 PCIE cards with two Realtek ethernet controllers each.
>>>>
>>>>>>> And does the problem occur with all of your NICs?
>>>>>>
>>>>>> No, only the Realtek ones.
>>>>>>
>>>>>>> The exact NIC type might provide a hint, best provide a full dmes=
g log.
>>>>>> [ 1512.295490] RSP: 0018:ffffbc0240193e88 EFLAGS: 00000246
>>>>>> [ 1512.295492] RAX: ffff998935680000 RBX: ffffdc023faa8e00 RCX: 00=
0000000000001f
>>>>>> [ 1512.295493] RDX: 0000000000000002 RSI: ffffffffb544f718 RDI: ff=
ffffffb543bc32
>>>>>> [ 1512.295494] RBP: 0000000000000003 R08: 0000000000000000 R09: 00=
00000000000018
>>>>>> [ 1512.295495] R10: ffff9989356b1dc4 R11: 00000000000058a8 R12: ff=
ffffffb5d981a0
>>>>>> [ 1512.295496] R13: 000001601bd198ef R14: 0000000000000003 R15: 00=
00000000000000
>>>>>> [ 1512.295497]  ? cpuidle_enter_state+0xbd/0x440
>>>>>> [ 1512.295499]  cpuidle_enter+0x2d/0x40
>>>>>> [ 1512.295501]  do_idle+0x217/0x270
>>>>>> [ 1512.295503]  cpu_startup_entry+0x1d/0x20
>>>>>> [ 1512.295505]  start_secondary+0x11a/0x140
>>>>>> [ 1512.295508]  secondary_startup_64_no_verify+0x17e/0x18b
>>>>>> [ 1512.295510]  </TASK>
>>>>>> [ 1512.295511] ---[ end trace 0000000000000000 ]---
>>>>>> [ 1512.295526] r8169 0000:03:00.0: can't disable ASPM; OS doesn't =
have ASPM control
>>>>>> [ 1531.322039] r8169 0000:03:00.0 enp3s0: Link is Down
>>>>>> [ 1534.138489] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full =
- flow control rx/tx
>>>>>> [ 1538.177385] r8169 0000:03:00.0 enp3s0: Link is Down
>>>>>> [ 1566.174660] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full =
- flow control rx/tx
>>>>>> [ 1567.839082] r8169 0000:03:00.0 enp3s0: Link is Down
>>>>>> [ 1570.621088] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full =
- flow control rx/tx
>>>>>> [ 1576.294267] r8169 0000:03:00.0: can't disable ASPM; OS doesn't =
have ASPM control
>>>>>
>>>>> Regarding the following: Issue occurs after few seconds of link-los=
s.
>>>>> Was this an intentional link-down event?
>>>>
>>>> Yes, I intentionally unplug the cable at the other end for the link =
to go down.
>>>>
>>>>> And is issue always related to link-up after a link-loss period?
>>>>>
>>>>
>>>> Yes, it happends after cable is plugged in again, so after a link-lo=
ss period.
>>>>
>>> Good to know. I heard this before, under unknown circumstances (Realt=
ek doesn't publish
>>> errata information) the NIC (unclear whether MAC or PHY) seems to han=
g up after link-loss
>>> in rare cases. Vendor driver does a full hw init on each link-up, may=
be this is to work
>>> around the issue we talk about here.
>>>
>>>>
>>>>>> [ 1488.643231] r8169 0000:03:00.0 enp3s0: Link is Down
>>>>>> [ 1506.576941] r8169 0000:03:00.0 enp3s0: Link is Up - 1Gbps/Full =
- flow control rx/tx
>>>>>> [ 1512.295215] ------------[ cut here ]------------
>>>>>> [ 1512.295219] NETDEV WATCHDOG: enp3s0 (r8169): transmit queue 0 t=
imed out 5368 ms
>>
>> I am seeing the behavior again with latest 6.6.21 kernel. Like last ti=
me, it
>> helps to manually shutdown and bring up the interface with 'ip link en=
p4s0
>> down/up'
>>
> Latest 6.1 kernel is ok?
> I'm not aware of related any change and other similar reports. Please b=
isect.
>=20
In addition would be good to know whether it's the same with a current ke=
nel: 6.8.1

>>
>> [243277.859725] r8169 0000:04:00.0 enp4s0: Link is Up - 1Gbps/Full - f=
low control off
>> [243283.400061] ------------[ cut here ]------------
>> [243283.400063] NETDEV WATCHDOG: enp4s0 (r8169): transmit queue 0 time=
d out 5537 ms
>> [243283.400070] WARNING: CPU: 3 PID: 2909804 at net/sched/sch_generic.=
c:525 dev_watchdog+0x225/0x230
>> [243283.400073] Modules linked in: tls nfnetlink_queue nfnetlink_log b=
luetooth ecdh_generic ecc xt_nat xt_tcpudp veth xt_conntrack xt_MASQUERAD=
E nf_conntrack_netlink iptable_nat xt_addrtype iptable_filter ip_tables x=
_tables bpfilter br_netfilter overlay authenc echainiv geniv crypto_null =
esp4 xfrm_interface xfrm6_tunnel tunnel4 tunnel6 cmac xfrm_user xfrm_algo=
 nls_utf8 cifs cifs_arc4 nls_ucs2_utils rdma_cm iw_cm ib_cm ib_core cifs_=
md4 dns_resolver fscache netfs snd_seq_dummy snd_hrtimer snd_seq af_packe=
t bridge stp llc cfg80211 rfkill nft_fib_ipv6 nft_nat nft_fib_ipv4 nft_fi=
b nft_masq nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv=
4 nf_tables libcrc32c nls_ascii nls_cp437 vfat fat intel_rapl_msr coretem=
p intel_rapl_common x86_pkg_temp_thermal intel_powerclamp ofpart cmdlinep=
art snd_usb_audio spi_nor iTCO_wdt intel_pmc_bxt kvm_intel mei_wdt snd_us=
bmidi_lib iTCO_vendor_support mei_pxp mei_hdcp ee1004 mtd watchdog snd_hw=
dep r8169 snd_ump kvm snd_rawmidi realtek uvcvideo snd_seq_device snd_pcm=
 mdio_devres
>> [243283.400109]  videobuf2_vmalloc irqbypass of_mdio uvc videobuf2_mem=
ops fixed_phy snd_timer videobuf2_v4l2 think_lmi intel_cstate rtsx_usb_ms=
 fwnode_mdio intel_uncore memstick e1000e rtc_cmos videodev mei_me ftdi_s=
io firmware_attributes_class joydev snd videobuf2_common i2c_i801 ptp spi=
_intel_pci libphy intel_wmi_thunderbolt wmi_bmof mei mc tiny_power_button=
 pps_core spi_intel i2c_smbus usbserial soundcore mousedev thermal fan in=
put_leds int3400_thermal acpi_thermal_rel intel_pmc_core acpi_tad acpi_pa=
d evdev button mac_hid sch_fq_codel msr loop fuse efi_pstore nfnetlink ef=
ivarfs dmi_sysfs dm_crypt trusted asn1_encoder tee ext4 crc32c_generic cr=
c16 mbcache jbd2 hid_logitech_hidpp hid_logitech_dj hid_jabra hid_generic=
 rtsx_usb_sdmmc mmc_core led_class usbhid hid rtsx_usb crc32_pclmul crc32=
c_intel polyval_clmulni polyval_generic gf128mul ghash_clmulni_intel i915=
 sha512_ssse3 sha256_ssse3 sha1_ssse3 xhci_pci ahci xhci_pci_renesas nvme=
 libahci xhci_hcd nvme_core libata nvme_common i2c_algo_bit drm_buddy t10=
_pi ttm usbcore
>> [243283.400142]  crc64_rocksoft_generic aesni_intel drm_display_helper=
 scsi_mod crc64_rocksoft crc_t10dif crct10dif_generic crct10dif_pclmul ce=
c hwmon crypto_simd crc64 rc_core cryptd crct10dif_common usb_common scsi=
_common 8250 8250_base video serial_mctrl_gpio serial_base wmi backlight =
dm_mod dax
>> [243283.400150] CPU: 3 PID: 2909804 Comm: python3.11 Not tainted 6.6.2=
1-gentoo-desktop-r1 #1
>> [243283.400152] Hardware name: LENOVO 30E30051UK/1052, BIOS S0AKT3EA 0=
9/22/2023
>> [243283.400153] RIP: 0010:dev_watchdog+0x225/0x230
>> [243283.400154] Code: ff ff ff 48 89 ef c6 05 08 6c ee 00 01 e8 03 94 =
fa ff 45 89 f8 44 89 f1 48 89 ee 48 89 c2 48 c7 c7 98 c4 37 9a e8 8b 5c 7=
9 ff <0f> 0b e9 27 ff ff ff 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90
>> [243283.400155] RSP: 0000:ffffc9000f3e3df8 EFLAGS: 00010292
>> [243283.400156] RAX: 0000000000000043 RBX: ffff88810b6f841c RCX: 00000=
00000000027
>> [243283.400157] RDX: ffff8890356e04c8 RSI: 0000000000000001 RDI: ffff8=
890356e04c0
>> [243283.400158] RBP: ffff88810b6f8000 R08: 0000000000000000 R09: fffff=
fff9a646ce0
>> [243283.400158] R10: ffffc9000f3e3cb0 R11: ffffffff9a726d28 R12: ffff8=
8810b6f84c8
>> [243283.400159] R13: ffff88810b6e6800 R14: 0000000000000000 R15: 00000=
000000015a1
>> [243283.400159] FS:  00007fb111f89740(0000) GS:ffff8890356c0000(0000) =
knlGS:0000000000000000
>> [243283.400160] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [243283.400161] CR2: 00007fb1041fb030 CR3: 000000044b576002 CR4: 00000=
00000770ee0
>> [243283.400162] PKRU: 55555554
>> [243283.400162] Call Trace:
>> [243283.400163]  <TASK>
>> [243283.400164]  ? dev_watchdog+0x225/0x230
>> [243283.400165]  ? __warn+0x7c/0x130
>> [243283.400168]  ? dev_watchdog+0x225/0x230
>> [243283.400169]  ? report_bug+0x171/0x1a0
>> [243283.400172]  ? handle_bug+0x3a/0x70
>> [243283.400174]  ? exc_invalid_op+0x17/0x70
>> [243283.400175]  ? asm_exc_invalid_op+0x1a/0x20
>> [243283.400178]  ? dev_watchdog+0x225/0x230
>> [243283.400179]  ? dev_watchdog+0x225/0x230
>> [243283.400180]  ? __pfx_dev_watchdog+0x10/0x10
>> [243283.400181]  ? __pfx_dev_watchdog+0x10/0x10
>> [243283.400182]  call_timer_fn+0x1f/0x130
>> [243283.400184]  __run_timers.part.0+0x1bc/0x250
>> [243283.400186]  ? ktime_get+0x34/0xa0
>> [243283.400187]  run_timer_softirq+0x25/0x50
>> [243283.400188]  __do_softirq+0xbd/0x296
>> [243283.400190]  irq_exit_rcu+0x65/0x80
>> [243283.400191]  sysvec_apic_timer_interrupt+0x3e/0x90
>> [243283.400192]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
>> [243283.400194] RIP: 0033:0x7fb111bd3cd5
>> [243283.400195] Code: c8 48 8b 56 08 48 83 c6 08 48 85 d2 75 a7 48 85 =
c0 74 05 48 39 c3 75 09 49 8b 47 10 48 89 44 24 10 48 85 ed 0f 85 8e 00 0=
0 00 <49> 8b 40 28 49 8b 4f 18 48 39 48 18 75 5d 49 8b 85 58 01 00 00 49
>> [243283.400196] RSP: 002b:00007ffd3916a9b0 EFLAGS: 00000246
>> [243283.400196] RAX: 00007fb111bd73c0 RBX: 000056339f603f78 RCX: 00007=
fb111f66aa8
>> [243283.400197] RDX: 0000000000000000 RSI: 00007fb111f04360 RDI: 00007=
fb111f66aa8
>> [243283.400197] RBP: 0000000000000000 R08: 00007fb10410c270 R09: 00007=
fb111f66aa0
>> [243283.400198] R10: 8d3a98eb5e44a685 R11: 1ffffffffffffffe R12: 00007=
ffd3916a9d4
>> [243283.400198] R13: 000056339f603eb0 R14: 00000000000000c8 R15: 00007=
fb111e0dcc0
>> [243283.400199]  </TASK>
>> [243283.400200] ---[ end trace 0000000000000000 ]---
>> [243283.400216] r8169 0000:04:00.0: can't disable ASPM; OS doesn't hav=
e ASPM control
>> [243295.067251] r8169 0000:04:00.0 enp4s0: Link is Down
>> [243297.620960] RTL8226 2.5Gbps PHY r8169-0-400:00: attached PHY drive=
r (mii_bus:phy_addr=3Dr8169-0-400:00, irq=3DMAC)
>> [243297.752106] r8169 0000:04:00.0 enp4s0: Link is Down
>> [243300.656125] r8169 0000:04:00.0 enp4s0: Link is Up - 1Gbps/Full - f=
low control off
>=20


