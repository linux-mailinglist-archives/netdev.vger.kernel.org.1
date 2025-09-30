Return-Path: <netdev+bounces-227375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A19BCBAD48E
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 16:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D5C7177B6F
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 14:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6945E2264AB;
	Tue, 30 Sep 2025 14:51:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CFF303CB7;
	Tue, 30 Sep 2025 14:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759243873; cv=none; b=XQUhQAZQbdO6V35XkA500ylPQ8Md4oMR9Qm3/fJZMBmUGm/XjiyWWzP23uUUFeG/80bc/ET8lqXHS0C5xuB0JdZl0NADQ86IOnRB1vfg0B/3WWLGSGlrFW7k+rvNIgFCdmFrTCq0aNlWSXp1WCe9Vb2XxkL37jZMkHkNIKYd6Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759243873; c=relaxed/simple;
	bh=x2kQmEmlvu1QcOpR7fef9c1vKRVV+9sgNhD0vk7sTK0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cwa/R4voz/qxDdd5DWWk4TwmeIynKBQn/Z/ai1+ut9geHcv9vVrwS5+RmNP7vDsyMmAw7s0NXkYyAugGYT5u3LQUdPHNRx6G6XblLC4syQstCheYNkYHF9DaQUkuBySiCxCTnppV7hSHqvi0+mKGBzkd0lowerdziOrVNAYG/4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cbgsF3Mxkz6M4YG;
	Tue, 30 Sep 2025 22:48:01 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 7289E140276;
	Tue, 30 Sep 2025 22:51:08 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 30 Sep
 2025 15:51:07 +0100
Date: Tue, 30 Sep 2025 15:51:05 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
Subject: Re: [PATCH v18 20/20] sfc: support pio mapping based on cxl
Message-ID: <20250930155105.00001463@huawei.com>
In-Reply-To: <26134b86-1481-451f-9337-70769ec9e792@amd.com>
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
	<20250918091746.2034285-21-alejandro.lucero-palau@amd.com>
	<20250918160832.00001ed7@huawei.com>
	<26134b86-1481-451f-9337-70769ec9e792@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 26 Sep 2025 10:47:27 +0100
Alejandro Lucero Palau <alucerop@amd.com> wrote:

> On 9/18/25 16:08, Jonathan Cameron wrote:
> > A few trivial things inline.
> >  
> >> diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
> >> index 47349c148c0c..7bc854e2d22a 100644
> >> --- a/drivers/net/ethernet/sfc/ef10.c
> >> +++ b/drivers/net/ethernet/sfc/ef10.c
> >> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> >> index 85490afc7930..3dde59003cd9 100644
> >> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> >> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> >> @@ -11,16 +11,23 @@
> >>   
> >>   #include "net_driver.h"
> >>   #include "efx_cxl.h"
> >> +#include "efx.h"
> >>   
> >>   #define EFX_CTPIO_BUFFER_SIZE	SZ_256M
> >>   
> >>   static void efx_release_cxl_region(void *priv_cxl)
> >>   {
> >>   	struct efx_probe_data *probe_data = priv_cxl;
> >> +	struct efx_nic *efx = &probe_data->efx;
> >>   	struct efx_cxl *cxl = probe_data->cxl;
> >>   
> >> +	/* Next avoid contention with efx_cxl_exit() */
> >>   	probe_data->cxl_pio_initialised = false;
> >> +
> >> +	/* Next makes cxl-based piobus to no be used */
> >> +	efx_ef10_disable_piobufs(efx);
> >>   	iounmap(cxl->ctpio_cxl);
> >> +  
> > Avoid extra white space changes. Perhaps push to earlier patch.  
> 
> 
> I'll fix the spaces. Not sure what you mean with the second part of your 
> comment, but if I understand it right, I think those changes should be 
> added in this patch, just when the final functionality is added.

Just the white space.  If you want that move it to where that iounmap() is
added.  This is just a patch cleanliness thing.

> 
> 
> FWIW, I have decided to drop this driver callback as Dan did not like 
> it, and after realizing those Dan's patches this patchset relies on fix 
> most of the problem this callback tried to address.
> 
> 
> >>   	cxl_put_root_decoder(cxl->cxlrd);
> >>   }
> >>   
> >> @@ -30,6 +37,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
> >>   	struct pci_dev *pci_dev = efx->pci_dev;
> >>   	resource_size_t max_size;
> >>   	struct efx_cxl *cxl;
> >> +	struct range range;
> >>   	u16 dvsec;
> >>   	int rc;
> >>   
> >> @@ -133,17 +141,34 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
> >>   					    &probe_data);
> >>   	if (IS_ERR(cxl->efx_region)) {
> >>   		pci_err(pci_dev, "CXL accel create region failed");
> >> -		cxl_dpa_free(cxl->cxled);
> >>   		rc = PTR_ERR(cxl->efx_region);
> >> -		goto err_decoder;
> >> +		goto err_dpa;  
> > Why do we now need to call cxl_dpa_free() and didn't previously here? That
> > seems like a probably bug in earlier patch.  
> 
> 
> I think you misread it. We were calling cxl_dpa_free already, just 
> moving it to a goto label here.
> 
Indeed.  Needed more coffee that day (or less, can't remember which ;)


