Return-Path: <netdev+bounces-174301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3FEA5E334
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 18:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 017983A7FC5
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 17:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239C1254B02;
	Wed, 12 Mar 2025 17:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h5vqUHuD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E136253B73;
	Wed, 12 Mar 2025 17:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741802232; cv=none; b=JTWzaIlpbxHUKrektYb1i5K/xU046Cv0nVGteQ6c/5YhoiW+TiA1JKadHMpwfbrq0rcZ6G/DW2o5w/BIrI7aIz1BUyAqPfROetbXmVN+2D3rbDF5VJPCfpzOTiZ2EsKihu4sojSL8jo76Tro9T+Nmt/H8RJuLNztLoNi30YfP+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741802232; c=relaxed/simple;
	bh=0qqmqiQl6CtULMpWjUKoBa0oLGQY8gOzK/oEwfkFhDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrjv4AHsuN7dFdHycVHLglMuLgpMKoZEmIA3RDkzHwoulBntFfPZnB4XNzyTHjhqfXYbGaPSswOT6TBsTNluP9YcugfryTx/SVGY9toA+GtagYOZnzqvq4U7r83SLIiKJkivP65EamnEV8/7GN6npu83F7pcKKnloBfb7p0HqUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h5vqUHuD; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741802232; x=1773338232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0qqmqiQl6CtULMpWjUKoBa0oLGQY8gOzK/oEwfkFhDo=;
  b=h5vqUHuDnpf4sG7dP0AnBoAtWS/KdDbfjB9G4YvirHJ99YiS6IoVzHzu
   QIgrNZogJZXAnmiSIaZS4u9TLnee14SXNNZmFxfH9xlxRbtAFhyeOthfd
   xyGzAQvIpXaj5mkwTkOm8kXjND6mEy7WN1Nn2+IyT+W6XSRm5PcTpa3jv
   7UNEMGu+P0PtXIZZHCAyX/Y9GFs10DQ89xxOI8fB78aCJdwpt4p3HWftI
   YtfJNTK6f4kgZmrW2brTNTY3JU8UV3ywqrwFc2pCFiBoEGv4g+huEu9X1
   NTvARIyQCG/mGA9gGpCFx349bEgROxTW+WRGRckIt1HbTqmavYfNPUMHR
   Q==;
X-CSE-ConnectionGUID: VZfTg2PyRC6wUbY2LBn9hw==
X-CSE-MsgGUID: d49nW1BnS4Ow3XLKoEO6qQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="46679226"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="46679226"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 10:57:11 -0700
X-CSE-ConnectionGUID: EcsYRIZ4QsWPYCxNSVqRjA==
X-CSE-MsgGUID: +uRh/LPgS7ifX7R+8KfM3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="151527782"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.10])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 10:57:10 -0700
Date: Wed, 12 Mar 2025 10:57:08 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dave.jiang@intel.com, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v11 00/23] add type2 device basic support
Message-ID: <Z9HK9A6Dh3h4Ui1q@aschofie-mobl2.lan>
References: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>

On Mon, Mar 10, 2025 at 09:03:17PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>

Hi Alejandro,

Can you restore a cover letter here? 
I'm particularly looking for more context around kernel driven region
creation.

--Alison

> 
> v11 changes:
>  - Dropping the use of cxl_memdev_state and going back to using
>    cxl_dev_state.
>  - Using a helper for an accel driver to allocate its own cxl-related
>    struct embedding cxl_dev_state.
>  - Exporting the required structs in include/cxl/cxl.h for an accel
>    driver being able to know the cxl_dev_state size required in the
>    previously mentioned helper for allocation.
>  - Avoid using any struct for dpa initialization by the accel driver
>    adding a specific function for creating dpa partitions by accel
>    drivers without a mailbox.
> 
> Alejandro Lucero (23):
>   cxl: add type2 device basic support
>   sfc: add cxl support
>   cxl: move pci generic code
>   cxl: move register/capability check to driver
>   cxl: add function for type2 cxl regs setup
>   sfc: make regs setup with checking and set media ready
>   cxl: support dpa initialization without a mailbox
>   sfc: initialize dpa
>   cxl: prepare memdev creation for type2
>   sfc: create type2 cxl memdev
>   cxl: define a driver interface for HPA free space enumeration
>   fc: obtain root decoder with enough HPA free space
>   cxl: define a driver interface for DPA allocation
>   sfc: get endpoint decoder
>   cxl: make region type based on endpoint type
>   cxl/region: factor out interleave ways setup
>   cxl/region: factor out interleave granularity setup
>   cxl: allow region creation by type2 drivers
>   cxl: add region flag for precluding a device memory to be used for dax
>   sfc: create cxl region
>   cxl: add function for obtaining region range
>   sfc: update MCDI protocol headers
>   sfc: support pio mapping based on cxl
> 
>  drivers/cxl/core/core.h               |     2 +
>  drivers/cxl/core/hdm.c                |    83 +
>  drivers/cxl/core/mbox.c               |    30 +-
>  drivers/cxl/core/memdev.c             |    47 +-
>  drivers/cxl/core/pci.c                |   115 +
>  drivers/cxl/core/port.c               |     8 +-
>  drivers/cxl/core/region.c             |   411 +-
>  drivers/cxl/core/regs.c               |    39 +-
>  drivers/cxl/cxl.h                     |   112 +-
>  drivers/cxl/cxlmem.h                  |   103 +-
>  drivers/cxl/cxlpci.h                  |    23 +-
>  drivers/cxl/mem.c                     |    26 +-
>  drivers/cxl/pci.c                     |   118 +-
>  drivers/cxl/port.c                    |     5 +-
>  drivers/net/ethernet/sfc/Kconfig      |     9 +
>  drivers/net/ethernet/sfc/Makefile     |     1 +
>  drivers/net/ethernet/sfc/ef10.c       |    50 +-
>  drivers/net/ethernet/sfc/efx.c        |    15 +-
>  drivers/net/ethernet/sfc/efx_cxl.c    |   162 +
>  drivers/net/ethernet/sfc/efx_cxl.h    |    40 +
>  drivers/net/ethernet/sfc/mcdi_pcol.h  | 13645 +++++++++---------------
>  drivers/net/ethernet/sfc/net_driver.h |    12 +
>  drivers/net/ethernet/sfc/nic.h        |     3 +
>  include/cxl/cxl.h                     |   269 +
>  include/cxl/pci.h                     |    36 +
>  tools/testing/cxl/Kbuild              |     1 -
>  tools/testing/cxl/test/mock.c         |    17 -
>  27 files changed, 6186 insertions(+), 9196 deletions(-)
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
>  create mode 100644 include/cxl/cxl.h
>  create mode 100644 include/cxl/pci.h
> 
> 
> base-commit: 0a14566be090ca51a32ebdd8a8e21678062dac08
> -- 
> 2.34.1
> 
> 

