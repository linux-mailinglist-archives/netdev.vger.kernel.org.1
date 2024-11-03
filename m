Return-Path: <netdev+bounces-141359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2249F9BA886
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 23:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBB2B280F08
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 22:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B3418C000;
	Sun,  3 Nov 2024 22:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9RgejXs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9541318A6AB
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 22:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730672518; cv=none; b=p6KH9UkCU9aTBf8tvoSEuRbXfP+gRSJ42iGs25eUyzHRECZYn40LJSoFBT3ouZe9cQmDdqHuZe8ipstxSPs0Ov3ukgJIH5W/pO3TQQwuF3t+r4JAZ+3Wc94w1LMtP6zESNtbrfEbO9UsMkb10UwljiWLU3YJGyyy/MQJe033V9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730672518; c=relaxed/simple;
	bh=KPRMefRjXAw7A6tOB9DY/Hw3ADb8p1C7DH/sZ6LtkeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sZhNK1QZxfqywRcs2mY20kM3P2NAt4+PDsf7A8y2Q+cffZVdMOm58fGh1IUg5qxAkDhRTLYm4jympjdsKUBgRlq+JErDiktoTwGhGA7IEm16O1yJBU+4pLyPCIVZbJihGeJnYQ+cgNELxrgy+zhl7V6Me1cVw9gjJFHaSUtbJ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9RgejXs; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a3dc089d8so611788566b.3
        for <netdev@vger.kernel.org>; Sun, 03 Nov 2024 14:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730672515; x=1731277315; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y7n3MvIYaJIUssyj0dkzB4JWINsxdXgwJcnfeHCiRBo=;
        b=f9RgejXslTWvP8n3W3ocRcyAweVYdeYp3dGoJGVjgenkI5rQEi6Uq94TfjxoakM4Vw
         JPjxcfz5grVS/d6FnWc9XNcb/Q7ptlX+8lt/P9SS59b/9XNmmB/AuTxz14QxZZexlbFS
         NiWz+lfJ1y9RSHsUSwgvl8gYIWbFVlRvB/XibyYY7LerJ9rA927I01aDJoD4/f7KN70j
         +2Rf/UXwTqnk47uP2TyASwCC6qEtcdl6S1FpqcF36jiQaCnaEiibldk/4gH7E9+lNBcW
         bS6uAfcf+xwyud+mMrMxitY8bcS48LSPO8DLGSVrXPc5jPWSQnptk6U6Sw9IOe45KAff
         +N/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730672515; x=1731277315;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7n3MvIYaJIUssyj0dkzB4JWINsxdXgwJcnfeHCiRBo=;
        b=lw+ODkinf55OzVXi8iVFljtBiJmFl+2Znqv2cN1SMn/3PXHjmm4FDrt8UK3GH+s4Zo
         2dX9uh308TXYhjM///8KNTMSv5mOXA/10RhOp4zFf0Zhl1adp6nB+zaOKPMmVuMxm2NX
         FH3QK3VQUB34bN/hWyDwLw9pPp7co7R1qTTu3zuVqUdghzO8c8TXRbLSVjBDlAl7b68e
         Qq0l25T8GwLJ3PCq9ZvesjmCIAH5SmrinCaCRTh4CZ/34YYXPJE/7BPF+2Db95AwJ886
         Ffe8AL4DSVGW3TCUN4SVzz61Rguyxb9WK4dUvAb5m9IU3XSBEe9K695AFxGkm51f+rGK
         ToPw==
X-Gm-Message-State: AOJu0YzottkzYjF7Vk9O/qQMH6iIvWANIR78GrT84oy3+ryRz/7/VSey
	3NN2auhCIa7tWPfmgsg96kP42rEfb1znS6KXB/eclT6wWmsDlLRgGuyU6g==
X-Google-Smtp-Source: AGHT+IGuZ/kQlgP3CuHRbbTypBtsPjjShIL38WPF2Mk9SJ+wlFDWZInS80SmrWrZMEhSj767d7+0EA==
X-Received: by 2002:a17:906:c146:b0:a99:d6cf:a1df with SMTP id a640c23a62f3a-a9e655b958amr1136074966b.46.1730672514504;
        Sun, 03 Nov 2024 14:21:54 -0800 (PST)
Received: from ?IPV6:2a02:3100:9dce:cb00:a145:200d:572b:2f6d? (dynamic-2a02-3100-9dce-cb00-a145-200d-572b-2f6d.310.pool.telefonica.de. [2a02:3100:9dce:cb00:a145:200d:572b:2f6d])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9e56649363sm466587466b.184.2024.11.03.14.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Nov 2024 14:21:54 -0800 (PST)
Message-ID: <c224bee7-7056-4c2a-a234-b8cb79900d40@gmail.com>
Date: Sun, 3 Nov 2024 23:21:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: r8169: regression in connection speed with kernels 6.2+
 (interrupt coalescing)
To: Felix Braun <f.braun@falix.de>, nic_swsd@realtek.com
Cc: netdev@vger.kernel.org
References: <ff6d9c69c2a09de5baf2f01f25e3faf487278dbb.camel@falix.de>
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
In-Reply-To: <ff6d9c69c2a09de5baf2f01f25e3faf487278dbb.camel@falix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03.11.2024 17:08, Felix Braun wrote:
> Hi there,
> 
> commit 42f66a44d83715bef810a543dfd66008b883a7a5 to Linus' kernel tree ("r8169: enable GRO software interrupt coalescing per default") introduces a speed regression on my hardware. With that commit applied I get net throughput of 10.5 MB/s, without that commit I get around 100 MB/s on my setup.
> 
Thanks for the report. 6.2 has been out for quite some time, and this is
the first such report. So I don't think there's a general problem.
Can you please provide a full dmesg log and elaborate on the type of traffic
and how you measure the speed? BTW: With 100MB/s you refer to 100MBit/s?

Also interesting would be whether there are any errors or missed packets
in the ethtool -S <if> output.

Instead of commenting out this line you can also adjust the values from userspace:
/sys/class/net/<if>/gro_flush_timeout
/sys/class/net/<if>/napi_defer_hard_irqs
Does increasing the gro_flush_timeout value change something for you?

Somewhat strange is that lspci shows ASPM as disabled in LnkCtl, but
L1 sub-states are enabled in L1SubCtl1. Do you have any downstream kernel code
changes or any specific ASPM settings?

> I've verified that just commenting out the one line in r8169_main.c
> 
> ```
> --- a/drivers/net/ethernet/realtek/r8169_main.c  
> +++ b/drivers/net/ethernet/realtek/r8169_main.c  
> @@ -5505,6 +5505,8 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)  
> dev->hw_features |= NETIF_F_RXALL;  
> dev->hw_features |= NETIF_F_RXFCS;
> 
> dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
> 
> - netdev_sw_irq_coalesce_default_on(dev);  
> + //netdev_sq_irq_coalesc_default_on(dev);
> 
> /* configure chip for default features */  
> rtl8169_set_features(dev, dev->features);
> ```
> 
> restores the speed with kernel 6.11.6. Is there perhaps a more elegant way to fix this regression for other people too?
> 
> Regards  
> Felix
> 
> This is my lspci -vvxx output:
> 
> ```
> 03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8211/8411 PCI Express Gigabit Ethernet Controller (rev 15)
> DeviceName: Onboard - RTK Ethernet
> Subsystem: ASRock Incorporation Motherboard (one of many)
> Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> Latency: 0, Cache Line Size: 64 bytes
> Interrupt: pin A routed to IRQ 20
> IOMMU group: 11
> Region 0: I/O ports at e000 [size=256]
> Region 2: Memory at a1204000 (64-bit, non-prefetchable) [size=4K]
> Region 4: Memory at a1200000 (64-bit, non-prefetchable) [size=16K]
> Capabilities: [40] Power Management version 3
> Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
> Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
> Address: 0000000000000000  Data: 0000
> Capabilities: [70] Express (v2) Endpoint, IntMsgNum 1
> DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
> ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 10W TEE-IO-
> DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
> MaxPayload 128 bytes, MaxReadReq 4096 bytes
> DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
> LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s unlimited, L1 <64us
> ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
> LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> LnkSta: Speed 2.5GT/s, Width x1
> TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
> 10BitTagComp- 10BitTagReq- OBFF Via message/WAKE#, ExtFmt- EETLPPrefix-
> EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
> FRS- TPHComp- ExtTPHComp-
> AtomicOpsCap: 32bit- 64bit- 128bitCAS-
> DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
> AtomicOpsCtl: ReqEn-
> IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
> 10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
> LnkCap2: Supported Link Speeds: 2.5GT/s, Crosslink- Retimer- 2Retimers- DRS-
> LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
> Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
> LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
> EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
> Retimer- 2Retimers- CrosslinkRes: unsupported
> Capabilities: [b0] MSI-X: Enable+ Count=4 Masked-
> Vector table: BAR=4 offset=00000000
> PBA: BAR=4 offset=00000800
> Capabilities: [100 v2] Advanced Error Reporting
> UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
> ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
> PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
> UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
> ECRC- UnsupReq+ ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
> PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
> UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
> ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
> PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
> CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr- CorrIntErr- HeaderOF-
> CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+ CorrIntErr+ HeaderOF-
> AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
> MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
> HeaderLog: 00000000 00000000 00000000 00000000
> Capabilities: [140 v1] Virtual Channel
> Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
> Arb:    Fixed- WRR32- WRR64- WRR128-
> Ctrl:   ArbSelect=Fixed
> Status: InProgress-
> VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
> Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
> Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
> Status: NegoPending- InProgress-
> Capabilities: [160 v1] Device Serial Number 39-79-71-c2-85-70-00-00
> Capabilities: [170 v1] Latency Tolerance Reporting
> Max snoop latency: 3145728ns
> Max no snoop latency: 3145728ns
> Capabilities: [178 v1] L1 PM Substates
> L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
> PortCommonModeRestoreTime=150us PortTPowerOnTime=150us
> L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> T_CommonMode=0us LTR1.2_Threshold=163840ns
> L1SubCtl2: T_PwrOn=150us
> Kernel driver in use: r8169
> Kernel modules: r8169
> 00: ec 10 68 81 07 04 10 00 15 00 00 02 10 00 00 00
> 10: 01 e0 00 00 00 00 00 00 04 40 20 a1 00 00 00 00
> 20: 04 00 20 a1 00 00 00 00 00 00 00 00 49 18 68 81
> 30: 00 00 00 00 40 00 00 00 00 00 00 00 ff 01 00 00
> ```


