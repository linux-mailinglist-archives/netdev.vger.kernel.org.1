Return-Path: <netdev+bounces-135140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BAB99C70F
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 12:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47F021C21B1B
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 10:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F4015B11F;
	Mon, 14 Oct 2024 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5gVL+2H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819EA156676
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 10:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728901382; cv=none; b=E49pdlhpKUqia1/Vr7rCFBNueP5cEIULNstbTNjffQPjjFLSDIa/VPJ9qD3vOdNr5ZGFqTd334/VNLzV5j+ppn3SktLJigRx1lxGGLdeRWeyvAIxNYR/1k5zrqQ0SoVZMrDwMXhp2al9lq9BpTqC5wpPb+NK+oER4suyu5zjH+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728901382; c=relaxed/simple;
	bh=VIfiXzpZ2lDerp5GRckwiWhzv0nbbNy+iYWo05oLbUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QZHSGaTT2Zu59r8Q/Ce0Vel8BhaYTIx3xfWXfBeShgN0h0cbUZBfpISL6TRHmzMqjkV/MVK8Wwr8rnle4V74jyaE4rjKoA/GpI4RRFNQSSgEZSI1EFtOjmcdKwq0G5fUm6MIJ5WCrRbtX8q9h7hqH23jwga1Jm2YG8KgpZlcsCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5gVL+2H; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c9404c0d50so4066345a12.3
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 03:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728901379; x=1729506179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GBV2IpMNkVM+sWjxjXH8EQ2f4fGwURqs77gDo5Ouz3g=;
        b=a5gVL+2H8EVW28Lw8E+q1NgwnH4y8WZCfiVMXEJqJgyTlhFIwgi0MuV25GAeGNBfJm
         EqNIhqkUH/90UjypCwkLbXRduUFAoad+ndRyfU36U5CgZSXYiryLite0DcyvbOgc20k6
         nxZxQ4k4OeUatbP7rY6ieffvY+egX3H94Ay1tARxN2TEgKa8KPkd7jFK8wu1FCSvR8vD
         YJ3JvhomoshneBUDSASUzTxeeNtKLoH8+JcZqSGNm9CofdA/gse48poP7An+6tBjZ8O7
         3w2wjk950Qy3H0yMCjiVE+vvtFEeLO3azIdKhdTZov5gGnEHhzdrrmcXkfz/1vY/oDcb
         0Vjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728901379; x=1729506179;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBV2IpMNkVM+sWjxjXH8EQ2f4fGwURqs77gDo5Ouz3g=;
        b=Y/N8/BNMl6XjHiiLDqV+vcdFCJsIGquHriwm9J+WJXxZFZziyFlvQvGEUadpnapAJ1
         v8IZmltC8LOzY9HdBE+NoH1VLa05XfdFciTj7j2hweb8QD2eVL/edmCNrn6LsVQK96ei
         qAV0DNP4RHuZhsJWlCRorho/NUbyJoAWCGHfqT+6drY6UKUAgR6tEtIcLzWS2e6ZjPoD
         yi6/HTyUmoX+kigMdW7xWCp7a5Bn4lSBteEw3mJ+ZYSAxMh3vNgKeSEoW3iI2TswDoKj
         GaMoHc44ZnTtyxxgvvmqymVgCj/sC/hoziCCOtpnafs13IwP86DgF0F6SLjRDJ9elNKd
         BlzQ==
X-Gm-Message-State: AOJu0YzxDr51iXnNNIuq6tQBfZFUUpEXAHIUWZZcvVS+oiEy0MKN4aSA
	qD6dtbiV6mMEwR1//oaX2vkzWvELKETfDL/E1oy2Fj1R3XUgSzuZOOjyWQ==
X-Google-Smtp-Source: AGHT+IGmYj71pZvQfYqfQnIGxDWs6YMtTJnJe2gh4uzmxdbiDYKgaYjMY9jhixtM0IigYMuq5AdjTA==
X-Received: by 2002:a05:6402:278b:b0:5c9:729e:76f2 with SMTP id 4fb4d7f45d1cf-5c9729e7895mr2716778a12.3.1728901378326;
        Mon, 14 Oct 2024 03:22:58 -0700 (PDT)
Received: from ?IPV6:2a02:3100:b2d7:5200:d78:8db7:b864:8ab4? (dynamic-2a02-3100-b2d7-5200-0d78-8db7-b864-8ab4.310.pool.telefonica.de. [2a02:3100:b2d7:5200:d78:8db7:b864:8ab4])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c9372940e3sm4822036a12.81.2024.10.14.03.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 03:22:57 -0700 (PDT)
Message-ID: <d49e275f-7526-4eb4-aa9c-31975aecbfc6@gmail.com>
Date: Mon, 14 Oct 2024 12:22:58 +0200
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
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <CAHJ97wRJQ4qm_Hxx=FB8ZzD3O7njLYX7mcPvMvRbsdu=T7VZrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14.10.2024 02:05, Luc Willems wrote:
> HI ,
> 
> installed the patch on a debian-backports 6.10.11 kernel in a VM (KVM)
> with the realtek injected using pci pass through.
> i had to modify the patch a bit, removing the RTL_GIGA_MAC_VER_63
> related entries because these don't seem to be in this kernel
> 
> running this kernel gives me this result now
> 
> root@prxmox-kernel:~# uname -a
> Linux prxmox-kernel 6.10+unreleased-amd64 #1 SMP PREEMPT_DYNAMIC
> Debian 6.10.11-1~bpo12+1r8169p1 (2024-10- x86_64 GNU/Linux
> root@prxmox-kernel:~# dmesg |grep r8169
> [    0.000000] Linux version 6.10+unreleased-amd64
> (debian-kernel@lists.debian.org) (x86_64-linux-gnu-gcc-12 (Debian
> 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #1 SMP
> PREEMPT_DYNAMIC Debian 6.10.
> 11-1~bpo12+1r8169p1 (2024-10-
> [    0.585895] r8169 0000:00:10.0: no dedicated PHY driver found for
> PHY ID 0x001cc841, maybe realtek.ko needs to be added to initramfs?
> [    0.586010] r8169 0000:00:10.0: probe with driver r8169 failed with error -49
> 
> root@prxmox-kernel:~# modinfo r8169
> filename:
> /lib/modules/6.10+unreleased-amd64/kernel/drivers/net/ethernet/realtek/r8169.ko.xz
> firmware:       rtl_nic/rtl8126a-2.fw
> firmware:       rtl_nic/rtl8125d-1.fw
> firmware:       rtl_nic/rtl8125b-2.fw
> firmware:       rtl_nic/rtl8125a-3.fw
> firmware:       rtl_nic/rtl8107e-2.fw
> firmware:       rtl_nic/rtl8168fp-3.fw
> firmware:       rtl_nic/rtl8168h-2.fw
> firmware:       rtl_nic/rtl8168g-3.fw
> firmware:       rtl_nic/rtl8168g-2.fw
> firmware:       rtl_nic/rtl8106e-2.fw
> firmware:       rtl_nic/rtl8106e-1.fw
> firmware:       rtl_nic/rtl8411-2.fw
> firmware:       rtl_nic/rtl8411-1.fw
> firmware:       rtl_nic/rtl8402-1.fw
> firmware:       rtl_nic/rtl8168f-2.fw
> firmware:       rtl_nic/rtl8168f-1.fw
> firmware:       rtl_nic/rtl8105e-1.fw
> firmware:       rtl_nic/rtl8168e-3.fw
> firmware:       rtl_nic/rtl8168e-2.fw
> firmware:       rtl_nic/rtl8168e-1.fw
> firmware:       rtl_nic/rtl8168d-2.fw
> firmware:       rtl_nic/rtl8168d-1.fw
> license:        GPL
> softdep:        pre: realtek
> description:    RealTek RTL-8169 Gigabit Ethernet driver
> author:         Realtek and the Linux r8169 crew <netdev@vger.kernel.org>
> alias:          pci:v000010ECd00003000sv*sd*bc*sc*i*
> alias:          pci:v000010ECd00008126sv*sd*bc*sc*i*
> alias:          pci:v000010ECd00008125sv*sd*bc*sc*i*
> alias:          pci:v00000001d00008168sv*sd00002410bc*sc*i*
> alias:          pci:v00001737d00001032sv*sd00000024bc*sc*i*
> alias:          pci:v000016ECd00000116sv*sd*bc*sc*i*
> alias:          pci:v00001259d0000C107sv*sd*bc*sc*i*
> alias:          pci:v00001186d00004302sv*sd*bc*sc*i*
> alias:          pci:v00001186d00004300sv*sd*bc*sc*i*
> alias:          pci:v00001186d00004300sv00001186sd00004B10bc*sc*i*
> alias:          pci:v000010ECd00008169sv*sd*bc*sc*i*
> alias:          pci:v000010FFd00008168sv*sd*bc*sc*i*
> alias:          pci:v000010ECd00008168sv*sd*bc*sc*i*
> alias:          pci:v000010ECd00008167sv*sd*bc*sc*i*
> alias:          pci:v000010ECd00008162sv*sd*bc*sc*i*
> alias:          pci:v000010ECd00008161sv*sd*bc*sc*i*
> alias:          pci:v000010ECd00008136sv*sd*bc*sc*i*
> alias:          pci:v000010ECd00008129sv*sd*bc*sc*i*
> alias:          pci:v000010ECd00002600sv*sd*bc*sc*i*
> alias:          pci:v000010ECd00002502sv*sd*bc*sc*i*
> depends:        libphy,mdio_devres
> retpoline:      Y
> intree:         Y
> name:           r8169
> vermagic:       6.10+unreleased-amd64 SMP preempt mod_unload modversions
> 
> root@prxmox-kernel:~# lsmod |grep real
> realtek                45056  0
> libphy                225280  3 r8169,mdio_devres,realtek
> root@prxmox-kernel:~#
> 
> On Sun, Oct 13, 2024 at 10:44 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> On 12.10.2024 21:03, Luc Willems wrote:
>>> using new gigabyte X870E AORUS ELITE WIFI7 board, running proxmox pve kernel
>>>
>>> Linux linux-s05 6.8.12-2-pve #1 SMP PREEMPT_DYNAMIC PMX 6.8.12-2
>>> (2024-09-05T10:03Z) x86_64 GNU/Linux
>>>
>>> 11:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8125
>>> 2.5GbE Controller (rev 0c)
>>>         Subsystem: Gigabyte Technology Co., Ltd RTL8125 2.5GbE Controller
>>>         Flags: fast devsel, IRQ 43, IOMMU group 26
>>>         I/O ports at e000 [size=256]
>>>         Memory at dd900000 (64-bit, non-prefetchable) [size=64K]
>>>         Memory at dd910000 (64-bit, non-prefetchable) [size=16K]
>>>         Capabilities: [40] Power Management version 3
>>>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable+ 64bit+
>>>         Capabilities: [70] Express Endpoint, MSI 01
>>>         Capabilities: [b0] MSI-X: Enable- Count=64 Masked-
>>>         Capabilities: [d0] Vital Product Data
>>>         Capabilities: [100] Advanced Error Reporting
>>>         Capabilities: [148] Virtual Channel
>>>         Capabilities: [164] Device Serial Number 01-00-00-00-68-4c-e0-00
>>>         Capabilities: [174] Transaction Processing Hints
>>>         Capabilities: [200] Latency Tolerance Reporting
>>>         Capabilities: [208] L1 PM Substates
>>>         Capabilities: [218] Vendor Specific Information: ID=0002 Rev=4
>>> Len=100 <?>
>>>         Kernel modules: r8169
>>>
>>> root@linux-s05:/root# dmesg |grep r8169
>>> [    6.353276] r8169 0000:11:00.0: error -ENODEV: unknown chip XID
>>> 688, contact r8169 maintainers (see MAINTAINERS file)
>>>
>>
>> Below is a patch with experimental support for RTL8125D. Could you
>> please test it? Few notes:
>> - Depending on the PHY ID of the integrated PHY you may receive an
>>   error message that there's no dedicated PHY driver. Please forward the
>>   error message with the PHY ID in this case.
>> - As long as the firmware for this chip version isn't available, link
>>   might be unstable or worst case completely missing. Driver will complain
>>   about the missing firmware file, but this error message can be ignored for now.
>>
>> ---
>>  drivers/net/ethernet/realtek/r8169.h          |  1 +
>>  drivers/net/ethernet/realtek/r8169_main.c     | 23 +++++++++++++------
>>  .../net/ethernet/realtek/r8169_phy_config.c   |  7 ++++++
>>  3 files changed, 24 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
>> index e2db944e6..be4c96226 100644
>> --- a/drivers/net/ethernet/realtek/r8169.h
>> +++ b/drivers/net/ethernet/realtek/r8169.h
>> @@ -68,6 +68,7 @@ enum mac_version {
>>         /* support for RTL_GIGA_MAC_VER_60 has been removed */
>>         RTL_GIGA_MAC_VER_61,
>>         RTL_GIGA_MAC_VER_63,
>> +       RTL_GIGA_MAC_VER_64,
>>         RTL_GIGA_MAC_VER_65,
>>         RTL_GIGA_MAC_VER_66,
>>         RTL_GIGA_MAC_NONE
>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>> index 1a2322824..dcd176a77 100644
>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>> @@ -56,6 +56,7 @@
>>  #define FIRMWARE_8107E_2       "rtl_nic/rtl8107e-2.fw"
>>  #define FIRMWARE_8125A_3       "rtl_nic/rtl8125a-3.fw"
>>  #define FIRMWARE_8125B_2       "rtl_nic/rtl8125b-2.fw"
>> +#define FIRMWARE_8125D_1       "rtl_nic/rtl8125d-1.fw"
>>  #define FIRMWARE_8126A_2       "rtl_nic/rtl8126a-2.fw"
>>  #define FIRMWARE_8126A_3       "rtl_nic/rtl8126a-3.fw"
>>
>> @@ -139,6 +140,7 @@ static const struct {
>>         [RTL_GIGA_MAC_VER_61] = {"RTL8125A",            FIRMWARE_8125A_3},
>>         /* reserve 62 for CFG_METHOD_4 in the vendor driver */
>>         [RTL_GIGA_MAC_VER_63] = {"RTL8125B",            FIRMWARE_8125B_2},
>> +       [RTL_GIGA_MAC_VER_64] = {"RTL8125D",            FIRMWARE_8125D_1},
>>         [RTL_GIGA_MAC_VER_65] = {"RTL8126A",            FIRMWARE_8126A_2},
>>         [RTL_GIGA_MAC_VER_66] = {"RTL8126A",            FIRMWARE_8126A_3},
>>  };
>> @@ -708,6 +710,7 @@ MODULE_FIRMWARE(FIRMWARE_8168FP_3);
>>  MODULE_FIRMWARE(FIRMWARE_8107E_2);
>>  MODULE_FIRMWARE(FIRMWARE_8125A_3);
>>  MODULE_FIRMWARE(FIRMWARE_8125B_2);
>> +MODULE_FIRMWARE(FIRMWARE_8125D_1);
>>  MODULE_FIRMWARE(FIRMWARE_8126A_2);
>>  MODULE_FIRMWARE(FIRMWARE_8126A_3);
>>
>> @@ -2099,10 +2102,7 @@ static void rtl_set_eee_txidle_timer(struct rtl8169_private *tp)
>>                 tp->tx_lpi_timer = timer_val;
>>                 r8168_mac_ocp_write(tp, 0xe048, timer_val);
>>                 break;
>> -       case RTL_GIGA_MAC_VER_61:
>> -       case RTL_GIGA_MAC_VER_63:
>> -       case RTL_GIGA_MAC_VER_65:
>> -       case RTL_GIGA_MAC_VER_66:
>> +       case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_66:
>>                 tp->tx_lpi_timer = timer_val;
>>                 RTL_W16(tp, EEE_TXIDLE_TIMER_8125, timer_val);
>>                 break;
>> @@ -2234,6 +2234,9 @@ static enum mac_version rtl8169_get_mac_version(u16 xid, bool gmii)
>>                 { 0x7cf, 0x64a, RTL_GIGA_MAC_VER_66 },
>>                 { 0x7cf, 0x649, RTL_GIGA_MAC_VER_65 },
>>
>> +               /* 8125D family. */
>> +               { 0x7cf, 0x688, RTL_GIGA_MAC_VER_64 },
>> +
>>                 /* 8125B family. */
>>                 { 0x7cf, 0x641, RTL_GIGA_MAC_VER_63 },
>>
>> @@ -2501,9 +2504,7 @@ static void rtl_init_rxcfg(struct rtl8169_private *tp)
>>         case RTL_GIGA_MAC_VER_61:
>>                 RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST);
>>                 break;
>> -       case RTL_GIGA_MAC_VER_63:
>> -       case RTL_GIGA_MAC_VER_65:
>> -       case RTL_GIGA_MAC_VER_66:
>> +       case RTL_GIGA_MAC_VER_63 ... RTL_GIGA_MAC_VER_66:
>>                 RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST |
>>                         RX_PAUSE_SLOT_ON);
>>                 break;
>> @@ -3815,6 +3816,12 @@ static void rtl_hw_start_8125b(struct rtl8169_private *tp)
>>         rtl_hw_start_8125_common(tp);
>>  }
>>
>> +static void rtl_hw_start_8125d(struct rtl8169_private *tp)
>> +{
>> +       rtl_set_def_aspm_entry_latency(tp);
>> +       rtl_hw_start_8125_common(tp);
>> +}
>> +
>>  static void rtl_hw_start_8126a(struct rtl8169_private *tp)
>>  {
>>         rtl_set_def_aspm_entry_latency(tp);
>> @@ -3863,6 +3870,7 @@ static void rtl_hw_config(struct rtl8169_private *tp)
>>                 [RTL_GIGA_MAC_VER_53] = rtl_hw_start_8117,
>>                 [RTL_GIGA_MAC_VER_61] = rtl_hw_start_8125a_2,
>>                 [RTL_GIGA_MAC_VER_63] = rtl_hw_start_8125b,
>> +               [RTL_GIGA_MAC_VER_64] = rtl_hw_start_8125d,
>>                 [RTL_GIGA_MAC_VER_65] = rtl_hw_start_8126a,
>>                 [RTL_GIGA_MAC_VER_66] = rtl_hw_start_8126a,
>>         };
>> @@ -3880,6 +3888,7 @@ static void rtl_hw_start_8125(struct rtl8169_private *tp)
>>         /* disable interrupt coalescing */
>>         switch (tp->mac_version) {
>>         case RTL_GIGA_MAC_VER_61:
>> +       case RTL_GIGA_MAC_VER_64:
>>                 for (i = 0xa00; i < 0xb00; i += 4)
>>                         RTL_W32(tp, i, 0);
>>                 break;
>> diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
>> index cf29b1208..6b70f23c8 100644
>> --- a/drivers/net/ethernet/realtek/r8169_phy_config.c
>> +++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
>> @@ -1104,6 +1104,12 @@ static void rtl8125b_hw_phy_config(struct rtl8169_private *tp,
>>         rtl8125b_config_eee_phy(phydev);
>>  }
>>
>> +static void rtl8125d_hw_phy_config(struct rtl8169_private *tp,
>> +                                  struct phy_device *phydev)
>> +{
>> +       r8169_apply_firmware(tp);
>> +}
>> +
>>  static void rtl8126a_hw_phy_config(struct rtl8169_private *tp,
>>                                    struct phy_device *phydev)
>>  {
>> @@ -1160,6 +1166,7 @@ void r8169_hw_phy_config(struct rtl8169_private *tp, struct phy_device *phydev,
>>                 [RTL_GIGA_MAC_VER_53] = rtl8117_hw_phy_config,
>>                 [RTL_GIGA_MAC_VER_61] = rtl8125a_2_hw_phy_config,
>>                 [RTL_GIGA_MAC_VER_63] = rtl8125b_hw_phy_config,
>> +               [RTL_GIGA_MAC_VER_64] = rtl8125d_hw_phy_config,
>>                 [RTL_GIGA_MAC_VER_65] = rtl8126a_hw_phy_config,
>>                 [RTL_GIGA_MAC_VER_66] = rtl8126a_hw_phy_config,
>>         };
>> --
>> 2.47.0
>>
>>
> 
> 

Thanks for testing. For PHY ID 0x001cc841 there's no PHY driver yet.
Following isn't a proper patch but just a quick hack to see whether
it makes your NIC work. Could you please apply this change on top
and re-test?

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 166f6a728..1bb8139cb 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -1348,7 +1348,7 @@ static struct phy_driver realtek_drvs[] = {
 		.read_mmd	= rtl822x_read_mmd,
 		.write_mmd	= rtl822x_write_mmd,
 	}, {
-		PHY_ID_MATCH_EXACT(0x001cc840),
+		PHY_ID_MATCH_EXACT(0x001cc841),
 		.name		= "RTL8226B_RTL8221B 2.5Gbps PHY",
 		.get_features	= rtl822x_get_features,
 		.config_aneg	= rtl822x_config_aneg,




