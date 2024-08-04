Return-Path: <netdev+bounces-115561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5A3947007
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 19:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FFEB1C209FA
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 17:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E30762EB;
	Sun,  4 Aug 2024 17:25:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CA1A95B;
	Sun,  4 Aug 2024 17:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722792325; cv=none; b=NpCZuWY3YpD4udgynRTyFi8+7LhyzjrN7LC4j68Y4QUT+ylVuIpDFIKAChvEqYF/c691/sk21XKq4bUow9p04r1vQtllS9bCcVSVq6IRdr/lwhsd97INXOcEQPtOVMfQHhBMjHPmrhG0gcaSrHLpn4K9ZYtt8xmf8qyBFI27qBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722792325; c=relaxed/simple;
	bh=rctv6ide3X7P7Mo0bNKgPnznHFcdsQgERCNfwR1/IPU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PJanvchshrimofODXxyh1k+Fq9nCDt8Nb64ej+Pqe4+DRTPfpcV1M5VTze+1uajv8ejfFzYm8N9wsnIJ3IYBChnoYcaJ6Pe4ccb96V/4ACI/0vorsMkaRHXwQH14bDAaL2wcgf5fFI5F6bAQaF3UAIWrlecSnin06f8+ULX4xwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WcRGR6rt9z6K8pm;
	Mon,  5 Aug 2024 01:22:39 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 91AE6140B3C;
	Mon,  5 Aug 2024 01:25:20 +0800 (CST)
Received: from localhost (10.195.244.131) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sun, 4 Aug
 2024 18:25:20 +0100
Date: Sun, 4 Aug 2024 18:25:19 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v2 05/15] cxl: fix use of resource_contains
Message-ID: <20240804182519.00006ea8@Huawei.com>
In-Reply-To: <20240715172835.24757-6-alejandro.lucero-palau@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
	<20240715172835.24757-6-alejandro.lucero-palau@amd.com>
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

On Mon, 15 Jul 2024 18:28:25 +0100
<alejandro.lucero-palau@amd.com> wrote:

> From: Alejandro Lucero <alucerop@amd.com>
> 
> For a resource defined with size zero, resource contains will also
> return true.
> 
> Add resource size check before using it.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
If this can happen in existing type 3 case the fixes tag
and send it separately from this series.

If there is no path due to some external code, then
drop the word fix from the title and call it

cxl: harden resource_contains checks to handle zero size resources

Avoids it getting backported into stable / distros picking it
up if there isn't a real issue before this series.

Thanks,

Jonathan

> ---
>  drivers/cxl/core/hdm.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 3df10517a327..4af9225d4b59 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -327,10 +327,13 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  	cxled->dpa_res = res;
>  	cxled->skip = skipped;
>  
> -	if (resource_contains(&cxlds->pmem_res, res))
> +	if ((resource_size(&cxlds->pmem_res)) && (resource_contains(&cxlds->pmem_res, res))) {
> +		printk("%s: resource_contains CXL_DECODER_PMEM\n", __func__);
>  		cxled->mode = CXL_DECODER_PMEM;
> -	else if (resource_contains(&cxlds->ram_res, res))
> +	} else if ((resource_size(&cxlds->ram_res)) && (resource_contains(&cxlds->ram_res, res))) {
> +		printk("%s: resource_contains CXL_DECODER_RAM\n", __func__);
>  		cxled->mode = CXL_DECODER_RAM;
> +	}
>  	else {
>  		dev_warn(dev, "decoder%d.%d: %pr mixed mode not supported\n",
>  			 port->id, cxled->cxld.id, cxled->dpa_res);


