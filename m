Return-Path: <netdev+bounces-67602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 505038443E1
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 17:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B869B1F2A5E0
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 16:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB9B12AAD0;
	Wed, 31 Jan 2024 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HL1UW2e5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A129F12A17A
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 16:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706717696; cv=none; b=vDLsW6VBIk6DHnKpALzK9y5GVx7aBPnScIYH8oIbAWk8nj074xBL11ZsrEr6RymcyniZtYPSb4Sc0SHbYTKFSRcJrpgf7PDsAWjsYB1kNa9tbAZZxqVsD8whAksakFrFuSd1Efw3/dkRCLZfE1hY8cwaD31DTWJ6NsoNFNzAuvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706717696; c=relaxed/simple;
	bh=q6A8bGt81Mi3l1hGNkCQ36F/8ScPVdmsXoJTUJDuMzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ds4Zw4PdabKI4y9WBrlbH0D51wfuJeNgV1N49TrBf6/zG6nV7SGi5PiKF/mkevRolsmeXeaQ0AO5l9+LQCPrk7AkhpfS5QMWOTigyoC5Mre8RSoEZ2hk3p+isxPRTT8gDEHn/AGg/TFonRiZmsK3yAlhbPHusUSV1MjvFVmWRRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HL1UW2e5; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-783d8e09a1cso358912485a.3
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 08:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706717693; x=1707322493; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q91kRQzkVbtHpZ7XuKVIAIcbBe+e1ko2oFyQoglSFz8=;
        b=HL1UW2e5Hg+7bQqPVgxAogoY3riUo2mFqPbO7/cPx55tys1AQN6cNahOajKSf/8P17
         Nb6bVD+25KrgnpfseFp6pv49x6bMRC3YZTStMT85LdNIwLukgIHcBS0Wz38fXQHreQHW
         iqfI8bYy4wbYM0dIykjLpW7gyK4A7HFMtWAhXtNsYHGwWmAZolATV6IIEvDO3k/y5WH6
         q4og6SlZzh3AWXMtZPtxw4RHMY7fNh2XkkmDJG8hUjxD+qckAIG6ff4lGc3ZDUdaRQuQ
         ZFuvPIDsmN8bbgJOIrPN3G0rOatY7zxFdatXeq6iPBYFdlDZHm7bXOWSo3tn5MJqKLLH
         DezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706717693; x=1707322493;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q91kRQzkVbtHpZ7XuKVIAIcbBe+e1ko2oFyQoglSFz8=;
        b=pEmSbCkLGDKpTUeAJtHjQgFcHn7rbQZcBniZ31lLB6YC0Hf8OnRbxjNP03eeFxR0cQ
         AAEAEBEqa2RBfodR4hem06J8rlyRrOjdSN63pya14tObr5dsDBWGSAmNYf3F07pqepOz
         VyvRawz2sL2Vtn+COG9hwDcO/wDRxD4fkjaoqy7pHnXIfamgFWH5Q2NI9XiapVIB4JlD
         NMY3rqI13vaRQkN6BdNIIuDzqlfp9OXsi3311GuTcApHcqpuAtGmL5sKf5wZHuRiY9Z8
         xlvKeS7wmeNI5wLub4DHujs98TsEJiUVbTLmq5v1ScdmGVCERfuqKsrVFdLCoJNUHtI6
         eKWw==
X-Gm-Message-State: AOJu0Yzm0oR/r5ltXknNLzGqQKGJ8bniaqrFIHIHxtdkEy85VHDKayJv
	jlUirbZel0I6Mbf2ZaYaodFEnNdaHv5owNIvL98EsXDhsh6cLQJX
X-Google-Smtp-Source: AGHT+IHQfW9yaxs1uSsL3yi9v3HdMSyTayU1m6cZAN7pLJSHvqZKg56dd6O+wnJ/KfellkDMcS93Lw==
X-Received: by 2002:a05:6214:1314:b0:686:acb4:e71 with SMTP id pn20-20020a056214131400b00686acb40e71mr2536795qvb.31.1706717693148;
        Wed, 31 Jan 2024 08:14:53 -0800 (PST)
Received: from [192.168.1.1] (pool-100-16-13-166.bltmmd.fios.verizon.net. [100.16.13.166])
        by smtp.gmail.com with ESMTPSA id qm12-20020a056214568c00b006869dc6c9b7sm5594399qvb.44.2024.01.31.08.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 08:14:52 -0800 (PST)
Message-ID: <55163a6d-b40a-472d-bacb-bb252bc85007@gmail.com>
Date: Wed, 31 Jan 2024 11:14:52 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel Module r8169 and the Realtek 8126 PCIe 5 G/bps WIRED
 ethernet adapter
To: Heiner Kallweit <hkallweit1@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, tiwai@suse.com
References: <edabbc1f-5440-4170-83a4-f436a6d04f76@gmail.com>
 <64b65025-792c-43c9-8ae5-22030264e374@gmail.com>
 <208a69de-af5b-4624-85d5-86e87dfe6272@gmail.com>
Content-Language: en-US
From: Joe Salmeri <jmscdba@gmail.com>
In-Reply-To: <208a69de-af5b-4624-85d5-86e87dfe6272@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/30/24 14:59, Heiner Kallweit wrote:
> On 30.01.2024 17:34, Joe Salmeri wrote:
>> On 1/29/24 17:19, Heiner Kallweit wrote:
>>> On 29.01.2024 19:31, Joe Salmeri wrote:
>>>> Hi,
>>>>
>>>> I recently built a new PC using the Asus z790 Maximus Formula motherboard.
>>>>
>>>> The z790 Formula uses the Realtek 8126 PCIe 5 G/bps WIRED ethernet adapter.
>>>>
>>>> I am using openSUSE Tumbleweed build 20231228 with kernel 6.6.7-1
>>>>
>>>> There does not seem to be a driver for the Realtek 8126.
>>>>
>>>> Here is the device info from "lspci | grep -i net"
>>>>
>>>>       04:00.0 Network controller: Intel Corporation Device 272b (rev 1a)
>>>>       05:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. Device 8126 (rev 01)
>>>>
>>>> So it is detects the 8126 just fine it just doesn't have a driver for it.
>>>>
>>>> I checked realtek.com and found
>>>>
>>>> https://www.realtek.com/en/component/zoo/category/network-interface-controllers-10-100-1000m-gigabit-ethernet-pci-express-software
>>>>
>>>> The download link still says 8125 ( and kernel 6.4 ), but I compiled the source and since I have Secure boot enabled, I signed the
>>>> resulting module file.
>>>>
>>>> The driver loads successfully and I now have wired networking and it has worked flawlessly for the last 2 months.
>>>>
>>>> I submitted a bug in Tumbleweed requesting support for the Realtek 8126 be added and was informed that the r8169 kernel module
>>>> is what is used to support the older Realtek 8125 device.
>>>>
>>>> Since the drivers from Realtek seem to support both the r8125 and my newer r8126, the Tumbleweed support prepared a test
>>>> kernel 6.6.7-1 for me where they added the PCI entry for the r8126 and I installed and tested it out.
>>>>
>>>> Although it does now load the r8169 module with their test kernel, the r8126 device still does not work.
>>>>
>>>> The only 2 lines that reference the r8169 in the dmesg log are these 2 lines:
>>>>
>>>> [    3.237151] r8169 0000:05:00.0: enabling device (0000 -> 0003)
>>>> [    3.237289] r8169 0000:05:00.0: error -ENODEV: unknown chip XID 649, contact r8169 maintainers (see MAINTAINERS file)
>>>>
>>>> I reported the results of the test to Tumbleweed support and they said that additional tweaks will be needed for the r8169
>>>> module to support the r8126 wired network adapter and thatn I should request to you to add support.
>>>>
>>>> The details of the openSUSE bug report on the issue can be found here:
>>>>
>>>>       https://bugzilla.suse.com/show_bug.cgi?id=1217417
>>>>
>>>> Could we please get support added for the r8126 - Realtek 8126 PCIe 5 G/bps WIRED ethernet adapter added to the kernel ?
>>>>
>>> Thanks for the report. Actually it's not a bug report but a feature request.
>>> Realtek provides no information about new chip versions and no data sheets, therefore the only
>>> source of information is the r8125 vendor driver. Each chip requires a lot of version-specific
>>> handling, therefore the first steps you described go in the right direction, but are by far not
>>> sufficient. Patch below applies on linux-next, please test whether it works for you, and report back.
>>>
>>> Disclaimer:
>>> r8125 references a firmware file that hasn't been provided to linux-firmware by Realtek yet.
>>> Typically the firmware files tune PHY parameters to deal with compatibility issues.
>>> In addition r8125 includes a lot of PHY tuning for RTL8126A.
>>> Depending on cabling, link partner etc. the patch may work for you, or you may experience
>>> link instability or worst case no link at all.
>>>
>>> Maybe RTL8126a also has a new integrated PHY version that isn't supported yet.
>>> In this case the driver will complain with the following message and I'd need the PHY ID.
>>> "no dedicated PHY driver found for PHY ID xxx"
>> Thanks very much for your quick response.
>>
>> I forward your patch to the openSUSE people I have been working and they prepared a new test kernel 6.7.2 with the patches for for me to test.
>>
>> I just installed the test kernel provided with the patches but just as you expected it complains about no dedicated PHY driver found.
>>
>> Here is the dmesg | grep 8169 output with the information you requested
>>
>> [    3.176753] r8169 0000:05:00.0: enabling device (0000 -> 0003)
>> [    3.184887] r8169 0000:05:00.0: no dedicated PHY driver found for PHY ID 0x001cc862, maybe realtek.ko needs to be added to initramfs?
>> [    3.184912] r8169: probe of 0000:05:00.0 failed with error -49
>>
>> Thank you for your efforts.
>>
>> Please let me know if you need any further details.
>>
>>> ---
>>>    drivers/net/ethernet/realtek/r8169.h          |  1 +
>>>    drivers/net/ethernet/realtek/r8169_main.c     | 91 +++++++++++++++----
>>>    .../net/ethernet/realtek/r8169_phy_config.c   |  1 +
>>>    3 files changed, 77 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/realtek/r8169.h b/drivers/net/ethernet/realtek/r8169.h
>>> index 81567fcf3..c921456ed 100644
>>> --- a/drivers/net/ethernet/realtek/r8169.h
>>> +++ b/drivers/net/ethernet/realtek/r8169.h
>>> @@ -68,6 +68,7 @@ enum mac_version {
>>>        /* support for RTL_GIGA_MAC_VER_60 has been removed */
>>>        RTL_GIGA_MAC_VER_61,
>>>        RTL_GIGA_MAC_VER_63,
>>> +    RTL_GIGA_MAC_VER_65,
>>>        RTL_GIGA_MAC_NONE
>>>    };
>>>    diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>>> index e0abdbcfa..ebf7a3b13 100644
>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>>> @@ -55,6 +55,7 @@
>>>    #define FIRMWARE_8107E_2    "rtl_nic/rtl8107e-2.fw"
>>>    #define FIRMWARE_8125A_3    "rtl_nic/rtl8125a-3.fw"
>>>    #define FIRMWARE_8125B_2    "rtl_nic/rtl8125b-2.fw"
>>> +#define FIRMWARE_8126A_2    "rtl_nic/rtl8126a-2.fw"
>>>      #define TX_DMA_BURST    7    /* Maximum PCI burst, '7' is unlimited */
>>>    #define InterFrameGap    0x03    /* 3 means InterFrameGap = the shortest one */
>>> @@ -136,6 +137,7 @@ static const struct {
>>>        [RTL_GIGA_MAC_VER_61] = {"RTL8125A",        FIRMWARE_8125A_3},
>>>        /* reserve 62 for CFG_METHOD_4 in the vendor driver */
>>>        [RTL_GIGA_MAC_VER_63] = {"RTL8125B",        FIRMWARE_8125B_2},
>>> +    [RTL_GIGA_MAC_VER_65] = {"RTL8126A",        FIRMWARE_8126A_2},
>>>    };
>>>      static const struct pci_device_id rtl8169_pci_tbl[] = {
>>> @@ -158,6 +160,7 @@ static const struct pci_device_id rtl8169_pci_tbl[] = {
>>>        { PCI_VENDOR_ID_LINKSYS, 0x1032, PCI_ANY_ID, 0x0024 },
>>>        { 0x0001, 0x8168, PCI_ANY_ID, 0x2410 },
>>>        { PCI_VDEVICE(REALTEK,    0x8125) },
>>> +    { PCI_VDEVICE(REALTEK,    0x8126) },
>>>        { PCI_VDEVICE(REALTEK,    0x3000) },
>>>        {}
>>>    };
>>> @@ -327,8 +330,12 @@ enum rtl8168_registers {
>>>    };
>>>      enum rtl8125_registers {
>>> +    INT_CFG0_8125        = 0x34,
>>> +#define INT_CFG0_ENABLE_8125        BIT(0)
>>> +#define INT_CFG0_CLKREQEN        BIT(3)
>>>        IntrMask_8125        = 0x38,
>>>        IntrStatus_8125        = 0x3c,
>>> +    INT_CFG1_8125        = 0x7a,
>>>        TxPoll_8125        = 0x90,
>>>        MAC0_BKP        = 0x19e0,
>>>        EEE_TXIDLE_TIMER_8125    = 0x6048,
>>> @@ -1139,7 +1146,7 @@ static void rtl_writephy(struct rtl8169_private *tp, int location, int val)
>>>        case RTL_GIGA_MAC_VER_31:
>>>            r8168dp_2_mdio_write(tp, location, val);
>>>            break;
>>> -    case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_63:
>>> +    case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_65:
>>>            r8168g_mdio_write(tp, location, val);
>>>            break;
>>>        default:
>>> @@ -1154,7 +1161,7 @@ static int rtl_readphy(struct rtl8169_private *tp, int location)
>>>        case RTL_GIGA_MAC_VER_28:
>>>        case RTL_GIGA_MAC_VER_31:
>>>            return r8168dp_2_mdio_read(tp, location);
>>> -    case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_63:
>>> +    case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_65:
>>>            return r8168g_mdio_read(tp, location);
>>>        default:
>>>            return r8169_mdio_read(tp, location);
>>> @@ -1507,7 +1514,7 @@ static void __rtl8169_set_wol(struct rtl8169_private *tp, u32 wolopts)
>>>            break;
>>>        case RTL_GIGA_MAC_VER_34:
>>>        case RTL_GIGA_MAC_VER_37:
>>> -    case RTL_GIGA_MAC_VER_39 ... RTL_GIGA_MAC_VER_63:
>>> +    case RTL_GIGA_MAC_VER_39 ... RTL_GIGA_MAC_VER_65:
>>>            if (wolopts)
>>>                rtl_mod_config2(tp, 0, PME_SIGNAL);
>>>            else
>>> @@ -2073,6 +2080,9 @@ static enum mac_version rtl8169_get_mac_version(u16 xid, bool gmii)
>>>            u16 val;
>>>            enum mac_version ver;
>>>        } mac_info[] = {
>>> +        /* 8126A family. */
>>> +        { 0x7cf, 0x649,    RTL_GIGA_MAC_VER_65 },
>>> +
>>>            /* 8125B family. */
>>>            { 0x7cf, 0x641,    RTL_GIGA_MAC_VER_63 },
>>>    @@ -2343,6 +2353,7 @@ static void rtl_init_rxcfg(struct rtl8169_private *tp)
>>>            RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST);
>>>            break;
>>>        case RTL_GIGA_MAC_VER_63:
>>> +    case RTL_GIGA_MAC_VER_65:
>>>            RTL_W32(tp, RxConfig, RX_FETCH_DFLT_8125 | RX_DMA_BURST |
>>>                RX_PAUSE_SLOT_ON);
>>>            break;
>>> @@ -2772,7 +2783,7 @@ static void rtl_enable_exit_l1(struct rtl8169_private *tp)
>>>        case RTL_GIGA_MAC_VER_37 ... RTL_GIGA_MAC_VER_38:
>>>            rtl_eri_set_bits(tp, 0xd4, 0x0c00);
>>>            break;
>>> -    case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_63:
>>> +    case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_65:
>>>            r8168_mac_ocp_modify(tp, 0xc0ac, 0, 0x1f80);
>>>            break;
>>>        default:
>>> @@ -2786,7 +2797,7 @@ static void rtl_disable_exit_l1(struct rtl8169_private *tp)
>>>        case RTL_GIGA_MAC_VER_34 ... RTL_GIGA_MAC_VER_38:
>>>            rtl_eri_clear_bits(tp, 0xd4, 0x1f00);
>>>            break;
>>> -    case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_63:
>>> +    case RTL_GIGA_MAC_VER_40 ... RTL_GIGA_MAC_VER_65:
>>>            r8168_mac_ocp_modify(tp, 0xc0ac, 0x1f80, 0);
>>>            break;
>>>        default:
>>> @@ -2796,6 +2807,8 @@ static void rtl_disable_exit_l1(struct rtl8169_private *tp)
>>>      static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
>>>    {
>>> +    u8 val8;
>>> +
>>>        if (tp->mac_version < RTL_GIGA_MAC_VER_32)
>>>            return;
>>>    @@ -2809,11 +2822,19 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
>>>                return;
>>>              rtl_mod_config5(tp, 0, ASPM_en);
>>> -        rtl_mod_config2(tp, 0, ClkReqEn);
>>> +        switch (tp->mac_version) {
>>> +        case RTL_GIGA_MAC_VER_65:
>>> +            val8 = RTL_R8(tp, INT_CFG0_8125) | INT_CFG0_CLKREQEN;
>>> +            RTL_W8(tp, INT_CFG0_8125, val8);
>>> +            break;
>>> +        default:
>>> +            rtl_mod_config2(tp, 0, ClkReqEn);
>>> +            break;
>>> +        }
>>>              switch (tp->mac_version) {
>>>            case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
>>> -        case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_63:
>>> +        case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_65:
>>>                /* reset ephy tx/rx disable timer */
>>>                r8168_mac_ocp_modify(tp, 0xe094, 0xff00, 0);
>>>                /* chip can trigger L1.2 */
>>> @@ -2825,14 +2846,22 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
>>>        } else {
>>>            switch (tp->mac_version) {
>>>            case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
>>> -        case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_63:
>>> +        case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_65:
>>>                r8168_mac_ocp_modify(tp, 0xe092, 0x00ff, 0);
>>>                break;
>>>            default:
>>>                break;
>>>            }
>>>    -        rtl_mod_config2(tp, ClkReqEn, 0);
>>> +        switch (tp->mac_version) {
>>> +        case RTL_GIGA_MAC_VER_65:
>>> +            val8 = RTL_R8(tp, INT_CFG0_8125) & ~INT_CFG0_CLKREQEN;
>>> +            RTL_W8(tp, INT_CFG0_8125, val8);
>>> +            break;
>>> +        default:
>>> +            rtl_mod_config2(tp, ClkReqEn, 0);
>>> +            break;
>>> +        }
>>>            rtl_mod_config5(tp, ASPM_en, 0);
>>>        }
>>>    }
>>> @@ -3545,10 +3574,15 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
>>>        /* disable new tx descriptor format */
>>>        r8168_mac_ocp_modify(tp, 0xeb58, 0x0001, 0x0000);
>>>    -    if (tp->mac_version == RTL_GIGA_MAC_VER_63)
>>> +    if (tp->mac_version == RTL_GIGA_MAC_VER_65)
>>> +        RTL_W8(tp, 0xD8, RTL_R8(tp, 0xD8) & ~0x02);
>>> +
>>> +    if (tp->mac_version == RTL_GIGA_MAC_VER_65)
>>> +        r8168_mac_ocp_modify(tp, 0xe614, 0x0700, 0x0400);
>>> +    else if (tp->mac_version == RTL_GIGA_MAC_VER_63)
>>>            r8168_mac_ocp_modify(tp, 0xe614, 0x0700, 0x0200);
>>>        else
>>> -        r8168_mac_ocp_modify(tp, 0xe614, 0x0700, 0x0400);
>>> +        r8168_mac_ocp_modify(tp, 0xe614, 0x0700, 0x0300);
>>>          if (tp->mac_version == RTL_GIGA_MAC_VER_63)
>>>            r8168_mac_ocp_modify(tp, 0xe63e, 0x0c30, 0x0000);
>>> @@ -3561,6 +3595,10 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
>>>        r8168_mac_ocp_modify(tp, 0xe056, 0x00f0, 0x0030);
>>>        r8168_mac_ocp_modify(tp, 0xe040, 0x1000, 0x0000);
>>>        r8168_mac_ocp_modify(tp, 0xea1c, 0x0003, 0x0001);
>>> +    if (tp->mac_version == RTL_GIGA_MAC_VER_65)
>>> +        r8168_mac_ocp_modify(tp, 0xea1c, 0x0300, 0x0000);
>>> +    else
>>> +        r8168_mac_ocp_modify(tp, 0xea1c, 0x0004, 0x0000);
>>>        r8168_mac_ocp_modify(tp, 0xe0c0, 0x4f0f, 0x4403);
>>>        r8168_mac_ocp_modify(tp, 0xe052, 0x0080, 0x0068);
>>>        r8168_mac_ocp_modify(tp, 0xd430, 0x0fff, 0x047f);
>>> @@ -3575,10 +3613,10 @@ static void rtl_hw_start_8125_common(struct rtl8169_private *tp)
>>>          rtl_loop_wait_low(tp, &rtl_mac_ocp_e00e_cond, 1000, 10);
>>>    -    if (tp->mac_version == RTL_GIGA_MAC_VER_63)
>>> -        rtl8125b_config_eee_mac(tp);
>>> -    else
>>> +    if (tp->mac_version == RTL_GIGA_MAC_VER_61)
>>>            rtl8125a_config_eee_mac(tp);
>>> +    else
>>> +        rtl8125b_config_eee_mac(tp);
>>>          rtl_disable_rxdvgate(tp);
>>>    }
>>> @@ -3622,6 +3660,12 @@ static void rtl_hw_start_8125b(struct rtl8169_private *tp)
>>>        rtl_hw_start_8125_common(tp);
>>>    }
>>>    +static void rtl_hw_start_8126a(struct rtl8169_private *tp)
>>> +{
>>> +    rtl_set_def_aspm_entry_latency(tp);
>>> +    rtl_hw_start_8125_common(tp);
>>> +}
>>> +
>>>    static void rtl_hw_config(struct rtl8169_private *tp)
>>>    {
>>>        static const rtl_generic_fct hw_configs[] = {
>>> @@ -3664,6 +3708,7 @@ static void rtl_hw_config(struct rtl8169_private *tp)
>>>            [RTL_GIGA_MAC_VER_53] = rtl_hw_start_8117,
>>>            [RTL_GIGA_MAC_VER_61] = rtl_hw_start_8125a_2,
>>>            [RTL_GIGA_MAC_VER_63] = rtl_hw_start_8125b,
>>> +        [RTL_GIGA_MAC_VER_65] = rtl_hw_start_8126a,
>>>        };
>>>          if (hw_configs[tp->mac_version])
>>> @@ -3674,9 +3719,23 @@ static void rtl_hw_start_8125(struct rtl8169_private *tp)
>>>    {
>>>        int i;
>>>    +    RTL_W8(tp, INT_CFG0_8125, 0x00);
>>> +
>>>        /* disable interrupt coalescing */
>>> -    for (i = 0xa00; i < 0xb00; i += 4)
>>> -        RTL_W32(tp, i, 0);
>>> +    switch (tp->mac_version) {
>>> +    case RTL_GIGA_MAC_VER_61:
>>> +        for (i = 0xa00; i < 0xb00; i += 4)
>>> +            RTL_W32(tp, i, 0);
>>> +        break;
>>> +    case RTL_GIGA_MAC_VER_63:
>>> +    case RTL_GIGA_MAC_VER_65:
>>> +        for (i = 0xa00; i < 0xa80; i += 4)
>>> +            RTL_W32(tp, i, 0);
>>> +        RTL_W16(tp, INT_CFG1_8125, 0x0000);
>>> +        break;
>>> +    default:
>>> +        break;
>>> +    }
>>>          rtl_hw_config(tp);
>>>    }
>>> diff --git a/drivers/net/ethernet/realtek/r8169_phy_config.c b/drivers/net/ethernet/realtek/r8169_phy_config.c
>>> index b50f16786..badf78f81 100644
>>> --- a/drivers/net/ethernet/realtek/r8169_phy_config.c
>>> +++ b/drivers/net/ethernet/realtek/r8169_phy_config.c
>>> @@ -1152,6 +1152,7 @@ void r8169_hw_phy_config(struct rtl8169_private *tp, struct phy_device *phydev,
>>>            [RTL_GIGA_MAC_VER_53] = rtl8117_hw_phy_config,
>>>            [RTL_GIGA_MAC_VER_61] = rtl8125a_2_hw_phy_config,
>>>            [RTL_GIGA_MAC_VER_63] = rtl8125b_hw_phy_config,
>>> +        [RTL_GIGA_MAC_VER_65] = NULL,
>>>        };
>>>          if (phy_configs[ver])
>>
> The followoing adds support for the integrated PHY.
> Please apply it on-top and re-test.
>
> ---
>   drivers/net/phy/realtek.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> index 894172a3e..132784321 100644
> --- a/drivers/net/phy/realtek.c
> +++ b/drivers/net/phy/realtek.c
> @@ -1047,6 +1047,16 @@ static struct phy_driver realtek_drvs[] = {
>   		.resume         = rtlgen_resume,
>   		.read_page      = rtl821x_read_page,
>   		.write_page     = rtl821x_write_page,
> +	}, {
> +		PHY_ID_MATCH_EXACT(0x001cc862),
> +		.name           = "RTL8251B 5Gbps PHY",
> +		.get_features   = rtl822x_get_features,
> +		.config_aneg    = rtl822x_config_aneg,
> +		.read_status    = rtl822x_read_status,
> +		.suspend        = genphy_suspend,
> +		.resume         = rtlgen_resume,
> +		.read_page      = rtl821x_read_page,
> +		.write_page     = rtl821x_write_page,
>   	}, {
>   		PHY_ID_MATCH_EXACT(0x001cc961),
>   		.name		= "RTL8366RB Gigabit Ethernet",

Thank you !

I forward your 2nd patch to the openSUSE people I have been working and they prepared a new test kernel 6.7.2 with both patches for for me to test.

I just installed the test kernel provided with both patches.

Here is the dmesg | grep 8169 output using this new test kernel

[    3.630222] r8169 0000:05:00.0: enabling device (0000 -> 0003)
[    3.632148] r8169 0000:05:00.0 eth0: RTL8126A, e8:9c:25:78:c9:bf, XID 649, IRQ 207
[    3.632150] r8169 0000:05:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
[    3.633218] r8169 0000:05:00.0 enp5s0: renamed from eth0
[    4.212381] r8169 0000:05:00.0: Direct firmware load for rtl_nic/rtl8126a-2.fw failed with error -2
[    4.212384] r8169 0000:05:00.0: Unable to load firmware rtl_nic/rtl8126a-2.fw (-2)
[    4.236119] RTL8251B 5Gbps PHY r8169-0-500:00: attached PHY driver (mii_bus:phy_addr=r8169-0-500:00, irq=MAC)
[    4.349625] r8169 0000:05:00.0 enp5s0: Link is Down
[    7.858055] r8169 0000:05:00.0 enp5s0: Link is Up - 1Gbps/Full - flow control rx/tx

Although dmesg has these 2 error messages, I have network connectivity, ran a quick speed test and am getting the correct speeds.

[    4.212381] r8169 0000:05:00.0: Direct firmware load for rtl_nic/rtl8126a-2.fw failed with error -2
[    4.212384] r8169 0000:05:00.0: Unable to load firmware rtl_nic/rtl8126a-2.fw (-2)

Here is the 'lsmod | grep 8169' results so you can see what is loaded

r8169                 114688  0 mdio_devres            12288  1 r8169 
libphy                245760  3 r8169,mdio_devres,realtek I will continue to test and report back if there are any network issues.

-- 
Regards,

Joe


