Return-Path: <netdev+bounces-231619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 369DEBFB914
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 13:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B5BA74F9868
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 11:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721DF32D7D9;
	Wed, 22 Oct 2025 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZVIARDlY"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB1E30B521;
	Wed, 22 Oct 2025 11:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761131604; cv=none; b=pr4SEm0qHEcR+hho2MtgR8GDvhkbKSZq+yMZHDjKpVCODEHPvGPU86OANNdjbJ7GXXQ39IYl1AKrKZlZTeso4VagDEPS5htrJkYiUkRGyVD6ZyG4Q6/cFxOdnAAI3lZlln/JrWfgYkV60BLB8RV9IM/xdHpG47RxBUpuIiGUyvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761131604; c=relaxed/simple;
	bh=C8NR3W5z0eijvd7yQTZAft9+99jTPgoAODtyee++TTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RcQiLJyw2KyZGxX0NxBmqJhmkQoksdh/Ir5rpS2I8iFTnUGi5377TkKnt4T/CWxDGIBd/D/tg334TMRJj3WjNQBWLsdIBvVQuIfvZbW78P8crBJWVQW2IXJob4Pltj/pkhngpWAduZrwdO8rtl0fm3W3UjheVVRnjGfSWM81VUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZVIARDlY; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fcabc415-17ef-4a68-8651-c55d4388db2b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761131600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C0RMxOqPcktF4Icr08/U5wYgtEAUTocjS/7m403u2lU=;
	b=ZVIARDlYumWJAqZSdaMPVJKlxMyFRYAhINuP9lklhASfO+DDbf+92L5g/3yqYxuc0b/R5u
	tOXRrGSCOs2ePesZTt0NCXWS50pUyNPZ1NTa7HT2PFqozPSHRBrLkfBWqQhh51LT3DJG4M
	nXYIZTR5Nk8Dyr+tiPAj0lZpyi8BRFM=
Date: Wed, 22 Oct 2025 12:13:10 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] ptp/ptp_vmw: Implement PTP clock adjustments ops
To: Ajay Kaher <ajay.kaher@broadcom.com>, kuba@kernel.org,
 davem@davemloft.net, richardcochran@gmail.com, nick.shi@broadcom.com,
 alexey.makhalov@broadcom.com, andrew+netdev@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, jiashengjiangcool@gmail.com, andrew@lunn.ch,
 viswanathiyyappan@gmail.com, wei.fang@nxp.com, rmk+kernel@armlinux.org.uk,
 vladimir.oltean@nxp.com, cjubran@nvidia.com, dtatulea@nvidia.com,
 tariqt@nvidia.com
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-kernel@vger.kernel.org, florian.fainelli@broadcom.com,
 vamsi-krishna.brahmajosyula@broadcom.com, tapas.kundu@broadcom.com,
 shubham-sg.gupta@broadcom.com, karen.wang@broadcom.com,
 hari-krishna.ginka@broadcom.com
References: <20251022105128.3679902-1-ajay.kaher@broadcom.com>
 <20251022105128.3679902-2-ajay.kaher@broadcom.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251022105128.3679902-2-ajay.kaher@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 22/10/2025 11:51, Ajay Kaher wrote:
> Implement PTP clock ops that set time and frequency of the underlying
> clock. On supported versions of VMware precision clock virtual device,
> new commands can adjust its time and frequency, allowing time transfer
> from a virtual machine to the underlying hypervisor.
> 
> In case of error, vmware_hypercall doesn't return Linux defined errno,
> converting it to -EIO.
> 
> Cc: Shubham Gupta <shubham-sg.gupta@broadcom.com>
> Cc: Nick Shi <nick.shi@broadcom.com>
> Tested-by: Karen Wang <karen.wang@broadcom.com>
> Tested-by: Hari Krishna Ginka <hari-krishna.ginka@broadcom.com>
> Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
> ---
>   drivers/ptp/ptp_vmw.c | 39 +++++++++++++++++++++++++++++----------
>   1 file changed, 29 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/ptp/ptp_vmw.c b/drivers/ptp/ptp_vmw.c
> index 20ab05c4d..7d117eee4 100644
> --- a/drivers/ptp/ptp_vmw.c
> +++ b/drivers/ptp/ptp_vmw.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>   /*
> - * Copyright (C) 2020 VMware, Inc., Palo Alto, CA., USA
> + * Copyright (C) 2020-2023 VMware, Inc., Palo Alto, CA., USA
> + * Copyright (C) 2024-2025 Broadcom Ltd.
>    *
>    * PTP clock driver for VMware precision clock virtual device.
>    */
> @@ -16,20 +17,36 @@
>   
>   #define VMWARE_CMD_PCLK(nr) ((nr << 16) | 97)
>   #define VMWARE_CMD_PCLK_GETTIME VMWARE_CMD_PCLK(0)
> +#define VMWARE_CMD_PCLK_SETTIME VMWARE_CMD_PCLK(1)
> +#define VMWARE_CMD_PCLK_ADJTIME VMWARE_CMD_PCLK(2)
> +#define VMWARE_CMD_PCLK_ADJFREQ VMWARE_CMD_PCLK(3)
>   
>   static struct acpi_device *ptp_vmw_acpi_device;
>   static struct ptp_clock *ptp_vmw_clock;
>   
> +/*
> + * Helpers for reading and writing to precision clock device.
> + */
>   
> -static int ptp_vmw_pclk_read(u64 *ns)
> +static int ptp_vmw_pclk_read(int cmd, u64 *ns)
>   {
>   	u32 ret, nsec_hi, nsec_lo;
>   
> -	ret = vmware_hypercall3(VMWARE_CMD_PCLK_GETTIME, 0,
> -				&nsec_hi, &nsec_lo);
> +	ret = vmware_hypercall3(cmd, 0, &nsec_hi, &nsec_lo);
>   	if (ret == 0)
>   		*ns = ((u64)nsec_hi << 32) | nsec_lo;
> -	return ret;
> +
> +	return ret != 0 ? -EIO : 0;
> +}

Why do you need to introduce this change? VMWARE_CMD_PCLK_GETTIME is
the only command used in read() in both patches of this patchset.



