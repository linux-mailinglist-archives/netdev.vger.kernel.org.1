Return-Path: <netdev+bounces-136749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 238DE9A2DC1
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 21:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F453B2274E
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 19:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85360227B80;
	Thu, 17 Oct 2024 19:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ojvr/3F8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9F421D2A3
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 19:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729193265; cv=none; b=aiZ/KyiOvb+wu63EmwB3fmEQGBeUnEMB73FFkC51+dcL0Y17GIGJO5JAz01j99qJ4IyAvU1EI5JfhKqXuRTL9fPaAyYiXiuv+pJoNGwQGXwafszGodpJffG7TXcPBw/WrTNY+Xd/IuQrhnrdTR5WzA43y6lZOOGHWJtndBPwWec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729193265; c=relaxed/simple;
	bh=+XWxjUD1BxRn6B39iiAjumXkCnrAZWNDXfmcJyY8ps4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=am6YtafguTzYeQDUbDR20k1qg9FyR9cpXXLcPF+s92HmYEIVkhyx+R/7hSLu2AshlPu35aQBWm6CQxdYZ8nKspJrWJcoUjOGd8tl/Q2W49cZxr91NHrJbGoIZ7YSxQp2h3P+3W0cEaYHRpO6ZCKwPaDxr4Cl3A+/MmKzEDzv0v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ojvr/3F8; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c9552d02e6so1634238a12.2
        for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 12:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729193258; x=1729798058; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3T9l+OUpspqFN821oic0CsraIjH6knEk38pCL4LtJrk=;
        b=Ojvr/3F8H1xUlYcbSplI7V+Sb6cIOXdaLclO7Gnv3Z02uFy2a3G3uHciSMQO8ZcP/e
         W0c6O7RRX7r4gz1Zmc4pfj9Ux8khc60Qeaxuezh6UHsiOY7znVB9AFb2vlhGD5CpD0v9
         mFRlBZUIXkUkFww0M8JM6sxiTIf3RZSNwBANn8I3IXzB0aO6k9q0+zsGONyRp0D7tdGt
         pquvaQgImXajKOTjZR/FYBc3GVMklDJi3RkbyGCQr1B0bPpLDW6CdOBQ1LoBZVQdvXuo
         GrPuQyECqjCiFmmbdsrIzssu837+f8jSNBFmBFG8RQLzMWB8PFTO5eOrgATvIjCAXLED
         aMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729193258; x=1729798058;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3T9l+OUpspqFN821oic0CsraIjH6knEk38pCL4LtJrk=;
        b=hjc1i/wj7Ej6GNxV3gy8gWEygLomu6avlb7yJf1ZcHedGi267agz4q26yqeRHYFHDY
         T1B58IVhi9pMI5HsaM0Y6SQerlm95A5GY52P1sG2pbwfMePctQPo7l2EX8xJ8X+9TQqO
         PBSpHsEU9gLd+J21fmoegUyBd2eFIq9XK6bLDLIxf0aRETnfLqv4ABcIC8aEP57t8c2v
         2QsaVdy3W76tFLPWra1rmUahmUNDRNN/CLpOucf4Wl3mt53XyCfzjybXijkPFMT/hNuU
         a67TswSXnG4+bBFoTjWrkTF4xGOxHcDam1/V3cVPzrjnlwKoaztPh0CznrAxDzwWh/mZ
         fY5w==
X-Gm-Message-State: AOJu0YyUCRGXoYRPg8KDAZU21BBLkRovjfXpqUV4mc3jywPpp4ELmlHU
	KK1Kbq/fMGFmWgxIZYGLm4At3ambcR6FTQXXrQpQh3rW0hX13FGn
X-Google-Smtp-Source: AGHT+IHh7l7mnN1X+pquLe9fLa6UGDuJ2xaoMn9OoxP0gz5k5Ac2uQrBsO0PyRp844mSAmRiynJHuw==
X-Received: by 2002:a17:907:f19a:b0:a99:f7df:b20a with SMTP id a640c23a62f3a-a9a34e88843mr661297566b.62.1729193257754;
        Thu, 17 Oct 2024 12:27:37 -0700 (PDT)
Received: from ?IPV6:2a02:3100:b38a:4000:88d:c0e7:13bb:6384? (dynamic-2a02-3100-b38a-4000-088d-c0e7-13bb-6384.310.pool.telefonica.de. [2a02:3100:b38a:4000:88d:c0e7:13bb:6384])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9a68c2733esm2032866b.205.2024.10.17.12.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 12:27:36 -0700 (PDT)
Message-ID: <f971d88e-be1f-494b-b754-e992adfe6321@gmail.com>
Date: Thu, 17 Oct 2024 21:27:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: r8169 unknown chip XID 688
To: Luc Willems <luc.willems@t-m-m.be>
Cc: netdev@vger.kernel.org
References: <CAHJ97wTDiqgOHfLJc3pEjz=ZwpWP4LJV7sxUfYxQmkryi-rv0A@mail.gmail.com>
 <73e05f2e-2e0c-4a72-94a6-3f618b0e616e@gmail.com>
 <CAHJ97wRJQ4qm_Hxx=FB8ZzD3O7njLYX7mcPvMvRbsdu=T7VZrg@mail.gmail.com>
 <d49e275f-7526-4eb4-aa9c-31975aecbfc6@gmail.com>
 <CAHJ97wRoaOAXASnWOwADQpL0pcsosRscNyQZFxnTYj76M4eE+g@mail.gmail.com>
 <CAHJ97wSAiwJgA297ry7z37kPut_jqYXGEakkbyKK6tJXvtCmOw@mail.gmail.com>
 <2ada65e1-5dfa-456c-9334-2bc51272e9da@gmail.com>
 <CAHJ97wT1jGSg=1qsbhryxSvk3QWTDtgSTHvkxxjyda-8N1OD4w@mail.gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <CAHJ97wT1jGSg=1qsbhryxSvk3QWTDtgSTHvkxxjyda-8N1OD4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17.10.2024 20:14, Luc Willems wrote:
> install the firmware,
> - static ip assignment using /etc/network/interfaces seems to work ok
> , system reboots in normal time, and connectivity works using iperf3
> (short test)
> - dhcp ip assignment still fails , reboot seems to hang on waiting for
> dhcp client timeout , and after that a second ifdown/ifup sequences
> doesn't seem to work , even ip link show the link up and active
> 
Thanks for the retest. If it works with a static ip then it's unlikely
that the DHCP issue is related to the network driver. This happens on
an upper layer. Best check the DHCP traffic between this system and
the DHCP server with e.g. tcpdump.

> root@prxmox-kernel:~# ifup ens16
> Internet Systems Consortium DHCP Client 4.4.3-P1
> Copyright 2004-2022 Internet Systems Consortium.
> All rights reserved.
> For info, please visit https://www.isc.org/software/dhcp/
> 
> Listening on LPF/ens16/10:ff:e0:6b:66:98
> Sending on   LPF/ens16/10:ff:e0:6b:66:98
> Sending on   Socket/fallback
> DHCPDISCOVER on ens16 to 255.255.255.255 port 67 interval 8
> DHCPDISCOVER on ens16 to 255.255.255.255 port 67 interval 7
> DHCPDISCOVER on ens16 to 255.255.255.255 port 67 interval 12
> DHCPDISCOVER on ens16 to 255.255.255.255 port 67 interval 12
> DHCPDISCOVER on ens16 to 255.255.255.255 port 67 interval 11
> DHCPDISCOVER on ens16 to 255.255.255.255 port 67 interval 11
> No DHCPOFFERS received.
> No working leases in persistent database - sleeping.
> root@prxmox-kernel:~# ip l
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN
> mode DEFAULT group default qlen 1000
>    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> 2: ens18: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel
> state UP mode DEFAULT group default qlen 1000
>    link/ether bc:24:11:e6:79:8f brd ff:ff:ff:ff:ff:ff
>    altname enp0s18
> 3: ens16: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel
> state UP mode DEFAULT group default qlen 1000
>    link/ether 10:ff:e0:6b:66:98 brd ff:ff:ff:ff:ff:ff
>    altname enp0s16
> root@prxmox-kernel:~#
> 
> using hotplug ens16 instead of auto ens16 in the interface seems to
> result in the interface staying down state.
> ethtool also doesn´t provide any useful info.
> 
> switching back to static ip, i can retrieve information using ethtool
> on the interface.
> 
> 
>  luc
> 
> 
> 
> 
> On Wed, Oct 16, 2024 at 7:44 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> On 14.10.2024 14:48, Luc Willems wrote:
>>> small correction, it took some time but dhcp has finally assigned an ip address
>>>
>>> I could run iperf3 on it, getting 2.35Gbits/sec for a short test.
>>> but after reboot i lost connectivity again , even switching to static
>>> ip did not provide a solution.
>>>
>>> so for the moment, not very stable.
>>> seems we need to wait to have specific firmware.
>>>
>> Firmware file has been submitted by Realtek, however it may take time until
>> the next linux-firmware release is published. In the meantime you can get the
>> firmware file from here:
>> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/rtl_nic/rtl8125d-1.fw
>> Just place it under /lib/firmware/rtl_nic/
>>
>>>
>>>
>>>
>>>
>>> On Mon, Oct 14, 2024 at 2:31 PM Luc Willems <luc.willems@t-m-m.be> wrote:
>>>>
>>>> after last patch, i now have an ens16 interface but not able to assign
>>>> ip using static or dhcp
>>>>
>>>> [    0.586421] r8169 0000:00:10.0 eth0: RTL8125D, 10:ff:e0:6b:66:98,
>>>> XID 688, IRQ 46
>>>> [    0.586424] r8169 0000:00:10.0 eth0: jumbo features [frames: 9194
>>>> bytes, tx checksumming: ko]
>>>> [    0.789719] r8169 0000:00:10.0 ens16: renamed from eth0
>>>> [   13.583533] r8169 0000:00:10.0: firmware: failed to load
>>>> rtl_nic/rtl8125d-1.fw (-2)
>>>> [   13.583541] r8169 0000:00:10.0: firmware: failed to load
>>>> rtl_nic/rtl8125d-1.fw (-2)
>>>> [   13.583542] r8169 0000:00:10.0: Direct firmware load for
>>>> rtl_nic/rtl8125d-1.fw failed with error -2
>>>> [   13.583544] r8169 0000:00:10.0: Unable to load firmware
>>>> rtl_nic/rtl8125d-1.fw (-2)
>>>> [   13.609457] RTL8226B_RTL8221B 2.5Gbps PHY r8169-0-80:00: attached
>>>> PHY driver (mii_bus:phy_addr=r8169-0-80:00, irq=MAC)
>>>> [   13.737853] r8169 0000:00:10.0 ens16: Link is Down
>>>> [   16.937666] r8169 0000:00:10.0 ens16: Link is Up - 2.5Gbps/Full -
>>>> flow control rx/tx
>>>> root@prxmox-kernel:~#
>>>>
>>>> On Mon, Oct 14, 2024 at 12:22 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>>>
>>>>> On 14.10.2024 02:05, Luc Willems wrote:
>>>>>> HI ,
>>>>>>
>>>>>> installed the patch on a debian-backports 6.10.11 kernel in a VM (KVM)
>>>>>> with the realtek injected using pci pass through.
>>>>>> i had to modify the patch a bit, removing the RTL_GIGA_MAC_VER_63
>>>>>> related entries because these don't seem to be in this kernel
>>>>>>
>>>>>> running this kernel gives me this result now
>>>>>>
>>>>>> root@prxmox-kernel:~# uname -a
>>>>>> Linux prxmox-kernel 6.10+unreleased-amd64 #1 SMP PREEMPT_DYNAMIC
>>>>>> Debian 6.10.11-1~bpo12+1r8169p1 (2024-10- x86_64 GNU/Linux
>>>>>> root@prxmox-kernel:~# dmesg |grep r8169
>>>>>> [    0.000000] Linux version 6.10+unreleased-amd64
>>>>>> (debian-kernel@lists.debian.org) (x86_64-linux-gnu-gcc-12 (Debian
>>>>>> 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #1 SMP
>>>>>> PREEMPT_DYNAMIC Debian 6.10.
>>>>>> 11-1~bpo12+1r8169p1 (2024-10-
>>>>>> [    0.585895] r8169 0000:00:10.0: no dedicated PHY driver found for
>>>>>> PHY ID 0x001cc841, maybe realtek.ko needs to be added to initramfs?
>>>>>> [    0.586010] r8169 0000:00:10.0: probe with driver r8169 failed with error -49
>>>>>>
>>>>>> root@prxmox-kernel:~# modinfo r8169
>>>>>> filename:
>>>>>> /lib/modules/6.10+unreleased-amd64/kernel/drivers/net/ethernet/realtek/r8169.ko.xz
>>>>>> firmware:       rtl_nic/rtl8126a-2.fw
>>>>>> firmware:       rtl_nic/rtl8125d-1.fw
>>>>>> firmware:       rtl_nic/rtl8125b-2.fw
>>>>>> firmware:       rtl_nic/rtl8125a-3.fw
>>>>>> firmware:       rtl_nic/rtl8107e-2.fw
>>>>>> firmware:       rtl_nic/rtl8168fp-3.fw
>>>>>> firmware:       rtl_nic/rtl8168h-2.fw
>>>>>> firmware:       rtl_nic/rtl8168g-3.fw
>>>>>> firmware:       rtl_nic/rtl8168g-2.fw
>>>>>> firmware:       rtl_nic/rtl8106e-2.fw
>>>>>> firmware:       rtl_nic/rtl8106e-1.fw
>>>>>> firmware:       rtl_nic/rtl8411-2.fw
>>>>>> firmware:       rtl_nic/rtl8411-1.fw
>>>>>> firmware:       rtl_nic/rtl8402-1.fw
>>>>>> firmware:       rtl_nic/rtl8168f-2.fw
>>>>>> firmware:       rtl_nic/rtl8168f-1.fw
>>>>>> firmware:       rtl_nic/rtl8105e-1.fw
>>>>>> firmware:       rtl_nic/rtl8168e-3.fw
>>>>>> firmware:       rtl_nic/rtl8168e-2.fw
>>>>>> firmware:       rtl_nic/rtl8168e-1.fw
>>>>>> firmware:       rtl_nic/rtl8168d-2.fw
>>>>>> firmware:       rtl_nic/rtl8168d-1.fw
>>>>>> license:        GPL
>>>>>> softdep:        pre: realtek
>>>>>> description:    RealTek RTL-8169 Gigabit Ethernet driver
>>>>>> author:         Realtek and the Linux r8169 crew <netdev@vger.kernel.org>
>>>>>> alias:          pci:v000010ECd00003000sv*sd*bc*sc*i*
>>>>>> alias:          pci:v000010ECd00008126sv*sd*bc*sc*i*
>>>>>> alias:          pci:v000010ECd00008125sv*sd*bc*sc*i*
>>>>>> alias:          pci:v00000001d00008168sv*sd00002410bc*sc*i*
>>>>>> alias:          pci:v00001737d00001032sv*sd00000024bc*sc*i*
>>>>>> alias:          pci:v000016ECd00000116sv*sd*bc*sc*i*
>>>>>> alias:          pci:v00001259d0000C107sv*sd*bc*sc*i*
>>>>>> alias:          pci:v00001186d00004302sv*sd*bc*sc*i*
>>>>>> alias:          pci:v00001186d00004300sv*sd*bc*sc*i*
>>>>>> alias:          pci:v00001186d00004300sv00001186sd00004B10bc*sc*i*
>>>>>> alias:          pci:v000010ECd00008169sv*sd*bc*sc*i*
>>>>>> alias:          pci:v000010FFd00008168sv*sd*bc*sc*i*
>>>>>> alias:          pci:v000010ECd00008168sv*sd*bc*sc*i*
>>>>>> alias:          pci:v000010ECd00008167sv*sd*bc*sc*i*
>>>>>> alias:          pci:v000010ECd00008162sv*sd*bc*sc*i*
>>>>>> alias:          pci:v000010ECd00008161sv*sd*bc*sc*i*
>>>>>> alias:          pci:v000010ECd00008136sv*sd*bc*sc*i*
>>>>>> alias:          pci:v000010ECd00008129sv*sd*bc*sc*i*
>>>>>> alias:          pci:v000010ECd00002600sv*sd*bc*sc*i*
>>>>>> alias:          pci:v000010ECd00002502sv*sd*bc*sc*i*
>>>>>> depends:        libphy,mdio_devres
>>>>>> retpoline:      Y
>>>>>> intree:         Y
>>>>>> name:           r8169
>>>>>> vermagic:       6.10+unreleased-amd64 SMP preempt mod_unload modversions
>>>>>>
>>>>>> root@prxmox-kernel:~# lsmod |grep real
>>>>>> realtek                45056  0
>>>>>> libphy                225280  3 r8169,mdio_devres,realtek
>>>>>> root@prxmox-kernel:~#
>>>>>>
>>>>>> On Sun, Oct 13, 2024 at 10:44 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>>>>>
>>>>>>> On 12.10.2024 21:03, Luc Willems wrote:
>>>>>>>> using new gigabyte X870E AORUS ELITE WIFI7 board, running proxmox pve kernel
>>>>>>>>
>>>>>>>> Linux linux-s05 6.8.12-2-pve #1 SMP PREEMPT_DYNAMIC PMX 6.8.12-2
>>>>>>>> (2024-09-05T10:03Z) x86_64 GNU/Linux
>>>>>>>>
>>>>>>>> 11:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125
>>>>>>>> 2.5GbE Controller (rev 0c)
>>>>>>>>         Subsystem: Gigabyte Technology Co., Ltd RTL8125 2.5GbE Controller
>>>>>>>>         Flags: fast devsel, IRQ 43, IOMMU group 26
>>>>>>>>         I/O ports at e000 [size=256]
>>>>>>>>         Memory at dd900000 (64-bit, non-prefetchable) [size=64K]
>>>>>>>>         Memory at dd910000 (64-bit, non-prefetchable) [size=16K]
>>>>>>>>         Capabilities: [40] Power Management version 3
>>>>>>>>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
>>>>>>>>         Capabilities: [70] Express Endpoint, MSI 01
>>>>>>>>         Capabilities: [b0] MSI-X: Enable- Count=64 Masked-
>>>>>>>>         Capabilities: [d0] Vital Product Data
>>>>>>>>         Capabilities: [100] Advanced Error Reporting
>>>>>>>>         Capabilities: [148] Virtual Channel
>>>>>>>>         Capabilities: [164] Device Serial Number 01-00-00-00-68-4c-e0-00
>>>>>>>>         Capabilities: [174] Transaction Processing Hints
>>>>>>>>         Capabilities: [200] Latency Tolerance Reporting
>>>>>>>>         Capabilities: [208] L1 PM Substates
>>>>>>>>         Capabilities: [218] Vendor Specific Information: ID=0002 Rev=4
>>>>>>>> Len=100 <?>
>>>>>>>>         Kernel modules: r8169
>>>>>>>>
>>>>>>>> root@linux-s05:/root# dmesg |grep r8169
>>>>>>>> [    6.353276] r8169 0000:11:00.0: error -ENODEV: unknown chip XID
>>>>>>>> 688, contact r8169 maintainers (see MAINTAINERS file)
>>>>>>>>
>>>>>>>
>>>>>>> Below is a patch with experimental support for RTL8125D. Could you
>>>>>>> please test it? Few notes:
>>>>>>> - Depending on the PHY ID of the integrated PHY you may receive an
>>>>>>>   error message that there's no dedicated PHY driver. Please forward the
>>>>>>>   error message with the PHY ID in this case.
>>>>>>> - As long as the firmware for this chip version isn't available, link
>>>>>>>   might be unstable or worst case completely missing. Driver will complain
>>>>>>>   about the missing firmware file, but this error message can be ignored for now.
>>>>>>>
>>>>>>> ---
>>>>>>>  drivers/net/ethernet/realtek/r8169.h          |  1 +
>>>>>>>  drivers/net/ethernet/realtek/r8169_main.c     | 23 +++++++++++++------
>>>>>>>  .../net/ethernet/realtek/r8169_phy_config.c   |  7 ++++++
>>>>>>>  3 files changed, 24 insertions(+), 7 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
>>>>>>> index e2db944e6..be4c96226 100644
>>>>>>> --- a/drivers/net/ethernet/realtek/r8169.h
>>>>>>> +++ b/drivers/net/ethernet/realtek/r8169.h
>>>>>>> @@ -68,6 +68,7 @@ enum mac_version {
>>>>>>>         /* support for RTL_GIGA_MAC_VER_60 has been removed */
>>>>>>>         RTL_GIGA_MAC_VER_61,
>>>>>>>         RTL_GIGA_MAC_VER_63,
>>>>>>> +       RTL_GIGA_MAC_VER_64,
>>>>>>>         RTL_GIGA_MAC_VER_65,
>>>>>>>         RTL_GIGA_MAC_VER_66,
>>>>>>>         RTL_GIGA_MAC_NONE
>>>>>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>>>>>>> index 1a2322824..dcd176a77 100644
>>>>>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>>>>>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>>>>>>> @@ -56,6 +56,7 @@
>>>>>>>  #define FIRMWARE_8107E_2       "rtl_nic/rtl8107e-2.fw"
>>>>>>>  #define FIRMWARE_8125A_3       "rtl_nic/rtl8125a-3.fw"
>>>>>>>  #define FIRMWARE_8125B_2       "rtl_nic/rtl8125b-2.fw"
>>>>>>> +#define FIRMWARE_8125D_1       "rtl_nic/rtl8125d-1.fw"
>>>>>>>  #define FIRMWARE_8126A_2       "rtl_nic/rtl8126a-2.fw"
>>>>>>>  #define FIRMWARE_8126A_3       "rtl_nic/rtl8126a-3.fw"
>>>>>>>
>>>>>>> @@ -139,6 +140,7 @@ static const struct {
>>>>>>>         [RTL_GIGA_MAC_VER_61] = {"RTL8125A",            FIRMWARE_8125A_3},
>>>>>>>         /* reserve 62 for CFG_METHOD_4 in the vendor driver */
>>>>>>>         [RTL_GIGA_MAC_VER_63] = {"RTL8125B",            FIRMWARE_8125B_2},
>>>>>>> +       [RTL_GIGA_MAC_VER_64] = {"RTL8125D",            FIRMWARE_8125D_1},
>>>>>>>         [RTL_GIGA_MAC_VER_65] = {"RTL8126A",            FIRMWARE_8126A_2},
>>>>>>>         [RTL_GIGA_MAC_VER_66] = {"RTL8126A",            FIRMWARE_8126A_3},
>>>>>>>  };
>>>>>>> @@ -708,6 +710,7 @@ MODULE_FIRMWARE(FIRMWARE_8168FP_3);
>>>>>>>  MODULE_FIRMWARE(FIRMWARE_8107E_2);
>>>>>>>  MODULE_FIRMWARE(FIRMWARE_8125A_3);
>>>>>>>  MODULE_FIRMWARE(FIRMWARE_8125B_2);
>>>>>>> +MODULE_FIRMWARE(FIRMWARE_8125D_1);
>>>>>>>  MODULE_FIRMWARE(FIRMWARE_8126A_2);
>>>>>>>  MODULE_FIRMWARE(FIRMWARE_8126A_3);
>>>>>>>
>>>>>>> @@ -2099,10 +2102,7 @@ static void rtl_set_eee_txidle_timer(struct rtl8169_private *tp)
>>>>>>>                 tp->tx_lpi_timer = timer_val;
>>>>>>>                 r8168_mac_ocp_write(tp, 0xe048, timer_val);
>>>>>>>                 break;
>>>>>>> -       case RTL_GIGA_MAC_VER_61:
>>>>>>> -       case RTL_GIGA_MAC_VER_63:
>>>>>>> -       case RTL_GIGA_MAC_VER_65:
>>>>>>> -       case RTL_GIGA_MAC_VER_66:
>>>>>>> +       case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_66:
>>>>>>>                 tp->tx_lpi_timer = timer_val;
>>>>>>>                 RTL_W16(tp, EEE_TXIDLE_TIMER_8125, timer_val);
>>>>>>>                 break;
>>>>>>> @@ -2234,6 +2234,9 @@ static enum mac_version rtl8169_get_mac_version(u16 xid, bool gmii)
>>>>>>>                 { 0x7cf, 0x64a, RTL_GIGA_MAC_VER_66 },
>>>>>>>                 { 0x7cf, 0x649, RTL_GIGA_MAC_VER_65 },
>>>>>>>
>>>>>>> +               /* 8125D family. */
>>>>>>> +               { 0x7cf, 0x688, RTL_GIGA_MAC_VER_64 },
>>>>>>> +
>>>>>>>                 /* 8125B family. */
>>>>>>>                 { 0x7cf, 0x641, RTL_GIGA_MAC_VER_63 },
>>>>>>>
>>>>>>> @@ -2501,9 +2504,7 @@ static void rtl_init_rxcfg(struct rtl8169_private *tp)
>>>>>>>         case RTL_GIGA_MAC_VER_61:
>>>>>>>                 RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST);
>>>>>>>                 break;
>>>>>>> -       case RTL_GIGA_MAC_VER_63:
>>>>>>> -       case RTL_GIGA_MAC_VER_65:
>>>>>>> -       case RTL_GIGA_MAC_VER_66:
>>>>>>> +       case RTL_GIGA_MAC_VER_63 ... RTL_GIGA_MAC_VER_66:
>>>>>>>                 RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST |
>>>>>>>                         RX_PAUSE_SLOT_ON);
>>>>>>>                 break;
>>>>>>> @@ -3815,6 +3816,12 @@ static void rtl_hw_start_8125b(struct rtl8169_private *tp)
>>>>>>>         rtl_hw_start_8125_common(tp);
>>>>>>>  }
>>>>>>>
>>>>>>> +static void rtl_hw_start_8125d(struct rtl8169_private *tp)
>>>>>>> +{
>>>>>>> +       rtl_set_def_aspm_entry_latency(tp);
>>>>>>> +       rtl_hw_start_8125_common(tp);
>>>>>>> +}
>>>>>>> +
>>>>>>>  static void rtl_hw_start_8126a(struct rtl8169_private *tp)
>>>>>>>  {
>>>>>>>         rtl_set_def_aspm_entry_latency(tp);
>>>>>>> @@ -3863,6 +3870,7 @@ static void rtl_hw_config(struct rtl8169_private *tp)
>>>>>>>                 [RTL_GIGA_MAC_VER_53] = rtl_hw_start_8117,
>>>>>>>                 [RTL_GIGA_MAC_VER_61] = rtl_hw_start_8125a_2,
>>>>>>>                 [RTL_GIGA_MAC_VER_63] = rtl_hw_start_8125b,
>>>>>>> +               [RTL_GIGA_MAC_VER_64] = rtl_hw_start_8125d,
>>>>>>>                 [RTL_GIGA_MAC_VER_65] = rtl_hw_start_8126a,
>>>>>>>                 [RTL_GIGA_MAC_VER_66] = rtl_hw_start_8126a,
>>>>>>>         };
>>>>>>> @@ -3880,6 +3888,7 @@ static void rtl_hw_start_8125(struct rtl8169_private *tp)
>>>>>>>         /* disable interrupt coalescing */
>>>>>>>         switch (tp->mac_version) {
>>>>>>>         case RTL_GIGA_MAC_VER_61:
>>>>>>> +       case RTL_GIGA_MAC_VER_64:
>>>>>>>                 for (i = 0xa00; i < 0xb00; i += 4)
>>>>>>>                         RTL_W32(tp, i, 0);
>>>>>>>                 break;
>>>>>>> diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
>>>>>>> index cf29b1208..6b70f23c8 100644
>>>>>>> --- a/drivers/net/ethernet/realtek/r8169_phy_config.c
>>>>>>> +++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
>>>>>>> @@ -1104,6 +1104,12 @@ static void rtl8125b_hw_phy_config(struct rtl8169_private *tp,
>>>>>>>         rtl8125b_config_eee_phy(phydev);
>>>>>>>  }
>>>>>>>
>>>>>>> +static void rtl8125d_hw_phy_config(struct rtl8169_private *tp,
>>>>>>> +                                  struct phy_device *phydev)
>>>>>>> +{
>>>>>>> +       r8169_apply_firmware(tp);
>>>>>>> +}
>>>>>>> +
>>>>>>>  static void rtl8126a_hw_phy_config(struct rtl8169_private *tp,
>>>>>>>                                    struct phy_device *phydev)
>>>>>>>  {
>>>>>>> @@ -1160,6 +1166,7 @@ void r8169_hw_phy_config(struct rtl8169_private *tp, struct phy_device *phydev,
>>>>>>>                 [RTL_GIGA_MAC_VER_53] = rtl8117_hw_phy_config,
>>>>>>>                 [RTL_GIGA_MAC_VER_61] = rtl8125a_2_hw_phy_config,
>>>>>>>                 [RTL_GIGA_MAC_VER_63] = rtl8125b_hw_phy_config,
>>>>>>> +               [RTL_GIGA_MAC_VER_64] = rtl8125d_hw_phy_config,
>>>>>>>                 [RTL_GIGA_MAC_VER_65] = rtl8126a_hw_phy_config,
>>>>>>>                 [RTL_GIGA_MAC_VER_66] = rtl8126a_hw_phy_config,
>>>>>>>         };
>>>>>>> --
>>>>>>> 2.47.0
>>>>>>>
>>>>>>>
>>>>>>
>>>>>>
>>>>>
>>>>> Thanks for testing. For PHY ID 0x001cc841 there's no PHY driver yet.
>>>>> Following isn't a proper patch but just a quick hack to see whether
>>>>> it makes your NIC work. Could you please apply this change on top
>>>>> and re-test?
>>>>>
>>>>> diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
>>>>> index 166f6a728..1bb8139cb 100644
>>>>> --- a/drivers/net/phy/realtek.c
>>>>> +++ b/drivers/net/phy/realtek.c
>>>>> @@ -1348,7 +1348,7 @@ static struct phy_driver realtek_drvs[] = {
>>>>>                 .read_mmd       = rtl822x_read_mmd,
>>>>>                 .write_mmd      = rtl822x_write_mmd,
>>>>>         }, {
>>>>> -               PHY_ID_MATCH_EXACT(0x001cc840),
>>>>> +               PHY_ID_MATCH_EXACT(0x001cc841),
>>>>>                 .name           = "RTL8226B_RTL8221B 2.5Gbps PHY",
>>>>>                 .get_features   = rtl822x_get_features,
>>>>>                 .config_aneg    = rtl822x_config_aneg,
>>>>>
>>>>>
>>>>>
>>>>
>>>>
>>>> --
>>>> T.M.M BV
>>>> Luc Willems
>>>> Schoolblok 7
>>>> 2275 Lille
>>>>
>>>>
>>>> mobile: 0478/959140
>>>> email: luc.willems@t-m-m.be
>>>
>>>
>>>
>>
> 
> 


