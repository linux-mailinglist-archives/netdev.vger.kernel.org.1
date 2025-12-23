Return-Path: <netdev+bounces-245863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D86D1CD96D1
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 14:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A17CC3011F8F
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 13:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D71FB33A03D;
	Tue, 23 Dec 2025 13:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FKZsI7lk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0512F616C;
	Tue, 23 Dec 2025 13:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766496204; cv=none; b=kOF36eq9gZNETa2Nu2csmGUL3mJilAE8BVAsmxbAWbVpzkPpfEYm1AGAixhCeqRR1Bjix7f83oYBpI65MAQw0zM1RabxHLUvWhGkaaHf/t+Yn9Gz73BfhcA7IPqHLpqmUEipSGKQkjtiCxyAJorL2CMjXqjGtVAtYCg+haDtgzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766496204; c=relaxed/simple;
	bh=rqjKymunayEwPeDVegrNhyGlPplhOK5dBWljWTlzY08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKtRdn6dMJ0DJ2gRGpql6G8D9Z+ClL84rHn1SKNoiNlTjHNifj6jhw1qKPyMh7ArF3owU9pxt96QsiTFLqUJBOdFqt1/lkKqqwtdlF0/46kiedkO76iKtj/ljXwGu/g518gnG7LNLmV2YFVHyEnBvxneHyNptSWF5unZaZc26Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FKZsI7lk; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766496203; x=1798032203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rqjKymunayEwPeDVegrNhyGlPplhOK5dBWljWTlzY08=;
  b=FKZsI7lkGCH5NYj4VvvWKMf5we/lJffbYCPubsPcLBxyh4f7VCIjkALs
   GlKLOFJb3tCalEuETYTf8VNj2y4rFO9pm1+MDBHInA3IVC0T6GARw6WjR
   g82pk7+YyIn8P5afI5d5HjHIuQKxpZLEi77eCVGVlaF0YLxoD0BmWSjBK
   In6chCSVYt7EY6PSC7QEo5AYdi9+ul+3S3AliXSo3HaYSG7szNoSlMJx5
   FbJxwjL8xhqiSVcyIm75wV/vkDBtQWaAlrKl2Jw8BPskdP0wnyF4xn31y
   cyvXRBRX8SmCjSIAa5SfOaRLZhmlaEdXvjcXGutbyh20fITw4CD2F6Bbe
   g==;
X-CSE-ConnectionGUID: HoTNlDT4RDG5kJqAnOjejg==
X-CSE-MsgGUID: HNMcfUP3Tyi72jdsUL96dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11651"; a="68226161"
X-IronPort-AV: E=Sophos;i="6.21,170,1763452800"; 
   d="scan'208";a="68226161"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2025 05:23:22 -0800
X-CSE-ConnectionGUID: MglQWePLRHij/XYMpZ4S+w==
X-CSE-MsgGUID: UiQRl1yoQZOfG/sl/2q93g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,170,1763452800"; 
   d="scan'208";a="199691760"
Received: from lkp-server02.sh.intel.com (HELO dd3453e2b682) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 23 Dec 2025 05:23:20 -0800
Received: from kbuild by dd3453e2b682 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vY2MA-000000001xf-2OQE;
	Tue, 23 Dec 2025 13:23:18 +0000
Date: Tue, 23 Dec 2025 21:22:28 +0800
From: kernel test robot <lkp@intel.com>
To: Osose Itua <osose.itua@savoirfairelinux.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, michael.hennerich@analog.com,
	jerome.oufella@savoirfairelinux.com,
	Osose Itua <osose.itua@savoirfairelinux.com>
Subject: Re: [PATCH v2 1/2] net: phy: adin: enable configuration of the LP
 Termination Register
Message-ID: <202512232150.85cDPKrJ-lkp@intel.com>
References: <20251222222210.3651577-2-osose.itua@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222222210.3651577-2-osose.itua@savoirfairelinux.com>

Hi Osose,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]
[also build test ERROR on net-next/main linus/master horms-ipvs/master v6.19-rc2 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Osose-Itua/net-phy-adin-enable-configuration-of-the-LP-Termination-Register/20251223-064926
base:   net/main
patch link:    https://lore.kernel.org/r/20251222222210.3651577-2-osose.itua%40savoirfairelinux.com
patch subject: [PATCH v2 1/2] net: phy: adin: enable configuration of the LP Termination Register
config: parisc-randconfig-001-20251223 (https://download.01.org/0day-ci/archive/20251223/202512232150.85cDPKrJ-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251223/202512232150.85cDPKrJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512232150.85cDPKrJ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/phy/adin.c:7:10: fatal error: cerrno: No such file or directory
    #include <cerrno>
             ^~~~~~~~
   compilation terminated.


vim +7 drivers/net/phy/adin.c

   > 7	#include <cerrno>
     8	#include <linux/kernel.h>
     9	#include <linux/bitfield.h>
    10	#include <linux/delay.h>
    11	#include <linux/errno.h>
    12	#include <linux/ethtool_netlink.h>
    13	#include <linux/init.h>
    14	#include <linux/module.h>
    15	#include <linux/mii.h>
    16	#include <linux/phy.h>
    17	#include <linux/property.h>
    18	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

