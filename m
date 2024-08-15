Return-Path: <netdev+bounces-118921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E01953859
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 18:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E57FB214E8
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 16:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB4E1B8E9F;
	Thu, 15 Aug 2024 16:36:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930211B4C4B;
	Thu, 15 Aug 2024 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723739763; cv=none; b=WzXR+7q9ECC6P9iQv2F0VRADsH29MLYkELqeJZ6Duc/yI4G0B97wm/joVSTsPv50lF8ASp9IFqHEFH/5z/ECsaTg/TUxeFrm1vMslgl7uC4pedh1kWqMhUcnbD7Od7tK4+XKwUNlRGlcFigzOoh/0OjICIaaPPgxEaDJ+BeRTG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723739763; c=relaxed/simple;
	bh=Ibe/Qa8GDqLxfc3hbXDm0mq8thb9jLpEPTGbvQrPnFI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WcFXpAPQwguaecFk0ZPj5P2/1aI66HVxMoBy9XYKGUIjMF22o3zrAZAlnPbak58YwFQETz25VCXn6w1LZzkqjo2N7jlaUVSAEzlnwz5Hpoi8Q37bYebZzJR0Y4X5uau8614RJd6n+2lPKy+JILWo5Renq923Dfz3yHJp0u6xlOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wl9df0SCWz6K6Hm;
	Fri, 16 Aug 2024 00:32:38 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C01D7140119;
	Fri, 16 Aug 2024 00:35:57 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 15 Aug
 2024 17:35:57 +0100
Date: Thu, 15 Aug 2024 17:35:55 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<richard.hughes@amd.com>
Subject: Re: [PATCH v2 01/15] cxl: add type2 device basic support
Message-ID: <20240815173555.0000691a@Huawei.com>
In-Reply-To: <508e796c-64f1-f90a-3860-827eaab2c672@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
	<20240715172835.24757-2-alejandro.lucero-palau@amd.com>
	<20240804181045.000009dc@Huawei.com>
	<508e796c-64f1-f90a-3860-827eaab2c672@amd.com>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 12 Aug 2024 12:16:02 +0100
Alejandro Lucero Palau <alucerop@amd.com> wrote:

> On 8/4/24 18:10, Jonathan Cameron wrote:
> > On Mon, 15 Jul 2024 18:28:21 +0100
> > <alejandro.lucero-palau@amd.com> wrote:
> >  
> >> From: Alejandro Lucero <alucerop@amd.com>
> >>
> >> Differientiate Type3, aka memory expanders, from Type2, aka device
> >> accelerators, with a new function for initializing cxl_dev_state.
> >>
> >> Create opaque struct to be used by accelerators relying on new access
> >> functions in following patches.
> >>
> >> Add SFC ethernet network driver as the client.
> >>
> >> Based on https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m52543f85d0e41ff7b3063fdb9caa7e845b446d0e
> >>
> >> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> >> Co-developed-by: Dan Williams <dan.j.williams@intel.com>  
> >  
> 
> >> +
> >> +void cxl_accel_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec)
> >> +{
> >> +	cxlds->cxl_dvsec = dvsec;  
> > Nothing to do with accel. If these make sense promote to cxl
> > core and a linux/cxl/ header.  Also we may want the type3 driver to
> > switch to them long term. If nothing else, making that handle the
> > cxl_dev_state as more opaque will show up what is still directly
> > accessed and may need to be wrapped up for a future accelerator driver
> > to use.
> >  
> 
> I will change the function name then, but not sure I follow the comment 
> about more opaque ...
If most code can't see the internals of cxl_dev_state because it
doesn't include the header that defines it, then we will generally
spot data that may not belong in that state structure in the first place
or where it is appropriate to have an accessor function mediating that
access.

Jonathan



