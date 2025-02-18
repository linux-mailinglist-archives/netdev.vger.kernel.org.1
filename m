Return-Path: <netdev+bounces-167355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76996A39E52
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 15:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0F33A7579
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 14:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A66269887;
	Tue, 18 Feb 2025 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="By9w66Ys"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8917D267B08;
	Tue, 18 Feb 2025 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887788; cv=none; b=OPAgSEhF7brn8HCbXNwG7kvyzLmTfObbUYb7jKuXzv3igY4B2OSdS83LRedU+DH0nqZW6yPKumlJfWJVk4LEqIFUaUo+ICkGHgAPXJqyPa8WfEoUbGOBTzKXBZjRD/Npnooq+AtgW2j3Vs8lBtAt9ymvgwyKOXrTVmtJtsZfm8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887788; c=relaxed/simple;
	bh=Kt+mFUcyvEuQyhjQU3EbrZcQ+gVBDskLBu4YZ0BgvHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSn263y3ONa9aR+reUYsXx0Gmvb9MmA8pp9zb91zQS+57je1CVaKPzx4mI4SkQBrihpZYpz3BQBvJwef2feYdgvVkvZKdm14IcESIaloEqDu/pHQ3FMBT6Yw+pExUzIp+tBNIhqyi6wdZPZLBYK1zlhEkBjzVHvXZ1ljxj1x+S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=By9w66Ys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC5DC4CEE2;
	Tue, 18 Feb 2025 14:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739887788;
	bh=Kt+mFUcyvEuQyhjQU3EbrZcQ+gVBDskLBu4YZ0BgvHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=By9w66YsXPVJ6QYomjo+ojS3dAJmQ+TxWhWs315EW4UIJaS3/JvBG/wwB2FT7MOpc
	 q25Apzrbd0QzQ3q7jftQCaczJRxnlA1Oa691AMKotNtVFTFNTRapbhd7XbE3aTGJ1u
	 PK2CGJGrbFJMNWt5r5oP74nwlYFb27/8BTwfobL0lns4rurbIQb0w+9p70upPvsJbd
	 AfPAORwcqavbhTn6x10qFKYr+759Fk1OwOAWdRtDNhBWi3GhxXRAfmxmcppdXFbnam
	 ae2UPBk/pT4WZPBXjoCI0OLunDofoJYeItsfFtBbi0kwICgrg51tZpEh140ZPK8YiT
	 Kl7D/fGv6Is/A==
Date: Tue, 18 Feb 2025 14:09:44 +0000
From: Simon Horman <horms@kernel.org>
To: Alejandro Lucero Palau <alucerop@amd.com>
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com
Subject: Re: [PATCH v10 16/26] cxl: define a driver interface for DPA
 allocation
Message-ID: <20250218140944.GZ1615191@kernel.org>
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-17-alucerop@amd.com>
 <20250207134605.GV554665@kernel.org>
 <2feddf43-7d86-4fc2-9817-3d0e51152b98@amd.com>
 <20250218133459.GX1615191@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218133459.GX1615191@kernel.org>

On Tue, Feb 18, 2025 at 01:34:59PM +0000, Simon Horman wrote:
> On Mon, Feb 17, 2025 at 02:08:28PM +0000, Alejandro Lucero Palau wrote:
> > 
> > On 2/7/25 13:46, Simon Horman wrote:
> > > On Wed, Feb 05, 2025 at 03:19:40PM +0000, alucerop@amd.com wrote:
> > > > From: Alejandro Lucero <alucerop@amd.com>
> > > > 
> > > > Region creation involves finding available DPA (device-physical-address)
> > > > capacity to map into HPA (host-physical-address) space. Define an API,
> > > > cxl_request_dpa(), that tries to allocate the DPA memory the driver
> > > > requires to operate. The memory requested should not be bigger than the
> > > > max available HPA obtained previously with cxl_get_hpa_freespace.
> > > > 
> > > > Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
> > > > 
> > > > Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> > > > ---
> > > >   drivers/cxl/core/hdm.c | 83 ++++++++++++++++++++++++++++++++++++++++++
> > > >   include/cxl/cxl.h      |  4 ++
> > > >   2 files changed, 87 insertions(+)
> > > > 
> > > > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > > > index af025da81fa2..cec2c7dcaf3a 100644
> > > > --- a/drivers/cxl/core/hdm.c
> > > > +++ b/drivers/cxl/core/hdm.c
> > > > @@ -3,6 +3,7 @@
> > > >   #include <linux/seq_file.h>
> > > >   #include <linux/device.h>
> > > >   #include <linux/delay.h>
> > > > +#include <cxl/cxl.h>
> > > Hi Alejandro,
> > 
> > 
> > Hi Simon,
> > 
> > 
> > > I think that linux/range.h should be included in cxl.h, or if not here.
> > > This is because on allmodconfigs for both arm and arm64 I see:
> > > 
> > > In file included from drivers/cxl/core/hdm.c:6:
> > > ./include/cxl/cxl.h:67:16: error: field has incomplete type 'struct range'
> > >     67 |                 struct range range;
> > >        |                              ^
> > > ./include/linux/memory_hotplug.h:247:8: note: forward declaration of 'struct range'
> > >    247 | struct range arch_get_mappable_range(void);
> > >        |        ^
> > > 1 error generated.
> > > 
> > > ...
> > 
> > 
> > I do not understand then why the robot does not trigger an issue when
> > building this code for those archs.
> > 
> > And where does that second struct range reference in memory_hotplug.h come
> > from? Is that related to cxl.h?
> 
> Thanks, let me try to reproduce this again.

Hi Alejandro,

I tried testing this with an allmodconfig build for arm64 [*].

And this time I see this manifesting slightly differently.  I can follow-up
on why it is different (probably I messed something up when first reporting
the issue). But I am certainly seeing an issue there today.

...
  CC [M]  drivers/cxl/core/hdm.o
In file included from drivers/cxl/core/hdm.c:6:
./include/cxl/cxl.h:67:30: error: field 'range' has incomplete type
   67 |                 struct range range;
      |                              ^~~~~
...

[*] This is with patches 1 - 16 of this series applied on top of next-20250205.

    I am using the GCC 14.2.0 toolchain from [1] to cross compile on x86_64.
    Like this:

    PATH=/tmp/gcc-14.2.0-nolibc/aarch64-linux/bin:$PATH
    ARCH=arm64 CROSS_COMPILE=aarch64-linux- make allmodconfig
    ARCH=arm64 CROSS_COMPILE=aarch64-linux- make

[1] https://mirrors.edge.kernel.org/pub/tools/crosstool/


