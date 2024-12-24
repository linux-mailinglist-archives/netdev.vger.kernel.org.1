Return-Path: <netdev+bounces-154190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 798F79FBFE0
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 17:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D785C1885749
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 16:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D691B0F1E;
	Tue, 24 Dec 2024 16:02:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837551494A6;
	Tue, 24 Dec 2024 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735056131; cv=none; b=bB5tAOqid1lVs9wlNqWO6hx/vEMzKYsf6mCyVYCljeYKhu7nnYxlU3twRSW2hUneze+bQAWGHfcQmyqxHe2/FPa3rAnfeiPHDp0R5+elklDasZzLXbJM5F8odMF+YLD8Jdhs1vWXyfVJvI1dirubHUyujhWhf4C1Hd0RIOLj2cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735056131; c=relaxed/simple;
	bh=upN/IWGXVES6du/kmaAUGWP+jmzcYe1SF5qk38W94Nw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZTNn1SiFZrt2bAjN0FMG7EmD/0uo9KKuBlX+qJUlfp2ynb7uyNf9Ky2IZDdCL8j1oLhqQ5Rd/TBh4HOn/cytPfkqk38E50ViMiOUMBLGtUJ3U33uDZ7IehRXYWGaR6GRixMViO6uvzA+W7ESbW+XMo+ZECvymNNckbh9tTZRuw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHfkY6HXbz67KdR;
	Wed, 25 Dec 2024 00:00:53 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F533140C72;
	Wed, 25 Dec 2024 00:02:07 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 17:02:06 +0100
Date: Tue, 24 Dec 2024 16:02:04 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <alejandro.lucero-palau@amd.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
Subject: Re: [PATCH v7 24/28] cxl: add region flag for precluding a device
 memory to be used for dax
Message-ID: <20241224160204.000012bb@huawei.com>
In-Reply-To: <2dfb81cf-a606-3146-117b-5b5cf25ddbe9@amd.com>
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
	<20241209185429.54054-25-alejandro.lucero-palau@amd.com>
	<455f8e81-fa7b-f416-db0d-4ad9ac158865@gmail.com>
	<2dfb81cf-a606-3146-117b-5b5cf25ddbe9@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 11 Dec 2024 09:23:10 +0000
Alejandro Lucero Palau <alucerop@amd.com> wrote:

> On 12/11/24 02:31, Edward Cree wrote:
> > On 09/12/2024 18:54, alejandro.lucero-palau@amd.com wrote:  
> >> From: Alejandro Lucero <alucerop@amd.com>
> >>
> >> By definition a type2 cxl device will use the host managed memory for
> >> specific functionality, therefore it should not be available to other
> >> uses. However, a dax interface could be just good enough in some cases.
> >>
> >> Add a flag to a cxl region for specifically state to not create a dax
> >> device. Allow a Type2 driver to set that flag at region creation time.
> >>
> >> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> >> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> >> ---
> >>   drivers/cxl/core/region.c | 10 +++++++++-
> >>   drivers/cxl/cxl.h         |  3 +++
> >>   drivers/cxl/cxlmem.h      |  3 ++-
> >>   include/cxl/cxl.h         |  3 ++-
> >>   4 files changed, 16 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> >> index b014f2fab789..b39086356d74 100644
> >> --- a/drivers/cxl/core/region.c
> >> +++ b/drivers/cxl/core/region.c
> >> @@ -3562,7 +3562,8 @@ __construct_new_region(struct cxl_root_decoder *cxlrd,
> >>    * cxl_region driver.
> >>    */
> >>   struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> >> -				     struct cxl_endpoint_decoder *cxled)
> >> +				     struct cxl_endpoint_decoder *cxled,
> >> +				     bool no_dax)  
> > Won't this break bisectability?  sfc won't build as of this commit
> >   because it tries to call cxl_create_region with the old signature.
> > You could do the whole dance of having an interim API during the
> >   conversion, but seems simpler just to reorder the patches so that
> >   the no_dax parameter is added first before the caller is introduced.  
> 
> 
> Oh. That's true. I wonder why the robot did not catch this! I thought it 
> was building things after each patch in a patchset.
That would be fantastically more expensive. There were some talks on 0-day
magic a while back. If I recall correctly it even merges what it thinks are
unrelated trees on basis if the merge is fine, both trees probably are
as well ;)  The whole game of that system is maximum catching of bugs
for minimum compile times!

Jonathan

> 
> I will change the order for properly using this in the sfc driver.
> 
> Thanks!
> 
> 
> 
> 


