Return-Path: <netdev+bounces-148194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 547A29E0C33
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 20:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13157282A84
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 19:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8461DE4F0;
	Mon,  2 Dec 2024 19:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j6pq5RL7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F0F1DBB36;
	Mon,  2 Dec 2024 19:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733168051; cv=none; b=ttVff8DPK8ftE4TVJvEqLAjEnyYzUMV/kXxSFrXwGP6qCSb3WUvVrfNhvy9zd1TrovlD8yPPTJ8tcLVoujVHkJE3yHDJdN+Z5Wknv01kpzUXCJyhuXpsorqFRRwzAih4uCQPvc0DNxC7kFOwHmVLZbcQZaR3+GYKblH55moTIbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733168051; c=relaxed/simple;
	bh=telg62VhWEef+uUdzmCeDxEX7vUPIFuuccOnRTtC0os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KcOxc6MdE1A0xPeQQ8Mdhmv4QnKVw6QF1e6KhuRQOyXxLm/4PjiA88zj1YBjceqTvaOMeN11G5Uiw802qDx1e8iGdsTvQgAMkf7M7jwg3gxEjNefUdrRfhrxU3gJeZKYZE/D88zkJiboHK4/czM6+nXyp2DEvBdshFSMV+Pehv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j6pq5RL7; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733168049; x=1764704049;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=telg62VhWEef+uUdzmCeDxEX7vUPIFuuccOnRTtC0os=;
  b=j6pq5RL70BLh7KFnXGmVoUsdnet8GY6DjFpmHzQw9fXiixZqkb/Zt14O
   yGKeMXUCgkaKNQ4zJOOF0QSGnD2dX8+ZaF4njjmLznKYpkBen5jEVbcAP
   v4QiJn+b3q822WCmjfrKHpR1h9SxL9vuHbtvn0F+GbwffY0/1DEippADi
   zZCI6CCGjekRsJqi6v3DKJ9y5GBVxgBbNliBP/LSucQ+2gHgf1S0OaUHf
   oiWvTK90WvErPVYpcGjiV0uhqApKv2Fri5mU1w24W9A1F9FIVuBQsMwOr
   aFf9Ilq7swsseyB0nuHS2ZqdBCWz634To3TiJAizP+9KK50wxBOX0cUz9
   w==;
X-CSE-ConnectionGUID: K/g0wgVVRUuCXPZ3A06lQA==
X-CSE-MsgGUID: qUfo51mhQeebkyNt7HdS6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="37020386"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="37020386"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 11:34:08 -0800
X-CSE-ConnectionGUID: JQSLHB7FSmydvJ4sQy755g==
X-CSE-MsgGUID: T64WW8wCT0SC8tVEy7xLoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="93106533"
Received: from lkp-server02.sh.intel.com (HELO 36a1563c48ff) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 02 Dec 2024 11:34:07 -0800
Received: from kbuild by 36a1563c48ff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tICAr-0002oz-1b;
	Mon, 02 Dec 2024 19:33:45 +0000
Date: Tue, 3 Dec 2024 03:32:02 +0800
From: kernel test robot <lkp@intel.com>
To: alucerop@amd.com, linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
	dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
	nifan.cxl@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCHv3] cxl: avoid driver data for obtaining cxl_dev_state
 reference
Message-ID: <202412030337.aesRtC2T-lkp@intel.com>
References: <20241202130009.49021-1-alucerop@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202130009.49021-1-alucerop@amd.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on cxl/next]
[also build test ERROR on linus/master v6.13-rc1 next-20241128]
[cannot apply to cxl/pending horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/alucerop-amd-com/cxl-avoid-driver-data-for-obtaining-cxl_dev_state-reference/20241202-210705
base:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git next
patch link:    https://lore.kernel.org/r/20241202130009.49021-1-alucerop%40amd.com
patch subject: [PATCHv3] cxl: avoid driver data for obtaining cxl_dev_state reference
config: x86_64-buildonly-randconfig-005-20241203 (https://download.01.org/0day-ci/archive/20241203/202412030337.aesRtC2T-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241203/202412030337.aesRtC2T-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412030337.aesRtC2T-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/perf/../cxl/cxlpci.h:6,
                    from drivers/perf/cxl_pmu.c:23:
>> drivers/perf/../cxl/cxl.h:823:32: warning: 'struct cxl_dev_state' declared inside parameter list will not be visible outside of this definition or declaration
     823 | int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
         |                                ^~~~~~~~~~~~~
--
   In file included from drivers/cxl/cxlmem.h:12,
                    from drivers/cxl/mem.c:8:
>> drivers/cxl/cxl.h:823:32: warning: 'struct cxl_dev_state' declared inside parameter list will not be visible outside of this definition or declaration
     823 | int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
         |                                ^~~~~~~~~~~~~
--
   In file included from drivers/cxl/cxlmem.h:12,
                    from drivers/cxl/port.c:7:
>> drivers/cxl/cxl.h:823:32: warning: 'struct cxl_dev_state' declared inside parameter list will not be visible outside of this definition or declaration
     823 | int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
         |                                ^~~~~~~~~~~~~
   drivers/cxl/port.c: In function 'cxl_endpoint_port_probe':
>> drivers/cxl/port.c:101:34: error: passing argument 1 of 'cxl_dvsec_rr_decode' from incompatible pointer type [-Werror=incompatible-pointer-types]
     101 |         rc = cxl_dvsec_rr_decode(cxlds, &info);
         |                                  ^~~~~
         |                                  |
         |                                  struct cxl_dev_state *
   drivers/cxl/cxl.h:823:47: note: expected 'struct cxl_dev_state *' but argument is of type 'struct cxl_dev_state *'
     823 | int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
         |                         ~~~~~~~~~~~~~~~~~~~~~~^~~~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/cxl/cxlpci.h:6,
                    from drivers/cxl/core/pci.c:10:
>> drivers/cxl/cxl.h:823:32: warning: 'struct cxl_dev_state' declared inside parameter list will not be visible outside of this definition or declaration
     823 | int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
         |                                ^~~~~~~~~~~~~
>> drivers/cxl/core/pci.c:294:5: error: conflicting types for 'cxl_dvsec_rr_decode'; have 'int(struct cxl_dev_state *, struct cxl_endpoint_dvsec_info *)'
     294 | int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
         |     ^~~~~~~~~~~~~~~~~~~
   drivers/cxl/cxl.h:823:5: note: previous declaration of 'cxl_dvsec_rr_decode' with type 'int(struct cxl_dev_state *, struct cxl_endpoint_dvsec_info *)'
     823 | int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
         |     ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/linkage.h:7,
                    from include/linux/printk.h:8,
                    from include/asm-generic/bug.h:22,
                    from arch/x86/include/asm/bug.h:99,
                    from include/linux/bug.h:5,
                    from include/linux/io.h:12,
                    from include/linux/io-64-nonatomic-lo-hi.h:5,
                    from drivers/cxl/core/pci.c:4:
   drivers/cxl/core/pci.c:389:22: error: conflicting types for 'cxl_dvsec_rr_decode'; have 'int(struct cxl_dev_state *, struct cxl_endpoint_dvsec_info *)'
     389 | EXPORT_SYMBOL_NS_GPL(cxl_dvsec_rr_decode, CXL);
         |                      ^~~~~~~~~~~~~~~~~~~
   include/linux/export.h:56:28: note: in definition of macro '__EXPORT_SYMBOL'
      56 |         extern typeof(sym) sym;                                 \
         |                            ^~~
   drivers/cxl/core/pci.c:389:1: note: in expansion of macro 'EXPORT_SYMBOL_NS_GPL'
     389 | EXPORT_SYMBOL_NS_GPL(cxl_dvsec_rr_decode, CXL);
         | ^~~~~~~~~~~~~~~~~~~~
   drivers/cxl/cxl.h:823:5: note: previous declaration of 'cxl_dvsec_rr_decode' with type 'int(struct cxl_dev_state *, struct cxl_endpoint_dvsec_info *)'
     823 | int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
         |     ^~~~~~~~~~~~~~~~~~~


vim +/cxl_dvsec_rr_decode +101 drivers/cxl/port.c

    91	
    92	static int cxl_endpoint_port_probe(struct cxl_port *port)
    93	{
    94		struct cxl_endpoint_dvsec_info info = { .port = port };
    95		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
    96		struct cxl_dev_state *cxlds = cxlmd->cxlds;
    97		struct cxl_hdm *cxlhdm;
    98		struct cxl_port *root;
    99		int rc;
   100	
 > 101		rc = cxl_dvsec_rr_decode(cxlds, &info);
   102		if (rc < 0)
   103			return rc;
   104	
   105		cxlhdm = devm_cxl_setup_hdm(port, &info);
   106		if (IS_ERR(cxlhdm)) {
   107			if (PTR_ERR(cxlhdm) == -ENODEV)
   108				dev_err(&port->dev, "HDM decoder registers not found\n");
   109			return PTR_ERR(cxlhdm);
   110		}
   111	
   112		/* Cache the data early to ensure is_visible() works */
   113		read_cdat_data(port);
   114		cxl_endpoint_parse_cdat(port);
   115	
   116		get_device(&cxlmd->dev);
   117		rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
   118		if (rc)
   119			return rc;
   120	
   121		rc = cxl_hdm_decode_init(cxlds, cxlhdm, &info);
   122		if (rc)
   123			return rc;
   124	
   125		rc = devm_cxl_enumerate_decoders(cxlhdm, &info);
   126		if (rc)
   127			return rc;
   128	
   129		/*
   130		 * This can't fail in practice as CXL root exit unregisters all
   131		 * descendant ports and that in turn synchronizes with cxl_port_probe()
   132		 */
   133		struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
   134	
   135		root = &cxl_root->port;
   136	
   137		/*
   138		 * Now that all endpoint decoders are successfully enumerated, try to
   139		 * assemble regions from committed decoders
   140		 */
   141		device_for_each_child(&port->dev, root, discover_region);
   142	
   143		return 0;
   144	}
   145	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

