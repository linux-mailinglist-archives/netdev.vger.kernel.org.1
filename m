Return-Path: <netdev+bounces-122398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F256961038
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 17:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 535C31C20C0C
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430C11C4603;
	Tue, 27 Aug 2024 15:06:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2BC19F485;
	Tue, 27 Aug 2024 15:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771192; cv=none; b=oTN4SaHxHVmQFJjEczZCUAyfSbPryTtfRcKI7Ix082Sv/3bTo8G7S8txVaA9aCYpY4FEJHmSKnI9uZP06ZECai818RtMrRgi4GeRBMa3f/6dPS/cBw3nu3L+GMgvtfs2JcsqYWJic2s5JOg3ZMmWJET2Dw0HTF/q8GDhCTq/igg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771192; c=relaxed/simple;
	bh=9dFmxU9XikVnndxj6IR/n8hH8VSnVajZd3oUbPdkPZ0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJ8TuTiXlQ0qQ2QbUsP3qF2J8DRM14gUSwJVVc9WlYHGoEnuCWas6EwYMkxOkaS2PbF3K7f3uXLxPBbWPDCQjWMwYI3RK8edl+Ymo5j9ROgn3Be9UfpO4r/n0jQqzBk0MChuifz0mvV8pW0YgYoqejfMLNnMRUkZQaaLD7cF9Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WtW4v5nFNz6DBhm;
	Tue, 27 Aug 2024 23:03:11 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B0F0A140B39;
	Tue, 27 Aug 2024 23:06:26 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 16:06:26 +0100
Date: Tue, 27 Aug 2024 16:06:25 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<richard.hughes@amd.com>
Subject: Re: [PATCH v2 01/15] cxl: add type2 device basic support
Message-ID: <20240827160625.0000505c@Huawei.com>
In-Reply-To: <3b23989a-9ac4-6a90-bc5b-bb12377c0385@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
	<20240715172835.24757-2-alejandro.lucero-palau@amd.com>
	<20240804181045.000009dc@Huawei.com>
	<508e796c-64f1-f90a-3860-827eaab2c672@amd.com>
	<20240815173555.0000691a@Huawei.com>
	<3b23989a-9ac4-6a90-bc5b-bb12377c0385@amd.com>
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

On Mon, 19 Aug 2024 12:10:34 +0100
Alejandro Lucero Palau <alucerop@amd.com> wrote:

> On 8/15/24 17:35, Jonathan Cameron wrote:
> > On Mon, 12 Aug 2024 12:16:02 +0100
> > Alejandro Lucero Palau <alucerop@amd.com> wrote:
> >  
> >> On 8/4/24 18:10, Jonathan Cameron wrote:  
> >>> On Mon, 15 Jul 2024 18:28:21 +0100
> >>> <alejandro.lucero-palau@amd.com> wrote:
> >>>     
> >>>> From: Alejandro Lucero <alucerop@amd.com>
> >>>>
> >>>> Differientiate Type3, aka memory expanders, from Type2, aka device
> >>>> accelerators, with a new function for initializing cxl_dev_state.
> >>>>
> >>>> Create opaque struct to be used by accelerators relying on new access
> >>>> functions in following patches.
> >>>>
> >>>> Add SFC ethernet network driver as the client.
> >>>>
> >>>> Based on https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m52543f85d0e41ff7b3063fdb9caa7e845b446d0e
> >>>>
> >>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> >>>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>  
> >>>     
> >>>> +
> >>>> +void cxl_accel_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec)
> >>>> +{
> >>>> +	cxlds->cxl_dvsec = dvsec;  
> >>> Nothing to do with accel. If these make sense promote to cxl
> >>> core and a linux/cxl/ header.  Also we may want the type3 driver to
> >>> switch to them long term. If nothing else, making that handle the
> >>> cxl_dev_state as more opaque will show up what is still directly
> >>> accessed and may need to be wrapped up for a future accelerator driver
> >>> to use.
> >>>     
> >> I will change the function name then, but not sure I follow the comment
> >> about more opaque ...  
> > If most code can't see the internals of cxl_dev_state because it
> > doesn't include the header that defines it, then we will generally
> > spot data that may not belong in that state structure in the first place
> > or where it is appropriate to have an accessor function mediating that
> > access.  
> 
> 
> I follow that but I do not know if you are suggesting here to make it 
> opaque which conflicts with a previous comment stating it does not need 
> to be.
> 
Different potential approaches.  I'm not totally sure we 'yet' care
about making it opaque as we don't have that many drivers so review for
misuse is enough. Longer term I think we want to get there - maybe now
is the convenient moment to do so.

Jonathan

> 
> > Jonathan
> >
> >  


