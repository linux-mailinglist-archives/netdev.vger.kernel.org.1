Return-Path: <netdev+bounces-199459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25477AE0621
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 14:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C85053A68D6
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 12:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853FA23D2BC;
	Thu, 19 Jun 2025 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I/Q1/tW9"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A26523D283
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 12:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750337026; cv=none; b=XBc3DevS5VU9aS7hRAYav27dIwX/RZDyUAsy8Ij7wgqqOmPjxqMZHehdta1wTxrXcznBlIOI1EVR3YHbrK0SHwEKwjUueTM7nn0/W83w9hLZcTYv89N1v3JZ99VV2tbD+fMWUNE85TrYatl+wXjwJYV+3BTcKkvPII44z/ypLYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750337026; c=relaxed/simple;
	bh=6VrA574brT6VW/4UkR55B+2t41g9GvZgzDG0MC8lqW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D6U8X66JaHTo57JNX6Vd1mlgCGVKboF+N04N7Lmtg4klPJJ9Ub+/HCi20Jhk4kr+350SEK8ajF1yyOdWWAkPX1izKbUpIjm13MEVAR5IPjv5BE7/ebvIMwdV49umV3jgg6NpBx56dDRbIk6speS3/nO9KhcqWx4b7MSsbwJ78lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I/Q1/tW9; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6735a940-bce8-43f5-a6d7-7a48ace197c8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750337019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=88IeTx3F+Ru63iJfLhr9wYINj1DkxKZKk7DiEWTICcw=;
	b=I/Q1/tW9NmVAli9fK97FXdwi9um9a5ePp3DzfxcTOgIiIaRm3KVi4eKOcHQmlEsE2SSas6
	xWEE0ZVi+UrtKvHxP3GfsUSP89LWKtK3bVXi2ILF4wdjxvvXYUFUB2hsiapeswu7k39Kxb
	MxtirJ1a9+m24g+W2b8WVPMYKOltQk8=
Date: Thu, 19 Jun 2025 13:43:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next, 03/10] bng_en: Add firmware communication mechanism
To: Vikas Gupta <vikas.gupta@broadcom.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 vsrama-krishna.nemani@broadcom.com,
 Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>,
 Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
References: <20250618144743.843815-1-vikas.gupta@broadcom.com>
 <20250618144743.843815-4-vikas.gupta@broadcom.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250618144743.843815-4-vikas.gupta@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 18/06/2025 15:47, Vikas Gupta wrote:
> Add support to communicate with the firmware.
> Future patches will use these functions to send the
> messages to the firmware.
> Functions support allocating request/response buffers
> to send a particular command. Each command has certain
> timeout value to which the driver waits for response from
> the firmware. In error case, commands may be either timed
> out waiting on response from the firmware or may return
> a specific error code.
> 
> Signed-off-by: Vikas Gupta <vikas.gupta@broadcom.com>
> Reviewed-by: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
> Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
> ---
>   drivers/net/ethernet/broadcom/bnge/Makefile   |   3 +-
>   drivers/net/ethernet/broadcom/bnge/bnge.h     |  13 +
>   .../net/ethernet/broadcom/bnge/bnge_hwrm.c    | 503 ++++++++++++++++++
>   .../net/ethernet/broadcom/bnge/bnge_hwrm.h    | 107 ++++
>   4 files changed, 625 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_hwrm.c
>   create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_hwrm.h
> 
> diff --git a/drivers/net/ethernet/broadcom/bnge/Makefile b/drivers/net/ethernet/broadcom/bnge/Makefile
> index e021a14d2fa0..b296d7de56ce 100644
> --- a/drivers/net/ethernet/broadcom/bnge/Makefile
> +++ b/drivers/net/ethernet/broadcom/bnge/Makefile
> @@ -3,4 +3,5 @@
>   obj-$(CONFIG_BNGE) += bng_en.o
>   
>   bng_en-y := bnge_core.o \
> -	    bnge_devlink.o
> +	    bnge_devlink.o \
> +	    bnge_hwrm.o
> diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
> index 19d85aabab4e..8f2a562d9ae2 100644
> --- a/drivers/net/ethernet/broadcom/bnge/bnge.h
> +++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
> @@ -13,6 +13,8 @@ enum board_idx {
>   	BCM57708,
>   };
>   
> +#define INVALID_HW_RING_ID      ((u16)-1)
> +
>   struct bnge_dev {
>   	struct device	*dev;
>   	struct pci_dev	*pdev;
> @@ -22,6 +24,17 @@ struct bnge_dev {
>   	char		board_serialno[BNGE_VPD_FLD_LEN];
>   
>   	void __iomem	*bar0;
> +
> +	/* HWRM members */
> +	u16			hwrm_cmd_seq;
> +	u16			hwrm_cmd_kong_seq;
> +	struct dma_pool		*hwrm_dma_pool;
> +	struct hlist_head	hwrm_pending_list;
> +	u16			hwrm_max_req_len;
> +	u16			hwrm_max_ext_req_len;
> +	unsigned int		hwrm_cmd_timeout;
> +	unsigned int		hwrm_cmd_max_timeout;
> +	struct mutex		hwrm_cmd_lock;	/* serialize hwrm messages */
>   };

It's all looks pretty similar to what is used in bnxt driver. Why do you
duplicate the code rather then reusing (and improving) the existing one?

I didn't look carefully, but in case it's impossible to merge hwrm code
from bnxt, you have to make function names prepended with bnge prefix...




