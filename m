Return-Path: <netdev+bounces-300546-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fqNqHeJ5NGqSZAYAu9opvQ
	(envelope-from <netdev+bounces-300546-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 01:06:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C21E16A3042
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 01:06:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=dPIB6Y34;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300546-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300546-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95A65303768E
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 23:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046FB32B11A;
	Thu, 18 Jun 2026 23:06:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2357C14ABE;
	Thu, 18 Jun 2026 23:06:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781823967; cv=none; b=hsWp5tHJqYpRoB+zkJjFOIgp4UnHfB9XDSsuABWLju2NSPsII3xv1udbw8NTZCN5+OC+eT8H7e0Kb6ZcYB7OlvZhKy0pSsPQav1v5Wvw3PcdycXUNk/sCdhWKSm2YeKmWz0bHtxerhpGrYEqtfR8CZK2Zkdi/cLVBvGYPVo+Czc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781823967; c=relaxed/simple;
	bh=ceOG19KH09VbVnPscVIEKnsb4MQDdbBPUaNkmq+MB9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LeDsosLN+uXztFvR/ilngwWngWI9fc2G7wBUyXlVUg2HutO+DDtXYajPeZOXYLLg30PkaUOojxq7VxUgSjIGiFdib8rVQedxu4JGPdimKeRHebrI/sn9bWEFcEkBapOMK+vdF5g0Z8C+BvaKAYQ9Mb3qWPa6KDBWtGZxkMsPpyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dPIB6Y34; arc=none smtp.client-ip=192.198.163.8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781823966; x=1813359966;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ceOG19KH09VbVnPscVIEKnsb4MQDdbBPUaNkmq+MB9Q=;
  b=dPIB6Y34u/Hi2T5ROmsumvtClzIkywoouQxcFc79+MNqpe/hWpIPbuWY
   tscHYdihnpyHJuPUSg0qQjRLoSORJrIX1stjrhNq3dmZ+ance9wux5rnk
   BknVgKvfoKgu8h2G0/CI28hM9c9Qre3CMfLQKNBHevWkTtk4BC6i77102
   DkGuYELOwjgMNu4nLqNOiF0zl9l9qaU9ZFPFBTLaHyfEwVEt56Qvg2Ko7
   9fFB/52TA8w4tP928uFnFRFI1zIO3gG0bcsmsLrweYWN+WdqmKh2Fl/ey
   /f+j4RFV4L2TQTvIOofMbu25i9cOaa1rwyjFnGdtrYyjkkgclrw8NsWC9
   w==;
X-CSE-ConnectionGUID: GXRt8opeQj+fj3yaEVnVQw==
X-CSE-MsgGUID: kP187qq8ShusvuyaT/XQAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="100229749"
X-IronPort-AV: E=Sophos;i="6.24,212,1774335600"; 
   d="scan'208";a="100229749"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 16:06:05 -0700
X-CSE-ConnectionGUID: qiR2BeqMQc6R8HtEyPyFzQ==
X-CSE-MsgGUID: fmLel/joRgC6etie3HsG+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,212,1774335600"; 
   d="scan'208";a="253476432"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO [10.125.111.229]) ([10.125.111.229])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 16:06:04 -0700
Message-ID: <5a0053d4-e46a-4cfa-a355-fb733d484029@intel.com>
Date: Thu, 18 Jun 2026 16:06:04 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v28 5/5] sfc: support pio mapping based on cxl
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, djbw@kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20260618181806.118745-1-alejandro.lucero-palau@amd.com>
 <20260618181806.118745-6-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260618181806.118745-6-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300546-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alejandro.lucero-palau@amd.com,m:linux-cxl@vger.kernel.org,m:netdev@vger.kernel.org,m:djbw@kernel.org,m:edward.cree@amd.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:alucerop@amd.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dave.jiang@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C21E16A3042



On 6/18/26 11:18 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> A PIO buffer is a region of device memory to which the driver can write a
> packet for TX, with the device handling the transmit doorbell without
> requiring a DMA for getting the packet data, which helps reducing latency
> in certain exchanges. With CXL mem protocol this latency can be lowered
> further.
> 
> With a device supporting CXL and successfully initialised, use the cxl
> region to map the memory range and use this mapping for PIO buffers.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  drivers/net/ethernet/sfc/ef10.c       | 41 ++++++++++++++++++++++-----
>  drivers/net/ethernet/sfc/efx.h        |  1 -
>  drivers/net/ethernet/sfc/efx_cxl.c    |  1 +
>  drivers/net/ethernet/sfc/net_driver.h |  1 +
>  drivers/net/ethernet/sfc/nic.h        |  3 ++
>  5 files changed, 39 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
> index 7e04f115bbaa..73bc064929f6 100644
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
> @@ -106,7 +107,7 @@ static int efx_ef10_get_vf_index(struct efx_nic *efx)
>  
>  static int efx_ef10_init_datapath_caps(struct efx_nic *efx)
>  {
> -	MCDI_DECLARE_BUF(outbuf, MC_CMD_GET_CAPABILITIES_V4_OUT_LEN);
> +	MCDI_DECLARE_BUF(outbuf, MC_CMD_GET_CAPABILITIES_V7_OUT_LEN);
>  	struct efx_ef10_nic_data *nic_data = efx->nic_data;
>  	size_t outlen;
>  	int rc;
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
> @@ -1140,6 +1147,9 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
>  	unsigned int channel_vis, pio_write_vi_base, max_vis;
>  	struct efx_ef10_nic_data *nic_data = efx->nic_data;
>  	unsigned int uc_mem_map_size, wc_mem_map_size;
> +#ifdef CONFIG_SFC_CXL
> +	struct efx_probe_data *probe_data;
> +#endif
>  	void __iomem *membase;
>  	int rc;
>  
> @@ -1263,8 +1273,23 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
>  	iounmap(efx->membase);
>  	efx->membase = membase;
>  
> -	/* Set up the WC mapping if needed */
> -	if (wc_mem_map_size) {
> +	if (!wc_mem_map_size)
> +		goto skip_pio;
> +
> +	/* Set up the WC mapping */
> +
> +#ifdef CONFIG_SFC_CXL
> +	probe_data = container_of(efx, struct efx_probe_data, efx);
> +	if ((nic_data->datapath_caps3 &
> +	    (1 << MC_CMD_GET_CAPABILITIES_V7_OUT_CXL_CONFIG_ENABLE_LBN)) &&
> +	    probe_data->cxl_pio_initialised) {
> +		/* Using PIO through CXL mapping */
> +		nic_data->pio_write_base = probe_data->cxl->ctpio_cxl;
> +		nic_data->pio_write_vi_base = pio_write_vi_base;
> +	} else
> +#endif
> +	{
> +		/* Using legacy PIO BAR mapping */
>  		nic_data->wc_membase = ioremap_wc(efx->membase_phys +
>  						  uc_mem_map_size,
>  						  wc_mem_map_size);
> @@ -1279,12 +1304,14 @@ static int efx_ef10_dimension_resources(struct efx_nic *efx)
>  			nic_data->wc_membase +
>  			(pio_write_vi_base * efx->vi_stride + ER_DZ_TX_PIOBUF -
>  			 uc_mem_map_size);
> -
> -		rc = efx_ef10_link_piobufs(efx);
> -		if (rc)
> -			efx_ef10_free_piobufs(efx);
>  	}
>  
> +	rc = efx_ef10_link_piobufs(efx);
> +	if (rc)
> +		efx_ef10_free_piobufs(efx);
> +
> +skip_pio:
> +
>  	netif_dbg(efx, probe, efx->net_dev,
>  		  "memory BAR at %pa (virtual %p+%x UC, %p+%x WC)\n",
>  		  &efx->membase_phys, efx->membase, uc_mem_map_size,
> diff --git a/drivers/net/ethernet/sfc/efx.h b/drivers/net/ethernet/sfc/efx.h
> index 45e191686625..057d30090894 100644
> --- a/drivers/net/ethernet/sfc/efx.h
> +++ b/drivers/net/ethernet/sfc/efx.h
> @@ -236,5 +236,4 @@ static inline bool efx_rwsem_assert_write_locked(struct rw_semaphore *sem)
>  
>  int efx_xdp_tx_buffers(struct efx_nic *efx, int n, struct xdp_frame **xdpfs,
>  		       bool flush);
> -
>  #endif /* EFX_EFX_H */
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 3e7c950f83e9..348d7404cd7a 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -88,6 +88,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		return -ENOMEM;
>  	}
>  
> +	probe_data->cxl_pio_initialised = true;
>  	probe_data->cxl = cxl;
>  
>  	return 0;
> diff --git a/drivers/net/ethernet/sfc/net_driver.h b/drivers/net/ethernet/sfc/net_driver.h
> index de3fc9537662..3964b2c56609 100644
> --- a/drivers/net/ethernet/sfc/net_driver.h
> +++ b/drivers/net/ethernet/sfc/net_driver.h
> @@ -1213,6 +1213,7 @@ struct efx_probe_data {
>  	struct efx_nic efx;
>  #ifdef CONFIG_SFC_CXL
>  	struct efx_cxl *cxl;
> +	bool cxl_pio_initialised;
>  #endif
>  };
>  
> diff --git a/drivers/net/ethernet/sfc/nic.h b/drivers/net/ethernet/sfc/nic.h
> index ec3b2df43b68..7480f9995dfb 100644
> --- a/drivers/net/ethernet/sfc/nic.h
> +++ b/drivers/net/ethernet/sfc/nic.h
> @@ -152,6 +152,8 @@ enum {
>   *	%MC_CMD_GET_CAPABILITIES response)
>   * @datapath_caps2: Further Capabilities of datapath firmware (FLAGS2 field of
>   * %MC_CMD_GET_CAPABILITIES response)
> + * @datapath_caps3: Further Capabilities of datapath firmware (FLAGS3 field of
> + * %MC_CMD_GET_CAPABILITIES response)
>   * @rx_dpcpu_fw_id: Firmware ID of the RxDPCPU
>   * @tx_dpcpu_fw_id: Firmware ID of the TxDPCPU
>   * @must_probe_vswitching: Flag: vswitching has yet to be setup after MC reboot
> @@ -187,6 +189,7 @@ struct efx_ef10_nic_data {
>  	bool must_check_datapath_caps;
>  	u32 datapath_caps;
>  	u32 datapath_caps2;
> +	u32 datapath_caps3;
>  	unsigned int rx_dpcpu_fw_id;
>  	unsigned int tx_dpcpu_fw_id;
>  	bool must_probe_vswitching;


