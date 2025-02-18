Return-Path: <netdev+bounces-167341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FBBA39DA9
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 14:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD1F61898ABC
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 13:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7ED2698B9;
	Tue, 18 Feb 2025 13:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESWC4G6R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55782269890;
	Tue, 18 Feb 2025 13:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885552; cv=none; b=RY2ucnp/Kc1N2yVCqDHoPRp+SDaOhWlCgBXrl2rcXwoGtt7UT6n1HyfEYgbhl9HIRTCBprNk15ZL2YxX/eLH/mjjvL+P59QujI1emXMFypWvwlvJWznDafZglrvv9nQyR0d3IwuIqlXtM2Hh8xgnFQ8iA8XRImXdNJMwm3Y3viE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885552; c=relaxed/simple;
	bh=DPfGQkoaGGA7K17sBH7fBSpRKAqhiuP0N7V+15GQphA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkaksKMRHu+pYRrvhl9ZamWQ6/KNy62ML4ZvU561aO72pmPr+qq6OWVSzW4lYWyKCOXGfCKTkJ10WJf37EpHoF9RkG5kohyxMO5EjC0e3A2TrhtEmQyfL/MsFnCfIovx7j78yBPLM3zdVF37YFMkiICdRIr6NlbhoOnCJK6bQSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESWC4G6R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D167FC4CEE2;
	Tue, 18 Feb 2025 13:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739885551;
	bh=DPfGQkoaGGA7K17sBH7fBSpRKAqhiuP0N7V+15GQphA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ESWC4G6Romjw6Pv/gO2Hy9zQInAVopYDpFnb7BVKi014JquWmNOFtPsdpCe83vzwZ
	 e7tnieDLWisVcNxmJyPOkEmttiiHSoTxNOUkiHbFKWDzOPsGD4/fjiPyYCbIgAL7j6
	 r61C10zQUaixkf1j23E4K7y+dh07zkA/cGdMYxjSxNtOXgQhw4f9ji6davVvpkEAbl
	 B0jbhX4wRo8qWBLx4VTK9aqc52+6A/lqcHYcAiC/eb8hCNd+XTL4jPegus6gbjoZvh
	 RomL4ZhhVS9yc2NNI90pjzceVugHuVov70nqkPmp9vp2gzY/yBgNN5aElHOKGoN7AX
	 6cj2dWTFlypeg==
Date: Tue, 18 Feb 2025 13:32:27 +0000
From: Simon Horman <horms@kernel.org>
To: Alejandro Lucero Palau <alucerop@amd.com>
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com
Subject: Re: [PATCH v10 02/26] sfc: add basic cxl initialization
Message-ID: <20250218133227.GW1615191@kernel.org>
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-3-alucerop@amd.com>
 <20250207130342.GS554665@kernel.org>
 <679b8737-8655-456e-949a-63db07a71d2b@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <679b8737-8655-456e-949a-63db07a71d2b@amd.com>

On Mon, Feb 17, 2025 at 01:11:41PM +0000, Alejandro Lucero Palau wrote:
> 
> On 2/7/25 13:03, Simon Horman wrote:
> > On Wed, Feb 05, 2025 at 03:19:26PM +0000, alucerop@amd.com wrote:
> > > From: Alejandro Lucero <alucerop@amd.com>
> > > 
> > > Create a cxl_memdev_state with CXL_DEVTYPE_DEVMEM, aka CXL Type2 memory
> > > device.
> > > 
> > > Make sfc CXL initialization dependent on kernel CXL configuration.
> > > 
> > > Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> > > ---
> > >   drivers/net/ethernet/sfc/Kconfig      |  5 +++
> > >   drivers/net/ethernet/sfc/Makefile     |  1 +
> > >   drivers/net/ethernet/sfc/efx.c        | 16 ++++++-
> > >   drivers/net/ethernet/sfc/efx_cxl.c    | 60 +++++++++++++++++++++++++++
> > >   drivers/net/ethernet/sfc/efx_cxl.h    | 40 ++++++++++++++++++
> > >   drivers/net/ethernet/sfc/net_driver.h | 10 +++++
> > >   6 files changed, 131 insertions(+), 1 deletion(-)
> > >   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
> > >   create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
> > > 
> > > diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
> > > index 3eb55dcfa8a6..0ce4a9cd5590 100644
> > > --- a/drivers/net/ethernet/sfc/Kconfig
> > > +++ b/drivers/net/ethernet/sfc/Kconfig
> > > @@ -65,6 +65,11 @@ config SFC_MCDI_LOGGING
> > >   	  Driver-Interface) commands and responses, allowing debugging of
> > >   	  driver/firmware interaction.  The tracing is actually enabled by
> > >   	  a sysfs file 'mcdi_logging' under the PCI device.
> > > +config SFC_CXL
> > > +	bool "Solarflare SFC9100-family CXL support"
> > > +	depends on SFC && CXL_BUS && !(SFC=y && CXL_BUS=m)
> > > +	depends on CXL_BUS >= CXL_BUS
> > Hi Alejandro,
> > 
> > I'm confused by the intent of the line above.
> > Could you clarify?
> 
> 
> Dan original comments will do:
> 
> https://lore.kernel.org/all/677ddb432dafe_2aff429488@dwillia2-xfh.jf.intel.com.notmuch/

Thanks, that makes things a bit clearer.
But do you mean:

 depends on CXL_BUS >= SFC

Rather than:

 depends on CXL_BUS >= CXL_BUS

Because the line above appears to be a truism.

> 
> 
> > > +	default SFC
> > >   source "drivers/net/ethernet/sfc/falcon/Kconfig"
> > >   source "drivers/net/ethernet/sfc/siena/Kconfig"
> > ...
> 

