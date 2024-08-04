Return-Path: <netdev+bounces-115567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1EA94703E
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 20:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBBB21F213BE
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 18:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C6E3AC0D;
	Sun,  4 Aug 2024 18:13:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE29B57323;
	Sun,  4 Aug 2024 18:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722795228; cv=none; b=m4XpL4yZQyzL/nbdNnGMVmr27rlp/NQNlv+NhY99F80WZdG0xL2cUggNurk2D85JrtbU7o84FWneBlmEZ6WAGB6Fxo7M+7S1Gx6mmCh72Qy4AYvtkiUKyq96cK9apWBzI95cyVscDpngah93GrOnGytpGtB4cVeGYXqf3ib2n1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722795228; c=relaxed/simple;
	bh=AbcT4rG8Zmg3NlVWwKow0kxWVTs5+bmVHu7mq+S6HME=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f73y37R2zF7/pUlWWAXRxBSWuvD7nLA/pqMbVtZtFRKtCzvWTTflgefcrPOSghElVcq0tpzaZfqgfpHTnANNdCSfF6P976OY/Iy+UTWO68l7Bgc+WKFhqeVNTY4Ms674ts5iDy1UpPvgvnQ0YOaBofZgsCpNIZDvig+lhGVuEhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WcSLB1R5kz67K7y;
	Mon,  5 Aug 2024 02:10:58 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 33AA3140133;
	Mon,  5 Aug 2024 02:13:43 +0800 (CST)
Received: from localhost (10.195.244.131) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sun, 4 Aug
 2024 19:13:42 +0100
Date: Sun, 4 Aug 2024 19:13:39 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v2 15/15] efx: support pio mapping based on cxl
Message-ID: <20240804191339.00001eb9@Huawei.com>
In-Reply-To: <20240715172835.24757-16-alejandro.lucero-palau@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
	<20240715172835.24757-16-alejandro.lucero-palau@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 15 Jul 2024 18:28:35 +0100
alejandro.lucero-palau@amd.com wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> With a device supporting CXL and successfully initialised, use the cxl
> region to map the memory range and use this mapping for PIO buffers.

This explains why you weren't worried about any step of the CXL
code failing and why that wasn't a 'bug' as such.

I'd argue that you should still have the cxl intialization return
an error code and cleanup any state it if hits an error.

Then the top level driver can of course elect to use an alternative
path given that failure.  Logically it belongs there rather than relying
on a buffer being mapped or not.

> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/net/ethernet/sfc/ef10.c      | 25 +++++++++++++++++++++----
>  drivers/net/ethernet/sfc/efx_cxl.c   | 12 +++++++++++-
>  drivers/net/ethernet/sfc/mcdi_pcol.h |  3 +++
>  drivers/net/ethernet/sfc/nic.h       |  1 +
>  4 files changed, 36 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
> index 8fa6c0e9195b..3924076d2628 100644
> --- a/drivers/net/ethernet/sfc/ef10.c
> +++ b/drivers/net/ethernet/sfc/ef10.c
> @@ -24,6 +24,7 @@
>  #include <linux/wait.h>
>  #include <linux/workqueue.h>
>  #include <net/udp_tunnel.h>
> +#include "efx_cxl.h"
>  
>  /* Hardware control for EF10 architecture including 'Huntington'. */
>  
> @@ -177,6 +178,12 @@ static int efx_ef10_init_datapath_caps(struct efx_nic *efx)
>  			  efx->num_mac_stats);
>  	}
>  
> +	if (outlen < MC_CMD_GET_CAPABILITIES_V7_OUT_LEN)
> +		nic_data->datapath_caps3 = 0;
> +	else
> +		nic_data->datapath_caps3 = MCDI_DWORD(outbuf,
> +						      GET_CAPABILITIES_V7_OUT_FLAGS3);
> +
>  	return 0;
>  }
>  
> @@ -1275,10 +1282,20 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
>  			return -ENOMEM;
>  		}
>  		nic_data->pio_write_vi_base = pio_write_vi_base;
> -		nic_data->pio_write_base =
> -			nic_data->wc_membase +
> -			(pio_write_vi_base * efx->vi_stride + ER_DZ_TX_PIOBUF -
> -			 uc_mem_map_size);
> +
> +		if ((nic_data->datapath_caps3 &
> +		    (1 << MC_CMD_GET_CAPABILITIES_V10_OUT_CXL_CONFIG_ENABLE_LBN)) &&
> +		    efx->cxl->ctpio_cxl)
As per comment at the top, I'd prefer to see some clean handling of the an
error passed up to the caller of the cxl init that then sets a flag that
we can clearly see is all about whether we have CXL or not.

Using this buffer mapping is a it too much of a detail in my opinion.

> +		{
> +			nic_data->pio_write_base =
> +				efx->cxl->ctpio_cxl +
> +				(pio_write_vi_base * efx->vi_stride + ER_DZ_TX_PIOBUF -
> +				 uc_mem_map_size);
> +		} else {
> +			nic_data->pio_write_base =nic_data->wc_membase +
> +				(pio_write_vi_base * efx->vi_stride + ER_DZ_TX_PIOBUF -
> +				 uc_mem_map_size);
> +		}



