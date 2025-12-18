Return-Path: <netdev+bounces-245372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAE0CCC60B
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 16:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 928AB302058A
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 15:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24AA2BD5BD;
	Thu, 18 Dec 2025 15:03:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAC3264A9D;
	Thu, 18 Dec 2025 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766070197; cv=none; b=Jt5Mp/i2qDVFVlPPKBlO54cTRm+D1PExYFzvWQcRiHO3CGIlxT3si/weTBRcjp8oc2kFF28vptvSXzUIjbHOV2CVcnz+olzh+NkAoZB7pmd1B8ocH7phBtGyaIQZrkVxVyr6m5EFrX66qadHOj24Qet8SpYZhUXGLt9dR9xFBgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766070197; c=relaxed/simple;
	bh=vk8vnEVYuY1//kqiFWRWF3nq5YHuqVZLbIp2abOJhA8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jHWH0FF6aaudz+OaRG+5aJANiRisB+Z9o1R9Kz/kBrFLBUQ2R9NXXDIvCRXMcLc2T21HdIQbmlWi+0e8QxpoljoxV0wFfbi1BC0KcMgtF39U5TknkjHS3bGnVq5PctlDhFj1mH9B/7VPN+MB2elAfNlJ/gRkYDeZAymngjvIyMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dXDRm1WfXzHnGkZ;
	Thu, 18 Dec 2025 23:02:44 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 8BB0940571;
	Thu, 18 Dec 2025 23:03:11 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 18 Dec
 2025 15:03:10 +0000
Date: Thu, 18 Dec 2025 15:03:09 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
Subject: Re: [PATCH v22 11/25] cxl/hdm: Add support for getting region from
 committed decoder
Message-ID: <20251218150309.00006837@huawei.com>
In-Reply-To: <f56f7a6b-7931-4264-8d42-50603ce81cba@amd.com>
References: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
	<20251205115248.772945-12-alejandro.lucero-palau@amd.com>
	<20251215135047.000018f7@huawei.com>
	<f56f7a6b-7931-4264-8d42-50603ce81cba@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 18 Dec 2025 11:52:58 +0000
Alejandro Lucero Palau <alucerop@amd.com> wrote:

> Hi Jonathan,
> 
> 
> On 12/15/25 13:50, Jonathan Cameron wrote:
> > On Fri, 5 Dec 2025 11:52:34 +0000
> > <alejandro.lucero-palau@amd.com> wrote:
> >  
> >> From: Alejandro Lucero <alucerop@amd.com>
> >>
> >> A Type2 device configured by the BIOS can already have its HDM
> >> committed. Add a cxl_get_committed_decoder() function for cheking  
> > checking if this is so after memdev creation.
> >  
> >> so after memdev creation. A CXL region should have been created
> >> during memdev initialization, therefore a Type2 driver can ask for
> >> such a region for working with the HPA. If the HDM is not committed,
> >> a Type2 driver will create the region after obtaining proper HPA
> >> and DPA space.
> >>
> >> Signed-off-by: Alejandro Lucero <alucerop@amd.com>  
> > Hi Alejandro,
> >
> > I'm in two minds about this.  In general there are devices that have
> > been configured by the BIOS because they are already in use. I'm not sure
> > the driver you are working with here is necessarily set up to survive
> > that sort of live setup without interrupting data flows.  
> 
> 
> This is not mainly about my driver/device but something PJ and Dan agree 
> on support along this type2 patchset.
> 
> You can see the v21 discussions, but basically PJ can not have his 
> driver using the committed decoders from BIOS. So this change addresses 
> that situation which my driver/device can also benefit from as current 
> BIOS available is committing decoders regardless of UEFI flags like 
> EFI_RESERVED_TYPE.
> 
> 
> Neither in my case nor in PJ case the device will be in use before 
> kernel is executing, although PJ should confirm this.

There was some discussion in that thread of whether the decoders are locked.
If they aren't (and if the device is not in use, or some other hard constraint
isn't requiring it, in my view they definitely shouldn't be!) I'd at least
like to consider the option of a 'cleanup pass' to tear them down and give
the driver a clean slate to build on. Kind of similar to what we do in
making PCI reeumerate in the kernel if we really don't like what the bios did.

Might not be possible if there is another higher numbered decoder in use
though :(

> 
> 
> >
> > If it is fair enough to support this, otherwise my inclination is tear
> > down whatever the bios did and start again (unless locked - in which
> > case go grumble at your BIOS folk). Reasoning being that we then only
> > have to handle the equivalent of the hotplug flow in both cases rather
> > than having to handle 2.  
> 
> 
> Well, the automatic discovery region used for Type3 can be reused for 
> Type2 in this scenario, so we do not need to tear down what the BIOS 
> did. However, the argument is what we should do when the driver exits 
> which the current functionality added with the patchset being tearing 
> down the device and CXL bridge decoders. Dan seems to be keen on not 
> doing this tear down even if the HDMs are not locked.

That's the question that makes this interesting.  What is reasoning for
leaving bios stuff around in type 2 cases? I'd definitely like 'a way'
to blow it away even if another option keeps it in place.
A bios configures for what it can see at boot not necessarily what shows
up later.  Similar cases exist in PCI such as resizeable BARs.
The OS knows a lot more about the workload than the bios ever does and
may choose to reconfigure because of hotplugged devices.

> 
> 
> What I can say is I have tested this patchset with an AMD system and 
> with the BIOS committing the HDM decoders for my device, and the first 
> time the driver loads it gets the region from the automatic discovery 
> while creating memdev, and the driver does tear down the HDMs when 
> exiting. Subsequent driver loads do the HDM configuration as this 
> patchset had been doing from day one. So all works as expected.
> 
> 
> I'm inclined to leave the functionality as it is now, and your 
> suggestion or Dan's one for keeping the HDMs, as they were configured by 
> the BIOS, when driver exits should require, IMO, a good reason behind it.

I'd definitely not make the assumption that BIOS' always do things for
good reasons. They do things because someone once thought there was
a good reason - or some other OS relied on them doing some part of setup. 


> 
> 
> > There are also the TSP / encrypted link cases where we need to be careful.
> > I have no idea if that applies here.  
> 
> 
> I would say, let's wait until this support is completed, but as far as I 
> know, this is not a requirement for current Type2 clients (sfc and jump 
> trading).

Dealing with this later works for me.  As long as it fails cleanly all good.

Jonathan


