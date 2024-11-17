Return-Path: <netdev+bounces-145653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6799D0489
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 16:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83AB8B21A88
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 15:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE62C1D9694;
	Sun, 17 Nov 2024 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T0oRXDBe"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0124A1D89E5;
	Sun, 17 Nov 2024 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731857991; cv=none; b=YcoZEyPJbpaqn3//+Eh3u+28PWQR3/ghfa+phMVSiuGqApFqSJHaJyOpG39r620cRsM3VJTAHV7GRA1bKh+kw9WpQTqwegqeZUmCgEOZ0cw45mmOfNFUf21r+XCqSq5dB4EI6E012MbK9dWmzbg2M3GnRJT/pjs9LtBArUvTaw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731857991; c=relaxed/simple;
	bh=XmSeuzaftL/+vg3VZC9X4kbM8L1zfwEERGsn4yRkYaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gljltogfI8q/XoBEU5SnQFfycTFbOHx+6GS/oQyP1099VgXARmiVHt0AXmtjf95JRGh0cuPJPUAwA84LO+g3walQCdicHiYrheQzeHRbqeD3XHL7BCGFZP/FTS9erAVSFMUjpToZDw/xBiK5JP+TJBFpFClJ9G2QsCW9strpQpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T0oRXDBe; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731857991; x=1763393991;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XmSeuzaftL/+vg3VZC9X4kbM8L1zfwEERGsn4yRkYaQ=;
  b=T0oRXDBevZszsf+xh0EDtJ2NJ7JUQhbk4M9hefT26SXG3FHng2JMwbEL
   /Meb4eXzQ6Kb5H4Y6GBoQlShXSIXaC9JLfkBmDYbblpSTXNVP9nh1ye1i
   ens8Ymo6wshQszo1uzDvoPVpRx5JCptDh8rcKsQ6cVxBjLLnf1hPkuQ92
   0zUIOefU7p3rxt/26twboAW1c/So2jZCF4vc+1k83QzoHMOrjGNMBQvvl
   33pS1NY2WBJVBDAFrltwAXUsv+bBC9ALYk2p+kt1XhZSy487ACfBXBNoS
   Dda620nWPgoOJyYbXZAgxqpb7LwDORsHSUIpuwe9mSDBNeic2Egcy9n8y
   A==;
X-CSE-ConnectionGUID: VIaBye7kRY2UFBXS+SbFJA==
X-CSE-MsgGUID: o9yJg6qITAC1MXb3sCU+vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11259"; a="42337237"
X-IronPort-AV: E=Sophos;i="6.12,162,1728975600"; 
   d="scan'208";a="42337237"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2024 07:39:50 -0800
X-CSE-ConnectionGUID: spULzkbMQh6Qegr2EG1+AQ==
X-CSE-MsgGUID: FtyVDRl0Rzaf2+ZwPyceVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,162,1728975600"; 
   d="scan'208";a="89431213"
Received: from lkp-server01.sh.intel.com (HELO 1e3cc1889ffb) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 17 Nov 2024 07:39:45 -0800
Received: from kbuild by 1e3cc1889ffb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tChNH-0001pV-0J;
	Sun, 17 Nov 2024 15:39:43 +0000
Date: Sun, 17 Nov 2024 23:39:35 +0800
From: kernel test robot <lkp@intel.com>
To: admiyo@os.amperecomputing.com, Sudeep Holla <sudeep.holla@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jeremy Kerr <jk@codeconstruct.com.au>,
	Matt Johnston <matt@codeconstruct.com.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Huisong Li <lihuisong@huawei.com>
Subject: Re: [PATCH v7 1/2] mctp pcc: Check before sending MCTP PCC response
 ACK
Message-ID: <202411172322.HO4ycC00-lkp@intel.com>
References: <20241114024928.60004-2-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114024928.60004-2-admiyo@os.amperecomputing.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge linus/master v6.12-rc7 next-20241115]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/admiyo-os-amperecomputing-com/mctp-pcc-Check-before-sending-MCTP-PCC-response-ACK/20241114-105151
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20241114024928.60004-2-admiyo%40os.amperecomputing.com
patch subject: [PATCH v7 1/2] mctp pcc: Check before sending MCTP PCC response ACK
config: x86_64-randconfig-123-20241117 (https://download.01.org/0day-ci/archive/20241117/202411172322.HO4ycC00-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241117/202411172322.HO4ycC00-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411172322.HO4ycC00-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/mailbox/pcc.c:283:34: sparse: sparse: Using plain integer as NULL pointer
>> drivers/mailbox/pcc.c:296:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int * @@
   drivers/mailbox/pcc.c:296:27: sparse:     expected restricted __le32 const [usertype] *p
   drivers/mailbox/pcc.c:296:27: sparse:     got unsigned int *
   drivers/mailbox/pcc.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/slab.h, ...):
   include/linux/page-flags.h:237:46: sparse: sparse: self-comparison always evaluates to false
   include/linux/page-flags.h:237:46: sparse: sparse: self-comparison always evaluates to false

vim +283 drivers/mailbox/pcc.c

   272	
   273	static void check_and_ack(struct pcc_chan_info *pchan, struct mbox_chan *chan)
   274	{
   275		struct acpi_pcct_ext_pcc_shared_memory pcc_hdr;
   276	
   277		if (pchan->type != ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
   278			return;
   279		/* If the memory region has not been mapped, we cannot
   280		 * determine if we need to send the message, but we still
   281		 * need to set the cmd_update flag before returning.
   282		 */
 > 283		if (pchan->chan.shmem == 0) {
   284			pcc_chan_reg_read_modify_write(&pchan->cmd_update);
   285			return;
   286		}
   287		memcpy_fromio(&pcc_hdr, pchan->chan.shmem,
   288			      sizeof(struct acpi_pcct_ext_pcc_shared_memory));
   289		/*
   290		 * The PCC slave subspace channel needs to set the command complete bit
   291		 * after processing message. If the PCC_ACK_FLAG is set, it should also
   292		 * ring the doorbell.
   293		 *
   294		 * The PCC master subspace channel clears chan_in_use to free channel.
   295		 */
 > 296		if (le32_to_cpup(&pcc_hdr.flags) & PCC_ACK_FLAG_MASK)
   297			pcc_send_data(chan, NULL);
   298		else
   299			pcc_chan_reg_read_modify_write(&pchan->cmd_update);
   300	}
   301	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

