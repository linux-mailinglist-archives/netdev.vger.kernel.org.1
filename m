Return-Path: <netdev+bounces-287428-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEoAF+b7A2rKBgIAu9opvQ
	(envelope-from <netdev+bounces-287428-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 06:19:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC0F52D20A
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 06:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B26E8305B028
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 04:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7C436E47E;
	Wed, 13 May 2026 04:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EISLT9Ve"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25572D5436;
	Wed, 13 May 2026 04:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778645987; cv=none; b=HWIi8BWy8R4+01lJf/MwtemBpN2NviL2k7rE/FfH+umJi5AeHBInDIcnHKa3NduYVLgVMqcTBP6LLtbBd5rfpZG1CnD4Sb3icgGaG+4bm1YSnLj2XtCAqGwRz1GzX749biFw4bKFCSuntipK9f+axwSCLEsWutwZ22s+vAcT/yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778645987; c=relaxed/simple;
	bh=/nSFQ2/8daCssLI1ptOVAQPaTh12fuEua1jAKxHxKZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFeLustw2tlCGJhVOKTx+q3yRbD0T17RQG4+Ijd3mizoUy8MVjTUdlYGJxzzkD0sTLq81M4UFaPGEXtfIFug/upIO+2V7IULZJrqaDX55V9l0UyQnF0hzkTPjYoDA3bJpbAEVBLU04RedQ0B/y43tlKd5E7tPNHLuxC1sRH9/os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EISLT9Ve; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778645985; x=1810181985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/nSFQ2/8daCssLI1ptOVAQPaTh12fuEua1jAKxHxKZw=;
  b=EISLT9VeVWc5O1YT8x7deljAni7VhL3o5yYxS/LP6gh/aQ6pTVn+DIxJ
   yCxre/K+p33SY/m54tASYeUlTNGjdBSXryCoBnlJirXLf5/a5kDCCEA5f
   HYiO9uUEtnsPhHTCf4Dbb+KVyr9j7ELeT8jjxweJ3bF8GA+TXyWs1a85Y
   I3VVV0sn2klFnTWYbwt+cEZ/SN56WXI0N1vTifEPfymlo0XiPS5ZN5vpo
   zVoFWQd30IH5q/EGiwM/nFeCU+nDN4jWhrRQ+nBe45M/8jFPB/Whd1JXd
   BgQ2rpRCeD3Nmriumb9xajvCPexPD7MtHZOrtDWMfjD+K2p6OnlN8YckI
   w==;
X-CSE-ConnectionGUID: fjJxU4aJRUe8G66CZ1MNPQ==
X-CSE-MsgGUID: xln78hRWTpGE/FmgjUYlxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79743060"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="79743060"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 21:19:44 -0700
X-CSE-ConnectionGUID: d/4PRzmUQie3DPdgWsdSyQ==
X-CSE-MsgGUID: oO2nSQnXTtm/JFV7Fzzuaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="242318375"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 12 May 2026 21:19:42 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wN14M-000000003Pb-2eHO;
	Wed, 13 May 2026 04:19:38 +0000
Date: Wed, 13 May 2026 12:18:59 +0800
From: kernel test robot <lkp@intel.com>
To: faicker.mo@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, kuba@kernel.org,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: net_failover: Fix the deadlock in slave register
Message-ID: <202605131216.7sSRq0Gy-lkp@intel.com>
References: <20260507074332.2543229-1-faicker.mo@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260507074332.2543229-1-faicker.mo@gmail.com>
X-Rspamd-Queue-Id: 7BC0F52D20A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287428-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,01.org:url]
X-Rspamd-Action: no action

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]
[also build test ERROR on net/main linus/master v7.1-rc3 next-20260508]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/faicker-mo-gmail-com/net-net_failover-Fix-the-deadlock-in-slave-register/20260513-045805
base:   net-next/main
patch link:    https://lore.kernel.org/r/20260507074332.2543229-1-faicker.mo%40gmail.com
patch subject: [PATCH v3] net: net_failover: Fix the deadlock in slave register
config: i386-randconfig-141-20260513 (https://download.01.org/0day-ci/archive/20260513/202605131216.7sSRq0Gy-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
smatch: v0.5.0-9185-gbcc58b9c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260513/202605131216.7sSRq0Gy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605131216.7sSRq0Gy-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/core/failover.c: In function 'failover_existing_slave_register':
>> net/core/failover.c:225:25: error: implicit declaration of function 'netdev_lock_ops'; did you mean 'netdev_lock'? [-Wimplicit-function-declaration]
     225 |                         netdev_lock_ops(dev);
         |                         ^~~~~~~~~~~~~~~
         |                         netdev_lock
>> net/core/failover.c:227:25: error: implicit declaration of function 'netdev_unlock_ops'; did you mean 'netdev_unlock'? [-Wimplicit-function-declaration]
     227 |                         netdev_unlock_ops(dev);
         |                         ^~~~~~~~~~~~~~~~~
         |                         netdev_unlock


vim +225 net/core/failover.c

   213	
   214	static void
   215	failover_existing_slave_register(struct net_device *failover_dev)
   216	{
   217		struct net *net = dev_net(failover_dev);
   218		struct net_device *dev;
   219	
   220		rtnl_lock();
   221		for_each_netdev(net, dev) {
   222			if (netif_is_failover(dev))
   223				continue;
   224			if (ether_addr_equal(failover_dev->perm_addr, dev->perm_addr)) {
 > 225				netdev_lock_ops(dev);
   226				failover_slave_register(dev);
 > 227				netdev_unlock_ops(dev);
   228			}
   229		}
   230		rtnl_unlock();
   231	}
   232	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

