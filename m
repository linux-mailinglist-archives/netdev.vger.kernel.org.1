Return-Path: <netdev+bounces-141354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8789BA871
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 23:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E5DDB21139
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 22:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE5518C033;
	Sun,  3 Nov 2024 22:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kF303OGq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A78A18B473;
	Sun,  3 Nov 2024 22:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730671343; cv=none; b=WzFYnu4W2IgVv0DKapcD3GcLDwEXND9Weh+ImDpdF4nESl7MZQacKraoqqDcrwCJRBT8JgfBOqW8GvO7MxTo38wCcVw9yBQX0GeBxkxzGI6yz6cFziSydA/G0D8LB2wsr+MsOTWiVFdotD7lRxyHkNfjf5NkpdMyd/YGYPgHKgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730671343; c=relaxed/simple;
	bh=7LUTBIhdbf0mwKlcqPNuhRJ2aQYtNyzc6hD9vCHcKyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZakGA5WobYt3ayBHLUTLpmkiHDVAmTAgkoh3AY7N1NzwDM67h0DdF0kp4vSTXKzhVFOrHgl8nk0N7DaRY6AIYyRU8SzaogTOp4ecgqTPAoN32/S9PeWuMd6gELJoDAauFMxtUTUCM8g9XQ8V6P4QKx5TjMsRcvTEQoIo/d1dnjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kF303OGq; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4316f3d3c21so27874115e9.3;
        Sun, 03 Nov 2024 14:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730671340; x=1731276140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vJJUevNe9GvVm+0On8RuMBavqwvRAie7DrYUh8hFkvM=;
        b=kF303OGq/6LM9LBccYxvSSbMCiVnnLlA/k4zkU78+JkbXcw1eJLNd5FDZMJslwZ+Zx
         vZqUeKTu2Ezojhv5cMrt5GRFtBBcp9sNTtlu0xw8lSk+wEPqPogXddT5Wfy6d1V8wBCd
         nPs9LcEQweV3P31mJpdZYiK7giL9Q3RgTuYQJ3MsgQrNdAfpunZPq7HGLVRZ+vYWECxg
         pSlVnO3UWr08s+rfjmHuMETMU/L7tWzXNKp1Ll5HoIeU/fM2L3QYc7TuZqnGGBEaKC0F
         7KHy/XRfGkXP006KU+P81/i8mhl1N/D8PNi8VpmiXQXF5VIMOTOqTGUv5csTHUyXoKHk
         +MIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730671340; x=1731276140;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vJJUevNe9GvVm+0On8RuMBavqwvRAie7DrYUh8hFkvM=;
        b=gvuZfrDArQ1/yMq7lUDtUQZm1deu4by79/B75Jb7MPvozyA0b1j92OiyF+Ak+5Apb5
         BVJZr1jd3OCmMfGjb3iLJP4UMJxKW1gGHfHc//osEFWZjhTGAXRYw4/Q4VHBbFuWWlU6
         SYm2nDIn0hK7njsY0LYcTdwJdgnXBc8jmUwL25S45IKpVwK1AKgzzCENPQ3BR5VO4Ci0
         o4kgXfhJp+cS2KvXKQZsx2LbbIM8t0cXkWatbFRNdJmgiJSnGfLmwq0Yv3pIAyZ6JAXu
         hn8EGp7ua0o+15tU0ZQT7ugFLDaxyI8GOaebC/vB9tjjk4bp2b5MhPncXzmj0M+dKuSt
         IF4g==
X-Forwarded-Encrypted: i=1; AJvYcCWRGf5MhbgS3H68JxXXtcDMjB5D4zzL4B7Y/LLeesaANxVxSKHGPjUq5TZr/CeEXkPwEOxnzCFjgGQ=@vger.kernel.org, AJvYcCXFnn3FxU/YXxsLUBO49DKxg7/fEoi770BdB1jMVqenHfVEVhmx4d6ajpOvwcpvRg4FCWHpf9SP@vger.kernel.org, AJvYcCXRfN6BwIjuuwUUNcwipAAy/IXPpexC2vTv8k+QNf0C+aFxToLXb+9JYqXHKVF6vurGezmFhPtCsSGDkN02@vger.kernel.org
X-Gm-Message-State: AOJu0Yy90O5M/m/fnbvJ4Rol17BttaiMop/fxwKnDZD+BcnxIhNe+ub0
	jzu9PnOV9nSaycACA6aFQZXCDfMIpqFttT5bneTyac0Y7KkMvhNV
X-Google-Smtp-Source: AGHT+IEuwfDX9hrStVj6im/q6cc6AdiNOutRjb+QmjbCLyXWPWbUdJn2VcL5jeZB6ik+bwlrR6183w==
X-Received: by 2002:a05:600c:3c97:b0:431:2b66:44f7 with SMTP id 5b1f17b1804b1-431bb9decf2mr178244385e9.31.1730671339509;
        Sun, 03 Nov 2024 14:02:19 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9aa83asm164499165e9.31.2024.11.03.14.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Nov 2024 14:02:18 -0800 (PST)
Message-ID: <1657857c-7761-4fea-aad2-f26c69473895@gmail.com>
Date: Mon, 4 Nov 2024 00:02:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v2] net: wwan: t7xx: reset device if suspend fails
To: linasvepstas@gmail.com, Bjorn Helgaas <helgaas@kernel.org>
Cc: Jinjian Song <jinjian.song@fibocom.com>,
 chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com,
 ricardo.martinez@linux.intel.com, loic.poulain@linaro.org,
 johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, angelogioacchino.delregno@collabora.com,
 bhelgaas@google.com, corbet@lwn.net, danielwinkler@google.com,
 korneld@google.com, linux-arm-kernel@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
 netdev@vger.kernel.org
References: <20241031130930.5583-1-jinjian.song@fibocom.com>
 <20241031170428.GA1249507@bhelgaas>
 <CAHrUA36X2cMZ4WNtRO7NoLaupBNfecLLxDfSVZ4mZzbzHiDjRA@mail.gmail.com>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <CAHrUA36X2cMZ4WNtRO7NoLaupBNfecLLxDfSVZ4mZzbzHiDjRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Bjorn, Linas,

many thanks for clarifying this tricky topic! Hope this information can 
serve a good starting point for Jinjian to develop a proper solution for 
that case.

On 03.11.2024 03:24, Linas Vepstas wrote:
> Top-post reply.
> 
> What Bjorn says is exactly right. Just one clarifying remark: When PCI
> error recovery was designed, it was envisioned for high-end,
> high-availability servers so that they could reset a failing device
> without forcing a reboot of the OS.  Concepts like suspend/resume did
> not perturb even the unconscious sleep of the engineers. Thus,
> stepping through error recovery during suspend would be novel,
> untested, and perhaps prone to confusion. The error recovery procedure
> is trying to reset the device into a fully-powered-on,
> fully-functional and connected state. This might be problematic if the
> suspend has already walked half-way through power-down. The fact that
> error recovery might run a very long fraction of a second after the
> error is detected further complicates things. The fact that error
> recovery  usually has the driver fully reinitializing the device,
> including reloading the firmware, could be a problem if the firmware
> is not in RAM or is sitting on a suspended block device. So it all
> could be an adventure.
> 
> As to testing: I asked one of the guys in the lab how he did it, and
> he said he would brush a metal wire against the PCI pins. I winced.
> But I guess it's cleaner than pouring coffee on it. Later we developed
> a software tool to artificially inject errors.
> 
> On Fri, Nov 1, 2024 at 8:52 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>> On Thu, Oct 31, 2024 at 09:09:30PM +0800, Jinjian Song wrote:
>>> From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
>>>> On 29.10.2024 05:46, Jinjian Song wrote:
>>>>> From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
>>>>>> On 22.10.2024 11:43, Jinjian Song wrote:
>>>>>>> If driver fails to set the device to suspend, it means that the
>>>>>>> device is abnormal. In this case, reset the device to recover
>>>>>>> when PCIe device is offline.
>>>>>>
>>>>>> Is it a reproducible or a speculative issue? Does the fix
>>>>>> recover modem from a problematic state?
>>>>>>
>>>>>> Anyway we need someone more familiar with this hardware (Intel
>>>>>> or MediaTek engineer) to Ack the change to make sure we are not
>>>>>> going to put a system in a more complicated state.
>>>>>
>>>>> This is a very difficult issue to replicate onece occured and fixed.
>>>>>
>>>>> The issue occured when driver and device lost the connection. I have
>>>>> encountered this problem twice so far:
>>>>> 1. During suspend/resume stress test, there was a probabilistic D3L2
>>>>> time sequence issue with the BIOS, result in PCIe link down, driver
>>>>> read and write the register of device invalid, so suspend failed.
>>>>> This issue was eventually fixed in the BIOS and I was able to restore
>>>>> it through the reset module after reproducing the problem.
>>>>>
>>>>> 2. During idle test, the modem probabilistic hang up, result in PCIe
>>>>> link down, driver read and write the register of device invalid, so
>>>>> suspend failed. This issue was eventually fiex in device modem firmware
>>>>> by adjust a certain power supply voltage, and reset modem as a workround
>>>>> to restore when the MBIM port command timeout in userspace applycations.
>>>>>
>>>>> Hardware reset modem to recover was discussed with MTK, and they said
>>>>> that if we don't want to keep the on-site problem location in case of
>>>>> suspend failure, we can use the recover solution.
>>>>> Both the ocurred issues result in the PCIe link issue, driver can't
>>>>> read and writer the register of WWAN device, so I want to add this
>>>>> path
>>>>> to restore, hardware reset modem can recover modem, but using the
>>>>> pci_channle_offline() as the judgment is my inference.
>>>>
>>>> Thank you for the clarification. Let me summarize what I've understood
>>>> from the explanation:
>>>> a) there were hardware (firmware) issues,
>>>> b) issues already were solved,
>>>> c) issues were not directly related to the device suspension procedure,
>>>> d) you want to implement a backup plan to make the modem support robust.
>>>>
>>>> If got it right, then I would like to recommend to implement a generic
>>>> error handling solution for the PCIe interface. You can check this
>>>> document: Documentation/PCI/pci-error-recovery.rst
>>>
>>> Yes, got it right.
>>> I want to identify the scenario and then recover by reset device,
>>> otherwise suspend failure will aways prevent the system from suspending
>>> if it occurs.
>>
>> If a PCIe link goes down here's my understanding of what happens:
>>
>>    - Writes to the device are silently dropped.
>>
>>    - Reads from the device return ~0 (PCI_POSSIBLE_ERROR()).
>>
>>    - If the device is in a slot and pciehp is enabled, a Data Link
>>      Layer State Changed interrupt will cause pciehp_unconfigure_device()
>>      to detach the driver and remove the pci_dev.
>>
>>    - If AER is enabled, a failed access to the device will cause an AER
>>      interrupt.  If the driver has registered pci_error_handlers, the
>>      driver callbacks will be called, and based on what the driver
>>      returns, the PCI core may reset the device.
>>
>> The pciehp and AER interrupts are *asynchronous* to link down events
>> and to any driver access to the device, so they may be delayed an
>> arbitrary amount of time.
>>
>> Both interrupt paths may lead to the device being marked as "offline".
>> Obviously this is asynchronous with respect to the driver.
>>
>>>>>>> +++ b/drivers/net/wwan/t7xx/t7xx_pci.c
>>>>>>> @@ -427,6 +427,10 @@ static int __t7xx_pci_pm_suspend(struct
>>>>>>> pci_dev *pdev)
>>>>>>>        iowrite32(T7XX_L1_BIT(0), IREG_BASE(t7xx_dev) +
>>>>>>> ENABLE_ASPM_LOWPWR);
>>>>>>>        atomic_set(&t7xx_dev->md_pm_state, MTK_PM_RESUMED);
>>>>>>>        t7xx_pcie_mac_set_int(t7xx_dev, SAP_RGU_INT);
>>>>>>> +    if (pci_channel_offline(pdev)) {
>>>>>>> +        dev_err(&pdev->dev, "Device offline, reset to recover\n");
>>>>>>> +        t7xx_reset_device(t7xx_dev, PLDR);
>>>>>>> +    }
>>
>> This looks like an unreliable way to detect issues.  It only works if
>> AER is enabled, and the device is only marked "offline" some arbitrary
>> length of time *after* a driver access to the device has failed.
>>
>> You can't reliably detect errors on writes to the device.
>>
>> You can only reliably detect errors on reads from the device by
>> looking for PCI_POSSIBLE_ERROR().  Obviously ~0 might be a valid value
>> to read from some registers, so you need device-specific knowledge to
>> know whether ~0 is valid or indicates an error.
>>
>> If AER or DPC are enabled, the driver can be *notified* about read
>> errors and some write errors via pci_error_handlers, but the
>> notification is long after the error.

--
Sergey

