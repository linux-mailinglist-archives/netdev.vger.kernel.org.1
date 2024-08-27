Return-Path: <netdev+bounces-122405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C444F96118D
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 17:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78A05280D00
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3D21C6F55;
	Tue, 27 Aug 2024 15:20:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3353A1CFBC;
	Tue, 27 Aug 2024 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772039; cv=none; b=P43ZN8PmBMubijIpBRVC1SsfQASHS4v6zBYBpSO7PQCbThWtOmVzHM/T1OcD4IyjOV1C+O8tyhWkdM3xA77lpp5zQff7/LTjomRiwT0ngLPn5NW9mNjidPh02fkrYq6Ivmeu+pR9dEubUvTn630FtXmgBqCX98Hq2XfCGDdPfcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772039; c=relaxed/simple;
	bh=OEClyW8tzUSHpxtCUWDullJ+70jg1UBt0vKBjD8Slqc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qSmW5deqNXkRAHQcOyqpcbXgGET8wsQFYJ/4LbwM4BNeqBAxaxfAE40x2MR/DLjpAAAUtvlhdPlsvOCQRUUvpdpdnZXuUIbqHqE6ZVGKUmTrzsuhtxLUuO7dSGgvY8Y5PxGWw3UpehBTx66dIw211AdV/5CyB+RiogtKVJB6vs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WtWNP04Lbz6J6gc;
	Tue, 27 Aug 2024 23:16:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 7D9B1140A87;
	Tue, 27 Aug 2024 23:20:35 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 16:20:34 +0100
Date: Tue, 27 Aug 2024 16:20:34 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: Zhi Wang <zhiw@nvidia.com>, <alejandro.lucero-palau@amd.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>,
	<targupta@nvidia.com>, <zhiwang@kernel.org>
Subject: Re: [PATCH v2 12/15] cxl: allow region creation by type2 drivers
Message-ID: <20240827162034.00005ef0@Huawei.com>
In-Reply-To: <17e5cf38-39f2-4136-fe2e-6936d8f45633@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
	<20240715172835.24757-13-alejandro.lucero-palau@amd.com>
	<20240822161226.00001736.zhiw@nvidia.com>
	<17e5cf38-39f2-4136-fe2e-6936d8f45633@amd.com>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 23 Aug 2024 10:31:20 +0100
Alejandro Lucero Palau <alucerop@amd.com> wrote:

> On 8/22/24 14:12, Zhi Wang wrote:
> > On Mon, 15 Jul 2024 18:28:32 +0100
> > <alejandro.lucero-palau@amd.com> wrote:
> >  
> >> From: Alejandro Lucero <alucerop@amd.com>
> >>
> >> Creating a CXL region requires userspace intervention through the cxl
> >> sysfs files. Type2 support should allow accelerator drivers to create
> >> such cxl region from kernel code.
> >>
> >> Adding that functionality and integrating it with current support for
> >> memory expanders.
> >>
> >> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c
> >> b/drivers/net/ethernet/sfc/efx_cxl.c index b5626d724b52..4012e3faa298
> >> 100644 --- a/drivers/net/ethernet/sfc/efx_cxl.c
> >> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> >> @@ -92,8 +92,18 @@ void efx_cxl_init(struct efx_nic *efx)
> >>   
> >>   	cxl->cxled = cxl_request_dpa(cxl->endpoint, true,
> >> EFX_CTPIO_BUFFER_SIZE, EFX_CTPIO_BUFFER_SIZE);
> >> -	if (IS_ERR(cxl->cxled))
> >> +	if (IS_ERR(cxl->cxled)) {
> >>   		pci_info(pci_dev, "CXL accel request DPA failed");
> >> +		return;
> >> +	}
> >> +
> >> +	cxl->efx_region = cxl_create_region(cxl->cxlrd, &cxl->cxled,
> >> 1);
> >> +	if (!cxl->efx_region) {  
> > if (IS_ERR(cxl->efx_region))
> >  
> 
> I'll fix it.
> 
> Thanks
Please crop replies. It's really easy to miss the important stuff
otherwise!

Jonathan



