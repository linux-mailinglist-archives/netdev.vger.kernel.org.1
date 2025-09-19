Return-Path: <netdev+bounces-224822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D11B8AD44
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 19:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 728EF7E0E52
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 17:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6132B31D371;
	Fri, 19 Sep 2025 17:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IBK0MRZG"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823E824677D;
	Fri, 19 Sep 2025 17:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758304426; cv=none; b=afWjUBsQI//WK7S3v2VcvgWGm6hCCjQ/9TgtEoQZ/o6Ktm2zGSWC6fVSk1pT1sOl2GFsxb38DqCAM3EwNcXUDftJG/TV313uQSDhKkTQKZQEqPSjL+fvFRKeV/SCwuVFK1jdwqf0COksS4m7IaNOn/1D0YmnRUf5E6oCAY+2UrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758304426; c=relaxed/simple;
	bh=OUZGsR/nW/uvMnmU4KgfXbnuSMYBK0R/M0EkaxR8So4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HouNQVFqjjJZL5JsBjnn7LLDgJ6T2k/jjGYERum5ZukumiuQdKtCpt+FuAykvMusfRIuSo08RtN3IKeh8yZp6ExUF9IxSVXe8Qe7e9jMlIYf09+bBKPMHxKyR+KCDyn70ZqWCM6dKBajPe4ytwhKdBb7gnZgLOOCc+zF0P8gy70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IBK0MRZG; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758304425; x=1789840425;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OUZGsR/nW/uvMnmU4KgfXbnuSMYBK0R/M0EkaxR8So4=;
  b=IBK0MRZGXFrIGwGp+hL6mTM2HR81Ae13dOkSuALRnGLpQXEUwG2TMe8J
   w0qzqzjnPfJOJg+qzpwOD8a1FwhUVuKiev/b/DVcUChHx50YzxYqJNDKq
   WFHL0u/4rVHQpAeYQWG9IHCSkYRmdvG9PjhWkqbPhds7gd2R+9Y2xeugS
   GHs9HYpKjdRPHETeY7DtFvXllfdAiulim0B3OP379jwvdIJrQUZvEW88N
   fdzNrwOLshVLx/kxxbbXqGDTLdOeAjVu6u8TEYHeGDvayhtJmNdJD/OO4
   ngigej6O4TQxkoPQGe4S6t6jtiRDOalQenoK8ueGrUKTiOMs0ZV5Rt4VL
   A==;
X-CSE-ConnectionGUID: iIbLVS61Rp+5T2G7dykn3Q==
X-CSE-MsgGUID: S0sOpEH4S1+FPXc9QddWew==
X-IronPort-AV: E=McAfee;i="6800,10657,11558"; a="60771055"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="60771055"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 10:53:44 -0700
X-CSE-ConnectionGUID: pVJyDmRCSyiJmHEoN/qGIA==
X-CSE-MsgGUID: Jhb8B9hhS4y9BiXWouH3qA==
X-ExtLoop1: 1
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.108.58]) ([10.125.108.58])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 10:53:42 -0700
Message-ID: <c3c29108-d8a8-459b-bcc1-d33f148f6dce@intel.com>
Date: Fri, 19 Sep 2025 10:53:41 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 08/20] cx/memdev: Indicate probe deferral
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-9-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250918091746.2034285-9-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/18/25 2:17 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> The first step for a CXL accelerator driver that wants to establish new
> CXL.mem regions is to register a 'struct cxl_memdev'. That kicks off
> cxl_mem_probe() to enumerate all 'struct cxl_port' instances in the
> topology up to the root.
> 
> If the port driver has not attached yet the expectation is that the
> driver waits until that link is established. The common cxl_pci driver
> has reason to keep the 'struct cxl_memdev' device attached to the bus
> until the root driver attaches. An accelerator may want to instead defer
> probing until CXL resources can be acquired.
> 
> Use the @endpoint attribute of a 'struct cxl_memdev' to convey when a
> accelerator driver probing should be deferred vs failed. Provide that
> indication via a new cxl_acquire_endpoint() API that can retrieve the
> probe status of the memdev.

So the -EPROBE_DEFER actually goes to the caller (accelerator driver) in this instance right? In the situation where the CXL resources never show up, does this particular accelerator driver never completes probe successfully or does it just punt CXL and completes probe without CXL support? This question is just for my understanding.

> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/memdev.c | 42 +++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/port.c   |  2 +-
>  drivers/cxl/mem.c         |  7 +++++--
>  include/cxl/cxl.h         |  2 ++
>  4 files changed, 50 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 3228287bf3f0..10d21996598a 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -1164,6 +1164,48 @@ struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_memdev_alloc, "CXL");
>  
> +/*
> + * Try to get a locked reference on a memdev's CXL port topology
> + * connection. Be careful to observe when cxl_mem_probe() has deposited
> + * a probe deferral awaiting the arrival of the CXL root driver.
> + */
> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_port *endpoint;
> +	int rc = -ENXIO;
> +
> +	device_lock(&cxlmd->dev);
> +
> +	endpoint = cxlmd->endpoint;
> +	if (!endpoint)
> +		goto err;
> +
> +	if (IS_ERR(endpoint)) {
> +		rc = PTR_ERR(endpoint);
> +		goto err;
> +	}
> +
> +	device_lock(&endpoint->dev);
> +	if (!endpoint->dev.driver)
> +		goto err_endpoint;
> +
> +	return endpoint;
> +
> +err_endpoint:
> +	device_unlock(&endpoint->dev);
> +err:
> +	device_unlock(&cxlmd->dev);
> +	return ERR_PTR(rc);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_acquire_endpoint, "CXL");
> +
> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
> +{
> +	device_unlock(&endpoint->dev);
> +	device_unlock(&cxlmd->dev);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_release_endpoint, "CXL");

We may want to annotate the locking to help out lockdep debug

static struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd)
        __acquires(&cxlmd->dev.mutex)
        __acquires(&cxlmd->endpoint->dev.mutex)
{
	...
}

static void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
        __releases(&endpoint->dev.mutex)
        __releases(&cxlmd->dev.mutex)
{
	...
}

DJ

> +
>  static void sanitize_teardown_notifier(void *data)
>  {
>  	struct cxl_memdev_state *mds = data;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 240c3c5bcdc8..4c3fecd4c8ea 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1557,7 +1557,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  		 */
>  		dev_dbg(&cxlmd->dev, "%s is a root dport\n",
>  			dev_name(dport_dev));
> -		return -ENXIO;
> +		return -EPROBE_DEFER;
>  	}
>  
>  	struct cxl_port *parent_port __free(put_cxl_port) =
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 9ffee09fcb50..f103e2003add 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -122,14 +122,17 @@ static int cxl_mem_probe(struct device *dev)
>  		return rc;
>  
>  	rc = devm_cxl_enumerate_ports(cxlmd);
> -	if (rc)
> +	if (rc) {
> +		cxlmd->endpoint = ERR_PTR(rc);
>  		return rc;
> +	}
>  
>  	struct cxl_port *parent_port __free(put_cxl_port) =
>  		cxl_mem_find_port(cxlmd, &dport);
>  	if (!parent_port) {
>  		dev_err(dev, "CXL port topology not found\n");
> -		return -ENXIO;
> +		cxlmd->endpoint = ERR_PTR(-EPROBE_DEFER);
> +		return -EPROBE_DEFER;
>  	}
>  
>  	if (cxl_pmem_size(cxlds) && IS_ENABLED(CONFIG_CXL_PMEM)) {
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 401a59185608..64946e698f5f 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -251,4 +251,6 @@ int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
>  struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>  				       struct cxl_dev_state *cxlds,
>  				       const struct cxl_memdev_ops *ops);
> +struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd);
> +void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
>  #endif /* __CXL_CXL_H__ */


