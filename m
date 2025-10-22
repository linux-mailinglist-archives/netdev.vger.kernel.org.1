Return-Path: <netdev+bounces-231903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7380BFE63E
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 00:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39EB84E1195
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 22:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C30226F443;
	Wed, 22 Oct 2025 22:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nvy59lCx"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC23B286D53
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 22:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761171472; cv=none; b=MVwqWBw9pRD2Us80IhEeLABG/MTcUGRnLkrCbidDl4Yn7T3GzD/UdyeEnCIlPeVGo+im22PajMnMCvZmsOhOuqyI9nqElAjTMMTkiG3iVmWBowSOyjMrtPBHbzPyI0PzLy7KiOgxOgnkXh/7on7ZN1ZBhuLlbPV6q0OVIS5WZFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761171472; c=relaxed/simple;
	bh=ecJKK4xqEWMQdohLNwrG1a262eWCzSJl9W3ejMnH2Kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QedXyyVAbKaeCrpVIZk3TwS4m8qxHfpx3N9rZgtj5M4Zfwfk76lClTJa2NqLxiaJHf4saCIzkPURULxLO4XrmnnjxNpcNa8X3iqao+WlzoiSFD1uwANw3pnil3eGroXlmythOwGPKcH7o1t94MKyeRCTVFn5IU1JvZwOjmrXWnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nvy59lCx; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <679df304-ebbf-4268-9834-b851d96e8366@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761171467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4+HK4rb9E/9aB/kAkTrE6m4QwZlKN/ZDhogoDFCK3Hg=;
	b=nvy59lCx5LbxlcajzRYulKeIOTEqWHIdetP2IQHD9HathSvbB3FdED7zObquBNiM/aIuXS
	CII0zNMSqPnYGhds88EYepMuGZ8iOFIYkHgUYiVZAkG/FQs9z/zX6zPCf5LdrBLtZzak1P
	auNJ6Mzt26ofLSU/VrBjMcqeSPV1egk=
Date: Wed, 22 Oct 2025 23:17:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] ptp/ptp_vmw: Implement PTP clock adjustments ops
To: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: kuba@kernel.org, davem@davemloft.net, richardcochran@gmail.com,
 nick.shi@broadcom.com, alexey.makhalov@broadcom.com, andrew+netdev@lunn.ch,
 edumazet@google.com, pabeni@redhat.com, jiashengjiangcool@gmail.com,
 andrew@lunn.ch, viswanathiyyappan@gmail.com, wei.fang@nxp.com,
 rmk+kernel@armlinux.org.uk, vladimir.oltean@nxp.com, cjubran@nvidia.com,
 dtatulea@nvidia.com, tariqt@nvidia.com, netdev@vger.kernel.org,
 bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org,
 florian.fainelli@broadcom.com, vamsi-krishna.brahmajosyula@broadcom.com,
 tapas.kundu@broadcom.com, shubham-sg.gupta@broadcom.com,
 karen.wang@broadcom.com, hari-krishna.ginka@broadcom.com
References: <20251022105128.3679902-1-ajay.kaher@broadcom.com>
 <20251022105128.3679902-2-ajay.kaher@broadcom.com>
 <fcabc415-17ef-4a68-8651-c55d4388db2b@linux.dev>
 <CAD2QZ9b9+TP1YnpL0DkNqn5kdgxseMooBr8xJ9fMu+0tgtX=vA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAD2QZ9b9+TP1YnpL0DkNqn5kdgxseMooBr8xJ9fMu+0tgtX=vA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 22/10/2025 18:27, Ajay Kaher wrote:
> On Wed, Oct 22, 2025 at 4:43 PM Vadim Fedorenko
> <vadim.fedorenko@linux.dev> wrote:
>>
>> On 22/10/2025 11:51, Ajay Kaher wrote:
>>> Implement PTP clock ops that set time and frequency of the underlying
>>> clock. On supported versions of VMware precision clock virtual device,
>>> new commands can adjust its time and frequency, allowing time transfer
>>> from a virtual machine to the underlying hypervisor.
>>>
>>> In case of error, vmware_hypercall doesn't return Linux defined errno,
>>> converting it to -EIO.
>>>
>>> Cc: Shubham Gupta <shubham-sg.gupta@broadcom.com>
>>> Cc: Nick Shi <nick.shi@broadcom.com>
>>> Tested-by: Karen Wang <karen.wang@broadcom.com>
>>> Tested-by: Hari Krishna Ginka <hari-krishna.ginka@broadcom.com>
>>> Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
>>> ---
>>>    drivers/ptp/ptp_vmw.c | 39 +++++++++++++++++++++++++++++----------
>>>    1 file changed, 29 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/ptp/ptp_vmw.c b/drivers/ptp/ptp_vmw.c
>>> index 20ab05c4d..7d117eee4 100644
>>> --- a/drivers/ptp/ptp_vmw.c
>>> +++ b/drivers/ptp/ptp_vmw.c
>>> @@ -1,6 +1,7 @@
>>>    // SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>>>    /*
>>> - * Copyright (C) 2020 VMware, Inc., Palo Alto, CA., USA
>>> + * Copyright (C) 2020-2023 VMware, Inc., Palo Alto, CA., USA
>>> + * Copyright (C) 2024-2025 Broadcom Ltd.
>>>     *
>>>     * PTP clock driver for VMware precision clock virtual device.
>>>     */
>>> @@ -16,20 +17,36 @@
>>>
>>>    #define VMWARE_CMD_PCLK(nr) ((nr << 16) | 97)
>>>    #define VMWARE_CMD_PCLK_GETTIME VMWARE_CMD_PCLK(0)
>>> +#define VMWARE_CMD_PCLK_SETTIME VMWARE_CMD_PCLK(1)
>>> +#define VMWARE_CMD_PCLK_ADJTIME VMWARE_CMD_PCLK(2)
>>> +#define VMWARE_CMD_PCLK_ADJFREQ VMWARE_CMD_PCLK(3)
>>>
>>>    static struct acpi_device *ptp_vmw_acpi_device;
>>>    static struct ptp_clock *ptp_vmw_clock;
>>>
>>> +/*
>>> + * Helpers for reading and writing to precision clock device.
>>> + */
>>>
>>> -static int ptp_vmw_pclk_read(u64 *ns)
>>> +static int ptp_vmw_pclk_read(int cmd, u64 *ns)
>>>    {
>>>        u32 ret, nsec_hi, nsec_lo;
>>>
>>> -     ret = vmware_hypercall3(VMWARE_CMD_PCLK_GETTIME, 0,
>>> -                             &nsec_hi, &nsec_lo);
>>> +     ret = vmware_hypercall3(cmd, 0, &nsec_hi, &nsec_lo);
>>>        if (ret == 0)
>>>                *ns = ((u64)nsec_hi << 32) | nsec_lo;
>>> -     return ret;
>>> +
>>> +     return ret != 0 ? -EIO : 0;
>>> +}
>>
>> Why do you need to introduce this change? VMWARE_CMD_PCLK_GETTIME is
>> the only command used in read() in both patches of this patchset.
>>
> 
> Vadim, thanks for looking into patches.
> 
> I have added ptp_vmw_pclk_write() where cmd has been passed as argument.
> Keeping the same format for ptp_vmw_pclk_read() as well, also may be useful
> in future.
> 
> Let me know if you think it's better to keep ptp_vmw_pclk_read() as it
> is. I will
> revert in v3.

I do believe it's better to keep code as is until you have real use of
new feature. And I'm not quite sure which command you can use to do
another read?

