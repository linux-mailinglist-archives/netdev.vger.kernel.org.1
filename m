Return-Path: <netdev+bounces-149812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DD99E7942
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 20:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FCA7282E1E
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 19:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723601C548B;
	Fri,  6 Dec 2024 19:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNnnvtKc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C6C1C54B8;
	Fri,  6 Dec 2024 19:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733514539; cv=none; b=YzLg/gRNM7ynyicWMHuhTn/PTqnsm/FI1Z0BIGV2IqySGBXBgdKebJOLm93DLL+u/uSO6bH0/pcYKIMz4Hp9h6JmOUZ9Og2PgaVX6xxu7r7d7YT5ekMSmK+EXJKe9qL3y4TNU6PauL6O4O1eRfncyGJBom9oQMT0azSTvb1VngQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733514539; c=relaxed/simple;
	bh=KdcsAxQBFbM2/z0yQXBCP285CiLGtcrcFpltMwY9AJw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Re6Z5URFGn1kK0jjYHVJvKN2GsMHrkxn94SbXGzGRhLYa5rnk+EmjZxu9HB+SFja3ganJR5877iLMK1pT5Pc377a39xFcC2dzcowmh1XG7fvQP82kT0nP19zzva3z8CyhCvGNG6dwh1Kz0V37Ret4vlOcnXLyjMZslOmE1kMcLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNnnvtKc; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7fd377ff3c5so93315a12.0;
        Fri, 06 Dec 2024 11:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733514536; x=1734119336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N95xgdzx4xelKVeZx4+OsIwb+6ka2x0GHnFXGtq9epY=;
        b=TNnnvtKcGnfGbhk3OhyaRoCUqwf/agvpis5BD4mrGh4lZh/joZjdJ1lu+qL1vrkGax
         dp4RF+XaAYxpVquvX7HM+y7LaFfBWdx52EAIe1u5gFNM1Js2sYZxImT0Gm6XnyvnjMLM
         Fe5Gr9I/HSUoYOHUhGWXW1TrFH7NM3loGk2HjGuRqNW7E8GwNUiFPg1ZYHUoVEaR9kbF
         +EMl8tRGrz9SvzlXXXCXHysSG6B32mhS8WMOBjdlI9qbMxoOdD1ijhc28Bxw5NaKWdU2
         3P7mfOnYTBy5K1E+VQ58kw1VzzjcpHzI3rkR9XZpOmUPDJ+jXok+te31rxVtTz5+RXC4
         M/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733514536; x=1734119336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N95xgdzx4xelKVeZx4+OsIwb+6ka2x0GHnFXGtq9epY=;
        b=VUbqpiSWEMCIr1zcQS9af7UzqSUosNnRrYN307gy3KBC6vKazzyYOx4vJNgz/jzJvA
         iyuwf7qlEOPB73GRfIQJvonWMIilMoFIF040lNzJGzixPyIYEY9n/72CCUyy3Srr0VKR
         rFxshJRz/9bOHH2cIaxOjhf7H10vM0CX8IaWewtiI/J/5d3Phhz2HjHBLnNV+7QC2FMt
         yS5sCH88GC5L9jUpT7+4qpY3qJuMVdrmTWjhVvIq2Hm8N3XGXpR+HpQEHH+8b7eZkYWO
         uAw/xtiwQMRgqbZIxzP4fu4FigdO3AYBQzXfwkRtmPF5Nx6p0NcyhKXol3B4oWsw+pd/
         bzpg==
X-Forwarded-Encrypted: i=1; AJvYcCWywzYyLhKKbsksc4OQ1p8JulyXQ4xXBDHVFgR6pIkSC9k2IEyENKB9k9uaNGSVCucI3hA2G0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVXAWXjlNbSWn+iVJVrRgu4A3t78wIqx/b8LFA4v8zQummRtj/
	Y0TunyIyulRzLsHkOtnRaUSIwgfGub5rjXKGoFnrg/X4d2QtbVmX
X-Gm-Gg: ASbGncswh/wAfqzpZPyox1EfAC86KFjD8QjDqy5cIT0LV+r83tOwTMo1ZepWXOcsA80
	BU9s3Hh9olf8iRypXuqC++UOwlcgzE6Qlzr7wB0CiablEoWeoZqyK4DefJ/PKP1C8LjjQOEvTkq
	prVV0E23d8G9aVTGUj0lTmnxGkLD4I+YRcj0VdoQzfr+oa77YQxUI+nW5uWHlTzCORvP2NZYUDO
	GBZlwBTyLCezEIRnIwNBoBKFae1ADUsnp7UH0Bn
X-Google-Smtp-Source: AGHT+IFLnsewxwtrgLPpEbYXmf+L8u95F2zSFaIQ67ReQBqeeKCTzE13SroaJgAnGJKQEl8ISi4YHg==
X-Received: by 2002:a05:6a21:328f:b0:1e0:c99e:1f41 with SMTP id adf61e73a8af0-1e186c0e611mr7173830637.8.1733514536430;
        Fri, 06 Dec 2024 11:48:56 -0800 (PST)
Received: from mini ([2601:646:8f03:9fe0:713e:4b65:ca0:73a7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156bb52asm3026439a12.22.2024.12.06.11.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 11:48:55 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Fri, 6 Dec 2024 11:48:50 -0800
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, martin.habets@xilinx.com,
	edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v6 15/28] cxl: define a driver interface for HPA free
 space enumeration
Message-ID: <Z1NVInTC-fB9A7T8@mini>
References: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
 <20241202171222.62595-16-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202171222.62595-16-alejandro.lucero-palau@amd.com>

On Mon, Dec 02, 2024 at 05:12:09PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> CXL region creation involves allocating capacity from device DPA
> (device-physical-address space) and assigning it to decode a given HPA
> (host-physical-address space). Before determining how much DPA to
> allocate the amount of available HPA must be determined. Also, not all
> HPA is create equal, some specifically targets RAM, some target PMEM,
> some is prepared for device-memory flows like HDM-D and HDM-DB, and some
> is host-only (HDM-H).
> 
> Wrap all of those concerns into an API that retrieves a root decoder
> (platform CXL window) that fits the specified constraints and the
> capacity available for a new region.
> 
> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/region.c | 145 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |   3 +
>  include/cxl/cxl.h         |   8 +++
>  3 files changed, 156 insertions(+)
> 
...
> +	/*
> +	 * Walk the root decoder resource range relying on cxl_region_rwsem to
> +	 * preclude sibling arrival/departure and find the largest free space
> +	 * gap.
> +	 */
> +	lockdep_assert_held_read(&cxl_region_rwsem);
> +	max = 0;
> +	res = cxlrd->res->child;
> +	if (!res)
> +		max = resource_size(cxlrd->res);
> +	else
> +		max = 0;
> +
> +	for (prev = NULL; res; prev = res, res = res->sibling) {
> +		struct resource *next = res->sibling;
> +		resource_size_t free = 0;
> +
> +		if (!prev && res->start > cxlrd->res->start) {
> +			free = res->start - cxlrd->res->start;
> +			max = max(free, max);
> +		}
> +		if (prev && res->start > prev->end + 1) {
> +			free = res->start - prev->end + 1;
Should it be
    free = res->start - (prev->end + 1);
?
> +			max = max(free, max);
> +		}
> +		if (next && res->end + 1 < next->start) {
> +			free = next->start - res->end + 1;
free = next->start - (res->end + 1);

Fan
> +			max = max(free, max);
> +		}
> +		if (!next && res->end + 1 < cxlrd->res->end + 1) {
> +			free = cxlrd->res->end + 1 - res->end + 1;
> +			max = max(free, max);
> +		}
> +	}
> +
> +	dev_dbg(CXLRD_DEV(cxlrd), "%s, found %pa bytes of free space\n",
> +		__func__, &max);
> +	if (max > ctx->max_hpa) {
> +		if (ctx->cxlrd)
> +			put_device(CXLRD_DEV(ctx->cxlrd));
> +		get_device(CXLRD_DEV(cxlrd));
> +		ctx->cxlrd = cxlrd;
> +		ctx->max_hpa = max;
> +		dev_dbg(CXLRD_DEV(cxlrd), "%s, found %pa bytes of free space\n",
> +			__func__, &max);
> +	}
> +	return 0;
> +}
> +
> +/**
> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
> + * @endpoint: an endpoint that is mapped by the returned decoder
> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and HDM-H vs HDM-D[B]
> + * @max_avail_contig: output parameter of max contiguous bytes available in the
> + *		      returned decoder
> + *
> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available given
> + * in (@max_avail_contig))' is a point in time snapshot. If by the time the
> + * caller goes to use this root decoder's capacity the capacity is reduced then
> + * caller needs to loop and retry.
> + *
> + * The returned root decoder has an elevated reference count that needs to be
> + * put with put_device(cxlrd_dev(cxlrd)). Locking context is with
> + * cxl_{acquire,release}_endpoint(), that ensures removal of the root decoder
> + * does not race.
> + */
> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
> +					       unsigned long flags,
> +					       resource_size_t *max_avail_contig)
> +{
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxlrd_max_context ctx = {
> +		.host_bridge = endpoint->host_bridge,
> +		.flags = flags,
> +	};
> +	struct cxl_port *root_port;
> +	struct cxl_root *root __free(put_cxl_root) = find_cxl_root(endpoint);
> +
> +	if (!is_cxl_endpoint(endpoint)) {
> +		dev_dbg(&endpoint->dev, "hpa requestor is not an endpoint\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	if (!root) {
> +		dev_dbg(&endpoint->dev, "endpoint can not be related to a root port\n");
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	root_port = &root->port;
> +	down_read(&cxl_region_rwsem);
> +	device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
> +	up_read(&cxl_region_rwsem);
> +
> +	if (!ctx.cxlrd)
> +		return ERR_PTR(-ENOMEM);
> +
> +	*max_avail_contig = ctx.max_hpa;
> +	return ctx.cxlrd;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, CXL);
> +
>  static ssize_t size_store(struct device *dev, struct device_attribute *attr,
>  			  const char *buf, size_t len)
>  {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 22e787748d79..57d6dda3fb4a 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -785,6 +785,9 @@ static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
>  struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>  struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
> +
> +#define CXLRD_DEV(cxlrd) (&(cxlrd)->cxlsd.cxld.dev)
> +
>  struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
>  bool is_root_decoder(struct device *dev);
>  bool is_switch_decoder(struct device *dev);
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 26d7735b5f31..eacd5e5e6fe8 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -7,6 +7,10 @@
>  #include <linux/ioport.h>
>  #include <linux/pci.h>
>  
> +#define CXL_DECODER_F_RAM   BIT(0)
> +#define CXL_DECODER_F_PMEM  BIT(1)
> +#define CXL_DECODER_F_TYPE2 BIT(2)
> +
>  enum cxl_resource {
>  	CXL_RES_DPA,
>  	CXL_RES_RAM,
> @@ -47,4 +51,8 @@ int cxl_release_resource(struct cxl_dev_state *cxlds, enum cxl_resource type);
>  void cxl_set_media_ready(struct cxl_dev_state *cxlds);
>  struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>  				       struct cxl_dev_state *cxlds);
> +struct cxl_port;
> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
> +					       unsigned long flags,
> +					       resource_size_t *max);
>  #endif
> -- 
> 2.17.1
> 

