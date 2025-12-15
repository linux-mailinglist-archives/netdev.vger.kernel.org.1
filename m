Return-Path: <netdev+bounces-244753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B86EFCBE228
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 14:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A7763002B84
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 13:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C02222F77B;
	Mon, 15 Dec 2025 13:50:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8C77080E;
	Mon, 15 Dec 2025 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765806655; cv=none; b=fIT01EHvgErA9Xkx5+CBVl+iZh5rO+Ce60hTRU6m+ucU1n7abkGxKCR8R22JNGiF7x9nFXaASP8i8d1aSqpuTYNJUbYl+nPn9RceR8i75900qyI7BVQ+H0SwWv1TfOKnC04BNlB9ZfJfuWWKsDjrbqR/yQEuVIOdGHHQxv9KT/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765806655; c=relaxed/simple;
	bh=4fY/HJsRqDZP2Lfc6RD+uMH0qvHerhCWkEveOjepnt8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NQFaHAd+bddgN3nL3NEaKP1uVUxoATGRR2sp7OpeMB6B1kNaZmyotS3q2A8JASSaTn+8CACjU4LbiAqxjWiaxt4YHkSJXjANQxeGneGCf4rSZ4biiHeF0kESdALSAq9swGq2qmNMDxSMAsHdCS/59TqxfESHp0zHebuPO8fCGrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dVLzm5nSxzHnGjn;
	Mon, 15 Dec 2025 21:50:28 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 2C50C40576;
	Mon, 15 Dec 2025 21:50:50 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 15 Dec
 2025 13:50:49 +0000
Date: Mon, 15 Dec 2025 13:50:47 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v22 11/25]  cxl/hdm: Add support for getting region from
 committed decoder
Message-ID: <20251215135047.000018f7@huawei.com>
In-Reply-To: <20251205115248.772945-12-alejandro.lucero-palau@amd.com>
References: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
	<20251205115248.772945-12-alejandro.lucero-palau@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 5 Dec 2025 11:52:34 +0000
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> A Type2 device configured by the BIOS can already have its HDM
> committed. Add a cxl_get_committed_decoder() function for cheking

checking if this is so after memdev creation.

> so after memdev creation. A CXL region should have been created
> during memdev initialization, therefore a Type2 driver can ask for
> such a region for working with the HPA. If the HDM is not committed,
> a Type2 driver will create the region after obtaining proper HPA
> and DPA space.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
Hi Alejandro,

I'm in two minds about this.  In general there are devices that have
been configured by the BIOS because they are already in use. I'm not sure
the driver you are working with here is necessarily set up to survive
that sort of live setup without interrupting data flows.

If it is fair enough to support this, otherwise my inclination is tear
down whatever the bios did and start again (unless locked - in which
case go grumble at your BIOS folk). Reasoning being that we then only
have to handle the equivalent of the hotplug flow in both cases rather
than having to handle 2.

There are also the TSP / encrypted link cases where we need to be careful.
I have no idea if that applies here.

So I'm not against this in general, just not sure there is an argument
for this approach 'yet'. If there is, give more breadcrumbs to it in this
commit message.  

A few comments inline.

> ---
>  drivers/cxl/core/hdm.c | 44 ++++++++++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h      |  3 +++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index d3a094ca01ad..fa99657440d1 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -92,6 +92,7 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>  {
>  	struct cxl_hdm *cxlhdm;
> +	struct cxl_port *port;
>  	void __iomem *hdm;
>  	u32 ctrl;
>  	int i;
> @@ -105,6 +106,10 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>  	if (!hdm)
>  		return true;
>  
> +	port = cxlhdm->port;
> +	if (is_cxl_endpoint(port))
> +		return false;

Why this change?  If it was valid before this patch as an early exit
then do it in a patch that justifies that not buried in here.

> +
>  	/*
>  	 * If HDM decoders are present and the driver is in control of
>  	 * Mem_Enable skip DVSEC based emulation
> @@ -686,6 +691,45 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>  	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>  }
>  
> +static int find_committed_decoder(struct device *dev, const void *data)

Function name rather suggests it finds committed decoders on 'whatever'
but it only works for the endpoint decoders.  Rename it to avoid this
confusion.

> +{
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_port *port;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	port = cxled_to_port(cxled);
> +
> +	return cxled->cxld.id == (port->hdm_end);

Drop the ()


> +}
> +
> +struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
> +						       struct cxl_region **cxlr)
> +{
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct device *cxled_dev;
> +
> +	if (!endpoint)
> +		return NULL;
> +
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +	cxled_dev = device_find_child(&endpoint->dev, NULL,
> +				      find_committed_decoder);
> +
> +	if (!cxled_dev)
> +		return NULL;
> +
> +	cxled = to_cxl_endpoint_decoder(cxled_dev);
> +	*cxlr = cxled->cxld.region;
> +
> +	put_device(cxled_dev);

Probably use a __free() for this.

> +	return cxled;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_committed_decoder, "CXL");
> +
>  static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>  {
>  	u16 eig;
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 043fc31c764e..2ff3c19c684c 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -250,4 +250,7 @@ int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
>  struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>  				       struct cxl_dev_state *cxlds,
>  				       const struct cxl_memdev_ops *ops);
> +struct cxl_region;
> +struct cxl_endpoint_decoder *cxl_get_committed_decoder(struct cxl_memdev *cxlmd,
> +						       struct cxl_region **cxlr);
>  #endif /* __CXL_CXL_H__ */


