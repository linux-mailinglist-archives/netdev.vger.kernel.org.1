Return-Path: <netdev+bounces-273694-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFPhAG/2y2nlMwYAu9opvQ
	(envelope-from <netdev+bounces-273694-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 18:29:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBE936CA25
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 18:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2097530470FB
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE24430E0DC;
	Tue, 31 Mar 2026 16:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hv/rzxlp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753FD3D75D9;
	Tue, 31 Mar 2026 16:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774974235; cv=none; b=ppFUYeHlI1IU2ha29Q7NVGnL++O5nucZvp7iatubtdFA25V3G+rTE5s3j/V0godvzDPPfTmwPuDPLZj7oNoKvwEo+sfz2N8O276mntsnkU4oYZJfYx6OnCoB04gBqK2Xsrdu8hghe+hLYNa49+TD5PECv+Vc/3TLAoBmcEarcxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774974235; c=relaxed/simple;
	bh=Owy27NZIONsUdNTzktg4/3o+Iq30FcPIRoBuYypQxIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOmXgEk0y9ewbe/3jh/8DsfDqLycxrgi0zRLhwxRMkN3/YX7x8D54X55vGYYWKqEe57CvgsRNh90s0lvMdP9f8IVzuD9ioig7jwK1Y4+01WaI7LiDpyajGh2czWkuV7u643sWeIh/sPL6pPmgSuTSMVvZArSs3xUpzvLHcn1UIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hv/rzxlp; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774974234; x=1806510234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Owy27NZIONsUdNTzktg4/3o+Iq30FcPIRoBuYypQxIE=;
  b=hv/rzxlpta3zLX3NoDA10qIuuOQNPUuAVfkj91UXVkya11PIU7f71jyE
   Nntu9meFawdKVRQao/z4FehEGAunmREKnv59aWfGuJspVSK+MlvJ6Wikc
   fTmAdN8w24qzgB3mxg+ldkM5Z29BFCk183e94xC8eeIA/mARMlFH1eUt6
   UKIiu1QM6V/rIL+tascZyMKBg2gWjOdkDwRgq3rF2BszPb/UE96uC/8Pb
   OuiJchUrb9PzvTLcE8YWrICVOEDODw59zkiVuVLqcjlqpb+LyiF4ZNpW0
   X/1lMkXSqPSAhtxaFOlow7KTmmNtg2DO5pT2Z1BhewgBBUM7ZSZ5LSTic
   g==;
X-CSE-ConnectionGUID: pIZP2Qq8R6KktlaTckjLPA==
X-CSE-MsgGUID: NvwQuBrXQlCDYi27I+QAOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="87386939"
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="87386939"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 09:23:54 -0700
X-CSE-ConnectionGUID: cF1F+tt8QQ2ChLIXH7/5Aw==
X-CSE-MsgGUID: 1YpHvgX7QJugjkhEZ86q+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,152,1770624000"; 
   d="scan'208";a="230860100"
Received: from lkp-server01.sh.intel.com (HELO 283bf2e1b94a) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 31 Mar 2026 09:23:50 -0700
Received: from kbuild by 283bf2e1b94a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w7bsZ-000000002t3-2ihm;
	Tue, 31 Mar 2026 16:23:47 +0000
Date: Wed, 1 Apr 2026 00:23:21 +0800
From: kernel test robot <lkp@intel.com>
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
	netdev@vger.kernel.org, dave.jiang@intel.com,
	dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
Cc: oe-kbuild-all@lists.linux.dev, Alejandro Lucero <alucerop@amd.com>,
	Edward Cree <ecree.xilinx@gmail.com>
Subject: Re: [PATCH v25 09/11] sfc: obtain decoder and region if committed by
 firmware
Message-ID: <202604010036.h2OVjfQU-lkp@intel.com>
References: <20260330143827.1278677-10-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330143827.1278677-10-alejandro.lucero-palau@amd.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[lists.linux.dev,amd.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-273694-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Queue-Id: 8EBE936CA25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on 64584273dfb8a1e5fc7d78094ba22a93c204b44e]

url:    https://github.com/intel-lab-lkp/linux/commits/alejandro-lucero-palau-amd-com/sfc-add-cxl-support/20260331-055820
base:   64584273dfb8a1e5fc7d78094ba22a93c204b44e
patch link:    https://lore.kernel.org/r/20260330143827.1278677-10-alejandro.lucero-palau%40amd.com
patch subject: [PATCH v25 09/11] sfc: obtain decoder and region if committed by firmware
config: sparc-randconfig-002-20260331 (https://download.01.org/0day-ci/archive/20260401/202604010036.h2OVjfQU-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260401/202604010036.h2OVjfQU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604010036.h2OVjfQU-lkp@intel.com/

All errors (new ones prefixed by >>):

   sparc-linux-ld: drivers/net/ethernet/sfc/efx_cxl.o: in function `efx_cxl_init':
>> drivers/net/ethernet/sfc/efx_cxl.c:89:(.text+0x198): undefined reference to `cxl_get_region_range'
   sparc-linux-ld: drivers/net/ethernet/sfc/efx_cxl.o: in function `efx_cxl_exit':
>> drivers/net/ethernet/sfc/efx_cxl.c:120:(.text+0x234): undefined reference to `cxl_unregister_region'


vim +89 drivers/net/ethernet/sfc/efx_cxl.c

    16	
    17	int efx_cxl_init(struct efx_probe_data *probe_data)
    18	{
    19		struct efx_nic *efx = &probe_data->efx;
    20		struct pci_dev *pci_dev = efx->pci_dev;
    21		struct efx_cxl *cxl;
    22		struct range range;
    23		u16 dvsec;
    24		int rc;
    25	
    26		probe_data->cxl_pio_initialised = false;
    27	
    28		/* Is the device configured with and using CXL? */
    29		if (!pcie_is_cxl(pci_dev))
    30			return 0;
    31	
    32		dvsec = pci_find_dvsec_capability(pci_dev, PCI_VENDOR_ID_CXL,
    33						  PCI_DVSEC_CXL_DEVICE);
    34		if (!dvsec) {
    35			pci_info(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability not found\n");
    36			return 0;
    37		}
    38	
    39		pci_dbg(pci_dev, "CXL_DVSEC_PCIE_DEVICE capability found\n");
    40	
    41		/* Create a cxl_dev_state embedded in the cxl struct using cxl core api
    42		 * specifying no mbox available.
    43		 */
    44		cxl = devm_cxl_dev_state_create(&pci_dev->dev, CXL_DEVTYPE_DEVMEM,
    45						pci_dev->dev.id, dvsec, struct efx_cxl,
    46						cxlds, false);
    47	
    48		if (!cxl)
    49			return -ENOMEM;
    50	
    51		rc = cxl_pci_setup_regs(pci_dev, CXL_REGLOC_RBI_COMPONENT,
    52					&cxl->cxlds.reg_map);
    53		if (rc) {
    54			pci_err(pci_dev, "No component registers\n");
    55			return rc;
    56		}
    57	
    58		if (!cxl->cxlds.reg_map.component_map.hdm_decoder.valid) {
    59			pci_err(pci_dev, "Expected HDM component register not found\n");
    60			return -ENODEV;
    61		}
    62	
    63		if (!cxl->cxlds.reg_map.component_map.ras.valid) {
    64			pci_err(pci_dev, "Expected RAS component register not found\n");
    65			return -ENODEV;
    66		}
    67	
    68		/* Set media ready explicitly as there are neither mailbox for checking
    69		 * this state nor the CXL register involved, both not mandatory for
    70		 * type2.
    71		 */
    72		cxl->cxlds.media_ready = true;
    73	
    74		if (cxl_set_capacity(&cxl->cxlds, EFX_CTPIO_BUFFER_SIZE)) {
    75			pci_err(pci_dev, "dpa capacity setup failed\n");
    76			return -ENODEV;
    77		}
    78	
    79		cxl->cxlmd = devm_cxl_add_memdev(&cxl->cxlds, NULL);
    80		if (IS_ERR(cxl->cxlmd)) {
    81			pci_err(pci_dev, "CXL accel memdev creation failed");
    82			return PTR_ERR(cxl->cxlmd);
    83		}
    84	
    85		cxl->efx_region = cxl_get_region_from_committed_decoder(cxl->cxlmd);
    86		if (!cxl->efx_region)
    87			return -ENODEV;
    88	
  > 89		rc = cxl_get_region_range(cxl->efx_region, &range);
    90		if (rc) {
    91			pci_err(pci_dev,
    92				"CXL getting regions params from a committed decoder failed");
    93			return rc;
    94		}
    95	
    96		cxl->ctpio_cxl = ioremap(range.start, range_len(&range));
    97		if (!cxl->ctpio_cxl) {
    98			pci_err(pci_dev, "CXL ioremap region (%pra) failed", &range);
    99			return -ENOMEM;
   100		}
   101	
   102	
   103		probe_data->cxl = cxl;
   104	
   105		return 0;
   106	}
   107	
   108	void efx_cxl_exit(struct efx_probe_data *probe_data)
   109	{
   110		if (!probe_data->cxl)
   111			return;
   112	
   113		iounmap(probe_data->cxl->ctpio_cxl);
   114	
   115		/* If the sfc cxl initialization was successful, it implies the
   116		 * endpoint decoder had an auto discover region which is the one
   117		 * we used and we need to remove now. Otherwise the region will
   118		 * be around until the root port is removed.
   119		 */
 > 120		cxl_unregister_region(probe_data->cxl->efx_region);
   121	}
   122	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

