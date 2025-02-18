Return-Path: <netdev+bounces-167343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E87A3A39DC3
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 14:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1107417A5DD
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 13:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC0A269D0B;
	Tue, 18 Feb 2025 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZJhhoCN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C565269AE6;
	Tue, 18 Feb 2025 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885704; cv=none; b=kOzi0/Jue7NUKmkG7fyWbI7KbqmVVikduq0bCH7j9BUsWHMrHDi2ZmUFKveLt1/6Sb23atzmYOp/2xqRlKdgzNA/RUJ7K/P3eozM8N2aYRSkwFnFmh17YyfugzxvCrNvU81wBgMieiWDRU+lPDJ3HRIamrxjTIo+Cg+mYXP+fFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885704; c=relaxed/simple;
	bh=UOJ5cNXT0cALVsou9bOjNRvYSHM+3SoBH7PDMH7zDMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGev5+GbOjf1Z8zOOPI2AM14pYt4Hr6gJTNrl2Jg1tm7YCw1tbKfQAMsk6Yc8vGnTLhav7bZWM6CglMMpG+7Ri2YVfI+1OqDOsXfzKJ1IEd0UlKEaQQoCWXqfHp/aL2nkChnbly/ytuZn0I5lQAKqZj+DNAxTsTD7FhcOVWqRD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZJhhoCN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2617C4CEE6;
	Tue, 18 Feb 2025 13:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739885703;
	bh=UOJ5cNXT0cALVsou9bOjNRvYSHM+3SoBH7PDMH7zDMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LZJhhoCN9BFI/rEnJrEnEYRYPS5yYiHLkCcgDoSJTM3LEcP4jaqtZRdVRICsej2Oj
	 xzIIJSq65UaSeBfb03/uODUHEb5xVmIkMLDmIN6ft5KawwMAnhMdc0wFTqV7o+RfdY
	 wEuGi+mNyUUy+qXQa7sjT1j5p1fMlpdxY4aMmjE5JqaG5BJYIb/SGdm/MKSdD4EemQ
	 cyAmsPzCwP9hW50kf2fpVUFmtLS5zNBt1OZ1d3rZmT+33cBiy6BD/KialqvVPTIBQk
	 XLX6N5PzxALjItOB5THEuF4qe+4XJc3rQxnHDRl9tlW0aoaaiXDtjLRRw9Py3xtmnx
	 yCT7pIROhJ0TA==
Date: Tue, 18 Feb 2025 13:34:59 +0000
From: Simon Horman <horms@kernel.org>
To: Alejandro Lucero Palau <alucerop@amd.com>
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com
Subject: Re: [PATCH v10 16/26] cxl: define a driver interface for DPA
 allocation
Message-ID: <20250218133459.GX1615191@kernel.org>
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-17-alucerop@amd.com>
 <20250207134605.GV554665@kernel.org>
 <2feddf43-7d86-4fc2-9817-3d0e51152b98@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2feddf43-7d86-4fc2-9817-3d0e51152b98@amd.com>

On Mon, Feb 17, 2025 at 02:08:28PM +0000, Alejandro Lucero Palau wrote:
> 
> On 2/7/25 13:46, Simon Horman wrote:
> > On Wed, Feb 05, 2025 at 03:19:40PM +0000, alucerop@amd.com wrote:
> > > From: Alejandro Lucero <alucerop@amd.com>
> > > 
> > > Region creation involves finding available DPA (device-physical-address)
> > > capacity to map into HPA (host-physical-address) space. Define an API,
> > > cxl_request_dpa(), that tries to allocate the DPA memory the driver
> > > requires to operate. The memory requested should not be bigger than the
> > > max available HPA obtained previously with cxl_get_hpa_freespace.
> > > 
> > > Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
> > > 
> > > Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> > > ---
> > >   drivers/cxl/core/hdm.c | 83 ++++++++++++++++++++++++++++++++++++++++++
> > >   include/cxl/cxl.h      |  4 ++
> > >   2 files changed, 87 insertions(+)
> > > 
> > > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > > index af025da81fa2..cec2c7dcaf3a 100644
> > > --- a/drivers/cxl/core/hdm.c
> > > +++ b/drivers/cxl/core/hdm.c
> > > @@ -3,6 +3,7 @@
> > >   #include <linux/seq_file.h>
> > >   #include <linux/device.h>
> > >   #include <linux/delay.h>
> > > +#include <cxl/cxl.h>
> > Hi Alejandro,
> 
> 
> Hi Simon,
> 
> 
> > I think that linux/range.h should be included in cxl.h, or if not here.
> > This is because on allmodconfigs for both arm and arm64 I see:
> > 
> > In file included from drivers/cxl/core/hdm.c:6:
> > ./include/cxl/cxl.h:67:16: error: field has incomplete type 'struct range'
> >     67 |                 struct range range;
> >        |                              ^
> > ./include/linux/memory_hotplug.h:247:8: note: forward declaration of 'struct range'
> >    247 | struct range arch_get_mappable_range(void);
> >        |        ^
> > 1 error generated.
> > 
> > ...
> 
> 
> I do not understand then why the robot does not trigger an issue when
> building this code for those archs.
> 
> And where does that second struct range reference in memory_hotplug.h come
> from? Is that related to cxl.h?

Thanks, let me try to reproduce this again.

