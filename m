Return-Path: <netdev+bounces-122403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C0C961160
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 17:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F3B6B2731C
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDC81C8FDE;
	Tue, 27 Aug 2024 15:18:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC761CDA04;
	Tue, 27 Aug 2024 15:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771911; cv=none; b=p5wwfXDZMIhn7iIXHFTxX7GPkcWHv1vMGcWInRrPB1GasuxUfmjJxGAPcOdh5R7t9O91EyvpPKntDkkrVJSaTzvUdq9jqNPJN7ikljtT1+FUGO+cIPxdFgVkSQ0rOajAE5D09uE+kMMo/OZMRVZCsRIjTkUw/uK2nImIGfPz7IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771911; c=relaxed/simple;
	bh=nNRIz068p/qgB1Y61AXhoZ04ufnISP5a48d3JNGk+ak=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bDHe8cy/Dq/pjNvStO2lsCwOgITonfSNjPO+4sKPL/g3AzoIeNGAybFnHs889aDAheFg/+Zdl2mqCYtAtFcgbDmuNlRgFcY3IOochz733TLm693+U/tPIGF1PP+Fxr3btXkEfsEXSg21OpCZKeHdwt227Gx/zHVyLHCnxjIbpjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WtWLl05Yjz6K5VM;
	Tue, 27 Aug 2024 23:15:11 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id BD348140C9C;
	Tue, 27 Aug 2024 23:18:26 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 16:18:26 +0100
Date: Tue, 27 Aug 2024 16:18:25 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<richard.hughes@amd.com>
Subject: Re: [PATCH v2 09/15] cxl: define a driver interface for HPA free
 space enumaration
Message-ID: <20240827161825.0000146b@Huawei.com>
In-Reply-To: <adcc692e-8819-3741-31d3-d1202cc1b619@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
	<20240715172835.24757-10-alejandro.lucero-palau@amd.com>
	<20240804185756.000046c5@Huawei.com>
	<adcc692e-8819-3741-31d3-d1202cc1b619@amd.com>
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
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 19 Aug 2024 15:47:48 +0100
Alejandro Lucero Palau <alucerop@amd.com> wrote:

> On 8/4/24 18:57, Jonathan Cameron wrote:
> > On Mon, 15 Jul 2024 18:28:29 +0100
> > alejandro.lucero-palau@amd.com wrote:
> >  
> >> From: Alejandro Lucero <alucerop@amd.com>
> >>
> >> CXL region creation involves allocating capacity from device DPA
> >> (device-physical-address space) and assigning it to decode a given HPA
> >> (host-physical-address space). Before determining how much DPA to
> >> allocate the amount of available HPA must be determined. Also, not all
> >> HPA is create equal, some specifically targets RAM, some target PMEM,
> >> some is prepared for device-memory flows like HDM-D and HDM-DB, and some
> >> is host-only (HDM-H).
> >>
> >> Wrap all of those concerns into an API that retrieves a root decoder
> >> (platform CXL window) that fits the specified constraints and the
> >> capacity available for a new region.
> >>
> >> Based on https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m6fbe775541da3cd477d65fa95c8acdc347345b4f
> >>
> >> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> >> Co-developed-by: Dan Williams <dan.j.williams@intel.com>  
> > Hi.
> >
> > This seems a lot more complex than an accelerator would need.
> > If plan is to use this in the type3 driver as well, I'd like to
> > see that done as a precursor to the main series.
> > If it only matters to accelerator drivers (as in type 3 I think
> > we make this a userspace problem), then limit the code to handle
> > interleave ways == 1 only.  Maybe we will care about higher interleave
> > in the long run, but do you have a multihead accelerator today?  
> 
> 
> I would say this is needed for Type3 as well but current support relies 
> on user space requests. I think Type3 support uses the legacy 
> implementation for memory devices where initially the requirements are 
> quite similar, but I think where CXL is going requires less manual 
> intervention or more automatic assisted manual intervention. I'll wait 
> until Dan can comment on this one for sending it as a precursor or as 
> part of the type2 support.
> 
> 
> Regarding the interleave, I know you are joking ... but who knows what 
> the future will bring. O maybe I'm misunderstanding your comment, 
> because in my view multi-head device and interleave are not directly 
> related. Are they? I think you can have a single head and support 
> interleaving, with multi-head implying different hosts and therefore 
> different HPAs.

Nothing says they heads are connected to different hosts.

For type 3 version the reason you'd do this is to spread load across
multiple root ports.  So it's just a bandwidth play and as far
as the host is concerned they might as well be separate devices.

For accelerators in theory you can do stuff like that but it gets
fiddly fast and in theory you might care that they are the same
device for reasons beyond RAS etc and might interleave access to
device memory across the two heads.

Don't think we care today though, so for now I'd just reject any
interleaving.

Jonathan

 


