Return-Path: <netdev+bounces-151516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1383A9EFE27
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 22:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AE2F168FBC
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 21:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8F21BE251;
	Thu, 12 Dec 2024 21:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0UUPPPx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723BB1AAE28;
	Thu, 12 Dec 2024 21:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734038554; cv=none; b=dONibJqmZKZBuJUQqpR22JcvKKPhus7D6btPqbtKf3eGlOE0lydIUAHdbuUIn7JTplNLb0l/zIJl1ao0ypekpXDomiGtbi0U2DnvUJWk+JG2liJQ5NN4xtzsTSwVi/FrcVjppVQg69E/ukTxYQQFQwQAk6AfLR2+s+gjWUu7bNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734038554; c=relaxed/simple;
	bh=ek95GW+tU8Tylid/kx9coHa0RUVz9tmbmJ7ZUEm1zG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3nFcBrLHPHdwlgYlJ2OE5UIu/FC4tKA8SpH308hEOkvm8MpeorurHbdjiS6HQbXChvN10djLewXrd8tuzwTcCGFBJUYDqoeCqsMxXy50TD2xdEuzgKrqIrDxX+vPbEvrxzc52bBJBjsUbvTCyz606miVQ8GvJN3zKx6LBD8d4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S0UUPPPx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB65DC4CECE;
	Thu, 12 Dec 2024 21:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734038554;
	bh=ek95GW+tU8Tylid/kx9coHa0RUVz9tmbmJ7ZUEm1zG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S0UUPPPxuerFCwua/KUSzhx+D6oaZUP0ZuwW6g36ytjW0P4CDc11mTB2PHIWtJCej
	 /r0aiWNS6j69M0FY4h27VyFslpa0+LPVWfcKlFGdm7J5bRXgirAWMXx821cdQL7KQR
	 rFMRwlToFNS3jk/6DEsq9O6NEJv0r6gmaKC89j4WEZE2BwnoHh7Y68zMGLntjhVYTu
	 agVUlFBqW9s5/AVlp4xzu1LFlbV+Jdp132+0U+ukro8BwN1gCap6YFuijRQBx0fS0G
	 qk9qZB1iFwEkyjf3o6cDMAus0fPuCeJdO/t4+lttcE6n99my3/svObn6xSz2VJW+/G
	 CRMuz7UsaB0pw==
Date: Thu, 12 Dec 2024 21:22:29 +0000
From: Simon Horman <horms@kernel.org>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v7 28/28] sfc: support pio mapping based on cxl
Message-ID: <20241212212229.GD2110@kernel.org>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
 <20241209185429.54054-29-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209185429.54054-29-alejandro.lucero-palau@amd.com>

On Mon, Dec 09, 2024 at 06:54:29PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> With a device supporting CXL and successfully initialised, use the cxl
> region to map the memory range and use this mapping for PIO buffers.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/net/ethernet/sfc/ef10.c       | 48 +++++++++++++++++++++++----
>  drivers/net/ethernet/sfc/efx_cxl.c    | 19 ++++++++++-
>  drivers/net/ethernet/sfc/net_driver.h |  2 ++
>  drivers/net/ethernet/sfc/nic.h        |  3 ++
>  4 files changed, 65 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
> index 452009ed7a43..4587ca884c03 100644
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

Hi Alejandro,

Earlier in efx_ef10_init_datapath_caps, outbuf is declared using:

	MCDI_DECLARE_BUF(outbuf, MC_CMD_GET_CAPABILITIES_V4_OUT_LEN);

This will result in the following declaration:

	efx_dword_t _name[DIV_ROUND_UP(MC_CMD_GET_CAPABILITIES_V4_OUT_LEN, 4)]

Where MC_CMD_GET_CAPABILITIES_V4_OUT_LEN is defined as 78.
So outbuf will be an array with DIV_ROUND_UP(78, 4) == 20 elements.

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

MC_CMD_GET_CAPABILITIES_V7_OUT_FLAGS3_OFST is defined as 148.
And the above will result in an access to element 148 / 4 == 37 of
outbuf. A buffer overflow.

Flagged by gcc-14 W=1 allmodconfig builds as:

In file included from drivers/net/ethernet/sfc/net_driver.h:33,
                 from drivers/net/ethernet/sfc/ef10.c:7:
drivers/net/ethernet/sfc/ef10.c: In function 'efx_ef10_init_datapath_caps':
drivers/net/ethernet/sfc/bitfield.h:167:35: warning: array subscript 37 is above array bounds of 'efx_dword_t[20]' {aka 'union efx_dword[20]'} [-Warray-bounds=]
  167 |         (EFX_EXTRACT32((dword).u32[0], 0, 31, low, high) &      \
drivers/net/ethernet/sfc/bitfield.h:129:11: note: in definition of macro 'EFX_EXTRACT_NATIVE'
  129 |          (native_element) << ((min) - (low)))
      |           ^~~~~~~~~~~~~~
./include/linux/byteorder/generic.h:89:21: note: in expansion of macro '__le32_to_cpu'
   89 | #define le32_to_cpu __le32_to_cpu
      |                     ^~~~~~~~~~~~~
drivers/net/ethernet/sfc/bitfield.h:167:10: note: in expansion of macro 'EFX_EXTRACT32'
  167 |         (EFX_EXTRACT32((dword).u32[0], 0, 31, low, high) &      \
      |          ^~~~~~~~~~~~~
drivers/net/ethernet/sfc/bitfield.h:187:9: note: in expansion of macro 'EFX_EXTRACT_DWORD'
  187 |         EFX_EXTRACT_DWORD(dword, EFX_LOW_BIT(field),            \
      |         ^~~~~~~~~~~~~~~~~
drivers/net/ethernet/sfc/mcdi.h:257:9: note: in expansion of macro 'EFX_DWORD_FIELD'
  257 |         EFX_DWORD_FIELD(*_MCDI_DWORD(_buf, _field), EFX_DWORD_0)
      |         ^~~~~~~~~~~~~~~
drivers/net/ethernet/sfc/ef10.c:184:44: note: in expansion of macro 'MCDI_DWORD'
  184 |                 nic_data->datapath_caps3 = MCDI_DWORD(outbuf,
      |                                            ^~~~~~~~~~
In file included from drivers/net/ethernet/sfc/ef10.c:12:
drivers/net/ethernet/sfc/ef10.c:110:26: note: while referencing 'outbuf'
  110 |         MCDI_DECLARE_BUF(outbuf, MC_CMD_GET_CAPABILITIES_V4_OUT_LEN);
      |                          ^~~~~~
drivers/net/ethernet/sfc/mcdi.h:187:21: note: in definition of macro '_MCDI_DECLARE_BUF'
  187 |         efx_dword_t _name[DIV_ROUND_UP(_len, 4)]
      |                     ^~~~~
drivers/net/ethernet/sfc/ef10.c:110:9: note: in expansion of macro 'MCDI_DECLARE_BUF'
  110 |         MCDI_DECLARE_BUF(outbuf, MC_CMD_GET_CAPABILITIES_V4_OUT_LEN);
      |         ^~~~~~~~~~~~~~~~

...

