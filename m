Return-Path: <netdev+bounces-245512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3252CCCF841
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 12:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32049304B004
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 11:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B231C1DB551;
	Fri, 19 Dec 2025 11:02:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369B91391;
	Fri, 19 Dec 2025 11:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766142145; cv=none; b=pM8PGCcndxuc0nyZpyXEizzpE0C6wdCxaMj916x2b2LC/afAfMNarOXWpQ9Y00+VYvvA6HIo67qOF0ukFbD6mefYPVxwHaqmT9pE1PhprC5r0qP3H2+zEo69FysZegRT2gShLVee3JVM1Ttc7JmeU1Z+khZ2l57lqT2LYQNAfww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766142145; c=relaxed/simple;
	bh=mYNc9wY1ehLz6KUVsIPjnaF9fPn1y8Uq0YhGUO8eZRc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uGPPgsDjG9d8gOIg0p9krn59c0lN6aXEV82DBn7nNs1GB3Y2QTalzkGoTv92kfHM+E6PG3uEfGw+JyUCbhOJ2iKrfG6+UnB3PZKVHaXf1/+UbA6v+/dkyHp0mpFI7n7RMbJSFsqD/maB93JrG6m2OJ3LFTG/9iJyB4grxi5cJb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dXl3H4MCyzJ4681;
	Fri, 19 Dec 2025 19:01:47 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 1C9C040539;
	Fri, 19 Dec 2025 19:02:20 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 19 Dec
 2025 11:02:19 +0000
Date: Fri, 19 Dec 2025 11:02:17 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
Subject: Re: [PATCH v22 11/25] cxl/hdm: Add support for getting region from
 committed decoder
Message-ID: <20251219110217.000063b0@huawei.com>
In-Reply-To: <1e98adcc-feeb-41cb-b1fe-618597cb0be4@amd.com>
References: <20251205115248.772945-1-alejandro.lucero-palau@amd.com>
	<20251205115248.772945-12-alejandro.lucero-palau@amd.com>
	<20251215135047.000018f7@huawei.com>
	<f56f7a6b-7931-4264-8d42-50603ce81cba@amd.com>
	<20251218150309.00006837@huawei.com>
	<1e98adcc-feeb-41cb-b1fe-618597cb0be4@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 18 Dec 2025 15:27:29 +0000
Alejandro Lucero Palau <alucerop@amd.com> wrote:

> On 12/18/25 15:03, Jonathan Cameron wrote:
> > On Thu, 18 Dec 2025 11:52:58 +0000
> > Alejandro Lucero Palau <alucerop@amd.com> wrote:
> >  
> >> Hi Jonathan,
> >>
> >>
> >> On 12/15/25 13:50, Jonathan Cameron wrote:  
> >>> On Fri, 5 Dec 2025 11:52:34 +0000
> >>> <alejandro.lucero-palau@amd.com> wrote:
> >>>     
> >>>> From: Alejandro Lucero <alucerop@amd.com>
> >>>>
> >>>> A Type2 device configured by the BIOS can already have its HDM
> >>>> committed. Add a cxl_get_committed_decoder() function for cheking  
> >>> checking if this is so after memdev creation.
> >>>     
> >>>> so after memdev creation. A CXL region should have been created
> >>>> during memdev initialization, therefore a Type2 driver can ask for
> >>>> such a region for working with the HPA. If the HDM is not committed,
> >>>> a Type2 driver will create the region after obtaining proper HPA
> >>>> and DPA space.
> >>>>
> >>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>  
> >>> Hi Alejandro,
> >>>
> >>> I'm in two minds about this.  In general there are devices that have
> >>> been configured by the BIOS because they are already in use. I'm not sure
> >>> the driver you are working with here is necessarily set up to survive
> >>> that sort of live setup without interrupting data flows.  
> >>
> >> This is not mainly about my driver/device but something PJ and Dan agree
> >> on support along this type2 patchset.
> >>
> >> You can see the v21 discussions, but basically PJ can not have his
> >> driver using the committed decoders from BIOS. So this change addresses
> >> that situation which my driver/device can also benefit from as current
> >> BIOS available is committing decoders regardless of UEFI flags like
> >> EFI_RESERVED_TYPE.
> >>
> >>
> >> Neither in my case nor in PJ case the device will be in use before
> >> kernel is executing, although PJ should confirm this.  
> > There was some discussion in that thread of whether the decoders are locked.
> > If they aren't (and if the device is not in use, or some other hard constraint
> > isn't requiring it, in my view they definitely shouldn't be!) I'd at least
> > like to consider the option of a 'cleanup pass' to tear them down and give
> > the driver a clean slate to build on. Kind of similar to what we do in
> > making PCI reeumerate in the kernel if we really don't like what the bios did.  
> 
> 
> I do not mind to support that option, but could we do it as a follow-up?

Sure. I'm wondering a bit on whether it's a global flag similar to the
one for full PCI bus reenumeration or more like the stuff that repairs corners
of PCI enumeration if the kernel doesn't like what it finds.

> 
> 
> > Might not be possible if there is another higher numbered decoder in use
> > though :(
> >  
> >>  
> >>> If it is fair enough to support this, otherwise my inclination is tear
> >>> down whatever the bios did and start again (unless locked - in which
> >>> case go grumble at your BIOS folk). Reasoning being that we then only
> >>> have to handle the equivalent of the hotplug flow in both cases rather
> >>> than having to handle 2.  
> >>
> >> Well, the automatic discovery region used for Type3 can be reused for
> >> Type2 in this scenario, so we do not need to tear down what the BIOS
> >> did. However, the argument is what we should do when the driver exits
> >> which the current functionality added with the patchset being tearing
> >> down the device and CXL bridge decoders. Dan seems to be keen on not
> >> doing this tear down even if the HDMs are not locked.  
> > That's the question that makes this interesting.  What is reasoning for
> > leaving bios stuff around in type 2 cases? I'd definitely like 'a way'
> > to blow it away even if another option keeps it in place.
> > A bios configures for what it can see at boot not necessarily what shows
> > up later.  Similar cases exist in PCI such as resizeable BARs.
> > The OS knows a lot more about the workload than the bios ever does and
> > may choose to reconfigure because of hotplugged devices.  
> 
> 
> The main reason seems to be an assumption from BIOSes that only 
> advertise CFMWS is there exists a CXL.mem enabled ... with the CXL Host 

Just to confirm, do you mean CXL.mem is enabled for the device? I.e.
memory is in use at boot?  If that config bit is set then we have
to leave it alone as we have very little idea what traffic is in flight.
Or just that there is some memory advertised by the device.

> Bridge CFMWS being equal to the total CXL.mem advertises by those 
> devices discovered. This is something I have been talking about in 
> discord and internally because I think that creates problems with 
> hotplugging and future FAM support, or maybe current DCD.

For DCD it shouldn't matter as long as there is space for all the DC
regions.  Whether that is backed by the device shouldn't be something
the bios cares about.  For the others fully agree its a wrong bios
writer assumption that we should try to get them to stop making!

> 
> 
> One case, theoretical but I think quite possible, is a device requiring 
> the CXL.mem not using the full capacity in all modes, likely because 
> that device memory used for other purposes and kept hidden from the 
> host. So the one knowing what to do should be the driver and dependent 
> on the device and likely some other data maybe even configurable from 
> user space.

Yes. This is kind of similar to some of the things that happen with
resizeable BARs in PCI.

> 
> 
> So yes, I agree with you that the kernel should be able to do things far 
> better than the BIOS ...

I'm sure everyone reading this email agrees policy in the OS where possible
not the BIOS :)

Jonathan


