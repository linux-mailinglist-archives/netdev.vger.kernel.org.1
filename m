Return-Path: <netdev+bounces-115559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3874947003
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 19:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F771F21333
	for <lists+netdev@lfdr.de>; Sun,  4 Aug 2024 17:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DC76026A;
	Sun,  4 Aug 2024 17:17:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FC436AE0;
	Sun,  4 Aug 2024 17:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722791820; cv=none; b=JhgTWxBoWJZXfAVmZFm02xbHgaM1QzHf/L3yH1ANmS/WzpRWJzPb5KzRvT3+0A0z/6AhWRgXI65+Zll0FqZ/oq6GYZ1j4bSqE4S8LDUISDkB0D32ChzUvdHhJ5vgCRSJPahf0IFDLdCr2NCDI1Gh6Ajcmrp+7a/G8uFzwzYVYhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722791820; c=relaxed/simple;
	bh=b7lXmm5K236DM9x0wcqewiz6y+a9ERMFkPhFY3AJacQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZRPggzc2ZOWAW4rmr97XviN80CsQxTJjqxFinapflek7q3rNKL+MHHq8JSqk6vFDnlem8ioo76krDgLALByt3QGqJmuhND3OuVGH1P50hMe2ncCJOQ9BHtlmnWunvjbtNirJllbqEei+6NqUUPeCh57cw8mcD163sihcKoHtPMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WcR4g0RH3z67fDN;
	Mon,  5 Aug 2024 01:14:11 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E70071400C9;
	Mon,  5 Aug 2024 01:16:55 +0800 (CST)
Received: from localhost (10.195.244.131) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sun, 4 Aug
 2024 18:16:55 +0100
Date: Sun, 4 Aug 2024 18:16:54 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<richard.hughes@amd.com>, "Alejandro Lucero" <alucerop@amd.com>
Subject: Re: [PATCH v2 03/15] cxl: add function for type2 resource request
Message-ID: <20240804181654.00007279@Huawei.com>
In-Reply-To: <abff9def-a878-47e9-b9c8-27cf3c008c29@intel.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
	<20240715172835.24757-4-alejandro.lucero-palau@amd.com>
	<abff9def-a878-47e9-b9c8-27cf3c008c29@intel.com>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 18 Jul 2024 16:36:00 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> On 7/15/24 10:28 AM, alejandro.lucero-palau@amd.com wrote:
> > From: Alejandro Lucero <alucerop@amd.com>
> > 
> > Create a new function for a type2 device requesting a resource
> > passing the opaque struct to work with.
> > 
> > Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> > ---
> >  drivers/cxl/core/memdev.c          | 13 +++++++++++++
> >  drivers/net/ethernet/sfc/efx_cxl.c |  7 ++++++-
> >  include/linux/cxl_accel_mem.h      |  1 +
> >  3 files changed, 20 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index 61b5d35b49e7..04c3a0f8bc2e 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -744,6 +744,19 @@ void cxl_accel_set_resource(struct cxl_dev_state *cxlds, struct resource res,
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_accel_set_resource, CXL);
> >  
> > +int cxl_accel_request_resource(struct cxl_dev_state *cxlds, bool is_ram)  
> Maybe declare a common enum like cxl_resource_type instead of 'enum accel_resource' and use here instead of bool?
> 
> > +{
> > +	int rc;
> > +
> > +	if (is_ram)
> > +		rc = request_resource(&cxlds->dpa_res, &cxlds->ram_res);
> > +	else
> > +		rc = request_resource(&cxlds->dpa_res, &cxlds->pmem_res);
> > +
> > +	return rc;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_accel_request_resource, CXL);
> > +
> >  static int cxl_memdev_release_file(struct inode *inode, struct file *file)
> >  {
> >  	struct cxl_memdev *cxlmd =
> > diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> > index 10c4fb915278..9cefcaf3caca 100644
> > --- a/drivers/net/ethernet/sfc/efx_cxl.c
> > +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> > @@ -48,8 +48,13 @@ void efx_cxl_init(struct efx_nic *efx)
> >  	res = DEFINE_RES_MEM_NAMED(0, EFX_CTPIO_BUFFER_SIZE, "ram");
> >  	cxl_accel_set_resource(cxl->cxlds, res, CXL_ACCEL_RES_RAM);
> >  
> > -	if (cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds))
> > +	if (cxl_pci_accel_setup_regs(pci_dev, cxl->cxlds)) {
> >  		pci_info(pci_dev, "CXL accel setup regs failed");
> > +		return;
> > +	}
> > +
> > +	if (cxl_accel_request_resource(cxl->cxlds, true))
> > +		pci_info(pci_dev, "CXL accel resource request failed");  
> 
> pci_warn()? also emitting the errno would be nice. 
Don't hide it at all.  Fail if this doesn't succeed and let the caller
know. Not to mention, tear down any other state already set up.
 
> >  }
> >  
> >  
> > diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
> > index ca7af4a9cefc..c7b254edc096 100644
> > --- a/include/linux/cxl_accel_mem.h
> > +++ b/include/linux/cxl_accel_mem.h
> > @@ -20,4 +20,5 @@ void cxl_accel_set_serial(cxl_accel_state *cxlds, u64 serial);
> >  void cxl_accel_set_resource(struct cxl_dev_state *cxlds, struct resource res,
> >  			    enum accel_resource);
> >  int cxl_pci_accel_setup_regs(struct pci_dev *pdev, struct cxl_dev_state *cxlds);
> > +int cxl_accel_request_resource(struct cxl_dev_state *cxlds, bool is_ram);
> >  #endif  
> 


