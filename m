Return-Path: <netdev+bounces-122408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A69CB9611DA
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 17:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F25C280FE7
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 15:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8D71C1723;
	Tue, 27 Aug 2024 15:24:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980751BC073;
	Tue, 27 Aug 2024 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772241; cv=none; b=aYV7gHVfrFwmGdVf4M+SIqQZQ6h78EyEXi/N2C0+32z7LIkHX+T79Yrw1c+/e9yXwuGEr13I3fNl9lhqqS1n1oR7cY8bpeAqwWuMI/e3c4vd2Ljyx6WChoAqcQqMOE6/vc/e1DidxqiYy9SNwblwCvKoDCVvOONxrTSQl6RxCKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772241; c=relaxed/simple;
	bh=1o2XwCwyaWcKmYe9S4DCz9zjrQeFOcSC2p5cTt54IMU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RNnrrilOMOrmOC1yTyoHHJ0g5NlfrCAopqkgs0fnT6rnOuzoLUYAYe+Tn2ppwp6sHnBBMp17XQbW4liY5/qH2XD0VCCnW/II1cY+GIC9/F+FgcafsnBBzI7/9CxGGEtx+kqFR0bU0Ya/jc4dUQc+qU9TVP9eTsBxcaGYupCHv1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WtWT371qlz6K9Bh;
	Tue, 27 Aug 2024 23:20:39 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B8392140C9C;
	Tue, 27 Aug 2024 23:23:55 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 16:23:55 +0100
Date: Tue, 27 Aug 2024 16:23:54 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>,
	<martin.habets@xilinx.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<richard.hughes@amd.com>
Subject: Re: [PATCH v2 15/15] efx: support pio mapping based on cxl
Message-ID: <20240827162354.00003208@Huawei.com>
In-Reply-To: <7e17a0f9-ef84-5ce1-3574-5d609525b7f1@amd.com>
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
	<20240715172835.24757-16-alejandro.lucero-palau@amd.com>
	<20240804191339.00001eb9@Huawei.com>
	<7e17a0f9-ef84-5ce1-3574-5d609525b7f1@amd.com>
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

On Mon, 19 Aug 2024 17:28:46 +0100
Alejandro Lucero Palau <alucerop@amd.com> wrote:

> On 8/4/24 19:13, Jonathan Cameron wrote:
> > On Mon, 15 Jul 2024 18:28:35 +0100
> > alejandro.lucero-palau@amd.com wrote:
> >  
> >> From: Alejandro Lucero <alucerop@amd.com>
> >>
> >> With a device supporting CXL and successfully initialised, use the cxl
> >> region to map the memory range and use this mapping for PIO buffers.  
> > This explains why you weren't worried about any step of the CXL
> > code failing and why that wasn't a 'bug' as such.
> >
> > I'd argue that you should still have the cxl intialization return
> > an error code and cleanup any state it if hits an error.  
> 
> 
> Ideally, but with devm* being used, this is not easy to do if the error 
> is not fatal.

That's usually a strong argument that you shouldn't use devm at that
level of abstraction.  

> 
> 
> > Then the top level driver can of course elect to use an alternative
> > path given that failure.  Logically it belongs there rather than relying
> > on a buffer being mapped or not.
> >  
> 
> Same driver needs to support same functionality which relies on those 
> specific hardware buffers.
> 
> The functionality is expected to be there with or without CXL. If the 
> hardware has no CXL, the system or the device, the functionality will be 
> there with legacy PCIe BAR regions. The green light for CXL use comes 
> from two sources: the firmware and the kernel. Both need to give the 
> thumbs up. If not, legacy PCIe BAR regions will be used.

Rather than going through full setup, see if you can figure out a minimal
(state free) check on whether it should work.

If a system is broken, then it's very different from a legacy system
with no support for CXL and we can maybe just handle the broken system
with errors (or quirks if it's a shipping system).

Jonathan
  
> 

