Return-Path: <netdev+bounces-122738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BD9962600
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 13:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2439C1C22877
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 11:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3E716CD2A;
	Wed, 28 Aug 2024 11:26:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87563FEC;
	Wed, 28 Aug 2024 11:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724844388; cv=none; b=CI5FtEB1g1FODa0GW5bhfevMXdHHZeHEc3USld50bFK/ULMcYlCyd3ZmSYuQaN/DXQeqnMKZjo0y6Q3ReVhIiD3eN270upMqUIGdQUCjAwuTgBA+neWvDHpqVJNCBvJg660ZvZJg63Ha3T+0ertkVlve2N99nnbHwyxoTQXPpcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724844388; c=relaxed/simple;
	bh=Le1Vfo7fOKhLyWpNlP2q66mH8jrOV4x4y91GBTZVU2k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JZGv3iZsI3KoWZwAuPBej4DxauQ4h53+rEP9Bo8pOIKWmwpREE54iVgInMKSr5V50oFGm9HDWRW3zBInsx2vHEC+IiK2dt3SP635/qupkBeXDWw0y+XYka0Q4U7eyTwA/ikwEjB2m640N93oUNcxnTQwerhbcHzM2CoirHLjxN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wv28S5Yvrz6K8n6;
	Wed, 28 Aug 2024 19:23:04 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E2D30140B20;
	Wed, 28 Aug 2024 19:26:22 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 12:26:14 +0100
Date: Wed, 28 Aug 2024 12:26:13 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<richard.hughes@amd.com>
Subject: Re: [PATCH v2 09/15] cxl: define a driver interface for HPA free
 space enumaration
Message-ID: <20240828122613.000032e9@Huawei.com>
In-Reply-To: <446d8183-d334-bf5c-8ba8-de957b7e8edb@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
	<20240715172835.24757-10-alejandro.lucero-palau@amd.com>
	<20240804185756.000046c5@Huawei.com>
	<446d8183-d334-bf5c-8ba8-de957b7e8edb@amd.com>
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

On Wed, 28 Aug 2024 11:41:11 +0100
Alejandro Lucero Palau <alucerop@amd.com> wrote:

> On 8/4/24 18:57, Jonathan Cameron wrote:
> > + }  
> >> +	return 0;
> >> +}
> >> +
> >> +/**
> >> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
> >> + * @endpoint: an endpoint that is mapped by the returned decoder
> >> + * @interleave_ways: number of entries in @host_bridges
> >> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and HDM-H vs HDM-D[B]
> >> + * @max: output parameter of bytes available in the returned decoder  
> > @available_size
> > or something along those lines. I'd expect max to be the end address of the available
> > region  
> 
> 
> No really. The code looks for the biggest free hole in the HPA. 
> Returning available size does not help except from informing about the 
> "internal fragmentation".

I worded that badly.  Intent was that to me 'max' ==  maximum address, not maximum available
contiguous range.  max_hole or max_avail_contig maybe?

> 

