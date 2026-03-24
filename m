Return-Path: <netdev+bounces-271201-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGPoCg7MwmkBmQQAu9opvQ
	(envelope-from <netdev+bounces-271201-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:38:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC4531A274
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 767A3300D620
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1670F3F8815;
	Tue, 24 Mar 2026 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G392Eml7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8223A1691;
	Tue, 24 Mar 2026 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774373898; cv=none; b=TapcCZLwN4K7bo05rykcOvsNFnyrvcxlY7BtG4TYw+RR/uHZret9JdgG0jPdRNztcM6uZ4tY0Qt47JXkgzmnSV3J1aDEVLPNm5IgRK5h0a6Sa2J4XeRkUQZIXXbPqLHMw+gKQ/EKUesQ/nJTUeCSJPCxFiEz2Tr/HBhGZiXfnp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774373898; c=relaxed/simple;
	bh=2P+UmFGVOVvOgdhAjhri3JMxsldiOWBJAj1Bv9GFu0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Br9+7aIpfSFrK9KV9nF1xGOci29TpbA0b6Ke7zSXkAQ9pz3h2Wh7YIqzM/pJAcLp6dx5pg9+tbs4XleAymYRxhletDu+KBpEHTGVuwWKYxCXHoEiVVWvHwCBKWAawOnL5rkBUpNjd4Ky/Ser2lcdybZsHvF9d3M7AgIGywQnozU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G392Eml7; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774373897; x=1805909897;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2P+UmFGVOVvOgdhAjhri3JMxsldiOWBJAj1Bv9GFu0Y=;
  b=G392Eml7sWXSXWc4X03C/U0HTdtwCx2KKxHE1qVQtXQ0GkRQdNxoqVeQ
   DsjIeBt3CPlsMNnS7va0lUSX8Rn3R59nWd9u5rWTmEFiMjhReeGgjBESt
   rPZK/nZ/8cQ5bqGQtuM0a+LPS2hrXR1qA9JxBWFEviZ1EfG/rzuDLyjE1
   AY7ei2eFYJ9MR/jnoMVbo5Sk7H1QB2JNq55ldGEXjhYFkhhQHid+gdbN3
   qW62ngP6Cp1wFBe6b7C/Sy7OKnt3BH8ohC4u1Nw3o2iIlDyr0/ARUPdvt
   0encu0G66NQ+0hbz0ZkqkywUAvx6qlRb2iiG2rSu7a80EOvyFii+iVvoi
   Q==;
X-CSE-ConnectionGUID: +2lGm4TIT9awfho2VE8KuA==
X-CSE-MsgGUID: iAngMTADQwyWf+BGAJXJ4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75283267"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75283267"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 10:38:17 -0700
X-CSE-ConnectionGUID: Zaig7Vu9Sxes3oEm5XmVSw==
X-CSE-MsgGUID: sj6LwwVOQDWXpzPePc90Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="247482158"
Received: from jdoman-mobl3.amr.corp.intel.com (HELO [10.125.110.6]) ([10.125.110.6])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 10:38:15 -0700
Message-ID: <9154b54f-32f9-4963-b25c-be30c4ceb8be@intel.com>
Date: Tue, 24 Mar 2026 10:38:14 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 09/11] sfc: obtain decoder and region if committed by
 firmware
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>, Edward Cree <ecree.xilinx@gmail.com>
References: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
 <20260323113117.2352709-10-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260323113117.2352709-10-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-271201-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dave.jiang@intel.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid,amd.com:email]
X-Rspamd-Queue-Id: 7EC4531A274
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/23/26 4:31 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Check if device HDM is already committed during firmware/BIOS
> initialization.
> 
> A CXL region should exist if so after memdev allocation/initialization.
> Get HPA from region and map it.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> ---
>  drivers/net/ethernet/sfc/efx_cxl.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 22a7d1d95425..78f926300943 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -19,6 +19,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	struct efx_nic *efx = &probe_data->efx;
>  	struct pci_dev *pci_dev = efx->pci_dev;
>  	struct efx_cxl *cxl;
> +	struct range range;
>  	u16 dvsec;
>  	int rc;
>  
> @@ -82,6 +83,24 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		return PTR_ERR(cxl->cxlmd);
>  	}
>  
> +	cxl->cxled = cxl_get_committed_decoder(cxl->cxlmd, &cxl->efx_region);
> +	if (!cxl->cxled || !cxl->efx_region)
> +		return -ENODEV;
> +
> +	rc = cxl_get_region_range(cxl->efx_region, &range);
> +	if (rc) {
> +		pci_err(pci_dev,
> +			"CXL getting regions params from a committed decoder failed");
> +		return rc;
> +	}
> +
> +	cxl->ctpio_cxl = ioremap(range.start, range_len(&range));
> +	if (!cxl->ctpio_cxl) {
> +		pci_err(pci_dev, "CXL ioremap region (%pra) failed", &range);
> +		return -ENOMEM;
> +	}
> +
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;
> @@ -89,6 +108,11 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  
>  void efx_cxl_exit(struct efx_probe_data *probe_data)
>  {
> +	if (!probe_data->cxl)
> +		return;
> +
> +	iounmap(probe_data->cxl->ctpio_cxl);
> +	cxl_unregister_region(probe_data->cxl->efx_region);

Would a device_put() on the region dev be sufficient here? Not sure if everything should be torn down if SFC didn't create the region to begin with and only retrieved it via cxl_get_commited_decoder()?

DJ

>  }
>  
>  MODULE_IMPORT_NS("CXL");


