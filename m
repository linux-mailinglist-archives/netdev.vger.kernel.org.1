Return-Path: <netdev+bounces-140521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B04BB9B6C2B
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 19:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E278B1C20CEC
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 18:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A5B1CB53E;
	Wed, 30 Oct 2024 18:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D38t/BjK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9C41BD9F4;
	Wed, 30 Oct 2024 18:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730313186; cv=none; b=FB7E2a0fXT7/xklVT+CUaplIsJkpXktYmrKwyXeFCEoah6DB3aq6XK0wv9EPHaTxNAbM9tkKyjXi+Ln6+d5NrDMZNLzn2TbOohyN6weX2NTRR6SSpgEX0pk2qXzWWXIryQOUFH850K2RWBeIvaiSMe4jXbsSBWzATBtTAGNO2qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730313186; c=relaxed/simple;
	bh=2RqiUqDobjJb8TzlK86nk9gSLyBgAadi2DM5HjlMjnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LdgbHlbEHiI0GxCfT+a/p6xF3dkxtYHpKtMow9B2wxL020WKCRNc/uriklQLAyi84pLE3s007a557Nyti8zfXx3IKbo20w/dWZJaPSFrnLECB/Yj2WKD5PxGvjZqG2oftIiyMdhK5zY26A/l6nkvEjmdvPttvVNmMzsTawVv6h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D38t/BjK; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d4fd00574so107858f8f.0;
        Wed, 30 Oct 2024 11:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730313182; x=1730917982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UpRP2MsIVMkQvKjqAp60xM5OFj18JwlP60eDqeYPxhc=;
        b=D38t/BjKst48gAkdZMiGuYGPLc5bc4rRNo2XmVxbPLFgVWK/WE8efRcIXRULqFSpcg
         3tK438dJf2z5z7MhTZyaMz+Dq8oG//ftPX9qZtxKByPItj9FZMHQkYIOJh+GMMsP4zj6
         mwvuZdAuhRRQ3vTxCKKxWqoIrSgjm1Npkh5QX44D4d3hgdcVQ35Q62Kqfx4m9DQSBiL2
         vnRVbT7pxnJ2BroCiSltE3lPZiW9nS7KXNR8kwBeX+7a0fSc8UEsyIWcaQRYk40kbuYB
         W9QBkcaaJlmBXpcHd+vAqfUteW/pqVMNrOckHHYzV8PoZqVmWDT58c3vLLQQea7zQ1mz
         xBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730313182; x=1730917982;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UpRP2MsIVMkQvKjqAp60xM5OFj18JwlP60eDqeYPxhc=;
        b=Bz0meVGx6GaYmyQ0ZTXEthYzTVwFjcFLvRK8aVQDq4iOlgMxOgtONoIgldksm88Y6J
         irWKyY4GE2BJLgUGNnNOZeKtEJRRCPU8lH+5Xfpn+XU1xkfox/ShoO9rFkNDnm3bkGB3
         HzVbjII6x+d1Bw8o12jjdCLJpAPs6I5NUpq2RDipU4prEaaYZ1AcDJlXbsYgd4ss7i91
         rXCPo9Qie2Y54c3LgNtgoYESXvP6ZA+Ggiu9PBNOk4Wt7kmI/fH5cA7OepvI9agigP8v
         UMnw59r6WPqk0a4kwRQfskiqTbHoskd3AXdma1kWAB0WUAIx0SQKEG8Xnwjwhpov2NwW
         bgFg==
X-Forwarded-Encrypted: i=1; AJvYcCVY5yLB9DYR6JOb10NagSnMH40M7ToavRUZpZnAENt4LKe7TNlK4lTV5bI12q3gBSLTuGtsaUCJAIE=@vger.kernel.org, AJvYcCW9NE1gMyYtCbP2zKlCM0e4Sg3xl5RVIiPVGWasOaYMyPdNnvjkYuojVvbraFwM8waJq1DBl1Dr5XAhPQI/@vger.kernel.org, AJvYcCWQJcY2QhejS/hcb4RJjCBrs3Aqzzk2dhwqncNppnHjSRX8coQjClYvc6cdmlWcc3a43Njpk7IA@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg8kXk4iEZcwMoJMyYJd9W8WFw558BaPqO0FoUAnOs7p2/Ny4e
	In4CytzxA2l8FAPUhHn6Cyf9Mp4wt23XvbKQyoP+EKfq7anjYGVt
X-Google-Smtp-Source: AGHT+IGUMEiJ5yqJQbqO4xA7/aA59KAvngIQZIC7OTI5GXqXyrK5y8mDR/1ooulIWDi8IfTeYR0uyA==
X-Received: by 2002:a5d:688b:0:b0:374:c613:7c58 with SMTP id ffacd0b85a97d-381b97c08fbmr2847327f8f.29.1730313181936;
        Wed, 30 Oct 2024 11:33:01 -0700 (PDT)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b71221sm15888748f8f.68.2024.10.30.11.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 11:33:01 -0700 (PDT)
Message-ID: <e37b9baa-51e5-48f9-a15d-521f29ce5f9c@gmail.com>
Date: Wed, 30 Oct 2024 20:33:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v2] net: wwan: t7xx: reset device if suspend fails
To: Jinjian Song <jinjian.song@fibocom.com>,
 chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com,
 ricardo.martinez@linux.intel.com, loic.poulain@linaro.org,
 johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: angelogioacchino.delregno@collabora.com, corbet@lwn.net,
 danielwinkler@google.com, helgaas@kernel.org, korneld@google.com,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 matthias.bgg@gmail.com, netdev@vger.kernel.org,
 Linas Vepstas <linasvepstas@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>
References: <20241022084348.4571-1-jinjian.song@fibocom.com>
 <20241029034657.6937-1-jinjian.song@fibocom.com>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20241029034657.6937-1-jinjian.song@fibocom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jinjian,

On 29.10.2024 05:46, Jinjian Song wrote:
> From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
>> On 22.10.2024 11:43, Jinjian Song wrote:
>>> If driver fails to set the device to suspend, it means that the
>>> device is abnormal. In this case, reset the device to recover
>>> when PCIe device is offline.
>>
>> Is it a reproducible or a speculative issue? Does the fix recover 
>> modem from a problematic state?
>>
>> Anyway we need someone more familiar with this hardware (Intel or 
>> MediaTek engineer) to Ack the change to make sure we are not going to 
>> put a system in a more complicated state.
> 
> Hi Sergey,
> 
> This is a very difficult issue to replicate onece occured and fixed.
> 
> The issue occured when driver and device lost the connection. I have
> encountered this problem twice so far:
> 1. During suspend/resume stress test, there was a probabilistic D3L2
> time sequence issue with the BIOS, result in PCIe link down, driver
> read and write the register of device invalid, so suspend failed.
> This issue was eventually fixed in the BIOS and I was able to restore
> it through the reset module after reproducing the problem.
> 
> 2. During idle test, the modem probabilistic hang up, result in PCIe
> link down, driver read and write the register of device invalid, so
> suspend failed. This issue was eventually fiex in device modem firmware
> by adjust a certain power supply voltage, and reset modem as a workround
> to restore when the MBIM port command timeout in userspace applycations.
> 
> Hardware reset modem to recover was discussed with MTK, and they said
> that if we don't want to keep the on-site problem location in case of
> suspend failure, we can use the recover solution.
> Both the ocurred issues result in the PCIe link issue, driver can't read 
> and writer the register of WWAN device, so I want to add this path
> to restore, hardware reset modem can recover modem, but using the 
> pci_channle_offline() as the judgment is my inference.

Thank you for the clarification. Let me summarize what I've understood 
from the explanation:
a) there were hardware (firmware) issues,
b) issues already were solved,
c) issues were not directly related to the device suspension procedure,
d) you want to implement a backup plan to make the modem support robust.

If got it right, then I would like to recommend to implement a generic 
error handling solution for the PCIe interface. You can check this 
document: Documentation/PCI/pci-error-recovery.rst

Suddenly, I am not an expert in the PCIe link recovery procedure, so 
I've CCed this message to PCI subsystem maintainers. I hope they can 
suggest a conceptually correct way to handle these cases.

>>> Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
>>> ---
>>> V2:
>>>   * Add judgment, reset when device is offline
>>> ---
>>>   drivers/net/wwan/t7xx/t7xx_pci.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/ 
>>> t7xx/t7xx_pci.c
>>> index e556e5bd49ab..4f89a353588b 100644
>>> --- a/drivers/net/wwan/t7xx/t7xx_pci.c
>>> +++ b/drivers/net/wwan/t7xx/t7xx_pci.c
>>> @@ -427,6 +427,10 @@ static int __t7xx_pci_pm_suspend(struct pci_dev 
>>> *pdev)
>>>       iowrite32(T7XX_L1_BIT(0), IREG_BASE(t7xx_dev) + 
>>> ENABLE_ASPM_LOWPWR);
>>>       atomic_set(&t7xx_dev->md_pm_state, MTK_PM_RESUMED);
>>>       t7xx_pcie_mac_set_int(t7xx_dev, SAP_RGU_INT);
>>> +    if (pci_channel_offline(pdev)) {
>>> +        dev_err(&pdev->dev, "Device offline, reset to recover\n");
>>> +        t7xx_reset_device(t7xx_dev, PLDR);
>>> +    }
>>>       return ret;
>>>   }

--
Sergey

