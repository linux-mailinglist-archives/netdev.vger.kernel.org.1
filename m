Return-Path: <netdev+bounces-128528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E72B597A22D
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 14:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90EA9B25035
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 12:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8341547FF;
	Mon, 16 Sep 2024 12:24:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0202C156F42;
	Mon, 16 Sep 2024 12:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489452; cv=none; b=mPCF1JnKVxnA8gqcoTh+O7qYYnV/Z8/hIN/wlNx3jd3TQHMulUKRVpxo1jDPS4SmduDI15AmhJUAcBDQVy/ew+gx3liJWC2Kt8ocjBNSkol9Ib0RtXL0WYea+ZVNt0ub1VIoQTazSxTM2BBC3o4ilCAF3S8AyyycPfqyLDszcBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489452; c=relaxed/simple;
	bh=ZuE0xGBM8KRxBFL/NYU+2UQ30BPaqFRmYRARfSX9Ymo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iViUs/XPZefttnPiQMJ6kRmlp463sJcI47POb0h9hqvbHa38k1xDqybq1Z7AvwbSYxWcyNJ1nEniCFg1w92/39lrdSPzAmEzdpPqBkDsIbkLKtBIZ4kNKbZeBF8EFPGxkNQUm5TZqqD54bTfH68UX0+uFj0rxsQNO4tOGr7u3cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X6kWF62HXz6K8yJ;
	Mon, 16 Sep 2024 20:19:53 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 658F7140A90;
	Mon, 16 Sep 2024 20:24:05 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 16 Sep
 2024 14:24:04 +0200
Date: Mon, 16 Sep 2024 13:24:03 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>
Subject: Re: [PATCH v3 01/20] cxl: add type2 device basic support
Message-ID: <20240916132403.0000342c@Huawei.com>
In-Reply-To: <5e3337df-cb85-efbb-ceaf-a9d9808d981c@amd.com>
References: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
	<20240907081836.5801-2-alejandro.lucero-palau@amd.com>
	<20240913174103.000034ee@Huawei.com>
	<5e3337df-cb85-efbb-ceaf-a9d9808d981c@amd.com>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 16 Sep 2024 13:03:10 +0100
Alejandro Lucero Palau <alucerop@amd.com> wrote:

> On 9/13/24 17:41, Jonathan Cameron wrote:

> >> Add SFC ethernet network driver as the client.  
> > Minor thing (And others may disagree) but I'd split this to be nice
> > to others who might want to backport the type2 support but not
> > the sfc changes (as they are supporting some other hardware).  
> 
> 
> Should I then send incremental sfc changes as well as the API is 
> introduced or just a final patch with all of it?

Given aim is to justify each step for this first user I think
incremental sfc changes do make sense.


> 
> 
> >> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> >> Co-developed-by: Dan Williams <dan.j.williams@intel.com>  
> >  
> >> +int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
> >> +		     enum cxl_resource type)
> >> +{
> >> +	switch (type) {
> >> +	case CXL_ACCEL_RES_DPA:
> >> +		cxlds->dpa_res = res;
> >> +		return 0;
> >> +	case CXL_ACCEL_RES_RAM:
> >> +		cxlds->ram_res = res;
> >> +		return 0;
> >> +	case CXL_ACCEL_RES_PMEM:
> >> +		cxlds->pmem_res = res;
> >> +		return 0;
> >> +	default:
> >> +		dev_err(cxlds->dev, "unknown resource type (%u)\n", type);  
> > It's an enum, do we need the default?  Hence do we need the return value?
> >  
> 
> I think it does not harm and helps with extending the enum without 
> silently failing if all the places where it is used are not properly 
> updated.

It won't silently fail.  The various build bots love to point out unhandled
cases :)  Adding the default means that you'll only see the problem
in runtime testing rather than at build time.

> 
> 
> >> +		return -EINVAL;
> >> +	}
> >> +}
> >> +EXPORT_SYMBOL_NS_GPL(cxl_set_resource, CXL);
> >> +
> >>   static int cxl_memdev_release_file(struct inode *inode, struct file *file)
> >>   {
> >>   	struct cxl_memdev *cxlmd =
> >> +	if (!dvsec)
> >>   		dev_warn(&pdev->dev,
> >>   			 "Device DVSEC not present, skip CXL.mem init\n");
> >> +	else
> >> +		cxl_set_dvsec(cxlds, dvsec);  
> > Set it unconditionally perhaps.  If it's NULL that's fine and then it corresponds
> > directly to the previous  
> 
> 
> OK. I guess keeping the dev_warn. Right?

Absolutely.


> >> diff --git a/drivers/net/ethernet/sfc/efx.c b/drivers/net/ethernet/sfc/efx.c
> >> index 6f1a01ded7d4..3a7406aa950c 100644
> >> --- a/drivers/net/ethernet/sfc/efx.c
> >> +++ b/drivers/net/ethernet/sfc/efx.c

> >> @@ -1109,6 +1113,15 @@ static int efx_pci_probe(struct pci_dev *pci_dev,
> >>   	if (rc)
> >>   		goto fail2;
> >>   
> >> +	/* A successful cxl initialization implies a CXL region created to be
> >> +	 * used for PIO buffers. If there is no CXL support, or initialization
> >> +	 * fails, efx_cxl_pio_initialised wll be false and legacy PIO buffers
> >> +	 * defined at specific PCI BAR regions will be used.
> >> +	 */
> >> +	rc = efx_cxl_init(efx);
> >> +	if (rc)
> >> +		pci_err(pci_dev, "CXL initialization failed with error %d\n", rc);  
> > If you are carrying on anyway is pci_info() more appropriate?
> > Personally I dislike muddling on in error cases, but understand
> > it can be useful on occasion at the cost of more complex flows.
> >
> >  
> 
> Not sure. Note this is for the case something went wrong when the device 
> has CXL support.
> 
> It is not fatal, but it is an error.

Fair enough.  I don't care that much about this.
> 
> 
> >> +
> >>   	rc = efx_pci_probe_post_io(efx);
> >>   	if (rc) {
> >>   		/* On failure, retry once immediately.
> >> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> >> new file mode 100644
> >> index 000000000000..bba36cbbab22
> >> --- /dev/null
> >> +++ b/drivers/net/ethernet/sfc/efx_cxl.c

> > //maybe also cxlds as then you can use __free() to handle the
> > //cleanup paths for both allowing early returns instead
> > //of gotos.  
> 
> 
> Maybe, but using __free is discouraged in network code: 1.6.5 at
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Fair enough.  I've not been keeping up with networking maintainer
preferences recently.

Jonathan


