Return-Path: <netdev+bounces-184763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65F4A971AE
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 17:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED80144187E
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 15:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C65E14883F;
	Tue, 22 Apr 2025 15:52:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72DF290083;
	Tue, 22 Apr 2025 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745337124; cv=none; b=kVQkEvi7vOxCXWzImqKdDWGUacpQE2q5W9SpgakQc7tQXfrj35u4toQafTrOUyxkIZ5Y1xYe5TnaXn3w+/E/TNjkCZGWFkH+rwrPDrTrvoRnugUYAc1KtuAxThs4OZqwqwxuPoi/kq2CCqHtlffVJSr6dyMFOIkP/80hSq8mrNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745337124; c=relaxed/simple;
	bh=AH+Q8UtE92o5RJ5wRhCdSovwJClD9/7ON4gllAZdkcc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tdjgwkRGxKaDi7T+R3JHDain/AwcmsHem0huq5tTl8K9J5+L0ij4Ye4oqVEtRKxYa2tl0AjTwm3XChzdEZ1DY4GxcfRzc5TzKDHOZs3hBNOu34dyqibpmAm3N4V3ooQC9h9WVMdFCw1QkJvDihOY5lyjnHcHcTf8v+nhK/4q3fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZhmsQ2dpLz6L5Gs;
	Tue, 22 Apr 2025 23:50:18 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id ECFA01401F4;
	Tue, 22 Apr 2025 23:51:58 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 22 Apr
 2025 17:51:58 +0200
Date: Tue, 22 Apr 2025 16:51:57 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
Subject: Re: [PATCH v13 11/22] cxl: define a driver interface for HPA free
 space enumeration
Message-ID: <20250422165157.00006953@huawei.com>
In-Reply-To: <eb1e5fca-7a8b-4ff1-8222-ce2eb16777dd@amd.com>
References: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
	<20250414151336.3852990-12-alejandro.lucero-palau@amd.com>
	<20250415145016.00003725@huawei.com>
	<eb5f16f8-607a-4c71-8f81-5cdb4ff73a75@amd.com>
	<20250417173650.00003ee0@huawei.com>
	<eb1e5fca-7a8b-4ff1-8222-ce2eb16777dd@amd.com>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Apr 2025 22:22:19 +0100
Alejandro Lucero Palau <alucerop@amd.com> wrote:

> On 4/17/25 17:36, Jonathan Cameron wrote:
> > On Thu, 17 Apr 2025 13:11:00 +0100
> > Alejandro Lucero Palau <alucerop@amd.com> wrote:
> >  
> >> On 4/15/25 14:50, Jonathan Cameron wrote:  
> >>> On Mon, 14 Apr 2025 16:13:25 +0100
> >>> alejandro.lucero-palau@amd.com wrote:
> >>>     
> >>>> From: Alejandro Lucero <alucerop@amd.com>
> >>>>
> >>>> CXL region creation involves allocating capacity from device DPA
> >>>> (device-physical-address space) and assigning it to decode a given HPA
> >>>> (host-physical-address space). Before determining how much DPA to
> >>>> allocate the amount of available HPA must be determined. Also, not all
> >>>> HPA is created equal, some specifically targets RAM, some target PMEM,
> >>>> some is prepared for device-memory flows like HDM-D and HDM-DB, and some
> >>>> is host-only (HDM-H).
> >>>>
> >>>> Wrap all of those concerns into an API that retrieves a root decoder
> >>>> (platform CXL window) that fits the specified constraints and the
> >>>> capacity available for a new region.
> >>>>
> >>>> Add a complementary function for releasing the reference to such root
> >>>> decoder.
> >>>>
> >>>> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
> >>>>
> >>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>  
> >>> One trivial comment inline.
> >>>
> >>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>>     
> >>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> >>>> index 80caaf14d08a..0a9eab4f8e2e 100644
> >>>> --- a/drivers/cxl/core/region.c
> >>>> +++ b/drivers/cxl/core/region.c
> >>>> +static int find_max_hpa(struct device *dev, void *data)
> >>>> +{
> >>>> +	struct cxlrd_max_context *ctx = data;
> >>>> +	struct cxl_switch_decoder *cxlsd;
> >>>> +	struct cxl_root_decoder *cxlrd;
> >>>> +	struct resource *res, *prev;
> >>>> +	struct cxl_decoder *cxld;
> >>>> +	resource_size_t max;
> >>>> +	int found = 0;
> >>>> +
> >>>> +	if (!is_root_decoder(dev))
> >>>> +		return 0;
> >>>> +
> >>>> +	cxlrd = to_cxl_root_decoder(dev);
> >>>> +	cxlsd = &cxlrd->cxlsd;
> >>>> +	cxld = &cxlsd->cxld;
> >>>> +
> >>>> +	/*
> >>>> +	 * None flags are declared as bitmaps but for the sake of better code  
> >>> None?  
> >>
> >> Not sure you refer to syntax or semantics here. Assuming is the former:  
> > Just the wording of the comment. I'm not sure what it means.  
> 
> 
> Ok. I just want to make clear those flags fields used in the 
> bitmap_subset are not declared as bitmaps, just in case someone points 
> this out.
> 
> I do not think this is problematic, and a good idea you gave me, but 
> better to comment on it before someone complains about it.
> 
Ah.. Ok. So something like:

Fields are not declared as bitmaps, but bitmap_subset may still be used.

> 
> >  
> >>
> >> No flags fields?  
> > Not following that either.  
> >>  
> >>>     
> >>>> +	 * used here as such, restricting the bitmap size to those bits used by
> >>>> +	 * any Type2 device driver requester.
> >>>> +	 */  
> >>>     


