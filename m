Return-Path: <netdev+bounces-189904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E013BAB4758
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 00:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 454D83A9081
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 22:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F1B255F5F;
	Mon, 12 May 2025 22:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iqfTbI2Q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02D1186A;
	Mon, 12 May 2025 22:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747089392; cv=none; b=BFca+ezFFwWjbOy1Y+6ErMG09EvrwBSjMOIGbRy+rnHQGNXesXC71x34FXoie5hGPNaQU9BoiyaKAfG8Dh/yWLb7508oeVGHtKX3kqdJy96hyn/UrVCcmXrL7cBVhrF4TfJe33ML1xhjWSWqvhdxD/hur2M3gz1r7zLEhbPgvQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747089392; c=relaxed/simple;
	bh=hNfw0UtyFv6qJKeD8A6LfhjTbW8dT4O5IgZCNGKSOOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MiwRdbLwh3UwGfjDtQ9veqgK5pKVsK2Ym7Fco3tvQVSYmM3AJ3MdZz4bON/0952+UoCTtDgsVnnAnITFjwnCWb0QXeXbhV7LFepyDd+CblPPQ0lszl9TYdxq7XUOYr9FaK8LbNuedzyzAy8gjDTgD+OcSvhc4yp2AhiACils2Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iqfTbI2Q; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747089391; x=1778625391;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hNfw0UtyFv6qJKeD8A6LfhjTbW8dT4O5IgZCNGKSOOM=;
  b=iqfTbI2Q3JjtGXT/qiYXYdQ74gf3MRpcPoLlRbWgvIouUFcXiA5X+4fx
   EK2UXRD+hgSFkD4qODWtTdkhBUQcMmGU3bb5xzfqTV0kSbbyu0qi/uQKl
   FVg7io2UpFiHFv6zfDrR5ZSddwxajQBoAluyOW4L0bKzXEdEt1KFr5d74
   Lkk9AkTYeGfVdlv0PnoUOToEQbWZIPbVBdha+iGFJu55Wy2Lo/fr0bF4V
   l+3bUtnyhbFRK7FX4Lhqex2azpfZfTnNhQ0U4OM98gHEO78eh9DfWv46r
   Dr8nPIwcZ/Qc+VxgOk9bJVIGOfKTbDnyioUy0O/cGGQItCEAltiHuKMWa
   w==;
X-CSE-ConnectionGUID: adK6J5Z3RoSmiv95gcHdFQ==
X-CSE-MsgGUID: zEpThNFOTymHrHhHsvHO3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="66451340"
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="66451340"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 15:36:30 -0700
X-CSE-ConnectionGUID: Zp7DIvHMTbODE3gwGNZo4Q==
X-CSE-MsgGUID: 4c/d15JeTje4fhpNy4rQ4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,283,1739865600"; 
   d="scan'208";a="168597424"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO [10.124.220.233]) ([10.124.220.233])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 15:36:30 -0700
Message-ID: <59fa7e55-f563-40f9-86aa-1873806e76cc@intel.com>
Date: Mon, 12 May 2025 15:36:27 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 00/22] Type2 device basic support
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/12/25 9:10 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> v15 changes:
>  - remove reference to unused header file (Jonathan Cameron)
>  - add proper kernel docs to exported functions (Alison Schofield)
>  - using an array to map the enums to strings (Alison Schofield)
>  - clarify comment when using bitmap_subset (Jonathan Cameron)
>  - specify link to type2 support in all patches (Alison Schofield)
> 
>   Patches changed (minor): 4, 11
>

Hi Alejandro,
Tried to pull this series using b4. Noticed couple things.
1. Can you run checkpatch on the entire series and fix any issues?
2. Can you rebase against v6.15-rc4? I think there are some conflicts against the fixes went in rc4.

Thanks!
 
> v14 changes:
>  - static null initialization of bitmaps (Jonathan Cameron)
>  - Fixing cxl tests (Alison Schofield)
>  - Fixing robot compilation problems
> 
>   Patches changed (minor): 1, 4, 6, 13
> 
> v13 changes:
>  - using names for headers checking more consistent (Jonathan Cameron)
>  - using helper for caps bit setting (Jonathan Cameron)
>  - provide generic function for reporting missing capabilities (Jonathan Cameron)
>  - rename cxl_pci_setup_memdev_regs to cxl_pci_accel_setup_memdev_regs (Jonathan Cameron)
>  - cxl_dpa_info size to be set by the Type2 driver (Jonathan Cameron)
>  - avoiding rc variable when possible (Jonathan Cameron)
>  - fix spelling (Simon Horman)
>  - use scoped_guard (Dave Jiang)
>  - use enum instead of bool (Dave Jiang)
>  - dropping patch with hardware symbols
>  
> v12 changes:
>  - use new macro cxl_dev_state_create in pci driver (Ben Cheatham)
>  - add public/private sections in now exported cxl_dev_state struct (Ben
>    Cheatham)
>  - fix cxl/pci.h regarding file name for checking if defined
>  - Clarify capabilities found vs expected in error message. (Ben
>    Cheatham)
>  - Clarify new CXL_DECODER_F flag (Ben Cheatham)
>  - Fix changes about cxl memdev creation support moving code to the
>    proper patch. (Ben Cheatham)
>  - Avoid debug and function duplications (Ben Cheatham)
>  - Fix robot compilation error reported by Simon Horman as well.
>  - Add doc about new param in clx_create_region (Simon Horman).
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
> v10 changes:
>  - Using cxl_memdev_state instead of cxl_dev_state for type2 which has a
>    memory after all and facilitates the setup.
>  - Adapt core for using cxl_memdev_state allowing accel drivers to work
>    with them without further awareness of internal cxl structs.
>  - Using last DPA changes for creating DPA partitions with accel driver
>    hardcoding mds values when no mailbox.
>  - capabilities not a new field but built up when current register maps
>    is performed and returned to the caller for checking.
>  - HPA free space supporting interleaving.
>  - DPA free space droping max-min for a simple alloc size.
> 
> v9 changes:
>  - adding forward definitions (Jonathan Cameron)
>  - using set_bit instead of bitmap_set (Jonathan Cameron)
>  - fix rebase problem (Jonathan Cameron)
>  - Improve error path (Jonathan Cameron)
>  - fix build problems with cxl region dependency (robot)
>  - fix error path (Simon Horman)
> 
> v8 changes:
>  - Change error path labeling inside sfc cxl code (Edward Cree)
>  - Properly handling checks and error in sfc cxl code (Simon Horman)
>  - Fix bug when checking resource_size (Simon Horman)
>  - Avoid bisect problems reordering patches (Edward Cree)
>  - Fix buffer allocation size in sfc (Simon Horman)
> 
> v7 changes:
> 
>  - fixing kernel test robot complains
>  - fix type with Type3 mandatory capabilities (Zhi Wang)
>  - optimize code in cxl_request_resource (Kalesh Anakkur Purayil)
>  - add sanity check when dealing with resources arithmetics (Fan Ni)
>  - fix typos and blank lines (Fan Ni)
>  - keep previous log errors/warnings in sfc driver (Martin Habets)
>  - add WARN_ON_ONCE if region given is NULL
> 
> v6 changes:
> 
>  - update sfc mcdi_pcol.h with full hardware changes most not related to 
>    this patchset. This is an automatic file created from hardware design
>    changes and not touched by software. It is updated from time to time
>    and it required update for the sfc driver CXL support.
>  - remove CXL capabilities definitions not used by the patchset or
>    previous kernel code. (Dave Jiang, Jonathan Cameron)
>  - Use bitmap_subset instead of reinventing the wheel ... (Ben Cheatham)
>  - Use cxl_accel_memdev for new device_type created (Ben Cheatham)
>  - Fix construct_region use of rwsem (Zhi Wang)
>  - Obtain region range instead of region params (Allison Schofield, Dave
>    Jiang)
> 
> v5 changes:
> 
>  - Fix SFC configuration based on kernel CXL configuration
>  - Add subset check for capabilities.
>  - fix region creation when HDM decoders programmed by firmware/BIOS (Ben
>    Cheatham)
>  - Add option for creating dax region based on driver decission (Ben
>    Cheatham)
>  - Using sfc probe_data struct for keeping sfc cxl data
> 
> v4 changes:
>   
>  - Use bitmap for capabilities new field (Jonathan Cameron)
> 
>  - Use cxl_mem attributes for sysfs based on device type (Dave Jian)
> 
>  - Add conditional cxl sfc compilation relying on kernel CXL config (kernel test robot)
> 
>  - Add sfc changes in different patches for facilitating backport (Jonathan Cameron)
> 
>  - Remove patch for dealing with cxl modules dependencies and using sfc kconfig plus
>    MODULE_SOFTDEP instead.
> 
> v3 changes:
> 
>  - cxl_dev_state not defined as opaque but only manipulated by accel drivers
>    through accessors.
> 
>  - accessors names not identified as only for accel drivers.
> 
>  - move pci code from pci driver (drivers/cxl/pci.c) to generic pci code
>    (drivers/cxl/core/pci.c).
> 
>  - capabilities field from u8 to u32 and initialised by CXL regs discovering
>    code.
> 
>  - add capabilities check and removing current check by CXL regs discovering
>    code.
> 
>  - Not fail if CXL Device Registers not found. Not mandatory for Type2.
> 
>  - add timeout in acquire_endpoint for solving a race with the endpoint port
>    creation.
> 
>  - handle EPROBE_DEFER by sfc driver.
> 
>  - Limiting interleave ways to 1 for accel driver HPA/DPA requests.
> 
>  - factoring out interleave ways and granularity helpers from type2 region
>    creation patch.
> 
>  - restricting region_creation for type2 to one endpoint decoder.
> 
>  - add accessor for release_resource.
> 
>  - handle errors and errors messages properly.
> 
> 
> v2 changes:
> 
> I have removed the introduction about the concerns with BIOS/UEFI after the
> discussion leading to confirm the need of the functionality implemented, at
> least is some scenarios.
> 
> There are two main changes from the RFC:
> 
> 1) Following concerns about drivers using CXL core without restrictions, the CXL
> struct to work with is opaque to those drivers, therefore functions are
> implemented for modifying or reading those structs indirectly.
> 
> 2) The driver for using the added functionality is not a test driver but a real
> one: the SFC ethernet network driver. It uses the CXL region mapped for PIO
> buffers instead of regions inside PCIe BARs.
> 
> 
> 
> RFC:
> 
> Current CXL kernel code is focused on supporting Type3 CXL devices, aka memory
> expanders. Type2 CXL devices, aka device accelerators, share some functionalities
> but require some special handling.
> 
> First of all, Type2 are by definition specific to drivers doing something and not just
> a memory expander, so it is expected to work with the CXL specifics. This implies the CXL
> setup needs to be done by such a driver instead of by a generic CXL PCI driver
> as for memory expanders. Most of such setup needs to use current CXL core code
> and therefore needs to be accessible to those vendor drivers. This is accomplished
> exporting opaque CXL structs and adding and exporting functions for working with
> those structs indirectly.
> 
> Some of the patches are based on a patchset sent by Dan Williams [1] which was just
> partially integrated, most related to making things ready for Type2 but none
> related to specific Type2 support. Those patches based on Dan´s work have Dan´s
> signing as co-developer, and a link to the original patch.
> 
> A final note about CXL.cache is needed. This patchset does not cover it at all,
> although the emulated Type2 device advertises it. From the kernel point of view
> supporting CXL.cache will imply to be sure the CXL path supports what the Type2
> device needs. A device accelerator will likely be connected to a Root Switch,
> but other configurations can not be discarded. Therefore the kernel will need to
> check not just HPA, DPA, interleave and granularity, but also the available
> CXL.cache support and resources in each switch in the CXL path to the Type2
> device. I expect to contribute to this support in the following months, and
> it would be good to discuss about it when possible.
> 
> [1] https://lore.kernel.org/linux-cxl/98b1f61a-e6c2-71d4-c368-50d958501b0c@intel.com/T/
> 
> Alejandro Lucero (22):
>   cxl: Add type2 device basic support
>   sfc: add cxl support
>   cxl: Move pci generic code
>   cxl: Move register/capability check to driver
>   cxl: Add function for type2 cxl regs setup
>   sfc: make regs setup with checking and set media ready
>   cxl: Support dpa initialization without a mailbox
>   sfc: initialize dpa
>   cxl: Prepare memdev creation for type2
>   sfc: create type2 cxl memdev
>   cxl: Define a driver interface for HPA free space enumeration
>   sfc: obtain root decoder with enough HPA free space
>   cxl: Define a driver interface for DPA allocation
>   sfc: get endpoint decoder
>   cxl: Make region type based on endpoint type
>   cxl/region: Factor out interleave ways setup
>   cxl/region: Factor out interleave granularity setup
>   cxl: Allow region creation by type2 drivers
>   cxl: Add region flag for precluding a device memory to be used for dax
>   sfc: create cxl region
>   cxl: Add function for obtaining region range
>   sfc: support pio mapping based on cxl
> 
>  drivers/cxl/core/core.h               |   2 +
>  drivers/cxl/core/hdm.c                |  86 +++++
>  drivers/cxl/core/mbox.c               |  37 ++-
>  drivers/cxl/core/memdev.c             |  47 ++-
>  drivers/cxl/core/pci.c                | 162 ++++++++++
>  drivers/cxl/core/port.c               |   8 +-
>  drivers/cxl/core/region.c             | 433 +++++++++++++++++++++++---
>  drivers/cxl/core/regs.c               |  40 ++-
>  drivers/cxl/cxl.h                     | 111 +------
>  drivers/cxl/cxlmem.h                  | 103 +-----
>  drivers/cxl/cxlpci.h                  |  23 +-
>  drivers/cxl/mem.c                     |  25 +-
>  drivers/cxl/pci.c                     | 111 ++-----
>  drivers/cxl/port.c                    |   5 +-
>  drivers/net/ethernet/sfc/Kconfig      |  10 +
>  drivers/net/ethernet/sfc/Makefile     |   1 +
>  drivers/net/ethernet/sfc/ef10.c       |  50 ++-
>  drivers/net/ethernet/sfc/efx.c        |  15 +-
>  drivers/net/ethernet/sfc/efx_cxl.c    | 159 ++++++++++
>  drivers/net/ethernet/sfc/efx_cxl.h    |  40 +++
>  drivers/net/ethernet/sfc/net_driver.h |  12 +
>  drivers/net/ethernet/sfc/nic.h        |   3 +
>  include/cxl/cxl.h                     | 292 +++++++++++++++++
>  include/cxl/pci.h                     |  36 +++
>  tools/testing/cxl/Kbuild              |   1 -
>  tools/testing/cxl/test/mem.c          |   3 +-
>  tools/testing/cxl/test/mock.c         |  17 -
>  27 files changed, 1415 insertions(+), 417 deletions(-)
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>  create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
>  create mode 100644 include/cxl/cxl.h
>  create mode 100644 include/cxl/pci.h
> 
> 
> base-commit: a223ce195741ca4f1a0e1a44f3e75ce5662b6c06


