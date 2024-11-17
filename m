Return-Path: <netdev+bounces-145659-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 817D69D04FC
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 19:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107101F2191A
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 18:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E441DA103;
	Sun, 17 Nov 2024 18:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TPhU/tqX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC4318D63A
	for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 18:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731867915; cv=none; b=suur6t4c+00xyMs9LE/GNz8kFmy1IqpGRSxZqg4DJMY9wz18ThGG+a8MulzC508XbYWnXw8kOlQOK+bhkwnx5xmWaEcdrTcPOph4j6k3Hp6weq8q6a3YXoNONtVMfRDjUsIiKRtfJqHNdnXm5K79DLEAOJkboR5LOuruxBLbYSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731867915; c=relaxed/simple;
	bh=fUO/Mcch2IlFpIG/d7Pw77G+lV3sgt4gfxCX/DENw8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsV1zyNaLzETgt9+ts5cExSP+GEUWWiR6Y0zlDD2vcKIPGVkixu7xQB9KrUZ3pV7ZlQegF5KxniR4q9wXiIFY8IQGlzrZ/xWyOkyU7m3suQQDJQW0gozGQ231dvFtIG5vqS6yFRisZSsIkOVQYmrZH4cKUAUPKQcDnFAcUgCGuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TPhU/tqX; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731867914; x=1763403914;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fUO/Mcch2IlFpIG/d7Pw77G+lV3sgt4gfxCX/DENw8o=;
  b=TPhU/tqXEnYrpXGUR+DUbHrd8gWgWOI4NzpabniPktQ/xjxI4AwqOehL
   QBC41ndUopgc8AkWRBVv/a6qV4BzreCAkFbf7R7KENLKgZWzVXbzLuDNz
   6QAE2rQ+R6z/H1kRZhdYs8uUOsGg2vtVmnR4UbzR19a4uz/i0ylnoLiqy
   rT34xeBrxvDTSGKXDyVvMQ2OmePrGQnb7eP46sEWIe1rY/LEv2KuyVQ+Z
   P/ytSYzeNmrjQu27OuEPpZ/fVWgTR51jGGyhdnQQptgkmQAvELJ3aWeoP
   VfW1z0OMq1RxaYcxEgZYtEn6GQZKhxQau8XAT9mSxNw2lfOL34SNa/LDq
   g==;
X-CSE-ConnectionGUID: z0HG6TH5SsCmbZFSw6V7dA==
X-CSE-MsgGUID: KOf9AaEqTZSw0ExMzT1MZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="49348096"
X-IronPort-AV: E=Sophos;i="6.12,162,1728975600"; 
   d="scan'208";a="49348096"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2024 10:25:13 -0800
X-CSE-ConnectionGUID: t0gLHI5rSFOhAvWAqsPlqw==
X-CSE-MsgGUID: GHOkiEj7SVSiOBC+WCgSjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,162,1728975600"; 
   d="scan'208";a="89030071"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 17 Nov 2024 10:25:05 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tCjxG-0001zZ-2P;
	Sun, 17 Nov 2024 18:25:02 +0000
Date: Mon, 18 Nov 2024 02:24:58 +0800
From: kernel test robot <lkp@intel.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Julia Lawall <julia.lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Ofir Bitton <obitton@habana.ai>, Oded Gabbay <ogabbay@kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?unknown-8bit?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jeroen de Borst <jeroendb@google.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 12/21] scsi: pm8001: Convert timeouts to
 secs_to_jiffies()
Message-ID: <202411180252.N1NjfHcR-lkp@intel.com>
References: <20241115-converge-secs-to-jiffies-v2-12-911fb7595e79@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115-converge-secs-to-jiffies-v2-12-911fb7595e79@linux.microsoft.com>

Hi Easwar,

kernel test robot noticed the following build errors:

[auto build test ERROR on 2d5404caa8c7bb5c4e0435f94b28834ae5456623]

url:    https://github.com/intel-lab-lkp/linux/commits/Easwar-Hariharan/netfilter-conntrack-Cleanup-timeout-definitions/20241117-003530
base:   2d5404caa8c7bb5c4e0435f94b28834ae5456623
patch link:    https://lore.kernel.org/r/20241115-converge-secs-to-jiffies-v2-12-911fb7595e79%40linux.microsoft.com
patch subject: [PATCH v2 12/21] scsi: pm8001: Convert timeouts to secs_to_jiffies()
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20241118/202411180252.N1NjfHcR-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241118/202411180252.N1NjfHcR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411180252.N1NjfHcR-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/scsi/pm8001/pm8001_init.c:42:
   In file included from drivers/scsi/pm8001/pm8001_sas.h:50:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/scsi/pm8001/pm8001_init.c:737:5: error: call to undeclared function 'secs_to_jiffies'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     737 |                                 secs_to_jiffies(60)); // 1 min
         |                                 ^
   4 warnings and 1 error generated.


vim +/secs_to_jiffies +737 drivers/scsi/pm8001/pm8001_init.c

   665	
   666	/**
   667	 * pm8001_init_sas_add - initialize sas address
   668	 * @pm8001_ha: our ha struct.
   669	 *
   670	 * Currently we just set the fixed SAS address to our HBA, for manufacture,
   671	 * it should read from the EEPROM
   672	 */
   673	static int pm8001_init_sas_add(struct pm8001_hba_info *pm8001_ha)
   674	{
   675		DECLARE_COMPLETION_ONSTACK(completion);
   676		struct pm8001_ioctl_payload payload;
   677		unsigned long time_remaining;
   678		u8 sas_add[8];
   679		u16 deviceid;
   680		int rc;
   681		u8 i, j;
   682	
   683		if (!pm8001_read_wwn) {
   684			__be64 dev_sas_addr = cpu_to_be64(0x50010c600047f9d0ULL);
   685	
   686			for (i = 0; i < pm8001_ha->chip->n_phy; i++)
   687				memcpy(&pm8001_ha->phy[i].dev_sas_addr, &dev_sas_addr,
   688				       SAS_ADDR_SIZE);
   689			memcpy(pm8001_ha->sas_addr, &pm8001_ha->phy[0].dev_sas_addr,
   690			       SAS_ADDR_SIZE);
   691			return 0;
   692		}
   693	
   694		/*
   695		 * For new SPC controllers WWN is stored in flash vpd. For SPC/SPCve
   696		 * controllers WWN is stored in EEPROM. And for Older SPC WWN is stored
   697		 * in NVMD.
   698		 */
   699		if (PM8001_CHIP_DISP->fatal_errors(pm8001_ha)) {
   700			pm8001_dbg(pm8001_ha, FAIL, "controller is in fatal error state\n");
   701			return -EIO;
   702		}
   703	
   704		pci_read_config_word(pm8001_ha->pdev, PCI_DEVICE_ID, &deviceid);
   705		pm8001_ha->nvmd_completion = &completion;
   706	
   707		if (pm8001_ha->chip_id == chip_8001) {
   708			if (deviceid == 0x8081 || deviceid == 0x0042) {
   709				payload.minor_function = 4;
   710				payload.rd_length = 4096;
   711			} else {
   712				payload.minor_function = 0;
   713				payload.rd_length = 128;
   714			}
   715		} else if ((pm8001_ha->chip_id == chip_8070 ||
   716				pm8001_ha->chip_id == chip_8072) &&
   717				pm8001_ha->pdev->subsystem_vendor == PCI_VENDOR_ID_ATTO) {
   718			payload.minor_function = 4;
   719			payload.rd_length = 4096;
   720		} else {
   721			payload.minor_function = 1;
   722			payload.rd_length = 4096;
   723		}
   724		payload.offset = 0;
   725		payload.func_specific = kzalloc(payload.rd_length, GFP_KERNEL);
   726		if (!payload.func_specific) {
   727			pm8001_dbg(pm8001_ha, FAIL, "mem alloc fail\n");
   728			return -ENOMEM;
   729		}
   730		rc = PM8001_CHIP_DISP->get_nvmd_req(pm8001_ha, &payload);
   731		if (rc) {
   732			kfree(payload.func_specific);
   733			pm8001_dbg(pm8001_ha, FAIL, "nvmd failed\n");
   734			return -EIO;
   735		}
   736		time_remaining = wait_for_completion_timeout(&completion,
 > 737					secs_to_jiffies(60)); // 1 min
   738		if (!time_remaining) {
   739			kfree(payload.func_specific);
   740			pm8001_dbg(pm8001_ha, FAIL, "get_nvmd_req timeout\n");
   741			return -EIO;
   742		}
   743	
   744	
   745		for (i = 0, j = 0; i <= 7; i++, j++) {
   746			if (pm8001_ha->chip_id == chip_8001) {
   747				if (deviceid == 0x8081)
   748					pm8001_ha->sas_addr[j] =
   749						payload.func_specific[0x704 + i];
   750				else if (deviceid == 0x0042)
   751					pm8001_ha->sas_addr[j] =
   752						payload.func_specific[0x010 + i];
   753			} else if ((pm8001_ha->chip_id == chip_8070 ||
   754					pm8001_ha->chip_id == chip_8072) &&
   755					pm8001_ha->pdev->subsystem_vendor == PCI_VENDOR_ID_ATTO) {
   756				pm8001_ha->sas_addr[j] =
   757						payload.func_specific[0x010 + i];
   758			} else
   759				pm8001_ha->sas_addr[j] =
   760						payload.func_specific[0x804 + i];
   761		}
   762		memcpy(sas_add, pm8001_ha->sas_addr, SAS_ADDR_SIZE);
   763		for (i = 0; i < pm8001_ha->chip->n_phy; i++) {
   764			if (i && ((i % 4) == 0))
   765				sas_add[7] = sas_add[7] + 4;
   766			memcpy(&pm8001_ha->phy[i].dev_sas_addr,
   767				sas_add, SAS_ADDR_SIZE);
   768			pm8001_dbg(pm8001_ha, INIT, "phy %d sas_addr = %016llx\n", i,
   769				   pm8001_ha->phy[i].dev_sas_addr);
   770		}
   771		kfree(payload.func_specific);
   772	
   773		return 0;
   774	}
   775	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

