Return-Path: <netdev+bounces-122400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 624699610D1
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 17:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D8471F23410
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3323B1C57AF;
	Tue, 27 Aug 2024 15:13:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15B71C6894;
	Tue, 27 Aug 2024 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771582; cv=none; b=oslc8vHfHlckW4kt84DnSNFYJSFzC5t62sXMphV6529MrMd2FOc8P73avCwTMaHu17WS2XBZQRjgTEVi7d+hfpUewTFOe3m0FdxjchrMn+xx4HDVaFmlWpSJTFdJRwwAJl47oGfFALLXetRxQI1DA3ratCnS9wQVpP4WTa737QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771582; c=relaxed/simple;
	bh=U6ZXTvMC7qfXZv/4gvYoEX0upKnN/rHEnjpxOPk+BBE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GnzcHLQp4ApbY2Rh4fHH28vSEPtafu8S6vmkCoq9iMesUMV8DlAKvDnog3DeikxJ8lslZuZqIzQY+10HV3N9dvKCFB8rHCrVjEEhgIOz5QIhzoaKyzGCOxyT841EjKDyDsd0nNZP91jIhDB75s6DKVGq6bpPkKdFR1XM6qzrKqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WtWCY33nlz6J73k;
	Tue, 27 Aug 2024 23:08:57 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 52C6F140B33;
	Tue, 27 Aug 2024 23:12:56 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 16:12:55 +0100
Date: Tue, 27 Aug 2024 16:12:54 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<richard.hughes@amd.com>
Subject: Re: [PATCH v2 05/15] cxl: fix use of resource_contains
Message-ID: <20240827161254.00002dbe@Huawei.com>
In-Reply-To: <32f38caf-8cc3-2e4c-668f-f36552b7cffe@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
	<20240715172835.24757-6-alejandro.lucero-palau@amd.com>
	<20240804182519.00006ea8@Huawei.com>
	<32f38caf-8cc3-2e4c-668f-f36552b7cffe@amd.com>
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

On Fri, 16 Aug 2024 15:37:14 +0100
Alejandro Lucero Palau <alucerop@amd.com> wrote:

> On 8/4/24 18:25, Jonathan Cameron wrote:
> > On Mon, 15 Jul 2024 18:28:25 +0100
> > <alejandro.lucero-palau@amd.com> wrote:
> >  
> >> From: Alejandro Lucero <alucerop@amd.com>
> >>
> >> For a resource defined with size zero, resource contains will also
> >> return true.
> >>
> >> Add resource size check before using it.
> >>
> >> Signed-off-by: Alejandro Lucero <alucerop@amd.com>  
> > If this can happen in existing type 3 case the fixes tag
> > and send it separately from this series.  
> 
> 
> I have been looking at this possibility and although not with 100% 
> certainty, I would say it is not for Type3.
> 
> "Type3 regions" are (usually) created from user space, and:
> 
> 1) if it is RAM, dax code is invoked for creating the region
> 
> 2) if it is pmem, pmem region creation code is invoked.
> 
> None of these possibilities use the affected code in this patch.
> 
> There exist two options where that code could be used by Type3, which 
> are confusing:
> 
> 1) regions created during device initialization, but for that the 
> decoder needs to be committed and it is not expected for Type3 without 
> user space intervention.

More than possible a bios already set them up.

> 
> 2) when emulating an hdm decoder, what I think it is not possible for 
> Type3 since it is mandatory.

HDM Decoders are not mandatory for older devices and not mandatory for
bios to have used them.  Papering over that gap is what the emulation code
is there for.

> 
> 
> Finally we have code when sysfs dpa_size file is written, which I'm not 
> familiar with.

That's an early part of the userspace bringing up the memory if it
wasn't set up by bios or from pmem lsa data.

Not sure any that helps though ;)

Jonathan

> 
> 
> 
> > If there is no path due to some external code, then
> > drop the word fix from the title and call it
> >
> > cxl: harden resource_contains checks to handle zero size resources  
> 
> 
> After the explanation above, I will do as you say.
> 
> Thanks!
> 
> 
> > Avoids it getting backported into stable / distros picking it
> > up if there isn't a real issue before this series.
> >
> > Thanks,
> >
> > Jonathan
> >  
> >> ---
> >>   drivers/cxl/core/hdm.c | 7 +++++--
> >>   1 file changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> >> index 3df10517a327..4af9225d4b59 100644
> >> --- a/drivers/cxl/core/hdm.c
> >> +++ b/drivers/cxl/core/hdm.c
> >> @@ -327,10 +327,13 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> >>   	cxled->dpa_res = res;
> >>   	cxled->skip = skipped;
> >>   
> >> -	if (resource_contains(&cxlds->pmem_res, res))
> >> +	if ((resource_size(&cxlds->pmem_res)) && (resource_contains(&cxlds->pmem_res, res))) {
> >> +		printk("%s: resource_contains CXL_DECODER_PMEM\n", __func__);
> >>   		cxled->mode = CXL_DECODER_PMEM;
> >> -	else if (resource_contains(&cxlds->ram_res, res))
> >> +	} else if ((resource_size(&cxlds->ram_res)) && (resource_contains(&cxlds->ram_res, res))) {
> >> +		printk("%s: resource_contains CXL_DECODER_RAM\n", __func__);
> >>   		cxled->mode = CXL_DECODER_RAM;
> >> +	}
> >>   	else {
> >>   		dev_warn(dev, "decoder%d.%d: %pr mixed mode not supported\n",
> >>   			 port->id, cxled->cxld.id, cxled->dpa_res);  


