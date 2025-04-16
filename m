Return-Path: <netdev+bounces-183359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8880A907EF
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 17:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CE875A1059
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 15:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C371DC04A;
	Wed, 16 Apr 2025 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dy5akA0p"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB319A50
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744818329; cv=none; b=jhv2bNzrXlCy0MST049pjMJKZe0JGw9w+dcLatH3qGOgVpDSLdHu531l9AMk8fEAlVlR/M44uCaTSxB24aKXEz5b7/FqJbuLC4tte31YcZg8nUEtaSMB/Wwm/YATEBdSJfPb9kfBP0BBUvBf3LBbUDdMyf90mmbhyuilxbSPIm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744818329; c=relaxed/simple;
	bh=TopqzhtRrEcwJtdNqadLRSmmKa3CCUXt6E7iLBIA9ZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vr+wd6ePJ4LlzqD1ofkscPnRf+yf5zj4zmVlWSJceC+X7I3z3q8YDQk6DthiZLKZG4wm+1+US1lOxqjthx4BlXM6ZW3UiFC3oiZQNwlNor/jPjCiaDDszniNwZ9updkYfHruhiYcArXf+W+L9latvrQfslOplMVJnzIGpj7ADqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dy5akA0p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53G9mFKN007029
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 15:45:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5nrxE3wDuczb4bg5pStE2AzCypvM8BiWyggD7GrqKcA=; b=dy5akA0pP68news0
	TSH2TD+yy1DVslISHLcS3X4xtg8Su708dIGHENXSOhoaLnX0+7I8Lju8cEWIE2GL
	k4w0cbg3j9kb2EkKS3AyS0w8kKtp9B+iGoqwlPj16m5KVjjJ/EF4OjN7FjsYpYLV
	OvEXzyiC4w7z9+odLQdqNPpWDYX672T82SmW7kHdBwI6X9VktSKLvx2fUYrfScer
	r+ZBo6otSqLfhyy7OKDJyL86VmZiCoI4vJjoFFXGVxR6v+zMD2LmGecK48v6ptVQ
	Qwkp3/gkDOxDxV/8WDbwr8ovwI67tghSPq3RARGlzWVlybLZBqfgkBpK/Oauxk/e
	8vDfKA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yfgjkyag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 15:45:26 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-225429696a9so87215535ad.1
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 08:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744818325; x=1745423125;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5nrxE3wDuczb4bg5pStE2AzCypvM8BiWyggD7GrqKcA=;
        b=MABYyBOBknm08RsEhWqRDu3ilID0QoHiCYNMl/6Nhr46xW3a0QEErHeGu5YgT2BtfR
         PTbRzG92LMyOwIrb04urOKKb7jtT7Dl0xQMNUcR7ZP2DsYS3Ie9EG6lLBpxARqSYIFsy
         /ClYDdYYxO5w9gYc0J9l4xPbV6lFY6hlqjDNjCpJaz10PwzRLUhvDvY+tN+s8klCjS/G
         OeanYhb8kC/AWLTPWATntLmZVPqnvadxlBZOuZDDd3wtO0HgE6/ti2mKkJWxiL+3rTRt
         YPSFDeDa4EKoB0YxOQEK68rU/m+xPCj6r/Ax977/r9IA/KY9eapOJPu0Pm4wMCbwxl/p
         Ca8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPcca9odIR3q9h2Bi1HkNHoKL5bcxmcPNTSAD10makxViJyUS48PJS3yXdp10rKx1iStFkq0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuWcnwZJvUcb07Q+H+WZHJs0poBgF/S6fq9F0kjyZYxs22K38O
	imB6Jb7SgdrySnoIiJbPqveR3BXZl85stev8KhRqK9un9YLScD5MopPKq6faoKaqaUZ5AMOPnxT
	GJ6ulrQ/SNU0Zb5iFzBpzdnVVqiSZztwe2o9/7QsTaimxm3gu1eNwRbk=
X-Gm-Gg: ASbGnctAoi6jZ6IuETmda9NR/SK6HqdUXEM6hGk/9YCSPc4MDL94c7VlfqZbnPBu5O3
	c36ULRhYTIX7ESZ2/Dfmv8nvbwyGCAxvk/VsUC9u1U11f+kiJxiFvnC4udL44AZd7WsTzEbCPPG
	SNeURwZjrg+XtyXm6OXarcBV27UhNx75dzHs5o/d/UtMuempVQtw/9iOEBNyijAnVYAHjPJcp5j
	qhbdO47VtmtrkQQemGoe6aoek1vSv34hdtUGIEWX5iU6ZRAZI3aSIUCWmoIFqvFHrSkgD1YkbI3
	Oqdnic3CbMenGdnncR5uRCStDE7nn1j8/meoYp4Lvvw=
X-Received: by 2002:a17:902:ccc2:b0:220:efc8:60b1 with SMTP id d9443c01a7336-22c3597ee16mr38252835ad.39.1744818324913;
        Wed, 16 Apr 2025 08:45:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4tMvWkm9MtAfqsPind80z9t9MOZHrBx7tLcDdN+bCo6aQHd485f7jr2Qd15a2Wv+6WjcvLQ==
X-Received: by 2002:a17:902:ccc2:b0:220:efc8:60b1 with SMTP id d9443c01a7336-22c3597ee16mr38252325ad.39.1744818324430;
        Wed, 16 Apr 2025 08:45:24 -0700 (PDT)
Received: from [192.168.29.92] ([49.43.231.216])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33ef111bsm15798655ad.3.2025.04.16.08.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 08:45:24 -0700 (PDT)
Message-ID: <276986c2-7dbe-33e5-3c11-ba8b2b2083a2@oss.qualcomm.com>
Date: Wed, 16 Apr 2025 21:15:19 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] r8169: do not call rtl8169_down() twice on shutdown
Content-Language: en-US
To: Niklas Cassel <cassel@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        netdev@vger.kernel.org
References: <20250415095335.506266-2-cassel@kernel.org>
 <4f8d3018-d7e5-47e5-b99d-550f8a4011ee@gmail.com> <Z_-7I26WVApG98Ej@ryzen>
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <Z_-7I26WVApG98Ej@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: D5EtH3Oi8I1staTiWBFW4Q7cfGuJ5p7D
X-Proofpoint-ORIG-GUID: D5EtH3Oi8I1staTiWBFW4Q7cfGuJ5p7D
X-Authority-Analysis: v=2.4 cv=Cve/cm4D c=1 sm=1 tr=0 ts=67ffd096 cx=c_pps a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ozAjUsZc/ya1UnB0O6+iCQ==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=ccdU49sxb5jRn6SkWpkA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_04,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=970 mlxscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504160129



On 4/16/2025 7:43 PM, Niklas Cassel wrote:
> On Tue, Apr 15, 2025 at 08:48:53PM +0200, Heiner Kallweit wrote:
>> On 15.04.2025 11:53, Niklas Cassel wrote:
>>> For a PCI controller driver with a .shutdown() callback, we will see the
>>> following warning:
>>
>> I saw the related mail thread, IIRC it was about potential new code.
>> Is this right? Or do we talk about existing code? Then it would have
>> to be treated as fix.
> 
> The qcom PCIe controller driver wants to add a .shutdown callback:
> https://lore.kernel.org/linux-pci/tb6kkyfgpemzacfwbg45otgcrg5ltj323y6ufjy3bw3rgri7uf@vrmmtueyg7su/T/#t
> 
> In that shutdown callback, they want to call dw_pcie_host_deinit(),
> which will call pci_stop_root_bus().
> 
> Looking at other PCIe controller drivers:
> $ git grep -p pci_stop_root_bus
> 
> There seems to be a lot of PCIe controller drivers that call
> pci_stop_root_bus(), but they all do it from the .remove() callback,
> not from the .shutdown() callback.
> 
> Actually, I can't see any existing PCIe controller driver that calls
> pci_stop_root_bus() from the .shutdown() callback.
> 
Not all endpoint have .shutdown callback(), the endpoint drivers still
will try to do data transfers if we don't call pci_stop_stop_bus(), and
if there are ongoing transfers over link and if the controller driver
turns off the PCIe link without calling pci_stop_root_bus we might get
bus errors, NOC errors etc which can hang the system.

This should be handled gracefully in the rtl8169 driver.
> So perhaps we should hold off with this patch.
> 
I disagree on this, it might be causing issue with net driver, but we
might face some other issues as explained above if we don't call
pci_stop_root_bus().

- Krishna Chaitanya.
> Adding the qcom folks to CC.
> 
> 
> Kind regards,
> Niklas
> 
> 
>>
>> Existence of a shutdown callback itself is not the problem, the problem is
>> that all PCI bus devices are removed as part of shutdown handling for this
>> specific controller driver.
>>
>>> [   12.020111] called from state HALTED
>>> [   12.020459] WARNING: CPU: 7 PID: 229 at drivers/net/phy/phy.c:1630 phy_stop+0x134/0x1a0
>>>
>>> This is because rtl8169_down() (which calls phy_stop()) is called twice
>>> during shutdown.
>>>
>>> First time:
>>> [   23.827764] Call trace:
>>> [   23.827765]  show_stack+0x20/0x40 (C)
>>> [   23.827774]  dump_stack_lvl+0x60/0x80
>>> [   23.827778]  dump_stack+0x18/0x24
>>> [   23.827782]  rtl8169_down+0x30/0x2a0
>>> [   23.827788]  rtl_shutdown+0xb0/0xc0
>>> [   23.827792]  pci_device_shutdown+0x3c/0x88
>>> [   23.827797]  device_shutdown+0x150/0x278
>>> [   23.827802]  kernel_restart+0x4c/0xb8
>>>
>>> Second time:
>>> [   23.841468] Call trace:
>>> [   23.841470]  show_stack+0x20/0x40 (C)
>>> [   23.841478]  dump_stack_lvl+0x60/0x80
>>> [   23.841483]  dump_stack+0x18/0x24
>>> [   23.841486]  rtl8169_down+0x30/0x2a0
>>> [   23.841492]  rtl8169_close+0x64/0x100
>>> [   23.841496]  __dev_close_many+0xbc/0x1f0
>>> [   23.841502]  dev_close_many+0x94/0x160
>>> [   23.841505]  unregister_netdevice_many_notify+0x160/0x9d0
>>> [   23.841510]  unregister_netdevice_queue+0xf0/0x100
>>> [   23.841515]  unregister_netdev+0x2c/0x58
>>> [   23.841519]  rtl_remove_one+0xa0/0xe0
>>> [   23.841524]  pci_device_remove+0x4c/0xf8
>>> [   23.841528]  device_remove+0x54/0x90
>>> [   23.841534]  device_release_driver_internal+0x1d4/0x238
>>> [   23.841539]  device_release_driver+0x20/0x38
>>> [   23.841544]  pci_stop_bus_device+0x84/0xe0
>>> [   23.841548]  pci_stop_bus_device+0x40/0xe0
>>> [   23.841552]  pci_stop_root_bus+0x48/0x80
>>> [   23.841555]  dw_pcie_host_deinit+0x34/0xe0
>>> [   23.841559]  rockchip_pcie_shutdown+0x20/0x38
>>> [   23.841565]  platform_shutdown+0x2c/0x48
>>> [   23.841571]  device_shutdown+0x150/0x278
>>> [   23.841575]  kernel_restart+0x4c/0xb8
>>>
>>> Add a netif_device_present() guard around the rtl8169_down() call in
>>> rtl8169_close(), to avoid rtl8169_down() from being called twice.
>>>
>>> This matches how e.g. e1000e_close() has a netif_device_present() guard
>>> around the e1000e_down() call.
>>>
>> This approach has at least two issues:
>>
>> 1. Likely it breaks WoL, because now phy_detach() is called.
>> 2. r8169 shutdown callback sets device to D3hot, PCI core wakes it up again
>>     for the remove callback. Now it's left in D0.
>>
>> I'll also spend a few thoughts on how to solve this best.
>>
>>> Signed-off-by: Niklas Cassel <cassel@kernel.org>
>>> ---
>>>   drivers/net/ethernet/realtek/r8169_main.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>>> index 4eebd9cb40a3..0300a06ae260 100644
>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>>> @@ -4879,7 +4879,8 @@ static int rtl8169_close(struct net_device *dev)
>>>   	pm_runtime_get_sync(&pdev->dev);
>>>   
>>>   	netif_stop_queue(dev);
>>> -	rtl8169_down(tp);
>>> +	if (netif_device_present(tp->dev))
>>> +		rtl8169_down(tp);
>>>   	rtl8169_rx_clear(tp);
>>>   
>>>   	free_irq(tp->irq, tp);
>>

